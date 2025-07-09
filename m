Return-Path: <linux-kernel+bounces-724369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B16FAAFF1D7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7C84A2604
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC6D24166B;
	Wed,  9 Jul 2025 19:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="0vnAWCQd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="KnvsyZ29"
Received: from mx0b-00273201.pphosted.com (mx0b-00273201.pphosted.com [67.231.152.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E37218EA1;
	Wed,  9 Jul 2025 19:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752089340; cv=fail; b=W5oUQF6Ziqx1szccCpjUxrCn5Tz3dl/HOiUKycQ56r3LWQmr6yb/Ju3XlCyRbUvnMTUtVpBcR2oJjo7Q2ZAtTSIdg0iibaPalGKQWOlxLGPoC7oVOOW9mSCeyLfQQ1bKApMhZeHZtlSMPF4DbFSDs3vltZDB9SmBBoXmKsWMWY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752089340; c=relaxed/simple;
	bh=GvPpSQyvgNzIgEiSW1dkkbDiNS8hUgzbYDQLndKceeM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dLUKLe6m6hQyWd5O7f/PuucGKcLs2YvGI63gko1bjPOoUMK75EBZe7txi5oLnQ2A9/RpSq/e8PREoTkb1BJuqX9YV9LYBtFfB7SbVbFL+u2Bi4lWlTsIA9EHW7hD/DI3pcz2Akeif7c4iV10PxNcCsU5jbXGiEgaMbQgPGXaDSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=0vnAWCQd; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=KnvsyZ29 reason="key not found in DNS"; arc=fail smtp.client-ip=67.231.152.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108163.ppops.net [127.0.0.1])
	by mx0b-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569J6m7r025731;
	Wed, 9 Jul 2025 12:25:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS1017; bh=2yUDeV39xzy8BlITii4kNhu3
	rpEwWyfVcL/NG8iE5p4=; b=0vnAWCQdjHFi6wjWcxbFjDdUMyrsnosJVqyNG4+N
	LTkow17jiYTpkcP69120s7jCFVuGWW5Nh4nMlwwoh8mfuZyLluYulBVyxRM+X2km
	DEA7Lor0Vy2n+RrctIZJY/vQMcnwj7hl33P0K3tnwJHawAsJ7bM5IVCJbFbJpP5b
	TPvtuTPe5JBU1udSYCd/mU3w+9E6xC9JI8UEjIdiObGGR7yiANmoJCTasb8xhbai
	CQUoD2p86YAhgfUde7IesYCopiXOCEnHzI2AoYN8oPh9le5k5IHxLMHTF1vNH3XN
	/rTY8XPE6BluqfwMDF42l5fhMs1jnooeE8qnFCpDiuK+qA==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020115.outbound.protection.outlook.com [52.101.56.115])
	by mx0b-00273201.pphosted.com (PPS) with ESMTPS id 47s612bw6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 12:25:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vdVqUr5gNiLb/rsV6ZlwpDEC4uwS/9epjewqk5Pc9QYDoXU4hnad1uwi1YKTHUvxSbitldsg+VxFBzYSizpS5DQEq9Li29zhxoZZYvWOebMo86iwhfNB5vLdSteLgrAbc1kwgadKxU3V1L70raoAiSUintym+Q/+4KDl0q+3jR3JK+XX0So/iB31U5rb0qIDIaHho1Sr7kJZAE4a6Ym1Tyl1bBqYtc15/zNPJbLZ68vpl3EVrY+Wsu9+GJ2klYYu+W08l6YG+zcBG8KKfICTQi9dzFVkYOW25lD0fC8FfABFteC/8wN+2yOKSReVRkRXKTAnn6o0lfOFHSKzaOphmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yUDeV39xzy8BlITii4kNhu3rpEwWyfVcL/NG8iE5p4=;
 b=Wk42RIKYbR5jNHO1SLEWBB/u3v96adC98Dx1BJcJq8qoB2bo5fFxO7WcOgJqEftdPXADzkNXU4TloQkwmOa+iRGLuk+/TMZVL0XyZkLYJ7JumZ3iRcNQVCAIfQPark30IowzdkuIDmssDbdevA7Y4hgM7D4pxvbJ6Sgf34eudLHGfI7s2ZHBUKg/7VbNpkpOAeSonABejEbUCpkEy/Z4Sv4/Nz6wCO4N7afRywgNuvdfukEV5SmFr2yhi5/G8UoRaE12+MtyjdddMLn2BLDLN7XrFwKEyN2+A/noPcZasDb6qAUiBUdykjTgBKPC4yK09OApcSOT4DYnFR9xl33vGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 66.129.239.15) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=juniper.net; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=juniper.net; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yUDeV39xzy8BlITii4kNhu3rpEwWyfVcL/NG8iE5p4=;
 b=KnvsyZ29bkZYhg8bHyIdOwQMxu3CFAxRfjvYPAvK7ht7tWvlqC/4VOKgYv5H/UUoyxiIflhjpgUp4vXtcnct6YhANkXWeIa/4JJI/HJ/w+jaxNzri0jeuTQdGeor0FXdtZWNgSvgZtVhX2PHO3aTJxbv6qn78wxwbleKWsa7zfI=
Received: from SJ0PR13CA0132.namprd13.prod.outlook.com (2603:10b6:a03:2c6::17)
 by MN6PR05MB10971.namprd05.prod.outlook.com (2603:10b6:208:4f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 19:25:22 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::4f) by SJ0PR13CA0132.outlook.office365.com
 (2603:10b6:a03:2c6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Wed,
 9 Jul 2025 19:25:21 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 66.129.239.15) smtp.mailfrom=juniper.net; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=juniper.net;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 juniper.net discourages use of 66.129.239.15 as permitted sender)
Received: from p-exchfe-eqx-02.jnpr.net (66.129.239.15) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Wed, 9 Jul 2025 19:25:21 +0000
Received: from p-exchbe-eqx-02.jnpr.net (10.104.9.15) by
 p-exchfe-eqx-02.jnpr.net (10.104.9.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Jul 2025 14:25:21 -0500
Received: from p-mailhub01.juniper.net (10.104.20.6) by
 p-exchbe-eqx-02.jnpr.net (10.104.9.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Jul 2025 14:25:21 -0500
Received: from buildcontainer.juniper.net (qnc-bas-srv120c.juniper.net [10.46.0.14])
	by p-mailhub01.juniper.net (8.14.4/8.11.3) with ESMTP id 569JPI1t004067;
	Wed, 9 Jul 2025 12:25:19 -0700
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
Subject: [PATCH] x86/kexec: Carry forward the boot DTB on kexec
Date: Wed, 9 Jul 2025 12:20:35 -0700
Message-ID: <20250709192035.271687-1-makb@juniper.net>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|MN6PR05MB10971:EE_
X-MS-Office365-Filtering-Correlation-Id: 26374f2f-45de-4f5b-0b3e-08ddbf1e58ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?St3/YkUifaIm1IdpT5skuLARBy1qA96/cNou8CDDV0k9c8cWTTwHP14eDDdH?=
 =?us-ascii?Q?nQisORnwRj/DcipX2jYxnbmiN1MaNGWrPE/2OO6G2NBgcNh3v6YBV/PyRtce?=
 =?us-ascii?Q?VOh2hmink2gdVA3hyR2xvYsIY6Dn9FZOuefI6kG7W6bx7HUFdYJK46ELLLfj?=
 =?us-ascii?Q?GziSZ8Vs2nq+OYuDeYEdcttvfT9ge/YLYC/uDOKrfMYD2+lPmAVsuG82gNPN?=
 =?us-ascii?Q?lkau7xzKVh1HB+0/F8PYTEik+6tnrtmtt9SCRmRw7XdFJftpig/FAtebYgcO?=
 =?us-ascii?Q?XyrH5eGerinbEm4IcwYH9JTp6+1agLcuYnt6zo2a5y41qT44wAnFxdgGYgdS?=
 =?us-ascii?Q?JcZI4SG7NamI8bt3zSG+80oBBTNHwoHjV26I97zpLjcImC3bQZMFuxddwuO6?=
 =?us-ascii?Q?5MgJJc0yfBgt7vkOHF9ZxN3MUpMaK7v+R/2aqrnFvGkh8R5cBD66nXmOok1g?=
 =?us-ascii?Q?EnGQ4Gb9RhTaKUyKShDv44AVmm7l4jutuYHGPoOR9vu6KwhleArwJf+JyY5Z?=
 =?us-ascii?Q?IIggzPDG4fZ3HjrEYj0f6lzy6NNet2Etwtws1C1FASIVZYfsR7h6oGlR+SWM?=
 =?us-ascii?Q?6FylsLuMVPsdqeSvA+qEUbCJa0/4o36zwAjvf1yGp69OE7ZyKJ7lL8MM7TZ8?=
 =?us-ascii?Q?dv3y62wsh5P5x4rzpEh+DjirUZ+cC8rq5pkWQJpZzxyH0eipfHVgDzBdTr3O?=
 =?us-ascii?Q?ffTQLnRPUm+XK9uf9ADZHiF2Z8NJY6C9vh2kUChjFiPVqU93KgV0Ke2vbMGo?=
 =?us-ascii?Q?rrH5ETjhGEzdfYiIc34rq3YgsCe6eCq8COKQkrh0lvbjbPE8jMNr5zNf+HkZ?=
 =?us-ascii?Q?WRwYfHvpqY+kJf8jV5x16Ubk3QJAKdSZ7hfmprKUcjociwZnKUfHONFWQ2Ys?=
 =?us-ascii?Q?wHM+Q4eBG3LBDryTyp41qg8jPHFBXqawSCcauwGYNEC2Q42e86l4sMcTxw+Y?=
 =?us-ascii?Q?qGTIyAZGVFTR2ZT1ytSzeIUo1esGAXMy0bMQ2tcr12uwIWJ0wWpxEgf2XxYp?=
 =?us-ascii?Q?rtLESDt4KO058j2hRQbEx2lDxFhm2UP3keIPT7AlYw77jx8P73FJJuWTZLA6?=
 =?us-ascii?Q?hPp8jUF2ZxZ36tVxaQdVRv5M6/90SLkXG5gyR23AymVtuYxUz+mg8iZFPNL0?=
 =?us-ascii?Q?3mgaVFiGRGd+d5j5RZ4RlAMAYfXHIZyaDpjatkpGKrmgOLhJJ3pwc6ir7P4h?=
 =?us-ascii?Q?leZEKq5mKLTjIP48MCBaYwfY+ErgSEzTcky7egwq1/Kl3iaPOTEXCfKB4qos?=
 =?us-ascii?Q?wtvBK6jdkolrDAT9BIAEbFCOLr6jpZccHNB+6gpvTC8S+DH1CZN0IGO/XyXd?=
 =?us-ascii?Q?PiM4ExEsmnVTYxu1q5+aCIFx8UKn8BgKJ3oXw+xS4oOuxdU90UEAxhcSI5tA?=
 =?us-ascii?Q?EAreM3XNhmgiv+GIKvDMSEgosc/QU4FQsscg91CkMJBrZBvmHKehRZ3ASCFm?=
 =?us-ascii?Q?tuOnJFwWDBjaTya91NmtHU2tz/aMOM15adNgdbG9AnHfPXKQNhFOwuxTdq3/?=
 =?us-ascii?Q?rVgyRM7ZmeG2eHVqiY3sYXRqd0To03rtQfISC/XiilrGnYlhcGdUs7IXGw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:66.129.239.15;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:p-exchfe-eqx-02.jnpr.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 19:25:21.7823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26374f2f-45de-4f5b-0b3e-08ddbf1e58ee
X-MS-Exchange-CrossTenant-Id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bea78b3c-4cdb-4130-854a-1d193232e5f4;Ip=[66.129.239.15];Helo=[p-exchfe-eqx-02.jnpr.net]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR05MB10971
X-Authority-Analysis: v=2.4 cv=LsuSymdc c=1 sm=1 tr=0 ts=686ec224 cx=c_pps
 a=Oahh2kgEN5ymB8sO0SiNEQ==:117 a=YQU41r7WENJiSYrYYNJVsQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=Wb1JkmetP80A:10 a=s63m1ICgrNkA:10 a=rhJc5-LppCAA:10 a=OUXY8nFuAAAA:8
 a=7_5vobUxZMcRO-ldgD8A:9 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-ORIG-GUID: xU9BpbEoZ35rbkM36kt3GynB8qioRzDg
X-Proofpoint-GUID: xU9BpbEoZ35rbkM36kt3GynB8qioRzDg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE3NCBTYWx0ZWRfX79MMF/saEIpV
 GbwU2Qi51ynzxoGslFuQQWoaVJ5VVxa/uFTBGXyM3T1R/Z1dtV13tQ0coJhyZri9LlaKEcy4zEQ
 8SUovek37CXqxPDYb2jOYK4mCNsV1eQIFcFlVNSkXiu0rHPW9OuFwrreWbPPBnOIjiEnkoFtG+0
 0dEzUXJVKVcbBglnMhFWi2KcIQt9T/mkYB0NNA91UGdumuBZIFFAL+EK0nYn3mzIhTg5dWHxzuR
 DQmDGH/X5ct8wfxhe8yi/IDzSGNn8V/zHvOOwrMCcrRAVNtLUI0IE7NP390pfrbSt5jqcrcq+L6
 pgCXkEf+PmiLw/GfqjjS9rfb8LpAujU7HoKaj1rkdrMwGa+JmsIq3mnv4LrUC+exNlXupU/viNE
 aYXq/8rBw8TZVUP+rzYxi8YLlqvxcYMiq3CYohcSeGWDQ1d1e+rQ9dGvw2qNIYnt32DRd8IW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam
 score=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1011
 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 phishscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507090174

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


