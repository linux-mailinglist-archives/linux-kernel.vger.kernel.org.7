Return-Path: <linux-kernel+bounces-877054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B7DC1D135
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A75423024
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039BE363379;
	Wed, 29 Oct 2025 19:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IlAFG1y/"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011031.outbound.protection.outlook.com [40.107.130.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF11136335C;
	Wed, 29 Oct 2025 19:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761767715; cv=fail; b=FHpKlaLORRU2sQjmp6ii91UOJgOjnnCvxAWL5D/6AzwaMpjwVOm7v1bMZJlcDIWrnusYTwwTb/dlVN/yUefQiJuxETQLLQS7G2OcaJEw/mdoF+9/g5JXeGSQqhLuSeYvH3kDFzqfSD0xP1fZepZ768Ki/hHUZjqN7gkgC386s8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761767715; c=relaxed/simple;
	bh=GnfnfVbr02v27i1Dw2M5RsxP2n/4rtFa3PyCDjrJa9c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fhthtckUanwomMRSx/M7gF4CHWgpiiS7ahgwEZd/0e4aMoAHAv0Eiliwnj6v/fbh7q5shuLcAhqmuaD5Yw69vx9KdKaHu9qCb6IpcMlnUDqefmINSBhmg/tAIoq6g4+dhgwDC6SBzgIhmKfJSk41Aa2YkYFRCHCywO4dr9DcstA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IlAFG1y/; arc=fail smtp.client-ip=40.107.130.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jr7cMvy3StB3sGg3tXcDUoSBrj1icaRKUYY5Ji4SDzXfIOPcl4daOdj8nWYW4qvCtg1lMlNTNKgcqiB/K7sJHtqS7N1F8u3Y2koL7bmPMHEVvc3eZXRMc+cpmdQjp2onQUqdXgDJOSVPC4dfB4fO8KxDCnlFf1dvNdX6dn49HCC+YyF/krGDaIg7YjoPJJDTKj1EYfjUi6F8MuLW92ZX0N7jOa9P1GDTrVLo4p+93+jLuGu4iZyGwNUIweg6L61nHUWx2gPtryCuopu1YTCkGPUDIOTLHrMYtMhSBpdVpaqONk6w+YRGWJ8mL07OyF+r2DCiVScEpBKlTo80949VWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9EIjrVWOcIXQzDzCokfx0EH8g7NWth7pbgtV0OX1sY=;
 b=g023lJuPXUthBplmYAUvtvMskfODDq8dT0m4Dpp2ls+49BqyLcoeQ3IXQ/3yzh4OQs+Pewlp0fUMV/xvGs/+/GlLO4i3Bt5FBmN2JkbpikXuP9if24VHwyYOPzxFScGATQyJVDROktDFtkrGMjtKSzHt1be7toRMP+1lcG42pDuugQLF91MvU+b0pYiCMzb1TtKoN+JESwd4S+5Sm/BDh+jKuLG9ML8Nxt6zwz/85l6h53+jsbXkQVe7pibjMIAwF9F33n+exCobYOk6EnyF0JvfnCfjwLFJ5UAE+1dYW6rCQLztH1yKfrtDYIMcxb4j1i46OERsx0FcJus7eZz26Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9EIjrVWOcIXQzDzCokfx0EH8g7NWth7pbgtV0OX1sY=;
 b=IlAFG1y/FnxrttYxx/QCq9HyfsRz3241eNkZP2udsokyp8iUiphT5T79PoLVZYKKYFOdrgYbFKtBp/evVCF4C927i0nFdAvmUD9Zw8/opHeXeF9EY/2CQfu4ogvVqnla6G+6GfLxKlR3qrHZwGHxJnYYKeeUP/q+WwzbzD8j+jQs5/UlahLv5nTNyBkpBSQtQq6+swBOtoPiU2haEoTB0Uisb7ZqTuxpaaAeNZPvEVBF7wNyUsfwCwsdEJQVB1SKD6e7V49gdrKZ+IcSRgAqMh0h7jUxT1j9VPC70kIaRlC+4D8yYKbq16rTDvGeAoqhf2mEmZdrIoATMICZjMbUXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV4PR04MB11377.eurprd04.prod.outlook.com (2603:10a6:150:29c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 19:55:11 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 19:55:11 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 29 Oct 2025 15:54:42 -0400
Subject: [PATCH 06/12] arm64: dts: imx8qxp-mek: add flexspi and flash
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-8qxp_dts-v1-6-cf61b7e5fc78@nxp.com>
References: <20251029-8qxp_dts-v1-0-cf61b7e5fc78@nxp.com>
In-Reply-To: <20251029-8qxp_dts-v1-0-cf61b7e5fc78@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761767689; l=2072;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=GnfnfVbr02v27i1Dw2M5RsxP2n/4rtFa3PyCDjrJa9c=;
 b=TD4/rLNQcLp1iL8XZgbdRpJzl8DF1ZORoXshTYjlauXIedoDSUVusOJnn8KcFGEwrrZdT2Euw
 hbqO+YK4uoKAt9awspp+hzYwrvfXlUzYTCs03jkWHpX/HV14BqickS2
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::24) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV4PR04MB11377:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d0570e2-8745-45b5-df86-08de172511a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0xTRGxIK091dTB0N3hJVnlSeGlUNTNwcnJUY0J0UmJ6NXMxMTNvWjBiUjRC?=
 =?utf-8?B?MEd3WElLaTFRd3ZrakJtQ0pmWWw5bm9kTisvZVQrbm5zZzEzWXoyOFZmdXV6?=
 =?utf-8?B?L0ZwcjZVZDNWMUxEU3dkdnZLTnZqSDE3Q1ZmbXBGU0tKVDk4bjRXTEYvQkU3?=
 =?utf-8?B?R3BrUnVXeUtseE5FNmd5bEJ2UG5YU0xNOFF5NERsQUtRMEU5bDJpWHBESzVP?=
 =?utf-8?B?Vlh5L2pHUEtrVFlYVmxZa3NsanNDR2tWM0pubm03S01rQTdGWTN0WExjT3FS?=
 =?utf-8?B?dE4xYytoWXBRNHE0ZnpZejBzS293aFRac21oZU1mSGh0ZlBYVkJNczdBeEM1?=
 =?utf-8?B?cjQ2dVBZU2xVS3ZzOUF4T1FwOUJ3K3ZZQWdDdHQxaUJoV2wzc1pzNW1ubzhF?=
 =?utf-8?B?a085QUVmVHdqRndlUmE5Q201b09Pbm5vUlU0NEVEL2UwbmtTUlgwcHF5L1E0?=
 =?utf-8?B?czRRcXhqalhRcXhqMzVxRVNCZVlhYzhKVzNpNmg2Skh4akhTZU5aQ2lxQkFG?=
 =?utf-8?B?eVBSV0pDRjVzQno1U3VtNnNJMGp1NWF2dDRIYlEvN1NiR0loWFRpNXlzQTNx?=
 =?utf-8?B?Z0RoWDgwQVMvREpLMlNNUHdzNVI0Wk9UdHIwYVRoTWlOZWx2dnVmcDJKRjVn?=
 =?utf-8?B?eUN6eVFuWTgrenE2ZjlNK0R1dURNK2NrYWJUaWJKeFFFbnVCVHlWQ25HTFJK?=
 =?utf-8?B?Y2MwN3FsZGFWbDk5Y3NsQStCVi84L1JqOXA4MHZBNWF2Y09tK0VGY2dscy9u?=
 =?utf-8?B?V1dJZ1FSMlFsMzVwSldNMHRRYnhCV01tK2dRSzFTNzN3eklQbU1ZRmxFbE9M?=
 =?utf-8?B?M1JUcUxKZDh5eDMwQU5mZ0wrYk45ZFJ1cUhuNVdUTXFrV3BsY3RYdUs5U0dO?=
 =?utf-8?B?MVNTSFhESXdoNzVzYVlrU2VHNHJ5a2lWRFV4bzAydE1SbUp6QTE3ODlKZ3lr?=
 =?utf-8?B?Wlo4aTZ0eUxEYURnT0s1L3I1aGFnellrUjd3MTFNT1VDUXVDblpxUHR1MkZS?=
 =?utf-8?B?WnVzSXdMb2pkWmxZSm9LUVV0ZHQvaUg1b2Q3ZVkyaDhUL2hteU9SM3ZBa2l3?=
 =?utf-8?B?djRpOTJOdkJLa2c2cnFzcW0zTkRiR2lwczdacFBEdTZXdll6Ty8yMldmenRV?=
 =?utf-8?B?cE1PSktFcjg5N0sxdE8ycFlJN2RXazhic2Q1OHYydVpuSTVwenNVQ1h2ZlNk?=
 =?utf-8?B?bWl2QzF1Yno5Ky9uU0krdmYxZ3ZvWU0xVUtoY0YyTmk3RUNEVXM4NlNQNXRQ?=
 =?utf-8?B?NXNhMWNRV0o5U2FzSTRDMFdCNEM4L3FQcGU3UEVpa0p6VVlWektteHJvNnFz?=
 =?utf-8?B?bC9iQ1pSNlZBTm44S3daRCtOY3cwWmNtWmhuN09mc1BDajdSMmIwUnFXUTgy?=
 =?utf-8?B?ZmZUbGZ4Q2EvbXRGVUx1Rk5NaWtFWHdCeTdpWGJvOHVNVGRQMW4zT3NJY0pL?=
 =?utf-8?B?K25KRnBpMGZ1SEhsMEkrbFN6NEZRdFU3NVJNQVo2UXA1RFI5bXNsaHQveVFz?=
 =?utf-8?B?K2NOWDF4VHNVVExzdytFYVVraEFVRGdYQloyOVdjZE5iaGN0TERwQVVlalNP?=
 =?utf-8?B?U0ptMEE1U2pSRUFoV1pCK0JqM0s4ekxtMXNpbHhoUkFJSE9YblBEV09KWnBC?=
 =?utf-8?B?WUl0QVBtNmRNQnR1MUJCcjNsZzBKZnBZUkhWZUcvbCsvVzBTUlZkSi9LYk5Q?=
 =?utf-8?B?WUdtU0pXdVpFbmRrRlBHa1JscnhMTWRFakpSazlUOFlxWjVQRzBsdjVQeGJ6?=
 =?utf-8?B?WWFISHk2bEtYNm5ZWlNsanArRHgrNGxWTENnUUU0M21BdERoSTF5bjVrYTM3?=
 =?utf-8?B?WmZrQ0loMVYvOXRYczQ0bXpOZng1SDdXRExBUkJMU09hNit4emowQkpDRm85?=
 =?utf-8?B?SmpxaFoyR3k3Wm5Nc3F1ZW5UTzc0VG9vWHRTUFpnbnl6WnFCNXp6Y2FmVlNj?=
 =?utf-8?B?OEN3SS81dGdoYXdmakJkOGhOT1NpaktHVVdoT2lvODRYWHVRN3p0OHlqOU05?=
 =?utf-8?B?N2FiTlh3K0xyVnl5VlZpY0ZqYlpuWC94M1RvQ1d5SG45SERGenNLeCsvRUZu?=
 =?utf-8?Q?WCkfmg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clFURW81UWZmU2FMSjBYY1FtU1ZLYmh6SER3NG9qYXRJdyt4NE1vS241Z0lx?=
 =?utf-8?B?ekVFNGIzWVQ0MVozTkNOSDJ0RFJKMTZFMk9lYmx3ZXZuR3ppZlVtZy9mQmQr?=
 =?utf-8?B?M2trZS9KNTQ2Uk5HRlVCYVpuUnhXTUU0M1JoWjBaaVZoRWpucGQrY0k5Z2Z5?=
 =?utf-8?B?NldrVmVIQ2Z6TnBFd1NuaGxZOHNlRHA4enFBWC9FQUNjSmIzNDNlNnJIeVps?=
 =?utf-8?B?bUZNWlV1WDREekIyemtOaThueWV2aGxmKzdMNWlJOU5zeDB5Y0FLa1hDTFFW?=
 =?utf-8?B?dDl1eWxNam0zRGdUamRLZWxteE05UzJxdGsxRi94UC9UTC91K21OVXdkU1Vj?=
 =?utf-8?B?NFhYbi9tcnhIS3dKOHlHYVR6VnFEYU1XR0tWM2d5RVdVeWNJd0ZXRXZGdVgw?=
 =?utf-8?B?bWQzQVVSM2ZPUk1CREhXbTlET1dCZElaQXE4TmUrKzRlZ0N4ajdMZmFnbmxT?=
 =?utf-8?B?ZUoxYTRNYVhzWU0zbkFGVkY4NlhhT29iY3FidUlKSFVZbGZsVkJKZnZ3U21M?=
 =?utf-8?B?ZFpzTHdKTjgxbnV0d21UT0dXa29Na3dwajdLdkxLRFEwQ1hJK01UZzdZZDlZ?=
 =?utf-8?B?bmpWU2JmL2NlWmI0ZXNDUE0ra2x1dEZGeVRPTmxFS2l4Nis1NGZaUEU0UkxY?=
 =?utf-8?B?MHpqM0ttaEtoQXhmYWprZ1QvNVQ3cXVMQ3hzREFRQjljUTN5YlFnL21UbmVh?=
 =?utf-8?B?R0JyZHFMVm5vTDVDbmxFTlF5RklMdkZZUlVSalVNdWdNOTAxZ216SG9yTG1W?=
 =?utf-8?B?UlQ5b1hHMzgvN0dQVlFMRXVDcmg3aWQvSElYaUpSczk0TEgwWG5TVyt4bWRY?=
 =?utf-8?B?NUZnZm14RFVQdXNCV09IbWRGdVNYa1pPVEFQcUFjRzVmSG02VDdnQmJMTVBD?=
 =?utf-8?B?Smg0bmdFeVQ2MG43VVNpa0RaZm1xc01aeGhUMFd1Y2ZaNUJocVpadW1EZjJl?=
 =?utf-8?B?MG05bTVTOWlxVkZDdzdJVnZpV3hUcEFiTGFwdmtTTnZubDFjRDN6d2RhR294?=
 =?utf-8?B?U3RpejkxVy9mNjIrMFo5eGdISU94MGovVkFqSC9Sa1Y3ZjllWnNVc3lMbDdt?=
 =?utf-8?B?c0FhK1BuVkVJSjVEZm5DMG5FZWdGZ3Bid2tqL2pSMVBsbytpWUg3cmdPdzRv?=
 =?utf-8?B?aGkrV1hidGNEbGt0TlU4aXc0TmhXbUVibFlja2lvTlpaeUxCL3JFM3pRaWk0?=
 =?utf-8?B?R1ZLZS9pRkhFejgrcDkzNDU5ZG5BOERlWHM4d2R4N3pSWG5kaUg4akpPNmhV?=
 =?utf-8?B?Yks1djJXN3pCVFBJdlJJcHd1anEzQ1lkU3BOK2x1VU9wbVdqQTUrL3NZRFBo?=
 =?utf-8?B?ODB3NkRJQUsrRy84bTc4emFUenp1Z2h6Q2JTNlMxaVpIcThTQzdxM3JoZlow?=
 =?utf-8?B?elNyYnlJZkdUNDBlbU1EeVJ2MzM0V25mcVlyRUVuajFBT1JhL09MR05HMHJU?=
 =?utf-8?B?dzJmNWxva1RxRjhqd0x6TWRTcHoxWlh0Nk9HK0RPNTNJblpRdTJoOFBhKzhH?=
 =?utf-8?B?NE9pK2gwUzhHbk5Sbys4b0k5bDQ4bTl3VkhjeEd6RXhkdGJvSGdjbk0zTlJs?=
 =?utf-8?B?VG5DV2RPako5THpKY2dmbDJlSXI3cWpJbnJUV0w2RVlOeU1GeW9SWU4wQU5k?=
 =?utf-8?B?bk9jTFVRVzYxMDF6aEQxRE5JancrRlNhNHdleEYxMEdFaWhiK1luc0txaUhS?=
 =?utf-8?B?dDZSM09ja28vS09uNVljT0ZKaGxoN2g0UjlqZDJZY1R4RkpQbGo3V2wrWjB2?=
 =?utf-8?B?QVhlcnEwNGRZQkorSTkwTVIxM3Jpb3NaV1A1MDZ1Q0dXVVFxeVU4WUdPY0x3?=
 =?utf-8?B?RWxkbGx6VWtQOVI4bkRVUlVvcnRsVytscENnTGFzNnhaNUxvRE5SK0VTZitm?=
 =?utf-8?B?UWNwRTNCR0ZxZEl5WkUyU0ZjaHY2SzdsUkliUG02VlFnc2Jwcnl6WnFtVmpx?=
 =?utf-8?B?NHBaRWZTb0dmdzZLWG1ndlo1Ty9BSmZTa3l6UVQ1ejNrVytOSEV0VFRPUmNj?=
 =?utf-8?B?Vi9HMzZiSllCTnE0OFIvWkRGZC9tckl4clJQTURybWdTTEptTEp2RW91Qmtw?=
 =?utf-8?B?dHdXM24wNnc2aWpNd1laZzA4bElHbzdHNnFUSTg4dUZDdkxzSXBsdXBwTGxU?=
 =?utf-8?Q?37TZm30Ecd1ki5eIA3fCVRARR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0570e2-8745-45b5-df86-08de172511a2
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:55:11.1808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezgzbMS07zKDMTwXD0PqQLfMmtWdAnXM7Lu9am7RV/gWJVfCmLP33bcHggc2WdHAyGwkcXok1lAZ71Iuv0nvrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11377

Add flexspi and flash node.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 35 +++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 80f4ab5339578b16aed3e3f2db6000f668de815a..25a73d376eed85049e78e4c8b209ec23638ffcce 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -586,6 +586,20 @@ &flexcan2 {
 	status = "okay";
 };
 
+&flexspi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi0>;
+	status = "okay";
+
+	flash0: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <133000000>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+	};
+};
+
 &jpegdec {
 	status = "okay";
 };
@@ -878,6 +892,27 @@ IMX8QXP_MIPI_CSI0_I2C0_SDA_MIPI_CSI0_I2C0_SDA		0xc2000020
 		>;
 	};
 
+	pinctrl_flexspi0: flexspi0grp {
+		fsl,pins = <
+			IMX8QXP_QSPI0A_DATA0_LSIO_QSPI0A_DATA0			0x06000021
+			IMX8QXP_QSPI0A_DATA1_LSIO_QSPI0A_DATA1			0x06000021
+			IMX8QXP_QSPI0A_DATA2_LSIO_QSPI0A_DATA2			0x06000021
+			IMX8QXP_QSPI0A_DATA3_LSIO_QSPI0A_DATA3			0x06000021
+			IMX8QXP_QSPI0A_DQS_LSIO_QSPI0A_DQS			0x06000021
+			IMX8QXP_QSPI0A_SS0_B_LSIO_QSPI0A_SS0_B			0x06000021
+			IMX8QXP_QSPI0A_SS1_B_LSIO_QSPI0A_SS1_B			0x06000021
+			IMX8QXP_QSPI0A_SCLK_LSIO_QSPI0A_SCLK			0x06000021
+			IMX8QXP_QSPI0B_SCLK_LSIO_QSPI0B_SCLK			0x06000021
+			IMX8QXP_QSPI0B_DATA0_LSIO_QSPI0B_DATA0			0x06000021
+			IMX8QXP_QSPI0B_DATA1_LSIO_QSPI0B_DATA1			0x06000021
+			IMX8QXP_QSPI0B_DATA2_LSIO_QSPI0B_DATA2			0x06000021
+			IMX8QXP_QSPI0B_DATA3_LSIO_QSPI0B_DATA3			0x06000021
+			IMX8QXP_QSPI0B_DQS_LSIO_QSPI0B_DQS			0x06000021
+			IMX8QXP_QSPI0B_SS0_B_LSIO_QSPI0B_SS0_B			0x06000021
+			IMX8QXP_QSPI0B_SS1_B_LSIO_QSPI0B_SS1_B			0x06000021
+		>;
+	};
+
 	pinctrl_ioexp_rst: ioexprstgrp {
 		fsl,pins = <
 			IMX8QXP_SPI2_SDO_LSIO_GPIO1_IO01			0x06000021

-- 
2.34.1


