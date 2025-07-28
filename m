Return-Path: <linux-kernel+bounces-747964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6E4B13ABE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37BD93B4269
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9BC267386;
	Mon, 28 Jul 2025 12:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HVnxY9G5"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2092A266573;
	Mon, 28 Jul 2025 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753706886; cv=fail; b=TZlxbrjUjT5xO/5iOY0rw/zrMZJdgLUhbbJQAQgOK0h6Unw5KOlpaiQrYXfjxCLZqRV06sRwRDEWRmwwt3fAn8xAUKIEYmEnHj0braRkROuVer61fMaElgplYfL9P9VdMSuIkqu+MWci2EBDvO31uc/OIPomztZt/dTsCHNJCh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753706886; c=relaxed/simple;
	bh=Ns0bO2OCYLjgNPbR3FBLi0kbV7SHMPyQrwKL548GMGE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rncf1SnN4bnz9AKoz23EvnAmWAjYMY++H8+7sB0Rs2GmtB/p5lWpiqAxPwVsHImP5k/aDV5tefQlQ2G5sye/I/K/QpVd/sGAcOcmmQLGpnrMz9ilHB9HgYWs3wmGOxkwJuVGsmOneSr766CllCTRvjl9MvjcmmPsM7PU6Vd4a7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HVnxY9G5; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxdALQSSPOxYlBjQrbJgWI/J4cRZPF5JmkSDYv5QA4HV+zTGelvaXJCqvwvpVDyYJPG2AhxvSJ/EQsna4vBNNu5xUkepjU+LBlJ9QWRmvd/9As4XEI8Cbj+puPLqMHkSssFQkNmggGd6DZk7jmXtjfXyd1MtH/Pjn3H9lGvUh3sg2uR+BFALQgrfCI+RSqFAdNGmtxlMlbNTkzWya+C9Ztw0zFTCs7JgVBKO626rsrpjYu86PQO6xTGqQEx7uMSMMEjNtEofNkhNbEMlGQmjERHWO+e8+Hhr+QEEITceIiesV/VY90l7/6V9uwNxIZ08uvevNdD+Bow07MteOPyoPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVRXRIGbdU18kk+nZLy8Vu4ziSJUQ+d78b4S9SWxeGQ=;
 b=UDaYBmWdJcHdpzrA8DzT3aAJHRAnjPmow7ujK7PoeLqlPxt99InFJE9VmUvvKDPuHvuJpwbZAnFj1ZFUuBVQpPosIeTdQ3UH/0SOHH7tEeLi0lJPKUUVKYsfOgd5lC3ELCHFlBocuGbtQ+ytOpw2ECVR4xsZY8yXhJIsqeBh1oJbRDn4Skyw724ohV2i/koBg8AqAKbU14Ja5VTZfwOLk5C7K0QfhW9qEFHL5hb95o24klrxi8LI8eS08rAcruNdbDehGHqI+fsZqUK5XaU0SUCdsXKulRhRlJogNqvqzeU0Bxashn1ApgtjMRjOWy8jcEhjOzR2QhG7cpAJKr21Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVRXRIGbdU18kk+nZLy8Vu4ziSJUQ+d78b4S9SWxeGQ=;
 b=HVnxY9G5nvzR82dRBT4TAixYoxLo8K/qQnjmmnQcsVqClMK2q4Pt45AUiVCt6/fa8P5aFim0MrciG8t1RdtwAkrhzmXWIPfgUMzR5R7Lqo1RNsp2bdB6sWGll8qCoefZJoHeUye/Xvgl54VwJ5rlmokpgK8FmujlIn+H4cVdmNC0yl0WNScYp4DUMJ5o3c/9noABIjEfnU75xA/MP5nU6MCsL59t1bzr4XmSBO8NZsudxMSF4pS0AQiwtB0omOY3DOxYlBFZSCGGewFJJwcjvmZ3rScAcB6T9GzOMNt0ZSCa6GTAIicD0VhGfE8kPCIEF6jZ6AVyiod9+VF1p4gDyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ2PR12MB8848.namprd12.prod.outlook.com (2603:10b6:a03:537::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 12:48:02 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8964.026; Mon, 28 Jul 2025
 12:48:02 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 28 Jul 2025 21:47:51 +0900
Subject: [PATCH v4 1/2] rust: transmute: add `as_bytes` method for
 `AsBytes` trait
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-as_bytes-v4-1-b9156af37e33@nvidia.com>
References: <20250728-as_bytes-v4-0-b9156af37e33@nvidia.com>
In-Reply-To: <20250728-as_bytes-v4-0-b9156af37e33@nvidia.com>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: "Christian S. Lima" <christiansantoslima21@gmail.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: TYCP286CA0290.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::7) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ2PR12MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: 7845457f-7500-43a7-a1c4-08ddcdd4fcd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUpyMmhtaWhsNXhFUkdIZmRCUGgrdzdJNXpNOG12b0hpbjBJM1ExNDNydHM4?=
 =?utf-8?B?NG40SkN0T215K0MwT1R1Z0xsQ0xFL1NLUE9sTThlU2doc1ZjcHMrN0RuM2FL?=
 =?utf-8?B?alJ5MWUwd3Q2eGg2ZXUycmNyN1Z6YkRwdGV4Tk1xNng0ZXlZMXJUOFJXT0Yv?=
 =?utf-8?B?Yk8zWGo0L0NvZHRjZ0ZMcFZnVzNOcnZESGhXRGNENzlSSERUL2ZlS1VvaENX?=
 =?utf-8?B?SjlxMHBucytFVkR3aXpib0JBbUthWEFvc2JOalF1WjhQYk9Qa21DNzYxc3VL?=
 =?utf-8?B?Nk1BQ243a3BiY1IrUXo2NE53Z3RDU0s2Z040YU9jQzdRYWkybG1ZRXJFY3Ft?=
 =?utf-8?B?aGpRUlAxY0dpOW9OWDRWNmRKTE1oaDk1T21qbTQwQ25ScnZUTGF0LzZuM3dE?=
 =?utf-8?B?enJHbGlucVo5eUxOV3pPYlUrZExYdWJIZVpDclJGZWNPeDJBaHRnaEdrRHlM?=
 =?utf-8?B?ejZIdHdaVk1qWUluRUlIcEVtcXJ6UHAwSjJ3eW9GdzFQOG42SEZNamlXaGhW?=
 =?utf-8?B?Njc3SXRwRG1ra0RXZ2o5QlMxQStkVkt0aWJYYWwyOS9ncjZ0SHpKbmlMVGNh?=
 =?utf-8?B?dXIraGRzTXVRd3pSaDduS3NLMlllcFo5L3VMYVpwNUU5SDZ2WkRUZzl3VWJS?=
 =?utf-8?B?c29aUWlPMU9lMm1KdlUra0Iyc1pMeko3VlhKYkhOek9VR1hLWXptalkzcU9n?=
 =?utf-8?B?b0JsV3ZYVk1lZnhJaE1IQmlzU3grdXVyQWtBYWRHQ3dsSlNBYnludHp0YTNW?=
 =?utf-8?B?bEVjaHVudm1Ya1NPVFR6Zy92ZDAyRlZubDRsT2R2cHRSNVV4TWN6ZG54cTFR?=
 =?utf-8?B?T0hSZ0c0VlVEUjRrYUpJMmJUT1VIT1U5blV1S1BQeTBxRFlGQjhuNlEyVlhF?=
 =?utf-8?B?Z1MxWll2a0o2VzlnRUlJSGlaRkdTazJIM1NRMzZRNSsvdURxL000Y1ZYK2M2?=
 =?utf-8?B?L0dRcGdNc014ZmYrMHhiVFNXRm1MamVQVElYRWw2U2d6ZHhpekJZR2NKQUta?=
 =?utf-8?B?aG80R2pVOVgzdkJhN2djZnNpejVGS2d4K01XelVZTmNiQjZZd3l1Vm4wd0RY?=
 =?utf-8?B?ZmhTUGNCK2phS2JYT3pmaXFERmQ5SlVUcTRORGlkNlZsckthNDczNTJLS2o0?=
 =?utf-8?B?ZVZpR0ViQ3kxQWdTSnM3anFrbFJUL243aEduUlQ2dGtHa3o1cnU2enZybXlm?=
 =?utf-8?B?S3F2M2k3TzhHUUtHOFVvUW9aNzZtZjVFQmtVQlk0M0lpY09xRkJHeVU0ZVJ5?=
 =?utf-8?B?OVFpbmV1Zkxpa25neGlMb0xYZThMU0FGWGVNODFLbHVON2dneC90R1lIYUh2?=
 =?utf-8?B?Y0FvcmNYUitadlNldHVSZ3VqYlI4QlF5VTlKZzl3TjFYVGY0Rkxkci9Wc0ho?=
 =?utf-8?B?ek5kRCtYZkVmS2hqUjYrRVljNndPU2RpTzU1TTY4bnZPZTJUb0xLMFVMeVNR?=
 =?utf-8?B?ZkRBclF1NzhMUmhVNUpvWTdPZzJzY0pCSGswbTZGR3BsZFNJWDE4TVlMOG5x?=
 =?utf-8?B?a0pWbWtEYzRwS3dKK210VXJzaVYxbGFCNmZyVWJMQzlhV2Q0dVRpQnhBZWJm?=
 =?utf-8?B?QTVtdkt5bStUZHlmbFk1UXdZYW9IQU1idlJqMkdnekM0YTRpamt6YnlQUk0v?=
 =?utf-8?B?Y1k5bXptbUp4SDRDVkFUalBVYzFKbDlYakJDbzhCYmFhRmI2QnVuQm9hNjg5?=
 =?utf-8?B?cmdRUEdWaDZTbWRzOHI0bGZVbVJ4SHlDcGNwaEVvTExYUjBMaFBJUjZ2ZGgv?=
 =?utf-8?B?N2VWVTNCMkVMV1pYTy9tazFqVzk0UHBCTFpVWTJKblBRRHpWaUJPU2VOSEk5?=
 =?utf-8?B?T1c1Qk1CUmgvWkY5Sng4aTVpRnlOVkFWRGNFQWYyVFZycnhZZm9oNzlwMWFQ?=
 =?utf-8?B?M0xEeGtFOTlGNENjZEtsQ3A5TCsyOXFvSnJqWjFXTEpoSDFPaVpaOTZvMTBM?=
 =?utf-8?B?Z2pRRGMyL3NyUVYrTzlRYTBNUkhyRTdHOUZkRVRnM2JWSUU2ZkFtdWNnUTNY?=
 =?utf-8?B?TkJYWFZRM0hnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0ZuRHVndnR5QVh3NkVFRHh5UHJYR2VDN01CUGRtMXRGZGRQbDN3ekc5R21Z?=
 =?utf-8?B?UGtCVUFwVWJtWnRJK0lhbko4ZERZaHhoYXBTMmk3dEgzTWFRNUdhT3JVbzA2?=
 =?utf-8?B?T2laSGc3QnNzMUFVN0pDeFprVFR2TkFXSE53clRHbU45QnlNQ0F3cWVVSlZ2?=
 =?utf-8?B?L2F5OFd6ZDAwMVZFaHdiZGVyUmhrM1k3RzFMM3NDdWFVV3NaT3Ntd1p0UXhs?=
 =?utf-8?B?dE9BaXZsL3NUZkE3R0xqZTRsdHZLTWRBemVSRkdsVWllMVhjdjgrTm52OTNy?=
 =?utf-8?B?UVhoUm5Kc1d6Z2wrTkdIaWp4WUNzSlh1Rk9XTTl6YWUrRkxXdFJ4QlZEdGFt?=
 =?utf-8?B?YzZLdC9IeUJWc2NwMFJ5UlFJbnBvVkRHTlgyb3ZqLzM5RHpyK21ndWFnUGRI?=
 =?utf-8?B?ZE9SVjNVWC9GNkZEaFBSRTY5K3hYRVUrck9XY2tVMkpEbU9TU0FnKzQzOGQ2?=
 =?utf-8?B?WVYxMTJDaGl2YmlBMTZ5c1d4YnhBaWhDSUVhZVFudFdMK3hqWDBidDJpQlJL?=
 =?utf-8?B?N0tnMHgrN0lLOXJQMlB1VUFVMjhqbFkrMU4xRUtNUFgvZVZrZWFtN3VvSTRr?=
 =?utf-8?B?U1lrZzFkdUxjWlJvMHdLcm0xVnhvZmErSkVBdTJhRXRjWC9wcVNGeEUwYXV5?=
 =?utf-8?B?R0FxdjBQQW44N3FIVUpqUkV3OWZodTBkdGt1NHRVaVpCc3VRcU02U0VjK3hn?=
 =?utf-8?B?QVhYZUtFUTVsR2VVMlZqcWdLY1FlVDdGM0NvaUdma0ZySzRGYmUwN01YdHV1?=
 =?utf-8?B?ZTBDU3Y5R0FMTXkzUE1Rck5aT1VZL25mbU5uMUlDWU5LT1UvL1FuSzBWdTJy?=
 =?utf-8?B?ZnNBR09GeHdhT3VJUnNlQmkxVzc3UEFVZGhtR0U0ejNrSW1oUWQ2SG1HTjdq?=
 =?utf-8?B?S2NCSFdhOUtEanNvaUE0U09wdHNxS1htYXpyamhpYW5jUXZzUWtEbzVhcmtS?=
 =?utf-8?B?MnllWGxZVkhJUkV3QzRaSkJFclF0YVVmeUtkNDFRdEVKMWxHOHF6QXppS2Nx?=
 =?utf-8?B?VFVXV2ZQRnpmNmEwNEI4dEM3NDZDQzdnNUlHTXoxMEFLZnprcEMxUHhLaEs4?=
 =?utf-8?B?NytUSk1BVTcybmh3bDhtYUcyM0lpQmtCY3hCbUlHNnY5Q1puZmdZbDBXc2Rk?=
 =?utf-8?B?OTd2TFVMQkZQR2dWRlhyU0Jldm0vVmxJekJka0huY3FhUHRUVEt3V3lXcGlI?=
 =?utf-8?B?aFFSY040ZHo2L0ViOVZBWWxHWTcyNGhqMU9qSUtPTy9FeDFzbmJSVnhXYWlM?=
 =?utf-8?B?dWdxTWF1d2ExVk45QkFJVzdkT2JmeTRHdVlVM1ZVdm8rd0tzdWszQ2NUV09N?=
 =?utf-8?B?WWcxZWgzMlllSnlScDlVay9OWXpIdWNqZHMwVWtrQnlaekJyM3ltNmd4aGlH?=
 =?utf-8?B?QzNTaWxHaDZGSC8vbS9xR3lhZjRWRWJDZXdxeExtRmZJRnExaUY0ckRRVUFU?=
 =?utf-8?B?RGNQWG82VVJmTll0Um1iSkJwdktLckRGZTdoQ2EzaFExc01lZVZIbTlLZ1lP?=
 =?utf-8?B?L2FYQ0Y0NlZoeFdOVjRJQ3Bqak5xRlB4VXNxclErR1hoN2dDdVV0TzNKamlq?=
 =?utf-8?B?a2NOY0RrbHBmQi9wTDd5ckJIY0xTbnVpbDAxRXQ2VWZ6Z0x3MzZVclJIQTU1?=
 =?utf-8?B?YTJBL1dQd3NsQzRQOFJUSnIyNlBQdjdIWVhEQ29OemJJdjVHMjZuVmlKc2NM?=
 =?utf-8?B?cWt3UmpvQmJkQ3Nlb203czZMb3NNNGlRL3BkamlYQkdJYlRXVUkvMWFIQ0k5?=
 =?utf-8?B?TVg1NzFkWGYwaGp1aFd1eXB4VUk2c09zcW5uLytGRmtIdndkVU8zWmZWL0N2?=
 =?utf-8?B?NDA0Nll0RVJOM2ZIa0x4aUw5d2hKMFBodXlpYUVvOU45V0RZQmdsYlpyYWlP?=
 =?utf-8?B?T1JzQktONDRLMTBHbVNlbVI1QWNLSnpsYzhqdUdqVlVWRGpwSVpXZ0ZXdUQ5?=
 =?utf-8?B?U0lwWXZjeXVpK3ZOdi9rcERvYitZeEErSnE0L3ZPOVZrUzdXN1FTL3FJYU0x?=
 =?utf-8?B?SUwrVVoveEp5U0x3azVwQWE0VXp3WVVNTnRjKys2QmlIOUJYVk85OWV4TmxH?=
 =?utf-8?B?eWxncmV0QWthS01aTzRvQ296MzQrclNST3JYMVIzVDFzOGxEaFpSeUQyV2tY?=
 =?utf-8?B?WkdoZW85WGNWVU14ZkN2dWRFbHk3QXNlNHRoQTZXMFdNM3dRS0N6M3Fjcm1k?=
 =?utf-8?Q?8+r53DOOiEjR/KR3fsHe1HJxpsQD0c8AOzYoPyvCKRd0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7845457f-7500-43a7-a1c4-08ddcdd4fcd1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 12:48:02.1913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VW3d5negqHVuZSeQ3+G6goZ8bcEPzMXgnK6yN9J3VHUXZtq/OAhcbp0JPJ5XuBFz68JMaJ/GHhtOfwHckaqG4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8848

Every type that implements `AsBytes` should be able to provide its byte
representation. Introduce the `as_bytes` method that returns the
implementer as a stream of bytes, and provide a default implementation
that should be suitable for any type that satisfies `AsBytes`'s safety
requirements.

Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/transmute.rs | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
index 1c7d43771a37b90150de86699f114a2ffb84db91..d541c9960904d8c7f755351f22d06e4e8dbd546a 100644
--- a/rust/kernel/transmute.rs
+++ b/rust/kernel/transmute.rs
@@ -47,7 +47,16 @@ macro_rules! impl_frombytes {
 ///
 /// Values of this type may not contain any uninitialized bytes. This type must not have interior
 /// mutability.
-pub unsafe trait AsBytes {}
+pub unsafe trait AsBytes {
+    /// Returns `self` as a slice of bytes.
+    fn as_bytes(&self) -> &[u8] {
+        let data = core::ptr::from_ref(self).cast::<u8>();
+        let len = size_of_val(self);
+
+        // SAFETY: `data` is non-null and valid for reads over `len * sizeof::<u8>()` bytes.
+        unsafe { core::slice::from_raw_parts(data, len) }
+    }
+}
 
 macro_rules! impl_asbytes {
     ($($({$($generics:tt)*})? $t:ty, )*) => {

-- 
2.50.1


