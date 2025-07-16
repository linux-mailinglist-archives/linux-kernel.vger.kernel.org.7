Return-Path: <linux-kernel+bounces-734033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FEBB07C32
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4E24A1D00
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186942F7D04;
	Wed, 16 Jul 2025 17:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JvnXWQM3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LyxT1BXR"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3222F7CE9
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752687536; cv=fail; b=GxH5QnxamIDnDlxX9nFN2Zr2RZUVpeAl/2S18jYKzxF3Asu+L9McFgJg5PjXTI05fYwe0dAvOqXRFeTprRVZGDaOAq+bZxlCChaAU/wkxNgz7yMgOtHNv/PhWXHGgPkT/xp67x9lkkDGOxYBUTy6A/3hj69hpiz0nHBCzSAnABY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752687536; c=relaxed/simple;
	bh=znzlEWZPyJwxNWenksENFonZ0Fo4LTEetb9bu6MwdRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X6DWkGzLqAmkZzcgIye1eecOuzGbdx0D1vYcu4HW+2QWJMcszUWI5BZkiiPioBaYLr7ipx4ep3Y1eYNsh6ezFHaDcUdkChkm9ub2GPOC6jIIpoTAx3SftJpSRAmNI38tiUvv6mT0gUxOTbVrkc9rEZIit7liRfi4YlVz6SfGC2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JvnXWQM3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LyxT1BXR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GFqULD025004;
	Wed, 16 Jul 2025 17:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=E7kf82FZ9aIQjKp7NwN7L58S0yx0X5u3kX5n1JmjkyU=; b=
	JvnXWQM3PJaK1bJ1RGvsJxEvzchY+AhU9TT3ruzLIITJoLlE/R4NDVO3CiXrY8oo
	SopPyef85PPzEy4OdcBXuPwUqAN3nRzLruNddAAl3aNyrAuejHZ6eoF36cJjIPOx
	Gz4tTwwTySieJbmh43AhAevT81IQv2aLr9M4Sy/YVcwZ7toJz29wsB6Q9EKfkyc6
	vYnP61FK40u6Lqs98YOBpuw/L3rHT9KtqTIvmCamsTJl8kNdIW7vI36QnZNsxZ98
	/l1HHpvLczSrhN5p5FnxPO+0sfc85r/3Sn8hycC9XAyi88gh8G0yacCFixglpioR
	PkvYKL2bu5abr5Tvj8YEjA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx81nt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 17:38:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56GGnY0o030328;
	Wed, 16 Jul 2025 17:38:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5bmbhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 17:38:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4xh8E3XiP/Ahs5p12rYZqgs1PzDIAwilhO5+sLHkuP9htY/lXy8cpb4pLSJ86iuxwdCx7wkC7frXqa5iryCxUQuPCm2x8eCzt+v4apaoQrCuaNkbUKhSMtwv38uNsIGZkGNZWbVSP1FowNPIe3S/7cDmaLAwdHdSct3p7RE8w9Vu50j82LNy0H1YyoXkEvdHLYiGlJN/DIMJnqgr0CQO20Vgn9vYKRqGxfG4W4PEVkzKDRMqijHF7Ji+0wg3ttyFzsEMZnXCAvhbQyXLJhKgEg6MHJ2oaoA3jWkqJU3WCvwj7o5ttGkYmWT1WHkDWLKABpbyIqdCfdO5P5T83bJ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7kf82FZ9aIQjKp7NwN7L58S0yx0X5u3kX5n1JmjkyU=;
 b=ASYy0gXTBQy528ZGJ6eSAAGwRENkAB5Ro2qBjwwgGmf/w7CDHOQIHO7iphWfRqjO0tvS8YHqfoAQUNHUoc8Ps5fDfHj+XQQbPEh9Y+z9dsd4z9oLhqZrPOZxrZpNFVpnZGvw+xtuP/+MrNWBso1/BM9n8g+lhlXxCEugsnCsU/tu7ed3BvvI2TEXEr7Drl2tRpWL07wO8pehrcNtEIbG1+Vq6BEKPkeFayeacQMfaWcb9O5+Vo/hLowEdGGapw0dkZoxMwZcbZFk3DNH4iRdZl7CdUfxTilAXqnLx1mCLQRQUEB0tfvPsML5W17enUCJpOS9POU9PqE3wJnVdFrUEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7kf82FZ9aIQjKp7NwN7L58S0yx0X5u3kX5n1JmjkyU=;
 b=LyxT1BXR9pCi81UeQnBEea5weblfLCe7Hf1h/hm9dYy5cmT1S61/UaGaAMeQLFxJMtwmSCatlFd1TMWJUyi8DgqSBcuQRHNbMi7hDJ2qZSL6KFtflFGXpIAg8ZxKhpuaVrVRLW45iMi5/USdiHlCQ6lMpyWUumsBnmzrJCEZ8gk=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by SA1PR10MB7683.namprd10.prod.outlook.com (2603:10b6:806:386::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Wed, 16 Jul
 2025 17:38:39 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.8901.036; Wed, 16 Jul 2025
 17:38:38 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v3 4/5] mm/mseal: Simplify and rename VMA gap check
Date: Wed, 16 Jul 2025 18:38:05 +0100
Message-ID: <f4dda4c4840c69b2ea735bcb6d54ae70d527a48a.1752687069.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0007.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::14) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|SA1PR10MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ed87a5-2702-4646-b597-08ddc48f98e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QKAoHXU8OetPvy9haFxlsSreakA36cz09CMdy9RaM/KKWfXK3EYP9pH95lxY?=
 =?us-ascii?Q?qdvJR5+JS5uWnF2XBrQ3jxicotdHuJNVL5QuQnVA7Fu1mbBH3YQWNnhxf12a?=
 =?us-ascii?Q?PQ0+pWaNBDXGzRCtaWs8aqPvG105MHXjo1/MfdImwSFbu9vvdbuP3D2o3pWk?=
 =?us-ascii?Q?vTb5nH+5NBA/4+GWMTbc+vf60njyv0vngkAj2hUPlV7dslE1+smDGQYOeZ60?=
 =?us-ascii?Q?cUBzobm15wf2FW79XwO+53sTiAOhJfu1mqQ0nzgjTDsjsn9KZF3WGQHUzqsr?=
 =?us-ascii?Q?wGp2uL/htchmE4e1ZhoX8Le/9VIjD0Ns0BvQoivu+DOnkIi8U9jPf3f+rBYG?=
 =?us-ascii?Q?oAx7kcqQZRhUy1mGrNe4PBIZHr1jQWOU2VvNaOp9idVhqVO4Lvr4GvjHdFda?=
 =?us-ascii?Q?pzYJKtU7R5jCnDO/v0br2ZNe7E65NebAHf+6GDzQGxyxi8Qk3NbKLbtO3V1T?=
 =?us-ascii?Q?g6AE2ipJRm2/74kp6Fbr/OH1Sqb6oo6zZTvTV6bG3IHSeD1t6GG1Go1YLgud?=
 =?us-ascii?Q?MVusKCpbEVybuluycUyof8xhD6UHh+qMK2UbQtmxx0ngiHhF0dVpubN+SFE5?=
 =?us-ascii?Q?v6RJFOSZ8vJD4ptXVLRPO76BoR8NDtYEoHE+Yp7l1x6X0qxMHUsKaG7QpoR4?=
 =?us-ascii?Q?yrME7XLj5HDYBGq/SJhzf0/y2pu/3RAWTBF1zTqvAcZEik40hjVqVJ5milCF?=
 =?us-ascii?Q?wmyNBI1+R2BZvVdPB8DhwsNZcouj9cpqOROSdyf8HysFRRnujPg1GlDsJri/?=
 =?us-ascii?Q?1NPzXjF6k5Comeb1wZK9lkhmhg3ejJnvA0L4x34JMUTfs1jdxHoOaPufQ8r1?=
 =?us-ascii?Q?U9dHLqV2ukCVQGOFBJ74Zp+bQO6yBOSeNKKn/7fnLw3bkKz1ianbiHg3dxWd?=
 =?us-ascii?Q?KQD30kvX6ZFnCA7ybGEmgQOCmOnS2P+IEW7ClTcLjOziwpMuPxfd3wBmXIcF?=
 =?us-ascii?Q?Cske7BeqB3encVPYGaq18Ecvbfmc7nBp2I29kOFKo/IuX4jNxVi9CGyc12pP?=
 =?us-ascii?Q?lNHBXZCRfoph0pfcpH4tjG8UtGKfSKT2aupc13R+64lrOy//bCYtfS6g9TKB?=
 =?us-ascii?Q?sOo6G2BydfAbsSfrr+uMpwNAgrqTLkAtaHhNQxf3wdr5DH+gC/J3J2/R04M8?=
 =?us-ascii?Q?I7UjWowV3DZPWfookyzNAkmE+BCHjptMLddnIC6wgpyt7EDrtKxr5P8Oatfv?=
 =?us-ascii?Q?2A5gfdKw62q/JYpFko6o58VVlMdz/NOGtUBnu6dYHPYoAnetI38any8Dj2vX?=
 =?us-ascii?Q?IKy/VCnYYu0hil66WaERvDc9gxFfQc6NBX7nuPr8em4KsL7M0h+kDgJ2/WtQ?=
 =?us-ascii?Q?3qiL+hpaSnUbsWk1yF67GCf02SCUHKcA6dOhTnO7Dp+EQFAPEJEBM2cTx+Xf?=
 =?us-ascii?Q?Z8jbm1oO1bvmHrG8WfOVqYCKLE83Auz1buy1mE+E1DXQ2ELH+m8TsGRMku7Y?=
 =?us-ascii?Q?xs2dBV/MZ7s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xEkEbU5x72NODVLljR9oSkvxp2k9+huFY1gsF6WuwzSmsJ7eqiLRmENb0J8F?=
 =?us-ascii?Q?Srt0mRI80bXcnPHhCpTemoEqu82dRW5IkRtyXfLZvxmWPSyEVMlioLPelMdM?=
 =?us-ascii?Q?jdEp0NVMVFDXOr+fZUfvX2UiVYLp1ArheMPguR2+oQd/k9bWap/gdlFOPzzy?=
 =?us-ascii?Q?KoM2vvVJRA1ZY0qTA+/KG5VTXSVdk4ZEMX0M2+bbol4D7TslJjk5yuzlPnfp?=
 =?us-ascii?Q?tpKA6LEve4tFz7LiH+Hdsd0nNtER0+nfhv/BM7NxPT0QuqMVTsTH5KdTmANO?=
 =?us-ascii?Q?/3FiHFdqC92hjK4vwQvxzH79yw0+oUabefF6xiWUyRDouJtNTH1rL+T4IMMk?=
 =?us-ascii?Q?sIrh9KwOE7NPwYCUY++02TaXPi6RA6d2LSWD3/r0P0ny1ojHzdi1uRHp1s0J?=
 =?us-ascii?Q?Azg+IJ7Do97cxf5r6G/4dnYEbicn4qtBAll20IKqFdx+vqOuqh0V/17hty3i?=
 =?us-ascii?Q?yX2IBVAWoDTfjtQMj5eO4X0ehxh3RUx62wPLxBVAYiHpWZUhBJlZ3nhMbvtW?=
 =?us-ascii?Q?AAimBwa9k2ZA/7RGFPI5ocIHydW4nc77VaZIgUYWYFzOtnEkhf/3OW0dZ4vA?=
 =?us-ascii?Q?YImtxKnsP+HEHyaghdGN5a8ieIPrFgweorg/KzouQv1MFGjXLOxzpGyuZSx+?=
 =?us-ascii?Q?IjyApw0do0fI3pPni9KC8MbG8tMVOHqBolqxyXYZCyqI6xPP6FhtlXD2aeC0?=
 =?us-ascii?Q?GWlKXVmBuR/yMOEo3uUpmiDY1Fw+DBIivk6uwWdSeaz3Gue+lmD1MFPude52?=
 =?us-ascii?Q?lR1D0vW7j//LKDOslyugE805VXPG1vYl3wt5ZXlk+yHmbvALYW/0QtW/j7OU?=
 =?us-ascii?Q?C252lEQxwMoePbSRVTsW1OC6ldR3daNhhlStI1WoLPHg+y1wKQhg4veoMicK?=
 =?us-ascii?Q?HM1/1ollVyEe7S6rMtnb7hjhlmoq2PESyecVW13P8/nivmquxEfmcw41RYp8?=
 =?us-ascii?Q?h5QPPLtWJ5wfTY6WQ2KYK0DoIiNgmRv7WX7RQhaIAnWNb3xW1SQuVmFJmGCW?=
 =?us-ascii?Q?zIFsUk/RtkRvRAPpwjsEd6gEVMBnMB2Zo+vUn2zPU6HJgOoViD+cQNn2Html?=
 =?us-ascii?Q?v8ATnUHuLtL7CcbGcI6n1U6juOOQRbAfy55WAhkaz5tDDBHnL0UzMBe3oNIK?=
 =?us-ascii?Q?hJrUYWuanwC0zwTkYvUGcGZAA9Il9HaRSW5eJurMmuCLuF/XlzW0iutxSHIy?=
 =?us-ascii?Q?VPP49iNOXX1+Z+gqH7aqeytBYxua6XC+wh/usuwkeyObyb7SeEl1w0ipXT9o?=
 =?us-ascii?Q?RuqAAqTbpiKq83Y4C2EeK74TZ+XCukkRus7jFO0KB5hJRPDxfP+Nc8CLuC+y?=
 =?us-ascii?Q?l00DDulKrbVAEGK89V2l2eWykgQSFTymUZLL90wcnM9Mt/gbqyTpsBpUkgG6?=
 =?us-ascii?Q?q7xcFQlFlLfhsQO8npIaxSbDjE7llQQPLgWRajIOA1C60Bbch6OBxUXBVqrf?=
 =?us-ascii?Q?hABIo4cu78DmUQkW2pHxSprs/9XkMnmlZ67QgEEeAeGBgJ7X1MdLtKbbR5pR?=
 =?us-ascii?Q?Ya1V8ziiLXY9vJwRNQT95QHFZBfyjbMl6atrjNXBTAxc3WHgh+3lCivnRkj1?=
 =?us-ascii?Q?mLmHDM5yVZ3dXtyd5TtkEsGf4Yrjw25k766pTpnlvhq4cSGRWn8Muj3nitQJ?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cKMHylhL9DKbZUglfU3/njx4jGqVCY6XhxEcKEOfZde4pmbmxdlStFl23bEYaCAo4ASSN6RDTXNFl4kx282G1otPB6qeOl4tob+YPeQrM2TTqinpK+RFdrcwCiLsTYKK5JKiCmg0IQBVPTqNn4PPbN9hdPW66gL+g4uC/3GGoPCk1lgyess72Nxv3/bCr6/lcrcEAz7Qda9Fhe11k/RlWa5hq1IdJCi7YWPTxkR9busWny7upKGs5laSdWbS8J4EQtriRjK8ccuJlWyEhf6XUeVYMYXm5R9TsUOCnRptKObnPasBQbMiszute45adpmOthpwbYFj2hhO04mdFPDokghzDFdos2HfspHaNR0e7YMqquKVFuqkXF1EPjQKbDX96UCeRfBubREBi8V1AG6CTl/y0jW4wAeW/sAYNdSLODDUMVHFmlW9wIYTQ+jG77AKIw0wkUC+bFTIq4p78MBqH2DlVKsg+4FK1U/bwtyYPYotDkQkKdb3PgfkmaTR/ERsYUJsAdmc2tQvr17uxmeujIP/7/YpedbkH4VgwYd7UWh+sT+HSaHsQtktzKaYpfX0XMTMZ/mWoRb/Gs/dokEh+SSfvDHtHRcCA8uDYFrHDxA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ed87a5-2702-4646-b597-08ddc48f98e5
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 17:38:38.1435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y3/MnzTCYvi/uX9lkzLhL01FdJMrUTsHQ3PnxsKsFUC9dEJGlbERCIZB/5Deks1+FUkdC00tshJeBPe+09Q1Llp15I3FcMxJcsqTgfpDznY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_03,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507160159
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=6877e3a3 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=qMmrSB22KtVtcMM35qUA:9
X-Proofpoint-ORIG-GUID: 74isZJNjUzv9FGVUiUrr5YXT4kycGjFz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE1OSBTYWx0ZWRfXy4QGDOGylPOH t+nBkAlusrYZPqZ7sIP6w9adbi2hWYd2GERQWhFAeYKWuUVuBhi/30jXB5U8BVbGAfwelyqSE3r pwSH6SYwfg5H+Xt4E2t+Nl5aHYzfcWoSefQwVoyLm9Mq/ztGYzQN9JOLqM0noCiIK1DpPYkOk4T
 LOw6RgSFj3Nd/v/TUmPbeeU57CLCt4KyDEmfv4buCClJBDcPeAmAZFf2mg2EJUTO49lsb28BD0t LXbhP0XIlp7HlRO250UVcjOOUYpRkFJLB5BKE+lp9XDSj9VwzyfZ/zP8P7YOej3BA/Qr0HBMApQ MQXN/RW93hOPQRtFaZLO9O3Ao2O7vA8ZvPisWmWPlntC2TpOX78BRmPzI8TZdDf5gIohq9orRNG
 ZLCG7ASZPnsjPLvHJOvQuVY447k/40CL0tJser6csXJzAYzzoUjVENVTyGUfwUkAYy00QWXF
X-Proofpoint-GUID: 74isZJNjUzv9FGVUiUrr5YXT4kycGjFz

The check_mm_seal() function is doing something general - checking whether
a range contains only VMAs (or rather that it does NOT contain any
unmapped regions).

So rename this function to range_contains_unmapped().

Additionally simplify the logic, we are simply checking whether the last
vma->vm_end has either a VMA starting after it or ends before the end
parameter.

This check is rather dubious, so it is sensible to keep it local to
mm/mseal.c as at a later stage it may be removed, and we don't want any
other mm code to perform such a check.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/mseal.c | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/mm/mseal.c b/mm/mseal.c
index adbcc65e9660..61c07b1369cb 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -37,32 +37,22 @@ static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return ret;
 }
 
-/*
- * Check for do_mseal:
- * 1> start is part of a valid vma.
- * 2> end is part of a valid vma.
- * 3> No gap (unallocated address) between start and end.
- * 4> map is sealable.
- */
-static int check_mm_seal(unsigned long start, unsigned long end)
+/* Does the [start, end) range contain any unmapped memory? */
+static bool range_contains_unmapped(struct mm_struct *mm,
+		unsigned long start, unsigned long end)
 {
 	struct vm_area_struct *vma;
-	unsigned long nstart = start;
+	unsigned long prev_end = start;
 	VMA_ITERATOR(vmi, current->mm, start);
 
-	/* going through each vma to check. */
 	for_each_vma_range(vmi, vma, end) {
-		if (vma->vm_start > nstart)
-			/* unallocated memory found. */
-			return -ENOMEM;
-
-		if (vma->vm_end >= end)
-			return 0;
+		if (vma->vm_start > prev_end)
+			return true;
 
-		nstart = vma->vm_end;
+		prev_end = vma->vm_end;
 	}
 
-	return -ENOMEM;
+	return prev_end < end;
 }
 
 /*
@@ -184,14 +174,10 @@ int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 
-	/*
-	 * First pass, this helps to avoid
-	 * partial sealing in case of error in input address range,
-	 * e.g. ENOMEM error.
-	 */
-	ret = check_mm_seal(start, end);
-	if (ret)
+	if (range_contains_unmapped(mm, start, end)) {
+		ret = -ENOMEM;
 		goto out;
+	}
 
 	/*
 	 * Second pass, this should success, unless there are errors
-- 
2.50.1


