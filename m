Return-Path: <linux-kernel+bounces-779768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A13B2F88C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757303AEBFA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1222320387;
	Thu, 21 Aug 2025 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PfDoGoS7"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209953101BF;
	Thu, 21 Aug 2025 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780165; cv=fail; b=HTN2vcUG5mnK3DsUTRte6ART4+jDDPcQPwa9RV6pok7cpfQ4Rgrr+bK+/6JIiohy1Cl1q8ylpdB3qX7bJ8IX7r0wasrwI+4mVc1a+mf96E9WxXbpjmtVn3JsbANLF6BGGkTCkCkXlJyUwY0lMwHqWnK4w2/uOqKIghi8p0ZxpLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780165; c=relaxed/simple;
	bh=YdDGpltXm0H9KbTro2GYZTbtr+R3nI7cIWvJk/wscw8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Lx2nKn7Wv//4IbuZQoNz3O4cggQDh2/lEJki3I6SVdT3BRSh8rac8pRgIXTOFM5jxx9QQKSY/tALbUKLkUZ6Sre59rGBKeNa0wEBuSP7jCtS1yg4k7xXNoBG0imGtuWZ7YYAoD2fbGvWjUf/sR3prn/++sJs6C4FKaRv17VqUl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PfDoGoS7; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6+Mioj3axIp+STlmuit4JIZUXdUNZxq3FyqGfXK2QbM0lmnlpzrOTtHbDLHmd2Bl0jgO4dor0Mh2s4b0MEOfIxqKAAgEF81bj/4IYDKsNrgQiTO2lBmxgQDnva93mOa6iPm8EXJeo5rW4wfLJ1K8MIu+1yyM8dbQWd6OVwGXZlvtCw6p5RqB176E5OqUQrH8TQ23F3taeNiYx0obIIUki/B53zL70s2kuQrejXds/I2fYlxqzP4RLpI4pkP0H5K+ZrZo2yHpYe68a/KXS3aqFDrYUMoVcpmvAvM63d9poXb/+VEeB5OJUglAx9U8Lu5aMSEqZOQcrvTgUvujfDq+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbJ5QHOYkDk2Ssac6AGet5LDdt3WkcZrMKn7Fiynpmo=;
 b=k4aoXKrJxP77+LmPmXCC93zdq7hdNdEzHYjSfB+NE5ZxEx1V/T+H9k1bQR2OJABWTVJwalaE5DZv8Zv0BBmZx/Zk4c7M5BD9IY1SlLZq3fKejzgFJUMsAw2TDdk3bV+RwIoirYrh7hM2lurBGQNw8jLCfWXHTfFbabTZyZj8QgewJwFUwcFmuXZA7nwtJIeHvyxbNMy/iojGKf/RmBgKGicw6JrYPnBMqmp4acxiVhoj0INKxpp7BU3AVup2n6nR3cdB4aAiVATP6NZeX7qnT68bMgl7LkmdD+vLg3fuvtELCjD4e0PDAlHBup6m3DyJdUvudpsfLUuR+RX2Njx9dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbJ5QHOYkDk2Ssac6AGet5LDdt3WkcZrMKn7Fiynpmo=;
 b=PfDoGoS7xtno/Gxy2sc3MWQZmDowCAskh/N9ZWxbUqhV6iNVJqGL39CdGGtAwnA3IO6QgHsGM5FkqKd2bvRHt30IYKELJE2LVsDoAUA3GhbKbMxiiROCIt990Y+KP37YlIVJMl3P3+4ihlQBc9t3OKFdQq7ZLSsvA2fvNZS4B/wFqFTuO2gvlx1sQA+pe3m9m546DG80T26JqGDxQIKm1IZAVXVZ1cqc3GcgGExJoXPjisq8gCHxD0CcG9fvEtvWw3UK8oH9fNgLqdVA8VNjFf677/2xZIF7CKsJwmJn5+fsU8EoMusk+1rKSEqCTX6p1H3HY7T/Q2+8ayE4W86Vgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 12:42:39 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9031.023; Thu, 21 Aug 2025
 12:42:38 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v4 0/2] rust: add `Alignment` type
Date: Thu, 21 Aug 2025 21:42:16 +0900
Message-Id: <20250821-num-v4-0-1f3a425d7244@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACgUp2gC/2WQ3WrEIBBGXyV4XRd/EqOhlL5HKcXo2BXWpNWst
 Cz77p0khe5SvDoy53M+L6RAjlDI0FxIhhpLnCeE9qEh7mind6DRIxPBRMeUYHQ6J2paRM0dE64
 nOPmRIcSvLeXlFfkYyzLn7y208vX23q+cMtqDk16GkSlnnqcafbQHNyeyBlTxJ2nW7pJAyRo1G
 mcVjEz8k+SNxMUuSZQ6ZbwKwLU04U667rtn+Dxj8WUvQBKUYrfiQ/P4u4KmwZ7cPPlk30SnxrU
 Cni4Yzr02Ifib4Kf1T0ZbgCKkuAxNVQfe0+w4vnn9AXDfP+V0AQAA
X-Change-ID: 20250620-num-9420281c02c7
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 nouveau@lists.freedesktop.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: TY2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:404:56::33) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: 70fcae7c-e02b-4d0a-0789-08dde0b0362e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0pGMThpQ2VvOFF4bmIwb2RhKzR4L0hqVmRHa2dwenhhMmJpSWJ6cTgycXVU?=
 =?utf-8?B?QWRNSEo0a3JaNDNLckNkQ0Y0ejV0RlA4YTg1TVRjbjlLT0RtZ2xnNUp4eTMz?=
 =?utf-8?B?ZHQ5ZkVtQkRGcmRpd0ozZDNTRUhMYkRVb3VzV2ZtUUdMUUlkVHFlTXloWWVt?=
 =?utf-8?B?Um11RThtRktOeEo0d0RmQnUwREdrZ1J1akNKeXRDYWZpTXl0andnU29CbVFq?=
 =?utf-8?B?eXRIOTg2T01zSHFlaHNkL0ozc1ZrdVJVRGh1bnhxdUtSWFFmWWJmV1lPeDRT?=
 =?utf-8?B?MFNZNmw0d29ibE1idG5meXBReGhCc2x3bFpQZGltNThVZDc4L1l3ZVY4TlBp?=
 =?utf-8?B?V3JScmwxMS9ZRmJjSTNlbU5uSHA3VUZPVW9tTm1QeDlWV1NGMjBTY2w5Y3Fo?=
 =?utf-8?B?UjJKeStSV1JkbUU0YmxybGQ1TkFSOG9GWHdWdW9pTWVaV3NqK3dMOTVPNnkv?=
 =?utf-8?B?ZzQ2YUlLajduTi8wQmRXNk1ONmlTMk5rRnhnZDFqUTFZc2QySlFUcHg3Qk1R?=
 =?utf-8?B?WHQ3b2NxeXFpMjVxSzRXa0t3VHdrejRGQVZGK3dobjMwc1dDRTBTWXpEZXdZ?=
 =?utf-8?B?b0dDSXFqaDUvbEx4RUNQVWkwb0diRjl1alE2WkQ5QUo5MHFkMzg3T0NKdDlV?=
 =?utf-8?B?ditPQnNFRjV5WVIrQVYzS011cjRmQTQ2MXNhUkNBSFY5QWFpb3FHaG1laENa?=
 =?utf-8?B?all6RzBKeWdOeEdXSUtjTE1FWFZtVi9sMHYwZk1pSnFzQW4xejZDbG9OOU54?=
 =?utf-8?B?Y2lTTXo3NWZqbnVkcXFvcDR5SmxWWFR5cFVvTUE4T01iMFhTbGRNdElmZVEw?=
 =?utf-8?B?by8yN0xnUVMvQWZybXJvUkovdTJCWGNjb21ua3hOZFZZNU5LalM3VE5iMlZI?=
 =?utf-8?B?Ly80dndlWmN2WDhDaUJITk4vTlcrMzRVMVZCUHJwd1dnU2sxOCsra0VUSkRv?=
 =?utf-8?B?MHQxaTRVc284R2NLb2pLOW5XVi9RSnczV1JtZk1iUElNUE53QStzc3ZHVzJW?=
 =?utf-8?B?eEMzNzRSWUtITkFYVXJvS2N2cndpb3RFQkgzQmNUZzRmT2llUklROCsweEJr?=
 =?utf-8?B?QU0zRTZ6M29xU1pPMEhwcnY1NFRBaGQ0b2ZWWVd4ZWcvZldiREhFQ2JqVkNk?=
 =?utf-8?B?enNuaVBKN3NoR3Z4d2tRWnQzZDgvS01WRUZzY2NTTkMzU0JyNDh0d1pyV08z?=
 =?utf-8?B?OTFEMjFralpIMXcrZVMrbGE0TlVlbnFyT0VxaEppbTNTSHRxTmZOREhVQkpq?=
 =?utf-8?B?eDY0ZEZ0VG9nZWY1bDcvK0hUMmR6bFFlazI0TGRCV1NCUTVSazdRcWltUW5R?=
 =?utf-8?B?a2VJY0dXZnFoNE5MYm5ITDhtM0ZXVS8wR1VMeDdVcTE5VXB0MWN4ZDJyYTUw?=
 =?utf-8?B?Y3YyZnVzKzVUUWIyRW9RNmhVVG5DRzlWRktUeG1NMktsTDQ5ZVk2TFhBdXJF?=
 =?utf-8?B?UmF5Zko3a1pYYlZxSzdqREdsdHFjbzRsOUdxVVlNUk84QkE2NWVJVVV1aHFX?=
 =?utf-8?B?M3hlU2djVjgycnRQMVFxS2tacXIvQ0dlY2ZXVEZzeUI5Q0ZmNkJUMzY0amJs?=
 =?utf-8?B?cFUrSjJ4b3FPWkNNNGFod3RiTmdpNGszYmlPdzYyQ2NCL2YxLzhMblNhYnFG?=
 =?utf-8?B?ZlVkWDBETVEvZ0NnNjVQMHU4RUZUV3ZxbXJkZnhQd2xTeE5WaDFtQ1NyWHFl?=
 =?utf-8?B?UWJyRWNmTGdjUENITDg5Y0JJcVBiTUZzT3pKdVYxZ1FqcFpMYlZXSWN4YVZt?=
 =?utf-8?B?Qi9WZTJ5Z0tad1NhL2ZaR2NYV2NEY3FzZjZBd2RseEpaYkoxZXFKaUxxZTB5?=
 =?utf-8?B?Vmpoc2ZZd2gwd3dabVoza21VNXU2OUFycFluVGdlRFhqc1B2NjJ0S2ZTSDlC?=
 =?utf-8?B?Uy9QLytFQW05bEN0UzV2UC8vNVZRbW9ON21vdDdpYUNpblFUc0R0MEZlWldz?=
 =?utf-8?B?YldlR2M1NHhDckkwelVjUGhrLzd3bTZ3WVh1ZTlqNGUwTmRrRDZjNVh6cHhi?=
 =?utf-8?Q?o8PTz6EQwv90dETJNNvgXGbP0OSRC8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkJleVdZTjlkN3pUV1lRaGo5VEhXM2VQT3A3TER4ZHdPZ29pVlBpbDlaN3lz?=
 =?utf-8?B?Sit6dDlpUzd2MmpMblU2MzlzR0doc1RQUm1ncllEYjZCOSt1Z0RRcWhEQXJI?=
 =?utf-8?B?WFBvblg3SElzb2k0eXgrYTVlSHlkQUpWWlRCa21iRkE3bkRJZkZDeitFQ0h4?=
 =?utf-8?B?MTFOSUpxZno5a1gyM2pra3IralNTWnNRaWRtcEVDUTVYc1VTMUxXbWp0eldr?=
 =?utf-8?B?WHNDVGNmdFVZYlc4S1YwaExJblQrQnN5KzZPNWZnRWFRMU5MQllMNEEvY1Vr?=
 =?utf-8?B?NWVCN0VWakVEYlpLcnZOckpUbnFkSkVIM2NSaGlVU0xVOGxlR0hTTlRQNE5s?=
 =?utf-8?B?RHhsMHNhTE8xL01sVExoMzZ0T1NNVVorSjUxamJZZnRFMlZmbVJ2akxtRFRB?=
 =?utf-8?B?aG1vQjBnYUZqbWxLTHpSQkFOOFB0cDl5WTQwSjViT3MwY2pZak5ZVVkxeDZM?=
 =?utf-8?B?SFlGd01KQWM4aThkM2hMQnp5M3pHMExxVkdmcUxPSjRWSnVxREJZeFhZOTh5?=
 =?utf-8?B?cUd3TURFbjdqRTJhblh1V3J2SlpYNHc4SVdyQWRmakZ3b1Z3dnA1b2p2Q296?=
 =?utf-8?B?ZXFHaUlIN2lXVFVGeWVLamI5eS9qOXI3a29IcWQ0V2ZjWk4xUi9FdlNqQTZC?=
 =?utf-8?B?V1RteUV5a3pidWtFSUVsNk1nTzNWbzBkRlN4Z0h5eTBOZzV3QzJUblQrcVBs?=
 =?utf-8?B?ODJTck1FZGdiM0k3c3RpUlVueCttRm5qUXBWbDI2YTROTlFybDJTaGoyTDJT?=
 =?utf-8?B?b3Q4Nm1ycGo4OG5yNlVxQ2w5RjVEOURQRkpBS3BlcFlibkwyS2szZmxMVUZI?=
 =?utf-8?B?eVM5bHVERU9jTVF3V3VlTWtpTmRlSkFXZk1vV2svUkkxTDI5c0ZBdTNrNGM1?=
 =?utf-8?B?OEIwUStUaGdDZkhSUjI4Uk1RYldGdkFzNURTTTVuajhERjZWSkZaeUNrMUE0?=
 =?utf-8?B?ZkJlVmpOSlhENWloWm1uTDZjMkdzV1NSUnhPbVJnekFzWkIrT2NoNWw2dis2?=
 =?utf-8?B?NVhlVndTVmxOa1Fkanc0SmhPT1VDNTVlRDBhaG5COERpbjFKeTM4SDVKamQ2?=
 =?utf-8?B?eXhxbTdGbXo0WVpNOURnSWN1NjR4YmtDTWFuR0c0bWRaeWhwODlzc2RIU2dE?=
 =?utf-8?B?U0VhWnE5SUlkSXdDN0o0QWtZR3RySVcrY3Azcjh4eGdCOXEzR3Q1ZnBSaWc5?=
 =?utf-8?B?WUxNbDBtbmtPS0U2aXdsUERNd3RhVkNta29Hd0hIZ2g0bFRnMVkrOW5aV2NR?=
 =?utf-8?B?aUFNNWhsMG5OUkZuakFlSEZXbzNHMzlWY2FtT280R21OQjVhTm56MTBheDk2?=
 =?utf-8?B?d2JYMlJLZjVaQTV5VExZeWo5L0ZWeTVLaVFBV0l4QXUwTDE2dXh5MlFsUFFH?=
 =?utf-8?B?ZkUxMVVLd0NmQlNjQTg5TnY4Q0hsRTZ6NXh5aU9pRGxScWU4d2ZmUkhyVVMy?=
 =?utf-8?B?aFNJdTljUnB4VmZ1Tk40U1FjNWtoZ0NpWTdtaWdrMFBYcnpBdFk5SldoVVhJ?=
 =?utf-8?B?NVJLa2xqYjY2OXc1TlZJQlZQM3NUaVJ6RDZxWjRuSWRjdWhqa1BjNitBSEpU?=
 =?utf-8?B?MGNsTEI0N2ZhbkdVTUppdjk0Q29GdmxhS3FDUGtGL0RsUzJQMklSZmVjT1J1?=
 =?utf-8?B?UTFNTUM1T1NXQkNSVVFIakJrME05QmJQMG9iRFlwSVdDRXFneFl1Q3lMOGRa?=
 =?utf-8?B?RC9WMFVmeHdyRmhNZWJjbFVRZHBNcEluMUhkQzJ2bTF3cmZ6TDNIelpkNTVN?=
 =?utf-8?B?bFkvdStsdGhJcjhHK3Vha3lEK2NPTlI1NXArY2JPaktHWittVng4UVpNa2do?=
 =?utf-8?B?UVlKQTJqV2p6aisxMDFZaE1xU052WkU5YzJJTTVBSEZlekNZM3hraU5FTnJu?=
 =?utf-8?B?bUorZVlwa2xsZlJOSWFZcXp2NXR5ek94Tk9HVFNZRkN0MkRrRlFvbnAzSE1D?=
 =?utf-8?B?NGExKzJUVnMwSk1pcjRXMTFQd01pc3JMVzBzaGQ4anFVb2hEbVRvcVIzWElP?=
 =?utf-8?B?V2FLRGlrZkVDS2g0emsyL2tVZzhjM0Q2Znp0U1RkNHdnRnRGaENHTHFCeVZE?=
 =?utf-8?B?NEJJRWY4UXlxUDdTNG5YVzgzS3hjbStEVlRuL2VZM21ZUFBoU0VvVVI0ZFRp?=
 =?utf-8?B?cVoyRmxISHUyRGF5c0RuVTR6cDEzYkZUNk9LOTUybkdiaVZ1ZWZXZ0ZjdHpY?=
 =?utf-8?Q?FcZoBIsQXvlTmCNbOIuPJjvkV+CUheLKTjrvbH6nrfVz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70fcae7c-e02b-4d0a-0789-08dde0b0362e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 12:42:38.8355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NT0QAq843MEz7SIVirlW5Xyo00E7BaQBhAzxa31+B+GP/+r9C+Vz7WtOPUrULX5+ChCPo4F+bZrVzsaDXFNDLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961

Basically a resend of the previous version, plus fixes to build with the
MSRV (1.78).

The first patch makes two additions:

- Bring an equivalent of the nightly upstream `Alignment` type [2] with
  an identical public interface,
- Add a new `Alignable` extension trait that provides a way to align
  values up or down according to an `Alignment`, and implement it on
  unsigned integer types.

The second patch makes use of these in the Nova driver.

[3] is recommended as a dependency, a small cleanup preventing an unwrap
upon applying this series.

[1] https://github.com/rust-lang/libs-team/issues/631
[2] https://doc.rust-lang.org/std/ptr/struct.Alignment.html
[3] https://lore.kernel.org/rust-for-linux/20250808-falcondma_256b-v1-1-15f911d89ffd@nvidia.com/

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v4:
- Add the `generic_nonzero` feature (stabilized in Rust 1.79) to fix
  build with Rust 1.78.
- Import `core::mem::align_of` for older Rust versions (as the patch
  adding it to the prelude is not attainable from nova-next yet).
- Link to v3: https://lore.kernel.org/r/20250812-num-v3-0-569d6fe1839f@nvidia.com

Changes in v3:
- Move `align_down` and `align_up` into their own `Alignable` trait.
  (thanks Miguel!)
- Fix `Alignment::mask` implementation to match upstream's.
- Add missing `SAFETY:` comments.
- Improve grammar on a few hard-to-parse comments.
- Link to v2: https://lore.kernel.org/r/20250804-num-v2-0-a96b9ca6eb02@nvidia.com

Changes in v2:
- Remove `last_checked_bit` (use Rust's `checked_ilog2` instead).
- Port Rust nightly `Alignment` type and extend it with `align_down` and
  `align_up` methods.
- Link to v1: https://lore.kernel.org/r/20250620-num-v1-0-7ec3d3fb06c9@nvidia.com

Changes since split from the nova-core series:
- Rename `fls` to `last_set_bit`,
- Generate per-type doctests,
- Add invariants section to `PowerOfTwo`.
- Do not use reference to `self` in `PowerOfTwo` methods since it
  implements `Copy`,
  - Use #[derive] where possible instead of implementing traits
    manually,
    - Remove `Deref` and `Borrow` implementations.

---
Alexandre Courbot (2):
      rust: add `Alignment` type
      gpu: nova-core: use Alignment for alignment-related operations

 Documentation/gpu/nova/core/todo.rst |   1 -
 drivers/gpu/nova-core/fb.rs          |   6 +-
 drivers/gpu/nova-core/vbios.rs       |   4 +-
 rust/kernel/lib.rs                   |   2 +
 rust/kernel/ptr.rs                   | 219 +++++++++++++++++++++++++++++++++++
 5 files changed, 226 insertions(+), 6 deletions(-)
---
base-commit: 062b3e4a1f880f104a8d4b90b767788786aa7b78
change-id: 20250620-num-9420281c02c7
prerequisite-message-id: <20250808-falcondma_256b-v1-1-15f911d89ffd@nvidia.com>
prerequisite-patch-id: 2439f5f9b560ee4867716f0018b5326dcd72cda3

Best regards,
-- 
Alexandre Courbot <acourbot@nvidia.com>


