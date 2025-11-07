Return-Path: <linux-kernel+bounces-890196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF2FC3F76D
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3CA44F1A4B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1638531987A;
	Fri,  7 Nov 2025 10:30:15 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2098.outbound.protection.partner.outlook.cn [139.219.17.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080463115B5;
	Fri,  7 Nov 2025 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511412; cv=fail; b=LxvjQGL0cYkoZyvv94wIaf/f09S7o4YYkmOB/FGEIEnNxaiNq3HlHunXH3g7g2gLKCPrvZpDSb3tBDYPwnfbzmvkKoxm9FvAylyHW26olq1soJaLTTFNYyRu9k6qkIcQh3z9AM6CJAwQ9iqVo20EZDBjd542hQTsVz51Ni26quA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511412; c=relaxed/simple;
	bh=dZvdAOKsKn4xUz6m9MEOpO0j6/uJ8VN0HQy5nJL/ABo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EdSr6QmByv8imGISxGbp8HERbaN4hii/wrKMkhx4e7tlzgspfuIKm/HgGlDp3Z0EEMuxRtcaBUGE8nBwFMB9CDRNcuw0nyB3K5356nGpDBxRa1vZE0Lbh/iGdSX4XGbRHCq4EcXvTO9Dmar32TG7Qp2SaAXzMU/Crbx63JdYznQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duBQ2ge1405dCHHZPQ93zIn9xuVIP2E+yTqtpWIRh+OgMVufsAKw2RRfqJkq0vMlixu6pQVLlg0LpzHgpvJSNphnt/LtUMI1dTbt4k/Ik9NLrj78pyicPW91kUFGnc7ynSJ+QK48l3qgRz4/TJXKr1dEsF5LIjaUYBsU8glLAsZzLXVRqLG0nUCfZinD2do7wYCwizyChu4Payg2u0e0oXyGlH4fmfwZF3Rnz60uSfxxdqPAR3H7CxRqoVRGg9FJm4YQELMOqh8sCPkMh7GbuLkkGAqnGLA3glDz6WE3eQq3bnpI5NXjmOYIE5Vyp0QVpeIVkGgjHrSobyzivG7QmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RopYT9nzxjAG1AgJJOfzvjsouzhfjUNUpcWgGKqJh5Q=;
 b=EcAtN3MxqSX/J4l1MHCzXg6LCnw5MsdhWEUyKts1NUAN2lHII0dDAhc3SHX5oIrH4mSbiwLvsCafVcGnQjH59i6NmiyoeeQ+IzTYy9zTW19Ddp1HNFMp/jjPWTT34lTZSfP+4Y42S1gkprGHjrLHTSzYkTTyv1IrE25K3VHqvJaVbiVr3m+/RLn688L2oIf68cMVsseB4HSpZwJsjXR7bWugqEZvSjN0SqpqcIlnLxzfP30m1OMfHkJiTOJGzELM917NQy5Jp+K8hUHaN+sN8hfcYQrTORbt0CYItl2DddAZzD06sG0vpcn6v+japaLI7kc3lSM/cGY1LohrbWp1tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1305.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 09:55:39 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 09:55:39 +0000
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
Subject: [PATCH v2 1/8] dt-bindings: PCI: starfive,jh7110-pcie: Add enable-gpios property
Date: Fri,  7 Nov 2025 17:55:23 +0800
Message-ID: <20251107095530.114775-2-hal.feng@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7aa2df87-424e-47ad-9324-08de1de3ce5e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|1800799024|41320700013|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	bmPYnsQGobFnS83YzdcFKYph65yqnS7rsljac/Ik7NqUvJrqjKMnrDUJTbBDF9VzGSyPl/lKoTSTSj8KKyEmfB+CsHr0Kv5CQu8cHqFdbhAS3oU44t38fP+FW7LpCpqdH43PdyQz8oI3h5/0DXCaffT6s0YO05dVYR33LCU3u+22WnlRndRPBwKqfxPClgygAAcuZ7PWjAubWvh2idvJXshX0YMIsplfjxmI0RtlmNXNqIw31D7LgspjfTPzyAt23T+vjYoOCKIpAzPXwQtQYAXD+0KLETn/avl3SunNbQzkcWLafvdtbDaZUux0TndSQqarGNfq25r3HszJK0KwcFPl2qG62RHs6DgtFBTC5HVc5Qjx/AKnLON9kIdyuf21MvDajOSJZWlMwSMoI03yNb2lyM0gbnDx3CxO8omPSonIrjTGB3NDQgGHt2ENwRINHiF8OMCqIuDSM6Vbn9v4WvdBIjggIG0EHq61ZEDIQP1LarZLiV3H4yLtLzFcKbIHMwJVtQCj0inVokMf7NIEu8ayWwUXRWZg96CSiK83okkqorOuohFXL7IhK4wJljPijSZIaMQq3tplOh58G7OsAYHqt5r8mYhBA590QU5Jl2U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(41320700013)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mGLWjjd3DdEM5AQ7kYolD2QuxGvjjmFwmkNfMymG9MHnrE/FhbrdSy6uHWRf?=
 =?us-ascii?Q?m6alxPT3VqJXPi+SYgGCJIEWS2RTN55ukVkx0gyN8jlJGwgTBacsTn4spR1n?=
 =?us-ascii?Q?a9a3NeuecJHZgRke6H+uVxffu9xGg7OdAT2T9ngmIgr+vbcC1bnsgQ3Ah+Iq?=
 =?us-ascii?Q?cn2mFi+UDTfsF+jOSsia4pmAik1f/Md2hL8VtRFEZhiB7r6iLceTQcGg/359?=
 =?us-ascii?Q?UNG3NODERpsnGGpxiBkMnnfTRreG/jW25Z7OlPHyrPab0ZOxpBQAn2oVc3tS?=
 =?us-ascii?Q?uTYm/e5tmeZUYUG0deexeq2ptHwzAreH6Zu+iCWys72/rYkaur72CIz5dlfd?=
 =?us-ascii?Q?c+v6aUsMe9bTFCk9qpt6rCMTGH+6x1CZ4/kB3Bm5wNiHnepQjD/azTT6Lk9x?=
 =?us-ascii?Q?5J43/nCG1jkLfRKe8+pGs1mYoIciH3fvvQX7gmQzVZdUoMJ9/62sXlEZ4y45?=
 =?us-ascii?Q?NyTM1A8wl7qs59w3/cHcYLWTIP8m22vlmZz2CqQgTaBTFeJOCHrclEecjCvT?=
 =?us-ascii?Q?8opWj3U8hprSYKUbxjqfalA+4RHcTcWmsdLsCAelP7hdDidxBGDjops4rxLS?=
 =?us-ascii?Q?n4bkGfKW8YOJcZxjjsoziekfxnTsuNKKCmI6UO+fDmUG/FuDkamBSxJVSNQI?=
 =?us-ascii?Q?Eeh4DTtJAh4iiYzgRzeNMnrBDHq6hAR1D9p3YfzwmBFvtzTPP2+wAogxkuVT?=
 =?us-ascii?Q?rznFrrUzXKEPqmkZyNkriZM9NfuhWfiRi4jPJR2Hea45nTwzOm4LoZj2DeVN?=
 =?us-ascii?Q?Nyjp87coVOUpp/YSIiDiw4WQKs5cuBA2S47atNc8eV1jYWNPm4Lh3ZKjTmo1?=
 =?us-ascii?Q?lSotHmZhQ90l0d3p56Bg8PoeAwhRVN5f0E86V/E/td0Qf6roaWIBXPGIgSTe?=
 =?us-ascii?Q?smwP+tnvtOlO16gTF3Dkp/2NZhBBIksDDiak2F7rrHcnnx4JBbyX38YxcaPI?=
 =?us-ascii?Q?pCJFGO7jDtiWWaDlGYQSD7WK2iwv1d+SmXky7GugUTAAG4GQFrLnVHK7bDyD?=
 =?us-ascii?Q?bNl3NdMAP+JqndWLdjZaDNy0cJHXylMw2FJ0SktL0gueQWr9v7aIIofxmTyU?=
 =?us-ascii?Q?DPLjbzOuvP2ZUX3u19L6zmd572XgdadXoi8hL1d5cRX6kCFcCPlvSPh17+IO?=
 =?us-ascii?Q?7zIb1vN99UUO/Y9jd8BjW+MujnpQfbheX/1mnuOqNotQ7EcxovOcFxtBlmfQ?=
 =?us-ascii?Q?JXhdkYmhpALAwdPA9eX8KEO+0jo+zqkZvXeWavYbvu1qHWhjtYLhbG9hSAPv?=
 =?us-ascii?Q?P8YG1dHR2MzA8GzcX9/GE0tAbTSO9SG1jwdSMHD8zBLelyTYW2AyIiQUN5Ve?=
 =?us-ascii?Q?OGK0FzIPGYGiBaK+dHR0Sdo/skBZtcqZxXSie10cZtL2PJ0zEXpc8/MSEMvY?=
 =?us-ascii?Q?4VI+gh42cYTQ4yc+6qcibxF57fQUoLMN1n0JgJmEp3ixWRelyoSP9C0egCJE?=
 =?us-ascii?Q?BF8OQNlf4G8iFlbyCuqiDDec/IDcK1xY8N1kkA9GslRa+YwMSduIZ7U3ay26?=
 =?us-ascii?Q?59jUxH5JrEVG1A6uR/a5S4Cy/Oq3GAIVpIIjBs+Kn1cbLaPqmSlJF/4aKvET?=
 =?us-ascii?Q?L0e0LJoE/+/inRxVzHn1JwOeQvndqOMo5GVt5fK0g5XHv/fZDIV7Yk1rK+No?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa2df87-424e-47ad-9324-08de1de3ce5e
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 09:55:39.1241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I9mGPjD4rU54fTz1U1tzYZOUydLohxXqMOfNv0I0eU4gXxRH6YGyshwpv8pdtRebQ4JcBBqrjGRg2opApP+obzzaA9rqWCkJ53BRdkOUs3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1305

Add enable-gpios property for controlling the PCI bus device power.
This property had been supported in the driver but not added in the
dt-bindings.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Fixes: 22fe32239770 ("dt-bindings: PCI: Add StarFive JH7110 PCIe controller")
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../devicetree/bindings/pci/starfive,jh7110-pcie.yaml         | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml b/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
index 33c80626e8ec..1e36f92ec852 100644
--- a/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
@@ -59,6 +59,10 @@ properties:
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


