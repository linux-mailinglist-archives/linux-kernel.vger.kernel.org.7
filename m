Return-Path: <linux-kernel+bounces-891264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0755C42491
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 03:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A2913B337B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 02:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E397B2C15BB;
	Sat,  8 Nov 2025 02:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M+dR5slu"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656FD2C026B;
	Sat,  8 Nov 2025 02:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762568659; cv=fail; b=Uk/wnP4f9KqNksHdkrlrqtJzh53xJbBb/mC9qxUg9pNv2TkE3WquxhKUCIH6qU24tapc+HFvVwwBHim4tGfidVxrqNFEmspjpt+O60cnqXRdgGnjAENSOEz6OUArbsqx4K79EMS0rAq8lVLpbKBZN3N1vo8ChkFD3XvU0TX2cps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762568659; c=relaxed/simple;
	bh=3zRpPJjaWfRyr3xEaIM6lAMSdycB1CRH0KLHMVYPZBM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bSE7C2AHkNarA8teXp6Rh+9TR0PibKbeXSMNlpvcuNFZPPoOII3Gam+7/pYM4ulF0bgTDFKP3zt402opM9OdRA1RwGZfkf1X003w8vrPot2KhgXbykSrgPxW5sIJkEZJkLaDQtxb0qFR92F+yaYSnoVoSEqcR5L3dVNlXc2y0xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M+dR5slu; arc=fail smtp.client-ip=40.107.209.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wW2fsCDZZEca1XJ0oiz1wW68GBgjce0qzap65JPHNpYqns+HAAtcxHhkyM2GqaGCQhJO2wJeyP7IaiQEpowem8Zg1Hsc9g6saPuzxjSmmuttxb7YZNzAwaEJPtR/6FrQad5fY7NGtvwdpEg42igNppBto+/hVupX6SrB4i0nIwj+Ef/7Qqoe1L6IdHWYmEH2IKXZ9714pt88oVHpgrll6OcS95ByxM6RV48vRMXeJBREobtONn9j3D8/U5s9uev6ysl8FjkCuCfboF7HqR7o1GrtdDDgUuol0PNffN6fm/vQraOJuRY+SPxW2XYQCybU5oNn0YESdSuBtv0Ruq7CzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZU52KZgmuHh4Bgh1GD4k8qt6qtLHOvspfRspftpLpQ=;
 b=jY8HSJ5viW2UidJko8rkQV19b6QVW9X0lequIfMpMZdKIksE7qBVNDpanuum+2Jg1bS/zuj+0JBKvj3zGjwV7NKe4555svwFJ7EmN0jY7iu2p8rwA9eVU/OBlXcXZ55nCvQCBng1ZcqOpqFzp0NoOXunIwSviQG1lgQVovE4nwJz1wOy+K2KLiymk4mmuM9/1MApLCblsJ8L+RB2qxNvPI9BGGuUIeTYKE6JRapBTuvrc9f3Z9kN4fDzTLKzD2U6im2GJiemLZ0MmbbTgwrZPDFYzKvLz8QFs90R9p2OOgxgmD+99S0SAi8TUM1D7mQPdaatWx2NC1ZwkS9OsFEkSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZU52KZgmuHh4Bgh1GD4k8qt6qtLHOvspfRspftpLpQ=;
 b=M+dR5slu6phhuoK9j8UTmWKTCVbI972RgrIf1S/2Ry2ZcR77E4i1ayRq9WRHzFv916QwSHfgYyR3nNZr+mlDwsbFJoMloeTO9j/XXuwmusPIEiE4k37qJ3U+5FPVS+wY58OIM9HYJIGTVhNJGqLpymqnLu9di5L82OzLOIY3kIY6lUdERLC0PbIqQARGgLIH2v0bE16yvtUgpleOTrU5lR57HBWQDK5YB8k2Rd9JALr92pdMiEnNziF4sBQ4hDGDPZkto86cE4t1n0mPEn1qa92kg9k/SEuq3HcRvLPZVPv/hljw4q7QEd9wme+YMqbC5h586kdycJmZwtMOo8B7kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Sat, 8 Nov
 2025 02:24:14 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 02:24:14 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sat, 08 Nov 2025 11:23:49 +0900
Subject: [PATCH v4 3/4] MAINTAINERS: add entry for the Rust `num` module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-bounded_ints-v4-3-c9342ac7ebd1@nvidia.com>
References: <20251108-bounded_ints-v4-0-c9342ac7ebd1@nvidia.com>
In-Reply-To: <20251108-bounded_ints-v4-0-c9342ac7ebd1@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0206.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 39564bf0-8679-422f-fd45-08de1e6de914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDZyajhRUFFPQ1VrZ2pRVDNBeXhaZWJITktKb3pQNlZzUGdEcURQT0M1cCtS?=
 =?utf-8?B?NThYK3ArdzZjTXF4RTZaekcvZGxCanhuTlpSNW02YmRYeEx1UlhaRW5md0ly?=
 =?utf-8?B?azRhdnFBL0Y0QkQwQ2hud2oxaW5ERVdwNU9EeWIwVHhjVHA0UFZqV3E3VnpO?=
 =?utf-8?B?TDhiTllFTUdQejAyaDVSM1lLMFErWmJPaUp6Y0pvam5yTmdNbE5NOVJ3YTZU?=
 =?utf-8?B?QkdObC9JT0RDTFVjTzRIMWlJaDF2dFVWUDMrUHl3c3pwVVpkSmV1SGlyS2cx?=
 =?utf-8?B?NENXc0l6amtTd3E2Q2xiM0hiVjU5OEp2VWJZaDh6cC9INWhOU25EQVpVVzJ1?=
 =?utf-8?B?Y1RQL2RXc2J0cVBaRFJnOHhTRG9IVnFObzgzTVdGTi9odmFueUZ6UVY3RERm?=
 =?utf-8?B?eW9Xd0EzcGpPc3ZvUGN2MzltV2U5Sitqc2dUYjcyTXJDTFI1aWpDWHllYmFm?=
 =?utf-8?B?YTduNlNVRWp5WGsrSlRyUUFBZlNlQ2I2M2J0bG1IWXVDSHhyWllyQXZtTnI0?=
 =?utf-8?B?dk94M28vdW9aRUtIS3BobHp2alhJNGdYN1ZpRVd4KzEwald6UU5BY3V3R2Er?=
 =?utf-8?B?Yk5rTXpQR1RKc0dxQXVpSjlWSFcrQTRkRlJJNkE5cXRwQURKM0x6eHcyVDRP?=
 =?utf-8?B?ZW5PcU5sNWo3d2o0NDg2SHRrSHQyNGg3VWZ6YXRCMVhBRlcreldEYUo5NEIr?=
 =?utf-8?B?VDRTR1VvN2hqeThjMElxV1RzVnc4amhPdTdkWGI4dHlUUEoyMXpJZGRmZUhF?=
 =?utf-8?B?elkyaUR6UzE2UElzT1VvVTIzSDR6Rjl6cEUwZVQwbnorazJjdlZyaktHcGhR?=
 =?utf-8?B?N3FwMnJqMG5HdEdqU3hJYmgrZlF5aFgrWkpHR0U0UDh3dHVCekdjSUpaeW1h?=
 =?utf-8?B?OW1TZ2Z6eHRGMzdBaHBQbjZoNURkSHlpMDh6WmdOM2Y5blUrZDREOHNuRlZ0?=
 =?utf-8?B?b01HUHA4dHB0TlRrR2MrU0hCT2h4VkI0bnNQZjVleHFvTnA1YnFQSzZCZGFW?=
 =?utf-8?B?UjdEbWdaYTlrREZzQkdETFlmbFJCTjQ3dnEzQ2xyWFJBL3lDUnBOaDR5RzlC?=
 =?utf-8?B?U2FOQUpRZVNxc3dwdmVMTVpxTnA5djJaZGxSaWVkc3pnb2NCUFFTTnEvZGNi?=
 =?utf-8?B?RHBHck8ybElkVlJDRCsxM3dZcysvdEJoejhiZHJraVBTcWFzZmNFUlU4QU9C?=
 =?utf-8?B?aWY0bmJLQ3RkVVRrdnJrazlNMDhURlVnOUEydm9VU3JVQnMveTRCK2hrdytj?=
 =?utf-8?B?NjNWTnVBeHRQVTRqbUNDVFg1dnZ1QnRQT2xXc2E0dDJ0VWF4OEFhaHJBMG1K?=
 =?utf-8?B?d0JDOGRJM2VuanZGcTBuOWVWRUVUTUxtNWRTZE53Mzl6QndDTEpzV3U4b0kv?=
 =?utf-8?B?OGRpdjYzY1FreUFZSDNUS2tnamtTZzEzWVZFdk80bmIxUDF0V1RrdzRKR1Iy?=
 =?utf-8?B?bURKOC9veVozN3hJalFZeG5UUy8yeFVGb3RreE1nOGFsM0k2ZDg2YTFleVI1?=
 =?utf-8?B?SmFKRUNHaG9Vb2V1aXcyVXM1bGpHazI0TGlrVWpDQTlLTUlIOHBTRkhQeE1i?=
 =?utf-8?B?NEVWMFY0enhnNXpJOUo3OTkxcU9TcDZGODA5RmR0aWFnM2JQWGxDQS8vaDh3?=
 =?utf-8?B?R2FYRXNsK3dEYTR2N3NZL3Voandia2VGa0RRaGJMSWFjdDJMbTd6SEwzNjhP?=
 =?utf-8?B?SUZSZUtMWWVSOHlUcHhsMmFuRm90bXU1dWNjb3g3ZGtWaWlBRTVOOUkzdlBE?=
 =?utf-8?B?SWFmUDU4ZkF6a29PNXJtOVArUzRGTVdpeUI1dGYrd1VJdU8weGZlQnErTDF1?=
 =?utf-8?B?TmFrRXdUOGhVMXd2b1VJb0tidDlJcE1zcUs0TkNuL2N2RFkwYzlYMUVlUjRi?=
 =?utf-8?B?ajRzWWFqd08xN3FpVGhXWnUrdlFoVVo1d2JNa0ZKR0VBQXhSSVlMTlIzdEZI?=
 =?utf-8?B?NlZ0RFNvOC96RGxPRUNvbjA3YXFCQjJ3RFdoV2RYYm1DdytHMUpkR1Y0d1pX?=
 =?utf-8?B?eC92SnIyRHUrY01Hc3FweUl1WExJZ3hDK1FCSEtTVk1JV25kRDhoNFM4K0hX?=
 =?utf-8?Q?/x21dS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXpTNUVncGpHYnJkVldLYUduMmN6b1NEaityMjQrSFNjdjRZS3FqRnF2NTBZ?=
 =?utf-8?B?UlBoUDhxekhXMEExVFdOV1JXU3R1RGovL1RSYVBDL3NkNVlGVVE1OFFJL293?=
 =?utf-8?B?T296VkFhNHp6TGp5VzZ6NHNIcjV4aytPcU9OUndTMU5uaUF5TU40bmRMcDFU?=
 =?utf-8?B?NnIzZDNyU1FTS0J4STJndTF3NWF2VUNPa0xkWWhtUStud3BZN2xHSmVWcGVP?=
 =?utf-8?B?aVcvK01oNFovVkhvUmd3WmQydzBZYldpTG1KQWMzMGUzNEt5c0trVy91OURm?=
 =?utf-8?B?Umh0bXZQbXd4UVkxVGQvTUFMcDBIVzNGSW9DMk9KODh0Sk9MdzB1ZlFLYlNU?=
 =?utf-8?B?RTE0Y2I0aWZJa2MzOS83dHQ2bTBOZzZmRld1UmFTakpxSUdaMUJmbTFLMVN4?=
 =?utf-8?B?Wm53eG00cUFMNWdCTEZPSHQyY1ZhYmdHQzErUCszUXhzS3hsbXJQTkRrVGJ5?=
 =?utf-8?B?eDVnS3hIVjNZM2MvQ1B6Ulo5SDlXUUU0eWFqSEpmQTZ1WUtMOVFSTStZdzM4?=
 =?utf-8?B?eE5hWW5NM1l6cVJDZDB0dDdQVW52bkZwRktQRVM5WTRTUkgwQlN6ZC9lV2hp?=
 =?utf-8?B?S3RpOGJMbzMzME94b0E3MC9lOHNrSzZtdWh0U0hodVB0aDVVdzk4d25uYmJq?=
 =?utf-8?B?ZjE3RDNUTG95RlhIeHh0ZUJmSlcyRVkwT0FSNjhPdjNuU3pGbklGejhCSFZT?=
 =?utf-8?B?dkF0b0t6VU9PdnJLSHZlN0Y4aXNJU21nL3Mrb01xOGZDWk1jazVVbzZtTjgy?=
 =?utf-8?B?NFFpbjd3M1JIS1BRZG5oUXB4UUR0aXBib2JkQkhEZXVGM1l4U1ZzVHlTN21J?=
 =?utf-8?B?Nmx2VWZNWTh4U3Rad0JuOXNCTFdXYzJiT1J2N0QrQWpPOWRVN1V2cTFidm0v?=
 =?utf-8?B?ZU90dFo5NkxxWTRrbExXUm9SaXpEbnl6ZWtYV2lkRXFSNHBSZVdxMmlLUlor?=
 =?utf-8?B?WHA1cEh2ZytVYTRMY3Y0ZmMrSDB5MUFyNEI5a3FqTHpRWlFCQTlIbHprZnBX?=
 =?utf-8?B?czViRmVxUFZweXN3U2V6Zzk2YVZ6VHVCTUlxUlRCangrb2VsSTVJeUVGT25J?=
 =?utf-8?B?ZTJFWGNJYW0yQ29oUmZwTjQ0TE5jcmF2L0NiR1JCTWpFZmhCQVEvL0IxMGh3?=
 =?utf-8?B?R1UvdE9VS0poK1VVS0pUQitQcGxqWVY1U3NPcmFkbFFQUDdWUGllOTFHNjND?=
 =?utf-8?B?clpaZVNzdUxKNThkT29MSW0reFZEY2pTNTkzTDc0QS9ya3V2SHJ3aDExRG5T?=
 =?utf-8?B?b25jdWVOTkFqSDR5NE43amlMRWQ0WXdpMVF5N01tMm4xREJOUGNyKzJ5L1hD?=
 =?utf-8?B?TEFnTy9FcVU3ZnJpcTVrdlI3OVR1R3hDQm9DZU52RC9nRWpJaVhONzFpYWZL?=
 =?utf-8?B?aXFvMmh6MTNndUdTWlZOcUdCNEJuVUhFcGVNUWpMbmExMTQ1UmxJL08zYTdj?=
 =?utf-8?B?a0xXZDhPRmltS2xpRVk1MkdZNjhCSGdGVElMUTBhazY5Zkd5NkpFTTVnem1O?=
 =?utf-8?B?ZjBjY3A3Z0FyRVRTOWFtczlvNUpOKzVSMEFJUXhvRlRYRFRUYVQwS0pIcFd3?=
 =?utf-8?B?THl1UXY5WkluN3JrMkkyd2ZxMGRvKzNOU2ZncnhDYkZUZTBCZWE5OFpmUWNU?=
 =?utf-8?B?Y3VPZmIyM3VXUUJaRi8va29wamU1NExBSzIrdU1TbVZadE9yR1Naa0Jldk1n?=
 =?utf-8?B?NkVSWW1hWG1hMkY5MkwxQVZEV2E0V0RGR0pnem9wSnl6WUZxbXpYanhjME93?=
 =?utf-8?B?VkFlR0JmMk41VTBuTXdUWUtTb3ZRNXVkZEIyaWNHTTNvUDJCOUhzSVRvRm9u?=
 =?utf-8?B?SkFhWFJEOTIzNDVMVWRGUTBCSURPaHRHODBVNmc2NTd0aUFpamUwU2wrQ1Ro?=
 =?utf-8?B?ZFBUanNRdFFicjJ2eGpxb2x0OUp5Q3pKcjBXV09URGN2UXA5THJsa3R4a2l2?=
 =?utf-8?B?SzMzdmc2aTUyQW9MOE5JcU5lTzlnSk1TYm9yaE1ZZ3FCRStqcjdOQ0JaRHdl?=
 =?utf-8?B?a2gxLzdtbWt2dkd2U1d2aXVjUUpkMjhxMlV6K2tPNG91dUJTekxSNHdpUjYv?=
 =?utf-8?B?dVJJMTczSU5HWUJJbnlXRGlSRkthcHpnY3QyZEcvbjFYaldpYzBuZE5hYUpW?=
 =?utf-8?B?UUY4Zi9Ua1Qwc2pwYU9xYUY1OWFVS3BTbVlrVVBjOTlFSGxoWUY5Y0JDRmtu?=
 =?utf-8?Q?YuankRS8iqwacfu/RLgM0WnejujNSK8QlHgvDC0kcuqU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39564bf0-8679-422f-fd45-08de1e6de914
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 02:24:14.7789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0YDe1RaIviCfiVhHzjQzdyrhDdLayG+PyQMs3UhyrK73kphGowL1dNB5KrJ28upevpy59iLP4OAchnPxCpx+Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149

This new module provides numerical features useful for the kernel, such
as the `Integer` trait and the `Bounded` integer wrapper.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 952aed4619c2..b6294a2903c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22521,6 +22521,14 @@ T:	git https://github.com/Rust-for-Linux/linux.git alloc-next
 F:	rust/kernel/alloc.rs
 F:	rust/kernel/alloc/
 
+RUST [NUM]
+M:	Alexandre Courbot <acourbot@nvidia.com>
+R:	Yury Norov <yury.norov@gmail.com>
+L:	rust-for-linux@vger.kernel.org
+S:	Maintained
+F:	rust/kernel/num.rs
+F:	rust/kernel/num/
+
 RUST [PIN-INIT]
 M:	Benno Lossin <lossin@kernel.org>
 L:	rust-for-linux@vger.kernel.org

-- 
2.51.2


