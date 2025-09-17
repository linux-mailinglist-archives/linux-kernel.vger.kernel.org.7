Return-Path: <linux-kernel+bounces-821132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A1CB80836
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47CB466A24
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EDF3397DF;
	Wed, 17 Sep 2025 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VQrkAp19";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XAvuifQ1"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7E6335944
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122719; cv=fail; b=RmT6ZOGoxoJH+FoD1lJ9rrIAJjuDpwxIZYfqFhIk38BWAV0hc8TBACyCnjvuthzJ2wNBRCF8PhLlWsC2gk5xtJCFZC0AnKT8/NtawIGJTirZAU5zGgvvWMtnShQeArLYTs58jeMrrNlQr/l0jfAIEDKvZ/ews3C1N3c3VIjivkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122719; c=relaxed/simple;
	bh=rxzYvBeS7MzwzRCh4wsHnCtMqLlXUYHZmifC+h5Koro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oP79FQm1HoW1z+D/dN5EO6IU4nDZ6ZbKtDhR6WwH7J+6YBTh/FHKBeOCBpTY0BcoSwHhPEH5+Hy1E1Y1gVqXxVLjJZvYxCveAQjhiPqLdUzOrtwYB05x1FSqbQmFoMH9Et3MtNSa3xhZGjIZWL6i7sjl1+0HE6fGaJkhblI3HBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VQrkAp19; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XAvuifQ1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEIR61001799;
	Wed, 17 Sep 2025 15:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0gtPsevvjfTF1ExhKn4sOeAYT+OZvZoqZh6GdkcevmM=; b=
	VQrkAp198JBsgzW0NFte83yjpQk63xuK1RMFxkHZCSC0Su3f8ODILlU+/RVQgVUM
	ZSW88393kxVAPw5Om2r8hQHAMBtsYJ56Bxpw5yX0BOq0eDL5WE9Mkzfxqes+Ro+V
	St0DwEIEPkxolv75aAErKGXZO6cwLs+G52gvdWV+rC9wT4R3N4OLf35yypkv+Nx1
	HJFuOvxi11bGLQ5ESjn+46AKadhJyH0v/BffKVuee5N7dsn+WrIIauIRT2hKd1yI
	lv/OEjgNVLbJqCN3jsWO3dkVQLmkXNFpkiYr3nYbP7yXogkhGox38jn4bmFDSCCE
	2WGwGlf6cWb6AqE6NaG6lg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxd1gwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 15:24:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HDxEIQ027229;
	Wed, 17 Sep 2025 15:24:41 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010016.outbound.protection.outlook.com [52.101.56.16])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2m7116-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 15:24:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eapRurKy+YUxB+XIZN6gS9nTn+B6ZqvX4amoINB/Luctk8G0DVNNCypODCKOEO9vuvnIIluUH2jwBVKfCGGm6DhigXG2wRKojEAZ5o4ZCd37fyoapw21FfxDWRttPqtt8mat0IMJqRwqy6FBqJD6A/eNIFoTOYD27ZqgppS9MIPkm4m6sRbRZaI+KImZT/vE3uA4CxWVm3l83PYfjXINPT7pMYtz7w1AVLon2Ae5mDuZbE3uVCsJpGCSLZBMjeHJvGZNvUu/+fkobxolWh73tR2OPYEi2vEJFs099PWk9EkcW05XZqOGA/3JohcSAQJRd8pNGxee38xviQea9f+rkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gtPsevvjfTF1ExhKn4sOeAYT+OZvZoqZh6GdkcevmM=;
 b=gHG5Os1IxlSmZA9P8rBXg2VLCJSqHyBy2/N5GEHGV+gQ9CMO2gJzQNSBVz27jmMeHyEZ9v52J/aUgzkkS6P/0/ylOfzJ29nZa3Ax1c1YCeO6r5RyceBfPWEqctgpr+Q7CKYpmMfhblR8hsuozE/BiTZmuso9ZB8lnfuZDi+QIkMB2BQZug/YkvkZA+EEIZxEGXOpZukYQkCX1hz7AnMxbXI9lqbdeVE5kH73L7F4Ul9wa4IR8DLFHCVDXP9iZ6pEWEBRojKb7+pwCnfPdi6ZHdhLL7qATwU7/P1h/Qvt3e8YcQTVw+vq2zoXTYVddLhWYUlK8ZMC92E0hH0+22CAxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gtPsevvjfTF1ExhKn4sOeAYT+OZvZoqZh6GdkcevmM=;
 b=XAvuifQ1/kDiC9kGEjyKYrwHaAlZvjPmWQZCsAX5LmxoE8rzMzOSHg5uPA4kFi5Jq/nQ4w6E/NjJNcVSlWVQ5coxz6UNjBB1j5fzSZnNHSuZ4iIZFTLhz59VlkipMrMgLHSUGRok/6dCM0lowaMbueL4fU4+AKjBjaka0vMuozw=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ5PPFD020A49E6.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 15:24:40 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 15:24:39 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v7 10/16] mm: define clear_pages(), clear_user_pages()
Date: Wed, 17 Sep 2025 08:24:12 -0700
Message-Id: <20250917152418.4077386-11-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
References: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0164.namprd03.prod.outlook.com
 (2603:10b6:303:8d::19) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ5PPFD020A49E6:EE_
X-MS-Office365-Filtering-Correlation-Id: ef01ea91-d224-42d6-5b2f-08ddf5fe51b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mINFUdUtBgfFgR40Q7cmijKXz6AdMadQvNFbLDtlUxiOVe6I44SHdVjFwAIZ?=
 =?us-ascii?Q?GhbKEiqAQmIZFJu9c3+AuTkOCA4HGG1fm4Sql3/g1haWcYLRtlAfDHxWc4GX?=
 =?us-ascii?Q?xd+qX7mYzkN8PYrafBHe4PKLO9hs+aVC2xPj2xYsp2KCj9BoJdu9enfMcfMo?=
 =?us-ascii?Q?Gv9mMRvuRx40mVUA1QD22JuV2+sS4daIyodbv6pDH/VDnLw10YtbHyGg5ZuH?=
 =?us-ascii?Q?nq/qheehajHzYaJPJkInGwLcNwH4AOSuX4yvvHFx99mx2inJjU2nj3V0Cgju?=
 =?us-ascii?Q?vBh1/lHYubgKDvzYzFaS6cq4n+Opi95uYGijTTTiJZWYFFIzcHZHfBw/o9CH?=
 =?us-ascii?Q?Z9LAKfbE1zXpZMx6gMx2/BL4Ccgb1OFOg38e5l4Rv825tXHfYva11+3a4Qxr?=
 =?us-ascii?Q?q1MuyNrCsfnoMdcWR4hSa9kyZkM0pDRBKhGgGQakO8KzqIxdSRpJaweaKmde?=
 =?us-ascii?Q?6Ni/AN5+dkwyh3ot0MoC5QGSdKVGkIbydk4K4ExDOICy41xh+DUg2XGNAdNa?=
 =?us-ascii?Q?smCCylyJHMOm+7dIckIPi912/fNNFU4wf+lfz8HX+fDenn386vffiUSIJdh2?=
 =?us-ascii?Q?kBYHtKohx3e8EBUy9yQq7nl8gEdt+ndIq9RH9eArUVB5ebNBp4VV7RxZRQPM?=
 =?us-ascii?Q?d2NOW4tOJCt6J1y8kkxc1reuZXFSR8eWc8w8iwQevXWmEqy77BWgJSMAOmha?=
 =?us-ascii?Q?/OVtDrsYuAtZ3cYkNFu/EYi0DkQgGC1ZHhRKxlHS9JpeNlj7IsdlhfQrFvyd?=
 =?us-ascii?Q?3PnOxUtoZNpk65bgv1A+y4GtUyqWgvY1Wks7yXL6Iuf6qtkikqJ06UgXqDRF?=
 =?us-ascii?Q?oa4Vap8PveapNo+UuK3aXVqwUivXRdlu6n068t7sXF+qzWGRjzNEfqAo3PiX?=
 =?us-ascii?Q?5MQoOzNCOQvZmcfOdqy01o2L1cd6+DPYcQHbBOS84LhEo4+SBu/QjvloO/RT?=
 =?us-ascii?Q?4XPE7utdkmrOavWMSIDSuZgbW1vbgnWtGDFqYZzk+HE4QXyWfTLga0PwpfEy?=
 =?us-ascii?Q?N9pAvX4CAPYuh6rp31oboD/0z34MurJQaE4AjS2ZZ8vDd1pplwHPltH4FUl+?=
 =?us-ascii?Q?7NQhRjXd9JmLAsp0RdWXrgIvfGR4mYP6je+JOTPV1mMV7TlNv2wARiFqSSir?=
 =?us-ascii?Q?U2Aq3zvRWE/sSh3p2+jl8MtnCfz6vqPdE/Oqb4ZaZWPuzESrv1FQ6UrjIRHi?=
 =?us-ascii?Q?nizqbe9vuO4WKrpGJ1Wmzrh7Oci8UJQPc6U99C6YcfaJsNJJutKI9uk7h7zv?=
 =?us-ascii?Q?rH6dT6CYUni7Gn3Tr9yd2ys1JAOZXgheOWhK7vf6FyfUHAQ1z2y/T6R13VBa?=
 =?us-ascii?Q?g69HUqii4JVJxeW4yde2iu0cTyrfnw80WwtaLPco/C2AnpzgLECho2uMiY0j?=
 =?us-ascii?Q?RnBNjZ0HER75jRVyhIqSuNTUALN7Z5p6VY41TTnHFYiSpKe/IaNPtJ+P+/WB?=
 =?us-ascii?Q?Wvr4Xy9jrXY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FbIa5bGMTqecq2B55m9vThTNi92qKvp/pnl1xEGciTP85iUbj2xyutQMuV3o?=
 =?us-ascii?Q?MSoJzFzBCYS9LhlaCBzChMlpOaxSvlNUaelomHpNaF3vMa1hlZ4jPteez4to?=
 =?us-ascii?Q?4PC8dhdnFAjk2PjiNsathDQMT/MY4+xuoYyT4joSVrcu6T++JoYN8YevtcFl?=
 =?us-ascii?Q?JgOzbgS2vU9PlHBYFCcWRn9UJMOUhiHh9etjB3ZKmZpotJx36LEp7Hcu4Ihc?=
 =?us-ascii?Q?jtmfvEizpmbRn+/oRHOK9bXISJUHe+XCIbWXMTbM4EOC+qjO9Hxgmhz77q5A?=
 =?us-ascii?Q?o4A2SoOyxPXnquf8g1KI1FCPF6RwDYAQD2L279SLe6FO1L34nsVkFVvfCltk?=
 =?us-ascii?Q?jthCleHxS53mQBNJ8xl5Ogj+FPdxjVv3FlztiE789UjGDrKjGbNnultkM8xI?=
 =?us-ascii?Q?YxgAzcnh4cNe6IOWqUQMQc8i7+jqE+XMqGUWErFxqP3LJ2G+lRQjMsyfnzBY?=
 =?us-ascii?Q?oool0Z37sS/QFtimj6r0Y9tl7S5vJDrmrmsSNqinGJs1a5fi7GzCmnFVLZtI?=
 =?us-ascii?Q?0aoiKdvp0n4d23PCkKkkBy9f2a+79C4QjpfYyaLaY9DeSIGeEkMcbKfvpZ8D?=
 =?us-ascii?Q?JFOMsXZw0ZrKa+X3+Kv+nJpwQCBUNu4VU/R0c7rS5+cuiv1UCJoGfrMYE3pJ?=
 =?us-ascii?Q?gco4bnNHtyzpc6WjrgFXQ8yLVu7I+4dHFqD5L4bdWuR490h9/UshHtWBwcSC?=
 =?us-ascii?Q?sF2rpE869+md70c0lB6pu1WTId3oue8owrRTLVVo7hX8BBYLykg5qBAHguVP?=
 =?us-ascii?Q?wD1tdoa8+9MOfT6Q9CIEY/ZjLPfaAaztqIMBYJ83fMVvBD6x4Mk5xozzy3W5?=
 =?us-ascii?Q?T+9Nq0va7QaFGu+UvUeuAZI/U5RUALWQGeJSuP0/cYbfXmXR6j3C+a1L+/6X?=
 =?us-ascii?Q?tK+0AlHdJGxyCFjxTaHLjEiaDvyr8SYKvqwuU0zWsk9YwDz2wgDpGtlm77VR?=
 =?us-ascii?Q?z+PcwFXgFT96qdQV791FP3q8ir5X94A09znlWYfVV2zU/ffUqIfz3jaJXLCC?=
 =?us-ascii?Q?rOuwD6L1YpPFF0i90NxrnKQ75ndsmqZ7PkAYwQx8McfbZw3DmPQ7FYRlJ39s?=
 =?us-ascii?Q?MdlW+W7VBzDjahs77RzO8NgYNy9cduJgVzdLoTwkuQ+jgieXH6oBnD9rLpXi?=
 =?us-ascii?Q?TDfaEEBxF2K/3jlPG3aj+9sLySukFIjDyqopYHgxjJxftGFKDrr2w1xY50+q?=
 =?us-ascii?Q?LpC6oY4fkHPmPBfnPuxt0LBLTk6u+Clw3T8h+YCbCNSUPfTu0rmNco7XCBUu?=
 =?us-ascii?Q?I2eNBpGYm7u9BIQ4jEIhqLok+/CbOfmkn4RjtDigck5TxT5aONpFX1wAffeD?=
 =?us-ascii?Q?At38mSzhvd1QMtKPWnHueEKvDh+j85WKOz4RlQOp2Eye+7GH0TKcWjTjBewb?=
 =?us-ascii?Q?pP2mmHcdR6tQw8iQNvq2HMqgGB1ArXgiDX4hclVQXDSJ1sh4Bcgqtr7Q58Ut?=
 =?us-ascii?Q?QCP2gFzfEQoSPNioV/UDa8Jt0mkLmAHEyRKJDEmS87mWM4bbNwQ9iLBwng01?=
 =?us-ascii?Q?tiVkBOAk/7sYC/Qqn78kLTBt33ZCCEJc3hQcY76xjoyZsqlnCBmVArAVI5O5?=
 =?us-ascii?Q?OhoHMAOwj/GWl8HckBjObjL8jFNmTP9pgWha+T6q7mWO3j3tGWAxwImnujTn?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5+Pgc/zczGUaZIoVPxPuyauljDyW2iNJrMX3ORYGCXb3nMn+6G6w5io5Kc9NqJrk3RnOqoo4VETzIXTTnliMTBrQ3aE1/tKTi2be1j2pVrmBHKtG2P6XIz4kaVVvh9PTzoHnXszJw/5KxM4la+m79nMs5LyCMhVBnbeFl8bI9MQy4m/4zZkvgQNxg9rWf1w/Na3vecFH7RdmOFljLywzqcFbEg+XJTVnO2uDRaQhN5WirPi2s5hiK4rNxUq5WtBaRxcbWGJTOcxS2qhz5P7MbmvSGZfWQo7hO3d2kQ4rVu1Gu3eZy6t6cHCgZlKAGpul5CowOrpLfSX63HTOiq4lHPUy2h60bgaLtJhaazUGiYzUYyAOCo6MMCY3D5QJlhpNAwoW9raVWE7v5AXnPWfCrTwBS5qJC8Z/t/mAPzIMxpwpLPIg7xOQSsfQDck4QrsnyR6oZPqLRZXmNejxf8tsCov2xRsmIEoOBdxvlVccObag3r+lE4ccGmvhl1AhKs0cf0WoAbbF1c3cM5rrxcpihFH0VC6TkHGY6CSok/n3+cCa3ooOb17O+Jf43xS1/8QuKKCkxnUBvomn79Fyjk6gJ8p1AGV0fT7d4KIZwWWT2+s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef01ea91-d224-42d6-5b2f-08ddf5fe51b1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 15:24:39.8942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Upb9cRZUcFbBg6U+3JAONEyc+xAqVs4MGeTOtm/fxSefDsz7yjgoODVHGcSHuch8KlnzGlERNSUdUYjrSOA0g1CcioJHVQdgA8FYIfkJUX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD020A49E6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509170150
X-Proofpoint-GUID: xoWDTPuKMtGEH4uVsH61OM249YcCpyK_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXwdoFLj5kRjy5
 rk134euoH//gzEzzyYDadCPCVmajf3n2I2Lwvxp0w6DwMp8hu4GaJUi7akd7Otg7ndtRhQA1ieo
 /mFLFLisNapBsShn5BLgDbwysEFx+PCyqUkWiDcUoz21AXQYuu+QNnPqpwHuoZ5w6Toq5rtCqWZ
 yczZeh4kBTlmaJd5vVz1byvZEBTHRJ+Wi2SpogUBsXakfEqYbTGOBNXKiCFduibjB+3/Uk4/PHT
 CLFYwANS6CBHxhkfSHw9SJdfX7NgKFfdrh4y6hy9i0UquojIzJFvnhjMwMqWNNTyLdF72fUaln1
 t/BXtAjvPfZvycjdnUWzcAHyUWEvSi8EKIeGjjzXx4uvCtqZ2NEheuavtAhImKLxAODK4znAQIU
 Rkkf3X1Ah2VI51PBwvQ91C6PIjifww==
X-Authority-Analysis: v=2.4 cv=cerSrmDM c=1 sm=1 tr=0 ts=68cad2ba b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=-FcHfTexsUZGmB1RXeUA:9 cc=ntf
 awl=host:12083
X-Proofpoint-ORIG-GUID: xoWDTPuKMtGEH4uVsH61OM249YcCpyK_

Define fallback versions of clear_pages(), clear_user_pages().

In absence of architectural primitives, we just clear pages
sequentially.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/mm.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1ae97a0b8ec7..0cde9b01da5e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3768,6 +3768,44 @@ static inline void clear_page_guard(struct zone *zone, struct page *page,
 				unsigned int order) {}
 #endif	/* CONFIG_DEBUG_PAGEALLOC */
 
+#ifndef clear_pages
+/**
+ * clear_pages() - clear a page range using a kernel virtual address.
+ * @addr: start address
+ * @npages: number of pages
+ *
+ * Assumes that (@addr, +@npages) references a kernel region.
+ * Does absolutely no exception handling.
+ */
+static inline void clear_pages(void *addr, unsigned int npages)
+{
+	do {
+		clear_page(addr);
+		addr += PAGE_SIZE;
+	} while (--npages);
+}
+#endif
+
+#ifndef clear_user_pages
+/**
+ * clear_user_pages() - clear a page range mapped by the user.
+ * @addr: kernel mapped address
+ * @vaddr: user mapped address
+ * @pg: start page
+ * @npages: number of pages
+ *
+ * Assumes that the region (@addr, +@npages) has been validated
+ * already so this does no exception handling.
+ */
+#define clear_user_pages(addr, vaddr, pg, npages)	\
+do {							\
+	clear_user_page(addr, vaddr, pg);		\
+	addr += PAGE_SIZE;				\
+	vaddr += PAGE_SIZE;				\
+	pg++;						\
+} while (--npages)
+#endif
+
 #ifdef __HAVE_ARCH_GATE_AREA
 extern struct vm_area_struct *get_gate_vma(struct mm_struct *mm);
 extern int in_gate_area_no_mm(unsigned long addr);
-- 
2.43.5


