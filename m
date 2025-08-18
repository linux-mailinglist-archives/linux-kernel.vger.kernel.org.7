Return-Path: <linux-kernel+bounces-774485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5C3B2B2EA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698EF1B21D52
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C1027AC54;
	Mon, 18 Aug 2025 20:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cZasZ+Eg"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013064.outbound.protection.outlook.com [52.101.72.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B5227A133;
	Mon, 18 Aug 2025 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550137; cv=fail; b=BiqKYoFNSvmdtzluTQWI8vVkrHmdwG62g9/81aAFSF2JtVPabWex6olpZMP/PHHFlVbXmZYNrvT4g0MFSSYPm5SFt2nkP40o9uXAUiXgM0DUrAYj78rMgqti2IQ965sYJk14qu2eFRo6/381tRb5MapmsQspOMdE/cVeQWop9v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550137; c=relaxed/simple;
	bh=u8KaPIg5WEbrrBMCxyVbENjWjCDwS4br2WKQxeAXjms=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=msfZGpfHhPEAIefCl7G4E5UINAitgZfeLx37X+DKqvZhBZdug9znlQHCSYs/qg6fPph1mFPXNw/FSVtrhgoFLbe5ctjNzAVQ001BHBY+FuA940fgJVheZtF/30F5mUtfa0t0odS0b8QOfcwdJyobuaLPMycqHpnU+PTk7yDblZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cZasZ+Eg; arc=fail smtp.client-ip=52.101.72.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6TN13m++CDBukrxV11AJeVRoTpxuBwBT6y8z4Eo5K6edX/jrsL8y6X6zUxk31oVzryLRMkHUMqmbeqwo9o1Hj8Gl5DmzNh83QeFHVejDXDE7wmDLUEwCibfiPv3qpNzwCZtCkd+2/pv51xZQQJ1I8gVjqP9NhT7lsXwbOlnfns4pTD9n1F12nAIgs2mzh84hV8xAJcfQOhMi7gBG3TVs2YJylHBujR7+jNt5TtifWD3IyqM6AOT/yQsEQpzeSUYfeUOFHzpg/mP6am4RRZslxNaeM9HPt628xg2ov4f6HcB74K/cHpiZrJQ/nWoN5Pht0mx5Rw2T6o41Cs6m+Ixbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbJhogPXWV+l0PE8+VDWiLqgnaLDqe0J9oaTWmq/4Mw=;
 b=WE42drqGYEwHH/FAY9bpN1vwfCP9RFS47D/boFDoUmOxq9fQhfCRrF5TSskmHz8I5Yb+uhS74ruqAU69hW5TWi+nFjxf6ClkzoFcnx27TdqPQw3rkfjh7SEFJ7qJZKSQ89iBg3UBdpIVXXl8AVijPN7WWc65aHQtswyjsjccQ/FhGCmJy/+q+dSP9plXJ7andwQ7QMMoq/2KLVnvXeutcR0lAcvz3g1wzSSP4Fddw5608L978hhAsxl8WBBe4RWlH+1+ulETJaFWkR/2BhHfyEid8YWja59VTqZaTc6JohJVY3QM2sONUIPUN/xF0hkVsMx4j1b0o05LvGR0ACpRnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbJhogPXWV+l0PE8+VDWiLqgnaLDqe0J9oaTWmq/4Mw=;
 b=cZasZ+EgZIXklXhkhJb+++QeunWhcHepJGRzM1cReIqe/CT13OEstk1kDUbeuUUeCmDz2ktUkcaoA9N5j4j9tidDJMBgijYn1UBLrQeNQIREUMm4F7g9yTxZ1kmYhC73anY0nVm4KSr562DNG6ntk7gU00Uy3NUylMOlX586/Wj7z/9SlYom9TwCt4t2JK4NqpfhljlmL+MR2l1Mo1H64A3U0hlwMaMk2yezL2W63HI16I0u9EEr3U+hmPpMRJeliRB8uZ8Wu9qN92aaE92/hV9vRgFfxlK08pOgLt4LNSysZJGHJk4erf7sIgTWthg3r4nCufvpSKFfrJe+4don3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9009.eurprd04.prod.outlook.com (2603:10a6:20b:42d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 20:48:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 20:48:50 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 18 Aug 2025 16:48:23 -0400
Subject: [PATCH 12/15] ARM: dts: ls1021a-tsn: Remove redundant
 #address-cells for ethernet-switch@1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-ls1021a_dts_warning-v1-12-7a79b6b4a0e2@nxp.com>
References: <20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com>
In-Reply-To: <20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755550106; l=1081;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=u8KaPIg5WEbrrBMCxyVbENjWjCDwS4br2WKQxeAXjms=;
 b=DvGnbZC8pmWf2gN5dAvOSxcNIcCo8owMemWjxDB8C8kgp8OVz15J4kaZe8MKmKX4hpAFS7+Iz
 bfZ+h56Ujj8AOJku9OCPFHqREeSI/RhujiaVLIe0nxjgSTQYUx6cn8U
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf4eecd-32f4-41cf-5a91-08ddde98a2f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3czWGYxcERDRXFOb3h5YXBUbWVjc0dacW54SnNpWE1ZMElXNjE3MDFVYURk?=
 =?utf-8?B?Vk5jZktmZktVZHltUExINzNQb0R2b1JTcWM0YklrMjNSYXovWk1leWFHS2ZX?=
 =?utf-8?B?blE0TG0vamhpMXpTYXpReU9ubmZoblV0cjZ6QkJBMDFISzBUVFUvbDlIWjVo?=
 =?utf-8?B?MnlnVmFibzFJVzhOY24zT1Fjazc3aVFZaStFSWFGYnZ5ZjlEK3lEYmt6MlJX?=
 =?utf-8?B?c0x2YkZpOXhaWkF2UUlRRHlkN3ZsMlZXWXY1R2VpZlVxaExRVzZIbjRsT3Qy?=
 =?utf-8?B?NWlFb29nU250VFpDZmVJbUVQazQvU3hPaFlXUnpRWHBwM1RoMkxzOExQRUI4?=
 =?utf-8?B?ZWZCbk1tK3RFNGRXQ2djM1oySXBGdmlmYTNTcEI2dkFwQm51dXUveUNaNUtn?=
 =?utf-8?B?aStLYThUaWpwU1pBNVl6Z0Q5NFkrWmppemNXOXF4K1lzSnhaWEJxVE93dnlM?=
 =?utf-8?B?bWtxc3RLZUoxZXc4MnJCKy9PNDgrOWVyUlhVeEtWN2FNclFnTXQvZ0xCblNx?=
 =?utf-8?B?dzF6bjVoNkxhMHJmK0ZFWGlTQVlaVVpUeVFldER0VU01Z1llelRpbGpYOHZ1?=
 =?utf-8?B?U1UxRG1ZNUF1QlM3ak5RQUkzV05hUzVPa2JkSXlNYkdFZXZFcmVmTFJuRTV0?=
 =?utf-8?B?SEtnbkpmdTZjTnpaZG1XRDJLQ3BPdmZ3c01oNThhK2M2cU1vL1p1eXowbVBO?=
 =?utf-8?B?OFJ1S2NtY3cyajZZcFVsUWV1TVMrVUppZGU3RmkzQ0thcUhOditpd0k2Y1lD?=
 =?utf-8?B?VFNaanlpUS9LZ0ExR24wZTRCY3NmMUVYRmdnYzhxVS9NY0hTZS83QkhRVENL?=
 =?utf-8?B?S04zK0trRTU2czVKdExIbW5VbHhuUWcxV092dzBDWEhndWNKUEVKV1MvZXZG?=
 =?utf-8?B?NFEzUG1lNEVSM2xNN00relI4QVc5a2o1dzVqTld6dXNMMVdWWURHUzVmVDNV?=
 =?utf-8?B?U1FZck1ZaTNQbHNXZ1J1Q2VZUm8xSlZNcFFiY1lUMGZNR0VQZ0ZWa1g5U2FY?=
 =?utf-8?B?U3dwSmtGOUFlYmdISHVscXRyUlJhUUpSR2dDRXZhTW1DOXdVUytqcWIya0NI?=
 =?utf-8?B?TGdXVXNWUmhkMGkyRGJDeUI4Qm9KdXpGTStmTnlWZFptTjJyaE1KTXhqRXls?=
 =?utf-8?B?Mm5wWFpCam4zRy9HYzRTVkl6eFhPN29NMW11YllYQWNZNHFaV0F0ZVpkdTRs?=
 =?utf-8?B?VjNva0pyZ004dlNVMEh1SThTdHdtaFRYdUEwUUZZcFlmc04wNlhTc0RoWHZH?=
 =?utf-8?B?cERIcjdGNm5sQ1VBellWZXcrRWVwRW4rdXlxLzVQT2pvVUJkT2FtTWZnWFc1?=
 =?utf-8?B?UnpLOWJObjZpRGluUTFCN201dGJZRjNuRzduNjdxMi92UTh1K1VHUEZiM25j?=
 =?utf-8?B?QmtraFJubFFQK3ZuLzBuMmo3RVd1V3FCNkhybjdrTUR4dS8wVERrTml0S3Y3?=
 =?utf-8?B?WGJrVVBjV29tNVpkSG5HbmNIRGJKcGhGcEVVZVhIZ0hZQnEvSTFZUlF5SDJl?=
 =?utf-8?B?QVF1ckhsQk85TXovWG9HNjloZkMyZy9RQ01mbEgrQ0N3LzFmcXhGQ2RsWUdx?=
 =?utf-8?B?MUlQZkpWU3p4Tnk5VExSd1A4Mmorc2FJQ29aWjZRYVJOamF0SVFrU1ZQNWxi?=
 =?utf-8?B?UG11RUtyV3hDVlZVQU9xRjh0NG5qTFVKOERlclhhMkdYZGF5NytDL21ZQXpD?=
 =?utf-8?B?N0ZrQm01VHN4NlRuTk94NThMMXJHNXVVZXE2eGxOcWlKaUtnSkg5OVl5bEVZ?=
 =?utf-8?B?OGRHbnMyUjFBYmhmVFlheTNFMGhJUGZMeHB6K1dRUDRkbjZXSDd5M2ZzSXZh?=
 =?utf-8?B?VThOTW04ajJGOEZsQnE4RDZOcjdzZEs5NnhZQmUwZGF2bmFQeFNZY3hCUG5M?=
 =?utf-8?B?WFNLVHVKeVdDZ05hU1NLcXVhK09xRG51Z0Y5Rk9LcVZ4VkFJRERwSjg5LzZx?=
 =?utf-8?Q?bJzzCbsaYfo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zy9rOGl2a216TlRlc2RjbHdyYldmUTFlNG1VMWhaVWFjdkNxQzlwWkgvL2c0?=
 =?utf-8?B?c056OGZNRUtBWXhqL0w4RXhpd293WmN2YVNvQy9HTnZtNGUrbW5ENVUwQjU3?=
 =?utf-8?B?RG1aSzY4MkFweHJLRWk0ZFpwTUVWV090S1dCMUYxelFVcU13MGEvY1JMREFF?=
 =?utf-8?B?YnZmZ0YzVGNZbjkxVzA2Ni9MZzF1ejdlTm1vUGJVWDI1aEYrRHk3cFBndncy?=
 =?utf-8?B?cW85b2lHcndNWDlLUHNTcVZITUljdnA1bnhyUkQwajlKZnRBTG5wdHFhRUQ2?=
 =?utf-8?B?bXpIaFAvZmVwQ0xTcG5DTnkrZ1FteXE5ZklVS29hWjBWb01pZmJxS2dRM3BQ?=
 =?utf-8?B?NHZvZ0pKL0JKMVlKRkRvVHBLYjZUMFhoMVB5REk4RitTZEdObzFRUDZ4MXc4?=
 =?utf-8?B?dHJPL1U0SmFraWtDYWZueVdUOXo2TjdlUzRsR1ZYQVV4emJrSjNyeS93bTFt?=
 =?utf-8?B?ZEJUME5saXFEZzFleFJoa2hVRjNZQzBTU3R4d1I0WHRveE9JVEhLU3JlMkY4?=
 =?utf-8?B?bTJCZks2WnYyTjhaNGlJMCtYRWV0SFBzVFhET3poNXVSRXZoNEZDbitaRWpX?=
 =?utf-8?B?Vjl2QUM4aDFGNTYzQUhBNkNmeVB2bklPcUhNZUFjN1J2dDdwSnFDR21PUEln?=
 =?utf-8?B?R2FhL0wrT2xydXNzeUVLTXpialJuNkNSOE1XcjBjdHhpM3RPYUk0OCsvTmxy?=
 =?utf-8?B?MDd6K2xJek1MWVIyNVkyRVMvSEF0Y0FoS3haUFloZDhnc2dkb1hNVVd5YUEy?=
 =?utf-8?B?bS91dGc1RTBKOHpwL2JpRDhDcEI3MXZWOHo1RU4wbUVXVGFVUVhRdWZiZXB4?=
 =?utf-8?B?cFlKUVJBcjArcXlTRHBXRmFCN21WUW85Y1Ywa3Rib2xYVTkzNzhyRjE0Qk5s?=
 =?utf-8?B?TlNnUDQrbjM5dVM5M2Q5a2ttcEtZb1c1bnNqK01CRzNWQVdqV25UbDUxcGls?=
 =?utf-8?B?bEs0R29VT2NaNUVOOHZjZVBwemlkeFcrTUxFUmxaUzNKS1dLNHJzVStHSkFs?=
 =?utf-8?B?UVgybVo1VmJjRkQ5SmQ3eHZNSUdGSHdGbXFaN3pwUzB0Q1BGQUJCdmhiL1ND?=
 =?utf-8?B?SjVmV3pTcGtvK1JLMWdYRGEwcFZyMlpna1psc2lFM3ZtUElCNmlzMm9aUS95?=
 =?utf-8?B?VW9MRDFPd3ZXVXpCQUlEOXIzVnZqN0ZjTWJVSVlWUGlXb2p3M3p2YUNtMERE?=
 =?utf-8?B?VGhLa1ZRSG8yZlVFMnhEMFpxNE9yWjNDeUV3eXEvY0lOQy9ac3RHcjk3L3ow?=
 =?utf-8?B?VUlUQkxRU29BMFFuSXpONDljaFV2Y3pFU1ZyRWdiZ0RnSkNCT2gzLzJrQkdM?=
 =?utf-8?B?L2VIQTNtREkzbmI0T3hDUEJ2YzA4dC9OSTZQUi9XVXpwNzZNbmlGN2dVajNh?=
 =?utf-8?B?dDF4Z3g4SjFaZTFyMlpJdG5Cc2xYS2FzVjdjbFVoTndlQ2xka1NlZFVwRnZ0?=
 =?utf-8?B?QjMvWmFXcTFwRENWMjRGSHdMVHNVbFlHaDZ1VWgxVUlobFdSTmtqMklPRzM5?=
 =?utf-8?B?U0YzbnAwRVh1VTR5WnJHQVNiUzRSb3NGSjdWZ295Uzkrd0hwKy9OT25hMTg2?=
 =?utf-8?B?VEl3Tk1xWjdSOFVrcEcrZ2s0MnVPcnlTcW45WW9qRGY2YTFkUVFkeUVkeVJp?=
 =?utf-8?B?Q1JIMUFDL2VSNkRvdVBRdkJxZFJ4Yit4Y1RhdUFJbzRGRmppVEx5YVN0WThu?=
 =?utf-8?B?YWRaNldaMWNwM1RWcVQwaThUV1B2NDVrVVRuNW11bUFhNXhZZkhBTDZZVExi?=
 =?utf-8?B?MnBGNTMvS2l1aDYvM2NLU2o1OVF0aXB2b0JrRXdvZTgyYUp5Q3ZRQStNNUdI?=
 =?utf-8?B?enI1R0lRUzBpSzVuQWk2dEVyYzFScXk1cGRoNWJXdE5uT3VOL0NGL3dFNTYy?=
 =?utf-8?B?eFRWRDkrekNQWk1WM2dCMmtkQUE5SlhpS3l4Wlg4VCtKMjRudVhMdXVaeVht?=
 =?utf-8?B?RE1HMW5NYmJ6TmdnN3FNUHJDMmREeE53THNhc2U1TS9nV05vZXVoVThUc3Rv?=
 =?utf-8?B?anZwOXhrYmozdVZxeVJXaDJ1ZHI5b2xRSnpBUHFHeWI2UlpBV3EvSngrNmJQ?=
 =?utf-8?B?VWlTRDlCQ2JoY25RWi9xVTVxRmtKZTNMOTMwZUxrOURPbWRtRmxIeGVvOUhr?=
 =?utf-8?Q?kFi4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf4eecd-32f4-41cf-5a91-08ddde98a2f1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 20:48:50.7933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7pcREHuQLC3lPLsxBRH6mlRKojHQh7mmbeYGb8X2BV53iSfLwFbplFJPYn7be+JsjV+TG6vm29dCII3yEAt6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9009

Remove redundant #address-cells and #size-cells for ethernet-switch@1
because children node have not address.

Fix below CHECK_DTBS warnings:
  arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dtb: ethernet-switch@1 (nxp,sja1105t): Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/dsa/nxp,sja1105.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts b/arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts
index 1ea32fff41201b7a787dd116eef675318861ad19..da76566f3510ce866586a214b4df6992e5fc4843 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts
@@ -40,8 +40,6 @@ &dspi0 {
 	/* ADG704BRMZ 1:4 SPI mux/demux */
 	sja1105: ethernet-switch@1 {
 		reg = <0x1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		compatible = "nxp,sja1105t";
 		/* 12 MHz */
 		spi-max-frequency = <12000000>;

-- 
2.34.1


