Return-Path: <linux-kernel+bounces-863344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC6EBF7991
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9B6518893D2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB6130F7F7;
	Tue, 21 Oct 2025 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ig2Rghmz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ODcf9/uj"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7671DFF7
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761063043; cv=fail; b=oLZJRWcUIZhwTMavfqkkW6DYst/1I6tB97D+NC+6aaMCDG0WgcVKQIFexR1l8v/RXSshQcAu1gY/3nlMqPrKOMBELseBnJzr8aX6h/+rTPe0CdoylXtlnvnoPHayg9LrPgKLYTihCcuMB5/me+j8CShp9qNFSTpBc3n95x9UAlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761063043; c=relaxed/simple;
	bh=IfHmIuVXkuFswkaoVsR/hBDjTvOmGTNUsSkB671fvVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MFCo/Gf0xGAHx4vDV6ZSQAWKQYWUD7qDL4R3aIhoAcuHvwBPXWFaXz0TLp+QYdAffQu/d7rd4QpmsPl/GIZkssHZKvNX/44KOnH9KElZkYAu/WkcuwK6PDp9ocNs3wQligolrA9+z2r5aouM2hxXu+Mw7r+uQD0D85emoOrstwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ig2Rghmz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ODcf9/uj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LEJ6L8031112;
	Tue, 21 Oct 2025 16:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=0OzXMbgNGTS+jVI1pj
	UJL9hGyGw6Q/XMHk/Ap2Oog7s=; b=Ig2Rghmzu2pRFYogQYwuGY2HIcyckPcirA
	k6DLFKNCK7nsfMkTuWoRntDZ54zabEnQ+MM5Pzu3AvzAgSRSeFc4EjjYKE142Nj/
	9Dh10eJcYZkUdOH9VgpfkIQQUoicN2YIxbfuBfMAOlTLzSSxujqU3s//L1fwnodb
	adWhTY45UXSB+dZf6UY2hrmnV1fj4kkVq0Cp0Bt1W+FaMadq95Sq/TgVbljTEd5T
	EGiN3s2kckiLmJsNGeBMqMnVTmCPl0zTXGJpNmePY8MK3qNBd6QhlCrkc1/2Ps31
	8BniN3nMG2yVvKFcfEMhjSdYxlhA/rIuUcDlqOCjUFaEMthtXr3Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2ypwwnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 16:10:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59LFOOsg032277;
	Tue, 21 Oct 2025 16:10:20 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013047.outbound.protection.outlook.com [40.93.196.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bd2mwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 16:10:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/dIO618y8oY16TDx7YV9GH+rq0HdrHmzo41R8qmRf7HsCVPNGEahe8cMrq9Mp843sc8PreF7cm/W2D09gHOCZGFGvWuQqFGigkYFjyBED5e+VtCdQznGAGlcPP9HaTTbwZnkMa3YIZYuWFkgcUutSEllykPk0A36wfUZDOpqhloKhsV+8KHW06XEdXc+bNF1JUC8dAopP26CcZV1JjNCq1R1nIJ22iPUahlNxEnqdWXx9dvCnnB2F9kLZtAdf9XdMgxp5HH1FluS1EHhTygOkMgfzwCc0P1F2VkCsmXhPskkaL+BtUnA8/IOTRnmGgwJh9Nf7iQlJlpnZ3iL+3/Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OzXMbgNGTS+jVI1pjUJL9hGyGw6Q/XMHk/Ap2Oog7s=;
 b=CxvleoU276bxFyBnkub/dTULXxAiJ5SYoOon3GSX+vRxz6JIVPYkvZWtnu29gytJZtoitV92bDcF5swxFXPBfEc4nSMMV0s/WK4kS4qhZ5sqAYk99WSoiJke8cp93h8D9EH3fKc20cQsvdN7TVCy2/AR626lT2pY8jJRGNkHfjFMkYz/wF2/Fco88smyqkvrpGLbXA+XRmaroej2QHra34bi47tISkmp8uBYCr7PVSy5kJwIK+fJk5s0qvz9fHyKQjPKejZbsUW6ubItKyaabspfQJP5SuAu17I7PkPWKTEQMZzTAXfM9LUk9MtlFJwRiDejpNuQaFJCUsOfEcIoNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OzXMbgNGTS+jVI1pjUJL9hGyGw6Q/XMHk/Ap2Oog7s=;
 b=ODcf9/uj9ZjnXDeqnBPumCVZJ2FeRQYUgBV5kRiatTZunkgSKNIJmkV4wzcY3pyB6kOuZn//y/w8CyvWtCidxSKgkR0XcUKAQPNjKsL6WD4pbGEkkTJ7d91pixXpcEBhpGLFUEaK3Kd5arAGfypdPfqy0+AoipFZb53EQd/QyOA=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DM4PR10MB6253.namprd10.prod.outlook.com (2603:10b6:8:b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Tue, 21 Oct
 2025 16:10:17 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%7]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 16:10:17 +0000
Date: Tue, 21 Oct 2025 12:10:14 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
        rppt@kernel.org, surenb@google.com, mhocko@suse.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jinnasujing@gmail.com
Subject: Re: [PATCH] mm/vmstat: Fix indentation in fold_diff function.
Message-ID: <bx5zarozwnlogznjai2242und55z5jxs4bpgliswuo7shezbma@ri2ocyj7n4q7>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org, david@redhat.com, 
	lorenzo.stoakes@oracle.com, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, jinnasujing@gmail.com
References: <aPc4I/8zXCGyiapN@pilot-ThinkCentre-M930t-N000>
 <b0c6c6d7-843a-48e9-bafc-f2595b059d32@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0c6c6d7-843a-48e9-bafc-f2595b059d32@suse.cz>
User-Agent: NeoMutt/20250905
X-ClientProxiedBy: YT2PR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::27) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DM4PR10MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e6856dc-1321-4dec-b461-08de10bc535c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AurcXEfbT8Yub3NUrWe5ZhpUsSMk43aRNOvXtVB1KCTmD72JiU1HvpWUh8yc?=
 =?us-ascii?Q?+Xo5IvfquoiLd7398M2t/1oMqapYQEUpifaRL1kZkEdf0TqKdr1NFsegRkvT?=
 =?us-ascii?Q?tIO2LuUm0TOrRBg9DXRzUr+Hvub5xWUrf0Gc3Q7PVo3amJoSPVHXWyywzi/X?=
 =?us-ascii?Q?S9QrLZwvaX78cYMNdXdWM92IBWou0iVNVh0h82egbjUOj6VWj/PJw4tVLJaW?=
 =?us-ascii?Q?BhrPGZamNdmwYI0HA5capf/GBfmEmWFEmeBnHmJERcjMfPj6chiHk2Ze7XGD?=
 =?us-ascii?Q?TMNTamRZ4MuxrJ0ROUpAMVah2nBJOJLs7vlucjZlzwFA3vmyfVYdtSgGP/n/?=
 =?us-ascii?Q?1zqXmjfT4qbFPu7i+KlpJpDSRECYmry/+wKSIasPoLoXO2z9A+IjEZeliw+2?=
 =?us-ascii?Q?t/KP8pVrqxSC0NYP8IYdQFWxmsV81B/IRQL3Wf35PEf6SJn9Mcq+ReW7EJMw?=
 =?us-ascii?Q?C0+/BJtFIOJ1YBpzkFM+oh0WboOzy9uoyx3ODQa2zTz6mONlgxJxDLkkXSI0?=
 =?us-ascii?Q?+//FQ5ouda3Pm37cWLEbMXHaXTLqIlR0s6eK3R8peKNH35soG+el4N5Q+gwI?=
 =?us-ascii?Q?mPOjqx9vThvU3ASkwuxSgi41YJQn7gQLiTvirLRtdS1u8IsiNlp9hDkosZIq?=
 =?us-ascii?Q?uGJYWe7qEhcF2Mj8sIR8O7TcMuIohN0YJBBFAdsOQYs5hUQh9gkGcju3FS6b?=
 =?us-ascii?Q?ygxlNxVh2VT5xkrdV5QawrXZ7tvY8XxInaI4eo4HzCvHY8tFaZioMfJYYEu6?=
 =?us-ascii?Q?hkPy7X2EG8m24mvGU3dN71N0tLnriT1HLH1Gdgh0X4sFcT+TLLvENrqgxFKC?=
 =?us-ascii?Q?ZxLrvlknTHTYO6NckYS7399Jfknl9D9bc+czxFTGbQ2GpXtYRk+92N2afGp4?=
 =?us-ascii?Q?KiW5MK3T99yrmBLWDaTwUEuy6llKjC1uRCtlQFhlyfCFUOOFiehTTinu7H7I?=
 =?us-ascii?Q?aLag/DYAkqbnHcJFI8L9teCSgpkw5ppgjqts0ut5ITGr17p7p5Ze/G5cz1et?=
 =?us-ascii?Q?ko+lo3iGGfrUOn3urM+bbrOEx1QvZ43m4Lxm8N9RNSbH+G2y8K0ehLZyA80k?=
 =?us-ascii?Q?D+LGACkLB7rsWg6ov6nR9CnRc4+9br4mzjTquP85sLkqmx1t47rlbOUiBjJh?=
 =?us-ascii?Q?hpZdIGoMvzjrN9B0c3gWmO0rgCY5ybP8T7neFGZbltZanwdndsxqHjN1nx9Y?=
 =?us-ascii?Q?8C7AK14WiK6kEXebVpcinf3CLN108/S0l6AzCnoBUfFW48m2CA0S1IY6KtsE?=
 =?us-ascii?Q?D58e9kIDvzy9YRN69LS0TWttTEFKZzV/lrHLGEm/RIEBBqvI2L6dlKHudfJn?=
 =?us-ascii?Q?1n/Uo3Jx90DKXQMRwphbKDPt9R0FmyhT0+jO/EHl+d95S5ofSbQhspDLbQsQ?=
 =?us-ascii?Q?NvHOEezL1F/vygzQ0bhN3LkkH/dau8jES8t3hmylYIi3+wxPX1OUIhWSR7Nx?=
 =?us-ascii?Q?iAxpdPLIzsJ9j7SvXEz3oNbIsFdRw0AH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CmpHzw8FRAl2gbQWXRUiRAsS3BJSVM+DjXVZwtMN9lO5Uabu/Opr5HeBS1IB?=
 =?us-ascii?Q?JCCU9SkaYLCYxz5jxZNlXxZ4wC86H2YTxxxAUs1XO8C8iyummxUstz7uoi+5?=
 =?us-ascii?Q?t5kDz1cqO5rWqT5DgiJTgUSFEI9wKyr+RKzbGOgBcI7g6zEUdzhZYQXkWVta?=
 =?us-ascii?Q?VWAgReDozQuvKmhm4S1zi94pVlDIANmrx2gdxHGzgZhn6tsMIp+diURTKQt7?=
 =?us-ascii?Q?FfZ38VnI66wBJxsLnGfuFHFXbROQnVgNa2MBYwyl2CcbnF/Fhwpm1is6KFJw?=
 =?us-ascii?Q?kAT/it8gNlxgxi5dMEDt/+eDiSKWpJ9A4ZAukgiFuM3a77QDtmPzguAk5uls?=
 =?us-ascii?Q?Ayks7444S57AgXiavbNsE+B6CdgqvfxP2+PlyugHsQ3WWL7op4ueeoDMKR8E?=
 =?us-ascii?Q?erKxdISU0MiTYu4cr9IGCJEFsulig8i+wa3mjwK9YEcnSd+6IhKws7NEAHyH?=
 =?us-ascii?Q?oex1rmOWvgOCZ52ScgVl5jdA8seJgUTeDMp/Gs6wYYytk6Jz8quIcdHFpe2a?=
 =?us-ascii?Q?UpS145VUTQXUN6aGqXoxpKN7VE10itErUFXESK71Frl7ps5I02N48p6PHoCR?=
 =?us-ascii?Q?7haRRPwfahIfVh/Wtf7sMr6HtYeozUvXGoZ+flZouPxKIhRZbunVFNSTwhSb?=
 =?us-ascii?Q?SS0W4JPLJddnvJq3qA8VO1bdv/J2EntYXOIVJOZO0mEQBpakSsA3K9IOZwEG?=
 =?us-ascii?Q?QHHFJUtdaxE/HUxCzpFTLowFsLdq282UL2yZ5qa4lyTOIpoYwdN7WvsaF7CL?=
 =?us-ascii?Q?fYylRKqg0g1FYdmLJmQuvGtrLKSP4hTCmJMeMZbnRU9c3plIccHPcLtXQi3W?=
 =?us-ascii?Q?xn0oE7rPD9ONcYqHwBBQGT373oM3h8fBtaXAQBoKDNKrRCJb/RTA18jd+Q0D?=
 =?us-ascii?Q?nIWRlCVtiiSqjA9tEPc/Q5JnFz1BQwQXVF7t094f8j5Him7WHxEbg8oX0neu?=
 =?us-ascii?Q?tAfJNXRAvjkDXG+iVgB1tS2ZIxvekDMswZgT/Ji8xpZZQ/DYIrEua/AtiSbN?=
 =?us-ascii?Q?zPHsZUIMicPxmABo1jP0QQ+M0yZ1upXIxPVpegSRiJGt/lAOkR3Xs6kB+l0t?=
 =?us-ascii?Q?HWwf+6/YH9qBjYgUHV8+8g0vSAzUo0FzJoipNx0nxAcEKsDKDh1OWW0Qu2Ab?=
 =?us-ascii?Q?J5q3j2/1Ruaoz25z+2BdfUe1BYizrj5evQ/TlBCqjx5WwY4ee6tKhwshWome?=
 =?us-ascii?Q?/pUtYMnacEt8djTxwEz823EZlFE9HoXwNoLTrOkVNaHxhmyMVygQJZeWPApL?=
 =?us-ascii?Q?ZSSevUHrxnMPa9W3BYHJBKbR3pnYWbCn9pEitt0+3U0WdUwPGCYQZxBIKWQQ?=
 =?us-ascii?Q?bJ57AY4pVc3GHsY34tAbFwoMNRF3hCBk3qqm0BOV+Dxxy+Fq437AyG8iUqHC?=
 =?us-ascii?Q?9bpDBUUH17CVt3tqhNphaYLeHa6XVScp1D/ndi7Ma+SqJv904tBRLk7+fllY?=
 =?us-ascii?Q?ZvdqIP59QdfjWdJFu+7KXeAMXRIbOyiihOU7km6mX5Kr6MEW9eu/nNcPL64o?=
 =?us-ascii?Q?YyOYmpuz7hyMMUCmB2+2KklBQIgzt/86AFYOVAUlMoQlFPMB7YDyAQLlPdqM?=
 =?us-ascii?Q?/KiIQLzMK2rnf5Ox6pQNLa35j9VMqow3jh+xhsaa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	etnGLTgwGzEur0YIZ29a00bShQB+ZjiyASeQ6UyopC/pmkJsgbmW4VUjm634aTdPcvZs7usuQBU75C+vhGM6FHZjjXzhiS3px0N0xR0ZnMfdqk45Z7LxV0xDA5eoTORn+6+e6OcVT0OtQ4hyNDSKh88+QcJ/ICNAr0PhmaA87+FI9mfRBfjIH2NuFn/0ZWbj30K6Ozphc4jqtmwCWwSV/sJ1Y0w8mg8YdyPzU8wrvmVsnFFYmcp7z6HQGAZHtRFWEzGylM7HJXEhWppqd+uhRkU+PtOetf4LXPfH4mjk/9y/2Np+j0zk9IX9Xb3dob4vU2dc8ywXq0KxjxkgalMTaeKsOp/q4ZoSPtK+8LsWAmYLYOsmEAYVa86a+RKqFsW/g40DwvUnr2MdFzVOorFzAsxka3MWTBkI1pShfOxUt4rIPal+iZS+xYk11nTm/MtNOTQIf57Mje6uU/BQkb93MnBpHKq+05Na+aKgkQEMptChh8FsQJ9hnUgTNUHzB9cw6NKsKmx8e5j324cXLEUlPJXEBeZ5SBnae+X+uvrHKikzjZpLtEFzU2sSPS1AGc9yYJlpcO9xtfSUUJ5sh0vomwAkSgUimTMO/NWb0S4tGsU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6856dc-1321-4dec-b461-08de10bc535c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 16:10:17.3638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcq8J7ZDaTcMfaf8ygFGiw9zEOWAsijqGU5TuxwmEwbdEghYznPBogIhNQ7qGmoJ4tjYARZhHN/tyci2Du2bNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6253
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=854
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510210127
X-Proofpoint-GUID: hkoNIDE0ZKtEh4GjErlFMk65T3Yr6I90
X-Proofpoint-ORIG-GUID: hkoNIDE0ZKtEh4GjErlFMk65T3Yr6I90
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX8JvIwgtLfvRj
 RyvAAdsJLqVJv8Ap2ZAm+JxkTCwaxwS8cXHmEh8JZdk8K35Nf5Fq38Ig3UlvX4cf3SiMUEJA5ah
 srqszD84kvInhPH3BZtxevP4/878uOZ8WD9QMzsY0XWfUP4x2ZW9inTX+EgCfdrROkoIw+vVYdL
 qIwl0+m9djcVw9D7rQvvUkJXApbn5BI6b9T9QWQYv00Nzpjh2kNulsL/F46d4h4LtjGZrvNHtXP
 0kY20pi6BqbS/hVNG1QBfX9bEWQf/Ssld9TxTOBZn85qjNAPQPs2xlagSELJZ+KYUMd7rFw/F15
 gvrQGxBkd80/oJG8nZxnSllOtXSBk+3qRBWB4+SVq9CYZgi5fJXkZlweuCuYUQXdl423t3Co8SI
 lmI7VxuzUBohrzgUqgnXHf8GVteWAhKNZ/s7IouLz/Cu2NrQu8E=
X-Authority-Analysis: v=2.4 cv=Nu7cssdJ c=1 sm=1 tr=0 ts=68f7b06d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=DyMV3BnNAAAA:8 a=WNATdb9X_FuPhw2xLy8A:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:13624

* Vlastimil Babka <vbabka@suse.cz> [251021 05:03]:
> On 10/21/25 09:37, Jing Su wrote:
> > Adjust misaligned braces in the fold_diff function to improve
> > code readability and maintain consistent coding style.
> > 
> > Signed-off-by: Jing Su <jingsusu@didiglobal.com>
> > ---
> >  mm/vmstat.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > index bb09c032eecf..63860c3d22e6 100644
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -782,13 +782,13 @@ static int fold_diff(int *zone_diff, int *node_diff)
> >  		if (zone_diff[i]) {
> >  			atomic_long_add(zone_diff[i], &vm_zone_stat[i]);
> >  			changes++;
> > -	}
> > +		}
> >  
> >  	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> >  		if (node_diff[i]) {
> >  			atomic_long_add(node_diff[i], &vm_node_stat[i]);
> >  			changes++;
> > -	}
> > +		}
> >  	return changes;
> >  }
> 
> Thanks. IMHO it would be even more readable if the for () also had {
> }brackets.

Yes, I agree.  That's probably how this happened in the first place.



