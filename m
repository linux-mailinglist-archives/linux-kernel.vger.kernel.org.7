Return-Path: <linux-kernel+bounces-846204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E05BC7458
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 05:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B9A3AEDE9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 03:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D2E221FB2;
	Thu,  9 Oct 2025 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="Nu26ZMW0"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022092.outbound.protection.outlook.com [40.107.75.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635A921FF36;
	Thu,  9 Oct 2025 03:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759979412; cv=fail; b=uef5JwjaI6roLp5pZE1ku79lzsnc3YHWrnJfJQ5W5WI4BbAzaQtL77B7MNA5FHhWt9xKxjA/p8wiMJBbpbfyotqcImy0/MUZ7d4MOKdQ1eRkmYJzy6UTn0+152VMBcsulw0bMi6m/ui249rJlUTqaEzu9a2KUrR8xgIhvkra2u0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759979412; c=relaxed/simple;
	bh=WmiJARq0wwXKi7Jq0+SlrOJHB66rdQsFBWGrpDF1rWI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=atoutY38gNk6Iwb0an3RdARFhRbJzKYfNpkBWBX/Y+X+WTa6g/yz6kwluaKGrKv/vZ0F0+cVCqEe6HSJyvFmEzVAruFC2xc0fFZzWUXPfyeWGqwON44ywmOr+/xqOhpOILvbE9lGFHepfywbrNYgtYmp0GXZRI51JJmwu5Jim3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=Nu26ZMW0; arc=fail smtp.client-ip=40.107.75.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+qpWWEl1dYUW95HdB856a0FWtLZg9IAJUYiSaI5E+4xqzyBjAuILxm2IktFvinNAyP6gYhvix9L/WQk6Yyep5zOwCPJz6N1mbU36SGVJjNazMzH/upMb4HWubM2jommOZ3Ilptk8X0NimS2m5jNzb+B9vXcSGFE0xjAoOaoz9wUbkxa7pd4ScRAuI96zvyASO4yt5aqBbTWcV/Z8rJRMAmNIkxUA0ik6nBCQrS2is42n1mdtuSgNilvs5RoYwrcE6uq3mXYXXnpGPGQcyoVdz6Aua4uyo1BJ3G63hxdNFHNLUs0zQbwcu3Hyn6HpU26qg/8dDa4VPOYdLUHgvjPGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CaaS0u2cQxB3qPzZbea7DZU/CU8srWiTDq/tpDFReo=;
 b=WR9dsDSOPQPvoa93wxP6SyHqvpwnnEXrd1kJ3Qaewf5SU836I7jXb0vg2BPnnpvmjhjtGALUgRaIvGYkyT9x1Tc/ATIeyCIKMNtrc2Xot/8PM6XoDP/ReX/5WwphlSjn6Xn5oUvxkxK1CtMFlll6TOxeVvDTouUeUVYkmRz527P5r61g/R1qSUwrUQ3GtbNmeKLAem1/vGHwBt0G1EVfMqqmll/qQbGzVsEJTStrgu4quOzbt/8Ojxw/fFRUqaB++I57Ye0FgXVCJhqZZ11B038g+sm5Mk6DEG0z7F7ML0229h+MsJtpxdl2Vyyr74t5qBbuutYczHJDN6ZgC+nblA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CaaS0u2cQxB3qPzZbea7DZU/CU8srWiTDq/tpDFReo=;
 b=Nu26ZMW0iegVrBVhUbibKZ6SEb5KfKWOkvVlhTuyVtoaKNxGf6GN38Bun8mt/U/WWAFYtLG0/A3OSr3TGdWRWKGOIaytVmStgrIgwvXz+BEMmgk+8NgVwvw1kQFHZiFG81Kjy+frwsvoFZd5nviclji1/kRUp+DbgWye11O52K3eQdf0FxKYxzro8Ln5LPae81hcIlBlXNp4HQYHnu/A+/3w41cY8XnHeTph6HFth61Ih2JNLcAtYuhZWc3PvAElrJSDrEWHG5dDZz328E4jC3CgtFHb6NkxOpBb1//qjoXZlVQhS6rzG6gkCnv/TTSpJrr/slCz3wSUVZRx0ke/uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by TYSPR03MB7542.apcprd03.prod.outlook.com (2603:1096:400:413::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 03:10:02 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e%5]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 03:10:01 +0000
Message-ID: <b8105d25-112c-4406-9f3a-8fbbd0754b26@amlogic.com>
Date: Thu, 9 Oct 2025 11:09:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] clk: amlogic: Add PLLs and peripheral clocks for A4
 and A5 SoCs
To: Jerome Brunet <jbrunet@baylibre.com>,
 Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
References: <20250930-a4_a5_add_clock_driver-v1-0-a9acf7951589@amlogic.com>
 <1jv7kz3w1p.fsf@starbuckisacylon.baylibre.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <1jv7kz3w1p.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::31)
 To KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|TYSPR03MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: 623a9d38-87a9-4494-c701-08de06e15610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHQzejU5cFlyODFDZ05KQUVKNEpqNW9CMUJCLy9rZTErZEducDdDTXFualVh?=
 =?utf-8?B?OUZoM2ZSLzFHVDR1VDdRZmFZVmNzcmxBL2ZxdDQwYXQrRlNCeHB5OGs4c25o?=
 =?utf-8?B?OFhlQjRrMXJkZDUzUkpFM0wyeHZHY1hET1kwTEV6dlhzcHVmZDBWV2p3VVBQ?=
 =?utf-8?B?RWJlSEl5aXBYRGsvOHFDSUhqNEloK3pBSDFpa0NUL2p3ZGJYeDNnb1huQWFY?=
 =?utf-8?B?YU9tNVlncEx0R2lFd2haSTFBMEhQa2hROUwrZldCZnM5RStFK2p3UHhmTTdO?=
 =?utf-8?B?dVcyQnIrK3V6K0YxUnNlSVQxOEZqclNNb1dQc1JXekhkNzdBdkh4eDdVRmEw?=
 =?utf-8?B?dFgrd2M2aG1qUm1hd0JjbVBUcWNsNlBKRFFZRUxPNFlkTjY5dHA3OTE1NENS?=
 =?utf-8?B?bEFnZlZqbStXRVNSNldFUHRoMVdNTUJlSDBKYUs0WE9jbWFuTHBUNHVYaDdh?=
 =?utf-8?B?QzRjOGpKVXZrZmMzNVNXaFFhR3M1RUtkaHZxWUUzd0hNdUNLekJJeHN5elB4?=
 =?utf-8?B?K0EwcjlCelErcktVVFJ3WDZVa0o2SXFsVGM2YzZ3T2FhQVZwOFhOV3Joc0Ey?=
 =?utf-8?B?QnE5VUhvREE0NkZKVm82SXpZUmh0R2RkODNUWjVlTmdaMHJHdDRoZGZTdVRj?=
 =?utf-8?B?c3FPN0pZTUhZSnNZV0c1clJ0SGRlYi8yUzlpdkZDTmV1YkV4K2hvUGNYdVhH?=
 =?utf-8?B?OE1VcHlSdGoycCtjV0RDQ1B3N0loODQ4K1dacXlDOVYyMVBOQzZRWXhaSTh0?=
 =?utf-8?B?OGQ4aGIxU1hjYk9sQjlsclAyVElST0ZhblpIMm5DWW9ZNjNWZzR6cjhqMUE3?=
 =?utf-8?B?blJvWWQwWitKTFN3WXQ0ZUZqd0QyVCtmSTNvT3JHSEFsaVl6b0UzSFhrSURB?=
 =?utf-8?B?ZVdvc1pvckFNMWtMdklEUGp0RlM5Q21TZkxIMGFuditFZ2RUc0ZlNUExU2Vu?=
 =?utf-8?B?MWVyM3g2ZytCYlU3dE53OWQvejBvcnVRYTFYU0tObFp0RnRrRXVEeEdVTkRD?=
 =?utf-8?B?enFVK1BSR2JQYmlHdkpZMUJrcUY2ZTdKQ2FYNHN5bjhZYVhDSTZ5c0hPbnBs?=
 =?utf-8?B?VVlFSk9XRWo2cGhqZ1RNMHVQNThqSzU0T0hBZlhtcFFQNWxPUVowVkJaNDFv?=
 =?utf-8?B?di9zMUR5Ni9LaUJlNlNjRkJ4dFNtWXFvYThxUEtQOU1UTjJvQlhjWHg5cVZH?=
 =?utf-8?B?ODhtK1pINkxYb2JTemo3L1czZHh5YkN1UlJRSWdreDJSbEZrWEo5QlR3Um5T?=
 =?utf-8?B?SWtVT1ByWUx5K1NVMU9aSDdXZGg0SkxYNjJhOWJTL3NVaGVUMW96UDVwbDRV?=
 =?utf-8?B?QWtXV2F4RkRSTGVVNHljUUI1aVNtTEFMOGoyNHRjRW1jdjE2S0pGT0tMZnpN?=
 =?utf-8?B?bmY2aURwTGhaanpRK2RXbDVGUEZxQklLbXBGUFUyN0FZcWd4S3BHMS9BclJh?=
 =?utf-8?B?dytkc1FMMEdKei8wR0dzb3BkdWdFbVk1NWkxa3VNLy9hYVU4cXBNekMwMk1l?=
 =?utf-8?B?NGprU2hCZGUwZUFRSStzTlFtY1pnMTU4SFdXVUJ5SWRDS1I5YXdiVThYUnpH?=
 =?utf-8?B?QUd4Zm9tdDJTaUV3ZDRJQy9pK0JBaVpUbUNuTmRSdnpwSFUwK0ZkMHdaZWJH?=
 =?utf-8?B?dzJualRIY3cySmY3a2dGSU9veVlpV1JSMVBiWGhtUEhDNEJEU3czVDFzbi81?=
 =?utf-8?B?M1NrTDJWS2dYcHM2c0xFdnIrRkFuZUl4OW0rU3JUMUZhUlByRU1tTHV5TjhE?=
 =?utf-8?B?YzlQUUt1SUdtM2pnNUtGSzBmV3AxOG5xc2Izay9kLzhsVjZUU3hXbzZiSWJO?=
 =?utf-8?B?QVZ1aWV1blFaa2JkelRocmlXQVRJQlhwbWV2bXVSaVEvMWJyWGxDSzU3K0Rt?=
 =?utf-8?B?VEs2RGRJa0hKdXpNdGFjKzk0Y0RXQktZcURJT0VNMjR1ZE4vY2o4UnpmMFNv?=
 =?utf-8?Q?fY4+fLKZheeRYLUEhaWv05la45v5w/ay?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmFYSUVEemk5OXZUaTk3eVhpOW5DcHdmUnJWSDdtSGlvK3JtWmNqT2Q1REpB?=
 =?utf-8?B?TkpjWWUxN2pRM0tDZ3F1Z2pkZWxLeEdzeDNWN0VkaVlOSFJYWkF0MXk1RTAv?=
 =?utf-8?B?MC9LSXRENFJPL2taWGMrd0JZWVFqVXJNWVh5T1BZS3BxY1V0ZExUTnNkNVZ5?=
 =?utf-8?B?QlFpSWhZQjcvV0Y3clZ6VmtGOVZKOElueVFJRVdWeXlHeFoxWEMzZmMwMEhE?=
 =?utf-8?B?OGtHZStTVXhFbW9kNUdPNS9pNG1lYjl6YnhMUGYyNVo5NU9tdzZXKzkzeFk1?=
 =?utf-8?B?ODl0UXdzM0dqNzR5Ky85ZFhjeTZWek01NDFWR3lGTFVvUDZqdmpMd05DbEJK?=
 =?utf-8?B?UVRKYkxLYXB0dzVheFhka3lvL3p1M2I1Tmt0YjBydzJMK1cyWXQ1U08yYnBq?=
 =?utf-8?B?UlZPTkN4Ukdldm1mazhjaUUyeWdLYytEcThSQU1ndWtkcEMzUHhtWDFZc3ln?=
 =?utf-8?B?bVpEWXQ4UVgxSU9UNHFiZHlBR2tkYkcrb1l3b1Z3eWlNekwxeTIvbTZyekdS?=
 =?utf-8?B?clkxcC9Sa0hac1k3WlE4VlpEbFl2K2FrOU1hY09Xcjg3SXRydWZTaWdkN2l1?=
 =?utf-8?B?TWFTc3ZJVUZ3M2hMekhwZW9qVmp0UHJ0UGlDc0RXYnc4SXpEY0pXMFdyVjN0?=
 =?utf-8?B?WHZkSjJXN0Vpd2FOUlIwN2QvQUxYUFRyRm5BaHhyNE1XeTlVR0Y1VGV3S0t4?=
 =?utf-8?B?WS91MjZ1WGc5RWVkZW9rUGxqQXZxd0ZrN1l5aUs0VUNzMWZLeHpIUUF6ZUlF?=
 =?utf-8?B?R2tmQmFUN0k3cDlVeEs4TmtjMjVDU04vYkRFY0Z2QmdjSWt4TlE2MVZQcHkx?=
 =?utf-8?B?bW1jcm1XVE5NUEU5aEJOWUVITDNROXArVEJzbnpDb1hocXUzby9Ra1NuWkZo?=
 =?utf-8?B?NExlQ2pJelJTWWJvWW9TQnBYaUtvQzVhMDk4Z1kxblN1SGVxVnNoZTQyUHhR?=
 =?utf-8?B?bGhtSHEwSUJjYUJ0Yk9keEdYMzJ3QkNnWFFTOGdUcmI1RC9FOFhIQWdJVDFu?=
 =?utf-8?B?eDlQL2tDME80ZGtmZnRCYUQ4YW1BYzJkMG80Wk94UkROS2NHMlE5WS9FS3ZR?=
 =?utf-8?B?RDlPYmFJSlZnbmZOT3BBZk1EZFZCSW5lR013NHpCQmJPa3pDWTIwWHczWk1h?=
 =?utf-8?B?d1R0MkhEUWk0d1FJRVhOS1NJa3dmYUZlZnFQSjhONWRVZUttanhQSnVGMUhK?=
 =?utf-8?B?bE1hVVhTb0Q1cFdqZkdibGR1eWEza20rNnMyaGgxV01PamltY1JBZ21aSFRx?=
 =?utf-8?B?b3V3ZXoxUTFFdmE1WkR1anNLWkl0aWE1OWhhYjRjYnR5dno1WS90emFMNzdJ?=
 =?utf-8?B?UlBraFIwS2NqVTZXTnBWOTR1azI4dnpLWERlc1RuZThRdThBYWZQL0lXWmFn?=
 =?utf-8?B?ZUJyY0lGZStzdmlraU5ybWxraG91bTN5Y0FiMkpNYmtNQTN4bHhhNUZJSGZq?=
 =?utf-8?B?dW5OUHdqTjBWcllSNDl2SXdmTDQ2TXdCS05jbkd5QW9KZ0UwY1c2UDBxTUd4?=
 =?utf-8?B?eHB1QTJldGhFd09Vc0Mzak5oTVUyL2Iwa2ZSM0FPVWtoWlBjVVFFVElVNVJT?=
 =?utf-8?B?SURaeldlS3FUcitxSjQwVDhVRlVnRGdYU29hTFp3cGwrNVQrRzFWNVBlWkYv?=
 =?utf-8?B?TmtEMzd2KzZ4THFRVjZMelJ0MnhOR0lPaDlham9KaEZsYkVGT0FEZTdadTc4?=
 =?utf-8?B?RU50UWJIdnRTUnZLemJPT2hzM0x2V3g4ajFsaEFsMk15Rmo1aU5EZ2NqbXVp?=
 =?utf-8?B?YTRCZjBKNllvdlBja1c2ZjJrUUhFQjZmYXRiR1lsZWtJeEhhUVY1SG9qVlNO?=
 =?utf-8?B?ODNaMU5JemZTUXZpVnRaNXJDblpzeWNma1dyVllJcEtySFNmWlhvYkYycGN0?=
 =?utf-8?B?S2IrUWpVUzV4MmRJSVVLUklNYzJXa0lnWmxLeEJhMkQxdjJ5NkVGRDZLL2Z3?=
 =?utf-8?B?Und2c3hRV2xVb0V6UHE4RnN3cjdyQ0sveFRoWW1QS0dLMFFub1c1LzRsTzdw?=
 =?utf-8?B?ZDV2OEpIdjIweW1Zazc2d0dpZHZFMVhRLzF3SkNTWVN4OWJBOUtWM2NmZDh6?=
 =?utf-8?B?dVNxM3V1Z2F4MXEvSmVXdURYeHFITmNmRVEzNVdhRlByMkhSbE5naUQ0SEFR?=
 =?utf-8?Q?7MDQs7PlBkpBDd0VFziRVrGbM?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 623a9d38-87a9-4494-c701-08de06e15610
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 03:10:01.7373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3W1EVupv0PX2jzZgq0d8W8oxOt+jIloWyfxfRqhsk+91HAwDjqUjSrYFxPI34AWoiPxsDPIzOyH+VALEz50iow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7542

Hi Jerome,

     Thanks for your review, because the national day holidays did not
timely feedback.


On 10/1/2025 3:45 PM, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
>
> On Tue 30 Sep 2025 at 17:37, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>
>> This patch series includes changes related to the PLL and peripheral
>> clocks for both the A4 and A5 SoCs.
>>
>> The patches for A5 were previously submitted up to V3 by Xianwei.
>> https://lore.kernel.org/all/20250103-a5-clk-v3-0-a207ce83b9e9@amlogic.com/
>> After friendly coordination, I’ve taken over and continued the
>> submission as part of this series. The dt-bindings patch retains Rob's
>> original "Reviewed-by" tag, and I hope this hasn’t caused any
>> additional confusion.
> ... and yet you restart the versioning of the series making it harder
> for people to follow that


Sorry for the inconvenience caused. The main changes compared to the
previous version by Xianwei are in the driver part.

The dt-bindings part only has minor modifications in [PATCH 14/19].

The driver part has relatively larger changes because it needs to be
based on the code base you previously submitted.


>> Both A4 and A5 belong to the Audio series. Judging by their names, one
>> might assume that A5 is an upgrade to A4, but in fact, A5 was released
>> a year earlier than A4.
>>
>> Since there are differences in the PLLs and peripheral clocks between
>> the A4 and A5 SoCs (especially the PLL), and taking into account factors
>> such as memory footprint and maintainability, this series does not
>> attempt to merge the two into a shared driver as was done for
>> G12A/G12B/SM1.
> ... and we end up with 19 patches series while it could be splitted into
> manageable series, for each controller of each SoC


I'm not sure if I understood you correctly.

Do you mean that I should split this series of 19 patches into multiple
patch series and send them separately? For example:
serie 1: A4 SCMI clock controller (dt-bindings)
serie 2: A4 PLL clock controller (dt-bindings, driver, dts)
serie 3: A4 peripherals clock controller (dt-bindings, driver, dts)
... A5 similarly?


>> This patch series includes all related dt-bindings, driver, and dts
>> changes for the PLLs and peripheral clocks. Following our past convention
>> for clock-related submissions, the dts changes are placed at the end
>> and submitted separately. If this ordering makes it harder for
>> maintainers to review or pick patches, please feel free to point it out.
>>
>> Co-developed-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>> ---
>> Chuan Liu (19):
>>        dt-bindings: clock: Add Amlogic A4 SCMI clock controller
>>        dt-bindings: clock: Add Amlogic A4 PLL clock controller
>>        dt-bindings: clock: Add Amlogic A4 peripherals clock controller
>>        clk: amlogic: Optimize PLL enable timing
>>        clk: amlogic: Correct l_detect bit control
>>        clk: amlogic: Fix out-of-range PLL frequency setting
>>        clk: amlogic: Add A4 PLL clock controller driver
>>        clk: amlogic: Add A4 clock peripherals controller driver
>>        arm64: dts: amlogic: A4: Add scmi-clk node
>>        arm64: dts: amlogic: A4: Add PLL controller node
>>        arm64: dts: amlogic: A4: Add peripherals clock controller node
>>        dt-bindings: clock: Add Amlogic A5 SCMI clock controller support
>>        dt-bindings: clock: Add Amlogic A5 PLL clock controller
>>        dt-bindings: clock: Add Amlogic A5 peripherals clock controller
>>        clk: amlogic: Add A5 PLL clock controller driver
>>        clk: amlogic: Add A5 clock peripherals controller driver
>>        arm64: dts: amlogic: A5: Add scmi-clk node
>>        arm64: dts: amlogic: A5: Add PLL controller node
>>        arm64: dts: amlogic: A5: Add peripheral clock controller node
>>
>>   .../clock/amlogic,a4-peripherals-clkc.yaml         | 122 +++
>>   .../bindings/clock/amlogic,a4-pll-clkc.yaml        |  61 ++
>>   .../clock/amlogic,a5-peripherals-clkc.yaml         | 134 ++++
>>   .../bindings/clock/amlogic,a5-pll-clkc.yaml        |  63 ++
>>   arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        |  80 ++
>>   arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi        |  87 ++
>>   drivers/clk/meson/Kconfig                          |  53 ++
>>   drivers/clk/meson/Makefile                         |   4 +
>>   drivers/clk/meson/a1-pll.c                         |   1 +
>>   drivers/clk/meson/a4-peripherals.c                 | 764 ++++++++++++++++++
>>   drivers/clk/meson/a4-pll.c                         | 242 ++++++
>>   drivers/clk/meson/a5-peripherals.c                 | 883 +++++++++++++++++++++
>>   drivers/clk/meson/a5-pll.c                         | 476 +++++++++++
>>   drivers/clk/meson/clk-pll.c                        |  76 +-
>>   drivers/clk/meson/clk-pll.h                        |   2 +
>>   .../clock/amlogic,a4-peripherals-clkc.h            | 129 +++
>>   include/dt-bindings/clock/amlogic,a4-pll-clkc.h    |  15 +
>>   include/dt-bindings/clock/amlogic,a4-scmi-clkc.h   |  42 +
>>   .../clock/amlogic,a5-peripherals-clkc.h            | 132 +++
>>   include/dt-bindings/clock/amlogic,a5-pll-clkc.h    |  24 +
>>   include/dt-bindings/clock/amlogic,a5-scmi-clkc.h   |  44 +
>>   21 files changed, 3406 insertions(+), 28 deletions(-)
>> ---
>> base-commit: 01f3a6d1d59b8e25a6de243b0d73075cf0415eaf
>> change-id: 20250928-a4_a5_add_clock_driver-2b7c9d695633
>>
>> Best regards,
> --
> Jerome

