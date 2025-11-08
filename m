Return-Path: <linux-kernel+bounces-891262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09285C4248B
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 03:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8776E188AFC7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 02:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F21429E0E5;
	Sat,  8 Nov 2025 02:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SVQKL/Dr"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011071.outbound.protection.outlook.com [40.93.194.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873A8625;
	Sat,  8 Nov 2025 02:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762568653; cv=fail; b=moBZvXGFuNL9TX6Gz3OCyzDSZMS2LbVM9ILXjOk4s/LtIgsq5XshobiaAz1q092NRTG+DWiRnazWiFYjdkGdsDlp1nHg8aktpOrfh2+dqLb1jsV+c/Mhon9hsKtLhYl40DLSXiId6D6B8WDIkulVradxfnYp6NwxA7fAZcDrXG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762568653; c=relaxed/simple;
	bh=7hOmwgEe+g4ugBGqAwEQbfShKIb5XZqW8NyzMtINo6s=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=b8kF6dJFAtw6ppFH0wFSof17tZoxTCWcJm+QNizJM+tBt4mGUA5u2byYjeG75kd/44VfLX3yeQ+nDQphQLrwEgDS7Jc3MBzI7OkHN78+QypaAdVqYaar4Gloyw4x5Q1FuWsO2D1rTssGgMSNYXBf+rKLrBHmrrJxl9p9ENsEwNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SVQKL/Dr; arc=fail smtp.client-ip=40.93.194.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwGzJ+Kvc70Gf3FqL8CR1Fi6nzGMDnPldNmJ80+fx+Lg297GIiA9O1qTur0RIjqSUosW8E9OPErxfqvmUDKjRQFLCPjUevJnddmwB7/x7OqWj0trjPA9/9P1Uee5LeZCkB0/cx615yThFbBaVByM2GA1g2FrCONdDDK8+q5QckApvZmR2LI3V2cATMgij8Lc8xKsLXuHoEGU50UJEPexyplsiR//hENjGIjm85J+NUvt/bVdFk0fb534x7GMvKZkvZdVmws5ozBmXEBek5Sk0WD8VRw2X50q4dujJV0my6XCEXaEObIx/x7rh1VdgOO70PMfdY2eYPm27XXYMWjYkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1fP8pDi8bXgjbc/n4ZdRjpY0cTU/wnJ22kycouIX+M=;
 b=VIS9p3BSPK1KoD6Up93uTSZOf9xGjjcHgt8meNdkD5j6APy9ilas40fPG++hNYQ6/ybpqHAx49mXLkTqdotOoiARjW0BCikdxnO4NJ0N5XgPys2s7Q8jZGaLkiT1eD1iH/al9fNxhwMkERw1DgOVxMLsunc0jFQfobG2a4JGLMwqwUlP1/8RQVoc+0QDcWDc/Y8tQ8D7++04J8xYFXcnzg1AwZbJ8VjsYUvIsGi8Wy97T7eemQQNT2p58tYZ/uU0LQjLA14XpYjiqYeKKJpjEGraSwvLcpcOr0YcBCQibiab0MTaXGaVr/dlSG63LZIhFiWPRvYkf/dkGVWm+EXtXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1fP8pDi8bXgjbc/n4ZdRjpY0cTU/wnJ22kycouIX+M=;
 b=SVQKL/DrRHeLl/qUnYMjIVTcRxz4yBYby+QNLsgXq5pRgqwQ/W8ZaphtOIpPdEy8dVrp4HlchTrTilNXkCxgtStnxCchanbvyYzQiji9RjaWfLwAgVgCQ8uQwoRBt0NLAiTVFXzoiQVKYdlvPDEHtgSqcwsxX1yIB6fYjXChR2JpeuB5MFQhIeGFyX1MjQz5s5N6tWGVoURTmm3zfay2rcNPF64BUUu/D5WZe+dDzA2NN8tIv/OwCFrlUZYeQkQEl7krmngukbDykbNKcMjEGXV9ftoQx8N39CyvteyfsphD5Ju9aEel0bb5WL1rmzxlpGz53qDkm9XyiaW3i3DS5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Sat, 8 Nov
 2025 02:24:04 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 02:24:04 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v4 0/4] rust: add Bounded integer type
Date: Sat, 08 Nov 2025 11:23:46 +0900
Message-Id: <20251108-bounded_ints-v4-0-c9342ac7ebd1@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALKpDmkC/22OzW7DIBAGXyXiXKpdwGD31PeoogqzS8OhODIpS
 hX53YtTVc3f8VtpZvYkCs+Ji3jZnMTMNZU05TbM00aEnc8fLBO1LRSoDgFQjtNXJqb3lA9FIoH
 pHA2elRUN2c8c0/Gse9u2vUvlMM3fZ3vF9fonUteiihIkkYXY9WDYm9dcEyX/HKbPVfxLaXxAs
 aIxUB/JO7yk1n5Vl83hhlaNjlGTi8w6RnrUxLtPV8pxhKDsiKTtXVP/NxHsDa0bbRyCGXrru6C
 v6GVZfgALbl6nkQEAAA==
X-Change-ID: 20251001-bounded_ints-1d0457d9ae26
To: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Jesung Yang <y.j3ms.n@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP301CA0048.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 701e801a-932e-4445-bdfa-08de1e6de2c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjFaL2lLb3dxL0t0MERWYXBLM3pkSFo0SDcwd3hNRkZTZXFKYkFZTjdLZjJ1?=
 =?utf-8?B?a2puU2RhRDluMHNCV3RoNVlPNGh1aHBuanNDV1daL0FIMzVYTmE3YTEwUE5Y?=
 =?utf-8?B?Yy8raFBycFBMaDViN0RNTW5KcmIxUXgyM2gyM3AraXB1U3M4NzFMQ2ZIZDEx?=
 =?utf-8?B?S3NnVi82azQzOGpPZGxFdWZNY2I1SkJwajVGdzJlSXozZzBHODJjQ09OWjNH?=
 =?utf-8?B?ekRtOEhXTjRjbGFDbW41YUZkMHNXSE1KL0JlSWYwcXY2Z2RSbjJrWHFLK0h0?=
 =?utf-8?B?TVBVT294aUhramYrU2dwQ3VkRnJKdlVNWW05Y2E5VXNnSkxFc2tPMnE2eW1L?=
 =?utf-8?B?TWdQejF6blJuVjRlL1Blb3AxZjZkOXRpR1FucEt3cUY5elVRdHZ0eERQYnd6?=
 =?utf-8?B?aUtFRlkxL1JhSkQ3eWNoNXkyZ0NEOXRYaFlMdjhIa1pIN2xGQmZibUxyZER2?=
 =?utf-8?B?TWZxdnd1Q1ZoOUNuQ1hnODYwNnlSeXZRRnVQRGJ0d09WNExFSXROdnFYZndE?=
 =?utf-8?B?am1qOFRJQm94bTkrVU1rUllKS2VZcG56bVByaTJWZ3dia3hnS21lSXgvVUNN?=
 =?utf-8?B?WVR0UzdrRzRERlFEa3ptVWxwakd6YmllR0xJbk9xWGplTWZDY29UdkFoVUdZ?=
 =?utf-8?B?cnpldEFsczJvQVVydEcwcEQzVGVCQmVrNExiTnl0NWhrd3FNeURBejkzSEtm?=
 =?utf-8?B?aE5mTXhCaWwxNkRubjFlb2hKMGpPMGRrQnVrbC8rbk0zelRTSDBGTG5WdlRD?=
 =?utf-8?B?ZXJ6bkFDZDAwREIwZGZnMFVBL3FNN0EyWE1vcVZBWXpmcjhtaGxqQVg0MU15?=
 =?utf-8?B?MlI2Ti9XVC9Oc1pJbWFLYis5RkJ3aVZIV0Q2dTlnQmtWOUFmcXY5VkF1cWpx?=
 =?utf-8?B?OVByT0krVVczR001ZjFteWVYRHZaRlZINDdkUkV5RVpXbDRSaExEYWVVTTQ3?=
 =?utf-8?B?eSszMXdzWWxOaE5DUmRhZFFUaUE3ZEtILzl6U1M5bFVBL20rNW5la0QzWjh4?=
 =?utf-8?B?V0o4SjIzaHFpOFl6c1pBU3FTY0NLZ2FUZGY0ZEluMERINCtIY1Zobk1PREdv?=
 =?utf-8?B?OEhGTXVydTdUemhVOTB0eGRlUzlFbERxY1dwOEVzMEVUQXk4Zk80elIwNUxF?=
 =?utf-8?B?Q3hMVS91QmNqVVNYVCtzWjgyOXZNS2toTFpBNllRUkpPWnEya2J3dUlBVmxY?=
 =?utf-8?B?SHkvc0NGdjlXblg5Z1Fua0VKRkwyM3pLQTRDR1dDYTdZOVEzeVEvUkhtN0hN?=
 =?utf-8?B?NEdQQ0xtN05JcS84U3RjSEVZa3U5SUVnUEIvWndzME5kSmM3T2RNZmUvclNu?=
 =?utf-8?B?eE1rdSt2ZlI2bC8yZXZFSFZJVk1mbkZRempvM2JrZTJUNFkrVjFteXNkV053?=
 =?utf-8?B?NTRoVHQvQlNYNGs4S2dUanh6RjFWdVVrOXordU1NZXljK3VwRWFGVU1JU0Z6?=
 =?utf-8?B?bStmNk0zUUpJZmNVOXNrR2tiWldzRjFJbGdTVnJJV09tNU84Vk1MVlRYbG1w?=
 =?utf-8?B?cnRianViYnRRY3RGeHFza3NrWGRYZXY4QkVPUHBuOUpydVZqQkZreFc2eXQ5?=
 =?utf-8?B?RUNIKzd6M05PanNaUkFoRTIvNUJLa1E4c21zOWlyQ0V2RkdHWEYzSnFhLzNN?=
 =?utf-8?B?aUVzTWNISmZ0YW93SzBjYnJFbUZVOUhmM0UzYk13NVpJRlZqY01obVpXaDlD?=
 =?utf-8?B?d2NEQWVJNDlYY0dFR2FKL0k4akpzeE5mVDZEQk1HZlMrNjl3d3o2TmlyeUFl?=
 =?utf-8?B?Q0FOWEZEVWlZSXRRL3hpa1hiRDNPWFAxcVY5SXpSamlKQzRmRTV2NlVpTUQ1?=
 =?utf-8?B?TTk4ckppWTFZVVc2c2V2Qk1tTVJ5UEp4RUt2VWpONGI0Zm0vcFVFYzgzNnhG?=
 =?utf-8?B?aktqeEdvNzVLUnpUK0xYZUM0OHhjZ1V5OWFJM3pxdDdBNjQxeGxDNjFkcSsr?=
 =?utf-8?B?SWtuY2pyc2RrVUNYYTdVRVVJSm4vQXlodXNUTytJdllzbGMzRDFJUnhTTStN?=
 =?utf-8?B?S2cyMHYyOVpCQXgvaDRMaHpaQmxoNE93TTN0eUtZVFh2R1ovZkNYVVloVGs2?=
 =?utf-8?Q?E3R82A?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkI2Q2drbTZ6U1kzOStqQ2p1aThZQXMvVmQwSXhLeDlCdEl2cDRHQklDRkJT?=
 =?utf-8?B?RXhDRS9qdG5MM1lidU1rWVVsVElZeURTT1pUNGRGOW9VSTcvV3RUR2FETCtu?=
 =?utf-8?B?S2FzU2NpKzAxWGsraUlvUUtKT0YwRUlYVGtnS2l2d3Uyc1FiQVV1UmJPWU4y?=
 =?utf-8?B?MHBVdmZXb1dQb3dEc2QvOWx6QlRnVnozbDhmcnFLeFdzTm1uV3daUlU1TTI2?=
 =?utf-8?B?QnlkMjdNbXRiSEJKdnZVWjM3WHJqYjdRb0ViZklHKzNpUUp0Z1lJUUhiSFhp?=
 =?utf-8?B?anBSTjhCaWVtWVBhU0xTWDJYcmcyT2I0em5mb0E5T0EzOFhNVEN6OGQyZFBt?=
 =?utf-8?B?VVN4TmhIVGpiZGY2WEc3N0dXRFJybDgzVk10UjRFOWVkanJiVWJaRklSaTNn?=
 =?utf-8?B?ZmhxQ1AwdlZZMktrRFJRTEJCZXJKR2Vsaml4K0p4TnVtOWJLYnVtNDFzNUMx?=
 =?utf-8?B?NnZjMzRPd3FDcS8vMkRNVFVsbE1wZ3NqRStsZzIyc2MzczRncHYvVjZSRllO?=
 =?utf-8?B?MUZ6YTRYaFFERlFPZjJRR3pYTGkwWmVSY3ZzMzMyanpRckVNYVFYNTl6OGZJ?=
 =?utf-8?B?blR0dnNQam1SanBNWlpIWHBEYy9SM0llWTVnYlRtN3Q1cUR3OHViWFAvc2Jv?=
 =?utf-8?B?Tzc5cFBIMVZXVUx3eVp5ODlYZ0Nob1pKYk5LM0RvZEVPK3FvVkxxUnJSa094?=
 =?utf-8?B?NkxTNVFLYUprclBERVg3bk9UVHNiQ1h3RVRIaVNzaWVxSm5HY0Y0ZEJqcUg4?=
 =?utf-8?B?bHFBRlM2VnExRzdaRHVzSEFPa2h0VjRaWVlzeHh0V0hSenA3UXFxZ1hBdWp4?=
 =?utf-8?B?eWFxYnlBTnNWdG05aDB4YlVpMlhYWGQxK05ZUDRBT3NRU254bFpPNE8wRncr?=
 =?utf-8?B?VVh3Z1Z0eHhLektIQXVmWTJRWVA2ZDRaNXZNY0FwUS9RSFZUMTFFV05IaFVV?=
 =?utf-8?B?QkxYV3dwb1QxY1BuUUJEQjAyam53T2JIOEtxNU9UUzYrM0lVQkFkTmdWaEZC?=
 =?utf-8?B?c1czbjJxbGpxWm9uRXhaZXAvbno4MkZLZjRCRHc0SFIxQVIvR0xtTFV4Mkhy?=
 =?utf-8?B?N2JWZm9ubzBSREEzRHlVZTJZNEkxRkFWSW1wdnYrbm81c1BGSWtIdVo5SW5i?=
 =?utf-8?B?SHNSWXErUEo3UEpUNTFocXRsQ1VMdG1DcDc1aFVSaE9rZUNRSTBhWnE2SDJO?=
 =?utf-8?B?bklLWC9abm1qc1g3WjgzUHA1MUpPZzVGWEp6SDMveDFoejFvZ0M5RjZYZDdV?=
 =?utf-8?B?TFZTUUpyS1JpRElUak53K0FFWmtVK0NITlBYUFlMWjRucW50bTUzeFcrZmxs?=
 =?utf-8?B?dVJRWkRQWlhsTkFRaVlKZjB4dStzSTl2WkJ4cVI0ODFFYXdRcm9XYlJaYXJP?=
 =?utf-8?B?bmV2djZZT1pWeGJBWGZZcm9BTHlodjJxLzZtMUpCT0RNVDF6d1VFL2Y1NnEw?=
 =?utf-8?B?OUxpSmY1RXlrUU1KQ0J5dUl2alZpUk40a0dJaGdqUXRTQ1ZjUkxNQmNXQ3A0?=
 =?utf-8?B?S1NURGJxNnEzUk1SUW9HWkxyVjFWNm1FUC90VEhaS0toSWpVMlpubjY1Q1Ev?=
 =?utf-8?B?MWdKZ3B4eTJFZXRNTS9rY2J5eXBWQjd2WlN2VTNxdFlucW9ES2F2a3ZoOER1?=
 =?utf-8?B?K1lFWTRhNkhyQThUeWQyR0U2YmxwYnZ0QzdSYmpwN3FoYlBOcHg4RWVjZ2ta?=
 =?utf-8?B?SW1LNnRndlk3ZjdnS0tndWdqYTlMSkc3M05FNjVOT1pNTWp6cGU0YUFadG1m?=
 =?utf-8?B?NHBjNW52Zk9hTE1OUlZBUjY1RGpHYnpLNDVjV1JSREJQVFJ0c09wL1JJOWV3?=
 =?utf-8?B?VkNKMUN3RXpFL3VUcDJvQTNXUFB1ck9kT05EdUgrZFVvVjFxOXVhUjFoTVRT?=
 =?utf-8?B?cit4STUvMzNYUjNaWk5kZWR6OTQ4aXNiaVlqRnRvclJJSmd0dHAwTU9hK2pS?=
 =?utf-8?B?MWNsODBDb3RMN21OMFV4SkpkRWNTTGVETktzdGt2T1JsYVNmejg2RVNBd0xa?=
 =?utf-8?B?RjhIMVN5Z3BpdDZGZmlSY3ZZR3J2c3FaUlJGaDVvS21OSk1namNHc1h2N0Js?=
 =?utf-8?B?MjkzTmYyTWpmMWdtUHFlWWVuV2xoUE5Pb3BHUmNOMGxyNU4vWFY5clNwbUNE?=
 =?utf-8?B?ZFBTTEpUcU9iVXE0aDJhVEhtc0NIUzExaVlaS05wSWdMZWFtaDNOZG03dVhp?=
 =?utf-8?Q?1u+0T0awi8yV5DBHVruuApc4WJOqq71hSd5GFSOOkkdY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 701e801a-932e-4445-bdfa-08de1e6de2c2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 02:24:03.9695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4fi4ZbOsTtxqqm55uyy+7FN6K0XUHAovTz1wAlfl+nPivN1AeV4VEPaWgQxAyTd1qtoasYYxra68Jl2bQbe1/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149

Minor revision adding the feedback received on v3.

Patch 3 adds a MAINTAINERS entry in case the Rust core team would like
us to maintain this, but please ignore it if you prefer to take it under
the core umbrella.

This series provides `Bounded`, a wrapper type for primitive integers
that guarantees that only a given number of bits are used to represent
values. This is particularly useful when working with bitfields, as the
guarantee that a given value fits within the number of assigned bits can
be enforced by the type system, saving cumbersome runtime checks, or
(worse) stripping data when bits are silently dropped.

For a basic usage, please see the rustdoc of the `Bounded` type on the
second patch.

The first use of this will be to represent bitfields in Nova register
types to guarantee that no data is ever stripped when manipulating them.
This should eventually allow the `bitfield` and `register` macros to
move out of Nova and into the kernel crate.

The last patch is just here to illustrate the use of this module; it is
not intended to be merged this cycle as it would likely result in big
merge conflicts with the drm tree.

This series applies on top of drm-rust-next for the needs of the last
patch, but the first 2 patches should apply cleanly on rust-next. A
branch with this series and its dependencies is available here:

https://github.com/Gnurou/linux/tree/b4/bounded_ints

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v4:
- Change `Unsigned` and `Signed` to be empty enums so they can never be
  instantiated (thanks Alice!).
- Add test at the limits of a `Bounded<i8, 4>` to confirm `fits_within`
  is working as expected.
- Rebase on top of drm-rust-next for Nova patch.
- Link to v3: https://lore.kernel.org/r/20251106-bounded_ints-v3-0-47104986a5c3@nvidia.com

Changes in v3:
- Rename to `Bounded` to avoid confusion with C's `_BitInt`.
- Request all common integer features on `Integer` trait and remove
  unneeded `Boundable`.
- Use `assert` instead of `build_assert` in const blocks. (thanks Alice!)
- Implement `Integer` for `u/isize` and `u/i128`.
- Support `usize`/`isize` as `Bounded` types.
- Implement arithmetic and logic ops between two `Bounded` of the same
  backing type (but not necessarily same length).
- Move addition of `num` module to its own patch.
- Add MAINTAINERS entry for `num`.
- Link to v2: https://lore.kernel.org/r/20251102-bounded_ints-v2-0-7ef0c26b1d36@nvidia.com

Changes in v2:
- Move type invariants of `BitInt` to a centralizing private
  constructor.
- Simplify `From` implementations to and from primitive types.
- Remove ability to convert between unsigned and signed types as it was
  buggy, and its utility doubtful.
- Use macro to implement `Integer` and avoid repeating code.
- Fix a few typos.
- More doctests, and split them into different paragraphs in the
  `BitInt` main doccomment.
- Fix build with Rust 1.78.
- Finish implementing relevant `core::ops` traits.
- Link to v1: https://lore.kernel.org/r/20251031-bounded_ints-v1-0-e2dbcd8fda71@nvidia.com

Changes in v1:
- Rebase on top of `drm-rust-next`.
- Rename `BoundedInt` to `BitInt` (thanks Yury!).
- Add lots of documentation.
- Use shifts to validate bounds, as it works with both unsigned and
  signed types contrary to the mask method.
- Support signed types (albeit with some bugs).
- Use `new` for the const static constructor and make it the preferred
  way to build values (thanks Alice and Joel!).
- Rename `LargerThanX` into `AtLeastX` (thanks Joel!).
- Support basic arithmetic operations (+, -, etc.) against the backing
  type.
- Add `Deref` implementation as alternative to the `get` method.
- Write correct `Default` implementation for bitfields.
- Make the new bitfield accessors `inline(always)`.
- Update bitfield documentation to the new usage.
- Link to RFC v2: https://lore.kernel.org/r/20251009-bounded_ints-v2-0-ff3d7fee3ffd@nvidia.com

Changes in RFC v2:
- Thorough implementation of `BoundedInt`.
- nova-core fully adapted to use `BoundedInt`.
- Link to RFC v1: https://lore.kernel.org/r/20251002-bounded_ints-v1-0-dd60f5804ea4@nvidia.com

---
Alexandre Courbot (4):
      rust: add num module and Integer trait
      rust: num: add Bounded integer wrapping type
      MAINTAINERS: add entry for the Rust `num` module
      [FOR REFERENCE] gpu: nova-core: use BitInt for bitfields

 MAINTAINERS                               |    8 +
 drivers/gpu/nova-core/bitfield.rs         |  366 +++++-----
 drivers/gpu/nova-core/falcon.rs           |  145 ++--
 drivers/gpu/nova-core/falcon/hal/ga102.rs |    5 +-
 drivers/gpu/nova-core/fb/hal/ga100.rs     |    9 +-
 drivers/gpu/nova-core/gpu.rs              |    9 +-
 drivers/gpu/nova-core/regs.rs             |  139 ++--
 rust/kernel/lib.rs                        |    1 +
 rust/kernel/num.rs                        |   79 +++
 rust/kernel/num/bounded.rs                | 1054 +++++++++++++++++++++++++++++
 10 files changed, 1507 insertions(+), 308 deletions(-)
---
base-commit: 80b3dc0a5a2e51fb2b8f3406f5ee20ad4a652316
change-id: 20251001-bounded_ints-1d0457d9ae26

Best regards,
-- 
Alexandre Courbot <acourbot@nvidia.com>


