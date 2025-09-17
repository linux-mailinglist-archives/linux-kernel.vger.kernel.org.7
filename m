Return-Path: <linux-kernel+bounces-821133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2310EB80839
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AF30466A33
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C61433AE89;
	Wed, 17 Sep 2025 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kwvYgIdO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xUGtEjAJ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F44D335959
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122720; cv=fail; b=iiYvM+c9HOIToAG2PiDMwnVSEcppIG+vjpOIkEYlUc04xD/ehhgdcKl8C2Gz2Oh+VyUAXQPfcIjiJ6veGgH9eF7KdEZbl8YzN6jsDmHfWcAyKeHOLYXqMyA4kOoS41WrpRB/mHqDElaLI3t6xfA4zcErpQlFr3cOBwwJv5EVgJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122720; c=relaxed/simple;
	bh=PI11IiJNpueuSek/N5RHTcF0onbWw14WA7lVHibfTvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KEvKL/l5dtUhuh88dqXF+/UntifpUFLM9vZTJBHNdP2Rx96TsCWfdhC5Syosfyg/a9OWFk4i7qWCQW4qDdvRm8vWrsF6LIOO1b3aR8cKNcPAn6OUZ2WF0YJC3N9i2MRKS+U9JcyTY9mCq/jK/MA/Gpuywf58rrdZtADTa/rU2lQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kwvYgIdO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xUGtEjAJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEIWMf010251;
	Wed, 17 Sep 2025 15:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cE8XrSts/PudR8Gp78fb4EZIA5enTOcxBz7UItwHy80=; b=
	kwvYgIdO9uR34emOJkLiw7LfWSf0Yt4wHbODE8wbEpQuMgrpUDPlyqlk/53pHgPd
	VYrJIU+n7/7k+YJisZBAo2r/l1fU43cIxJlHY7RpLA0t+8siCXOxeXozXrhqx1g6
	x04pYLQQd4S6Dzqkvun1a+X4+p6QgpD2hyvh/CP/2ctcXZNFu5tpV4ZIZ+fmm1Rp
	FEVXXhleDGQnByebVWujyI8gYju/FfVXKmEdXJJ5Q/wc78uKRaGozjIYgbA7NTbN
	Bc2D/4wKA0wD/ImAMzlWy5gif8gVv0TZp/GPaOsaXlTi1DB8ncm9WlNBO9UCQjcK
	GpMM8QhubKoYArnGtkTnCg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx6hhdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 15:24:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEnin6036777;
	Wed, 17 Sep 2025 15:24:56 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2dxupy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 15:24:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a25i0Fax2aZQnEj5Yf7KhKIx8kILynZ3ABVZdvXqVTVaAur2zYgR/+LH/3qa84DkwgSKw0e+SqCIubnlPEyGYuibLrqLvJjtv2RRSkgGu7LEXT+9MTRMPC9Cm/bmi22zBDxSDk+V6NJnsN/6wUUBv5lnEgxlmc5qmx3KdS2hCnKvQLrpgx8S9VpCrH4deaysdaqz79J0cujXGlxcULJX600hh4XYhLDgKb1/GDAScxGLCGNjJCdNq4y3YZr6xR2W37RMALHuCds+gNHtlfhFAiLjjFoGs4HzpzAAtvZ9uxHrhcq2YXfcCkQP+9jKITGSMEztE6XeJ3RlsuYhB7/oUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cE8XrSts/PudR8Gp78fb4EZIA5enTOcxBz7UItwHy80=;
 b=v16tQ2ji5JfR891jcgWYuj1VW4FHLgaXcpaSakoYP5sNBvi/QSLwsh/xdsoI1aB2dT+ci2F7FBlRtsetUI8tgjCHl2hiWrABrNDwAxMU0ZfGYvSPVqoJwKjXCxWUjr6ZGIByGtaqFrlx3yiA6Ki3DzcxNBDr3pdN9KzOaGeJ4afPB3uGrNfvHYRIXYLs7evMIXcEMYMJW3/WbnftfKg9Svz35Rv06hbnctruFP5rU+2SObn7/lBfHMXen4QI5g3ST0gQv0myyt4oOfQRQLglUQVXH8/pAbqoDAy0PcrGIvE+NQAbGOqlmgXTH58RjOVDdzv71zL0izHkzG7UO6hiHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cE8XrSts/PudR8Gp78fb4EZIA5enTOcxBz7UItwHy80=;
 b=xUGtEjAJg1LM/cxo5oktb58Kik2hE1bKy7PJN/yI3u8VxunnflONSMG9CE71bPV4ev0/jLpvqTVpr2L6ZNLpBc2EPwp4uHp/gXbnDmulSdBXtjN/ksT1z+Fu81UDFiuWTDwsPYhHrCYpA9uQMxoqV6xtwHrWP74Xd33ZduV+oD4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB4942.namprd10.prod.outlook.com (2603:10b6:5:3ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 15:24:22 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 15:24:22 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v7 02/16] perf bench mem: Defer type munging of size to float
Date: Wed, 17 Sep 2025 08:24:04 -0700
Message-Id: <20250917152418.4077386-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
References: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0215.namprd04.prod.outlook.com
 (2603:10b6:303:87::10) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB4942:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c9f755-051b-4708-6534-08ddf5fe4707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/dhireHz+vV2G5UxxbC1q5fw4i6jUbhldKr7mKXwYjj7tOPFe2r2YP0MYBZH?=
 =?us-ascii?Q?6qX4bc8dnIWx1Yg2MMPymD1xIv8rydMy18yIRU8sc/av5vKgFMxjbNPMoqeE?=
 =?us-ascii?Q?pWbSYk6Tp6zheJi6xlQ0JUYhwiu1nv++sQU1gWmN7a0r0pnRtT2dkarCq44/?=
 =?us-ascii?Q?oj7ITrbZK8RQAUWrfV+/ygSRM2Ui5mBRZrAqFlYFlzBbQVLt+0zNBRjUZEp3?=
 =?us-ascii?Q?lrnXGdplLXSOzsK+mvvSrwBy0RdbUyN7sJQC2EAW7dhMsOqXj5DrGltWdKvC?=
 =?us-ascii?Q?i9v+RPzaRpdfQnhIrWlKx+EzVOuWqdXHTBdmh/Jo+GPXNKlzjhuJ8w+cPP8Q?=
 =?us-ascii?Q?zk6dR9TXJT5dKWDcdFPa7FwuHM3SUlE5oKlqMvI2yMsgCB0Wo2RDP7TDEY1o?=
 =?us-ascii?Q?SVv/ITdrl3MYfE6op/15zRxuA1X8Tkuh9xeFCYdxCWWTQbQewk6a0rFvi7Gn?=
 =?us-ascii?Q?hG+/MES7BSMflJk+nySQ2YZH4ZP3wz+83lWRAYHUd1cPz2+dvoAA2mKCb4FI?=
 =?us-ascii?Q?tJ1G+YN79WoAbcg8mCSEcFaug2FwP87HigYOBmmZY0L5Tb1d/A9pfCAAaUe5?=
 =?us-ascii?Q?mLhfmRoebtsnGcUtTT6xV8GrewCPzfJQpMN0H1ip0CjoxwM5TkfN+hfw8RCp?=
 =?us-ascii?Q?03C9XxHGmuQUV7d6JfGKVKW5dCtgdu7shyV/ROkAoKQu7FLfgNvm5YxehKro?=
 =?us-ascii?Q?gJIm8R2PuOLtqAqZUabmxuc8FUQo4FTJ+Q0oCkXteGa6zligXCKyg0YpPD3Q?=
 =?us-ascii?Q?Ab/2vVN90/VME/jh3Vf7I1Qphj0SVmRgDhdB7vl8nRx1ps3JW41/atOc4CvG?=
 =?us-ascii?Q?GPXSyP6qO7dnYn0jPZO5FnqybFm/risceSOJV/CrwGttxx6nehR77fvbfzjF?=
 =?us-ascii?Q?HkCG+j09fM84EXlCGFfZVY470L5jgcHde83Ne+OEhO0AQqalXIaoO1D+kfzB?=
 =?us-ascii?Q?CuUpm2P22cqJcRxx3eY6j3/9yYFYnoKP/av72AxU0S5XTux5NwO7BHJ4Wl7F?=
 =?us-ascii?Q?+0XLlqNCbQu9Xw3rRRPQK7vzugLHpRAD0VOFzcWNPHdeg7Af9vgHK1BpGlF1?=
 =?us-ascii?Q?i14v4FuoTGlmPCItszYSQW5xH61rJVSDCXFuEo+8y6ec5pQVXJZJv5t7XPiB?=
 =?us-ascii?Q?RPw6K+P0UuygMnxx8aMo+Xi8H3U97fLDjqxsGbJM+hmwSUg6jkRvB0GGVRVx?=
 =?us-ascii?Q?nB85Vki8XNyT/reIg6/t5Gdrqfyw+Qh7xNcu05rB1Aw/0VbStgbsyKb65R3h?=
 =?us-ascii?Q?tERJFi5ww2/RZTz5xe5XF+CT2uodsfoxnJqhERN4SbEJzqXpuPg8NYsDSaHo?=
 =?us-ascii?Q?+SdmFSirlzvbtLnngf4L13DKpZeuIunkjIx2t/VjcyyjS5K6IeFMDDPRRcLB?=
 =?us-ascii?Q?BRQadtY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s0sCFpsXq1E/PEC2WL0Nu7cUzJ6wRe4cDpi+OnjV+qSHSpDr1Cf3sfkYIVN/?=
 =?us-ascii?Q?EkHhCyuX84baxzE2bJT3uZwi35BmDbrN3NYwbt5o55uqmkayW789nCTtqpk0?=
 =?us-ascii?Q?J5AWJot1ohi486iwtUswqo4fHuCFvONOThE1TNaMxiYEBJ4/IX8oFaT07EAt?=
 =?us-ascii?Q?4iO9EHhGHxrg2QIDLxJ6sgvqkVvOSrXp3XwMnbz70IbjVn9/COl9ZLmtYfwv?=
 =?us-ascii?Q?6Zvfhb9ErPJR4iGO8kanSEI8O58y71XcX3SwAOlPzuM5aiGRXQotT5+pEE3/?=
 =?us-ascii?Q?GmxsizpxnANq54eUwCeTVbxIM8bcM8jNn7J6z4UBCLFQaft62MNAcuFkyu2b?=
 =?us-ascii?Q?oYj6J5a6vcxkyKML8K29wIwN/tnNy4t0XWhD+qYIEdqT1tykxQ7lK0tGSlaI?=
 =?us-ascii?Q?NacX1qr5C63dseMFYh6xHfeX7tgYSdRKT9/NZL30u8XSVoKMVRU/GBeserVe?=
 =?us-ascii?Q?kWz28kS6h6okloMPFNWHDHWaZXkk/+mXI/KhLOkuX6oU0JWPos2lxxRQyNJv?=
 =?us-ascii?Q?RWEbv/aHlgaPTMb9oWeetKxzXvtUPXTaHFrOKA/zxVFOSUIUFWGgsDTFU6jz?=
 =?us-ascii?Q?QkPyL7/08vTcfLePEYdM7xrHTFHaDvMJIJHhD8FPSH+4oWtTMm1WfWwnsOhm?=
 =?us-ascii?Q?O+1SvWRyIc/kd3qbvTcAfgO7pPD+ngwuaT+gJiA6DYqP6YrU0ukoMpCjlS4U?=
 =?us-ascii?Q?pzbNDtYL54PjBGv27gRBoj6YHEchD9Ils4P3ibHoxp79j2NBEzm4DgXBJzQ+?=
 =?us-ascii?Q?Y4EFsRfVuRfs/CpPdJv1p9ZzHhLEqmCmoCpxZ+vSv0UfX5JsYh+vj0urWeWr?=
 =?us-ascii?Q?iRmB15+qmX7NxsSB8sDi6dH55wi7koziv7UFCa1r0ymnHmZ4SKjS7ifVV/Va?=
 =?us-ascii?Q?NKHPLQymoul41VZuORAvTCl3cTwPAmpUSB6PrjpxeY5581KlNHTBlzKTHJXr?=
 =?us-ascii?Q?bgh3OzeWNwl4IavU7+6rSzEhCDnU/aX2DqVwfnXajjUSVFrDUmS6+5ohD3t6?=
 =?us-ascii?Q?sWeypqwzCsPvUdq2kxC0r2vdOa8vsCoF4JN6T0Wf1cKTDQX8taez9DtXSssW?=
 =?us-ascii?Q?RYLmHvlDmkkjpwL0zJYBEYu8RwRrHufO7jYdkmW8+Ik0Z7p8r8eNnNmmZbIn?=
 =?us-ascii?Q?PlFOGTIgBOdDHpY2hjn8uuGaPNDYnUOeUW+GJ6nFYcoV8517t7DFi44QWmGF?=
 =?us-ascii?Q?16O5DC7JmCNWz+qVyP3Y2UXBolcWyTo9deTVWJi9YRPeWYxYstCQUlYIdagB?=
 =?us-ascii?Q?Oq6C1PbkAgENFmx7WZ+vUEhYCwpZNGDaGXj43BWTuq/uC3BdKcPvhIP4RoL9?=
 =?us-ascii?Q?H3sQQAkU+ESYnbzZcWfwcUZwMSkBz8222QKyVqOunvVLqfOdsBawbmLbjWGI?=
 =?us-ascii?Q?KOXiFM/VMTVHH748+iEyAR1HkYbYixD9WkujntKKPXpDWAJpyLwfAZSUvY2u?=
 =?us-ascii?Q?g15kj9vceeNlKJgiUkCsQw9lelQmH8b51+SxENlyo0EgV58gDKXwzDQa74fl?=
 =?us-ascii?Q?PQaJagPYgArGJ2FnNJN11m1cyFP0XEKaBMOlEbcWJomBTnrcPd3Sk8zdwIoM?=
 =?us-ascii?Q?alC0oEj7/ukKGOlhazd2JS37Xaua25W10xcOeWsXYv2MxBSsZkYigWnRMQeE?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XKF5xk1qdkfyVXNyXBo8l7gwPJvon6aarzwdqK6ScUIVDsMFw0HE/ubjrlCRI84sEbg5936CUMaMxEhPkrf8bA/FuUbXR/V5mtPNCOItgz57kmfDEkHrZuHyWg30nPyVqcZXCOGcE24BQGbrEYZ+Nm8IoSi28mwKygNPtKwI8ji4lig3rsxvuINHrKFy4QeXwIeDp8FktE/4/LNWifAGfMr41tImU2+cymCFMhtdSdHOG8exKU1T+mWyqzFQC3bXOi6E3983uiSPFXp+P9ZFa1z01J6CPuinWhdm76Y1HborXdLomqPfgB2l3dKsI3gRMBybsPr7kV5zravtRtmnHanchc0fNco8Ytaz23Rx7AbK4FN1xvgciL64rImWpQ0RynSu0w8Uy39trtB567OpRZaPmXcJQSypE/7qLkKkphwH0LOnRYscshmeNdYlJaFxfZa89Z6dCrzngQaIRtGAa7SqpQbpsEve9oCN+FABzdf8wNKNBiOjnEjyGuqwgzp5gkRRTynL+qIjqSduH0ECzHggas5Qe6xF33Y1ATEFm+k+dKT9D+mWYX/UQ0La5TlaDw1EArnUd43MY3O/TKY8WZXKtD/IE0RmdT1gYXhiQeU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c9f755-051b-4708-6534-08ddf5fe4707
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 15:24:21.9842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yKyk27KnbG2wzBiTdSZceqdPqf+bl2/Q3HVErU0PgIqzv4fXoniskJeyOtcK7dwpGxL2Ot2RC6xTRaJm6PCGsAhD48nz09hFvWtYCc9OyEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4942
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509170150
X-Authority-Analysis: v=2.4 cv=TqbmhCXh c=1 sm=1 tr=0 ts=68cad2c9 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=X4Au_8HLBps5sezr5J8A:9
 cc=ntf awl=host:12084
X-Proofpoint-GUID: A84uJIapJ3zqFBkwa1R-pZgkTYm-SVx8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXzP43j2CfsHhD
 nfU6h5qGjQOTNMpGo6RsuSkgHsK4ULWsEbtJdcZ0uC1hD2hACdE9EkX62hMCi4zZYpmUYxQfIsr
 5gcgxqNB+97Ma279Y15pCnvbNL7payXK9Hl49alzzRbiFKVx/66T+RhXRJjIFREgEh/IRyQjPt3
 mzd9JHWbPeyB89IQ4+Sz0D/l0iKPmkX/l7jHPrDXGILrv0b6McEZhy6d0BXhmmBlSIKoTooHOTs
 NifeaNWACL3v09FQ+lWguXAS4DkpHyfTctEIYD8KA8V+xO/emm5ODfkH8yUk6FSoJVYoO/wgfo2
 CQFKHcHPocHsM1Vy/ImYb0L5sPIuMiLrm+9DpMMXPMNY+SY1ZniMTC1MxjG5Ud6tVnJDWxsLV0F
 BH9xhBjCgekJAH5d4crduwj3F8LZlw==
X-Proofpoint-ORIG-GUID: A84uJIapJ3zqFBkwa1R-pZgkTYm-SVx8

Do type conversion to double at the point of use.

Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 tools/perf/bench/mem-functions.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
index 8599ed96ee1f..fddb2acd2d3a 100644
--- a/tools/perf/bench/mem-functions.c
+++ b/tools/perf/bench/mem-functions.c
@@ -139,7 +139,7 @@ struct bench_mem_info {
 	bool alloc_src;
 };
 
-static void __bench_mem_function(struct bench_mem_info *info, int r_idx, size_t size, double size_total)
+static void __bench_mem_function(struct bench_mem_info *info, int r_idx, size_t size, size_t size_total)
 {
 	const struct function *r = &info->functions[r_idx];
 	double result_bps = 0.0;
@@ -165,18 +165,18 @@ static void __bench_mem_function(struct bench_mem_info *info, int r_idx, size_t
 	switch (bench_format) {
 	case BENCH_FORMAT_DEFAULT:
 		if (use_cycles) {
-			printf(" %14lf cycles/byte\n", (double)rt.cycles/size_total);
+			printf(" %14lf cycles/byte\n", (double)rt.cycles/(double)size_total);
 		} else {
-			result_bps = size_total/timeval2double(&rt.tv);
+			result_bps = (double)size_total/timeval2double(&rt.tv);
 			print_bps(result_bps);
 		}
 		break;
 
 	case BENCH_FORMAT_SIMPLE:
 		if (use_cycles) {
-			printf("%lf\n", (double)rt.cycles/size_total);
+			printf("%lf\n", (double)rt.cycles/(double)size_total);
 		} else {
-			result_bps = size_total/timeval2double(&rt.tv);
+			result_bps = (double)size_total/timeval2double(&rt.tv);
 			printf("%lf\n", result_bps);
 		}
 		break;
@@ -199,7 +199,7 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
 {
 	int i;
 	size_t size;
-	double size_total;
+	size_t size_total;
 
 	argc = parse_options(argc, argv, options, info->usage, 0);
 
@@ -212,7 +212,7 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
 	}
 
 	size = (size_t)perf_atoll((char *)size_str);
-	size_total = (double)size * nr_loops;
+	size_total = size * nr_loops;
 
 	if ((s64)size <= 0) {
 		fprintf(stderr, "Invalid size:%s\n", size_str);
-- 
2.43.5


