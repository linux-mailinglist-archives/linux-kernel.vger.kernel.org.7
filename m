Return-Path: <linux-kernel+bounces-754662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E145EB19A8B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 05:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69D7E1891F8A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 03:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092B0193077;
	Mon,  4 Aug 2025 03:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OfhDISeu"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010007.outbound.protection.outlook.com [52.101.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B8714A4CC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 03:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754278848; cv=fail; b=GHAud9UKGHVpg+tSMCLwo1X67eggcmXKabFdRnRRg3066QwOo0zXxz0PFXTPmbkoYq7Of6ShK/FaXrnYnG3C8DIKoAQ6OmeKHoP+JdFQShoMTCaDIZazTHrEQT5Kh0OWTlQM557Ox7MPkTCPNdQFK3AKZDSkFp+3xV02W/cgLWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754278848; c=relaxed/simple;
	bh=oet1nf6106Twtf9QqmgJYytuOLYcrsERLsfr4PA+cUY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ed0NVsMITimNFV+hG85J2RkE2ZbOL6F3wU42/ffUZCNOJGcPjiuhQ/MEphAoct/KqEVKqR2ESLG3Zd+XiQ3R/maU+DNMTcxNeqk5GhBp22pdgRHjhfJygZwB7UXs4dSCqOmcrN5JRtRArnIT4wynxMbrXf2xI+b2dd1gBY0uKeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OfhDISeu; arc=fail smtp.client-ip=52.101.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQwRrZddxG1yHvjfJT6E/g66p4yZUzkhoaP/VzRN/gmuMo0TJ1H1RDRrg19hT5DlYpOAdebsy5CMIfdENeBGkQuuc43IElLcYBxL0LKawRupii9FNHv9G2NbPCTvyS3Ztn3ORyZ46z67s8gaS7RrdzFMgiN9EGW5LfzQrY4KNk5uUD1No8PjeSbqFLbXxmOBNnjLKSSY4KTfk3atq3mONIuTZCZWqqtYE4jK81Z52m40wuszF8sRy1Z7W11eNS8FcOThg7w3v8Y64PExFOrm5HWPT1qdYRj3PtNEttG4YPnk+IOV+BKEoasURKqJ29I3Zml8MAnrW2nR0s2DtVQFRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdShzxkRZpA5m+1p6bdDWL6JlER8VCUCBunFMP7KiKQ=;
 b=Orjv47q60YH3CouQfgxmmfIkpf0pQLSfhPiXdgvegiUR7NzYEpkYPUN/33TPPN3wwQn7IMT7brjmu0wvxEmzne3htpga/0A64ttwo9saS6oj/gL4RkvmkUpgUA5A4QcP1XTFIChGwfCO/HSDg+I5wsUrH2iOrg2zcMZ28+7QKS8vd7iWYM/Zqut4SMW1UbXbw3F/tnRbgjnxBmYJRx3Nyp4qn8rmvQGF2jXbIMk6CcOfkilGhaGqeRm9XJB310wjm2VVpZHYxvFJfIJE5VypYcmRgANPr8B7ei5Q5+5POLH0fxVcjMiZavbcbmpKYKumqWnoZ+6GFqVBhqlrmWm4pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdShzxkRZpA5m+1p6bdDWL6JlER8VCUCBunFMP7KiKQ=;
 b=OfhDISeu3/vZxGWJ58bONb3MyBjBtfyhSYSAMqFm0/qv85gtOERSg05S+7AYXJtV6Iw0bX97jkEL+vc8pKH0Z6LUxxp6spqsRWoX/zjBKWSYpNFanU2xhR0PKyKNHNJjfAEJOflgqDOCikEiIZFdwYS5JLs/5ivF+ET7wzfm1wafqqqiH9rUyOXlAC/Q0hrqQjtonezfUcIXT23mGpk21vMn+j/FLtMVzBWGYftdl6VYMLlgDon49kyD8P6WK/QDDtxiz1vgjZxX66JB9vwOUURfioynGEiDTlW0oxza2Ns1swjvxVuwY5OvoSg0r1vxGY8FwgmZGzPjBT+QVa9Fzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DU2PR04MB8918.eurprd04.prod.outlook.com (2603:10a6:10:2e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 03:40:43 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 03:40:43 +0000
Message-ID: <d8d3d252-1050-4040-9260-281123c15a09@nxp.com>
Date: Mon, 4 Aug 2025 11:42:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] drm/bridge: imx93-mipi-dsi: use
 drm_bridge_chain_get_last_bridge()
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20250801-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v2-0-888912b0be13@bootlin.com>
 <20250801-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v2-3-888912b0be13@bootlin.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20250801-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v2-3-888912b0be13@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DU2PR04MB8918:EE_
X-MS-Office365-Filtering-Correlation-Id: c4d18c7a-0a7e-4355-94b5-08ddd308b049
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WDZERHlqN0tSSUhHdjdJTEgzNG9abWVHKysvWnlnWUkxbEhGWmF0THcxSlhu?=
 =?utf-8?B?K2llNXBZNkZ6cVU1Z2h4a084ZlhvOXcrOUdnUEM3OE1wK1VpTWQ3UWgwd2Jr?=
 =?utf-8?B?VlRVTjVzMjhkWmhldG9kaFJHcTkxNHlMZlRpcTVKelpvTDBPSDBYblJkWHpp?=
 =?utf-8?B?VU5TbTNHWWVaZzRHUHNhb0taZThoSXRtejFPNWZTMWZyZFc0bGtNbEQxMXFG?=
 =?utf-8?B?cU5KSlFwVWNHb1FuL25WclhWUmQ3VFZiS3crRmFOQk85UDJ6QmZ1Qjl2cFdm?=
 =?utf-8?B?WEVhTThuNVludXZ4Z0YyVEFtQk5uS3dsN2NOVDMyeGx4dmMxMHhMZGU5em1y?=
 =?utf-8?B?T2Y2b0ZHZktiSGxQbnNkRTNTK2RiOXY5citkQzNxWnBmUWdiWEZQNGwzUEFo?=
 =?utf-8?B?MUhHVU9HbjJzV1N5bjhCTEJlVHBoMUtJZVNsbzFDQWgvZ3E3UlNLcXVOdHYv?=
 =?utf-8?B?UGFsdng1cHVzYnJHdlBqUElKdnozb3FQcEdFU1FNbmNySitYOVVsbmZOTFlx?=
 =?utf-8?B?encvRHppUldrVUh1ZUtVYzB1eW1lLzBmUERVL2YzSFgycGdqMVRqTjl2Zk4v?=
 =?utf-8?B?S1V3LzFvYWlqbWk2bWpFUmRZUmkzRUpacE1zQ1JCbHIwVTRPeW1qdXVpREI5?=
 =?utf-8?B?a21EeDJKR0l1d09kZkdock1GUEUzMEJ0dEp6bFhCV2NCRUJiOFZoQnhaRWlq?=
 =?utf-8?B?b2tjcy80b1hBSisvQlNWeWg5OW11dHpzeGNQNi81SXFjeElKVTlwUGREYlZE?=
 =?utf-8?B?M09GRWh2bW1qTFZTdFJvejNrOXZ4RWpsL1VVTDd3ZmF4OWFzNDU4MWVkalZW?=
 =?utf-8?B?cUlONzJYd1lPR1g0eFhSVGlvNDZmK0ZzZ0lUVUJON05KM3Vtc3FBRmJhalhF?=
 =?utf-8?B?QTdSM3FGUmNNdm5BN0NPQ21SWlRUTTdIUW9qblNNVXpKWlNxWmhoajVtSGpQ?=
 =?utf-8?B?eXpYSHRWLyt3WHpoSndOdDJXWnNvYzRHcXhUTHVFWVp0RllQUThDSHdiSlRj?=
 =?utf-8?B?azlZUm04L3Z3amxHSHllcHkxTE9oVTVNek9USjNlRUZIVlNZZkt6OTZZcGJr?=
 =?utf-8?B?THJnV2pFd1djcUVuWGFIb0t1Q3pScHl6N3VwbzlKSGF2SEtvTzdJUGM1YVVF?=
 =?utf-8?B?d0pxTFZNNVVhNDRLRjlBQXBXV3ZxU0t5djBnd0VpNFVKQmNYTEM1N0Myb3Nj?=
 =?utf-8?B?L3ZuZlR3a2hFQjd4blE5ZUhsSjVraENGZHZ3UGViUGQyZDByY2NDbHYvaytP?=
 =?utf-8?B?dUdhRTBVZm40NHFEbDVnaE1mU1ovOGNpSExDYzdNeUE0MEZrOWtFdWpWZCty?=
 =?utf-8?B?RG1tUGo5N1l2bGtJVldXd3pNY3Vxc1BGUmo1Q1VQOEtEMzVKRmd1RDNIem1K?=
 =?utf-8?B?OFFkUHZmK3RFSUlHaEhYMnlkcEtISEh0NkEwSW94aTBLT2ZJcW1FVWNIdlZm?=
 =?utf-8?B?UjF6ck5pVzFzRG1UWC9aTmJxYnNBNnF4OEx4Wk1hYUdGWklsU0tOVll3UnhG?=
 =?utf-8?B?WE5Va1FHRUo0NVVlQnBwVGsxai9GaDdoQUdVWlZZVFI3UCtENGNYWEdOaStn?=
 =?utf-8?B?L1p4MCsyZ3AxL0tLd3RDUlZuTzRTOHR2MCt0bFo2L3BuTkdUTWx5Z01JMnl2?=
 =?utf-8?B?Y3JvcHR2MFJQLzhUOWpkY0NDTUg3VVVYQlF1b0N3M3plRGRXVmsrV1JSRndO?=
 =?utf-8?B?RFpPbW8wdjNVelZFeEZlYzhRMFBaOFI5SEp6cVdmUllQUHFpU3phNmc2Wlg0?=
 =?utf-8?B?eHV2bjJsZFNrZFNzRTNhcXUzd2lqYmFCSnNIL011T0hlZWREeE9tL2MzYkh3?=
 =?utf-8?B?amQ4NklGT1JFSUdQTzhFTkJVVTFhN1QyNjNxd2x1cm5kQlZaSnV2L2huMEhj?=
 =?utf-8?B?emR2Mml5VWo5L3A1V2VEbUNSSXhEbzNrT3BMbk1wVjZmVkt2MDhMaEp4cDVI?=
 =?utf-8?B?Rm9uTnF5Q2c0TTJjeC8ySXl4cmdGSVBvK3liZkx4cUJjSmFFWTRZckp6cGVr?=
 =?utf-8?B?cThNRXd5eERBPT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eWd1cVk2dzVlRW9HZ3lCeVB1MWlmQjE1MUtpaVBRV0x6V2o5QnZqVWk4d0F5?=
 =?utf-8?B?Z0k1K09WT29OMXNYSTVyL1ZVRFVtdGIyY0RCdjV1a1VBYVRyTXRyWENWQkJy?=
 =?utf-8?B?Q21XOVhDdUlIUm5NUVh0M0c3NFgzdDVrZnlhRFROTWo1WkRwSndPRjhBa2p2?=
 =?utf-8?B?RytJSmgvb0h3TTcwdlcxY2RHWDcwQUhMTjBGcGFVaDg3SlZFM2gzRzBwYXNL?=
 =?utf-8?B?VzRJb1N3K3ZrNU9uN1NtYlVOVHJkTGpPanBQMUNhcWY2Ym5YdkZSVVBTUUVL?=
 =?utf-8?B?aWtiWHpkVU82ZTNtNXBaSWgrdUF4WFhqWHlMcGUrTWpmLzd4QjdMM0tNeXhu?=
 =?utf-8?B?NTBMOUlNblpJUjZaeWF5eHZsZ2tZclJqNENKODJydkdTN2xzeDk1UE9RL1hM?=
 =?utf-8?B?b3RQRGk1NHZCZ1FKbG1jcTVOdTlMaVg1V05aT1JGbEh2aUoveml6RHhNanR1?=
 =?utf-8?B?Qk04MXA4OUNaM0U0Y013S1BhektlMDVFcEhRTGZQVkw3MDlsS0xzVE1rV3Bm?=
 =?utf-8?B?YXVPcEdCTFBET2VsYW5GOGMyd09rZU5EYStMOWl6M2dRc2NVVDBJd2xKT1Zp?=
 =?utf-8?B?emxPL0VabXpVWGV5MG1TSXdVZmtBVTl6VzUwWUpJcmlWQVV5eXJLZndudmFP?=
 =?utf-8?B?cUxjTmdia085czVIekpjQm1kZzlVZitMVldNZmxiWlV6c0I5SURjbjVnTUNx?=
 =?utf-8?B?SUxXRmcrTWVnZjJrWTZPSXZrLzdJanQxS3c2aWkyVEdmdlY4Nktld1RDRThi?=
 =?utf-8?B?S21QUjYvM3loSEcwRWdNN0xldHdCbUQ4NjVaY0tOSmFtTXBKejNFZkF2bG9U?=
 =?utf-8?B?eEprR1VQVGJXaXRZWjhobVNUdFJ3Qkk4OUowT1FNV0hZUlRVR0lrQitEaTFl?=
 =?utf-8?B?NFNPaExRTGlKMzFHN2xqcHlvSndack5NWG9qNE5yeXd4SENqZmdzd2RXNzhC?=
 =?utf-8?B?eHhSVEdyVTFUSzBTMEhBdGZVall1dlVmOFBOc3p1bm9TS0hncHA3VjB3cVAz?=
 =?utf-8?B?Q0FkemkxTEhNNFJHb2c4M0xCTzFiTkwzb3R5NlduTGNDNjVXTFJzaVdZMXdB?=
 =?utf-8?B?Ykw5QkZwNXVWTmozRlAvTGZONUNvSGFTcERWRzlLS3hWSXZHMStYOGdVQ0Nm?=
 =?utf-8?B?RytJZEt6KzFWQmUzcWFubmFtelR0bGhTS3pFcTB6dHhYZzI2ckxaK0twNnVE?=
 =?utf-8?B?QVZJNFNUUzdCd2VxK1VadG5tb0tOR1FhQU42aStBOTdFcEgwTVFDVnd3RlJi?=
 =?utf-8?B?czBxUGpMaEhjbExMdTZwWkR6ZUhCN3NWOUNNNEorcGNQSUpwV1p3cERpNXNI?=
 =?utf-8?B?dW1tY0dqT09KVjl4Tm1uZmxGUWFxdHZpZ2NydUJoZUM2N3dhajQ0SG82TGo0?=
 =?utf-8?B?ZVdLZm5ZR1RpendLNWhzUm03a3JiYUc3Y0VwZUVxV05yemZYRm8xU2IxTlRK?=
 =?utf-8?B?bXgyTENoTnZUdXU5WHRlRlN0UHZxbXQyRElsWTN0WGU5K1RIRTZJN0J6L1Vw?=
 =?utf-8?B?Y1V6TjJOSHd2NGU0dDBoNGJsbHMxcHA5OHYrcG5MZFMyQzdmN1hLTE12SGxN?=
 =?utf-8?B?VFJidW5oT1JPMUFNV0pncTBNTjJFL1dJNk1FV1kvSTlXSlQyUzVyak5Mc05F?=
 =?utf-8?B?aEZza2ZQUk12bWtIQitRS2Zmb0dPcWN2a3JUaitxSXYvVDZ3VnNrT21QQ1lp?=
 =?utf-8?B?ektMNUZpK1RJdzlzc2cvWHMwK2p1alUzTldkVTBoNjJjRTlna2RwSWdsNjZW?=
 =?utf-8?B?K0lxVzZjbGpadUlVdzdGNjh6OHNQWU8zSHZXdFRIYmxKQkZYeG1HaFlmSUhC?=
 =?utf-8?B?T245VTlOOHBmbnlRNlBqVGx6NUlNVDlRdHg0TEhzMW1qWGZXTUswRXpHL3p4?=
 =?utf-8?B?QlBoRnRpbzZUWXBTbjcrUCt2Z2RTMGdZQ01pNlY0dldFTVlvYWNVcjBPUk5W?=
 =?utf-8?B?azFlb1FEcTNCVTdGYjBCZmN3bWtVcGw5OTVDQ3dSTi9tNEtMMlI4Q080YURm?=
 =?utf-8?B?dHFXMVdXeExjT0pNU0FoMXRIalo1WTQ3dnFFalV5a2JCckZ3c1B3NnRqd0ZF?=
 =?utf-8?B?TlNrMHVXUHVpamQ0aTh2Rm8vbXdQQmMwcXA3aTAyZlh5YjFrZitJSFk3SUJw?=
 =?utf-8?Q?IG0D6f6feIE5PcYjwKxSfI6kW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d18c7a-0a7e-4355-94b5-08ddd308b049
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 03:40:43.0484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7E9yd/1W0esulL2KnLbKXfpYBCBvqqK2M4+R3nHqV+DRM0EXuyuAkEDXUekpVwF+CCD23h0vjYEn4dSBjUGGQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8918

On 08/01/2025, Luca Ceresoli wrote:
> Use drm_bridge_chain_get_last_bridge() instead of open coding a loop with
> two invocations of drm_bridge_get_next_bridge() per iteration.
> 
> Besides being cleaner and more efficient, this change is necessary in
> preparation for drm_bridge_get_next_bridge() to get a reference to the
> returned bridge.
> 
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

Reviewed-by: Liu Ying <victor.liu@nxp.com>

