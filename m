Return-Path: <linux-kernel+bounces-821135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C96A4B80851
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5600D62192A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EC73397CE;
	Wed, 17 Sep 2025 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gA2r3pKy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bqC36uNr"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8BA335949
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122721; cv=fail; b=tjtUQVCIdMxAy0WxDdNrR6BalOJMGM/0jtKx8A2LhsTkqSx1BS59NI/kOeJ0ttblnmQ+3Bbwg08FrUVuDLqnAC05O5Nkl8kiepvnRaU/0WXfnsSmApaSPKMcOxt3Lrtfg/3bz+pc/EVZ0Hxjcu+Gxo5+gYahbM6Bjp+4X+7ymrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122721; c=relaxed/simple;
	bh=oFE1He2pcLgU56MO13fP+HHlHAS9hbAYChIDkffQWSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AqYpwwxI7bJUlkrK2AJ+rr63iRqwqtoyT9Tod8Q78ETvV6AiSyZR6mNDDCeZPsD579ZWw0aWvwSa4U5vrTxrIyzLIDWLvXqyEnOAFsJK7CC363n6HnnTcGIgP5h9cWeydrdGbskOhTwJPwsYXB8uyK3MhJV8sBM7zk8fO5DErPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gA2r3pKy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bqC36uNr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEITRa008296;
	Wed, 17 Sep 2025 15:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JhJNwVlggWvhdVgvWTY8KzHTWZIgpo2fNw+mzLIOieM=; b=
	gA2r3pKy4rxvB32LwxhdNTTf5aEf+3wk8jmsRdtCms6u5qpFJ9iPEHELdaZF4EXa
	blqln/NNY2Hm+Qy3mc7V5u6IZf+yu6rhjz5Sjzl7VaUzQRPFqfZSNOHLiQ+0oWB7
	RvwmjaENQK2QuiXJ0qaVI2fbvPeMqEpVLkiypvBZDsG5Tc7PIF2DAYfLq5ANQg1L
	wHosLaB4hFH6iV35HUUgkxrQiTzaTn6C09fAgpodBj6k4c4g68iLdXKp9UoytEZB
	oa7VLqwCmCd8JaPmn4e2dF9L0OSmVbpZqujtBwzaO5ffZWKeRUrSBTcaGPQ6x4WH
	Yos9gsaUUrrFQOu03aM+iQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx8hfu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 15:24:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEbBbb027235;
	Wed, 17 Sep 2025 15:24:36 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2m70xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 15:24:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdZCTfwNg5HH7v+BoJQ94QTqgiqrKF0AtWO+E4GBTrNjfedFrzHDG77FcEuaDvnNy0uveqbNRRlA4SRrDmbbd8igDpy7JqpFzTuG5PZTSetk5fWE0Ya+5ijoC96X0cI/UnpqNfK94TkZyCTTzb7oYWMM2VkVBnO29k/iNhlg4h9mlVM2xMeI7Abgm73VAH8cqT3Lpqt1Wnz/hh8aS16loCkWQlCftzJddaPx4X585Ki2xs97eXY5iI5IwRIe8PZHqbIXdLPbVrPkxQJD7r2MlZ0BcVV95nC+7SDPBkrjzlT4UwYPKsfI/SetT1pDLJl565gjHjjGmwx3pWT/PWZLAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhJNwVlggWvhdVgvWTY8KzHTWZIgpo2fNw+mzLIOieM=;
 b=ZWC5fUtXKLJPZ6s40oXZMxjShc6bHt2Id6c1jhR4rutcJEXFImua9C/Ui0XShEn6c/VS++95kWKnPz8nNTc9plFPVjh8nXk/rTWpgPXqTeFDm+Qez0jlyJekFTq/57DbxaxOBA3ASD2iCJVTqgjflA50Ev+ma5IBNK3+3Sm787YELEo5RxlrrhWYCWfqQFQKUuC7EeINCtj7YwelUJwQe4NCtV6vvnWJHSyC4KptudI6zCo8j1rYZR68HJCGMt04LEjVpfEl/csk4fYvnr7osfrQeFr6KukivbvjLpmHKaRLZraymSeqBrfaKpCVEoe3N8H/gXsa/eSLEfVx5tzwUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhJNwVlggWvhdVgvWTY8KzHTWZIgpo2fNw+mzLIOieM=;
 b=bqC36uNrksRjhB9oCBO47NX3MCJF3mdjMdF8OalStfn9MBmJXKlZhw3v7StxriqMiTvUBlhkyeHPRdt+QCofewQHXgBrZ4CtiygQ8VTDHR7OXvmuX9sBiJYGXwB50q4Sov6CfuTXYfQOwg1hK9Ebk+/ifx0i03C87ExVLxML43c=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ5PPFD020A49E6.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 15:24:33 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 15:24:33 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v7 07/16] perf bench mem: Allow chunking on a memory region
Date: Wed, 17 Sep 2025 08:24:09 -0700
Message-Id: <20250917152418.4077386-8-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
References: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:303:8d::26) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ5PPFD020A49E6:EE_
X-MS-Office365-Filtering-Correlation-Id: b73ab240-8000-4f19-a197-08ddf5fe4de8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/W89agPtf3npxYs/nvIMo6HXQ6JwZJ5y9AFKnHeU54AgVDZ3T8UPTfr5NJWR?=
 =?us-ascii?Q?kxNzTS/i0aKi86LV3m9eD4v5gGlnAcGNtbOT1BO8Rq0QdgPpTPnP/K+rwrap?=
 =?us-ascii?Q?xqsnFE0zLtLrtTsigopMBvC7X7YJR2sCqod3zhfiFmOJT6ORkvnZs/65gtDb?=
 =?us-ascii?Q?2FRHr9yXOoCBV2cMZbNg9ZK7knIyCmITDgauIAEV1zKp8dM18pHsMpBP4y9Z?=
 =?us-ascii?Q?6nT0DUaAMNuEvwOmb3i9kk2cDGrilB74TPNLngLR6lx1HXChD69/8WhmSkyO?=
 =?us-ascii?Q?gGLAtCqexB41c28V1yDIbz8xTj7/bW2Vvtbu+2DdmWo+3p2QB9uHysleipIj?=
 =?us-ascii?Q?0HZwtC/Fb0N1q3knzQ1IHn19sPkHQ4ipWLLc+Z9LFYyOy6AZr4PpjCNDM9dz?=
 =?us-ascii?Q?JDzppFA6al0EYBuF15ULU3elIhXb4iOpo9bs3NuDJ+mwntGayP7xbvkiwbN2?=
 =?us-ascii?Q?inFkamL5+tZif/n+zQ824GJCWGZ/qtqaRCyOR1+Q42xjoezzDsxRJ760CitV?=
 =?us-ascii?Q?B06GeuruMLjVbtOCi6Vs1uGcjkfw/JvXYw4XHnKQUQAmwNyIELp0XniTr6nh?=
 =?us-ascii?Q?B7ft5WwZ8KTdFoiYSvJAbPSPK2QO9RaK/2lTMcvV2FI7UxYHtqPz7hIQOtiA?=
 =?us-ascii?Q?BfB6BZUgP9x0WA4lW8jZbFf/9/U1XP+ViTswqtwRZnE/fdO20wel69iDgjcZ?=
 =?us-ascii?Q?2gLK3dJQkllWCBrcFLDOSpegGdULQBWL3OVauhR4zg69+c99/4WAODNDkGq5?=
 =?us-ascii?Q?/dMfjCtHBxPSEnwxhUKmz8WcMVKrB6zNJL0oLklb8XJYCrSrmmFF8l/6jlXW?=
 =?us-ascii?Q?Q4XmbTg4UM1RehIEvcJEdh2gjHwMmFHMGdwf4vUVfz01v/rIoI4+KqnlEt3u?=
 =?us-ascii?Q?H4gNwpK38f2RkNkyTQTxTrAalKDa6YBMgxsoJrvJFHAJ1nXVSLqsj9muy0Me?=
 =?us-ascii?Q?lamKR2+NUapmHbZu1M3nStshFZU20Q1/xtTFdRVqu8VG2hXWkHnJJB089QGI?=
 =?us-ascii?Q?9YVNOrzIkaXrpa82TL1PeyN7mKz+U896uzusoheMOoa7qC4vxRE3VDlPkfJI?=
 =?us-ascii?Q?lchQSPKr6NSGSX6r3GYZj+X0OCNnPkUlO8Bt3s/LF+mVKSAZJcfuNgGtw0wa?=
 =?us-ascii?Q?MmiCalqUze60sz6RboLIFdBqs+9/hKvCE9cLIi/bsPntvZwCvqTLPsOFguaI?=
 =?us-ascii?Q?DR1uACVcGRM1pO/ZXsjS2rwROySrse/pARESJ2JdGwf+eexnrg80kKYhxNJD?=
 =?us-ascii?Q?vxbuz8Z4IBckqRjtSWbc5r7GzM5+WItugvKVPpaHHhFtkTSm7ifDcBzijwIS?=
 =?us-ascii?Q?B8a+3Umu08wcwGzMFbycZ3q/VHH1FWegLJrvzJXnafZc2hlCnCx03PmPS57x?=
 =?us-ascii?Q?PCev8ZeX/mDcSlBaP6Kt7egf/zO96FUDAmKdKP6PNEf4JKWmbA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yu6X+dETAfEdYL7+ovcj/rgH24narWVsuE4lTOkOABymLqYn6LKJIDDEuybO?=
 =?us-ascii?Q?7CNNwzS4/NYptxz56t3pPpsj56cgNFeEMqjmYtMV9GPRS5x2t65SUZ49QjOi?=
 =?us-ascii?Q?itgDXKa8gsLFEtkh2LNI9X7KG9oDhWI42znLkQI5VdUUBXIWnT5PHs9+8bBZ?=
 =?us-ascii?Q?HjGsAaDoAeqdoJL+Ylnrk/F+NLS9JoUlThE8xMlbtmlpHRldp5L8VNbOdwJT?=
 =?us-ascii?Q?ReO8uqAv8B2uYNaeqGpDBl4e+K5ShPzk2YWDMc0/+VUXbVfvcvT9xIY1RwWy?=
 =?us-ascii?Q?qKLUdCsltV7FINEf0O22h1x56zrvxEUy1a4sZiyeoimSgx+aJRHl6fTgazvY?=
 =?us-ascii?Q?OTcLL26LOXkYTlwb1oTmrYrcU0NTdq4ihfoq8Y8T/v+g+Q1F75OhFwvoYRtR?=
 =?us-ascii?Q?03e98EMiv3TU56KzwyJhfhjatzArRBQlQvyKiKcSss6xG11F/AjcfTqNto+O?=
 =?us-ascii?Q?DdmSPqqJPz3v3Tpw5skNyUGaEfw0PfLD9TH7a8R2Pnwwjk67y/vSHTv7gRMO?=
 =?us-ascii?Q?tM1IJwotEwJXxw8GBnuncFp7fDqcAuWfmhj/nl1CHJdB2bXz8ar01Q2gj13O?=
 =?us-ascii?Q?R0wlOYXculagvczMtSW2FyCmQngiOdg5xtudvNQ5vZT70KBTXRrXyD1MAUg1?=
 =?us-ascii?Q?3JKQlgRdpY0AmrVz3MoQki6+4uJWyysGvueLvB59sD93pB+FISqdXA9vZgNy?=
 =?us-ascii?Q?Si3bocRHbc2Svrhu+23uh8tAcxZaIdZG4ul+a+9vIIpybNuLbqXcCZ/PdvHm?=
 =?us-ascii?Q?XTwmnAh5SSKVqUG0Nhl/kt0hxiBV9ob13AyTDUjE4BrPapwApDE6vuQ+AH18?=
 =?us-ascii?Q?CWrIhO/Cp9O354eA1YUO+4dWiNh8P0He+REtrpENFYJuTKsBVHn0P2ffBV3V?=
 =?us-ascii?Q?uSiTX4+nQKLXDoWG6YISJ+uMLe9tdjQJnUcj772Ffgg7gA2gmJhgyc0mM+Il?=
 =?us-ascii?Q?aSbiMho5mnO1UfvOGlk6mPkR6XAVOfBQ6c1VTDHd/tyx62Nv5FclNHglAu0+?=
 =?us-ascii?Q?6cWIaCBjyGLQ+LQuLiIgRJDLES2j26ieqV6JUvR8C15w7vq267jWzgs2JMNv?=
 =?us-ascii?Q?Kun0ZwOH6DqLB8dCu+8iuQWv09cJGY6T32kNFZjTgxUIQb/jeP/uS1ZvBV2K?=
 =?us-ascii?Q?QLykTfEz3uAeLhdlCl55hCqEVl4FzBH0eGcUN74TdEBOSNCoyweS/P0TDopH?=
 =?us-ascii?Q?Bj/4GJ/ZN70gZSbHvZhXDEWKPgvVBuBPmb7r/qEKS47wMzfCyjVRR2d4W/cs?=
 =?us-ascii?Q?yOVc2n14Sbqx0slRfZzqNMzcaz3Cz6qKVVfjoiOtjNGV/lsqY3EEOt1VIIjz?=
 =?us-ascii?Q?Q3xaYS4MSNt7jj+CjrgiOy1OKFZwHLbUOyOnOm8OzfSfykXmvxVKNZIkp6CV?=
 =?us-ascii?Q?zCgZ537ZWMnIGLMEMs2+UE1dEcqrkq23SIlpNf/JN79dHU3wgLGp8rLEU/S7?=
 =?us-ascii?Q?goULkcUsszV4G9Sx+TjxPu4CpBC12Ug3DQgHmCI8zikoU3jttTnGCE+TfO+3?=
 =?us-ascii?Q?2pMd6ZAqeH6YcAwiS0HtJ3nfgF0xRDNIjJNraGSfhBWEnJu9e7bEzy4T0UZD?=
 =?us-ascii?Q?RHWNhaAq18nUQkyWXZJoX5nbKg+nXLdCA8wguT35orwJaYp/vyoLci6JB4y7?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aq6YS8ANA9BdNee3e37X74IEhWIcGkDmwhXJUlhoLqpW0WBbjc572axwtgc97XT6eOqubrapDhrA9XQolGA82HRswjAGe8yuXh/SmHujyA42cbYFE0Wfi6zEzdhBxzc47N681tLICcCuI8EI7ZBmpwllh2FbRUvcPDJQ24A1od+/aGHM9RY3x+AgCb8lvnf/cUUEN9rt1r7ylCSgKuIGrBtXHIIuxzURlsu4pzgC9jlqYtp7Dw+oSUQw5ajsQ3Yr6U/pWU4gHbOM0ZXheR1TlJ6Rt0kNQaFL/BsGVqHBz13ehGCBltrt+aMccf/GZzAQolFwOEFoqyLS8OXU+IGlqf4K78tlMoYJRbAdAAesGy2ySJ0s5VY5GCqIKHwex0RCKSBYac51bIGzSMA6RyJFm70muEN70QD8LYvf/5dE6yUVKK8KTyPUY8zDaySzzwUMLoh7Lz51Dqw68n/4ScmZZMCCFTSV6/c2z9hd61cBLGs3cDk4OI37AF5qvizfDlgDDrzqZ8WvjwzWzaArfv9pVHeSJJZJ6mEdF9N+5FVN900J/x86l+K09mDm/Bekr8PydqwHB92oDkQDwFLv1Tp1GQdhdF140JMXZlXlmqLnapE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b73ab240-8000-4f19-a197-08ddf5fe4de8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 15:24:33.5610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHuKYRfPEXhdYgARHKQNTHxUpIS3QoxA3qywtj8lhfiUV6IapiDAfS0L80qpzExp6I6KJzijLncUZMbbxvdykLwdefMbtWb+cNM/qTI2Zto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD020A49E6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509170150
X-Authority-Analysis: v=2.4 cv=JNU7s9Kb c=1 sm=1 tr=0 ts=68cad2b5 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=Us96s6kiNGSoJA3BlCYA:9
 cc=ntf awl=host:12083
X-Proofpoint-ORIG-GUID: RsML2-9Lw66XP5xSPvQq0PmHEQmIGqqz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX4VBAhrGXO3vk
 sdKwaSQhZNpBnK5al0NYP2FVFRALUcYIgbaD/nBdBdzRDd/R23G77yaMtgK3+WLt+T/uRnDDXfg
 UFd/ZXtzCcNkJq8JDHstGYuqgS+boVA5FecaY/sXuyK9tf1oT36IInkflqM3spAVdb6BJhImY46
 uBzhGvHjvygn4eJtdoB6mFYkfJEU7yZC1OD4q5xGSFlUDKZgT1ujfsOef8ZBQHHs/MO8SxDaySo
 Guq1kt6aK7TNCuZDuom6/qMga7WRwP4e7578xLNBOxd5J4y1pquHeGNMsQe+MIhYy1Uvydxdux8
 /CLFnWi8Nw1QQyPceuenAW9mrQx/kMXVJT+xxvgLa9W67HfS0c8UWjbOKRYCFiOnzzrUS+98J0L
 /Dq9baYW2KhQRrNKH3++IRRphbYeWw==
X-Proofpoint-GUID: RsML2-9Lw66XP5xSPvQq0PmHEQmIGqqz

There can be a significant gap in memset/memcpy performance depending
on the size of the region being operated on.

With chunk-size=4kb:

  $ echo madvise > /sys/kernel/mm/transparent_hugepage/enabled

  $ perf bench mem memset -p 4kb -k 4kb -s 4gb -l 10 -f x86-64-stosq
  # Running 'mem/memset' benchmark:
  # function 'x86-64-stosq' (movsq-based memset() in arch/x86/lib/memset_64.S)
  # Copying 4gb bytes ...

      13.011655 GB/sec

With chunk-size=1gb:

  $ echo madvise > /sys/kernel/mm/transparent_hugepage/enabled

  $ perf bench mem memset -p 4kb -k 1gb -s 4gb -l 10 -f x86-64-stosq
  # Running 'mem/memset' benchmark:
  # function 'x86-64-stosq' (movsq-based memset() in arch/x86/lib/memset_64.S)
  # Copying 4gb bytes ...

      21.936355 GB/sec

So, allow the user to specify the chunk-size.

The default value is identical to the total size of the region, which
preserves current behaviour.

Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 tools/perf/Documentation/perf-bench.txt | 10 ++++++++++
 tools/perf/bench/mem-functions.c        | 20 ++++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
index 04cdc31a0b0b..3d1455d880c3 100644
--- a/tools/perf/Documentation/perf-bench.txt
+++ b/tools/perf/Documentation/perf-bench.txt
@@ -187,6 +187,11 @@ Available units are B, KB, MB, GB and TB (case insensitive).
 Specify page-size for mapping memory buffers (default: 4KB).
 Available values are 4KB, 2MB, 1GB (case insensitive).
 
+-k::
+--chunk::
+Specify the chunk-size for each invocation. (default: 0, or full-extent)
+Available units are B, KB, MB, GB and TB (case insensitive).
+
 -f::
 --function::
 Specify function to copy (default: default).
@@ -216,6 +221,11 @@ Available units are B, KB, MB, GB and TB (case insensitive).
 Specify page-size for mapping memory buffers (default: 4KB).
 Available values are 4KB, 2MB, 1GB (case insensitive).
 
+-k::
+--chunk::
+Specify the chunk-size for each invocation. (default: 0, or full-extent)
+Available units are B, KB, MB, GB and TB (case insensitive).
+
 -f::
 --function::
 Specify function to set (default: default).
diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
index 6aa1f02553ba..69968ba63d81 100644
--- a/tools/perf/bench/mem-functions.c
+++ b/tools/perf/bench/mem-functions.c
@@ -36,6 +36,7 @@
 static const char	*size_str	= "1MB";
 static const char	*function_str	= "all";
 static const char	*page_size_str	= "4KB";
+static const char	*chunk_size_str	= "0";
 static unsigned int	nr_loops	= 1;
 static bool		use_cycles;
 static int		cycles_fd;
@@ -49,6 +50,10 @@ static const struct option options[] = {
 		    "Specify page-size for mapping memory buffers. "
 		    "Available sizes: 4KB, 2MB, 1GB (case insensitive)"),
 
+	OPT_STRING('k', "chunk", &chunk_size_str, "0",
+		    "Specify the chunk-size for each invocation. "
+		    "Available units: B, KB, MB, GB and TB (case insensitive)"),
+
 	OPT_STRING('f', "function", &function_str, "all",
 		    "Specify the function to run, \"all\" runs all available functions, \"help\" lists them"),
 
@@ -69,6 +74,7 @@ union bench_clock {
 struct bench_params {
 	size_t		size;
 	size_t		size_total;
+	size_t		chunk_size;
 	unsigned int	nr_loops;
 	unsigned int	page_shift;
 };
@@ -243,6 +249,14 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
 	}
 	p.size_total = p.size * p.nr_loops;
 
+	p.chunk_size = (size_t)perf_atoll((char *)chunk_size_str);
+	if ((s64)p.chunk_size < 0 || (s64)p.chunk_size > (s64)p.size) {
+		fprintf(stderr, "Invalid chunk_size:%s\n", chunk_size_str);
+		return 1;
+	}
+	if (!p.chunk_size)
+		p.chunk_size = p.size;
+
 	page_size = (unsigned int)perf_atoll((char *)page_size_str);
 	if (page_size != (1 << PAGE_SHIFT_4KB) &&
 	    page_size != (1 << PAGE_SHIFT_2MB) &&
@@ -300,7 +314,8 @@ static int do_memcpy(const struct function *r, struct bench_params *p,
 
 	clock_get(&start);
 	for (unsigned int i = 0; i < p->nr_loops; ++i)
-		fn(dst, src, p->size);
+		for (size_t off = 0; off < p->size; off += p->chunk_size)
+			fn(dst + off, src + off, min(p->chunk_size, p->size - off));
 	clock_get(&end);
 
 	*rt = clock_diff(&start, &end);
@@ -402,7 +417,8 @@ static int do_memset(const struct function *r, struct bench_params *p,
 
 	clock_get(&start);
 	for (unsigned int i = 0; i < p->nr_loops; ++i)
-		fn(dst, i, p->size);
+		for (size_t off = 0; off < p->size; off += p->chunk_size)
+			fn(dst + off, i, min(p->chunk_size, p->size - off));
 	clock_get(&end);
 
 	*rt = clock_diff(&start, &end);
-- 
2.43.5


