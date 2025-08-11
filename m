Return-Path: <linux-kernel+bounces-762698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 668F1B209F5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75DAE18A0F01
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49681E1C22;
	Mon, 11 Aug 2025 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K7FAJQw+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JLnMrIv3"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB732DAFD9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754918492; cv=fail; b=QbR4G4x011JT/eVYfcRgtRh9Jiz9FJYUjgOyPF0iAqulScn52413TlFSczWWzqrLjfmRgeGgwT1ASh/MqOjrTcDMycGRBjJmUPNywPnfvly7H/G7rdHGkMzRa1uIYCg9Gb/oB2DfJC3SJnAyf2pMA/zV92O/aU9UH/uCvSWbQqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754918492; c=relaxed/simple;
	bh=GmPeTgjsBoyrO6Y/G+C9BRWAqY/+Hw8122o/Im4+Ywg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hRlo/784PbEc9W9l2sw/xQAQ9IbbzF/I8+0nTOvrc5M7F4d/ITTXdBnugaau/E6IjtrzsDp4kV3q8QUD2AZvn9xiy9CMuNNt7j/Lq3jTO0Fv60kYxOf8EVyfSXwebEjIO84q7P6814QQpOnoilsorpMtcwP1ljzfZN9yqI0Pp0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K7FAJQw+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JLnMrIv3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BDLAiE015367;
	Mon, 11 Aug 2025 13:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=PY5+m0UMUpCy3aHAjF
	syqNEazI9lZf3txrL0BVWn7pI=; b=K7FAJQw+antPY+gPZrwyjYekV47R5H0Bk3
	WaegF/McCmHKkNKWN26yS8IjJjSIFfmQryUd4uVbNiY62+Wg0KLNEX1R/Ev7e3H+
	oAk3QrjOJS4Z7xnhemzFG5CYpSFw1X5nNulQFM9LwWH0GOXa81IqIfmC+sKASvuI
	NHsS+HtRYqhfGVw3LQNnX7Vja+9L68FomoJSkh3me2vaihWGzgGSB4Pjcaf8ZMZk
	MYfyCxreLKcRMVrTYxpfNtZBl3YfPtvz7w5Fbu4rOxOok9ssOfT5bH4vGXkl/3FD
	chVx2jc6Yi1b/88DQV/yGHWT4O+8SMOUUmZau/5JiOBCChPSEl1w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxvwtf79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 13:21:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57BCrgPD009647;
	Mon, 11 Aug 2025 13:21:16 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsewjr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 13:21:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdyEZI0xDERzNuxIIq05c7boEPHY9x8nl8ZekK2Z0M6kJCr9MukgBl+7dWGVDRTd9zrggsW2so4ZHBDlTWj1f4F7nyqtXQt6mXBpJnsNZCZHLyr9XUVALpcpAF9G56BuPDefaHqnqTktaB3XgtRDqAM9JMhgWI+c42zjd84y5FCW9JGf0BNE6T9255xO1n5ifAPC/OonOoPOaHB7bGm0leZpIh3HWZqKv8b8yIoR6cReSefTigjlZXGjYVDKEkRUt/Q6+Jm0pfZKVj2D+n4CU4/Nr+Yg8xHYVNhIPkyNt9dYuff6l16cw+dmzPKCiU4YjvB4ulL1/w60Mw6QwPzWWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PY5+m0UMUpCy3aHAjFsyqNEazI9lZf3txrL0BVWn7pI=;
 b=P7Xmgn+G/k5JtmhzVCI8c07aPsPLw+fh1aPmxwW3Tk3Lh4Af7Ais2Oy3cjrMLu/eaqZHRYYSZvTL+8wNJ1gc6h8NId9oNo4p105SDURQXmBHcUvNSPTFjkYHR/mpmFI0Ue+8l+NUpVsRHdTGMD4IUbOenS8Kgmw9XAcl5c4CdKJgVD/SJmIOkr7wDc+MhDtDdmzJZZDPuUQoxPccq5YT1CpveuhID07CHnf+0VAZItyUqo3UlZ1nmQ5sW624iptyGzP2dNQKLCI+xz4Mdb7LxQD67/PCGWLtI8JGHA+2SjKwNH8gzqtf6YovBEcD2IFYqfOvPiLaEC6LOdGoxARF2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PY5+m0UMUpCy3aHAjFsyqNEazI9lZf3txrL0BVWn7pI=;
 b=JLnMrIv3aZiQIppwEzCzsiz3XeMXI/KaPKAKWcV6C7ekykoccbYwFr1mbQTjlTJVhZpEzD2X7GCLOG7YqZurVpHzBsnsH38biNEySx/k5nTeAdm1Kknd6DP26g/G94sdz+eOCoSGNMcs77n4VLm45p4mVAxa2lfDMCW8NpYQKAo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB5989.namprd10.prod.outlook.com (2603:10b6:8:b3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.21; Mon, 11 Aug 2025 13:21:14 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 13:21:14 +0000
Date: Mon, 11 Aug 2025 14:21:08 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Kees Cook <kees@kernel.org>
Subject: Re: [patch V2 RESEND 4/6] perf/core: Split out AUX buffer allocation
Message-ID: <b606c5fc-2463-492d-b978-e8cf4dab01c7@lucifer.local>
References: <20250811123458.050061356@linutronix.de>
 <20250811123609.667172352@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811123609.667172352@linutronix.de>
X-ClientProxiedBy: MM0P280CA0108.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:9::9)
 To DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c125b7d-eeae-4757-2e57-08ddd8d9f243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e2+1301SB54uOcHZrcz/oXBpP3r3zOsurJtC/x5LMw6wDSYueXSYRmBQbik1?=
 =?us-ascii?Q?MS3BWZbEQOsd/i1y2gHbzjxNqhSaWnHgclswPu3JJMmWme79x6Bje2s3sP8e?=
 =?us-ascii?Q?1qQYsunvOR0DdDCuJ1Z8ije1/i4btQeyXlv6ETiwy4IXwgnYBnCdlMai6E8+?=
 =?us-ascii?Q?Ea1RCJ9nF0o1gtcR/rJtbNzvWVkEAOgM7otgRmXpR3zbhs7S/kH90co83nW8?=
 =?us-ascii?Q?OK9EmEIfGRVuOMp/fxsPNLRBEHuYdnjwExzsUOwjzlb5B/FPJdqKWJPBuo3/?=
 =?us-ascii?Q?SthYCNdddvz+K5iUfnMCOJ1GN/5MwAUKp4PfZ5VwvTeP5R5p2pU1GExO8/Gc?=
 =?us-ascii?Q?LtgjGOPVq1ECi69QFXDZhduOS6ckB6gqvm84VFM+prcAZbgkm2OcWP/7He6h?=
 =?us-ascii?Q?igiOEytUGzqHGnQGL7VVJHhOQmnYuS2Fwau1y3seyFvSCt4uOJBhfjc2pNAx?=
 =?us-ascii?Q?0j4LIkMvz194CQBI6sb5nYEoBq3ePikbbLEAUIbdS2b/eCjU5vqd4+Kfd+U5?=
 =?us-ascii?Q?f1LsLtDKR2KlLimWTg62pUZpTQ0FR2rze9BJQWsx3QV8zZ0bi29sDoOWNvPl?=
 =?us-ascii?Q?Sec7kVo+XmDk32Y4+kubaVFu/SdNRZrDf8kU3rE3JhLqwFXnaeqs+DNCmg6j?=
 =?us-ascii?Q?3n7oypxZpQRmXAoExVZpet12GmWIRVo7y9f+l2nhQTtPbkwYnjxOyONVuAVp?=
 =?us-ascii?Q?ynEutc1yHTSvLwrHc9Q01TjVXF48nY3tBQYtmIvk138/LShu4ZxLrQfAGuK8?=
 =?us-ascii?Q?hyevTxuF3b5II0r4OIW9OPEmlTcINm0WHFVtzMP97CL2oXikUqqWJg9clbtC?=
 =?us-ascii?Q?6PrWR6h8ykyRc3hw1Wgv/p5aSRRhZrKRLBiKrUPaw90QQQi/29Zsh0yM9Rzn?=
 =?us-ascii?Q?OSMI4A8y+G2BnOy6Nv33YyUFXgrjRTjglSZILsDuF1Ll2MTn8lPe+HT2lnG/?=
 =?us-ascii?Q?cEWhPt9mX4QEPudImDMBTIAX24xC5Gv+ooaJUm3nSNvd0VJ7FyLHJ5p4e5h4?=
 =?us-ascii?Q?JtNj2xeYdtymNZRsVbzMzGRFbAJNQHfpp3eIab/xd4U+TqiLX5lKF6EE78gy?=
 =?us-ascii?Q?4iFgtru46ORGxA8DOO87rOpBv52THt9xeDGiMQYmXoVEYHiyo9wgUpbSlfEe?=
 =?us-ascii?Q?LOnIS9DDRo8M+6LRFRg1B2ehK25Oyl5dlh/a1qhh3SEeZspTQHYQTzTRgJf4?=
 =?us-ascii?Q?jH9AXpwvj9TNql4nX30O3zsP+i44aCloXzdUQr4gVh3xbYWfzI7uG0Oi9BBt?=
 =?us-ascii?Q?5MRpheXuW+aXGEnB9FdH/U5CEZ6BLmn7kr1JSkqsePVuZWlHtx317Vem7aP3?=
 =?us-ascii?Q?Q0yIQNpKO1jFA2G5JB6qZuWSE2thMGlb4EosC9OWGErvsZkQYcRUpT1qv2Ou?=
 =?us-ascii?Q?vhGFfSDkYmVUoS2SitprKDWUGXcWwXk9r+zepaavyu8L9hX2q+DFptJ+O3/1?=
 =?us-ascii?Q?B+lrVrPtLHc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QL4a2KD7FZcgn+p5y7OVhK2U/K4VziAmNDhG8a1qOuI/L6ZlYIG/o7FL3k0y?=
 =?us-ascii?Q?hZO61xH+S9TSp/tDP+qDaHIMkusWEhwt3e7V35ICmhTN5rta5Ex19FzfFnYO?=
 =?us-ascii?Q?L2Fc6igHAyDlKbb3UrG8UW5ZESjVNFm77jNy18zFa83XmQOK/BVKLRvGUAcE?=
 =?us-ascii?Q?rx7qCeyK2lWJFDtnqRTVqiRei4jmg0NMmo2nYP2KsjO/FeMhIIRumRGFNJjE?=
 =?us-ascii?Q?RdE72/UaFH99QFdXptp9VoM8OSiGDyLHjKtkX6+H+ilvjt3Cvc5J1Q1vTrRd?=
 =?us-ascii?Q?KL6sl6ceXUQaxDSyNs31VPS1cuy/PQhp3wTbY2UhMPXf079pJW5ALWc7QHnQ?=
 =?us-ascii?Q?rc4Saye/uVJMvVIkJEhDhEPgqrJKZLDW3L50O0mVb2vLxz9UwBIMnToAIrNf?=
 =?us-ascii?Q?eoBc/sdVpaaW+S0IfihDYbdTnK3oo2bzbGyjgIo9LwAupIb1RsZVbeOdq9gv?=
 =?us-ascii?Q?re5zFaEEgII+nQoP320qjaBQ5Xz+02HXHEHAJS5r0EACIdQ/a3lytUdh2WAS?=
 =?us-ascii?Q?9BXGKUMyKF/fo8bNAheLqxF5+C/0DSk3FHq+rIgnFJ8z4qJ1E7yHiTD7zzPf?=
 =?us-ascii?Q?wQRjxU/qQ7bObYFtyN9PSI+jKSu7h4NQrYgKyw6/2VQmMCXnrJBBsKfdM8pv?=
 =?us-ascii?Q?fP5APyIYhrb+DRTl9JbfTdJRRIB27cqY/YilIxnY3NhUuUirwUJPzFyGyO2e?=
 =?us-ascii?Q?LWur3pAFW3u8CGqdi4k7OHDQc/LulZpgQkjhElzMtRPyFyhSM6XHCPMRUaJf?=
 =?us-ascii?Q?krTLg1gsOqEtHNWTvQeCRZ6FTURES83ZY3q0dtKLyNEolOeSJ2ugOCuRSFTc?=
 =?us-ascii?Q?hyzeK6gpYIp+mNSnu9b+U3NZ5pIyP1kSDKphP0WH8jBizxgBXRKUbGWXbB+x?=
 =?us-ascii?Q?EwAam+aySmOXzCaWi9jubJ2nlVQcnkTo44S7im7OrMEbTn5AOEZ7XfD5YqZY?=
 =?us-ascii?Q?Gp6JVfVpJQWb0XU5YEK20978dyEHENPQGLC2abElU60kPZT/2JzUVkxGLzTh?=
 =?us-ascii?Q?MjjqVfHFoOdlLMGZTifWSmDOs5V79Awofd4KFe/ilA1fytoSHM2Sm7mbEdL8?=
 =?us-ascii?Q?nlVgi/HG3ndK12vEyQ5kUOyexSl9zdzASMBLTkxO0Fle9xcDinzTO5a7a7/u?=
 =?us-ascii?Q?qvcTYmr1P2k2+l0Yo51bgqGNCnoDXMTecDSO/OTH/NhFNlT294/xrVO06SVN?=
 =?us-ascii?Q?nSRHhpNnG+s5I1rrWvy59ad3cCXq/UNX+5qu4emmORKmN+oAdP1uEO+33f58?=
 =?us-ascii?Q?bBzVtGFl8yb4tHOxTLno/Z+DO9JM4padep4Yx9NYalcLf40I+m5bMYz1VmCW?=
 =?us-ascii?Q?uyOOnsxNMvQX5BzqO1oO7kPYGA05ru5OY72/QPJ2imMNDtBG9YQjxv5RHP9G?=
 =?us-ascii?Q?SP+y1peLrASblgV0efTePzhC4PhE/t6bIvqVMuKqb83VEIVTDQ1eFWRp+Z2i?=
 =?us-ascii?Q?xdIMJWQWBKMB8qURXPe3AjLsUmhe2K5GpoBISfImmDDHvFoC29q7lO/ioKv5?=
 =?us-ascii?Q?vcoIIacHSb4ZDpEj0W8r1Kf12M4HB8qqIwQaKeV7DrTgJmB1EqvDmRHea60D?=
 =?us-ascii?Q?MnbU4mGmwX3Jch+6uDpN/s+B2MmfvRfaMkpbzzsQf+qeoABEbddWqoFC4BSI?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fTiI0AV/SXRfpaQbzFhC8XiTAPmbAAZ80xFfUu75sJ+a1qZc8ywtmSUD/huZEEFpIHBR0EIzPdeePEvB00m1JHYOuurY18w8s2maKG2cjZSE38nFJi9/shChlMScNRkvrBDvtLmlf7cfXKW4HrZcQedp+LsPvYwRwJLadfTfk4rdZ44hB6C0rRAOAi3QFUybfIWc++zU0MrUVkiLZG8J4IO9dQPbBgzODKoYXWFsMqJ7mZhrmtViavx5grR4yZ4G2XO9e+KxtmUZFy2tSUbOHvzQg2QIggyA9U7Fmgag/FQ15RjemStjPtL/VE63Lvr9w1aPegN/m/5Cnapq//sVioqFj8wflq3X/sGFlkX84oqELycSqyq04zpK4cBLVI8xi8tlT/7sXxGsY9DHUrvSe1WEVr0Pe5GDW5LuY2UEm6JRDA9GTakcKzpVNQBoqm33AmVIYaf6DdPyUxmmPg4uXIItb2rIU5Fb8yytS/sCsvXK2Z4dhierdFP9lP1b0pHQYnrRpVFrAE9OEn2HPi3WxBxexHHhQOY6D0wsVBsnXS1OqaY5Ujts8CE7Qi768Mg8OPjPlwi5Uanpxxg28mRPokY2WzDsMQLwVdoGtkNEOzI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c125b7d-eeae-4757-2e57-08ddd8d9f243
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 13:21:14.1014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xkVacBe5xiVTCujdcg3xoJs2HTfeQ3Mf2J+wD5WWXzHgl4KFEozrCMxmrtsSrMvVjRWCUHCP557FSs1ot1pUqsZIkDDNMWHsjIRl/8tsC2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5989
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508110085
X-Proofpoint-GUID: fnkzGMZxlwl1tJ-19Z33IrKcRD9CpIpU
X-Proofpoint-ORIG-GUID: fnkzGMZxlwl1tJ-19Z33IrKcRD9CpIpU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA4NCBTYWx0ZWRfX1SW6h4iG0oNw
 EAQB69R7zxA6FRebll01Tw2kp7KWkfhCuckFy1rgcp6qDCSZqgHPYU1A6bWEYt3ZZw0ldk6lv/F
 HhcGYFDifM7lGCUDnTCKw4tp0aes/4590/X2TP1lIU5rropuuvFoM+ijar2R4iMf/KOnmSawCcz
 WSbF/0eQFcvMylhUpfbFLWCmcHzRKmadCeGCnQRqH+4/LYe6tx3Tl7mORoZ8nT0woFQav3wj/KX
 FKGNofenWJhf6VMQFYA46X00D9ShcR6O7wa2yW3ML0foMqkmYbmDckzsF1cvstcFU+hYHdX2Xtf
 4KpzVvUpP+1iGFQUW387zidSQWbFd4LYms39LF/yRLviv5ZidJ7nDgizmAJLWUEwUsvC8nGrfZ6
 9O1b8ZSHx8huse2OUmhjxqD6K3g0vv4xmZ07k0HySUKwuAQWpF38zMAARQaqlFAnwowcRFQM
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=6899ee4d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VrSDyX0xmgaSRFJNXCMA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12069

On Mon, Aug 11, 2025 at 02:36:35PM +0200, Thomas Gleixner wrote:
> The code logic in perf_mmap() is incomprehensible and has been source of
> subtle bugs in the past. It makes it impossible to convert the atomic_t
> reference counts to refcount_t.
>
> There is not really much, which is shared between the ringbuffer and AUX
> buffer allocation code since the mlock limit calculation and the
> accounting has been split out into helper functions.
>
> Move the AUX buffer allocation code out and integrate the call with a
> momentary workaround to allow skipping the remaining ringbuffer related
> code completely. That workaround will be removed once the ringbuffer
> allocation is moved to its own function as well.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

git range-diff made this much easier :)

I see you have also rearranged the ordering of the event->state <=
PERF_EVENT_STATE_REVOKED check and the data_page_nr() check as well, which
comparing to the original, seems to be a correct thing to do (I guess maybe
we'd just have a different error message than anticipated at worst from
having them in the 'wrong' order).

Overall this LGTM, thanks for getting this respun quickly!!

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
> V2: Fixup invers condition and add the dropped flags setup back - Lorenzo
>     Fixup subject line to match the content
> ---
>  kernel/events/core.c |  137 +++++++++++++++++++++++++++++----------------------
>  1 file changed, 78 insertions(+), 59 deletions(-)
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6970,12 +6970,79 @@ static void perf_mmap_account(struct vm_
>  	atomic64_add(extra, &vma->vm_mm->pinned_vm);
>  }
>
> +static int perf_mmap_aux(struct vm_area_struct *vma, struct perf_event *event,
> +			 unsigned long nr_pages)
> +{
> +	long user_extra = nr_pages, extra = 0;
> +	struct perf_buffer *rb = event->rb;
> +	u64 aux_offset, aux_size;
> +	int ret, rb_flags = 0;
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
> +	/* Already mapped with a different offset */
> +	if (rb_has_aux(rb) && rb->aux_pgoff != vma->vm_pgoff)
> +		return -EINVAL;
> +
> +	if (aux_size != nr_pages * PAGE_SIZE)
> +		return -EINVAL;
> +
> +	/* Already mapped with a different size */
> +	if (rb_has_aux(rb) && rb->aux_nr_pages != nr_pages)
> +		return -EINVAL;
> +
> +	if (!is_power_of_2(nr_pages))
> +		return -EINVAL;
> +
> +	/* If this succeeds, subsequent failures have to undo it */
> +	if (!atomic_inc_not_zero(&rb->mmap_count))
> +		return -EINVAL;
> +
> +	/* If mapped, attach to it */
> +	if (rb_has_aux(rb)) {
> +		atomic_inc(&rb->aux_mmap_count);
> +		return 0;
> +	}
> +
> +	if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
> +		atomic_dec(&rb->mmap_count);
> +		return -EPERM;
> +	}
> +
> +	if (vma->vm_flags & VM_WRITE)
> +		rb_flags |= RING_BUFFER_WRITABLE;
> +
> +	ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
> +			   event->attr.aux_watermark, rb_flags);
> +	if (ret) {
> +		atomic_dec(&rb->mmap_count);
> +		return ret;
> +	}
> +
> +	atomic_set(&rb->aux_mmap_count, 1);
> +	rb->aux_mmap_locked = extra;
> +	perf_mmap_account(vma, user_extra, extra);
> +	atomic_inc(&event->mmap_count);
> +	return 0;
> +}
> +
>  static int perf_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>  	struct perf_event *event = file->private_data;
>  	unsigned long vma_size, nr_pages;
>  	long user_extra = 0, extra = 0;
> -	struct mutex *aux_mutex = NULL;
>  	struct perf_buffer *rb = NULL;
>  	int ret, flags = 0;
>  	mapped_f mapped;
> @@ -7055,51 +7122,15 @@ static int perf_mmap(struct file *file,
>  		}
>
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
> -			goto aux_unlock;
> -
> -		aux_mutex = &rb->aux_mutex;
> -		mutex_lock(aux_mutex);
> -
> -		aux_offset = READ_ONCE(rb->user_page->aux_offset);
> -		aux_size = READ_ONCE(rb->user_page->aux_size);
> -
> -		if (aux_offset < perf_data_size(rb) + PAGE_SIZE)
> -			goto aux_unlock;
> -
> -		if (aux_offset != vma->vm_pgoff << PAGE_SHIFT)
> -			goto aux_unlock;
> -
> -		/* already mapped with a different offset */
> -		if (rb_has_aux(rb) && rb->aux_pgoff != vma->vm_pgoff)
> -			goto aux_unlock;
> -
> -		if (aux_size != nr_pages * PAGE_SIZE)
> -			goto aux_unlock;
> -
> -		/* already mapped with a different size */
> -		if (rb_has_aux(rb) && rb->aux_nr_pages != nr_pages)
> -			goto aux_unlock;
> -
> -		if (!is_power_of_2(nr_pages))
> -			goto aux_unlock;
> -
> -		if (!atomic_inc_not_zero(&rb->mmap_count))
> -			goto aux_unlock;
> -
> -		if (rb_has_aux(rb)) {
> -			atomic_inc(&rb->aux_mmap_count);
> -			ret = 0;
> -			goto unlock;
> +		if (!event->rb) {
> +			ret = -EINVAL;
> +		} else {
> +			scoped_guard(mutex, &event->rb->aux_mutex)
> +				ret = perf_mmap_aux(vma, event, nr_pages);
>  		}
> +		// Temporary workaround to split out AUX handling first
> +		mutex_unlock(&event->mmap_mutex);
> +		goto out;
>  	}
>
>  	if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
> @@ -7132,28 +7163,16 @@ static int perf_mmap(struct file *file,
>  		perf_event_init_userpage(event);
>  		perf_event_update_userpage(event);
>  		ret = 0;
> -	} else {
> -		ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
> -				   event->attr.aux_watermark, flags);
> -		if (!ret) {
> -			atomic_set(&rb->aux_mmap_count, 1);
> -			rb->aux_mmap_locked = extra;
> -		}
>  	}
> -
>  unlock:
>  	if (!ret) {
>  		perf_mmap_account(vma, user_extra, extra);
>  		atomic_inc(&event->mmap_count);
> -	} else if (rb) {
> -		/* AUX allocation failed */
> -		atomic_dec(&rb->mmap_count);
>  	}
> -aux_unlock:
> -	if (aux_mutex)
> -		mutex_unlock(aux_mutex);
>  	mutex_unlock(&event->mmap_mutex);
>
> +// Temporary until RB allocation is split out.
> +out:
>  	if (ret)
>  		return ret;
>
>

