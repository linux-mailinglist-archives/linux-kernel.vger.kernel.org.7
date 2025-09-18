Return-Path: <linux-kernel+bounces-771371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F597B28630
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 632B7602CF0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19C32288D5;
	Fri, 15 Aug 2025 19:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tybk93LC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MXYSioqo"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3E03AC22
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 19:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285092; cv=fail; b=DOXJZ9Xh/ekq7VRCEFlToCJQkwP8II+XBX7ox6S01/i6+VHO6RMpM010BUvlQkcxkMWasikRORIV/wRuDGrLXS/1idjDh8xkLktOCaCKSdvTZPalwUoMxt9VoMflrrMIhJWf0XFtd5itSZOYVmxftchkTm6Nfku7mhxCbRQb9+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285092; c=relaxed/simple;
	bh=dK6coIh/LmpPdgb/LBeirSOKXVxwloElECwmT2sGxOc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KsN0UP4cAgRESPp9Sp8xS5uU/Ac3QftpzV3QD3SQXXvu7jZL3422mpE3LzNIJBETmz14DjasleXgmXHDnDD0HjjJR3xbeuNb6EQnYSR17r7ybLN/lRwi3MWAfe1CqeQxso71du+hGak+opdDnRoQvxKW6rG/w0HH3XklRxYGIyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tybk93LC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MXYSioqo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FHk90j025361;
	Fri, 15 Aug 2025 19:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=Y+dvevIqo9mrwSCr
	UipG7wwQo/UHACBpMrYUOu3gSZM=; b=Tybk93LChjpnn3m2iu+kbFX0Uac0twEJ
	bNOp4bCNNMrgmelXIUS1JX+Z3gwVg9x0xi6nTD87OZN13B+OxQYZy0fTx7nwAHR+
	BPhZtpFbuyVVkV+p8YpHodV4UZtwGJy6vQQlrW+NVO0EYIx64wrCJwKizWHfA1YA
	vhkEI0kZUG9o9yXadULIrv9Ue7mH7DV2Zdo0ZpazsSWU6FwET+PSp2ptYE3XORZO
	utPEDbcHHYq5UH+pE/wrbNHdEAxJ5OAVD68W40+Ycwsc9IJjCkA4E5pJ+F6mc92P
	c8U8iOqDow2NB1RDaxTpTJvWOhnAxigJE+WPyXW0Q1rvqRazbUcbxA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw454hmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 19:10:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57FHThJs009928;
	Fri, 15 Aug 2025 19:10:40 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsmnb3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 19:10:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYsTBmtWxVbUtblbbV0JdHlMohl9mwaoA6vbYkJ75CIDvGy3WVoNbJ9d9cJE9ALq/DBhHjXCJ4Fa4Un9Y2nYrFRWBVs3wYYohg+UkTvIltMUaXeRuHaI6OBakUsPPPkES9EV3zQLUC7feLVdjlq3tojlRboTrqAlaveaa2trQfn+Nej0iyb19DW2+2N8CMH9P1zf7H3oz3DG/8V5WaARAB/5Cok69lAEcweoWjt+Z/7sglDGTRShsZHLX6QdujpguCrzQFjKQHYrT9myi6H2fIvdm2pRIwHdG11ARkn39gGEF0nHk1B9SvV5CqwHyIh5W6qwrdaw/Q+dkhB/JZdXTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+dvevIqo9mrwSCrUipG7wwQo/UHACBpMrYUOu3gSZM=;
 b=iYGX1kl+wnq2pugomcA1wg67/deL94/9kS4wX04s4r2LyyanIB3OsmA1Dym59857S17LWcqDu7zDgzhaFOVbCOXmoHgsICafR7IU7s6/Jsyf+sx1CtpB8JGUMuxUTm8L13zp+gIqLXiZJZbEc2yIg6mmulvMI65t4XcS/cejjS5IofS+UYDsrF4DsZJzVVzcZ5FYVLxYDJ0ytpZBdxFgV0S65gTaxegeFGZcv3ayDuzxVWZKYceycy7BpFBSi+sB8zhOPrwWQ/Hhy3/TF7kPy9hpl9QEcjyV+LRIxiADKjf6mfzVDghWs9h+o8kAKOkqGr1EwxqU0ehAumL6y03TjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+dvevIqo9mrwSCrUipG7wwQo/UHACBpMrYUOu3gSZM=;
 b=MXYSioqo6GAF37bMgfFBGw5juWtXBnNhdPpzaShujtbdNY8Q7+LP5hTHuZ0C4x1EE+vehhULfNsX3RQG21B3WGAEKpREQz8ffenZdxTLDfdtPg4dtdDiyfza2nsHA/aYpBmqGf/cJpsMD1/V2EJpjg0Q9s225xgZzcG619CW8vI=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by MW4PR10MB6464.namprd10.prod.outlook.com (2603:10b6:303:222::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Fri, 15 Aug
 2025 19:10:36 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 19:10:36 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
        bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [RFC PATCH 0/6] Remove XA_ZERO from error recovery of
Date: Fri, 15 Aug 2025 15:10:25 -0400
Message-ID: <20250815191031.3769540-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::39) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|MW4PR10MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c255ad2-8b21-4945-6317-08dddc2f6a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lmu50FFdVqX5vNGG535o5HjwG5Eq6RjEeqcaKvpTCIkIbwS+Bw8j/bVLbOPs?=
 =?us-ascii?Q?sCBEMWoCuuJ2xGhBe+6tL8pIEXIUNgSt+kKvJr/uEhfU3A5+i80E+HRuhIKm?=
 =?us-ascii?Q?h32iRYTdmwLSjdGrJBV7dU+8Fiy1Gct5DjZCc48mb8yZqFTIGAYEVMWwXBBH?=
 =?us-ascii?Q?Q3omxuLbgmlCQkD3b0h+mX8pQcdwclnTbqrelh4rfQvnuTXiviAhHfWY0Xt2?=
 =?us-ascii?Q?odoXTl3YnWofwIWrdad7Bon/zebBNJGf0WuI31ap99X7gGpHBACRXcRe+s6K?=
 =?us-ascii?Q?l7NLxQTUT9UE4YIWC65GFFxlYDbVj71gNQK5bPTg4Ediy7Nry0iE22IzmQ+b?=
 =?us-ascii?Q?6yNoKPKCjM7X0LS2LFemRqASc1epvGds6frEqrj3hFw8Fzf22NJuc3Qe/LjU?=
 =?us-ascii?Q?oH75atbTKHfKsc0Zp30nZMd9Pf3XGM+B4WmuI0cO+y/phH908S3H9TLpyvKS?=
 =?us-ascii?Q?WJ3oy9JnapLxgvgQveoAlC4XcLqh0kdFtmotTEToFnn8J9Jm0NSW1OxTavG0?=
 =?us-ascii?Q?GVW6d9uGirw5dsX5O6SVadv6HHP+RbeZhfrNSOR/+ldX4G8RJ1tl88+peSP8?=
 =?us-ascii?Q?YscxbRzsjG22C+YIOpRNzPbtjCGuJRKcgm0tuDl1V5Un0xhTN0zbF4Ba0ypN?=
 =?us-ascii?Q?LrW4+WxIsFIlHqEn4A0h2h6xv89O9qCojnUcHY0zWDXKoXMSfhsmcj2NzZJl?=
 =?us-ascii?Q?AnnwWzVzmLzZPsyN8oiOt+h7PIXoAO+x6cs8mwln4aNAXrMhYkWpTA3WMNT4?=
 =?us-ascii?Q?lEPuwHFjmHjfRPKfkVxjD/9se4C0xTEBDKIJySpd6fZQBhvcoxg2uBsXZqBV?=
 =?us-ascii?Q?/qiUxdI5lna4zy+MjulUSZZC5UB20IMGQysayaV8bFkpO0M5oo3fLhQI2FkW?=
 =?us-ascii?Q?FX/wwFovxyJ/xdtVijesGz0E+NbkAqN3UkmXMpYhafG43jMZM12snzNHAoNT?=
 =?us-ascii?Q?ayMPBjTyQwCS7/+C1Xe9bqx63xvsc9TWqs4J0iS9UFLeMvGq+GvE0lXHFVyF?=
 =?us-ascii?Q?mu79n971FExhPV6yfRnSgv19f6p7ag//A3I5IBkURXqSaNpqw5OK33U6CytF?=
 =?us-ascii?Q?GTehFSzJgQGv2g/7oStajnW9lZw6cKaMP+/HaDde8Y1TszmC2nEm1tdK+OrZ?=
 =?us-ascii?Q?Aj7EoEdtic+kCrXJy91Ew+Kml/Tfd2XQU7BHxa6nfTJdQU+Nyex8vvs+i93t?=
 =?us-ascii?Q?3MFQmPbo4Pd+rfkgVV6Z9LGVRTSmzSFoD4s57QE/xH3yVyEoRRaTiL256z8o?=
 =?us-ascii?Q?ShxAZwZpvOACaMjeUa2coTiHZ8loNOlr0qsoH9PLvPiecsbTR3YjR37v7LUL?=
 =?us-ascii?Q?Cv49TWHEjoug5OEPgrVAtWtRz7Dnp+Jd6bDZ87dfq4bD0tN+/tiPSUI+3XYT?=
 =?us-ascii?Q?5PhfvE4C9j6GC3K/ZsKRFTtUPkfFhjHHoxhjop6FiNquzyfB4W+uPmGIFwwl?=
 =?us-ascii?Q?o7RaH6+twsE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LBlJWRvfDHlEteYd0+A8H+FE4g4D/4Wlmya1sXcPzCtRcK6sGlcvLTDaq1r8?=
 =?us-ascii?Q?HJkjVEUi1+MIh5VN7Wr0dz+f4ZC++esAVTvmosijLszX/2qohcS4M879yGDY?=
 =?us-ascii?Q?7WbNO22dHBElOry3x5Y1lU3+MdDNiV3cNTIQjAnMjH9vxzZBWhI4GGDOsdlZ?=
 =?us-ascii?Q?iaAjqq69CuzgGA6HS2r7sxORNr3FyqMcFUoUV60ZcW+zlAmAiKrUmhox0LaK?=
 =?us-ascii?Q?7+v48yMQjQmb1xqDBgeTFMItPsC0rrf/TRtYum9/2k/jhuSTFx2PdoPzq1RK?=
 =?us-ascii?Q?yi3EV4e18FHK8IEBwR/UV8RJDvTs7Y09TR2W17TfAoEPVjssa6cTXOS64FoA?=
 =?us-ascii?Q?kr+iseQRHJAkltwKnnuQpmKA3szAf14zFHL5zLaV09pap2mEt/41flx3+tDX?=
 =?us-ascii?Q?lsZLqsVbpTQMfKmA14GESrZgRh53HZP8iZksvvV2zL1BMIZ6xo3kqR+FU8YJ?=
 =?us-ascii?Q?XG9XGkoTxPkrZNLiESebQcgJDMhxh9nk9rdQ4m3Pw2KDXREMISstN1qTc0sQ?=
 =?us-ascii?Q?j1ZBhVZeBSYUJj86Hfh1DUB78VM2V92Mwsq9uHDWai3oqBtYcP82tzp+S1iz?=
 =?us-ascii?Q?hz6FwBmYfqLofjzYhdv6v6m0fiVTWQnr+W1gsdVKjekX3Ww192TO1PQ+jsiv?=
 =?us-ascii?Q?Y/Y82Q3nfSXc+03skdo0HjSQFtfusuEdPD/BGTJiM+uuhBrcSoy8fVwgRbpz?=
 =?us-ascii?Q?bo9EMA3eXD6sefCOuvDhszA8WikDls3mgKx68PHao0Pz7HnolsE9ckHZ6XBR?=
 =?us-ascii?Q?NqDp6e74hRwWE7XuhyLp5s72NDgRewWuMAnMPirEvmNBMD77hifXYLXIjZeI?=
 =?us-ascii?Q?aaIjdPi6oNcQsUNxakkf2r64glilX6ZuK+u3MslkcabPHVpp0ZNprlyS2Poe?=
 =?us-ascii?Q?QSMtQ1rVfcgmi8lYQ4Dyuj9Ib38pRzfhJpg1Fi8NPybfrKbrbqn4s+l9FNWl?=
 =?us-ascii?Q?89k4+K4hKcUtQIVO4Iw3BIKk5mcaKfuI5x0Kt0XilfVmnzQxw2WJJKZ3VwN9?=
 =?us-ascii?Q?Iuqc5pEGUbHupKnPKc+hj229FIVjFPD2PrEzPqdaorALrcIv99fr58LhVng2?=
 =?us-ascii?Q?1efGWbwn2296dW8Ob3y15gapzcF+SI/CPiRTx7ONhbQJ7BlmDwOIyCiVLFNi?=
 =?us-ascii?Q?wchJ0H/u5NUewvlLeZwgp51CpWETN3VHrGkcSvJCalLOJOsj8KZhNI0qpap+?=
 =?us-ascii?Q?oDeppWwjsHsgbQHtSxwKXEXjp1+ymJCGcF0OO7TjyDjsHSzNy0ZxQIAfXFyi?=
 =?us-ascii?Q?dXUl6JeQpq2OkUL1CyUTZ3SPShd76KinLPtI5/FM1S/4+fvW2IAA16+ZPIRI?=
 =?us-ascii?Q?T+yp2JmqvAkykq4HNXSddYW5xqnu+BZAqZS4yrcpGJ0Ip1joEW8pJ2MXmYTW?=
 =?us-ascii?Q?K9TcEHXxOsz/Tz0fuOfcpjhdaLzdIvIPfFZDSyXLDwd81um2+FetoQwUjaph?=
 =?us-ascii?Q?zILyXEZJ5rb+qpLF0QNO2sUEwFVR6zzAPibvhqEdthJRaQ6YUBOQ3Zd+HdSo?=
 =?us-ascii?Q?46nmAYZwZblnzCV7MKGmqYmY4rt3wnlR5jxddZmo58hFH8CK1x/D+waKRbxk?=
 =?us-ascii?Q?LQpcplFKH0dozs6BRlvZlSyk6U4nfIIZUhAbla2R?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ylm/dNbH5dWUcrxv/ZvmiTBLBTDxx5S0yoQ2bMKLQuw982Si8MZZ4We4Z2Quxd95TE417Z5fg6qs5aC+uTW3t1lrYL76oArbrBWAIH8dR4OaF6EGLiOWO9wtfp8BJWXu/F/n3UOXn6e0r3nPHqAwrWn0mDmxn/d9BiewLFpbxxMdzKZYXHPd9nrX56ZK+wOx9CX9FTS8/GwJFhhxTqnC90+uEgAQTSezhvgZOak111v4eHufsTaDC5IJ17Y3QHbkIPPpodqbPv+kRvn5MxEGYaqTEn28zSqd2qjl2Kx2Twl1mOUSlNtjj83rfMSka1apV2FYAsP/joQTr5pIYEgWBYGZTdKZ0QyWjDfM3vgC+bjGUL9o0ZrG5BTuVv3IAe/BQ7HlPrieYPYVLprpv7FhpyaJj7FJyeVFLOHjoD5+nHlotbe6CgjqW0IqYHXbH0COlbfxGjSlmde0edRyurnpqdMDGOkDp5SZ/fR0r9weGki9reQeywGlvee0I2jsJ8JxWQWgDbHA6b0vtFrICtMgbdgFcrNt6y2RD6BfvAJKIWM2GBWXhMDu7WpY5W1Vln74jw3JBBylQL7WQFWRmd+Pnm0wuSRNzU+dsahVv8woC0Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c255ad2-8b21-4945-6317-08dddc2f6a92
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 19:10:36.7206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLpIlhLDzETi9kn/p6OutBwAYdLFo2RqY3GR81J+TdtZlqqR0NuvKo8sGS6nYGdTxlwjWX29vgs8OFE3lukQVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6464
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_06,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508150162
X-Proofpoint-ORIG-GUID: nI0B05KHw2RI0L1oW5UU9kqCAkMP5sd5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE1MDE2MiBTYWx0ZWRfX0haBxdhyc6rp
 k1qbpQ5jywmz6uRQx8CnmLBLEjlmAr2P6VIY+Kn4+2Zxu1+vIc9oGuzQgd4spsar0vHcAYkmOq1
 lr/K1nznnV+aIFoYvEfmLuWx7gdfpOa0+1i4IssoTrXwq/NabKpsitGEdSRbsvbrhfsEMKICAVy
 s7dXKRrCZlTefurfoW+daUp96xeJEv+A1cXsZhiVWGMvkJzceUil/bWjFY+uWy05ucX4u9wkGiY
 84d/mIg1lE9vd7m+Ih9cBCNm6ujR1stcvmKnzR04VpNB6xqo6DMrzd8a+uK/ifaAg8/nMHadDcq
 D7A57Xe+MmztIhm/5Gr+ZKt/e6IYl/zrtmP7MWI68UHKKXT24O4gu8K1p9D7EDuHA53IeShweGA
 g3lRsfffQQAvNt/iRDkOST8B2Q/R99tCjwUCtBi2FqYMwqF0L26zVqpYpV/ggMY5J02YB3an
X-Authority-Analysis: v=2.4 cv=X9FSKHTe c=1 sm=1 tr=0 ts=689f8631 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=1Cp9xoOITP4FoG_vIv4A:9
 cc=ntf awl=host:12069
X-Proofpoint-GUID: nI0B05KHw2RI0L1oW5UU9kqCAkMP5sd5

Before you read on, please take a moment to acknowledge that David
Hildenbrand asked for this, so I'm blaming mostly him :)

It is possible that the dup_mmap() call fails on allocating or setting
up a vma after the maple tree of the oldmm is copied.  Today, that
failure point is marked by inserting an XA_ZERO entry over the failure
point so that the exact location does not need to be communicated
through to exit_mmap().

However, a race exists in the tear down process because the dup_mmap()
drops the mmap lock before exit_mmap() can remove the partially set up
vma tree.  This means that other tasks may get to the mm tree and find
the invalid vma pointer (since it's an XA_ZERO entry), even though the
mm is marked as MMF_OOM_SKIP and MMF_UNSTABLE.

To remove the race fully, the tree must be cleaned up before dropping
the lock.  This is accomplished by extracting the vma cleanup in
exit_mmap() and changing the required functions to pass through the vma
search limit.

This does run the risk of increasing the possibility of finding no vmas
(which is already possible!) in code this isn't careful.

The passing of so many limits and variables was such a mess when the
dup_mmap() was introduced that it was avoided in favour of the XA_ZERO
entry marker, but since the swap case was the second time we've hit
cases of walking an almost-dead mm, here's the alternative to checking
MMF_UNSTABLE before wandering into other mm structs.

[1].  https://lore.kernel.org/all/2e8df53b-d953-43fb-9c69-7d7d60e95c9a@redhat.com/

Liam R. Howlett (6):
  mm/mmap: Move exit_mmap() trace point
  mm/mmap: Abstract vma clean up from exit_mmap()
  mm/vma: Add limits to unmap_region() for vmas
  mm/memory: Add tree limit to free_pgtables()
  mm/vma: Add page table limit to unmap_region()
  mm: Change dup_mmap() recovery

 mm/internal.h |  4 ++-
 mm/memory.c   | 13 ++++-----
 mm/mmap.c     | 80 ++++++++++++++++++++++++++++++++++-----------------
 mm/vma.c      | 10 +++++--
 mm/vma.h      |  1 +
 5 files changed, 70 insertions(+), 38 deletions(-)

-- 
2.47.2


