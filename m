Return-Path: <linux-kernel+bounces-735386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C707B08E95
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45A7A18825CE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4F42F5C55;
	Thu, 17 Jul 2025 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="vc2lkJOW"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazrln10223024.outbound.protection.outlook.com [52.103.171.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EBB298CD5;
	Thu, 17 Jul 2025 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.171.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752760441; cv=fail; b=lRKv+IKRERZfYOu8gHYu7xZ7OeuHyieNoqK/VHT/aqcyaY/VSm/EDiCArVm14L5R0vLYRq3EYn70e1c5DDntudbjS4pDFr+jbqAv14YWv31s9zh02v0uyMR67ahK+EY6GubRIJYKppl99FnXIdq5R8eMOnldNs7Ko+MViZItoVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752760441; c=relaxed/simple;
	bh=w4vM0Y777e12k/7QH1e4MkI1wnaHwP651KpDe7sSrWw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gjD8SCjVoCgdE7zlMN8DGDBTHGdH7nnjODtwoZOpbzkM1FDY+4YqlgyW0pznORQCfZmyMOO18LdH1T/zFHmXhIMwcegxVw6CFHUOz6N8/nchANDX6Z2PWStTo5Ld36K/unUkRQLs4X/MtHn4g9cS0cpdC1mf59Zx7RXjPtMj0gM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=taln60.nuvoton.co.il; dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b=vc2lkJOW; arc=fail smtp.client-ip=52.103.171.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysbI6DhsXf/pop5eFLi0XJ41hr5D7ZOWW5uFA508WjJBzsc1PJEZHvjDeHdIC7KWkhpnKmBniYZW0lpS+67wfs3B+OoUxPJYp335+pmB9hjs6ufC4xnkxkS5Sw+CEoXEolAXLUVtNXTKNPfh9b8/Rl1RUhp84bgJ5OyjJYPO6djFyjHyRLB5HYHkkKj/k7vPDarZAPchoKMQtqB0RxYB6xtZbEv+upUGLDSRYfYw66GwLTB2de1hlD6YFVQrKhzCpcOoFWszzLIM8dQkKRJ5aELqmb7t31O1N5Bh8+5RksJc5yKjM8IkrASSHKpKp+btcaYsbSAXFVNVN/TTYXp6/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZ5U2b7kfe+LY684Ewc3FgSInDAhIcWdUoo6+Jn/NX0=;
 b=VU3O/kNR7YQE2ZiLP2qzND6tbTP8xNcIYNELNMIV+C5nisvvgj/ZX9GlVih/WSY3Q3Ae/HRucTRpsQ4hhAcSeAPGmvR51WDM2BsvVRqxjwDKG2h+nC1Sxyirvj/Y/GG6/0wi/jJVM7tcFA72TgPoOSWFUdOkpGdT+ePKMN+Dgb1ldws28ezVruyMtUSt4NrSPMWYOFaPwH7xJVVD5XBSfi3f6vrmKh6QlYXEJAJJUDy8FNFzS+uzGQkk+PNv6t2RDFy/jE0/t+CIe4R5oGJZDhvuHnhZ8NjHdtdQ9UWWGI06pc5Lo4eZpx1e/K9HcclTODJrPx+MEI5qlqATNhq1rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 175.98.123.7) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZ5U2b7kfe+LY684Ewc3FgSInDAhIcWdUoo6+Jn/NX0=;
 b=vc2lkJOWSKKJGiKLqFR+JhyX3nHfNV9VsLXaVa1HOM+s9/UkkUgTNG9VDQdhhcSLKnoPoE28sd4n2aYeQfDMfQ0+FmLj9qaH2LpwwXNzRBh7axZsgZQU8qBjE7I0ZV3/vPifAiCZA665s12Usx6LuWa75HABgKj7A0K5BHIs/1s=
Received: from SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) by SEYPR03MB6532.apcprd03.prod.outlook.com
 (2603:1096:101:89::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 17 Jul
 2025 13:53:44 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:189:cafe::89) by SG2PR01CA0197.outlook.office365.com
 (2603:1096:4:189::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21 via Frontend Transport; Thu,
 17 Jul 2025 13:53:39 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 175.98.123.7) smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not
 signed) header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of taln60.nuvoton.co.il: DNS Timeout)
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 13:53:41 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Thu, 17 Jul
 2025 21:53:40 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 17 Jul 2025 21:53:40 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id 2C03F5F604;
	Thu, 17 Jul 2025 16:53:39 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id 1D4B0DC084A; Thu, 17 Jul 2025 16:53:39 +0300 (IDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
	<joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
	<benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 0/2] arm64: dts: nuvoton: Add NPCM845 SoC and EVB support
Date: Thu, 17 Jul 2025 16:53:34 +0300
Message-ID: <20250717135336.3974758-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|SEYPR03MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: ea74f602-eedc-441a-7ca1-08ddc5395717
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|48200799018|35950700016|82310400026|376014|7093399015|7416014|35450700002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TtoumXjOQS7WprMXsz9wVxU9V4nWDx3Klu3+21YnbIsD/3+I5V2wJe8xOSl+?=
 =?us-ascii?Q?IrPMFC7LWIJFyFrFqxA5X6hiw2AxOsESQPtLywqoRK0E418p1vzrjWTC36X5?=
 =?us-ascii?Q?SfeAhHTo06lwXUC5euArZRl4IQDSwE/AZpDu00d3jOg5CvmdRCUIxOPo6QA9?=
 =?us-ascii?Q?C8rZMqFI/PEssbrV80fMIRAHsoaYCBXQNLQoNlLpuI1mV++T70LXEAtQzYRl?=
 =?us-ascii?Q?snjYjQwZaZQgW/alnBK3+aoL3XjoxkO3++qHoydNmmaechUrfyYZ2aSm9ayT?=
 =?us-ascii?Q?dJnc2gcpM1AwKQbl+d4SpELBpfcty7XitQQwiQjm3PKXNRBTFMNYJ2bdOdp/?=
 =?us-ascii?Q?vRazK2PmHGa7+KbF1QhnmdlD1lkWNoubfZ7kf87x2nlj8cgttO3DrogNvzTF?=
 =?us-ascii?Q?/70mXl+xkhlyeRLT5oq/07N8SsvoAGXwmoy70Gev6DarFV6ya9X1Nzue4DXe?=
 =?us-ascii?Q?fHCB8PbzZhDbd+G2DmB+G5ckV9zY+85LEv9EO7U7fnp0q7/AePhdWB2qS3yQ?=
 =?us-ascii?Q?1H6MD7hSDybYA7xaAGNbfQllFHzWP1JYmO+9T98p1FJAqE4y7gDz/bC2XAzd?=
 =?us-ascii?Q?vFtfHXz4dk72DGeHUFXAOZzn1D6tzXxx0q9ZdILujLDsUi85wWCiJQ1c6jhB?=
 =?us-ascii?Q?6vusCOtT2I6qCJzk1zTWJbAWO3CHQLu958c3jBVXvhVmbkl/+aqQhNRI5nMT?=
 =?us-ascii?Q?3sHuenJi4LvGhEjvI7mTyv+XZrUlVKB5C4iGAop29UF0xiG33fjA7GHpOABg?=
 =?us-ascii?Q?CnkyhiUxrvRez9eyCzoSYjyQ165o7g5mxZyOj+b8xYcNRUGtuP3rlQb/YpTl?=
 =?us-ascii?Q?UO+9eojjFCa9xga2IjpA3hgkje+kpTvnGtfY3meBehzrE/UnX+md45t8Me10?=
 =?us-ascii?Q?r/TsrQtIElVhJU4B3R6nBgpeG4mQeSbGrylkuc9iTg4VU7QIJ75u8PGFZuvv?=
 =?us-ascii?Q?E5lfNWFdC1MtaJrSM9T5DY5JFBDTsQL7hpAh3g9Js0Sklz97Ec9gzh1/2zQZ?=
 =?us-ascii?Q?JYezamx8V08BSSW3uf50Hvmx38XM6aZC1Bhb9VG3GMM7IlEm4IUMDgxeNsWu?=
 =?us-ascii?Q?hN7dXwkVoSf0dk1X+6UFXg9320/ay5wFzwgQw9k1RKTnn0WsCPGtVJeiRWOa?=
 =?us-ascii?Q?KAhZfTw0ogkdKeTJJ56a+uzJVsxPVe4ZLy3xdsHluY7qe+hQa9Tk0BMAsQQN?=
 =?us-ascii?Q?jYodC5fx+NyVjH56SZvanHST/SfEwtGJvruVphxDc02pigozJLQABho0cYb4?=
 =?us-ascii?Q?7DOfBjQffOMlnvq7sOE2QcKZqO7OShfjOZ9HCkxqJj11Wlp8IOEevRT3FVZ/?=
 =?us-ascii?Q?iRBse82hJk1jxAH7TTFnJrTQPy61MiaQ9R33eTNPNFEZDxwfOIaQyZxx/uT9?=
 =?us-ascii?Q?LJiKclzWKGREJKlDSSgAsj6cqU/DoSJYji95QEzFU+hcNyC9WXIheOcDmIW/?=
 =?us-ascii?Q?pmqNoZezYfbf9RD3jsbo/tiBBmYWwxHKXxB7MIY78MvKQNFUWQMY32Id4cCA?=
 =?us-ascii?Q?K1OUcbxq/9Zli11XaZmaIw+TBHQdWEetaxpT?=
X-Forefront-Antispam-Report:
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230040)(61400799027)(48200799018)(35950700016)(82310400026)(376014)(7093399015)(7416014)(35450700002);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 13:53:41.9576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea74f602-eedc-441a-7ca1-08ddc5395717
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6532

This series adds device tree support for peripherals on the Nuvoton NPCM845 
SoC and its Evaluation Board (EVB).
The first patch introduces peripheral nodes for Ethernet, MMC, SPI, USB,
RNG, ADC, PWM-FAN, I2C, and OP-TEE firmware in the NPCM845 SoC device tree.
The second patch enables these peripherals for the NPCM845-EVB, adding
MDIO nodes, reserved memory, aliases, and board-specific configurations
like PHY modes and SPI flash partitions.

The series depends on a separate pinctrl patch for NPCM845 pinmux groups.

Tomer Maimon (2):
  arm64: dts: nuvoton: npcm845: Add peripheral nodes
  arm64: dts: nuvoton: npcm845-evb: Add peripheral nodes

 .../dts/nuvoton/nuvoton-common-npcm8xx.dtsi   | 695 ++++++++++++++++++
 .../boot/dts/nuvoton/nuvoton-npcm845-evb.dts  | 445 +++++++++++
 .../boot/dts/nuvoton/nuvoton-npcm845.dtsi     |   7 +
 3 files changed, 1147 insertions(+)

-- 
2.34.1


