Return-Path: <linux-kernel+bounces-825269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2B3B8B778
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EF875A7782
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A4F2D3731;
	Fri, 19 Sep 2025 22:24:42 +0000 (UTC)
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020132.outbound.protection.outlook.com [52.101.196.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EA85C96
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758320682; cv=fail; b=cqqpbGS5xzQ8Vm1o3XdrjUcWPo7+vlQTpciM3bY0A7B6fNN/S3bDgm87sdcRAikPJhtu/PtqwCY5StrIk/S1hTFwT3btz9sQecObTtx4AIr2knXgTGviPRxKFb358br8A1FjzxJCuwHcA9oBj7ooMjJWMKDuUq4UKjTUqGnvqwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758320682; c=relaxed/simple;
	bh=7Rz0KyZgzZsA/6/GBR15mSP38XrUVVhUcRQexMt0R8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tmBlxv+6lArEvA4fWU51tnvnGQdPB2Uq3BV/ohpSPkqBELyoz+XZ1YJEjB/LpO4Mt0Ot7oqpJvRIAs285jUV9o9k89adlMRbeFKbHOIj1NZqtiES5QNMRWlcR7MRsHmBzkw64ERJH0KwrXM5aSQnUgRjkWykIVbAASFRgz+qRF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9oJmZHPyfEZA207rHU+v5cJU/8fWf2WE3rdKRz+jkBToY4yCClDQiW/t88sPsB17Xwkbnmm4md7eLgL3wNFh52EILyA4Xb0o+GGtdKW4Iupg3QMv8pD1nUC4IPmtRScXvjBVYPlsl6K0T6vtRc46IqcqsqvcICHM+GxCKqBXfAw7a6rQ8HIxpuA8ZnVk4a0Ekltc4O6fs+9UVmYuXATTXfs6tcg3h0jCTS/V1VT+lqxfR61vLeXMuchOjeFY9QhoKpTMO18Hd5yza+DwouLPUIB8IYe7XbFFvhORhJMh6bkY7RYgtlyuLtfdLAFSlwfuitpOBHhx3UbaOsJ2CYdDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00ZI3tgaKHYH372Ukb25bCM4MqgiNS9ZlII94nKAT5s=;
 b=X/WAw9bTrsNJ+rRcW4Woff05fHHu8H/m4aJVkigFxvUsgD5NlU2O/WN9GygD5fKLwyFCudJLnHkEx+nfwQZ5v3gVfoxdYQVr+KuNZebKsNySnxO7BlfkjW0CfxsZ9gun5UvJ8UN1Ik2qfyUO2Cnm1UdN8g3ucxWWFyGONKp+616tunt23nCMz6flFc6svtUVfS11ewFfIhgzyuhS35QzlidToGUsf7XiDX5tnMG5s9gxhKfJT2TFLiuXr7+uoKFUpIoi2FLNo4TCZrFcHCRRSyeJFtR7cMXOf0K4o1FKu4IBFrfWcIdS3TW+t23khmLOIm3lFIyV3yXdJgJyl+pzIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB6290.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 22:24:35 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 22:24:33 +0000
Date: Fri, 19 Sep 2025 18:24:29 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	shashank.mahadasyam@sony.com, longman@redhat.com, tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Report failed rt migrations to non-root
 cgroup without rt bandwidth under RT_GROUP_SCHED
Message-ID: <w5z36gxgncmsoojht2upexrar7ooybaalg6s3gu4dugmnhvf2k@lqvh7feslsou>
References: <20250916011146.4129696-1-atomlin@atomlin.com>
 <6zi6fp2kgs2hjychav3rrf22qwwskegdq53ew33tfn7rylueik@slugq2khaakw>
 <4nafhr4wqvta5uk4jfuxi7rc7fyaurflrfxa54ajaajy3o57mj@55qzh24m2u6s>
 <3emv4bx2o7mdv7oc72ffdinlltqohqjt5nxgccdiyw47xjgbww@drvkcpiy5zq5>
 <ziakoghx6xbfvcocc5kcrcw5gv4xlphto44bptadkfbbtyf6op@d2fvj7rbec26>
 <d7oxdqxfos3jiuoxckvth2hinhqks65exroxu2lipyopeuiz5c@v7jwxoltx7hf>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7oxdqxfos3jiuoxckvth2hinhqks65exroxu2lipyopeuiz5c@v7jwxoltx7hf>
X-ClientProxiedBy: BN8PR15CA0030.namprd15.prod.outlook.com
 (2603:10b6:408:c0::43) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0d62f2-b925-41c3-e11a-08ddf7cb4f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXJINXdoSG9VWGdaVzRsR1IyOFdPZFhZdFhJcHgxSklOWGtlaWJPem9hOVhK?=
 =?utf-8?B?aklJZUdXZkRZNTAyeU1HN0RDOFdCM3IyU2V6aXlKMHEzdDJPek9yTzQ1M3pu?=
 =?utf-8?B?OFR2THUwRlZpNktxRk5PaHpyRUtwUGlQUUVTM0dVVzFjb2w5aEdLVjUxdEFj?=
 =?utf-8?B?M0JwMFIrR1l5bVdYcmZ3RVppbmhwM0hPeU5vR2NhQkJCSnladElrQnlkS2FG?=
 =?utf-8?B?VTd5blBMbzJORHN1dnZmUWdRdXJrV1M5YUx1UjhtbXowellHK2hyQ0dER0cx?=
 =?utf-8?B?MXFUT0RMQy9iZjk3ZWxZNDF4Y0JvTDJIM1pGZDJNZFUyOEZKbllWOW1aeTVk?=
 =?utf-8?B?aFQwYlpSbEJoTHowWlR6UldCRFVLWStUczZrUFI4UDdzWjhxcVZ0b1pJY01q?=
 =?utf-8?B?MW9jcGNhSDY0YVhXanhkR3lhUXk4V0NvNzJjbGNFZzM1MjE3d0NMaTJmU1M5?=
 =?utf-8?B?ZUYyWU5aTFdpV1h4empmZWtvN3pQTHc3N0MvVndMUWQrREh3aVJyM3h2TWdk?=
 =?utf-8?B?N3EzWVRTTlF0TXhkWk8zeW5IWlNld2E4MFZRWGRiYWZxU0VlRWMrOU9ORXky?=
 =?utf-8?B?SWlFa21qOUFwUHNZOEIyWnppS0FMR0o5cm10SXVSeFQ2WUNBbmttbnFhcys2?=
 =?utf-8?B?emRTUWhFa1Jha3pNVjJOT0dLTkp1eHQ2a1hoNm15Q1gvMEprSHYzYVdBeVlG?=
 =?utf-8?B?ckh6aVArdUMvU0V5WHlCQjRKanpyMXdzNk04SlRqWnMwaHM0UGlCMEdFTGpS?=
 =?utf-8?B?cS8xUUFJcDg0TjY4bFAzSzlXdk83dEkzL2pFNkhJYzZBNXV1YXk3NXNXVTRL?=
 =?utf-8?B?L3pZTmhvYjZRQ3JiZHJaMEYvWFFzLzdjdDRQTVJPamJoYnpoNDVSTGUwYTdv?=
 =?utf-8?B?aU8wa3FvemxPT3pYQkEyUzdrcUFaWVhkWXdIWE1UaktLNFNqVjlLNkF3TXU4?=
 =?utf-8?B?WlpZNVl6NWx4RENlWVBXVU1Wb0xTRytoWHQ0eS81SndNSzU1ZllId3dXRENC?=
 =?utf-8?B?Z1o1S0hVQzdvdVBzeTcxZTZUOVR3YWRNQ0I3eDMrb1hST2I2TWJlMnB1aUJR?=
 =?utf-8?B?TUc5cVpHZkxoZmdnQlg2dUExSi9ZSjFQN0JLc2xscFUrZk1uaXd2d2I0TFVp?=
 =?utf-8?B?SEk2aUQvbkhJN2NZK25PQnpqdkVVV2VrN25XZnorOFFtQzd6WkwzRlg4VHlD?=
 =?utf-8?B?SndxcnpucUNKeEpwS3V1U0hrd3J4YUVnNWdpN3hzNExGUmN5Nk5OeFJJeEJ6?=
 =?utf-8?B?L3JGNXdrNGtYb2kreWREajcrNGJSeTFVdUhqN3czSnhDNlFLY1lJUExPUHpC?=
 =?utf-8?B?a25mcEsvZTMxcXhyY1d0bWZqYWNKRVBMTmpCdmIvTjNZL3haN1lvOWVZODRI?=
 =?utf-8?B?aFJBUzJ1bTB0YjMwQVVPVFpDT3NWSVlWQUlOMFc5Rkp4WG92cFdXeng5Tk5n?=
 =?utf-8?B?WVFhMjZ6aGFQNTc0YjBSMHJPUDdRUnE3enlhbTNpVWxBNS9JYW1lUElmdmV5?=
 =?utf-8?B?UzVEcDZSR1R0d2ZwT0dNMWNZNTZZQVdhbjVSSk4wcFlkeml3WlFOYzRuOHky?=
 =?utf-8?B?SU5IdWN2SG4vSnNiTGVCdWdVUjRUbEdoallGUmMxK3FNalZsV29XTmUwSjMr?=
 =?utf-8?B?UHV0bmVSRU9NVUt1UUZLTnNKOFJvemJOY2wxQ0VpVUR0MlBvUkRMTk5ZQnZr?=
 =?utf-8?B?U2xmVDZ2MDJlZE4rQmdJY0NMK3QvRE4xd2RsQU40VjFjN2IxcWkxeGZVeXBY?=
 =?utf-8?B?Ly83L0xYK2EvTnN5U3dnbElXamVkMy9kb0xDbEQxanA2Z00rQVlGYkdoeU1P?=
 =?utf-8?B?aGdIMVlDMy9aNTRLeW5RTlVuSCtVTmRHOWJGL1AzN0d0SUpQcWVucWFHV3l1?=
 =?utf-8?B?TlpZcndVbXRWbkFUWmMrZ3dDVHV5UHlrTUVKVFVzL0xxZVptVnk2eTFzU2Nr?=
 =?utf-8?Q?ni7avRfyHPU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2tubkNxaGdFSUpQK2lQOGQ1eUVEM00xN3RpeUoveEZqN2pvT0VGUGtSMjVv?=
 =?utf-8?B?ZlNiKzhoSGt6NWl6S0JjbHQvRk40RDVHc25YdXRaVm9COEN3NWw3R2U5d2t1?=
 =?utf-8?B?ald2blB4NXp5MmxvdWN2blR1aGl1ZE5MV0pIVS9wV3BES051NUkwd0dOalov?=
 =?utf-8?B?bmJxRk1Fa2p1c0FtM3JyMG9Fb1gxWTIwUmRHSWhnWWVqTGRiSFdkNkRpNy9B?=
 =?utf-8?B?QkkrVGVGdk51Ny9hVHlMQnBuL0NlSzYyeElrZFpHOWRtSXVXWTF3NDJaTDU2?=
 =?utf-8?B?ckI4UFUxUVFBc2YyTStVcXdYMFBNMFp6S2RwVU5HSmZiSjc2REN6dG5rSFVF?=
 =?utf-8?B?dEQxYnBmK0d4dUtDeHhka2tFZW55QUpDU0Z0TUZVcHFVV2NvcEQ5aXI3ZXpl?=
 =?utf-8?B?TE9QZ1BKaU5taFF0MktPS0l0aTZMVDhJeUxnK3hMeG5vSnN5WU9TanV6YTdZ?=
 =?utf-8?B?dFJuZnhFeUZBQ2lyMjlGemlpbUNxTDlEUmpUK2ZPKzB3K0xjUjN2RSswdGhZ?=
 =?utf-8?B?aVZ4TVdIblZjQmtidEFyVzZTMDZvOG8zamlWU2VMSlNKdjR6ZXh6bGNGYWZ1?=
 =?utf-8?B?ZWsvcnVQQS95UWVwNHhGaElkRjRUTmNiU2JMRXVWRGRHYkxtZVgwOFNVejRV?=
 =?utf-8?B?SjUvWEozQ0djUndtd2tUZTVKSmdxc2YwMWt5L0ZhZFRsVXB3N1FpZVJpd0xB?=
 =?utf-8?B?WXA3OU9SWjFOcUtrV3Y4NGtKMS9wbEJ4NjBJTlNNQnlRbFNhaFBpdk5VSTZP?=
 =?utf-8?B?MUlkTEVJQnRDekpwUXhKNG55UFdZT3JYTDVNckZtZE9YMDFHVW5vU3pQSGhP?=
 =?utf-8?B?MEFTUm1CM0JnaElrbkdUdUFNOTNtZDhRYzFHamwxMURWNFl2MnkvNGlySlI4?=
 =?utf-8?B?M3hkTkFpc253ZVBHZjhQUTd6b2RBbVJMOGhoSjlpT1JEMlhTWExKYjJXVVdB?=
 =?utf-8?B?RUFOdFREOEJnKzBwVTVxWHNBNG1TZ2N6bmJjRFF4Ykl2U2EvTlpvRVJxSnln?=
 =?utf-8?B?TGxHT2RhelZIMW94ZnZDMUJXT09yalozNDdxemMyVXFjNlJmWjJiZEJUdGRy?=
 =?utf-8?B?Qld0WWVlQUpIRzZWYzAzQW9FVTQreTZBb05rbUwyY1NVUXRnTFdRam9hMEl3?=
 =?utf-8?B?Q1RjUVlsT0RUMUN5L3F0R05RS2ROV1FWWmZjZHVyK09DeWxWcDlxbm80N0dp?=
 =?utf-8?B?RTB6L0E3aWxpSTVwbmhUQ1prOE4xK3JVQ0hsbEVUVXVuZUlXalhJc2t6QUZE?=
 =?utf-8?B?Mml1Y2NJMHFKR05OV1dxKzEweVNtWXFyenJSWS9xS280V280Wm9yQ0sxdG5K?=
 =?utf-8?B?WENUWUZMZEJscCtPbmtFWU5GR3Q0LzVCTVMvOTE1ZkFhQkphMmFUeHVLdG41?=
 =?utf-8?B?Z2QrQzN2aW9GQ0xIbGtoSDRTNmE2cHdpVVAwMEJubkVoallJM3VLdkZTSXVG?=
 =?utf-8?B?R1hWekQ5VXZKMVZpakxldkh2OS9lcnlURHZmaHdZNWhQOFhsZkJHR2drVUpC?=
 =?utf-8?B?SEdYY1lTVU43Z2h6bUpqZkozVDBIcFNRVmlRNnpKcTMycTRuTXR0UENwRFhN?=
 =?utf-8?B?NkxFZGZwanNQa3JDbFVCWVZibVltdGRoS21qSy9OclV4eXFOWnZYWTZDQitZ?=
 =?utf-8?B?TkJHamFYZzFFazRSa2RYUUFYT0drQ3VCQWtyWTF5RFVaSVRmSU5SVTlDZmZG?=
 =?utf-8?B?VHhZamwrRFM4K3YyWUJxdUtxRHJWRkc0UmZZdXppcWQzaGp2SGpmR1ptWC82?=
 =?utf-8?B?ZEhWcUtBd1pGYnphbU5udEdFSzZHWFFVcXJvMm0zZ25JQTNWTDZOclREcStT?=
 =?utf-8?B?ZU9tZVBBNHVNU1VCSWN3WjFONXhQdTgrMmtlRkxhNHFxUUtFbGF1bXJZY2Fr?=
 =?utf-8?B?OTUvVCtxQzcrWVNlKzlMdXI4cFNvR2NXYmhTWFo4dTh3MWtBRHhDbFBXQ2g0?=
 =?utf-8?B?cVI0UE1GU3AwRUlneWYxRkFqdS9qbTh6Tmk5OEJIZXFsUmhYTmFNRkxVM1Qv?=
 =?utf-8?B?WEZoZmlXeHFNa0Jyd2VTbEtuTlByc0ZrRVg3UGhzNCtOdEpBOFAyRXZ5VGFO?=
 =?utf-8?B?STN6QlFYOXdUcHZJZ3RUSnByME0ycFovSXJDQlVuYXhhL2pZdVgwajZ6N2VN?=
 =?utf-8?Q?+MjWR+APa6D1Mu4gBD8vPJ17l?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0d62f2-b925-41c3-e11a-08ddf7cb4f12
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 22:24:33.8450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dvCT9RBZzszDTPGjO1CajSJR0BxmjwxnDo0f9+//k/Yqy67PDDBTJDi9tLkkfjGpD5dBPcc6pe1UUN6zrIhEMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6290

On Wed, Sep 17, 2025 at 11:37:37AM +0200, Michal Koutný wrote:
> So I'd primarily suggest you to disable CONFIG_RT_GROUP_SCHED. It seems
> you ran into a situation where you have kernel with
> CONFIG_RT_GROUP_SCHED but userspace that'd like to use cgroup v2 and
> these two are known not get well along. (Alternatively, you may switch
> userspace to v1 if you really really need RT groups.)

Thanks Michal! I initially thought you were suggesting to "normalize" the
RT task in this context (e.g. a simplified version of
__sched_setscheduler()) to allow forward progress so the CPU controller can
be attached. Please ignore.


Kind regards,
-- 
Aaron Tomlin

