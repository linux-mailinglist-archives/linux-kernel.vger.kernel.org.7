Return-Path: <linux-kernel+bounces-776429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE87DB2CD3A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7331BC825E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F9C343D66;
	Tue, 19 Aug 2025 19:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gxs6HSPC"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013061.outbound.protection.outlook.com [52.101.72.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA513431F8;
	Tue, 19 Aug 2025 19:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755632685; cv=fail; b=cgT2VU5MxWKRdmlOz/fxO2OL9yumscMj4qmRyWXGvT15ck89/s/dDUmzDdomaDfUDYGuHvbAbdcJJylEaXO3pgceS+iGYp72NRjPZvUJSExnI81FhFdAAQtphT+R8pFjmzP7NTqh3fDR6ZLS6Fe9Pl/lMyOAg01jtohai1ImhLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755632685; c=relaxed/simple;
	bh=r3Da7krTQc72m+3sjxyBBU253EN260Kv7eDFNCmAO94=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=q5MFTLzPBARXVOOabsDXe3YRWITStaIy4NQG1toyY9CgRCXl4xjh4RsLnSW/3g+EzEj/kz7QeD9mzNjA3bmmnWfqn1NzyEhsxermHx47440HCgdOCHKxSih8uIMtJbopKhKJl/RXHEyL4x47m+BUQUy5mLvdDSr8qbw03dNYXEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Gxs6HSPC; arc=fail smtp.client-ip=52.101.72.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNMqf0q86JAJvjVAgydguu5c5j4cRSlbgnJIgOZb2rjpyLOL4uZ+P27ASucng8N9uaOku7naEecE7DIARZEGAmLgkVaBNS+oZ8Gd8iWNKuzOfmGCA2FMLzLx1j4ZIjjDwkjg2P7v5N0FaR2E6tau3aYv4WKefF3Pmqjt6lAVuHsTHnexGp+qRlUP6aE8ffi1nT1rEfvEFgJDkxwccIn8JQ8M4F/jEu9w5HuvDLu8Vt6aS6+GIsUpNu0VkkQbgxE6A47n82VVTuaodMVYw5sOd5mtscBqrfRtNxjiIH/5II8zUQYGoEy73j+gM3pwvoXT38h9Y6NkVbIxWRDVAfBQhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gtb7uL+TxLoibq2PrKmEyoEOPqn1iJTfEjCH7CRYQog=;
 b=c2r8i24zdt+XPCDidb6eyJDspm4wEx6584kuKDav3obe3uyPTWCTAei/qoCCdgLZIM5mKVCqSTKWDAeh6lBSG9lhhbaSpYlCkTaCX1Dvf9AHLGZmve3c6ZMtWxCJZWVnzsr3jZF1czS7xTHVdg9LfPFxogsbBKfhAkMaDq+kI8UbwJfIrMyaPjZ50z/OJ2I/aTFYg1Z4ypSEaia0ppxhsQ032m4SnZoVozYKoEK9N6zHz4d5AEC2A+iQKpvxUZdPTS4vPZ/wJFklNH3xW8vyU4k+kEM5o5yOs9bCSht+zFurUfbqwsnbZIh2jVBBFEw0h+JUIhotf5ywhIUrrFXlBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gtb7uL+TxLoibq2PrKmEyoEOPqn1iJTfEjCH7CRYQog=;
 b=Gxs6HSPCwQb2TDBOiDtP/yEieg4jo1itW5brI5tCVzqNYbeyZt3VeKZerLQD5kWqMqOTWsmMleWuwYmlONGylfVcYOX1cGJqlv4qgItvLjq89StIkSMdnEuTlMAK3UKAvv26kPj6jvxAcvxUUJVD4TmQOKk1+kfpLgTGprnsC9NVoRQJZWNprZqvRf4q18tXhExgrsQbD+3/kIHPEDwpVZLlykFpQ55dsrwgOTufLbNuPl7tZJDfcFXUrKHNR+D0DE6Vx/CX86hEGw9L59WsiYEnL10BzruZN/ewBPoYpmB6Fe1EcyGli0impN9XNAsoJJDkmHL3NsXaAc4wax2pGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7313.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 19:44:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 19:44:39 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 19 Aug 2025 15:44:09 -0400
Subject: [PATCH 4/4] ARM: dts: vfxxx: add arm,num-irq-priority-bits for
 nvic
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-vfxxx_warning-v1-4-080930d8e1ea@nxp.com>
References: <20250819-vfxxx_warning-v1-0-080930d8e1ea@nxp.com>
In-Reply-To: <20250819-vfxxx_warning-v1-0-080930d8e1ea@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Stefan Agner <stefan@agner.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755632668; l=891;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=r3Da7krTQc72m+3sjxyBBU253EN260Kv7eDFNCmAO94=;
 b=20Kkd31nj94lUDFqRm21BYjIFdfJA/IGSrIo8xbsNIhY18mIb7JDCFs28XPpM9Va3+1smSupg
 0ZcTxWnGOXzCRNfbyJ46MC/0L08sk4qdFjAp3BJGbAyv02GcdRZzeMJ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM0PR08CA0016.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: 7178b78c-75fb-44ae-231e-08dddf58d5e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVYvNGJjN2U2Z2tCL3pERHJ6Sko2a0JKNVFEYUROQVgvcng5OVlmaFhKOHZi?=
 =?utf-8?B?RHFFVDJtYWtOblc4cWJvNGJGbEdvS1hwdWpIWFFXMzBBelUrb3hZTE5CRkVK?=
 =?utf-8?B?R2o3bGp3ci8wb3lkMUtROVM1VU1sRmRtNG0zZ1JVN2RzQUVJVHA4RkEwRmFv?=
 =?utf-8?B?NUsxcWhQNEM3bkVEK20vV0lYWDVkVEFlQW5FdmoyUGU3bmpCczd1RTNVNzAw?=
 =?utf-8?B?NnFYQWF2cnNxRG5DNjMyRjV3dmpmYkJnM1V0Y2N2cDNGdHJ3N3B0bkJzeEFi?=
 =?utf-8?B?dUxpUWpwbmowQ25XNlNXNWlFTkYyRXJpWmV1cVJMZFdmZFdjRFFCVll6cGh4?=
 =?utf-8?B?TDNOZTdycjltdU56NzRScXExdEFUTndGTU9jZUdOLzBLd2s1MXF1S3dBNmZv?=
 =?utf-8?B?NVNWanhzdzUrQVM5UC9nbGJmdnQyZ1AxYU1SVFMyQmg2dTRiZXBkVk5HMGdh?=
 =?utf-8?B?aTcxY2V6b2YxM1hXUHJUYS9QeW9lN2VYZmRtK1NBYytGNWdPelZ6SWs5TmJS?=
 =?utf-8?B?MEdPZTZOTUxUL1BMclZUVURlTGQ2RjRHYkZ2d2dHTVhJWHlCR2V6SVhCR28x?=
 =?utf-8?B?VW1NQi9RYjloNVMrTUF6bitKM0hkbzRyVTV0NFNPSmJzR2pxbEV6aEZiV3hU?=
 =?utf-8?B?dTNCcXhLaDlxOUdlU2FhaWEvWHVEd1BLWUlGL1FqM1ZVSEFJUkVEaVJLelRt?=
 =?utf-8?B?TEFDQ1ZmOGtxK1luYlM0MVBMcGFKMEJWd1ZRN25BL3BrYkRHdzRFaTVuNFUy?=
 =?utf-8?B?dlpOSEVsbzI1cVRHcWtRa2xWTVJhQWRNd25YL2htWGtoV1ZCdmdKNy9vTGpn?=
 =?utf-8?B?L0NlSjBpWXVrb1Byd2FGWEhqNUtyc3FuSThLK2ZveEhvMEZUMUlGdEFuUzFC?=
 =?utf-8?B?dUU1QTMvZGNVWGFUMURTSHRQT01hakwzd2s0dEE3TlpLN1hkbWVkTE1qRE1V?=
 =?utf-8?B?clpHaEFMdUJSaGdaUHg1WDEwVURhSStKcDJJMk1oZ1hQM3RrdlE2YTR2cFBR?=
 =?utf-8?B?a01LVG1nRjJKT1N6WjlMSjEyRElMMjY0Yy9WLzhLakVYRHNLK3BXZUxlRWdR?=
 =?utf-8?B?RjZuNk52cHUwY2tGamp0L1ZnNlpKS2M0a1pJL3FCM0F4RzdqL1Q4QjJJbnJr?=
 =?utf-8?B?Q0V4NTBseEt4MmlYODUvVE9CUmpQRy9mSEVCQW5ZU2IyMXgyd3Y4M2wyUngx?=
 =?utf-8?B?OUppM1ZVSTVDR3NkNnFLMk9CZWdFd3Jjd2ZxYndrcnE3VElqSzhnNHgyVU5Z?=
 =?utf-8?B?UXpCckdRV1dQeXNLbEFBTzBuVUdKZGQ5QldNQ3RHRXJVRVVRTERLZkZ3QkhU?=
 =?utf-8?B?NmxXbzR5aE5nSHdQRmpwejAwRkJMV1JOaktPOWhyTFZ3S1Z6RUZqY1FDQkhJ?=
 =?utf-8?B?Y01JNVdPWTYzY3VnWHZEMStFT1hrb1pWZVBQSW1kZGFXWmlEL3MreGVNU1Jm?=
 =?utf-8?B?Mm41cVBZMFNlc0QwdVZUdEUvSnFoMFYydmRiOWNjZGZ4eS9ibmQ2YkRXNkpz?=
 =?utf-8?B?anRzd1BucW52QjZSMXdvT2tmZW1ib1M4NjNicWorQmZwc205eFB1MndKNWtS?=
 =?utf-8?B?YUJxN0tBdlpVOEthK2tHSGlvM1p2Z3pBMGlqYVdMWHpKUllMcXBaY0p0WE1S?=
 =?utf-8?B?OVlRUlVaTUx3SnBpU1lrMFBob293S0EyOHdPWmRQZ1RnQTh6M21tYllIcXN6?=
 =?utf-8?B?SkxxKzBoeTV1bGhXcVBnaWdLdXUwT0JoWXhkZ3FocjVwc1NKN2dkZlFTNmkx?=
 =?utf-8?B?VUV4cEIrRjNRQ0N5TkhveWpoY0ZsNHYzandPZmVleFpNSlh4TE5YN1E5WDZF?=
 =?utf-8?B?Q2JoOHcxdEw2VTZYcVBmdGkwMXRiSU9VbUFSK1ZXQVQ5WjdIZGs3aS83U3NM?=
 =?utf-8?B?eDFhTzZpMXhYbTc4a0J1K1d4T2x4M0JLck5tdElPZ2xDZXhraE1GS2xMM29X?=
 =?utf-8?Q?78vQFLCPoEs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0dRT296MGY1UVEzb0liS2FDeklsaGJ0ZERrZFU1dFZOYUczTDdVZVQxVytD?=
 =?utf-8?B?RlVocmRJUFUvYko3R0JoMGRycXYrdjg5MzBSVDZxZXFxQ1dJWnBxVU9yK1gx?=
 =?utf-8?B?MysrQU9ZdUVRZ2F4bUpyL1FPK21CT09TR2Q1SVlyYm1mbFBFSEdFNDRuN0k2?=
 =?utf-8?B?QWxhVkpMUWdNY0FPRXJFTyt1SDdOdmd0RnJQeDdrZUJ1L3N3VXora09QMWVj?=
 =?utf-8?B?YmxuZURsSzJFUlBPM01XS2I0em1uR1pYOXFqQVNqbnhBSWhMSkhmOFhrRjMr?=
 =?utf-8?B?Q1ZiSmhkazd3YlR5Q01YbFNBWU5lT3QySU9jdEdiNHZqaXlaSVJ1bzZodVJW?=
 =?utf-8?B?UW9WZ05PN3RrNlhWS3BkNzRKZ0VzbFdwOXNRaVpRTnRvSFQya0ZmUy8rdDBa?=
 =?utf-8?B?cmRjTC9xUFlwbEFRWCs4NHdLbjM0QlBxWkE2dERsc0djQWZITGR2TlJyZGEx?=
 =?utf-8?B?N2ZseGdVdTVTRHNCbnI4NDE1RzJVYmp6UzA0TE5VcEh5eTFNSHVxMGkrcTZT?=
 =?utf-8?B?WEcvcjYvbFQxOEJENXdhaWVKTm4yaHZxeFFoSWNSdHBoUlpjK0xjRmlTY0pz?=
 =?utf-8?B?UGppamJHVGdYMDJidW5SUnlWampyc3dLZlcxOTE5ckFTNlNrYTAyRnNCQ3pu?=
 =?utf-8?B?Y1VFYjQ2TEFsVzhrSmhQa3Fudi9lS1NFN0xFcjhkemhKbVJuN1ZNeGorWUJp?=
 =?utf-8?B?aVpIMXB4UTRCeE1oUm1TN2FDTlpXSE1TUU9uSnk5Vkl5bzNWbVA1M1JpelUz?=
 =?utf-8?B?ZU1WYlBqOGdGVHRDZS96dDBVMCtUWUdOZ002WHJKY244WnVYNzI4akFZOXN6?=
 =?utf-8?B?SmF2OFpIeU9KOXhTSWtmd2xpbStHZ1NIQ2hMRVdCRnp0MnZWU0NQMUlDN21t?=
 =?utf-8?B?ampINEFFYjY2VU1vNHAzNVZGWmdDNmRVQ1ZDN3BUOXQ2Y0gyNDF1ZlpPdjN3?=
 =?utf-8?B?a1NyOUFPZlhGVC9XOEJhRVhlSmR6M2dsVVRhbGp2RHlCdnhVMG9aOTZKUVlN?=
 =?utf-8?B?NzlhMmw4RnNqWWU5WHpWOTBZVjJJY1hvOHR4WFk4WGNsSHYrU3UvN1FpRW9B?=
 =?utf-8?B?TW1vRVRvYUV0Q3Fqc1d6NkUrVXUyQThYSXhYRldZN25QMDVCaWFmRkpvR3JK?=
 =?utf-8?B?RXVxc3NrQjU5VTcrMTBSb2E1eVd2WTJ1ZWd5Q2YwYXI1SjVBMFNQSFp2NjVU?=
 =?utf-8?B?Zy9OT1dtSzVCY3RManE3NWJoWE9FeHBLUDdoL2xJeFBCWWJJMy9CY29CQy9h?=
 =?utf-8?B?YnVwN1ZaYWF3NlZtenZxV1VhSmtvdWEwaTd3dExxWGU4SVpzY0VpeUc2WEdE?=
 =?utf-8?B?QXlqSW9hd2NrVkQxUFBZK3FYcy9naE5rR1FHZDB3Mjl2RXB1cXA5VTQrcW1W?=
 =?utf-8?B?NVdMNDM5ajVjV0haR1h5S1VvdVZHbTJka0lnUFZCQ2loOURvZ1luNzQrNE43?=
 =?utf-8?B?Wk81ZUxJbEtkdXJQYnBHUHE2WHdkNVVwM3VIVGhJVGp2Q1dRbTdsd1Y2T1Ev?=
 =?utf-8?B?SERwRXJ4NFpPNUxvTTRjbnJSUTNkcWFqS1IwUldHRi9VbkI1UVArd051Mm1T?=
 =?utf-8?B?Q2k4ZmY1L015emNuWUxPTlQ2ZCt0eGI0TENNSU9UU0VZR1FuQzg3UW13K1ZK?=
 =?utf-8?B?WnBSTXZleHNNbTlMbWZ0anpZYUIyZjI5YW9BT2QvNjMzS09rSU0wMmNyZjhM?=
 =?utf-8?B?SHVJNHJLQ2xtVWIvOWFMRWJ0eVRWTUxjNjI3V3VUZEhUTHhCZnA5dnlvZ1Ew?=
 =?utf-8?B?Uk5yajlVSFdUQXdxNisrNXpsVlRxZzJuOTJMSWZKbWxBMGVydkgybmRPM2xh?=
 =?utf-8?B?RzFscmJSSUhhckRaWXJvM0JZK3g3MnVRZ3k5NU5tU2g4QWFsVzJMQU1WakU3?=
 =?utf-8?B?aDhXUjNjRHNUUW01WXlxZFBuc0tpKzg5cTlncHBRQ2wzZFFUSDd6amk0Wk9J?=
 =?utf-8?B?SFVudXVsSmVaQ0FwU1MxTEJxT1VlVlc0ZEF0REdDQmlvcnRrODAxNHJPbkFM?=
 =?utf-8?B?aWpQMjRvT2Q1Snd3Z3hqcUhOdm45M0hYSytRKzJld1BqMG9IblQycE9pT3Yw?=
 =?utf-8?B?SkFMVmpTc1ZkYmN2dmEyNEtOQTFGT3hzSHNadlRVUjdBckxnWEEvQUplV0hi?=
 =?utf-8?Q?xD32dYyI1H2f4iIwh1z6ZsTye?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7178b78c-75fb-44ae-231e-08dddf58d5e2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 19:44:39.6722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1l7S4X6vKjeIqzDOrcKcqgvRjKq7U9yz8PKwIkiV7iLzL7qnlqJlToGkFmjBHq+XnLfrxxAceXDw5RkSqNXquw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7313

Add arm,num-irq-priority-bits(4) for nvic to fix below CHECK_DTB warnings:
  arch/arm/boot/dts/nxp/vf/vf610m4-colibri.dtb: interrupt-controller@e000e100 (arm,armv7m-nvic): 'arm,num-irq-priority-bits' is a required property
	from schema $id: http://devicetree.org/schemas/interrupt-controller/arm,nvic.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/vf/vf610m4.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/vf/vf610m4.dtsi b/arch/arm/boot/dts/nxp/vf/vf610m4.dtsi
index 2bb331a87721000880cebeb81dd3c00febfbed3c..ccb5deb4e9528fe005a5691347d4a3852fa52ca3 100644
--- a/arch/arm/boot/dts/nxp/vf/vf610m4.dtsi
+++ b/arch/arm/boot/dts/nxp/vf/vf610m4.dtsi
@@ -52,6 +52,10 @@ / {
 	aliases { };
 };
 
+&nvic {
+	arm,num-irq-priority-bits = <4>;
+};
+
 &mscm_ir {
 	interrupt-parent = <&nvic>;
 };

-- 
2.34.1


