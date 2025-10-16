Return-Path: <linux-kernel+bounces-856351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF7EBE3F1A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367CB1A6441D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58753340DB3;
	Thu, 16 Oct 2025 14:38:01 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2120.outbound.protection.partner.outlook.cn [139.219.17.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C3B340D92;
	Thu, 16 Oct 2025 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760625480; cv=fail; b=r3eKmxrpkwcVmRNelAQ1dIuiUZIGypCm0pRbWpMiqP6HS1II+HWRb0P9OjrR09JyCnzx3c3g/+NmQrrkja5GhodLg3pu/g9ys70HsktZ0+OY/wJj0K3DWPB0dRfVGvTw7Eb9sZQJaDtf1gQjeS6YZSOa1QdJjn5XSdBRucv/OE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760625480; c=relaxed/simple;
	bh=b40VGzqmuVf7KmX9i6nYw5FD7Ja13JDTmf3KYWWi0/0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bgEfy5cEb27rYPKS2D5cKoAKSUbeoskh06yM9g+GkqsQTtP0oRxchVTUjfP7ejHu9QK0P39070naQpH8dTvpKthbjqWnml8BDGYm8Dj6fxyIA3QDeSsxfGLscyyYF5nZ8wDNz7VbCKBmih9/CorYF7ZRbmXxebzSIJ6pBWHSC00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERzcIPsmZX1APNYGVeuFbN5T+6l82hXE51IXbp+ey8Pu+0QUoSchlhRDa75ygdMyN9hhFUoVCC0bvqcYIjAvrEMHicIl9pBRrOaOMxGt+XKsaHafZFYUfUJm4MJ/ynr1CfbtclGnW9w0TeZmC7e7RN0o/NaDEMviVVGJaI9wtOLeLqBhAj2I7vubEnkL4x6KzglQAZ6stX6PcW5C6gJKR9bx24WP6b9VVrF/O/tlVF3HHbZkrwF5qD62v8Itsgzl3swfpyav6iGffbI29AFqlj50uxyljtT38G3uRsDBePkpKzhVd4dINKWlTSK1Me/VmEMrUe2lckKF2AG6NdFmHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6LTVbU3+DpTafxllsSWQ1JuJxqWMozOIgRqIPFhQQM=;
 b=aA4K4G5JykiANNH4Sk5txH2ngTAyxXgUQfczNgGLieCbdHVI9mIKD6vY74EHeYhrCQ8+2zgHFaMRXd803FjufQiIbZ4U5S5tzwQeiOVgeDisc7HUAvLScNZMPrXm28SA4fY6gQ1Om5Ah40sAviT0BSG2B5tQ5lKPoPS85SW9US6/YMZW5cFHj9ltB3JgIyTVtQQBAhvcnbZipQ4Xm/Y8dMbb8onVcIAB/Y3Lws3thCRCSUkZosoD2TDwVHYxr+cmOgTLhMrz0hyX5G09UCYfsMyeWlhtSswq1OPClRzMyHpvBPRkAsmeynLucIrgPEOqtlofaGI+qZkneraF3Lh8vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1308.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.23; Thu, 16 Oct
 2025 08:01:02 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.9182.020; Thu, 16 Oct 2025
 08:01:02 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	E Shattow <e@freeshell.de>,
	Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/7] Add support for StarFive VisionFive 2 Lite board
Date: Thu, 16 Oct 2025 16:00:47 +0800
Message-ID: <20251016080054.12484-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0020.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::16) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1308:EE_
X-MS-Office365-Filtering-Correlation-Id: add9b522-4c86-4851-2c05-08de0c8a2674
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|41320700013|1800799024|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	rDK/bDB8IM9FEhpQUL/HZp/HKdS1MAIjlyS4gQFB+B6OZ01496sRlkZtrmrzk5p4cIBUe8cRlsuHVGnV+bpPJh9ut25bARkuZrJ1O2MRI+skYpSbdUgp52uHxbM3bn12xM6kcO9Xf4TIvVtAPIGqNBWF7P84J5XhxGaV9yIDGt5HJlPh3nZYfnl5XTG+MAd9NxvFc/NlfXx9SfJymj1a9dbAD0OMrtt2U5oFD3h+7pMPVO8hplC7cq8XzARgfxuYmChrv1HY7LiXmXwzdvYCM1RxpyngFM64F/+21O59GesNqwLoHBLxGS/zMkft0XwnYCkohs+Ffxqc+fzmuLIMPohPGjMk4JjyZ1bRSV/2hy7Wv4EWKTv2NkwgjjMwLH1/ksKD4TyPZYuSEQjfGmji7IppRTZJJw9JcB2yqWiuSaZ/hgHz0j8G2MuVf+ukpbe1IdNv3Ly5Xqj7nscB2Sg+YmEEYs7ohJ0tb/GVDpfWN3NLl8Ta5YQMS12UzpVXhvCAP1sEdMrh4J2x+8M2t4NFBQTqCNHGJ9YZytWzTQsk/shkH04MSjvUwOJXMdHeK/ycitlj9olLTXlh++Oy3EOZ9MNfp1M1KsaXGVfK7wnXQsU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(41320700013)(1800799024)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RA/nLE8IMwcN8HY3q5f7E5VNMqfPLUhoRXitfBA2lTeTZ2YhfB2a6cpgXoHV?=
 =?us-ascii?Q?N5SAOEJUpHlv5uX11Ajqf7VRtmwFeRUWUNcH+6kyJeTdiglKRq6+8knEE6sh?=
 =?us-ascii?Q?96pyNndOKzjNlnn78Bm6gwx/waq+y5UpDxDSeA0cv2pn5lhNEQQ28gERxEV2?=
 =?us-ascii?Q?6l5vF7StvijG6jK9Vlcj+Jy4TvuL3BqUYat3kckdLbJs+Y5L3vmmn5d7n/el?=
 =?us-ascii?Q?teXAJyT4x3lRCyaQCi5ZiKfgToBAPnclNaenb4AW5Y3LYbnU16qTvTmgNico?=
 =?us-ascii?Q?Fe5CROZc4/8tl39HbMllRYGNZqp8uoB3EzsPfqygTMrKymoy44YZpFsPoEro?=
 =?us-ascii?Q?4mkMyzyN+C4R0OMCGaJzcNy4qtZY9r7XWb3hKwlR4RLb1t2vjoFa4beJoVJI?=
 =?us-ascii?Q?HMXWSJs6IYYJpniO9tMMMoBFDv4DSTfq62+lmdb/3PgRna9pBAiXfYuxP3OA?=
 =?us-ascii?Q?2+b9aRs3QgrKFR1+BMfVynunZOsGBTHZV58jhNqq02af6NYXlxF1nsXl8S92?=
 =?us-ascii?Q?s1eShbtb/5hEPucvzknfxDSK6ohnKojVp4q0E6D4RQ88CG4UvkRxhuCFMra1?=
 =?us-ascii?Q?qIDlSuByDLC3GHPQp9GYprsPtzFxrPcznOIDxiHKUsJ4bBzEv9RfodJvi+hu?=
 =?us-ascii?Q?XSrPXRfS/gx+7hsXMbkGVa0Z7bDvABkv91Cm79TJrbmj+SDrKD5oqlq7ekHD?=
 =?us-ascii?Q?N6JG47BttsuZLkP+oYnKGLarYWmq2yDttOR1uVBOMVhyF+QJ4WWIZ6KHMCyT?=
 =?us-ascii?Q?loGL8XuGpGOsptHfuAUgualg3B6V16KMdZLz9DybpCFYwEjkdgL5VDB0rvsE?=
 =?us-ascii?Q?x4GVY1pYNsD1yIWjvUMcxQ7TT/S8OzxdDupgGn0lQhpDgwZEiBB6GN5tiO+T?=
 =?us-ascii?Q?vAWyx+EdXrPuARxS/Ld5qqp3/Xqn6nu+kt8rpZ7IbZdfHzIZk2ltM69rcAZc?=
 =?us-ascii?Q?cbaQusprWqryklP5nYZvXz5klGyVu3z9fG8XSyt0xJ3Yi8sf7yXJXS5j82Pj?=
 =?us-ascii?Q?1wP4n48Ol7m4WaWk5d7MWGxvcsl3Nq3oZgb5//lN2x9LEX5vEZ947Es4MsW0?=
 =?us-ascii?Q?Lu5Y3psxrqTydfb53zAqo/mPFjUDSfVpBmACHQG0L06mWJA6cDkP/PuDvlGk?=
 =?us-ascii?Q?aQ+8gFoG8b3LC30Igv91+0DbeCfblolz5Pn+nJy0tVoawtVJrOtqrZBh+zw+?=
 =?us-ascii?Q?vEund0oMjNWJTAlbJLvD0Xof1xQOf9aX/rFfPjfWQlz14ZXuam7os2MO3W3S?=
 =?us-ascii?Q?yeyJ+Eyz3+cNz/bN20xy8qsoLx55+tgK8TQ9+4VP+4lbjV8Ml6A5ZPxB8Otx?=
 =?us-ascii?Q?p25VAvxYI/ORnD3gqxohwUvSG4DURbA2xN5zVHTdR022a0prkPfpmXRsb1Sh?=
 =?us-ascii?Q?OFvQkqNBLHG9fm6bOJtQS1zeDpz0nNBYRlvNoCpNNQSechUF9pfSuWW3La6m?=
 =?us-ascii?Q?q8Mn0/OJx34FbyZPSxixi+9mrALSyJGgcFNn9wFpyZ/1YJpqWdatKe3TIQDv?=
 =?us-ascii?Q?UoiIJ0uC5qycXIfsJVYI5hdaYgJx0qmm+9mU7/1/SPx92e49B1leEVbMo5YW?=
 =?us-ascii?Q?PPCxv2vUAC+KCwHm2xR2ZgFyr4j1xuz+HgnT/rNoWFSxwzsAU/muRgW1WF3o?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add9b522-4c86-4851-2c05-08de0c8a2674
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 08:01:02.4811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePjxPKWrBjrucB4ZGKyrQkjRcd+TXx3QhYusr+mK26Tvkp4fUyREG19I26U30wcNI06h+nd8gWBRzZ633ydku3ztNMW57RGKgc3Q1TxKm4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1308

VisionFive 2 Lite is a mini SBC based on the StarFive JH7110S industrial
SoC which can run at -40~85 degrees centigrade and up to 1.25GHz.

Board features:
- JH7110S SoC
- 4/8 GiB LPDDR4 DRAM
- AXP15060 PMIC
- 40 pin GPIO header
- 1x USB 3.0 host port
- 3x USB 2.0 host port
- 1x M.2 M-Key (size: 2242)
- 1x MicroSD slot (optional non-removable 64GiB eMMC)
- 1x QSPI Flash
- 1x I2C EEPROM
- 1x 1Gbps Ethernet port
- SDIO-based Wi-Fi & UART-based Bluetooth
- 1x HDMI port
- 1x 2-lane DSI
- 1x 2-lane CSI

VisionFive 2 Lite schematics: https://doc-en.rvspace.org/VisionFive2Lite/PDF/VF2_LITE_V1.10_TF_20250818_SCH.pdf
VisionFive 2 Lite Quick Start Guide: https://doc-en.rvspace.org/VisionFive2Lite/VisionFive2LiteQSG/index.html
More documents: https://doc-en.rvspace.org/Doc_Center/visionfive_2_lite.html

Changes since RFC:
- Add jh7110s compatible to the generic cpufreq driver.
- Fix the dtbs_check error by adding the missing "enable-gpios" property
  in jh7110 pcie dt-bindings.
- Rebase on the latest mainline.
- Add VisionFive 2 Lite eMMC board device tree and add a common board dtsi
  for VisionFive 2 Lite variants.
- Add usb switch pin configuration (GPIO62).
- Improve the commit messages.

History:
RFC: https://lore.kernel.org/all/20250821100930.71404-1-hal.feng@starfivetech.com/

Hal Feng (7):
  cpufreq: dt-platdev: Add JH7110S SOC to the allowlist
  dt-bindings: PCI: starfive,jh7110-pcie: Add enable-gpios property
  dt-bindings: riscv: Add StarFive JH7110S SoC and VisionFive 2 Lite
    board
  riscv: dts: starfive: jh7110-common: Move out some nodes to the board
    dts
  riscv: dts: starfive: Add common board dtsi for VisionFive 2 Lite
    variants
  riscv: dts: starfive: Add VisionFive 2 Lite board device tree
  riscv: dts: starfive: Add VisionFive 2 Lite eMMC board device tree

 .../bindings/pci/starfive,jh7110-pcie.yaml    |   4 +
 .../devicetree/bindings/riscv/starfive.yaml   |   6 +
 arch/riscv/boot/dts/starfive/Makefile         |   3 +
 .../boot/dts/starfive/jh7110-common.dtsi      |  19 ---
 .../jh7110-deepcomputing-fml13v01.dts         |  46 ++++++
 .../boot/dts/starfive/jh7110-milkv-mars.dts   |  46 ++++++
 .../dts/starfive/jh7110-milkv-marscm-emmc.dts |   9 ++
 .../dts/starfive/jh7110-milkv-marscm-lite.dts |   1 +
 .../dts/starfive/jh7110-milkv-marscm.dtsi     |  32 ++++
 .../dts/starfive/jh7110-pine64-star64.dts     |  46 ++++++
 .../jh7110-starfive-visionfive-2.dtsi         |  43 ++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  16 --
 ...h7110s-starfive-visionfive-2-lite-emmc.dts |  22 +++
 .../jh7110s-starfive-visionfive-2-lite.dts    |  20 +++
 .../jh7110s-starfive-visionfive-2-lite.dtsi   | 145 ++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c          |   1 +
 16 files changed, 424 insertions(+), 35 deletions(-)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite-emmc.dts
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite.dts
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite.dtsi


base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.43.2


