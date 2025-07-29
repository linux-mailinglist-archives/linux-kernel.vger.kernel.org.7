Return-Path: <linux-kernel+bounces-749782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8390DB152E2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B22546AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E12248F7A;
	Tue, 29 Jul 2025 18:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="Scip9x+r";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="Vua43W9Q"
Received: from mx0a-00273201.pphosted.com (mx0a-00273201.pphosted.com [208.84.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D56823ABA1;
	Tue, 29 Jul 2025 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814153; cv=fail; b=ufS8LWIjSL2XcALk8+jvy/XJee91wnDe1dZdit1ojkCx5KiNRXEHsUps7VjQB2oG7TuoG+m72MXmTQMZS9B4qySTsKn/8W/Ta2rhV4Obtw51ZqFbOVTOfq6Mv5lGEBINB5zoZOxpGa4wv7Nf5ZJ7mLI42L1TCjt/MQfmiqYK9Hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814153; c=relaxed/simple;
	bh=GvPpSQyvgNzIgEiSW1dkkbDiNS8hUgzbYDQLndKceeM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IEc0iqB/AovMqLuVj3Gx6X7y7LSrlTqykhVJbRWTKbnK72e4xWjFKxBYy+A4yh/eMPX1P2qTV9FT6Tn96qUVyrGB9n/u8BRMNdcnwdLPnQLJmTGq4lm3xKw1rQ/jim50yilix1WeDqFasWq3wBvm/rCvWenQ2c3V8/956X1uIoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=Scip9x+r; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=Vua43W9Q reason="key not found in DNS"; arc=fail smtp.client-ip=208.84.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108156.ppops.net [127.0.0.1])
	by mx0a-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TGeea7029128;
	Tue, 29 Jul 2025 11:22:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS1017; bh=2yUDeV39xzy8BlITii4kNhu3
	rpEwWyfVcL/NG8iE5p4=; b=Scip9x+rvvZGc7qEd5QD6+Mu1faFKcetvfk3NJHo
	FHnpte3Mo9481kv8PCGDxZocjL//zz5pMIXJFPQhE6z2Ot27sGdP0V7+meE0zdxI
	gV7ue8IIsJKxzDCw2UWzM0fNixZlD2aI06imgBiYRQok78sODA1NYQDo6yBjdKdQ
	IY0TG5Te6obj6Pr4sHddDJ0mbn5gezXgNbbE53sHw7RUE/evT9lAlZhaj14Eu3lX
	KbN/ybXd26V3aSq6uteoPfmqb3geurMZd17hSaBL0HpLW61eomcfQYamMulpfbq1
	/U5uibyESt97Wo0SJ9+AAmW0dAsp5EEK7CnSdPYSN9Ub9g==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11023138.outbound.protection.outlook.com [40.93.196.138])
	by mx0a-00273201.pphosted.com (PPS) with ESMTPS id 486vyvh39q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 11:22:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3mNSnLGMkcIkYRctGfSVdA5g0mVYCcrMnYwDF7ukY+zpneiq2EWlYxCyvc9d//Nb9G5ymzzK9wKbAiZQ1UpAdTBchxDPIF4q38W1It3GirxIjiWfmDUgPA1iYNlXWPqME31ebD/FNMhDqDizSWypUhdC5ImUtOHuHMYUAFAB8x0+LGjxng1L4o5cmTUmlnTe7IukHf9X3BMbljhrdloPj7SS3kgfGhc6yGdGocaBblNzkBkixAPAhBT+0Il9riJrzJmsr0iROs0qmCqgzOzBylIYM6EREcuWY5X1Pj7s2F7kT8HTzXZqkSNIFi6c6ZwaCO1GHatm+DDNj4w7k7pkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yUDeV39xzy8BlITii4kNhu3rpEwWyfVcL/NG8iE5p4=;
 b=vqP5lfzC42RUwk80L45kZeR4FZK2g+yO0CXAg+0L09sAQEKYW74f9x02kP2r3dGu0dlYuIPe5VK511idoqzLFNb0C2Hl7a/bEm0g96a6Xm0VkKLrUJt3qCLtUjOj2EOrSqTK2tRyI4jQ6s+11/L7tOU5mgjMoA0lHmOztnzSp54H4ZH4bTh+2UuKukCqS+qJ35MpQ0E0GMraTATnEPBgIepUOZjHrewBn9SY6P23shatvWW1RGnJYVt2Tp4FS/mtiMqULeghqNK0sV2mKsvAtoTVBOd7SKFgGfgK1wMm56FSpHl+wgy8EfiPJHzbpLThzeWh7jPmo77+h09LznHbng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 66.129.239.15) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=juniper.net; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=juniper.net; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yUDeV39xzy8BlITii4kNhu3rpEwWyfVcL/NG8iE5p4=;
 b=Vua43W9Qoxw0HwKhlc8xEo7ASRa5t8HEpX1Pqr0nMdqcjFoN7ezuSxsSPZoY68zBsmM1WEzbWXxZvkBSvOeaI5+sSCVnCByZ9he0U/I0HUchFTwFVsPUK8knHf9pTtWKqP53ci4wWvUNX62Eaf854RPP81TzItxng71oYfMwQfw=
Received: from SJ0PR03CA0363.namprd03.prod.outlook.com (2603:10b6:a03:3a1::8)
 by CYXPR05MB10532.namprd05.prod.outlook.com (2603:10b6:930:d6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 18:22:27 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::f1) by SJ0PR03CA0363.outlook.office365.com
 (2603:10b6:a03:3a1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Tue,
 29 Jul 2025 18:22:27 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 66.129.239.15) smtp.mailfrom=juniper.net; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=juniper.net;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 juniper.net discourages use of 66.129.239.15 as permitted sender)
Received: from p-exchfe-eqx-02.jnpr.net (66.129.239.15) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.10 via Frontend Transport; Tue, 29 Jul 2025 18:22:27 +0000
Received: from p-exchbe-eqx-01.jnpr.net (10.104.9.14) by
 p-exchfe-eqx-02.jnpr.net (10.104.9.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 29 Jul 2025 13:22:26 -0500
Received: from p-exchbe-eqx-02.jnpr.net (10.104.9.15) by
 p-exchbe-eqx-01.jnpr.net (10.104.9.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 29 Jul 2025 13:22:26 -0500
Received: from p-mailhub01.juniper.net (10.104.20.6) by
 p-exchbe-eqx-02.jnpr.net (10.104.9.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 29 Jul 2025 13:22:26 -0500
Received: from buildcontainer.juniper.net (qnc-bas-srv120c.juniper.net [10.46.0.14])
	by p-mailhub01.juniper.net (8.14.4/8.11.3) with ESMTP id 56TIMLsZ003853;
	Tue, 29 Jul 2025 11:22:22 -0700
	(envelope-from makb@juniper.net)
From: Brian Mak <makb@juniper.net>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
        Rob Herring <robh@kernel.org>, Saravana Kannan
	<saravanak@google.com>,
        <x86@kernel.org>, <kexec@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Brian Mak <makb@juniper.net>
Subject: [PATCH RESEND] x86/kexec: Carry forward the boot DTB on kexec
Date: Tue, 29 Jul 2025 11:21:42 -0700
Message-ID: <20250729182142.4875-1-makb@juniper.net>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|CYXPR05MB10532:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a4dc903-6684-47e7-c559-08ddceccdf4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vvlJZGRa3USub/X6v9Cx+w9zgvpMRKvvn3XmmWu9xLP6hs+E6NCVQetrMtlS?=
 =?us-ascii?Q?pJiCR4EdwjXcyJYwId9vlePaYOJ+Z/p9fROH5CXbzD1cFjmomzLmkU/3dtut?=
 =?us-ascii?Q?NKpuHDwZFUDpE7LN0u2Hq1VOa5KYFi+LGSXapHYT4f1A2Sv3y7MYHbsTGGNu?=
 =?us-ascii?Q?imwioWYIPLEr7BDkbKTlY8pkeq2sEcPuJ8k04i8zs9YsGm9B6+7Mgs7Rujhd?=
 =?us-ascii?Q?wYquFCeKrfWyxlLVmRhK+rP8/xQXB/LfOk+YqYg227z9jhTdZHHgsjYSy3qY?=
 =?us-ascii?Q?EGybw9UXB4WLgKC0Aj/amGNdHaT6jiWZ7qTWGMZlidJs4VrnAG02zOWJYSYZ?=
 =?us-ascii?Q?UykaPGDwlvTA9Ofkv4apsbuW0LUi2Dwr4KERJMVbcektSDlMln1pTNinqGn3?=
 =?us-ascii?Q?xgyjtSshwWGVI0l1gL7XzOKpwsvtJpAOifQ8klGp5fFelQjgltSHkkPt7NaO?=
 =?us-ascii?Q?AG3tQgpGPZr5OzIsMyk0pWotd6BBk8+P0KDhf9xWrBQBVJR8rzaSnGOnfX19?=
 =?us-ascii?Q?DQPaCMsB8KyaKpubjTkzmfNt8WdE/BAnILQn1EzCnUahqJgkdXJY8htaGanh?=
 =?us-ascii?Q?S603HzUKVZtjGpFqI7yh3e707J5SQeY5WvWWw7w1osQPUeoMt7XYvG2j1jDZ?=
 =?us-ascii?Q?XWwRbIGnqdXOTcrifZQbM8tjCOE65ObxaLtPrf4IsQHunjS63bFPYouGySGb?=
 =?us-ascii?Q?//FZ9Azg2O0YfjrLBjFFpUFZNS8GxFECnh04xbduFQUhy6zlgnPe+bJHbSMu?=
 =?us-ascii?Q?qJtgySTSO9DuCSNfH4Lomi2dNkipgWj8HSe53r7aOy9naemcjpMj9/mqxlNL?=
 =?us-ascii?Q?FnybjXBEg9u+5Ew/P2bl1mS8vfWUwlU+ao1SmnBZJGsd0HrwCup1rCCt+oOT?=
 =?us-ascii?Q?VZ3Xp5d4TJaF2qzF6qqo8xKenghtv6UWpOByV7vrTJfXFSf9slb0MpUymAP0?=
 =?us-ascii?Q?2tJTFX6PRXF/Hf4Q03BZN2AwLbmYnJqgCyMRopcahWXY4AH2jRIslOqVxTqn?=
 =?us-ascii?Q?E6vgHlAWcO+Kx2AESsCQ8m+1QqZs694uH6M5Pl000+LNq3J9FON4qFbYM7pI?=
 =?us-ascii?Q?hk6/U8AyMbG95vsQAJdgFFCECKORA01VFdO2oxa/H7pn++8H3oAKD90imlNK?=
 =?us-ascii?Q?/IhzFFsBp0owsp/iXarQNK7MowaDls71fNQI4f3NBR+PdbQfVANckRTejjDc?=
 =?us-ascii?Q?5r7gMDvt++zowlJdRWjXpWLF159oK4uucYhfboUlOceyf0JBeZJ6Qe1MpT3m?=
 =?us-ascii?Q?fkTc/bl6elT9py/bpML8g4n/2pEBNGIHNiGVPqKA+bwVZ0aMYSCN+0kQNrOU?=
 =?us-ascii?Q?CMBfsyxO63ldMZtp/seWRtUeVO2y6wCqX//ctW/tJ1UCb9Mwpf+UBr9Kukvn?=
 =?us-ascii?Q?ui/KdbYgItzguBFg4/uRcN39MpUw5tJRXJwYB+76BW2CsgfkdqBFx+32Ae+a?=
 =?us-ascii?Q?yJiO9INPz0XC3mVuaFkxEstC2n/wVJLPpX6bYVe18h96jrNGQm/YbErc20hw?=
 =?us-ascii?Q?XX8zrhdUTYLhpLvshf/d24pEqUUbhNIf0aEBhhdOx+jf+DsKDSpM1nMpSw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:66.129.239.15;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:p-exchfe-eqx-02.jnpr.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 18:22:27.1397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4dc903-6684-47e7-c559-08ddceccdf4d
X-MS-Exchange-CrossTenant-Id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bea78b3c-4cdb-4130-854a-1d193232e5f4;Ip=[66.129.239.15];Helo=[p-exchfe-eqx-02.jnpr.net]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR05MB10532
X-Proofpoint-GUID: wWjZcQLTSaE3WjeNO8xer8ViXoWOxIY8
X-Authority-Analysis: v=2.4 cv=MPNgmNZl c=1 sm=1 tr=0 ts=68891165 cx=c_pps
 a=LTDvKTvnmzKa6KpkIGqB2A==:117 a=YQU41r7WENJiSYrYYNJVsQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=Wb1JkmetP80A:10 a=s63m1ICgrNkA:10 a=rhJc5-LppCAA:10 a=OUXY8nFuAAAA:8
 a=7_5vobUxZMcRO-ldgD8A:9 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDE0MCBTYWx0ZWRfX00eF6R8z2OAR
 K2CadauXV9VN4xffsvGIeObhnKh9muS6MfrGj2DeEbfcCrwVmCU92AZ2EYyrHaVPle9dxugX0mu
 7S5rSUgJhSw5vzmzv25NLfs9Pct63LWLiofYRduW424y+y4mXL2A/L4To4c0MtyBW+UTKZj8fqX
 U75kG8yUzSUlTQyP/DuTB6nE58VC6daQKWIA3l7RNFm2dhJ/SKZeKGsO8bu94PqVAhNthipLbgm
 KuA2D5LtpjskGOHjA1BCilt0ak8nv7VKKq1TpeNmTL4nW286FvMuJKKF4ch41i6T244sEEK+HxU
 JJiFz77ZI/yQMwCXTkR8fCGBo1hV3nmQC0+3PUsFVYYB0/XaGry/d2I3OzD9ja5PN+E5L1khfYc
 I6OL2aT3ZbN0L0v3socWFtn/Lo7RBCLfemQRWRXvcjMEMM6s/sEDQsYY+RnXZAlsxOYBgD2g
X-Proofpoint-ORIG-GUID: wWjZcQLTSaE3WjeNO8xer8ViXoWOxIY8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam
 score=0 impostorscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507290140

The kexec_file_load syscall on x86 currently does not support passing
a device tree blob to the new kernel.

To add support for this, we copy the behavior of ARM64 and PowerPC and
copy the current boot's device tree blob for use in the new kernel. We
do this on x86 by passing the device tree blob as a setup_data entry in
accordance with the x86 boot protocol.

Signed-off-by: Brian Mak <makb@juniper.net>
---
 arch/x86/kernel/kexec-bzimage64.c | 46 +++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 24a41f0e0cf1..c24536c25f98 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -16,6 +16,8 @@
 #include <linux/kexec.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/libfdt.h>
+#include <linux/of_fdt.h>
 #include <linux/efi.h>
 #include <linux/random.h>
 
@@ -212,6 +214,28 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
 }
 #endif /* CONFIG_EFI */
 
+#ifdef CONFIG_OF_FLATTREE
+static void setup_dtb(struct boot_params *params,
+		      unsigned long params_load_addr,
+		      unsigned int dtb_setup_data_offset)
+{
+	struct setup_data *sd = (void *)params + dtb_setup_data_offset;
+	unsigned long setup_data_phys, dtb_len;
+
+	dtb_len = fdt_totalsize(initial_boot_params);
+	sd->type = SETUP_DTB;
+	sd->len = dtb_len;
+
+	/* Carry over current boot DTB with setup_data */
+	memcpy(sd->data, initial_boot_params, dtb_len);
+
+	/* Add setup data */
+	setup_data_phys = params_load_addr + dtb_setup_data_offset;
+	sd->next = params->hdr.setup_data;
+	params->hdr.setup_data = setup_data_phys;
+}
+#endif /* CONFIG_OF_FLATTREE */
+
 static void
 setup_ima_state(const struct kimage *image, struct boot_params *params,
 		unsigned long params_load_addr,
@@ -336,6 +360,16 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 			sizeof(struct efi_setup_data);
 #endif
 
+#ifdef CONFIG_OF_FLATTREE
+	if (initial_boot_params) {
+		setup_dtb(params, params_load_addr, setup_data_offset);
+		setup_data_offset += sizeof(struct setup_data) +
+				     fdt_totalsize(initial_boot_params);
+	} else {
+		pr_info("No DTB\n");
+	}
+#endif
+
 	if (IS_ENABLED(CONFIG_IMA_KEXEC)) {
 		/* Setup IMA log buffer state */
 		setup_ima_state(image, params, params_load_addr,
@@ -529,6 +563,12 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 				sizeof(struct setup_data) +
 				RNG_SEED_LENGTH;
 
+#ifdef CONFIG_OF_FLATTREE
+	if (initial_boot_params)
+		kbuf.bufsz += sizeof(struct setup_data) +
+			      fdt_totalsize(initial_boot_params);
+#endif
+
 	if (IS_ENABLED(CONFIG_IMA_KEXEC))
 		kbuf.bufsz += sizeof(struct setup_data) +
 			      sizeof(struct ima_setup_data);
@@ -537,7 +577,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 		kbuf.bufsz += sizeof(struct setup_data) +
 			      sizeof(struct kho_data);
 
-	params = kzalloc(kbuf.bufsz, GFP_KERNEL);
+	params = kvzalloc(kbuf.bufsz, GFP_KERNEL);
 	if (!params)
 		return ERR_PTR(-ENOMEM);
 	efi_map_offset = params_cmdline_sz;
@@ -647,7 +687,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	return ldata;
 
 out_free_params:
-	kfree(params);
+	kvfree(params);
 	return ERR_PTR(ret);
 }
 
@@ -659,7 +699,7 @@ static int bzImage64_cleanup(void *loader_data)
 	if (!ldata)
 		return 0;
 
-	kfree(ldata->bootparams_buf);
+	kvfree(ldata->bootparams_buf);
 	ldata->bootparams_buf = NULL;
 
 	return 0;

base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
-- 
2.25.1


