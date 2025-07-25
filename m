Return-Path: <linux-kernel+bounces-745932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2FFB120A3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85D718978BF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C1B2EE266;
	Fri, 25 Jul 2025 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MhvbyWeU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FDeDHjOa"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D181E766F;
	Fri, 25 Jul 2025 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753456162; cv=fail; b=MRAMGAhmiNn5xXA+ZF2V7oYqF48EdSbJYukNkKws0ewOIGmeJy8/KWC3Vrtov0t3PgPM9VQ3tMZGa1TerqKk8PAAaUjnonZ6aGt2lB5/QL6+2gaeUQYbbCDc/v4tu7uxTdvgQv8hv8TU4zOJ/xT+8CJzY84Db298Ine7YvnWHAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753456162; c=relaxed/simple;
	bh=nY49zBx5sLiTYy6UsZCIlfauniXXIat33tzRCJq95Fs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jIySljHh7ra//sUhvYvmw1YrM4ITVQRjW1W/EhoRF1Kk5tgeue9YeTFrFcRKX2r9lE5g2avljS8LA29eGxCsgrVi/V93pVTc3ctrc81KJNz0kfXSlSnrBq2r9QBr9W/XxvLAYNn1SEXJh3tkDBsDCPEXgInEC+vgG0PHwR1KbAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MhvbyWeU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FDeDHjOa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PEJ2D7005103;
	Fri, 25 Jul 2025 15:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=STNSLCK3MtX9GLa3CS8A+MxxbEbUHt1SxPo41RqpGGE=; b=
	MhvbyWeUlpwOGbOA1hmpZXEBLXNHjEW9abRHi4GC49lNzBO59lwy8Zrj0wAbRa3M
	ep23Mdeex0fm1+FkXV9y6//u10vwAe73khYaWN+sODjpwy7GILhRe5pMw+7wkndK
	rwGoHs97DVbBgZp90b9eg9+tKsUeiJsl8jEGmBW9Ybc3VfKE1Wl4k4oxUgns+8if
	9FLAvfajkWnX3WQ0A+Yr6n17NRUiZnCe5FvbEJBcFiJjgteR1PawLKFI4/bGjaRO
	tYmqZOVgC69eNRqtBpD7P+8NQUOGIJiFzWLaTjzRQeE3YyUacwrw9DlmpZiHHjd1
	62R9u6IlTLmltds62X2Cvw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w1j18n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 15:09:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56PEQ7IO005947;
	Fri, 25 Jul 2025 15:09:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801td5vgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 15:09:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y7Pk5eEXzStWpvTfXKFCMkSGH5wrz4R+7KTWwn+oOKmdSTFVN4KRybn1re7fhGKRB5+zBDa9jHTZtW57wlHL2cmXb1kQenK804szQ4TM2/aDIERAtFkoMi6L5eVQsTHOBHfrcrVtm6VasgvlYXPCYkHv+mJ8kkMQi3jL/xWm5LasMQzyUBulz1taHP5uAVHgmwNDKFosymHs5xktIUrUVlaoTUwUpi1ZKYhDy4z1EXMnzBOe9AHNL9CFn8BkI6a6kJjusqmqTvpOrMOosqkHwTXnj1Pq5o3PJrVMSJKlkaCNPVIQvMymVFSawK4y2iAuoviczg3jsGbgcNIt82F6Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STNSLCK3MtX9GLa3CS8A+MxxbEbUHt1SxPo41RqpGGE=;
 b=huE8fBvea/HdlIDufKCp0/Qf4Cm+ZbvZJIeFA/xcOHjEWXr1Zbg06GwKUpHFKUqFVF5ALR7fk4t/yvNZmauFBfMb5+kQyp2uZPmInmj0AApWwb9PzrRUplUdW92emtUgU9QzhZMjNT+wuWRjTplXk7pWzWnFa6nVpXGcbjqs0WE6RtX1ip4MWtbPr2sNTVlPN8qBy3Neo5P/4C67XF6l2KpveEJv9NgCgdJJTrDTO3Ly+xq46i+PE/b8CZpeeAepKA8LiyRJHaCnnDNzrtwPPC1vmRAkpSOB558rw4deG5ABok8sOp/grLMYupBMlPhijaZDPT2raebxVvIHPeXDLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STNSLCK3MtX9GLa3CS8A+MxxbEbUHt1SxPo41RqpGGE=;
 b=FDeDHjOaJiL6kouyzp8RIaELPf8RxOjHqQBoPqcmbFxi/FNN/oRRv5qXo6Zq5YUMmiONx8UvYdL5q02SBAmawqWG8baFd2dswALvUX1SWYfhTUTR7+ZlGSqVik248Vynga3J1tS+OZoZM2ENbdpfcY5L7XbzeNP7QVwa4FOpBpI=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by CH0PR10MB5161.namprd10.prod.outlook.com (2603:10b6:610:c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 15:08:50 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 15:08:50 +0000
Message-ID: <e3ab1337-2409-4828-aea7-4c71f8e9197d@oracle.com>
Date: Fri, 25 Jul 2025 20:38:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] platform/x86: (ayn-ec) Add PWM Fan HWMON Interface
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Hans de Goede <hansg@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20250725004533.63537-1-derekjohn.clark@gmail.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250725004533.63537-1-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0206.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::18) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|CH0PR10MB5161:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d0ef61-3db9-4078-c7d7-08ddcb8d297c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ly9TQUF0djEzWEhIK0ZqcGtnYVRuN0FJVnVtQjFVdDEvNUt5eFZ4d1ZDTjFP?=
 =?utf-8?B?THNwTkhMNHIvNi8veUtlRWcvcUk5UFEvTi9PUEJLaTZOU1hYUjZoZlJheEtX?=
 =?utf-8?B?b3hFdm1zOE45MTBneXl5S1dOZUdvMWNWempjUjhGeXhqY2psZUtjaEVQYkN2?=
 =?utf-8?B?alQyaHJYbEFONFdhVnIrTW82RjZUZ2tnRlByMklVY0t3RmtlR0xmcU85QUNZ?=
 =?utf-8?B?M1U2MHd4b3l5ZVZyWWVnQUN3SlRaWWRsTll3N1FVWWthN2ZWV0lMRkM3QWpM?=
 =?utf-8?B?bXk1eCtWak5OM3kvSHZNZmZRTjZ6Sk1weHFSc1dLMHBWbGNRcE9iQkdWdWwy?=
 =?utf-8?B?VVhIUWg3YW5KWXMxYTFsWkJFekFlMkNHQVNRRjlXazdPQlMyQkZ6SGlrYlMw?=
 =?utf-8?B?eWZTKzh3Z2pCUThQWWoydjlLSXdZclllV0FWb25jY0VITnhuY3pJWXBidXY4?=
 =?utf-8?B?OVU3NU50U2R5WmV0OWtLQW5oK3BPWDY4Q0NRaWFsMTd1bm9BWmNKZFVkYlp3?=
 =?utf-8?B?NnROZ04yaDV6MHVCU2J1ZmJCeGswQ2wvdkV6WFlzV1ZWT3QwYm9xMGREL0tj?=
 =?utf-8?B?VzlOL2hoUWNGYUtOVXVqdS9CcmdqSWZjUHcvYVZlZmE3aHdBb0U1VlBXTGhN?=
 =?utf-8?B?WDBZaWk4TjlTT0NSK1hNSTZNQjBkdGZwRWNiRGk4cEhYVzdzRS83T3EzUm1n?=
 =?utf-8?B?Q3k4V2k5VFNaN1lIUEZZeU03VktYa3IwcTEya0l0cThNcWJCRWpNbHNGU1Rm?=
 =?utf-8?B?cU0vdGkvU1o5MCtoYnFsYkRqdzRlYUJLL2s0cldFZjVmSEFaS2tEY21LUHFT?=
 =?utf-8?B?d3M1cjlkVWRnL2lxSEIzRGZpNjBqdk9BWER1bVJUcEFnTjhjN3M5TGo5dy9k?=
 =?utf-8?B?MElqWnFueXZNOERtTHJzd2k3VUcydmFRMi8vUU5VREt5NTM1SGF0S0tCMndR?=
 =?utf-8?B?eCs3TGJXZDFhNmQxOUgzaEFJU3ZsY3pKTmtHdjI5SW10ek1KQlJURGpXTlpZ?=
 =?utf-8?B?MTV3UDVXYlo3QWxhTmxOTzBZOGxXNW1rS1ZjbFl4WmNWWTcydEtVL21XUFZ2?=
 =?utf-8?B?ZEh5NEl0T0lFaytVL3IvZythaUVtMEI0YjdkQlZzNk56dU44NWNUbWNZNkNo?=
 =?utf-8?B?SXloallQbzM4WnZna05HMTJTS1l5L25yZy9OZzJOU0dvV3N1dkhuZmlhTHhX?=
 =?utf-8?B?WkcrVnk1eDFSWWllZHp4VHhqUVBWYS9nclFabGhSTkVzMTV1T0E4ZUxJMUZT?=
 =?utf-8?B?czZTakgvWTlEKzdaem1uVUpOZDhzMnJIK0phbCtudXR1YmR5NUFSU3ZRajdS?=
 =?utf-8?B?czQyMGpYZnlkVmtBN1JKTWRCUHpXTE5qK2FsZVFvMFVPREdPcXNtSEFNQzZ2?=
 =?utf-8?B?THBWUGpGTkQ0aU5ZUHNEc3IzZVZkV243L2ZDVFA2eXloaTlyTC8yaGRoK21o?=
 =?utf-8?B?UDJGVXFBcnBzUk5qV2pLQ1lVa1AwSHc1RjJxanhUZC96bzk1VFJNbUJDOVhP?=
 =?utf-8?B?TzVaRk0vc2F1QWV1QnUvMTBQWHdpQmNkcXMzazVmSGR3N09iSVEwb0l4THBC?=
 =?utf-8?B?NmZVYTRwY3VPZHZsZEx3blE3MDFvQzFTLzZ2UVdFZVFaRDlIWVJWZjRoQ01q?=
 =?utf-8?B?Ny9MdndRQlVEUUNjdDN5bW1uN21EcTBiSmJrazBVakhGVkFOeEsrY3VjR1J6?=
 =?utf-8?B?MjBHTG56aGs4L3ZUVlJFYnVLaFJPN1R5aGl0M3YyNFJWczJJQ05jZElQZ015?=
 =?utf-8?B?VGp6bllKSjlzSVRNSjlLNzJHTmdUR2lkb1NDVjExTHh0WnZRNG5LR1FJYWlS?=
 =?utf-8?B?NnVFdHhseStzU0UyZGJQeC8wak9nYm5XTG5LQVM3MGRERWxLazMwc0xlSGFH?=
 =?utf-8?B?Q09oYVkzUmcwelZpU3IrUDZ4VkdhR2xmRXcrU0FRZ2daRnVNNFNOTXRKQ3Bh?=
 =?utf-8?Q?kQZCbtr53uY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzZ2S2NEbjIwOS9HNmoxVUxlQzVONlliZ2JBS1BRaFhobmU1c1I0aFpUWW9p?=
 =?utf-8?B?TTBCYUlLN1Z3dnZjQTJTNVlvRzhKdFloOENsRU5iTHlVZnkwZWVENitLbmR3?=
 =?utf-8?B?S3p6NmNKZ0ZpOHZKaGVzcmJuRUtZQmwzSWVrRHdqMXl5czVQYVRWZGVuK2xv?=
 =?utf-8?B?UUptTkhlM2JsQm9FZWZBNjU0QzVxZS90N2wrZ05qZU1JZWUzclNtWnQyaVg0?=
 =?utf-8?B?K1dkb1QyT0tZWFRWY04rdk1IWDR4cUZJVktyL2ZQT2svRUljM0lDNHFraUE1?=
 =?utf-8?B?bHByMXBTeDZUSFRaTWNzOUIxTVhGVFlXUXFCVU1GUnRYMGhVdU03ZjE1akxp?=
 =?utf-8?B?dDhSK2luVnpkT3lHRXZoeEcvUWxJL1BCb2F2UGpaUEdab09seUU3dExkQ2Za?=
 =?utf-8?B?QVZpa21iaE9vWno1ZUhGSFltd3JwZTRqY1NQSThDZVRteHNEVU0raC9vbE1n?=
 =?utf-8?B?L05DQzhrQ3owaE9DdXhMU0grUiswWDIvc09sU0grSmZvcG45eGlIZloxcVgv?=
 =?utf-8?B?K0xtRUQyb2tDRU9YY0poczZMUW5NM2M3cXZVQjdzVSt0bmVZempJMDhnWTBN?=
 =?utf-8?B?Y01Va1pLRjU4OEJLaUh3SHY1eEVHczhheDAycitObC9SNjNWSklqNVZOYmJq?=
 =?utf-8?B?NVptUlhiVkVMbU5ZYnVzVlR6ZWRsM0N4NU02QStldFp4Sy9nVlJackRYUU8r?=
 =?utf-8?B?Vk8zT01rR09LbGpCTXNZak5ubk4wVEc3OXFIOTV2dkY0WkpjdGRtc095cUcx?=
 =?utf-8?B?aitta3dmUE9ZMmc1ZVNtWm5vOTMvR2NNSGhWVGJhYVRRVUdJR21vMExxbHll?=
 =?utf-8?B?WmFGbkJFZHRNQ01DcXhoM2gwQ0VoSlBveWtNS2taa3V4Ykx5UXpBTzRBdkkw?=
 =?utf-8?B?cGZHd2xYeEdFT21oY2tPQ0Y4eXdiUnZ3eTF3a2x0cTB3QUFYT2dSNW1sckZw?=
 =?utf-8?B?OURmMVBabzFwRDMydEtlTzJXTkFSK0dhR1g4WDhoTzVUcUJaUmwyYTltZlM2?=
 =?utf-8?B?THNraFlCTmxpQm1Ed09XY0Jyemt5c1dYSXlNQ1BQanp0Y01iclkvL2JXbWY4?=
 =?utf-8?B?ZU5rV3VnSnl2TUlBQ2VncWRDVC9wZWtmWFl5T1Z0Z2JudkMybXFRaGhhWldn?=
 =?utf-8?B?RXlLOExDNG5OdUo4TWhFRjI2QjZYcHY3TG03ZncrVXdZT3h1cXpRZ3ZpdTJy?=
 =?utf-8?B?bkZBWjI3OGpReVlRb0p6MkZWL05JVXc2aVhLb2F5WGpQTktrYjFGMTRsSWxB?=
 =?utf-8?B?UkVMTmppQitrSy9QOVA5dzYydUc2aUpKNFc4S2xCbHhkT1hucm5DSlpyV2xQ?=
 =?utf-8?B?b1V5NlFNLzRhZWJxblZDMjhFQnEreUxkQWV0R2xrbkZZZkFON2M0dVNnVCtO?=
 =?utf-8?B?ZmlneDFTNTljOVpPYUZmeGFDS01UbHNqVGJmeldjWjJaUFZqSVRKT2VqTFYy?=
 =?utf-8?B?SnVXS2x4Y080VnNNT2VSVGtFemVMdGtvd21GaEEvNFpDVzdKcUNUbExNRnl2?=
 =?utf-8?B?LysxTklVL0hZVGhuUDMvZnFQOTFRR0puNUswbitTNFJxZ2srRHNsN1V5OHFv?=
 =?utf-8?B?SWVxdkJzRjdTNzhQNGJIRFNhcTdtMHhoU1R6WDIwOHlSMjFuekduUld1UVRT?=
 =?utf-8?B?QWxWQW9LV2RoY0NRdUxvZTBSdUVwUkZiZlFjcURmeFYyRkZDRXV4OFV6OHNs?=
 =?utf-8?B?Mm5CQ2RYYVFBOFJELzZLRVpTVUVRa0h4T3B2MjhSbGpyZE5uNDJiZG55LzQr?=
 =?utf-8?B?ZFlheVhyVWdrbjRZVmJNdE80OU82aTdmVm83QjBXUDFxcVY4Qm82SWhGK04z?=
 =?utf-8?B?Y09FSmNSVUZ5Z2VGczhscGkxU1VYVEN5Y1pQNE9HbjA0RjN1ZzRmOXZTc3Y0?=
 =?utf-8?B?ZHE0K3hESmY2YXhOVC8vSjY4clBlQ1hTNEtKRSt2VEVzSXo5MCtGQzU0U0Ra?=
 =?utf-8?B?bUpYUHR4UEhIblM3SmxHM2FCbHkxeXNWMjl4clRJcTFlQWlkdFFmRUd0dktX?=
 =?utf-8?B?UEFlSWdCUWlJclgyZjNId2ZjRHZicGhLTU1IQnFCTWFXdUVGS1hiVW1mRzZo?=
 =?utf-8?B?bUVMbjNoTm9FTmM3Vy9YMm9iT1FBVnZFOWRqbGpsSkdqdVdUOGJpbjljV2h4?=
 =?utf-8?B?MmUwM0l2V2k4SUEzM3BlSUhGMUZYQk9kdDBrZTh2MS9vVHhEYzZZRytoMGxS?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/CHrbAkM9zb9Is0TMPt1kARL8ZBHzbDACYjVBw9qEDMbI1OjKhyV0YNDAxVwFKON/Th1HIxpRxi4ShEid4B7EG17YhKWSrDcZpZfHIgSSoN45jUL8EA2kgcFQaXIbKjE1/yCd0f5oAHIhAL4TPg6hQ6cu4WdJLUqVkYT1t72Ilh2WSrMLLdc0I52qmaQcZY4K2//a86B0UtHM8I3s5U+3CjRJJbVXZJq/d7FZsflrLCsS3ESCQ8O7lDw1Q5WTR2lYJVsb47c7OZylb5Yw5IOtf+D5lunTUyUMjtis7EMt2RQkP2k1QTsVVjKA/aNUlXV301VGDyqRCxoZaQYxSq5AIlBkpVuQhQXhtF6DupytgTwXNFVPTu7L2NN2Mhh8SOTXiSyLl1fvEW3Ypxm4EJ7lBwnRYVx5zSZ429cGMpSJEe/A6f+9QwbBPjMiA/GZo8wv8yPoLyJwVECS7/WlVgZGMVHe3bOlfjSY5kSdzuCoUlm2ezPxZnzNE7HPo5e7NJt7TEycGfquPtiKmI6w31qBC6ez8CKnmlhXxDKnOnM/s1EDdf6HzqONzizzJxZXKeYGi7Mnx0PuoHJn993YNx2+0CMP9GzbeiM0Vj44JDGRhc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d0ef61-3db9-4078-c7d7-08ddcb8d297c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 15:08:50.6367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lbhmgia3PM/w141jcUdTzl+mEYAOoLWEj+XSaprrJqAm3PKedIdeRAZEuqLuMgRsoClV3Itlr6DiULPRx+y4DC+qbJLuHlh1ukgGEzQGXJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5161
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507250130
X-Authority-Analysis: v=2.4 cv=Jq7xrN4C c=1 sm=1 tr=0 ts=68839e0d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=pGLkceISAAAA:8 a=xqhx_5fQM3tRZ3dPEeoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: C2usxztbkWYt-fHSRAHT4pxXPDaQgVEE
X-Proofpoint-ORIG-GUID: C2usxztbkWYt-fHSRAHT4pxXPDaQgVEE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDEzMCBTYWx0ZWRfXxwMXQFfPa+XZ
 u91SWMzg9P4fNaBpY0qEzidcZ08tAocdYRSkuPwd5YWOOkYRcPbP3AtOk1g1OGAujytUALX1qZP
 yL26h6dLLntgiJ7LqvGQQtI4MWyAsWsX80g8QdwbfVneVxaatAmCQqaQFiICJYxs03ez1kGeMlG
 Kv6bp+Ajvn1wEG9Hohs3/Dco5FtHGsR+RFi2biUhfNzRWtqltuztHF8NAkFsdrgXybjHi/R4aJK
 Lb3yvMcEwoP7wJUf07kQwM/wQZlz89oRpxPQqWij5e8KmAjigjrJTGAh6hdYLngDQvX1BCoV2W6
 ygwe4TWsAOC9llIZqh/nVM8p9/TPyHwa+Lu9+mR+fa7MbgfIfvRi2aiHzwhjo2jya5RjFQUs2U+
 Yimm7QbA3gI3rVppICwY7MwbS6PZEGXgf6GywfpEQNc+b0bESZUbNT0XDucop3X7c+iS2Brt


> +/*
> + * Platform driver for Ayn x86 Handhelds.
> + *
> + * Implements multiple attributes provided by the EC. Fan reading and control,
> + * as well as temperature sensor readings are exposed via hwmon sysfs. EC RGB
> + * control is exposed via an led-class-multicolor interface.
> + *
> + * Fan control is provided via a pwm interface in the range [0-255]. Ayn use
> + * [0-128] as the range in the EC, the written value is scaled to accommodate.
> + * The EC also provides a configurable fan curve with five set points that
> + * associate a temperature in Celcius [0-100] with a fan speed [0-128]. The
> + * auto_point fan speeds are also scaled from the range [0-255]. Temperature
> + * readings are scaled from degrees to millidegrees when read.
> + *
> + * RGB control is provided using 4 registers. One each for the colors red,
> + * green, and blue are [0-255]. There is also a effect register that takes
> + * switches between an EC controlled breathing that cycles through all colors
> + * and fades in/out, and manual, which enables setting a user defined color.
> + *
> + * Copyright (C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
> + */
> +
[clip]
> +		if (val < 0 || val > 255)
> +			return -EINVAL;
> +		val = val >> 1; /* Max EC value is 128, scale from 255 */
> +		break;
> +	case 5:
> +	case 6:
> +	case 7:
> +	case 8:
> +	case 9:
> +		if (val < 0 || val > 100)
> +			return -EINVAL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = write_to_ec(reg, val);
> +	if (ret)
> +		return ret;
> +	return count;
> +}
> +
> +/**
> + * pwm_curve_show() - Read a fan curve speed or temperature value.
> + *
> + * @dev: The attribute's parent device.
> + * @attr: The attribute to read.
> + * @buf: Buffer to read to.

"to read to" is awkward
Output buffer.

> + *
> + * Return: Number of bytes read, or an error.
> + */
> +static ssize_t pwm_curve_show(struct device *dev, struct device_attribute *attr,
> +			      char *buf)
> +{
> +	int i, ret;
> +	long val;
> +	u8 reg;
> +
> +	i = to_sensor_dev_attr(attr)->index;
> +	switch (i) {
> +	case 0:
> +		reg = AYN_SENSOR_PWM_FAN_SPEED_1_REG;
> +		break;
> +	case 1:
> +		reg = AYN_SENSOR_PWM_FAN_SPEED_2_REG;
> +		break;
> +	case 2:
> +		reg = AYN_SENSOR_PWM_FAN_SPEED_3_REG;
> +		break;
> +	case 3:
> +		reg = AYN_SENSOR_PWM_FAN_SPEED_4_REG;
> +		break;
> +	case 4:
> +		reg = AYN_SENSOR_PWM_FAN_SPEED_5_REG;
> +		break;
> +	case 5:
> +		reg = AYN_SENSOR_PWM_FAN_TEMP_1_REG;
> +		break;
> +	case 6:
> +		reg = AYN_SENSOR_PWM_FAN_TEMP_2_REG;
> +		break;
> +	case 7:
> +		reg = AYN_SENSOR_PWM_FAN_TEMP_3_REG;
> +		break;
> +	case 8:
> +		reg = AYN_SENSOR_PWM_FAN_TEMP_4_REG;
> +		break;
> +	case 9:
> +		reg = AYN_SENSOR_PWM_FAN_TEMP_5_REG;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = read_from_ec(reg, 1, &val);
> +	if (ret)
> +		return ret;
> +
> +	switch (i) {
> +	case 0:
> +	case 1:
> +	case 2:
> +	case 3:
> +	case 4:
> +		val = val << 1; /* Max EC value is 128, scale to 255 */
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return sysfs_emit(buf, "%ld\n", val);
> +}
> +
> +/* Fan curve attributes */
> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point1_pwm, pwm_curve, 0);
> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point2_pwm, pwm_curve, 1);
> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point3_pwm, pwm_curve, 2);
> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point4_pwm, pwm_curve, 3);
> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point5_pwm, pwm_curve, 4);
> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point1_temp, pwm_curve, 5);
> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point2_temp, pwm_curve, 6);
> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point3_temp, pwm_curve, 7);
> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point4_temp, pwm_curve, 8);
> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point5_temp, pwm_curve, 9);
> +
> +static struct attribute *ayn_sensors_attrs[] = {
> +	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point1_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point2_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point2_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point3_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point3_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point4_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point4_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point5_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point5_temp.dev_attr.attr,
> +	NULL,
> +};
> +
> +ATTRIBUTE_GROUPS(ayn_sensors);
> +
> +static int ayn_ec_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device *hwdev;
> +	int ret;

ret is unused.

> +
> +	hwdev = devm_hwmon_device_register_with_info(dev, "aynec", NULL,
> +						     &ayn_ec_chip_info,
> +						     ayn_sensors_groups);
> +	return PTR_ERR_OR_ZERO(hwdev);
> +}
> +
> +static struct platform_driver ayn_ec_driver = {
> +	.driver = {
> +		.name = "ayn-ec",
> +	},
> +	.probe = ayn_ec_probe,
> +};

Thanks,
Alok

