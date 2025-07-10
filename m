Return-Path: <linux-kernel+bounces-724733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A64AFF648
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC74568058
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 01:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E457A273802;
	Thu, 10 Jul 2025 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D56i7Odm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bFwDp39i"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69843272E72
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752109233; cv=fail; b=eXeJd8O33xLDb6hC5qSWi6dNapVwpoZhcseULwpJJppiCseATieT41T8fjUJr8b0n0dR4hlGx3reQ3iBgeaoqzixzw1/gVKxSpF0N+RYBPSkdtgQl5Lp0U/t4LRJgmkaZqipxaI0PMvlYAo+ZsQOUDsWNoWVzWlqTj9jSG92cWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752109233; c=relaxed/simple;
	bh=gQuyZAF4Ij4Y2/ja8vRTM7c2T4xHRRtpFF91ZFb7PuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qt8LYHpfPEQhM/JXEIeAbJ2TayL8ce23tKMEpNbD67vmPycKDzhG9JnxurO1Svshv0Pb4SCZXGeY9tZDIy0YU9/Hx5abJWVIlX5RF2zzEO6dvljLONED//LV8rt7TAZacwME8mb52CnocUHlrOtwrf0ZOSEtkSym7Y8/UGfDekY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D56i7Odm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bFwDp39i; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A0Mn6D030185;
	Thu, 10 Jul 2025 01:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=brUOVKSdWQ5XclxFBHQ2tJOX4ITr6gFe6rD/Ly8ZXGA=; b=
	D56i7OdmkSvwEvqjfHjHPkt8yTQJDSGPwVYwbNNomPg9XtERkihC97ZfZ0HsG/Jj
	b+Y7OlBlxairKU5uMK57boHi2hM4OpNu9ojuDEJuuYQTPBmUystNYpy+lbRK5iIS
	zffKm0YMLY+UvO2YUHrOELcPIeW9+8jUNs8Zss7ZbGJaEh2tRBwy+dAp9DCMLAU9
	6hgbb1OUYiU+tLj6808lupVY21pyajJ5cdkR+43OOrQ71RGGoduAMkypEEM67pLs
	0UUsNCxOez7qNL5wd86DYIqgQMhziewKHVnllP03By+vt4wBMiSHf3u6dmdZVoBg
	odgn6Xttk1YV8np28Rdaig==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47t2wn819y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 01:00:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56A057IG023666;
	Thu, 10 Jul 2025 01:00:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgbvxne-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 01:00:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qotcHzWvVZzVZtxf1z7DG2Pfc3zzlwwx4Ruvz12FhqGnpeW8yJ1k5NdJAtpnjW7jeJlcUcZdiSYMOkqyFr0DFtjZEgQ5bzmuvAYbnrvV05/RQfLR5dMAMxYmm4YygKvp+5MO+ywxX3wz0u1QllN/MiqaQxtlGzLmSCIX76n78EfAjFOOe1GuysdTsnDgqACvaPkgJBMS+CCYoF8+Tj7Wzb6IF4EouqJPPOo9/iM1UHjV2NbTh3RG9yWYQaRfxWX/Bex7qLDzUfZraN4D1Kai51YPlpQTGUeogfjzcw7t0BFZfcrxGUg6qj1FuVR3TSyiw3Vy11a53vis9atqm+7wiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brUOVKSdWQ5XclxFBHQ2tJOX4ITr6gFe6rD/Ly8ZXGA=;
 b=hOUXvpK3ApeFn48MUxB+TwBQl0OUd2s2VBQ/x0JQOx6dOvtZkRn3njCvBjJhUdQS6Q+M5AOZZNQANhNjAuwqArQA6KDuH5OlvE4vLU1XzDaqWJ2SJePF+nqxMyyQviDNgq/gdohpKmFLgVlQqrF+VIRmQf7HB5NiOuI8vtb3gSkO1cLCYqGd/3yaABpcO0/3Aj7V5UNUvoWk+Ra301tBMSy2kF72P/UdAkIiopCfPG0EN2S6TI9bK/PFH9Ml61ixDvasF8D/zYpR8klxyLu3iA6wYRT1TQcuTCqiBT9XbCnmBncOkm+TM/nFyNapJPhDifQakew8yTQ7iCB5d7h5/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brUOVKSdWQ5XclxFBHQ2tJOX4ITr6gFe6rD/Ly8ZXGA=;
 b=bFwDp39iaVPFxbaYQNtJxBo53gdTIFPDiwxmm1bL4f8h3m1/M/ekSK1yaQLXyR5uXzIeB9EAzMs1FDqXnPtIkOu4/DNFhPY7M6Y+qYJim8Qmj4H6/zzii41zhUrwRVKiLIALfWGIEsosi72W6giciLpA0W3H0/sU6/igA9/X0b8=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB4832.namprd10.prod.outlook.com (2603:10b6:5:3a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 00:59:58 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 00:59:58 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v5 14/14] x86/clear_pages: Support clearing of page-extents
Date: Wed,  9 Jul 2025 17:59:26 -0700
Message-Id: <20250710005926.1159009-15-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:303:b6::24) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB4832:EE_
X-MS-Office365-Filtering-Correlation-Id: a6ba13ad-6288-4017-a114-08ddbf4d179c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pCknsoH1EW68Z8V/b2XsbeR1XQKFKDrz8ZWpvDlPo6E+35UFY3vPRIkQnBwQ?=
 =?us-ascii?Q?Wg48X1nIFNs611+Pjvx3T2uekJA61QFkAD9wZulxB25SrPB1VsNn9MAuXb3l?=
 =?us-ascii?Q?qSyVmLht3XAdf2NYAQxvR3XnbDDiKF5A0zR/HFmpGG9/P013MMlE4Ky4jbbs?=
 =?us-ascii?Q?KYMl/yARG9hZHrIz8VKTG1+8hGowU80b7DSMdlJWo3uE/V6saFnb1wF7R/Et?=
 =?us-ascii?Q?OLze2Ko5lUnYti4QYcOHJDsJSTHhCxi3tf5hUdR0h24etvWBWt/5c2xS1/KB?=
 =?us-ascii?Q?a8oe3923l2NXtij7cl8z6TGzIJAq1/gKwTJOrX5m2istAYEc4nzqXg8d5P7A?=
 =?us-ascii?Q?JrofoHry/J92Kag5YiWh3N4H+h4K0njrxZfKB9j5Zq3aYlaTN/xEaK6vAp7Q?=
 =?us-ascii?Q?7gndDfcCIfFKqvou8c9fX8jLEBKjUr5Tfd+R/EoXV4iz+5KGAyFh5X18ZqTK?=
 =?us-ascii?Q?iOOYzFUcddzcoXibZV6sRWj+/K78IyBlsNeV2pPZx1zKpoKP8czB3zNR4+ub?=
 =?us-ascii?Q?r4iR/sMyqYgnW2RhNAEMQnSsMJX/iqSeOxTC0qaIJGwM+M4ur8q/RfxsDTjt?=
 =?us-ascii?Q?7XzmMTWJhFHVoe+tV3ZGSMCeCtIEjPanebRB6ahQwyuoVv5Hb5aZHOUSSvWN?=
 =?us-ascii?Q?e6170Rl4/yh8TeOx9M3aLSM8DLj3CFMS7e9AvliM2etlnYyXAbdmKloGk9ut?=
 =?us-ascii?Q?PPb0mWMVZioZ631vg5Bf0+gfP9ndDDj3yeizEPhuAXk1iSzFhoincdZMbQy9?=
 =?us-ascii?Q?/W/icphcE62eqo5MVD2aEteVQwMLXrTpEMlI9f2EZ6MHdPjt1xVE7FOVlUW9?=
 =?us-ascii?Q?8y+/VlRGNmfcaKiYGUGvI0nAhPGgmD6odwboFdEN730X/rb7FK/ixy4Ji1+f?=
 =?us-ascii?Q?+3nZGaRFMWiWwdCgIw1GvnM5yH38M7CASTaNxlljauffE6aPnrrqvoccETXD?=
 =?us-ascii?Q?qwoJ9o/GUJW9IYKovYveyW3p+PTDsaPQpk1BKBjiV7BQhAVd3lbvuUwyG4BT?=
 =?us-ascii?Q?Eg7B934HVWvGYp0VAImK5ruRWGaDG9d2s3YDUNpoZo8sUAz8SzrGBoY4d16t?=
 =?us-ascii?Q?amUrJnU7F1QUps2mzzg+/jSMGMP72wmb6C0LcFw7MB0Le2OYdcFEK6wcUsEj?=
 =?us-ascii?Q?tHm0hikMPV+jwNjQcjvm7ckkobl5N0B46ivOoOEn4AYLcrRShLRM9IrrOuAX?=
 =?us-ascii?Q?mNtZCx9VltgMJr55v3B2BidXhN8ZPuHE/d2Ti9GmyGfPRH7WACbzk3MdqQ7w?=
 =?us-ascii?Q?4jSCg7bfZ3ABWlINFnfLvdyPnMHqzPkkpaZma3/tMheTxQwr6F/J2lRPw3XQ?=
 =?us-ascii?Q?/CWlNfiumGgxuZqLBNxSjFJ8QmuPBa82xxdSbOLVYlIXZfMOT+qBFczUKpYF?=
 =?us-ascii?Q?E2bgzeWCoIOYQJwJ8BCzmiHYrJk83bvEJjmV4jN3J1YqU363bMc/NVNpiQ5D?=
 =?us-ascii?Q?brJ66wHIDKY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nJ6Bx1eE+u3r/qsyFhEFGrIV+zaLBPviL2MSd7s12B9qosiJjJgtCFxhNRQa?=
 =?us-ascii?Q?GsV1OBMOPv6OmMLQpnLQqKu6mzvU/9+6yKoW71O9epyJ+xbUtnI0BVbgNvFo?=
 =?us-ascii?Q?MTTjCPzMmfaiakLyXs6S8+J2ohLEeyXbc9SUI4/eiPE3rMutDc0M8N7Y3DXP?=
 =?us-ascii?Q?YjvbRSrbdDmn3oqo0o/VxdeiCOUHqIVXbqErmpC/P+2Okdnikmw42aQLfIyG?=
 =?us-ascii?Q?46vUaIFL/nqxjvfucTf32RQPTG456i/TLJt5Mqskg5xAFJmefDeCJlaRMKw4?=
 =?us-ascii?Q?Ny2zBVq1mDYuQuyj4/mMPEJSYufnWAwdf93hIGrtEtQQy6ELxPqO1QqCrqDp?=
 =?us-ascii?Q?KhbzrDd4rVlldPiHhZue59g3YrNotqpfiyRXdRs+mYB6JjlqEmNFfsBjMNgz?=
 =?us-ascii?Q?ci+OUezh6GsNtGY//0GJ/kqaefFqBnZWHZRyJEjCszp8FCycSHE37JdQfhrq?=
 =?us-ascii?Q?J/Ae51YCNTSmOg+7IV7BAsl2hqfLvBgKJN7kSa2KhJ2boF8dRd3Qrpolkpke?=
 =?us-ascii?Q?5mICE4o0/292LkgOAtVHyGNg5ZjuEhU0K7TdVN9Rdwsst6u4yRCdWGRNxW2e?=
 =?us-ascii?Q?5RbdtwOSlOvu5MLKN9EYpGFrZQtHf2WG9ovUPkGU1amZVoKDXCZlBerK0YN3?=
 =?us-ascii?Q?IU88pV/sCPKGjnNw0p3az1ErNUJHlsAHNkpxespA18T3g5r6VF02bR/n8xj7?=
 =?us-ascii?Q?AX9mPqh1D5obxajTDPiyt4C2odbNCkkgIq4Ev6mOu+HmQZ4lu8U5aO/PVrbZ?=
 =?us-ascii?Q?XkOEYRwjnx5dwTDRQx9HqMnsPPIySQkhz7PSxmZTtOCBXZ1mBAoToZXvnSzV?=
 =?us-ascii?Q?l0c8TBNqEEFGE+lLBcMt+LOxUm1KsvR+GpLDiUl4IooPJOzqdERMICrdQoiF?=
 =?us-ascii?Q?zLaVNBppLUcXdc7jSeM3oSm4QEMiTAE7kbwnJf8/NM8WO0e+8pDBIpnSVsdW?=
 =?us-ascii?Q?O5aOF57m5afD9ooImt9lM5kO/9PBRNcX/dROOmZRtrigtl26+ChXPFfw17FL?=
 =?us-ascii?Q?whCQoPlXYrl+ZkAO70x+OM3ExPvA7wfpm+j2YyBBZGrRY73EfxVQt3aV3rJX?=
 =?us-ascii?Q?WJFEDfMY2+sBetKvjBCRP0098awspRSWwJu9Gmm/JZNiA+tt6vzylvzfqoSK?=
 =?us-ascii?Q?HnMgGU1TJFxAZBnudsvEVqG1b8V0IA3CT1xS+VSZrMGNv6LhBQjJRVsuHTLJ?=
 =?us-ascii?Q?38nnFibLhnw/hhqXxUhTee0kwQlUGdMwOlyiMASeaqhfDkqZEPMMfRYvod20?=
 =?us-ascii?Q?K7f6JRMPa/6gzlA5BJMvfUeMFuiaKQZk5HZDViFe3m+n1zFQXDKzYi3FOn8H?=
 =?us-ascii?Q?ipxENJ9Y33hUowJ/eTkOr06MiMUuxn/6ju5lEkfH1bz5PXg8jBIQobfoJ14t?=
 =?us-ascii?Q?Dgua92vTtTPqmkoj9mspfZZRF6Vn6tCmJkiykh0yZ49OkZ/MTrPreLrroJCB?=
 =?us-ascii?Q?cLoCdLgnu0iYEToq/MHUGcXxfoY07+z5qVHMHJ304t0EJCFpcw2UzyqU8mJa?=
 =?us-ascii?Q?Qn5zi9e1azigQYfgX9Z+i3rAGn93XxyNNg7qxE32oJySAuGtyRdCyo9xHA39?=
 =?us-ascii?Q?Ci0WRGSQK5k9+pbVZc6MmhBmcz4C4bZBA2RFA/qmYCekTew7xPh6mMzLZc6o?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xcn1MkNPdf1NnhYL6OK34G+PfkGdpJnkcVZHYGqC6IqgDAvv1R1KnKOfSuYQUTeys0S2Jx0rJ4QcfQvJqACyKrP5TWwlDjRR5cgZlIcKZYqt4pnbK0VduXttgaRRwRARQq9eIvqxjqxM5jXa0W6QGdDY0RZxNn3O4g4scw+2m8whgy6BxWWOfhiRSdqcAtX0rz5ZevSATua7ZEKeKF3XZ36bw7mm0RdiJ+4wLflx0V3nwCqXZufwub/qFV10qCO4e5ityZhyfbB7khoaQ2ufRz+KJmoqJ2vH4SOlZy/cytVu+gDjB42YQIdmfLETqmWLO1xMyWRLQ6BsG/5hapnwuTIXfaiG72NiAv+C2XiwAF4KdEZVVnkkBdc2kNOzHCxr2pW7CBJAYWSoyl0hO1EQwGmNen2FBRq6qo8GgWUxzo7dYUOeqtAd+qTE4ykadfRao+2ImtwisjBufJSEFtI23T7MD8lox9msTRaqIFUCLHAZZN7iijydRZ74StE7kxg3Zni5NYbVT1pILQq5zd+T1n5RPup7rmAbbprv/DBoevG19sxDbhYMR+TcaAKI3JCbCAU1uF6mLltXWwm07q5iSgNTxLS0rclatV4q4bZ6c0Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ba13ad-6288-4017-a114-08ddbf4d179c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 00:59:58.7239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqKurtGZJP4ojRWeZZe+G45RvxMJ3aSGImosxV9+1sxqLIHbNlAaNrXiuCRkDp2hmczg6vSGgSnKf/v4riuHzJXNbOncH04LoiuGtF/UXTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100006
X-Authority-Analysis: v=2.4 cv=WtMrMcfv c=1 sm=1 tr=0 ts=686f1092 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=RmA6VkjFzPJuhqsbX-0A:9
X-Proofpoint-GUID: 78Vy77Bte5xWlXVuZKaoCPjOEBb9dfUP
X-Proofpoint-ORIG-GUID: 78Vy77Bte5xWlXVuZKaoCPjOEBb9dfUP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDAwNiBTYWx0ZWRfX87+p3+lp8mz3 nJsKLYEM6b7EDhZWCF78qebmKujdc1m31Ar20z0fSUMOKqJUgNI8CUNQMP+WbsjgqZSSQDANaxi 5blJwuslrEyiPvaLng6EDoEhKswySqveXMIa9LA0Rcnn7StZmN5aqe6DHbs8CdRqpvJH8AKXrNW
 qnMa3Oiv0Odg1hglTFyZUo1b9bmd/B6chJAP/Kk8GIOeoIxfoge5XlM81IHeh7TQCdt3zndthtH nFfJ4LKtZwDsMGZB076pqBMXmSzzmF6KXupSxlmKFRL4I6daFjw8IbrxDX6kb15uEmJ189bMXnY aYpIpBzuFUlvVYJXGGC8a3yvnmvCFliSE2bGFwHhRXW1AxRTD+WJ7WOh57X6HHjbDtglF220FWu
 zFPQd+YvHPt10T4+Kk6QQJeN6zl9GgeFRNJ5fHlFu8fo0GdCT7OdMJN54iHEYpxRNvLyLkrF

Define ARCH_HAS_CLEAR_PAGES so hugepage zeroing (via folio_zero_user())
can use clear_pages() to clear in page-extents. This allows the
processor -- when using string instructions (REP; STOS) -- to optimize
based on the extent size.

Also define ARCH_CLEAR_PAGE_EXTENT which is used by folio_zero_user() to
decide the maximum extent to be zeroed when running under cooperative
preemption models.

The resultant performance depends on the kinds of optimizations
available to the uarch for the extent being cleared. Two class
of optimizations:

  - clearing iteration costs can be amortized over a range larger that
    a single page.
  - cacheline allocation elision (seen only on AMD Zen models).

A demand fault workload shows an improved baseline due to the first
optimization and a larger improvement when the extent is large enough
for the second one.

AMD Milan (EPYC 7J13, boost=0, region=64GB on the local NUMA node):

 $ perf bench mem map -p $pg-sz -f demand -s 64GB -l 5

                 mm/folio_zero_user    x86/folio_zero_user       change
                  (GB/s  +- %stdev)     (GB/s  +- %stdev)

   pg-sz=2MB       11.82  +- 0.67%        16.48  +-  0.30%       + 39.4%	preempt=*

   pg-sz=1GB       17.14  +- 1.39%        17.42  +-  0.98% [#]   +  1.6%	preempt=none|voluntary
   pg-sz=1GB       17.51  +- 1.19%        43.23  +-  5.22%       +146.8%	preempt=full|lazy

[#] Milan uses a threshold of LLC-size (~32MB) for eliding cacheline
allocation, which is higher than ARCH_CLEAR_PAGE_EXTENT, so
preempt=none|voluntary sees no improvement on the pg-sz=1GB.

The improvement due to the hardware eliding cacheline allocation for
pg-sz=1GB can be seen in the reduced L1-dcache-loads:

   - 44,513,459,667      cycles                           #    2.420 GHz                         ( +-  0.44% )  (35.71%)
   -  1,378,032,592      instructions                     #    0.03  insn per cycle
   - 11,224,288,082      L1-dcache-loads                  #  610.187 M/sec                       ( +-  0.08% )  (35.72%)
   -  5,373,473,118      L1-dcache-load-misses            #   47.87% of all L1-dcache accesses   ( +-  0.00% )  (35.71%)

   + 20,093,219,076      cycles                           #    2.421 GHz                         ( +-  3.64% )  (35.69%)
   +  1,378,032,592      instructions                     #    0.03  insn per cycle
   +    186,525,095      L1-dcache-loads                  #   22.479 M/sec                       ( +-  2.11% )  (35.74%)
   +     73,479,687      L1-dcache-load-misses            #   39.39% of all L1-dcache accesses   ( +-  3.03% )  (35.74%)

Also as mentioned earlier, the baseline improvement is not specific to
AMD Zen*. Intel Icelakex (pg-sz=2MB|1GB) sees a similar improvement as
the Milan pg-sz=2MB workload above (~35%).

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/Kconfig               | 4 ++++
 arch/x86/include/asm/page_64.h | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 71019b3b54ea..8a7ce6ab229b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -395,6 +395,10 @@ config GENERIC_CALIBRATE_DELAY
 config ARCH_HAS_CPU_RELAX
 	def_bool y
 
+config ARCH_HAS_CLEAR_PAGES
+	def_bool y
+	depends on X86_64 && !HIGHMEM
+
 config ARCH_HIBERNATION_POSSIBLE
 	def_bool y
 
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 5625d616bd00..221c7404fc3a 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -40,6 +40,13 @@ extern unsigned long __phys_addr_symbol(unsigned long);
 
 #define __phys_reloc_hide(x)	(x)
 
+/*
+ * When running under voluntary preemption models, limit the max extent
+ * to pages worth 8MB. With a clearing BW of ~10GBps, this should result
+ * in a worst case scheduling latency of ~1ms.
+ */
+#define ARCH_CLEAR_PAGE_EXTENT (8 << (20 - PAGE_SHIFT))
+
 void memzero_page_aligned_unrolled(void *addr, u64 len);
 
 /*
-- 
2.43.5


