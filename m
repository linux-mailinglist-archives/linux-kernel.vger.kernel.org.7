Return-Path: <linux-kernel+bounces-851355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C264BD6400
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEE664F368A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE1D2C11F0;
	Mon, 13 Oct 2025 20:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mTcJoR4Y"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ED134BA34
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760388465; cv=fail; b=BLKPwRCN+H2sW5s4nTSSeaCHsNrCZYme0YxG4Rw8te7HvtkEkGUBYeDVzAau7xQ2JmM1SXtv2G3Z2/Qd06I7gmzAPzPwOn08G96/QLivd8PPtuJeGFnwz/sODlFk2fm0o2SnIdUk6gw7zHuy3qWEYRZZaU1B+UcC7Jhm27r+46Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760388465; c=relaxed/simple;
	bh=6K7YyIQ4DQPNd94V9hw6YVb9D7LJVE4zj6O9FP5WGNY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S+Ep+89Fk//5IFfXzhDTo+XQbeV6ddydtMmo/kl41gB/1z+wYosz0TliiFXm9JAFVWn0N4GvKqpHtT6yAflNlbTFjI4ZQaACpevy2PyeNkT77KltuWcAE3d3ygRV4JANjcL4vJV5HCmrhUifrwc2pFuuXtOPuWr3fKWIjzwX/Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mTcJoR4Y; arc=fail smtp.client-ip=52.101.43.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/2/MWVFDPvCCJvD2RnYip35lRwx5OqXS0N8tZ3PED6UdwvEiZYb+AJx3gpMrGfdLGM9eB6AyLuUiBWU/JsNzMjdZfvGwxiUgdGXNnzMAicDnY6mCjyAKpT32heGVRx0ZW2tcyjXe9M0CkjOhLzuBWi1nWgC3H8gzGe5JbS2UOwawaeZdbopbBX/KfC8IMpbaUUD2AOYiqMtCTviKjX+S5TtBg4I603SMWInG27KLbL5xpKleoAlWqCQ0UITdV0Zy5dbDwhiuf0XBMnR83cVZFxXAWhdH0y/AiYdE29vkEIuKirVMP+2U3i+i+7U+cEZzvawzvKOPcKyN0ReusUdZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yh2l8jbaxVxtfSz3/o8QlFDcTegjoaSGr5YMYKDgVho=;
 b=QLNACR9CixkjpGy42qTwWPNVe7yjR5G/XTGi2qUVqANpAaGVTvGaqCfgU4J+myyUz2HjlRo5WzuFXsHLmm6rzrIwCsjwTXv7erDXruZsXYLW6fw3FxrZdUNCvB5whkdX08BYdOXiQB9cs2psfeR2BRJkmd3oJdGEdsA5OCn08xPDbAfQfJIukSvU32HROBDKzCQj9prpQ375JMMVpJEti4f5U1UViCPTld/RHepnERWb1Ih9DvX0t79g7Bl3TFAJhMtCLC8V0e+0ie8tS3UMioWtSuTVH8gO0eGASkvRYHQjk3P/6jMa991qBZ57M51PtEgwWN4IJ5P3ryTJn6XshA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yh2l8jbaxVxtfSz3/o8QlFDcTegjoaSGr5YMYKDgVho=;
 b=mTcJoR4YkK/kmn67nMLFBLZQNEPLZxDalkmAxHSJa6n2aWGXAapwE4ve+R+qvZr5jNhXdUdXb3zWThyJeeT7HZO31bEf/CSUpEEFqhqsTH2ljHkHA1SEKzcj2a12FrGxiR8o/kktLkEMHKDM9a0AJINjpX4k+qCcNAHgiw/e1DT98oGt8Vzt6lkyzw54Wt5t0YxD9sOy8sVo+2GTEGyesdcI44nWyCNVlYlQ+MkXbBDZVtNmiC6jZlYP8Se2bzBA/CcfapFeQeRoUfChjXSXLY9OwjeEVE9tCgOjzxLTjuNHAc9Aodh8PpOczdwuX7asWgtkxRARs6uM41lBLTKcvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7704.namprd12.prod.outlook.com (2603:10b6:8:138::22)
 by DM4PR12MB6398.namprd12.prod.outlook.com (2603:10b6:8:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 20:47:36 +0000
Received: from DS0PR12MB7704.namprd12.prod.outlook.com
 ([fe80::e85e:e922:a750:e68b]) by DS0PR12MB7704.namprd12.prod.outlook.com
 ([fe80::e85e:e922:a750:e68b%3]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 20:47:36 +0000
Message-ID: <b0a1c2ab-c040-41cb-9dad-49442a03993b@nvidia.com>
Date: Mon, 13 Oct 2025 13:47:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] firmware: smccc: LFA: refactor, add device node
 support
Content-Language: en-US
To: Salman Nabi <salman.nabi@arm.com>, lpieralisi@kernel.org,
 mark.rutland@arm.com, sudeep.holla@arm.com, andre.przywara@arm.com
Cc: ardb@kernel.org, chao.gao@intel.com,
 linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, sdonthineni@nvidia.com, vsethi@nvidia.com,
 vwadekar@nvidia.com
References: <20251008190907.181412-1-vvidwans@nvidia.com>
 <20251008190907.181412-3-vvidwans@nvidia.com>
 <12598032-3f12-42db-8fc9-6ef879d9a3ba@arm.com>
From: Vedashree Vidwans <vvidwans@nvidia.com>
In-Reply-To: <12598032-3f12-42db-8fc9-6ef879d9a3ba@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0182.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::7) To DS0PR12MB7704.namprd12.prod.outlook.com
 (2603:10b6:8:138::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7704:EE_|DM4PR12MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ed1f0ad-4425-4b60-2969-08de0a99bdbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KytHdXRSdzhBWjVscmYrOUxLOUxlNXZzWnJRRmxLcmhxSkg0NXkxZ2dZQ2dX?=
 =?utf-8?B?RHU4OWVXNVF1Q2lJOS9sR1BnVDZ1d1Qvc1BqTVZLU1B0N1FMS1RSRnZOOERk?=
 =?utf-8?B?Z2VyK2loc09WRkxhR2JZcXF4WTRWaWhrRVhCUHI1aFYzdy9vdkMwakVMTFky?=
 =?utf-8?B?TGhrQ0wzN1BON3MwZyt1SEhaR3VrQWREQXFMTkxKOExwbXh3d0JDTUE0eW5J?=
 =?utf-8?B?aEFDOFkwMzV1NDlyYmJFcE5MZ1JSbjI4ZDlEODh2emlITmdBMUFvUjU0TWw3?=
 =?utf-8?B?M0JnOGFORVR3MnpISjFnbDZoTmVOWGUwcEdVS3RxU05KSmdaaklZK3NicHFG?=
 =?utf-8?B?SzRmMzVJV2lGVG5ENEc4Qm9wRExJdGJRS01MVFVKb21nYWNPU2svcFRQVUJu?=
 =?utf-8?B?S2hsQmRiU2lDTllBUGF4Y08vZkY4UmlkZjAvUElDMk9Vb2YyOHR6SWVLTFl2?=
 =?utf-8?B?QXNwMnE5c1dBbW9tSnBzK2RYc1VMWmtYNktiSUx6OEdESVpiUWNSYmpyK2dq?=
 =?utf-8?B?b3VEQ2JLcHVIVlA2SUdxNFIwU3pXcEU4OW9iQ3l3b3ZHbFdKNnJvcUdicWla?=
 =?utf-8?B?cjkwdkRid3QxVkNIUmhXOXhYQ2tMUnVkWlBlbXJMV1J2b1B0UEw3T2RJVkZB?=
 =?utf-8?B?Z0ZtSEFYb1VuWWIvZnBDUXdiV0kyYW1JRlBrOG1FVllVcFdBMFkxcHBZZ1VF?=
 =?utf-8?B?WG1qTWZWZ0JJWGNKV2taeFFaRWFYbno3dkVNbDlEOFJ1Rm1MaWdLbSsyQnlq?=
 =?utf-8?B?MEFnTm8vWXRvTHN2ZVVhKzgrZFR0c2lTUHpGK211Nk43V001SENHcXN1aXU3?=
 =?utf-8?B?bjhIaGJCbFBlNCtwNGM3VEFuWlA1OURIS2tJMHRwN0pQWHNhQmhWS0k2K2Vp?=
 =?utf-8?B?RmttRG9yR3RSbFlBWEZTWnhJVHh5Wi93VWxqM3poamFhOWJYQnhmMW9md1lu?=
 =?utf-8?B?MmhiOEw1VEx2ekxMSm1raDRmOFN5bjA5ejdKdzZxUkk3T2JoTER5aUZqZ2Ry?=
 =?utf-8?B?S1pEdENiM0lwZTZaTzJRWnpRVmlFTUYzK2lRSklCVnhwbm1VRlJrWDhMRGE0?=
 =?utf-8?B?T2lma1VkUXo5N29lTUFZRk9VQUlySkpIWkx4WmczMUlkWEhoWGhkRlduRHIz?=
 =?utf-8?B?dUl4VkkvSTRUSFRmODkyVlZpMjI0d3BVTFkwSUhhcDRZa0pEWHg2bnV2UVNU?=
 =?utf-8?B?K2lscmEyenN0bCtZRVlZTkx1UHBYV2MwdEEyY0VvTGszVmdHUmk0N0IxV0Jk?=
 =?utf-8?B?Y29uREFBUEI3S2tHUlo4dW93TlJhTXBtcHl0bWZPWWx6cndkN3FJU3JxWTIr?=
 =?utf-8?B?clpweUwxeHRVUDBSRzFKOHppVXdDVGV1bUVJc1lXNHk0RTljU0loVHBoNnJt?=
 =?utf-8?B?YWJDc0xhNnVvVlh0RDh1RFlYa0x5WS9nT0RqYVQ0Y3V2dkI3TDE5WGI1ZnFp?=
 =?utf-8?B?NEVFb21jQXR0RzlvZ2F6UllLTEpidGxlc0VNOW9kVU1PY3k0c09LWkhKeFdB?=
 =?utf-8?B?TE5SbUFHSVJWK1FVOHdiS1VvZE1KUm92SjRoRTFxTThGZG1QdUxTUU9WWDBR?=
 =?utf-8?B?VHcxZWprWmFDbDVoT2lrazNlZ1g0KzFwSE1XQkMzRmZWWEk0bldFVEFUeEFx?=
 =?utf-8?B?R1JueUZNYjdIczhQUE5qblUreElxcXBJcXQ5dW5vb3RiQWhtQVNTbG9DL00x?=
 =?utf-8?B?YmNxL1hEQWROUTBrdElpOHVGNmNKdjdNU0Z1RnN2cWNzQUk5SlhkdmtqVnVo?=
 =?utf-8?B?QVRjQW96WXArU3AxN0Y3clpSMFYwb3NZMklWVndWbWt4NnR0c29Ic1pWRmFh?=
 =?utf-8?B?SmtjN0RwSFV0NTUrSDhqdVRHMHhHR1k5cVgyMHB3cno2WlJsbnJKRFM4QVNH?=
 =?utf-8?B?aUFHbTBIMVIzRGMvUUNHUXBURDNGUWoxVTE3ekVrc1RheHFGZ0RqT2ZWa0hn?=
 =?utf-8?Q?0CqtvHmudsKM64StXYQIxWrMgNnts3Yv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7704.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEg1a0p1aXdjcXZrZ05MeXFkMUN2Ymc4WWo3VHpDZkp0QWY3OFlxZzQ5b04x?=
 =?utf-8?B?L3l5WnlWNm1qelN5MFR5UWs0WkIwOXBPNHdtTXdMVW1IcVQ4R0Z2ZG5NZy9t?=
 =?utf-8?B?Z2wyUmwzbHRldThZNXRIRUt0b1ZJWG1LbzB1TkFQTk91dFpObkRGR1BJSlQ3?=
 =?utf-8?B?dWtWUXpoanpLNDhjOU4zWC9RQkJDSXBobmF2ZHNxazhnTFltVUxIT3BFNXVt?=
 =?utf-8?B?eW1CRUo0VUs1ZHI2OElxYmZsUXVnQnVpV3JkakJoMlNsd2dtUXJPMEF5OWp6?=
 =?utf-8?B?WjNULytHZXc1dUs1RE1NdDJpWDM3VDgwM240SkErMWlCUkh0M2txa2pkcDJK?=
 =?utf-8?B?K1dRSHZ0d0o2bkMvNDNsR3YvNnVNTElYbnhtVzlkQW11MksvQzVKUUVNN0dv?=
 =?utf-8?B?VTBuN21PbG85TFpwWSt1OXhMZlNuUlM0RFlBT2lQaVdKVXQ5aDFjYStrUXFZ?=
 =?utf-8?B?VVFITWwwZ2x6WjhmTURsUGVuT0lrcUljM0UrNStVSzJBZEFPak1aUzN5L0oz?=
 =?utf-8?B?SlRFc0pYVWt5V2lWRC9qZFpISzRIdFk4TVVrQWxTNnZ4OFNKY2tIRVE2TnRH?=
 =?utf-8?B?WkdsbEdpYkNuQzJHS212bzJ6RDFVRThLczhyOFVWbU10bjlIZk5JNk5GYlhu?=
 =?utf-8?B?emVFUGlxVUpIWUpXcXJYUm1RSDNEQnVaem10azBwTUYyTW9OS2tCemdQMXdX?=
 =?utf-8?B?TkhHbTJXNEtsaHUyOGFzSjhhL1lPZktmSDhCY1dqZko4OWIrL1FiODdsMnR0?=
 =?utf-8?B?eTBCMkhLdmVDTVNPaGVyUmRJL293YVltWFpLMldvajBoYjAzOUtyWXRzR3dM?=
 =?utf-8?B?a3lMYk4vb2JpM2lUSkh5enlSQWNxdlFXMlkrd083dGtCSFM0WndKRTRxRXJs?=
 =?utf-8?B?MHp0U1E5dmo5RzJnTWFaK1N3TlNOOWZFaWJ6VC9vR3NYR2VCOVVFM1NGdXJ2?=
 =?utf-8?B?Rm0zdHBnQitkZXVsMDlUaVlOaGExM0l0U0s2WGwzbzJjaGNsU1JPR2h4Wngy?=
 =?utf-8?B?Q3FQcnlZWFlsREw5c0Zsa1FpM29abDhjV25Pa3pRV0xnM0tweml1N3d1TVhR?=
 =?utf-8?B?TDhEV3FjUm93K0tmczRGcGRQSmlrL0RrUU1XMDFETVJXM0hLOGhBVHRSS0l6?=
 =?utf-8?B?OGFQdmo5UEhGbW5QamtXeEJIY1ZuWW5WRzJMSCtKMU5oaTh2KzNadlVCTHJV?=
 =?utf-8?B?WlhuV0NRc2ZuK3lWRW42S1MwLzNlSTNleU9xVmRkSXlvb09VRFNwaW94eXha?=
 =?utf-8?B?KzllTVc3N3grR3EwbFd5QkppVElPQ2VUWFdNUUFlU1dWS0xRMjE4QXhac09a?=
 =?utf-8?B?dnZwQzhzN2Z4dTFkRWNBaG5sWm1FSWxUN3ZHdVh0akJmcVBSbjdHeUIrNlNi?=
 =?utf-8?B?RUNtdmNSS3B6NEJwcUxmTmRxYk5mY2d6RlZBN0E4bUZYdExEaWp4RkdOeE9v?=
 =?utf-8?B?YVdjWS9wZkY0REhpUmpYSHpGVWJVTzcwTlQwTDNVMmdHNlB1VmROcGxET0Rx?=
 =?utf-8?B?aW1Cc0xnN0locVlRNE1ESC9WbkRwNitvZ2t6bE9pUzlwejhQYWdqMWMvNTlH?=
 =?utf-8?B?TmlNVkVNcnpUb2N4cGtJVmlZY1RzaEJPMkM1ZERZRG50RUs5clpuK21jYUI5?=
 =?utf-8?B?a2NRSkFmWjl2QW9rNHlzTjB6UlpxZVhnTStUdXZHYUJBK0pzd1JYWW4waTZJ?=
 =?utf-8?B?aHVjYlhDMjlTekx5ajAyQ2JlSFJYbUZLRVNvSU5lMnVrQmRjSE9JODNJTUpI?=
 =?utf-8?B?b0dTUVhJV1ZzZ3FrbzZ4WjhLQ3BDL0t0TlhzT3RCNGxYVkZSWkxiWFA5U0Iy?=
 =?utf-8?B?aFVaVlQ0RzB3RDZMSnhVZWlxTEhaRXVJRWUzMUtLZkhBYmF6M2Ftc2JOZGhG?=
 =?utf-8?B?RWFUNWtxWWpodHpBbXAyaWlUa1RhNk1ENjZSTFR0bDZrZm5JUSs4Y3hZVDJa?=
 =?utf-8?B?VStUS3duQUkvdjBrOGlRMUZ1VkxmMzBrbHdpcFowQUtqbU9QZ0t3RHhyVThE?=
 =?utf-8?B?Sm5lM0FxMExzM3Y4N0dsNkZqb01SRUdSTEpJUWltZDdTUUxnbUQrd0xhWXR0?=
 =?utf-8?B?WjkrOUptS0IxMnlWV1RNWG5tSmwvdTlYVXlLU3BnYWxTNU5henQ2T2JQcC9n?=
 =?utf-8?Q?Ojm04Uqch4+7rA868GbP5t7wp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed1f0ad-4425-4b60-2969-08de0a99bdbc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7704.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 20:47:36.5074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7i8lh9qE3AP+y3BVwkHiaYMRfKiaDRWT1rDR45Jzm4rxUDqIPfm6ecDSfcZHTN2LTleoHKkBq+rITTHBMI4OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6398

On 10/10/25 10:35, Salman Nabi wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hi Vedashree,
> 
> Thank you for sending those pathces over. I just have a few comments.
> 
> On 10/8/25 20:09, Vedashree Vidwans wrote:
>> - Add support for LFA device node in the kernel driver. Implement
>> probe() to register LFA interrupt and threaded interrupt service
>> function.
>> - CPUs will be rendezvoused during activation.
>> - On IRQ, driver will query FW components then triggers activation of
>> capable and pending components.
>> - Mutex synchronization is implemented to avoid concurrent LFA updates
>> through interrupt and sysfs interfaces.
>> - Refactor LFA CANCEL logic into independent lfa_cancel() function.
>> - Enhance PRIME/ACTIVATION functions to touch watchdog and implement
>> timeouts.
>>
>> Signed-off-by: Vedashree Vidwans <vvidwans@nvidia.com>
>> ---
>>   drivers/firmware/smccc/lfa_fw.c | 299 ++++++++++++++++++++++++++++----
>>   1 file changed, 262 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/firmware/smccc/lfa_fw.c b/drivers/firmware/smccc/lfa_fw.c
>> index 49f7feb6a211b..b36b8d7457c30 100644
>> --- a/drivers/firmware/smccc/lfa_fw.c
>> +++ b/drivers/firmware/smccc/lfa_fw.c
>> @@ -16,7 +16,15 @@
>>   #include <linux/uuid.h>
>>   #include <linux/array_size.h>
>>   #include <linux/list.h>
>> -
>> +#include <linux/interrupt.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/acpi.h>
>> +#include <linux/nmi.h>
>> +#include <linux/ktime.h>
>> +#include <linux/delay.h>
>> +#include <linux/mutex.h>
>> +
>> +#define DRIVER_NAME  "ARM_LFA"
>>   #define LFA_ERROR_STRING(name) \
>>        [name] = #name
>>   #undef pr_fmt
>> @@ -34,6 +42,18 @@
>>   #define LFA_1_0_FN_ACTIVATE          LFA_1_0_FN(5)
>>   #define LFA_1_0_FN_CANCEL            LFA_1_0_FN(6)
>>
>> +/* CALL_AGAIN flags (returned in res.a1[0]) */
>> +#define LFA_PRIME_CALL_AGAIN         BIT(0)
>> +#define LFA_ACTIVATE_CALL_AGAIN              BIT(0)
>> +
>> +/* Prime loop limits, TODO: tune after testing */
>> +#define LFA_PRIME_BUDGET_US          30000000 /* 30s cap */
>> +#define LFA_PRIME_POLL_DELAY_US              10       /* 10us between polls */
>> +
>> +/* Activation loop limits, TODO: tune after testing */
>> +#define LFA_ACTIVATE_BUDGET_US               20000000 /* 20s cap */
>> +#define LFA_ACTIVATE_POLL_DELAY_US   10       /* 10us between polls */
>> +
>>   /* LFA return values */
>>   #define LFA_SUCCESS                  0
>>   #define LFA_NOT_SUPPORTED            1
>> @@ -114,8 +134,9 @@ static const struct fw_image_uuid {
>>   };
>>
>>   static struct kobject *lfa_dir;
>> +static DEFINE_MUTEX(lfa_lock);
>>
>> -static int get_nr_lfa_components(void)
>> +static unsigned long get_nr_lfa_components(void)
>>   {
>>        struct arm_smccc_1_2_regs args = { 0 };
>>        struct arm_smccc_1_2_regs res = { 0 };
>> @@ -130,11 +151,40 @@ static int get_nr_lfa_components(void)
>>        return res.a1;
>>   }
>>
>> +static int lfa_cancel(void *data)
>> +{
>> +     struct image_props *attrs = data;
>> +     struct arm_smccc_1_2_regs args = { 0 };
>> +     struct arm_smccc_1_2_regs res = { 0 };
>> +
>> +     args.a0 = LFA_1_0_FN_CANCEL;
>> +     args.a1 = attrs->fw_seq_id;
>> +     arm_smccc_1_2_invoke(&args, &res);
>> +
>> +     /*
>> +      * When firmware activation is called with "skip_cpu_rendezvous=1",
>> +      * LFA_CANCEL can fail with LFA_BUSY if the activation could not be
>> +      * cancelled.
>> +      */
>> +     if (res.a0 == LFA_SUCCESS) {
>> +             pr_info("Activation cancelled for image %s",
>> +                     attrs->image_name);
>> +     } else {
>> +             pr_err("Firmware activation could not be cancelled: %ld",
>> +                    (long)res.a0);
>> +             return -EIO;
>> +     }
>> +
>> +     return res.a0;
>> +}
>> +
>>   static int call_lfa_activate(void *data)
>>   {
>>        struct image_props *attrs = data;
>>        struct arm_smccc_1_2_regs args = { 0 };
>>        struct arm_smccc_1_2_regs res = { 0 };
>> +     ktime_t end = ktime_add_us(ktime_get(), LFA_ACTIVATE_BUDGET_US);
>> +     int ret;
>>
>>        args.a0 = LFA_1_0_FN_ACTIVATE;
>>        args.a1 = attrs->fw_seq_id; /* fw_seq_id under consideration */
>> @@ -148,9 +198,32 @@ static int call_lfa_activate(void *data)
>>         */
>>        args.a2 = !(attrs->cpu_rendezvous_forced || attrs->cpu_rendezvous);
>>
>> -     do {
>> +     for (;;) {
>> +             /* Touch watchdog, ACTIVATE shouldn't take longer than watchdog_thresh */
>> +             touch_nmi_watchdog();
>>                arm_smccc_1_2_invoke(&args, &res);
>> -     } while (res.a0 == 0 && res.a1 == 1);
>> +
>> +             if ((long)res.a0 < 0) {
>> +                     pr_err("ACTIVATE for image %s failed: %s",
>> +                             attrs->image_name, lfa_error_strings[-res.a0]);
>> +                     return res.a0;
>> +             }
>> +             if (!(res.a1 & LFA_ACTIVATE_CALL_AGAIN))
>> +                     break; /* ACTIVATE successful */
>> +
>> +             /* SMC returned with call_again flag set */
>> +             if (ktime_before(ktime_get(), end)) {
>> +                     udelay(LFA_ACTIVATE_POLL_DELAY_US);
>> +                     continue;
>> +             }
>> +
>> +             pr_err("ACTIVATE timed out for image %s", attrs->image_name);
>> +             ret = lfa_cancel(attrs);
>> +             if (ret == 0)
>> +                     return -ETIMEDOUT;
>> +             else
>> +                     return ret;
>> +     }
>>
>>        return res.a0;
>>   }
>> @@ -159,8 +232,24 @@ static int activate_fw_image(struct image_props *attrs)
>>   {
>>        struct arm_smccc_1_2_regs args = { 0 };
>>        struct arm_smccc_1_2_regs res = { 0 };
>> +     ktime_t end = ktime_add_us(ktime_get(), LFA_PRIME_BUDGET_US);
>>        int ret;
>>
>> +     if (attrs->may_reset_cpu) {
>> +             pr_err("Firmware component requires unsupported CPU reset");
>> +             return -EINVAL;
>> +     }
>> +
>> +     /*
>> +      * We want to force CPU rendezvous if either cpu_rendezvous or
>> +      * cpu_rendezvous_forced is set. The flag value is flipped as
>> +      * it is called skip_cpu_rendezvous in the spec.
>> +      */
>> +     if (!(attrs->cpu_rendezvous_forced || attrs->cpu_rendezvous)) {
>> +             pr_warn("CPU rendezvous is expected to be selected.");
>> +             return -EAGAIN;
>> +     }
> 
> The purpose of cpu_rendezvous_forced was to allow firmware components, that dont
> require cpu rendezvous, bypass kernel's conservative approach of always requiring
> cpu_rendezvous. This was per the feedback on the first LFA RFC patch. If we are
> happy forcing cpu rendezvou than I don't see the point of cpu_rendezvous_forced
> switch.
> 
For current situation, enforcing CPU rendezvous appears to be the most 
practical approach for our usecase. I agree that cpu_rendezvous_forced 
switch is redundant but it enforces the situation that kernel can handle.
 From my perspective, it is challenging for kernel driver to reliably 
determine whether any process will use services from the firmware that's 
being updated. We should revisit whether the switch is necessary in the 
future, especially based on requirements, feedback and validation data. >> +
>>        /*
>>         * LFA_PRIME/ACTIVATE will return 1 in res.a1 if the firmware
>>         * priming/activation is still in progress. In that case
>> @@ -169,20 +258,36 @@ static int activate_fw_image(struct image_props *attrs)
>>         */
>>        args.a0 = LFA_1_0_FN_PRIME;
>>        args.a1 = attrs->fw_seq_id; /* fw_seq_id under consideration */
>> -     do {
>> +     for (;;) {
>> +             /* Touch watchdog, PRIME shouldn't take longer than watchdog_thresh */
>> +             touch_nmi_watchdog();
>>                arm_smccc_1_2_invoke(&args, &res);
>> -             if (res.a0 != LFA_SUCCESS) {
>> -                     pr_err("LFA_PRIME failed: %s\n",
>> -                             lfa_error_strings[-res.a0]);
>>
>> +             if ((long)res.a0 < 0) {
>> +                     pr_err("LFA_PRIME for image %s failed: %s\n",
>> +                             attrs->image_name, lfa_error_strings[-res.a0]);
>>                        return res.a0;
>>                }
>> -     } while (res.a1 == 1);
>> +             if (!(res.a1 & LFA_PRIME_CALL_AGAIN))
>> +                     break; /* PRIME successful */
>>
>> -     if (attrs->cpu_rendezvous_forced || attrs->cpu_rendezvous)
>> -             ret = stop_machine(call_lfa_activate, attrs, cpu_online_mask);
>> -     else
>> -             ret = call_lfa_activate(attrs);
>> +             /* SMC returned with call_again flag set */
>> +             if (ktime_before(ktime_get(), end)) {
>> +                     udelay(LFA_PRIME_POLL_DELAY_US);
>> +                     continue;
>> +             }
>> +
>> +             pr_err("PRIME timed out for image %s", attrs->image_name);
>> +             ret = lfa_cancel(attrs);
>> +             if (ret == 0)
>> +                     return -ETIMEDOUT;
>> +             else
>> +                     return ret;
>> +     }
>> +
>> +     ret = stop_machine(call_lfa_activate, attrs, cpu_online_mask);
>> +     if (ret != 0)
>> +             return lfa_cancel(attrs);
>>
>>        return ret;
>>   }
>> @@ -286,23 +391,23 @@ static ssize_t activate_store(struct kobject *kobj, struct kobj_attribute *attr,
>>                                         image_attrs[LFA_ATTR_ACTIVATE]);
>>        int ret;
>>
>> -     if (attrs->may_reset_cpu) {
>> -             pr_err("Firmware component requires unsupported CPU reset\n");
>> -
>> -             return -EINVAL;
>> +     if (!mutex_trylock(&lfa_lock)) {
>> +             pr_err("Mutex locked, try again");
>> +             return -EAGAIN;
>>        }
>>
>>        ret = activate_fw_image(attrs);
>>        if (ret) {
>>                pr_err("Firmware activation failed: %s\n",
>>                        lfa_error_strings[-ret]);
>> -
>> +             mutex_unlock(&lfa_lock);
>>                return -ECANCELED;
>>        }
>>
>>        pr_info("Firmware activation succeeded\n");
>>
>>        /* TODO: refresh image flags here*/
>> +     mutex_unlock(&lfa_lock);
>>        return count;
>>   }
>>
>> @@ -311,26 +416,11 @@ static ssize_t cancel_store(struct kobject *kobj, struct kobj_attribute *attr,
>>   {
>>        struct image_props *attrs = container_of(attr, struct image_props,
>>                                                 image_attrs[LFA_ATTR_CANCEL]);
>> -     struct arm_smccc_1_2_regs args = { 0 };
>> -     struct arm_smccc_1_2_regs res = { 0 };
>> -
>> -     args.a0 = LFA_1_0_FN_CANCEL;
>> -     args.a1 = attrs->fw_seq_id;
>> -     arm_smccc_1_2_invoke(&args, &res);
>> +     int ret;
>>
>> -     /*
>> -      * When firmware activation is called with "skip_cpu_rendezvous=1",
>> -      * LFA_CANCEL can fail with LFA_BUSY if the activation could not be
>> -      * cancelled.
>> -      */
>> -     if (res.a0 == LFA_SUCCESS) {
>> -             pr_info("Activation cancelled for image %s\n",
>> -                     attrs->image_name);
>> -     } else {
>> -             pr_err("Firmware activation could not be cancelled: %s\n",
>> -                    lfa_error_strings[-res.a0]);
>> -             return -EINVAL;
>> -     }
>> +     ret = lfa_cancel(attrs);
>> +     if (ret != 0)
>> +             return ret;
>>
>>        return count;
>>   }
>> @@ -418,6 +508,11 @@ static int create_fw_images_tree(void)
>>        int ret, num_of_components;
>>
>>        num_of_components = get_nr_lfa_components();
>> +     if (num_of_components <= 0) {
>> +             pr_err("Error getting number of LFA components");
>> +             return -ENODEV;
>> +     }
>> +
>>        args.a0 = LFA_1_0_FN_GET_INVENTORY;
>>        for (int i = 0; i < num_of_components; i++) {
>>                args.a1 = i; /* fw_seq_id under consideration */
>> @@ -437,6 +532,125 @@ static int create_fw_images_tree(void)
>>        return 0;
>>   }
>>
>> +static int refresh_fw_images_tree(void)
>> +{
>> +     int ret;
>> +     /*
>> +      * Ideally, this function should invoke the GET_INVENTORY SMC
>> +      * for each firmware image and update the corresponding details
>> +      * in the firmware image tree node.
>> +      * There are several edge cases to consider:
>> +      *    - The number of firmware components may change.
>> +      *    - The mapping between firmware sequence IDs and
>> +      *      firmware image UUIDs may be modified.
>> +      * As a result, it is possible that the firmware image tree nodes
>> +      * will require updates. Additionally, GET_INVENTORY SMC provides
>> +      * all current and revised information. Therefore, retaining the
>> +      * existing fw_images_tree data is not justified. Reconstructing
>> +      * the firmware images tree will simplify the code and keep data
>> +      * up-to-date.
>> +      */
>> +     // Clean current inventory details
>> +     clean_fw_images_tree();
> 
> This isn't an optimal approach to updating the firmware components. Removing a
> directory that a user is currently looking at will still linger around as its
> ref count won't get 0. Also, an attribute read/write operation during an
> activation for example, reading the activation pending flag will result in
> the mutex lock waiting to acquire the lock which will keep the attribute file
> around. Trying to remove said object may result in unpredictable behaviour.
> We have a WIP patch that is supposed to refresh the data i.e. firmware images
> attributes and seq_ids, instead of deleting the objects and re-creating them.
> Only firmware images that are removed from the LFA agent following an
> activation would be removed.
> 
Okay, I understand.
I will add a placeholder to refresh the fw_images_tree() to unblock rest 
of the changes. I will hold back to use your implementation and/or 
brainstorm more approaches in parallel.>> +
>> +     // Update new inventory details
>> +     ret = create_fw_images_tree();
>> +     if (ret != 0)
>> +             kobject_put(lfa_dir);
>> +
>> +     return ret;
>> +}
>> +
>> +static irqreturn_t lfa_irq_thread(int irq, void *data)
>> +{
>> +     struct image_props *attrs = NULL;
>> +     int ret;
>> +
>> +     mutex_lock(&lfa_lock);
> 
> mutex_lock() can sleep and is unsafe in an interrupt context, mutex_trylock()
> doesn't sleep but is still considered illegal in an interrupt context as
> mutex_unlock() can still sleep.
> 
The lfa_irq_thread() is a thread_fn passed to request_threaded_irq(). 
 From what I understand, thread_fn runs in a process context as a kernel 
thread and therefore can use sleeping locks such as mutex_lock(), 
wait_event() and msleep().>> +
>> +     // Update new inventory details
>> +     ret = refresh_fw_images_tree();
> 
> According to the LFA specification IIRC the firmware images and their seq_ids
> may change following an activation, not after an update that is pending an
> activation. Thus the refresh should happen soon after an activation only.
> 
> Kind Regards
> Salman
> 
Thank you for pointing that out. If I understand the spec correctly, it 
is possible that number of components can change after an activation and 
so we would have to refresh complete fw_images_tree.
So the flow I would follow for activation is:
1. Get inventory for all FW components
2. PRIME-ACTIVATE first activable component in the list.
3. Go to 1, until no component is pending activation.

Regards,
Veda>> +     if (ret != 0)
>> +             goto exit_unlock;
>> +
>> +     /*
>> +      * Execute PRIME and ACTIVATE for each FW component
>> +      * Start from first FW component
>> +      */
>> +     list_for_each_entry(attrs, &lfa_fw_images, image_node) {
>> +             if ((!attrs->activation_capable) || (!attrs->activation_pending)) {
>> +                     /* LFA not applicable for this FW component, continue to next component */
>> +                     continue;
>> +             }
>> +
>> +             ret = activate_fw_image(attrs);
>> +             if (ret) {
>> +                     pr_err("Firmware %s activation failed: %s\n",
>> +                             attrs->image_name, lfa_error_strings[-ret]);
>> +                     goto exit_unlock;
>> +             }
>> +
>> +             pr_info("Firmware %s activation succeeded", attrs->image_name);
>> +     }
>> +
>> +     // Update new inventory details
>> +     ret = refresh_fw_images_tree();
>> +     if (ret != 0)
>> +             goto exit_unlock;
>> +
>> +exit_unlock:
>> +     mutex_unlock(&lfa_lock);
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +static int __init lfa_probe(struct platform_device *pdev)
>> +{
>> +     int err;
>> +     unsigned int irq;
>> +
>> +     err = platform_get_irq_byname_optional(pdev, "fw-store-updated-interrupt");
>> +     if (err < 0)
>> +             err = platform_get_irq(pdev, 0);
>> +     if (err < 0) {
>> +             pr_err("Interrupt not found, functionality will be unavailable.");
>> +
>> +             /* Bail out without failing the driver. */
>> +             return 0;
>> +     }
>> +     irq = err;
>> +
>> +     err = request_threaded_irq(irq, NULL, lfa_irq_thread, IRQF_ONESHOT, DRIVER_NAME, NULL);
>> +     if (err != 0) {
>> +             pr_err("Interrupt setup failed, functionality will be unavailable.");
>> +
>> +             /* Bail out without failing the driver. */
>> +             return 0;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct of_device_id lfa_of_ids[] = {
>> +     { .compatible = "arm,armhf000", },
>> +     { },
>> +};
>> +MODULE_DEVICE_TABLE(of, lfa_of_ids);
>> +
>> +static const struct acpi_device_id lfa_acpi_ids[] = {
>> +     {"ARMHF000"},
>> +     {},
>> +};
>> +MODULE_DEVICE_TABLE(acpi, lfa_acpi_ids);
>> +
>> +static struct platform_driver lfa_driver = {
>> +     .probe = lfa_probe,
>> +     .driver = {
>> +             .name = DRIVER_NAME,
>> +             .of_match_table = lfa_of_ids,
>> +             .acpi_match_table = ACPI_PTR(lfa_acpi_ids),
>> +     },
>> +};
>> +
>>   static int __init lfa_init(void)
>>   {
>>        struct arm_smccc_1_2_regs args = { 0 };
>> @@ -464,22 +678,33 @@ static int __init lfa_init(void)
>>        pr_info("Arm Live Firmware Activation (LFA): detected v%ld.%ld\n",
>>                res.a0 >> 16, res.a0 & 0xffff);
>>
>> +     err = platform_driver_register(&lfa_driver);
>> +     if (err < 0)
>> +             pr_err("Platform driver register failed");
>> +
>> +
>>        lfa_dir = kobject_create_and_add("lfa", firmware_kobj);
>>        if (!lfa_dir)
>>                return -ENOMEM;
>>
>> +     mutex_lock(&lfa_lock);
>>        err = create_fw_images_tree();
>>        if (err != 0)
>>                kobject_put(lfa_dir);
>>
>> +     mutex_unlock(&lfa_lock);
>>        return err;
>>   }
>>   module_init(lfa_init);
>>
>>   static void __exit lfa_exit(void)
>>   {
>> +     mutex_lock(&lfa_lock);
>>        clean_fw_images_tree();
>> +     mutex_unlock(&lfa_lock);
>> +
>>        kobject_put(lfa_dir);
>> +     platform_driver_unregister(&lfa_driver);
>>   }
>>   module_exit(lfa_exit);
>>


