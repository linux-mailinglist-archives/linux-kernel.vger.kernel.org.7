Return-Path: <linux-kernel+bounces-774264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D23AB2B097
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45D332A1345
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480962522B6;
	Mon, 18 Aug 2025 18:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cYr363AX"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013008.outbound.protection.outlook.com [52.101.83.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B250223DEE;
	Mon, 18 Aug 2025 18:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755542187; cv=fail; b=bGIPYWaSHPiyYxD/dTUcSI1KTpes3xNYaf2MQsZvR5hYujzc0bW13jq641w7U7tPYym/P6QJxqVf42sIBOsCJgbJ9yGAYJDQFJuwZgoHmxCICvlM1WxbQGGxv2RPfkqDVtYZgaKjwI8HyHnLOID0xh4RrefgGXzd5zfgKswxSgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755542187; c=relaxed/simple;
	bh=kXndgPGmUAG5ZFF7CM45Oaa25Z6vCfr126hhg7z97aE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AvZuzy0OdidnOwInHUhsmnUwQUSAYRkcNkplNhQSEDpJpdWGP6uBh4AUjiH9KOd5gPZcRmFUmQFDxXh/LW0AlbyQ/VDZNMc8kp/KRtgk0I7jHUEK/nc/rBRDUeJPRIAUvKSQ4/lvj6O1mYc9xa+WMMEKuCFtoT1bCjQ3QU+x5tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cYr363AX; arc=fail smtp.client-ip=52.101.83.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OW3Zs+hF41hfZraA6KRMYjRML2LNXmnGGoasOULS8W+p8zvDd4x1bI3AbTsqDMFBDbieHzHBi3vBVpwGicd6pKDH++7Txj7rMGoog4FCXcoSSjOAe97cV71zMs5P/uoGSLmDgufPGi6v20MYfU4qhMyQIyvaUBUOuINvoWCyV3ydgDgriZQFOoG775t3XrlDZ2zoS0WqOGE2L8EpWykVgYYpp3ReUy8TQdcoDiEMehufvO1o2yFpYU6aj1FicqgPBXu2ZhkvVzlOGyg11NSGFQdwyq42XCCZXq19Py3lNwJWh+5O32+WpWeplhn1xXXpU7fFzqoMSdQ666kFLe9c8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6EHWPMIsPQWkyu7lvQ0IijVHM9vWkwisEw0fniPBuM=;
 b=CuQhdCBBhqQVoI/ZCiWcJ8uJmeFC1uf1EJJar9vAUyzI+i+L9W3aSYxb++skggVFGM898SKugJRD5Ap1ij1OH0yk7xCwCheVf0yLIk9ywa3fFNXxiA3d+T7KMhEgDl/e+D0eX65mwCQlPuz/QbNTxzYXOPBykiHMNwxquntUXdn372QjYi4N9RzHPK4TePvOM/ia+o9zWPkg08vgcPt2zuVY5aFp0tADnKXObxu93/b2gyfNB82jsBGvbuWUfnJXbFpRq9O7GgtCvraN4yhm9zad4d+nBZBXDGoUwp4L6b6KfycLvJOmByK7WjXB81gL4vqZB8rgzozd6e43b1ltMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6EHWPMIsPQWkyu7lvQ0IijVHM9vWkwisEw0fniPBuM=;
 b=cYr363AXQ+KhlUchY88t/5l32WU8A0zQresmXGAQyDsXMW/WEgjaICm+Wp3Fr+hudyU+SHk3hLM7CVUVPOsRG8dqsvVUmNFH2czgtTgc1Yta8wBG0blXQC2lhKxFnYLXQmhavwgeT/eHtSaF0lc91tuaznIZpsloHazRy3WBDsxkSzyXVtO5/YoycIHaSW8e7RIeCmqLQpQEMIw6fySCJJPnL4wATzbTREJoMcWl6qRUxXXEC1Ft1d7mqEJ1LMNuuyLDtH3HRRE+Fv80nMY5szONw2u5vpKT4G6aCVnKK1NXPzCTUAi5kLXicCZ4NSPP1OtIgec7cOuroxdMWXXwpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by OSKPR04MB11317.eurprd04.prod.outlook.com (2603:10a6:e10:99::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 18:36:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 18:36:21 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michal Simek <michal.simek@amd.com>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>,
	Grant Peltier <grantpeltier93@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Fabio Estevam <festevam@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kever Yang <kever.yang@rock-chips.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [RESEND v3 1/1] dt-bindings: trivial-devices: Add compatible string synaptics,synaptics_i2c
Date: Mon, 18 Aug 2025 14:36:04 -0400
Message-Id: <20250818183606.3602219-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0178.namprd05.prod.outlook.com
 (2603:10b6:a03:339::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|OSKPR04MB11317:EE_
X-MS-Office365-Filtering-Correlation-Id: e313ad85-7a53-4e67-6d2a-08ddde8620ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6ZKGlCs5AihWWSTLwkTFbk9RPcac9dUzhXTCCFswIKQZQVOm0DfRog5N/jDq?=
 =?us-ascii?Q?P41GoTDYWnf/i08r0pajAf9mSn6pgo/6VA4ojqDA3hBZ3SaGYMzjmjBCtRfQ?=
 =?us-ascii?Q?64djxErI/zJgEr1ShiqMJRRVbGotJMbTHJ3QjnrNLfLPevTlgOTr2pXY1KJ3?=
 =?us-ascii?Q?ns1h8ULl9x3edOKkCLLjQfF0ZlHibme+paJoCBng3QW4vxjHHV9ELuThPypw?=
 =?us-ascii?Q?geyL9L/wGEcQln4kYS6+O0O0i0ZNXDAkzflYvKgDkwsGc6B8zapd83CTXv1n?=
 =?us-ascii?Q?iCEP+fpMxaej7OsjoEiLIBHHjh5TIcev999AcvSJlEEC/fuQK5/kOFVzMKsu?=
 =?us-ascii?Q?5S7vqFKyO1HNV/1FbHkSBB0+HoVS0j8gEJb8y+XviW1wcXeAygleOnj/eRsc?=
 =?us-ascii?Q?Bf2iYaIG0jsB1LNuwnWe+bNo52K3KwbMHVIZVjAOqV8YsZzYsg3nK+o4uxNF?=
 =?us-ascii?Q?XHIULwzyBeQN5IYDozIzGb+Ul4BhXqXa/qguvqb8NNXlAI7EgB/t6oZP63mg?=
 =?us-ascii?Q?UtKIuFm7Ppc4xfpIg/PuqhB1VZ7KjUxEbOlrL2r4Hqb8b+zziTBBPrztmoaz?=
 =?us-ascii?Q?4pfEoKcGyuUFq52U1EfpC2fiYfkPjCdjzmPJgJzUlVvkeDZ5ZiY79MbHYwoB?=
 =?us-ascii?Q?Sx9lgwWsVmQUpXKGupd7cfO4yy8V/Vgq6/TwKlC9mkPEGi1JYTdUGjt9gSUg?=
 =?us-ascii?Q?lCuieGktgmWE/ZfAQC2f8GC8cznFUJNNZvik8k2PwWx9AU53hf67sP3NpykC?=
 =?us-ascii?Q?JKXQdy8OczCm0Whvdi5XvE1z4MZr6WxBNBC0bQyyCsVuMglBiMTW0Q6EqzOj?=
 =?us-ascii?Q?UG4RCPgBC0A0eg77hmxBJ0sFk+2l9Li5eot2bhFSaRfMbXqZfsaupWG0i+2p?=
 =?us-ascii?Q?/ye5wASfEY2SyZWG1LXnBfirEnC1hywvFDf7+f2UjvRhVBnSAwoRUrLjbJ74?=
 =?us-ascii?Q?I4yu/QtcF8ErIBbVflSngJmVJR7MTa7F5i0rBUP7983qCQCM5ZZmOw7A3wtf?=
 =?us-ascii?Q?Yo4CpLrdneM57GxzeA8LaWLX1SG9zzyxh21J3MjAGJK/73SQxq61iDml+EAS?=
 =?us-ascii?Q?KgxHFy5276JiV1DLo8iM0M3FWmcrcdtt+7SZrH5Iauaym/pjcsHdEr3lvtvc?=
 =?us-ascii?Q?2pftVrXKEU6IlzpRX2+Qd0dZ8t/JB8g6nfd1N33EHLiXdSrwc3EzEu6GORbQ?=
 =?us-ascii?Q?py25iwhl3wrDLlLqJ8pkhZ+HzBWnXeeiYoQBhP7Kx0dSsERnKjROjCqxahU3?=
 =?us-ascii?Q?df8cmgqaTKWpBc9YlhQUEjKAxNYTzONq3SFMpIjrtKJQlmDjMR8h7SUAjwq7?=
 =?us-ascii?Q?/y65yTrmkVwgsgbafffHlP+gYV47wSGtqpiyrvNYXQ52dxhQwYlrP0mMQSVt?=
 =?us-ascii?Q?L/5caF5URBqIdZlHPwxai/6jnmRa6eLdtNbVemWq8FYsPaWJ7WqU2vwoAQfW?=
 =?us-ascii?Q?RNt66CaVvVI1Qyd6lS7n8mhZ5/kqY9k7ryOhTy5/NTjb/LCPyc5Cgu0KMmjv?=
 =?us-ascii?Q?uF9MPl52Y0xaWlA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/zrxUWM5FzgUT98tZpDTa9JOuF9CEcXygAbd69+luzTfx1EMIzJaTPk2wGEn?=
 =?us-ascii?Q?9UNbXTM8dxxqsJ+0bH3hkaniSJEdilYH2ztePUW5O4rSQsKyMFYY/5Vrk4g/?=
 =?us-ascii?Q?8DIeusOMHbX7xcJOnXA7iahXpJ7ULAID+n6ZYVl/XvonJFySWHR16x7WfOTY?=
 =?us-ascii?Q?xjCu4sffiXoXLNZIzxkEj2oxYj6GUOc294vRqvnVY3kxN6FO1vvDp0GsihJF?=
 =?us-ascii?Q?Wz7Pd4Bn22ziD2jiZhIGdy8MikmHHSWQWa4Q098g8Gg7WlXh98fV1a4/zb7b?=
 =?us-ascii?Q?sC+jsefXusaPgRhZd5Uk0BwNBN9DsYZ2jpm7WzwBhmRsWlH7hQcPYrCJZx3c?=
 =?us-ascii?Q?VuHocHbn6nw+msgNKYDYTd8D0uN7RrWF6zzkgWJ0c4ZtEQ4+MATBPAxLCQM1?=
 =?us-ascii?Q?IaI19RqlPxcWolUqfYBWoNbfKnJ6SSl4M0nF0biGzw4vtgh0vi4Ua7XW19yX?=
 =?us-ascii?Q?PGqM9XRL1RZEnMnbDQlwJG7Z0ORn+zyLIi8oIocaatiBhUV45X9br/QZ8lwK?=
 =?us-ascii?Q?+3V/qcRG6kRoT7sMJy++McN8wxPQ57QuzvtprYpKSyNFdloycvbjulNbSg5T?=
 =?us-ascii?Q?pFxm70B23FOn2eQJ5CkSSnSn3nyV7tTTet9kj3coY2gbkuVFUXl0+hbrEz1/?=
 =?us-ascii?Q?KqMIqcJhet2YEH5DjGuOinFbtIXHwC1zfoBIJmzVl9maCkjJ8QsNibdk4VJz?=
 =?us-ascii?Q?nGLalgzYKOCkY5+kO+tr8NRn8wLovEyVP/Cm7GQtZiuBPw953HjVrNda5mYd?=
 =?us-ascii?Q?YVcrfN2SwuwYvnV6EdVaLX6AaTiFoj2iKY01Mor17UFs9nVbGSFjy8lABYRk?=
 =?us-ascii?Q?qMNV0t2O8QWK3L9j29fDTwPChGkaZ5ikrVZySdsSsh1+92ChzW5381e3kLlV?=
 =?us-ascii?Q?kgo38bjbZ8j2kZOUZ79EGSny0I5bX39dRfcFP8jarIh3sSDeuQyTX0vwxqN6?=
 =?us-ascii?Q?ND0Uo48c1knhQScQsVNl8wS9tbFUUEU67SAFKLVSu22jROl/UHUATdynzAZ0?=
 =?us-ascii?Q?vy+Zs5dDrzMx1iBD3sfR1WZCSqMwL28+qrLxWpKLzKibqq5WMKE/ocS6vZFN?=
 =?us-ascii?Q?KIpukJja7p6Zm5FvYwiKrTfvPIS+cvhOzPCxkOdctt3jI0b0t6jEIgX+Tmsx?=
 =?us-ascii?Q?YvAcX1GHL+LM7Z/AB8Xt50HA6bZbvYf8Uh4NKkZCTcX+WSpgNe0JO68kRgDb?=
 =?us-ascii?Q?WbRYoygTYBTG3CexLKQkVpZdsaz/QkVjz17PkIcHdefY9RiazlkEnowrQFbc?=
 =?us-ascii?Q?N8gJENsyDt3hFqZ/AC7QvHuLXYo52cqaLQ9S0guUehHu5+K9r60ym2UTv906?=
 =?us-ascii?Q?6dTwkCAOkwHafL2qC98DxGV9wEsrvs0+XplUJqXURJnd1eJLD6/Pk64T9DGp?=
 =?us-ascii?Q?2UZcS8431UXE8LxXQkzSGRhE/kTHM9IIuvFWbv3J93OAkdVBLVh8BOXqps80?=
 =?us-ascii?Q?tkxtmx3Ew/jTZse5LnbB6kFu3lfBecbFtDFW+eTYt1SIrT/6yWXO0tk2uWIu?=
 =?us-ascii?Q?aLIctzSbUUomN9Ky3HbD/z0bCrwuqQ0vSHB4eEJPyVoldO5CbFy9fyg+c+pQ?=
 =?us-ascii?Q?V4zio2tVtvgX80wgCeJlFcC6JaGUNgnkgGlBp2W+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e313ad85-7a53-4e67-6d2a-08ddde8620ab
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 18:36:21.4399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iA4OZkPC1FzXbkyishxtz5nHl0PgRVIoKOCxhyJbvXkKgSzgtUOg8qkPTX+v6Iw1+BB/MvTUWSvvafK7n9R9dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11317

Add compatible string synaptics,synaptics_i2c for synaptics touch pad. It
match existed driver drivers/input/mouse/synaptics_i2c.c.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Resend v3 include Krzysztof Kozlowski's review tag

change in v3
- fix order in vendor-prefixes
change in v2
- update vendor-prefixes
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index f3dd18681aa6f..8db4596c616b9 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -395,6 +395,8 @@ properties:
           - sparkfun,qwiic-joystick
             # Sierra Wireless mangOH Green SPI IoT interface
           - swir,mangoh-iotport-spi
+            # Synaptics I2C touchpad
+          - synaptics,synaptics_i2c
             # Ambient Light Sensor with SMBUS/Two Wire Serial Interface
           - taos,tsl2550
             # Digital PWM System Controller PMBus
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a92261b10c527..ec114191873ab 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1512,6 +1512,9 @@ patternProperties:
     description: Sierra Wireless
   "^syna,.*":
     description: Synaptics Inc.
+  "^synaptics,.*":
+    description: Synaptics Inc.
+    deprecated: true
   "^synology,.*":
     description: Synology, Inc.
   "^synopsys,.*":
-- 
2.34.1


