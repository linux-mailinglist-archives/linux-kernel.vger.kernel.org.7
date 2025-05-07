Return-Path: <linux-kernel+bounces-638118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041D7AAE1BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 16:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1ED9B24C97
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 13:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDF228B7D1;
	Wed,  7 May 2025 13:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AJUW6iIC"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9DC28A1E7;
	Wed,  7 May 2025 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625973; cv=fail; b=UOQVnTmbuyU4tew6/S52go7WBeFvVhKrhCG+sSl4Jxyw11ci5oBY9JLi6G2A7smftzn3AgMF104VQ/BQxMbtJQ8lIElU639oT5V9H3TJwQ828UWebUnslGusG8nNTT+iXYHGhT36QXOuzFx9adzn4vyWX/YBxNVYWILTGud8nas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625973; c=relaxed/simple;
	bh=FNkMMSK4nk4ksPWRv0df1f0p10JKCv3J0c912JivkRk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nDufM7xBAEQdaJQMxnwJAV6JXVchPjkVJ5eKfxmwGwCrVU862s97EEcUJrp/P66TywnbK1Qa3kRJVRYSh+WJClqheUROu0kH+x8lGKjp+1R1trMQUt0cz4XBzR6gMSdsXTvDabYwESbynM2c/UxPkjs4yGj7uA5koPK4f2BnqhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AJUW6iIC; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UItmf7vGBr/SfpXD0oVauQlBXPO/twOVL0C9fw373ijfqrjjIaEWzYM/RGiAD0dXb1qdvF0qPyZrQtEbbffQvrUYJLgevx2yI4s/KCNu8dYkLYVXrko9/U+4oGXFPciv+LPDnw8HfKwnmZLqGGqt6yISbBlM2OYlo5bSrkcpWH3AZdOMikwwwMNZnM/YMDADxMROCYwf/PsdUmvA9q7ytFe/qPozOQ0jTqMBLPZ/jJqGu1xXLtZSRg1dffuyII2Pu45ADPhQ+1eL6ghLQGZgKejU0ifXGNFcQq4CVyJX4yj7fp6OioBl7NEj4B25aXAywHEoAQESoUHY2YIJ0fMaCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPTmwN0glf7WjhUerrKyJMaFvWRXWDbnYc+uvGNFom8=;
 b=n3G9u08CKvm3+6XCekOhHn0MMhgTLN/0++vkuXKWEkodf1jp42e5dN/c6+MmwnRWFa8AYCnHfILvxBOKRewvzvkaEZtiGR6lKh4ZXlEZjwaOYcBCfVUBKbsfdQZSson2+0UzCqAPoxXAHjzP2RxF6/WwBsSfxn8apM8py5oL4b55FtienTsI+F7mNdIpt+w8TgG9VEDTR66ReFsqEkhtipAzRAQ5aYdBIgTGDRXOIPfT6Va4oL1n8CgqwMzatWFAW3pFpplCKRKfveY5LUtxFekFA3cmoKAdbmiGwkrxFXIKH3y5qFqa1/Tfg3HmkdgYRpFfd+dbJnly7raBBns70g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPTmwN0glf7WjhUerrKyJMaFvWRXWDbnYc+uvGNFom8=;
 b=AJUW6iICy4vFk4rExh18Crn07pw0s4BSse3RuDp+I/Rs9fcbF9PvwmXzAhsolAb8nuvJdEjsQRw2uDl1Gq2+YUqXb76/cYpHnoH1Oua+nKLuxBd0MeJI9Lg7kdlJDh6T3lBgTMT5X4vAd9VUi5jRLqobBQJ6EvyXaeDoFzqBoWHkzVVHMJGXhYyqWmlSl3ySVGKo0DZjlGW2M7E8SsQ6PZ/HcH3X+a6PWEvv74IM/KJ/WY20ptLWcgOdnfy70YihAstfLkPHgSyZ+Nh54ZBW7FXbIU6KUa4FUuG3G9GoGKcwD+Ni7rMGukE6xHGkrf05NI/4iBXJ2p0Le2FrPr7opw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB6761.namprd12.prod.outlook.com (2603:10b6:510:1ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 13:52:49 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 13:52:49 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 07 May 2025 22:52:29 +0900
Subject: [PATCH v3 02/19] gpu: nova-core: derive useful traits for Chipset
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-nova-frts-v3-2-fcb02749754d@nvidia.com>
References: <20250507-nova-frts-v3-0-fcb02749754d@nvidia.com>
In-Reply-To: <20250507-nova-frts-v3-0-fcb02749754d@nvidia.com>
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
X-ClientProxiedBy: OS0P286CA0113.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:169::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: 709a09ac-f455-43e8-7efd-08dd8d6e740d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUZoOERiYk90QTB2ZlZUSGgvRHBhVUxrRU43TlBRMEVHK2dERW91SVNtS0tY?=
 =?utf-8?B?MVpxZkp5MC9VbGorZjRhOGNYY0h4SlZ3a3grK1RhREZLNEZaRVI1YVhteDNH?=
 =?utf-8?B?VWlaZW9lYWpvREZpT1lzYXA3eGM3WGRBY2pPRnEwL3k4SUkrUjJnVDlKSGE2?=
 =?utf-8?B?V09IRVlzMDNZSWZHdVF4ZjJGcHpYdnRRNHRSZzliTjJ5MlZNbkJMOEtSTW9r?=
 =?utf-8?B?SzhOSks4S2hLTm80K0RBOHZGTFFFV1Q3dUFLRnBLQW5BSG83ODRWejh5R3Zr?=
 =?utf-8?B?NHQ4Q1NnY3JJUkpWTHJMTDF4aENnSkFicVVpUlZhWDdIbitqZFRKV3Z1ZXJ1?=
 =?utf-8?B?YTV5TmNtUEcvU1cvUXRkeVp3ekdwZWphd1Vtc0ZRN2F1U2xIMWMxUmpNTUFo?=
 =?utf-8?B?Tm84dCtJem9JcXRPYzc5RGo0M3o5VENIeVVRczRpbjFkTmZYQkZyVmEvZWVl?=
 =?utf-8?B?bUNiVzJ3Mk9jMGdpblVUdkZyWFJ0UU1BdGdVT1JnVnE0WnlFZzdXSmhNTVda?=
 =?utf-8?B?TDFJeGRSd05WKzZXQkFHdGVmTGxyVUlsY09UYVUybVJBRmRDRlM5MHZlQ01m?=
 =?utf-8?B?MHVMOTBvaHhjTUJNYTlGdjVxdGUydUFFeXJZWmlOb3prUmFaWjlUTnFhcGIz?=
 =?utf-8?B?MjBrNjlmMTJCUmZ2RjFFUU1lMXcxaGp1OWZuUk9LSERGQXI0dkdwbzVWMnZx?=
 =?utf-8?B?S2JUK241WUhLeGR5UnRwQTBkWDlqZDZjRmc3VEJFYnVEeURFb0hGbmlQYld4?=
 =?utf-8?B?dE5rdStoOExTY3ZiV1owb1U4eS9xWDhJZ2wvWEFPeUdGWVRYZmEraGxUYkhj?=
 =?utf-8?B?TGlBUzFMdEFTLzF6OC9HQWphbC9nZ2dwRTRWbzJ2TUhvTUNVRWNYTkZoVm1u?=
 =?utf-8?B?ZHg0SDZNaHd4WWlqbmFLU0NHMm5Od1E1cEt6R2hiekpwU2R0eHcyeVIxWUs1?=
 =?utf-8?B?KytFS0hYeWJMeUY2c3g3MlM1b3orZHJyZnBMWnloZlBTekcvUmcybVYyeGtG?=
 =?utf-8?B?dWlWN1IrMzRsY3dSTjlrR3RySndIdkpSaS9qL3hoZGY4NFFpSGtyeXlRM1ds?=
 =?utf-8?B?M3hIUVZsL25RUnYvcU1Yc3REbHJSSW9ibVdJUHdSSVMra25QeVd0YjllUHVU?=
 =?utf-8?B?dkdNVkttaGhaekh2SDlvcDIyb2MzSUM4ZmJkU1d4YXdCdHhUMVhzaEpYRFZ2?=
 =?utf-8?B?QWkzRW14Q0NoTjZoTmpZaEJBek93R1lObWd2elR3SU9TT0pMeVpXWFNJdG1m?=
 =?utf-8?B?WlNCY1huYlpMY0RKN1F4bG9oaGVlT2lTSHdIWHJPSDFEZytodThqaXRQTThO?=
 =?utf-8?B?NE52UGJ3L1ExRHhLd0pyMHdzVkdwL0JtZXUwYUxtNmQ4Q29PTHR1Vmt4dG1a?=
 =?utf-8?B?Wk9hbFFyb2VkS0tvUGdDYU5aaG51dTZtVmpuUlNxWE5sQnd3SkxoemtKQ2hq?=
 =?utf-8?B?aytpYmM2ZUZDeVVMWW5aZElsWENneXpXWXpMRGo3WTdvK1owSmFMSi9TcGxt?=
 =?utf-8?B?cjVma0hEdmwyR1BacU0vNEtvYnJpYTNEUDMzZWVFOFFnd2lxMjdvNWl4SFFM?=
 =?utf-8?B?RlB1SU9ML3IrL0hXWnJNS3oxMUdHRTZBNTR5UUhzbWdBSHZRNHVWdUt4U28x?=
 =?utf-8?B?enJYUE0vOTl4YkpKZ3Fka1pUY3JNM3I2TEVSNUJiWlBkcE9VKzcwU1ZtL1Jo?=
 =?utf-8?B?aHcycEFBVXZYa1JtTUw5Y0ZHNXROSzdqZnU3dTVwa0VpYUZhbkp4WkZMbmlK?=
 =?utf-8?B?ZS9vMUx0WnR2cnlYWHNnV1dUOFRuYXo3VzBaWDJvWHNSWlF1a1JhMk1uaDhq?=
 =?utf-8?B?cHk0UVlvWGYrbnhBU0NySXMvTUpNNzJYMEdiNDZOVFMrTVZKSXgvaGxDOEFK?=
 =?utf-8?B?YzVxWmpLdThhTnVVTTZnN0lWTGZSWmY2M1hXK1J5bi9YY1JZTGxIb1VIQ2RU?=
 =?utf-8?B?cTNBZWt0bHFheVNmcWk5RDJmWlN3S2luMk5wN2JVQkJHcG9lK3RKNUh1WFNY?=
 =?utf-8?B?OWZjYVRLbitRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NG9yOUZSd3pEZmlGWG9oMWNlekwzOWlvR2xZZmxRRzE4VU9yVXcyYTU0YjYy?=
 =?utf-8?B?TUNDb0pTMndnT1lLaDhzK05iTVpzNHRWMmUvZW5kMzFPbTRNV0RhV1gyaDNQ?=
 =?utf-8?B?L1JxTk9jNWVBTzVFUXUyRjhWNTBVYitrNmZ4MW05ZzRoVEFISVRtV29tOHBv?=
 =?utf-8?B?WTNQSnJsdEF5MVZyWlZaY3RlSzIrNXVDUERnakxXTzBqSWVxVW5LV0xZNE9r?=
 =?utf-8?B?cXdYRGs2SFFpY0FXeHcwQ0hDRmJiMkFudHBpOHFxSDhZK1RZZ3VMTlRyOFY4?=
 =?utf-8?B?UnFZTjNMa1JBY0JKaGhYcCtDeVh1SG9Ka0hjQ3VKUVcrNjEvMThBaS9CRXBh?=
 =?utf-8?B?NHVCdmlBVHU3RUsvbUV2NDR2UDdMenNlYi9zVHJuLy84TllETzdseUxYb2VS?=
 =?utf-8?B?Z2NCSXZQWUJBSHdRSUdMbnQyQUQ2Y3NEMWtXTTJObVJPNFk0M3NrUkRBbkh2?=
 =?utf-8?B?TDBQMlNsaWxibW1TYnFocHJ2OE90elcyZFJTMk0zcWkybGZ1WXhOanNURmNS?=
 =?utf-8?B?NWo4RVhmRkVGa2kxb2xCSzdHL3ZTclEyMVA1SjNqeUZwRmhqVEhPbzNPWmhW?=
 =?utf-8?B?YmExZDdrb1NoTXZGMk4weHFRaGNQUXZqcWVkSitUZEJNeTZiNkdvNUhUcWF5?=
 =?utf-8?B?bHpMWWhJOURnYS9YZmR2SnEydkFxOXB1OHdOMjRKbjV4RzV6WWZjaE9iY2I4?=
 =?utf-8?B?a2Q5c21TVGZYMm1VS3dZY3pwSFNvVk04akUyUHdUQk92czlKd1RqTzdUMUdw?=
 =?utf-8?B?RkdwK1FHbCtLMTM2anJGZWdPSjEvZThhN1dha25vdW1zR0d5RGVWbHJWb25w?=
 =?utf-8?B?RnljWmc5U0NwNGhSTE92VXJwRDBmb0krNDllbWJpbG5zUVVkMDd3dXh5Smxj?=
 =?utf-8?B?WUVTc2pnU1lsSUFGaFp4RHE2N2EyQkxSNVo4RkxnY0xUYUtCenlMOXBtcFFl?=
 =?utf-8?B?S2JIanV2bFFkR0RpNytTczZOTjNScUZ2Qm1xckVnT3Y5QUxhME5neEo1dm5F?=
 =?utf-8?B?M0NVeTR6TjkyTzhlNEVESE9zbXpBNDVLV01GYWliTnZOYk5GRjhJWmQ1cmVF?=
 =?utf-8?B?RHRabXZjU0lQOVk3amVlSnRKanNBWkVYbnRSM3I5dkdxUytFQnBKWmJZQi9M?=
 =?utf-8?B?VDZ0NFROenR0b0V1azN1WEUwOGZuVUhYd0hxZ3Y3RDNZYUs2eXFGUjg4K09z?=
 =?utf-8?B?djZOT0ZUMXFBcll5VVd5TUVwWEZHdW5jYTV6LzRXY1JUNHB3UE5ONHlqaGx5?=
 =?utf-8?B?c3Y3dFVQaDM2c1lacC9oclNvdDB4dUdzZjVmVnhsblFJeEU1ODVUWGQ0dkE3?=
 =?utf-8?B?VnhwTjVFUWk4d2dDWEk4T2k1b2Q2SGRHLytTY0kwaFBma09FVkU0RmlMclBG?=
 =?utf-8?B?bmY1a3RmUU5vdUNEM3NPRzkydHlJTTNTR1c5TTFXaEVnTmg4M3FzMlRONGFD?=
 =?utf-8?B?cmtUMG15RU9pdzNvWk5HcWxJTk1pZWZpMUxCZkJuUzIzZXUyTjhNODY4VWdD?=
 =?utf-8?B?WEl3eUp0L2lWMEFzbG1mazhTK2RnTkV1K2tDRG55bGIwQU41ME9Sa1pPZ25l?=
 =?utf-8?B?am8xaW9kQ0swQ2o5VWs3OUR6NHVVQXVxN1JUQXBJZDZwa1FCWFNIdXFlVFBp?=
 =?utf-8?B?RzZjSTRDcFdUakJIc0dYOHRmbHRLbTZtN2Q3anRyMU0wNERBc0o2aGx6RmVt?=
 =?utf-8?B?WVNLNFhVcFAxTWQweUNLUjFTdEFPTUozcS9mWWFxRDU3c0oycjdjUjlxRUJp?=
 =?utf-8?B?ZXFjU2dYbnY4bzZEYnVPdjdJWmtWR2FxelVUT29RdklEdmowYk5GK0dDaDlQ?=
 =?utf-8?B?UWNlckxWWkZaZG1CWTZ5RFVsOEtQdWhLSHNISzJ0ZEtZNHBDRVcxUUcxb21S?=
 =?utf-8?B?bmpyK3J4K0hmNS9RdzByQVdYeFZBbHJua29FVTJmUXJRZE1oVk83UXRpdkRz?=
 =?utf-8?B?cDU0MGN2N1cwYkZBOVErUzRJSzIyMmhVdldHMXlXMENOQnM3Y2pTd1djZXBH?=
 =?utf-8?B?Um9hSWZwZzFpbWFoZUc2MWo2Vk5YQ1p4eUZ2Q2JLYTFDczBvNElGS05HRG55?=
 =?utf-8?B?cFBqTVg1WlJsbFdBOU9aejhrMDZNaElSRFdzSnBuVk00Rlo3OFh6VmY3bUdw?=
 =?utf-8?B?bFRnNnc4dVJSR0h5T1VHWWE0NURHdklZQmY2T3Q4eXNKY2pqMG9adTVoemk5?=
 =?utf-8?Q?MnPdiPYPexb3KSSFHoZxm0Uamc06vjqab0zshvHBMjKV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 709a09ac-f455-43e8-7efd-08dd8d6e740d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 13:52:49.2436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l69dUK/Rj4+oefqa0xOSRrzOuDl2vVpcNoKViHUJv1mI1xGh98FlJgvXYmkA2/MrmHUc/cknsOqimfrN00S+LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6761

We will commonly need to compare chipset versions, so derive the
ordering traits to make that possible. Also derive Copy and Clone since
passing Chipset by value will be more efficient than by reference.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 17c9660da45034762edaa78e372d8821144cdeb7..4de67a2dc16302c00530026156d7264cbc7e5b32 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -13,7 +13,7 @@ macro_rules! define_chipset {
     ({ $($variant:ident = $value:expr),* $(,)* }) =>
     {
         /// Enum representation of the GPU chipset.
-        #[derive(fmt::Debug)]
+        #[derive(fmt::Debug, Copy, Clone, PartialOrd, Ord, PartialEq, Eq)]
         pub(crate) enum Chipset {
             $($variant = $value),*,
         }

-- 
2.49.0


