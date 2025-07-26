Return-Path: <linux-kernel+bounces-746584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD73B12896
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 04:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD2F582D70
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 02:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC52A1E1DE3;
	Sat, 26 Jul 2025 02:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HRwjCPjv"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B8D17F4F6;
	Sat, 26 Jul 2025 02:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753497976; cv=fail; b=TUqy1NrbUFKhmw8iBSz93AL2/92KKBNuclspX67ih7K5/Hb34gj+nw6kewDtKcCiNIXjfTVi1PXt5NKyS6zSvEwXrcT72SXoWyr2nHQR2nnrNP/k+hwnSAYr1Y3gyFaIsducPx9pbkqf8c/l/r0wSeMQAwltXFperwbM4Sn/3rQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753497976; c=relaxed/simple;
	bh=+Of5/bqjeZFtV0Yri0ZG1ccvsbiu3GY1AUxIBvuazP8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=PO5JwPjvUorJ3iKUbo4CLBQtshfR/u4zfdY83kRJm04QmVSztcHSIxLzLczP2eY9Y7fGFL0Y/azcrGYhgbpTZrtf4LzfwJUR+NMk9CMZKH8JAavYsaVaAYtvpFhnearOCCuM9tBdydgH/4enkuSGk1+I1xF35ZLtbgLOeH0n9KU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HRwjCPjv; arc=fail smtp.client-ip=40.107.102.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMHVzuLx8OlSDIguWBg3x130RzGcVwGCeoMd2y03rgby0jB7JvlSRscF6d1rhwV4EeJeFV3aEFvyPYZQe3n+XnrP27PW+Czourr5NbKpQ5ybMAHpBhOXJ1wXzGvn5xE1QBUCkARnbDM9GYobRX+xMZ/hOXhFygArqhpcN7o/uTEgzYTZNEpVwkpuFdLwNVpzJPBfqCZh+rsre9x/w46RSRuTsc3T67amZ1Wi7qVHe5ytDVkh3gD53TRt8gpt/BJPbCEQUDHaowY5MhHF6T8o4bwExK+U9eetLRM96EZ9bd5njbWqodyMzamtsI6P7OuVs7aVxaj1e1X1B8eSa8y+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RWJ7SjoRf+jFh+HKYZSsQfYwWINBkijuKcNkLmXuVo=;
 b=wXPkR2BLhTtwK+QOGZYWHH+5WCa4y1dC7Tcpyj+h3i/ilItQrIlm1x1d3hPJKqLR2haj/3VifiZDKNi6l3PX6Fr5bqt6eIYqJwNz9QTT5vVODJZ3f8GgOBzrai8hY2NNbaJc9SnHoD5jRSy4QZ3n4PubpcgjbHLmkiRXJFn58nxBDKWliWrzRFJ5WCvnP+dAfM4tRRw2Oi93tbC2oCb448c12cb95h8vYfHZUas1hPHZmj5BTNM3+y6ZAncHQLSB2QpWL68UkRn/gOdn2Vuez4WxOyWnCNB7NaWiSpdpIr80uBDpg0vvCbF7ZLHSLM5X3kuL+YqtcjbfB6MmCp2v/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RWJ7SjoRf+jFh+HKYZSsQfYwWINBkijuKcNkLmXuVo=;
 b=HRwjCPjvXYxHG5rSCTMT8m4CzboL8lw3WaI4z5X4jafBJRW571cHBSvhJ+MuUG3k4y3Zwn1Em4ewW7qAXPKN3aEd6VcvT422z/ERqNm/qugVd1LvO4Th/uj8RSuI/rikuoJVLMjalJ0hgsjDAndfpD1niVEb6kMCpOdmHC+B0Ab2GVQa4tPvUh1lBr0OhfTi59o/Fuey0jIsxLE/XZJsZti9jjsSQbdCrXyl4WglJJcbqWuE9/9KH1CAR4CQT6lFyd4HmzIoArEM97zmAMbb46zKDZ5Up+0E+bbmvsXMsAMJlRXoLGQyp5lXGUzt+pvtEgnMx+563eY9O85CLC1NHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW4PR12MB6852.namprd12.prod.outlook.com (2603:10b6:303:207::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Sat, 26 Jul
 2025 02:46:12 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8964.019; Sat, 26 Jul 2025
 02:46:11 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 26 Jul 2025 11:46:07 +0900
Message-Id: <DBLN5HS5I4UT.2KP9UI3AUFJ99@nvidia.com>
Cc: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Christian S. Lima" <christiansantoslima21@gmail.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rust: transmute: add `as_bytes` method for `AsBytes`
 trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250725-as_bytes-v2-1-c6584c211a6c@nvidia.com>
 <a05133e0-0331-46ce-ab50-c423e40a3879@kernel.org>
In-Reply-To: <a05133e0-0331-46ce-ab50-c423e40a3879@kernel.org>
X-ClientProxiedBy: TYAPR01CA0060.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::24) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW4PR12MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: 7189fd7d-827f-437c-bbd3-08ddcbee94a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUw4cllyQzNXL25lTXdUN2xVTytZSmpESE1rRGE5QVY0dnBhdnlYaXpDdWJz?=
 =?utf-8?B?SzJrbzUrVFZDeG5yOGNDcytjYjROaVlSZlJDakdCRW94RGllWCtvRVFVYXBP?=
 =?utf-8?B?UXBZSDl3Y3hsYXJ3a2hwVlFkZXBLdlFDWFdJdGlpcDRhS2VvUExRb21LZmNB?=
 =?utf-8?B?cmNEbFlhRTFyTnJZUWtROGVmWDBSZGZESGVUQmpZc2xPZGlaaXRuTE13MjQ4?=
 =?utf-8?B?bnFhVi9OVHVybEJ5UzU4MXcrRkFWSDI4SDRnR3NJa3h6dEJicngrb0JsV2ky?=
 =?utf-8?B?YW45ZGoxbXRZTXhTVHVZU1Y4Ky92bis3OXRLZWpOZlRJbGxOWStvaHUwUzZO?=
 =?utf-8?B?STIvekhWUEgwNzJrTVdwellTSmI2RTVVbUFzNFhqM1NBcWRKZGU3ZzdUY2lu?=
 =?utf-8?B?QkRWYVA3UFBjem1ZMWN4LzBEeC83WWh4MTl6UGNQcFE5QWdsYjU4L016bXR0?=
 =?utf-8?B?aXlFVDdIQzFydHNYUCtIdm1OTk53by9tU1dEdHgzWS9zd2VHSFk0WWdFaHdx?=
 =?utf-8?B?NDZzMS9NN1NMeDlITGwxVnRhV2k2cTZtNEppVHVJTEJHT0ZUV1hodzU3RjBt?=
 =?utf-8?B?QzNmQm1OQlZTcnBhZkdlWWxpaVVGcUZyNkFjdVJpZ1lzV1h6Ui9TTmo0NEUy?=
 =?utf-8?B?R2p4SUFXWWdLRjgwU1gvSkE2OTArMHRFTGlTTWk3aWlOSXBRUWo1Y0FlWUFu?=
 =?utf-8?B?TE02TnVTdkFNQ0JUcW0wakZuZ0c0SkhsUXpsMGpYSlcvNXZGZlBXeW5nL2R6?=
 =?utf-8?B?UzdMV1NVUUpDc0hYNVNLZmplbEhxM0d6Y2ZGcEpFanVkNS83UW40M1J1Ui95?=
 =?utf-8?B?R3pjcDNFTzVXcVBKMmh3SG5ML250Sm5IUG9KajU4M1QwajdrWUpKbUJwUHlH?=
 =?utf-8?B?ZWdQWm1FR3NVWFBoQWRjQS9KT1ppbFpMb3FSZkJlRHJTSlNvZGdSdlNvMW5J?=
 =?utf-8?B?ck1WK2I3K0hHUUFVaUx1ZzdwTGorVW00czFraEMxRE5qQ2Q0aU1Yb24wZ1lD?=
 =?utf-8?B?eTBOWnpGeWo5N3IxcWFyelo0RWl0b0hpdVFiMTN1TVpoMnlXalFDRVNSWkZX?=
 =?utf-8?B?UHlFOXpzSmZqaE1FenM1ZjJCME9PMS9MbkNrUG9CdHlKaVR3VGs4QUNWK2FN?=
 =?utf-8?B?L0d3UDVQTDFGUGxxdk1Ub1NjcFVWeEpEaGh5WHFHdmlzVzhXUlYvbzBlQk05?=
 =?utf-8?B?VFMvdllCVHNMb2RZUDUzRDJ3Wmtla1d0NjRMVStlSkdOMEdhb3diOHpMVFh2?=
 =?utf-8?B?NEZSa2tvbVJGc084aXZLUXplczloZkF4cXlXZWZ2NGRkWGovc3UzbHE5UnFX?=
 =?utf-8?B?STZOdFdUMlVJRHg0aEREUzNUNm95SEdhU01JTWxwWVIvbFA5b3hVSWx2MFUz?=
 =?utf-8?B?T3djT3EwQ21ORWxFVVI2V2dXd2hia3RNK1A5ZTNQYTRnSm5FOUhyVElGY01i?=
 =?utf-8?B?NXNRRHdRSnN5cWxBdVVCcFZsbTBwZXNWYTlHc3FEdGZ0U1BEQ09Ba1JzY1Bm?=
 =?utf-8?B?c2RySjRkOXpGeXIwZVUvaFVoaUJhelBIUzlESXFJQW4yL1NVS2pycHhxYzRH?=
 =?utf-8?B?d0toOGZQNFZoWm1PdmppL2F4RXh5RUc2cS9GNkFRVUtZSXVyQXR1bEVHN3Nk?=
 =?utf-8?B?L2tody9MQ0l0RHJGS3BsVnplV2dPVXY0NnQxdUJLVXJpTFBPNm9QVXBIK3VK?=
 =?utf-8?B?NXRPQkhGK0ZXT240QU9maUtpNVp6VEZPVSs4djNqMEV6aTd4VXM1czhjUTJa?=
 =?utf-8?B?dVFoRkdGTVVJNERpd1RGMkRueGl4ZklIWFV6R0JBdnJVdUY5QWxZZkVYUzRO?=
 =?utf-8?B?YU54cTRHcnQ0WFhWSnJ3MU50L203YnhyMkYxamJkTEdPNmtjVDIvUkQrckc5?=
 =?utf-8?B?THJXWlAzR3I1RVVWZ1ora05LVDdBNCtyT2ltQW90ZHNWYWxIVHdDNEI1YUJH?=
 =?utf-8?Q?3IEzcvg4af4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWFMZmo3bHozek90VGdNWDF2RFgrVUg1cWdkVDFzQkxia2V6cVp0WVl6cHhD?=
 =?utf-8?B?cmtDa1lxRHhabkJTaWluTUVTWXh5eDd6NU5yM244bWM1WlAzdTRuMkhpQmxv?=
 =?utf-8?B?Q1VvbnkwQmRBZzEwdUdhcmgxVzBYa3BkVTlmU2ZNOUJpMW81bzNRNTdyWnpx?=
 =?utf-8?B?TmNTVmhia2FnQnVmUnlHeko4VXI0MjE5K0t2UXY2dGxRTTVQdXY0OEVhRzVM?=
 =?utf-8?B?KzNzWXFvN0kremROT1QrQnRYb3FnNEowL0NDdUxMbGRnMG41WWIvNW9mRkJo?=
 =?utf-8?B?dHJmb0tWZGN0cTBkT2pVN1RNRFJQWDNLYnAzVk1HK2ZvTkpiaEJEVkIrUGNO?=
 =?utf-8?B?cXF0MU5KTmlwdVFsZ1VRUjg2bk5QMnVYcExMbEhwaFBobUVFOXhaY2E5U3hs?=
 =?utf-8?B?TGgyV241d3VMbmNHc2VnRmZrVXEyZkVRVkJ3bEE0R0s3WW9CUjhoUTJzK3Bt?=
 =?utf-8?B?TnBJQmhYZWdhWXI1Q29zQmFtL0VrM2ZLTVdabDF6clNWWUpNZFFwRWNJdUEz?=
 =?utf-8?B?ZFAveWVhcStGbHBQWVJUblRvSlFnc0xwaUIzTWRhK1JqMGZFY0g3QU5UQ1JT?=
 =?utf-8?B?TmJYazBJSHdYSkg4WkVUc1hlU011R2s5cjBTSVRoTmJlS0dYY2NwblkrWWlq?=
 =?utf-8?B?MzZSQ1pPVTM3aXFjanlEQ1huZG5FTXlIOExTcU0vaHVqR3AydnFjai9aUFlk?=
 =?utf-8?B?SHZ6MXJhd0lRQ042dmkyZC9iZmlOelB4TS9LVFdQN0JrYjcxWGVhNjVONGRn?=
 =?utf-8?B?RjJmb3pLSm1wblY0bTkwb3BKMGJ0cXl1dkFHYVRjcWtIOTVVTmFiamZ3bVJL?=
 =?utf-8?B?ZU4vbGtVaGs2b3BEOTR4RFI5R2ovRWFKSUltUGRsTXJxMEtoM1diUElDWnRO?=
 =?utf-8?B?OEtMckc0eFdjKzRKbm1wN3l0dkUvNG0zSkxjRTJnSFEvak1mQTdGa2liYVFH?=
 =?utf-8?B?MDNNWlhaQnQ3ckJFaDFIak0wUjlzcHg4T2hkVUc2Tk5yb3dONlJ6dXh1QmE1?=
 =?utf-8?B?M09yMHkxM1A1eVJsTjE3Z1ExUkRKNWx1eGE1Y0JZRmRCVWNaazBqVkxackVB?=
 =?utf-8?B?Y2dwTjIyOVM3MWNtT3JseFR6TVZyQTVva250djA2KzFCMkJKaHR2dGI2RW1B?=
 =?utf-8?B?bzVBOEMya0M5RzNXN09RSmpqc3lnNEUxWGpTWU1aMXUrSGp5dkZPc1VFSTRJ?=
 =?utf-8?B?aVB6SmpobVRhNlpiWVgrV3lLOEUrcHZCdUNUQThuWFE5MFcvNUR4SFFtcVlB?=
 =?utf-8?B?VGhRelpiOHc3SDVGR0hKZjMxU2dmcEhsTlFNQURKRlp1aXpkMUpVN3ZXYURm?=
 =?utf-8?B?bmZWdnlnWHVpZjB1K3ZpNnNLa0xIZkR4OU9iOHR3RzI5MitodHM1SjQ0WHZT?=
 =?utf-8?B?T0l3WGIwUm5GaXgvVXpodXRYcStrMGN1YS9tM1FzNEg4UTB6bHpkb2pJeE1H?=
 =?utf-8?B?WGkxald1Wkw1bXZZbG0xbFc5ZTI0Z1JWSS9FYm81QVdNWU5rVTY1Y3JlRm55?=
 =?utf-8?B?Z1JIUytRSXFzQTRPNnp0dzBtRGNjeHFxY0U0Zmg2djBhUXNzK0xMaFZOTVVa?=
 =?utf-8?B?WEhNVzFnS2pxUWFraVA1eEdPY1Z5eWNjSHdJYWEweUJ5aUxIdXlPY29xYjBz?=
 =?utf-8?B?OEhIRDZ6TXNSYzlKd0dNYnFHRStSVndjY1FmOEhaWEpIRzIrU0dtNWROS2tT?=
 =?utf-8?B?UjdKNnJZUDI5VzNoZ3dZbHVoVWpjaCtkb2pZRTdzcXltMy9aZG4reXNyMTI3?=
 =?utf-8?B?STI1UllmNDdzSE9RbkJXRHJkK3V0dzlxNzRmZ3dremFxZ1VSeFFrc1NLcFA0?=
 =?utf-8?B?NTlkVEt0M1VSQ2k4VlhodnBTUjBrY1hyazNCV1JjQUUzRTFMZWxNTG5EcFF3?=
 =?utf-8?B?ZFMwamFZYXJvZnZ0RHZCckduQ0FldUVYRnM2TkJOWTBwOG00eU8vN2VwanVH?=
 =?utf-8?B?OTluOGd3Y1VJeHRGclRmbHMzYmdLMWRKOUtwTkcvV2FhNlJvSmt1NmtaWWl0?=
 =?utf-8?B?aFJaUi9Zb1lQYzBsOTRoUm8rZnFWazJObVgrbEVPeHY5aXRRem94bHFxVlNi?=
 =?utf-8?B?ZTZ0UmxUUS92K09KdXoyTlhWMlREQTF5dDlMK3VERVZuUzJOTFV0NUwydU1L?=
 =?utf-8?B?R1pnNzAySHBlSmxuT3NKcW9NcGVVV1orb28rOE81cWRlcXdUUTVzQzV5cnV2?=
 =?utf-8?Q?liJMpfZU8y84rx5Gb/3fSwKIpPSYutBajnhpPx8jwHz4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7189fd7d-827f-437c-bbd3-08ddcbee94a6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2025 02:46:11.7049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TQ/wfohOqxCMtDZIfwVX/ntZIPBl6U5a6D8Nz7tInNT5Tyqz+UsxQA2TBcKrxc3nQkOXw6hgR6gIQ+pwxo7zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6852

On Sat Jul 26, 2025 at 12:07 AM JST, Danilo Krummrich wrote:
> On 7/25/25 3:08 PM, Alexandre Courbot wrote:
>> diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
>> index 1c7d43771a37b90150de86699f114a2ffb84db91..d4036986a3d7fb97e5da3e12=
1e9590ad23b784e9 100644
>> --- a/rust/kernel/transmute.rs
>> +++ b/rust/kernel/transmute.rs
>> @@ -47,7 +47,16 @@ macro_rules! impl_frombytes {
>>   ///
>>   /// Values of this type may not contain any uninitialized bytes. This =
type must not have interior
>>   /// mutability.
>> -pub unsafe trait AsBytes {}
>> +pub unsafe trait AsBytes {
>> +    /// Returns `self` as a slice of bytes.
>> +    fn as_bytes(&self) -> &[u8] {
>> +        let data =3D (self as *const Self).cast::<u8>();
>
> I'd probably use from_ref() instead. With that,

Oh yes I always forget about this one...

>
> 	Reviewed-by: Danilo Krummrich <dakr@kernel.org>

Thanks!

