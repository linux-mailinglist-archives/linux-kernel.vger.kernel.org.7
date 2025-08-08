Return-Path: <linux-kernel+bounces-760041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29069B1E5E5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9D14188FB21
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDF626FA62;
	Fri,  8 Aug 2025 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="n4eHOXli";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="dHHQzbqK"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9503020C010;
	Fri,  8 Aug 2025 09:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754646429; cv=fail; b=lKH020iminqxitd2cK4HKA5iJGOjR7Oj7F8lCMuE2DBbSFuY9wqKzH8zBv12GTn9j5+r3kCKdi3rdLmZ1qxAfnzjwz4UVCv6r0KwoKEj1ifjpMpG5nWEBCipZSPJoGrTC3OMrCu5CXU1msnUn2CmGqHS0f4KUeftLZISGJvl9D4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754646429; c=relaxed/simple;
	bh=TPDFP1Iy1THpIb/cwaw19qVquZtjodoLKstoKYWkOUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOaLGFfSCueHeQm5xRuBTtN/S2R8fz7zbOBxD74PdfsH2yYRs61wMCRIqcLnmxWZgeBzzO5tEww7BePn919e18LNthESpnFiwtHjUYGbqxKMvXdCYdp3hV2nt9aoyoO1+gfN3a4cLyk0T2tt8pUqB5qlX1NX9eTFc/6NHxbn1DI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=n4eHOXli; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=dHHQzbqK; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5786gO4L009047;
	Fri, 8 Aug 2025 04:46:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=FKYxly8bb1ggq6E5dNG96VzZlA5GKZkJNWtVE6aqZu0=; b=
	n4eHOXlimU/SRKUaimePp1dZOUaOlqWOc1sY+vHUxSfKbgwuCjApaN+TloG02psd
	M+Jr6Cd8bMdvGHX10jzM0KsDstFEXkJ4qELlg5VQDUwt5/yCZfxTaAOWmx/hBYbR
	/6NeBydUxo4HntlSYRMtN398kt+0SqGH25lSm/SOiLuj6krvOlKnJbmMeaV6b1Vv
	Zq8YNO/2gz47OOZ54ekUBI5NI+J8EbOhjt5UpT/sKl1En7uvPP0OjqmizwgTHaAr
	2EppVpfJBAaX+C+z6YA2dGF7QDrcCoiH3GgMWJK1M71TILQ0BKF+eVKciyZ5mdHv
	CtGWLaGpQJRit3Do1CEjxA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2136.outbound.protection.outlook.com [40.107.236.136])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 48bpw9m97a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 04:46:43 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJRzxYrALXDxF5EZXAendmvSTePSJ9CgaPZWlvbORybpkio1AsKxrebcMfjd124w9bPyppW0l9R6NGmmblP7JR+VcJMOKvWZ1yS/Y7T6AJWC+4dcQ1dsqSO69coUSWc0JcjDEiHZmfMMne+xAECHPBcbDVTxJ3Gzjjt4NrbExnMQ6CSiis3a39P67956mio1TFvRvSYqnrLHsh0CtZzIb2ozj5vN0O6/ZDaZFLcx+ElWsP9MfcQC+vurQlg/lP5vmM9pvKC6yUKrayz6/gXmn2GUaVy7xJhkd8nuN1SbSQw/7aeOPFifyn/6NG4NSPQiQYUTWQi5xJz6gM+RBuOwog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKYxly8bb1ggq6E5dNG96VzZlA5GKZkJNWtVE6aqZu0=;
 b=FXv+rbmo5qGHw5RmskD/MwONLDCrOI2zFy5lGg/HPs2/FQJmjWi7lp4QewR0yqvB5cF1AT3G0Xt9bmD0cuzlu7G91+htL/qsnlO3ZRGP9Ezkvjs8565U98din2VvHvbRUkOPSGeWDO58fwFUrrfn0eIieeqIt2CvcN6Sk0DakHvAwtMgZHsKchPUhksBzYHI2iwMVF8pn4hrENotFYbAAoFsR0fts/C395hdnYUn4a82tP/YrT/qLzeIMk3q8yrcsiUGQ8SO9FHrRd471MzV7rZYV5jUV2cEA5C+r/0YTsT7754Xr9B9P0c3JpjCjHbHt+uw9fXyeXR0X4kFSzNEhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKYxly8bb1ggq6E5dNG96VzZlA5GKZkJNWtVE6aqZu0=;
 b=dHHQzbqKhoppAXrxnCM0EnQWHW/qZdoPQTlAp83fkKRSXFfpi0BHa5434izV6lb2p6EOvbKp/I6hhGcPDpRau6nAT8dNJYMV62J39a30Zk0o6rsSNmCY/QUsLJV+Mb9T2g77P3BBikzwmkhoUl5ji9LfV4LBZxv6YFP63lya6f8=
Received: from MW2PR16CA0023.namprd16.prod.outlook.com (2603:10b6:907::36) by
 BY5PR19MB4066.namprd19.prod.outlook.com (2603:10b6:a03:225::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 09:46:39 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:907:0:cafe::92) by MW2PR16CA0023.outlook.office365.com
 (2603:10b6:907::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.16 via Frontend Transport; Fri,
 8 Aug 2025 09:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8
 via Frontend Transport; Fri, 8 Aug 2025 09:46:37 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 0D11B406565;
	Fri,  8 Aug 2025 09:46:36 +0000 (UTC)
Received: from [198.90.208.24] (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id E20DC820249;
	Fri,  8 Aug 2025 09:46:35 +0000 (UTC)
Message-ID: <c29fa4d5-ccf7-4143-961c-a2018b9aa25c@opensource.cirrus.com>
Date: Fri, 8 Aug 2025 10:46:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: cs48l32: Use PTR_ERR_OR_ZERO() to simplify code
To: Xichao Zhao <zhao.xichao@vivo.com>, david.rhodes@cirrus.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc: linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
References: <20250805090431.117114-1-zhao.xichao@vivo.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20250805090431.117114-1-zhao.xichao@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|BY5PR19MB4066:EE_
X-MS-Office365-Filtering-Correlation-Id: 95efacf3-483a-4c57-854e-08ddd660786f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yk81MGplWm82dDI4TWhKUE1KVVVxcjhKVml6MWdKcERTQ3pnZWtidWZLZzVv?=
 =?utf-8?B?b29SM21UdVZBN1JTMlB2WGtaNXhZY0FpZlZBbjhueUVjeTNRbFZWRWREcGxD?=
 =?utf-8?B?bjZ5OGdkbG8ySDJRTnNwOTZQN2FMRVVONVd3VGl4U2FPUkdGWSs4bGdVeUd1?=
 =?utf-8?B?TG03aWVXdXpqTWg5RGVzcTI5VmhwSlh3WG9QeFVnZHhEZWNDUFBhalpXWGVK?=
 =?utf-8?B?UjdiU3N6bUpFdTlGbmJFVzlGWVpLV3BNZ2VMNHA1YTVxWmxPbUNROGl5MVJh?=
 =?utf-8?B?SzNPTHBnRUxtYTVZN1JYM1MxV3ZrZERDeXprVVlpYWMwMWtrcjVZWmE5U2hW?=
 =?utf-8?B?MW96NDF6cnp2eDVTSkVTZ2J1ODZ6bHIxMU5mQUIxdXRkWVo1akZnOGtLK0Ro?=
 =?utf-8?B?aVNuRGhPZGlyU21mdm1QcUlCVGZDNlQ4Y3ZCZ01sMFV6ZjFGNkRGK3pnV3Zt?=
 =?utf-8?B?R2lOcVY5NTNGVWpLa0thdUhhaHhvRVRFYUJZWEt2bmNEemVoT1M4YzBMYW5n?=
 =?utf-8?B?TStyYm9zZE5nRzJTeHVOUzExUmg0MGNqRjRkS0x6YVh4Q1JJQktRc256T0Nn?=
 =?utf-8?B?WTEvYnpYR1ZxNjU0ZlBNRUdHQXlZTzNYbUNmL2VyNWtMRDcrQXQ0ZTBwRFps?=
 =?utf-8?B?VWNEYzFCUVJrdllISGdFYkN5VnFNUUJMTnBXdW55cWFGaXdBNmQ0cW54ampZ?=
 =?utf-8?B?d1p2WGIyNERlM21ZK294L0sycGVpTVphbDFMZ3JxR2lmUUN1dUptMmJQU2xQ?=
 =?utf-8?B?S2czcXJZWjJJZXY3TlVRR1BickxUWTBJRG1ZTkNYUGt3Q28xZUR4ZUxIYnFo?=
 =?utf-8?B?ZGZRK2V4S2U2VUxrckkyaUZCTnJEeVM4N1FXK0lNeUppVVBKdEd6SERYeHBR?=
 =?utf-8?B?NGxZVUpuVmFpUHd0QzJNU1A1Z3hVdUp0cDFHWE5zV2tzN3lrZ0IyMHoyUXNJ?=
 =?utf-8?B?QThsWlJ3eURXOW5vbjRNUnliZHF0WFR6MUhleHAwbjR6NnJIRXM2RHQ0QU8y?=
 =?utf-8?B?R2xtOXNNQ2FDOGxvcHpFcWppMDdkZ2Rac0ZZNksxV0pjcStVa2ZNbyttdllr?=
 =?utf-8?B?cnBoOVVMN2I1ZyttczNEWnhnaU5leFZXMWhJQ0l3VGJFdE4xem1VQXlWeFZr?=
 =?utf-8?B?TFp5V2ttR3lVNGlsM1hkWjFLd2w0bDNOc0k2YmZYM3JQY052NWsvS2F6K3pz?=
 =?utf-8?B?YkVZU2IzcFNJRTNPaVVLNld3NjMwaDJsRC96ckZid2MzY01rSy93VGtrWUdp?=
 =?utf-8?B?MWZ6YzJlNlNYWWdKWmJERUJINmd5SW1GTmh1d0F5dWhrTzJoeEo1Q0JkcThF?=
 =?utf-8?B?OTNjd3ZhRUJLVkFoMkJLQ0Zib29LTXpZRVVxQ3VhWS8vYVVmbUM5bXVNWmsw?=
 =?utf-8?B?YkY1dTRwVlJVNlF6dDM3a0EvZzFwd0FQSFhQdXJ4TEk5bzhhMU9MME14NVUz?=
 =?utf-8?B?QzdHOVpFeEZiVjk3SHBuY2lkU0g1SXBleTV3OW9nYzBUVUd2YTNmcCsyT1pW?=
 =?utf-8?B?RmQyY05hVStLVEFwYit2Z2dkc3pEOTF1REhNb1RyTmdIT2lURjBlTWRhTEFS?=
 =?utf-8?B?WndkL1Y2YWFLT2ozb2NoczU2alNORCtYekwrdTRJMXRjbEloakxjMUlrK1Jn?=
 =?utf-8?B?OHRFcjd6S1pnWEM5Nkx6bURQRnpkbUs3Wjl3S095U3RLUUxHZXpiWW02Qm52?=
 =?utf-8?B?NUU5Qm1QWkIyMFNNYlM2YmJWK1VDSXdUT3ozbG9xK0crQnYvV3pjRUozd0xy?=
 =?utf-8?B?dnUyZUg3RjZubXlJbVlyamtkL2RTTi92THlxeXBsZ3BoZE84d3lqY2xQNHhJ?=
 =?utf-8?B?MVVZaWpONE1QLzh6R2xJNFFlK0xLdE92Z2J3SENMVjNMT1ZtOGU2amowdS9v?=
 =?utf-8?B?TkdySGF1b1BGcUpCOURCK1FUblUraDhBQmdDQ05oazdwbmIrUzRTMnQ2Smsy?=
 =?utf-8?B?cGd1dndpb2QrWEFGc3BQckVLR0pYdEtHYktlZDhVd0p0WXRMM002MWlpY3FX?=
 =?utf-8?B?dENQV0h4ZjAvWUVlZFEvK1FNbTJJLzlSY0o2L1NBOGdhOHY0bmgyUjk2bFJz?=
 =?utf-8?Q?nmwpms?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 09:46:37.8855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95efacf3-483a-4c57-854e-08ddd660786f
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB4066
X-Authority-Analysis: v=2.4 cv=HfUUTjE8 c=1 sm=1 tr=0 ts=6895c783 cx=c_pps a=DHuqkZ/VLdBH1VweqxBGCQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=1WtWmnkvAAAA:8 a=w1d2syhTAAAA:8 a=SBAotoejIjBNO3Ghu80A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: KrwxFYnjfa6G1ipGy6VB6pXnXWeZoQmL
X-Proofpoint-ORIG-GUID: KrwxFYnjfa6G1ipGy6VB6pXnXWeZoQmL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEyNyBTYWx0ZWRfX84M5pwBtr46x OKk0uwA6RarVr6M1BwnNGfCMaVYjHuwkz7pa2GIxWxXxrg96uVHnxjGHLjFtCb7N4q/QB8Vpr9J yU5iZYYv//As56bnIkxmfPTwRKPl20uPSF7hL8BrAG58h0VguIMktXKYFrqDV53kKPLqptnjwFY
 1tRedm0zi4b9Kel1zF11wkJX/rsAldsHYWhz/ZYBKsGzYiGqJUd7ZmRxmOAH7wYWa2xjIU3TFVl juyl4Vc6vwYspPlek3X8hDV7Cx9ABd4Samth3FwGPJhqCEFdIYnzlzJSw/VlQTxVn8Akr59Ug+d xXNt/m3j35N47ll0aupJnkurayl5BbmBPXju7MEeI8Fk74sugELLgNwBnQrh3rwCHcbbFVvLzAG VJP9HgnC
X-Proofpoint-Spam-Reason: safe

On 05/08/2025 10:04 am, Xichao Zhao wrote:
> Use the standard error pointer macro to shorten the code and simplify.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>   sound/soc/codecs/cs48l32-tables.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/cs48l32-tables.c b/sound/soc/codecs/cs48l32-tables.c
> index 59eaa9a5029f..8ff3652a010e 100644
> --- a/sound/soc/codecs/cs48l32-tables.c
> +++ b/sound/soc/codecs/cs48l32-tables.c
> @@ -533,8 +533,6 @@ static const struct regmap_config cs48l32_regmap = {
>   int cs48l32_create_regmap(struct spi_device *spi, struct cs48l32 *cs48l32)
>   {
>   	cs48l32->regmap = devm_regmap_init_spi(spi, &cs48l32_regmap);
> -	if (IS_ERR(cs48l32->regmap))
> -		return PTR_ERR(cs48l32->regmap);
>   
> -	return 0;
> +	return PTR_ERR_OR_ZERO(cs48l32->regmap);
>   }
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>

