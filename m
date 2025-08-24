Return-Path: <linux-kernel+bounces-783673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D40CBB33108
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 16:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1471F204DF1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 14:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97A62D7DEA;
	Sun, 24 Aug 2025 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="ppRpiOLT"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2137.outbound.protection.outlook.com [40.107.243.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78307189BB0;
	Sun, 24 Aug 2025 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756047391; cv=fail; b=mPJcg+uHs6QUsJPDpdOWGuDkjVPxe6O7hUED6uRqWG8+l/lH+paAIWgSLVqXYAsKeQ0AUlKX+vTHesclUTdArz5T17pDXZkktWioUNb4Du8gTITzDdyYuhoRyh9CFjCcEptLJcw7BeQT5tFA4Wzu2g+AW0uJxtVnaUzlZEaffVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756047391; c=relaxed/simple;
	bh=PNSQ2YL/exiCKcVkXcMD6ewdev328gM72mLwViyZzcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZVMu+ovUje7V6b0oKn9xqdkSbhov3OwN6wfKe0vE6PjV3CJj0MIZGCV05GQIbcVBk5iR10kCo/NrOZLLutJpX/v2UfoIsOBz/DAE/KBrAiPfK4nmVodJpUkhlQFlOpckMG2szpTcIQXC8nTpHxX8Z8KZJZPuRpjv/1u+TWKJ7Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=ppRpiOLT; arc=fail smtp.client-ip=40.107.243.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQVAh8Eyg8SxmLAx2NBQL53Q09/6e7/j1LAbWpbI45KekICs5RHjPe2QCovmtbjcODXhcfeLX2Br35jbY85HSH50ll4ebAYziXs2uAznbJHwLmvR2W0W4FnsMS2RmpiIJKe0FXjoAGE8a2c6J4iWRX/dkkJR//GnBCjZglKE6eEkhe6C3IZnbQp7XT7s08u/+T5O+WzTgj+GEiXoSAHQ1pkoT4Y8VOkDJ3SQ9uJVgc5i1ABJkqeQPhHtnN7n5wlZDU/FrRprqwDPE9hsKcRrEaJt6m6j10GP5qaQFN20WLGeqFb0lkgYOtnU6A1PXU7uO+Io2Dbc/kMwni6sV2EVDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jB40GCO/90xLXoC/+9m3zZ3t+RsEWKO7gv3OFKJl7Rs=;
 b=fqpWQWhPKuyK/+yFqau9JPremwwNOLr6DA1KP6rQHeINvuW7vUoUhlJjb1IhuwGjD4XG/aCSjwer0DiB0YjmEIIxe+mXU9QWrKBUnQ+rem+z0ty0+jfc9SyUP8d9CiWk5/18MD2+GHJL2krJYSCxuZNjmMTYF84dDL73LxDoDJMMOoGzXnh4wnBIe5qv3vwSGz94y67fF53RkLqy/QsVP2wWiLozN89RS5r/6+ktDsA8YxXzrf75V+KYP4AslhbryZQcsdxlcmVC6cKsU+QebtRDp2Q+UkJrSHzwIftz5QDvJ9mTzXDqBfA92sAsg8a2D0sSG3hlok5IUGYtWgAyag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 50.233.182.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jB40GCO/90xLXoC/+9m3zZ3t+RsEWKO7gv3OFKJl7Rs=;
 b=ppRpiOLThCCBp0+DBDNJhOAM2vjc+Qmgbx3K7ubjW1gVjeWn0F84zpfOTetStGOBwB2PlMvQ737lubBW3vv43+ZX0/fqF16ngfXsmE/D3yux0IvIOjvHJsMqu0qIe+ynRVkRcVpY3dIzp/HCOgcBznlau4H4/CMK7j9JAt6ABv9Cud4hPf6nrrEBJP2HhUphP/650HOVvL//R2R1JTHXd2RxCACVgPkXN7B3MjRO5e8JZbQAYW/bvJ5JBNmFV3Yu8K3WrGFMUq8u67cFWO/CyBQZjtmLRHrCH67IysXrPOA3Xf0iKVrDS5B2ULaONWoIJ6BWlgA+7CWpC7I9bbcRyQ==
Received: from SJ0PR03CA0207.namprd03.prod.outlook.com (2603:10b6:a03:2ef::32)
 by BY3PR18MB4595.namprd18.prod.outlook.com (2603:10b6:a03:3c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sun, 24 Aug
 2025 14:56:25 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::94) by SJ0PR03CA0207.outlook.office365.com
 (2603:10b6:a03:2ef::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Sun,
 24 Aug 2025 14:56:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 50.233.182.194)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 50.233.182.194 as permitted sender)
 receiver=protection.outlook.com; client-ip=50.233.182.194; helo=[127.0.1.1];
Received: from [127.0.1.1] (50.233.182.194) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11
 via Frontend Transport; Sun, 24 Aug 2025 14:56:25 +0000
From: Harshit Shah <hshah@axiado.com>
Date: Sun, 24 Aug 2025 07:56:18 -0700
Subject: [PATCH v3] arm64: dts: axiado: Add missing UART aliases
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250824-axiado-ax3000-missing-serial-alias-v3-1-5db4143bf189@axiado.com>
X-B4-Tracking: v=1; b=H4sIABEoq2gC/42OQQ6CMBBFr0K6tmbaUktdeQ/jokCFSRC0xQZDu
 LsFTNQdq8n/yX9vRuKtQ+vJMRmJswE9dm0MYpeQojZtZSmWMRMOXELGBDUDmrKLRwAAvaH32FZ
 0ppiGmgaNp0IXaaaFgtxoEkF3Z684LJLzZc3OPp7R1X/LGn3fudfySGBz+3FytsUZGGVUclVqp
 QthDZzW0b7obmTmB/7L5JuYfGamIHmpZHpQ+R9zmqY3R7QTUj4BAAA=
X-Change-ID: 20250813-axiado-ax3000-missing-serial-alias-39c489370ba9
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Harshit Shah <hshah@axiado.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1397; i=hshah@axiado.com;
 h=from:subject:message-id; bh=PNSQ2YL/exiCKcVkXcMD6ewdev328gM72mLwViyZzcg=;
 b=owEB7QES/pANAwAKAfFYcxGhMtX7AcsmYgBoqygZRjUizbootn+3SGNNV4osRwpeehTDMCHZA
 pGFYZ+IRHeJAbMEAAEKAB0WIQRO3pC/7SkLS2viWOvxWHMRoTLV+wUCaKsoGQAKCRDxWHMRoTLV
 +7SKC/9l7GwMfZTAnuN8SfK2fhVRIQ3148KThobcY8r/1o+Sc5Hd8yoOkcIKD/d3oRpjLT9m0MO
 z8fXmQqlDdxcw7jUFGSIjfkmfF8hpKBOU8+NpUAVbugzwRIG2pedhVDRgrm3iPYdVLoX2kQu1oM
 oBqrVQjxD5ONdI7AbgdtrQpNDFa0G2ObchMJ+ujRtXrGyKx0AC5IH590AdUpzuH0NrGi9SYT15i
 x5mXtSRYnuXzz1Da55NRNCsZkUVnE6FFk9CwwiBYywwgFjWSn0U2inlXQPfF4+oxZEJOzCYkn0e
 wJOYfglDW1cn2TdTMlwteg7HGKYl+ZClubpv9DMoRmr3m65rPbRalyyGK85knXZBjurFSSjYSSG
 Hv7TAP1tUdZECTORvi/Xv8WTFwfnzp2p/RRj+jZ2dgccxqWU56xpiGmr5sL/M3pWWAR6kEs9bGU
 Ryz0bNQVtXvX9+W9ehFXsY72GX7RZolaWlVQZqgtBh9ZXCIGq2suEkTaUAi6cjQpmj6Ok=
X-Developer-Key: i=hshah@axiado.com; a=openpgp;
 fpr=4EDE90BFED290B4B6BE258EBF1587311A132D5FB
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|BY3PR18MB4595:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b72780-5537-4b6d-3329-08dde31e6612
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0ZGZ3FVMUNuREI2aEFNR0Mwa2JwSEdjQ0xNRTVKemx3Y29tMkhQamV1ai9R?=
 =?utf-8?B?ZE5zaUY5S0hYVGg5Z1VLUUdUM2hMK2JmSzkyVnZrR1ZwaXBpTnJRaGUwVnlj?=
 =?utf-8?B?M1FxOUdxaWY5NDV5ZkpIMHJuMTd5cnpzMVRsZ3FGQXdBTndhM0gxY01UNWll?=
 =?utf-8?B?VGp1YTRlKzg3NUkxTVoxY0NNcWFDemRNeVYrdytyQ0VZMXpQaDUyR3FlYTVs?=
 =?utf-8?B?MDltTm5IelRxNzB1ZmFuM3J5Szh6cHA3RlIvUEE5RTlkVTNTMGpaeEsrVzlG?=
 =?utf-8?B?WWl1dE9tWElwWWdPclZyeUVZcHY4SE5IUHcxNk9DRi9KNEdYbjgvb2MwVDVj?=
 =?utf-8?B?L3hDdGlldGtmVUFYNzlaOEQwZ3NlUUpKK3hsMkU1Q0l5Z09pQzFUMTNTblVa?=
 =?utf-8?B?bk8rRHpLMlVIM1pjTHZwM1g4dGtReVdlRTVQM1NqdnN5K1VNbVNFT0pSdUd1?=
 =?utf-8?B?cnhqdzRISDRyWGhpM2gyc1ZFd2RSZjVncDVHTVZqQ1pDK0VZV2ZtOG9pM3BE?=
 =?utf-8?B?MGFVMmthbllxazhLMDN2dFhpYmM1TS9rNEhLaHpFcTVydzlpKzFOZXNYVzlK?=
 =?utf-8?B?WUlKZ2Q5cHFtbUtYUElkTHBVU3R6cWo1djJ4dEdXdFRNZER0a0dNbWV0U3Nx?=
 =?utf-8?B?ckllV2dqREh6Tmc3aGVVZlZBMXlCaWRBVmtSR2srcWdvYW45ZERLb09waEQ1?=
 =?utf-8?B?MGFXRmlyOTVKNG1NMU13cDBGVFp1dkVUd1Y2amhlNklNMlhKSmUraWxUTFU3?=
 =?utf-8?B?L1QyaUw3QmV0YUVSMGlBTTcxdHFTWi9ORmJlQ09lcEpRVkZpWkp4RHZjMnFK?=
 =?utf-8?B?bE05NTRtQ0hHL0tiZGhHZHM2RGt3UDR3OGVEWTEwT1BZeU9IdlFTaktreit6?=
 =?utf-8?B?SUZOdS9KSis0SXVvZ1piRVJDd0VwVjU0U0Noc3RCcVdWbTdaQVVDenN5Mnpz?=
 =?utf-8?B?YnMzSWZvMUMzTFpxdy9YSVVBSHJodktpcnNvREpXdzVOZGVVZXNIYWg2VHZM?=
 =?utf-8?B?TW9QT01FQTZsRWRoWHREU0VveEhsQ1hiYW1zZjdUdURWdHNvNjF1dnF6ZFk4?=
 =?utf-8?B?Q1BYemRkd0hkQ2twcUxUVlRXenJiVldKbmtZaWROSkczdDR6VTlic3kzbmcz?=
 =?utf-8?B?a3QyNmJuampBMzRzYUcxZjRvUmFoQTlwb0dVRkpOWHFqeXlpaGNzM05hWnlH?=
 =?utf-8?B?R0kxVWtvVS9UUU53ZTk1OTZVU2h1aGlwYnZNSkNLZDZGY2xsVTdDSzJkODJO?=
 =?utf-8?B?NGY4WEovU2ZGUUs3ZllhUTZoVGhsWVBFZWhvcGZqaTIvcEVHNkRTNnRrTXd1?=
 =?utf-8?B?alhqYURMZmVRa0tCalhaNngxK1VEWkRVK2dJYjZDb3N2Njl3OU0rS3gzdVZX?=
 =?utf-8?B?Z1ViQTgxam9EakpRNGFKc1JlZUhidzVGVnV6NG9pdkg5VnM0TDg3cmw3WjlR?=
 =?utf-8?B?OXdLNGVVK0Yxa0lMSlFCMUxrcnRTc1dQcE1QQmlsbkI0R2dUa2NwQWVOSzZs?=
 =?utf-8?B?MlJWMmRpTkQ2a3p6SWlZeGF6SFl0TkNscGNSczhPdHlhV2g3TVJFejZOQWl0?=
 =?utf-8?B?QlhjcE9nSTA0dzl1eFhCazNLenhiNHpnWTdhZEliMnYxYTNVQlNNY25pWXlu?=
 =?utf-8?B?NTZSanNxS3l3bERCZ2t6TGtKK2xmOGxJcEh3TXdtZEUrNldqMU9UdHZHT3ZQ?=
 =?utf-8?B?S2Y5RzBOVnQxRXVLYThwN2JLVXhPejVNRG1iYTU4cG9QckJtd2pQcEY5TjlT?=
 =?utf-8?B?akRsMCtrcnNBZXUwdHdBVi91aGNXeWhHdUg1YytOeVZQK2t4ZkdGdGdBa3Fq?=
 =?utf-8?B?Um52SVJXYmJFREJtSjJ2Z1JPeDFvRmY2NlJwbURra2R2MnVXNUJBRS9vZGh5?=
 =?utf-8?B?Zjk1cE5Zc1lrVFdReFpmNmU3WkV3ZVJnVUtrR090bnJiL2cvOENkQm9xSTJP?=
 =?utf-8?B?a2FRZkF1UXd5bWtQSzY5RFNBNWNZZkJiNFZWUjdUc1hnSnlxNkZrSlc4THV5?=
 =?utf-8?B?eDVKSDlvaUlsV2x6RElkcHpuVmRzd1AzRDhTM0FzK3BPdWFmMU5SNEF3MDVY?=
 =?utf-8?Q?IkgDAY?=
X-Forefront-Antispam-Report:
	CIP:50.233.182.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:[127.0.1.1];PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 14:56:25.6982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b72780-5537-4b6d-3329-08dde31e6612
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[50.233.182.194];Helo=[[127.0.1.1]]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR18MB4595

Axiado AX3000 EVK has total of 4 UART ports. Add missing alias for uart0,
uart1, uart2.

This fixes the probe failures on the remaining UARTs.

Fixes: 1f7055779001 ("arm64: dts: axiado: Add initial support for AX3000 SoC and eval board")
Signed-off-by: Harshit Shah <hshah@axiado.com>
---
Changes in v3:
- move "Fixes:" tag before Signed-off-by in commit (Krzysztof)
- Link to v2: https://lore.kernel.org/r/20250822-axiado-ax3000-missing-serial-alias-v2-1-54052d75467b@axiado.com

Changes in v2:
- Add missing "Fixes:" tag in commit msg
- Link to v1: https://lore.kernel.org/r/20250821-axiado-ax3000-missing-serial-alias-v1-1-527d979c3ea0@axiado.com
---
 arch/arm64/boot/dts/axiado/ax3000-evk.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/axiado/ax3000-evk.dts b/arch/arm64/boot/dts/axiado/ax3000-evk.dts
index 92101c5b534bfac8b463adaa1c4f0d4367d01e21..b86e969625573bf92bdd5e4435ea571dd7500de2 100644
--- a/arch/arm64/boot/dts/axiado/ax3000-evk.dts
+++ b/arch/arm64/boot/dts/axiado/ax3000-evk.dts
@@ -14,6 +14,9 @@ / {
 	#size-cells = <2>;
 
 	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
 		serial3 = &uart3;
 	};
 

---
base-commit: 8742b2d8935f476449ef37e263bc4da3295c7b58
change-id: 20250813-axiado-ax3000-missing-serial-alias-39c489370ba9

Best regards,
-- 
Harshit Shah <hshah@axiado.com>


