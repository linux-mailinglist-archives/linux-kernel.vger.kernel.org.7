Return-Path: <linux-kernel+bounces-765817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 965AFB23EA9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 04:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA82188FDA1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 02:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1DF26FA5E;
	Wed, 13 Aug 2025 02:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ItYjvSHZ"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98251369B4;
	Wed, 13 Aug 2025 02:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755053801; cv=fail; b=pXQiYxxW8BRWsHLDzhglm+XtTY7eCEYR9nWqBV9UnlAAt50Gs+5KA15pcKtk7dHhlQ/XOv88MFai2OSZmmoLTN2zcHmzxL8dpmNpjh00ggfj5XdDSN5DHWtj04HjgGYxuSHcuPt8RFbltlfBukS7/VkgIWvr0krcAkeUip+UPcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755053801; c=relaxed/simple;
	bh=lnZ0ATkBzBCTQeiz3o6NAxN445MXaTkbGXiQieYxJk0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=VBzuZfGx20CoKhHmvkMhXmFLBr7H3Fpnhykrk7VapjUTuolq0Xb2oEz4zkCEP1Z1KVSwVilCLzz1YZ91VlAqW/p+M8LWUWDTBCoo+zZSt4VQcn6eSRzqYKcwpb1Mb3bscmsY4BsmO1FWroh7Ke8V4/SHI5NmTvXWG/+UgnD3tKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ItYjvSHZ; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcXN1vXTmrBm2hEjCXxuouDO8IoxxtJ/mPJHF5yry/cw4LYLMOuJOeCFS40gl4lUpPgMGHEl46C4b7Bfe0QOTfbC12NmuipJNwkQWKjF6G0J5vHdERYl6jVxDTAvfz6aYDDnYZgOg8iLmxE+pktCvMYk22ZG9ujIsgRQcnkyBLPZhyrO7hnm5JEwK+e9caVMkALnoAwAqrJOVZcHDKH1t+OhOdQIORVNicSP3t07SPtZhtdgEgzq5I+qZWhT7eDeQwgnqEh3wCgd5SCLS6RTMEgNDJ5QEa/GeoQVGMUo31b8t8jgdv/pT8a3mBq3NNBycwuRPje2ZrVa1vOSz0YODw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMKaNQFGyLGvpnki1Ngk05wpQBrmcmUKmrcqAeMMAWE=;
 b=bow20mGSrKeBU2ccqubPAukDdeTq5PwLL2xKlw5RDxu5SQWod5m7NK6MzcKP7bJM6xUSh6frJ5W8ItA1RV+LS7jgunPhyKvk+SIT5QMv+ZWQZFKPE5jdelOgrASCIJsBlxvm5vjmxDpmbrws6tKkUbw+Zi4rdYqdEFAi5VtZUEl3tGDYuNDM7zXd/8sCTU73wfvHzd8x05E+VoDNXydTy8eQ7ncAL5gc3/ULZ3Wlf3qw/mrD0NRnRhkTspwsWimISJ76EoCcLZ74zufjsgZw+xR/vdH1hz0l2Imti6sD9YtCO5Y1LjXVAfYx185aflvUNVD3frWCb1nRMnhD2rQEQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMKaNQFGyLGvpnki1Ngk05wpQBrmcmUKmrcqAeMMAWE=;
 b=ItYjvSHZ0OzNJAznDczZ+qLQxcwJhrkyzFsQggQ/bd+xyORnmj0eX9CboDeLdsse50ZRdQLGwSbUXZ/aWB+mW4vriLCnwGT44YDUfbYJBMiLT1Jl5rj/7AxHged1VBPlbP3pojWlnfpLmYxYjZmUE2MUxhBusuvKxVxY4apWP7WKZmBMfFww30w1ajaJpwBFgu9osJ7arOEqleR51XhFLMgTy1/O7Gqyq3OZLoWrDWbpGYnz6sh1FbSzltGPt+EUYKt6MHUCuk/Sd+96ZwWyy3TNQ3u/5FPetgGAnktMoDeD9eNv5VE6gl9+rFWL0fv1TDHwPSFcfzVqSKk7drYNxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by DS5PPF5E0E7945E.namprd12.prod.outlook.com (2603:10b6:f:fc00::650) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 13 Aug
 2025 02:56:33 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::d161:329:fdd3:e316]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::d161:329:fdd3:e316%5]) with mapi id 15.20.9009.018; Wed, 13 Aug 2025
 02:56:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 11:56:26 +0900
Message-Id: <DC0YN6WQFUQY.3PKYK23ESRJQL@nvidia.com>
Cc: <aliceryhl@google.com>, <anna-maria@linutronix.de>,
 <bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>, <dakr@kernel.org>,
 <frederic@kernel.org>, <gary@garyguo.net>, <jstultz@google.com>,
 <linux-kernel@vger.kernel.org>, <lossin@kernel.org>, <lyude@redhat.com>,
 <rust-for-linux@vger.kernel.org>, <sboyd@kernel.org>, <tglx@linutronix.de>,
 <tmgross@umich.edu>, <daniel.almeida@collabora.com>, "Fiona Behrens"
 <me@kloenk.dev>
Subject: Re: [PATCH v1 2/2] rust: Add read_poll_timeout functions
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>, <a.hindborg@kernel.org>,
 <alex.gaynor@gmail.com>, <ojeda@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250811041039.3231548-1-fujita.tomonori@gmail.com>
 <20250811041039.3231548-3-fujita.tomonori@gmail.com>
In-Reply-To: <20250811041039.3231548-3-fujita.tomonori@gmail.com>
X-ClientProxiedBy: TYCPR01CA0125.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::7) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|DS5PPF5E0E7945E:EE_
X-MS-Office365-Filtering-Correlation-Id: a3da916b-52e4-43a7-2d2f-08ddda1500e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDEwa05XMk10RVROak03dWVNdHdKSGZ5MWl1YVNKb1lBempINHl5MFpzTzEx?=
 =?utf-8?B?QjlMTXNxQmk4cmRYeUFIUHVIYnN6MEJ3OTdhS2Z5T1ZMS3FaOUxqem9rNWh1?=
 =?utf-8?B?SGQrQ25oVDhHYnREd1BFSE90YU9Da2FvUUdoL09FU2haVVhvditrdmNIUHdD?=
 =?utf-8?B?ZFVxNUNnL0NsNE9EbEl1WDQvV2FDdHQrRGMzVGlhVFg4TkRXYlMyL1Y3RGs3?=
 =?utf-8?B?TTlsMjFMeWNmNWZMeDlrU0swOU5yR1JOZnd2RzZIQ3R1bjNZd1dDUzdPYnFq?=
 =?utf-8?B?Q0VWZnpJR2tna3BqQkYzcUtkU1NFUW1pOWkrajI2MkdHV0p0cVVsZExpN2kw?=
 =?utf-8?B?WTVHMkZhVTdhMzlJa2VJbHpJcjdrckswRHFSSnMveWNqYjRuTDVleXIxMk5T?=
 =?utf-8?B?elZFd1Jrb0g1QlBVUjI4SzhzWW9EK1lPc3gwQU8zUEp4QlBQZmZzMXlBVzNq?=
 =?utf-8?B?cm1jMFg5VVYrZnl6eVc2TEErVk9UNktjQndUTnNRSmNjR1p6MjhZUklmT1B3?=
 =?utf-8?B?bTNadUEzbm1OcmFzSE1RbVRVTmNwT0FaZ1dZSUUraFgxaDE2bU1pT3Q1L2x2?=
 =?utf-8?B?RFdWcWJPQjVxdERrS1FDUThGc0hxNzFkR3k0d0VjeFErSU91M1ByYUpGUXYz?=
 =?utf-8?B?ZUgrZkZKaEtLekJDdlhYaU5Qc1Z1Q2orUDBmYVNlZ0I3aWZ0bnViU1g1RmxF?=
 =?utf-8?B?L2plTmxSNVV2bGM5KzZWYUwyaEFqZ1JlQTNzd1AxS0RpRkF0MUJVcWYvMU1z?=
 =?utf-8?B?bW4yREVNazZoUGVpSGVJd0tyeGZwaWpCalAyLzA1MzVKZGg3VVZLVE44WjJD?=
 =?utf-8?B?aHAweGpDVE0rZWZhMzVNWnVtZFF2cy9wRHg1Qk03WTRNQVlxc1lUVTRQUEIw?=
 =?utf-8?B?ODMzaGNBeDlnTEEzYTR4cXdEMVBqdkJPRS93NU5ZVk9TMksxNWE2OWJxWncx?=
 =?utf-8?B?cVNTTHlSY3A1YTRyNHdLS2NPdjI1anZ6ZmFBb3cwQTY5Z3NhaFlxR0xuOXpK?=
 =?utf-8?B?L0M0YVIvWFdhdXRIbjE3QmhRQ3VqK05maGdJZG8xV2R1Q2RBNUpyZ1B5cGtn?=
 =?utf-8?B?bFhEc21KbE15SFRFeUR3VFpFY2dZTFRzSWs4RUNiN3Q1Y2ZMbmxBRnNnb0R5?=
 =?utf-8?B?L1R4VmZHOG1lZlFsMS9NYjJXQldlcGw0ekc0VVVEL09oOTN0QjZjZlpSbnVk?=
 =?utf-8?B?U2Y1YTRVQ0Q5QlZObmtkTGpxN2NsaFZoTncySnhIZGlKR04rNkV3dTJCN2Zp?=
 =?utf-8?B?Wm03b0FTRSsxTkMzVzVhc3F6UDVJa1Q3ZXNLRWxjVDRUUnZNN2d2UDdOb0Nv?=
 =?utf-8?B?aHdBMEFJdTkwVE1OSkwrME9HUXZ2amV4Q3ZPMGNUVmpFNVBoVXQwbWtmeVd3?=
 =?utf-8?B?a1RPeEtVeWZVeTI0cXZOUUFYSUswaHpoL09qNzJRcGR1OEhGOEdiM1Q3SVFV?=
 =?utf-8?B?bWlQbXd2MXltNkV1bXBrdy85c0RzdFpPSGxBRFVrbTlPR1NkbjBveGp2QWxu?=
 =?utf-8?B?bnV5ODZXK3k0R3A3NDBCcTZqeDRMbCt0UnRTM1R3VG9sYmVmdE9jUmc0OXVU?=
 =?utf-8?B?SmtvMVVZQnZtbTlSNzJIQTJSZ2VBNnlJTTA2VnZEejZxRUNMamp2MEhibnFD?=
 =?utf-8?B?Q2o2bTNvVlpoNlNEbDhjRytva29paGp3eFRLMlZlVTh6TGRZOXV6UE4vVnox?=
 =?utf-8?B?aDg4WlJ1YmV2blNsYVk1RWxlUjVObXE1WkhiRmx6TEpkbWZxRWtBaEprVzVn?=
 =?utf-8?B?NXBzR2FUeWdxbnhjWm44RTJXMDBlYzFUdWdZQnRnYzdaZnY5b0F3aG5jYXhv?=
 =?utf-8?B?TXhWTjd6UE5iVHlyMUxONUFnU01jSEVKU0JZYUF3YXBQblMxM1BmbEhHU1F2?=
 =?utf-8?B?U0ZkZldRdmpVZTR3NDlaT21DZFBTL1N5YzJBTUxNWGZOTmdFOXQrblNhZ1ln?=
 =?utf-8?Q?ze4ynrar0lw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3997.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUJ2WG5VZjZSR1RMM1JZd1FhTGxOMUhiYVJTWjY5OHJvSFQ1RkpRUjRKbWF6?=
 =?utf-8?B?QjBJd0d1UUlxcTI2bDJ3MjJhUXdvOTNYMEVMUnNWN0NJbWppZEVZYktYdEVL?=
 =?utf-8?B?ZTZRWWtSODlyTjV4VHlLNjNNeDJIT1VjVHhpaDZhMzVvbmwrWERBVnk5N0JG?=
 =?utf-8?B?M0dRemU5aW1GMlBNMExra3RoWWMzZ3E1dlNYYTJESU1HS3lmL3dIUnhZSk5h?=
 =?utf-8?B?SGRRVXVheFF0ZnJDMi9meW9aVmRENFRRU0JNbFhGMGk3cjNiK3pmbnVhYXA1?=
 =?utf-8?B?QTl3VHpVNlJoV2RBVFpCWjB3blplVEZ4TndKWEtIaXQvSzNtbFNld1lXaWZh?=
 =?utf-8?B?QTY1RFBzVGRaMGZtNWZuMmhwdEx1UHNmcHd0Yyt1dTFyUFd5dGFBWnRyb3JF?=
 =?utf-8?B?bUg1dEFpSEFickJSMnJET045V2ZFLzlvWDBtRlJvQzRpVlNBR3gzd0VtYjBX?=
 =?utf-8?B?aDR3S0FCWkxCRXJyZm5aYVpwUDl2V1F5RGU5eFFBU0p0a1pWb3pabFR0VFVi?=
 =?utf-8?B?V1hxUE04UGZOMEp5UWxETTZDalhkaE9rMTJpK2tTZDJNSTZKa1hDYllvT3Vv?=
 =?utf-8?B?SVo4TjZmUjN5ZmtmcjkvWU1iQlhzL1luMHp2c0NtZnBJTHdsTEtvSHFuNGQv?=
 =?utf-8?B?THovcUU3bVdjcFBHcy8xQ2tueXdIM2RvcmllQitiQWJBUlBvYytpNFdxOHhU?=
 =?utf-8?B?M1EvTFpzd0Q4TmM3Z2FHV0hxZmIvTXU5QVlMaGZ4SFgrK21jV0toY0pHekFJ?=
 =?utf-8?B?K08rcFhVcTVSTkpySFRKWDdkNEE0MXp0b3lmTkxYL3YxM0s2WmNLVHZtQ2cz?=
 =?utf-8?B?VXZTSFlOc2NlOStiajFDQzJwSWlkTXRlaEpQR2FhUEtmdGlweTVhL1N0MFVN?=
 =?utf-8?B?Tms2SkhVWVJRNGJEVHhVMmtCRUEzRjZEMlJ5enN4cWpDRlo2bWQvL25EMjlV?=
 =?utf-8?B?TXV3Z1dzQ0hjM2E3cWhXanR5Sm4ranZwU1JPREl0N3NPNmNCYnBsMlJtM0tP?=
 =?utf-8?B?UGw0cE82ejZRSkpPcW83Y05uc0YyN3hnUWJ3aXh4cDFjOFVnSlpEcjF4Ukxo?=
 =?utf-8?B?NzFiZDBEcDVuZ0VkVTFqTzVzMGoxcHczSFRtZnU0c0hUK1RlZzI4WDFheWlS?=
 =?utf-8?B?cTJLR3NwRURMUXlLZ2F0RXBYU0llWU5lazFuMDA4SWdiNGp4K1lLZmxubFFp?=
 =?utf-8?B?c3Nmc0ZvSHN3M2Yxc3NqL0JpY0dPR3dHMDdWZ0s0a2xjSmhBbTg2cHlBMWlS?=
 =?utf-8?B?cDdaNHdzb1F3Z1M3OWQvWlBWNlVidDNXRzRaR2o1SHlIMmg5NWlkMldWNEox?=
 =?utf-8?B?MUFmYmJCNll4S0J1RE1CZ3dIc1Z2Skk0SHB2T3RJc0FXeWZ0WUhwNkdXU0F2?=
 =?utf-8?B?OThZb20vR0h6ckczdi9zN1RSd2NlZjZ6b3BTSGhGQ09WakRReFdSOWp4cEk0?=
 =?utf-8?B?Qm5QT2JqT3RwTFBGV0IwSm1mczhwS0U1SzEzdFJJblBDNUh0elFYR0RVMVZs?=
 =?utf-8?B?TWRNeDdpcTMyRWEvWDFBRHczQ2tnU2gwcFRBNFhIU2tVMXhkcHBqTzd1QUZV?=
 =?utf-8?B?cmlHOEFKSFdURG5leEd6SVovNHpIYzVnMzdGNGhMbDdDbU1oWDZQTk9VRjVJ?=
 =?utf-8?B?bGNPQUtGZUhTMGlEa0FxMmIzTHZWcmw5dkhndzE1ZVYxRkxXKzJZOGlJRmtk?=
 =?utf-8?B?dmRyM0xOZFhGOTVxQUpDYTZoZUMzMXErWHVTUFNCTGJiU2YxSHNQblZiYmIz?=
 =?utf-8?B?b2Q0WTI4OWtqaDAzcVZDR1hsTFB3c0lOWldRK2wrTER2eEhPOCtoZ29FUHoy?=
 =?utf-8?B?eS8zSmp1YXJ6V3RIN1dFRXN2bEovOHNHZmlFUzE0bmk5U1RaV1UvaVRPVmhF?=
 =?utf-8?B?MWlmY0x0Ym5La0VCNmR1Z3hCaDF2RURvY2F1MURBNUl6WTV3QS9mYW1TbXkw?=
 =?utf-8?B?N3ZmQ3d0VzJtVUFlemNqUUQzZmg3VGU1Wjk1NkY1M2huUXoxRnVaaVVqdXhD?=
 =?utf-8?B?b2wzVzZRTHU5WnBvYm15N016QVlIVmNIWTN6ZTJQcGtjS0E4bi9PTCswZFNj?=
 =?utf-8?B?cXV4dnRmODBUQlkzdjc1anoycGFXdmZSTm1JaVJlTVg3OU9CSStnd290OHhU?=
 =?utf-8?B?dnQ0VXBsRFltY1htaHRSMnZJL0Q1U1lVUk91MHprUjZmZ1RKK0h3UWFhQnJU?=
 =?utf-8?Q?+cOB9OvG24uk8tEEhjMPfhcZHBQWZHY5BSjQ5YDihOo7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3da916b-52e4-43a7-2d2f-08ddda1500e6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 02:56:32.1222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VrvfQ8J/tDLzm7tyA8Farr0OR0DabqCutWwDSUSfQhdglt0LTf4BzW/FzPHG1Tw5UtB/1mBkr2jussK9K/+Omw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5E0E7945E

On Mon Aug 11, 2025 at 1:10 PM JST, FUJITA Tomonori wrote:
> Add read_poll_timeout functions which poll periodically until a

"functions" should be the singular "function" as this patch only adds
one function.

<snip>
> +/// # Examples
> +///
> +/// ```no_run
> +/// use kernel::io::Io;
> +/// use kernel::time::{poll::read_poll_timeout, Delta};
> +///
> +/// const HW_READY: u16 =3D 0x01;
> +///
> +/// fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> Result<()>=
 {
> +///     // The `op` closure reads the value of a specific status registe=
r.
> +///     let op =3D || -> Result<u16> { io.try_read16(0x1000) };
> +///
> +///     // The `cond` closure takes a reference to the value returned by=
 `op`
> +///     // and checks whether the hardware is ready.
> +///     let cond =3D |val: &u16| *val =3D=3D HW_READY;
> +///
> +///     match read_poll_timeout(op, cond, Delta::from_millis(50), Some(D=
elta::from_secs(3))) {

Is there a reason for not writing the closures directly inline? I.e.

  match read_poll_timeout(
      // The `op` closure reads the value of a specific status register.
      || io.try_read16(0x1000),
      // The `cond` closure takes a reference to the value returned by `op`
      // and checks whether the hardware is ready.
      |val| *val =3D=3D HW_READY,
      Delta::from_millis(50),
      Some(Delta::from_secs(3))
  )

I think it is closer to how people will actually use this function, and
the expected types for the closures are available right in the function
definition if they need more details.

