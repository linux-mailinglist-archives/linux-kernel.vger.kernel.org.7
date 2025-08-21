Return-Path: <linux-kernel+bounces-778923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82047B2ECC4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E64A5E1E9D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85F028D83D;
	Thu, 21 Aug 2025 04:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H3gBclg8"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1C927A465;
	Thu, 21 Aug 2025 04:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750524; cv=fail; b=o0rlt8K2DLkCS9VIPMfuqZWGZcwfOGT7EnLi91ihqC5S9xC6OdeXJ9+YG7ZzQKPaE8MycZjN3UoyIPb8Il1661/s2YU8REEPIkni3afG3/dl+2W5UqlvHKc15oW24mXdBypx3M5MP59VNOkV0K5mOrXfFdOsxya8FKdNlCBIkHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750524; c=relaxed/simple;
	bh=PSEJgh++TnIXBwfYjkaplRFV+K6ikzqNqIvC7no/8/8=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=Gb/FZ3F79CEtEQW8reLChrda67/ZiLSRjf8/wX0Vjevxgzcdm9e5VnF70N71KaY0/aHyUhBu37DvCvXdfiBRAnAPs4oxuYS8m6w8N/cRbjjvJRRGXMuBIbAWPnB4l7svsJOr8s+SjmIoj0coXItRzAmOUCSmD+COCYBoN9/r3CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H3gBclg8; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=meZ0jkEDzrQx97daJwmxM/WFJtcBnBh18/34yOOwcI4dkYTZtw9ACu+ueal2E0XSAoqN7WhUvFMMJOBH7tJksPz7aMHsnJQaM2yNYeBiB6jW22HIAtI5pKJIq808JwDnVTHgbPkxvc1JmvMMIhrfNYMJcI3Kv7OPWP41/za0QXmBSG/iwyl1WnUjB6retbjdxQUUOlWj6EFKdFAkiBetPp9gEIzdsMiQ27tg1LkztWeQRnDEMUZo0LZoikVTRhZOIPjVtmMRhtEOeem0yaS3PpmOwj/ug6TkCYKeD+6KjMJspiPBxqGB5JMLj1H7iO6Lr8wfSrkqs+kBGDRYqy57rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSEJgh++TnIXBwfYjkaplRFV+K6ikzqNqIvC7no/8/8=;
 b=Vg9hdlZgbxlk+ISX/8Ven3Jpmhe25DhfqEXKlPgv3fQvChqiCsZib9B56b8fuu0qQdzg/LrwhOP1tEp8M4mUotveLBJDG7YnyGJcUA7njGpZq1Ot1lKD2C/PkrgjQfcCvLF8qffCddhsvE0JG9VZ53OyylgNDvm5rdXGMSt5t2Nk8PiMsemLd1CgONE3iPhhid99KTjoF9/VQudKMyN8feauo1we7coMXm3pW6bRB7fjSBwin/i2OBnYSHcPgH3jN8MhqJ2vNB+8sZRIyZqNDrbSXSQcgLoAPgS0ECkraFMb8FMhmMUZmCr21RfJ0TQUTjrREoaklOtOGzZlQmBw1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSEJgh++TnIXBwfYjkaplRFV+K6ikzqNqIvC7no/8/8=;
 b=H3gBclg8aPCTigRMvaMa1VCYQxwufUeStNgD7jHjZZX63oh+IkJcP0wSDdoWc4v8eIFhA0+efIeE0qpMBDnbMffN2tTB1K7cfqJEnUPT2UZvXHZ2Gh816J4CrlEQJ/awd/gf9uTeFJMi8CKMxpBMIgmb32chDSarjuUCzXoecsWJBiW3KU6nmoM92Q1aJOjHwl4IuQF81D832RcKOVI+ABR7g/Ibzzl3nOMmasZDwpTS1b3m6tGxj75/R1m63cMUy545wuw7/7gHAw68k+9wgAS44sZx6cPAq6Ty2h/oCR0XIfkG8Mi9+Hz/wWmCrdjvzN/ouEKCGQCSuUR58t3mag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN0PR12MB6032.namprd12.prod.outlook.com (2603:10b6:208:3cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.21; Thu, 21 Aug
 2025 04:28:40 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9031.023; Thu, 21 Aug 2025
 04:28:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Aug 2025 13:28:36 +0900
Message-Id: <DC7TM44KSWRV.NOS616JX1X61@nvidia.com>
To: "Shankari Anand" <shankari.ak0208@gmail.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>
Cc: "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] rust: nova-core: Update ARef imports from sync::aref
From: "Alexandre Courbot" <acourbot@nvidia.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250820112846.9665-1-shankari.ak0208@gmail.com>
In-Reply-To: <20250820112846.9665-1-shankari.ak0208@gmail.com>
X-ClientProxiedBy: TYCP286CA0261.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN0PR12MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b494f14-f67a-497b-804e-08dde06b33f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmFLTTVqbVAwbS9DaFYzOFNFdUpQRXVFeVIzWEhxVm5XNS9pbzMvMk9vclZw?=
 =?utf-8?B?c01kK0hiVkZjNFRXUUdOME1BWHNhejVIeFRtTUF2VHVuNW9UYXRxbXg3TWlz?=
 =?utf-8?B?WDZEc3ZVSHRuUzdlNEUzKys4TzRJVHFHR2c3d2tIZ2lEYXlESU5DNWZzZFYr?=
 =?utf-8?B?ZWZnRWlrdVkrOEhMNjFKdEZJTVdvcW96WWRPa0RlTmFkYVArZlNkcjh3UzNZ?=
 =?utf-8?B?UDN6SmhCYUNsL25XcWRiS0ZRTjdNU21CZHUzaWlrd2drYk10Y2VuQkV1c1FY?=
 =?utf-8?B?dnNNRXMzT1Zxd2JqUERhelAzVjVRQ0xwYytPMU5EOWxueGprZVR3aVg3ZkYz?=
 =?utf-8?B?QjJxOGZJVDJsdFN2OXJQWE1iWElla2Fkd1pxVGxLNlpNS1RhVHpDNHl0N21X?=
 =?utf-8?B?MEczN05KWjJIVlZuNVVxTHBSc0hlSDZHMFk4R2t3enFnMmhwUVJ4Y21kMkxx?=
 =?utf-8?B?R3B0QUN0NzRWai9kSjFpN3BWWFlhT05tSlNtZGs3VE9hcUlRZmlWU2ovSW1K?=
 =?utf-8?B?OGE1Q3dxV0IyRTZVUGJiNUNKUWt4eUp1NDQ2b1hTVUk2OEJLMURIMXpJUWtR?=
 =?utf-8?B?Y0pEdVlpTjVUSGhTMXpUVWxqaTNlM0NmRHhxemg4ZjlBc1djYVFLYjRTMmhx?=
 =?utf-8?B?TFBKVFV1RUNWTUVPQkp1SVFtZThtYm1DWkhMV2dXenZsYlljdVpDWXowMG5U?=
 =?utf-8?B?T09YdjdnUmlPQ0FPdGVaS3Y1NGRMNXUrZEY3VmJrV09OUDZXYzBCWFh3YUw4?=
 =?utf-8?B?Vi9QSlU0WmhrdENScUhzc01lL2Q5R0tzUWw1Y2lXeU9VbmtpRDd4S2Q2d1c5?=
 =?utf-8?B?YithaHpmVStCSVhGRHdGaC9zYjBIZFliMGxpUnpsOU5VR2tEWFFCMGs1bEph?=
 =?utf-8?B?dzE4RStlUzBQaUN0ODZWZC91ekwrVEY1T1Q3TVMvaUZ2Uzl6NWI0djNNb0JP?=
 =?utf-8?B?R2N0VWVScWttT0U0M0pHbllhV1JWcGowUWVveFBaT3FtbjlGc0dNRWR0K3N6?=
 =?utf-8?B?QytLNkMrZXd6aUxXVENQd21yTWswQmtCNU5zUnNwQUU3Rjk3QjBGNThXYWNy?=
 =?utf-8?B?RzZKa1p2d1oxNVNZaG5oZU4rRGdqazNPMzZxZC9naWIzaUZuclFUNjNjbnR1?=
 =?utf-8?B?Nng4aFc4d0RSaHJ6cFVqTWxPNWF2MGlod1B2cHlQRUpGTUpkZzJ5SldqQU1i?=
 =?utf-8?B?SzQ3NktXYkl1c2lQcHhYbG5BZHhOSS9mRDEvdEJvY3pYNHhWeG9kT2N3VGc2?=
 =?utf-8?B?UFYySVlyYXRrWFpZWjhYQ2s0VWpkQnZtTVlkTHZ3R1hvU2d3VlBWbWNuNlJn?=
 =?utf-8?B?ZzlrNDFPM0MvNXRGdTFsK0JDN1BTNFk0ZlMrTmphZE1BbzIrVHF2dmJNRnJ6?=
 =?utf-8?B?eTl2TlhyWFo3bC9YOWpTaTJGTHJFYmNRa2sxSkZTWlgrQXVobVN5Qzh2R3h3?=
 =?utf-8?B?R2tIWlJ5S0w5SWRSWW9peWtFR2FoN3dhazJmYXFTUU5ZVGVEa044bC8vYVM5?=
 =?utf-8?B?NzFlWDl6VnovUkM1UGFPNUc4T3pYWFFzZkJUS2RSd0pYMnlLK2RXbEM0YzZa?=
 =?utf-8?B?ZW1ENVdBZk44eGF4KzRlWk5wcHJ0cUdacmlkajMycFBBWGFsNk5SVU9KZGJJ?=
 =?utf-8?B?VW9CWHZrN2hIbHdZNmtIMnZoUGZoTUdJanlYZXdXNG90Q0NHNWJ2TFdWbVRN?=
 =?utf-8?B?OEpDOUhSK29ZcXhJYkV1VnBhZFE1ekY5Ynd3UThJM3lxNjAzUVlpY3NvM2tn?=
 =?utf-8?B?RlBpdkNqSkh2QjQ2bGVSNVpxWjZJSVJ4dVVvSE5xZXE3YVFVbjRsVmc2cncr?=
 =?utf-8?B?NVhKMWNGUHB1SjVnZGI4eHViZDhVdm8rdHcvU1FDQmZOeGtUcW9FMWFxRlVl?=
 =?utf-8?B?dDFIRnRDL2F1UlZFYlZNZVhpVXZkdFloL2VIT1dhcnhHd3BZTnkvR2NYNTdJ?=
 =?utf-8?Q?6L6BFBDwsIU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVdHbkMyZWx3UStuYysrVjlIQVlMNi9uSXN2eWc1RkVzamRhMVhyUUwyWU1L?=
 =?utf-8?B?L1dtVHQ0RnA3ekZzclQ2TmlJQmR4enFLeDJpWHFHKzFRTi9KemYzSmRob0tL?=
 =?utf-8?B?dm05eFFlOFNZdzdPb1VUaHYyTFAzdzFRSGVieWdwZ0ovOFlNYy9GVXFZL3Jv?=
 =?utf-8?B?UkRqdFBRcGlHdm5aSk9hTlo0RTlCS1ZiTmY4RmFWNXBQcVRrSldEbHlwNEwy?=
 =?utf-8?B?Q2JuQlpKZHcxUlhCNUY2bkhoVFl0OGRvTGRMdlM2c2kwd295V0dUblQ5ZHZj?=
 =?utf-8?B?Q29vd25rcGdvNzVvZm8yemRRUWp0ZnMzMkR6SnVISzNBL0RHL1dPQWpQVnd5?=
 =?utf-8?B?dHdxRm1IWmxFd3hNWTJDNGhuRmdFd2ZNdWpQVGExaCtTM1B3dmNOQjNnYlVQ?=
 =?utf-8?B?em9tZEtkVDhtOWdJOXlMMjNOeVVkSXcrQXBOTFZGWklDaGFCMWI0c1hYYlBr?=
 =?utf-8?B?RkNIckNrMkVnY3VBMGhQRUtMSk5NWm5EdUhaOXJ6UHp0WFlWK2RPMWM1RmVG?=
 =?utf-8?B?dm0zdTNTYi9EYTlpQXk3ZWhiY2R3K0Jtc0pPc0hNRStTL3dnMjFQSUwrQjNI?=
 =?utf-8?B?RzV1UEpQTkRNMFdVNWloakU1NlI1bnl4aWl5RHUzUjNGeTdDV3h4VEQrZTNq?=
 =?utf-8?B?Uk5mbjNiaUxYSFNPZjgzdUQydmcyQlBiaFhhbmZsUFphbHY3eks4T2RMSDNK?=
 =?utf-8?B?bG1vWjFwMnlLUFd3cEhBaThFaENJVVc4KzdSYzZtaGwxSlkvUjk5eFlYekhq?=
 =?utf-8?B?NDY3L204M25rRzRuOUNRSHVPOGFnYklXOEQyeWhxdVpISDNmNCtMTWFWSzY5?=
 =?utf-8?B?ZjUxdldyWXFIM0tRVXE5UGFmTzZhK3VaNThlT2ViVlhUWmdaU3FUelRMalV3?=
 =?utf-8?B?ZGlzamdGRm0vVW10SnNQSHhxdE9waUVhbDNCZjIwS0ViNlY5Z0E4VUtpVkJG?=
 =?utf-8?B?K3E0VHR1S1RyQitaZWM1blhIUGwwVzBwSmpmZjBvRnhRb2JUN1FNNGdZaTYv?=
 =?utf-8?B?dGRIY2JyQ1BVSUJHOW9tV3Iraks0U2tPV2tKbUxMZUNyRktVLzBSRUthVjV5?=
 =?utf-8?B?MWJMUjFhTEpaSnE5ek5teHlSbDZEdzcvem1MK004OUZoRGdkNm8rTGRIRm8r?=
 =?utf-8?B?TXNUZjJLbTBLWHoxbm9SNU1mbFpaaURaRUhkOGc1ZFl6NStOUHFFaWVIWmVo?=
 =?utf-8?B?WXgrdVY2TmFIWnRpZ1FEN0syaTlSdElrb0RpOGxVb05QV1IyR1REc1F0OVd0?=
 =?utf-8?B?WnVvUTQrZ0Jmd3Fsb2w3ZUF0a0Y1VkhBd0dGU3c2YTN4VUdhNmRlOTRHdmVy?=
 =?utf-8?B?cnhBL2YvcHRyVlI0Z0o5eE5pZGdjVlUrL2NrWGxJRWxPYnNFaERiRzRIUHNG?=
 =?utf-8?B?VDIvbWJITjlHMU01TndDaURRQzZSVWNUZTZZSit3Vjgxc0RtWmFMQ21CQUtQ?=
 =?utf-8?B?OS9wQ29XRklIMjZHNFc2cXlJWWFiM2lVa2k4bjFEbWdMbW5yV0FRZk9idmo2?=
 =?utf-8?B?d01DaVh5NkVWeWJTQndYU1hXV3o0WVRKdGN2WEFzQUJFb29ReEV1MXZ5K3FM?=
 =?utf-8?B?bVptOXZuMXFsbG94Snc3U216cXNYdFBueVBUenYzUVQrTDQ1VjVzSEg2T1ZH?=
 =?utf-8?B?Z1ZvWkkwejFtL0RCdHJGWVpWNVhZY1lHUHRmMkdIZ0RvQXhHbUN2cXV0bHRl?=
 =?utf-8?B?aVJpU2FjWmFaM285dnQ1RVJkVmRLUWttSlNkdWxmYUI3Sk82QUk0MFdKZnpN?=
 =?utf-8?B?N3pKOEFROXlMM1oxc1I2a2ZrS09Sd05sNGFwU2ZXWTUwRVdQMTgrYjIzRytl?=
 =?utf-8?B?MXJJeUlqR2V5bGJrcE5oMEhJRXh2RXptbHBMZy9sa21qajlHKzdKb1hYSm1M?=
 =?utf-8?B?bDBrZGt4Q3JoYjQ3ZjBVSk9temk2dk9teVVVMXFaQVRKa1phTHlRT0dWSHQz?=
 =?utf-8?B?NTJQU010UXBNTnNlUkRGVzBrT2VQMjA0WUxnTWNObU9wRlkrMS83UDFlYzJs?=
 =?utf-8?B?UDJReG81NHVLc1NvN2tNaGxzakZTRzdsQTdSTElLdGVJN2xES0gwKzhkemNy?=
 =?utf-8?B?dEJNczdsVkJ6S2lBeWtzcnUzNW5sNExzRlJCYUY3TjJIcVcxSEk4ajdjNnl2?=
 =?utf-8?B?dFppcC9uK1RlVnpuR1JmVERxMVpTVkY0V3gzcks2NmpRUDlzWFFrQmt4OG1W?=
 =?utf-8?Q?CHxwNAdFOZb4NHJgv1JUysAcsexrBgBZNI5dLziQud51?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b494f14-f67a-497b-804e-08dde06b33f4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 04:28:39.7738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xfl3rY/dA4QmHxmTbq9XP/k32peIcsMyD+ZdserQeRCefXS9raoEQohQUMX26Y123H+KLr+9EUeMhMP9LP7MKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6032

On Wed Aug 20, 2025 at 8:28 PM JST, Shankari Anand wrote:
> Update call sites in nova-core to import `ARef`
> from `sync::aref` instead of `types`.
>
> This aligns with the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to sync.
>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>

Thanks! I will push this into nova-next shortly.

