Return-Path: <linux-kernel+bounces-764846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1BCB227F2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD98B1BC54CB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD2828467C;
	Tue, 12 Aug 2025 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qvfKVwB0"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2E4280037;
	Tue, 12 Aug 2025 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003647; cv=fail; b=RAcUFAR7GpJA9+8tY5lpOWZazVudnFZAWLx5ij2sgERxJt3/JQN+kMV5hQKrQkffNrkIpr75DZi/A9GYN89WoS3YnFDVFu21pfCU3GDD9EbuJWNegAU7JdssSJFJgNEh0MBuBNAgxsav6MZlIEEu/7EafT8eX4y17pYtLiQOYHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003647; c=relaxed/simple;
	bh=HGLr4pvOHkBaYRlLvestEnRGrdwndTsvoYi62IveGvg=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=sc4Ayr5m6uxbBTsBNvC6IX/8Rax44UVdudjYGLVu5NGolTDs3R6+kpSj3WPIwwjleXRvD7mj6nE4mRFkillax5z57tJwfzgGud9LOLAQcdZqFOlW/4LcFOWOFfVjTp/BtMU1MQJfo+pSdPBTnYIXJ2x4aJokwpfIUW4fWTipbs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qvfKVwB0; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtMI+7DcvpsnpKq86Fw92tVrT4n8Usp5wUV8U2GUCoYTtZptYrx4zYZKKYM2sHGsNUQ6LzzNPwh7setsfz787WcYKAx7k+pJnNI8jhAwYnPjBDm+1bql5ziNdLKIOE/tgKSeI6rTkn7Lwy26N93bKjIdN2va0Y35yrz9PnbpkzWX3B5MCLGQkc2rOI4wiUxVrypxMdUYd53A1/SHtBQvnmi7T7p2+z7+QSFeNWGAfN9XsdRPZZxzEmPf1GAv1+SGk/ZwcLmZKyxBUHTqSzBW7Cc1KEQLkhd008e4n9k75KhFvYMsexpfZDgGBCoWloB9OD1XQBmhMEcJz73ZG5XE6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gmo1twd+Lhz4RGOz4ixIzFbobyJOoojRsDNASyr/3AQ=;
 b=R5NwyEgq0185Gz4v9Qqp5S36nZxkZtvBCabrZN+t4xtC3KGXyTP7rv9CYSngE/Y/gvUsPynaC9rnybFV0aBu+kHdIDNLfTzz1xOTQW4wig8dktdGKf36lNNqadvTw3EP4YHuITBCwOJmGtbEkMHcE15lcfx8SEFV+T7HKKdOwoE36BVE289vgdUkAHD5tn972rQMlWnWcTH/LkAAn4KXk+qs1chXMJ+kzbZ9nxWuAJsuDkcBrDm5R0IvxsxKAWdlbxsXjU8DLoWXLj/CY6kfqI3MWkeZHgU3KblJyttcl/vV88AXI39Aolx7/aZtID2p2INef3Vey3j7clsSpPX+xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gmo1twd+Lhz4RGOz4ixIzFbobyJOoojRsDNASyr/3AQ=;
 b=qvfKVwB0Y76rgXf6Txxfi4edzJDGCQgSB0CoTAGDxcaxemZUqBzonuVyfHeFkJ+GRHLUzfrmSaMjNm2l6GnBsJ784NAUZep1lw1N0Ut64dIlmb0PtyZHQ0yuVTpdXXm5T7ova38Fcm5VvZJz1oNrxFs/W0SVvAo2l6xQutSKy2fu642z1HyKzi3d1mVdWAkhgFmqlq/17aoiG/NdQVDqWq3qFPvEC+4w6MNiA80ChGBTfqT5vr8Abo781LrU8VlFjUdYVXEFQOU5NBskOJVgslXymEF3+pw+WWYRCEmTA2F3W8DyABjjHFCdRtyl4XkRxTDLdE57nMyim++ieewNBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB8563.namprd12.prod.outlook.com (2603:10b6:8:165::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 13:00:33 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 13:00:33 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Aug 2025 22:00:29 +0900
Message-Id: <DC0GV5DU4GGU.1G4FLQVXU62VI@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>
Subject: Re: [PATCH v2 2/3] device: rust: expand documentation for Device
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250722150110.23565-1-dakr@kernel.org>
 <20250722150110.23565-3-dakr@kernel.org>
In-Reply-To: <20250722150110.23565-3-dakr@kernel.org>
X-ClientProxiedBy: TY2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:404:42::26) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: c313350f-3894-4aec-bbd4-08ddd9a03910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aExHMzRmckRVMFFLd040Z1JIcHllTUkrL0YxUEZNK1FuMC9kelVpNEhUVkRN?=
 =?utf-8?B?VEUzOVpMTWVRZ0NtUzc1NkgxU3ZXcnBJVVA0YW5hWXFnRVJwRXA1dTRvZzdR?=
 =?utf-8?B?UjFJUFowclRZcVF4L2tWMkFHenhxN2NDWEpydVRPeXdTQWdIdTlleDJSZlhi?=
 =?utf-8?B?SGkyWkUzYkNvazNXekVwWm9ud1RRNlJqcUhJeHRlblZ1ZnE1Z2MydHBFKzFj?=
 =?utf-8?B?RHJpbWZnTS9CYUxKSXdTeHBaaFptcytsVUlwUzJSZnRpZ1NXb0wrOHZCNjJL?=
 =?utf-8?B?OGlVUU1nRXp0M2tQejc3VW96Q3RCdm1TRnFkV2NqQkpxRVdYMzBHWms5bzR4?=
 =?utf-8?B?eUowUExDUWIzNnNrMjZtQlQrY2xMMC9rL2Y2NEZScUpvSnk5WkFCdSs4bERp?=
 =?utf-8?B?OUJ2c2xZbFpkTEIwNFBVUi9vV0x3VmhGb1YvVGpmRDNQQk83R0JGMWpBWGNL?=
 =?utf-8?B?U0JWV0tuYlNLakRJZldad0dYdkFsSHpFRy9wVjNVcjNlWllUZzhLVS91NFBD?=
 =?utf-8?B?YnM3SjlUaCtOLzZKSlk2Q01QOE1vZDNGS3lzdFRqL01iMlBHT0w4TXQwWnNl?=
 =?utf-8?B?Zjh3WUFBNE1pbHd1SGVxaHdBMEVpTWxEclc4eUlnTzZYdjJzSFY0aW1KNk5T?=
 =?utf-8?B?YUhOaHVxSmtBd2hSazk3WW1hWElpV2Qxd3d5Tm5PSWZTMmJuZUlYMjBnQmxh?=
 =?utf-8?B?RHluSXF1ZG1wN1FuMjlXTGVoT29HQ09DWEQxRmtaQ0tFbi9KdmVSM3Q0WWMw?=
 =?utf-8?B?bDQra2gvNEhpaGk4M0pYV20zT0RUUVJleFdXRmQrU3d4NjRsL0haUVFsTDIz?=
 =?utf-8?B?c3ZVMGk4TTllanJYWW9MbVhHQVJhOGZaUkZzRTdsZDl6UE84NGc3NzRTZUh3?=
 =?utf-8?B?cFBiOVpRRUdBVTYwdWt1K1l3UWQxOWdKNWpIMWpQMkNKaHRicWkraXViMFkx?=
 =?utf-8?B?RU1DOFdUOUdnYU5vRVBqM01VTlRUUEtuTTlpMW5aWFF4MU1Hbll3VzVTVnAx?=
 =?utf-8?B?RW5IalFCNHFub3U1SFRXdnE4eW5SWnloN3hhMW9LeGVKRjJ6OHpIVDllay9y?=
 =?utf-8?B?WUcxYzduNDVtSmpvOGhySWVERDJrMmd2eHRpRjhEV2R6YnM1QVYyeUY3UGZa?=
 =?utf-8?B?ZXA1d1NPeWMyR2tIeTRMcGRJK0dQVFU0aXZCY0VRMXZQN0lXR1dRK3B0bVRq?=
 =?utf-8?B?RzJKYUVxMFh1dDJFSHJiampqQ2lRN0RiN2pVVk1jMzVoZWVHL2FlSVJpMEo3?=
 =?utf-8?B?VHN4RVdJUXNxZjBnNHdOYWx2eEZ5bjI2M2IvTnZrczg5VzkvaStobm9ZUnVP?=
 =?utf-8?B?OEUrT1IrUUZsaGp0WG9vMGhEOHBmbmRJcUZlVVhKK25WUUhNeDAzUkI2U0FC?=
 =?utf-8?B?dFpaN0hEQ3p4bEZTNkJFZFR1emtYdDI3KzBva01jdmdqUTBSOU9ZN0Z4V2xa?=
 =?utf-8?B?cDhXSnBvS3NOVFBoNW82VVA1Q1V6WDhSTGdjZEZOVkgwMjl6c25Ud1FtSkhZ?=
 =?utf-8?B?WHNiV21KNTFXNHFiVFlPSHZtNjhjNld5d2JlVnhqbjd2SHd0akRoNWxIRnRP?=
 =?utf-8?B?d0VzQSszVHFTRW9rb01yVjZiS0V0YXlKSHAvYU5PazJuNWpUTC95dDFwRXhN?=
 =?utf-8?B?OS91VlFndkhzYm05M3ZlWmpxTllQL2V3cy9yWHkxQW5lQ0RNSGE2b0JCY1N2?=
 =?utf-8?B?Uk9JclVxa09LREczdnd0R3hoKzRTbGhFem1VQlh6QWZ2SHppSFRwQk5naUI1?=
 =?utf-8?B?aVNXRmtEU2d5OHBzZkZXckpoNExoTnhRWlh5TTFVUkJFMmgxaWlGeEhuU3F2?=
 =?utf-8?B?aU8wSi81WmM0cHFUY0g5VXl4OXZZRjYwV2lDOFg1U1JHc0xqT0FMNzNZb2VO?=
 =?utf-8?B?SEd6aWEvRTRoZlU0ckNKQ0cyNlI5Rjk4RkpwOHdxdXlETERsVS9hY2U5ckx4?=
 =?utf-8?B?bGxBa0lKdmJWTE1CMWgzV2NMTEhpK0lnWnM0YVdzWEFLaWhOZUlDSlh2c0tn?=
 =?utf-8?B?M0pEdEhRLzZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzFENFlXMk5ZblF5SWJOVHpaQXI4cUI3OUwrSU85QUJ1YXdxKzdYNWpDZlh2?=
 =?utf-8?B?U0Z3TjZ6V1FHNVptbHhDMzEvQWFRNUJMdU5HSzZGVkozMVlKRkFwNHVEcEht?=
 =?utf-8?B?NWppZDE5dkZmMFAwTFJxM29XNXNHV25CR3Q3Z2VWM2E5UkhHOUt3bFJLcVly?=
 =?utf-8?B?Y1dwclBjSVhCbnBXVm1udEtNWWcrSUlCcmYzdUNCajR6UHRzaWpmeGtWTk5E?=
 =?utf-8?B?T25Fby92aExCbDlDU1hwTHZyKzFvb05lTXo4RXFoYkhIZUh1Q2JZcUhMdksv?=
 =?utf-8?B?MnJVdExieVRQa3BNSTk3cDZBRlN5WVhFd1ZDNDBuWm9EQzdGc2Nid284eHhx?=
 =?utf-8?B?RjZPVG02YTdYRkt4K2NCVGpDc2U4amZSb09PVnptVFgwVVVPNEErRmFWWC9U?=
 =?utf-8?B?VXRqQjFHNEdXOStVM0lEclpaMFVhczlFak1tRFZjVDNoaEsrMENpSTRTUE8z?=
 =?utf-8?B?c1ExYnhxZ3c3UzYyUFMvZjFVWkhEQklucUJtY2JUbGpRWFNhMXpFa1IwVFBM?=
 =?utf-8?B?dmNuTTZFaFREa01laGVtOXB2bU5wNmdxZjZiRHl3U1A1NWxLQ2tlY0psMDZj?=
 =?utf-8?B?RnJCNDJSUnFValZZSEpVWXFkUG9IRmQ3MFVCcjdFRE5KYUluK2F5Tm1YcWFi?=
 =?utf-8?B?ZmRRa0dodjEwRDFxcnBpNjllb3ZiOHNFcEM3TXgzZ0hvYXhEb2crc0g0UVUw?=
 =?utf-8?B?LzBGL1JPbDUvdmRTMGl5RlhHN0tReGh3R1RpMkFHWnp3ZVk0dkdTZzlFMGpQ?=
 =?utf-8?B?MnVFelR5Z2hLNWpoN1VpSGZFalZjWXhsVWRXd2xCaFhlKzVFOUtUSFlNNEJG?=
 =?utf-8?B?dTNnNlllZXBHVDNRVG95RnFJK3IxSUZiVFJLdTJNZEpybjQvazZ1R0R1K1ZP?=
 =?utf-8?B?b2ordW9CVzJHb3RCeEdwNkUzOU1XUGdqR05BRWxNMGpNSS9NYmEwcDRtQnZY?=
 =?utf-8?B?cnAzSmJ4Q3pTQmt3NVZ2NXF4ZmV3M3VFSFdKWS90WEdDSHIzNkZCeWFRbmdq?=
 =?utf-8?B?L0hUZ2gzRTBkODRpYS9TcnY5M21DSStabE9MUk14MFVGamVuTkNaODEzekQ0?=
 =?utf-8?B?YWdwRHpjMGNHcnBSMU80ckl3VXNBTnZOVXZ2dlJhUHE4bnU3a2EySHBaZUph?=
 =?utf-8?B?YlRDMEV6aVVlZ2lTVmY5ZGE0SzhCaHZvVVkvTUFISEVtOG0zQmcrQW9lWkQ4?=
 =?utf-8?B?blJDdlAvVDRidm9xR1p3U1V5c0tGUGVPaFQwc0FtbHhEOStPUlgybFhLYUdI?=
 =?utf-8?B?YVkrVG5taGFKK3NvQ3NVU2lvWWVxZUE4K2t3a2N4Y0VpMmNKWGdxQmpSMkNN?=
 =?utf-8?B?U0N6WFcxU3kzQ29JVGVmYUtMZU91eDdxVys0T1J0eGNjS0hGVmRxd1V0OVRD?=
 =?utf-8?B?WWY5NUVZQ3FCZkNQb2NhL1lPZkNGaThoazJXd3VPWkdJYm1TU1hJUmVUS0lj?=
 =?utf-8?B?Z3FGZHU5YUJrdXgyNWswNDNLRFljNzR1MmQ2bkZML0F2QzdEcGptQzNJVy9L?=
 =?utf-8?B?YWlSdStqWGQzc2pyMlFLeUJmM0diY21VSjR0Qi9YR0V3ZTdwV1BQbWFDRGhr?=
 =?utf-8?B?d3ZmZHFQMzV0N3hUbmJhM0dSTmRsUVI0cmFVeHdrbUJZVC9BT25ncUVXbDhS?=
 =?utf-8?B?VFhJaUg2N3JpVDYwR3JJdjY2dkNJZU9ML2pBMHU2VE9mclJsK05HOW5ubWR6?=
 =?utf-8?B?VktSd3lHV0xsT3RhMU53WURSeTVLSGpPYUplL1RmRGNha0Q3dFdxRGc5YXdK?=
 =?utf-8?B?bWcrc3hGdlF4Yk0wQ2E4Qjc0cWk4bHpOM0t1MkpHb1d6SklXckppbFBpQnhB?=
 =?utf-8?B?Uk5YdUlZY085VnRiTkd0WkJ5V3ZnY1F1Y0R5b2pFSHJHVUxBUjAzWjlYOG9a?=
 =?utf-8?B?RFlJc0pKV20xdFJwcmFsR2Rabm9hSW9BWWttd0ZsMUJWYnBBTVVadzRUQ0U2?=
 =?utf-8?B?bUxySnY3UWREUXdVNU5yS0Q4Z3JqNml6VkdpTENCdDdlM25nL094OFhsb3pn?=
 =?utf-8?B?V0FjYWhEZ2FnTkl4MDg1Q3VsVVFxUWlDVkYwSTF2aXYyVGpHUDdZaFRFU0JF?=
 =?utf-8?B?VTlzNHA0OHFFQkYxYWZXUmtNeTg3Y1pNVFBjQjc5RTExL2ZOYmFCeHNQSVBH?=
 =?utf-8?B?RkNnNzhoOTRURnBCRFFlV29ITHNubGxrampVWjAzU1Nad21seWpRT0RoWjgz?=
 =?utf-8?Q?m2B3XX8gINxVXKGMjzPJEc005zr/bqL3N3P2lgWQ9dYr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c313350f-3894-4aec-bbd4-08ddd9a03910
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 13:00:33.3937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15N8wl4m8DyRdHt8ZqaCeSsrFaJy3iZQ44Hh5DPn6LfIJTK1VFYX+vN/eI9FYWC5jxUoktFWA7oHFskHJXFxmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8563

On Wed Jul 23, 2025 at 12:00 AM JST, Danilo Krummrich wrote:
> The documentation for the generic Device type is outdated and deserves
> much more detail.
>
> Hence, expand the documentation and cover topics such as device types,
> device contexts, as well as information on how to use the generic device
> infrastructure to implement bus and class specific device types.
>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

<snip>
> +/// # Implementing Bus Devices
> +///
> +/// This section provides a guideline to implement bus specific devices,=
 such as [`pci::Device`] or
> +/// [`platform::Device`].
> +///
> +/// A bus specific device should be defined as follows.
> +///
> +/// ```ignore
> +/// #[repr(transparent)]
> +/// pub struct Device<Ctx: device::DeviceContext =3D device::Normal>(
> +///     Opaque<bindings::bus_device_type>,
> +///     PhantomData<Ctx>,
> +/// );
> +/// ```
> +///
> +/// Since devices are reference counted, [`AlwaysRefCounted`] should be =
implemented for `Device`
> +/// (i.e. `Device<Normal>`). Note that [`AlwaysRefCounted`] must not be =
implemented for any other
> +/// [`DeviceContext`], since all other device context types are only val=
id in a certain scope.

supernit: "valid within a certain scope"?

> +///
> +/// In order to be able to implement the [`DeviceContext`] dereference h=
ierarchy, bus device
> +/// implementations should call the [`impl_device_context_deref`] macro =
as shown below.
> +///
> +/// ```ignore
> +/// // SAFETY: `Device` is a transparent wrapper of a type that doesn't =
depend on `Device`'s
> +/// // generic argument.
> +/// kernel::impl_device_context_deref!(unsafe { Device });
> +/// ```
> +/// In order to convert from a any [`Device<Ctx>`] to [`ARef<Device>`], =
bus devices can implement

Missing empty line after the code block? I don't think this would break
rendering though.

> +/// the following macro call.
> +///
> +/// ```ignore
> +/// kernel::impl_device_context_into_aref!(Device);
> +/// ```
> +/// Bus devices should also implement the following [`AsRef`] implementa=
tion, such that users can

Here as well.


