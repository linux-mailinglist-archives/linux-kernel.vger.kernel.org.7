Return-Path: <linux-kernel+bounces-854195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 013E9BDDCCC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F0F1349CFC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A67D306D37;
	Wed, 15 Oct 2025 09:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="nk+YJs8d";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="FycW87iX"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E722031770B;
	Wed, 15 Oct 2025 09:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760520778; cv=fail; b=UAUExbITSQISEZZpsgy+AcWLkzBALvxMPaPy+8PathRMYKbfot+uwBr5ecfc0Q6LMZ+kzFZkoRi5ksBop4mV8IkjNiRHvqEAVw4vgIDpvKS3DKiCiO2yaAj+/TEaeMV914AC7NRFM0vCDtWSfExlkUebnZFU/6udLi1jfeKp9QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760520778; c=relaxed/simple;
	bh=3bqqXSlPV4Z1Le3Gb9M2tZ2EM5qKjvtETzfHKaM1nsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6jwXsczzHkVr0SzQjoJdHPDQawpzX1n9J0B5Mdyrpg1AgiS3rG7WFzdHr9ihFXFXMrgumjr+i62zHTPStc3MhVh+2bpuUV5OFwVMgFRd4Bm8/XYZcjkqU/GdGj2hqMOfjB/x55we8zu3PVU91hb52YIuQO28zKdUAY2/JwmIi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=nk+YJs8d; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=FycW87iX; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59EGZnd21728970;
	Wed, 15 Oct 2025 04:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=Uc7ajakXyNroJpQi3d2N4nzqTHY1rCNRS4HAzVuUyuk=; b=
	nk+YJs8dFxc9p5Q863k75bBgrx4PotKPVYamyunvibj50kaux1eXTDCfeQyIHXqI
	oVVxV2jxYH0eVkLs0E685W6Pjpx3QrKWsB1j/E9M9TMsJnSH46IiycGDREHqWFNV
	5XFQOS4voC8ukQPx5FRrjZiL89wKlwG03uyQjnd7cixcj7Uy5fGIFyMQ+9ywDKc4
	Vu4cBXUJjRflJnNHBVjsHJyg+oeANdXwbkHYWs3njnSiVSQp7LQCoZlIjNmigsDj
	1+SuSLgbMNwhbxVzut6wbgg0UGKQxSTiE6cgZXrqJERHLl/BHAZCVwmQQ6h4DV1l
	3iga5VA/kizKOnFvV0sfRg==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11020098.outbound.protection.outlook.com [52.101.85.98])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49sdb42g34-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 04:32:48 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwqdnVOw2yT0B86YEujEtIOvrDuo8r6hgo4R0ZifM99Iw71WxqpETSKCQ5z8FB0htZhurmP5JzB1jqaEtrwQz/xUMQeGZckRiFyjYDqUQRYOGxV34stBWDnPk5UoeR6PXDIXD2jXbdODXThgbjinVfY2PrTa8llDt7Q+K0sI5mKg0sokTuWgVzjUr+muG5t+cuVEH11JsZdbJOuWa0DcGjwbfnCOYLgozWnJCVdvS8lJEAgXpqds7Z87ZcM4JLjJQhynHlR/+LjCazGbZs2KqaJLDha3KlT/QQO27jyeEly2hKJoXSL/GXBrvEEBEN6ngkGxXbXwgg+0HIYp619N7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uc7ajakXyNroJpQi3d2N4nzqTHY1rCNRS4HAzVuUyuk=;
 b=hUTr79Pa7fikvrt0DoEjsDMR+qs2XqaKGfPm03ttobGx9xiWGhWsf0ohMgTN5RFOIC7WCBkQq7V1COrrwbn+7Jn+1Z28iVpdBe6Ew8Q0l/9xChO9GH/VTWZnTbzqp1UzFO0RJEhi4z7Uh8WM4bHfWM2ELFyjoJCW0Ph+vr0luflfUmGeCkgDuDhrkouwTRbcwDZmLTSPitkXs0ioriEDSePqDtr6L7pNgm/h+cLcNRaTdrKI5T6XnPpZWF9E8FyIkYrqRageWTUFgmVQRBE+dYUHnv11Jev++Z3Zj3dtlxGkynVwcf7mAGu+aCtN3KYbXVcU6kgn8mmABw27GdT2ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uc7ajakXyNroJpQi3d2N4nzqTHY1rCNRS4HAzVuUyuk=;
 b=FycW87iXVh+5MkZ8wvCmzAyM6Tv57wrzD74XdOUCnt5DXL9ufhNHrCLMaszROrhy/F0DwVIJvXiCZEejvWOFIrWkwzMwDUirPd9oNDgFFElIneloooiwsWfbFUxbJfVzvXkQgEDU+OR/7+xpEhwFqPuNAahtpcuQ/y1lcdoJpOg=
Received: from MN2PR01CA0059.prod.exchangelabs.com (2603:10b6:208:23f::28) by
 SA1PR19MB5200.namprd19.prod.outlook.com (2603:10b6:806:1a5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.10; Wed, 15 Oct 2025 09:26:42 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:23f:cafe::7c) by MN2PR01CA0059.outlook.office365.com
 (2603:10b6:208:23f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Wed,
 15 Oct 2025 09:27:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.0
 via Frontend Transport; Wed, 15 Oct 2025 09:26:41 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id B7CF3406559;
	Wed, 15 Oct 2025 09:26:40 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 7440C822541;
	Wed, 15 Oct 2025 09:26:40 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH 8/8] ASoC: cs530x: Add DT compartible strings
Date: Wed, 15 Oct 2025 10:26:11 +0100
Message-ID: <20251015092619.52952-9-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015092619.52952-1-vitalyr@opensource.cirrus.com>
References: <20251015092619.52952-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|SA1PR19MB5200:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 88582409-9adb-45aa-10fd-08de0bccf364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/yDkgzDHROi8y4TxCDw5Z90SqwHxFBiLK1Hx6OhcNlLalIybDDJF3OrjRKGd?=
 =?us-ascii?Q?9lwexRLkjVR+NboExN55xmPRvwdbQ7FEDtsWYSIz5jmgRbO1GjJFtAdeJAry?=
 =?us-ascii?Q?nxNq9UPmr+k6PhO6PTWCn2g4cFlRZMkBkjiwX/NpN6iDkXU4NrPVZjrfd729?=
 =?us-ascii?Q?JXXRDfYsYAu7unaiqfTrxD1CLRZ5ZQypw8a/vsP+fwhlGvGIVk9O65Usg76r?=
 =?us-ascii?Q?gSdGAaLkobA6Ry9XLmL/SG8ysbvqGRHR9o4maSLUXFz+x3L6acNXJTWHIf7L?=
 =?us-ascii?Q?2evTNnbbgn/AbXTVsU6ZCW1xV848myzN/CiUABe+sxBuK4DD4P7EYBNczIiK?=
 =?us-ascii?Q?H1ZkrDI+uTWXOXaIsKeWCJMwLngQllsd7vzGz1QfmQXqj92Coj1b7n0KExp/?=
 =?us-ascii?Q?gpzAz/UFbZ/htvy1SfwX4AuYyfTe6m+LHZEMwNB6XtO+Kkfn7XgOSD8Q70fU?=
 =?us-ascii?Q?bwGW4Ccg2uVnjcC04PVeosBSJlwlfwzTHdNxO47XyVXldXkhW6ONX4g5z0Gn?=
 =?us-ascii?Q?LvP9hICKVga/ptbv0YOxC2Qi2X1PeF2jj1CqEnR3k7pLZnA+WnUfEFK36oPw?=
 =?us-ascii?Q?hGhBq2ICeNylvEJmDYcF7p2zFbARy4DjzfPy6yWIvDQLhDYjeqDKLDztB6W8?=
 =?us-ascii?Q?UU0XqOA9I5MD4RBANtX+25ZntacUNoqU+J/ce8Q7TxIImK4RjPYebrsN2iiV?=
 =?us-ascii?Q?ki64WlkM19dNQf1B8OoAlHK/q/J66+nIpFZDhxTIo2Gp2HXY7wI+/NmkkBLe?=
 =?us-ascii?Q?Iv05ki/CTsSuIssc0zLj9B74SMfUovyt5Xmvk1zPUyBaGomYbKy0F0xg3pcA?=
 =?us-ascii?Q?M2nGk/k9vdL0aJPksJJU9jMynn3lFAeEpJFBiwUPa4iwtqU+JWmJJyWHI0dT?=
 =?us-ascii?Q?wJ6ykueCPZ3u5P7rbvpwY6jEJPwplEamC05na73mBfZHx1HNtqA5LF/iS5mg?=
 =?us-ascii?Q?VP7Pqd1uvSva3zBFG6SLD5gn06mqHmtb7alQKdHRBm2QBipDjmFUkDzEbYpu?=
 =?us-ascii?Q?vHt7DUhV+Rhw9dApSG06chs4dF0TW5Jwgpiz2DTWQCj03BjJMfAvq9lR8F1k?=
 =?us-ascii?Q?Lw8ErALwWqgSzIBYLcrYe3JqPKYlyHVJXye3N6gaCiwu8Neu9S+JEO079b4O?=
 =?us-ascii?Q?JNG6gqJjfhiFR9GU2pdzZzU85Vcbf2pA7W4iDlL9RhWzVOzLf2yopvgWoIQv?=
 =?us-ascii?Q?G4pNL68iU0zTuS7sZNzePSqA2dWzYb6uxyjhgwjMdRXKYFJLbVo7H/3TB4zw?=
 =?us-ascii?Q?N6Tkswbkn1DWekKye9CniixDk4CemyERgq64ssNAJLh2tv/iXqauKIZyD5O6?=
 =?us-ascii?Q?OwY81PY6RlGqiJ3SQ0zoJTjBATwgY2jM28S7Y5sr9BmTYA2SysW4oGEcxtkI?=
 =?us-ascii?Q?tqeevZsi3PipGFTQEfGRZPn6IFe5DTi6S2Sbyk7HncbI1QFacC5FlPVTdTAZ?=
 =?us-ascii?Q?pkYC8asF76TSuzm8gEg0yXu9BAlIIChl6U0ENgWRNI6AHfiDOpN/+UVecl6F?=
 =?us-ascii?Q?sLy2C46FqK0E6rNEiZFWLPWwg8fX6FeCJdqfiO+VJj1aQxaHAmvP4Y1jPTOD?=
 =?us-ascii?Q?Eu8ajALSqHk9C5SWcuo=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 09:26:41.5707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88582409-9adb-45aa-10fd-08de0bccf364
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB5200
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE1MDA3MyBTYWx0ZWRfXyJBpWwqY+arl
 B0KHX8WQ1HoVg1+xczEn88rEb5Rf5nfa5gWD4gumT+wuVy7vLiBe0IV0+ezcpZ/uG39KB99sGUL
 GQEcLmXO75oZ66CqpofKDr8WPT/Rrdul0yZPQGHQa6x9EyZ/SqCQFPnaVxyKpu7Gc7RUiSEEcgv
 R8IzBjQvxtO0lUZz3pmbSJDKPbQYffEt+ApH/UgX4Z+RrzxmV3FVtysSn0cxRBe4AaLUZ/sTqcb
 BKr+YAIIU2Z87yh2kRNW1lK1cTbzZdrg2Ze2TbFZ43yaTZcWq07jLA5EoPlSAxAiZcv4NJspCJf
 ZGkKYZu2EouGPamW7zjSSukajB4/gas1qahfQU9YAJIGQh7LXB1mytXBmXuCn+3FwousokWb3UL
 kFErqf8mzACVY3qThBsh8fWBNnbimQ==
X-Proofpoint-GUID: 3e-UJhRLkahHpWwwHrmsUAz5lzHfjysb
X-Authority-Analysis: v=2.4 cv=PPICOPqC c=1 sm=1 tr=0 ts=68ef6a40 cx=c_pps
 a=5ZmoExZQM1RqZyAr9AiZEw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=EIw7sTYcH-EARjFZPrAA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 3e-UJhRLkahHpWwwHrmsUAz5lzHfjysb
X-Proofpoint-Spam-Reason: safe

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml
index 9582eb8eb418..90a5cea0632d 100644
--- a/Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml
@@ -22,6 +22,10 @@ properties:
       - cirrus,cs5302
       - cirrus,cs5304
       - cirrus,cs5308
+      - cirrus,cs4282
+      - cirrus,cs4302
+      - cirrus,cs4304
+      - cirrus,cs4308
 
   reg:
     maxItems: 1
-- 
2.43.0


