Return-Path: <linux-kernel+bounces-834291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49670BA4598
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D165169056
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498A21F542A;
	Fri, 26 Sep 2025 15:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gjPL9ktU"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010033.outbound.protection.outlook.com [52.101.69.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC590219A79;
	Fri, 26 Sep 2025 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758899180; cv=fail; b=G6hGfYv1EqidABuXVWQqb9pI3+VWf1NfVrrW8HDPnqnFXY031Y/O2VsJ+/0Lo2KCgWU2Ij4RJ8rAu/TBqE0sZrZaKodwV5/d80D/UpPfGJTXBCn6BiyPo1FaidF85Y4XKX0UpIGbXfTQkM/dxxHxsiwTqQQ/xzF7owMxD97a+Y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758899180; c=relaxed/simple;
	bh=2N2q2cKPZ8ZVOfvA3LyQDNr8Tu3pWDaE9bF3oPfKGYo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KqrZkcVAQgKkKIPqLtDr79wADYTGE53D7qBP+oL1MCtzxL5XCq+khngX2+d6m+Nka6vyfe8LkcHlQww+qaRpw4R9GS8zEC0NCoPzhP4qUWhRY5+zaExKI6DQvMzkZ3AjiadFOgITk/scZdz+xP1PKZIb5Q3vj7GgaTB0u9uq1Iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gjPL9ktU; arc=fail smtp.client-ip=52.101.69.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYrPnwk5Ghl8NJI8QsPEL+q28FWjAbdmc2O44dN7jkAAKGhAvLbGXTaGDiNptjCuojZjQiRDga5GL5JaudOA6pfZQzWRSFBYQwqaJH7D8oLZmRcpzEP+VEhOgCMr2NLpypKVdXcYTdRDj6xcFwwPIWrRvfy4h0ry7nVOMBeYOMwbIz4++82hUitS++kU6iL5nn2DBsl4TfQQKSz9UTaU+AMww+3uHa2ZTiJcvDUw2VFcQ2dJUc4N49YGS5xlRv/T9RNzGbimdoXVEopUFHGq3h+WCblCWqVc7gStIXSxK+GqQplI+Sf8Tzs/6XMKxB2ZCUdZDDdUCzZC4QYFMp4XqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9iLmdy37RKHkCAlvSY7Udy7GnJJ+6QLI7MsTCVz87o=;
 b=spqd2NMcCz8EAUUe2qAKvsArjAunnSsTSa9UiUKTAAS7Bb6tJY70ldNw9tNHuG4O80LVpuIiKesCSyOGjmWCiObrLDA/eGRXYKKa2dHFJFeRuuyBs6de+1H+8AQFFAw/wmkZvfyqcg9TwYVZL1k0sziaBzobDE39VN0eMb8qxKs/TOksg1KClFOQK3vbNIAmSXgzkEP3n0glMJIYq7HSthKCjVjzpbIfmX4+NPpOqkdVF7xCWIMZ0vwAmkm75FG3wfFAtydFBb+cEL1fh6y/adojAD0bIUmRD8EPlynws7VfdRhGyFSzeMfw+9miNt552OrO65ZJVbzouD+ItELZ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9iLmdy37RKHkCAlvSY7Udy7GnJJ+6QLI7MsTCVz87o=;
 b=gjPL9ktU+BNkmnoFSEm8Jad+pW11l2nJvAInzWtyWm+3lFDPSb0p5FwVwdv/C/A58y+v08yXuULtLjZPAY5N7/syYL2Sfn5GnxboCPvqV41+HR2ZlocWqoGIm4KiYEB+dB/f/anl6rGScEBtre76lAa0kME2hrv0Do0Ae59m4SlcNxySWurTL1Yki5JY4AbAAOkz71ufdC1d4H0JwN9GIdFzNc4iF0AisOhgTEA1/KpPYH3GGsGMR9dcSJ52eBlmLk+ZIL0OM+idVS2EeyPnK/9CH4c09RajSG82dDTfsk0Pn0/A9dZ0UdMtzyV2nEAijynl06qg+vn70kJfbftEYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PAXPR04MB8960.eurprd04.prod.outlook.com (2603:10a6:102:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 15:06:13 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 15:06:13 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 26 Sep 2025 11:05:50 -0400
Subject: [PATCH v3 3/3] arm64: dts: layerscape: add dma-coherent for usb
 node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-ls_dma_coherence-v3-3-602b1c0ce6b4@nxp.com>
References: <20250926-ls_dma_coherence-v3-0-602b1c0ce6b4@nxp.com>
In-Reply-To: <20250926-ls_dma_coherence-v3-0-602b1c0ce6b4@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 bjorn.andersson@oss.qualcomm.com, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Ze Huang <huang.ze@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758899159; l=8721;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=2N2q2cKPZ8ZVOfvA3LyQDNr8Tu3pWDaE9bF3oPfKGYo=;
 b=XZ6Revw5FRYHRAe5e/xYXRi045WJHCyOyN/8NZi+aMlAHaaQApLyeJppnmGPQ3URSojSOafze
 uHhpH4W5k1ICAVGzdO/BjOIdgY/OPbwmXdIF5e/JZrge2DwCOx3HvyZ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0072.namprd05.prod.outlook.com
 (2603:10b6:a03:74::49) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PAXPR04MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: 46863d67-68d0-4635-4dbf-08ddfd0e3be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXNDRzVMRmRkTy9BRHBiMmtLek5oU2VDTG5La2dFclg1NGEyRGJTVVc1djcy?=
 =?utf-8?B?RHlSSlVXcG5ZUmFkUi83RkNNeld3MWNIOWNtM0ZkRElHSjQzQ2l1TU9MWTZ5?=
 =?utf-8?B?eWh4UnZFb0hYTGRvQzR2QmdGVDc2STgxTXhJejlvM2s4c2YvK1dpRGNKbWNO?=
 =?utf-8?B?YVR4eEhERnFwNDhFSTErcGpuc2NzelV4ZndxNkp5aVNYdkEzMVNFYm5CQlVj?=
 =?utf-8?B?dTFBTDlFd01UUERqaFg4cWNHY0JaWlZJSkJrUDdHWHErdWJMczllRkFoOG1J?=
 =?utf-8?B?NytTOFhESllkSWlPbnVYRk50Y3RSMUlVSWJLbWNsclQrRm5rczlCcWhTVDlO?=
 =?utf-8?B?WDFDWDNqSzRVeG5hZS9aUlFicFAwdll4RDZoR01Nc2NlZTBmRVZMdUZ3c1J2?=
 =?utf-8?B?aHIxOThYZnNBQkhLWHdXTExEN3hybW1tdTY1aCtkbTJsaVBwWmFiWktrcmN2?=
 =?utf-8?B?Y1daRGc3QWx5Wk1PV3hVT2J3MW0ydTNIcDUyVnhGc3pNNEkvYjh0YUVKYXAz?=
 =?utf-8?B?cDgxdGN0c0N1TmI1ekd6V3k2czV5OGNUR0QrZWZmRG5jU3RvcUxGRFlvYzRu?=
 =?utf-8?B?SE1QRUMwRFlvSXVQQllPM2NuZHpBRDRnOXQ0ODBQbVFNdmFhR3FTVHhYZHVo?=
 =?utf-8?B?U2VFWDlzMnhoV3hqY2E0aVd6SzNTb051V2JTd0RrSEtIYXVPREJ3blZ3YU1z?=
 =?utf-8?B?UHBPUUkzSFFaNWx5NlZGbmc2VjJLQkFVanlXc3BldVNVZHNyZXVHbTlDbVQ3?=
 =?utf-8?B?SVZhWTJGazMvOGNIbjhTUmp1cWFuOHZpTFR4S0p1K3d0Y2Z6Q3FJaWJGdnF6?=
 =?utf-8?B?V3kvdm5iRkpxeHdDcE5KZjVSaHhFTHdvRjdNMEFYZVJJTjVCTlg4L2RxR3ZK?=
 =?utf-8?B?dzAzU2pXaU02cUNyVlpPZ1R5OGZxMm1oSWtzNGxMaXFZV1dWRVBFQVdkZkM5?=
 =?utf-8?B?cm1qcnB6Z3FNdy84VTVwbGRwL1NCT1hOQ2JDV2FRemxYTlZRTzV4MVJLYjFI?=
 =?utf-8?B?ZmU3UDlQamFqMXo3TjMrWUtYU09GcFJzQlo0VGtWQnBKc3AvYWpUUFAwWkZy?=
 =?utf-8?B?REd0RDQzZ2lkdTB6MXNrYkZTamNwMVN5czNyL092VTh5Q0hsSzNTRDBQL0U0?=
 =?utf-8?B?dUFNTXlJUDF6WkhOZjloZUJzbXV0R2R3cFRtZzg2eG9wZkRQbDNuc24zc2o2?=
 =?utf-8?B?b29IanlVb3BQNVNhb1JQUzRmVjhZRGZTWlBUS0pxN2I1OCtwUnJNTW45UlRn?=
 =?utf-8?B?dUJDb0JEZEgydHRsbnNXTXBvbkxMMDNCZ1dZMXNVQ2FabENEZnBxalk2S3dE?=
 =?utf-8?B?Rkc3ZU45VThjWTcxTWdFaHR0LzRmWWdzOS8zZTYvYjYzeFQ1NFFMSjE0ak1n?=
 =?utf-8?B?NzA4VGk3YXliT1NoZVY5T01URWlPUTJSNFUreGREZFUvbzNRaUM3VUZPblJO?=
 =?utf-8?B?eFF1YTNLYTkrY213clF4WnpHeTYyOEx6WnYwVmYyQUgwcElieW9DdU5MVlli?=
 =?utf-8?B?NjFWaWFqanl1eG9lSXhoT1JkZ2N1VGZGcndtK0RYWGpMb2NXUUdkR3YyQklE?=
 =?utf-8?B?YjZIV1c3dHdveFB3Q1ZKaitIYldaTVNzbDJ5alpIaVJ5SzZYOGJtS09vZGdu?=
 =?utf-8?B?ZUlSenZNYXJSUjlwbTdyTDlIampkeVBDV3hPNS9pYXpaUTVkcHFtRnh2N1RF?=
 =?utf-8?B?cmllVVcxeU5QSFFZeXU5Ulg5TW5hWi9vYWNBRjdoTCt6QytjelM4SWxIRGlP?=
 =?utf-8?B?bWt4dDQxQTJndFljdDV5dWh4N1JkeFcyVlpnWnNXKzExRjhnbnV3MmRTWDNQ?=
 =?utf-8?B?VVNBd2cvS200bHpJbU82blZaZXlCeWtzR1pYaUhsLy9kOWtBc2RoRDNTTXo0?=
 =?utf-8?B?UWMvWFBvOURvOEFkc1gxSTcra3Z2ZGhMQTAwKzRnYW4vcFFRN0JHT0Q5Y05F?=
 =?utf-8?B?Y2poVkE3Qkd1RVV4TndXMG9Xd3kwaGtPeVAyczJ3SmU1OGhtdGJ0RjF6ekw5?=
 =?utf-8?B?ZHJIVUFGRWx3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1ljTlRwMlpSanUwcFdNVHkzUFkybnBTV2xRbWR5dDBGNUQ3Q0dEMENUWG9H?=
 =?utf-8?B?MG5vWTJreDIzbzdmN1lOOWpJM2Z2b1BoeGxwOWNTOGZVQWsyci9zeVdHbHNT?=
 =?utf-8?B?YnN2MUFpdWNTcUVKdiswNjJTb0txL2hxTkVKUkRXelFPMW1FczQvUWJRWXNu?=
 =?utf-8?B?NUI4TUo2TzJITEFTV3pTNGthSExaaEN0d0RZSTExSXBHeXBJTGF2ODRCQmU0?=
 =?utf-8?B?dlBDY1ArUzk4dnkzclk1V1c2WEJoTXBLYmV5QUpRWmlGWFhLd2QwRFZZaUlE?=
 =?utf-8?B?enI0d1pTNklpcDFCMk1yK0FwVzgrejkzZC9hOVVyS0JKSVh2Yi9lVTRJZ1dy?=
 =?utf-8?B?QW1oTVJpYms0TGNlb1NQTWJFU2M2S0VUUnhUMy82dDJWSUdwS2hndVQwYWNi?=
 =?utf-8?B?TEYzQzVzakdpQmszamp1TXRweXJPMjl2alpEQ0NUai80RFkzMmJTM0JXYTNp?=
 =?utf-8?B?eDVwRTZHNG0vcmR1ak9NemdhNk5oVWRQKzRBVUZnY1NqbjJMZlRNMGtYZEk5?=
 =?utf-8?B?VVNPNHl3YUxNV2V0YU5PeGxNQjFiUjlCSGZRUWNLaVltVGZUOGFFbTUvbCtF?=
 =?utf-8?B?SEZBVHF4YXVtWlkzQW0vVWJHK0JOVGJaVDNqb2RwdEFNWWxlUGY5OTdYdTcy?=
 =?utf-8?B?V1hXMXdpdDJmSXNJaHlvV2xLZEd0YVVpZXJpODFUaHJNTzR6Z3pRaCtqTkJM?=
 =?utf-8?B?TDBiS0RZQWpEUmcxbGJWUTJFaktNWnFPTU5tWlpxKys3bjlYMUx0U1dKODBC?=
 =?utf-8?B?ZTRFR1ZwM1RKYnZJS3EwZXFoR0pKUlMwVGp4S2hoVHFnZVBOWE1rSmU2ZlBx?=
 =?utf-8?B?cGdmbHMvK1F0OEhYRHZnelU4eE5haVlQb0lnUlV1Q1ZZSTNDZndPcEFVOEJq?=
 =?utf-8?B?cmx6cVpnWkEzMWszWDNUSlRaSnBHVCt2MEpFK0NsYVhjZU1qUTY4R1poS1lx?=
 =?utf-8?B?QXAvYnJVZ3V3dk5YUFAyZWM1allzTWZRaTk1aEtESnNpVUdtTm5CWXlZLy9z?=
 =?utf-8?B?Z1hTVVRWNXlOVzZGQk9hL1pnbUc2amY4ZGZ2YVVjZjFoa1YybXFLcDZKU2NQ?=
 =?utf-8?B?UG1zZHlOSkFUcDU2S2cyS1lScmNVUEFhNjJjbTAwNmRCMDVSdWQ2cy9ERUY2?=
 =?utf-8?B?OHBpbUJiUGQwUHRPN2loUXdYNEFDTFNHdFR1ZXpTaENyV0lobWlId0lVcDl2?=
 =?utf-8?B?OFNWYXJmRURzcFlGSzNQWmY4Q0xGdXc3N0tJYXJPcnVkTVZGeHFwak54RllM?=
 =?utf-8?B?MmZpMEpYR0ZzOGRiek16Smo5ZWkrSHIxaUJmZ2NudXNlam42MGh5MUh5OUZY?=
 =?utf-8?B?ZFg3MS8vWGxjblhzTDdlc09OR2RYMk5BYUJnWlorbnRCM0g3V2N4cmU4SlV1?=
 =?utf-8?B?VTR2TmtoMmx0Ukx3RXRxcTloVXlON3Zha0lHRDNCb1FYWFNHd0hJeDU3b0hl?=
 =?utf-8?B?SkpXalhDYlRjYmR4N2ZKR0J1N2tpVFpTQU4vc09aRDl5S0NIUktTTmlHd2pP?=
 =?utf-8?B?NmlHdHBPSWNYbHM2MEZNNlRrRVMrZm9hbFlQSmxVbDl5VENvUmErb0Y2YTVk?=
 =?utf-8?B?VTRrdlhvREJ2ZjZqL1hFZy9YMlUyY2pKOVlZR1N3dFl4aVdtZXNESnlyZzJ3?=
 =?utf-8?B?WlFDK0VlQ0k1aFpxS1pBVTZTZWlVZ0NMWGZCSGppeXZVajI1WFJ1cGlKc09O?=
 =?utf-8?B?ZGdnTnMxZHVaTVVlaENCOE85ME5tWmFsWTNDVUE1VElycVBtUjVnQ1AwTVFQ?=
 =?utf-8?B?QzB0R000WVBoWGl3QkFLUlVtbFN6c3dVdkV1SzdFenYwNjh2ODhZblpCTzBJ?=
 =?utf-8?B?RTZ3WmtxZXhBazl6cEx3UDBrUUZGaGtCQWd4YTJVMTFtWjJPRVZkL1JDRU04?=
 =?utf-8?B?d3Rtd1BzK3djc3c2eXVHa05raXBwSEVXQSs2K1dyZTdTaGpXTUd6bWJOZ3ha?=
 =?utf-8?B?ZE9oQ3VXOWFWenZHcXpBNGZhUGFUMTZFb0dRcFVwanBCb00vMFdWTm5jeCs0?=
 =?utf-8?B?YWpjYTd2Zm4xS1Z1Q3pOV0xwdGJIOWZCUFd2ZmQ1TGo2SmF1bHdnQUd0ZlNq?=
 =?utf-8?B?QnVDWFJubTVrdW94WGdFTFNISExZQ2R4dXd1R01VbTE3REZBalNSSnN1YzJt?=
 =?utf-8?Q?FLGn+2aQcAKnx+Zz7yygy9bpa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46863d67-68d0-4635-4dbf-08ddfd0e3be9
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 15:06:13.4248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+tyGBMiHkw8cSmBK/8SujR0U0bLrzByOMo/VjYEs+VmaRl/5F4/AiAYP+/rLI3rOa2mRArgUtVj/3O3GP7Hwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8960

Add SOC special compatible string, remove fallback snps,dwc3 to let flatten
dwc3-layerscape driver to be probed and enable dma-coherence for usb node
since commit add layerscape dwc3 support, which set correct gsbustcfg0
value.

Add iommus property to run at old uboot, which use fixup add iommus by
check compatible string snsp,dwc3 compatible string.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v3
- none
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 3 ++-
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 8 ++++++--
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 9 ++++++---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 9 ++++++---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 8 ++++++--
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 8 ++++++--
 6 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index fc3e138077b86cd5e3cf95c3d336cb3c6e1c45ef..ef80bf6a604f475c670e2d626a727e94fcb2a17a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -493,10 +493,11 @@ QORIQ_CLK_PLL_DIV(4)>,
 		};
 
 		usb0: usb@2f00000 {
-			compatible = "snps,dwc3";
+			compatible = "fsl,ls1012a-dwc3", "fsl,ls1028a-dwc3";
 			reg = <0x0 0x2f00000 0x0 0x10000>;
 			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
+			dma-coherent;
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 7d172d7e5737c4b6e42ee88676c5763fa7415260..e7f9c9319319a69d8c70d1e26446b899c3599f95 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -613,9 +613,11 @@ gpio3: gpio@2320000 {
 		};
 
 		usb0: usb@3100000 {
-			compatible = "fsl,ls1028a-dwc3", "snps,dwc3";
+			compatible = "fsl,ls1028a-dwc3";
 			reg = <0x0 0x3100000 0x0 0x10000>;
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			iommus = <&smmu 1>;
+			dma-coherent;
 			snps,dis_rxdet_inp3_quirk;
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
@@ -623,9 +625,11 @@ usb0: usb@3100000 {
 		};
 
 		usb1: usb@3110000 {
-			compatible = "fsl,ls1028a-dwc3", "snps,dwc3";
+			compatible = "fsl,ls1028a-dwc3";
 			reg = <0x0 0x3110000 0x0 0x10000>;
 			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+			iommus = <&smmu 2>;
+			dma-coherent;
 			snps,dis_rxdet_inp3_quirk;
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 73315c51703943d9ee5e1aa300c388ff6482423f..50d9b03a284a2aa4e13aa3323c25bbc5fe08f3d0 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -833,10 +833,11 @@ aux_bus: bus {
 			dma-ranges = <0x0 0x0 0x0 0x0 0x100 0x00000000>;
 
 			usb0: usb@2f00000 {
-				compatible = "snps,dwc3";
+				compatible = "fsl,ls1043a-dwc3", "fsl,ls1028a-dwc3";
 				reg = <0x0 0x2f00000 0x0 0x10000>;
 				interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 				dr_mode = "host";
+				dma-coherent;
 				snps,quirk-frame-length-adjustment = <0x20>;
 				snps,dis_rxdet_inp3_quirk;
 				usb3-lpm-capable;
@@ -845,10 +846,11 @@ usb0: usb@2f00000 {
 			};
 
 			usb1: usb@3000000 {
-				compatible = "snps,dwc3";
+				compatible = "fsl,ls1043a-dwc3", "fsl,ls1028a-dwc3";
 				reg = <0x0 0x3000000 0x0 0x10000>;
 				interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 				dr_mode = "host";
+				dma-coherent;
 				snps,quirk-frame-length-adjustment = <0x20>;
 				snps,dis_rxdet_inp3_quirk;
 				usb3-lpm-capable;
@@ -857,10 +859,11 @@ usb1: usb@3000000 {
 			};
 
 			usb2: usb@3100000 {
-				compatible = "snps,dwc3";
+				compatible = "fsl,ls1043a-dwc3", "fsl,ls1028a-dwc3";
 				reg = <0x0 0x3100000 0x0 0x10000>;
 				interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 				dr_mode = "host";
+				dma-coherent;
 				snps,quirk-frame-length-adjustment = <0x20>;
 				snps,dis_rxdet_inp3_quirk;
 				usb3-lpm-capable;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 770d91ef0310d971d044a1f55cc5e2cb738acc47..22173d69713d1bd2abca986e76668ad437dd34e4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -749,10 +749,11 @@ aux_bus: bus {
 			dma-ranges = <0x0 0x0 0x0 0x0 0x100 0x00000000>;
 
 			usb0: usb@2f00000 {
-				compatible = "snps,dwc3";
+				compatible = "fsl,ls1046a-dwc3", "fsl,ls1028a-dwc3";
 				reg = <0x0 0x2f00000 0x0 0x10000>;
 				interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 				dr_mode = "host";
+				dma-coherent;
 				snps,quirk-frame-length-adjustment = <0x20>;
 				snps,dis_rxdet_inp3_quirk;
 				snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
@@ -760,10 +761,11 @@ usb0: usb@2f00000 {
 			};
 
 			usb1: usb@3000000 {
-				compatible = "snps,dwc3";
+				compatible = "fsl,ls1046a-dwc3", "fsl,ls1028a-dwc3";
 				reg = <0x0 0x3000000 0x0 0x10000>;
 				interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 				dr_mode = "host";
+				dma-coherent;
 				snps,quirk-frame-length-adjustment = <0x20>;
 				snps,dis_rxdet_inp3_quirk;
 				snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
@@ -771,10 +773,11 @@ usb1: usb@3000000 {
 			};
 
 			usb2: usb@3100000 {
-				compatible = "snps,dwc3";
+				compatible = "fsl,ls1046a-dwc3", "fsl,ls1028a-dwc3";
 				reg = <0x0 0x3100000 0x0 0x10000>;
 				interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 				dr_mode = "host";
+				dma-coherent;
 				snps,quirk-frame-length-adjustment = <0x20>;
 				snps,dis_rxdet_inp3_quirk;
 				snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 9d5726378aa015eff10578bf095908a58b9d9eee..b2f6cd237be046123de9342e2167aa32248a8a16 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -489,10 +489,12 @@ esdhc: mmc@2140000 {
 		};
 
 		usb0: usb@3100000 {
-			compatible = "snps,dwc3";
+			compatible = "fsl,ls1088a-dwc3", "fsl,ls1028a-dwc3";
 			reg = <0x0 0x3100000 0x0 0x10000>;
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
+			iommus = <&smmu 1>;
+			dma-coherent;
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
@@ -500,10 +502,12 @@ usb0: usb@3100000 {
 		};
 
 		usb1: usb@3110000 {
-			compatible = "snps,dwc3";
+			compatible = "fsl,ls1088a-dwc3", "fsl,ls1028a-dwc3";
 			reg = <0x0 0x3110000 0x0 0x10000>;
 			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
+			iommus = <&smmu 2>;
+			dma-coherent;
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index c9541403bcd8239a48d4ef79c7c4f9e3b607b556..d899c0355e51dd457a4e7259709cea98a488f557 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1094,24 +1094,28 @@ ftm_alarm0: rtc@2800000 {
 		};
 
 		usb0: usb@3100000 {
-			compatible = "snps,dwc3";
+			compatible = "fsl,lx2160a-dwc3", "fsl,ls1028a-dwc3";
 			reg = <0x0 0x3100000 0x0 0x10000>;
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			usb3-lpm-capable;
+			iommus = <&smmu 1>;
+			dma-coherent;
 			snps,dis_rxdet_inp3_quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 			status = "disabled";
 		};
 
 		usb1: usb@3110000 {
-			compatible = "snps,dwc3";
+			compatible = "fsl,lx2160a-dwc3", "fsl,ls1028a-dwc3";
 			reg = <0x0 0x3110000 0x0 0x10000>;
 			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			usb3-lpm-capable;
+			iommus = <&smmu 2>;
+			dma-coherent;
 			snps,dis_rxdet_inp3_quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 			status = "disabled";

-- 
2.34.1


