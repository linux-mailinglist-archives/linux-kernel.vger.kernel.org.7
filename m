Return-Path: <linux-kernel+bounces-885527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30739C333B6
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 23:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1531F3A8254
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 22:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4EA303CAF;
	Tue,  4 Nov 2025 22:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bj5BARdk"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011040.outbound.protection.outlook.com [52.101.70.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C4F2AE89;
	Tue,  4 Nov 2025 22:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295256; cv=fail; b=KjFviQwJWL7r/Y25PvqD8pELsE7PbeAfw+LvQmDOOlmPmNsnnDv0SASlF3tiYryIMvD54ZUYpiqcVPGv5Ek5zkUwPdAcvL+s6v5jZ+HXacXsl3CB9DOYBpgq8c9kcH94mxlHUDZSEU5QQnJA32/t7LmKq+dC2NTOxsdhvV3EBSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295256; c=relaxed/simple;
	bh=NXlx15kFsm/J131upYZNDfC13rTNECLbdacclQ9y8UE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=tTx1zY+ellqP+tV2jS6yHuBoDfmAA7tl3h1TW36HL6m3Ulij4UVBjzX8OcaFStmTPxFwTzukEfrgVnYHQyDmpfBxzK7Wf65PDdEjV4fX1w84lzNpO+wNseuG/g9XqRIseJlmx+9UXQyNM/Kxs6c45dxuCgTnar+eNC+LPmCscHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bj5BARdk; arc=fail smtp.client-ip=52.101.70.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ybYa9MUuBtAS1zLOoQZ806PaZCJN6OBoc8t3JgY/Y934y3/JKAwRammRtL2HCuXBFcrvQAvVyFtRgdqfmPf805eo6NneM5IJ9mrXeKeZXl1ChfeS/SNMnlTj+bcOjLAvGIuQtHEbxFHU24jBMxOL1vfhGlwN5bmXFeILKuLjEnRVr6a6nEd3S7qgcRolQeYgVXg66l0gm0BXfmDd8Vj8Af3htAAVuox4kmZ/45sJn2+7B66w4EP7xvHRl/l0SWt+cCmt9g4GD5QDUw/859nrkueaVBlmDXco/npoJ9kFqkGfa6wf46mw9XbKOQ0pnNC+I+r7ke7haSdUgsohxm3gsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nszrk6h1byveC7pSSpIso3dhKBuElyqCg7byA9qxbU=;
 b=zOHdmyxegw+yf6EeRbTsfFvbal3nFEHgJPdF7jYcH5JVJnfCa+n+2kwdwzJM1E0vYtXxHsKsSEUJPg9jTPlmTPUjbvFJQm4zGOzHi490aQWn6pcwYAhLV7YT8PffexqCuHxAONP4A+I/5ndM8eR5e1STB2tiVXFc8v4AJXHL/gMjOrilIAenbBLzYNMNqsALOPniHScsmwvYjXxFdnvXdX05TQ07hme2ZX3DJVsgya4o1Ku3ge7ZC+49v98qgFlUCltshZpyMnJlPmkOtiqLsTAgDIZRAZa7kTWdK4lDnEVscgeS5oCK6j8CTV3Fs8BfjGVIwS85EjZp2oLaB1MYdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nszrk6h1byveC7pSSpIso3dhKBuElyqCg7byA9qxbU=;
 b=Bj5BARdkpstGWLebH7dcL7dhTyg+NGRQRGeN5N3z+PZednDBIpX2tojwDnB1VMuat0mW4UMHa7HId3lsmLpm5wrzx1PdeGK3eyjsXLgsF7pjgIOY5TNMmhHz89192v5Be52Sy0Ne8A/i9Tj4IHIRcHvV6By0Lw2Pg0yZ1Jd5S8TnWmMhEOj99NMwWQsiCgE6HFS+qpdotNmwDZBhEIiA23uBZGEPD3EAWcsu9IodD7V+Gg5nhAygT+taW7nzUiI4nJjPJfXPTROm3HJJdERkL0zJnaRhiPRFpZcRQ1rjBhVonPTHUhKO6H78t3wjfcxiZzDLJ8u455Yc3twhIgKdTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DBAPR04MB7286.eurprd04.prod.outlook.com (2603:10a6:10:1aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 22:27:30 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 22:27:30 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/3] ARM: dts: imx: cleanup most gpmi related CHECK_DTB
 warning
Date: Tue, 04 Nov 2025 17:27:11 -0500
Message-Id: <20251104-gpmi_dts-v1-0-886865393d0f@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL99CmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQwMT3fSC3Mz4lJJiXTPzNAPztCQjAxPDZCWg8oKi1LTMCrBR0bG1tQC
 p3jLUWgAAAA==
X-Change-ID: 20251104-gpmi_dts-67f07fb2041c
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762295246; l=2400;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=NXlx15kFsm/J131upYZNDfC13rTNECLbdacclQ9y8UE=;
 b=vqWbRBFqKHLP7F1lAF8iHCPqhAGzN203wXdTpJVFqt9mufRG2CSzWTxjQ34vjFJMiGa1bEERW
 PZtgCvijuytCVWVfUuvgRX1JMUdGORSpSGt3vKlFu+ySh2xtgvIXYv6
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR20CA0033.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::46) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DBAPR04MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: 525a7b40-f640-4f1b-5aa4-08de1bf15722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXp2OW1leWNkWTB3T0dHMjRtTlgxaTRoMDh5NFNGQ1Z4R09CRXUvTDhBZVEv?=
 =?utf-8?B?UHNERlNPc1k3VHpZeXMzTjA2V1U2Rkx4dkZvR0VUbGJEUHVNUk13eGdVcnlq?=
 =?utf-8?B?VmNIclh1Y3Z0VHNwV1ZBeS9LMERGUVF0dnJkWnZoMDZWQ3c5MXhvRCtlTStu?=
 =?utf-8?B?KzNyK1BHd0tVYS9HaDJDRzBNd3huUzZ0TTN0dGxENk0xREduSGVNWEVnWSs5?=
 =?utf-8?B?a3BsWDB6blJZMmpNSjluNkVXT1AybWlRNUQreks5RzFGTENoZTBsTkZGRWpl?=
 =?utf-8?B?UXJDSWRXQytTaktRTk5VZ1BGNE1hdUUxZnNBcnhWWEk1SEhBalJBSUZxYXRn?=
 =?utf-8?B?L1NHbFc3djh1Mkl5QnJTQlhaNkFnM3cxL3Q0T1Q1aXZjTEhzTXdMQnhpWVQw?=
 =?utf-8?B?OUdGK3IwREpHWDdMQk5leW5lVDNZTFBiOXpBNm9ud2RONVB6d1FpeGxReEcw?=
 =?utf-8?B?TWFPdHozVjFYazhRK1QyN3lyd3I3UGVKdDRHakdCb0diK0VPOWo3ZzJyU2tY?=
 =?utf-8?B?MEgvRy9nMjRtVGRvUm1CNHcwZXAwMEErT1JXY3BPbmlUVTdIVHlNcEJOMWxB?=
 =?utf-8?B?THF0eStBSkhwYmdRdEhPVUtKcUNhNDlBN0RGd21raXpBaFMvWGNrOUhCYWlU?=
 =?utf-8?B?RlV6UlpIUTkxMHFiSUFTYjVXVTAxV3IvQTM2eVJmem9VaWh6Wks3VkxqWjlw?=
 =?utf-8?B?aStTQ0dsNktxQk8vMWZBSm84SWo2Vk1xV0F1cUVORnJZaU1yRTNjeWlkN1Z2?=
 =?utf-8?B?eFc5c1grSTR0QlErbnd1WktWVTFmeENQazlkSnBFbkQ4ckx1RTBENkxpVFUw?=
 =?utf-8?B?dGp1NjZTcmF6RkZBNTAvNzNhSVFwYW9ZWXpXSnNyS1BTKzJnK1JkTktMQzE3?=
 =?utf-8?B?UEg3ZjJ2VmV2WWpXaVhPaktzSkdGWVVTQ1BUNGhtc3RvQU10YThZb1BKb0Jq?=
 =?utf-8?B?dDBndzl2WnJ2b09YOVdyNHM0NzhheXJ2KzZ1bEtTKy9OclNiS2lsYXo4dEVV?=
 =?utf-8?B?YzdiZkJhalpybGJYOXAvK056QmxzUVlqbnpyeWJ0U216MDFXTTlMVUVaVks5?=
 =?utf-8?B?WjMxUTVzZTFOeTVWTHEzTEptb2ZnY0ROUG9aZXA2TGdadmJIcGsyNXBMYUc0?=
 =?utf-8?B?R3NnK2xsY1dGMVhlL0NCeWVWTjV6ZFpyTW9uWnkxVWF4OUxpMzhKaVNlWVVU?=
 =?utf-8?B?azFGdVFwU1RjYWxDakJhMFBQZjVRbHhCVnppbldZdkhDY1JLMGJKZHJOWUp3?=
 =?utf-8?B?QVZtWUVlekQ1ZldZc2NHcHFheXVjWVhvSXZIcndML2tMVVJxK2FxVWhaZ0Fv?=
 =?utf-8?B?Z0dXVnFDUDBDVitQY0t6b241NGRqSm8vVGVzRnNVc2lnNkljazVIWmtDL2ox?=
 =?utf-8?B?aDI2L3I1RlJHbkIvaFllZXdYZ041UXJZa2JOaUhvWmp5MjUrTmI5SFEzM0xu?=
 =?utf-8?B?M3dIUTJPcHVwSXlETnNLSEdxOVM1dFhlYUw5Y2R5ZFQ1OEcxVVhUUy9GU2Zs?=
 =?utf-8?B?VmtBS0RnSzlqNTIwQUozbEJ5blRZTFZKaVI0VzlHVDhmSFUyaVRKOVB2dmpw?=
 =?utf-8?B?Nm9uRUpQckFmNktvT0hTcXkrdkRrU0xFelNnN1hyWjFxOWFVdlc2eElxT0Iv?=
 =?utf-8?B?SEQxRkorNU1HNUNUaFpKcURYWGl2NTlCY1lxYyt4RjJ0akdGd0hHV2lFY2Vx?=
 =?utf-8?B?aW9iNXdsQWI5MTdxN21WdEd2aWQvYnpuZXIyVlBiN3Z2YXh6Z2c5UUhGMURx?=
 =?utf-8?B?Y2s1b2VqWlB2WmJsL25WVks3ZEp6bGIvbE5uMHYzMy9wNjRvQ0xKL2lIeHFu?=
 =?utf-8?B?VG5UVjFKSzBJbXNycUlPbkxnTnRJdDh2dGJwM3VtVy8weDJqQUlSamh1T04y?=
 =?utf-8?B?Qzk2TDR2WER0MzhQdmlXbWFBOFQzemt5eHkrSUg0Sm9mMkMxTm15d1RMSTh4?=
 =?utf-8?B?ektDV0hqSnAvbmxHT0dxV3YvTGJUcXlENnJ3WUt0YXFxZHo1aHJPdzNDU1NE?=
 =?utf-8?Q?gHDpijY98W0IIvcDsq7JZOkvQXT3vI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3F5MVBwNlB3TWxpWDdrWVNDbGdPV3NuanNQZTErTUJVSXExcytFVTNDU21X?=
 =?utf-8?B?cFZ2OVRpWjJjYi84ZThVMVJsN0FGS2Y4ZmNqY0dnbTJJQ0xIZEIzdHNqRFht?=
 =?utf-8?B?aUs5ODJYRFhUdUxqMW5iSmtqdEMvVE1TVGV6N1d5TmNZTDZCUmIzOHd6dWtQ?=
 =?utf-8?B?YUZDa3JhU3ZsQzE2WFM3VW5jbGpKLzBPWldZNHpaaStyd1VWVjlpTUpqY1E5?=
 =?utf-8?B?aWt6UTQ5Q1lYUUplaWlMc1FsU2RycXRTdVR2Vm5OYktQOUhTS3VXaU1FV2hw?=
 =?utf-8?B?SGRWcVE3QTZKaVFQU2xlbEJ1SGIrb05ka3UxV3pYTVlUVEdPUDBEeEdFTHJx?=
 =?utf-8?B?dCtUNnZXNVNOcE9wL24rMVVYWmlIRC9PaHN3NWVhT0Nyak4wYmw4WTl0V1ZX?=
 =?utf-8?B?LzNvSUNsRVFkcVQxZEdXOEloMlcyNjlDbHdXUVhsZ1RqTm1GMWNhNVBOL3Zv?=
 =?utf-8?B?WE9JMy93Qm9pZHlxN2d6b0JOa3U5dml0a1ZuTWFTWFNjTWtjMmdRQUo5bDlW?=
 =?utf-8?B?MkdPQWVxcnNqTERhclpzRVVmUVRvRnJKRVJPdTdERGFvZVhFRmloZWxHeFND?=
 =?utf-8?B?eXI1Wm5TcXk5eXNTa1IrMGZqQ0IzQzkyazUyT0t4R205TlFKMzZSbDRTelJx?=
 =?utf-8?B?L0VydEVQRFZjNWdWQkRNUktRWk1jd0w4TXhHK1M3QnpJWkxXcEd3dGFlbjJ6?=
 =?utf-8?B?SlljVWhJSm5ROFNBZUk0eHh3TXpQSVNvYkV2WmpnR3h3RzRIcGtacTNFR0Jl?=
 =?utf-8?B?YUF4NGFEelc0YWdmUHUzdWQ5NTh6Sy9xZ09XTGJneDJxUDVuN09kWElRbTda?=
 =?utf-8?B?aThVZWVPY1VpaHBBMGQzZUIxdSs3bVlFSDIvR2NEaThrYmF1c3VVUmpWNkpR?=
 =?utf-8?B?MDdYcjFOYzkvUjg0bGJDb1prNTNkZFhZTGpPOFFLUlZKY1dDU3NlQk1PRHB0?=
 =?utf-8?B?d3VMUjh2Y0psUVZ0cHBoaUVkTHFESHFvSlpuWlFkTHdnZGNOTWZIRFlmUkRJ?=
 =?utf-8?B?YURyU2FTdGs2TjVWNG45bm14bE9OdWdXN0tWSTY1WmNBYmJWN1I4VXlvbGcz?=
 =?utf-8?B?aFA0SnVLbEkxRjU2RndiNjZkLzl5Wm1McVJDNmJ6WnF0V29tR01TdVR5Zkty?=
 =?utf-8?B?OVJ4c1hMMHd2Ry9DVGxsTFB3M3JJU2FTWlJMODNndUxzUlJaaTNXVEREMG92?=
 =?utf-8?B?SDd0Qld3MjhUWXZsWHZXRGR4bXl4MHRyTXp1SGZGZTVuSWhrZmJrUDJPYStl?=
 =?utf-8?B?c2paOWFjbUVocjNOMTE2NlRjaWRsVG5sRUVTazdMZklZSGcwUG53NkFJa2pm?=
 =?utf-8?B?dmhhY3VNS05vVHd2bS9idnNEL2JKTElWUk51b1NQLy8zYjF3dEVjMTNnNjZU?=
 =?utf-8?B?OUdKMTVUdTlCbFErNFlxMUxMV2xZVnlLT2ZVZWpFTUtTVlUrMGN0cGtYN2hL?=
 =?utf-8?B?UkJnQ3lsLys0ek9VSWNIMDBVQ05mNUx3dU5teDQzdlRqc1VLQkdXbHJxSkxM?=
 =?utf-8?B?R0JvU0xWUldXOTYxb1BRNDFPeWtjRld0aXZRQk0wekZJcXovR0FtNGEycVRs?=
 =?utf-8?B?ZWdUT3Zjb1YzV1Q3ZXRmN2U3YzhZR09VK0tQTzNwanlmbHRaRmRzVW93Smpl?=
 =?utf-8?B?RU1KQU5Cb2p4TTVkc2NldjZLMUxHcGxYOHByZksyV053dlhpVlRSYVR0ajFE?=
 =?utf-8?B?eU9VKzN0dXpLVkpEMDI4Y1RDRlJoS2lzWm9Ud3lXYkpUVFRSczVSUm9LcUtX?=
 =?utf-8?B?ZjJyczdtK1VCTWVBRkxFeXdhN0lIcjBUNE03VFl5TkRHR2gycUZwbElVRHNF?=
 =?utf-8?B?MmlWNXhDbHNFbUFEdnNaKzFOQXJINGYxSE5laFIzV3Vvdi9LaytlTFVETnRG?=
 =?utf-8?B?L2pRWmJPSGg3dS9sbmdkUzJnR0c0cXg1elZCc3F1TkVoQ1JzU1N5UFppYzhq?=
 =?utf-8?B?anI2V25QSWhMQzZUWkRsVTIzSDRKKytBc1BJV0R4b1A4NVJYVUhPZ0xqT2pC?=
 =?utf-8?B?alNZZ0RiU25ZMUFZVTJsdU1ERjR2MFhJaEJPUFBYWUdkeWVsMmVURVFHdnRl?=
 =?utf-8?B?UlpoU3c2M3IzbWgyQ2NJeTlSWnRrdE1pc0ZxZGxBU3RjU1h5LytITlh2R210?=
 =?utf-8?Q?2di33IgtmtkFCmr0zfCIN9p2v?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 525a7b40-f640-4f1b-5aa4-08de1bf15722
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 22:27:29.9525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRednwP8HGMALY9MI2Y8LYqC9W8TOgWlkFo8XYmfEXFdNsT8EZaycPTtDtBcnDHYdZLVgVtbS/iD9wzyrG/7WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7286

Only few warning left because original data is wrong
arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-bmm.dtb: nand-controller@1806000 (fsl,imx6q-gpmi-nand): nand@0:nand-ecc-step-size: 0 is less than the minimum of 1

driver will leave default value when these value is 0, but binding require
start from 1.

Since 2019 year, commit
        (212e496935929 dt-bindings: mtd: Add YAML schemas for the generic NAND options)
        NAND related property is preferred located under nand@<n> even though only
        one NAND chip supported.

NAND related property should be located under nand@0. This format already
support quite long time, so it should be safe to switch to modern format.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (3):
      ARM: dts: imx6qdl: add '#address-cells' and '#size-cells' for gpmi-nand
      ARM: dts: imx6sx: update gpmi #size-cells to 0
      ARM: dts: imx: move nand related property under nand@0

 arch/arm/boot/dts/nxp/imx/imx6-logicpd-som.dtsi           |  6 +++++-
 arch/arm/boot/dts/nxp/imx/imx6qdl-icore.dtsi              |  6 +++++-
 arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-pfla02.dtsi      |  6 +++++-
 arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-phycore-som.dtsi |  6 +++++-
 arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi           |  6 +++++-
 arch/arm/boot/dts/nxp/imx/imx6qdl-tx6.dtsi                |  6 +++++-
 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi                    |  2 ++
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi                     |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts                 |  6 +++++-
 arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi               |  6 +++++-
 arch/arm/boot/dts/nxp/imx/imx6ul-phytec-phycore-som.dtsi  |  6 +++++-
 arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi               |  6 +++++-
 arch/arm/boot/dts/nxp/imx/imx6ull-colibri.dtsi            | 12 ++++++++----
 arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea.dtsi   | 12 ++++++++----
 arch/arm/boot/dts/nxp/imx/imx6ull-myir-mys-6ulx.dtsi      |  6 +++++-
 arch/arm/boot/dts/nxp/imx/imx6ulz-bsh-smm-m2.dts          |  6 +++++-
 arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi               |  8 ++++++--
 17 files changed, 85 insertions(+), 23 deletions(-)
---
base-commit: f8a6148698538647188a0f801f686ff90035a8ca
change-id: 20251104-gpmi_dts-67f07fb2041c

Best regards,
--
Frank Li <Frank.Li@nxp.com>


