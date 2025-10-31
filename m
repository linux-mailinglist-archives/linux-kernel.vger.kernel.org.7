Return-Path: <linux-kernel+bounces-879490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CFEC233C8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 05:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB60E4E2513
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 04:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92F629E109;
	Fri, 31 Oct 2025 04:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Hy8Nn9rC"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011045.outbound.protection.outlook.com [52.101.52.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38D026FA52
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761883833; cv=fail; b=JEeVQtjmmb6f2f/AT7YZn9UK2wdXlFdm5NhBrg9Hea4XK5x7/bsbU2+iF8Glsg1heomt/36rrFziZtlcYcDnH6saGgQ6l9MJFn82L+I3WSH9yuHWgThQ9kfXSRac/GelBETKrIrAYl9P7yFyuyjipy5TkWG52aQEDiP/QWXqkjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761883833; c=relaxed/simple;
	bh=x724WoogbYSJVjFl57oAnXSNVzLKq0lGnIr0FldF15s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2DjlvBY6shej0ggFUBmRIXa9IePJkj7QkuP5D7Vnz1S8yo6OzE9lBF9ejGdfSLRdUhQc48i/rz7r2CszCxsxEg9G61gXyOwlwNdONzfg9HO5EyTDbHYRAkPQ3OQ8pO2Lj9W7/NvPQVzY/by+oUEOPefDtsTzCdb2IIz0cnS6FM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Hy8Nn9rC; arc=fail smtp.client-ip=52.101.52.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WU0ek1Vycn5YFK6YZ3nWO5T0c3akarf4dwOQJh2ZGN7FFCbRkUd6ZTNAJloRzyrt3r8K0Uvvk6WK6ZN0cX+tkVyKYC/0B551rcpezMlDhStrxnrMzmLvIbyfQCv6Gh9n29/0hp27Ii/f+5Gg03Lw5oUOJ8oBkvLqSrP2TIiJksDgF7HyhB11tfMszooEHxn1yZ4GYaYmNYypZu9PdLgfrqOYF137nNcqLJ8k5eZ0zkLKFhV5u7aSAaZS9RWa8xIkjR4SppPAzR+qfjtHEi2q09VCQ/5QwYKYCd1w5sFChFtZKKXG3bnWxBoipVNB7QytLp0i0LP97EeR78krWwblKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GcExelvZHgLHmnH/LZ0YNu1y/pUMQdmMrtdtUrutEo=;
 b=cbcPvTI+fqxIJLqghFeRO3Uz+gX9LjveiJwsj5c4GldUmTDKQwv1tXLwbwCFypZ78Nt4V7lLVJwnQe3V1Kjj9ml1GryX95RGEEE5WUrkxhNE56bMX2N2b0a5KVf2adB6Q+L+WRNwbU8QWPpWldwJhWF8mCmH1Yu1IAK05XFqYEZjs1uRSxaAAkoqVnchkRgSRu6BhsSrkw4QM2OR8nRj/kDhgX9Yz1fD4nhsnBV2IaX+QFu+tKim6cb/Um9SjlO+NWwTZBwwyn51t3SvfJi+QGSU/qxo7ASr9sYdQyAJNvEE4m41rYycBUCJnWeMqM6dD+Fk8KdMS4TFXDvOn9TDCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GcExelvZHgLHmnH/LZ0YNu1y/pUMQdmMrtdtUrutEo=;
 b=Hy8Nn9rCuPQCiq/WwgGMlYb5xZ61EO6wcGlPu4OLwh4n0Q1MYzeZTsg4MepAEN6eUw9fnXIe3f9Fr6IT5elrxdy+f/jbxPfIPqF5HvDLA+q7R3r8OWWwuTfz8xmka/5r6XFU8jv7iJqS/b4et4d7a6mmCzy1QlzoNRx8DQ90Gw8=
Received: from CH2PR18CA0008.namprd18.prod.outlook.com (2603:10b6:610:4f::18)
 by DM4PR10MB6693.namprd10.prod.outlook.com (2603:10b6:8:113::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 04:10:27 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::cd) by CH2PR18CA0008.outlook.office365.com
 (2603:10b6:610:4f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Fri,
 31 Oct 2025 04:10:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 04:10:24 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 23:10:13 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 23:10:13 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Oct 2025 23:10:13 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59V4ADZu3280795;
	Thu, 30 Oct 2025 23:10:13 -0500
Date: Thu, 30 Oct 2025 23:10:13 -0500
From: Nishanth Menon <nm@ti.com>
To: "Thomas Richard (TI.com)" <thomas.richard@bootlin.com>
CC: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Gregory CLEMENT
	<gregory.clement@bootlin.com>, Richard Genoud <richard.genoud@bootlin.com>,
	Udit Kumar <u-kumar1@ti.com>, Prasanth Mantena <p-mantena@ti.com>, "Abhash
 Kumar" <a-kumar2@ti.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: ti_sci: set IO Isolation only if the firmware
 is capable
Message-ID: <20251031041013.kfyveddq7rkmtvfv@wince>
References: <20251014-ti-sci-io-isolation-v1-1-67c7ce5d1b63@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251014-ti-sci-io-isolation-v1-1-67c7ce5d1b63@bootlin.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|DM4PR10MB6693:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a751068-1f97-4374-fd74-08de18336a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|34020700016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4YKfbbKdHiKShwfSzTEqvMMFjGPOA95b8itDZ7idVvcM0Pcdcj4c9RpoOh1J?=
 =?us-ascii?Q?m7EWbRUuYq+OIogriOWEpzGTVhcgY/krAKVKufOBlHelBdf03QdNQF9/wAjB?=
 =?us-ascii?Q?D77wq5gDJJbDy8rPZPlP/HFO29ejqYa7/TpNrV+7MSLBAVKlEpZdRJUNYw0g?=
 =?us-ascii?Q?JsdgNsUsMTKWngOOVA6ReGdhmQNpY4hJyvelNY5BVgzVeDKyhWS32wAMUkn7?=
 =?us-ascii?Q?Htkhg2/H5KJ3YAkxaeWbOl7MmItgwsrwt/wN1OWYY5KCSZYMu1DwrLJB8jdB?=
 =?us-ascii?Q?3Tbk+PNpZgQUY7vxUylesRcRfyBR6CyxEgpubFDE7OI6A9qvFJck9YGg7Ogj?=
 =?us-ascii?Q?WXMbAhoJPy+8yI4Q6P0DCcE2jDfPXn4BqPJaXN6/YQsIttwQOqlPrVVgsHjf?=
 =?us-ascii?Q?J/4eKswcPdJMCwebF8Pd9dfOBqXND7IA5b4DaE+hsBiQ+8wmiEdcAGaZnJLb?=
 =?us-ascii?Q?rY+rkPSS1maebIxVYHM88Togo/8dk2PukZXyCeJCZX5LX+bNeeRDGbXTRqNU?=
 =?us-ascii?Q?CLH3Rm8VZMEFW7TaEBwtBKl/LVt62DpxSy6ukvppXsbN0qydhqwHP7DjhAgb?=
 =?us-ascii?Q?cAnriFA9seGQMfKITcVLqtrSKpVlMrapE8fRlCNlcAMMkEMJPkDBN7c9rwX+?=
 =?us-ascii?Q?HNqdzxJIdtZFBW771Bw/Wh+BfIE7vGBXtN3vXi6aM0vt+6c4d2I34tQNWIiR?=
 =?us-ascii?Q?GoKjJ1yNHu18Y+iPspa/gmbdcA6XAWSKETBVvX9X6OuSLTLxz3UhW4X1EWu2?=
 =?us-ascii?Q?pAj1zw3bur9Y+mawARgmLuKkW+P2xKYyApAFq1cCBX/MoAqRVMCz2rQaDfkS?=
 =?us-ascii?Q?up8lkaF7cag+ys84ijd163I5yPWHlJAVE9cf/JpJCbVVRiWVKEJfUUIkzQ2a?=
 =?us-ascii?Q?qKswG9oNMXmfhEKBtOY4PEdlgbWF6Q3AMgsBuHKsUVIHwh2ZfUtOc2xE9N6I?=
 =?us-ascii?Q?a7GuScDyPxNMdNionVxG0E9zWopF0pvqgyi19qw+Osew5hJESWiyYDfGabkN?=
 =?us-ascii?Q?M1oe2BDy1wYxsoSzooUhuB/9Ve/zyvA9tl5T/E7DhZ+UHFG/CZhKv7I9vIAg?=
 =?us-ascii?Q?EOSIZe+I4k6B4LsaPzRPB6Njj5kM6oNV4ZVanggtmboCsrA44dzdM7Lu+Y7X?=
 =?us-ascii?Q?0K+W+JEAn39+C4+Ge8T72w9khQlJ9zt9ZUtz7NarVOyOjBsw6BnNzWXa2i1M?=
 =?us-ascii?Q?fJ5RO6I5b8fYioeaaZGA1bcIuIEs5eOwbdaxGM6vfSLzlzjgDzuV7bvT/0kq?=
 =?us-ascii?Q?ywqx0Pdk2AAtiD7VIurrCaD97j4gyMMqdKHWNE7jTtFbJHp2XKwk3IVZHRHb?=
 =?us-ascii?Q?re623KJuWADZPaP4LPiIcXAGa1DrWJlkvinl+k1g7HRyiJngaMsbO3NCXmAK?=
 =?us-ascii?Q?Y3M5PZBOs35aoFd4KDuphMFQzTa9m1ZvF6upw/qMK6X50s6Rp4b5vIFCYle4?=
 =?us-ascii?Q?Pz1MKkRmc0KjF6ukjC9RHqDnqp2WgC023GgVKxo4N6bUbEBmW9qKv7Zq3jYv?=
 =?us-ascii?Q?VTK6Z+EhtaRCIgwnmsPsbD60GEuQB2DtmRmePxshefufrr6LHz0A14fckfMd?=
 =?us-ascii?Q?kwzr3W0WJWlt/KUJ6cY=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(34020700016);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 04:10:24.0388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a751068-1f97-4374-fd74-08de18336a6b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6693

On 10:31-20251014, Thomas Richard (TI.com) wrote:
> Add the IO_ISOLATION firmware capability, and set IO Isolation during
> suspend only if the firmware is capable.

How about:
Prevent calling ti_sci_cmd_set_io_isolation() on
firmware that does not support the IO_ISOLATION capability. Add
the MSG_FLAG_CAPS_IO_ISOLATION capability flag and check it before
attempting to set IO isolation during suspend/resume operations.

Without this check, systems with older firmware may experience
undefined behavior or errors when entering/exiting suspend states.

> 
> Fixes: ec24643bdd62 ("firmware: ti_sci: Add system suspend and resume call")
> Signed-off-by: Thomas Richard (TI.com) <thomas.richard@bootlin.com>
> ---
>  drivers/firmware/ti_sci.c | 21 +++++++++++++--------
>  drivers/firmware/ti_sci.h |  2 ++
>  2 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 49fd2ae01055d0f425062147422471f0fd49e4bd..8d96a3c12b36a908097805b44dc3343172fbbfec 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -3751,9 +3751,11 @@ static int __maybe_unused ti_sci_suspend_noirq(struct device *dev)
>  	struct ti_sci_info *info = dev_get_drvdata(dev);
>  	int ret = 0;
>  
> -	ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_ENABLE);
> -	if (ret)
> -		return ret;
> +	if (info->fw_caps & MSG_FLAG_CAPS_IO_ISOLATION) {
> +		ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_ENABLE);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	return 0;
>  }
> @@ -3767,9 +3769,11 @@ static int __maybe_unused ti_sci_resume_noirq(struct device *dev)
>  	u8 pin;
>  	u8 mode;
>  
> -	ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_DISABLE);
> -	if (ret)
> -		return ret;
> +	if (info->fw_caps & MSG_FLAG_CAPS_IO_ISOLATION) {
> +		ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_DISABLE);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	ret = ti_sci_msg_cmd_lpm_wake_reason(&info->handle, &source, &time, &pin, &mode);
>  	/* Do not fail to resume on error as the wake reason is not critical */
> @@ -3928,11 +3932,12 @@ static int ti_sci_probe(struct platform_device *pdev)
>  	}
>  
>  	ti_sci_msg_cmd_query_fw_caps(&info->handle, &info->fw_caps);
> -	dev_dbg(dev, "Detected firmware capabilities: %s%s%s%s\n",
> +	dev_dbg(dev, "Detected firmware capabilities: %s%s%s%s%s\n",
>  		info->fw_caps & MSG_FLAG_CAPS_GENERIC ? "Generic" : "",
>  		info->fw_caps & MSG_FLAG_CAPS_LPM_PARTIAL_IO ? " Partial-IO" : "",
>  		info->fw_caps & MSG_FLAG_CAPS_LPM_DM_MANAGED ? " DM-Managed" : "",
> -		info->fw_caps & MSG_FLAG_CAPS_LPM_ABORT ? " LPM-Abort" : ""
> +		info->fw_caps & MSG_FLAG_CAPS_LPM_ABORT ? " LPM-Abort" : "",
> +		info->fw_caps & MSG_FLAG_CAPS_IO_ISOLATION ? " IO-Isolation" : ""
>  	);
>  
>  	ti_sci_setup_ops(info);
> diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
> index 701c416b2e78f8ef20ce6741a88ffa6fd4853b2d..7559cde17b6ccfeeb1bc357fce5c5767c3f75c54 100644
> --- a/drivers/firmware/ti_sci.h
> +++ b/drivers/firmware/ti_sci.h
> @@ -149,6 +149,7 @@ struct ti_sci_msg_req_reboot {
>   *		MSG_FLAG_CAPS_LPM_PARTIAL_IO: Partial IO in LPM
>   *		MSG_FLAG_CAPS_LPM_DM_MANAGED: LPM can be managed by DM
>   *		MSG_FLAG_CAPS_LPM_ABORT: Abort entry to LPM
> + *		MSG_FLAG_CAPS_IO_ISOLATION: IO Isolation support
>   *
>   * Response to a generic message with message type TI_SCI_MSG_QUERY_FW_CAPS
>   * providing currently available SOC/firmware capabilities. SoC that don't
> @@ -160,6 +161,7 @@ struct ti_sci_msg_resp_query_fw_caps {
>  #define MSG_FLAG_CAPS_LPM_PARTIAL_IO	TI_SCI_MSG_FLAG(4)
>  #define MSG_FLAG_CAPS_LPM_DM_MANAGED	TI_SCI_MSG_FLAG(5)
>  #define MSG_FLAG_CAPS_LPM_ABORT		TI_SCI_MSG_FLAG(9)
> +#define MSG_FLAG_CAPS_IO_ISOLATION	TI_SCI_MSG_FLAG(7)
>  #define MSG_MASK_CAPS_LPM		GENMASK_ULL(4, 1)
>  	u64 fw_caps;
>  } __packed;
> 
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20251013-ti-sci-io-isolation-63a8bcd9d4e9
> 
> Best regards,
> -- 
> Thomas Richard (TI.com) <thomas.richard@bootlin.com>
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

