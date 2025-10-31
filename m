Return-Path: <linux-kernel+bounces-879953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A202C2479C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B9B1895C59
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293DF334C09;
	Fri, 31 Oct 2025 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="uu8GOOKN"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012049.outbound.protection.outlook.com [40.93.195.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AA72EC56D;
	Fri, 31 Oct 2025 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761906816; cv=fail; b=PJlx0IlKNMvO9USiT6diDfmEjKq7AkdhbYACYAtcuzCRELPygl3JPU8BCtH+jQQ0xyKVzD6acRvOxALSJ6+P70y97+S0PP1ldF0+h1asLdzirmaTVYgyFCUb2TYmvdwIxYK9qSdAJ9wI8nQgY+UepXGmWtMX61niUzGu165CEdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761906816; c=relaxed/simple;
	bh=qk+9Mb5MO0C1baOj8iV6VGS1hSBo7O6Wj7uYEe0LGRw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aWbK/vDQJJyTWAxsUgkcsPl2m6tcpPmB/ua2rsfjatle3SEQ3V6XOlQ2njRhSL/coManQDwN+d8TOL3keCU13xBtmGWjKxbJjTbFisrvGbe9WjKsu7EG4cHKuRhebmRkDEaljCVraNExCnTQ4u16yLRJPwzc+M8GOdEj6MEGWwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=uu8GOOKN; arc=fail smtp.client-ip=40.93.195.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUztrXQE0C4sb4PoDHuFk4e83rcNzDpXe4izKQt3Z3eqzUEGObBkasActU8HDO43ugyZB7oT7fXf7Ov5LsG6fj5+ty+MhREtiNiiNQL8VLno0PqiUP7Ip2gFO/jdK8u9G1oJ+va56MNbDVOONdq3Yke7TSCpOPbAmdWiZHeu2or0Y0NOO5u94cN7KkNuifNSZ8CXZzsc1mdnXsfeUUugaqx0tO4xoBAp8TC2Z1AwQJlnbX6Hmb4rMyjT1iMMWpAo8WgN23jrk5pJLezIiReREzu0gjeTEhO9q1gQnJTMWWhXxuojAXYMz76hnyTqmiYD/NieSBRYC7mxes3zF8m65Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqF2zzVU1c7AQtb+wphcIOMCThtXRP0EMWL4GHgp724=;
 b=IvriT0MpFz6fdeqfOSjQ90vtszyilF85Qkm7tdGBXCuOaHAYtSc73PLQ1gkCQGlsA22LlzFSwHQkpXd/s9NWEdilhTn7BtaFKCr5PwnzXcydQqXdGvJ+CCmMcSxu/iT01UYkQjq4QY3Mf3pz53eJwOzdQxLL2/Nd7UHQe2sUZ2H7xnySKoeB/6DFpkL4HMsg3BkZM2B0KwtmHds1V5b62wXXYRiQOG9E2hKI6bJYrIud2/sZ3rguf+at8gafHkHq93idz/FWzwnGwjSD9RwIrOoqyVZyzq7kte1psiGGd8db8pKtAOD7ltPB5VY/6g5LtObpPnsZb6vuwj9uI8Cm3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqF2zzVU1c7AQtb+wphcIOMCThtXRP0EMWL4GHgp724=;
 b=uu8GOOKN4Mdls7OC1V1mvhMrmhWUiISFTVx4IsRMtxBBIIMrpUNHui2/j55a0K9lLpd/x0zuJSdKLuG7/iy7BdPbrDvQhkZjQVLYPmdjOK5kY1nFN3bOr1A4UHxDnolE25sp/bW0+SS+qu3LofdeGWxSRQ12BK8X3cXSxHulXo2ssV8bV4ibI0Zo9ak6LG/Q8y1xp2180y/x8206NNM3KMdM/x97BXrequUc8J0xceCzBuWeHp4hhXR7lUtcfDlKvGqBtOZ30M32oQYixZLysQ5dDcxXxuk9JE2M4/xcuGR8gYbDCD3xygPNHhAUm35/18fChAUQKWBdFpGtG/w9Bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 10:33:31 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9253.018; Fri, 31 Oct 2025
 10:33:31 +0000
From: niravkumarlaxmidas.rabara@altera.com
To: dinguyen@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Subject: [PATCH 0/2] Add support for Agilex5 SoCFPGA 013b board
Date: Fri, 31 Oct 2025 18:31:15 +0800
Message-Id: <20251031103117.910187-1-niravkumarlaxmidas.rabara@altera.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1P15301CA0028.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:6::16) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|CH8PR03MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: 15a52a0c-7e78-4d68-8be2-08de1868efbe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VAzvWGbHigv696UQPJzO7OCFWgMy2HXGV6wbPgGInkoOR1Xi2iQHIoYmUHWo?=
 =?us-ascii?Q?zxIRwWq6PWihtynXFfQFQ194wlLW54mWblLnxwjRzAWLuLmhbMux1Spkqgfu?=
 =?us-ascii?Q?ypgE4V+25qnmbWeuc4Jpn1xnBTHauN3hDEuZJ/rfFXGyTvebv3CPBF4Zt2tg?=
 =?us-ascii?Q?X2Ct5c/wJSsQXUoPFIaZn+Q+gs7nNOgwsGG25F3bOPUuVuxDjc9O4ZgisrSO?=
 =?us-ascii?Q?m4pE0lFpKDEHTlYyuByUp4OIezGTUmbJOJCk42gt/vLfzOuaCsV0gSezRznS?=
 =?us-ascii?Q?kqmMgf348lhymomlfJILaXvp9LNjiMJZtzm3kUYSLEX6oUk9lhWaV+jlnwq3?=
 =?us-ascii?Q?a+VQF+xKjCLgqOTJ2L9S90xsIoiq1a3sseHqgD2TQ2f3weehQiGe9kQ7x/Qt?=
 =?us-ascii?Q?tGxatlDwAiV9Yl1gcBNRl9YuNo+2+FAo5RUWEndrQ8KExnLakAVrrTCiYlig?=
 =?us-ascii?Q?5euPbXFAYpfDtkuR0wAABP0YGskBmi+so8kLUJb6M2Ny/1l4AQ3kRVQ9Fc4P?=
 =?us-ascii?Q?zUpqEKJiaaMVH5IolB4tOHxH0lb+1yZ2tI/LQy6v+3zS5SzysM6yOpVyl+qg?=
 =?us-ascii?Q?XfoiQhX22kzcyOznwMxHdQ/i3qHO9oJWldOq1It8POPogzn+kQGm8eCSiGoA?=
 =?us-ascii?Q?3CHxBRIIatZMTchEgEZbFL40SinjzDmRA0N9xjF+iNaeY5KZ1ixyqWOOkd9b?=
 =?us-ascii?Q?lwrZvaDSYkI252l+oro4AxFRkyWxYrmkJxK5lR9/TCl3/CR/DeDUMZDQTSb7?=
 =?us-ascii?Q?q/2NWp0Pt8XBJf47NAbdE9ajOPXi/x4wcviV40el4YyWWqKmyPXgd7LDcRPG?=
 =?us-ascii?Q?fzTbezk2qoFvKE2wrahGGVAecK5PT+skY3tCFLDIgrocuh8p3F2gH+w++36U?=
 =?us-ascii?Q?gooELScc/PZTjCzopMDIaJP2DSwSdbMELAhPl/6pOXejM8/nL1NFUPCrb/7+?=
 =?us-ascii?Q?Wq/WwEFJJmgc29GlxPHLofb751Cg84Huwx3eNNIpVbdKVb/7IeS/ZRYmgUg9?=
 =?us-ascii?Q?84RFSm7sxNMdz8mXLLlDaRYyrIgmzOTV2Qv5eDOVPJuSMxl66LkFJ0AlVayu?=
 =?us-ascii?Q?MMSDRU0j1+dyUzn5S5/KActOTfq5gm2qrf722Lt3d8sCjP+9VtdnAOD6Uh3g?=
 =?us-ascii?Q?EWyigiDwhHTgEibfoMBVlQSCJaO43n+EkA8Wsj4RU3mNMsbd1g/Uv3kfYR7W?=
 =?us-ascii?Q?zde4oUS8lcmTM0x4DuLZLh/dpVor75CH61QOpzm8lWw6KigGAo5EDKfOu/6V?=
 =?us-ascii?Q?LbmZIhWR+xXUbDM/nH0ACSQbcTDJZinydEfD++ucfXpCwNQa0ZyTtEkq0kH2?=
 =?us-ascii?Q?pQAfO5GsBvw/OrTi5tfpu8dCYtlEq+NTkdQPIP3sQbf3IMmt3G2m7oiEmKFH?=
 =?us-ascii?Q?HeWZ2Iuc/T4lPeq2V/4zW8fAhGderJei50KfkmPOc5q5we6tp5pK4jvt7WZG?=
 =?us-ascii?Q?lseNuTBuSxtjqIwQfoz3eXJcCl+1NGO3V3vj84Stz0K4MEdEMBfF5A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DJY8+9B9gXnIyJSiTvuWX0i/I7DdnNv25yiZ8bpKNoUdJapYpE4pIPNn4ctF?=
 =?us-ascii?Q?+RIQiMl6BFVciiM6OtOW3x9xgUj0ldsLlYDEVk6Cnp4JTPk1gXgkUNw+zNL+?=
 =?us-ascii?Q?yxgwJRIli6Nm6KRV3ZgBWspIZdq8v7kjo7J1kC0O5KT6VuI8uQrFlbzKYXdO?=
 =?us-ascii?Q?YmY7RNO8vodWg1dU3zGBC+cevYCEceHfrcJXyCiVTzEFCuTE1M1N9CJONx5t?=
 =?us-ascii?Q?T77tyboDC2/St/jAq8qR8F2CkLHnRWCTovWei3t+uTjAyTnWpkKN0bsH1tYh?=
 =?us-ascii?Q?FtPtkI9tKONsGzyDRTnDkoo1cHT5LjGbdthwULqx+49qezLZVdilNUofaFB8?=
 =?us-ascii?Q?8GS+/pYx2xAinSDOzSzCwmfulSLryaYi3mka03tnTYPJ//4o3BheWSPMUNLz?=
 =?us-ascii?Q?e6cBE/rxVOXws7Q3MsqSZwxMKq78cMjEmJ9zIfjPBIrZsVUOL5DLF/hnPmRY?=
 =?us-ascii?Q?ZIl0AvARy5QKqKgZuT18RdYPaEm9HvNtteiwAe2sfDJXFewilMjw/UjCy1t+?=
 =?us-ascii?Q?yKCtcuQYOAQ+IWIKS2EF7HVO1xNvsphaWxnyqh5Xjxg3lBGd1Elf/GrbYLws?=
 =?us-ascii?Q?KQmoJgLiH9NE/dwc3k88oO93ELqXkIZCmeYGuSVDo4Iv/AhI2YajbJxH+ski?=
 =?us-ascii?Q?kFc/M4j4irGNTIDyA3exZv20LJaqg+QI5J3xItemjrPHIZQqH3n+ccjncBy2?=
 =?us-ascii?Q?Y2YppQw5UBKWb6SZL85hE/NaB+ZG4uCyVHGmhbSACDuyu+vVjH64bKCwu/9z?=
 =?us-ascii?Q?z0ZKqlC8sdHlRtaaz9VS0UM7BWdCx4LjxTGm21UW0BQ/3wb0FsoUIoaknUfg?=
 =?us-ascii?Q?NaJdRx3q3GG/70pLUbOitIIA5MisplRu+PTJaAXhlZF48xCLBTwSrLJjWEID?=
 =?us-ascii?Q?b50R8bMTi56/ZFUS5EkdsmHZSS71z3T3PwaGb3edacWNGqMOMOgsd9ZAwEYq?=
 =?us-ascii?Q?wZEdTq5wbkhJor6pSyFGZTvEiyt2DWNGgmSTnOHnaLG4RaNAZWbkoAm6f2T7?=
 =?us-ascii?Q?RN2hYl8ejrl1RqbYQTD6NRxlzvawZobP8kotFRCe0YOFu9YycyTveG1oJ80N?=
 =?us-ascii?Q?qQUw0vO188BFg/WRD2Jzr5y/nmYGcU7rqUF0St0tJ+yjdOPWgQASo17FcEq4?=
 =?us-ascii?Q?4MNnwhvKpC/HHBl3XUJ/eENrOLpaE89XTex1ixGkBGdIA3oEQWslhrCeR1WF?=
 =?us-ascii?Q?PgypWZnfhbXEIhCaHbX0Xl79AnoDBPrzm9KW9+Z4Xza987gmZbie07B9T+hH?=
 =?us-ascii?Q?LvNukQjLhaFB9pjOFs4eE56/JWS/qsnPF4ellQa33CfRHM1yCV2FO6mzSE10?=
 =?us-ascii?Q?ECmJcV0N7TA8LMUehx4RhBQoEjtumkQ2a9pHIkEQfvNnRFtuzJlKC4ZkZQ66?=
 =?us-ascii?Q?BjK4pZrRRZdi16TEmXJ17z7rFKcmsA+7sx/6ConKih8HpzdGpccXjyE5z/0u?=
 =?us-ascii?Q?Iuwfz8Qn8SzewFP1GiOqCEVCggrHxvqy+Njm9v0poOLNuyAUOtHgwQvVO1RB?=
 =?us-ascii?Q?TKQuUnkOYI9v1bWylwxQzseRscYPGYexRXlfvPujDwFDK8BGBSEYBnc+2Nah?=
 =?us-ascii?Q?DBQmh3xEyLwf5BXQsBiX6QnWUNra5HeAoj0/zoY6jeq6/7oaOSAdxCf4pF7L?=
 =?us-ascii?Q?Pax3V8T2U2rN0CllYHXBdNr0JO3Qf+Dti732URP6zj/b?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a52a0c-7e78-4d68-8be2-08de1868efbe
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:33:31.5854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZ0glUcJNF0rnJ+HB6I3wWCy0MfEPNAKsfmbBDoa6pfkSbsZXIr38QlbXv3mSNl1/+UKuIY1r8J1YRoNsVfj6Y5AsJQs2/5hVJNeAfsyy7hu8vDix9ZjHjZUfsHfh3k5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR03MB8275

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

Add support for Agilex5 SoCFPGA 013b development board. It is low cost
and small form factor development kit compared to other Agilex5
development kits.  

https://www.altera.com/products/devkit/a1jui0000057q9nmau/agilex-5-fpga-e-series-013b-development-kit

* Patch 1 - Add compatible string for the new 013b board. 
* Patch 2 - Add device tree for 013b board.

Note: 
The patch 2 depends on the series: "Add iommu supports"
https://lore.kernel.org/all/cover.1760486497.git.khairul.anuar.romli@altera.com/

Patch series "Add iommu supports" is applied to socfpga maintainer's tree 
https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/log/?h=socfpga_dts_for_v6.19 

Niravkumar L Rabara (2):
  dt-bindings: intel: Add Agilex5 SoCFPGA 013b board
  arm64: dts: socfpga: agilex5: add support for Agilex5 013b board

 .../bindings/arm/intel,socfpga.yaml           |   1 +
 arch/arm64/boot/dts/intel/Makefile            |   1 +
 .../dts/intel/socfpga_agilex5_socdk_013b.dts  | 126 ++++++++++++++++++
 3 files changed, 128 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_013b.dts

-- 
2.25.1


