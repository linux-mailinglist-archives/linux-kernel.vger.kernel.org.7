Return-Path: <linux-kernel+bounces-731942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CF0B05E36
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D5B500175
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB562EBB88;
	Tue, 15 Jul 2025 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ccNlOzOr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IJgnSKpD"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA532E7BA7
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586691; cv=fail; b=CzGM8BgciamKRsVSbZy5H829999QGpY4681A18W1M2uvOHDIN9UNNXKQMo+qY1Z2sQZ7DqeA7EVys6/OicsTBcevfosRxlbMxHu9JKYPlJ37iikmt1z3srWvb20JfnoaY6Z2aCGlsnPr9ZrNaX3vC40tVCRjuYlylGhOolnoJQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586691; c=relaxed/simple;
	bh=eTCfkkfuA2Kw9C3XCHJGBhcU63i3HvEcQPGJN1FnYZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=giGN5l5VmrWDP2CyiCvAyy7j94ylxwb7RHwfUqmRXXHrtKCusfoiiASZwkVCZz814AT4mTfny+ggfpeQPipqMzB9INBEAyaDq8LnhIkouF39Obwa0KWWCDKBqbg8lsC7MQGb9snvaZ+I735LHQpRguqTGeDlpQzrwejn50NAyZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ccNlOzOr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IJgnSKpD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FDZGEH031330;
	Tue, 15 Jul 2025 13:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QptOdQPuFn6gVdQ/d/mqna3NpamIzZFF0u4BBl8kB4I=; b=
	ccNlOzOrRcWrLyKzWGKg3/y0gN6o5B8cl3fSnczoPSfh0OpNvdM/KU7sRTYOWUJD
	qL9hoZntTK2clXn6jL+/3/DhNhdQrT6gly/VQPeNyrzjQMSapuEjIMDLQsZKLcDA
	elaGl1nVQOG6qDoNrVq7p5MnPjMmEawgpBTLJZcDCaGW83Dej5kqLouLWBqY1sfd
	bIjHUJptCwWgzV9y6jkBp06yxFYqgo0gxrEMPp2FHvNA9ja9zBMV89SG/SHvQzB5
	09hr2S+k+5i1reKUCQ8Hz85xl0CVkWlqDtwQm8bgbaOhM2Po5E7tbH0n1zIqyegw
	9BPzmME7geiwrdk/EvPU+w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8fxpax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 13:37:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FCpu86030307;
	Tue, 15 Jul 2025 13:37:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue59y8w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 13:37:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yl1DEOf2E9rcuiBugLGXWRV7CsIspvtqOrutt23skMZHMVMhPxNYxxWuq6cQnBVZx6atq84/mDI2ZCdUZB2Y5+OAIWcHEOy4ANRIequ3Y0vZHCi8epBI16RWRNXAMBYJzWoXf6V3Z+ZRG1mk0Rol69PXQ5Ut8f2fTpkKKQY4xNaJX55uoYaOtX1VvtapGTN94EDWS+Kj6iiAnExbm/Z0rpodnsKtXixyw2weNnRHo5eG4xqKaUJdQpzn0mTDUk7jbnbjrpw6vzbODGBR82/quoVe21zmQdu1hT2nfl1upoDDTAD38c5ASa7F51CzrWB9PRkPiu/qWeGqzOG9l8mlMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QptOdQPuFn6gVdQ/d/mqna3NpamIzZFF0u4BBl8kB4I=;
 b=VDezCS4AcIhS9zwhO3/IU1evkDt7XjQzAAcz8/YKsqrSpRAu5zBvfmRFsnE3a2TMLo4vrLZ49W6h1oQJ+CjYUty7P+aMdQJCEvqSv/whkKLhqjTSQCO4lVzBqU3385Ev139YeVmUuoJ4tUReGIUsTdoIRkoNzdbvQBWqihvfWRPb0H6qJZxcmbXQQsT9DAjIy1C3PG8cHGVJClLp5vziKWDifPWHubeVbm6I0aNKNDYgH72YGj+9qvCliWf8rOMEJ+8IycTj2ktAzZXJ4+WpuE5PeJ1aHmgNs9ItUgflYsn+q4HVA1x5O2/t2siX8wTgOKq4LUuXHW6JmK5+1xBMGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QptOdQPuFn6gVdQ/d/mqna3NpamIzZFF0u4BBl8kB4I=;
 b=IJgnSKpD18v4EDedAtoF6fZkBSm0pl9f14SaT0OXu5UD+F2TwKnuVOcxYYmGHthl/d+X7mC1+iFjWzUsJQ4g6/GXDwB7UXwnUmGQ55wvXHm0xZ9Hhw9Xi9kA8aSSK64AGomU9H6yimMKwAjMtsTwIU0e+S99MAU1QBy2btZMHCc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW4PR10MB6370.namprd10.prod.outlook.com (2603:10b6:303:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Tue, 15 Jul
 2025 13:37:52 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 13:37:52 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v2 2/5] mm/mseal: update madvise() logic
Date: Tue, 15 Jul 2025 14:37:39 +0100
Message-ID: <bbbbd8b8b1d0bb2cd2f63dece62ed8d773cdd4d1.1752586090.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752586090.git.lorenzo.stoakes@oracle.com>
References: <cover.1752586090.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW4PR10MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: 915e63fe-2d94-4629-8dc8-08ddc3a4cc3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2t/ccTmNLs5pi32X6Fq0SQC/JSegoiVMcazl/RUTkti6OYZYH2p3IXe/ZU3w?=
 =?us-ascii?Q?hOyw3LXifD0e3Nnz2uDJTxmU8LxO0SfCbI4K8NQOSmxL0tEHHuXsEjbPKinU?=
 =?us-ascii?Q?ORpEtgGVFepd3/tG4/yudKxeKJiT2ZRzFgNrKAn1fB4lWq3RWR1V9nRRu5H7?=
 =?us-ascii?Q?pLQUB7qTuDYCVR5d9oIsUOoDQtun87vsR1Nzg9aziEOjUmsHBlR6kDynRkEK?=
 =?us-ascii?Q?wjDaqDHr8CQKthflnEUAzIBlJmVZBJ6NWo3UCD+4vvb3jYQRSSqaNB0sVIif?=
 =?us-ascii?Q?Sm6IXt1hYJ+rENr7y0/8nayY16Jj1LIoJ8AkdctuqoSX96f29bGNlxyiW+9J?=
 =?us-ascii?Q?sNMuYXwfiAN3CbU8Z3hP1rNqMSB0Xi0K89osuoW0/k3nJ3ps7cfOtvI0KsOM?=
 =?us-ascii?Q?txc/wZoBtqvPD4vd8TJi/aVqJjrmN4aw72KgQomIYQNkkcDogB8ZD0mW+HpA?=
 =?us-ascii?Q?oqLAJatAqyA/106zL7V5P5V9WfJnd0q0ya/nqTFJhn1pMBp9JFYFcekSpRRU?=
 =?us-ascii?Q?ocFh5mPDoIhwNqlSd5g9szdnCRm9kq+pGhA2tmqJgwOjou8FDiF1JfOPkvzZ?=
 =?us-ascii?Q?QBNub1zwU/ydInmpUv9duj5beU2XqvxMH7VUVBXyQCo8tzKgCuJM/94YjRNA?=
 =?us-ascii?Q?Pe2Ck6vDUfYpXxdPqe4We1IvmJTTTi+j6kVUebWKqZnHdo6FChDkaZ3R+H+N?=
 =?us-ascii?Q?9zBMFqL+t61mjtK9m6uOvd4qER7RXTOmXXuqXNicoNYUltMToVr0PiAIOUWi?=
 =?us-ascii?Q?NRiyMushTwQsVS4WkogV/QkSpezEP6hTV9G71sa60+wZep1imCFEmTFewe/q?=
 =?us-ascii?Q?46iJvcWrV89obBnb+EbkB9FrO7AYWWnN7i7viMggoFciFBpOi8caf8+s0Ydg?=
 =?us-ascii?Q?wwYjJBJR02zF+elDmgiPqjDlpvt4m4iVAUZw1DnJXLy/aoz38FqUu8SB29W5?=
 =?us-ascii?Q?fTIjlrvFkOucReiSm6qjceGX0K3DuBWD6A7yjZgQo6mrZmzAx/jSO6hP2MXX?=
 =?us-ascii?Q?ZSCs7PAOF60GckRbr0MnAgT6YdjdHUhQlzz8nPI3HDK5vu8J0rgMimh7XmVx?=
 =?us-ascii?Q?t6r8Idrv+aH/i4QqYL50h59eM1tMeM6fxTD01pPSNDOrpnyKfI6Kfofs4hAl?=
 =?us-ascii?Q?i8GRSDLLpErdTC/tEpfVesPIFGEpUnRoGZqJMhBdCmrxgOPOiGnBRDirzrIX?=
 =?us-ascii?Q?DQW5LoDwMUR8I0zVmx8emgW1QQRfEf52sL1HoyOr++MpdT0tNxrVcB9yyXoy?=
 =?us-ascii?Q?SH59gg1/botrA7Pzn0yc9rb82SLXdrsRk2yly23DF0rlZH3NkpE4Ttpf9EwP?=
 =?us-ascii?Q?9Jtmg1wCF1VDALZuil2o0Zqeysgd/laZhmCPSTR/4LIhVLqz+Rxxm2pC0nAP?=
 =?us-ascii?Q?nWpFpj/PxC8/vp+fDL3MfUxytrdzSGcA6UW6Ed47NPrxI4yGaCVVu86Fy1dv?=
 =?us-ascii?Q?moQH2XhX5Uo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gM/uSMFmbEVeLbimzzBhO+UGU7c26NSn9fQepfW31bzxHO4Oy7xJ9/JH6+Xr?=
 =?us-ascii?Q?Ti5lojQwyxBaN+G3TQRjm7NiCDG/Np43j538M5hLLs0TZK6oKQesCaNTc27o?=
 =?us-ascii?Q?8RWFuWZPxLJ8Uqq8NVOvqru7uKjWaxEsEur9hTE75e8Cru4D58T6EC3cW1zf?=
 =?us-ascii?Q?gVzllfwPuRysbLikXtauCYN69+K92lT3nwIhF7nE5FcuwDhHOoSUbBdN2EQo?=
 =?us-ascii?Q?PbS463HNgvfE10lcveAByQWjYu6o7cR+qjLnD5id6j+MSz2H0MhBMsV0Jkzr?=
 =?us-ascii?Q?sGyIaDg0hp9MxHPSL5DyrzjP/IR15pe9r1nEfVZd3YnKswLzaE9+KQ3fe94R?=
 =?us-ascii?Q?RKugTrEPo7lhJ1MKdevsuCijectAjYy6X/fVEhAZxXmqqDi26tsMkxUoYS9A?=
 =?us-ascii?Q?kSn7Z/3y5SqK0egByTpdcfxEQEQV/R4uwmwaqPfly6TycLvdb4WObR4kQdDW?=
 =?us-ascii?Q?t9IcVXLbdh7wKJ9pkIyXhJv3uJLY7bbHhSXKxyubWSHefNtDFu6IxXJe7Ywm?=
 =?us-ascii?Q?nVEmZuukmhXQKW9h1YuCUCTnKqfDfOBrVg8WOkS01RtV8JSitsvflnrn59nu?=
 =?us-ascii?Q?ih0gWRaZUJN7GYkTerjqwRbRt15bUKLWSbKr64tNlwgDAbvlhyBGeswf0Grl?=
 =?us-ascii?Q?NE/VfXsa4GiApoqQPQedsdzyO7cKlUCxbFDrJn0CecAtCjJp8FOqqimgQjbO?=
 =?us-ascii?Q?DacSsoUSMg9G/NNDWtsb4GVwmFu/frs20iD30Zuu6OSJQ3vbT4lv9ScinScM?=
 =?us-ascii?Q?pOWo/qRZg+XU9h2iZ49HdT0i67LKTAUTfa7Pacjf+RrbjNYxnO49mW+cdb7f?=
 =?us-ascii?Q?tVKdW85py4lsO+1HK0w5WXd7xonaXgInztJ14Ap7uSfhPA/RSZnJeGQv1e1m?=
 =?us-ascii?Q?B+GRYA4Ty58yK8u3lhPiF+K/qEOxx/RYIUKYz0FMIFnIT7k2d96io1n+OXUE?=
 =?us-ascii?Q?VJBCxGovrSOW1l0PsRPEZnaiMWSVj/WUQRIetcirJgxl+wZdMQFhKtaVfoDI?=
 =?us-ascii?Q?Nsg6SRbrDOl48Tu25P0iTkPnj3GddFEdPSy4dY+XREZ3EypsZkvtLW2kEH6F?=
 =?us-ascii?Q?I3UBmqcU4eKnspoyFnyFOCLC34lYcWfa5FpuO/BHucsKARhG7ALpjCeHt9sD?=
 =?us-ascii?Q?M9YrlOWF7hJx/ye8o/DWZXTa7ANwmkHg/SKD6oPEYIWpHNGQMitryw6z6iDr?=
 =?us-ascii?Q?TGj4RaZSkVpTZGNUqdKerRrnpz1OdlwQCuBNKPhLmuIbDQTDgihEfwlj6duY?=
 =?us-ascii?Q?jKfBBjY/3HfBis00r0ROyv92aAf0TwXkyNCEkHAiakHRrmKaNNDAVTijJaXs?=
 =?us-ascii?Q?j8gKtwVNWUfXm3/Nrv8YfGnZLmYGB/iINJIb91j1WQpzXzB0fpGGFXpcjB14?=
 =?us-ascii?Q?L2yle+nNOl6ObtRxJhseluMs7yq3QMwd7WCPzyrAH/OBXXva6WNy4d7lxBbp?=
 =?us-ascii?Q?4JJrsnhBzgn3CG5Qg3FB8uy41ck7koWM0PrsR5KEvjMZKHQSKqrKxUmVSgPC?=
 =?us-ascii?Q?fuZBGFg4k7uD9XRQe2fDbdDE+uxN2omFbdG4kX6BhNFvQgypPJKZF+CJaCEO?=
 =?us-ascii?Q?dvlIWIc4w03/oiFYspaGtDwpT3nuas1Svhf9LxUbFlrg/0lpSSlzD+NEbiNk?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Vg9KELI/9UITGZeKAUwL5Hk+lIYxx/SKFsl57yWo3ixFAK/95mKPEgw8Lxtbg3cpxZ/q7VSzLwgQn31D4mmXwHGAkWi/zAkDjObdYPZeyulUsdK3L4UGCnKPdCI2gNzOLrnlkTJ+e7mrEgm8W0KbDIv+evvxc0iDfBEds90xoQwXdFGHf5BuUO4kRe67dcaJzvQI6KEtrjzDAQqmZnAQxFC9xMY6hBJn09FB3UqM/a8Atamn57CGN4ZDJglivKUQj5iDxuRCbbrm6Fi87POX58CKdPoYTPvHYZr9za7XjvmDnb3bbMTDOBTeocsaoxSLULXdw4t9KUte+884e9vrx766saiqnUxtW0aHeiGSQY79EIe9x1eS5kyyeNEkEunE2BZFL+MdWm9yaccc8td1/uNt/VkNKiNuPtI0TdzRJa9YODFqV5pUK5IAzu2CrO7wBLiR3jwHtu61sIl8iC57Y/q0xqlCUg3Nuu567Lxd5MeyCkyvPvxBLc6Wpy1Wi6ZWF2LLwofv45Cd93BxXTIuTPiKomUuIzTyKmawyrYngQliNsqNn0TYsAdM+4WvzTLay7Bchy6RdQUOnLoGT9paRrzz7Lx62ThMWn6gUKOQmhc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 915e63fe-2d94-4629-8dc8-08ddc3a4cc3c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:37:52.5703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vdhAX5wrBtdS9/0dvmSqJe52rJJO053lCo1hF6CwnS2/1hI+c/gupXmn4d/LKMiL+Kr4ldFAJCF/r9foNOJGSj1LBC/DfT9/tTuInUvXmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6370
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507150124
X-Proofpoint-ORIG-GUID: PTYL0hLAM8f_yobdsCsvPvo0m9dgROmg
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=687659b3 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=2PFmxa78D7MNR3FRbQQA:9
X-Proofpoint-GUID: PTYL0hLAM8f_yobdsCsvPvo0m9dgROmg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEyNSBTYWx0ZWRfX2zH2kE62oWNq pHV+vsq7JexH4NPya5eFOD+/gUipa00H82BP5DnksZ96L/5dV++STdlCqUj8JrT8bZkrPXArxu6 O29GDPGI/roe0vBv8LicuIAWmlPHGSG/0ZcWyZLsgHHd3W+jsyDWP3lzBsV1u89A0qzhf2wRyyw
 Fobg2smLH9e6Ep4rskhs9dG+7xBdSoioHBLcUPQU83TW4CdL9j+pxw/WpokddL/szRiGZzeT1kD htleHDyyhT3e6TzYVGbqpu/PDqPWHI2XURQ9Q4NL7HekJykEw5e0A1/cJFvS+h8vQFuB8psTPGT hGXjcff0oQ/CUJZxDdZ9enG4E/ec5+q3P+dV9Do16TQba0/jIqVzpZLqLYxotpSZp4VHtx8GhSa
 Six5iMTryXmuVjp/IAEihsLmD/3LW4CXG7dYTlw/Ms+Q3P62aL5pLJ3zkvRRaVbcrE6kx382

The madvise() logic is inexplicably performed in mm/mseal.c - this ought to
be located in mm/madvise.c.

Additionally can_modify_vma_madv() is inconsistently named and, in
combination with is_ro_anon(), is very confusing logic.

Put a static function in mm/madvise.c instead - can_madvise_modify() - that
spells out exactly what's happening. Also explicitly check for an anon VMA.

Also add commentary to explain what's going on.

Essentially - we disallow discarding of data in mseal()'d mappings in
instances where the user couldn't otherwise write to that data.

Shared mappings are always backed, so no discard will actually truly
discard the data. Read-only anonymous and MAP_PRIVATE file-backed mappings
are the ones we are interested in.

We make a change to the logic here to correct a mistake - we must disallow
discard of read-only MAP_PRIVATE file-backed mappings, which previously we
were not.

The justification for this change is to account for the case where:

1. A MAP_PRIVATE R/W file-backed mapping is established.
2. The mapping is written to, which backs it with anonymous memory.
3. The mapping is mprotect()'d read-only.
4. The mapping is mseal()'d.

If we were to now allow discard of this data, it would mean mseal() would
not prevent the unrecoverable discarding of data and it was thus violate
the semantics of sealed VMAs.

Finally, update the mseal tests, which were asserting previously that a
read-only MAP_PRIVATE file-backed mapping could be discarded.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
---
 mm/madvise.c                            | 63 ++++++++++++++++++++++++-
 mm/mseal.c                              | 49 -------------------
 mm/vma.h                                |  7 ---
 tools/testing/selftests/mm/mseal_test.c |  3 +-
 4 files changed, 63 insertions(+), 59 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 9de9b7c797c6..89205693b67a 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -19,6 +19,7 @@
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
 #include <linux/mm_inline.h>
+#include <linux/mmu_context.h>
 #include <linux/string.h>
 #include <linux/uio.h>
 #include <linux/ksm.h>
@@ -1256,6 +1257,66 @@ static long madvise_guard_remove(struct madvise_behavior *madv_behavior)
 			       &guard_remove_walk_ops, NULL);
 }
 
+#ifdef CONFIG_64BIT
+/* Does the madvise operation result in discarding of mapped data? */
+static bool is_discard(int behavior)
+{
+	switch (behavior) {
+	case MADV_FREE:
+	case MADV_DONTNEED:
+	case MADV_DONTNEED_LOCKED:
+	case MADV_REMOVE:
+	case MADV_DONTFORK:
+	case MADV_WIPEONFORK:
+	case MADV_GUARD_INSTALL:
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * We are restricted from madvise()'ing mseal()'d VMAs only in very particular
+ * circumstances - discarding of data from read-only anonymous SEALED mappings.
+ *
+ * This is because users cannot trivally discard data from these VMAs, and may
+ * only do so via an appropriate madvise() call.
+ */
+static bool can_madvise_modify(struct madvise_behavior *madv_behavior)
+{
+	struct vm_area_struct *vma = madv_behavior->vma;
+
+	/* If the VMA isn't sealed we're good. */
+	if (can_modify_vma(vma))
+		return true;
+
+	/* For a sealed VMA, we only care about discard operations. */
+	if (!is_discard(madv_behavior->behavior))
+		return true;
+
+	/*
+	 * But shared mappings are fine, as dirty pages will be written to a
+	 * backing store regardless of discard.
+	 */
+	if (vma->vm_flags & VM_SHARED)
+		return true;
+
+	/* If the user could write to the mapping anyway, then this is fine. */
+	if ((vma->vm_flags & VM_WRITE) &&
+	    arch_vma_access_permitted(vma, /* write= */ true,
+			/* execute= */ false, /* foreign= */ false))
+		return true;
+
+	/* Otherwise, we are not permitted to perform this operation. */
+	return false;
+}
+#else
+static bool can_madvise_modify(struct madvise_behavior *madv_behavior)
+{
+	return true;
+}
+#endif
+
 /*
  * Apply an madvise behavior to a region of a vma.  madvise_update_vma
  * will handle splitting a vm area into separate areas, each area with its own
@@ -1269,7 +1330,7 @@ static int madvise_vma_behavior(struct madvise_behavior *madv_behavior)
 	struct madvise_behavior_range *range = &madv_behavior->range;
 	int error;
 
-	if (unlikely(!can_modify_vma_madv(madv_behavior->vma, behavior)))
+	if (unlikely(!can_madvise_modify(madv_behavior)))
 		return -EPERM;
 
 	switch (behavior) {
diff --git a/mm/mseal.c b/mm/mseal.c
index c27197ac04e8..1308e88ab184 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -11,7 +11,6 @@
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/mm_inline.h>
-#include <linux/mmu_context.h>
 #include <linux/syscalls.h>
 #include <linux/sched.h>
 #include "internal.h"
@@ -21,54 +20,6 @@ static inline void set_vma_sealed(struct vm_area_struct *vma)
 	vm_flags_set(vma, VM_SEALED);
 }
 
-static bool is_madv_discard(int behavior)
-{
-	switch (behavior) {
-	case MADV_FREE:
-	case MADV_DONTNEED:
-	case MADV_DONTNEED_LOCKED:
-	case MADV_REMOVE:
-	case MADV_DONTFORK:
-	case MADV_WIPEONFORK:
-	case MADV_GUARD_INSTALL:
-		return true;
-	}
-
-	return false;
-}
-
-static bool is_ro_anon(struct vm_area_struct *vma)
-{
-	/* check anonymous mapping. */
-	if (vma->vm_file || vma->vm_flags & VM_SHARED)
-		return false;
-
-	/*
-	 * check for non-writable:
-	 * PROT=RO or PKRU is not writeable.
-	 */
-	if (!(vma->vm_flags & VM_WRITE) ||
-		!arch_vma_access_permitted(vma, true, false, false))
-		return true;
-
-	return false;
-}
-
-/*
- * Check if a vma is allowed to be modified by madvise.
- */
-bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior)
-{
-	if (!is_madv_discard(behavior))
-		return true;
-
-	if (unlikely(!can_modify_vma(vma) && is_ro_anon(vma)))
-		return false;
-
-	/* Allow by default. */
-	return true;
-}
-
 static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		struct vm_area_struct **prev, unsigned long start,
 		unsigned long end, vm_flags_t newflags)
diff --git a/mm/vma.h b/mm/vma.h
index cf6e3a6371b6..6515045ba342 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -578,8 +578,6 @@ static inline bool can_modify_vma(struct vm_area_struct *vma)
 	return true;
 }
 
-bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior);
-
 #else
 
 static inline bool can_modify_vma(struct vm_area_struct *vma)
@@ -587,11 +585,6 @@ static inline bool can_modify_vma(struct vm_area_struct *vma)
 	return true;
 }
 
-static inline bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior)
-{
-	return true;
-}
-
 #endif
 
 #if defined(CONFIG_STACK_GROWSUP)
diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index 005f29c86484..34c042da4de2 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -1712,7 +1712,6 @@ static void test_seal_discard_ro_anon_on_filebacked(bool seal)
 	unsigned long size = 4 * page_size;
 	int ret;
 	int fd;
-	unsigned long mapflags = MAP_PRIVATE;
 
 	fd = memfd_create("test", 0);
 	FAIL_TEST_IF_FALSE(fd > 0);
@@ -1720,7 +1719,7 @@ static void test_seal_discard_ro_anon_on_filebacked(bool seal)
 	ret = fallocate(fd, 0, 0, size);
 	FAIL_TEST_IF_FALSE(!ret);
 
-	ptr = mmap(NULL, size, PROT_READ, mapflags, fd, 0);
+	ptr = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, 0);
 	FAIL_TEST_IF_FALSE(ptr != MAP_FAILED);
 
 	if (seal) {
-- 
2.50.1


