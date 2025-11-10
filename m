Return-Path: <linux-kernel+bounces-893131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C58B3C46985
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 114443A1E11
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF7D307AFC;
	Mon, 10 Nov 2025 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T9bcXDfH"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011051.outbound.protection.outlook.com [52.101.52.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E152FE585
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762777631; cv=fail; b=dMwTepFTWB8TOnGke0gbHtZk0HyHXRkrDYxZh7mQJg5txaomlKibN73XnD32FA0K5MNPk5qzC1gMZKD+ks9Pvt54CkSxfPgZFsQz+HR+bOhvcJUZrj+8THFWfhSMtBpChKyBsocEU32vC7Q8IhhzTzhYoOhrPFIz3ISHIkNi3yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762777631; c=relaxed/simple;
	bh=Dwl5d5OCuH+AofkpWJ2rGxYTQ0OhupFtZiJaQo+TEWc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXrcQxnAVxH6JTQvLPXyVxS0s1xLEIC8PBJa0cDZee9TY2dQrQwsAtRfACuhwyM/9tiOirBmmT5qwtco2Lu+dqoZwK2sYpSQosqD9taDw645zxXc8ImO2A2VhqTHG8/4JpY/3W69UejWTyRR0x5h5zedU9MFH+VidGclJyD1N4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=T9bcXDfH; arc=fail smtp.client-ip=52.101.52.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhVWm45Lb0DbwlNC9qTpH0QT5M5OBzGvLnXGF28s5iypR69YaMZNmAGphw1WIqIVoGjbHiXiUbf9KypqXOOj9DbEKd4BZFm8O/8EZc/5bXZlWZmfRDMba70I0AnFFdOiwX1a78bRq/PS6Ec3SGZyxakcIq34fjSURnXqbjj3MKecY9dOl63J6pqK1KjClMNm/j+m/vX7Cp27mOlrq/F2zGhJEOXGlUQw2len+HOGLSqx83d1baoDX9Xs8ArA8HET93QkViJutY+AxNxvIGuSRE3ej8f3yH1BBQVkW/0aUbHIFr0QxUyptXXF1gXX2UfI6pc46vGVo+hPBnRjUe2M0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/alG1gJ7XqPqUDi2aSQqrMS7c/8JTAjaO7cxtC5v0Y=;
 b=dhDNV5kyc4dxnnee/6IulYfyhEKuKdG13k/GBcH53n10VZ9Zoa3NG2vBChIpN115mG9D8H7WBdbcdkZsqfwIySQHYfW73zuY31io/m9kH5pLqEEhrWQZfe7kvtnNhGRVAhdTnTywVlCJZzb4rgXNZ6n8Rvk+rOXEoI5uUWKwsotV9mgotL8DgVjlM17RFULSRRsiqmRmxmiiehA3i27owisoys3Hm893gXwPlzUt9B1dfiQOrQWkSUOeUUYHQ8isz3BTT77CX0m2y34U66F+bPFDadRgTHXiXNHop9GraJdIFea/aLyT/IJjc9zUEOC1x/1BrlHj2nm+8CqkQNhwIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/alG1gJ7XqPqUDi2aSQqrMS7c/8JTAjaO7cxtC5v0Y=;
 b=T9bcXDfH0d286PFFRPgfMIym+zEi/8eoGUfbuUynIzdb2inO9aRFaW+f+gyhiI9gJRz7A8lXFJs7YgmsJvPgVNhzn1/zgAqx8VEWjyjRLrRzQvxecjHSW82gPMnpAAmJ1OepWoFS3IiN1o52G8QCBjXh44Gwh/UgQe/cC/lYsGM=
Received: from BN9PR03CA0555.namprd03.prod.outlook.com (2603:10b6:408:138::20)
 by DS0PR10MB6272.namprd10.prod.outlook.com (2603:10b6:8:d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 12:27:02 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:138:cafe::bd) by BN9PR03CA0555.outlook.office365.com
 (2603:10b6:408:138::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 12:26:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 12:27:00 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 06:26:57 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 06:26:57 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 10 Nov 2025 06:26:57 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AACQvx93356586;
	Mon, 10 Nov 2025 06:26:57 -0600
Date: Mon, 10 Nov 2025 06:26:57 -0600
From: Nishanth Menon <nm@ti.com>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
CC: <ssantosh@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: ti: knav_qmss_queue: free resources in remove
 callback
Message-ID: <20251110122657.jzda24kcperpqp2t@amigo>
References: <20251105013049.45646-1-shofiqtest@gmail.com>
 <20251108221741.48610-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251108221741.48610-1-shofiqtest@gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|DS0PR10MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc6069c-67e2-4b1b-f63b-08de20547268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oS7ZSlarCAIzMkqBnA2tdR4dXPp1qaYL0QDu8qudZe0PnSlSYSNbhOBkK3gb?=
 =?us-ascii?Q?NSy0q9CSnjUwI58m3vX9Rfj8ULTdCUjzF6PeBVOHUXu+Yj3HpYOOa01sflZL?=
 =?us-ascii?Q?GSQ5MzKeXMuHAlkd0crF9k82KMmdC95PXQDbd65gP62vw0GLw0EiX97lwAfL?=
 =?us-ascii?Q?KUUziBl2MBo4iFiZHIOclx1zLKg1V0fzEDvvHGBV0zkml4yIiUIrh2XS79hG?=
 =?us-ascii?Q?LNphW3x58EL/eB3gS9+eeDrA27AJVCxnEshOSAKclBtjd1FrrfBsyEuM66TR?=
 =?us-ascii?Q?TA4huEzI0Exo9wqS1+BszNUYe3DC/wjMYxAXvPchwQmwuhsurwlQqSxzAj3Y?=
 =?us-ascii?Q?yxG5f2lV6KokJ4zvxYH8DQztV6VIk9/W7a77SFK3xiyY+LR/HPXLspQriJOD?=
 =?us-ascii?Q?EAIkN/Hol10GxOpQ9yyV5e9fsNuSd4IBRbMrJDiBQXPgJAOO9FH5tNSFbumA?=
 =?us-ascii?Q?4TNG4Qy1O3xOyLnDINY4JY03O9aOudXyoH62ADtoME6d5uNqUv8fh3nxz0oi?=
 =?us-ascii?Q?CiMEhUvDiTp8/D6ToHQV9eIUibHW1Iof5WUJWsYoFVWWMCn7wytovp0AXsL0?=
 =?us-ascii?Q?C25aqUXl1D5uaSi2XNjuXEGxqAcnJY6gnmH4Tsx4tKnqoB7nv3io8pXrm6FY?=
 =?us-ascii?Q?+yJi53GAQadu+Ef6OShYafRV6CobEs5Zsfq86qwbrhMTgaL2dQ1jHhLRhFHs?=
 =?us-ascii?Q?AC8TWhZfv9Ml77MpO1j/9gpoZJE7DsfLgXJ54/suByNHPF6xTrBB96LlSKO/?=
 =?us-ascii?Q?ya55lSCBVODKa+vnwLa4glsuHwZBijKVAsqgt/Ccu+UUUOWf9MjjqHbfWdGy?=
 =?us-ascii?Q?ibhnvLv6rTHVYrpjbw/uSwYsaQGD8Lbrf+diU4ZpXgwjVOzj4IOAyaSo09dU?=
 =?us-ascii?Q?owCKEaE+ThxHUxdddopu+GPbycpFsm6BxWW1mQfawEr39F0q9wopMMz6BKXL?=
 =?us-ascii?Q?q+/ocu1t2nHRpK1BcI6yZxuwhVtB5FXTDzinTxmEzsI9FrzaI8hMDHFacMUG?=
 =?us-ascii?Q?ztA30jn3VXn1a7tzDp2MBHeFu/1nDccelzBdCxa2+TJbFRNQ2JdffYeZa/pD?=
 =?us-ascii?Q?qMoZxX/oP5wUwEvO/Bfb0isQAiBudrSGTOxW9wMiTbkJOtdXJW33Ry6TFJrN?=
 =?us-ascii?Q?JAQAW9nccYoxBPTFTFiTDXFIYnwcoiHpfGLgaBXsmw+jKNDQzsNS1Yw8CWzB?=
 =?us-ascii?Q?mqkEaseVWcSrsfQPbOPw4goLvO7M1yQOviWzDyJ3NBVnCHqJCaQshAmLW+4J?=
 =?us-ascii?Q?DFuueHh7fNxHdrfxNvV2h5KJkatyx+HaRpMJIg5L0TMLAtP32sxePcl7nGqe?=
 =?us-ascii?Q?XycqHknyK5WyyaAmrn21OrS89XDI/EYWGp1Sn6ppHWYg5U1Wqu0Up7XsS2Cx?=
 =?us-ascii?Q?M/VNqixl91Vittwdp4vVMFJUC7vh+VpSCTfcaYZmI8vyKDeKMT7lJYeIVj8f?=
 =?us-ascii?Q?3SUSoM6PwHO7NbYMQp2FYmU26gS5HjnIyQYoAIYwwQ1xovitLqSXAe5QPG5D?=
 =?us-ascii?Q?mnCpOYPnt9C6rKIt3cjcU6EZ5Qi8hU4PUIJWpADRXYvBnUJMu+NVaeEj0K8z?=
 =?us-ascii?Q?TgC7iFGC8e7MVZmmElA=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 12:27:00.0845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc6069c-67e2-4b1b-f63b-08de20547268
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6272

On 00:17-20251109, Md Shofiqul Islam wrote:
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

Did you happen to send the same patch as previous? it has the exact same
formatting issues that i flagged.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

