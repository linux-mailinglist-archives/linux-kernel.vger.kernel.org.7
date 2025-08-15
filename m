Return-Path: <linux-kernel+bounces-771186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFC9B283ED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68A55C871B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E3E309DA7;
	Fri, 15 Aug 2025 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hZ+DodvP"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010065.outbound.protection.outlook.com [52.101.84.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DF130AAB8;
	Fri, 15 Aug 2025 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755275894; cv=fail; b=nZBkTh0w5HtPmavhveBPBE4oLQ/P/fA00hcAnC+PJ3s24pzicbjnm3hMXtEOqI1AIVnCJjbKKMPn221Nbj7UXCaAPFbhi1trp4QGFElyax98gyu9We6AW7QTDUYkZs6yWQf5v7bFSL5JIH7RM5qPs72W29jtR62uLY94Nkr9t9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755275894; c=relaxed/simple;
	bh=3Q4o/dhmDcX54YICAplZf/iH8ZhkfwlfaNCZUtYTmHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IkEYAB6/OAL0BmateWHxTEabvOA3GMwqi63/a8GMYGpBNDwZukk9aKzHyBR/b2gkJJl2YK+13XmwqvPnpdxjEUKq34vWt1lBCF1z6mnObzmcYbfvFa+rKBi3rFEBEtcEPKHj6vfKWKGXRG4Ahk3JTnq1ogaesJhEnQvCNvF/9T4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hZ+DodvP; arc=fail smtp.client-ip=52.101.84.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmgZLzHR2fE6ONfDmWFV/DTJCFkia25RwwlQW72R2f7+EPwW3r8KVaL+HhlR1JPk9zDZEvn2kWVo87iXYJERPXHgpy9ADrGOtEkwYhI2wPhTeYBao7jkwZLtpGEZPnZijCjNYoNU5jn+qwRlRITUV56WI+e+j2lFsru0SATF8GPq8Bf7q12LgjmamV/crFYdISvTGlsPBkgpJvH3bSK8KZAs57eEuIxNHPVfUt2yVgl/dr+SmmT0e3L4Ok8j9w+51HMB93dBXcKinuL1cgN9neQMTKHVCmwC2KH97o+8S4qp/vOpJlPFECsvTc3yQUat0dsPD7q6wSyoi/x1FaLYLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOVFKD5vF1ji28A9YfQRSnad+wN6gUnr+RKndb7FrDI=;
 b=XoKD1QPrRmcbeRPID9kheHtls/Kd8WLy2P6mkSWGHpobyjjwZGLv7D2YCG4zpecmnfh9jY70Pkj1CrItUZRweXq2+0yOxb8DZG07KTV9l0pk7m2CMbH4YttSYEC5dI5YseJf8hE3BE3L8NFPDWZthkYwbwQkCsIv7oc+G4Ai8oKFGVHYX+A88EJHYT+x8yu06c0ZGB8RHAYf/t725+Hx+sYVu3p30btIlWALVBG2GGWaee4IpIUUZ3oREJsaLNMjDwADDydkNT86jQokkhFunm/KV2AVqPDlJjRSsVlIA4ll0V5J9EyYiaUooCpyy+W03hRGjSviYTjrIV/9ONj95w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOVFKD5vF1ji28A9YfQRSnad+wN6gUnr+RKndb7FrDI=;
 b=hZ+DodvPlUWYl0oCy7jwNc8mhEZaH8NbpAPiN2dnEqAPMlhB2OZNWKuXJJwmkpEpUwFwHVs0uGmQlJtG2p0MV/IZWC3ffAOTigB2unPlrLqQqeYxW88mrLE1GG/YMgPeblXd204wtWBtWvSpip8nJMfUQBJMDzBeoLftXVTVXlqJ3xKY8ljIp6vOqR3vaF206YdTrhHvUOm0OtMNGRGAN/nwJsw+FQFmnCalTuzMgSHDSsWQtpCvN4AHwNrHGt7WpaysfIiFeMDEZBTKKiXgu2buClTDRhraaUUHCQCSbDexWeYihNXN9QGduCTTzXVWA7IB3Z5e5sRcV62sZKk2tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10655.eurprd04.prod.outlook.com (2603:10a6:150:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 16:38:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.006; Fri, 15 Aug 2025
 16:38:09 +0000
Date: Fri, 15 Aug 2025 12:38:00 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] arm64: dts: imx95-evk: Update alias
Message-ID: <aJ9iaP1E/G1OLAE7@lizhi-Precision-Tower-5810>
References: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
 <20250815-imx9-dts-v1-7-e609eb4e3105@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815-imx9-dts-v1-7-e609eb4e3105@nxp.com>
X-ClientProxiedBy: BY1P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10655:EE_
X-MS-Office365-Filtering-Correlation-Id: 1125194a-598e-4286-237a-08dddc1a1e84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K4QvG6cXhJWEwqP++2+yacXjc1qmd1VBLWTClVmn5mJanhKOjlZnKkZ8vl3O?=
 =?us-ascii?Q?vBemJRwaVrCz9hrtTLc27KWebvvjoL1udHJ9ucxoC9TjNramh8pOZ0WQZoAo?=
 =?us-ascii?Q?GYAGCMV4ZlLJvdKaDdtX8HGKDtS2jIy0g2v7mNS806qjTSoXR/ICGH3NbvbR?=
 =?us-ascii?Q?2VpJrbllX2/fL7YOxWyCuLpDVmfqjmE0WjQEfCaueqbTLhbi1/4XkTUwgi4E?=
 =?us-ascii?Q?eJ0YagSUcXfzAKcPjNyCggg9iubYuDD9JGC2zuuPRY5ua+YKnH60L8slMFPL?=
 =?us-ascii?Q?hhuzqc+YTuA0aXzWn75vzvKCo/Ia2Ih0Glu18E35urUNADS/dEmddP3V12Zl?=
 =?us-ascii?Q?ctHzyuF8UhX3ZBCxzyUhyiwxsd+Grksj8K2gcadlLSkVen1S/Vri6XEJTBwr?=
 =?us-ascii?Q?AJ69xztif2Ip3mBDtJcJa3YJJtOngJ7oYnEydA7F9r23BsofZGwToYtNAP8n?=
 =?us-ascii?Q?ij4qvgN5n1iZ+OQDiCEGl5b/0EZvieLHiGKZ2/bmu5ljOF1lHCO7+EBvciTO?=
 =?us-ascii?Q?p8W25BTPg07A6aNVPQTUHnyE18pEaRlxYVm050fqKJpKH/4n5e3hWoBwhsCe?=
 =?us-ascii?Q?d9EvIOxHK6h4/E68a+8KKax2duusEV5GKp5z/PvxqhLU5HjZhWqeKu+CDxhA?=
 =?us-ascii?Q?Ca+pC/hXCp+BuB1xiqS1T+Wmq5scdCUu1TgqVZNFSB8hbbG+ohgzC1jdog2E?=
 =?us-ascii?Q?yqBxwpHsHSEwJ8DcaElOAYjrZPxgeRgq62qlKW1aPrFEW0M4bSkcU6BujYV3?=
 =?us-ascii?Q?0RtKUdq8nKQGdQtnqHao3hscu8W+Y7jH+jrRvkWNda8tkSExUDaJUisucVAF?=
 =?us-ascii?Q?xpYCwYUxq/Xk4WqKiVr8JhyfFtMRTCNYdA2/BdhsZri0fUwc0rbYThkcO78G?=
 =?us-ascii?Q?67A8lX1MlM1W4mNI+Vcov5wVDmxvVPvQTJ/CGvpY6FDMraCl8QfnscbKR47w?=
 =?us-ascii?Q?PnDQ23TZEcMXSmczfchYa8ZCSUaWMfmSRIu0Ew/jxZgi0bXhbsLlJg1Y1/HB?=
 =?us-ascii?Q?9dckCHM1H/4jFkIM32r0TZebdFNfeTeItuyp5wlAHEGBojmoeGeWMmVGyzxM?=
 =?us-ascii?Q?ltqa3QLjKSuJ+nP6Z4PvICemiSBKn5ztFMymb/HX8uyzESH3sY90UY82xcCT?=
 =?us-ascii?Q?QNQr+LBAYWfGlwFCoPiKadESajkI6b+J4Q7cXORPegtrjgU6guPxZi5h4GLM?=
 =?us-ascii?Q?JByBNP7wiho3NCvjXPjonAVtTu1sC9RIYBk29ZMXj1xsbfw8SJkOsV9BcMz1?=
 =?us-ascii?Q?h7L/+Q8Ee/Y6bTxHoV3bsSz6Z7+MH4gfzKM5GHnVF9nZNvRZkzgF6LnPi3GN?=
 =?us-ascii?Q?v8sQg16fgDQUHXBPnvrn44opFyQqBgtE6Srv3J6QwXHzfPLRDWMXvseIzGH8?=
 =?us-ascii?Q?QDlfQxeNeJGOXvBhZBc6IQt9whOnJnHojH93MoO0HcR4l9IXXNTEy2VgiNlc?=
 =?us-ascii?Q?cfWq7BH1Rps4QgsVsEPn1cwB7itPDU1f0FLXFZtcw9QZEtlDczl/7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aqMUKhGSRXQ8d1xNBl4JVcZ0SN2X6I2TpwpFY8rUvybWce4ZL6fU1zTDzlAQ?=
 =?us-ascii?Q?8LrxDG3RNVmx25HfSh6NYea6/4NFVv2i6Pgevu5oopoiLRI+Vw4KpoqpXL2k?=
 =?us-ascii?Q?yR90GoyDlMNxvNL3oje36muwGgaA4f7S1kGRArSiXShM+emKoJY5zVX9aBAV?=
 =?us-ascii?Q?YdizIcKEyZdNU80Zv1H4SFuZQKvN7Pp7DgZkdLDFdbyPg8vnoWOMHoTZ709y?=
 =?us-ascii?Q?Zr8e+eLKKP+5ZFfbANjU0Qu4RLcTojyfKmeyajGir+pzVVg8631A6w9lDFrY?=
 =?us-ascii?Q?+UKvRfXnklDdYTjFcwTCy2rR55iL3WhoLRWYwnLdEti95cBWPbY0Oa9TuYOi?=
 =?us-ascii?Q?rZg61LOzqNYafKlmCD0PWYkv0nhHz1pQjtcVe53wInobQKyWRgf6yDI3LxlK?=
 =?us-ascii?Q?eDedDYOa5vmMckWTcSdQWHvdL2La9yumBhdwLUAp5saOj0qM3qUo70eBlVnk?=
 =?us-ascii?Q?x0YDIS+b6PqyNTGkB3tgSYiBaiV0yfpSJkcVlmAdSDeJIDxn+qES/a3EJ8V7?=
 =?us-ascii?Q?jGF/Kw/55PZdmshpLrGVnHd+EslFYQ8nCFxY1uAXlJVZUHzZH1TPcZjmKq3u?=
 =?us-ascii?Q?1kzwWvmS/2Z6mc0N+GmnqVAYXStOTg7CfGKWDeHpBVh52N0f8RP7Clw7OLBx?=
 =?us-ascii?Q?EuPeZPeQXweY3Ke/yBhMevLlUfXV2caQ4nrGxM9HFolrGy8Tl01syeKbEWVn?=
 =?us-ascii?Q?DW0ryIt5tpjcNhpJkJGweq4MnwlhgwFbbCcA+Sel/vBzMXbffdKz/HlGRu90?=
 =?us-ascii?Q?Eh1P162WcPPoPwKNgkuDEOYPPflHbhlv8XbGFH+sdobjd1ROdE9yB5JUy9Oi?=
 =?us-ascii?Q?0MB7OaKlwhYycp17d43Hl1S3x36BzKLOs8VpkXszhaqIo+Gz4vBskeenZXl7?=
 =?us-ascii?Q?dzym97ERbHLGRosArFxKC3B5+7JT85ULbO1BoxURP/eYuW9kFjq4iudPdHFP?=
 =?us-ascii?Q?J/Qe6HsiXaVYpjVYsJnFxuOgvKax24QWqxj/eH2pIK0UEnUOCcyTCXLolaCd?=
 =?us-ascii?Q?gExUeOao/umlk4jOmJLG9gb0aYvbSWWjS9FnpeZDicq96DnUV8N8Td6GknRW?=
 =?us-ascii?Q?NFU5Ua2iSe0PWGmZUE7QlkM2ea8fFWuXEFzoUl9N1l18SEkXJvPZdYevDzbd?=
 =?us-ascii?Q?sxwcGXR1OyUqbKzvDeVA5T2puThheZ3tX+i4RYZsivueFGgXw4ZiJTRil8Nn?=
 =?us-ascii?Q?p1NgjAGevMtoxSRFEFx/nH9ACstYwG5nDxGVM/plwlUWUVpf90o9s7rOQkcI?=
 =?us-ascii?Q?Kn+3Fx4E+cEtGPcRzqxXFxemlS8dZ9ztK1W0Do14hcJXMUIHCRXJ3jMd7YQ3?=
 =?us-ascii?Q?nd5mZcJ11EMpyJEwsY1Y5wOrqoFSSYSpZR0dbmqgseFnnYCHt0dH6gvHuVuP?=
 =?us-ascii?Q?vIZwsGRq1RWpQK2naZ4KD9ZAFQ2+rM3h7XAeIQQMPMoaGLxH5RuPDo1MJxsy?=
 =?us-ascii?Q?VjYcNOKU9luMQ/QVVDP07vi6nrO3uZgeXqKejUXlsKi4ZgON4+c3A9eA2Fri?=
 =?us-ascii?Q?GgkTdYlHiNm0NZsN/FDIt3bwF/DGKkDxwjjTdkDxLHsVmX5jIubafW1x+9QQ?=
 =?us-ascii?Q?LvOgUkdtvxHNg5NbLcg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1125194a-598e-4286-237a-08dddc1a1e84
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 16:38:09.7946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMUMrRP4zP8Gkg1SctawOxM6Gi258NhEQDDKTBgZQ8bvuWIdVd7YcLxdrxOgxK05aLfwUYlXL5IvL2Tzc0x1QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10655

On Fri, Aug 15, 2025 at 05:03:53PM +0800, Peng Fan wrote:
> Add i2c, gpio, mmc, serial alias for 15x15 EVK and add lpuart5 serial
> alias for 19x19 EVK.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 17 +++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts |  1 +
>  2 files changed, 18 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> index 46f6e0fbf2b09106e6e726ff8b61522d1359cfa4..de7f4321e5f9d7d6a6c46741d3710756dd2b69cf 100644
> --- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> @@ -28,7 +28,24 @@ / {
>  	aliases {
>  		ethernet0 = &enetc_port0;
>  		ethernet1 = &enetc_port1;
> +		gpio0 = &gpio1;
> +		gpio1 = &gpio2;
> +		gpio2 = &gpio3;
> +		gpio3 = &gpio4;
> +		gpio4 = &gpio5;
> +		i2c0 = &lpi2c1;
> +		i2c1 = &lpi2c2;
> +		i2c2 = &lpi2c3;
> +		i2c3 = &lpi2c4;
> +		i2c4 = &lpi2c5;
> +		i2c5 = &lpi2c6;
> +		i2c6 = &lpi2c7;
> +		i2c7 = &lpi2c8;
> +		mmc0 = &usdhc1;
> +		mmc1 = &usdhc2;
> +		mmc2 = &usdhc3;
>  		serial0 = &lpuart1;
> +		serial4 = &lpuart5;
>  	};
>
>  	bt_sco_codec: bt-sco-codec {
> diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> index 2f949a0d48d2d8066388884703c3b3cd678f16e1..39815b21d235d2f8cfa49720d3be49d056ea039a 100644
> --- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> @@ -40,6 +40,7 @@ aliases {
>  		mmc0 = &usdhc1;
>  		mmc1 = &usdhc2;
>  		serial0 = &lpuart1;
> +		serial4 = &lpuart5;
>  	};
>
>  	bt_sco_codec: audio-codec-bt-sco {
>
> --
> 2.37.1
>

