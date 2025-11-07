Return-Path: <linux-kernel+bounces-890305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A2FC3FC1C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A7418826CD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCEE31D753;
	Fri,  7 Nov 2025 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HOHQiNCt"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF23431A04F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762515688; cv=fail; b=IuhEDBrwEf3ER5Q70sSkiDP7aYU4Mn5IGoHAIoOTlyrFe4FdJQTJds08iWeVkxQlq+OCljUtGtgk3Nu3R/3jdp9p2ELZeZd7GSpOPSugXhp0uW+ABxG9sU5DxPhBQflQ4b6uzq/xG4Ww4Ao1JN9Plxem0nnowndEnUR5ytESbTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762515688; c=relaxed/simple;
	bh=K92FBvI8LuJ89nsV4U6ZQqRYl0wEV8CUrBM+OH3Nhgo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=melkj+r2su6g0IkRrO6e3j9qrauLek5rlxHTGkbV7dWWcE74AaQ98o6XHx3iIk+U/a9HVAOI593u3ea6avNWKj0nHwuAa9p3tP+QoKsJmt9hzriXnWLgUSyDGW5GncBqHwdg7RDnOLeKeWgqYWbMCzMZQ9De8GxHhgx7BIjeYAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HOHQiNCt; arc=fail smtp.client-ip=40.107.208.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbvD9DDqS4/TDkt4/k65UXql7hNPe1mB13Dghqs7r5s1qhpUlVxiwXHtP2tGfKyPAhOpZKQi3cP4QumMxj7M0R+W3o8QA2+6Eq5rfbOiwbt0qAfXLw/MSRS99xggI3mDYnW3A56axCw8XTyrXI0rbSl9fLLC4BVIa0fwvEGG0w4UvD/P+GenvBUTADwebITU4ogQ+ocUrE8IBpU13K0O5IUPpvxYygWkKpxRR0Eiazuzf42NVvkDIAUoWT/MPb2ww37XinY5iWGkkwaUeSwgJnv36nygrRub11F08x02q4/rGaS8fqZ8nCl9CPTuTUwhIiY96nd5grP6EDAkAY5neQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6UvMIVyFHQEXYx2VUEJCKqOTGz97qoHlz3hBNOwJbQ=;
 b=opaqc9qfiZRZQ4Q08v1jQQdYtFcE6z2jUB4/MYaqZ/T9hGC+kjvg2PJZznrsJDo8JBMn41o90Yo7PtM+xuUKKoTpy3UxcVC7vu6NmYKjH7yaRIHk31FcjNBm29CR+VhC2Jc9vuAEuablg7pBlCrtWzsS637km1sT5hFrWP4TUAZh++yJUbGBUsOIz8i1VmkJbRpxFb3uNc9J+Hk4El46D9868N90yRl0st4QUASEScz2T/gz/n7gHvctwIbPxpE2pabWDUgscJHvHcIrPTP6CzLqC0K2kUgyb/lKlOuK11RP+q2/7j3BWAdbfZBlp7S5b+RZkoyxiPqyQn7cc4ZsTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6UvMIVyFHQEXYx2VUEJCKqOTGz97qoHlz3hBNOwJbQ=;
 b=HOHQiNCtCYfQKzUCpMEgP7sM1hFEYn3d+t51OMJMylm3bXLQ0Nl1dWbPF4I2sRD8l7esJvJSSnpNX7DeCNWWwHzesI0/37nlHncMgfArCZSLm7OnzTRGlJIDeiCaGDeFpJLFhUcsJj3TXi4OWEUUqP/ZJuN3/NulEkm0ZeGdAWE=
Received: from MN0P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::21)
 by BLAPR10MB5121.namprd10.prod.outlook.com (2603:10b6:208:334::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Fri, 7 Nov
 2025 11:41:21 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::cd) by MN0P220CA0028.outlook.office365.com
 (2603:10b6:208:52e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.13 via Frontend Transport; Fri,
 7 Nov 2025 11:41:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 11:41:21 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Nov
 2025 05:41:17 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Nov
 2025 05:41:16 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 7 Nov 2025 05:41:16 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A7BfGla2956373;
	Fri, 7 Nov 2025 05:41:16 -0600
Date: Fri, 7 Nov 2025 05:41:16 -0600
From: Nishanth Menon <nm@ti.com>
To: "Thomas Richard (TI.com)" <thomas.richard@bootlin.com>
CC: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
	Gregory CLEMENT <gregory.clement@bootlin.com>, <richard.genoud@bootlin.com>,
	Udit Kumar <u-kumar1@ti.com>, Prasanth Mantena <p-mantena@ti.com>, "Abhash
 Kumar" <a-kumar2@ti.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 1/2] firmware: ti_sci: add BOARDCFG_MANAGED mode
 support
Message-ID: <20251107114116.f2laylu5yziueyia@budget>
References: <20251017-ti-sci-jacinto-s2r-restore-irq-v1-0-34d4339d247a@bootlin.com>
 <20251017-ti-sci-jacinto-s2r-restore-irq-v1-1-34d4339d247a@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251017-ti-sci-jacinto-s2r-restore-irq-v1-1-34d4339d247a@bootlin.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|BLAPR10MB5121:EE_
X-MS-Office365-Filtering-Correlation-Id: d600ac87-9f2a-4d53-f11b-08de1df29295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SmfTKT80vLkMbQLe3GAsdkmEv/cYv3kzUpQjjJ56yMNK1xp2UsgIgoppszFO?=
 =?us-ascii?Q?hcwQ+fppuHw8NsO/C9mVjR0R7pTjGCbnpsc/hU7YM9DGT+m4nrNiwllxdWfY?=
 =?us-ascii?Q?jXBUIJZgAJ5ZWcnGlmtpJ02UuKrQtR/v/o0hgNWpgiPV1X/t3/LCcyNNMKba?=
 =?us-ascii?Q?lZ+dh6uBB2SNdTmQBjbnsXJVhROJW5hx2+HCPgwngPEph8IAhEr5qRz2Fy1d?=
 =?us-ascii?Q?/RMkxWITe2ny+xEyuM3isWpunLRxwXmY8+7F7eiV0TAbXpuoZXzUX+dpvFB0?=
 =?us-ascii?Q?9DLffi/N+U+0rkbM0hmN2KVmLK+xISmNvxog8mwT9Y5S+kVijFuo34ioYEMi?=
 =?us-ascii?Q?+nJEuqe+Wp827MYrZcFuI1owPyZcrrGxuN8iyOmtCqLZxOvCFsLe0RLMr7nE?=
 =?us-ascii?Q?SII0Mi+RCGiUiv+1n9NIiOvTROA9R9NpVJ3KVITqMJ8Ubm1cIphtL6y9/iXA?=
 =?us-ascii?Q?U43Fos9ZZ18nae6CTUDnNoSPiBCz57GSw4mutPWgxb+6kL9k+bTR/oxK5ZG3?=
 =?us-ascii?Q?xZBG3A36Ji24qjClyjzjN5XmnDx0mHFHwQdpIM5oaHs4nm024OD2+NQ9gY4X?=
 =?us-ascii?Q?nOmS9BAHkIhFFs1dTgetbUkv/RVj3zYpyBr+DptM7aAa3NcoNotBAupoOS1w?=
 =?us-ascii?Q?Xd94Bq4qEtqZHOZLj32Cf5/GWzfFEudyGjzZtNO/2A44VzciNT6ycwFs/T8e?=
 =?us-ascii?Q?jT9Fzw8kjmZBJ0cr82C+/nVt6tIv/hwFupY/d0vIT2UEc09AlpP6OcvXkT+0?=
 =?us-ascii?Q?sHlzEH4DcB77MC50BFm8U4S5urXrVSd0xcJDQhiMNUsrEodBVxM2tsER8LJ1?=
 =?us-ascii?Q?MGH/2lYQ0xamXjrylEc1Qj4cItxJtd+Oiaz9UOn9pNTZT3v0IOVPHHUZCwsX?=
 =?us-ascii?Q?CfFZxQHGwSSDQqQ45BKbh7wz8/PqbNRCukhfKeW9QC1kYihoSJ5Ig2L1xfXQ?=
 =?us-ascii?Q?33as58WRbXJnbvQDfoBoKPcRf5oi4XTl66O12OtXmw/LG65bu1OJXylPAOqK?=
 =?us-ascii?Q?lKVWIJ5oHkoFQeL5+7DEXpFL9KVuq1MGKIXDU3zInspsI+kVEVOdAOjhgh7C?=
 =?us-ascii?Q?ZjJ8v9sfUv7GNbM7Db8Kj2ixCfnvppLlKKJKgS8yNr3J7kl5bR2hmgJaU1bT?=
 =?us-ascii?Q?WHfi9hzESlQKn9RwJWNKYWEqJh14dw5mPRgu/tJ7klArUe0ZOXnX5304FWDP?=
 =?us-ascii?Q?dZ51iRbrJlaIPqOHVItu83m0OPVeMt0EFuoyf5SubXCG72dkwOv22XFWvTeQ?=
 =?us-ascii?Q?Y5fiVzua5xZAEuTLnWNB5Wad4n0BoboJf/9HMnXpuFHgQfnNXARmya1LQPbA?=
 =?us-ascii?Q?yzcv6ZykuNP3XktODeLcafAxYLNsCq21cSLj29pQ/VSnJB5oPBwn2BtNpot1?=
 =?us-ascii?Q?Fd/5ser4f1T6mRv6n+5CNIaOr/LnoKdR8IDCz3FDld6WONgRLUThrQpQ+LMQ?=
 =?us-ascii?Q?/gy7DMyIrl6IhdCXbce15G0qpV9oroCJofZX59AbiRE/2iTjj2zeT+kgxpyl?=
 =?us-ascii?Q?D2MaWntr4zMFGO0d2MyIOMlDg19BsUcP+OxpPbB+2VwPdI0FKAUjwnfd7xed?=
 =?us-ascii?Q?i1Bjioi00uNch11lPvI=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 11:41:21.0628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d600ac87-9f2a-4d53-f11b-08de1df29295
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5121

On 16:44-20251017, Thomas Richard (TI.com) wrote:
> In BOARDCFG_MANAGED mode, the low power mode configuration is done
> statically for the DM via the boardcfg. Constraints are not supported, and
> prepare_sleep() is not needed.

Will be good to get pointed to some documentation around this..
> 
> Signed-off-by: Thomas Richard (TI.com) <thomas.richard@bootlin.com>
> ---
>  drivers/firmware/ti_sci.c | 10 +++++++---
>  drivers/firmware/ti_sci.h | 14 ++++++++------
>  2 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index da134ada64e179b4b307f7e0de5ed0f7371a96f2..f9f1a67e8e66b0a4048fae04ce31be54ca5cba7a 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -3693,8 +3693,11 @@ static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
>  			return ti_sci_cmd_prepare_sleep(&info->handle,
>  							TISCI_MSG_VALUE_SLEEP_MODE_DM_MANAGED,
>  							0, 0, 0);
> +		} else if (info->fw_caps & MSG_FLAG_CAPS_LPM_BOARDCFG_MANAGED) {
> +			/* Nothing to do in the BOARDCFG_MANAGED mode */
> +			return 0;
>  		} else {
> -			/* DM Managed is not supported by the firmware. */
> +			/* DM Managed and BoardCfg Managed are not supported by the firmware. */
>  			dev_err(info->dev, "Suspend to memory is not supported by the firmware\n");
>  			return -EOPNOTSUPP;
>  		}
> @@ -3932,12 +3935,13 @@ static int ti_sci_probe(struct platform_device *pdev)
>  	}
>  
>  	ti_sci_msg_cmd_query_fw_caps(&info->handle, &info->fw_caps);
> -	dev_dbg(dev, "Detected firmware capabilities: %s%s%s%s%s\n",
> +	dev_dbg(dev, "Detected firmware capabilities: %s%s%s%s%s%s\n",
>  		info->fw_caps & MSG_FLAG_CAPS_GENERIC ? "Generic" : "",
>  		info->fw_caps & MSG_FLAG_CAPS_LPM_PARTIAL_IO ? " Partial-IO" : "",
>  		info->fw_caps & MSG_FLAG_CAPS_LPM_DM_MANAGED ? " DM-Managed" : "",
>  		info->fw_caps & MSG_FLAG_CAPS_LPM_ABORT ? " LPM-Abort" : "",
> -		info->fw_caps & MSG_FLAG_CAPS_IO_ISOLATION ? " IO-Isolation" : ""
> +		info->fw_caps & MSG_FLAG_CAPS_IO_ISOLATION ? " IO-Isolation" : "",
> +		info->fw_caps & MSG_FLAG_CAPS_LPM_BOARDCFG_MANAGED ? " BoardConfig-Managed" : ""
>  	);
>  
>  	ti_sci_setup_ops(info);
> diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
> index 7559cde17b6ccfeeb1bc357fce5c5767c3f75c54..ac1cf6971b8678aa1277abb86d9ec672493f4c86 100644
> --- a/drivers/firmware/ti_sci.h
> +++ b/drivers/firmware/ti_sci.h
> @@ -150,6 +150,7 @@ struct ti_sci_msg_req_reboot {
>   *		MSG_FLAG_CAPS_LPM_DM_MANAGED: LPM can be managed by DM
>   *		MSG_FLAG_CAPS_LPM_ABORT: Abort entry to LPM
>   *		MSG_FLAG_CAPS_IO_ISOLATION: IO Isolation support
> + *		MSG_FLAG_CAPS_LPM_BOARDCFG_MANAGED: LPM config done statically for the DM via boardcfg
>   *
>   * Response to a generic message with message type TI_SCI_MSG_QUERY_FW_CAPS
>   * providing currently available SOC/firmware capabilities. SoC that don't
> @@ -157,12 +158,13 @@ struct ti_sci_msg_req_reboot {
>   */
>  struct ti_sci_msg_resp_query_fw_caps {
>  	struct ti_sci_msg_hdr hdr;
> -#define MSG_FLAG_CAPS_GENERIC		TI_SCI_MSG_FLAG(0)
> -#define MSG_FLAG_CAPS_LPM_PARTIAL_IO	TI_SCI_MSG_FLAG(4)
> -#define MSG_FLAG_CAPS_LPM_DM_MANAGED	TI_SCI_MSG_FLAG(5)
> -#define MSG_FLAG_CAPS_LPM_ABORT		TI_SCI_MSG_FLAG(9)
> -#define MSG_FLAG_CAPS_IO_ISOLATION	TI_SCI_MSG_FLAG(7)
> -#define MSG_MASK_CAPS_LPM		GENMASK_ULL(4, 1)
> +#define MSG_FLAG_CAPS_GENERIC			TI_SCI_MSG_FLAG(0)
> +#define MSG_FLAG_CAPS_LPM_PARTIAL_IO		TI_SCI_MSG_FLAG(4)
> +#define MSG_FLAG_CAPS_LPM_DM_MANAGED		TI_SCI_MSG_FLAG(5)
> +#define MSG_FLAG_CAPS_LPM_ABORT			TI_SCI_MSG_FLAG(9)
> +#define MSG_FLAG_CAPS_IO_ISOLATION		TI_SCI_MSG_FLAG(7)
> +#define MSG_FLAG_CAPS_LPM_BOARDCFG_MANAGED	TI_SCI_MSG_FLAG(10)
> +#define MSG_MASK_CAPS_LPM			GENMASK_ULL(4, 1)

Driveby comment: let us not churn formatting..

>  	u64 fw_caps;
>  } __packed;
>  
> 
> -- 
> 2.51.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

