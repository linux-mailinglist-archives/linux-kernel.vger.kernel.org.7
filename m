Return-Path: <linux-kernel+bounces-724732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 240D6AFF647
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1CE54816A2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 01:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C119D270553;
	Thu, 10 Jul 2025 01:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rAxX2KU2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Wzk+Y7tE"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA78E26E17D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752109224; cv=fail; b=tLJ63gpDF4CreU7yPhQPjbZ7PacD+VICDK/ikCWw96c4kuMOP8foEoLGORjVbHan6nPUROej1b6LaqIQegEgAC5S0r92ikCCsNyDc6LsRf0iy5aP8iE77ZBN5oZO07JfCS4QXDxBgyJ5gEb+mOC7brJKa27Gpy7VcXOUTSQ8KSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752109224; c=relaxed/simple;
	bh=e0zWQtXD9qDjJdqm0w4gvN9HYdMGJHwakkcsf1PWRBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JCfsjT8xHE3b+DaD5s2UoUbz6pOuoxIXRM0UuuTLkl6iaFsPj+Q0FGagVtsuGU8GdX3/byJpmUKlVCKsUrriVHps2kZZc+VMzZ3/NmUwViyO9h+wVC3sNiFN2djePe7vF4/ryPCjLQKg2dSyXMEytQFz1z6nSOV7qmjN7AzGoiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rAxX2KU2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Wzk+Y7tE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A0ODM3031877;
	Thu, 10 Jul 2025 00:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yHZ7F0owhId1Nj0V3t/dLJRFmpIt8oVtlFY5VptQEkA=; b=
	rAxX2KU2FfJdShPDppYsE2UWR9oVC2qDJVoEWDmT0cXjC1ZzV8KZQ7jds/kBPCu4
	5ICYW+VyCGXt55tLiuZ0XtwHGHHbuRx/edOEuSEhWSNJ84ELVgVeT4+M3x4V2tJ6
	BUZqMpR1UYuUkjzrHuTfgMrdr88tW4irElx0ONGqufH+EU4rQOooEw1fSkOYl9a5
	dBPnHwwdyIkQD6Cwnbt3T7tjXoT1aV6+CQ0XQmAH1kpIpjb6pF8xglO7L7ZEqhVa
	CE2FO3tzdrAyxDD7u+jKCdd7/1itFOWo35O9yqh8VZVQV/4bTATwRczR6U5IHyB0
	YwzHTNmizWA2yyr2FIsGCQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47t2wn818r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 00:59:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 569N8lDU024219;
	Thu, 10 Jul 2025 00:59:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgbvxab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 00:59:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=biquizSaULDY+IgWw34ek55nYaVnMG/bB3LFfqc83zxi02JSA5y9jQyBTBgJNp4JtNEigGuwccDvoCVKA16MqEjn3H264Tc/nt8JZihKzZhGrsEFMkyLj4fYO24XMgz9T7UOW19A6dEEVrJq5hqTNz4AtnXUvjPT8sSTAt9on77+/uYnaLIAgNy6l4JIq9gbp+UOfUwvIs8pew9G4zVnMxC4oj8qp/W1rgpYHpJxJhXn4gcku6+JmOQtmHm82zEOviXN+ZZv7igNDyp959ECTcXsZpNbXLg59kNozmBcg1BbtOBswLQCG6y/dxa8IHpUJ4jqNgSLBLK/aYu0F6reZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHZ7F0owhId1Nj0V3t/dLJRFmpIt8oVtlFY5VptQEkA=;
 b=ONyaKL28vTxT4IhBpDZTnSCJN+TQlqnGXiy8larQKK3hVdefzPrWpQ3pld5y4dOahpkOxIT/0jTDXVxmfuDMSpZZmUpoiuc09vtykoMPx/kptANdJw6B5jFZktsAxuN3xZufKH+bNAlZs95rADyb4MVMvuF1e/GF61dyhBonCDp+oC1IsgxI7Ihenz3grkHWYf7YCE+NbEJyel76NF98p/XRLc5+DzMrBqNErtoI0WniOprREWz41mTjV+I1Pr1irZsjgSfyRKPATXaXmqosl/F91fj/+GB/MHGiyY04ZNFCVlA33yB/o5HZ+yWciwijrdYGjai/bDnlL+oYgkrLxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHZ7F0owhId1Nj0V3t/dLJRFmpIt8oVtlFY5VptQEkA=;
 b=Wzk+Y7tEO3bfnMwj6GMMsIuo28MyRfMtKvXvtNATDSASBc9lJxvJgeyiqr7WnRctvdG+w5MekVMA1MDz+EdEI/cffSl8iZC8Du0lsGtSyPQDu4uqAzvwkqH9V+Ovrlc5iWgP4bo0R24iJR6o29kqOf/9RfLGNCb74erR44SGnH0=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB8078.namprd10.prod.outlook.com (2603:10b6:8:1fd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 10 Jul
 2025 00:59:34 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 00:59:34 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v5 03/14] perf bench mem: Move mem op parameters into a structure
Date: Wed,  9 Jul 2025 17:59:15 -0700
Message-Id: <20250710005926.1159009-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:303:8f::8) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: b08cdd5f-31d6-4d53-a672-08ddbf4d0913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QSw9myhhM6KG3OS20Otx0qikFTlNoe2BJUYdMb08L8MmQWjb5fUSPPeIRvlw?=
 =?us-ascii?Q?zx5z+wJRPYYybpJNgwdl+GA+XZ//Pp7b2itJiUsF3EACvtCFLooxcmPjSSQ9?=
 =?us-ascii?Q?AzVXmOZM8W1vYfSF6i1g5WJWXQI+M1KcIkRwrC7r7rViAwhHAEiSgVg6re+X?=
 =?us-ascii?Q?jMfT1DBSTTIlorrham1ocy7nIC4FWWEfYWKPagWdm2crNL5LcW0r8GOn8vw8?=
 =?us-ascii?Q?zL+rpQgRIQyszwTvzZTGxY6t/ShhD83aecOPiq6cdVUn46KkyW6obWvaLYHJ?=
 =?us-ascii?Q?6klz52rInk1idkK94PX3iQQkKnajBzpV3lL0qNan/8qzSRq7RE0Uc8oPyRlX?=
 =?us-ascii?Q?AJ2wufPqgt0mpHprMOK91wtqAygLbPmbTL/E/DXw2TLiowM3yVmv2Em8xfic?=
 =?us-ascii?Q?zs2ic4sESoZjDyCEo0MHBQVY7Ea0xeebjJpYAXSG8FCBL29DE90NJGoB/z4a?=
 =?us-ascii?Q?DkjZH+8lXvgqWnjJNgHL7Ke1gqXaPJMUtge6NqVflBO4Ihg1Qx4oUJJfJPgh?=
 =?us-ascii?Q?ubWiTtLdX50Q8X+ZESyXMJQkQOCszbr92z/wIVZahqc9wPlrUQf/FmQjAhf+?=
 =?us-ascii?Q?ctgb/03kWbly7En/cDGxwjZxCOCqXwbFugthi5rbz+2mdC3Wy/+V39Yb7boC?=
 =?us-ascii?Q?q2WMvsN0AhxBi+6ro7SABDks81LTvx22EIPY5jKSFhCKDofL32ElrD7vDwG7?=
 =?us-ascii?Q?jfqOBcBx0GpOkGPHZwyCtclIHoiQITZFup18ri342w51Osz6ZDu4AIxkd7jW?=
 =?us-ascii?Q?cRBCuGbXowfLV0v4TKZTx5Rcc4rm6lWw2JEwa/+CQ/mLgRFtC8liyNs043Rn?=
 =?us-ascii?Q?Du9aHPYlWgG0fuZw58889k29YO53RZqRBuQGijPGXuJV//A7OyFEM3kmyTli?=
 =?us-ascii?Q?2TjM5LhdA/ipcfdWhnCXwZki6RaPPMHNWlPcogaIQWJtmbpMvvbRFd2fenUw?=
 =?us-ascii?Q?HMah1BqYER61wU6uzXCDnY0k5v4Ro5+M95KxF0hYao4znrPj4offRLZj6Y7Z?=
 =?us-ascii?Q?2xRUyAb+5NE6RrLYyeST2ERpOB/gWnCzgPkW616d4kPLhlGyr9H7Oyw1rH+b?=
 =?us-ascii?Q?bjVX8EwAM0+MgogUq+uoCm2FUZYFdrBHgjw83eQ8H/slH+q5fM9KP9zHXM7w?=
 =?us-ascii?Q?9KFxJ9KUg2epFUCRTSa+D4r4fZXlIq1Ms1l9dRDkUpcZ4a1t3PMYN2k4mMFX?=
 =?us-ascii?Q?gvjKO2J6aeuOOYWhowuKKi3FK23soa+IG8+u7nsLDqB/31XCrEcffomvh/1a?=
 =?us-ascii?Q?W7J6jUaxOi88Xvc6QaD43iVDzQ7g/O5dmm46NaxXw+z9PPG22R/scmMQM4Xh?=
 =?us-ascii?Q?ScquSBZ2rL5YzjGnk///gmnwZVs78tIUZ2gAm66TbDFcR2JA1WWojz+dUEi8?=
 =?us-ascii?Q?rWmjxXv7vP1yYudMGN0a04FGMp1/gnm57AyN3CHES9F/tIo3iCRn9vOp+bsx?=
 =?us-ascii?Q?jbm2uz03LHo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?udNW0FeeJrHJa+Ecl+1DKsle0HDPeBo+raCkf1y8shYVIO6UBPEHO6DmQVJy?=
 =?us-ascii?Q?5PDaUltL2bd6iRjKcniRUHJtWlSSNko1nLTl7tuLwrIcUnySaOA3vdQPg/jf?=
 =?us-ascii?Q?uOiANz1Xw7hh8zQHtqyVa5XXi+eClboJfAsfOv/v1eS2ipf92H3YzP0ADB92?=
 =?us-ascii?Q?+LzwMZqUmVRoodMy3Vjcx+Jh8CZArLID1TvIvpVSDWGQkfQinPMqUEdD2Mv5?=
 =?us-ascii?Q?CmPJ2sF6MbBMK+j4pW+dELofpAgdF8JojtDROn6vyTlzju2kgyb/wgLxmtZj?=
 =?us-ascii?Q?VXPDwoBhVUJQ9FpW4yABMdhjAu7lvoPWDULIEAX/5/N4cataM++DHl7ZUA+q?=
 =?us-ascii?Q?w+V2xO+zTKjQH/UPMk45NwMrZxhS1HIIoS3Pk42Bh/4q3gVqP1V66czLCwgD?=
 =?us-ascii?Q?fBEphL92ZCz2R4IIil060efsjL6u4YcYDuycmhovGMC47+uNeZtJjshYP3NE?=
 =?us-ascii?Q?ic0q9efHXnw8ii6+2W+yvC9Np0vsvt1g41FDgO0g7xYf6MG0DqlYXJlge//s?=
 =?us-ascii?Q?RUY6oraL6ldZY5Btckx4C5G6D4dG2sq8cAu48TO99qgFSZvISmvad9Ko1jwk?=
 =?us-ascii?Q?ED8orqJssTzqSiBzu/ezNY+zPY3xZRK91LrrK+95dgnGFWdl7ow14oTGWwKN?=
 =?us-ascii?Q?LmoTSCJHCrchVXxpi1U0uug5r5rO27VILoI5EvdLWrpvFAMSdLQsDOivadp1?=
 =?us-ascii?Q?RFTIM9R3uQVpRlZLgUOKkoVRP8/9K4Ivsvv90hDGdL2XAfTNqE7DS0LISqiv?=
 =?us-ascii?Q?HAfyuPm4VxU6Gu3qlg7ebsG4krQZ5pF5nOqk3MoiqsIDOmZ9qnlKsfbpYj4k?=
 =?us-ascii?Q?JOfOgsNiZ8W3tQs8NiMWcYdeSz07WmpXbHhdoBWSssO/GTAFdfZz2hbOw/8i?=
 =?us-ascii?Q?XvQsMpjs3JpYXpu53pWnSYiNFowsrH3GLnbh2NzfIR/QAwqU9UAeIeJkZoLp?=
 =?us-ascii?Q?u/sp/O7fL6FLF0LwKAaRvK+h53kyUELVIHAm2dfBfjrK+bRu2U01GxWl2jWr?=
 =?us-ascii?Q?Q/ckSdwik+tnpso+EVmWwbVOjGqWPDD4Uc/isXQ877NwH7noDWvtGocSGHi3?=
 =?us-ascii?Q?YVY8LrXZIuy7J5OGCkb/r/Zh90OVXr1z47Hkjn9rxb4SoZ9UQsotX5IYxFK1?=
 =?us-ascii?Q?WXqLfeMAtTQEJv+jMh8xXoZWcd+ZXNvX9QjzLHWbsUM7Bq1HHFJQsCqarwbr?=
 =?us-ascii?Q?c7AdmDbN4iuVahW4fMq6xvY0Q/KltivwWPOudCo4v4viZ0nSvw86/dS9A9kY?=
 =?us-ascii?Q?rPZ/zPdfJyvUN9OyPPa1aXuiMyb/L2t1bEzY99xYGfAxgsPvGNqVbD3Be6oE?=
 =?us-ascii?Q?kVjIO7niqkn4PwXO6HfLBjCvxgr6o3WBtRwmm6VoPP3oIxn+rr+kSQNIrEDI?=
 =?us-ascii?Q?9h6H+9hhYZcHZX+1/xlQ4AY+muBavruXgh4m3NrT0ZRuTBn7s241WGGL9tLE?=
 =?us-ascii?Q?Yb3dqLI2LThJ3yCQRY3IQU36c+z9/k1RS7GbunXgUkLeWiovNqM8O54mTwcW?=
 =?us-ascii?Q?UGE6q3BLTCjLGZeQF93Ueu+ag7tGWitRWfeWU4j0Ff+Xgzj06VVhS0Z8xq0g?=
 =?us-ascii?Q?f/0ivp22WugXXzvVHU3aD3HU2aJ17Ju4vnlFGIlCnQrkmlTNEjyWEqtc78oT?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mjGZGFRvKXa1Xexf8R0tqyzwaDyrtp26Agfbn5L4hMTAYeXfdqq51TZbrfEm+tRK0NkklgugTAHhtgMJD1BTU4SXtEmAicnTuOM+z0oXzFsfBw+Sp8Pc9+CWcMHNi/ADqAGILwVp0BSjOBFkAvDV8ukiKZEV1Uao6utJRysCGc3AogIF5vsq7DW/NkymX48wSeXoxt/KSEXG5HI8oZvfdfmV/VdUKDPEXGHrrEqNAqwj9nAOfqK7n87dfiPiPY98eFlcudCoe+ppkk/DOjFwF7D5Hm98LdrOT72lUCVPwsqErWviJeF94aq2ytTtwsQVCRk4fAeukdeN5PPQ0bYylG6Kh68ab3RElwb2rlv+ihj9H+yW5Rcm9LkOI86hGMSagg/r1L49yw/UFkHAeGgwbqYLxvXMCqs0DgBkBz09kSqoOEYgeGtkUx26TtRB+6DLAyH3RAoE9+Cg/D5vkC4mxj7lB5HleRpPqGJeiKB8JE3q2/rFkNaL9dyoX4H2ncvlXtU5DOJHpcYBdQbLLpBHK5LcpCJmjprhxw20oY2UdmWHoEH1K4acd5jAoe5OT01Kvku/SpJ3rpY6vV6RR2zWgVzi2cMs64pZpcasskp0AKM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b08cdd5f-31d6-4d53-a672-08ddbf4d0913
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 00:59:34.3521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dEe/h78VEYITtGfyyp3XHQWSit0dLJm4vpD9bQDY28TYDNhNmljhwWj9tFOPK3gWVbNZQQ0j7HQkQZqXlPLep9tx2jMCBs/B2ck8z2WjiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100006
X-Authority-Analysis: v=2.4 cv=WtMrMcfv c=1 sm=1 tr=0 ts=686f1079 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=_WLpKjk4XQ775Vi3V00A:9
X-Proofpoint-GUID: n2qMZb4VmFbzllVeyZHb8PK_4F4UXbfC
X-Proofpoint-ORIG-GUID: n2qMZb4VmFbzllVeyZHb8PK_4F4UXbfC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDAwNiBTYWx0ZWRfX+0XskUCmEaj7 366eJuYXaePlaIyoee+UeT4erTBVF8VB45VimopNAdRuEmzKlz5lMdIVqv0lX/jBSCYUiQhyNU6 xjDqEEyl4B7ON1nOUJYNYjIkD+X7yXV3h1d5izqAyJeYbfxD7JrAnh3QkmdC2FLBuXxOK6F/wUl
 zZrEtY+EjMdS9hhXhSI8wdM0qfRzsmSVPZR5vXFmtxBp+Xxw/OGQEec+7g34c1NjXj+HkDmUT+3 0q8Qo7vBGzCYsIeq+JIDBofrgZtHArI3VjD4kxs4fqv6oMAvSdBNsetGhT61I56V/Cm+mqxshOP XTJfv3PgEqqZOl1oVEvHz4ZhflnyDfmf6riw5nX8NjPAhozvlye68Ga9w5XwCBe1v8L3Izppkvy
 aIc/QYzMWKnEaLCRX4ySqsK2an/gzKVDHtzxNSYpgoooR+mg5YSZAJ5y/KvFg/I34K1ISoZ5

Move benchmark function parameters in struct bench_params.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 tools/perf/bench/mem-functions.c | 63 +++++++++++++++++---------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
index b8f020379197..fb17d36a6f6c 100644
--- a/tools/perf/bench/mem-functions.c
+++ b/tools/perf/bench/mem-functions.c
@@ -30,7 +30,7 @@
 
 static const char	*size_str	= "1MB";
 static const char	*function_str	= "all";
-static int		nr_loops	= 1;
+static unsigned int	nr_loops	= 1;
 static bool		use_cycles;
 static int		cycles_fd;
 
@@ -42,7 +42,7 @@ static const struct option options[] = {
 	OPT_STRING('f', "function", &function_str, "all",
 		    "Specify the function to run, \"all\" runs all available functions, \"help\" lists them"),
 
-	OPT_INTEGER('l', "nr_loops", &nr_loops,
+	OPT_UINTEGER('l', "nr_loops", &nr_loops,
 		    "Specify the number of loops to run. (default: 1)"),
 
 	OPT_BOOLEAN('c', "cycles", &use_cycles,
@@ -56,6 +56,12 @@ union bench_clock {
 	struct timeval	tv;
 };
 
+struct bench_params {
+	size_t		size;
+	size_t		size_total;
+	unsigned int	nr_loops;
+};
+
 typedef void *(*memcpy_t)(void *, const void *, size_t);
 typedef void *(*memset_t)(void *, int, size_t);
 
@@ -134,17 +140,19 @@ static double timeval2double(struct timeval *ts)
 
 struct bench_mem_info {
 	const struct function *functions;
-	union bench_clock (*do_op)(const struct function *r, size_t size, void *src, void *dst);
+	union bench_clock (*do_op)(const struct function *r, struct bench_params *p,
+				   void *src, void *dst);
 	const char *const *usage;
 	bool alloc_src;
 };
 
-static void __bench_mem_function(struct bench_mem_info *info, int r_idx, size_t size, size_t size_total)
+static void __bench_mem_function(struct bench_mem_info *info, struct bench_params *p,
+				 int r_idx)
 {
 	const struct function *r = &info->functions[r_idx];
 	double result_bps = 0.0;
 	union bench_clock rt = { 0 };
-	void *src = NULL, *dst = zalloc(size);
+	void *src = NULL, *dst = zalloc(p->size);
 
 	printf("# function '%s' (%s)\n", r->name, r->desc);
 
@@ -152,7 +160,7 @@ static void __bench_mem_function(struct bench_mem_info *info, int r_idx, size_t
 		goto out_alloc_failed;
 
 	if (info->alloc_src) {
-		src = zalloc(size);
+		src = zalloc(p->size);
 		if (src == NULL)
 			goto out_alloc_failed;
 	}
@@ -160,23 +168,23 @@ static void __bench_mem_function(struct bench_mem_info *info, int r_idx, size_t
 	if (bench_format == BENCH_FORMAT_DEFAULT)
 		printf("# Copying %s bytes ...\n\n", size_str);
 
-	rt = info->do_op(r, size, src, dst);
+	rt = info->do_op(r, p, src, dst);
 
 	switch (bench_format) {
 	case BENCH_FORMAT_DEFAULT:
 		if (use_cycles) {
-			printf(" %14lf cycles/byte\n", (double)rt.cycles/(double)size_total);
+			printf(" %14lf cycles/byte\n", (double)rt.cycles/(double)p->size_total);
 		} else {
-			result_bps = (double)size_total/timeval2double(&rt.tv);
+			result_bps = (double)p->size_total/timeval2double(&rt.tv);
 			print_bps(result_bps);
 		}
 		break;
 
 	case BENCH_FORMAT_SIMPLE:
 		if (use_cycles) {
-			printf("%lf\n", (double)rt.cycles/(double)size_total);
+			printf("%lf\n", (double)rt.cycles/(double)p->size_total);
 		} else {
-			result_bps = (double)size_total/timeval2double(&rt.tv);
+			result_bps = (double)p->size_total/timeval2double(&rt.tv);
 			printf("%lf\n", result_bps);
 		}
 		break;
@@ -198,8 +206,7 @@ static void __bench_mem_function(struct bench_mem_info *info, int r_idx, size_t
 static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *info)
 {
 	int i;
-	size_t size;
-	size_t size_total;
+	struct bench_params p = { 0 };
 
 	argc = parse_options(argc, argv, options, info->usage, 0);
 
@@ -211,17 +218,17 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
 		}
 	}
 
-	size = (size_t)perf_atoll((char *)size_str);
-	size_total = (size_t)size * nr_loops;
-
-	if ((s64)size <= 0) {
+	p.nr_loops = nr_loops;
+	p.size = (size_t)perf_atoll((char *)size_str);
+	if ((s64)p.size <= 0) {
 		fprintf(stderr, "Invalid size:%s\n", size_str);
 		return 1;
 	}
+	p.size_total = (size_t)p.size * p.nr_loops;
 
 	if (!strncmp(function_str, "all", 3)) {
 		for (i = 0; info->functions[i].name; i++)
-			__bench_mem_function(info, i, size, size_total);
+			__bench_mem_function(info, &p, i);
 		return 0;
 	}
 
@@ -240,7 +247,7 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
 		return 1;
 	}
 
-	__bench_mem_function(info, i, size, size_total);
+	__bench_mem_function(info, &p, i);
 
 	return 0;
 }
@@ -257,18 +264,17 @@ static void memcpy_prefault(memcpy_t fn, size_t size, void *src, void *dst)
 	fn(dst, src, size);
 }
 
-static union bench_clock do_memcpy(const struct function *r, size_t size,
+static union bench_clock do_memcpy(const struct function *r, struct bench_params *p,
 				   void *src, void *dst)
 {
 	union bench_clock start, end;
 	memcpy_t fn = r->fn.memcpy;
-	int i;
 
-	memcpy_prefault(fn, size, src, dst);
+	memcpy_prefault(fn, p->size, src, dst);
 
 	clock_get(&start);
-	for (i = 0; i < nr_loops; ++i)
-		fn(dst, src, size);
+	for (unsigned int i = 0; i < p->nr_loops; ++i)
+		fn(dst, src, p->size);
 	clock_get(&end);
 
 	return clock_diff(&start, &end);
@@ -305,22 +311,21 @@ int bench_mem_memcpy(int argc, const char **argv)
 	return bench_mem_common(argc, argv, &info);
 }
 
-static union bench_clock do_memset(const struct function *r, size_t size,
+static union bench_clock do_memset(const struct function *r, struct bench_params *p,
 				   void *src __maybe_unused, void *dst)
 {
 	union bench_clock start, end;
 	memset_t fn = r->fn.memset;
-	int i;
 
 	/*
 	 * We prefault the freshly allocated memory range here,
 	 * to not measure page fault overhead:
 	 */
-	fn(dst, -1, size);
+	fn(dst, -1, p->size);
 
 	clock_get(&start);
-	for (i = 0; i < nr_loops; ++i)
-		fn(dst, i, size);
+	for (unsigned int i = 0; i < p->nr_loops; ++i)
+		fn(dst, i, p->size);
 	clock_get(&end);
 
 	return clock_diff(&start, &end);
-- 
2.43.5


