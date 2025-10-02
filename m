Return-Path: <linux-kernel+bounces-840575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C399BB4B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927C219E53B9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7B926E703;
	Thu,  2 Oct 2025 17:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VwbUNKhL"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013061.outbound.protection.outlook.com [40.107.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032F022758F;
	Thu,  2 Oct 2025 17:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759426367; cv=fail; b=CRb2xUe3YVFOq+qZqj0+tLaZLl47E0w8aFOrHH7qjOnzlc/BcNeyeKb/piJPy5QzYHTVk5z4VbHosF1DI+IZv64xI0iRiyOpAk5tJppDaP3M1l2HO0QAbaPakWcOkNjGI8hmUl9OCasII2ygj68Rlu5+Z4FPxSvoIozfeia0Ing=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759426367; c=relaxed/simple;
	bh=3IpIwSkLSOH6n+Bx4DVKwvisiwY7KSrEstZy27kYu7c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tbut68mzpBX9xsglXeW0ffz1wC6bMavB77yt0FPzxa3/Et0mAzk8Og9rGerfA6hTeoRqj6b1jhichSj0QbDh8Ccpzb6a4n6H+b//sa6+pp3dPgl8TCIUQ8pbygEKHS77iQCsmtpPvPfvnQy04qHPKg/TuSh2u9V3fAsNvmfpVt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VwbUNKhL; arc=fail smtp.client-ip=40.107.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+rrjD+8njAH94p2YgANfwmQ/+jpUa3muWoz8XqQi0j0S7P9PgTryBVRVXdUdVTzLPIOf8H61TWZ8k8yNCPN1hypRE3vTVF55mLILgc+4yU5ERIUA1YrnDRf5pnmnqDRJsqF09EGP4D6DqkVTZJ2JoN7/y7iXo0iqlI4YYLwNMdgfG1B4NHHMKkiWOan8yDwp1sjyLS10JR2edVsOHn+B8pFWGOKBl3eC8PUo/DbKgdKL9OWEV+yVk8pbZtlH7G/VpWCzWQ79SY7a/l9hUmCT9w4X/3f8cLyK1lhzhkD3yvsW1HLM2xTy6d6qXRR2C+hwyC3lPe8FFLp35jJ6Ddpwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vtNQmIXtTR046kIbF9lLhVblDToxFzmcW2S9QYgUMg=;
 b=hj498vlxRhgkgqIHI/gntRZd4BXd+/6tHn3xaMn4zLsY56lj6hgjTtTppaOylLPDd5vX8xxKKsBRHmGRhkthByvn5/c+xhN8/krBpEDlx7V/jyAFLuYLJNioJTzQHj67sSSWAATJ4IdOvOGf7ZGMllSW1gQKOlAKQDvKOddPZahNjgG4OYHNYMGR5Lcdrva9HWMf43yRhoW8TeTK5DBXw/K2Ay/f/Nuiz0c6XDPMI/0Dx0T1HsiyormOaJuQMn3En8bk+0nNVYmJOx1D3c/Ai3RTjaXycP0GyqTqw/oW1MLrcSwOWhU0mO1f1vJfTuZYi2/6ydtfZwVKN2vw4Wy77Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vtNQmIXtTR046kIbF9lLhVblDToxFzmcW2S9QYgUMg=;
 b=VwbUNKhLV10guABiI1kAyNn86c0QTfOLWzTDjmCkd3zplFMpYpGzrwdub2vcLCJgUpivUwXjDU5G55OSvxM4L0N9aEiYpsguI8+Vr6lT3rlkpR3fkBMtILt/SQRK3tdsrnDAfrs4c2jXaRB/yU+8dy3dQl3ak4x46L4MpL5bjuJ3Snfm3CMKEXZp6HskQ3FjXPKyv9PEG4cVqm+sQcyFfSaT5c0uzhoRDAOfMJBwhjIwqF8RqX8dGKzbVYI2uyx77d/poKjRAEueWuSpCRatYpfRohLYbjsibzbB/kQ9PRw3G57KsOr70a8QxMBbFdsMGZVV/o8BdCSqjw1mPvjojQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB5617.namprd12.prod.outlook.com (2603:10b6:510:133::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 17:32:37 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 17:32:37 +0000
Message-ID: <2b780ee4-1780-4fbf-9f80-4867ab5e8d67@nvidia.com>
Date: Thu, 2 Oct 2025 13:32:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust_binder: remove warning about orphan mappings
To: Alice Ryhl <aliceryhl@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
 Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>,
 Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20251002-binder-orphan-v1-1-cdc4cffff992@google.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20251002-binder-orphan-v1-1-cdc4cffff992@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0042.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::17) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: bdbb4ac4-3348-42a1-2c67-08de01d9ae12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0FWYnhtZ2lPQ0Y0QkNJcG1WNTNsVGFtemQvd1VpRXE0Z2NKQjBGRG9teDdH?=
 =?utf-8?B?c1ZISkViNzFCK1l1VXBzRUpIR25LWm5nNy9SR253c2dmcFo4cUw1VEhLc0oz?=
 =?utf-8?B?aitING1rVk9wSDFGc0pmNlI3TzZWa1EyMFdjajU4SURZRG1yWFFvaUZDdTNj?=
 =?utf-8?B?SkJvNkJPQnVRUFlyOVhiU3NEc0tQRStabStxZFFCNTF2SnY2ZzZ0c0xCcytp?=
 =?utf-8?B?b1JHS2t6dFRuOUVCa0w3MVdWeElzbjRSaE44cCtOMGh2K21UZW5YRHRJaXVJ?=
 =?utf-8?B?YnV6UkZKU1NUWDlZSTZVNWNMUVNJTGE0VDRFd2RRNHY2UjBTRm94cko4Wm1B?=
 =?utf-8?B?dkJ0Rk5JUnVPZHFxb3N4K3gwWkY2REgrS3hNZFNjY1BZaVFGdkhIVkZhZjEv?=
 =?utf-8?B?ck1WSFhVV3Rtb2FuNVRMV0pJU1AvSXNhS2JtdFgvZW5DVStmRm1kT3BYVnNU?=
 =?utf-8?B?U1B0RDg0RUU5UjU2RERWd244NzEwS0srY3M5dzJrNDcwT0hyZm1GTVNUbXJx?=
 =?utf-8?B?V0N6ei9MOHFuRzBOQjJYdTVQTVRKYy8yeG1sS3RpdElRaWFQVERhYktIc2NZ?=
 =?utf-8?B?NXlFYktya0VGazg3UmJYWFIwcnc3OGo4dDZxNGY1QnNtakNFdlliKzNpZWh3?=
 =?utf-8?B?dGNKRmIvc0lRY1AyeCtGalhVWU93aktHRHdNUWJlYldzTWg5TEF4TUdlUWtk?=
 =?utf-8?B?T0hIb1BQZ2dZS3NIMm54SWhETWhkOGRxNkplQXdEd0pWQmdTUnJVRFRndkhD?=
 =?utf-8?B?VlJRbWI2dWhPekUvWU9pd3oya1kwOW1DdDhCR0dtSmZFYWtRUmNjMXFkN1NZ?=
 =?utf-8?B?cm5aWkhDZnVsanRiTURzZHBvN0JJZ0d6NjBUNzZRRFNVWWV3V21yRzlKVEpO?=
 =?utf-8?B?TENnUDZnUlQ4NkFKcytwYSt1L1ZvUXVGOGJEMzc4RzlRWitIbmRveGgzOS9n?=
 =?utf-8?B?TTRiVFl1N2N6NWQvYzdIQWI3MG41Sy9nMHEyQWFKdFhsZUdIY1JJZ3FLVE5k?=
 =?utf-8?B?RzhYNkxZNSt0TWlhV3VxVjRRNkJkdkI0aHFuaDE1NHVJc0VKM2xlcEo1V2hJ?=
 =?utf-8?B?cm4rMFJGeFQxREU2RVJlZlNqL0llTG9FSGU3Wmx6L0ZFcDV5N0JqbzdFdmEy?=
 =?utf-8?B?SDJDN2Q1bkkra3pQYUtvRVpOaHBhU3F3OGltUzIrUUlmbXl6MndmTG84c2FJ?=
 =?utf-8?B?MXZQNGtmdWJ1VWcvbk9acTREakVzZE5WcXE3UUgxVmRQZGlrcEFpZUNFWlhR?=
 =?utf-8?B?dmgxMjh2dkcvbjFUOGpGMnNMQlhwNXFlVHQ1OEQvUHBmbG44eW9hc3o5V3Rw?=
 =?utf-8?B?dWJacGxPWVFYK0VySlREcFM3RjV2Y3VMRVdvcXhZR0dVRjV4NGp4N2xidXBO?=
 =?utf-8?B?K0xBNFZQZ3dxNkh0V1k1bnFrMHN0Q2NoTWVwYTVqNGJmL2UwWUF3N29CUUJq?=
 =?utf-8?B?NTBEUHdwWW5YWGV1WHU3UnI1YlFnVTJPaFdva3lKby8ySldRaFppZGU1V2dt?=
 =?utf-8?B?R3RSaFUxTVlDRFRYQkhTb1VvaExETjQ5SkluWC9tR240NGUrbTdJcCtUVkRY?=
 =?utf-8?B?Q2YwdkhaWHY3TDRyV2RGK3FEZUMxeTB4SkV3dklsQkJkV1NRZ3hrNmREckEv?=
 =?utf-8?B?N21CMTVPS25MMXVtYkhWVFVPdW1WYWVTOUxSQXZnZ3JKYXlCYzZicGtJS3F3?=
 =?utf-8?B?SWRkVjhpNEFianBtbHd4UmZueEFuMUZUK3pZWVJhR3pQb1dhdVNoWXJ3U09F?=
 =?utf-8?B?c0VSSTZrK3pNdExWcG9vWll5WkdtZlZLMmFaTlNGWW1aaUM4ZVRDNHQ0UEZW?=
 =?utf-8?B?U0dHYWJObTZuenFsTXcxTDVycHFHNTVoWHBWN012TXZnb1lwcGJRR1JaK2w3?=
 =?utf-8?B?dXR3WVVyNHphMU52Qit5SitKRTVZWFJRcENQMWpCbElOY3J5aWcyV2s0Ri9q?=
 =?utf-8?Q?qYmpHeYmerI8wa7Jo2513j1w+qa9nBay?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NklpVzhWemVPSWJtVHFxNEtWTjRzTUZaRjd5TjE4aVBWNklwTDNzRlloNEdM?=
 =?utf-8?B?SUJoK2owbmJMcjc0U0J6VFE5Zk9iR1FCRDFsV20wZHVMSVN3NDlaVDRBdE0y?=
 =?utf-8?B?akRycFlSTUh3N3J2UGxHb0U1dGpCT01yMUFMMkl1SjJOTTFiY08xWmsveWE3?=
 =?utf-8?B?dkRpYXc3dmgvdDBPdUsrd1htRHNERnIrVVBvZ2hWWHhTZTM4bGdHazFzamx2?=
 =?utf-8?B?M1FvNnBERWVxWGNuMHV4ZDVkejVXRm0wNldYZnYya1FVODVoUHRZM3BqVEZm?=
 =?utf-8?B?NlAzOEdDaE9JOENuZ2tkRitmaE5HU05pRXFpUWpiYkRBdnptQlYwcWY3QmQ5?=
 =?utf-8?B?ZXYrYUZkdG5IaFJBcnUzNjhMbWJlTjJlNnFmeUl6V2R5anVabGExdVZXSkIv?=
 =?utf-8?B?UGhYK245VHpGQTJiYndtSXdaWmRPVGF4U2VVRzFSMW5RcGJWYWNjUFRZWHBD?=
 =?utf-8?B?NFlaN3RsN3BMSVhoUFc1QnFPbUVUM1h5enIyMUJTOWRFcUtlMHBUV21jbFAx?=
 =?utf-8?B?SzlwR3dZY0NtZEpXaGlvQzl6dTVoc0xRc1NEMWtBSnUzMHc1a3VKaFdFbS9T?=
 =?utf-8?B?ckhaelBsMTJiMWtjdndZWnV0aDAwWURhcWlaSmpVV2czSnZTWEdqMG5YQVZJ?=
 =?utf-8?B?RThXdVFhUkpMUXJZN1o2NDJWR2RsWTNkeTJmL0oyM2lEcWZIMDY0N1IwUTVO?=
 =?utf-8?B?endwMVBIZVdiQUdyeHJnUFNET2FxU1M0dW44cFd3RTJyaFlHTis0MGRDa3BZ?=
 =?utf-8?B?bUJZOUFJWTJSbjBCTElFYzI0UzFNQWVXOUVVam40bTgrQ083bnVBeFU4eDB4?=
 =?utf-8?B?SXB3Q05xbC9vNzhFbWdPMGNzakJFaWRyMm9oTVFDMzFrQTNyMnArWkxQaDRv?=
 =?utf-8?B?bjJzejNXYzd1Yng0VXdoakRORjh1Tng1cm13akVJN1AvbjJGUlIrYWpWMXkz?=
 =?utf-8?B?L1BvcC9JYnlYeUxxUXFWNW84RERLUlRQczcydE5Sc2ltdEFDY1FjWEY4TWY5?=
 =?utf-8?B?NUJpMzlKRnZ5Nzg2QmNSTlVBSGpzYnZ0by9qMXJJcHh4OUIvbW9OMnhjbjBp?=
 =?utf-8?B?SlhBTVd3L0NjWXNZMGhTTUM0MDJxWEtNcnBKQ2tabDVqQXNVRUxsRjJRWjho?=
 =?utf-8?B?eVA2NVhUYkFyQllBbERVSkZheXZ3VzFGWTd2WmpyaTY4UHhqQndMR0t4RVBC?=
 =?utf-8?B?TUVOTXB2UmQ1Y29BeDFJRnJKb2RRemFtMlY5QjJZTU1ZcjNxemUremlvU1Jt?=
 =?utf-8?B?aUFXREhRZGFpbyszbVRmaGt1SCtIUERlT1BVbFRpSkp3ZFRFMVZ6clBGcG1B?=
 =?utf-8?B?ZW1Ja05kcm11SkV6REtRa3VyTlBXTE9QWDVSQkRZQUdpZlJkZFFLVFhqdjVZ?=
 =?utf-8?B?RzFPc3VYMDNBSUhDbUtzQWNoNkY5ckpmdEYrTlFlYUltL05HZWsyektWS042?=
 =?utf-8?B?MGJBQWdkTVN5dDdpWTNCVU5PbEg3Y25YbEFZK0hmMFludE5ZYTZUcWc0T0xu?=
 =?utf-8?B?NWZyTXlTOUZNMmszZS9lV04vVzlaMy9DUTNuRm1VVDVLKzVCM3VwN1oxOUUw?=
 =?utf-8?B?Q0UwYUVVWmhQUm1OdjdzOVNVOVhSVzFBWUZlYkdkM0ZZZTR5R0tYRzlGYUxy?=
 =?utf-8?B?YUtVSElTaHQzanZqVWlFTURpRm4zZ1p2RCsyM3pjSFlKUGxqYnVKQzlNZGtk?=
 =?utf-8?B?ckpNTUtmTFU1eldjc3BlZkdxWkNhTUJTWk1uZ0pwSUxCTFNDTGRlc0dmODFk?=
 =?utf-8?B?TXJOVFZJZEJVaHA5ZlJZUEliczFSMnhPRmNaV0tqa21jZndsZmx6bk9hNURW?=
 =?utf-8?B?SkFoakJSZ1ZjcmVXMHVJaHdQL0ZZVUZvTjVVV3NuL0tzckt4bVFnczBLUi9L?=
 =?utf-8?B?TjFyUXlZNnJnUk5QektaMVREMGQxT3lCMUVMUTN4eTBMZmhMMkRyQnZyWENn?=
 =?utf-8?B?cUxMNmtKa3A3a2kxQURLNWppZ2NMN3BjZWJLZWZQUUM2UTZIQko1bHZ5a0hF?=
 =?utf-8?B?c0FnZ2RSVDFJYW9QbEZONzJyNmVwS2dDcnpHL01zTFpLOWk3Mi9iYWhLVCt4?=
 =?utf-8?B?anFqV0txN2g1MjlKSlV3b2FXaUR1YnRReUJYN1pnRkE1ZzNEM1BXYmhqTTVj?=
 =?utf-8?B?ZFI1T1VPQ1hrNEhKVkl1Z29SS2RHbkhQUFVVeVBiZVdhT1lKZEc4ZmJDVkl1?=
 =?utf-8?B?UUE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdbb4ac4-3348-42a1-2c67-08de01d9ae12
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 17:32:37.6114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UGaG0JP4uO3aLewpOoy2OP53RhyjCQAM83evVrwKeeubhbZh1/BHJepeAYZhlns6+IIfuIcHkn2MbBBagkqvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5617



On 10/2/2025 5:25 AM, Alice Ryhl wrote:
> This condition occurs if a thread dies while processing a transaction.
> We should not print anything in this scenario.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

thanks,

 - Joel

> ---
>  drivers/android/binder/process.rs | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
> index f13a747e784c84a0fb09cbf47442712106eba07c..d8c3c1ae740e0eb3bcc8aa5e7faf4291f1cb69c9 100644
> --- a/drivers/android/binder/process.rs
> +++ b/drivers/android/binder/process.rs
> @@ -1346,10 +1346,6 @@ fn deferred_release(self: Arc<Self>) {
>                  .alloc
>                  .take_for_each(|offset, size, debug_id, odata| {
>                      let ptr = offset + address;
> -                    pr_warn!(
> -                        "{}: removing orphan mapping {offset}:{size}\n",
> -                        self.pid_in_current_ns()
> -                    );
>                      let mut alloc =
>                          Allocation::new(self.clone(), debug_id, offset, size, ptr, false);
>                      if let Some(data) = odata {
> 
> ---
> base-commit: eafedbc7c050c44744fbdf80bdf3315e860b7513
> change-id: 20251002-binder-orphan-d1bc4bcd9777
> 
> Best regards,


