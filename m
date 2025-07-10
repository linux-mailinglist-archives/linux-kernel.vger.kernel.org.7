Return-Path: <linux-kernel+bounces-726154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D46AB008DD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EE4AB41713
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EFC2EFDB9;
	Thu, 10 Jul 2025 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mTLCVwba";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hXbb6zMC"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6B42253A7
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165163; cv=fail; b=CcPczTjhQ7vZO0TilRDr+3FGWwE7v6DH6/23TOYV7xZeM6l7setwkBAWxCjEwnJ0AvcF7eDJCrkB+1t+DMtu5N4KZULP3uwDJHWfIlPi0K9WfQbFUKO8+lspQE2Imu+cddE8fefNIfJBaEth2S1gxph2KJMtI3z1lj49uT5ykOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165163; c=relaxed/simple;
	bh=M5bH2zHkhRRL/GC1zG7J6xBM6ont+Sp1LPZL+YQQKks=;
	h=References:From:To:Cc:Subject:In-reply-to:Message-ID:Date:
	 Content-Type:MIME-Version; b=mslTId7C8pEWFJawYgaZr9i+YU15spiJRIex4GtpoDjyIG6m4nINJlsXu5t5Lzpb70gFzo5ArT/GyNoKLILySYUyq09JaMY7RbgWyYbkeQw9FYnpDGClcjjzohcuy7Cx6Gle5pV07rAm4zNH6emrC+cJJR9I9B7Mj6GDA71aQqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mTLCVwba; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hXbb6zMC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AF2xxI011999;
	Thu, 10 Jul 2025 16:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=S8q7Wv6mFxVDUkKyye
	pqtDNHf2mFUk/2xLDobPpUGJI=; b=mTLCVwbaf51D4aH00wfiC6w5JjWneTSgTQ
	p77NOTSJ2xzlZa899BQq5MxXtEOcsR9DIHfvAFE1/Z94J2lU5cRA+HAe1I0oUdY6
	Sp/ohj1MjyhVVvBwy11rDmv2ny8nmS5ueKS2eMuhc78FyM0y91j+jdHNPa+nH68I
	f5Knch5G0mFVtlmzDdfuolHln5mwLYw6kRYTWD6apvVvl/V+I3ZP13YtAq+XJw3d
	VUfCINA8olry2CNZ34Gj+vJ4PmnUY4tDLjeGMuN4ErgfD5kuaP4LWbIPXkJ77W9Q
	4+zmfTvZeSS5yPtR5e5isOkkHhRoIWXEgDseo1OHKCPBwE0gCU9w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47tft086rd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:31:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56AFMQtG024608;
	Thu, 10 Jul 2025 16:31:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgcrk1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:31:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qONPFlsTBQydCrUtxfMsMFRPKqaAYx1SIkfdr9WTAKNMlMgooPxW9kkItMHQHEq85A1cKXdjWnQ25YQDonlludu7YY1masNOkgpIPp2OfQHd4HwtaD/GWFDpP/1cz8OiegdtbYFJkDXFp48u3nNKGj6xCsVaVIY8khOPLJ+gT4p0HfZKwPCb62bp8eFoCAWfM7Vd9K8a4KuFDvMtEZmgW/+Z8P73rxz6cFEV5eEnfrXE+rxRmDzp5rfTHRuPJSAmi6ougVQL1PzTFY5J0KBb7iZ5AFA5X0hwtkQWJcxrWsoEXMUgBq/lsWqrodOALQuiU4i3Kr8OWVVymCdjsaHoqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8q7Wv6mFxVDUkKyyepqtDNHf2mFUk/2xLDobPpUGJI=;
 b=c7/Ku/x7Qby2WgZCtAYt20SVkaEouj6M2B/ftIPbUT7veXgEuNQwMhnimaTMkVRjWNeuwexQxIEeDaBYDp+TZJXrs440qlm5GCyzTXwWktkpmWD8MFmL6QlIUSG/Qym5gpATrF7+/9OPE6m0qHFAqHJDX93Xn+UcG58Z/tFxygDnc7n0s5tBXJrO1bcmwo2e1wepTCByJOEudZe8VyCkC/HmY4g6IdNnsSK57sK8jTA2cCKYdiY1vyYP36YdGS8EVXbesLyVcIs1cRapVy+uzwnYpCqmyf+KneV+sK2jIQf4xlGlHLRfmqA6eETOxjzI+bi0zq0ZvVF5DoOvtWIiIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8q7Wv6mFxVDUkKyyepqtDNHf2mFUk/2xLDobPpUGJI=;
 b=hXbb6zMC6I9bhZtfRYljolT5/bJRgxQue9r4KE6afXHNr4J+EiFT++hbCjDI06tfT82CS10P4J0UqhhQo195ahLCpvQBVUUgdfO9rbzAZ1y4wb5lP8zyF6t5uD8eoNv3Mizvz+KuiDtGFx7V3eHxcFuhVS8Ujb0CL2tRy2ZsHWM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB6750.namprd10.prod.outlook.com (2603:10b6:8:133::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 16:31:52 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 16:31:52 +0000
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-13-ankur.a.arora@oracle.com>
 <20250710005835.8819c30579e37b90d79f4c53@linux-foundation.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v5 12/14] mm: add config option for clearing page-extents
In-reply-to: <20250710005835.8819c30579e37b90d79f4c53@linux-foundation.org>
Message-ID: <87ldowovm1.fsf@oracle.com>
Date: Thu, 10 Jul 2025 09:31:50 -0700
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0221.namprd03.prod.outlook.com
 (2603:10b6:303:b9::16) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f13745-4117-42d3-4813-08ddbfcf4680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZtHicGE8cg7yDsw4LN4EyvkzQa7I7CErFcXaRQ6WtcjRzoKG6RnCNkDPkcBP?=
 =?us-ascii?Q?RRahI7UxozsQYKxWbtFC1BvBcNY/g5selen8S4JdSJPv36bzV/xq4AcSNpia?=
 =?us-ascii?Q?+iVuJqmbafPkG5tBXPyXhQQR0SGMW+fNH/6mKSIJHlV/O5/biphORqOEdz3K?=
 =?us-ascii?Q?3UI2ALSPWmWVvbja/nNjY/aqLcirojzbtpYffwPgNhlUCw23Md/cvLhZSRrq?=
 =?us-ascii?Q?JO8AXTfIuNa43tfjpD5JdZLMCNhSHn3EsbLVyRwteBFZKnNDkvOEIv/HaOzC?=
 =?us-ascii?Q?KsKYUzYf7nMKYlTRfeSLH7x6X867mSJx1sspSfPmqym6UOSe3k1eVa8P1BF8?=
 =?us-ascii?Q?XOKD399r/o/mRY7v9HElSRafgXQVDY6+EiSKEu1SZOyZk/bX2G9i76n4zVa/?=
 =?us-ascii?Q?GpPxWVymiwl7F0cVE4qfUPEUF22Rxeivo5ANfW7j6CgVLQ9tLgawiPIlNoDl?=
 =?us-ascii?Q?aQ6rooQornY2+G20qmYzGTOfWJ3cBu8RmyAy+BJJAorKC09HL7tR3a/HV4iU?=
 =?us-ascii?Q?JPW8i93U357+/LfQS/vYWW/QIuc6f58O5C5ekXdTVHBWscq6RwbBPuqY097i?=
 =?us-ascii?Q?nQectRcRAJZZlQIo3prQ7TmOTsljpYgBfa5++3i5fUtd2HwS00nAHwFfXTNS?=
 =?us-ascii?Q?qKkexv+3CKSpco/XwFFTZE+Fn9XR6zjqDx9qWKNXoYdsq8KIkC/f6Stp992a?=
 =?us-ascii?Q?V6LfErA41deHsWLMwgnGMW1xkGd77PdcFJlMwR8MnSiSgJ+DVQjcRnwd17HS?=
 =?us-ascii?Q?OfxdpGU/1xZfa0JSclL0MVHP190IwQisNUdEWNMDah0emgrqZduEpuMb7oqS?=
 =?us-ascii?Q?DbLNX1rewij1+yMfC5KSFolUT5niR0hMwQ3JuZL7ChBMhV8UsXKFY+Slu+Gc?=
 =?us-ascii?Q?XfkkVAj6nKfIROsXbxIn9xf5IVfR+63PBY4l5TUVkxIb/xY0J4/ZCTDJ/ULO?=
 =?us-ascii?Q?cZQefpwYZrffl1wIWVisStZos1/UXMkw+Q5T/f46kwYhhPqkTLRPRdeZK4sy?=
 =?us-ascii?Q?3t7dSs6iPu1/lXQBPGFZu+jH7KDiR2zbbnS0PoKiUypes1G4RQV+M+YJWoxM?=
 =?us-ascii?Q?XPwYRoWj625NPf1xAwdVmZqj0Q2xIBgNDktgOqM46TKq0Wokf8ungzMvASiW?=
 =?us-ascii?Q?/pLPcA3pBI/5iAgFEEp81+Ff3eG7e1+IsMXTMA7UgPPiKWCnSxqitILtYfwB?=
 =?us-ascii?Q?vkmJnKVgkjGyeNcIq+A776GycKUTTO0InxGYcyaKj6HKquz4MCygzi6jBGwq?=
 =?us-ascii?Q?IuNA3s7u3Po7A82qKBetMyBnRqjCZot60js59aL6D7GSj6sHM8GnpKKyHJSO?=
 =?us-ascii?Q?X+rtJiqLhH96kYbQu8Ko2c+pHAB4zU2YcgPgxejcj3k/y5Q8f5PHGrByEMzv?=
 =?us-ascii?Q?h6UlY5bJ+sTdF+NktSDz0SyrL2DF2TEji/HEiySWCTzpN6EDg7pVnX8rw7Et?=
 =?us-ascii?Q?xEc8BsX0zdw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i5+Z91iQqoE6MQ77NxYc6n433to5jNXozpydAbpipuvSU1lQKEab52htS8MI?=
 =?us-ascii?Q?jqlMImm8s4E+i0FGYfRbeegw/GBqBKd6CuccscgFDOSa201DKMCVSk5jHUlI?=
 =?us-ascii?Q?SoFqHF10Nv3KAQUrgOWPRpLyUhVA0KYr21y5+2DI0IrvwtECo90T9C45SfMN?=
 =?us-ascii?Q?i167TrROJgTQaeDhWAnlTKfjxoNHB1fLBW9vivdgPILooZS/6hM0VmETWuzS?=
 =?us-ascii?Q?rma48fj9nA1MmePI5pr502zJCBDyyJQWh+Xmge2Pmm13+kMOzWpiZobEBRnw?=
 =?us-ascii?Q?2NXhZyVArMEfjPEAZjDQYGee7OhMP49Tg+v6cBgO8G/Uqu19ILcVJTCKne/E?=
 =?us-ascii?Q?GaAlEBvfNtGw7dHC6KzL7m3H94fL7vgtFn7QdYSaPb0Db8l86CLew0D9Nsze?=
 =?us-ascii?Q?tV5I0LhGY5aJ1Ww/OeTaus8JMx4KeFRK2XXHPwzYxSGSCFl0GyAvgBEdkZoG?=
 =?us-ascii?Q?y0xc7zhgnfeLi7b/EAeJVeWFr9scoGVP2cS/cIlZRyVB9eR0/x1IjS2qHP2a?=
 =?us-ascii?Q?pdqRW6pCdjRjs5wsJGBCUoFJuvaJDzVvZBaDbjxtmx4ERDhKZ1l4240cBTeA?=
 =?us-ascii?Q?4fTyFOujvVUCfTijLKvLEXDjs933KewZi5/OaPlwMg7O09NVag3e+PptVUw5?=
 =?us-ascii?Q?GHpjlAwNsYVSYQC/wK5yPX3K/+kAvOyueli/T9Ofk1Sr/RNn10scZ6trZM6u?=
 =?us-ascii?Q?8a6KERakOOSR1cdVBHa02MersIhj9PvUP7p8WdbhioEqCyBQ6fcYZoU/z7Jk?=
 =?us-ascii?Q?eVIn1MLc1vWBZ9yvxQe9BUYHdEDp/R75KD5NiIkaOKL23Q6unnFvhVJhkCg0?=
 =?us-ascii?Q?62lLxVZbiEyegk0Goxpdr7rIIuOFnPEqdvfi0vHN/hWIEVU/X5EteYwKdTX9?=
 =?us-ascii?Q?31p0vmPu3Ocar6zV+Ae1LBpcBCMHQR8A90dRXDYoCV0vODP97WG03D2yu1wr?=
 =?us-ascii?Q?keIdrsecVUOLWPyJ/HT2FdijjaKVcXrJy3O1Lx+D23fI21A4yOOTEwLPDjaB?=
 =?us-ascii?Q?2RdMZd41Ix9AY7nCwdHXDcfBzK/SEWFEVBw8XGpgCnoxuoY48/sqXXEMJ2qh?=
 =?us-ascii?Q?xTPShxfJSyTa71/p1di2f5Vhx82LxFNkZ0oWYFePWbOav+9lyuIsSHWkcTgZ?=
 =?us-ascii?Q?ZQgG1X+bl16l6+mJ95v+bX/u0ESkClbgwGudEolTQ6gZmWWODuf1nb4JhlHB?=
 =?us-ascii?Q?2On58Nka5N79rvBDBylKtzSNxzUOaLb8j6WJqHssmduuHPCQnN5v8MQqhrWB?=
 =?us-ascii?Q?GJV8J4r4Ow+R63wLa2y6We2fCTjOmR7pkRYdrk91M+9DsnLGA1RHNZcazqtm?=
 =?us-ascii?Q?kFK81nrGZv4+hSSApp1LspXCQCzY0CY5e+SqZvyl2keriXSGGwOlz7KvGhLu?=
 =?us-ascii?Q?4AmBLRQ03cEwNSiTCryA5WRtowSwQYx3Q7ypDP0BIUNfckw1mTFfLJ4yW3Aw?=
 =?us-ascii?Q?hlg2WRk/lObyal/JfLknDCAAFkUfDz1+WrpnQc0xPiyUzdya4R2HRZYczchO?=
 =?us-ascii?Q?oYasn2i86AewMrgJ4dlDGutn0LDD13YnT/x1Oul6ZAEykEw7kbVKrdDCwQkS?=
 =?us-ascii?Q?AGhFdUA0N8XwTp5aPRq9ZcXTtWZ3/FyZAI9UKc0KCpm41DH2NIz6LJ9XzVQo?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fjcsErUuV2NagAxOaQvEbFGEN7OfcmgxU3+Z1YBbkCeW+ZawI4fz7ykGBdLX00CivTV4jv1Tgo8Bkq15UKztYmzWPTjWNz+1y6FiIpYNB7uKlVgVp/cGAbhYwbc0OLiE/4Bfvi+EegNmnSPBxtUTzc3hMiS8zV7nDWYwpeUd7cCt+j2VPQtlwDbE0YOE83fSSg+T/a/MZ2tRGh/BkspnEkfVi9y3dSwj8EcApsPTdfuJ6Za7TvqxnzUIDtJfN0u1FHwFVU1gMy8T3fQYS0mHXJaFqbq9dHdOlUaQah+yVmADtb0WLV6kYR641NOlMK9qEmV4ZmFQSZzWnhtQ53R95cnqPGQ5h01ok5t9zSW3mNjlDM7c9F0RHcXrHsAg/VR6ho8+7eX6+kuP9cxi/bn9LOWSbytxsL2hEe+RwjxzSjerlbaGA2nvpXbqMI6ysrpQnYPwszH7d7PKLERTomgXaGXQ6SBEQKW7RqVZaGO+aQEzsp1xZzOMfQESM0PI7q5HufHnhR4wPbX4+F+ZNEeRbrWv+TIpdysI2G7BYjx3HofZWPlMNdk1xn6W1zNaK/P/dMVkw6K4HqGgCLv0fzSzJYgVwfHVc+JEHxhszEUfBjg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f13745-4117-42d3-4813-08ddbfcf4680
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 16:31:52.0153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7HlfneUuCVWeVl+qXqwbXIqK4JbSBJwIytkaW4wcl3GsmpPFWyMEyVSjBRodpYyWGsG8603DBrPze1VfcxKGe7DgQ/HYE0jtElkfhC/TIgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100140
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDE0MSBTYWx0ZWRfXyGdlC2W98f1u Bo2JFbMZUKrMMQvCJK7orYnQ3yWnbtVAgBdVGcNKxvDF+ZQ4Jkcyn6DaDjwuMlfE8TXPzW16hZV KEsX3sNNjWaUrUKkuLwKCN7EcquvXRHHxdOU+RpgKPUjOgwbV69R7sj+XttVUTxpHmugdUYccLA
 K1rnR4Y+o0GHAht5DyHvyDE3LWgsQOLUbW4D/u2XdsJHQmf/eHpo3oHQY3lAYPDXZrfPXK+VVci TVFZn+qwgtOGmKKJ6tgMqGNv80tb3KilkR2BoqNcSy9+A7foheGw71g7eN8woXmQPhdM/kkoxIR wwOIBieH6PBvUqD2PWrxlIVlOAmNKI5HCdxxIKpOUH9bbiiV6edQoyoYwHOYMrf3fhz0HK741Aw
 L0H1CWW3WIYh609rQ6j+qYnbKkfDNzJfugOCE4R0fG7UmkF62ZGzaBSaOOT4JCGyJxodFEWS
X-Proofpoint-ORIG-GUID: z_IUMnT1r54pMTxv7Go7uGV4hjVVPXMf
X-Authority-Analysis: v=2.4 cv=cvybk04i c=1 sm=1 tr=0 ts=686feafe b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Z4Rwk6OoAAAA:8 a=yPCof4ZbAAAA:8 a=WGH4CLgoqCUWnWhGhc8A:9 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: z_IUMnT1r54pMTxv7Go7uGV4hjVVPXMf


Andrew Morton <akpm@linux-foundation.org> writes:

> On Wed,  9 Jul 2025 17:59:24 -0700 Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
>> This is only available with !CONFIG_HIGHMEM because the intent is to
>> use architecture support to clear contiguous extents in a single
>> operation (ex. via FEAT_MOPS on arm64, string instructions on x86)
>> which excludes any possibility of interspersing kmap()/kunmap().
>
> I'm feeling dumb.  What does the use of a string instruction have to do
> with kmap/kunmap?

Sorry, that might have been unnecessarily inscrutable. How about
something like this:

 This is only enabled with !CONFIG_HIGHMEM because the intent is
 to use architecture support to clear contiguous extents in a
 single interruptible operation (ex. via FEAT_MOPS on arm64,
 string instructions on x86).

 Given that we might be zeroing the whole extent with a single
 instruction, this excludes any possibility of constructing
 intermediate HIGHMEM maps.

--
ankur

