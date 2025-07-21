Return-Path: <linux-kernel+bounces-739688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 069F3B0C9BD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9D351897010
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321CB2E0924;
	Mon, 21 Jul 2025 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nuRDtEeP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="byGkPlaC"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12D52DECB0
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119264; cv=fail; b=J3lLQtvH8xCW2rWPG3bxtHgdtJu4DqjQWZNM+i0ixlJHXpRIXOaG08qA7UCPwtBVaPu3S+VlE7xHNxZv4Gde4NyuhMdshF8t15xV4AF7fCi8DqEF/NzLzS8taLZGIc5fl8b3mdum65ZgEbnSdBo+clhZmeydsoKothOenXpeUCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119264; c=relaxed/simple;
	bh=z3QId1VZwuJ4IiQBv4ysQIXwXLB4mjoTwm+moSl/YeI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cgvdUotfK4ruVQmAQYfpzftgSMtBkH01F7eHEfNJkevqFYfNs6q7ufOyqX2QhZzMJWDj/AZUWGvFrhC7XCH56KXcU5px6dgRbEb1P2HtSkVFr7UsS2y9sPawEmGMc3ioMuAZuWq+D1agHF30IkopqfNw12LOxRqDiDgy7+s/8Uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nuRDtEeP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=byGkPlaC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LFQf2C003199;
	Mon, 21 Jul 2025 17:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=K1JrJLl3gw6HjQnZ
	5VEd1kT3CrkPDpwSH8FEcgCun2U=; b=nuRDtEePvKEE0jSTUg5XpbG2KMuskUPv
	Jir4C70hT0Moua1O+1IERneAWpZ9+/i5y84y8RoN5rYF6f+v8ol6z0OW2E0+4/Ty
	hQZxwNAhpIVTiSnVtPF5BrM67Jvv0Epz4cB1B923eYw/Nut4MpmzH/ZN2S4wbigu
	ZZ6cjXzunJMB3ugJIHM7+5NdeGbm3V8uS4Ng5+G1o7b/608qFbTrK5vtfJ6j6FUk
	khGDo9Yg2gBn+yYn2DcGWaxoLtfybkXgJ0QzS2AXy0+oVgkQNPpSc0ZuAPgG5Cvz
	sN6zmKITDiS1/In3Pf5iNLsbcnrqP8BKSqkWrVySbiKNtMYH1W/D2w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805tx3c4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 17:34:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56LGsoEH011025;
	Mon, 21 Jul 2025 17:34:09 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801t8bagn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 17:34:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zgb9K2IOFrFhtzhUYM61iR0MHAiNW/R6X1fyI/CLBUH6SMTDrf7CV4rFsTycZ5H4g+OeW9XDE1/nFzOnjL77nPDlJRyDOgfaotNLjRv1i/+r9uZdKCR8BcmUR2dZpQsYN1wfay7Zc9zvVc90wcdWcMeZvBPXxpbwLFWVzK+kIjdCfHBzUBUqX7pl3gC2SQ5j53GoyvU//r1vcfwVKSWt1qLjiszqBoo//I5mEROGxSYR+/daqEGmdWKkvrL/bkikFZ04vSVtWsVbd5xomhQ67nb39IBq43AtTsl8vjR9OJW4oRD2+Z23Kvgv9WWmu5e25qvYqtXM5bfWdlLChdg47A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1JrJLl3gw6HjQnZ5VEd1kT3CrkPDpwSH8FEcgCun2U=;
 b=L9ZhwGmgeodGoB72bJKxOyJe/eEuB2mBi1r+vtBewEyrPqjXWoCjj1zlMW8xBRsKMxdAfcnUIGs/mfeDQGmm98XX6jHsPdmPPQgvvhFH5ylr/PK3t8XghPhOstqRk3LlfG9SFHllE6pARc/9ARWC9M5y5+3eaJ/GAWLxTtLZ6noJgQIxaVG0zVIhke7bmsUup+BGApH7+q1AjbzPHDFQzZmlBbPTr7tERZcpPPwPIyY0irhkck17bRuX663MCOoT6C58I9eXjfjHrsk7OMRlpnjJbswslyPvtBfKx7tcycnuCzHWIXDCq1odpt80X8Gc7lyGhl3j+ZtP/ukmLP0yNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1JrJLl3gw6HjQnZ5VEd1kT3CrkPDpwSH8FEcgCun2U=;
 b=byGkPlaChX2Mjv6YTVQAcAVFgpf4Pr0IFEOnhaB8oR+mLy/tjVXGZ0eS6ljkkwKbutchxsDMivJ+rhbp9NdcvLRXc0TL189haxMVgECVlbU/GgjPCQMEcEZGXlEPQDmXCQ3bfQUH3yNebwJLjPBMjLX3pO5nGJ9FIpOaSR4ivzc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB4632.namprd10.prod.outlook.com (2603:10b6:510:34::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Mon, 21 Jul
 2025 17:34:05 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 17:34:05 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] tools/testing: expand mremap testing
Date: Mon, 21 Jul 2025 18:33:24 +0100
Message-ID: <cover.1753119043.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0150.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB4632:EE_
X-MS-Office365-Filtering-Correlation-Id: af2cd34c-8f75-4357-b03e-08ddc87cca4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9E5TobXJtebgaesNJ4uxJRkD0478xJxwz3WConBKhfSyWeDDVFMdRWzC/zhE?=
 =?us-ascii?Q?HdZa18kKHC9A43jE89uIQi2mYDlAwTm1/rW02P3zTAnjXEZCS/1AKs0PP2TP?=
 =?us-ascii?Q?USYmN9MiVLT/WTCS0AszlPfydExIv5bNqrIBbOBWHjtzY6oCOsBrh0cdI9r2?=
 =?us-ascii?Q?0K2Fx9kppTt+GAb9MsE0j59WNr3AjsO1Vj9olaZHOcKpA6On0GCyRjme4f65?=
 =?us-ascii?Q?GX6Tq3BD/thTzYrvrG99m5ovtb2bWhXn4c6dgViWqDuWITkOPs21MEq0yCR3?=
 =?us-ascii?Q?B3s0cYjuuJ7suiVRvTaCAPGYusK7BXqAtT0x7FHU4kerAN++G0k0PHK+dPeM?=
 =?us-ascii?Q?VQyVR8g+0jEetcS00CiNfkXap0hUnbEJrwa71ntVLznkpDs9zQzZP55A0E9G?=
 =?us-ascii?Q?mspsbDVhQBRDEmg2QZcS+VAUJ7CSnr8XBWnGIKxHAE1PIJH2YJgoUgHaOg5I?=
 =?us-ascii?Q?f3RjmVDOg/ns+39sk2+vJLZhE5pZpkvq/cO7tlFKFjM0Uo9pU/OpZmLyB2oh?=
 =?us-ascii?Q?JVQtUxYVNShmHwoDye0PoXlh+FEb7MOPHWRIKKVd4zM4rYVPwP6zjukiv6sv?=
 =?us-ascii?Q?Hb+HXmW9uX0FbFHgxG5x1JPRgFm7eEn7oCeGrz8Z1Vumovxxu1+mAAhjsIzO?=
 =?us-ascii?Q?XR4FbxjG8NGKqzWiZIxRpkqn1uT27MsBvtiq1l7DRaa/Y6nnHvve/3WV/Ro9?=
 =?us-ascii?Q?EPcJIRMaGWwseUqkokukPOazhcPQzV+AuVdTOL5/BTnM1B1880HiExA0yaOD?=
 =?us-ascii?Q?mIcDRluI+IsSb0XbMIkaxlj+L2KHjQwgsmRwEUz1ZGPwPLl+fK2AMuNNcqrZ?=
 =?us-ascii?Q?U3Pste81NuARHcOWb81ZTaMQJV/WOmV5l4kiV1UWri8BxXSDmPUx2GG0YJq/?=
 =?us-ascii?Q?sOIyxoTawBxIMiAss5rzt4ca4ssvsNaiuYdX7VLp5KrEhn0YiOz+FvyhIkbq?=
 =?us-ascii?Q?QcTo6yGUAq9XhYoktNOIGCbyvsL5ICqDNxR9aviMDNSKbwG9Vn3XGmYGnsb7?=
 =?us-ascii?Q?UONQW6ZOdLVc3Us8rbtN/iz1kF6z7l7VbtOVAp/p1GJUVD5MfVZUDgCc2fui?=
 =?us-ascii?Q?AaWCwH4rvvIvfgzTUPocv7Nkg37lF7GrNgq1spUkWE2gsacir3tELnTqUR5y?=
 =?us-ascii?Q?zcG8x6YZkz5tH5R5FyvtPd0iabVF65Cjrk4lOv2jaG/gC8KgZrrG5z0D/dNC?=
 =?us-ascii?Q?RMJ36fEqc+HoJlBiMnFOFiHEPMLDb/17pQ5ZR6mk0POznnd1085btHrhtTAa?=
 =?us-ascii?Q?1Z6W2j3s9aYKeKg1AgwGIQeqO1a/7pqYyYAWi6DsOiQSPIiOlZT9ENRWVzcB?=
 =?us-ascii?Q?zTsSJwz+U6MRqIfLgPKQ0MTEqIQvmGRwOHA9Bf2OWNDmXj92+G2EDbIJGC+I?=
 =?us-ascii?Q?aOvoTV5pNw9LAd3Hru4QFvBghWoTVc2FojNCHnvUV+d1zy0Ed0PJIGa1UR/K?=
 =?us-ascii?Q?7PZmTXRDF58=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jysKfTSNb3P9760OiC6TzJFhM6q8sauJja9YzewOJweTOdLGVwYTGRJOteLG?=
 =?us-ascii?Q?8CiMjG5t664SzerGqMI1TEyhrpNPljg1nIeEjWRhOCA6erHrw3+n0Od0UE6m?=
 =?us-ascii?Q?jZabmlHkIoLnJ8cqj0KQU4Wuu6kNZsaGPeJPMEyc1ELasOmYHhxb+ayIPPBX?=
 =?us-ascii?Q?maQuQZFB+LChq8U6ZmpUThK9C1WSmgQ8nLNGfgje+K4VvQ+0XtjXuhHN4UfF?=
 =?us-ascii?Q?bpOGafn9cykFvCLtiRcQap6d/Z0wLQ8p8d4XR/PoscsX5mT4gjcoNC+MFs0w?=
 =?us-ascii?Q?F7jGvRvbcyER6crMRx7vVBNHOnCIrNGfOCFAEZ2J3cRUWCs3hw+Ex2ihDz8m?=
 =?us-ascii?Q?fYlLoLmLBzOa2QbA1u1b0l1HTzsRCyvofVc5M/XuYplq2LIHbR3AyhL3gdEw?=
 =?us-ascii?Q?Rrk7JlhudWja9HBJLnVI11FsAneXo9luqMng/XDbGqxvb1Im8RZHLoRmzuZo?=
 =?us-ascii?Q?+u/WaZ2ogNUbcJH+YZ3b4g07AVwbqThbj7yKlPVnG43/cXEtsSbFuYKhdbOr?=
 =?us-ascii?Q?s3rZiYxQa7sTQRVfTh94ZovC37/wbNAW+wyIbB8G6vMidEZ3EUtRab5hx9cK?=
 =?us-ascii?Q?zjRjK6/Ys/SdY7iCXhzNV2LABsJPb5urlXGzznIEy5yLTpWkGHayCpRVY0r1?=
 =?us-ascii?Q?3ZdcWj0jx3uJ4xINt5GZCbvdGtoBE/rs0V8QJAptqCPoMhjHrLCePZYm7rky?=
 =?us-ascii?Q?J7EEsvHWUDaKs8lqiouQousykG2FaLmIORsqCuanelIN8fPZgEBZRKkdE8zT?=
 =?us-ascii?Q?56VXBSn/UPE3/98rHdOcXnxphmFOrYztb6+1c6jiveX+Yg6Ulxc8+00sC4xv?=
 =?us-ascii?Q?vzTx+ul+kL5sM38XK1w0MzIAA1mDMFiTisNmHYgG7lgnfQ4l4oDWOH8DDRbz?=
 =?us-ascii?Q?oVwBw3MRLa79l8bFJz+ETgkY95rj/ONm3k+pTBm5YBwE7T0TJYvT+J4mV8A/?=
 =?us-ascii?Q?ta2uEE05m9IWd9bK4i7w47KPbf10vPlsL3UJvYoRbdSRcZOwZyym9EgPVV+Q?=
 =?us-ascii?Q?PjHlMcAvmlE1ZKJ03yeOfoCJN+stzzSM/Cxy/yvZd45+tJEc6t9kos1+HVJe?=
 =?us-ascii?Q?ybSS2ygjk3tn2LaTn4m5nur+Ghx/7WTg3/zZPpb8NWH7L0/jJSBe52exKrJE?=
 =?us-ascii?Q?lkA0n7y2DkKhdqC6UckjpLZc2RvaeVFpS8TwL8ftEei/svWo2ByZ+6TMHfRO?=
 =?us-ascii?Q?N7ObgVWT4nuG6lk+MbaDbS/54yUOcXEtACbWmi0mjFkOPL2mKLhl1AxidRDf?=
 =?us-ascii?Q?kkgvkF4Ii7Z3etk0Sxy5pakDbm06YI5UUO8ldMGmYTm89mPKk/MjPRlPIgzV?=
 =?us-ascii?Q?25hGiviiuhQpAhgPGaSdoc87wi1/C8IDr/TRdswm+1FEu2y2pl22kmDbCf9e?=
 =?us-ascii?Q?HNJ7BjO1cUFmmQOpxknD4hOF+JFBcX5mI6AkWg9CdVkMTpBCIFGcYsxxeodJ?=
 =?us-ascii?Q?lXRx6VbbuNAeFD2iD4winKtU/e2NQ2m0oJN2tdkB+AZgWo2IqSbAZhcUsXDW?=
 =?us-ascii?Q?CDF2nGycRsK0T6JY3lgN7U6OuRgT1pNGj/fVMRE2aPmt2yYDhwXPc6D4EgDS?=
 =?us-ascii?Q?KpJgRH/gOF28omNNKDw0Ck9A61j8zlGcOuubwPw+wPzPn/v6ZLPdNjrOn5Wb?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EEfcbWobTC9sHzmDgbZwv93GxbmOpvqf8MkbnF8TFTrPUqhacogbstaM4ZjjDQPzMZtAvbVl/3++EzPNtOuvHApAte3rbEbnMbiLgE3D5sck71oeTjPu+Or+UcgczRgoxpJxI3qELpwFy4BUMs7mB2oWbfv4Jv+s9j7194ycAdyxW/RWphnaA2JMbmAd2adw7rlbthKrN2bV3aHB+Zza+yYgGnf2JLsqgwuQsZpvELOT2k4WHOr3n+etMPvaRihzCIoLk1KK+smX6tn86E+ZXVuuI/eVkZpM7CJyUmeT7/PDC0NcKjLqntf9CaRjjIe+ah/c5lDqJ4qMT1QoPpsDFC5T0u28/DhCE3lOmvNuSslEPknDlXxoXnRsJzOuLMu5morZB9FtCSVSoW1IrJmFu8XLjZBGBcMM357MoPKQIgDpVPjxOEvVDb081SxC5s5vmB4hJLCLc+JPR8HKMNGKCRb7TUPoK3V00ZVt/Mi1r8uYJzmSyZr3AO0tSriY2yUb3BCdsBtoN8x2GUyEmdEYXmrFtBQVQeh5NnDPfxqsqZlb1U4e2n5GzKuv8F4C0BTUzEtF2oZXb4mlEY0mzajUc86s3P7Nxi1yo+fbiH7FpIM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af2cd34c-8f75-4357-b03e-08ddc87cca4c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 17:34:05.2747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q6TsrUMCY3tLr0nsg6Uag8g0q7MG+0BoG7NoVWQqPN9YHJ1zVYUrUPv2rTaCWbTNbqK4xU2J42qqj5RGHpEtGBoESLSLz4tWD1tS3XuwflA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4632
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507210155
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE1NSBTYWx0ZWRfX4rKJMmVpI5/x
 lOp4UfLv2IcmqPTlf4s//E74eQuOvDpOKUCuC+h8mcH5ZSE5nCn8db7ww8rsUlrVwlLm+ipWg3M
 +oypwYRst/oH+pe7Tucdx5oo4gmqoelU6sXRylq3ToJbKVYPXMNXC17MIKQrJumcpEcEIkzYXIg
 Qu4FxmwXgH7cTVQQ6XjMJqPw1CUwZ7yk9JATj0cP7NWgoDIEEgoreoEffw7YsMjcGGAT/UYgUcA
 W5UCGn4k7xagfV1pbKMacpuZVqUVZBlcOzmHmDsFmh3FHgjzb+tT4WyKAUUpzxfaAQ2SGyYAFOh
 8dRaAo5HKi+dXcnEN+BaeHn9NfdO/0i+HGniNAI7z+DjInRwwN0mTbl+A2AESjxLG6/OOiH6/Mp
 70crpFlDLTdtm+DedfOAhonBSh9F/i07GVcjWL2eF/vjIivJaSQdze3cvNz9skv55idKBjct
X-Proofpoint-GUID: wckEyOegQ-pMzHazhcV8y5uOPVqOQnQb
X-Authority-Analysis: v=2.4 cv=IsYecK/g c=1 sm=1 tr=0 ts=687e7a11 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=JXcecBNaQGpbR_Hj-d0A:9
X-Proofpoint-ORIG-GUID: wckEyOegQ-pMzHazhcV8y5uOPVqOQnQb

Expand our mremap() testing to further assert that behaviour is as
expected.

There is a poorly documented mremap() feature whereby it is possible to
mremap() multiple VMAs (even with gaps) when shrinking, as long as the
resultant shrunk range spans only a single VMA.

So we start by asserting this behaviour functions correctly both with an
in-place shrink and a shrink/move.

Next, we further test the newly introduced ability to mremap() multiple
VMAs when performing a MAP_FIXED move (that is without the size being
changed), firstly by asserting that MREMAP_DONTUNMAP has no bearing on this
behaviour.

Finally, we explicitly test that such moves, when splitting source VMAs,
function correctly.

Lorenzo Stoakes (3):
  tools/testing/selftests: add mremap() shrink test for multiple VMAs
  tools/testing/selftests: test MREMAP_DONTUNMAP on multiple VMA move
  tools/testing/selftests: explicitly test split multi VMA mremap move

 tools/testing/selftests/mm/mremap_test.c | 235 ++++++++++++++++++++++-
 1 file changed, 225 insertions(+), 10 deletions(-)

--
2.50.1

