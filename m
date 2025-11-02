Return-Path: <linux-kernel+bounces-881623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCF4C2894F
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 03:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03C01897915
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 02:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AF723A9A8;
	Sun,  2 Nov 2025 02:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AJG5eULZ"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011056.outbound.protection.outlook.com [40.107.208.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C9B51022;
	Sun,  2 Nov 2025 02:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762049154; cv=fail; b=QmXZJgxzqwuHe49kZ7R9rXFM66roQZIROPyXMYjRp09GwM5lqqsBM6Fb5E5rmpzlqNOJBVYWLEEnW7O+6XW7GbXMqmhpboJt3fzE3PjzCkwSrr2TBeVlJI4/6d5e7fFQVS2VoleoCie1VOrdhAyUe3pyFs93Jshva4lArrzTZk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762049154; c=relaxed/simple;
	bh=N76OFTTMrjqsyD10qhsdl4d6dGlEdEGrVobcIc4MOwY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=DDFOMpXfR5XtQ9UI4HmY6KW7rITm26jCwliE3+wm7VNCHdP3Guf0Scttdsoof/teyIdAycle38UAah8jq8c6WoDa06QBW3j8BVzRnd0ctvtU59/emdxZQZoWvZzwZa7wWPTV54p00qWSXqtLSZylGSFWVVYSwBA7oSttuLD+qWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AJG5eULZ; arc=fail smtp.client-ip=40.107.208.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7Wwu4SR/oSnq1kTC4MsdoywdSnKRp0gRqn+oVJO/umR/+z0gSqroQUxP3f0PjkrIoZCic1tgd0i+qsFEXbe9ycmDrFtXYVN7nIiMEAnsaN4l2Ay+tSoZFVm8pOmsuq9pyd/7hP+9UoPq0oz/uCWLzAvODbeggfIdOtOfq4Lw3w48Ly4QClvAYN8H79ManpsPUJqUpooHaUavHdPjv1iZ4BBMGLhdc96KQgbfnAYjHh/ZFFjtF7J5GvmsD68sGRJ4hGJMBITfDgNKqgB+f3iOW3ifXu+5Eas9cCvS9S650HHtMKaMaz+6y+YphhupjVgGTNWHDvT/TnzdWfG9YtT8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kf/ZLwDhy16+CT4Jk/y0wcUUSfM2/y7dUjDOSWks8oU=;
 b=WBj3MsfQVisQ7/78eaSwC0vq+nFBS4mnrgEvFRu0cIZIGEklWMp29Cg8nj62eGEWmFv0/aZ2mTupL8GsZox4rN3W8XneKeVACL7j2Gd1FHBr49iXzM0peONkstsekKgs57g7RVPYFT5ELiouBP4jz6fxOeanfa43yzJHKsuSDsDJ1wZyh/3KF/TTYpQV6dmq8p4sngnyZ/F+rmdZXgIY7Afc8VYVZB8j2et8jVH7p5gkGccDksk1tawjss6P/KRnqm8r5PqrkheUOaSnq8rjcBGQiQZCJiX8yWYTnQQrFuc5/JnKrlWd/mo6JCJndpXq/F1HNT2R8uTDNKTQm57gog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kf/ZLwDhy16+CT4Jk/y0wcUUSfM2/y7dUjDOSWks8oU=;
 b=AJG5eULZwOkLGCfzUkxprd5lf2k7wsuMm6JdHYOOIb8TAcj6i2nnQPdxtHvp3FeGCsvlmvlU13Iupmm81svycmVEExC+zRn7V6oxvpSxNf0x6BCk6ymbfeSqkcmU/Dk/C+Qwo7dRhwHyNr0nM02JISPJ36e4PGl/WXJFtIGNOrgLt08Omyc0R9gMqDPxpkjtMPAsjsfHR11/u6tTLzL3PwZkJ867voxasGhVfdS4xEsmsJOAZK34wZ/hWjT/4qvTAz8mFvAm+mhA0p1k0wy1gUNjDmpvcYnWhVl96fIBQG7eoJX15HRWrkkH71fAYEGn0drASz0EWccC2a7gYjMS2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB7874.namprd12.prod.outlook.com (2603:10b6:8:141::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sun, 2 Nov
 2025 02:05:47 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9275.013; Sun, 2 Nov 2025
 02:05:47 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 02 Nov 2025 11:05:41 +0900
Message-Id: <DDXUAGO6JUZ9.1S23GJLS39DBD@nvidia.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] rust: transmute: add `from_bytes_prefix` family
 of methods
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251101-b4-frombytes-prefix-v1-1-0d9c1fd63b34@nvidia.com>
 <DDXEOPKO5RV5.37NXWB7O9AA6K@kernel.org>
In-Reply-To: <DDXEOPKO5RV5.37NXWB7O9AA6K@kernel.org>
X-ClientProxiedBy: TY4P286CA0070.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: 98784d3a-628d-442d-93b1-08de19b45658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGQvTXRvTFZrd3JJMUk3KzdZaFQ1Y0JEQnlGN2ROdTcwdHFtMDhkM0wyM2JS?=
 =?utf-8?B?SDBqV0lCMmlhZ2EwM0dIcCtCbEJ2MjhGdW1iV0pWM3dUZ0RGTkRxTUlLQmx0?=
 =?utf-8?B?bXo0eGFzL25Rbm9SME44ajJLT0hQc1pHK0FSeHhhbHFPa0lrcG1hUVY5TmFC?=
 =?utf-8?B?Ukg0OWFoVndzdEJKTmNaMnY2U0JyUDZLVjJjQWZWVjVIZGdkdEowODdCc1ZE?=
 =?utf-8?B?RWxmWVNZc3NBUjEwS1BqMmhTM3o5T1lxWjNRbndLdUJGdllsNXdxbTViZjZD?=
 =?utf-8?B?NDdYYml0eWs1Z1BUd1lIV3Myd0xQT3RiVHhDVmdqcTZrM0pYd1Uyd0t1TDlD?=
 =?utf-8?B?Y3hqT3IrdkxyTUFLelpZRXMrT2ZtMno5MlNlS0lrR3VKYlhnUG5HMnVEVGU4?=
 =?utf-8?B?ckRDNEkxaFlRZDM0U3FzdnJRMDVJa1orTGpvYUdpMk1iZHZBV3NMUC9nK0pz?=
 =?utf-8?B?OXlRRHM2TFFGcTJVVzNVaElRRExjTk1hNjRvcU1GVmtkTmY0L3BZWkdGa0Jo?=
 =?utf-8?B?Z2xHL0kxL25TN05taGx6QTJkSlJId2ZIZ0xlWDlYWjY1aGhMU0NVYVVOWnBY?=
 =?utf-8?B?VVU0bWJQbUtud1FkNUxNNW9FS3EwMjlLLzdac3FNRkpJWEl6ZUsrTnFsOCta?=
 =?utf-8?B?QUJ0YlZjN0c1dVpXRmphVnk2a3ZqSGFKakZLdXhZdGd1aEU0OTk0alVQYlZV?=
 =?utf-8?B?Sm1Md0ZKTmRDZ0JMOHc2WjZpK3RlVk1PYlhXZGlsT2kraWc0elV1UnZqd0Za?=
 =?utf-8?B?K2VBbWJralZuVFBmQnlHQllZQjR5T3hDWS9leEVobGJLbUppeU1OZVJnSEMy?=
 =?utf-8?B?Q1IwZ3BrNklCcVFCcGttNGpCMXlWclYwclo3SVZkQWVyYzYvZ0x3UjV2dDFG?=
 =?utf-8?B?aDk5SWhOR0I0S01SM2h6dDRrbjlIa3VlTjJJazJRWThGWnZtSUJnMVdCL0l3?=
 =?utf-8?B?Q3F3TXd0Z2Y4ekI5UlJ4a1JhaUp1MEVjK1dNVDJROEpsVGx1RHIxZDFBYk1G?=
 =?utf-8?B?NzJ5UjQzRGJBRkJ3Q0ppckhkTzRhRS9ld0V2VXV4d1FWMExiaXdscklWenhx?=
 =?utf-8?B?SGR6TlI2ZFFWK3NRV0Y5Ym1Bd1M2WjFyMThRK3MwSkNkRUFHK1JyRHNrODZr?=
 =?utf-8?B?L1pzai9MZnhpWDlRNmdNN3FJV1R2ZmFOcEliRVIxSEMvT0llVUtaaS9rdVFt?=
 =?utf-8?B?SnllMEs3enBNbDQxNVc4YlRERFcvbU92UC9Rb0tITXE3UDh1U09ZQVZsSzRr?=
 =?utf-8?B?SU1zMWtHNjFzNkppK2N0blZhV1FaaVZLWkkvM3pWdVZKL0ljOS92N2JKeGtj?=
 =?utf-8?B?dzcrT1pkMnZncld2VzRBNTB6YkN2TDFmUDdrWDdFcFdhWS9mQUJPT2huY3FC?=
 =?utf-8?B?SkhGaUpONkpaY21ldGtNV2k3UmV3a2RjUmsvQXAwTnRqR21HUWJLU2IvOUJn?=
 =?utf-8?B?UWxkMzIwaE1aVkx1NDJtczIwVVNWVU0yRlF4WlJKTWVuVkkrY2p1eDRKWm03?=
 =?utf-8?B?T1JSTzNkNkRtbEJWenBvSXZNWGkxamFVYVBYVkVYeENDSmkyMmNFb0NtQXJK?=
 =?utf-8?B?SzR0Q1d6cDE0RlVVMzN2eXVhakhFUHptTUltYkg5dUpxalE3L0d0WGxPRWhW?=
 =?utf-8?B?VmNHbkY2alVEUm5NOUJ4eElYZ2k0YjJ6Z1NyWkprQ1ZYeDVUQjdGMlBJMkdh?=
 =?utf-8?B?MS9INU83bDF1YXpRaHpFT0VGMCs3M3EwakRPV1JXbVZPNTFod0hDU1N4bUtp?=
 =?utf-8?B?QURKc2VadHBtZ3BtSm1ORzgrOFlLZXo4d2VNRHJjbUR2R2tyd2p4T3dDYjhu?=
 =?utf-8?B?TnFTSVlVWlVPak5HWFFxeENieE5RekEwak9OcE1lQUgzY0pGRVp0TmM4aVg2?=
 =?utf-8?B?emMrcS9TbFJ2enlVMndCd2RSeisyZ0VuSXpsZkZSdFF2QUdxUlIxay9NYXRU?=
 =?utf-8?Q?jgPQuKWG9nSMFFBj7BN4hEhhjVqX0x1E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2hJbnd5UWF4aGVCZmpJZzc3RTI2ellxQllDZWNQQ0dJMlhzQnFUYkd6T3hw?=
 =?utf-8?B?L2g2U0pZM2FzV0ZBRHVGK3kvNWdZTlBPSjBLYmRjNGRpc1JzczZ6elM1UGF3?=
 =?utf-8?B?QmliQTRCcTRrZnZyS01KcFJEd1ZrNEdDREhsSnNISmRENXlLTld3cndvc3o4?=
 =?utf-8?B?Q1VRVVNhVW4zN2hyQ1MwMFVkTSt1aUF6NHlFVlFwMHVrd3lKazVTbGtwYjhm?=
 =?utf-8?B?RDhqTmxYZzh2QXE3aVV2aiswQjhhb2p6bkdwenFkTU9ZTkV3RW9Wd3VlaXV6?=
 =?utf-8?B?VUMyQzZZcEZTbHovZzkyRFhQOUd5MHQ3NzBNK2xYc2tlRW56MSt0aFhjdjg5?=
 =?utf-8?B?MjMrSEFWd3NhNXM2dWNFejBYNWliV0RFNTUxdzVsTlJhVEZha3BtQVdDMy9z?=
 =?utf-8?B?dkxFa0J6UFZQVEhKd0pRQkpudDNyMFBhL0xESDVtMEhmREFBZGtOVWFob2E4?=
 =?utf-8?B?U2pIOE41dEVIMnBNZzdua3ZYbmZJU092WGtYVXRjVFNBc01JYTR1czRHOGJ6?=
 =?utf-8?B?N2xmSzJOMEtoK1E5SWJsOUROUisrQ2VhS2ZiT0ZmUmdOZzNoZXpGcENJemM4?=
 =?utf-8?B?eG5OWjloOGJCa3pUUkFGWFVPQjJUT3p2WHBMVGhWeGlSM0FCOFZNVVZmc1J1?=
 =?utf-8?B?ZW5FUG9BM05VL1U1c2hjZ2x1V01yVElYWUdSbzU2NndCNnhPTEtrMThRNVNU?=
 =?utf-8?B?ODFLTUVSUWxEbExBeTFOOVUvNThPb0FLYnFZUzNVdHROL2owQTZTZVNHV2lx?=
 =?utf-8?B?L21LcENqNTFLSE8vZzl6TlF1R3g5UTVURXQ5ZnBvUmVOYzRxR2FnWStJbUpB?=
 =?utf-8?B?SEZPM29lVUR3aUtMM2JYbUJ0am5QRWxhcHRSYjZnYVY3NUJsVjBab1EwdXdV?=
 =?utf-8?B?RlhSci9HcEJvQkxvbUt5S05oVDh3S1AyL3Uxb2VBYmduK0kwY0NtdythRno0?=
 =?utf-8?B?NE1aM1NLVTFwbVQ2U2lxSkpNVzJQR0I2RUJJMGtxRGMrck1iRHB5TWJKWGpS?=
 =?utf-8?B?NUF2czg5OFlrdWF3QU5LYVNmaVY2VFlFZU1IWnpMOCtHbnpoSlZrTkFMdEJ6?=
 =?utf-8?B?RTFIa3hES2h6Ung4VnE0SzFRQ2owcGxEdzJCcWtYZldtam5idjdKYk9WQ0l1?=
 =?utf-8?B?RHkzV3h6eUhkbmcySTBLeUtHK040Y3Y5NHJWc0RkcDJzTkJBWEd5WUFGdHlV?=
 =?utf-8?B?b2FqZ1JXK2gvL2hPOFdtTWQ1MGk1b1FMd2ppR3R4UGF2VTh1U2RlcXY0R2pQ?=
 =?utf-8?B?TVdkdGhEenAwR2I0WUhNSHVuOTFTdDZKUHpTOVI5Y3VYbFl5N05OZ0M4T1hT?=
 =?utf-8?B?NnpuVndBQTh3TFJ1eFV1U2kydktjQktXc1RqcDhLYUdwRGpPcjRXM1h5VnVD?=
 =?utf-8?B?TmNaUkQ0OWxZWFVnLzBLRlpNdnhUcHJLSjRhNktYTlg0Z0EvUkQ5Tk55bEV2?=
 =?utf-8?B?Q0xweUZMbThZeUtlRzJnak5PQUJLVWdubmE5RFY1VSsvSytCQlBSREhEcDlB?=
 =?utf-8?B?UExSOFg1clRzb1dSTTBKRUVPTzIzbS9pQzd1WFpTQkpHNDRMeEVwOC83ZGRv?=
 =?utf-8?B?cXZPL1BwN3lqWnhLUXZmMW02eVY4eFZSS0xSdzJkWnNHWDd6Ti9RbDFPejJn?=
 =?utf-8?B?eTc2RmpOSnFpTEhlL1d3N0ZtUUl1SDlQM0EvWm5pbmsvWFJlZWN2czYzcENH?=
 =?utf-8?B?Y29jNDROek5JVHZyMlIzZFRReUl5aXZtaFlkckN4TThKbzcvS0M0aUpjdTlP?=
 =?utf-8?B?OWkrNWRicVNkZncycWcxb1NvUklmelJWNUtvVjFHYm1oQTcvaWpZQ3VlM2xN?=
 =?utf-8?B?d25pNFVPaGlaSnNhWVIzTGRVTDhyRWltc1AvRmNZTFBSWXc3WG12Ty9SeUo4?=
 =?utf-8?B?TGtVazRMaWxmYnZJWVVQN3ZoaHBQS1g3Y054b1hSK2cxQW9QNVZQN1daWHAz?=
 =?utf-8?B?OTJXMXYvMUJjZ3VrVFlaaEZjT0xNYzFtUUgvTkxZRnNhY292QzhDQ2NvbTds?=
 =?utf-8?B?QzIrZmZOZGVzcTlZdlVOVGVtemhuZ3JFM2JjSU1SYzAweXpucGpld2w5azgz?=
 =?utf-8?B?UFEvdTFaSEEvUERkRC9Lcnd1ZU5GdFhWVmNmSkpLRDFtNHRJSGUvRFBrNHR2?=
 =?utf-8?B?SGRjNkNRNE5BTHFZR3VMczNtRjBoR0hWcU5GUWJ4RVpRaWMrRWJPTVUzb3Vp?=
 =?utf-8?Q?VQeZf30Vk/mEVIM2RNk505V12EYh99AtSm6x++/bOTo7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98784d3a-628d-442d-93b1-08de19b45658
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2025 02:05:46.8826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6aLdQQBtVj4xq1s/ttESuSM1g2IJjjQMCJy3hGWL57Zs39LGXmdowxJLbZ/cfytYez4jc8WPoRi238OUBTsvVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7874

On Sat Nov 1, 2025 at 10:52 PM JST, Danilo Krummrich wrote:
> On Sat Nov 1, 2025 at 2:41 PM CET, Alexandre Courbot wrote:
>> The `from_bytes*` family of functions expect a slice of the exact same
>> size as the requested type. This can be sometimes cumbersome for callers
>> that deal with dynamic stream of data that needs to be manually cut
>> before each invocation of `from_bytes`.
>>
>> To simplify such callers, introduce a new `from_bytes*_prefix` family of
>> methods, which split the input slice at the index required for the
>> equivalent `from_bytes` method to succeed, and return its result
>> alongside with the remainder of the slice.
>>
>> This design is inspired by zerocopy's `try_*_from_prefix` family of
>> methods.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
>
> One nit below:
>
>> +    /// Converts the beginning of `bytes` to a reference to `Self`.
>> +    ///
>> +    /// This method is similar to [`Self::from_bytes`], with the differ=
ence that `bytes` does not
>> +    /// need to be the same size of `Self` - the appropriate portion is=
 cut from the beginning of
>> +    /// `bytes`, and the remainder returned alongside the result.
>
> Maybe "alongside `&Self`"? "alongside the result" sounds a bit like the m=
ethod
> would return `Result<&Self>, &[u8]`.

Thanks, that remove the ambiguity indeed!

