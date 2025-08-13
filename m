Return-Path: <linux-kernel+bounces-766005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7F7B2412B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42CF9189400C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 06:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0902C1581;
	Wed, 13 Aug 2025 06:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BbiXywM0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WYAZK/Lt"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20EB2BEFFF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755065462; cv=fail; b=rT+s1ChpbihPidvGYACx/SuvVEg2qGwMuzgjIwwNpax/yR4uTotfqZ4i/jcTVy/GKbL+J40iPMUja7DsQLyaLc22qSvG6CfybIl+kTMTJhS1sHjStxcp6F+h6tGOgVkXR8JMaFCpOa0lOMNEoiWBQbd+6+ZRnAWCpJ3mIeSBRt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755065462; c=relaxed/simple;
	bh=ET6wd0F3uMn2wHit4OrLeJH8n2RdoxIdpZPWDCvFsy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=asrtBhQhrJoFAz2TpzX74tCxJluhmMQArpbGhDYsLxoZDWDPydoXYKMR81YzyNzm/kPh8wpsZ1JlzJbHIkC5FMl4+F3XrHB09jTEGJTD82GolJRAgIbr+Hv/MUNeWovxDSrDYoPNomiL3EV8oNsqhMUXLSya78bpAtzqnJaiOyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BbiXywM0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WYAZK/Lt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D5tvHC032422;
	Wed, 13 Aug 2025 06:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Lsj14dLBTAbp/aUoQ+
	1E5LjHH3yFfjPWRZrXx9P9wyY=; b=BbiXywM03Tss2Y2uZPkYOgbYXanMYuGpjR
	YUZlCSZRh76yMss6GB1apipNqbnd13TTnCF6lr8H6DmtNhvs5EtTVZRuuvn6tt1b
	d/1cqhgB++gUTWCHooZMOHTSS90C3z5Rj+yR/kWWyiYdsu9+RxMD/Nl1FzcQn0Hg
	Xnv9vlCFX2U8xT02gQD0Lr/oSqGWRHjI04nm+x7Q9RWY40C62bAfqmSHiIuzFlxo
	kRTiYIIKGfF6PK8OFGkjF7mw9dXFxS0OdIVwh4Y+G59xQNsa0M2XFj0NyGueskMk
	3MVDyywI4Dw4XIQjo12C7TqNqCUAAJ4YbQxHNQcuHeYNfNJGsC1w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxcf6jqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 06:10:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57D5PsvM030131;
	Wed, 13 Aug 2025 06:10:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsaxq2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 06:10:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3gHQ2vsWQbC1JBrgNsKXdf9atS89opFT2djUxvvxI0Z2LzDmsNzeAQgASVYc3+q86ExPAKoDPzLHPjFE21Gq+hWbH3KKLWcu1fl0QZ5k3NNVRfsNxPUSm+oZKYegMltXlccJWU3igkmHgctUy/zk0CrnZ5S2Vi43et2uwKahWNIUvB12eqikzpg0YfB5ofLucI5HjHnfsZjctmJVZj0xv4PHrILfeyrCfT6Ixm+veDbWykCznLkKovBGpUPuyj2gVWmXG1v+i3GeX5oSa8wNLkICrbyeDEEXa9AL9R2Xsy/S4g4iVuckFvLszFar+lLmCk1dk9UoZNzXgJ/dgi88A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lsj14dLBTAbp/aUoQ+1E5LjHH3yFfjPWRZrXx9P9wyY=;
 b=yZqJLXS5TwKxOlTHEcNJKbYHNKDBgTM7z9H8RSH4j7kLkOqH3Tsb3+oCQRdJ1tz70NKk3whixTijlE9beCPfsE6FtIf9m8rCITjr3ZbOBaBaxBwGDiCF3ef0krz9tErjb9U0QS2oVjkB41tM028Q98LS+g45eVUACkOfdMfsmR5DiECyKokPv02s1P27S8qYUgp4t6bHlxL57xipol9LVOkAkpk8rwSIlK4bmnDP8I0AeoqV4BdIplrg84kh83+Mir0eSEe9nhORFb/2tRbQ3sSpBKh51VE7egqnaqfPSLodHBIz0YLXUistZLhbtG9QIZuLWEtzZ9ko7phykLNDXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lsj14dLBTAbp/aUoQ+1E5LjHH3yFfjPWRZrXx9P9wyY=;
 b=WYAZK/Lt8aXNkJfzxBJkFW/eAfeJzvqbL+1S3bQOtHGcOnSHHLrFWfvv2ali4QM+yTypESB+r4+mFG8FFUcePssEv0ZwHf17y8K1P3JCWdrViUb7+IvbFmCGtv0Fc2vN4js4Rl/vmf1egQzDPYVsAMRzf7lxTOeErdM1Z+WH6AU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6522.namprd10.prod.outlook.com (2603:10b6:806:2a5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 06:10:48 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 06:10:48 +0000
Date: Wed, 13 Aug 2025 07:10:43 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linuxfoundation.org, mingo@kernel.org, namhyung@kernel.org,
        acme@redhat.com, kees@kernel.org
Subject: Re: [PATCH v3 10/15] perf: Split out the AUX buffer allocation
Message-ID: <4d681184-c285-4d79-8e5f-f4b3f23c9f25@lucifer.local>
References: <20250812103858.234850285@infradead.org>
 <20250812104019.494205648@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812104019.494205648@infradead.org>
X-ClientProxiedBy: AM0PR04CA0126.eurprd04.prod.outlook.com
 (2603:10a6:208:55::31) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: acf05616-5d26-45a7-95ba-08ddda3025ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9aRXn/YW1f8hCZAR996SHiMOtJimwJ4Zu/Wik0Ar6j85XmIPyzV6nIqtWs9A?=
 =?us-ascii?Q?vPXxYntTQ4MgM4LTdK+/EH6G3jfF0xBdMgTv5TgW74yRONd/sYQzTY72FM5X?=
 =?us-ascii?Q?QiivOrNSw76TpZdx50MmWj1DFlf1JVF80NizQ5NdZklZE9Uv5l1aAiXU6jwW?=
 =?us-ascii?Q?t6QRiTG/vrqqEFH9yIftW4O24jqpE9MmWgcbFd0DGY1wDX8X8a86s0jwTPPN?=
 =?us-ascii?Q?uaeamKM/nLdakUpVUpzYnj1CZFUuLEfQBH9CrsZZOiRVv50O27MqmRUpStYQ?=
 =?us-ascii?Q?PacQgCZNNg1RXtG7eTAhVKL285JM/Vv51QbSv4Z8EpIN1mYLCR+KYR/ksRvY?=
 =?us-ascii?Q?9SG5Mv+8XXsrgTXgJFSojorwpHKJbN5x6EPy9SLKD5x8/7zxWSqLrvms+HVC?=
 =?us-ascii?Q?8/Uowl0lcmiqz+KOzBfbKlE9mKJrRfhrZKsqoFSvCfxfUbLOhXX98DS5eOaH?=
 =?us-ascii?Q?P/aPeBBXE3h/HWpwsVoC7kVPZbEWWZB2vqxpRH5WbuLesXFlLrAMVA2Xxve4?=
 =?us-ascii?Q?uF41Azoh0GsTeXNXINyV8o96ajLIuHFzvdLRYY/sP2fzeX30smXLSM8lGnp3?=
 =?us-ascii?Q?vQIv/yXO9Ba+6Z7MrAkivrfHwgVJOzeDilTQqSYCvt0MimqTloxYA1v3OuPM?=
 =?us-ascii?Q?Z5ExZqlgbnIhNFRKX7N06UzvSAJUEP8BAdhpa1lkgvH9wpoEYW16L7YC60k2?=
 =?us-ascii?Q?XLimN6oGNuopPUiYWNoWUvfIDcV6XWiDSEYNerU4VAUvDtec3+taGF8GZKgF?=
 =?us-ascii?Q?KOzUqWFLCe4jh2Jp4RjLZMBTUveTNm1tKvdMyzOmEk7FtCMpL35cng88sGpa?=
 =?us-ascii?Q?N0lU6pnaLi6gV18pEVvIAqKppJDydjT87P3FpTSoZwPBcjat0zVZlE55ZF3l?=
 =?us-ascii?Q?0iTkPlbIYrlgns9Y5OqzsWYb38W5+KPTfwtpCqaHbAuZ59nxVfn/oX/j/nhZ?=
 =?us-ascii?Q?qbJ81KEAshfHsvOOCX59xrsqaU/wKXg7EOb0sieTDha/LwvK3ztiF9JPg34P?=
 =?us-ascii?Q?Gwk4QZ5ig6kUIRu1RwaNH1XMj8QdrTKrWykf9Cu2wGwuF4NRyc9ic9OwaSXC?=
 =?us-ascii?Q?2YKu5fIn1xQnu7tHVoDIhujHFaRoPey5FdiQKhkpt0/0m04r5f104CeJUhD5?=
 =?us-ascii?Q?1pWlFYDmkWreCJf+fYj4n+F5O+zZT9vKet4+3aF47TETMYSESmDbtKBfRn9Q?=
 =?us-ascii?Q?D0+ZWZlFZ+fjmB0i6xIdmChxEOsvyPJbEM6IBmWdogH3TZyMGmnhydXmCWOv?=
 =?us-ascii?Q?JArcSqWF/Hj+BDwlo7uqLxGTIjQUiYCQJlvydLb7tzzTTrg3JL5OqoFvl/4C?=
 =?us-ascii?Q?KhiU7IQ9qrgxu1iH3q2GN8TVRK/FEvl1yamFiLcMg6OpqqegJbCz8IIG4fLq?=
 =?us-ascii?Q?MDpJvAhW4Ezt76cXnGk9UMJHie3JGSZWg+wZB0VEisAWrzGnyFygUBLzYifE?=
 =?us-ascii?Q?ogJGamxeTxs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SMuMwBJyRYnMzp9Iq5//zthCEFmLSrVJKSOVFLloYw87HQf+bjJCxqHQc3Cf?=
 =?us-ascii?Q?YdZN6jyhbu3tP0IWJwEEB+g/qdSBIuKD3gB/89KYWfWNvzEfIUcnUKnlngfh?=
 =?us-ascii?Q?EKpNyCn5STjSERAxiPym4031QM8eQ6uM1iKGFL6vD5lp6WQgwF8/9rrVT9Ba?=
 =?us-ascii?Q?Etq0zo2c9xvcP2Cphmq1wyAZtjx8IuTPn9I+xHxzyRv/OZG6Dbjs9alQVfVa?=
 =?us-ascii?Q?ElAnaR11jkZ4i0JO8IXFqp/On0FY02mIURp6UBNcuRwiBg5aLP/utdUjXxwr?=
 =?us-ascii?Q?XyNnuIPWUWkFpQ/aa7dQfYZwsWalD8cXJmT7p5+b0E2GYZh3r2gJ9/OMjuYG?=
 =?us-ascii?Q?/LRE4f07Q5G7YB09nVJQxmd/IZyPrN2bHl+lw0J/zcA2DSmJ48OyL9SXUzP/?=
 =?us-ascii?Q?3ZK3W10vmzeh5eFSIZz3XrpjE0WLUo2lUbdfiZmTrwvCMHmqQJqQT+PcptAv?=
 =?us-ascii?Q?itY0rC0ZAnv/fdlHtQ1Y6uHntcmTyPvnXkEomv88suYxk3O47FpjRgVR8UMm?=
 =?us-ascii?Q?hc3UVkmAblo0cxCvQFRRXkPouxKaXCBOliUIXcd4r/OzGFj76XCTwtF4R1wS?=
 =?us-ascii?Q?htIvXGhVLvzcBiyLP1oZmdv8m6/clvWz4HI1+ZEUNP+jEx34k0ONqs2XGyWX?=
 =?us-ascii?Q?OsRq9V0f8dH7/khyuQEUiMa9mFR8RvwuVfizdcOUDPwyW18cnOOqLSvC4fBw?=
 =?us-ascii?Q?XeNuW+sHYQr4GqaP//2a0dDMxdFUHCyVHsma6g5udrLCbCEUkeef1YN6JJ8n?=
 =?us-ascii?Q?L9fpMli2v1h7KID1iEdoD6qkMLQp7I9xZ6V1dJqginKy+dYf47IlRMd46d2Y?=
 =?us-ascii?Q?jpInZNY9qSqZ7Fj4MSlWNBE10+TE0OZLsbKCfcWiICXi9+DKeTEk9D4wa+EB?=
 =?us-ascii?Q?xDFUbxsEIWYfoRvrx6tPyFYNTlUpP4oYJjZYF75d0LND8UKt4RPoBlpW0MbK?=
 =?us-ascii?Q?gvCtProBJtkRcoNLSEuiUWNqn56NKJuRBSQ07Lu1LrZjdAQu/7vQlKBd66Hi?=
 =?us-ascii?Q?HwRsXxIOSuEa9j4Edeqr7+ednbIWToZ3q+twNx1fbwxxaKiG42uqAOryde6X?=
 =?us-ascii?Q?AuGd+F5Z9wc9PnsY5UplErtF+65xZklf19RFxCGoaFmf0i0wtkuplE851BhY?=
 =?us-ascii?Q?ngyx1BuRAaM+LyB46QieQqnBowDZQJT+nC+YCyAyW8Ze1O4wuKrpwX4/p2No?=
 =?us-ascii?Q?6TZbqhp7E4jpjNE9hqsOJum9qrJtg7/T4Uc3QORFNL8saS6HiDmgY2Vcy4/s?=
 =?us-ascii?Q?tjB9F9GPfP7e9O/X33MLYV4qAefxyo0BuzVhM5cAIVegTwkgNdmEXybbp3zY?=
 =?us-ascii?Q?AMGdaVhLe0EFwGxLTYy9xC7fyJzaIzLzZEnCaw2MGd8v/44mrFH9T+9wBe/4?=
 =?us-ascii?Q?Fnb1/sB/NE8lApC7ri9XN9m9Ht0BWgzqJKYo2S7dFuuMSMSZQDGJoIYHjhBg?=
 =?us-ascii?Q?v21sHJ0Cso+6InTuaK1w4HDs5OCKzPtu+ktM6DQ84hrqbFaeW0IiOC/q07/w?=
 =?us-ascii?Q?Nw6wW/eRHdKpAJdU2DP+fuz+vpHKrFGIL7DITPMcpSOzGdh9q9w9p9aGz5dv?=
 =?us-ascii?Q?ZPdKoOmlqoR5OG8dK9bL8VHHTl/lJyJGd5Ohs+OhNaLb1TJLY2Q+wePaVyzv?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SbTTzPDMhGCjTHTVLm4GW3X3vItbAFHrHDVMBPFayLksq1AUGIXdXKn7Ehm9482SrxlsyOSoDsjPSVJw059ZMqTmnCSXXkh+fCBcbCxOXS9Y17SNoHK0EU5Iy32mtYd60XguPovtHTWxEBOr7KbK4HtxXfCnArw3s35742yX2gtaeCGv2R/q7FPLfxxhAd6h0bsB+2uySw6n52D/rEf6GEfiWqhm16D91V2T/np4NSqFA1R+cIljVYFTLpRShWyKSnt5gvMImPEdgoPGBIot+B1aAGm/KQdmok8DiLmeOSuvLrrq60VvhN+ahO0byyqVyiyvFdKZU+WMegn4JZLj4Sn4J4hut55AME9CxLoRxmGslN2EUgto7tlg2UgxGWzvdtHx/rPNHlE9g7Ys4PECo7SL7KSqMGhtyjYh5pFu2H2gLVaBAESkfedsQygcI0loGjlkxIrxdFW6rk+OWqqov683mWpjxwHIOUM4BLrSapvt+qtIBhe4Uz8W12hKrsLD9d8+QBbfrWPJMhG902/hCgVRntPdAP7dNXBOtbpiHo/rEzekmIEFAzRJhKqoEsLV5iagzc2OqjsFECt4YRNpjRUBKScnduUzcpRkKw7v4P4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acf05616-5d26-45a7-95ba-08ddda3025ce
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 06:10:48.4658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rU89m1BjS4poJOAEziE+D4QG3wfMMUlV8GamQsByxa6QGXV9XSlK5T+A9kfw2PAVT0NKgEkxn+w3zyKCIG6LQ2BwebdY6VvMusPAqU2aw0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6522
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508130058
X-Proofpoint-GUID: YrnW2HNg8jUiVvH4KAymXISxe4aVD-e_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA1OCBTYWx0ZWRfX+YLOYVEpLpj6
 35Qts3Oe6GNy5fheoyi+ujivk2RIycCQ75kSJgVBejPMcN9Iepiz4jgg0FUhV1ejPoUlJMNVg/U
 YJGS2vtVHA/BvbEpddYN9LlU533g0lJkVjI7X4WMztVh0dZ41sXVEUUWJlpI1z7hCZCFgCh9yBn
 z/wwY+V+tiWLN7DrSu5XK+0J1eRM2S1hjl+wTtqETdbxAdWqi1UCW9daEBM+yUIk/4oMRXH2hG8
 DIDb17TGcnEHUxNSPKD8n2v4smLMVpNI3DzKVOouJu5tqenCQj8NEPcqhWuVHZRrpbyil4NQkEB
 jehE0+qFN6UAtaL36Ke/R9UMmYPpL/Ut+vf30abQPLdJIIVAwCuh/4JxVP9J2OG/fl61VWve8rl
 KfErAwaeXFJrqCX4BgwLizFDsxQ5ROHDbV1mybqP615ua8RY43XtNt543saOzS1gBK4jAaZC
X-Authority-Analysis: v=2.4 cv=W8M4VQWk c=1 sm=1 tr=0 ts=689c2c6b cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8
 a=XNe4y-zn5_Dv9V3B10QA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: YrnW2HNg8jUiVvH4KAymXISxe4aVD-e_

On Tue, Aug 12, 2025 at 12:39:08PM +0200, Peter Zijlstra wrote:
> Move the AUX buffer allocation branch into its own function.
>
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

LGTM (one nitty note below :), so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  kernel/events/core.c |  144 +++++++++++++++++++++++++++------------------------
>  1 file changed, 77 insertions(+), 67 deletions(-)
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6970,6 +6970,82 @@ static void perf_mmap_account(struct vm_
>  	atomic64_add(extra, &vma->vm_mm->pinned_vm);
>  }
>
> +static int perf_mmap_aux(struct vm_area_struct *vma, struct perf_event *event,
> +			 unsigned long nr_pages)
> +{
> +	long extra = 0, user_extra = nr_pages;
> +	u64 aux_offset, aux_size;
> +	struct perf_buffer *rb;
> +	int ret, rb_flags = 0;
> +
> +	rb = event->rb;
> +	if (!rb)
> +		return -EINVAL;
> +
> +	guard(mutex)(&rb->aux_mutex);
> +
> +	/*
> +	 * AUX area mapping: if rb->aux_nr_pages != 0, it's already
> +	 * mapped, all subsequent mappings should have the same size
> +	 * and offset. Must be above the normal perf buffer.
> +	 */
> +	aux_offset = READ_ONCE(rb->user_page->aux_offset);
> +	aux_size = READ_ONCE(rb->user_page->aux_size);
> +
> +	if (aux_offset < perf_data_size(rb) + PAGE_SIZE)
> +		return -EINVAL;
> +
> +	if (aux_offset != vma->vm_pgoff << PAGE_SHIFT)
> +		return -EINVAL;
> +
> +	/* already mapped with a different offset */
> +	if (rb_has_aux(rb) && rb->aux_pgoff != vma->vm_pgoff)
> +		return -EINVAL;
> +
> +	if (aux_size != nr_pages * PAGE_SIZE)
> +		return -EINVAL;
> +
> +	/* already mapped with a different size */
> +	if (rb_has_aux(rb) && rb->aux_nr_pages != nr_pages)
> +		return -EINVAL;
> +
> +	if (!is_power_of_2(nr_pages))
> +		return -EINVAL;
> +
> +	if (!atomic_inc_not_zero(&rb->mmap_count))
> +		return -EINVAL;
> +
> +	if (rb_has_aux(rb)) {
> +		atomic_inc(&rb->aux_mmap_count);
> +

Still that extra line :>)

> +	} else {
> +		if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
> +			atomic_dec(&rb->mmap_count);
> +			return -EPERM;
> +		}
> +
> +		WARN_ON(!rb && event->rb);
> +
> +		if (vma->vm_flags & VM_WRITE)
> +			rb_flags |= RING_BUFFER_WRITABLE;
> +
> +		ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
> +				   event->attr.aux_watermark, rb_flags);
> +		if (ret) {
> +			atomic_dec(&rb->mmap_count);
> +			return ret;
> +		}
> +
> +		atomic_set(&rb->aux_mmap_count, 1);
> +		rb->aux_mmap_locked = extra;
> +	}
> +
> +	perf_mmap_account(vma, user_extra, extra);
> +	atomic_inc(&event->mmap_count);
> +
> +	return 0;
> +}
> +
>  static int perf_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>  	struct perf_event *event = file->private_data;
> @@ -7087,73 +7163,7 @@ static int perf_mmap(struct file *file,
>  		perf_mmap_account(vma, user_extra, extra);
>  		atomic_inc(&event->mmap_count);
>  	} else {
> -		/*
> -		 * AUX area mapping: if rb->aux_nr_pages != 0, it's already
> -		 * mapped, all subsequent mappings should have the same size
> -		 * and offset. Must be above the normal perf buffer.
> -		 */
> -		u64 aux_offset, aux_size;
> -
> -		rb = event->rb;
> -		if (!rb)
> -			goto unlock;
> -
> -		guard(mutex)(&rb->aux_mutex);
> -
> -		aux_offset = READ_ONCE(rb->user_page->aux_offset);
> -		aux_size = READ_ONCE(rb->user_page->aux_size);
> -
> -		if (aux_offset < perf_data_size(rb) + PAGE_SIZE)
> -			goto unlock;
> -
> -		if (aux_offset != vma->vm_pgoff << PAGE_SHIFT)
> -			goto unlock;
> -
> -		/* already mapped with a different offset */
> -		if (rb_has_aux(rb) && rb->aux_pgoff != vma->vm_pgoff)
> -			goto unlock;
> -
> -		if (aux_size != nr_pages * PAGE_SIZE)
> -			goto unlock;
> -
> -		/* already mapped with a different size */
> -		if (rb_has_aux(rb) && rb->aux_nr_pages != nr_pages)
> -			goto unlock;
> -
> -		if (!is_power_of_2(nr_pages))
> -			goto unlock;
> -
> -		if (!atomic_inc_not_zero(&rb->mmap_count))
> -			goto unlock;
> -
> -		if (rb_has_aux(rb)) {
> -			atomic_inc(&rb->aux_mmap_count);
> -			ret = 0;
> -
> -		} else {
> -			if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
> -				ret = -EPERM;
> -				atomic_dec(&rb->mmap_count);
> -				goto unlock;
> -			}
> -
> -			WARN_ON(!rb && event->rb);
> -
> -			if (vma->vm_flags & VM_WRITE)
> -				flags |= RING_BUFFER_WRITABLE;
> -
> -			ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
> -					   event->attr.aux_watermark, flags);
> -			if (ret) {
> -				atomic_dec(&rb->mmap_count);
> -				goto unlock;
> -			}
> -
> -			atomic_set(&rb->aux_mmap_count, 1);
> -			rb->aux_mmap_locked = extra;
> -		}
> -		perf_mmap_account(vma, user_extra, extra);
> -		atomic_inc(&event->mmap_count);
> +		ret = perf_mmap_aux(vma, event, nr_pages);
>  	}
>
>  unlock:
>
>

