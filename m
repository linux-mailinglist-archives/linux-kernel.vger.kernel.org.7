Return-Path: <linux-kernel+bounces-795773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D552B3F7BB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79FEB1A87A34
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94532E6CC8;
	Tue,  2 Sep 2025 08:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oQmXPbhu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OptgRYJ4"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0AD32F757
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800538; cv=fail; b=LtbYJrrxF77tBHuNZ8lmjDc2sz8PJKpMW7tIDWYwMzb3wVhdyFepALSZ0ql9+qYbZ3O/eOZemRxWcYZAeUJPFdJlfTaFnEx5XVPFCOSyJLPJkuu7d54EI0mVbgEntaau7gibALkM5zSL9ha0XNqQfBqiecxRNjKruV4yFyPnBak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800538; c=relaxed/simple;
	bh=G47Ylp0713rz49HeAZWsKOSnOGTHq2w55GzXbQb6we8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BYD/WGjCWJq0sy0FbjyT1bhKbaxEKnDKnvAXmhP5htWrnw1Wh5vHAqDwtdZ7A+SojoBpCafpzahrGpqiMz/pK4SAhutCrz/T2zmGOe5NTTwSUJ/QTBzcuZYS3UN1UrNt3+f94EAAO1hBA9ftWC2cUqSJyO+C7D4E83PFAf3JUbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oQmXPbhu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OptgRYJ4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5826gPSm001342;
	Tue, 2 Sep 2025 08:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=71YcSEAsBYKVV6nPijC07t2ug5PWbqQEVoZxPM9VakM=; b=
	oQmXPbhudipJLj6Yd/QjwMtjBdNfYML1vNVbdwm4HmAmt/3OdUKpYcEQMlN16HHH
	gtTYQiVcRSj9iCNvfTHSKDVRpPbdsuX4veIaY1lE3NLju/0a3wSw6wkE77pyjTIZ
	iRoqM0bzU/GcU8qv5rB1vZ8qTFW4wcr+ihmOq3mSE/lqsC5P32M8KFDPieBBs1Z+
	WCXojpDXTivhoBNgZbXpNT17bQoFy6Z0RcWYiCHOfeS9p1aNBoKvJ/3QYtKKf4gz
	eCg/81qkyPcIdujherA9t52Mqdkss0fz90ZebCkan+haY/Niu82wtYLiNJYKlBpJ
	Tbs8qDdXgVtVMkjCq3IkyQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ussykdyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 08:08:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5827Z7US004220;
	Tue, 2 Sep 2025 08:08:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr8t46r-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 08:08:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQveU+21ag7y/oGdxeyOvJ0ZSysjlX2LMMJY9mXYct46KejTIUdfhnxq/Nwlmz+6t911iBMBrwGm8e2E6FuXJZvZ+iq0H/y+CZgIGC4bk6ZIGNI2jaxeoaKrlciT5ShsS4kGuvK6jdgAUJXcE5aX6jlGRC1fHDFbldCm/jCABw9dzFJdqTE5w4fw8eK/B4IVbaAhWVui0HTCOiJEdOc/dLHHIxXPbWUN7lsF+ahbiQTobeMhTXaz4n6WAfLA0qcRhA+s8PoIkDAGGl6vfcf/5G59ZacUOEeaAS6tdyJftLkWpBa5O6co8FbFi7Pmfq4iu4Ikj1u8UQJBJEj1SJW0tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71YcSEAsBYKVV6nPijC07t2ug5PWbqQEVoZxPM9VakM=;
 b=MB8gbK+lQXc755ITeYs9RDRe/Zk8w5iaHkg2hN/Le53CcM7xrAYSzB1Vtse4yHn0rWHcyaaCDYPSKPamlZiM7VPJ2d25xHFxC+GDZ58HcwNM4sroG2hqNQAXBSsoXxdSXw4KR+nQf88ihxb9SyUAJULLRA3oA0/spOzHVsYDKccCemgyw9emDgzT98iPCdOOzqcleN2TzjNpKNYq95WMJ6QxpX6wp3W0yjOoZpXozafqrKj27CRF3UkiLV+EKJq5H0+sWVkfMwxl2LgUJHsNtYTOKjKxjc5AAvNH8AUJMn87p53kJ6uqY6Si8dUmDWTRVdmkWC1jbS4iR1rqbqGpeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71YcSEAsBYKVV6nPijC07t2ug5PWbqQEVoZxPM9VakM=;
 b=OptgRYJ44cGkCgq6ggdXIygW9pZYUGO9hdnXErh/djgRtn2Vb6NHMWdE25us/Bn8rI7aHpFqtrpeTh3i+yqEMH/2G1UW3Skgzq3ToHbm2U0jJsMu8kUL1wrPTlm8/AAQKBRAvptmWKDm4DcZsjYF4xPtrnU1ZpgO6TcP4pMhdCo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BLAPR10MB5139.namprd10.prod.outlook.com (2603:10b6:208:307::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 08:08:20 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9052.013; Tue, 2 Sep 2025
 08:08:20 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v6 02/15] perf bench mem: Defer type munging of size to float
Date: Tue,  2 Sep 2025 01:08:03 -0700
Message-Id: <20250902080816.3715913-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250902080816.3715913-1-ankur.a.arora@oracle.com>
References: <20250902080816.3715913-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0069.namprd04.prod.outlook.com
 (2603:10b6:303:6b::14) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BLAPR10MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d3656c-eac8-4085-69d6-08dde9f7e156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CIUQYUQnpcS/jrWk1RS2el04cpb16djZt5LppsE+Ey28ZSUKQHDFn87aejwn?=
 =?us-ascii?Q?2X4ieoPdPSHPINBar3IcgKbMnNopAUGK7CpK6aWQQO3/qtoHGBzaT6WMzT/c?=
 =?us-ascii?Q?OD3yCXWZZKD9RCGrnVaXiSwMmlTW47bu2+26Gu1y3LpklId+7s0juBo1PzA5?=
 =?us-ascii?Q?JsEM2cdJt3MMQrzaTiqw2p54oI4hrEwp0w8Sh/sfrZGQuH0sf51n0AMLV8Gt?=
 =?us-ascii?Q?DmM9xFHyRp3+KwgIgMgSAB5+jGDSAL9oiB/CLBGcXagJIcMooxm53CMqoGwv?=
 =?us-ascii?Q?e+7MNRMftw43UNmPd+GV0HRcdV7SczZAUDKQ3Rg2+eTu22Ve0y3Np2/Rv99F?=
 =?us-ascii?Q?cmc1ACLgsFkEu0pnCq5NCqvvZ8I6B10J/ERpUWmMZqLrDkE4o74bVor5n6O/?=
 =?us-ascii?Q?j9palyvcGxxVCBq0a4noK2uPoITMH+/Owmq6HqOsVQUC13gxCMA/sosgNA4Y?=
 =?us-ascii?Q?ZBx7rOxWV+BWQKiToBeX3ZppHKtCfudmxYjPLqUJhu4L0ytlLKuNxoHQCptU?=
 =?us-ascii?Q?lAWyva2SHu3bdIkyitXQuN0oOrRRYpYJy97F/OTFRQoJVSbWWTFMRhBQamds?=
 =?us-ascii?Q?AHKYpjBS4rHwtTntJxv89qUGdsltaP16qoZ3c1cpsy5akRgTxBSTEK0aooPF?=
 =?us-ascii?Q?umXtz5wItPmzGBKCQGbAGiV3XZa+7zRINmWSsBT9drMYfsh+qlHxvdafnG5W?=
 =?us-ascii?Q?LP+aQTCXzMo2MuzhX07UZyW/SzoLau+3Ct1bUwhh685MD072hn8va4Y1BUUR?=
 =?us-ascii?Q?edJzU4WEegOwSIOh4QLd8lDJAF1fe0pG5vtFNoHlaLvM+1BraRQ778iHCH6n?=
 =?us-ascii?Q?tebUoHFqsaFSiYPp/ChxQ6QUDmUTwQvgHVlw1jMCU3o5pHEHqLe0vjDTVkXE?=
 =?us-ascii?Q?Pwh49ORINF3IkAnCeusMN84S1/9XVJPk2Xu788DtoVttUGG2avNnh2FUYPDF?=
 =?us-ascii?Q?zOCYZhCvB+D+Vzy6ekM+9BV51kG6C3HaYl6EgIJTMDcYR7Yl91/K/7S4eoS6?=
 =?us-ascii?Q?iI7mqGTVjKsWHs4kdvIrPjDNcGYxNyES6pJfnxvb0Wummmkky11ZiNOL4Hp1?=
 =?us-ascii?Q?Se3Di4j5j1j2e+jxIJ7DurAESbeeio1/B+MvZ02spw2xpwVT8alV7X7jtRWC?=
 =?us-ascii?Q?fktSd5RfO2xYWlpDroj/lNVu2evOtV5Zt5S3V1qWhSwX+lRbkxTExzD3caT1?=
 =?us-ascii?Q?ydZhK/BjYthZEshK392EJrLa7MBpgyFnwkoz6x5rBsLy9bPU9TyXrzQizgMM?=
 =?us-ascii?Q?v9BbaJvGegPNeKB6B8IJFbON4baStGN1HafSAEHM/lIkOyTk+efZXqPW31an?=
 =?us-ascii?Q?u/qHCnQxJrJLyXulxi5xRJ529zwukyKR/KQpt85ZS30H7Z1XEpD9zT81JBb+?=
 =?us-ascii?Q?68+FgSs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DDQtHLAgQouRqSpeHznJ6L0EnFjHxK7DW3pPd5gVT/8sEBOoBI6A2Fhlm6kH?=
 =?us-ascii?Q?PO799+CtO+5IA3yYk6pwlv9Zsxzw99wQABfJ6jGGn+lUGwwo1l84an3WG7oa?=
 =?us-ascii?Q?3NCEdtxIGd06VNjghrM3gEikqnNZvJrSUHWT7/lSIq8akq40qff1MmVtUcNt?=
 =?us-ascii?Q?/wwzDOTfJfpj5iMW9OTWmZ/2EE+gZDsK6ovPczhJrH8rfZaonuaGUNT3HSGt?=
 =?us-ascii?Q?OelqL7KvmEAqb8JqTl8NlivTiuiCx6+EdUjWC8TzPmQEXhzcw+R5KdOE5jze?=
 =?us-ascii?Q?0rZhfxfCdGy1z3pQxsoYtszSpQPlwHwEVXfTNh5UuWFmIJbWl7xBMLzgdRHy?=
 =?us-ascii?Q?og8AjdMsj/P8VwoH0OSAkhx4LCEq/s66juh1NDiEUMKiKApT1z4KfQPfQ1t7?=
 =?us-ascii?Q?BHZ1CYONYLGbqAuf87YWhpch3YKDYMdb9VrzqtGRHVjmoATLBuabbSzngfxE?=
 =?us-ascii?Q?slEmAMuC+pTL6Ri2dg96sOxFkshIebaJJmBWr4E4JOYkCVnYGHmw8ta1mINP?=
 =?us-ascii?Q?5mOoHj7LLSH+5WofdGe5kJDoDQjIj+TId7OW/Uw0hNihM9cdzQALnSJr3sji?=
 =?us-ascii?Q?OuCmygCREDw/pQa3yNnUlP/q6tR0iqLgyskEYJYx0XJdDHfQySmM6jwVpkZj?=
 =?us-ascii?Q?/WiBXZXb0U7pgQ/6ERsEZ6eWmGtVBMSFk/PNpdpX8lc1hVcs6cy0MZty4RLt?=
 =?us-ascii?Q?fhTH9LEk0TImStJTv9QRSdRM/H9XMGWy51Rgmet7Ls76jfaD46FFKlZlWv1T?=
 =?us-ascii?Q?RVVTBS0Oi8shWGpwVYq3ijAve0KKCuXFnfS+6zyNdagX9WKrhmdLV8PYylYa?=
 =?us-ascii?Q?uRl6wYccQiGCte1FHrTnlw4GXllIZlL/xg1Krx+G2bJcvNzJd9wTUmzP5W3g?=
 =?us-ascii?Q?FiF+t/bas3IL8uTMjSvirJrk5n4yjYcPQb+ZeMsxdb9Omfp9P51bwa/JIL5N?=
 =?us-ascii?Q?wjY0jnlo0qH+wq21k8UPEhBeBlyFJlHi7xSZXIQ1rWSX/ASiNVH26/Txl6WQ?=
 =?us-ascii?Q?QJCisy+XT1Qd23qgI9lroyMrYe5tdHTe9SMB/S6uUvn0OIHijPs0vQtLBppg?=
 =?us-ascii?Q?Dc3CUFa0guhztGKPE9BqzCttafc8lI+CvHsUfO9pG6ZqpDOKGk0ZYRVYhq5l?=
 =?us-ascii?Q?7+wVBHN6/HiNG5B24z4YsMj48xK5u+dIOmod3qodOOJ5W7j78hOoz7YHvzXJ?=
 =?us-ascii?Q?WY7AC8/Vuh+D84P23dVgm44px0Kmzqm5BYPW983zrZH8T3Jx5gkI0KRN1q02?=
 =?us-ascii?Q?6t4vCHyLDD/ugbqSH8d7/QLCeIAc7pxQ/TlSgs2X+jxnD52QYHkZYywYbqzk?=
 =?us-ascii?Q?LKSJqV8yoAwLb79k9svnycChCYks3KDcaol8vFccFh/1XpnOQZwY43OjMuiU?=
 =?us-ascii?Q?iO9C4imNripTu0RxxhCCkWDc2X/CWgwf6zgWoDp8YLIJwmPvj6/IpwfisTou?=
 =?us-ascii?Q?8MSGyBwm1L3kEdcMeAn6ShGoO3IwcfWBpCAqB8x49n4fBjA4J801XLjIQ8OM?=
 =?us-ascii?Q?Q3L2eS9vrmMy/3xD/sqzM3YITTV4vnJp5lLYwtQOGczelSNjZ/iBPneGqWuj?=
 =?us-ascii?Q?VgGNLfS2H3DLlOGv3bFcjZUWojWknV+mxZbYIlLAYZNq7K4ffcRwVnedEaFf?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mmFZCrtz2F2VbAlvXAjEHsareCMv0n2UA3l5P9EbO9p2Eec5udbOHxx16WGCInIO6oaGXRI8nsgouBbZj4NR1kP8HZ+X+F2BpMTezfcCUwvBOwrRRLJa+/Bo948cM2+Q7sjIrzRbFqlMYH1w2q1ceRcgcDASs8Nke7lVnI944nanLGgk8sLu/UgZdf+q5GrrGOE3ci7Y7lCkU1lm75yWFLU//cBLlDIrP37zT/mRHne1QhrJqEnEX5nFtGT5m8CG3X4Vp9eX63SUEneimy/6rhwtfajw+iJ3tPuqHugnhTqcMtwEJEIum36Sp79TLjwNUk5FDo1G52KN91qVAU8HRxNrTTi4SwIQpmdDWUj0SPpte0bUHoIXpZhiuFMvcSI5rVhrhGBLUzf7Er5BcQmQbQBf/vrjqvhNsS4hRlwf+knjU2AVjlPb8VoEkGZGETHRm99n2tmF/9mhtFBwtmcdGymX/zFDiHIgmzp2+EAEd6+8SLokLDBYvs4W0tXFrJ8SgzZ12TUVkfkaTXHvQGSXXR6fioIh1xTP8Cuu2Pluj7OxQaVQeBrhYanSVPA1pQyjJR3E+ETCVF7D0IV5hjNUMAPIZj8Ur3UV3WlEil6Rvkg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d3656c-eac8-4085-69d6-08dde9f7e156
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:08:20.6895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gNpKotvmPS/EH95HrhcuiCSoDAtoydPqBeZckizbPix6EMCnxDY6ktWVhMKdOuXxP5e87Oj8zJoHD+iZh+KL9W6AfR8m0N2hvW1pmyxKOEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5139
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509020081
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX3mW5bZGhGghZ
 qpALeqcoEUrrqcfGuYHnkUv2hOqX3lV7Y8UKRqwgNQLidcKYDKkv1n1LGLwzti70wK+5SeM+3HP
 UZzS56zoTYwWTTJg7OC713QH9yD1wpn3UnRXHiAfOKZrvJRxbY+Vbktpry2Vlo/pKesTiuQzQbb
 G2qSGZfg4Kz4lBllLeEV0gL+rQmkef+sJpfBoASgYK0pXiFpZZpeCkSz8nfmP7AR5OmFarbMB1l
 X059+S5SDJSqmTC0bBubbG1RCp7DBC904+A9lLCrH8Dj/JsjZ7aCwGpSf4tAy4e2JCUTUwsGeQz
 TCCP9gU1CqruOY+LOO37L2YQjXVgpmh/aGFsu7GolzC/4hr7d4jVOoCjBzDenrhW/NTqFIJkcFK
 Fvv4+fSw
X-Authority-Analysis: v=2.4 cv=X/9SKHTe c=1 sm=1 tr=0 ts=68b6a5f7 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=X4Au_8HLBps5sezr5J8A:9
X-Proofpoint-ORIG-GUID: SPiMARZnqndJPvPbrWvz6f6b_5gPCqL-
X-Proofpoint-GUID: SPiMARZnqndJPvPbrWvz6f6b_5gPCqL-

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
2.31.1


