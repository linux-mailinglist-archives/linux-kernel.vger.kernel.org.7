Return-Path: <linux-kernel+bounces-724728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1A5AFF644
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7A25189EC6F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 01:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2CE26D4C1;
	Thu, 10 Jul 2025 01:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r5Bnrq/9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o4Mvqn5q"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C51526C391
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752109221; cv=fail; b=GpHtBs+YFINStrQpsxqSlFmm0oi8k6BrCuT+hbkXGELvddjTau4H1voDt4yGh6QzGl9EW5hCpTBsOXcawVpgS/aa6wBd8tFJXkd8Xu5WtyEha7t5riDdHfJnb/aFU5IEmN2glpe8hUPrQNZ8lHAyV5fxBJJ58Tno7xZxyy4lJ2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752109221; c=relaxed/simple;
	bh=/zNP3La+jFIuMboaBHHcg+gYtj//QGoDs8+rpKqTi7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hrDq7NrigC0Hs8kn9uzeiEJ4frZ/Bd2vQJq73HmVwFPBARqI786z+uWBirjHH2Hitwyw4tc1CwfDwjT5I8gyMrTtlDH67UTKs34dVhgK5N2LIxeZ16WNOzwILVM1jJufDmHpauccfPEJ5Du2/Z2CAfjQ/hNh2WDHmkRGGZA5Irc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r5Bnrq/9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o4Mvqn5q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A0MuZo030250;
	Thu, 10 Jul 2025 00:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=w3bmaR7XSSWErZeDIOOKpVYEiN4NluZA1hZEpjjD9Jo=; b=
	r5Bnrq/97owtJjEg/dEPXMk/NV6GreHw6zgCHp3TCWzYWY1M4zrZpBTYtjf//uE8
	5iM0ivfFvPpoUku78KPrPCteefPQHGHYI+Mf9wcFyK8ljLO2il3oMJgEdXEgL1eu
	t/Ff+U00eQxU3qTOJDS3DIdfo8tylTa2V6CYrWBuLR0YDlHTmqGPrmL/sAsMORr9
	CE6Hi4J72kA7YLq3OUIJEuFDm67c/2nClOhaDurLL/JVTCZ0LHgkcZbFvIh0ZM2K
	SqI1+Qu7OPkgvdCB+/nKHLpYLuD6micc/2O01CjE+zta6Cq2nFDG11qZTFDH0PaZ
	v4LXYjc/GOobXtUcngu/7w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47t2wn8182-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 00:59:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 569NuiI0014348;
	Thu, 10 Jul 2025 00:59:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgcds62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 00:59:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8tajd7c16gwoYR2gm/sac2Cp9u12/SS8+zFp8a8FAYV9x0hBmiMMcKZgJgCVW3uEMYvTiRpQ7xAYuGSdg2lKm3M8gXaI46kIakehrpvXvMLqIF6+9zYY/+NIR8/WImZiYovER3MDk0JkEnx0p6MUgJkVe/seNKxWVFIU1W/WRmba/Sod8U8o87+Eyw05T2ksz2dWnQTCca5EWYKwLNm0VSPrweFcR9Y08RismegvCmgqYTKt3ldyaUuKH9vbOUtez8Rl5vXq+I4jzlciGD/4UP9+V2rL8EjPK29LwWmMFMl+G4ud6s6pkv/LPfZBHqxURvgTyfRBMAnkykSTdNVJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3bmaR7XSSWErZeDIOOKpVYEiN4NluZA1hZEpjjD9Jo=;
 b=yPyRTgPTYCjEWqoVBZkMl4HSD8bhFlZSuJsznqAql8Q8rAVv9ha2+CNAHPWXIFoVvh2BW+VL0S4IRYQ699LZ1FoqQ/5oLpY7iwYOw6bTT9JbqIWp9YEDdx86O0vsiirCgM7w1zINCiK7TiktnWXL036Nax13SiiJiDiUqvmOZ2sAZLHOmNQOO/t4SbOgqv9RBa0ncrXCKQYKs4k0SiiWluZgthpCQCecQgb4F+NvFEr+xME7xjYAHja/g5C5t0I0DXXc3S6FebIXhKEcv3vIC3mdZ023Snu8uSxU7UuuQ/PaI4+sg+1MLdK1gz4DEsZzGP1RWIlW6609dLbvSDWA7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3bmaR7XSSWErZeDIOOKpVYEiN4NluZA1hZEpjjD9Jo=;
 b=o4Mvqn5qZ20VA0sN8nnOqrUxsABkq95JZFw6cndgyff4sWsxo4vwxBwJDzPIJrGDhwdjDHX7xxcBke70VjXSMZmscNafaiMTmAVOwzsnmXmceutLBHdEV6ax4cOCNeisQgeYXGBP4rf3cdWrRZ0RP7CceeZH/BHtFZ+nR6m5Qho=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB4832.namprd10.prod.outlook.com (2603:10b6:5:3a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 00:59:28 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 00:59:28 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v5 01/14] perf bench mem: Remove repetition around time measurement
Date: Wed,  9 Jul 2025 17:59:13 -0700
Message-Id: <20250710005926.1159009-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0044.namprd16.prod.outlook.com
 (2603:10b6:907:1::21) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB4832:EE_
X-MS-Office365-Filtering-Correlation-Id: a248ccac-ae24-40e3-f12e-08ddbf4d05b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gJkqZjVUcl4sypgkGuoMisUOljOWG2XS8UyJhb3k8SclmUH3oKObtW14jXEU?=
 =?us-ascii?Q?b3zT3SlMU3ALWE1gD2A4L7WPUa1JaIV8EMgE2iK2ehpz2V3Gz382PEp/I+nb?=
 =?us-ascii?Q?QHblU2SyVSOaBZrQrZ9nrbMC139EMcWzBIaqKbmegQPtQ1FUMegQ1GdJKtA4?=
 =?us-ascii?Q?EnhqkdmyTrKakYCLe1CHTzXkxLgeg0ZZKphJtdR5U/PNlb4G8HE3MB+f3X4Z?=
 =?us-ascii?Q?g1GOOZJcTqyi/YSK/OuyBtieEQVgDaM9afsTmBBat2tFS5IL3wLZ73fED/ou?=
 =?us-ascii?Q?U0/LfAQ6DRWFCnYyuPTDpaPpIzqO69PWUegL53Ths4DqIQH9iAldvX87wF7q?=
 =?us-ascii?Q?eYU7FPKYeidCW00YfAAoaxPAOz3OkAMNkq4yKNQySGNMqzcvvwjgIOM8XG0j?=
 =?us-ascii?Q?cP8nP3QAZNjFSi5pN0DtLUto099765TpDDlWiroF4L63ofDa09xUlUMI/NWH?=
 =?us-ascii?Q?szU3m/kFgwrEP9YA6acrFcpWjXushSDkREbGReaQCpYb+Q3MN5rGJ/Uc1rFC?=
 =?us-ascii?Q?VnJLpSSsqhdNRP/g38FH4JsXpMPQuwmcuuIpdUnDxLTYt55pKzrfZ3iqlto4?=
 =?us-ascii?Q?fqx0sgc0FI07R6LcGi9SiO0kGiFg7yc2nVg6OZXcr001bx1mdTFs57WBVc5i?=
 =?us-ascii?Q?jFlhuH2ihdwQbYRO8THRfwBynq1xtBGImqa1pukl6GLl10S+tRELFrEdbb46?=
 =?us-ascii?Q?sKZY0JOKMVlYvqq26SNA0oTo9GXQcNZarPYcCDnMGyoTCjkhblTPuskE8JRL?=
 =?us-ascii?Q?yAfKur1zncUOzn/4pgAWMSZxkjHHRK3Jg/97PqM9BYEWSfql5CFtzKyG9tU5?=
 =?us-ascii?Q?5ZjiwdC5RuF2m0xBjaq3xilibkc8bKc0CENR/Re+VvqW1smeutErqMGmzuqN?=
 =?us-ascii?Q?4+05j9pO5TP1v7WjFnzyJHE8mu45rwH76us4TrRZHOPixiG/b8qaarlYWD73?=
 =?us-ascii?Q?wEgSZf9gHSUsYxxo7/pob9afep26qHTCNR07u625pchIaK7jWPahKl/w78Ua?=
 =?us-ascii?Q?KJjORjLGqIATeDcr52/5UYVj57Jbzk03picIhQQ+bcnLFBqZbAhdEJdld8TL?=
 =?us-ascii?Q?wQbB/5cX99il3U32P9E0gS5+wjlfiOdOZBxu4zIUSpCzgioUtkhUQByYAQ9s?=
 =?us-ascii?Q?lvXRHt7nxBN/TAqDxF3HYx+859F5GH8T0IBxRXfVlx4DSEA++n3iy+hOKZqB?=
 =?us-ascii?Q?Z0MfrfOUheKAnHRkRhp4cjkgLkDPuoZtE/Tunw0LeQlmBp/yJ+mqfdkQBo8O?=
 =?us-ascii?Q?Fv24ZGTIDun4ibKjRa5aFAC1/qqK/373iqXFsgU/hHOr8vub8yWoJEv7RXVx?=
 =?us-ascii?Q?eJbNe3khRgmmU04ERoKwHOcl+EzZP/OimvS9NjlkaPTrvz7pHGe9sXYj2C+q?=
 =?us-ascii?Q?FJA2YX8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l/b5MgLxcuLw3ckw2tNDrdnRJYPDj0+yy6cYMmxXTGyzpG+ZP5DNLd+ZQ+gA?=
 =?us-ascii?Q?p4q4nqMZdaRnFKDZw0QLI49K1cf2Vr1KrvZQlwFwMJhw0XEa3kGgbZy/IGRO?=
 =?us-ascii?Q?DXbvaQoukol1ZcG8XvKUNQpT2vc/3GMZDv4TiaDPD+0UDvA3md7Sz0WswFRT?=
 =?us-ascii?Q?DF8LD7BB7VaJRnmL1rCPMoLQ26lKfGK4BWoIvvdL4B/PS/cZn3iWB2gSlZQP?=
 =?us-ascii?Q?UzHZYSbVklcOLGKLvFiYPVxAj9EXda4oTeuzCt4/zKJmCZSrIxP3OmIzvcpF?=
 =?us-ascii?Q?NSoey0JHCNBGS+Cc1gwIAwUix2AfYf9EhRAgkkomqrCBK0y08LUVEq5ZBB8x?=
 =?us-ascii?Q?wRIlyN8/2rg4WGSdEKLGvfwMa+oS6ECq5ZoixLotGzWTsf7KF7r569uVE4ds?=
 =?us-ascii?Q?3hyaEW57VmRQqLJuC0+pFFkeNaGQCoJrSvRZ3gqEoINNpg9W4bmy+M1M/bN6?=
 =?us-ascii?Q?5eh8E4xAtCTkH/Aam4yY4+AA5Q35hDXjHPLmnJTIq8QTmtF/yLYmQry5Es3T?=
 =?us-ascii?Q?2CSn41DNq9x9MHRzGEMdamZbbpzVREGDVJ7v+7dLG5PtHvMCwsaXTEbD7Yfx?=
 =?us-ascii?Q?hAxoYwxEU0ZO0eVoivKYqK0CJ6aoBAH9ncnkE9s7+1I/yk0S3VnmJdHsETMF?=
 =?us-ascii?Q?0NvMOmo09KvZAon4/YcnkC6GyfhqzgxImzViyVk5Cr6CCFrIa6hfdKjFvb2o?=
 =?us-ascii?Q?JbgeKqlyi4VW0jhQ3lOgDemJOsFwdfKt5VbUo+RdQQBw4Aig6d6mlz2UlZe9?=
 =?us-ascii?Q?Ovl7KNY20VMAYMBXrf/cDVY9Vhh7jasLkPgkmy7pavyNt/ryjVEpHEbdLU6L?=
 =?us-ascii?Q?wg4Efnf1KtGBAqT2PhjuE7UtzfTobvvTEL+WXJJUIaOBPY4vUwWmzNHxdZTP?=
 =?us-ascii?Q?vIvOzTAJGNiOWTiPCXTpEUxoUT+aiHxOPmlMMOgS7F/fAWvJ/HzQQsJSp/Se?=
 =?us-ascii?Q?HFlOIujju3oL1Dyq7OuWFg05WzFmJ4qHcLEtU7B8SVUJEh9uj5pocR3GPaSQ?=
 =?us-ascii?Q?xnEWAf6Pt4oB+fVtXDpp5VVdMKl2Em8JAC+oGmt07idVgWaCRRL4hOIXfa9/?=
 =?us-ascii?Q?QVEQueyy93zviVnJuhahGtqNtUlQq7+k2T5GaayhgOCMXX5cq9ROpbiiw8OG?=
 =?us-ascii?Q?xkLYDgPsorKUxlFEfJSk4AS90UECqJ0mZtU34+5qSIuVESKXXaTGX2c6hxG3?=
 =?us-ascii?Q?qH3bkjSXvmAH/G4T6E9Bjt5dtMoIA6SpBRjJho3HV28cDZsJnYFDHtMEv2pQ?=
 =?us-ascii?Q?7yGN66BF0ypiaH72wqtoFQWMNgcoMe/fgn9VTwAcqMeS0Cdlvy8CFhf9CUKo?=
 =?us-ascii?Q?xiqaW/cZS0gDgR4HLoCto16IwO0IQySvGor/Dg0NVooGrwSPHMv14yK8meY2?=
 =?us-ascii?Q?J3BHJGaY3uGHG6tfS4+8WPWFlXZl+FF99Ttt694X6DxSrs/hkxLjyc/uSU4i?=
 =?us-ascii?Q?dgZK2bwUxTNKpnhXQoujCo1HQymRRO+ZvsdZrf0tw6tBvBHJUwQC/8FGWcdl?=
 =?us-ascii?Q?9BEWbaUTakXbUrtRwCSJPhvL+a0KlJAtBZ+mM1MjQ70Jn40XxJg+2EXMatsF?=
 =?us-ascii?Q?/gdbXd/Lo2+vGUcoZ+qmkVy0UsmmsBcNSDenW10IwctD+8fEDSJvdzYfALNe?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	46JJMCTqe5Pn/nrDtiGJQ4/Q2tfvozo3n8zs8Zfg2zoj6PJyKmQEDt4xOFx4nmxwj6RwpXi+wtlkKH22/h6UiXP11bPaLDKplXpsuLzD9+QjCcAR+QXdlc0hCdGI12mlbHbRhkW1i8df1zqD4c7HQgBrl60kcK+L+x/Pgyek5O5/mYEFfHO+lS+Q26iHunJWGlgDFtoHgEp2cFktePTa+PWyV2Zz7Zyr0BYUJIC/b43wsa6X8Aju1SaECxnjFQRggAIHjXtam0f+UqIqh0T4L6peUsdFAD0E5DSwD3Fs6VlrGCXolvRDPUFL3AlgPTqFGZ442wHc7SAGEkxI2OvKv9dkHSMyO6LrCrgXxBRqtCjcOhHcnwdgI0NLNKuUn7GCbSVL35bQ5giQQeVGcO0VCeDLKZu8b55KtwMMhQEb4djs+YzdEC3QcDWqYnNj2KrN2Wi3Ztt0OYj8E5pboht7J6FqFnfdaVOU25XCusweCBXwmXyWKjPqm7om6osHxjcB99JbsV7XCoOq5B9L/mboOwvvBZGXZMPi/Ldbj2VbwLb0tn/ocqPd3C+O3YDtQJYHwJX9M1hxLypBt06YwEAGwEW/lVz3KY+7UoNM4ALElqg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a248ccac-ae24-40e3-f12e-08ddbf4d05b4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 00:59:28.7128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mi8uKWKTqsPpkoKGmwFKr+DeZLg8wWx1R38h5B8Da5iXxK6yEKjl5U40WFzLgUNLvusmnhHGvBqhbbPT8VHiQ+UNSY3et4y/Htpavm/pijY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100006
X-Authority-Analysis: v=2.4 cv=WtMrMcfv c=1 sm=1 tr=0 ts=686f1075 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=QzB8L1Xlpqjwh72o9DYA:9 cc=ntf awl=host:13565
X-Proofpoint-GUID: yGYIKgFABlPIWtMCc9VB3NalWYyyNHeR
X-Proofpoint-ORIG-GUID: yGYIKgFABlPIWtMCc9VB3NalWYyyNHeR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDAwNiBTYWx0ZWRfX1gkm1Ew+/fG5 PmIdpodBMZBwxUhbWeFKs0wYlKOZK6+9bZ4e5ACLcZZ1shDSQipNKcAqh9Bst+GZyulLCbFJj7o ud5O+80k+NdwPuHRtw8J+U3cyXrF7rwtBT5nMQcqJj+1g6zkrIUAN1De7swPNTgroA1VnkASCM9
 hi8jZPHqcdllJ/IMPNcsB4faG2WWlcBFgPy3yjt/B5Yt41eWzls9UaD6TY2v3eGZfd5ICRLIvr3 tVCsnvKvUmPXAh82egZG8S+ffFmxDqhM9BxMlp28UtP6mO8UF/E3+GIA/Q+DgBgPGt+Mr8HQMVT SiK0SlJ6Sx/Io+Z9ZcPnbvAjICtsjUpbS7JoaHM4ItTn4ikiCrNyjpTOWIIrv05Czyg1e284NjW
 NQix0w0IiR4LOgQOIGAR4I44GEx1aJ+5xzYz7MYDhenqL3RQS5CKDFPdQZ17kyxRGFcV/ctm

We have two copies of each mem benchmark: one using cycles to
measure time, the second for gettimeofday().

Unify.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 tools/perf/bench/mem-functions.c | 110 +++++++++++++------------------
 1 file changed, 46 insertions(+), 64 deletions(-)

diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
index 19d45c377ac1..8599ed96ee1f 100644
--- a/tools/perf/bench/mem-functions.c
+++ b/tools/perf/bench/mem-functions.c
@@ -51,6 +51,11 @@ static const struct option options[] = {
 	OPT_END()
 };
 
+union bench_clock {
+	u64		cycles;
+	struct timeval	tv;
+};
+
 typedef void *(*memcpy_t)(void *, const void *, size_t);
 typedef void *(*memset_t)(void *, int, size_t);
 
@@ -91,6 +96,26 @@ static u64 get_cycles(void)
 	return clk;
 }
 
+static void clock_get(union bench_clock *t)
+{
+	if (use_cycles)
+		t->cycles = get_cycles();
+	else
+		BUG_ON(gettimeofday(&t->tv, NULL));
+}
+
+static union bench_clock clock_diff(union bench_clock *s, union bench_clock *e)
+{
+	union bench_clock t;
+
+	if (use_cycles)
+		t.cycles = e->cycles - s->cycles;
+	else
+		timersub(&e->tv, &s->tv, &t.tv);
+
+	return t;
+}
+
 static double timeval2double(struct timeval *ts)
 {
 	return (double)ts->tv_sec + (double)ts->tv_usec / (double)USEC_PER_SEC;
@@ -109,8 +134,7 @@ static double timeval2double(struct timeval *ts)
 
 struct bench_mem_info {
 	const struct function *functions;
-	u64 (*do_cycles)(const struct function *r, size_t size, void *src, void *dst);
-	double (*do_gettimeofday)(const struct function *r, size_t size, void *src, void *dst);
+	union bench_clock (*do_op)(const struct function *r, size_t size, void *src, void *dst);
 	const char *const *usage;
 	bool alloc_src;
 };
@@ -119,7 +143,7 @@ static void __bench_mem_function(struct bench_mem_info *info, int r_idx, size_t
 {
 	const struct function *r = &info->functions[r_idx];
 	double result_bps = 0.0;
-	u64 result_cycles = 0;
+	union bench_clock rt = { 0 };
 	void *src = NULL, *dst = zalloc(size);
 
 	printf("# function '%s' (%s)\n", r->name, r->desc);
@@ -136,25 +160,23 @@ static void __bench_mem_function(struct bench_mem_info *info, int r_idx, size_t
 	if (bench_format == BENCH_FORMAT_DEFAULT)
 		printf("# Copying %s bytes ...\n\n", size_str);
 
-	if (use_cycles) {
-		result_cycles = info->do_cycles(r, size, src, dst);
-	} else {
-		result_bps = info->do_gettimeofday(r, size, src, dst);
-	}
+	rt = info->do_op(r, size, src, dst);
 
 	switch (bench_format) {
 	case BENCH_FORMAT_DEFAULT:
 		if (use_cycles) {
-			printf(" %14lf cycles/byte\n", (double)result_cycles/size_total);
+			printf(" %14lf cycles/byte\n", (double)rt.cycles/size_total);
 		} else {
+			result_bps = size_total/timeval2double(&rt.tv);
 			print_bps(result_bps);
 		}
 		break;
 
 	case BENCH_FORMAT_SIMPLE:
 		if (use_cycles) {
-			printf("%lf\n", (double)result_cycles/size_total);
+			printf("%lf\n", (double)rt.cycles/size_total);
 		} else {
+			result_bps = size_total/timeval2double(&rt.tv);
 			printf("%lf\n", result_bps);
 		}
 		break;
@@ -235,38 +257,21 @@ static void memcpy_prefault(memcpy_t fn, size_t size, void *src, void *dst)
 	fn(dst, src, size);
 }
 
-static u64 do_memcpy_cycles(const struct function *r, size_t size, void *src, void *dst)
+static union bench_clock do_memcpy(const struct function *r, size_t size,
+				   void *src, void *dst)
 {
-	u64 cycle_start = 0ULL, cycle_end = 0ULL;
+	union bench_clock start, end;
 	memcpy_t fn = r->fn.memcpy;
 	int i;
 
 	memcpy_prefault(fn, size, src, dst);
 
-	cycle_start = get_cycles();
+	clock_get(&start);
 	for (i = 0; i < nr_loops; ++i)
 		fn(dst, src, size);
-	cycle_end = get_cycles();
+	clock_get(&end);
 
-	return cycle_end - cycle_start;
-}
-
-static double do_memcpy_gettimeofday(const struct function *r, size_t size, void *src, void *dst)
-{
-	struct timeval tv_start, tv_end, tv_diff;
-	memcpy_t fn = r->fn.memcpy;
-	int i;
-
-	memcpy_prefault(fn, size, src, dst);
-
-	BUG_ON(gettimeofday(&tv_start, NULL));
-	for (i = 0; i < nr_loops; ++i)
-		fn(dst, src, size);
-	BUG_ON(gettimeofday(&tv_end, NULL));
-
-	timersub(&tv_end, &tv_start, &tv_diff);
-
-	return (double)(((double)size * nr_loops) / timeval2double(&tv_diff));
+	return clock_diff(&start, &end);
 }
 
 struct function memcpy_functions[] = {
@@ -292,8 +297,7 @@ int bench_mem_memcpy(int argc, const char **argv)
 {
 	struct bench_mem_info info = {
 		.functions		= memcpy_functions,
-		.do_cycles		= do_memcpy_cycles,
-		.do_gettimeofday	= do_memcpy_gettimeofday,
+		.do_op			= do_memcpy,
 		.usage			= bench_mem_memcpy_usage,
 		.alloc_src              = true,
 	};
@@ -301,9 +305,10 @@ int bench_mem_memcpy(int argc, const char **argv)
 	return bench_mem_common(argc, argv, &info);
 }
 
-static u64 do_memset_cycles(const struct function *r, size_t size, void *src __maybe_unused, void *dst)
+static union bench_clock do_memset(const struct function *r, size_t size,
+				   void *src __maybe_unused, void *dst)
 {
-	u64 cycle_start = 0ULL, cycle_end = 0ULL;
+	union bench_clock start, end;
 	memset_t fn = r->fn.memset;
 	int i;
 
@@ -313,34 +318,12 @@ static u64 do_memset_cycles(const struct function *r, size_t size, void *src __m
 	 */
 	fn(dst, -1, size);
 
-	cycle_start = get_cycles();
+	clock_get(&start);
 	for (i = 0; i < nr_loops; ++i)
 		fn(dst, i, size);
-	cycle_end = get_cycles();
+	clock_get(&end);
 
-	return cycle_end - cycle_start;
-}
-
-static double do_memset_gettimeofday(const struct function *r, size_t size, void *src __maybe_unused, void *dst)
-{
-	struct timeval tv_start, tv_end, tv_diff;
-	memset_t fn = r->fn.memset;
-	int i;
-
-	/*
-	 * We prefault the freshly allocated memory range here,
-	 * to not measure page fault overhead:
-	 */
-	fn(dst, -1, size);
-
-	BUG_ON(gettimeofday(&tv_start, NULL));
-	for (i = 0; i < nr_loops; ++i)
-		fn(dst, i, size);
-	BUG_ON(gettimeofday(&tv_end, NULL));
-
-	timersub(&tv_end, &tv_start, &tv_diff);
-
-	return (double)(((double)size * nr_loops) / timeval2double(&tv_diff));
+	return clock_diff(&start, &end);
 }
 
 static const char * const bench_mem_memset_usage[] = {
@@ -366,8 +349,7 @@ int bench_mem_memset(int argc, const char **argv)
 {
 	struct bench_mem_info info = {
 		.functions		= memset_functions,
-		.do_cycles		= do_memset_cycles,
-		.do_gettimeofday	= do_memset_gettimeofday,
+		.do_op			= do_memset,
 		.usage			= bench_mem_memset_usage,
 	};
 
-- 
2.43.5


