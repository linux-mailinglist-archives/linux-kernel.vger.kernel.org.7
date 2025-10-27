Return-Path: <linux-kernel+bounces-872522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B2359C115EC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 38F1D3538A7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6355E31BC91;
	Mon, 27 Oct 2025 20:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kj5zLy7y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CrQaUepk"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130262E040E
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 20:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761596510; cv=fail; b=OCg5kNtsI804O9GXz2Ezots9m4x3Z6dVLb0Dhj69ik7KUS1Qizu6s8JVEwkvh91JXTYrxyElb4bHcKV+0eNupnUDV05DBkebouHBe9Tbhre7iP930DtxroCmbr3ks8cxloFXhWgWnBGYFgo/w94eLGnEcJrQA7U1qSiHG95AUOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761596510; c=relaxed/simple;
	bh=ey6zLklXrLQw2XfumlMgwwBTPmO6AP1u2tFN0dh4DKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZQLYRBcRo7E7kpOZL6upFiHxMx0zBUw6b9hALRCio8wAJKwrQhIEwmDzo4IblydaOGpxH2TVg0lKYWrFOmOQroRpqpgMdr3HMr6wCYMqyc9NkDSMfUTXu5F4IpcmXqy6oGfS2bzbl7A92zV3C0zEEH0nOaq6OGlR1CtuclTJE+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Kj5zLy7y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CrQaUepk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RKCRNA014710;
	Mon, 27 Oct 2025 20:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=MwaTfrtWKegNLWYGFbytOmtquO53i/sYm1JRyCEPomc=; b=
	Kj5zLy7yxfe9MHcK1C70+bHj2ejzSLIwbjrom7rPx8c2DwERDpOdoHiuNvBLNTAp
	WCr1Vi2/3Uwb3krGI/zw2gVdbsKiGToxN5rop4MkUbQsHPGCSUJGXUp8HHl0ZS6v
	RX8HGIV6Li1M/ZWCUQEkSxApbO0+sZLm8UCHFCda528ZnmbBBgRfhpRXQmGuU13M
	uoMHBba6UOXTQjAW8IVS4+H8a98V3rLgdJ6KKSTI8HRQEYKRl0xga0estvK31b5v
	DpH5WGxzhcoqX1WL0hMm5OOETw5pdJu8pH7Cd/Il4+ldRaC6kEVXkSVtJDs//u0l
	OqCFzbZuaxphdAp3vocHIg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a23gvhvan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 20:21:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59RJjLDm025120;
	Mon, 27 Oct 2025 20:21:16 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011035.outbound.protection.outlook.com [40.107.208.35])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n07h7eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 20:21:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEA3hfHpOo7N+v5cEDh5ZzSNB9lv0Y696PteZGooEuGbINqPL/RgIu7uo3FE9/sOCGBZe9LIOaXZ27OY5z7G9EGf2dW8pfYJ90dvy3VES3ydmyKU61SUg8HApfoWTF/sjXwzMnIY0JRb2LJ0A4g2kYlL3FMlzurnBPvZAYjmI+YJksmG8QXbyaRxzt1QvjhFgmHAmw0E2FwJiLZFAUZVcHo+vsX22rqXSf/pWFq+wWlrweAisuM2pDy2X91CGpucA2tFiL10jQa7YHG8xfdd4ALALyKCoDyG0pS+4LtQZ0xvgC/T+I6QjfR5V8roE2c/lCglksmWd+xI2LqGK9J/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwaTfrtWKegNLWYGFbytOmtquO53i/sYm1JRyCEPomc=;
 b=jAyJPfq3iL4xx7ukYXX6lgYm8FYvTivrL3/IICLQJVOnSkHRID8tCUvwoHuhCSNlLTtlIhY4aKOhniwSGHDu9KldIUhjI1nbgsXnCGm7uEvR7C7os+7eRnhS01aNjodK0mJC2VQM77p1jgljoYc8AuZAny20tX+IUAbHfGsQT6DvB1xnPkUsUKBIPJ3YJO/bLr1zTXYto/zeH7fi2f2io0JWdwLJU8gqeN5UuIXrWCPxkQt0fYSSLQPgJLFjNJdxpymPTdDGpV3mO963AvZlDnA+TE0I1mUzJ1Zab4BCqiJdLJHO9Lqa2T1AovfvnW8eBDPBYVcVZA/e83UNdPe3Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwaTfrtWKegNLWYGFbytOmtquO53i/sYm1JRyCEPomc=;
 b=CrQaUepko/gHuBaLvoalXXThRmlyxrtBuu0/M+D3Akmed2P+vQiTDoTSG8BFPwPP2u/uWgvhpzhEc3QV+aajsfe6omObJiXfi9vjqeVfVLShNX9DhjwNGaJQGjgBD8Yj5CpAdohZFeE6Aj5WxlHZulYEbpDRtvbRPsFISUoV+NE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH2PR10MB4120.namprd10.prod.outlook.com (2603:10b6:610:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Mon, 27 Oct
 2025 20:21:13 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 20:21:13 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v8 2/7] mm: introduce clear_pages() and clear_user_pages()
Date: Mon, 27 Oct 2025 13:21:04 -0700
Message-Id: <20251027202109.678022-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251027202109.678022-1-ankur.a.arora@oracle.com>
References: <20251027202109.678022-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:303:b6::27) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH2PR10MB4120:EE_
X-MS-Office365-Filtering-Correlation-Id: d055b344-8410-4b0e-c8dd-08de1596601c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5sUpAZRfTTJ94YttrbgHo296IH6/665AML3PySjX5Udbjoo3TGneAlqp6Wi7?=
 =?us-ascii?Q?aFt1XNFLIy2LSp7ZhIuwumxZ6NYvi4omh5p7k2UF0QqC0MCGtWW92j59hxRB?=
 =?us-ascii?Q?4g9+40Av8eEvR6zwOJ8jIlaZWpu9kOJp9UrpZSxlIInxb4M+h8CsF1gWWiUr?=
 =?us-ascii?Q?VG6C+JIj84RG0BcMpDOJd3wkI1YQncXTWyy5tA0VxyjwDrRuC2BEetw1uTqq?=
 =?us-ascii?Q?4qIXpBp1V56W7G5GdxR5hJTqnc0ILy12WEq2mHCy8qAo6Zzp5im33XvPiYpS?=
 =?us-ascii?Q?548I0/ULfTnHKDfhZAWAM0WjJCfDzzPyDzYSFVn76FU2Kx1pOmm+xTC9hoTV?=
 =?us-ascii?Q?qEfH06sJNDhCm4H78b5J5UL5F3dCzHkXX3KTQYYjrwTofopo8gCaLXhBWSG/?=
 =?us-ascii?Q?TLw8hXzgDdTtv5MQ6gjGP1lWNtKVwXA0UeHXaxZY1OCV8xQc8iIXUYZl97J+?=
 =?us-ascii?Q?+a3sS5PEln3Pi+rOvHmho4nqFu/TbipI4uabaPvmKI4MJOQhv6yxJsFCsa6U?=
 =?us-ascii?Q?XpdrEa3RahcgXtF1LTICmJ60KzHnZcdle3RNSExvb/COcovY9/JlupexiYeZ?=
 =?us-ascii?Q?w9yrBxvhZ+07P93Ax2nBKXsCGmnJkrjr5fabeOY9Hk98+Oi5NPEbvUyTs+yN?=
 =?us-ascii?Q?vhptjithJVTM/xclz8GeoXgPT/dYte39M7WTgPyHkhhFFr5T1WJFlxGUPjS0?=
 =?us-ascii?Q?uWS7ilJl5UayF08f0qXjFjjt5mYMXPpE9DvNtdaLX3rdhmwOxyUr64MtYRBO?=
 =?us-ascii?Q?vYqnpG8d232uqM4lcmCZlYn73ThcH7F8mq/cYbxXR3tE6BES2+whhKr+Kub1?=
 =?us-ascii?Q?SQBYST52+wX6G+R2wJpI1759noY7tBX7l7mMUCIiv6M1cuzoOQHOOAcvACvb?=
 =?us-ascii?Q?+P4JLBkTI2qwx24EthC9cTZtIu2fC/zE4HtfJBM55fg/hJKmTbSFCB5ksay9?=
 =?us-ascii?Q?QOYpXxcO5vAFWtyvb8+oVHqmVKcLjcRdg37qiwaPsjTMgTXuWGL/rqWtlWHG?=
 =?us-ascii?Q?HPE3KJQzo/kPeAzL5y9FyHouCe92WoGpFT4MM0Uiqw3kPPMq+b4EXZli0N+6?=
 =?us-ascii?Q?87XAX4y4hTFvh4+Z9T9mTA+HZPoPg5VFCtwMDVxQCy5YbrzXkLRUXAmMyucE?=
 =?us-ascii?Q?H0AEK3IQZbcIICAVJQ92pqBGsUnjK+ltEI5FZ2Dg1XwYqyvCpIKlmhENti+p?=
 =?us-ascii?Q?B7lk6ugFY/Og/wNJiSuk2j6ruov9GqZ+g7nG/d/qwzsdFFUjCDJdbFoeF5GW?=
 =?us-ascii?Q?tdSji2nTtu6I+An+KSOV/fXd08QH/zSjP3i4n2Vh+Poeqn/shtO4lJVsqnCM?=
 =?us-ascii?Q?1ZGx9DkJqva0iNFNaiKRV3SZxP/NVB1FOCGXPlniaBXQGH7mRK2+kvFRazTu?=
 =?us-ascii?Q?zCnk+RzRcDfvtLQS3nXbEwvnQxeykjppMIyNHPwLcwYF/+UcYs309JncsGbP?=
 =?us-ascii?Q?3pMQ618qO4/5Pi3bcmau9qo8mLV2v/ZF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ehzCHFwTQ+nNMUo161lT4fBzsUNgGP7ejNLcz9qN8syb8HSJ2/s1Krrcnjj+?=
 =?us-ascii?Q?h4L9D1eFh1Gtez4WqFM61ZOlVgIoWgBf6pz52X0d7kchMtaeT9p/iT6EVtbU?=
 =?us-ascii?Q?cGvz9bblidinokocQ9M6rVF2oZEopOeEvXkWVkvqx7jh/41NWdfsRV51QQPl?=
 =?us-ascii?Q?1ChloP9JP0wssNCU+P5GBmNeEkb4gJvjTqrLC/hwJ1E5gLQqZyNqpFEAiBuY?=
 =?us-ascii?Q?dSj4ADSnVV4qZhmnIkZJcW6O79wclF+K26D2wlFQ6klsXfSYBAQumR1SHdht?=
 =?us-ascii?Q?lQ17YymB4gphegyJTVRkv7bnH/8BY+gneBS37M2If8Jk4m0E5XglTM7u5lya?=
 =?us-ascii?Q?K3E1vO5+0O1e1JJGhodFmxh0LX27lyva7VmHs0HYTIC7Hv36UyuLvVwD6AHi?=
 =?us-ascii?Q?6RVu50vsEmDArFcgADJpJtT4ImrkRu+Y7JRItRzB1OiXN6RRc9RIGFZ9+nAg?=
 =?us-ascii?Q?4BCHq3am6i8A5rOjzEUCV9LCgtxwmQL+fgN42CvTROtCd0vdvH6/eqgQb0Tc?=
 =?us-ascii?Q?scz4in2RXOv3fqJdYKmqzsxHXVT6dzohopsKX7pMlpy19su0GEUm3fcf0jsB?=
 =?us-ascii?Q?SCAZhBtQzozE8tc4ez3jP0KXbn6G5dR5jkLvpkbS3HeHvslCywKEeBXm7Z23?=
 =?us-ascii?Q?CK0Tvv26UwyEka8/CapNq0sWFsI/3zDQ8v8zfKTjTw1Qtx4vjJnIaiukETvr?=
 =?us-ascii?Q?1ywnPMmTecXlEyEVAnJQQqcZ7BTp/1ol/N9fbeAMxfeS2n/gf1BJHzjc750m?=
 =?us-ascii?Q?p5dg5/tcNFG9cYyaaWF75BwBElGakBKuXBnTJHGM+PEUNMzKwmdL2ooy61lz?=
 =?us-ascii?Q?hWIxZeG21df48750mRXdWo1S/kwbGUwwFOpKrTE2/YzC6cM07ZRrwWeXjrLn?=
 =?us-ascii?Q?8Z8LfWuwoOMXKydUH9b8K+nNDEwFDtcDXs1at73FPMUNcmH8u9+Cl+hG/R0l?=
 =?us-ascii?Q?5kZGU68Byofpt4jnmagO4hafO2fY/LrswcDY1b3HKKClkfOzBPq19OOEqEAR?=
 =?us-ascii?Q?8clwWgGR689Rv6tqmPgP/TNs9RjhqAy95CgJwoHOF68QZ9AWywjh+NToBA54?=
 =?us-ascii?Q?+stmXxnyIH403kySVQSuWLqK8h4fI5m97gJU72KqT1jUrz8UU8FFXzkzNXaK?=
 =?us-ascii?Q?LQDCzLGLFkHI/Kaxn7uVJa98FqZLkbLME0G7THVGfjAoCdXfrOTdCmu/zIgP?=
 =?us-ascii?Q?+Pe2OiwRniLZR/BZGRJooZ0YHitWqTul1SR4K11aYmtJelPt1kMu/dnWa+fj?=
 =?us-ascii?Q?OP1EbA8bsqFN1SgJ/UDpDWL9yAjAn8oohUe4VBhfHVDA8OJTenUjHjzI6l/R?=
 =?us-ascii?Q?vcZZqMQjKCcu79uPOmlvpYWHAbNs0jnESIAun89hDnyRBUQXQz+Mh4Q1ltsh?=
 =?us-ascii?Q?YTzNPy0kr1fEs/zWd4+m8iI8fW+YEKwjhtPcBofPP8bA5hGWywjz2OSYZaIJ?=
 =?us-ascii?Q?avlhF4/bf9M8zAn+E0bN2BOE6Lr5I8SNNsVSVSPt6d0HiOQEiX87aEE7upxA?=
 =?us-ascii?Q?YRJbyMUm/t/GyxDvcB2zhHq6S0Za+EQQ8UKULkz1HWOvnIVF6EDHeF2KmSlT?=
 =?us-ascii?Q?nhH2HUqF0qNzy/yUqWocNLA6QQC/Bcz2CwLBn6lw6tawkvu44hy/BaUkcIh7?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RLPTZVSyWc9zrGg6JGa6RKYVc0SHWdrSEklvWm8LsrcKp9tCR0Oih0T3HKI+jFZVwW11Ay2hUV1EmxO9M+rHx5/5oiGB8euBS050cCkprCOy4+i++om/aj3LNPGbKI5t4/FYHwZ26bFN2pVpxctU4jk67ZHJwTnpyltPRvHACjo7tJ/gNFmGSusgkLRWUwjCwlBgGKsxMX2spgueCRPLACRXBweltgkZKGEt0zS1hcXHCwK1U1hh26B1nKG7yKRDeQDrwnAqJbB2F4K5cz/V/wPoX+PxvAr6JMgFsJmOc6TmzpDz85roWwEx6+SmMyrbksIMtWlrwMfzIVT0ChJD4wDg4oKZjfOEGwXGdA5fnVaMWldalvecsQmzaVAGO9UpNUTcQIRcTu0rWTOUHPNH2/7u6g/8KJLWWm0uI9o8rPzaTVbtQXDXusLIi7VI9gXWRyzUh0Adr8o5JHG3MyEBd/EoznysGjmkAQT6muZfjiwfGt6quJBEr9n5CH3eGYXpqZjtI6lwrXXJeIMsqABDFrKhX9uLYl1vNrFw9SqznPyCyfOVzwjXawYh0skFh2c1Ma47hvBQOcjGa3tZjKOdABSvZWR6VLTnEcLHMhjcSCA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d055b344-8410-4b0e-c8dd-08de1596601c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 20:21:13.6469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: deJUByN/u/Dg2fY3iBPx3IZWD4ShTw8ZbRZb867zD4HTGiCoxyMWkLyljAZ8xsDZ3chStcQ75dCCOPakppgrtKUqc0DKC94jwLcJ0/7GlXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510270187
X-Proofpoint-GUID: 6QqfPG2tpEjrcPketsm6eDmBMP24Bb8T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1OCBTYWx0ZWRfX0UrA98vuzlRO
 XYIC3ykaYXl01/i3KuCNL5B7xDzzeVoTUv70bmi0Bh/guERUVFdXIlwHulQrCwjhszADhaSZJf4
 pj+5AdSBbb5WGVxvzE5C4qJWMhvJaTZIYRTQsLLVRxhJaAQc1mKtpARr/DCq06Wt2xJVy/PW/Br
 yvCeerxanpDdunXAwQ4GOBTQjzv9JAMyOHEwZjqcTWfWupmXmSVlCjWX/bbs+BHJXHi8nrff9bE
 wWOR8mXOP5O1tz8wyr15q+JkkBT9RMy0j2Sht6dsy0ho8D7wRWN1NTFd2vXWOYP/K7eAwOMS2Ni
 KnwIIMtsYbFSXLhqTtb1X38Y9kF/BkyvfH4uAstUXb2odG5CzmrIahTDZiui14qc/pVc6ZssIh9
 B6CqFFqY1x5qGOo9eEsYJ1osNlKe+g==
X-Authority-Analysis: v=2.4 cv=HsN72kTS c=1 sm=1 tr=0 ts=68ffd43d b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=jAc279nnwvjaFhRRfOAA:9
X-Proofpoint-ORIG-GUID: 6QqfPG2tpEjrcPketsm6eDmBMP24Bb8T

Introduce clear_pages(), to be overridden by architectures that
support more efficient clearing of consecutive pages.

Also introduce clear_user_pages(), however, we will not expect
this function to be overridden anytime soon.

We have to place the clear_user_pages() variant that uses
clear_user_page() into mm/util.c for now to work around
macro magic on sparc and m68k.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/mm.h | 41 +++++++++++++++++++++++++++++++++++++++++
 mm/util.c          | 13 +++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 683168b522b3..ecbcb76df9de 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3872,6 +3872,26 @@ static inline void clear_page_guard(struct zone *zone, struct page *page,
 				unsigned int order) {}
 #endif	/* CONFIG_DEBUG_PAGEALLOC */
 
+#ifndef __HAVE_ARCH_CLEAR_PAGES
+/**
+ * clear_pages() - clear a page range for kernel-internal use.
+ * @addr: start address
+ * @npages: number of pages
+ *
+ * Use clear_user_pages() instead when clearing a page range to be
+ * mapped to user space.
+ *
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
 #ifndef __HAVE_ARCH_CLEAR_USER_PAGE
 /**
  * clear_user_page() - clear a page to be mapped to user space
@@ -3894,6 +3914,27 @@ static inline void clear_user_page(void *addr, unsigned long vaddr, struct page
 }
 #endif
 
+/**
+ * clear_user_pages() - clear a page range to be mapped to user space
+ * @addr: start address
+ * @vaddr: start address of the user mapping
+ * @page: start page
+ * @npages: number of pages
+ *
+ * Assumes that the region (@addr, +@npages) has been validated
+ * already so this does no exception handling.
+ */
+#ifdef __HAVE_ARCH_CLEAR_USER_PAGE
+void clear_user_pages(void *addr, unsigned long vaddr,
+		struct page *page, unsigned int npages);
+#else /* !__HAVE_ARCH_CLEAR_USER_PAGE */
+static inline void clear_user_pages(void *addr, unsigned long vaddr,
+		struct page *page, unsigned int npages)
+{
+	clear_pages(addr, npages);
+}
+#endif /* __HAVE_ARCH_CLEAR_USER_PAGE */
+
 #ifdef __HAVE_ARCH_GATE_AREA
 extern struct vm_area_struct *get_gate_vma(struct mm_struct *mm);
 extern int in_gate_area_no_mm(unsigned long addr);
diff --git a/mm/util.c b/mm/util.c
index 8989d5767528..d3b662b71f33 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1344,3 +1344,16 @@ bool page_range_contiguous(const struct page *page, unsigned long nr_pages)
 }
 EXPORT_SYMBOL(page_range_contiguous);
 #endif
+
+#ifdef __HAVE_ARCH_CLEAR_USER_PAGE
+void clear_user_pages(void *addr, unsigned long vaddr,
+		struct page *page, unsigned int npages)
+{
+	do {
+		clear_user_page(addr, vaddr, page);
+		addr += PAGE_SIZE;
+		vaddr += PAGE_SIZE;
+		page++;
+	} while (--npages);
+}
+#endif /* __HAVE_ARCH_CLEAR_USER_PAGE */
-- 
2.43.5


