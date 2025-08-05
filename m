Return-Path: <linux-kernel+bounces-756978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D8EB1BBB9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEF88188DB3A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4931257AC6;
	Tue,  5 Aug 2025 21:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="Y7Fo5DAi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="gISrbO0w"
Received: from mx0b-00273201.pphosted.com (mx0b-00273201.pphosted.com [67.231.152.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E0923C511;
	Tue,  5 Aug 2025 21:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754428624; cv=fail; b=enJ/edqjyDr5sPB3S1OIlwn+TshpCvvRGI7sklA8EKRLRN1TNb2DDJy7Gzn9tdMxvlQFHhSSpESFKhRld3lEmq4kAvG4LnE297IIDsbgjtWor95nCRzfdIiVB9hRe9c9t7gpLQ4tHtsCoD1Lffre33svWVgPeOl5atA0p7ZsW2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754428624; c=relaxed/simple;
	bh=BW5dSoVmX+UOMmvCHgT+jKaErlHJOETw0SoS4N2VpLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXIwn2a/e7v6kXsAIuvFEPMOiJ628qwOlA00IYIcOs1hTOpjF5GWYVi4s3PzF2iHzUCJSQgYgPRTXrWCjCLPAAgyGAoyBELKU9dY8w4ASP6qr/Zq+L2Zema4bFkmxgR1cBlHCoPy+GTf2e5CW5b+gd2y263INqVFbSijvzYIuek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=Y7Fo5DAi; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=gISrbO0w reason="key not found in DNS"; arc=fail smtp.client-ip=67.231.152.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108162.ppops.net [127.0.0.1])
	by mx0b-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575I99w0014567;
	Tue, 5 Aug 2025 14:16:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS1017; bh=2Y
	L8G6hBHkrzO8XvEHyXjN6M3ipMhoRUM91lxT8rL+g=; b=Y7Fo5DAiRAugLSr/HP
	q8jb8HpNLdcDkcFFOk7XVfbCkHQjSREAqGq6kOlDUP808ZmU7hEO/S51/DMaOm4K
	PpfYXYmsROV0qLtbt0hfsGjJGhv9FTCWDUyH29xucz8uJfVact1nRt2X4hiq9HLz
	MxG2/so7puLZgLviFl8opNYrkVsGHW2SqMoerEMGsRZff9TKZLSVFrkyJvrmeVb4
	zaGOqgc5hcs8Vp9520Sndd4iVWwur9UBlfC4sclb028YMyOcxOK+63iX98RCAeEr
	xOKDdl1VGqU1f/K5eiSsGaOlwpaRz69M82/vsK4df29UwLlLQCTE/u2ohA8tc0Qk
	QGPg==
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazon11021109.outbound.protection.outlook.com [40.93.199.109])
	by mx0b-00273201.pphosted.com (PPS) with ESMTPS id 48bq008e7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 14:16:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJg8JQacoigiF9e+hjW6el+0e83ic1beeMVsLiRhZtNO4/JMMq2Kt8gxc3rzjgvgCgh7DCqvjgCG2129DKLPtdfH2tJgS2WAl+UiN/Mdk3672MSv2L8hHYwNsBD6IMVoo7icvSgD6F1CjbE60cblx/hrtjDtQw4kt3ZH+y5v5meYCEeRRTBzPRic2Z/D+MfUQZFhygGnxF4yeR6l7lwoC3nKwoXOfTHW+T7gwkZZoFwEfhwoMyVW5YYUKIzA+jRK8EYmqQO0yqDpMDAvpCMUYti3nCjQOr+rvG3xWuITmbrgrbnxOAaIh3O0WxZag9iU+eF4toOK23l4RjMPl5KUEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YL8G6hBHkrzO8XvEHyXjN6M3ipMhoRUM91lxT8rL+g=;
 b=dkT3NESUzYW3BDp23h5lhy6ybmP4HKLV6/3i+/+C2F+n4zTKNxgOx8DjYpE81FDL6buf3Q5Uakr3VFKf/PnE5htYK3HWQCiyjFeyClUKYJiEHad76hUBtD5iaqPtp31NW4+PNVAgplyxRBdzyc9B5Y33Fk/awPjdqPpSQIQfRHUNiyNA8WM7on/06SM6+oYQOeywjWW3pI3VFwQ9WsmsNQhQAJrId+G1LgisqIFBg6Z7pjWhDqowXVxSOBH1noJHl7OvX4yc3lh4RaNJQ2LlSkP75umjEGi+EqAt7Y3pPQUiVH0zaEbmYt4mt87tNczezZypjyaXUZOhJxnYAt59Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 66.129.239.14) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=juniper.net; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=juniper.net; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YL8G6hBHkrzO8XvEHyXjN6M3ipMhoRUM91lxT8rL+g=;
 b=gISrbO0wq0CORmC5PYmScSAVJfqq4uIdPGChQ4DMu/bPbHrUK8/uTzDfzGErjTMwbt4MFyg7RMldvNpbTV/2Tm1wjepxSkABLZlC1DRYtl+GjAer11Z5ufNJ2nNWjlDx/fo38nSVxCvEjUL8EblCIAkEps85y96kNTb4xBNWi5c=
Received: from DM5PR08CA0058.namprd08.prod.outlook.com (2603:10b6:4:60::47) by
 CO6PR05MB7778.namprd05.prod.outlook.com (2603:10b6:5:352::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.13; Tue, 5 Aug 2025 21:16:04 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:4:60:cafe::23) by DM5PR08CA0058.outlook.office365.com
 (2603:10b6:4:60::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.14 via Frontend Transport; Tue,
 5 Aug 2025 21:16:04 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 66.129.239.14) smtp.mailfrom=juniper.net; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=juniper.net;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 juniper.net discourages use of 66.129.239.14 as permitted sender)
Received: from p-exchfe-eqx-01.jnpr.net (66.129.239.14) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.0 via Frontend Transport; Tue, 5 Aug 2025 21:16:04 +0000
Received: from p-exchbe-eqx-02.jnpr.net (10.104.9.15) by
 p-exchfe-eqx-01.jnpr.net (10.104.9.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 5 Aug 2025 16:16:03 -0500
Received: from p-mailhub01.juniper.net (10.104.20.6) by
 p-exchbe-eqx-02.jnpr.net (10.104.9.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 5 Aug 2025 16:16:03 -0500
Received: from buildcontainer.juniper.net (qnc-bas-srv028d.juniper.net [10.46.0.24])
	by p-mailhub01.juniper.net (8.14.4/8.11.3) with ESMTP id 575LFxLW001612;
	Tue, 5 Aug 2025 14:16:02 -0700
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
Subject: [PATCH v2 1/2] kexec: Add KEXEC_FILE_NO_CMA as a legal flag
Date: Tue, 5 Aug 2025 14:15:26 -0700
Message-ID: <20250805211527.122367-2-makb@juniper.net>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|CO6PR05MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: 25fcec87-378d-481b-136c-08ddd465496c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e0lNXYn68gPbgetAgKxsO2jy34Ujez+eNCvN81UVoKklKWEsLJjVMJMIsHLn?=
 =?us-ascii?Q?V0JHtZSIuHkmEB8iCmkp//rCy67kcmLnhxWiCONNvCOSv85clxUrWYsBCx/S?=
 =?us-ascii?Q?i/JHYsZUbJDCKnYw5bFJ/TFQR4L4NVS1PlRTNhBqrBTEY6/pFydlwEWTiky0?=
 =?us-ascii?Q?0eG/AwQk1iCIHNaL9K1SS97XDLF9pilF12dguBCrCwmLJtcG/ZEpN62CEYvW?=
 =?us-ascii?Q?+xNwiSCdcyro5WH5uvIse+8766l4g6+Y50Qa663cTV1r/69+0RWHnFAuu9Pt?=
 =?us-ascii?Q?TXUGuss6O+HjZUYh9QIoBWPSmMOUsBBvRhI5wAz9mXtvJDIZD1OKdaMV72qs?=
 =?us-ascii?Q?O8RVNhY7Cm+YAg4eLRCkEIXvlEYxwrFtxgtfc0SE1rFrPbuxRW53u2c6i39/?=
 =?us-ascii?Q?e5h6JHt3eiBkUxr5aDs4Fuag/NA7qNz76QVKa6oZ2ZPWtYOjsndKcsxf4qb0?=
 =?us-ascii?Q?wlBCpNpeYPyITt46tgUtEfPMD+deTgurXG/NPEmWQqZ+MTQvKtNswX3H3Rkd?=
 =?us-ascii?Q?5XCdh2juBaddDw9ImLWnphL5GMBGiqiWAA5EELofaa2FuMZ6n/1wnzDljei+?=
 =?us-ascii?Q?3Q6w8d10gfDsIlMx/hdKDFGzwGJxT8QoEfAqpdZqQK2dQwLlpBirxSZIGbu8?=
 =?us-ascii?Q?vcOq9Y9r5St/Hz9qoC1kXLXzC5gHrzN+LPz6NGzUE0jy/dwVDIz0xzopUsg3?=
 =?us-ascii?Q?rPSADKkId2L6bQ/XBDUHOr1AH0M82+RC+/ufFlbaLm8IGxjA39cY+ow/Ii1v?=
 =?us-ascii?Q?Ys4WuTOpPdgFMivRETx29SRb/YuCcFrZqWdDm2czTsyQY3L25BUzX9PJK+JY?=
 =?us-ascii?Q?fFUqn47VCGvSxoyoEFNOnsTHnm64w13ijf1acNmIEeoLgJQNeRQhtqnNx3Iw?=
 =?us-ascii?Q?Lhu1oRUE3QqCQ72iwsSQSxXZ9QjXbt5QtGaj4UqN/alr1u/F4DDNo+MdMmjX?=
 =?us-ascii?Q?6SdrbOot7lZHXNNPGgY354gZKbB1M1r66jfZtVSjKd04xnkfLAUQ186HMXUz?=
 =?us-ascii?Q?EwN3/qodRPsvI2dL4f8qYZvM8sE11mS6FXavoxRfVFcwsoJIyg5jD7ZMtX9U?=
 =?us-ascii?Q?oDbt3T8iZJpG5heb/YpbCSYRJFS5/bbtUcURD1lpuEg7ccokZ45hnKg/IAsE?=
 =?us-ascii?Q?KEZ/7oUNbcePmD3PRy8zBP1DjR2G3EPUkgsWphvsdVOWqZgauUMdcDq7A5Hj?=
 =?us-ascii?Q?xIP4Q1NkhwnI2i5og35Z5TIAPC486kqIGQEovG75d9qwdPosXYOXJ8C1xH9s?=
 =?us-ascii?Q?1qm1V3bdfncByO4ejGhvYteOd0KGxIEw3I4Kqq1OioHm4WteJI2jvjyZfZn3?=
 =?us-ascii?Q?6pEfHAOqeT1JZPFoIzBP2ZOxDfdNAqClItymLRLRLqrXXxq2YjdA373ovvS5?=
 =?us-ascii?Q?Z220n/qJt5v+UPxLTecPmB7742kUmNZzIJs7Hnx9sUGrjjsbF5zpDe4BfOoi?=
 =?us-ascii?Q?Uuqmzyfhj/CD04OjaCJWQKHCHzPxrqMWXNgUh9MCws1LyZ6/RYc8ldqYBpEC?=
 =?us-ascii?Q?s2fVX1pefTF2COP2xNNrykvj65SVlRPjafwVj3o6+QzGeEwS9SzBHYkNiA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:66.129.239.14;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:p-exchfe-eqx-01.jnpr.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 21:16:04.3938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fcec87-378d-481b-136c-08ddd465496c
X-MS-Exchange-CrossTenant-Id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bea78b3c-4cdb-4130-854a-1d193232e5f4;Ip=[66.129.239.14];Helo=[p-exchfe-eqx-01.jnpr.net]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR05MB7778
X-Proofpoint-GUID: 94V3hk8oSHPNNfvNkxJ-6bVDOY2oZb3n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDE1MCBTYWx0ZWRfXxa/FddkqTXOa
 5OaFaUGZeS+D3Wz4sPIz3Ud65zgF5YbRlz+HWCXv47hYr8E3gU0vT/K38RZzXRVRBWxT8W6YINo
 CZP2nhLSvX4sDkWfk0mP+VRC+fzrtSZhUhh3yGL1RT1VQeqf8NncEv2c++HUf1ZP5HxnTQ8ferH
 wcz26uFAHeNIS9lxoFaXY5MzeLyJXHUkkp//9iHfQ8aW3bOQd8bNpkH4S5jFQSeoy/u3Y8HbGa5
 tY1Q+zcROF1a1NkxqBmbuQ4qlDkeqO08iHdIoqd1ZUbCMoehLnoXsaw2uY7ZVMF/FzmfHg/19vg
 Ijlqn8rXpwKN9CtgTYAvCEXa9ul7NOGyE/WLTmyc0aBZqn13x/fUkDRf5gWaQWFd1sc8t84gmGX
 /IjSzPSE4IFP0gGhHiiwUvBOUAYHcmuvVtAZzEONNoJ40cCbQ6hT3t7YdtXQW7kJJ1xdBiMY
X-Authority-Analysis: v=2.4 cv=aoiyCTZV c=1 sm=1 tr=0 ts=68927497 cx=c_pps
 a=9c8FoEJc7oVTurgRVAnTEA==:117 a=f/rncuQqEjTEF/G1odkJ9w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=2OwXVqhp2XgA:10 a=s63m1ICgrNkA:10 a=rhJc5-LppCAA:10 a=OUXY8nFuAAAA:8
 a=dIESPa_uRpZuTktfA0UA:9 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-ORIG-GUID: 94V3hk8oSHPNNfvNkxJ-6bVDOY2oZb3n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam
 score=0 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1011 priorityscore=1501 mlxscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508050150

Commit 07d24902977e ("kexec: enable CMA based contiguous allocation")
introduces logic to use CMA-based allocation in kexec by default. As
part of the changes, it introduces a kexec_file_load flag to disable the
use of CMA allocations from userspace. However, this flag is broken
since it is missing from the list of legal flags for kexec_file_load.
kexec_file_load returns EINVAL when attempting to use the flag.

Fix this by adding the KEXEC_FILE_NO_CMA flag to the list of legal flags
for kexec_file_load.

Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
Signed-off-by: Brian Mak <makb@juniper.net>
---
 include/linux/kexec.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 1b10a5d84b68..39fe3e6cd282 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -460,7 +460,8 @@ bool kexec_load_permitted(int kexec_image_type);
 
 /* List of defined/legal kexec file flags */
 #define KEXEC_FILE_FLAGS	(KEXEC_FILE_UNLOAD | KEXEC_FILE_ON_CRASH | \
-				 KEXEC_FILE_NO_INITRAMFS | KEXEC_FILE_DEBUG)
+				 KEXEC_FILE_NO_INITRAMFS | KEXEC_FILE_DEBUG | \
+				 KEXEC_FILE_NO_CMA)
 
 /* flag to track if kexec reboot is in progress */
 extern bool kexec_in_progress;
-- 
2.25.1


