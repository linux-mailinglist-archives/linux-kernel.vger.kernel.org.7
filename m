Return-Path: <linux-kernel+bounces-786829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAD3B36AFC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 067457B6152
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7249E34F48B;
	Tue, 26 Aug 2025 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e3GJpXXP"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29A422370D;
	Tue, 26 Aug 2025 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219128; cv=fail; b=ipMb6XoICDJ5HBcBl/ZJLlsACcQR5lsYzKdZe5m5axoZ0nVNkHQqmuTaZdUoNA0bfwSk1refPBkllfKa9lcDq6zkMHtHyPD/yU4S93H3AS4RVJ+aU5eS4/8LfEbbZey4FFMPqolUzIiDqqRPjv27LAKWctBfCXLV3UN4Iu29FYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219128; c=relaxed/simple;
	bh=zNgx6QFt3ybI/4JfI4jXwU7wNu4DV3GoecM9LMP4T+s=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=gE3WbEE7yIt66iPWT0PjyNzTotol4DPpODe93MWdS1sVWS/pfAAmd5gFAoLUEzRz0WXb1cgl+rvlCYXfS/MnP4/hxpLQqqhNb/Hh5+QOyagC2caY6dTUoamFdOtlBoBSKp6s1/eKwySdZizoxTsxoII253koMJG6V5mQAk/NJ00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e3GJpXXP; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAFd/rX/ZyNI7uRoPfyjU41h8QTBVXK9x++Zjsao9l9XA1/UxnUBxadqUvIRpDtlhM/bS8YJ+y3BwRDJeSMh7k802UzW2b8Z89KGhwSDgC17E1xEiBs5Gs74XLjyIi0nqlySwW1dP+lT/EJtFm62RtBo7XFWjdch1fbZG05oCSVJNymPsbuWe375p+yDalF0JF/5ANHpPojVOXABWGmnRjqfEQy5u8G8iE8Y3ZX52gC98mg0F35n35+J1Ay+5D+4GsrlJr7TwrQ1BchPjdN7cBDt1WV6fCJL2rF2Cjccxy+RliBIRoHtsYzbAyyRHAnVpWEa0ROMtSfZhXXUQD3/zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNgx6QFt3ybI/4JfI4jXwU7wNu4DV3GoecM9LMP4T+s=;
 b=ATRaPvAL0nJfXfqkpfHzkcJxUTTkUjAZS9EkIHCykBTA6zrLo8rtZ3mFAI9UPehFLnuUdxNSCExR4qmpZIMlNrzi0w3iAgJ7W2SMhYkVyddYumVSFJEPGROfhwLDigwSNrKXOjhRyyChS29JTJZKfNOtvJT2vNs/nLYq1KC//4pT2askZVyyKMK4wOA4SIDEfdE/5vCuKjsL+mfamV3PjORr16wQibSCO2Wf86cc2ECgnDGfrnHUbq3ggW6t4oB96PHAu+s6wcEtsm+Hx6/vlXfOkOUupwgLJ6HViJVdw02cnBvOL4Q4n0ok3fAtsfVO4W/0pfhxCq5AT33JLufpRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNgx6QFt3ybI/4JfI4jXwU7wNu4DV3GoecM9LMP4T+s=;
 b=e3GJpXXP8lltJ83BG2dOL+IZnvvbwP+/JbnFkJ8u31XP64LZI6cDIhdXs0DJCMYyr6O6ya2G75j1oVLrCu6KX9Akd4m2rORnk1Ss4qKaDEBhjIu5+3FccgLJtIp9O5PoVA3Kh3S8s5EYa9Fl3/GZRNUPjuAYIlYq9vQ2dYU0N1EOccw8/eG7LOMfvKdpJNaxhiHGxB1MTyFhvD6CWK537/Fasx63IDhG6If2AEDMpmEcNCkPeszxOETygJVyjhbAlodf9O8UuaJDtcVwb/IAiESFGP0OQT2T5R95Pc2XqPdnVHjdxz2JLj+/jMpr9L0vId19IT4T3RUIiTsU9jIS2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY5PR12MB6480.namprd12.prod.outlook.com (2603:10b6:930:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Tue, 26 Aug
 2025 14:38:42 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 14:38:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Aug 2025 23:38:38 +0900
Message-Id: <DCCFPWZCBAAB.3KP2R8P2C6GPD@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] samples: rust: dma: add sample code for SGTable
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <akpm@linux-foundation.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <abdiel.janulgue@gmail.com>, <jgg@ziepe.ca>, <lyude@redhat.com>,
 <robin.murphy@arm.com>, <daniel.almeida@collabora.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250825132539.122412-1-dakr@kernel.org>
 <20250825132539.122412-5-dakr@kernel.org>
In-Reply-To: <20250825132539.122412-5-dakr@kernel.org>
X-ClientProxiedBy: TY2PR0101CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::21) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY5PR12MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b563fd9-5071-4c4f-aa45-08dde4ae40a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Kzg4SVpvd1l6L0VpN2Z5UkRpdFB3NmdtUVlBdWxvWURuRXdSS0Zkb3RKVzZS?=
 =?utf-8?B?Nm1udWRJSmZWZmdTY2sxdlkwV1NhcTJDeWlKYmdxMnZySDR3YmI1aERLVGNT?=
 =?utf-8?B?UVBnaEprUnBjdGZYUWFGRFFFVzFYNlB1ZytFSnpmUjU2OGc4cWRLeEVQaFJP?=
 =?utf-8?B?WGhwSHU2TnBPZ1hLRXdBeHlsclAyUUVlaHFkWHFCcElhdU9aUzdlY0RjT3pK?=
 =?utf-8?B?eHozYnl4RWljWDZwWVhQVHY2bEtHRGVoV0NXTHNpZks3TC81UVpMNTlKNHpY?=
 =?utf-8?B?U3JmSENJZmZwVDNYS2l4Q1M1TnE0bFJyWGdqMTQrcUM2OEhNcHlXZVR1amUw?=
 =?utf-8?B?MCtCZGhhb2ZiOWNEVnRHV1ViS0F0TUczS2R4dDBLOW0vWGQ5M1pvb1pRY2Nz?=
 =?utf-8?B?cHFTYUtaRXFhMGgxR0tEbHlDSmJLQVJLYVNOR1hXcjZWZnNaaDdsdVRxaDlO?=
 =?utf-8?B?WlNPWS8yYnVlQUJmVWtKWmVXa0NKWDZRYTUwckN2R1VBS2dnOEEzbHR0VFpC?=
 =?utf-8?B?UkEvKzJLelUxemlnQ21RZTlhK3pVOGFxblhFRkVmZ0JtNnpkSHliYkZDTHFq?=
 =?utf-8?B?MGFZQjA2Zm5KNWEvdWQvQmJnSXFaQzk3di80NTRnNm5Ld2tYalJzRFUxbXJT?=
 =?utf-8?B?a1NQR3I2WDNlQlNiSWpqcW5qb0pocFFrK0hWRVhQNzZuZlFaVHI0MmJyZ2Nn?=
 =?utf-8?B?U0R1ZW5sQlQ5Z0lZak81YWtmcTBCWjBma3pidXRKUW9NSXFhdVQwYkV3ZGNk?=
 =?utf-8?B?aXpuQWllTklFYTYxYnBPWVB0d3F2VFhEZDR5UENKWjlFOFpVeU9hZkozTk9z?=
 =?utf-8?B?Y0piVFM1S3NwV3h3V1huMmxJMWFaRkhFTzZ1VVlHNTR4bnNLZkVYaWJEUUlV?=
 =?utf-8?B?Qnc1cGtNcFhibEEvbnNCRTdTemR0RU4rdlhxN0pOQnkrOUoveXNuZldrbTBN?=
 =?utf-8?B?TnRiNjNrL0lPUUppTkN1a0tGUmErS2NXcEhPMXhkQll0RVh3TDZWUUdwNmNj?=
 =?utf-8?B?Y2Z3RXNWdU9JTCtKdlh5TjRhcStCMmw3OUVrNHVLMUVtalBXYWhNV1Qza3lr?=
 =?utf-8?B?WmlOR3I5ZkQyTXQvdWt5L1dtSktETXdWb0FDOXo3SlIvVVV4cW9wRHBkZ0o4?=
 =?utf-8?B?ZlBDa2QyQk1GaHBRSDR6cUhFSjVKKzdTRUc2US9seEl5TGlJV1UvWmJNeHkz?=
 =?utf-8?B?aTAyVDM5Q09oWU1sQU1iRVRnUnVZZkV2S3VvbGF5aVJpZ2ZTWldlMzIvZUU5?=
 =?utf-8?B?b0V5V2hQK0tlRTRSRXNXVEZnWEJITVVCS3YxNWdlTTArRHF5QU1uRWVsUnZY?=
 =?utf-8?B?UlA2eXVUeTdaYlpSRlZCbFpoNm05bFNTUUhFNjZHeC84Mjcrc3JMUi9FeWxn?=
 =?utf-8?B?UlltQlhHMXdnVER6bjl0d0VXMFFMVThxellFUVl5SUNMUEFYL3hiZEFIcWI0?=
 =?utf-8?B?SDVERFpEcDFFdGd5SDhKdmNNZ2ZYUzJtWHlOUThzSUw1aDdhcjZVUkplQzQ5?=
 =?utf-8?B?L3pweUJQdVpNZnBWcGVkRHpPUHFxOXJRYmJPdDhkeVNJYnVoUTZUNHhQL1pn?=
 =?utf-8?B?aWdtUlo1OVBlQ2grV0x1b2M1djZPVXZRNlh1bVJNbWk5elBJdndEcGlnZ0NC?=
 =?utf-8?B?Y3UwK3ZOMUZvUHA3eHpSYkJwcWE1NlAzczhaMnJlOUllR3hPc2ZoR1Ezd0hK?=
 =?utf-8?B?ays2WVVPZWVOZGNBY2NGWFgzY2JYRTRRZzBNQjhxYXNUSGh2ejhmRENHdDFq?=
 =?utf-8?B?TUQzc3l6MjdCUGdyS2tXV3paU2dUZnJteHFXMnVmbm1JdUpjSDlHeXVBNVpI?=
 =?utf-8?B?WG43amp3TW5sWW1WWFh3SzhReFdWNnhmbCs4cEQ2a0loMUp2R0VNQ25Sdits?=
 =?utf-8?B?M0RJZDNmcjhFUUdrQkp4T0RDeVUrb2ZRMTAvcUlpWmhHakhZMUVGM0hMRXVD?=
 =?utf-8?B?SHpjaEJxZms3L21SSDBaaUhnTlFhMEtFTGtNS0hFNUhTQitVdG4wSG10WE0r?=
 =?utf-8?B?ZnpuSHB4R2xRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ukt3TlNobG1uVDNzZmluZmRZVFg0SFpnRmlXam5YV3d1dmhjbG1ZQ0Q1ODIw?=
 =?utf-8?B?K2Q5RWFnaGw3Nnc1SzEzZDkrSU40V01qK3dvVFo3c2t4ZTlva29IRVl2QUFo?=
 =?utf-8?B?Y0VwTWpIN0lHUTg1aFNyLzFEL1o2MDdEOGludjdyZVB5akNNYjhYdC92V0Jp?=
 =?utf-8?B?anRMVDl3SVNyQ2RuWWpKWGxVNHFXdjJJWFdZQ3dKY1V3ejdVTzY5TFhuUE43?=
 =?utf-8?B?aEgvRldKK091aGlmamVSeGovdXZ1dzFBbXVhZldwS2N0bG13dUhTY1RHSjlq?=
 =?utf-8?B?elNYTVdTQkMzZnF4QXZ2c1Buc1h6SWRDaXEzMUNnejFnOVNOUi9EU2lpSFcz?=
 =?utf-8?B?Ny94bllmVTdBRjVEWjcvdE1DNVJUQ3JQN3NJaUxwTUhCd0Y2a1dQTytFUU1H?=
 =?utf-8?B?SFlZUmNTQjdPS2d3QnYyWEV1bmlnVDhiY3pxUW5sRzlVVGhDUW93UXk1WVg2?=
 =?utf-8?B?bzU5dElCV1drMEZSRC9DemNKaGUva3I1LzRFaGtuMFVkN3prdktqMDdSaU5W?=
 =?utf-8?B?UUlnWTNxQVZSMG4xYTIrM0NVUmRnV2hkWFlhRGptWWlCK2tHYXhldEo2M0xn?=
 =?utf-8?B?dk9ibytuV2V4ZFRsL0lZM1BHYzYxenlHMW5rcEZMNVQyNEo4ZDVwVHFQSnYw?=
 =?utf-8?B?K1hOdEc3bE4vZWErSmNJZEMxbUkrSnlwU1JWNmR5bnV5a0lsNGRHVTcwOUlr?=
 =?utf-8?B?a3k0Q3VHMWtkNWpsNGM1bG5ycUR4WFBQVmRYNHJtMDgyWWJmSUZLWFdQb1Rp?=
 =?utf-8?B?b1JZV092bW1Bb1IxVnhyWG8rNXFLZDFPR2d1REVvVnNnY0pPdnZEd2VNenNC?=
 =?utf-8?B?V25rK3MwMXhOMlc5RlRHR0l1OVVReFEzcDhKVmh3aDRNTXlscnJDaHdFN1Jm?=
 =?utf-8?B?TjZJdWNIaWxXZmlwcUNuRHozOTFaUDFtdkprUkZvZmZrZ3R3MHF6c1AzZ292?=
 =?utf-8?B?VUJndVZhWTcrSUMvdkVabEhSdUNiT3I2TnMya3hDdnlxUmVEUmpxdnFSTkt4?=
 =?utf-8?B?aUI2OVYzQlgwNzVRd3NwaUxiTHAycndrU0J4amFaSXpxaTJtSFdsdmxMQndC?=
 =?utf-8?B?Q1JWY1RaVGFCZ1dTdDBhMjE4eUZ6S2Z0QVBOWHUwREdHY3AraWRTRC9uV2p0?=
 =?utf-8?B?MERiU1drdm1HYWkyZkllZEs3TDVCUFNnRWwvNE83MWhoalZVSjdybDZJSkd2?=
 =?utf-8?B?cFBNNlFQcjZVMVpJWXlQQmZTeGNYTjlRSU43Y3VxMFdvNkM3eU5XWWtnL2Fo?=
 =?utf-8?B?aDZoQkJYYmxTUXFYWXV1aWJub0F4cVN3MzBBN0gxMlBmbTU1YlFrbGxFaWly?=
 =?utf-8?B?blFucks4aVdFN0l0WGxCWHFzNjJIcEFQdUZySE80b2xxMHM4RnAyZTBrTGFG?=
 =?utf-8?B?SHQ3SE1xNTdiN1NNODFYMElBcEdubSt4RVROTnpLRkhPSVpPY1V1WXN6eFBx?=
 =?utf-8?B?QmZlandVdGlwcVlRRXdjNGxzajB4ZmlCQ2w1dS94bmVqTmNHSXRjUmMzMkc1?=
 =?utf-8?B?YjRWVkZwdlNxekJlbUZoWVBRYUY2Y0U0OW80ak1KWlJWbHVBbEtlNElyK1py?=
 =?utf-8?B?aTVTTjZjeE9JSFBTTWJSRFJWRloxQWcwYXg0MUNaYWdZd21taitZRXVRMThq?=
 =?utf-8?B?aWJtalpUTC9aNmVJNHdzY2hBZkpodlNDR3NNOHp0aWJKTkpHa1lHSjFBZjdz?=
 =?utf-8?B?bUJvRUg4VGJHZG1qNVRGYzRCcVpUK1g1cnlyRVlXYURGRkdmM0NScnBLRlk2?=
 =?utf-8?B?MkxEZnJNdkhiWm0vTnU0U1AzQWVnRFFHQXVpa21zZTlzSG12QnlhT2lrdUdM?=
 =?utf-8?B?L2ZoYU5KZCt3WG80bmhBN1c3MFkzN1UwZFNCU01udnVNdExPdjhrQXJlM2lJ?=
 =?utf-8?B?OUsrWHhWcG1IU0pYd2JnYzlWa3ZSSWM2Y2xYWWdSY1Z4NFRTVzBRVENpUnk5?=
 =?utf-8?B?QzRXWGpyUllCL1FHb1hhOGRYZ2tEMGJyMHhmVStKYkhFcVUzbnRlblcxYTZi?=
 =?utf-8?B?VHFhanpBTFYyTXlzcjdrL0VsUktGT3dVeEk5WHdCbGlWQmo0aHdyNXEzYWVD?=
 =?utf-8?B?TmdIWUlIOG1pTTE2MktSKzRlQWFyeVRDaVhYUjlubWRDQ09KYmV4eUFyeE12?=
 =?utf-8?B?clUwaGExWC9KN2FMb3VHNmZWNk9XNHhGdHNUZkQ2QVNaS0NEQm9vZktaZ3dw?=
 =?utf-8?Q?wDp91pFKbXBIHG6nW0Ll0LssQz8Ly4a5j8Wqq03dz6yv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b563fd9-5071-4c4f-aa45-08dde4ae40a6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 14:38:41.8577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9nfdk2pEW0j5qH4qI26Hhu/P0vGbMkf7uxPDBgwahDchb4FNqDg1+qfgNloiyiFzNCUgqSbHFewXrFx2wFOaCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6480

On Mon Aug 25, 2025 at 10:24 PM JST, Danilo Krummrich wrote:
> Add sample code for allocating and mapping a scatter-gather table
> (`SGTable`).
>
> Co-developed-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

