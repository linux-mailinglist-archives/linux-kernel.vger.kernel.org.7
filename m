Return-Path: <linux-kernel+bounces-817810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2730FB586CF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD7F1B24E85
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC1C270569;
	Mon, 15 Sep 2025 21:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="fga+kvyL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="dujGet+q"
Received: from mx0a-00273201.pphosted.com (mx0a-00273201.pphosted.com [208.84.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721B2EACE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 21:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757972055; cv=fail; b=R6aGxZy+wL+oF/2OE9JV32lN/R45utJGg38VQXRIfX5zL4npkmKu3K/pvGbtGGk7h8gJW8B4O5wrJqwN5ZjV4FhRGuXoClhdlvG0DEKau54l6qaxFRM127aXiq9iSLAjB0m1iORsTqWmzeUvP4JvBuL+AUyRrJBRlKpFDr36VI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757972055; c=relaxed/simple;
	bh=TMRBkt2voLxk6gWOGHmJxgwMK3syHjFoF6bhl7lHjMw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kDSdzf7Trhgt0v84aF8N6pQIaryQSjONZEueVXUHp9MWl+7EYnL68aIS79qgRKIoh4aSly+DRlz9u3GusKNYeqi6bVsSbZ7ZnjUinHM220e04i61bOJmfxRcAI0plOavJL3DPTuPrXyv0ViyWr7iE35PnzAsv3Ch1wS2lbUZxfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=fga+kvyL; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=dujGet+q reason="key not found in DNS"; arc=fail smtp.client-ip=208.84.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108158.ppops.net [127.0.0.1])
	by mx0a-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FIbsK3001864;
	Mon, 15 Sep 2025 13:27:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS1017; bh=5efEglA3w64cLzr3Z8frOwPR
	4VbJriSNzJR4lUaYH9Q=; b=fga+kvyLL0eNf7dQljGjoe77e0vUTpaeZPMJrteW
	e/bRKFU2+8Z34x4296WUWMTJOYTqrTaojGaN4NPrIx8HjVhjwLkwFSAZPNBg7TfI
	HVGcWXlS/fI4+YYBWjn2pqwTeikGBT/3savqP+A12x7UEWxYPXjbwLps20RMZVNT
	jJxX8czT3NYd4h2R7KjSb2Gxml5S9wtnDn7o6lhVnDG/I9u3JPbdYpjLKWmlJRU3
	2ovS+jglTU3mvwj4ALkMJfrepa8n3/8Iy55/QDLmJRknZfsQL2MXYGacFdp+kACG
	BfNPNa83DGKc/D3QKM3EGB7/r3JSjJDx2HCMq6B+wNzfDw==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020102.outbound.protection.outlook.com [52.101.201.102])
	by mx0a-00273201.pphosted.com (PPS) with ESMTPS id 49653uadkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 13:27:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FyzHHLmjVQUOJX1KW47YLK1gTflfi5Rmi7nF/jijxQGDFVsrKk8w8Qt3NqRhjuXGTWRP4p8bFHrnsG5xd8hVjswQNwJy0eeBdSwQAeOCKgMyTbHb8+PqPcn/2B9MUDfq2v1yX1h7Xa5TZ15dRx03HFsG6olTdV4I2XlsJf2Bc2Y3U69IIJF5s3EewhAF6UCUp1dY5JgJNWgaEJ2391lwfNLJb6DaKu4C3kgpwGpZDr9OPA3R2Y+jznnW6CAjMSbp+7Ua/fYsbSKX0RpvvAKt7h7gDDCIEigDm0rwxbiaFe/LjQhKPukaR2yfuGrOrWiSLjxB6FV5v8CiviGWI+VWEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5efEglA3w64cLzr3Z8frOwPR4VbJriSNzJR4lUaYH9Q=;
 b=MTX2a24VkFmG6VKaeFYlcjkjINzJOy3tESq4YLTKaeY9+4w4zhZp+UdErPZGqKSNo2W7euQzrKBpyRw/6IkIbbAo5SBRi+KcjrPAxh0451PCI0aIbmKGER4YeEJsav7yfWE9MttlIHxYD2tfZXMsTNqYv5UTdmjY/ilEKZG9EQeDbBr4Jo4gNC7TbdB++zgeQGIK7MsCT3o9413nNI5Apu3HVpkWEjfbCh3ymNv1Ls9QrVCuaiusCm5HJqNrZjUH5IC0tYFhqLsw6dk/VPgEG1rdUT62wvdLxNGEINip83mA03mVUrLoOQlNaUMQ9FsWU7gSUZz1fjevRty8yKs4ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 66.129.239.14) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=juniper.net; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=juniper.net; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5efEglA3w64cLzr3Z8frOwPR4VbJriSNzJR4lUaYH9Q=;
 b=dujGet+qw8RvBVhRh16LJ3ePqn+NR86CHyIELulm4LwWVdT0TAnaVrLRQJdg3uQ05Mw6V15ayg4xxLZWG5B/e8aCcrFSzLzSURWJn0aOG4c/2AjUEl8Pz1IMeurSi9Ll4ovwXYQaY2/bX9t+VpRtIdR8XeJ47DAO8mVN82TfJ3w=
Received: from BN8PR07CA0036.namprd07.prod.outlook.com (2603:10b6:408:ac::49)
 by DS0PR05MB9398.namprd05.prod.outlook.com (2603:10b6:8:132::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 20:27:04 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:ac:cafe::49) by BN8PR07CA0036.outlook.office365.com
 (2603:10b6:408:ac::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Mon,
 15 Sep 2025 20:27:04 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 66.129.239.14) smtp.mailfrom=juniper.net; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=juniper.net;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 juniper.net discourages use of 66.129.239.14 as permitted sender)
Received: from p-exchfe-eqx-01.jnpr.net (66.129.239.14) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 20:27:03 +0000
Received: from p-exchbe-eqx-01.jnpr.net (10.104.9.14) by
 p-exchfe-eqx-01.jnpr.net (10.104.9.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 15 Sep 2025 15:27:03 -0500
Received: from p-exchbe-eqx-01.jnpr.net (10.104.9.14) by
 p-exchbe-eqx-01.jnpr.net (10.104.9.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 15 Sep 2025 15:27:03 -0500
Received: from p-mailhub01.juniper.net (10.104.20.6) by
 p-exchbe-eqx-01.jnpr.net (10.104.9.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 15 Sep 2025 15:27:02 -0500
Received: from buildcontainer.juniper.net (qnc-bas-srv028d.juniper.net [10.46.0.24])
	by p-mailhub01.juniper.net (8.14.4/8.11.3) with ESMTP id 58FKQx43014536;
	Mon, 15 Sep 2025 13:26:59 -0700
	(envelope-from makb@juniper.net)
From: Brian Mak <makb@juniper.net>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Brian Mak <makb@juniper.net>
Subject: [PATCH RESEND] x86/boot: Add option to append to the cmdline
Date: Mon, 15 Sep 2025 13:26:49 -0700
Message-ID: <20250915202649.44309-1-makb@juniper.net>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|DS0PR05MB9398:EE_
X-MS-Office365-Filtering-Correlation-Id: bc4d1290-e508-4142-e7d3-08ddf4963bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vjph5z6xaAnpYZWDz1HlBv4ap830EVo/VyHig11mnTr1DdhN6XKiMgGh7mP3?=
 =?us-ascii?Q?lXE5NP1RiBbKH/d7pklpI3BMdyzt4f1eZ0DDcUHy+sxupqrsW99P6WVJv9Ug?=
 =?us-ascii?Q?XvMsSOjGX8PbAh063NHieOSYWzsT1evDHWx1ehqBRJ8k4prQbMPsxYvbLpxt?=
 =?us-ascii?Q?wr/v7aKGGmlXWMuAKFR43yKDW9R6TRAgT1emn6tXFLaBjKF57+CzzOmLtdqL?=
 =?us-ascii?Q?hIYQIZ7aq0xd3MfFUrocwIMxycYpl87QsW/uBSbZ0wC+GnJ3g3QBPKMEmoZP?=
 =?us-ascii?Q?M+3utooCzzU3ShfwmmG+F9k26iyIZpK+JYvQtOIdxneJdbdQIvjIV9jj8+e+?=
 =?us-ascii?Q?GQh0Plt6kf446YDqLdt4+9/CSfFkfDfAHENLqIRreXH+dZKXkjYQARVpP5ev?=
 =?us-ascii?Q?NFa32pmxG7AqnR2FELUF8wZkYnpby4Z+0CfIpFh6VZExPF1bTgypsMugegt0?=
 =?us-ascii?Q?juH/0oST84zwG/sblSEH6v5StobSlCTFu2MzdfBAO0+LsaGwvIfJDbFZDSg2?=
 =?us-ascii?Q?P8/j/tiDsYlfHrO+DSnDXqNqhG8QD1Cdp7ubahuCELgCusdyB4MW/fFrZsKu?=
 =?us-ascii?Q?/t6/EawOPB6clo6aDpexw2IzHdcsxRYhfbhOFGJaatnt22FMDI8UQ3XQO6UO?=
 =?us-ascii?Q?13hV8H4SDFgPxO9DAkSNwZrDFCe0O1xExy5qJN4Zh/xv4LqkThU/ssU1l+3/?=
 =?us-ascii?Q?qMPReBuf1HMOISLmohle658zi4nuxQllEYZgrqWfnrHqjFPv2LaRMpefdOO1?=
 =?us-ascii?Q?+zR/wsl91t1JNd6M8f5qM+MaMf5xS2VJO4GwNe9iQ979FE1qYJHwy0A4nc+Y?=
 =?us-ascii?Q?S++JqYgmqL3HiXt9kkt9txXPYbHgQahrpQkRDab1OJ6iO30WQ6pxuhUmLG0d?=
 =?us-ascii?Q?jxNOLkKJilzBOOjGeIFpQNBwWv5OsfDy1V14K6P1p60TD8CzTxdjqAO3a3eL?=
 =?us-ascii?Q?+Y/cu4qsAgnyndADZsX31fXqadUNPPfr9z9LTAM91Bc24T39rhc7ludCXVyg?=
 =?us-ascii?Q?aCq1J247dhM/7yJOdYJlgtbbsjNqkV2yKQ2p8fDU6k/3foAyAtflMSXO3ORO?=
 =?us-ascii?Q?5oJpSdjcEX8eamKtoFKATQFlnDj6fIr2V5KcFrohjPY+29LyHh7GoVuVJzPw?=
 =?us-ascii?Q?YcGkMWGo8Y4YsUrwuKcJ4nkmE4bjt47XFtOEbIoPewcxRyzKe4Fk8HQ5k6+b?=
 =?us-ascii?Q?oG0M1+s3eZ1ojCwabMVSSQqvkICK8qfU/Av8hwLg/9qqCehM6Edpcr882L3P?=
 =?us-ascii?Q?phjKfbw1Q1KwLf0LIJImobrgUPoFBmsT9Yw6ZHJ5/saai81Xu1c6sl0Sei9p?=
 =?us-ascii?Q?+NFD7i5nFj2lWjiksWkrjuuHzC4ZkiRFH96zCVjp0CLa3vm9Ja7lxGLxWQf5?=
 =?us-ascii?Q?E+ut1anCObBlSMpdwgmwXA08NfKldNCdeTOSVbHbiQdtlwcP4Nefss7irnIn?=
 =?us-ascii?Q?HSyiZVpf5ITehveYhDgU5aVdTT6a4a0078Wq+elKWBLaNb2djlfJkj6zyj4O?=
 =?us-ascii?Q?xBMyZrsgt/jLgoNkF9hT2sbPsYwDq5vcHwCY?=
X-Forefront-Antispam-Report:
	CIP:66.129.239.14;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:p-exchfe-eqx-01.jnpr.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 20:27:03.9924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4d1290-e508-4142-e7d3-08ddf4963bc2
X-MS-Exchange-CrossTenant-Id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bea78b3c-4cdb-4130-854a-1d193232e5f4;Ip=[66.129.239.14];Helo=[p-exchfe-eqx-01.jnpr.net]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR05MB9398
X-Authority-Analysis: v=2.4 cv=XrP6OUF9 c=1 sm=1 tr=0 ts=68c8769b cx=c_pps
 a=5886/XAhn54D+t2DuUGJPw==:117 a=f/rncuQqEjTEF/G1odkJ9w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=rhJc5-LppCAA:10 a=OUXY8nFuAAAA:8
 a=T8OkcMHtG-hyPi3r-k4A:9 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-ORIG-GUID: WembR-Y56MnOnOh-h0_cYUF-yTAZG-3L
X-Proofpoint-GUID: WembR-Y56MnOnOh-h0_cYUF-yTAZG-3L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE0MDIwMCBTYWx0ZWRfXybdFXCPf1+om
 7NAE0Ahm7tGwQYGWF7Z9Ebl4KiuiPmzUQNxQRPzea4wJcH3m1OmSEX2ODvLutdOfxw4CuphMSG/
 p8TmVRJIt7z+1rIdbFxQvo4nbV2R9kr1vNLimJ/kmKLRXlxpU5jRAyUUFQNZK2KQ4w0vdploTPx
 LqUGGg5gmVaa67cuin2vyU015NMo0lcGyDzAfCYeCEbSpKqOX6rrg2dppkcnc284yK86bCKjk5A
 Zsgu8Gyze1RwciX3Oemb+PGmSelRKyybI13CMo/9aRV7Ry3bLmcC2gsfGkR8f7oOfujdgPXG3Za
 7v5Gztfh708QRPraur6g233RHouB3ZuuQn9yscMQq5/3Uh78qSimUjj+yQlY0zAhfphysmAboR1
 vTAnsMdw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam
 score=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509140200

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


