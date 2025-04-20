Return-Path: <linux-kernel+bounces-611901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C748A947CD
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Apr 2025 14:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC456172DEC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Apr 2025 12:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A872204F67;
	Sun, 20 Apr 2025 12:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZKNTWKg/"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D25204C37;
	Sun, 20 Apr 2025 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745151637; cv=fail; b=cFiTlR82xHp5+YmTKPkX9Ge2Sb3/zVjXUuyfTfx/HqpWXHpwXaLNPAF7g3kFR0WNkp7knksDdgDq9neXw5uwVY9jXvZLnCIFSQyepmZ/V/svmKBdKTCtRaSx4LWkYvWGRxYq8GTlW7dBblsczDlqT519DcXc7JLUyJty0Pq3OXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745151637; c=relaxed/simple;
	bh=JWpq+xFF0zL5IlDXU/L0kA35dJT8snLPFffTr6LlfCs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=m3YKD68kXRgw5VNuRkVwjyvCZPOGpX3VlfPCQIm55Wy+aZSwDnmTjGl4Lh/1j15IQUgR8jvsPgZNGaJI3rPjJutWs2k5pxg74U2GEZ98vqBP1ODJmGnDFcrU7FC0/0hTCDmhm3ojhknYN9BjqnbRLpnek2qVVZI8cfyOItHqQKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZKNTWKg/; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHBwyCLvzJhrqUpd8ZiWjmBAJT1gmQH3lAm7ycJSZpoTqhy26dB+3WwVvXtEpvu6xpD3AkryKbNeu17ku9TfHR8R5us58xbmJ6mjrdAvngOYWSnUU6lKhtaVEmGJVM/lkoIGJnIrPLo4ntdjKevBqK6PC1MGwMDfuCyxEVZIJhYI5faNY+OsgopUZDMaQeTXybODpGquSOk3z2BCV94CCMDwBaZduRkPpMJWzymsy+OferM6eFk+X7ncjeJKKg5wNOHOxC3H0bH6+dOJLVGRHXfjrWrqJNu0embATKkSQ5GgBn3dxPT04sBWHMtqtb74KqhsS84ZLFsGGYZHO3r5Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5FJr6TqC+thTrSaiMokRQlX+sdQC8KOP+HSJriL4kk=;
 b=FSseXgK2USfUJRwodil0q5I30kwm8ZG7/zxBJlU6eFqwz1r5qSmsORviin+j/bXbjhVlhhU8M9y1qFD8E85bATXzQYdLf3HDvBx5BjuUWAQc4eS4MN/dPuddrbB56P0dzU5nAUCcQ0f9PIUvjsMVtBpublefskWBnkjxJ8/B31PbG6ErzNYrCyn79VKashibp7IojtCHQQT6CGQr9Psk2TMYLbiJCQRVnmYz+4e9n/hfB8MvOh8uftR+wnzF5n8h8Su6Ncfmxx7wa2QKXD4fwQsADXPqC3ImrL/HZ2sE1jBEm+8jeVt3Bd6qUfYyo90HNm3ac+gWMg9tjZ0rWGlBfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5FJr6TqC+thTrSaiMokRQlX+sdQC8KOP+HSJriL4kk=;
 b=ZKNTWKg/fn05QKNC56L2d5Qwg1VWEjH7zgRxdAAtzzw9Crj4zvEfzXsrebpIDslyQJPrAsbf9Qnvz23wSaRrO1l1ScWPHZwEbdZobLlW6zfRQr+dID3sX6b3R0umaXsDcfOtp7cauVDOS2Jbgw9sSM5RSJ5VDgc5d7xVrSh4iI+Y5kNKq68s30QGfVgGNbBbe/R5Ccmdszp7g95pFps1QmG35Ww8AMibDUPh7meVGXSeBx5PnApgWVIGYFgHJ4uhAss9/kdlFOuGVk/anAjVdvYMxtLIAH0YzWtvRgaWt/9Td2ROjN53qpozFwpWPt4BfX37CliZ5OFB6pXmrwiMoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB9175.namprd12.prod.outlook.com (2603:10b6:510:2e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Sun, 20 Apr
 2025 12:20:30 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8655.025; Sun, 20 Apr 2025
 12:20:30 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sun, 20 Apr 2025 21:19:44 +0900
Subject: [PATCH 12/16] gpu: nova-core: firmware: add ucode descriptor used
 by FWSEC-FRTS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250420-nova-frts-v1-12-ecd1cca23963@nvidia.com>
References: <20250420-nova-frts-v1-0-ecd1cca23963@nvidia.com>
In-Reply-To: <20250420-nova-frts-v1-0-ecd1cca23963@nvidia.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: John Hubbard <jhubbard@nvidia.com>, Ben Skeggs <bskeggs@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: OSTP286CA0071.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:226::20) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: 187154e3-1564-4ebd-d0bd-08dd8005bdc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1piczJKV2JPZUdtWnJuZHB3M3hIcmRDeEd1ZjhWS0thdm54QzdDWXl2K011?=
 =?utf-8?B?a3haL3JTOWNKVmV6V25VS255aHhUNzBVZjk4RWswWi8xNDJUOHZvanJJaHB6?=
 =?utf-8?B?dDcrRXoyS0lZUHlNWXhRNEVWYXBRQ0hWby9VNGJpWkxKYVdFQXdSRkV5T25w?=
 =?utf-8?B?Z3pZMjNRRGZWbEZTOTJyWkNid05QS3ltVVlQMEFMWjNCNGdLeEJGU1ZtMUVr?=
 =?utf-8?B?eE1xZFlHcHk4OVV4WkVOdVRBV0FnOEJHcUd4RDdZb05UUlY0cmZQb3V6KzNP?=
 =?utf-8?B?Q1VmbDk1RFhMdzRzUkZ2NVlEVUp6eElsRldzd0prWGhNRUU0c1hjWkJudlI0?=
 =?utf-8?B?MWowTlg5VDlEclVNQWJZclVkRE5WeGxzM1RWZjc4dWNhcGU2ZC9rV3VvQmlL?=
 =?utf-8?B?cWwxVW5Yd2thODJGMyttbTdTVmpnZmN5blFhNHEzMXh5Z2JyRXpSbUdEdldL?=
 =?utf-8?B?MUdvYUErdzI4T1BOQ3h6ckZxQ0RHd2dBNE9SM3FSWXMyTzJSSW44aFRLV2Uy?=
 =?utf-8?B?NExQVlhLVTFzUk9MNU90YzJqdlhXdDQ4ZzlWS2FuQ2JEb1Jqc1l5SGVnV2Vz?=
 =?utf-8?B?ODFFWWN5NHRwRTNneWRPOS9DNEYxSmJ2enN2Qm9XVlZudHpEaWI4SjN6NkFI?=
 =?utf-8?B?aFliVHBzVTdKOWl6R1ppQXBJOGN6TTNudWMvcFFpa3dIdS9oK1JoVUE1Y2Zh?=
 =?utf-8?B?K0gzaktyekM0b3RRZGEvOElNZ2h6SXFpdm5JeW45aWNqVzArc3grN05mL2VE?=
 =?utf-8?B?U0U0OVB1cXo2WjZkQm9YaGk0U20zNm9TbEhJbHhqQUZ6WWI3eUtUN2ErVkVL?=
 =?utf-8?B?eVBjci9xNEN1anhpZ2l0ZkJ5TUxoTXFhS2JBMW01UEgxZVZuUWx0VmlmWmxu?=
 =?utf-8?B?bGxXR1JtbVVWcG03RE5qdlhUbjVoVXc0ZUZlZm83d3M0YVNzQW9WOUEwOHdl?=
 =?utf-8?B?Sll2b0MyazdxYTJnQzhrTVo4V1kweDl0OG1raFI4NGFRVUFocXlCRXkyazJr?=
 =?utf-8?B?aUxDdTcxZzB6bUIzQUZFc3FkT2duNUFJdERuT0hMWkk5RWNlWENoeVVVaUJD?=
 =?utf-8?B?eS9Tcjg0SUxvNldLb2pYbk5DVndwdG9MZ3E5a2dIVVd1R3NiZ0wyRDZOODBN?=
 =?utf-8?B?OUIvK3F2a0l0dnhZTjV3Z29vdkFNRFBPc1QycGwyOS9PT2JsZnUwcEhBV01r?=
 =?utf-8?B?cFhqenFTNEo4dGRqVWF0K1hZN0h5QnV3SFJQTVlpcm05VVhEUlhaMDI3Z2pU?=
 =?utf-8?B?dEVmYmNMSXhvUFJOOHFtZHYwNVA1RmNPRm1nTGdHd1pkS2RaZjFKK1F3RFMy?=
 =?utf-8?B?SElldURSSnNEbHl4K25uVFpNam16bVBsd21OMEI3eXIxV2p1eEtidHZjbGZv?=
 =?utf-8?B?aVM2MlRkWjdHbFNSOVBwSGZoTmhWQm40b2FZV0s3b2QwOWw4MmY2WDRHQ1Nm?=
 =?utf-8?B?WldtTWMvcTVoRkFkeG1XTmdBSjRIUFdhaHZ0Q2dGTnFvOXpjMmxyQTlZZ3pT?=
 =?utf-8?B?WkgzODA4WTZKakl1aWZtK3NVMGdZNFNXU3pNMDUvcEYyb1dmTStmWUFHUUhn?=
 =?utf-8?B?M3hwa3o4dGNJWHExeFZmWm85NHl4eDErOEowRFhmazZZTmFUemZBZEZ2ZDNJ?=
 =?utf-8?B?bFZ4b3pPKzdlYjczYVNlclNjRFpVREQraS9lUTR2UUh0R0UzS0VNaGJkbnNZ?=
 =?utf-8?B?eHNFbUtRYlgrTjlGR0JUQjRsZi9rVEwwSGN4R003WU5VWlBKclNxSXVjaGJa?=
 =?utf-8?B?TUUzQzVZM0NtRWdySHp6TW5rVEV6TWU1TWVSTTNwbXFrUGRCK3lFa3F3OHZD?=
 =?utf-8?B?My9UZ21DekVmblc1b0VHZkxhcGFTVEhNbFIxN216dTV6Nzl3MmxVaFMvQUU2?=
 =?utf-8?B?cDFqSkkrcEFHVjRNVHpxTkh0dFllNllUbEdrQjRvQmdDTWhKK0srN2IvTUFM?=
 =?utf-8?B?Q0I5amkvOFByNldGS2cyd21wK0Z4YTdMcGdRdDRrbVlsaHAvaitGb1Urcytz?=
 =?utf-8?B?dXJiUU4yNUV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODU5b2Mrd2VsMVl6eTNsU1RKZmVmaVhzVUJnMmtYUThqR1FQem13ZS9EYWEv?=
 =?utf-8?B?RHVGZS8xblJoUjBiOEE0QlZwSGJNWGJuZFVLK0xBNVlnaXIzWm1CQnI5aE9v?=
 =?utf-8?B?N29vS2pnOHA2VStFZklnNXd5bldrN21FZFhBVWk2SERVSExvZ0prMWRaUmw4?=
 =?utf-8?B?dFFMQVc3YmVQMGpiOWd6Yzh6UVREZVdpd3c4SDRFTWJSMDJiMGEycVdYcEJz?=
 =?utf-8?B?RExXQzc2aFVFUUNnL1pkWDZJYUsyazJ0Zmo4ZlpUWldVVlFlcm9NaEhRYTNj?=
 =?utf-8?B?dy9GRFQ3SEwrQzROV0VSNXBmWkNGaGh0cDNmL0xYdGNZSGt4Um95bWFLK2Z4?=
 =?utf-8?B?bytMalV6NEtoYTRpdWsvam4xeklxWHJhVzlZTUozdDBqY2lieWJnMkN1QmpF?=
 =?utf-8?B?c3NrdFFuZEtFcnZjMGxDTmsyeEs5RU4zSlR0YzArTXEwd1ZNaDBJTTZIUm1R?=
 =?utf-8?B?SWZFNmo2U0kxUTdpU1hJMmVEVHg5citJQzdkQU5kVjZLcFN6blIwK2Q3L3lk?=
 =?utf-8?B?Qk9YT1JyRFdFV2s2OVErdUp5VkRDQ2h1WENzWEErVDRtTXROaGx2Ymd4SE9Y?=
 =?utf-8?B?eUlBSVN3NmxKbi9YSzQ0UTR4eHdTKzBmL2VyMG9GM0hYWUY5eXJzamhERkVZ?=
 =?utf-8?B?elhYeUNFcWlkbFU1S1k3VlExM2Rrcjl1UnlqRHBpUUJFb09KNkdmUGxMZDd6?=
 =?utf-8?B?VzhzUFFKUHpXbmFhWGNheGpoSWpOWUZ3bmRORTFOMm5qekJVQUxLclM4V3c1?=
 =?utf-8?B?TlVGRXBpUWo2SkdVV01WdVdUMjBPQkIxdGdEUHg5MVo5eHhyd3VwNWVxdk1S?=
 =?utf-8?B?WDRjTjNhaENrdXJWYktseVRKN1o4b2JWUFhwdHVrRnQyRERPWDlxTzJnN1U0?=
 =?utf-8?B?aitwdzRrWGNnY3UrS2VldlpEM3AxWitiTDRvMlBBOHNWYjFnOGY1eVNFamhu?=
 =?utf-8?B?UlBlNmhyWkdWZDdzQmY0bjRzTVpaL2QyUG40ZUJJNDdodGlxb1hqRXVXNTZ5?=
 =?utf-8?B?ZGs2YmxvRFhaQWYvMzJMQ0RVNlo2NXRVdENLOUJoZ0Eya2JIYmdOTWUza0o1?=
 =?utf-8?B?RG1XeVBzTFpYTEJYeHlTNTRYQldHZ1cxSDBaKzE3ZE8wQ0hVRWFwZ2F0bEVa?=
 =?utf-8?B?TnVleDZBRTkwKytnMlN2Z0hoR3U2R0UyOXBTTDdTVmpHOVhiSlJvb1hCT01r?=
 =?utf-8?B?OERLWHJKcnA3dDVxQjI0SHRtaWYvdHNBS2pUY3ZPRzdJeUxjZ25PZ3ZlTW05?=
 =?utf-8?B?TlMwcXpBL01jaW4wZzlIVDMwT2JJd0xSNUM3VDdQT25ZTkFpS05JSzkzYmp1?=
 =?utf-8?B?OXBRNVM2cmRnbFdWRHltektSc0NXNWpxaEdXa2JyVlU2dTlxL2loVzVyRkxv?=
 =?utf-8?B?cXVoUHg0cW1EVDEwYnFUWm4zWFZOMjJsT2VBZVBncmF5dy82WWNZY0dab3gw?=
 =?utf-8?B?Z3hKd2dsZEdIaDhsdUt0U01XSFEweGhIRTV6OFhzMjN2UG9tM0ZYRW0rMjYz?=
 =?utf-8?B?a1FpQlo5QnBONU91a0lzMXZIcEloTVpiWU5SZDA0dFozZ0Q4dXUzNVgvclpN?=
 =?utf-8?B?cnBjOHBMbjhPZk9McGpmMjk2TzRtUFF3WWVHckUvV0xZT0dBRmJPdG44Z0Zq?=
 =?utf-8?B?K0VWTnQyYms0Mll0bHU2VWhIYkxob1lBRVA0OXhHcVZESXVLa3BRa1lJb05i?=
 =?utf-8?B?bTZSem1TVUJSVW9BWXFBK2FmL2ViWVF2cTdzZklPT3hMNml4dkt4ejdNY0V6?=
 =?utf-8?B?UlcxeE5HdWpYRGJKUklRQnRkbURyWVc5THpQSERSMGFLSFV6d3ZmSHdCRW5J?=
 =?utf-8?B?d05KTVkvbTdZdVVTRlRxR2c3NzZaK1ZZVmg1czYvNlVkeERDNWNneFlxODdy?=
 =?utf-8?B?MWhiVWdmQkRmSEVrM3RZWG44TmxLSEV1c0xpNkRqTGFZOFBGU01lUXJtZVRO?=
 =?utf-8?B?OFdSRHhQWGYxbnVNV3FsUmZTMzVqazNEaU5ROGVxWXhLVXlaR3ZQT2lISVhu?=
 =?utf-8?B?Mmd0b1JwVCt5M3kvYmVsK3MySDhndjN5NTgxODIwemF0bFhSUkt3bmJkZHVp?=
 =?utf-8?B?QXNsZ3FpUE5nY0Ftc0FVWUV6T3orS3lUamZ5clhGWG8xWHpiR25kVW1ITWIx?=
 =?utf-8?B?aVAwajJlanRYeVN3V3JtU3l6VVp1NTlrbVl4ZlZkZmtGajVCWnlJM3ZiRHZi?=
 =?utf-8?Q?4MrGJJmpZPSxnMPVVDNs0frIf8cARqcq4kvcayIdhklE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 187154e3-1564-4ebd-d0bd-08dd8005bdc6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2025 12:20:30.4730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGnfzIRjSiPfPh3pACH2uepttDQSXcBVOL9+BMR21PIi6wQAyxutSATQ/cK1O8Ylb/nC3LVByERxWXJSN3xeUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9175

FWSEC-FRTS is the first firmware we need to run on the GSP falcon in
order to initiate the GSP boot process. Introduce the structure that
describes it.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/firmware.rs | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/nova-core/firmware.rs b/drivers/gpu/nova-core/firmware.rs
index 9bad7a86382af7917b3dce7bf3087d0002bd5971..4ef5ba934b9d255635aa9a902e1d3a732d6e5568 100644
--- a/drivers/gpu/nova-core/firmware.rs
+++ b/drivers/gpu/nova-core/firmware.rs
@@ -43,6 +43,34 @@ pub(crate) fn new(
     }
 }
 
+/// Structure used to describe some firmwares, notable fwsec-frts.
+#[allow(dead_code)]
+#[repr(C)]
+#[derive(Debug, Clone)]
+pub(crate) struct FalconUCodeDescV3 {
+    pub(crate) hdr: u32,
+    pub(crate) stored_size: u32,
+    pub(crate) pkc_data_offset: u32,
+    pub(crate) interface_offset: u32,
+    pub(crate) imem_phys_base: u32,
+    pub(crate) imem_load_size: u32,
+    pub(crate) imem_virt_base: u32,
+    pub(crate) dmem_phys_base: u32,
+    pub(crate) dmem_load_size: u32,
+    pub(crate) engine_id_mask: u16,
+    pub(crate) ucode_id: u8,
+    pub(crate) signature_count: u8,
+    pub(crate) signature_versions: u16,
+    _reserved: u16,
+}
+
+#[allow(dead_code)]
+impl FalconUCodeDescV3 {
+    pub(crate) fn size(&self) -> usize {
+        ((self.hdr & 0xffff0000) >> 16) as usize
+    }
+}
+
 pub(crate) struct ModInfoBuilder<const N: usize>(firmware::ModInfoBuilder<N>);
 
 impl<const N: usize> ModInfoBuilder<N> {

-- 
2.49.0


