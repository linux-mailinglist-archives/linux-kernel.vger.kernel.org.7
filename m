Return-Path: <linux-kernel+bounces-786456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6A8B35A13
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49CCB3602E8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1512BE7D1;
	Tue, 26 Aug 2025 10:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OlcyxUw3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Wt/Mm2TN"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64242BE7B3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 10:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756204134; cv=fail; b=s3qa6m6sD/j5SSeenjFnXep+WJY+uvcrQbXzA5JT91KFhcuVRJwawAxucHugJFA2FPTW1PUwtI5G5tpce0tNFnJITL+t6Uij/TD/eAh+H8ayEY6iMLuW6dUczy/OuH4c7rmB/KivNUuNQFIoLx/b9CIxsWdHtZTCUs/XB6jNHH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756204134; c=relaxed/simple;
	bh=QWyxtE2M0Mphxx8qQMRfBA7KcL42/7as2y8k1pdyOT8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ls87Kq0gOAvTiIGnwhBrqqozzVTXFiqxD6sCtVODxOrLn9pPzGJdhSyT62w5VG7qxCeUoMtzlpM8GDvGNcqPtPmbFXiwd32wOIlxRqiSRNz3zSEvBPfix2YWa6ro+wKHK43pZ3yzijbjHShM+s3WyzfMEpibx7T9awD1NiwYSNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OlcyxUw3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Wt/Mm2TN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q8m0Z5013780;
	Tue, 26 Aug 2025 10:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=z2CXjY7MXXNBPxtm
	sXqM8bOLuUBzSqVQx4Vd9Wk6gyE=; b=OlcyxUw3pGrys8jACjQXc/+K/zevdiMf
	l7M7PpmZEXARQzu+h2ISRKHzuz8AxkHnBWaAnm1U1dQGYUx/2IXzuDG5h9jIRWM9
	Vdx3Qvh8qK+f7TGwoGTCvfmeHNoZjRGacNsHCIuZLJgRUAQjYBKQxWOfjYl76HM2
	lrRnY/FBGXrJVV66uCYQBrPSCWFTWpjQTJ6EtPGSazFyr4UMdlh/TY5frHJwaCad
	2vzLajpW+qEHR6t6Vv5KnvAC6UmsP8TUxZK2S2DHN534+r4cZLUjwMPbkIcd3oIP
	6R90Xfosy/e/iTxbOwOfrMuiQEg95cA0iLIrRhpNmjXdHwepzmGu7Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4e2476h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 10:28:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q8LeuR005107;
	Tue, 26 Aug 2025 10:28:39 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48qj89m6wh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 10:28:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6e2f1THGFVs/Gs7oa5a6fU1jKQMSV1KmL8CdIjRK1PkalGeHfM2Bc/Kzv87rWlexkSGZ/nKTkoeYFB3HPROUXjOURSPk3N9mXfXGS/HC5LwhxwTZ9VFQjrzUkgxbAMQJEwh0/hfWul31exuj1LYCf7snbf5iyAPycfghBdhLyrsc47Q+ufIpXKSQXgiI/w1T7nLQWHiStro04qyRmVKeSr9NOGIiFfvP6en6ULH+1o9awCDO8xeK/Ka3efXvz9oMYbmUql5AP2KTCrZUKaFy/RO2jJRDRb1OE34yQtj7gQMqfP2r5IcwpCKMrbcVV2/COfgrc7q1S0klqCZDKj4zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2CXjY7MXXNBPxtmsXqM8bOLuUBzSqVQx4Vd9Wk6gyE=;
 b=UhHUXl6TOcOWMC79nuMVFkhuNFbGUKCDhqF+fW/0S/WT+PC+ZoIxs9dSXilZ0O0DnRMP2+PRUG+R35qSJY+9qwsXPfKIsJtmXqRV2Omo0GZ0Qgh2lGNhgaqKFIVvTtdacJ441wUzf/YtuHEsz4gziCbyi4Rw+lbw92pCz7FXqvgFOhPTNecvtmJC3Hj4ve9OMumnt/2M1xQkzP+QAPGf/MENd/9fno8j2t4J+4BMMb6RMNe/X4D4dk5/ogmaq/T2vlSlpjJUxuJE+z9WTmhBXM3v5/vxsyRmdYx3VjTyk6IwSaK65oPgtve5DBAev+PTWBUVZvIaOk14KOQbAGABqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2CXjY7MXXNBPxtmsXqM8bOLuUBzSqVQx4Vd9Wk6gyE=;
 b=Wt/Mm2TNbsgOimYbX0Oa25IKt+nkqbqnfJC/FX/3yff/RfLZOFy9nmNq/JUGsYJUzl6jwdT3uuqJ2M/ja4HUm/VLOuDyqM19CZR88MZCPeknLHQ0cNr5kbaYvZ1OD8z/EfFtBXNM4q3RsbopCbBPs/cUUJHt1gwxZ66Ee7m8PxQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB7343.namprd10.prod.outlook.com (2603:10b6:8:fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 10:28:32 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 10:28:32 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, WangYuli <wangyuli@uniontech.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tools/testing/vma: Clean up stubs in vma_internal.h
Date: Tue, 26 Aug 2025 11:28:24 +0100
Message-ID: <20250826102824.22730-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0114.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 12e70b45-7930-4a27-385b-08dde48b4e33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GeWF39leKc7uL7lMHJz/2MTiy3nscBMTaH5kYSCqUNjLczEm3wfbtiHIXgAj?=
 =?us-ascii?Q?b/m+MIIRaDSRIX4GdiqMvfMHgYzzE8p460k56O7zcBZ5WJZtbogcLyKSPgc9?=
 =?us-ascii?Q?DTot1nADmzATMcE7s0FWddAc1GmV6yDTS0A6hLliMAlBwvDBm4x0lNaufcV+?=
 =?us-ascii?Q?GVVmNEOH5NV3QfzsQE1Flw6TnV9Nps9XMrX5wtleQ58g+81giNHjBGC6kc1H?=
 =?us-ascii?Q?ZDMEB9k1lay8PAUIS3IZ3+vK2WcN0UtJjdjf4pR/JF5VV+RlSSNJIBw1TKVI?=
 =?us-ascii?Q?566vkij2XGGZZBvs3kqRrqQ4zwJjGGO1Htb9JuSb2QvYLLw0E9yZXh4vflcb?=
 =?us-ascii?Q?t+7YOTeCICcbDRnCXldDyeCFGVqra4U3LoVLmwjuC/LmLk/Gd0DlccrWhajP?=
 =?us-ascii?Q?bmjMbpkD4oEXw7CTIFSZXEi/4oSoaMGKeHq2AbdaZFo3dn41DsMvUifPTrlD?=
 =?us-ascii?Q?JIebtyGe7Hfbv9K34vNSvlZIIkVpeHHcJyJ0vJYw44rQgA95URzfXjOJ7GOu?=
 =?us-ascii?Q?XZJfOEjeN77Z+1cUFsljaw+NgNNmUAgrrOn7xcfMP++9+l3TdPQsAChToTs7?=
 =?us-ascii?Q?UU0VXO42deVKl+WZUeD/hcvu7rWeVi2ROLQ3Y01oPRuzn0pOgHSJM4+76wis?=
 =?us-ascii?Q?fKlG1tan4j8Oz0bT4rzs9DfFA1+cuxS06BdKVxY0q1H6HZYxEBkEOcz3Muxa?=
 =?us-ascii?Q?04T0kaFd9aKHHU6M4BUfxn8Z/7FNUK8TUSznyAXk9w82PEotKp6TwN0a+ep3?=
 =?us-ascii?Q?/+zojnzcnzZ/6XC9jTkYdGlmkc6378WDsR3pDjBmRiQp7mPI4ovzg5anv+Eq?=
 =?us-ascii?Q?gypEf7I3LX3ob54eqyRqopGAe+rNO5YlaiwM7HEA0k357/SbT1xt+kiV8bx6?=
 =?us-ascii?Q?BoJMi9X3qnqiuFCdRnrfntWew6CvyszA4+rKlLWNdStRb4UkYfunM1ueigVQ?=
 =?us-ascii?Q?rplx+TNVKVa1ca/ZwRx3gkz1qrIxcz0C6ag8AmaJC9UVeapsc1VkHTkeHpe2?=
 =?us-ascii?Q?1241EfJYgQNBZsDKtsYRxV6wS2z0nbJltqPa1ye1Db1Vb80Dy8U6V5bEnmpH?=
 =?us-ascii?Q?73uQARNrwpScG+eVQklcyk8xFoeU7SIP0RES9vTp+zDO0ELJuaX42MoTlc7F?=
 =?us-ascii?Q?FgTfkE7Lnt41jtqZ0xNp+byuyUoiln0+R54E2FL2T5L1ZJ6ywGLdI+Zkbaoc?=
 =?us-ascii?Q?+boBrQNNym1v7Bfw7ksEnF+9mOTwcIeGYsgrxRRoRbvMdJbufpud2azIci4P?=
 =?us-ascii?Q?lRugaqVYTPdvVQK9nGuyXi+p4U2gO5VfFg5IIEB4QkqcTCw+grjj3GffSglL?=
 =?us-ascii?Q?DlmNG8NaK/pSzNdQTY/Sz27buDdbxWWGcugo4Lg9CnoVx+ePQXcEbonwbYdw?=
 =?us-ascii?Q?4xDHa+abAXFTE6JnyFBlQoF6s5s5XKQsdJwQGZ05Vn+Yy/xexQcNw5BMaR42?=
 =?us-ascii?Q?XvpnuWpMGk0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aDnoY463CMyNv3UFAsm2Y6ISGGJU6WoTdR+F/fZfdRV8xPYtasIV6koR+V64?=
 =?us-ascii?Q?1Y9kaMOAPDAWH/wX44LANaJzNuqQfN+BaLDofrlLijHrSq914/bLRLdoZ9q4?=
 =?us-ascii?Q?x65bfLnh9e7TxzPhEZJAJt2UC1t+1X1C28a+Ou1AKbehgEcr+QmGwVZK8lY0?=
 =?us-ascii?Q?+VUHpojZbf+8GiMKJCP0ArhTCkNsx2sAB3N/l+aSiIFq83dJZW8WGLS66Bga?=
 =?us-ascii?Q?JUmYoDrZb+r/DKXWMsLyZkEsSB8zquXUqRWU1L2IXK8qW6cRqHG/ITqDLBB5?=
 =?us-ascii?Q?qeeDt1LoiPibZb6YQ0IaHZ55OXT5HmPPWUda43/En815drCF02ll0QtTz8Za?=
 =?us-ascii?Q?/hNfLYCSluKcrWSliVproh5gCoUhdP8HqFZ9qJvRD71LJZy8zLUVGYkLXs1g?=
 =?us-ascii?Q?lb4zemf3J04TldBaSVBkGmW7R+caTNAYtsKINRla/YbeQ3awczcj4eETnCht?=
 =?us-ascii?Q?71vAGGd67Q+MIaYLfjyh2QEGvhK0GSDa9UKf63ENMejEDKIlZvlMxHUlE2pY?=
 =?us-ascii?Q?E8LuZ4P8WBxL08Tx3l/IISURyAuQONG1LEH4bg76ZseqTtOSmyfEKUJOCgp2?=
 =?us-ascii?Q?Skjiu7CeS33HzQHCmms97Hi2rRfCR9V64T+2ACGSEMozLFHFoaWlXICtAk+/?=
 =?us-ascii?Q?aoOsq8WI5PMUiId50uitM0W1yWI3gInJSnM5ACzgzOVm3Fuc3qSOyXmS+avS?=
 =?us-ascii?Q?k66uyNlngXm6YDwJsVEQB9OdLikJaaIbrsjQiAUL9nifuxvdvyEbh5ZWwQz7?=
 =?us-ascii?Q?GvtB3dDTsC7uInweegEHnbClIThVAHsAXn8+kH5EiBIQRaaqmPhzCxRkL1IJ?=
 =?us-ascii?Q?WDRJ1TJV93IxhZE5X36IpTc2wrhFxnu9pu8fpqn7gxAtsZccSsHV1tA+FQSh?=
 =?us-ascii?Q?bxncgRA0QRXKyGci0FrccRzlx2FdWPCKaTJ45+VRegaV5MI5+GdaJGjdicP2?=
 =?us-ascii?Q?dFz/4tDLdiW5xqovYJDaI/g/KdQjNQBoh+ZZMwVdM4hwO9PkBCRxnlYpd9DB?=
 =?us-ascii?Q?tAuNuRbREeoRNyIHz6P6SovwkMF67PGZqFENZyM4gx1J+hBFX7XNQYTwQdhU?=
 =?us-ascii?Q?4s8/DGh95adYzoYaUuRktp94mRDRiwvpFi8e4KEkZBvqM4m6Eaj4tBfYHaVV?=
 =?us-ascii?Q?7zoagSMXP+F4sElneQCQPCFLBZsFhget3ANlBNiXF1110zyeOjKNieNTMQ9H?=
 =?us-ascii?Q?6L08oIT3QJrEyqLN5G5hPPiQ+KihxtUAFgf3ryS8OzTqdheIXfd2A5WQsoFi?=
 =?us-ascii?Q?/dF6eTokTpvi9SRjSV/z5/+4nHB93xoCrMj9nseVKMDNtcOajZSjhg5tQ3jD?=
 =?us-ascii?Q?UjH97MK8E38PksjJF/7p3uqSxyTq18WdKlC/uy8jXAh41P2eCdgls88J2g35?=
 =?us-ascii?Q?gnE3qTytewkuFBsIUgypc9n0jI+aZI42uj3RhJu6XpQaTu4sgpMmhmxltOcR?=
 =?us-ascii?Q?EQ+5IDAJFD2Fmi/AACH0mIdmy9LCcwAqLULyZSZvw6IYXOJTRtomw7fYzadp?=
 =?us-ascii?Q?/hEYo9i7egbYClpKpJK9hR6k74TCRpU2HZrp5vM/V4mWTDYpJuiEUb/8zfYT?=
 =?us-ascii?Q?GQAY+wJirNamod3QfzphXaazkdNG0H5rSS3eZ0+ZBNLh0xMFd+VPmozIknI8?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6m4RJ3UAu1Pluja1Wk29cQLoZ+xiV75qC6neS0vXotBijHPr+z+D43TwOJIkinhcRlqFf4PcJsDDIRiOpgLmcOY6aAvpLP7TnZmm7fPXZ/mNvBQvE8hOE+x1ualTmXiyE+a33mO9YKDiX8XlO343dRnu1boJH7DT6Aerqw5S3xbZTo9K3Z6cRTrv6iZHModL4okEhyywPyhODoc746DudLMaTnG8rxgyA0uiMUvzuMikEtD195rEGiruf3PWlBfFNiQq02hclHtpN0Dk5tm7VnD37ChAU3C8h0VaGJx/dnwHoevCpve3GbGBu929sAriAL82b/pbNl+9SzjbOFKWqxe3TjCzfOd+19158mHbll9rtcWy5R+06Fov0Gs8x5+lLIi7Oasoz+viPXJNz9BVYNczrtfuh+v5bzR2z12ACchIVOyMy/YDX0kLnPNHf2dEURSYhb8e13H8aVDuCOUjelUha0c0KeBEBvMLDLKhTabaG7ozQcIWDp6YFDKgdz9xQlayW9EKRhm0a4MZyLtClrv1kG4F/0toycH4noAJl8E11EI0uNdXsqlQhlJlaLbP6FJpVM06epj7iEzxvrClhshsr51j8/1CgMyUQlSUbx8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e70b45-7930-4a27-385b-08dde48b4e33
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 10:28:32.1008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azoFXJrqwQc+KMiLd/1Sed8fhW/ces4cGwERNq+gGCcat6xefL+WPzFyuwVOwN0wmsiR4wppU/mlwXJ464ysp4nyXoTpjwNqQvbrWOUoSdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7343
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508260092
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNyBTYWx0ZWRfX9TAk3fcA29z3
 ufGtd7OCm+yJ4CkN7qSkxBoeA6lx1eDuaj7DCd3u6l4+8gJVBEjSxUYTWLTfjmVXyH4GrJo9ESy
 rNpbEc08gIPsmvtPV+l/LCwQMDzUc9M/yWGzNtFIYsU4pR3YXDUkQdQDpaTXmSV3gvy9ZUTxvzw
 xck5jy0IvW0mC9U2s6uOyyeYAA4HrCL2wCWcp3OiIYG86Y/bkzT3I4B4B1D9C1dhq/YsaWTISeL
 6lClWNOk3LIN2gXyLxM/z3gWXXApY5PJX0184Dh7LuTAwsu1faPiIygx+P5Be7HP8ZTP8qlnW9A
 lt2RkrHZgIxoohd5TFJH8AzJOsGZsPByTftN6XmxWsWm+zMgS6Fe/SFyGt+mrx4CDlJxzp9NbFC
 iUAoBxT/OWkMYBS0tezYNvKlbaEP2A==
X-Proofpoint-ORIG-GUID: zU-rpaDvMEF8BShjMoTtHnm4N__oqi-p
X-Proofpoint-GUID: zU-rpaDvMEF8BShjMoTtHnm4N__oqi-p
X-Authority-Analysis: v=2.4 cv=IauHWXqa c=1 sm=1 tr=0 ts=68ad8c58 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=iHwBjlyiAAAA:8 a=yPCof4ZbAAAA:8
 a=4GRksjcJ2oKnMSpOPt4A:9 a=uNSKXYNwxGiU6LD0JREI:22 cc=ntf awl=host:12069

We do not need to references arguments just to avoid compiler warnings, the
warning in question does not arise here, so remove all of the instances of
'(void)xxx' introduced purely to avoid this warning.

As reported by WagYuli in the referenced mail, GCC 8.3 and before will have
issues compiling this file if parameter names are not provided, so ensure
these are always provided.

Finally, perform a trivial fix up of kmem_cache_alloc() which technically
has parameters in the incorrect order (as reported by Vlastimil Babka
off-list).

Reported-by: WangYuli <wangyuli@uniontech.com>
Closes: https://lore.kernel.org/linux-mm/EFCEBE7E301589DE+20250729084700.208767-1-wangyuli@uniontech.com/
Reported-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/vma/vma_internal.h | 167 +++++++++++--------------------
 1 file changed, 57 insertions(+), 110 deletions(-)

diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index f13354bf0a1e..4b9394d75b34 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -692,9 +692,7 @@ static inline struct kmem_cache *__kmem_cache_create(const char *name,
 
 static inline void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
 {
-	(void)gfpflags;
-
-	return calloc(s->object_size, 1);
+	return calloc(1, s->object_size);
 }
 
 static inline void kmem_cache_free(struct kmem_cache *s, void *x)
@@ -858,11 +856,11 @@ static inline unsigned long vma_pages(struct vm_area_struct *vma)
 	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 }
 
-static inline void fput(struct file *)
+static inline void fput(struct file *file)
 {
 }
 
-static inline void mpol_put(struct mempolicy *)
+static inline void mpol_put(struct mempolicy *pol)
 {
 }
 
@@ -870,15 +868,15 @@ static inline void lru_add_drain(void)
 {
 }
 
-static inline void tlb_gather_mmu(struct mmu_gather *, struct mm_struct *)
+static inline void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm)
 {
 }
 
-static inline void update_hiwater_rss(struct mm_struct *)
+static inline void update_hiwater_rss(struct mm_struct *mm)
 {
 }
 
-static inline void update_hiwater_vm(struct mm_struct *)
+static inline void update_hiwater_vm(struct mm_struct *mm)
 {
 }
 
@@ -887,36 +885,23 @@ static inline void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
 		      unsigned long end_addr, unsigned long tree_end,
 		      bool mm_wr_locked)
 {
-	(void)tlb;
-	(void)mas;
-	(void)vma;
-	(void)start_addr;
-	(void)end_addr;
-	(void)tree_end;
-	(void)mm_wr_locked;
 }
 
 static inline void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 		   struct vm_area_struct *vma, unsigned long floor,
 		   unsigned long ceiling, bool mm_wr_locked)
 {
-	(void)tlb;
-	(void)mas;
-	(void)vma;
-	(void)floor;
-	(void)ceiling;
-	(void)mm_wr_locked;
 }
 
-static inline void mapping_unmap_writable(struct address_space *)
+static inline void mapping_unmap_writable(struct address_space *mapping)
 {
 }
 
-static inline void flush_dcache_mmap_lock(struct address_space *)
+static inline void flush_dcache_mmap_lock(struct address_space *mapping)
 {
 }
 
-static inline void tlb_finish_mmu(struct mmu_gather *)
+static inline void tlb_finish_mmu(struct mmu_gather *tlb)
 {
 }
 
@@ -925,7 +910,7 @@ static inline struct file *get_file(struct file *f)
 	return f;
 }
 
-static inline int vma_dup_policy(struct vm_area_struct *, struct vm_area_struct *)
+static inline int vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst)
 {
 	return 0;
 }
@@ -952,10 +937,6 @@ static inline void vma_adjust_trans_huge(struct vm_area_struct *vma,
 					 unsigned long end,
 					 struct vm_area_struct *next)
 {
-	(void)vma;
-	(void)start;
-	(void)end;
-	(void)next;
 }
 
 static inline void hugetlb_split(struct vm_area_struct *, unsigned long) {}
@@ -975,51 +956,48 @@ static inline void vm_acct_memory(long pages)
 {
 }
 
-static inline void vma_interval_tree_insert(struct vm_area_struct *,
-					    struct rb_root_cached *)
+static inline void vma_interval_tree_insert(struct vm_area_struct *vma,
+					    struct rb_root_cached *rb)
 {
 }
 
-static inline void vma_interval_tree_remove(struct vm_area_struct *,
-					    struct rb_root_cached *)
+static inline void vma_interval_tree_remove(struct vm_area_struct *vma,
+					    struct rb_root_cached *rb)
 {
 }
 
-static inline void flush_dcache_mmap_unlock(struct address_space *)
+static inline void flush_dcache_mmap_unlock(struct address_space *mapping)
 {
 }
 
-static inline void anon_vma_interval_tree_insert(struct anon_vma_chain*,
-						 struct rb_root_cached *)
+static inline void anon_vma_interval_tree_insert(struct anon_vma_chain *avc,
+						 struct rb_root_cached *rb)
 {
 }
 
-static inline void anon_vma_interval_tree_remove(struct anon_vma_chain*,
-						 struct rb_root_cached *)
+static inline void anon_vma_interval_tree_remove(struct anon_vma_chain *avc,
+						 struct rb_root_cached *rb)
 {
 }
 
-static inline void uprobe_mmap(struct vm_area_struct *)
+static inline void uprobe_mmap(struct vm_area_struct *vma)
 {
 }
 
 static inline void uprobe_munmap(struct vm_area_struct *vma,
 				 unsigned long start, unsigned long end)
 {
-	(void)vma;
-	(void)start;
-	(void)end;
 }
 
-static inline void i_mmap_lock_write(struct address_space *)
+static inline void i_mmap_lock_write(struct address_space *mapping)
 {
 }
 
-static inline void anon_vma_lock_write(struct anon_vma *)
+static inline void anon_vma_lock_write(struct anon_vma *anon_vma)
 {
 }
 
-static inline void vma_assert_write_locked(struct vm_area_struct *)
+static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 {
 }
 
@@ -1029,16 +1007,16 @@ static inline void unlink_anon_vmas(struct vm_area_struct *vma)
 	vma->anon_vma->was_unlinked = true;
 }
 
-static inline void anon_vma_unlock_write(struct anon_vma *)
+static inline void anon_vma_unlock_write(struct anon_vma *anon_vma)
 {
 }
 
-static inline void i_mmap_unlock_write(struct address_space *)
+static inline void i_mmap_unlock_write(struct address_space *mapping)
 {
 }
 
-static inline void anon_vma_merge(struct vm_area_struct *,
-				  struct vm_area_struct *)
+static inline void anon_vma_merge(struct vm_area_struct *vma,
+				  struct vm_area_struct *next)
 {
 }
 
@@ -1047,27 +1025,22 @@ static inline int userfaultfd_unmap_prep(struct vm_area_struct *vma,
 					 unsigned long end,
 					 struct list_head *unmaps)
 {
-	(void)vma;
-	(void)start;
-	(void)end;
-	(void)unmaps;
-
 	return 0;
 }
 
-static inline void mmap_write_downgrade(struct mm_struct *)
+static inline void mmap_write_downgrade(struct mm_struct *mm)
 {
 }
 
-static inline void mmap_read_unlock(struct mm_struct *)
+static inline void mmap_read_unlock(struct mm_struct *mm)
 {
 }
 
-static inline void mmap_write_unlock(struct mm_struct *)
+static inline void mmap_write_unlock(struct mm_struct *mm)
 {
 }
 
-static inline int mmap_write_lock_killable(struct mm_struct *)
+static inline int mmap_write_lock_killable(struct mm_struct *mm)
 {
 	return 0;
 }
@@ -1076,10 +1049,6 @@ static inline bool can_modify_mm(struct mm_struct *mm,
 				 unsigned long start,
 				 unsigned long end)
 {
-	(void)mm;
-	(void)start;
-	(void)end;
-
 	return true;
 }
 
@@ -1087,16 +1056,13 @@ static inline void arch_unmap(struct mm_struct *mm,
 				 unsigned long start,
 				 unsigned long end)
 {
-	(void)mm;
-	(void)start;
-	(void)end;
 }
 
-static inline void mmap_assert_locked(struct mm_struct *)
+static inline void mmap_assert_locked(struct mm_struct *mm)
 {
 }
 
-static inline bool mpol_equal(struct mempolicy *, struct mempolicy *)
+static inline bool mpol_equal(struct mempolicy *a, struct mempolicy *b)
 {
 	return true;
 }
@@ -1104,63 +1070,62 @@ static inline bool mpol_equal(struct mempolicy *, struct mempolicy *)
 static inline void khugepaged_enter_vma(struct vm_area_struct *vma,
 			  vm_flags_t vm_flags)
 {
-	(void)vma;
-	(void)vm_flags;
 }
 
-static inline bool mapping_can_writeback(struct address_space *)
+static inline bool mapping_can_writeback(struct address_space *mapping)
 {
 	return true;
 }
 
-static inline bool is_vm_hugetlb_page(struct vm_area_struct *)
+static inline bool is_vm_hugetlb_page(struct vm_area_struct *vma)
 {
 	return false;
 }
 
-static inline bool vma_soft_dirty_enabled(struct vm_area_struct *)
+static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
 {
 	return false;
 }
 
-static inline bool userfaultfd_wp(struct vm_area_struct *)
+static inline bool userfaultfd_wp(struct vm_area_struct *vma)
 {
 	return false;
 }
 
-static inline void mmap_assert_write_locked(struct mm_struct *)
+static inline void mmap_assert_write_locked(struct mm_struct *mm)
 {
 }
 
-static inline void mutex_lock(struct mutex *)
+static inline void mutex_lock(struct mutex *lock)
 {
 }
 
-static inline void mutex_unlock(struct mutex *)
+static inline void mutex_unlock(struct mutex *lock)
 {
 }
 
-static inline bool mutex_is_locked(struct mutex *)
+static inline bool mutex_is_locked(struct mutex *lock)
 {
 	return true;
 }
 
-static inline bool signal_pending(void *)
+static inline bool signal_pending(void *p)
 {
 	return false;
 }
 
-static inline bool is_file_hugepages(struct file *)
+static inline bool is_file_hugepages(struct file *file)
 {
 	return false;
 }
 
-static inline int security_vm_enough_memory_mm(struct mm_struct *, long)
+static inline int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 {
 	return 0;
 }
 
-static inline bool may_expand_vm(struct mm_struct *, vm_flags_t, unsigned long)
+static inline bool may_expand_vm(struct mm_struct *mm, vm_flags_t flags,
+				 unsigned long npages)
 {
 	return true;
 }
@@ -1185,7 +1150,7 @@ static inline void vm_flags_clear(struct vm_area_struct *vma,
 	vma->__vm_flags &= ~flags;
 }
 
-static inline int shmem_zero_setup(struct vm_area_struct *)
+static inline int shmem_zero_setup(struct vm_area_struct *vma)
 {
 	return 0;
 }
@@ -1195,20 +1160,20 @@ static inline void vma_set_anonymous(struct vm_area_struct *vma)
 	vma->vm_ops = NULL;
 }
 
-static inline void ksm_add_vma(struct vm_area_struct *)
+static inline void ksm_add_vma(struct vm_area_struct *vma)
 {
 }
 
-static inline void perf_event_mmap(struct vm_area_struct *)
+static inline void perf_event_mmap(struct vm_area_struct *vma)
 {
 }
 
-static inline bool vma_is_dax(struct vm_area_struct *)
+static inline bool vma_is_dax(struct vm_area_struct *vma)
 {
 	return false;
 }
 
-static inline struct vm_area_struct *get_gate_vma(struct mm_struct *)
+static inline struct vm_area_struct *get_gate_vma(struct mm_struct *mm)
 {
 	return NULL;
 }
@@ -1233,16 +1198,16 @@ static inline void vma_set_page_prot(struct vm_area_struct *vma)
 	WRITE_ONCE(vma->vm_page_prot, vm_page_prot);
 }
 
-static inline bool arch_validate_flags(vm_flags_t)
+static inline bool arch_validate_flags(vm_flags_t flags)
 {
 	return true;
 }
 
-static inline void vma_close(struct vm_area_struct *)
+static inline void vma_close(struct vm_area_struct *vma)
 {
 }
 
-static inline int mmap_file(struct file *, struct vm_area_struct *)
+static inline int mmap_file(struct file *file, struct vm_area_struct *vma)
 {
 	return 0;
 }
@@ -1411,8 +1376,6 @@ static inline int mapping_map_writable(struct address_space *mapping)
 
 static inline unsigned long move_page_tables(struct pagetable_move_control *pmc)
 {
-	(void)pmc;
-
 	return 0;
 }
 
@@ -1420,51 +1383,36 @@ static inline void free_pgd_range(struct mmu_gather *tlb,
 			unsigned long addr, unsigned long end,
 			unsigned long floor, unsigned long ceiling)
 {
-	(void)tlb;
-	(void)addr;
-	(void)end;
-	(void)floor;
-	(void)ceiling;
 }
 
 static inline int ksm_execve(struct mm_struct *mm)
 {
-	(void)mm;
-
 	return 0;
 }
 
 static inline void ksm_exit(struct mm_struct *mm)
 {
-	(void)mm;
 }
 
 static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt)
 {
-	(void)vma;
-	(void)reset_refcnt;
 }
 
 static inline void vma_numab_state_init(struct vm_area_struct *vma)
 {
-	(void)vma;
 }
 
 static inline void vma_numab_state_free(struct vm_area_struct *vma)
 {
-	(void)vma;
 }
 
 static inline void dup_anon_vma_name(struct vm_area_struct *orig_vma,
 				     struct vm_area_struct *new_vma)
 {
-	(void)orig_vma;
-	(void)new_vma;
 }
 
 static inline void free_anon_vma_name(struct vm_area_struct *vma)
 {
-	(void)vma;
 }
 
 /* Declared in vma.h. */
@@ -1518,7 +1466,6 @@ static inline int vfs_mmap_prepare(struct file *file, struct vm_area_desc *desc)
 
 static inline void fixup_hugetlb_reservations(struct vm_area_struct *vma)
 {
-	(void)vma;
 }
 
 static inline void vma_set_file(struct vm_area_struct *vma, struct file *file)
@@ -1529,13 +1476,13 @@ static inline void vma_set_file(struct vm_area_struct *vma, struct file *file)
 	fput(file);
 }
 
-static inline bool shmem_file(struct file *)
+static inline bool shmem_file(struct file *file)
 {
 	return false;
 }
 
-static inline vm_flags_t ksm_vma_flags(const struct mm_struct *, const struct file *,
-			 vm_flags_t vm_flags)
+static inline vm_flags_t ksm_vma_flags(const struct mm_struct *mm,
+		const struct file *file, vm_flags_t vm_flags)
 {
 	return vm_flags;
 }
-- 
2.50.1


