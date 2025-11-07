Return-Path: <linux-kernel+bounces-890201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4D3C3F89F
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B183B4114
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2847331CA7F;
	Fri,  7 Nov 2025 10:30:25 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2098.outbound.protection.partner.outlook.cn [139.219.17.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78883195EC;
	Fri,  7 Nov 2025 10:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511417; cv=fail; b=FytVl/YAUriijgZ06/dtescAHtgVHJlakxl1DWgp9Ic0qEYdzcig8y0O3A/Koy8Xp2J4WNWPKRIDIsp1JgYQsx2xTVGb+4xZppaqU92z6t+v4dNhNVZoOtfVAPEg3GPIyIOKUdY91Hgh+X+A7wXRMl/KJ2Do6J45dTQhj3cVGcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511417; c=relaxed/simple;
	bh=/Q+0iEwPd8dENaLPCJaSXynf71xyqBM66C/Y+25SKYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r1lXIAw65nnTs2/Ar5rR7Ok8MlPPllvWdLAOEU1+mS6KHV0PSQm5reVuGG8l7H7woWvgLOFfynrJbwlXtUNSlWViXMLEIcy29B62RgvdX1rr0hEORBSVxaJ30XCuqNVL+h+1XFpubfLpYz7XP12XaS1VVB1Kd+mrTOKTiTNtock=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFTdoNQ2J5hVcma2qI63oBqEXgN50wZCPqnIhNRPj79eo9vtXfZQntEPuaYh5ffi9iRvOqkDo2REqgDJj0ZmJVzp7qZmw5LhoVyhvIQtDG0vq6NIHVC5bIueyykBJQlEoXMwImx62CrtD1+AuxtjX4qgqxwt8/VxWkP58+vB41PJ+q9dzbpv2+gPoLv+haDYVOKLT2pOPv818G0045um2PQd2fUAVDC5XSo4IXNnQkFDBxVMl2bFmVHHgF0YZaPtmBFZSMyfd6XiI6y3L9qCVM4MLIr39Y9aDA8XWkBaL90DRsQmlPmDGaS1bDpbzVJjqHGW9SAvpuSPvOj46RnMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQCTHLQIU/AIPDs6AFrkkAkw5Vdt6Bv+nefuaHIZTGI=;
 b=ZEhTOf1Y3q8ySNxxncVXvgXWTgkN1q48EsnJ5GDc6fwRkjlUhccQhwGum70yvkq2Rm+vGjgBjC62WaE48xVLtAo1bMzMs8yzD4RbxjqQfPJR8iPr504qEgPB1wvc5UJQ8iBL1olTmSafUu9zeOn3reV6p7gqo/NoYMypZnqOC469coXck8DkXumslWcGtPnCasne26l508rSM0pwO0xFsl6TBmT/KE8JB48Yf8OEZA4rDte/vWGmaa6wXS7NSmjQxMvqNMJuEiJQggRSDtn4632R1nt+OoO0mz5UgpPdzQci7tWZ0toGKost6BaFstU3whPguy4s3f3fN1DNcq5FtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1305.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 09:55:41 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 09:55:41 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] riscv: dts: starfive: Rename jh7110.dtsi to jh711x.dtsi
Date: Fri,  7 Nov 2025 17:55:25 +0800
Message-ID: <20251107095530.114775-4-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20251107095530.114775-1-hal.feng@starfivetech.com>
References: <20251107095530.114775-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0014.CHNPR01.prod.partner.outlook.cn (10.2.0.83)
 To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn (10.2.1.78)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1305:EE_
X-MS-Office365-Filtering-Correlation-Id: 892fd969-ac0c-494f-9239-08de1de3cfc4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|1800799024|41320700013|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	uBMDFddZHmdxi56iU7yikjyVP5QVFJblWbuSik10oEEZmOf7nicwd95nzFQFdZn9IqmuAgHxI/zpg3PAr1MF1cMmgR5kJ1xLCG4ccY1domX0EjOql7Q/sqG4ervmayqnvxDMl2yj6Qh1sGAUxUZ40wp+CasRh9QafkBaL08vB7R6D4TQW3YzIkNYMqRZGrbscWeYxPB6sjTIuoiD7yc0e9SmhVUpSm6qQ4H4oMCLUe1rOYSZsOAXOma/W8nseGAqSZcrYKpkgrS0chcVzWTIr0cYILHP6r5s6x/d+8Kd8q89kdfgjvUEEt9MJuUo6k7190BBNNRM6zoilDUQd0PPOp3mvgX/aetHCgi2k63gqJRDm9DRtl2ZfrDFGUxGsziEbTjO2dlzhVferY86qirGQ6bH35ZV4tUtDFQfpOgwfgEGiXi67VoUvWcbDKksykILM7yAT0Yc4Y39DobxsIj92jtdTFmdwcL+I/TaVZ23jCljkK+D7TR6p9B2hzu582jtIbCPMjLLzthfcU8ioGVccWGZEElbvH9fn/oSB2OjRmchxZ7ouiFojhLm+hFLwRyemHVx3a+D8HRF6u98UXnkkejiLsMhuZcBYmQY3ok5TaA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(41320700013)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m3/DRifrg9eMHgCQEHT13nV2G88X06Dh/vp+gRghlNN7GvWJRTQsbFRYxClI?=
 =?us-ascii?Q?z0ViuwO8mRgEEQGYaMXzwX6zFUbYommSsHocHbKGD1F9ooAvrU6jpGUdcR8J?=
 =?us-ascii?Q?f1Ax0sjjtRwvFXYRwQYRUMFkK2FLEK7YrXlXcVswqQTKaD7Gk+kdV4uScySk?=
 =?us-ascii?Q?KcpmubfuQt5Sd8syqVEI9qb8Ey9irffbR9FLk0czxPfXhWazIy7MAfYY2cQP?=
 =?us-ascii?Q?9sesyu7fhvtLCF/dJv2hKSjw/zSKOxBGTQ8e2DsFZUaGu5vU6QOQ47lnkmhQ?=
 =?us-ascii?Q?HTg/PBEUappQb1gqDDHjkXDc5zj+mt47POyxPSEGi82qmS+RPSV7AFlEUFOP?=
 =?us-ascii?Q?Onxu+rGmouh5/fjrR0vRdHqQ8Pmj60K/x2ae1UufPdG4MKcGaYYCtib+INaN?=
 =?us-ascii?Q?hdOUrNLXJYckMS6c9pscq63BRDs3mo7vI3aFL+zkFBzL82KyORbYpa0h+Zfq?=
 =?us-ascii?Q?kN26/x5Z/xyPyzIsTeQfP0W0i9RJvRbH1wCV/zSfzuovoMYfPh5/0vqh8Gf/?=
 =?us-ascii?Q?OsRrWTFBl68kfWXlNfzjt40147LYhDlqDKaYilsobcyPBVYAPvQDEwoEUwy4?=
 =?us-ascii?Q?VMFVEzu0H9O7eNLTdkdMxfM/dH0g6qaInR6nlseoOyxVBy4Wt9ZH83lktcdr?=
 =?us-ascii?Q?pHLbLFt5j2laAO9LDx2Z/yKFKD3CGa492OU9kFSTwFbn0RhGjn9AShuj727c?=
 =?us-ascii?Q?9ufmP7Oh62aFTDli8hFikccOKF70jdX1j2sFkCGRioMdcrPZ60oweDVX5zVz?=
 =?us-ascii?Q?+3m9QHY6/kjL4pODb/xpZSUl1smuOpekrJodVJ8KKyYnA0OpfNaBq+jh5fvk?=
 =?us-ascii?Q?Y9qRMzynt6d1fLNwf8HG0Wrd1ffuEHaskQBU734q+KZtEG7OzgaYrwmJGTkE?=
 =?us-ascii?Q?i2/oEiRourISkpCTTT/FRCe0nKLFVlmbKEdw0VgjaHdAaBGKu9/X153KEqvh?=
 =?us-ascii?Q?nXYxo5b+68Qbzto5QDEwXYiMT0veeVqHxh4HLtjFOe3Ra6cj5x7z2avsf+he?=
 =?us-ascii?Q?vyEoUwzU3piKdqGJ3p3BdNXGi3AyUNTP+Db6pXtUwtodDe8oy5R/dr5EP7tx?=
 =?us-ascii?Q?SAWeHojLz7Y5Z2IkFOVdFeBwShYUpgTGgrbywksmC+CiD4t7jsQFRfdX6Uc5?=
 =?us-ascii?Q?DyJYhv+ojvFy5UIZvpdMYn1BHr890I++y6VExCCiDRBV6p/95nlGUQgEZxQ2?=
 =?us-ascii?Q?L/R1w5M/vpvAnSfC92oL2HDc3oUy2GMqxICdAUP+4LFJB0x1MZlQVDEf+H/m?=
 =?us-ascii?Q?aTmCH6NaVOkOkFf/Yl0K22mySqEbKnZkBRP2JsijEaBt+YWavWnUbuKaVb2j?=
 =?us-ascii?Q?r60MwadDTIO30410Q8F+nUaT0foCY9v1feWBRZl4wz3kporOyx5+HMDQ2IjA?=
 =?us-ascii?Q?f3AyPCxDLatp/5FMmtViAJ5cq55mAnXzon/+ly+j4Xs+Xhz+eWX7SCm94DN1?=
 =?us-ascii?Q?RsqNR6yMKpqyYKYWSr7FFC7MGjfuOo8WoGfOyNS+UloQll5a2gYE9exvKHkX?=
 =?us-ascii?Q?PGBGWqg7KTRGhcuNd+hRqZu0cs6UdM92Xe/wuTuRGe2vx5xZKRKvGRtHQ7vy?=
 =?us-ascii?Q?zG19Ce4+6LdtFVmw/xiV0FalZTruLWdmfNQx23qhpGsJHu2U/DH8/gry6kBB?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 892fd969-ac0c-494f-9239-08de1de3cfc4
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 09:55:41.4700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfNAV3zeT3knpZF9g6l2OftsjpVQrJSjoXVBl3cw2n46blOW/zt50EWFA49nk1rztt2Jj3u821pJlvFjGdS3oaWj6k1RCof4aqj5kvwqYfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1305

JH7110S uses the same devices as JH7110. Rename jh7110.dtsi to jh711x.dtsi
for preparing to add JH7110S based board device trees.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi           | 2 +-
 arch/riscv/boot/dts/starfive/{jh7110.dtsi => jh711x.dtsi} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/riscv/boot/dts/starfive/{jh7110.dtsi => jh711x.dtsi} (100%)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
index 083ec80b4e44..809274625615 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
@@ -5,7 +5,7 @@
  */
 
 /dts-v1/;
-#include "jh7110.dtsi"
+#include "jh711x.dtsi"
 #include "jh7110-pinfunc.h"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/leds/common.h>
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh711x.dtsi
similarity index 100%
rename from arch/riscv/boot/dts/starfive/jh7110.dtsi
rename to arch/riscv/boot/dts/starfive/jh711x.dtsi
-- 
2.43.2


