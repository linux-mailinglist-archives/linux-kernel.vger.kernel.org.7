Return-Path: <linux-kernel+bounces-894701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85195C4BA28
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0743B86A3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFCA2D23B8;
	Tue, 11 Nov 2025 06:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="CxVnpRoE"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011060.outbound.protection.outlook.com [40.107.208.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA0F2D1911;
	Tue, 11 Nov 2025 06:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762842005; cv=fail; b=HAjCK03mdDvxIOhbpvD3+a5iYRGN30/qcTuUdCNDg+xZSZg4PXP5pBSdHDWtwErvKisd2FiiuT0YrV4j5wQUWue+Q6StaWxnFVYCp3yuq7Eot0Ie4wFa0DLWVdkvoTVDPezrzh+RD94pzWunFt7PHyjdD7mHRLXCxSyYQxKsqCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762842005; c=relaxed/simple;
	bh=RdhuPUzYKrNOukW7sYypqjil+QWtj070ntIFVS3aba0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nSEEa1YL2s8huBNuo7jEqRvvdoI3EMD7in1HVVpnOgyceunMkuyCsnuOxVjAVgtNtFd4coXVYGfjPuPGym0V939jxOrt1EJ25We8dc9kJR9dMDo5k9FyXT6GxfvvqcmEAFQ6Mn0lJrq7atxjhdVO4pfOH9oT3DGC5IagaHF/ydM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=CxVnpRoE; arc=fail smtp.client-ip=40.107.208.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBI0YxGh1Qbyl/jvOd64D9Kgl6P+HpHZbCBRDf4NVjGNDMYHtSQ1ML5qfpr8nk4MAAFW6YT53JnL22AaZ+rpNJb9FL5TqWMT6PxHHBTfi7qHbxoLeJPkZb3r7TnJjHvAIfxVi/lgrXM/50nxwcE/sXdk3Jn+CT9mb9J+EzafORH2H5a9CJaaIiY7IhvRUN6z9eYkELwB2lwbJOZaoChvfoms5deBmbFzM8s1TVvk7Aazz2soCexneGDNlDx2DkLhzwEzUFVAAvNXsYnVk6zfUa6aLP/snzIzpGX8dTFJcno+B5JSswT5C9OZ69ZJlI9A88eprO30tNmDA5/YOhJd1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCyEerO0OnCjygqL1Do+lfFaeRL/6SIa/hKxVRbDHd0=;
 b=pIBMYxVXEL6tIWagGpcasCMgu9YibCnWDoVhwLYfPtcgy/r1P4RC0T/QJj1yCHYgxFA7FLHKAOqLpdG+unlI2GQn+X0WKnP5BisDjPl0JKXOnqxML3zBIPPDW3SnHMXmVZwlhiTDulOdZWuy96VNq5Y0qu3yJ4J1TsN0K2y3KzHDDxwbq1XpM2Xsd63ziJOiHJCAep2SyhZO8QLhdzexqI01kgoX47vwskYraWY4sNw4AT34hZLribD0+C/9X0xtIEcHAfj55s/Ye4ODfLTH5uToPkopRWvd9I3HOAI08tSyW0FbEWb0yaTworEj6Habg9aoBAdMyUzewQgiVCDD2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCyEerO0OnCjygqL1Do+lfFaeRL/6SIa/hKxVRbDHd0=;
 b=CxVnpRoEfvl5AuWlzAHO8jhSR1q5g8nhYq4+XD4FtnagKdrNT+sfyzPHsT1JvFmM8R5TDlXgqV1RP953mRuAXQejFDLORtGZyLv7JFh7LaO+Ky39gfzu4hMqg+ifHNNdRtkSGd2zebZEYWjDZiX2HDZklp4pvuTlaktnzVYojBfFvUB9gpJh9xRx5sg2CQCyRIbei0XJqDhgY6cNNe/BvHED9aoejNkcclCXvnA3s2isDzcrQsixgmXweQnTRiPiapoqUkF5Bm6YKtWcI73pT0RnqcSzwMVrkA1ZZjJa55JviDk26ykjHP3bmlIHW8De7gNuxuKhQ/UQUoJy4uQqJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by BY5PR03MB4968.namprd03.prod.outlook.com (2603:10b6:a03:1ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 06:20:00 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 06:20:00 +0000
From: niravkumarlaxmidas.rabara@altera.com
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Subject: [PATCH v2 1/2] dt-bindings: intel: Add Agilex3 SoCFPGA board
Date: Tue, 11 Nov 2025 14:17:38 +0800
Message-Id: <e9d398bacb299c996f14c9993bf041a9a6740cbf.1762840092.git.niravkumarlaxmidas.rabara@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1762840092.git.niravkumarlaxmidas.rabara@altera.com>
References: <cover.1762840092.git.niravkumarlaxmidas.rabara@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:d10:32::6) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|BY5PR03MB4968:EE_
X-MS-Office365-Filtering-Correlation-Id: 7281e5e7-a5e3-44ad-8d3a-08de20ea57c8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m4SKlnjBMuhlN2sQGdYQZA4RChuGqJ7tG1xrUsDTJOOEsUEORvB1ty3fVETv?=
 =?us-ascii?Q?fHw10GV5MxklnJ1o3KGVIoUOAWmpni8L9+S49/fus7LSmOPvGHqwFxiDqCEV?=
 =?us-ascii?Q?P9IcGMLSp952AbxfVm2zSFsqoFe6d+p8zGF4CLj/Uhi4xU2Ik5DmNe+x96NB?=
 =?us-ascii?Q?MDxKUzFQArA3NvnvTD/QLUSG+6i/6YzqiPMZUWSsgLZ8yBKOzUnN/KaPd+ug?=
 =?us-ascii?Q?KAY6T9OzbeZlLhuVNfiCH82qzfbT1ErDn2Msir5uJwTABKeyyHlyYk85Mpv+?=
 =?us-ascii?Q?j0NhrSUYdy0iSp0OQOkLjMfWauguxCEAePJkuZ+Adw67hGILs+LMgY+qNyfe?=
 =?us-ascii?Q?MP99JkDbZmnd6doPXbsT8RUj4GlYzQfIPJ4HNPvICvlwxqMOAIDrtXEl22Mj?=
 =?us-ascii?Q?rfjLbPR6LRzcDFQcCzeKPf4YOwvlW5kfGDsEoOIyopwxn5gS+7ANDUyHdJ1A?=
 =?us-ascii?Q?kRwBLmAL0z5l7MnZy0d2hrGEatuVLKqp9yTGfNeKeGecqiB3wWLfIS4RkDmX?=
 =?us-ascii?Q?X/nD2JxfFmrEUWvHDhqzuMKPz+jcqXlTc9i0ZMmtxf0NmLaX/wzTscF6rJ/Q?=
 =?us-ascii?Q?6v2u9iyMry2O5Z7Uzg4dC2m5MZETPnzsgtNwnRT20GU55BVJPt66iNr0cbFZ?=
 =?us-ascii?Q?pWOjMho9HF1ly0V0U+we7E6W+UVl+gMlWqtT77CXB2SiVOuLEPkm8ssA9EPJ?=
 =?us-ascii?Q?A59BJQzixyAM++y+dWeMq0x4rCod5+TeL5HBpYMLL5CbBOho8BHPWwuuKo9t?=
 =?us-ascii?Q?HRbzPmvI1DfurVosaXrXf9jncnuZZYp8p07v2Z+V0ApxOZa1rD8EQ4zCcjLx?=
 =?us-ascii?Q?tDcOiMzWY3Wpua5unW7TCQWNEG/7nDJrngP7x2Ptl/kcYfHjRoSVpfJo/1J2?=
 =?us-ascii?Q?C10DIYku8iVsLKl3GMhW2y4kduUr45VhVVwwm/7+IFKZJd78DcUf2zH1XauU?=
 =?us-ascii?Q?HTYLM92CIINsHv13WSewHm39Z1xo+6y7gWIJCBHVb9JyWTUzso/LZrtCyLxK?=
 =?us-ascii?Q?ZxXqP7bfbUG9MJzco2NfmyTFHPmtm+08ALiu4vwmsbbihsJKCCJ4q7pQ+Rok?=
 =?us-ascii?Q?lQ4WlmLAg+tmoheZRV5MfT5ywAwf9W7F30/Sw4kI+BcRiPxPlUOhSmewbiEz?=
 =?us-ascii?Q?xDHQ63dx/uHERlS0vsz6bUBfo3ha4nZl355oToWrZeCN+4KyS89VutSCgIkZ?=
 =?us-ascii?Q?fp7hPJIWA92JSYqWW+dVLQLqR/05olBxM0/XlIlWHIAueGd2yWYgPmmCo6hl?=
 =?us-ascii?Q?5ZDube0hu64sujGSDZK6WlS+vxKbGbcanfdOUZW/N50AzvqOQ5zrCOc0b2Ha?=
 =?us-ascii?Q?gt3aBEb4iuPo8hQGbjkZUIHYYfSX4i2VMaca5UPDoIc5Z8z1JecW4GpFn//M?=
 =?us-ascii?Q?MiWXcXE7DjZLFqNp/FYqeUW+v78nkfLle6lPJQXEJ9valvf/ANfYVuSxXATB?=
 =?us-ascii?Q?0FOKAL3LiryW6PCsu3F70fqVu92Is6xSCjXhOR19SH9rCh18XDAHtA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VzeEtZnBewK3diEijDXw9jEX90ko4wMqFf/68e8913YZnJ3gx1FuHggvwWI/?=
 =?us-ascii?Q?uy9FN0G1fqiU1sJA7I8Qq7xCOSmXFS6SuEkRncGX+5O4kLE+MUydpPILuKfp?=
 =?us-ascii?Q?A0T2Y5uxfRLUvNE6eEutIA+FrX4zHawHgAHK8PJlyWQoNR1HpPe5mp58lFVV?=
 =?us-ascii?Q?UR/E+N6+1xWrTQRhkMmWZTnKI36rSYH5/LHKhtAIMQQzJu0TXXkjQB7WOtK4?=
 =?us-ascii?Q?RZq9pT2EiXb7FTk49CfGLqAuGXyYcziyCp4IoeTyRAg0tIl6bb4AOrSN8bmD?=
 =?us-ascii?Q?zLR3qvWFxIdjJk3q9Nn1YcdEFz5znD6VK5P+3LNr85CMN+e0D+4t1Htu13NN?=
 =?us-ascii?Q?xDxebTLMkBrnlsxeY553kVHqTXpOaytrtufif86/IWn3iPznhCb/oJPbdx3W?=
 =?us-ascii?Q?oBKfN5K0on0PRvxBy+Wji5WMszajveh959A21jR6S2XMV6nVaUfAl+PvitPk?=
 =?us-ascii?Q?JLpqkhjEnrYbZkCPZrUMw5yZ6zOJEBWJMMvhKByM5xoPkr7hcX88GR+xaFS6?=
 =?us-ascii?Q?jnyg3T9jJSBoUSDfiN0usjZ14j2mEukavgd8E9uGES/lLgVeRl9RGZzOknQv?=
 =?us-ascii?Q?opy9dijMyQWTbsVFbol0T8YAUEDLQp3rho2UT8r0JRDzav7xAcuwHDrkc2Xn?=
 =?us-ascii?Q?+5SaEfv89MT9QwAZt0gQtR2J7Ip1KaETTms9VLweKpYCALRIbWHdC1NgUT+G?=
 =?us-ascii?Q?rXu5rSKrfWrGySF9rG3t+8r1XuSqmH/hPDONCUmTTSXBZ7iWR+UR29IckLMo?=
 =?us-ascii?Q?7iWuTG9v3Xr039iXrfDFivOE6Msev81XJ6WvSWN1JsoggmdwypOY5Wkik4Gi?=
 =?us-ascii?Q?noZVPuL9VnVehokNI9MJvGtDouhM8wz1E1MGdF/Drp6T5svBwMFupxO12zUI?=
 =?us-ascii?Q?wP+Svza9eH5OcUZbU6a3r/Sq33m3F7O3MXBNstmXaD0cFeHR14mbdZcc7Dcl?=
 =?us-ascii?Q?kB1SrhQuK5qwpXQeCeacOf4fUgg+ZUyLlwH3WW8d0PGSNr5ziIvGgYrk95gu?=
 =?us-ascii?Q?HzVn389smPbXoJhSfS4Iz3M7u3IwA4lxu4ccStcRq8av03WmjnIbAKhGTYGO?=
 =?us-ascii?Q?xzUyMR7zJ7gd7/uvj5Y7t3ewIEbMLVEBRNyBSVFBtn+aCkcqcDXDbgQwTvka?=
 =?us-ascii?Q?P/g/ZJi7tdShhTYrQDJCZXAgUYGxP4inBc9qkn0qL3bOsjer4+Y0F74015Sn?=
 =?us-ascii?Q?o8ZYQyPyKCgwxmozVyjRm9ZNzuz3x46BRrORcOvFYcQBQuDLCYEDDqFgHOxE?=
 =?us-ascii?Q?vCDQ5vP1euvKmAWSR/t6DkEmPlpa0xQQ46mk0kZIbIrt6Do9YJMT+zSA76Sw?=
 =?us-ascii?Q?iZSqFllnj9N6Vb6JBehRmbFABAW+dbHr7QzGZq5BsXpO2NqdpkFJOVUnA6wu?=
 =?us-ascii?Q?PA2qRp7VDiybBtSMZ/doyZ3mZOvoC05Eap9z2vqHQArT12PHSv9OoVJiC/Sk?=
 =?us-ascii?Q?njgzL2hjoir4bOzhgyHPHQDOQzszB0gi8Y602Ihu8ek6KqDkFX9CiTVHIpph?=
 =?us-ascii?Q?j+QBhxbktQ89UHm3MORotujOUrxQdpOl1a1OwzXB2g+xhCofshbLwoTbbAXv?=
 =?us-ascii?Q?2KR5mnni5RQnsjyVf4i0I8U1Zw04IB3BFWeZBejJT8+5ZGMZ4QD/WFtQGO6S?=
 =?us-ascii?Q?jheulV68IrC8wSVr0QWMPZB429dtVYgPLGogf4s3Unxy?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7281e5e7-a5e3-44ad-8d3a-08de20ea57c8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 06:20:00.4116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGsYDyL5mjQPtsPdDZXQN2rPJIJjGKIRbwUUQA4R2/3Kb8LlHsctMZvs+ojekQI82i19v7V4dswgmTRoHSzCbQH5ueXf4EIudChRwou1kqw+39zNW2yJB1CmV70dWCQs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB4968

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

Add compatible string for Agilex3 SoCFPGA board, which shares the same
architecture as Agilex5 but with two fewer CPU cores.

Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
---

v2 changes:
 - Add separate agilex3 compatible instead of using agilex5 context.

v1 link:
https://lore.kernel.org/all/51ecc7f4eb7e419c00ee51fc26156e25686dfece.1762756191.git.niravkumarlaxmidas.rabara@altera.com/

 Documentation/devicetree/bindings/arm/intel,socfpga.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
index cf7a91dfec8a..e5a8141dc6cb 100644
--- a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
+++ b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
@@ -21,6 +21,11 @@ properties:
               - intel,socfpga-agilex-n6000
               - intel,socfpga-agilex-socdk
           - const: intel,socfpga-agilex
+      - description: Agilex3 boards
+        items:
+          - enum:
+              - intel,socfpga-agilex3-socdk
+          - const: intel,socfpga-agilex3
       - description: Agilex5 boards
         items:
           - enum:
-- 
2.25.1


