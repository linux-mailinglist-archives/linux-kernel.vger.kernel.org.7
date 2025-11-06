Return-Path: <linux-kernel+bounces-887901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FD3C39564
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 08:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21B244F4F9C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 07:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750F42DEA62;
	Thu,  6 Nov 2025 07:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bwDondvT"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86D72D94A0;
	Thu,  6 Nov 2025 07:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762412891; cv=fail; b=jsLNlJCdjdpGqCAopqYGq8AhiBJg+O/7gfVQWJtR03zXoxwb8+NIHb19hXFh2oW9J/9gRF47Z2UpFxRVRdHiV9BpnyAZtEm/sbip5ubge2DYj1aE7jDfFNFzQO2voclyIAYBSokrVKVBFrcJYQk80/Rax9EPRVS+xFyvYqXr86I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762412891; c=relaxed/simple;
	bh=B1Xqd5kUtQrUrmi+itqnQ0KMkEusAr7WYN/uQjyuAzw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=k0Ax5A21NZhV2SBBRhgIizp+41HnUsxNLiWtFLx97ij1J07h6PUfr6Ina09ecsd7nPIOXbgTtqpDpVtwzF9pOTq28zBBLsY2H74ExGmyPyYmpgRyp5UiLZBWLwZCScoSNtiRz4GkrS7t2I5YPcYzoRVLpixeqZWq6CLi/DesKK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bwDondvT; arc=fail smtp.client-ip=52.101.85.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSWVbJVBIIvGgo462AeiFTP3RccOb3tf2LOasYHxy+jOjqZ7NsW4pMkxhQwuDTONiQmbOE+p/717mVjp32XsJmfTcAwhCeyOK18IMqiB8Haxk3+BwAXVCxAPLwNS2lQALFYyQ0GGkCVOIk3epdu0vPirRj0ApXTPc7wwd5szR9Zoxl6xVajuywNjmZ8mFtqDKZyskbuY7IvCy9078RDHqSxhIFyvBnKZ88BX7AazwK2amG0AJWtg+JL8JiOm0tU05ZHPp9m2MYFlSB/FmrMHk+SbgvDzPfbSlhEDKcw/Xjh4xyaHCRgdatp0Sv3OqXzXuaYytDZZpVgq1vQg29FUDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGI3i1niawvQKRPwyYPHYvw/CH7HZdb2QnrA8L6buqI=;
 b=h9QwuI4CMPfcAImCjvfzyXQA7chuuUtJ9PJlj2JFHD0ujQE/Au17lBLQLXf14v/8L6PuDUGlwiiXVxkqJrBflvZizK96vvN777nA0V8uzlz+eDznMcF5oETKdUvDklwddjINNqofSp7GrH+EktiXiDeRsGsFVXzRFmL1DKA85sJY9f1D23UUmIvNYJ76xqYxvE9gw03y9Hxj3NHcWRO1erCcKE6qGT+RgaiS1M4/cgvTN+C1MBM3/EIfBraIkYDCXYQfSYjQJlas0tte+d38C4pqlFO/uadb9SPiBZagJrk/fZSbQbR7IAuH8mOB9iUr+Xof/Yd8vwQYK4W1fyWx9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGI3i1niawvQKRPwyYPHYvw/CH7HZdb2QnrA8L6buqI=;
 b=bwDondvTIx9iQX/Svj/cmiTmbUj8CcUe5f3jYQHgVoRw+pxKvNRRpIc/0Aa12ytFx9Blr6TEvhQFajqQewtq1YGKh93oh5gtMvt6YNMOVHpoeuFgTZohfjb3ODVp6o6OT5XqWi+6fznWReNUPnHHS1IPYUK7H0OfKFHGqRISBfRiSEVkg+q47IeaeOyHGq2p7vXfKe2Gf3SDSofIbT7MDAxw+HgVeIvuqWawy2ElNw6mT/+8tudUGduOmRIHqfkhFskUTj41+vMTGf0HBH6xeHnHLaJTNY+aJMxWJCKcP+PXLGJGRcdgyCf17atEBrMP0CT/823JoGgV05OqIihojA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA5PPF7F0CA3746.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 07:08:02 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 07:08:02 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 06 Nov 2025 16:07:13 +0900
Subject: [PATCH v3 1/4] rust: add num module and Integer trait
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-bounded_ints-v3-1-47104986a5c3@nvidia.com>
References: <20251106-bounded_ints-v3-0-47104986a5c3@nvidia.com>
In-Reply-To: <20251106-bounded_ints-v3-0-47104986a5c3@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0309.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA5PPF7F0CA3746:EE_
X-MS-Office365-Filtering-Correlation-Id: a332e41b-f85a-4b92-3e0e-08de1d033977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ylp3anRjZjB6T3FGKy9qUStmc2ErdHI3cHVrdTVoSWVWUE1DUjZKRnZaUUky?=
 =?utf-8?B?anE1a0E4YVNsOWZYbEZSUEtDb1BDNDBqM2lhSTRQMGZBQWIzRmxmSGhqREZ0?=
 =?utf-8?B?WXU4cmkwQ2xyMm84RnZkeXpWM0Irb3ZXYWptZEQzclJYUmZnWWluUDJRVHZC?=
 =?utf-8?B?RHNHUld2OVdYRjhWdGU5RXZsU3RCNWFDek5iQS9DZHpzUmI3N3hsQXBuRnpU?=
 =?utf-8?B?QkFKb3lIbVdRUmdCTks4dzF3RFNoOUxKc2Y2RDREaXJZZ1N4cEhBcGZsa0hy?=
 =?utf-8?B?NmI3LzB3UmhSMkZ2Z3lWbzJRVE8wUk9CZ3Ixc1hsTmVRNmt5Qk5raTJKSWJs?=
 =?utf-8?B?dEVWQ0VMcFJrZkFUYWFqLzZwOVZqamg0RE13YUlmQmxKWHJLWWRCaW9la0lx?=
 =?utf-8?B?Y1NvQml3M090c05yZFhNbDkwOEdhS0ZzNi96Q0N2S2RqeFJaQ01wbE96dU5M?=
 =?utf-8?B?ZkNXa2VVTzRyWEJlRzdLSXl2U1FPVTN3OVkxL3JHOVp4MUdXcmwwZ2pSSTla?=
 =?utf-8?B?RlZ4MkJpbzZjNTdQUm5TMVZNZC9ESkVoWnh0RUI2QkVyQTJiQktnTlYxaUlO?=
 =?utf-8?B?eTlaZFcvT25DOFZKTWJ4N0JQRG85dUdzbUh6RytSSUcyVEZUQ1dGOTFaUzN5?=
 =?utf-8?B?Vk9FRS9nVHVOYWVmT1JaZ21sQmQyOThZb2x6SkxzOHRqUlRCNkZTLzBsOW01?=
 =?utf-8?B?RmpxcmJRMXZWc0l4dnp4aSttclhidTNBN1pKUlhoNUwzRmFxdnJpd3JIS2p2?=
 =?utf-8?B?TSttdzMvQXJzazNraGU4Z2t0d0FsMDYvVTJRTE9SM1YrRzdjbGpMdUw5TnIv?=
 =?utf-8?B?NUh6NFdFQ2VyZVZxQ1pzamw3QW8zL1VrMFp4V1UyaWUybVlBZjFzbmdSWGJN?=
 =?utf-8?B?a3N1TVg4T05uWStOSW9yRE9nelZnUk1TTmxFcFZML3M3Ymd6ZDJlWDR5RlFs?=
 =?utf-8?B?YnF0eDlnM29lUTIwYUdseHM3ZzR1Y3grVG96QjZwM3I4R1VjVGpOSWpYQTNB?=
 =?utf-8?B?cmJMMFo4S2l6dDBIMXlPTXhWaEx0aWNqUTBiMHQ0L0llMmNxZWRSUUU2ZFJV?=
 =?utf-8?B?S1lIZmJoVFpFTnQ1TWs4Q0dCOUdYL29PN3dqSEgveUYrbThJYXN1VEZETWo3?=
 =?utf-8?B?SEpLSm9YWEJlMlhGcjN2cGpXcnBwNVIwV0hJckF2TXhPUHJXdVVOakxoUU1M?=
 =?utf-8?B?cTBUeHh5RFV2S3ZzbTZDLzlnRmpJVGpqakljVHp5LzE4b05VM3R3UTZ1cW5F?=
 =?utf-8?B?ZTdiUTBxL1F1ZmVJM2JGanl6aTdDOVlrK1I5aXVWRVhjM0duajJaTStQY3hy?=
 =?utf-8?B?V3VvRGU2Tm1mMStvaTV1WTl3YjJtTGpxbnZYRk94Nyt4Z1Q0WG5ieEJJWXBr?=
 =?utf-8?B?OXRoUFJJaElOYm1nS0J4SHk2VjNyM3VWWHFkdjZmUVRxRmgveHZ3V2xkd0FJ?=
 =?utf-8?B?ZVlOZER4eHZLQzROUXNkTEdJQ2VkcXFyN0NLV091LzA1cUQyaDFaaDRjdXAx?=
 =?utf-8?B?WGdhYXAxMVFHSDM2aGNzUGZwNjFUK1Q3c01HeWVCNy96d3RGK0FKZGhhUEtJ?=
 =?utf-8?B?dTFwdXFwYk9uWVFRRGFsLzl4cXJmNFlGa3I2T05kL20wdHZ1NEZTMWlJNnpX?=
 =?utf-8?B?MU9CT0c2Y3RsRjBkazZBb2tJeGJPaWhGVE1tMGRLVVpobEVVNnBOMW5kbmxx?=
 =?utf-8?B?SXllQnBwNDFYMnpZK3NCQVBBWUphc1RwNUdsTEovTkJpcFpzS3MrSU9MR09C?=
 =?utf-8?B?SEhxaU1UcEVGNkhCTXIvTnhSbXdyREVkaG41K1hOUjh5empmdGd6TVRmZjdC?=
 =?utf-8?B?dC9TamVDQjRUYzdYcmpFRTZZUnp3LzdDTGxZV2JvTzY2NUVLaGRxQzNnN0RV?=
 =?utf-8?B?T0dHRElEaWlvbnQ2MmFmVms2OVE3UXBYaUpaYmxTbHRmZ2VhQ2pUSmdJSktk?=
 =?utf-8?B?Lzl0cnlzYWlKbGxLcVNaSFNTTEx0T2JYcGJ1K2RidlJLWlJ1WWpLT2lLZWZo?=
 =?utf-8?Q?7KD00hWknP0ijuNpazzrZhMmqaTwYc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3NkTEdZeU9xaGQvTTQxbkU1RFJUQzNXSnhydnI3Rk5aeWxOU3NjMkZkWndQ?=
 =?utf-8?B?VmVabmtwNlVQcFVHUmMvVkJySzBYUkR4d29ocFJYdWJKNDQrWE5KcVVuNm1l?=
 =?utf-8?B?TGtKb29HTy9obUg4Tk83R0RHS2ZSR2JzMjNvQ21pWGhLOGhFWjJoODh4OS9S?=
 =?utf-8?B?QmhXVzlrRWVHSFR3YUpITEduQ25xK2ZyeEJKcnFObm5VamF6OFhTVGdyMzlU?=
 =?utf-8?B?eXdDMlR5K0JlaEdlSU81eTBXTU1jSkVCUXNJZy9rUlp3NS9mTXNsbG5oSy8x?=
 =?utf-8?B?SGZCZ2VOTC8zaS9Xd2RzYk5FaFBxOHdnaXhPWHZwaFp1cVQrOVQzQmluSDhC?=
 =?utf-8?B?Qng5cUF4RVlQaVA5L01WRVdWcXhoTWpaeVhkNTgxcWYxV0IxalM0NGZHWStH?=
 =?utf-8?B?d3AxdFBDSjdwSG9BQjdzVkhtSVRscjBDRE8zSHNnSFlTSXdOeTg3TlFRd2Zw?=
 =?utf-8?B?WVdTYkZBMnhUUjhRSEJDeU5jQ3QzWktraFg1dEZzRjRtUmF0anc5a0o2dG1h?=
 =?utf-8?B?K2NYYlEzUGd0QTRrRjd4OGpwMFMrMk8zS1BxM051YWtXSWVKWjlrNVc0a0hI?=
 =?utf-8?B?QkN4K3QyMFpRczErakJudVFVbnRSWW1lUmQzOXREeU92aHR1RXpKdHRzYi9S?=
 =?utf-8?B?WWlhMG9JSUpLS2V3MUQrV1NiRnByN1RGMlV3eUZ1cHlYWmdnV2NmTnhQaVpB?=
 =?utf-8?B?bzRTRFNvd24xcVczeUkySjUvUEU4R2daT3hIYjNlVm1OVmVkWDIvYkdaVGlT?=
 =?utf-8?B?QUE2REFvTzdKOGtUVlVtTlpEY1NxUE9qVFVFeTA0N2hvZFJjZTE3bk85Qk1u?=
 =?utf-8?B?THhLeTczQzVjalE3ZjBFNnZtREJJL3BhaVFYYXpoTWJVMkg0S0MrT2orY1Bl?=
 =?utf-8?B?alZ2dHZ5eElaOUJHdG1ybGxISkJ2eVhYbXRscEFldXZzZ0hwb2twRDU2Zk9D?=
 =?utf-8?B?bUhkNWE2bzFkTVgwVjNoM2xicU14YWY2TXRSRUp1bHgxUVF2SUFUS1Y0K001?=
 =?utf-8?B?SXZYc3c5b0lVcjROZ3FLdjc4dzNHTHlJc3M0NDd6RitncVJkL0lXUTgrRmFU?=
 =?utf-8?B?QkszMkJSYW1HMklaTENrQUtCNU1Zd0RVWTFBQXlranlGZ1ArRE1ha0NFaFFr?=
 =?utf-8?B?VWdXV0d1QzB6Vi8xczYrZDJObStQVW9IUEI0bTdKYnJ5Tk8ray9JcnJRcS9o?=
 =?utf-8?B?QWJuTklQYUFmanVTMzFSMVBTVzE1UFdNMkY0MS91cGE0VVZJZUtIcVcyL2lI?=
 =?utf-8?B?YU5BSkJWS09lQUZ6T0VaZVR5ZCtTbFYxb09JeG9RRitsWGpCd2NYQ0UzUU0v?=
 =?utf-8?B?VDdYZW45UytrdDBCUFRLOVZzNjI3b3pZUVU5REJWUE05bFlRd1FwSUNycy9R?=
 =?utf-8?B?WjFZTElpdTQ1cFVHS1U2ZjE4cGFGWmxNT1dXd1hvRXFPUzIrQXh5amtuWDY2?=
 =?utf-8?B?QVJyeld3dmJCeDFCbi80NUZ1S2ZsZUlTdmN1T2lpS0JnQ0prbU0yMUpMMVJH?=
 =?utf-8?B?Q21TOTA0NHBWZGZsOW92b2w3N1MrZlYvbmhSVkcvT2dFWkZGYlI4Z0RhaWFS?=
 =?utf-8?B?cndybWJxbk4rZSsyaS80TWgvY3l1T2ZHbFZXVGhJZjBhWG9iOGRYYmc2VC93?=
 =?utf-8?B?ZTVSOEI1Y1crZHlUeE1CcDhidnA1Yk8yb2w0Vk9xbzNRSWpsMmF5czRKeWxl?=
 =?utf-8?B?c09YMk0vd2hXMVpOVnhpeGRJc2Vra09zamRxaWEvRFpRbHJ5RDQ2OWVkeHV0?=
 =?utf-8?B?cXcxMDc1L3E3a3NuNERqZXdMU2djWlo3Z0Y0NGZaTnFPREsxd2JGVnlra3o5?=
 =?utf-8?B?MHdLTU1peHg5Sm1aV09rbS9LQUp5WVluMzV2QXZJSHA1bWtJUTAzTTJmeHJK?=
 =?utf-8?B?UG1wL0tpbjJsd2NjQnVSZTBPSFc3OXZNaVdTWWFRaGVwaHE0MlkzQ09VSHZw?=
 =?utf-8?B?dHA5Z0djYXN4czFGMHowWXN5bjV0YmJJQ0xmM3N2TGdBdEN3SC93aXl3ZU94?=
 =?utf-8?B?ZEtHQ2VDRG04VXVCTUxXQWdHTE9HTVN0bXdYSDlIcnA4VWFHa0k2bTIzMlVE?=
 =?utf-8?B?UjREejlLV0dyckR3Zk1VTmtzTGkwbFU5WWIxVlJRV281bEZQa3lLazhYNFhU?=
 =?utf-8?B?MVFQdGNVQ2RaRkFEZDZWZGY2OTg2L3c1d20vTmd1dXlEeHBSQ1gyZUpZcDdu?=
 =?utf-8?Q?e6TP3CtJGtsKP5eGIanYtsqglOA1vUCHWmr29mZhGPlE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a332e41b-f85a-4b92-3e0e-08de1d033977
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 07:08:02.1088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /gz9by4AHtJV7WT85//hdU20YZjm1LtgWdOcwAd1zF5ddygm6PDRw2mj37OJzrOBAK9waqQcZ8JHerv8X85Mfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF7F0CA3746

Introduce the `num` module, which will provide numerical extensions and
utilities for the kernel.

For now, introduce the `Integer` trait, which is implemented for all
primitive integer types to provides their core properties to generic
code.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/lib.rs |  1 +
 rust/kernel/num.rs | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 3dd7bebe7888..235d0d8b1eff 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -109,6 +109,7 @@
 pub mod mm;
 #[cfg(CONFIG_NET)]
 pub mod net;
+pub mod num;
 pub mod of;
 #[cfg(CONFIG_PM_OPP)]
 pub mod opp;
diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
new file mode 100644
index 000000000000..3f85e50b8632
--- /dev/null
+++ b/rust/kernel/num.rs
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Additional numerical features for the kernel.
+
+use core::ops;
+
+/// Designates unsigned primitive types.
+pub struct Unsigned(());
+
+/// Designates signed primitive types.
+pub struct Signed(());
+
+/// Describes core properties of integer types.
+pub trait Integer:
+    Sized
+    + Copy
+    + Clone
+    + PartialEq
+    + Eq
+    + PartialOrd
+    + Ord
+    + ops::Add<Output = Self>
+    + ops::AddAssign
+    + ops::Sub<Output = Self>
+    + ops::SubAssign
+    + ops::Mul<Output = Self>
+    + ops::MulAssign
+    + ops::Div<Output = Self>
+    + ops::DivAssign
+    + ops::Rem<Output = Self>
+    + ops::RemAssign
+    + ops::BitAnd<Output = Self>
+    + ops::BitAndAssign
+    + ops::BitOr<Output = Self>
+    + ops::BitOrAssign
+    + ops::BitXor<Output = Self>
+    + ops::BitXorAssign
+    + ops::Shl<u32, Output = Self>
+    + ops::ShlAssign<u32>
+    + ops::Shr<u32, Output = Self>
+    + ops::ShrAssign<u32>
+    + ops::Not
+{
+    /// Whether this type is [`Signed`] or [`Unsigned`].
+    type Signedness;
+
+    /// Number of bits used for value representation.
+    const BITS: u32;
+}
+
+macro_rules! impl_integer {
+    ($($type:ty: $signedness:ty), *) => {
+        $(
+        impl Integer for $type {
+            type Signedness = $signedness;
+
+            const BITS: u32 = <$type>::BITS;
+        }
+        )*
+    };
+}
+
+impl_integer!(
+    u8: Unsigned,
+    u16: Unsigned,
+    u32: Unsigned,
+    u64: Unsigned,
+    u128: Unsigned,
+    usize: Unsigned,
+    i8: Signed,
+    i16: Signed,
+    i32: Signed,
+    i64: Signed,
+    i128: Signed,
+    isize: Signed
+);

-- 
2.51.2


