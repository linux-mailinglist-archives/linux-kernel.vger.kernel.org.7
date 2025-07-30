Return-Path: <linux-kernel+bounces-750808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5118B16146
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0840218C36BF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1132B29827E;
	Wed, 30 Jul 2025 13:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uFonMKff"
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011035.outbound.protection.outlook.com [52.103.66.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D93518858C;
	Wed, 30 Jul 2025 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753881506; cv=fail; b=YB8sHtjvR4hz48j3dIq/fmaPTT9l0qHqyNqU9OC62PlyXuSw3gJrBYjbsRyNt3Q98BsKKvfM6mLV59UXlLUvwRzW1x08J20wdB8rkmA2eAVjR+OJJ4EdryYyfrZ6rZ/kakSuKLENbtp45TplPIjQt2xThiURRKSryzN8JghfG+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753881506; c=relaxed/simple;
	bh=cAD9qhLLGAb4O9HkiiJx+TqZGoOfIM6stiObA657aCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bWFwLlu5Yzmriojeh3Jrxb9fnqZTMBhDMuHXpUKbngB64An+yD1g0Xm0T27BZAX5Zqfnq/fGbhcV2hbO1KZ6bpfGevXhWWbV0CFbgYYSADDiQf/bX0u8xvaOuF0UglaZuU3k+yGZOFc+iui6yoR3j5fU5zESPxxpKQ4ZOzUquxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uFonMKff; arc=fail smtp.client-ip=52.103.66.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tS9Ngeh1JQeFhY1YLttGpjYeFoxDe2UCUHvrWwtE9bQF1fr7y84Iy8J3pDLeqvDaJc24bLUHO/qB07HWXJZ38cjLaNi8jz5QR613s9yqJCCGmo0Kkir1t2J5t4tk9QLQmq2b9WH5GOu3CRa5m2Z5dpN0bU2Xkoxy3EMm7nWAPIoFORfd33obJY/4uQix06PxDBS8cXHqKRT43sHCkeKqTIo/ZNM0XX+DuS3AhacfR+aPC5weWzDhNcgkRkDNqIN8fvgStqZB7ZD13b1YKtT1MtmgEZh8coRk15QRtSsfwTPXffKGheNmXsQ7ggQ6ccU7+QLd+yp/HRCnCQYSIkN9tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqwtbG3y6Gy1sQ2x/m9TPU5EXDsYp6Mp2cCgdtqkG9w=;
 b=NnRW6TC+gFoC8pdvmlr7VznpIHfNK2lrRdyGcArXPXxqreQsVDVmiv5uJkVfuKAOhB/YWCro33ksDihPZZTpzum3hIbR2bz/GVFIaS1kG3HF0KjKcoDp1i+DCR41PB90MNac6xA3nPZsu7jGP0d1PDtde20hV1PuJZaUgAtFLoUNQstVvyqv4f5/rRbhRIfshKtMHyhWeCNkUwqU6D7ccTnuFM8iZiHb5JwGZEzGUZ7TGHuif9hPaesWkLGDilu0QyuQx0UuEgnLDgCnT4ypiHnUDGWgtTAFEos6FeBQjp0aP33q5TJliciqRIAJ5vFszuCd9BqMBzr709uEpP+Wgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqwtbG3y6Gy1sQ2x/m9TPU5EXDsYp6Mp2cCgdtqkG9w=;
 b=uFonMKffFBTLcZm0aHLha5WhwEuqlXfQa//ILBtkFpY0L1pJdDO+h+/aWap5DD5IngIti5fvTGcloPb5ErAqo9PCwa5ckpfShxvV4xrJzHre0mQIaEI+WYBgUqO+a9N9Edo4so/jHL3TxJ9hkTqAT68k5i11guNHUZMEnfPO8jFoSiI9S0+uQYlipaTPRTDyCivoFMnUSXKlKRh87HRiR3E3dKzcOktoneW0LxLPDxoYVGFzYxblybQ79GCLMEjvZRBSdJVGuSUxTg7HRUtmDX1kOAmC72Fnm4/xGuLn43BbIlb1ItGAq6ZOIgef+S2Qn67U1NKIK9g/t1tO7QgcsQ==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by OS7PR01MB15385.jpnprd01.prod.outlook.com (2603:1096:604:38b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Wed, 30 Jul
 2025 13:18:22 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8989.011; Wed, 30 Jul 2025
 13:18:22 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Srinivas Kandagatla <srini@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 2/2] dt-bindings: nvmem: add env-size property for u-boot env layout
Date: Wed, 30 Jul 2025 21:17:47 +0800
Message-ID:
 <OSBPR01MB16702D6947772E526F64D63CBC24A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <OSBPR01MB1670FF3930C3B1736E7EFC23BC24A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
References: <OSBPR01MB1670FF3930C3B1736E7EFC23BC24A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID:
 <20250730131747.30405-2-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|OS7PR01MB15385:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ad2c8bf-04ea-4eb9-401b-08ddcf6b8e9e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|15080799012|8060799015|41001999006|461199028|8022599003|5072599009|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hbUsc3ytvb4tRfKvi79wpTP03bv+dOCSUADdLbIXtcuD1WynVbpcWF9L+8kz?=
 =?us-ascii?Q?Dz+lbFQP0WcOqGwoLhlSSi0nU5oVFu8onm/vzZ5q7GsJC98iawAp2pfB5/54?=
 =?us-ascii?Q?kznLKDDWWIL8Ji8uYfMoFVf35v1CkMIJNzXR1Oe2jxd+I4eEmSXAqLeFnk+j?=
 =?us-ascii?Q?rIVck4yiPFW85xIhkVePJYO2CNB8Yfgo+U6lf332Gn4Aq3J4JJYmfUe6jJPo?=
 =?us-ascii?Q?GhS964cB5GKwPqpGTjpNO8HlAEQisIUFUj/aKR4W7VYP5bUyAXJSZZwn5zr2?=
 =?us-ascii?Q?2YYo9ev8FzBYRmSHv75ZO8h4ivcOHAep+MOYLP8wvueDVcReY4wN22ABGjE0?=
 =?us-ascii?Q?4YsXTZ9uvJ5m5NAXiZjRY0smC5WdAv6Stp6gQDhSxlzZG4G+RWGREtHobJ/P?=
 =?us-ascii?Q?7rDr2jLF0arVIPSExW4twlrjf1B4GQ1vjTTzNB6ug7neFF5H92GR8SncpTMH?=
 =?us-ascii?Q?tUa79Ox73QUkDk5W/a7GDQygh096ID4ahZg7bBRF/vJGb6g84XYZPrMhWdCx?=
 =?us-ascii?Q?ip4Aia6YU1gySzbtxXRFfPs+basJgqZU1uQZ0WZEQu+MN6WjsEhdTbEsHjQe?=
 =?us-ascii?Q?vWTBJq4IXsdxpSinpOxmL6zPRVRKFHu83e8wT+qSIza9Y8WqT0SJjDaOpK4M?=
 =?us-ascii?Q?1EnXwiw3TKu7wdGREKxmU0lZ8COgw2wBnW/E4/HPW3TqgunqtJWcachF00JG?=
 =?us-ascii?Q?0+9yKDXOm5G7YA1R7cSCS69O4+uwD5NKbsI3dRGWc/pA7LxzW+zWbIwVs/bJ?=
 =?us-ascii?Q?Km4UciS4iIh4o8RHZZeFQHcCov90Ot9NUOKxL6V7nU5367epy0r0xI/MjGhx?=
 =?us-ascii?Q?2Xxqvr5H1Xbcz2eD41cLGBAsiFZXuOTLqHXb7zxkEZPpn8NxkuGNjC2ORvMh?=
 =?us-ascii?Q?VQXj97Nwfh6J5Vdi7i+o7Wjx7hSpcIOv9zupdWWlqdyBLSTBBahi1F4XO6xC?=
 =?us-ascii?Q?kKj960t6iFTqmiosmqyVQp8yWYuDlmMIgexqnrItjFx2PKPw/VGIzFKTjLhV?=
 =?us-ascii?Q?7NV+qeGf67LUQINZZKRYuhjorMKaxxaNSM1dQIL/Ge8507Go7wbHPofyKQPZ?=
 =?us-ascii?Q?XP3OOPGsfLhnReGTbbX68D2kJQa0IbYRlNjnL/OFudmWB5IEY35cdexpcJM2?=
 =?us-ascii?Q?Y/t2x82lamsE+UleL7h0pgeDOsiue3xs9xWN65zl7mq297qpMFIV1Rs=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kYRRXpMGVsvfEor/gTKsi5pYzkCvTF+Q9spVkECAep5cg6RihyTJ4o65PhCy?=
 =?us-ascii?Q?op9FWRMZVjhVl9M77axojrCMBO8bXUY/ptp2zuIQ6LsyfecxBjSdHVZKjTwb?=
 =?us-ascii?Q?8vZ4W1Y0y74827JRUc53K03nZaNbfYFGtI2SVvMeBCuffUy326crF6GWdggt?=
 =?us-ascii?Q?j1b/FhFoW0nvZL2WLbXmvxBkYd5CzARj9XZFEX6pRAd+C80ZeJ1tbWMYRVXi?=
 =?us-ascii?Q?hB4ybZoxD44dAz7cWgUmVx6g6Ttrqhw060BuoXgMX/WP0CcDMN84Usf/zy6E?=
 =?us-ascii?Q?9AeAz7LUU/x0sULxTjclu3BBzubhCbfW/+99Kg2qTLrESZBjRfE0tBWu70w0?=
 =?us-ascii?Q?KlpHX0b/3RYrOea/d/ekdo5VTFjkp11zILPZc7ihPcuCfNRWDjq/Y8RfkG13?=
 =?us-ascii?Q?mgppIDfQarHilXHaAx+1jKEVhvplfK7B5PPVEIcZ/YB/7zGM9x8A76OPz8iV?=
 =?us-ascii?Q?cgtbjBk3ZroyBe+9dvi2FYJmVtuOZPVX+9TV/GqKVbe1AZ9/uKFgaPkFwLSn?=
 =?us-ascii?Q?t+gnJwtKya4UcZLcp9HMhR9dMzxXz9KfZYwg3Ibau2rsOw6j4LRfK6nCvclj?=
 =?us-ascii?Q?zVKNNElBbag+T2Q7imRLKsuCkvvPq2F14W/Byhfcg6vF4JZlrJdCKkTVr7ZQ?=
 =?us-ascii?Q?sCJNQgD9MyJ4ztUwwDZgXrkhGHGlzTf5lzKoM3AJX5ORJ9QxxycY4wWNxAVg?=
 =?us-ascii?Q?8dZPvj0Uhp3SoSG3VJ8JKG5y9/fo54Fy+gcJelKHn4v2HmPcBbERquSED5ZZ?=
 =?us-ascii?Q?8YelpfRqptSSTOdjDu0ptSJ5Adwdmo9jkKmvUGiuJRF9xp/+LsvhLRCombGP?=
 =?us-ascii?Q?kaA0vk2j4AgN7DSil5eNbFlV5S6c178bV0ELUZNEmWYJ9MsXoVF13pikDSPc?=
 =?us-ascii?Q?Csva6jSKAQBklwRIf9fsgaPErkH7TSiNChTftG7EQTV/vGWljaz1eL4Ari4V?=
 =?us-ascii?Q?S+3smwXJXt6w01c/kAKJob8YF76LqX653IWHKqjBuHjofSUEfJ4zkbupvr0Y?=
 =?us-ascii?Q?bfGoBdR5AvA/NwmT5BjdTmZ5Y9uOEIZQF6UEeUNXM7vgTYfnJx3z11GRUpLA?=
 =?us-ascii?Q?4AFdPObDPwjwEg7VJEuPiCoN6YXN7cGa57UjBTS7HAhSGPoSScwzN/vqoHJx?=
 =?us-ascii?Q?bi3X0urE07Qvc5rGhvWYfn15ZD7ea1y3ULehcyHp0Ns26zER1UgsaYxjI1XS?=
 =?us-ascii?Q?88YXgvMiMEAwTWE0aUxRIJzwAR716zd/cd2Cce06QH5fXkVqg8VGsp47aVLK?=
 =?us-ascii?Q?do7wsENKmjUkO6FkPjPt?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad2c8bf-04ea-4eb9-401b-08ddcf6b8e9e
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 13:18:22.0954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15385

This newly introduced property allows users to declare the size of
the environment storage area.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 .../devicetree/bindings/nvmem/layouts/u-boot,env.yaml      | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
index 56a8f55d4..e0b65a53e 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
@@ -46,6 +46,12 @@ properties:
     type: object
     description: Command to use for automatic booting
 
+  env-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Size of the environment storage area in bytes. If this property
+      is not defined, the default size is the partition size.
+
   ethaddr:
     type: object
     description: Ethernet interfaces base MAC address.
@@ -85,6 +91,7 @@ examples:
         env: partition@40000 {
             compatible = "u-boot,env";
             reg = <0x40000 0x10000>;
+            env-size = <0x1000>;
 
             mac: ethaddr {
                 #nvmem-cell-cells = <1>;
-- 
2.50.0


