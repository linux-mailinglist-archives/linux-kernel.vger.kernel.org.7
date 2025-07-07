Return-Path: <linux-kernel+bounces-720546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8E6AFBD2D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 23:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B735189C4FB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 21:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F224285418;
	Mon,  7 Jul 2025 21:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LxzVi+XS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cRgvG3TR"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE70B2868A5
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 21:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751922332; cv=fail; b=rzId57cTczmBGvLjHxU2rPl4aBZ0z6V8FKUV8/3aY9sTMu1bw50yLph6odBwupaejFvpGK94OKOfC4YwK6yF5aHCRj54gOmclbnw2OE+QOYwk4BrivJj1+FIHguAX7FOuJf3y6mmJK0G07Fi7AOxzKOpfK7KaKOP6A5wxkcawuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751922332; c=relaxed/simple;
	bh=mkcFj7lc3mSeA7fCctaH8gopI8WlV29NoSCC+3xZltg=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=sjwoocGn6tESEGp5QWDD9hBhSSvaEQLe/Nf5uwaDSStiCPBCKv+KkPn9L9fOgkyY15ocn79yltbfdqBJxXrr+zknOvpJ+aP9N20qBjQbytplc4yM0V6FY6Rf7ylxzj9qPJoOCkNAq+hdebWogpJQbNkuVGMMBSDKMW9nCkln2Eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LxzVi+XS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cRgvG3TR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567KqDDk027930;
	Mon, 7 Jul 2025 21:04:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=68QGFaeKLngxwOxM2d
	MK4TBwg8purRcKSC0IuPsLiKc=; b=LxzVi+XSbPMV+SrjkG+b77wszXo1lJ1Xxp
	Ijg3nq6+A6aJwWr29mmBTGkSKeswj+bFH8yGNtpJpTs2ok7OLkB9SAh7U1KvOhP/
	Ogs0Cru1bVrXL4JUnhVcOPKBjXoekAY4OM24G/AuPrVBqr7Ouryn8HrcczYb+HyG
	Qeefiuq0qsVK4qVoe2Ic4sCtGTc4BxFrh0YG13F+oFgg3nKwtTSSskSRDBp0JDBV
	UpXq7Z+6rLEIWWcKGxFNcRYViAyT2MaS29RMJblbXFI7AZcahZ1SG3k+4P8VT5dl
	CkRD26xi7/96PyInNFmdJwGXAONbVQSi2EnWm8Bhaq52F6qGu66w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47rnn880th-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 21:04:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 567KWo2n021376;
	Mon, 7 Jul 2025 21:02:52 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg8shu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 21:02:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUUIVhgn1vTayqBnn+Gr2hsBzRrPoIC9eHiolnBZ8/GD0zQqNubp7db6VwXHYTaP5hb1AnbIpCws/gOdMA+LhyFkTmugGDpHrzmsvS44mcDD6wUAz00epfRbA7OPRDgTRJUbL4/NUFOVx+L7cyZhK7bWmAklFI+Nf0qyLAjj6tH+rbjrzPcpYzGSOxTg3bB/gEILqcOUcfRK1sikEbCf+QbRUVJyNQ+Oo35OoLOvkxIkh8BAbY0BoBxepQIxo/7NM0PIP7122qwsM4hIqHwFBCTTZq/MCmZXBtlbSc9UfHPrIZGSgv0PwJu56SzF4huV8RJdW54XSpCoPP4Fgl+XsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68QGFaeKLngxwOxM2dMK4TBwg8purRcKSC0IuPsLiKc=;
 b=Dn9gVOYAmdsHMFY4fegdTb5VQ5f/AehWZ6phMK9PniO/cJ6PtBLnJT+sc8/6vaFQIa0aIofU0qqED2h6huISpa0xPZFmv0F3Lqr8v/OlMLHFNKLr7GV0NnFSlm0nsu/LXqTgx12A+2QcjVKLkBfsRzEFK51b2UPca+GyleTSOphfCLdi7cI3gMNacLYj/IpRGBlnGst4bWl8m49r2n1QaviCROxinl6TU2m/sXxlcEaxYeGhJBm9J/omH/OXpxUMYtSnl1pY9KQAhy6fZ2+oMUn9G9IS3EJ6/iz3vqjSYQUOfWPT9ypVkf1tf2qNcQ5VHzJsE4aWOAVF+aijfPfXFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68QGFaeKLngxwOxM2dMK4TBwg8purRcKSC0IuPsLiKc=;
 b=cRgvG3TRsfF6UZKXc2DsGJGXr/W1cuHYYW3zSmoKOhQp9oK6U5LnLR6F0CUBZvP3f24IBDillT3zooqgmLFDkIvSnuQGC/484I+XeRvxm7ZIrl/mHw4gePWiTQ4lnq1i9hzmlChT5txeQh68wj0FwI0an4Oy4eu9LSSzK6wlji4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB6123.namprd10.prod.outlook.com (2603:10b6:208:3a9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Mon, 7 Jul
 2025 21:02:49 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.023; Mon, 7 Jul 2025
 21:02:49 +0000
References: <20250616052223.723982-1-ankur.a.arora@oracle.com>
 <fffd4dad-2cb9-4bc9-8a80-a70be687fd54@amd.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Raghavendra K T <raghavendra.kt@amd.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
        peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, willy@infradead.org, jon.grimm@amd.com,
        bharata@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v4 00/13] x86/mm: Add multi-page clearing
In-reply-to: <fffd4dad-2cb9-4bc9-8a80-a70be687fd54@amd.com>
Date: Mon, 07 Jul 2025 14:02:47 -0700
Message-ID: <87ms9fr9xk.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:303:8f::11) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: 9335e2b5-e4b3-4bc0-d359-08ddbd99a0f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PBwIsilMJJjguagTcCpQTvxtF8CTb5jzdvyEPhIR04OJyQFoYdH+6/hC40Bk?=
 =?us-ascii?Q?6xJpCWbp/Kk3WyZOozqV3+JMa6tZ5bnGv9eFmLMWulp0xM+j9+hBRqI2GavD?=
 =?us-ascii?Q?DrexHs3BKuaA+IJIrozmnKQvwHPxtFJAiw6aUr+7LQ+SRL1avHvBU0ewtaZC?=
 =?us-ascii?Q?dxV7T2GujQkAf2RNKcWxati3AKBohp4D86I5vvCZlvIeLyD/omCR3HvAbuDh?=
 =?us-ascii?Q?dGiEqDKVIZHySRO4CEi8VDZnsXU58anJwKadtOOdCekhZizvsmbpuqCBpzQp?=
 =?us-ascii?Q?4E24XPVkR+j0ev5fyDND7HpBjn7Hcc4MJZ7rQROElztCluMoobj0KmAvZDJz?=
 =?us-ascii?Q?mJMN7IEXsMXf6L9B2yMPuu5T29qvLpxKaRwGMmrv5z2s1GSQ1tMu19hOM61y?=
 =?us-ascii?Q?r10WWqOlQMQeUHDUJV88IZBGUE4SO8QatQoGOvGnIzU5WSYlR2TF4E7+nVng?=
 =?us-ascii?Q?kABsmvC3RVl8gypoUJjdHNK9DGCMAXdQzn88ylRAO8x8S1l9zsfq46fFqHq2?=
 =?us-ascii?Q?To1Vnq0ke9QZPvie3GzSilYc/vY27/CDI9Tg6Wq0vsd9wVe1+WQXSfZT5ksp?=
 =?us-ascii?Q?aay0mJdAQDI2MjIaHSZxZfAmCdUkPqz3wDQL8Co+sooLfBu8OBfIyKG/UzmH?=
 =?us-ascii?Q?pKy4Ln/58BSzeRmbR9a7jqsM+1XncXkkSmTNVyC2Qdx/gyVQU2ELX7Nq96Q5?=
 =?us-ascii?Q?Lx6hnn7UkQs6H0p2WdyCjTV0o5qzSK+IHL05Eoyxft5BxoFVJaTZPXiYF/nj?=
 =?us-ascii?Q?B30BPQkWNTpwtk9UbZR6E6N5YPxRVTg6zFf6NvtRyVDUVSK6gu6DhgDNvkgh?=
 =?us-ascii?Q?jQmIKcHUXejcJF+6XtWAz7ADt0thZuOxtRZ6+8Mx/KpjSXzeCKZRwskagk+v?=
 =?us-ascii?Q?TO2do3cbTMrFnR5dP66Ap+PNjDy1vxF8A7Rjsm6aWWjFpjp3mUQhf2pIzuLM?=
 =?us-ascii?Q?BlYhwXDu0B9YKjZvu2gG7pcmHB1zskmJi1Eu2llhbtrrPQdKkXvp8F4T82JS?=
 =?us-ascii?Q?JVDK3ObFsYBTrT2o9UL+Z61GbHCxnTUova4DtvxfxMmHeax/R+AJMYsOCYAX?=
 =?us-ascii?Q?toaC4tMYRri4ui3vQWgBYX3uIybElWBgZAg7rqNquEnXK5vlHi01892LYu1T?=
 =?us-ascii?Q?f150hhk6De4iX6ZESX/mfouTDddLr8TRn50FNHl0T0tqk1HyehrROfHJzm1z?=
 =?us-ascii?Q?ose88N8oglOp8/QAY09qcy45ulVLfQTa/kUO8uetUvI0UH8Cn3AVDnLt82hF?=
 =?us-ascii?Q?nyn1fjhBCMWn5EmjmJmN/QFJF6GmPW4Fp22C5XQE3+dc724SmJyMqyTFozpK?=
 =?us-ascii?Q?FQdseOMIjXBVRUUL1/vsqTQQtvkAjmoqRKRuTrWgPBSbrI3eJ4wXZEXpozNW?=
 =?us-ascii?Q?u1mCmSUQc/zyRXWr/zUXMCk2TVNE5hni7kvSVhLBPUzo/s0gVpberaqQFRvH?=
 =?us-ascii?Q?oiq+kPgYQQQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IQufkUfXv+ZeA2nGLVXLdn+Sx3Dn49+bTYsQokTLn9W3W51aIBJ/S4LtWek4?=
 =?us-ascii?Q?vHuqhuJ+VbMtD4KwaWh1EizbIXDCjzdhZ2DXADOqpBMNucboGLi+puhf+NWc?=
 =?us-ascii?Q?6gbdkaScEHCsvUCPy9Clh7DL/be9oxz+0Pl8bV2gJlUNh1qQHO9AWutUN6H4?=
 =?us-ascii?Q?onF8gLypQIYdnOkZACcd5wikGDxX8nkrPbFxq2QkmDLZuYBWOzUcpFpVmU+w?=
 =?us-ascii?Q?Mp1iYCUihUL3EN8OUT9Y5ZkK5Lv6Icmc64TCZvAWFFNXLdEvFutnew8Avpq7?=
 =?us-ascii?Q?VarTxRbhMhaKpDrNIe/9kkLDP6Oo3YuHYes+SrKrjizP/yk8KeZyKBDOBu2E?=
 =?us-ascii?Q?VCztJ/s21+Snm1G+AEAQVeOFCzF5cNpPO7bE0ekuvJhL5qmkHk/GgV4arlHv?=
 =?us-ascii?Q?I4h9++EwfUHPPy0D5muW++8cJgYqn+0ORaIhHyCYtLXWnlGogn5mlt0YLr/H?=
 =?us-ascii?Q?N5cTEcJW11Jke/cMIu1vRcTUQqwFusP4RyyvI/ccOjgMDc9KyaIn+vOkLBYC?=
 =?us-ascii?Q?VpKa7JgNQI7B2PC4rusiPYcli1yV9vZweH2xqnNUfG9jO0XuH0rjO4ox7D2m?=
 =?us-ascii?Q?8myVLYt1A7lP2SkcVc13O+zWTLznN7bC+3ZmgWIPYab0+OSSIoSel1Dv3Xid?=
 =?us-ascii?Q?1vqYUq/xchlJF1Xp8W+UExKgyL3KYRJBpMrodIayDqb+5xUootLhUE5Tiq6I?=
 =?us-ascii?Q?kALP2/gu2Qsevaz8GUXfckHpxmWxnsFnjCjdIIX2TB7XxuaLdlKA2QJCsa3b?=
 =?us-ascii?Q?ZadQnsSDvKBzy2hrfPe2zJlQllPTF3V/HeLgyfWyep94noASLbHm41d/8kDg?=
 =?us-ascii?Q?nIGKcFwfWP5J7ksMFbaB6O2Ii6PSuBPkrF9jkGdRPDfQ6P9EDEOqSG1iJPww?=
 =?us-ascii?Q?/fSusxTdjzXlnLvsztUSk9M0jHvqTzCrvQUDKZXnbCkcDM394tcPcGJCZZb/?=
 =?us-ascii?Q?NlN3gbsn+/KFXDHX4mpqTcqNPWDRRxBze8tavlaFZhG88SLGhdwGot2nyKXz?=
 =?us-ascii?Q?iQBGOARZPyGbiuGXWQBwtnm8ZBJB5lHtAplnsW0Bbis1NNCFRLzwYJpjA/x6?=
 =?us-ascii?Q?TjR0V+NHERj5D1nKhY0bX+pZ/Ie6jerR9nfUiXvje0168NjZyhzAkJ03IDcF?=
 =?us-ascii?Q?5Vq1CU6Z1lyUm0Ffx2FGb84itLFullO3PdQ3E+J5Hast4QaEuj4lfdSL1zmq?=
 =?us-ascii?Q?EH8DShqdFOrjpcu5OM3TJOiJJwg/fuYcvRWUPsxDX2rLTXt+UqVjoLi/SoVc?=
 =?us-ascii?Q?YyKuOIEIDwQ3QYOSNnIhc8fTNFysyfZjRku0uAHVI0bdJqNNlupQN8iBzWpg?=
 =?us-ascii?Q?dXxp9zPqny8cITafZvwWB4gU5QtKDqCtB3ViEqG3TOSLPkU4uVyxZczIf3Sk?=
 =?us-ascii?Q?TjN7FuamIJNtP8YDgI8Chg0ODSkIlsjyPIVnOQYYOD9Gg6M2Zt29yf7KuGwc?=
 =?us-ascii?Q?I9yKAFkjgs1ETLCWR5tU6WnyjGuCQadKeyBgG4XwUtL96vrpERH3r90MKqI/?=
 =?us-ascii?Q?JfdIoDpQ0k6kJa5gi6fGfis69FWvHezUUW4BtuhfY84qsoGYolenooG3a6n3?=
 =?us-ascii?Q?q/ZnwE993/OPdsURZcn2eODpMNPNLFejq9AcJX8o96qUOF2Nn+Q5KrNz6bMd?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	m5MLMPck2Nu+ItUBlJzl3ceKVhV1pNEf1G4H/hsmxro7QnEXu02LMCje2bsfE99M0uYF04RkMr41u2fwDo7ZJOs1Lj8NsHV2RM3r2FE+mHywqhdwov42E9JxchScaO+/skhDxnl0bVR2B23c3HL9LzmKxeaSXVjd5gYcOC0Xko+RssRDben7V214CLTWfRwJKL6/jZsv3weveTxFk9d8QKRRX+WjaNQni9ZnMsoxnseDd5J+8kHhbYSfH3BxBDGnseIzQnbFL4JHQNn73SMQ1zYRP0Zzyz/0ojJgJS41fjhrfWta3+inkHK8koAMCFmZsLYmZ0ljx7Rw+7I9u/6pKa8sH5VxJIez3yLa3fqIbL+lblMknLtqc7FmTGYKVInvLH1Ho4CvgotrCF813ETUFvjta4RdC8B2EDJ6AkQdBsvs6lenGgqp6VL4lJ2JTLAlGdWs2kHwCCRBlPmW+/92O91Xdb3KVYZso4JW3XAkhuLBmX1k+BbNUXzpOqTeLrmfwUiEjZ79Sebcg1O35KGCjRS0zwGMGFSsx9nI6rb5PQF5IkcwKhBrwaflNunXZ0VFSJUtPv7sFpNr2cB7uPFsxYnP176zVAg9zI2RqhXiwG4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9335e2b5-e4b3-4bc0-d359-08ddbd99a0f7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 21:02:48.9054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEJFBaO7zEdo8EN1q1iFmz6R44eo4nC56n+00eiAr23jVncZkPyIEZI9O8hCn0wVfAlzbeMTaetWeyOOD6BkbSEASk9+qpQPc3brquvhUQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6123
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_05,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070141
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDE0MSBTYWx0ZWRfX+2f/H92oWPxM tqoQNpDbG7Mb+YolvL48RD7DYAyCiafJiA3+8ygLJT/kMVZ6nrLGQQrs8O3xCE12YQ7HMvoRxoi ETcjPTWcMs4i3OIRy3p7368shocb015d/fT9bo3pEdR10hLxycvd/p7YFfT810F07CR/FpBpNbR
 eGUex0XnbNvdWPKYCpx5xh9BkwnlAj7Egp+EqVQx6UJODBB1ErH/Ovn4swls41MIHBXYlVtprxK ZJmR6/RO5PGQ0lrQuB9lpN7Xecy46QZ7Ec1yM/zgO+VXouiOJZN34zrw5ATt+PtzaG3TIij6DcI 2H7BNLxyVclTWHB/gYRzZhhvV0rcAcMngWI9Pl+mcR/jUx3z9L8TXId++CSPJP6qcaO7uAWUXpS
 V+w/wNOjKUYnkGjdUU9guNV67XfnKJOFQM2i2BdBgPHd9MSxDGkOdA1oDhUjIsTUMtuWVIl2
X-Proofpoint-GUID: 6MrfGxQbsHPJzY1NdNPPZNpi1W_TtGQV
X-Proofpoint-ORIG-GUID: 6MrfGxQbsHPJzY1NdNPPZNpi1W_TtGQV
X-Authority-Analysis: v=2.4 cv=Su6Q6OO0 c=1 sm=1 tr=0 ts=686c3677 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=zd2uoN0lAAAA:8 a=6-E9JeUyLCDCr6DI-u4A:9


Raghavendra K T <raghavendra.kt@amd.com> writes:

> On 6/16/2025 10:52 AM, Ankur Arora wrote:
>> This series adds multi-page clearing for hugepages, improving on the
>> current page-at-a-time approach in two ways:
>>   - amortizes the per-page setup cost over a larger extent
>>   - when using string instructions, exposes the real region size to the
>>     processor. A processor could use that as a hint to optimize based
>>     on the full extent size. AMD Zen uarchs, as an example, elide
>>     allocation of cachelines for regions larger than L3-size.
>> Demand faulting a 64GB region shows good performance improvements:
>>   $ perf bench mem map -p $page-size -f demand -s 64GB -l 5
>>                   mm/folio_zero_user    x86/folio_zero_user       change
>>                    (GB/s  +- %stdev)     (GB/s  +- %stdev)
>>    pg-sz=2MB       11.82  +- 0.67%        16.48  +-  0.30%       + 39.4%
>>    pg-sz=1GB       17.51  +- 1.19%        40.03  +-  7.26% [#]   +129.9%
>> [#] Only with preempt=full|lazy because cooperatively preempted models
>> need regular invocations of cond_resched(). This limits the extent
>> sizes that can be cleared as a unit.
>> Raghavendra also tested on AMD Genoa and that shows similar
>> improvements [1].
>>
> [...]
> Sorry for coming back late on this:
> It was nice to have it integrated to perf bench mem (easy to test :)).
>
> I do see similar (almost same) improvement again with the rebased kernel
> and patchset.
> Tested only preempt=lazy and boost=1
>
> base       6.16-rc4 + 1-9 patches of this series
> patched =  6.16-rc4 + all patches
>
> SUT: Genoa+ AMD EPYC 9B24
>
>  $ perf bench mem map -p $page-size -f populate -s 64GB -l 10
>                    base               patched              change
>   pg-sz=2MB       12.731939 GB/sec    26.304263 GB/sec     106.6%
>   pg-sz=1GB       26.232423 GB/sec    61.174836 GB/sec     133.2%

Thanks for trying them out. Looks great.

--
ankur

