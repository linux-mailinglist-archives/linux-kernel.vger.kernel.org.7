Return-Path: <linux-kernel+bounces-802377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809C7B451B3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435FD583E07
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3DA27814A;
	Fri,  5 Sep 2025 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WS+UbWgE"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010052.outbound.protection.outlook.com [52.101.84.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F97E277C87
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061538; cv=fail; b=l4Cv6maCMi0K1F3rPtkCA1oKYEQMzvx7Jd7H7FZiPReRXiodcU2PhNBfvGGygx3MaIq+20vaIuQwDlZpQ+9oXH6jY9Pt74ngKVW7oy09ONwBx75ryJ2YwP+yWk8aWbKJFWBw/962lLo5kGp20KbLGb7GiDlOBg3kjFNKnP35j+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061538; c=relaxed/simple;
	bh=msakK+h03pBb8JCk3cEnIWyc6a6GZUKNwNCVESeQ56A=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B7Re4z2/Z6UpGCswa5lk+qym3oDd1Lh4oxtvSmpC3hVny8zXEL86fi1Ae7IZRDbX1ZqYmNp0fUng1vBBg5oHyZae0Le2ElTb/2iOG4a4zWoLju6GJcs3pAirNLdFv/LJ5aOYW+GrJfMAcnymzWG1XA1lJ2k/4G8D5F12rln1+5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WS+UbWgE; arc=fail smtp.client-ip=52.101.84.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3H7HooN1YRR1jrasyqpfzrSbsdUZiVpstnB12YmqtJzhPYE3cs4UtKlo67R/NgHD9vjIX+IU95DhzWvpxgsISYMc+jzUTJv9qpWvCCnLztpr/q75uHxX6Ntatcuxj/oxy8H+b98AFH4CVZBohhxcaphP6zgUJkmpc5piwJhEWSgBoSjUFdYdXvUJV7nznsV2WCSgoNvSOP8lcWwdpj0SSHU7W4Sph9qkM5t7B0bvHUGieYmH8jkedRnpAJrlMNqkkf1OFPqw+K6gQjLLdF0ZBCBa/HKwIACgoo0FHOBDLFW0N71K/BnxvJdISSpZe8fpiR/TlSdRn+f9Kc7vq8H/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FLRX3gt+t2ea2JlJN+7btmuOwOOfKBgk4a37DYi26E=;
 b=Zd/sIZIxNTvXTGsziloEN2/shd3RA6vrEs1+MSS7Q+TdsWzfcs5NdszWEFlJCnwxG5RgU0U5fUK9sFqohVfVk2xUnXt0YAySqOwnSh/5ztFnDeZlFpZX5gXDE6CyFItAGxJTBO40prf55Z5R996tjo3adpckcOiK+B+3xYLRp3tr0+DK0FE6Twsu+CbqyFvcVZMlxvwnRQ2JgZik+Z/VrT4+RQHTzZ8Z1u8GEMJ/oyQzQnc76YatESVlMK2jQNPLGLjIc+/DBtW6ACF2n1Lc/l0538B1cbgTGUIlqPpYVWrgslQupvghDnR/Zh+d9shn+OK17uYp7XdgfEfyNA5C7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FLRX3gt+t2ea2JlJN+7btmuOwOOfKBgk4a37DYi26E=;
 b=WS+UbWgEph2ehI0at/K9mgm8JrGcVjiGjDNUk5/x5TILYHsbrcTZlmT35DBl6FPdUm14jCBTMmyD2opRaMRoU8PZvUGVJMUEkd9l3Ec/gjGMCX9h+sFz8lOLnhn6ULqGnObcZCxBXa9dzJBxXD0bVYit7I2amKEzqqTuRp4KWwTP+YlHP1EtoPo4SGTzwxqPsA8qgSHjOrs0TqtGjB0kKOu8mJfo7mXDN1SsiaSjtiwjoSNZvx9fCEtmQTr8bE0Mi1i7ZbnHD5rgAcCzXUrrd0ogIHYBTOPh9uxSVL6tCELMJ9L5oLDo2iP1Q8GnUOkeI/v6wp97cFOuI3bNOQvXlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VI1PR04MB9929.eurprd04.prod.outlook.com (2603:10a6:800:1dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Fri, 5 Sep
 2025 08:38:50 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%5]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 08:38:50 +0000
Message-ID: <342ce13e-0c6d-43b8-a4fa-e9b29c0f8f96@nxp.com>
Date: Fri, 5 Sep 2025 16:40:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge: waveshare-dsi: Fix bailout for
 devm_drm_bridge_alloc()
From: Liu Ying <victor.liu@nxp.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 qijian.guo@nxp.com
References: <20250806084121.510207-1-victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20250806084121.510207-1-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0225.apcprd06.prod.outlook.com
 (2603:1096:4:68::33) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|VI1PR04MB9929:EE_
X-MS-Office365-Filtering-Correlation-Id: 3376f391-c157-47c4-406d-08ddec57a347
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Rk4wRlNFMDNDQnJmcEJiNWxPL3gyWitCc01ubGUrMVBBeVU5VmM0UzlFTVQv?=
 =?utf-8?B?cmRjWHlMb2xyc2gzVnBUMTM5bSswWWs5T2pUTkdobWhPanN1ekFLaElVcm55?=
 =?utf-8?B?eVFUZ3p3Sll2OVM4aW1YUjVqY3JOdlNUSEVjV2J5YjRGY1hWcEFqWWZUVVoy?=
 =?utf-8?B?cXNPV3NnZytJeGxIczRtRmgyU2pVaTUzRzhxdEkzdEYzbXNXWloxMDlyOWNh?=
 =?utf-8?B?emtkeW9ibkFub2lVdld2NnFBU2ZZZnpNN1lyTVV5MkhnVmxlbk1td2g2T0VH?=
 =?utf-8?B?OUVTSnR1L0RPdDJGNVp5NGx3cGx1cktEVjZkbE53czVPVlh4blB1VVFUbUNu?=
 =?utf-8?B?enhmQkNTc1U1NStYR2UxZE5sdnhsYko2MHhEVk5PbXU5V1BFMk9uaEgvTXJC?=
 =?utf-8?B?VDdCNDNyMG1QbGE4MERDTTcrS21CM1A0MHpXbzdyV2VCZlBwaDIyNG1yTGZB?=
 =?utf-8?B?L1l4VnpxNmpvUTBVbTIwbXVLR2xWajQwZjI0Z2FzS2JEV1FuMGRJOXk0MWVJ?=
 =?utf-8?B?SzU5aGUyMC9tT28rYVlOa1dCRUcvdUpRTkZTbmQwUlZ0VnludmtnMlhaMHc2?=
 =?utf-8?B?V0RiUmhlOHppZC9UYUdObnlTVmpSV0g4ZnVMbmxBcCt4Q0pNUWRpN3VOU2Fr?=
 =?utf-8?B?clVhbDI4d0czZFlnZGpyRGk3aDBlR2o2QlpFTGNmcjQxSHV2dFFsSUY1SGRp?=
 =?utf-8?B?KzlKM0JqSU9jV0I3a0hxL3pQUkFPL0RNUnZLR29ld1d1K0dNL3NaclVrK3lK?=
 =?utf-8?B?V1ZFeWpxZC9OelFYM2lKdEppblZ4bWUzb09IcEYydFk3ZHR4ZEVmSkNPamlj?=
 =?utf-8?B?d1lrVXVMUGl4M0RtOEMrVWNuWUFrTkZCME9RY1A4dlV2UjZnVmliQStvZEN6?=
 =?utf-8?B?azFHOEtIUllzVnBybzRRRnAvcWZrSlJjZXdwZ2dqMkI0WDJ1NHd5UDI4TlZT?=
 =?utf-8?B?RFdKUi9vMHJaSWNDZGw4N2NOall2WGxyOG1lNHlHOEg4YzhZdEV6a2dTVVpJ?=
 =?utf-8?B?RlU1KzhQallNb01EQk5ZNDJpa3lEYzg4REFjRmo4WHJSSkVpMFV6N05LTUhz?=
 =?utf-8?B?MExFZ3pQYjI0UmZwWEtuQWdZTlZZcnBJV211OU5tYllDRHdobS94M3poSWk4?=
 =?utf-8?B?OUpqSXNycW1PM3NsT0ZpZEZVUGxZcXMxTDlDbVEvMnVCYVB0M0VFdGZCWThi?=
 =?utf-8?B?NUsyWkRZaTBrUGEzbmdheFFpci9GQ2ZLUlFkUmpMTVhSckxJdFc4aFpDTm91?=
 =?utf-8?B?dml3SmllM2RtNEYzdUVPUGhkajEraStFemNERVc4MGNTRHFRZTlweHRZS3dC?=
 =?utf-8?B?Tzljb3lMUEd5VkJkKzZwa1IrRDhucWgxVlRwQlZmVjRZSWRWV0g0dExGTVZX?=
 =?utf-8?B?STFxOGpSdFI3VWYrOHNxaTlIRllobkNxSG9pRExPNXdZT2dmZVB0ZzRDaVlF?=
 =?utf-8?B?Tm15L24vVmxLbGNXbElWN3NlbXB5WWp4YUMrTEwzajdybFhmZGFraGx4Q2d3?=
 =?utf-8?B?eWlQRU11enFtclVpUzJxcFRFOXRWa0NnQ283aU4wR0NQd0VtSzlna1lXdGlZ?=
 =?utf-8?B?NzRQYUYzcXBsVERXNFRwd2k3QzBMenRDV01hTG9KUG9KekI2VzYvbkNGU1Ji?=
 =?utf-8?B?SFlGUTdSYnprTFNKRUNyVmxKRTh4bllYeDJwbGFORGRsSWNiTVVDWEJFenpG?=
 =?utf-8?B?RlBJdWRUZGEyd25tdHlWclpDZmFKcHBsc1o5UHlOTDVOdllQTWJSWXFYcnB4?=
 =?utf-8?B?a3BGNkhkSWpkLzJUcHVsZ1oyNzdKaGtzNVlVcVlKZ1dlTjllTXhURDQvVE1E?=
 =?utf-8?B?a1RISlE2SjdYbzdsY3NJWHg0L09MNlA2UHZhdTJ2TjlBYXpGdTFnRnRySzFK?=
 =?utf-8?B?TG5vTXRhRUtMZUhNdUtOeGdVR3oyT3NUUlhKMmlDbWR1Z3FOQ0F5VXJZR2Ns?=
 =?utf-8?Q?SbwZ0AMPNUI=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WTRRV0hDL2ExL3hEMXptRGszQXM2N1IvNDhJUUdrQm55aXh4aFVJRUY5R0Z1?=
 =?utf-8?B?K3EvYytKV0lPYjZDV0lSRXFMYm5ZVzJBMHhVUG5jcHgrMlRyZUNHa0NtR0FR?=
 =?utf-8?B?U0VxaXhIdHJqL2V5RFMxT1ZwYkZrUkFNQXlVM091R3BHOUxCb090elM2K2hm?=
 =?utf-8?B?KzJzNXplMUNlV1Y2T0xrUHN6Y3FCUWgzZWtMUTFVM21LWTNEUEc4dHFnWUtw?=
 =?utf-8?B?NmFqY2g2aXZuVFYxejVNTnRMb1ZwR1BMSmVsblU0S1ZyanVwdjAxZEExRmZv?=
 =?utf-8?B?ODJkTlRtcDA1SjN5R1ZJbjhMNE9ENFhQVEtoRVYvRzJmK20zV0QrMmJ5a3pD?=
 =?utf-8?B?cTl5bVhEWWNTM3FwSm9BTkxpM0luS1JBZmlSQSs5SGNlQXZMSzU3S1ZYL0ox?=
 =?utf-8?B?YVJ3VnZVY0xLaGRreGJacGc1Vk9KN3ppMmErcWVBRENESVBvT2d1b3RRa1pY?=
 =?utf-8?B?a2NIUXZja000UUhuR3FOYmIzK1B2eDlHSi9jRWJlb2dUcG9yOGs0Rzd3R3RZ?=
 =?utf-8?B?NjR6RVJ2bTcrU2xNZ0dCV0lzcDVSckhhZWZhY0o2dE80SG45TVM3ODVpQkVw?=
 =?utf-8?B?Ujd0WTRwMUVDemYycTVTUldIOGF6NEpGdGwyRXZ1VnBBSjYrMnJ5RE5nN3ZK?=
 =?utf-8?B?Z1N6cHdCbG91VHNiSFNUczdKWktsYU5LM21KRWJEeDNYQzNwMExES1ZwMDR6?=
 =?utf-8?B?Z0I0cmIzZmZWVmpTK0FzWk9rZy9CU0NocHlkS0hhSCtGVEFvSHoxNmU3VEI2?=
 =?utf-8?B?ODU1WTJ3eEgrQkVuUVpiR21DSERmWDdKT1hKNCtNNUtRRk9GWXl0WVBGZnZO?=
 =?utf-8?B?Z00va28yRkVsaUZ0Y3lNc2UxdGd5bzk3dU5aSlRZZU8yZ3B6Y3lHR1lrRDRh?=
 =?utf-8?B?L3l0YS8wRS9lc0lMbzIrNENWNmNDODJERUFia0hvSENtN3RjV1V5QnlJU1B5?=
 =?utf-8?B?K2ZMd0liVElRT01nRzAzbUo0KzBhYzFlOTZhV0J3K0locUNiNXEwNHdWeVVV?=
 =?utf-8?B?YjRFZGNKVFJXQWpkUEpOS1BpUjh5UWxPYmxDMVZCZ3VtQitvNFhyRWxSTWxH?=
 =?utf-8?B?aWlIRlpVQ1RJbVBKbEJLVk9rUGNwY2pIZWdRbWx3a3dMaHVnanZwVzdLZkV2?=
 =?utf-8?B?NERtbFdjSnY0R05Zenl1TGsvTUlCMDBUR2Z0OTBIV3RNQnNDazV2elJuanlP?=
 =?utf-8?B?aWhZREZOU0w3cW1JbVMxdm5QM3NORlcydlBjdTdIVGJHalVkZFFhVlM5V2pI?=
 =?utf-8?B?a1g1VXlTRTVxakwzRmZvSFhhQ1JCdEJjb1ZrNTJqMzRHeDA4VzB5eTlhcnYz?=
 =?utf-8?B?VlNVcEV6WTlkY0FHcnVKTUlidEZFMHczdWIzalhtMjhaa1lMcUwvaTBRWFVR?=
 =?utf-8?B?YTg5VVAvOVdMN2dFbnlCQlZOSEJRMk9VS3cxTFFoazUzNE5SWm5ITWhDd3p3?=
 =?utf-8?B?ak5XZHBZWjdsWm1uSzkyYllxV05kdlM4MkNDUVVXOWVNNmpZR1hTQzF5S3U5?=
 =?utf-8?B?TktiQk42MWM3dzVZSlh1U3dDMDRGbnY0WENKNGtubGo2TXovQmtRcENvcytT?=
 =?utf-8?B?MWM1WkNLUkFMOWM5N3RHL3A5TWRydGVINWo1c0NTSnZuc2Yrd0Rvc0NvRGxX?=
 =?utf-8?B?TGFBRW9UblNnQS81a3k1dTVrL0xGa3FsRDQ1bXJXYVJsRzNGdkp0dndWbExj?=
 =?utf-8?B?cDhXSGJadmV3TG5GU0EvTnRxbG9KY2RXa2I0YU1aMFJPZHRVSDZSYnAzT3Nx?=
 =?utf-8?B?Z1dWRjUraUtlbzBnV0pnVzJzNnNML3BxdDlXMkt5NWlzUG90ODRNM0pBQVhR?=
 =?utf-8?B?bFlwTXA3eENGVnVFVGg1RWxHVDU5aTI3dE1GUmJvR3RMMUpHL3FpRzNvSVpB?=
 =?utf-8?B?ektQR2lKZlBqSG5oQ3lkSHVMMkhCcHlaSmpPMDRQRzF2V25pWWpDRmx5WTFW?=
 =?utf-8?B?SVplYkgxWStIZWJpWFVSdmhDcHNKYVVIQXp1bUpnaDNadkIvMTluUlp4Q2pM?=
 =?utf-8?B?ZG1NRUtzOFJNb282WThlaVF2UHlVRUFRWDVOcGo3TzI4UHNYN3lDdzg1MVBP?=
 =?utf-8?B?NFhMTDFTOHlmREg3bUFIZEpaWkpsQTlFU0RvTGNoWFNoZW9jQm43aTNaamFU?=
 =?utf-8?Q?VeqYFCYr+rKUbX90MD5AWWGAm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3376f391-c157-47c4-406d-08ddec57a347
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 08:38:50.4071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gwe4UPWeSTaO0cGfjjmpPmUGv1H8vhkJVrb1c4BUH8dWyyy5QoGoLgffc1nkPtxWOzoJFJB6/ShIa7jerXU3sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9929

On 8/6/25 16:41, Liu Ying wrote:
> devm_drm_bridge_alloc() returns ERR_PTR on failure instead of a
> NULL pointer, so use IS_ERR() to check the returned pointer and
> turn proper error code on failure by using PTR_ERR().
> 
> Fixes: dbdea37add13 ("drm: bridge: Add waveshare DSI2DPI unit driver")
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  drivers/gpu/drm/bridge/waveshare-dsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Gentle ping for review.

> 
> diff --git a/drivers/gpu/drm/bridge/waveshare-dsi.c b/drivers/gpu/drm/bridge/waveshare-dsi.c
> index 01c70e7d3d3b..43f4e7412d72 100644
> --- a/drivers/gpu/drm/bridge/waveshare-dsi.c
> +++ b/drivers/gpu/drm/bridge/waveshare-dsi.c
> @@ -147,8 +147,8 @@ static int ws_bridge_probe(struct i2c_client *i2c)
>  	int ret;
>  
>  	ws = devm_drm_bridge_alloc(dev, struct ws_bridge, bridge, &ws_bridge_bridge_funcs);
> -	if (!ws)
> -		return -ENOMEM;
> +	if (IS_ERR(ws))
> +		return PTR_ERR(ws);
>  
>  	ws->dev = dev;
>  

-- 
Regards,
Liu Ying

