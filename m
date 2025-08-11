Return-Path: <linux-kernel+bounces-763106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF17B21044
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 367E668697C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE662E2845;
	Mon, 11 Aug 2025 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FgPzfgiZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gN8MXyst"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168422EE5F7
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754925519; cv=fail; b=nJUmMw1zEQe7y0VWO3bG6hJKnAGCC6gucqICswXAlJ5CgYOcyvK29fSUD8sggo/S3kKPINveSqK3DZmgDjv9Q34hKCV9HqGUo+wp/xQPZtFcqF8LqtJekW7W6M6zHSq4FqNsqpHzmqazRxwFdFbXPe2nqopJwWze7gsWHFn0yPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754925519; c=relaxed/simple;
	bh=6ulqcu/UXB1wvXkjFca+Dsa7P7asMInVt6MFu2Tq1DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u98TU0k38X1yiDXq8Za9c7hGoWqj9dtouLF4Lc7hiAbpL8vY3l8qX08WqfeGRx9GcJ+2mOGT60OSxHYD9O8a9UwVWcuVcRTETIAnAfAaZpOpaKJ7ybl95W3ahlcwKkb256FE1TMnuROPL9mwngWlEEObeOaZTkCvdmKU5aORzOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FgPzfgiZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gN8MXyst; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BFEvkA030669;
	Mon, 11 Aug 2025 15:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=WQ+Wv9LFZZ8RsHz9gc
	a6JgVZg+h2vUj4uSYVMvsaLX8=; b=FgPzfgiZtwV6mF9em4TOSpLtmFTePQafx0
	/fkaFvhfCfVuC5nuClx7QQnt4nHzkhTSuSznH/GS2Dw5EYIom2S8M65y+STL4P93
	1p3enZmncaJR4/EidEUMjFdPDIrTtVc+S1nTEfEEL1Cm2mEq6JFNRgK/O+qZhRYm
	uha1Sn1aCpE+1WtQy9IxkQH7FjKjz2xS3aBEL0DNoMWBu8CtboF+YW/2mggmDZAW
	I/KAnfNaONm9DIAWPhxRv5M4KRSph1xxvGpragUCZGnATZRg+k+4SSsFQ1tGuHc0
	S9Po7F5UY8a9Xs+5uaiavy7xLhZ7dUkwdJrBxqZYmZLrNr0EufKw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dx7djsd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 15:17:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57BEFFDr006448;
	Mon, 11 Aug 2025 15:17:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvs8hxww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 15:17:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSM7bgZLgKgiwPcsIJs9nQLwacNv1k79xuaQnIAM0/DXgUMx7Fcy/ZINJ4joDlHV8dB2IRqLp3f5JS+YLK4bCOfCG6wHY2zJENfiTHV96EuLafvl7TNd/JcxQxPbA8I56ZilEVJh0NiwjbOD9LULtQFPQgyxM5HCyvvA+/2Uz+1Akh6ERZcnoy/8j6kgRFAj6aX20TjY2IdaUF7IpsGGeaVx+gOnpvp77Yocb01l3RCa3KAuSAgrbCgHkNlVl2MJZl/DKiRqa03CXYSvh0qN+e/kHs81QF8fVdEWW5MMZIbxav8tVsvHU0KcQhOnvibOCMu9UCT/YjgGRkhvpVNF7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQ+Wv9LFZZ8RsHz9gca6JgVZg+h2vUj4uSYVMvsaLX8=;
 b=PGHxvxCVf6bNc0A8d/ts2docyssFIsi1kdqk/PkmMWTLbM8QltO0/REa6i8AeuKwigJhZe/6gGe61UN6WCI/O5Cj3XaW4A14N/DLJrRQ8tuoh173sCGpWRbbF4qAjXdkvw18GRjzXGZ48nZpD0tFlTftAQ5gkjfv6klNmIbXcQX7Xian0cazViv9DQur9EpHyLkR/xUOIQfwLRoyN0gyR1WshSedw55rqoymuJ2tyPvK4k31qXiFajOkXcr6PNPHHdq+S8cj0wLU4olQB7rXjTl1Ogmh0XGOUZ1i+hN0xm5YOilIHbfWfkiakM/uELrppkTkPei8Xg6GmBt6w+jRIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQ+Wv9LFZZ8RsHz9gca6JgVZg+h2vUj4uSYVMvsaLX8=;
 b=gN8MXystLFAidHdYb0oRnmObjxYJLq9IA/f6S7/lLm/QKv156/3KCJpO7Z/mq+jDuAYEzKHYMrSRFuNXSvpFNRoXNxA22+5WSvD6EA5esj0rVRbEZ67kwXd+VBU7/+nRyClGNpTwU3vCtSkQ7EZJOklVVm01sYKzybiPVQUEMwY=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SJ2PR10MB7112.namprd10.prod.outlook.com (2603:10b6:a03:4c6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 15:17:56 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 15:17:56 +0000
Date: Mon, 11 Aug 2025 11:17:51 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        akpm@linux-foundation.org, shikemeng@huaweicloud.com,
        kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com,
        baohua@kernel.org, chrisl@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm: swap: check for xa_zero_entry() on vma in swapoff
 path
Message-ID: <efe3aogdw5wxsn46xyy2rrqui7oghyi7elam7aiv3c6o6hsfbx@ee6dayztcy2x>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Charan Teja Kalla <quic_charante@quicinc.com>, akpm@linux-foundation.org, shikemeng@huaweicloud.com, 
	kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org, 
	chrisl@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>
References: <20250808092156.1918973-1-quic_charante@quicinc.com>
 <dedf7436-9afa-47f6-b676-88f2dd8b638b@redhat.com>
 <f008107a-2741-476d-9e32-ae9fc0f81838@redhat.com>
 <29e080fd-5f9a-4760-876a-a6ccef33129f@quicinc.com>
 <fec5ad61-7caf-4076-ba81-7b454ec7018d@lucifer.local>
 <9178bf98-2ea7-4ad8-ad43-cdcc02ab863d@redhat.com>
 <904f85d0-acd6-4f47-ab45-fbf18b80f1c6@lucifer.local>
 <7e7bfd05-434c-40b7-98ec-8ce352a8147d@redhat.com>
 <fd35dd5d-95cc-4c37-bf72-52a27fe822ac@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd35dd5d-95cc-4c37-bf72-52a27fe822ac@lucifer.local>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YQBPR0101CA0255.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::16) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SJ2PR10MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: ea22ead1-06e1-4666-2a24-08ddd8ea3f86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JbFbulVWBld+HKr9z/zS6YWGTqDDeMEhoqmBLgUB0WdJXu1WMyzFeJBuLow/?=
 =?us-ascii?Q?lJLBceQoE07ai/CKQyeRrWrt4vUxf2Y2PAjWjBUWjcaN4/mppOUix7JgDmHM?=
 =?us-ascii?Q?5I+NV2dfR/6wN7M/rvAhTCSYqw2/6iGbhvA7Zh3zuUaEUczOQr/Sv7fRp8y7?=
 =?us-ascii?Q?jreGTSUZjp2jzvTtMnaz3A9+q5TjzWg9NZbq3Oz5ZA0Xvyv0M9gt2m7b8pyj?=
 =?us-ascii?Q?ABHdpVekTAfdFMhsQ2AJhIjD9iQFJT5OJCVioSXAhvi4Q/cxgh6c/EeVCPJO?=
 =?us-ascii?Q?Syv6XWccySH0AahaO1D94HT7RnojbayngfclWfyc7Dl8gNdtEW2j8h8M0nwU?=
 =?us-ascii?Q?dgDYD/8xhlcalAXg9wt0ErjqbWQvwGLX/hcbvCOEGnvTic4bcNErJNcCwLzF?=
 =?us-ascii?Q?XKFaTPaFvdl7dc9yNlwmXFGoM1bBJiMpe5Pbk//aRiGZbd36I9/zpEywgM3i?=
 =?us-ascii?Q?iTEeyeAGxd0640k/CvUAbsFaQFCws2IVViQSDcocllgSXhTMWqC24n8jbGaM?=
 =?us-ascii?Q?ZAAIUacl3NZt07pAEOYW9HYQRMyjKlZfdHnJqgYoQQnLQM1eyKmcOmdbWPn4?=
 =?us-ascii?Q?8AGIXGmj+qFMq3YAeIoz1ddEsMcYf+W32H2LkHmkLNOeE1j/4MeJLIW5C3r2?=
 =?us-ascii?Q?AnJQ7VK2fLNfvTdLN7my71taOMl7YjfSMziSUKCA7XV7GFQR45fnmqjy+D7i?=
 =?us-ascii?Q?dKBmC2uP8CiNT+zAF+D4MphSNrm5qNEemUZuqu2vEL/BgVKNNzAD1mTthOyP?=
 =?us-ascii?Q?vGSjFoDBCXU0E9hIWy57wQs1CPC4rNIQ7gl+mydf+Q6l6NtxAMWAKg5YmJs6?=
 =?us-ascii?Q?AYlDrn0DLDPbCpQlA/Ds+v2PHC4HJ2B5Jgwitky0JRt4j74BA4zM6pIhVmOJ?=
 =?us-ascii?Q?k/1+8m/MovYumWYb8BjeBKAmK4VYna/YWeddZOaKNcbB4f2XQXAcfJSxpYrj?=
 =?us-ascii?Q?WjOqUyexVf+R/VyJ9sPlyBEmjBZDoDfKAI6Ot6ZCiileUlCuHbHILiqQcEAu?=
 =?us-ascii?Q?NJq+o1r1af7o8gAD07L0En+qBYF8G+GC6A3xijGK1PxCLWhgfR91Qcz/U0L8?=
 =?us-ascii?Q?Ppyh/gVs60c2mBiTXMhDjCGi1OYm8GN/2owizjn/o0ANLFFoOIfksUIxrP6m?=
 =?us-ascii?Q?LmH0zZ60ijdCosnD248V2eayi7abF9VBWpMK5nFR/ipVhHbsuLCurx9g43Tg?=
 =?us-ascii?Q?J3TleLLbHQCvaxFHnMt9f557zUDbL/wrBZ3FzfaBKJjSgwcZ3Rbklxq5g6i6?=
 =?us-ascii?Q?H2OWjaq972rUo7E7l4Za+xW4cbmv6kYqvrMFRGDfjM/hs3SSoUA1VBQmAFkx?=
 =?us-ascii?Q?fq1grQ0kQnkd/Rnn91V5NBhVoQCPjK9wMbRestZj+x/6KO9AcoIK/9DFiiQo?=
 =?us-ascii?Q?oGqSzgUiuLpAjMbuDWB/Q11Z7+4I9e2IVsASHxg4N/kaaNs317KNatEbmrfi?=
 =?us-ascii?Q?+lGsKjedxfc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EPNYklnCh9hjV9YQLF5LxfrC3sEmFx+vnh4NWwCwe+SIuYKYaqVypGCfNuK/?=
 =?us-ascii?Q?A3MPDHnCyRa5wKNHuBoZCYGP9HsVJ2KZ386lo8LGboD1R5lzylOo7JNXG0fa?=
 =?us-ascii?Q?cSafEdsGampz/tcQ62qhKPHWvUGLIXadtorORg+s8O0p8IwHuPvSbZVHhxRL?=
 =?us-ascii?Q?RhYm/RvfYG89q1aBB77NNjan0reXrfkU6A0K4zj4H34sKhCWmrSHAIwaBIHE?=
 =?us-ascii?Q?0YJH4eKgTqqhBymxNH5SYSAwpY2zixF5+Du7zWmUBMIXCHigYSY+G1Jt6MOw?=
 =?us-ascii?Q?6WF+lHW7QW/p+q7tq0jvk5e/CmJRaP0BPH/ossHgWyrcBjogVlXYB3Jta090?=
 =?us-ascii?Q?alKMVuwrWOoXfM1i0zd28GnNcw8WNHNv0IIwRVSl1rSrecJtgMk7TD9QVtQD?=
 =?us-ascii?Q?jh0i3NfnRm+VSQG4vqduNXC18rtD2C5OIrywCBrvc+V5Kht4FlM9KZga1IpT?=
 =?us-ascii?Q?ujXYtZ6Yu20gDKJzC9pI/czDm/nb3vjo30R4tzUa50ZoB46i47Djqhsh3mHP?=
 =?us-ascii?Q?iUZQd9SUsTRSWYmT4aQYi22qNYZZfDfliOeUbfuwU1nBc/AA62CXsgVojIop?=
 =?us-ascii?Q?a+vDkeiHuhgbzbSBD86qB4zHp/BIq8Xfzy2UJjm+OFRcQQskTu5sPwRsscxq?=
 =?us-ascii?Q?bFva5TwJThYmBpkdoQ9eAkvSMHxRDuX1xjaqW/srm/KxinD/njIVG5u3cZ4H?=
 =?us-ascii?Q?D2Ctthv1gxI5r/1EQRiFSvPUcTXd0l6EZmWnnXZ1AwbMSqUmPZT6pLZAuLsO?=
 =?us-ascii?Q?Q6M/wFchEy8iUyDq+YDYPJwvij51VU+arfsjYuFjQNGpGdCYAduzTwmyfpHQ?=
 =?us-ascii?Q?iZx7IFhdXRo2pZbM6DnLbc2fp/fVmsbozsGKW6l0uLW+06/t8BqlbYjXDT78?=
 =?us-ascii?Q?yRTUo7BQLVxwgeIa1MAGNySwSQ6D9h8gvsgD+VIgbz5qNuy83jN9gM9RQtjj?=
 =?us-ascii?Q?MCNwEmnZKbawrZzTdAT5Vmwfbwy/EtysN6fJFLJzb5k+BjCb864Ksvx4A2+t?=
 =?us-ascii?Q?zGwJqyGZ3qnjSdgXpiYEsDNGWmEfu4Zp2J5CG6CmthutqU67okng2ADUBdHz?=
 =?us-ascii?Q?Xag0JIsnQ97dDPzW6SC5136hTKFH7QH1B5xpgONJiuVSJXvy5rC6a6JXtmoM?=
 =?us-ascii?Q?Xt2g0vQ1cZ7NzP2Ezvyzy+7E64UkqsfDPAgrjHCBiCy24ipf5/5XX9p4VQlh?=
 =?us-ascii?Q?JMfRG9VbmPK5cW8M7Y6h1b05zvbGlqyy2aDQxdofcrH6bYNpDU1nZm7APTr3?=
 =?us-ascii?Q?Dtq6yiOu9mKlJcq7eo2OlXl55qMVvUv4HvkyfPum99nqd4qj/ueg6rqBH6Mg?=
 =?us-ascii?Q?q19LO2LfORfQB9EyJwEr6C3kin65t5BPmCv2P+rL4xpirrPuRkUTQ0AjPpFa?=
 =?us-ascii?Q?u5EV4e7XTzxP0+uENewljPCGGST4exy3aXSYnggUrK4z4QqelA2lxubJI6Jl?=
 =?us-ascii?Q?lWDFVebS7dFV4+BCQ2fRRAxAGKkE5CTS7CEHy+edOg9++ZU4FfR5dQPDxLEm?=
 =?us-ascii?Q?Vkpo5xdmjK8CNKDAB5BDjd6Xn+IM0tbQsDQzCzDJekVX9peeIColW7FblfEO?=
 =?us-ascii?Q?0QF1lIrNkjlH3MaQm9OWRLR2BFqQ/ce2s6WVADLi1ylyHXA5X/gzwf/nMdgd?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FT3MDK5On+pZceVfctTmGcBe48oRmsyPvGYNlGdvA4jH1hvdqu2Qp8cIOFuKu4lAXvPQSkDwNdvpCDejexx34kyCmqU0KKSIyWqLzxFDOR8GyRKVBnNOTChubDf/LcXQhaE5jOy3xBUIh5oLFYitqxDeFuhD9+TVfL8rhPYU2wYq+UWhW8N14Tthk7aW0tY0z5swF5LVqLqra6cd8J3VKyDzeVi7HUyrg790vV6j2E3C85QVH1BJ6w0qP7WGHAyLNT74JrnA4A1v35EetI2aojbfF4Bt+yvw+NBm3USS7yOjMMutky6gDk30fzHzdw57hBcnz5+x8dzbhcGuJzzOSWKs3iC63AaAwYMKPPiDg5VrISEa93hBfEgcdzweEvc0EzvzzsHNh/aNGmxf3pDnXqGzM4t51eFDRWistrUkpnXlNyk7EpgAHsHRiDWveQl3DEvo1FywDHrQI7rHlW/FREAwBzPr8EU9CNCzkqQGwO0SQSI+ZqVqrM4WJuApI3QmWbS08Wd9dmUFqb4XeNGR/7jnMiFN3tKAvCMOmsTiIiK8iDkXTYD8SAI1j9rfuduA/mWYuSrszCSZyDJ3wwTn3ki+yBdo/pVQNKxPAN2P7AE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea22ead1-06e1-4666-2a24-08ddd8ea3f86
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 15:17:55.8615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYDc8Mr08PjCCmaLD4ME7+zb6GcLyUR09morl5dc4fPHNieBhFD5PXR/I0Asz6miflRKkaQujB9slyxqg0h/UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7112
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_03,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508110097
X-Proofpoint-ORIG-GUID: wIA3frvIbeZ3hZQ5Ayu7IZLOwLhHT95y
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=689a09a7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=-ytPC1BM6wVri4fdnJAA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600
X-Proofpoint-GUID: wIA3frvIbeZ3hZQ5Ayu7IZLOwLhHT95y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5NyBTYWx0ZWRfX2WorrhOoZE6t
 42vCP26yOJMTFDacozKamBQH4CqvGg9T+AFpAIc+yTNnH3x4eToKOPsrsVT2CodqQdW4ClSj47l
 MTIvmAs/JDibX9LqO0Umqfx0eXN2WzH4NTONLTj6+3k0sm//ckxzhnb7i2sT6XyFU9qd0ZiYrIg
 gYeOSU6AiLGEE4+B/+Al6b1NMxTxX4XZXZ2ttAYcw9/KYtHhv9m+EAWHzsj894T+OgYlFXHXTHa
 xcEQPejXpi2jgHU7QkVxxlXD7t8g+WYGH4gWhA8F+J7DsvfrZcliuW886FyxFI5O3YPz2lGIWd4
 EsVtJWHNPGZHJrk8vcMF89b5oOZLDuAc6SPhgW1W9SMF5CWn05vPp3snMPOSh6zWoQ74UjxR28T
 qCmiIUIojuJxtuDwcjDoit1+S7wdVoKejEBUakPPXAyxHIRURaK1oWGDltTRCRLyk1C6aAH7

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250811 09:22]:
> On Mon, Aug 11, 2025 at 03:19:53PM +0200, David Hildenbrand wrote:
> > > > >
> > > > > > When registering vmas for uprobe, skip the vmas in an mm that is marked
> > > > > > unstable.  Modifying a vma in an unstable mm may cause issues if the mm
> > > > > > isn't fully initialised.__
> > > > > >
> > > > > > > Is there anything preventing us from just leaving a proper tree that
> > > > > > > reflects reality in place before we drop the write lock?
> > > > > >
> > > > > > When you mean proper tree, is this about the your previous question? --
> > > > > > Shouldn't we just remove anything from the tree here that was not copied
> > > > > > immediately?
> > > > >
> > > > > Commit d24062914837 (" fork: use __mt_dup() to duplicate maple tree in
> > > > > dup_mmap()") did this for efficiency, so it'd be a regression to do this.
> > > >
> > > > We're talking about the case where fork *fails*. That cannot possibly be
> > > > relevant for performance, can it? :)
> > >
> > > I think it optimises the overall operation, but as a product of that, has to
> > > handle this edge case, and that necessitated this rather horrble stuff.
> > >
> > > Obviously we don't need to optimise a 'we are about to die' case :)
> >
> > Right, so my original question was whether we could just drop all stale
> > stuff from the tree before we lift the mmap write lock, leaving only the
> > VMAs in there that we actually processed successfully.
> 
> That'd be better answered by Liam who's more familiar with it.

The short answer is no, we cannot.

But some options and questions below..

> 
> I think it may actually be difficult to do on some level or there was some
> reason we couldn't, but I may be mistaken.

Down the rabbit hole we go..

The cloning of the tree happens by copying the tree in DFS and
replacing the old nodes with new nodes.  The tree leaves end up being
copied, which contains all the vmas (unless DONT_COPY is set, so
basically always all of them..).  When the tree is copied, we have a
duplicate of the tree with pointers to all the vmas in the old process.

The way the tree fails is that we've been unable to finish cloning it,
usually for out of memory reasons.  So, this means we have a tree with
new and exciting vmas that have never been used and old but still active
vmas in oldmm.

The failure point is then marked with an XA_ZERO_ENTRY, which will
succeed in storing as it's a direct replacement in the tree so no
allocations necessary.  Thus this is safe even in -ENOMEM scenarios.

Clearing out the stale data means we may actually need to allocate to
remove vmas from the new tree, because we use allocated memory in the
maple tree - we'll need to rebalance, new parents, etc, etc.

So, to remove the stale data - we may actually have to allocate memory.

But we're most likely out of memory.. and we don't want to get the
shrinker involved in a broken task teardown, especially since it has
already been run and failed to help..

We could replace all the old vmas with XA_ZERO_ENTRY, but that doesn't
really fix this issue either.

I could make a function that frees all new vmas and destroys the tree
specifically for this failure state?

I'm almost certain this will lead to another whack-a-mole situation, but
those _should_ already be checked or written to work when there are zero
vmas in an mm (going by experience of what the scheduler does with an
empty tree).  Syzbot finds these scenarios sometimes via signals or
other corner cases that can happen..

Then again, I also thought the unstable mm should be checked where
necessary to avoid assumptions on the mm state..?

This is funny because we already have a (probably) benign race with oom
here.  This code may already visit the mm after __oom_reap_task_mm() and
the mm disappearing, but since the anon vmas should be removed,
unuse_mm() will skip them.

Although, I'm not sure what happens when
mmu_notifier_invalidate_range_start_nonblock() fails AND unuse_mm() is
called on the mm after.  Maybe checking the unstable mm is necessary
here anyways?

Thanks,
Liam


