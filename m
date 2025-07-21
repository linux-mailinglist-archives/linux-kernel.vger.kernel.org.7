Return-Path: <linux-kernel+bounces-739584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE174B0C82E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256AA1C20EF2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447D12E3396;
	Mon, 21 Jul 2025 15:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XD51qGFa"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011039.outbound.protection.outlook.com [52.101.65.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFCE2E3363;
	Mon, 21 Jul 2025 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753113136; cv=fail; b=WmoKs2uMmt35mKoPPorLSg7Q/cP4/jwTIPg10zhT6S+At+oSwFKcHtQYF0YVpfMtMGOx0UpeRuSRDyLNjlpJE7xEH6FIztpu3XXz+Xu2vfkVWcBv1PEcJtTZhigjoBySBIgpMoE9k++jfO40CSdWut3rqtVyEtuYcRO5oOGLNqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753113136; c=relaxed/simple;
	bh=lB8E1hpndIcVf9N88HkPxvJ/XRLzFKQcykn3wI/ihso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FxAyzmI9mZ56Te8zksyhFOz9aNCbdmvxWnMyNC1wSN4eb6bKXsonKqSJKBXE8hss/qNpX8nfOCotFgCx09lHphnf0Ge3ezp3v/H9eQb478fyFo+K8C5191QWRo/kS+RtvtlgpkTL7ZdpzomaA3RfaAi9VLzKKussXJH0U1f8Gv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XD51qGFa; arc=fail smtp.client-ip=52.101.65.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqIz8KKOnWBEA4578YUkx0dYDxNdgGiAwl5yybhWBooXDDpfw7r4KwUHwanJ7WCHk3GiZKTmOseMwcydq6LBErKpApv3NKTznTkAeVsd1qj32nW4k4ciDTojZqUxpIDBiNzJEz4LdkFiv9aM1etsOhjoWX/BSnVkWFhzbuXUQtw033OrItArgDJE1lXPZgC1EUipWTLlnNM2qoJuqoT9ONxpxva4zsLyEsv0Bm7CwUc2k6tGuo9MvC4DlviygCSllmxeG/hhfbGoz4zjXUXZXavSZVJNa9SYW8orbnweFET5dQjtCIau3MzsbDF3bCKDtEIcSaDWVrqxcNSOEcWuNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sl98lHr/lBvVShYVFKsZVQcXfKoH2ktLkkvelEYbJ08=;
 b=BU27i9TvSCX0RVELJRQbkgCV7/R2ahJAcFd26TgvuPvVenmoelaZG7MVCVY1s0TCfWwtaRimWONbe5ELpxvUwzE/tuop4YgwbNpacV1oZDHanXYt72gjrFnMDN/7C7CQPnAc9xIpMr9VWvE3sTBgvLdCgHT0CSx/F0dsCAgkvpmBZo3HivCBRC983vHmPMlyC6SaQxJp769Jqz954s991duXGarZI2CtIb93se6N5rUzRrEQ5LWUpLydM5rghllTNA1VX8Wa29NJ0oIlVEfSSGI3xDOwN4TIxssIcviXpxCEtyIQaPInkCqHWumUPUO69erSm6O+UQXJ55q8UWqJaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sl98lHr/lBvVShYVFKsZVQcXfKoH2ktLkkvelEYbJ08=;
 b=XD51qGFatuwHhWukwfXBA4fdL/LqCIIceD4tcTWPwbuY6Wz5smdRyJIt3OzXgkvK7bw0eMvMOQbPViEVrEI/80XBv+FOzkKhOeliSrmwHOCE1qDLGqTvlWpx0sUaF53Q87x5vAHN+xr1Zc3jjKQRk59uOhBn9K2NEWmDq3oK6TS0SPjlaUqTIAtW7Bfp/AdLHdNtQP7x40ZEC3yYA6+JML/vP6iOf4dx8rv+nbpU9gRthwSMNEoEIyp6g0H+MEDiqkHz+C7atuY5mAXgL1UfJBUxv2X5ZQjAOn9ef9w5byq/v+LFVGwmqQonWDF2vFSZ5tzH7WwGv/QqSI6CGJBPew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10329.eurprd04.prod.outlook.com (2603:10a6:150:1cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 15:52:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 15:52:10 +0000
Date: Mon, 21 Jul 2025 11:52:03 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: Re: [PATCH v2 1/3] arm64: dts: imx8mm-evk: support more sample rates
 for wm8524 card
Message-ID: <aH5iI0qR7eW6Yg7Z@lizhi-Precision-Tower-5810>
References: <20250721083433.25711-1-shengjiu.wang@nxp.com>
 <20250721083433.25711-2-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721083433.25711-2-shengjiu.wang@nxp.com>
X-ClientProxiedBy: AS4P190CA0060.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10329:EE_
X-MS-Office365-Filtering-Correlation-Id: 492dae1c-97d9-4d55-56c6-08ddc86e8d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tD+OKx0ujopFItz0gf3IQhsjRV3l0ysjCB1A1IVl7jnjxhzhOiWb/5Hgq8sz?=
 =?us-ascii?Q?HWcvKY8KBqBNquR9MQjQT/KmGGHxiooumZkzXaX3DjjyDb8dXyFhDMXGy/0T?=
 =?us-ascii?Q?habW/WvqgJKc40x8HWANmkmrYoZ7Tflo9ugoTEwMpO6fNhF+ow8gQTtc1U68?=
 =?us-ascii?Q?/LDfrH6b/1XEs+b2eTm+z7v+VNDeqgcu05TFm2SauIKTmldpj/GfpkZQRMLN?=
 =?us-ascii?Q?H3RDXim1gbiY80FY6Z/RVUBnmiAG6mje4OWVw2Y7z38kgE7VYcmtqN851psX?=
 =?us-ascii?Q?aO5dIjKkRABGHpcgyHISJoE1blb1bWPM4pdhC+n5rhHWcAr3QSS0WuamytK3?=
 =?us-ascii?Q?ZJfwNwJgZZmRLjhQwgmss/m3HFQDWu8r6aMS219wWZoU1C17iJAKn4liHOui?=
 =?us-ascii?Q?KXIqmML3BKi9psF1BvgAuivH60AzRPW4pb4IqRD77NQTz2nUEosulosgPtIq?=
 =?us-ascii?Q?XEf7wqT0w1z0/nqL/Fc61AIOSMnMNFvFvtNTr84gkOQTrgJFSUkGTD5F5P2O?=
 =?us-ascii?Q?f7Dc+lrZUWS/nfgzzSEeX/kj1Tn3oRf2bUYWtN/mteba1DSYJ0Rpc8VJ2lS6?=
 =?us-ascii?Q?wVZTA3MIs4vWN4ZUJY7A6cVBF1Nkp0W3XPaOxWvJZ5PZ0VBTIFIuslodx47w?=
 =?us-ascii?Q?QBwN5V9GRfKB/+ToTSUNt0/gAuN74XCrS8Iw4hlxwWzKXEU/8quiy74gUnxD?=
 =?us-ascii?Q?fXwOX7rwcK05xFkiw9OJwNDALPYWg1xE3RPgK6R4N7jQ7OB9siaZ1HXBjqIL?=
 =?us-ascii?Q?JIrjvtP0GnLZZtb63Evc0IYUyLuBd7mTYIGUrIJ3s8I+65HpDea6TL9ib9YR?=
 =?us-ascii?Q?Ob03RT6ZvC0Fk8PXN5ErtwrfzTFn1FioWEhraOQ7+Qh93T0+GH0/9+/Wsp9h?=
 =?us-ascii?Q?8w8FLgy9PkGVC9FZHvuBXriLTbG1jqJPyTOwLSexB5AeR1SCmYYvg5/NCJht?=
 =?us-ascii?Q?L7naug1tcHYpQtd5J1cj77mstgVgzAPVD9fG7aoQBtJPLsdyUF4PMNGqAF2x?=
 =?us-ascii?Q?5YF+qdI5kq3d0+Wt3JPP+6NK93hAPq4q1BC1+mtzHAymTGVE1PcYMLMuTgdV?=
 =?us-ascii?Q?cip/3cc6WzRn3Is0Auxb29AG06cRy/lWMiv91Y2TWC5Zkr8WLq5S61PlbAL/?=
 =?us-ascii?Q?ERUxCiCV/q0Smv7/WnJ/78bPeVqROReM0K9ruaTlbN+z/JvOBEdvy61uc8yv?=
 =?us-ascii?Q?sO/QPo4YqL4lIxR6GR8waBLlRdx+8+6gxr6/uqQ35rIotx+tSaiZFzwdILKH?=
 =?us-ascii?Q?B+gkIjQ7Fg7urna/sPcX+dCxvrwoz2YqpoipFIjl5x5ScfNDWODuvlCYf1ax?=
 =?us-ascii?Q?GJSnKVxyOnc+8FnUBYG+aBGQ64z8hicAQmJ6V65Rg+htT6fuW7RUlKIwtKUP?=
 =?us-ascii?Q?baNxNDGy2E4YfuYDvnbJKSrhe0K7fMcqZhjRhYVW8v0Rmc++2H3JIUsIrU1H?=
 =?us-ascii?Q?g/AHmkEEL6lgdgsXx4WWLdoewqC4zgjUpVybKtZchNdUITKbsTWBHw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hY9AMDp5d8bUQCWjbH6CWA5K8FRd7H9adA9jmIYDmICjn4ZsC3NAlnnB3FYQ?=
 =?us-ascii?Q?B81vRA7QOp86WRBteWO81wKgnueioqsT4Ty96580x1WF6+C1aQAH+Tv4YsAZ?=
 =?us-ascii?Q?eQZyrXGDaTo6dyCeD60yVkfR16RPjzZ83Wynyw4Nf3ZKX8EnDt4yyCINcwTi?=
 =?us-ascii?Q?TyZ1fe3HkZcdQ8pToTrZmV104rmVgHcS0pKM5UdUGIxFZKBRmMioRcX0pZ+4?=
 =?us-ascii?Q?5lu4FzoJmoT9LAVi06XeCfbvZx5qbgmkyoO0ujKfZ6qOUEAdnMkMZfnY+uXE?=
 =?us-ascii?Q?jrbwXQLFQm4kfPuzpcU6P6EQk2bm191VQA0N8G/DbouZFhJONMN6DRDr2BmJ?=
 =?us-ascii?Q?vdpJNWGFfWU30QTUormLqojU2f2WTkUDey1B43vB8MttNLGlymOO+mOlLekG?=
 =?us-ascii?Q?HkBSjdzk4VvLVrdZh6TRFzO7IUxDYawl6OK3L9R+1ZyGPfFMIL5eeQnQP+AN?=
 =?us-ascii?Q?0br0Z/Dzo1STughHxq0RR1/xfldRKEbpsgxi27X66nLdnLP3xRZk1gxn5y7o?=
 =?us-ascii?Q?cSprQ+anJGT7k0AiJqBnC/VN0d7UVuOaT07AvWWb13R84TqpDyB6rA6crcfj?=
 =?us-ascii?Q?UccARSo9ccA39NGmh2LAE3zuouN9HRB+kx5IpL1vX7eHnl12X+bcYMPS0WB7?=
 =?us-ascii?Q?ZeOAXyq7IDTv6WdhXD2jPtOfxn0tOPMKIOSdNSZe/vLEFkSEkMMv+1T/l1Gy?=
 =?us-ascii?Q?LfAPTpd4hYWhOJnrEh8MEFCMVF+EhIT6GS816POxAWAE2EKXxkl0lu4bJ95j?=
 =?us-ascii?Q?rrdxowT34FTLVhiKDLv48sMReLMgl7YOsOcvEOykOS/OB2jgV++rfYDPj8u8?=
 =?us-ascii?Q?q9aTdK5UqxogMOVE5G0beqHA5k8KDhpjhuCCZN62a++EsfY3yHfIR+hT3Il+?=
 =?us-ascii?Q?W9yCdVO+aoSFpGtBWIZ9ov7EGW5F110/pteu6EsbZK9+qphU8Fyy9+226ZN6?=
 =?us-ascii?Q?kn+OEKLCa5QJo5YgqS9ED0SutC5hoOkR99/waCHDdXb4WZWGe2sizw5nq621?=
 =?us-ascii?Q?jbUuW1KEU+QPAg4uyRBkrFNhKezVCQu0zohS895vuzcJEGSgApjqjZyrplv5?=
 =?us-ascii?Q?sXTP+CpkPQekY5B5ORL7QdFUTxuGnTcwZlU893Wwa89zkOLXatXR/ezgix9S?=
 =?us-ascii?Q?McyqN/egNwyjCeCjjcBnmHHVxK37eQWsPHjM0pD3xCGhi6xQ5fLaxUUvK8JY?=
 =?us-ascii?Q?ChLUJDT50OyCtE3E//mCzT1CCUdVgA4zFRS+EcyPkPCtx1Pxa9sbGIuUc5EC?=
 =?us-ascii?Q?/RYK54puoF6CFlpVFYUCnGuHCwrIiNJIWY00s0At9Kku7pDlNnQHRrMaK6JN?=
 =?us-ascii?Q?Z4UiWCJFP8sFiaehs+VcBw24+7QCOPforbe8yJqY0PT/aNKgfPxF5LtijkYS?=
 =?us-ascii?Q?3f3fqCXdU6cnndjrC3vRUvIHiDFbUxQ+OT8bQP9ROIHFxLmP4hkxsJZliJK/?=
 =?us-ascii?Q?8p6y0PJRqg8FYQ45UjkBe9UD4+ipeG4Y31JEHxO8PA8A3WPZ+RXzMw4F2ZTL?=
 =?us-ascii?Q?OQFfFgE7IBaORECUR01+LIm/x3lk3HhTVqPXr3foJhpsSJVAm33iGnxXcP41?=
 =?us-ascii?Q?ZpRxPFoUN32nwpadtL76Kfo2npqwPXf1Ks9m3Ku3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 492dae1c-97d9-4d55-56c6-08ddc86e8d75
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 15:52:10.3242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0XGl3NX2I9kFPCtPgm0e0P1qyHBaAnFKTx7zXrOThMPq6O280B7fI5C+rpxFYVhFIcdecpRlRg+iLSXASqPLOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10329

On Mon, Jul 21, 2025 at 04:34:31PM +0800, Shengjiu Wang wrote:
> The wm8524 codec is connected to the SAI interface. There are two audio
> plls on i.MX8MM, one pll can be the clock source of 44kHz series rates,
> another pll can be clock source of 48kHz series rates.
>
> Previously it only supported 48kHz series rates, with this change the
> supported rates will include 44kHz series rates, from 8kHz to 192kHz.
>
> As commit 17cc308b1833 ("ASoC: wm8524: enable constraints when sysclk is
> configured.") make wm8524 release the constraint when codec's sysclk is
> not configured, so we can configure the cpu dai's sysclk to support more
> rates with the 'clocks' property removed.

nit: remove 'we can'

>
> Add mclk-fs property for the sysclk ratio, which is required by
> calculating the sysclk, 256 is a common ratio for audio.
>
> 'system-clock-direction-out' is a must have property after

nit" 'must have' to 'required'

> commit 5725bce709db ("ASoC: simple-card-utils: Unify clock direction by
> clk_direction") to specify the clock direction.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> index 622caaa78eaf..ff7ca2075230 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> @@ -147,6 +147,7 @@ sound-wm8524 {
>  		simple-audio-card,format = "i2s";
>  		simple-audio-card,frame-master = <&cpudai>;
>  		simple-audio-card,bitclock-master = <&cpudai>;
> +		simple-audio-card,mclk-fs = <256>;
>  		simple-audio-card,widgets =
>  			"Line", "Left Line Out Jack",
>  			"Line", "Right Line Out Jack";
> @@ -158,11 +159,11 @@ cpudai: simple-audio-card,cpu {
>  			sound-dai = <&sai3>;
>  			dai-tdm-slot-num = <2>;
>  			dai-tdm-slot-width = <32>;
> +			system-clock-direction-out;
>  		};
>
>  		simple-audio-card,codec {
>  			sound-dai = <&wm8524>;
> -			clocks = <&clk IMX8MM_CLK_SAI3_ROOT>;
>  		};
>  	};
>
> @@ -570,9 +571,17 @@ &sai2 {
>  &sai3 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_sai3>;
> -	assigned-clocks = <&clk IMX8MM_CLK_SAI3>;
> -	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
> -	assigned-clock-rates = <24576000>;
> +	assigned-clocks = <&clk IMX8MM_AUDIO_PLL1>,
> +			  <&clk IMX8MM_AUDIO_PLL2>,
> +			  <&clk IMX8MM_CLK_SAI3>;
> +	assigned-clock-parents = <0>, <0>, <&clk IMX8MM_AUDIO_PLL1_OUT>;
> +	assigned-clock-rates = <393216000>, <361267200>, <24576000>;
> +	fsl,sai-mclk-direction-output;
> +	clocks = <&clk IMX8MM_CLK_SAI3_IPG>, <&clk IMX8MM_CLK_DUMMY>,
> +		<&clk IMX8MM_CLK_SAI3_ROOT>, <&clk IMX8MM_CLK_DUMMY>,
> +		<&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_AUDIO_PLL1_OUT>,
> +		<&clk IMX8MM_AUDIO_PLL2_OUT>;
> +	clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3", "pll8k", "pll11k";
>  	status = "okay";
>  };
>
> --
> 2.34.1
>

