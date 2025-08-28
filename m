Return-Path: <linux-kernel+bounces-789943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B27F6B39D30
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E392318993E0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8606A30FF27;
	Thu, 28 Aug 2025 12:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="D0Q0oaCn"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013062.outbound.protection.outlook.com [52.101.127.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E63030FC22
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383866; cv=fail; b=AsSXRW4tHu+z49P/fIpcg34YSqLkN13ZpIZiCZh73uPjjJI5UIcdp0Sc6O4RNHQi7xJBnSr/QhMS5EKBgeQP6DUCn38VCI8fCRR5n/I8MOw9kFG6ez59uIN43rZJmubut8p4YQNZ5qXyJS+eJ6NChs7IzWYlpLEdGQd3Nl/L2qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383866; c=relaxed/simple;
	bh=6ge6yPVmxQ7Rgwq91Qo/razId73cMGXLF9aRnm6r6Ok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=msXFOCIgL+DCIanI8GsGC653+CUA3c/ESbtufFatYdO9iZbqr3vUTdCHPBzwTXS+CHNuQ2Yurn9CRvdJQi+u8d7TVVz76kRrAnabG6Dw9prVaTYA/o31wwJHT8hBxCmu5zimmIP8tx1nd88eMuXmhuVfzcDB8dUn7D6hpRs7goo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=D0Q0oaCn; arc=fail smtp.client-ip=52.101.127.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrqWxwAlK/Hs3ryQg2jvr1+dz0btsXDflrZRW09pe3YtwmtflhfAUtkAcBgiH89ipiuYIS0sTIs1TGxqbdbhkMhkSRkAQ2Qm696JJ5TELKqOUrj7wTf7t7amJc1yaka4MyeNiMVlpBh0l0nSwi1MLUi4J1x3J0iYIVuWAZ8aLiuC1F8JCtjFd+t9sSp/Om9qM2Ko2ksYnrAXRWwbOjQwj+TJnBcWO9gncoBn1brQEfV6EeJ6ApO5iaIii1n/5yvhiBi97IGpgJy1i3j3rymkcnvjvnU3od2WpeVenwWSXhaAiUxhuv/Tl0GwcJ7mf3PdCPo8zGDz7e8JIXqm9FzhKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIxTNZf+f91cusEf3LG+dR3T+eRzEjoGnhqz6aUAlJY=;
 b=t2eSTgX02AFaXXjlDwIfoN4YdMsj8EOPg92x6tjCgYqHxIiIr2jZVN/lIEcqp5oM3//0M114vBkY0uP6HSwnp7z9DR0YAieY6p95kvca/FbGJr79HCi5jIIuGd1H6iJu+QGRyBa1ClF82oxPrLa8vsAqW57CY5W6lodL0MYY8YweKq/zCmYugI7ZO5Bnl3h1JD6YABlHweYxV44losz3cdiiVhR8MPSqESQvJ1aNQ9guQ0uwu+syDRkJOYpPOknoMuVI7yup47dsFpUlG/l/ei0cSryqITFCWtmAj4gUaApF51S7KFomS8N+6D1stl7EcUPsy325og29KUlzHCL8GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIxTNZf+f91cusEf3LG+dR3T+eRzEjoGnhqz6aUAlJY=;
 b=D0Q0oaCnPkoPWmkqfR4cn+gZWIO2Y7/Wq0ZDTB1nn2NM4tKUTlbrUrglXqQ3mWv8lgxm7xS8wFFJC/sSErYgkBzoRBe3BgMRRvV36eN7zmp3nrLFzzKwdBxJs12191MpixzEjbiPCEdaJK6wBSa/mHFkPbkLUxwgTu6wzHyJ61riRE9c4J2sZsMg4pWOU3gUuNHHG+eWpx39Zo/dRDdwoj2v+MZn/y+O9nZ+6gHQJxvHRz/QvUj0R0e6PZiQXaxbSPdYDIkjy5KX2RyJ8jjhn54Qj0dzJjMfEnxM3prw1f9UKYcVcyOjtato62QVSYPqJv58jWyMcu4upsMmcNa0UA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by KL1PR06MB7287.apcprd06.prod.outlook.com (2603:1096:820:143::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Thu, 28 Aug
 2025 12:24:21 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9073.014; Thu, 28 Aug 2025
 12:24:21 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH 3/3] phy: rockchip: usbdp: Remove redundant ternary operators
Date: Thu, 28 Aug 2025 20:23:57 +0800
Message-Id: <20250828122401.17441-4-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828122401.17441-1-liaoyuanhong@vivo.com>
References: <20250828122401.17441-1-liaoyuanhong@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0127.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::9) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|KL1PR06MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6596fd-c729-4576-b451-08dde62dd118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jVuB2sXT/9UToRB0rhpM//YhiNhBwAziG74yP0fPqoxEMIyW3Vt289yjMWH9?=
 =?us-ascii?Q?DEQEdXN2Fc/k3f2L9KIqV0U7lpnYrIPAbpwvKPG2Zrz7lSEw6s8NzA7kij/c?=
 =?us-ascii?Q?8IJEQLPYR4f1hwsISwV8YPD8QNaToxomVoooMjWcJ39NDwx92oUhLWDCRa0H?=
 =?us-ascii?Q?tjI8X/Lq7cO3m0VQFH8bMiOUeDEKO+G7J4//Rc5k5gQDECfnm1XgCb1OGefz?=
 =?us-ascii?Q?burTfD+vz1HVmaLXKY17pi0JPetGCggX7FkAL96yBrRYzxYksSMElpyghxJp?=
 =?us-ascii?Q?5Qoj7BAFVjuNSb9reu/t8dhUVOjOlKTmVe0VDmnjn91Fx5YEYwfLuC5xdTf+?=
 =?us-ascii?Q?HLAwqzNdzqScyFPRcas1Ay1c8MtG3X2Fb1WTS6fErPO8wNMpiao5lg1miRac?=
 =?us-ascii?Q?kIZ7fwLQ8G6XxD8pTCvsG3CgJO3om0MmGvd5dK1Bx/wDg8WmJjPc0F4ld67P?=
 =?us-ascii?Q?kirDmJwB46WvGLXHtiyem/goYJQ/ayzA8upGaM4QZl3vorik3+w/lhKVqOqx?=
 =?us-ascii?Q?ZnnZwubmkdJXdY0i2uV1F68y6qSa8pNYc45zVmCqrdd9zNJl3v0Zm7cucAup?=
 =?us-ascii?Q?hFCYtJHnrDY2rnZZRuLGvueA0XYhuzJm8LCDlyU/4slD3Rr24JYgHoEo/fsm?=
 =?us-ascii?Q?JydAAWKPDYCn2XqP7cmHDzQN0VJpAWo/8Hr7MldiNWWhRv8DZ2sFlP3FiqTG?=
 =?us-ascii?Q?raXwMdAYloUQ/MVRdInQTWlIBvl309Uxb5RxTgi7gAxM3o+t1Wap89IX5lAI?=
 =?us-ascii?Q?KQp3trqxBlZ17BYNJ21onEDQozp1LAkz9f8GPt6EeRTSi6uFpoNh/htUaIVa?=
 =?us-ascii?Q?Nby2ZlchuORH4MS9BZMNn7tEfYN1Evhqc0LBEUo0+Z9ZxK0iD9P5HBf+p4nR?=
 =?us-ascii?Q?8nUsNKM+qm/k4D7oWaKTPzpfXG73j2/Gu5P4SUOqKcPkcwVcze7BWj8Sphv0?=
 =?us-ascii?Q?p/JA21iKITFqZpMdvA/e0xkin2Xzvba8atGLjX7zBVmExyY/uD2/5p0AIzbg?=
 =?us-ascii?Q?8/Nqjidc0Rd4TmWc/0ayYl7BGqwiu0uMHH/y4DlIUihKCON6xRE6Xvh514a9?=
 =?us-ascii?Q?cYL3XrWTrJfivveg6PNUAMpevHa+FoegGJzFjLEggVC8tnjbBMFYN8UbUFMl?=
 =?us-ascii?Q?lDTovAZPICfojTX6jJjh7EkVQZNxTk/YgVTgQuFtyVVFmJEUpKmH1QNaTTnL?=
 =?us-ascii?Q?LKeG0hJFgBkCYUdA/UFekqmT/YJNIc/iKldTku3kzo2jXeASIizcEZ8kPEI2?=
 =?us-ascii?Q?eofmJ1Bd/J5KdXhnWfR6it++gJ2zHym+PZq7412jBKYlrpWA7pyHMoW7sYTY?=
 =?us-ascii?Q?7JdFKF4Py4zDXdxYpLn1QloEKU1GOWI37QEk+xNbDg7EMWaLM7bCSFbZHLBX?=
 =?us-ascii?Q?oIoUGkQemr56lpXsO1pfTFbCFxpah+QyFrRI+eHKIiG2R2eTqnQ+kKPEBZSe?=
 =?us-ascii?Q?8uXrSf6JmjQvPn/OORANUfT4wBkSStHFhLk9JkeK8ewPV+gDZCCHvQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tFlT57efZ3nkX+4w/lJ9wZaWpNANQNnzPwcwTbAjMD6tVenYT+at+z3YCe0S?=
 =?us-ascii?Q?iR0O9Pkq74fjkqD70ROkIafcKfYTPi1+cIQ41NmLnYceSuHws8av9z3VLh5y?=
 =?us-ascii?Q?xQ5ty2wymCrj/dasAKIrlwn/+3nYly2bC8K+L6gInGGE+5uhNyzGGVgeHNkv?=
 =?us-ascii?Q?TL0HQ/LV/bg8WjUipyeRg2dNc5vfRmmC2bsxCbc+ijpjdFI61kkSieXH5L86?=
 =?us-ascii?Q?wfqCBPqkzuJA41z6uD0Lu24CY+w5rLkCL22xaxzhXheCGrJddRe3G/MZAu94?=
 =?us-ascii?Q?AvBnXmrB/eY/9WZchOW67vZO2ozocUWf4HLaFXKUyBdedkEuLIw5E6SZurzV?=
 =?us-ascii?Q?SvaRlJbd6pGbBjc0R0JZOOP1G+PfMza5UbyatXMxP8UaFBGz8Yl4HYhKTnjo?=
 =?us-ascii?Q?mmwd84XFnIvSpsQM5ZYruoJfK1kosqW/q/AhThwbjURwi03Iv2p+m1PaGb6f?=
 =?us-ascii?Q?9lyvxOS1aEvtsx95NKzRyUkP6v1pwtSoHr8iXZpNYCTgzkRJ/XjqhsCil+W7?=
 =?us-ascii?Q?V8y4Fl4wtPNurWZW+pp016kXn+COk90v8O1rTZ34LKXoTDKhXFjl6kxwhaLw?=
 =?us-ascii?Q?kMM5aJDrLYkvvh8j4PADfgTTWPtY/Ha6vrn3SqLX6OkPlWVs/DxpLadyBYQO?=
 =?us-ascii?Q?uYjLgiyvbwIMc4SsWlRHRWEwFHGpv1BFUVZfPDbEF6iUTIqd3ywIor3tMbg7?=
 =?us-ascii?Q?28Ntvx64+SGoglYdn0z2mzoJDRheoZg5x15cd5cBW28jpfYDQ7Ya6/3cgBlO?=
 =?us-ascii?Q?hMQL+Zsv6fZSLdbhc571ne4mhh5XyTjXiUnh0PYwQQDAixfa7Or/Grofl8dy?=
 =?us-ascii?Q?bUTthOiiUR3YSm7t1ZFwQaTIylydNb0/03NlEZDNRdm5JsgpQHy776ePDXG8?=
 =?us-ascii?Q?rW9Baa8wcDoa1Z46uioXZlmtOTch9gNgiHM66kiPGPeD5nAvoiF3LcK5y+Ez?=
 =?us-ascii?Q?e1RLaT3KKth5aHhfe5aNy1VVdFndqntAQuT5NlsXiCnmLm2e4iEOi2eAe6q/?=
 =?us-ascii?Q?NymjjzqCQs9TeTtFEypg49CFrpn0RbUo3cusEcRKi3kUBr+s1FXbUGl/OHJj?=
 =?us-ascii?Q?X1tbFnKgyV3OEiR3kaUfVtrtdcQVT2n9tDtJja3FUWtGaaIZHIKZk5jsbCUu?=
 =?us-ascii?Q?UOmXZCV/YF1BXGsZ59I1sGqVVj9U3fyWtCSZjcrMw95G0f+Pi7o91NOu0Lvz?=
 =?us-ascii?Q?7sQF8vgp5DIVJIL/Xa7Kb7lN4+fd3pDGO6APVIbi3xjQFeITPTJuviThhBFQ?=
 =?us-ascii?Q?YI/GwsKzDtALF+sIsZ+S3mEzuPPqSzQ/3o6QKbuPMfpaWJMaG+3nMST6lTAw?=
 =?us-ascii?Q?ks4iGI1GwRZ9nOXhVKAFo8rhwN//K82DvhDFFVcDGZI/7xzDVd7E+Q5dqbQE?=
 =?us-ascii?Q?+am9GzKg1JTWwDjm0Bg47TivAJm2Bam/dSCpCeOgdA2grQp4tQqgxL2GtP4c?=
 =?us-ascii?Q?uVR8m8jg+zBrQtRYJffC1/1/dlrGYeNDhNviqG983qXFdgVMN0jbVXQSw28F?=
 =?us-ascii?Q?8JUTcALbk/rMchmg7tmtqAjnhlw2XMBCbDCpDOu5ciI08gJbKFLSeRt38qz0?=
 =?us-ascii?Q?+CztnW3yJpNEPcO+fAjtmxt+62zcqE8nDmKS6XDb?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6596fd-c729-4576-b451-08dde62dd118
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 12:24:21.4492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mjw28JrZP3CL0GzfgYhRZjP96XydhPx+6GFz5jMznXYFLlYZexcENoDP75i7vwyRdj5v6Azubbtn8RTd779BjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7287

Remove redundant ternary operators to clean up the code.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/phy/rockchip/phy-rockchip-usbdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
index 010e9d2d6fac..fba35510d88c 100644
--- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
+++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
@@ -666,7 +666,7 @@ static int rk_udphy_orien_sw_set(struct typec_switch_dev *sw,
 		goto unlock_ret;
 	}
 
-	udphy->flip = (orien == TYPEC_ORIENTATION_REVERSE) ? true : false;
+	udphy->flip = orien == TYPEC_ORIENTATION_REVERSE;
 	rk_udphy_set_typec_default_mapping(udphy);
 	rk_udphy_usb_bvalid_enable(udphy, true);
 
-- 
2.34.1


