Return-Path: <linux-kernel+bounces-792725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38262B3C81D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 07:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68CE416D39B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 05:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0FA1E5B64;
	Sat, 30 Aug 2025 05:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tIkEHidE"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA9078F52;
	Sat, 30 Aug 2025 05:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756531269; cv=fail; b=TYwb7u6+F1c6Vpz7sJ4wO5jxELT2Tel18znqRTpRoOE0y9OyLggCKDAaj4Jm5G7rDP/zW1hSQrAPMDeosDaqVwLG0zIiwBSpwT52Kc3uc6O3G+vw+XTgiRahVEqNW+GXwPSS0XqDOd9zzQ3TA2DjH0HZ+Ok1u68/4O61EKPI0s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756531269; c=relaxed/simple;
	bh=hOWNYNwkfHecdFcACxxjMtmLqABbs7kod/zHz7m3xas=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=HlDl3k+oI91GQbNg1vyB+vAHK3xUzgqqGhbMSIodaEb2G6PVhenAQPhWpMIqZvF5rgyN/cwA1f6r4+V/bP867eQsN+zu/TXD27nUWHCKvn+KUPgy+uZdff6/YiZ7QNqLpRto4TpSmNPyNNwOW+81DmZDFwzQJLXjuNS7DQcIWvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tIkEHidE; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCbpP76+UWXsBex62UfenaBm1pRHtafspKfUspdz50x8bi0XmHGPLGUx6mUOkVp4Dx+v0yLhsXBBamGsn6dWwahdi8sBL3E+CvHnP19acrEopuRoyaf0MXfZkYCEDgd3CPFWbMJ3HrAGZ2NFBys0urvoqf8ZMKCjd9iNGBA+aYYlywsaDMZGhfIF3Ncg+4QaIg6SHLmEQivDTY00q/FvX6nqKNC299r6tNzNTIQfGov1rr0411ZVJrceDicr8kDEdreBEetWpXIbARun2x4UvO61Inu3ps233yqPo9CaXARMShEzIRmOGLMmkMCLy7UzyqgPU2u5dR5XaOsLvu+v2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpjGWG6Ff4uNngs9mtxiJz5iQLzSpG2uZ4SG4oszZEg=;
 b=n0v4se04v75SLW3T0zhzv7RDFs+i4jcFho+kGGfOeCw4ZwY+ea7TmK0Zlk/Vt7qZq5Wuh9BYj3iiyIieRnDz38Qk9DWrVPSb+IauJVSbibI4Op8Ey13gGO/3tRywJ1hI6w0c+p1/9HmeT2bl4juF0gUeC1xGFQa+HMJfyyuN1vgYNoIvyAZxFWUAH7E3IMyf7rxhBmV7/SIBkLEuu1GlK/73VjqfzsFDxRuC7RViww49wYdbA4MZxH2NkbPVHG8iRhmrpnDV2+6B5q+ti45VySa4e/gZKyeFachyozUEIOo+XFe0Tc/4Gfg+u6QDwXqiken+o9qPttjojrW+9S/59Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpjGWG6Ff4uNngs9mtxiJz5iQLzSpG2uZ4SG4oszZEg=;
 b=tIkEHidEbi3TDMyS7/YZvYJM/bOoaiL3VXm1lD56CqKuwPFsg7RkDe2x5KTjK81Dhec56yzDO3yWoVKglyI3gggtKQ3k5lRGSE71teHs7S4LJGMQ8wzwKJWIr7OhsSHf22ij3BQVCBvLJmdJM/OyBexO80K0ZdZRULT4FaRmGjPT/efcI0Hj7289otIEV7BhxjXjB0wi3MRnsAsUMjeVBotshHfDGF21/MhemPSgV5Ex7V1rDfGTZ36ZohynSu3X85xZ03qFPqRz2/99WE+AoGQX9km0Q1w711O7W+ZWheA1AYcJcXM6j089Z2WkCMwRtJDLZtyoNf4Vvl7r2rCn1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Sat, 30 Aug
 2025 05:20:59 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9052.019; Sat, 30 Aug 2025
 05:20:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 Aug 2025 14:20:55 +0900
Message-Id: <DCFID32NEFH0.3JB41XV88JZ3F@nvidia.com>
Subject: Re: [PATCH 2/2] rust: regulator: add devm_regulator_get_enable API
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Daniel Almeida" <daniel.almeida@collabora.com>, "Liam Girdwood"
 <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250829-regulator-remove-dynamic-v1-0-deb59205e8e9@collabora.com> <20250829-regulator-remove-dynamic-v1-2-deb59205e8e9@collabora.com>
In-Reply-To: <20250829-regulator-remove-dynamic-v1-2-deb59205e8e9@collabora.com>
X-ClientProxiedBy: TYCP286CA0165.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW3PR12MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: 37c09777-1241-4b0a-7e0e-08dde78500e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|376014|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHRJS3MvWVZUa1BzQWNxTEs1Mmtka0Y1bk5SSGRWVlIvM2lvc0tIcVJTTStq?=
 =?utf-8?B?RGQ4Y1RZdXorakU2MFFTdmNQY1NEdFJCNkZTcWdEQXZPMEZGOEtJL0pNb2Nx?=
 =?utf-8?B?ZnBIK2JGVWEyQkRZZXNvaXJmcGxTR1pMRXhWSER4d0dDQkduT05Eb2s0VUZB?=
 =?utf-8?B?bERwbU13R1Rya04wekhUcC9KOXpjaVJvdy8xZjM4RnY0MlZ4ZGs0bTBpK0Nz?=
 =?utf-8?B?ZWJyellZd1g0Sk5LdFgvNFhMbldXY0tsdFhGbkZ2VVkrWWRsNEJqMEo1QVdk?=
 =?utf-8?B?QVpZLzQ0VXE5Q2lPem1RMkNiSjBMd0lneG5Wb294bmdlT0hOYUJPbExJN2dl?=
 =?utf-8?B?eEFpM0xkL2NtUXh5eGppTDFwckduOXVPanpITDdXUjhwbXRlbzczMlUvekhM?=
 =?utf-8?B?Z3dpMnRzUENZMUI1bzJZU2Z2T2pNUjY1REJXbkVrZ3hjRzVUM0I1dUdGYldR?=
 =?utf-8?B?STJyTXk4Y20rOWpRRFlONEdXMG9xV254NSszTFg3OFlVQWxjL0JoOWxtWmhK?=
 =?utf-8?B?ak5MczVQUXlRYUU1cXFrU0ppVnhBaHhEajEwdTBmekUxanR1b3BqdzFGWHhv?=
 =?utf-8?B?TUEwbXhMUFFnT0dhWktNZ2h3UWRSMzBWbzlMM3B6NnMwTm1kd0JaWllUdHE0?=
 =?utf-8?B?ODVtbk5OZmF4UnRNRkQ4cENKUXVFb0dTTy9FK0FUOWZHNjBOTTJYbmgydURk?=
 =?utf-8?B?SXcwUld4bHRCN3RraTZYRWJITUkvTTQyVnNCbzZaWFNYVEtSUW96S2ZUdmZK?=
 =?utf-8?B?REp1cjhpaTlHdDV4L3ZqL01QdUJmOUZLZUx0Z09MdXc5Y2lHcUlVWjZOVUky?=
 =?utf-8?B?TFpSMHV1L0xXV0xWRVY2VXg5K1VqYWpzellMaW9abUF6NXd0bzhHSmwyNGtG?=
 =?utf-8?B?bjhtdW5qOU9mZUFTNGRuNnZoV1F2R2hCM21VQThjUkFXNlZrK0FFM0YzSlRE?=
 =?utf-8?B?NWVzeDhaemRjVkNCc1JRMitBdDcrbTJNMmRQZXJxYlF4OWlFRGpwSWR5dWV4?=
 =?utf-8?B?MzVaeHRXMEJUai85a25qdlNRMlNjd0oxRWVQMnFCWmxkamh5RjhPeUVPRnRC?=
 =?utf-8?B?WU9GRWpmdzBpSXNlN2orRjh5dCtiSVdNRGpsdUhsZG5RVG1qUUU4S0hUc0dQ?=
 =?utf-8?B?YmE1Y0FOY2szOGgzUkZObDliWXB3RUozWUlTMzZ3VEREaTlhazVYRUpTN3Az?=
 =?utf-8?B?c1RnRCtid09ISlVhSlVtN1Z1dmJnSkxSUjVUMS9KdW5rNFdlRFFMNzZkZEJi?=
 =?utf-8?B?VXEzYis1ZWFQREZDcktJdUNkaUx3ZTVRRDkrTFRZWC81eGhoWU1qdmtXK0xw?=
 =?utf-8?B?MHNxcG4wQi9GSVd3UlRyVm5SMzdBS0J1Ynh0TVd3T3RETmJyOFVldTNoN0l4?=
 =?utf-8?B?UWRobThuOVZuRElrSWJSY2NWS3lMLzFsNFZNWDB4Wmt3MjFhNlQxWnFZbWo4?=
 =?utf-8?B?S1gwQjg1S2xteFkrUitTaE5oVnROVk81cDZWYnpLUXhSbC9heUMyVTRrVTBC?=
 =?utf-8?B?MkhHaGJ5VlJlZ0oyS1JtR0kzSmlCLzZaTkZWQTROaXhFMkpsdjRld1kyWGVL?=
 =?utf-8?B?YXlnL1hTYkhXNzJJR1JFTnNUZGI4V0FTZ2NIZWUrVk5lSk1DcnJDQW0zbldl?=
 =?utf-8?B?STJlNXpNT1RubUVQS3ZFVWJWZW9KakE2YUdaMkhzQkE5M281L0llbUM4Q3ZG?=
 =?utf-8?B?L2hjOTZyczB4Zk41eEQ1NlJWTjdUVDlOWHl0R3p3T2drK1YzYlNlNkZKYzVF?=
 =?utf-8?B?bWM1ait3N2VIcUgxU1VxL1doU1ZMVDZvODc1UGMxaDhqNThIQ0dOQlh2NWd4?=
 =?utf-8?B?NzFFQ3pBd0Nxb0h2Snc1VVlRYS9ieTY0VUhxakZka25BaW1pYlp4NWtmVGVL?=
 =?utf-8?B?YlFnYllkZ2t1VlBud3lVNEhMMkxqd2U0WnpmWVh0eHphYnVQNkRTVk85MnIw?=
 =?utf-8?B?bHNEOHFSaDNXSUlwNE12TzdTbThydHlTSFhXeWFCTmErMCs0Y0hIOUdlTGcz?=
 =?utf-8?B?ZUg1OVFrVWVnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWxDYmV1WXVhRUpiMDlvOGZjblRaU0NDdnpRVjhSVm03eHJET3o5VnpjN3ZY?=
 =?utf-8?B?WXBHUjcvclRkQmNFU3RZNnBBZG5lMFJ0QTNpeFkxRHdJRHJXaXR5aXMxTGtC?=
 =?utf-8?B?SmsyLytITEwzNi9tYmUyTkpMcGhSKzdmTWJrQWZwY3N1MXB4RlhacFFhZUFa?=
 =?utf-8?B?MFZGaVgzRWZhc3k5cFprWTNuRGxvQ2hSS3BhYW10VU1OR0dPS2VEbERNVmhU?=
 =?utf-8?B?WUNwZC9hb0JiMkxzdTVTNi84ZWN0citoZVNuWTA1cXFUNFJXYktWNnlybTdz?=
 =?utf-8?B?SFprWVQxcHB6c2dEYjFIRkxlN1lOZnFtYlVFQUw1SUZIeU9LRmhmRVRyODJn?=
 =?utf-8?B?MXlTSXAxYndRZlBJQUZ5K25Ya0RVVVNJVllKUTR3VGwvVVNSb29ueE1iTW5a?=
 =?utf-8?B?alFDSkExa2VlL21vcFBGR2FCYXN3U2VsY3pvQm5QQWk3QytUUkszYW1SNGpW?=
 =?utf-8?B?dVhiZ2FPekFOdnB6SDVDSGxYTWlBcTVjS05ZTy9HSmFoejdoemJDbGgwaHBY?=
 =?utf-8?B?MlZrTElzTGU4R2V2T3N5RnVmMXBLTWdqUExudjN6Q2RqQjE4RjRRNEFlRXRh?=
 =?utf-8?B?a2dBSU9lM09jR2hpSldvVUM2WmxmUHB5bFo4dDdXbDlVeUl5UzZIcm8xalk0?=
 =?utf-8?B?ZkYyN1lJQlhZZEltaFQ5NDU1UHo4Z0VralIzL2VsSk85eGZSOUJkeUFMTk5W?=
 =?utf-8?B?TFJaeVN5Q3drZDNYZmdIKzNjVGJlN3hhbGZ1UnNIeEp3QnErS0tqdDZ0UlA0?=
 =?utf-8?B?UlpmZWwrK2lqelpoUUtVa0dKNGZ3UkE3MXRIRVdKNHNPa1RGb1UzOWNCVWMz?=
 =?utf-8?B?RlRoZ00vdHEvVFFhSnExeHN5N0IyVTd1Tks2RGVORE8wcldBeXg5N1BaVSsy?=
 =?utf-8?B?elU4OXozWVFaTFB0VVlyM01Hd2tXYTNaOEg0N3liQWxrQzRUdmdQUjd3Qkor?=
 =?utf-8?B?MDBIMTA5M1ZVV1MzOVduZUtPQkFxMDk5YyswaVNoUFdxSFdBTElrUVlpL0Iv?=
 =?utf-8?B?SVQrZmU1R0FvWHZLMWJOdzVMZzFncCtiMWhiUFh4Q1NNK0tWMUFxTWZkNmU0?=
 =?utf-8?B?MGgvVXpMZldmRzRvYjRZaWIrNUVWRU1CT0huNGIyZFc2SDNQbHRyU1k0cEZz?=
 =?utf-8?B?RTFiK3pSM1V0UFFublVGZlJ6cXFaTTBvbFBJY0JqMTZtcUVpeEJuRTFwVWtC?=
 =?utf-8?B?OERMbU1TR2dLaEhVYXNaUkZxQTBVb0tTY25Ub1Z3M0Voc3dubUNkTG5GQUZO?=
 =?utf-8?B?S2xJeVNsR1VBVEtDdzFjYm5pQmo5RlovOWQ4NGhhVFQzRFRLMGhPQlR5ZC84?=
 =?utf-8?B?amhKV3g4eWdkY1hiRGtDN2ZHVHQyTVljcWp2TlpUSktNdFRFR2ZUNlJycm5u?=
 =?utf-8?B?ZzRPbjZzQ0t6U29DQmE2VnpwMkZQK0JSUWVhZFA1c1lHVW1XSnc5VURQSEFk?=
 =?utf-8?B?bmcwa0hNeEtvYloydDRJeVJJaERydUVBOE9TejM5WU03SXZOYUpyOHZhWHZh?=
 =?utf-8?B?RUd6SGRJek0xT1lWdE85OHFlem9JcG9qWGUxeWc1aTZiODR3cnJGSlNNcXV6?=
 =?utf-8?B?ZCtkM2Q2M0xJcFJwRFVvTG1wUm9FTjJ6L1hlVGRJMGZtNDRQZ0xSM0FER2lx?=
 =?utf-8?B?WS9mR3FLb214SElkZDIrR2pLaUtJdE1waFY3OFdUalpHZmIvV1MzSW5UM3ZX?=
 =?utf-8?B?eGRyMUp1QkFRUmQwTnpnTWQwWEs3RTloalZiRUVqL3krTm1hMVZ1K3EwTzNk?=
 =?utf-8?B?dWE3ZkROSlY2bi9qRllSQ01CWitxTFVOcGJkWXltRGdNVVk4NTAxWnY0M1hs?=
 =?utf-8?B?ckZraGVvRGVUL2NLcnBCdDl1ZysyVCt6QndSM0lSb1Q1Sk4zTzBhVExzWjBI?=
 =?utf-8?B?TEl6TVFtekduL3FjNE02SzBlUWxHdDQzUkt3NWkwUlorQTVBSWNxd0VkZ3lO?=
 =?utf-8?B?UmgrOGZaVWRDMnA5azUrYmxjd2REa3diMDVzSkxFeVpYRlk5alRSNmFMbnVh?=
 =?utf-8?B?M0lERXZMeU95Y1hURWhpSk1zUHpVK3U3cndyY3hNMmQxS0RRY09TcVdzeGJH?=
 =?utf-8?B?ZVJKRmhGV3MrbmdSdlROLzI2OEovNXM0azVIZ1lvWGFqUDRhekFBVXZsZVFE?=
 =?utf-8?B?WFE0NTJjOEczY1Bhc3NJLzlNeG5TS3lnWmp2d05GVjBYcjA2Nld5anpSU3Mw?=
 =?utf-8?Q?G1XHXqgw9tIoHItOnyLaL4HrxuUsVcdJ2cCtIJoe9fvA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c09777-1241-4b0a-7e0e-08dde78500e3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2025 05:20:59.3295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y14wiNAtpXAaJO3EGKo04cImO8dwObP07R1C0PPCUIympQlF2j41JSMi3fLlHRxx6Y/qGA8op4Hipv+Zo6/MEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348

On Sat Aug 30, 2025 at 6:11 AM JST, Daniel Almeida wrote:
> A lot of drivers only care about enabling the regulator for as long as
> the underlying Device is bound. This can be easily observed due to the
> extensive use of `devm_regulator_get_enable` and
> `devm_regulator_get_enable_optional` throughout the kernel.
>
> Therefore, make this helper available in Rust. Also add an example
> noting how it should be the default API unless the driver needs more
> fine-grained control over the regulator.
>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---
>  rust/helpers/regulator.c | 10 ++++++++++
>  rust/kernel/regulator.rs | 42 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 51 insertions(+), 1 deletion(-)
>
> diff --git a/rust/helpers/regulator.c b/rust/helpers/regulator.c
> index cd8b7ba648ee33dd14326c9242fb6c96ab8e32a7..11bc332443bd064f4b5afd350=
ffc045badff9076 100644
> --- a/rust/helpers/regulator.c
> +++ b/rust/helpers/regulator.c
> @@ -40,4 +40,14 @@ int rust_helper_regulator_is_enabled(struct regulator =
*regulator)
>  	return regulator_is_enabled(regulator);
>  }
> =20
> +int rust_helper_devm_regulator_get_enable(struct device *dev, const char=
 *id)
> +{
> +	return devm_regulator_get_enable(dev, id);
> +}
> +
> +int rust_helper_devm_regulator_get_enable_optional(struct device *dev, c=
onst char *id)
> +{
> +	return devm_regulator_get_enable_optional(dev, id);
> +}
> +
>  #endif
> diff --git a/rust/kernel/regulator.rs b/rust/kernel/regulator.rs
> index 60993373f4d911f4f0cbec2510f0c67efa24a51b..73d4c9b56dca9c676793d78e3=
5e5758d18eef3e8 100644
> --- a/rust/kernel/regulator.rs
> +++ b/rust/kernel/regulator.rs
> @@ -18,7 +18,7 @@
> =20
>  use crate::{
>      bindings,
> -    device::Device,
> +    device::{Bound, Device},
>      error::{from_err_ptr, to_result, Result},
>      prelude::*,
>  };
> @@ -70,6 +70,26 @@ pub struct Error<State: RegulatorState> {
>      pub regulator: Regulator<State>,
>  }
> =20
> +/// Enables a regulator whose lifetime is tied to the lifetime of `dev`.
> +///
> +/// This calls `regulator_disable()` and `regulator_put()` automatically=
 on
> +/// driver detach.
> +///
> +/// This API is identical to `devm_regulator_get_enable()`, and should b=
e
> +/// preferred if the caller only cares about the regulator being on.
> +pub fn enable(dev: &Device<Bound>, name: &CStr) -> Result {

The name `enable` sounds like it just enables a regulator, which is a bit
confusing IMHO. Maybe `get_enable` or `get_enable_for`? Not sure what
would be idiomatic here.

> +    // SAFETY: `dev` is a valid and bound device, while `name` is a vali=
d C
> +    // string.
> +    to_result(unsafe { bindings::devm_regulator_get_enable(dev.as_raw(),=
 name.as_ptr()) })
> +}
> +
> +/// Same as [`enable`], but calls `devm_regulator_get_enable_optional` i=
nstead.

Maybe explain in one sentence what `devm_regulator_get_enable_optional`
as it might not be completely obvious.

> +pub fn enable_optional(dev: &Device<Bound>, name: &CStr) -> Result {
> +    // SAFETY: `dev` is a valid and bound device, while `name` is a vali=
d C
> +    // string.
> +    to_result(unsafe { bindings::devm_regulator_get_enable_optional(dev.=
as_raw(), name.as_ptr()) })
> +}
> +
>  /// A `struct regulator` abstraction.
>  ///
>  /// # Examples
> @@ -146,6 +166,26 @@ pub struct Error<State: RegulatorState> {
>  /// }
>  /// ```
>  ///
> +/// If a driver only cares about the regulator being on for as long it i=
s bound
> +/// to a device, then it should use [`regulator::get_enabled`] or
> +/// [`regulator::get_enabled_optional`]. This should be the default use-=
case

I suppose you mean `enable` and `enable_optional` instead of
`get_enabled` and `get_enabled_optional` (although I personally would
favor the latter :)).


