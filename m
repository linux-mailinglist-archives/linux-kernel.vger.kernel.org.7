Return-Path: <linux-kernel+bounces-855435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 639DFBE137B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 04:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173DB3BA276
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 02:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC14620298D;
	Thu, 16 Oct 2025 02:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="NpQypUnY"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010002.outbound.protection.outlook.com [52.101.46.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DCE1624D5
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 02:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760580345; cv=fail; b=F096EglMlUxQ6xMm7l9qGkWwf/I3WormLix4EtmRxrNdDwPiiKAilmQBVfOEbk5B5E+ElULxaCu8Tggpe4mrjMPwwvdhlNVyjhmNIfURZ7doJ0rqJ0J+6oAY9fncnCtauXqxbUQjeqdfYnR1kjldk+zh1rWbPHv9cGSN+APUn0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760580345; c=relaxed/simple;
	bh=iw+S0Hic1BhMnCYR4ba9A+71mzmptih0o7lEMKmzX2U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ag3VaAzAhXbhyvDRWpxqZO9Rh90Lu5y9yxCsVhZrlrRWCqTOs6Vaix05+0Ngz4MSMQcWsJS9XY5GYfQh0zuXtFFneJO1KXgIfO/7+zV6lFUHu2ENeadlGQVN392j4052869G4IfEiVMgFHn/K/gkYfJaDPILdrQiAdvTHoWR96k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=NpQypUnY; arc=fail smtp.client-ip=52.101.46.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HP3hbWKtuvh+nZLBqrrz4NHsXsxxrz0rsyYqad7yW7BDg3moP4rlPTqaoaxan/QST4RluMl24qv7uxvEmC96jfgK7qNDkgnDtFEJ+pOYIr5+ZtBegBahD+Kf1XLKqRL+RW2BZjMWf85qYk1d89HJDaspcL2qEvp46I99OmWrtIbALOPn9Tcr1JVcToVz2W6gRTY6V5mMR2qS90it84pG+3CeAShN5V9ZVccVKkcQ+nPO6UHeOZEczv+zjc6/r9HA+JEbmwINZQzo/6x6Brgasio+W6IbxQnHB/plVqOvoRB1PIk+OQpRViEdBpePPOiqlL8ENI36mAPgyMYskIbx3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sa02HbsIOLvpDN0rKfQJ/hYcNkb7vjPakyvpWY/39Qg=;
 b=aCdf9F/a+0Ul9nFQV5ndaY8uE8o8XHd0DKNRGvPyC/DX3kXqGbf2muj1GYlUVidhgKv9YKjkQcGq7jAXhGheRGZqcBKmGSxFoNVXDAt2al7a185IwpFFcKQpm8kCqrHUrGm6biZFn+2EbnrBYkWY2DuJglXgBTYBCRjxw2Yw3z2Y2JwqRAjWKqFjqX/FrudQ8chE5Mxfre4fpwudJ484SB3UG+LIPzbX7sSP10ODOEq2gpUtib+/i1HU1ky3ykPSF9LdtHmvQudLKCL0f+MJdfa2LlMupWLPxDcN6okKVAkWLrM7UJWjXFkYv+t2rfSg6lE1r20T4jcCgCXGbJdPfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sa02HbsIOLvpDN0rKfQJ/hYcNkb7vjPakyvpWY/39Qg=;
 b=NpQypUnYOGKXMAlyzz8EiXv/1K/86Ob87b5lrchYs5v7SHuAWD+OT2BtMweu1TpDYINWTJ5RnKiHEWdiK2FfOzHJamZzsQNFzWVD4792TDZM8BIqGUVdxgF+j6S1t8khE3xNJc6N6+TwnjtOXzFWAbbpS6rq91g8upqt+0cidK1Suyh9ebnODeForYelR2ZGl2afs6yRG8oNR5mV6ARAxqNsOW1CEz/TTw00IHJ3Mlkdmwvxx3vtaOWmOzGTOqbI4jbNo1O+HA7z8r59++46uoSJyowkE+M/Xs3qMETHvrCzWCkdMTRJRB4JtcaHU+v66faxCEFPt14VMo4A3rdXvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 CH5PR03MB7982.namprd03.prod.outlook.com (2603:10b6:610:214::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 02:05:39 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 02:05:39 +0000
From: adrianhoyin.ng@altera.com
To: dinguyen@kernel.org,
	alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: adrianhoyin.ng@altera.com
Subject: [RFC PATCH] i3c: dw: add option to disable runtime PM for DesignWare I3C controller
Date: Thu, 16 Oct 2025 10:03:39 +0800
Message-ID: <22286d459959f2a153ac59d7da46794c0f495c77.1760579799.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:820:1::28) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|CH5PR03MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c71ae00-f024-4086-b8c4-08de0c5880c8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RlyyoK+qG3dzm1FP7Rsfj8UjwaKTLohPiH/dPU7ZUHtiziTFeXyXoxvfXXio?=
 =?us-ascii?Q?hWY/BWY2n1dhDySms7JLgv6mi0ZzJ2xBaPUYBKK5o/+YfW5lld50WedBVFWF?=
 =?us-ascii?Q?Xj/gnSrYVc2H5KBCnx4j1mc44w6HM7gX+Hg9QFaA4QQfKj6hG6xVAakws0LE?=
 =?us-ascii?Q?vbzOFFL8/ffZffSj2wUQAZHGod8eYp6Yoax26AUynQPq/E9R96mMSKayzXZY?=
 =?us-ascii?Q?9ypAzrPOWzfbgNQYfzhd+FAY93EejCZ8vO+A3c2Y6pCNQjU3J/o0iNS7NX4X?=
 =?us-ascii?Q?ssj9AiTotClLxy5+qGZgaUE8x7U7HpHUl8RwyM9WOnvbSyEafrT3bT63RLeA?=
 =?us-ascii?Q?iXwUubkA0YKBUVCHUuP2Avo/ynXH7rwXhVRihJwfWUzwMg3kb4Z4yIFMIGn3?=
 =?us-ascii?Q?vkcQ5d4SaSy21bilit6j1igfBUUmPVAn7GIa+d5s7Hinwx90pC1bYwbUD2ZG?=
 =?us-ascii?Q?AfYiN4LPDxOh3aWr7RK7HdXK43MDuXWWNrfoCHhzSlFNc200PfKv1hDkJD7S?=
 =?us-ascii?Q?JM7XU6qGe/0mXrpggNqZ2RFEfoWaFlZk7ZqnXgqLHIzNtBXHG3HHlWg8EG7f?=
 =?us-ascii?Q?FjaofynSLEz+xMIDN1e0bfRrAPwCHiXMKD4n+3XDWSpeBYXbYH/zbVu/7Hy5?=
 =?us-ascii?Q?FUZ8PYn2oZ7oW6JKfYkNyk3NmOCGlCfx6i/QotKNdC9cIr9WKYVPftsu4iu2?=
 =?us-ascii?Q?37z4KsRTaR4KGHH7Xc4ey8064hWBi3MZrozsf5Cr61Y1RyyuWmC0qTCSqkEy?=
 =?us-ascii?Q?68k3BduAhUjLJ9owHj18gghYvgOow1EeWslwICIPdg82e78Q/B8RD+Z+NJA+?=
 =?us-ascii?Q?Z1hkhJOXdkfXr2htr0hyVxRwemELGhOEj2GUY7EvBacqOCfQi/R79GKNDe/m?=
 =?us-ascii?Q?2D4KKyMVk5h1p3g0zBVJ3gABbfCKFMNIY8GHV+yGY0h7I1g4RXr2+ZQhkSLT?=
 =?us-ascii?Q?lxLlcmj4TQQwDf0RZuCLWhiA1gztjaOSr+zOqBMWhMp8z3j1HSTbEdBZVXXF?=
 =?us-ascii?Q?X87ykI0XW5UpquOix/65mm5Y1OIk19u0u5O4tOJDai+UXqAJLE/fpSjZd2WJ?=
 =?us-ascii?Q?iMVtmVZC3SMMBLvKPovxmb5lU4Zl5O+Xmp4ooq6oTivSPuL0pgBKee/EAO+1?=
 =?us-ascii?Q?+CJ1FNgSxyipF6TspnT0x4RcToj81TBuqhwAEwRPtK9P8QQnm0oYME7foqOT?=
 =?us-ascii?Q?0Df/ZbVeB8wCdZ0veCAY3PmXo7fkDj/lUGus5sFNWrmoFHN6PSIAI6+9Bvq8?=
 =?us-ascii?Q?dI83meJNGD2zFQf+qGYZ7XjBayG17iDy/WcuE8zuD1shWgLr39Gs2K82TFlk?=
 =?us-ascii?Q?3voLVY7qf0M2lejiYwZq+VrhtZNCuogoOga5GthReKZzCoWtKDMCgfyyLXrG?=
 =?us-ascii?Q?FcKQieBbtLzuqSgN9WayUAm1xnwxJOzAflUPCAGXpSpIO7Z6lR8uzSJ//bMb?=
 =?us-ascii?Q?F282XX0L13jCGCMAX0uCsQVQioUU7qRP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+kZFHXpkY07b82VRcGSKq0iCDjWEK0Du1jj3ZUmZ5r28vN2bIdjQQseaq/XJ?=
 =?us-ascii?Q?tPhXaCfwvJBdztyCPUMxjkbo4NOABWkKAt8lUgN0ssOXLVYG4+X/2L7LFaOb?=
 =?us-ascii?Q?oQKBzDwhqh7tW0j1UAGbxrTKwhBHu2ftWVsVv1qHYMMdbDgstVVqf9dyvxiF?=
 =?us-ascii?Q?tWoYQMSHbUHuWlMGAwCGFP0K9Cl+8t2dWRnR4h1o4+VtymD4Rf+LNMoesBJr?=
 =?us-ascii?Q?5GUPobGx66gfkdzc5ym1clnvf6wemvYnb2WyJXvTav9+EfUQug+mpfmvUehy?=
 =?us-ascii?Q?qTWqVLlfvlvUBmieJLYMSvIHinN9wQeW4wqlMNpSMiqNlT6Xtzj27EWkHVb8?=
 =?us-ascii?Q?JW5xUyKTDpRfMIQMruceFw26OY4GCJ4zxEplTJ3+8K8RHANPuqvsV5ljgMFN?=
 =?us-ascii?Q?2II4aJ6Nb0zbZ5ypBJCY3f1Ewav8GV+KWTvBofWgHuOykYu2NXqnC1yr9sr4?=
 =?us-ascii?Q?OSSbVCY+sKMHXUQzcXL1kXdtciLD12iJg9CBWHw2q/+GNQeU6R8iK9clnumh?=
 =?us-ascii?Q?2VXCLpSKocijfQyQds4GJG/eGqTxqVjxOKzabpgzauT/ZVLCPCWOpOgatuIr?=
 =?us-ascii?Q?GxVXfZSpFYTG9MI4bsFurhA6tiH5Vs70gep+8GvnrurdRY3e5OaXN5e+GKYw?=
 =?us-ascii?Q?KAJojM8mzvRqNFrtxNGsv9o63CqAKkGPfedpj47pi3mrGbraD+Bxkg0qSlUh?=
 =?us-ascii?Q?nIeKJ5Ikab5iwja1TxVO3BxUX3X4k2fDr8Tv6+1LymvAruxQVS6I97O5w8bZ?=
 =?us-ascii?Q?VgkrAFAb6i4mE5Vu6TNEttgS78UIR5NWj+RieMgMJ5kT+o0orh7ZGEUWgYNj?=
 =?us-ascii?Q?sR8pFDDMiMNdUswRy7vuWE3NriVsFFZbAoPhjOn8BlG+m+z4pdYeTuLFkRQw?=
 =?us-ascii?Q?jV247AsyDE9urxVsBVo+7ja6ZXg1HlyXIyJagy4A3NT7AbEhKGA3eD8JzWvp?=
 =?us-ascii?Q?R7aueVpxMQwfDBxyYi6l22LQ3x/McgLFBXd4u7T7gtNBxAIe8Q58ljCTGCEG?=
 =?us-ascii?Q?PkYtZmJDbpAw9UqgcggIWsL2FDfUH3K5JdYgKsvWhNo2SBpjPlx3u3ybynGr?=
 =?us-ascii?Q?PZ3s9xMMkaIk8JZYMFF6Zp2hIgGTCoBvOij5gsOg0zSkl/fLWHvjtrnmKD13?=
 =?us-ascii?Q?uGHhVFmigbjIhhzSymFmrRyg5WZDrVN1LdBO0RQkw54DPemGf49DmpsBOUUc?=
 =?us-ascii?Q?/8Nzck2DNTYCOhmKkdGM+qJdbUqskBrKH4CxDArIfV8ocWOC6ohE/HJN0kE8?=
 =?us-ascii?Q?FdNvpEbN7lL9AviOKWew65GofZvLcup1mC0kIm7HopeBsWRnkaz5ZB7s1ozo?=
 =?us-ascii?Q?HdLyXv3C/s3Gf3qiV9SArVkfZnnwv+fW25Y/I45olcS/psoxH0pgBTeaUIE0?=
 =?us-ascii?Q?eyb9MmUvPB7P44NyJb5FOWq3EZLJowTmoaQy2x4Kc4g3mySmlyGm5RTtPRqB?=
 =?us-ascii?Q?KlbOBXYPaIp/WNGSexBFj7h+EWJtTDZ6jj/HqzpVxf8QMquXCod6knGaz7KP?=
 =?us-ascii?Q?/KiXgc8kuFp3jlEW94lZKbvG5sLWe+rZZS4GqYAA6byg51MeVda2k72m20cM?=
 =?us-ascii?Q?f6HXIzvsSAiFEHzsZE4yZArLlZSB4YFlaD3umOPYM13oBb71XAOyOFw0ql1W?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c71ae00-f024-4086-b8c4-08de0c5880c8
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 02:05:39.4082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEnGStAnyAX+///8UTEZXKKgWBdtzfH0icVpPbSzN0QVM2BQFbIVVlULStRZlzn/xBYT41TuBDRwC+dlGyJnj8ry10mB4yukVSKilSdUNoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR03MB7982

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Add a new Kconfig option, DW_I3C_DISABLE_RUNTIME_PM, that allows
disabling all runtime power management (PM) operations for the
Synopsys DesignWare I3C controller. When this option is selected,
the driver skips all runtime PM calls such as pm_runtime_enable(),
pm_runtime_get(), and pm_runtime_put(), keeping the controller
permanently active.

This change addresses a reliability issue observed on some systems
where the controller enters a suspended state while a slave device
issues an In-Band Interrupt (IBI). Because the suspended controller
no longer drives the SCL line, the IBI transfer cannot complete,
causing the SDA line to remain stuck low and leaving the bus in a
hung state. Disabling runtime PM prevents the controller from
entering this suspended state, ensuring that clock signals remain
active and IBI transactions complete successfully.

A new quirk flag (DW_I3C_DISABLE_RUNTIME_PM_QUIRK) is introduced to
control this behavior dynamically at probe time, and the option is
propagated through the device match data.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
---
 drivers/i3c/master/Kconfig         |  23 ++++
 drivers/i3c/master/dw-i3c-master.c | 176 +++++++++++++++++------------
 2 files changed, 129 insertions(+), 70 deletions(-)

diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
index 82cf330778d5..d6159ec94c85 100644
--- a/drivers/i3c/master/Kconfig
+++ b/drivers/i3c/master/Kconfig
@@ -31,6 +31,29 @@ config DW_I3C_MASTER
 	  This driver can also be built as a module.  If so, the module
 	  will be called dw-i3c-master.
 
+config DW_I3C_DISABLE_RUNTIME_PM
+	bool "Disable runtime PM support for DesignWare I3C controller"
+	depends on DW_I3C_MASTER
+	default n
+	help
+	  If selected, disables all runtime power management (PM)
+	  operations for the Synopsys DesignWare I3C controller.
+
+	  When enabled, the driver skips all runtime PM calls such as
+	  pm_runtime_enable(), pm_runtime_get(), and pm_runtime_put(),
+	  keeping the controller permanently active during operation.
+
+	  This option is useful on systems where runtime PM causes bus
+	  reliability issues. In particular, if the controller is placed
+	  into a suspended state while a slave device attempts to issue an
+	  In-Band Interrupt (IBI), the controller may stop driving the
+	  SCL line, preventing the IBI from completing. This condition can
+	  result in the SDA line remaining stuck low, leaving the bus in a
+	  hung state until a full hardware reset is performed. Disabling
+	  runtime PM prevents the controller from entering this suspended
+	  state, ensuring that clock signals remain active for IBI
+	  handling.
+
 config AST2600_I3C_MASTER
 	tristate "ASPEED AST2600 I3C master driver"
 	depends on DW_I3C_MASTER
diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 9ceedf09c3b6..4f4ef4672255 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -227,7 +227,8 @@
 #define AMD_I3C_PP_TIMING          0x8001A
 
 /* List of quirks */
-#define AMD_I3C_OD_PP_TIMING		BIT(1)
+#define AMD_I3C_OD_PP_TIMING			BIT(1)
+#define DW_I3C_DISABLE_RUNTIME_PM_QUIRK	BIT(2)
 
 struct dw_i3c_cmd {
 	u32 cmd_lo;
@@ -635,12 +636,14 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 	struct i3c_device_info info = { };
 	int ret;
 
-	ret = pm_runtime_resume_and_get(master->dev);
-	if (ret < 0) {
-		dev_err(master->dev,
-			"<%s> cannot resume i3c bus master, err: %d\n",
-			__func__, ret);
-		return ret;
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		ret = pm_runtime_resume_and_get(master->dev);
+		if (ret < 0) {
+			dev_err(master->dev,
+				"<%s> cannot resume i3c bus master, err: %d\n",
+				__func__, ret);
+			return ret;
+		}
 	}
 
 	ret = master->platform_ops->init(master);
@@ -682,7 +685,8 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 	dw_i3c_master_enable(master);
 
 rpm_out:
-	pm_runtime_put_autosuspend(master->dev);
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
+		pm_runtime_put_autosuspend(master->dev);
 	return ret;
 }
 
@@ -798,12 +802,14 @@ static int dw_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
 		writel(master->i3c_od_timing, master->regs + SCL_I3C_OD_TIMING);
 	}
 
-	ret = pm_runtime_resume_and_get(master->dev);
-	if (ret < 0) {
-		dev_err(master->dev,
-			"<%s> cannot resume i3c bus master, err: %d\n",
-			__func__, ret);
-		return ret;
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		ret = pm_runtime_resume_and_get(master->dev);
+		if (ret < 0) {
+			dev_err(master->dev,
+				"<%s> cannot resume i3c bus master, err: %d\n",
+				__func__, ret);
+			return ret;
+		}
 	}
 
 	if (ccc->rnw)
@@ -811,7 +817,8 @@ static int dw_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
 	else
 		ret = dw_i3c_ccc_set(master, ccc);
 
-	pm_runtime_put_autosuspend(master->dev);
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
+		pm_runtime_put_autosuspend(master->dev);
 	return ret;
 }
 
@@ -824,12 +831,14 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
 	u8 last_addr = 0;
 	int ret, pos;
 
-	ret = pm_runtime_resume_and_get(master->dev);
-	if (ret < 0) {
-		dev_err(master->dev,
-			"<%s> cannot resume i3c bus master, err: %d\n",
-			__func__, ret);
-		return ret;
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		ret = pm_runtime_resume_and_get(master->dev);
+		if (ret < 0) {
+			dev_err(master->dev,
+				"<%s> cannot resume i3c bus master, err: %d\n",
+				__func__, ret);
+			return ret;
+		}
 	}
 
 	olddevs = ~(master->free_pos);
@@ -893,7 +902,8 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
 	dw_i3c_master_free_xfer(xfer);
 
 rpm_out:
-	pm_runtime_put_autosuspend(master->dev);
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
+		pm_runtime_put_autosuspend(master->dev);
 	return ret;
 }
 
@@ -929,12 +939,14 @@ static int dw_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 	if (!xfer)
 		return -ENOMEM;
 
-	ret = pm_runtime_resume_and_get(master->dev);
-	if (ret < 0) {
-		dev_err(master->dev,
-			"<%s> cannot resume i3c bus master, err: %d\n",
-			__func__, ret);
-		return ret;
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		ret = pm_runtime_resume_and_get(master->dev);
+		if (ret < 0) {
+			dev_err(master->dev,
+				"<%s> cannot resume i3c bus master, err: %d\n",
+				__func__, ret);
+			return ret;
+		}
 	}
 
 	for (i = 0; i < i3c_nxfers; i++) {
@@ -978,7 +990,8 @@ static int dw_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 	ret = xfer->ret;
 	dw_i3c_master_free_xfer(xfer);
 
-	pm_runtime_put_autosuspend(master->dev);
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
+		pm_runtime_put_autosuspend(master->dev);
 	return ret;
 }
 
@@ -1089,12 +1102,14 @@ static int dw_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
 	if (!xfer)
 		return -ENOMEM;
 
-	ret = pm_runtime_resume_and_get(master->dev);
-	if (ret < 0) {
-		dev_err(master->dev,
-			"<%s> cannot resume i3c bus master, err: %d\n",
-			__func__, ret);
-		return ret;
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		ret = pm_runtime_resume_and_get(master->dev);
+		if (ret < 0) {
+			dev_err(master->dev,
+				"<%s> cannot resume i3c bus master, err: %d\n",
+				__func__, ret);
+			return ret;
+		}
 	}
 
 	for (i = 0; i < i2c_nxfers; i++) {
@@ -1127,7 +1142,8 @@ static int dw_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
 	ret = xfer->ret;
 	dw_i3c_master_free_xfer(xfer);
 
-	pm_runtime_put_autosuspend(master->dev);
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
+		pm_runtime_put_autosuspend(master->dev);
 	return ret;
 }
 
@@ -1272,12 +1288,14 @@ static int dw_i3c_master_enable_hotjoin(struct i3c_master_controller *m)
 	struct dw_i3c_master *master = to_dw_i3c_master(m);
 	int ret;
 
-	ret = pm_runtime_resume_and_get(master->dev);
-	if (ret < 0) {
-		dev_err(master->dev,
-			"<%s> cannot resume i3c bus master, err: %d\n",
-			__func__, ret);
-		return ret;
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		ret = pm_runtime_resume_and_get(master->dev);
+		if (ret < 0) {
+			dev_err(master->dev,
+				"<%s> cannot resume i3c bus master, err: %d\n",
+				__func__, ret);
+			return ret;
+		}
 	}
 
 	dw_i3c_master_enable_sir_signal(master, true);
@@ -1294,7 +1312,8 @@ static int dw_i3c_master_disable_hotjoin(struct i3c_master_controller *m)
 	writel(readl(master->regs + DEVICE_CTRL) | DEV_CTRL_HOT_JOIN_NACK,
 	       master->regs + DEVICE_CTRL);
 
-	pm_runtime_put_autosuspend(master->dev);
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
+		pm_runtime_put_autosuspend(master->dev);
 	return 0;
 }
 
@@ -1305,12 +1324,14 @@ static int dw_i3c_master_enable_ibi(struct i3c_dev_desc *dev)
 	struct dw_i3c_master *master = to_dw_i3c_master(m);
 	int rc;
 
-	rc = pm_runtime_resume_and_get(master->dev);
-	if (rc < 0) {
-		dev_err(master->dev,
-			"<%s> cannot resume i3c bus master, err: %d\n",
-			__func__, rc);
-		return rc;
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		rc = pm_runtime_resume_and_get(master->dev);
+		if (rc < 0) {
+			dev_err(master->dev,
+				"<%s> cannot resume i3c bus master, err: %d\n",
+				__func__, rc);
+			return rc;
+		}
 	}
 
 	dw_i3c_master_set_sir_enabled(master, dev, data->index, true);
@@ -1319,7 +1340,8 @@ static int dw_i3c_master_enable_ibi(struct i3c_dev_desc *dev)
 
 	if (rc) {
 		dw_i3c_master_set_sir_enabled(master, dev, data->index, false);
-		pm_runtime_put_autosuspend(master->dev);
+		if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
+			pm_runtime_put_autosuspend(master->dev);
 	}
 
 	return rc;
@@ -1338,7 +1360,8 @@ static int dw_i3c_master_disable_ibi(struct i3c_dev_desc *dev)
 
 	dw_i3c_master_set_sir_enabled(master, dev, data->index, false);
 
-	pm_runtime_put_autosuspend(master->dev);
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
+		pm_runtime_put_autosuspend(master->dev);
 	return 0;
 }
 
@@ -1573,11 +1596,6 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 
 	platform_set_drvdata(pdev, master);
 
-	pm_runtime_set_autosuspend_delay(&pdev->dev, RPM_AUTOSUSPEND_TIMEOUT);
-	pm_runtime_use_autosuspend(&pdev->dev);
-	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
-
 	/* Information regarding the FIFOs/QUEUEs depth */
 	ret = readl(master->regs + QUEUE_STATUS_LEVEL);
 	master->caps.cmdfifodepth = QUEUE_STATUS_LEVEL_CMD(ret);
@@ -1592,6 +1610,13 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 
 	master->quirks = (unsigned long)device_get_match_data(&pdev->dev);
 
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		pm_runtime_set_autosuspend_delay(&pdev->dev, RPM_AUTOSUSPEND_TIMEOUT);
+		pm_runtime_use_autosuspend(&pdev->dev);
+		pm_runtime_set_active(&pdev->dev);
+		pm_runtime_enable(&pdev->dev);
+	}
+
 	INIT_WORK(&master->hj_work, dw_i3c_hj_work);
 	ret = i3c_master_register(&master->base, &pdev->dev,
 				  &dw_mipi_i3c_ops, false);
@@ -1601,9 +1626,11 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 	return 0;
 
 err_disable_pm:
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		pm_runtime_disable(&pdev->dev);
+		pm_runtime_set_suspended(&pdev->dev);
+		pm_runtime_dont_use_autosuspend(&pdev->dev);
+	}
 
 err_assert_rst:
 	reset_control_assert(master->core_rst);
@@ -1617,9 +1644,11 @@ void dw_i3c_common_remove(struct dw_i3c_master *master)
 	cancel_work_sync(&master->hj_work);
 	i3c_master_unregister(&master->base);
 
-	pm_runtime_disable(master->dev);
-	pm_runtime_set_suspended(master->dev);
-	pm_runtime_dont_use_autosuspend(master->dev);
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		pm_runtime_disable(master->dev);
+		pm_runtime_set_suspended(master->dev);
+		pm_runtime_dont_use_autosuspend(master->dev);
+	}
 }
 EXPORT_SYMBOL_GPL(dw_i3c_common_remove);
 
@@ -1742,12 +1771,14 @@ static void dw_i3c_shutdown(struct platform_device *pdev)
 	struct dw_i3c_master *master = platform_get_drvdata(pdev);
 	int ret;
 
-	ret = pm_runtime_resume_and_get(master->dev);
-	if (ret < 0) {
-		dev_err(master->dev,
-			"<%s> cannot resume i3c bus master, err: %d\n",
-			__func__, ret);
-		return;
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		ret = pm_runtime_resume_and_get(master->dev);
+		if (ret < 0) {
+			dev_err(master->dev,
+				"<%s> cannot resume i3c bus master, err: %d\n",
+				__func__, ret);
+			return;
+		}
 	}
 
 	cancel_work_sync(&master->hj_work);
@@ -1756,11 +1787,16 @@ static void dw_i3c_shutdown(struct platform_device *pdev)
 	writel((u32)~INTR_ALL, master->regs + INTR_STATUS_EN);
 	writel((u32)~INTR_ALL, master->regs + INTR_SIGNAL_EN);
 
-	pm_runtime_put_autosuspend(master->dev);
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
+		pm_runtime_put_autosuspend(master->dev);
 }
 
 static const struct of_device_id dw_i3c_master_of_match[] = {
-	{ .compatible = "snps,dw-i3c-master-1.00a", },
+	{ .compatible = "snps,dw-i3c-master-1.00a",
+#ifdef CONFIG_DW_I3C_DISABLE_RUNTIME_PM
+	  .data = (void *)DW_I3C_DISABLE_RUNTIME_PM_QUIRK,
+#endif
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, dw_i3c_master_of_match);
-- 
2.49.GIT


