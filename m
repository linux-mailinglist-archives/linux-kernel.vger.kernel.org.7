Return-Path: <linux-kernel+bounces-774475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DC1B2B2D2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D77F1628542
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327ED2737F9;
	Mon, 18 Aug 2025 20:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g34EZ4kq"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013027.outbound.protection.outlook.com [40.107.159.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74349224AED;
	Mon, 18 Aug 2025 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550117; cv=fail; b=V0Er1+UQxfA5w4jCpa+0UHLjLAImKsalGsaQc54D5YNzpebDrGdmbfcd4w7jkF1WARvS1sJK6eYtFfiDPUrTdMtLB/N57F/9ueqO3BSv88U1/9zxaYaIaFCmRtpxeZGneraLtXAYg5c41K6tD7ErsxacVWb1ARJg+FsDesn5NPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550117; c=relaxed/simple;
	bh=0yrEpaHHmXEwPCp8YGKQlagzzCd/v6AHSUpR31ihWfw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=U/Lv/LCKGo93nwkuZ0ua4oKTYjxnOb3pnmYvShO5cLXw5hXs3vUWFPhA789jc8urknTGYbqbolbp1uT60toVTyNHRiNPpMsdvKHkENBG/EnGi+AKCIVSxS5fVCeNyi4MB8ZEx/PjFeAp02wO6/GU5tzbvW3s0Y9lI7vbjyG+968=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g34EZ4kq; arc=fail smtp.client-ip=40.107.159.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vX5jY/0L459fRj0kTCKdLI1Pc4XwSmOAnForRJIKNGAbUXqHgBOJVm4hFoVnZEnCnbJztq0nAQE1Y3Wn0zdI4hIykG76Xgs1wFm45wjZXBM1Mr8hfL/w8t2cCfulqOadrES1Tq1XonG1B6qXmSdlLu7uz7cRzUTqRtNeCeLoSssXFPorTx472S0GELnd0JFgivXUwY2wjvDmr6WQd9QiyJKGL689a9bVKOLr29JsNHySzUsYf6RWyBP39VFHpaHCBrE4Uoz/keSoBPz7eMKYF/B4jgA8wY2nwr70bahvkbwyM15UoE0V8LwInj5a6sv6zCCX4UBEmzBxFkce8xY+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIdBGDDjFc/EQ36TFvZ1pviQ97cJKzauk2Ce1cwV6CU=;
 b=VfuXvy7nAChHncL2kyHb3UtwaOcwYGAM4Z8iC3+M460CJzcQeCpeNobgPgPYVy6OcFHFmz+xE3UasT9Tw+su7dO6f6onWbD++KOa1IQIhieLn/2w2hPhdYAcCJ9r9FRcfXVIXHa97jOFKKLmUk5QRhEABZdWY5j2P5d0qIa9zADGSzBVp3BUBmYGvilK02fnNkm/mtsmL7xULPOZ2F5o2AwB/mIIQg95QjX3WKh2HVA6XduuhJfZFshipsJ3Smho21mpV7kdcDsRC28r45rMglgRujjxpUyl5objAFGtxucB/CP8EDcTEPJ4kqCu0ypPYIASnjCOZobErrziXJ9ASA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIdBGDDjFc/EQ36TFvZ1pviQ97cJKzauk2Ce1cwV6CU=;
 b=g34EZ4kqxdFKj5r+YzNlHyDD18CnkhqQwLxup32LsKQ4xPXPc8DfVS1+V5Es6s2RPYL65UrOKwotUQkgo6KorzPecM32aL6y291lQF3TiemzUI4MbJZEge9t1R+SrNAZz0ev/8GEACYTcfjLp8kVOTcvwfNcTynlnGPmxMeDb7xjNP4xGiwuXR7335KbYkLz4YPQkJLzvEEeUMMlrtzaDCl/kMLQKf/WFgWP3yzrR1F5z40DhdOuSIFOMQWcJfIt/B9g+w5irhf40fqMHBs8Wsovmf0eewAn95tzP2AFHtjRkefst9VmCafeM7SCcFk7gY9ECmq1NSToU1WM1kLcmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7619.eurprd04.prod.outlook.com (2603:10a6:20b:284::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 20:48:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 20:48:32 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 18 Aug 2025 16:48:13 -0400
Subject: [PATCH 02/15] ARM: dts: ls1021a: correct node name "timer0" to
 'rtc' and remove reg-names
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-ls1021a_dts_warning-v1-2-7a79b6b4a0e2@nxp.com>
References: <20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com>
In-Reply-To: <20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755550106; l=1142;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0yrEpaHHmXEwPCp8YGKQlagzzCd/v6AHSUpR31ihWfw=;
 b=hrVOPrQR1IH+iGCKuUHYCnHEewMI+V5WX+VG3buAkD1OQhPEA+4JtJELAQjhU3nWLJTbysdwY
 /0Kkr+qZ6gRDj7bGpXHz80ccAIxhl0VQfCetjsmtHpTDF0DoykzoC/t
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM9P192CA0022.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: eeae62ff-68a7-4984-2f88-08ddde9897c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3ltaThTaElOam1SYUlhQjk3THpVelVFZFNqTmRFRlE0QVNCSXhpemlpRDVE?=
 =?utf-8?B?ck5vbU16Z3JXcGNwM1hKSy9XelRERTBiUHlZRDZrRndTVVAyRFdMTk1Jc3Bn?=
 =?utf-8?B?QURWajZiaTYvV3doNjZLT3lNZVNzOE1NSGM4VjU4djdPMGkzdkIyaHpTRFJo?=
 =?utf-8?B?bHRjVytWYzVNVTZpR0x4WnV2K1FBMGpqRlR1eFc1UTB4ZEdWdTVWekgrWXJZ?=
 =?utf-8?B?TnI3dC81UE5VSWQwdWhsdFQ4SHgyZjkyV2c1RU1PeUp1UGtRUnhJYjlCaDRr?=
 =?utf-8?B?VXhoMTlKemp1dWtmVnIyMkYwYzBlYzltWEtONkVzcE50c2FYWWUxZE5yazE4?=
 =?utf-8?B?SGduOEVCb0VnK2o3YWdzRG5WZ0l5dlhkalQrMFhHK1IrUVF5M3YwWjRYcXNr?=
 =?utf-8?B?SlNBLzlmQ3ZQWHhFL3Y1aE5waXZWcE1YY0VKMGxsTW0zMG8zbWtsZnB4SW5z?=
 =?utf-8?B?Y1IrcDUwbGpzdXJrQWRQVVpnVDBsdTdUU2NQTlUxYnJQb2Y4N2lVeWhaR1JP?=
 =?utf-8?B?bElFYU9OZDlTbEpZeHJuelJwVGdxSzY1NWtsU0YrenZjdzZ5SDBVNUhJeWh0?=
 =?utf-8?B?QWJqVGlrT21OMVVrZnQySkxEcS80QXRUQjBYNjhGQ2tpd01ZTE03THBnWk9u?=
 =?utf-8?B?N0x0TUNiL1JZdU1UWjhEV0dQUmxXeFJ1MFhWMVlBUEZSODJNOHBRVXhpOFVL?=
 =?utf-8?B?WnJ4RjhrblJKczlHNXlISEpuVTkvRUZLNGcyTWwzTzN5UWZaZ2lrczRXZHd6?=
 =?utf-8?B?dWt5dzBXV3ROR3lVY1UrWXJ0azZteVdxM3VMeWFEVmNRb2U3REFoSTNSdDgz?=
 =?utf-8?B?cXhKQkg3UTA4bS9HWDJPWmJOZDN3TE1POExVaW1qWmtMcyt1Um95ODlGaUVn?=
 =?utf-8?B?c1BPcnJaZlFJLzhJM1pRMmFNRXNWNTNBdzdueG9Eb0ZsckE2dWFuZGJEc2ZW?=
 =?utf-8?B?aHQwYjI1amZ3d3FxTDA5ckdDOEh1Rm8xc1I2RTJ5cTRxbG4zUkI5WWkyS3JK?=
 =?utf-8?B?cmEwdjdISnlxbmp3VTRQWitaMnMyQjBpTUp0UDErck5YZjRucHIzOEJDbFZy?=
 =?utf-8?B?cGFvTU1HZksvdEV2dUNzZDE1cG1YVnNHaHh6a3JnU04vVTBlYWdXVGlrR1Rt?=
 =?utf-8?B?RThDWVJyV3N1YzZVK2RWcllhanZQRGlMcis2UzNKRUE3RWxiK1ByMVRtc3Iw?=
 =?utf-8?B?OWtkVlIxZEVGYjZHajlMMnkwU1RLK242VXNWME1vOHp2SjZzN0FGVHBJT3R6?=
 =?utf-8?B?VDFSbWVYZDVlQWxOcUVYZGdNcE9UdXlqOXpHRjNNNmtOK1FQdWFmNW10NGtW?=
 =?utf-8?B?eGZQcVVIdmpHbytqMnd5UlBhR1hvdkQwcDV1M2VGWk1vc2FXaU4wY1h5TWRU?=
 =?utf-8?B?YmlHWlNOSTFGNzFUT1JMazAyZzJxNEdKT3EwNzBrKy9aY0tVczBTb2ovMHgx?=
 =?utf-8?B?bjhCenNOWjdVUDRGUDNudDFJQWR1bFdCWnRCa0JWQ1VBMWJ0V1JZdkFKdnlG?=
 =?utf-8?B?YUxNNThPRzJGM3A1clJVc3J3ZkpqSVVqbTB3YjlDVnZnckN4ZjFPK0dYaXZa?=
 =?utf-8?B?NkMrdGoyaFAxMko4a1NmVkNvT1gzQXBiNm10SjZKK2UrRFJRWDEreGdRbEhq?=
 =?utf-8?B?SjdsTGpJYW1HWUR1aFZFN3ZOdVo5ZnNmdFV6UjQzMDlBdlpHaCtWRTJEemhC?=
 =?utf-8?B?dXl4SUFZdGdsY1p4a3pkb3hueGlicDZXTVA2Q0F3SnhNUHAwNGZvUExKUTRH?=
 =?utf-8?B?dE1JU1FqVm9FYi8vMzNaOHVHZStERTJ1VS9wUWdYQnNjUndwTDhUVFdUMnJX?=
 =?utf-8?B?QTQzcnhNMUFheFVJUkdTcm5veDcyWmF5VVBKWEJQL1dsS2VsL0Jwang0U2hK?=
 =?utf-8?B?VkZwaFRteDhncGVXdmtMalFyeXVyMkxVdVNuUTdOMGVyK0tFMXNCUU00OWxL?=
 =?utf-8?B?eHIzM3pIQ2cvVHR1T0RwSUxqUUUvK0x4YWJtYk50S09sQnZZZUhJc1NrWU4y?=
 =?utf-8?B?V2VST1JZcVB3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHp1K3E1QUdmR3pDRkRCMUZuOThNYTFWcEZKcmVLTERLZFBtaktDUUxxdmNz?=
 =?utf-8?B?YmVzbDBBVTNPalRUeTQxZE1NeVdDWFhwL2hWL0crUGVBeWJRekUrcDdIeGRE?=
 =?utf-8?B?ejRoMGsvbWI3T1QrRk5pb0JxcGpHL2dWMndKdTVNMy9pbTlFVy9zOER1Zk5P?=
 =?utf-8?B?R2JabDQ3R2lHR2V2c3ZLOGlXNlBpKzc5WEY5cVJmTklxQVh4Q1pQTVA0RXN6?=
 =?utf-8?B?OU1TeWNTQjNXS1NGdloxSElNQk9qbzdBTmQvQUh0VVZXWUpyM1VyZkdDeWlv?=
 =?utf-8?B?Z3ZKeGJKVW94MmhvZHpaY3ZjY25aS280Q3gvdFRsS2NNcWp0V2dvdEo4cGxK?=
 =?utf-8?B?RWNwZHdBSHJMaHpCQkdGTXFmRTM3UUMxcVIwaFRaRHQ0K05vMXlRbkwvUEJ1?=
 =?utf-8?B?eDVvOUZLZllKYXF1YWgyUC9FOG9LVGdIV2FQZXE5VTVHcnV1cHhTc1g4VDhS?=
 =?utf-8?B?OUNPYnJkcGFMb3l0eHMwRGVnV3RRbVdXcjU0dG9LcmVKeG1YVTRtSHFTSkRD?=
 =?utf-8?B?WDlXU20yaFh5RURwU1lMSy9GVU9NOG5kVTZqYU9zMS83TzV0QnVkQWVzVTls?=
 =?utf-8?B?UmNDNkdJYWpIWXhCS1poRzlUNGI2MmJSWjk3b2l3TmthbFU5amV1c2RNUVgw?=
 =?utf-8?B?bDJocWRiWDdBSXlkTW1BL3hpbWlCd1NCVUFsLzhaVGo4d2NMQ0RSQjNFL3lB?=
 =?utf-8?B?bi9yRWdwb1hvZjBOUUZpdGVTVHFBNUllejBaanRpOFN2NC8yZWZNcnpmMnBB?=
 =?utf-8?B?ZC9BLzBhZXpJSlBGdzBWMFcyZlhRSzEwT3IwVDFWTXhXR0xtQlk3V2JMdUNC?=
 =?utf-8?B?WHBFOUdGdVJWTks3ZXZsbUJUZ1VrbUZOenhTRDM2bklXT3hncFpkNDUyeFEy?=
 =?utf-8?B?QkFNKy9hR0l4RDU2ejN6SjlUU3pGWnBuZG51K0FIRWh2N3AvaGp2OVhMUm9I?=
 =?utf-8?B?WklZMEJjQWNGYmdLUkRianlvWmI2NTVZcHg2TmlYZWo0WGc0UkdoSHR6UUZi?=
 =?utf-8?B?WHZ0ZktaUXBqbThXcVNWZG9xTDZNbEFkMXJEWkhLNURVTlRIS3lBNXQyNkVz?=
 =?utf-8?B?cXY1QUpaQklWWnhQanlMUkQwaXBHNm56N1VsbGZHNVU0ZFpmb0xmVXA0a2NE?=
 =?utf-8?B?ZHprZHVjNi9FMUt0RXNsMHZVMVl6dzFDMCsxdWxJVnlpaWhLWGpQelZjNm0r?=
 =?utf-8?B?Y0pPYUFmV1BjanM4OVJmMXpaaUtCTUsxdmtQMVpQTGdtZ3BhOCtJT0xGS3hr?=
 =?utf-8?B?cTRyK0lieExORjByVTFoaFVvckpEVDBBZjFkMlVIUE9tMjExNjIyMVIxOUxM?=
 =?utf-8?B?akpPUmppeENjYkJ4MkNBRFgvQ2M1bUY2Z3RXWUFOWkNXL0NRb2IzeDg3OFhG?=
 =?utf-8?B?eXhET3h3VTRkKzdCQS9YVTh3bEozNjJmcDFyT1dQSXVrOThGcXN2STBqRjJI?=
 =?utf-8?B?MVdxaE5MdkhFUnBHMGUya04wbU9nMkQxUVBjSmNzbEc3SmgzUndacjdHcE9Q?=
 =?utf-8?B?Q3BWeTA2cDZWUTBNMmtzSzU0WlRja1loMTJwa2tQY085NWJDTTU2SUNKTzMx?=
 =?utf-8?B?MXQ1T2VndW5KdFhnS3FLdDZTK281WDB0azBLdmZ1RkFaaUJiTzUrdWtXRG1n?=
 =?utf-8?B?VXZyMUF2dEhpYUg5K3JaLytsckRvNXBFNGRqbEhadDViWW5qdFJWOWUvMGtL?=
 =?utf-8?B?dFhLWHBoU1VYU2d3WnQxa0VQYVhKWnFRcTlIMy80cEtUY2N5R01PZDYrOGRo?=
 =?utf-8?B?b3JuSWJmTGUxTERNN2paeW5tTW5Sek1vdlRnVkp2MHZ4UU9vVDNuQklydnRU?=
 =?utf-8?B?M1ErV3pYZzhWSmo1aWt5REVBZ09UckQ1Z1BTZDdJQXM3VTJzM2VhQURkeXZM?=
 =?utf-8?B?Q3FnVk1JK01TOXE5eGgvM2ZESXEzY3Nlakhhb0JYamV4WnMyajgvN0Q5RFNi?=
 =?utf-8?B?d1A2QnRDVXV6MGY4eWlzaUErZnNlYmR0UmhmcWdoNkNiMS8veVpsWVU2NHNC?=
 =?utf-8?B?QUx1cTVJYWxrdkZHZGJGbEo0Z0pFbVB1QVh3akNOQ1V1U01XUlFUbi9Remts?=
 =?utf-8?B?VnhiSFEyZThYd1ZXSU15eXhyWkl5Qk95M3M4anBrVUlGTHlueFc4YXdLb3Jx?=
 =?utf-8?Q?n0u9W2gDzzvLyhzpxTQvtPWS3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeae62ff-68a7-4984-2f88-08ddde9897c4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 20:48:32.0316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKb4eJ7tSpSP6TX8PDYGt91zWxXrq0TAW3IEj5iu79XhmAu/zh7spa779awraI0UxBgCpBYiONP/zHuyZ8lfoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7619

Rename 'time0' to 'rtc' to fix below DTB_CHECK warning:
  timer0@29d0000: $nodename:0: 'timer0@29d0000' does not match '^rtc(@.*|-([0-9]|[1-9][0-9]+))?$

Remove undocument and unused property 'reg-names' to fix below warning:
  rtc@29d0000: Unevaluated properties are not allowed ('reg-names' was unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
index 315f7fb8dbf4c5e9a482c285a8f394a3a2f6bfff..fdb8f5952fcf7f55fda9b5d5a45de053697f3264 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
@@ -944,10 +944,9 @@ rcpm: power-controller@1ee2140 {
 			#power-domain-cells = <0>;
 		};
 
-		ftm_alarm0: timer0@29d0000 {
+		ftm_alarm0: rtc@29d0000 {
 			compatible = "fsl,ls1021a-ftm-alarm";
 			reg = <0x0 0x29d0000 0x0 0x10000>;
-			reg-names = "ftm";
 			fsl,rcpm-wakeup = <&rcpm 0x0 0x20000000>;
 			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
 			big-endian;

-- 
2.34.1


