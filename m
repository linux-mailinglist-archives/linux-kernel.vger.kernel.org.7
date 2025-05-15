Return-Path: <linux-kernel+bounces-649098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27362AB802F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 10:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07A297A926C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 08:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1278828688B;
	Thu, 15 May 2025 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bk0Tb9Xb"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFFB27D791;
	Thu, 15 May 2025 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747297214; cv=fail; b=W2QC4VvnG+ywKQC96tIM9kEmitti1OjQhtPX/t/QwT/lwSIt8Faw/LRUP9VVRqxKaQEbYtsmbVsmA8Eh5IaT2j8E4aY4CvElG8yTfZhgM3lfwNyi9eMXWMzbpDxW9i2Xq20MFJDZZ10n31BcHzlvQn0xXNtR/PzdPWXR/cbKdqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747297214; c=relaxed/simple;
	bh=uwdvp1O1ObVDxGVUumpOZjRdImA8CBYUGuIrNi1Ukwk=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=cU3mq61dAoUsB9+QdYrF5tYZWnG0mHCeJ6PFgBGY27XyrXykfirZPCQIkFbpS0QzDM8SDsq0srA4EbZCwbzDYrkwsKTptdVI6YD9CFoomFbZLoEFJC+WoYVS5Z9GG6Z7nlzALpP91gKDuu7JJH2UDXZ14P9b0Hf4PgI75t/clog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bk0Tb9Xb; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgkyp6IXY8ZUdiwMorZBRRzz7JDC6ZiAshMDDoAByZgixGvtyNwccECdD+VOqCi0jfghbCLoxXPasWkj8IyhWGSS0xbG+JBABMsOrc8ZMY9Ka/moWnonMzdVTWlwHwkWL79nEomua/3FXACU8sz/WUnhLUGoHE5gc/2ZfEPi9jEttgvNNVJR1RK8LYwUDV0pSRH8sxAYLYNfMhKZD/hYfn1vl/pjdWJaEvSvavgqiFz0wMJvYcGGhDJRxbwsYS9WLjxLsyiKpYu3ZNk4yE2FBtzJMpOcRZcDwiwG8U7DHd7iQlaFUIhC3ZXkCO5d7qQaqHW21sd/ohC+XvAvn87FJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwdvp1O1ObVDxGVUumpOZjRdImA8CBYUGuIrNi1Ukwk=;
 b=Mj9bpdnefRFkUCjj2LDqa+IHvwC94KW4CD8AGlPTagqskXYFI9I4eSY3z1KeF05Xy3SOY8lapkE7pmhI9BwQqvkO0iH1eKONZ9PL0hObAj1/zjy2jQ3lgvtt7RLCsz+/GWyYteWPWSq1z381M9j+48gxpnzl5otM81pxcP3sdYegPCezt7yLjRXn1mRquFXDXqp6LWBnUyisjQU91fLw+2rZTkh8uVy8ogRZKmtlrY9/CH+WSuONwW9L1TEk0CS4J8Zb6CgP7jDK1gdrIjkL4jRZnAmklK7f6tDcDqF2WNMSzgCy7D9jtcV4Dsz1rUtbnin70iAQYaOG2dHvs08T5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwdvp1O1ObVDxGVUumpOZjRdImA8CBYUGuIrNi1Ukwk=;
 b=bk0Tb9Xbf3TbyHZN47hF73QFqkOLkQG2Q5hCZsIotnbefaRTDi9QJm0TkGOsq7ryZZegZwmsL+8QUEcwNpInjxmJcIYvKrGQDvX6xViKNOQEUi1OHNY8vhKw/gQIub4d2Tp2mvXM8jNEGyZrhwTt7vrODmnQ6g/dKq7t+s5YKsrV4m+BCGRN0a7wXR3uUhrQ+KedoGIN0/A9ezSIImrIgR5Py53dYTHZyMZ7tLgWoghJcLnL5u6wptlC/9QU4108DXO8oQen0Cp1a4fXZNzA07OvEpyR+mOmw+3fOrygROZA/Pi9Vx5Dv3IXfy7MILutCZCTKLQ9frRBO7YjmdRZGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 08:20:09 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 08:20:08 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 May 2025 17:20:04 +0900
Message-Id: <D9WL5Y9Y3AIF.2B315CEVQI4VZ@nvidia.com>
Subject: Re: [PATCH 0/3] rust: select AUXILIARY_BUS instead of depending on
 it
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <benno.lossin@proton.me>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250515-aux_bus-v1-0-1781b54424e4@nvidia.com>
In-Reply-To: <20250515-aux_bus-v1-0-1781b54424e4@nvidia.com>
X-ClientProxiedBy: TYCP301CA0047.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: bc221f10-2bf1-470a-fb91-08dd93894daf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1pTMXg3OWgyUWhiRk9WNE5hMkJJMHY0ZE1vZW05bzdTbllhcTQ0Mk5WdTJK?=
 =?utf-8?B?Z1dtV0hJdjF3azVzakF0dkd4L1hnczEzUGpWcHF4NTFwbTBENmp3UDVLVDBB?=
 =?utf-8?B?czFFT1l5aFMvYldXbUtXdTZxLzFoME04NUF3NnVRZGNGdE9DMDgwUzZUV0VS?=
 =?utf-8?B?MzRlei9sekQwcUttVmdkeGZuWmg5YzhxVzZvMTBsWWJKLysyMGI1c2FOZXl6?=
 =?utf-8?B?aUI5RC9XMzJxRGlSbHVXZ3IxVUw5WXFLajY5OCthSnFibUVPcU5ibWtsaFBp?=
 =?utf-8?B?eXFrdGJYa0llV0xlS2I2bVExTDdKbC9sZGNNM1laT3lTTDV2T0lQaFpBRkha?=
 =?utf-8?B?SWUzUXczKzVBVmhtN25oYTVYVEV3cW1LdzZ2Y0FBcG5YdmVaeWR0US9xc3Ur?=
 =?utf-8?B?MVArenNhSFl0OWw2QXpPMFIyYnRZb2g5b2s3Y3NoSUloQmJvVmZyZ0Q4eXZU?=
 =?utf-8?B?WlVnbE5oc1BCSmhvOXFpdXRVYmxHTWhaTnVHRXg4NWhnRGlXV1RmM0t5bmM5?=
 =?utf-8?B?ZWdrdFg5QkxadThKcFJ4YlpwbnRtYWdEVnAyK3VuZGZQTnV1NVcrdzVjdnFX?=
 =?utf-8?B?TkVoSnYrTVgwODloWVpYOEhXVjZnUVdjWWtaN3dhd1o0ZWh0emR3ZG51WUtp?=
 =?utf-8?B?ZTQ4OEJ2bzRLNEplTXNOZXZqaEdld2tZejJrM2tNYTR5cU5DVEg5WkU2MmUw?=
 =?utf-8?B?SFVOa2ZYUElyRXdYVUp6SmozeGNkcWVyNjl4VTBVbWx3bGQybzNpSHh5RW5H?=
 =?utf-8?B?TTVCUUppZmdzY0NKamw3dGd5RmRvczUyWmY4N1IrRlpOeVRlcGZZSDZLSUJn?=
 =?utf-8?B?NkVwNzE1SythMUJmSGRkVGo0SmNYQkFxR1dFSEE0S2NoNmd6TWtBcnhkSG5Q?=
 =?utf-8?B?SDE0Y3hra3AyS0xHSjFjRDh4QkcwektIbkM2Zkc4bTNFZ0RVSGZFKzZ3bk81?=
 =?utf-8?B?cGpBSUpocGhqV2lxbnUzbmFrWElFTkJRaWY3a1lqcHBabS9MMHhxcEM1RWxv?=
 =?utf-8?B?R1lNK2dTSjVqdWpDVVhuVVBKRTVPay9mOHE1UUpqNW1uNFQrQU14UkpkSzZC?=
 =?utf-8?B?U1hpWDdtSzlBd0NRY29WMlNJcUUxQnhUNlBta1VZcFFRbUMyNkowSWFOaUZW?=
 =?utf-8?B?TENXM0JCaVQ5S2NTOUw2TDQ4RmgzNEhmeDhyTFc5ZVlxUWJjZlF6MElCdWRJ?=
 =?utf-8?B?aXpkeXZFT2swMmJsMHoxTWVGeEJhQnFZaHJTUUwxa3lGby9iTW1hM2dVUkdB?=
 =?utf-8?B?TTBrNnowWHBGYWUzeE5IV3dBU2FXYXhidEZ0clg2TlcrRVJjM2ZQRldZdUdV?=
 =?utf-8?B?Ti9pRGJoNUNNWmdoSUc4WHhtUllFQ0RaZGZ2MzFBZEFXaXAvRjZNUlZWK1di?=
 =?utf-8?B?UWNlRGQ0dkExM0RtL0RoVUhsaThoNXNyREFMYVFGc1pRSG9kazczVzV6WW01?=
 =?utf-8?B?TVRMa2ZGRm92bXlTQ083cDlNQkdaWkhDL0FoY1kwbE4zMkRRZ1BGQlJqKzBt?=
 =?utf-8?B?NkwvSnBOdjRTUkMxS0FNMTlTTm1wMnloRmlQTGFKVkRpWUJ4ZXUrWnZYNktt?=
 =?utf-8?B?YW11QUNUY3FjUW12djdjUlg3WnlCOGF2TXJCUDg2TXc0Q2N0QkFpQlFVRmF4?=
 =?utf-8?B?SEQraEQrQTNsN0l6djk1SXIyZDd0RmNqMkR2MzlyWGUwWk9INmJyWjNYRFht?=
 =?utf-8?B?VVMyWmlibDJsL3pYMmk0V29hQUNBdGpIRHFrSmw0MlRaR0dDK2M0blBZYzFP?=
 =?utf-8?B?ZnR0YVZDVW8xYVlGSlF2dEY5MnJITC9razdEQ1VqQXhNdWJQR0dna2tpSDV2?=
 =?utf-8?B?Y3pYNll6Z3YzbFFTVDRQb0FPTGIyeFFiTlVENit4KzBKeHZDcTMwS3Y2YjVK?=
 =?utf-8?B?OG9BeDVib3ZZNkN1RFdjZzkrNTdHUGVZSmhLdWFnR1NJeThvSlU3R3Z0ZUFm?=
 =?utf-8?B?NWljRDZGNXlmQ091dnhIb0ZiT1cxRzNFZVc5azh0aUl1Q1JyY3RTMkplYjFY?=
 =?utf-8?B?Z3l1d3VSdXRBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0owbE40ZUpYQmk3L21UL2x6K0plYUpyQ1p2dmtEWUtVUi9JUVgzZ1VycmR4?=
 =?utf-8?B?NjhZV2llNFBMTGlDaWd0VUIweDd4OUpRMzVwUkNQSW1Ka0VqTVEvT0ZCWGtL?=
 =?utf-8?B?WG9vZDhwQkxWVUJqSEJQVkk1QlNocTlmbkE2RnFxQnBLS1dYb2s5M21vamN2?=
 =?utf-8?B?YUFoajE5MGN5Y3hsTTdySWFXS1VoY3FuNGlVYVlmNlduT2tHSElxTWYxUEpk?=
 =?utf-8?B?UmlmaWVlYW9CbXFITDhtZGdEQzZKRnZTOThUWmo1UGVoVEZaK1pRdFhPSkIy?=
 =?utf-8?B?dzI3M1UwVGo0MFFEYlBKaFVVS1NneXpvc2JjcWpSU0FtdGFHbEo0MWZyTVJX?=
 =?utf-8?B?a3d3N0JxM3FpdTJiaVoySW1leFU4NE9nVStsOFRSQ2JTMjk4VTVLeFhaS2t0?=
 =?utf-8?B?dTZsWkRPQmcwVVdqZ2M1TjJmZzlKelF0WXRJSlRkS3dVcUV3ZHl1UWNuUk9x?=
 =?utf-8?B?TklpYmdDT0lvWVgreEpQVFV4UDFFbTcwS1BoamNJNVZMcnd5TXdiNUFPS0pH?=
 =?utf-8?B?Z01xYkMrY0dZZGl3Nm9MZ3I2MkVldjFzN3pSRmc5Tzd4VTd0Z2NYbXNTZlZv?=
 =?utf-8?B?c2ExSktOaEF2SUhWYUMzam40eml6L1NMUGZjbFBxRkhHSmhkK2w3M3NnNzRD?=
 =?utf-8?B?bURkVTUvVHZOc1VlTDNZVk5tNjdCbWtzQThneTlHbEJKYTI2ZzJmOUc0Snlz?=
 =?utf-8?B?YlFka2NkMU0vRzJOYmpoSTRQNEJtZTRvejNZUTNrTUZLcTA5U3Z5UjBVeVNo?=
 =?utf-8?B?YzZEblBmbVZJUkRoeFEyWlNLYkNhVFlEUkRtQWgrVjFrcTZrNlNoajI2OFlF?=
 =?utf-8?B?MUhUYjFqakhPNXoxejRROERnK1Nabm1RMkF1VDNUa0psa2YxOHFzU0ZOaGlY?=
 =?utf-8?B?YXN5bWhKRmI2Vys5R1YxNWNOdDgyRFNqOWxQb1VCZmVBclFRODRxZ2xkR1NI?=
 =?utf-8?B?ZnRXLys5NzNDd1ozWGJXelozSDlPUjdOeDIyRW9GMjlKQkp0NXVsNkNoQmY4?=
 =?utf-8?B?dHBiQWc0VVc5aDByTGo0bE9MdjJYOExabFQ3VytiajlSdmc0SnM0Q0Z4ZWpk?=
 =?utf-8?B?d1RGN05CdW85bzdQdjQwbi9YWFBmL3g3ejZiSE8rRUxBMGxPRFFmZjVQMUlU?=
 =?utf-8?B?Ujc3ODdJelFON1Q1bE9qK3dIZkRDOFNUWDNhaG5oWGsxWmlEYk9KeFo3Nngy?=
 =?utf-8?B?VDdBR2VKNEhUZXBPMVMrSjFHc21lOU1UZEZrMFBGUWpIMUhFZnhmMW9rZHdk?=
 =?utf-8?B?dHR3L3FTMzlxdEcxT3cxaEp6TkIya1FUQ0NYZmdVQzNKVEY2Q0ZxRkRjUEZq?=
 =?utf-8?B?QVlNMGNKM1k5VEZZN0RWK2xqVThjZ3dkVXhUSUE0bjRkaFVvSzMxVWlMUjJp?=
 =?utf-8?B?RjNWRGFTam9pdGlRMjBwMEdXQUtCekRFbWQxemVFbkNoVmpUcUNUWE9MZ2NF?=
 =?utf-8?B?Nm1WQy9pYVdISEs4NDRFYkg2WmcyaUZLcnV0ZEIzTDJaSHFhOFBJbEFZSGlC?=
 =?utf-8?B?UjlwNEFaWG52bi9CTkFweU9ySTIyVUUvZHhEZ0R3ZXFIbS9oOGQ0QVJnUVFh?=
 =?utf-8?B?aHlpUC9Ec3krZUc2ZTBDZStGRzJwZ1lsaHpmRUZORzFYZm1UYlJqRnZ3eWF1?=
 =?utf-8?B?YjdzSG9NWk9GRUVJVFkvVGFHK3orNFNDK2Mrbm8xeXpQdC9hWDdIQTRWVndZ?=
 =?utf-8?B?Y0JPWklrRVJjQUJSOGpUZGVuMG8rZVZiVnVLWGVxYlJWTjhJa2JuMHFBME1a?=
 =?utf-8?B?c2lzVjJpN2lrbXcxZzQvVDlLRXBMbGdsY3lRQjJHbHlrQ0s5WjNmQlMxdDBK?=
 =?utf-8?B?UzVmMWRGKzZoZXI1ZnczV0FYcVVtbFRsSlpjN2hTSVhDN21uQWdLV3MwZUVB?=
 =?utf-8?B?Q0VzVDBhSEZDRlBTTGRWQUp5YjVkL0hIWExwQWU0NjJTWXM2OUFoSjhFdjdy?=
 =?utf-8?B?ejFGZFkvaEt4TW8rV0FqM2g3UUFXUjBoazQzd3JJc0ZNWlhYbGhZTnlYZVNX?=
 =?utf-8?B?RXJXdytzZmdkVlp4Q01SNkxya1cyTlBnZFByY2p6ay94ZlpiS3djczdPQzVR?=
 =?utf-8?B?RVUxd1JJVGhrcTEyZ3FXK2NSTzdXbmk0cFgvRGxlOWRRT1NyUWpIVUxDMWp1?=
 =?utf-8?B?TWlDS2Fjb0VVV2xMLzNmNSsxM0ZsekFIWnh2elVzSkN5cW90dlNiQm5nL1JL?=
 =?utf-8?Q?qjaGvF5fvR1czgnt0h1ywAtoJwetJhR/FrdnPUrOjY67?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc221f10-2bf1-470a-fb91-08dd93894daf
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 08:20:08.2163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZebdW8Zn+Vb0dGa5SbALDlEpTK84IOzQy43SkE5GEmG5DDjKFjC9DpszS+wdveu3b/GypitWdE6Kk9U0iUjtjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962

On Thu May 15, 2025 at 3:26 PM JST, Alexandre Courbot wrote:
> I noticed this after trying to understand why my minimal Nova defconfig
> was not selecting NOVA_CORE anymore and why I couldn't even find it in
> menuconfig.
>
> CONFIG_AUXILIARY_BUS cannot be enabled directly and must be selected by
> another module. Options that depend on it thus cannot be enabled unless
> a different module selecting AUXILIARY_BUS is also enabled.
>
> All non-Rust modules using CONFIG_AUXILIARY_BUS select it, so it should
> make sense for the Rust ones to use that scheme as well.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Oops, these commits should have "Fixes:" tags, let me respin.

