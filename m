Return-Path: <linux-kernel+bounces-795787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3575B3F7CE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8F9B163D98
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE9D2E8B64;
	Tue,  2 Sep 2025 08:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EXDsYR0a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VM8ACx3R"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDAF2EA17F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800561; cv=fail; b=iAzWoJdmaUTXWQOsVa7gMUH4xvuSrG2K8SLFx0U6Zz66nHZRHKzx98EPUSlwgnHGoDU+4oAZ7AW3QJp25dK9SxdlCPrnTAFzJtD/+tMXltHB+YIi2ZVwkWFYjJHTLimRwTq3DhIRHjSHVoNjDVxtlXEBuIurKx7fqs3Xc1MFc2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800561; c=relaxed/simple;
	bh=u+eOjkHYhnJIQb0aLc5Larhis/wIehEsFllXRCkvDCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DPEFniaa/5KuNz3jgzUR4OU1T0Ukeo/7W6xLU5nqxuXtobDRuvoq3WfpM59q1pLjYAqOMEgf60XpTbohVwTczFn2tm3e/mJtQ02SyoyUxW+s2rfMSBtWw9RrlZqfRugedfhhdxD0Glk70JN71gB5cYytXAF3uD6BmYrt0PPV+qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EXDsYR0a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VM8ACx3R; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5826fjWn026302;
	Tue, 2 Sep 2025 08:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UPWg8IaLCGkrS/X2oPVs17aaNpSGv/rcwYn5unoSWaY=; b=
	EXDsYR0ai9yGc6iO77O9gb/wgPGQF8X0pCeEHoIM5Adz84wuVz2RgHpyubCS2lQ4
	0x5CnZ8dGmWOCXmbEanX9RXRI6nGihLpHYWbtjDp02Lgd3yLE1Al87fY5v6amh04
	yqena3daW8jsd84W7XCea+TT90l/1poyLczzdxojdiMF+JuphPaV2scX78JcUKqc
	WUitsMnbVHqM4i8YTWdzNBlcQ0kh6DPF03O0+pwu5SNRyrFRipdHrdxe7cGTTTQh
	gYkuuBUhEuZe9Y/A/jLrOtDQadf8UkbSQMULO63CdSMBY23Q2ILq3Q4iDQ49ZD86
	/OflufU9hGRWwItKVF9Nwg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ushguf98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 08:08:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58265DfX024980;
	Tue, 2 Sep 2025 08:08:53 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr8j726-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 08:08:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHCkEHwTestNeljwhXuLD1pxm22BAyhTfTBxEV6+NoNfkO71S5qxzWFd3KbIogZvrTwQRnTJEIth+WQT7lCcY5wiEAgoPkOEtfqntJPVVTPHcUzONQXSSHNskvprtGvKGKbXi4Qlckh9AOfYFD/UF7WAmHnGh8DZVdmtzFUtHNyYhqhBthpDoQSX41/AUiHgNG+Yz+May7YVLepmbPWHJdlv85HYOVnzpLNl8qmZgcg/Pa8ReuMuyAmqGvJL6gSqEzKecARWvUO/6ZVItQ7P68tcjr3dCIOihJCbT86eV3+YHxeE3MFHaPcvtQMbCUx82Eej6vDUVPsHEgQ/65AQNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPWg8IaLCGkrS/X2oPVs17aaNpSGv/rcwYn5unoSWaY=;
 b=EHY+EMkiLK2EOC6BoWpaJ/gUTM09eQgl9ZqZnOR65V+uwK33BCi5b6nv4CkclGSFDBNyJ4m31tdKCP144JyjLDGXgzOl46PJ7XIHxzsStUuD9DGjyStcK8DdZUacd2/0FVe4qDGCAUPd3L2ML39/O3iPstf9QIv+c9lAkr7nHnw/3LCrGsB0KfPl7q8//vsgUbmHXknO1yArI5aFwueRhseakS7ICCW9Yb99KoPVuvv3f4VbXrEI++irFMyKjHRaglpAEYOu8HFb5wNqbdGFBxFGcqlke5yi8DMB+NRhUILMwhxbnuskTGwrL2QoSETMm4jfbFjpjnOS85Rpzr6ttg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPWg8IaLCGkrS/X2oPVs17aaNpSGv/rcwYn5unoSWaY=;
 b=VM8ACx3RqR+J1bKgvQmm6uGoZgqwCRO/uieZeAf/vYAYFWerrTvfE1IZWjaiWWhqXajOALunH2eyxuUMN397eCEp1yZZw8DJ0I7F58IOYwzyUooDSVnDpNoDA9qvc+iVL/di7rXfvVlWLua/87IOl2/W1uNi13Kvn9uoGE8TfkU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS4PPF6ABE13187.namprd10.prod.outlook.com (2603:10b6:f:fc00::d24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Tue, 2 Sep
 2025 08:08:50 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9052.013; Tue, 2 Sep 2025
 08:08:50 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v6 14/15] x86/clear_page: Introduce clear_pages()
Date: Tue,  2 Sep 2025 01:08:15 -0700
Message-Id: <20250902080816.3715913-15-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250902080816.3715913-1-ankur.a.arora@oracle.com>
References: <20250902080816.3715913-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0127.namprd04.prod.outlook.com
 (2603:10b6:303:84::12) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS4PPF6ABE13187:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d11626-9ff9-4828-816c-08dde9f7f32b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gGwwijXGUn3eYjMml29nfOq8RiWQ1h/Jll3kM2jvyFrsFif6+4ZDntkergqR?=
 =?us-ascii?Q?kkjFASmggHKQxCARbOwOAXOxBhDSRorlMaouxn6wtKFWH2ade04MBCS+cbz2?=
 =?us-ascii?Q?yBotEbZYLT1d6HWvt7AzZiXSOgh9f5/aECya61pP5S9f5JmeQo/zrgmb3ebr?=
 =?us-ascii?Q?BSlNeL2AyXYYIHa2JQ3my+2RKBMbg+xKScIYlRNf6BOOJJ6JC0p8irYAyzf2?=
 =?us-ascii?Q?+2l/GnEtXi0PoX9Ncy2YjDo8nQdTGVfmCrOjSw9MbEThVPZEDa117OWYdpHn?=
 =?us-ascii?Q?5MJOEWRQY7D0lIdhVdKmcFGTPr11eE4WF3xyUMWHKYerO12KlG5egpsE602k?=
 =?us-ascii?Q?MWGS7ZdjH0pZ5mnDOHid45PMMYxKQZ0PAv9LPFmaj10heCMyEFUhRUvHZP5v?=
 =?us-ascii?Q?ZRZjRML/JJ1SGy8WW3pXgwwbg+KEYVig3p11lNLbanXg7U1yr9qbmqpXazGB?=
 =?us-ascii?Q?DFlt1ftkyDTTvzz8aEW/KMp8ydmg/2E/1/YcEPNss4agTvAUQX42//BBNQ39?=
 =?us-ascii?Q?dzM7Dhw6etSefrboo6xaFxy3U8Hm/CHZGzvX6n+Zk2n9BLBUSWNPm4Hi+WY2?=
 =?us-ascii?Q?JJgOxZiFvlwqsTJzseKVs3cz0B1aJh8/0QbMFHYTqDZCP/9Mw3r1R2TIuHBZ?=
 =?us-ascii?Q?AIvkk9ThT27Mrb50ePtM30HISjAdQWKJh5XgDdkPZVt7NjqFek00+46O8UeG?=
 =?us-ascii?Q?RgR2xYaOnjAFFDoyWcwlj4gtXjgsWunQAN1HR2GoWvoIXFT0L58dh7e6qxna?=
 =?us-ascii?Q?jMMzXO9tXXyO/vdJQMYO8/qnevOFB0zdBUZzsAQmHc2v60rP1xznggNti+hq?=
 =?us-ascii?Q?DMaeGqYQSIe9Kx7cF84Swz0EggyzwGr5oG2Bs3FsebxY5En9AklJzewZGBA3?=
 =?us-ascii?Q?cvzMhvxpeMPySfAvPA/h0K88qWb6QQBw/gfXmXodTvg/69W8GY4cfMTvvsOB?=
 =?us-ascii?Q?SKhhKAvj0xCv7xjCHa2oBNzyQyEJcd3QCRi/r6g5Fp8+yDwtone4ma5so5Bq?=
 =?us-ascii?Q?J7OH33BKhw1yNkUL4nDpeF6x+O+MMMG5TVh7LrFaxkx737HhgN2f8uIVMJ2z?=
 =?us-ascii?Q?4vG6uQF8aEFXmSCQ8X+JSqwL0KTunN6ccQmHxwR6EVbyReW+hAhXtQXrOrLL?=
 =?us-ascii?Q?a1b9JdJVfT13/uKNbm4JiISY0RLH7+yjxaL9230sfwy3fm7z5rjMBWna+EzI?=
 =?us-ascii?Q?7jC3s+McWDgmrIEmZhghHabvtXjtWg+818AM7TP724XxC6saHnqVD5KRdib7?=
 =?us-ascii?Q?oCaRnue6wkAZG020t6Pu6/9ghN+FcmtSAPH5WmsJ4ZZGOjBKjhMG3eLsV/sm?=
 =?us-ascii?Q?gPveRLZX/+FbUKBqdj2JVejtixquAWqKTPsIOReig+12nwSZ2AJ2ooD+ehM3?=
 =?us-ascii?Q?6u0LABvVGQDZUe7tCit2QrCR1017tC79bYbiUqCbszU32fh/PGOhk1eBkukv?=
 =?us-ascii?Q?samrrkli6uI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2rHG/Pv7blcdoawDYfiGInclL3+BllQxm/vq7oXIFnpkyWT/e7vGzWnjelPQ?=
 =?us-ascii?Q?+8PJBdfl2lxa2NIS556Edxy8x0C6FjQh4jFVqXVfBfYVK/UNHVttoWsnEazN?=
 =?us-ascii?Q?Nrk/9QQxtFLxdpI6zsFKhgXdmMSmKSQU2bkZhZ4HUskv+en5YTvFeRD0Pm+Z?=
 =?us-ascii?Q?CSF5qgpz6ZwpyeKxQ+g2pa3fSJSiqvfYqkGNmFU4t9WwpH0TgXZdKycJ2QPe?=
 =?us-ascii?Q?7yLwfQ6WaTxpcFULakUlD/suW0EeJr2QL4zcDAfuEjMNTinQOetj2QXJrLNN?=
 =?us-ascii?Q?YGiJLkwv+TZHMDGp40mNRpWGy3kXfUhY/cEc+unjDn7BoTOimrs7uMWewwq2?=
 =?us-ascii?Q?4wARCORNIJJFbGdad8I6jXQI14YaYE1Yr0tDoJH6XGyksCOY3daAchgYM72P?=
 =?us-ascii?Q?zLbVJX+Tgwi5RMg7aGsfg8Hm9LOB0vnxMVktsnrw037o4UNjesa5Pn4kefcX?=
 =?us-ascii?Q?DCBLLM9h0w2C7hfpOvgtO3mHUX1e38tv6ypearT+qXPpftuDhqrC65hfg1kb?=
 =?us-ascii?Q?whLoGzZHN2ElCdCrLPjiqJxU88W/GWJMhhb5XNv78pdwvuX/C6fH0YKk+SrY?=
 =?us-ascii?Q?fFosfNWHY8NOUz69WfOCDDtA5gK6/iudEokUHHjn1jg36ZpIlxwCLp0O3hwt?=
 =?us-ascii?Q?4ZFBwXD1JeFJc9KTLzD4AGqEjha2Abgq8SzB2mJLVqHLaan0ueRnMnri4q4D?=
 =?us-ascii?Q?SbUMKUn0b1cBgBGwEKzXe3IunDxd+D8ovUrMv2UQvX23CtdbqZsXiq5Zf/qe?=
 =?us-ascii?Q?KhwhjYVhgtYJm5tQddYuRO51glxRRzY/qa0eWsbFDROXW1cDZ124u84MBgWO?=
 =?us-ascii?Q?zVXapzQqMNZgxBHGIgBgKHBYBvykCX8CcYd7p9MY1pJ8skX8RRiAjanauord?=
 =?us-ascii?Q?uae58mv4Ec59xGZG5hjOSVrYSkn9bEo8Ti051RP3MBUm3VGUpDEDPmuZ6g5i?=
 =?us-ascii?Q?37QNdrtH/HzbokG6uDQEQSo8zlR05P4ug8UjVzGm/tYGjU37jpSWp8O8Ft/7?=
 =?us-ascii?Q?fF/FidnZMGwKoigfXXCaYDRl0Xyk414aYXj7+q8+PUHpeSYNbL3dWPHU25Uh?=
 =?us-ascii?Q?qwzXZIcK/F8EVZ9MV9YqPyFXCR4hpyHBUgIwPCyLwuzqCx3eInxhUm2PFTZY?=
 =?us-ascii?Q?2t55gF14ti609K5ZYdaz4Ydjse+qGUUcQRP/ZGkamP856wLY+I4HIb4NE26B?=
 =?us-ascii?Q?xKFsn5eLnqoWkBW8eTpesFkqN67RxtpOYWvXHbuq4/W4bjy7BhxuhrHY1DYF?=
 =?us-ascii?Q?LMNYq8y4FsgPiwNZr887lGkHR0b9b3SOvnKzHULKmglWy0FSGJwS46NMf/0B?=
 =?us-ascii?Q?IR0p5TAWHUgA8oIzzitXBLT6Y+r/NA8h8MCzxx9RSM2mwBr5kO5MdoDqOAqU?=
 =?us-ascii?Q?xjr47JTghgeD4NBSh6ejA/dLArHJax5B1SwmyvebeIzMEZIhuyCYdkVUqHRs?=
 =?us-ascii?Q?kqpRXLaThWJXG2pFHcDSCn2UFgqLWONgG9fyXhJCTubHUOjzMYCXM+08Vxh1?=
 =?us-ascii?Q?8JuG5O+dE89+00UuI6NG8ZnDdH4GKhAcTuI20kb/3RQvmcZaeZ6001tTgO4N?=
 =?us-ascii?Q?fu8kQam5BlTPsnZqIj3DdlzXZ41f0MnizwjQr6nbSef6DdSG9F7WMWVtDBCW?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZKM+0t7SJkN33AFlPazllPWwe4N0SUBtQwJrkmfgnDzlqH33NW9lbqR2a1+VU0CuSSXCtiFQEHSm8LwcSEG7dUUGn3ih1i12orJsz8C9STTbBIMJu1I5cCPKpwwerECYAczfIxSm+JxHwvAvuRKXJJm9kKpbQSdsorgt7Ig+D1XDEoLLMULGsIhb8Z2NQCKZPawUpFRfj0HnwZLFFfQT2+0ItDbsGbo2Z4e/U61bpwFD95NPj3RbL2x+bVBW9Z6RHpPxT3kgy1SlCCfFho1N/vtUsxjI6WY3gPZnrivmviLav41ZuEmV9+VkiZw6vCB+ctOlruZ93eNRQTIPj5b3IP803zdPDLqjqQPqWSjyt7EglAoJkWMLAo+uu4eRYx5eJM2WN4ZPQ0nWXG+WHB+apvSdTxqwsydkMTRnxoRnzuQix3hkPqComEFx1H9N2Nh5oqxehEgA9zLRQObpP4rQIFZ1wxKmU3bEFcPJrMMrHf0ovLYEMW4UTv2jUxTFEcX7JPXCdH0pfWV3bUn3M2wJzEWCiqgkNlik3qnsDgUdTBge2yFrKUnJtVjGPdf7oV/0wFlgftOPLAJRc82iDrjtkRU9BIAgOAPUctXRthyvnQA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d11626-9ff9-4828-816c-08dde9f7f32b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:08:50.4465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0ERLBidQCVNs/EeCQevuRr307Fs7F3feJnVDQKoXhItSlw90xhHPKyidG58Itm7YiPEYNHbc+NJnwBlV2BaMA66KZ/Ty3QRj+0xN+p7zbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6ABE13187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509020081
X-Proofpoint-ORIG-GUID: 6XKz3F9jXQKGpDaEYCmH6LmzLsRXaNg0
X-Authority-Analysis: v=2.4 cv=YKifyQGx c=1 sm=1 tr=0 ts=68b6a61b cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=M8a9pf4_m8jl-BS7tPkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfXxbJnkYuJeinl
 hRDUyK3oWlACv+VxT2YsWFwFtco/zmQ8YZJZA2ClpV4xDs/CP2gyGpG22ecWdSdNYpRzB4ejj2G
 0FOV+lcVzx7++BN4kuhgGbISETdRNcxT5cNMjeVxpQH15vTCwmio7yLnNDyZ5WdYEI+tgriZuQO
 t26Ld/fBOZydhNoq1jTvqpHaIcjjZj9SLw1UJtZzjI742ertb4/xfgJtZJoH4KsRP96HW1xsI1h
 7XgT83uzrAPHK++HN8hOtSQZ1HqLrH1fNwycXjKEvFqhS8BwOJKx3MJHZX3bO09453BPCcxLuWt
 gmYJrAUQlfk8kIVQ1QD/XJBNhBqLw9DTAWIQVeQEqwSZRMxO2hh1O8JA1FbCjolboTLGKMgLVum
 qaeMAIe2
X-Proofpoint-GUID: 6XKz3F9jXQKGpDaEYCmH6LmzLsRXaNg0

Performance when clearing with string instructions (x86-64-stosq and
similar) can vary significantly based on the chunk-size used.

  $ perf bench mem memset -k 4KB -s 4GB -f x86-64-stosq
  # Running 'mem/memset' benchmark:
  # function 'x86-64-stosq' (movsq-based memset() in arch/x86/lib/memset_64.S)
  # Copying 4GB bytes ...

      13.748208 GB/sec

  $ perf bench mem memset -k 2MB -s 4GB -f x86-64-stosq
  # Running 'mem/memset' benchmark:
  # function 'x86-64-stosq' (movsq-based memset() in
  # arch/x86/lib/memset_64.S)
  # Copying 4GB bytes ...

      15.067900 GB/sec

  $ perf bench mem memset -k 1GB -s 4GB -f x86-64-stosq
  # Running 'mem/memset' benchmark:
  # function 'x86-64-stosq' (movsq-based memset() in arch/x86/lib/memset_64.S)
  # Copying 4GB bytes ...

      38.104311 GB/sec

(Both on AMD Milan.)

With a change in chunk-size of 4KB to 1GB, we see the performance go
from 13.7 GB/sec to 38.1 GB/sec. For a chunk-size of 2MB the change isn't
quite as drastic but it is worth adding a clear_page() variant that can
handle contiguous page-extents.

Define clear_user_pages() while at it.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/page_64.h | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 17b6ae89e211..289b31a4c910 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -43,8 +43,11 @@ extern unsigned long __phys_addr_symbol(unsigned long);
 void memzero_page_aligned_unrolled(void *addr, u64 len);
 
 /**
- * clear_page() - clear a page using a kernel virtual address.
- * @page: address of kernel page
+ * clear_page() - clear a page range using a kernel virtual address.
+ * @addr: start address
+ * @npages: number of pages
+ *
+ * Assumes that (@addr, +@npages) references a kernel region.
  *
  * Switch between three implementations of page clearing based on CPU
  * capabilities:
@@ -65,21 +68,35 @@ void memzero_page_aligned_unrolled(void *addr, u64 len);
  *
  * Does absolutely no exception handling.
  */
-static inline void clear_page(void *page)
+static inline void clear_pages(void *addr, unsigned int npages)
 {
-	u64 len = PAGE_SIZE;
+	u64 len = npages * PAGE_SIZE;
 	/*
-	 * Clean up KMSAN metadata for the page being cleared. The assembly call
-	 * below clobbers @page, so we perform unpoisoning before it.
+	 * Clean up KMSAN metadata for the pages being cleared. The assembly call
+	 * below clobbers @addr, so we perform unpoisoning before it.
 	 */
-	kmsan_unpoison_memory(page, len);
+	kmsan_unpoison_memory(addr, len);
 	asm volatile(ALTERNATIVE_2("call memzero_page_aligned_unrolled",
 				   "shrq $3, %%rcx; rep stosq", X86_FEATURE_REP_GOOD,
 				   "rep stosb", X86_FEATURE_ERMS)
-			: "+c" (len), "+D" (page), ASM_CALL_CONSTRAINT
+			: "+c" (len), "+D" (addr), ASM_CALL_CONSTRAINT
 			: "a" (0)
 			: "cc", "memory");
 }
+#define clear_pages clear_pages
+
+struct page;
+static inline void clear_user_pages(void *page, unsigned long vaddr,
+				    struct page *pg, unsigned int npages)
+{
+	clear_pages(page, npages);
+}
+#define clear_user_pages clear_user_pages
+
+static inline void clear_page(void *addr)
+{
+	clear_pages(addr, 1);
+}
 
 void copy_page(void *to, void *from);
 KCFI_REFERENCE(copy_page);
-- 
2.31.1


