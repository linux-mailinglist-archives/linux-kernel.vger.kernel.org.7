Return-Path: <linux-kernel+bounces-735403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE061B08ED5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29BD016DA6E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27112F6F90;
	Thu, 17 Jul 2025 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="APwBFofV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ik/4YChY"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0481DE4E1
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752761264; cv=fail; b=A9dfuTnPSo0bYjns3J0wywnPTa9qKQXGQM3XOTOhtn8bhpfQ5zCCqcUeUUSVra/Hxf+pYS9BgQpXxYhMG5pZIa9X8qpqkIiXPZlusi/hhrii/LUhiy/MHnEvSWXjo4QZcgn7g6WyjfQe5RnsuXVj4xUiQL+ljYmJI5eTtqwi5aQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752761264; c=relaxed/simple;
	bh=6VWqgFCtLwMXq9Z1tTKk4dfqJiYD/ZnQGPt+qFpvc6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r5iadYIprxSKnvS5aVukN3KzK5BjfxY6ZsybmBphmLSi+xSuddtS01r1ggDU2DBfLX7jGOBWBcRpL/RWqoBL/NPWXWZ/0ATO9DDtWzSUsFL5Jc5fUCodYcG3gYcYx7YUNp4E5pVxENOr1RKorKYduRJ6WWzaR01+w7OqxmcLeGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=APwBFofV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ik/4YChY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H7fnpi002949;
	Thu, 17 Jul 2025 14:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=9V5g0lX6fXA7wS3XYf
	9wd+I82HYGfpjdxwekm5m90H0=; b=APwBFofVaaxMXDt16RC3r6ZVe2bPAmI3mm
	X+v9MS9F6peZW7O7Ymhj0u61K/ocm0+mNc791/hSMVXq5sxWdGZGKINfxkM2nOne
	z9I+DmBPBfXqjqir+EeINT6n2vFBckvVv7ExxLubflXwZQj7P0KNrZ9v2OI7ymbq
	z5gPHSKBJb44yg1QVWtRrXH1ukT4THdrGjKcr1/YNniRCwKz9Lb0UoWgY4sXDv6N
	0fr3E+wwPVDwMuz0rzYyZ45fcFjjWPd7qDdw8fzUrCdvcgrydX86xI2swogo+tWt
	B1ntz/Anpxccznqx8a7Zq1vq2OWA1U+W2De0X0ObBepoWre9IvIQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ufnquvmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 14:07:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCo7p1023713;
	Thu, 17 Jul 2025 14:07:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5cr4c4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 14:07:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzC3rxB9b5/lgOF+Rta/DfgXdXfDKVOQgYVUGur1WE9RE8E9EaIUMPpiKuuVITk9dqKTR7V/mVGayFklBUcSyGBIp24sJasydbBGNEHdHXE10YUbowWM56E0gQ2+z0R873OLbB/bIU8XExXp6CJTMYh/LGdo1QC/oXLPbw/rssBC8huhBtHrXyBnoDcoYcgBC6Nxi6+pm/tgh2unZiIj+LnTJm0y5ZOw7H4q2WZUk2MO95YIQ2Lqfn3OBopRjiiqSnVYlUj/zIfgnxAIBzlzsHMJ7Rdrfq8d0Kboo4ruQh8UgIqqigo24UI1hh3UMrV3rFN9D2MuJ6bsNiA9uqAojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9V5g0lX6fXA7wS3XYf9wd+I82HYGfpjdxwekm5m90H0=;
 b=VOLsG+qhjOKAnSZiNlRuR9N25KdzUUr0SSuvWMKKKuECvWVcAzK0NRxuovtmV6C8v0Qiv+0PgRWWhNNysDOZjpNhq6mM/wUTZ/6CXvtbMkywl3+ONb6uh3i77SAJo/vYd7rYAyRGQ/ZMbxTH1Cp2OImLwSpaR6P5Kmq4p1+HtBvw96GN3az7iogHxGyncYFHp6h3oiJCWF9u2SqUQTmu9irv7JAwyWXx2TiLqCkPppJotsV+7UQlnl8LKGkf5ZfDHjbApDdcEQMfcAx/TEXzcwd5YaN/K1uOsmMJZ8JjOyN2+NrfNOVJxOT1NEMxoXbgCfBcnAAYZMEBpGO0Ud39wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9V5g0lX6fXA7wS3XYf9wd+I82HYGfpjdxwekm5m90H0=;
 b=Ik/4YChY8m+1DndjPIgTcQD73bWyQZOox2sn3Ic7txJ8NKtkNkvQt5Y7O2hURgbHPRDzZyXFvynVzHKO79D2HsT+sTmctgpk5Ymg2qgO6vnNykKUfA3ec46aPupaTQcfX3Ao/Al2v8wfma+l/DMBRKUsfjWZD0BwHmrv0/6pt4k=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB5887.namprd10.prod.outlook.com (2603:10b6:806:23e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 17 Jul
 2025 14:07:14 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 14:07:14 +0000
Date: Thu, 17 Jul 2025 15:07:12 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Balbir Singh <balbirs@nvidia.com>, David Hildenbrand <david@redhat.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Kirill Shutemov <k.shutemov@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm/huge_memory: move unrelated code out of
 __split_unmapped_folio()
Message-ID: <5c97b1a8-b877-438b-91a9-1d1da19964a3@lucifer.local>
References: <20250714171823.3626213-1-ziy@nvidia.com>
 <20250714171823.3626213-2-ziy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714171823.3626213-2-ziy@nvidia.com>
X-ClientProxiedBy: LO4P123CA0146.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: fa9d1d75-f743-4f7f-9d6c-08ddc53b3b3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zy8i36Pxc5NCIgjkRKSX2AeMA5JSuhRybXca6NopWpu3C0fKNmtfFtU9rBK7?=
 =?us-ascii?Q?bF7kRbvBglYGX5qwT/HrI77EW2ANgrDoQaILMlPROA2y6o4EZU++hYt9raXy?=
 =?us-ascii?Q?rbLEgNmiaIAsjOY3vzW4Xp9hhEMli8GSgClW32gQ5Kxd/BFMXItypwDZr9wp?=
 =?us-ascii?Q?XNJRDfmh6ysrTWmtTyPmQR5QoYZ0u9sA6aBVP7aEXU2KpuLEv6iaFVfADDB/?=
 =?us-ascii?Q?n2s5Uh8Vn4PhaisLpXe9tCn/BsBwbouFiAu/9553r5G2CBXnkTQCEU5ev1V0?=
 =?us-ascii?Q?+W8A4ivNReYa0iAIHPF1AiSwIYrqHb1qRhVkdywPbr7EZCLVLrftn+idU9BU?=
 =?us-ascii?Q?faxJo4+Kn9t07sp7hT7uu0CYEmeKtElcSzapqEJkeSR43p+XE60EAmrRuafh?=
 =?us-ascii?Q?abNm8B+LnfFEEWiq/NDuiamKhp+yIYetbxJ4YnBa5/cmMrOell4/MlXY27m7?=
 =?us-ascii?Q?0jGa9N5P6DB7rk9bU0E4iotBI2YvFsm3Mwod6/5KqEHY6QiYTPukT8tIoRFd?=
 =?us-ascii?Q?5OZydST8be0q4g8QPIMxNBnXYTyHDPbEBS3SXOEBnL81lGhszD3GT+oj+Eci?=
 =?us-ascii?Q?Okj62hYXL0feSLgXtVv1j3bAIw5NCl7Bsb832g0L1FesE1P776RPjOutRvuE?=
 =?us-ascii?Q?uuFVgmi+LraxziHvl26GvXjSv8iFhhmuZPW5WY0CY1M0WoUS7m1a6q4bdPyZ?=
 =?us-ascii?Q?h38KtlR/IArpdrq0fNFxBkX2boNRRjW9GVlddbyEU7DiwuRcB628pyeMVFP2?=
 =?us-ascii?Q?vKVgf0xIeQCHBi1cuUZdFO8jDBOIZHAuP/SYCixx1mvxOhIb04PEmdp0u+EM?=
 =?us-ascii?Q?Ldo6yqOUb1gJW+kI2+HxpQRLJRFhcgeHdh9jiAg+1vAbHzJRd7iu4XPFza6w?=
 =?us-ascii?Q?CeZEY0LIfbK/B5YLH0c6Q1ansgORDh1mda4oEqvt4t9nEgCBTO/A9TUjxuNl?=
 =?us-ascii?Q?+aXNbIcGcLiLZG8HINGOmidW/d8Pr3t54WyZv68e7RbLW2+Ytwr6lD8AJ7CP?=
 =?us-ascii?Q?PmUD8wnfFlQ1nUaRKaQoUwc65h3fhJeZMHywXER1krzxPVueUzeEjPqGmlxP?=
 =?us-ascii?Q?htFOb76KonDW25etFL2isTwuFDUoH8QQ8CffCHUfJRoZ5kwWd7X7IUhvE0K7?=
 =?us-ascii?Q?hI0g97Lh7qwcDXr4n4YL5hI8TC3We0uLTEDaoaapd58O7HrqitebUE1zZH+u?=
 =?us-ascii?Q?gOFV5ukXilyyiCuvlhRvU2PwkwVKyo17PmKR6CrbQfGKWGZn68SN3klTIIHx?=
 =?us-ascii?Q?nfqdAHq4jhv+D9iu16RhwaadVQ3RgXZT+Bdv0aJ2C7X/wmbO5kifTlJc5n8N?=
 =?us-ascii?Q?UhIO5TNRQwjG5zjsGSS3ym7xQ4Qv+GZx/MLoI7w2bxVdAMCL72RmD4broZEz?=
 =?us-ascii?Q?/427c8hu6TnfqEfAtQYjvcN8Ep+OlN6MaX6DnXViEhrsp6HeFAySr3KaQclD?=
 =?us-ascii?Q?pks7JbfzOXM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EZMSw8cmzDtuG+amp3AM215XGtrJjbRCHzWaozSbTs+o1oAkehx68y9F2K1e?=
 =?us-ascii?Q?VP9QnTiGkEfhO5PA+Yl25ky80e8ZzWlvstPMfc7FXResUOELV1T/xwPL4r6T?=
 =?us-ascii?Q?4avcfTT+osAh7XgimHf3hdcvDZ876+tMJ0EgREScdPW2N/CHFU0VL0W89A+/?=
 =?us-ascii?Q?vMJecghJ4gAEyxYim90x6Mw4PRCqsgh6OnFE8C+ymnDlhHPWukr22wU+QtV6?=
 =?us-ascii?Q?iGftE1lnV9vfzxeuFX5WmCBjmwd/HO6y2Wd2BrihVYHszHlqIToJURZCc9Qk?=
 =?us-ascii?Q?gvExZhlf6655GHon8JT8usEedKUMMVE57s/slECFEi8z6vYVrEewQBtKSXTB?=
 =?us-ascii?Q?/a/RcXxJVIscpY5xGkChtIVUK1ZwPq4mFwO6d9dB1XH8HvsmBGeJBiS2bXc2?=
 =?us-ascii?Q?mjEQGJ4ddH6L4NbKV38YpNjd8kKRSLqSQJYDbcTt7pTFFt4lNYM72DWXOdnV?=
 =?us-ascii?Q?1XnV+EggY1RyPymF+sxUanxlq6QN+aNW5CCweOLoqSnjSpgdbieXmW587VXg?=
 =?us-ascii?Q?dwbAey/v6rku1DwJ4rYFhpPREBMb/ApYRW6P9BUVRU8WsVWqoWeHn/uHeG54?=
 =?us-ascii?Q?piDyvZWw1SJh+VZbNV45E5MgBiOn9OM1PiMsxDiQKeRQrnP0eWNNXGzqikEM?=
 =?us-ascii?Q?sCPxB/6xRnU8thqBEhhydQhYfeEM9X7MmmBXXmlmcrHw6JbiQbVW6kAXauME?=
 =?us-ascii?Q?da1I9sxu8HCZW6gWgmlF7jeNM3PisTXnb9e+LkMupPC87qrgHQckZsaexN+Y?=
 =?us-ascii?Q?jBRz7AKd6QROtbcb/8iM6DoFiwSeS6A+Q3DO3sGTLpKJuXJmtIKWehO5Y/IY?=
 =?us-ascii?Q?+HOypQufpfoVToZ+VEhWM1HtxkevmuUTmeomKfELbvpZJtKp3lGFo0GRM59y?=
 =?us-ascii?Q?nbGh2cTut82k80smc/8QHEtJAPcXSSkWzlci0W0A08GlaM7VJzn4Leu1aGc5?=
 =?us-ascii?Q?vLcgWNomzIIAO/eiR1GTrxx19CliXGjjKT5DEu+uHM1tBpGSQv/l4lRHFAJ3?=
 =?us-ascii?Q?ptzmlYsgTdALxeENZU/u/grIg/DA5nCSspEE1SBtHmnIL0u9qI3Zp+/XQhkw?=
 =?us-ascii?Q?vK7f3/PVKI1nKaI8Gpn5Gs5Hq1MLDEgdX9TH0bSaMnrAjjrVZ1TafUIrXy0r?=
 =?us-ascii?Q?VWFOtcTBn66R2fHzwVZ3S7NSLQCrShJLwJ49yi1xWJB8LZuEEiHCkYp+uNAk?=
 =?us-ascii?Q?A3ZalmMkDV7qyDxDWMXl/9zYzJmYtRY45hzk+Vg2UPTdU6DaWkcYEb1x5QXH?=
 =?us-ascii?Q?J0Mrg/SXv5hoZoauBqfuMAOdSrhayn7KLs4e70Iq8mC4jmDHlb6bSBpVJ0Uy?=
 =?us-ascii?Q?aEGsRDtqXVP4e8+CNxsNb96zt3niBcg3X4p36AxxoDwUOiwP9frm6EayUZGj?=
 =?us-ascii?Q?uNrpLpybO2dhi0pC5KCbdboQaF5aTE0/Nc4U7T6b9lDTCafr+LERhwzh2Aas?=
 =?us-ascii?Q?+fQWE8dBGAoxgfnDNFTyh/9NyAnlHVk3iHvbD1Ivgmf8iW6PC6zqoAR14Qs1?=
 =?us-ascii?Q?rE8bOHA5rftuBqDF7b+BaNXltTUlJFRZcazAfbYJq4tNtatbCG2UMwW1PBSa?=
 =?us-ascii?Q?WKe69LlCadBt855O7EjN/4zUMBW55snkMKExvgRqyK0/ZWMnKsWWozFbLUAT?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QkTwYC5iO34oAYCrbEsmGNOg4WamjFyJ2gSgmQt2SjvoPYN4mvQWp9Yw8mVDUhAzw/sUbqidVc7PCrNgYFjrSn/Efp7LmewW1gvdZ0uL6KqHNmJiB3L3Bft+4N1B9DguMLzZToalufpnDMNnFOppxL5osMJK3HXfmsboiWREVQYP+1j2dx1wcL8dIng2dNMzi6GeXct+WxYNv27qHD/D5gQbRtkls3Pyn6DUuQoymzMob8TUcKc/YppqpOKpnUjq2A2FGSJ0M93m5Weq6uyUAmmvMFC381A0bezsn9Aw+bGqk7o+OtrBVukh1EfJKVrMbRfFeCZ1B5QHXqK7qwLCmBPxXPBWccG5cgi/P6NSfRO6urJdPvk/c/vvfOnInyRJpMcQo94weIaR9ULZwo0tCGNS5WLDRYVQpwwGUq4K20ah2OSNV2+mnLPLpBW4Tk1tifDr3uQkacZPNlDay3Snr04r6UtnY+cOZgLNDf7VNpn7X1Z25iGfOIqFw9tCYNOC7MSvaVwYgk0OepOr/I+u9xjd6NiuYu0SdRNzQYoedIO639qckP7/GiEM08hA1FZrB6WDsUSYWLly+MYyaym8pPszBV3fE7d59/eHTD/gxJ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9d1d75-f743-4f7f-9d6c-08ddc53b3b3e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 14:07:14.6334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ZJllFZy6PIRY93Erkas34tBgDRnxj3ajZo4tUoBsYzFGWk3+yD6wfYxUEIApp3QZbyIz9TlkMz32U0ejAAUaBhCIHGBcX2Ox/oYqDGY4YU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5887
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170124
X-Proofpoint-GUID: SJW7eXo8H_aDl2UVfW9FcuBqqnhyAy0L
X-Proofpoint-ORIG-GUID: SJW7eXo8H_aDl2UVfW9FcuBqqnhyAy0L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEyMyBTYWx0ZWRfX23phhjp8jUc8 Uur4UULYa5LZKJSl8H+xrk5BChaVOKPRSr/7JBpsGakYfBhsqYiyiFga7OKtObGr7VKj61kPJAS fEuMkP9ZU+i6/M8cn/pFafjq4SgUZEhsoEL+JHvC7lZM4//KwumUlES6blcooJiDGHedg6to3tT
 yWtZCvcla7mkWBPAiBjAy/utZhHJe3wQ+crFmTq5HoodQ+bklsao+cehh840kMw2PbCLT6p5zTL XZnoLTJaGyhouB9y+b02Cy2XKL20VVxVReHWMaCdg10uNp/9swHexWsum1xwjApEXGjEJwgQIcH 7gUkmiw/WEQQIBSKmivFLcM+yLVUqXguafJT25vt0Xsj3nPt3t+uf/Im+QFIiVfRN/4lvH12JX+
 FA6vMYV/YJ0xCSzCOUYK/HJYi0OEjbm4SaXimgKtQCFkRqs3X5vg03WGg33x2IjHTz6s0U4K
X-Authority-Analysis: v=2.4 cv=U9ySDfru c=1 sm=1 tr=0 ts=68790398 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=y0oVMWSBv-rYbWE2dVcA:9 a=CjuIK1q_8ugA:10

On Mon, Jul 14, 2025 at 01:18:22PM -0400, Zi Yan wrote:
> remap(), folio_ref_unfreeze(), lru_add_split_folio() are not relevant to
> splitting unmapped folio operations. Move them out to the caller so that
> __split_unmapped_folio() only handles unmapped folio splits. This makes
> __split_unmapped_folio() reusable.

Nit but maybe worth mentioning the various renames etc.

>
> Convert VM_BUG_ON(mapping) to use VM_WARN_ON_ONCE_FOLIO().
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Acked-by: Balbir Singh <balbirs@nvidia.com>

After a lot of staring, 2 difftastic's at once and exactly 0 coverity
instances, I've convinced myself this looks right.

I think you really should have split this up into smaller patches, as this
is moving stuff around and changing stuff all at once with a lot of
complexity and moving parts.

However not going to make you do that, since you got acks and I don't want
to hold this up.

I have a few nits + queries below that need addressing however, see below.

> ---
>  mm/huge_memory.c | 291 +++++++++++++++++++++++------------------------
>  1 file changed, 144 insertions(+), 147 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 3eb1c34be601..a7ee731f974f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3396,10 +3396,6 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>   *             order - 1 to new_order).
>   * @split_at: in buddy allocator like split, the folio containing @split_at
>   *            will be split until its order becomes @new_order.
> - * @lock_at: the folio containing @lock_at is left locked for caller.
> - * @list: the after split folios will be added to @list if it is not NULL,
> - *        otherwise to LRU lists.
> - * @end: the end of the file @folio maps to. -1 if @folio is anonymous memory.
>   * @xas: xa_state pointing to folio->mapping->i_pages and locked by caller
>   * @mapping: @folio->mapping
>   * @uniform_split: if the split is uniform or not (buddy allocator like split)
> @@ -3425,52 +3421,26 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>   *    @page, which is split in next for loop.
>   *
>   * After splitting, the caller's folio reference will be transferred to the
> - * folio containing @page. The other folios may be freed if they are not mapped.
> - *
> - * In terms of locking, after splitting,
> - * 1. uniform split leaves @page (or the folio contains it) locked;
> - * 2. buddy allocator like (non-uniform) split leaves @folio locked.

Are these no longer relevant? Shouldn't we retain this, or move it
elsewhere if appropriate?

> - *
> + * folio containing @page. The caller needs to unlock and/or free after-split
> + * folios if necessary.
>   *
>   * For !uniform_split, when -ENOMEM is returned, the original folio might be
>   * split. The caller needs to check the input folio.
>   */
>  static int __split_unmapped_folio(struct folio *folio, int new_order,
> -		struct page *split_at, struct page *lock_at,
> -		struct list_head *list, pgoff_t end,
> -		struct xa_state *xas, struct address_space *mapping,
> -		bool uniform_split)
> +		struct page *split_at, struct xa_state *xas,
> +		struct address_space *mapping, bool uniform_split)
>  {
> -	struct lruvec *lruvec;
> -	struct address_space *swap_cache = NULL;
> -	struct folio *origin_folio = folio;
> -	struct folio *next_folio = folio_next(folio);
> -	struct folio *new_folio;
>  	struct folio *next;
>  	int order = folio_order(folio);
>  	int split_order;
>  	int start_order = uniform_split ? new_order : order - 1;
> -	int nr_dropped = 0;
>  	int ret = 0;
>  	bool stop_split = false;
>
> -	if (folio_test_swapcache(folio)) {
> -		VM_BUG_ON(mapping);

Good to get rid of this.

> -
> -		/* a swapcache folio can only be uniformly split to order-0 */
> -		if (!uniform_split || new_order != 0)
> -			return -EINVAL;
> -
> -		swap_cache = swap_address_space(folio->swap);
> -		xa_lock(&swap_cache->i_pages);
> -	}
> -
>  	if (folio_test_anon(folio))
>  		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>
> -	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
> -	lruvec = folio_lruvec_lock(folio);
> -
>  	folio_clear_has_hwpoisoned(folio);
>
>  	/*
> @@ -3480,9 +3450,9 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
>  	for (split_order = start_order;
>  	     split_order >= new_order && !stop_split;
>  	     split_order--) {
> -		int old_order = folio_order(folio);
> -		struct folio *release;
>  		struct folio *end_folio = folio_next(folio);
> +		int old_order = folio_order(folio);
> +		struct folio *new_folio;
>
>  		/* order-1 anonymous folio is not supported */
>  		if (folio_test_anon(folio) && split_order == 1)
> @@ -3504,126 +3474,44 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
>  				if (xas_error(xas)) {
>  					ret = xas_error(xas);
>  					stop_split = true;
> -					goto after_split;
>  				}
>  			}
>  		}
>
> -		folio_split_memcg_refs(folio, old_order, split_order);
> -		split_page_owner(&folio->page, old_order, split_order);
> -		pgalloc_tag_split(folio, old_order, split_order);
> -
> -		__split_folio_to_order(folio, old_order, split_order);
> +		if (!stop_split) {
> +			folio_split_memcg_refs(folio, old_order, split_order);
> +			split_page_owner(&folio->page, old_order, split_order);
> +			pgalloc_tag_split(folio, old_order, split_order);
>
> -after_split:
> +			__split_folio_to_order(folio, old_order, split_order);
> +		}
>  		/*
> -		 * Iterate through after-split folios and perform related
> -		 * operations. But in buddy allocator like split, the folio
> +		 * Iterate through after-split folios and update folio stats.

Good to spell out what the 'related operations' are :) Of course you're
changing this so this loop does some and the other loop does the post-split
rest.

> +		 * But in buddy allocator like split, the folio
>  		 * containing the specified page is skipped until its order
>  		 * is new_order, since the folio will be worked on in next
>  		 * iteration.
>  		 */
> -		for (release = folio; release != end_folio; release = next) {
> -			next = folio_next(release);
> +		for (new_folio = folio; new_folio != end_folio; new_folio = next) {
> +			next = folio_next(new_folio);
>  			/*
> -			 * for buddy allocator like split, the folio containing
> -			 * page will be split next and should not be released,
> -			 * until the folio's order is new_order or stop_split
> -			 * is set to true by the above xas_split() failure.
> +			 * for buddy allocator like split, new_folio containing
> +			 * page could be split again, thus do not change stats
> +			 * yet. Wait until new_folio's order is new_order or
> +			 * stop_split is set to true by the above xas_split()
> +			 * failure.
>  			 */
> -			if (release == page_folio(split_at)) {
> -				folio = release;
> +			if (new_folio == page_folio(split_at)) {
> +				folio = new_folio;
>  				if (split_order != new_order && !stop_split)
>  					continue;
>  			}
> -			if (folio_test_anon(release)) {
> -				mod_mthp_stat(folio_order(release),
> -						MTHP_STAT_NR_ANON, 1);
> -			}
> -
> -			/*
> -			 * origin_folio should be kept frozon until page cache
> -			 * entries are updated with all the other after-split
> -			 * folios to prevent others seeing stale page cache
> -			 * entries.
> -			 */
> -			if (release == origin_folio)
> -				continue;
> -
> -			folio_ref_unfreeze(release, 1 +
> -					((mapping || swap_cache) ?
> -						folio_nr_pages(release) : 0));
> -
> -			lru_add_split_folio(origin_folio, release, lruvec,
> -					list);
> -
> -			/* Some pages can be beyond EOF: drop them from cache */
> -			if (release->index >= end) {
> -				if (shmem_mapping(mapping))
> -					nr_dropped += folio_nr_pages(release);
> -				else if (folio_test_clear_dirty(release))
> -					folio_account_cleaned(release,
> -						inode_to_wb(mapping->host));
> -				__filemap_remove_folio(release, NULL);
> -				folio_put_refs(release, folio_nr_pages(release));
> -			} else if (mapping) {
> -				__xa_store(&mapping->i_pages,
> -						release->index, release, 0);
> -			} else if (swap_cache) {
> -				__xa_store(&swap_cache->i_pages,
> -						swap_cache_index(release->swap),
> -						release, 0);
> -			}
> +			if (folio_test_anon(new_folio))
> +				mod_mthp_stat(folio_order(new_folio),
> +					      MTHP_STAT_NR_ANON, 1);
>  		}
>  	}
>
> -	/*
> -	 * Unfreeze origin_folio only after all page cache entries, which used
> -	 * to point to it, have been updated with new folios. Otherwise,
> -	 * a parallel folio_try_get() can grab origin_folio and its caller can
> -	 * see stale page cache entries.
> -	 */
> -	folio_ref_unfreeze(origin_folio, 1 +
> -		((mapping || swap_cache) ? folio_nr_pages(origin_folio) : 0));
> -
> -	unlock_page_lruvec(lruvec);
> -
> -	if (swap_cache)
> -		xa_unlock(&swap_cache->i_pages);
> -	if (mapping)
> -		xa_unlock(&mapping->i_pages);
> -
> -	/* Caller disabled irqs, so they are still disabled here */
> -	local_irq_enable();
> -
> -	if (nr_dropped)
> -		shmem_uncharge(mapping->host, nr_dropped);
> -
> -	remap_page(origin_folio, 1 << order,
> -			folio_test_anon(origin_folio) ?
> -				RMP_USE_SHARED_ZEROPAGE : 0);
> -
> -	/*
> -	 * At this point, folio should contain the specified page.
> -	 * For uniform split, it is left for caller to unlock.
> -	 * For buddy allocator like split, the first after-split folio is left
> -	 * for caller to unlock.
> -	 */
> -	for (new_folio = origin_folio; new_folio != next_folio; new_folio = next) {
> -		next = folio_next(new_folio);
> -		if (new_folio == page_folio(lock_at))
> -			continue;
> -
> -		folio_unlock(new_folio);
> -		/*
> -		 * Subpages may be freed if there wasn't any mapping
> -		 * like if add_to_swap() is running on a lru page that
> -		 * had its mapping zapped. And freeing these pages
> -		 * requires taking the lru_lock so we do the put_page
> -		 * of the tail pages after the split is complete.
> -		 */
> -		free_folio_and_swap_cache(new_folio);
> -	}
>  	return ret;
>  }
>
> @@ -3706,10 +3594,13 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  {
>  	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
>  	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
> +	struct folio *next_folio = folio_next(folio);
>  	bool is_anon = folio_test_anon(folio);
>  	struct address_space *mapping = NULL;
>  	struct anon_vma *anon_vma = NULL;
>  	int order = folio_order(folio);
> +	struct folio *new_folio, *next;
> +	int nr_shmem_dropped = 0;
>  	int extra_pins, ret;
>  	pgoff_t end;
>  	bool is_hzp;

There's some VM_BUG_ON_FOLIO()'s in the code:

	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);

That should probably be VM_WARN_ON() or VM_WARN_ON_ONCE(), maybe worth
changing here too?

> @@ -3833,13 +3724,18 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  		 */
>  		xas_lock(&xas);
>  		xas_reset(&xas);
> -		if (xas_load(&xas) != folio)
> +		if (xas_load(&xas) != folio) {
> +			ret = -EAGAIN;

It is beyond words that the original logic manually set ret == -EAGAIN...

And this is the only place we 'goto fail'.

Yikes this code is a horror show.


>  			goto fail;
> +		}
>  	}
>
>  	/* Prevent deferred_split_scan() touching ->_refcount */
>  	spin_lock(&ds_queue->split_queue_lock);
>  	if (folio_ref_freeze(folio, 1 + extra_pins)) {
> +		struct address_space *swap_cache = NULL;
> +		struct lruvec *lruvec;
> +
>  		if (folio_order(folio) > 1 &&
>  		    !list_empty(&folio->_deferred_list)) {
>  			ds_queue->split_queue_len--;
> @@ -3873,18 +3769,119 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  			}
>  		}
>
> -		ret = __split_unmapped_folio(folio, new_order,
> -				split_at, lock_at, list, end, &xas, mapping,
> -				uniform_split);
> +		if (folio_test_swapcache(folio)) {
> +			if (mapping) {
> +				VM_WARN_ON_ONCE_FOLIO(mapping, folio);
> +				ret = -EINVAL;
> +				goto fail;

It's a new code path (in prod we'd just carry on, or in debug we would
haven oops'd), but I think valid.

I wonder if this is almost over-cautious, as this would require a non-anon
folio to be in the swap-cache (since the is_anon path will set mapping
NUL).

But at the same time, probably worth keeping in at least for now.

> +			}
> +
> +			/*
> +			 * a swapcache folio can only be uniformly split to
> +			 * order-0
> +			 */
> +			if (!uniform_split || new_order != 0) {
> +				ret = -EINVAL;
> +				goto fail;
> +			}
> +
> +			swap_cache = swap_address_space(folio->swap);
> +			xa_lock(&swap_cache->i_pages);
> +		}
> +
> +		/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
> +		lruvec = folio_lruvec_lock(folio);
> +
> +		ret = __split_unmapped_folio(folio, new_order, split_at, &xas,
> +					     mapping, uniform_split);
> +
> +		/*
> +		 * Unfreeze after-split folios and put them back to the right
> +		 * list. @folio should be kept frozon until page cache entries
> +		 * are updated with all the other after-split folios to prevent
> +		 * others seeing stale page cache entries.
> +		 */
> +		for (new_folio = folio_next(folio); new_folio != next_folio;
> +		     new_folio = next) {

Hm now we have 'next' and 'next_folio', this is quite confusing.

Seems to me new_folio should be end_folio no, like the original? And maybe
then rename next to next_folio? As it is kinda inconsistent that it isn't
suffixed with _folio anyway.

> +			next = folio_next(new_folio);
> +

We're no longer doing what would here be new_folio == origin_folio
(previously, release == origin_folio).

Is this correct? Why do we no longer ned to do this?

Is it because __split_unmapped_folio() will somehow take care of this in
advance/render this meaningless?

This definitely needs to be mentioned in the commit message.

> +			folio_ref_unfreeze(
> +				new_folio,
> +				1 + ((mapping || swap_cache) ?
> +					     folio_nr_pages(new_folio) :
> +					     0));

Again, be nice to separate this out, but I think in a follow-up not here.

> +
> +			lru_add_split_folio(folio, new_folio, lruvec, list);
> +
> +			/* Some pages can be beyond EOF: drop them from cache */
> +			if (new_folio->index >= end) {
> +				if (shmem_mapping(mapping))
> +					nr_shmem_dropped += folio_nr_pages(new_folio);
> +				else if (folio_test_clear_dirty(new_folio))
> +					folio_account_cleaned(
> +						new_folio,
> +						inode_to_wb(mapping->host));
> +				__filemap_remove_folio(new_folio, NULL);
> +				folio_put_refs(new_folio,
> +					       folio_nr_pages(new_folio));
> +			} else if (mapping) {
> +				__xa_store(&mapping->i_pages, new_folio->index,
> +					   new_folio, 0);
> +			} else if (swap_cache) {
> +				__xa_store(&swap_cache->i_pages,
> +					   swap_cache_index(new_folio->swap),
> +					   new_folio, 0);
> +			}
> +		}
> +		/*
> +		 * Unfreeze @folio only after all page cache entries, which
> +		 * used to point to it, have been updated with new folios.
> +		 * Otherwise, a parallel folio_try_get() can grab origin_folio
> +		 * and its caller can see stale page cache entries.
> +		 */
> +		folio_ref_unfreeze(folio, 1 +
> +			((mapping || swap_cache) ? folio_nr_pages(folio) : 0));

This line is horrid, probably one for a future series but this sort of
calculation of what the number of refs should be post-freeze should clearly
be separated out or at least made abundantly clear in an open-coded
implementation.

> +
> +		unlock_page_lruvec(lruvec);
> +
> +		if (swap_cache)
> +			xa_unlock(&swap_cache->i_pages);
>  	} else {
>  		spin_unlock(&ds_queue->split_queue_lock);
> -fail:
> -		if (mapping)
> -			xas_unlock(&xas);
> -		local_irq_enable();
> -		remap_page(folio, folio_nr_pages(folio), 0);
>  		ret = -EAGAIN;
>  	}
> +fail:
> +	if (mapping)
> +		xas_unlock(&xas);
> +
> +	local_irq_enable();
> +
> +	if (nr_shmem_dropped)
> +		shmem_uncharge(mapping->host, nr_shmem_dropped);
> +
> +	remap_page(folio, 1 << order,
> +		   !ret && folio_test_anon(folio) ? RMP_USE_SHARED_ZEROPAGE :
> +						    0);

I really don't like this !ret but here, this isn't very readable.

Something like:

	int flags;

	...

	if (!ret && folio_test_anon(folio))
		flags = RMP_USE_SHARED_ZERO_PAGE;
	remap_page(folio, 1 << order, flags);

Would be better.

But really this is all screaming out to be separated into parts of
course. But that's one for a follow-up series...

> +
> +	/*
> +	 * Unlock all after-split folios except the one containing @lock_at
> +	 * page. If @folio is not split, it will be kept locked.
> +	 */
> +	for (new_folio = folio; new_folio != next_folio; new_folio = next) {
> +		next = folio_next(new_folio);
> +		if (new_folio == page_folio(lock_at))
> +			continue;
> +
> +		folio_unlock(new_folio);
> +		/*
> +		 * Subpages may be freed if there wasn't any mapping
> +		 * like if add_to_swap() is running on a lru page that
> +		 * had its mapping zapped. And freeing these pages
> +		 * requires taking the lru_lock so we do the put_page
> +		 * of the tail pages after the split is complete.
> +		 */
> +		free_folio_and_swap_cache(new_folio);
> +	}
>
>  out_unlock:
>  	if (anon_vma) {
> --
> 2.47.2
>

Generally I see why you're not using origin_folio any more since you can
just use folio everywhere, but I wonder if this makes things more
confusing.

On the other hand, this function is already hugely confusing so maybe not a
big deal and can be addressed in follow ups...

