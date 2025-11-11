Return-Path: <linux-kernel+bounces-894871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2455C4C4FD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7EC6189CE2E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C21E2FF673;
	Tue, 11 Nov 2025 08:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j5T+AblG"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A345E2D7398;
	Tue, 11 Nov 2025 08:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848752; cv=fail; b=CcKGz4p1Y8OowkUom7tjcqh7QLtsr+BHQe3l1FU4U4kCJ3/Q6SeP5NLBlQ0GgI1osVfo+QSJbsG6w/OdPhx0sbTcKCcNZL+PewUFipBWNIbzjnROFFIkEyGCjOZlU1xHK0zLuLkPnVB2+b8NMDFUsAvjm4Hj/PzPfkaWI1yvheo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848752; c=relaxed/simple;
	bh=YmQUf3vQuHdfej/rDMoJ11Ndq13l/uDsO7umtgVGkyc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Fn8/61SLjRfG+9gprZmguNUzGi0agzh30tEpe2EuIir6HHgAsX533tfwfd1Ee23z9YZeaOQlYvz8qzT2xMPXmvWzi9WM9ccceIHP4L/s/HcGrLIYoKSNIcImc9ERBuNSHpBvRuyeYQa3pZvrnMwrNg8O9AhZ/UywskevHsTVuf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j5T+AblG; arc=fail smtp.client-ip=52.101.53.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVi67aVg3IoQvzwVzkF81dLDNd7rK4lkEfEz5CjEpl2vj/BX023v4CtvXJ/C35XK4CIa3bSRY2An5JPZF+WCeTornkM5wO0OmdBnpvGcd82a42SgqEYzMcHqbiq1YYtYV5ib+psP/ErXGNyLhCnZQWcIVQ6EH/VTKW1k/3+3vHWF1UoSj94M9iT1ym3vD8ojNmnah6ONEw6VaQw4uEyLw0X0s6PZe4auyrC4fcAyBrVpbCJ07+NEk8PqRpA6Ox7olt3ereiCFwVPwuASW2KBL+Q9/qN8rsX/2+HBxBKBZSM/oHomKoQUZr9J3+tF6ZJHbnNb5yYzGAvxLhPVNcTmuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmQUf3vQuHdfej/rDMoJ11Ndq13l/uDsO7umtgVGkyc=;
 b=YatZ8DCS9KmYB3YtFGzctNLxeF2dD4ET9s3HGa687kD5yC7FGDbchYfjClx27gQgNrgwxnUZ8zSm5wQRCkMkVz5UO4wXJz457iKWe3rhH0Iil/FyEv241qKlhzIvcgTd7Om5g/qJFRSvvkWtSHdtmbCkUolslUMZ13yWgM0XkmzS+HdTrQF6u3Vf1kwZfv3sG1NPnhJVu+WZGud3jgWzDvrzqvwWypFI90rfj1TS6WPuQVYtUk4/hK/S+Z1e6IPO5geLFkhEsAhL0kLUVe/WlYR88QbdxQgSQYycTAyCCeeMaLPldxfWU1zY3QNcNuQHHjFY3/sCtMI0YyPfMgy6Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmQUf3vQuHdfej/rDMoJ11Ndq13l/uDsO7umtgVGkyc=;
 b=j5T+AblGHKvm4BED8ktzDdGmiqrCzduE5tnDROxW4uXUfJoiBorLTQ2726K+ppHdRY3VhsqHfytAqBdb1dkEJPDRwiVyVD3oN/iOmykfAgpRindfyPFAbPpezVLznBFqPs/DoGR6Ox70noRqkYsuT9l6z5+F+du71p3mohdv6uzHAqTKzjWbV5D7quSq4cIgs5Wz43bv7n9SjJPptDTOfHt6MkfT9lOJowdWP1rZvtTAPdMgmFcnj0mSybfr4tZtfeDaxyzefDnOp/A0P/uv00koxqaSJj3zS1eSmRguX2lKN40DcLnhFiqFbvuy0o1hdNLCwjOJMTG+azZh1BsnAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN0PR12MB6152.namprd12.prod.outlook.com (2603:10b6:208:3c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 08:12:24 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 08:12:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Nov 2025 17:12:20 +0900
Message-Id: <DE5PQ3927GMS.31N4JGGZK3M1N@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v4 0/4] rust: add Bounded integer type
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Danilo Krummrich" <dakr@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Yury
 Norov" <yury.norov@gmail.com>, "Jesung Yang" <y.j3ms.n@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251108-bounded_ints-v4-0-c9342ac7ebd1@nvidia.com>
In-Reply-To: <20251108-bounded_ints-v4-0-c9342ac7ebd1@nvidia.com>
X-ClientProxiedBy: TYCP286CA0064.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN0PR12MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: d4388dcc-a9c4-46d6-1d13-08de20fa0b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlM5Rnp2SC9GYU1lZFlHR1dhN3FRMmtUdlY3bzNXSnpic2RyS2hVYjd0bTVk?=
 =?utf-8?B?N2lNR3VCUE9lSHMyV0NQQ0paWER1UnVTY1EvV250ZVpBSHFiUlNPL1NzVVVr?=
 =?utf-8?B?Q3FJajVUV0JZRjRLYVA0Q0xhV1dxQ3VXSWpoY2ViYzVsdDJSb3JQSit1b3VR?=
 =?utf-8?B?Zy94eTRuSm03UUF1VjM3V2RzaGdmaFZmaTZYM0I2T1BibTU5ZlBJQXJ4Sjh0?=
 =?utf-8?B?YjNJUjg0WEIxZysxNGtzT3R3V2daZWJDSU85c3QwSUhGVVNlSlNJbWZVSTQ4?=
 =?utf-8?B?MjZ6SlR2T0UzTzUyVDdPNmY0TEk0dWNtOUNkaDNFNTRaZTNuOWtiRzJqeDcy?=
 =?utf-8?B?OEloZHFvOWYxMnN1Ui9TdnhpaXJDSDF4NXRtdjRTYm1adTZoeFlDYnI4M2E0?=
 =?utf-8?B?YUlBM2tRWk9CdmdZUGUxQlZDTUtwWmVwdXp2cTE2eWZuQUZyZFBuM000Y2VR?=
 =?utf-8?B?T1doaG1NaW1YS1E0eUt1SGZ6WjRTQWcrS25oSytNbjg0WWh1dC9lQlhyaHIz?=
 =?utf-8?B?WUpPN3RJc3VmNUxhUHdzRkdWU0Q5OFZ5MmRhaU1nekt5SFdUNGhHeVJadXdO?=
 =?utf-8?B?SlkyT2N5eWdSeTRKZmE4ZzVMc1ZQSlFtRzdQV3UrRTI4RTdEQkFXczdmY2Qr?=
 =?utf-8?B?bys2OVh4QlZkeEhXbzNTRi9hNytvVzhNM3VsZ0dkaWUweUVvSEt6RmVUWCtG?=
 =?utf-8?B?Tk5Sa1lyV3hsVHYvUkxaazgrU2pJQUhzdDNoWmlrVFBPdDczSUx2UHpqdm5j?=
 =?utf-8?B?aDRtVkp3eUJZM2xEVlMrZmk2bzVJblNraVJubXlzUHhiNlZlQzhrUlRDMEJ1?=
 =?utf-8?B?UFpjQzZjVkZLNUdYVzFJSVVQUnFKRXBMb2ZXM3lybWpjT0lQSnlqT3RnanBw?=
 =?utf-8?B?Vi9lME8xWk0vdEZ4emRONDB3dzE2SHVtVUNWd2kzTW1OUjl3UFNsZHlqNnc1?=
 =?utf-8?B?TGlWbUg3WG11MnMrZVJhbTI1K25IWHRBd00vOE5QL2VDSjF2ME9RTnZjTmM4?=
 =?utf-8?B?WUFTWTNtZW1HZlI5SVQxRlJMRk1KeXYxZTlPUWV5U1djSUJTMU90RGZZNG5R?=
 =?utf-8?B?M2xEYWJGVGc5bmt3YmRqd1BIOGJmTStSNzFEenJjR1hPbFZYSEdBWXJnU0NU?=
 =?utf-8?B?OWQvL1dDOUt1MFkzSVEwUzJhQlMzT05xMGppc05qRXhWNkpqM1dUZitzeGcx?=
 =?utf-8?B?VTBpYk4zV0F2Skd5aUtNSkw4cGFwZCtJQUI5dWZtUjRQLy9UdjA3MlpCRXRF?=
 =?utf-8?B?WmE4ZGY0YlRFQUR5TWVFVS84WFFWNGE2VmJXSWFvYXlsQkxpdk8xWUJNcTJB?=
 =?utf-8?B?ODM5Sk5HdEhUUklRQUdiRDcvcUp3SFNVQi8vbWV6TWJjV2JTWFQ5U0E3ZXAx?=
 =?utf-8?B?aXFSaU1DZjlxbW9GZXBxMnpVMWpodGNCWkxGTitkQ2lMTUhvclQ2NnVORFI2?=
 =?utf-8?B?bEJQdHVRSklpb2Q3TVhDRWRCTlp0ZnF4QkpMaWNQajBZUWxaM1N4M3VUSkEx?=
 =?utf-8?B?VTRob1Q1T0pvMlpSUkY0VlZQVllqNFdOcUpodGlZUUJLTER0ZDk1YnlEUDZE?=
 =?utf-8?B?azJMSEVjZXpXdFBocTNMZFJ4SUJaamdvWkRnQzRaTkMyZlZUclQ0SmxsWEow?=
 =?utf-8?B?M0RtMXJVWm1pZUFYUzE1M0dsTTJSSzcrUVZjTEQxVW54NlV2MUsyb1dhY09q?=
 =?utf-8?B?c0xIOG1ZZ2dBRFhxb2l4ZkV0TmRTbWJzK0VsYTA4dHhVU1A4N21hVXFBVWxa?=
 =?utf-8?B?dnFKU2ZveDlYVUFkdnhnenVOMG9remRheklHb3hEeXVQNytWd3JjZ01YZ2J5?=
 =?utf-8?B?ejc2Tk5URDlTTk9wbkFHc0NOSU81MkhaRG5nbjJyR29sb1k0dDZUbVQvUEVK?=
 =?utf-8?B?UnNmdm5hdGFwRi9oSUM5aWVxWnF3eEtiM3lPLzhjV2h6SngrU3EwZG9SOFAy?=
 =?utf-8?B?ZWQ2d0VrbEJVRGVsNUppaHJkMUFuSnc5a2J1aktyQzBHODROQ2kwR1lLbTVH?=
 =?utf-8?B?dm9NbEwzN2VpM2lYZGFTSUJNVU5jcndRc3FRY2tLeVJaSXVZZElHb0JzZm4w?=
 =?utf-8?Q?71z0xg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mk84a1NROWtCZDdHUkxBZElDQ2FiSXkrVlZaUTlsdVkwbUFMeXZTY1FoSnJp?=
 =?utf-8?B?TVdDdnJVK3l4VnhNbzRwcUpxTHE5K2pOTVFsQUZWclBnWjJpdlRvS1NmZkIv?=
 =?utf-8?B?TmtLQy9jNitjcDlPZXBOclAyZEVBdm9sVEhsMGtVWTJHUUlOb2NrbE93RFk3?=
 =?utf-8?B?Z1ViUTJ4aDMxUDF6WXRQbVo3Q2VVei9ZYVNNQlpJSlY4OWN4cVpFYkdDZ2J3?=
 =?utf-8?B?M0lzaFBVZEZNaURsYmk1SzVRdkg3TlArdjBaTHR3NUxpYkd6OGhwc21sZzhs?=
 =?utf-8?B?bTlHM1ltSklqSEJENHZGcWg5RXRMS0E2Q2tKWGZPdDYvTjZUejZieTVVYnlM?=
 =?utf-8?B?UDFhcnQ1R3phVFNvVWdsSHZ1QkE5dXhmemh2UEpNNVhOVkY3QzdjSDQ5bVhJ?=
 =?utf-8?B?enhJUnNPdlBpcWUwYzdOQmgzZHhNTU9zbk9qTDNsSW42NnpsK29rY2owOEVI?=
 =?utf-8?B?WlUxN1cyaEFZOWtIeWRKKzBSZ2I4dWx2NGVKYmxKSGdxMUlCVXBQcVJkMU8v?=
 =?utf-8?B?aVViK05SK09LQXdFL2xVQXQ0UENvSDJGcXhCZlhDd3VpbXZSVTlqVVVZaFlL?=
 =?utf-8?B?RkNVRHN1OHhwOFg0RktmY0VzZEFzSFdSZHZaZFNaVEE0MEEwcU8vQk9tdDFv?=
 =?utf-8?B?MGVJLzhSTTFZaW9EM0J4cEpQcmYrVlIxU0JpN2MzMGQ4dlhiOW1rSWVha3J4?=
 =?utf-8?B?a3J2ZTZ3OEFxQ2FnZ2lMWkQyY3Z1OUlqNGI0NTRDN2d5dEpvQlpuUzdhdmdt?=
 =?utf-8?B?R2gxbWdjdy9tVmVJRzN6WjVpbmdsbjd5TFBtbUpJemFHRnRpNEwrRjJKQ2pZ?=
 =?utf-8?B?WVZsMUdjSTVpTlZaRTdCNXVmRFR1Sm5PUVp1V0Jwa3d4Qkp2ZjF3cE9ZSENz?=
 =?utf-8?B?OHgzZkhDUytBRHl6NXRlVmt3U0lMQUhNdkI0QTYzZzN5YWRxUE1zRlRyeXdS?=
 =?utf-8?B?Y1BaKzg5d1hYOWpQMnBwaysxb0tlWS9kVkFzc1NHR0RJdTdmQ3F3aGtXa3I1?=
 =?utf-8?B?c3kxT1prMnM4QnFWM0Q3WUMyL0FKTVNiTlNwbnV2dm80M2dhdlZ3VHZOV2Ns?=
 =?utf-8?B?SnZMUFJmd01reklWd2ladVc0cTg3bUI5Q2FQQ0dqU3g2TG4wbGRTeEdRV2ZK?=
 =?utf-8?B?cEJ1d2hMd3l0S3hMdGpWYTJacWpLKzlqNmdnWm9zRVlNdEJDTC9UNitKa3FC?=
 =?utf-8?B?WlA3Y2ZoTThZSUQxV2FjOTh6b1JmbEkzaC9PVXlRc2xSdmEvdXBxUGFLc0kx?=
 =?utf-8?B?SUlEUFNOSEwyV1RwSGVGbGh4ZGVleDMyZkN1aS9Cc1FtU3lFcXczQ1pjenQ4?=
 =?utf-8?B?REM5d1Rmbk5tZ3JCdFFpUmwrZjhtM3FZWFcxRS9YenZra01pbVZkd2QxZW53?=
 =?utf-8?B?SjlZRnhtU0RwS1VkUHpsd0liaVFxV01XK21weFNGRm5ic3BuNCtJVmVYdTdS?=
 =?utf-8?B?M2NDQmU1eWE5VHI5ampWQ0RTcVhxT1ZBdVlCYWd4N1hwdGVhbmFnWG5WS204?=
 =?utf-8?B?c2ZBTWRFdXNhVVRMeEs5ZDlnMlJtZGtHcWh3QW5OeEZlamJ2cmNyT3hPT04y?=
 =?utf-8?B?MHlTZnd4dHZjNXdUODNGZGErNzhRdkFZcDJKY2k3dTg1dUNxTkZaam9zeHFR?=
 =?utf-8?B?YzZSUjAwQnNjdXNxNjVSdEloa3pJb2I4YXk3NWx5emdxK2l2VUJnSzZZNGkx?=
 =?utf-8?B?UGN3RndjNGppdGJjWE0zaGVKdktDQnB2bldTSGp5TlQ1aTV3UXdqcGxSVlNo?=
 =?utf-8?B?K1ladDlIb3VBVUtkT29jdWY1Vlp6eTdxb1R3N2FsdGh2cWlBLzIvQ281ajBU?=
 =?utf-8?B?cmJFOHhTbjZnMXJzbUlSTUo0ZUJqSzV2WnRZOTU1c3dMbmpmbzFyRXJQdXZY?=
 =?utf-8?B?cmRYVU9CSzIzcU9MMWszSElDelJLMHRXU2hoYkVhRlNWb3ZRS0dsTm9zMUJr?=
 =?utf-8?B?Ykt4cEltdFh3QlhLLzdDSEVBQm5TUlFjc04zcVZTbXVQYjgrdFlWL0dDcFcz?=
 =?utf-8?B?MXdNaHdEcEZ6ZFRNd1FLODFvMllMNzJzbjYrbUs3MlJvK3BVTGNienJqakx1?=
 =?utf-8?B?ZlI2Vlgwa2FjUkFrRi9UY09hZUc2dUlOR1YyYndiQm5jVlZoTWJnY09UdnJu?=
 =?utf-8?B?N1ZhR2kwTGtGdElqNk10MnlCcHI3QTNuNFhoWngyMmsxRy9SZzZlN3QzaUpR?=
 =?utf-8?Q?ljooiWORUzN3gaC+hnp52wSEYB5+TidY6bbb4NbrS9FI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4388dcc-a9c4-46d6-1d13-08de20fa0b0c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 08:12:23.8359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RbOebH6ZlZ31Ur1VlNqjmK7dPJdwnQQa5sXHXMC3IW+BnHpkGBwlHWwKkTdAM3Hs8kj7WxKfUDxynsHOm+9Bcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6152

On Sat Nov 8, 2025 at 11:23 AM JST, Alexandre Courbot wrote:
> Minor revision adding the feedback received on v3.
>
> Patch 3 adds a MAINTAINERS entry in case the Rust core team would like
> us to maintain this, but please ignore it if you prefer to take it under
> the core umbrella.
>
> This series provides `Bounded`, a wrapper type for primitive integers
> that guarantees that only a given number of bits are used to represent
> values. This is particularly useful when working with bitfields, as the
> guarantee that a given value fits within the number of assigned bits can
> be enforced by the type system, saving cumbersome runtime checks, or
> (worse) stripping data when bits are silently dropped.
>
> For a basic usage, please see the rustdoc of the `Bounded` type on the
> second patch.
>
> The first use of this will be to represent bitfields in Nova register
> types to guarantee that no data is ever stripped when manipulating them.
> This should eventually allow the `bitfield` and `register` macros to
> move out of Nova and into the kernel crate.
>
> The last patch is just here to illustrate the use of this module; it is
> not intended to be merged this cycle as it would likely result in big
> merge conflicts with the drm tree.
>
> This series applies on top of drm-rust-next for the needs of the last
> patch, but the first 2 patches should apply cleanly on rust-next. A
> branch with this series and its dependencies is available here:
>
> https://github.com/Gnurou/linux/tree/b4/bounded_ints
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Hi Rust core team,

With -rc6 approaching, may I enquire on the appetite to merge this for
6.19? This is the last hard dependency for moving the bitfield/register
macros out of Nova, so we need it if we want to tackle this for the next
cycle.

Please let me know if there is more I can do to bring this to shape! :)

