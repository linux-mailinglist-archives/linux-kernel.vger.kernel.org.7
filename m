Return-Path: <linux-kernel+bounces-888646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A42C3B7CC
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F13885082E4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAAF302168;
	Thu,  6 Nov 2025 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YMFdkvHk"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazhn15010016.outbound.protection.outlook.com [52.102.139.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D503F30215F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.139.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436960; cv=fail; b=sU4XbFjy8wFHYF8/rAR3d12YjElfMTRU5VN8qUkX0uSVrYTgL3XF1LEhgJFyiXYqPw4DrIumc2fCaBr4HHZW3O0N/owncYb1r4b4V9QmZyIPui8toHYnlCurrlYVkRpxAaJDxHT+Cz7olzisD/4U0Y2prMiJTpgwNDOQ5IjUFAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436960; c=relaxed/simple;
	bh=c/uEWT1vD5XEYZ6mx3ebebGYScfOSbPopJdgMEoA5UU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1iFvqZ6MoDewiwiNXXsF9Q3Be2poywFn+wxdGOcmq8L5tucQrsUP5l2k+KBJrnIJQCr47i0hjImZczImA1goxsQjqy4PYgyfjeykPObZvyxGpPXtLwDtVci0DgEeIXT4nGAzbDoOwLWlOn5nDvc1wNjNxkviGLU0bnE/6VFNmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YMFdkvHk; arc=fail smtp.client-ip=52.102.139.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WM8KA46xYEKQIy8Gid/b+NLePs49CA6GLbXhySXQd8pRMZaEEbMNaN7VzPYjoIXDOGI0DTB3TtA88lHMsBSTVRDFlTACOOMQBbWbkkuxsOR62+SaD7usP4Rzy91DVdenlaFiV8OtUKl6NfskWsb/RJ+bgqBKtxjchVqUjGxxUG8txdcmf/7aNEh1K1fcKxiTwkA8qaMGluXAY9e/dXRuRLNhT8JyF8ZrAKllR4N7qn0Io/6SBTaDhDksX6devHQgYUSX4CXeWLOy3eJmeYGySIQc0r23Svbk1XeLef8+AGTmnUdpqswIf9e01U2Df6IttDSikmKrlQOfauKgPvYw9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58vrfhXX7bWYkImndvSweELPzaHPdaMGJ2fp41SAblE=;
 b=cNewRTU7fftyQQ0LunG1Lik4vHGKFxpLSUYpBA/a5PQT8l6e962oN9jynFQDM0RGg+SlvFQ8aew3CJX3DQKcVXbBZJnuUbVFuRA0CuuogKTclfY3qdlrb+8+W/dbHRNSuex8o9RiWwLIIX9kVZXhG6AF2KGKEKhBqwwMvHjXy0yVxTYn1jbxn6ETZJDAmA5PIejkIyVzaZoIVNMa/60TzqQg+iCGRuAGHmmzIpJ0FWwSu0HUd+bX3q9OW+mq/FvrswNz8V0JLmfVT0ccvITG0Ukycn3dV1JdTWQWsU5lent5gl6T35J6HqCFpF1WOoKkBpgTOH5a2771Kge7iMs1Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58vrfhXX7bWYkImndvSweELPzaHPdaMGJ2fp41SAblE=;
 b=YMFdkvHkqf05NWWPt7VrAXPkYpU8w8/O8rATzwsjgxBReae7pyYI5oPdKSPuyQi2M6HQu5/qfeYVWnmj1V24TaCS/i2Dh3sqpuyKw7B0AWvul9EZGYFtyQmFXyginSGGJXaBFrwuXKVm3xs1DZaoi2WF2dqs6AjXu6O37PREIuo=
Received: from LV3P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::13)
 by PH5PR10MB997735.namprd10.prod.outlook.com (2603:10b6:510:34d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 13:49:17 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:234:cafe::26) by LV3P220CA0021.outlook.office365.com
 (2603:10b6:408:234::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Thu, 6
 Nov 2025 13:49:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 13:49:16 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 07:49:11 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 07:49:11 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 6 Nov 2025 07:49:11 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A6DnBNf1304724;
	Thu, 6 Nov 2025 07:49:11 -0600
Date: Thu, 6 Nov 2025 07:49:11 -0600
From: Nishanth Menon <nm@ti.com>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
CC: <ssantosh@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: ti: knav_qmss_queue: free resources in remove
 callback
Message-ID: <20251106134911.nfe2fwqodeehir6y@disorder>
References: <20251105013049.45646-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251105013049.45646-1-shofiqtest@gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|PH5PR10MB997735:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f41903-07f8-42c8-f992-08de1d3b4720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|34020700016|36860700013|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5X2L1Qlb3dt575wFylXeqtFf7tT6wMZu2YkKmqAVZAc8AxzifvFHOKIKquJp?=
 =?us-ascii?Q?7EdXXLQVY/zbk/iAPIIPjQpUr/d/jhzYeSWdffXHu5gsKrQ+L+4N81lKAmae?=
 =?us-ascii?Q?5G+jvF0cqT31LvEz4z/OmE1j/Jb0/EYtzmRPnwBVZN2MLhjm3YDjrih8aeqf?=
 =?us-ascii?Q?HHDeJ+eRJwCVR1K/8z0L64dHkdCCXU3j6uWxcVFHdoZJyGj7RFha/LlA0iKn?=
 =?us-ascii?Q?TXoLdN7iU78spFvxqH0aYaxi+VxIEyjf6vtpxxGH7GFWpDQNu8otC/NUz50/?=
 =?us-ascii?Q?0xKELPG8ey2dxeLlxGmwxqBRobZhj0SUcTG99fyk2G1h3y2Y+raqVVR+c2F+?=
 =?us-ascii?Q?ayFyrd0ymo5+ZJZfW3oTRJfkkj7x+XiAcl+SOSjMtCc+rigcmu1cIPx3FPHt?=
 =?us-ascii?Q?WodUUkjNaNCpg1NPY1w8XMVjXuA3Qa+JsxwmJ+/T4w3HJ4Ys37RBr02w7/Db?=
 =?us-ascii?Q?gMPnw6zFk0UYur+d3zQsnVQ9SZssWR4VI/SlDblWj9eJQLmAf6o4X5z5dDOk?=
 =?us-ascii?Q?t3j4yWLwgd3nmSNUUuSzXbsyJUZXkWt+fzwFPhrzHTiwcTDKYDl3Fa3mENKx?=
 =?us-ascii?Q?QpcnSp9F2ZwLMcDbFcXjX6ndJkouNQlflEXmMU85lm9CCRzTxCSTcbEufOdE?=
 =?us-ascii?Q?duyzbjYk0sVhgTQZ9XBPA7+qm9LoDr1436sxdowLI0nOYnsXvxDuGgYs/40u?=
 =?us-ascii?Q?BRDRYx2W9iUQug3HMSA8z7hPg/fEtB3G2TsMToBDKaonTjHrFogMuObz9Exx?=
 =?us-ascii?Q?NH0tKwVq4zIfm1tB8hmUd/nMSNUJnvIX6GniF6qtXrypYKZ5KxZvdpEv96nP?=
 =?us-ascii?Q?2Cv0NBN3FNwQyEbUfyKyqyw4lFbjMztdjwQTMvClIRqsZ17XHd54rLpTmM/M?=
 =?us-ascii?Q?w3+TOXlAWSeG/HKj1gSwGzp/InjSib/ynJfAKSnIkCcw7L3A+5iAIGMCWkzR?=
 =?us-ascii?Q?YVKofBWMeNZ11pyFj4AayWnE+c8OOEEzIv8KR5OjOKlHg1E+PKTB8HDNSSQx?=
 =?us-ascii?Q?mju7ba9Ko+P1Kwzw4EKSqtFXqML4tHMqFqDmu7X1tW5CO0otxdYXEqofaJMJ?=
 =?us-ascii?Q?8w5Uel4jCpzWmcncEu7YZx6yYxvh/gSNsCs+sEdCnb7oxAc/UNE0xts82KOT?=
 =?us-ascii?Q?zwfkJ1aPnbP2GVkYWxNWOUcmDTFiL8VNe1eaZ+9t9vnrUpEa6gjRgvEuRe2q?=
 =?us-ascii?Q?I6e3uIcWxu/HYxK+VG7wQnA/H69xQ6d9q5LgLZrN4EWmfzK35kQHGdz7KT4w?=
 =?us-ascii?Q?WHQckzzCJvbrYOKCuP92UP3EUWhcrevDmVgElWpxg/Hz1DhHD+HaKOKfTHlv?=
 =?us-ascii?Q?0aeCZIWGvpTSR0pj6bk9sLQUMmy9w9rqRKo9w6nDpiQHFR8BtjA+9CJWd0Lg?=
 =?us-ascii?Q?H/9r+2jPUtmAyn7Ql7PmRtywNKUQCoH0O9lmHEoqt/5Gcz6sXMx5Qu0ZbVZr?=
 =?us-ascii?Q?ly30fm610pJZnA9jbArs18PlOKX9WhnXkunV+piIjjNaKbQcnhZQ3+0I7qvC?=
 =?us-ascii?Q?W/ZMWBwvlY3E2BrkoTycgfTN91JT9/jtViEwH3YX0a1nQE21ow2z5nj15g3M?=
 =?us-ascii?Q?KMtzWEwI8o9RrK0a2ys=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(34020700016)(36860700013)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 13:49:16.5575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f41903-07f8-42c8-f992-08de1d3b4720
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997735

On 03:30-20251105, Md Shofiqul Islam wrote:
> Implement the TODO in knav_queue_remove() by stopping PDSPs and
> freeing queue regions and queue ranges before disabling runtime PM,
> mirroring the allocations performed in the probe path.
> 
> This ensures resources are released on driver unbind and avoids
> leaking queue/region state.
> 
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> ---
>  drivers/soc/ti/knav_qmss_queue.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
> index 6e56e7609ccd..1e5f3e9faa99 100644
> --- a/drivers/soc/ti/knav_qmss_queue.c
> +++ b/drivers/soc/ti/knav_qmss_queue.c
> @@ -1884,9 +1884,14 @@ static int knav_queue_probe(struct platform_device *pdev)
>  
>  static void knav_queue_remove(struct platform_device *pdev)
>  {
> -	/* TODO: Free resources */
> -	pm_runtime_put_sync(&pdev->dev);
> -	pm_runtime_disable(&pdev->dev);
> +    struct knav_device *kdev = platform_get_drvdata(pdev);
> +
> +    knav_queue_stop_pdsps(kdev);
> +    knav_queue_free_regions(kdev);
> +    knav_free_queue_ranges(kdev);
> +
> +    pm_runtime_put_sync(&pdev->dev);
> +    pm_runtime_disable(&pdev->dev);
>  }
>  
>  static struct platform_driver keystone_qmss_driver = {
> -- 
> 2.51.1
> 

Please follow linux coding conventions about usage of tabs - this should
be exposed by running checkpatch.pl --strict on the patch.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

