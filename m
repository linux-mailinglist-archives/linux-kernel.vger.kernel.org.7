Return-Path: <linux-kernel+bounces-805680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C4EB48C3E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636443B9E29
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8672922F77B;
	Mon,  8 Sep 2025 11:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EjrOe7fL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zEezdWrJ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E220519343B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 11:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757331182; cv=fail; b=Mf8mos0xLsTtT6DJrZ5Hw5C/wGDI1MtalSNORw2WyNKCD+me6wOz9dpzvssZLp05c3ntHCIMFgtbSSEBEQDWsg414cOFtS9MAQOT4AamaS/mi1w64Cbh7twXhlrezwmKhLidZ/t3/1oeCbL3DuP9ZTtEWoSdRwyHdFiatjQgb2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757331182; c=relaxed/simple;
	bh=MPv6eO3uHlRAzMR4WnHM7Ze9G7YDUnKXcegOjiowXp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ucUf+XNMxju2JufJMQ8usXnXx4Xty2+mbC9RPpLBmnhXEL8diVYxHIUdQXfNZYpEcNFW/BsgTs5isDDI8BV4zp8xSyZOfU7bWMnhBNjoTbZaCE5Z/KNJWzITwk6k4kfGVxfVIQw3fFUEPQjjPDTx++JnjCLn9J2pxBZfxXxRqeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EjrOe7fL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zEezdWrJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5889icAQ000817;
	Mon, 8 Sep 2025 11:32:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=MPv6eO3uHlRAzMR4Wn
	HM7Ze9G7YDUnKXcegOjiowXp8=; b=EjrOe7fL0SK3adwBZTT+OJu+scE8OqFYqK
	DlLqnSgGiXTN4pe8u3w9nn8xytgzq4GAewBTWnwR0oiXn/VvUxmCdH+8V11oB/c6
	jTkA6vCsOpMyPG9bbHYOqyW1otY5N/rI12opgvfOTdaMrJWfSWKX0aASp44fLrFH
	+DICr2uVMzy6W+ABrvETosI0QTo0QhLMLlVTkxx6DdKDqgLTi6LSwDhRqdiIuwkM
	r21ET+7euYA4ueVZgs042LgB5DKi3djrraU+aX7Y1cPcg+3jPRHIRt8DSW4KU2UV
	1Qj74VV07d+GPC27pgahVt4VFzOTqHU7HnsLnOW/l/5uz0WbWfvA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 491vsc0636-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 11:32:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588AkCw0025934;
	Mon, 8 Sep 2025 11:32:43 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bd829c4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 11:32:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DcMV52GQ3t4hncJyx++83c7AgeVvRK/MuSjSqK6N9JWYngP+a78nrZvGvak4CIAFEGuLg3MmorxsxU8rJN7LwI9ne9OaA53qzUTxvsucOnfKc4nolTT9BC6MMjrt4ckl9YAYQFrfJbcrt6jjUwuCzuLkpNPKaHhciTx/Kr2WhXB/pl5VP17WZClmGGXgVgx+rBLl/5DtqulSUl7Pj0WTGG0c3yuxFzy12lxqn4fLoWQCvOVKs/FzV0d+jQSznE6MRfCO6GPjM2bPLzpkCdivvOuhyemOLmsbAEMV84DVeL/28fa1TmGB4bhVDFNhXsLY7c9bkbJN/LWcLsmP6razzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPv6eO3uHlRAzMR4WnHM7Ze9G7YDUnKXcegOjiowXp8=;
 b=Oc8Cf6+OtornIWePatJKJlLPuIHfUJCXSXifXjvDEnpZI0X+7CFX/SllkE3Aeo2zl9xqpxBsnPtFLIXIkOdaCoMPVq0xWU7ctd4E1aLAPmS0n5kIBkhHtY3i0C5FVUGt231vxKCz4fCG6KjW+y2ebtl9VWVHXVWKLm3e9xRkigbmjLFV+iYHJXUF7WRUCE0HbFQIQtt3sqq6Lo1vvSbXMlp4SZQuNFCLUcTnyvoihjKwi1D6b6gFThh0x6ouOGXpex7NPtGO9FY5bQwMANzR69Q7mZeMtydlz8p0ibNOtS1wsDIcRU5pnnz0oX6uVoh+mdQqStHEKBaJeDniiZSMSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPv6eO3uHlRAzMR4WnHM7Ze9G7YDUnKXcegOjiowXp8=;
 b=zEezdWrJtR/F7sa6A7qX25zrldvG6KFHks3CsCdRMDyHrIh9dbMy42NtOh4bFoqUanH1BzKXMGAkAANYAOe+AH5hfzdSq+MgiEJF7f0tpqyJ+RovhTBRqDxvVMwA3FNUYKBwRczOsxZo8WJugX4mrxB4skLF/z8t1uV3VWk0ON0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CO1PR10MB4529.namprd10.prod.outlook.com (2603:10b6:303:96::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 11:32:40 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 11:32:40 +0000
Date: Mon, 8 Sep 2025 12:32:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Usama Arif <usamaarif642@gmail.com>
Subject: Re: [PATCH v1] mm/huge_memory: fix shrinking of all-zero THPs with
 max_ptes_none default
Message-ID: <beda2005-f83f-42d4-8769-e719ece50866@lucifer.local>
References: <20250905141137.3529867-1-david@redhat.com>
 <0cd87ad4-206c-4367-b7e8-9c1ccddc15c7@lucifer.local>
 <ebb2a888-a111-4c27-925e-58bfa8e07852@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebb2a888-a111-4c27-925e-58bfa8e07852@redhat.com>
X-ClientProxiedBy: GVYP280CA0030.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CO1PR10MB4529:EE_
X-MS-Office365-Filtering-Correlation-Id: 086f583b-d193-407b-5ee6-08ddeecb6b8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZyqTviIOit2J9WpH78EMvgAlsx8Bmlmpc+C4IlfTpQ8sIbGeKtzSsZjmEERI?=
 =?us-ascii?Q?ZeH1JoejORCDINjOSLscN0FyRh1tlz0dXPQtmcumkmPpTKBzpxYNn6lv4pNR?=
 =?us-ascii?Q?P8PkqMTrXFKtKgsvH/FyneSBhGFAqHcnB4julTavetX2cxedXlKh9ugX2eVD?=
 =?us-ascii?Q?/ScmtaScyLv1om+y7HpME07FCm6DuHC/MMCXgeWF91ghpFZjpUSgZe63MzdC?=
 =?us-ascii?Q?pGN2ZNyBVHNHpJeFO1eZEo11KO5fmz4uY4oeVVwly/1rALiZsSWTiW4EQC/w?=
 =?us-ascii?Q?GW1BwHQ781mK967Ee0p4kl1cm4XsLun+iUaPWE26T0bductumtRuZm47xJqS?=
 =?us-ascii?Q?OLDBlDOrslZdoPPzip5eApSLZ8MyXR79x+Rcqxss+sqDnHR9gyuK9s5bUUkp?=
 =?us-ascii?Q?+vnuxhR52jVw1OpMXcEnUHeIDYuC8SGzr9A045oyRJqHTXJjnmkPpe2Ph8n2?=
 =?us-ascii?Q?anDOsoVo0L1y8CZuQACM1F2ujHf3OjmynTJTMC6i17zbMdmxOypVJ/UXDCdf?=
 =?us-ascii?Q?pZp7Jvtiyl8X/zcFeH9AkTAE9+inah4VMJLUK6mxNEUQi8kzhl+Y6/Wg0DuW?=
 =?us-ascii?Q?gJuDzTLi2h2qK5wnEUcX/MinWBygFaNU2oM3oqdQg5IpmA0mnxdhp6i0ZLC9?=
 =?us-ascii?Q?x0W8tCTKBHG8R+DwOeC9K2ZITgdpxOT9kQfmCB23Md+8obXXXaY9pTeA+dGF?=
 =?us-ascii?Q?zfA6VNk3LY/S+vifa9KqyCrmzAlFxugwOcsfai8Gn5nWRvSaF+4EzbrOlvrI?=
 =?us-ascii?Q?4doWOoRqJtjDlQ/zrpccbTRcxYDawxy0BiJGoIwJuXfiNwUV/EZpD+vmIbro?=
 =?us-ascii?Q?aCSoqOAmp5XSAbkEu1HSKlAkEyhdy8aiXAZsgwnJT86nUZUdRryqyfMglMds?=
 =?us-ascii?Q?PZm2MfLmqyy28KWhXKhbRLSTMhCLeDE6Hww5myOsnJPvJ13E1d2MS2IwSDzb?=
 =?us-ascii?Q?s3Bg94JXmpnmnF00VF48yYvCyiDv7ir8hYhqNhito0GzxQMLwPs+qZRpkq4i?=
 =?us-ascii?Q?UTv97o8UjimikBF6LM9sMipV8tDJj5Ybssvc9Dkr88+ml7vCF4NHIMxBIfFJ?=
 =?us-ascii?Q?q65T+mudcZb2xyQjKWnH06sojdEa0h236EHW8L9MN34uWSTm7s91wuHuq+3z?=
 =?us-ascii?Q?yvttEkG6m9hYAQXYVgZNOVyarUQ5fHXSOpvNv/B1HFfnbb0w9vTQVd19aTgD?=
 =?us-ascii?Q?Zu+DNpvk0cqq32oR89OSph9c5K9YuCKOoox7hzaoRSaFw433TeY/lTpIJWAX?=
 =?us-ascii?Q?21F9rRLgngJawAbRVZ+oWq+MemZqMNqvEXDgc3KvLVJtn4LBWig2xPPNUfKD?=
 =?us-ascii?Q?uZJrVb8t7oFPe8T5W63YVDB4TWyNPN8BxfuT2aXDpJZSjQuQZUG35XdkWFmB?=
 =?us-ascii?Q?LO7HFaHPRIP/FHoVO4OJPMRTh7bs7HO0p3e/MnkQlIYRJS49Dg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ec0s+m385c3KIjnIyqhneExctjTwW1tjEHtQsMT0/NxkMP6JXB/8rxAIKJyW?=
 =?us-ascii?Q?3H2bx+m5o62F5b2GoG7rXqRAlGALacNDhgsitnqvQiCJ2W66Pjl9icJideq1?=
 =?us-ascii?Q?rEpmddJd+XI73anvpzod4fM+F/jMeZnScjIiKyNgPiysOQij06ic6FdQVxTL?=
 =?us-ascii?Q?S42yYbI4EvE0kumTw5Al5RgcdkypoaFRFIXedk5j0+x7zEtl3+SlYyvC97px?=
 =?us-ascii?Q?Gj18H8i0U6wjQT//sLJnDWOiQ6bZsuaBkuT3nh3LWiYP/fXCTsvK4L6diJQG?=
 =?us-ascii?Q?qXeHf2maFFm+lKswxXU0ODlGbj7H4Hdf6Fqa1hUBdQxxK4ja+49jbKRxFiac?=
 =?us-ascii?Q?18JGq/k/h0FiOAq/dXZKqGtUn5XhCMiyIhKX/5egWzulWdhG2RpHqw6uhx/S?=
 =?us-ascii?Q?4wwOg1c0aKvtjLvQQqxOPInVvo2kEvv+wlCMa43mY+b1KpltkGlzYBpmJgVm?=
 =?us-ascii?Q?iuvYrt+Br2l8ZRpM2DR3xm9/63JvkXAYz4g94PKUo8qXGRkgt7H3+J89IXpk?=
 =?us-ascii?Q?kHLYS+qcJ5h6RPSwNCYSvcI5AbzbOzJXcJINDfeFegl0qjTnib6SFl4Qdtmf?=
 =?us-ascii?Q?8VMU09R7LbZ6IdJhc9KrhApmEG9FPlyffpepffnTl7ri2RQkImBNp8+qneza?=
 =?us-ascii?Q?sbl5G07hz9/fRMuyDOTYoCgzjMXfiA0JogMBHTwXNa7ijfkC97tR2aoECoyd?=
 =?us-ascii?Q?BdTAr2ZhJd75LTajMN/8/jYdd9QBm7NUByAJPDV0jTZ5lV5mXDe/VR61ugEk?=
 =?us-ascii?Q?zCJCKUjeMr7hDeimHndNbic6Yo11oivIPcV84T+YjGamGrNe11tElfYqgVnT?=
 =?us-ascii?Q?S4idpnlO5J6ZfdrSopqWmXzZl00l5/OMcLY8O4d65H+pOJ96koO7+F6GJTtn?=
 =?us-ascii?Q?IM5+MdBhDsdhrDeeoc/cwAayQ6GWFn7g1Ss92JeNAa5azo+rkWFN8+skli19?=
 =?us-ascii?Q?nTId5nISk/icgp14xQZLTnfPfNb8+p7JWscfo5JuTQy4FwYpPNwMz4uGXcNX?=
 =?us-ascii?Q?JxmlVjk1AVYYwQwAuz+zz18MNoKmOfG7n3K+TNaJ6VaS4KSNIkcBJFChesDY?=
 =?us-ascii?Q?MlvMPr8dmKzwJ7gCCbDCN1lOPz4JT02I3q7AgayKo2DWI+xTmCaWEp2VssCc?=
 =?us-ascii?Q?+4xcIM9MEOt657ADwN10tYu3bz9Yvltmh34nEUQ2oRzEEv0kdqsRAeYySJVD?=
 =?us-ascii?Q?jbQeK2x3Q16dV+Ak88PDo4DJN+Xnc04lafDX0lQXnzIz3as6BUpNIIdetIqF?=
 =?us-ascii?Q?reB2r3U/ZQ3ZNLx0z58+9f/7QOWEgqrCuQomaU0HutvRs3eMCAIsvbFCTtO+?=
 =?us-ascii?Q?BrUitLWH1Tw7k9HcP9KnB/Cy8R1syJBnhxHmTSqfjEoW2F4FC6nCjVRJ63Yx?=
 =?us-ascii?Q?OF5+DW4PJFfHygrEymb//yZ3UmxmPYkt0pPaBDP7VnSi4ckfPd0WdP4+N7Kb?=
 =?us-ascii?Q?qzocnwuEDUYrylLN/8s0xQTGBTvbq004V4e+HHNsLtwZ83isGu/ImsKLzzru?=
 =?us-ascii?Q?kvvRe0USoyRHoDQVF4x9J6RhuzlIaYnm4Zk7T7N0xcWEP3vRaIKZFNVknuwm?=
 =?us-ascii?Q?wufxZJpxxVlKMFZ/5f0JFiHnIaunzZ3OKczknM3vbNUDWWr7KKltROclJVuA?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UJuuURgBm8CrebRcMgDtktJg9fEyINsRe6XK84NIBfVRLGUFsfy9bHuha0BE396ANLM+/VnjLudGIIOs6MRxtZcbR9o5Qrm/uP034k6w+JGdGz5Kiicz3TBoPvkHSzEsHHmjRiKX9C7Wl9UI9uG4X80kUnXKxUq0FVF6Mw7URavOH/YHH8DOhbpvzMYxfz/UiYT6YuHj8K+J29HXogGDWdFJRcb+OF2CnHp1PWnfjweH0CQeK8ipJVYR6zfsKXz0jgxj/Oct72gKvk63gJinyj1++HUbyqtVfld9hnbEUtbBqQFBImxO2B8+FbQJu6i0SJaIfCNCHG8WbnecDSYEqT3hd6DZ84x7X14oWZYt7LJhyWqesjd+/0JeVIqVK1if0txBgIko9zydFmPjdDrP+UI5WsI7H60qZVY8HVBwGqOmwIVCwBSQJgN2zEAZ8dGiloKoyeEWfZ2qmz5+mju2SF+bg7x3U9YAGyjeDOL22dgvjL2+EMtKxGE8F8krrHLYt+AWkhQ6uxqdlYsqrZhcCCT5brHMPrHowDq+bX7465oIWk7LEHM3Skch1Jcsl2eSPsQ+5ROajJTul6ho7lAiiE5rmB8XAFTMSbtPOn5d4Js=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086f583b-d193-407b-5ee6-08ddeecb6b8b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:32:40.8319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GleUwCTxOjUQluv0aTNLuJtSmy/g/L2ZV5aqfO1JdBNqZCur8dOnIu5YiBya1fgAWf5+ZmBtoEuFXPHtOppsvw45XS5RioMJFNB+MxsB3YI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4529
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=958
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080115
X-Proofpoint-GUID: Aj10iKvbDRDzGqwF8ATtG36qGtQSqOrX
X-Proofpoint-ORIG-GUID: Aj10iKvbDRDzGqwF8ATtG36qGtQSqOrX
X-Authority-Analysis: v=2.4 cv=JvDxrN4C c=1 sm=1 tr=0 ts=68bebedb b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=Cx3iVUDafaUIWpQ5tBcA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13602
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA5OSBTYWx0ZWRfXytRWf8GoXDdX
 BVPXEOZVDsNA29jItqCskJBCOKaZ7EwgUktoEUAeNEIdlUv7bVnLZA2Z26QaxuVwin69zEaQdye
 sqQTwv3JXl3b2iRjyW+eMRdvjWj5kkAhKW4Xk4vHlqa8rhhSi1kHTOAzQrNrBWm7rscwwsJGzJv
 HtQMRKkd6VjMNQTHxKSQUUTsgeeAYGz2Uehp1zC1kdrYtnUQndJDZeHS/9fNPqQ0fbE5XWjyudw
 jMLyNLKKdGCZIMRYcsxRSu8QEGOs4sHqIzxiD0xmGH3hiHBvAW2h80MHqRZuRBfvj3gyMTnPhMi
 C3JUpMQMZEA0VSnt8XvajbPwgUhw7tFAjpoGWQD0TwMOUA4lBQTNsQI9FnTfn9cBITjlnKblF5p
 O9GsY/qYVe6NDKi45a0k9BqoXDxpMQ==

On Fri, Sep 05, 2025 at 05:36:01PM +0200, David Hildenbrand wrote:
> On 05.09.25 17:30, Lorenzo Stoakes wrote:
> > On Fri, Sep 05, 2025 at 04:11:37PM +0200, David Hildenbrand wrote:
> > > We added an early exit in thp_underused(), probably to avoid scanning
> > > pages when there is no chance for success.
> > >
> > > However, assume we have max_ptes_none = 511 (default).
> > >
> > > Nothing should stop us from freeing all pages part of a THP that
> >
> > Freeing 'all pages which are part of a THP' rather?
>
> I'm German, I don't know what I'm doing. :D

Whereas I have no excuse :P

>
> >
> > > is completely zero (512) and khugepaged will for sure not try to
> >
> > that is -> that are?
>
> the THP is zero?

I mean "all pages part of a THP that is completely zero' -> "all pages part of a
THP that are completely zero', I'm referring to the 'all pages' bit, but I guess
you mean the THP is entirely zero.

So maybe rephrase to 'all pages which are part of a zero THP' or similar? :)

>
> >
> > > instantiate a THP in that case (512 shared zeropages).
> >
> > But if you write faulted they're not the zero page? And how are they shared? I
> > mean be being dumb here.
>
> The shrinker will replace zeroed pages by the shared zeropages.

Ah thanks, I was being dumb :) too stuck in vanilla mm land...

>
> >
> > >
> > > This can just trivially happen if someone writes a single 0 byte into a
> > > PMD area, or of course, when data ends up being zero later.
> > >
> > > So let's remove that early exit.
> > >
> > > Do we want to CC stable? Hm, not sure. Probably not urgent.
> >
> > Surely this is worth having?
>
> Alrighty, let me cc stable.

Thanks!

>
> >
> > >
> > > Note that, as default, the THP shrinker is active
> > > (/sys/kernel/mm/transparent_hugepage/shrink_underused = 1), and all
> > > THPs are added to the deferred split lists. However, with the
> > > max_ptes_none default we would never scan them. We would not do that. If
> >
> > Nit but 'we would not do that' is kinda duplicative here :)
>
> Yeah, fixed it already while rewriting: this was meant to be "would now".

Cheers!

>
>
> Thanks!
>
>
> --
> Cheers
>
> David / dhildenb
>

Cheers, Lorenzo

