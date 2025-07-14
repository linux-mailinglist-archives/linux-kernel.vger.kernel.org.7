Return-Path: <linux-kernel+bounces-730447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43414B044AD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80871886594
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBC0256C81;
	Mon, 14 Jul 2025 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cqiMR3JO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KmEqB19U"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD86623D280
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752508115; cv=fail; b=HXnb8/t91CUZuTB02WWUQ6M6dQS/xGZ+fKVCTBFd8j5r1ElxlvvuNwnOrauCdiwo0AtSre8QBFSFCDLUgACzMsemXmJdwwXQNYDmkmPwP0/tvK0ZcWsvC3Dwxbic4ImAxu1K97aCG8vhBEEMKntnVgW6u+T/r9JRoRhkqI7kQIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752508115; c=relaxed/simple;
	bh=3kRRS+Dwtk1QLIoKXOVCcU+HqZ8j0QNhrDG9qxpVXUg=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jVh/8BQZI8jrnbkpAxPBELogVZHTjITL0lzp8J5OqFHpUb/5ZeHOSsu2BzDuyGCKkbofZR/kRaGJpTw92uPpKI2np92NEWWme8rPPXwrP8YZXD36euCWqXERptn65r6/ccxQuOL1T06f2HKS023VFDC56W0M+RL4V8mDdfVMt4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cqiMR3JO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KmEqB19U; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z6Fu031362;
	Mon, 14 Jul 2025 15:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=s6SF/G+lcEbUX5h7mR
	oxRQofljz4fynuJimRHgPTlag=; b=cqiMR3JOEB7CpjHjFqHFfanzgM32SJtdRD
	pZ3qXE6Y4lJ93irqhcg1IhTG5FrhXccCG7+8xG5TP/b/HmyI6qXTWuOSzPqXSk4x
	X2CsY9dZ/f9qR66PkNnd4hS71wgjNt0TZfRmYn8YCYf+Jft/opcz8r0cie1bTlJ5
	f73FHsfgdHexjIf81BNQ66cqMVU5QBDUpEuFdPK0a9PsOlXhC1HV8hKNTcx0mXyL
	NKrZTQRidCP4XJDDUK8B8UYyjZD2W2h+pGOfxX24xH+Yqt/TYGwTC4htLBwJGaKZ
	V09sHhxIMJ0OqRsH33b0q6/72+Km72PYC2wXXhQt8Zcbd5oF/Qew==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4mgc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:48:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EEAIYq039882;
	Mon, 14 Jul 2025 15:48:17 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58pg57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:48:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8v2w42VkP8kAaAoqfOlBX0vEueoBO18UauH1QcRQZL1axIjIVXqtKKlKeMnGsgdU1Q6qa0HIqbydeed5vxHtFLkND+jBVZngSr8ygoBt4SfBoz4Kp8z2GePdyQ0LS5s4MDSSRpTcDM9rRKVhs4cw8NvnX67CJf8YX+dN93BtxyLdvUMA89jMs2GZ40/5bpCJNkuI92c15bUxvesHfSyJdteCby1HmsF1xtlWz55xCHZofB5hcWIJHWPzJ4TZhFK8ckmUOfQOAPKM6vUFB0wVOSqiY0MBv3oDejw12Tg7rp3jLpHfB+rjOCEIZUxsI1y/Dn6j1zEZoxWhhZ8l9LrvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6SF/G+lcEbUX5h7mRoxRQofljz4fynuJimRHgPTlag=;
 b=Kb6HwjLv6064Bs0RLFHb4JuZv1z2GjCwbqK0+8nXaCBhNDoa6LXf7+5TNys5HXpKaGjw17XpoKiIMQpiBXgYlysXOlFe82narsnd4cnE3UjH0N/3J3rUXPgP0SxRHmRjFZy2UEn+uHK/eDFdd7MQTZN0RwEJ7jUlg+/0eHzrgqNZTJHzcSH5DXsoQRiikzITY7PpwpKwvVQ7WLYMbyWPvT1HqnD3P0DQ55kiWxWxbMK1K1n79v2Hjlf4qLee81CUBu9ry6iOts9G4ur73xryC15Q/Oh3WUMD0sOTRqVP468cBrKpMlc5yzTqXuq6X1rWCH3eMX4f5UyNdKENbSWHPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6SF/G+lcEbUX5h7mRoxRQofljz4fynuJimRHgPTlag=;
 b=KmEqB19U35UGy9EJ1B2vrvnq0zZfl7369nvPtAMWdUjdrjbNk4pcu3dJewoEHmXkfaz/Df4xEfhhQMCGahMhIs8GVN7toSzXOBhmNLT9XnEWPEl1T+LJzpIUosZeauPfxm7ZmSNn/dXlIEq1laxbYy54RwiNNhBFBmKudGzHeB4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ2PR10MB7582.namprd10.prod.outlook.com (2603:10b6:a03:538::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 15:47:50 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 15:47:50 +0000
Date: Mon, 14 Jul 2025 16:47:48 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH 4/5] mm/mseal: separate out and simplify VMA gap check
Message-ID: <2862cc9d-9939-4bbb-9e55-486b7df3d445@lucifer.local>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <f010ec1ce65f35dbe1fbd82ce002ea833a7128f3.1752497324.git.lorenzo.stoakes@oracle.com>
 <mmqwb7m76ty6gmazw7db35rfow5vq66a72qa7rwjhnkh7o3j6t@2bk55s6jqb5f>
 <bb2ece09-fa16-4f4c-ad29-bf8de847411a@lucifer.local>
 <awqb5pkf5fvrlz5shphy26zlbeopw6oc7blpm2rdcceszqzjce@lamh3fx3ldzi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awqb5pkf5fvrlz5shphy26zlbeopw6oc7blpm2rdcceszqzjce@lamh3fx3ldzi>
X-ClientProxiedBy: LO2P265CA0365.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ2PR10MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ccac99-c2b3-4155-4881-08ddc2edc992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pvCAqjp215fpVV8zOBDM5Xu3sr5Gn8P6yMt6u4kJ/ohUN0IuC52KcBwvarNV?=
 =?us-ascii?Q?OtlC0Cv/i672MkcWfJf5HZ5OLYgQIpgNRn6+c4Nj5qicul7S8dKiTnI/FvV2?=
 =?us-ascii?Q?cPvGq1XGVJOT/E9mmCxqMKOb6aPux5l9lGuQZYvB95GFsodYg/SERqDQY29L?=
 =?us-ascii?Q?g2yZRvpzeyvR6Cysp1YzCvSVERZoImHXoOCTkfWrWHgF+ymcDftJ3ugFO4hj?=
 =?us-ascii?Q?ctFQ/z9pu91QHguKLfeQqkDcAPZIrMMo/ewz8Oth1UghaJbXtinB7glzSqos?=
 =?us-ascii?Q?1CnR43Ii+DycijcVgafq1Vkm1ZSVMlbQ3JFDjmsEIorVZRzGlX/DRW1NqhqU?=
 =?us-ascii?Q?hFUOa6CeLaw9x889PO79lK2H+kwB+mXiTSGsVbLP3H00XIr5mth5ZKhJ6Bzr?=
 =?us-ascii?Q?Pe2a+YMD2dHhQ+73BIa913QkRyshEOq2yQY/jOTULCPdqqmNuZE+fkEs/taj?=
 =?us-ascii?Q?tYIZBJ/JEy7TXvaq4tmyZv6HcLF7s9zty40zoTkrkQ4xZCnehfegPXGmR86T?=
 =?us-ascii?Q?HvjAYMvOP8kAoQ9rLtQEz2jtw8rFDZTU5rij9kxGGOWTqQ7RaVLbjnbVakL7?=
 =?us-ascii?Q?FwI7FUotQdUd+AcFTs5y03qZg6plH9Ud4YG9To8VzFHE9sD+/yhOZXN5vUVi?=
 =?us-ascii?Q?JZZ88K6fxnVGYevac1c1tvXDKgKJsc4LprrJgFQrwbu4R9v1MkeBrPOS2k/o?=
 =?us-ascii?Q?fkEYRXBbJ2OWNbP0xhbFlglMfg/7HNn0xpmOAviHNRqw4C4+x4gctClT7B0g?=
 =?us-ascii?Q?Br+IQk/2UTxM1etPQnZlb0vpCHnUfT5ad9HZ/jK3xTaUcNArtgK+TH9XMUjk?=
 =?us-ascii?Q?B80e0UliiVof9CXVHy/KB4WJ9z+ssV5EQGHhKLhBiD2jfhMA+3mdNINUpai+?=
 =?us-ascii?Q?uDMkcCDrUnuKoxKYmU9YNLfgbAS01L7H/NihQXdAZNx3EQfAQYcFpp7DjI6C?=
 =?us-ascii?Q?HgIwzli+VwPUpTyyQ8q4qlNNVNq0jqX64KJuGpHB2/AI5GQv5GkKqOhZmchq?=
 =?us-ascii?Q?21NbFKixqupo7x0KNjtwgw4JZuYFnZK3e+M98ML4eAWO1aHHO7OKFrTjSFvH?=
 =?us-ascii?Q?Mh50Jin7CME1o+sFhRNOayqQVENX3LQNr92N5WMEafO//HtujcUTsHUIY6Jb?=
 =?us-ascii?Q?88JWyvoILi/bNn018q/NcbslChBIHYsauUhy4XaoSmtciI1jL4/C8Qqnpn0N?=
 =?us-ascii?Q?IGHA1CinI1qxR3lvfQ8Y6fbUPWy/cB01kXLfkilA+BtBSrcI1Kr6+AbwjQVa?=
 =?us-ascii?Q?adIPHeNvk16ww4rbhsjgl8DK0t3P/XXeYv5o3qObGVeGXCva5ua8aQfdfTep?=
 =?us-ascii?Q?+8IhLbYJdiiS8tIBOBeROO1B+F4PcwlEjbXNx9oAI/xSWSdIPpusISVfZnEh?=
 =?us-ascii?Q?QDfG6wKMPQUxHnG6pCiMLQSbFOhiAGCptqy4GEtoepVfXQs3v2s1Jcj4SwjH?=
 =?us-ascii?Q?F1ngJQdjvEE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ajLOIt9bli0Mzd2g+LYxHKNxz6kjr9uT8IC9ILjtKHxS2P4cMcRGDVkKPWBJ?=
 =?us-ascii?Q?BAxU839s0cZJMytxWu1qhxsAkyboKuJDE4Z5ghXZKjArkqDoddYUvMTWBBF4?=
 =?us-ascii?Q?aLFNNHhb0HlXKtx9cHxgDWpFgG/A0u5551OcoOJF7vvhgj6mkDCdCCBWpcu2?=
 =?us-ascii?Q?PYAMWnCAQ4guzcThj7pT6fdxsNdTpjyfiWxY3x/dE//fGSp8MoOL0anN5e6J?=
 =?us-ascii?Q?Rr4/O6t9lo+IPgbj7KQWXUMY262nCtv87HPyBL5yds9l91st6zp/uzH9a2hh?=
 =?us-ascii?Q?8ttkVeOlnECVzMf1ebR/2UnI5duM2rBiCBgL5aOfMhgFNwyOBFJX1HGvByec?=
 =?us-ascii?Q?5Fm90ZFIIFucmlb64FqM06Pp6eHf9C9GlAU2kfXX6wddUR/leKE7/kSJdGIl?=
 =?us-ascii?Q?Zur7ZoYdN+iqPqBISZErUerw6/o7TMDOA4dtGbWza18kgHW0cmlamcynwlpN?=
 =?us-ascii?Q?c8mimnLMtelJfpMrYl6iywypejo3PweVACxUSQYttIvAv1aM41rMH3brXnvc?=
 =?us-ascii?Q?U5LRMcoS7RJ792UBYwUbjAx48puPRR8HslflVRTI58Skphi+49DdleeLtM9F?=
 =?us-ascii?Q?W4t+YlyEC5otV1+Yc2anDmborXlBGzP2yrRrV02CfKxm97qj5NdHHyomZWwb?=
 =?us-ascii?Q?/CLFazAvEJXgQTgsDF/TkXAryz4WTL1XDxci07BMv0rnGLVUvhJLslN/tsKS?=
 =?us-ascii?Q?I3YwWf+cT5djgxKdIfIMXT5XWT1goRtxSZopHa0tg+KzK7J0h8pU6ia0uLa6?=
 =?us-ascii?Q?UHZgnL1SE+auIb+rAcZlfKJ5mczvdGIyFLgRurRxrFtoZu24ln9nnpi38j2i?=
 =?us-ascii?Q?2+hZpTXgVZbNfShs/kI9gkcSKHwqDv9kDfuXX6/xUJn+qKjihRjEza4rV/mb?=
 =?us-ascii?Q?YBFJuiq7wn8ymfLMlzCzeAc3WSQc29QdnK2aHVw8HmkAxgbn6/XLWALG7e5e?=
 =?us-ascii?Q?qfviWzdfaAU9koW3Q403A0ABJaAoxOZfzvi17sFSqGSLlPH5iLcRYY8eyvIU?=
 =?us-ascii?Q?kc6dAR1RWfDigMjHT8Xh0ACfhs0P57KgFF+/FVZmof+7yNbNFlAhKQ3rwZHQ?=
 =?us-ascii?Q?a+7IoK0d/8PpCgRu+J/bogK3s8xuprCdsrKgcNs/h/ww1T/IRZCK44nQA+Q/?=
 =?us-ascii?Q?YChjuT82cM/bmY4k1uX0sOx13yeaQICtuLA9D6xfLln3bL18QL21JhyhQVh7?=
 =?us-ascii?Q?fg1LRgsd1XUEGFrcuIVAQKiL1kTswBt0+vFrrprp2Ln9DgaKZZxMqpemRQab?=
 =?us-ascii?Q?w9WCY5k8Wd9xWV1/XkFFjeLz0xF5MpvMpNThskRKrRFwvrPRYA166ZBTeX5p?=
 =?us-ascii?Q?gytprqHBKu/j4mzjAlZX1JobCCDTp/wqwAwa0lufWbFQJxHbl9IxRJQNxwxC?=
 =?us-ascii?Q?cc+7Kdfy1vrf6qlEgOb9YrLkqiMn36Mqqr017iVSm/goijXTRjshd5qwR5+G?=
 =?us-ascii?Q?1Y9sec39INAY7K3068YaNtLtNz6/A+GrKtQMdkelVjio29JJ5ATixpb00q+L?=
 =?us-ascii?Q?bKGBteubd766kTSbrkEtVeTtXmrGooriq4wn+UN8d6+9wwtCDyVcEQpA4SYL?=
 =?us-ascii?Q?vJEo7hEtITtF0d5EZ4qQXCXNJHwleR4sh3BJNeaax3F7LdaPeDw+ePrlhJ9X?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/DNQhYH+peqmCQibwdqPXFwJXx5s13eeB2HSqEtgNeqKyvbGhmZ/KoGJ314O70AzMNOIKTk48iIgC1EehL6D0BAwL3g08zy/kjZlj6JRmMJE48Hk4rcasKu61BHikJJpkXWmQFns62Z582L7pB5WsgTbyo2oUoda4mQc9pInNxn8LZf0ZWsAcKegv+TxnEdDIXpg4M3R6MtDaX5ccnP6ictcwTSzKxp7d3mE2ZZzgPRc3QdRPDdZggvMpfyG1yXFLYissXIFujjHfOk6enmFtDfwXTxTMZa41IEK5N+Z5H8sxxmIsP6F/9EJaSYhM1RirLrG34K8nUdqU6SVPS6fv48ZKuu9v2bZh/YStiuPNOhtihX98XJTCT/GltqQgetJTjKxT11E61mmvFhyHeEFRB669hJ0m0PwJkyhXlGxIkSMbK5ohudT7xY7YkYrKrLwtNMfj87zqvp4EpDqhLt0uZbnHpq+Kkdna8Q7q7mIufONL+wMEMlj9MZYD9MHzHjOXWrQAyMMskZ9pH24ShNqC/mrc//CoPtzd5E05GEWk+fv8r9Qzqwv/Qd3HvmknUgY8lidugc4ZULZ6XUWeWKV2tD86g4ns4YKpTc9gGoLjic=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ccac99-c2b3-4155-4881-08ddc2edc992
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:47:50.2225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZyKeiRGVHxZfGhpRb4bjh1BaOy+mfi9aZlt6Zw+h3MEWRAQsyyc0ihhTrPKjzpbBpHaDaGk0V42iXBjzgGbC84+0VX7CGKBnUlKVlvUtiOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7582
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=910 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140095
X-Proofpoint-ORIG-GUID: 5zjkUZwWcTcb_5639w8TsWYY_YzKOqGN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5NCBTYWx0ZWRfX0UiDVgu4damB uyyt4HkjDhhN92nTGjd+IeWKND8GHe6XfTZoJa+WDEgiwnZZIO5jOKVBRiKbAgnQR/GqVgU9GVz 8Efo8rKQrU6XLZUVDyQjv8dTqLz2bIROrYUuuPiY5jEfGLdd0j1FF2kJXmv4gTvbr+XQEn3V+Hc
 aY3aoECHSpSUCW6dgINDaft99FYv2bbSP23i5vqNjX2chgecLglhaToUNJEufcXM8sxiyJooIF1 LAWaCf1CJatmFB/KnLpERUV3Vo+HxmOXD4hNSWgQ8ENo0BlmjS6tXH4ZeOQgbGdRZFoJS8NVP+1 huXEFZkmGthkCDI0F7sQFNK0D6wZ43GZao4dXlbtOYs2g/eQi0ziW/9NeswNd99VZ2ntaNXHAIj
 JqLxwnqRhAu7aFU5Qw+weF4Ktj6mn3UpRRwhQ7V6HTrVb4X8wfnDptBGpQ18fyHeeTfJnKIC
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=687526c2 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Q45CC5q2eSKL1uJXxCEA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600
X-Proofpoint-GUID: 5zjkUZwWcTcb_5639w8TsWYY_YzKOqGN

On Mon, Jul 14, 2025 at 11:43:57AM -0400, Liam R. Howlett wrote:
> Yes, but the existence of a function legitimizes their thought prior to
> sending it for review.  That is, seeing a function that already does it
> makes okay to include the option in the planning.

True.

OK, based on what you're saying and what Pedro's saying, next respin/fixpatch
I"ll put this in mseal.c as a static function, even if it makes me cringe a bit
to do it.

And then Pedro can remove it in his series :)

For the record I don't agree with this check being performed... it seems silly
to me.

