Return-Path: <linux-kernel+bounces-898889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36222C56412
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A328E35284C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5C332F773;
	Thu, 13 Nov 2025 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HGiT3MNq"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7323280329;
	Thu, 13 Nov 2025 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763021958; cv=fail; b=uB79VbPBNeRyu0xfG2885b6C7fmeO9ROcnv9nTaRCJQxHmh6cbpmNl0g4cw3lqeIR1+A4Blvk42Mr1APgNAue1GpRCJSATXwdj/B9vGXLAGffnxqqEJBuTh/ijBeeFV8TWEuoSVPboUvr+zRHiMFfcADCA+E0qSCqqxDpSOYNkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763021958; c=relaxed/simple;
	bh=Mbr+uCe5HDWyxvxrWI1pmkkbc3ofisAVeRVYsMmifTo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X8F3IFRTJzs69YuGP/9IVnrOuIF+UJz4nhUzKzXtJ7qGDsmI5X/7djku/j6Q1mKnSBUxGhP1rt9/fyVunch+ZfQEGYHVWdJPjCORF0lmDVsb+H1FQklOyjEKCYRgDnzky+cghqgpcXRZMalMDNg6PRVnq0bCDowODXAf7ctWQvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HGiT3MNq; arc=fail smtp.client-ip=40.107.159.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kknl/du4PavK9g2JcjTOVx+OUEkUJPv0IS0dQa9DPWgJyFJWDzW7nonSghKYraI042TBiWcOdl1VkqCmawnMSWeQoDqiWmi0NeyZdaMIsEMYPrNyIpPRZyL5DaG4Of/Qz2MOr//IL69we8L8udg5+80tK9jFRH9uBFAvq3o+1eig7LdRR6svLT6YmuQaoioH8DvnVJiKWriU+sHbuOxWjIUxulExWGXWzf+zWTXKPNOlkG7q1dz3w7eF4oHmEMyxlBUlQfiNvFcmkqNgI9yBOqw/8kOdw5gQIXMYDeVbW8cD4VDVu3+zLZ11kLBJygfAVvyVpvSevMGXE3bdg4Q8+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FdplCdlJl8pSjEoM7eeAjLoUFAm4Jtl/lN2P3mdIxQ=;
 b=g5IzqR3GdxnOjcrzjs+ItwWBuas0CE2kHCmrT5uXafMLzJw8v3dqPmNzilcWjcbGyf96a+FHzlkVgdaUIDEffx2UtHHxXVg4zWG8MABdBloRarvNt0ItHMVZHV3ZRddUDQCeauHMzueHI1LUpsy2/VP0EtaSaR7fxopXVC5q4wYwzkEeXY7+Vb1jIdqoezPrrR1Qzme/VvSdCItZdp9r4QqEzY9AWG7o3nmrFnxTSqb6BtTzQtmKJG75dUvmymcoC92tYf9X9b/gu5PGN8PHOldPnXZBtzZpCQZ64nznXkLs1Xx0w8f7E04BNe16/m6+S3XRlmf+GC0LdmjPC1NMsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FdplCdlJl8pSjEoM7eeAjLoUFAm4Jtl/lN2P3mdIxQ=;
 b=HGiT3MNqTVRVXNpFeEDUNhVyEYX6bIaPLJJzF4sV52lFUDpNMRe/HgwYLV7+7WQ0DIRezNnIxhNK8WmPaidm5yvgRzlqxMceTlfRQaAmHwKCSYr11gSkGWheFJyjY4Q+h3AkwSyawcXhZyK2Z3sWptzkVsmKNyNUecGwYvjOjCX0sarezfJuH816VZ1OrBZ6UEZHSS68yf1Hvre7D3GRIdsYgJ/de4mNxbVrIi4BwZapJA3nG6uBSp+76tPK2079DsfUETX12BSq7l8Ji3y82fHH7S57uYuryw09hchTyB1fceGK0PNnsMfsx2mdAmKJDHopj+ixfa79kj6YYLtkog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB9831.eurprd04.prod.outlook.com (2603:10a6:150:11c::8)
 by GVXPR04MB10136.eurprd04.prod.outlook.com (2603:10a6:150:1bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 08:19:12 +0000
Received: from GVXPR04MB9831.eurprd04.prod.outlook.com
 ([fe80::4634:3d9c:c4a:641a]) by GVXPR04MB9831.eurprd04.prod.outlook.com
 ([fe80::4634:3d9c:c4a:641a%6]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 08:19:12 +0000
Message-ID: <90267077-c74c-4e05-809d-94694d162e18@nxp.com>
Date: Thu, 13 Nov 2025 09:19:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/8] media: v4l2-core: Introduce v4l2-isp.c
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
 Dafna Hirschfeld <dafna@fastmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Keke Li <keke.li@amlogic.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Dan Scally <dan.scally@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Michael Riesch <michael.riesch@collabora.com>
References: <20251020-extensible-parameters-validation-v8-0-afba4ba7b42d@ideasonboard.com>
 <20251020-extensible-parameters-validation-v8-5-afba4ba7b42d@ideasonboard.com>
Content-Language: en-US
From: Antoine Bouyer <antoine.bouyer@nxp.com>
In-Reply-To: <20251020-extensible-parameters-validation-v8-5-afba4ba7b42d@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::16) To GVXPR04MB9831.eurprd04.prod.outlook.com
 (2603:10a6:150:11c::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB9831:EE_|GVXPR04MB10136:EE_
X-MS-Office365-Filtering-Correlation-Id: 25101d67-c0db-4fab-05fd-08de228d537b
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Y20zVjlTSTIyT2w4MC9BeEw3RVF2Y3lQN1dId0RPMXIvUmtPN2Q4YTJrY3dJ?=
 =?utf-8?B?MUgrT0xCeDZnTjlDSWVQeGJGQUtjQ20zalcrdFc3L2dHQkltemh6U3IzLzdo?=
 =?utf-8?B?RVpkaElFNVBDOEpza3p4RXlmblJWc2ZpYWphL2VnQ2xydDlrY2NjTFpOdWR2?=
 =?utf-8?B?a24xUFZaUFhPVWtlWGliampmUmhTbXRtdFMxSVNTVjlmdU50TDdEK3JkRjc0?=
 =?utf-8?B?WGxnWG1Zc1FsSVc3VFNYSWZrRmNJb2pkNlI2QnU3M3JueitCY2MzQmJBU3hL?=
 =?utf-8?B?RzlIcEI0UWcxYXhnNkg2S1YxTW5DYVF6MzRKWFYwL1pmV0tZbDJmVElJa1Ra?=
 =?utf-8?B?SktMN1hRb3o4ZXduQzVEMmFhMGFzQ2tlT0pnVlZBOXhVWjBZbHV0MGl1aUJ1?=
 =?utf-8?B?Z2ZCakY1Q05YcU96Y1BlbjFJbjluVTl1NnhleHFxeU0yMGtFMnBTOTFEcXpM?=
 =?utf-8?B?bk5XMVEvL2hZazJUT05JQm5HdjR1Ym94L3poNktQZEtud2JlcDNKMWVSQWk3?=
 =?utf-8?B?eVgzNFNLaE5vMklNM0RiUHdUTG5WSWxTN2lSTERMMnhqSnNLUjYwQThNTUMv?=
 =?utf-8?B?TlhCeFp2bnRvdVlsZXhIOFR6TGozemJENFYwTnZIZXMrSm5pVk0wWlByUXNz?=
 =?utf-8?B?WkZVYVhuNVdmQ3VLenlRa0s3QTBHVmxoUCs5bnYyNkR2Z2dBaGxrb3FseWJU?=
 =?utf-8?B?S21BcGVBS3ppcXZ2bktwZ2I1NFFEcUM5OS9nbWIwNy9RRUI2VHVBaGNuZ2do?=
 =?utf-8?B?Y2crWHVkY0FTWTVtbmd3QXM5UElhVDZ5dWEzZTZ0WVVPTHNjaWdTT2RoaS9o?=
 =?utf-8?B?VkhpQWJweDVNRmRRWGhHUzh3NTA4OWRBVUlRMWZZU3NELzlqM01uczdWdVh0?=
 =?utf-8?B?SFVxV1BPbEp5WFg2dmJCZDJuT1hseFJJakNyaEtWWXN4NUhyeXhQbjk5Nlpa?=
 =?utf-8?B?ZndzNWYyeE8vM2N0WVpJL1BUTkVqbnNyYkxUWmRzQTVKRFYxdkR1VTRWRWpG?=
 =?utf-8?B?UFNsVnhFbWNnREV5bXBCTjcwVFZqYy9TNFRGY3hhb25UWFpGR1ZwTEM3T1dz?=
 =?utf-8?B?cHJ3TVg5dzl0R2pEazJlMjBNb3RRamZWNmhrV05mN2pnUUdPQmMySWNFWkdH?=
 =?utf-8?B?dDFjUGY0T2pNUEU2ODl3YXdrQ3BmN0tZakFHd2w0UWxOQTE3NWxXU1Y4K3Fq?=
 =?utf-8?B?L281dk9weTNnRlFKanlGYk9BVlYrUmxERGQ2MTdiN1orVXJKL1N1Vk50Qkg1?=
 =?utf-8?B?VlExT29RZExpRzJKbDFRbTgrQ3NxbW1uWEpmd0ZHV2kzaGo2UGNqTEFCbk9S?=
 =?utf-8?B?Y0NZVHNXVnJhbWgxQUtqYitQd1V2NGtRaE1CNTc3dkVCeVFiVVJ5Zjl2bUVk?=
 =?utf-8?B?M3VkdWszbWZuSTJVNVF3Vy9aVUVNS2lUQkc3d1dkTjFHM0dpYVBWMytmYmdk?=
 =?utf-8?B?WEoxR1F1SVVidjJnQWF1MEZFb2d2SWhRNHZpTHhuQm9GUTFYYktVeFRFMlJy?=
 =?utf-8?B?bUUvK0ZRbEsvT0lISGVwalJTN2srVWlDa3BOYlN3MUsvTjUvMTl5VDdXVjNs?=
 =?utf-8?B?T3l1REVLaEYzTkw4c2R5UTB2Y0UrRTA4aTNJdEI5NTBOdnZzeXZ5a2lGck1o?=
 =?utf-8?B?dk56eEFFU3QxMllidzMySlFsRzQvLzJkN0RnaS9rK1FHQ1FGN0J1a2FVS0dy?=
 =?utf-8?B?dE12aFI4NFZOMlZxMTlYYURwSnlpYkdPZmZBYjQ0THF3cWJzbUtMVU5hRUlR?=
 =?utf-8?B?Y1hWTStNMjFnQlVYUStZNG9sOWd1UVY2T3JGbjVIR05ud0loK2VvVnlXL01m?=
 =?utf-8?B?TzNYMU5GL3NXdFJuY051K3VXVmZoUUNVL0gzbitKUjRKV2N3N1VhRDJwTmxR?=
 =?utf-8?B?WjI0dURhS0R0UFB4eHloYzNRbmFDT2pCcUpjTXh6VTh3UndQaEhERjZ3WWYx?=
 =?utf-8?Q?be9AQcTcg2WHXxKpctvVPk6n3sFYYQtl?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB9831.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VXJQbnZKNk9SYm12UGxFSUlZZ2hVcTRpZFRyd3hsdjRGQTB2dVVkU1o5RHN4?=
 =?utf-8?B?amxsczlvQVZ6cC9xVnhXZlIxdVJTTCtkMVZVSWVPbUNwdVJFcElOYXhmZFlM?=
 =?utf-8?B?T2ttdXFjN2ZmU1pHWmhGM0NEdFFlZ0F0Y2poZ0NXRWVubjVEb0pweW5nSXJa?=
 =?utf-8?B?SkNpT0FTNlV0ZGZWRVpkYnlzQXNUUkJrUmphbkw2Vms2blI4VkQ0Vm1jOU01?=
 =?utf-8?B?L1dwbSt3Lzd0aUs4ZGQ5RktqeUNnYnloRGkzSk9LbnluZFZuSTFNM1N0Ymcx?=
 =?utf-8?B?aDVFRjJnaUdyVjhNeDNELzJRSC9kcCtOUEdFTlBkdFRteDlZTnZCcTV6dlJo?=
 =?utf-8?B?b0wwdXR2OUptRFhiR0RxdEtrTVBLZnBpeVM1ZUhzWWYyVTllS2pjT1JaUjBl?=
 =?utf-8?B?NUFGUzFwQ3R4YUxjOWp4ZXVoRUsyNWEwemtZNjVuZm1lS3p0SXZXNzhadFhE?=
 =?utf-8?B?T29vdmUrNnNnYXpkOTJPVXpVVGlLeFRBdjNIdDd1akhMNXNSR0pydVc0N3dP?=
 =?utf-8?B?Ty9MNHN5WkhKMC9DUG4yY29JOTQ5R3IxT1ZqSTM3WEhOQXd6VFlwRVBoUlh4?=
 =?utf-8?B?ZDloT1h2MVZ5Y3BjampGVEdqWm1KZWFDNGVZWkFRNGtQZFVjZ0RlQ05TTklY?=
 =?utf-8?B?UTFyVFJoNGxHN2VzMDJlVndMSEVqcElHUFBjK0FHYmJodEJKZ3ljd0VDUlFL?=
 =?utf-8?B?V1UvZDR4T0dYdkg1ZVJaeGNTMzlDWTJjYXZBaFhtL2FqZlk2RlBVT2o5NVp1?=
 =?utf-8?B?N3VPVXBKSzZ0R01PeFZxTE5mY0FHcmpzaFQwMXk3Q0p4OStLMjBwNHVLNkpO?=
 =?utf-8?B?NWd3aFlKemtRemc1bEIxTUFMSWcrQlE1cEJ2RHpMNHlqckdxazMvelM3aHFC?=
 =?utf-8?B?aDg5ZTNQVko4eWVSYmczWFZxSlBBSFhrbjJGWUhQVC9nUlBSS1hlMllKMTRu?=
 =?utf-8?B?dHdtcy9ZVzk1TWNQdWlQeGJiZXpOTUlXZ2Y0cUZXMVR5bmhxUjJGZ1puNFhQ?=
 =?utf-8?B?eDl0UmoxVThBYmo2UU1VV2l2KzFHNEt4YmJKbUlLMjJYczRMZEY4aVFkZ21s?=
 =?utf-8?B?Uzc0UUJERUE0RHlnTWZzYnhCWHN5ZGFaS01reXdsQTRZVnlhdXk2QUlnOTdt?=
 =?utf-8?B?VkdCL1JGL0FtZXM2YmIrU1FtMVIrMi9iaEVtWVNsZzlPSGdKaTNCcEJnNXVm?=
 =?utf-8?B?YkdxbC9OQVphQVhUVXZEREVIVUthQURvdVBxYkQ4MXlIdkM1VCtFY1VJRUVL?=
 =?utf-8?B?UGQ1SVNXcTlQQTN5TEpZN1Y3SFYrWloyRm00eGd2U1VDRWI4a2QyeFVDbVJL?=
 =?utf-8?B?bmMvVGtKRlliUFNUbk93dURjdWsxNlBJYWtHZFNvai9rTUlzc1pYelVwdE9E?=
 =?utf-8?B?UEw5dkRQc1BzVlhLcWJOSWcrK1ZEQ25BV0lKeS91cDBXdTZJb2dXYzRnRGo1?=
 =?utf-8?B?RkdDdnM0ZnFNM1I2a3NHcmc3NllpL0w4NnZZSGxWc3FZd1lkWWVNRXA1d2lT?=
 =?utf-8?B?QkFRRVczeW52Vk5TeGdYYW1kWUhLcUg1MUFJVFJrRVBHUHVWTHZ1SFZab3Vq?=
 =?utf-8?B?dWIyZXc5Q2hnZEptdHBPT1FxbmFMaHlWQ0VrNmIvTU1ybjdPRlVOS09DMHp0?=
 =?utf-8?B?QlNlYitLSTZ2anNFSmdYMEJsb1YzSGRKZmh4QlB6TjNmR3c4NWhwKzNKdkQz?=
 =?utf-8?B?K20xNlJCaGZCdTlUZzJvN2Z6YlROb1QrWHpaWDJ6OGpkMS8vSEw3TWw4TFVr?=
 =?utf-8?B?UU9rdnhoRmNtRll1bWlUd0V2TDQ5UmRkTGwxSGgxdDB1dkNLZ2RkME1KL0NQ?=
 =?utf-8?B?azhaMzRyTXYrWW1wOW9Dcno3WTRXOEpLc01LODYwcGNJMXBGalcwMHd4NGEw?=
 =?utf-8?B?Q2lEMWtsclNIbWp3TW84enlKNnUyRVhvd2NMdWVnT1FUTXRvdE9UY05XNjlF?=
 =?utf-8?B?eFZnLzNkd0JvWlpTdGpSU2IwQzJna2lWOWEwYTVUQm9iNzM1eDJvRDdmWHdI?=
 =?utf-8?B?cFF4MW1IWUhNVjlGOVNzVkNhN2VKNWlkMnp4RHA5eVlUekU5R2ZPZ0JKTkVp?=
 =?utf-8?B?aUdwdTZIWTJXekpZNXEybjJCTjJkdHVRempIVjFCc1lUeW0xV2ZFR1BIS3ht?=
 =?utf-8?B?R3U4VWpiQXhqaEEzOWlTWDBtNnNkU3NXeklTQTR5YURyaktQMTN6dk56bGI5?=
 =?utf-8?B?YkE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25101d67-c0db-4fab-05fd-08de228d537b
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB9831.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 08:19:12.2225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipO7BEJ5fkGjIY9vlM8wVNaM/B0Q7JeWUOdMe0JU5F6wrW6MUBIjkUTnjhoO2LKLOkh6KBBOGElj8Iy4s66VaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10136


Hi Jacopo

On 10/20/25 10:24 AM, Jacopo Mondi wrote:
> 
> Add to the V4L2 framework helper functions to support drivers when
> validating a buffer of V4L2 ISP parameters.
> 
> Driver shall use v4l2_isp_params_validate_buffer_size() to verify the
> size correctness of the data received from userspace, and after having
> copied the data to a kernel-only memory location, complete the
> validation by calling v4l2_isp_params_validate_buffer().
> 
> Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Reviewed-by: Michael Riesch <michael.riesch@collabora.com>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> ---
>   MAINTAINERS                        |   2 +
>   drivers/media/v4l2-core/Kconfig    |   4 ++
>   drivers/media/v4l2-core/Makefile   |   1 +
>   drivers/media/v4l2-core/v4l2-isp.c | 128 +++++++++++++++++++++++++++++++++++++
>   include/media/v4l2-isp.h           |  91 ++++++++++++++++++++++++++
>   5 files changed, 226 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f52237d57710cadff78b297d2b4610b508f55092..5833f82caa7f2f734bb0e1be144ade2109b23988 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26857,6 +26857,8 @@ M:      Jacopo Mondi <jacopo.mondi@ideasonboard.com>
>   L:     linux-media@vger.kernel.org
>   S:     Maintained
>   F:     Documentation/userspace-api/media/v4l/v4l2-isp.rst
> +F:     drivers/media/v4l2-core/v4l2-isp.c
> +F:     include/media/v4l2-isp.h
>   F:     include/uapi/linux/media/v4l2-isp.h
> 
>   VF610 NAND DRIVER
> diff --git a/drivers/media/v4l2-core/Kconfig b/drivers/media/v4l2-core/Kconfig
> index 331b8e535e5bbf33f22638b2ae8bc764ad5fc407..d50ccac9733cc39a43426ae7e7996dd0b5b45186 100644
> --- a/drivers/media/v4l2-core/Kconfig
> +++ b/drivers/media/v4l2-core/Kconfig
> @@ -82,3 +82,7 @@ config V4L2_CCI_I2C
>          depends on I2C
>          select REGMAP_I2C
>          select V4L2_CCI
> +
> +config V4L2_ISP
> +       tristate

When configured as module, there's build error:

ERROR: modpost: missing MODULE_LICENSE() in 
drivers/media/v4l2-core/v4l2-isp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in 
drivers/media/v4l2-core/v4l2-isp.o

It happens when selected from an ISP driver, and ISP driver is a module. 
Then module is applied to v4l2-isp too.

> +       depends on VIDEOBUF2_CORE
> diff --git a/drivers/media/v4l2-core/Makefile b/drivers/media/v4l2-core/Makefile
> index 2177b9d63a8ffc1127c5a70118249a2ff63cd759..329f0eadce994cc1c8580beb435f68fa7e2a7aeb 100644
> --- a/drivers/media/v4l2-core/Makefile
> +++ b/drivers/media/v4l2-core/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_V4L2_CCI) += v4l2-cci.o
>   obj-$(CONFIG_V4L2_FLASH_LED_CLASS) += v4l2-flash-led-class.o
>   obj-$(CONFIG_V4L2_FWNODE) += v4l2-fwnode.o
>   obj-$(CONFIG_V4L2_H264) += v4l2-h264.o
> +obj-$(CONFIG_V4L2_ISP) += v4l2-isp.o
>   obj-$(CONFIG_V4L2_JPEG_HELPER) += v4l2-jpeg.o
>   obj-$(CONFIG_V4L2_MEM2MEM_DEV) += v4l2-mem2mem.o
>   obj-$(CONFIG_V4L2_VP9) += v4l2-vp9.o
> diff --git a/drivers/media/v4l2-core/v4l2-isp.c b/drivers/media/v4l2-core/v4l2-isp.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..35f0b701f1729c3c0ccc34b1c89189b179e0b684
> --- /dev/null
> +++ b/drivers/media/v4l2-core/v4l2-isp.c
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Video4Linux2 generic ISP parameters and statistics support
> + *
> + * Copyright (C) 2025 Ideas On Board Oy
> + * Author: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> + */
> +
> +#include <media/v4l2-isp.h>
> +
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +
> +#include <media/videobuf2-core.h>
> +
> +int v4l2_isp_params_validate_buffer_size(struct device *dev,
> +                                        struct vb2_buffer *vb,
> +                                        size_t max_size)
> +{
> +       size_t header_size = offsetof(struct v4l2_isp_params_buffer, data);
> +       size_t payload_size = vb2_get_plane_payload(vb, 0);
> +
> +       /* Payload size can't be greater than the destination buffer size */
> +       if (payload_size > max_size) {
> +               dev_dbg(dev, "Payload size is too large: %zu\n", payload_size);
> +               return -EINVAL;
> +       }
> +
> +       /* Payload size can't be smaller than the header size */
> +       if (payload_size < header_size) {
> +               dev_dbg(dev, "Payload size is too small: %zu\n", payload_size);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(v4l2_isp_params_validate_buffer_size);
> +
> +int v4l2_isp_params_validate_buffer(struct device *dev, struct vb2_buffer *vb,
> +                                   const struct v4l2_isp_params_buffer *buffer,
> +                                   const struct v4l2_isp_params_block_info *info,
> +                                   size_t num_blocks)
> +{
> +       size_t header_size = offsetof(struct v4l2_isp_params_buffer, data);
> +       size_t payload_size = vb2_get_plane_payload(vb, 0);
> +       size_t block_offset = 0;
> +       size_t buffer_size;
> +
> +       /*
> +        * Currently only the first version of the V4L2 ISP parameters format is
> +        * supported. We accept both V0 and V1 to support existing drivers
> +        * compatible with V4L2 ISP that use either 0 or 1 as their "first
> +        * version" identifiers.
> +        */
> +       if (buffer->version != V4L2_ISP_PARAMS_VERSION_V0 &&
> +           buffer->version != V4L2_ISP_PARAMS_VERSION_V1) {
> +               dev_dbg(dev,
> +                       "Unsupported V4L2 ISP parameters format version: %u\n",
> +                       buffer->version);
> +               return -EINVAL;
> +       }
> +
> +       /* Validate the size reported in the header */
> +       buffer_size = header_size + buffer->data_size;
> +       if (buffer_size != payload_size) {
> +               dev_dbg(dev, "Data size %zu and payload size %zu are different\n",
> +                       buffer_size, payload_size);
> +               return -EINVAL;
> +       }
> +
> +       /* Walk the list of ISP configuration blocks and validate them. */
> +       buffer_size = buffer->data_size;
> +       while (buffer_size >= sizeof(struct v4l2_isp_params_block_header)) {
> +               const struct v4l2_isp_params_block_info *block_info;
> +               const struct v4l2_isp_params_block_header *block;
> +
> +               block = (const struct v4l2_isp_params_block_header *)
> +                       (buffer->data + block_offset);
> +
> +               if (block->type >= num_blocks) {
> +                       dev_dbg(dev,
> +                               "Invalid block type %u at offset %zu\n",
> +                               block->type, block_offset);
> +                       return -EINVAL;
> +               }
> +
> +               if (block->size > buffer_size) {
> +                       dev_dbg(dev, "Premature end of parameters data\n");
> +                       return -EINVAL;
> +               }
> +
> +               /* It's invalid to specify both ENABLE and DISABLE. */
> +               if ((block->flags & (V4L2_ISP_PARAMS_FL_BLOCK_ENABLE |
> +                                    V4L2_ISP_PARAMS_FL_BLOCK_DISABLE)) ==
> +                    (V4L2_ISP_PARAMS_FL_BLOCK_ENABLE |
> +                    V4L2_ISP_PARAMS_FL_BLOCK_DISABLE)) {
> +                       dev_dbg(dev, "Invalid block flags %x at offset %zu\n",
> +                               block->flags, block_offset);
> +                       return -EINVAL;
> +               }
> +
> +               /*
> +                * Match the block reported size against the info provided
> +                * one, but allow the block to only contain the header in
> +                * case it is going to be disabled.
> +                */
> +               block_info = &info[block->type];
> +               if (block->size != block_info->size &&
> +                   (!(block->flags & V4L2_ISP_PARAMS_FL_BLOCK_DISABLE) ||
> +                   block->size != sizeof(*block))) {
> +                       dev_dbg(dev,
> +                               "Invalid block size %u (expected %zu) at offset %zu\n",
> +                               block->size, block_info->size, block_offset);
> +                       return -EINVAL;
> +               }
> +
> +               block_offset += block->size;
> +               buffer_size -= block->size;
> +       }
> +
> +       if (buffer_size) {
> +               dev_dbg(dev, "Unexpected data after the parameters buffer end\n");
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(v4l2_isp_params_validate_buffer);
> diff --git a/include/media/v4l2-isp.h b/include/media/v4l2-isp.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..8b4695663699e7f176384739cf54ed7fa2c578f8
> --- /dev/null
> +++ b/include/media/v4l2-isp.h
> @@ -0,0 +1,91 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Video4Linux2 generic ISP parameters and statistics support
> + *
> + * Copyright (C) 2025 Ideas On Board Oy
> + * Author: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> + */
> +
> +#ifndef _V4L2_ISP_H_
> +#define _V4L2_ISP_H_
> +
> +#include <linux/media/v4l2-isp.h>
> +
> +struct device;
> +struct vb2_buffer;
> +
> +/**
> + * v4l2_isp_params_buffer_size - Calculate size of v4l2_isp_params_buffer
> + * @max_params_size: The total size of the ISP configuration blocks
> + *
> + * Users of the v4l2 extensible parameters will have differing sized data arrays
> + * depending on their specific parameter buffers. Drivers and userspace will
> + * need to be able to calculate the appropriate size of the struct to
> + * accommodate all ISP configuration blocks provided by the platform.
> + * This macro provides a convenient tool for the calculation.
> + */
> +#define v4l2_isp_params_buffer_size(max_params_size) \
> +       (offsetof(struct v4l2_isp_params_buffer, data) + (max_params_size))
> +
> +/**
> + * v4l2_isp_params_validate_buffer_size - Validate a V4L2 ISP buffer sizes
> + * @dev: the driver's device pointer
> + * @vb: the videobuf2 buffer
> + * @max_size: the maximum allowed buffer size
> + *
> + * This function performs validation of the size of a V4L2 ISP parameters buffer
> + * before the driver can access the actual data buffer content.
> + *
> + * After the sizes validation, drivers should copy the buffer content to a
> + * kernel-only memory area to prevent userspace from modifying it,
> + * before completing validation using v4l2_isp_params_validate_buffer().
> + *
> + * The @vb buffer as received from the vb2 .buf_prepare() operation is checked
> + * against @max_size and it's validated to be large enough to accommodate at
> + * least one ISP configuration block.
> + */
> +int v4l2_isp_params_validate_buffer_size(struct device *dev,
> +                                        struct vb2_buffer *vb,
> +                                        size_t max_size);
> +
> +/**
> + * struct v4l2_isp_params_block_info - V4L2 ISP per-block info
> + * @size: the block expected size
> + *
> + * The v4l2_isp_params_block_info collects information of the ISP configuration
> + * blocks for validation purposes. It currently only contains the expected
> + * block size.
> + *
> + * Drivers shall prepare a list of block info, indexed by block type, one for
> + * each supported ISP block and correctly populate them with the expected block
> + * size.
> + */
> +struct v4l2_isp_params_block_info {
> +       size_t size;
> +};
> +
> +/**
> + * v4l2_isp_params_validate_buffer - Validate a V4L2 ISP parameters buffer
> + * @dev: the driver's device pointer
> + * @vb: the videobuf2 buffer
> + * @buffer: the V4L2 ISP parameters buffer
> + * @info: the list of per-block validation info
> + * @num_blocks: the number of blocks
> + *
> + * This function completes the validation of a V4L2 ISP parameters buffer,
> + * verifying each configuration block correctness before the driver can use
> + * them to program the hardware.
> + *
> + * Drivers should use this function after having validated the correctness of
> + * the vb2 buffer sizes by using the v4l2_isp_params_validate_buffer_size()
> + * helper first. Once the buffer size has been validated, drivers should
> + * perform a copy of the user provided buffer into a kernel-only memory buffer
> + * to prevent userspace from modifying its content after it has been submitted
> + * to the driver, and then call this function to complete validation.
> + */
> +int v4l2_isp_params_validate_buffer(struct device *dev, struct vb2_buffer *vb,
> +                                   const struct v4l2_isp_params_buffer *buffer,
> +                                   const struct v4l2_isp_params_block_info *info,
> +                                   size_t num_blocks);
> +
> +#endif /* _V4L2_ISP_H_ */
> 
> --
> 2.51.0
> 


