Return-Path: <linux-kernel+bounces-770562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 240D0B27C5F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEBC51D03BF9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A39426B75B;
	Fri, 15 Aug 2025 09:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H6I6gRME"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011059.outbound.protection.outlook.com [40.107.130.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FCF2DC356;
	Fri, 15 Aug 2025 09:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248716; cv=fail; b=OlicZ+p4nhBi/bVQ3BQDV6wGTy+I0Ck5CS6kwLQXHlgWIBzVdoVhfHOjJyXA2/EXtB3AKHzK2wZlypmTKNCfYe4QMGdSIN7MVrY+QS6OaYDoGI6D/QO654fn+STV9YqFVZp3W2p+hnbx9UAo51B22vGPgtspXDyGHkYiLT5MzoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248716; c=relaxed/simple;
	bh=JOS2VX9MCSz/l6b2mGHCHT3/tEpYg0J/v94aTE+P2GA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jSCk92s1oPgtyourWdAYIcxZvzWFJpoMHBkAJ4inqQYzeyQkS/5Lm1ihcpqiUuMKo0Gw4anwudrqSgAt7HFTr0iMMdtGGEzOiPEWC6KO+J6nUDHaH3ks9SThcxXnoeLr8O6wiV0UOMpEb8uENCy3/5GD2zHNw+yRL48K0/qQniE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H6I6gRME; arc=fail smtp.client-ip=40.107.130.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csI/FBM4kmorsE/+NDniwdHy0NhQrysIQGWCIT1af108JUd8qwYpg3RfcKuhiP13KZBTulav1xwxtfqBNTUHWw1BmlouGFLI1CSglRCHxV7SkJgWU7UqHR/yKDhqcdXJH9ELcSjY0/YVwrwnEM7qe4y7nIWILYPEShNaAWbZMXbZ7oKz3XIi9yefBlSIKc7frfK9b9HPqtkJ/xEHFUf40cG8UFdwFIT0g3ula1qSUk/p843m1F/tB4lbMp+V3pXY9iIXTgBEculse42nOywJRAb1Pmz2HiWBHIBb5DTV6tb7mcVNY1ht5gy19EXQDN+5zw52a6hnpgSWeUFz/Iif8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgYeUP3w71EiHKF3leKKLezJb4q3AAuf/ksWHgOH0b4=;
 b=mz9I+IlkkgNnf5fx49J3Cp/v8YbhTe+pX20B/pO/SsPCSsE9wzv8BvSsLWAm1O3WRu8HoyhhLfJuM35rt995nSRhbexur9sCzLPXA4oJmH4sVv3koNipl6VdGC/wEdFrDm9uoHr5C+atU170Skc2x789qoNb8LVB6e8MZeM2aPUqGQ/Asachro57TfNAtiuAWANaVXsMhxA52TJjGS4dnupGvzKpuVr/vDFV4GySmsHvIphFloNwnd7SdIqCxitwLvdabtB1B0qOQkgdf88OgwpDQmE0kEPV/2wFayxDf8AAfIQf1FQ0ZpXgNMXuB7dqTHn/6TBlBjyEnM35ogrz1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgYeUP3w71EiHKF3leKKLezJb4q3AAuf/ksWHgOH0b4=;
 b=H6I6gRMEmETySgoOo9WUN3JT9pvxUM/nxH39rdGFpf/wl9OrM3FNcOTyKrcmnyqidD5uxtMfF9QAbxyMMGPI1hO3x/I/8AGVLWoKMyV5wa2sykDsIr7NHrFl81tKkCfN6GbJsLnkoBcWsIUze6JyhLRy1YMrK7TE/lGuMfKL86ghvnpg8HzB0uYXCzCOrVBFJuxe0iuyr5quukUe/5Cu09uR48+OwcKxYUasp34vQo/DHAifKJ2D5LrxA2sr071iG+NQ3+X+OECdmmSIMcTvz+XLCyvMm2HqRXLEFQTsDkMbSl8C3AsLAYsWtQfwl+t/cG7BqBaOLZoh0JWLVY/ogw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8007.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.7; Fri, 15 Aug
 2025 09:05:12 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 09:05:12 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 15 Aug 2025 17:03:58 +0800
Subject: [PATCH 12/13] arm64: dts: imx95-19x19-evk: Add spidev0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-imx9-dts-v1-12-e609eb4e3105@nxp.com>
References: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
In-Reply-To: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755248657; l=807;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=JOS2VX9MCSz/l6b2mGHCHT3/tEpYg0J/v94aTE+P2GA=;
 b=kH11d0hsqBJTR/nHLLcdj4Pq8QQkaAhBW7dj1yB0L4Jv7Na0BjW4DgGcAZKi94ClGAGB2Ys+d
 pPRXvQpQQbsD9s62bdceXxIUZ3I7bvVU6o/Duhv6VJn2/oDzx9Hx4O4
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0158.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f6f64a6-80c6-4947-f08a-08dddbdad753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVljYmZHSG9raDdlVmQ0OXpVT25wL3pzdThrWEIwdXV1UkVNeEkyTFplRmdU?=
 =?utf-8?B?THVBTVNGSTF1YzNTUlZaTm5malVIV2ZWbmVSdUtnWDMyaUI4bkowbHQ1ejcy?=
 =?utf-8?B?WlVPcWNIR2U2cDV4U25WRXpRZER3VEM2TFdReHFqQUd6VzQvRXBsUnpBOWsw?=
 =?utf-8?B?a25RZUo1LzdVM1dOOFlyWFU5YnEvazJxM1d4T096bmVXcnB5MkVxNHJuWTRl?=
 =?utf-8?B?S1dFMzVka3ZQbWJrVUZ3eGlWT2JLZHZaOUpVT1hYdEpIZFVHLy9HY3BGMG0x?=
 =?utf-8?B?dWJjNXVjNy9MSlFQUThCVDZmV1hwTzhZVDdOdWhxSXE0ZW5RZkQrNGZoRGZB?=
 =?utf-8?B?clk0dldjMnpWbk9YQUo3TmpVdDArRUl0c2JvRGdZMUlLdW9jdzhJSlBWdXJn?=
 =?utf-8?B?MkVDM3NyMjRWTy8rOTYrbjNBNWlDZmphL1BMMi85NE15eFk0RnBHYnRJcnha?=
 =?utf-8?B?cFVBMVovSW0yMG5YWWd5VzNlWDk5YVQ2UFo1NWlmaXh5L1h6TnhkOThiZ3NR?=
 =?utf-8?B?TGs5Rm9SU2prc2pHcDJkbnJ1ckpFRGd1UmJUR3IvbmJKdmJUNlFPQTBBMmxh?=
 =?utf-8?B?VTByREVnaFVObUdUTktvbnBXVlJTL3psSGd3REZJbGhQRkFSL3ZnSjd6dE9P?=
 =?utf-8?B?L1dSMzRPQWxRYUo1QmFRc2pqTzdhL3pjOGswSUE5bUlvd0Nzcmsva1ZYcTY2?=
 =?utf-8?B?bUp0L1NlT3NLTmNWQysyaEM3QmlScUlqYklseXI3VHg5VzdmLzR2UG1YWXNO?=
 =?utf-8?B?bytLZTBzd2hvQTA2MnRhUnJZTzFXclJOOG52TEY4bjUzM0lzTDJmRmEwbTZF?=
 =?utf-8?B?WFJoUUNXS1VMSjdOUEorcnk0eUpXcHdsQXlRRlMwQTdobTc3RTZoR0pnd3hk?=
 =?utf-8?B?ejh3QTdmWVlVdjVVUHdVdDlKalNCNVA5c3RvYTYybXNZeFpnTG5KVkNjeGlW?=
 =?utf-8?B?UEd0ZFQrWkVCMEE1RkY5WjBOTEJJbGtlckVNME9nazNiQi9UWDk2Vml6Y0lB?=
 =?utf-8?B?RjEveGtLc2xJcmJ2YjRvcldqd2hRTGhiZjJtSDdWbHo0Njhab2h5TURzOEFV?=
 =?utf-8?B?L1Uvd3hBMUw4ZytvQ1ZwakVNeEM0S3FXVUZvK2NRK3dmY0MzMDJKTUNaY0V3?=
 =?utf-8?B?dXMyOG9UNTY4ZXJnaThxUEtSdStveHZ0RTc4anF3UUtKYnV2bHJCYm1TbGpl?=
 =?utf-8?B?MzVCMXR2VEdDdXpRVTFDS3d5UlNHN05rWVJtTWh6dGwwTktobmJtK2xkb1Y1?=
 =?utf-8?B?UjBvTHVLdFc3bHo4TE0ybURqQTNXVEtvb2hPa2VQOGtrV2lBSDVrekZ6Rkkz?=
 =?utf-8?B?VXV6MzV1dGdjUlNzbWhNWXB0N2Z6bHdZOHEwWVlwcXMwZHczazYxamI2eDJw?=
 =?utf-8?B?cGNSUlJ3YUVWWmZEd0RhcWFSd2FEeDVLZzFzR1NoR0t0QkptYnZiWmJyNldu?=
 =?utf-8?B?ZXMwNHFZOWZjb09hbExqN3hNd1BKeTV0VHlFb0Uxc3RlWU1jcGxybEozWlJo?=
 =?utf-8?B?WE01cGFCZndiY1p5czIwVyticUJQeUJQNnoyWHZXMC9WTmZwc1ZKYTBBSENq?=
 =?utf-8?B?WEJXN0V4Y3YzbzgwZmpTQnAxdko0Ykp3a0NyTi9vd0QwZ1BUR1JZb2dhckFy?=
 =?utf-8?B?UjN1c3RmSVhzc0dzeVIrUWJkNnF1ck5UeTA3bmlCcUFtbXZLbnBKZnBsenRv?=
 =?utf-8?B?a1E5aEdsNUo5N1JBdGtocFZQcVREbUtyQy9OUHhhUGhEZWhLUjdlYVFCMVBl?=
 =?utf-8?B?SllZdURtNDJZM2NxdGRkQ0N3QWlocURDbTBobG14SFBiK05RTVJIOXJoNnlN?=
 =?utf-8?B?TUkyRGZHajZlTm51bXdsQ0JNNitGVUlEbzJFWVJ4QndZTFN3SXZTWVVLMnJN?=
 =?utf-8?B?YzJKSEcwNVVWUHBpVHJvVGFNdUNrNTRMczlPVERtMi9KQm1jZ3JKWDdZOWJS?=
 =?utf-8?B?Y0xsaVV3ZUNScXpDVmw4eEc5NEhTRDhRQVhBMkhEczlVLzJ6UEJFL1VYVW94?=
 =?utf-8?B?dmp6a1NKaEx3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFFpY3NKbjh3STYya29PMGtiTHYxMXE2d0s3NUE4a3A2RDdEdHlRWmF2cnBu?=
 =?utf-8?B?eEFHaHNXZC9ROUtNcXFvVXhPNmxYSTJ5VEJzREg0S01lNkZ0Yk9XajBaN0Jy?=
 =?utf-8?B?K0ZBbHAyNlZsbEtSM3RIdTRaR3dCUk9jcGxITWlhbVplWUZQbGlLT2V3UkVm?=
 =?utf-8?B?WndubkVHR1VnLzJTazNNN2JubE1Icmh6TEYxNzl5RW9DQ2FRUG8yUVZOb3ky?=
 =?utf-8?B?ajZ0cHlWeGYxeVNUdWswY3h3ODRNM2J2NHpqNVVMYjdib1pyQTZDb2M4VFJF?=
 =?utf-8?B?N3lhT2ZocWd1Q1o4ZVIyczdzRklNTXJHaGlNUnk2T054a3N6QXlodWZlVVVy?=
 =?utf-8?B?aThTellnRGVyU0VnQzNiYUJGV3Q4eXZiaVNKTE9adHZ2MWFuekxUbllkWVNH?=
 =?utf-8?B?TlR5NENPc1JZMVBuZzU2QWlwb25ORmhGbHlzRjRBb3orVTl4YWtEK3d4c2R2?=
 =?utf-8?B?azFpZkFZWEJVZWJIWGRkUzIvTC9mcGxVTkIvWG9DSnFoVGhNdExEei9IVXdP?=
 =?utf-8?B?R2kyVGhpQ1poZm1neC9QQ04zL2Y4QWp1eHd3SS8vUmxteDlUSm1sYmtpM2ZX?=
 =?utf-8?B?b2VOQ0dieUl0ME5NWlVIKy9ZZE9QemF1dWJZQ1FhT3NReVNUZExFS3VLczJK?=
 =?utf-8?B?RGwrZVNDSGJOQ28yV2psdCtYWHJVZ2c0Zkx1bUw3TzdCZHJ3T2xRcTBUWUlo?=
 =?utf-8?B?eGVUM2lodDBVd1dseC8xOWZvdnJBcnczenR6U0hnTkxoWjQ3bjU2d0FKT0E0?=
 =?utf-8?B?OVNaUzJnK1lZVzlzOWorNkROK1ExbldFbmpGd1hmSDV6WVRzOUdoSUZpaXc1?=
 =?utf-8?B?NkdFY2dOVy8xdE8xWWpSc3hZaTY2ZnBPKzVBSUh0MzdxY0pLQnlVWkw4Q3Nr?=
 =?utf-8?B?RGVISWMwSFk5bjVXR3VWbHVNdDJqeHA3OVRNR285UlFwckZxeVkrVGtwVk1V?=
 =?utf-8?B?WklwVUNEWUVkdk1maXRVSUhYaXNpRHkzaGlZRWZvSU01QVY2WUM1bGFqWllm?=
 =?utf-8?B?WDdZWWI1SHNvUjRwbUl0K2ZyR3lDaCtqSVB2MmwrNDN1Y0RLalY3WnMvL3Q2?=
 =?utf-8?B?SW0wMyt3VUhYVFZrWWxrc1JuOGNNTlc3Mks4elNTSDlxU1FESUROY3BkVkFY?=
 =?utf-8?B?dWJMRzRFV3FNUlhyazNkYzlOK0dxb0M0aVlTSXFnTHZnN3QvN2wzQlZMcnVa?=
 =?utf-8?B?bmJyWWZPckhiN3UwYVhVWE5NMXJCeHJrczJOVExxUFdDZ3FLZ0VjSXljQnoz?=
 =?utf-8?B?ZnZVTTdLWksyOGJSK3ZOcnAxRzJFKzhzdFM1OG5uTjh5QXNmL3VJVlk3Mlh3?=
 =?utf-8?B?YXAzYTZpNE9nYjZXRExWaGxnSis0MDJVcU9YREl5Tm9PdDJjTGRiSGRVbnMw?=
 =?utf-8?B?UzhIVVRoRXRpVS9nZlBJcVljZTdCaHdQWVlZTUlwNHJBRld2YlE1b2hiSDVU?=
 =?utf-8?B?VTlMSm1Pem5FVXRZS2Y3UnFjRlQxNEZXQVE5NkJsYWRqSGEvODNlOXBiVjNm?=
 =?utf-8?B?dllBS0NxVEV4MTJCQ3prbWRoTG0vVE5kQ1I3OHlsbE5qWjRKY2k1TUJQTmZ5?=
 =?utf-8?B?ZmE2emo3ZDlZMkp5M1Y2ak9jeFJMOEZKdWFkWjFFQ0RWK3V3em1TN08zeEFz?=
 =?utf-8?B?TkJaSU5jT1M4Ykx3VmRhZ21kNDUrMDlkS21KTnNOYXVkMlJjS2VqMER4bmtI?=
 =?utf-8?B?R2dSYVVSV21MVHNwRE1RVW1mRXRBL1dHT05hazY1NmVDUDh6TDRMcnZuUGlk?=
 =?utf-8?B?N0tYbElISTI5U3A3MTc5M1I2QzA0STFnVDgzUXVZUWdpSjlxN0E2QTlBbUpi?=
 =?utf-8?B?TEdhZkdFSWRxWXh5Y3hPdEp1OW90REg2L09iZ3ptek1QaWNXNWZGYUZzRlAw?=
 =?utf-8?B?V05VVEJndjREWE8ydHVpa1NDcklUeSt3eE5hV3ZPUURZZHJWelZmZWxLV1p5?=
 =?utf-8?B?N0pIN2lwUzZpOFRvbnVrMXRLZkhDTVhLaWlkN2Nicm03bVpIQk42cTVBVXNl?=
 =?utf-8?B?VXlxbTFOUjNHZG0ycGVSSmpjRkZSdDRxcVlDR2t3ZHVuYm9mN3Z5YzNUZlp4?=
 =?utf-8?B?ak54U0hJUGViSUFzbERETTFSY2d5SkFIa2dGeGkvT2ExRGh1Q1ZwOE5iQ05O?=
 =?utf-8?Q?K6lCLLcX2OLr0FG6x0nZCo+hT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6f64a6-80c6-4947-f08a-08dddbdad753
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 09:05:12.0537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WeZf2Nve9aHxQiGLaVPlqePUhKlky7IPvmyykOT9i9pVefq2/7eK3Q7kNmWVELlnZk41KFhQZknnCCYfBcziA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8007

Add "lwn,bk4-spi" compatible spidev node under lpspi7.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 0ad5707314fb225b74d8940908b53dc2a444ed5d..193fc2cc9ac92bc3f0ff0e14ce0b1f84e91516c5 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -507,6 +507,12 @@ &lpspi7 {
 	pinctrl-0 = <&pinctrl_lpspi7>;
 	cs-gpios = <&gpio2 4 GPIO_ACTIVE_LOW>;
 	status = "okay";
+
+	spidev0: spi@0 {
+		compatible = "lwn,bk4-spi";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+	};
 };
 
 &micfil {

-- 
2.37.1


