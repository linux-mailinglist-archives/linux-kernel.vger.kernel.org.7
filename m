Return-Path: <linux-kernel+bounces-898746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0D3C55EAA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DEC94E2E53
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 06:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E8F3203BA;
	Thu, 13 Nov 2025 06:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M/SODdCz"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010021.outbound.protection.outlook.com [52.101.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E47C320387
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763014887; cv=fail; b=bOFdc7oRHbBZ3zWm41UYF4Jze0+PidsAEaxO1MyYtE6/zYGD7dPbrY/GCahQDU/YqKrQ5wUvfJJAIBNkKpi8FHB5Q4bHEbBzImASwslSSk0AB+mU41e4vn5U6kBE89EpzJ4gftKJJcLWAyA8WYUGMaYAiBfnXnhFsMScHhhuuNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763014887; c=relaxed/simple;
	bh=zXRKDOWLm9uxrpGsF/mOcxpAC9mq/3oTC5oPwqhXbJk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNnKKujTqmLXdzj8XHE1qe/VAvy6wbRkqgMHWAzrkUKh4UCVEd9GCOi4M3HnURA2/OJLchYtFz4vEjvdxrCWtrR1ZyEWove0H9T4/IrsspM71rEazkUAblf3nRi2RpbsridAra9B+OU/Vz1U52ukhEeUMzEqdShBb1KW0DFm5Ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=M/SODdCz; arc=fail smtp.client-ip=52.101.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpaeJep0n963dEUareXgWy8xiOeBymmBwDQoyXT3fje584RxrCgDap9+nnwu34ObPX5BJStQUpKwcihqJ0nGoZhHeyggg3ZwChVKD4rMGGKCw61NrdAuMeQe/iL3vZWpaVeu56ydOBd0AEka9ISDFaadkABvDKp953v+kJVXXQNehMI6+ysHFBFsEon7jdX8/wSYlnOP6NEiyxbI8hAUlibcYQEEO9Pat72xfekcv8n096RwAY6qc2f/eROAEu08MYG+JOEEWEhoO8JgkGtMCpPcOQVSUwxyBKsw6yNXRDoswp2c1fiZGpjl8QpKKRctiKW3ZpaPXjhAv04smBRqRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+O51X/BMpBBEdJ0NRkQN+4zXcaMm2aqmHp+UN1OTgUE=;
 b=kdyVRdb3ILKmZVS6f4Fvovjtp9vidZ24WFcRcKDJqig9foFdTcYJEnVZi8bAuFOrnj7D7LJnEFylthKXjzY0F+QdlDMaudHeki7bHrQLDT8U8K4jTqYqz5lOivwwewMLTe2jpJkiw+lk/6rWilnvw+QEy/a1H0Oks9Dr33diJZBgGnbMyheFh2H3VtCG7Yv1Z971dkCD5qolfKXfoAeHhwz6hU1ykEj4XGQFawgSG35vVoLqdkIJYntUH91wZj7xrn+lS2toXweCM8Cv40gVdMpZDqWNFwqJ1i9BUZt1bmJTv/u0diq6DiqZ8eoVyIODDfwQrPhZ2J12/NlPfdCVRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+O51X/BMpBBEdJ0NRkQN+4zXcaMm2aqmHp+UN1OTgUE=;
 b=M/SODdCzr2R61D6SpXEgpLzzYcuE2w8Qfq8DL4QaVb/z4L8xXZyZstjDLkX5XRD22+W0372bnKXX2C5gkbkZn/UUMZ0IeEHo+E+h7YsVxCVLiFUzOi2HKM3Vv063+B8Ch12Gk+lqVl3Ufiqtb6Cpt2XdKOIiUhe1wUW+56Xeoa0=
Received: from CH0P221CA0035.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::22)
 by BY5PR10MB4321.namprd10.prod.outlook.com (2603:10b6:a03:202::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 06:21:23 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::cd) by CH0P221CA0035.outlook.office365.com
 (2603:10b6:610:11d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 06:21:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 06:21:21 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 00:21:16 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 00:21:15 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 00:21:15 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AD6LE6j3956165;
	Thu, 13 Nov 2025 00:21:15 -0600
Date: Thu, 13 Nov 2025 11:51:14 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, "Santosh
 Shilimkar" <ssantosh@kernel.org>, Vishal Mahaveer <vishalm@ti.com>, "Kevin
 Hilman" <khilman@baylibre.com>, Sebin Francis <sebin.francis@ti.com>,
	"Kendall Willis" <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 2/3] firmware: ti_sci: Partial-IO support
Message-ID: <20251113062114.m5zgjgeg4xnvkany@lcpd911>
References: <20251103-topic-am62-partialio-v6-12-b4-v10-0-0557e858d747@baylibre.com>
 <20251103-topic-am62-partialio-v6-12-b4-v10-2-0557e858d747@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251103-topic-am62-partialio-v6-12-b4-v10-2-0557e858d747@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|BY5PR10MB4321:EE_
X-MS-Office365-Filtering-Correlation-Id: 0141569c-bc72-4a58-f83d-08de227cdcf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n+Qs+oen0c8187b9+WzRC5ETu503bPTvctyi+n1gTYIQqi3R2PMHJsernBxX?=
 =?us-ascii?Q?80o3U4zfmxUH3VVjrtqZZlivzyJciF5U05MEdXC5825HETJkLpCl5NuKk/PY?=
 =?us-ascii?Q?clPPYKbzR6pnALjLKXSuOGjTJsZafdNTQGqQHaVSGIeZ40NNRs438JrBPu8z?=
 =?us-ascii?Q?n9DFyeuVHUK2d6WQKQ9PzwKvgF2L9nlZeDH8hB+aPd+QPy5s4FgChBDUFD3e?=
 =?us-ascii?Q?ZZmXHhgCwFxRFFF719vxYJ7rVjYa8+qp8JVQRt2/SeX8HrrgxA7i8eeVcIXk?=
 =?us-ascii?Q?mXngJtWDK88xL4CfPmpO8F03aipYZ1wx+RZQVmYzzOyPWR4yIWkhF8OeeU9W?=
 =?us-ascii?Q?uqGHEcjQe6rw4vyGq6BtS7vxnTcs7kxUbNtNAKgmeTmLl9Orz0CBN7t23Yb7?=
 =?us-ascii?Q?lFOeKYg8lvukYqWFrCl4fwyAC/0DkDv8y9yJXmihVVmzd4lPbNRR1YNQYyVW?=
 =?us-ascii?Q?45oI/i/TIN3+fsikRKIcLFQJx663mdxXBGoWyLFAGpzH7DgpgQfrnUPtpMap?=
 =?us-ascii?Q?oOrPOA/7NZxXJgKdL+ABBDQTUg/xx3yHBLNnYdH4EN3l5X1jjNUHoh6vtjnL?=
 =?us-ascii?Q?iSMoelg34/v+BKHYtWloXR6+gsCTZ15oKMLIOt/+UDw7P8GMrJshPy1bDmbQ?=
 =?us-ascii?Q?/H5MCsyaYA+0HIGaskgtbdAKIPJpm3PEUzPy0ox+6/KnFZ0n0ywmhqr0DLzU?=
 =?us-ascii?Q?ElU4bHqciXdiudGQ+MG8yyINdpqeTxsVch8VSh+ZkRA+OEJPJ0aytWt9oh8b?=
 =?us-ascii?Q?hkJiabULmDE+X3+Yvaf8tnq68Jm+B9DBUXvUfYMaLlRMQm6jnNJAR/oyZeWi?=
 =?us-ascii?Q?msG0jJXnk09ysGD0SSEHpktUnM4zOL3AmLhFiCpBGel6PeZ9edKawcRgBghQ?=
 =?us-ascii?Q?RdE6M1ckwbXAQ4jk/khKJSAEnWoy4p23ZZveXrgfgy9YgP+0m84QDlhupJ3G?=
 =?us-ascii?Q?+s7KpWr7lKEb3USnHqzMD5o8kBPukQhlnTt0yHpv0RqpXYP4SJ3uzpm0IQL1?=
 =?us-ascii?Q?KSTCHCLY+wHAvC3/gb6Z3xcqhUUItEVnj/C0B39uePjyTUaIBp5UN3knXSqX?=
 =?us-ascii?Q?6Wb5ngzedkscDUdYIxHp0Czf6sx8lzNJTz4H20qISRdGpN/9JOB6vzjj0ji3?=
 =?us-ascii?Q?DERv0rVqepAlAxt7lHDOiK43xC70fqOqup9FFuDE6JbbrBPitIT96po9dzZs?=
 =?us-ascii?Q?eUMiDeVmtvS8Il+oM6OHpfqtRh0MHkr3jLDNWl2g5CsNz6zdO3KwSS/o2W9m?=
 =?us-ascii?Q?z1khrDOHmPmkEGUPzmmNhP0Q9Z3IobpF2vCAVvMLZVgHkW23Ke03eHynJj8G?=
 =?us-ascii?Q?IEx915RDuJJQNWD4w9syKzEEiz9IKu4+pUVaWhB9X4RPCxQjJHZEtXwoVv+q?=
 =?us-ascii?Q?7JDBB/ULOwrDhhnvZpYm9rpnoIigNH90TKgaK76ZoZGveawylaIGdZtYJJdj?=
 =?us-ascii?Q?54NW+hXosJEzjhRWeKRx2tx5oiVnFF/CemjGTJpEiKc61Wnlt6W1Gc39FWQJ?=
 =?us-ascii?Q?kfgzuvxxK7SrCe9Gf+03zSS/WJ1s+niwNZnDiwEEiSNFHiiWF+w1HHGYfNEj?=
 =?us-ascii?Q?OKy0E8CMr7Js1bP7JFo=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 06:21:21.1013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0141569c-bc72-4a58-f83d-08de227cdcf3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4321

On Nov 03, 2025 at 13:42:20 +0100, Markus Schneider-Pargmann (TI.com) wrote:
> Add support for Partial-IO poweroff. In Partial-IO pins of a few
> hardware units can generate system wakeups while DDR memory is not
> powered resulting in a fresh boot of the system. These hardware units in
> the SoC are always powered so that some logic can detect pin activity.
> 
> If the system supports Partial-IO as described in the fw capabilities, a
> sys_off handler is added. This sys_off handler decides if the poweroff
> is executed by entering normal poweroff or Partial-IO instead. The
> decision is made by checking if wakeup is enabled on all devices that
> may wake up the SoC from Partial-IO.
> 
> The possible wakeup devices are found by checking which devices
> reference a "Partial-IO" system state in the list of wakeup-source
> system states. Only devices that are actually enabled by the user will
> be considered as an active wakeup source. If none of the wakeup sources
> is enabled the system will do a normal poweroff. If at least one wakeup
> source is enabled it will instead send a TI_SCI_MSG_PREPARE_SLEEP
> message from the sys_off handler. Sending this message will result in an
> immediate shutdown of the system. No execution is expected after this
> point. The code will wait for 5s and do an emergency_restart afterwards
> if Partial-IO wasn't entered at that point.
> 
> A short documentation about Partial-IO can be found in section 6.2.4.5
> of the TRM at
>   https://www.ti.com/lit/pdf/spruiv7
> 
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---

Reviewed-by: Dhruva Gole <d-gole@ti.com>


>  drivers/firmware/ti_sci.c | 109 +++++++++++++++++++++++++++++++++++++++++++---
>  drivers/firmware/ti_sci.h |   5 +++
>  2 files changed, 107 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 2585cb82d1ad8e3d79bca458a2b86cc81a3e627b..811507ded63ac784ad6c6ad77b2f827768f3f3c7 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -1673,6 +1673,9 @@ static int ti_sci_cmd_clk_get_freq(const struct ti_sci_handle *handle,
>  static int ti_sci_cmd_prepare_sleep(const struct ti_sci_handle *handle, u8 mode,
>  				    u32 ctx_lo, u32 ctx_hi, u32 debug_flags)
>  {
> +	u32 msg_flags = mode == TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO ?
> +			TI_SCI_FLAG_REQ_GENERIC_NORESPONSE :
> +			TI_SCI_FLAG_REQ_ACK_ON_PROCESSED;
>  	struct ti_sci_info *info;
>  	struct ti_sci_msg_req_prepare_sleep *req;
>  	struct ti_sci_msg_hdr *resp;
> @@ -1689,7 +1692,7 @@ static int ti_sci_cmd_prepare_sleep(const struct ti_sci_handle *handle, u8 mode,
>  	dev = info->dev;
>  
>  	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_PREPARE_SLEEP,
> -				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
> +				   msg_flags,
>  				   sizeof(*req), sizeof(*resp));
>  	if (IS_ERR(xfer)) {
>  		ret = PTR_ERR(xfer);
> @@ -1709,11 +1712,12 @@ static int ti_sci_cmd_prepare_sleep(const struct ti_sci_handle *handle, u8 mode,
>  		goto fail;
>  	}
>  
> -	resp = (struct ti_sci_msg_hdr *)xfer->xfer_buf;
> -
> -	if (!ti_sci_is_response_ack(resp)) {
> -		dev_err(dev, "Failed to prepare sleep\n");
> -		ret = -ENODEV;
> +	if (msg_flags == TI_SCI_FLAG_REQ_ACK_ON_PROCESSED) {
> +		resp = (struct ti_sci_msg_hdr *)xfer->xfer_buf;
> +		if (!ti_sci_is_response_ack(resp)) {
> +			dev_err(dev, "Failed to prepare sleep\n");
> +			ret = -ENODEV;
> +		}
>  	}
>  
>  fail:
> @@ -3667,6 +3671,78 @@ devm_ti_sci_get_resource(const struct ti_sci_handle *handle, struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_ti_sci_get_resource);
>  
> +/*
> + * Iterate all device nodes that have a wakeup-source property and check if one
> + * of the possible phandles points to a Partial-IO system state. If it
> + * does resolve the device node to an actual device and check if wakeup is
> + * enabled.
> + */
> +static bool ti_sci_partial_io_wakeup_enabled(struct ti_sci_info *info)
> +{
> +	struct device_node *wakeup_node = NULL;
> +
> +	for_each_node_with_property(wakeup_node, "wakeup-source") {
> +		struct of_phandle_iterator it;
> +		int err;
> +
> +		of_for_each_phandle(&it, err, wakeup_node, "wakeup-source", NULL, 0) {
> +			struct platform_device *pdev;
> +			bool may_wakeup;
> +
> +			/*
> +			 * Continue if idle-state-name is not off-wake. Return
> +			 * value is the index of the string which should be 0 if
> +			 * off-wake is present.
> +			 */
> +			if (of_property_match_string(it.node, "idle-state-name", "off-wake"))
> +				continue;
> +
> +			pdev = of_find_device_by_node(wakeup_node);
> +			if (!pdev)
> +				continue;
> +
> +			may_wakeup = device_may_wakeup(&pdev->dev);
> +			put_device(&pdev->dev);
> +
> +			if (may_wakeup) {
> +				dev_dbg(info->dev, "%pOF identified as wakeup source for Partial-IO\n",
> +					wakeup_node);
> +				of_node_put(it.node);
> +				of_node_put(wakeup_node);
> +				return true;
> +			}
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +static int ti_sci_sys_off_handler(struct sys_off_data *data)
> +{
> +	struct ti_sci_info *info = data->cb_data;
> +	const struct ti_sci_handle *handle = &info->handle;
> +	bool enter_partial_io = ti_sci_partial_io_wakeup_enabled(info);
> +	int ret;
> +
> +	if (!enter_partial_io)
> +		return NOTIFY_DONE;
> +
> +	dev_info(info->dev, "Entering Partial-IO because a powered wakeup-enabled device was found.\n");
> +
> +	ret = ti_sci_cmd_prepare_sleep(handle, TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO, 0, 0, 0);
> +	if (ret) {
> +		dev_err(info->dev,
> +			"Failed to enter Partial-IO %pe, trying to do an emergency restart\n",
> +			ERR_PTR(ret));
> +		emergency_restart();
> +	}
> +
> +	mdelay(5000);
> +	emergency_restart();
> +
> +	return NOTIFY_DONE;
> +}
> +
>  static int tisci_reboot_handler(struct sys_off_data *data)
>  {
>  	struct ti_sci_info *info = data->cb_data;
> @@ -3946,6 +4022,19 @@ static int ti_sci_probe(struct platform_device *pdev)
>  		goto out;
>  	}
>  
> +	if (info->fw_caps & MSG_FLAG_CAPS_LPM_PARTIAL_IO) {
> +		ret = devm_register_sys_off_handler(dev,
> +						    SYS_OFF_MODE_POWER_OFF,
> +						    SYS_OFF_PRIO_FIRMWARE,
> +						    ti_sci_sys_off_handler,
> +						    info);
> +		if (ret) {
> +			dev_err(dev, "Failed to register sys_off_handler %pe\n",
> +				ERR_PTR(ret));
> +			goto out;
> +		}
> +	}
> +
>  	dev_info(dev, "ABI: %d.%d (firmware rev 0x%04x '%s')\n",
>  		 info->handle.version.abi_major, info->handle.version.abi_minor,
>  		 info->handle.version.firmware_revision,
> @@ -3955,7 +4044,13 @@ static int ti_sci_probe(struct platform_device *pdev)
>  	list_add_tail(&info->node, &ti_sci_list);
>  	mutex_unlock(&ti_sci_list_mutex);
>  
> -	return of_platform_populate(dev->of_node, NULL, NULL, dev);
> +	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
> +	if (ret) {
> +		dev_err(dev, "platform_populate failed %pe\n", ERR_PTR(ret));
> +		goto out;
> +	}
> +	return 0;
> +
>  out:
>  	if (!IS_ERR(info->chan_tx))
>  		mbox_free_channel(info->chan_tx);
> diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
> index 701c416b2e78f8ef20ce6741a88ffa6fd4853b2d..09eaea54dd5cabce72dd1652c9603e3ab446b60c 100644
> --- a/drivers/firmware/ti_sci.h
> +++ b/drivers/firmware/ti_sci.h
> @@ -595,6 +595,11 @@ struct ti_sci_msg_resp_get_clock_freq {
>  struct ti_sci_msg_req_prepare_sleep {
>  	struct ti_sci_msg_hdr	hdr;
>  
> +/*
> + * When sending prepare_sleep with MODE_PARTIAL_IO no response will be sent,
> + * no further steps are required.
> + */
> +#define TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO				0x03
>  #define TISCI_MSG_VALUE_SLEEP_MODE_DM_MANAGED				0xfd
>  	u8			mode;
>  	u32			ctx_lo;
> 
> -- 
> 2.51.0
> 

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

