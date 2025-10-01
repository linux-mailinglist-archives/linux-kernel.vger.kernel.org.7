Return-Path: <linux-kernel+bounces-839576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17460BB1F18
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 00:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57374814F9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 22:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4701F3126CB;
	Wed,  1 Oct 2025 22:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OjpquT6V"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9C32D3EF1;
	Wed,  1 Oct 2025 22:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759356485; cv=fail; b=SsuhXEB9JDpk1qBHuT22/hex1O71m8hFHr9OnA0ScUCTUp3RM9Ho31/eIfqjatb95VmluNDFByyd9nMpvJ1OIbQHtOuT1Nwu3ZQIu6BPsbrHttgefF3ANT7FP5mzo9m//3Dnpjz15vWhKRwQxPm909RT0ahL7g/NPWKY8dRYWzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759356485; c=relaxed/simple;
	bh=nYajsfrGUmoqKvRzXCx5ngUNlzboG62Uma3pRv8E688=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WGykBdRHVppOzd9jvgXD0uTw2f+wPf/0KS0mzAthXr0vl0BMcU/XMiPpyemE5vqviwU0IHrX2YB4f2RWUlb2cDVvfHkaH2Q+JxuUuAuKt9xY+urprmz2cC0jr2JJJktJi8vJDM1L3eeO6bnQE8dQ9S8yqT1IYabaeSBiVX6673M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OjpquT6V; arc=fail smtp.client-ip=52.101.43.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDLLpd1xggcpIxq14/SQ80v0N/nehwHDxTTKB+QCpF+qAsSXUIx9Tq+D1wQVMe9S3Q2Sb69P0VK+CROT5sN5AGjDH274183iBHP+AkGH4wSsb5+GNYOewnfbNjXwepoOzVAGDigE7/BvC1oGFySM77ATaYq/rQVLKHefZSX1/lAaLCFwwEelc1cPiJHqKRXPC7RS4kfPSFCN1qjw+I5sLdUKK25yrtgPPq+wgMsEaqAdOfoUtHkbb+bi+R62tAZZIU1qrpS+TaXEiZjFTi6YL7oP0+P0b/gz37kEZw+aWAQ7XQQoBme8NYkgCDn3Ie7P1t8p4lh7KI+0MLM5lVinrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10ZN7oHvWQ3Srd4b/3G6dRF3/lyRwtjjgzCl6j9MZfg=;
 b=o9+5rA/czL1zT9NyD4F6onikwwdCRCGtE3gJW0dXdzLeMJDMT8o4Iwo4d2rMheuc7Pe+WW0YBi6laToMs/+OEn4h8XEBlaX/TL9bvBToGg0Ip9of+tt4vD8VOZ+dBbwNpG5HVs2cMoQ0mTzHQjeUSEz0RCgirYxuy/ZaETjIzURs0yOfaqQ5jA2crM6KgJe15/FLtABwIV18jtaE4WvpSkqoZiIMyIQLknxOEfjMgX8jn7peps+zQHcX8o4CLjcQ+yjeh7wDRoVGsWy3hg8kYaw0T3Q8bJobQJjYDTqiZkLrMov2+oy9EZtJcfhf/HAWEwF183LkIKE0iVmAi3JpVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10ZN7oHvWQ3Srd4b/3G6dRF3/lyRwtjjgzCl6j9MZfg=;
 b=OjpquT6V9waHt+Q6zzbzFJUjKKOjLh2DLM/fV/Hi7seg7E9JW39i/YKZHedyGnrfwK3jT13KH6L6f9NmMytfFxSxZkBrLuupj6DTDAbCHgsv1XXiewP4QqnhjHexCxkE+ssMd4XwiFyUnbIJfgIeeJ/n92hDCU9YmROB1zKsL3x/Z/aKnoPTJb0bCv1MhVR1+rc3K6PI1l387RnsW0rqXCfT7acoLY5drV1LQlnRV3+mvwzHeQZmF7DzmaHzGO5HUPtP4UfROgae9leoQ5ZWhiTSf0QovRMyxO+xzzFrWpXuuRqZ54Oo3PwWYJaXbTaD02MN8dOdFJe9TKJR4TcG5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS0PR12MB7558.namprd12.prod.outlook.com (2603:10b6:8:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 22:08:01 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 22:08:01 +0000
Message-ID: <6d4b5659-7c0e-4720-8305-5b0053807443@nvidia.com>
Date: Wed, 1 Oct 2025 18:07:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] rust: bounded integer types and use in register
 macro
To: Alexandre Courbot <acourbot@nvidia.com>, Yury Norov
 <yury.norov@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251002-bounded_ints-v1-0-dd60f5804ea4@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20251002-bounded_ints-v1-0-dd60f5804ea4@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0093.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::8) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS0PR12MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: 05cd7623-c4ac-434f-2363-08de0136fca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTBiRWdIOXVaWDdOcXVZcWhWRGpWbHJiQnluTHVRb2ExVG1PSCtCWUtLYkZv?=
 =?utf-8?B?RHp6MEx6K1ZrdWZLZERzbnNUd24zL0R2aUZITGREU0VkZW9EYkJtOW92OHFw?=
 =?utf-8?B?dmtVVFg2VmJWSHZaT0oxZnoxcEphOEdVdTZmMWU4R2dYKzdEV2ZyendGQzg5?=
 =?utf-8?B?eVJxSGZPREwrdE8yUmx5eUxqSUloSmU3Y0dBNEpOTGdtczhNcWorSTkvOVFH?=
 =?utf-8?B?TE1mYzF3ZFBBMXJFc3RKMlRTY2JtUDNEOHprbFFIWTBITXZDU2FudUVFL2hm?=
 =?utf-8?B?aHhyV3JBNmFRS1Y1bTRJUEVvSEk1ckZYSC9GeElsQ2twN1kyKzZsa1RneEIx?=
 =?utf-8?B?MDdMTlFrbkE0VkpGOWphQW9IVmZkT1gzbXZmVUZML2JvcEtpTklSL3pxcWRs?=
 =?utf-8?B?T2lHL1dOQW9Cd2t4eFp1NHk0R3Y5TjRLS1JiT0xYZTVGU0gyeW5hTi9uekRO?=
 =?utf-8?B?MFZzU3cvQ1E0N2VCYW5RdFE1SjlsMldUMFFqS2NUaWJQN3ZrNXB2Y25YTXAz?=
 =?utf-8?B?Mjd5dmNQZ3RUTkk5M3k1MGh5ejVwKzBHNkl5VjlhZXZ0RnBtM2p4NXZ6dzdq?=
 =?utf-8?B?UmpJOEs4R3ZMSkZIVWdXR2h3QWs0MjZRbHEranpFRlJKdXdIRzErV09ocUVF?=
 =?utf-8?B?OE4zS0ppVStFRERNclVTWEdRek1vaWl4TjZnbmc4WU1vMExLNXpuZkNEM1po?=
 =?utf-8?B?ZjU3R09mbGtESHl4NUxCMWVaTW1IS3U1N0szQjFoVE93bGZ3Nk5sUXBwbi9P?=
 =?utf-8?B?NFJyZXdab0xSMWI1QW9JTlVTeS95aWw5VXgvUkVGUWRPL3l6bnF4WjlCT0Fx?=
 =?utf-8?B?QmIyVHFyY0FsSUlYOHJma0w5bVRZbE9wUFVYQWdlZW96VGo5MjYxWHhtL1N4?=
 =?utf-8?B?VWx6UnpIMmxTcW5jbHZmbDVqTEEwbGp2cVBudTJiRTJIK2JxbnJPUjBYbUY3?=
 =?utf-8?B?UmVwYzhuVWZpblZ6b1hVb1czNUJDcm9nSUQrNW1ES1ZoS2VCQ2svWkRYUHc1?=
 =?utf-8?B?RUlEN0hMWHVoUnRjQnpnL0UrVHdZL2lZWCtZNEoyZmQxNUcwYTBENUJMVWZY?=
 =?utf-8?B?NndJMnlOZVNHckxKNGZXMVJzWmVxTk9lQmZIazVxL3BKRC9XUVNFMERzajg2?=
 =?utf-8?B?dnRDL1JPekhzTWF3dEtWT3ZCR21NYTlmL2tPRUxCSDdCZWZIeGplNkk3QjEr?=
 =?utf-8?B?QXkraU5VTTVwa2x2REx0RTNyQ2pOUEx6S04xSlFXZ1B2RU5uYzEvT0VGUjU5?=
 =?utf-8?B?R0FiWHpTdEhkNTBHNXY5RFRXSnhQYmNuVjhPTVBFMHhna0pYd0o4T25OSDFS?=
 =?utf-8?B?YTYrMWdvRUZjWGhSZkdPeURZdFc1aXpqSmkxWTBrK0FQOGU0K3NZeldWeFJV?=
 =?utf-8?B?a3B6am1FdUhHWTJFS2FwR0ZtdUJjK0NoRG1WVDBPOWxkRzhiSFhBQWZHbXhT?=
 =?utf-8?B?eHVEbkVVWTlBU1hXR2kxM3UyY2EvYlJMbm0wbi92NkJFSE5mOHNIZUlKVnJz?=
 =?utf-8?B?bjlWend6K05Pd0hSeVIvb1g0U0REbVdyZWx2MXJjRWNRcFNUSEwyREhET1Z3?=
 =?utf-8?B?RUV3VERzckhXdzF4eDBiUS9DNzVuUndDd3N2MitnQ2k5ODU1N3dTWHYvMDZ0?=
 =?utf-8?B?UFVTcmZLc1QyNDc3Z3E3dzFrVjBXYjB2R3RqVnBURnQ3WkU3ZTZoeWd5KzF6?=
 =?utf-8?B?UlNNenl4NHprTjNzNm1kbUVScTNKdUVmVGcwYVZoNHE0OXRwd0UxZ3J0Ujcx?=
 =?utf-8?B?QzBNbG9FOHZvZkdlQi9QR3lQQzdhTHJaTERQYmlFS3FlelJRTkNWU1NxQ3BV?=
 =?utf-8?B?QnlZR3pCWk5WUkxBUkF0OTVNVDBueUlIY1dqUHBLNGNLQUczMThqZzFkMjQv?=
 =?utf-8?B?Q3JUemVHWm84Mmc0UmFpcG9oTldqWXB2QWZ6VGEwRi9zV2paTzhUUGp6dVQ2?=
 =?utf-8?Q?aY7zmyMRLTkddJC+9IYPH1B3BxxMkr6/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDRPa1MzVUpaKy9NOEdLUjduWlhkSlVrdjNsSStPWm5WVkFtL2pzN3lGQTQr?=
 =?utf-8?B?VE9OdjF0YS80TEN4bklxeXJxRDUzMmNPNmlmSmxlWnlwYjMxa2MrVjlZa0Ru?=
 =?utf-8?B?eFZGSktRVGEzYzk1UTl5aTRCTjBYVXBzZ3AzVU83T2JGbE9kczFIbDEvZjlR?=
 =?utf-8?B?eGtBbTZIL0JHek1tOU5JWWdpL2JEbXpkUEdUYWlBcUdhYVpsbFdtbHlXNXAz?=
 =?utf-8?B?VHBGc0s0UGxkd05SN05pUTkyVXBGTWJBcjAyS2gzamhXTndHc3d3N2U4MDdK?=
 =?utf-8?B?cy9jWWlVZCtpMnc2eEkrRHg0dGlPZWdPbktreVZLazdmb0NDT2t6eGJNS0hK?=
 =?utf-8?B?dmF0aTZuYVljcFdSTUJEdHFBOE55bTIzd1dJMTlyZWVLTWtHVDVXVjdjaG1O?=
 =?utf-8?B?TG82UlR1emZlNUpZd3ZmelkrREtxNmM5SEdVcXY1dHh2TzV3K3RhMndzOWNy?=
 =?utf-8?B?TEZYWDVGcXY0WkF6bjRHaWo3eXNaS3RYVVBGalJXTFZoeGZBME5IRE5reWZ2?=
 =?utf-8?B?U1E1L0U0Nk9GV0wvR3JHNnVnQkNNQVRZeGRkclJIQnRuQlhlTTA3T0NhVFVY?=
 =?utf-8?B?RHE1Z1htSDhRdFJLK1RpU2NsRXBmTFdodm5EZ3NHN0RDS2hmWU1xT3F6dmxv?=
 =?utf-8?B?a2Y2K2R0TG00RllZbGlJcTRIMUVQTTB2T2taRjUzUnBOb1hyU0lUcGVFNEtT?=
 =?utf-8?B?SEN2QWtHTjhYVGE3dUwvYkZHQmVpTVRUMlpVZE5UUVczczZOWWFjTFN0d3Ja?=
 =?utf-8?B?N1NVbmlmTjZ6VzJZZVZyTXVHVXBoZGM3Q3lRZFpPZG95UnpSMkVhenhXNUpt?=
 =?utf-8?B?ZXlCVVJxVnNuSHNkQnlTazdNY1dsUzF1Mldna2VPTjdJSzEyQjVBRExqSGtC?=
 =?utf-8?B?TVVYYitjdWlQazloOFZ1UWRRWWlGRUlMcWl3eWZKZy9lV2lHeHRydk1UbENE?=
 =?utf-8?B?SWJKWHM4WXdJNFlXS2tlZC94K1pDNW42UnI1d2J3S1ZNdnMzSVo4cER6dWNW?=
 =?utf-8?B?UFM4dUs4Z3ZJQjh0d0x3U1d6R2hQUHR6dTdvUlRYY2NaTmZobThjc3c1QzBU?=
 =?utf-8?B?WHdlVGJCUUcyU05KVllQQnlwVWt2RzVtZ0ZEWnBqSE9pRUp3WUN1TEZ3MFY5?=
 =?utf-8?B?dnpDbDZHNXBXemJrR0hoZkVtdVB6ZitiQk55ZTNXYldJOU15MXRPV2tJMGFp?=
 =?utf-8?B?RkZzY3YzZUptdUxyQmpUMk9wUEFZUGxNTDhwTUQ5RDlNVk1jbDVrUmw2bURC?=
 =?utf-8?B?MTBabFpwNG9hQ0cvc0Fva3d3SDhEbFovRHJveHI5Uno2U0h6THM2WlBwVEU0?=
 =?utf-8?B?ekZZQWhhamlrZC9ZYUovQ2lmM20yWFBDZFBvdkQ2OW15dlpIV2R4OVBhVHN0?=
 =?utf-8?B?M2NMcEk1TGVmbllnQ1p6cFBWNTVGMUorR2pQM1huS1pvZ3lvMGNUemFCOC8r?=
 =?utf-8?B?d1BGK0Nac0FZOFk4MWZHODlYejFHUVlJVEIrZzdUOW1rMEVwZkxvNUFESHRj?=
 =?utf-8?B?OTdMVFUwTmpyVWNLYjVPb3B1Qnh0ZHJZcGpMM1kzNU9ha05nQm9VYS9lZ1ZC?=
 =?utf-8?B?R0FoVXVKa2RSa1EyTHpJUU9peHRSb1lwNkwveE8zOE13RStGZDh2dHIzcUVY?=
 =?utf-8?B?WVhmVlk2K1hDeFZ1TjhuTXp2S2J6N0hzK0M0U29XaHV6dnhUck82M3lkSm9D?=
 =?utf-8?B?cXRYcStWWmsvVDBpRUFzQ0FlQVJJT0JUZDZRRS9PaEZYRTJGS3hhb2hEd0do?=
 =?utf-8?B?eHh6bUo5SmZYMlNoZXRLRHVUME5MU3hrQ0dKZjd6NmcvVkJyNkEzUGE4Unk1?=
 =?utf-8?B?QVlMeUF6ZTZna0p4NFpTdW1XZytYQ3Y4RHcyU2JxSmt4ZWxZWE5OWWlJczZZ?=
 =?utf-8?B?M3pNc0ZsYjNQK3N0MERZOWVheWNzNytZZzlGUzI5UzBuZWJjMTU4VitxWVIz?=
 =?utf-8?B?blVhUkhoS1hqOVpwSTgzMi9SczdSTEJWM0J1ZEMvVmpySFNMQjRVcnJmOUdV?=
 =?utf-8?B?SjV5QWdIR0VsSmRiT3NjajhBc2hkOVhOelNPakYvbjZWMmhzQzJ4N3RsVjgx?=
 =?utf-8?B?WmNTemJra2p4SVdhOG5RNkt3TXkxOW1xVmE5bHJKcFdHakpHMmJUTjV2MW5N?=
 =?utf-8?Q?XzmZkB5dQ8dbTvzYpA48hccmS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05cd7623-c4ac-434f-2363-08de0136fca3
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 22:08:01.4056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QT3BKQDykrXjiU3KR3CwOBfgPkrSTavXiuJEFGSF3PWDIw8n+fOrFwcctnjjlXU9as9IZKI386NCc5gH/Q0K7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7558

Hi Alex,

Nice!

On 10/1/2025 11:03 AM, Alexandre Courbot wrote:
> For convenience, this PoC is based on drm-rust-next. If we decide to
> proceed with it, we would do it after the patchset extracting and moving
> the bitfield logic [3] lands, as the two would conflict heavily.

I would strongly prefer this as well, to avoid conflicts. On initial look, this
seems to be in the right direction and solves the pain points we were seeing.

-            .set_sec(if sec { 1 } else { 0 });
+            .set_sec_bounded(BoundedInt::new(if sec { 1 } else { 0 }));

Here, I would prefer if we did not add _bounded, since the idea is to solve the
problems in the macro's setters itself (make it infallible, not panicking etc).
So we can just modify those?

Also, BoundedInt sounds like a good name to me IMO.

Also, since TryFrom trait is implemented in the first patch, then in nova we can
just do the following?
  .set_foo(value.try_into()?);

That's slightly simpler to read than:
  .set_foo(BoundedInt::try_from(value)?);

And closer to the old syntax of
  .set_foo(value); // used to truncate

But I don't feel strongly about not using the full form version.

thanks,

 - Joel


