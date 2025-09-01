Return-Path: <linux-kernel+bounces-794002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB21B3DB58
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDEE117C133
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6323B2D7DD8;
	Mon,  1 Sep 2025 07:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l9wu1C1c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E8sMsejF"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821672D7DC9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756712673; cv=fail; b=CpfGvqFRTuY9npURU0dX27f15gbgRf7FQadx3Ydv/qWCvT+KU9E/E3JDLo1VlZ3AN2gdJzagBcfBprvOZbnb8YkrzN9l26lJ00sHbGFpEVDWijOGcgAcUiHxm82CC51N2of98/N+wVKQY+phv/KwwsHxb8zjn/6SMFIaGjzpwzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756712673; c=relaxed/simple;
	bh=/KU0tK/yZ2fYDQ2eYuz8yWYdQs7oDs99sii4O97TltQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HrmzUhl6PJ7tqMBt5zHTvhev9fiAaWiFb0+/cyvmWcSCgRgko2td/CWNs9xHsstgfc9B+hruBAJ6pPRZOdP/nrxlph8gSm46VPJof4mI/9Q3HWDVo/KvavSlBZYi72PoYZhvZaePAnzrg2UejR9esCClfKH6wSY5JfKnHQcAles=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l9wu1C1c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E8sMsejF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5815fmq2026606;
	Mon, 1 Sep 2025 07:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=sN+3rCdfo37WARjLwB
	ZVAOqoy/VxhhSyVG6hT29YzYU=; b=l9wu1C1ca/J4QpcUU2nW3ZcTnyrPMeVu4Q
	PzIcsyuXpfLd8K/24q/Cx6iZQKGQYn86kt0n+ecfTR5ljT616vdNYH4CcO2DnzSo
	CR4ypbRa0S8E/K4nR1PETrMh1L1A7u9bzigKF12HPPd8uFKo/6YgLjqSkRxasKtp
	0UGXEgrrHi6gYlbGsC57TgNV2Od3WyU6cef3FHlibV3wmQ/HakJafC8eJAIuEVdU
	vomIOaBwN/fpBkV8V9xv8cIqaD/Oox5zE4aWYztmAl5aWiQdQFf8ZSLIKug09YQ3
	GcOouXC3N58zRkvAv5Uda+Z3v1f+/7kdJxBqyB1Tx+thuVAwQQTQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ushgsvqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 07:44:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58178Idq028741;
	Mon, 1 Sep 2025 07:44:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr7vqcd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 07:44:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ng3xKbSngmO1Enhdxu0KN9Ndrm9Bckedml66q7k8dp88II7N55c8XAxcMhY8qkppjKCG5rpfQ6QwCG5VmCCdllV9NS7BysTpeW9q0xiCaAREoIHk0WCf+lJr9EVF5KCu0FuyNsdDDyedb09rLIVT17Ji7Q0o/Mp/eJNT0Xe6z13iMzlT20+CUFOmhWe4jHEEsubzV65mFBcgFNTmreCsgEHb89XXetu+r/uZqKlr8k43xfg5H616bATmKHnI6YiIahEsAjL1CiDhiq2kg/Y4aXNszQRGuLOS4a4AoJe+BKqqwjPYykXZwnCPWch/L8M7HgfOWOE0B1MWRLNhFbSCDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sN+3rCdfo37WARjLwBZVAOqoy/VxhhSyVG6hT29YzYU=;
 b=o7l26qOqhHt91C4kvtzCcVuHfQf/4dWHfu0krKj4JGJhv4gs2n3HgWyk0C4VKCQVRYzQg+9pqtNkISJEJ4PFxIRPgylLKXneqZTLunFRcQBTDKCm+1eqXSN/AIxbp2od2/XMunfXqkq5AKEcaJKNCTQ/PEfROBMHYJmLHDQ1bVGj1uqhQukM5FJcusuIfbxFGixt8N4cYo0y9rS4zDpWWj8UBByEIaVYCc/2FGJGTsRb/BBSy+uFdwZATAWLl7vmCrcnVQuc47p2wjiidj/RlS6Oy58pPLdHddhkOp56BjtPv8m6ryInYFiMgT2wwjz/6fYWWLFPAeiu+4HQOkYX/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sN+3rCdfo37WARjLwBZVAOqoy/VxhhSyVG6hT29YzYU=;
 b=E8sMsejFgwPLnbiDdbOaSM7v4soFrMvr8FLqOBjdsCLUH/V7YFRhngM0XEI0CVgcKUqE2pLCd6NBopEykYHgexIHfcuXtg/NRS5Udm1173sM+7tW54k1jesq7li4RHiOzRbDwSKeGJcPAB1KMkwKPgv6vjPCCdElEg+ZURxLWFo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB7511.namprd10.prod.outlook.com (2603:10b6:8:164::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Mon, 1 Sep
 2025 07:44:09 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 07:44:09 +0000
Date: Mon, 1 Sep 2025 08:44:04 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com,
        yuanchu@google.com, willy@infradead.org, hughd@google.com,
        mhocko@suse.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, vishal.moola@gmail.com
Subject: Re: [PATCH v3 01/12] mm/shmem: add `const` to lots of pointer
 parameters
Message-ID: <052aee05-4cfc-4fa2-8944-4c85676c95ed@lucifer.local>
References: <20250901061223.2939097-1-max.kellermann@ionos.com>
 <20250901061223.2939097-2-max.kellermann@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901061223.2939097-2-max.kellermann@ionos.com>
X-ClientProxiedBy: MM0P280CA0034.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: c38fc1e6-bf8b-46b9-da2b-08dde92b55e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JqBOMEMpoFEMfw669TOJuc/hhPLj1rMHkKace8NFE6eFfO59ViMokpF9MPjq?=
 =?us-ascii?Q?mCyVPz11vVN1YLR/hCHo625jr1IkhuItcxQETg2iaaB6L/cfd8JWs9gnvqgf?=
 =?us-ascii?Q?i9+ibBEeK4obi43sjZD4w5sWEkCDoC2F6qFuOuvpvJApU6O8RPYJaA94UXJO?=
 =?us-ascii?Q?PeSC9sqaShoFy3QILc21ZehC6Y4m3VY/hKNKYZ0EO7LXugpVN2HO8BoVuu4J?=
 =?us-ascii?Q?f7EGs7sBcpfYhQzqUPBzfBuXrWNXA78f63WveTy28ocWHImRPQMWU4J+tUjQ?=
 =?us-ascii?Q?Z2aaF2nghzfOVLJXNz41RTzR3c+iVc1Ih2rZWNdm8YKnVBgl8Mjfq2AS7xC5?=
 =?us-ascii?Q?9/Tb5DwU4/NLgQA71QR7euwTnLio64NvPKaxx/Ik6qidhGNXumBzYrAnizG9?=
 =?us-ascii?Q?aX1gIX9QgfrAa2FZ4YRgVSesuHSSLT/m8OR9PDXrQXs9vXzdENdOA9K4TU4Y?=
 =?us-ascii?Q?ChHiEy5U7l7KMIcvUlhMZlNcmj5/PDeL3GnYxSJV+wWRfBcJNW4pu3Uz+UAe?=
 =?us-ascii?Q?ZnGVJyEFEOnrXZvY5duEWu7koV2HQszFXNYoEWBu+hEFCtLFNpsEn3NrGNb8?=
 =?us-ascii?Q?sOKTkrahEwkg7uBOHxS2Hx3y01SvhidMDcs32Ojn4Fuq7tZb+txl2mxA0DJ7?=
 =?us-ascii?Q?2apJmdhk5OJH5c5UyF16wjAi1QN/wNsxp4rsio8IcQ0z8yOPppn49DaZGFEZ?=
 =?us-ascii?Q?8nP0wZZaadqN7B2sNuPNXsp0Kxqa40xKcx9IdFo73nJb4P/HJwrw6zH5ItlR?=
 =?us-ascii?Q?iPWO60yrg5RvNF2tfAEusneybBjVE5UNOA1rnTzP7jAIzzCBuwTuz/1wBHOd?=
 =?us-ascii?Q?M3VmLNebKZjua/yMi+J31iZzKDGqvRTNxj5LbWYNFZpbx6cAXJ3Ty3/zOq+v?=
 =?us-ascii?Q?4Yece/xQuJdn0r+MVvPONgylv0jIfrWMMDk2anPwFx54r72YKUEZIcvLvmFs?=
 =?us-ascii?Q?J5TDTGtLpYCIGYS84jdBL0rmksAs3CGODK0gHnjOW1Ehc06wPQoTjHFQ/uEW?=
 =?us-ascii?Q?xVEU5QIbOrqlVEJA46b2DhOacqPjyhLQKVj0TXVCoTtR0j5SKFwAY9QkQnFb?=
 =?us-ascii?Q?WWGU445gYVOasNGQNialZV7+cIcVbPRPcUdeTi/ViJucIbxhBGZ1fQ+RsqDg?=
 =?us-ascii?Q?wdoThEscoFn5MJzafT2t/0D988JuCYD34HpDJHdxrC6sxOcdkPOfcIY0Wwev?=
 =?us-ascii?Q?LRLQfJHE6Z+V04OQrg74r3JM5jwIImrbLJSB90NuQ3aypUEUcgq/hqMcDvQC?=
 =?us-ascii?Q?AQV9ExVuHaw6rFTnoj1B6K+X7gZxoPa9z+9sdiUkSsce6InTEiqB9/68Fu/E?=
 =?us-ascii?Q?2XUqV9Ze+WWn93Hd8xJPRKsLDuwpm6lXrZQ9hQpTX3GyC8vBjT/KqbzdNAuK?=
 =?us-ascii?Q?p4p4IaisdEsi8p4PcxDMOFexfXVcNCouR7tvdvXOoeERfjJJKOXUItzc6lsW?=
 =?us-ascii?Q?35QMFVvZcDo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wCsurvtVmiGC/JhTvDHQaw5asJK/B8l8SF2thmW1mq6UlbBzBzKzUicJfHGI?=
 =?us-ascii?Q?UhXTwSeG6tv0qYWJFf8sousEPq/bnGau837q6sUH2OOWx2YIDnYvgRc94osR?=
 =?us-ascii?Q?oEYYB+GlZIqD8ffL9ws9dftchWxquIYDocm8rjXTDQjYs7ai59GWHg2NsKB9?=
 =?us-ascii?Q?UalaDiy1IITqYSmvJ3OLO0dEkQLr6iDHNOuH1k8VdZHcQQXxOGYxQYJ4MDZ0?=
 =?us-ascii?Q?FeHzTMK1zYQ8SMJD4sIpnLQpmm9wMwaxCtF1oJ2/c81AOVCUTicZKaoEP5gS?=
 =?us-ascii?Q?0P2XEGTeG6U33LutINWE/asUehZ2rV6vZYaRpCaLQnrBk80kOKeEYob5VkGS?=
 =?us-ascii?Q?KJMx1s3VbbG8d1HlO5hIgs2OfbJyZa5bapqaO0USt+V5jEmtCUHFBaUbza2u?=
 =?us-ascii?Q?uV+WRdxgV+Mw+djVovP4JhmWEVkbjhXnkuM7XS+XaQtsf2QsBvpwUyn5CrPP?=
 =?us-ascii?Q?/q5leMO5Z/uXfh7PQQCD56cb9/cPoA5o7hNpHHj+a9iamXc380W2fg/gC77e?=
 =?us-ascii?Q?0tMx8a/zjZYjNRNhjj8NxS6jAxpXGO+b6eBZT3PWPtd2K7F1dFDOsF1kU8kU?=
 =?us-ascii?Q?vVjkcAtrM6K86/r13ODOzYgciCEjqwojIy+wWmMYj45ObG+vTPRsAKzDIrsm?=
 =?us-ascii?Q?WQKVzrcBkcMB+zjhE7GFJr0qcXXE+v/1PPQdl5gAYsDPwvQNmD+NYIRUyTd6?=
 =?us-ascii?Q?F86FMmX6Ed5K2qBQ6JomhF7098TUY92seElfGaMxZHLE9Pc+Mriy81y4StIV?=
 =?us-ascii?Q?g/4iuzLg2e14VT2TvBg8dzQZE3GafMcTPnGUkBi6mdZzLuVJ89qi5zLYYu43?=
 =?us-ascii?Q?KfWkPQ61MJYw3ax4l/Ghmq9VUaTbX1MBCSHls2imDLDQ/YN6jQMb4NQUAVD2?=
 =?us-ascii?Q?YN+/YK4Zdzn/c6yHGNXT0RtL9O+W/2pBH7Hq8T/6ua5g1mFme7ENWOEgK5UP?=
 =?us-ascii?Q?rZjSPVbVBlZtiHsa+I/14PRrxYoUc/pAwa5xQ35RGGhcE4pGddaS3nDQK1BG?=
 =?us-ascii?Q?Mo07T9fMjgVDf06kDdfJhDXzb2ssfWsTIUtp8V0+VyFbMdNyb9nkXVBumINI?=
 =?us-ascii?Q?8MaIwg/aUBuqcn92X3owhDZteR12NvNCwzjEivTrFXEhuLv/of5CwN9H1HQV?=
 =?us-ascii?Q?LUY+GfPELrvgb7la/FuohncFXOF6eHuON3iykapoz1WKDSfM+m/LKG1B9eAZ?=
 =?us-ascii?Q?3UdVMJPY6lvBIEu6JJsdqoe5Pjoe6bexTA901CoXNGaIY+qJ9cgWnfm5rD68?=
 =?us-ascii?Q?xX7ZnsnibVZnIhBXdxcHFMdXuihES8o9ZBiAuey2a8D88m4oTO2/JK4fyuUI?=
 =?us-ascii?Q?KGSzzxfPyjlqizQ1+lqceIhc76F0NsHS2x7Gcv6PylXWUmIPeeapne9Ve3LY?=
 =?us-ascii?Q?3/8Usgg5OFUSwHFjoJMZafj60+rNUsZ0CFeSp2Tp0QUPBqlmxeyAYxcLRQSG?=
 =?us-ascii?Q?OgRuWQ/LdGyv/QIdo+L4r4cHfpJAiOdgwda7KHW6Tf8YY8DU97yDoTpGu5G1?=
 =?us-ascii?Q?hDhhszKVsb0Inl90Qgr0/qOI3ZB70UCnYKjkvCgHZiwh6WpVnQvi4j22dPun?=
 =?us-ascii?Q?wo+C5rGz3xDlqlDO3FdObrD29j5VppCg0kqGYZO5m4PdTmK1xVM0fnyMspaS?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wdJo9hq4GhmxpBzm9AB7CpLWyS6E1fnLx99E6ua7BTT0WUSm5/LWrahVYk68Uw+1OxCKJFUTsz8KVb9GxOwkvvBZYtELUITQi8xQFoxefnWZ/lTvDYLpLHuBh/AwVQAdad4eR6LOJecUGZPilKEhYgmE8OesVYQaPNfWAvJKNFtK89gAMhWn+dwGbRni1tJSw7ohCNzOF4TWItXIwHEV0/6O4lc3G4DqAoBR9p4/1E0F1X5LwI4vq5KVLxuPtfs/DVwXPfewsLZUWGsxGWEdrhFCgZ1AHq/3806OzHQOc6O3BHpvzq1KymyMWdtxl6Y5C3PoDqGCLuBqJZ1LFcUMI7rxTSWtphYeL4Jvtz2USnaW12pEwsLAHxBWFRayq0WtEUKWzTpp7ncdvHEhR+6swZQc1dabHLWPPr3SzveHbypOfyZbbmV7UCzNv8AvdA7fX1WL9qFnfCmBF5iCfbufEnpxnkaunqXAgo4v9HRWpwbb+pJEK9UaAL5yur2A6djHStep36yQPfKnAgD7M9aCxMhpk/FUl/xRUadg40x24wZx5wrMu6tRKVk5z/1tLED/6QeN3Hk3sB43LX0jo2MUd3Ury4fMz5jJeT4lxzQEyPs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c38fc1e6-bf8b-46b9-da2b-08dde92b55e4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 07:44:09.1054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R2e5V+zmTSZK+RAi+xO22jt6LuG/KS2vfvTddB+YnKfEjnphycr0hMG7A4qzE0PtMMq0Vwgl5e8ZCzTJ4p2XtR8mhzNivPEh+yyPndB1XSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7511
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509010081
X-Proofpoint-ORIG-GUID: M2Fx9L9auy4xkJ6CY5rBW5p56x8VorH9
X-Authority-Analysis: v=2.4 cv=YKifyQGx c=1 sm=1 tr=0 ts=68b54ece b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=UgJECxHJAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=yRUURUDK4fCiVKFZ-C0A:9 a=CjuIK1q_8ugA:10
 a=-El7cUbtino8hM1DCn8D:22 cc=ntf awl=host:13602
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX5BMFphJxbOrG
 AdT1axKjsKBBPnRlhqmczcSQ4lGnNXxdjLUGZxkdxAkQohBs/p7Oj2OGL87dvpcZdOEePZ0k4XS
 EN+YrE0O4PCOWVN2xgLTvMXuWfYFz/LaqcPwJ8qNDJzrFTJxVHMLxort2MJyhhtDpwNvOVCguTx
 1hzHe+NpzS88Ap+EfDA67m47h+TxZ5C2mgsvFZKDxeWft+YzzGnKLiQKV9DYSz8jcX6hXpNqo7M
 ptEsva3jFrQH54y2AhaZrxUxga8yAMKaIPWnWpGzZioKNC4gm3cy2c/ubBFjHyAvF+zzfA2uKlU
 g6IARb7IZp2kuOBHvlwxQH/P7Jxn2PtAX4wotB/f5LdPSLEpp/1/9Oh5azC3tIGwNDhd85Eys3X
 7HyBGNNrAT9+3QAe6poYtCdBjmLePw==
X-Proofpoint-GUID: M2Fx9L9auy4xkJ6CY5rBW5p56x8VorH9

On Mon, Sep 01, 2025 at 08:12:12AM +0200, Max Kellermann wrote:
> For improved const-correctness.

This is not an acceptable commit message, you need to explain what you're doing
here.

I'm thinking that review will be the same for each...

For instance, reference the fact you're starting with functions at the bottom of
the call graph, and mention which functions you're changing.

>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

This otherwise, functionally, LGTM so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

On basis of you fixing the commit message.

> ---
>  include/linux/mm.h       | 8 ++++----
>  include/linux/shmem_fs.h | 4 ++--
>  mm/shmem.c               | 6 +++---
>  3 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index cd14298bb958..18deb14cb1f5 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -979,11 +979,11 @@ static inline void vma_iter_set(struct vma_iterator *vmi, unsigned long addr)
>   * The vma_is_shmem is not inline because it is used only by slow
>   * paths in userfault.
>   */
> -bool vma_is_shmem(struct vm_area_struct *vma);
> -bool vma_is_anon_shmem(struct vm_area_struct *vma);
> +bool vma_is_shmem(const struct vm_area_struct *vma);
> +bool vma_is_anon_shmem(const struct vm_area_struct *vma);
>  #else
> -static inline bool vma_is_shmem(struct vm_area_struct *vma) { return false; }
> -static inline bool vma_is_anon_shmem(struct vm_area_struct *vma) { return false; }
> +static inline bool vma_is_shmem(const struct vm_area_struct *vma) { return false; }
> +static inline bool vma_is_anon_shmem(const struct vm_area_struct *vma) { return false; }
>  #endif
>
>  int vma_is_stack_for_current(struct vm_area_struct *vma);
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 6d0f9c599ff7..0e47465ef0fd 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -99,9 +99,9 @@ extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
>  		unsigned long len, unsigned long pgoff, unsigned long flags);
>  extern int shmem_lock(struct file *file, int lock, struct ucounts *ucounts);
>  #ifdef CONFIG_SHMEM
> -bool shmem_mapping(struct address_space *mapping);
> +bool shmem_mapping(const struct address_space *mapping);
>  #else
> -static inline bool shmem_mapping(struct address_space *mapping)
> +static inline bool shmem_mapping(const struct address_space *mapping)
>  {
>  	return false;
>  }
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 640fecc42f60..d55bceaa1c80 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -275,18 +275,18 @@ static const struct vm_operations_struct shmem_vm_ops;
>  static const struct vm_operations_struct shmem_anon_vm_ops;
>  static struct file_system_type shmem_fs_type;
>
> -bool shmem_mapping(struct address_space *mapping)
> +bool shmem_mapping(const struct address_space *const mapping)
>  {
>  	return mapping->a_ops == &shmem_aops;
>  }
>  EXPORT_SYMBOL_GPL(shmem_mapping);
>
> -bool vma_is_anon_shmem(struct vm_area_struct *vma)
> +bool vma_is_anon_shmem(const struct vm_area_struct *const vma)
>  {
>  	return vma->vm_ops == &shmem_anon_vm_ops;
>  }
>
> -bool vma_is_shmem(struct vm_area_struct *vma)
> +bool vma_is_shmem(const struct vm_area_struct *const vma)
>  {
>  	return vma_is_anon_shmem(vma) || vma->vm_ops == &shmem_vm_ops;
>  }
> --
> 2.47.2
>

