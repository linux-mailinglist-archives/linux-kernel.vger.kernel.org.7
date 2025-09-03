Return-Path: <linux-kernel+bounces-799278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC34B42972
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6930216156B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0342D6E6D;
	Wed,  3 Sep 2025 19:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GnTVKXdD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aZ+uaCsU"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADDA198A11
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 19:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756926307; cv=fail; b=a3UnRhPw38Jl4q2sVccKlEREvbODYLaaOlswVjzdOCwne0k9dxTcdeMr1V1upDqdEh5vxXaDarYrYYUXFYtlu3sGs0MRP1lzoyj2tnJZtrTtvBOKKVgg6GzFLaS4AF9fXcc3WHAEc2nYafjGfVvsLrLbNMxInfcPhejRSUu+deQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756926307; c=relaxed/simple;
	bh=FI2djRqHkjLv3WjCXiu/vucu9S7joSP9/Hw5b9Pv1bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t+q0H+kUXJz+i+DPhcDIdBNP1NliQvh9zC09XVJK6OQ5jbDODfjLepnSAbCNKzvRczfpTx6ySRFY+9iqs0wexAki1WNIe4gGoznfBMwTd7Pnjkts9ezTv/SuaUP1ylAr7FZEKwq3IS58u+wGuDnGK4mHxgz0wsr5trhH9k5AHXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GnTVKXdD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aZ+uaCsU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583IdpMi017558;
	Wed, 3 Sep 2025 19:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=p+UIszC+Crg+N+MGGG
	+7GC7rumCx6DY8Q5TkP/Fe2HI=; b=GnTVKXdDSeT5QqoUWRJ6ryrj0dkaix4Wss
	glvBfiQgeETH5PUb957k21H9hVDCu6Gd2NDCZ6DLulBTFElHQEhU3kbum5UfxNqZ
	e9BqXS3R8f3WrmWfCVgDArzCO9V3MyqCIVecujo+TsFQxJmoSMdXbICFigCBwdIC
	4+LqezSXzvjKOHPe8mU7XQvtsTKbKpj0gZXwSDAJACNjJH8zydXL35e/c59I901p
	dbC0H5erW9XNWsX+NSkRWvHC8gqCjDLWdPYvKUPX+6YBLgu0XdaLNWTGHX1Z4PpS
	LD6kCTVyeePvwJwUdSGyydhpvs4cLJyDoPQSU0ny3Ici76s0AUiQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48xu5581rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 19:02:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 583Ial5a036094;
	Wed, 3 Sep 2025 19:02:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrapkde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 19:02:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUSr5EhqlN24eiIaMhBRN2oU9infObcsEKXbshOVuKpl5+5JS+jiEZ3NXn+qGVsuIfGpZP/fOffOi8YqfxI+2ylNGfYNcPt5ZqxSCA9U3YUxaEO6rkgOy2ffuVyxWIpUyA4CDLAfe2dJ/xvmkdTuMnSyPf/WJPyDlVvDJjvr0aULX+nNXBTGgpHEFwji+CY0ZoJjmOT51s3OiOuspOWduCbAzqBesJWI5EOqXsdld7Ob9DlIhTY5NQAcK9SNSosF7hQK+6Bt/NC1pydDg72jRTjQbXhBgM/8oOyuMW0Tup1Lgn/Vq5Sy0ESlAnsS76CiJdysTZeCBj77UDBY+hO5Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+UIszC+Crg+N+MGGG+7GC7rumCx6DY8Q5TkP/Fe2HI=;
 b=XHFX3Lnuwluteg4jhqjVWr/Qdr5MXx8RrGpA/Dr7kg19myuKpjGDr4fbREtxz9mnJ3F/kxV/LnIcyFgK8AAiQ5/geQMlcFCUSC/hAcf2oAdHWtg/lQcjmi+lLZWhc9vnQUNOvrGSzi/CVwlEWu61nR35nq3DiRVuP38LnAbbx4YlRh6ZetrxWlOVa6FJ8d4GAcsMBKWXU8ZTAe2xp9TyKy5x27bHr80vj63zZUAcAKh5oC9PKL0ZHzttk0EVnO2iIp17AQ+2ThpdW/EzizN1YeAZ9CBTXv4aYGqr7h7RwAVR+jDXN96evUTToB8lUv7EAfh37nF3dpIKKjna6zpS1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+UIszC+Crg+N+MGGG+7GC7rumCx6DY8Q5TkP/Fe2HI=;
 b=aZ+uaCsUFmVfu6nE38eUAI7VsgLKxY8a6lRwoeTlEhDg1GCLZp3sPS4VnySmanoeMYSC9WFD6Sy3rgXlklQ5q8a+1rpTb0oe39Wu1aAGZ9IZKr74D0lnMoI+zGFV5hGuM02o3r9TN0I11/FzP/CxkPYuqVPs48XBIHsKMjb/UM4=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DS0PR10MB8053.namprd10.prod.outlook.com (2603:10b6:8:1f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 19:02:38 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 19:02:38 +0000
Date: Wed, 3 Sep 2025 15:02:34 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Michal Hocko <mhocko@suse.com>
Cc: zhongjinji <zhongjinji@honor.com>, rientjes@google.com,
        shakeel.butt@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        lorenzo.stoakes@oracle.com, surenb@google.com, liulu.liu@honor.com,
        feng.han@honor.com
Subject: Re: [PATCH v7 2/2] mm/oom_kill: The OOM reaper traverses the VMA
 maple tree in reverse order
Message-ID: <7rvwvuifkav5oz4ftfuziq23wek2bn6ygvrfotpaweypuy7obv@hjuf3eknscii>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Michal Hocko <mhocko@suse.com>, zhongjinji <zhongjinji@honor.com>, rientjes@google.com, 
	shakeel.butt@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, tglx@linutronix.de, lorenzo.stoakes@oracle.com, 
	surenb@google.com, liulu.liu@honor.com, feng.han@honor.com
References: <20250903092729.10611-1-zhongjinji@honor.com>
 <20250903092729.10611-3-zhongjinji@honor.com>
 <aLg7ajpko2j1qV4h@tiehlicka>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLg7ajpko2j1qV4h@tiehlicka>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: MW4PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:303:8f::32) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DS0PR10MB8053:EE_
X-MS-Office365-Filtering-Correlation-Id: 19c09daf-7beb-4e7a-e156-08ddeb1c7345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kw8XE36hZWOIxhguiKSH/yZF8DqCdDZMhoBdoobTwyAJIKN2mMreLI8ng1sJ?=
 =?us-ascii?Q?CMZpUl63aGgVP4fpjrZ0yeW/EvRV4hvK64sX1V/96v+hMJWPyKJonOZYJzvz?=
 =?us-ascii?Q?Yesed6aJ/y6Wcf4O2DRTmDOZaNWUP5LN95Ew6b3TWKauPUjtkKe+2zOpdv94?=
 =?us-ascii?Q?71Xb6vZL4CNdeDiVecMzWV+CsSez5pAq6OpIoy3jJ5EP8tgAqrGBEUzPQVum?=
 =?us-ascii?Q?DYoAest+ei+Rh7uxWE0jRYPs8eEpBqdyvLosHXUAkB1zXm7WoaKCar1Y+IWP?=
 =?us-ascii?Q?ZftFwxC/ccjBNOWMtHsiv2ajA4T3J+wC0T5Ia/8GfdowZIQmXQ47LRnkTXwh?=
 =?us-ascii?Q?4OwlAxF5NY0k91ed1K0RTXOQV1rfDMBN87eZgOn6VgIBAAW07CvwVcRWBQ2b?=
 =?us-ascii?Q?MHN8S1OZC7AjGYpnxg1/PmNaZWP5gNE3tcVCazmUevlTVnJgk58IKxjSB6sc?=
 =?us-ascii?Q?CCurB018ZytZNF4sBsgGttTlkOnmr8FMMgzewuRJexyfp6EsUHiw6ZyrEv3J?=
 =?us-ascii?Q?Nu5P89fp2VvvPrEP8JX1x5f3EUF12VeYVhPCAUvnR6Z6F4M7zpQZDbM1bNov?=
 =?us-ascii?Q?rrtyd8gw1oIZBajQcx2cImVuydIgUZUNKBNoh6FiVJg1nt+XkRZQxnHbsls3?=
 =?us-ascii?Q?QXAsU9ihp1CFfjFvOyCWZTUZoXfoB/N/KcOq/QPvjA4PeUVdchYMJvTncXwU?=
 =?us-ascii?Q?NUi/GxOrUn9SL1QeBPUF0+rbm2+qdDC8OnV70S8ZYfmpj7pOxVYgPOOKrQsW?=
 =?us-ascii?Q?H5DsKBzeiHgGuq7GDNm0lZQa2by6KxMor04B3t4rPgW8zhzTMkEWaZtuSs4W?=
 =?us-ascii?Q?vQiqyh+LBbPZo0fK84TJQIxzxfQUi5s1R05/EsZl3Af3k0waz3ZWwaUc6snS?=
 =?us-ascii?Q?KNgrLIVEVvTJ7XsUhr4ZhJci65YbURcksaCKT6Lon41nJxaHf22HpB3fjnB4?=
 =?us-ascii?Q?N5oL80MMS99i1HpFZnNBJ8ftsQtwl8qivxY/RdOa6W/vnUIcHxD/jxC+sgHP?=
 =?us-ascii?Q?nZ5RoZqyVFk5XYs3mFeiY11kF/J3XUpnPjeHobrKyElAcQUZEpq4L98XC697?=
 =?us-ascii?Q?88GNif1KlUD33ryu9Hgw3RozQC0e48adXHqp0zVHNSyT5vdHQf8XmvGPLpwK?=
 =?us-ascii?Q?Jq8sB0DhqLVj5Cxyb3rmGmoTHyYC6fk9OQWWckR5iKVxgxJ2lwALKydPZwGF?=
 =?us-ascii?Q?IZxrZcb4c+Krk9wzro0x8QBKC2DUgWWA/La41J9NmZgyk0rHg3RM6o1I4Zsa?=
 =?us-ascii?Q?kz2FTfUnvr1qBJdrYCWr1Kgw+S5wUMHw/nyMzHv5ySSobNs02iCp+6Y+paq1?=
 =?us-ascii?Q?1ynp4n2ATRVXsPjnyPISJlj0viAGN+xaGuMsilWxvAfzcjekehjhg/BPb3t8?=
 =?us-ascii?Q?KZNHnA4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YDpEZVVrLl09T08xMln+UHO09uk/W9FSDu5SqT5CTroSml/kL9iKHeGzEUle?=
 =?us-ascii?Q?2PKNI/s/6OcAUtMPycmyPVul4VyMl3XxdedS/oK85Vv1kVAtU7M27dm5FpVj?=
 =?us-ascii?Q?DEkTIgNDw3A7doEJTlMcjpRe/UXwryhjfDZzhEXDxiDG/KaR5sH7l5F6Nfsx?=
 =?us-ascii?Q?U1iU66KC8Wlqt/7ojkHsVNX2kYqFEsFB251micm9bLybS1CjYtfj34PSYOpb?=
 =?us-ascii?Q?4+VdYFHII5Q9Pe+VtcBshLG0saHMleK3OGxKiF9S910TP429tATHooEHV3LU?=
 =?us-ascii?Q?dMUOpmAXrfgnwm6ftbso9k1yRfRAme4pqnCfw3tRjYfD03R6z3fuGZVw87bE?=
 =?us-ascii?Q?6jCtcGO+a2IyJKiJi/dHeXDufR8J99kJV/gUEpvs4R9POqU1Poq6O+0rkZF2?=
 =?us-ascii?Q?OrFnvGw40RkQyq87cxKIZikRt4Xl4OHOBedYxOcHM3flSpO9m+hopbvuu4Tu?=
 =?us-ascii?Q?55a1XF5m9NrBxBmq1aZ6J/5IIEWKA2MpTGowIOY2VU5xBmWB3SIHzDlkpkc3?=
 =?us-ascii?Q?Hg+6SEFlCNB6FARMPS+gT4mOPawLft9M1o52REJ33RG6OFD2bIgvm69hIKv3?=
 =?us-ascii?Q?vvHq6w1K7FhAtMXCHsmWHYbTy27brVkQAqbRybIEib4kODGMLrXn2VCZNVaC?=
 =?us-ascii?Q?EqeRk10M1BoRLM+mwV8+DoQ6aUN2eSk1kDzlN/9ey2V6X/ZfQQuHjhGQVMEG?=
 =?us-ascii?Q?27+zRb7IHu0MpMXwcTilyQnsU+UFaSDGkCWDNX2Os+NFQSqbvjZ6SmsDrkKl?=
 =?us-ascii?Q?W3y1H2E/G70jKTuyPCuY2ARMSr7zG2PhyheqyQrbSIEmAk2xVKNsSnALo9tM?=
 =?us-ascii?Q?I7OpFvQyausbVlWt2XvyjGpKSwz9zJQgp1shrXavEymrcVqxE4SsGpt4OAYO?=
 =?us-ascii?Q?0ndKPwOyOPeYUH7rt41OvBBIsDgbIcH80HMLGRrCJRtU0eLH7gkIrlcRGaTS?=
 =?us-ascii?Q?J+NMU8LKrbN/heoNSoR+OQY6GajGRVCIqttDrbl6YXI5ucPSJwOwh6bzLqMR?=
 =?us-ascii?Q?Kkqbk0swG10/H15H/QPxWELyprjqTTYZKY8POPMrp3WwJd2SeNTVq/9tfbkl?=
 =?us-ascii?Q?9lbq1HgtLlf59G/IsoMwfhf0MoEtbczqQX6m8netslXoNR97Wq/sJMfJZRml?=
 =?us-ascii?Q?3u0XRFr4t7TnAmg3haos7Qp5B4FDz8jCRB/HkMN0oASH7kMp8d2VCvYHL0WX?=
 =?us-ascii?Q?EDEze5Wj2iDB5PGFzdheUuCdu/8AR3fGL5RVxr4aUNcAR3Wx1KZqLnh6PHOC?=
 =?us-ascii?Q?EEMjRaaxWbcgHG+4C1Z71a+7X2mquRKTcJL+oZj5D8Lm6BUiFD2PSYBXnBBU?=
 =?us-ascii?Q?CO8rNkWMNDn0LEk/kyCEcFPzQmP3+e4AdKVHJkSvA4z46/J7HETT8NH7j1TH?=
 =?us-ascii?Q?QSCG+Q+9lYjvKJBtZ/+JrOL3j5EXz4mlv467bCPadFtl6vziPW/KEIrgAKQk?=
 =?us-ascii?Q?qPDEGn5feCRakSFMonvGMkKDgjcoudUWOLP7+EEoadPyAgJN+lhqxjfGsdT/?=
 =?us-ascii?Q?ZFD974kFENq/lborVRupfmW35rRu4tEn/8CwZHbT2Pq4EcfQhZi8TNVfXldr?=
 =?us-ascii?Q?a2D9rJNnHFakwLZCJpBQU1ANVuIEYubXBtH0JlPn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BsZOo/avadrS54T87gEOw82o2omehXKvQy/6Gdcs0tw6u1upoDFZM0ZcGmXnEi06EU5wiTZhruSCkuGx+niakwTCQb+MvsPOIlHDIJXzpBTdhXaLgnS/I+izFT8UqSNZNsdVp0xIFywuI9rHAeNotR2hHQpDmamU+eYy21FLiLx06svZpbB+CxpEFPS7MXoSSy6J7vvIrVkcxujT1iKB6WdpCHk20slih/t011//2comsnenK+5Q/tEQLVpC3P3ZqzRR1YGW/DdCt4TlAyvRurIqDcX6N4hwBjNbMoOwwNGktmz4MFiBUo9ILqR63X0uIB1DpmPYAulrJqBzorulDlAXlf0rwWGAlYgVN97CV3Ma3ktCoNSwNt+KhEioYoGTuyFjWAAqziNeCeepA+JsT1CvLl5VfibFfeCCwaMdfGhtZMpXJttjuCLSG1S4wa/Et+xbSb1zjIicDSw6WgynaX3heZeTYNLo8rU+CYi+UJkzS8fYIpTlbULlMMmUYMBNUxxgBTWq9qthb3i9EZuzdxq3aAOidEEGdIAsXf3b/giQKh4e5JD9TWmkMxXvE0hmd/iDMjHWc+GHh9CNpRD8uVeh+38DJi+5MkxUi8+Rl/8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c09daf-7beb-4e7a-e156-08ddeb1c7345
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 19:02:38.4131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ebE3FLW89OUOi+EGJZRJP6V5lh+RAToSlfFQrLGYKHb53WhEijaCHsiuK7gkRzZjCpqyLd8GVj42Xgtgc/NcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8053
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_09,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=842 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509030191
X-Proofpoint-GUID: jzzYOpyviSbdqZx1pdp6RZKt1qqbSusJ
X-Authority-Analysis: v=2.4 cv=Cf0I5Krl c=1 sm=1 tr=0 ts=68b890d2 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=P-IC7800AAAA:8 a=iox4zFpeAAAA:8
 a=CvlTB2HrAAAA:8 a=oZ7ZxsKLDK1Xoq-nMKUA:9 a=CjuIK1q_8ugA:10
 a=d3PnA9EDa4IxuAV0gXij:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=67QrwF-mucXG56UA-v15:22
X-Proofpoint-ORIG-GUID: jzzYOpyviSbdqZx1pdp6RZKt1qqbSusJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDE4OCBTYWx0ZWRfXyE26zdCj7EwV
 0G0gllpY+uaJlopJcaJLddgsNvksBKxbdQ4eDLlcAS3g9dlxJ5Jn6aFMRmXVBi9qU0INANi3E1F
 1cJSQWIb1WDaCXlSd1sI+vAMqrxje/kEeSC4TjHMuHvHhhCWWfGed3VVGHMQqgvPW1bSmyO5o3N
 wUx4oNm/iNJeW64SwNfwKAinVdPx616kkqktgT4oaCccEj4AysLjdk5xau0DVE0YHaJ2CysXlQi
 tuWsqia/F0z/NTBRUzdblOdQJyF9spVOYnQaXnzAWqhQMeDbMy6DRNNd4iRs+dy2kEilSO2Zcx2
 VGD4L6UF9tV6A5yc7/VIflArqMXqHQMid+Gzn6h4SwUYJKWNSL5szQ9yxvO6ydGTd3+8OvPUIXY
 uLLaIgr0

* Michal Hocko <mhocko@suse.com> [250903 08:58]:
> On Wed 03-09-25 17:27:29, zhongjinji wrote:
> > Although the oom_reaper is delayed and it gives the oom victim chance to
> > clean up its address space this might take a while especially for
> > processes with a large address space footprint. In those cases
> > oom_reaper might start racing with the dying task and compete for shared
> > resources - e.g. page table lock contention has been observed.
> > 
> > Reduce those races by reaping the oom victim from the other end of the
> > address space.
> > 
> > It is also a significant improvement for process_mrelease(). When a process
> > is killed, process_mrelease is used to reap the killed process and often
> > runs concurrently with the dying task. The test data shows that after
> > applying the patch, lock contention is greatly reduced during the procedure
> > of reaping the killed process.
> 
> Thank you this is much better!
> 
> > Without the patch:
> > |--99.74%-- oom_reaper
> > |  |--76.67%-- unmap_page_range
> > |  |  |--33.70%-- __pte_offset_map_lock
> > |  |  |  |--98.46%-- _raw_spin_lock
> > |  |  |--27.61%-- free_swap_and_cache_nr
> > |  |  |--16.40%-- folio_remove_rmap_ptes
> > |  |  |--12.25%-- tlb_flush_mmu
> > |  |--12.61%-- tlb_finish_mmu
> > 
> > With the patch:
> > |--98.84%-- oom_reaper
> > |  |--53.45%-- unmap_page_range
> > |  |  |--24.29%-- [hit in function]
> > |  |  |--48.06%-- folio_remove_rmap_ptes
> > |  |  |--17.99%-- tlb_flush_mmu
> > |  |  |--1.72%-- __pte_offset_map_lock
> > |  |--30.43%-- tlb_finish_mmu
> 
> Just curious. Do I read this correctly that the overall speedup is
> mostly eaten by contention over tlb_finish_mmu?

The tlb_finish_mmu() taking less time indicates that it's probably not
doing much work, afaict.  These numbers would be better if exit_mmap()
was also added to show a more complete view of how the system is
affected - I suspect the tlb_finish_mmu time will have disappeared from
that side of things.

Comments in the code of this stuff has many arch specific statements,
which makes me wonder if this is safe (probably?) and beneficial for
everyone?  At the least, it would be worth mentioning which arch was
used for the benchmark - I am guessing arm64 considering the talk of
android, coincidently arm64 would benefit the most fwiu.

mmu_notifier_release(mm) is called early in the exit_mmap() path should
cause the mmu notifiers to be non-blocking (according to the comment in
v6.0 source of exit_mmap [1].

> 
> > Signed-off-by: zhongjinji <zhongjinji@honor.com>
> 
> Anyway, the change on its own makes sense to me
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Thanks for working on the changelog improvements.

[1]. https://elixir.bootlin.com/linux/v6.0.19/source/mm/mmap.c#L3089

...

Thanks,
Liam

