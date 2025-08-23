Return-Path: <linux-kernel+bounces-783008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD58B3284E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 13:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2676A1B62393
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 11:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC2025291B;
	Sat, 23 Aug 2025 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Be1cvd+k"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9058E188715;
	Sat, 23 Aug 2025 11:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755947394; cv=fail; b=epsfM2aZNyProOX8SK5Z/OTZF+izkcMiWAKW0P2WK8XCL6yQOnYx6oMRKQg2T83tQxbfFCUSs2fwXI+9mMtnFa2q3g8HRsovQwWzkl/NClyUvkVuJgt3jkAYewMYAlh6E1bkAkMxM+IqW8zSYYRoyiEqHBUaTAb3Kq/GAmkuaGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755947394; c=relaxed/simple;
	bh=xS3F120gg47Xr1L7jtnYqeZVn5Lva2sL3Rf3zJEHMjI=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=WBbFagrLbPnk/+Blm71cjWwZoSXj888r7Up4CTOjrqw9NtCk2ISw1Z2IYf6TkF8yJGFglkmCcNY9ArmYVj8g9ZVFrqE4PO7F3noVHu5qKEMGa7sGorcWG7SRBXXxAjuLECssfxozUXI1WHYVBwrMmAKbIaNhVplVoO5Bbt1Cf24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Be1cvd+k; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXAtA1uqwD2Yqa5aOsTd0/3bY22NJyb+b0WmSxan40g8Ti7b4XbU1ips1Vfg4dwegSxLPs3EPmALRb3XZaY88qqKR/UWJrYPrTQmhyLBUJLXrJQAW/PE7Tt45qM7n1Ik3NtdDVW4v6YcbixO5qjE9GMOvQo0o/NAxyJU/CRlaPJh1qy1URnBL9aIT59ukDoihkAhsGGkxF0RiUxPvpKYqW6ScDnBXqgB4wBKEvdKkL9k04sjIDPCG3rn4ESwxH/hhbMh6G0NIJZJ94Zf0v45+4h3/a4+mPd3e7u9MoGaqzqjparMlRE2w4CjlTL0BkTwRkFfQ13mFnVk2KA9CHYppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5JezIRWNgu4lB1R8X07c81mABKjHqGN7uBy2GWhrcM=;
 b=e1113k9DuJXSVzJBAt0QOJmxAEt/VSieQVFQZKH965BfgfsQGLRy6Emnl+XEFaKm7qEBZeWs3Y7+eSVNr77M10NU9KWSJbRTUHAggD1Lb7qua3l5xl6AaHHyYG4f8iESUGtAgXh4JdV5uM3a8bj2UuZ5KmJhkYGoxKFwV+In+Kbwbh3nV8thkilGyMwGGYgVCR4H7TtAS9wR7a3u3/OlwOz4i17pLjVpBPo1DjL1rZHMAfzQQ38eB/lExWuXHSKlLNu9FnQseoLFUpvwGpkgdeXH+AUi1+OWJ8pHc1ft5JGXu6vXgpbGWG+x235l6RdJ3Z4nQn1N/UiALvuCIbWSDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5JezIRWNgu4lB1R8X07c81mABKjHqGN7uBy2GWhrcM=;
 b=Be1cvd+kegTLIvmOOwAQWLxxnAJYQYbSQKrjHZXu30wPKtBXqgHsp2YIJhDeniQ2Z5Pv7nOdqkbuUYOcYwlIR0k7ELftbtvODnMWe8Se4rooGSOB1xdtAcS5s9aViX2qOYcCSbRWUbcnwQBIOc6EfiALmm6Sdv4oCK2peLDeNs77uidVZDR5EkTnGdeHsychLRPZpphrCfH9x0w3BeimIUYsFjKVfuR9u9UbV3Skyobwkz++YUu47i1UGmFdAeIOP+MeIqNbKlb0Unru4r1PFRDtuN/l92MZeMPeBoSCF8wvucYxbVka5t1P3rktSYEhJQNMThILx87VcR0HCH5EuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by LV5PR12MB9827.namprd12.prod.outlook.com (2603:10b6:408:305::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sat, 23 Aug
 2025 11:09:49 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9052.014; Sat, 23 Aug 2025
 11:09:49 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 20:09:46 +0900
Message-Id: <DC9RED1FAC80.B7PYIPB9H5OO@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] rust: dma: implement DataDirection
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <akpm@linux-foundation.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <abdiel.janulgue@gmail.com>, <jgg@ziepe.ca>, <lyude@redhat.com>,
 <robin.murphy@arm.com>, <daniel.almeida@collabora.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250820165431.170195-1-dakr@kernel.org>
 <20250820165431.170195-2-dakr@kernel.org>
In-Reply-To: <20250820165431.170195-2-dakr@kernel.org>
X-ClientProxiedBy: TYAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:404:15::24) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|LV5PR12MB9827:EE_
X-MS-Office365-Filtering-Correlation-Id: da21280f-fd0c-42a0-83f9-08dde2359387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0phUE9ZS0xSM2c5ZDFDcnUzc0dUR1JhdjdpZ2gvdzlabHJMMTBoYk9mOEdR?=
 =?utf-8?B?UHVvZVNuMzdpM0Z4cnp3ZVR3NVBTclFIVlN1RTg2REFYNDZpK1l6Z0dLQks3?=
 =?utf-8?B?OC9HcDBwdTVIZTJYZVZGK0hjeWdSWDRGb1pncW9rQStxM3loU0Y0cUFmbStl?=
 =?utf-8?B?ZTZlMXpZdHZEbCtiRnFhWnBFcDljWlZLSWhuR3NlakowYUtjbk5qVDRVbHc3?=
 =?utf-8?B?NVZNZlJCWkFLWlJyUEM2dU8wU2ljclYxZWpVbUQxY2hSZHdyTUd3eXVBaHp2?=
 =?utf-8?B?dE8wK0t3bFdJMVFVeGlSaGJabkhiK05tSE9tWFRTNWNuZ3orUE9UMGdDRytl?=
 =?utf-8?B?dWRwMGU5OTk1Z1lPQlE1VytHT3g5NzBHTzRBMnk4ZURLZnJSUVZUdGhFaUZp?=
 =?utf-8?B?dHZIR2tXcFBYQXVPaHp6eTJtSSsrMUdjNHMxajBVQ3J0TVZ1YTBSQWxFOHFm?=
 =?utf-8?B?cytyUUR3UUFBcGM4dmVqM0dBMmpxZGtIcGZxNFN4Y3lnYUdmci9HOVdGK3NJ?=
 =?utf-8?B?bzNFc1VRVXI5QlhEUEtIc0VOU3ZtZlhLYjhTcEp4WlEwNGVLdDV1YVFQS0J4?=
 =?utf-8?B?SUFnaU1QTWptOU5VNDgvU2JoYUtZT3NpblpTWmJpcXMvY09LMW42bDg1Ukc3?=
 =?utf-8?B?WDRwNVRtZXp4dFA0SXJXZXpwc21OdTg2ekhRMWRQZy9YWVlrU292djVlUEhi?=
 =?utf-8?B?N2RzZGZ2QnRiM2N0SXY0T1dPWjJMMUQ0cGlLMWZQNFozcEpVemVVK2xxWEYx?=
 =?utf-8?B?MEIxcjZRaGN3ZU9FdG96V1hzNW9VdmwzUzkxK3hvYm9wMzQ2c2VQeXdLaGVw?=
 =?utf-8?B?b2xWWG9zY1pYNkYrSmNpNkxqY1FDbkpVOThocFZrbkU1cE1HRDEreDh4cGNU?=
 =?utf-8?B?RnFYeXNDN0w0M1pxMFB2b1lab2YzMk1GaUdkazl5YkxXV29ucFdyaGFLZTR3?=
 =?utf-8?B?YWp1NUJueHhUWGxnSGtIL2F4N2Y0Z0ZYSUE0bERnQzFFYmoyVEFEZmFWVDUr?=
 =?utf-8?B?cjd2SHVoakhaVFhFS3RpSWhvR2ZuRkR5OHdZV1kyVlJ4bE5aR0Zzem5MVjJu?=
 =?utf-8?B?d3BLWFl3c0VWSDdVcUwycFJDaklxRCtrdmY4bHJRSjJEQ3JJUkY3S215cWs2?=
 =?utf-8?B?ajFHeWE1MkhjUU5GRE84aW94SHcxU3JMaUJWcGNqQWRzUmpqbUxJVlJHLzV3?=
 =?utf-8?B?cW41OEU4YXFOSXJkSDlXV3pPVkJabjc5NGR3cWxJS3ZoMnVFdDNtakdoUzVt?=
 =?utf-8?B?S05GNllEcFFsUjVQRlM3eWN1RUI3c1NJcitBc1VGTzBwTTZjYzlJSVUraG04?=
 =?utf-8?B?TXQySURJTGhsRUVGRTIxRFdsY0N3a1YyVFpBakxJY0ZMVHI3a1V4eWs4Y1A1?=
 =?utf-8?B?dDRnT3RhS21YdWVESFZMVWNEWXBlQmIxQmtuS2t6Vzk4VFo4ekZJRi9qYnk5?=
 =?utf-8?B?ZkVYdkp0eEE5U3ZtOENKa1J0dmpGN09NaElKWjdhZDljRXduZS9nREdTWnJm?=
 =?utf-8?B?VUttU0tTTy9XL0IwK2Jpa3BHUlJzMDE5SjhRMmFPYUpCenFmbGNTcXUxZFd6?=
 =?utf-8?B?K3BUTWw5YmJrcUkxVmVqbkZwWGh0MXh5ZUo5MERjZTRLdGcrN0NldUE0bGNa?=
 =?utf-8?B?YVhVRmcramwxVmV6RE5wb1ZFZ21TSEE0TlEzMzF5QitMYW1PTHdGYkZrbHlZ?=
 =?utf-8?B?QkdCVGR2ZGJzY0FkUGNSbTlaa2RmZ0lxNkNhbWt2T1pwbGdGeTRPc0F0L2Qy?=
 =?utf-8?B?WmswOXFyMlQzUjQ5NHc3RkNxQ0dsVEptc2ExNmVEK3ROV3Y5Z2g0VFhnS1Nh?=
 =?utf-8?B?SjF1bC9Mb1dSSytiY2ZWcGlUVzlqeDFoVzVJSUVnUFVHd3RjeExSa3dXKzRO?=
 =?utf-8?B?V0xVZ0FuY2QwRHcvM3dBVzdyRGJuQWZPcVZHY3dwdElrQ3ZFa0VLUExDV2dH?=
 =?utf-8?B?bm00OUZnNXdDSldUUXcwemR6Ukh6U3RhL200RVhzUktHWTNNY291NzVTRkZy?=
 =?utf-8?B?OFJsMzZ1ZnlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dm1xWnRTNm80UlpQbDQ4Vmx3QTNaaVFOZUh4Z2ltZFhMeXFNcDNyK3FlZm5Y?=
 =?utf-8?B?ZitwTlczdEVuazN2anQ0TVVXTkFUNWVNWHRKalZIVWhYM0JwT2NKSG1hTGpP?=
 =?utf-8?B?TUtWVS9taFpzdFhPellSejFmQmRxclJ3NTZkZFhoVmI0TXo4RUl6TllrRlEz?=
 =?utf-8?B?WFV2KzVBYTJuRFJ5a1hUaU80dUNPS2l5Tm5YaVpadHFTSm9iQTMrQUFwejBi?=
 =?utf-8?B?Qk1Kd3ZLRDlHWnNkSTJUZi9LdkpHWnVOZUZwWFRLM3hOMHpJOVFQODUxbHFI?=
 =?utf-8?B?QldYaTh0TGFBbFhsSlF4S2pIWXpEU2dSYW9DOHIvem1kZEFyZk5vZXhzdjR3?=
 =?utf-8?B?UEI0WnlMeUFiSHdmRzhpSGc5NExwMTNuVzBCd3JJbkc0azJ0ZTF2UjgzOS9u?=
 =?utf-8?B?UkdtalEwVUdPbzVxYVJ3MTRjK01xYVVxdWQraHZ5QklVcEU1TzhCTXRHdnFR?=
 =?utf-8?B?RFJRdXB4cVpCdlNkVy8zaUJGcGhCNkUrWUFCQ1pRT0lTOWRaZ3RVU2N2dVhs?=
 =?utf-8?B?WnpMd3pIdnNBWFR6YlhBRVBWNmZoVkQ3aEJ4aWRCRk9LVTZaZTBJMHZEUWx3?=
 =?utf-8?B?TGkreW4vanhJdnJYdmJYSWFvTkxHbjlCK0g0UGNDSmxYL01tSzVUVm9ack5X?=
 =?utf-8?B?eStDanRMY20wTW5QZGQ0NGlCMXVod1BwOS8xSzVBNy81Q1V1cGxvQjAwLzZV?=
 =?utf-8?B?YjRVMExzb3ZxRXp1OENzVmhmclNQZDM3dzBJRnRGaTJCaDl2WEttMU95cSth?=
 =?utf-8?B?MGZUUDhIaGN3MUU4Z3hySGdVaWxKaEZHdE5zNWREak01STN0clpmNFp6TGdF?=
 =?utf-8?B?Q3ZUSk9XeWh2TmZRTFcyYjZWWUd5cVNvbUwydVlVcGlPOHN3NnRFU1RUYlZ0?=
 =?utf-8?B?NDZyZ2JsbWlmdnlYR0Y0dG9jZUZHQjZVMzZpSVNZcEhoQXB1dXpJcE8vdVJn?=
 =?utf-8?B?Rm0yN05xcTVkTnJRWE85MWRLUnozaU9ELzA4Zit3S1c3OXhhMmxlMnlFekFm?=
 =?utf-8?B?NmZlZ3dFazVJMjlqSkpJWDZYL3U4OFFVZUNsWXFEWmxHdDU4ZUhrTEM5aS9J?=
 =?utf-8?B?TEIraUlNazBIYWVPaGxQeDhMQXRCV3JpYnNHT2duS2lNb3YvaExkOW1KZzlH?=
 =?utf-8?B?RmQwOGd5MGMwS0RDMThjV2FWYWhsM1l2eHBCNFdVaUpOOUZZZXVkNTJOMytl?=
 =?utf-8?B?QWtWVjFhaEl3YmI4VU9mMlgyUDVTVzFNRFhDQ0REbXR0TE5EcFY5WVJXa1ZX?=
 =?utf-8?B?cHdsVzF4MVhxUW5hT1MwT3dvN0VIS2J1NHhsY3FmUFdjUE1lMGxBMXphUGND?=
 =?utf-8?B?K3loOFowQWtMb0F1ekw2elM0SXE0Rng5YU1PVFNtbkZFYVhyOStlQXNXMmNi?=
 =?utf-8?B?Q3hoZWhPQ2ZkNzVUdE01d1ZwYUpLUEhWZDlPNVh2Ynd2YmgrTkNSSE9ZdXll?=
 =?utf-8?B?M0JkN3hKc0VlMjFRaGcxV0NYbkNTNGFJYWh0dDhXaEdwckFhV0tGYisydjhH?=
 =?utf-8?B?d2lncXRXdVdKMzdRY0QvNDBNWTNBRmF2bmZacWdVNnNJUGJLNFZZSzF0TnZq?=
 =?utf-8?B?L2EzTEJiQUlwWTZuWWdjeVFmcGM1eWN2VEhDa2ZxNnpOYlpmbFJHWmcraXMr?=
 =?utf-8?B?SjFEcVlnMEt5SXdXQTJOcHlXU3NPMmhTNnNUd0QraUQ2dVArMVJnV1hvVXNR?=
 =?utf-8?B?U3M4aFZxQW5YWllRenBNMFVEOFEyS2RnTXlYa3BkN2VQNTlXSnpFRnNGVUNr?=
 =?utf-8?B?YWhxSE0yYUxHQnA3UktFZW4wVG1zVlVZYmVvWW5Xb2RteWJhTDIwMnEyWWhP?=
 =?utf-8?B?RGorWHRPT095UHp5Q05pSk5vaks3SzJycldJSnpWd0dLS2o3ajBsb3NQc2N5?=
 =?utf-8?B?SUNyYTVyNG1xN21zTWFhdGhValU3djNRMUNmaHpkVlNkVUc3bFRnMEUzRFZS?=
 =?utf-8?B?VGxweFRsVkFSVnk0WTRCM0c3bVliNnZ1Mm9YdTY4S3VRS2EvS0xvdXhEc2w4?=
 =?utf-8?B?MWxTWGs3ZjczbkY2czVNbWJ4M25mam9OMlhwYlA3TThDZGpGd1RXQ1NWaWkz?=
 =?utf-8?B?UE9oK2JLQ2g0bmNLbGsxVWlJUVhiTWJDZFN6RTdPVGM3U252ZEYrcG95enhm?=
 =?utf-8?B?VllwZjE1aHRpU1ZHUDZoRXo5OHdPRWhabTlLRVNRa0NHUFZZL1AwQjlxZjJZ?=
 =?utf-8?Q?leTejVWZOEvlHeay7BY/cWrHgvUV+EnVObRd6MZqVuUo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da21280f-fd0c-42a0-83f9-08dde2359387
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 11:09:49.4684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jd3KM0XWE/vtj1W5/t65ATz2HSx0W4/spm1K3v8eqIH9w8tldua9gTpxHxgj6a6Usuk19MriALvszKmp0oCeaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9827

On Thu Aug 21, 2025 at 1:52 AM JST, Danilo Krummrich wrote:
> Add the `DataDirection` struct, a newtype wrapper around the C
> `enum dma_data_direction`.
>
> This provides a type-safe Rust interface for specifying the direction of
> DMA transfers.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

One very very minor comment below.

> ---
>  rust/bindings/bindings_helper.h |  1 +
>  rust/kernel/dma.rs              | 68 +++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+)
>
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 0e140e07758b..c2cc52ee9945 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -47,6 +47,7 @@
>  #include <linux/cpumask.h>
>  #include <linux/cred.h>
>  #include <linux/device/faux.h>
> +#include <linux/dma-direction.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/errname.h>
>  #include <linux/ethtool.h>
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 2bc8ab51ec28..5daba00ecc78 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -244,6 +244,74 @@ pub mod attrs {
>      pub const DMA_ATTR_PRIVILEGED: Attrs =3D Attrs(bindings::DMA_ATTR_PR=
IVILEGED);
>  }
> =20
> +/// DMA data direction.
> +///
> +/// Corresponds to the C [`enum dma_data_direction`].
> +///
> +/// [`enum dma_data_direction`]: srctree/include/linux/dma-direction.h
> +#[derive(Copy, Clone, PartialEq, Eq, Debug)]
> +#[repr(u32)]
> +pub enum DataDirection {
> +    /// The DMA mapping is for bidirectional data transfer.
> +    ///
> +    /// This is used when the buffer can be both read from and written t=
o by the device.
> +    /// The cache for the corresponding memory region is both flushed an=
d invalidated.
> +    Bidirectional =3D Self::const_cast(bindings::dma_data_direction_DMA_=
BIDIRECTIONAL),
> +
> +    /// The DMA mapping is for data transfer from memory to the device (=
write).
> +    ///
> +    /// The CPU has prepared data in the buffer, and the device will rea=
d it.
> +    /// The cache for the corresponding memory region is flushed.

Is flushed when? :) The comment for `FromDevice` specifies the timing
for cache invalidation, so it would be nice to have the same here imho.


