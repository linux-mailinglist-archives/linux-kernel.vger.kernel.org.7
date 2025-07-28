Return-Path: <linux-kernel+bounces-747963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AB7B13ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B7EA17C97C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD98265CCF;
	Mon, 28 Jul 2025 12:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cAu9aTFo"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B482C13D51E;
	Mon, 28 Jul 2025 12:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753706882; cv=fail; b=TkNSMM3ErgMWCZLHuIbXaJog5pmXRWDn0vfxrN5geBsxGMnrLUQIZkhBnajFs2j4EBhtuHx1U0pRyMIpngL58wJvm3coCQJDfDjG3Xypvthu+jh3R7v/Q7wqtCRwH3V6fsPxt8LEWe5CyWUgoducPhP2pWsnGIOal95F8WMuMx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753706882; c=relaxed/simple;
	bh=+ZRKpVFFLg/jmb2USslx0C6+R8F0+s7TpB2T0Y4eQZU=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=RDjbCqwGnqBJz5raVCvy6KRvyFr71OKfaosuDgEpEqFWwBn84rMGBZVtyS+IY3pjWvcHhpSHEgveAzDR/oa/5ao3KU5FkxceKG8kvSaXnpkgmOr4Y4ap8JgngacgkQgICekn8yLmK/2cI+j01hxDq4gRAcd9kd8JQmtIxwdQ91E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cAu9aTFo; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPxfFQ2wfWVuHbLvrgTP45rJCUkUxTl7j5JO2zDj9QxCmFRN//GFzU19RnJ14HSkFQXSirdCAA9NBt+WwsYMVnqtjbSyOe0aYILgDedbGLckNVndORUPOadCQHHtGCsoGsy/deySajZPSwD8wYgQFRWM6JdQtdVZJGcoUq+vKnXoLtH9PCNZ2ZUbQuB0KFc1vFVdE4987vw3CfErUp8wFVRHQZ+BoC9f8r3hM6lzAXIOqmESlxP1uW+SFg5TfTYkq1wFzm0Tu/yrc4JHb5fDHavOULgd71RcCAit8UT3n4ujZ99j/mRDefjZgKLswWxSztAPTSRj4Rj5D084F8Ay2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmfmEl6lZUB8wOynxr8psgNH5bmjpE7UjmBuqG3cMHE=;
 b=b3ZPJySu4bdGXGOzWyonQbgq/wNF3Ep6xEO6HuPXzVPnpeZwoh228hniklTctGtpO3rONWCe2kLiUSjCI3TYxxY+3upHFnIkzQUW6QqRGdLwCVAsHn/EQZn8HH16U6qqxAzqwMo0SwqhsWN0+B+IDsSZNdsIVOFcIaUXC+LazSvQd8y//Ajpre235T3Y23TONgcPCjZySpjWVT5A5G924nGCz2agElbGoXXUg54LPPSyYw1NZxhBdHHzjZph4r09LXEQ9asY9r68YK8TsoWZv0Rl7LWMl5dQWn62fF8CPThgGs1B/g2ov00lEmEL/cy4hCWSnNOfkdjFYLrKB7drxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmfmEl6lZUB8wOynxr8psgNH5bmjpE7UjmBuqG3cMHE=;
 b=cAu9aTFoOiqsWH2nYaK/515NL4ytyHN5NqBFmpnplyVF3Noa+FqiYjCf8LqzYWpZu4u1d0AbKKdP/znrWkcAUoOvSw7iUD3U5j9xmfUyBUIbhnknZKK/vnWvaRjlkQ7exGeFn1MBMwT2eyzpZRhM79uUGHlFq+DbHDjVXVlFy+ANMfh41kTPIJdWmxrkecQtZaM9KbN2tAav9P4uKH7QIB0rsT0kEnmcD6syGZWhbVpYPZOlBzVtbyr3fkz4kEdL7pxob7ss/wERwTjReUw3vAA34Mr2EMAIhtsVu7WizNsV2B2JpVRZoXJ++vQwn/gi5A0RqZxsCKXLZGUTFZu2MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ2PR12MB8848.namprd12.prod.outlook.com (2603:10b6:a03:537::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 12:47:58 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8964.026; Mon, 28 Jul 2025
 12:47:57 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v4 0/2] rust: transmute: add `as_bytes(_mut)` methods for
 `AsBytes` trait
Date: Mon, 28 Jul 2025 21:47:50 +0900
Message-Id: <20250728-as_bytes-v4-0-b9156af37e33@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHZxh2gC/3XMQQ6CMBCF4auYrq1hpqWgK+9hjGlLK7MQTEsaC
 eHuFlYYdfkm8/0Tiy6Qi+y0m1hwiSL1XR5yv2O21d3dcWryZlhgWVRYch1vZhxc5MoaC+DR1Va
 w/P4MztNrTV2uebcUhz6MaznBcv0RScCBK18oLSopvTqeu0QN6YPtH2ypJPwnMUurylpaBNDKf
 kmxlWojRZbOVCVIr7XB+kPO8/wGkiucmhUBAAA=
X-Change-ID: 20250725-as_bytes-6cbc11f2e8c3
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
X-ClientProxiedBy: TYCP286CA0209.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ2PR12MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: b01f9cdf-ae75-4f28-ff5a-08ddcdd4fa2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THZEVmhtNTQyNlVtdTZ0d25xV29wRDhBTUpWSVhLSmtDeXpzQXZ5V0JaNjVE?=
 =?utf-8?B?SzNHL0RwSndFay8vQzZOWWtKTmtENzdDYjBUcWxDbkkzL1RqVEg5YlFZK096?=
 =?utf-8?B?L0xObStUOXVtSkxRZFNvNjNrbXJLTFJVajRhVUU5TzFiUzJiQk8wV253eTN3?=
 =?utf-8?B?bjJqWitvRHo5aGFYYU1Cc2JCWDBXcWFPSm1hMmtiZXFtQWNHbmpqNFYrS1Ux?=
 =?utf-8?B?VTUzQmhZdEJBL1puOWxQVHZYcDNmYmFuUm1VVHlWWVFVR1AxODJLeVUvdzlI?=
 =?utf-8?B?R0EvNWpuZEtQMXlIU1NwZ3BGVGZHYTRqUVJMUmV6ZTREQWJDQTZWSEkxbkxs?=
 =?utf-8?B?UEwxT2luLzZESk9WMkZ3Vjg2Z3ZXUkNQTHY0d2lDcWE2YmMyb0d3VkhiYkFG?=
 =?utf-8?B?akZVVG5TdElOblAveDl0MEx0UGF1aFNzdi9zci96UU9pYWR5WVZZb0NWMlpu?=
 =?utf-8?B?WTVOaXhFQVhtUDVuLzlRYitFeEFiaFBRTm9YdlhtSVJrR0RXWkdBTXdjeUcz?=
 =?utf-8?B?MkwwTlViR1JueXFMUy9YWEVETC9KUVdMZGUvSmJacTFKa3NaZ3ovdWdTNDZZ?=
 =?utf-8?B?SXlCc2szN0dGYnhGM1pZYk5pN01UQkNKZi95OFpXYWtHenp4M0VsSU9jL25r?=
 =?utf-8?B?NGQ3SWtJaVg1YmR0SWQ1VGxvSDM3ZTkwcUZKSFBGTW1jeURoVmxLWTR0eStu?=
 =?utf-8?B?ZHlqQS8xcEpPaEFjdDEvR2RQckdvbDFQZTQveitPejBLeVltVU5Gemc0OVcy?=
 =?utf-8?B?b2s3Q2FHREs5UE0rdlJHY0dNRVhhb3ZvbjJGUElONDBzenJuZXlnblZKQnlE?=
 =?utf-8?B?aG02RHI4Z1ppZW1zVmJuZjVkWm1kY1lBNHRhNkszbXYzRUNiWndTWldMSGFK?=
 =?utf-8?B?LzA5T3dHTE9DcHpXNmdJZk16cmE2K1BFTWo1WCtwZ3J4cWtNaTJNWnlNOVhw?=
 =?utf-8?B?N25ZaHp4dkgrSndCYlpDQjl2OFZIS3dTMDlTMzUrNGZxTXozZ21XaDJHZWZC?=
 =?utf-8?B?SlN0eElGNnRYZjlMTnc5aVJuQ3JTWWpTMmxqRlRIL2FoalJkZ1VNN2dnNVRJ?=
 =?utf-8?B?ZHJkbDI0YUNjMXdBdTFBL0g0MGMvZlM4NTJuUysyb0VvVmpydnBFODI0WWdo?=
 =?utf-8?B?QTlaQ29kSDFNOGEyckgvWXVnKzRsS0dtVlZ2UXlicVNFYWdTVXNBd1pFcmtD?=
 =?utf-8?B?ZkpWV3Q0UlB3bVh0eXZMRXhkLzROV2NSb2k0TUZ6R1hUbWV2RnpEY1pwWjVE?=
 =?utf-8?B?V1dRTDVzTGgwNm5sMGx1UFQ5ZFAzZjNTb09qd0ZCbHBiVkZoeGtGam5ZM3NG?=
 =?utf-8?B?VlRYRjQ5cVpCaTExdWFrMmJzZGxtaS9jaFJkSmE5NmI1YytYVm5IOWZhTG5C?=
 =?utf-8?B?SmF3SnlDRGo3dnhjNjRKNmNGZ2krT1hzSHd0Z0xRa3FXSll2OFdKL2E0WnRx?=
 =?utf-8?B?blRhdXNKcWRsemovK2J0eTc5Wk52Zml2UXdlY2h6SnlCNVRGQkNkOUh2NUhl?=
 =?utf-8?B?YUdMVnhMbE5Qd2Q3eEdmY2RNeXJPekRyMlIya3JHMlRsQVduMXhncVJyYmVS?=
 =?utf-8?B?cmJPRHNOUlR4UUxJbFlhdWg4TGhEcUwxNFJQSmlUNzI5Vi9ZWm1jcnR3SGZH?=
 =?utf-8?B?aHBrZUxIaWRUeDd0K1NjVmZscDNnYmsySUdpL04ybXBhYSt6VkNQSnpILzJO?=
 =?utf-8?B?REJlZG5BcnhBVmcrV3NKdnBzeElFcC93UlZDazRxWHBBSUpzeXFpRm5KQ0Jl?=
 =?utf-8?B?NUoyaW5kWjZZWmZ2NGV1M1FvdFpoWWNCNzVMQm1DL1VuVEROYWthSHVHbzg5?=
 =?utf-8?B?N2tGZVFpd1hxTEJTOERENEFRQTcxamxHdHFSNE0rbUE0a25SQU9kL1I0RGJI?=
 =?utf-8?B?WkpZWVRaTUI5UlB1SmgydEVObGdhL21uL1V1U0k4eUN6RW4vUXhVMytkTlUx?=
 =?utf-8?B?dVQ1QUgxS3JsWXZzcmRqR1R5ajFXLytRT1JZWTFtZGY0NjdyWEFLRUV6d3Vl?=
 =?utf-8?Q?KGqxZH2qnjOTAXmH1Zy7VFjB4QvulQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0NHMHBmdHlCSUlpVEZLN0xWSlBjRmpueGY4SEprejdUcmpGelpJMUtxdUxt?=
 =?utf-8?B?WndXbW82cWlaY01uRVRDRXM3OG5MVFFKVm5MYkx6YlBjNjFPSlhsSVNNQ2lh?=
 =?utf-8?B?NmtjbStGTUNHVitZRWZVam5FRTB6dkJUd1dYNmVVdVoxT0tmTUh1K2VpQkZI?=
 =?utf-8?B?OEM4ZWRPWTVFS3Fvd3I2ajdHZDUrYkdDdDh5bjZBWHlXY0dpajlTS2l4NEdT?=
 =?utf-8?B?UldGaWhGdDBJYUxlU1FlbXRWbGlSeXFETkM5cnFIV2VlWWlrVmd0dlVWc2pj?=
 =?utf-8?B?TVRPYmhuK3VhR1hMc1ZnSnNTMTAyMGRkWjVKcVN6M3lkZzZMSTRVc2pJejVP?=
 =?utf-8?B?MkFIWUhnd1h3QUVxZzRvTm1FV2IwZHh4Y0pIVi9udFpSeEtHclJSMmtnSWFR?=
 =?utf-8?B?S3hHblNkRUdmY0lNT0lMY0JNV2ZUcXRSMk5sdTgvdjlZSGptbG5TbTFWMWh2?=
 =?utf-8?B?WDRTaXlONTZxMmUwUE1BRGtQc2R6ZEVnd1k2eDErOHB3WCtZU1psVlVzQ3c4?=
 =?utf-8?B?UFd2M3U1VGd4TEhWSTdVS3M2NWpCay83eEFvNFJLSXoxUHB6V2JFbFl6Mmwy?=
 =?utf-8?B?Rll5N0ltcWNWWkdFZXNSU0VpWmJOMUNkMjVoeE0ycHNLY25JNlU4QkU0TnMz?=
 =?utf-8?B?SkY2SnNqTjE5OW5DZ3M2TTFCRUxmcndkV3BOK01ndHVrRlVlZGhxOFhDaW8y?=
 =?utf-8?B?eWlZQjNyRTVmUFc5dlBTMExXK0syNWtmRjUwcDE5anBDVTJ4MDRFL2x4UVRF?=
 =?utf-8?B?SUQxZ2dkRnMrdVpqRHZPdEFTYU1kZ29PbEhUK1lBTGRCVjczVFVybjQ1eWhz?=
 =?utf-8?B?WVFmK05pZ0syWFdGTi82TWdYNDVqU3ZVWXlxU3k2RkhkRVNxYUpzTzBpYnhM?=
 =?utf-8?B?U1FlMlhsOUhGU2hWQkdXWS9ZaW1oWGYvOUZMYXd6Q3NJRmZrWEYwVXBVUlQ4?=
 =?utf-8?B?WWRwa2o0UzNxVDdHdHNsaHRicXdSVktwQjdpQm1CUXJLRjZab2RXajNFcGFw?=
 =?utf-8?B?dkxBS0FaK3o1UUN5U3JnbWNEUmtSYks1aGUyZ25IOUJpK055eGMvK2l6c25n?=
 =?utf-8?B?MWRXQ2ZKUmpXNmZMV3d3WERxQmFRRXlLSTBESUpMWDNwZUZRRlJySjNOM3JZ?=
 =?utf-8?B?eUVNZXlDWDFTQis3TWFqUmdXTm1hV3BOd2RnaDJaeDg5enU5UzdRaDlERDNV?=
 =?utf-8?B?eEZhYm1xSjJvRGFhWTI2YnJLSnArZGlsdzFSd1dzdC9GelFEOXVVakRMU1NN?=
 =?utf-8?B?blF3ZWUxajM5UUxjb0IrK3RuVzV3ODhnTHlrUmd6dkgrLzBVSndmNFlJeGN6?=
 =?utf-8?B?b3pSdlNJY1FYQ01US2prYWtuUmJhQlF0dmtRZ1NoU2V2aUtxd2VsRDBkRGg0?=
 =?utf-8?B?dVJ4RDRKYWZuV0d2SDZ3UUtsR3Q4V3dIUllHU290RWdhYWlLTG56SmZZUVpX?=
 =?utf-8?B?L0xoNUwyRkhNc3RCVXhjenEwVDVzeEZWM2dEYVBUNVV4Q2l1ZWQxbUc5WHUr?=
 =?utf-8?B?ME9uNlQ3V3phdTV6c1M5MDR6TGNHTTV3U2JwTmhINlY2VGpwWHVOL1IxcTlh?=
 =?utf-8?B?aGJnb01xbnNQalYzZ3NKV2c1TDhVWEdYUytMYXVIRjI4VlNLM01mMHVUN1dx?=
 =?utf-8?B?N0IyRXpGYmFqUlF0SW50OTgwNGsyM3VFdWI3cWRhMmYxK1EvMnZ3K2FDTzBu?=
 =?utf-8?B?eUhMNkN0Y1BUb0Z2UjF4ZmYyc01CdjBKRGgxQTJaRTZ2blRJdjVlMXNJWWlU?=
 =?utf-8?B?ZUl4a2dSb3NFTXJuNWNWZ2kvMkxJYWNpYjMwdHNVWTQxSTltVVdPc2haYWFx?=
 =?utf-8?B?aUFNVlZHOWUwelFoZmxXaktTNmo0bUsrL3R2bnVoQklaQ3pieFYyRFgxQi9D?=
 =?utf-8?B?R2xyT0gxcXIwT3p6YzZCQ0ZPdEVLMkJYQkwyYnRQQklUWGNYQS9CY3lPOTAx?=
 =?utf-8?B?YjJaSWxqQytTN3gxQmZ5M2d5SUhnWFNHa2FCVDJydlcwQXBRLzNLcnRJR2xV?=
 =?utf-8?B?ZmxUVkEzbUx1WmZ1UWczMS9oWGhLbVRWRkNvd1BxSkxMOXZUajJiYzhMS09x?=
 =?utf-8?B?ZitOWUN5bTcrYTh2aXFqUG9keGszMG5nQnY2WW1EbzVaQ0dqbFlFanAvY01Y?=
 =?utf-8?B?YWcvUGdEWE12eUw3aGhTeUJ1N0w1UE9zOS9LanBWSVVUMmhWU0xFeVVwT1pv?=
 =?utf-8?Q?J4FtbfoNpVOv8jmYR7Ml273bKSxjzk/YQ2dJV2x8fVat?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b01f9cdf-ae75-4f28-ff5a-08ddcdd4fa2f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 12:47:57.4921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzCl59EhZI16TRIqV6Xn6Yhis5kVvdX81IUrSVTVsQrLWE0Lh/Y/80jCwVNWL9pg375WKNaMwIwLj5yJ9cwDtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8848

This is the sister patch of [1], providing an `as_bytes` method for
`AsBytes`, and an `as_bytes_mut` accessor for types also implementing
`FromBytes`.

It is going to be used in Nova, but should also be universally useful -
if anything, it felt a bit strange that `AsBytes` did not provide this
so far.

[1] https://lore.kernel.org/rust-for-linux/20250624042802.105623-1-christiansantoslima21@gmail.com/

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v4:
- Add the `as_bytes_mut` method for types also implementing `FromBytes`.
  (thanks Alice!)
- Link to v3: https://lore.kernel.org/r/20250726-as_bytes-v3-1-eb7514faab28@nvidia.com

Changes in v3:
- Use `ptr::from_ref` instead of `as *const T`.
- Link to v2: https://lore.kernel.org/r/20250725-as_bytes-v2-1-c6584c211a6c@nvidia.com

Changes in v2:
- Use `size_of_val` to provide a default implementation for both `Sized`
  and non-`Sized` types, and remove `AsBytesSized`. (thanks Alice!)
- Link to v1: https://lore.kernel.org/r/20250725-as_bytes-v1-1-6f06a3744f69@nvidia.com

---
Alexandre Courbot (2):
      rust: transmute: add `as_bytes` method for `AsBytes` trait
      rust: transmute: add `as_bytes_mut` method to `AsBytes` trait

 rust/kernel/transmute.rs | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)
---
base-commit: 14ae91a81ec8fa0bc23170d4aa16dd2a20d54105
change-id: 20250725-as_bytes-6cbc11f2e8c3

Best regards,
-- 
Alexandre Courbot <acourbot@nvidia.com>


