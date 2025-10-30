Return-Path: <linux-kernel+bounces-877486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 11497C1E347
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 04:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 89F1134CE89
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF78B2C3276;
	Thu, 30 Oct 2025 03:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="o3lw7/kn"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012039.outbound.protection.outlook.com [40.107.209.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DFF2BD58C;
	Thu, 30 Oct 2025 03:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761795022; cv=fail; b=jUdfDjqjSDaLrsuIgyvCQfeLkXg+8f1nyQ4l41r+/n26S304dJ/o7GbriCn+zTXiU4I3V7xmFk447viCquIQ+aO0OjjN0DBJmdE+RsMldUnzQNREHrfYasxFj7kitXgz9t8Sdk9NepgBYACpS6zrPenTEKTSMt7FuWKYP0w4fZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761795022; c=relaxed/simple;
	bh=EFVM3yR17x1JUkyQLsaYpuaCWqSRdP8H8XLHkvhMUx0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OZlVe6PdXrn9eA6Q1SJeCR3alCGnYV1dKA0CSAvlaN17GdVLI3cLxP5xHtIpemMlp9ETHyynRwh9zU/+evA2HC6/7NxS7wG6sj1F04rWtcTysA0yVqcshzU3tyuR56NrVsemJofYFaarFMaylveNPNXRYiskhBf95LUucbg7jhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=o3lw7/kn; arc=fail smtp.client-ip=40.107.209.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEyXghfXl3muD3ow1UbdXNg1MPdPueRV7x2B5hfQN5Rl82qmM4HiQIrBwmXERdC7W77WrfZxlNndJ7lFN1Bf5Wrt+iKfThlY/5+CBDaolYugJ36q1X5WCEZcNHurxRN+vfQzNrGGgi4+MGXDC9CANrlRIFUzsf+oJRCuS3BLoF/6lwOVKG68r2Zcc53Kt7V9myFIjTdOhNIcZ/y9/br+vQUeaVDLu0awu1HQYk/Vsw2Il6rt4uaIZc5csz+Etfxe24JcWZOaAIMSjz6BwQXoH/CfyxbJ0Nn/sqlkpt6zEv2m/1tQZs6f4SGVoFBQmKysF/0ylQUnV+7n9JhZRgGFmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsMz4gYGu1bJSvHGQt6gUB/K80Us3MrKzei1w/OINgQ=;
 b=yuzrBtsorZvPn7+tMBygZ8yoOtk6zBZYpM7+/0Ddson/4iV6YSicNKAiPZfNMxZSF6mW/hpxhoH5cqCTnid0qz9GCe3iXl7kkVRNHryvbw66eJodT5zfHCUtr5Rp2f99H4M2ONuaC/FJg1AyxvBMzaCN+zCNbRBRqSdRZxFzTpJwxQgBqbYYmrkLPJl8SzBhSq5+ki9ji5SId31+6UIdXAYFL0ndAaJnkx7IOy+5g2OT30aWFuriW5fd5ZBt6JhKT1OGa539MWbrZGTXFs8uInogHRYYV9Di4HjmAyHZV4hsk2au9BKQ3C3WwXfqR743nbk/wJWP4AtnxddDRLn8/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsMz4gYGu1bJSvHGQt6gUB/K80Us3MrKzei1w/OINgQ=;
 b=o3lw7/knlQUd8GeGAuDotQSnlXLjz/wJuNxNLPy8Sdz7qcsb5ZjoD0pvwpTYWgzduRx3OCRr4TVNAVtICUT7SPEJFAWSAO6bfZu1+Jzu1gfbN58vEMp09Glo8rdLwbCew0d0TF9VGT/hhCP2h1Ly3VPqhzv4HG/lm90Qo2ZSAyL5ONzspmbQrihJe0cDYmxgqVcX795tKxFsnEpRgPE6ft1mrIPPpsgQ/Ld6d7CsI4L5RCJAcVliB5ehn/Z2yPwOpGsCqMvte+qINcqGmp+JyKVjflfc89BeuiN9b9BppvmRSMbgOQp0f4vgRKEkGCvzqL5Ug3ePoA/N/mbKhfyxFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by DS0PR03MB7655.namprd03.prod.outlook.com (2603:10b6:8:1f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 03:30:19 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9253.013; Thu, 30 Oct 2025
 03:30:19 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mahesh Rao <mahesh.rao@altera.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v2 1/3] dt-bindings: firmware: Add Agilex5 SVC compatible string
Date: Thu, 30 Oct 2025 11:30:07 +0800
Message-ID: <71503d442d66054c023ec25ae21838c0939c72b4.1761648711.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1761648711.git.khairul.anuar.romli@altera.com>
References: <cover.1761648711.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::26) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|DS0PR03MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 57120b03-b445-4421-aa96-08de1764a66a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fEFG1+AWn2BTEG1OpVbEnv8wwUovKL/lBXmiD3qM8Lyz2RgezgmcskqWY9Un?=
 =?us-ascii?Q?oDs7ymvz34dghtJizr5+9E5Iqhi6JsCxyCrhR4oQUqd3bV1h4eUVmlKx8bWg?=
 =?us-ascii?Q?5siElWjazaeV4EIS4PoGeTaMxw9w5ApN8GSgw6p20++4F35OjvxtXGgKti08?=
 =?us-ascii?Q?HL4LNEiPG6A8BxzAbBdiLvGMavW2LVok1rpcGnSOf7Eb+DYdBawayDR+DANu?=
 =?us-ascii?Q?AP2sNVQpWFOSTRfzzfZN1Le4LC462gCf6IxQdWKaDS6aO1cmyBgX6l+OEqDT?=
 =?us-ascii?Q?z9fW/y9t/dgyaIjgSTZgx360rzFbVJHe7vfesiKemYaDp1sO+z5zNA+wP3MD?=
 =?us-ascii?Q?gICyDVwfUtMyDmlxMXxnFXVG3Fo8D0D6tyEHxlZduHWBaYTmo1aDzae8vlfr?=
 =?us-ascii?Q?bcOoXN91FALZlzhQUOSwjJTt3AGYWiCrb/JEcx4SCj5DHwtC37WyPNVFg54o?=
 =?us-ascii?Q?BvvEZ2u6MZWHSzqLv0VongJzT7uHH60bMu7IyxdOkK3ft0Tfs39kcd53Lsb6?=
 =?us-ascii?Q?CGXxQKCwfCUV3eAT4K1xw5jNo0YtcXC7J27+1d12MyrVCqyK/cxYWEDZ8Gtf?=
 =?us-ascii?Q?d+90dCxw73aNQRUkyij1kBT0biBOsujAHnySftsx1299GW13KGic9qcen+ES?=
 =?us-ascii?Q?j2IPIsF8Lrglh52seAVwPB3680o81a+/PMI2raKzh6BghZosVAOYwjgdnggT?=
 =?us-ascii?Q?rOxAsrqLWGDxUnng5dXCYG2mdrAxus/C/2h/u+O+Ng+4dKXCRrLB8P82yNqI?=
 =?us-ascii?Q?6og5YQDOmhLev2KXIAchjRDxmM6tnn6KQcMbgPIUSLEzbYTFJHEq8Dcw/bk/?=
 =?us-ascii?Q?2L2KdqdOH3jGE/NgXE/z08VTxCUkGZAhddOEkLuD4u4vXXn0ZBWmxlzB5vEe?=
 =?us-ascii?Q?VLdH2wrcZ+z3yEdVFL2vD3aGSZQE5eF4NipRWZbxHx2eI3qzKDCpGzmEfdtq?=
 =?us-ascii?Q?QGEM7u7NKBjKpD86/SrZ6QRxb7qIv2ImGepDbexRxIwhYTxjp/5A6wuzSEQu?=
 =?us-ascii?Q?bX1krX02mwm0d0b5o4kdg1IlsM8zDzaTFtXVZNw8Z79fD210y8+NvGDXKt+F?=
 =?us-ascii?Q?vjzv1ClmE3XtFib8NgICKKAvLD8TTp8VaEhvOwWx3hudOTtjUO77/1Xvo+JU?=
 =?us-ascii?Q?3tfIYV08OijtmswvRnFnptsbW/K7tprVVs3p4MD0J9myEqog1bXX/smG29nA?=
 =?us-ascii?Q?cGqPOTpdWuaqjtMFXGqZRr6O1XhO2VSF5Bd789pLKO+1O7ZL3HnwlnRdSmUX?=
 =?us-ascii?Q?K6jIFZ7lAmrjE+w6ZHjvjWc4LA1OPX4OIO124bAhMb3b8H39cswBoh6lnJMd?=
 =?us-ascii?Q?z5FSERS5UcbsiM0zO89CbUQPjskVRW4kAEQT/XqQGl4QtIo2aiRoNIqxq0K2?=
 =?us-ascii?Q?vj1W+1LC2B/Mw13l6FXMHVsNUdrBp8hpbQ9LbQbge+wVErGuazhX37QVSxQI?=
 =?us-ascii?Q?t4excqrl4Xp3YACutOnrKCqFvoadVVUc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XbvP2XR/jrDztJnO5qZjsYjndX6ftO2/tIa45pgQtlginurDpNCOwk+JXx1H?=
 =?us-ascii?Q?FWpN/nGlMt8mYK7rhz9Uub/NWWY/H1ko5rFa/yHW/Tw31Bv0KWBAv76rYSog?=
 =?us-ascii?Q?wSsJfvTHVNF/Nx7/0F33cN+HLTNEmFM2Xog/I4vlGBtKbt80N0IWlSu5kbah?=
 =?us-ascii?Q?0Mop4ws7WEXKGLIvZgvSoxw+sYLGoV8JLXxwFnf1tjgjiBSswMtBLFDZKGRy?=
 =?us-ascii?Q?aT7h7xbXPltBZct0BmkSw86kIxoCzeDKqEZ9J874YskkLgVamEMKtaEk5LNo?=
 =?us-ascii?Q?bCqi4wXMMUYyfr9+/5AT3o4dMs3jp318aU+HA/ToSiurR8CwIrFlKR2+WyIL?=
 =?us-ascii?Q?LdSbuEhN6GUytx8/4+6E7CMVIDIPREeANzdDqYNsc2bv0w4g4isFuc9WQefP?=
 =?us-ascii?Q?DTnpc8+ajIam8IdA/13VlYRz+3JFEZu/VEMLXT5pV6mXWjAYLgac3X7/4nzA?=
 =?us-ascii?Q?4qQlxpff0k2P0f5I93VNxEYu0mH+Q8Ju5gKr6wP1neMty2bXZMw0syKjbevd?=
 =?us-ascii?Q?DMs9QzTB1r33IP2HkuVnBBXtWgnrbd+foirCSghXDtHeGXtCiXigZnaihCMi?=
 =?us-ascii?Q?L6hyFulnJHb61fav7pEZY+rh6bvhUV3b1XSNusE8dSzKxb58iDYAWrPY2irB?=
 =?us-ascii?Q?aNiwZ1q8uPEb2+chkWn369F5GFl3hUAHLUB8BtdL4dy2jPEusc/TmGHlAse4?=
 =?us-ascii?Q?NtGgW6Wv4WtR2onK7FeoIeYP5C+UuKHu1xQ7xsEAgt/QsstkQVYtX9nh1vuj?=
 =?us-ascii?Q?d+hspHSYSlzO/YVb3v9H+v9hUBKQWLdGJWinELgSHCGLBYCxaVBYfv9VTyK8?=
 =?us-ascii?Q?/6mbekNaMGcufalBVooap2pwJFoC0MwJwCvaTPllosGTOu5Z9uKLAHyyHfWN?=
 =?us-ascii?Q?kP0jHil/v4n2bgHXAtidityXuBErrzWWcaARaFhCIS7g+a0Vw2HUXW8SJsgk?=
 =?us-ascii?Q?+bYeVnrGjQHZsXwjd/zLD/sIi137ov7ZRsMyJN67vnwKsth/w4NHSVN5J/Jo?=
 =?us-ascii?Q?tP0CtssWDf5dnEb0UQSjrKXcqx9ZC86/tV7Tka7Yg7xJVVDYsZtOporWy7FO?=
 =?us-ascii?Q?d6o7yWZ5RP1oofgfe+yKbtRvXA7wqV7LQKsQTOK1veKNi7GtueA2kyqNOV6d?=
 =?us-ascii?Q?m0Pdqx13K8YRMbp2/A67mPrOBqOinTZCueVoNhUtCTLbIM8xemVnfysa3hmn?=
 =?us-ascii?Q?onYDPs5WWyJB3pR7PmCsss+4yRGK63iPwXZNdMX32Xw7WtB6LjBFqo858zlP?=
 =?us-ascii?Q?Z1xeOG+w+bUirrQGA/1vw6L/N+dFtHsGJP64wBrL2w1+cTg+1veqE2+Uw0iv?=
 =?us-ascii?Q?UDVNOG1fFs+wKjjf/e1omeSZQKY1WShvJO/Sv+YcP9HPoS25UN/TI8oVRz3Z?=
 =?us-ascii?Q?5UogZ/xteQQaxlYqEDTSLaj3DCqcf8S+jFJLGIUhqhXAkrFjYGYTK099WjYx?=
 =?us-ascii?Q?eleY61NA9tnOYaiqxHuvpijjWs73kMhLCQNSvdox3ghFrazkt5EA08/QqP73?=
 =?us-ascii?Q?GdYDTtYkBsAA9fNpVGPNF0Utw0FhsRBud7+uzMVbbpZ32heu0WrT5KlJ1VZd?=
 =?us-ascii?Q?1mSwnDndzEAGn2ZH2dAOlSXnBce2xt0VcWIY4J7+RTU0laKF99AkFdRxXo6s?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57120b03-b445-4421-aa96-08de1764a66a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 03:30:19.3921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rnA2y/ZK0dMx6y+Z0Wb7xPSB/Rc295Rw12ej8euVen3+nfeSdHycaz6AphaR/FynwrT8MKw7EX4wPcproijffIwJG5P3Xin5VCxQFXC0biM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7655

Enable support for the Agilex5 SoC in the Stratix10 Service Layer (SVC) by
adding the new compatible string "intel,agilex5-svc" to the device tree
bindings.

This allows distinguishing Agilex5 from earlier SoC generations, as it
uses a different mechanism for handling reserved memory regions.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v2:
	- Reprase commit message to exclude iommu
---
 .../devicetree/bindings/firmware/intel,stratix10-svc.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml
index fac1e955852e..90b4c00e3079 100644
--- a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml
+++ b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml
@@ -34,6 +34,7 @@ properties:
     enum:
       - intel,stratix10-svc
       - intel,agilex-svc
+      - intel,agilex5-svc
 
   method:
     description: |
-- 
2.43.7


