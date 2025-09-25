Return-Path: <linux-kernel+bounces-831613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31DFB9D1F5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5B1383C53
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B73D2E541E;
	Thu, 25 Sep 2025 02:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t10GDQi2"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011057.outbound.protection.outlook.com [40.107.208.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDBE1DE4E0;
	Thu, 25 Sep 2025 02:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758766702; cv=fail; b=tGKw8naGqrIHIKYpzFfm23S6hOydN9je5ts2pf1MH4TVtJ+ljjELngayyo7IjUlY5+TD6Qbiz2YJYcVu6QfFhBUHI5nkykkzmy7uKB+sbTSLo2nvSvQ2uSzJ7hQKsEiIDVNWH0Bh+wGebqJF5BTdNcpvpw9xkSBwjUR901rmLNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758766702; c=relaxed/simple;
	bh=u9V0DSlsxfVvR2XRWfzxYdijr/5wWUw1iQpd065wU4g=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EHL4UNGiQ25aDhMP7WoRwTq3P4QvYS6GcXPlp9sqvPHk/q/m/BwWjQi5De+q9iPHWO7J0aVJQGLiG+lZyk8FKmDRwPiXlmmLc24H+xc8LyzenZFuWqHK1haWrYEywM4aKsR9eNlsGA+xRmi5X/qXKdgt4FReF1dIoINgP8FoiCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t10GDQi2; arc=fail smtp.client-ip=40.107.208.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfDA8Ez3n8YfB649JIXadhz+t2Vhw0dk7a9UhGeyeu5Jqs66yqAWtk6v/IhKjuFACxA3dx8Ct69rhqXXJvTX83T1lyQWwfvtCHMqXDQrB9DVF7gUE3Q4r+VfHFIyExKU0sLkiy0GVIekX0NOtJnYhXTz8idyZeZLcsdBaRr8McxZuvOEfPkjAtIz6CSegkyOkBiWjMuV8nFaEU8gHdj+T2AgJTpY/AOoEHhwvIlwxkVxEX9wyC1OMUgeCaMw0DKgrWS+NsYDIAYyFBmg/c6tQR9XgJ8L86/LQLIT6c1gCgA6DahZv2JsHB5rwlcluvAWiB1Cxt8hv0FmySNErPICJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=senCHWjk3TO97udJFmATqNwUlv5Z0GgCWW1sDCSOqQ8=;
 b=xIQnLUulYIELO27yuce/rjzQXjS+LCSbFOa4I26NjpoX8+CsA+PDSDZACPLIh8RYYgT7LrYDQM/FvXd+ou4LC1h7MGlMXwrUztd6dnOb6xSQpSxDS5lR1qthcj7wN4tK15aybpFEfy8QDxd2MwU5YNAA0o1Q752g7qUn8o1wFtBL+ybexUHbIhrEDxtAN6tgJVazyUUYba2QO/9Lgl2LVUqUZIAXoDCjcjOD5nY0Pwhkp/UZwNQl6uOeQDVVs3fVfz1IPK3Oi0E9KKz5sD0AsOAyk3mfal/x9meSvNsL/dXImBHrQg0JYKokWYTgf4dtrW+064dQVkR7WSaH+GR5ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=senCHWjk3TO97udJFmATqNwUlv5Z0GgCWW1sDCSOqQ8=;
 b=t10GDQi2V9vBS+r1g3TwHU6Ngnr9S/trihz3T0Mg2uEvMben8RbvPUJ+PkCfQ7EhCbTk36A2+knvoT5J9pZLolcD7TxNI5xos9biTYW3C/XEjKLHRKcTUn8x84Rt3Jtcr+RxMdo8A89c9BVLeTx7Ra+AfMEITMh/INgLINchOGyjkcQxVL5Pel6/W7vmpwffB3zy1doMMfusO9BuLUPDIB119Icr6LRSZYf+Zzy9VyUxF5BI1EPl5Xh1f0aqZQRrPw7li/7M9SoVsJ0zM1YIIf19WYbnv8WaLTtkBp1xu0jKqdcdQYyPgU4ayOK099dq2cIkAL959c4HwHDPg6oxPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by DS2PR12MB9592.namprd12.prod.outlook.com (2603:10b6:8:27c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 02:18:17 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 02:18:16 +0000
Message-ID: <81b26efe-5099-4238-a58f-65bf4c50e021@nvidia.com>
Date: Wed, 24 Sep 2025 19:17:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: slab: add basic slab module
To: Elijah Wright <git@elijahs.space>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20250924193643.4001-1-git@elijahs.space>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20250924193643.4001-1-git@elijahs.space>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0098.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::13) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|DS2PR12MB9592:EE_
X-MS-Office365-Filtering-Correlation-Id: dc676217-8014-4110-8342-08ddfbd9c976
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Znkwc2NnZ0prVWM5dzVmNWxGL2tqUzFMU1RxdVM5OGRYa2sycEJCb3Fyd0Fv?=
 =?utf-8?B?aTBUYWg2Yi9ZSU1VR3JMakNnV25HTm10L0NYb3NVRWlsYlVGdUdXS2FiWGVT?=
 =?utf-8?B?WDZwSlFpVDdDM01veURLY1pIdTlsaEFPZ09PbzZiWEd5NldvKytEbUtXaWdK?=
 =?utf-8?B?OHR4NDJaVHFMK3FpQlBhQWVNR3FjLzlla01VWjBJR2NxWTBWem0yUFhlN2xw?=
 =?utf-8?B?MEdmeVpwMks0YnlPYUlLbGRmelNvbmYyVjU0b3JqS1pBT2NQTy92MERWK2lU?=
 =?utf-8?B?T1pJbEp5NVcySkFIRUdNeTl6NGgyT002Nk10VWVHejZSb0gvTnltWW0zMWVP?=
 =?utf-8?B?N0Nsd0NxMjJLUFpUZVpya0FFbTJCT3hTSUhabklXOHlPMHMxVEkzZTFZbmFT?=
 =?utf-8?B?S2JSaXZzV1Y5dm11N1lvWC92NmQrOEFBY1RKSXE2Ry9lS2gxa3lMSjVEQXZ6?=
 =?utf-8?B?YjlKenRrS081b29IVDBFRGZaYjBwaG5KelZzcXNDU0FxRnYzbDdxUmR3K1c1?=
 =?utf-8?B?eXYwQTRrZFFlYkZqbUQ1TElBd1NuTDRFakg2M1hndlhCaDBHMy9LNHJTOHc4?=
 =?utf-8?B?bEhDbmNCOE9WaDRCUEtTUk5CNzJCWmQ2Y09QbGZOZlB2My84UXpMQktJL3NL?=
 =?utf-8?B?VmtXdGtqR2UycEQ0VnZwc2ZlR2JFVmZnMDBwQXdaaHQ4VU42c2JPemV5clg3?=
 =?utf-8?B?MUMwSkNQSHFDMURrb2JlN25uTEpmYW93WExha0JGTmhjTjBSN0VhYXE1b2hP?=
 =?utf-8?B?M0lnY0lJQkpRekUwMUtIbU9tTjNSZUtYTlFzU09xMHNKSHlzZ3F5YTQzZ003?=
 =?utf-8?B?QVFjYzVmVFQyTDhTYUVEaHBnOGtQTDUrZTlVTHlNdVRKUzc0K1Z4YmtlTE9m?=
 =?utf-8?B?VDN2RFlBa2ZGZE1JQS9tVVFCZkYzaUpmSnM2Z2EvTnVMQjZ2a0doRDc0TGRp?=
 =?utf-8?B?SGJ2WC9aOFdsaWxGcTYvUE1OQVNsWWJ4RGljUTROWmloaC9HWHkxNTBIZFBm?=
 =?utf-8?B?Tllxbk02bUZtVjkxTG5zWENPalhiNTZ5cFV6VHNyMVROcERRMFBTZ2p5UXNY?=
 =?utf-8?B?V0hnUXB1Q0tVQncwSU5aak4zNEd3TjZnckpnV3BUZHI1aTdNVlVxeG53NTM4?=
 =?utf-8?B?TGt3KzlhVjJ1dDBROEdhY0JuUXNYcXQ2cFFPcUV1a3cxQWxzVnQyeWJXcmFl?=
 =?utf-8?B?VWVjVFBqb3pQdlYrdG9ib3ZIYy9yYkxLc0dLZm8rTytlSmxpU0k2NEFEVVdY?=
 =?utf-8?B?bko5REEzdHRuanVwWVdBa29iYmJJeXFobUdyWG1aUGVZVXhwd3FoK0dhbmdL?=
 =?utf-8?B?TmFKT1ZqMXczc2lRWGN3eFZqdUNSbFBHZnV5b1dlMU5TVU5DQXBuK25rQ09G?=
 =?utf-8?B?WTlTVG1veHhmQ1N1VjR6ZFF5eHBWNWswblJjQlhhbXJUV1lMQ0xwaFRvTFBD?=
 =?utf-8?B?V05Pd0NwME1weURxUDBBOGh6aWdXcjhpcmIzRHQzZ3l5M1BFM3B5enVzME5t?=
 =?utf-8?B?NDNWMXNpV1JzQkNXcFhSbFNmc2JhczNHSWRNNS8rd2hxRk9YOThJRlhSSUFq?=
 =?utf-8?B?cXlKaXBiZnhMSWowT2p2Wkkwc3lsUXhqSytQbVRhNDNycC9UZk9SRFVMd3pS?=
 =?utf-8?B?bmhxb2NxTFZxNWxIQW4zQjJDeHV1MFRKVTFNQmNDVmp0Y2JFazhBb3l2SHZq?=
 =?utf-8?B?dGZiYngwWTVSQndtTVhmeW1UaGhvVjlJMUQ0Y2QxQ255dUtsUWNLR3g3VklT?=
 =?utf-8?B?dG1HSHk4RDJIVnc3VlJlQlJwbEhsUXZYVTJQM1ZodTBTMXRQNVUwaDZUNStu?=
 =?utf-8?B?WmlwU1ZkWE9KY21SSkJoZ1ZldVJ5R1VNcjdQMFdVam93dGk5Z0hEa0hqUmJ3?=
 =?utf-8?B?amh3alB4SFdrTGhwa09LVG5Ga3VjKzRQeENzcDhja2kwRDUxZ2dhYkhtNEdw?=
 =?utf-8?Q?G79Ndu1I7OmSStQz8SZC1O88uD3khGRY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFVPTkR2ZldDbkcwL3RWNFFidTl1RCs1TGQ5RTBXTnk4NjBTTXNXUUxIaVFX?=
 =?utf-8?B?M0JUbkFPTVlTVTU3eVpDL1NjOFpWUGdDRVRRejdwcVZTT091eXZ3ZEgzRDBj?=
 =?utf-8?B?QVhiaHJNSEVjSW8vaUk2M3Y1MmNKbzVXRTlhZmRlVno1TktzM0dWbi8weHJ5?=
 =?utf-8?B?UGtBMlRua2ZMWldaYnEzcjJJcXZlRmdwWDcwSlJycE5rWEJRSjNKbEY3dndM?=
 =?utf-8?B?bkYrLytObEgzVXoySEVnR0tFVFFreU1vamNnN1pFcGViVDhsUW1COW1HSWNw?=
 =?utf-8?B?VlJlekxkaHFyc29tQS9KVTJ3Rm1GOVplU0FpWU1PZld6enRUMjZiM3hydlBi?=
 =?utf-8?B?L2dZV1daK3V2OEk1aG1uSHUrUU1rV2ZBdkF4dmFHVS9EeTRxSHZVWGNEVGRv?=
 =?utf-8?B?TFhyZyt5Qm9oczhtVzVmekluSmUrTVZLa2d4R3pEVEhVTmxqNndxb2EzZlNG?=
 =?utf-8?B?QjdLM1RneEE5Q2MycmR0cXFDRmNKMUR0SHI4R25lOERQeGdrYlljNFlPeHJu?=
 =?utf-8?B?NHdRN0t6UndUbmh1RUlxUk4reGVoaTdhMHdLb1NjSXAzRE9aTnN5UkNmdFFJ?=
 =?utf-8?B?K0pYTGU4Rkw4YU5wMmxodTJ0d1dTbHhxWnJUSnNUWVBxRVRXd3FnZnlMMDN3?=
 =?utf-8?B?b3c0L2FhOGVWRE50WHQwY3ZTYUJLV3JGTlQ4VlA4VmZNRmdWazllK3BUTGtI?=
 =?utf-8?B?c3VieCtnWDZhczdtbjZ2cFdkSlRHcE5DOVZoQzYrdGtzbFVBb3JiU2NSa2Z6?=
 =?utf-8?B?NnRiNi9RTG5zSVl3M3RDT1lxWFl6VjQwNTFyVDNHZnpFR2dsZ082YkxYcW1s?=
 =?utf-8?B?eXNLS05oTVVSa0MxZ0w0OTFYYnU0RkxxSUZLV1gvVit5d1o1Wmg3Q3NJOENM?=
 =?utf-8?B?NTdFMk80dU5pQkFrcU4vWGlmU1hLZVV1ZUZyVWMrMjZITjVOL0lvdzYvWFVz?=
 =?utf-8?B?ZDN2US9zZ1F3cEJHdFhkR1pNVmIyL1NENy9hWDlrSXhyMGlZajRES1VpRytH?=
 =?utf-8?B?dU9tSDAvV0FPOVREVytNbEhuVGhuWVArNkx6dFg2cFl6MENTMnpjUzFJZEZs?=
 =?utf-8?B?cHp5K1pXeDRsdksvQUpTUEE1TitYMDh4NE9XbWZIMlk0Vk4zS1NaUTdRbTU0?=
 =?utf-8?B?NExwVGExNkRsQXdNbHFESG1oUGdNWmMvZUpRaTA4Y2JtcnA5WGdnVUxpS3Bn?=
 =?utf-8?B?WW1HUmV6ZFo3NXo5NFZIeWtWcjdvendadS9QYXlUcU1ZSXNyRWxmeXZuY1Jr?=
 =?utf-8?B?TUh3Wml0clRjTlZkMkNVUWhXVnBSY2pFTFp0bnAzUzNnUThicG5BZk5nRDVI?=
 =?utf-8?B?YXAvY1pxcEVIZ3RxRm5SYjhLV0N0TkFOYWVWcXdHSzdVWTcrYk05cDJTVGs0?=
 =?utf-8?B?bTJoRHhNbkVoeHFkRTJJcWhUK3l5akxwZUk2MW85eUUyZWc5TEVqMWpNZllV?=
 =?utf-8?B?ME1qYzNDL0Q5YzY5T05nVHpFYkVGeFVWT0QvOW5JS1VrMHVyOWtBY2h2dGNv?=
 =?utf-8?B?djlJMlR4aWpmeDNWdUtIc3gvbGpwaHRnZDdnUG0zYi92RG1kalFkRTRha3RF?=
 =?utf-8?B?Y2FMUE9JNy9PWEp5MVlGWjUxbVA0MDIzeEZTcTN1L1lpKyt2VGllaVk4aHZE?=
 =?utf-8?B?VWNTeWhUMWZBcUt2T2xvRkdLMGFXYisrN2I2SEVINGhFYkNUMVlua0VJdCtK?=
 =?utf-8?B?ejlycEwvS1dLNWZ3SjdMdlZRS2dScDhIbEVwY3ZGZ3BYUUxHSElMRFpRZTE5?=
 =?utf-8?B?WnZtL2s4WlB0YmI0Tm5GRHNaVGNzMlVYTEZkV0tWRkRhTytwak5POTJnV0Ja?=
 =?utf-8?B?L3NBTm1tQUtrSHJ5OE1TT0R4RDE4NkVZbUZMMjdpalFHcUtkRFBYOVFMaHdR?=
 =?utf-8?B?dmw3Mk1nalNpRCtCUThqWUphNFUxYzJ6RlJoYTBmWjR0d3htdTM4UUFHa3Ny?=
 =?utf-8?B?SnU4Y0p2dFhWUm1WSGpldi9waEJQb0laeW5mcjFJKzZFQXVQS0F0V1RJZWtI?=
 =?utf-8?B?N3NBTE9iOG9UWlNuMkFJVnVHNnhMcUZRRHNyRjNQcldoa01TcHhJbk9TM0JE?=
 =?utf-8?B?dHVOblBaQVFUSHMxVlZBNUVqM2NQcHZuREhqM2JDMWU4VWJBK1Bvb3FoQ0Jl?=
 =?utf-8?Q?s4Qnqq8zBm3zhWJkkl3mAe9Nn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc676217-8014-4110-8342-08ddfbd9c976
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 02:18:16.7157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GDhkQSuWphJ+mAfpY+DDBk/unuFjIpCvl5lU4e4ciqG4aI5AkgMVnerPwZkLHiMIQ7WOLmPNtAnYTE7W9rgaTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9592

On 9/24/25 12:36 PM, Elijah Wright wrote:
> this patch adds a basic slab module for kmem_cache, primarily wrapping
> kmem_cache_create, kmem_cache_alloc, kmem_cache_free, and kmem_cache_destroy.

+Cc linux-mm

Maybe that's not required, but if so I'll be quite surprised. :)

thanks,
John Hubbard

> 
> Signed-off-by: Elijah Wright <git@elijahs.space>
> ---
>  rust/helpers/slab.c | 10 ++++++
>  rust/kernel/lib.rs  |  1 +
>  rust/kernel/slab.rs | 85 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 96 insertions(+)
>  create mode 100644 rust/kernel/slab.rs
> 
> diff --git a/rust/helpers/slab.c b/rust/helpers/slab.c
> index a842bfbddcba..799de7bc1405 100644
> --- a/rust/helpers/slab.c
> +++ b/rust/helpers/slab.c
> @@ -13,3 +13,13 @@ rust_helper_kvrealloc(const void *p, size_t size, gfp_t flags)
>  {
>  	return kvrealloc(p, size, flags);
>  }
> +
> +struct kmem_cache * rust_helper_kmem_cache_create(const char *name, unsigned int size, unsigned int align, gfp_t flags, void (*ctor)(void *))
> +{
> +	return kmem_cache_create(name, size, align, flags, NULL);
> +}
> +
> +void * rust_helper_kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
> +{
> +	return kmem_cache_alloc(cachep, flags);
> +}
> \ No newline at end of file
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index fef97f2a5098..bd76eadbe297 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -116,6 +116,7 @@
>  pub mod security;
>  pub mod seq_file;
>  pub mod sizes;
> +pub mod slab;
>  mod static_assert;
>  #[doc(hidden)]
>  pub mod std_vendor;
> diff --git a/rust/kernel/slab.rs b/rust/kernel/slab.rs
> new file mode 100644
> index 000000000000..8b418f9db7cb
> --- /dev/null
> +++ b/rust/kernel/slab.rs
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Slab bindings.
> +//!
> +//! C header: [`include/linux/slab.h`](srctree/include/linux/slab.h)
> +
> +use core::{marker::PhantomData, mem, ptr::NonNull};
> +
> +use crate::{
> +    alloc::Flags,
> +    bindings,
> +    error::{code::ENOMEM, Result},
> +    str::CStr,
> +};
> +
> +/// A wrapper for kmem_cache that allocates objects of type `T`.
> +#[repr(transparent)]
> +pub struct Slab<T> {
> +    cache: NonNull<bindings::kmem_cache>,
> +    _p: PhantomData<T>,
> +}
> +
> +impl<T> Slab<T> {
> +    /// Creates a cache for objects of type `T`.
> +    pub fn try_new(name: &CStr, flags: Flags) -> Result<Self> {
> +        let size = mem::size_of::<T>();
> +        let align = mem::align_of::<T>();
> +        debug_assert!(size <= usize::MAX);
> +        debug_assert!(align <= usize::MAX);
> +
> +        // SAFETY: `flags` is a valid impl, `name` is a valid C string, and
> +        // other arguments are plain values.
> +        let cache = unsafe {
> +            bindings::kmem_cache_create(
> +                name.as_char_ptr(),
> +                size as u32,
> +                align as u32,
> +                flags.as_raw(),
> +                None,
> +            )
> +        };
> +
> +        NonNull::new(cache)
> +            .map(|c| Slab {
> +                cache: c,
> +                _p: PhantomData,
> +            })
> +            .ok_or(ENOMEM)
> +    }
> +
> +    /// Allocates one object from the cache with the given gfp flags.
> +    #[inline]
> +    pub fn alloc(&self, flags: Flags) -> Result<NonNull<T>> {
> +        // SAFETY: `self.cache` is a valid pointer obtained from
> +        // `kmem_cache_create` and still alive because `self` is borrowed.
> +        let ptr = unsafe { bindings::kmem_cache_alloc(self.cache.as_ptr(), flags.as_raw()) };
> +        NonNull::new(ptr.cast()).ok_or(ENOMEM)
> +    }
> +
> +    /// Frees an object previously returned by `alloc()`.
> +    ///
> +    /// # Safety
> +    /// The caller must guarantee that `obj` was allocated from this cache and
> +    /// is no longer accessed afterwards.
> +    #[inline]
> +    pub unsafe fn free(&self, obj: NonNull<T>) {
> +        // SAFETY: By the safety contract the pointer is valid and unique at
> +        // this point.
> +        unsafe { bindings::kmem_cache_free(self.cache.as_ptr(), obj.cast().as_ptr()) };
> +    }
> +
> +    /// Returns the raw mutable pointer to the cache
> +    #[inline]
> +    pub fn as_ptr(&self) -> *mut bindings::kmem_cache {
> +        self.cache.as_ptr()
> +    }
> +}
> +
> +impl<T> Drop for Slab<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: `self.cache` is valid and we are the final owner because
> +        // of ownership rules.
> +        unsafe { bindings::kmem_cache_destroy(self.cache.as_ptr()) };
> +    }
> +}



