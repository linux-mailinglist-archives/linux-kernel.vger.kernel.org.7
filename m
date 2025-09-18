Return-Path: <linux-kernel+bounces-764015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C11B21CDF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F9D680ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA4B311C38;
	Tue, 12 Aug 2025 05:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aGdkjgT0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xSiE7Kgo"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3651DB92A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754976786; cv=fail; b=QBBCqBAB5jk2QF1j4sCX+QbpwmEltkVL5quoaDbOx87lESfHl6Hq3yL0Gdhk0Tbn7EcM9cLotL+8df47EF7ykwmfOvWKC7JHjQ1FR20TGIdHt5+BgrQDfg6x7cVnJjtFh3RX6ZtInTvBla3BeqEo1LO5I7ldwvNlWWyCSOml4CY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754976786; c=relaxed/simple;
	bh=7v80AgqE951onaVr0Kq3uSPtGunfumpP4x/hDWqX8kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uYRe7A3seJnXovcTOEDwmEgRjJtR/saqEls8XV25EY7v1ERbYcXBdZbWZeOk5MkP+prgy2d0FMNxOg8pjfmYZPDPJRmsE4bKqTvfI9Ys4Cs+jo78leLS7LLgYZIyW7BEsPXuarsVvyR2z2oyLEApQwpNx/t5GdQQQU/VTmE/haQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aGdkjgT0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xSiE7Kgo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C0u682026579;
	Tue, 12 Aug 2025 05:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=qqeeZ8ABLD1sneYb2q
	zOhPxWlkD3ZZ5psEx54VVLkds=; b=aGdkjgT0CI0mpIZZDlrqOcHUiSVgrIaY7j
	XbxpA1Tj34raF448q/a/uSLmTiWWYqnNgNh2mEcjH2KXys6taORjAJVvtmmKdZfz
	glHqHbeN6WIaS1OMoGntoiu7tsLajGeCPtJMiYTLm9/Bnu0k2QWwDZNvaiqCMWTc
	XyLjCsCMeaZ0xJBvV/G/2yGp4szbM6y+5YEjDfUxyDsfYoF/II4AwFb7RRSPbILK
	clL/8WD/QMFPH2YxsLNg7Qtz5rKti/ZqePhxI9Lp6c+Eju3ysnV4V28n0ZL55Y3r
	ecEW6TVoS4RhjNHCATznyVzJfGVOXnq6ZijlwIHbrZptPGnc9XHQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw8ebxaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 05:32:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57C4TvwK009640;
	Tue, 12 Aug 2025 05:32:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsftecp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 05:32:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVFx8J9QxdekZxVNpzVshUr8Tz/WwJtm3PfceXjeE+NbpsA+DbZI4RQrBTVDpJYWYCsuz6o44RZcIF3DI6bbeo79C5qNY/kudL9G+oMTV/I6B/1VoXZ9gon6AWcY9OiOnAIQPtzlnBK3bawzEaXzU+Znncni4Gqc26uxa8CIqNHOfLywU8XjozUvkRh/CFerwNBTflx+fqzly2c3z7zoOJHEUAV/1UYZOU+kjkhqC056Q+arYsJaGk9ghJxWrUgiXRkLdD5JUP/0zLTSdmAIdMemkQ7L8Cb8lUrViUZmw73KZIh7oVeNa0hz/0/jTQa7As2RLb7p3ZpYUMM4QXbYQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqeeZ8ABLD1sneYb2qzOhPxWlkD3ZZ5psEx54VVLkds=;
 b=ZMKvTyNfCG8NrxGYDOw4Y1dKdw74ElXhNpioccfYfBGoJwUvmGPG8WpIuWTNLi2s5xtbVyjSJS+SVRdUBs7pIBzETBSZKrtVz1yq2hJhxUAi2dgyD3l78YfZR8aVi9zsesipKp6eZAtIz8TqxOsHiZLtVUibrJYHOLQrtvdtQqTHxMFBOR9Y6UW7Sah8xbw61anyWmkn2sKedUdL6LSMX7gHxUJVFx93JLFwMtuk5bexhOWZfhctQALsnKwOTfPqzrC8W33pbcXCtb+e2uBULt0Gef289/liC62wq1RqQAODhzCrNnA45UaY3YaDpUrnSMTltwgNWHq81zhgT7r00w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqeeZ8ABLD1sneYb2qzOhPxWlkD3ZZ5psEx54VVLkds=;
 b=xSiE7Kgosw63mv+flqPy5fG971/ungekpgkqYC0irNZhmjPajni+j2SeEioWSk0HhVPxX3BCZc3qSmfJ7hCsZ/Oshe1y09S7hl4roykstTVTFz3teUpCiDnJ6UUtnMGbQVcg3heam780idTROrWYiqS8iPkkvKegHDtkZ1Antbw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MN6PR10MB8047.namprd10.prod.outlook.com (2603:10b6:208:4f2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Tue, 12 Aug
 2025 05:32:36 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 05:32:36 +0000
Date: Tue, 12 Aug 2025 06:32:33 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.17 0/3] mm/mremap: allow multi-VMA move for huge folio,
 find ineligible earlier
Message-ID: <7644f347-f010-4c48-b830-e88a05953967@lucifer.local>
References: <cover.1754218667.git.lorenzo.stoakes@oracle.com>
 <20250811210158.3241454a858582a7600e62e6@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811210158.3241454a858582a7600e62e6@linux-foundation.org>
X-ClientProxiedBy: GV3P280CA0004.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MN6PR10MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: 28aab409-acb6-419e-a78c-08ddd961a555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yL+J+YvNLawsMLtASjXz3a05ohBp4ZtTyQFNV7IrBztwxqhc64JvOGfPv174?=
 =?us-ascii?Q?9qgFliNN+kBgJLidqVqTzO8piZgx8DxSxJKevyTGNumhkXxAi3UQ1c/yEkIg?=
 =?us-ascii?Q?bip2IJR64vB+ZBX0YLhQj5CiUxgx/3wPkAzSQPA9h1BWx1eujDO5ifQ9tzOX?=
 =?us-ascii?Q?PrcnscKxymtDsgR7oVDDnrvzciu+24VylJyM9ogGrjo9XdrvgkHGpsV/dPUY?=
 =?us-ascii?Q?BNlRUoSQ4zEMdkYFr9BlMW8lmMhM0El9eSla9J9FnnlLnLylD5jeHilhDIuK?=
 =?us-ascii?Q?g2qMUkYX1ZnYwzV8Jr19ya2cMisdpAijTF3pwgvaEHYrhLA4ficqRQtRRLjj?=
 =?us-ascii?Q?gshKdeIcQPsRsLa6+A/PRkoNlEoC1HaYaSbFqPVzRwL3W6ICTMNu5UUYm1YN?=
 =?us-ascii?Q?FvJpNskCHh2Nd0o55BrenVM5RgNZIAN6WXV+XOdhKgVFG7GtNsA6+IzLWFV9?=
 =?us-ascii?Q?RPEQAl41dsZyFdnF6uaMSF4EB5nq6GT0k1acRLtr2EIiLg8+fUejDQpVC+rp?=
 =?us-ascii?Q?UbZFllPBPgUxlt+WL15rMTT00paN1xlqO7l0IlMr0v/31DndwgXgMkjAl8jp?=
 =?us-ascii?Q?dTfR+mIPjixc/bbC30DQ+WtBbeTZFg6Z5Imu05NApNzj/uhXpN5REC3OUNmM?=
 =?us-ascii?Q?JhKReqQfSidiYPWId+PkUW+6FewWypLOTpLCEDvjzYdBUI7dw+TWQW9fHvk5?=
 =?us-ascii?Q?0QLrpIpbMX9y9hRhBCKm8YmhMrbKtZdpL09tDAReh69gL1hRYcFmhsCy6xiZ?=
 =?us-ascii?Q?pz/hbmyg5TRHKBUdrAdlzFhYSrJRPQvWFiaXteJEiH22/3LQKGweCJUocZ9M?=
 =?us-ascii?Q?eR8ijVi+9JXWcSXPlRFryz/F3gVVyFhAggl1DbhZPkSow9Lel1BmA4Szgl2i?=
 =?us-ascii?Q?fuLtlqAk10RDjK+Q07AIJHtzF0OUwajppvtJb7O4qrTbXbqbu94lkUSKuK5O?=
 =?us-ascii?Q?4wXNisPelc0pt0rbE4qelajqpBG0ZqrBGm9jfiHwq8kzCpICZQjS/ukRyKGf?=
 =?us-ascii?Q?Nw5tU+kbm/FbbO1BfyMcZWyopElFfknjmkVl990oojsjPmNuuN8K+qCpW2Hr?=
 =?us-ascii?Q?doV/6W822G7stFjoQ2ZLG5owyubvDoa3nc0nt64nhQrbigideOX4o8SarD/U?=
 =?us-ascii?Q?FdGEnFXSlS0QeVLRHmORn/mthtYfLR8KtV0G580pIwNiqgtc3TnOHSwr0jrC?=
 =?us-ascii?Q?gqsgLnaSYPaW/REZVp7M2ebiS7pJKOyQw5mcDVXvL/3LO6Eq+wznqWKwxTKa?=
 =?us-ascii?Q?0X7Z4avA7w7PrIjj2UpGBvPanF68TilyWL3zxS4Csssknd2eNjf3kN0blx5k?=
 =?us-ascii?Q?E1elpVYjx7+WFLqBkO1vYMP/b3pCMLxQkNT7vxEzofDbzXr2aR8Im7lKLtpu?=
 =?us-ascii?Q?YxkszaX7Ks5bTnd+MpqiSYG+6Re0enwTFgQh1IBsgFE4vMhVCWiT68vAIT8j?=
 =?us-ascii?Q?OVIF5whu+ds=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k6KJqPcY8Th9a+wa8EIBfCTxYTDpO5bFMukVOyR1e65kCwUgrXlxdi+7fjZO?=
 =?us-ascii?Q?dUMZGgImnTxoO0GZjqcPHEm6o3Mxs1LVYN/TjeC+SjNxpo6wLq9+hg+cR4jm?=
 =?us-ascii?Q?1QmP2xDyp3rjm7Y0vhuWDIVM/pNHylVLz+llwirxzszE770i/LWx1W5zzyj+?=
 =?us-ascii?Q?pNb2bTUecThNbd8WdKv57EKQKWgQeqMQ+NFG/slxPl6XRdbITsgacB3bTVyu?=
 =?us-ascii?Q?o3KobjAinkc9m9kK2EP/36cb0ziQrLH/WDqXshh0+0/iDpt8uu8L4Yy7/pFH?=
 =?us-ascii?Q?YLl5zD6f5rUJjoKCLAmTlD6gsFUbY4Q+J4GBfKNYW2LPLEBPW7zWAnIAySlC?=
 =?us-ascii?Q?JMiy4n1xOv3sWaYbCfhhW708MjW5HoN3+efJ1P4qu5K+NcMIeElarHJZ1/RI?=
 =?us-ascii?Q?ZaRp6GHFWfnVOhRtkpE7izfG5hhVwwLCF2fLq5+i7mJ06DC/vVWYxPahiiR8?=
 =?us-ascii?Q?fKCFfOl0KaL/ah3Q1AVzc1Q0FC7kjJa4Gh8gN7DFvUYAx1jOVqtOVeL1LVWA?=
 =?us-ascii?Q?a8gjuRE5qB1Y0YAhuj9HPUCYB1xTn2UKCDzwQ52Bsiz/g6qrQ1dvJn16zONX?=
 =?us-ascii?Q?srdlnFe0/9cbopxlAKA6psV8mYQgUDCZzwMv52frMIPVoSWquPt+dSJApQxP?=
 =?us-ascii?Q?plHnS7LgN8F0fUafBwaqbA8M4+SZGrJI2RXi5EZ16mRX4PIWsRNmJhaTquxJ?=
 =?us-ascii?Q?gKa4ZXFJPtn/zuXBucEyF86Vsp2j8UvooxhGSG885d/p1oLYObiHzxO4hE4P?=
 =?us-ascii?Q?5M1IOmuTRjFxMnkEmB0DJmybCLvITEtI+Ex7j+nLjp9Fn/9dH2GHEBHDPMBn?=
 =?us-ascii?Q?fB7tO5LzcpXhZ246yvzZyEXwQAF1UJvBjw+HYO6YExpO2u1fhKfI4F0FqiIf?=
 =?us-ascii?Q?CukJrR6xeBa6V0xaBaMmQCJSC4aTPsXqhtpS3a0Qhpmg+ec2lnXDIA+mJjnB?=
 =?us-ascii?Q?dDZ7dmaC2birs5ENH0CmmXwGcEy/nydQo9raKiKczbTOn6ThrhETllb7/ZyR?=
 =?us-ascii?Q?OUi6b8EgQtO+fEASHsogY4Rj0ErmE3Y5p/mO6K58h/WX6/4DZfAfiC5CdeXv?=
 =?us-ascii?Q?ubNVCHBj5sA30Y5FVE2F1x4wyIG+/18bTFfrdVPb7TKL+yx66n5wDvXJt5w5?=
 =?us-ascii?Q?u9EfyJC4PS8OTMEH3+waLfiukfLW7uyVfJ2MuyYsC5KHGTmYQaNlBypOFJnV?=
 =?us-ascii?Q?Fpr+7++8MmyGYjBif/DtX1Z86oD0gd0qcqDBpRx2oI5n8fYeuZ9Uair77u9P?=
 =?us-ascii?Q?Nyz16m4aYRUdO5VxzRcnl6frQiZTZAwjcMPXWXQi0V8vqsy53lZLAlGyEIjK?=
 =?us-ascii?Q?Hly0UNoNMJ8wjPClzAKlnOvFWTGjZnyYgKPws2Bn8jbfnY48dKhoq+ECB+ul?=
 =?us-ascii?Q?dZMMIvbfOCOUou8FtvMrPdIlLj0PYi/Yw/2v4r0eZnkpeXaA1AmfxY/lymNl?=
 =?us-ascii?Q?7LaC3tNn3XDC/1S645moHnj0Gr05eTcn2rziakXiAsqg6WNGY9YkzrWx3o9n?=
 =?us-ascii?Q?lN3E88hnQUVpNw6pcWpZYlzupZuuYdDaZPxW2BgDhzcuuuDA3AAA/iBedZag?=
 =?us-ascii?Q?myvGJTvNbqGo4tWwBKwif4WXivZ0HGDSCO2jCbWzTwE0raRRN3ACAek5k2+v?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gmssg0Pmt2uIaPOQ7VU/bCUyNteitdeMYjTFD+1VYbqdzSa6+1/1hrF8/rw4JPZooPmp3rkyTYH8d+VPz2TCwD6yJwM0Todo5S15qtun3rBKpLG1hsn9jQceVzBXjEV5x92olP6byFeGrq1N4DaHn0XC40FOyloCs/S1pTEJFwaYMbfbafEOwxGFmL7pHI3xmCmBUoS8crQO9dVunfbd76S9E78vACqzrhHKBzCmm3PYg3BJ2qmo2qy7Dgi6nR+CTF2X1XCQJ6ClduiR/hngDtgzsLDZrAHeH+nsoOB1hKvSGezhTI/I7YewnczbQdJtE+T7+9v06qRfIa5/Jpb6t81gtXElNo2nSj/xIIr0azRxBccFpB609XmHJjZWMq1+/w3B6uUkf74OeAfwg+eaWIjD733bHQfz59KdcwRCw9HqBf5kkxOIs6txjGWFjxUpsDuVNdtLmSU3UKFDQ9Sdclv+2l6hO7hwydd7xsJLMJLOvUlfj/E95h9O1GBIbugGApdbzLiKpd0iZUmPb4JtLvKfVuRtfumG7etF3nXTdlf7dihxv1UVJxWnMgJOVFO7NSQW/utkSmqvicGrnp9FOj7ctCfLwZx48Z5sFhi/Ye8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28aab409-acb6-419e-a78c-08ddd961a555
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 05:32:36.6143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJtUJX200I6y2u1Gt9thO4bDBG4/GiZ4XdwT+DBaVMkCX3OzR7cWV/Xg/NKK/N2mO1M2qMqHT1ujiRDCsJGUVPOGe1EWKmQ/m5RXzOOBo7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8047
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508120049
X-Proofpoint-GUID: okZg8TmI3y7JRmbzVBsBGfkZpbJFG5rr
X-Proofpoint-ORIG-GUID: okZg8TmI3y7JRmbzVBsBGfkZpbJFG5rr
X-Authority-Analysis: v=2.4 cv=ePQTjGp1 c=1 sm=1 tr=0 ts=689ad1f8 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=rQSo2A6WyBV5h-wPDKwA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDA0OSBTYWx0ZWRfX23tdr+GByagt
 6hpiovetIK7GOhNpE4D7SA/6uqPNNtS+66t3yt/Aicf7GI0KkHvFHMFYXm04KZyB+KfTv5+upZo
 cCchV8u4CYvnYz8EangVvv3hRhRiRAN9ETMIq39L5aZ9Yi5qdzR/BfQAjbmC0S7AQ+kBBxhtfRV
 P6FuoeCJB4yhqe3Y7TM7Qw/I/PgfAw/cNqxC6zs2DKxHuAO+7MGroTARTGk6l4O4gdO75mcRiTA
 7IGyo3RhU+Iss7Zia0SfBBXUvzscfSKKre8EePOHGjjZOmd6Q5h8P0/V7LB5ptgtqAeoaTzsde9
 8Uxzau/nWmYQYaJruqU09mDgKGmsx9FltKbdoXOUSNI7OlaJfCEktZLIu1wyBPGqif0LlDPe5uQ
 50v1XMjqgrT2DYS0y+zw0utTISyCaDw7xdMA0G21v0ONaCtIsRgPDP89/4dWmQlUGlxxethV

On Mon, Aug 11, 2025 at 09:01:58PM -0700, Andrew Morton wrote:
> On Sun,  3 Aug 2025 12:11:20 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > Subject: [PATCH 6.17 0/3] mm/mremap: allow multi-VMA move for huge folio, find ineligible earlier
>
> I missed this series until just now, because the Subject: innovation
> fooled me.
>
> My pattern recognizer saw "[PATCH 6.17 ..." and said "that's an LTS
> patch".  Because that's precisely what they do.  By the million.
>
> I can't say I find this change valuable, really.
>
> Now wondering which other patches I missed.

Yes sorry, just wanted to highlight it as hotfix and it seemed sensible (at the
time)...

