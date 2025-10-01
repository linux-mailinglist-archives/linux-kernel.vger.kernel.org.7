Return-Path: <linux-kernel+bounces-839679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAF8BB223B
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 02:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF9642271F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 00:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C2133987;
	Thu,  2 Oct 2025 00:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="lq+vX2/J";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="CL/sno8G"
Received: from mx0a-00273201.pphosted.com (mx0a-00273201.pphosted.com [208.84.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC27B640
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 00:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759364626; cv=fail; b=RZMoXaN6P5PmKEwMaZ7pEBTr14/vuDiJgyNpqc3purIqEQXvMfzYoIXPzqiZLf0sR/c6BYv+tWOTEfaACW8CxxIEQbGX8fF3W0qCbnIIxudff/IWrWDKfLT/4o7krQuv45aTzKdjvF4G16Wi/LMZYAbNldk7Tkv63igyCgdn+QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759364626; c=relaxed/simple;
	bh=nADzaotJWaNNfDZVMVlyOtjuQEpA8icnfVSV6V3+3SA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l8aQ/5+IvSKaZ1WSO1F7tbBVvox+lwDiLTO/aVwlmvFPMkGdwfkhTLSkJjVPdvNyYxB4MIw3ZawHmZtANz2sZvpXMpn6/IM4JNKB15bqP+HcMWHM76fOQkTanY/0yAK0L0rIPhmy9NsCcCg+M2GSmcNigBMdT7rEX/8EzhZNM68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=lq+vX2/J; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=CL/sno8G reason="key not found in DNS"; arc=fail smtp.client-ip=208.84.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108156.ppops.net [127.0.0.1])
	by mx0a-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591L1uER000656;
	Wed, 1 Oct 2025 16:05:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS1017; bh=Q4MrFdRTm3nbJhef6aEHevkI
	9Lrn3SIiHdCrvWp/Pko=; b=lq+vX2/JgLDuHh0R+39A6rUJE1lw/SCQeCSLAsbs
	8AbO3dfsSEYJbkZsj7c3kFkKkzovf7ag7DekfIeSctCRW63lCFXIzyuiM3EoqysH
	xkyt5bnexe/hfdcvuAUeXocjZmQn9kkatGWZOWRAmO8IPi4gU3MZVHXmM7hobj3N
	kFMElonBBk2P9oTpX4zMLxZgQmEXXE27tIF5XwK3vi4mqpNPkYbAe7L4NQFmeN5b
	rqfQq8ae4KJxBo8HOd+H+3yijl+k24RAscxHP8s1N3B4mnQlHa+SNucKTg7SQroA
	nmku6EauyFDjYOmDe8vo4lOKEBjFkNxk9NQR7cvEsiyrNQ==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
	by mx0a-00273201.pphosted.com (PPS) with ESMTPS id 49gp4rtuvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 16:04:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osCWKg9FIqvoQ2YYiCkFGkeemub5GvAJQhT0YWV6vCU2b0LMmMX180uZrO5q8jcm6m+flBBadu0uk04Dzur4svCtWMlAJIU/Recx0Fp0Tp01soL1iX0VXlBjabyPLgH6hhfURJjv5mzgIiEmLBX9g9h9EzIvNOnNvKGS/YOHmqw5Jq7m/sQYU9gOq1ooLi8U0Tjv87DcFPMI2jOnH5Ijaw9J1qrB/kLhDwiQE8OMoMhM8rnbgJwNg3uWW1//evJ1embB+WlBLdXGXFxUDnTDauAc7IVdVjdOuBMGwZwMo3WAZoZspilwqzNblD8qD2mQdhG+B3WrrGFsV3xjIXSr8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4MrFdRTm3nbJhef6aEHevkI9Lrn3SIiHdCrvWp/Pko=;
 b=LCd58jpcBza8QmMmVMNXNxobD1fwUVzgTbdPieK8gEcmZVZsfr7G7wnHabEXuMOm83k79G9wTz7tHVwCCMHpjau0+VV7zfB7h8ih2UU2bu/cnzpHWxCQG8yL2vvHjdHQh/92BWP9E93XnBURSDw0d3piDjeFq8dUX+0FkbkFIC7Jdt1gydA2XaCsXKa+wXI+VUmdjPUuQJxNLdtlUOQl8k6KfTFnVMUeQLrSExurfesOTqFWDtoMUX49HIqgSanOIUfR6M1UxcIdVcvkg5RSo79sur/Tj6h3LUWmgkpijY2s2dd2VBtR0rTFQgS7VdDv1PD2wS8hpzj3//SrBInEdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 66.129.239.14) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=juniper.net; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=juniper.net; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4MrFdRTm3nbJhef6aEHevkI9Lrn3SIiHdCrvWp/Pko=;
 b=CL/sno8GGxkgKNHemqjd9beuqcA6PzY3zVNzBQ5vAEANpWRtdmsINGSUubrnhKsYeJgHEop83Eu76mn/hBNPnTWSm9HRVOScJMBwp6O27IUrHzBZeOhE77O5hDrHdhxQHAFhNRhNy41CTJvuj9dNx4fc1CxTPUvXJ+IR0Ky3Z98=
Received: from MN2PR12CA0003.namprd12.prod.outlook.com (2603:10b6:208:a8::16)
 by DS7PR05MB11182.namprd05.prod.outlook.com (2603:10b6:8:268::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 23:04:58 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:a8:cafe::91) by MN2PR12CA0003.outlook.office365.com
 (2603:10b6:208:a8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Wed,
 1 Oct 2025 23:04:58 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 66.129.239.14) smtp.mailfrom=juniper.net; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=juniper.net;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 juniper.net discourages use of 66.129.239.14 as permitted sender)
Received: from p-exchfe-eqx-01.jnpr.net (66.129.239.14) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 23:04:57 +0000
Received: from p-exchbe-eqx-01.jnpr.net (10.104.9.14) by
 p-exchfe-eqx-01.jnpr.net (10.104.9.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 1 Oct 2025 18:04:57 -0500
Received: from p-mailhub01.juniper.net (10.104.20.6) by
 p-exchbe-eqx-01.jnpr.net (10.104.9.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 1 Oct 2025 18:04:56 -0500
Received: from buildcontainer.juniper.net (qnc-bas-srv120c.juniper.net [10.46.0.14])
	by p-mailhub01.juniper.net (8.14.4/8.11.3) with ESMTP id 591N4s8b022695;
	Wed, 1 Oct 2025 16:04:54 -0700
	(envelope-from makb@juniper.net)
From: Brian Mak <makb@juniper.net>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Brian Mak <makb@juniper.net>
Subject: [PATCH RESEND] x86/boot: Add option to append to the cmdline
Date: Wed, 1 Oct 2025 16:04:08 -0700
Message-ID: <20251001230408.13137-1-makb@juniper.net>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|DS7PR05MB11182:EE_
X-MS-Office365-Filtering-Correlation-Id: e50dcd7b-016a-41a5-4542-08de013ef14a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SF+6Ca9CK+qEQWIxYsV3ihhI/cxl14/2HvzqCtCbNprPP1K1kgDs0887MqZa?=
 =?us-ascii?Q?Odn5Ymce9r7MjmWpNXlELO49AqJjP9VkYzFkesUBvuGcMfNhfi0jRxGYyCRM?=
 =?us-ascii?Q?D6lVzTGyRK84pd/7DqmndJZIw2e41o3yOTfGremLXHCGXtzW5Y0LoGF5GkVh?=
 =?us-ascii?Q?CaVJ+I4OC96FkYRCeIkBzjlolOfENNOjUoLMAWrPplNoHEuu2IxxttQcB09B?=
 =?us-ascii?Q?+4KxnYtWG2X5iNR8yTcTYc6YWmn/+tCHyLuFzRtEgt9+jTylPR/al0O1pHBY?=
 =?us-ascii?Q?Vd5CDeRWggBLzX0HQxHV20ahERXhkScHBzj4yNYrMezo9v19fRL6tNcxGj41?=
 =?us-ascii?Q?78ggPAJXLGOLaAVKlZdWsiswtAVmU4vnlBc7GtaflUZVTtz/oGvtCj8+jSLW?=
 =?us-ascii?Q?gj6UqUNpgIkGn3lVuFy0ugMGgKO+rVZOpFo4BGE1VeCoZU+lrOEOXP6n4I0h?=
 =?us-ascii?Q?yHA1BehC2tUEsXmATtoQ/AXPitEU8Ga0xCUnxZQX4vJxRTN5Q5G0hnKRVxOb?=
 =?us-ascii?Q?6zlnVGTvlW584ipVQ6JZl2nxyk7b87epSU7cS4rrBZsDfNyOYmsEVBm5+H+8?=
 =?us-ascii?Q?1Na2ryqz9mniXIOODveP2mB09kWrMNg48ZY9teHz11nubB+/wmm/+le9Bln5?=
 =?us-ascii?Q?y3BsB/Wz2yHoIgcM0p+7oxVS/5NXs9InsHJSEYIOeH59RfkNGmhrgb/0dbbY?=
 =?us-ascii?Q?EK6L9EpToPyr7ziOXsdunvWDpbu1vPJj55pym59NyHZuxjYmB/kzGPhLV6u4?=
 =?us-ascii?Q?ez5BoQAEo/ctOMKfZfo5uzHlso7GVbcpLs+mkgUHsdgQmIBuvnRE0vsGe9gc?=
 =?us-ascii?Q?IzQF6sQQMIUd6zInI0nggJ49qjFz93+oufHt4eG+71udS/7j1aQCDo5vvYTU?=
 =?us-ascii?Q?v7B57j+uiR5U1NhX6PL8yM7ETa+v+6F0TXUJBGURiCA727dbaUZsKiFgbSLZ?=
 =?us-ascii?Q?2j3rhoj1p9pVlSF71OqcsEuItEiZeYJ5Ua6EqaEP1p1N+zLDH1XmiLHpOou6?=
 =?us-ascii?Q?C2H6/j9aLbdqhtkrftEp+AhPBL3lqJUbY2z+uBggGHAAdQfb8kOWd4e1A7qa?=
 =?us-ascii?Q?PeuadfI9bK+nAx4e338G09iHDIxEaSFDqMM7M11NvKObyGLF+s94v9cQr7YP?=
 =?us-ascii?Q?Zd2Q4UQUzOfZRQGvKjL4n4jQfJ7i1B3Gava4w2OW+HxTOQas3co4hNm3rc8F?=
 =?us-ascii?Q?umgYJx3b1WMgdA1houclQ6+ZvuC8H+rekwvbCPy5nzjoahogEqtrWo02Lsxn?=
 =?us-ascii?Q?WL+h89yfyvevh1m0oSHeQ2zrzZWgkxqNgzDxficVBxvwEUPNPMlz0X2PEpYk?=
 =?us-ascii?Q?JyhwYQopIkbIUbhnDKpY/WT5+xlqs8Cv2lddy/Ds3rimg+Yb0Db7GYrpZGVX?=
 =?us-ascii?Q?tpdBSX5Bl2ppDIL8uFrcTC5NZlq1MqSmHS3rcKvEjfFZ+8qz3GBJlmAAoy6g?=
 =?us-ascii?Q?Iu9Bshvcy6RXCLUa3rzBuuyMAjLQZGaYnsw3Us89EGkxLPoThCCpyWo9EHkt?=
 =?us-ascii?Q?r/nNixVT5KdkNV41KxQihodbhDgoiz4iepyuS8JbH/d/zgvNZq7oB69SnSpA?=
 =?us-ascii?Q?uYYx1Bt607NWbvb43fk=3D?=
X-Forefront-Antispam-Report:
	CIP:66.129.239.14;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:p-exchfe-eqx-01.jnpr.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 23:04:57.9490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e50dcd7b-016a-41a5-4542-08de013ef14a
X-MS-Exchange-CrossTenant-Id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bea78b3c-4cdb-4130-854a-1d193232e5f4;Ip=[66.129.239.14];Helo=[p-exchfe-eqx-01.jnpr.net]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR05MB11182
X-Authority-Analysis: v=2.4 cv=KrxAGGWN c=1 sm=1 tr=0 ts=68ddb39b cx=c_pps
 a=WFfob/tpvpsU+KY5JpTU8Q==:117 a=f/rncuQqEjTEF/G1odkJ9w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10
 a=rhJc5-LppCAA:10 a=OUXY8nFuAAAA:8 a=T8OkcMHtG-hyPi3r-k4A:9
 a=cAcMbU7R10T-QSRYIcO_:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 04c6fg_ME1KwKSUM7UNNEi-hr_gxRN2Z
X-Proofpoint-ORIG-GUID: 04c6fg_ME1KwKSUM7UNNEi-hr_gxRN2Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE4NCBTYWx0ZWRfX5QANehkwWr6A
 AO0vWcAVud036ih2o7odPtYp2c6tnkkMr2IF3Ma6XZ03DcJh0F782CT1vKvXwM45HrfZLu80wjd
 ttYZjA9wPzQraA0R76clLz6yhDKZ1jnxMU6WbU/56/ca4vUgZezdSR+yvszxgh0JTUjzWrSV+4b
 KRuchSphNL8rphxo1PGiUFALZz93kY6Vf/2SnnHj4GWCKC1nnLewRyq5h69hG1wuQtgYqax9AMe
 qWrugIsgjvgciNQH2RuFOXmRbE6ouOoWs6PoFbNcL1OU4eG9DLS4UdLdLGQa1oHADQZyiBI+PX0
 NwufYhJr7RTVep5Kcc4zmIUWj1JM3jtx6jVd4r9YKq14sW4N1xHTqOVdZ/aoDaCk/qSL2MFJSVK
 kTvPy7qaALVb/XcA0cFAcrcDi0QOtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_07,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam
 score=0 priorityscore=1501 suspectscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509300184

Currently, the bootloader-provided command line can be prepended to with
the built-in command line. This is done by enabling CONFIG_CMDLINE_BOOL
and specifying a CONFIG_CMDLINE value with CONFIG_CMDLINE_OVERRIDE
disabled.

However, there is currently no way to append the built-in command line
to the bootloader-provided command line, like there is on some other
architectures. This is necessary to work around bootloaders that are
difficult to update, where we want to override a subset of the
bootloader-provided values and keep the others.

To solve this limitation, we add CONFIG_CMDLINE_EXTEND, which is already
available on several other architectures, to make the built-in command
line append to the bootloader-provided command line.

Signed-off-by: Brian Mak <makb@juniper.net>
---

Hi all,

I'm not sure if I'm reaching the right audience since I haven't received a
response in the past two times I sent this patch, so I'm adding Andrew
Morton to this patch as well.

Best,
Brian

 arch/x86/Kconfig        |  9 +++++++++
 arch/x86/kernel/setup.c | 13 +++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890fe2100..8da39ebaddf4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2275,6 +2275,15 @@ config CMDLINE_BOOL
 	  Systems with fully functional boot loaders (i.e. non-embedded)
 	  should leave this option set to 'N'.
 
+config CMDLINE_EXTEND
+	bool "Extend bootloader kernel arguments"
+	depends on CMDLINE_BOOL && !CMDLINE_OVERRIDE
+	help
+	  The built-in command line will be appended to the command-
+	  line arguments provided during boot. This is useful in
+	  cases where the provided arguments are insufficient and
+	  you don't want to or cannot modify them.
+
 config CMDLINE
 	string "Built-in kernel command string"
 	depends on CMDLINE_BOOL
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 1b2edd07a3e1..86e4d8ab8558 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -911,10 +911,15 @@ void __init setup_arch(char **cmdline_p)
 	strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
 #else
 	if (builtin_cmdline[0]) {
-		/* append boot loader cmdline to builtin */
-		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
-		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
-		strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
+		if (!IS_ENABLED(CONFIG_CMDLINE_EXTEND)) {
+			/* append boot loader cmdline to builtin */
+			strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
+			strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
+			strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
+		} else {
+			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
+			strlcat(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
+		}
 	}
 #endif
 	builtin_cmdline_added = true;

base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
-- 
2.25.1


