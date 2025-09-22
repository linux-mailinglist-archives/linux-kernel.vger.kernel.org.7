Return-Path: <linux-kernel+bounces-827768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F59EB92B70
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A6E419063D1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D7931AF06;
	Mon, 22 Sep 2025 19:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UaU9WOXt"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010048.outbound.protection.outlook.com [52.101.56.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE5D70810;
	Mon, 22 Sep 2025 19:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758567695; cv=fail; b=sduGYdQVW5oCpuxq2qotQXygbZlnXUbtijFcOd3vSs3YjL4DuIfi7SAi2XLruJy8NcPSDAvAMEmUwsbEmnf4H3bwusUrs38G6lfnPzeHEUCaO82PXL7Tak5/BK6tP9UawdrC6rs6BOuNnQbmDMoU7EAtWh6IZcEAgZtjLdRJdwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758567695; c=relaxed/simple;
	bh=mbB2OYhsmttHXACx8TRmeAQxR4jKbRmA13bsUZwPX94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JvuvbF2RViNmQrRJBsY5JnsHPnUdpGpkZaBzuuxZM2EbpJHJK7vNrEMf/KVF9cxgIeNWUPTtSIKF5i3ca6V23WiK7RpP7sKgUWY0u8trd1bm8eqjHDp4y1Qz9kFFG1E5A1q3zmqQMBowbo4l4sS01TAaHS5NqwT3dufQMG5d0rA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UaU9WOXt; arc=fail smtp.client-ip=52.101.56.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdpIJAPaellpH1c2jDhC38evdb8kC3i3nb9hiDUdD7SW1qGyRnj/XtuTlPNKGm3Z3Mdfk38JaUcRso1DIEnhMhD36xBmd3Lc6S0raWYtnqLEjLRSoCAfhC7/OhDPXRP1ojirq1P8cftqJwLZD9rm7rZ3bEJyWnJuowU2IUAnLJzoajXFN2+dEA1wrrssf2o24+6iAt/mXZXF1Z3UAcSTgOVOWTzF+NGyrxVSFz5VJJGowNWHap17xMvGVPD01jYFp1E0sRzmaItbsE49b+6ZV7/CJUM/nubmwZueUOXBEWEulgoHo/68wDlyW/91QIQ0hNxalq+1/f/Q17B6jVJPYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZLV6TLkpyXKI6p685Q5cCspLe8CW9PHZnr8wCQrRoI=;
 b=HqPnjLOZkZbHCfQNzFZtoFUzXXP1/OEsu0s1ClzHA+xI+VSbm5s3X9gxGC1nlTNcwEL/Q7eznIuqQdU3NMAEkYdoFZgN9/Yh95q/NJBckaEx0JpG2IL1MrsyZM1fg5+155T8NiPvXYFYnyq38WMardKDICRQU8cpfbt4rtbe2CFzBTyccY1YO/7dYrw+xPPlB7TUPnmRz6UVgJlORkr3MwAh+laBGW7k36RATmRWqJN7Jt9yYiJGCrn5bX8y7RrieFkiChFU99K1yw326A0SS3G0C0Zdrdb62tny5W4xps1jPkiHkIIL6VkP8Xh8MSwCySuD0QiiQBo+ONdmVupZ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZLV6TLkpyXKI6p685Q5cCspLe8CW9PHZnr8wCQrRoI=;
 b=UaU9WOXtKXMKWPS86j4gFvy2Sfk5BSe/qtNRBiOcBnHLySnJzYTljMbMQpxTknr3xT7WXJvg6A3RvxDeSbl0+65aFSjCXWwHFuENmRZnC9WT00uO2xduMTZd4PNpdy8PRf4SHsgJRv/YZ3oNOigkcMfuCvSJaOef38GW17tsJE4nr/f0TvFagRIJdBCFRwErfT6Q9jLL/Rrc5QDKcE4OObGRMqcgi3kUKg1rPkbHZBQcFAe4fAkznwdiIsgXGgzjqnI878dcBex24Myk9XSYoWvNoBILrgxSsSXCTBa8r4Ry/F17rH+w0norrcJysNHM2RYrkYPmQhXiMRa8J1viSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21)
 by DS0PR12MB6654.namprd12.prod.outlook.com (2603:10b6:8:d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 19:01:29 +0000
Received: from PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6]) by PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6%4]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 19:01:29 +0000
Date: Mon, 22 Sep 2025 15:01:27 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, acourbot@nvidia.com,
	Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: print: Fix issue with rust_build_error
Message-ID: <20250922190127.GA2462108@joelbox2>
References: <20250920161958.2079105-1-joelagnelf@nvidia.com>
 <DCXWEV3YO443.2EUZL32P96Z0D@kernel.org>
 <20250921004517.GA2101443@joelbox2>
 <CANiq72kDkAtYQ6fBb4gPEJqsS10qmXRRZj34gDWqjAQEvmXVPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kDkAtYQ6fBb4gPEJqsS10qmXRRZj34gDWqjAQEvmXVPw@mail.gmail.com>
X-ClientProxiedBy: BN9P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::12) To PH7PR12MB8056.namprd12.prod.outlook.com
 (2603:10b6:510:269::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB8056:EE_|DS0PR12MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: c39bc8e1-3dd2-47e9-c0a7-08ddfa0a703e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0N4KzFuRDI2bnVYOCswUHBhQllUbHpXemRSN242RzIzNUI3TURZalNHQjJO?=
 =?utf-8?B?eGVjQWlrSmRtVWRXU0VzelZVRHlWV3ZVUTZtZDA2N01MK2JKNXNQbTJmNTRv?=
 =?utf-8?B?YXdVTUFMVGRxUXVNSVQ4b0xJeEt2RGl1clFlcFVWbDRUOEVkT2g2bHU2alNs?=
 =?utf-8?B?Rjc5eGJVZDNXK3MvT0krZnpGY3drMjdMaWxFNEg2bkRIWmpEUFZISDZacHdF?=
 =?utf-8?B?WlpqRGhuYktlVk5XSmlhYlc4MGxERkZoNm9pRGIwbEJHUWlDa1diVHpDTVFJ?=
 =?utf-8?B?VWo2KzFsQjVCcTBsTDFBUkZoM05LYm85SndWTlEvdXIxWnh0azcwaER0T0s0?=
 =?utf-8?B?dnB6dnh3WmNacmhYVWx1L1JnQzFWSjdmQitqem10cjMxWVZOdk5VQmlrZGgz?=
 =?utf-8?B?MjRHWTlvY0hMalgwcU8vdWN4c1JWTTdldXF1MmtyRjAzTTE2QVZFbVF5WVhT?=
 =?utf-8?B?RlROUlRWR0xKdGp1ekI2ZE5sY0h0OExrNlVHL3FhNUNVWDFXS3pSdHdtdVRI?=
 =?utf-8?B?V2YwRzBla25VY2lNc1NjVW1wdmJIZXc3R3BSS0VkMlp6RU96ZzRhL0NwTWxU?=
 =?utf-8?B?Y2szdXNWM09lRlRsUUVuNWtVdnZOemFFbGdrNmtUTGdhN0RrdnNFaWZ0all5?=
 =?utf-8?B?U1hWVkgrVXY1aDNOdlozVU5nOFFPS2swSm50NUtBYUg2bjAvWE56UEd2MXhK?=
 =?utf-8?B?dGszTXhuYlNGVWttc1JPTmdkV2pqSTJ1enNsYU04UW9TaGpsdjQzQVdkOFNh?=
 =?utf-8?B?dVhJKzRXck9sRUpxQ3FNeHdCQnB4NUIzNEphMm1ucGxDMU1YRWVPcTJ6OFdO?=
 =?utf-8?B?bjR3NVliRUdFRVEzQ0hhaGJ4Z2I3VkZYVlN4Ukt6b28xdzBJQmpkK0U1Y2Mz?=
 =?utf-8?B?M2FnYnpQSmpMMXhXUDZpQmVlTU13VlA1M0FpNE9IcUpUSlNXNlFUa3h5NkRt?=
 =?utf-8?B?d29aYTF3clFUbkFiK0Zsd09SbFdZNGZ5V1FEcDNtVmttMUxvR1hScmhPMWQ3?=
 =?utf-8?B?OXRNcC9hYlFxSnVSUXd0dUVjbFVPM1RDTW56c1FnRVUrZzdnUGFqQ0RWMmRE?=
 =?utf-8?B?VVdjUVVzUG14dEZVOGIvVkVoQXFWYWxCQ3czU2NkYk1Ea2xsRXRXdnQrcTU2?=
 =?utf-8?B?MEVEYmhQSjFVMk1WdEFUWXk1UkZLZzJWeDNIM2h3akw5K1JzZWRQaXN2dEh3?=
 =?utf-8?B?R0xzL3FzRDRlaHZkVUNrYkxUdWg1V1BxTFBBUW1ZeW4yamNYOFpNeHRTQXhT?=
 =?utf-8?B?Z0owMC8yaUJvOW5pbjFCQ2labTlsTytKZWI4LzdXN1BIZFFSZzFqZU9IL3hH?=
 =?utf-8?B?TTNkQ3VTcXE2Z2pTYXFBbjdDS3F3em1STUtiemRaU29IUCtnWlFTLys1dkVL?=
 =?utf-8?B?WW8yZ0NzODkrNkpqQnpXL3hrWlBIcEI1a3RlRFBkVzk2Uis2RnowaUVTTWxW?=
 =?utf-8?B?dHNxbnR0Z3BxNDBzeXhUN2FHM3hUaElMS0t1K1hkaEpob0s2dUxqR1hTY3Q2?=
 =?utf-8?B?Wm4xUC9DMEU2blZCM0tRZVhtZmg3dUllamhoaGF6YUZoMHZvbXc3a3JIVWZR?=
 =?utf-8?B?Wi9FekhodkQvS2JCMmEyQU56TFgwaUhBV25XKzEwd3Y1Z1VzSmRJQTZsYnYv?=
 =?utf-8?B?dE8wdk53ZHRIcElOOUFYY0x6ck1NQWkrVFFwclRBb2R2TEt1eEdjRHpoMlNz?=
 =?utf-8?B?WEhzcjI0cVRFQk5UeTQ0aWxkR3lXTnJqOXczQzBkLzVHTkpWanhLZnZYWkRS?=
 =?utf-8?B?cW8rSFVLMjJ4bVQwblZKbHlFclVLYjlTUWg1NXRHRWVxRE1kd2RabDFuWDFP?=
 =?utf-8?B?MFF2MjQxWXF6L1EwQW5SRmwyekhyVnp3aXY0Um5FQ3cxNUgzaXhGQzdHbWhs?=
 =?utf-8?B?N1Q4WVU0Y3lWRDh4ZXlLTkNickRpcmFUNHBtM0xQVEFieHJRL2cvbitqU1dj?=
 =?utf-8?Q?9RexYIXLwDM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8056.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VG9YOC94ckJmU244WWpzSkh0aWExd2ZVbklGQlA2YmpUR1F6R3RoY05MQjVB?=
 =?utf-8?B?aE1WSlZjeHBtWUN6a0p1M1JCNGhmSUNhemgxc1hYZVRzV1U5aVVJeklwamo4?=
 =?utf-8?B?MkdKeGI5emZQd1J6L2JXbGFXbVBtbng5R0hLTUhOVjlHOUFJTXhtWWVxeWts?=
 =?utf-8?B?bHB2c2VXMUJqdU9ZTDIzSC81VTVBRXVURGUvcXMvTUw3VzVXeXh6Y3VFZWNU?=
 =?utf-8?B?NUFsY3U1NkJ5ZEM4OEliaDI4ak5TUU1ydVNmWUxubGQwSENiRkRjMzdlUWtI?=
 =?utf-8?B?RUJORDNyakh5dXQ3WVpsSG42aWxteDluRkllVzI4THN3ZjJNK1lhaWlWV1k0?=
 =?utf-8?B?VlVhZDA2Ym9QenM1OE02cTBOemlIQVBrbVZHS3AxcTRMWmZGR1p5RWJGTnZW?=
 =?utf-8?B?dnMzQ0R5UVRIKy90NEtWNlVidm5XRWVGNTJJdFhQNVMzbEcySXg2azZJOGtt?=
 =?utf-8?B?bnlDcWtVdG1BU1RXMHRuZnY5RUErYkwvMCtjSllwWElLMnY4TUdYcVI3SGd2?=
 =?utf-8?B?aThWclJ1R1h5TlM1ODROZXFnOVE4ZkMwMTE0MnF2RUFnZjVJcC9EWDdWUnZV?=
 =?utf-8?B?OCtNYXFSQ0RJYnkxQ1dLMXJqSlY1dkdHd1F0VG1NcFNSV0NCQnloUjhvRzVG?=
 =?utf-8?B?NE9QY1BJZkxxYk1XcmVudmVlK1lmdkV4TU5FSTZjcGZhOUhJbTBWbTZqZ2p3?=
 =?utf-8?B?WGFVZk1Ia2k3VzNZcGJ4REw5VExDRy9ESlNJQzA0K2ptb2luOW95OHdnVDF0?=
 =?utf-8?B?WjlaYWlwRXZ0clVFaWhrMWRWWVlFdHdIem1KWGpNRlF3WGhhcUZDL2pFakhE?=
 =?utf-8?B?cDNmckVXbkU3R0puTzJKbWtIdnc4OGJKZjJyZTdXZkJJc1kyVndsWWpOYnNz?=
 =?utf-8?B?aklkTTU1YkVtUHFjcE42Z3pDanVBc01KRVJEUjltamI1MW9qRFpvR2tSSlNw?=
 =?utf-8?B?clJHOUtHbExjQ1JSYUxINVRLajl6WXRkUjVtU2MyeU1FTlVwTUY5L3JOd0hl?=
 =?utf-8?B?NVdCTkhlN205VWd0T0FoZjZEeks3QUFCR1ZpbHFQY3E1R3REcktja3lBMkdp?=
 =?utf-8?B?RGgvNDBscDNoVktlTW1FbVZRb2FuWWwxaXZEQzJsam15cStUSDh6ZW91bTlz?=
 =?utf-8?B?K2daM1lpd00yaUJvVFZHSG1wa2ZJYk5mZ1g4NUJFczFWQStYb2NiQytCSTg3?=
 =?utf-8?B?ZXFJTXk1em9PcTJKdnJKVk5uM2FvTEdmamtWWHZJYjM5VFpMS3NCb21QTVli?=
 =?utf-8?B?OVNTZW8yckxCaEhEV0VySjFWaWNMRm0xQ0wrUi80UEx6RFVTMHMxODIvaHZD?=
 =?utf-8?B?UDdWdVVrTWd2ZHFjNHNhTDRuU3Jna2Q2b1VNdUxHb3lxODVtQmNhcXRVaGNr?=
 =?utf-8?B?cEJoVE5yWU5KMkdYdFd5UWtEKy9ORVhjNjZnQTh2eFZXQ1dnYnNNcFZkVzVw?=
 =?utf-8?B?aHVhUnJGdkRoWVcwR0cwT25PUG9zcUsrTDNlVktFNkdITllkTk54SFVLeTZY?=
 =?utf-8?B?OHRHa1Rla0I2dCtHMFRhY1VUQTZ6NUsraFVRcWh1TFhEUkMyc2h1aXp6VW9y?=
 =?utf-8?B?ZWptcjgwRWFQQ25EWktTVWFObzRvQlVERmlzVkRlWXpGdGYvYkpzNjlJaHl4?=
 =?utf-8?B?aUpLSTVFdUZOVmRLWHVMeVB1T2c2L0l1T3ZmZWRuS1BLUHp1Zm9ZM0FtSDUy?=
 =?utf-8?B?N3lXM2V0R3FMV1FYaTk3c3R5QUo1TEJERCtteUpyRTNLOVlTWHBIVFQ1dCtI?=
 =?utf-8?B?RXJxRWY0cW9HNXhXaURCWnZMUmI2RGhzamZHV24xdEcvN3lqdkpMN3QxTGlD?=
 =?utf-8?B?SVVOWnhOS0MvYXhIU0gvaUlOQ25nczkwbVBCWkpvU0dWQjlKTW5INW8rVDYz?=
 =?utf-8?B?T0xRYVBHM1pEa0dsaUpXTjR5UmE0cjJ4N0llZ0NaSGsvb3hRRmI4RTg2a05X?=
 =?utf-8?B?WnJHbDVXWThPUHFWaGtjV0hMNDY3NVkyekhWQWtMQ25ZdlZaaEJCeFBKRGJj?=
 =?utf-8?B?Nkx6dTRGN21Kd1B3RVBlZUlEMVBqOFB0djFuZUJXakhBQWhlNndtUWkrYktS?=
 =?utf-8?B?dEc3a2JzS2Rpd0ErblZWbm9OVS9CQmlRRXFzcUp1Q1BzR2F2T00vZU16VEFF?=
 =?utf-8?Q?cdYbhFRVJKRXvlva12/lU123i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c39bc8e1-3dd2-47e9-c0a7-08ddfa0a703e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8056.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 19:01:29.7913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76YlzYuHimcAFjQUdL5MU05V5chgOGT3Y7A8SSBP2TXaVpbjO8rKVt3HSE4bdWa1k5VALG/hxC69t5pDMzf1zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6654

On Sun, Sep 21, 2025 at 11:13:11AM +0200, Miguel Ojeda wrote:
> On Sun, Sep 21, 2025 at 2:45 AM Joel Fernandes <joelagnelf@nvidia.com> wrote:
> >
> > But even if the pointer is a C const pointer, LLVM seems to
> > always want to reload it.
> 
> What do you mean by this? I think I mentioned in the other thread that
> a C pointer to const still allows the callee to change the value.

Apologies, indeed a const pointer in C does not mean the pointee cannot be
modified.

I think I somewhat understand the issue but still not fully. MIR optimization
is supposed to optimize away the dead code in build_assert. This is what I
see for "good" cases when things work.

But the information that the data being printed is an immutable reference, is
lost somehow during MIR optimization phase when a printk is involved.  Per the
github issue [1], there is likely some provenance information in the immutable
reference to the data, that gets lost during "MIR inlining" optimization. In
other words, this is not an LLVM problem as I was pointing out, but an MIR
optimization problem.  Benno/Gary correct me anything I said is wrong.

I guess I still have a few more questions:

1. What is being inlined when we talk about MIR inlining? The print
statement? Constructor to the Argument object? Something else?

2. What does 'noalias' mean in the github report [1], and why would that effect
'MIR inlining'?

3. Why does LLVM inlining still succeed when MIR inlining is disabled? This
has something to do with a new llvm feature Niki referred to in the report.

thanks,

 - Joel
[1] https://github.com/rust-lang/rust/issues/146844


