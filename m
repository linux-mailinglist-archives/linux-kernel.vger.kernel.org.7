Return-Path: <linux-kernel+bounces-884022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ACFC2F1BD
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 04:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A1D3A9945
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 03:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDF126F2B0;
	Tue,  4 Nov 2025 03:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fwXKlhy3"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20D626CE1E;
	Tue,  4 Nov 2025 03:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762226022; cv=fail; b=PebM2lTEg2hYCRLpbXjFrL92/ie/DmafLi+ZZJb2852IugwkTT2zyIQ9Sq3CdN3UBTictoWiaMfLWVfFGkjFnfrqGVChsl26pe9cRc3PAFidTq/+9xqla3R55A48xNMVYfRJMHMViX76FGxvyo1SfsOOT/rxUw+VbAT2lcDJtm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762226022; c=relaxed/simple;
	bh=Xm3SL2rBP4mt78yKLKvRFajfqOdjT73KhM5TjNcuMYw=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=LGeNsAZrI7a6DrkL4PkHkklx0aCmzZ1Ow6kTwVOSk+ytBNAP2Pl8GfuDYWsaVpN8JKrIpMR+10atAkn6lfw1dlNp7OlWUL+TgqYiHrR/SQrtUupzI94bVcWderLHPKr3DdPv6goqVOeuGHzHufWuJ7JYmADMNwA2VahwJcft1IQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fwXKlhy3; arc=fail smtp.client-ip=52.101.43.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cs5Xmk/DjI5nJdYbnO1KU8nGU4FTke9TGi4TatYs87RZ6F8qVuK8IHc+vcwxcBE54wtak/1DOH4EqZBL9/crNqDm4UV9YbJFFRuR0BGtlyutARaHnvyzhZugXJbrqw3eojqJTcuB5e8bAKLNd1Z5EGefN4vbxM9LHZmkCzhk4FRcm3MytOz5SxH57hyk51gADmNZu5aFuzvMWnsWgPCtK8jRJG2DjNoK94HXciLiQu8lmpCiCsIvAZimwAMLw5L7MvzaZgCnJkGo0mu5nEScZeEil0q04PeqFoxpv660nzi+bUNvYZSVEztO9ZlRATbkAE3Pijk0FmP9f01Vm0aTzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1W45CPJ8kJExiRAzL4DZWjRPHKiAT4Giq4WXzt49pA=;
 b=AiP6+s5lOc4khVG3/Hxl8GgfBkIV1bR1ehTWUnHIXV0GZp9Egj23mfoh37I7FaE91CjealmJ37e3xCDy0IGsnZqGiR4OpWlA4opbKP7XU1B+KPH4kTRt3aqgjRb91NlGTcQ9Emx7nXP+2LT/my/Vu68moAbHoGygFf33c29MNuuw3d97IJ9g6qBker8NtT3vpil2kLOuHwa6Fe3pLKEpFFkXqkU8Jq6cMMN3sCrmr/b1fbsw3yYm72ZmBSKABZcoK5ATPJ0/bcK26k2On7yH24YPP5wsyCO+r9nUCpxORteSmURDnmeekt2y07BJYlBSMQZdijJqKbQtmbW6sOtwmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1W45CPJ8kJExiRAzL4DZWjRPHKiAT4Giq4WXzt49pA=;
 b=fwXKlhy30nQM9Dc10g/491nLB9U+JhJsRDTg+Jzw73flTMBTHN3yPJ9x9f6kLGSwgxlucKU8Shr/6uR1XWZj3G6VC1dLIjsHnLsgkBhDynD72Olpng1U0VZJHnEyRBmDGOpLs7hpRDJg+J4+PVaNaRK6s98mPjH9jQKGiyb5dvC2fB+efFUJUr/mVpyRYBnOlnRvBNkcq69pRllM5J628PDqrk2oOzLNP8QdzB4HAv6UCvcE14W+mgxX5GGf3E56MCg22QcB4nYkUE8oEBuLBd6pRQtW0c8eDTLZeFN4VsmjttYUTJFqS5EdcxiEVQbzszh+H+ug+MB/LcTINefj/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW5PR12MB5623.namprd12.prod.outlook.com (2603:10b6:303:199::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 03:13:30 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 03:13:29 +0000
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Nov 2025 12:13:26 +0900
Message-Id: <DDZKZFCK27HZ.DY3QVXKFU3BI@nvidia.com>
Subject: Re: [PATCH 1/2] rust: add BitInt integer wrapping type
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Yury Norov" <yury.norov@gmail.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Jesung Yang" <y.j3ms.n@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251031-bounded_ints-v1-0-e2dbcd8fda71@nvidia.com>
 <20251031-bounded_ints-v1-1-e2dbcd8fda71@nvidia.com>
 <aQgQv6F0Ao4DH6U0@yury> <DDZ3QBBUM27H.MJS1S3WHWJO0@nvidia.com>
 <aQkEVqbhoVMUc-Km@yury>
In-Reply-To: <aQkEVqbhoVMUc-Km@yury>
X-ClientProxiedBy: TYCPR01CA0145.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW5PR12MB5623:EE_
X-MS-Office365-Filtering-Correlation-Id: d0d92b74-0ae1-4f1c-fbff-08de1b5020b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVVOMEtuNkZMVWRIZXBPSXdlRGNTTEZJLzdkNEZlYloxVFRhYm9VdDl6V0da?=
 =?utf-8?B?bTRaRFhnOHdoWTVCMVltUDVNeVJzUUNWZURrMXE5UC94MFBkTWhqelp6TnlS?=
 =?utf-8?B?VmtRWjQ0ZkhhTjJ6VDMxUzgxOE9zaFdnL3lhcFZjZkJrRkZoSmxQOEhzeFV2?=
 =?utf-8?B?dTdqZkUyTzZFWHc3bzM1RkVHSm9qUHhES2hSbmV0TTJBam95ZXVSeW1nUXJM?=
 =?utf-8?B?Q3M1Q2U4eVpEZ2NUU2pHOXpDdlJrakM5cjRLcGhOR3dwTmpoU1NEWEFxWTRv?=
 =?utf-8?B?dnE1ZnhqQjJVK3hZM0o3bWZUTU5WOU5uK1g1aWJaZjk1QXk3YkxUdlVYYnIv?=
 =?utf-8?B?T2FRYkFabStDc2ptbC9sNjFsTWllQWdYaGxWOFd4Z0ZvTEI3TGJsbGRQeFBX?=
 =?utf-8?B?Vi9EQ09rOUU2N0lTWjhJY2dvdEJJRXBXM0wrVzJmaW8zQ1didXNTNWdaM3R4?=
 =?utf-8?B?aFFJWGJBQVRPUDVDN1dvVW5HeU5oME15Uk1DTVpOUjlLbXRpQmdKdDg0bUI4?=
 =?utf-8?B?MGdsSEYrYW80TW5kb3FMMWdSSjE1eWhjRVN6c2NNU296Q0xpRURoeTVIQ1hH?=
 =?utf-8?B?ek4ybEc4V290WDVkWkZtUlMwR1doWm9PSm8wTEhpa1hSc1VoZjlzMmcxaHdN?=
 =?utf-8?B?YmdjOVY1WmJQT1pmVEo0UVc3K2dPcVhjMU96WWQxVER0eXpsNE5iREdlMWNw?=
 =?utf-8?B?bTdUTVdGb3NiM1lYbjB6NitvUEkzOFl2MEVZclRjdFl4elZhME5YZGNaTjJW?=
 =?utf-8?B?RHE2cUhHWUE2elVxaEtpM1lKcTBVcGVPaFplME1BVXZsOTFVdiswWFlzSlBn?=
 =?utf-8?B?QkQ5WW1Wa1lWMVAyWE1hRkFTdTA0MUlYdEtkTlpPUUVNc3ZBSVM5M2NWTnB4?=
 =?utf-8?B?SmE3WmpKdHpGeHR5RlNxbmpWWXdJS1NpOFg2MFhZWHUyZkMrZlFEc3dyZi9y?=
 =?utf-8?B?RnlhR242WEx4WFZaRDRhUXhZek1ERm0vUXpSNEhWcWNvTmZWaFlXRW1ob1Vh?=
 =?utf-8?B?U2hqdG5DdTBHa2NYNHdlQkN2T2NKSUF0WWQ1WStRdWorSFM4VnZvZWRVTmRP?=
 =?utf-8?B?SXoycVlwaXI2TEpjcitRcncrUjM3UmJKRS9PWEtmazY5RDU3R1VHOGZKeDZx?=
 =?utf-8?B?UkRuK2NHaDhCVnBQR3h3N0FjWVk0V1JSc0djWGhKRFg3d2VvNUZMRHR2V01j?=
 =?utf-8?B?LzNVeWtVK0RzU2lxTVhWc1pwWG82UlhRSWRJYXNMMjVGenZjc2ZaanFFcHQ3?=
 =?utf-8?B?QlhlK3ZFQVNxTFdCeFgyNjZtbkNpWmlZV2UwUHAwSjljTzNOUUQwT2dWZUwy?=
 =?utf-8?B?dFFQS1VMbFVqYkhIUTEzT3l3bmkzN2tqSnZLb2NwcllodW4vdUczdE9ZYllB?=
 =?utf-8?B?WVJkOHhiMXBHNW9QWEdyc3pPL1laYUNGQlRPT1d2b3I2bVFrVEN5YnJQbnZK?=
 =?utf-8?B?cWdGS2VObU03NnRTNGRWaHI5MG5oMFZVbmFleXErREZKUmgwRG45di9ZbkZp?=
 =?utf-8?B?TnBzYUVoOTIzWFgzTzFUbTRXMExOSmxZcEdna1IzWlkyaGJnWXRlcm9xajVv?=
 =?utf-8?B?RjZsbGtpWXhPZlJLd3dvL2MrOW5WUXdZSGg1ZENXY2hqcUpwYm1rekM3SEE3?=
 =?utf-8?B?S1VwYVlteXZyVFIzMmJLdmQ1amF4dUtWL0hlalo1WWtxdjRQeko3dnhkOVdU?=
 =?utf-8?B?N1JDWTg4Z3kxZVdjNVdJRWlKSE5neitPK1paYXl1alczTFJBdCs0cm5KRGM1?=
 =?utf-8?B?eUE2M1gxMmpybmRqNnZtdEgyT25zaWhzVW4xWWQ2c0lzQktLSXBKVHJkVHRk?=
 =?utf-8?B?aDhUWTFQelBMWHk2RG9kSXlnVEEzYzd5UzJZd1JQc2E5SDh1K2doQVZlaFRM?=
 =?utf-8?B?NGlSMk9GNXUvUkIrc2lGYTc0NjMxOFQ3VXZ6aE1nRnhvWWU5cS9pRDVJY3FY?=
 =?utf-8?Q?tU/YAkzzOZFQMJJ0Rpd8JUu4PezB4X4P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWxjMFczZzhzRG9lTzY4TDdSTVVuVFdLUnB4ZGwwYUJuc0VTQTBwNzNSTitt?=
 =?utf-8?B?UGN4NDVaeEJ6R2ZVWGlvdHV5bU42Y1Y2YkJoQmFtRGhCdWM5bzZkYVJ2YUlC?=
 =?utf-8?B?V2h6SUEyK0lXaEgvYlpBWk5EMm14a1RhNlp4dTNqbG9qYXNnR2t5RW52U1M5?=
 =?utf-8?B?ZGN5YnJITUVMZ3dSRTFUUnFSZ0JYbHFJZ3JJbGo3NW12d0k1VVYxY1hGTFFJ?=
 =?utf-8?B?WW8wVDAwZldydGppb0RqY2NzUVRsZnpaZi9aZlY1dzdXSGdELzN0ZDFRSTZU?=
 =?utf-8?B?SHIyb3pBSzBoRzJRMmczTVdWUVJFejRySC91TnFDNzhxV1ZnaXhielFWTXBs?=
 =?utf-8?B?Tjc5ODJxNGJ3QjFQYVNPb3lCNk1pQkswM3pub0NjbEI2cjQwcmQrSXpVbmJn?=
 =?utf-8?B?d0NhRmJpNzluektmVEkyWmJ4TmRqTVYxTDhFZmtvL01UMmh2QWI1LzYvcTRH?=
 =?utf-8?B?OWMyazFvdW1XQmN0cjN3M3pJbFRjMkZoVmhoS0F0dE9DVGVSS0YrRGFZblVH?=
 =?utf-8?B?d2dzNGYvY1duZzB5Nmp0TUQ3czdVTmJHdVYwK2VyY2hpaVFzZDBoMkZWcTd3?=
 =?utf-8?B?Sm0vVE1XZ0ZPbW84cU1iVmdFdDk1RVVWWDVoWWlHaHhmTFo2U0Q1Qy9tZ0hy?=
 =?utf-8?B?Q01mR2dXZDlONGw5Q25zTitINVcyZG5sOFBEc0w2dytVMGpzck5jSXlWU2hM?=
 =?utf-8?B?Q0VBV1lBakx1NDY2VUZ3TS9UVmozTDRhMUw2K1dIOWVlTFVLTnU1STZHaTNP?=
 =?utf-8?B?TUNiMnRvejRyRFRGc3Q0alNhTHN2bVBEWm84WFM5d0Y5clFuUzI2RGMxSndM?=
 =?utf-8?B?dHMrUXNLbTlsWVlkVmR4TGNleFQybllHZXVaeWRFcUs5S2cwd1lrV3Uyc1dw?=
 =?utf-8?B?STNVS0VVRWVHMTJJWndKNGZDNzhZbk1IbFpIRHczVkFmbDJJbVhGMUNFc3Jh?=
 =?utf-8?B?WkhDZWk2ZHJmS3RFWU9zYlhVMDhGMDFVTmJlNkNTNWEzT0swY0VlQ2h4eGhj?=
 =?utf-8?B?VDR3dXhub3hqc2NlY2QzcW1RV0NDN3pOQXkvSFpDSk4yVnBZQ3BGYi9veDc4?=
 =?utf-8?B?QlNNcnlRbU9GZEd1alY5SVZTVlNZNFJxUmxuWWhvaUVMT0lvdURzR1pmeVl1?=
 =?utf-8?B?YW9hekRiUzdraHpKZUtKeFdPTFFKTytadG9RWml0UHBzNjZJOUpvVHZENUx0?=
 =?utf-8?B?ZnQvVkNoZEd2V1ZQSUpkT09hTWN5QjNwZnFrNHg1azRoZFUzVkYza1hpWVhu?=
 =?utf-8?B?eGVQTHhaM25Rc0p6bzFYeTByYWdPZ1JsT3NRbTE2TGs4Q1lEazI5VWdEaVJJ?=
 =?utf-8?B?NGhPYThXbndwMEx1eDdEK3Nna04wR1dUaWNPR3plbEt0ZEh1WmJuL2dZWXJU?=
 =?utf-8?B?b3JONFJTZTdCUndKU0l4eFAwWGhQbnBuSmFGbnpYWGl4aTJOTUU2a2I4Z3pF?=
 =?utf-8?B?UDVKbHl5dHJKUXJTVHRXbmVVU2YvZ2p0ODBrNGZqQ1ZVWHR0bDBkMFVTUVdl?=
 =?utf-8?B?dW0xZnlmYzFUUHIxMERvNFg3RjV4b0dKTjkxUUNJYUFEL0dSYmF0RFhJenJV?=
 =?utf-8?B?cUtEMlRWNWVpV3gxMkJCQ2xHai9ReTBYWHJTTGFWUXBqMWZmc3dtNWhNWDI0?=
 =?utf-8?B?dk1SUHJvVEZpaFNqWFcrdnJiNmY3N2laOWRFamx5bFY4b0lITUNuZTVZanBr?=
 =?utf-8?B?YVNCd0xTbE04eCszbWovdDJUMUVZVXhvUXZsQ1NDRWdlYW5Yd2ozZjBRaElx?=
 =?utf-8?B?cTNYbVJjUW9zaVRNVENEaysrcjF3UHhUNkYxdFBHSjMxT25VdllxaEd0b0p2?=
 =?utf-8?B?RDEvOUpXS2pUWGxzUWVueXFIY2N3NHRqbEduUjRHUUxlazJ3U2RtQysrWk9E?=
 =?utf-8?B?dXJXUGU2VEdzNFdxTFdWeUNrQkVCTGlrSml2d3BPRE9QSWJpeEQwSS8rbEI4?=
 =?utf-8?B?ZVk2dVRLWWxIU3ZzT0Q0UjEwYWFiMm9FbldhSzZ6TnVoVDZhbWVDbWJpUlll?=
 =?utf-8?B?alorMGRaNDkxY3dYSm9PMGx5M2FaQXRUcWhCMC9FeU5STUgrQXJyNFlYT1RV?=
 =?utf-8?B?bktXZWVDNGpGeGZrQVh4eFk1NnVJVlpFWVk0VVJrbys1blYycVlVdTc1UXps?=
 =?utf-8?B?VjhNQkhkOStRRjl3SXFKTURkQ1FadE8xb0VTd0FOMkRBUE1yTkNTTTJFTzdt?=
 =?utf-8?Q?VlipVvbuWebA3c67ZUSbae42fVKr5t3CE4/hLLyvUdSB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d92b74-0ae1-4f1c-fbff-08de1b5020b4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 03:13:29.7272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uxp4NNOCt3XX56OJVId7husWsefsT2eIxMZApN+VbE0wo4FfKgrLTHzC81mOjlOWXA3huxhgW3t2W4uiJWlKpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5623

On Tue Nov 4, 2025 at 4:36 AM JST, Yury Norov wrote:
> On Mon, Nov 03, 2025 at 10:42:13PM +0900, Alexandre Courbot wrote:
>> Hi Yury,
>>=20
>> On Mon Nov 3, 2025 at 11:17 AM JST, Yury Norov wrote:
>> > On Fri, Oct 31, 2025 at 10:39:57PM +0900, Alexandre Courbot wrote:
>> >> Add the `BitInt` type, which is an integer on which the number of bit=
s
>> >> allowed to be used is restricted, capping its maximal value below tha=
t
>> >> of primitive type is wraps.
>> >>=20
>> >> This is useful to e.g. enforce guarantees when working with bit field=
s.
>> >>=20
>> >> Alongside this type, provide many `From` and `TryFrom` implementation=
s
>> >> are to reduce friction when using with regular integer types. Proxy
>> >> implementations of common integer traits are also provided.
>> >>=20
>> >> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> >> ---
>> >>  rust/kernel/lib.rs        |   1 +
>> >>  rust/kernel/num.rs        |  75 ++++
>> >>  rust/kernel/num/bitint.rs | 896 ++++++++++++++++++++++++++++++++++++=
++++++++++
>> >>  3 files changed, 972 insertions(+)
>> > =20
>> > ...
>> >
>> >> +/// Evaluates to `true` if `$value` can be represented using at most=
 `$num_bits` on `$type`.
>> >> +///
>> >> +/// Can be used in const context.
>> >> +macro_rules! fits_within {
>> >> +    ($value:expr, $type:ty, $num_bits:expr) =3D> {{
>> >> +        // Any attempt to create a `BitInt` with more bits used for =
representation than its backing
>> >> +        // type (i.e. create an invalid `BitInt`) must be aborted at=
 build time.
>> >> +        build_assert!(
>> >> +            <$type>::BITS >=3D $num_bits,
>> >> +            "Number of bits requested for representation is larger t=
han backing type."
>> >> +        );
>> >> +
>> >> +        let shift: u32 =3D <$type>::BITS - $num_bits;
>> >> +        let v =3D $value;
>> >> +
>> >> +        // The value fits within `NUM_BITS` if shifting it left by t=
he number of unused bits, then
>> >> +        // right by the same number, doesn't change the value.
>> >> +        //
>> >> +        // This method has the benefit of working with both unsigned=
 and signed integers.
>> >> +        (v << shift) >> shift =3D=3D v
>> >
>> > In C it doesn't work:
>> >
>> >         int c =3D 0x7fffffff;
>> >         printf("%x\t%x\n", c, (c << 1) >> 1); // 7fffffff	ffffffff
>> >
>> > Neither in rust:  =20
>> >
>> >         let c: i32 =3D 0x7fffffff;
>> >         println!("{} {}", c, (c << 1) >> 1);  // 2147483647 -1
>> >
>> > Or I misunderstand something?
>>=20
>> For a short while I though this was indeed not working, to my despair as
>> this looked like an elegant solution.
>
> No it does not. One suggested by Alice is better because it's more
> straightforward.

The benefit of the shift approach is that it makes it very clear to the
compiler that the MSBs will be unused, opening the way to related
optimizations. I'm worried this would not be carried as clearly if we
rely on value comparisons.

> =20
>> But then I considered why we are doing that shift by 1 in the first
>> place: that would be because we are intent on using only 31 of the 32
>> bits of the `0x7fffffff` value, in order to encode a signed number.
>>=20
>> And the positive `0x7fffffff` value cannot be encoded as a signed
>> integer of 31 bits, as after ignoring the MSB the next bit (which would
>> be the sign bit) is `1`. So the post-shift value differs from the
>> original one, and the creation of a `BitInt<i32, 31>` for that value
>> fails, which is working as intended.
>>=20
>> If OTOH we did the same operation for a `BitInt<u32, 31>`, the
>> non-signed nature of the value would make the shift-and-back operation
>> produce the same value as the initial one - allowing the creation of the
>> `BitInt`, which again is correct because `0x7fffffff` can be
>> represented as an unsigned value using 31 bits.
>>=20
>> I have tested both cases successfully - so this way of validating still
>> looks correct to me.
>
> I read this carefully more than once, but still can't understand. So
> I gave your macro a try:
>
>   macro_rules! fits_within {
>       ($value:expr, $BITS:expr, $num_bits:expr) =3D> {{
>           let shift: u32 =3D $BITS - $num_bits;
>           let v =3D $value;
>  =20
>           (v << shift) >> shift =3D=3D v
>       }};
>   }
>  =20
>   fn main() {
>       let a: i32 =3D -1;
>       let b: i32 =3D 0x7fffffff;
>  =20
>       println!("{}", fits_within!(a, 32, 31)); // true
>       println!("{}", fits_within!(b, 32, 31)); // false
>   }
>
> This is exactly opposite to what I naively expect: 32-bit '-1'
> shouldn't fit into 31-bit storage, but 31-bit 0x7fffffff should.

That still looks correct to me, but from your later example I understand
why you think it isn't. Let me explain my reasoning.

For `a`, you want to represent the signed value `-1` using 31 bits.
That's possible (just like you can represent it using 16 or 8 bits), so
`fits_within` succeeds.

For `b`, you want to represent the signed, positive value `0x7fffffff`
using 31 bits. To do that, the MSB or sign bit must be zero, but bit 30
is set to 1 in that value. Thus you need at 32 bits to represent it
properly, and `fits_within` fails.

But from your example below I think your expectation is that we should
consider bit 30 as the sign bit in this case? There could be a case for
doing that, but I think it is also essential that we are able to express
things like "create a 4-bits BitInt with the value -1" simply.

>
> And said aloud, my naive expectation is: fits_withing() must
> return true iff typecasting from one type to another followed
> by typecasting back to the original type would not change the
> value.
>
> Nevermind. Let's consider a more practical example: I read some
> 12-bit ADC with a C function:
>
>         int read_my_adc();
>
> It gives me either some 12-bit value, or errno, like -EAGAIN. Let's
> assume my ADC is differential, and bit 11 encodes sign of the output.
> Now, I want to put it into a 12-bit variable. So:
>        =20
>         let val =3D read_my_adc(); // -EAGAIN
>         fits_within!(val, i32, 12);
>
> returns true. This is surely not what one would expect.

In Rust `read_my_adc` would return a `Result`, so you cannot pass the
error value to `fits_within` to begin with.

Now if the problem is that `val`'s MSBs are zero and we still want to
interpret it as signed with bit 11 as the signed bit, that's a different
thing (and I better understand the different expectations we have about
`fits_within`). We could either normalize the value before turning it
into a bounded int, or have a dedicated constructor that only considers
the first 12 bits and extends the bit sign as appropriate. Normalizing
is simple ("if bit 11 is set then apply this mask on val"), so I'd
suggest that `read_my_adc` does that (and better, returns a
`Result<BitInt>`).

>
> This is one more example:
>
>         let a: i64 =3D -1i64;
>         println!("{}", fits_within!(a, 32, 31));
>
> Here you exceed even the 'backing storage', but still return OK.
>
>> >> +    }};
>> >> +}
>> >> +
>> >> +/// Trait for primitive integer types that can be used to back a [`B=
itInt`].
>> >> +///
>> >> +/// This is mostly used to lock all the operations we need for [`Bit=
Int`] in a single trait.
>> >> +pub trait Boundable
>> >> +where
>> >> +    Self: Integer
>> >> +        + Sized
>> >> +        + Copy
>> >> +        + core::ops::Shl<u32, Output =3D Self>
>> >> +        + core::ops::Shr<u32, Output =3D Self>
>> >> +        + core::cmp::PartialEq,
>> >> +    Self: TryInto<u8> + TryInto<u16> + TryInto<u32> + TryInto<u64>,
>> >> +    Self: TryInto<i8> + TryInto<i16> + TryInto<i32> + TryInto<i64>,
>> >> +{
>> >> +    /// Returns `true` if `value` can be represented with at most `N=
UM_BITS` on `T`.
>> >> +    fn fits_within(value: Self, num_bits: u32) -> bool {
>> >> +        fits_within!(value, Self, num_bits)
>> >> +    }
>> >> +}
>> >> +
>> >> +/// Inplement `Boundable` for all integers types.
>> >> +impl<T> Boundable for T
>> >> +where
>> >> +    T: Integer
>> >> +        + Sized
>> >> +        + Copy
>> >> +        + core::ops::Shl<u32, Output =3D Self>
>> >> +        + core::ops::Shr<u32, Output =3D Self>
>> >> +        + core::cmp::PartialEq,
>> >> +    Self: TryInto<u8> + TryInto<u16> + TryInto<u32> + TryInto<u64>,
>> >> +    Self: TryInto<i8> + TryInto<i16> + TryInto<i32> + TryInto<i64>,
>> >> +{
>> >> +}
>> >> +
>> >> +/// Integer type for which only the bits `0..NUM_BITS` are valid.
>> >> +///
>> >> +/// # Invariants
>> >> +///
>> >> +/// Stored values are represented with at most `NUM_BITS` bits.
>> >> +///
>> >> +/// # Examples
>> >> +///
>> >> +/// ```
>> >> +/// use kernel::num::BitInt;
>> >> +///
>> >> +/// // An unsigned 8-bit integer, of which only the 4 LSBs can ever =
be set.
>> >> +/// // The value `15` is statically validated to fit within the spec=
ified number of bits.
>> >> +/// let v =3D BitInt::<u8, 4>::new::<15>();
>> >
>> > What for do you make user to declare the storage explicitly? From
>> > end-user perspective, declaring 4-bit variable must imply the most
>> > suitable storage... C version of the same doesn't allow user to select
>> > the storage as well:
>> >
>> >         _BitInt(4) x =3D 8;
>> >
>> > I can't think out any useful usecase for this... I believe that the
>> > optimal storage must be chosen by implementation. And it may even be
>> > different for different arches.
>>=20
>> Alice provided a good justification in her reply, but let me elaborate a
>> bit more.
>
> This is what Alice said:
>
>   It's more complex to not specify the backing storage explicitly, but I
>   also think it would be nice to be able to avoid it.
>
> I agree with her. But I don't see any justification here for the
> proposed approach.
>
> TBH, I think it's not too complicated to realize that the best
> backing storage for an N-bit value is 2^(ceil(log(N)))-bit type,
> unless arch specifics comes in play.
>
> I also think that you can bake first version based on 64-bit backing
> storage, regardless of number of bits, so tailoring BitInt() would
> be a future improvement.

I don't think I can explain it better than I already did. If we don't
let users control the size of their values, it will make it very
cumbersome to perform actual work with them.

>
>> C allows itself to implicitly cast values when performing operations.
>> For instance:
>>=20
>>     signed char a =3D -128;
>>     unsigned int b =3D 120;
>>     unsigned short c =3D b + a;
>>=20
>>     printf("%d\n", c);
>>=20
>> This absolutely not confusing program is perfectly valid and prints
>> `65528`.
>>=20
>> For the equivalent code in Rust:
>>=20
>>     let a =3D -128i8;
>>     let b =3D 120u32;
>>     let c: u16 =3D b + a;
>>=20
>> I don't even bother printing the result because these 3 lines alone
>> produce 3 build errors. Rust doesn't let you perform operations on
>> primitive integers that are not exactly the same type.
>>=20
>> So that's the first reason for explicitly passing a type: so you can
>> perform the operations you want with your `BitInt` without jumping
>> through cast hoops. This is particularly important to use it with
>> bitfields, which is the primary goal.
>
> OK, that's really a Rust innovation. So, if we follow the rule, I have
> two and a half considerations:
>
> 1. It also means that BitInt(u8, 4) and BitInt(u8, 5) should be the
> different types, and you shouldn't be able to do arithmetics with them
> even if the backing types match. Can you confirm that?

That's true as of v2. But we could probably make it work, and make the
return type be the backing type. Actually I got the following to work:

    let v =3D BitInt::<u8, 4>::new::<15>();
    let u =3D BitInt::<u8, 5>::new::<30>();

    assert_eq!(v + 5, 20);
    assert_eq!(v + u, 45);

And I'd say it probably does make sense to support this, since `BitInt`
is really just a transparent shell around a primitive type that
restricts its allowed values. That's all the more reason to specify the
type being wrapped, otherwise you wouldn't be able to e.g. add a
`BitInt<4>` to a `BitInt<17>` as their automatically-infered backing
types would differ.

>
> 2. Later in your patch you allow this:
>
>   let v =3D BitInt::<u32, 4>::new::<15>();
>   assert_eq!(v * 10, 150);
>
> This one is really misleading. You allow me to multiply 4-bit number
> by 10, which looks really C-like, and produce an extended result, just
> like C does. But from what you say here, and Miguel in another email,
> it breaks the spirit of Rust types safety.

We don't produce an extended result here. We multiply a u32 with another
u32, and get a u32 as a result. It does make sense when (repeating
myself, but this is the fundamental point) you consider `BitInt` as a
transparent shell around a primitive type that restricts its possible
values.

>
> 2a. Here you allow to do:
>
>   let v =3D BitInt::<i32, 4>::new::<15>();
>   let n =3D -EINVAL;
>   assert_eq!(v + n, -7);
>
> And this is not OK. To follow Rust way, you need to convert n to
> BitInt(4), and then it would work as expected - making sure it's
> impossible and throwing an overflow.

Have you tried building this code before telling me it is allowed? How
do you get `EINVAL` as an integer in Rust?

Error codes are their own type, `kernel::error::Error`, so you cannot
even contemplate adding them to an integer.

>
>> Another reason is that even if you don't care about the size of the
>> storage, you should care about its signedness, which is part of the
>> type.
>
> Just invent BitUint or unsigned BitInt, or teach the macro to
> understand BitInt(i12) notation.
>
>> I played a bit with C's `_Bitint`, and managed to produce this
>> wonder:
>>=20
>>     _BitInt(8) v =3D -1;
>>     printf("%d\n", v);
>>=20
>> This programs prints `255`, even though I used the signed "%d"
>> formatter? Maybe that's because I should make my `_BitInt` explicitly
>> signed?
>>=20
>>     signed _BitInt(8) v =3D -1;
>>     printf("%d\n", v);
>>=20
>> Nope. Still `255`. Go figure. =C2=AF\_(=E3=83=84)_/=C2=AF
>
> Clang throws Wformat on this; and it is printf() issue, not the
> _BitInt()s math bug.
>
>> You cannot do that with our implementation. You either specify
>>=20
>>     let v =3D BitInt::<i8, 8>::new::<-1>();
>>=20
>> and get a proper, signed `-1` value that prints properly, or do
>>=20
>>     let v =3D BitInt::<u8, 8>::new::<-1>();
>>=20
>> and get the build error you should get. No ambiguity, no surprises.
>>=20
>> >
>> >> +/// assert_eq!(v.get(), 15);
>> >> +///
>> >> +/// let v =3D BitInt::<i8, 4>::new::<-8>();
>> >> +/// assert_eq!(v.get(), -8);
>> >> +///
>> >> +/// // This doesn't build: a `u8` is smaller than the requested 9 bi=
ts.
>> >> +/// // let _ =3D BitInt::<u8, 9>::new::<10>();
>> >> +///
>> >> +/// // This also doesn't build: the requested value doesn't fit with=
in the requested bits.
>> >> +/// // let _ =3D BitInt::<i8, 4>::new::<8>();
>> >> +///
>> >> +/// // Values can also be validated at runtime. This succeeds becaus=
e `15` can be represented
>> >> +/// // with 4 bits.
>> >> +/// assert!(BitInt::<u8, 4>::try_new(15).is_some());
>> >> +/// // This fails because `16` cannot be represented with 4 bits.
>> >> +/// assert!(BitInt::<u8, 4>::try_new(16).is_none());
>> >
>> > Nice! Maybe .is_overflow() instead of .is_none(), so that user will
>> > know that the variable contains truncated value. Just like C does.
>> >
>> > Can you please print the exact error that user will get on compile-
>> > and runtime? How big is the cost of runtime test for overflow? If it
>> > is indeed nonzero, can you consider making the runtime part
>> > configurable?
>>=20
>> `is_none()` comes from the `Option` type, so we cannot change its name
>> and it's the idiomatic way to do anyway.
>
> I understand. I suggested to implement this .is_overflow(), and have
> .is_none() reserved for cases like assigning floating values to
> unsigned type.

We cannot add a method to `Option`, we would have to implement our own
return type and we are not doing that. Returning an `Option` is the
idiomatic way to do in that case, that's how it is done in the standard
library [1], and everyone a bit familiar with Rust expects this pattern.

[1] https://doc.rust-lang.org/std/num/struct.NonZero.html#method.new

We also don't need to reserve anything for assigning floating values to
unsigned types, since you already get a build error if you try to assign
floating values to unsigned types.

>
>> The runtime cost for overflow is the double-shift and comparison with
>> the initial value.
>
> Are you sure that everyone is OK to pay this runtime cost, especially
> after passing debug phase?

`BitInt` guarantees the following invariant: stored values can be
represented within `N` bits, and the compiler and user can make
optimization decisions based on this invariant.

If you want to create a `BitInt`, you must guarantee that this invariant
is withheld for the value you want to wrap. If you can prove this
statically, you can use `new` or `from_expr` constructors, and there
will be no runtime check and thus no runtime cost.

If you cannot, then you must check the value at runtime - otherwise you
get undefined behavior.

Now we can also add a `new_unchecked` constructor that is marked
`unsafe` and bypass that check altogether if the need arises, but for
now the current family of constructors looks reasonable to me.

>
>> >> +/// // Non-constant expressions can also be validated at build-time =
thanks to compiler
>> >> +/// // optimizations. This should be used as a last resort though.
>> >> +/// let v =3D BitInt::<u8, 4>::from_expr(15);
>> >
>> > Not sure I understand that. Can you confirm my understanding?
>> >
>> > 1. For compile-time initialization I use BitInt::<i8, 4>::new::<8>();
>> > 2. For compile- or runtime initialization: BitInt::<i8, 4>::from_expr(=
val);
>> > 3. For runtime-only initialization: BitInt::<i8, 4>::try_new(val);
>> >
>> > In this scheme #3 looks excessive...
>>=20
>> This example was not very good. The v2 features a better one:
>>=20
>>     let v =3D BitInt::<u32, 4>::from_expr(some_number() & 0xf);
>>=20
>> Here assume that `some_number()` returns a random value. You cannot use
>> the static `new` constructor, as the exact value is not statically
>> known, so the alternative would be to use `try_new` and check for an
>> overflow error you know cannot happen because the value is masked with
>> `0xf` and thus will fit the 4 bits.
>>=20
>> `from_expr` allows you to create this `BitInt` infallibly, by relying on
>> the compiler being smart enough to infer from the mask operation that
>> the value will indeed satify the constraints of the `BitInt`, and throws
>> a linker error if it couldn't. If the program builds, there is no need
>> for error checking and no runtime validation.
>
> So from_expr() only allows statically true expressions, like this one
>
>         some_number() & 0xf < 16.
>
> And try_new() allows true runtime fallible ones.
>
> Looks like OK... But this ::new<8>() syntax really looks overloaded.

That's how Rust deals with constant parameters. FWIW, using
`from_expr(8)` should be strictly equivalent, but the `::<8>` syntax has
the benefit of being usable in `const` context.

>
>> >> +/// // Common operations are supported against the backing type.
>> >> +/// assert_eq!(v + 5, 20);
>> >> +/// assert_eq!(v / 3, 5);
>> >
>> > No, v + 5 =3D=3D 20 for a different reason. There's nothing about 'bac=
king
>> > storage' here.
>> >
>> > v + 5 should be 20 because addition implies typecasting to the wider
>> > type. In this case, 20 is numeral, or int, and BitInt(4) + int =3D=3D =
int.
>> >
>> > I tried C23, and it works exactly like that:
>> >
>> >     unsigned _BitInt(4) x =3D 15;
>> >
>> >     printf("%d\n", x + 5);                              // 20
>> >     printf("%d\n", x / 3);                              // 5
>> >     printf("%d\n", x + (unsigned _BitInt(4))5);         // 4
>> >     x +=3D 5;
>> >     printf("%d\n", x);                                  // 4
>> >
>> > Rust _must_ do the same thing to at least be arithmetically
>> > compatible to the big brother.=20
>>=20
>> Rust doesn't do implicit casts. I do agree that "backing storage" is not
>> the best choice of words though.
>
> In fact, in "assert_eq!(v + 5, 20)" the '5' is implicitly typecasted
> to the backing storage type.
>
> In other words, Rust doesn't prohibit typecasting. It just typecasts
> to the most restricted type, instead than most relaxed one.
>
>> > It makes me more confident that this 'backing storage' concept
>> > brings nothing but confusion.

`5` is never cast. It is created as the backing storage type of `v` from
the beginning.

>> >
>> >> +/// // The backing type can be changed while preserving the number o=
f bits used for representation.
>> >> +/// assert_eq!(v.cast::<u32>(), BitInt::<u32, 4>::new::<15>());
>> >> +///
>> >> +/// // We can safely extend the number of bits...
>> >> +/// assert_eq!(v.extend::<5>(), BitInt::<u8, 5>::new::<15>());
>> >> +/// // ... but reducing the number of bits fails here as the value d=
oesn't fit anymore.
>> >> +/// assert_eq!(v.try_shrink::<3>(), None);
>> >
>> > Not sure what for you need this. If I need to 'extend', I just assign
>> > the value to a variable:
>> >
>> >         BitInt(3) a =3D 3;
>> >         BitInt(10) b;
>> >         int c;
>> >
>> >         b =3D a + 123;    // extend
>> >         c =3D b;          // another extend
>> >
>> > How would this 'extend' and 'shrink' work with arrays of BitInts?
>>=20
>> I think this discussion would be more productive if we don't rely on
>> examples in a language that is irrelevant for the current patch. :)
>
> The language I rely on is called 'pseudo language', and it is perfectly
> OK as soon as it helps me to describe my intention. If you want me to
> start thinking in Rust, please make it more friendly.

I am doing my best to make my explanations accessible.

To answer your question, your code above would translate to
something like:

    let a =3D BitInt::<i8, 3>::new::<3>();
    let b =3D BitInt::<i16, 10>::from_expr(a.cast::<i16>() + 123i16);

    let c: i32 =3D b.into();

(let `let b` line works because `from_expr` can infer that the BitInt
invariant won't be broken - another way would be to use `try_new` if the
value in `a` was not known at build time).

Regarding arrays of BitInts, I guess you mean BitInts that are larger
than any primitive type? This is out of scope for this implementation.

>
> The following is really a nightmare:
>
>         let a =3D BitInt::<u8, 3>::new::<3>();
>         let b =3D BitInt::<u16, 10>::new::<123>() + BitInt::<u16, 10>::tr=
y_from(a);
>
>         let c =3D BitInt::<u32, 32>::try_from(a) + BitInt::<u32, 32>::try=
_from(b);

It also wouldn't build. Here is the correct version (assuming the `+`
operator improvement discussed above is available):

    let a =3D BitInt::<u8, 3>::new::<3>();
    let b =3D BitInt::<u16, 10>::new::<123>() + a.cast::<u16>();

    let c =3D a.cast::<u32>() + u32::from(b);

Note that `b` and `c` are regular `u16` and `u32`. Arithmetic operations
cannot guarantee that the BitInt invariant will be maintained, so the
result needs to be converted back if that's what one wants.

>
>> Rust does not allow overloading the `=3D` operator, so these implicit
>> conversions from one type to another cannot be performed. Having
>> dedicated methods is an idiomatic way to do this according to my
>> experience - an alternative would be to have `From` implementations, but
>> doing this elegantly would require one language feature (generic const
>> expressions) that is still not stable.
>>=20
>> >
>> >> +/// // Conversion into primitive types is dependent on the number of=
 useful bits, not the backing
>> >> +/// // type.
>> >> +/// //
>> >> +/// // Event though its backing type is `u32`, this `BitInt` only us=
es 8 bits and thus can safely
>> >> +/// // be converted to a `u8`.
>> >> +/// assert_eq!(u8::from(BitInt::<u32, 8>::new::<128>()), 128u8);
>> >
>> > 'Backing type' is useless here too.
>> >
>> >> +/// // The same applies to signed values.
>> >> +/// asserkkt_eq!(i8::from(BitInt::<i32, 8>::new::<127>()), 127i8);
>> >> +///
>> >> +/// // This however is not allowed, as 10 bits won't fit into a `u8`=
 (regardless of the actually
>> >> +/// // contained value).
>> >> +/// // let _ =3D u8::from(BitInt::<u32, 10>::new::<10>());
>> >
>> > If I explicitly typecast from a wider type, please just let me do
>> > that. In the above examples you show that .is_some() and .is_none()
>> > can help user to check for overflow if needed.
>> >
>> > Otherwise, user will hack your protection by just converting
>> > BitInt(8) to u32, and then to BitInt(10).
>>=20
>> Doing so would require validating that the value in the `u32` can fit
>> within the 10-bit `BitInt` one way or the other, so the protection
>> cannot be bypassed that way.
>
> That's what I meant. You allow one way to initialize data, but
> disallow another equivalent and more straightforward way.

I cannot make sense of what you want here. Can you write down what you
expect to be possible to do?

