Return-Path: <linux-kernel+bounces-759669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D25B1E0E7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 05:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E591F18A556F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 03:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2301ACEDE;
	Fri,  8 Aug 2025 03:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qRcLvM+f"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66023FE4;
	Fri,  8 Aug 2025 03:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754623216; cv=fail; b=SKI4QuX6VTyGlQZOrJ7TbW0RTXZB63PXorLm0gDe9/nAhKPv8HB/K9CKhUCh5z8jIXbuvA1+eGHHrM4yH4CstFBJ35jeLaIt33e+QezqR3w2WV246s5P0kchSm+kx6V7bxYXthkrXPHiXPsPc3e7moCP0mmA4zpZbq9GmxYFmUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754623216; c=relaxed/simple;
	bh=DHlhsRD2hJ6Jv8dv69/ZTW3PpumZ2q4Yn3v5ghB7aSQ=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=qB0nHJv4J6t/DMh6ISnMVCszVBSjOaPOAn6TdOOefkyNVRN1dz+CPmmQqnsJHSuhYxMv5p2Bt+8QP+sRIm3xsf3v+iEsxuWHHicJVogXhgeDXO11vTqX5O/qBm3tDjD3vlR7v9bo/IB0tb9b+2aWZVP1xy1OcsD6GO858TxqRa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qRcLvM+f; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8MSXMiOQodKPkn1SaFGsfjEwyMk+7xf/Dy1ha7ArHlD7XAJt7nfuP20ctEvW6ICtawy9uZLAPgpUQcoKeuXFbzmQocQl046+YVobarkl+N9r+ROIAx3PKRljg3r/VZZhLiYLZx6cV6OmiOnbNTuX8BmwilZxgZcqjEiuBzNIM58n9Fo/bYuhBP1DeLIkuWybAT6AMLc/nJOiDmd02esiXKOf2VZMybdSqAJk1tqfkHVr8vlLvjIDxdqmW4sA9DxqJUVYPTu9gJQHR2V2REyMh3C22IFahYJN0ZULAZ3zg1c559fKW/OYJy/zjwnCKehtFnbRUQSGvpQlpPEOJsPhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5kAVVwj/mKrxY73WwNXRL8xjJ6l1q8XtsCg23tXXDs=;
 b=mMKNonUl+gQBDk7fq5vdgxbs4Ej7TU7HAJXAOB1QdpROMGgc5HyWyqzf2CWwXFBwCifX9u83n7IK8OEXpaTHs0s7YSbMLxWCrT3F4pzk4MxuaXmAh3WJRW/hdgaJJla349EkkrVSu3eOFBWJ1lr4HfR9bWe+cBCcFMygoJaYAxCohUQGt9/cgs9blozj7vp051s0/sHbFkyhQFozCx5iPvltqZ0Lkr8nI/UhWzitg84DadTVGvLVaPrLGLS5uFllgJxFvggty+TT0y6PRTjJcC1pyDNwxKIUxMSteiVVU3lNtm4PWa37Sow7Ha4z3Bz7ejxKNFpMr5ej1OBVI3E2/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5kAVVwj/mKrxY73WwNXRL8xjJ6l1q8XtsCg23tXXDs=;
 b=qRcLvM+fXMeYzIWu13Pc5Xu8OhwF7jATnKswWqK0HIVDfPg8eVxTKrjOyNKXOX5sBZG/rkLwefpFooMrdxlWYgqDer9IfLfun/AMOMBuuQdBKD4/aMwxbJ8Yx/WfULAU5hrDnLtCgF9SqG8GV+jdjo+xhu+UZC91/pTw4GQNSlyV/1ansSw4ni6vtjPDT7IVCsrmojl7PSS4O86EaAB2pdsvzK8Y42EDbC2OfT/cr9RdFwnGIak//6d84Xaan0IbJxb8nBmzx4CixRKZjeZ1WAEWbzlTSHKTPWKBnu/Q8cylu2BmFoNP0zAq4YXC+ildIe8GSGFHuLywPbsuZdtnDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BL4PR12MB9506.namprd12.prod.outlook.com (2603:10b6:208:590::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 03:20:09 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 03:20:09 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 Aug 2025 12:20:05 +0900
Message-Id: <DBWQ0KSI65TR.1X7XT05QCGQXZ@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Benno Lossin" <lossin@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Shankari Anand"
 <shankari.ak0208@gmail.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: sync: extend module documentation of aref
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250722121441.224439-1-lossin@kernel.org>
In-Reply-To: <20250722121441.224439-1-lossin@kernel.org>
X-ClientProxiedBy: TY4PR01CA0079.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BL4PR12MB9506:EE_
X-MS-Office365-Filtering-Correlation-Id: b23299aa-472f-4623-b4dc-08ddd62a7a57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NExtVkhiZUgyZUY0cytDNmc3MDVucUhMd3RkYllRZlhlRjF0U3Q3aUhKVFJw?=
 =?utf-8?B?UkhkbXZITk1ubXlBZkI3Qms1Q3FBakhLN2plbVd5L3RZak1JSG56WitZZSs3?=
 =?utf-8?B?ZGlLWStScUczS2F2Y2lMcDRpSkx3aHZGTnYxaFRMSi90cmF3VzRnQ29wWGZk?=
 =?utf-8?B?dGpsdDhUUDNlQWovNTRNWmJGV0xUcnMwRUxLN3dad0pLN2dPTmkzUUlMblpa?=
 =?utf-8?B?WWZYdHQ4QWQxNllWcjRYanF6S3Z6QjdHdU5qTklGVC8zTENPU0NZVjNlWkN6?=
 =?utf-8?B?WXlNWmF1QzF1SnVkRVQzRjVBREtCUFYzL0QvM2V4WnM2NHJIV2NlYjRQSUs5?=
 =?utf-8?B?VVhEbmhlaDRzajBqdmhCNy9Tc09jeGszQjZ5VnkxZFNQREpaM3cxZnc1Ynh3?=
 =?utf-8?B?RDJaOGxtRUF6M25KWFFyTVhzeThGVXVaTm82eTVQRGZlVzFPaWtSMFhjZVZX?=
 =?utf-8?B?dVhvbllTbmFMbC9KMHlEV0JCbjROdTdOaXBEcmxOM21TTzRENHNIQ1BGQjB4?=
 =?utf-8?B?SGRjOXBrTFpJUk9sS3NYdGNOZWFXNmRqR1VzOGNIaU5wTVQySHBVd1FtbTdN?=
 =?utf-8?B?Q1QwajRkTTVRVDFqUlBTWjlxa0gvNmp1cU90dTRmNWZNQ2ZvdloxcUhZKzU5?=
 =?utf-8?B?bHBlc3hCSVB1ZXNOSFhENVFEZk8zMjVGajZGSGpEYXprS2pmeC9hVXIwUFRR?=
 =?utf-8?B?cXJkYTdaYVNFLzhvRXhSc04rVXZMdGtxTjFzemRMVHgwMnRkTWlWdDhidmZh?=
 =?utf-8?B?bXlyNWh4eFZuYkRvRTljNWN3azQ0dndiS05RUmxzTStXZTUycjR1RGFnUWVS?=
 =?utf-8?B?dFNWNFdlVDdZUFFhRnpPM1dJMmRGU3FTYlVrYXkzaCtxQjVwQWRoUUZGWUxm?=
 =?utf-8?B?eU53TFpUZ2RjVlZJa04zOGkwekZEYktlUkFZNk5rY01TcnFVUU51WkhqNnBi?=
 =?utf-8?B?OW02NjNlaVJGcm5yQk81OUIzTGd1eGRZYjdlNytjeGg4NHZjeU1YK1dhbmgz?=
 =?utf-8?B?WE5XYXFST2ZXYXF6WXZHVXBvZ1VCc0JMQTVDWEJOekx0dHMxcHBWckd4bUx5?=
 =?utf-8?B?R1BSQ2ppalM5UVBZeG5XUHpaMytxcUJRemJqcmdpTHBIK0pQbUcwVERVdWJJ?=
 =?utf-8?B?UlNIL0pCUVBMU2Z4bCtpYitaS3h3MG9HQVNyN3I4bUdNQXNtdjRXQm9uYXdJ?=
 =?utf-8?B?TnpjVVl2NWhROGh2V2htOFlpc1ozVlU4VjVIMkdjb3pkSlNWZ0hSNTEzM1hj?=
 =?utf-8?B?RTBYT3RwMERUcG1zMm1QRHVtYnVqcU5iTldJaFlZNDhyb0x4VU1HOFkrZmZV?=
 =?utf-8?B?WVdraVNSQnZibHF1Z1RzNmIrbXBQbnVDSWcybFNjN1NXeEJIam9ldUNmTm0w?=
 =?utf-8?B?c1ZaeU9GamhJR1R5S2RYcFp1aTgzU0pOcEp0YzhJWlo5ZFBzTXRJdXVQelo0?=
 =?utf-8?B?OUhqeWxTVGJqdy8zbFBOMlgyditGeWVmb1JKRnFFdzcwRng5WG5UcHFDL0Mx?=
 =?utf-8?B?cHkwZnk2L3F3cktUMGlyUVcrVm0rRWs0anptNFVwS0ZWdFRReU93ZFJFWFJ3?=
 =?utf-8?B?ZkIyZ0Q0N1BhR0hlc1FBQTM5QTQ3MWpPZ2ttTzlkRDJjc3pWTlVLK3ZlNjF0?=
 =?utf-8?B?eG9zM25LU08yVXBhRDVFTXVyclE1clZ0YkJNUEtJYXRQRnhydUgyeTNrb3lK?=
 =?utf-8?B?NHpVZzNzZXdWUnpZeTYxTFdzcUZVU1Z1dnc4MUZrU2tXNWRIN3A1OStKQWgr?=
 =?utf-8?B?cU14MVZFMGdWRmRIclIwZXM2Wll5RUozVUFGMUZIcEcxeEE3cjNXVFBlRVZ4?=
 =?utf-8?B?eHhwS2xoK1hOWCtpZVFkQUdPSm8vSXFEU2xwUEJmZkg5OHdZenJHTW1VSzVP?=
 =?utf-8?B?RU14b0I0cmY1TUJnc1VybGN0d1NDcStOZHZ6cjV1ZGF0OWRDTTZaVnovdEZu?=
 =?utf-8?B?TndidDBza2hHWlRvZXVWeGpKUnhtTjVCdEpPVVJlUUlsR0FXN29uc1ZJZUVx?=
 =?utf-8?B?TFBUdEt2MjhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWFzQnRoNWV3NHJIQStPeVcyYlp2L0JVaTM5U0p1SXZFemZYZUk0RkQzMUpS?=
 =?utf-8?B?cmJsOVNZQ3FmZlkxR2tmSnRvRjR2eUlJcE91dWZJeTZLclpJYU0yUXJMbXdV?=
 =?utf-8?B?ZGhSRm1DenBoOXIzTkdHaDBVOHRrQzFjN2c0ekJVbmR4WVFlSEI2cGZNRjl1?=
 =?utf-8?B?NVd4cFZ6SFlHSHM2VWlEdkI0UVA3d2NpRVlGRG8yeTZUUjhoUS9jYUpad044?=
 =?utf-8?B?TkNCM1JPOXZBYjJvczdhVHI3NVM2YWxZWFJqdmRVQjU5d1l0Ri9Cb3BtUTdH?=
 =?utf-8?B?U1ZBVzFRWlBoTTNBbDJJYkl5Z0lkVTYrNzF6SnR5TklLWGozclJQVkVjN0V3?=
 =?utf-8?B?bXNoU0xoUXR1Y2dBVGJPcVhBcEdOQjN5dDJ4NnFVMjdOQk9ZdEVWMnduOU9o?=
 =?utf-8?B?bGw2QXZXTitGVzRoWm0vTEJweFpJOWJkRXp0d2FjTGJJMkZvVEYwbGlhclJu?=
 =?utf-8?B?MXc1UDY4b0N1NlYwVDNCYUxUMEl1bTh2L2w1WUZ3WEtXdTlzbStyeEx2TUE2?=
 =?utf-8?B?aUdjei9YYmZOS3VQN0NWU041c0VHZ3A4ZFR3dW52R2VxNmUvL3V2dGlqY3ZX?=
 =?utf-8?B?RnV4L09xL1FRdGRCcUgwYW9kclZTTU9EVk1NT1E2ZFJTNHhWZSs4ZTNpQ1RR?=
 =?utf-8?B?K2Z5OStSTWZFWVh0RGVuYzBGK1l0RXFzRllpMHl3VnJ6Q1paN2VadDhGTWZB?=
 =?utf-8?B?ZFFOZVBLd0dwWWN4RHJ5Tlp1Z2JLdVhEdnI0em1qS21hTENRSlpySEc3bWpK?=
 =?utf-8?B?bTFtcW0yWC9YK0E3bmlIT1AyTVBpaTYxL3VtdDJ3ajVWUHJyWTVIbHZkRXFP?=
 =?utf-8?B?VHdWdUVOZTZydzlxRisvYXJoZW4zWnNLTFpTcmpZYWtsSDBJRmZWdjd4WTFu?=
 =?utf-8?B?VW5VSjh4WVB3YkI5RWY1bi9pUjE1VUJEQ2hMTDVNVzhvYk5HbURXUHc1dzVZ?=
 =?utf-8?B?dkVucnNibURkN3hiUHN5dXRjVWxmYzgwY2JWVzB0K2UrUVh1NURKaUVxU0lZ?=
 =?utf-8?B?SUpSZzdRc21YSU54QUZieUxGQ3JRS0hUVVM3SUtpUVJkZ1E3QU94bkZtYzNZ?=
 =?utf-8?B?N0dKb3FUdlZobzBnM3k0QzRDWGdzTFpTWlNQNC9hTzZUdGpSWnlkNW9ObE12?=
 =?utf-8?B?QmVVSEw4Q0pQK3RFS1lmbWFaVjB0V2Q3bTB4djZTcXJJOEswTXRNTnF4UW9x?=
 =?utf-8?B?TThjbDNqMG1EaitpcVJrMHdHZzR4UC9oazhoWlRRNkVRZjZkWW9ZWEIyazlN?=
 =?utf-8?B?S0R0aS9mVnhZUzhSNm1FUFVXUnZFZTBHNlRucW01Wm5LVEJoUytOQlVVWmtK?=
 =?utf-8?B?bzB5eVpFSTFpVW12dVRzeUhmZlI2Y2xuTjFDNzdiMWxIajFQNURYb2ZhQVdo?=
 =?utf-8?B?Uk9WOE1GOHhab3oveGR4NitEcHNaZmZ5VG9IZ3ZmRGpMbFFTQ1RueEE2OHJl?=
 =?utf-8?B?WXlieTh2dFhrcGs5V3ErY1NKM1BpYmdHbDJ6REdoOGRqQVNMcEJ2MmVQaW81?=
 =?utf-8?B?Q3oxZ0o2eGl0MDliakpKSTc1SUdXMjd1SVNwalRCUWpzbmQ1ZVdESWFxNlIx?=
 =?utf-8?B?Vmg3M1o2UTJocVNkbjVXWEkxczBKdDZFa1RXUDhwT3FuUGNMSW1mNFNRZ01H?=
 =?utf-8?B?OXVJRXVTZ2UvRnR1NW45OXpkbnlibDljRDIyb1p0Z0R5SHpUdHhtQUdvdnY4?=
 =?utf-8?B?anRaZW8xQ2F5SENzTjRWV2pMMmVlcTJhVTdGUW1RRDhEQjNqN095Uy8wbEkw?=
 =?utf-8?B?MCtPNk15ZE1rc2tMcmk4M0NjV1V2bUtzRHZCSnFlK05pb1BaWGRzbXV2VnYr?=
 =?utf-8?B?MWlWZDdoSTZFYlB4blV0aGcwR2VjNHE5emJRQ3JNeElvSllhcXhRbElORzlS?=
 =?utf-8?B?VFFDMDBOYXlPS1FTTVNpa1BpTUFtREtjL2N2djhwTlpWQXlaZXZmRGlJREFo?=
 =?utf-8?B?TVY3V01Sa09yalkwTlhZcWs4aDBsQmRxeGlJdnkybXhwVXZEd0hjbnFUSzIz?=
 =?utf-8?B?YUdqS3MvUU4rU2lzS1BUbTBPcjBxd00zbWIvL1F0WUlJSXJUanQrVk0rRk9y?=
 =?utf-8?B?TGdiNTVDTU1WTm5WVjNmTTNFUkh2L0c0aXVHYkZsR0s2NiswZzUwd3JOZHhj?=
 =?utf-8?B?UTN3cG5BU0JWaURKRlFpYldVYUl1RTVvOC9GL24zZHgycjI1Qk9Qbm03QjZp?=
 =?utf-8?Q?VHXkx6Be7FS9FhldOY2cKMsFJwFqiXsdninfJ2JX3Rv1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23299aa-472f-4623-b4dc-08ddd62a7a57
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 03:20:08.9489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jMO2oVrO2ntBKxx+3wP6ueFBTG9h1OtEpwwCbe31pkniFgo8B0QGsvsnz77JhmN3gcjUcIWnDA87tayYwK9Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9506

On Tue Jul 22, 2025 at 9:14 PM JST, Benno Lossin wrote:
> Commit 07dad44aa9a9 ("rust: kernel: move ARef and AlwaysRefCounted to
> sync::aref") moved `ARef` and `AlwaysRefCounted` into their own module.
> In that process only a short, single line description of the module was
> added. Extend the description by explaining what is meant by "internal
> reference counting", the two items in the trait & the difference to
> `Arc`.
>
> Signed-off-by: Benno Lossin <lossin@kernel.org>
> ---
>  rust/kernel/sync/aref.rs | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> index dbd77bb68617..1c212238c0e5 100644
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs
> @@ -1,6 +1,21 @@
>  // SPDX-License-Identifier: GPL-2.0
> =20
>  //! Internal reference counting support.
> +//!
> +//! Many C types already have their own reference counting mechanism (e.=
g. by storing a
> +//! `refcount_t`). This module provides support for directly using their=
 internal reference count
> +//! from Rust; instead of making users have to use an additional Rust-re=
ference count in the form of
> +//! [`Arc`].
> +//!
> +//! The smart pointer [`ARef<T>`] acts similarly to [`Arc<T>`] in that i=
t holds a refcount on the
> +//! underlying object, but this refcount is internal to the object. It e=
ssentially is a Rust
> +//! implementation of the `get_` and `put_` pattern used in C for refere=
nce counting.
> +//!
> +//! To make use of [`ARef<MyType>`], `MyType` needs to implement [`Alway=
sRefCounted`]. It is a trait
> +//! for accessing the internal reference count of an object of the `MyTy=
pe` type.
> +//!
> +//! [`Arc`]: crate::sync::Arc
> +//! [`Arc<T>`]: crate::sync::Arc

Very useful explanation IMHO.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

