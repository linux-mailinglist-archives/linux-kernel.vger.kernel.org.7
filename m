Return-Path: <linux-kernel+bounces-873274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B8BC138DE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0AD64ED41F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BCE257842;
	Tue, 28 Oct 2025 08:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lwOxF1AI"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012006.outbound.protection.outlook.com [40.93.195.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA40C264A65
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761640333; cv=fail; b=eu1eK/lT8JBY4DGmjxZwhgH77+RTO+c15wpyEzcqbQ/6Z3ZygJlh7NSM28cShRYB9lFoNDnP3sVgCWCfYk2bD6YxZoitn21oAqYq7B9xRIMnPRU4NjFGrJ6zrAr4EvXpF39Pxfaw0/2aNkzHQCiuVKZeFh2y+NTDWXBqvmWU2h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761640333; c=relaxed/simple;
	bh=4s6v5BfP1sNRpyAstElHrWu3dklWraG/6nU1Q+UGEn8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=drDpt//nY+eHoxeHryenU8T70AURQG4M2Dc1++GKlD+aWKJCkq6yiNrhuvGpLqj2VsvjMYv4w9xgGrICa3Kik5sJ2v6yWj9tQ3GzRmsgHmCoA20gKb9NoLtPnyZKNAvmPi4JcUYpLY+3TobvSw/x49It0KFw6oHO7A8lB7ExV9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lwOxF1AI; arc=fail smtp.client-ip=40.93.195.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wsvJllNH4OJXLA1b53MI/D3mtcKKGXIR94LkqWOe1rTi8OBGbXED4C1ObfrVeR/LIO9RDlE7t06EVzDQoUPjKQOfziVDkkv86JGZkgWQ6qt7sOwmIzBYVl2Q/meVy+Xsi6GavVUREPnIuXen9fkaXGFcu4uGPO1FlyFhwUvibg+SSQw6BhEL1IGL0bwufDKp/zOyFpkO1VvH9bBdJWOccCRd41ErE5lM0+H+AM5Sg0pZc4/ZjR3LGhAxkSUB2TTam0xhZUHg9sqsp+enmZ1NopGmFlxT8XaAsKArZ0uFHqrehlewP/gZycDYFiNNFmABbeBiM1WvFtaWJsGPc6ngsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5dio2kSRN8jZHu49K4UbZcCy8jf47zneCf02j545WY=;
 b=DfPCzCG55/jGRb3gZ2/2iRdwit4z3uat/DttiOZ7m6ccUp2DKCra5TJxVS5bib40uO4BASfjpHRWUY2zNEGgNryJU23Oxtj43W9e/pf3IWZW16kjPRHWGf1SEEqwmTPytFyhyTeFRixQwodJ/lkB8aKnh2E84kg9XUN9I/yb92HUYjhpVd3goZ2WjpkIOeIQbYSvv1Ec3fytCEO58f+hc7IC5ZXUrpZrrxvVgkgOCzrVOfDVAuSXPLhANWss6jEoRJaUyrM1GyMLVyuGayKGxyp5Hf9ltF2pkus5GBlKccw8H6+u8VHNm17IlgLQBjRW4L1IzB3hwNMcynkBV/EE9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5dio2kSRN8jZHu49K4UbZcCy8jf47zneCf02j545WY=;
 b=lwOxF1AIKX064DV7hTY7smsiNuXt0Yh1/tQ0qoZsK6uCLr85dwCrr2BYvQNuXGWCgqDUaqCAualXCGdr284UufHlmFgadK+TvIWWVVVgGkq9SlJadY4zPill8toboMVouV3Vp6cILYaJcfaQi/Q3GjiPvthD3dZXQ8UZ/sS9Hfo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB6237.namprd12.prod.outlook.com (2603:10b6:8:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 08:32:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 08:32:08 +0000
Message-ID: <5deb806b-4bd0-47c9-a8ba-868cd4c9dfd4@amd.com>
Date: Tue, 28 Oct 2025 09:32:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: x86: Disable SSE4A
To: Arisu Tachibana <arisu.tachibana@miraclelinux.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 Leyvi Rose <leyvirose@gmail.com>, Samuel Holland
 <samuel.holland@sifive.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 lkml <linux-kernel@vger.kernel.org>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
References: <20251027114059.GJ3245006@noisy.programming.kicks-ass.net>
 <20251027124049.GAaP9oUaUtzzHUK4j4@fat_crate.local>
 <CANgtXuN-grBSdVfhtZ0xBk8pWyh6tUiMtAWOaPHBApQ3wrUy6w@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CANgtXuN-grBSdVfhtZ0xBk8pWyh6tUiMtAWOaPHBApQ3wrUy6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b7f4fdf-0698-4a7c-0822-08de15fc7bc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkxSdU96N0pxcHdiaVMxVFFrR1B1bmxiRmw1MEpMenJJRk5hU3VjWG9nMU94?=
 =?utf-8?B?T3R3VzVWdXJybVlIR055d2UybmpLd2dTUmdSL0Z4R1Z4bzBZSFVHbmRwZDZk?=
 =?utf-8?B?a25NTDk5cEFNNktQZkt2NHNzandUSnM5S1ArNUcwMFRSSEpkbVdIMjNSUWNa?=
 =?utf-8?B?VXBoOCtSWi9ISDYvQXZuZDRaUDhHR2hrblJ5OHphdGNVbXVmT3RZZjA5Qkc3?=
 =?utf-8?B?RURCTEZLRTJqM0JRSjA3SjZZLzdub0xYWHA4N2QreTlzVjQ1ZC9WUUVrOWZH?=
 =?utf-8?B?a1ZCOWtTQTdVeFZ3bHB3VTgzZEt2UmRvdnhmL21QaVBFN25lSUlSYlY3TDIy?=
 =?utf-8?B?cTBLUUY2MzdNK1krZU93K2lLRTlpemQ4dVR1SHlYUWNBN0dLU1RlM1dvTTNo?=
 =?utf-8?B?UTdGZmxva2dBNmUyeTRxTGU5ZHJVZTNWQ3V3ckJLREtiZFkxR3pyMlRFcUJT?=
 =?utf-8?B?OHZZUUpQRTFQODNBNEtQRDdLd0dhWXlwcHNPQzBhRmxMMXppUE1SMHExazZj?=
 =?utf-8?B?WUl5NFNMYVREbE50NkpobTJyWUNoaE02OUM4ZzUzbE5zUmJQaWNOMG0wQVdO?=
 =?utf-8?B?OWlSRGtZMVBjd3JQZmlSMkJ1T1lLc3hIU3J4ZU5FSy9WaHU5ZElnQkUveDdB?=
 =?utf-8?B?ak9hWUxYY2o2RU9tOWx0Rit3eTE2UDNTNHRkVzNrU0pvUHM4TGc0WkpjaGZs?=
 =?utf-8?B?NDRhd3BUMmZ2emkzcDFlKzV5bkx4UGpEN1l5aVVzeXlHS0V5TEp2aUlpRWli?=
 =?utf-8?B?bkcwVlJDbGI4K2dCa3NrWGtKRTBSY1ZmTzVzVnVnWlJObmd5bDVMQVNub0wx?=
 =?utf-8?B?T2Nkdm01Y3JwazI1Sy9FbVFFM1E2L05mSWMrbWdrTHFSNjdENFBSSHJhQi9l?=
 =?utf-8?B?dHR6NDJBTTVPd2plZjJHTmZqWU5EV1FrMDhDK2tvbHJuQWR4RFN4RWRKYlNF?=
 =?utf-8?B?QzZRbmZqam5DWWh2VERZc3liM2U4YWZnRHJ3VzJSSFA5RGsvT3ZPK2ZuVWdz?=
 =?utf-8?B?TTVkeWk1Q2lmMVNsYWQxd2ZsMk5zN2pFSGVYNjQveFdvRnFhZHFSRkJxUXcx?=
 =?utf-8?B?eXFRb2Y4Ty9JeUJ4U2lVV3NXM2xRaXorUTFXVmRhWUtRNE5TUXBva0w3S1Fn?=
 =?utf-8?B?V3RjcGlsTFZVR1JwRFJGVjZ2RWNpWDMycFRMeG5PZWhJdkRKOStnRVh1NFM4?=
 =?utf-8?B?eThkVVUzNXBzVFAzejBjNnpLR2xwQXlIa3p5V0V5U2wxYlp1VXpyRnd5dnUy?=
 =?utf-8?B?SHFZaHBNMlZNWFFTd1hYbTk0QmlIQVlzaGJyWGN4ZDJIbFhmZGxUWW9NVVdo?=
 =?utf-8?B?dVJ4R003R0k3N1NDenJTMU8yMzRlRVdVQ1g5YTFWamNIVHJWRkhaS1puMGhY?=
 =?utf-8?B?S3RqT3V0MG5tNE5aNC9vYUlRY1Nma3ZsK1Q0RlZ2ZndSWk9qVmFRZzNOZGlq?=
 =?utf-8?B?ZEpkZmFldGhwMzBsc3dCenNmRk11SXpXc3RCcDEyN0Fzb0s4czlzVStKSVdm?=
 =?utf-8?B?V3RJZFVkRmc4cEFSQmM5N3pLdVFMOHN1M3pXakwyeFA4aHROemJlNW5MaHlV?=
 =?utf-8?B?K0xSNFVqUEVSTXNQTGlNR0pSbUsxNVFTMlV4THFVTkpWTTY5d1E5Y0VycDk5?=
 =?utf-8?B?VFQ2QXYrSjA4NUszN1ZhSzB1dHdGdmVDWC9jc1d4U2R5aHQ5eGZsQjNFR2x2?=
 =?utf-8?B?ckxJTmR4U29jWXBHNWcxNHV1MHBnNnhlZlNNVGJZOUZINFZFM1BBRXUzVWpk?=
 =?utf-8?B?YTNJSzdBK3YvZUJlRGE3bS94Rmd5TldXTi9rdlppU29sblpudVVzWldnemtW?=
 =?utf-8?B?TWtnUitjaElXbXp5ZGlyY2FzeDdla3NBZFhpM0M1TWt3L1FVOTVoWE5HSW80?=
 =?utf-8?B?RlNBZ0FaK1c3UU9OVVAxNGxaa205cWo5cDc1S1NXYysxWlBUejFVOTQ2Y044?=
 =?utf-8?B?UnFtWVE4UGttblRlSjYrWVk0aW1FcEV4bllXTGR6NFdJSEhWalg1L3lkVUJn?=
 =?utf-8?B?UzhsUnV1S3hBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aE00ZDIyWWQxcDVJNXlVdW5TWmRhQ1JGdWpVaWk3MEdxaEdNZG9wQS9xVHhO?=
 =?utf-8?B?MnZUZDhxWkFMRWNUWm1WOFhtNWVZYWhZR01uNE1QN0l2NjRGbzNtTExiazFR?=
 =?utf-8?B?YTB1Y3dia3dwSEpQUS9HamNocm50dlVrR1F3ckJwZlZkdGJMQjFjTFgrMUla?=
 =?utf-8?B?RGdYaTNLMWR2a3d4UGJUYSt6MXM2WFdXeEZkdmFUWXMxYlFRcW11TFJ1bVdT?=
 =?utf-8?B?dVBQWjZweWdUK25Mdm9EOUx2ZEUzaFZMWThGRE12V1FES2w5RGRmanFlcEI5?=
 =?utf-8?B?SWJSNzRESzd3WkNOYmVad2plSnc2V0ZGMHB0TzlHTDRGdTczSDdlSDV2WHRV?=
 =?utf-8?B?MXFOT1ZVZFdhMUVDYm91YzZibXpBRkNPc0t0amErV001N0RIMko0QXlYL3Yr?=
 =?utf-8?B?ekIyUmh5aVROVzFuK3ZuYXk2eUp5aUo0R0ZRSG4vVFlDbEJNYjc4NURnczQ4?=
 =?utf-8?B?UzNNTVYrVFp4S3l5bnJvNXNUa3NQYzFnaFI5dDdoNVQ4MUxLVVU0M09ESnNP?=
 =?utf-8?B?NW1jMzFhQ2VvRDA0a053WXJrQ3RQZ2d5dGY5OHJEQW1zV3RRVWJhNjQwS20v?=
 =?utf-8?B?OTNVWFMybDhVeTRmRHNsbjFKYjFPY2tOT0JPMTVHa2ZSMEFtQmM1RGZrWmNi?=
 =?utf-8?B?K3ZHWnlzdFlNc2NvMTN5YVBTTVhiMkVZS1Y3T1p1dTJDV2Z5U3JETHJLb0x0?=
 =?utf-8?B?LzVCbWZMSVJiU2lUK1hmcmV5RmVRMVVhOE5PTGxTcDlRRzQ1cU96M2VzNXZw?=
 =?utf-8?B?elRUMmN4VXpJeFIvVGs3amV0Sk1ZUERLR2Ezbkx5dm5LK2ZvVEIybXBNODNP?=
 =?utf-8?B?ayt6RFFNRFh6cDdsNVRrY00vWEZ2WXVzWFJ4UlgxamhzeWpyVU5Rb0dFcmd5?=
 =?utf-8?B?bWN6T3QzbmVEa3QzQWJnbHA5SlJuUGZtNFpNZlFSSi96UkZHT1kwSUs5N3c3?=
 =?utf-8?B?VFplVzVCWnpRZUQ0cGJSSUt4S2NWbW1Bb0dyZWRRcVVIUSthazJQVkNUNUJ5?=
 =?utf-8?B?dnJpd21FbDlBNERFK1UwYjdMYzRSRTVkNkdoNFVPWTNuRXFFTjhKQ2tHUzcx?=
 =?utf-8?B?TnZxNm05VDgvL1JNejJKSEpVMXhGYWtXM2ZYNE9RM0RKb1RMb2Q4OXVyVVNP?=
 =?utf-8?B?cXc0cXNIMHlMcEM1N0RlME1nYkpKVGF5eTFMYjBlVEZ3YnFXMDVIL2lENS9u?=
 =?utf-8?B?dEY2UkZIVlVnclVpaGkzbDE3d3E1YkxZUU1BL3RWQnJwa1czZlBIanduRHR3?=
 =?utf-8?B?QXB4d2xxRGNWMkdpVzRFUEpDc2c0VEd3VVlrcGFUYUF5bEVmOWpUakMvcXpO?=
 =?utf-8?B?SHlkTnQ0QnpZbzRvamljWmF5NTEzb3IyVEZ6OE9pNUtBVVJLd1hQNnRkWWM1?=
 =?utf-8?B?WGlBQ25KelExdTQwRzZ3Nkx4VFRIa2JZdG1wSW13L3ZkUWdLQzJKWXppTE9N?=
 =?utf-8?B?WlFuU2RZZmRCOXNwZDF4ZmNCaGZET3FiNTZPVmxIUHhvN1dXQlh0T2t0OFZE?=
 =?utf-8?B?VFRhZngwU1hKT2c1TEdqRDhaZ1lBZzBEUy9zRUMzazY5N0JIRVZXUEc5Z0wy?=
 =?utf-8?B?VGhwNGtBSVY1K29HK0NvcUcrRmlyeDh3ZFp4bnhYM1I1d1l0WVdNdk1ValY4?=
 =?utf-8?B?d05VclUrZVJzaFZ2Sm4wcWJ1bk1MN3M0TGJFN1NVSGp6Nk9QRjczSFJsblBk?=
 =?utf-8?B?bHp6MUhvdTNnVi9vQ25EeUMvT0dJZkhCa3oxbUhtVkUzaytsVVlDTGN0eFp6?=
 =?utf-8?B?T21PSnorYUZLdHFucFUyWVNZY3IyaDFYUkJIamdzY2FxS2dmMXMzMk01Ryts?=
 =?utf-8?B?WWxyVGxwaEtTZXMvRmd6d2Y1NmxWKzhvd2VTbzNKOHNVaUdLK2Z6MmNGY251?=
 =?utf-8?B?TWVzUUQ3ajVCaCtvdUNieGRYTTlmQ1liZzJ6N2wrU3l5Yk9WMUNWc1l6enJR?=
 =?utf-8?B?Qy9LanNsSGJLOVRTdDRldGpoZmNaUzVHZ00xQnZ1UWh6emlKQjZvaXdzamFi?=
 =?utf-8?B?em1Sdkc5NFQ0bnd0dlRHL3NWOFIxV0kyMHFOcFNVWGVaSHhZakFEUXhib1Nm?=
 =?utf-8?B?MUZCS2VXQ2k5UUV1Q1E4emhuSGF0aW1DRFp0emxXaDVrbDNhU1dGNnFGK1Z6?=
 =?utf-8?Q?KYfF0S4ZszCxtjTdk7CnR50vv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7f4fdf-0698-4a7c-0822-08de15fc7bc0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 08:32:08.7435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+7s6vyv/KR4IdCv5XLbmb5ykfwRHKq4T5jzrDSW9Zd6Hbfrh6INTsvlsy6Cx+30
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6237

Adding AMDs DC people (the component which enables FPU in amdgpu) on CC.

On 10/28/25 05:19, Arisu Tachibana wrote:
> On Mon, Oct 27, 2025 at 9:41 PM Borislav Petkov <bp@alien8.de> wrote:
>>
>> On Mon, Oct 27, 2025 at 12:40:59PM +0100, Peter Zijlstra wrote:
>>> Leyvi Rose reported that his X86_NATIVE_CPU=y build is failing because
>>> our instruction decoder doesn't support SSE4A and the AMDGPU code seems
>>> to be generating those with his compiler of choice (CLANG+LTO).
>>>
>>> Now, our normal build flags disable SSE MMX SSE2 3DNOW AVX, but then
>>> CC_FLAGS_FPU re-enable SSE SSE2.
>>>
>>> Since nothing mentions SSE3 or SSE4, I'm assuming that -msse (or its
>>> negative) control all SSE variants -- but why then explicitly enumerate
>>> SSE2 ?
>>>
>>> Anyway, until the instruction decoder gets fixed, explicitly disallow
>>> SSE4A (an AMD specific SSE4 extension).
>>>
>>> Fixes: ea1dcca1de12 ("x86/kbuild/64: Add the CONFIG_X86_NATIVE_CPU option to locally optimize the kernel with '-march=native'")
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> ---
>>>
>>> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
>>> index 4db7e4bf69f5..8fbff3106c56 100644
>>> --- a/arch/x86/Makefile
>>> +++ b/arch/x86/Makefile
>>> @@ -75,7 +75,7 @@ export BITS
>>>  #
>>>  #    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53383
>>>  #
>>> -KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
>>> +KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -mno-sse4a
>>>  KBUILD_RUSTFLAGS += --target=$(objtree)/scripts/target.json
>>>  KBUILD_RUSTFLAGS += -Ctarget-feature=-sse,-sse2,-sse3,-ssse3,-sse4.1,-sse4.2,-avx,-avx2
>>
>> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
>>
> 
>  Acked-by: Arisu Tachibana <arisu.tachibana@miraclelinux.com>

Acked-by: Christian König <christian.koenig@amd.com>

> 
> 
> --
> thanks,
> arisut


