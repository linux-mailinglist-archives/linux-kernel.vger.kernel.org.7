Return-Path: <linux-kernel+bounces-811078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6E9B5241E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 00:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ABE41B25F2F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC3E30BBB7;
	Wed, 10 Sep 2025 22:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nVEWy6fs"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010034.outbound.protection.outlook.com [52.101.69.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583C825D1F7;
	Wed, 10 Sep 2025 22:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757542741; cv=fail; b=YkA7TtmlbWei4Xg89y2x3uFqRdozjFyjpNILezET6TSRbIrrUQ7qcodXSKUn9H5V9sOR+YF2p1vHyohnvd5P8kY18P1KyEpGlOdn0PJFjs7ZPqpDBbtD9+LD9NFL1vzMcIlELX6+sCCT542++9zTJPBrco4onsq8dgsXmdP9YFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757542741; c=relaxed/simple;
	bh=r7qC55z1cRTJlEVo5rHnqTqPE8XzJ/GOxCQhxllVhV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=doAFoD6jQ13eT5lwtBM5hu0sZc4uh0i4B1kDjtPc3FAnXsnKfjrySRw5AkYjUSwZpB5pkcQBhDRTrPDj/Blqh3mq79zV2sbZN1ofMILU6bNJt8rNuSezx8InOjVEBii1+jcmBJYHk2wjqYTNHOkWQh5TTSnEP5KTWmLTNenx0T4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nVEWy6fs; arc=fail smtp.client-ip=52.101.69.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YiICgEMRChb9Z2InRvPxHEp5mtacBdfEb4+SkncoqveXhylzYNbR6fhYfrrhl10pIJqvWo7eUtcM+Em3WM6bwTJvL28/HBzLj4+x6XhWvky6rO78mxmQb42uuobdsGrIEYbsn31nqpszX9JOWEXKP+e2K13R0CFp5VKtc0nWZWjdrU+1hlB9i/R7y0m6At5xITaH7ifHWWR14COIOwNs4qsOhYmdMrUkcaTo9kNbQtvxy0ay5l659HdUL8y4UN1Htq5y5K3V9FFjS3CoWfGcL2nO2KreqDjLtbhKKdekklrATdP097nBm5pFafLa8UeH8FvTHFYimJW79PPGuw9dBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzuw1pVGwNa75m/uRnFC3/33r0by5Xr685mD6O7T6gg=;
 b=M565mYgqFScR4R+OdpA8e16akG5SwO0DT0Gd9DQzccVW2m6RDTNRjPHfB5927brnVsz7K2QImarHxoeBOoT7ZGLGYZQ4ilyiRZKcRj3h1pjQHcrY7uj77smOqaFD+nae3+6JpBD/iG9bCTdFeuC8ZC8wG3lznFCRwfNov+Jhet5mi4DYNtxhRPIUKaJsaQCoKIuWYbSy7K+BPgdrLJiogYbm5W903oNG6s+ltdBJW5JEXPlr+6hJsO7rfofcSQRQKmEC4kTm7JsEZgK054BrMAgXR7TrCMpTw3Z3ogeIChqIQkcB4+8+tZAYOwkZJr7Ae/cawnE0cEUm/caLBS6Y8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzuw1pVGwNa75m/uRnFC3/33r0by5Xr685mD6O7T6gg=;
 b=nVEWy6fs2lCCC3mCqBH1WLHm2Nb9i9XuBQAbMhql/9VkrYxG7ONhK4BIAmiYqD5KaTD25OgFlYfklJWx+qO+HiuhkAy/ROQvSs2efvvv4+UHT9bV5+JPP44q2ucA7cur0r8KCwhUFaAODqNTUZLCBut460+cS/sNl3yYy7NteDDFWdhmDmSmgy+TR0BxIFM1+WrU+3H0nP/OLM41EMjYfHz+Kz6tuHr2fBdudrRSh8u3IShoJiq2XrCel3sY9euWC4ZuYv7QcHeoI9H7zLiqoTmQEtocG6OKqFs/5YKCnEQ9+LrWKTzI5PNLe8eOwNAIkGHvQ+AiJKSSR1OFLmTJCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by PA1PR04MB10939.eurprd04.prod.outlook.com (2603:10a6:102:489::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Wed, 10 Sep
 2025 22:18:51 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 22:18:51 +0000
Date: Wed, 10 Sep 2025 18:18:39 -0400
From: Frank Li <Frank.li@nxp.com>
To: Ze Huang <huang.ze@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v7 1/2] dt-bindings: usb: dwc3: add support for SpacemiT
 K1
Message-ID: <aMH5P3Xae0MCt6wu@lizhi-Precision-Tower-5810>
References: <20250729-dwc3_generic-v7-0-5c791bba826f@linux.dev>
 <20250729-dwc3_generic-v7-1-5c791bba826f@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729-dwc3_generic-v7-1-5c791bba826f@linux.dev>
X-ClientProxiedBy: PH7P221CA0007.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::10) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|PA1PR04MB10939:EE_
X-MS-Office365-Filtering-Correlation-Id: 3554f022-3735-472b-8c75-08ddf0b8033e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|7416014|376014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EaaekCyVIlsYMUiLxDiQYQnPVamdbBtvpP6K2r8Dok8eyssTiRGEh36F8+rK?=
 =?us-ascii?Q?EEQ3e9RxyloQWjkupCqS19c2XExo3tjsF9JuJDyeEalobbZYkCnDq/nypF/o?=
 =?us-ascii?Q?lPJwUb173I6/0sVAZ77FWd1ggHnQ7dtF7nRGJgBQWEIPzVhU4P6b7cN7J4uv?=
 =?us-ascii?Q?Dpt8goAAnjLdIl723MOfo/UXL5c+vYxVz3qgBpPa2qZoEku39CP75Ipc9bC8?=
 =?us-ascii?Q?f6ImzpQ1VS0YECQF3wp3vZDeHpcy84DHhLojyhs0kxKsjphZBh2EIuFPKnBR?=
 =?us-ascii?Q?ga6/TeJZX2SpKbvNPuS+NF+zIjdXQpWxjBE8gRKuzdDDcbnuDrPeH8Cs5999?=
 =?us-ascii?Q?p8sPJoXmAja5leZEoTR6reatTFwzWq4BMs0WoZ3Mwjxazpyv9/1wk2CwR6m6?=
 =?us-ascii?Q?qFmJqpxIP39M5AwBJaH70nQ02unuW8PGU3tBnAcsPXXB8jI/coJxe0fdvo4S?=
 =?us-ascii?Q?uZpDWg851F8mJOYnFoQhHgvoUGWdLSvF/COkvdEEFFCL7vpP84+Hts8LDKwj?=
 =?us-ascii?Q?lgk5jNrgNCDFn5Eh8PKeFHVEjUohHJKi042DOeDChzpO/8rkLv2JjkK3f+tO?=
 =?us-ascii?Q?oMWOArpiF5FaTah30c0QqteZAp/Sd+hBWR1K+BvaJzIZ5FjKiD7yikzITVeZ?=
 =?us-ascii?Q?W902uRrSKdvR5evT0zHP4GilyLCKsfg+ZieSSRWtbdWxWX4XnsgKhAWvimOL?=
 =?us-ascii?Q?5SF3/WioP3aGmic5wuF8BS58a4p1n9WWqxVMpIzQH9LzJSJPGjl3MpFEk1d7?=
 =?us-ascii?Q?+kEtHjIoxrfyr926X6gYgwyzWcEcrByhJ7jmL3KrB4yV9r08Jqi9LtKl1KiK?=
 =?us-ascii?Q?NQevznqxfOguihaKybwD2xuR7/d8z9nTff42K1J5qa/41/JzGEJKxq1JteX5?=
 =?us-ascii?Q?X3SDXOvS1FmW9BmnKghoyiai95jJeU6Kx7PDc2vg4GGldPTIivRl4QlGr0+u?=
 =?us-ascii?Q?cQfp+PbU5xBXlHoTPovA3AqawFH+BJ5A4mjD7lCIQg+Z1bHiQyMPcX5MZcfb?=
 =?us-ascii?Q?9YzCAEi6sIBF/HYkL/ekO1v22Hpi1W91+vDYj3//lUBCe3y9gWpmv6HehuBc?=
 =?us-ascii?Q?5BdaHzH67tqduLotd0yQ7XXe98t8kqkONmLwBhOMjLohig/m9rCHMSOqB4P6?=
 =?us-ascii?Q?z0k/KOV6VBX4oRv6WrwLmbS/OBPcNLO0o4Q/Hi99gtWM3mt5YN2Xb04SPhq3?=
 =?us-ascii?Q?E7JwuknZyakJfrullBQP20jwU7x/BZ/tZgQWa0d2mPQeHc95e/+qhZc84RRv?=
 =?us-ascii?Q?pGodCUPN5GuAKXB1GIMkJzw6NNWDtSgjFZZ9+6mFq3DhNB/Z8Ja9Vuc2aEjd?=
 =?us-ascii?Q?a0gehC0cUb8zW0DBqXpT23a+GrXWGoEEPBtRseYsz+jTvFQhFMEnmxpVS2wC?=
 =?us-ascii?Q?zccQRo9duPfDKBCEL16DkUFXZePVI0OSnwAa0Jl0PCnH6Co18fJLV9oVjs3h?=
 =?us-ascii?Q?ftxfR1Cc+P6s6b0F1IMQerC9fjVIsZB+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(7416014)(376014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5nnBuWo+dsSb1vsMkOySSkblRquXnoTABLN7YUyFueMyH43jxLxHY3uFxldj?=
 =?us-ascii?Q?71jlWPDNWxvhYmBuj3eBd5h2CloQ35zLvVBc6vl4HgjuHS/HJLqRlvehk+Sx?=
 =?us-ascii?Q?mtjiHNPGKjEprSXVKxK2NnbeCWHFWmMlwgsnxM+s/J1NixCu/RfbtmiIXWFW?=
 =?us-ascii?Q?KNvXPVljaRFjSxGkVYhc/e1fOHIp8RKzvcpSRFzmvpD4eoGqRXgOQGl5NF74?=
 =?us-ascii?Q?L/W21NZDfwX1Pt2x4AykLCwfCh08bdzU0G1Ehyt8/4DLpw/zKj71BaaQ5MpA?=
 =?us-ascii?Q?UsZropH9h0FrzlmdstHdVY2sN8Asq9gwPWwoMNS3iMzCx/8E7HxIYLxy7zgg?=
 =?us-ascii?Q?Xln7qWFGSdj3/6JF/oo42dd0BmLpeoeviPCo+tgBTpEnJK1J8uJAb/saBl/M?=
 =?us-ascii?Q?EQOjpOb5elFHzd8Vdohn8hzl7mbcWId6MmywT5v/qUA3CCPe/SDT/eEQLr/x?=
 =?us-ascii?Q?fVkGPm8j77YGRebihHD7CLvA3Kk42i8qQtNZvFGDyLMZcG5siZunXvUwKwES?=
 =?us-ascii?Q?1vo8z1FaWGOs2Cj/wT/XL+p0MLsTYawjXFKpGhvAh2L8LAy24GRXew11EgOy?=
 =?us-ascii?Q?3BCdrnmOIc87gQVhZ8R0thdERHatrK1eyDc4WZQ2kJxK2ElOGL1Ivf70zpbv?=
 =?us-ascii?Q?4yVTdmVH/+083HjFPNQWuW54zL3/uAelRdiyoAJcOJNXFKCGw/nivcwDuwIw?=
 =?us-ascii?Q?IHdRyElRpGAauihutsfz7e7yt4Jr01kGUnayQ7dEIGQw+S+6HWNMWB7qsAEH?=
 =?us-ascii?Q?FW711f2yTEvB1bDFVvuyYzJxMzNeGr3DVf0tCZSRqu6EuoeLt6H2BuPrSEwN?=
 =?us-ascii?Q?Yhj3HPa/IuUhK6CDbgHyaRwSIIlih8r3l/gElY0RXRYrb3z6ynT1+1SPbK7k?=
 =?us-ascii?Q?+SEvPNitaivz/n/DAS43I3dmZ2MimPavm9B8TydKTK48sEmWhLI7vq9qvQwU?=
 =?us-ascii?Q?x1sVKGZqLUeidiJws0jVF+r+Etx5glA/mgmaaDmXb5ibMcXxDAumEUiqQozn?=
 =?us-ascii?Q?xB3bqHoBntVT6EDZO7M8S0OY9MYOw9mQ+84ai8dKmNLsyOEhTm04vBji5kjf?=
 =?us-ascii?Q?ehN/PejTQkOwSZQylVBJX/ULrkr3nZvVe7AWyjSaHb97UCf0nTLeAXC5fkSX?=
 =?us-ascii?Q?6ZTL3SBdWZ3ORwClHGa80bUzmrUPPP+bBnTxJ0AGa8CneW9F8M2oyzPhdBay?=
 =?us-ascii?Q?Dw0c0UoWltgtTewGnRqG8B9M/b+nPZAofayXb77JkxzH/mVgZRmWiz+GVg5N?=
 =?us-ascii?Q?1WPzBEls4mPOwjiZgG0b2VC8oBYveB5pD3kZEs4KbJZ0Bzi2P/QS3P0WilCw?=
 =?us-ascii?Q?hSrCFbRdMjc9I27Ppc5OI8Fu2id0CkNCMQQaeHVx1W2hwRrohXp63GaSBACX?=
 =?us-ascii?Q?X/v/rtVOIwWClbtiyeN3dxoWcZ2MB4i+HkypTUmG53iQ7MTz3PCQ0mleaiUE?=
 =?us-ascii?Q?ChgyhER/MXSBr7ubTbyVRFNFGdnp5/uO5riH4eJ1QnKGPqz33AB9wIjOLD/c?=
 =?us-ascii?Q?7IEu8DGF+wQbk/vqZbeqyILaz1iStQWgSEOpiB0qCAJqNtrnSi5edH8gpKop?=
 =?us-ascii?Q?9e0gbP5kZ26EarYW3C/UxtG1ziWO7yxwdF7cgjUh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3554f022-3735-472b-8c75-08ddf0b8033e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 22:18:51.1354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHUr9a+TeqAjX4NciirvV1Mjt81t6lGUNkeVX/Kwkh7kxxTfn2O77K7Za6U7308Gp/24/z+ftaj4hy1an+zcsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10939

On Tue, Jul 29, 2025 at 12:33:55AM +0800, Ze Huang wrote:
> Add support for the USB 3.0 Dual-Role Device (DRD) controller embedded
> in the SpacemiT K1 SoC. The controller is based on the Synopsys
> DesignWare Core USB 3 (DWC3) IP, supporting USB3.0 host mode and USB 2.0
> DRD mode.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Ze Huang <huang.ze@linux.dev>
> ---

Ze Huang:

   I seen Krzysztof and Thinh Nguyen already acked this patches. Do you
wait for greg pick it up or need respin?

   My one layerscape usb patch depend on this one!

Frank

>  .../devicetree/bindings/usb/spacemit,k1-dwc3.yaml  | 124 +++++++++++++++++++++
>  1 file changed, 124 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/usb/spacemit,k1-dwc3.yaml b/Documentation/devicetree/bindings/usb/spacemit,k1-dwc3.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..7007e2bd42016ae0e50c4007e75d26bada34d983
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/spacemit,k1-dwc3.yaml
> @@ -0,0 +1,124 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/spacemit,k1-dwc3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SpacemiT K1 SuperSpeed DWC3 USB SoC Controller
> +
> +maintainers:
> +  - Ze Huang <huang.ze@linux.dev>
> +
> +description: |
> +  The SpacemiT K1 embeds a DWC3 USB IP Core which supports Host functions
> +  for USB 3.0 and DRD for USB 2.0.
> +
> +  Key features:
> +  - USB3.0 SuperSpeed and USB2.0 High/Full/Low-Speed support
> +  - Supports low-power modes (USB2.0 suspend, USB3.0 U1/U2/U3)
> +  - Internal DMA controller and flexible endpoint FIFO sizing
> +
> +  Communication Interface:
> +  - Use of PIPE3 (125MHz) interface for USB3.0 PHY
> +  - Use of UTMI+ (30/60MHz) interface for USB2.0 PHY
> +
> +allOf:
> +  - $ref: snps,dwc3-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: spacemit,k1-dwc3
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: usbdrd30
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  phys:
> +    items:
> +      - description: phandle to USB2/HS PHY
> +      - description: phandle to USB3/SS PHY
> +
> +  phy-names:
> +    items:
> +      - const: usb2-phy
> +      - const: usb3-phy
> +
> +  resets:
> +    items:
> +      - description: USB3.0 AHB reset
> +      - description: USB3.0 VCC reset
> +      - description: USB3.0 PHY reset
> +      - description: PCIE0 global reset (for combo phy)
> +
> +  reset-names:
> +    items:
> +      - const: ahb
> +      - const: vcc
> +      - const: phy
> +      - const: pcie0
> +
> +  reset-delay:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 2
> +    description: delay after reset sequence [us]
> +
> +  vbus-supply:
> +    description: A phandle to the regulator supplying the VBUS voltage.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - phys
> +  - phy-names
> +  - resets
> +  - reset-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    usb@c0a00000 {
> +        compatible = "spacemit,k1-dwc3";
> +        reg = <0xc0a00000 0x10000>;
> +        clocks = <&syscon_apmu 16>;
> +        clock-names = "usbdrd30";
> +        interrupts = <125>;
> +        phys = <&usb2phy>, <&usb3phy>;
> +        phy-names = "usb2-phy", "usb3-phy";
> +        resets = <&syscon_apmu 8>,
> +                 <&syscon_apmu 9>,
> +                 <&syscon_apmu 10>,
> +                 <&syscon_apmu 26>;
> +        reset-names = "ahb", "vcc", "phy", "pcie0";
> +        reset-delay = <2>;
> +        vbus-supply = <&usb3_vbus>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        hub_2_0: hub@1 {
> +            compatible = "usb2109,2817";
> +            reg = <1>;
> +            vdd-supply = <&usb3_vhub>;
> +            peer-hub = <&hub_3_0>;
> +            reset-gpios = <&gpio 3 28 1>;
> +        };
> +
> +        hub_3_0: hub@2 {
> +            compatible = "usb2109,817";
> +            reg = <2>;
> +            vdd-supply = <&usb3_vhub>;
> +            peer-hub = <&hub_2_0>;
> +            reset-gpios = <&gpio 3 28 1>;
> +        };
> +    };
>
> --
> 2.50.1
>

