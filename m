Return-Path: <linux-kernel+bounces-877050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B589C1D114
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F28AB4E19A4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B4D35A95D;
	Wed, 29 Oct 2025 19:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bMDikVgP"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011057.outbound.protection.outlook.com [40.107.130.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDED35A92D;
	Wed, 29 Oct 2025 19:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761767705; cv=fail; b=UOct0wD3cC8P64HtLROqVQciUVY4QftF32yDWEnKm5c96G1qb8jYrFZdI/yRbRjRzh3MG3S2oHnIoIOhK0nI4dGzbjPZZsDPFXgO/w8HpfF7l5Lwp8JRd25gnM6h60qvPwziT0hfxYJlYVq+wW14l3+jMRtKcoAMSOxCDoJY8tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761767705; c=relaxed/simple;
	bh=OJ5jYSKcHHZ/zbf3wYncmnI/AAG3OS9hMsjt48MLayU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kAzrZjZpV+ANCAGp4K0Ymswt7ZrQqBLrsgKjDbFjoZJYLeDRMyHnAq35O8sOVjNs5iK+aSF/5KXUaLufWPl/ZvVC0kzL1Cpff3NLSWyaoVWMFy2AVr35SwzkVl1vzPlJta++SeonAMLJFYIrDue5Q9UeutvdBWEBUusTL9sPJis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bMDikVgP; arc=fail smtp.client-ip=40.107.130.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+Dgx6A3/tLSOJzZRSlsvOiT0F+12+H0KHatWADfXJzY8q5LvOMknJkzHAhApisNcbIo9O86QoxAZcJPNXb9rMoOuFpogyeIEIVG5EKr8M0iBirul4Gyr5LTpCWP0p+qgixPQPMBNR/tn3kr7Ai0EadpjlupHILj7mLFFBxdNDgTVW/jsShVm+EyrXvrAKX8yt3jfziuzRInrbSugXj8fZlWpTTjM3azPSHwkR9ENu1wrhoI6W0tTQgYB5ouyqc7EEPkuSS48luTmafa7NPphsIBzC247JLf2xLXpP/t4GrO9/iIWyL/0+KTp8saBVwQOF+sRkt/aerjelUbC+ZiIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvRWH73PLYKIy7/aYnfECypnD7Ych9e7dobBQNCUrhE=;
 b=dolCNXXGWtdvsJZW/M6AUeZ6a49lYUvXKkiLUzuhg7Sko0mQk0STYh6xg1Xr8DI6AFMagIlW44QjeJbIbF6BAYzMsyhBnr5WIGv0CPIPUYMufZVRF35Q/q+jMou8f2vIgjZN7ychFSsevU8QcBuWEuXduNch+P0EYe+9nikkbrYNi3f78VtE5GSWJgRPpyD+Sq7BaOyvzt45LtyDGI52zkDpVe9FqvIOZrQuBxA0oBJe+S5ZdQ3IjVcY/CPI+BwnvILZNERqAx4RdJiao5GustvpZofEh9Kb1zRmOllN50abPFXdp6yp4BEbOr9qQh/DH1evxa1DTHsnOxi5JdbVmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvRWH73PLYKIy7/aYnfECypnD7Ych9e7dobBQNCUrhE=;
 b=bMDikVgP2nbRSrDNPN2U6WO+18h5J12vuHC9n72B1/5/5k54SCBUCyMe0zbIitzYuQN+F/6qWtlx6YwXFMXGr2pxJ6a4jJgyVHjr0VINr25h6Iv4XCZSqHW7xF8rP8z51/yz4tk0wB0vFwjTP5YwxIfgsTl/9sXviU9tNDqrWc+8qYMO3Yxv2/n4hsmfbmHSUhQaYLFEcXLfoYVH9ZyxkzA9tTZRnz42YBfM5xPD/kcKsT5ofYRA+VykrVtBESqlj8KkcL4pPm0wPon/tcdw7CHLCsioAq8eR4IsqwLP+yjUXXnB1BYp5gBFmvqRcza9o6DAvEfuHihm6EPzHub9MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV4PR04MB11377.eurprd04.prod.outlook.com (2603:10a6:150:29c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 19:54:59 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 19:54:59 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 29 Oct 2025 15:54:38 -0400
Subject: [PATCH 02/12] arm64: dts: imx8qxp: add readonly for ocotp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-8qxp_dts-v1-2-cf61b7e5fc78@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761767689; l=723;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=OJ5jYSKcHHZ/zbf3wYncmnI/AAG3OS9hMsjt48MLayU=;
 b=uw8Nf26bllduiFuyM7NoFYAvxqZlIkKvKBpTvH0+P28hon2x33O5P0XIbQEOpBrB0l0V9cxmv
 u5fe9iNv9k2DhHmBbnJXqP5Tf65hj9poME9Moq4BQhZeabh3pxYRw5t
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
X-MS-Office365-Filtering-Correlation-Id: e886e024-559d-46ac-919e-08de17250a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RExNTysvbGF1ZUlCTnoxS3hLMzUwSTEvRERkTnVyOFdsSWdyKzl6ellhWWZH?=
 =?utf-8?B?RmFRV1ZCaXlxeEFnZmpxNG1CdEpITFgzMmRUWUZINEV0RFVOVzEvZGFKb1RV?=
 =?utf-8?B?aWJSTGVpT2hUTDlYWUR6SmpPbXkyeTVvZ0NFRlhLMHhMYldOdTBuUHoveG1u?=
 =?utf-8?B?Z2RpR0tqTGxQUlorUFMvSGZFdzl0cHB0QmxnRU15NjVYL3RyT21EQm92YWc5?=
 =?utf-8?B?WWFPSWM0dVQxaE1Ba2FpN2FVZHlmMDhRTDNIU3NqUG1QSVhRVVZhOTc0S3Zo?=
 =?utf-8?B?R3pxaWtCSkduWFdaTjhPWFlTTnI3dWZoWVIrNWF1T1E3MUtBWGFuNEk0QWpH?=
 =?utf-8?B?cHpvaWZleGJvTjViN0hDUE9BN2pCdThjM2NUb29iVExmaFB4bE5UUXlzNERG?=
 =?utf-8?B?MkErOTY5NDh2bTVQMkN3R3pFY3c5Z3B1SUVZaVFYcUxyNlhud2o5K0VlVEhW?=
 =?utf-8?B?dGVXWW13TC9lSzJDaUxicU1kV1NoWnpDQ1MxeDNLT253d1JQb0RQSERYK2s1?=
 =?utf-8?B?WFRnaHlIRXMrMHNDbDVnNUxaUXJtRFlUZ05UOUduWnVpanFIMU1mTVVJNWFr?=
 =?utf-8?B?ZlVHOXROdlVsaG9QVVFnN3o1N1lmdXZ3VFpwTTFvOEQ2akZWeGEyK3BNUHVX?=
 =?utf-8?B?YlpoQzF1VWxJRDRIdmVDYUFJdm9NOUF3emF3ekp1R1g4U3IzaXQvUXN2OXFE?=
 =?utf-8?B?YzFzNzZpRWFWNmdjMVNyZDNiNnRjbnBwRUZxaGFzd21qTTVodmtEOWx4aDYw?=
 =?utf-8?B?NzZqdGJvNmRNdUZiQ0VUdmcwdXNYWnJwNTJ3RFV2SWNxUDhuNlRCUEhkYldS?=
 =?utf-8?B?bVlsRjdJaWl4eEJRU2QwaU53dWxEVGZmTDREcGdtb1pub2xpaFU3b0Rpc3J2?=
 =?utf-8?B?Wlo5THdzMmg2MUpWOTFBbTBqMlJ2bmx4QlhmU1Fuc0ZKZWhWM3NGTU1OVUVT?=
 =?utf-8?B?emxJQ0d6WGFla2NadzZaVVY1dnJiWjhaZTA4SjZnSDMzaHlaYVowd25uSVpH?=
 =?utf-8?B?NWZockV5c1FXcFdkeU52S1E0Sk9nU3FZQjlRNGlXTWFDd1YxNld4ajhFK01C?=
 =?utf-8?B?eTRaa2V3ODBsL1h1NFQ0Qi9qMzh2c1p6amIxaSs5UHNneVF3Tk1rSHMrTVBU?=
 =?utf-8?B?R3ZaNVNOQ05ianEyMHNHTHJKakwrVWV4Q3gvTFpkM0JHbXMvc0RHZHB5YTlm?=
 =?utf-8?B?Skkzai9RRzlNaHl4eTlmSkpOeHhiT2EvYTZsNFREOTU5ZHZDMy9YQTBPRWNx?=
 =?utf-8?B?eFpVTkZwYis2b0VtV1l1WnFJbFZ1d3ljc1c1VEVadGlrdWUwWXFFTzdDME8x?=
 =?utf-8?B?MkNUV0RldEdjMkc5a0h0ZVBMclI2emNscU5MQnVTYWhlVjlhZytDck83clBB?=
 =?utf-8?B?dVRlR3diZEQ3TmdNZk5EcDJaOW5SOVgreFR1Z3g2NUYzV2RLQzY1ZmdhYXVk?=
 =?utf-8?B?M2Ezd1ppWUQ4NEJvbWMrK0RsZmRxK1FRS3RFRU56MmlsSTdYU0UraDZmNFNx?=
 =?utf-8?B?TnhWYzR0cE9QbzlhWTRSQlpudUN4WW9WTUpuTmxFRE9rWXhtejVmNG85RWcw?=
 =?utf-8?B?MkZ0WFdkSjJWMlMycDhldmNETnFCOVE2N3FjeHdmK3FVQkFOSnVzWllqbk9Z?=
 =?utf-8?B?Lzh1bG4yYUN5SjI1cjdLVnEyYjl2VXZxYlpqSk0reDFJRXZQMUVNci82M2Z0?=
 =?utf-8?B?WkFiOURpOWd4T05PY3BoYzhGQ3lIQzdWWlBLSkRvQmM2bC8xN3FoU1lscjli?=
 =?utf-8?B?UzFteDI0WFErc0J5b2toU0N4OW1QajUvblZEU0w2azhrM1BoSy82dWZ5Nlcy?=
 =?utf-8?B?SjZEdHZvZUMxajRlZEM5STlXWjhMYXFZd3VTQkVzZXZJZE84QjJ0WU83NVZ2?=
 =?utf-8?B?TWUyYU5XM0w0UmtaejlrTGVBdHJTMi9nRkwwS0IzdVFGZkNiYVN3WmZWNHlE?=
 =?utf-8?B?SitWc0I2ajUyQjZrZHFsaTRjYjlaMmlqbDU2L1d5MGozUjUwQit5TTJ3ZXJK?=
 =?utf-8?B?K1pWNjkyNUYrNVJnYkhLOGlvbDBNdDc3MlE0UWJubms0V0lDZFljY2NaVnpu?=
 =?utf-8?Q?Tql8+/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEsxbndueHZ6ZU1td0JobEFvdzBOVXh4NXlya2JOeitrcmpES3lTNlFSY2R0?=
 =?utf-8?B?UWo5aUFTbHVoRmswNGxTdDJPTVBPUzZzL2xnL2JvanZlcVZZN0pBWkhuVDNq?=
 =?utf-8?B?aFU0c2FwVTRmWG1LbDdJcjFaZlNMQk5sUjk4SHBOUlA4dURqZnpuRjlHRi9O?=
 =?utf-8?B?SXF0WjFaS2kxTnlmUEtkS3hLeFVvMENsNHFIWm5pTTd1b05tWjhuR2lySE4w?=
 =?utf-8?B?eGhZR0NTWENaakV2cVVJNmtxL3J4Q0t0NDc2SlNqcEY1QkFxTmRpcnJpeEZH?=
 =?utf-8?B?NkpMUHlNbWxHWVgvNVF4KytNSjdKc2VYVHVJcHQrSkZOeThQMHBEOHU5OGlN?=
 =?utf-8?B?WGNnUDFFdms2VnJtT1JOWUNRc2dRTVFYaXdvN2U1ZHJPZEgrakdVLzNjRU9l?=
 =?utf-8?B?anc2ZEozbFh4bTNWU1M2QWI3ZUJBcHdmaU1zSEk3WjhhOTF0R0NDSmZ6M0M3?=
 =?utf-8?B?TXBHakFUU0lFaldrMHNFbW84b2JCOG5HUXVQVm9CUUc3RmZzcXhMNVpTUG55?=
 =?utf-8?B?L3YxWGxJZTNZdzk0dXBVb0JkeWJzRU1mY3l1enlUTFdWb2tBUnM4NWJ2N3Ax?=
 =?utf-8?B?YTlMdjYxQVN2MldBUHdJNXZLSEhmODByQ1c4WmNqQnpiS2k4NUdiNkFmK1FX?=
 =?utf-8?B?ZEVSdXBqMVlpclJoeU1ON01HYURiTGN0QmZPUlhScE1TUWM2dFRSaEFBM0xN?=
 =?utf-8?B?ZXFpcTJCWTBkVnczNjd1c1hqSkVCOWQrVjlLaGN1aHZDK1Uvenh3NXNSSWk0?=
 =?utf-8?B?aHcrUHFkbmxzSUU1NjN0cmpDTzRBWjc3eTlUc0pLYjhidkJQRzhYT2FWdmNk?=
 =?utf-8?B?aDJhN09VcnE4NWFzRzNnQ1Z3NC9VUnFXRUc5Wlh2YktaZ1gyTTMwOWpnRDM3?=
 =?utf-8?B?TDNHSzFGQU9LalZZSlJtV0F3S2tVYWd0Y2ZYdmh2ZFpaeTlUM3Q1VUdxclhw?=
 =?utf-8?B?L1VWNkF2ZnBuTEFTZHkrTFJLOWZVankrTDFOZms3QWg0SW5JYU5nMEp3a1hp?=
 =?utf-8?B?VDRDV1FSWlFhQTEyWXgxWmthaTJnR2lrMms0MjlvOW5wb3NGWWtUbU85ZUZz?=
 =?utf-8?B?WWRNUUE4ODBsQ2NjSGx2TmFTeGlHUDR0Nm14ZlNvVVZmYURxa2tCalpuaVZH?=
 =?utf-8?B?STExUzIvZmM5RjdNMC9wUE8vRkFmQkc5YmVySGovZWJybWtNVmc5RmRSYW4v?=
 =?utf-8?B?RFRGdHZRRlFZcWdKUlQ5am9Mc3AySVRib0NCMk15UkZ3VFNBSkRreFVDRUNa?=
 =?utf-8?B?d2tNaXRvVmpFN3lEdXl6dmYzRU1oRXRYZVR1a0dxK3hwU00yMEV4U0lCUnhS?=
 =?utf-8?B?OWdSdmJWRXNFL3JQend1MmdlcStHODN2RlJDU3pIdjJUR1dQTFJyTmVUdlh0?=
 =?utf-8?B?QlFJZ3VEY0IyaU5IVEJRa0gvYVdYRGJIL1VhemVRcndhbDZTM2xaZ0dyT1Bp?=
 =?utf-8?B?TXdJekJ0QkdXTk1hQU1obEpTcmFLKzgyTVRsN1JOOUVUcS9rQVpzWnI1RzhG?=
 =?utf-8?B?NGM5MUo3STluM29RTjhUeUhHaURsNEVjL0hKNXBLOXBqQ0dTa3BUak8zekZO?=
 =?utf-8?B?b0ZpbEJpekllTHNDQW1HZkFJak4vWGZWd2wvQjJMUkxCa3Q3bEpqenROQ3pn?=
 =?utf-8?B?Z0VVUFNVaHFJQnhBcGVLYU1ZQWZEa2tXMGhvMit5NWJDdnJTTUd6ek5hSDIz?=
 =?utf-8?B?UWtiQzNYOFJ0dDZtVHBKVzY3alBSWmV5ZnFaaENlcXdNYUErRkZUU1BMalI5?=
 =?utf-8?B?b0dOaSsvMlQzZjZnS3c0VEJXZGN5V3V4RklTRG94azFuaXIzV0Y2S1dXbFMw?=
 =?utf-8?B?ZDVsTVRVOTl0Rnorc05GTlVXQVlIYmF2RVlhSWhLQmN2R2JPQ05wTnduUWxY?=
 =?utf-8?B?K05BMjQyWThCNHBOZ1JPTVM2dnpQcnp6UU1UVEhGL3o3bjh4UUd5ZHRrZkNa?=
 =?utf-8?B?MkpQcW8zSVgvSjZWOVlMTVljQlYzckJQd0JZWGNSaEFBa1JDZW5DaE1helZj?=
 =?utf-8?B?TnhjQUJtZDRxaEVieitML3NQWVNhcFlzZ3c3K3M4RHhwNzk2MFVIVEEwV0dV?=
 =?utf-8?B?aTZYcXJqYlRYSDZCMFRlWFNhelhzZmF5am1pSDdYUXBiOUZ0MnR4Z0VnUFJ5?=
 =?utf-8?Q?WHtvsQAsajCcRcfhSSwr8liuw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e886e024-559d-46ac-919e-08de17250a6d
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:54:59.4210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZyCZpWq52QY5yKPF3787G3PQKK5TvWtAvpGsIWgMjg2X9meY18q8gOf7S+PMl115w9cdCL73yRBO6LtR2f5Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11377

Add readonly for ocotp because i.MX8QXP only support program fuse by scu.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index def6de8d579d40919e4bf7f88e119611ae4cb69a..cc82cc319159c2558400fa641570cddd3ad3083d 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -234,6 +234,7 @@ ocotp: ocotp {
 			compatible = "fsl,imx8qxp-scu-ocotp";
 			#address-cells = <1>;
 			#size-cells = <1>;
+			read-only;
 
 			fec_mac0: mac@2c4 {
 				reg = <0x2c4 6>;

-- 
2.34.1


