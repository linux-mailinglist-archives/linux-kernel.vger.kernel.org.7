Return-Path: <linux-kernel+bounces-753399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A606B18264
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E65A624F8C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3506254AFF;
	Fri,  1 Aug 2025 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sOt6CIir"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767012AD25;
	Fri,  1 Aug 2025 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754054578; cv=fail; b=WaVVCtylvE2VW6yDHbOrdvHdbDBWVaFqlgqJDcipb/FkcOap9vK2bVA76fnEBy0sFfYPoYKq35VxzriDu4gzc7TOOvOfLVZDpuFy8ztu0UXxIUn1PoTy2UdhF3Z3j1kJmX5Gr0w1gxZqvc4VijwXCX2JmB9emAYFQz6KeUa2pJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754054578; c=relaxed/simple;
	bh=ejZT0Z3hDHWxPZfzFiC32XhQ8CM7SN+ziPRAUbKeNoU=;
	h=Content-Type:Date:Message-Id:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=ZS+zu1L7xKMWJ37deXfQokki5iSUeLw6SYhCp9sCVzv6ZlchA2U/CeEQGb6GC3GyPMwgOJpLD54B4ijyRqKV7xD3cGQhjpn0aWKIFjVUXA2qO60bQViNrd0iDFYsP10j6lagr59gXdeLSS4ktyyaJQBX3M6SfVsNkl5vHthse7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sOt6CIir; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxwQr3AM8lJH3ii/YavpKAhE1PMz3mFZA8EA3hpo+NTl+A0Ij9cFbyHYfD/5F7EFrQ4zjHJBUpBN1sApKyW1gFLdPFIf8UYvmUo2PTUnDRchBfbfCe8gUCMeHNHIdGLCJ9MgRHRQwiLVGvB6mlK4lvxhJq1LDQN5Yqd3/3Pou89TSrpO+2N5+zp2mPVPFXBbpsWcBK5ljD2DTFXDFpt2t86MSPVj8CPT+Z8yu2i1amDL8VUP61mAeUZjWERGQEr185/535AO6mgjRHCmBJDYsErd3SSCMfUU+ieGwA+Z3u5vBjny4JLEibjI11XqBSyYohHfb54uyDxuVfiTrrBwkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrkxF8cds/M+Kaxamut6mMhj+23TrwcbTY6w5IxEQLY=;
 b=f4rb27lE6qXdhZNk2FVKy28qys4Ox76PiOylALWdmQJpKNXFbin8S+OAk/H7pbC9XhGLeT/903V2TytfYmTZ5yp2iIL1Perk2PVU0wLe3eK0qRyCpk2ipwh9OsRgkP2ASM/YEDlwHuofbdRKS2DJ3qtXDLoB7U8K34t7bP24s4nGTx1jGSJhi1a1pe9k5jOVxmSJnYBaUWrHvGr+6khrEg0SjnsZLRju/3KQ4G3nQrNHxAQQT1029rqiUa+wjWS4ba33c0MrkDrjCEcBpkB5OtCIIc6d24nNPXPUfH/qI4OlZyGQict1N0I7Df2HxyLzrd0Gb2NBboFJ4tCPcJBr9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrkxF8cds/M+Kaxamut6mMhj+23TrwcbTY6w5IxEQLY=;
 b=sOt6CIirPwHDhuJVnhQryEZghTLKMD0y2ISabUgJnLSljBx+TV8/4NDcFJNQWWkNsgycddIpR0uWEVks5zws8sUQgJtNWkOYxYReC8Xhk8CDz4Q8uuGMP8toVW5L9vvfq2o88O9rNAHEyq3kkecioGrv5aktuJXLj/F8JOCHAYibcUFffLs8mYczEEReQSVvL+ctpaIvW9vlE2WPX0DD4wPQTb8pZR+B/y1Xw49RUHh4DAmKPa/pcprqzCSQxn361ceXOXDKbnwEMDmY6rdEen11ByQ1OXLgJ9R96Dh8x2gmBGlXux2Xd6qvRuYqU+u0+pY7NZG+vo7jOY1fIRek5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH0PR12MB8007.namprd12.prod.outlook.com (2603:10b6:510:28e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Fri, 1 Aug
 2025 13:22:52 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8964.026; Fri, 1 Aug 2025
 13:22:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Aug 2025 21:26:22 +0900
Message-Id: <DBR3913BFPSK.18K4JBYOPQVRG@nvidia.com>
Subject: Re: [PATCH v8] rust: transmute: Add methods for FromBytes trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Christian S. Lima" <christiansantoslima21@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <benno.lossin@proton.me>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <~lkcamp/patches@lists.sr.ht>,
 <richard120310@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250624042802.105623-1-christiansantoslima21@gmail.com>
In-Reply-To: <20250624042802.105623-1-christiansantoslima21@gmail.com>
X-ClientProxiedBy: OS0P286CA0008.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:9c::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH0PR12MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: aaac387e-0dcf-480b-6efe-08ddd0fe82f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnREUytQVWFILzR1a1kyY3hnVkM0WUIwREZ6b1BhOFhRRHVLd0dZTUdzNzRC?=
 =?utf-8?B?Y2JQZXNZUmpKaGpLcUFQTUpvLzh0OXRJdWk3U3dQMFpRcUVxYjdxQmtDUmtY?=
 =?utf-8?B?TStNWHo4STEydVl6QVNlUi83dXFVRW8xQzZoc1J2NTR5UkR0V29KZmVzZDFW?=
 =?utf-8?B?eEE1ZWZkV1VQTlI1VEVhY0MxV1Ywdk9EdUhXTVZiUkxIODZJUlpMUyt3VFoy?=
 =?utf-8?B?N29aSEx6a3VKWmliR1JUTHFkQUhISW04WWlmU3IyN3dCODBSR0lXQ1UvQVZ4?=
 =?utf-8?B?QkN5eGhRWUdZSEp0cjNNU2llbU1QY2JiZ2FuUWZERHRRZU8zNldNaGFjRHAz?=
 =?utf-8?B?OEkzY2twZHl4ZHI5bUthVE9DU1VxSG5xdEFWR2ZZWmJkNnVzY3BhQ2VuZ2Vx?=
 =?utf-8?B?cXdpS0F5Z0VBYWdVb2hSY0dMaDlaeVdOWlFHa0hvSmRNeno3ajlWNWZsdSt0?=
 =?utf-8?B?R05lcnY0d01ZSDFidG5FQWhXN0ROTmFZSmdPL2Z2Ty9xUkJsTDFLNW9Ud3Vk?=
 =?utf-8?B?b2VtcW9oYlQvWXZmT0dZdUJtdkZwWkZCck5aRkVISnpwMkZVbkZDeHRoajZD?=
 =?utf-8?B?SkUycEtSUHNhSERDVVJBVHJVeGNiZytHeFd3OFJaRXoyWVNnZ2NHR2YreFdX?=
 =?utf-8?B?TmhIT2RnMFhKV09lYUZRZWgvM2xZQnZjeXhoWVY4aHFUdWdIaTYrV0MzSXlM?=
 =?utf-8?B?a1lIMVNUQlFOaVZNbGx1d1liRlF0M1NtZDdGV2JGVUtXMHJJdWpFY3BUTlZK?=
 =?utf-8?B?Y3I3TWd0MFNXYSs2U1lWSit3aTRCWWFiYXhQMzFCTzhqbjh2NzZvcFhVZURV?=
 =?utf-8?B?Y2NLVC92VWZhUEJqeW5VMVQwbUVPRTV5ajQwV3BkWW10d3Q3UHRvejdhdm9D?=
 =?utf-8?B?aTBHbXpxRDhVb21QNkdqQzlIY1FmSUVMQ1M1L2dUR0J6aTZhK21CbHBTc3Mr?=
 =?utf-8?B?RVl6UlU2aW1WUWliWVJhT3paK2kxcW1JZXdyQitNMENCWnFHdXF3UGJpYVpz?=
 =?utf-8?B?alkvSit1MjZWdURUWTBYSW1veW1peUFQdnlqRG5UNVJWUzg4NktvcGM2U09t?=
 =?utf-8?B?cG9EaXpEbXRTekdaN0JabnVHeDRXWVFvRXpIUENPdWh3VTVwekRUcWJHdXJ4?=
 =?utf-8?B?TlRlV2dKSUVteENHRlZSdDdBMk1OaGlMT1d4SkpDa0N1aXU5T0VQcVpuOXor?=
 =?utf-8?B?M04rQ3k5THBIVlpPa1MwYklBd1A0OVZtTjFBRWQ5Z1JlNDRVNUlRV09OUlJa?=
 =?utf-8?B?czQwSnRDWjg2TmkweUwrQ0lQZHIxYVBXa250cmFoWFVMS2J2eE85T3oreDBP?=
 =?utf-8?B?OGNVTkZtTERmb0szSEltc1RjUFlCWTdKWkYzbXNsTVVEeUhkSWFOR3hIc29M?=
 =?utf-8?B?eUIzTmtUVUNEVnJETVY1QUdsdGhFWlFEbjgzc1RzeGZKS1cyTDB3VjNIT3p3?=
 =?utf-8?B?MmlIUjRDOUxkWkxhcEN4YXhEaWxjOHFuZDNYQm15b3VVamI3WkJ0c2lKdG1X?=
 =?utf-8?B?aytPT0h1TXltWVhKVmQvRFR1U0NaL0YxeDVSaUxBcm5ZMkRrRHcrYVVHOWtk?=
 =?utf-8?B?c2xtU2hYUnpPb2V4bHZMMzZMYTNZUHFySU5NNjM4NEFtaHUzQ21PL3hnclZS?=
 =?utf-8?B?enJ3ZHltZ2lYVmpYS3JoNlU2cUFYVlRIZ2V5aUxrdFJYUTlHYXM2VlpTeTBu?=
 =?utf-8?B?RGxwdHVNZU80RDZvVlhNQm1waWZnQmxyNEo0ZkhHZ1JPS3lhM08ra2pMdW91?=
 =?utf-8?B?OEpMa2Rsb3NRSW9vNWRCakVQQU05M200b0dXZWdNYTJFNitlWnYvRWx6S2hp?=
 =?utf-8?B?SmZMZ1J2WmZkbnZmUU5lVzl2UUJuaVRRTzVnYk84aWpkTzNBMTlmSllSbkYx?=
 =?utf-8?B?K2dFMFpYWGhDVHVkV0FuZWIyQVdaZllSZ1lVbVlIa0VKVFZ5azEzQnNRazZi?=
 =?utf-8?B?dlZLaHUyMjZYNERNVVdGQWM1R2JCMkEwTVQzdFpWLzFWZTlvYVZVdG80Tk85?=
 =?utf-8?B?S0RkZnUrUUFBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnNTbkJUdHZrckJvWTIwclFBM0FyVStLU2R0SWd5VjdJL3dBWG00bEQ1ZHRM?=
 =?utf-8?B?Rk94bERldFVtZmRlTmhmbHNEeVYyM3lVT1pWUG1Zd3NJQWxSZDA2a0YyM0pD?=
 =?utf-8?B?M2RRL1JCQk81dXhoSWVpK2xqRFRzbnd5SzQyQVkxYldoWDN2d0lYZTRqSldE?=
 =?utf-8?B?c0JicEtsemlWN0RsamR5Z3R2V0NFQlUrTmVzVkJXZXFBQUlzSWpXVmFEN1FH?=
 =?utf-8?B?WUtsYzJxYTZubEZ0d2NwamFJeW4rZUxpUkxvbHVoUW13QU8yMi84SWhwZ21p?=
 =?utf-8?B?dGJuMFBJeHg5amltOTdxbEZBM0dyeVplVmgyNmUwVE5CdnhMVUhUZHJtcGRC?=
 =?utf-8?B?ZjlXbmpqMnVKU1ZIcnFNbXVONzJnRVZnVmxiZkZCQmhIRGdaODd1Yml1RCtQ?=
 =?utf-8?B?VGVJeU0wbkRWSHlhb2RPMG83VGNwYXIzbnIySWh3czJ1MHFOVHZpOU94UExS?=
 =?utf-8?B?T1MxOFFYOTlBS0pDSldwNHJ6TmZwc1RJWC9NUEt2cmJFWWVnRVRYdFRrWnRB?=
 =?utf-8?B?QllMRWhkVis0ZFVUMXJKRURWVW9JcldNbkNnMTArdjcvMDFJbzZrK21JR1FF?=
 =?utf-8?B?anNWdzBRRVhCUGxNTWhIOUdsRXNPcTZVSnZzMEU2MUFjQjMyYldXeDVTbXRL?=
 =?utf-8?B?dTM4RDBBSTJMczVkdVpLSUd6UnIvenZlb1A5a0tMeWE5c0lZcGJxZGxydjd6?=
 =?utf-8?B?NXRtTzBrS1ByL0o2VDNFS1hSblBKWlUrRXlkUlh1Q2JseDdFczVkUGZINXlE?=
 =?utf-8?B?ZFAwa2ZOdkNmc2lSbUR0L3VGQW1lTittZE9FeDFGRDhldlNGcDR2MFFrSkYy?=
 =?utf-8?B?aFNYTU1IL0lVcHNlUmd3dnpjSGx0K3NDNmpWQ3kvc0JnSk1OUmtCbFhLZkll?=
 =?utf-8?B?WHMvckJZSGhBcG9pUVQ0V0tuZGJBK2tXOWx3d2NtQk1pK1lGdmNTNHRhUGUx?=
 =?utf-8?B?MDhPS29MVFZqTHlHNmczK01ZNWNLcGFldGVqZHNaYWtzVk9rc05NL3JadUhs?=
 =?utf-8?B?N3krZ2I1UlF4bG1xMDRnVGJ2T1Z4eUYrYUl5RzJUM01kZHBJRklpUFdBZ3Ew?=
 =?utf-8?B?SVJ2NlF1N01nNFByMkpXamI3NVZxVG9jT01WZVVlTUVNWFBYWW85ZjBmQmJY?=
 =?utf-8?B?ZWtsRjNyR0UvZjQyS2FNMGd4NHkwUXd5RTlTaG1XMkFIdEJjaVJadk9TM2NM?=
 =?utf-8?B?ZzBkWENtWmhWQ0ZTUkRDUmljUzBobDdYaTVyMjB1S1dPV2NKR2JUWVp5TnMr?=
 =?utf-8?B?ZTZDanpFOHFjNy9IU3RrNEwzdkJSSm42b1dwVllEUGJBV1dJck45ZGtDZDk1?=
 =?utf-8?B?RU82Q0tFZit0OEM3MElQZ3l1endVN1pBOHNqM0xNV1VaMWUzMldoa1FPaE5o?=
 =?utf-8?B?cVBqcC9iZGxVSG4yQnI3bUkvbGljY2FMOVcxSjFmUGV6enQvRVVZYjJiaWpQ?=
 =?utf-8?B?QTJKY2E4R0pRQ3JLTU1HRE9sYmY3N2ZQOGo0R25kbE1xUzVsb0JzR1NDbkxC?=
 =?utf-8?B?bzRqbitzRE9HNkxhSm5qaHhqelU2Qnp6aWJSb24reWhQeFR0NVdJTC92blhY?=
 =?utf-8?B?UW5PdWxudHRUL1RVT1EreTRQRlNhUWFEV2Y3MjJTL2JpYW1nUUtZU1g3TXRR?=
 =?utf-8?B?ZmVaQ1FKemZjOGtYbEgxMmJLUFdVMk91T2hOVk9ZUCtpeDZtU05SaUYxZ3Iw?=
 =?utf-8?B?NGc4TytJS1VmQUo4TmlFdFh4aXVQVTFRanVGLzBOcC80Qkl0blRQK0srUm5m?=
 =?utf-8?B?cHBWcVd6SHJyeElHOG04ZmtBWm5PQVN5d0RBbCs4SjdkNmZHbDN2NzJMWnk4?=
 =?utf-8?B?VVF1SXZMRkVqRGhmVUNta0M3MEJnVEV0UVFjR2ExTVNEb2JOcUNnMFBsdVV3?=
 =?utf-8?B?T2JYT3puSFFFb2VybGdseHlUUjU2cURIMFd3aXlFMFlBYUxJZmFFRVBWZHB4?=
 =?utf-8?B?YU9ucTJqcFJKc3VaVDRQSXQ4Vm00SER0VWx1VmMvYytuajRqc0RqaHFlRTFE?=
 =?utf-8?B?TzQ2R2pyaGIraUttb0pMWllqTFJyOVlpbjFnTitMSE8rS0drZkVKeXpmMlMz?=
 =?utf-8?B?TVZTSUFYbXVxVWhuelVuOXN3RGVZbnJIZ210dVdlY00zR1NkZjZWZFhsQVRv?=
 =?utf-8?B?Z2F4MENaSjVXTW5IU2hzTXRodmx2MFNRbm9wYXRqalB4cmh3STBwclc2Nk1L?=
 =?utf-8?Q?lXigX1fGS6OppJHQSE+I3AXwFZLNzZannM0KV+UJw2qs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaac387e-0dcf-480b-6efe-08ddd0fe82f1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 13:22:52.4054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXXkGt2PeQ72sJqzMumIFqkEI6HjKidpaCgZIDzvNvO+dx3lH5+rgHPO6ebKfWFAaIm7vzrzW7H6ZyfsVf+4kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8007

Hi Christian,

Any plan for a v9 soon? I would like to make sure we secure this into
the Nova tree as we are highly dependent on this feature.

On Tue Jun 24, 2025 at 1:28 PM JST, Christian S. Lima wrote:
<snip>
> +// SAFETY: All bit patterns are acceptable values of the types and in ar=
ray case if all bit patterns
> +// are acceptable for individual values in an array, then all bit patter=
ns are also acceptable
> +// for arrays of that type.
> +unsafe impl<T> FromBytes for T
> +where
> +    T: FromBytesSized,
> +{
> +    fn from_bytes(bytes: &[u8]) -> Option<&Self> {
> +        let slice_ptr =3D bytes.as_ptr().cast::<T>();
> +        if bytes.len() =3D=3D ::core::mem::size_of::<T>() && slice_ptr.i=
s_aligned() {

Another small nit: this is not a macro, so you don't need to use the
`::` prefix here. Actually even `size_of::<T>()` seems to work.

