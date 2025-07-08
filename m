Return-Path: <linux-kernel+bounces-722146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F72AFD5CF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E7FA7AA54F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1949C2E6D1A;
	Tue,  8 Jul 2025 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SFMsZyjo"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013068.outbound.protection.outlook.com [40.107.162.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703DB3C01;
	Tue,  8 Jul 2025 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997458; cv=fail; b=NM01LTBy+TD62MeYFdZ9vaucMmZ37hOTdHnlPZl+duw5b12eXvO/cWj1gVG/JU6F86Lr9sJo3vu5/XH+IdKnS89kAgaPiJdNRydbrL03GGtYOJJDqiY71yV/s0ir9qJukTaeoF25hfhaXg4FJ/Gh1ejKP6oWiPb8HN4grZwaiOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997458; c=relaxed/simple;
	bh=cJm4D1m4Qd1uQy9ECgPS60tgSLj2P25VcIiwc0WJPwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P2fFTWstcglG40kR4jpvOWYvldSv+ljuVhm83+M78ZXyEHWXodzi2ZxpSYk+wNS9xeoWPuy2XVXL7YdzJgiPFhBTHyw1lGCOvYCeJ9/z9nkerdutYMS+Ku/Sl2sNeWFEv37fuB+7Ux3ypQEUuZYhSETQ5lEMKrML971Pyp7Jc8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SFMsZyjo; arc=fail smtp.client-ip=40.107.162.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHmgLHp7wpraoRdlOGpy4YHQnfpGV1nuMFA4UVg4HeXPJQuEXFdjKyLbs71b5cN193HafUnPFIP7rciQhcoWoIoo0AkFCE1d1En6HiVOBgmeeVQL8wUAvgocKA4xZh5i7iyqKs5qXlKOsoL1DB6pgW4DV9T80lUXp6HCbQ9g49s//B3zGgqbiwpMAU+05114EpQym2XyvBdAHwntJljAutg7nY+w9jIsmwjVZffC1wh9ZOUzVN8O/C/sQrYWIbW19Hysj5YcX/LHM6iXyw/QsF7o2A2csKT/y1eBsznMlZZmat1hYcDcnt3R+VwB2eB0FzzgHriTptDnYMBIPs7eXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKbJDQb1V2ze/iDWEp8KA7NUjqPjhK6vxv85NawQMag=;
 b=TcY4NX2T62d5cJYR/UpKVzmK1fBogFIZOmu7apQl68MAze8NlcQlvHNG8vR/U36z3y1yxr9PZC8Mb5JLSUrTHZzXoCqd7BuzE4HFTFmgJ6UGEaV1Q14E2yO2Oc3CUYI15vuR/bQOayzJPRcBSmyw7Pc9r2DsDPtAwDUbHjZCk2zcM1WqdMUKYsaIFir//UVYi+TTDPMAj5iRXKfrEqx1JytrRyoTtWVh+CpjmP548YguTbJmNmBTOXZkMr0aadL/uq5VTEaoS4+BTdRXWOs+lCfzwVk0xGwXPgpyazUQUGfJb7Lc6PregEjMxnXhTwtVX1OB2kVkVFnEAnMICQmndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKbJDQb1V2ze/iDWEp8KA7NUjqPjhK6vxv85NawQMag=;
 b=SFMsZyjonrHCKL5OILES4mV39cGosYi0nBlWIyeZlHBm6cRoac+UgwYZixxfTi3amVNkV6aQDbt00shHXrSRQSWhjUU0/Bd9KQCRg3kzzEA5/c1HIY1rMJLYiHKkGmN2jWsSxCBbAAOmekFHriX+z5RRBFo3Fp2rZmzvg5l+gdk5g+nlYUkfnlBvTvL5B62JCUWjnnA/nIai7DJpjSCSXUVy84NBZHj6bfx855Y6MCfHFQ4tOacuH4vZThuGX3+ttPkuWwgG81LHoTTZQek0xRQLHZTwNsgJ81uH2seqX7zaJxmuY/Bxi6t5LfjIH06C7Prgkl3IHw4JZ6o9Lur7lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10453.eurprd04.prod.outlook.com (2603:10a6:150:1d2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 17:57:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8901.023; Tue, 8 Jul 2025
 17:57:33 +0000
Date: Tue, 8 Jul 2025 13:57:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: Frieder Schrempf <frieder@fris.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Eberhard Stoll <eberhard.stoll@kontron.de>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] ARM: dts: imx6ul-kontron-sl-common: Add SPI NOR
 partitions
Message-ID: <aG1cCK1U7cs+Jf1n@lizhi-Precision-Tower-5810>
References: <20250708125607.66113-1-frieder@fris.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708125607.66113-1-frieder@fris.de>
X-ClientProxiedBy: AS4P251CA0027.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10453:EE_
X-MS-Office365-Filtering-Correlation-Id: fa2ee14c-6c35-4497-77f1-08ddbe48ea69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|19092799006|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nGSmdNHKno5SfdQ8VcZghMcermg9yWrOpuxjZx9R6/LblFKiVLF8Sk5CKhPT?=
 =?us-ascii?Q?/FFha1YUCCqnGc4aXYDE9jgleNBJv5j5Yx6wEcsLvoZ1DCumxK+gM+2fB8w1?=
 =?us-ascii?Q?3u4ixHmniEDr6VghMSh3TGJbOP8dZS/69Vgwp6q/0Y8459x7eiaw2a2Yo2KS?=
 =?us-ascii?Q?+xrEYxuV49JbADwdfLmww8p6ElAJQzhLaJznjoW1QBYSWsr6cjeEHyx49CMq?=
 =?us-ascii?Q?DUU82Hq8QOdc6KyNXmQCFFUcRaKmUErTlSB9xLBSsi/wWXBe8YNXxEoW1vU9?=
 =?us-ascii?Q?MqZ3sIOVBzqgFUB6AsFuZu6rIechTMTor96QCPVtqs35FK6X3KS2+Nb01F5A?=
 =?us-ascii?Q?078GoMSjsnMoCo/h8W7Jwlhi4a28uLJPEDyyNBx47W/tld3uInvA70vA9ehG?=
 =?us-ascii?Q?ewgq4ywmqSoy56YTy7qQTlXhFll+fHjxToQC4n+FMDwIejF5+7+j+NDuHS70?=
 =?us-ascii?Q?/ANSbG8mKuLeODSa/ys5I8kjrDlzUVYv1YqaGXTVWQeLB6eTsgHwNyrSHkbc?=
 =?us-ascii?Q?YyrrY/V0P1pR8oP/wVSXO9k5DYaTafxq0jUJayucmRWoOgfcsid7z12lGBUD?=
 =?us-ascii?Q?ZNiVsLdGvkbhE2h7VGyAHStAztr1ftJif5yzCo8Pg5poIfiIhPmKuy6MiYz/?=
 =?us-ascii?Q?9P8tB1cMt0nbwMc0Bj2oSbXRIDHc7RMewIxA4o9ep1hISC+gaP/qsbcC9zik?=
 =?us-ascii?Q?MQ6HCKgV8Lgr2BELnzu2js+Jxf3ZT3fmM0Lrg9Nfdp1qWUtNV7eCeE3xZwBJ?=
 =?us-ascii?Q?QBAVJYuc7dJ1eXkLItIlBNIm9R8YqdTPma9l9c3rb9R2blltSB7oYnB/NlCr?=
 =?us-ascii?Q?/mTF2ZiJ4maaktwbNkQhgtNpvlXK6r+U3cGL1Qsbk7pnbPQWYeJRQquaVj/S?=
 =?us-ascii?Q?h/p6WLfs0CMJ/MaMB0Km7Z7yAAnkPDYGt525iIbHhGUmDkD2qHcTvU6n/f/Y?=
 =?us-ascii?Q?PMDW9exl0MB0sYYh0TT1ZpE8iPr7y/3OS2uQ/Pjjk496MiWKDNQr6Dv5C+sJ?=
 =?us-ascii?Q?m5joDNSJ+Kmn0rnsK4Uk6amjSfV8ypwJYC1xcpC+AWS+6DYYK2iQlMOxToG3?=
 =?us-ascii?Q?BAnu/yX3Mgza16iEpmDNwfPuCobQcR3R2xCq6opdvQiLCv4BwVp3xC0NLYPH?=
 =?us-ascii?Q?18Of0j8xzCGw5qLGdTQ0vnPk9JJ06qD2FoKAOYP89wGI1PuVEJPJNOXQP4de?=
 =?us-ascii?Q?AuDKKzN70T/16tL5Y+vs5WdAfR31Wns8Daa6SdcdI7KB9xhaayzvi2Aw6qB9?=
 =?us-ascii?Q?XT8YerSi3A8034kB1UyvmeQaGSX0S6fi7LEOY5umB2lvvr/GTequVTNYNCXd?=
 =?us-ascii?Q?vL8Y/rVEMBbHxdPw89IW3AIcKvqeXu7OfrR10FnqhJGxaZDOZpDpa+pfIpKF?=
 =?us-ascii?Q?VQfUJ+EG+CcZBhKHzhAppKX454snzRnsVmx54y1TA6Q6uAsldLppx7MZiCgk?=
 =?us-ascii?Q?mgCFyjdX+9RVQdHkCQIH4cNpAVklUODwyGu/Vyc/OVJz7D/yHH4WbA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(19092799006)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/o5ilvLDuBf1PQBz+7s7IO+Ce2ltb8gqrpN8AcsKKj49o/fYmiOU0LwIiIBy?=
 =?us-ascii?Q?lSrJW9yEwetc/a/aP5i3ewh+2zRWT5qWZtbXBmQ8hh+DgVRrvs64pcYhWNvf?=
 =?us-ascii?Q?uQw+Qli5PmDkuFFEgNfsgKcrW4YONMuLJa55vkJapep2Z2FLo528X5Aeb2SN?=
 =?us-ascii?Q?XRFhNDzHzyQ8yytxFU+/8MHgWsMGzFrF8EjZbDnTDSQAkwo1HuVG4zChxjpO?=
 =?us-ascii?Q?WgbuVkjx3SLQaOqHKi1XriWvMUZaBz00M5wfM1KPpuJIXOMqwIlA7VqZ5QT+?=
 =?us-ascii?Q?a3OH5IgDBnxxCchjKgea81OUy7KlNPshj9PoR1EcZdCs9YMy8PcPH4yePesP?=
 =?us-ascii?Q?L1NIA7XzI1JsEzmiZLCU0I5TuUotqIqOYY0M8Wp0K3cxRHQ+6g2GyLAp+u3R?=
 =?us-ascii?Q?KgMe52wta+1pmwY/YWwM/WOlCHoB2eNEo0RG99FMTsj3ngfME9PkSg5GoFCl?=
 =?us-ascii?Q?AN17tK7bNgdxesT3iOdjOoCNK4mr0NqSLMeo8FlN4JmWYX3w5U5/1CPM8Mp3?=
 =?us-ascii?Q?9OAUGhjpMvmfYyaUVQ86x3shyiM3DMncMZ0IGAIHxNw9EYzmq4Zvf/rjJdUz?=
 =?us-ascii?Q?tdY8S3t7iwYhC//rKaBYGoDSJK/Ls168YNvDpFQD1QDkGcLgxWvEYmOYySe7?=
 =?us-ascii?Q?ZBIXZlgUH8eaYVF6I8CWXLcVJcqMaJe1e/JOXvcDkw/6QS1jzBvCsx+AAhcu?=
 =?us-ascii?Q?YCAl9kqBBukKRJhK9FSXgBHnc3VBJ87JFEGcenmAeH0SSg8Tbmq3NzRK9Nvy?=
 =?us-ascii?Q?1Abco9ldGpPBoBUplVoHc9+b581CPlaByCtwofb2XTRrnWWFhnY+0zVu7P1h?=
 =?us-ascii?Q?r/KNEf7dsWXbiXPyEXr3ys/NPTtM7Guz82HFrXxvNlethuFfl/rwS5EeTDRJ?=
 =?us-ascii?Q?7DI12FVemcB6W/uQsfKaQRqa9PtKFvwGcmY30SZpPgue2ihlZIRVWGWQqNFR?=
 =?us-ascii?Q?aLZALNDXyZXPQp+IkoTmK/0G5fxkUnx0R6RnUXYIM/QcXgRrzK9MaEbj+xlI?=
 =?us-ascii?Q?X37EB4GGsAz7N0VpdesXfLzmimj3zh7RxbdajGbFtPISB19QWQEQa3Yfx/vY?=
 =?us-ascii?Q?AA4gNU54RjyTXC+vqjwJQ69poKbEuUoq9BR57yN1ZVbfkFjydHC1QF9MueBR?=
 =?us-ascii?Q?HTO62IvGUU0ToHh8nZvcTT8Y8zVwB1evXhWug+z9me+gd+4dvzmBKJNtJtbc?=
 =?us-ascii?Q?r+W/baGpyIDIH4il5OMcqda5GHTkND8rpzgOTUVur31nu4txbPzEucmyj3Xf?=
 =?us-ascii?Q?cwW3J40sscqcGp9JrYdb51j6zfzF7f0ji3DECeLE5EuXB6tWl3VIAM8JMU8r?=
 =?us-ascii?Q?Jq2Rryz5TRJgOVn5sIGFp32xNJimjd45RWgrYDVBfnk8/E/7YITwmvw/o/Z9?=
 =?us-ascii?Q?imrzV9bxDEPgjNKM6SseDV7pEx00EXCmPUA+maSG1588eiUJZBAVVF/K5+qk?=
 =?us-ascii?Q?V9uVfpHFItU/af5262S6ydzeS6tJY+vPzSr9JABI2oinvcLV3FzJ1nk3lAWk?=
 =?us-ascii?Q?fzMkSQb+0l3OmlEbe2RJHedmbC5MsHkn88i74odEfuDjX7CKxGwN+rHVDO8o?=
 =?us-ascii?Q?wA7KxU5ckGHwsfaw/D3Wu1zFHEJucuMMz/62SmkL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2ee14c-6c35-4497-77f1-08ddbe48ea69
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 17:57:33.8204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUZ/T/ei2bEonARWuzw+j4raK3JY6ETYCA+7zWON1tnzygzvPewZKIoxIwGYEEXy4N3Co9Vd5eaVhr9y1/QK7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10453

On Tue, Jul 08, 2025 at 02:56:04PM +0200, Frieder Schrempf wrote:
> From: Eberhard Stoll <eberhard.stoll@kontron.de>
>
> Describe the partitions for the bootloader and the environment
> on the SPI NOR.
>
> Signed-off-by: Eberhard Stoll <eberhard.stoll@kontron.de>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
> Changes for v2:
> * Fix name order in SoB
> ---
>  .../dts/nxp/imx/imx6ul-kontron-sl-common.dtsi | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-sl-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-sl-common.dtsi
> index dcf88f6103466..ab149c40a9cc1 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-sl-common.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-sl-common.dtsi
> @@ -28,6 +28,27 @@ flash@0 {
>  		compatible = "mxicy,mx25v8035f", "jedec,spi-nor";
>  		spi-max-frequency = <50000000>;
>  		reg = <0>;
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			partition@0 {
> +				label = "u-boot";
> +				reg = <0x0 0xf0000>;

I think reg should first property.
first is 'compatible', the second is 'reg'.

Frank

> +			};
> +
> +			partition@f0000 {
> +				label = "env";
> +				reg = <0xf0000 0x8000>;
> +			};
> +
> +			partition@f8000 {
> +				label = "env_redundant";
> +				reg = <0xf8000 0x8000>;
> +			};
> +		};
>  	};
>  };
>
> --
> 2.50.0
>

