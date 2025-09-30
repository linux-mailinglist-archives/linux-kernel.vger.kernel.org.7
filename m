Return-Path: <linux-kernel+bounces-836957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B185BBAAF89
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3863A814F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A6E214A8B;
	Tue, 30 Sep 2025 02:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="Mw15W6Ro"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023096.outbound.protection.outlook.com [52.101.83.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C1F86352;
	Tue, 30 Sep 2025 02:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759198630; cv=fail; b=s4hor9wlVFQnZFGVmmX/xZoTrisDpYcvSI6TIVw5c04xRoncTEdZ3do+MG2WJbMR9YZIyIwc+hyryjZq9LKl0gol2xVughVfFc4BXAe5KMrobp2cS//cC94XVnMla3cwrUbecRnghjNyCcH+NeSCJIS7NFOeGmyD4GjGN0C9w/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759198630; c=relaxed/simple;
	bh=fSA0F7hetIbW8m5lXq94EL12+PAByf2+AqaN88JnHuU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ITbTn7zqd6GobpfklbIPChxhwJ64b2pNkEpyJs8j+CZcYl9hC4n2JHZUEAKwZ+R7ZW61yWzgrRumWCXJsbjINjD5VY25esi/ipQJFvUm56QcX9yXjXY+pSW/u1fJAUFANALqYxVVlczmP+SiHrle6alee53LsOfGEOJ2AYY1CGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=Mw15W6Ro; arc=fail smtp.client-ip=52.101.83.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avImByO7GTxHNBYXtjxcK6C/0jc7/SZH/d2Yj/LqEa+6n76ZFiA1Gg99PbPfLW13clan+Cz8l7vS5x9MzyCPZ9IBewYeZOapOgVamvoIexzPvYIbCKAvyH++B5c7cOREE/gqpWj8MvBY/yGEPlBCXc+Wx1UiXP+PkjMDn6nG1RE5YwYSdPksw04LDEf4sOKvRFot0076xPm0p6TG2FPLkhdFft6DUOwBwTpmBVk5NeVxY7ynvB2x6Pc0y0Pv9lnL3WiVLqV08nLsXhlnPHgITWCYk9uNM3N1bFCVXCYwLTzo933OtBeugHs+OHUwJYSsjqKKkt+OsLNK9MCx5fIu9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUhOWAa08Glx6xO2OUXI26vY6N49eimIvug0g7tdt6E=;
 b=xeOOqHwPyzD4TgHq3lrf7+4xOYgeMfvOAMsiL3RQpwzbPBhEzdyrjaxq7OyvBOHnh7C4pjPVlvg13wStNcSORJRJCBCv8eiEt5fazymOSXEPe8ruefnSyp++9Q1puahgiI9CceB7v6zMdE76aFm75XxTGAuf6E2ciY3WaXJ4qtjRf9MYavjd3s2kBoUfnJcbn3VXKwSjYobYqM9UW9R77hvZTx420sdgnxxmSk8cGb75tukNyCo4bpEzg9T9Hx9/jEM9yJ0gPSnqyaUHjTVjur8eS81Gu8X6GARb0he1SZ9KpHWGR8+casACyLcMb/IwSBh672GwNpZVm0ptFVlXhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUhOWAa08Glx6xO2OUXI26vY6N49eimIvug0g7tdt6E=;
 b=Mw15W6Ro/vVQbaYltS2VOQ39I+b7n/sC1cwtCa9cjTtXkcOyT+lqFSZQiAQxV/gsBnkTdEV4t4lV8w4x6tI9fwxEHrthRUtffwUshTCcD3/4yM91GR8SM6LTW7ZBAdGTrGv5D0SrvjQB/mqvKMok2MbJ/RNw03jJpN+wvnZigkPtYSrEMhQV49t3aMpTYWOqu30832ZzyIOnZ1M5hEEeH2Uifrd7D3YaaskojpTTWHln5l7NaUcLHgDfjon4JFkihzqjW2lJ7nXxltY8ojNjkMcjIr3k8IgY55J7FZDHm7KBwvvCLg6zZkbnkxvhLA1/irVkYhZfnaFP2m1jG5lpUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB9104.eurprd08.prod.outlook.com (2603:10a6:20b:5fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 02:17:04 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 02:17:03 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH RESEND v4] arm64: dts: mediatek: mt7986-bpi-r3: Change fan PWM value for mid speed
Date: Tue, 30 Sep 2025 05:16:56 +0300
Message-ID: <20250930021656.1394942-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0083.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:274::16) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: b7d56f1e-5409-4c30-0bcc-08ddffc7721b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DQQ3zkTzVcHEHyW8htz+srOjCsk2l4d3/MmmYn3lhFNnz7DIxQyJ29AEfIYm?=
 =?us-ascii?Q?YcU7sqQdyZXhajphUdGVf00ev4TrOgEID37O/DEqpqCfGeXtF0eybWH7sXeN?=
 =?us-ascii?Q?LA1yNa3OnamZ9cPmzaOJHTxBtDsqGjlON/ZoTzgj0/o5fjnWU2088pl6ah0v?=
 =?us-ascii?Q?YnwEbTgaLRMpaS3ZnKPqv1wQ/DDPyRM5n3iJLkrzoF8qLkoEIGEEmghJpIoU?=
 =?us-ascii?Q?vejSMf+Z6FGZjeTv/Q2ufJtP0FI0Vm+iSxIw85aQxXO8748Q3fdTlfGubfi2?=
 =?us-ascii?Q?2chue0h2+8hmrQwt91D7fgWz8asjB12bR+jIp8O6cmfwIzgxAGvWXp/qyJVr?=
 =?us-ascii?Q?RxGywzQRiGBrClvT0taADCI2/mnWZUQ1QPuEGSYGOuy0p1alupmIWbERlm8Z?=
 =?us-ascii?Q?6qsX9c33GCCcULgLQzNVUqiK0ib+C0Pmv4nPaKvMLrE8LYOdt1HWEy9ou3wc?=
 =?us-ascii?Q?b31wkdK5C3Sb5iNT5tXMWQtdx+w9KDuDIf8N7anoF+PeQCj+qN8kti5dCnoF?=
 =?us-ascii?Q?7DveYeSfS5EXFQrf5/qTEMkWBitEUT8wNRqYYSTNifQPLTYpOmvFAC6KPVqq?=
 =?us-ascii?Q?uxPBw5GVPtI3qt7TIJTJ8BL5+G4y+madN5PYLMZOmCxxr7p1j9X3FIUo672w?=
 =?us-ascii?Q?WvA6CU182gGLs0ohval570bxvePoOD+0+M2N79IjLrsLhPWkP2EBAFZMzp78?=
 =?us-ascii?Q?gwa+Mv6tCKEnA5t+t9I/XbGPznRcc7/44Bmt26PfjpI36VBX6b+zlD9ddaqO?=
 =?us-ascii?Q?a6W8BQQqrPGUPAW/73IVg9R2pI4AdKzzKiKzYtfnNXu/mUzkI8fGmUpTrNe9?=
 =?us-ascii?Q?TjCMgmMNUDva8N3WUD9s/TWvTVmIsbT4OeaV6dmFBHZGgDB0OpRf7iOvpsth?=
 =?us-ascii?Q?HVgzB62qY63+E40S7SLNfSWFcS4AS7kvqtM+q5p3nO6TM10+uoZkOk1cDT1H?=
 =?us-ascii?Q?jv7iZlrxq5AljVMfPZ5g8bs+Iy9DBgri4KTnRA5Cr5WjkruUI4Il1zQHUFaD?=
 =?us-ascii?Q?yKWVXX+4WUWgU7bi3hut/RfpEq4a/uGbdbZakAkVYAfQlDNhaB9YdWW/5qFZ?=
 =?us-ascii?Q?lNU0nwoPDk/d3G+skoJlBXjxnk83gtTfwRzQQlXMLOpueq0/H6tec+c8Rz5n?=
 =?us-ascii?Q?2A+nqd1/4dCRL6QmlR1m1u692Lre4SaMp4giYLzB27BjDn3L8keXS29+KSdW?=
 =?us-ascii?Q?lCf+R3CKzJS0KCaFSkjzpirJCHktZGMDZsknW86+m9lTEMJAhhF93ubJPdqj?=
 =?us-ascii?Q?AuXQLlMHxZwcj/v9U9orWcmKTiNgnR1a7ia8WQgMfSBtr1FwCSYryDkd7tik?=
 =?us-ascii?Q?sGQ+S2EidF39J1AAqcyWO3u1+84tazmz42gji7W5lBUckiEKZ0NMqQK7Co56?=
 =?us-ascii?Q?oCNAkOe3NguvHxqxNFoXjFJy0IORI9bfqBxl6o9i1VHPfs14yKt3b3f+6UGF?=
 =?us-ascii?Q?CJJUmh4KEFOxm66d1mLlnIlOcKuAt6SY2ifq03p95IA4dLb44jnQRyLHzh3j?=
 =?us-ascii?Q?+TobKv10Qhnejfy2vABB26p4/HEZ0LnHOKHI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GpoWKaTHxSCIIA3wDO/XGCQbXRYl6u7vDmPdnAbBcLOG9CEBL5PdkS6GxMS/?=
 =?us-ascii?Q?Zp7D8fN4+kIBHOAN0TtcFq5K38z6ZI2T5YQ5TvcC63znpqfInbUKQMRCRf/h?=
 =?us-ascii?Q?Zrc/6JPMdpwlcu9VbVNAPazN1rUtIqlxhZErncu4JkBU9xT7trvZTGDx3Iep?=
 =?us-ascii?Q?kkx6eZtgolVh/s6aO/g/wB8hYzJ6ILatL3DuctGgL3vjoEaMxjEhJnfjYnxV?=
 =?us-ascii?Q?AMTW7A9jLNIsmoyMe/cGLG1j5Z/idhm6dJAqrlq1Z5cB3zY110Jkaxu9Zv9V?=
 =?us-ascii?Q?oEMIQp/Qu0QCi4x1yr78Kxjny51M17k/huKc4is9rRYVIv3lnRJWgNceLyDM?=
 =?us-ascii?Q?ra5gvUvGjBsQNndxGrpC0rZMclkflylJHdFAJFJuMs3EiBDiD4i7XM8slugx?=
 =?us-ascii?Q?haB2deLnBaN3JK6iJP2I0HM17tXoxJLflnTagJq27PM43T55lNJxoM9SVJQi?=
 =?us-ascii?Q?/We8BGs+BRdqV42Y3aysvRFTqG31qAMLX9Cd3tLpIkBh9gqYv4tjWSusZ+Hu?=
 =?us-ascii?Q?Qfrb2sTbxPeyvddkWvGJP607vtMPmz8A3zdwrB97t7R5Xi2LG8DKU9K9pv4j?=
 =?us-ascii?Q?vazOPe3pabovsmdinLrd/2KIW04AsOpKgjeo5b3iugxwKHhA1yPf8dI1fKzb?=
 =?us-ascii?Q?c7cevJgXaXEWXba9dUxW9ZIsvu42k850DSktDZVc9PPDAcUHC0/S33hR+PMy?=
 =?us-ascii?Q?GPEpU7F9avUrlkZ7A97zLSWZuBUAAY18Nn/WNtNRHtAb5/GfCVgWK5Ex6CI2?=
 =?us-ascii?Q?iDiHO9DGcUUojuqBaMFpvhQoCpqvxYHE8yr2BI4w4FrZgOdlIneJyctADaLo?=
 =?us-ascii?Q?aiwlmMYFcPIPhxseJTENan9g0B0LpyyN1CDFr3WhJVdIjnqjrNltZ1XWglsm?=
 =?us-ascii?Q?9W0+ZB324nJQJG1UVeCvyyKtS94c8lORTJo0E4zOVuPK9Fc5VWvf7OHj9sMo?=
 =?us-ascii?Q?iP5OQXHAr2jU3BsMohu+Nfqlc/6E2AgVeD6+EOnlq3l+kAWC4uY8uqjao7le?=
 =?us-ascii?Q?CuNSHfs8/NezmjsQ2JAvEY3LqxrrKG0g9g6iqGYWLYJWKnuQGM1hKk0JjAD0?=
 =?us-ascii?Q?gEpB7h4V43NEy9AcJloZJJlQlCfbX1QotX6gWIdzhBA8/gJANsY1u+tDf3VP?=
 =?us-ascii?Q?iJeY//Fap9G/xeH/PrO8XkIMiJtHJdJOsRJjEOs/djRhIZD873Qf7NTvYCHd?=
 =?us-ascii?Q?xIhihyKSxisHKPD1GoUJaNa7+iqx8Q9UOwKG+AAWfVC511nFQAlP9Ve/Gn4G?=
 =?us-ascii?Q?viJT0UJg91Dzb2PkOO5wZPpfdxXtjHgZSg4MQ4qx5zVGdhPnOZguHJRLBe9f?=
 =?us-ascii?Q?tRB42+uen5vXix3+L87E5AcF4hO6HLo/Tgz3oZevTQlZE9je+3U2be3Q1eNL?=
 =?us-ascii?Q?YQIBaq/igXJup9k+EAkmVVBDj0kpuaNIbBkQIphuTwBtm3hZI9m34q6kb5L2?=
 =?us-ascii?Q?3FYutpWPr8/kzpxV7QC1EL9J+wmU7vUXE/J4n6r5bVvbcXo6RmTvqPbPFEUu?=
 =?us-ascii?Q?cKfCtCLrrdS3yXucKtH+trSrv4x+2EIQJr8rvV/rGCKCeRf1MafTLoyj7Qi+?=
 =?us-ascii?Q?PEaxo1hhTZPSMdyl+CKxOl+RlUGXpKw8tgCvg19i3+cYB+Db1z/Higu9S7HY?=
 =?us-ascii?Q?jhcImp4rutg1EhS6TEp5JUg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d56f1e-5409-4c30-0bcc-08ddffc7721b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 02:17:03.7140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKPmmAZDuBwljT1J9zzk/ZcT7s5/pisX+5N59xc/Rx609HEE75H5+0Uyh9v504G7MMVDPGy5+aA8BhFi6GoT96bHnmn4kayJwYM4Knxw8zU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9104

Popular cheap PWM fans for this machine, like the ones coming in
heatsink+fan combos will not work properly at the currently defined
medium speed. Trying different pwm setting using a command

  echo $value > /sys/devices/platform/pwm-fan/hwmon/hwmon1/pwm1

I found:

  pwm1 value     fan rotation speed   cpu temperature     notes
  -----------------------------------------------------------------
    0            maximal              31.5 Celsius        too noisy
   40            optimal              35.2 Celsius        no noise hearable
   95            minimal
   above 95      does not rotate      55.5 Celsius
  -----------------------------------------------------------------

Thus only cpu-active-high and cpu-active-low modes are usable.
I think this is wrong.

This patch fixes cpu-active-medium settings for bpi-r3 board.

I know, the patch is not ideal as it can break pwm fan for some users.
Likely this is the only official mt7986-bpi-r3 heatsink+fan solution
available on the market.

This patch may not be enough. Users may wants to tweak their thermal_zone0
trip points, thus tuning fan rotation speed depending on cpu temperature.
That can be done on the base of the following example:

  === example =========
  # cpu temperature below 25 Celsius degrees, no rotation
  echo 25000 > /sys/class/thermal/thermal_zone0/trip_point_4_temp
  # cpu temperature in [25..32] Celsius degrees, normal rotation speed
  echo 32000 > /sys/class/thermal/thermal_zone0/trip_point_3_temp
  # cpu temperature above 50 Celsius degrees, max rotation speed
  echo 50000 > /sys/class/thermal/thermal_zone0/trip_point_2_temp
  =====================

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Acked-by: Frank Wunderlich <frank-w@public-files.de>

---
Changes from v1 to v2:
 * improve patch description

Changes from v2 to v3:
 * added question to Frank Wunderlich

Changes from v3 to v4:
 * Acked by Frank Wunderlich
---
 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
index ed79ad1ae871..b0cc0cbdff0f 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
@@ -42,7 +42,7 @@ fan: pwm-fan {
 		compatible = "pwm-fan";
 		#cooling-cells = <2>;
 		/* cooling level (0, 1, 2) - pwm inverted */
-		cooling-levels = <255 96 0>;
+		cooling-levels = <255 40 0>;
 		pwms = <&pwm 0 10000>;
 		status = "okay";
 	};
-- 
2.51.0


