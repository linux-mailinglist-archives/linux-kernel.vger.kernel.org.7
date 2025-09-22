Return-Path: <linux-kernel+bounces-826591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 258FAB8EDF0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 05:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4C4A7A8118
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 03:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6845C2E1EE6;
	Mon, 22 Sep 2025 03:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FCO/NP4+"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011016.outbound.protection.outlook.com [52.101.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402582ECE86;
	Mon, 22 Sep 2025 03:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758512468; cv=fail; b=FXmAY5BZdTEpnKf4wclY16eZjWnMeTtvM+eCBwh34TcWzD8Z57bVKb7bGsOtpuMEpBQcm9UEzOkSjldz/z4gJs8z1fgHBIAncc2AE3jHW3chbrUSWxJ2znXUo3LwDCXm+K95VrMjsGwE77DOOhEw5n8Z+E+52TpEHSSobGOlZFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758512468; c=relaxed/simple;
	bh=DJveDZGlym/nfgfN17I32FB6Ae5k8/uJ6Qz4Y6EcvSs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cDt6nZNAyL2bumNFSfH9JD95VvO1Jc6wDSJVupIcNfmQLmUdIF06Xn736SiBqehbdkh4O9w3Wjv03NSwimHP7x/WZRHdQMi5GSCTkVCWStrtVKZ0EX2/icAuwQga9sAhVxPnHDyH0Tsl+5ABv4Nqlv6S/dqgF9/JPOGFUzr0Fds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FCO/NP4+; arc=fail smtp.client-ip=52.101.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GY8D5o01tDUrv1025WTjUoZpYL/9mVvkNGi1mPuIsuaDIun3FYe7EjGmWWD3QRv9CuhlbOtBolFOgJEecbAh/OXqYhkw8d0gBIlWfCC5+p/6nyJ7gGflywIOabxgTnwKvmUQizKXS+WEWTV+eDYCAe6M2zx9X8K5Uh3H5zraqomwio2quCNKG5niUqHhmJYYtoY7PC22ZmEfWUKuQopB9N8I0gSJDpnfoWLoHAahfX57TnfQYDRimZRGL4X/EJirpTGKGLTZ/vBSeNvh2ieBQ7IA46ITRxTnsLnbmwF2zzJPhejB1Iorwm7gkUr24HNtG6e0T3cHv7EbWXQav3H4iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9qQu80eqcCh3j9Oo2wSpcdFN1ria6o2WN1+kCr8wXc=;
 b=I5ldjkbdRXS4uPkG9GAnv90zYz0Oc2Vye5IuWM/xqUDz2YrzzJIBUQFJNFibPL6WPCak8WtHFj9WzPnjgjawLI9JwzXPaXUTD0EsYevvGGk4215kN4Bpk4CUv6HhS164h+6OWsaYjV1zwnhq4KqFccMqBLGx/FO5aR0WQ026EbtlutoMoDaQpmg+snvdWnRi8WMUiVcFsySikSfC8oIGkwOprNLk2ERoAyXpMPOuxV0lkve7hrmfyhnSGgGYkuzSq6FjkNt6op26iIpo5y5MYk3v2334hUrshapCTnubyuXr50GE6Lo7ZZ7cOuPiuyFx6t/qCOAtuC8nugtlq+nYaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9qQu80eqcCh3j9Oo2wSpcdFN1ria6o2WN1+kCr8wXc=;
 b=FCO/NP4+V1lFUPaFf8YuMh+qzwmimRWS2QaSoMz08l5yUmZgyaHFPsJdigjF9f9vKtt3PE5uqHvsNzNk4tCTAC6cJkgt+k7KVkXnFak0wDMyMz9mAUkJF9D+wraB4Q8sL2thmNf959xFLApgw6ZdlaHVbmJ1KpV4JXLVwsbmSJi742UlfkScGaVCExESN8zR13hxSfzipnVJPDjq7TKFAVsogQvA0HaEpXIG7l9TOdK5vKoAk2CFRqpumlL7fBFze4pyHLMXYDXR/M/q0BcPDwwpmWCTPefDsICdPd1IjMkNGoz2+IotOeVnFxq24uOb6+qyFKQJFeCHO0uJJnCPDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PA1PR04MB10263.eurprd04.prod.outlook.com (2603:10a6:102:455::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.8; Mon, 22 Sep
 2025 03:41:01 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%6]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 03:41:01 +0000
Message-ID: <18230ef9-09e1-48c8-aeee-d40d483e28b1@nxp.com>
Date: Mon, 22 Sep 2025 11:42:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] drm/imx: dc-crtc: Disable at boot
To: Frank Li <Frank.li@nxp.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250704-imx8-dc-prefetch-v1-0-784c03fd645f@nxp.com>
 <20250704-imx8-dc-prefetch-v1-5-784c03fd645f@nxp.com>
 <aM1w4URkELrmK7No@lizhi-Precision-Tower-5810>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <aM1w4URkELrmK7No@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|PA1PR04MB10263:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba5d654-30b1-4a5e-2381-08ddf989d98b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFZka1hiWEtOSDZQZndIUVdnc1VTM3p0eWlmR1MvVWpRVFgwY0dobUF4Vm05?=
 =?utf-8?B?b0tOeDJCdE9lYzk5RWloQUhERFpXNEhQMDBkZG1CZC9aRnVJWjZHSFc2M3BM?=
 =?utf-8?B?eGJYdXlVc1JmUlpTYXZBTFpsMUpZU0xpdUJGTG9DNzJvUWRTMGo5cllvVXlO?=
 =?utf-8?B?VllmalQxNExrS045TjhYWWR4OTlCZ2VMUEFqU1NMRlkrcW9xcDdFZzNNSTBs?=
 =?utf-8?B?emlJRjZJU2hBRjJXejR2MDVqak1mc0JFUm8rdVAydUdUYlhDUVczTFU5RldW?=
 =?utf-8?B?SjJmQ1pFU2QvcDhUalEwNjducm9nVlJPcS9JSlk2L2ZZTnZXR2NQS1RkcGRP?=
 =?utf-8?B?dk11dFZnNTRvcFJxbGd6S3U2bkZEUC8xejNDZ0p3NWFBMGcrYzNrMlFhaTIz?=
 =?utf-8?B?S1pRYnpwZUh0TW1oazhRU1FCVmVDT3VPK3oyVnN3MDM1bHlRbDVMcHMvdG82?=
 =?utf-8?B?SGo0Z1BuOFpGNS9YVTY3U2RvZENwZ3d1emVDV0pGUDlHc0I4VDJBM1luNkZr?=
 =?utf-8?B?RUIyR2NLRC8vZWgyWHZWVWM1WDM0czA2a2Z5ZU5pMXN6ZnpVa1VJWTVhVDBm?=
 =?utf-8?B?S2RUVjN1VUs0c3NvZHYzdmxldjJPN1I5M2U2WG42WWVMdmFId1Z2RGh4dmVa?=
 =?utf-8?B?RjZwMmNNNmNXTTN3MjFQcnJHM3RKWXkycnU1clN4TkZaZjlkbXRQcmN2WnhL?=
 =?utf-8?B?QU5CVVNOdWp6cm9hQndDcG9DOTJTbGY5TlgyNnBWTjF6ZUFUQjRpVXpwU2pC?=
 =?utf-8?B?Y2NwY2JjYnh3VmlPd3doWDhFNjB0eVgxOTVRd2UxaUpnY3hoVG8xYi9uR0xz?=
 =?utf-8?B?MUozN2k5NjZsUEt2L3ljdk9vWnhpNXlzRWFEK3RqVGFvQkRXb2RwM2xLRHpN?=
 =?utf-8?B?VHhpa2JuUFhnZ2pLNXFYblFOSnNOY3RFU25Bc09ERWFUVkZ3ZXhockxhRDA5?=
 =?utf-8?B?ampzTklqRnlITlNpdll1dWlGQkZ6cy9SYlI1ZUFDRjIrcE5rV3p1KzZ2ZTJy?=
 =?utf-8?B?WUJuYml2b1BkWEs5ckZ2V0w4ZWRaRTVlVmJZZFpLY0YrRjBsUkxUUmp6aTVL?=
 =?utf-8?B?Z0NzTSs3bXNFUkpqUTdrNStBZW1wT2k0Zk1rL3ROQUsxRkEvdno3K0daOWhY?=
 =?utf-8?B?RDFmcGV3NXp1aTlUcmpzWHAyUHBqWGNqQ1VmYkpRVCt4T0V4WmQrc2JpRTNm?=
 =?utf-8?B?ZGQvWnlUaGozR0dEVWxqK2JjOHUxK0JWZFp3VENvdHBuV09PS1ovNUlqZnJL?=
 =?utf-8?B?dFEyaHl3c1NpdlhEZExDekZBNFdnUEx0bHZpWDJlUURZSzhXVTF4ZjBCOFpL?=
 =?utf-8?B?MHpDVVYxTjgzNWUvSDRYa1F1N2xHN1JCMVlqa0hHWjNOK3o0cHkrYlZicFYw?=
 =?utf-8?B?c09VajZScm96aDY4LzRmSE11aHIxTkdLMTVsMVJSNE5YZkdOS3NneEdyZXNL?=
 =?utf-8?B?M1pkWnNOUUtSVjNQeGVWczNCWmJIaEFLK2lpenN2aW91VzNOWGpqYjlOazV1?=
 =?utf-8?B?VUlPbWt5eWNac3hTTFRqS2N6VC9IWWl4WDlsMmFLTnhMdnhOOUZqYkY2V1FW?=
 =?utf-8?B?NWVZNkdibjZxWmcwZVVFbTNORHpjM1V4U3l1RVRMNUtUbHhwU1pVRW85OThi?=
 =?utf-8?B?STFwVWg4QlNQY3lsY3VybWFoZEQzWGkvcDgxTzRHVk4vb2xLejI0WE5xY0hX?=
 =?utf-8?B?dGhMeU5oTHNEMzQ1UTgvckVQT2hGWFFsbUZTY3RZQ2tjSjZkS2FtSkdmdjlW?=
 =?utf-8?B?eS9wTXZnTzFCSFN0eVJoQ3lUSFRHMWliSzdlVkJ0blhqL2ZvL2cyLzJnYytn?=
 =?utf-8?B?eEJ5RW5FVnhnMXJ5Q3FDSEs0UklMT2pIYlJOcjBGQ0dYTVhvQkh0ejR6MCtC?=
 =?utf-8?B?SjZyWXNkS2RMejREc1k0K2lWV2Vxc3dYRDJMYytZM1JWcnk2WWpRWnBuM3Ev?=
 =?utf-8?Q?+BWN2jTvUwc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3praElTSzh2bmZNV1M4dm1sRWlaTTZOQzBNZ1h2enJBemNSU211RFlFcnp2?=
 =?utf-8?B?anlyYUdDd0o5Smx4ckxTQlYzRElQMkIwYUdseHB4VjFOYTFreGptVGFncUlH?=
 =?utf-8?B?WmQwVitFbW9ZQjdFbjVDcGcvZTAxWmk2RmZMcUJmY2M0MjRzUkx3aTkzcmg4?=
 =?utf-8?B?T3A2anF1V1Z0YkxBMitjbnRQbUtwa0pPcVJKS25wNEhzV1BGaFVEQU0xeG9q?=
 =?utf-8?B?Qm0yeTFncEVFbUNMV1k2L1huaXBDaldVM25lZFMxQkFad1JTTEF6NU5lOSsw?=
 =?utf-8?B?YTdudDJSY0VaWkxrRXVqaVZ6MkFSbklqVU9lU3pmM2wyMlZkV0t0ZE5RZUVh?=
 =?utf-8?B?ckJnRkIyL28yNDFuc1hPWE5LcEZSUTQ4djArQXF0SmFkUlJTL2lrVWxaQU5n?=
 =?utf-8?B?dEp3RDBQOU9LTGNjbTFLRk5yVGU1bWdEc3FlVG5iN3BJMDlhQy9Pa1lwVW9v?=
 =?utf-8?B?ZXZBVDUvdSswWkM3YndGUWNHR2lYM1lQY0JPMWJFQXNKOGEyR21SVHl3aGFH?=
 =?utf-8?B?UWFlTDR0VURJM0xSTitoMjVyYm9CNzlNM1BEMDFHdGgyemxaeDJFTlF3YlRT?=
 =?utf-8?B?OWZJMjM2bjcrSUhvRFZzcXEwRERTSDBYTkVVVU1wb0JOUDRHdW9lNzNnSys0?=
 =?utf-8?B?c3pxblEyT2I2eDhJUENxTFFvL2N2TEVwWllTYzg2QlNQczZBM2xoMS9NSEd6?=
 =?utf-8?B?ZDh5SjlXazBsd0V6cnFxRkwvUWNGRmdwMWdjcFRKaDV0NkVHUGpjSWRvek00?=
 =?utf-8?B?RW5ZVjFYTzV0ZHVYaDliaXVpZkFIOUZsb0s0ajUvMUhaQVJpaDVXVE9rZ3pX?=
 =?utf-8?B?SmhVNzFpdGVEL1ROQnh3OVptOGZWZG00WjBqdlVnL2ZZY3orN0VNMHBuVUNB?=
 =?utf-8?B?RkoxeVZOSWwxSFJjMVBzKzBMQ0pZSVlMS2xubjFaejY4a0pUZ1ZRY0ZJcEM5?=
 =?utf-8?B?eEs4SHE5UkNIaU96ZVo5OUxiUnFKS1g3V1FBeWNoQUtORzZqZ2pHWXJ4aFE4?=
 =?utf-8?B?ZDhxSmNMa2ZsSm90YWFuN2xHSFJSYXY2MlhIdVo3QmVZT1VIcnBMN0JTMVdZ?=
 =?utf-8?B?ZEQxUVNJaVpMTjNyQWZOTTkybnBObmRmazkrZThxR29DMXZldi9jNkVGT2Nx?=
 =?utf-8?B?SHA4emljZXRKT3hZM2xrTjR6SXdtQ1BjQmNERnZHem9XcC9HWTlHVVBkN0xu?=
 =?utf-8?B?dmFQZHoybFhCZUhBbm1qWTBmWmxOU0prcFFleWlqY1VKWUxCeFNLajBBaGRi?=
 =?utf-8?B?dnMyMHpCY1E3cTFTSXViZHl1cUQ2bG5qRHRObVRrZjB2SEtBblFWbktieFJm?=
 =?utf-8?B?R0hwVi9hMFFvdDdseEd5YldUdUwyUTB5UksxQ0J4b1lwUm93cStWM0pzV1BW?=
 =?utf-8?B?bjlvTW5na3hUb2tFbytIdjlQTkQ4WVRZd3B3OXB0VDZuejNXWWRWSWV0T0hl?=
 =?utf-8?B?M2VOWTdiRFpGMmgwbGFUYnNkZVZvcVh3Z2UzOVhHU0d4OVBBSTdNOFkzc1Rm?=
 =?utf-8?B?amYvVWErenc4K0pVNFdZYTZMdERDY2Z6TVI5ZnNKZzJPZEY0SXBtZFpvLy9x?=
 =?utf-8?B?dkkzQ1RkS0pQOS9RdW9HTkNKRWw2RmozMlFjYXBwbTNSOG5tZzF0akhKdXp5?=
 =?utf-8?B?d09Ia1BQYVNJRWFtcllGN3h3VVRrNHk1aGlaWHJzUGVsS2wzSFUrajhlUFVm?=
 =?utf-8?B?OUZmMktieEhCelNIVTNKTWQwakdrQU9tck91SSsvRlYyVHFtTW8raGpNaE01?=
 =?utf-8?B?Q0VnR0F2L255ZFBxU1o1Tk5nRFRkQVNseUQ4RWxJdStxa2gydTVUY2FuS0lw?=
 =?utf-8?B?N3U0TXY3WVRYWkt6ODRrRnYwdXNNK2lOZTFyNS9CWDFmNnlWSDJxRHBjUnR1?=
 =?utf-8?B?YS8xMUduL0VVYXJoOU1kQzVLSTBrcDB3dzhEVGtmNjhZUUlGSVlEWmhUSDhB?=
 =?utf-8?B?NlFaa0h2eGVzTDB5QUd6OEJ5S1gzMjA4NmJ5NU5NcmtkczFSQUJBZXA0ZThI?=
 =?utf-8?B?am02TjFheStqMWFuMENPeWdZMjRYMVZtZFlxclcwaGExamxueVdxeWVFWVRL?=
 =?utf-8?B?d2ZDSExUUC83Y0szSUovdDN2Zmw5dWZtUHJaZkdsa0F4bjRuNVBDblI0SXNa?=
 =?utf-8?Q?Jti8SWtjMo61iGONjUiBFH9vd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba5d654-30b1-4a5e-2381-08ddf989d98b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 03:41:01.4149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IA6tPRQzXr++lLaXjpohK9dnL+H+4EqzrF0Pr+XttEDxZKR+hbxcIhv0tZhVINUKvkrRab2L49mGV0z7ijK+xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10263

On 09/19/2025, Frank Li wrote:
> On Fri, Jul 04, 2025 at 05:03:52PM +0800, Liu Ying wrote:
>> CRTC(s) could still be running after the DRM device is unplugged by
>> calling drm_dev_unplug(), because the CRTC disablement logic is
>> protected and bypassed by the drm_dev_enter()/drm_dev_exit() pair.
>> Hence, Pixel Engine's AXI clock use count(managed by Pixel Engine
>> driver's runtime PM) and pixel clock use count could be inbalanced
>> after removing and re-installing the driver module.  To fix this,
>> add a helper dc_crtc_disable_at_boot() and call it to properly
>> disable all CRTCs before advertising DRM device to user-space by
>> calling drm_dev_register().
>>
>> Fixes: 711a3b878366 ("drm/imx: Add i.MX8qxp Display Controller KMS")
>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
>> ---
>>  drivers/gpu/drm/imx/dc/dc-crtc.c | 50 ++++++++++++++++++++++++++++++++++++----
>>  drivers/gpu/drm/imx/dc/dc-drv.c  |  5 ++++
>>  drivers/gpu/drm/imx/dc/dc-drv.h  |  3 +++
>>  3 files changed, 53 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/imx/dc/dc-crtc.c b/drivers/gpu/drm/imx/dc/dc-crtc.c
>> index 31d3a982deaf7a0390937285c9d5d00100323181..45a87df1ad6a8bd768aa5ed38d6f03f14052b3d7 100644
>> --- a/drivers/gpu/drm/imx/dc/dc-crtc.c
>> +++ b/drivers/gpu/drm/imx/dc/dc-crtc.c
>> @@ -293,6 +293,16 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_state *state)
>>  	dc_crtc_queue_state_event(new_crtc_state);
>>  }
>>
>> +static inline void __dc_crtc_disable_fg(struct drm_crtc *crtc)
>> +{
>> +	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
>> +
>> +	enable_irq(dc_crtc->irq_dec_seqcomplete);
>> +	dc_fg_disable(dc_crtc->fg);
>> +	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(dec_seqcomplete_done);
>> +	disable_irq(dc_crtc->irq_dec_seqcomplete);
>> +}
>> +
>>  static void
>>  dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_state *state)
>>  {
>> @@ -305,11 +315,7 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_state *state)
>>  	if (!drm_dev_enter(crtc->dev, &idx))
>>  		goto out;
>>
>> -	enable_irq(dc_crtc->irq_dec_seqcomplete);
>> -	dc_fg_disable(dc_crtc->fg);
>> -	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(dec_seqcomplete_done);
>> -	disable_irq(dc_crtc->irq_dec_seqcomplete);
>> -
>> +	__dc_crtc_disable_fg(crtc);
>>  	dc_fg_disable_clock(dc_crtc->fg);
>>
>>  	/* request pixel engine power-off as plane is off too */
>> @@ -337,6 +343,40 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_state *state)
>>  	spin_unlock_irq(&crtc->dev->event_lock);
>>  }
>>
>> +void dc_crtc_disable_at_boot(struct drm_crtc *crtc)
>> +{
>> +	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
>> +	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
>> +	int ret;
>> +
>> +	ret = pm_runtime_resume_and_get(dc_crtc->de->dev);
>> +	if (ret < 0) {
>> +		dc_crtc_err(crtc, "failed to get DC display engine RPM: %d\n",
>> +			    ret);
>> +		return;
>> +	}
>> +
>> +	if (!dc_fg_wait_for_frame_index_moving(dc_crtc->fg)) {
>> +		dc_crtc_dbg(crtc, "FrameGen frame index isn't moving\n");
>> +		goto out;
>> +	}
>> +
>> +	dc_crtc_dbg(crtc, "disabling at boot\n");
>> +	__dc_crtc_disable_fg(crtc);
>> +	dc_fg_disable_clock(dc_crtc->fg);
>> +
>> +	if (!dc_drm->pe_clk_axi_disabled) {
>> +		clk_disable_unprepare(dc_drm->pe->clk_axi);
>> +		dc_drm->pe_clk_axi_disabled = true;
>> +	}
> 
> look like dc_crtc_disable_at_boot() call by dc_drm_bind(), does it call
> twice without call unbind()? Most like other place paired function have
> not correct.

It could be called multiple times by bind() without calling unbind.  But
it's fine and by design.  As this function checks FrameGen frame index
moving before disabling CRTC(no moving with a disabled CRTC), CRTC is
actually disabled at most for one time no matter how many times bind()
is called without unbind().

> 
> Frank
> 
>> +
>> +out:
>> +	ret = pm_runtime_put(dc_crtc->de->dev);
>> +	if (ret < 0)
>> +		dc_crtc_err(crtc, "failed to put DC display engine RPM: %d\n",
>> +			    ret);
>> +}
>> +
>>  static bool dc_crtc_get_scanout_position(struct drm_crtc *crtc,
>>  					 bool in_vblank_irq,
>>  					 int *vpos, int *hpos,
>> diff --git a/drivers/gpu/drm/imx/dc/dc-drv.c b/drivers/gpu/drm/imx/dc/dc-drv.c
>> index 04f021d2d6cfc93972aa8d9073be24d347152602..f93766b6bfbfae8510db05278d104820ca0719c4 100644
>> --- a/drivers/gpu/drm/imx/dc/dc-drv.c
>> +++ b/drivers/gpu/drm/imx/dc/dc-drv.c
>> @@ -17,6 +17,7 @@
>>
>>  #include <drm/clients/drm_client_setup.h>
>>  #include <drm/drm_atomic_helper.h>
>> +#include <drm/drm_crtc.h>
>>  #include <drm/drm_drv.h>
>>  #include <drm/drm_fbdev_dma.h>
>>  #include <drm/drm_fourcc.h>
>> @@ -96,6 +97,7 @@ static int dc_drm_bind(struct device *dev)
>>  	struct dc_priv *priv = dev_get_drvdata(dev);
>>  	struct dc_drm_device *dc_drm;
>>  	struct drm_device *drm;
>> +	struct drm_crtc *crtc;
>>  	int ret;
>>
>>  	dc_drm = devm_drm_dev_alloc(dev, &dc_drm_driver, struct dc_drm_device,
>> @@ -118,6 +120,9 @@ static int dc_drm_bind(struct device *dev)
>>  	if (ret)
>>  		return ret;
>>
>> +	drm_for_each_crtc(crtc, drm)
>> +		dc_crtc_disable_at_boot(crtc);
>> +
>>  	ret = drm_dev_register(drm, 0);
>>  	if (ret) {
>>  		dev_err(dev, "failed to register drm device: %d\n", ret);
>> diff --git a/drivers/gpu/drm/imx/dc/dc-drv.h b/drivers/gpu/drm/imx/dc/dc-drv.h
>> index eb61b8c7626933adc7688f046139e2167665dad1..68e99ba7cedbca1b8bdc0d8ced7a610a1056bfc7 100644
>> --- a/drivers/gpu/drm/imx/dc/dc-drv.h
>> +++ b/drivers/gpu/drm/imx/dc/dc-drv.h
>> @@ -50,6 +50,8 @@ struct dc_drm_device {
>>  	struct dc_pe *pe;
>>  	/** @tc: tcon list */
>>  	struct dc_tc *tc[DC_DISPLAYS];
>> +	/** @pe_clk_axi_disabled: disablement flag at boot */
>> +	bool pe_clk_axi_disabled;
>>  };
>>
>>  struct dc_subdev_info {
>> @@ -96,6 +98,7 @@ static inline int dc_subdev_get_id(const struct dc_subdev_info *info,
>>  	return -EINVAL;
>>  }
>>
>> +void dc_crtc_disable_at_boot(struct drm_crtc *crtc);
>>  void dc_de_post_bind(struct dc_drm_device *dc_drm);
>>  void dc_pe_post_bind(struct dc_drm_device *dc_drm);
>>
>>
>> --
>> 2.34.1
>>


-- 
Regards,
Liu Ying

