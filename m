Return-Path: <linux-kernel+bounces-824249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A0FB88800
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC0E560CA8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1D02E54A1;
	Fri, 19 Sep 2025 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HUSlCtev";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Fe4yBhMJ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735C826D4EE;
	Fri, 19 Sep 2025 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758272429; cv=fail; b=tRhZGTwFJUURc1jvTFuNj55iV9mgW5+LHfgLkVb3S1cH7T2nUhme9mU6UoOoHus6g2f5x1yHzQQ8qxE4B7cSZZOBxFarUpxjYtZnHGLkToFv1s87AFXn7959tCDltSL8DTsLqg8RwjwGWiP+0LFYkTay/UiSVnKOrgGYIt4F1CY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758272429; c=relaxed/simple;
	bh=BXtuakfX/fV+MQg/8s/ov5hISYDrkFvfSUtgG+hSDjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FVjx4Dq+Hsm9c3AZUHc217kMyHo/9ypYycEkzPt9HTvRcDPbkG3Diy1sor0m5/ZoL2sqxKpCRDI3oCVXLnlUCVMvBblAM4VYQuj8RYAZE0vriU0cQFCb3JAIdagM4lz1a9BWqV1Ia2Yfat5zaG6NUKIaiEQ8clRxJtpD1ETnfnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HUSlCtev; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Fe4yBhMJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58J7gTDq000867;
	Fri, 19 Sep 2025 09:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=zhwdwsS1kGLcEMYw/Q
	kawGUEtF3K04FrNuRmtsu7NCg=; b=HUSlCtevBE2qK5u8vqrDgvgkONj6LS2+rk
	Z8+zW9jKiEomBV12hyMAGDL8bOtnttHvBCZ0dyfz2HnyAFNXpWOtIzgr8t9el9KZ
	IgnWXeiO2JpGopevNwaVV0bsqzTwfiKGPyJ6/F1hXbmFxOqRwkR/gOiu12+OEsSZ
	bWAVQel1A1wxL9Ym9aqu2ZpZ2kZjOLLZS2MV8tHzdmkjdkkebY0PTX2RtQ+pXmfW
	izx0hjs1+4Ojc8Q4i3L4WIu7nwRSkmQZBdoK9KgYggw3OuQR3BQOBFoGJmOdzah7
	+6EmSaKK683pX17zNwUu2Hy5WiANzHSFIpjuWF/wo/E/JLESLZGA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxb558b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 09:00:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58J6tFfu001582;
	Fri, 19 Sep 2025 09:00:06 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2genhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 09:00:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipvzi7/pRXTx6JVhB3ArE64CW4SwOITo54iV0CmPxSL899+EmqiEke0vvSiwm+e773L/exEHvCuO7MCfRWKYPGsWIG81yADmmh2BwKCujjavdrruG5F1e5HF7yCCg3/kVlr2OId3r7UwZReYg3XSlSaExSWv61gZUrwQrMytCMmZ3IM8d+84PmB0ZBtrV6+A7W/7lI7Dhp772/MdjI1yamgyd+HwkuMbpqIv0HiCesJnBcCjkahBbayFEvWydno7jZmLQfjEASEV+8OwGux3SEUpo16tPj76m+tsN6nRjqRfvgXZXo7I9rtTOhIEMlzZKpc6r6MZVu50V94kNW0GBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhwdwsS1kGLcEMYw/QkawGUEtF3K04FrNuRmtsu7NCg=;
 b=fnD9uSIFN+zXkSjQp8BUzWlMWqS+ssej1loQvYbp+z/MJqEI3GRXvkQSYuCIBw20YMf98khOb4FsSJEzbxKwj0HkYqU84bzvkOMRDY5+5ZG15+N5tOd6iRFGcs9pOjTLnAvessGjP/GjR0gXUwnWNwxyacxCbIIiZVVKqgmV6rwx/LMxb4dlQlIYGkof5NZFgK/oRDmF1S/cUIWEqffa8Tf7wrgxKsxBCBmphSnZr9Mali8WwU5SkkTlr7Rj9ue7eb4IIzGTpYQKyqljIhS8MiF8TThqfpYVboKe1VzGBzVf/RhrebTvyzxpFhrVTWsYr9F3H1pZmXFhom1hBMzsig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhwdwsS1kGLcEMYw/QkawGUEtF3K04FrNuRmtsu7NCg=;
 b=Fe4yBhMJ+I7CHNxA7qL2DivPVv4nwTItPrEIizZRCpZHh5USTYC4TqpFAlW9wr4kpuWCYaoEKxrQld/k0GO8FpkFoPVwBVZ/eCUPj1MgkiyQNLXgII8DDcOKl1FnTE/0sbXZgAvOtyJ2ByJ1wZS/NZOyZ4oFwsPbo7lDfbPlR2A=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH3PPF860E415BA.namprd10.prod.outlook.com (2603:10b6:518:1::7b3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Fri, 19 Sep
 2025 09:00:01 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 09:00:00 +0000
Date: Fri, 19 Sep 2025 17:59:54 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Uladzislau Rezki <urezki@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        maple-tree@lists.infradead.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v8 04/23] slab: add sheaf support for batching
 kfree_rcu() operations
Message-ID: <aM0biub0a-px9Ldt@harry>
References: <bbda8c25-b575-4e98-b1ae-b103c6598d38@suse.cz>
 <aMqcXyKRlZggLxu_@hyeyoo>
 <6f92eca3-863e-4b77-b2df-dc2752c0ff4e@suse.cz>
 <aMqyn6nenR8V_p1y@hyeyoo>
 <bf8b4741-1025-4cc8-b9ed-5b566bdcb2d7@suse.cz>
 <aMq40h5iOjj8K7cc@hyeyoo>
 <a32bd837-2597-43d0-9da3-1ce5a53b15f4@suse.cz>
 <40461105-a344-444f-834b-9559b6644710@suse.cz>
 <aMz8hk3lrWiPQYnw@harry>
 <a4ca0cf5-b7fa-48cb-abfb-1e1d016c30d0@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4ca0cf5-b7fa-48cb-abfb-1e1d016c30d0@suse.cz>
X-ClientProxiedBy: SL2P216CA0147.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:35::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH3PPF860E415BA:EE_
X-MS-Office365-Filtering-Correlation-Id: e42ff356-5d37-4fc4-3740-08ddf75aea3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?39VKZEhFrkQRhuoCGnbI4Bd5g2jwZyV4XkdITkWf3AwUp9QKur3uuFl16y8p?=
 =?us-ascii?Q?lEWhHdyZg4X8PTwgdcISnsWbQj9K5YmfhaVneC+K1ngPkmgYgyjxZEX8L5hI?=
 =?us-ascii?Q?I20LMgMxhJ3eUUm1hWx45F8C0UTUhQWXdkZUsytd2pfZmV1Pm46w/9ErRBr5?=
 =?us-ascii?Q?WQ1xRT2XvFjMnkdmXMw3iIVD8dztRo5YiIULEN6xCZlVhY+fAoP72wyBC8TL?=
 =?us-ascii?Q?iRweXSnqjYCCwL+HY3tYQZ1xKb4jTMQJwlorSMh4pKPfESnk3m9O9Qjr1LlJ?=
 =?us-ascii?Q?AbDIecvRO6csvPeK9FoRXf0CQ39oLfHIAF8tKXrd0avYae5aZJh/Zc0F633k?=
 =?us-ascii?Q?Cd/UF3UO1trwIYcFKalYkFHvKIZMSv3rOFNSLKGioz7FFBr6BwdDdPob2NvQ?=
 =?us-ascii?Q?PI0vhOu57shHsJC2D8bjnbhi650nhviv+wzKsdkIYCgOul3M5yrOciQE8ebZ?=
 =?us-ascii?Q?elx8As19HO2DflblMuDWdxh7hyNiF6wXu6s2qfTqMBjfyjfu5ZZ13VeU7ZG9?=
 =?us-ascii?Q?0Y7geuLhy0gdjGqM44c6jubsJ2FHkY7ZcYv9wL58TC0VjjxIwqGJg5L2FYi/?=
 =?us-ascii?Q?ZDqkjuxTcF9vsk8qY6XR6EO0VMgwLrTqjmN1CsuvC0QNSncoU3YcFmcAPdbD?=
 =?us-ascii?Q?9gwlf9lCW/YZQzYvTkk+8hqTBWHdOPwtb61O+dp5DnSrV2z7f7xJ6JxJcaJ5?=
 =?us-ascii?Q?8A+VRaLoFD3J9upzU5So55ofx3II+XxLlnl3RoC/tve5Ay7Q0b9aoGJZVZqs?=
 =?us-ascii?Q?1HXMd5o8Rygf4IJxG0WadP8nujp0ez+4w9WYi9O3B5S7Jh82mcAwEPLHRNl3?=
 =?us-ascii?Q?37ceqIjl000nt59GxG+w1lB6faWlofF3dh7agWmj1p3fePMI21j6w4Q2sEk5?=
 =?us-ascii?Q?HwzjC6YFO8ibl1jRXKAuTzSRlqdAlS5WuCaHifL9o652RZHem0tYpKpD8tET?=
 =?us-ascii?Q?jakdmi8z8OOasR31LD4QVk4sMHM2pDKKWMIHZuKyn1X2cL1CV0Ijze3iYqBc?=
 =?us-ascii?Q?t2+iIl+uYWzr6MuXoeajgcPOCLP4dsPDnfny1JlNR1WeVZnv8ioc41SnDwft?=
 =?us-ascii?Q?PSow7ScZ5DHB0Sp1n1X9EfEJjkwLG3tuQkauSNyCClPt9no6kPlDxMwzzdfr?=
 =?us-ascii?Q?GLvj5nxfI30eJwGpveHRgUx1yzqytAbFHSHw+iGDDQqiZH6/lzqQBBv4GelM?=
 =?us-ascii?Q?QF3EOL0+cq8MPDM+7iTjIScYf3N6MNRRq7XPKpv/+l+DAuS6HAbeaFOtxZ5z?=
 =?us-ascii?Q?h/JXjerMA8w/sY6BdS9bskhdDBIqz31MBphKiCpPg2ApIPc7Rqt/zzWYBar0?=
 =?us-ascii?Q?SyVzLQPM9d9tZx7Tp+wZPWBNH6eZEv28SJMFLgBe7IgxJb8h7VUDpdkfd1jD?=
 =?us-ascii?Q?LhgRvcaOYXUhQhsSjNvUgG+0Gyr5W7DbNfHwzinZfNmD00Vm3MvMGsmovnYR?=
 =?us-ascii?Q?+/CsJ4jVPXo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?USTklX+5BImdylI67q6RSoBlTY17sHbUQkSxwv0Y9HMpURoPjLgIShm54tPv?=
 =?us-ascii?Q?431We1c1lwa+wIU31pzPJlrjTUC48HjQakXhOz3RfopdZI+nBtEjnYOIxmga?=
 =?us-ascii?Q?FKUdAZgoF3NdnRC3fFp50Sd6pcRtiJJ+Vu67WowxGSTQJuXJZ/XtBrmXZ59f?=
 =?us-ascii?Q?OpFCfFjE/aW31hXzyzsWnEJeVCnlaOtQ+7l5PpaJyD65z63fd2K5rrquNTA0?=
 =?us-ascii?Q?l1KcHvgSPkny5tHWb81U/a+WdkZA/x8vpW4+amAo0VTDVTUnEMe8uGnZbsA/?=
 =?us-ascii?Q?ytiVom4qQVxQYe1bwdZl/AQB0A+Fur7FfhI9NTyOdKdx7Ytn2YqIWwbo9ize?=
 =?us-ascii?Q?kxAQP51NI29DT65rfiPRujUVaFB5AEU6qpec+CPJayjY/pT4ZruVIubSncN1?=
 =?us-ascii?Q?l3lV36xVxBsjeH2aHv2r7ZEJCM8AhfSxK6O1zMb9EwBlKKk7mBWEVvpMtGq5?=
 =?us-ascii?Q?ewVmN+ejW5SHdpysRJqirKvMg0Pqo7Ns3qT6on+Y0CWOyBSv/lVq7PQA4rtN?=
 =?us-ascii?Q?QGogHqeKIHRfb0S2kGXpxUiobO2SZCFdr0L2t6MTLpsyHTwv75KgWME8exG6?=
 =?us-ascii?Q?HJeA+WJZQI6FTYuVYA3UtWWRhKmzh3IfodYsA18L8Mucic39S5zBatw23JC2?=
 =?us-ascii?Q?BgQ6OT3D3Vw+qcFvELVn75TzvdM+JdtG2ZgrxUX4XX29cWZbe2pnAZ+Ov7Qz?=
 =?us-ascii?Q?MWdz5rqNKxW+CnePWBgW/v54NADDcxNcbzpbwXW7Dj3cRAiJ5FsxdeXTAJrR?=
 =?us-ascii?Q?7YNmBIVA7vBg5A1XVZJhjypl7rBPa3RfW1SwZqiFTvmTLJU8ibJb1kBJgfKX?=
 =?us-ascii?Q?neCH0tj0UFL0ID5IFGBcolKDW7S/ettFaysGCNFMef9tReUvKvZUretsPd1o?=
 =?us-ascii?Q?C3f6vqxAVzpmMmtoIvaWouwZnX9jdPNncndNYZhfiEp+Rms6qwlNrIjsKReY?=
 =?us-ascii?Q?SCRS7AN/y6ZgQkpaxuMUU5JlOpK6hA1ulIfH+PRWDBnle4TIyEqzPq6V3PYs?=
 =?us-ascii?Q?fRtIeXJTi1LpfGO1CBhCKgrYOzvO5peCSW0L4dgNlZeV5FiKUpzESqRT5EMH?=
 =?us-ascii?Q?NxwPYh4GTxNYB36a4RL6Y2QYqSRCmZGNQghdqJF0eiBSTklb4ZFxCw97nWbp?=
 =?us-ascii?Q?owZ3C3nXSNAREHSVjhy9RnN/BGy2tndjGOLnbBJxGj2BWTayPE6Eq+6vVQid?=
 =?us-ascii?Q?iKNi+xo6u5+2buVDHYw0/CVEe9KcHnAuos6lx8YBaH+jDDQZWyuoW7ASSvRT?=
 =?us-ascii?Q?VCoydgkmL0lkEx1m1JHFGn/4RPcW7UZRPWU9Qx7VNedP8S1mJOQ/n5Ze5TIr?=
 =?us-ascii?Q?/8KmZAHYC8QL6BQ5MNRNVvRyEuDTvgES5i/4kZpjiT7lhINvdi8osCtftT8+?=
 =?us-ascii?Q?eYlV4inUsrBHCnMC8zPvSq2sPvDNpJphDnh8h17VY7o+G4inHIFAVqytVLMn?=
 =?us-ascii?Q?cu927Cc66gIcajHXEcikCv21DQyIJzkVHffVlhGdSbUWv3Pr/QW8FA6hRWhG?=
 =?us-ascii?Q?vrfK9dW+zduumq8GU47JbgTOmhVa4uCgCAGpfHVLciNvbAL28P0PZICRiCF1?=
 =?us-ascii?Q?VlcLLa9/omckKddT/0L3hSedztWeO1BfXB9b3LgL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y8DZDK/7RyEVS2QvrwYGvysU2JgNRg8O32DRXtwVPs3V8LaaFKv62RDiGIumQ5DM6Qqw8YL0RKJEdjeEBtLg/lvy06UrG5LBvFL5zb4rXxdUQNWwK9x5ixJQ5q3yLrnqey8zsyr5tsLhhvr5fY5l7/+qrXrHQn9KKVnNShB5LRG9e/xFTv/p2QfhJROmGPB+GZPk+HCxApMQd3PZZtEidkxAEGPn7A0jvb2QZyBVOAqFTvoPMFp7kJtr/6MSV5eCws2O+S3UKfWfsu0U9t6Zl2QU/lm12bRVoKGUSVVdYieOWFGElry/NJXQlojNIYC4R60cXJQNR4DifNG4B/gYRbUihtllWvHCf0lwZcWnr1KebPSZBzRDbFBluKU5e+n4ciwJMbpJ9D+9Tc/3YxCYyOr+UuuPfW8mukmuHZ7EFunpj0KHJRhgN3MgCv7NURck0CGnD0+id5q0LABYrAJCTpKpiZ3cbCyGMuJEN3fDdyk8RbCPyUA54VTTiPtnllaUhpDXgr1iA3U36TA4zDTq6Nktm+gJeLO426lwcc+NEveA49xK8CQ9HVxKAiaSIPlFawbn/cb9fKQG8Lwe1y0Rx1iswOSzjNd3iaksEoOngkQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e42ff356-5d37-4fc4-3740-08ddf75aea3d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 09:00:00.8232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FrRv0iW99Ko4qU4gQVht5N0/GsvTDdTSqflOhXY2MlVcU6UtQROmWNtUDtKLENdzH8ZTcuGrK7irC8tWTAwbuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF860E415BA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509190081
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXxWTrTsyjb8xm
 cluOeSrk1Oopu4sgzka8cLNG//ULjk0Fmm74OAp+IVNH6H7XgN3IT6+MvDQigFux68mXJPXc9t9
 MeXesYBY3qlniYFtfF3b12K+vZKsv9vHtauNpZF3V7f8AXqM7/o6HhLCrryo0rwnfXLHnbaAiGo
 97lEBBaPX9vS9pT2I4X89hgRIkVEFjWG9jorR7FBmtxlqtPMyzZ3utpCL0f4ePOAvMh1jmCL78j
 5wavRvauVl+Q3yPTGd+b/817Iveaw0VlPEtVUJCYRT2vxfvp/1t8aOCGk24qWkO88YEfdbjubva
 3s1uH6RMcsainRpLdq3r3zVoeA9a6RiduIbpMM2oMrtvw9ppP5wZ9Ush77cfGxIi7TYYN8b8pt5
 UA7Wrbxv
X-Authority-Analysis: v=2.4 cv=KOJaDEFo c=1 sm=1 tr=0 ts=68cd1b97 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=xRbzKv8CKK6sxhIbYK8A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: yT-_ftLNiNHUxndpUtCiVA0Vd3Grvn-q
X-Proofpoint-ORIG-GUID: yT-_ftLNiNHUxndpUtCiVA0Vd3Grvn-q

On Fri, Sep 19, 2025 at 09:02:22AM +0200, Vlastimil Babka wrote:
> On 9/19/25 08:47, Harry Yoo wrote:
> > On Thu, Sep 18, 2025 at 10:09:34AM +0200, Vlastimil Babka wrote:
> >> On 9/17/25 16:14, Vlastimil Babka wrote:
> >> > On 9/17/25 15:34, Harry Yoo wrote:
> >> >> On Wed, Sep 17, 2025 at 03:21:31PM +0200, Vlastimil Babka wrote:
> >> >>> On 9/17/25 15:07, Harry Yoo wrote:
> >> >>> > On Wed, Sep 17, 2025 at 02:05:49PM +0200, Vlastimil Babka wrote:
> >> >>> >> On 9/17/25 13:32, Harry Yoo wrote:
> >> >>> >> > On Wed, Sep 17, 2025 at 11:55:10AM +0200, Vlastimil Babka wrote:
> >> >>> >> >> On 9/17/25 10:30, Harry Yoo wrote:
> >> >>> >> >> > On Wed, Sep 10, 2025 at 10:01:06AM +0200, Vlastimil Babka wrote:
> >> >>> >> >> >> +				sfw->skip = true;
> >> >>> >> >> >> +				continue;
> >> >>> >> >> >> +			}
> >> >>> >> >> >>
> >> >>> >> >> >> +			INIT_WORK(&sfw->work, flush_rcu_sheaf);
> >> >>> >> >> >> +			sfw->skip = false;
> >> >>> >> >> >> +			sfw->s = s;
> >> >>> >> >> >> +			queue_work_on(cpu, flushwq, &sfw->work);
> >> >>> >> >> >> +			flushed = true;
> >> >>> >> >> >> +		}
> >> >>> >> >> >> +
> >> >>> >> >> >> +		for_each_online_cpu(cpu) {
> >> >>> >> >> >> +			sfw = &per_cpu(slub_flush, cpu);
> >> >>> >> >> >> +			if (sfw->skip)
> >> >>> >> >> >> +				continue;
> >> >>> >> >> >> +			flush_work(&sfw->work);
> >> >>> >> >> >> +		}
> >> >>> >> >> >> +
> >> >>> >> >> >> +		mutex_unlock(&flush_lock);
> >> >>> >> >> >> +	}
> >> >>> >> >> >> +
> >> >>> >> >> >> +	mutex_unlock(&slab_mutex);
> >> >>> >> >> >> +	cpus_read_unlock();
> >> >>> >> >> >> +
> >> >>> >> >> >> +	if (flushed)
> >> >>> >> >> >> +		rcu_barrier();
> >> >>> >> >> > 
> >> >>> >> >> > I think we need to call rcu_barrier() even if flushed == false?
> >> >>> >> >> > 
> >> >>> >> >> > Maybe a kvfree_rcu()'d object was already waiting for the rcu callback to
> >> >>> >> >> > be processed before flush_all_rcu_sheaves() is called, and
> >> >>> >> >> > in flush_all_rcu_sheaves() we skipped all (cache, cpu) pairs,
> >> >>> >> >> > so flushed == false but the rcu callback isn't processed yet
> >> >>> >> >> > by the end of the function?
> >> >>> >> >> > 
> >> >>> >> >> > That sounds like a very unlikely to happen in a realistic scenario,
> >> >>> >> >> > but still possible...
> >> >>> >> >> 
> >> >>> >> >> Yes also good point, will flush unconditionally.
> >> >>> >> >> 
> >> >>> >> >> Maybe in __kfree_rcu_sheaf() I should also move the call_rcu(...) before
> >> >>> >> >> local_unlock().
> >> >>> >> >>
> >> >>> >> >> So we don't end up seeing a NULL pcs->rcu_free in
> >> >>> >> >> flush_all_rcu_sheaves() because __kfree_rcu_sheaf() already set it to NULL,
> >> >>> >> >> but didn't yet do the call_rcu() as it got preempted after local_unlock().
> >> >>> >> > 
> >> >>> >> > Makes sense to me.
> >> >>> > 
> >> >>> > Wait, I'm confused.
> >> >>> > 
> >> >>> > I think the caller of kvfree_rcu_barrier() should make sure that it's invoked
> >> >>> > only after a kvfree_rcu(X, rhs) call has returned, if the caller expects
> >> >>> > the object X to be freed before kvfree_rcu_barrier() returns?
> >> >>> 
> >> >>> Hmm, the caller of kvfree_rcu(X, rhs) might have returned without filling up
> >> >>> the rcu_sheaf fully and thus without submitting it to call_rcu(), then
> >> >>> migrated to another cpu. Then it calls kvfree_rcu_barrier() while another
> >> >>> unrelated kvfree_rcu(X, rhs) call on the previous cpu is for the same
> >> >>> kmem_cache (kvfree_rcu_barrier() is not only for cache destruction), fills
> >> >>> up the rcu_sheaf fully and is about to call_rcu() on it. And since that
> >> >>> sheaf also contains the object X, we should make sure that is flushed.
> >> >> 
> >> >> I was going to say "but we queue and wait for the flushing work to
> >> >> complete, so the sheaf containing object X should be flushed?"
> >> >> 
> >> >> But nah, that's true only if we see pcs->rcu_free != NULL in
> >> >> flush_all_rcu_sheaves().
> >> >> 
> >> >> You are right...
> >> >> 
> >> >> Hmm, maybe it's simpler to fix this by never skipping queueing the work
> >> >> even when pcs->rcu_sheaf == NULL?
> >> > 
> >> > I guess it's simpler, yeah.
> >> 
> >> So what about this? The unconditional queueing should cover all races with
> >> __kfree_rcu_sheaf() so there's just unconditional rcu_barrier() in the end.
> >> 
> >> From 0722b29fa1625b31c05d659d1d988ec882247b38 Mon Sep 17 00:00:00 2001
> >> From: Vlastimil Babka <vbabka@suse.cz>
> >> Date: Wed, 3 Sep 2025 14:59:46 +0200
> >> Subject: [PATCH] slab: add sheaf support for batching kfree_rcu() operations
> >> 
> >> Extend the sheaf infrastructure for more efficient kfree_rcu() handling.
> >> For caches with sheaves, on each cpu maintain a rcu_free sheaf in
> >> addition to main and spare sheaves.
> >> 
> >> kfree_rcu() operations will try to put objects on this sheaf. Once full,
> >> the sheaf is detached and submitted to call_rcu() with a handler that
> >> will try to put it in the barn, or flush to slab pages using bulk free,
> >> when the barn is full. Then a new empty sheaf must be obtained to put
> >> more objects there.
> >> 
> >> It's possible that no free sheaves are available to use for a new
> >> rcu_free sheaf, and the allocation in kfree_rcu() context can only use
> >> GFP_NOWAIT and thus may fail. In that case, fall back to the existing
> >> kfree_rcu() implementation.
> >> 
> >> Expected advantages:
> >> - batching the kfree_rcu() operations, that could eventually replace the
> >>   existing batching
> >> - sheaves can be reused for allocations via barn instead of being
> >>   flushed to slabs, which is more efficient
> >>   - this includes cases where only some cpus are allowed to process rcu
> >>     callbacks (Android)
> >> 
> >> Possible disadvantage:
> >> - objects might be waiting for more than their grace period (it is
> >>   determined by the last object freed into the sheaf), increasing memory
> >>   usage - but the existing batching does that too.
> >> 
> >> Only implement this for CONFIG_KVFREE_RCU_BATCHED as the tiny
> >> implementation favors smaller memory footprint over performance.
> >> 
> >> Also for now skip the usage of rcu sheaf for CONFIG_PREEMPT_RT as the
> >> contexts where kfree_rcu() is called might not be compatible with taking
> >> a barn spinlock or a GFP_NOWAIT allocation of a new sheaf taking a
> >> spinlock - the current kfree_rcu() implementation avoids doing that.
> >> 
> >> Teach kvfree_rcu_barrier() to flush all rcu_free sheaves from all caches
> >> that have them. This is not a cheap operation, but the barrier usage is
> >> rare - currently kmem_cache_destroy() or on module unload.
> >> 
> >> Add CONFIG_SLUB_STATS counters free_rcu_sheaf and free_rcu_sheaf_fail to
> >> count how many kfree_rcu() used the rcu_free sheaf successfully and how
> >> many had to fall back to the existing implementation.
> >> 
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >> ---
> > 
> > Looks good to me,
> > Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> 
> Thanks.
> 
> >> +do_free:
> >> +
> >> +	rcu_sheaf = pcs->rcu_free;
> >> +
> >> +	rcu_sheaf->objects[rcu_sheaf->size++] = obj;
> >> +
> >> +	if (likely(rcu_sheaf->size < s->sheaf_capacity))
> >> +		rcu_sheaf = NULL;
> >> +	else
> >> +		pcs->rcu_free = NULL;
> >> +
> >> +	/*
> >> +	 * we flush before local_unlock to make sure a racing
> >> +	 * flush_all_rcu_sheaves() doesn't miss this sheaf
> >> +	 */
> >> +	if (rcu_sheaf)
> >> +		call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
> > 
> > nit: now we don't have to put this inside local_lock()~local_unlock()?
> 
> I think we still need to? AFAICS I wrote before is still true:
> 
> The caller of kvfree_rcu(X, rhs) might have returned without filling up
> the rcu_sheaf fully and thus without submitting it to call_rcu(), then
> migrated to another cpu. Then it calls kvfree_rcu_barrier() while another
> unrelated kvfree_rcu(X, rhs) call on the previous cpu is for the same
> kmem_cache (kvfree_rcu_barrier() is not only for cache destruction), fills
> up the rcu_sheaf fully and is about to call_rcu() on it.
>
> If it can local_unlock() before doing the call_rcu(), it can local_unlock(),
> get preempted, and our flush worqueue handler will only see there's no
> rcu_free sheaf and do nothing.

Oops, you're right. So even if a previous kvfree_rcu() has returned
and then kvfree_rcu_barrier() is called, a later kvfree_rcu() call can
make the sheaf invisible to the flush workqueue handler if it calls
call_rcu() outside the critical section because it can be preempted by
the workqueue handler after local_unlock() but before calling
call_rcu().

> If if must call_rcu() before local_unlock(), our flush workqueue handler
> will not execute on the cpu until it performs the call_rcu() and
> local_unlock(), because it can't preempt that section (!RT) or will have to
> wait doing local_lock() in flush_rcu_sheaf() (RT) - here it's important it
> takes the lock unconditionally.

Right.

My nit was wrong and it looks good to me then!

-- 
Cheers,
Harry / Hyeonggon

