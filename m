Return-Path: <linux-kernel+bounces-697419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B07FBAE33DE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 05:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D7A16E296
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 03:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3BA1A3160;
	Mon, 23 Jun 2025 03:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vz7ny5VQ"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013024.outbound.protection.outlook.com [40.107.162.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C738F1DDD1
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 03:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750647911; cv=fail; b=mqCYpH0xQAWtEr6IUDV70qA5sAH6RFsgB8zH528lYSMr6A4FgICejcowPpGY2JuiTAKEmfS5hJNZTAYYWmIZBazxQlw48Dsfje6pxTvVwY/qNf/9kgqSBT3u9Fp77YcbaHTqe1wQD1SMj1bfjzYEruj/XA8HE6nYvd+eLrQoHwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750647911; c=relaxed/simple;
	bh=o6UQ0yC1YgwzpIRr+ly4rF0s+d5cg85bYPBh4YQZxaA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SooXyGFPOM91fhojao+mPQGBUGEpYkKFlYf6DLgmh6EYr/1wiEf6HQV8SrAJ5IH5sRbLXyBm+ZIAeSQwyXDWGI3qU7/dIwp+CBat67cxjeYu3NPJbTjL4njb8zDz/lSVPRUjTF+JZv0JqvSWuhsJv0vhmwCSz5lErP3hZlwu3oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vz7ny5VQ; arc=fail smtp.client-ip=40.107.162.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEYqZATZUFt7Dgceb+73x8kqw3bpvEkfkl4KwZOIC0jbWJJZ2D06W85pi1BZx3TdlLoP5N0QfeSSJmWgiK76DnOfwxyjQuVzcMf2REVllTYPLezxDh5yelF/Qd26hsCCsE5adP5gk9S5PbppA2+xFmyMuDy8IinmjFu++l/QSmuqc2x8YFu2LzZQIBYFzW4Bb7bqLZaQDVT1NHEoEkGFuhh9b/A75XKRxBB9ucilcWVODvLpAmxiHg1W+fj91s7qcAHbblOrbllCKnDXtvIaB9LRw0qAAIu8ulRFOHCMednTJ/wa0lf1BWkQKBJoN9mcKCDYQQOmoAcbbwUqN2oexA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVh+bSJIsLThqu+qI3c7wVpGiY1j+ZbugVrPq+6/GRE=;
 b=Abp/vHxA/af405szut3bSZGF1USP7zCrcKXhRfKPeI5T0N0rDYLakHu9Sw7cf/nWiWZE2sV5x1/VaG/9zI0vuqNnznEMcT5cJJ8GWviE2tHzgZhbA44/0qj4+JW9xNd3MYSyqhVLpICUGQID0JlsnG4ORyFw3ZRZGUuQaP6aFd2iU9z2kPAVlwiuRbjEkFWuqbPlvMMLoV9QrJAWYsuOMoydMs6hmx9G0PVvFl49RalSPvw7C0fhAMmMqwnemV59StLzicwkO4wVdZjt3xTNCDFrdL3uc+GeM8QbRUC27U5gzGH5dpWTM8U6NsyTI+lXtsMmvpQRuBUOlurWH5ziiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVh+bSJIsLThqu+qI3c7wVpGiY1j+ZbugVrPq+6/GRE=;
 b=Vz7ny5VQVc3+xRl4j2xY4en/zJsoYOZfcbNpeKYL22DupaNH15a8NZGusySVkCXuRZ2GhjWN4oGPq0B6904DhfSZvE56Cc/2DZNL1GBJ1nPaljwZ7stvPz8fmsx2P7yToI16StRj0rTDoBIGh1E3EledauRA5/Xo6HHYTL/aYCCqJ5RjVNTT8VI1B2FyhmjBWXVAa1HFf7sXZO7YsqLqeJFbi3MXf+OZ3q7nQt3cFFvufyi7dC46m/2U12CL8PFi+m31OUukR6o0Px2gJr1fDMQidhF5CL5GPCOtN5bK6ficnCfVXGpPepLqNXlY9el/Z3WlUSGLiJdZEja+yv5zOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 03:05:07 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%5]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 03:05:07 +0000
Message-ID: <6ed34611-d2fe-4c9c-8b00-0939ac407e07@nxp.com>
Date: Mon, 23 Jun 2025 11:06:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/5] drm/mxsfb: put the bridge returned by
 drm_bridge_chain_get_first_bridge()
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20250620-drm-bridge-alloc-getput-drm_bridge_chain_get_first_bridge-v8-0-0321845fcafb@bootlin.com>
 <20250620-drm-bridge-alloc-getput-drm_bridge_chain_get_first_bridge-v8-3-0321845fcafb@bootlin.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20250620-drm-bridge-alloc-getput-drm_bridge_chain_get_first_bridge-v8-3-0321845fcafb@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:3:17::25) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AM0PR04MB7044:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc9418f-8489-4585-d659-08ddb202c1e4
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SWRYYWpsek9wQTl4Y2NucExSN1JaYVA1ejFVT0xxN1MvNFZVRERjekVBMlla?=
 =?utf-8?B?djE4SE9IUktYNkN0Wkd4TlJNcWxDcndSdVRic1JETHdNRmRCcUs4RmtoTGVW?=
 =?utf-8?B?aGlxcExVeWJxVkxyRENYRlFsMndmOVhzZXJMNFp2S3FTVjZkV0tGNjZqbi9K?=
 =?utf-8?B?SjFnbEQwb1VDVzVJZ09tTGxEdXh6eENKN3R3QVN5MUxiWThNclVtVHI0cTA5?=
 =?utf-8?B?bVBZdDBaSUV2anQvdXdrSjRCVzlTSEZEalloZFpBd2NtbVc1cHdRS1NGMDhv?=
 =?utf-8?B?SjBTT3NNOG9WeFF4Y05oTlFIak10c094SjIwZDkzZk95dDlSUkJ6dVVaZTV4?=
 =?utf-8?B?cDZ3RC9PN1NnU0xGNWZpd2hjcENlLzU4WWVTd09naFNUdUZlMzY4UGVWcnd2?=
 =?utf-8?B?U0pkTG9tZmVJLytMVUxwZldkRjlDeU1yWnRsRjRtdllvWGtiTzBnbmhnSE9S?=
 =?utf-8?B?Qks5VEZMeXBRcTlTWFk3MHFUck45Z0ZtZlVGZUVZRnAybGNpSC9VM0FhRTNu?=
 =?utf-8?B?ZUhHU013VmZzeFVBVnVoUHVPTU1aamJXNlpMdGZNQW83bEJpYkw2aC9RTE02?=
 =?utf-8?B?eXQ4djV3NEdRalA0dXRlYW1ieUxMckpQWTlOWmV2VUhVNTVPRHRyUjZHV2xq?=
 =?utf-8?B?U0lRRWVJNjRXWEl0cXF4OFhDK2FmMXovYWFmMjJRbHBVQTRKNllhUWM3VVJX?=
 =?utf-8?B?c09odno0amtyN2t1dDYxUUY0NFEzS3lkK1NWV2NveVA2OVVZL3JJbTZXNTc2?=
 =?utf-8?B?eDFLUHpyTFlEWTArZS9NK01yZWsvQ2E0YkRTbndtZzhDaUFDUlMxd1YxZU1z?=
 =?utf-8?B?RURuZVd0ZGR6WHd2KytWRmJmVTBmSkQ5RWdOeU9RTHJzMlFPUTIvQmNQL2JD?=
 =?utf-8?B?Qlo3aTVnd2pUeVNrNGxaTGdYR0NZRXJaci9ub0JvWkZQbWlweGZyRDV6QXBw?=
 =?utf-8?B?ZU5maUhjZHVNUnpjMld0OVVBUDVPbHdIQ2xSdVZGSFhKMHpSM0ZqeUZySFlR?=
 =?utf-8?B?ZUwzY0FQVHhWUWszQlU5SGU0UldleGMxeEN5K1E2Ly9VZjNGZDBadkpSTlJj?=
 =?utf-8?B?S1F5RVV5S281SVhRc29FOERtZjBIRk1ENUQ3SG5mYWEvczZtNTExd1owK3ds?=
 =?utf-8?B?cm9HTlJ0cVMwQnZZT1M2Q2I4blBwdGJDYlM0dFI2M0lscWtmQ1RVQk5UZmtq?=
 =?utf-8?B?WFl1ZGtyV0ZSRzE1MWZZblB4eERUSVllTWlmRXVoRERpby9ONTNqaW4zTFF3?=
 =?utf-8?B?MUE5VmowRU5YVklyL3BnMjBrbzh4dHdITW5kb2s2Q2RDTWNyWStuU1ZUdndX?=
 =?utf-8?B?N1pGNVRrV0tTaUFhQUoraXpETzU4cXpCT2FHK3c2cWR4U0Z2Z0Q2bXBhbFFu?=
 =?utf-8?B?UjdOVDR2aDJvM0lVZjl2OUpYdG8yZ21MTDdmMUFpUlhJNnFDdUdURXZLZFdL?=
 =?utf-8?B?ZG1ycU5lU3BVdlJHNTc1N1pyUVBFN21pdGdFaUhDTTd6VzZCOHljRG5NbEI4?=
 =?utf-8?B?RHdtSWZqN3FhbzBnam9OWnpSVm5GVnJJaWRyMXVsZER0UVpJRXA3alVmN2R6?=
 =?utf-8?B?Y3F4cGdSaWVKY1NQQk9nMWtMMTN0Z0VkTUpod0FEand1RXNkVlNJR1dzQ3Yx?=
 =?utf-8?B?WTJ0SHlmbTNPWU1wY0VUb3NrbXhmZ3l4VzVkZFdCcTdDSFdEZ2treGJhQlRP?=
 =?utf-8?B?UVdRT2E1V1A0TW9ZQktaUHU2VmkwUERZcnBlYlVPaExzQXgzelpjZmlkTWJm?=
 =?utf-8?B?VSthT1EwMHNTZTF0MGxZQnoxVkwydlNGbFkzVnVmK3Q2cGd0S204TFFCVzhj?=
 =?utf-8?B?bGtoWWdVR3NUTUZmMHJVazRGTFg5UHQvVGgybjBTYkFNZlNyVzFVeUM1WDlD?=
 =?utf-8?B?WXJmUEhCaWF4QkxsRGl6NkpvcVlZZUhROVFIV2VaUC9xWm55cXlRQkZkWHVa?=
 =?utf-8?B?SXpoWjJUYUg5NWdPZ3g1RmgzSE5yNS9sQmQ1Q3UvSWlYcjNoaHFqNmJxdFVK?=
 =?utf-8?B?eGV5ZUtlRm5RPT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dEc3WlZhTWVTSzJCWEQ3K0kzVXQ0cEdDb2VieEpaRmozaVNRTEtQeldwQWdj?=
 =?utf-8?B?M2Z5dkRod2U3R2hKeHpSOHR6aGl4Z0t0WjJCV3ZCKzd1M0htYm80akRDNm11?=
 =?utf-8?B?bXNyY1Z6eitZSkFSS2wvNW52SElLOUswZVI3aitMQjFaNVdwTlRKUXgvZUhr?=
 =?utf-8?B?ZXdKRWRKRjMvWTRKYlpvWm9oSldyR3ZuM0JBTEFNbUdkUDdrV01rZkhHOXFH?=
 =?utf-8?B?WWZocVFKdk4zUFROTWJ1YVdUQUw3OU5RTjFzMzFnV3pibjdGRjNmbzl4Zzk3?=
 =?utf-8?B?dFBsR1FhNTB5eTVxOFNjSzNUb2x2Wnp5b28zTWJQdnRKdzAyNGZhTUxzSHZY?=
 =?utf-8?B?TUsrL0VFbHBaMjcvRHU5NndtQnFGOVEyUlYxM0dEbGZRQ0JpZW1FVE0xc05N?=
 =?utf-8?B?ZHViK3JCTGpSelpIeGFCeWRTUVFOV0svemlFb1FibzNLOHNUdGo5UWI0dFk0?=
 =?utf-8?B?WEYrblV0aTVVZjJ3WjJMNFlZcXk3aWJEc2hRNFNQMktiaVNRRmo4a25HLzJS?=
 =?utf-8?B?UFpQUnRjeTFBQ3JZNE01ZEdKRHYvVU1mQTJ5L09jM1p6dDNtYkZBWkZMNG91?=
 =?utf-8?B?SHVrelhEQm9VTFhMUlowZkFoVzVGQkljSmVlenkwUWdpeVRFWklXWmw0WVZF?=
 =?utf-8?B?V1hLSG42dkFRZWR2U29rTVc4WmdoTnNtNEVmSVk0czIrRlZVL2tOTVErek0r?=
 =?utf-8?B?cFlXb2hOSkZQZ0pZTWp5NXM3Rmx5Z3lQTEFjbmZiRXNPeWhCanYrVWRBdHhR?=
 =?utf-8?B?aXNPdFNOU2wrQ1B3YnV3eGphMW4vKzlRNzR3RWtlREd4N285S1lQcXUzRzlp?=
 =?utf-8?B?S1dGZGxZYlM1eHlTdEVuQlJiNitUZFJmSXVzS1lHOUpVRWlxdElaR0dWd1V2?=
 =?utf-8?B?cnEvWkpQQW1tYWlpRHVRZTBTMG1BaGF2VURiazFnbFZBN3Z5clpTRy9Iajdi?=
 =?utf-8?B?anN2NEZ5YkJmYW1hK2JPd3RRZjU4ckkwMjZOVE03YTZ6UmNjcjl5bTloUEpi?=
 =?utf-8?B?SGdEc2cxV01EVHZuZXBxc3Z6cDhpbGt2TUp3NWM3VStZTFY4aWtCbkQydjlU?=
 =?utf-8?B?WGU4VFlZejZDMktkTW5acnVWK3doR1ptTTluM21FWmpjSzJmODJMNkE4Yi91?=
 =?utf-8?B?cUxYQU4wc2VPNXBCMXlPOXFhMHROdjk3YXUybTlOL2E4ZUI4Mmw4QkE5cjZZ?=
 =?utf-8?B?dkZmWHlwRUhRRzRjaDlvSDkvYUVQWWprZEFXc2VjeFNvY1N4R3k4QXpKUHZK?=
 =?utf-8?B?YXVzSDJGRTd2NUJiWGNETjY0cWNpUHdoRm9Na2NQbU5oMnlsY0JFTGh0cXQ2?=
 =?utf-8?B?MkhXYWY2K0lUa1kzeHB4VXZscHJVbHdTSmN3bG5VV2pINkRleks4MVJVSW1U?=
 =?utf-8?B?SkR1TU9rRk1tV1JGa0ZzZWhPQm9yMkZtMW85TGY5Yk5IcXpjYTAxbnNJWFdo?=
 =?utf-8?B?MytROHYwTDdOQXFTZlI2NktGOFcwY2tCWFFQbzZKekF3NUh1TmVDOU1Jalli?=
 =?utf-8?B?Tng0bS9nY2lqS0xieGk4dENZRTNTcFlyMldaTG1wdHY1WHZaZ3ErZlNTa2Fn?=
 =?utf-8?B?a1pVajBrTHI4TzU4RHN5bk5Jc21PTGMyM1BURVYvNURzYUNXQ0FUNzFyVkdh?=
 =?utf-8?B?ZVpvS3k4cG9menFjb2F4VEloWjVmNTNYNzlvNjM5ZE12OUVib0twclJtWU5W?=
 =?utf-8?B?OHBDb2V0RTc5U2R0OU0rVTJ3NlJEZFVybGFrbUx3Q3BnVnRva1g2ZFpyaXlz?=
 =?utf-8?B?WlZGejVLSEFZWm9KY2U3UzZoeUFMd3lLL3VmTFRaQkZUNml3R2tKYnF6Mk1o?=
 =?utf-8?B?YjVaRTNMb3R1YitVaUdGWG9IQ21XT0VKMWVFcExtZm1pK2NKSnhWZUFFbmJa?=
 =?utf-8?B?ZEI0eEc0cGdQZjU2R1o2ZzBWNFQ3NXB3Vm92MzRRQzhxMUhLdnE3Z3loTFdF?=
 =?utf-8?B?MFQ4QUJOdEFBcXlYYWtFZkYwMUR1RmVIbjBJSEx0UnhHbjBhYkVzZzBrdGh5?=
 =?utf-8?B?MGVZYWxiN21aRVRBNHFVYlZSSVIvKythd25BeEdVRy8wRTE5REdEM2s2bHFI?=
 =?utf-8?B?bnYwdEhpMWFWaHpieDA1QTRHbWQyc0VoL1pqNzRxT1dCYU5iUDVFOGRBaU5M?=
 =?utf-8?Q?H7pIqdfYx3vE8LCACW7aI0OhQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc9418f-8489-4585-d659-08ddb202c1e4
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 03:05:07.1568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1E5RVOCI5DXNr9/u1dqpIi8hoXf4EF0eIhLX8EEpCGaZVWdBB06dXh73v/8I8a48UvYMVXlwjHzYseA+cfJQ3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7044

On 06/21/2025, Luca Ceresoli wrote:
> The bridge returned by drm_bridge_chain_get_first_bridge() is
> refcounted. Put it when done. Use a scope-based free action to catch all
> the code paths.
> 
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
> 
> This patch was added in v7.
> ---
>  drivers/gpu/drm/mxsfb/lcdif_kms.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/lcdif_kms.c b/drivers/gpu/drm/mxsfb/lcdif_kms.c
> index dbd42cc1da87f82ef9cd4ccc70cdecbe56035174..21311cf5efee7d26c80316bffe80dd2bfed02238 100644
> --- a/drivers/gpu/drm/mxsfb/lcdif_kms.c
> +++ b/drivers/gpu/drm/mxsfb/lcdif_kms.c
> @@ -433,7 +433,6 @@ static int lcdif_crtc_atomic_check(struct drm_crtc *crtc,
>  	struct drm_connector *connector;
>  	struct drm_encoder *encoder;
>  	struct drm_bridge_state *bridge_state;
> -	struct drm_bridge *bridge;
>  	u32 bus_format, bus_flags;
>  	bool format_set = false, flags_set = false;
>  	int ret, i;
> @@ -448,6 +447,8 @@ static int lcdif_crtc_atomic_check(struct drm_crtc *crtc,
>  
>  	/* Try to find consistent bus format and flags across first bridges. */
>  	for_each_new_connector_in_state(state, connector, connector_state, i) {
> +		struct drm_bridge *bridge __free(drm_bridge_put) = NULL;
> +
>  		if (!connector_state->crtc)
>  			continue;

To avoid the unnecessary cleanup for !connector_state->crtc, I would write:

-8<-
--- a/drivers/gpu/drm/mxsfb/lcdif_kms.c
+++ b/drivers/gpu/drm/mxsfb/lcdif_kms.c
@@ -433,7 +433,6 @@ static int lcdif_crtc_atomic_check(struct drm_crtc *crtc,
        struct drm_connector *connector;
        struct drm_encoder *encoder;
        struct drm_bridge_state *bridge_state;
-       struct drm_bridge *bridge;
        u32 bus_format, bus_flags;
        bool format_set = false, flags_set = false;
        int ret, i;
@@ -453,7 +452,8 @@ static int lcdif_crtc_atomic_check(struct drm_crtc *crtc,
 
                encoder = connector_state->best_encoder;
 
-               bridge = drm_bridge_chain_get_first_bridge(encoder);
+               struct drm_bridge *bridge __free(drm_bridge_put) =
+                               drm_bridge_chain_get_first_bridge(encoder);
                if (!bridge)
                        continue;
-8<-

>  
> 

-- 
Regards,
Liu Ying

