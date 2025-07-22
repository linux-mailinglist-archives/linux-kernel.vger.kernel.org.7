Return-Path: <linux-kernel+bounces-741322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D0CB0E2BC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADF7D5812DB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A99D27F4D5;
	Tue, 22 Jul 2025 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JHHLnZ4e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0G2hdpTc"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F926AA7
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206129; cv=fail; b=LOCRyNzyczCeBhapqPOvnBuyUrJV5XIyquKpvmeaVxhi4mpXp0aq24KCJgEbDUAE/eG0s7VOygQyLfNiYnStCskInU37w4FGCjIuhyWWU/w3OzOWllQvscqrcWfln39p62wE0yDD/g4OmKLE/eKZB9xGU/ho/ormPwLfAQn+Vds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206129; c=relaxed/simple;
	bh=iHcggRwSEMRBrIrJWRMpyo90MtTxT4acLIAUahS3ZBI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=s2DQJzgAyC2MePegcJW6BIKtP4BboHiJnEnfkLy4hO7dLJMG64Oz5Bbkjgw8fV4WK5vBp3FxXstFLC/wwngeNflEvr0YHFBP7fkxthmxIPBFRPr+TPe0xn2ogowkoSJkdkAJEXAuKuie5uSbToDRknKPbJqM25QaqCtaOLcppAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JHHLnZ4e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0G2hdpTc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MFXpJG030091;
	Tue, 22 Jul 2025 17:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=7QoZE82QEWc50Orz
	PeqxsBZeb2bwyvJ3DDhbx0zItTA=; b=JHHLnZ4epFadsfwNDFhJRYPx1bLlalLM
	YXe1i87B1hmBOT1R3V8FFv6arFIP85tbscZ1NuNT3+rxbQPggXP00Vp1xzFTQzTD
	lIkSYt2O1V1bQWXnzjVeqrzQLcpB2vLp8YyDM4+hbxGmG5bcm9wzQr+pojOFRjZB
	bBWfmWck1NwmDbOyEiQJeSqlGp3k6jIbY5jgTPI/KGbI2/vhaUpXUlongFmmwW6m
	nMS8XE7aiTwHErCjzLK3VatItu2sNUxpSEUgotqP20Lm7cz+9AgQyoprEuh2UTWd
	f+QMd5aSy8eQ6IRJUw76KbJGQtDEeDhvfgR5zZAd27N6GTONGhUhMA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e9nyux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 17:41:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56MHZ5CK014625;
	Tue, 22 Jul 2025 17:41:53 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010034.outbound.protection.outlook.com [52.101.56.34])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tfwvwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 17:41:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGAWfLTSOKzar5OOzMbFMds0bI0ea9O2lFPYxzOeP9SVuS9TH1AMz6Z0EyQR9cXZ1msXRjm75FN/UueNFparjPKv/otY3NKZoNLyH3K4573lmaz2sdS/onDFvkHdgLt6YfjVIf9PFXX27l5Cglslpw215LVD8jHL180Wi8wo4hhJa/4fhAxCg9ac8iZpx4Clfio/hWT+n2ec50RGaLRn5vbN3Nt0jQVG1iXqU4qpbVhvGC3xBqe6H9uS7ETKJUYoI+g6ihnQa8LNedyX6fzVBS+yIEgv2hSyHmAcMIWxJXgCOEwnbsAYn/XHwhb4pv2lafxKXyuLbp5LMevZgi7Tgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QoZE82QEWc50OrzPeqxsBZeb2bwyvJ3DDhbx0zItTA=;
 b=cXKZVQbi2e1RFJIpd1ZC9hOUumGEo9ogZR4VZ58o11xuYfBM8uXEj1B5yBOvsi+F+nSQPSmy9zaUkDybXHEXt3s1kBrMZhqZUWKaSGQed1x1ILYfQ0JyJUlNLn4BnwHc9WwibD6IDAOIMYGYhBxYk98eWJj0Wv4fsgL7ritQRstoPF2jERLYBtK692s+Pkm2UIkiIAUFcSfHJaAD39TP1gLbsp/YpHLjW+wEZhh6+JF2Uco4EB//F1RwRV1y4v9qTrWVKk1zGyf47eVxOEvq5I9vkk/k2FHwW5K7o7nfuZ6DUT/u/bKa4adYgKXG2rqe7GXMLV7tqkp1JgJcmDX7Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QoZE82QEWc50OrzPeqxsBZeb2bwyvJ3DDhbx0zItTA=;
 b=0G2hdpTcWYpQEBiB7CMikblIdHRcn83gY8RVDh5ZZyVERjp69D8Wp1ubaPa2PYM5RYaV6nNSfRZCttrRA5ZCM0g4OC5Wf4PxY7j8gT/MmDtnTeQS7e3jMvtXTo5vrm/SdinkuswAF1rIcKBedrdg8ZpXvzt4oCLGZDsQbU5vJxk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB7049.namprd10.prod.outlook.com (2603:10b6:8:14b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 17:41:51 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 17:41:51 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH] MAINTAINERS: add missing files to page alloc section
Date: Tue, 22 Jul 2025 18:41:43 +0100
Message-ID: <20250722174143.147143-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0112.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::28) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: e5826cf2-b6b7-433f-702d-08ddc9470a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JttuzBF2EzYky1PxBVwi/9FiB+14rixxrKzegL9v2W1SumKGne58rip5w8PO?=
 =?us-ascii?Q?hMg7i97IQRwBJUSrszJwWBuWTFnypiIss4Fch3sEzLv2K3ozLOYZrzMDr9k0?=
 =?us-ascii?Q?EKQBuPpZvkEUnUkrJwmi9LMXtzibU5u70xP/7O2OIcQPUdPQzobeXpWlB4kv?=
 =?us-ascii?Q?X0Mo5MhAJ9u/B9QEzkW3labDZWjBIjx6cdkfvmGnBsh2M/Q9uwze9rlzEHfG?=
 =?us-ascii?Q?JSP7hzOjILREEzZHUjqZZqgQOC/mw90nzuW9L0j2UPlZsm16PRWxElX0ZPFn?=
 =?us-ascii?Q?UqNYp8iKnWSTl4DX/Cm5L9E7mPKfoxjmMHv9wld4bkcVjLnHFm6RLGQmoPM2?=
 =?us-ascii?Q?UuLUqchDeujn+uzgoC+A2okw6XxT4+bix/4uPMYZVcBCBAomZVr8ZofoSM7V?=
 =?us-ascii?Q?j1/ahXzF4iOyB2JGiA5F2TB10KS/8LRXLTi1onSaqIFJju85ZCisI+jbfGAn?=
 =?us-ascii?Q?NkW9OevdhuknOPMtgPK2hSEHrnAo5/bN/l/HgEtUPKFjxMSVKET+l5Fdyn5W?=
 =?us-ascii?Q?bOmU1lot850Pq1QvuHSNKRR0E+kmmR0IJAQGBczCbNoyyCDtFIKvCRhAI4ZF?=
 =?us-ascii?Q?zzabiBs33gw33jAWrpqLamTrI/apT7GUjHrGyawr9aUbYjvtRS47FgjCFg0B?=
 =?us-ascii?Q?hyw89JL5DFOtAEozi0ZWMGcoAtaxA3JMEA2upvBia4x8XExNSMXgSeZk7dEG?=
 =?us-ascii?Q?qymtrLTbN9LGeQDOFpIkRAIMFrdRbWR8yxYNyRmjWmQ8+YwQf3jHof5Cg816?=
 =?us-ascii?Q?sDWj6Ce/shP4pygJWVJ5EyUuRjXWkKnH6zJKJ2aVp2qackmE4K6kgb2Y/FrJ?=
 =?us-ascii?Q?dciIt+n69ZTtr738NOQ7eFGJ/iVMNHoWK++tGh3JxJMNfP/4NZ38zSJTNvUy?=
 =?us-ascii?Q?JAxwDqTxdiEc0ed+Qt7thTfmBCvwbeGVRm9YUs0xMV8ZhC6nIWASPFXoR10x?=
 =?us-ascii?Q?Cc4vYdQx1Eg6FwENI7eidDoT4mG/sOaiv63MXfOTIzWsrzss1Kj19SMHBbNJ?=
 =?us-ascii?Q?APW6kSQHMi/KVuZVf1GxXUONiXkO7UCUJ58QP2qficWr99qOpAN64xsg5IxH?=
 =?us-ascii?Q?TyUk4ODS6O72sDm2eqEj0/fGwnFlJViJt9l0xC56aZzF/HeQjiZr5pZf+q62?=
 =?us-ascii?Q?AIjOf9Xi/RQkhj1949TTWYX5pMKi9J3mC40nR/7V7Htr7G/KdqlSyeERAjut?=
 =?us-ascii?Q?oVieb6BG43TzK7XynoB4cq4YZAxBZf1BYfaWkT8aeMnYGkLZh5V8x3j0loIs?=
 =?us-ascii?Q?Hbx2nKyUSL5w+q924ef7EQyLoufk2HesGUSYRRNhTldln297mbpSVRxZ8Ynf?=
 =?us-ascii?Q?eAYSrrcqBzxvESp7I3sqEwoju0D87s0r8NL3QWnh7XQ49stQjL0IvKwMQ4q2?=
 =?us-ascii?Q?8DjIlpaN5RNatXNpDeLEAb9AS8g8mwdDxYeLkj2KxgfiZlxGPEYtMKwqBbDt?=
 =?us-ascii?Q?LflE2gTqTYw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VnxI2vtFcIpzWUvEY36ue3lYNwTILDZFyLSCpnWqKZO97mD47dnIhYERMPL4?=
 =?us-ascii?Q?0DHFW7zohWH03LoFUKpqgtP5Y98uU7lXeJsy+4WIpuksLezl9qg2x7Ax7TYY?=
 =?us-ascii?Q?hQH/8/01pq2RpPjv0VQvLSAB9H1WH3PeuNhkE04Kde+sDIFt2BDtScQOsoLl?=
 =?us-ascii?Q?vItv41gU6SEDlHvviel5RCOvIoQcsIkdkAZG5i45Q3jI97zA7p8tu6D8xkOL?=
 =?us-ascii?Q?9xQrwQgdZZvN/8N5OueNT+NpRtCPvuEuJIL+zlywvMHss4ItrfHrffAhJ3VZ?=
 =?us-ascii?Q?H/9TnRG0oPMNsZexNv5OZNm+ddeHNzRUDKZnIoYi+JaMMmvj4VDPjGetXT/M?=
 =?us-ascii?Q?0e2MvUDCQiR/S4lL5W7C4fV5jrThWFjbLo+98pa4vh+A10vjkTi0KEQdcJXe?=
 =?us-ascii?Q?dkb0pimzYNCOuUHswv6Q2UFkbNmUhzaSBtE4CQSlCrBz+nS8fARTTY++StRK?=
 =?us-ascii?Q?D7tK1hlthuM03wRXK9PsUrRITlf9cWtf/Jlw2b7TZbnhBuu92GAobIwuaR2G?=
 =?us-ascii?Q?fo36yuwTCF7O/yUvk5T5HPSH/yWP66mgcLfIdpAXY3BIojScrh2G5L9wsny/?=
 =?us-ascii?Q?/vuUQ8xEFRcBN7PmgaT6WpUUtt7596JjqJhEUgUCEL0s1x6eqv9uyPsqN/f0?=
 =?us-ascii?Q?L3z3k+Auz3ayd/qYrlwv2uuqY1xOuSh/eHCRj6u+J3BiG1BOvCl+h//tDmHQ?=
 =?us-ascii?Q?cspkhPT5217cvMWwXtWMybB+7yT+PFra4YIjsWebTlXBcu1xO0hEQar4LnY9?=
 =?us-ascii?Q?PScQjuhGx5rEz1BkF/1QzBHcdyC7/g2Ej/YkSe4odtM0Yo6MZ1qh3mKW/Hf9?=
 =?us-ascii?Q?QW0ZaJ34VCDtQaWb6g0fAHNfqD4TMZpL7PW9dEQe8okZgH6zlX3WTbrd9llL?=
 =?us-ascii?Q?WuTBZDH8qQ9sbQSOZ7WYj80EHZT+b9nwxrUgrzEnyFPIg+nyfbv8r+czo85y?=
 =?us-ascii?Q?8q2GLbxhQ0ngEL2m3WE8W/HR2CQMTwn0Fup8u7Y5h2owplpf0N2lxIBQtff9?=
 =?us-ascii?Q?qGf6oo97407rGdqA5M72PbXSO2jaxVIK2YxSWxJcz+QC6uB/vrcVBF5RMsdK?=
 =?us-ascii?Q?BhQ7uBFRtllVl+lF3NXpbcDI4gp3sl/WWBT/uWqQ8V+drMhje7tp8ZTDsGwW?=
 =?us-ascii?Q?MjDjXZ/1kd5GAj1cPRzSMpK/scpyY6yvUNCt38UtHBqsGLcolbnxI34s9ILt?=
 =?us-ascii?Q?Wsn3Jg23MpUXSqDjWLmyBa+amr87MlNlLQpfk87gFdElpFljRIWeNSqrXIG3?=
 =?us-ascii?Q?7WpX7r9FmIyt8G358sGX9HY3aJ6mfaX873b6quGzMzoeBijGkaxEd713ckg+?=
 =?us-ascii?Q?9T/2iTxSpa0qe+GqNz/Y32nCmYQcmb+L6aLOjtok+AERB6jb2YGfSj+hSTQa?=
 =?us-ascii?Q?WXlBWBUeR9BOvMx5WoIm23USfAviUCJDmyChMGooEKYaem8vFIfgr9BCVLCU?=
 =?us-ascii?Q?a3uot5r8GHKYIN5qWgnBUBU4oM+RZVj37LjbOCWDKnw9iYMF6TAEDggVC+IU?=
 =?us-ascii?Q?htsfIjGUkwoWQFMIXUyL4IX9JQw7IR0LZR9ckfSC+J9Hg+mETr3APx6Asyq8?=
 =?us-ascii?Q?iBXiZetnFS+ZKo3D2IXhrhYoaua/hEwVC/DNfLLWGPfG37nO4bsRbQq6br0X?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ChgXxtpyunvpIj4dMbP/quEhv9Uf9vjcNt3Esk3d2anQk4Zli2BcSmGyzGb6ITmr/dDQj2loeRw5tdcjsQXaoV09J2Y5wP4hFXvZvXTnD18VVhUpURKrY1U7LNj78s0KrE3W8jMKeiJqMbUM2UyzFsTz6wGjx7CuVrRYGZAFcyESBbtp5mHVTkszplESpfoMMa+QLgYMbxM1pEaI9HmndVtavQ6wAd/Y+54TTPBuwAGvz6Yijd29uqD3ioI6HhmWo3SQ2VWVSFuzQqYop21qyOMuaJTNHz4KakvBxwackP/34R0WkPAEW/Ac/XQ4gpc/Olak8l196lnUCiUqMdnFt2FJo4nizKXaLkINihAtS9mRWGfjZmW1kZC5N4J64WK8B3NWdqHvC/Qw0Vv/BZRohqBoJtj59ozyt/2aFNPUZK/NZRG/ww2S6f9ZQPch4Ej6jTxdU9fOF06LmHfgHjgQ3IiCskqLEaR9ALbf2RRS/cgPYtsky6fm6Un5OcufrxQ9H46xyyCiEq92IDoWwUM5Bd59eJsFkKZ99bA4ZjBW/9Lvr392iooWp+A8ek+eifK+9igNap5p9J3N+t4SJrLj8M82ls6ItyrlpCYRK1S5CsU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5826cf2-b6b7-433f-702d-08ddc9470a6d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 17:41:51.1816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMEvNxE6s2PSJkc6Xcd9ZPY8U+0yvcdkdsXb7SX3N5wK5tYZ3kSNAj+mR2UH/i5uravOsQ21n6QiJXOXBFjYd0B5iI1SS405KpPu9d0qrdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7049
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507220149
X-Authority-Analysis: v=2.4 cv=eqbfzppX c=1 sm=1 tr=0 ts=687fcd63 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=Z4Rwk6OoAAAA:8 a=SpECLH6rVf7mn8lUAfkA:9 a=HkZW87K1Qel5hWWM3VKY:22 cc=ntf
 awl=host:12061
X-Proofpoint-GUID: knMO-yGSysbAjNRd_o1NQCoHBx9m34d8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE0OSBTYWx0ZWRfXwENnljttwgYA
 aDEqMgykGrivZcX3KfOEqkZsO1ca+j4SZ8aDGDV9BiPhGsa6aWz/WI70h0W3ucQ3NvdLGxE835b
 AlvGf/83mllJkE4IQSY/qg1/QRyjjagL5NYeFJbnZ6EH/hoFsi017ZcRZzqwVkMXWLb7G7PgTSt
 ZD7gIfAuaBAgfxsp4SlyZ3lwcN3z4eKKgnJQCMU6y2Ab25jFf6fQ8kHQXHrp9QC+vTLVVufmB+c
 vq5qoNkL6ublayBFpxtSEl7RIxZL16K8+TYflNuFxlwMfK0hdgpgxzvnRM2rBeB+c+8IeIp8M54
 cE+mFyJ/WYCaHF5TMmlv1JgW6FAfU+IyWU+iWIg8TMNbc29V0XXZbnPaDml5RoJp7xpjsjIHfI9
 k/Xc8+cXVDoewf3wf1E2TfxU+MQPzpFDcoGn98lEJ+jzGSXYiErMy3KGFshuPBPyU3cw41ss
X-Proofpoint-ORIG-GUID: knMO-yGSysbAjNRd_o1NQCoHBx9m34d8

There are a couple of mm/-specific header files that were accidentally
missed previously, and some page ref debug code also that ought to live
here.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 837bc5cd6166..703f176315d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15879,6 +15879,7 @@ F:	include/linux/gfp.h
 F:	include/linux/page-isolation.h
 F:	mm/compaction.c
 F:	mm/debug_page_alloc.c
+F:	mm/debug_page_ref.c
 F:	mm/fail_page_alloc.c
 F:	mm/page_alloc.c
 F:	mm/page_ext.c
@@ -15887,8 +15888,10 @@ F:	mm/page_isolation.c
 F:	mm/page_owner.c
 F:	mm/page_poison.c
 F:	mm/page_reporting.c
+F:	mm/page_reporting.h
 F:	mm/show_mem.c
 F:	mm/shuffle.c
+F:	mm/shuffle.h
 
 MEMORY MANAGEMENT - RECLAIM
 M:	Andrew Morton <akpm@linux-foundation.org>
-- 
2.50.1


