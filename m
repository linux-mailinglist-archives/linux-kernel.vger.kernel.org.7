Return-Path: <linux-kernel+bounces-751096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C76B16538
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48F3A546F7F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F962DE6F7;
	Wed, 30 Jul 2025 17:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="EKHq1n6f"
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020088.outbound.protection.outlook.com [52.101.196.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B499F2C1788
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 17:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753895668; cv=fail; b=f5tuAh+Ugh9eXzBuAIe07pjNdVZ56cDmeaesU31hZDhCxln3Z4sPuEEcUGJvx0+CQAzwu+zCK/2R1ueJUMXvYc/pI2UXhwLN2nQGTtGIn2I2y2OCOPlJ5nShqWFMJS9c0Oi4lqruJ9fpxiUtq1C47KBF6w5AURCvwvAuFBQjH+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753895668; c=relaxed/simple;
	bh=BEk28o7YNaXG/ubHIl9gWjHMi2WsCSgeRdka//LG9ic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u1CWgIUVRyxtL5uzjDnnkDRMxH1tRi109PJTzZTSczjC7e04Lj0bkp6K0vc5954w0momxuaRhplC+5KAddBnFY87QNEBQxlsszuOW2nZUAcCpgkWnDpJoeaMFd/qGc35JiOq2EfXHdsiBDO3NugI6VR+3B+b0QJegspw2HncZ+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=EKHq1n6f; arc=fail smtp.client-ip=52.101.196.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b12PNPpYAk8jch1bvHFPetVe8B3OeB2r9hipqu3wV2A2mk1T74oqhds3w5WbQ36YB+zlIA3FEVNEnAxScaZDmMwajeMagXmQmgeM0dOb1zWU6zEdb7F7H9wgHeKjnYBTx4ItqQ3+kc9fRFP8SRcSEizLRaRcfF5B/88r4ckb0C2tVC3PMiUpyox2WaAcftuuZpUcrcz32yT/91K30Y9CaPi2IpYnIpdMqeTnItZOJO9T6KViD3ClmsC8lJnVA/4kf+yPWjpnSEZ72vNI8k1W4VbAPju9uYtT7/gM9GnTR4znYOzlBP5uQd5YM+RvLIqYdYVkTv2u2F1nDnj2YK1VNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFU1tL3QWXzpRj2C/tUxYgrgqcCcWju3riQ/iaurh/c=;
 b=lXxv0saJp2A/VvEPDm/5bn5qX38GOFf1sseOBtjqgzkF/py1sHFLKeE/QvWGa40hkKbjpzD10+a6pXaRXtJJClUTZbyQCeUbnB1WybRZFFiqtHYgzLikTDjCEXVTq7MvQGN8YldO4G99M0V7OClRPhk6tzi/eV+s9ZdHkHaYpIcW0zhPirSGE0cHdMH/umlP5RbKp5TXRREZ9b+6s0i2N7IcSpvfv8xgcs2OXVMH+IBWc8JimPz1HDvtAECgzKQTCTvFcmeIANObh0ZDlh7k+v8K6nKeEPaZH2Dc/ejtV6YtP0CuY0/aZ02Qd85xrM/Ab0Xv/6YfUMl6sQr+YA+yqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFU1tL3QWXzpRj2C/tUxYgrgqcCcWju3riQ/iaurh/c=;
 b=EKHq1n6fDzdr6Xpyh9ZNkCgN9hGYrsHptzeDc17PcNluo0Jf4Dkn06PFCBAoPkWo6NZfEMiwhTTfUgOc5wYz/zHf5hEPUOZIPt6Hg8Pm0Oag6pgFqzkoFpksyP/BziY73crP+iG+d4Qt+yFxmsJW32zsq6/KEz/xj1JB560wpDk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB6042.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:29c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Wed, 30 Jul
 2025 17:14:22 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 17:14:22 +0000
Date: Wed, 30 Jul 2025 18:14:20 +0100
From: Gary Guo <gary@garyguo.net>
To: Ritvik Gupta <ritvikfoss@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v2] rust: kernel: introduce
 `unsafe_precondition_assert!` macro
Message-ID: <20250730181420.6979b4f1@eugeo>
In-Reply-To: <20250730171132.159917-1-ritvikfoss@gmail.com>
References: <20250730171132.159917-1-ritvikfoss@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0113.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::17) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: 47764bdc-1b54-4a7e-d021-08ddcf8c86d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVFMRCtrUXNaTEl0cUVOL0txN09MbVkxRkZ5a3pZK3JnZFdsNGRqZTAwU0RO?=
 =?utf-8?B?bG5MZWEvQ0xzSSsyOENWUUJGN3paYzFTZzhJVHQwSk9UQi9kVzYyT1g4Q3RE?=
 =?utf-8?B?UkRnR3kweFdDTE9XT2M5L01PclRzVXVSWUlsdnVvVUt6RGlTV0JyZWNyNkJv?=
 =?utf-8?B?MHV4WmN3TDZ2YmJGbm93c1FuMGNNZXdKNmU3Q3R1elI3WkxIOGxaTFpYQm5i?=
 =?utf-8?B?VFVZK091L0NqRVh6S1Bmcm8yWlBSUzg0TzN5M3BOUDA5bmRZZ21LQWZIVGs0?=
 =?utf-8?B?Z3lEb0xUVUNyeS9PQ3lKWWdmTk9veUVvaE91eUtaMzV4QS95dzdYY3F0TzJp?=
 =?utf-8?B?R2hoelREWS9wZWc0bDlGV0RnM2lYSVJNRmI2S200OXk5bFh5TzJoODEzTUlQ?=
 =?utf-8?B?elR6Q0R5SW40cEFHR1FKMnowZEUyeGM1VXpUOThYR25JbXF0cEJZYmdBV1pB?=
 =?utf-8?B?OUttWHJEZGZxdmZZcE9NYTdJS3lVUzVtS0J4dTNSMzJrWEl4YkRySFd5KzVN?=
 =?utf-8?B?ckE2WFNQV1FSeUVjZkkray9MSFN2L2FWQ2dNRGN6V29IdTdRaFovdlVlaE1O?=
 =?utf-8?B?Z3B1VlNXWWpzUUNkTm13TUl4QVFqZEhyRjhYeTA1WXBaQ09QNkZuVks2TitR?=
 =?utf-8?B?RlVsQXF1bUQySGZHR04rRXJoVC9vaEQyWWNBRXpCL2JiRUQvcXRyRklQK0lp?=
 =?utf-8?B?dGhwKzV3TTVhMm82c0E1NVUrNHErK3puR3Zud3U2cFE3SGY2N3lJRzE1VVpU?=
 =?utf-8?B?dW9HbzZBT3NRVy8rVVRnUGRpV3dxMTNGL2NBWVVhMGlYc2hRUFhxeHVpbFov?=
 =?utf-8?B?dlVnTVhGV2hURFZpcW9kanNHOFNMKytIZGRHU0xYR2pUZVgzVkl6eDF1b0VV?=
 =?utf-8?B?Ujg2SmNZZ1grSUNKMEJsRm9PRCtmUEdyQmRTTXFpVmxjcWlzU1BPckhwZDFW?=
 =?utf-8?B?eVRrYks4RVpLRTM5bXRmaWdRR3V4M2FGNkZvKzBLL2U1bzNVb0dRNnV0bGR6?=
 =?utf-8?B?dHpYRXczUktPbnRsUFpqR2JlRzBKUkdpNmh0T29UVTVRcDNNa2pBdE9QRUdO?=
 =?utf-8?B?MExaOVNYeUI2KzNaTGsrU0ROaVp0THhLYW5TQ2FIczFZQWREYVhLN242NE1h?=
 =?utf-8?B?NWRQMUhIVmVUTkI4U2J2N2V1TVdHa2drbDVaYmhrM3doSFpNM2Y5MGc1a3VW?=
 =?utf-8?B?eEE3QTRQUXpvSkJlNythQi9kWEhQVm02TWkwVDZSWW0yWk9YT25venp3Vy9E?=
 =?utf-8?B?bnRFZGltNUVWM0dxbTZJc3NBa3dkY0dhOG9zZGJNSE1Ea3RVS0UwTGUwTXdy?=
 =?utf-8?B?SU5kVGlkNGxvMys0V2hnNFZrNWFJZ1MyUUR2MVBhVTNMM3NYTFlMWXQ1NDl5?=
 =?utf-8?B?YXZTYWNrWFhTVitJQ2FRY1JqTXFUVzVvMWFUb0p6QXJQVTJQY3U5Z1Q2cDhl?=
 =?utf-8?B?b20wQzlIdG1yZE9BRVRmTE5jQ2Nnc2FXbkhWMjRpMmxOdTl2ZVBocnVUbitE?=
 =?utf-8?B?ZVlrQWRBSk9Sb2VpUnZkUnR5UXlhT2xjNktvVCtBbVdQRVRUS0hSVWNidHBr?=
 =?utf-8?B?cU4vRWJzYm1lNUZ4YkZxNmxxODc5SkFOYlIxUW4rZnFtZlh5YnFNUDZNYzc4?=
 =?utf-8?B?Y001UlloODR0TjV1OGREcm9TbVh1V1JMYmllTitqckpRemNodVhYVDgvUy8w?=
 =?utf-8?B?TGR2RitFRklqWGp5QkVWczVBVk1SckNZUEJCbkVmWlpFSDJMQmIvTGZsRmJD?=
 =?utf-8?B?eUpJYmJWWXY3ZU5HWlVBQVlqeDY5QUJJTXlOcWx3bW1haVpoVzN6S25pME1X?=
 =?utf-8?Q?PCuUJdCAzZFfCJJd0+Pt6eWAXM89RAmBlrBZ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVBkNFVEUThjYzZRZVdHdzNFSGZyY2ZuSFJrZWhmejNlZDkzSFczVUQ2b1Nw?=
 =?utf-8?B?bEIvMVhWR3k0M3pUdFJwZWF6UTZNdFVDZE1aeWhmcXc0Q1ROQ2RFU1N0a3Q2?=
 =?utf-8?B?UndSR0FQZ0lUV2h4QUwxKytieGUydHgzZjllUjJ5TjgwdmZSdHViQWVjSU0z?=
 =?utf-8?B?YlBqS2xzSmtRdFNwYnRxaTFXdDFFZmtoWDNZSW15MW9wUDB1Z0ZzU2xtVWNK?=
 =?utf-8?B?TlJ0MWlqeUZVbTJHSXRtQzNtS1ZMOFFLTytJdnp1MnNXdTR2QWUxL0JIaUFS?=
 =?utf-8?B?Q2ltVVhlc1JPaGFEQ2NSYndFSzZyVE5lMVNrdmJhR3pscHJJbjl4RXhkYWdI?=
 =?utf-8?B?MjcvZHlkV0R2TmREamxqWDgzT05xODdDUGhOcTVkcXpnaW5Fd0xPaG9RQTV0?=
 =?utf-8?B?ZHhibG1sc2RMSXpuNnBudm9xMGhKMzduTHlqcUxtSUQzUDZpdWRodEhYNkJy?=
 =?utf-8?B?WDROTWE1ekpCcVRNa2V2OUdsZFRESjdNSzVUOVNPNGJDVFhhZmxUeGVyNk5K?=
 =?utf-8?B?d3dTTk5TTnphZGxoYitMdzhKNWM0QTVBVVNMdVpUbXZJVm1xcG1nNk05MFFU?=
 =?utf-8?B?eURyWklyOWtWR2plUnlZaHl0NURvcDFOZksrN080SlRiSzFuczdFSnNTNzJS?=
 =?utf-8?B?MnM4ZlBzejdwbUhHaERnRHVEN09icWcvQmZNclNOM2RqMjZLamNGeTZxRlB5?=
 =?utf-8?B?VUFzTWVhNEplMEQrUGJQRWpHcGFMOEU0YkxCWm9YaFFsSHNseXVTTzcxR2o4?=
 =?utf-8?B?NEQ1WHFLVytBUit0ck5GTVd6VWtaZUIrT3Jld2J6OXlQT3l3MUphc1Q3OUtZ?=
 =?utf-8?B?M05Sa0VNOUtkS2ZIN2hBNEpLRWs1MmpTQS84K1FNeXJIdEJzSWI0THhsT2FW?=
 =?utf-8?B?ekEzWlk2SSt0eG5FV044QWdod241dmQ2cm9xRWlXM2cyRWM4NkpiRDJiL3k5?=
 =?utf-8?B?UFU1RC9sRmtpelJFZHYyVm5PWTE4NzgxaHhhK2RSYkQ3YWRxU3JDSU1FYmEv?=
 =?utf-8?B?bVJ1clJkcXBkM2l2NCtOOURYUlFLaUwySk1ZU2hlSEJ5UzFkR1ZqNHYwa2ZK?=
 =?utf-8?B?cjBDVWJVYkZwVXo3aG1IVkFjRWZPaitVZnUwZ1NVeEhqaDlmc1FKMHVZQXZw?=
 =?utf-8?B?KzdVOFBEQjJCVnB6NTFzUDNwNFEwRUhoLzM2aklWRFpMZWUvdk1YV2NReE0v?=
 =?utf-8?B?VnhLMS9XUE9lSy9kcm8rSmVDdzVHZUVhd1lYSjc5ODFQTjZ6ZFhiTm9udUcy?=
 =?utf-8?B?SlB1TEpNNnJYK2wycHQrQ1ZtRFBWNHdOTFZqMmhYQlNmdHNKN3QwSVBVb3V4?=
 =?utf-8?B?SHgwcXU3c2E5MUpFbTJkeXZ4YU5hNGtkcTZDaXVFV1o4ZVFXRXVCWGIrWEpx?=
 =?utf-8?B?QWdZNjd6VlZKVHM1R2k4bDJ5dFNQUmNUOXlTYjFEd2MxVnFGdUw1Nm1IU29Y?=
 =?utf-8?B?Kyt2WlhKalhoOXFGYVg1NzhpL0s4LzJ0YjhpMTYzS1NpdFhHaHlHUDAwRFVm?=
 =?utf-8?B?VWM1NU41N1h1R0NzWFArNFlhcVRMMk5TTzREYkpWeGoveDF6MzhHd2ZVQ0Jx?=
 =?utf-8?B?d1lzNXVsUGphMmswY2JwOVlRdUVUTUc1VDVwcTdIMnFXTER0R3UrL0t3UFl1?=
 =?utf-8?B?NDhjdlF2SS9OdFBPR2xKQTcrbDk3Sm1YNUZoMnJjTHp4bG9pcERwRTBOZE4x?=
 =?utf-8?B?MXF5K1M0SlhUOEx3MmttVG5ZekFRYWg3cXJSSHc4eWhmTnVPVVBvejhPSlRq?=
 =?utf-8?B?bGN5clZGcDQxVjJDNHFxQm9qUmtLSkViQ3FCVjMrSjc4VXhkRWQvNiszaTFj?=
 =?utf-8?B?WUF0N0Y3bk1ndkxVaGE1K2dEcUNSOWJWb2ZkVTJBdjlFelREMC9QNnBoWmdF?=
 =?utf-8?B?OTFWdjgvbHB2Q2RqanA5dUM2alM1YmZYL2VpTWRwODg2U2dGYmMyZWJYZUh4?=
 =?utf-8?B?MW13dTFha0NJN1NWRjk2Z3F0citWdm44M0puMllycllJNDgrU0lxUDFOQkZB?=
 =?utf-8?B?V2grcGFheWFPc3l2QUFiNTU0VURWQUFSVDJwejVyaitHenppYU94c3JCOTl3?=
 =?utf-8?B?cUxGZUQ4QzFhQ2RCSDM1OC96bFRqOEFHcnp3UkRsMHhaQ1NqOUJmNXBMQy9s?=
 =?utf-8?B?dXhzMUx2bWgycXorZ1hBTzNSdm8rODJQOHJlMVRnUjEzNUIwYjVYcWtscTF4?=
 =?utf-8?Q?xW+BfrQ9vqleYE57iWzWz0nGOXwwgJCTR0PkWwsLD3vK?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 47764bdc-1b54-4a7e-d021-08ddcf8c86d2
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 17:14:22.2361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NeG4dFKLxg3x5MPWqDa+h+SfiqxLqeewzhso0P9x9hZh/cWpcNjF0dOSYYk2/qGpOWFEqtUD0SIf6Uppmhdm1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6042

On Wed, 30 Jul 2025 22:41:28 +0530
Ritvik Gupta <ritvikfoss@gmail.com> wrote:

> Introduce a new `safety` module containing `unsafe_precondition_assert!`
> macro. It is a wrapper around `debug_assert!`, intended for validating
> pre-conditions of unsafe function.
>=20
> When `CONFIG_RUST_DEBUG_ASSERTIONS` flag is enabled, this macro performs
> runtime checks to ensure that the preconditions for unsafe function hold.
> Otherwise, the macro is a no-op.

This email should be include the Rust-for-Linux list.

>=20
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1162
> Link: https://rust-for-linux.zulipchat.com/#narrow/channel/291566-Library=
/topic/.60unsafe_precondition_assert.60.20macro/with/528457452
> Signed-off-by: Ritvik Gupta <ritvikfoss@gmail.com>
> ---
>=20
> Changes in v2:
>  - Wrap `debug_assert!` internally instead of using `pr_err!` with `asser=
t!` + `cfg!(debug_assertions)
>  - Print =E2=80=9Cunsafe precondition(s) violated=E2=80=9D only on assert=
ion failure (no longer always printed)
>  - Use `# Safety` section instead of comment in the example
>  - Rename module-level doc
>  - Link to v1: https://lore.kernel.org/rust-for-linux/20250716045957.3973=
2-1-ritvikfoss@gmail.com/
>=20
> ---
>  rust/kernel/lib.rs    |  1 +
>  rust/kernel/safety.rs | 52 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+)
>  create mode 100644 rust/kernel/safety.rs
>=20
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 11a6461e98da..7aab607dd879 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -104,6 +104,7 @@
>  pub mod print;
>  pub mod rbtree;
>  pub mod revocable;
> +pub mod safety;
>  pub mod security;
>  pub mod seq_file;
>  pub mod sizes;
> diff --git a/rust/kernel/safety.rs b/rust/kernel/safety.rs
> new file mode 100644
> index 000000000000..42f7763a044f
> --- /dev/null
> +++ b/rust/kernel/safety.rs
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Safety related APIs.
> +
> +/// Checks that preconditions of an unsafe function are followed.
> +///
> +/// The check is enabled at runtime if debug assertions (`CONFIG_RUST_DE=
BUG_ASSERTIONS`)
> +/// are enabled. Otherwise, this macro is no-op.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// /// # Safety
> +/// ///
> +/// /// The caller must ensure that interpreting the bytes of `[T; N]` a=
s `[U; N]` is valid.
> +/// ///
> +/// /// This requires:
> +/// /// - `T` and `U` must have same size.
> +/// /// - The bit pattern of `T` must be valid for `U`.
> +/// /// - The alignment of `T` must be at least as strict as `U`.
> +/// unsafe fn transmute_array<const N: usize, T: Copy, U: Copy>(input: [=
T; N]) -> [U; N] {
> +///     unsafe_precondition_assert!(
> +///         core::mem::size_of::<T>() =3D=3D core::mem::size_of::<U>(),
> +///         "src and dst must have the same size"
> +///     );

These can just be `const { assert!() }`? There's no reason for this to
be runtime.

Best,
Gary

> +///
> +///     unsafe_precondition_assert!(
> +///         core::mem::align_of::<T>() >=3D core::mem::align_of::<U>(),
> +///         "src alignment must be compatible with dst alignment"
> +///     );
> +///
> +///     unsafe { core::mem::transmute_copy(&input) }
> +/// }
> +/// ```
> +///
> +/// # Panics
> +///
> +/// Panics if the expression is evaluated to `false` at runtime.
> +///
> +#[macro_export]
> +macro_rules! unsafe_precondition_assert {
> +    ($cond:expr $(,)?) =3D> {
> +        $crate::unsafe_precondition_assert!(@inner $cond, ::core::string=
ify!($cond))
> +    };
> +
> +    ($cond:expr, $($arg:tt)+) =3D> {
> +        $crate::unsafe_precondition_assert!(@inner $cond, ::core::format=
_args!($($arg)+))
> +    };
> +
> +    (@inner $cond:expr, $msg:expr) =3D> {
> +        ::core::debug_assert!($cond, "unsafe precondition(s) violated: {=
}", $msg) };
> +}
>=20
> base-commit: dff64b072708ffef23c117fa1ee1ea59eb417807


