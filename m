Return-Path: <linux-kernel+bounces-814436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0DDB55414
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F977AE4F10
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A872E30DD12;
	Fri, 12 Sep 2025 15:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="q6xrXusO";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="qYvfYN4e"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF98242D9E;
	Fri, 12 Sep 2025 15:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692113; cv=fail; b=N2o6o2uXjVO80s9l9TKX675UpA4e+dy7VDHJGxZF9h17rdMjab5NOxAzAgVWXUHw5JLmuR/W44avDYF7oGWpFWBELlMVSZcYVmhSUqKVTkjW+/1vXbxxb+u/IZxDnGXpIhejLJzrTuwhGekvuNeJA7D2LYY+DFjwHwj8tGuVy0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692113; c=relaxed/simple;
	bh=Zb6dAEJbCZ+rzk8YRzlYeFF37trGOxQEIfm82Ab5fyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O6xKciuZnnY4Im2G65xCVenWIdTzkDEe7t3/k8IXgGXRS/PNLFWhMXcZRYklwqBMjaQPWTKhcer5nJIGN1r6XajSRFVEHMw0y3dx2jH2Y+EmKwllEnNbzY1nXntA/aHpZzsLZyqYUA0GPlbvKdbqooYkS6zC0vSYX80FyaAGhYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=q6xrXusO; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=qYvfYN4e; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58C7QE8c3763904;
	Fri, 12 Sep 2025 10:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=w59MPa5xG0PwrCuY
	RezrRepCTa6DLnc//cxM0T28IOo=; b=q6xrXusOc6DKLL7PPHHB+ZK4NKcNLFkA
	WX6Qr+FOYv2RCTsHp8l3qqOnl44FnQnjCVheKkrttZALjZjb+JGcVBZnmI3gRsRl
	ktnnA5f8HZ4/pDcusR2yqzW8qrDO6rNvWHc3tGXTl2jVcoDqA+YGt6X83WqrBSay
	QDwDrH1Q1kLLg1Z8qtQUwCkBqylODfFv9LUoCJHMmYcnkqH+TaelUQ36P4BCHzYo
	SghOS65ZocTs4i7wZ/tRQ8j4ya5cSJZVkcXRliSp+/5P6bMhCjNbFoKvOq+NP9PG
	EBuETNmHOmgEE7WzaAdzM4kaDrw8LNpRIpKcYtPAWOqOCni9+2j/CA==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2137.outbound.protection.outlook.com [40.107.220.137])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 494due0qxu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 10:48:16 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJMdgvFe7u5T/JfAwP5mw8G0mKfH1J0zsNDklrLDOOaP7VvD+XdrGu6gJRNO+Y9PmNl0UzhbU8Fv/eMDPQcC4aCwuubfQYgkMV87JVY98Ub1WgLQlnHg3YF8/ByqOBV3a3e2roFAh2R6/s23tmjGualdtbHldZxNmG7F3kW58bpau/ntDlWuqNa8XXwbDdGlA8RI/WAyM0eRGHrJWoAdGk7hUHekymy9iLvwu7FgRAH9svMxiI0wc4as52HRQtS1q5JTiojtGEjunA8bjxnv311H5Jadc/vn3QtZlrcGV4aEMoCw/XT4WdbiZVo254HX/Pxe6q0wREkqhS+itFt2VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w59MPa5xG0PwrCuYRezrRepCTa6DLnc//cxM0T28IOo=;
 b=uB1gDBElDRkdDWvr1qAvQpRR0t+zks1EI1C2X/YtbkbGCETujs/yDhhgd9DL9gJyOw1wZAsl84jg7/MHZz+23tTeDquV5/zY6WTgpNGdrGwHgabGTsMHZwMgdT6brg3FhYqxa2t+9WvCJLWlglM+4TbBewLgz7vPaV+3hFXJo9wY2lCSyZ7OXOg0w7vsLW6B7+OjEATv0Z5BnyvgcSnZpYwWHgRSwyYUv4v/PQF09PnFznF8iVw978BD9YDtek++9R44o5VSEICaxG6U+eWc1X3705jn1knknuzdVdKtK3RZd2Au6cAKVkAXTxNWHFYEpELD4j8kKCK1eD7er6+yqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w59MPa5xG0PwrCuYRezrRepCTa6DLnc//cxM0T28IOo=;
 b=qYvfYN4eziJ/js5YstXJDgAdOI7EvTt5X6Yh8MRGtVT7tJK1hXV8uMgGsQIq3FhpIIBdz4ApFjpldtsrQqVW7TDIaTPcD8wMXDhSdOqrzQEhiv1vOvsAYxljSJu1Wkj2iNfmd6NPDQM1Nr6+FGiDnMawFiNsh7de/bWDOigSd+E=
Received: from MW4PR04CA0296.namprd04.prod.outlook.com (2603:10b6:303:89::31)
 by SA1PR19MB5120.namprd19.prod.outlook.com (2603:10b6:806:1a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 15:48:12 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:303:89:cafe::57) by MW4PR04CA0296.outlook.office365.com
 (2603:10b6:303:89::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Fri,
 12 Sep 2025 15:48:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Fri, 12 Sep 2025 15:48:10 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 822DE406540;
	Fri, 12 Sep 2025 15:48:09 +0000 (UTC)
Received: from lonswws02.ad.cirrus.com (lonswws02.ad.cirrus.com [198.90.188.42])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 3694D82024A;
	Fri, 12 Sep 2025 15:48:09 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 0/2] Support reading Subsystem ID from Device Tree
Date: Fri, 12 Sep 2025 16:47:43 +0100
Message-ID: <20250912154759.279661-1-sbinding@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|SA1PR19MB5120:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 19ad1ff9-b6c6-41c4-6dd9-08ddf213c6f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MKkfnGzm7IQakvDkY4Ebcz4X74Wl1LJHZOf+rJ6LmgNqKQb3SZdRGyrjxlNX?=
 =?us-ascii?Q?6S17hOPOR1Zph1ZOnxjq3ejda4dh8dkiEDc1JcYyNt5TgnpXAnOkbvio+21B?=
 =?us-ascii?Q?GRtGPP4ZQUZHy20TAsJQMrk7DER4xRX+4m7K+QWHVblwN6ZcWiHwuOXMBevI?=
 =?us-ascii?Q?bBbNbA7OTS8o0TNRyJ3YZVJkARInBtJKSWJf7mxmdUolO8DSI2EHjRdUKNm3?=
 =?us-ascii?Q?JvRtLkTE0Ygvjk+0Xt+C2oHMqLjfu1xRRgBcUOf0jXkxfW+cuhBg6qlzgXUe?=
 =?us-ascii?Q?+TJ6QIgeXcisHG17ybLDgggAp/UE0Dv0vr+QN0kiqbyF+IHHrHlYm5VusYjM?=
 =?us-ascii?Q?48vDz4TjkPBsFNzERDxohV32qoztyaH5v8EjVkQEr00xZNkkCuYJ3wO+F/nu?=
 =?us-ascii?Q?o4/DvVynB/mFjEIh5KG0k2vZojaFkaIAgMw6pxB4C9YOzuRzT2cZWBxVB/yv?=
 =?us-ascii?Q?Kb9ETyHhB4l3DcnPxfn0G5rM+8ZnwF4PWev3gHz2BU2lxEsD2fPwZj7QRhFK?=
 =?us-ascii?Q?/mVw9TAljSjV+EnZzxA/QZnIedBdpUQQ+05EqqYV7ZjDg0VUwdZroE2dgaR/?=
 =?us-ascii?Q?aRMVH92VQfLiQoROPJ+VTegWcr4yuJ/y7rnIjT9hMpAqsskN+VgUyne3Xqav?=
 =?us-ascii?Q?+u2smObXWZWVy6EiiwJ09lrgKS6VTtYTGIcvH84m2MkG5guGThgmmXvJnHfk?=
 =?us-ascii?Q?iUCUwPSlpFiIaOfzmFAXumJvYB4OGUwMq3iwXiIu4u1L7uyHuKvhzgEF/Ab+?=
 =?us-ascii?Q?3R/7dZyDNZPQa5aGYotO9V0fb1aZx36NhPUapJAOgxYPbBJMsOXKnXMNjTtD?=
 =?us-ascii?Q?f7eVRTUa8q59awbNzCoTjwX+pGmWvmkOBXhbUo/7Q3gfHI+HzbqPFmbjhQrU?=
 =?us-ascii?Q?KA1UF+p4DpszL/MxYNq61I41r2wSzYPGiqS4Y++I81tUgYxPIuwJSpECTXNY?=
 =?us-ascii?Q?i+WPiDinEB0LpCFFVdExKelVOh8MZOB5DXjwP0pwwNsIGKaoByuxD35TwPjX?=
 =?us-ascii?Q?n4tv7IQvtHK9TtpCCfFQf7B7ENh64pLZ7bfjoX71ECF5Mp+9FDJWPdAh9zYk?=
 =?us-ascii?Q?UdxKeLZ0A2/iC0/NugmG8VXZMoUJdP9mVu/WHDIOblncAY+lOGMjU7N9iXey?=
 =?us-ascii?Q?SElv4jNnckHeZ6+IzPYIPsWoGGsMi8YqbRwN10iPwfFRG/OCdb4elCVH88VL?=
 =?us-ascii?Q?3GPmeuC0Xev1+oSDFhMih2z2f50afLWR/KdhCQ7KRntaubg844NjDwJ5fJQe?=
 =?us-ascii?Q?DgyFCsctSxrvkisyW+IdQgUzRsDzfKAfAVoOmmNum1xDaF16oxJ03EgBKy1o?=
 =?us-ascii?Q?X1C7v9Cfeg0oF3TGVyoOSexs5gQ7qln5FhDYfPxhWWVduGk/QycKrgOCtFwk?=
 =?us-ascii?Q?3NcYDVNNGCn/Oky8z76X45ssxTY8hmLpqONO6RZxdYfMv1AME7Br7cr7jCdO?=
 =?us-ascii?Q?rp4DfEFeSMqWHQDfDt7BsQk7z+FrJt1nlYbAurm2heKGefAS309TeNBDiJgr?=
 =?us-ascii?Q?Yih2jkeOecgnp1nP4kRhVaXW9l6a772VsmQq?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 15:48:10.9143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ad1ff9-b6c6-41c4-6dd9-08ddf213c6f0
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB5120
X-Proofpoint-ORIG-GUID: qS5yngbRqDjWRoqN0mSyIujRQ1ONikio
X-Authority-Analysis: v=2.4 cv=F9NXdrhN c=1 sm=1 tr=0 ts=68c440c1 cx=c_pps
 a=uhh9Xr6CjD6FiqEknFfS7A==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=4cEVVl_1FvM9a3rzOFQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEyMDE0NyBTYWx0ZWRfX52E0m/9Vc30a
 UqgmhYJkQ5Iwt8JkKGAMCHf2q+3buBGkQr7uheacclS/JjORwUBWEY6TtcPSqUCwDWXE/FuH1cT
 vfNHl4kVjQRBYQrHdNPZE2GXCida+HJWkejsTFA8XwAgWjRMqh6TGPwKHe286/r9+vHwu/zseOn
 dj1PV93JYgdrE/+adrC0wy3wQat+c9pab0BZSpUZ7B4CjTKvH0cgy1Ob+xgiiNPlANqNa+GX/yq
 apmlI44rCHLsT6i1KsbGSrwAI3YmfQcv8tNrQcAAPk/skU5MsCx7bEx6scUlke6NFmlYmfa9EzY
 3NVkKdaMsPC/xvgHaXDroNOkD47aByS+7swbxQbGxg7v66tzT8fBylUa8CdwPE=
X-Proofpoint-GUID: qS5yngbRqDjWRoqN0mSyIujRQ1ONikio
X-Proofpoint-Spam-Reason: safe

In PC systems using ACPI, the driver is able to read back an SSID from
the _SUB property. This SSID uniquely identifies the system, which
enables the driver to read the correct firmware and tuning for that
system from linux-firmware. Currently there is no way of reading this
property from device tree. Add an equivalent property in device tree
to perform the same role.

Changes since v1:
- Fixed device tree property type

Stefan Binding (2):
  ASoC: dt-bindings: cirrus,cs35l41: Document the cirrus,subsystem-id
    property
  ASoC: cs35l41: Fallback to reading Subsystem ID property if not ACPI

 .../bindings/sound/cirrus,cs35l41.yaml        |  6 ++
 sound/soc/codecs/cs35l41.c                    | 77 +++++++++++--------
 2 files changed, 50 insertions(+), 33 deletions(-)

-- 
2.43.0


