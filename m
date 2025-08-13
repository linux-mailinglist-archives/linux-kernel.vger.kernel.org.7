Return-Path: <linux-kernel+bounces-765989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0BCB240E4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE38188D533
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 06:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A812BEC57;
	Wed, 13 Aug 2025 06:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hamKuxXz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ltl4vNLd"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B2C23D7C6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755065018; cv=fail; b=M80GIeT3xEGkNgMz5YdnmFb3/dFqoKYefKxHsF22KFx4bgqf0+epowNLC5sjflaFJ94iekABe36OAafST5batLD8nj2RcHNKgA4IJFDJNLy+LNX65zKJCBu9GKwYlgeK01Z0F9lpn6BZKjHkQa82uBes08sL2hc5CyyKciy57XE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755065018; c=relaxed/simple;
	bh=A8Ra4LydSWy3Fqzfv2gxlqZDmP3buIglgF/MAhFaTBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LswlIZXVrK6jPxfPpZ99Pfclo51OSwOt4tssFMRd0o4qvcAnOsrTVISGruc4mcvPrdlMaW6xFbhPLZAMlfvNcj+jOBVUqYL7KKHbuEdQSdVQmbhDt8EFfRepZ6umpJZdpFbq6HxSIpS5nXqogSH0XTfBgTZSGVkP20d7M5+jEUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hamKuxXz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ltl4vNLd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D5u6Sl026003;
	Wed, 13 Aug 2025 06:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ZwCyoKvijJJJbGAGhg
	Dklz9UiK7dStITr2tZFhS5kl4=; b=hamKuxXzJIayJ6CnOma8GdOdxzyfu93vnO
	B25BpTfBuc5OO3pRxxyz9yVBrBGzA0H9+z8IiFYHdM2+L7XiHSgBDPJ8qtLbe4/7
	d0mL6zAmX4RxyXUg6g7eq3p4pZbRlJDnNhonq3GPJMHAdHlUk7N2M5unk3wWOvbr
	pDp/aBqUz1lfhi3uT2d7SZP/8XCkjD0JPCYlJsqS4j9mo4V0gjVH5n6LzXydzxfL
	PNeJZqSNOcHxE2fpJ1eGXhkisSMEFa3b4/PzB/GJ1kq0LTGYqpzz6FnRzwigt6hK
	CUg/viyTm3Hoi/VFEBvmUPjYXcrrTJAK00JDdTNwJg3Ssm0c842w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw8eefsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 06:03:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57D4O8Bw009648;
	Wed, 13 Aug 2025 06:03:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsh866d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 06:03:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuZFP5EGsN5oGNlTIjNN9Ct1mxGoL8+Yb9VOizJnOrwOfojTYPpX/nFjTqsAbrtbHGJLVIgFVkhHmKSm8RMKSqMlNDvtHWo4QaJH01+TVvim1nSOzaVqSaU2juUgh8QulTNKd6WpFl1bzHKdgC3aGGqArTmp1bQ1kpw/ddXYlSrEwCm/IB176egrZ27A8onkQCrk0oJdVFcxMT3B+uAvdGtAvQKR+/Aox3xnSS85vbWKqjtrVSA3RhV3ihGv9tt2r7kcAu4IghAWfQ7l/xXUsyGhsBi+zQeAqziE2EK5iNquNzLI5iKSrmoR6dsIAJuLm/rx+zTnlvEPFRWQd4KS5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwCyoKvijJJJbGAGhgDklz9UiK7dStITr2tZFhS5kl4=;
 b=nt+fRyXNEzvqVFXoS3Ov9a52Wc4CrIvOnei9A7komJ/VjFvol9agteGIXCqPmsV4lTCMutYtLD6oWDa6v2ZDEJgnuBRcapX3i2xwrtujkDXLh8IeMtCDe0+j45soq5sSOX5AfeEyFgCPcMdS0q+SbVFf5Stscv+CQbu0tdbOXQxJ4sZ5OodApEV1PrL9rsTiPJVmdBhap0BTlRBe7rZDti0/q9vyItMQwQAfenwHvb9Y5ubThm0VuEEqfIp3wY2IYaLNFca1FTNv+3xp8eRvqs1FTxJ767c4H+eZsxRrMezFJ50F5yNyNQtWjOa2JsYJT69Jy6QItI0ylvIpcr+YGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwCyoKvijJJJbGAGhgDklz9UiK7dStITr2tZFhS5kl4=;
 b=Ltl4vNLdtYiTl+F/sDtl9jdjXDscViuVz3j3uMoBFmro1GBxS36PJcvMU4RH4sOwTK9Lmbv5RiG4uh90HO3hsoeQs+ndg08JM5K0UjGfjhugeChXs2tvJp01sL63VxU7+31+a94e3wkkGT9onEh6u1v+vY0mQKNQm+Qq0lbvjRg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6642.namprd10.prod.outlook.com (2603:10b6:806:2ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Wed, 13 Aug
 2025 06:03:06 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 06:03:06 +0000
Date: Wed, 13 Aug 2025 07:03:01 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linuxfoundation.org, mingo@kernel.org, namhyung@kernel.org,
        acme@redhat.com, kees@kernel.org
Subject: Re: [PATCH v3 09/15] perf: Reflow to get rid of aux_success label
Message-ID: <653d4d30-eaf7-4dbf-8e35-6820996ca491@lucifer.local>
References: <20250812103858.234850285@infradead.org>
 <20250812104019.362581570@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812104019.362581570@infradead.org>
X-ClientProxiedBy: AS4P189CA0052.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: 93dac09e-74aa-426f-ca7a-08ddda2f12a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I/NMkMIhf0heORdWpf8O+6RNwwiL+e2vXLCptgoC+QsFgLNP1d/NUO0RzxJM?=
 =?us-ascii?Q?z2GmPTuFmICUBK4wG/3iQlHSusJvoVeMyu59cH5AoguBxEZSqqiHtMJYeD90?=
 =?us-ascii?Q?9VojAGXXNmTaoBf6PIO5oQVGilC77lPVhN+zFUnN1JtFtQNmjqlBhAwsjgwA?=
 =?us-ascii?Q?ik4OQxP3HR3YaNK95D1wS0OEoDceEgr1Ls64lZP+U1mz0de6gN+jv2Cr6Uub?=
 =?us-ascii?Q?ZiaUW7aKPblsYSQ76phhep9qoTf4VqVpbjT7zvGj1jfqACYS755FVqHyWxFE?=
 =?us-ascii?Q?1EinoIhNDU0NOkX1PGHX2vqh5OSnmnHdYN0B1CelddBf0bGT2xhPJGo6f1Mc?=
 =?us-ascii?Q?kgkJqsxWkgy0mfn7qWCsOSGqE9YrduOFJh9eJ/Qje7Fwm+uDpV9jVNn8/i6+?=
 =?us-ascii?Q?aQ7bkTKozkQfDVIot8aRJF1LBe4SxbHbHHX3MJjKTuUMvrODjlSs3Zaiw0oO?=
 =?us-ascii?Q?EGmN5n3QGsbuZAOvd7aZPQ2hHAkfNZ/ffyNoIFJAaFeN0rw/QcPgbEETj64+?=
 =?us-ascii?Q?YDo9+HagkjIXNUsfh3HrDfRfAFnDTCDLWUScfQr+B/jLh58QO6Oml81dHwBm?=
 =?us-ascii?Q?7QMf3/DOjfwLp2bzhA68U83uJRPHHkw2JKnhfiC2ngmo7pPQNoPQA5dhjBUl?=
 =?us-ascii?Q?uPOie2Dm9vxSMbor91cK7H3WQhpQDkag9x+brG8dJq7ovR2FKrDmSYgEu36s?=
 =?us-ascii?Q?PyqtwsH4fT5DA1Xb52XNaXebPW9CIJgUu6j1IEkeUXuQ3ILZsSCaK/2MwdVO?=
 =?us-ascii?Q?lssx+8eYdFt1PIVQrHBV4Tzb5ck8upKuM5JK0zIcLQf6jC/fWzwvbrwS8WSh?=
 =?us-ascii?Q?lU7Jwnde44KPo0Ok3zoMiL4RXgtHphS3yItyfJDxgVC4ZvpuU7XoTRWWbXgw?=
 =?us-ascii?Q?91UOaIiERets14tWofUrHIjeiqU8HPQ06Tm/4AatBVdypWfqyJ3U1TI8beH/?=
 =?us-ascii?Q?HFWt8N0LhKd+ARfXXDiCuCfKPysVw1o1aeQomfPwCZeKYCDP+fpApqiihe3K?=
 =?us-ascii?Q?remefyVGgoR/m9/IzuIQmFLcmNVE006qe21Ii4VFQRJWse2W9KaOyP709I7V?=
 =?us-ascii?Q?EuK+FuPicq2YN8oDRa314tRRXt2adiKfcjxvYjLUpKVrHhBvDNIaEQrYMmGK?=
 =?us-ascii?Q?rhqOYJm71UfA0glneEjwOBG5MqWA6fvvAUAxJv7a0vlmt+WS4BiucGqLetmj?=
 =?us-ascii?Q?wRNtJiOBbIM2CpZ+UBWzw7+R1DorIJ1lBayhKFhjHlVdTq4YzcAmXKfnZtIt?=
 =?us-ascii?Q?dh6qkIYT4aUes79MVcWZ2ziEXqcB6uapcYS7M5F+7ng0Q32AHLi9fKlhuLd0?=
 =?us-ascii?Q?zYPVkqPJGcYgH5gu1t3d2GZFbDdTgJR+f9hl6DIouHfa5EV7YkG7Kn1Aoizy?=
 =?us-ascii?Q?3sgdyzzc6hBslB9PExgTp6b5MyInXBKKYKdIV0397oV9WZfzs5JDVj28GcIb?=
 =?us-ascii?Q?0RG/A4pRsuY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cSirzqZVVxGLv4EvmbKnTYm23glFyrizhW7m6JGUF9Hjb6qEPEbnU8CfpaVv?=
 =?us-ascii?Q?daPuBrAYh/ReMaG+9ue6f4LGPL8IWCvbRmRlH920qpkl0aOSyxdwXmvfqSrN?=
 =?us-ascii?Q?5guz0f76/Fhn+PQXKj9psMmOyC0kugSJWw0QQiYuIaSKvEHcMAHkhliJbY/P?=
 =?us-ascii?Q?DB7ZrvSQGN4+0C2gFuqDcc8TGhU/K/TsABdKDUlf1wB3SOZVcih/6ffJJCAx?=
 =?us-ascii?Q?FFBixTwkaLafwhROvqQY0TysFB7nWJ2ZgKmqrfQmlVt9d0U8RNKxCi3vCekO?=
 =?us-ascii?Q?L8F8yVzpMpDp1XXkYVKJ/VTE3Bv70J4N4Kd3uVpZpdUFbwUNYY2FhL9/MGG2?=
 =?us-ascii?Q?ujzfXL0yGWVZlXe/qzFyYg0vIFPp9t67M/UO137PRISEBESyakEaxxfGQRZI?=
 =?us-ascii?Q?bRnHNT4ukrzBAX74aiZ7Lhp57d0uXyED84QAcSIQDFttZ7ndNDLsw45CP+KG?=
 =?us-ascii?Q?6JJhj98hyPsi+XbmXBhhV8geyh7xxvmgDaApSmQQkfQetxevENa1HcAYBQOE?=
 =?us-ascii?Q?w/08d19PDf0YLpqrMuSe0hEvM8rnjPJcnGIsl3PtxX0njeO3pL+8qzArgiZr?=
 =?us-ascii?Q?PQ1zqcdJVAr+0owm9FTUdM4ExVz5iAoTGNrlLfv4CLYuLos3VeKYvqW9RJwu?=
 =?us-ascii?Q?iQSkTQtTEI/O1CxMUoJSyrx3xj7EDZnA29pvZNi5ppF680oZXpR99GmGg8gC?=
 =?us-ascii?Q?OSW5GOY+wnUSM3qyIVwMuDo/4G4ylUkzYh1xc9QwOonh6M45ZLWVSWtrNyWX?=
 =?us-ascii?Q?2nQ+smEXexNhkOf91dPsMZyirZm96RiG7yhcSENkzJh18ZPiv1AGiT/oWZTf?=
 =?us-ascii?Q?aSWMIhCUFbXNPPYknXRmQxyTBZh1nXeoG8nVVO/PqhHzhAh8rs2OoImaxDma?=
 =?us-ascii?Q?xQJMo2soflq+sHJbbhEtL5cxRZjw1rwzpMsz68X3cG8oBbyK54jbvfdmTTVm?=
 =?us-ascii?Q?nyA+JmZqoOlk4+JVC7W/USYcnSaJRMJxwLYvrmffvaHBqUTRed700TWm/cGt?=
 =?us-ascii?Q?vrVmq+AgFpytwSqoLwUuE128UC/u747yj/vWylzdUbsUqm20R6AdPAGA9oKC?=
 =?us-ascii?Q?8AtEieBFqEJ0bqp2VklRquLisVu9u2N4Yf2tkJpy5nwzk4yKeG6ggGhTOBmg?=
 =?us-ascii?Q?BmDvhXSbY3FgS2TLD/SEXoK4yNpRfyxx8PKwv/zf0SJN/BfxKqWGCdc2jz9R?=
 =?us-ascii?Q?JJTbUE9qhwtlCZXQvMJLi51EP3ql1gdQwekS7dCgC1xoL3k/Y7jMQJ3AaRmN?=
 =?us-ascii?Q?ZeDrCbdd4UwpZwu14KQS2Hpi4AM/CWWsXs1gBghQeQWJL2HNRHBfQS99jbph?=
 =?us-ascii?Q?5//RpaNSANSFoYhKUz8LRtll7vhE39C/2eRL0T9PuOD0cQeIIB6Qh+qTPWms?=
 =?us-ascii?Q?E/TH1dBLzco+0lNQKHdrStEMR4IsSFOFORFhGSaoBGfQiZF6m1R6K1GlY6aB?=
 =?us-ascii?Q?4sicMezA+FCqpb0FbDakwG32/8F+ebmeiNEtm7pmA7nbKpDRYsXsPDtm622y?=
 =?us-ascii?Q?+0gP3T1B53B7lLNlFEvdHBUfIFeYwLtpzabr2SCdSJPHZ/BILAVVV+Pr8GiU?=
 =?us-ascii?Q?5aM9LwSEWTxi8T/B5E1yd5Uo6gu75rD5XTVJotahHj5e+DY7bev/pK/oJ9Ml?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NJY9S3TUkdQ54RdJ1SbO/R5ythXGeaAU+YYaj97ueHIdpoH4JemUXSmuyEHB7wyRP6CTqg9VYKoC5xvKf6Pt66lfzyTU8WnMSFJ/6SVlyMidZHp98TIBzXhGJnQUGprjQ5nr7txejnsICrdf6U11hvb4ZlEskqDR/iAnoXDFAXuGZQL1Ya2SY8Ze4LcInB6pBcp815XJ69WxGRtbrMg/QYhyUuLvKgzieI1TniN97IDdUY9NZG90FfLiMuFh32TEV1qc7jMCKMnU1kt7KU0CnZcutdpsov6LQU7urOMHuqilwDtXSIjWlubCEq3R0XlLEKzmQp61nzV8iyVjBVDrd5EjzSriwBpeDJpqPunfXF6Lw/155Z1hjK1CsWn8gJyjBJvHxA7fixkXkX8rjYLT/hVcMXL298vJbU/ex600W9xRbbVz+d/ed/KXF77aXXLhsn7eqFw+Py5r90cMvAwLeIcT1oYTXlJMIIC+sSwKRlDvDAYU/d+7goQNiEk1R9X01E6X6l4T93Ou7URXMjIcMwhSLjXqRqiuUnhmEqt19B7VYZmWv+tYxgkP7glWf28isna9NCWw0yIcMRbgb6MhgdSXR7rchuNvtt81lisFY+4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93dac09e-74aa-426f-ca7a-08ddda2f12a7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 06:03:06.8365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3kwRf5T3ywhZStc8AMWELb5JXGRcb4AUR6eojzeN8zLKvMB3Pw6QT66b/KTLPLLTTuQSQhF+dPk/USQHyaBxn1EO9wyjf+AjXyZaJhDROJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508130057
X-Proofpoint-GUID: -11aPOr83xsuhxgSxgI74UUq4j4ViPMX
X-Proofpoint-ORIG-GUID: -11aPOr83xsuhxgSxgI74UUq4j4ViPMX
X-Authority-Analysis: v=2.4 cv=ePQTjGp1 c=1 sm=1 tr=0 ts=689c2aaf b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8
 a=ZForgDttQPJIQX0qw5QA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf
 awl=host:12069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA1NyBTYWx0ZWRfX1h1xBc/2fNIe
 J6UnQHEDyEnbbcOqTz4/z0Sw09ArJpTD7QdI3EnKt1DjHPDI0BGkJXwuRf3chxYmgreGIGquNEn
 IAr1Z4JhpidLj5ZrS9sMFyAGPK4LZbAl9KTxQbYgdWYwaPecDXcZkvYr0b+ghdJ29VW/yglWLuV
 3rUgJtBhevOi3tMMi8ZfjGPH2TLzvRDfxjcszSsM9oP/ia8B4NdgIYeWxfysZ9h3M3duucEZwhp
 zOF8FR4SCUQwiMZzGoEgyzV006fdUjwDyEPMeQIwNvOEsT3OKHgC70Jthx31Lj7wiPNu5GMnE0k
 h7PnCxe7ZgR+arfatE/R7uc0VVik0k212+RAdnZdebDvVLxPuV5J7Zs+fJV1PlDi1hXECgB3sP9
 7oBHaPEALoQ4IWijjecDhP3s+g2BzK43JqGtxrqUvrZ8eYL9laggiRR6HWbJdAD9RpnwHySm

On Tue, Aug 12, 2025 at 12:39:07PM +0200, Peter Zijlstra wrote:
> Mostly re-indent noise needed to get rid of that label.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

This is where a side-by-side git diff pager comes in handy :)

LGTM apart from nit/comment below so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  kernel/events/core.c |   37 ++++++++++++++++++-------------------
>  1 file changed, 18 insertions(+), 19 deletions(-)
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7127,30 +7127,29 @@ static int perf_mmap(struct file *file,
>  		if (rb_has_aux(rb)) {
>  			atomic_inc(&rb->aux_mmap_count);
>  			ret = 0;
> -			goto aux_success;
> -		}
>
> -		if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
> -			ret = -EPERM;
> -			atomic_dec(&rb->mmap_count);
> -			goto unlock;
> -		}

NIT: These leaves  a space above:

		if (rb_has_aux(rb)) {
			atomic_inc(&rb->aux_mmap_count);
			ret = 0;

		} else {


> +		} else {
> +			if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
> +				ret = -EPERM;
> +				atomic_dec(&rb->mmap_count);
> +				goto unlock;
> +			}
>
> -		WARN_ON(!rb && event->rb);
> +			WARN_ON(!rb && event->rb);
>
> -		if (vma->vm_flags & VM_WRITE)
> -			flags |= RING_BUFFER_WRITABLE;
> +			if (vma->vm_flags & VM_WRITE)
> +				flags |= RING_BUFFER_WRITABLE;
>
> -		ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
> -				   event->attr.aux_watermark, flags);
> -		if (ret) {
> -			atomic_dec(&rb->mmap_count);
> -			goto unlock;
> -		}
> +			ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
> +					   event->attr.aux_watermark, flags);
> +			if (ret) {
> +				atomic_dec(&rb->mmap_count);
> +				goto unlock;
> +			}
>
> -		atomic_set(&rb->aux_mmap_count, 1);
> -		rb->aux_mmap_locked = extra;
> -aux_success:
> +			atomic_set(&rb->aux_mmap_count, 1);
> +			rb->aux_mmap_locked = extra;
> +		}

This gets rid of the label but leave spretty horrid nesting, but I'm
guessing further refactorings will tame it.

>  		perf_mmap_account(vma, user_extra, extra);
>  		atomic_inc(&event->mmap_count);
>  	}
>
>

