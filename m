Return-Path: <linux-kernel+bounces-813741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F81B54A2D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A15924648C1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B386A2FD7CF;
	Fri, 12 Sep 2025 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Dsjaxpnb";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="cVpUlTYG"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603271EA7DD;
	Fri, 12 Sep 2025 10:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674015; cv=fail; b=k/CaWnZvJkXLjyflGLbmpvxDW/yKmB5HInIk/WB+v2YFu8XFc0PW+DHMRhC06Nps+6n4wx/zQG5N+cCKv+ZZ1YPzaPbUQ44D4lXTIq9+dCVIcD4hffLARGPXVPqNjnTwzw/1lLSJ5oZzppkJxN8hRKU/ntFGvx1QLG3w6Ngd43A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674015; c=relaxed/simple;
	bh=i5lKCVpBgkW+EjEHCnrudVtNORK0TbgVaS/yQfJcQlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DENWHanHx2waBYKxxysym90ejjqmwUrWfDhHUlApMpuT87XmukhkG+w0nMYjji1oT8q6mobQdqhTIN68thGOzu7lipFEPjKBWA/AUJ96V6mDU71hDs3sJWsy77COnl7twVwRO++QE8QJ6QDXFYCNF2NFQGE2W924SFd9o8SzVVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Dsjaxpnb; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=cVpUlTYG; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58C5wnhA3620853;
	Fri, 12 Sep 2025 05:46:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=/ACbPdLEZtrT4gL5
	CWomjmiDDSvjy7952tNNMzbMW8c=; b=DsjaxpnbnIjcmYbyUwAfiC6/qxZdCHQy
	ED/siArVTN48ABMUGjKlvrLOO0NmOBHWTwIfsPcajjj7WLc3oSHj23nV5m50ZeQD
	SgVnZi3mKNPbudvs4khYukBoV5Ym4HunIxVJTEAf2nXyF6nGBFLvV1ijg1ugjaAS
	CLVwZpf7QfI+00YBkbC3gG1rvxKcQjzOEyR7TeQ1XjduJ52QmY7y+pwwgr5T5dDl
	t/BTVPg+zjm5ALta5eYaQFWJqaeQyKDNwzXs/bbO/K355rAABWb+ZCi1vBgiBW9F
	Dmf0vwFLha827JOPDpJRis4fGZD9sq/d6jJufkCDoCa0eh/UgAp5uw==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2118.outbound.protection.outlook.com [40.107.92.118])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 494due099p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 05:46:51 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmxQqiJwfq8u3W68w8KOlQRFFeBnKIeP4Z+yFUORzXsE7RsTls7yS9K/RxzXrmkVENFHnlqrOGkWmd/EOMAxup4nS62oJ1nXyGTyWJHFd5+xElemqnJ2yHdLM3+M9+cTAszhBpLSqxs09NHZBaYjE+mDRHjQKpyCPSlXAFmEk//TUhyEglAczzlNto4za2FVbbz+cFToTMQ12nkEyNWdBzXL8qyEtln9XDPBrn97zknHHWWf5xi4DZoipVPTPDCURFAcw8eRsswyLZvkafA+pmrNP4u/6EDs9i0bhAlXCntH0usHq4WMpCUAQVfZz05qogMjPDp7jHa/P8UNX0Mttw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ACbPdLEZtrT4gL5CWomjmiDDSvjy7952tNNMzbMW8c=;
 b=FbbS+x34iKcl9nnVOAiXEP4yZxzIo+YlX2TswTWEiS/BWTLSDq6fCUatjHehtM2Jcx14fZZSHYcixb7mzloUdozgPSzDDNDZOxB0llIu2ZWG8rnqjhRljV+lk+PD9LAF+A6GO4urmEpyXCPnSzhcwkimLa63iMLPvsbCyPePVDyTkcn8DhEBSJR5OWKeCHUtR4IWowhPAdBlSpF5q3wwTBOjthnbCv+a6JDUdPA++j3RQRY0+NnI+iDl4Kfart+tcg0ViCo5QH7F6LRJcXEDBxLXwBzf3bHe1nCgJ1aBjkxgVbWk1MP7UpDLo+DAZ68nQhcUMkHJMIp2lrPAwgowvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ACbPdLEZtrT4gL5CWomjmiDDSvjy7952tNNMzbMW8c=;
 b=cVpUlTYG/D/I0Tqj9/rpj3X91f8tjbLLuu0sVXlaRcVJA7gSr8O08GFDrbou5LsDBdxl+RxLjXjQ3odCmzpaEBziqGovCzepQ2HXdWCO2sW6fHe8y3FHtO5hpPtYVT09gK88keZcpee5iv7JnAlCKZ6awawVq7NAZQZa0qabWPE=
Received: from SA0PR11CA0200.namprd11.prod.outlook.com (2603:10b6:806:1bc::25)
 by SJ4PPFB04496E67.namprd19.prod.outlook.com (2603:10b6:a0f:fc02::a44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:46:48 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:1bc:cafe::5d) by SA0PR11CA0200.outlook.office365.com
 (2603:10b6:806:1bc::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Fri,
 12 Sep 2025 10:46:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Fri, 12 Sep 2025 10:46:46 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 5043B406540;
	Fri, 12 Sep 2025 10:46:45 +0000 (UTC)
Received: from lonswws02.ad.cirrus.com (lonswws02.ad.cirrus.com [198.90.188.42])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 019B682024A;
	Fri, 12 Sep 2025 10:46:44 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 0/2] Support reading Subsystem ID from Device Tree
Date: Fri, 12 Sep 2025 11:45:36 +0100
Message-ID: <20250912104612.361125-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|SJ4PPFB04496E67:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bd9b9ef0-fbda-47f6-52fc-08ddf1e9abf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?el9KdDm3LfUCWKlqSIHTu5UYUQro7ZMW+vlVFssumnFiSgW3/G6/XW41XrDp?=
 =?us-ascii?Q?VFgzS+ITujx+Dm18rfThMEOi5R/OvBjV+tKjwbAPfFrBtlsMUoT77nIiVHXh?=
 =?us-ascii?Q?4PHPtzM6QkY1LxSmrbZ5C1qLKKgXd3xaLwa130I7T4n4s1dg2B67aMNaF6RQ?=
 =?us-ascii?Q?+IMfmMH52Br4i4v+5oc+AOycrlc/6RA48goa42jIeuc57+6/VWMOXKUqGvZP?=
 =?us-ascii?Q?DPliNnNzaG+JZuw5blhbZZwLteGe4Zv9jLSiX9bY9uL3EFO68Ta8FaBvEWyz?=
 =?us-ascii?Q?oyqXgolTEYLUL35KpCkKiVLlKphFfUHwKqG0+bFaMa0mm3xit99vceueH75/?=
 =?us-ascii?Q?F/z+E397xtauYbppMpWmftBL0pjrjAKaCFYFP2u/ke/+Qp38wbBB7HhmI5DR?=
 =?us-ascii?Q?2u8JtX3qmo/GIGyDvApPEmX0oWxZOYYKNuMVfcPk4RD20MhS7nhZ+VUQ8UI4?=
 =?us-ascii?Q?EcNgw5PfUaofUzZSn154qCopFmKvS1zItthx35D+kONZPdVCf5mZdlxarSLE?=
 =?us-ascii?Q?dzybUAybEwWV5i9UgJdm9JLjHiJ7omjR3kTFu8HXPvyt1FTYIscn5WX1rGI6?=
 =?us-ascii?Q?kiHCKJ+86GC8kEtO5GwQrDzx1bDX778rqfBdisBSy8NjMLjPVaJgg8xgVQ5D?=
 =?us-ascii?Q?ezAJU6pXgwfhwufyjoaYJkBezqWRMt62SwCBKRAmSpenrBw6i1Va3zWD3l1c?=
 =?us-ascii?Q?mW2f8kx5FTIKJnDcQPFNvG1IgJloOH1hG6ZIWmqiF+otmzR72H2YgknLe7rE?=
 =?us-ascii?Q?QVqjQqKXXgXs2IWKMDrMS/wyHQfVCyD/MyJrnbFZ8K1pOmIHc2kLtjqbINx1?=
 =?us-ascii?Q?0Hoz/oXT+lJaUjHn/edLN4m1gTRWQG0cbB7MRJ7KeF8wy8rGHIBDfmFucCmk?=
 =?us-ascii?Q?r9zWqbvX4m3+nDcN/ttqWOXNWZ97S9L70BfOEn40mcBIOUZwQ8nZz3zSDUvG?=
 =?us-ascii?Q?xF5mTQHscYP1s3UFSGaqkjJnPBofCf9QdtdCMpWuSfeb4pzHsg781TsizW6w?=
 =?us-ascii?Q?LDPSjrbdADosq4ceqLOe+zpc+Jp3fali+lTfPOsBppGlmdqDucs5NjNX+/qY?=
 =?us-ascii?Q?9Q/0rrIXJTtwDwe0oX7g5GyA8VK2416vDnEXmGl6WPgHxFTY4UaZ+LOo0GGe?=
 =?us-ascii?Q?8fWHo0yxdmI6bVIss/TYlZrB/3P+YROB6xs11WIISoYfA1oGDL/JeSfib7fr?=
 =?us-ascii?Q?l+Bs6qkd/9ghg0HRnlLp/BdtNlxX8FMyhp45/xTlHW6Ep8p08mDAsgr05v27?=
 =?us-ascii?Q?0L3XLITz6k4IrqikhS+OyeDA6nD7uJOKCtGGHqcX7PfwfKCiCjWz9JOB0pHt?=
 =?us-ascii?Q?4SFVoJ0oS3mK97E5KQlDrqb+Iw3Pu5SxPTDlMZRCQ5XeOt7bWLaHr2c/i47f?=
 =?us-ascii?Q?yrBA2t/K11TCTh3iyBNKmjBEwVRItDKajcEwEoBVTvNaiNoyGj3PZfuCZbwv?=
 =?us-ascii?Q?KOUKdKYg/rRjM9wWBUIMzari3ZH2Wa5nN408UEqj9rk1OqdTy8Nucr1uNcTn?=
 =?us-ascii?Q?v3DCQ9ZGmlo7H+DyoxT5CIhGJQ1v+0KKPJEr?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:46:46.8601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9b9ef0-fbda-47f6-52fc-08ddf1e9abf8
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPFB04496E67
X-Proofpoint-ORIG-GUID: 8abT1ZhkD4Dow2qy1wpEwfeu1E2UOchA
X-Authority-Analysis: v=2.4 cv=F9NXdrhN c=1 sm=1 tr=0 ts=68c3fa1b cx=c_pps
 a=pkoRu+o/X5P/V2ORyTBuqQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=RWc_ulEos4gA:10 a=4cEVVl_1FvM9a3rzOFQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEyMDEwMCBTYWx0ZWRfX7By5E/xHuBoa
 4SCHUQSenPYqt0dWAYMF2Dh2gxcN+b8hljniVPVyAJNr7+EXHOMDx5+vp7Uh85WmFLMlrb5pGeJ
 NEaL4AUsTsE2iZ2sRJ8juHwGfeoYO/WHFMPFivaeT+w5j9hvR6JIzcXaWtRtuDfbFODx6u8wcj2
 BT75PiZkunLGlv7aDAEhi0M7/ozTxckEOlvlOiSTdRMtXccZkCl4KZasEZzgk6f0ko5njY0jBij
 y2XgC4gLGjxKwdbsr4vZzrlLIVNgl6yqxOrk6JMf49Hoo/vBg9fRUIy5WlAjqNn/X0ljabRQhFn
 etoQ1yptoCjOfChesf6RT9Kbi0aJqrPElSWk+U1apDakffbmUsEcrsSz3HlchM=
X-Proofpoint-GUID: 8abT1ZhkD4Dow2qy1wpEwfeu1E2UOchA
X-Proofpoint-Spam-Reason: safe

In PC systems using ACPI, the driver is able to read back an SSID from
the _SUB property. This SSID uniquely identifies the system, which
enables the driver to read the correct firmware and tuning for that
system from linux-firmware. Currently there is no way of reading this
property from device tree. Add an equivalent property in device tree
to perform the same role.

Stefan Binding (2):
  ASoC: dt-bindings: cirrus,cs35l41: Document the cirrus,subsystem-id
    property
  ASoC: cs35l41: Fallback to reading Subsystem ID property if not ACPI

 .../bindings/sound/cirrus,cs35l41.yaml        |  6 ++
 sound/soc/codecs/cs35l41.c                    | 77 +++++++++++--------
 2 files changed, 50 insertions(+), 33 deletions(-)

-- 
2.43.0


