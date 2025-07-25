Return-Path: <linux-kernel+bounces-745817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31972B11F29
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1161B161343
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402312ED169;
	Fri, 25 Jul 2025 13:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qNZcD53G"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01EC23F405;
	Fri, 25 Jul 2025 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753448895; cv=fail; b=GFgJ8LrIiXInxRhAE80M+j3AIS1Y1iytEqJ4TycC9Ja9gkMNhQFmd45eThFhGwOa7b3Ar6mvtkNnt0z8T3eMMj20oe4WbJcnc5PWsaNkSlhZfJKWQlLJPxczLJVU2wRSQyu/Qkm6PPjUsQ4q0vil/ef3ILQhX5jZAEM3X/Wjj2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753448895; c=relaxed/simple;
	bh=q4TpK5VbVZn71J6ewOJtf1HLQrxEBnrJdPaivRdPsH8=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=hibExhhEL62tyfzTcw2qmtoYoBrOHb19OGw5tMjX6YEF6FUgQwS7SWNrLlKQvcJ1AsklrUCZ8m/eEwZwNBTzpraiMNV9K567lgVp+xXvsIUdh61rtFRYhv3gAFGxtSl2s4gpO3wmHpRxHRsDDH0xX1mWwgKDx+6/A3BuFTkLcpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qNZcD53G; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7ssLI2MBXBhqPbb5Db2j6pN/9VCmmhpMv0Xd1QDoTeUDO8ejmVypXdpsEIB6Lqw4OqTHEZB/f5PKsBjTTizmwCFVHaDSaPKYGB5z5j1+8SZhBm9CHXRUtQkR4/0+1zhsPbSzxjQ8/V7qNAPeRHC+uiSIYz17eh8+WBpwkye9WjwTzlkppv94Ixm7CTUEs9DL9YBWuiu5ze/Bihf+C/Oa5IOzNrjwAFR3ZbAucR9DUeNA16AXgDcA8M2j33w9g0OUv9b1HAHqB+o4p6Fe1sTN135hvOWWQB5EqAsljGPb5YQnOQmix38VTLmbK7v4MbCrpfUXIxk8Fm5b0BFabEBmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xrJGerOsSlG4iB6I8LPDze1llQaAeIHCBWZxmD0qks=;
 b=p4AmeuFdTvHJBedcB/W4rUlSGhNXTDUm9cBqULgE65QB6WrUCtzCr+wVyyCYvkp8T9+TOb7aeBH+0np5Qe4AYK+U8AhSziXUWgu1NHu7+jh2RTY2ScDcLrSwYeifiaLkiXpJDty9AZ24wieq3N4KeLYeqGdE8qy5MRTqyvGYjwTlZzpyfKmcY5TySlsM4aoEXwIT+53BX4sLFUe7iR+wbW1wQ7FqxKuj10ivsYTFVnOUWtsfb6w6dIyH0HIJqgNZXAWA5GaSEV8HgKPiEhJ1YZW1AVjZss5nwvNxliDjNhKXc/hCH/C5vkD7/7ckRD5ZB9pjFVhw91rhqF2uBu7AOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xrJGerOsSlG4iB6I8LPDze1llQaAeIHCBWZxmD0qks=;
 b=qNZcD53G+B28bAjQsSM6tD5EF/DabrW7KV/9z0bwFKFgh2rgTvAVDNFEm6P0QpPgZzD+HuHSdz40YAXyPdcQYvddyWxNLuqAX+y/zHNdff4TqW26p4lSVtU889nd067A5YBvEitGXifgNTHdm8PY14dpyyNVMgQEnBn45mRX4uwng0h+jAjmVwWjc9oOEWQMdwRTC53JxhDnnMIhtaNOuW/9It8yiXktKcv0ho7cxz72mGGw/7YvbAW5S6KY4zJYPubvuUQM4Lxoq+qDZ7PuKBVaCL18UgXky+nE37m9FF05hrDoQDJ3n5VFLzC4kRPwDh5pCRgq5qZad7v0OQhq7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS7PR12MB8324.namprd12.prod.outlook.com (2603:10b6:8:ec::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.22; Fri, 25 Jul 2025 13:08:08 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 13:08:08 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 25 Jul 2025 22:08:00 +0900
Subject: [PATCH v2] rust: transmute: add `as_bytes` method for `AsBytes`
 trait
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-as_bytes-v2-1-c6584c211a6c@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAK+Bg2gC/23MQQ6CMBCF4auQWVvTFijqynsYYkqZyiykpEMaC
 endraxd/i8v3w6MkZDhVu0QMRFTmEvoUwVusvMLBY2lQUvdyk63wvJz2FZkYdzglPIaL66Gcl8
 ievoc1KMvPRGvIW6HnNRv/YMkJZQwXhpbd03jzfU+JxrJnl14Q59z/gI2eVBxoQAAAA==
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
X-ClientProxiedBy: OSTPR01CA0022.jpnprd01.prod.outlook.com
 (2603:1096:604:221::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS7PR12MB8324:EE_
X-MS-Office365-Filtering-Correlation-Id: 78894db7-1da3-4518-2efe-08ddcb7c4cb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWN2dWVldlp3MTRrZnRIWUlUMTBGRzJMVkk0TW9OOGVmVk5UVGdrMzI4bWJn?=
 =?utf-8?B?cEV1QW0zYnBxdm9UNElaNExrN21FNkZpdktrUmdvNFNIR1ZpMUx1VkoyVUhK?=
 =?utf-8?B?N1hGT3lIS0RWdmRnZXhrbWlIL0pNRitNa1ZZY283NHFzOElZdHdPNFZqZTFt?=
 =?utf-8?B?bnl4TGwyUFdhMzVXd01jOU9jQjlLeFE3OC9VeEo3ODBodkNYbnFKcVM5aXBP?=
 =?utf-8?B?Um9ZZjhoSUhSMU5uSW9idVM1L3Rnc1RycUlwdXFHSUkxck9wSEZnN0pBdW5N?=
 =?utf-8?B?N0FqcHNvYUxPaDNhZzVjTHNJdkRTeFREL3BRck03K212VFUrYSs5RlZXUW01?=
 =?utf-8?B?bFYzbGVtd1NsVjBGWTl1RFBCK2dIWHo3VDdacW9rOFd4S09aODQ3akVaSVYv?=
 =?utf-8?B?VUFERTBLUytxaWJLdW5JUHh4RE1qVTlBc2xCL0RHbWRxRHg5SHI1QUJ2eWNS?=
 =?utf-8?B?TDdyTTkxVzQrMUg0TWZwM3hvT0kxdVZnVU9ZSHFkemo5dHc5MWpRSHFRWG11?=
 =?utf-8?B?V2JkMUNmdXVsVmF1TFd2eFUwSXpYdjhGMFhPcUE1eElvaWJoeXUvaU5FUzBy?=
 =?utf-8?B?Y21BMlJNMlZIOXRNQVdSK3pIUDdnaHRKcmlwTEJZR25vL3VoNDlKU0VJWDlQ?=
 =?utf-8?B?cTlJVVVjOHZSOERMbzE3VUZITkYzYm5FWUIvYlc1QWRDR2t5SFRKQVlnRkt1?=
 =?utf-8?B?V1ZPbWo3ZU5WY1A5aUdtajFXanNRRjk5VkNKWU1aY294MjRTaDE3VkJDOVdh?=
 =?utf-8?B?YkZpMjREZ0w3YWJ1aVFUVTRsWEZkZVdXd01hT1R4SE9YQ0FRd2hHejJsWnd1?=
 =?utf-8?B?MjM5RjJIejA2aFoydVBkcUtPUmRDbSt1L2VyUzdiYVJRaUpSaWcrZEFrMkFj?=
 =?utf-8?B?YUxXSUp2dFdwSW5WbzZ5TzlhOVp1SUtHOGEzcEVCU1l5VTVaUFAvUy8rcUly?=
 =?utf-8?B?eFRJc2NQQUxUNHlWaU94bDhmeUtBNXJEM2M0TkdmY1JnNmFVQjdmK0R6Qldp?=
 =?utf-8?B?QzFwNU5PSEVjTEF6ZE9VUUhEMjA3OCtJR240QUlkdHZNT29pa3poNVZ0UEhh?=
 =?utf-8?B?WVN5YlpiM1VUUTUzdmRyK2loTXdhUmhwN052MkdSWE5BR1dFYmVvekZIUmo0?=
 =?utf-8?B?RW90WjRQdDdpaFQvN1BsWkppaWlralY1S2gwcE5pZllWUFJXMDZKU0l5ai8x?=
 =?utf-8?B?S251aWEwaUZIZytHS2FEN0I1SGdDaERlNDJHWWFNTmR3OUNRbnVQWWxZVlcy?=
 =?utf-8?B?MFFEMmtDZ216MDJMWkNYL1kwWThlWE1WU0ExSkYzRnl5b3dUblhuYnJ2RUVh?=
 =?utf-8?B?aFpQRjU3WC9Nak15K0x6K0VEVFh5UXRKeXMwNkhIZ1hRTEVLTHIvYWdyK0pG?=
 =?utf-8?B?SWRZS1gvZ2pDMzhHbVp3U1JLQTJlb0FoQTgyOUFJcmFKZndmRGdxOTV4ZTF3?=
 =?utf-8?B?ZlJtenk3V2svYmdLV2xoK0ZTZ3BqYyt1VzJ0S3Q2eC91RWRZY3hTdkRFREZB?=
 =?utf-8?B?MURQa3pjYkNrc0V2YVh5Tk5pUUh3blY3RXpqdHUxU01YemM0UDJhMFQzUmxu?=
 =?utf-8?B?MTQya1dVbjc1MmVXSTdLV2Mwa0UxRXk0OVhjWjZWem5JVjRSTHRjaWYvVDZ2?=
 =?utf-8?B?Tkkzcjd5R2NpSUEvUi9WWnRaVnRjeVh5SkQ3cm14RXQwMkViV0VwbEJXSGV0?=
 =?utf-8?B?Z2lOdGVpQTYxTnloU25odG91eStXOTdFaWYwa25YT25xZVo4MWdmeEQ4Y2tU?=
 =?utf-8?B?OWFCVnZLZkRkMjMrM0tDVEE1QkU1bDRwQ3NDTlJscVBOc0JibVBqYlZMQWk1?=
 =?utf-8?B?bGlidkE2Y3U3UkIycjhCb3ptU25DMmsxbzFXQUk4UzhIYkNheG83MC9rbGVw?=
 =?utf-8?B?T0JGdU9KRjFoUkFibFRTdXh6am1YWDVlTjFVbmRVdHFhUEE1TXNFeHZuRXA4?=
 =?utf-8?B?M1NzYmYyOUt2U1h3TGRvOTZCb3pKdldjRVJFeUdhMTVXWDNScUU3QWp2Rm1l?=
 =?utf-8?Q?G0R9qsW5jTk3wRBd3WSEobfbe0hTKc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eG0zeE5uMzd3MjV5RmJHVThtS2x5RmVKNTdpRlRlaE9scWdhNXF2Y05lU3hq?=
 =?utf-8?B?VHorSlMyT2E0enU1SldZTVE3WWsxVStOOVIrWUZZQjRWL0NaenFwZTFZeFow?=
 =?utf-8?B?Z2QydFlIa1FKc2pHRnlxeFB3OFBjcnVVK2xnaU82ZlZMV0F0TUlWODZ6alVs?=
 =?utf-8?B?UGlpc29OUVhBRFA5N3JYbUJjcUk0RjU0RWtsSHUxUjArNUJPQzJxS2xxUENi?=
 =?utf-8?B?RENNQlpRVGFiMHlnSFdyakF4TmtsS3dxUEFlbFRseFM1M25zQjVxTERSUjl1?=
 =?utf-8?B?eEVTdE5wTVAzZjFvc010OXlxcmU5OW05czBMeVlERnY1bnB3bzhsby9ETzRI?=
 =?utf-8?B?YVgrNGtBcWhSeVdxUkJIRXVCU3FoTE9uYVZ2RXpqd2ZpUGVCU0RXTUQ2Nkc0?=
 =?utf-8?B?KzJ5cGN3encralEyWkI5aFBqYitSbUt3YjRJWitBcGFEMG83TU1OaEdqblVG?=
 =?utf-8?B?WlFOVW1iVG4vQnVZdmZVSlF4R3QwVkJkL2NiK3oxQ0NTZlZjS2hwdk5PcFpI?=
 =?utf-8?B?cTFhTCtnUGdkZjNCTTJlNXNxdVV4M2R6cEhEU1B0UkVFK2hLeTlocVBDNVh6?=
 =?utf-8?B?b0hYY2syR1l3WU5OSXZFcDVicVZwZlYxempRWUt1eU5CVEF4T0JydU5zaEhM?=
 =?utf-8?B?TzFlYlBPbTFGdElHZXAzYkVubTdpb0FnRy8rMXVGTk1GUHkyd3B1V0NpbmVl?=
 =?utf-8?B?ekZIU2w2cENhL3MxU3lZV1p0a1dQWU9zcklMYVYvbEhLeGRzanozdmpGbFNI?=
 =?utf-8?B?ME5MWWtpTyt3cFBKNHdKbXdlL0pEQnBlMElSckxwbkFXeTdSNHJTV29BUktm?=
 =?utf-8?B?a2RZZUhHcWFjRVNVZDJrdG5RZlFGbllrODN5WW5GWkNXQ1JHMjR3VnZyYUpQ?=
 =?utf-8?B?Z3N3OWdURnpmOVA2WTFiM2ZNOGNIUDlwaHhJYzg5VzlOM1g2dllCRDhqenVB?=
 =?utf-8?B?eTErNmdKWnN1d1lWQ3BTY2xwTGFWUGNLVm42akFpbjRobWxmQmdLY0tSZ3VL?=
 =?utf-8?B?cXBBb056V3ZCOXd0UWUvQVcyQStWYUJuSmNZTThuYnlqNDB5TG9WQnM4ay9R?=
 =?utf-8?B?bWNNdjFvS3kwc0xsOUlRSW9JK0c1c3E1Mzl3a1BrcTlDdWFzcE1UbEdkcUJs?=
 =?utf-8?B?M3JpSEQ4Sk9VNXlkUHlUek96dm9FNm02cnhrL3NKQmw4b2J3anhyK2FQbzIx?=
 =?utf-8?B?ckl2b25VNFJjdlNCNDJBaFFmSDlHNWJlSENxMHFPK3RzREhNaGp2NldUNDdD?=
 =?utf-8?B?NjVPS3VnRjNBa3NjRHpyZ21ORjQ3WTFpQUlZajFlVE5FZ2JVeWVwcDJEbXlE?=
 =?utf-8?B?Zm9ObHpBS3dvS21iZHA0Um5Jemtwbi9SMHg4SDFWRjQ2YlgyZzBLMmRxOXJK?=
 =?utf-8?B?VWJkL25XR21RWkI2QytUN1lpT0dkc1Z1ZUN3YlhtNlRTR2FpWDlXTDFqbXJX?=
 =?utf-8?B?cjRKNWo2YTZKc3J2MmRKdUZ0UkJaK3BzRS9wTmNKN2hHRmJWaFhpQ1JpeUx2?=
 =?utf-8?B?ekRCVkYwMTQrcExrM284YmR1NUVvdDZobzlZSmx1RDRtVjdiTkJZcmRsYlVs?=
 =?utf-8?B?MWpsbk9HNlVJMi9GT3NsVjQ1SUU5ejVmWnZMVzRkaldDZUppODlWZW1TUXVR?=
 =?utf-8?B?VWJTZVlFZFBnZllZRGtYODlOaC9aZDZjWE02bUY1RmZmcUhTa2hVaHgxdXha?=
 =?utf-8?B?bmN1RXErN1R1RnEzTnA1UW5PVUlZUS9RUTJEVnB0ZFZxVkZDY3BQUzlhRkwz?=
 =?utf-8?B?YXl3MnJvZkgwRnl2L2NOdU85clhsaTRYcitXcjc1eDVDU0N3T1BsYndoYTl6?=
 =?utf-8?B?OG9jdnlLbDdHelV1U0NLc1QvME5FcmloZXNLWnhpcHNMeG9CdnhXZkhDT0t0?=
 =?utf-8?B?NU82LzFvUG9JVmhIZGFaemZ5U29uS1dNaCtMSmJvV3hhOTJyZ0d6WmVPMHdy?=
 =?utf-8?B?OFBEZU54eFNYMFZDQVMxenM2bDV0OTdhd20vbUZSQTZTb203UldiM0cxT1Uv?=
 =?utf-8?B?RUJDL2xyelZweUZXVVZRUFpMNndqUGhsbXQ1aU54aHh3amFmL2twUWVOaTQ5?=
 =?utf-8?B?MU8raHZ2YzFOR05nRGo0MXFDWlNzUWI2ZldrSVNORWNyTS90SDd5SFI4THhm?=
 =?utf-8?B?Zk9MQ05xVStDOUJzTmhVeEp0ZFhEaWJwbi95bzB3OFpPSXEyUVRnaTJ3bTNY?=
 =?utf-8?Q?pJEUoYVHY+JFNmcT0FGERmR0R35rhcpNHvQlH+xaLiKQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78894db7-1da3-4518-2efe-08ddcb7c4cb4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 13:08:08.2317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 48JKHphgmDaB1QMKNcUvmK1RpB6C8b8oBq/OJYzVF9RX6o5q3+rObVxttItvrat5tdNjJ92aN6/47i3nkHMXhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8324

Every type that implements `AsBytes` should be able to provide its byte
representation. Introduce the `as_bytes` method that returns the
implementer as a stream of bytes, and provide a default implementation
that should be suitable for any type that satisfies `AsBytes`'s safety
requirements.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
This is the sister patch of [1], providing an `as_bytes` method for
`AsBytes`.

It is going to be used in Nova, but should also be universally useful -
if anything, it felt a bit strange that `AsBytes` did not provide this
method so far.

[1] https://lore.kernel.org/rust-for-linux/20250624042802.105623-1-christiansantoslima21@gmail.com/
---
Changes in v2:
- Use `size_of_val` to provide a default implementation for both `Sized`
  and non-`Sized` types, and remove `AsBytesSized`. (thanks Alice!)
- Link to v1: https://lore.kernel.org/r/20250725-as_bytes-v1-1-6f06a3744f69@nvidia.com
---
 rust/kernel/transmute.rs | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
index 1c7d43771a37b90150de86699f114a2ffb84db91..d4036986a3d7fb97e5da3e121e9590ad23b784e9 100644
--- a/rust/kernel/transmute.rs
+++ b/rust/kernel/transmute.rs
@@ -47,7 +47,16 @@ macro_rules! impl_frombytes {
 ///
 /// Values of this type may not contain any uninitialized bytes. This type must not have interior
 /// mutability.
-pub unsafe trait AsBytes {}
+pub unsafe trait AsBytes {
+    /// Returns `self` as a slice of bytes.
+    fn as_bytes(&self) -> &[u8] {
+        let data = (self as *const Self).cast::<u8>();
+        let len = size_of_val(self);
+
+        // SAFETY: `data` is non-null and valid for `len * sizeof::<u8>()` bytes.
+        unsafe { core::slice::from_raw_parts(data, len) }
+    }
+}
 
 macro_rules! impl_asbytes {
     ($($({$($generics:tt)*})? $t:ty, )*) => {

---
base-commit: 14ae91a81ec8fa0bc23170d4aa16dd2a20d54105
change-id: 20250725-as_bytes-6cbc11f2e8c3

Best regards,
-- 
Alexandre Courbot <acourbot@nvidia.com>


