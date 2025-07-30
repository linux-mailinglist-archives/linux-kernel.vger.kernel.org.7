Return-Path: <linux-kernel+bounces-750807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E93B16144
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018E33B3D36
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F4623E344;
	Wed, 30 Jul 2025 13:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EnUEGKHv"
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011035.outbound.protection.outlook.com [52.103.66.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CAA14D70E;
	Wed, 30 Jul 2025 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753881504; cv=fail; b=CWcDouhzy5B1B8qbLx9GQC2f6DxKDUgZs8mGbNROjFBuTY6VqrZsXXHPFZ8K0MyyXd5Wh2M4MsVZM/fU/wuBEEKMFX0fPgQ0dA19gRnP+uFqLnJeUKTxJsbf4bA842q49fHo0AmhzctuP0mX05EFmNtCGdWUWsuvyMrfR3xgjJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753881504; c=relaxed/simple;
	bh=EaL+/8r7X9QBL8zt58OWF5UPrKpbDmjJEvSTgBRQOKU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=O4HDae0tmEWdgq170vx8uvtcEoFM6D+TmkVPxIQocvzCBJRhtNKC1lchrBOnNUJ9Wz52w0KFjQHVLU1QCJTI6G2vOE3C1xwbW94BR8CxmozN0gHW07v1DGR40cdAbpN05Me3ffhYvrX9XkWI59Rdu+FbABadTiNyHV51PAO/cO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EnUEGKHv; arc=fail smtp.client-ip=52.103.66.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxR0fDU253NC5M0QIw7xzGh2iBs8fCvueQ4b3ueu5go4ewSBB6/qIVtsA19mfGsTgpN6g0xucfG5hu0df1MwZqUUKEJXaikad3l1FC9jgMJ8WUlT7ZNe8R2jSEsmOLcs6rPeqB+rrxqoKKVWm94EYBUtwBH2DIDLnAIRd5KPAJ/BSWdz04dJbL7gfjJSp7K6c7nGxwgCiM4PAtE3+5bwZhhHYJEQz8sHE7MamSHvtLAHy+HMR8QEanFHSVgC98yUfDftC/Y78ISuz9AhiZPzl5qjf+fBqWiAJZLBEcXF7pC+tVe9B54cHqfb875MeNeCBT+c2fHGRoHE5RqNvMWSVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boyUC7JUtD+jZbzY/zBrEgNRvgPlPACW9p/0aI2fO1I=;
 b=xDubd/dm8hxan9W9/txVjDgO/KsX/5KGl3em85df+69yW3V1ykKg5wDU8r+SMbGpkWv7nMTrb3DTYHm8zsZ4h6PgCwQyIxNRu6pUocvBKJfdse97+Uf7WEoRzE8wBPym1GLDLk412rC+bnKlE1U8neU0KuMW0Im2yI5sgHxXNgdWlMGsvbGkkohQlbTqU7tXdFHngfM5YVBDVKtKDYZiSIxFKceZyv6CN1Gidm/iKCUpdxC5gXjMA5yk7w9e4rJJuCDv7XB5Pq+2J3V/Obs+zs+mjwrNrl0axIR0Bksi+FE887q+qvIilDWdVBM7a64IDOf1pswLs0lgUrIGBszeSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boyUC7JUtD+jZbzY/zBrEgNRvgPlPACW9p/0aI2fO1I=;
 b=EnUEGKHv8La5IN5vTdKPtg6R5m0GTdZCm9FGPMxmpTJZAHd+ca3JasI6pLtLwNoU3U6ra5NZodbTnQ1Rh+AXReSNK0JxxNdk/2ah0zp/zpByJ/OwKCf5Wg48aIEFzSG4YTTTxeYtDR8MkYY/t2Ba+MM1otnThcZMPtEsxTyV+XNFgc43Me6yTO/Fv8sYw2H/oAzs89zbmpU+sghhHGi/9f7e6oa6w0CBsbpPSjNA5ovpiCZ6YpfQGNvyMwSm75HU87oJm8njSNdKvWnWAcBYNjfgbuDGUymQwIHch4cyxvLuHHm9j/vLorjPE9PcAXXB5Wh1dyXqhggk1NCKSKXaAA==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by OS7PR01MB15385.jpnprd01.prod.outlook.com (2603:1096:604:38b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Wed, 30 Jul
 2025 13:18:19 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8989.011; Wed, 30 Jul 2025
 13:18:19 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Srinivas Kandagatla <srini@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 1/2] nvmem: u-boot-env: support specifying the env storage size
Date: Wed, 30 Jul 2025 21:17:46 +0800
Message-ID:
 <OSBPR01MB1670FF3930C3B1736E7EFC23BC24A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID:
 <20250730131747.30405-1-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|OS7PR01MB15385:EE_
X-MS-Office365-Filtering-Correlation-Id: e28cf2b8-b6e2-4816-05e9-08ddcf6b8bbc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|15080799012|8060799015|461199028|8022599003|5072599009|5062599005|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pyUerXe5Ep2NRWN1LNiZFWM5ps1PcSXI+ONiub4vVJy3zyKL50/NU0Qo+jk4?=
 =?us-ascii?Q?INHSsWXxqF7b7uoWL5IHUSrjH00QLipDH7sx9CyBgcb1LEe+FvhZFFPeMvzx?=
 =?us-ascii?Q?1nytOr8M7SvukD1LaOHOWx77tny6PRAC1S0DNZycVEuxMeSQI87oYFPI6q7W?=
 =?us-ascii?Q?rZVrHfZEwdJGX6u7WQ58gTk5a6k4IsoOO7ojjBIULAkR32UH2Z7dZYcWHxCC?=
 =?us-ascii?Q?RZWTEpmAezdf/QeMBOX5joyDKLZIK/5yVXtvTqPWfuPzjQYEWkbZ7n65+XMg?=
 =?us-ascii?Q?Bm7ULaO0Al4wtU93tSk2v4X5vfz6dhmJ7xO076ByMQX99OBApkbmZfQSAbd/?=
 =?us-ascii?Q?0IG9eXai/cm3vvVET5Jrxa1KdmvUEXt6zsi4URyEh3AB5Z/eagWXtXj5Jf3T?=
 =?us-ascii?Q?oxTUO5EysTR9RirV0d+UbVX6nfOkLZshIEZocUfRbj2GnfNcfSyc4t8Xsl+C?=
 =?us-ascii?Q?YDuMOS/IWccJ7n1ZnfHfm+RIC0NtaUuT/0VcZsjoEb34ntvYHKzsIwobQyXR?=
 =?us-ascii?Q?v93p2+h3TZHpWi0becFByu7DIRyjc8jWPXqoO1xpOTwmkwiDP/VgmsGnNumY?=
 =?us-ascii?Q?ISv8/0dOhQa4y2TaKExvtsV+Ga4SM9EbGBOWkObIgAjMJ58Eslr2dnzY+i5R?=
 =?us-ascii?Q?WARpTneID1ZO2y6/TD4W90Xu2WX5GqFsj7Iz0cfTGv5Lt9+skIPFxw1iJi1l?=
 =?us-ascii?Q?E9rZdTs5b6Zz4Xu6ytHaq7qKqqPqYI7dZ6mgtyNod5R2lGNSsfNB3mv39l/f?=
 =?us-ascii?Q?Wsa+X9zjqj3x3JB+FCC7QSc8rebDi0XFZ6gVz0nnUEC4yLKwTzuv3Lpb4Wqm?=
 =?us-ascii?Q?hpoh1H7Y+/PfKWyuiL831HuKtw5iI+i+HNI75RnndS7e5d13f7CzXMTl51fb?=
 =?us-ascii?Q?iCp2NceTP/jG+WtoLwc6kzCvvqol3YWQsbW5vSZ8gF1vTtor4qmaEcM2EwHa?=
 =?us-ascii?Q?zptHSBSp8NcJhZy+GF7tdLDtAwQz1HUqjJG7iap3ZPLSzesQxgHx5neTskf2?=
 =?us-ascii?Q?W5blmpgy5sdS7ejo7RsZlM/LPy0dsP/Pw/22zNIpC5gkdaBa9AqltBSE4QzH?=
 =?us-ascii?Q?GxA5a/gFTmoeb1RhIYEpPMnwZdai5/D+lz7pDNYIRewbzVHZA3CxDxJR5eaS?=
 =?us-ascii?Q?5BDidC11PAGM85ZTBgkRfGpA5F9Rrz04VCKXaprxA4V8W5Vh8iWhGBA=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6CJqhMQar+Z5hyKiFkcC4PoIMnAO9yKoqjG6nQqscywZbS+38PdEYSsx+ZSn?=
 =?us-ascii?Q?j1uvXtJtsj2UkiPRdkl/i+ejK+R23C47QM0GSFvAei3m5KRei1QFUdOiOb2l?=
 =?us-ascii?Q?aw7zH1kzLqmT5b84XB1qIgWl4dubS8bwVk03OqiNvU/W7V3u60UVkiOYEuCM?=
 =?us-ascii?Q?m6FtMvTDt+5au2Jnzy/hexWZqoB3ZAJSZA3Lc18OywR4JBcvFUs93RFgw5kj?=
 =?us-ascii?Q?jd/ZnsBcuEZMdwJgKvIICC1Kmfk3fGArEZWGa7e9D/fzvS3Lu3JDhgS1++RP?=
 =?us-ascii?Q?o6ACjv2HpeQCo3vCwUDANV3UCk0AX0GcCXvm0rFTOVrKXfgvCaOhNVoa9ieL?=
 =?us-ascii?Q?HfF7PtPeeSvYS8mhtyHMbU5FAsC6wrEKBqt9bC0w5HLJEZ7+gSfMee5o3Jbh?=
 =?us-ascii?Q?y/h+WSnDTDGkLIWb2vGgyHLF0wlgR+1+m+IMB0JDnpj65D2bpVXGeSZW4mba?=
 =?us-ascii?Q?bVpakXb5GzwOO3G264adCni+fUngkLU3pzk2w6XBg1s/Se4wEYt3E73hCreT?=
 =?us-ascii?Q?UBo9lsbbUyoPhPZ8ZaWe6zGbLqfmtkZNiXKCBL3u546/bqOhJIMubD3m279V?=
 =?us-ascii?Q?HMm/sC3I4wrMiC+PPBFN8VmzSDZHaKjTC2DbISPLpo4CbDknjhREb+BnQ7qm?=
 =?us-ascii?Q?ibywDlwfgxZwxsT2l0LhZm527lWHI1GeOZOgpJ9T4lk8e50dwTWn9/Ha6dC8?=
 =?us-ascii?Q?1fUnV+5t6tSlguXyg7j+u9iCi0+p2qMwFBK0z8ZFMatGQicuz7MlcJHVpJ+S?=
 =?us-ascii?Q?GVLnE81dQOqcSB9cwUWzq/gGLxdjU+2M38GaTSRv1SQqiPcIyeSluvWnCPGP?=
 =?us-ascii?Q?ocK4Y/UrvpeCvoZteA/2ycdF8VC89GXCFb7jGpNw+CZYMaCkwxlsF4JA/5ZF?=
 =?us-ascii?Q?nKh1+pw15M/zf/0bVFjMd1plFWIXMLmyBq3UaQgoMcM/JB/hSDh88w842LHH?=
 =?us-ascii?Q?pSd3T8G1BDrNXMxwyBQYVoCu20ySUqELRAEm2jTudD8Jvbai4Kwutb0WHWZe?=
 =?us-ascii?Q?SXJ4xFieq/AKQpVWGgdALBc6Rbu3vRdIkfMMh2bSGcAqZeCbfLZW5tKw9qx7?=
 =?us-ascii?Q?GYuIMi5ayrmt6Qapjp3DOe3hT7iYAm1U7LeKpnlk/xJuOOVaToUHRCH/Dkal?=
 =?us-ascii?Q?1VbzcenLHysDmiSuARPrBjI6Pd2o0nbtn9nuG5KekMN5xdUCAz/Rh0bezOoy?=
 =?us-ascii?Q?obBS0mzjcOeDNed6+q9ae5EUeegwIIT8CzHeYzk2gQ2ckYuSPvEbXDv2dHhV?=
 =?us-ascii?Q?HyP19Faq1bWzCWeY5iKX?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e28cf2b8-b6e2-4816-05e9-08ddcf6b8bbc
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 13:18:19.6455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15385

In the current code, we always assume that the env storage size is
the same as the mtd partition size. U-boot supports customizing the
size of the environment area. If its size is different from the MTD
partition size. This will result in CRC32 verification error. This
patch will introduce a new property env-size to give users a chance
to configure the correct env storage size.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 drivers/nvmem/u-boot-env.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index ced414fc9..ac9858010 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -52,6 +52,7 @@ static int u_boot_env_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct u_boot_env *priv;
+	u32 env_size;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -68,7 +69,12 @@ static int u_boot_env_probe(struct platform_device *pdev)
 
 	config.dev = dev;
 	config.priv = priv;
-	config.size = priv->mtd->size;
+
+	if (!of_property_read_u32(np, "env-size", &env_size) &&
+	    env_size <= priv->mtd->size)
+		config.size = env_size;
+	else
+		config.size = priv->mtd->size;
 
 	priv->nvmem = devm_nvmem_register(dev, &config);
 	if (IS_ERR(priv->nvmem))
-- 
2.50.0


