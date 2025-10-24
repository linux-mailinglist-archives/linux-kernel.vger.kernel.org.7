Return-Path: <linux-kernel+bounces-868269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED2BC04BDE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D487F4E4258
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429F02E7650;
	Fri, 24 Oct 2025 07:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a8P5tKSz"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011029.outbound.protection.outlook.com [40.107.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA792E8B9E;
	Fri, 24 Oct 2025 07:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291169; cv=fail; b=qye6mR38iRwF91NbTwxDDyEtLusweWxV9ljLqIMW4wYZyKYwmgxRwGnBcEiSc6qMiMdBYN2vtixZvwpf4S2JnDQNRaNBMdr9pp0GGFUxr8momt9eT0ylyfvKH/8xw0g994WcjpC37ic8UJfaEX1oExeUn/Wk65As/zoxOv8kGwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291169; c=relaxed/simple;
	bh=c2h2cAD7WrTrmj4mmNContpgDYNtY2JXyFtaGl1ZMLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TU+v5m1grkzDHLKcUmLOdmmwJzyV46ILvPZHokmMw0nu7sX1Dy5dSB9RrkW+fRlBj3RmLZ5pvjvm7TCrXjHizPY50py5rOA4zhPM8hlR2K2wexDTPGYc7AWhRyumWXCjNlMK1HE9aNBLnOqp7QPKiPJx8v5QB8Yd4y/Gz2GVq3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a8P5tKSz; arc=fail smtp.client-ip=40.107.130.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lklflRatHadEwOdov2x/+qCHnznpr4JziCRHpiiFHSp1Jft3ytYKO+eDwz3SvjfO6XOerbtW7Rma+FJiBJ5cyFbldDddNv8whMux1GaB6u8hjDFIH4/iWJwOHClWcnE4HbC0Mf9F+LvEtw05x2YM/CtwoB3eUnJigIAkK/XrT7vwO5HHsCFW+L5HLuAZ4T0g3m+9djs/JbJccfmTZLEwXLtUEwqx/pVFQExVOwlP0vBArvRiNfAFPV3NF2UXVbVcxrDQ/yDmBf3rlONqgMN4ZOfjIVp1RXQ5tBw4kLIa4hKY4Z6ODx8yjTVtgm2dThUbmm9bGNfQQvemQD4JU3cnoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3olTyvv7kPg8VCcSxtmv5VAs9EC35qTyB2FijWJpgg=;
 b=lcMJ4sN26ABvViaa2ZwYzWvoiyPoOQ0bnQgjrr+/lTIrPytAFGoCRfi3qlc9xhJ9pxr0OisPjqPiVGr6TESS4Vn0JLFUK116k+i7pOsOLEEGWhwYf9E0y3bzK2wvlS4xgYT1ta1ODBmLxBjZa4EL+s5hQiHgmqXhsFyNjELVpi/KSX6K10pn/31J0AtzPldcuZ/zyd77KiWVEnjpkG+8JmPEv+QTdz3FqQW51siO20dkYcw2k47a9TMyrt0O+FhdVze/YTs77cq41f7gw+5uqgRGj9JIVffp+f64vz7EypSthUp8163uzsDAlnIa0GEgh662aFxnP4JV3FRJLFXevg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3olTyvv7kPg8VCcSxtmv5VAs9EC35qTyB2FijWJpgg=;
 b=a8P5tKSzLFixXQflvUk6i7zR7BUqAyoggk1TN7x0N6o0ruOYiClPy7MuYE9d0u2hWWqJ3QBNKo4l4plRJcz5WD1bg4ZA4yBBwVfi7SdLLaGS9sXNFIDqQezS8j+zc65JcJt7en7ZQBQAK4iSyLJ80dTPG7KoPlLYfLRBgRRakd3tuqed5HGf/6fWe1sZMqWFBS+bEwo3rDUFhhlAqfBz/miOU3LMin96dsTyKT3+yi/1i0quOg39NzNbinjIFjYpmm0mpvOAqzYfctzrHRGUp6oR2PszHb8xNMVXP3jHfERUQTc1a7afm09ZkCBKwBniiTD6tH6/K032hepLF29jMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DBAPR04MB7432.eurprd04.prod.outlook.com (2603:10a6:10:1a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 24 Oct
 2025 07:32:44 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:32:44 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	frank.li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: kernel@pengutronix.de,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1 5/7] arm64: dts: imx8qxp-mek: Add vpcie3v3aux regulator for PCIe M.2 connector
Date: Fri, 24 Oct 2025 15:31:50 +0800
Message-Id: <20251024073152.902735-6-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251024073152.902735-1-hongxing.zhu@nxp.com>
References: <20251024073152.902735-1-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|DBAPR04MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: 41fb426d-f3e8-4a23-ae43-08de12cf8586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXZLa3djNEsyRFo5T1NyaVAvZDF2NUN3QU4vUjBZd0NsV0xlYkpQaU94K2gy?=
 =?utf-8?B?RGZGVFcxTmhZeUVUNm04NGhYMkNwczhvYUh3ZElCWlhlSXhCS3lqMmN3WnlN?=
 =?utf-8?B?TmlmUXVPS0h6MGlKZ0kvbjdrUk1aczN6cCttSGJiYWxCa0hZRnBhRFF4cnZQ?=
 =?utf-8?B?UkNHNCtvWUNHcGdmejkvUmt3MnMwT0JxMURnZS9JMDVnVVE1dW5DRldib3BV?=
 =?utf-8?B?ckw3Ym8zaXY1c0R2TlRGSVNOcW5kNU5ldmlyK3Z6eXFNVjd4YXpVZW96U1ho?=
 =?utf-8?B?aVQ1TTZJRTBQLzVjMmsxUzhpcXoxYVJZR3UraE9pd3J2enNWcTU1ZVVCOWp0?=
 =?utf-8?B?bHFhQ2NaK2VhQjR0VzhLQTJMNS9pR0Y3OUdOQVBocm1CNXYwR0FRalUydFRT?=
 =?utf-8?B?TGZPSU5jK3I2cGcraXFkZUNQbDkrQmdVK0dDUS96UzZTMnlmaHJ1Qm53eEdj?=
 =?utf-8?B?VGxuSER2WUdUTEh6eVJ5RXp2WGRjNmsrc1RqSExyZ2lEZ1VJNXdSYzBMRkRT?=
 =?utf-8?B?SW5MbDYzbG1ubmRRalZKMzVWbXJPdTR2SXF2dVZRaWhZTjVVVHlkQXF3Y3cx?=
 =?utf-8?B?Ukd2bGhBbkl0cWgzNXlNc1RxYUNyVWRsZWtGd1h5NFRxVjE2dmZtSnl2VXdL?=
 =?utf-8?B?cVNoS21jeDNRbzEvMnlqeHI0L2ZqQldxTCt2SWVuRGwyTGhUc2ZJYTNNVDNa?=
 =?utf-8?B?Vkk0VGZBTHAwOHVudGpMeU9hYlpHMzNmQ3J4Z1dIampsdzlwL2hSS2pzVVQy?=
 =?utf-8?B?MlVUQ3dRayszZHFJU2pzOWhrUmRCWTFheVZPWWVTUjhlNDB2ZlV6WGdWbzND?=
 =?utf-8?B?K3JZUzNVVW9xdmg5T085S2pwL0Q3bEV3cUhDbi9WVUlRd25CSHZrSUZOditp?=
 =?utf-8?B?Q2YzaWJYeUJhVVpnWnJMaFNRU3l5TFZTQU94U20veWt2SFBhSVdCVHhMa0Nu?=
 =?utf-8?B?YjlzelV2ZWk2TW5DRS9RRnFmVVdIMlNsTnp0OUh3a01JRTFGYmlxOTBVekw0?=
 =?utf-8?B?SDV5UVBSOXFpdENNYUsrbGpzeW5sU0JVOTB5ZUtFNUZoQkJyS0VaNjVYdGlG?=
 =?utf-8?B?RFF3SWZRQlJ0aHRHQXdSK0Zzb3dnQ1JrUXF2VVJJc2Rsam83MEZTZzJneDEr?=
 =?utf-8?B?QmlISWY0MlQyc1RQcFBtL3Z5TGEwNmpBN1ZZVDFJNFJSeldzK3ZQTTRKY3Bo?=
 =?utf-8?B?Mko4cTYvaFVvajIyckx5c0dBQ2hQV1lRcGs0Mnp6bG5LNzlsSURsN21wSENY?=
 =?utf-8?B?UE1LYy9LQzcyWE1QQTBRMW9jeXBJUXRvcTZNcDNuSjhwTlVrYXZWNVZCVzFa?=
 =?utf-8?B?TGpkaGlOck5jUU15RFFqM01MTFJ1ejVXejVNVmJtOG1qSFhPcTExYWtjL0pz?=
 =?utf-8?B?YnpqdnRRU3FoaW1hM0NOWXk4My85MXVTTSs5YlFteVFqUVllMitLaDlaODVM?=
 =?utf-8?B?eGR1dXFQRy8rYmlvVi80dHFJb0xvQW1EdmhIaGdLZ2xueTJJamRXbXNnWWlP?=
 =?utf-8?B?SllnMXhDU2IxZGR6c0FNZVJ4S2NnYTNsazFmUE0xUW5PWUo3eUwvU3NlMzlI?=
 =?utf-8?B?QkRDVzhNYWtleldHaTBnczlxQ1NLVmxrOVlVM05DTC93UFJKOUMxTkFVdXkv?=
 =?utf-8?B?Qk1XUUtHL2FTck5oSmZjY2J6UlhBUS94N3JkcGNyb2VnKzErWUhtMGcvQXNn?=
 =?utf-8?B?Z3RFcis1NFhhZ0RRd25XRnNzUGMzS3c0a2NlZUNJbE1ONmhGQVRkcVVhYUI3?=
 =?utf-8?B?YnovOFBjNGNIb1ErSkNMVmpiMTVieTF5ZHZpZkExQ29KbG1wSklyV2RpWDJB?=
 =?utf-8?B?eHJzZ1pIVmxsWENLVi9aU1RQQzJOTVNNUGRHTGZFM01oRWI0UnA5bjBQS21m?=
 =?utf-8?B?NGdKSGFBdkxnemZadFo0SkV2MW9xVGhxd3ZwN21hVGROMTdodFVjaC9FMEZp?=
 =?utf-8?B?UFZMeEJyOG1Jd2ttcGtQUkV3WnBUUUFTb1NDN2VJWVRtMHFTV3dIOWNOQWVL?=
 =?utf-8?B?WUtwNVpNVDFFZENEbFBWek5oUVA1cW9hS09SMndwMTQ3TUNiRHFWOHJXL2t6?=
 =?utf-8?Q?TCgVwU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkVIUWIyZG1SUCtRUTFla24vT2NieVdSbithQklZNTNBeUNhTHpyclViSVEv?=
 =?utf-8?B?akFGWUZxdzhmVmVmVkJmUmxUdXFRTlRsV3UwQzdPSjIvZ0J6VCtaY0xST3o5?=
 =?utf-8?B?MTQrN0tFV2NzZ3VSV21iczZNSk5UckhLa1ZSNUFEdWF2ZzBtV0xpeVQwYUZP?=
 =?utf-8?B?SmxhUkZIVlZ0WlV3T0pzUlVsOTQ0Uk9rak1hYTJ6N3hoMUNtVzBob1FjUnFt?=
 =?utf-8?B?NzFCbk9wWWdDT29pbGRHNVJTNmQ4THQzdSt1NjlrTWhTM0ZNSkRTY1FkMkZh?=
 =?utf-8?B?ckxQZi9MMkxIVXhjVXVzb3huMWpYeXhnMTcwZjllOUl1UDluWjRYdnA5STVq?=
 =?utf-8?B?aWdaU3QzbjJiQ0RLOXFnVG04UE5vdExpSm5QODdMZDRQQ2E4b2ZJTlpvd1ZG?=
 =?utf-8?B?OEdBODhHU0syVXAvMWhEZVlyM3Zjb3g5YUdzZzJybGhxZGtnQUR4S3FUUWZs?=
 =?utf-8?B?cUViMHhrck9scjkzdkpKU2dtZ0VFcmdBemtEM29IUHN6MXIrOTJGQU5EdFk4?=
 =?utf-8?B?aThYSS9EbUFHTkpqbStJTnEwT3Y1YWlwNXkrcDZrdXVpTTdsa1pvSStydlgr?=
 =?utf-8?B?TGF3T09kbS9ObEYzQzB5UDdnZ1pCSDhMZ1dWR01nZHJPSnFkVkNseWp4QzQv?=
 =?utf-8?B?OU1neXpRTGtjTzJ6cnI0OHRTWDM3MnV5aUc1eWNIcVFiYkNuSnU5dEl2Q2dL?=
 =?utf-8?B?bXVjL0k2anFtemIzUmQ4NEM4djRFb3N3UDBaQnI3RklNcnFUN2N0NXpvWjRh?=
 =?utf-8?B?TGhmSkZneGFWYUtVbW1adXViWW5GVEpMZ3VwNFViUjIvVExyYnNVQlJCOW1i?=
 =?utf-8?B?OWhNOHBHSjl4VXExSUp5T29DUW55WnI4OEtaeExFOFBTeUhsU1BKOTJGVDI4?=
 =?utf-8?B?Tmx4Q29uN1cyRmVCekk2b2dTa2RqM2tZaUZqdFVOQVdzYlNkRDdadGp5NFp5?=
 =?utf-8?B?N3p0UGZhYXhhU2h5TlhmcU5TR2hIYnk5TnFRTkpvcEM2d2o5UWRBeDNVb0k1?=
 =?utf-8?B?bHVCZDhaNjFyT1N5Y25NYUo5bmlrWjFkS3BXdXJQdUwydlhDbTdqcGtyS1la?=
 =?utf-8?B?NGlqVjBna1BsZU4xUzJTS2Jka0ZOVnhUZ1plS2lTWVEvdmpQVTlQc04wY29h?=
 =?utf-8?B?U1Rwd01yQlZkMWlyd0oxQ0N1eFAvSkU3Mk9xbHR1S2xBN1lFdTRUc0UvNWl4?=
 =?utf-8?B?dlhuVTFhNzJKV3F6S0Q1VUU3QzFCUmJJVDh6ck05UlhWTGxETlRiUkdoNVNt?=
 =?utf-8?B?Zjc1VFRzblVDOEIzOWJxSjBkR3JNREpXVjJSTGFESnBKaXJydmljaG52ZEZ6?=
 =?utf-8?B?R2dRbGIvQkEwdkZ3MUJFcGNzY2tjWHNnc09OcGo0b0xIdXhJYXU4amtVNW84?=
 =?utf-8?B?R0RSdVFFNkUzd0RncEN4dzJNMEQ0U1VDVEkrczIxcS9zZ2o3TjJIZ0E2TEI0?=
 =?utf-8?B?SWNvU1YrTElRcGRtNDZLUWVQa3VTV0JYdGJ3SURjSDJab3JuRXVMdlZvaFBW?=
 =?utf-8?B?T1JMcVROQ2dUUFV0NURFOFJnSVJvaUxKcVNKMG1VR0l3cy9sYVBXMCs0RXFZ?=
 =?utf-8?B?dGJxZWFFMWF4eTd5ak04TU1UQW84ZUY2MFR2Z0dJZ0NRSk9LZEpudVlnMXVa?=
 =?utf-8?B?cjdBYUpiVXJZRmJCTit4MVZlOVg4Mjl2MVgyTzVCRjhaT1MvL1JpQUFYb0RQ?=
 =?utf-8?B?YXBZd0lSNlRiNE56V0diQldkSzlPd3ZOMS83WlVCZXBpdjBPOS9aU0hoMDQr?=
 =?utf-8?B?USsxZE82clJFdEcwNDhuUGkzdmZDTWZ5dE55WVhkenpoRG5mL2RRU0FvTTBz?=
 =?utf-8?B?YzdDaDdnK1JjMFIya2NTQXFCUWJJeFRna1B1UFpRd25iSWU5MXl3VEphci9u?=
 =?utf-8?B?T0xjTDBvRnB6WWNzeGlsY1o3NmwycDI0ZDljK1dlcFAxOFowdU1HL1prZjdw?=
 =?utf-8?B?Z1hhbW80TGxaYWpPa0R5VFpIWExCZi90TkpoN1ZmYkV2d0lOeWgxenpBaDB0?=
 =?utf-8?B?OC9jZmg4WGpQempmS28rVTFnN1c0Tk5ETW1Pd1JrQjBCMlBXaVNtaThoT0NB?=
 =?utf-8?B?WUJDTDEyUldIeXd1WWY3UWg0bEJoNXRkT1I4Vkx3VnVkclJHVWV1Y3ovUk12?=
 =?utf-8?Q?5sdpUzBV67eS0yqoCXDx1mQDz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41fb426d-f3e8-4a23-ae43-08de12cf8586
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 07:32:44.4417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVcmqc0xNGI/N5TExzj9b6dNn1nM6Yu3JXozyQ0uf03gLG89vT8PecgC3wnaaIQwvaUQDSsyKdsWYpKLz2etlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7432

Refer to PCI Express M.2 Specification r5.1 sec3.1.1 Power Sources and
Grounds.

PCI Express M.2 Socket 1 utilizes a 3.3 V power source. The voltage
source, 3.3 V, is expected to be available during the system’s
stand-by/suspend state to support wake event processing on the
communications card.

Add vpcie3v3aux regulator to let this 3.3 V power source always on for
PCIe M.2 Key E connector on i.MX8QXP MEK board.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 7b03374455410..521e1be710d73 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -631,6 +631,7 @@ &pcie0 {
 	pinctrl-names = "default";
 	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcieb>;
+	vpcie3v3aux-supply = <&reg_pcieb>;
 	status = "okay";
 };
 
-- 
2.37.1


