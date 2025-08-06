Return-Path: <linux-kernel+bounces-758015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FB3B1C9C6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C29B7227C3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C156129995A;
	Wed,  6 Aug 2025 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ursc7H1b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w8YyMCrK"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A0A293C67
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754497594; cv=fail; b=MyNotw1znAXQ5RdWCWDX0Pg3ItaYoOrIhksmlxu37TI4Wmd6yNIuwLM38tMpJAEW/mLHmk4QohIrO7MtsAAKdsTwHr3DlqL8FhmkA9PePr9lLFCE/s5mQzq4weHE6WCeBb12uMYAY7LYDQjUUY9/jE8BcDtRfYtfr8tUz0kiV6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754497594; c=relaxed/simple;
	bh=OQ5yoD8xce/oD+6cd17YGvCyYSp7e0Hy3Yf/lAZ49KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JuGOGEd0whonlF7RBSxoDZyBQC38dIL+/1jPIYBasSVoHWkLo9HfV7g6/MF7jYjhX2QTUTDwDGmt1s5dksAl6Q76ducz6aW3uNZsZT6HLmEWokSJX+WDmKyorZ5PJKhJiVudgcAvujnVSBBplhkxCjRbC9cNfcpWqH+KWYZlIB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ursc7H1b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w8YyMCrK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576CRSrZ011407;
	Wed, 6 Aug 2025 16:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=CB3DRRvq0WYZw6RJtn
	oaMTnJWrzV8Qu4Aq0zOTZ6kOQ=; b=Ursc7H1byGH+6UYGqJriN532vkdX0cs6vE
	h1RokeWATIB7YYD0sf/oE6FK8iP5kTkn8WpfmXA8f71NVqVTCZzdI10eB9uBCcTu
	yORC5P4lyTKuFZxoN68i+rn2zl0pC9YBAIrqfQc3tSp1eHRP4L1ADuqznRLln+Qr
	agypTUHpbMK952Vt0ZiBS0mj8DtRBUwFjR26m6iUwqmAr5WOooRljiQqAp9RoC4C
	bXBo9J3xEJ2cROSHb/yD76lFUBuhjKQLGG5iGPhPdp8/MZqJ1L2B5n21RiEitQOG
	VXxj8r+/VTtaO43Ub8ddgNnYKd00zG6m7XtVAxb9gP/ZwLiL59rg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvd25ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 16:26:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 576Fme2k032091;
	Wed, 6 Aug 2025 16:26:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwqrvv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 16:26:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jm3yXXI8pRkW02GF1I1PHhSCkWtYit9iRPAKGNek8/25ETd5ECtvQlq2dWjLWTE6DJuWZkXMtSc6qTgEh//tv0ffs9vhRkjYYgJQDAZEk173Jhm9y544wekWc4SnfZ4aQ+D1MObOxid4biC423RfEiA9kKJceRnwpa0S5ffBWUlTE220WRZdAFwvKdTBhnwMJ+gb6d7VH5HYAaF6ORC2KVYw9ASh1jddNfoC3TvpGMIh7Y7HNuTG3qDZzDc+RD/BcQLlpusVF26MhziNqso9shB2LLBjcdHB0zsc+IsK3o41wELaDDcH9CLs8wKu26pfqrIrI4LEPhod2tOX0EHmWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CB3DRRvq0WYZw6RJtnoaMTnJWrzV8Qu4Aq0zOTZ6kOQ=;
 b=DsZYocZEqTTj5Qmu8WV6+smRFmRAMIvJ5+hMDLKkv5vVPXMi4N7qFKWryVDEbEf1w/xdNluvVv1iAEz7G7vNV1guvG3t3ZiPi7pQtLXMuJqNMI4+bml2rD5cxSaGwJmxofDUUe/qSu4Amc3mK2cWanQErX97FmxbkeQ94I2S494h19WsHLEYMdzYxvVevPWNtzIf2LZav9toEvjeNKDZLiaVclb6IGrLqOpoVDQ26rkj7jMZhLlzs5wL8IyX5Y3Hp2z7hZpKVH2uLVXa3qPW3tsERotrFEXMYR9FRcv9whxVLAZQvAj1MBAAXjH2BGG4lSkL+Nv07taoaOS7KymErw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CB3DRRvq0WYZw6RJtnoaMTnJWrzV8Qu4Aq0zOTZ6kOQ=;
 b=w8YyMCrK2X4ZzDgHok7zCejACAPafyyl4DUTYOYV1N8MvFIeWqWsalw//hfjW3LVm/Tssy3jnhQIg5QYW0GRFXpEch5GVnmKJGTGbLpVBPiuaVt1Rrnchq1uGWLKm5gAbKpHs+jViHXvF+nbimPQ7ljflDfk3aPqZRw3rU1unDY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4624.namprd10.prod.outlook.com (2603:10b6:a03:2de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 16:26:14 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 16:26:14 +0000
Date: Wed, 6 Aug 2025 17:26:11 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: SeongJae Park <sj@kernel.org>
Cc: Baoquan He <bhe@redhat.com>, linux-mm@kvack.org, ryabinin.a.a@gmail.com,
        glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
        vincenzo.frascino@arm.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH 4/4] mm/kasan: make kasan=on|off take effect for all
 three modes
Message-ID: <9ca2790c-1214-47a0-abdc-212ee3ea5e18@lucifer.local>
References: <20250805062333.121553-5-bhe@redhat.com>
 <20250806052231.619715-1-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806052231.619715-1-sj@kernel.org>
X-ClientProxiedBy: AM0PR06CA0141.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::46) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4624:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f3a36c4-782c-4c91-a0f5-08ddd505f6a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tBge5PpSW92p11d25Yb4+Imhp4LA3PtVxoaFNpEuubKaHv0hY+zKC1HphCJs?=
 =?us-ascii?Q?4i1cN1oCoPpS2NTe5ie7dzVSB2zNia+IxjmM9xWAWFuefbpPYJmIhGnZrkO/?=
 =?us-ascii?Q?V78VzH3NmlkJhaGJtXHlnlKZiTKrXk2/SF4Qpf1cIIusSrfd4kle8n1BEnJa?=
 =?us-ascii?Q?+5j7nDp7EbLF0kMt84o3VkyuubCVAEZbcJLOoEimpRhCLPkz5im0A6+BhslR?=
 =?us-ascii?Q?tMLjUmfxo9P86KG5zBdW1roLe+DO8Xkg5f5YjGQo70pW0e7Sk57HNU4or54L?=
 =?us-ascii?Q?FHJGwCwI1SdabTtjsjpNAK7mZjQLOR+oAyrcutYsLJhwPL6YhBrvCIgRldIv?=
 =?us-ascii?Q?l4kv3eyJEuzGQOrmee/F3ZZn56mQNc9bwCUo3GCEqpUrCt69va+rFdVoaSDs?=
 =?us-ascii?Q?52MFFuBepyP83vTZNJvZbiu5CghbZ7JIMmlmju0Inct+CRw9QH/SOgU0DzyS?=
 =?us-ascii?Q?Fwg7GtfUV/i4UlN2iusftzp5ADIHLTpia1lb64hTgHk1tT10hbt486hW9+td?=
 =?us-ascii?Q?/VIiTbDof/2whAICjVcvY6JQg6yLl+fMYoPDKP3WkIfszeiOzc39/uqv2ZG4?=
 =?us-ascii?Q?5waqM9ertUxnTI1Q+MflsLQRokptWucpbicWNMLTZ6+PSZJdmfcqllndigQb?=
 =?us-ascii?Q?gSbTqlPQ8VK9hbNfqvYmltBgW5vavnotuQo57S/SVKk/y2aGUJmHrP6x84EW?=
 =?us-ascii?Q?gKP0Eh2Olvi6jMvybbGCSwzaYNCsDGiPsxc/FV7+PJZYMm30IZE+ReGmhaPl?=
 =?us-ascii?Q?32syR79oJwTrqJaDmNOQihs7ciWMJj+KhrxnEzBdg9hTvzC8IJPuaC9XdmPl?=
 =?us-ascii?Q?Xb+55cpYPdMVovnTiMDnLbBLYKFloBanFF8rEnBGfFcDvzWruMrDqI7XLW9P?=
 =?us-ascii?Q?mkGsMD65J8pSHjlw7WA75VtOrg0L2vZ1bDFrUbrbM/BwkZR4z73SKGL0wtY4?=
 =?us-ascii?Q?KBUfX0UaNtRyOsnr7IPdSlVvwBuaExH9Tm99lECMgB9mPoVc8biz+fn2Jy5W?=
 =?us-ascii?Q?/w2T2tsLupq26vFl+MIu5+0Wtmk023vANW3bCE0VDPZjqR/2aG0V63K0ybgp?=
 =?us-ascii?Q?D0A3fKyBREBLV47kaALlcTkNWIhWq3ZbgEf6veUZcysge4HMvo00/+pllokm?=
 =?us-ascii?Q?x0LOgDfB3+dJK3G6XhNgS+drcpgYdrap/lWkwSnv1xqMX2UbZcVtcS+HKV/+?=
 =?us-ascii?Q?HpzJYBkeURs4KJnYtkeKAOnyOxEtmBELry4oAs9FRUdLqsaw0gz8wd+YJPh1?=
 =?us-ascii?Q?ac35pByUXRDGTBt3HsyeXiyIBNznYQ9MsKIkSKlFzRUmvEubCUKq2bAxhujv?=
 =?us-ascii?Q?s20J3jC6HOKMcEu8FgGFyVVo3GNSgCUS6uWpDpwedKFyuqW9tyx69p5WxCiI?=
 =?us-ascii?Q?yI/+pwI0P2UwZ7femN8Hbmo6I+L/qVX4k2QLm5Dwg3bKXtKq/ruT4YDXPK8M?=
 =?us-ascii?Q?o0GTChYREWQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Id95/rEslsCdoAIYt3yuSGpnAV0MgVNzERhIJnorfUnfzfDztalU+nREsRr6?=
 =?us-ascii?Q?djibZl3+OhIK6qUuBpgoGN9yT0CHymjcwLeagdOjwbLpLWNkEKrmf1dXKhVX?=
 =?us-ascii?Q?WyiSXmrEtXXGgjkerEtCiZNdostzQAJdAbH2H18yE27YtdUflCM1yA1CmOSV?=
 =?us-ascii?Q?21xWtmnhW63hrL1FDmgsgBfnBJshYz1Jk8FdEcKw0jUqrhhecPUzbMkevqN3?=
 =?us-ascii?Q?lFVTyWa2HcX4RG3sRNWoIFPtwqrDwt5Vb5dUnsLM0BM61tklC6zvPpf6mA7l?=
 =?us-ascii?Q?8urHAiAoSIzssTDVIn2zdP8LVg0oszwXsYTLTg4XOqW7CTRWUgUSzBNWF35G?=
 =?us-ascii?Q?Lbz28KLYKCsqEvzZocZUl0ZP+bf5E7ICWuVMk2/XJYM8dsJAbZ+kfFqjgH8D?=
 =?us-ascii?Q?AsoGWKmTlJJjk/aEp4xJSFUu/cSbsacKvtTSpxGxM8nzvDcPMuDx3LAHRkP6?=
 =?us-ascii?Q?UGf0rW+tSKBKUzPIu6qVJIpM1GMAJQ8vDh/PQH2yZWKl6nuXh1zl/Z/Tbq4s?=
 =?us-ascii?Q?gXfD7/lqZE3oPXBY8fygcxj5LEMm67Ry8Hz9cjcPhguJiN/w++j0vMskyUZG?=
 =?us-ascii?Q?+0RcqmiOv0iAXBptweKZVx2zidUwzx8h/2w4uswpI5signiLTiQLSme1UtIx?=
 =?us-ascii?Q?jV9QlBwf+CuTwwEm+8IseK53OG0/ib5YFOGgi7BPIRyTRk8dL0SEY2Ou9Umd?=
 =?us-ascii?Q?T9G9l49q4VkaJtUWz42EnqqsOpRqtFEa0m9tsQj3p0dWL8og8A8SHEqpYuae?=
 =?us-ascii?Q?rmueXoliq0MRbLKx5282tJEUvprcPGyy77o3/Q49R1YLe5GcuRfa9Emk3TUo?=
 =?us-ascii?Q?nMqoBLv2sXfl7HkNRot1Gy7fWrpxxk5R7i5AbPx/yslql0MzLIl4fE0BsDMO?=
 =?us-ascii?Q?YEgWj4BMA71FcqtTSjBPOykbeMAvj9cm4jSOYO+N97Aar3aTjmXry/5rfq/6?=
 =?us-ascii?Q?HIRbExg3faW4IYWC+XDH8s4oTjlB7pxM9xdnZeZosTgysDYfQ7fMnqwXF9Ar?=
 =?us-ascii?Q?R0cWdRwAX9q2htfk91dL7AuhsjszqdX8waxvAdSz2Cnkyovf2IZwrmZ8V1cK?=
 =?us-ascii?Q?iXbkF1OFoHZRpzzKbLq9knrquwk+Mdc+XPqU1EBsncK7pFw+6KPQYKQsertA?=
 =?us-ascii?Q?xg0hONx5NhW7adJ1lXE0mq3wYAOSfEDppJdgO+eB6H+MK3rW5vhVQS3mkGtF?=
 =?us-ascii?Q?F5A0gqPH6x4e0aT8tX7A35N/XoURSa4E1z2gnMGeaM0ag2PSaYCoNoQEK8mN?=
 =?us-ascii?Q?JXUk7ZjpCcwm3tePDx6Bd7k2YIcN52VpeJjsvSiXBN4fwJpv7MFvwCHqdiN3?=
 =?us-ascii?Q?MUlljqCo+xJ7sKFiCQRL+fzqu5RT/8VogT8ZyNRsw1H+QIUTrWK5dVAR9BUr?=
 =?us-ascii?Q?/khcBTL+FEZZyTBLGIJTJrMnjg5zb7z5YfeHIrPNgAy9x3NGjXnUCtSqLNYK?=
 =?us-ascii?Q?XsoZGXDhSwl812zJSz5xO9gTSlD96sgrOHGTVjWk14fuMrz294LT5/UyJu+G?=
 =?us-ascii?Q?YlUgrs4B7YKlb7SVLL/D3UOJSFDtFjBYvD+8y0JPtkUzIjNq1zy3lMx4A/CS?=
 =?us-ascii?Q?CPqxaKqZ11um/FqJ9ngEfxeGco+oIJZSpmHOv9LWbNnTChZhJoayuB0erIHI?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h76Pn4S9xXgO6n2P9YuCqLpeOizllFSCwtE5mZ4dvoMF+kPGyC72GyYg2yTW0VgaE4QTsdPdMh0WRBwoQQFz96BVCU2R/bWyJZEHH4XW50bNf8b2x5nf3kw4DgENfft70+FQkao8Fsp43HZOFZ1CCGCPchwhY3Aq/Ih9bfwZIvu4vGArMUvPtkY2yKie/vbx4ZMntKGVC9E94L8Mpkd+9reCvXD+18EjhxsVnqnDKFz+ECom3ctjcqS+oMsvQ52jbr8GqGSRKy+qCeMdOsv9IBjrMZuFYW+1lLxWyl6X3+5j/aO3FI7ZPDitELaVy3qQg0KiednJxAhARRcGE+xqRUD5wQx2HX1APvF5hpEOWrTm+UhYK9Fu6yJjnbgWZ8mzUgyaXaRd48ECfb0WkVtTr9ulO3PG4YAEaKyH1TexS4+fFLTBeV/1v1Kx2aDO945zkelr/2oWT6PilTvrVV0szVHGFp6hnVnXVIcJWH+gmsRuEpalA7akfb0W35sttUblbySDjZ399KcfWUCtx6NfGjb4cASWokgIhSE6g4eJuaQ9eZ4pYWIklp8YkWSEZA0yp01aPNYhHwb9N1yicknfNkYQ7i/Z+sG7KGKf1uJWsZc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3a36c4-782c-4c91-a0f5-08ddd505f6a9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 16:26:14.8019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aovKUaDiyUfn8VXF6zFOG00PpNOsyPaANvTThDHxl6IaqUCyfE1z1KeyJlHpuxBYytJkVIXT296y4GMYOAezlBWwv5o/BptL0OAHFfuJqZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4624
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508060104
X-Authority-Analysis: v=2.4 cv=fYaty1QF c=1 sm=1 tr=0 ts=68938229 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=drpxK5Sr0r6PeNfVfTEA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: K4i3LfeUPhF_YeTrkIEVoGyc6RjZNKGk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDEwNCBTYWx0ZWRfX1AQWM+IHoKGb
 ramUCgExUGIELWydClJC+UNG06WmWAUFFHcwiPXGXKS7+8t1WQ4LutP6S6DW8PCrGaKhtJDFOlG
 9cb1T8pQ95hAb/ecLfk31rcgWtsmsgVebPBRslAGBdVdg4Hrq1XgAtluctnnuUvcWRYtZXG0hzU
 CHxC6CoWLGihu73S2UOqda9qfmoNSrXYrKZW0cAS+m28KkTUm4vyVci30xbohZ8sdr+4UBTsIK7
 FOJLU3MLqijZkKcapejsUfQoprFcdCEktnh4DgsTTj36YxlSjJsiUQpDyOeidHFVNT7M1oTOQyT
 IDBmP0TIGEC1X03xMVZY4F2PXQ2k0SANETZRLe+5+qx9JswVBfyT7TQA6kDVSaYf8GNoSx1KNH5
 XwewumQLjKu06Rdq7NyUhxVXY/z9Jxm6cj4tnafk0VeIBPRBjs/mCvaGShLgKHX70BHzZ4la
X-Proofpoint-GUID: K4i3LfeUPhF_YeTrkIEVoGyc6RjZNKGk

On Tue, Aug 05, 2025 at 10:22:31PM -0700, SeongJae Park wrote:
> Hello Baoqua,
>
> On Tue,  5 Aug 2025 14:23:33 +0800 Baoquan He <bhe@redhat.com> wrote:
>
> > Now everything is ready, set kasan=off can disable kasan for all
> > three modes.
> >
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  include/linux/kasan-enabled.h | 11 +----------
> >  1 file changed, 1 insertion(+), 10 deletions(-)
> >
> > diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
> > index 32f2d19f599f..b5857e15ef14 100644
> > --- a/include/linux/kasan-enabled.h
> > +++ b/include/linux/kasan-enabled.h
> > @@ -8,30 +8,21 @@ extern bool kasan_arg_disabled;
> >
> >  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
> >
> > -#ifdef CONFIG_KASAN_HW_TAGS
> > -
> >  static __always_inline bool kasan_enabled(void)
> >  {
> >  	return static_branch_likely(&kasan_flag_enabled);
> >  }
>
> I found mm-new build fails when CONFIG_KASAN is unset as below, and 'git
> bisect' points this patch.

Yup just hit this + bisected here.

>
>       LD      .tmp_vmlinux1
>     ld: lib/stackdepot.o:(__jump_table+0x8): undefined reference to `kasan_flag_enabled'
>
> Since kasna_flag_enabled is defined in mm/kasan/common.c, I confirmed diff like
> below fixes this.  I think it may not be a correct fix though, since I didn't
> read this patchset thoroughly.
>
> diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
> index b5857e15ef14..a53d112b1020 100644
> --- a/include/linux/kasan-enabled.h
> +++ b/include/linux/kasan-enabled.h
> @@ -8,11 +8,22 @@ extern bool kasan_arg_disabled;
>
>  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
>
> +#ifdef CONFIG_KASAN
> +

Shouldn't we put this above the static key declaration?

Feels like the whole header should be included really.

>  static __always_inline bool kasan_enabled(void)
>  {
>  	return static_branch_likely(&kasan_flag_enabled);
>  }
>
> +#else /* CONFIG_KASAN */
> +
> +static inline bool kasan_enabled(void)
> +{
> +	return false;
> +}
> +
> +#endif
> +
>  #ifdef CONFIG_KASAN_HW_TAGS
>  static inline bool kasan_hw_tags_enabled(void)
>  {
>
>
> [...]
>
> Thanks,
> SJ
>

Cheers, Lorenzo

