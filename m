Return-Path: <linux-kernel+bounces-889540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFA4C3DDE5
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2648D188C148
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFC230CD81;
	Thu,  6 Nov 2025 23:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="NpqUNQxv"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229BE34F478;
	Thu,  6 Nov 2025 23:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762472145; cv=fail; b=l/CTv/WNi1fqll+IdQ4uPs7/OKxT26slC0aODmrju3KM+scPhJVnAjINw3gXYHlts7LTJ4XoUXCiYeZGxAUR/pv7H605Ittm1YRGKbz83ReorMeQhxSBm6jF91MD6pZBtynfZuc4ESVt3/C7RrLxwHhddx/Q7RQgbM2a7IVeK14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762472145; c=relaxed/simple;
	bh=Ylk6yBgQ/vLtqO+BwM1nw8wiTbXYlRAOw0TM9qOAsbA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CAdzBlli1Mg7kNIe9L5rozRiMtMCMpoIE4cKfNKBdigKpERexM6wP66eH7yI4x0w+utFtSmOcNZzMBSM3WnYw9ezWKCDZLDFHbBWb66Ey25z4N5Jh6ob4G4prMoUi/B1h7F+XjYXiaYAozm6TYROtmd/X2sF4jqARcDPRCWLuw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=NpqUNQxv; arc=fail smtp.client-ip=52.101.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLb/D/KOCy2kpPHakDMlSu7pnmFmNBO9m5itklmyxrz300Us15z0eUL/gLWbqexJT9ZbmDKaRzO21Mcyac2vtQSySM+bpXy0tUFpX5p23dRExdAhZuHR6YS+L8fgsFrUJ30bvi8eTTWZvdK7MnvhPX9EqCZbhMrINbCNTgb/COIc4evzqQoR+OZ0aBWK9h/DvaFvuXpkLsASq+WYgyULEST9Il3qSttR3A5kUZABr7x7fRB9bhUGa8On7rXTnhpfey7wGpi6+209BWqmfU5nJ+sMHWxuVUV1yZYJnhrwsjA7ZzPMf/MfdZFQA6fz/I8P9078Wa6FhKQMgG5CoA19iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrBC6CM2N0aA7dYgI4l4LBxscgcOmLAo2UIIThggK1Y=;
 b=AEx7c/qsnv2vf+MKzgS/mC4ZAcIKNdbcAiAMRn/ZzkGCn3IzvY00VbGSn3igHZBCn7R7/aB0FQE/ZmF4Q3huEW1fZgjrM43Tz6xksDyk3bbZAmQYW6FQEXyl5sRqkPy3vdhOUkWPxREK7VT5fJVdx4WzQ8gxMKgSroa6llRyk7BHYT/aR0cuTp6VQSWvWmMSy9c1NzY3V3H9c9h5zXFXmqMPYGBrLcigKulIb5Qhqa1tRRR8Ipp25te/1/IpVXNkgUfkBQh/4fCwH5yVAUgM72tOpJA4ZdKzgrQqgqtCD4O/Q4dKZeReYDy8zvDf1CkBNg8rjLuBb7S4x4dY1g3Msw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrBC6CM2N0aA7dYgI4l4LBxscgcOmLAo2UIIThggK1Y=;
 b=NpqUNQxvXgndD2V0QsRWiOQQBFvmUhx7TsCnD+jSAwUkfZwGDKyDTfAc+UzNQew2ed1yg+xY2VI+Q91/KN5HggjY9G3Jk8drSHtm1EDwHDvdqlCyuTK1MF+MVBCmGwiDqWR7fbXmdbMy5bvS/DedCGj12Pm6zGmJZZwRTCoUudVMvwyyeT7jMGIKyZROY6ipaywTTMK4+wvo9RHuT5w3BsGrk+dn9Vqr6JQ8WiJbd1KVjtNkDP1Hg+9YBbgaLUitVUJ0KiD6qkt5GxnDCgrw8x59BBGAkHlKMYu+U+hBLIlIZYnP0peoutFqi11a24XnfkepBJDvSwjHquGq45kjJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by CO1PR03MB5794.namprd03.prod.outlook.com (2603:10b6:303:9d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 23:35:42 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 23:35:42 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mahesh Rao <mahesh.rao@altera.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v6 2/2] arm64: dts: intel: Add Agilex5 SVC node with memory region
Date: Fri,  7 Nov 2025 07:35:26 +0800
Message-ID: <3381ef56c1ff34a0b54cf76010889b5523ead825.1762387665.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1762387665.git.khairul.anuar.romli@altera.com>
References: <cover.1762387665.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0139.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::24) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|CO1PR03MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: 32074720-7087-49fd-f27a-08de1d8d32eb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?buizhaDr677HAkSBS4bwGtLHtH7CxJP6LZeuWBlT61RZ0IkFgI1JVwugjH/o?=
 =?us-ascii?Q?TEC15Z4GvRWZMiLS4f58QqjPM8GdiM35IhVfhbr2n1uMZs3UA5Luf3o9WgIu?=
 =?us-ascii?Q?gPWhee1JIYT4IQ7hjaFGF6YHdb3pO8lMhzrIeI8ZK8SHkwhoKXYrkg+nb41L?=
 =?us-ascii?Q?EALB2KwoldckLqLym1u/rlcGuhOZ9QcCs9a8qqn8vGZPWgRZDO9YtXGAf/Cj?=
 =?us-ascii?Q?OOJauiuwhOHnOic9JfDu+G4eH3S+rBzIObBQWBnQDN8Qt2MHP8aomWwgiLdq?=
 =?us-ascii?Q?9eEu2BcccqYLp6TL/LNHnsU0hHsGrEzJb0jrRIyoYuVKOz33DV8NK5eSqfl3?=
 =?us-ascii?Q?QaErMbyMhTPiwcwC2q8ttixLGb4bW/0+ADaWr4pbAfEhVwtdZLKViV/WDpbD?=
 =?us-ascii?Q?lnHXy8bbhQxJZ1rgZW4pHlhzWmxGswH+frFD6Pjs+cG0gGUzTC6pKoYEqNHW?=
 =?us-ascii?Q?cl6sr/BSbNi9ER2Jz+E0d4ikFEK8+DU9pOy81DdEiIRD1FXTaNuW6S5l+F5R?=
 =?us-ascii?Q?E1QP70hDVhJ03rmnk5PwZm2ph0m3dPPFQzU+G3h073ANPaYqfi17RbBaliHQ?=
 =?us-ascii?Q?FcENu/j5U2CkWfRjOMuN9aXbSg1dLHSBgzjsq5hPLX488zM+zNRa/jnF6ft/?=
 =?us-ascii?Q?dZ+lpmyiLHLq4NN6meydHAnx8DzfsWQuFz1xtTEfK/e4k/qt095tRNmI4VY3?=
 =?us-ascii?Q?7uRA8QGhu6fixxz1XcSYwuIuPcuO5ppu0tjuhRVrrqUkumb7o9/p7SlZ3NHa?=
 =?us-ascii?Q?ZqGmMlKje9u7UkA5PvkbA1elHTKlGYlqQMxmG6VED/KjpuJm2FgCR1CHj3t5?=
 =?us-ascii?Q?Pr3GkGPNZC4zFnEf9kOo9ttsoN+mKVwmGDVkiSdQLStEpPblbhru3CuoiSyr?=
 =?us-ascii?Q?T6ovU7/tRUHYo4jZO/AnseeuBbF/hTgYOvwn7620phjBAba2yzIxbqq9Obpm?=
 =?us-ascii?Q?6T+OS+hIo/h7L6yY7TQFnuNFfF9P7UubpAqhZ8ft2bgYH3oF5CLgjRcxGpPa?=
 =?us-ascii?Q?5C0LFOlN71U92pirwttk/xJgLY7/6sEYUH00H02M3ySSVYZSRhFoeT15VvFK?=
 =?us-ascii?Q?QjqG2AkBt76a4IG06F9cHkm/HFfeuRGjA3YXcc51OvWJ2pi0bK0QqIvzktN+?=
 =?us-ascii?Q?Yc3+4HLvW3QnLbjUji8L9N1BavWX5KL8Tm9NOEkCk2gu0jjDY3JgCeCPG5DA?=
 =?us-ascii?Q?06OmdI8JL2o+w1gpGvEoJPVZUIh+pvNkXXWSHnyQfWglsqgE8jwwRmOfqjPk?=
 =?us-ascii?Q?+Ot4GJ6FWHuXC33WSIiWfPqbx6TBk4Tb2r8mpJszSyMNPdhOjRKRF9DCjdfY?=
 =?us-ascii?Q?1P74ZBpgXc4Ofq0H2Ivs9nM8z9K5LpJzWdZWtNeqo7XpgGU3ZoXvJ4u2ny8N?=
 =?us-ascii?Q?PJMh2KGg1PXSZjZimXXnWnY+TC/V6Bnjo+12+0mZJjK0bg0eNIHB4mq82c8m?=
 =?us-ascii?Q?tCLj4+uuHn3P4T+QMH1uyN99oNBge3aF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k9XGVQwARD3kwU7Qqa2cIUeGooGhpgRVrO3h61IgdI2ZNF/+Iv7t4hVw6cui?=
 =?us-ascii?Q?iqnz3xwBXZlnvvGFg+cjKCWLsaZRJZXIBXPvtb91820hE3hpVLK/lOY1aOA7?=
 =?us-ascii?Q?XnrqtqjCefvw6R8kulJA/m81b7nE++2I64ma7fpx8Ddjxz7luNcf9jMiRgbG?=
 =?us-ascii?Q?P82b3d4VrAkAnWWbIQUN1Y7fhDeTFunwfQ8KQglIlNgUTD1uYApNUmgQOx06?=
 =?us-ascii?Q?XimzM7vFMF9FUHX7xR4uZiwk/vLVPTW1QVrJ99H4ESTvKvWOWDJ1BU0B338r?=
 =?us-ascii?Q?6A91nGfSF8S9oXC1UxlbiTZ+ACk/hDKrCLraqPptM414LI35HuwpP3X6OEuW?=
 =?us-ascii?Q?yTE/GAoSAL9GiqGySJI3G7Ny06KAmR7gkK+c2wrX3E2jI9GFWLpKD0UeKcO9?=
 =?us-ascii?Q?OyVt96DHPZWpMlYGKiEhfSDNGG9Zzqy36Wn9lJdpiIzV2peTUOE2bJFU9LmI?=
 =?us-ascii?Q?4jz+CcgrcejNC0eAZwsDYfVKwb6Dy7oUyKk10gaxyL6t7noSsNr5PPEjuP5T?=
 =?us-ascii?Q?q4i6NGwgPKeG4wmE0+1wCi+XO1MRjxdvFmxy4criBEIeW69Ys/X5RDx/BWen?=
 =?us-ascii?Q?yNgZsUM4BvZP+5b2Kuh6ISZe/fEXJtJ7HHfiuPAgipPJrPVGkBJm65B1Fd73?=
 =?us-ascii?Q?KTbshe+aVRfDffbR0/Lz3StYJLSQKuNArJD21EbrWfRhvjEAv83JEIsvRppe?=
 =?us-ascii?Q?pYMsa/6qv620Vi+OOFJMpWDuuGKYoeMJAikgadGBV5L/Xb05RKzUpqrA2IIy?=
 =?us-ascii?Q?f9D0hWVi3xKtzO1HNCZFA5zd8KcG+q/G4vM1QYrPQXRDXaurkupyNbDFYoLl?=
 =?us-ascii?Q?1fk0/Nan8lwKl8zQY8Slb2YlVHTsx8UA9S40RNJDWuvagXigXiSn+yDYt6NF?=
 =?us-ascii?Q?LQi5QqRe9BGgIqUEtF3VE50Nw8ymRgT9HixUlhkPByzNiHdmQ61fxwXCNsXU?=
 =?us-ascii?Q?1MI4eph4+HWDbnS2Vb/MFk0QDzDXdL/HdRWt5Uw67stZ1Mg6zFAnJqIefpk+?=
 =?us-ascii?Q?x+Yv8gqf//Qx5BWSumaJRPNUHSIsEcyZNL7nUiqzoQAgTr4Zk8a5wJdYZ9Il?=
 =?us-ascii?Q?mwJiygCuC7Zz7YN+/OB20Wth2LlOyzTJcvX4gW3GXXkHfBPdycHvDI9Sl7hD?=
 =?us-ascii?Q?UoUCzCKHbBMd9ruthjxKPAqO8wX8p6B7QKwlUgH3MKUgDJmKKICKM7mM7jWv?=
 =?us-ascii?Q?mffxC5ZrGy7aLriF74EPsYCF9oqNRMbb5MeTt/yDGvlI/k7Mq1wafVsolaOc?=
 =?us-ascii?Q?VN5oDPUV0OwjSMl9j+fcbDQUXd771pAd/GWxQjQknrSGAXn6kcFlV0yTzURk?=
 =?us-ascii?Q?hIwU8aDfgX9H8bS8XaN/KKqUXStSPktQn/PEkogMWK4vRtwkyAun9YfWcq0o?=
 =?us-ascii?Q?y8CuC6qRD0/UGsQX0lePTdhjufB4U3w9wkAiO+bqF0NiY/0HY3CtpUmB/9wg?=
 =?us-ascii?Q?ejO1Bq8WLQ9avDG1XtrsBuoUv1GHk5wkzdWoSllIKvsSg2EUMcyjoLQLwy1z?=
 =?us-ascii?Q?6ZwLGS0vO3qAl4GdCv7zxJr2OJkraZT4fyi1b1Ei4s5vVNlH6U40bQsmTSRX?=
 =?us-ascii?Q?KMOWSsdVJ5qBAto4c1STT0O/dMDw3anD4bY0JAc2oPuWbpu4A1/Pr8UZZKvE?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32074720-7087-49fd-f27a-08de1d8d32eb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 23:35:42.1176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVOmcICFUeSYemzHbr2P0BkJBR4jYtuL3s0pIoPeyxnfJnhE7eSdXyg+hDdEEVMObwPYLI1Nh0Lr0omZRlgBJNLnAXTZW/FW86feWtLAPRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5794

Introduce the Stratix10 SoC Service Layer (SVC) node for Agilex5 SoCs. This
node includes the compatible string "intel,agilex5-svc" and references a
reserved memory region used for communication with the Secure Device
Manager (SDM).

Agilex5 introduces changes in how reserved memory is mapped and accessed
compared to previous SoC generations. This commit updates the device tree
structure to support Agilex5-specific handling of the SVC interface.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v6:
	- Move svc node below cpu node.
Changes in v5:
	- No change.
Changes in v4:
	- Exclude peers reviewers in the sign off.
Changes in v3:
	- include iommu property in svc node.
	- Rephrase git commit message to describe iommu presence
	  in Agilex5
Changes in v2:
	- Rephrase commit message to exclude mentioning iommu
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 408911ea7bc5..bf7128adddde 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -79,6 +79,15 @@ L3: l3-cache {
 
 	};
 
+	firmware {
+		svc {
+			compatible = "intel,agilex5-svc";
+			method = "smc";
+			memory-region = <&service_reserved>;
+			iommus = <&smmu 10>;
+		};
+	};
+
 	psci {
 		compatible = "arm,psci-0.2";
 		method = "smc";
-- 
2.43.7


