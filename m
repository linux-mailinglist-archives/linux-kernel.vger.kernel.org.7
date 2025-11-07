Return-Path: <linux-kernel+bounces-890265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EE4C3FA6E
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E4D3B8D54
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9805A31D75E;
	Fri,  7 Nov 2025 11:08:37 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2090.outbound.protection.partner.outlook.cn [139.219.17.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E51A30FC23;
	Fri,  7 Nov 2025 11:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762513717; cv=fail; b=hkG9xhFUKlaQ9LdaH5T5RXOUlmUddqHabxlfbJRQhhvf+J1Bm5mk16z8nasvwQgBnKc8XzgOLR3J+Tv2Hp/Pey0MgQKBgkyFAzpfBPh2cIo3oVCg4Kmf8Mk7LGyIoaZAbKyuo9sTMdluM8GBUzTIIerFKUllLS22le0zE3AEUps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762513717; c=relaxed/simple;
	bh=nL5jLAky1y6eU1JSj2sdKu7T8q6TR+IjSIzWMLgQbCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bMtYjKruxFTOATJ3VhSWGrb0VNkzfo1oqlRiKlZKy0qtLo3g6ni7vicqjsAjMcat1Vx/OEloEuhtk+TgtUlpgP6DAtsgs5VFbCXZYbTd7tUJ62hg8ciFHFRVz8C2gSU56K6xerbE93ahQjrsxrrtU/MFyukCMgQpK0XoMtdOyjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from ZQ2PR01MB1305.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::14) by NT0PR01MB1309.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 10:54:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdozJx4+cs6dqsWrentRm9nQbAdDmcv6VbDc4NHYz0ksTpAg0s72ATmYlba31LOMZMY4Suyzty2/NknmtA04HFoAWxVzKbFqccKCrx6xgg7p3KhStbfMJJnRzZpaJ00YflUkJzGMWkBuDAAZakobbhqnl1lMLBizstClNp96buKnz0Rzj25srhB1QuZz2NUYZ5aDL7CiGHm7BuBKMAiaj4eRYRjW86koZhrMLa4+uwsNmjkOgQBhYy1vgdYYfjR2KV/6bxjOvbEsgsHBkNOAkaxw8Aut0jqVZC8OtfCtZcoD1xFzwT998izATIxAWIhmbUQMjjA3bDT2PJu0C7FhnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrdOIBe6XTVZYCkuYgFBIwODEgTpoZey6Uz/1VHRgT0=;
 b=e36z+ag0dGk285J+fFmDEVrbAv+TB8GLVn/oMegF7/7HHyNIBFrlOlKZmWWe6eGmtCs4+fwWI4xfGWB6vMVLZssOF+rLqmejO77lU4B7H72C7zt5KJLlvAFBKO40D25BJDjfol5UkZ3FqeWwnTuX28o8iM7sgHx3GhCWRzDB7hjoA84OFP5hOoDuih4SolNRpEE8OF6XX0o+Xe4oR7EDPAjarZBg1dD2uVhwOQZFy5hi03puMnGO/7FJVNaZC4HB74wGX2bI4OjBatZuUYN7S7A7xGy3d4jIaX86N23R5ZnsJQAiJ2s/mu2vvmBcgvkQYzxRoK3QEmAWu3ZAzzqMuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1305.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 09:55:40 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 09:55:40 +0000
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
Subject: [PATCH v2 2/8] dt-bindings: riscv: Add StarFive JH7110S SoC and VisionFive 2 Lite board
Date: Fri,  7 Nov 2025 17:55:24 +0800
Message-ID: <20251107095530.114775-3-hal.feng@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic:
	ZQ2PR01MB1307:EE_|ZQ2PR01MB1305:EE_|NT0PR01MB1309:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c9f0c0c-8aae-4c2a-2744-08de1de3cf12
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|7416014|52116014|1800799024|41320700013|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
 7bQqh4feFPbdWh0jCeHER1jTrSE1exxiyUQ9KWvtK21DLJr1isQi64CgJ4zcZEC4ul0gvsiVMf1QPCC9EDTUHLCC94wthajav6NN3Iqlkf30PJfhic9xZxH4I4/xpfuAk9eZzDgA5M6f+CtaQSTwY0S7+q+DzMqN1jdB2FV/fKZSyi7nH8cYWLn+vf5aNab1l12IdVDJdLAT+FgHHTmPw3wDysln5Z9llJz7po0i5UCPmAR2YAWVosMfYjRdGNJVqDpJQ6KjoVj2YYdfapG9GGWAa+92HmpFiXmDsILVp0p7a1wW31xY+iQ0eO66fmza6bbypNFIfVIUUTzLzqyp2ET/ClDcj+uZaDKJ9DDOS9vyK1znCY4G2TuuUtDG5yDjeTDo+PMBuGPnZXXx0XxnTJjw55YsiTM6+/EHPw6SX14v0Ir3R9CO8wy9RoJAP+T1HkAy07DR2I4sMWCK5i919fHXCUTeiqSBxnGvSMGriammMWLoQRc2wtOG8nq1cOU+FcMr73Yn421i5Z/0Oe0ePO/p0SOsHjdlc2Cq+wMLmc5sA8DHU+ej7A34VKJsJBUUFBLFODFU5rLlwYjU8SKpXa5E4SrmJzCmLvC+V105RvI=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(41320700013)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?TiLpzzMZJ2X20c1L2tUPjC6tuzqY5TUr6wnIV/tSGCHhJtBVjDTpMUZVVKO9?=
 =?us-ascii?Q?lD4bh4ZttJGyVminG505oHDp7aDENfzgcLT0ueufWLJUO8kSKG000Sl0rk8S?=
 =?us-ascii?Q?jpBuHYumhs941sef+u/UeQk0Qa2y+3Jaj9w+MCgsSMfzEYF53169voCBDK/R?=
 =?us-ascii?Q?BcK40KpYZs5ybv55GRBKRyXdiBVOkAlV1ZIwcM5B/LTky3kKuk3AanbeLVhB?=
 =?us-ascii?Q?86zAPTRLhNNX4v6yR9H1Pk+ihqcD6590ac86uLc9wm9k1rOq7talLLcmI3UM?=
 =?us-ascii?Q?RGNGCTq7q+6R+j7I/DWJ85eDa4MMh7yjYSigpOz0xiWs0Vxnd3L8TwigJLCJ?=
 =?us-ascii?Q?+nJVOAf6kW0ZKff39q7eOeDLz2UgmEXCczMfPdOl3dAC7fSaB+CzDdDsabVp?=
 =?us-ascii?Q?IRMGg1gwUkK60U5Jfh2DOW/dihvgN9v6s7KpwjNmdTc9xMT/ajm/ga/kxTCR?=
 =?us-ascii?Q?8ZVbOXyFCFQYgOhv4ULvK7dlcV0mkGCoArrjLvU/y93az3olGYqSMwmVGWwa?=
 =?us-ascii?Q?VIcdQU15yBjNYbycw3XpsKfN05lMxOrJLpj6CcLMO0Lygn1JW6Drou2wivqg?=
 =?us-ascii?Q?J5h6YQbb/GZvMwkSJauV5CNB+dI7r00jOwJa84Degar1cHteJYSzW947JHag?=
 =?us-ascii?Q?AsxwghJ+OT/fDTFNrh5/DQKbv9zQXB5Mfrf0C16sDHc2FEi0nUqg9ukyPRfO?=
 =?us-ascii?Q?26HeWWtEwjqDj4qq+5OdJyg52Q2FAg3nvtbZJEnTgsQbQk9kVn45U3+y2VcL?=
 =?us-ascii?Q?Rxro54me3f5ofna8Ck4z2WU+R2vIXi8bGK0QkWNnOeOzV5DrQlFDzQx6dsT4?=
 =?us-ascii?Q?R0BDZU4ImEaZavTE1HWD4UgHPAEj32jOVY0xLy1g45OZ34p/GL1OCD9WkjqP?=
 =?us-ascii?Q?Z5VaMsPGKdzXg17Cfdgiv3bpiZ5Bki/USQscL/ya0F0by6DXcQ6aCXI7e6rN?=
 =?us-ascii?Q?wRQhoXcpvRqMqLdvaeB+yxdOG4JGUJP1g8fqNZRrxYHMhgdvTDp6fIUGmcmL?=
 =?us-ascii?Q?VOhAYWs3MaZ+3vX1/gTLQQ4NuoMbutSQH/dKHIEKBxtOKhyGyVjFyRelDeDB?=
 =?us-ascii?Q?4I31l0/TXNbjQuDTq8PYjVCvyKqEq62v633fxYCSujfAGh0FuRHO+LB79bhM?=
 =?us-ascii?Q?GzZTrFYHHu6yM1o/5CuTy+90LDicLZGd+XdbLrlXPsrvgIfy9IijS7iqSDyp?=
 =?us-ascii?Q?340vgS4PoC0eq1a8RVqbJ27u6d7i5szg18idt5Ld7lmYIy0TgCLKK3X6+LRx?=
 =?us-ascii?Q?PM4dmgkE+HgHLhBrslLJpMzX/CYF5qLPB278faGa1iHgyLkqYp2SaNx47nAQ?=
 =?us-ascii?Q?QTkxanWBB4K1M++iJmaDf5hH9/4PTa0uqaNSBqINJVPapZ5+nVx44hoWDl/z?=
 =?us-ascii?Q?Qvz8sKaKeqc3G7PiMTn1X/fCsM3fIBTHVRmBlkx+T6/mbwrs3eFgoD7Y6zOn?=
 =?us-ascii?Q?a4DUAWIbYCRXreRXWKUOarNHNN04YnkZBVgXzgeunG/WTe/a5lYW79LtMJso?=
 =?us-ascii?Q?3Cc4wIqAv9nqAZgi5gm4RynnBFpRyHgqO74XX7wTqfN30s1bJqDVhstUZmSK?=
 =?us-ascii?Q?WJfhfeqvaZvs0tLCnXIIE2Vie5U/QbLDXaeGZAOs/utdK8aAO4zv2S/DKfFs?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9f0c0c-8aae-4c2a-2744-08de1de3cf12
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 09:55:40.3008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGakS39WWJZ3ECey7QMJsA02iNvYb1an9u6TcO7wyX+bwXSACQQkf1ZaJG/PQnpf6RH93rwQJcVkrUkFyYSBEheLAaWP2dOnG5KcsdQ8v4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1305
X-OriginatorOrg: starfivetech.com

Add device tree bindings for the StarFive JH7110S SoC
and the VisionFive 2 Lite board equipped with it.

JH7110S SoC is an industrial SoC which can run at -40~85 degrees centigrade
and up to 1.25GHz. Its CPU cores and peripherals are the same as
those of the JH7110 SoC.

VisionFive 2 Lite boards have SD card version (default) and eMMC version,
which are called "VisionFive 2 Lite" and "VisionFive 2 Lite eMMC"
respectively.

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 Documentation/devicetree/bindings/riscv/starfive.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Documentation/devicetree/bindings/riscv/starfive.yaml
index 04510341a71e..797d9956b949 100644
--- a/Documentation/devicetree/bindings/riscv/starfive.yaml
+++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
@@ -35,6 +35,12 @@ properties:
               - starfive,visionfive-2-v1.3b
           - const: starfive,jh7110
 
+      - items:
+          - enum:
+              - starfive,visionfive-2-lite
+              - starfive,visionfive-2-lite-emmc
+          - const: starfive,jh7110s
+
 additionalProperties: true
 
 ...
-- 
2.43.2


