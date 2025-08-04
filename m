Return-Path: <linux-kernel+bounces-754962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2088EB19F39
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D096A3AAFB5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC6A248891;
	Mon,  4 Aug 2025 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lmzHr9wN"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBD02472AA
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754301767; cv=fail; b=dk9wkgH4TdDwxum3sHA0CoNYTT+uDqH8CYCMubM2fKGypjiNBlJY2SpYJe+g0pNPBgN/g31lubW5W7KifGNQEM7F5AAZJPWoYMBEzlK84VxWFDDFH/8GT4IFVaxyLIFmogFryQT8hdSPhtMAne3Ht76cCUQ9vlDqXn5F5R/LJMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754301767; c=relaxed/simple;
	bh=h/85dXF968YCcW/+JoOU3mFaQSly3TzDVCh90QLe1Fw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rqaf4wSnai/+ygeGRtEqCj7YKlL3vOp4ukF5mZdcwYYTb9ZS7DirAC2hI7EkrvTalR/Pap0zzyM9gCpYnGlcfbGTPfpsd0UcZfij1WYganhYFrwvzVz3kprqGBVqJXmi0exCDc9VQSnNhwX4NFseBQhNXFFqZk3EeTf6pMcnN2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lmzHr9wN; arc=fail smtp.client-ip=52.101.69.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crSrZhQKx2qqwbNovSzRLUAdmAHQ0cvTTUWS9wOpXVjVhUgVVkPZ8obZDbsTnK/TR9u5YzYw+hIhGXWBEjlfKIFK8KP8IzA+cQYIMs1l0Wzn1kxtFGTWfK5Fw0Cf74WcvWGRvVU4YaW2BUHZyx8N3Lukn2Fp6kVUyIniWcFdsug9s5Fd5S4obBZRcM/9Jo/HQTFYLXK7R6cZQfRQht0Yua9qB6rpAnq58QRmBOlhPTBpEwj2hRGVetjQoNWxcpQPTRkwita+gbF8MgMVEUcJih8IyQTziODRSfXI//mLlsMAaI/+n3M2KVWr8+UKFxZwUa0eyAtALeAI13pq/VPmUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuAzcMH188Bcg752aoT4FOnr8g1CN3btIP2Vs4ZmCxE=;
 b=jWEQ1kDYUdzehtAta6vFzgBIKcvK+TmFEDDG4LeGwSR4mkYOlgRx6m7zy29m3AjxsW3HjM4eJLQnRFvrcaBUpcHs747OY8yAMbmB/IhdQpiz6bZu60Oh0qemE+I72s2KrpAShhbeTfzMI/37EQiZqE+eJoW+gt+t80clRXBGZSNx/TWuM4se6k/fiUNGfRGYMnS0A/QnqzRK5wjrj/RTNOkCml8PmFAnJsIFv41e8AZ6AtC+FW2CLj6F+4kzii8UXVhjyXQ5sBdq7J8cCVE2s/yPtP2Il/71TZlGTtYq601OuVYxs+EDL/RbUVVZcJRh+wmNo9uky96+wGVT9raR3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuAzcMH188Bcg752aoT4FOnr8g1CN3btIP2Vs4ZmCxE=;
 b=lmzHr9wN7t++XUllv6NKQipDfpMtdEw66BLr7UnaaxxWCyhqSXKJphTA7DRPyoYqlSMjsLtw/dKla9vC7D9eey8zvAEow73fR9z+kuo7SsAevFIvoYygiTrfYKp5VMUGEnzl2TQixPUm1TjaRXOlJ9dU8Ltz3fMWZvylSkjwShE2CZCW5+DFyvkxP5G+fBdE3clh+xM2pCTE6rB5jQ/qsAVf/xX6gUj/Q6ngPSa1k10XSN5ScQ8VmYNtQyNV4WyWpz9QbcmFBMNqQKnnxvLtJxq0aujLR5XFMNl/5zLi2vqpviH5Uh7A5D/8melbbqpwQFFnsaPW/AGL+qdYzWel9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by DU4PR04MB10647.eurprd04.prod.outlook.com (2603:10a6:10:589::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 10:02:42 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::c96e:12f1:67b7:ed74]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::c96e:12f1:67b7:ed74%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 10:02:41 +0000
Message-ID: <7e80eaf4-4d78-420c-82c6-0604a5180f71@oss.nxp.com>
Date: Mon, 4 Aug 2025 13:02:38 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/20] clocksource/drivers/vf-pit: Allocate the struct
 timer at init time
Content-Language: en-GB
To: Daniel Lezcano <daniel.lezcano@linaro.org>, tglx@linutronix.de
Cc: S32@nxp.com, linux-kernel@vger.kernel.org
References: <20250730082725.183133-1-daniel.lezcano@linaro.org>
 <20250730082725.183133-8-daniel.lezcano@linaro.org>
 <8d76fd30-57de-40b0-a847-4b84c8d529c5@oss.nxp.com>
 <437fdf05-296e-43b8-9894-1da429dfab1a@linaro.org>
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <437fdf05-296e-43b8-9894-1da429dfab1a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0039.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::12) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|DU4PR04MB10647:EE_
X-MS-Office365-Filtering-Correlation-Id: 58674e01-a4a1-4a54-7c8c-08ddd33e0cdb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|19092799006|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWhwak5EVjlwTDFmU2VHbUJQSTlMSXNUZXRsOEhNZDNUL01vaFVTNkJzbEk0?=
 =?utf-8?B?K1lxL1VvMDFJL01aQmo0WmdXeTEzV3Fuc3pMbk9zckVES0tVUStoRVFlUXFZ?=
 =?utf-8?B?VWRSYzRKL0h6V1hMd2FGMHlkaFhHbFlscnZXTVYwZHAyMzVEWVd3UXN2bE8y?=
 =?utf-8?B?T3NRWm12SE9vbk9wS2o4Yk5sUllhMEtva05ZWmNheDVJTTRmOWtZdGoyMlRP?=
 =?utf-8?B?aC9kMTVWVmV3ekVheEV0Tm80Q0dHMTcvaVYvM2Z6RkRTNWNzWEdBeUhrajNs?=
 =?utf-8?B?SnQ3Z3pPR0w2bUU1M01hbWZjc3BYcjBYM083eHdON0czeW5GaThyT2hMaE5E?=
 =?utf-8?B?VzZ2aG5YRWorWHBMWHJ3am9VQlE1Y3p5cVc3QzlxMUFlTURpRFZOM1FnaUNi?=
 =?utf-8?B?Qmg0bHAvdlNzVnQyTlMrOURFYy9iN21kZ3hYNG44ckFSYnRNMXpuUEdrY2VP?=
 =?utf-8?B?L2FpTi9IdndaL280d1psem5tditmc0JRSXVmODU2cGlhMGF2VFpHMCtGcUpY?=
 =?utf-8?B?ZTEreGJDanpUYXF1WGdxNzMvV2JZRXBmRW11MS9CcEI1aUtqL3liVmtvM1ll?=
 =?utf-8?B?bXNTOTNZNUZWWlkramJBOVc0ZkhhSUNBaGxRdjVLNXdISDU2VlZlS1JJZE9U?=
 =?utf-8?B?RTQ2M25CcDkxY1picm4wMlR3QlhDVjlqbTNOdXloa011bnBpQ1AyN0ppZC9W?=
 =?utf-8?B?YWREamRTWE9ZOUR5RnZpd2RsVmlYbGVXRThrcndKYWtzSHBFVS9nc2VveUQr?=
 =?utf-8?B?RlBqVWZneWR5VVNHdnNLZW1iSWxSU1F5SVJvL2htQllIQmNBaGlSQU81aUQ3?=
 =?utf-8?B?VGpXSEp4NzhFS3NQeUwzZUE5V2dyQTh5YXh0L2VJWTkvOFdNZ2RnYldLbFhu?=
 =?utf-8?B?VlkycG5lejJNSm9Zc1dERzdOTUlQT1c2clNEdEJrdUJ4eW85bGh5T1E1bmkv?=
 =?utf-8?B?amdLYjdFejlTVGF1cUF6bTZWdHBpRVZINGpNS0RKR0NET3dRZmovcWdhbFVE?=
 =?utf-8?B?UUVqVld2T0h3RU9DcGp6ZTY3cTlLK0oyN2ZBRHcyUGVOMlRoelkvbDVtdmNv?=
 =?utf-8?B?ek1hd0VsUFlUb1FJK3BFazNEQk0rVWhVYzBQV3ZqakRsRC9oRW41K2RUQ0ZQ?=
 =?utf-8?B?cFJZdXl2dTBPZGg4S0w4YmN0N2JscmVHK1MrWnp3NUluYUErNEU0OTRrZzd3?=
 =?utf-8?B?RmlYQWc4SGxmakdGSC9wU0locFNacUhGMHNFZDVINnFvcFp0cUgvcUlHODlq?=
 =?utf-8?B?anRqMndKL3JSeXlBaitWM0xjUjM5L0JXVno1VlhDTWZXNGpieTZNblhXVjZy?=
 =?utf-8?B?dE53cVowdDJrd3RwQ08va3RHeHhneENhQ3FlNk9SOXhBN1hmL3ZEOWQ5Vk4r?=
 =?utf-8?B?TTVjNVU5anNsMzVySjhFK0wvMHBzTkoxNzFhWG40N0dnMVExY0ZpalJMdUFB?=
 =?utf-8?B?cTZPZktXdG9vamhCTDU0ZzBmTWU2OHhtOXdBazI4RGc5OXZRZHhPc3FFa0ow?=
 =?utf-8?B?aStoQ3FUWHZSczFkSHR5ZG5waUxnTnpyMWJYV2h3L3dCWDE4VXRRNmlpa0Nx?=
 =?utf-8?B?VlBtU0Zua294OG9iZFlDQ1Vsait0VWhneEpVMmFBUGtCdi93Q21IZkFkWjI5?=
 =?utf-8?B?UW8wNUxPZmRWQmdSd1hqZTAyNzJvZno0UTFwSXRnd3IwS2FkU0RzT2t6SG43?=
 =?utf-8?B?eHFlK21qYnJkZS9WeWVsTkdoVGdEY1owMjB6WXJzb2I2eURmUmJ1NEpDT1hm?=
 =?utf-8?B?SWdwMXR6ZXRUS1NwMUJqY1luRWNmaVV2Kyt5c0J2RnhXSGwvUFJaZVZ0TU9h?=
 =?utf-8?B?SVEwdk5kUjBvUlQxZFM4dXhCd3V4NWFpYVZNS0xEQkpoODlkYjlUbDVBelNh?=
 =?utf-8?B?YkNrRi9Kd2lIU3VrMkoxZWI3MW9mVXUwSmp5d20vMXhzVURBdnBGeDFvOTFy?=
 =?utf-8?Q?QHSuha2o2Eo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEcwNW9kNFZrWWJMQnJnVmtBcEZud2ZJUFFuNlF0Nk9OM3RoL1RkQ1RabHBN?=
 =?utf-8?B?Y094VTJrdWRkZk8yRElNVzR0NXVkaFdLYzc0YzJQbFJBa1FwNlRFbVJqcVh5?=
 =?utf-8?B?bnVycFNXckdVdUpTOXRySzFjUkdJZVhidVZ5OFhnajg2eHlKamJ3SHdsbFdR?=
 =?utf-8?B?L1k5K3lIbmlZWlFhVzRuUTQrelhZa1VRNGJZd0NMaEtaV2hKekYxMHFmcmha?=
 =?utf-8?B?RElhZG91VGxrakV2cnZvekFzY21samFKSDhlZzdFaC9IRks2RUNNNDEvbnBn?=
 =?utf-8?B?NTVHcHp2SXJ5ZEhPUlJjemtwM21scGs0anhsbXMwVWczSkRvMTlYWkNUZ05Y?=
 =?utf-8?B?bThOVE12U2dCbXhYWlR0SWk1KzMyS2k1NjJudzg4RXVYRTQvN09OMUM3cll2?=
 =?utf-8?B?U3ZJdUVCQ0dKbHMvQnhxdHp4cEZhczhwUlY0ajRCay9rYmRCRlJFNGRmSVBu?=
 =?utf-8?B?cDNuTFJSUDlmQUFrRTFhb0FpaXpSaER4WStpZlErUDZ3U21SRVZoeWNjd1U5?=
 =?utf-8?B?cVhvcEpka1JtblhhNzl2MmRJL2pUVFk4dzE3cUhadFBuWDNZdmdWZGthOUlU?=
 =?utf-8?B?R3pJcWNwQ0IrS0hQOTl3VXlzbThGeWpOa253ZTZMNGlMR0N6WnkzN3VFcXZM?=
 =?utf-8?B?NUd2cDM3dFRJaGxLR3BrTWpyM2RrZzZMN04xT0NPellxZmE5Nmt3WWlJZXJ6?=
 =?utf-8?B?bHlLOVNubjA4Rklod0lRdm1BMEFwWURNR2JuTkdHRGg1WG5peDEycTZBbDR2?=
 =?utf-8?B?c2hndE50MHYvUTJxZXN3TnZSL2Z4bk1BVUk5b0VLTXFxY1l6bW9QMFNGakJG?=
 =?utf-8?B?ZGRvR05VdUdBTDE4VDNEMWRnQ05tS2tpUVJCODlLVERUbXpwdWlHckJXM1Zo?=
 =?utf-8?B?YUpadERyYjFMcTY4ZkdlY2ZPSnFUTW5SL0ZsbU1wUFJoTU1xNjZiTTFGbS9z?=
 =?utf-8?B?SGpXdEFsUlJxZVdrYzV2dnJVRnRXT1lVN1VHVUVsU3JObmxXd0x3SmN2Mi9u?=
 =?utf-8?B?L042RVY4Y1Vld242VW5OdUZPdmR2UEM5bGlPRStxdHRmTTJHbmtacDZiVGVZ?=
 =?utf-8?B?cUNnZDNIZWlOTzNCejNpMTlXT2ordzF0SjVsY21QMFlwUmtVVXV2NDNVc2JP?=
 =?utf-8?B?bWVzOVRaRVc1NlI3MW5iakVwQTVxWnl3Y3VvMmx3MEtxTjI5cHVrNldXSDlP?=
 =?utf-8?B?MlNmVkhrVERlUWFTd2lCZjFhbUhVeXBMbzNFNTZWaDNiUGlvbjJVUno5dHQr?=
 =?utf-8?B?SlNEenN3OGVWdzl4YU1sVE5MNS9UQmxsTXc0TitGdXM1VUFZTlFwZU5ZTjdO?=
 =?utf-8?B?YXdmL3dDYlBwTVJCZWJucnRWS1NZbG1rako1UGczaFNPcTc3dmRKZ0d6K3l5?=
 =?utf-8?B?d2c1Y0JINkVRcUpibjVpSElkbnJPQWF6WjRwaFN2cXN6VkpQanpPdjA1Q2x2?=
 =?utf-8?B?blN4VzFSNjhtMGRUQ0EwckcwZTh0MHNCYXlwczg4Ni9XL1BqUDhRTE1wWTVv?=
 =?utf-8?B?WkQweFRzNG4vMk8zdmJpbzQxeGp5ZEJMOWthZm5MSldLU0hDWFY4c2tzdEpZ?=
 =?utf-8?B?UVRVODdubGM4ak4zZ1cxd2o5WDdnV1Ird2UxTW1wQ0UvZ2JSY1RtVnlqdTkx?=
 =?utf-8?B?QnRKWlRKZnN1RWpsUGdpVzZ6TnQ5emNXc0duNUpPK09DUktiUTZGNHFaN2Fw?=
 =?utf-8?B?VWM0S0kweHE2bHpXeXBzYlBXNS9vbWx3U01PM0hmeXRIUnRiQWtyUjZPaVNa?=
 =?utf-8?B?TkdlNmhXL3VnRWxKeW0yTGFKN2tsazhMN0VzallycHRGdCtCOTRzU1RXVlJh?=
 =?utf-8?B?VXhNb3piL1U0cGwrU3VoY25PejRRZ20wRi9IRFZpcXZhd0lCRkxSa2ZWWnpn?=
 =?utf-8?B?LzBBZWwwWlhpN1BWUmgvc08zeSsyYjcvK09ORGFSYXp2M3VpNmhXWHhLTWxW?=
 =?utf-8?B?TEM4TjFVUU5BZFBMNXBVdmRFZ1UwVDNvZ1JjRG1vWGdEbTkrMHhiQjBIeHlK?=
 =?utf-8?B?WFlSVjJzczBiMVpVUUxjWmNVTkJhNWF1anpVcG5zeWprVzlNQldOdjNZMlEy?=
 =?utf-8?B?QUx2N1Qrd3FhekQxS3NLZXJJYlBrVmJubmJncmpxSzl1bUZlYTQzWEk1eGU5?=
 =?utf-8?B?WHdkdit6ZlBmSzk3aGJxb3BCU3VQUkZKSU1SQnVtU05NVE5GeVhkZ2dkWU1Q?=
 =?utf-8?Q?YWDt3jeozV+x6nUS+jWbRAU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58674e01-a4a1-4a54-7c8c-08ddd33e0cdb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 10:02:41.7806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lY7so7IQ3O5ombKmvoNpvasNl7H7EEApR9pXEZeSkliTG9L44BUzMKvseJBLiqhESClGb/Z7NmkfWekmANc8z/KpKUGcPGo6UnElJ5ZBHxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10647

On 8/4/2025 12:12 PM, Daniel Lezcano wrote:
> On 01/08/2025 09:33, Ghennadi Procopciuc wrote:
>> On 7/30/2025 11:27 AM, Daniel Lezcano wrote:
>>
>> [...]
>>
> 
> [ ... ]
> 
>>> +    ret = -EINVAL;
>>>       irq = irq_of_parse_and_map(np, 0);
>>> -    if (irq <= 0)
>>> -        return -EINVAL;
>>> +    if (irq <= 0) {
>>> +        pr_err("Failed to irq_of_parse_and_map\n");
>>> +        goto out_iounmap;
>>> +    }
>>>         pit_clk = of_clk_get(np, 0);
>>> -    if (IS_ERR(pit_clk))
>>> -        return PTR_ERR(pit_clk);
>>> +    if (IS_ERR(pit_clk)) {
>>> +        ret = PTR_ERR(pit_clk);
>>> +        goto out_iounmap;
>>
>> This does not revert the use of irq_of_parse_and_map. In my opinion, it
>> should be explicitly reverted as part of the cleanup phase by calling
>> irq_of_parse_and_map.
> 
> AFAICT, it does not make sense to undo irq_of_parse_and_map() and there
> is no revert function for that.
> 
> However, calling free_irq as commented in patch 20/20 makes sense.
> 
> 

I noticed that irq_of_parse_and_map internally calls both
of_irq_parse_one and irq_create_of_mapping. While the former does not
have a corresponding revert function, the latter can be reversed using
irq_dispose_mapping.

Examples:
    drivers/char/ipmi/ipmi_powernv.c
    drivers/clocksource/timer-microchip-pit64b.c
    drivers/crypto/amcc/crypto4xx_core.c
    drivers/memory/fsl_ifc.c

-- 
Regards,
Ghennadi

