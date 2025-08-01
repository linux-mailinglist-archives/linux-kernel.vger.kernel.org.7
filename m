Return-Path: <linux-kernel+bounces-753400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70218B18265
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F2447A7DFB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3192550BB;
	Fri,  1 Aug 2025 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JmBecQTV"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB2A2E371B;
	Fri,  1 Aug 2025 13:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754054662; cv=fail; b=UhceO+q2slPdgLGgYot4LrCjaW2SMIVtP12bVPx9eH7aob2IZmRdEtm6bx7XodVLC1kYcC+jCa0sv+KR4yAIVpLGxS0FEPo1UMYPFDnfedGgxI7VLcIIW+XaIimUeJKtoTpur3J1dJXbYi6KU7NoEGmDdrt+H0MDAVpeTWBrQAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754054662; c=relaxed/simple;
	bh=cc9C+Zxa+FLw1Vn6RVo3CjYnTQqcqlaizV+5ta3jqgQ=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=MFsCO7WVhfErDLyIMae3qRKrBmnXGT3T+gHc+LVVqZS/Zj6qtnVRsmdPozhgHnj/QbIEbhU3lAT4trlH9F8LEnOfWk0BV8N6l9X3poMOk2WfiLxJYk29ezZ1+AXB2K9SH+ESN8fYCO9F3+ruJR+MYvNhL7iD8GoQI8Jyj24SAYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JmBecQTV; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbnaCQvGRefq1VysLnlRYcbzhi9L5yKJrsZRQQUbCjmwVCMAYz+MJRQP+tAcGT5KNihjFOHhjsoORsVnVaO7nJ0EuNssgv/LXNVri/cjjMzvpWSHgYJFYtJrhyDbJSTtci89DfIRAli0+8gj/WozWJ8qH5FsESXhC5gVKz93p4BOCFvE7y4pWdid9Q68W7YmUOxh9MFEqAX6WT2ccYQ/Q/aVK1mFVYiG+X2qwWzmlRKVC/MSs1zuxiIU78CH6RR293joAW3k1gWjujtOWj/nY+oWatq8DEBqSEaHCOu0B8PbC9Lp6dObRsKgErw2zKrWKOWkc9/Q2LF91nBSVR9pPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nu+8dEsC6vaZor/ZJhcvlAwkKPG9uXkFn99xEk2pThU=;
 b=EHkcdGiaK4wqkCXfVdMU6B+W7IaTOr/byceQdNYcOP7JGG8IGnuX9PzECyHoT2dqFiPt6dbjxUbFK8mU4ZrDzpNb1ZNxhY0H3SC7poVIcz0rAbpLdLZryfyIaWbOJKb8vf3439JnxbHzoIZiqZw6uQN+9v233rrtUdW3Z0WyVpmDvJPxoMoJHcdaECrCwJrqfK2YXuC0aN1UHBE/6Tso0JgbQbODVLvPsmLhJ3qezd8BcGR1qzqLknlNkowz54mexhMSEJMpMSy67mE4ePd45UZ9m+cU8pxrYiWp/2F3wBLvb5mngIbcCQdrbFjXrHoNMybHIrLAB9hc22AGoY60vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nu+8dEsC6vaZor/ZJhcvlAwkKPG9uXkFn99xEk2pThU=;
 b=JmBecQTVH9z8152QtPCxM/e1jAGuI3By4CzE1W7MU4p34Gs2a5F4EUMJJkI02lIzk5LpuyZ4Hk4z6TdBVW4CKUERPVBFKhtkQD+wG/ZbQAHIy+9T+hWjNeqbl/pGqYxdmC1HKfENh+pZI2XugSHRf53O1znulQI0Qvi7chdiKtwW/Feff0VRg08cXm5fAlHLgkgATOJVlSpc3VHlTqUJcYy1yOjfGRtdZsgPDMINKVTm6Mi6RKq2hV7pqKVc1arBsvdAcc2GzTon8tid8Cjr1aRrdyUGDoi0ftoff4jVziX1X57dqbqUmWzkAALyJaho8kc5Q3ncMy2C/03o9lll8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH0PR12MB8007.namprd12.prod.outlook.com (2603:10b6:510:28e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Fri, 1 Aug
 2025 13:24:17 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8964.026; Fri, 1 Aug 2025
 13:24:17 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v5 0/2] rust: transmute: add `as_bytes(_mut)` methods for
 `AsBytes` trait
Date: Fri, 01 Aug 2025 22:24:08 +0900
Message-Id: <20250801-as_bytes-v5-0-975f87d5dc85@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPi/jGgC/3XMTQ6CMBCG4auYrq1h+ge48h7GmLZMpQvBtKSRE
 O5uYYVBl99knnciEYPHSM6HiQRMPvq+y0MeD8S2unsg9U3ehBVMFiWTVMe7GQeMVFljARzDynK
 S318BnX+vqest79bHoQ/jWk6wXH9EElCgyhVK81IIp+pLl3zj9cn2T7JUEvsnWZZWyUpYBqCV3
 Um+lWojeZZoSgnCaW1YtZNiK6uNFLSgpgaptOMlcv4l53n+AOuwbtBPAQAA
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
X-ClientProxiedBy: OS0PR01CA0030.jpnprd01.prod.outlook.com
 (2603:1096:604:25::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH0PR12MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: 25643513-9f46-4f35-86ae-08ddd0feb773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDd4V01CbUlqa0NQWjBHd2ZEeTE3SmJvTlpJdFFOL3R1Nm42TXJOSWI1ak9R?=
 =?utf-8?B?N3lQdWJMcktTRWpOQW9jMTVzUmN5R1ZlK08waHZoQ3RWM1lsaWd1YjdBMmhm?=
 =?utf-8?B?c1JNczZzZ3F6bXNMNG0xbVVGL3RHK2hvNVg1cHlRR3hoV2lyWW9SdkJZczZu?=
 =?utf-8?B?NlNkaHNnQW9qM0M4aFU2U2RDY3E1eEN3U2owK2YwYWtqcHBqcWlNZFNDeEtz?=
 =?utf-8?B?S256NXU2QWN3TlhjenJvVzRjbU40V2U4emhSUUkzSmd2NCtSczZlTXp1SnFL?=
 =?utf-8?B?ZGpBMVpJUFlwZ2hXQTV4SitZL0dobU5PN0xzTmlKNUxMZXZZS0pTMmxsWW9H?=
 =?utf-8?B?bVhqYlRlNHp1YmhlY0FKRWhCNVZZM2pOclk1VHBVQm54dXNIMmRESFpJRmIz?=
 =?utf-8?B?Q05rd2E5b0QvOFp5amNaUFZCclNWMHE2S3YyOHZoWDVZbC9nOFoyZm52ODM0?=
 =?utf-8?B?ZHp5S2h6ZXJzMit5RXBhTVlkWlo4cDZhUFBwSEFwNExZdGV6RzI3WWVjRXd3?=
 =?utf-8?B?WmRDa2lSNzgwRnIzNjNaaTVEQnJrL2FLK0oyaG5YcXM5SnMxTmdneENLY1Nv?=
 =?utf-8?B?Z0NiZytJdCttSjZGSFIvSWd3OW5uS09ySS96U05GZGs2eFhzV1hpRytvYk84?=
 =?utf-8?B?MFJmV0pVNW5NSThycE5uTWtCM0lxemFXYlc1YWQvS0tJcFY1U3paOXdjQW40?=
 =?utf-8?B?TFMrVXhMS3hKSHE2dlF1TDZZem80djJjSWhHQnhNV2s4SGg0blNxOERWM2tB?=
 =?utf-8?B?K0dIV3ptdk5nZEdxenAxVHk0ZysrZHlJeVpicDd3aktuTGZ2Qmx0c0d4OXli?=
 =?utf-8?B?eWE5SWRmK3RQYW5CVHU1SlVDSGtBc2FmRDNrK213R21OSStjY0JpMHNZRjly?=
 =?utf-8?B?TzZnTGZZZzZ3MTMrSnJBMElyV1FOMnBvMDFxN3dTRkpJdzR2NXJtVzFidndX?=
 =?utf-8?B?YlZmWFBxWU1kTHN4Y1RXemVNN3U1cWdqR2RRUzV5QnJscVJkM29GTkd6UlBJ?=
 =?utf-8?B?cWpUNnRpVGVqUnZuczhocGNSWTYyUHZJekZXOWdTaUFJNU03cHdMdjhBM1ZD?=
 =?utf-8?B?K1dzcXZuUnRGSWo1anR1OUl3MS9xc3pRUnNWZG5zTThCZG9vK1MwTDNsM2lm?=
 =?utf-8?B?Y3pyOWdHczl3VzEvS3VlbDJCOFo4WlZlZUtFcy9uSVAyUFhzREJZUU82am9x?=
 =?utf-8?B?bVd3Ympsb2VDa3RoVkVmMzRBZ05TazU3Y1FhV25mUFZBbFhXUld0TVhIUEYv?=
 =?utf-8?B?ZkViem5nM2U3MXhKZTRxc21qR1pVLzM4Njlrd3NNRDhYeUg0a0gwNGN6UkIr?=
 =?utf-8?B?SEpTTWxxbTBFVWZjMkpoS3pYa3hMZ1dPQzRXZ2oxV3IwNENlb0Fjc1pGczN2?=
 =?utf-8?B?N0VOZFdmc09TcFQxUU8rWjVEUmk3U1R3MVVQdS9rdVFpb0Z0RktPOGx1SzdV?=
 =?utf-8?B?WVJ3MUhzdjlFMjJmQjQ3QTFtNm5Qc01MSUE3OS9JenhWeWxiTVU3MmhFMWVR?=
 =?utf-8?B?Z00vNDBkQmYweVRvZUtZZFhibFpDVnVudVZtVjUvdy9zejBYbjNJNnpHNUVz?=
 =?utf-8?B?NStQbGdOVUJCRjBhWVp1bmM5ZVM0UnBFaTdpZ3pIY0RWUkZtWU9XRXMvKzJG?=
 =?utf-8?B?UE9GUjRhUFZ0dU5xOXVYaDFKWWcvY3hBTUVSQ2RSYURUQ2lWZzBEU3gwcFVa?=
 =?utf-8?B?TndvVWYvdlFrdy9Xck52VVlzdWRNaHBxM3BwcThWTlM1NEdwbnNVdXRwK1dB?=
 =?utf-8?B?OUJjVVBJQkdLem16YkhmTHB6emJUSGxkclN3T2dpUXo0Vm03Yi9xTkZPMFBa?=
 =?utf-8?B?UG9ubUJDMFBoQ2d5ZFE0dnQyYVlOQUN4SVRWenR4amdYWTFrMXBpSi96c1cw?=
 =?utf-8?B?VkVHMG15QllNWjVwdGZzZW1aaVBPSlNaRGtCb0grajk2TE9UVUI0a3pKc01O?=
 =?utf-8?B?V05VeTdmYnBBQW9CMmxDM3RucFd3dkJCaU5GL1VWeXpHSGUwYld2dXVUVENB?=
 =?utf-8?Q?2X6b57Zn5n3ECEV+fAPJVwXnjIdSCA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmpZOFcydk5sZmoycWs4dDE3ajgwOERNa1psbVQwN1Z3cXlzUUl4dXNDQ1Vw?=
 =?utf-8?B?SU1HQ3hOYXlqTkczRnBSN3ZycnVLZmhiQ3VjMVRoaTg4SnhsMkFmQ2dSTmRl?=
 =?utf-8?B?Mnl3aUNlenlYUC8rRDcrbzRUano4K0dUZjFJZ2N2RkJEM0VpNENJSmxEMjV3?=
 =?utf-8?B?SnhDekY5T2NXRDNTRVg5RkZLUGN0bkpnSFhwS0NoOHNEV1JnNjRZUkl3SlV1?=
 =?utf-8?B?SlFXSDBvTm9IN1FNdkF5ZkdicEFGZ3hNSXpIR1QwQjBBUlBkL2pIcUxWT2xs?=
 =?utf-8?B?am1hbkZ2K1BKeU0xWjlGSW9weFRlU0MxdFBSdkVLVVdPUE1LT1BnZXYvS2xv?=
 =?utf-8?B?NjFZdkNHc2pnZXhUQ3MzNDNlZlBoOTNaVDN5cUJYcE5YcDRaNXhjZG1qS3E0?=
 =?utf-8?B?QWR5RkhxSWxDVU5FNEJNT3JYZThuUWNuNWtSTWRQWVVHSVpIS0toWExoSDVm?=
 =?utf-8?B?emNmVGIyTHRDbUJIUzl2Z29tSWt6TFFUWTJQem9ROXV1VEpUZGZtWDU5cjFQ?=
 =?utf-8?B?NXhUU3BSZDc5c1g5cUNiTGVuaTRDcVdzcDRaQTc3ZXpVcERLNnQ5QXNPUE9S?=
 =?utf-8?B?ZVZicGNPTWxGWG4wMmwzSVQza0JLMnl5ZDhFWkFYTWdaNVd2TGk1NDVWN3VC?=
 =?utf-8?B?WUlBRG42MDFSWWdJNGdUWVJvL0tra2ZOdUxmdEpIS0J1bU9ySDhRcm9rTFhv?=
 =?utf-8?B?cTltUDJQQk5ZemNYZlJqQWgyRlNWb3NrZkZ6SEJUV1N6R2gwYkpGekRrVTZ5?=
 =?utf-8?B?eU10ZEVITmt3elNSb290VjZiTkRaQUpZeWlzYnNLUUhMWFhnVjFvT3N1Ui9M?=
 =?utf-8?B?Y0hwQnV4Vll0OVJPVTZDYlhwYiszVzZuL1JOb2x5b0pRR3FnYzhlY0Z5Zmx5?=
 =?utf-8?B?TVFvdTZmTU9GS1NnazIyUHE0UG53UThQd2JxdTl6Y3V5dnNzRmprVFpPQ3dy?=
 =?utf-8?B?cEdwOC9ZSGxyS3R3eFhtTTE4NEVyaUw4K0UzK1hGY09YcEZDY3g1MC9rUWZR?=
 =?utf-8?B?a3UzbXBPWmRCRmNGSVJUdFZTREd1bGIxeUJHazdaT3pZcmVJWXFLVkgydCtD?=
 =?utf-8?B?dEVqZlFPWmJVU1Z5VDlxVmM1cGN3UzBFZlZHdzlZMk5EOS92bnBhdlgrdlhj?=
 =?utf-8?B?bklQdFRYejY0SHd5RXRBVEFmK1lOQkZPaDdrV3p2cTlIa2xGZno5S1Z0Rkoz?=
 =?utf-8?B?aGtrdDBkUTZxeU5KSkVmaVVqazhhYWxBaVZFN3FSc0lWK3lnTnRWcytrOU5k?=
 =?utf-8?B?ZG5zYzdzY0VJSWpscTFUZEFXMzVVZTFrZWdRTlI0SDlsK3pNZlhjMTJvdjky?=
 =?utf-8?B?Q20zR2luMUhtdDhEamI1VXdXVGVCdWRBVWZFV25aZy9wTnl2YzVWeXNxTTgw?=
 =?utf-8?B?N2hqN20yUFkrazlKYlVDM3RHQzhQZUlQY1R2c1o4UkZCMVFSTWw5VHgrNDFV?=
 =?utf-8?B?ZFdwN3IvdnJoU3VldnYxbXNISmV6N0pHNWxJTHQrdlc3elJJa3p0dVE0U24r?=
 =?utf-8?B?b0l5UUp0YjVvUFp0MU9LelY2b0FxbEk2SzBzOW54b2drT2VDKytxRVB5akR6?=
 =?utf-8?B?V1BqekJ2dng0RW8rTFJoQnZlK2VSN2dGOHdHVXc1Wi9HZ3Z1MG5BWkxENk93?=
 =?utf-8?B?T2MwbGZJSS9Db0ZwaldBcHltMnBjQldpNDVqcDJPeXR2S2M4eHRhQ0JqZVNz?=
 =?utf-8?B?bzBZaUM3bVpRek1kNUFlbDY1MjluUHYwWGw5djNFTXFHYmhIb2pLU1NPZkYr?=
 =?utf-8?B?VW5NNnBWSDBUNFFyWWVacktYc0RRaHdFTTVEKy9TRlBqdTlwekdpMnI1cGFK?=
 =?utf-8?B?TXU3NUhIZUdXcVhOdnFwZTE5VXVtQ1dJTW9LVGM2T0FqN1ZxeXZFZUQxYjkx?=
 =?utf-8?B?RzYzM01SM2hMQUxTWE1zbHVmRFYvdzcxTFlyZWZxMUxDMlBTNHM3a3REb250?=
 =?utf-8?B?d3dwTjQwQVhKUmg1NDBIOERMYzdESzJLNjd2RzNkcjNGckROalYxMXg1VGE0?=
 =?utf-8?B?YURYbnZDKzlabnM2SjNRbzFXN0p3UnBSdmROS2hvVGZJQTN2QW9oNkFWQVI2?=
 =?utf-8?B?M0ZUVGpabmFlS3NmVmJHRDhuRkFsWndsTVVYU3liMWt4NDdYQkc0YkFaQyti?=
 =?utf-8?B?WVhIaE5rVy94bUtwVTNtbnVFVGRBc1hUZCsyb1VDeWVzUks3ZHdQWnBNNFNM?=
 =?utf-8?Q?gojCxhb+Sl+UchXMEkjGf23F9/NzGHAuemXyEQKMazOF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25643513-9f46-4f35-86ae-08ddd0feb773
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 13:24:17.7632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gD9opBZ5wp8KbX0RjhtOtZ2+ugYmHD0yMCfnARxl2CjZVpxbw7vxY/13EpsgLEPaTlfBiE74URL+UCsKc7dLpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8007

This is the sister patch of [1], providing an `as_bytes` method for
`AsBytes`, and an `as_bytes_mut` accessor for types also implementing
`FromBytes`.

It is going to be used in Nova, but should also be universally useful -
if anything, it felt a bit strange that `AsBytes` did not provide this
so far.

[1] https://lore.kernel.org/rust-for-linux/20250624042802.105623-1-christiansantoslima21@gmail.com/

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v5:
- Add `CAST:` comments above cast operations. (thanks Benno!)
- Link to v4: https://lore.kernel.org/r/20250728-as_bytes-v4-0-b9156af37e33@nvidia.com

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

 rust/kernel/transmute.rs | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)
---
base-commit: 14ae91a81ec8fa0bc23170d4aa16dd2a20d54105
change-id: 20250725-as_bytes-6cbc11f2e8c3

Best regards,
-- 
Alexandre Courbot <acourbot@nvidia.com>


