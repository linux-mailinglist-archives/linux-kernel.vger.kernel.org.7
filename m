Return-Path: <linux-kernel+bounces-739690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC61B0C9BF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9ECB17D8D0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D6D2E2640;
	Mon, 21 Jul 2025 17:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kf4pPa1a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Sa4BQRFJ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C34A29E0F4
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119269; cv=fail; b=gBEZYUwzVRu+O0gqcYRReh42en03EV53x1IDXCnAQ2Q5rm4iEtvPKUTq77mhfyzcRfARMQ+J6HUaIkTxhP3NBdi/sE5vrnsrfNkMb85aRDTbYN4r8DnnqxmNHeWDtZsg/f41dHrNnqjDYz80ewg1+5iJ11vclY1vfpqd6LITIG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119269; c=relaxed/simple;
	bh=pMUGHx9jwqgOeQH/vHqrXpV6WU/9qrP9QUJFUxhVQp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LAUH7j83RnNEqo6ohdUyN3QwY21+CaX7saWG79lJ19XCtmA0JbL3AjFZXxvOEnMtqTYAMhekhE4Odlv4TAC4oAkIGg1n4tKCNwmSDDS/6nULpJ10ad9z0HbYcNeV2inK33Vxi5jIQHyJkSUckxH04GY5OZU8gD/pgfu61qDeeEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kf4pPa1a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Sa4BQRFJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LFQsmT007265;
	Mon, 21 Jul 2025 17:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7n3eXWPo2Q56GgEbQkCx1X8JPPRVnMpqU3oOl9yxewY=; b=
	kf4pPa1aCSg51eaVL26oll0VUA96imMCIZeawRRFa0Wqliu5hqfC8yC5xx8l6cyh
	osRUbeOhZpFQiKxvVofLHf46we3fCe65OOGy6OssFzriHBnyJvmUv22upxktPZn1
	cFMv3vQs3uoKqwDtMGQFGkmqjDNtIcOliGpW3OlpJgqm5cwPXODLfklDRKhbW3a8
	IHd+Rqe1/ttoGr3QCc1trXpvIvqwUxHUL4SIG/UG72eP+K1/i1MV8qf7rG1Z9qZ4
	b9j0e4/nnlOPP2bIblogDs2QIPedG7dL7bhF75SZ1cSrXYUstyqt46OQoweNMc1Q
	wwaEsA7TCZr+YRLwFyvftw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e9kctk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 17:34:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56LGUjp6031545;
	Mon, 21 Jul 2025 17:34:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tekusc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 17:34:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDJEvdOne0Orf3wfZUmXbt+m/aArfbokeGQCNxYcAOHeo9+ff1hdxXgzR9piZOqYW1dxNafxTIGMBZ76KbqE8FoS+k7UaMKDCJpXcRpNQYwsDEKgq6hr+GW7vDikkDDKs1qf+gF7EqFdwlXepckogPb+gyIV8dxHAKZltGVFkBbzZO+JsbETl5xfLi93ytMMVndxdW7JJcaoRVPn51qjSWg0JAufUxmnz86lQWvvK0qvDlkPTelyl9Jh5M1Mx8iEPsqsyZ2RBqMZUzsoxqXCGpNcC/e3HEJXqnsgNrO7726GPw19hb9A9jcl4YI/ndFtVkElYyjyKIpqX2tmzUPnMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7n3eXWPo2Q56GgEbQkCx1X8JPPRVnMpqU3oOl9yxewY=;
 b=TiU/qV8FHzwAA/rfunwPUhQN7NuWAP9JoJAZKaoiRiWRsbiM5ajYTYcBmxqHdU9/wB1ljTzdBL+vW3QMg8kc+qo2IJ3m59FkZBzyqVebb9cPm3Ko6nw66wt3iHZKmtSQV9JYmskS6ugzxhBMD9NdCCok2ASLhbf+GYVegdXo6DtuDRaBnnVJJjkQyEdhm1iB9GAlkqJfhbEyjnI+tHc0c9VAZBMw5FltS2Z9FGlv5E9lL4V99Rl4MbkVrWa72tqKxUpo7WSgZLChY2EV7Vr7//cggj1lrVY0JytK5S9IHeO5F5D9v0jZfoSvTGY0jw7IcnaX7yw8KJb+zBefTJsX5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7n3eXWPo2Q56GgEbQkCx1X8JPPRVnMpqU3oOl9yxewY=;
 b=Sa4BQRFJyZAFgal2B5s0QjiXKyKa0rRL9vkXb+3yZs0fOG15to4ghMwiuG79JwYszQOnU2axI/el6BJnIqT/vzn5/G+uDysptqx8E7RR/IulzSTSpTIs2nkNdiGb+Czzu6ZtxUSj0PIpAbh3W/TO3O9S0ZpWwzxNSdAMbYnnBE8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB4518.namprd10.prod.outlook.com (2603:10b6:510:38::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 17:34:11 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 17:34:11 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] tools/testing/selftests: test MREMAP_DONTUNMAP on multiple VMA move
Date: Mon, 21 Jul 2025 18:33:26 +0100
Message-ID: <d7359941981e4e44c774753b3e364d1c54928e6a.1753119043.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1753119043.git.lorenzo.stoakes@oracle.com>
References: <cover.1753119043.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0157.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::25) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB4518:EE_
X-MS-Office365-Filtering-Correlation-Id: ff54dd4d-7d6a-4c50-5750-08ddc87cce39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LAtGSE9DwIwuyjAMU+1XadFdAMJQqxfbsYvkT18lt47HxKTn5rmrHPx3+LwA?=
 =?us-ascii?Q?mI5YfUySitKRQzV7BFw9+ASgNc83CNcH8KaKsFLOJJDEgMMyOUS0Gvh4c4tm?=
 =?us-ascii?Q?Rs29cDI2DSqnHPSWIPLjS6GKZ2iLHOPqsycr66FkMmCnbqjyqNv6eR3Pz6Hn?=
 =?us-ascii?Q?XxCaL8G+ITABwfZUjuFVpYrpBUdNHB/SL9sZvvnunhN/BZZuXAuYzkcfzck0?=
 =?us-ascii?Q?OtptSkJzaTD84rt7aN/CimacYp7HMe2II4nUE1isH1zMiRfhppcoVL+n5TG+?=
 =?us-ascii?Q?97S5vGskHvs1SgAn0iWs8UYTMWHihaDcmpe9bm5DGUsIlzQi3/BpsYI5lcn6?=
 =?us-ascii?Q?hknDC9zExNdRFCb2hLMmqqDErJesyBP0oU81JuwsANjkXXZM56or3ApsYulW?=
 =?us-ascii?Q?wwVSMncrDvwWntiq7M6S1cH9MNgiUXkBbMOY9+WFv1Tc3pBwA3t9K12xklba?=
 =?us-ascii?Q?ZfbLuQl8W02De3uxqLkzb4INltzPPA927vK9apPNHe1GJOhsdOUm/Hoi0+h+?=
 =?us-ascii?Q?/l5Aj7+TPL7S0pbNnvTXWjntls4hUXPmeETVqHeT8R2v9iyT/vKxf9d4Pw4A?=
 =?us-ascii?Q?IsJUJq+KCXlLlbx8TXn8Bbx+v+GIt60ctmNk1Oy2cTHfwD2lph0aFBROVHU1?=
 =?us-ascii?Q?BtHOBrSQ1J8gK9AQGFthwlTNcc9J8Vyrb2LPAW8FocWqf1yr8Z7R5W4d5MbS?=
 =?us-ascii?Q?60PDNEYhpn9QXhyZut6OcADz3VSk5ldVyZ99eaMBLqxxRxIgjTI8zcndC7uD?=
 =?us-ascii?Q?bsNYKMksdMOsMA2gE20tjbjlXDRTZpEdgVQiDd+OHaeHW1E4Rtr7AYK7keuf?=
 =?us-ascii?Q?Z55a4pwUx6kkqmzjd1WLCGGEDrWz1HLB33Xa7jYrLignFrOtrX81Q7BmJJUM?=
 =?us-ascii?Q?Cdr5ANHLb4bEg00uptRE1KamGxBxrd0IWISkGFrM/6c/guwqEFaN+rD894n0?=
 =?us-ascii?Q?OVwS0ptByVZjJYLAW+22yEJyUZA5cpAdhzpAXuTaI+q4DMdCXlHYS6LiLCKx?=
 =?us-ascii?Q?SZYL+9Funf59sDyoYSEz/6hKg+Cur0q3u78i26wzL8S8Ja7J5Z5ZyrO6FPA3?=
 =?us-ascii?Q?kfU2GDEEzUu1+Yh/iO4O9uAaz7CznTQILIN80pYBhF9qK2qYBx/J8d83QbDV?=
 =?us-ascii?Q?QmmqQWujCwiAXAe/rX32sjqXPALM5naNwVp4Ye46B6m//pAbg0hQZ3b0sr6k?=
 =?us-ascii?Q?fmDj3Lzn+9To4tSCkNP/bRIwhaEfFnnSGoWQNCiLqcsTUc2A6XNc7ZMtT0Ga?=
 =?us-ascii?Q?GSG5uDFzfSoWJH6m7rvQT/0UFAxJNYtxX/+HGQBU7NKefCaKTgi8bRCsu6BG?=
 =?us-ascii?Q?L/fsOxYcaEHYIJjQbA1xlKKhU6TN9EJtxPwDtKJ5Hq4wnsuz2JpIM8NSBjf7?=
 =?us-ascii?Q?IPQoQUjLg5cZO0eIbYSxBOCePZTbmEUlOEUF4s/oRgVryc7njdCzV/E7vGoK?=
 =?us-ascii?Q?mS3Pn5ZguFQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CDYip2sStNAFKAecHFODNW1HDmuYbO2FwFSJbOqd6afg2VxpEJ6SjXwRWUVU?=
 =?us-ascii?Q?riEFgrYL823cLjFKL+XUqUg8kE768lczLsCeglX14M2lXohGQX7KJVFTY6BT?=
 =?us-ascii?Q?WfpKoX7ujWFNAUfsLXCP6uQBbSSSWEd1ebrEqH2IwhohFRElG7rR/qmFp8Ti?=
 =?us-ascii?Q?YGGfiGLmGovZcuZG7/UxfN8MwHscJsFjIhoMcDypSFfFuo5GAo+eebcYskBX?=
 =?us-ascii?Q?bRKa1MT99hQKj6tYEn7P4a2CtLQ6q+wbL2qsUTkwLzssZSWOdp3XPi6nq5SK?=
 =?us-ascii?Q?GZ7laYTGF7o6aqYc1HG0aOMfoIGd6TCXD02E/+w5A968oUsDptxeh5KvJmdD?=
 =?us-ascii?Q?KXHL9OoS8NXTZ1Mv6r8EhlgoazBqwSq3boZoPMR5KrWlNdRWo8XUOEUOSFFD?=
 =?us-ascii?Q?GrF30d0ma4Zx7q8MvZRNi4U5bIOfCrxZy6Pq/lErLZ9OS7b9/L2a1TqhSevM?=
 =?us-ascii?Q?ppB7Pt2nXUFhig/QLG1vn0R94F7uNA+Z251lxj3Yw4NfMVSjgUdK+Kn34SJK?=
 =?us-ascii?Q?oI4RlP5a/eD8vb2HP+DUTM4cgons9EHz5iJdgP6J/4a4FwneUhXoa7zUXKcj?=
 =?us-ascii?Q?LHClF4IYch4Uaj9Y8Ot3m/6cjog+b41QMrh+vVmTIPS/BNJ8+u0PNdrVAILN?=
 =?us-ascii?Q?+KaFWRgd3XPMOqyItuxcvABy7CORbhKGZJCN++QggvOgL+I3tlVziTzsmsEx?=
 =?us-ascii?Q?tSXMy/+QoU6glf/32Q14Vi89Eoa+fvj9OkiJu/BknZLaIDgcc80N8na3nTQC?=
 =?us-ascii?Q?lo/AkN6FQmhbvCjyvj6Oon5UOy0AJ0t2xwxRUwRCIuTchOZSkhp58TWaoLC7?=
 =?us-ascii?Q?1IuqPFLqgeGEFiwusXqQchzVUI0D+6BKuumSAe0UaTqO85kM1CikAGkF05JS?=
 =?us-ascii?Q?jtDAj5q6Hb600UaNXTYQ437YpIBax70rkM1r6T1AKsDcaejmyaMKaXG8lFSQ?=
 =?us-ascii?Q?PKUO9TuLbJj4WrnDqgXv7Sl4xpP02rfW8c5WOZKIeDUkz+kCjBuCIvUCcRM/?=
 =?us-ascii?Q?Mt2Uvd9Y4zpi6H82CTFdCaa/1KjSEUO9moP1U7KTe3clTpdtHHlrBjWkMeNL?=
 =?us-ascii?Q?g5YsgoGoo8yRrTyA/7VEWfBDwRd3JFIUHWxsJ3uu2J6rBSceQAtkwujsu9EY?=
 =?us-ascii?Q?okMWU0cgv68jEH9uzsn+kthpHg8AYpsf8J3Ngz4p/5AsRaD22QjC6RDYG9mW?=
 =?us-ascii?Q?ozUQhNEfbl9BscvVSl//Vk0oyFQhoPP3YobHnxtYAPWU9qkykdG7666r/AeL?=
 =?us-ascii?Q?Pj9kVtKdoZH2bhXWg0eTYqU8fmEB5go5EocjnYwm1zZlqV9BTosR1YSsvPAO?=
 =?us-ascii?Q?x6Twjj17qT3kBRkwsJYalxIx/hMMirnmllbdvx4aa7REJoNCgBYFmoW09zhq?=
 =?us-ascii?Q?nLO5+h2e1ttwFhsXNEpxDlP24CfZrqgF3FEaYuVvQN/jYmjftssrcy///JHd?=
 =?us-ascii?Q?f8iBXqgMeIGvKp9QSr/EEEfhbqBQOkJ+AZ72AtvCHAmJvFQuKDbw/ag9HwFJ?=
 =?us-ascii?Q?NCUS0QYSURr4eT1RyNuB4rhifzpPZThF9U0uV+CmipZ51yaW65+p10zzVupX?=
 =?us-ascii?Q?7c91kZI/nqEMDGTP6YnOrkRRr84qqFgbCGqIKMx8SGdX+ZMubDIwQZjjNedf?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7/z7AJRQoSuNWRhRXCHOr526d7Nc+RJa2vdZhDxfSqkdhCdu7rAQa236YFXbokYEvIut96OdY0WdOVvy3z+IdseTMu+x+AkigGBwdNt0iY+XPiSQenuhzLSpLmV+MCmftS7vGvvzLZc7PNfeKVfz/+mwLCSiK4ka15LpuSVO2l/Jz/lNUpiigSmZhufnbeSlc6na0pzDFkDLh6MZeaeHer+rz25iLN7ugpDWgiuqTzeQGIcJxn47MWcAIo1eDMG5zZADftZ/sF0u2lcfZ7bF0xju6nLeHDgAbyedY/9o0WTMHl6jIQgC5U4hh0ZSAbmpfQSdOlp+x3SE5lQjCqOOIEjRn/+A+8oT8dgSDHqGEeomzVQcsvyD8f0Df+tJ3GepDdwyAap8EAk1G/P798wvyqtFTQkq216iZ71GgyM05o0HK54BnUVQSsBajf3+LXv2dsMgvaFn3fNgmLaIqPPe7hIdBKEb9KvIVDZWiV+SZUqMYjnPLSRm1T5J4vHZqQMpFF+/0HEr95YsI0ZGFA4CXUMtXlBigAwdLBpoFK7IviKmQyh/D1dvRJ+p7D+NyfE0SOKkQOZSgxC/HMHObLCK8IGFTW9y2rggOYTXKOTMJgA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff54dd4d-7d6a-4c50-5750-08ddc87cce39
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 17:34:11.8446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgaxaNfH4tOTBcpDhHGhfbBC/l5VYIrYgv2jkUpx96s4H5+hsdbaeMf8s3wOo+B7LXrTN3MzfHPzIqCeTKuuH+Q3xwV3oMQ01JLrismAqo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4518
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507210155
X-Authority-Analysis: v=2.4 cv=eqbfzppX c=1 sm=1 tr=0 ts=687e7a17 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=3iKSiHUcCLKKygD1IVYA:9 cc=ntf awl=host:13600
X-Proofpoint-GUID: Z9KBzHquXy0lrpDd2iEi4PpskuHartF7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE1NSBTYWx0ZWRfX+QwlhXL5X+/3
 dkOx1zubuXwLZIONzXOoI3gST6xq5FhjR0FLWXiB3wKYGafC2K8sH+FCJW85HSz1/VmhuKRpo/g
 w3E+KQxpOHuvRHuboXnEj1IEJOFqQ/XVTifQffaNgNs5UAxFNQL6rR91Ycj+VrHZ7cEUI4Ov0a4
 mK4B9Q9CptLKJT07VABB8xz7xXAlrPqtAN62O2/EJ6wh0WoOx4eSyyOIT7aFM8zLqDSeLQsIqnb
 11JJYx+OyzRKw3AkeUlEgosualE/tkTVRgUdBddAm9oUO/bBha0M8gEisuw4uoD1uQgdp60oYyk
 hmpekdCM/Z63YSaFZh9JjD13sQ5yrJ1j5m4XAtYBr8tS9xKUCNtekFw+6ZWzlKJuWcSegiVkJHV
 4nqXeMtoTI8raxqcK2UZFTOKbWsr9d4eXAM5Kmu6SV60I5s3YDyzfh67NNw6YViRLoIYI5YQ
X-Proofpoint-ORIG-GUID: Z9KBzHquXy0lrpDd2iEi4PpskuHartF7

We support MREMAP_MAYMOVE | MREMAP_FIXED | MREMAP_DONTUNMAP for moving
multiple VMAs via mremap(), so assert that the tests pass with both
MREMAP_DONTUNMAP set and not set.

Additionally, add success = false settings when mremap() fails. This is
something that cannot realistically happen, so in no way impacted test
outcome, but it is incorrect to indicate a test pass when something has
failed.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/mremap_test.c | 29 ++++++++++++++++--------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index 141a9032414e..d3b4772cd8c9 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -406,14 +406,19 @@ static bool is_multiple_vma_range_ok(unsigned int pattern_seed,
 }
 
 static void mremap_move_multiple_vmas(unsigned int pattern_seed,
-				      unsigned long page_size)
+				      unsigned long page_size,
+				      bool dont_unmap)
 {
+	int mremap_flags = MREMAP_FIXED | MREMAP_MAYMOVE;
 	char *test_name = "mremap move multiple vmas";
 	const size_t size = 11 * page_size;
 	bool success = true;
 	char *ptr, *tgt_ptr;
 	int i;
 
+	if (dont_unmap)
+		mremap_flags |= MREMAP_DONTUNMAP;
+
 	ptr = mmap(NULL, size, PROT_READ | PROT_WRITE,
 		   MAP_PRIVATE | MAP_ANON, -1, 0);
 	if (ptr == MAP_FAILED) {
@@ -467,8 +472,7 @@ static void mremap_move_multiple_vmas(unsigned int pattern_seed,
 	}
 
 	/* First, just move the whole thing. */
-	if (mremap(ptr, size, size,
-		   MREMAP_MAYMOVE | MREMAP_FIXED, tgt_ptr) == MAP_FAILED) {
+	if (mremap(ptr, size, size, mremap_flags, tgt_ptr) == MAP_FAILED) {
 		perror("mremap");
 		success = false;
 		goto out_unmap;
@@ -480,9 +484,10 @@ static void mremap_move_multiple_vmas(unsigned int pattern_seed,
 	}
 
 	/* Move next to itself. */
-	if (mremap(tgt_ptr, size, size,
-		   MREMAP_MAYMOVE | MREMAP_FIXED, &tgt_ptr[size]) == MAP_FAILED) {
+	if (mremap(tgt_ptr, size, size, mremap_flags,
+		   &tgt_ptr[size]) == MAP_FAILED) {
 		perror("mremap");
+		success = false;
 		goto out_unmap;
 	}
 	/* Check that the move is ok. */
@@ -500,8 +505,9 @@ static void mremap_move_multiple_vmas(unsigned int pattern_seed,
 	}
 	/* Move and overwrite. */
 	if (mremap(&tgt_ptr[size], size, size,
-		   MREMAP_MAYMOVE | MREMAP_FIXED, tgt_ptr) == MAP_FAILED) {
+		   mremap_flags, tgt_ptr) == MAP_FAILED) {
 		perror("mremap");
+		success = false;
 		goto out_unmap;
 	}
 	/* Check that the move is ok. */
@@ -518,9 +524,11 @@ static void mremap_move_multiple_vmas(unsigned int pattern_seed,
 
 out:
 	if (success)
-		ksft_test_result_pass("%s\n", test_name);
+		ksft_test_result_pass("%s%s\n", test_name,
+				      dont_unmap ? " [dontunnmap]" : "");
 	else
-		ksft_test_result_fail("%s\n", test_name);
+		ksft_test_result_fail("%s%s\n", test_name,
+				      dont_unmap ? " [dontunnmap]" : "");
 }
 
 static void mremap_shrink_multiple_vmas(unsigned long page_size,
@@ -943,7 +951,7 @@ int main(int argc, char **argv)
 	char *rand_addr;
 	size_t rand_size;
 	int num_expand_tests = 2;
-	int num_misc_tests = 5;
+	int num_misc_tests = 6;
 	struct test test_cases[MAX_TEST] = {};
 	struct test perf_test_cases[MAX_PERF_TEST];
 	int page_size;
@@ -1070,9 +1078,10 @@ int main(int argc, char **argv)
 
 	mremap_move_within_range(pattern_seed, rand_addr);
 	mremap_move_1mb_from_start(pattern_seed, rand_addr);
-	mremap_move_multiple_vmas(pattern_seed, page_size);
 	mremap_shrink_multiple_vmas(page_size, /* inplace= */true);
 	mremap_shrink_multiple_vmas(page_size, /* inplace= */false);
+	mremap_move_multiple_vmas(pattern_seed, page_size, /* dontunmap= */ false);
+	mremap_move_multiple_vmas(pattern_seed, page_size, /* dontunmap= */ true);
 
 	if (run_perf_tests) {
 		ksft_print_msg("\n%s\n",
-- 
2.50.1


