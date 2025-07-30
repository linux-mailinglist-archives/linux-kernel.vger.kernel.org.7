Return-Path: <linux-kernel+bounces-751117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA87B1656D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B448620343
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE732E03EE;
	Wed, 30 Jul 2025 17:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sDys62Ww";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w6fTA9FI"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7111C1DED42;
	Wed, 30 Jul 2025 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896227; cv=fail; b=ZMDcEqM846wNJTU/jpo3F0kZAqBefOu7cGQ7OL/UcY4IdbR4mWJgzXCcqQE3IOGDbuRD5KarBG9wbrL+c1MACwLU8PyVAxRYoknYjbdi69aQGfxmrKOK7HAFeEHioilzFm3V1z6Q9s0u1IPK6JQfeVEm4pJvSJSe92R9VojCFP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896227; c=relaxed/simple;
	bh=bUxE873Qk18aftD22oc7LK95xWzHuST86YdMlW0pUDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OV1vg6vdqL7SDSzrtBCtO/bv8H4Xxgs1NmdcdBZnCj79gXl5H/nUNQSZ10/wT3k1oSnek+ZevMpYTqwvJwuqYu8TYrfc0Axxvb8sPWFkNv6jlUOwibj/RomYmcXuIWVCjVbumoRcwP7PShHP290Bi4VPy2+rQwqEvRLn4w3We8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sDys62Ww; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w6fTA9FI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UHN34r002805;
	Wed, 30 Jul 2025 17:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=HIVjc7Iu99dTRtkeX7
	7SEVa6Yd4kOkBwGdzN0iLXJQQ=; b=sDys62WwR/cbCz6Al4hCRnbdP2dzutSyo7
	OKyn/YdYtk0wR6+JT7uZd3bmlmErV2mtu8cSgFCuWCdkwR9kjygii/b90Vh0Shqe
	lxjF2vQe9WZhWCqL6vgmUle5DOz1ErINdIOTjUtKa9RTQLf2NyQ2dfoF4zYRtZ3j
	Hy+D0rnzJE5s0xAJHLp3atgyyDlEZZq9YTqrYWKOYFum+OqFFWgMp5SX/2+2VO3a
	sNrceXd5spM8wdJ4o9+JszPCWar8rNcUI6pae02IPGaWjqdscNsTWJHDdxsnH+Iz
	sejkQm4d2+S6eP/3rj/aR1h5etVj3DCVnkbKB4cfAlwihCN9rNVw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484qjwtf72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 17:23:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56UHGIem002467;
	Wed, 30 Jul 2025 17:23:34 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nfbg672-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 17:23:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rb1TWiYGHxxQAVU4Qp2mT6TC8xUwRUVnn6QK0EXqQ3+ZzNV0q/ay9ZtdgFbfJlbVhCNRWpLwTlowsf8Zpl0YKPXuDrF/pYfoYzNcfrR93ATEsTnKbD/3lWQyiXhNlwO78vDa5m0LK0M6E2W3py4+CVCzr5WGILqlJ9VQJhlZZkAr45Oj4oSu2Rq0PV4Waqb0ODOL+3L9WD/RDDpKY6zUc+KuXYmA48FRcvnI7/ky28OPtSDvhg3eTb/ztoaPEMMWJBoU7X9mgexSMD541urFMfw9JuK/+Dv6bnYASmV3zKB+F/GPT9FHlYFrOo2pOY1vSHA8+WyCIn5kkBlagJFARw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIVjc7Iu99dTRtkeX77SEVa6Yd4kOkBwGdzN0iLXJQQ=;
 b=eg8SbdsPKytICDJ8X3ysvREF0zTDAbTBSOb3lXU7ptaWjCADGQr/qzioD0bPqlmSqByQWV0Yf1HlTOMF8HAC28LdtyO3813JriOwiSzKXxYwq2lOOfg7uKcWgj5JfK/VTCIfmBBm8ntSiRWZ8L1caSWDygB96FurpUWXIyMJB6ROo2Wp391HZRpR4FNK9/JNPynii1B9L7Eudi6G0hTNsMyySBdyYfnf72Cr6B26/x+m/UEjh4E2D2M0MBzWTuHy1Q7R7aL8t59mQMPiIW775jwduG7APF0phdknxzyDUvvdd6lm7NEbCbBw+1jQ9oqYS9twBUDf9AxcSz7oHkXeGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIVjc7Iu99dTRtkeX77SEVa6Yd4kOkBwGdzN0iLXJQQ=;
 b=w6fTA9FItikkPtdHyNDdgzfUVGyg5Gy3SJ2h9O7yUyqQ0gx8cqWPPoTmn19drE77YGxyrenGa8vzxIPpyFz8KvbnZEf6GlO/bzzbYOnYMaozu6VsuwXfRLODCf+JDHAfwSHhrmCHOZrtBaWM0NyoIPnm1JM65L0+gKi14hFxaHM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB6054.namprd10.prod.outlook.com (2603:10b6:8:cd::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.11; Wed, 30 Jul 2025 17:23:20 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 17:23:20 +0000
Date: Wed, 30 Jul 2025 18:23:14 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Greg KH <greg@kroah.com>,
        corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
        josh@joshtriplett.org, kees@kernel.org, konstantin@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <eaf1366f-4b28-4312-a820-1cd04796ff1d@lucifer.local>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
 <2025072854-earthen-velcro-8b32@gregkh>
 <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
 <20250730112753.17f5af13@gandalf.local.home>
 <158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
 <20250730121829.0c89228d@gandalf.local.home>
 <aIpKCXrc-k2Dx43x@lappy>
 <a1022055-52bd-4948-9399-908b29ca140a@lucifer.local>
 <aIpSlhPTC9G1AqvO@lappy>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIpSlhPTC9G1AqvO@lappy>
X-ClientProxiedBy: MM0P280CA0120.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::34) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: 12fe1909-a307-4824-5201-08ddcf8dc792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NObv1MqacwH5VECUpFZskRsp1046hhFE0jZmX1ZkhM/VRkCh3lCw67//xgfN?=
 =?us-ascii?Q?EQn4o5lZKW2RSuAFDVxMtmdmhfABEpe2Jlr3t1Ypm2z8t3kv0bvKyqBp137G?=
 =?us-ascii?Q?SBAG7qi93cdk8vsCRSkkOpMDXn3TAGzkf1/DIa9rxUeECPHSXx7ZP947e35L?=
 =?us-ascii?Q?zraxn6QD5hpDQ7Q9xuIoCQcExFkMKQMa2cSwvqyhyWN79sBtued1ksAPWXGm?=
 =?us-ascii?Q?CuXWqY6qQYBfxmitoyP23o2PUWJ+50mqeIXxgd0TI8qJM8kf5ee0yKTUBQfh?=
 =?us-ascii?Q?aiwTnXymNfQZxUr19xGi0gwAAwxKcs/Qezi60hK5AQyTiqUJS/KUsCoxpmQR?=
 =?us-ascii?Q?6ZuruT2hZklNIhlLZC/XE3fzM98VYU6kjrlp5fdd8ehX4nmeVGxnP+hbmUGv?=
 =?us-ascii?Q?hlVd4oI1x0UlcDu/tYKzNAfNFHYqwEM8kZ6BVyROo1oaegyWTrR2jSDXUuzc?=
 =?us-ascii?Q?vXawOm0YpUDv2jc0iVIWsbi4u/nY8so3n1/aVE4VQTg2W7T/wMarbE1PE4zy?=
 =?us-ascii?Q?1+xwZvDGg+okbZfo5JXNCxiiG+RRV/Yvtd7GgVwVWAw9bH1x1MyzayAext+1?=
 =?us-ascii?Q?YA29Y7kLfTxyrMwDzUQ6ao1WNZnwGlto8GUHTqUqR8JBudFxdmJXfIP+PLLf?=
 =?us-ascii?Q?lJikn+bSws4GcsnPMKfN80xaSgJGV2fNch42uP4k/6ImxCNL3rBznDHQ/vEv?=
 =?us-ascii?Q?0KuxWRWggnvNjFUeHpegKJVrnt4SCt7WpGiVpI7okkdSDPpOwwOnF4eETwBg?=
 =?us-ascii?Q?5SUGJwuVnyDvk6IJ2PRTPc2fPjOTchn3IN27ruLnH/9vgejFozSFpYVBzi0W?=
 =?us-ascii?Q?tGiQvEvDUPR4rjJWf403LYZ5D6Z6/6mhmaxO8Jay1HUseCrgcOCnGGndE0Ri?=
 =?us-ascii?Q?ZP5ZC0ifcxlrpPF9yFMzJ+Wx/JjH8qBbXpVRuPdOzZRae7jGQDszUXE2IL6Y?=
 =?us-ascii?Q?LW7ZvLYujS/XYji2FcQz7zhVE0M5rOD59mjK7FIILx6T4wQ0b7zAfmpV5Hql?=
 =?us-ascii?Q?NWvihS2YdR3/8p/HOMt0TI1LGcca1/LwmDyrhVv/vMNm6gWOjN1Wm2BhyuHD?=
 =?us-ascii?Q?ESgrqni2h4N/YDAZIaR2bl3QyGLjzlxlmCVoWJmSRsyf5Yj8UdfALkdgadDH?=
 =?us-ascii?Q?3xFoOw6h1pWGimMwnfYMs+HhFhLuISDIGVeULccN2Gn+euPtsrd6H18ctubx?=
 =?us-ascii?Q?LOCpGhnqTMqENtHqGE5gkO1Z3xFEahq9gLS6sx9OvBC9E2CygKgUG900IiXS?=
 =?us-ascii?Q?1Nug4SdzHofPyIb+Tw4CFm3KQ9FsZV8QsT204bs5Ags/0qhzQ+knDppVpkiR?=
 =?us-ascii?Q?Sdl/9ZwvfNBFlG+WLYrDJEmw5O2n4D92ljEb3TKGVER7Fxlt7sfWGToGuFuW?=
 =?us-ascii?Q?KyFmc2J6xaJnBHrSTU/4b/IwiEWoRct+LSpT6zmfFpvm6Uc1Dio2hvH+G1ro?=
 =?us-ascii?Q?s7T4IbpE2W0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8fUTEXun65YhG5iNhOldbYGNgsBLcifBg8Jt15ootQpBVvo4aMgKei74sFdb?=
 =?us-ascii?Q?LbYn8baoRZ/a5YIpsckNSxtndAHVJnT54vYXvz6B09cHQoxta+9OBFYGz8Gc?=
 =?us-ascii?Q?NJJhxump8JPpQj9SennCy77s3uxE32qhxzcnK5G0eWf8dcdokTuVaTZtiZc0?=
 =?us-ascii?Q?lqTVLHJ2Qylb2dE1pjgL3jh9e5MR5tEyZA9jrtpsdIBbhgQw7g7m+4isyAlm?=
 =?us-ascii?Q?5B1Gn6hXcO3a3ftuAVcvTy/S41mkwp0VocsHgWKaxAIHHE0nRjqQCO+vPxUu?=
 =?us-ascii?Q?i+2A4IJhB9mSlAezOH9Xxn7c4Dy8BzTjZGvzzqY98dH4gXE4QInXXc2k+dnl?=
 =?us-ascii?Q?qKwpxOezaY8VR/hpetZEF2AsBSoQiXA4AEEqojLaQq6i5Cj8EYItP5pdHcfH?=
 =?us-ascii?Q?9v5bqfb61/0L8KOoqw1SdOXRkSl/QZKzMOJJ1bMzhYYnZ10KCrCfg+XEio7M?=
 =?us-ascii?Q?QHobTajcfqwnbAM6xY6DvRS7nnyRpMe2E7YBispVZBSdAbaPVd5gDm7D47EQ?=
 =?us-ascii?Q?ok5IMP6iBgAlfQFddEAi96kGo2BVmtV2txVqbkPrkMaaVymPhT2B58KR9hg/?=
 =?us-ascii?Q?rp7mqYoSr8Pw+2MiSoKWv5Wof2LtxzsQWUxTLByoRcF6ZdY3YzGWF7guGA3z?=
 =?us-ascii?Q?YQMxp7ZZzQ27DfhI1LjRab+GpsMgL+feGuEEJDg2uqDW7Y7Oi3HsPagg9Wzo?=
 =?us-ascii?Q?41lbV59X8EuQKgyhNpOqnqYX1mwJgb5NRfoaTh2iy/LszOXpqHHtI9hRkKO2?=
 =?us-ascii?Q?bYeSV0KO8njdF5VSwAhWZC9xZZfiHYAV4tKg3Xw5FWg3dHZq3WjLBS8aeCtz?=
 =?us-ascii?Q?uC2u8UsSbuz4ihpwONAlkNtlhUk+6EQyAW22Y2PQll1AkL+Z/KcfSLAKXcdh?=
 =?us-ascii?Q?u0namqv81G8oaj+9rbOnzeqoZbesnRonB0C3xwNCVzboZA3ZXGb6EyvDe986?=
 =?us-ascii?Q?Je9I3yAyE8+RbFReXM5xVFZ8cKJuAfsJUJK72DWydO5BUuv6xHgRDPPg84xN?=
 =?us-ascii?Q?sXIo7Nn/Knb/ic5lB0HkCIW/T/5vqfmMXAKEvDWWQmUps0XdiuXMEaNQUN5K?=
 =?us-ascii?Q?0lYy3ikE6r/cpGjFORNrMGaL4hdmH/Lku+oMBbAPAg/HaxcwRcwV+FGFitZ2?=
 =?us-ascii?Q?FwlIJNWPvVMoQsg0BYBBWIAxghhR5xN2HlvyKVJYMT94ZRWdll9A1cTVvZGN?=
 =?us-ascii?Q?LQDdasf0iB3MSqyaiRTGFaomypzrPFr6wfYSuy7TqJKRvX9/sHLsHMnT8sio?=
 =?us-ascii?Q?KbltFiGwfKwfh9LZ82mNRBTZud9GfVTejRnIvR7wmIuSlkIu6m2ngrqwf6dB?=
 =?us-ascii?Q?RNl50fYeXT4rh6X+4C9XzARPzBVhn+sXS3c84RrnofYsCLNZrZ/iWrRZdKHV?=
 =?us-ascii?Q?0GgkijPmkS9ZLuG/eRIvLQH4rJ0rXJgCEFagj7NqxLvVmX0OAapP15vkbV2J?=
 =?us-ascii?Q?q6Gmwug9Wp4HFJdrAVM+VLyhu9GO8hV+4am++smOkayMlIYVxJi2cWbukQX9?=
 =?us-ascii?Q?DAmhfJysOT/QTHhzibBqW+G9Wreg4jYuGAvcVCsqWqu6F0bRe+5Dbc9kK52O?=
 =?us-ascii?Q?DBJsz6WqKvyKHOdzTPkvCqpFDT3xkzl9Xz6Oo+T31+ojC7kjuwk1CJXSPpWz?=
 =?us-ascii?Q?Hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J7h1H1ThufBaJrJwkQqzIIDIMOw+17HmJR3lC8zYmabCL38ChxkOwuTDvEKG9GduVDaFt8PvRQypXRoOlv+BvIsYq2YyNTXNLI7Jkt79vhKNTbW5cFNuPcEuuv2dHWBhRoy0npNWaX476qcSmQ2jtX/4WX/B1+hvSx9ZF5vOfFdVlH0WcYxgEaVBxkMuUni2MfNKo3/JrMeONy2x+Xm9dDDkHUHBGCBjvw0HVUSu+71FfFHrSYKkw72JAgXSvI7ARdFjW/KVFVQ3CR8V+enMwpuouojKX5wBKjS5wZSeXLBnVPZAVfpDhnyFnMfg5gB/22WhyJ1AY2YeHeo2K8+tw3Mnph+Yciqu0U09IxlNgsFn9MLn1raezyxsnIy5zAG638yhoQMpHn1oDfdkmS9hbKDL65Jy5Nl9jJQqgloysgRARwXkokaVFo99mKW3+fU8MVzc19fwSUcmZSPvPt+Zp/RaKQTgjqiMFgXa2ntDTDXndR9PchBsd5GfY/vJq0ZbUXorp9WhXOHbma+ay87QbsL53dmLaRqL5cxKtDaew8cWlwZ4dkQ69kh6B1+oZBBpfslHseoPgrs6GafUC/6nSNRnUvjkHF04WJwryp3KSm8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12fe1909-a307-4824-5201-08ddcf8dc792
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 17:23:20.3807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ox+wDC3yjRcjjenL9jBa2cduJGnHxhUy6/uu0AfKk5xJVXmaPeqprHrOjqDrhDPZOsdMaUo72TeGiCX1dpS9en9TwFdjehXW0j1Rb/2pGsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6054
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_05,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507300127
X-Authority-Analysis: v=2.4 cv=OvdPyz/t c=1 sm=1 tr=0 ts=688a5517 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=tmPA9tANRr5J-Rgr3NAA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 9JaNdTqiaEoJgiPOiKkMBtV57fsLF1Pk
X-Proofpoint-ORIG-GUID: 9JaNdTqiaEoJgiPOiKkMBtV57fsLF1Pk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDEyNyBTYWx0ZWRfX613+sOnUGEfu
 P1Xoketc23xq8jf2qnYUGuZb3MTSs+mAX8VuuGBnO38qHJpSkWbyfACfk1rx8HZK9c3GjQt5khI
 FhWvBKZRxefTl/dZZDqZlp1GoLuwQy5wF9AjSWU8VlOaPARuL5ueWvVRlC5NaSelt/aH75n/5vt
 RczkTg37lPRWPdMC524HNaLmDNWkP2Gjw6/yJ1JtbfLv7x2/6Op/JseXRYaQyJ+UrfOipfXI1kp
 v/YzhOJMts1Na3ePP0BFxAEnWnWmGX/9RdgwsVbnlr26zDcxqze00yHEQrVgTgBHxVrvVtAs9iO
 uZEFqZHFicz6+cAm/J9PuGw5exCMrctNYYSdacSJLmEs8tGA+7ULc0Ol3m9yKTXH9DvLZe01FdQ
 DhnHEoImOtIHOPkQoec0SY/v+62EONp6eSfiM1264fEb5MuFA/owCvpi+hcoZ8Zejd5KwPhg

On Wed, Jul 30, 2025 at 01:12:54PM -0400, Sasha Levin wrote:
> On Wed, Jul 30, 2025 at 05:59:25PM +0100, Lorenzo Stoakes wrote:
> > On Wed, Jul 30, 2025 at 12:36:25PM -0400, Sasha Levin wrote:
> > > On Wed, Jul 30, 2025 at 12:18:29PM -0400, Steven Rostedt wrote:
> > > > On Wed, 30 Jul 2025 16:34:28 +0100
> > > > Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> > > >
> > > > > > Which looked like someone else (now Cc'd on this thread) took it public,
> > > > > > and I wanted to see where that ended. I didn't want to start another
> > > > > > discussion when there's already two in progress.
> > > > >
> > > > > OK, but having a document like this is not in my view optional - we must
> > > > > have a clear, stated policy and one which ideally makes plain that it's
> > > > > opt-in and maintainers may choose not to take these patches.
> > > >
> > > > That sounds pretty much exactly as what I was stating in our meeting. That
> > > > is, it is OK to submit a patch written with AI but you must disclose it. It
> > > > is also the right of the Maintainer to refuse to take any patch that was
> > > > written in AI. They may feel that they want someone who fully understands
> > >
> > > This should probably be a stronger statement if we don't have it in the
> > > docs yet: a maintainer can refuse to take any patch, period.
> > >
> > > > what that patch does, and AI can cloud the knowledge of that patch from the
> > > > author.
> > >
> > > Maybe we should unify this with the academic research doc we already
> > > have?
> > >
> > > This way we can extend MAINTAINERS to indicate which subsystems are
> > > more open to research work (drivers/staging/ comes to mind) vs ones that
> > > aren't.
> > >
> > > Some sort of a "traffic light" system:
> > >
> > >  1. Green: the subsystem is happy to receive patches from any source.
> > >
> > >  2. Yellow: "If you're unfamiliar with the subsystem and using any
> > >  tooling to generate your patches, please have a reviewed-by from a
> > >  trusted developer before sending your patch".
> > >
> > >  3. No tool-generated patches without prior maintainer approval.
> >
> > This sounds good, with a default on red. Which would enforce the opt-in
> > part.
>
> I don't think we should (or can) set a policy here for other
> maintainers. Right now we allow tool-assisted contributions - flipping
> this would mean we need to get an ack from at least a majority of the
> MAINTAINERS folks.

Sasha, with respect this is totally crazy.

Assuming every maintainer accepts AI patches unless explicitly opted out is
very clearly not something that will be acceptable to people.

Assuming an LF policy most maintainers won't be aware of applies with the
kind of ramifications this will inevitably have seems very unreasonable to
me.

You might suggest presuming a policy for maintainers is inappropriate, but
you are doing so wrt the LF policy on the assumption everybody is aware and
agrees with it.

That same document says individual projects can _override_ this as they
please. So the introduction of this document can very well override that.

We at the very least need this to be raised at the maintainers summit with
a very clear decision on opt-in vs. opt-out, with the decision being
communicated clearly.

It's maintainers like me that'll have to deal with the consequences of
this.

Thanks, Lorenzo

