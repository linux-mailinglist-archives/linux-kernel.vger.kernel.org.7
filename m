Return-Path: <linux-kernel+bounces-868267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFF9C04BBD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 25C4034BBC8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2872E88A7;
	Fri, 24 Oct 2025 07:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P9vIJ+Aq"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013026.outbound.protection.outlook.com [40.107.162.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B462E7F11;
	Fri, 24 Oct 2025 07:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291160; cv=fail; b=dBUjRHZTBuAubuIi9qoLA+r62KfhN7ZnBJbcrkz01KKr0HgsHS6Ka3OMF1Dbw/kssxFROKnoUuWGT5TZ1u3iebqIl2HSpXpIgbgshBBKhD30r44QCF2l98DtjlQIWAranWrZm1PsAXCJpkoP9T9IhG8dL4fmF9gpn8k+OlhLhac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291160; c=relaxed/simple;
	bh=bfUxtm9qwWgahWzzvOCAZCzVjDqJU+HizgoCK8tss1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I7Q9QqSMmIIwKbHHa3SSNGDLwU9MnWnbD0sn9dMvzrq9VLpGYbcSOC+a0paXqZiraB6Ph1zL5E8ij6EjnoLQwlP586rVBp9mgsq9XeF00CgtUQjSdjqakmeAT5fq+nSNGAioJxeUWgcKZjE4yOPJDPx26l3lxT2buYZfnmaw9yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P9vIJ+Aq; arc=fail smtp.client-ip=40.107.162.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzs2ijyVbPPzTskUxsjfjwpV29JpmaJLL7U5pVgwdCtC75mCILlp+JtfZ+7C5LJdVvKq4q0w1p8wFpfEmU8C/A2bDCcIXPD5i06w+s7o/hZ80c8b/IOhk8PGWN0+DYwsaqSP1w906/M74OxMVAdhE1lnTWdgT/iHm54Ssl4isHlHqZWCXTZtdu+Q+8LuttJy0xrspQiLZeA6hEFz9rf0kbRwXmqz7hzcTN1XAyj69LMF/7ecwHwVeFIGzW7zd134w6W8DgycXB/34SagY9mFVoIjMjVEXcXLeFFdsd3TG14eKSoebocHT1XKww7fjmYFjsMvPVF7HBf6jhIJ9R85LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YH4NouuZrYDfMOwKRckV9KTvADpYd8iqqjbVRnj9jbc=;
 b=YhshDVFHMD6OyOwHb3+n86FzppUHSwfGteYjjsRw78TMg4ietSgKay+Zaq9sODN6jXM2mUJAR7KzC/34zkBr5+10gZVGh0F2pd+IZcIMnZ/RzvaTCuqUpRyAFoyvUcEyDTn9o98fwxligoM9trZPO3hfkSC9BvKJy+ZXx/qZUypkdQzAoaXLLQrLvkP9lsyj0ubqcDqKco9WFEfjYdpfJIjCq185c7jCmQ5uD/+6lNcP99ipdHyBPbKwQItBJsogsEHiDKWv4s/X2D7h9U9kunL+jlT1B9XsfXNrRXOdMPumZjzLMXLEMtOAvve6gkowDWBpOVwj7kHw3JUuPN0gGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YH4NouuZrYDfMOwKRckV9KTvADpYd8iqqjbVRnj9jbc=;
 b=P9vIJ+AqG2aXdvD/EUFwI1Au0HpODSiPG9lR/s670PLN+eB3SUabKAHJSfRwmlqgMAnAJU1wsOGweAg0vsQ8NaQVXuslmVMBxwP35IJq3jxbwssFExgAZYsL66HWPX4kypHnvpMUwPfICHtBf4jMUItBil3ZON/CNTORl9kO7eb3IYZX2YVbrO2ed+MFKXls2laNoXrksUyXpdb6knKYJG//GGSzGVmfb6ua2UNKYUIwpZ2SO0FTSKD7Rpq0JI+jVkWcLydjf36rPJ72nze3pcWMllXaHYzeSGq3C/k9mxILVzqhRXNbYx3hR0W7uOX7ZBy8TojMYhdjm0kcoO45Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DBAPR04MB7432.eurprd04.prod.outlook.com (2603:10a6:10:1a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 24 Oct
 2025 07:32:36 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:32:36 +0000
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
Subject: [PATCH v1 3/7] arm64: dts: imx8mq-evk: Add vpcie3v3aux regulator for PCIe M.2 connector
Date: Fri, 24 Oct 2025 15:31:48 +0800
Message-Id: <20251024073152.902735-4-hongxing.zhu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0ccee832-be44-435f-67fa-08de12cf8076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHBKc2hKQjlWNkE1S1NkL01mRTk4WExxUzNtQ0JNWVFFODlrUlNHMDlKVWJW?=
 =?utf-8?B?RXRCSHdjVUVwNldUWDU5YUlNZXB5d29DV3VTemx3dzZWbTR6c1pnd0MxSlJY?=
 =?utf-8?B?OW5Sb3pNaGZaVW1xa21IQWNuMHA0dlYwUWwyeTdzT2cwNGQxZEtPY3Z0dk9l?=
 =?utf-8?B?MEd2OC9OMklBcmpFcDZCV0tPZjFYYlNsb290bUlqTHFDMWt4ZTNVSHNnQWRx?=
 =?utf-8?B?MTZsTlpSajFyNEtkWUY4WWZNN2lPRmtoeXpWZHJYclhkblArZFI1V2JSWVFt?=
 =?utf-8?B?d3FQUXdDaG45MG1kcXBJOEVJa0FCOEozVzBqeXFxKzNQZUU1MFBEQktmODZz?=
 =?utf-8?B?elBEMU9scXRaMzBPT2RGWEVNQkFPdnlSUXRXYWx6NmJUODg5SWlUdDc5b2JJ?=
 =?utf-8?B?d2NDdmhYMGJtMWo5WlVWZ3dIY0N1b29XV0xUYXNnSUYvSHlubkMxeVhkejhS?=
 =?utf-8?B?YllJcSttdmd6anMwUFR1b1ZmUTlmRVRLZjR5Zzg4OXlLMlgvTVlrSmw4Ymds?=
 =?utf-8?B?N1d0djZndkM4RG9PWnVZRlhGL0ZCc2ZvOXJEVU9qNXkybnV0Q0hUNnZ2eVZX?=
 =?utf-8?B?d0VLK0hId3ZDUUFKNGphSlUxdExZbzBxWTNmN1lnVmx1SGlUUjdRL0xCdlE0?=
 =?utf-8?B?a2l0ZmpsQVdpTjNZM0g3OTB6UU8yYllFQjg5NXRYand5cFYxak52MlJHTFFJ?=
 =?utf-8?B?aEpvRGMySjc5RGh1L29sblhNRkZ3MEpzOEw3VXY0UFRLeTRWV2dlV3g5Qnow?=
 =?utf-8?B?KzhVaTdQZ0cydVVHTzIwUndIWURTMkN2alE1SDluREkrV2hOa2FMWktqN0hi?=
 =?utf-8?B?UXdxYUkvVlI5ZldGa0wySnFrNzlJWCs4ZjZKMExvaGRTcEZKZE1wYW9jY1p1?=
 =?utf-8?B?QTRqM282bkdqWU4zYmNmdWtKSEpTaXpFNXNlbVg1NXhWbU4zc05na2R2RXhv?=
 =?utf-8?B?WU5NQVlqVW5aNzNWMnJkaGVtSm1aa0tGR1V1R2U4WVZCdDlTLzBqeGNIN0hu?=
 =?utf-8?B?c2J5YUtieVAxSXpmSHRzUkNCUFRVaDlmN0ZNbkhLcWhDMVoyaUR2NE9jTmpi?=
 =?utf-8?B?TVp2dlZxYU9MY2RoUGpZQU1CUFppek9VaWlzSkQ4SGxRUnF6aDEwQmtSanlI?=
 =?utf-8?B?dzdiWndnZUozYmpyNmhJSUZSUzhxM2hIcjVTZEFQdVV0TmZ4ZFFKTVI0ckxI?=
 =?utf-8?B?cE1uYUQ1b3dRbUFJaXoyT0p1SUlHMmxRSm9CWklUK0FSbVBhWGYyYUhqTzZE?=
 =?utf-8?B?Q1dlNDlVUzlnSGg5QXJ2M0w4TUpLZVNrcDhXdHVyVHBMb1VNNkpPWFVWdzAx?=
 =?utf-8?B?Z29vNy9uSjhlVUp1TjJIdXRCQm5YQ3BQK0xITzRvL2tLQ0xGa0d1amZSRXU2?=
 =?utf-8?B?eEVoVXBwbzlaR0VhcExuY1JnWkxHbllNSFczM0wyODJQVW93djJKRGF0SUhK?=
 =?utf-8?B?Ynk4L0ordFRqNWRZZVNoeStReGRZbFlvZXNKT2p3NkVicTY5bUlTTlhrVXkr?=
 =?utf-8?B?MU10bTNPVnJ2OS9ISC9MR1huQS9aNkJDajdLZUdSb0MydEF0TURjUGdHdWFQ?=
 =?utf-8?B?dnFyR051Ly8wOUhHU0FJNTNvVERSQUlnaVBxc0lOU0wyRXNZZzFpSERMdmU2?=
 =?utf-8?B?YldZTVo5UVV3NW5mcmJORFVFcWxmdE82T3ZqeDMzMWRXS3ZjSHdrOG5TK2xC?=
 =?utf-8?B?eEdmYjhsbDFnY3lDcW9zRjNja0lURjFhM3FQNURYTUt5RnRiUjBCMUtscGM5?=
 =?utf-8?B?dnloQ1B0K1pXSDlBUDN3TkplSllweU9Kb3NpWllCZVpraTQxQjdqM1o3NVdV?=
 =?utf-8?B?R3pGUlc1bTV5UG8rTFpTSlRVRFBxbUJMeGhadTNQS0RuRlBuNFBUektRUExP?=
 =?utf-8?B?YmUxUGxBYi9IU1l1Y2FmZ3BmNDRyaGpLZ2J6amNKd0orM3h4Qjk4Ny9aUkN3?=
 =?utf-8?B?SnFkNUFNUVloR0lRZm1uYnBVSk4wcDVydXVtZUMvZXV1V1c0cFlYV0tqbmsv?=
 =?utf-8?B?MUd3YXp3TTB5Vm1tWS9KZkpUVXJPeVIwR2FpRjJ2WksyUCtOUVc4M0o4VGpL?=
 =?utf-8?Q?0I0XDp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXFYTjh0YU1Ma0ViTmVnNDVYdGVja2RGdzdEMXJDcE9BYm1pODRuS2lKSUpk?=
 =?utf-8?B?aWlEelROaXlWc0V4TkdTc0w3WkhBa0NkM3dQU0ZKUmcvY3NiemhwcTI2Y1Vn?=
 =?utf-8?B?QUxXbEJxaVNwSkowTGt3TXA2Z1V1cFdnNEhOS1dSOHV4Z2NMZDlnZ1FVbVlD?=
 =?utf-8?B?bVB2bFQ5RWhIaFVoOS9xRnYxbnQ0T09DeXd5elh5YjBIcmhESnZ6am5jYjRM?=
 =?utf-8?B?ODkwOXkrZlZhOWVnbVRyUkZsUFErVmRudGEySWtpdGRxL01uckJ4WGs0RnN0?=
 =?utf-8?B?WDJYQTBhbHg0SzEzWnZ0MDJyZ0ZlMktQQzc1L2hNclVCK1JjSmQ5MktwTGp2?=
 =?utf-8?B?S1ArL3BpKzJzYi9WSW5PaVA4QU4vYk5OZHdURCtrb3lucjI1T0RQNzhHL0o4?=
 =?utf-8?B?WHFJV0ZTOHFha1k2SEI2ZkZPZVRkTldUenhNUzFDK2YyUC9adUNUT1VNWG1n?=
 =?utf-8?B?dDQ5Mkh5RGRQS25wby8xakdqNUkvRVhwUkl3UlJMOFFVUUFzSC9OM0k1WXAr?=
 =?utf-8?B?cDVxM1AyUHpVQ28vK3RydnFub1VlOWlzUE1DdE1oNm11RnVpbUdvcXcxY0p2?=
 =?utf-8?B?QnlyUjJoVjJ6bjdJa25oZ2dPY1l6alhVMWV1VFJtdzFtdVJhdHhGNDhtZk5l?=
 =?utf-8?B?U3B5Z2cxZTd2V1FXRytINTRiSnJpdU1jWkczbE9MaFAvSTBwWFl0Z20xVEgw?=
 =?utf-8?B?VUI2TXo4d3ZCbXMzQ1N3a2dSQ2tzUExlWWNFMXJUMHl6bDN2NzZpdWNxdW1r?=
 =?utf-8?B?RGZENVA2aFNtVElPdnNFUGwyRjlCTlJOQUIrenRyUXp6b3BaM01OSEFVVnJR?=
 =?utf-8?B?a2dWU3N6cExPREwyemh5SzhxR0ZNUkxpR3VpUEdzQ2FBaG41bzc4d3lyRFYv?=
 =?utf-8?B?UmZmQzNNQXlIa1dKbXpXYmxiRllBbnBSTzBrRzVra0JkQkdQM1Y2eEhhcGJI?=
 =?utf-8?B?Nk1ibkIrVXVRcDhnR1NVdG1Db0xVS2tyNVhvK1ZlWDh2aXhDcUtmMnlDNXZT?=
 =?utf-8?B?TDc3ck9odGx3ZXBDQW84aWhLTVRsTzdpclZaM0tGU3RpVW8vNjF0NHRpWVJ5?=
 =?utf-8?B?cjFObWJNTUNIRnljU1ZSUVVjMFJ4aXdPT2R6UnMxSDFjLzdCNFByNjU3ZTR2?=
 =?utf-8?B?VmIrQVk1MUt1S0dRWHdsc2FMV3lWdXVDbTV5UCtEdDRxVTVkWlo2a1VyTmRZ?=
 =?utf-8?B?dUlVTWxKTTQ5cXFuMlp1anZGQlEyR2p6YnVqVTZFKzJTdDNVZ1oyUDN4SUs3?=
 =?utf-8?B?OWJzZHAzRVhxYmtjeS9IOUhoL2pNRUZNR1RJS3kra0o4Y1VaaDVQbkhWTzNC?=
 =?utf-8?B?TExiTnRuUFZHWlUvOGY2NWlxNDNROUljRVhpYmVrUUh4NWI2YXRmSVV2NVNF?=
 =?utf-8?B?RmZXTnZReWxCYUwyRWd4NEt6a0h3V0lISFVoTFJKNWd5dW84UTBNYzFhOFM3?=
 =?utf-8?B?amsxalJZQXJkRkJmRWJWUHdMSkF0TnF3d2Qxb3lqWXplNThwNVFNS3Z5K0Jn?=
 =?utf-8?B?TiswT0ZHUmZyWEc2bGc0M2FPUGNtbUQyUzdEb1BhbGZCVU53SnpsQnNUY2c4?=
 =?utf-8?B?V3pOb2tNQzFsTFhaQzBPUmVvYjkwd2ViaTZ3WnNwQ2NpUjNNVmQ4cmV5b2No?=
 =?utf-8?B?T2h0ZUxRV1FGbWY5eXJaMHRNcDl3VlI1eTM0MVhGTmk1LzQ2Y1p4SDdadlBD?=
 =?utf-8?B?SitMeHNFWW1qMEh4OUFqZEF5VnBoUncremc2TUtLZitqTHhZbE1BbVNIdE1H?=
 =?utf-8?B?RzlWdUJJcHUycDJFMVpWN21ieC94MU1QQSs2VzQxNTR0NlRJQ3EwSzY0V3hE?=
 =?utf-8?B?ck5nenVpY29zS3BZSk5QNFZOUk10Z2FkSEJucmdGak5NSmNxMG1CYUIrNnNV?=
 =?utf-8?B?aThZUk1FUHBDVGFLQkI1eVhEdG9jK0g1RU0zS05EeGM3dVlvdHR0VFlkMTJi?=
 =?utf-8?B?MWRxdnowYmZRSlhSYWNPMWI1NiswU3U2czdWcnNTTFM3QWhuQnE1RDdCMXhS?=
 =?utf-8?B?Q1lpZWJ3aDR2c0NTYUk1UkliUjQ2Y0xGb0ZhdUNRMUVIUWhBZS9TaWVCeFVS?=
 =?utf-8?B?dTRocTlIT3pwT1ZUUXB4QTUzVER3MVRZMzdsMDRVVDlFV1RQMmVqTFRUVmtt?=
 =?utf-8?Q?fPXhEi72L3ir3XbS2hbppLi+m?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ccee832-be44-435f-67fa-08de12cf8076
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 07:32:35.9632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MO/7p27aPypl6XJlW7aA7PmMs6P1peZVunx6v1L7ZqxYFIf+4AF7EMqsj6G02h/jyrDwaKMrLoskoI/iVw8Scg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7432

Refer to PCI Express M.2 Specification r5.1 sec3.1.1 Power Sources and
Grounds.

PCI Express M.2 Socket 1 utilizes a 3.3 V power source. The voltage
source, 3.3 V, is expected to be available during the system’s
stand-by/suspend state to support wake event processing on the
communications card.

Add vpcie3v3aux regulator to let this 3.3 V power source always on for
PCIe M.2 Key E connector on i.MX8MQ EVK board.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index a88bc90346636..0aad853981761 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -397,6 +397,7 @@ &pcie1 {
 		 <&clk IMX8MQ_CLK_PCIE2_PHY>,
 		 <&clk IMX8MQ_CLK_PCIE2_AUX>;
 	vpcie-supply = <&reg_pcie1>;
+	vpcie3v3aux-supply = <&reg_pcie1>;
 	vph-supply = <&vgen5_reg>;
 	status = "okay";
 };
-- 
2.37.1


