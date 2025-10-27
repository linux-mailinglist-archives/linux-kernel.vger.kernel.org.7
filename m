Return-Path: <linux-kernel+bounces-872559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 035ACC11736
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A26A3348E20
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DCB31E0F2;
	Mon, 27 Oct 2025 20:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kMRm9vRQ"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013010.outbound.protection.outlook.com [40.107.159.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EF328313D
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 20:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761598684; cv=fail; b=u0jbeZQ15UmoMn89D4XvV03fpbinnRDNNYTD9Jyoq5QKFtuBy+UuR8KBgYcSCHFypyET98gz8JL34yW65gVvCGF+DEDyOvhI7GcTCPXlYgoTDVoZMg2LRaRgaKWHkJ9D9xHBuARpcgOOGcEr75m7EQPEhs+rjm9pvvsRHZM6nDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761598684; c=relaxed/simple;
	bh=PB4FZTrzGLubS42myhJ/f7pyiLt6OmsEMzPqlD2fNjI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=VdqHtV86/dwq6H/XY2QXMtAOjaJDDVPKJIs+fQv/E6kWa1kLtx7gUguCTSW7wbltqxA0xchXPvKKrWUHNJIdc3OdPQRlz/zMrw6ZSidUvrn2SwXSYVWq7HpNbrKv9nKw3XmdauzAWsqTbqd9/7Cc19OIdPNRxD4AZ1F+U1Mjw1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kMRm9vRQ; arc=fail smtp.client-ip=40.107.159.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHn1gFzEy0phlRDBDtmolLtT+/84inDhwehQRcom/UZggGPiUZ6xANnX46cw2lJtEXtuSUtmQoTP+rUgKGXHCuXOeRF5JuuWR/oFQEaw7Ry4SmCDwzba+N3Zvgg9SaZ0weiUnDeTM2dF0j7R82xb0PgP55gPkJIe/xemEuCuS5YevQCr5G8VB786m4A2hlhTtRHTnZN7e3u6qoaNoweZL59nuFsuvu5r1ChJgoovTe8reZ3fBKv2Xlw9Z7mZT9tu3wCwpxTKxfEyZE3vQcFJ4BCJCdyRNzbsR95VR+2TGnY9Jwx5ba0FGYd/1Cuo8Zw/ThHZdTbE+Egm6/ad4n7JdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jV4SXzCOeC8q/6Q9KuSfeiJaDDvphWBkKxT+EvYN1mk=;
 b=YkbI1bBBlRq47ZQnCilPorCPzzdP8zq8by0l4gkz0QkuTAtPcefz4EKFNcHteL4qkgwFqeVEeLVjdtkdB/MPPCdhoaueWt8VHAMktFug/sGhtkET2cBFRKMYa67paoyjbcBoLtotTbsnPvlrQONKblb58t2slTa2GhzHemaZDLtqaDiE7kOfVUyEXTdbpfn8k0p9JhmDXZby738POXiaYDZ5rATSlg7b1je5QV4+sfdEt99WLMITCyuBpHZljrQt24GnKuQLHJxNiQoQarnOAllUXTvjidIRInVDbzoi3Gkdj6J9txgmKNQPXULGFjkven/zFB0fS+da2I056l0lig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jV4SXzCOeC8q/6Q9KuSfeiJaDDvphWBkKxT+EvYN1mk=;
 b=kMRm9vRQz8cZYGMcDEmsDJnouISYG2v6tdIfrCTG7SSkelNH0SlMhOYo4UiZADhoGXpUzRclHuOhD0L9fUmdlIP5QBjlKuX5jPqrq02GJIqHou55jovjq8AMktqJIDfJCpz2sE+sERwT1/TbpQLv60QoM5fptJWHtdprMnwitmgsWjdc5k8Gph625J2dqsQUJigkajByw/+vS01o8EX4621NBxMB8ScTBokWaw74weSIasi+3fy9rAgeDpoMTDrFvXcg9BRgoIf6BpPS8wO5x6vA0r0zF7Jfe2GV8S4gtPEDCdiUYvVP45Vz6Hyde99hOupx75blkFk3e0dBN/lclw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by AS8PR04MB8577.eurprd04.prod.outlook.com (2603:10a6:20b:424::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 20:57:56 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 20:57:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/2] i3c: master: switch to use new callback .i3c_xfers()
 from .priv_xfers()
Date: Mon, 27 Oct 2025 16:57:38 -0400
Message-Id: <20251027-i3c_xfer_cleanup_master-v1-0-e9bfcb083a38@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMPc/2gC/x3MQQqAIBBA0avErBPSCKGrRIhMYw2UxVghRHdPW
 r7F/w8kEqYEffWA0M2J91ig6wpw8XEmxVMxmMZ0ujFWcYsuBxKHK/l4HW7z6SRRGGznrTYTWoR
 SH0KB838exvf9AHIsjSNpAAAA
X-Change-ID: 20251027-i3c_xfer_cleanup_master-cf75a712dc7c
To: Jorge Marques <jorge.marques@analog.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 =?utf-8?q?Przemys=C5=82aw_Gaj?= <pgaj@cadence.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761598674; l=1037;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=PB4FZTrzGLubS42myhJ/f7pyiLt6OmsEMzPqlD2fNjI=;
 b=MP3wLZFSsaI51AFpcXGntvl56kMXcKeAFarJIuiCALNREdKyzSyrwbU8BqCzWjn56QJ2tCroq
 fV/kD/d9D6gCv0SVi2VbW9U0OvkjVS2yayAiDtXbyaycD2qG/ydYlfc
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH0P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::6) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|AS8PR04MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: d68b8491-ba0e-4318-e6f3-08de159b810c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|19092799006|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlBDUCtPYUUzUEtpU1FrRW9VeGsvY0s3eGxoU3diWEdHekFCYU0zMnBsUkYv?=
 =?utf-8?B?ZnBuT3RTNmRyc25SbjRyaEpDZjBlWE1ZTnE0aEg1MTRZQTA1L3JKd2MwaHNI?=
 =?utf-8?B?UEdBOGpxOVNFZHFyQ1NvQmFLcEFmZ2xMbzY1YXVmMVRMS2N5S0JjTjVLNU9P?=
 =?utf-8?B?L1gzRDdQdjlxRXVpYmpuOFUwc0N3T2pZQ0VBYlhiMzNIb1pqanhHQk5uYzNm?=
 =?utf-8?B?RnBYR3QrTmRpYXRxRWdiZmZEZWM5NkpxMnduUEtzZ09zTzFhclBTUEhtNVhP?=
 =?utf-8?B?RG5HaXZrQm1XRnpWajE0N0JmK2d2dUNDZlJGYm1INDY1QzV2b1NKcmhZSzlR?=
 =?utf-8?B?am83MHJhdFBza1pKTFpRZSswMjhBQXo1WGJuREY5TkVWbTZrZUduVkpRcFdq?=
 =?utf-8?B?emlvWTc3NEQ4Q2orZm95Y1pRQmV3WjcyVmJiZ05UZkw2QTQydFZPa3NrYjhN?=
 =?utf-8?B?OFloSzZvRytJTHU4MkkyNWt0QS95aUVmNG03bWtMRnlVcXprb2dDdFdyaG16?=
 =?utf-8?B?SzFuK2ZRTmZROVk2R1NqR0k0YVpNQUlxM29ERnZDN1NWM0FKbytxWmFVWjBD?=
 =?utf-8?B?QTM0V0xHS3RRQUxtWm10Q1plSWkvVFpCQ081dk9iNG9LWGNLekZrQ3d5cUJX?=
 =?utf-8?B?a2RHWXVuZmdvdmw0aDZoNHprYS84aWEwK0VjaTQ4ZWRTaGhDMHppeHZUd1VD?=
 =?utf-8?B?QXFBdHg1UTFVWE1iRXZvd3lnclVuS1lKYXY3dTBueS85TWJvU1ovVFNsdjl1?=
 =?utf-8?B?NThSQmNCSTRZenl2TTA4OGx4QWtsMCtwOG83U1k4NWh3MG04VnRVcVVRcDBs?=
 =?utf-8?B?WkxXQ3ZUN1pGbVdVM3Q4V3FWc0VuVG5tMitwVTM1ZHlOTzk4Y0I3WGN3NlFl?=
 =?utf-8?B?WkdVRHg0Q1VBVnZSZFVhekpPUmxKRGZLWHBDVDU0R2RCOEc0QmllelRzMDNy?=
 =?utf-8?B?UXNUcGF1SXhaWlFScDBxdmNMb3dWV2M4QjQ0OEdTemZjcTQ1dEVkNDhjTFY1?=
 =?utf-8?B?L1p4Uk4rUlhhbk9VYUFRRDFlRHNmQzlJaGdVVEJiRkFKZDlkS1VXN0xvVWo3?=
 =?utf-8?B?M0J4VmJZQzk4SE1vS1NkeGdwbFp5YW1TSWdmRS9UWVJnZkxpR3dweDk1cndH?=
 =?utf-8?B?WGdMcm1HM1piREs3Y0F0UkRyTnBRWGw3V203MnVIS0x3bVNNV29hcGxTclZ0?=
 =?utf-8?B?dnlXWTBTUDZiaVRPdlFBVHMvbXdqalZxRVM0ZjJpWFV5WVRtWWVqd2lVMHFy?=
 =?utf-8?B?M3hyWlp3VW5uaDE2WVVydGNVaUFheUtuWTRzbEsxWnFJU01HY1cyalVmVllh?=
 =?utf-8?B?d08wZ3NuR2greGdvQkRndGFBNDR2NUQ1RW1RMGNzSCtmM2dMTzd2OFowcGdU?=
 =?utf-8?B?MVM3S3FwUkhuQy9wTHB2VTAzUm1MVFc1UEx2Qy94Nm1nSitpMkNhS0doNWp2?=
 =?utf-8?B?QTRuM2RMUnJ6cHNSYytkMU1NN3gwZnREelVwRit2TEFXdktuNGZ0elk5YU96?=
 =?utf-8?B?M3ZJY2VJcTZwbWZadm1kQUIxcThDSDJ0b3NnZUk5d01va2Z5VnhMVnRST052?=
 =?utf-8?B?aFo1TFRJT2h5M1dzQkZZam11Z0xER2dSMEpFV0FtM2JQZjNlQU56YmJzS0tN?=
 =?utf-8?B?NGtTZDlvSExNMHBmZHFnd1p6VGlIQ0FxWHM3NHdkdU5rRXUxbFVhZitmM0Ni?=
 =?utf-8?B?THZXaEZST0R6N3dKbGJIQnI1Rnd1QkN3NzhZRDNMRU0vNzRZS0o4TG5RaUxV?=
 =?utf-8?B?b3FrN1Bpbm5HZ2ovdEZtWmxJY2JxNVlaYjZzVXJ5NnpRYjl2b0R2Y2EzNTRY?=
 =?utf-8?B?OURrRUpZK2N1RGFjZkRYMFh6V0lOajFwM1NrR1pOTzlDS0NGWVgyOExDYTMw?=
 =?utf-8?B?SEFtZ2s2TmFSTXVJTHlrZTN5cHBXSWw5OU53UTNjazV4NXBpTStQZi9wKzdw?=
 =?utf-8?B?N2RRR040Vk9BUHhuMEQ4QmdpYVlscmM5b0EvQ1N4S2RjQytCbHA1RmdMYkNs?=
 =?utf-8?B?dGZPY1hQQXNkZjdLOTR4dWNidVhTMkRXdEc4c2ZRSnc1ZERHWlMwc3VOOTJI?=
 =?utf-8?Q?Xm2Q2F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(19092799006)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjQrUVZ1dVFzN0RWc3FabkJjeGN0bHptUG95emRrSlZqUmdxNjk2RmVBVHhZ?=
 =?utf-8?B?RWhXZ0hPckowdUxQOU5BVFdFS00zTmNGL1ZMOXIrdzVHMytpamM0R0NqNTlU?=
 =?utf-8?B?Rm1aTVppSnZoUDlJL3pSbGY4T0pHUTljVlFoRmI0WnNKc1FNY21tZnVNUzlp?=
 =?utf-8?B?QzFNeGxQQi9Md1pqblRvaWgwYS92QWQrNnRON1krc2ltQjJ5U3dQM3dWcmhx?=
 =?utf-8?B?VXMyWkVLSGZqSWpGeEhrclZJQ1Y0aTBRYXJiYTZPZWpKd29MUjlsZlJyakpJ?=
 =?utf-8?B?N1RhWTVLSFBwY05DM1Y1UElIZnJIWkFmNjd1MjNlY3pZcDFxUDlsRldTT2Nw?=
 =?utf-8?B?cndrNTR0RUdFb0pMUVN6azRSZm1GaFRHRnZkdzJnMCtTL3Z1S0w1dlQ1Q1Ev?=
 =?utf-8?B?YXcxajJFSnNNVVExNHpHR2RNS0tic2l1S1lrdWFMb3ladW5jZ1BOLzhaeVZ2?=
 =?utf-8?B?VFZvMG9qeEZMNVpZTWF3QS95T0E1MWVINGRPdm5qSy9oNTRnOXBad29BeURy?=
 =?utf-8?B?QWdsdTdUK1NJRjY1UWNXT3JsVW1vQmkzY1BhMDZzR3VxYkdPR1FScnE1Z1B0?=
 =?utf-8?B?QmMrcDBKWnd0MHJzU0FXRElFTnpsU3dIMEdyQUJsZHNhN2dqTDZiWWtrdUlz?=
 =?utf-8?B?ZHJEYVNiYVJUSVFydWRlUnBxbGdiSWtDcmlqb0pEOGJHUzUremNGOGQzSnkw?=
 =?utf-8?B?eWQrc0xKTnR2VGZFekszRldIK1doUnZ4K0lKcnJ0cllDc3U1NDA0Skhzd0dZ?=
 =?utf-8?B?b0x6cjNMQWVUTEg0d3hTUFVjVXBlNjFiditUZHNrelhxKzl1cnVWczRDbTdB?=
 =?utf-8?B?a3czMEh3QngyUW45OXQ5NTdZRzlOMmxCQmRFNy9maEFXSWVTSUNLdHA2OHI3?=
 =?utf-8?B?aTdVbC9KTW9tSCtDcE9EUDJjeFRJQ3QvQnlObWtEbEdnY0xZYXdZdnozQlNz?=
 =?utf-8?B?bGpzckc3N0pLWkp5bE9uK0JLZUN1NEpNK1IxVi96VGZkZmluY2VtM3R0KzF6?=
 =?utf-8?B?dFQ4cVYxRzlTdkV6V1NmMXgySEE1Q0NOTUpBUFI3ZjVETStmRzlCUDUyWDE4?=
 =?utf-8?B?cjhhZSt6R3FsYUtvZ0tYV3lxaUFhZTByZDFMQ3pzUXd5aDVZRURDVFhjYzBn?=
 =?utf-8?B?MjRpSlN0WU1zREk3MnNHVzZOV1pEdDQ2RW5UQ0N0cVQwcUR5eXNHbkcrOTV3?=
 =?utf-8?B?Z0d4TUhkWENaL0k5b3FCNGxiTS92TXl4MUU3TUNIZmh4cmZacUpTMkVtNU1O?=
 =?utf-8?B?ajMyUGs1Y3JHZE9FT3F1MWxsUk9oY1lMcE9RM3lYak1HMVVBUng4WXVDWkZ3?=
 =?utf-8?B?bmdKUCtlM2tNd1ZzeFA3RFlEcWRtU3V1Z0l1VkpnbElqMnljeUpJZUlCRGhq?=
 =?utf-8?B?VGxLWVd0V2lxdCtaRldqQTBoNGladVNDZFNZRTdlMXVrSzAzRGhYVnFidkdy?=
 =?utf-8?B?eHRxSzFPV0tBbGRNOFp2Ky9PLzBDUEdjbDJsVnRUUzUrdkEzYjR3VkxRV3d5?=
 =?utf-8?B?REVHVkJXOGRBUVRQS0VtL0VRUlF4OWxROVF4SjhGS1c1dmdXSlF0VmlDT2kz?=
 =?utf-8?B?Q3BvMXdZM3F5U0cydld3ak1LdzR0RExTZ1ZlcXNxVUM5M0N5Y2ZwQkNqSmdL?=
 =?utf-8?B?TEJUVmQ0SGtONHN6RXlNZHhLVUkvQ1p1ZXJ3TVF2cDlsSGlSOTJVM2hrUDl3?=
 =?utf-8?B?TmRYc2ZSK0EzRU5jcDc4R3lBNnBPbm9oWEZXdzFKOHNQdmxJbFc1RDBwdmxZ?=
 =?utf-8?B?bU85eHc3d0FXUy9kS1lzSmhkUHlBNW5EbmJaY09lS2p3ZTBoZHBiNnovT1JD?=
 =?utf-8?B?dm11S1BuQTNnczhRdEFaVTdaZkpzWk1XVjNrU0RhTzBtVmNhWGdDdGgwb3JN?=
 =?utf-8?B?WEJ5d3N6RjZEK2xKQmRnc1g4eS9ibHErTHMwYktVQmJ4TWpVYWoyc3ZTRm5x?=
 =?utf-8?B?RS9mWW9jcWtFWFNGMkZ4VUE2djBiZncvZzh0cm5Ub1ZRc2JjQkJNU1ZFYWZx?=
 =?utf-8?B?c3dHcUJpeTQyTXNrd2x4MTlmSlA2S0RzNXZOdWFqTm5pU25uaDh1Vm5KaGxq?=
 =?utf-8?B?dS9YUldJTHZHZGM1Z0dLOTlkRWg4elFmbmE3dXRibTB3V3NFUnBtUXZaaFpP?=
 =?utf-8?Q?xA7bW60LjHY7sZY29u422vTtB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d68b8491-ba0e-4318-e6f3-08de159b810c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 20:57:56.4475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EzrMlOpz4S/E7xb9Gix7ebbZwhwddirGCqITgYx7CkMxv7zY7VygQAfPcnAL80tCXmWmYaq81R21CD6zIgBg0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8577

switch all controller driver use new callback .i3c_xfers() from
.priv_xfers() and remove .priv_xfers() in framework.

This serise is base on
https://lore.kernel.org/linux-i3c/20251027-i3c_ddr-v7-0-866a0ff7fc46@nxp.com/T/#t

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (2):
      i3c: master: switch to use new callback .i3c_xfers() from .priv_xfers()
      i3c: master: cleanup callback .priv_xfers()

 drivers/i3c/master.c                   | 17 ++---------------
 drivers/i3c/master/adi-i3c-master.c    |  8 ++++----
 drivers/i3c/master/dw-i3c-master.c     |  8 ++++----
 drivers/i3c/master/i3c-master-cdns.c   |  8 ++++----
 drivers/i3c/master/mipi-i3c-hci/core.c |  8 ++++----
 drivers/i3c/master/renesas-i3c.c       |  6 +++---
 include/linux/i3c/master.h             |  6 ------
 7 files changed, 21 insertions(+), 40 deletions(-)
---
base-commit: f22e2617a331cf4800d6468cf0455db05a74c9a4
change-id: 20251027-i3c_xfer_cleanup_master-cf75a712dc7c

Best regards,
--
Frank Li <Frank.Li@nxp.com>


