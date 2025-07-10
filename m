Return-Path: <linux-kernel+bounces-724730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D5FAFF643
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83DA565AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 01:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B1026FDA9;
	Thu, 10 Jul 2025 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lD3Dbaay";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Zhg6BWer"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3727F26D4F8
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752109223; cv=fail; b=nN/ehKNzXAIDtF+WpcSTScbbImeT/yisgBJF4gpomFeA4tp21/98pjv/ec5v9OHGsIJL3DOdRe0hbI53X4EWGB9Ey/i8UXXsRNKADyWUnzjovgSXdsFuU1ZHybcqBtma0kRnG2GSA7fbDnyQtJ1yDGKLzYxcgHGbQeJ5y22pGdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752109223; c=relaxed/simple;
	bh=5FUsEltdFvn1yQF42nmrk+LF5wc0Bhp6XQSb80G6A8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Bnu3Cc6TItymyaco5X48EdfrL869fGtTgJ7of3nmBpFwwr4WQBIsIzA8vmwDZef2n73Wut53qAaCuwlmAmKPep7bRPEwCsoksVUGmbVm0ppSuh3/uSvbQOlgLkM3LGr62oaUHwSQFm4i44IHi3vvW833QGJgXaEi3UgIsKtwDDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lD3Dbaay; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Zhg6BWer; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A0MuZn030250;
	Thu, 10 Jul 2025 00:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=vAnproaGTe53nd7i
	3/OmC5LyRD/ifCUYKliNyNd6L5U=; b=lD3Dbaay/YaUggBfJi1rL/fYZs9T0n5t
	Mx1gw64nXm/2vKk0C2Ge3Weq0OniXTCALcu3EvUtRQjqkfuFHYDJ2oG7CeM92q/M
	wli8OLxEh9D9qGjTuUl2tbAfoOYocFtyXSX0j/7zPEzg0RdmTy4xkf+uP4AOTevo
	23VChxHt1O25MfAOwGc8lsdfXsDWLgHUrqeEAoKjfnIQzVNHJGabi5IURry8QzCn
	URIEO4LV/kwlhMDn1StA6Idm6GeaYPAjVHDIsYYYcJcgsnNoUditQV5sYf9ACvgq
	yYvOdeg/z781TornsgzLPm8Fc7h5W1CYE4TTF87y/AgQVzVOayKGig==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47t2wn817v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 00:59:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56A0AoXm013986;
	Thu, 10 Jul 2025 00:59:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgbndh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 00:59:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1Pkcsh5Wo51gyjOGIe33cODLruleI/WZipeWraaQ13FKMTLqYg9x1I0sns7fLV2DM0VDgwbY+HE0LMSk7a6MMofFpYZ0Yfif4+Va0CGv3MITllQpSX7rX05oZ8f/1p1stG+9pw7sZFqqOJlbOQG7sn6BYE1L28dzLt1uIRTRC3t7uLdYEaRkBg862GzmIEy/z/766tljb7P8csZVHqWrxiO84d05xOrhZdO9dIHkS9Dj3U1ggpxgeVoGhpiG8qgAqIfA1I0SXhKlNTQP00UTvmwbCTSg8ZSj131hbnxbAABC1fSCCZXgTxBQzHEpBfk5zqVR0RQSXG7VVRvjEyqYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAnproaGTe53nd7i3/OmC5LyRD/ifCUYKliNyNd6L5U=;
 b=SZpTsngvQQkbnj332g2Bgsn186jxm1KyZIjqWCXDhwcFIBm7ZpVyTLCIUmGBBpH2tu9e1J+otIwWotaoDC5iyKnO6+rJlyaJIln2xeRkHRb+wtF6F9Mppdxdft+Uj8/wV9ubi+/qsuhf4/fdAS61+QH+rjeChvdum5wsgUfPBjNZ7mY9gk5dyaM+vgjetK1sBdUukHM0ywZYOSpBUUmST04+WvgmVm32XcT5UWtAMRFRiWMiQrI7AGsxX9e2Ma30vUa3443NEwshYzwNKmCltKOko5rNKXXYliwcOHhdNMFhgaKuwcuE3ibB8j12ZX5hk2vukpvKM66gXUZ5Z1Af9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAnproaGTe53nd7i3/OmC5LyRD/ifCUYKliNyNd6L5U=;
 b=Zhg6BWer9oDti4rfkGQ/RrAzRZTPIhXDwMUAh5pw1YpQ6N/crOUsNZhrloop1UL2FCxKI6BXt8IA9sve3kqJU+03E7dnlyx50ca8vrLsaZ/mD7SdiNMfHN77NrSi4x82sp8ayZEP44C1dRXUISlz/OZts7bhp0PCha91BZl5sAQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB8078.namprd10.prod.outlook.com (2603:10b6:8:1fd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 10 Jul
 2025 00:59:27 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 00:59:27 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v5 00/14] mm: folio_zero_user: clearing of page-extents
Date: Wed,  9 Jul 2025 17:59:12 -0700
Message-Id: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0049.namprd16.prod.outlook.com
 (2603:10b6:907:1::26) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c9554e9-0ea8-49ac-d3fe-08ddbf4d04e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n02cLA8AOwNTHQvIVeqhZh3QXwkgNZJr+dhSG6at2LQ2CA3BgA2M/rSBhh7w?=
 =?us-ascii?Q?LE/zbEhSkFo6QYDOWIveLX0PsJFbY8p2psK7UpoEY5e5/n3GDcOGJCI1AHea?=
 =?us-ascii?Q?lC61D4C6WDuT8vDOXkdIXkmsG4ryds68qr5UYz8/JROPqGF5PcykCBsLlJ5T?=
 =?us-ascii?Q?56GYGD2N9ZkSAQeNWLOkrrMFJ9P2b9IOPvyQDsm0rWUz0RNinUY1+PqzezTB?=
 =?us-ascii?Q?xqn7VT28xkyApc4lxxoFuSfr4aKrTnZ/fV/6ObFaBI68bf1GqwlzuDej9NBe?=
 =?us-ascii?Q?F6t8kaA/cSEVXFga3r/XJO7QW+yCJ1ypnCth2I2ngAnurNhbE5eDPynpuNdw?=
 =?us-ascii?Q?24KNkF4z5t+i8H3Q8gVYPSSzsIlgzy6fGZ+KmYunuburccMUiZoCd/DmtBqa?=
 =?us-ascii?Q?ZopfdCcmijiOLvjeMy8RG3Zl2le2uuerm9I3oVvV8lbhOGor/J0rtUnow4b9?=
 =?us-ascii?Q?skUufQoCmHTjMpK2J5uftKO/aGlsZuGVcd5v1TiLxRhtHXBOrAU5vc/SpDBp?=
 =?us-ascii?Q?NwS55NSKtgYwZsqmNSDyyqFKW2qTgXnM3Pqwcph44ot1jRj0a0uV9sDxmKsK?=
 =?us-ascii?Q?I80jnchbcV9hMCswboXFLknjPBkf76NXIO2j30rQ5WN2FLAYtma5JYo+cXE2?=
 =?us-ascii?Q?IaeZt5Mn+D5y9STSL3tW01aagMXGyzbwYtkATqOIfmVV1Sb50EcxT67g8H1S?=
 =?us-ascii?Q?oCUW7u6Fwc04aBdNOQO1cpGkITs4GeZauZ+GbnhTqEa7d9ghN4XvRIertmIK?=
 =?us-ascii?Q?WW2b5lzYj8E2Gdw4+WaySblV+r+OY0WFnC+mjnXe9OuLE2chFpyhlrHAJbUm?=
 =?us-ascii?Q?MDR/zXC/4MxmzP6pnxgAE6MGnW6dsHghE7lXmZ+ZAfMyJJn6HO3y4T9jLqTj?=
 =?us-ascii?Q?9Xiik55tCTNiiEszayTl/wYMknNpmQKzSIWkq+ZtKWFFUT8NBEaMX5IN/JN5?=
 =?us-ascii?Q?yNLiOBuFuFVzRafsyf81n2ddM/GMqjd2wqBe3nJGQVzVEOLbGqVgE4UjBoy2?=
 =?us-ascii?Q?afaJh3PkrRFyivQhrrWMb0bkdkbzz5LK/NUpirgmRrR2JokB+E+9yDcXGlkX?=
 =?us-ascii?Q?z8ONr3EYFIZExR85/KiYYFcO9B84Kq/uONDTcUlGeLdtuKC5HR0xnj7411Ed?=
 =?us-ascii?Q?JXdfNuAi1VCdszs10v8LToWx6EZqpxlYc/oS9SlJ8GiQ6H27AsV02DsTgdnr?=
 =?us-ascii?Q?nW9VhTKQ0J/9cbhXajKH6a1vXuBxCFz0sZ6PEmZT1TuauGAW8gS59af0Zwue?=
 =?us-ascii?Q?gNR3ve140vV7CFQ0WvkPB/uU0W/OitAPy2bHwK0OoWOYovxuSE+u26usilu0?=
 =?us-ascii?Q?XoRSJnpT0pcxTZEiWJe2zoyb+IkidVzxjuJR2ddCXnT5NhPY91Bxf7iJiFPx?=
 =?us-ascii?Q?4gbk/5DqxBSqui00DA0zif4nHq35?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wdFq0n/FDLg1o/o7tSC5FDxKBHBck4DvHmPLvC5oU4c/O+ivdfBMln4rRFMO?=
 =?us-ascii?Q?vKSnem4gO+nFPOaysWRNGQeCi95NEmDZjEd9C7JSOwstyTA6/g88ZF/JMIPb?=
 =?us-ascii?Q?7PL2R8gWF1ECzSM2HbWnq8Sg+k8zGVAyzIuC9PkA2TTk6P96/gCSv3fc+fig?=
 =?us-ascii?Q?uzkZRXHWZoCOBg+uqbRqYttn9XaKvZ6U/Do5Ix8NAZTY61cugziuDs0Ai2xY?=
 =?us-ascii?Q?ApaWKs1A2HOFMmiHSbfWw9syqbSpwzjD70I52NE2Wtn+o5BkaWwLqqo+Wbpm?=
 =?us-ascii?Q?AflA3koP5Bpvy5M+eHJ3b4XxSaSz9GVJe/31g3EpjY9PWU0hkNooBNXpmKWL?=
 =?us-ascii?Q?38RmWpZtq3nM6H/vqJOntsM6NqtAF5sQqhHezMn29YYlSwmEI5axf3MEvj0Y?=
 =?us-ascii?Q?Vz3w3Q5GYEa2V0V02iQqna6YcRIYSPl52B6iIgTwJ1g3I1bV7TPhumeWKoyc?=
 =?us-ascii?Q?/tiPoVnt2txTds1ZwQxPYVLn31afXMiyCeRkqnAJwFw/O2CtX6sHIIFoooGq?=
 =?us-ascii?Q?maIU42joohQj2W/Zi1rZ8SLAaEleWb+bG7aGRIL/uk99UIpM/UeTNL35aihJ?=
 =?us-ascii?Q?n7pxJUET5vaJUgmEIgVBppQEmYjX0w1iJ5CGtUt3y5TK0mRnDwSo8W+aJ6Wc?=
 =?us-ascii?Q?D/HfeUue6nwaNDxaBPcoflhEmQhS4BNISdhG6NPDZn3nzsi4NON19nCtTD+S?=
 =?us-ascii?Q?cEtcJdsnfSDP/7oSfzYFbj241V5Tm/eNu/X8fBEQcsKz1OzWNLrHmdHMdtNM?=
 =?us-ascii?Q?+iLPem+CVeEDVRH+wlLRjcolAPZ5V+i8+JRQ/1PNxvRxQkcEN59/pY8auBNC?=
 =?us-ascii?Q?PRJ/l31MtSoblB2XydA9iqmjjWHCxMGlfH64ptedzkpv+jTTSj960xb2OlKS?=
 =?us-ascii?Q?h3G4yM3JpxoGoy10jIgOFGJb7coPC8DB0OYRjY8JqIcuusUDy24PjS4HtNPG?=
 =?us-ascii?Q?7PdikxZS8U/cC6nULQk28iOp7kBpfHeMM1VpWYQVQAaZ8Xeg3KGyjQBatHXa?=
 =?us-ascii?Q?PY+M+JncX5VxTmarm+AF9vsBQNtAiO3ktR37cU7tLlodXMaiUveOyeUhTy7A?=
 =?us-ascii?Q?T7APjtiUQAqXHaBlOaHhnNqOCwnO0yFCGGv1b9jW4hzDnF7sfjek+0RfF8x1?=
 =?us-ascii?Q?6AbFwFrH73quhrDYhbl2F+7nrJ1/N3+4swyjyuL31S4bld5uWpzzILS40b5r?=
 =?us-ascii?Q?Y6xW/CmYxKtnR/hXEF++zoMAhD+LKnJRudVFX4LqlubB9TojcYUIZjHJpGGr?=
 =?us-ascii?Q?B2owlXwA5wvPqm2QFOdqu4DIowmGDg9Fxy4yKeiKkPyqo7MgwvxKNts1Qnvg?=
 =?us-ascii?Q?SEDV89hGATc/2xi71HG0SM0XTFSnk/otSbtZygoeqxDBQRBWn7aihZuqP4/F?=
 =?us-ascii?Q?65QttkqP5AAx0yzp8CYHp/wPwP+ayVfKtD4hPzOSQsM8x5mwF76cP1eR/e55?=
 =?us-ascii?Q?z4fOS4ru/ncEsZCp/Yw6EVVWG0fzbz6r4PlEoMEj05U9CFJhhgPTWR0NUHpm?=
 =?us-ascii?Q?c/NRSICpd1kr3AlZnEuD2oiqiKVr8xaTccnxIakehCgkyWt44HKx9v2bnRlr?=
 =?us-ascii?Q?h8RQha+BtsRKzcpHGpCkPYMzx6GVZNVZ+dNK0CHFZ5eEx5EJK3XZYj+C/KDg?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9IEMgI0qMvHBPGgf+gIGDWJtITuyZde+9fRQXIERfdTZyqI2adS3zg3DqjnTQ5CHWoGsoRAxOTYMBz0FuaHCGUZnw8KvQFsNHPEhxskc6s4g6vtWQhlxwhQoqYwGbZTlA48KSm17R5fperCbjeoE9BaK3VsjxpPal0ve+qiS+GBj9YxZdbofnaVxpRiROoJBqfvJxYiFtc4+4O7kq3IaCnzFYxjd825yPX9yzH70z9U/GNAzjqvEPBdBibw+FFvWw9irh/4ZL4GJVCerbzDMimUcmSyA30CeNOTFVVHICaRcxXsgw3UohFeqB2VAa198o9yZISk87MxvzZszx/zHpAKlxAX+UInG/ohnZisQEORRsCCXwqr8KXuxkt0tLFGbYHTTlRwZQgtU5IfYXn8TSw8H65ceErUWpiPT9LB/4EbbYbcusJ/+jCLGMYCKbkezdjT0VilPwyWeBUXBCnP1GRvGXXraVu3QNalVpLyj4to9dLDywdQOFT1GbnllZgYpoZGFAU8p6v9Aa5fxtyi93vo9ouqYFJCDXc8yvZ3Ba1tGPNS+R6/yXl2zlf0JXbGxIrGgCjShKya759+QZj4a97w5MN4KjIzQBmGODHJhfQk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9554e9-0ea8-49ac-d3fe-08ddbf4d04e9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 00:59:27.3778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCNyuli1vndkTOXk+ZkeS2krsiptQzGHxUizHy+CnAXrZ+5S6CjH0xhBXC4RXmnBRmjEIzvrT32TX/GV7MOYZSlAPSpNy4FWUAQ8APUZVu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507100006
X-Authority-Analysis: v=2.4 cv=WtMrMcfv c=1 sm=1 tr=0 ts=686f1075 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=zd2uoN0lAAAA:8 a=NEAV23lmAAAA:8 a=dwtZxa6-cFIMZWPJcc8A:9 cc=ntf awl=host:12058
X-Proofpoint-GUID: k4ahYjHXvAMBVfVlDJ_NrtvXCxw3zKDU
X-Proofpoint-ORIG-GUID: k4ahYjHXvAMBVfVlDJ_NrtvXCxw3zKDU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDAwNiBTYWx0ZWRfX1ItK0dmBQ1IV QYLNLBU5X/wwbUfOCDGn8MJQtsxGqHBpzMkv/LyIZt4wFSaO1izf7kdm3GH2USIHbPWxhHH7WIG HsNsB9vI/wfQj3mqBwgLxdW+dpfnKPQCJ+FdeTQ5qVy0EbotAogE3shNrX5lzVwxvJWJnjpCbja
 CboBpjp79KYTdu1GE5cgMoDZ7fPTKACiZRVOi06rVSwgqXj8m1r6n1oT+VTrNyYHmGbUyWppd5A nFEVdmwfuPOM5NFpJJQzYC7nMkm7cRXTQfDTdv980oA6FOjeLpRYe6ZtWpNBOah+t7T6Akl/jiL 2GNzf7kyInyhBLyeghOo/AqZtzyVkoFSqUIwOVzE/V8yHFrjx3wehG6WlkOXXPJo6N9Rl6otX33
 CXNdmLhCv+UxWkGl7XaOhvPxmH24I11R1l1QYEy3e2bj2s2SuFjfZaJCsyyg2qQAfzM9MYPV

This series adds clearing of page-extents for hugepages, improving on the
current page-at-a-time approach in two ways:

 - amortizes the per-page setup cost over a larger extent

 - when using string instructions, exposes the real region size to the
   processor. A processor could use that as a hint to optimize based
   on the full extent size. AMD Zen uarchs, as an example, elide
   allocation of cachelines for regions larger than L3-size.

Demand faulting a 64GB region shows performance improvements:

 $ perf bench mem map -p $pg-sz -f demand -s 64GB -l 5

                 mm/folio_zero_user    x86/folio_zero_user       change
                  (GB/s  +- %stdev)     (GB/s  +- %stdev)

   pg-sz=2MB       11.82  +- 0.67%        16.48  +-  0.30%       + 39.4%	preempt=*

   pg-sz=1GB       17.14  +- 1.39%        17.42  +-  0.98% [#]   +  1.6%	preempt=none|voluntary
   pg-sz=1GB       17.51  +- 1.19%        43.23  +-  5.22%       +146.8%	preempt=full|lazy

[#] Milan uses a threshold of LLC-size (~32MB) for eliding cacheline
allocation, which is higher than ARCH_CLEAR_PAGE_EXTENT, so
preempt=none|voluntary sees no improvement with pg-sz=1GB.

Raghavendra also tested v3/v4 on AMD Genoa and sees similar improvement [1].

Structure of the series:

Patches 1-5, 8,
  "perf bench mem: Remove repetition around time measurement"
  "perf bench mem: Defer type munging of size to float"
  "perf bench mem: Move mem op parameters into a structure"
  "perf bench mem: Pull out init/fini logic"
  "perf bench mem: Switch from zalloc() to mmap()"
  "perf bench mem: Refactor mem_options"

refactor, and patches 6-7, 9
  "perf bench mem: Allow mapping of hugepages"
  "perf bench mem: Allow chunking on a memory region"
  "perf bench mem: Add mmap() workload"

add a few new perf bench mem workloads (chunking and mapping
performance).

Patches 10-11,
  "x86/mm: Simplify clear_page_*"
  "x86/clear_page: Introduce clear_pages()"

inlines the ERMS and REP_GOOD implementations used from clear_page()
and adds clear_pages() to handle page extents.

Patches 12-13,
  "mm: add config option for clearing page-extents"
  "mm: memory: support clearing page-extents"

adds support to do extent zeroing via folio_zero_user().

And, finally patch 14,
  "x86/clear_pages: Support clearing of page-extents"

adds x86 support so folio_zero_user() can take advantage of
clear_pages().

Changelog:

v5:
 - move the non HIGHMEM implementation of folio_zero_user() from x86
   to common code (Dave Hansen)
 - Minor naming cleanups, commit messages etc

v4:
 - adds perf bench workloads to exercise mmap() populate/demand-fault (Ingo)
 - inline stosb etc (PeterZ)
 - handle cooperative preemption models (Ingo)
 - interface and other cleanups all over (Ingo)
 (https://lore.kernel.org/lkml/20250616052223.723982-1-ankur.a.arora@oracle.com/)

v3:
 - get rid of preemption dependency (TIF_ALLOW_RESCHED); this version
   was limited to preempt=full|lazy.
 - override folio_zero_user() (Linus)
 (https://lore.kernel.org/lkml/20250414034607.762653-1-ankur.a.arora@oracle.com/)

v2:
 - addressed review comments from peterz, tglx.
 - Removed clear_user_pages(), and CONFIG_X86_32:clear_pages()
 - General code cleanup
 (https://lore.kernel.org/lkml/20230830184958.2333078-1-ankur.a.arora@oracle.com/)

Comments appreciated!

Also at:
  github.com/terminus/linux clear-pages.v5

[1] https://lore.kernel.org/lkml/fffd4dad-2cb9-4bc9-8a80-a70be687fd54@amd.com/

Ankur Arora (14):
  perf bench mem: Remove repetition around time measurement
  perf bench mem: Defer type munging of size to float
  perf bench mem: Move mem op parameters into a structure
  perf bench mem: Pull out init/fini logic
  perf bench mem: Switch from zalloc() to mmap()
  perf bench mem: Allow mapping of hugepages
  perf bench mem: Allow chunking on a memory region
  perf bench mem: Refactor mem_options
  perf bench mem: Add mmap() workloads
  x86/mm: Simplify clear_page_*
  x86/clear_page: Introduce clear_pages()
  mm: add config option for clearing page-extents
  mm: memory: support clearing page-extents
  x86/clear_pages: Support clearing of page-extents

 arch/x86/Kconfig                             |   4 +
 arch/x86/include/asm/page_32.h               |  17 +-
 arch/x86/include/asm/page_64.h               |  63 ++-
 arch/x86/lib/clear_page_64.S                 |  39 +-
 mm/Kconfig                                   |   9 +
 mm/memory.c                                  |  86 +++-
 tools/perf/bench/bench.h                     |   1 +
 tools/perf/bench/mem-functions.c             | 391 ++++++++++++++-----
 tools/perf/bench/mem-memcpy-arch.h           |   2 +-
 tools/perf/bench/mem-memcpy-x86-64-asm-def.h |   4 +
 tools/perf/bench/mem-memset-arch.h           |   2 +-
 tools/perf/bench/mem-memset-x86-64-asm-def.h |   4 +
 tools/perf/builtin-bench.c                   |   1 +
 13 files changed, 472 insertions(+), 151 deletions(-)

-- 
2.43.5


