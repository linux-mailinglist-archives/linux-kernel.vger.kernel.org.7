Return-Path: <linux-kernel+bounces-792726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5DAB3C81E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 07:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946CBA04226
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 05:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA9D1DB92A;
	Sat, 30 Aug 2025 05:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a9n2DZD4"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28F51DDC07;
	Sat, 30 Aug 2025 05:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756531303; cv=fail; b=C5OB8CNpvbrMujl+OngpWS3hvOnswvM0Ff8bECbr+T5+Jzlq75/HS+BBPe17NbND/TUkIuOT8nlNwv7GtMSc4PfbAy3TzhCSWek9S0DaeOkMyzIzYf0YGNfgQpZ8X/dp/r5YdgJdKh794aCbusrWuGhd5f6vbdt8wYSLQp1IlVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756531303; c=relaxed/simple;
	bh=PpiNQ85SfFM3MXwlknS+IDX1d14QkwiUdaqklRDgw70=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=tfEd9Ynm0a3Kaw3SIAKO28T0ToEQgojtnudVGHOxWIO1i0Wc610e+mPe+MbmyuGCX/1yVIJPzAX8rUvKffrg4bqce93jBTwidtaGIzVZbfKzzrlmo4/ujlvtCEJPYxYeWCWF7xe3sw/cZTBufTpoPRTmkbWKDjhB7ov+RxzHBec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a9n2DZD4; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iwwHL0C6xDYQCsn3XxFGeK7JNM/WM7l7t/1YNWzwc7G5UDBprfdkH4h/6k6qaSymrCg2tQvwrFlk5UfULPC4gOyXd+GhdFTj9UOn5o1M3nLxl5MTAtFQtEuDuM+Fn4l640HqVCkLUnY+WSQmewFOHWr6sY6DDU3wtctjDYS05Y8ThezcJs4YYnkcMpY9pMXLF4GAxJlXDOtzPSw/0HQJ/U1nwLTQVyg5cHpS+QYeBSG3PR9WM/h7ovSi9cxB52oLhzDIuEcNVxN0OIl+pANw3BaOfD0557G0OqT3yCg6eF3TiVIMikIBSyZi1qvUxKrgSx41Im5gLgb1Ca0CrXRtuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpiNQ85SfFM3MXwlknS+IDX1d14QkwiUdaqklRDgw70=;
 b=Kk3iy+o6FpMZVRP8TmzpvFaDG8bTx2KA6GbPzjwOdFpNoZ7HV137vXjQZf4Dqk+BUO4v+/K/om2WUp2nbbxMSGffjII/nPReRQPoH5kadryInoVZTD05ssCj//xS/NWihAsfEdRQgprtm7PYvTg+wSXJLjKjiWGKFh6Kk20KW5fM8GgxNNQLcDgeB4mrqC9BywBQvdM89APR2lGPh8AkTHKzZmk3BhBZ01AyYP23KDdlcI53Ce+0oyfolW+B2nMGxBJ6+2UlNzwO/q+OzQxlVUEN7WFS2DZsoUhr56f4LDIBNtLVz1QrSXwztbjC/0X5TBRVW5dbvrWrSXL4TuSJEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpiNQ85SfFM3MXwlknS+IDX1d14QkwiUdaqklRDgw70=;
 b=a9n2DZD4zvxsbb4DT3nCtU+OsXUHYSLCkwF8HN6EM4ZSWOqPcHl2kLAuLtnNZl/gC2L96ClJMCfHXhSmELtDvywlhZrKEN7zUvTleCeCY+e1dRZfAXW2Tdooq99ZGu3u1uVOifP9Z9GYccbA5B3gycMv+whcNXHsGX8X+iWp3/dy+i/OEab7SFu40ZRQp1T4/4QZjKF9w1UUsUKZpxPJxyz+wO9KzCK+nle2ydgZOPhYd1tSIsxTv47FwBhyLyeAlAeGO6fcRdfuJLncZWXBpstven1kTjaMhz5H0aHJCKjk1syDsFOLx62ObGpRAc1ZMk5gW7djXmT7jycJCs45zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Sat, 30 Aug
 2025 05:21:35 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9052.019; Sat, 30 Aug 2025
 05:21:34 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 Aug 2025 14:21:30 +0900
Message-Id: <DCFIDJ3L14Z5.33N8H76S1GBW2@nvidia.com>
To: "Daniel Almeida" <daniel.almeida@collabora.com>, "Liam Girdwood"
 <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/2] rust: regulator: remove Regulator<Dynamic>
From: "Alexandre Courbot" <acourbot@nvidia.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250829-regulator-remove-dynamic-v1-0-deb59205e8e9@collabora.com> <20250829-regulator-remove-dynamic-v1-1-deb59205e8e9@collabora.com>
In-Reply-To: <20250829-regulator-remove-dynamic-v1-1-deb59205e8e9@collabora.com>
X-ClientProxiedBy: TY4P301CA0064.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW3PR12MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: 591539bf-fa63-41b3-11f9-08dde78515fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|376014|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlVRZWxtcXlCbHZtTE9NdVBOY1BqRkNZRjZIQ3VSdjJ0VEFZZmJKaEMxRDFN?=
 =?utf-8?B?MGptaHQxS0RCOWlLb0NHVHZTeHdTeExnMnFPS2E0amFSRGlXd2NkY0t2TVky?=
 =?utf-8?B?Uld6RG9nWmUwMnhtYUxtZ0FlUmZ6VVpoNEVhbzZaQ2ZWVW1CVU5qU3FRanlx?=
 =?utf-8?B?MHJLcElDeU11RTdjVVZIR2cyZXJGQ1N1V0NjL0xSNXBmbUJoUEZZM1ZpcC9Z?=
 =?utf-8?B?VE0rRWIvcDd0VXJ5NXlZc3gxUjloaWhWdW9FSDNUSkV1dmFXSjJybUhyamlm?=
 =?utf-8?B?VThoUjFPTmJsaTNJNFN4eERaOUwvd0dKVHpOejhBdVdXSHFKQnBNOEdmRWZU?=
 =?utf-8?B?QjZVcXF6cXJsaGhPNVNpRHV4SE9qUDJTVTZ5S0VCSnVHUnB3RXF2cjNpU3hR?=
 =?utf-8?B?RUEzcXlhdG5IVG9VSEFvaFlYYmdzb0hQdzhFaHBEcWdkQ25XNzJHVGRlRllZ?=
 =?utf-8?B?NGZTYWJqdXdXd1lKclpxSzZlcElVbUhQM1lORFhjMFErTWlyQU1wdk4rRkN0?=
 =?utf-8?B?TTJDRGNadlo1dVozUURZWUxRYUJiajViWVMvL0p0dVRoNVRXcE9icndnSTJ6?=
 =?utf-8?B?cGJ4cEJqTm0wUUdwbWRNV2ZMMlhBRDRZSEIzMm40V2V4YU1IeEY4RGxGZW1U?=
 =?utf-8?B?Y1B5TGFqRndKMFZUYVhZdG5RVUF2ZXhJNnEvbzUxQ0NtN3I1aVlyMHZoL3Nv?=
 =?utf-8?B?cHg0bWRQeTUrODN1RzFKc2lBclZtY2JsZUh0elMvT3d2QmlmenJtUGJzd3J1?=
 =?utf-8?B?R0paT3ZLcHdxTnB5bCtTVmdGMU9ucFQveU1LNk5EMDY3UmZ6ckxzL2UxRTlX?=
 =?utf-8?B?WEI4MlhlMnB1VWJpV2Z2YUV4a1gwRFJXdDdRY0FjUEphMXVWYVJ0b1JaNk5D?=
 =?utf-8?B?NDdmSFNmQmR0ZmZMWnpYbHpXb1hiOG5NRmtYYlFRc00zYUF4ZFVweFloZHov?=
 =?utf-8?B?ZlBRcEphRFltVURzTWNrUmhCSnR3cGx3SFlKK0k1dUEzTUVtSGI4SHkxMWln?=
 =?utf-8?B?NXRxL3VtdWVSdFlDbU1GWEVtWUNKUUxOUTN6Y1NXSXNvcUplYVM2c01hdWU4?=
 =?utf-8?B?N0tad0pnUGd4Uys2RG1HVytKM09JYUlqd3ZFbjZ4QmRlVTRzVGRFOEszVmov?=
 =?utf-8?B?eHFZTmNRaHE4Ry9kSmdqK2xkT3Q4UDVablYwbG84dVc0bTNjdi9wQ3RGSW5W?=
 =?utf-8?B?WDNlNWs5ajQ3WWtFZFN6QXIwZEtWUnhyaTlNMW1KWUFRTlJzb3Q4bUREUWk1?=
 =?utf-8?B?QWFPVzV6V1FhTlYwNUhwalk4aDJHWHk1bmUrUVBsWjZBNzdtcTk3ZlFibHhM?=
 =?utf-8?B?V3laNzl6cll6Q2RWTDRMeVd0ZHRGN1hFeS9DU1ZQZ05kUWc5ZzF0UGFvVEUz?=
 =?utf-8?B?Y0cvU1VUTDFwbDlUeG05aFJPRThLMFR5WDNJSHBVdGZnd2NPdXcxU1VyQ0FP?=
 =?utf-8?B?cnpRNU1zejZWODZvdmRwWFNSYWpPWStWamVmeWJPRmxwRk1hR3d3VGt5cUhP?=
 =?utf-8?B?RGUwZGxNUndjUHhlNlU0T0orRVNUWDdiNTgvNldHRGVjdU9aTzY0c2d4UURU?=
 =?utf-8?B?K1dkUFo5T0dIclExNlhXRG5PNVhPbHRKejYzelgrNERzSnVqTWNONE5McXVm?=
 =?utf-8?B?U1dEMjUzWVY3VEQzQ2MxTzhzZXlFdmdmUGZZVTMrd0lpODVVVzhsOWdXT213?=
 =?utf-8?B?c1FOalZyR1V3M0FyN1FsU0pmRytUc3NwT0NEWFI0NDdiMmJVSWY1NEdlL3A5?=
 =?utf-8?B?NUhVdUlTcHlDVjNlWm40UGQyMzVTOEFhbDBmR3ZUZ3BUdWE3NmZHNWhLUjBT?=
 =?utf-8?B?WmtUSEFITDdsZGlVQXhXU1FETVJoaDUybW1ocmswZFNjU2xadWNmVk1sdXpW?=
 =?utf-8?B?dWRjWWtqRkxtc0JFLzZaSTV3cXRlQ21RVUJTQ1ZnemJaM3M5MXQ0MkdIM2J2?=
 =?utf-8?B?ZzdmRU51SVFwQ2VUZGE5V0lQUXVmVnM1bWFHcm9GZEVxa0MxMzhmTjMxZk0w?=
 =?utf-8?B?bWYyMDFLOGp3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVYvWnA4NkRBN3k1aE1UdDR1cWRzMW5yQytJVmRDUCtGWnVjNThwUlFGZkl2?=
 =?utf-8?B?NEIvVGtIK1pPNkpOM1lGZWJ5ODZhUU5aS0R6QlVBL2hKdlFMNWJxMWI4V0kw?=
 =?utf-8?B?NmhWbUZnZ1RXaGVST24yTW5pbUUzTTBBWVc3aWt4MmZhVXlMMGd5RzVXNEZn?=
 =?utf-8?B?R08xRTkzZllwbVJqSEVUMzV2SUpaMnh6Kzl6anVrQ1hOT0RSZjk1R0swNCsy?=
 =?utf-8?B?TEIyVWJEUEdlZm9qVlk0TnBXeFBuZ1FwNTNmSGpjTERQVHZHZzZsRVJLcFha?=
 =?utf-8?B?ckZaOSt5RHpMVkFUVUlUWjBPNTgyZ3d5UktZWXFORGs1RC9pOVk4bEdZWG1I?=
 =?utf-8?B?ejBYV2ZpLzc1NnJ3MVB6NVYwWG5iTW9sU0tzcEkwL3V4bzVqK0pXNDc1YWY5?=
 =?utf-8?B?bU55WnBOZk1LQXRsV2s1RHR5QVNSYUs5U0FWYTBJSWxTUjFGc3RsMXRXVnRv?=
 =?utf-8?B?NEo1b3FPNkxwMjJKSDZqaUVIUndUZnFqT0RnRUMwOUQ5K0R5S1FFMmN1eERl?=
 =?utf-8?B?b1pXaE83MjNiVDg5b0dCK3RrYzZzcnJVM0huREEvQUtLUGY1RTBTUG1HMFBY?=
 =?utf-8?B?Nkp5dlRaclkxNTJZODdEU0M3SnhrTHM1ZDJUaTdGdzJJNlJwbGsyblBxaGtv?=
 =?utf-8?B?VG5tdUM2N0krcXdDZURtMEpXQkFpby84MGdGWjR4Nkh6MlpJZTdYVUZ2NEQz?=
 =?utf-8?B?azFNb1k2MDBLTjg4S0o1cDFYTzhBS0ZtUTlHWEU0aHNMdzg0WmdYdXZQZzU5?=
 =?utf-8?B?WVMrRnpYeXVPNjNoSXdHUDFzcEIwb1hDcm02d05JVDloWDdGWENGeDJSOU5W?=
 =?utf-8?B?bXJGZ0p3TUhDMW5PL05JNXJvMTFMNlVqZnh6UzRUMlVleDFCWTJOTjdTT1lJ?=
 =?utf-8?B?VTQ3R1RQaDBiNWtvQlREcndvWE1abVBXcEFNNzBpVjlUamhhRDJlQXhkNmRm?=
 =?utf-8?B?MG03MDQxa1BmS3lRTWg3VUJ3K0I2NEhMOThGUTZ1RnUwMTZoVE1WNkZlVFhO?=
 =?utf-8?B?SEJNV3NJRmhRekVVdW1oano1VG94a1lRYjg3NVlmakFuNmRwY0JRVHJnQUdS?=
 =?utf-8?B?Zm51Y1hWeHZvM2ZoYjVNejVkeTFxeFQzYklOZUYreVk3cWVjUDltcmJPU3Yx?=
 =?utf-8?B?dXByN09TSEs0czBXeE44YVk5RElRaFBFd0svRUV3MVBSU0VibUlaYlUyc3oy?=
 =?utf-8?B?WGFmUnh6NHRVellmK2lBbTA4ZXFiYnBZZmRWYTJiZjdlZ3JheWNGZVlIL2Fq?=
 =?utf-8?B?NEpvUWhWbDlMTWQ0V1N1QUZsaGNaSlFscGlzR0lEVWpQdEloSDZWeEgzUlRZ?=
 =?utf-8?B?bUwxOENtZlJqbUVVdWo3eW0yRUhvdGxDWlNudVgwaDNZNUtMK3k3ajBWNWVS?=
 =?utf-8?B?SWJrTXJhamRuUlVveEtFUDBYaEw2cWV6Z3B4Lzd1RnlEN1lBS253YnVSckVr?=
 =?utf-8?B?UUxLUkdSeGN2QmtWMzRuTnI3ZUgvR3ZRek9rcUFUQXdHMWlHcGVyYlY2enFj?=
 =?utf-8?B?cTFzQVU5OFovZFVEanlaSlZTK0tvRTRSekc4enBMdUJ5Tm9laVUvYjVEc3NJ?=
 =?utf-8?B?WWZOMWZuL3czZSsvTVhMbjB3eXFFbllxWUJwMkVKeE8rV1V1bU9wRXlQTHJN?=
 =?utf-8?B?Z2x3T3d2TFVjOEFGd0h5by9zNlprc084V2dHZ3BCVm9pQnJGRnlRb1VRUnhy?=
 =?utf-8?B?amlrdVc1ZElaTTMvUVpqSnQ0eWtheWRMZ00wcE93WjNJRHVkdytEelJHT25W?=
 =?utf-8?B?a2JzUUdiZFVnWU5YQU5WeUFWQUJMdGFqWEo5UDJMbkIwZUg5Ly82RW94TjQz?=
 =?utf-8?B?SmlacURVV1ZHOUtZNXg3NzkydUFhVXV4TFRrbmREZFEvbXA5cm1wK3UyMUY1?=
 =?utf-8?B?QnpPMFBFbHQxMGN3eTlNNjlQem42OUhnNkFrcXdvSEZVUHdEOWNmdzR3eS9J?=
 =?utf-8?B?a1VSUER0cWZsOFA0eHNJTlJPZWtkTG1PZ2JTeWJKbHNZQllxS1pvRk9LMU50?=
 =?utf-8?B?aWhzR3RicnFZL09MTzNUcDJubHR4Z2RGOU9wanJHZk5iU3hkTmhxZG1TNzZh?=
 =?utf-8?B?dmJXNFNGKzJvZEo2bStDUndHTmRBTjRpdTJZcGkxeWhna2R5RGhPbHdmYUFW?=
 =?utf-8?B?ODlOSkVVTE1taW5lamFraU1HRTc0ZXVsSjR4b1JXMExaYVlsd0IxdkpqSU9x?=
 =?utf-8?Q?pzXohZXiG1zYLPkJIkGp0e6Qootq8e64wjir/kop1UY7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 591539bf-fa63-41b3-11f9-08dde78515fc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2025 05:21:34.3662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTgzNpY9APn3838pjA+kP/IHh9DXxnxXCX/sa2TIzu7IqwdsV9Hb+pHGzMCKWNuZdLnHGflQrL1lB/n09YiOfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348

On Sat Aug 30, 2025 at 6:11 AM JST, Daniel Almeida wrote:
> After some experimenting and further discussion, it is starting to look
> like Regulator<Dynamic> might be a footgun. It turns out that one can
> get the same behavior by correctly using just Regulator<Enabled> and
> Regulator<Disabled>, so there is no need to directly expose the manual
> refcounting ability of Regulator<Dynamic> to clients.
>
> Remove it while we do not have any other users.
>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

