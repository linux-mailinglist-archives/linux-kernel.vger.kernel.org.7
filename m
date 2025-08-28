Return-Path: <linux-kernel+bounces-790290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6CFB3A46E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 17:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAFBF7A9D52
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9509722D4F1;
	Thu, 28 Aug 2025 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R5TlYBcX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z+oR12Y/"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192D630CDB5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756395000; cv=fail; b=VHqqUwsDQcAiD3LUzT5mvngH59HOLCykG5fIsral//yW5LXHtgBrflC+yf5nCnt2l5l9iElbtvBo3z0thfvJrh3yFQORAGiZKQDwV6SrrAR3LG+wGDXggwL+UeHWvcozdllXZP7jEAP1EJOT753+2EHoXmoLKRQtorf3MntJjqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756395000; c=relaxed/simple;
	bh=MMtosIJplPiwZVmWjXxga0NiLESuzwuHy6DtOUfwhWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DBydYl1zx3+njlmWPgx1REjpwmR9Ci17uuYjc3leAngpE5qPXMsN36vCjsLBwN/NWHpWB0lDvPpG4+H0aiCSoDjhtIxjxdjyJcuJYm1ELmvD+I776TY3NIWUyWkzIHnugzEKetK8PQi0nt0ER/5yNxrpXkEKLvC+JK/GG7E9GAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R5TlYBcX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z+oR12Y/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SEOKW2007781;
	Thu, 28 Aug 2025 15:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=5sk4UahbM8hsM4/kyk
	biIXcdzBAneNAH9/sqeZ/Zd+U=; b=R5TlYBcXFVry0hZDZ9ZLFFU97BeXO/VuAs
	4+iqEG/jfng//I8JzMAge9tZF9jaCkvqHSsM4M0//LyOpY03nCYeYs3G6CL8cNBz
	3M6rDw221T7Kwf2MJt3YndlxHBTxFT9dQTGWMOFgvscoXREWvsBOtGQmILcsTpUH
	7qjk170Pa2jfaBXngAgxbcpMIu29/xmi9RwVGkhSF/+YX85ZVNqTki8BEK4uZTyO
	rDpuEdVt2bfCce9/weZnCXeCaHo9Gmdz19m2vz+YPbmlaID3fMW+S6JaAAmmJv8v
	3xcMU/hhKAWTAm+OV5nwhB+nlIAqJmlcRRw8rshtMSacPc3ZSvLA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q58s8s6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 15:29:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57SDttQd004965;
	Thu, 28 Aug 2025 15:29:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43c5e38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 15:29:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpxeO4+cy5nniJkyVQNxUOzg8ScCkZSscKTVHbqa0lpmhEvudEroMbTH4A7VPEC1IjBaL6CEuZuNZag46/KDymyakgbNgCPaFDMF4EYZ5RsxQJNSVPcFORCa4HtglIueP00J//Mia+UdhKbWg2GfCpe+LQnOxFJdfyMlYXaDC3f9g+HH2y+vokg2wT7FhQMnsjEXfC8HBsKUXG6KPjlqXgc6oNFSdGi2o0wSpxDJNS3YRXMDFITkRSOavajmg5X65g3Xu2nC1fjgAkX1dBTT8cK+ZJ9yAko76WXvBpMNGG27JbtSCWt6ZcsVo7HBHMxCu4V/S9CWXnTBp7Z6uTQEMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sk4UahbM8hsM4/kykbiIXcdzBAneNAH9/sqeZ/Zd+U=;
 b=hAiVxSNGaLW3uBdkZRpwbUIt9OugAfNlslHPSXdC62C8x5G6fMnSzMkIm6lvjUB1GEKNc0CCU1LVMUkT1xGZS6QXaHj4axm9How7MxSqmUKuLx84DjcgoK6UY1bWqfbfC8TlelJaFn10MTn6BtuAdwx/eT+m0fFzBiUuEcyYMDbVWLlGzDiiP9CqyCfIjEhRCpJxryObNx0LqJHOUHuViIPuTzVZ2yPmEK+owILKJctgUK9w44DJX1y721d+t1IIVAwuspXRI2seHEuWfZYoKxapSo89ORb1eMyTV78juHBD/52gURA44bONzzxxde5MCKpBYFCoLW7hGDFQn6GiYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sk4UahbM8hsM4/kykbiIXcdzBAneNAH9/sqeZ/Zd+U=;
 b=Z+oR12Y/ztesx5P0Pl+5h+axD8OGDlAtBpMEXzT33p5SGEpDiltr5TuGfZKAbApb2sDocWybUYGUs8iNlV8pP17TO/3WCT5Ofj8QCNFdKW7A7LNAGmGsXGeUz3DarNEH+sK0YD14/X1iB7F94WGHoh1tsQtQQhQcj4ol6fVZlZ0=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by IA1PR10MB6855.namprd10.prod.outlook.com (2603:10b6:208:424::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 15:29:41 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 15:29:41 +0000
Date: Thu, 28 Aug 2025 11:29:38 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] maple_tree: Fix testing for 32 bit builds
Message-ID: <vsd57szi5ymhqe2d3ydjgq66oqsrh2u4ep6rlwysm4xjunfa4j@cadtq3ai4lqe>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250828003023.418966-1-Liam.Howlett@oracle.com>
 <20250828003023.418966-2-Liam.Howlett@oracle.com>
 <b69c03f8-9de1-44a8-9e21-322b0816be37@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b69c03f8-9de1-44a8-9e21-322b0816be37@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0335.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::26) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|IA1PR10MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: b1036a11-9bb5-4991-f072-08dde647b4cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?227nDmXZdYoEzlBzf0aCkJ6HIJMJbbX6yxKX1XuT5Bb0FHokcF0u4kMIHGHk?=
 =?us-ascii?Q?cz4E5IMjvlbooHT9HMvLYk2eNVHVb2QNQn+Tt8NnMo92xBlB/GjY/f7H1yJR?=
 =?us-ascii?Q?Esy0l2Y5rjibBZt1wgUNURymm/w0QWMxQSdFVCqNXhyauxF5iD5/04W2v8aT?=
 =?us-ascii?Q?y39uz2xueX6RKxDM4ktikftlJhNG9qscOJ8g+xOBUw38VVJLos+NvYhvI4/j?=
 =?us-ascii?Q?ffqqn7J+vtwnzFcA42GYW4j5qUiOCHp7sW1hsWh2Pm/82unNZ4ma/JzBiFiC?=
 =?us-ascii?Q?2uU/B0IPV/D5qevbnI1wO9ZmYUxhTD14KcxmKO1BUkq3F3w+Zv1pk5oyIrzw?=
 =?us-ascii?Q?PiH9AFpYPTeON4IR7N+0+64T3jax+n43NlqdPBDws86qYuOUubHoOxCzRTwK?=
 =?us-ascii?Q?e9+ozgBPh/5pd3NrmmkzNjYj7wHHgrjAxEU0UgllOUD/MFtkKZqe7+corYI3?=
 =?us-ascii?Q?Uya7CE5wzHROpBUguQ0EbBUB5+ysMQWgVO8lg35gA9mAECMZzVs0wvrK0kjy?=
 =?us-ascii?Q?v/pnainbRaa7f0TC3mUjSPYQnqm1nJikOug2D+n1s0bJC0RYJezhahEfrVJS?=
 =?us-ascii?Q?1qT17Szb/tprLhn4GanVksbQmfWdj7bPTaBQ+qH/xZvEoN3d5c/zJMstC9zp?=
 =?us-ascii?Q?ofJ7ZyJtPrLFxSyTZURS7IIb8ky1R5Iy4k6Jh8lUwS13kJMIfgf+vNCYQm9z?=
 =?us-ascii?Q?WRp0O5/FmMM9kTwgEUlfAhkFNWP4ryKuVX4wtSJA+21/qyIzMg8jI2kMwFBf?=
 =?us-ascii?Q?wDog/ASkU7uRiezpiLFR+o0bvR+7A2StOMNkLFWplPgGlpgY8vipr6FHsE9B?=
 =?us-ascii?Q?vF8YNlUb5x41HQlXUmsq59iaJBQ5MA/SBxOgN3F8Pl+UvuJmhSjVA6B3bepH?=
 =?us-ascii?Q?bDNa0a762XQYocSCBgk+eVEMKnIy4/YjuB5NeO3aoPKGtyownB3ERzzyFZH6?=
 =?us-ascii?Q?n71T/JjwfMQ2IFgCDiaENfj/ntlWIuempIZYrZK7fgEPtC8D9zHmgYKMG3VT?=
 =?us-ascii?Q?T5HoAvC34OeTjFGIJtcMWanUv/cDnv//Z8twcHL5jkcfYUa3DMe7YQgB5vtc?=
 =?us-ascii?Q?uTk6zmqaY6YzMNsCozUJCAbEbcJr9dSrh7AgiJP8II5BRO2LttgUDsbfJyRW?=
 =?us-ascii?Q?JhFhnTIxHUpPu0YKA6sSppLqjT/tqTN5Cp9qnwcgxSh63x6ad+6/sY5+47F2?=
 =?us-ascii?Q?vJ471g+eplx2gCJYdPH0ZWZo7FGoGT5QUprPbu45m8yR/uSSgvzj615MnCJg?=
 =?us-ascii?Q?g/fxLEvsNZ+RSfpIjKsEdd/Ixi2JZCtZq0BsG/RSMsdz383UPl+GXGl9wjI5?=
 =?us-ascii?Q?wUA4WFuM5xad1hjs1LtTJxcqqSj3kD3AE9kCNex4mOuTdS9kxqjqM1fRfYPj?=
 =?us-ascii?Q?dWiN3vI9isBZLT3NEslvGm/cvEWQl9/supkCWJT/4jt2lZ9K+iBAh/NuDybF?=
 =?us-ascii?Q?0Ccw0hdcDlg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l813hjdB6T4/jzjf4goS20IXzQ/Xmf9eIqR/w1ZY0FcZeNm4upBmfQ3CSNp8?=
 =?us-ascii?Q?Z6yhOKa6JXAL99AUt5+WYOg2YeYmz22w35A6p6p0Hn8LNniFGDHRQM/l8gZx?=
 =?us-ascii?Q?c6CD5fBXfCIKghwF5fB08v5/Y+WMObHlZSTZvpkLRaDjoZ+SuPIeUfIqcj1q?=
 =?us-ascii?Q?dDyL2NMxyvARuFZG2ZluBmU+L5go3X0rqo3VqS41tenndisAyLJ4lCyX8s2e?=
 =?us-ascii?Q?G2uUHrIhxqRKiXibRLBDc1AhL4U2DLV9gx4hK9K1nxB/DhreeWCzBS1sGOe7?=
 =?us-ascii?Q?OdWSW6BPKgAEgPzKlZ7OJ9CEcxnEOLWbibv7EBePJG8Ko9FpWofZ3Z9mZViq?=
 =?us-ascii?Q?7CN4G7MFXIUMwEOPsDslDy/5k6bnow+LW2seJ7GNJg/3743/ksF6AbppSATL?=
 =?us-ascii?Q?UMlOLPzm1uSpXwTYjs838JMjqatLFPjwLPSGqeoo9vIT6urangUW3cywVB0n?=
 =?us-ascii?Q?H+kUuzSQxnll/89ui4vO2Z8mgVL5pES554Ro7lxZHWvvRkHfqntTiKJuU1O9?=
 =?us-ascii?Q?zWd/7PP+yg7TyzJoPxajRqxwy3qPCtKiAqlrNqCFqUvbrKW0QY/7YvhW5TML?=
 =?us-ascii?Q?hpdwWtN4jpjOSvw50TNJr3403iy4U2vWdEVCldDujJ+GltC9lwkKyFCjjtLs?=
 =?us-ascii?Q?RUKePTrTNOGFwgxXevpQFvo1QcNXkqcvz/JIvkDprFIgXwzaABmriE5Vzf8P?=
 =?us-ascii?Q?35NaUiJt1Rnqh5mvYv7LUn+Ktl7ftcJTNhKxYUViJSzv5LsAV7JxFLXdT1Uz?=
 =?us-ascii?Q?Qto6lkdg3UVsIVUqsU0UtURjvzTs/22a88x5eGvJeWT9ZzjJXqQ/L56lzyJ5?=
 =?us-ascii?Q?oeM7DoHqncV04ZZf6hte+hTPbglSghOihgLwNWwXr2Yp2QLUlbU9VEKqc3B4?=
 =?us-ascii?Q?RRG8qyGwg3VFAB3DNa3ePuWwsTokv1g//LpsVbaIGAsoJ2xTnxsFDJdssnZT?=
 =?us-ascii?Q?HBL6JOr+jpuMCT76o6EhZsWanKT9O4MDbuhU7s0qL6QiUJrrO6E77Kr3JrTp?=
 =?us-ascii?Q?bSev/alIv0a7FE9Sii0mEcfXZz9vivODnSJvDKcm63mHnOUQrfMExo/iqEcQ?=
 =?us-ascii?Q?atEfXMWs1ZK1z96OQ0wnZdaT7mFe+vDMywLuRx9uPKZRseG291qqhx6QJTm6?=
 =?us-ascii?Q?dqQvCqOF1GyR21OxVRCF/Qome2TR3Cy2z4kFNwIuTpKW5T9jkOdFlHTFqbBk?=
 =?us-ascii?Q?KhDFdJdKdPq4MZ/1pgHT2bf3z/v948NN5AJZ00h+aFVXo6g9DJBfd+hZcYS6?=
 =?us-ascii?Q?WJoEaIVyGSRoES1UVOXMSQ948z4nPPb+WzQzhcuqYTKc7m2lizT/sCwm/nh4?=
 =?us-ascii?Q?WP3Wytl0dpNqZR1DnYaRaBARU5/fTgjAATb2xSIqPy9bn/qB8MosjJA3Cu8k?=
 =?us-ascii?Q?9aW0UbX47LdI3WAf1j08uW9/dbBu+i8xkKD8fc2fEi1TIUN90gXg+qyPmaQE?=
 =?us-ascii?Q?CLFptDu0NkrG4WWa3Bzc/+Ca4X97F1piRdanNrIHKOZnIt3fx+jYDMj+vQaD?=
 =?us-ascii?Q?71G98545KcSVNzu20ME3RPuISZn2Ez54wp4kQsuKIdY3koSCEZsgPwnGWjEt?=
 =?us-ascii?Q?yxo5rMYxravwoSFr9sefB17ZVHf0unDg2hsfzyHzvYtPZJqq75DKFbUgIr6g?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Wo87jd4vpnBFt4fPuGGnfeLPNVzBnWjYNbf1JsrQUBebuEVHfTGOodr48o6+QEVDj0IVNvdMeEEQ3Uwt0HEsoN5gkl/nsiFE/SdefrejvikUUldT84sX+8zXClaYJMepu0YaxZcM7H0s4Ps5AlkIu73VWi7q5gfkxIGe2YJ4ZHRrIO853MSqW7Y76sTV/JbCPns4CEDPrsbRUyrInvgOm0VwJnfhrCZk4p8JY16odHpTGMeIUOpUWklAIJgdLkMaIT+4wZYI+On5qg3KvkGqTwnmGgYr1fhp8MH29Y5Desp9cI/+/ovu+MBnkf9nabVpcGw2J+1boz0XM8B7+AZtTTQO/oK8YRienA9lgikpnkYENBUFs7kBaZgMVYa4ZTW2AaUdQz/pkm1tlVe5lMZVM/bPStVtDwEHfE9ERaesOs2qZikK44m3b9aezu/XL4pLV62uVDGdmIXm/RjeoQ8TeFrlYs3qgmlGr/1YYvwt6yyfpwOu//BGSShHJW+sGOg//IZJiSC4rX5mxYNwlVAyCnwGCUHEu9/KzICHCGckTaf7QOxMfRloTZo47YVyNz3Zq4l/bk/cPlxkjCrNXmlRyWW5zmDJv4jvs6lhAGHr7Qo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1036a11-9bb5-4991-f072-08dde647b4cd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 15:29:41.0768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7DzOFqHCzMucxOx+HE21R1ps2HCzi7UGDAvezoxqAFxBzyCCx3qfomHU6LZw6C6pbf0loPIoq1AuvnbTwqTDuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6855
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508280129
X-Authority-Analysis: v=2.4 cv=J6mq7BnS c=1 sm=1 tr=0 ts=68b075ee b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=6z2QIQZS_8HQ1aAFQv0A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: KDPUWtnvgV8vaQwDYtvKY3IFzOarNzit
X-Proofpoint-ORIG-GUID: KDPUWtnvgV8vaQwDYtvKY3IFzOarNzit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyNyBTYWx0ZWRfXyRbgmkutjrqY
 Dbr31HJxIYyLrqdyrZrsgdQ6gd+rafji9n1tXqdpwCSz6AIkjewWfafYM+mw52PXGeF6Huvw1Sp
 8ggSWlX+yEIfB987LTpgm8SpkKz3kLQFD6Z6d86MpCuTF8Q3qYLY06wmrcNtt4EIxHx5clnyD4W
 zJVt1nQZy+TFqLhC6R5BFt8vWRUeEA6sgHEMA3EkpIq7RIrFTUajOpA5hUxlg1tQ0qnOUCGTPmA
 KVL6aln1FXhaQkBJUv78iopyH3ZQQtir3K92uqJDNKiS4YBMS2C2J2mZDs9b/vJLylo6e5epkcr
 Ohl+5BPlLt/Ui2KhVGUX4k5KwK8haPmDuLn7YUR2WwkAQngHCMCsszmH+HzkesldsuuCx9OTemV
 Zc4lm2lz

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [250828 11:12]:
> On 8/27/25 8:30 PM, Liam R. Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> > 
> > Some tests are invalid on 32bit due to the size of the index and last.
> > Making those tests depend on the correct build flags stops compile
> > complaints.
> > 
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> 
> Should a fixes tag also be added?

Well, it's a test fix, so there really isn't an issue with the actual
code.. and it's for 32bit.

I don't think we need it backported, but I guess the tag doesn't hurt.

Thanks!

> 
> Fixes: 5d659bbb52a2 ("maple_tree: introduce mas_wr_store_type()")
> 
> Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> 
> > ---
> >   tools/testing/radix-tree/maple.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> > index 172700fb7784d..90a0db45a33c3 100644
> > --- a/tools/testing/radix-tree/maple.c
> > +++ b/tools/testing/radix-tree/maple.c
> > @@ -36428,6 +36428,7 @@ static void check_nomem_writer_race(struct maple_tree *mt)
> >     */
> >   static inline int check_vma_modification(struct maple_tree *mt)
> >   {
> > +#if defined(CONFIG_64BIT)
> >   	MA_STATE(mas, mt, 0, 0);
> >   	mtree_lock(mt);
> > @@ -36451,6 +36452,8 @@ static inline int check_vma_modification(struct maple_tree *mt)
> >   	mas_destroy(&mas);
> >   	mtree_unlock(mt);
> > +#endif
> > +
> >   	return 0;
> >   }
> 

