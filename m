Return-Path: <linux-kernel+bounces-738117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEAEB0B492
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 11:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0A3217BD98
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 09:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437CB1E1DE5;
	Sun, 20 Jul 2025 09:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="csfGbOws";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QMlqT+38"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CFC1B424F
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 09:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753003445; cv=fail; b=p+DTR19dkwlD0LgseKHNs9V8VW/6sTdVn2+xMCvjxQidTZpxFNtYI8DQsB6iyzs7qoOzA0QiKS0A/cTaG5Nx0g9JfPHyoLQedbs4lrnaupFVgoJbC4/uKaybDbTtZiR3rPzsMOcjCLX1XPc6tBKmG7Ioqc6yJqC4LBLgDuQcYwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753003445; c=relaxed/simple;
	bh=81GCBab3D+6a0WiMO9fEvAQfagRj3hzcUO5evSB0dHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AOzqdYVudRvyHNYwFyPosp1F5G2j4j6qqPaAma8kwJN0kkZZF+2KlFIHc5dXVPdhaJPTR336J50l+t28XJDFEPIQbUSuN21L92zACIfRGi8yNiS4yN6kzaOjfrz79lTBecilEvVvpHTO6NNma0nSH/EGk6vmNspRg1FwJ1tI8S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=csfGbOws; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QMlqT+38; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56K3u6qC005478;
	Sun, 20 Jul 2025 09:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=sRrlKIxvxXe3a8BImc
	+sNy+WzHj9/Z96JIh9MYxwUYc=; b=csfGbOwscwlxRCagSURKeoyd3XDJdrVQRa
	bidwzGP5gkpTzMmrkf37xlUEZjh2XMFk8nq/ar9AGwyhfYAS2BJHBZwt0XbJLIw0
	qOHOwHojSvgavnYvoMHRizf/j0RJ9h7dSqR+aL1Z7o+JlkheHHpLt6TTKhyr4/TX
	ix6xbKkXPqI3xJ2lBKHQ7lngoM2wZdaVib+ToRL/jF2G+A9mC89tMDxtDZdSdHgp
	C2DN1ez8txvIglLRHMps2r2Vdovd1osUSNfP9/Opim+/N1rG4c5wMC7JinhXQCz3
	PHKConTJt5Odmi+2JvUpF17ls4GETzOvDtMyl7d0+hehlmDb/PZw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48057qs5jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 09:23:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56K8bQFt005769;
	Sun, 20 Jul 2025 09:23:34 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801t73ke6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 09:23:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WivMxPk5cGW9cVJ6yKXbeDWLsoMfJtLuE9WldP282jZPD7WRZWQMUaxl+OSIJ3hmlia3t1zt30lpsGcaqcfR8p3+AJv7ecjIaEkniAJ3Jvo+zGDtm07iVYJdPmFuf6nKpw0p4QqV62lbUGtyzOHl2Ue+LJAgJb4ajUk7AiYS5WSjoyic/x97MrspXhNMR069fZ8s4DmQW9bRnDGI2kmlx6ZUJY0IE1dcLDi/mymMDmtJpWE+M5L60RlulAQkfqC4hyDZ9UP2Syti4cfmX3ofdBEm9NAWXSsVVGTvoKdU3BB99FJXRoPVkTSMnCazz22aGFxNRS77j8u+fwqr8yDX8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRrlKIxvxXe3a8BImc+sNy+WzHj9/Z96JIh9MYxwUYc=;
 b=rdyeMC1rG4SyAF2w1HtZKJoDLWpgYwwpjnNY9MsbIbE7Jf9udLe7nXZUo59UoDdo5yijGafi3PvvR5i3CAb2+hRgXpebUjmMgB99POClzKmhUKqoPUAEQ5Gsc5rqxAv2KDSgir+sypdLPjERmaXpzxtu4Cs/xBb1tz112/8785C79LGyyn85D5qXVtOgKuxPd2J0WZ4BK35S9a0TzWk8t4HKMOI0J0uU5ZgCp0h9jB5DlNVzCLjVLwKDHoXbwP3PNY75G87dPp8oezoXlsYcaVYONqFQpW4NQPRVfzx/IAKdClOs9NURVMcCU2WeTeSOyKhoUVI4NXpEKe8zInH9JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRrlKIxvxXe3a8BImc+sNy+WzHj9/Z96JIh9MYxwUYc=;
 b=QMlqT+38yYk3540Nfv+qaAEQA3DopW/kAIMZ2roEKQCEAb6X12Cs8Y/zIPwPhfsIn8+DkGrwx/o35hQI3jmxxGO0Kju1XwZ1yuAOXXxkCdRMjYgL72YSw4kjHmud33gwD2MHuwpVF2eMTP2JlUWuT9RmGXg77YjUYV6LE5fRHnE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4590.namprd10.prod.outlook.com (2603:10b6:a03:2d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Sun, 20 Jul
 2025 09:23:23 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.028; Sun, 20 Jul 2025
 09:23:22 +0000
Date: Sun, 20 Jul 2025 10:23:20 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, wang lian <lianux.mm@gmail.com>,
        akpm@linux-foundation.org, Liam.Howlett@oracle.com, brauner@kernel.org,
        gkwang@linx-info.com, jannh@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ludovico.zy.wu@gmail.com, p1ucky0923@gmail.com,
        ryncsn@gmail.com, sj@kernel.org, vbabka@suse.cz,
        zijing.zhang@proton.me, ziy@nvidia.com, shuah@kernel.org,
        broonie@kernel.org
Subject: Re: [PATCH] selftests/mm: reuse FORCE_READ to replace "asm
 volatile("" : "+r" (XXX));"
Message-ID: <f0503a61-f605-468e-ae15-c4934faea632@lucifer.local>
References: <20250716151543.998b121a58064011e9ce68cb@linux-foundation.org>
 <20250717104811.3773-1-lianux.mm@gmail.com>
 <d27e9451-8807-4c86-b2aa-063639f7801d@redhat.com>
 <20250719102738.06b91a8b@pumpkin>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719102738.06b91a8b@pumpkin>
X-ClientProxiedBy: LO6P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4590:EE_
X-MS-Office365-Filtering-Correlation-Id: b20a1db3-5776-495f-1663-08ddc76f12db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6huTacPY3+LQqbS5XKdL09a5SrAXJ2ab+D52TwMfXOuoVcJo7L1O+yS76HFT?=
 =?us-ascii?Q?RoOXjEhHfR6isoQpHcsOtG0G33SW9vzCoBqMn4QxKSpZI/RiCEJa82nQjCDv?=
 =?us-ascii?Q?NElCwixQmgdZcLDrMV53BH/JwM3czfzurOO/YJk2NrVPTaVQK5P5k5DA52Ny?=
 =?us-ascii?Q?9cv7Bz+b6hARcrYsw9Ja88s9VXElcuWE66BIf5LeAJwrsr0Xrta+Z3/yoKZ5?=
 =?us-ascii?Q?5VPiNhyemaB8qZLeboAwewqltAb+jid0A2jrzmlyljUQU/gp0Y+79l7RTsK0?=
 =?us-ascii?Q?tR1Vw2RGn8b/aj4tMT4serimft3/sSvKEg+jj1GtE85BNpgURMasAHYYLZCP?=
 =?us-ascii?Q?AbaWzLLcBuq+IV6PKRQAVqjA13vwmgJ6xbHNYgxqLkear8yYNsosoPnCMiRb?=
 =?us-ascii?Q?7QvSa2NEAuPz4y3Ank7wXFnzrbH9sYbZqpSqek7rwmLEzpbOrpcYmnj497bh?=
 =?us-ascii?Q?fxpILacL88dN8iv0y0uJFt9Xj5laEtBc4gkDgQqpW7FRy3edbvqKa6kzOu5H?=
 =?us-ascii?Q?1ArZ3FQoNu4JO8IvKJkGUeC8lN1vOe1bNPKVbB1OP2jEv5SuHpMP+b9Cg+D/?=
 =?us-ascii?Q?bzP0Zs5hWNZQF7O92BrHlmeetcpYKx58SiNlUlcVR9jsJuxjRa1O0o7n3r4Y?=
 =?us-ascii?Q?vnT77JGIZ6S94XyDKW929cTuMv5N2B3c/b0DF8WQrefR7OMgD3Y2fGC3K0E5?=
 =?us-ascii?Q?/idKrttRCci0+sZvCxj5xFkUaAYEkXDR+y9nvQGNdid46cV/wHFeqvjU3ce+?=
 =?us-ascii?Q?DRUdYiuwOuiTCVUNosGTqiuzM1+wv4Lr+Z752j76y4NAYXhmTf+Efm+7M1E7?=
 =?us-ascii?Q?PZW7iTO8JiAuzmwG+vW4Ol0IsTSmwf72/ELJ46OYJJkRapTPd2JlVw9cHiAR?=
 =?us-ascii?Q?PCDrPrdg9he6hrIxCdcqUVjO5orhv9k0I6rXOgzuJyMmmYR8US20e0etAeDJ?=
 =?us-ascii?Q?1K0K5g1GJD2iBpRmBgboFG9BpJyHy4bTVOGANo8FIyRJq5IMyf5eOYQy31Nx?=
 =?us-ascii?Q?JJ4N8nD2HJ+cTmgHCZ4uWZ10cGTVU3jwl4E5qpYhbQ2EyphxQjTcldJFWFAk?=
 =?us-ascii?Q?2xGoF27KrtncYQVoJzS06/mTIxtDoIln/zClyQP7A6RwV8zxhGyQo1teJqq/?=
 =?us-ascii?Q?P2CBMk/JgsJwkM9KK8SSC69j/iubziXq1ant+4FhtSuWXRZK4q2tbvwj8fVW?=
 =?us-ascii?Q?TXJ1JOmavm8Lbs40xSZDdqudYRqJ7n1S2zIr6JrlXH31kGu4SPCvCan5ffCz?=
 =?us-ascii?Q?zCAuF9NWAQK9/xCAcGZWfsskOhJ24c6IkdyTDFzRVwzN8fKROXr7pGZIaPfb?=
 =?us-ascii?Q?z0okhG6l9pxkiYNtkrFN/I25Eo7stF5pwDtNlCXkbzxS+t0hOw9u/G2q24FQ?=
 =?us-ascii?Q?w6WojJhcGIsYKa2P5qq0Q0UQ0txcwfJ0R5tv76FpGIIYq4OTf8CVW3XEiI0p?=
 =?us-ascii?Q?kCZTMelAXuc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fxZlx+lNZ2dfbgufE5xwqG3tcY3mTQVAkZWRg1WefU3Yn75F6jLvoebzOrTK?=
 =?us-ascii?Q?sfn8z3XDWUPRIR6VTMGmL631pchxYSWTAAGIlGOlGS1xH6ezhPtjfOd1MMhS?=
 =?us-ascii?Q?uB1ucF1KUA7lLe/8CiRBiv+83oSK0aHz/vrhHFGo5Dg8SRyUN5IxoAdmYwI1?=
 =?us-ascii?Q?C7FgJVOIiD9dwmiTmcytYfJTEn534ksBOkArPSaIFXNFMAPwgy5h/sqrpK+7?=
 =?us-ascii?Q?TeCgEjC9O7SLXWQYKO2kXOZAULkP6E7qJ3eaK3s1SccPyx9f7i8N3E6351NC?=
 =?us-ascii?Q?ymVmmDfg5QTpc3vZ95KhYZGkaswm/3odL2hlQBy2Gpl993mLhQHEAReuzaEx?=
 =?us-ascii?Q?JuaLM0Aa5oVCZ1kA4kWk6iQWLhNuYXjMDqelxbIuKWuTWVJu6DkiHw5glLEO?=
 =?us-ascii?Q?Bmatnw5dzG4mei2cCLiX8SDCOw1nqscaVtQQoPlIz5WLj2T4GozaSF5Gx9/9?=
 =?us-ascii?Q?140dDwAz0l/37iG7yzVZDPOQ5+m9YriZsh6hwxOsqvjf1VE7FtedROdc/hwd?=
 =?us-ascii?Q?qy/EArri1gCn0NY9J32piYfSVMNRCL+4S0WJAPJvc3dQAeNrXy+F9xXwAlQn?=
 =?us-ascii?Q?WVOh9s7ezoDUHaiJ0jFlKlacLnH4Z4WqAcoLJgaWktZri2o62pdmXDAGTfnP?=
 =?us-ascii?Q?JmmJX3hcoC2HwIu8D6AdEEa/N5S/xlZ31Av/7V9wWH4du2VcTTSLsnDZK1WY?=
 =?us-ascii?Q?yCZbsAddkIsSYYNHrEeZSvFqg3CaJv27kPGJe6ORA4eYxoaJ+3PflkwKfuNk?=
 =?us-ascii?Q?fRVCgai3fcTgp2ZvdCHFjF0qdwxx5QNUJF1Y4b7BGrvIUdzJ8RzD3CBMz936?=
 =?us-ascii?Q?/NUCgw3g5nkNjOhwQIHEXxd7k98h3e5Do/ESBOaMm5zn/KEnArRs2NTFSIOb?=
 =?us-ascii?Q?k7sV8wQAWjiZ7nAdNrUUA2BIkcnJdVjW34EyGsZx01WxnXitMcBFSQs2bw88?=
 =?us-ascii?Q?1KU4LCnFGb8BnD9bT5nSud5ztnM4DBzO17CvtHb32wO7/xEFzXLHVumBHlas?=
 =?us-ascii?Q?lgrXH3R9XSZZY2B+VZJa7Dn14JPA/B+wKsrNAD+0rc77iaGzUqzt40oTqo+f?=
 =?us-ascii?Q?joJ4as4FA/NcmjAkINn9qDHRN7bIn/ggODli24YZCOvXOHILUmPsjT5sW0DA?=
 =?us-ascii?Q?RfHszkgd7V7ryHj7AJvHcgvsFKDjRJoZeipsm/lQvX9Ym1pnohgvyKSBgeyw?=
 =?us-ascii?Q?+MrWU/yf8T5SWUsSi/AocALtFytjK97lPvx4sdk6fDDoznunVbbqvGOVTuZD?=
 =?us-ascii?Q?XAwcPmGRxmYht72OVofM+zI07rQSz4dlrHks68bL2tH1YdfnlciI+XElKe5W?=
 =?us-ascii?Q?JtrINmtEdusdYTuKaWJDAMgEtjtXl9RV8XEQMC5DdXXuBW4F1BUxzi2CNqWp?=
 =?us-ascii?Q?Nv0RjemoBXYLCwIUIblubQpMglwKWrTrEdZnZ98YBxseNc9JwsLv7oPmOsjZ?=
 =?us-ascii?Q?B7+UaeNUxAjt1idJHF5I2TB7SPvAR+n41vHDeCijmoccx9sTXMZXvpv4+A1F?=
 =?us-ascii?Q?fvhijKR6IQyqOXmjgT6wcGWFUfn6m2GoJ0SOlBQyHRZnHR7MIZuNi74D27SS?=
 =?us-ascii?Q?G1tTRB8m3TLL81g6Y5QyE7F9KG8XtTWHuuLo1pBnCu1agPETlsPFYZlmib+R?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r9qw22IxpZAWKRwZ4zJkJAGI4IwFX2H0J7ITqqhWstFW2ddGMKXC6CslnAE5D8ciypL9BxFPmpimUw03/EdcAGVEzsnZqs/o/El31dx+q/EBThdiLq7qJqVvTpYhcPte0c8PfIs0MbT8LX/pFFG7NFzmy5/nrKVxk/mrV0uKnzIMnoeB6M1TK4ubAAfn1B86/HKEW/W77tuiD70arf2QA5C9KukBs/k3akwSjQA+Mo5a4sARZq6tHwACgpsqw471yGVSizfjW63OFm5ztTpzARO8+btaN/QDTP2PL6g7/TfZOzjVWhNhTKtmjlODov96PIh5TTg3L77/DrTfvuCG2Xls+24XCeftXTPAzEWa/ejGOGcV9td86Tdv9XdBA5wK5tUv1XYr1fDLU3Vo4Yorpnt4T+q02cl3kTbYAXp+EopjbVAE13bPf4xKFQkGqTSVCZqH0ydkrSf5ENxAPNb8AP9n072/POA+u0X7PudfbFVrF7T/Ly9WlqckuN7hd4rIft48sCYmFkxytlhEpYNm5NsdbtWx1i81+xO+YlGQcJaEpajNDMoeHpmzoeQQ6kVtNEX4T2QBZy94J+Jpx/zBDFm9EiIr9iHvZWAQKQeA/JA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20a1db3-5776-495f-1663-08ddc76f12db
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2025 09:23:22.8886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/aDzXbB5lHZ5aQYi6e8QceBZ0SKLJUi7/XxPDXMvvD5EZoNlt3y07RqIXZlWbQpfOxJLjgoynZdfQ0IiVnLMlffv0Mw2ReZxxVE4Swfglc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4590
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507200089
X-Authority-Analysis: v=2.4 cv=MNRgmNZl c=1 sm=1 tr=0 ts=687cb597 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=IL8r6mLcNWiA0mF2rEQA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: rBjEJZbu1p3CMYDf9eO9v82f9TvxnAb6
X-Proofpoint-GUID: rBjEJZbu1p3CMYDf9eO9v82f9TvxnAb6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDA4OSBTYWx0ZWRfX+Bl+KVZ+Qrri
 ktQ8DUaabB8WeEeMyt86QB0K6UGftRsAuaPlQqiuQhwM/Dw+DHcChQ+eveQeRGPygE3GwCfjt8k
 6xbEh2kDo6hKMX872WsNJMrF0E26JGISJjyC+oWD4bZqBP1GbwS66tBDYR2T8bYTgzsunrLN8oH
 ijAJpIY0qzeYRm75fajkTt4DWMv0tghiG/jQqlOTGmy2gwPeMc3ISSPCwNWW1Yz5umEehIaF9P5
 lNcaDNkDGay5+tzESVHDF/pWVTDwq10U90BozSrHfN+0XLlzCk1vjDx71kV463Mrc/KEqvYkMhY
 mTl232kgl+ACFXX9oULRyf8EwsgQFoAZHRn1WTZW3ZrlLsPAxzHR60OSUOaExaTD9OAjMXuaZlZ
 B2dL6J8zttdn0Yml34ECLHYjNgi4tjHIq/O2MWwU6la2KLAjyyejY68kSvb6V0FeHc6G5IeW

On Sat, Jul 19, 2025 at 10:27:38AM +0100, David Laight wrote:
> On Thu, 17 Jul 2025 13:43:45 +0200
> David Hildenbrand <david@redhat.com> wrote:
>
> > On 17.07.25 12:48, wang lian wrote:
> > >> On Wed, 16 Jul 2025 20:31:26 +0800 wang lian <lianux.mm@gmail.com> wrote:
> > >
> > >>> Several mm selftests use the `asm volatile("" : "+r" (variable));`
> > >>> construct to force a read of a variable, preventing the compiler from
> > >>> optimizing away the memory access. This idiom is cryptic and duplicated
> > >>> across multiple test files.
> > >>>
> > >>> Following a suggestion from David[1], this patch refactors this
> > >>> common pattern into a FORCE_READ() macro
> > >>>
> > >>>   tools/testing/selftests/mm/cow.c              | 30 +++++++++----------
> > >>>   tools/testing/selftests/mm/hugetlb-madvise.c  |  5 +---
> > >>>   tools/testing/selftests/mm/migration.c        | 13 ++++----
> > >>>   tools/testing/selftests/mm/pagemap_ioctl.c    |  4 +--
> > >>>   .../selftests/mm/split_huge_page_test.c       |  4 +--
> > >>>   5 files changed, 24 insertions(+), 32 deletions(-)
> > >
> > >> The patch forgot to move the FORCE_READ definition into a header?
> > >
> > > Hi Andrew,
> > > You are absolutely right. My apologies for the inconvenience.
> > > This patch was sent standalone based on a suggestion from David during
> > > the discussion of a previous, larger patch series. In that original series,
> > > I had already moved the FORCE_READ() macro definition into vm_util.h.
> > >
> > > You can find the original patch series and discussion at this link:
> > > https://lore.kernel.org/lkml/20250714130009.14581-1-lianux.mm@gmail.com/
> > > It should also be in your mailing list archive.
> > >
> > > To make this easier to review and apply, I can send a new, small patch series
> > > that first introduces the FORCE_READ() macro in vm_util.h and then applies this refactoring.
> >
> > Please simply perform the move of FORCE_READ() in this very patch where
> > you also use it elswehere.
>
> Why not use READ_ONCE() instead (or even just make all the variables 'volatile char *').
> I had to look up the definition to find the hidden indirection in FORCE_READ().

Honestly this is an incredible level of nitpicking for a _self test_
patch.

I don't think you need to look up definitions to understand that volatile
prevents the compiler from optimising out a read like this. And what
exactly is hidden? We cast to the volatile type of the pointer, then deref
it in a fashion that cannot be optimised out?

But I mean, maybe I'm missing some complexity here? I am always happy to be
corrected :)

The point is to read fault a page for testing purposes.

This is fine, works, and it's _test code_.

Overall though, this discussion is not helpful and this is a moot point,
sorry.

>
> It has to be said that now writes to variables that are READ_ONCE() have to be
> WRITE_ONCE() why not just make the variables 'volatile'.
> That will stop things bleating about missing READ/WRITE_ONCE() wrappers.
> There was a rational for not using volatile, but it is getting to be moot.

I'm struggling to understand what on earth you're talking about here, what
would bleat about self test code missing READ/WRITE_ONCE() wrappers?

And you're suggesting going through and changing all pointers to be
volatile... because why? What? That'd be awful and very very silly.

Note that checkpatch.pl _will_ bleat about this.

TL;DR: No, absolutely not.

Wang - do not do anything like this, please!

>
> 	David
>
>
> >
> > I missed that when skimming over this patch.
> >
>

Let's all have some empathy for this being one of Wang's first patches. I
appreciate this patch and it's a strict improvement on the past situation
AFAIC.

Cheers, Lorenzo

