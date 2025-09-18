Return-Path: <linux-kernel+bounces-821921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5ECB829F0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6051C08812
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E760C235345;
	Thu, 18 Sep 2025 02:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GYzTZU2o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZgTOdBdy"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78062629D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758161442; cv=fail; b=CfjBTwFx2FVyDVsIzp9HhfuIQ5aUMV+gxeXlybqotoBjJ0SSEXSqu3+JLYyxNJ+MQ5rTRIDK2pK0UBYIsWM1t8zNlkdjbAiFKfAHjpHpg05OQ+Emlzk6UqPH2dfbJIC94SvaMDiKUgV4eFJyePaK3IZsYF6zISYOgXCZAHmkfak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758161442; c=relaxed/simple;
	bh=f4oKfVo+pZtv2clnzAvvXU/ur04fFxWd5uo9V4V2YaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ANobxS1J1i2YpoK+92zV0whEFzcF8pooj2bZIjBQiLadPAHLLfc6Cps+Wlf4rhIOqDIrdBvI1XGQZekasiThw333HTdVYGVS78HqHbpzBweVbMVW5RQKGycORBzuo5mA62s4oKpdsOyIdFjAyEC1ksVAbDehqnsmL9qIc59AZOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GYzTZU2o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZgTOdBdy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HM59Gt001828;
	Thu, 18 Sep 2025 02:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=6/MjvYHgYLmAQgc80a
	UAL+t3IlU75iDgIwBDAx2oYCY=; b=GYzTZU2oVfoEgvUjRfQlBnnqqCs2iafiK7
	bM3O0mBrMD4dLUJCA8pub+owOl3GYpC2IcwaIhg1PPjgohEOmCj1j4uBmAP3dbkh
	rVGSpU/Oo3R/FhaY1MzUSfTThWQIMxumMv3Tg0xIvjyHqNN7nvNelve2L0FSMeSd
	ALNqZOB3OmEprWiA/rdO5GitLQ1J/0b/OAqSZxE6RP2+YfeWTdOai+Eyzhmr4/cb
	9L8vPT3WsJ2V/gRPQXBmNY09H2lyc5ZeWnvTZqGOEQ6FkmQRFHPKOtO1GG1BJJHI
	HbGksY9rJ2CqeY5FCLfFoqRPyq0MV/HnUx516T34Rd8mXM8wWG5w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxd2ft3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 02:09:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58I0Ri2Z001461;
	Thu, 18 Sep 2025 02:09:38 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010025.outbound.protection.outlook.com [52.101.85.25])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2eqtej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 02:09:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pcHkf8dXw1ChUjwosqWmcsqLscpKsaVLuresJorzbHIB8lS11fHTma3IGPwY4xaDlANbeVWoJsCygmXCqIAG/3qHDYnNZMhwnr030aE1EWtcLCyMtW3gu7I/XB3Y8rdea9Y6OI/MSkL+zkEW46Efzbtp2SVngRbvKqncjVoSRUe2gRwLly7n0f+qfb7dKljboxAi+vvH/lES0zte/3YCsthzRhnikFEwVfMH3phtLHsOk0zR0OHX/lZEvXeiOxgkSCQoJB1DYCDg10Cc6CxfepYXr48g+asfvMYj9IKstFFp1fTQhKNb8TNfoz2Ia5t9aA+baSeAl2R8UpXNIrUYOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/MjvYHgYLmAQgc80aUAL+t3IlU75iDgIwBDAx2oYCY=;
 b=nGRRvq0TfNTegEwBgRuMW+x0PG4SOXq7Lrur7q2SVj7IFY3TVKsavFwoRzhfI/o53H3S8JlSYP1p+7sjqFEPkDuLChJbpkFmgLKdNuq/O9Kg2HY0EKJNALlWiF6h+GYm42jYsXemvvn1fCkmAdPK6OXtB63M+B5w3wjGx62EAvN7rseOrgVcGW8t52VOq2+yWPgiG6RBdI29HGxR+2EeEGB9jpOYG3wIrjlhSNM/JD8DbTVgOYrgXrAfl6YmZqDGJPwcb45ftaK5TUJyhSXidb/DlFK3q8OSkGMqfwHzbsjuTla4wURP7wx83bwpisLdnqv1ynFkn+5I7RaNLDq9eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/MjvYHgYLmAQgc80aUAL+t3IlU75iDgIwBDAx2oYCY=;
 b=ZgTOdBdy0Migu+YqT7lmDw+kUZqVICVyR4AxeLMrPBTAE0PxwENP5sUUBBYp4ktOenREUXFxl8AkesrQiRyQPJJYNU2/Csk7J7epSTIqRW3XWqYC/iwbmK3YBa2C0hCbUwDry9y7IvvJ8HWFFbZuLuiFDnX3BUhQStaumaLc+Yo=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB6882.namprd10.prod.outlook.com (2603:10b6:610:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 02:09:36 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9115.018; Thu, 18 Sep 2025
 02:09:36 +0000
Date: Thu, 18 Sep 2025 11:09:23 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Jinliang Zheng <alexjlzheng@gmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        alexjlzheng@tencent.com, arnd@arndb.de, bp@alien8.de,
        dave.hansen@linux.intel.com, david@redhat.com, geert@linux-m68k.org,
        hpa@zytor.com, joro@8bytes.org, jroedel@suse.de, kas@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux@armlinux.org.uk, lorenzo.stoakes@oracle.com,
        mhocko@suse.com, mingo@redhat.com, rppt@kernel.org, surenb@google.com,
        tglx@linutronix.de, thuth@redhat.com, urezki@gmail.com, vbabka@suse.cz,
        vincenzo.frascino@arm.com, x86@kernel.org
Subject: Re: [PATCH] mm: introduce ARCH_PAGE_TABLE_SYNC_MASK_VMALLOC to sync
 kernel mapping conditionally
Message-ID: <aMtp0-mV5_33AgYt@hyeyoo>
References: <aMrkoBhIcP37YgyS@hyeyoo>
 <20250918013130.2425537-1-alexjlzheng@tencent.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918013130.2425537-1-alexjlzheng@tencent.com>
X-ClientProxiedBy: SE2P216CA0097.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c2::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f8a06c2-769e-43ae-b163-08ddf6586a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UBRaFG+gd7j7MHZ7GcfuhUHUBur4kcjOcOFwpHyM6KfIr7dvdCM1fJvCtMIy?=
 =?us-ascii?Q?+T+Qvd8NVj+Q5dEjNOm1kJFUfJkcsYt3Fe8cCUmmkL7LU5XCTkRENpnkEUjN?=
 =?us-ascii?Q?KI5Pk+sUg6xCsMCeAi4JgnRfRPhwOei3cPpAIG1qjrQtKnnt5hpTrB3esBoz?=
 =?us-ascii?Q?jZATUIPawPC4N1TCzXYi51FQIJ8JqcCGmh5W+jDO0bxhJJNIpAukw135+O1G?=
 =?us-ascii?Q?HOrI8RNpux5ewylLPt+o/rAI79oBxH3YW+aSCy32tkezrCg+GFAX7zCpy9bW?=
 =?us-ascii?Q?C2RLsaGkwGn5ihCjI8lhg08LbEhCY9qu5AJiuVGKv3M4m4yPQUspBYx908BG?=
 =?us-ascii?Q?e/UlwQumAi2y9y3rhbn1x5DsVEWQl7DbWFM+v4RTFqzZwQgRLNF37JVpLy+U?=
 =?us-ascii?Q?pTlW9SHvYSw15e0FRq9r2hvC7ZMeOmH1WAjkVH2kTKKMNViC/vzass6kMSDO?=
 =?us-ascii?Q?8EZjJ54brE3gJxxSDwMJZdH0KSslHAgxZiJYdj77u2CoJFSsxrcyWGTJmxHg?=
 =?us-ascii?Q?nZOcO5ywO4G8iUxY5Hw3Mg8AJin+hfl0PIK/j2NILSwQ4aSuCG996ODZge9l?=
 =?us-ascii?Q?a+evmz5VvwsIW3L/+6FRXjF5vmqyPVvIAckxkO2KxttPjPui4iFrWXstoLHS?=
 =?us-ascii?Q?IGDN1iUq8Af9JCqnjTQWlzat8JIWr/A9R4Ldw1vDwHu+uqPPBLpvrLj+fBYg?=
 =?us-ascii?Q?qv3QQ2CIKjCvMjv1Ji8oPyW2LEi93UJFShB40mN+K5Gr31rBlHbcxke+wlfo?=
 =?us-ascii?Q?GSET2HCZNdwIN1k9r+EhcBl4JUYWdV1/5uEs54gvPr4FPQrQV14CMFqvhSF4?=
 =?us-ascii?Q?HXf6/f55gw34bUrwJcZMvfZjBAnZHw+YUYdFBN+ujbiJaPsW4n8eCI8Cpyqw?=
 =?us-ascii?Q?J38hsuBoce0nLZ03E2yJ1i4+tAQ6iqiANNXMitTDABuSXvxcwiqsUK7rFmZN?=
 =?us-ascii?Q?DmHa1sdKVO71iwwUqr9YKAyD52Zuf7aBzoGNFKjGKOxS1BPnY3ftAeZ/jyFL?=
 =?us-ascii?Q?C6AnyR/DaDCOlkvvDGkY17PDVwJoy9uiRR67TBwAdGi2B22hthTWkDnL+QEG?=
 =?us-ascii?Q?IF9YzxcaJE+Hbk2DIsOF5VSZrJKJoyx4OwsSoq9XWW37CM73b/2ALvgK7Fz3?=
 =?us-ascii?Q?LFQ60UnHyJqSXvnB1hDFObrKycmxo3qMYA1OFky1US9LWG6fR8Kqr6sF9lp9?=
 =?us-ascii?Q?aotKXBD7Lv2B7ztbeFZfgGHMJxAo/JftciEQegb2UHpYDO1cr8FghXuMI2ZP?=
 =?us-ascii?Q?n725UNfBXi1G1Xq65BJ0W6e+/VxPIJRybiHaaPDtq61dswZb1ExCZ6rc6SBF?=
 =?us-ascii?Q?y3+fB0ALzbzrm4+nVb26ZxHdaPac93yDCU66mJkKvYixYuKnLd6X3PgjxfXN?=
 =?us-ascii?Q?pUoDn3z3fVHAzFolu1I/ufW1j/zIRSdiWm1mnUyzUOxsC7g4cA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3TxNaD/14T2Q9VbylUiegHqzO3msmmpj/sDZfP3TIfDLOnDTGgaZyPUB/6yH?=
 =?us-ascii?Q?mBbw26u7/fmvcZy5tGM8LzcQO49SKgsdNpdqPma/l3QHcDBNvMWlEKIGe8/C?=
 =?us-ascii?Q?sC8a66lwCFNSTZpkjlBJ+TXvlfnIGDfC+zMk2FsFsnch3u4BMK+nyBrMMHzH?=
 =?us-ascii?Q?9gyhrFRFay1wr10bEBnesbS1FViFjE6F2X1eI0bdZAscRybdq/qas9JpAGg8?=
 =?us-ascii?Q?pOCrt+paQa4KdAOEk7cnuwIXjdqUcZl4153kN3H+ycvj8CirEUGDZWPHPcHG?=
 =?us-ascii?Q?lbjNktI89UrXxdh3rmEroJft6Hvu4Ac3MFJngQeTG9t3Vdk+M50sFNEVQFgd?=
 =?us-ascii?Q?uaWpWIFj0D2VZZEFVHziJYYLC9cOuAxiuf6BvW/Osr3c4FCLLTqnF71tjJ0N?=
 =?us-ascii?Q?DKBBe5j2g/9ryUivvG4YJJiB+DFA2Gn7Mrethnto7hUIKSsNy4YfMchWBxj5?=
 =?us-ascii?Q?SjZnD5NF9t6q1eos5Glqt/4Lm/3h45Td+gwKNLGZJ7+wk2CDqlK8GKRuowbw?=
 =?us-ascii?Q?qVgBYTi3gDJJLzw0TIPmLtuRUoYrZ8ao9CFnrlZSjhTyuuwkeK+X8MOVxKUo?=
 =?us-ascii?Q?K3Str7DKK+njfxrRTpqGoQGppDHKJ2d8wbeQ17cq33s3mpQ9WC5DxxRXqx3d?=
 =?us-ascii?Q?q9PiC/uL7f0I77pEmKC9XUd1fZuDpVj716xme5pALNPXcaA9Pb/nGtprCLjg?=
 =?us-ascii?Q?l/pU/hd5XDXwq7xEzgrtS6GZoowmmgT1vwxyrotEr2e55VCjURLz1Qvf8YH2?=
 =?us-ascii?Q?lYWBBeMMeaQOnuP84P1ICRLCBAWx+IK9Wm4zGnqnH3k6lTHlBJlL8EZVHw+B?=
 =?us-ascii?Q?bo7rj5e5sfUDP3QD0Om+RH0IZiS90Ltq8w8GfynEbHc8XmC0qUH+BFuIj75z?=
 =?us-ascii?Q?CXmY/EzJFeJs8ow0PYjYFXESWRcCoz62HEfcQp8cEahSgFMZhQSV9111i2nD?=
 =?us-ascii?Q?WEzDfrM6X/5ibp1P5AmsR4a93jQdFTR77XLxnBEseGTOKh4ZL+WSXonPr4OJ?=
 =?us-ascii?Q?jTrPwMxV1aoAL68d9XEdLMJCBMipuKLZVZxy26g/QZrQW/2d18n5OgAewCma?=
 =?us-ascii?Q?H+68uylKnDT7SacaNaEprsInOs3RkJejcjMuS11DqX4SYh0wq3qvgVYQkqxc?=
 =?us-ascii?Q?Tq0MU5oIbrEppIkUmjZW7xpjZbuWiZ7amfrqaCH1Hay5sFpCraQDQlbNA5TQ?=
 =?us-ascii?Q?HuvThTblaQ1cDvjaV2nca2GRYNZnw7NvCDI4d99/SIFTnSxE/JBpvT9QRrxq?=
 =?us-ascii?Q?s4/PoNAdo47FGA0bYtTwB/cgKw2XY+2HgyXQT/PmzQsxTXxLOKMDYeLvAQfe?=
 =?us-ascii?Q?HMXcbmkoGhNAOJqdatAS5GbYMYcB14C1IdvL0Xyk1CcrZqBdAmsCxnofTZuv?=
 =?us-ascii?Q?UJ/NMi/wqrmXJM1RMoqG3ZVhLcFdUpXO4Y/oUtNotrzfm5Hkjjy0paa+DTdt?=
 =?us-ascii?Q?3KZZvsxg1GJAHoRAdQespPIS+ynacMqGaUYGYPzrvf9ED6MqtraDuVKnDYKP?=
 =?us-ascii?Q?ONvOWnThNB9+5vQiEt0UD3puVU1+Cli/s7pAV43k25HsgzoL5vqz7cjXzqf9?=
 =?us-ascii?Q?sxtMmQgkFGGkbp8yJ2lZrHQTEEOXxiSnJ35AHNxS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QjR3pNs6uK0zcdF8lhQJSKjj6+nOBcntluf1jm3lo/jziyPwAaBHygdkb8zQqC545taL+z5xRvB8yC6FBxfY5pUHtRp2Szz44XdBgda+vwt6iQH4XGRP8NHyd07m4j+XCjXOaYJqsZOpEa8uDqh2DG66GNxtvm//PCAkzXr0xskVFdfW8Wo922g1LIskVQn5ddRvbgVR8T9jAI82NxSIkmCiS9keNXEk9ZAFfInPxI7V7s6mloTTUPTT3nu61DTT7XCDqY6vWxVpOxLymRjFfYpwC1PIGm4bcFUZRDtsk9DSpu2n/1YStz95Qub4QjI7GXTJlato0y9v731ZFVfQEEmDN+jcZqY7eQ68DDn2y0Q63/Fv2JGOgv589WRr+lJiSgilnYs8m19gNhVdyDHxC+KQOjBAeRWWmS0TbWNODLpZjw8jxRJFV0b6TdzqGET9xDkxEl8NFWfLS67qCc4sxAj0xXp8npYBdHFmNA6Mle6hH47rwrw9FA+tHNh+rNGn5iYmzOKiJNlTO/A8Z5GdmmifrUkyHE8C9M0l5lQbdhOaS/CAbX6beA2ccXAFggw2LBXiPLJBWzp3+e++6XBE6I6mubJWaMtfzpTckJa/pMI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8a06c2-769e-43ae-b163-08ddf6586a4a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 02:09:36.0700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZA91+Z1dCPlRVMvdJB/GM2J0GQZ7s3q4WZwY4SlFP5lUPkLhe61jfCJkj04zpIikC0aE2SIUYaJOnFPXFpZkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6882
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509180017
X-Proofpoint-GUID: iFZXDJ1861pb9jsbhu25wcau0XJwK1Yz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX+Bnsxginjdtb
 Exbd2ovSbkiK3k5NH07JsI1r6XRUi1AqUc71mxcIrdXegfpsa5z5hUURm4bFhOc4P+ltKlpDG0E
 umT5ofmgnfp7/Xvm/eLnh4b86jQpcTyxqOf2axzgvFcyM+s8yEeqeYLj/SBMbwpc2BIrA+yesbF
 2hFTHjt9u7XYMWKqGN4qqSzCBBMXwx7pYGHr+ifWPHy6sb/1yZvU/y5Vp/9zDusfrcKyCxGCFP+
 NyqoUhkEJlChZDvG9LNx5ZUkuFPsj5PofrrRLxHTwyGMfcftNBvznOzrP73Vtb8Nq41YPLPkVkb
 klP04IYd0N+6Pb8AeQPZja5vJibCXQQ4c38NpW71sOJgXIP3N7/AEVbzsnvcmzqVv62d6o3C7QA
 yT0+ciK6
X-Authority-Analysis: v=2.4 cv=cerSrmDM c=1 sm=1 tr=0 ts=68cb69e3 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=GvQkQWPkAAAA:8 a=hxcxAv-qyI0tpPchHNAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: iFZXDJ1861pb9jsbhu25wcau0XJwK1Yz

On Thu, Sep 18, 2025 at 09:31:30AM +0800, Jinliang Zheng wrote:
> On Thu, 18 Sep 2025 01:41:04 +0900, harry.yoo@oracle.com wrote:
> > On Wed, Sep 17, 2025 at 11:48:29PM +0800, alexjlzheng@gmail.com wrote:
> > > From: Jinliang Zheng <alexjlzheng@tencent.com>
> > > 
> > > After commit 6eb82f994026 ("x86/mm: Pre-allocate P4D/PUD pages for
> > > vmalloc area"), we don't need to synchronize kernel mappings in the
> > > vmalloc area on x86_64.
> > 
> > Right.
> > 
> > > And commit 58a18fe95e83 ("x86/mm/64: Do not sync vmalloc/ioremap
> > > mappings") actually does this.
> > 
> > Right.
> > 
> > > But commit 6659d0279980 ("x86/mm/64: define ARCH_PAGE_TABLE_SYNC_MASK
> > > and arch_sync_kernel_mappings()") breaks this.
> > 
> > Good point.
> > 
> > > This patch introduces ARCH_PAGE_TABLE_SYNC_MASK_VMALLOC to avoid
> > > unnecessary kernel mappings synchronization of the vmalloc area.
> > > 
> > > Fixes: 6659d0279980 ("x86/mm/64: define ARCH_PAGE_TABLE_SYNC_MASK and arch_sync_kernel_mappings()")
> > 
> > The commit is getting backported to -stable kernels.
> > 
> > Do you think this can cause a visible performance regression from
> > user point of view, or it's just a nice optimization to have?
> > (and any data to support?)
> 
> Haha, when I woke up in bed this morning, I suddenly realized that I
> might have pushed a worthless patch and wasted everyone's precious time.
> 
> Sorry for that. :-(

It's okay!

> After commit 6eb82f994026 ("x86/mm: Pre-allocate P4D/PUD pages for vmalloc area"),
> pgd_alloc_track()/p4d_alloc_track() in vmalloc() and apply_to_range() may should
> always return a mask that does not contain PGTBL_PGD_MODIFIED (5 level pgtable)
> or PGTBL_P4D_MODIFIED (4 level pgtable), thereby bypassing the call to
> arch_sync_kernel_mappings(). Right?

Yeah, I was confused about it too ;)

I think you're right. because vmalloc area is already populated,
p4d_alloc_track() / pud_alloc_track() won't return
PGTBL_PGD_MODIFIED or PGTBL_P4D_MODIFIED.

> thanks,
> Jinliang Zheng. :)
> 
> > 
> > > Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> > > ---
> > >  arch/arm/include/asm/page.h                 | 3 ++-
> > >  arch/x86/include/asm/pgtable-2level_types.h | 3 ++-
> > >  arch/x86/include/asm/pgtable-3level_types.h | 3 ++-
> > >  include/linux/pgtable.h                     | 4 ++++
> > >  mm/memory.c                                 | 2 +-
> > >  mm/vmalloc.c                                | 6 +++---
> > >  6 files changed, 14 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 0ba4f6b71847..cd2488043f8f 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -3170,7 +3170,7 @@ static int __apply_to_page_range(struct mm_struct *mm, unsigned long addr,
> > >  			break;
> > >  	} while (pgd++, addr = next, addr != end);
> > >  
> > > -	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
> > > +	if (mask & ARCH_PAGE_TABLE_SYNC_MASK_VMALLOC)
> > >  		arch_sync_kernel_mappings(start, start + size);
> > 
> > But vmalloc is not the only user of apply_to_page_range()?
> > 
> > -- 
> > Cheers,
> > Harry / Hyeonggon

-- 
Cheers,
Harry / Hyeonggon

