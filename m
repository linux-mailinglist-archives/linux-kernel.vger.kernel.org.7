Return-Path: <linux-kernel+bounces-897536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4035EC53094
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 86E84359F80
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B053016F1;
	Wed, 12 Nov 2025 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GrRV5vnn"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010031.outbound.protection.outlook.com [52.101.85.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD30D26A0DB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960618; cv=fail; b=jrBWZh18wv0DGj/PChrTULu1Ym7lQnJaXKBG6tNNa7JfKHl/28q555SQxpM5m9oQuoY5K7ibfICRei7VyrBbeCKTI0+IjN2rUAx8cVq34s2KhSLYXhPmq3BQqTM/1LND7qGJNils2fVgLCoqVzA/Q1746TwWW+2q+BWIFsiW9hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960618; c=relaxed/simple;
	bh=sfFtcVGT+lKsvLTtNzSVUgOtFUfqRKEbnoY2Gn99jBw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFS94OOMIPzjb74BCYBwpHKiQmHKxT6G+tbRZyhFiRv3e8o/ka+ELpbg78kiAiuT/T1TZK/OJ5S4Si+OVBTAqnThWyZ5xkN6xyyiwhdaySZZiTh2f4eGZPQu/jcTqSA2fQ2/Y/7XEeEYbcOhKDKrvvqVIh0m8BGE73IXzQbxE4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GrRV5vnn; arc=fail smtp.client-ip=52.101.85.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHPD9slpP2jDVuRoDmSZ5ueHsYTWwF3S4+omQdjh02/kTn5OAqeBeHc26S6yyJTv44EBiuyTKdXnp5RBAlx/NDDBQ20zen05/q2CGqYer8KKl3sXMjk4QMCqZ2q1ejUhrzWEMvmx3rd0whB4s3prz8QVL/qkhhK9M30dv2z3aQnYol3iwXwGIU3kbIvQ3dhShY1wb9t+vk21Vk9ZNq3sRUYDt0pjEfqHuZ+U50J4YhYTs2MeW7LzjIXbh6HSKwkNgOvg1oWbJcB6EyeOdS+b+zZiNkUIeYPXRyOAnz+zvdJMiRtnW/URJsJ6MKzGqMqEXXMluDBC90RX8kuofZbx0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRKhUWc7w2iAG9gyJBZyUPz1wkiqOFB3aQ/y72EXfe4=;
 b=S3ZJJ1QLgPodZ5emJOx/ucMPP1G20CPDIzePC8zixD8c6D2kWcdAGYpfuqi0EBuDz0DAB28Q9tzlZ+RyZqcjQOSr8ta2wHxhdj3uoP5qJUYBNsW75IS+FIZ/Yz2oFDtuir7DbGxGN2lHC9kYwuilFbfL6HTeRE4N3D3xKKlOt5Ryg6aMJRwWEJo0p3SdxF6zvyiP+bD6M1vprBlLna/5aLM9pG+B9aFnuCqb7qFsdNzlcNn0VMs1qXuAEejqRaAFr0YjhQ/I0XdJg2lbhJDFrIEufMjHSW2SsLaze9/8gqoTzFONeUdWPWIwh9bTfK7pVLQU4g/UYwU/PXe2uF7N1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRKhUWc7w2iAG9gyJBZyUPz1wkiqOFB3aQ/y72EXfe4=;
 b=GrRV5vnnvEkprdbZyZiTktaAWrZQUm5ghjoq+aQS9dDPIjVGUKVXI8CQfSG+rrET5nSPD0bBieajC2wXqroUMb42K426jjJpAumT4b7BOS8JzDXN0GNJ8n32/UH5TRLWNId3w/ngSp3uZYAFWsVUjrbFF+HUN5CfclzR367nAow=
Received: from MN0PR05CA0017.namprd05.prod.outlook.com (2603:10b6:208:52c::21)
 by DS0PR10MB7068.namprd10.prod.outlook.com (2603:10b6:8:144::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 15:16:48 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:52c:cafe::cd) by MN0PR05CA0017.outlook.office365.com
 (2603:10b6:208:52c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.6 via Frontend Transport; Wed,
 12 Nov 2025 15:16:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 15:16:44 +0000
Received: from DFLE109.ent.ti.com (10.64.6.30) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20; Wed, 12 Nov
 2025 09:16:40 -0600
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 12
 Nov 2025 09:16:40 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 09:16:40 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ACFGe6W2860422;
	Wed, 12 Nov 2025 09:16:40 -0600
Date: Wed, 12 Nov 2025 09:16:40 -0600
From: Nishanth Menon <nm@ti.com>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
CC: <ssantosh@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] soc: ti: knav_qmss_queue: free resources in remove
 callback (v2)
Message-ID: <20251112151640.rraufakkykekhmgf@stand>
References: <20251110212751.Jdztdakpcerpqpr28@gmail.com>
 <20251110224459.49724-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251110224459.49724-1-shofiqtest@gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|DS0PR10MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: bb302d87-9e65-4b42-d2f2-08de21fe7deb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eixk2q7gzoeucQzEDHThcecB4UqVv6sjfnUmO5y9PGqOPV2vAJK/9JOkSz+R?=
 =?us-ascii?Q?dN6PnrqfKJtHYJiNE8sYG8JqN1W0KiPldlw4qKgXatSsMMnDnHLVDLkz+6yE?=
 =?us-ascii?Q?h3HNKuxOOMJD7K1L/yO5/j8+P8ABF2NSnFD3JKQnt4E8MJ5Shs7gGT2ef6VV?=
 =?us-ascii?Q?XF9ZUUJLr9qwf2BN+B1eIsItBMlw72vRi4f6zDQ7Ls8FrM/QVydSdaIlz6yw?=
 =?us-ascii?Q?7objWetrcvjZg5u3GzHYhOW+H83r0ROQhpx2zUsD+fOKVZpGqZr0zoS9hDtW?=
 =?us-ascii?Q?eluZ8khjFA/ao32aACxWrxEmZF3B1uCo4qCPTlwJHQmjqA106Fc94N0sfwaX?=
 =?us-ascii?Q?wCRIzEH0WuZm8zQD6zhIwdNkn/5vwAw9pdKFC01Usd7sSmzaYINr506rM4XZ?=
 =?us-ascii?Q?J61JQHroeZdyIVMzPyeEDx2NVJL87aKvwPHbyHVJqs1TPAv0mk9V7/tV8meX?=
 =?us-ascii?Q?+gxmyV9OnALLfXypEbTrYxL3yowIlohbfEJDzBsVNwZ8VOd//zf10QN/6wyN?=
 =?us-ascii?Q?Da721YFKr1qZ9sPF9qobi2m8TBTxxfJ8KFqwK1mLIi0tDBS2IUIE9184Jha9?=
 =?us-ascii?Q?48sBu3+tp6S23TC1DDoMA7pD5j8TRGD29OktnPEdZZsxPIWo7rMJj3e+MN2c?=
 =?us-ascii?Q?ZineGCd4GfYmxw1U9R6llT12DVzbjDs+5m93hd+3z5OoOq+b5b+5/z5WQ/D6?=
 =?us-ascii?Q?ulrUCFgPK9rS12g8y4xogWl1LE3ogbE11Ic3xzJ2iDD7dO8MS1lHOrJZxxh9?=
 =?us-ascii?Q?0/JEwA9ZaRSQRtn+gBUJ0xSM69ijHS6JtFAJJ7w1Ck7RBpoz3VWaAQuZGKOQ?=
 =?us-ascii?Q?ujwjuuGUJD12j+mttNqWX9RIaU1c9DP7Xo2FaolU1esgUqwc/ZCANrhUqpyv?=
 =?us-ascii?Q?XDyeRAyqS4Ac0gVEOYmZJ8oKnmZDoSq69UNXoLccSjk0e/6ncclE7hiX+kxr?=
 =?us-ascii?Q?JQKIBfFnqcjL+nIICjRT9PwpNUsFpAcVmydrZkzi43HDM8PP7Rubyhzqhweu?=
 =?us-ascii?Q?O+I22eoz021QC0uW83rg0jBrBBOR6m8yOf/7Ed7Ra6JAtuTzVmktZAOjpjHN?=
 =?us-ascii?Q?uoGZhqyGPK8ZNVfTxYgtx4Pmc+sGVNrkDDfdaiX4LF+O3urMoUrAnVGYd6ZS?=
 =?us-ascii?Q?mpIGscKNVgH4Tc5ttmjD+asmc+BFMRUWP+qFLgxXCCfApB5sESQ/xbPWuidW?=
 =?us-ascii?Q?cGHYvWFo2RQZzQ1Gc9MQ6axH4Siw0gg/OT+YIj/2Ovtc5xy8ccU0/95RrqaO?=
 =?us-ascii?Q?lmsZiSlTpj5pFW4JWoG9gGWvolXYrvBAv3nNDVhgE5KaofQ0lAreAUhOl37h?=
 =?us-ascii?Q?UAcEh9XswcQngxG27pWn6dS4R6oHZrDdmD5BxrkEWSalDtZqmn4c08TpW8GV?=
 =?us-ascii?Q?QJ/Z0+oEp7ibW6SJ+fod6WIWnjfCs9HluX4U0hDhAGP1Kg+E5d8ToGTGvHud?=
 =?us-ascii?Q?RmrvVok5TpbA/Vw0Jsr3WGwOpkK06nLCMEdNe4vDq1yhr242LGTpR9RGf9IT?=
 =?us-ascii?Q?M+2nbnLeaKpsa/bK4iP7xiY7F09DCs/9HXEp+ogvlnzmM8I92H1aMQlA17TJ?=
 =?us-ascii?Q?5Tygp36aeuICmE7PnE3hFL7jG2YCGLxroF4J0mFF?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:16:44.9957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb302d87-9e65-4b42-d2f2-08de21fe7deb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7068

On 00:44-20251111, Md Shofiqul Islam wrote:
> 
> Hi Nishanth,
> 
> Thanks for reviewing!
> 
> This is version 2 (v2) of the patch, not the same as before.
> I have fixed the formatting and indentation issues you pointed out.
> The patch now passes checkpatch.pl without any warnings or errors.
> 
> Changes in v2:
> - Fixed indentation and alignment issues reported by checkpatch
> - Wrapped commit message lines to within 75 characters
> 
> Thanks again for your feedback!
> 
> Regards,
> Md Shofiqul Islam
> 
> Implement the TODO in knav_queue_remove() by stopping PDSPs and
> freeing queue regions and queue ranges before disabling runtime PM,
> mirroring the allocations performed in the probe path.
> 
> This ensures resources are released on driver unbind and avoids
> leaking queue/region state.
> 
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>

Please fix the commit message. I use b4 to apply patches.
Documentation/process/submitting-patches.rst
or https://docs.kernel.org/process/submitting-patches.html
https://docs.kernel.org/process/email-clients.html

Also you can see how patches are reviewed, the style used
https://lore.kernel.org/linux-arm-kernel/

(hint: don't add (v2) as postfix in $subject)

> ---
>  drivers/soc/ti/knav_qmss_queue.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
> index 1e5f3e9faa99..7d9f3570ecf3 100644
> --- a/drivers/soc/ti/knav_qmss_queue.c
> +++ b/drivers/soc/ti/knav_qmss_queue.c
> @@ -1,11 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/*
> +/**
>   * Keystone Queue Manager subsystem driver
>   *
>   * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com
> - * Authors:	Sandeep Nair <sandeep_n@ti.com>
> - *		Cyril Chemparathy <cyril@ti.com>
> - *		Santosh Shilimkar <santosh.shilimkar@ti.com>
> + * Authors: Sandeep Nair <sandeep_n@ti.com>
> + *          Cyril Chemparathy <cyril@ti.com>
> + *          Santosh Shilimkar <santosh.shilimkar@ti.com>

un-necessary change, drop.
>   */
>  
>  #include <linux/debugfs.h>
> @@ -1884,14 +1884,13 @@ static int knav_queue_probe(struct platform_device *pdev)
>  
>  static void knav_queue_remove(struct platform_device *pdev)
>  {
> -    struct knav_device *kdev = platform_get_drvdata(pdev);
> -
> -    knav_queue_stop_pdsps(kdev);
> -    knav_queue_free_regions(kdev);
> -    knav_free_queue_ranges(kdev);
> +	struct knav_device *kdev = platform_get_drvdata(pdev);
>  
> -    pm_runtime_put_sync(&pdev->dev);
> -    pm_runtime_disable(&pdev->dev);
> +	knav_queue_stop_pdsps(kdev);
> +	knav_queue_free_regions(kdev);
> +	knav_free_queue_ranges(kdev);
> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);

When submitting a patch, please rebase and squash local changes.. and
make sure the patch applies cleanly.

>  }
>  
>  static struct platform_driver keystone_qmss_driver = {
> -- 
> 2.51.1
> 
> 

PS: if you are not comfortable with upstream patch flow, I suggest
online training/in-person training from various sources such as bootlin
etc..

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

