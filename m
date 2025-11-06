Return-Path: <linux-kernel+bounces-887900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D76B4C39561
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 08:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5E14734B79D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 07:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66AA2DCF47;
	Thu,  6 Nov 2025 07:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BAbxmAcy"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7692D7395;
	Thu,  6 Nov 2025 07:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762412889; cv=fail; b=hgZusH1jsvw/e5tB2FElEEnZ2RokGOmlTOEYbbBeyx2niC0YgCV+69Myuhh8dOfoGE55gR1bAsEQRD73tU367TswYky7ebobAuVClDQDU/YMt/oxBXbA6rUL+A0ed5i/dKY046ABujY8qSw0FLV2HDEjUbZj5mO8kEFy9r0FGoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762412889; c=relaxed/simple;
	bh=AseZ0s16BiOLtBdi//ubLy3sSidWub2ncYy2D9Huy7o=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=FPDO75RxWNmIURUOcCBvYp20OytiWvEpSku4AQ0OcLdihG4WzeQuDWnUDOvsK+JmoAfC5SzO8vytB1VQ827DQOkQb02GKo9tc3cjd3u7c2tV97OzWUTVaHCCU/bLru6QsYre5tEYzkC/mgEKZX7sdfVRt2Puoh4uKUdyD2kTc28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BAbxmAcy; arc=fail smtp.client-ip=52.101.85.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rH7zsH06Fe7tE+8thb6x0TOyjJuRjXEkGfWGO6Vixt8lARr9bxZmTPoDrwlKbKkxlZEluP5vsR9wuMg4TuPAj1gQBdsgPcln9A9FXKpVygEuBecASzeao30sUqMi0XAYl7qT1IKEyPrz2Mhbovp5kAF3lJlgeNyDUt1q9ZH4QXFlQYleQP3fZGdMlwIgvM1WCGy8ZtkA6D3kLXzdk9O8dhXgIkN7Rg8RW40d6wVe9iEX5RbOjG6UZ75DOONEjTWWwBKxBRrmBLpWuw/FeTXJ2udi8PWHEoul2lVWuU93aw06PXyFlZeP25vXne1Blv2FY7QQsc9KV6E4RqssOOJLzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7daY2cb5xEZpBs20em13XEvABQhEiKsmr+q8fSVFtA=;
 b=aT7aUR43oFaOh6lAQW5uexMC4sb/SijaCLfiEU5bCBR+eIacSt1ZSSWLl8bIdLzTIkvQQmb1Ah5rncho48hEH7TQXScM28ZCmjG6stbot4LeQhMslOEvyuVEaWsveQb8v4CPBAAZE9I1b0aTIdj6SGDJP/FwPH2Larsc/yjVqB+XvC1XaBgbd9J9fdkFF7jL2WI9a6nvGu7OWagDbZ8d3WO2CC/CHrJIjFEVXlEAaLKjj7C552gsH4X9SLu4QXk2rV3/2I/XjVOBcwNkxGg4bdbVP5yRwoOPzv9K2IZ4DPSmwVj6VzKt/iEnaSsr2rX5k45Fx5PJiC88Ma3urq7V9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7daY2cb5xEZpBs20em13XEvABQhEiKsmr+q8fSVFtA=;
 b=BAbxmAcy6L+NrymJ6ycyz1YAVoj74BjJ05pax4MZCvK6t3aAibdwjROXRgIwmYSEP04r+wlUjxiw+TOgIZCxQNqwrA1qD/OYkxoQqpway3jLNA09+l8hWYq8wsRUd7UOe4t+/S2Wa2v7IHQRpR+guCQufliexV/ciyxIpeEYHVlR2+ARq5hrDm99mOv06flkhr7zGClQtt1DEQb8clhwif+E8aCSBJnGPc9I4Z9vgguv6cN/2tXoZ9A2IPzjcm+jBZWajSmm8TjMhHMuU5mSCd7Ewm0IrUzDCp6bcql5ujW3NVczfnMoEsLdD7goIgNgknLTbAEXChru+OzThWiZEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA5PPF7F0CA3746.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 07:07:59 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 07:07:58 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v3 0/4] rust: add Bounded integer type
Date: Thu, 06 Nov 2025 16:07:12 +0900
Message-Id: <20251106-bounded_ints-v3-0-47104986a5c3@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACBJDGkC/22OywoCMQxFf0W6ttK081BX/oeIdCaJZmFHploUm
 X+3owi+ljdwzslNReqFolpObqqnJFG6kIebTlS792FHWjBvZY0twRjQTXcOSLiVcIoa0BRljQt
 PtlIZOfbEcnno1pu89xJPXX992BOM15fIfooSaKMRK8Pl3BTki1VIguJnbXcYxU/KwR+KLDYtz
 hl9De/U2E/2vbn4om2mmR3WTOSY8V8Tfj4dqZrYtLZqAF310RyG4Q7PUc0zUwEAAA==
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
X-ClientProxiedBy: TYCP286CA0117.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA5PPF7F0CA3746:EE_
X-MS-Office365-Filtering-Correlation-Id: ae92557c-b568-46c3-9b49-08de1d03374c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHhLRWcvdFFTWkhsbkoycEd1YmpmQWFHcG53RzJFaTI4ZWlmY21GMGV3WVVL?=
 =?utf-8?B?RUxpcDJuTnAzMW1yNXV2NC9ObHl6bDFPVjNka3E0anllNGNxY2NOSkd2eTNQ?=
 =?utf-8?B?K1ZQR25DZlVLdXVyNm8rcE9tWEt1MW9JdytKOGZsbU5tSjRzdk8xWmNwU1lw?=
 =?utf-8?B?d2NoeWRqcTFKUG9wblVuSS95TmpreG5CU2RWYWJvQ1RXQzVVZzN4V0h2dnBt?=
 =?utf-8?B?ZVNHcnVEcWhFRXcrQkkrVDFuT2J2SXA4dFlVQjNsQnZ5c3lNODUvWksyZGNK?=
 =?utf-8?B?aDd0bFhaRGhLaUJuN01lM0ZTLzRGSVh5My84Y0kybzIyS09yekxjdTFsenlT?=
 =?utf-8?B?aURxVm9LQ2RtU2Zxc2ovL0x5UFI0elZ0RFlZWWhtdkx4L0dJZ2ZPK1BZNnBu?=
 =?utf-8?B?WmpOeTh5MURueVdGa2NvWHRPNWx5cjNGMHhXaEVaY3lCUm9rVGdFQ3R0ei9i?=
 =?utf-8?B?OTNzSXM1UG9BMU95aVFEV1RNVFhZRnU0T3ladTFiUU1GUlhVanRWS2YwNFl1?=
 =?utf-8?B?OUk4WjZ3bzczNGJVT1hRWW1ybVlidzdabU5mUzhrVkhwUlFmVFFNb2VRN3ky?=
 =?utf-8?B?TGJJejNpSTJsc0FNaFgyVHdoNlEzejYrQmZLSStPeExydENTV0NrWDdEd2dx?=
 =?utf-8?B?YnZpQUxNQXd0RlVTYTlOUUVsYTdMc0t5anVPVE1RTzFtSzNyb0NRS1h2S2JZ?=
 =?utf-8?B?R092SkhDVnJiRGRQRjVRNFl2T0NzQXl2aTJsTmtzUWQrbmV6NHdFLytXdnpI?=
 =?utf-8?B?TEhFRUpWUThXblFicXUrYjNITk1LNklSbGpqMklNZEMxSFJUWHY4NHdEeGEv?=
 =?utf-8?B?V2xEOE0zbWxtNExRQmR3K2Y2eHcwWWRCUnJlTFBXYWg5bGxNaTczemZLNkdJ?=
 =?utf-8?B?azQ0eEFScitXRHM0Sm44SFRxSVNsWjRTQXlIYnl1VUIreTZIZW43MkxFZkQ3?=
 =?utf-8?B?RU9NY2FUVXdCWERMK3hEWlZqNXVyUFBjc3NITmxCSXZ3djgvRy9IblF2N1dD?=
 =?utf-8?B?L3kwUEZPVnNkRUJBWHZmRXhoS3FMVzE3endRVENDYkdMN2puMUhjbjRpZlNN?=
 =?utf-8?B?Rnl4QTJEay9aNUEyZEl6WThVaGdvUU9lcmI4aE4zenYyczJDYkRrNXRIS1RU?=
 =?utf-8?B?RzUrY0tHU3B0dk8xOXJoYjBvWlBkY1Y1OXBlL3VXczl4bWc5b1hMeEhpNm5S?=
 =?utf-8?B?Qk1KbHBnamhyMERKaUFjL1ZHMVY2NHBSRU5pQUh1aGh4SmRxWWFSQXplK3d1?=
 =?utf-8?B?eFlqQStJd3ZIa2NXZWxHbnNTc3NXSnFRcFZReVRJVGsxcWdIcWhNNm9mbU9h?=
 =?utf-8?B?N2RIOGtXdTJ0OFNESDcyd21EOU0wSmd2aGxnSlhSaUJBSXZUenkzZHpEeHJi?=
 =?utf-8?B?aVhFTFVKMnV2eEREQnZHeFVzTU1EakYwOGF6SDdoamovS0lRMXUvYmVtMkRk?=
 =?utf-8?B?OHZxNWFEd0VjRHBnMDNMVzFrRm9UaUlKcVZuNm52V205Qm43YVdROGg0Mk1Z?=
 =?utf-8?B?c0dCOXZudUxpVm4vYWJWSHlydHRSSFk5NXZlbzRiQ3dDQzBNQ3hrc2ZobGlF?=
 =?utf-8?B?aFZlYnJOcTNDbFpFUjMvak1pUmpybE9kR2NkRWpiT3FEUEIvY1gwQkI4VjlL?=
 =?utf-8?B?VnIwK21mS2FUN2QxY0xGUUJ4dmFrOGc0Q0dDdHZIa0YzRGRRMTdPcDNZeUwy?=
 =?utf-8?B?Rko3emhZTDVhVVVTVlNlVFIrUFdlYVBkU2U3RlR0REpjbThxL0FzK3U1SUs5?=
 =?utf-8?B?bVN0c3gyWTdWVTRBTHB5SWJHN2FZT0VxcmtRaytSd2JZT0lLRU1yaHZSWnZa?=
 =?utf-8?B?MVAzVW9IdjA4U0l5eXA0N0dSb1E0L1FCMndYNXFBOEtTYlU3Qm1oWnNzSU5a?=
 =?utf-8?B?dkphZkYrTm1tU20vYTRxS0czTVFVMHY0MWVObnBvcDU2M0NWMU80OVRVR3B4?=
 =?utf-8?B?SDBxbENONGE1NGJHVHlpa21IRzk3Z0w2TGhvckxNRXhYbnBNeGRXRUw5eUVh?=
 =?utf-8?B?L1dVVzI2M2RLU1k2d0twRlVkZmozckg3cnVaKy90SW1NRXVsVG5OZ3QxYUtm?=
 =?utf-8?Q?7mvYG+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTVIVmRVQTJXaWs3aEZVanh4Tzk0ZFBhbjVCSE1QM1p1bzZybWtYMGFqaHhU?=
 =?utf-8?B?Vjd1aFBlckNSM3YvT3NqVi9FQUdTZW9ZZ2lWaTBkTkx0UGRUb2tmQW9ESDY2?=
 =?utf-8?B?emIza0JGeVRUZnFNTElnQmRaL3NmL3ltWEJDTjBKQjdVRTZlYzRUTTRlRUV0?=
 =?utf-8?B?QVZxZXJHUE5qbldEeG1NRmdFaTBJb1liQmpDa09KL3J3ZzhYUWRPak95Y1Bl?=
 =?utf-8?B?QWZHbHJQSytCSTRkMElXWUdzdTlSN0JFS1h5U2FrYmt1ZjR0K1hYVUo4ZE9k?=
 =?utf-8?B?MXlWblRzUnhQd3RqR0ZOVjZsWHhCQitwVFdJbkVWaXlXZkRVRzFrUHc5OHdO?=
 =?utf-8?B?U2g3MTkvZnB0V2xiMGFnZS9qdzQ3TzM5cEpRSWphVHk5V0loME9Ia3Q4aHpS?=
 =?utf-8?B?My9zNDh6YzNORFNTYXVxSVVCQWJPRzdrNHBKTG9Jb3cwa24zVDZqWU1kb2Fz?=
 =?utf-8?B?SXNqUCtLTzhuN2lxNFZJN3Arc0p5YjhtZWZUTWYySGhTYlIyRFJ6SkUvNWxT?=
 =?utf-8?B?bXlIdzF5VUZEQzF4RTVJRE13Z2ZzR25UYXQyc0ZaZThyeHN3Y01xVEIvWWV1?=
 =?utf-8?B?T2FIcll5b3BUWHlSWFhvcjlMM0Yxc3lZaHJMSm0rS256eFNHVlJCOEFQVTNm?=
 =?utf-8?B?RGZ4OVRrYzZkYkFBL3NjQnV6U3Q1K3ZjTExmL05Za1FRVzBKMUhqamd5bndZ?=
 =?utf-8?B?ZDl3blV3WHRqVkhJdHJQNW43dkZQeGRvTFB5WlBqWXdBdUFMczNETUtTMnNv?=
 =?utf-8?B?M1ZSQWtrUVdNUTdOUVRxRUpZODE3b2hNclhJMk5ZeEthYkIxZ0xTWkl4U1Qw?=
 =?utf-8?B?eTV0bWp5d3RSVS9WblNqeldvV1UvSWxVT2I0MU9sN0hhTG5VSXJvOS9GNExY?=
 =?utf-8?B?UjZybkxnckRVenNIc1UyTHd0L1ZtQkJOWUtuVjhrcmRubks0ZnlqajFSSkpp?=
 =?utf-8?B?TXhLcjRBaEN0VXFtcXhTd0FYWkhpa1RYeU9aMkJKRy92VHk1bmdaOWhIZ0hl?=
 =?utf-8?B?ZE9NYXlmdndvaitlN3NLcUkwTDkwZFBmTGZZTVJKWmt3TGF5NGxaZHJxWWFa?=
 =?utf-8?B?UkZjekp2V1Zjek1PcGFvT2JiK3JHQWhwT3g4eUZEb3RvcXNVZVkxTkJzQ2ZT?=
 =?utf-8?B?QVRmUE1RSmd1S3pmMDN1MFExOXZVdUNNK000akkwOVM3NEVTdFFrWkE1Si9y?=
 =?utf-8?B?Vnp1TXJEcUJPWWM4MnFQbkJaWVM2SXdpSWRzNExZTmJCMlhyYVN5bE85VTdN?=
 =?utf-8?B?dUZPWnlyR0dMb0NDUytOeFhlazJJM1RFZm04OExCNDltYzlvb295Wk5yU3ZM?=
 =?utf-8?B?NkRvYVNIcXZqTXVPbFZKcnpiNTBsbnVuYlVaVUFaTkJ3Z3RsenNrbkhDSGp2?=
 =?utf-8?B?dUk5czdQYjlucDZ6QjFObUkydkdabENzbEptbUt2c1pjandaUHQzWFB2ZzZm?=
 =?utf-8?B?c01ndW04WTh3ZUVQNXFJMHo1U2pxNjJJMmdrVENIa0tMM043SEkyQndSVWEx?=
 =?utf-8?B?MzFpQXR1K0dtclNhNVBzVzQ1YzV0Y2t5Q05vZ0lRdklhNnpBa0xWeXVqcHN1?=
 =?utf-8?B?SWlWSFV1NHBERUZHOU12Q0Y0ZmtrRTNtc3htdEIraWs2bHJybUMvTlo0TUdh?=
 =?utf-8?B?Yy9ISUJtc2RJeUUwNGYrcThTQnJwZXpkVUVSZ3k3Z2RjTzE2dm0vQ2I4Y05R?=
 =?utf-8?B?MmJDa1NZRlJ6a0ZzUUhmemEwN1Y0azlPQUI0NHYzck55NFF0djNESWMxZUE5?=
 =?utf-8?B?emNFRTJERmV3NG52eXY1c1JBNjRmN3ZIRCtHTkZqMWZGSTdReHhJa2xWdFlH?=
 =?utf-8?B?dDVFLzJFVG80UXJKSW5qZnM5b2FVRnVTb0M4L2dtcjdCK1ArQk9YMlRyc0hm?=
 =?utf-8?B?ZXJXUVhuai9lSW50bTc3cGUxUElhdkt5UURZd1FLbmk1QUNyNVZabHQxeks4?=
 =?utf-8?B?N0RGODdKSjB3bkpxbkRQZUQ0N2FGbS9XZHg0c0Q0UTJFaDZUU1drV2FJaS9n?=
 =?utf-8?B?ZTN1RGJZeXVwNnVhbm1Pb0lsUHpYOVZiT2RsYTNPMUhSZHZrdC9uN3FNVHND?=
 =?utf-8?B?ditzTlhWZE5XZnhOQW9rMzBORFRxUTBzMWhFWVBBUnVSMmlqcnhRUzd6bXBE?=
 =?utf-8?B?aDNlQ0tPclcxYUovYkRkcno5dHE4TTlXajc1UlNkdUpPeU0wWnZQVHVCZ3R6?=
 =?utf-8?Q?MZdZcnxF46NTlHkyaqM3j3OgfJKchx5XBsh13e1fSfTV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae92557c-b568-46c3-9b49-08de1d03374c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 07:07:58.5208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCfOGGA2zErDQlVDcgXJMsyWkcwfvNPnVcUn1gAxw37oKTqbMPRc74oEIsSx0ONzgFipOmXjmULtlL2NIvEiGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF7F0CA3746

New revision, where we rename `BitInt` to `Bounded` and consolidate
things a bit. The `Integer` trait also exposes more common features of
integers to generic code, which makes it more useful - to the point
where we can now use it in place of the `Boundable` trait.

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
 drivers/gpu/nova-core/falcon.rs           |  140 ++--
 drivers/gpu/nova-core/falcon/hal/ga102.rs |    5 +-
 drivers/gpu/nova-core/fb/hal/ga100.rs     |    3 +-
 drivers/gpu/nova-core/gpu.rs              |    9 +-
 drivers/gpu/nova-core/regs.rs             |  139 ++--
 rust/kernel/lib.rs                        |    1 +
 rust/kernel/num.rs                        |   79 +++
 rust/kernel/num/bounded.rs                | 1045 +++++++++++++++++++++++++++++
 10 files changed, 1492 insertions(+), 303 deletions(-)
---
base-commit: ade19c5060dfa39b84a9475a4a6b05e2a8a2b3ac
change-id: 20251001-bounded_ints-1d0457d9ae26

Best regards,
-- 
Alexandre Courbot <acourbot@nvidia.com>


