Return-Path: <linux-kernel+bounces-849227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 141A4BCFA40
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 19:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DD134E5FBB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 17:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8039A2820DA;
	Sat, 11 Oct 2025 17:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kK44yl/K";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YbEd9TBZ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7738D33D8;
	Sat, 11 Oct 2025 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760203696; cv=fail; b=b+3iUrl+ht4D32OAFyWu77tVj4HRHYFyHFvpuxn0zhEGl2aoHZTBdsFuEqQZAUIE2p+qmkKHx6H/9+XM1FQW7u1OBRplGYgbfhW7zAz966u/5gf88Yy6GWoKrq7xHa78945GyG55PSSfxtqb/EJa0fkGa8OVL0SXshvS4ouEsoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760203696; c=relaxed/simple;
	bh=nZJVEKzc9fUlz2YAmgBpgkMHvZSSEJtBgY+8M4v/pXc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jVd0ojpyheMxgTo4bd5+fCkEQy0TgT5wpSOh4Tf/50z6MeIqT+2B7YZt+xdeDWGEB1P548TM7jWaAxHxWXs1QmMXIpr08KcZLY9Vl2Oa5NN7Vno7npgp1OXCjdGvXlK03PuR45e1K/RQ2LxUgfF/Y/HthXqZjmaSyZtETqOJ5To=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kK44yl/K; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YbEd9TBZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59BHDwAB023222;
	Sat, 11 Oct 2025 17:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=W7IpGEM75cy5sRQpoS3Oy1xKpMb0x0LaZWRxoXfj2XM=; b=
	kK44yl/KkHJIobfKUQz39YglVo3vhX/2tgSIKQGlopmkDkb1noN8VF3s8WXajf8B
	rrQr0370JLBnrKMIhP9KaHiyOjZI5JIJ2mBE8hnOKN4GRszvwFYckXdwkiHJvKbu
	iAHdFYPZpAAOkwHHy3XJHKoPoghwh/7l/JqoPw6gvFldk/NrIqrZXIkKURYD4nmx
	1spUEEn2TjLehL4cbTE35ALG0rDuDaNuu9sgwkycO79/8DJo3AhsaeP/rNAu6AJQ
	JNdgFAqtQ812ZCRWLsCTPkgZNJFq9Evux3zjZn4ZtkQdL6R9PJ9EULe0kKxCqSUS
	Xy0jquPG0NkaBhoc7zwWOA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qdnc0g1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 Oct 2025 17:27:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59BDK70U037124;
	Sat, 11 Oct 2025 17:27:55 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013071.outbound.protection.outlook.com [40.93.201.71])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp65rdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 Oct 2025 17:27:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzPulGdqGAKY9FMXgROQh8TuNrqIJFjU/Vf+vEl4+08gkQDxyOY+KxnozBB1gfe30/FKRdXOp1UdiHEgUFgK1Z9bZfr56AMTrUE15ZgxRJ13KWWbOa9JjUW+AIg7spqFZsjWlLfLktlWJ1JtRHcfq8Bfcv/EAKC92jsm5TbZIRIUu7SNtG0qKxnE1qbfvXgKJVYDELXY7XzAhxFGhG+JdLqzrOQbPegAMF989cKUlglOCX4lD8mhvZR6cKXHKPqP0ii+Hq9wYxQNSlpr5AlSJmpynWr/L/D1di4C6I40JwS+WGMoIOcb2cTsUBufogHpPu5XgJSbs5uznVLS+rctjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7IpGEM75cy5sRQpoS3Oy1xKpMb0x0LaZWRxoXfj2XM=;
 b=YblzioKshd63OYBaqA+lK5QTbRBSklXrWubowrRKnNTja8WS8H95dIB5QWNcpR0KM7CuorY332wWBd26EaNgaT4kqYOCqseJ9eF3wprZaQ6FzXMIjTZy0qaf36YHgMrQWXRhy7EjfkJr0KIwoi1R4nxCdTHhQWaepOOqxFfz5Oh8efwBlCw6OZJlhpMY4NCeQTZOFD0FevFdIKRZmLdoIjTMsH4+Q2aMCaHxrgdkCUE5ORtDmC6IyLJKJ47z4btARHDau7T5z0I7JSyC9G2VYJPDzqZ7Qi4PMOvrPPeJjdvKykG/37QNN7XfbDYDZkC9T32Fc0e6wuiJz/93Yb2T5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7IpGEM75cy5sRQpoS3Oy1xKpMb0x0LaZWRxoXfj2XM=;
 b=YbEd9TBZZuIj6PXE3tisH5kPGI07wXLwgoCysNiKbXRQxU3jbGDjMP6/wqe+MuRW/p8VZd0+DQvwmo3JvLROa0QM4t454gSmIPuqbqyUkhSxGAJTOsDbvWPMTha1SwQIweam/R7qB3j2A8IOTYbxfiH50pTFox5/QW84E+dhDQU=
Received: from IA4PR10MB8421.namprd10.prod.outlook.com (2603:10b6:208:563::15)
 by PH7PR10MB6987.namprd10.prod.outlook.com (2603:10b6:510:27b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sat, 11 Oct
 2025 17:27:53 +0000
Received: from IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77]) by IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77%6]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 17:27:52 +0000
Message-ID: <73bc2c81-2d8d-4d17-8adf-99770846b979@oracle.com>
Date: Sat, 11 Oct 2025 22:57:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: gpd-fan: Fix return value when
 platform_get_resource() fails
To: Cryolitia PukNgae <cryolitia@uniontech.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
References: <20251010204359.94300-1-harshit.m.mogalapalli@oracle.com>
 <5FD7E8DCAC61F6BB+8248b939-e3b1-4966-9e6c-3189dd64029c@uniontech.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <5FD7E8DCAC61F6BB+8248b939-e3b1-4966-9e6c-3189dd64029c@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::14) To DS4PPF5E3A27BDE.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8421:EE_|PH7PR10MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f1d1bc2-cbcd-45b5-0718-08de08eb819a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGxYV3pTclpiTDV4WjJYM3N6ZWdDNjN3V0UwN3ZjWlE3djAvMEI3WW1wOXd6?=
 =?utf-8?B?bGUrSUozYVkxeGtuUCs1L3FTUzRlSEpnMTlPVm85OEkzcGF2Wk5zTGw4ODEz?=
 =?utf-8?B?bWdXNDdwU0FFMHlNTnNLMnEycEtkMWFpQ3BST3VPZUlZMHZuemxwNHJPT1Ar?=
 =?utf-8?B?bk9KTHhsUitSRlR1YUxWQWJnNTJSWjlIVWJVWjlUV1FNWWQrc2c3Sk1mdHdF?=
 =?utf-8?B?S2lLNzdFMGlwREw5dEpjaFhpT011ZFVCNGE1Ym9JZ1ZXK3NYWXpJMmtnZlpW?=
 =?utf-8?B?eWNCU1o0V0FqZXhhdlhKM2N5VndHdTg4Zndwa05TQTN5MFBvS3J6M01tY2xp?=
 =?utf-8?B?L05NdHdteFMySFZxMmZBdlo2VmFPblhEQmZEcHl4UkxtRXFRTkNuZEJXRVNQ?=
 =?utf-8?B?S0wzN0hkY2x4eVJNRW9mWlNob0lBOE82Mk9Kb0JMR2x3V0lUUkwveStpNTZ1?=
 =?utf-8?B?cnNFSmI0YlpscEwwWXFlOEptYW5lbFFqNTFjYTdZU0RRZjFDR04rMnFQemlP?=
 =?utf-8?B?TCtyRFZuOVo1UjVaWWpKc0h5UUhMQzdiRHh5T1E5WmlEclBxQVpGZEt1UWIr?=
 =?utf-8?B?VG9GM3N1SDkxQ2VubVBPOHVUSktxNEtFZTU3MkpUdm16dWtTaTZpVnVielVT?=
 =?utf-8?B?c1pLVVVSL2FROFNPeGRWUldaMkZxM2xyeFFaNDhNRXEvVEZxVzA5UWM3NEZw?=
 =?utf-8?B?UTZVWjRlNUpwSkZheXlYcSt0cjdVZEZwYTFySTJhZTQ3am0vb3Nwemhid0ZY?=
 =?utf-8?B?NURjaDFMQlNCRGdLaXFYamREdE5SVzM1RFIwb1QvRU1LKzN5dDdKSW1jYlV1?=
 =?utf-8?B?N2dBaTJzRkhsRmE3cGhqcjIxNm4zbUNRb3pzcCtNVUxLV3pKTVowQUV3UEdv?=
 =?utf-8?B?UXpxYk1Yc3p4RnUzNkFNcU9pQjd3OFNIVE5zd083M0ZvR2FsbHFvc01NTU5R?=
 =?utf-8?B?c0RhZ2EvL2xtUUppYk9FZHcxU0orbVpnT01KVDJ5NUdNSVc3MHNSem5yNTRp?=
 =?utf-8?B?dVVIcHN5WHNud0g3dnpnbWFPV2d5U3Qzbk9JN0RZaE1mSytUc0twVlV1d0NL?=
 =?utf-8?B?UFZnV0NzVzNFSTJ4dEptdEN1d2ZBODhsNnh6eFRJMk5MOHg3N2hLMTBXSmFk?=
 =?utf-8?B?bzM4cE5tV2J0bEkvWm53S3d3bkVRR2x0WU5LbEpEcVkweGVNMXVPTDhpM0dn?=
 =?utf-8?B?V0JrWFFCTUw4ZzFhMllSVTdXRlhyYW8yNzZsd3FOc3N4aDFKNXIzdllqU1Yx?=
 =?utf-8?B?WFd2Q2dYZndYdDhvNjYxNWhOTW5KSk1xOUM4WHFCUm5iK2haaFd0ODE4Qmlp?=
 =?utf-8?B?Skl4SXR4ejFScGZ3UnlKdXBwY1dkcHhBcDF0MkttWWx0RjVPdzZTNXZtV0Fo?=
 =?utf-8?B?S0ZCQzRpTk5vNkZpNExHMDdmWTJGZUNjaGtDTDIyMnJiaThkR0ZjSEV3R3B5?=
 =?utf-8?B?d2xZd3VyeEpOeTYvOC92WmJFRm1TS2JpSmNqU2tMSmFWYVY4UjE4cS93dG4r?=
 =?utf-8?B?K3NZYWRpdG15dWZ5T3hrOTRvTHd1K3dJaFBvdGxFL0doSDY1RHR6VTFsS1Rt?=
 =?utf-8?B?TDAzc1c3MXlkNDBWNGhjcHVGaUNBKy9wVUdRdzFqMnhUVWNpQzdiK3FQbm9E?=
 =?utf-8?B?YU5CL3lFTlVTNnFWOFJpQ1YwMnp4UDVtL1Q5OE9xVWQ0MHk3YzNNVFFtblR1?=
 =?utf-8?B?U0lVQ0NLbk94cXBQaTVPMlpoVi9nWk53ZEZiSDc3V0YzZERkdlcycFU0dW0x?=
 =?utf-8?B?enlJSThJOHNHYitBNDd1eXRuVWdVak1UOVRpczVkak5yUVNac3RkaVdjaFpL?=
 =?utf-8?B?ajFiZDNZOUw4WXkrU3FLZzJhU2xyMUFyZk1QczlBZXRoRGdOMnhBeUlDMjZy?=
 =?utf-8?B?RVE3YmUwcEZoRWxlNzkxMzVBSm9XOGt3MmY0R2s1N3JsVE9tUkNHamNsYTZH?=
 =?utf-8?B?SnpwQkxHN0hCZXZlU0FKcUZIdm5mNFhTaHg1cjllUjRQUCt5YWsxUnlwck8w?=
 =?utf-8?B?REtkN3V0MmtRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8421.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3BlTjBHd0Nvc2lPdVg3VkZjam5mQW5EenFxMFp5amcvdEVHcmZkV2pEci9P?=
 =?utf-8?B?VjBsNEN1ZGpoS0tyK0phOGlmTmtnNThsVmJiK2dPeE91dG5zRmJjKzhtU3JE?=
 =?utf-8?B?OHRiWVRGUHB4ekJiU3l4ZUh1RXJJbkkyTXliNWFocFM5TVJGejVkMmdFUTB4?=
 =?utf-8?B?dzh4eEt3T3k3a28zZEdvSzVJdkRXajAwRk5QeGdyMjM3d2JDd1dWVm94cnAv?=
 =?utf-8?B?OWlLdUtKNlJSeThzY3BMQkdZd2syQ1lVaVhCeHJoaEs0SzNjcDBXeFlWRENt?=
 =?utf-8?B?a1phMWtuRG9CcDhTQWtiQlpES3IvQkVxU25CL2pIWnRUN3dGaldoWEdBYjA5?=
 =?utf-8?B?aDREeFRkK2xFQ2JIdHBCejhSRFd0QVAzU3NMNE5yTS9oUE5vY3k5aHJWNEUw?=
 =?utf-8?B?b2I1WlJSQU5VVEV2RWR0Y1ZwSHl2cGxFY1ZNTWp3KzN3TjF5dVNXQ2w3Sm9H?=
 =?utf-8?B?eXNXVFkreEdudnVpSzhSeUpDOWpaSjlwVDlnL2tvdXQrbFVDQ0w1N2Y1Q0pH?=
 =?utf-8?B?WStsZS8vNGpkdXlncFdPU0phTCtkblczUDMrMzJXTEh1ZGlBMTBiYU5OZUJs?=
 =?utf-8?B?dEZYR3BmcXpNbHJRNGFLY2lPNzR2SFBuUnFsakFmTGdQTzR1c21ZR0o4T0lo?=
 =?utf-8?B?MmlxUnZsb3VjUExUcE1SNElHT0pLb1FTbTZZUlUzT1k3b2hqQlNpazVOMGtv?=
 =?utf-8?B?d0VOSVVsMGxUNnlWK2ovYk5pOEpwTm5CK0hSenI2Rmk1Y01EekRtM0hsZk9j?=
 =?utf-8?B?MmhSZTFEZkF1THBFUUdsQis2NVR5OEtTSjRnNXRBbUxRS2xPaHo1aWlUMjN2?=
 =?utf-8?B?aFRTTzJrMkZYdVFOK0lSZlJ4MjZKbkZQNHBtNFA2U2RiYkJiTkloS3lOODY3?=
 =?utf-8?B?RFpqdzBEeXR1UVk4aDAvM2FlRGtCM1ZvdUsvVk5YMzcyUnNEdEFxbG9zL1dt?=
 =?utf-8?B?L1ZGOU9qaTVnMTBLRENURCthdlk0ejE1ckRhQkR5cHkrTXpBeEVKMmJwZ1lO?=
 =?utf-8?B?dU85K1ZqWk1udG1YSEx0VzZCeTFMdmdYVW1XQ3R3Nkg1aG4yNjBqM2J0UXRq?=
 =?utf-8?B?QUNhdHB4Zjl1aDRIeU5lMDhwMkg5bXhoU09KS3V3Ykt1MGtCMGNPUXZnOWhu?=
 =?utf-8?B?U0lEWCt0YnVRbzgxK1YvaXhBQWVjaGZHdU1VaHI5dzkvc1RRMFJCS3N4eEdM?=
 =?utf-8?B?NzBGdG9hUFNDMkkyUkpjSjVmS2VoZUFXNVB2WnVxT3lzd1M1Q0tzb2xwNk00?=
 =?utf-8?B?RWxvbkxyZnMxKzhOeG5rMSs3dGxkR3NlVVIrY2YzeVJ0Y1RBK014MndkLzBr?=
 =?utf-8?B?RXRnSEJKNER1eXY1YVhtSmZBU2xNOW1qZWRpV3ltckxUdXFTWGZmcndoOEVx?=
 =?utf-8?B?cXp4OW9qbWFScnZnM3VTOFpVdmNTSm8rRTU5NTJGdktFRGczdnh3VTdXbmlW?=
 =?utf-8?B?ZFdIcmRCNUppY0JuSlNESGRDYUU2cVBKKzRTUCtqL0M3RDV0Qy9aS1I2SEN4?=
 =?utf-8?B?TUZwc1Q1ejc0UTFoc054QUhWajFrb2tkdzUrNnFZVEplUDhId2ZPQ1Q2QXFV?=
 =?utf-8?B?ZU9XWFNzUHpLNVZ5QldtSGFMMEdCRGF2WDhmeGh1eGdIUFJ3cVZrK3Y0YkdD?=
 =?utf-8?B?K1I3SmNTaVQ1cFd0eHFwdW5GZHJMZHdyb3ZQUmY3TU9ZWlhicmNwNzAzS0lF?=
 =?utf-8?B?QnFkdkpYT0U5cThwS2dIa0ZWV0VsNVpoRGZ5c010RlN3UDRkcWN5QTJ6UlJi?=
 =?utf-8?B?VjJjQXpYTDVvVWRXT2EwdDZXdnY2VURnVldOZHJBQjIzMU9GZEZXY0RmaFFL?=
 =?utf-8?B?SXljWEJ2dkNOWG5hKy9Ya09nNEowaHNEcTBVMUxtTFZuOTFFN2taOGdlS010?=
 =?utf-8?B?ZW1Gb1p6ODlKblRzUUpCcDFQODNaeG1HUldFTHFXZHNiTW80SUpha1VTUyto?=
 =?utf-8?B?L3k1L0RZdmNxZkp3YmVmYmhxV0pyZVdzNzZ1eDJmQmh4ZEk1UVUxL21EUC94?=
 =?utf-8?B?di94THpRdVM5MVBaTzk4RzNqWEdiWU5naWtrVWV4OHIxNlczZGVScGR4Z2R2?=
 =?utf-8?B?Q3VVMVpTTHBOL3V2M2t3UXB1eFY1M1NSeWVqOWcwNHhIVHlQYTZXOGtna3Ba?=
 =?utf-8?B?YlpESkJZWmlpLzMyN0ZxcmRRWTBqK0NrSlUyUEx5OEZTcElmYU40bFBLSWx5?=
 =?utf-8?Q?DuhOp6LCJCIqhWB/l6cHW4Y=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XmsK5pNCzLxDKdKX4UNyXtWzBKKtjbzdyMqzTElIk528EPg7l2Txy6T/gGDg+Sh3YeQAT1f/VXJ8WLXHC/Zlc4m+Y92eI6am/8XzSHrW9NtJhKJqgQVyFjmwU1x/AVBGojPvOP+hvNrzuVg5chOLIwI8ys8F7iolfEKWKRggk2OzWENpxY2p6mTmFPamj2pv9Vx3erSCoZI1nQ3nQRMV//FMYGmlmyoZif3DQ5fak41kmhBILXWgTsqe/itYhG5oEswqHHGVWAy0h/JirHE64AlV5HW3PXhUmzESUkmvP2T0oMDd7BWP3L/DxntXDA5/4c/J2oMU9/bk0XoAQ7R64VigtMhI8H80DMaW+IieDFrac+iwCUYLRNNMNaBUVZWAOGvmWwbJXflmhM7YVIkNNJuDS7oYrflICn7uGS40YEyl57jI3RzbUVnAA50wBVV8beq3PIsPOIC0HbiuaidYhJL3TrewLyy31jtRXErYRxEMVUfwLgADLdSd1i8AI/oOalkdPT0nzqCpO6hChbfzXho0gCfeDgjELWyesZ/OVx+J1pN/QDdd8fcNIDQhMVar/9x5+h+x/H8wIpcBp3PigZh799IvNHRfwC8fb2+tO0A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1d1bc2-cbcd-45b5-0718-08de08eb819a
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF5E3A27BDE.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 17:27:52.6153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qhl+mG+KwP2LJpflqNx3LcYjPJGDjUwY/ElyzVJbU5XGPJrcUdbLZXSZH+XGeyOeodvBGoty+sDVdcb8t6M2m1DEXJdHNZ+vqDedHdr16KJtHxheRJ7iijNw5yB88SbX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6987
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-11_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510110098
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNiBTYWx0ZWRfX9Rnq3VWraQUa
 L2E+hZaQ0KIFlG3b0wacQszhO2lMhMDAVWQhyj1oGZ108jxkBRcJ8rxKUPpbVwERipMylwSJcGU
 ajRkzM9hVGZQZrg8svfyyIgkZVey3mGmIOanPFnfgU0nwWKXHP4TblNGbTwQM6ZisUrOu5KN6GY
 kp9wOA0jWmycfNc8gYu0tpbFXeaFQq4p97d4EUtSzNviXvi2jrWMNaL/Jqxa1SL6oyyYSFhUUV0
 dVHxoFlJddmtI+j/t2x5NIcvVkPC42piOXx3B6+DAeHjym4NAwnGcPguzT1d16vcUKROhdGFmwA
 O8j1hjAJ7RZ1CZ/01m8/tazxZtIk53mVu/NBLQWaJQ/UiDUsH45rSFuwchuJt/7prM4IQhB7nH5
 RyP1dIPc9ZtFBF907ISR8BJj7+iwPw==
X-Proofpoint-GUID: nfAdnyzmuL9GbVgtg_aAaJ_RGBeNcq9c
X-Authority-Analysis: v=2.4 cv=ReCdyltv c=1 sm=1 tr=0 ts=68ea939c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=-zXEB3PgJ_JIcsOuWFQA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=HhbK4dLum7pmb74im6QT:22 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-ORIG-GUID: nfAdnyzmuL9GbVgtg_aAaJ_RGBeNcq9c

Hi,
On 11/10/25 11:42, Cryolitia PukNgae wrote:
> On 11/10/2025 04.43, Harshit Mogalapalli wrote:
>> When platform_get_resource() fails it returns NULL and not an error
>> pointer, accordingly change the error handling.
>>
>> Fixes: 0ab88e239439 ("hwmon: add GPD devices sensor driver")
>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>> ---
>> This is based on static analysis with Smatch, only compile tested.
>> ---
>>   drivers/hwmon/gpd-fan.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwmon/gpd-fan.c b/drivers/hwmon/gpd-fan.c
>> index 644dc3ca9df7..eebe39ef9677 100644
>> --- a/drivers/hwmon/gpd-fan.c
>> +++ b/drivers/hwmon/gpd-fan.c
>> @@ -615,8 +615,8 @@ static int gpd_fan_probe(struct platform_device *pdev)
>>   	const struct device *hwdev;
>>   
>>   	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
>> -	if (IS_ERR(res))
>> -		return dev_err_probe(dev, PTR_ERR(res),
>> +	if (!res)
>> +		return dev_err_probe(dev, -EINVAL,
>>   				     "Failed to get platform resource\n");
>>   
>>   	region = devm_request_region(dev, res->start,
> 
> Has it already been replaced by hwmon: gpd-fan: Fix error handling in gpd_fan_probe() ?
> 

No, this patch particularly fixes one more issue with return value of 
platform_get_resource()

Thanks,
Harshit

> thx
> 
> Link: https://lore.kernel.org/all/20251010204447.94343-1-harshit.m.mogalapalli@oracle.com/
> 
> Best regards,
> Cryolitia PukNgae
> 


