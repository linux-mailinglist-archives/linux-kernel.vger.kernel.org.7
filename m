Return-Path: <linux-kernel+bounces-756976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C48DB1BBB8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB498184069
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B412A2066CF;
	Tue,  5 Aug 2025 21:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="PgUsoIGL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="fKEK14Vr"
Received: from mx0a-00273201.pphosted.com (mx0a-00273201.pphosted.com [208.84.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDED239591;
	Tue,  5 Aug 2025 21:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754428624; cv=fail; b=okOm2yhkzt6ONCB82b0EpvgfHbtfjihQXrXxHv/1oPJs8AXopaNIbDDs0kFHb1cEBtb4Evgc/j1ljUVZzTHk+o+qVKU4w0bRQtVV3oXLFiOXLIWuu+fpFILqN609wWYVi2Y7WvdqGlBGdXzKeJs4AVOCexrnCl6KTwi0MNgBoLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754428624; c=relaxed/simple;
	bh=AGkCxbtYifqVauZb7aUj6+vZ4015cjL+eZCkI2ZXy/Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SB86OTZxk2mRl+h+Ih2esxPZGu/m7drY94XU7w76VTMOH0Hlt+Rt1CjdSEvNPOoklTCKm7xCx6F8FzPpIpV+SPeP/M1/Kd9IQpynpyaRIbOOHDW999UPMobSLWSfETQSXqcIK+OPM/RdakDbJavQ6bXcndQv1TK6YLvR+axk58M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=PgUsoIGL; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=fKEK14Vr reason="key not found in DNS"; arc=fail smtp.client-ip=208.84.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108159.ppops.net [127.0.0.1])
	by mx0a-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575I9eQZ006727;
	Tue, 5 Aug 2025 14:16:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS1017; bh=k0
	C1EW7oyTuOW7TGeV1L2EbJVROxLG4xH/ywpLGykvQ=; b=PgUsoIGLzh4jvfOtaj
	aI9hx46nv60+1gGyt/8LCRLIHHiH9wm0UHgl4ZR2wivmuCYEu+/cOhKEe3EhL8pJ
	pZquAwWB6qGWwST1V2knjHvIXkgF3PVCSD1rzMRLxrhPNIOg5bRO+Tk7n8e5Igiu
	Ih9xOcfvMJtdvDSAGjYAPcP3//t471mM3hcGT5OltctYzq8yX1Imaxo0HnzaDNfe
	p0YF5nspW284jir2R2fhrpJ6Ra/s9RW7vxsx7KdTyzGXXdLmHRysNf/PS3gv9HPM
	qW07PmhYgAxt5XMMg4vswjwQD/O2rmZQXkKpwSsK0ndXs8NblJF9ii3dLiptqsZL
	KZyw==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11020117.outbound.protection.outlook.com [52.101.193.117])
	by mx0a-00273201.pphosted.com (PPS) with ESMTPS id 48bq07rctk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 14:16:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqRBL+e0nRVBERIpjaZUMHOkSe6qoHnDu67/7d+DJzwSbE0DBUta9jCvJYbhsV7eWl2cD1bsN+a9oIjDTOclP+lEGeA6VJSL0yJGqSXx7I7+h/5MKJDIlnfP70vTcbhnPBPqEwoof0oVSHA2/1bOv/myhzgu6JyxvY/IApPUypZ45qzeP5kmkfz+g+cHfGLV0frCKTjfzV1e7P3bjGP/pYvOwJFECUz1Et6FdEJ1zBiDNUD/1sToE/P9eyLfaJglG2GnWpNqkFSXGdEVzZye9hOOVrKKUVkp8Gv1/bXSUrMTTNZW2FX/rDfV3l0+YaOMAIjavHPw8n9SQ5jDLxjDNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0C1EW7oyTuOW7TGeV1L2EbJVROxLG4xH/ywpLGykvQ=;
 b=bdU062Qj215UXNnOh7UkdPoI+1/AkwvVHgJT9mlEK1Aen135tUi42BgDd/mev01E9vIsHlqIOqfRY1LLrQkrFI1SVJhLE8aaSlB9dNXeSbpzNLx09jss/uxOcbqaVF6+lJshFvo6YyZ56KThjE5yWepDAEmgGyiHqztYO5S0N4wmZJQSdCKZR94kcJUnNOQcWb/QLoU1AX/XS6QFLMYS4K3akb57jedw2nnlvgZ1oedc2BTLrStFXnUoNXTyF+R/6Dl+uqwDkxysqPldOs/QiXfT3y0noe47IT1YAo+crcr7NyqEMfhYW69eexD18sRqfnuRzJa0n0BmRk88bHE/mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 66.129.239.15) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=juniper.net; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=juniper.net; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0C1EW7oyTuOW7TGeV1L2EbJVROxLG4xH/ywpLGykvQ=;
 b=fKEK14VrXgbFiwRxshloDDApkQHMciwXWq8aZSaoyIT0AwwM1eIdCjr6XHrQuZfcnb5cr+fW8sTx/Wy/m7uUIB2wHekVVoN+GCgiBY7Iv1U8bli6N+bB1ZZwxNi1SzA0IivpwNW9vbT8w7Q1HDHGgR19dw8WJii/Y6d0ukkKwVY=
Received: from DM5PR07CA0076.namprd07.prod.outlook.com (2603:10b6:4:ad::41) by
 PH0PR05MB10061.namprd05.prod.outlook.com (2603:10b6:510:294::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Tue, 5 Aug
 2025 21:16:05 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::8c) by DM5PR07CA0076.outlook.office365.com
 (2603:10b6:4:ad::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.20 via Frontend Transport; Tue,
 5 Aug 2025 21:16:04 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 66.129.239.15) smtp.mailfrom=juniper.net; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=juniper.net;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 juniper.net discourages use of 66.129.239.15 as permitted sender)
Received: from p-exchfe-eqx-02.jnpr.net (66.129.239.15) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 21:16:04 +0000
Received: from p-exchbe-eqx-02.jnpr.net (10.104.9.15) by
 p-exchfe-eqx-02.jnpr.net (10.104.9.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 5 Aug 2025 16:16:03 -0500
Received: from p-mailhub01.juniper.net (10.104.20.6) by
 p-exchbe-eqx-02.jnpr.net (10.104.9.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 5 Aug 2025 16:16:03 -0500
Received: from buildcontainer.juniper.net (qnc-bas-srv028d.juniper.net [10.46.0.24])
	by p-mailhub01.juniper.net (8.14.4/8.11.3) with ESMTP id 575LFxLX001612;
	Tue, 5 Aug 2025 14:16:03 -0700
	(envelope-from makb@juniper.net)
From: Brian Mak <makb@juniper.net>
To: Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Alexander
 Graf <graf@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen
	<dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew
 Morton <akpm@linux-foundation.org>,
        Rob Herring <robh@kernel.org>, Saravana
 Kannan <saravanak@google.com>,
        <x86@kernel.org>, <kexec@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Brian Mak <makb@juniper.net>
Subject: [PATCH v2 2/2] x86/kexec: Carry forward the boot DTB on kexec
Date: Tue, 5 Aug 2025 14:15:27 -0700
Message-ID: <20250805211527.122367-3-makb@juniper.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250805211527.122367-1-makb@juniper.net>
References: <20250805211527.122367-1-makb@juniper.net>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|PH0PR05MB10061:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b08af6-197a-4dee-a5f5-08ddd465496e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IMBjc6GB3JYYOYIIR7J+ig/noUqUL/0trs9BlWbJZYQMR7cjFtLTlaK3FrKJ?=
 =?us-ascii?Q?yXkIRvf1bg8DXeNfLIAbA/KPazXVeC8CT/XpvkTzsyQy+2Pbwj12DPXhfjar?=
 =?us-ascii?Q?A+8qrK87ja4oz9Rc58Xnbabec+sl/UJZr40dTmvKwg23VekmNSWlScVjrnmX?=
 =?us-ascii?Q?EINU4r+Wh/A5tDwMLjwnD9nmQ+D51n9Uvqz9/266taE5Qxz4LlQiyFuZE4LP?=
 =?us-ascii?Q?Navk+BCbgbv8JKUg8CLOFRcw/ZfHY3wFq5eW42Iqao80fLkjfWzma3N7EwIj?=
 =?us-ascii?Q?srHJjsZ8R2C1vcWXnmPJQkWcT8Xiz8pBkXm2++oGqk9rg+hK1IKfZhVZ1KJF?=
 =?us-ascii?Q?HOX/pzQ+RIFdxKQvN9DO28GJ0HqBb+LzFQSOGfNWe+WMJBxrnZn77zSAl9jO?=
 =?us-ascii?Q?BeWqZnDYhv5HjlCsHYQrsJwlUq+IZseR4fLUsEZ7k3kEyh98tt0H2iPCSZbD?=
 =?us-ascii?Q?L1j6++gLA3Pli3HjtLHdyqrIpX30Sc10L6LMRz2mquXKErLq+g9xqVxh3nBL?=
 =?us-ascii?Q?Gb3+k7sIiU+kk2p0pFjhuZTQRciIxhqfH1+UocEDboT5/bXoShGwmkBjEB2o?=
 =?us-ascii?Q?HOl1Zlj1HJl7oIwpNTMsbkB4VUG3gWKeAp8FOUOsyhLFxRFEGiufdFoSCKln?=
 =?us-ascii?Q?tOSp03eQbrpGiH6j6qnMX/Fwqi5ryN+dPh4fBz1IUA82fqXSySu/gXT75nf+?=
 =?us-ascii?Q?PaLtQGWe4gN8EsqLpiDHywlfHowRX/QxgS/mwX8STn+K9g7rZXBC56L8rqbG?=
 =?us-ascii?Q?DyKose0/kUDKjpBF6FqwTFvlfvRvCpeLK/pTBcMQTxzeYV15S2SFvqpd9uMX?=
 =?us-ascii?Q?8ne5Luu7Cz0PeKz5FqEZ4nAr+GdeBuesE9brY9eHs3KIzQUjgJB5xP30qd0C?=
 =?us-ascii?Q?WhyCK17pZO8vjnwum/ZxgHVjEghZaUH97tvFAlyevftCRZ4VUK7zD3BG3y5P?=
 =?us-ascii?Q?hXZAJT3aZYff1Mlr5HoHt6qmmdvwPgjhyFS25CHou6kOD6zUMqvABMuf4xEc?=
 =?us-ascii?Q?9AQQ6wHLCCF8q8vCbBx5YAsdhtqLXCv1q0a1lwbQG+MOdzf/+xMsn+yfr92M?=
 =?us-ascii?Q?IkbUp19jvc0MzAtYse74+0XipsI0LNuHoH8/zWB0nEYHmyjG9xYtbZdc1iDp?=
 =?us-ascii?Q?RWW+jdhJjJdNH9qaT+LLt09mC2uyGFtJlA5camuEwY0DCcDUXVvTSsPthJ4C?=
 =?us-ascii?Q?MMVI1nEmefi3j0ZquuYPfBpZtrIvHFxnG+0bHPqgUzQWIoqnDu5i00ulmZtX?=
 =?us-ascii?Q?BbOHPkoKmxbwn7leKJB6hFBbw8/VqzxiQAdu8a1YGM1CO6xd2aiEFKu3IXp0?=
 =?us-ascii?Q?+cwt+6UwV1FvZSgCalLdEPP8mGz9XUNh1hBbjtLls8684Bc16Z99ZHHoCQTn?=
 =?us-ascii?Q?/IPilYSyLt5lXxtZEPWaZy/EXbUOvvRSGj6rkcV4wUUNwcRFPcUmUlfpC2+Z?=
 =?us-ascii?Q?zsKwMQEjbJjpjvtgWhKP8l6fbWIm1RzMYrl3JyWyv3d25TKPlrx+qvZC5M3l?=
 =?us-ascii?Q?8fSWsqMlJk2HR65hDjTQL7oU/OP5rfwoy3ePu62J35gc1QWeMXu9JPwFpg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:66.129.239.15;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:p-exchfe-eqx-02.jnpr.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 21:16:04.4344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b08af6-197a-4dee-a5f5-08ddd465496e
X-MS-Exchange-CrossTenant-Id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bea78b3c-4cdb-4130-854a-1d193232e5f4;Ip=[66.129.239.15];Helo=[p-exchfe-eqx-02.jnpr.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB10061
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDE0OSBTYWx0ZWRfXwvln0eMujhJO
 FjeQtGa2STKKiXW3/AgaMzFN+1N+QKulaEiyi3mbaZ7L3MriUInO7ByHjCX2zNiRDwDZys7MI8w
 EUkGmfMJr9HzBZQumgopYbcvo2bIywVqNzmSEizTSFzrFtsLVac2CZVQfT0Mgo9roVy/XB1F4RD
 ZjlOfu8wGlMt8d0BH5Y27AYx8saJHR11aPoPlq76E8c+veUgnHdb3tfjSImVoE9bHVXvHwrx8uS
 rEDmmJ7XJ3AkF0Fe5+ni2h2GvjegQMpcHCnlvnO39hjtFKxtYJTMl8klCCr6leOHSfbqkWjh8zL
 xCjyQo4pTLS3DrxOPj97OyiGMuV4LWbFFFB0qaOuNilvl0I+UXWfrM+4WZhRE6ZLIRb0KkRZksF
 w4A3ldMWk0rxLHM5v+wKielgwlATBXkev9CeV1Gs75sQwEKkZMyo+GwsIpTN/CNDFX8Ot6n4
X-Authority-Analysis: v=2.4 cv=Fp8F/3rq c=1 sm=1 tr=0 ts=68927499 cx=c_pps
 a=AhzfF/YxCie0pcxRiAEGiw==:117 a=YQU41r7WENJiSYrYYNJVsQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=2OwXVqhp2XgA:10 a=s63m1ICgrNkA:10 a=rhJc5-LppCAA:10 a=OUXY8nFuAAAA:8
 a=m8dw7swGO52DeL0zIVoA:9 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-ORIG-GUID: TIcV9axam_iye-lfiidzh3Vfj7h7qFaI
X-Proofpoint-GUID: TIcV9axam_iye-lfiidzh3Vfj7h7qFaI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam
 score=0 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508050149

Currently, the kexec_file_load syscall on x86 does not support passing a
device tree blob to the new kernel. Some embedded x86 systems use device
trees. On these systems, failing to pass a device tree to the new kernel
causes a boot failure.

To add support for this, we copy the behavior of ARM64 and PowerPC and
copy the current boot's device tree blob for use in the new kernel. We
do this on x86 by passing the device tree blob as a setup_data entry in
accordance with the x86 boot protocol.

This behavior is gated behind the KEXEC_FILE_FORCE_DTB flag.

Signed-off-by: Brian Mak <makb@juniper.net>
---
 arch/x86/kernel/kexec-bzimage64.c | 47 +++++++++++++++++++++++++++++--
 include/linux/kexec.h             |  5 +++-
 include/uapi/linux/kexec.h        |  4 +++
 kernel/kexec_file.c               |  1 +
 4 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 24a41f0e0cf1..c3244ac680d1 100644
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
@@ -336,6 +360,17 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 			sizeof(struct efi_setup_data);
 #endif
 
+#ifdef CONFIG_OF_FLATTREE
+	if (image->force_dtb && initial_boot_params) {
+		setup_dtb(params, params_load_addr, setup_data_offset);
+		setup_data_offset += sizeof(struct setup_data) +
+				     fdt_totalsize(initial_boot_params);
+	} else {
+		pr_debug("Not carrying over DTB, force_dtb = %d\n",
+			 image->force_dtb);
+	}
+#endif
+
 	if (IS_ENABLED(CONFIG_IMA_KEXEC)) {
 		/* Setup IMA log buffer state */
 		setup_ima_state(image, params, params_load_addr,
@@ -529,6 +564,12 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 				sizeof(struct setup_data) +
 				RNG_SEED_LENGTH;
 
+#ifdef CONFIG_OF_FLATTREE
+	if (image->force_dtb && initial_boot_params)
+		kbuf.bufsz += sizeof(struct setup_data) +
+			      fdt_totalsize(initial_boot_params);
+#endif
+
 	if (IS_ENABLED(CONFIG_IMA_KEXEC))
 		kbuf.bufsz += sizeof(struct setup_data) +
 			      sizeof(struct ima_setup_data);
@@ -537,7 +578,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 		kbuf.bufsz += sizeof(struct setup_data) +
 			      sizeof(struct kho_data);
 
-	params = kzalloc(kbuf.bufsz, GFP_KERNEL);
+	params = kvzalloc(kbuf.bufsz, GFP_KERNEL);
 	if (!params)
 		return ERR_PTR(-ENOMEM);
 	efi_map_offset = params_cmdline_sz;
@@ -647,7 +688,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	return ldata;
 
 out_free_params:
-	kfree(params);
+	kvfree(params);
 	return ERR_PTR(ret);
 }
 
@@ -659,7 +700,7 @@ static int bzImage64_cleanup(void *loader_data)
 	if (!ldata)
 		return 0;
 
-	kfree(ldata->bootparams_buf);
+	kvfree(ldata->bootparams_buf);
 	ldata->bootparams_buf = NULL;
 
 	return 0;
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 39fe3e6cd282..ff7e231b0485 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -395,6 +395,9 @@ struct kimage {
 
 	/* Information for loading purgatory */
 	struct purgatory_info purgatory_info;
+
+	/* Force carrying over the DTB from the current boot */
+	bool force_dtb;
 #endif
 
 #ifdef CONFIG_CRASH_HOTPLUG
@@ -461,7 +464,7 @@ bool kexec_load_permitted(int kexec_image_type);
 /* List of defined/legal kexec file flags */
 #define KEXEC_FILE_FLAGS	(KEXEC_FILE_UNLOAD | KEXEC_FILE_ON_CRASH | \
 				 KEXEC_FILE_NO_INITRAMFS | KEXEC_FILE_DEBUG | \
-				 KEXEC_FILE_NO_CMA)
+				 KEXEC_FILE_NO_CMA | KEXEC_FILE_FORCE_DTB)
 
 /* flag to track if kexec reboot is in progress */
 extern bool kexec_in_progress;
diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 8958ebfcff94..55749cb0b81d 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -22,12 +22,16 @@
  * KEXEC_FILE_ON_CRASH : Load/unload operation belongs to kdump image.
  * KEXEC_FILE_NO_INITRAMFS : No initramfs is being loaded. Ignore the initrd
  *                           fd field.
+ * KEXEC_FILE_FORCE_DTB : Force carrying over the current boot's DTB to the new
+ *                        kernel on x86. This is already the default behavior on
+ *                        some other architectures, like ARM64 and PowerPC.
  */
 #define KEXEC_FILE_UNLOAD	0x00000001
 #define KEXEC_FILE_ON_CRASH	0x00000002
 #define KEXEC_FILE_NO_INITRAMFS	0x00000004
 #define KEXEC_FILE_DEBUG	0x00000008
 #define KEXEC_FILE_NO_CMA	0x00000010
+#define KEXEC_FILE_FORCE_DTB	0x00000020
 
 /* These values match the ELF architecture values.
  * Unless there is a good reason that should continue to be the case.
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 91d46502a817..eb62a9794242 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -255,6 +255,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	}
 
 	image->no_cma = !!(flags & KEXEC_FILE_NO_CMA);
+	image->force_dtb = flags & KEXEC_FILE_FORCE_DTB;
 
 	if (cmdline_len) {
 		image->cmdline_buf = memdup_user(cmdline_ptr, cmdline_len);
-- 
2.25.1


