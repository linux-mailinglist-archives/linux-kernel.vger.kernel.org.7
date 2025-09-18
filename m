Return-Path: <linux-kernel+bounces-795779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6892CB3F7C2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4243BB0EA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359242E6CC8;
	Tue,  2 Sep 2025 08:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kxTJV+/Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y2FtXeVF"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BED2E88B5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800544; cv=fail; b=POmCy+seDgYJJMOLKbTg+5M5ZRMI8F99K9zGUrsxtuixP0Uc3F31NmknyxoGwHpXh7q1KCyvgsuQA2z8RXq5MTpSkdvQvpmhUGDQ5NaH+S72mKwMtGWpJtPZ9NBDDCW4aMCW0LwOX+T23C9rp8lupQk0AMFPAcuEW+q8EO0n0+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800544; c=relaxed/simple;
	bh=x3GnM7rfwDfEBvzelLoovzwBPOhWLVz1sRRXlnsRlJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pJmRSmMCj/R5jqj1e+mIZELlmmAj/ezEngG4bhqSb3iqi5p94Wj4Zwi+fd6ZOeYitJ0vc1gKKERYfhuDIU5+HbDz0QPRR1EohUfZVNs0tF2IZ0oFIjNQrDcpGUNcE+1GKr/lyu6PYsWMhQYFI/WSAGDt1ODwetz99kMHJOKWZ3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kxTJV+/Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y2FtXeVF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5826foVU026480;
	Tue, 2 Sep 2025 08:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=TPfAe3JQcGcPTps5duHu5oiaK6TDdouCxH60jzZmr74=; b=
	kxTJV+/ZKj+Gi5bk68FFxOhvYSw82oCcz9Z5uGOaNOESfW9Ph/On6v2iuSt0ECwL
	7uz89b6J2Y0+S6Lb61AuUubyh0d14N2TQfi7VUXdcO09I3/HytpEGFF6u2m6EuMZ
	QHcE93iF2Z6lHDz8m8zn31FN7n8OdfcPwxQ8oJ9VXckAvc6qv8WTZ2GrpOyXdgd5
	QAv14evlkhjuLkG7ljMjcpvqWmZDB1uVsbF8QWm8jTuNKf4QwJmvtsBPRfjWwjaH
	FX1ya6pjpaXF1fS+rGt9cGJYawI2Ex6NLhjbw2AUOL/1rANIz91derwbfmbCmOJd
	j8PiLli9oKzi9EpwqFRAmw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ushguf8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 08:08:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5827nYtS024842;
	Tue, 2 Sep 2025 08:08:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr8j6vg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 08:08:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ct0xjYgyrDSin3qQydkTpS5xQcppmqfv4KfOMYuQXGwJYGKxxcvXsUNQvSXxmZ9jN1fCJg48gtLEDZaUcmaKPYf2QV5Ve/he4S+zy6HPR4xYvJx+Adm8Nu/ap6ElEW4WKiKXeFQcJ+YpJa1gnYd4R2mw+jnbKayrokerJS6MX38FyEYDkLjx9evOvHpXfYftAABRIY9FLb6Swyqf92EWsGd7752r4gf4K4qyW0ufrUmb7rrSQEzk2o7LfBVkvhSpg1T61TlbKOQnwVZnz7SyEv0aOw+nh7ShZJfZO6gjBfw3y27Si5CyLHCCJcOiFyVfIKXsTuKcyJIRtLJIiD3rLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPfAe3JQcGcPTps5duHu5oiaK6TDdouCxH60jzZmr74=;
 b=G2aHesW7RDFHQ4dEZyWH3A+MM29aumJ5t8/rnIZ6UJxgrpCrLcKAT9v7wADIFdId2z1jIqzUMnxib2jzkJw3aCkTHswwoX0xzud2x3bQYoahGjKhBo3PXv6RIjufPcEzx+SMDEArNkp+TnAyPsqZdSFdDEFxIVoMGxwioBnkQTORPUyjeEZLYDjMOn+7x9zyfla/j879VnOYA1EGwgf30w067tM2oJZAKMENneHpM0+ARIb3o+1NBPCbAWzjwlnSvOnQbauRRPRzu/RvaD1s6MpZ1p/Tj4XmXfHamrEgsSr/1dDc+norOSk2x0g7kOPSPtyYjWMlqaTI5t/HmuV9cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPfAe3JQcGcPTps5duHu5oiaK6TDdouCxH60jzZmr74=;
 b=y2FtXeVF7bDDw6rwf2ri5Q3pOpbf2I0s+t+bvm4HZjKewGoEXdjBomjBDNBq0y5GsH/P7IYgEP7DScICBO3gbzzTAKcuFq/I3lOGdmGojiLDYCYii1EmVy7ULgkadlz3RoNa3w6slDsxeFfKloE/ldqwtW7zgLV/CU/Ggv5mmbY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BLAPR10MB5139.namprd10.prod.outlook.com (2603:10b6:208:307::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 08:08:36 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9052.013; Tue, 2 Sep 2025
 08:08:35 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v6 08/15] perf bench mem: Refactor mem_options
Date: Tue,  2 Sep 2025 01:08:09 -0700
Message-Id: <20250902080816.3715913-9-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250902080816.3715913-1-ankur.a.arora@oracle.com>
References: <20250902080816.3715913-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:303:b6::11) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BLAPR10MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ea61ca7-8ee7-4335-75fc-08dde9f7ea70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O0OTmIxN7XJi+60cooeAU7Bj/rB4W6pbMOIoBnI2I5lixmN/TgegcaFN0eny?=
 =?us-ascii?Q?pPA56/vRdNLmi0LnZTDe4K/YdK5zHJQpHS8B4mq8GTjDRFBkwqa8WgadPxbC?=
 =?us-ascii?Q?QeDRlywYF8yS78aiMNXbWEYuJY42bukbXq6DOWfZQyalU7aFXkGrVqdXJ5Vx?=
 =?us-ascii?Q?3oS4mhdyBLSOE7jxx2SJzkiOwg5OsRQzUzxzY3HtWiHiBbF5LD/gHmvI/xPr?=
 =?us-ascii?Q?0tS0rrxE7dbATQ8v5ENRhJR3b0Puz5GAIgTxkYpiBYLdACwu9XBg4gBGP059?=
 =?us-ascii?Q?sLkCaZkWBVF64rMZb9Rl1IIlQztwbg5FPVABvSqumKzHOdBcWK0CLLRcklhj?=
 =?us-ascii?Q?wPnr+Zk0vt4VGkzg7M72xrQ2jgI7u2Gl9MfdW5Rnwws+7zJdxFM7ZV2LhLfV?=
 =?us-ascii?Q?gjNShP80qmsren3pmgWYuQfNsCJkIBY82oXXn+pkviwDXNXiTi8v5UBHS2T9?=
 =?us-ascii?Q?llwcP4hxyaTrGzCq5dNJ/rrhtVWN6F21WBoj4OTc7daUK/4ry783m/x1eTd0?=
 =?us-ascii?Q?7GyDOW43OigIP1KVUA2tfmWNST27V2c8I4N8kb3LpkISC3kDfs2gSenYOUOm?=
 =?us-ascii?Q?Xy/0OfbK8lnmIB79FFR6i26/42Qbi+uPfvIKBcEqX3loZ93k2Xjn5Fskb1rl?=
 =?us-ascii?Q?DCVJwwV5wV5STq30JvcD7xn1jgQ25/4b6ma4A4jjTZ3kuM3SJ0ADPs0UGc4H?=
 =?us-ascii?Q?espuxS7gi17HrquY/eJr5bjEP0LFUAOpYI9w56mkmmjfN3oMBXAgml01J1V/?=
 =?us-ascii?Q?h3DHp/rsG/0dr/kkLnSldca+pcsZDN5/HBpWuhK4pYd+Wy9AMfnKbQPSa8M/?=
 =?us-ascii?Q?u0i/yFrDrp/0aVAF3G00gT1y/vU1PxB+XPDgnSN5vXQVB5OSbbIfk4MoBg95?=
 =?us-ascii?Q?GdSCPQGe3SCCgBuB68mmuTuj6VYfIcNcjz2MUt5hU/LPC3oetwkF/410qF5Y?=
 =?us-ascii?Q?CyNjS25/V3RqwPY6lELGE3FqR6Y1AmlFJ8QU06dS5iRsNbNd0RTXOX5+yul4?=
 =?us-ascii?Q?R2KNAiHLJMy9GrWSsoJg6MWi2E3zPT10dXc+d6FvoXvyBj+0jMm1lSDN2MT6?=
 =?us-ascii?Q?KaTCrmuWqPr1I7YZpU+OeUhhmfuHKWWi9/Luk4H0XfEGRKJW5Y2qh40LXWGU?=
 =?us-ascii?Q?5ms+fADvYuX0KB+5qVUAbdR6k8qTxZiIqcPqmzDfcW2frxOEgiURmzTthxSh?=
 =?us-ascii?Q?lzA3xinVITDJ6Sfctb6+zdlA3U5Fiy3uE1DVFYcrkUrAy8u1WCBvz8YsJvYQ?=
 =?us-ascii?Q?TM0CAKiTOy1bqVuGlDxy7kZHAh1F22QCIiR1wKyEkXuMYN+86xSfSUJmNT1c?=
 =?us-ascii?Q?UPU2CgUIpaRTuGfXpHnqN+lN/k6NNOJcMYKpV0gqLJ5NsiZt9Nml+n6rU/eK?=
 =?us-ascii?Q?brTXJd6BGJx8o9mW6fOURS7u8t/VEOX/kQB2lstBXpy31ZLe5g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KnHNDS0BhjYWrLTlWkDwt0zf1gbZ5t4dFEkgu1Meq1W+4QVuotQ74qSx+RIY?=
 =?us-ascii?Q?jpJKoMy6lBx2WZhgXZCUYusmHgvcJYjautmN4o/A/olw9p8UDrZHrmrpL1yR?=
 =?us-ascii?Q?PmVYaUsJDnm8WoB0rj0QZoPdUbOSCBw9KAmvgavR2S6tSVhy2sLqlx+ihg6l?=
 =?us-ascii?Q?ptcW7qDwJIcsgTN9LP3B+hcqZcH5JsAgy+sT0e++KxRW3p39W78gMhdQPrgm?=
 =?us-ascii?Q?8gPKwFSMstbI/tlscyHNkVSHfAB7/6CfJcIHX40ie120Ayl+OOpni5ru8Vd0?=
 =?us-ascii?Q?6EO87mqKx/gjf2ElgYFH7EMyYYnjNElh3jBh2WHrIZdQIAghXALeaCxnzvw9?=
 =?us-ascii?Q?52SN6NOzenEp1U2B2tK0A5Tffc7migRqs+dpIIG64qSjFHD4sWx7qcSk6hrX?=
 =?us-ascii?Q?nst8L3d2cHcLw65OKYxooTimnFHYLar3qAx0Ug356nfPxFEMPUFqmA9CpItR?=
 =?us-ascii?Q?4kTW8/gBuLsQtHxEO1OX23Y3Jca+zEgEwPUHRsTU/oncmwGrvuCQPX1qiDdc?=
 =?us-ascii?Q?R976Iysy0D2D9OJY9nGAH4OJ74NTpgt2xuNT/VWJVaYqsaGGQt05grinbgCz?=
 =?us-ascii?Q?2qNZ+/zu8E4h4wxfHkd/ie0IxloryGlejW4LgR6ayFyNY44HRcLT8VVozCIt?=
 =?us-ascii?Q?Z/8dRL/aGVhZtkzMeZPW1K/+SZ5RCOvisIJubvbKXCxpf1Ss3NhKTIe6VWxA?=
 =?us-ascii?Q?/cMyHnjSLdiZekSLg6HKk3CwtEFTjHhvpQsFg8OGjRWy1n+Viq43E6Fial3W?=
 =?us-ascii?Q?icHdNxP+gOi9Z6z77ElRJsLHJg9hdexRCiE61m86JwbhKBrt8hJkHf4bRElY?=
 =?us-ascii?Q?Pvjcwn0gtgEgcobdpK2916IxgIN9LZZa6M6Cs6V+wde31yl0tnYKqMoLP+C6?=
 =?us-ascii?Q?Kt7sNVN08dtdjVUYQA4dy67MQfmQ+wz303tode6aUs5MAgXk/hy820VZJtaM?=
 =?us-ascii?Q?l8jg8EsTYie86o2XAwHKFeoMrPX/Vp83M9bnnmIY3h4wae2JkEqSVi9iuvzF?=
 =?us-ascii?Q?ZpomsYfJTlL9NPrCZ6U5w6rOAVs/6mJJUdVAbQw9IngW33iQrZiYckYbkOVZ?=
 =?us-ascii?Q?U3NestihY7CETkv38ymd9Q0CO/IzFgsGp9wX0WYYOKsEpI3jds3g6fOpDn1A?=
 =?us-ascii?Q?AKJRoFjXlNsvWsWE6SxqY3H9PRnYylStglFmSEi0StqCvPgtAh41CbIZbTlB?=
 =?us-ascii?Q?/rPZXM81evbHUgj1dn0Cl14BdwnRaeXMVqxFrJQ6jLyAVznffeeMw5fTX0Kw?=
 =?us-ascii?Q?fttATgKmWRlq4pfHXCBsaRSZXjse0p3D3hNnxmsBSiu41GJv6Xp6rCIsg68r?=
 =?us-ascii?Q?nS0tFX2hBRGoLlKJcp+FI/5754jJi2TL4dc5WfUTZMvQVumdVSrJpFNcbCPC?=
 =?us-ascii?Q?344C2kwFw8/S4fFLKdc7uRizjknUt4CvvCU9Yd9VMEWXEJtuql4sXd/3LRzr?=
 =?us-ascii?Q?sR9OVyEHUcmJpxt9GjFcE+OWDcdnpEOyi+B7ZfipmyXoPiEuM2fADhyk0FmS?=
 =?us-ascii?Q?Ud2H2NR4MMnV8QO9cM5pKdyYdHunVlgptruLeBcP5Zh22BI8ym8iT8NdUDhu?=
 =?us-ascii?Q?cq7uRn8hNf3yMV4tXdnRVtCwUDVssMeFEzFMjUgR8u0JEYElMKKbP9N9fQco?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Lvh53C7uW1y+aCxQNRRllmteu17R4zVrXKlKLXn3Y7CvFrqSNDiLyO1N2RACwPDouZFoiFADb6yopVLM0D+NTpxcpywOyJrCNHhQvo3kqgqd2Tkr4Sut1PaX7OsX+9UtdNZZh18i11hMnvLYz0gOEwRSiVdVSYZGknRMYFMBct/DMdmUbdFvNVKWrRifY9Uz+QfwItLfhAIOnAdjMVU5VCxsxIYPfK8swa7t5qNCLVlCoVbQbDoTu671ipx6IXPXCClhc4gwIzhrhq4L4YeSIjpp6Py7EqnQ5+zqAB8+xiX8z2Ogja2zcSyZ5NNbqy663LEe7iD+02VDzDTQNRvLkEF4Kp721h1wUS4a7pVTVW5Qondeo3DGO3GyC/Ulo9deUpmSVokyOhngIOqGp3W9hmNr/BIB+mMAmhX8GrTf6F8pW7rEyCnOapeKReCitnARtXucgHacqnUgEOhwKj7MidwUlWrG+mPU2YwCttq0Idh9nVCw5Fn6W5Akxywg30Y2H9nDNzdfxFDiEm5JK3Y/HUPC9PRaBW4+rerSfpA3TZrL+Wdub2AEyAi8A71xuQsCks1UeEpGvGEykA8WClFFCOt7kapVK0FguAYBoxCLO6Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea61ca7-8ee7-4335-75fc-08dde9f7ea70
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:08:35.8782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZAiuH88azHw61BFpRvPE7FAsUw6KNHj+ZJLIcZtgE11w/45yXXZDB2l/LIvmJEZRkVp5ubP47ccUB7JFczxS9a7E6rSEGslDI/q4HlFdh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5139
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509020081
X-Proofpoint-ORIG-GUID: i3l_pcmPY6t64CokiGgMofXSssRTL7aA
X-Authority-Analysis: v=2.4 cv=YKifyQGx c=1 sm=1 tr=0 ts=68b6a608 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=_oAs_-Zd7h5Ft3cs7ucA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX/19/FmdJLGuR
 hLXVF9sH/IxwrlfrmqWbLY4ZY2xzU6xESuETqvI0G7v/tcehL5K48lzMOfHvE3wnomXvvCWv+7x
 dKCZnZWW/siyC7l7nQ4Loalb18QQdiIunqSuY4jZy9fw3fmk+z8NMV2CA+tdAXcTOWi5jbS4RNT
 2gBTFnTSVQ4q5O94Z05HI/RKqVOT6j/0ia0xA9O5Zy0H59TSQ7MUM1WeF9Q0DwHf0kcyxw+kRUx
 bHAluWUVKYVaOtsCRciLQgNH9KDhUIudsGhITrTBDJ9s4R2/Umtdk/teQx9ylKv/PB8d1SE8HER
 Wn9Ruq/GzC8zE9wvYvszKURMGXN75PUQEB4oLJ0VVbB4meCt4FRyU+D79DNYu3FWNsAVHPzuek1
 ybcag6Y9
X-Proofpoint-GUID: i3l_pcmPY6t64CokiGgMofXSssRTL7aA

Split mem benchmark options into common and memset/memcpy specific.

Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 tools/perf/bench/mem-functions.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
index 69968ba63d81..2a23bed8c2d3 100644
--- a/tools/perf/bench/mem-functions.c
+++ b/tools/perf/bench/mem-functions.c
@@ -41,7 +41,7 @@ static unsigned int	nr_loops	= 1;
 static bool		use_cycles;
 static int		cycles_fd;
 
-static const struct option options[] = {
+static const struct option bench_common_options[] = {
 	OPT_STRING('s', "size", &size_str, "1MB",
 		    "Specify the size of the memory buffers. "
 		    "Available units: B, KB, MB, GB and TB (case insensitive)"),
@@ -50,10 +50,6 @@ static const struct option options[] = {
 		    "Specify page-size for mapping memory buffers. "
 		    "Available sizes: 4KB, 2MB, 1GB (case insensitive)"),
 
-	OPT_STRING('k', "chunk", &chunk_size_str, "0",
-		    "Specify the chunk-size for each invocation. "
-		    "Available units: B, KB, MB, GB and TB (case insensitive)"),
-
 	OPT_STRING('f', "function", &function_str, "all",
 		    "Specify the function to run, \"all\" runs all available functions, \"help\" lists them"),
 
@@ -66,6 +62,14 @@ static const struct option options[] = {
 	OPT_END()
 };
 
+static const struct option bench_mem_options[] = {
+	OPT_STRING('k', "chunk", &chunk_size_str, "0",
+		    "Specify the chunk-size for each invocation. "
+		    "Available units: B, KB, MB, GB and TB (case insensitive)"),
+	OPT_PARENT(bench_common_options),
+	OPT_END()
+};
+
 union bench_clock {
 	u64		cycles;
 	struct timeval	tv;
@@ -84,6 +88,7 @@ struct bench_mem_info {
 	int (*do_op)(const struct function *r, struct bench_params *p,
 		     void *src, void *dst, union bench_clock *rt);
 	const char *const *usage;
+	const struct option *options;
 	bool alloc_src;
 };
 
@@ -230,7 +235,7 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
 	struct bench_params p = { 0 };
 	unsigned int page_size;
 
-	argc = parse_options(argc, argv, options, info->usage, 0);
+	argc = parse_options(argc, argv, info->options, info->usage, 0);
 
 	if (use_cycles) {
 		i = init_cycles();
@@ -397,6 +402,7 @@ int bench_mem_memcpy(int argc, const char **argv)
 		.functions		= memcpy_functions,
 		.do_op			= do_memcpy,
 		.usage			= bench_mem_memcpy_usage,
+		.options		= bench_mem_options,
 		.alloc_src              = true,
 	};
 
@@ -454,6 +460,7 @@ int bench_mem_memset(int argc, const char **argv)
 		.functions		= memset_functions,
 		.do_op			= do_memset,
 		.usage			= bench_mem_memset_usage,
+		.options		= bench_mem_options,
 	};
 
 	return bench_mem_common(argc, argv, &info);
-- 
2.31.1


