Return-Path: <linux-kernel+bounces-882556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55677C2ABC7
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B99784F1774
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9152B2EB5C4;
	Mon,  3 Nov 2025 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="pQsPI0xv"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012051.outbound.protection.outlook.com [40.107.209.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D5A2EA723;
	Mon,  3 Nov 2025 09:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162025; cv=fail; b=fYjaGe393rkPN8xT2yIRDIoz7p8lC6QvL6QDyL2s0RmDPDjv+vY4qXzSNB3zXdhiCGcm3LJf231dDJdPHSobfjwNXDjWDNe9pOI9LxgsHje+caYbQTeKYzrmuqg7OHwbX4h8hXiBr730ylC5+TnuACnTwO4dUfuhszf9axZ9v/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162025; c=relaxed/simple;
	bh=IU/zrRNm5bjszk2e+QG3xg7nTjEYTQTr7SmR3+hEqXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KoU8DqKe98nZHygqJz5WHausYITcdJTd88Jbzm/tcuAwVH4LU5Ia4vt/A4AwVGQg00lzfJFnJKCEDjNN334xay/tPbYhB8n7jB+XdgD5d16kpZ0CLXEpxhcmkaBF505A5yOWGea4VBDbhcBbI6J3OYnvvhRnZ1r02jY0QREl3w8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=pQsPI0xv; arc=fail smtp.client-ip=40.107.209.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RT7qbskYGPLA6l4Whz7ggzuaRUhk+JlPKbWSGWJ3eIHtzOYso3GT4/nfKIp25WCHvHcJOrvXCOSVKWSnNR+D+5lFaJqTUa2JgjA+mC3i37J91cbTTwSRpk2R3ddT0UggzVfw1PQQsF51TwcswtnhwFl1v4dSOwRTb+sxpECndod+jt4JghHrxxbq1VL8PePBTJy8wVsQzzuxJFZo8maCDUHxopeJJ1BkWPAiB7nMbeUf1dcdjngiWgSXZ4UNYdqWMKhBa7sYWM85UdBxjHLVMsCS6mbLRPAx30fdrN0yaIcIlp+aP/rqlH+niNy0eIvXVvp5gndkGfvm7dV3pB81PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukWl9JWXL3JdBvct6OgDQH9cv4oC+ooiBUqWCWVfJec=;
 b=MIqSmZ5YaTWvxVfoU+hchq2cwXtlH6+L2uU5Cnl3RRBZGlamT7i11OHPQabE/bwdT5e29n1qI1/OLuMInyh6wXiFksgrA6mLSJYItlLSGX3MQQOetKz6FgRAvtsTnuHrI0ge6VcxfNTAz+17wK94sbggCdCGh6AiIZqlATAaHj3Fr+yACPfCwjI1Kp0AL5+egcD29TwRJCIKif1tnu32Nzfwm3sM5K91qO07E6appJ18goPFUKSu8FVk1gYYFYHZo2OTz+dD77lyRGlueOrMqfTuxP9mZysKSD9S4FPeI3QB0zcMZLrylS/Er+QiFLkKPKiCC4My/bqnlCR1tlCwYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukWl9JWXL3JdBvct6OgDQH9cv4oC+ooiBUqWCWVfJec=;
 b=pQsPI0xvUys62C/Mj/7ASR1XdQ1NENzdx/wMsbhdxS63JG51XWnbMbHTgspRd1VZRw2e8uozsSNY7ecAyrb02AA73qw94K4y2nHVxX9wVsDI1XE4Yd8VSPvmUOsCOMwWIXoQ96HorsPiS84PZ61MXI2DFgBeDvv/KENi8cm/v5EfBN2Cr3xK5P3eXpeOKZ0nH/HqLw2T2ZXljwJFy9UFpWwQW0/dd16f5gtbmMIEkCCafIl+U9YO1neYOCBfN/3vI16WB6kk27ZGyT5WFx2OAOhVkPuw411eXoB9dMrtkn/pBz7M6xJBW6QPwzQt8toUKYkdgoCnSqtjLLh+49xjlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 DS0PR03MB7252.namprd03.prod.outlook.com (2603:10b6:8:117::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Mon, 3 Nov 2025 09:27:02 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 09:27:02 +0000
From: adrianhoyin.ng@altera.com
To: alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	wsa+renesas@sang-engineering.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: adrianhoyin.ng@altera.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/3] dt-bindings: i3c: snps: Add Altera SoCFPGA compatible
Date: Mon,  3 Nov 2025 17:24:26 +0800
Message-ID: <4ef059b129e9457eaadcfa6b996b9b6b000c7dba.1762161408.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1762161408.git.adrianhoyin.ng@altera.com>
References: <cover.1762161408.git.adrianhoyin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU2P306CA0002.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:14::9) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|DS0PR03MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: cc63ebf2-51f7-4b2f-9fd1-08de1abb2555
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tFe+qTazj4uYcn4oCu2uhHX6rR3ix01bookFebDGyvVY7I2T9gu2SVnCIc9W?=
 =?us-ascii?Q?CdCAuFvGioMHZjgA1YHVeYpLtNgcz8zUowR0dmEfdPPg2e52A2NLikKCM0qp?=
 =?us-ascii?Q?HjwQ+nP0XAcKGrRuIhcnHIHOEvYalTSAkoxxSZtjNcSESKGdJG968pf+HYSM?=
 =?us-ascii?Q?oC5dFaihxr9xLo6TaSkva+wrmAQxGwLFt0KxGtQPK24XXPuH1qpr6/K/vOIp?=
 =?us-ascii?Q?0HLCv2w/ZdtTYoHCLZK0bHekvR3Co5pXB1+hyPMrVHmT0XFfu7ZEh7M/s0Fd?=
 =?us-ascii?Q?jNnGzGdlFT3H06XyajhzD/wuRnh3ZIR24/EMlHqA94hbcFPf9V/WPFoMot4O?=
 =?us-ascii?Q?8JXuptR2KBMc3JCtcR4/JYvdPsI3sSh7MlAV7ZRogIi8hJkJM7u2UWIzgAn5?=
 =?us-ascii?Q?ozD3+KDFnCTzc3QSqWVCcg6LNMV+ffzI+DbmVHtCopm+U7eROKXSGGHrHFxY?=
 =?us-ascii?Q?9sHQDl8Q4l2hQKhBq5moleY+fqNp6W1xa3ziXgD95Qsqz+YSeZOFCdxSLDRC?=
 =?us-ascii?Q?UzBda2SGRoKsq1RUJEH84yQ6fJXV1OZeSoWRdHprBVYXE/SeNRGf8hrNFZ8Q?=
 =?us-ascii?Q?ailQH+38P3Oq2EkVuUyLMiWfeH+mM2hulUTRXrgTEBAJEpUynT5aYaZvIIkA?=
 =?us-ascii?Q?BqITCsu6TGlMWCEThtNzGQP42uvcLBMgxTgNi24wnr5TEZUny08ZGzU0EOiu?=
 =?us-ascii?Q?VRiKjIBFBUdlet7STeJWBKzUbzfivv23YW7HvrFqWm2xrPR8QufStAHrjRuy?=
 =?us-ascii?Q?xvSeeR8kl7Pw6lpXKNsa7dojSgIjl6u5lnbe5cp0c97i331R9HRMc5f2cdYv?=
 =?us-ascii?Q?FlpWY04Phzh+BERD44IzGfI7Idicc1GtCd56fmNoeGipvWRUcsRt/ajMBzry?=
 =?us-ascii?Q?CpaaV9QLcrB2MkMIG6twMq3Wgd1lOAS208GRwAhrhrTU1z60aLfpWXQl8MrZ?=
 =?us-ascii?Q?tN8w1ku2oshKQb00SV9zuTSs33VaNYGwMC5AMHBSLVqiMaeLQbJYu8zeYS22?=
 =?us-ascii?Q?u4jYBxPW2OsRijlye2zSSnvXIKYMR84w+rJjPV1Ag8Hrj43MoWKST0Bc5QuO?=
 =?us-ascii?Q?YRhKH+nBcYvN/QufzvIcGCrC6Ufd0veuvOb6ehPUJNDbdNH3DXc3jVJLpHyE?=
 =?us-ascii?Q?ada0t+dtIcDC2pu/caO3viiyHtVY+gE0qdGEnmYogXVX5vAJjQFphPDVkRNn?=
 =?us-ascii?Q?I3qrlDS/JOV/0AyhqFIZyFEHFk4CRG+Gcl2bJxCWF03lV0iCvFzJB4qFMcJK?=
 =?us-ascii?Q?oOmbNcbfkZBKpNupCsZ5DmTgENbIiQrDXjRJDDer2KOYJEcuTHUIXE7N5FQN?=
 =?us-ascii?Q?RzIqyYc3e/vfZn48wH/6NwNA3CsGLA+tjff/vPBZm9wwEwLkboahIc4EqULm?=
 =?us-ascii?Q?qTbo/z3g1KRtzbsU1MFdiYC0oO2WCkHNLidLvJ0Py/t6nvwp2GTpdMwz4S62?=
 =?us-ascii?Q?TreTgp4w9rMX6JsPg0b/u1AfMeHaT3xQpWLwKlSgdg5tF87lUxJBnaneSQWc?=
 =?us-ascii?Q?PzW72MFUGzhmXZ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IsVJI/ZDhBvNYfF+YKmLuM3ca3BlDafqGRKxkjPic0XkMbSaJhEoZ2M67KOu?=
 =?us-ascii?Q?vzQsk3vokLRufAjznCOGw/tdKjQf5uy2kUfhEMpoBXh5GO/feUbsWULBEFcu?=
 =?us-ascii?Q?mv5nqJ6oMuBDnaIpUev41QTgVcyoqut9pekwsSZhHH2YV75ZiBMheOhEFEV9?=
 =?us-ascii?Q?WhvONjUNc9YA0k9iQtXKKxy8zlxKhLhWXFOx/G5MzZy8AUoen1cDkyOBNxW6?=
 =?us-ascii?Q?3hSQxvWUpsGsym9nLm+gcSwk81gZr22lHD/p0jUOjNR9j9V4IgzK/S+JmU8l?=
 =?us-ascii?Q?Cthmd6pXscuzCW1S7L7qtNxoYUzPvXn0TqVhcq3Yl8sUeGsknh/KPZWLgc2c?=
 =?us-ascii?Q?52jl9x8va34wTVa33C4oZP5G4+eF0+N+9G70AqjI+LuvGjBpGe5nBdp+2xQX?=
 =?us-ascii?Q?s9pC6lDwxkg45utQ+LajpEX01OaiHWVs/oho6JO70nkTGtEj5zhNym5u/5hq?=
 =?us-ascii?Q?OYvH5cmldpUPGLXNV83mrIdZA+OHcGxjrNOAvtO19NMYWodfzRyXxx3G5VBy?=
 =?us-ascii?Q?CKips3gjCXRNoG3gI51mkHy+JTM1PqQbO82Bp00Ka5a9J7xcO8n8b1j918Gq?=
 =?us-ascii?Q?wO4/u5RecGJ4EPKYhuJvawhFlv3mWiQVHpzMgTTkpa6mqTOcx6PcSVLI981A?=
 =?us-ascii?Q?ia5CV5hmEUJx/9B8pq3fqujYrJLU1au+bpMPy65U39YvdGf76/cSSayZQPcW?=
 =?us-ascii?Q?rbCN83XZI3vqUgL9xlNw12jTSKBkvC76za8xt/JiSBb0LEeWcSy7B8OQH0/Z?=
 =?us-ascii?Q?u/rWDlGdP57EPNzd2/H50tkjtBm+F1KouYBzPL0S0V5+qGNKo/0AgbBDQoJf?=
 =?us-ascii?Q?E/rglXecsOMhPari1YnNWb2ddM+v9uN9lqWXatY3gSsVDAotglwF6CX+VVAp?=
 =?us-ascii?Q?ybLmqBQteZ8coFkO5Dnz/HcO6ahD0d4TZHcov7suQtq1YiPXvxXl+R5QfMap?=
 =?us-ascii?Q?MT5yx6b77NC6l7jsznq8DQ6Z6TuwaIEDjrrLf99dSZnDjEr2+XKoPfCSBznA?=
 =?us-ascii?Q?sTZupsAA8tFw+KOrCkR6Cp81FTZuB6dkDiOJpPKpwTTRmmWfQYCuf8ZUq3dK?=
 =?us-ascii?Q?08LeQdGjkav4kWhiuGKkGJ0uEk6nya1Xt+yoULLGhhOFWb1VV5U2Io6Vd2QO?=
 =?us-ascii?Q?t1ubmCO/veAMlLBGOWyRQnkBQ+987ruIaV0y5Tn5h6mPUatzLnShh4J9Rpgg?=
 =?us-ascii?Q?/w4SMUlZHiSlL7rM5M1a+IoXXmuKubplcY5bDbYbQUIfWL9CoxBt44uZC35b?=
 =?us-ascii?Q?g4QXKo1ooh8pTHcwdwSYZhyv3AOgdRURG5aqZevrXS2PYF/vBGrqadIf6lqT?=
 =?us-ascii?Q?wTCK6Gosr/ODjkyvyfP6KeI5hV/X7GQfpp813c9UWevp0StxBRULRVw4vlea?=
 =?us-ascii?Q?jSnrjl74QJNj/hFaZg70qox5oyp9PI2uENI7e905IQ8v2GZBAil2TmBQWGQD?=
 =?us-ascii?Q?wNZ+ZUMSGe+xx9a61tq24Lmb1/DXl6ZXpYILQoNzUBMWcILSTpKB+LQ4Wz9L?=
 =?us-ascii?Q?EPN/UfOEH0Aw+d6aDp2nvs9Ll/EnB8OKq3nBZ26WczhigHM6yGy9zz3H03P+?=
 =?us-ascii?Q?rzO0yZUURVEfympqOfAGpvnpx/KheU+EXpk+zzd0iJ5VlMMivBRXQMnLgydC?=
 =?us-ascii?Q?7A=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc63ebf2-51f7-4b2f-9fd1-08de1abb2555
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 09:27:02.4407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64a1VUQgFNV/udBIuzSJAIt92EWjBmd4UwXUi5sIwBA5AnTeDCk5sxYnQY3pz8ZL5IbSdCsoE1LrOKHrivFvbLn3yWRyEidIPF2nmPXQUDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7252

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Add the "altr,agilex5-dw-i3c-master" compatible string to the
Synopsys DesignWare I3C master binding. This allow Agilex5 to
use the generic DW I3C master controller while applying any
required platform-specific quirks.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/i3c/snps,dw-i3c-master.yaml         | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
index 5f6467375811..e803457d3f55 100644
--- a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
+++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
@@ -14,7 +14,11 @@ allOf:
 
 properties:
   compatible:
-    const: snps,dw-i3c-master-1.00a
+    oneOf:
+      - const: snps,dw-i3c-master-1.00a
+      - items:
+          - const: altr,agilex5-dw-i3c-master
+          - const: snps,dw-i3c-master-1.00a
 
   reg:
     maxItems: 1
-- 
2.49.GIT


