Return-Path: <linux-kernel+bounces-793768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 720F9B3D7FA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 05:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21BE18994DE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 03:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD482144CF;
	Mon,  1 Sep 2025 03:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HjINXD/h"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013067.outbound.protection.outlook.com [40.107.162.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C89B1E503D;
	Mon,  1 Sep 2025 03:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756698723; cv=fail; b=CVnuP36bi4NQ3lRobwt1TPO9Imq89jivt+zZliBR32soy+YOY349PCVRLiU42fAjuMHXjxxPklU0LsxxYBTLP/VRmf8xV/GujyFdHajaK50+alB4UQpfMTc+KEANlSk4UlnYBhgiJ347n3ytGqQciXTLpOziCKoNoTdHKSGXGNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756698723; c=relaxed/simple;
	bh=TQYLbG73dDBUkiTEOWbDnudQLD4nGUEnxq5IVrsYTiM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=UeB6pHFn4iGotdONkL6Mfw3Qhs0Km22w9gyHC/8JCEp0tw5WGBTam5fCi/zaa4rS2QLV/50e0WdWMLgs31WAwSp0AXRZisLaY7TGw/bO3mWXjKSrCvAFLi4OD7Zz1dRgkeEdCwMS0F6Ll/7JzegEdVyPEYdiLZDedPEEWFPdoo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HjINXD/h; arc=fail smtp.client-ip=40.107.162.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlVuGxC/ZFAznieVgHnbP0Lq2Yk76pViOa6ht68WPl4ix/QST/CRLbhurOA/cCbNeiI5ZugjuUNlmWH3/AxwoCkcLxh3YzeVzTaY3ET4wdPP0uUeoVe2Jpnho+gqwXcqoTlhfFKbENTy60EmIjnl76ov8kolgsqFO15sv18EC22xPJzba5PAEYsYoL8EbnOI6qdBpXeqyOqrfa0dFVHgbsVdIONHf9aVsViqwSH7c40Em935BSx70IfwZQjTY55rRCFtUsUIblGL0IXshHSjO4FxkG/NXmd18VZivwDVFQingh1sR3d6McSMcDcUZ94F06C+ahIetT5GuhZwercKjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36/6ifiGsycJxs+btfARiMcLFILeVf3Y5xtot8GkO4c=;
 b=RCh1Mt1Egd3uti8BqZpJZHg17hvt9E8KWKMaLfXXb62j+pd2oDnfmNFNClokXsrcMd64AvUwh8nL/cPg1bowtV/DK5K+mhls+j4yXfYLj/Mup5HA8zQY+zdfzRi3UAGQoWNv7qBarcpmHp8AiZwRBSZk0ohu9HZtWrPKzLak3lD8SZvHs/Whr+dPtUic0B0MuDbQV7RpKK7cPFbx8DxKhvBcJIMEpoE/aaTnZsswUGKJZxg6p9cbOfLYWUTVxgLDIPtPCxTQxu0+RxRId03LaKP3DM7EKqo77JjTPW0ZeUaOYN8EEjKL4KUw6YA+Nc1TyV/PZd1vyQLsanpQou+Q1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36/6ifiGsycJxs+btfARiMcLFILeVf3Y5xtot8GkO4c=;
 b=HjINXD/h+5qgo/WIeicLetGtk2frCE2aRbzsxqaSOPTzd6YIDtinYuwfJGzMNrsAVOMLx7s/rURKV+b+WLuwf9wu8r8uelC8Bi0dyU+kuF3f5FsNwBHYYfk6y15UxZ+iaLg8Udi4kwqklFleKlijO+nZpLGivdDgJMu+uEPO6f/njz47Pf4e+pkTekJ01ICdCDDP2U3Gv+lFTiUZtbAjFOqKTZpTysCd4HFW01GuNEZtxagYMV3KEg3YYQhq7lmP1tj9WRBDohFAxfFrKapVkfSvYtXxy0n0hnDau8m+7GdOoz6aD55KKaIPSWtTOTRkX9djba7kO3rvRBJChJcjGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB11358.eurprd04.prod.outlook.com (2603:10a6:102:4ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 03:51:58 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.015; Mon, 1 Sep 2025
 03:51:58 +0000
From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 0/3] clk: Support spread spectrum and use it in clk-scmi
Date: Mon, 01 Sep 2025 11:51:44 +0800
Message-Id: <20250901-clk-ssc-version1-v2-0-1d0a486dffe6@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFAYtWgC/32NQQrCMBBFr1Jm7UgSMFVX3qN0UZMZG9S0ZCRUS
 u5u2gO4fJ//319BKAUSuDYrJMpBwhQrmEMDbhzigzD4ymCUOamzNuheTxRxmCltXY2DY8uW+O4
 vFupsTsRh2ZVdX3kM8pnSd3/Iekv/yLJGhY7YKjbKt626xWU+uukNfSnlBwQTgMauAAAA
X-Change-ID: 20250812-clk-ssc-version1-acf6f6efbd96
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
Cc: Brian Masney <bmasney@redhat.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756698713; l=1919;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=TQYLbG73dDBUkiTEOWbDnudQLD4nGUEnxq5IVrsYTiM=;
 b=afk2xRJD4radREQss4JojguZwwkkTSfTTCBEXKO/nMdMYFVNJw+sFugt+oLAZJ8AcucmxM5qp
 YMeClpmBdriBCO7UWMnq9+sregr6FW0Nw1nHFVkN9L+mTKvuFeWbdGG
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB11358:EE_
X-MS-Office365-Filtering-Correlation-Id: f5718e2e-d20f-4a78-aae9-08dde90ae6ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVdPR2JMMm56VExpcjc0RVdOTzRwQkhTWHluYjh3RDJHWDh6cm0xWVk0a2hV?=
 =?utf-8?B?ZEdudzdUOFBaMER4VmJ1b0dKazlwSWRrSTBPWm9jWjdDemo2a3UwNkpoSHdk?=
 =?utf-8?B?emxoRWlxdHE3cFUwSGxtbEtDNkZJTnUyMDI3ZThFNDU1dGxJc1MzUXo3VGZx?=
 =?utf-8?B?ZnJtYjU5UURQMStUbm1NK2JtRG5kYzl4Yk1YYUQ4M2Y4RDhVM0RLVUtsamdB?=
 =?utf-8?B?RTZsa1ZxMDd6Mk1OMnJWVGJsNzVTelhNKzEyemlGZEhUR212QzVpQ0orUG40?=
 =?utf-8?B?WHBOT0NwNFVLb08vTHdCRHNvSWNVdkprSzdkbVlJckZVNzBtcDNTeFBRL0ts?=
 =?utf-8?B?c0d2cCtxZHhUSjgvcDZPQnBoamltU2ZmTkd5ZkJIZi91MU5UVzBoejZoV2N1?=
 =?utf-8?B?Q2E5WkwyWWMxVkZuN0J2RjlqR1I5WjFHS3AxQnRXK2xvN3VsUVNJYU1VSnp5?=
 =?utf-8?B?MW52dGlWYmI3K2RNOG1yYkZoZEFScnlJazJJWldkWEJ1NUc5dGZiMER2c1Jk?=
 =?utf-8?B?RkxHbGFMdFgrUU1WbkZVMDZ1NUsrdTNNZTIvbWZqd1huTlAvMWRMSmpJZzJi?=
 =?utf-8?B?d1RVSGQzZFdNekhYZ2FsK2plOVNiUEJ0TkNTK0xibUNVc1dhUXo2VVV2ek5r?=
 =?utf-8?B?K0Q0QnZVNEdwUHk1K0IrcHdpcHpKdUJ0ZVgvR1VDaEY2dnJpWjVhc014enp3?=
 =?utf-8?B?d0QzV0NjT1h0VGcrNkRUczhiamlha09URE1rNlVxVnRoWjVQTWUxNVIrZDhl?=
 =?utf-8?B?eXFwRDhNUE90YnBIcUZIL09jQzZDdmpFVnloS2VDY2RuNjNXUG5jTEQ2dlor?=
 =?utf-8?B?c3loRm0vc252ZGRXMThuQ2FHdUZhbFNrVWQzcFRKSVVRRXN0aElyQ2Y0dVU2?=
 =?utf-8?B?a0ZTT0R0Znp4WUFCUmxpMGRPSUNUdkVRQWJQWDlwcU5QT0ZQZmNIWWNVaDFw?=
 =?utf-8?B?VEpPeDRmY2k5NTF5NTB0bjRiUE1kVkJZZEI2ZkhXUS9GcW8vSUkvRlZiOWY5?=
 =?utf-8?B?VVpZYVJwb25Ib050WXZHMGZlL01VT25VRzVNL0QyR1d6amFvR2pRaVI5Vkdq?=
 =?utf-8?B?eXVLaUhCamZ5QlhnVGd2aW9iZWc0N2dwcUZNNzRIakpvU2ZMT3NPNGdwaWU5?=
 =?utf-8?B?MnJKS2xXelI3RDBhV0szaUlZWC9lMlpQWEx5YThXRHlJN1ZmOFB6bVdKaERk?=
 =?utf-8?B?a1VCNlk1dzZzUG5vejdOMmgzem9rSFZlQkV5dmhsR2ExZXNabGFHdjhObGtH?=
 =?utf-8?B?S0hhWHlEWU5pNExGQVNvc0hndTNqWXlBWHdrLy8xN3ZRRmlCemlzS2llNVNV?=
 =?utf-8?B?ZkZRckwwVXNlTUtNY1FZWFlXUTJTYVJ0clNRaDh6NnRoSTQ1WnJTUU9ua0ZF?=
 =?utf-8?B?YWxDY1pSUUZjbkluc3RMeWFwcGZ6OWo3d3VFRmp1T3VNN0g5eFRjVjRxWlJ2?=
 =?utf-8?B?U3dUaGpaTExoa08yMHJPTUxIY1NFS3k1Y0dvRGg0MDB2S1o3RmptcDlZZjE0?=
 =?utf-8?B?NVRYeE5iOEVodFM1Tyt2Vk9rTXc1RkpMV3lrYjJMbThadEFaNjZUelREZmJN?=
 =?utf-8?B?QU5qN3NOajBRVFl4Ty9DRzR4M3lMdzhpZi9CTjA0Nittc2JrQnk1KzRvTXZw?=
 =?utf-8?B?aXhCc0pia3dheldRUHhhcVJSOWlkWlRIREVibU5UVFVPQ1VXWGJXU1RNKzU1?=
 =?utf-8?B?WlR1c3F4dmZwaUxwbi9tZXhGdUFyT0x3a25yTGc3M0RYTFBWVDFydUpLbnVQ?=
 =?utf-8?B?SjRTd29SMEtDeXd1QlFIK2JpcmgrbU15ckhCem5iUlVoUTJKakpRWS9jVlhW?=
 =?utf-8?B?OGVlYWFUbnZwRnYzbDVHbk9qQ3BVbHFwNVpJMDJvMk01d05jM0Q5djZxZ3Ru?=
 =?utf-8?B?ei8zK3pDTlp0MEtTZTJDcElieG5yUkc0amw2NU0wMy9qN2R1QkZrTkNFQm1J?=
 =?utf-8?B?a0xPOTB5VTN5MnNyWEczOUR1UFVjVi9JRTliOUMxQ3hUNXFSVXNxUE1KcjVB?=
 =?utf-8?Q?a6zYlHo2fnEFT+ju3zam0tRybb0tls=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUM0OGlVdDh3dGFFdWZ5MzNYOWlNckFoQnI3aEQ4VytVZlFaVmZVNXQ0WE9J?=
 =?utf-8?B?L0pEaUdIQjVoRUhqVnF2SzFtOG5ibWJjVUpNMkIxN01CL2crdW05Z21RM2w4?=
 =?utf-8?B?N3B1TW5kV3MvZUhnZ1QyYVVYYzRudXBTTW5SNGJWbFNHOWd1RkZIN3FJNk1Z?=
 =?utf-8?B?RTlxTklFMWN4QkFUaWorNWk0amVIamdQc3JTbFpyRUdGeS9KSFdPSUxaUkJ3?=
 =?utf-8?B?MmVISWFCemkrN2NFL3BpczVud1Y3TFVsUkxCSzFrcXdDaE9kaHo5TmtmWThH?=
 =?utf-8?B?NGJ2emFMUy9TZGpNN0FkMkhaUmpTMDJRTW04K2JYR3hrcUhVT1ZURjRwd0h4?=
 =?utf-8?B?VTJUOENseGFwZ2hjaUxtY2l6SHpNbjk0NEI2b1FaVWU2b0RDcER1SHkrem1Y?=
 =?utf-8?B?Nk5LdEJiU3Ixc0pXNDZnQWxsK282TGUvbVg1bHI4MXhGSEZmOUp2L2h0dStw?=
 =?utf-8?B?N0xkeVRZcCsrcDBkaUdOa2hBZU84WUtrYXRHdGtpMkZ4WDMrakNZWFNDZDVR?=
 =?utf-8?B?NFJXSjRzWmxJTFBFbHhBaTlscFNXanZ2WE0yV1gwN2kyMytKNzYwWDd3V0Z2?=
 =?utf-8?B?eHpIcnhvMk9QOS9FNlIrOHRtRm5XUEZqTGFES2JBWlN0OTNIbjdKWUkvd1Nn?=
 =?utf-8?B?dFBZK05xQ25qNnR0bVk5UlpmN05nQUViajRTYmQ0MkthWnp0MVVUbFFHT2ds?=
 =?utf-8?B?QWc0bDdUdHRlY1c3dnVPQ3V2T2pkMWw4Nll1NXhGSzU5eW9BSjA0WUlDdW95?=
 =?utf-8?B?V3N4MmVDeWtNSkJRM0JlOGQ5aVhBRUw1UUF6NHNPb1FmTThtbmhZb2pKeFVE?=
 =?utf-8?B?QnVWdGREUms0ZnBCUlY2RXZKZHl5ZnljRm5XMEdWOTNPSUNscC9Wcy91SEsx?=
 =?utf-8?B?Qks1THhXakluaVlRYXNwSUU4dVp1WGZsWFNmcXJVei9zbWlzVkREcEp4N1lr?=
 =?utf-8?B?WVBVLzc4Z25uUzd5VXhTTzRoRWNHRXYzVXl4Y1BaQTliOTZ1N09tZ29NU0hD?=
 =?utf-8?B?ZEFxSlErZDhhNnVpSElOYmZ1SFhKR3FUUDhQSU0rZGpRYjlXTnBybGd4ZzZI?=
 =?utf-8?B?QXh4QzEzb2g0SXRoNS9qelBOUzdKRnJGL2lMTjhvSVVDUjZkWnNiZFREQjQr?=
 =?utf-8?B?UXFBcDArVGZLVHBjQ3ptajBsWkdDMUNlSmFyK1M0UXpOYlhDSUZ3T1Fsb3BZ?=
 =?utf-8?B?K1gzRjZOT1A3d282eGNnaDMrdnM5ZWhqSWJvbGVTYVEyaU8zVGxZWngycGJF?=
 =?utf-8?B?K1VqTGNXUWE2RHowWWV5bUoyRjQzaHZHZ3FPOENGNFdzSCtNaERPSTdMTHBh?=
 =?utf-8?B?OVl0SWFIWk4wMVNRN3kyd05lSWVhWlkwR3lhMVc5QktBMU9hM0pBQVNnVHVQ?=
 =?utf-8?B?WWJUdDA5eWRGaEJMK0hjRmk5czJRNDExNUg2Q08rSGVuMXFHWlpHWEhVTG9G?=
 =?utf-8?B?bUxrL2hYV1cvaTBlT2lDSVF6dk9aa21XcjMzSHF0ZENsUGpzQk5sNnVYeFUx?=
 =?utf-8?B?UzJyUVVZRm1PRGp6UkVQSnk1dXEveFZJbTQ4eVlHSFRDME9Ya2ZQRTNxNmUz?=
 =?utf-8?B?ZklNUEdCcm94RURtNHZ3Q3VMcXBwRGNGS0oxZzhmZGVneEcrL0duUndpRGtt?=
 =?utf-8?B?OVpqSVpqRm5IRWovTUh6OXNKSjlITmhneU9yZ25tNVdUbTFlUmJvdFZ2VVQ3?=
 =?utf-8?B?d2lEYmtFYUFkQXhjUVZ4VmtmSHhkN0toQ1hUNUNnSGJCdmNBTFgwY05DbFZK?=
 =?utf-8?B?dWRXV2Rtb3FQSTBSbVI1V3JkU3ZiS0xqRjNZRG1sMzFNN21OOXdscjdudTdT?=
 =?utf-8?B?YzBpYWs4MU1KaVJTS1NhMHhGc3B2TDFMZzhkdjRieCs1clVpVjNaWHlhQVhL?=
 =?utf-8?B?bXc0WDJ5S1E0K3FtTWxpbmdyT3p0NW1CcWRhcjZjaTZoT3pSQ21UMFpxZ1dp?=
 =?utf-8?B?bTczRkpLcEpVQkdKenN5MTFIdENGcnBsZ3V4aFZSUW5GZHkzUkU2QkdxNjdJ?=
 =?utf-8?B?Y1c0eGx3YmQrRFAwVWhNMmY5Z3JtajVKVzgwUWJzTlpocUMrb0NpM2ZSRDFR?=
 =?utf-8?B?YXNtVUs0SlhSN2V5a0JDRUFpS3lCd2NmZjNEems0ODQ1MjhPejBaVklzT3dr?=
 =?utf-8?Q?lUDyz4wGRMsSns2hwqCSTpLCn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5718e2e-d20f-4a78-aae9-08dde90ae6ae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 03:51:58.7777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xYqz83BMdQymML4wvtZ1nP0evUDnA1YvwxDZdVwPPpYJ1P2JmImh8gyH2Dxn0WHGy0BV5fZBAPs9Rq1GAFYYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11358

Since the assigned-clock-sscs property [1] has been accepted into the device
tree schema, we can now support it in the Linux clock driver. Therefore,
I’ve picked up the previously submitted work [2] titled “clk: Support
spread spectrum and use it in clk-pll144x and clk-scmi.”
As more than six months have passed since [2] was posted, I’m treating this
patchset as a new submission rather than a v3.

- Introduce clk_set_spread_spectrum to set the parameters for enabling
  spread spectrum of a clock.
- Parse 'assigned-clock-sscs' and configure it by default before using the
  clock. This property is parsed before parsing clock rate.
- Enable this feature for clk-scmi on i.MX95.

Because SCMI spec will not include spread spectrum as a standard
extension, we still need to use NXP i.MX OEM extension.

[1] https://github.com/devicetree-org/dt-schema/pull/154
[2] https://lore.kernel.org/all/20250205-clk-ssc-v2-0-fa73083caa92@nxp.com/

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Simplify the code in patch 2 per Dan Carpenter and Brian Masney
- Rebased to next-20250829
- Link to v1: https://lore.kernel.org/r/20250812-clk-ssc-version1-v1-0-cef60f20d770@nxp.com

---
Peng Fan (3):
      clk: Introduce clk_hw_set_spread_spectrum
      clk: conf: Support assigned-clock-sscs
      clk: scmi: Support Spread Spectrum for NXP i.MX95

 drivers/clk/clk-conf.c        | 69 +++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/clk-scmi.c        | 64 ++++++++++++++++++++++++++++++++++++---
 drivers/clk/clk.c             | 26 ++++++++++++++++
 include/linux/clk-provider.h  | 26 ++++++++++++++++
 include/linux/scmi_protocol.h |  5 ++++
 5 files changed, 186 insertions(+), 4 deletions(-)
---
base-commit: ef1ec3476bc4f1db6c9da36d66d9f57bb0d02734
change-id: 20250812-clk-ssc-version1-acf6f6efbd96

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


