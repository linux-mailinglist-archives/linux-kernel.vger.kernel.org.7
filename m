Return-Path: <linux-kernel+bounces-855743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63975BE22B0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 773C44ED71A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D916302CC7;
	Thu, 16 Oct 2025 08:35:56 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2126.outbound.protection.partner.outlook.cn [139.219.146.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C51A2E7647;
	Thu, 16 Oct 2025 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760603755; cv=fail; b=Wyr9UJ5SUwv4SKM8icqvt6Wmqd4/20WhbkL1ph3cl/0HcMPEu75G5seUwv+mB64M4pulrdbe8NQzNh7HrHi2uO1Z+kQg6KND+MY3Cec8g79FCUkCOmD/iPX5qnoKwFxYMZftk9Wp7girMWM0lFq62LQIWjDlS10hCUATOvDmJdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760603755; c=relaxed/simple;
	bh=JwLfZSWnJD0kHN5EUkKVIQD0tUPG3N/kaoSARla8vWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MNRvRpttTqdB8qB5FH2QzcRMXl8oEvxd9svYj69lZx2GGKytsSHCfl60+WbTjaN0r8g/E9QvL4VhdbC6kQEDtmKXRh1mgxIDnr7huBs0JIPv3uZoRo/XU3K9NHDmstepcx8ucjI/A6fQoFpNqQg72Ee1isifrPw2JulsGNVoG2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGmVeuvO4cFReiqTATKVwK9MlirVSe7HEEDCXaUfZXwbczupe8Yi/Zkm5D4wBFSOdOdtNHY77HfPPnEGGgQ0OxMNlF2kVzHkHBjKH9noRsi+9MwM+xZElkNRGkT6hwS4fikhCoYJ+wWQ+rWEtthkt0Wwki4pwryeby+O4IVo8mIOxXWNtTxsGy70tqmXnALvSQyLIwl2Bzcn9ermZkzehocu30U+i02cUegxggCoMiGIt2BfGh25ACxbKUMVPGsZPDZp3lQBzRAgtZMhk3V44nG1asTXlUts0X4Tat+Zr5ln9lpzgWYjCWtNb8PbADmDsX2oXn1RrXYtivGbye/XMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAnC3859fL2t5uMekp7Cis2Ia1LOluMUd2A4C16sl58=;
 b=GyP65M6YaDPR/q1L8Yt5LVvEct9mD1mGv410c/pUcPYsJzCRGPiI4opX+iScV7LgIygrz4WWmvSj5khLC7kMYXBoY3kLEDwIxtKz5S0Sd9j0S3Q/355kIklvySFdk5qOcb++iZg2IzWWaqrON77WHvbkVEJcuMFnFQcHqOwNxzjsnyRQpG9d6jKDU+zEpkj7kLrBzt+ey4bUOK7JtQeao/8vNaSo3sChh4p/24iJuVciDk/z5qX5+PWTRrWWFfdl/1LXNDylaQt49s0fJXN1Rn9pRApGAJW5lTbrovSJ5xyfMu8Vw+HTz1wnpCGRq0s6T3K6uV67mxTjCSkwEFl9Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1308.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.23; Thu, 16 Oct
 2025 08:01:04 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.9182.020; Thu, 16 Oct 2025
 08:01:04 +0000
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
Subject: [PATCH v1 2/7] dt-bindings: PCI: starfive,jh7110-pcie: Add enable-gpios property
Date: Thu, 16 Oct 2025 16:00:49 +0800
Message-ID: <20251016080054.12484-3-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20251016080054.12484-1-hal.feng@starfivetech.com>
References: <20251016080054.12484-1-hal.feng@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 660bf8d3-9981-4039-1cbc-08de0c8a27e4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|41320700013|1800799024|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	6zfKe23rybj73WkSvQEdQoYPq1e9kmpYjsgatXB3EORYyVk+Z3sxpQBQwLuP0YiEfP1TJ7AYfTmkC7igSkJopBBta6aRg3htnWD1F8Ui99rdmWnNLIWP38FEm/JnWZXBIlFe0rJzZMdgvCpfMHGZcXbq7gIUb3PTMpHzdCDcqO6w+S5Iz/XCMj7a5TdscS0YzzclYWCyRdKDoASDeP1UezVuNdgkAlLW9PJ1GimEGNUhRnwm1jED6ehb8IB7ySkBuMfSzzVnoM7Nlh6es707rrcP+utf1s42oSLjLIVWmKarQN3R7ntB/4YT6w7MC3T+yUEnEN2YpThUSIewk6xLg6oX4LkpYhpq6hHMGTJm/Wcp3Txt3h9ffJZpToXpmDKRz0rB97Yx/Aegw4ECpeOe3bw8v4gtxTrF/f7wyptX/ROyW9De0denVqCgE78dhPj5YlLYTDh1DaY1oouReQTLC/In5DvjskMNIRvQHCAFKI0HTFOd3MStB6lLcjyTWnDu0jQXXmrhEq0y94Q/POeq5wdtO09di+BcPGgk2hir5WfeRgWq108cpWOTsGyJ2sQU1o72DX5rrmDzcGd4VTIc3e2NI82lXE6y4JUgJd3cWr4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(41320700013)(1800799024)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8zVp1Us8LruMcOAutF6ogog04JBEEh9Shi0xX/EkF8/hkhL25/3A9vD2v3/8?=
 =?us-ascii?Q?qDNc7FyyZgNWNBNU8gYpz7RTSnywDBlJyh/eJ5487d54yvJ5I9sBXaFpZ9f/?=
 =?us-ascii?Q?PxUuQS7S003pIf+TACWfzZCj0/egNnQtakxEt02pHZW+gPLtvbAL0Grz3oNI?=
 =?us-ascii?Q?ID0x8I26NGqbM1ucX9jo8scLnTUo7DRZmuPByOdW9QnVbKBicIOioALWpPM3?=
 =?us-ascii?Q?1brKrbMbJFQssPMmREEF+LU6gP726+dntvlkNeGe3DutDcwyLPFtx+gYvD2F?=
 =?us-ascii?Q?KBQwUXDwjf0B69zBN/wolbCYhdEyXhKUcBVgIw293/uKSDzWuIxFOVITV6kO?=
 =?us-ascii?Q?dqC92Gon5MBuvuUSK7ev99HKfbTDKQ7CmF6zCD4j98B1/mzVTJ5IlfzCJkXX?=
 =?us-ascii?Q?ZhyLDh/1UTgfciMWDjq413Ha3JqpANgj1EFulII0btwnzH8GqVIJwjqgpBk0?=
 =?us-ascii?Q?MzWyXkMtcAxZjp+JD5O2Bl/WkTG6goy2R8dusGGCCU+mdo/RdeY8sIiwmu/3?=
 =?us-ascii?Q?lpAywRBEUcgATT23+Q84lq3PKct04JfKLQGCekyi71fK4tBAzcEGDfXGIrxX?=
 =?us-ascii?Q?R3tnrcmpFxfe8hS85StCHn40A4CXNWo7jVKJqtAGIq1Bix/+bBwzycdthsg6?=
 =?us-ascii?Q?kv1McyEu+VCo5yikPVBPtiWqriu+zYzISD9WBAdxZj94FzUPPH69Iq3eCCbW?=
 =?us-ascii?Q?yGKHzFHm76VUMIb7EbO087n0Ai8aR/qSTbHmw5oS6srWhU5qgUfK2qA2ADo5?=
 =?us-ascii?Q?wIzAPNWaMHKqguelkP/whfH+4QmuScsEDpWKun03xqNLEc6tegQy+zDEz4D1?=
 =?us-ascii?Q?xSt4lgkEIhhHN1YoWewpU3oNUpD5RXgxFQrNh4iWuGCnZ4NjTno9BXtV9enl?=
 =?us-ascii?Q?fSWkxsLGnYP6XLGqc+Xl+zEENxFQyCFn0jNMAf9BBmarXwuExxYgj9C9uivF?=
 =?us-ascii?Q?cjqNZggjEsnzP5qOPmbzSDA0OC+qdVOQScNqlexvND/BgtjhYJVAQXpVzVnY?=
 =?us-ascii?Q?2GtnabggpIeuak9X1acoLPgADuaEnFJhIWHDbKnvJ1UxodObceVeMbHIdpwK?=
 =?us-ascii?Q?jy669hvedyQqxRK73g+5oC1M8trHxt642hYptNcjJEITXUBZhjLqsEKkaew6?=
 =?us-ascii?Q?t0w6P2L01V4I+RFoMFMCFSmoGYjPpYwpQs3B0cpirgD8sN+gUxOsLy2C9bwo?=
 =?us-ascii?Q?68MzDFhDOFt41zz6XWQOgyQEXtoUFS3Mqj2KrqA2Btl6cVIpWGJT1FxOIOiM?=
 =?us-ascii?Q?QAJcwoTDNUHo0WdPe3VZJ7CgKbmx/lWtmyYZw5BpMZDIe2Gv+CV3m0B6Cw+5?=
 =?us-ascii?Q?0BR+yRUTJBpwipThcV7SS927fyyxVQmELIN9/tAYCd9jZP6FoaMLDmYDjrW/?=
 =?us-ascii?Q?wf4u1k5SyM8Wk842A7Efzj3BhMJQv/o+LpUPaMm+REQ4BEe1NwvvM0farAlB?=
 =?us-ascii?Q?1fAf6G/00NyoHF2be4V9UoTYOhSF6dKApxQPcHkDZ1D+bY9N4XjgFlwL3MVX?=
 =?us-ascii?Q?z9GIVzEhR36ECJU795PXaQufwSTGk+lsYS9gbVdb/iQBNQv32TUbMzfzgw23?=
 =?us-ascii?Q?MNjw0vc+c/JB4pJGhGN+UW8gbZ4WjSG9eT1p9/nokM8g9fyIG8C1ZKcp3vZc?=
 =?us-ascii?Q?dA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 660bf8d3-9981-4039-1cbc-08de0c8a27e4
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 08:01:04.8804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GWxEXTS/Z37+/0DboOwR+1Ke8lGPCAI/e54jqJZk4zCo4brNbTBMX7FlGPuYe7NQTAT5Hz/d7LcXunq1Ld0wks6emDWisOBXjBRvXUvs5qo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1308

Add enable-gpios property for controlling the PCI bus device power.
This property had been supported in the driver but not added in the
dt-bindings.

Fixes: 22fe32239770 ("dt-bindings: PCI: Add StarFive JH7110 PCIe controller")
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../devicetree/bindings/pci/starfive,jh7110-pcie.yaml         | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml b/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
index 5f432452c815..f254c7111837 100644
--- a/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
@@ -60,6 +60,10 @@ properties:
     description:
       The phandle to System Register Controller syscon node.
 
+  enable-gpios:
+    description: GPIO used to enable the PCI bus device power
+    maxItems: 1
+
   perst-gpios:
     description: GPIO controlled connection to PERST# signal
     maxItems: 1
-- 
2.43.2


