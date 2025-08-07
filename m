Return-Path: <linux-kernel+bounces-759067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BF7B1D808
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C73247AB8FD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7190B2528F3;
	Thu,  7 Aug 2025 12:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MpOX3iFo"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013037.outbound.protection.outlook.com [40.107.162.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA607E9;
	Thu,  7 Aug 2025 12:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754570157; cv=fail; b=J/j01S3ZV//MLj4FOBAXthIt3FAHCZjzHzB0Kk99/EvIbLY+rGMDQxFBBST/qZJZjLAIqdAAeSJ1iR7pOt9XYiAFn610JGVT52zVw4DOnHXwzPehnNbIX9AdvmrMkEQaBpC+RdOnrEQV2C3Ufj4/XUoXQCyq4ib4buqf6oe5nEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754570157; c=relaxed/simple;
	bh=Z0xLU9CdjeQ/uk7BFoSNwdUh+qUEJvVtolSuqbtVyZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oGD33Tg5elzv/YKXeJXLUAsdSHedxSBwHj3rAwYkidgJMmC5ZjwHH7MDeYbprA59hNbnB2j8FcxnYJNeSQHIYIl4Z3/4IHi0N1qydphAi2gZRidwwuC9oMwq2NohdNt6koUbbt++i3/wpo1A19gnMBQmu2op71I3IYspVWLLZSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MpOX3iFo; arc=fail smtp.client-ip=40.107.162.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIm/bnGHCJ2cbtrDL1WhAMYcUzgmiWlz7LagD14JqXOmIotsKraQhbZgzfd5JvEp73EiOO0Ao8qBUHx1cYGMDYwYopYN1vB1aC1AkCmZYvaE+QQrKXbS64aEOwmf1Hf7zm0yXdHnXrSnbeeWeC57D0Eq/03ZalJm4F9jvjrmsghRRcFSsF+i0p4Tsw3XWOoeYo5bJDpKp+1DIc2LvU3UD9IlTmr1wnqGRfMd3mAeIifr33Webk9gOrV6yXmF0ske/B4RAPm38N3IZSbNWAdadmjJIuuXFN7FJRuW4th2XHEI2UMukxesqucqb6mVwinRrh7I4KsSAN16T2Ti0vtuVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnbcZ2RVAsUtJF4sMld2Mn7VnedB02T8paHqEvZuFTo=;
 b=yMILizGnbxAes8WGoWMyUAnO4aqs4lATkyYOMdEpf/+NGXaeIwIwaD5RlIfeyxXWxJJrU/mFm5vQPlQ6jWseo6c8Qs5R1az0V9JIShpFuxIwq0HVkmrbpid7mPih6egjsOQhNI01F/mFf6HUobADAX70UEf6Emwbh9OPsVps/XA5NEkfz9tsUzfqYyGZSgC9DoSGh/t2gMC/rBrCKqiHW4et4LdzmphKRO5oUeTfclsohn+pzJytrP1D0sCpc9qcgUgbDHL3D7oTdwACWTgp6bB1GhWMv4iCA00ggMvAhuGahkvwy6gJ8iZwP7vYu0PXn0i9iyGQ/MsF8WnR3C+ueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnbcZ2RVAsUtJF4sMld2Mn7VnedB02T8paHqEvZuFTo=;
 b=MpOX3iFoXv4py9ZmmwX92Z7bhEVLBUhIf5E7pVU0Gx7IoVdxqe/3MxF2bu4RqtNZ58FYMunP0RlyaSB8zJC+ah92EN9dW85ZjnhYmehpxWzoJ1VrgtC70hnvRocWabzdzO4IrhMZoeDcHjnV/Tj/Ay08CggeGfkhfY7TEQCuCTqHC8znV+DcoLn4LzugGl7GH3jVheFX+8ElOp1FKMMtS6eDGJiJSKHUD/befa/2KLA5A0kux4Sys/njg5rgevJ1M4u9wq3o2NTDeBtJ6hVW/8ofidUaYay0PY5KT3g88MdI5eLbAtfcbrooLqSKOEAmSLnOsjQy1dKLW3G1mxTB2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by AM9PR04MB8178.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Thu, 7 Aug
 2025 12:35:51 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 12:35:51 +0000
Date: Thu, 7 Aug 2025 15:35:48 +0300
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: imx@lists.linux.dev, Abel Vesa <abelvesa@kernel.org>, 
	Peng Fan <peng.fan@nxp.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/9] dt-bindings: clock: nxp,imx95-blk-ctl: Add
 optional ldb property
Message-ID: <3ckcsadhab3wx54g37qhqtckr6r5j7g4mffmcksbxlxuavar7a@hokyb2k6lk3p>
References: <20250806150521.2174797-1-laurentiu.palcu@oss.nxp.com>
 <20250806150521.2174797-7-laurentiu.palcu@oss.nxp.com>
 <20250807-airborne-rich-lobster-6f8e2e@kuoka>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807-airborne-rich-lobster-6f8e2e@kuoka>
X-ClientProxiedBy: FR2P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::13) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|AM9PR04MB8178:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ab5870-b8ff-4a66-6323-08ddd5aef1c6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dcsbhq7RWSarawD2IKxbFnxWGTlAaiUsJsCI36Vn3NaUUoGdz5H3o4/soUQ+?=
 =?us-ascii?Q?vJZz00zB6g7d9Nzb6sFD/j6uXH49EqlfGwgUZor8fQx+igzMOqFW+4Q0o8aN?=
 =?us-ascii?Q?VQyEXkIyoGh9U4QavA3djf7n0r05mgPk22Y4oG/8RRJT7h/ka5iuSy5IW3vL?=
 =?us-ascii?Q?sNiKDTO12Y8FMH/Q3lMk+4cT3PPl4A0HFJHWRFaApTqxW7GHi9GbHCQheUPm?=
 =?us-ascii?Q?KpyDO4tKaZUu+JLBp1Ufqd5ulaHOhw9e8qQMR0My9L5iBkHm4vSjRBy+nPBQ?=
 =?us-ascii?Q?kN77XiftibU4cE5JDvIxGDslpb5OZ1JLS9qi3F/leWkWgcLYWYl1WceVO+5d?=
 =?us-ascii?Q?cbkPvsjXMwiq6q558vWM4P4EDRKelrJmC+0K1cCU4uwuvayxXfOx2XbUnnq6?=
 =?us-ascii?Q?P2XeYND0unxOcJdh1H5gAvhGVibrYP+e0oQLpxczXWPEZAUPprR11CamB4Gd?=
 =?us-ascii?Q?5nB0WbdBKtJv4YlN/tFFUrqjbZPUvKvDbIGx4jcivYjo8D+WVIZwgj9YyDmm?=
 =?us-ascii?Q?umdYgchci3vHqvpSiXmOIVz/TxVxDxCk981QwIptB0MT7MGk5b9Y4HBF1L36?=
 =?us-ascii?Q?Kfk/5LjZBvzZIL9Z/Yp76Ex/etQDn9jMXrq0WOd2Z6e5Jc4JnlBMrsZpAx9m?=
 =?us-ascii?Q?rEEhWTOxXUDl0axMy1ahKgFvqVlQD+IY3a9zbcLgaG+ZuH2wdoJpCuKFkRjn?=
 =?us-ascii?Q?3waEJLnfBLmWCrAI+kZJ8KDv2XCPvVcbo+j+90rjyb6zoMuD5okSGu+9115i?=
 =?us-ascii?Q?q/n59bsNaiPkhawojB9BlngW43z5c8VwmfYnLy9yHx+OKOoA7yEAKTHyNuGq?=
 =?us-ascii?Q?ehAVdMU00nejFMBqCKjwJNih9amHLDIHKrJOlb1tH+r6fLhW4hUKZp66WJ4k?=
 =?us-ascii?Q?i8ZJM+E75pXwZY8XnSmaKZqZ/KxJQCkHq0SX1HEZRMV/P/M8kawU6JdXDdbR?=
 =?us-ascii?Q?0l0qLrzBLcANKinjq6oZQLPtw0til9Knj3slLCklRfVb+jg53kSgrvKIFDia?=
 =?us-ascii?Q?7k8zPJei5U3kIxMMQl52S0Zjz4emGtYFM7uGnxXB6NgO/NBzJUsvx+ErhJxH?=
 =?us-ascii?Q?EfRxfEk0abMiUmb66PCuCZGpAXRjmRIaxAHOw1/IRHHDMPJBLUTUwAnWshrg?=
 =?us-ascii?Q?SWlPaeQmJ6lyS3si6bmGXXAoQrmMECeGFjcp7Eiv5GOTCstKYuLdvBszipQQ?=
 =?us-ascii?Q?GpBxHUO880iOrB6NwcnYNBy9YIDIz19QanagluTPWo5K8XznqvAHzgVjEbeD?=
 =?us-ascii?Q?WBRmLgMwNGCcyGIcfHwFjAVT0pptL5k6MzPo8rCgbGcPuLvRQHQgJpIcsmzK?=
 =?us-ascii?Q?JqQXcKZfqHgaXWmGmn6i9fwOCXQjRv89VBU5I6x0BClec/0XN2aNP/RyBtzo?=
 =?us-ascii?Q?xzmMGeWWs2JqNmReQrjMwt4OI4xpOmPr0iWeUWo0UGTq9dyPZr07Si/BDmf0?=
 =?us-ascii?Q?2OQZU1JsqT8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9135.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zt/GKXulp0QbXHb8OiosMVKq2DZi/rL0wTqT1xdB+DRTu+taHAiDqZDdd7fx?=
 =?us-ascii?Q?u4Y9YyRFAsrcWvXPLZ8QW76wMZoXmbraqReszMEr/yRmikSALsSQAUg1XF+p?=
 =?us-ascii?Q?Xn5jh7y4hRizCQ6ZuCpyT9RJJCwr82SJMjRm5WDOOg6tbQtAaJwhMM12MrUG?=
 =?us-ascii?Q?DPdvi+VY7UD5vX+q2GiV1LfUAtacfsbzoiaYND/ZANmKs4X6mN6kaAMgC29I?=
 =?us-ascii?Q?P/BcIfd1MKIWPtv7m76KNxfc9itDWz91mGT+J5uW9raH9oTYGLomMMq2EqT0?=
 =?us-ascii?Q?7GiocU+hWCftBg5ZT554UvSwpbhCZNGHikTvkE/ufHGuZJl1x7Ejj0mlcJTb?=
 =?us-ascii?Q?2Ej+H9JKA88yv9BmBhJoyLdQPpF08swmUhRTc1rphDOdjWxgI6BL0HzjalMG?=
 =?us-ascii?Q?3DdVP3QD0AmI6PBROxvflDEdyFvHy0RxGDGw/VEit8udQ6DogXU7KupjYCzJ?=
 =?us-ascii?Q?NtnLEeVbLBfZo2tCkNKFR99gA707zc+qJRjgeG54jN3fbSL3m9tB2PInfMof?=
 =?us-ascii?Q?08gy2dEXo3uDro9ZNfAdB9ZUezMC1RMT+ma5ob26SY306aKjDHYnU53PFnJI?=
 =?us-ascii?Q?aZ672WTSoZ5DoN8IGBc6Y78GAN62WX4NOO944xTBQ7PuZNhQoH9QsiQy0ydX?=
 =?us-ascii?Q?Fg/enUGECfnWQT/KinH6jH9nrL4Hvx3f2yZNCZoTioiYOGqozNv9qTttgZM+?=
 =?us-ascii?Q?OjL2ov6rxkFcdwBnFO+Ew0lgGx0ak40IoiD8FbWsbL5E4GNBivMPaON+q5GD?=
 =?us-ascii?Q?C1ZDapG/PYEPGJ5G4DmaF+5b15eSoJvpUWThXtA5UNbIIDldG6kNRTOqPcKi?=
 =?us-ascii?Q?UF+Od858BiOWYT/M4t9Yy2AT1+Kl7qEWAGdQIZcYvtEltmWyE40b+BCytte5?=
 =?us-ascii?Q?6pHntbywV1ceHY5hB/xpsqNiE3G47ligYOm+xyEVhIOf3JKQ735FQMy6/2B6?=
 =?us-ascii?Q?UURme7rFBK1IAD77HSvNa0/T6rz6/PaPRYWqubCVeCcZF2ixOGvg/f4+SjcZ?=
 =?us-ascii?Q?o39dSrKRv3h5iW/afrfPaOjjvlJI0eY6Ordr8oeFGjNvfSzU49zB5X+meGLa?=
 =?us-ascii?Q?iFOMNAqnRMbWbZ+KbA/WVnore27T9NCuQe+Vz/+yz0HwLtktNGLkVbKoPwGF?=
 =?us-ascii?Q?hDrAYyPKixx9To0VDnF9ncqJGloSvx6O3mRXWzPZCGc8spaG+95BB6t0e/ql?=
 =?us-ascii?Q?Ql5w0Z6EJq6BOOxbtogUbcKl2TPtfiMOL8vb3urHiLTaHV54xcif4m0GFAKH?=
 =?us-ascii?Q?OViy4zvWh92FDHHXZ59zDgLuHDOpRDD+GO4vaksnnVO4oO2zzUD5IlM+vALE?=
 =?us-ascii?Q?y7mfW7HqioPyMgFWCTpfuB9uoN7okonP7mxVxNiUDZVrdJePW9IjT5dOovMP?=
 =?us-ascii?Q?kU8gekRBAwUl3BErNKGdOHwornT3AjlJIPX9szXHbb0+71tbzMvQiyO/06nB?=
 =?us-ascii?Q?i/vyhJWWER5+a8nvj1zGQY5bTJSe1ibIPKfeId2da36PRAhw4aR/fiQmnNEa?=
 =?us-ascii?Q?OSkQE5U5g39Wp6OSWHICIpbwo7E80VZ7o14zhc1voPdNnoXirsCzsovJuQAb?=
 =?us-ascii?Q?+hPsRB7t2yCQEVfaO6mge3DgX6doK+s8ruUH6k0rWv/HHSNRHB3k/B+nh0ZE?=
 =?us-ascii?Q?vg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ab5870-b8ff-4a66-6323-08ddd5aef1c6
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 12:35:51.5870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzRUtwmPYPpPoj/9K6eTuTdHc0PB3JONGKy/q2eyCtInoY4f5cSfSrOWgcPI0JOiokNXepXsb0aQHLM59cctnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8178

On Thu, Aug 07, 2025 at 09:29:05AM +0200, Krzysztof Kozlowski wrote:
> On Wed, Aug 06, 2025 at 06:05:13PM +0300, Laurentiu Palcu wrote:
> > Since the BLK CTL registers, like the LVDS CSR, can be used to control the
> > LVDS Display Bridge controllers, add optional 'ldb' property to handle
> > these use cases.
> 
> You did not add property here. You added child node.
Being under 'patternProperties', I thought it was appropriate to call it
a 'property'.

> 
> I don't understand the rationale at all. How the registers could appear
> in this hardware? What changed that registers were not there?
These are "configuration and status registers"(CSR). This syscon
device binding covers the CSRs for various subsystems. However, the CSR
register map is not the same for all CSR blocks.

> 
> Why every device here has ldb child? Why camera has ldb?
I guess I see what you mean... Would something like the following change
be acceptable?

---
if:
  properties:
    compatible:
      contains:
        const: nxp,imx94-lvds-csr
then:
  patternProperties:
    "^ldb@[0-9a-f]+$":
      type: object
      $ref: /schemas/display/bridge/fsl,ldb.yaml#
---

Thanks,
Laurentiu

> 
> Best regards,
> Krzysztof
> 

