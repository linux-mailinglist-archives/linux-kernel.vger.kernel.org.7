Return-Path: <linux-kernel+bounces-794120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1867B3DD14
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A74047AE779
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CE01DEFDD;
	Mon,  1 Sep 2025 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ITa3b78w";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0HY/19Mo"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4238C2FB973
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756716771; cv=fail; b=NYhNyCB+KUbD+YqDp1wkygCyHKJwXlfCPSfqAx4iMQg/IXtyHA1OGhgGZFuUhg9iNN8+wodoUnHT/mJH2Xx2z/e1lwyniA9weZuxZBykbUh/njE6eDiUHxv5umIlWt72NDDQyzgs5m4U1uzmafEVsKHGZ4BhWScJOeOLTnBdTAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756716771; c=relaxed/simple;
	bh=pYR2CJ41ZC9RwiBi24yq/D7wfgZkkScYvD+3lXwTu7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YUE8xs2rge04kgXEk9MTCvqHyE0vsJM9nEf0YEnovL3wiOEojw8o4Sai06F6zTBB7DoLI+O89iWBOyVw+Z62hjb3BaQV27dcDistZmLJb+DSOUKa1jeSkOpK0DQfe1O/nFxDS8i8YZ1eB+pkQ3YqUu+TnOo86XtP2cLoyRqhNKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ITa3b78w; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0HY/19Mo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5815frV7018261;
	Mon, 1 Sep 2025 08:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=pYR2CJ41ZC9RwiBi24yq/D7wfgZkkScYvD+3lXwTu7I=; b=
	ITa3b78wPME5PBzbvCCWFkozre1BycTPIX9gPe0MgmKV40FH4EAunl4ESqL8jZc+
	xQoLyg3L1aGGJ59WpcAIL9gnKLYmmZG2jMduIHS1p7R1O/vYOgIgdBqNZzS07BcY
	H99loLD9d7OqiD1TWIEoDKIeS3SWx3GBcuxjG9f6TnfdVdxWC5OAH4BiEe8yqYIs
	0nFCtn07GzNbo5qhHBQ/BmECW9xGohRHNe+VKZk+G1rCJaodEBIV2mMX5AatYWzc
	a69S6lOi2iciacxQerXo1bN2gmTgbwUAw2WXkgFMG8zx3oHq8GMlM66HjJBQvZvE
	vL+414rY9CwoGo5q60xIzQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usm9j2h2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 08:52:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5818M47a004247;
	Mon, 1 Sep 2025 08:52:32 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr7wc6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 08:52:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlMVobEYOKlEyyYoATj8qffDyfPaMmav+88KP8X9bSoIQdu5D+OXM9swPVncn6LYIarsx4Kc+TRCv+oheuFQ8mHNaZ/cmzJovwNRRKcxr5QiuJFjHva9VPknFCSw+FsA5Y/cvTb03VcocgSLMxrnplNaH8mjCauZuTLu4yULkbrzWYC3i1gD7NXXFTIj10rP0A8d9M5G69s6i907G7SW/xQrFP0W4fqaW9Z1ST7TmY881a/OuEUPtD9zqa5IgbXE+NwnIfs4AEK+EU/2mjWzt33gG86AVieoeH+tY52htSN0UVOAT92U07ThRHhYvjEdabCub0X7FSjAHi6goTHtAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYR2CJ41ZC9RwiBi24yq/D7wfgZkkScYvD+3lXwTu7I=;
 b=BuDE30VW9cs9jQ+mVL4k7FrHOTbF0XuK7BlTAEf1guW2lrhvolz4VRTpKVWsbeUKl3asTj6lxiUuS5+CBP76AcZTEKFhXL0Di+Ds92PHhGGgqMwjvS5FHUfJ0NpLqJI2xaKeiHDB9cwnEa2s6Z6MJnWykiZw5E7PiW+6fMtmZ/OPAJ9nppkfXpNWRjq8I8rUyctEDTpcDyvRzdZj6rU88IjfCpKutUy/Aw7Wtduf+SSFftV7xFR6BWlEb6+WL3pHxbE4q7yNBM+K92VgohuGgHCSBUsIQ5LWhWQuLf9GTTrlDpk9uQewm/oZlYI9NnDDAiogglpt7i09DPGLYG6hCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYR2CJ41ZC9RwiBi24yq/D7wfgZkkScYvD+3lXwTu7I=;
 b=0HY/19MoC8ClS0ltMwSCqz8jovPp1Wuxj3DKheq1WZeZeUUZIIdHyozWNbd8YwRmirRemGENyLMXCW94Jbc33G87+cbwgGvyiT6J6uuH1fRXq7pHjd7dAd+Yph77x1w8RkIQd8ApxtnyVTR+C8jWf4rVgWaWgAFPUmRMavVCjNo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF1BDA8E55F.namprd10.prod.outlook.com (2603:10b6:f:fc00::c0f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.28; Mon, 1 Sep
 2025 08:52:29 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 08:52:29 +0000
Date: Mon, 1 Sep 2025 09:52:26 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com,
        yuanchu@google.com, willy@infradead.org, hughd@google.com,
        mhocko@suse.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, vishal.moola@gmail.com
Subject: Re: [PATCH v3 01/12] mm/shmem: add `const` to lots of pointer
 parameters
Message-ID: <843b5ccb-ef37-4398-b6e5-5f1d997acd77@lucifer.local>
References: <20250901061223.2939097-1-max.kellermann@ionos.com>
 <20250901061223.2939097-2-max.kellermann@ionos.com>
 <052aee05-4cfc-4fa2-8944-4c85676c95ed@lucifer.local>
 <CAKPOu+-A6EoBnJhYkgX3Ktuivo2hpDZtbCKPfcmR_SNsvPQ02g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+-A6EoBnJhYkgX3Ktuivo2hpDZtbCKPfcmR_SNsvPQ02g@mail.gmail.com>
X-ClientProxiedBy: MM0P280CA0030.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::28) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF1BDA8E55F:EE_
X-MS-Office365-Filtering-Correlation-Id: fd170c17-0e87-4d8d-4bfe-08dde934e1f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3VhbE9TUnJVdk9hVkRRL1JRR3AwYXZWUVdsdnkrYWZGQ3hOLzRNNW9GUUNa?=
 =?utf-8?B?WVFQVVdRVVdoRUlEMFdiZFNoSEIzNFNZNUpIMlNPbklHdTdYU0Y3eTVpKzla?=
 =?utf-8?B?NDc0OUpDbWRNdFEyTVZMVXJHenhxMlNQVVliOWVac1lJZHJ4Zm5zMjZlTENV?=
 =?utf-8?B?ZXpVZTZWanFrdFJGMjExZ2tValhVVkFLOTAzNFNZaWIyaTZBWlVMYWY3c0Fo?=
 =?utf-8?B?R2dBMmt3RHhFOUI4Yk9LaCtvQzRlMnl5L0pJcVZzMnFlTUg0OFpBOUFYQW9r?=
 =?utf-8?B?S3BienhXYXBFaVlXNW1ueXNjMm0yMmtwakZETHE2eXhzU2c5SXQ2aFhPb1N6?=
 =?utf-8?B?dWFycUpEVFkzMjExSHBXNUxxTkRvUVBWeE9HdFBEM0oxWm1MT1B5UnFLYmdq?=
 =?utf-8?B?eG00MTlaNEN4eGlzWlJyeVZ1RVJhcEdKeTR1RncyOWtTWlNwWGp4b1RoVlpZ?=
 =?utf-8?B?bmE0eE1GQnRqOWt5Nk5mMzBPdXZoSnZvNGp2Unl6M2ZmeHQxbktNWkVOZmgx?=
 =?utf-8?B?TGtQSlNwQXluamRXQkkzRmd4L1MyWnNpRHI2RDJHY0NEUnEvMW0rcGsvQUZG?=
 =?utf-8?B?OGh1d09yWStRY29va3dRbmtWelVQaWQxOWdVcTdCdmFTTmZOT3NQZnJqR0xi?=
 =?utf-8?B?WUw3ZjFtZUdCcHpQamUrTFR4dHRxR0RzY1A0eFpBbDU0eklORzk0eWJ4OU1q?=
 =?utf-8?B?eTR4MkttZHN6MkxsY0xYZEM3U0FpbzV4QWxGYyt6d3oxKzlSVC9XRDB0NmZP?=
 =?utf-8?B?Nm14WlViejBpMXJZeExKRSsvZjJIQ2xMcWJ0aW9TcW1WejB3TmRUTlk5S29i?=
 =?utf-8?B?c2h4T1pudlJkSW5OVFV6Zys4Q1BSL2lielZHdEdyTXBZZ1VDOXFLZjBoTWlR?=
 =?utf-8?B?dEJrUzkzU3BnY0lLSk96TUpyd2JaY1JrRktaU29LcjJRbXpNdHFBakJIaER5?=
 =?utf-8?B?RGFYNXFuV3lRUjZKMyszdTlkWngvMEZJa1JoT1pGZ0RTdzhESVdpRjhNZ0dE?=
 =?utf-8?B?ZW10VXZqdGRtMWV6Mk1kM1pPaEh3ZHAxL1UzeVh0UUpGbDFiVXhFc21IR1ZQ?=
 =?utf-8?B?VEswUDNRbm02UzYwN2o4WDJHdjc2bExVUEF5dmxEYnNGNTFza3VQQUU2ZHNX?=
 =?utf-8?B?R2tDbXpnb0JaZWFWa3BvSEpod0dYUWpHa0pISnhMUmlrcUY3ZGUwZ0JFbWdq?=
 =?utf-8?B?NTZCMzRkbXNpbVNiS3lNY3Z4OEphck1Ddkc3NHpiRXU2TmlyblRuWjRkcTBa?=
 =?utf-8?B?MDRONG1ieHVRTzlLcFJBVzEvSjVpNTVGZ3ZmQ3J2c2dIL09ZTUdqa0hUZEli?=
 =?utf-8?B?SDZGMEcxVlQ2S2ZOSVRIQUNyREtIeWZFbmptQUxmdTliMENnWTR2UHpTaSto?=
 =?utf-8?B?NWY2UjRUNVkyMWVnQ0s0Mnk4RVNWbWVKWDNSNnhkN2VNaUlLcnUveEM2eDUx?=
 =?utf-8?B?NGtYWXZTTW10S3VRdnByNkFBRFc3QXUyMjBYMlJSWmdndjBaRSswSnRqbVpO?=
 =?utf-8?B?TXNvU0t2Ri9Mbnc0U2dRbTdmSGtUT2Yvdlh3bzdSZDRIWjkrT0JZWlY4aDZN?=
 =?utf-8?B?bXRldEJ0c3BlbUQxd3RidHBTaklEbll4SXFnajJIUTlYUVVKRWk2Z0c3K1hK?=
 =?utf-8?B?Q1RWZVpOQnV6NWE3eDVlNmdyQXRzL0ZpcUF3UUJaQVBjQjJrak8rVTByWHZH?=
 =?utf-8?B?cllJNDcyRlloSW41Z2ltNC9pWjJta05mYlVERzdkUHlkVUFGbkJvU1I2OEdm?=
 =?utf-8?B?UnJRenlaMmx1ZllGUWhnZE9EeW1Ib1p4NW5VYWhuSDVWL3o0MTlPS0pDM3d0?=
 =?utf-8?B?ckw2ZHRqakFCRmtzSHo5NThzMjRhaTVORUV6L0ZmNFdaRjFkWXZncjhiQ0o1?=
 =?utf-8?B?YnZlUE5qeXlOYnhTUmNObm1pZ0dFblpyU2xyY3Y3eDhseEpqVWN2QktaR3FV?=
 =?utf-8?Q?HS1dCsaJWpY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rng3bjdvME5OSXdxdGRnK0NGOWF6OGFlWS8rRjJSdzd2RmRhck1iekZzckdM?=
 =?utf-8?B?TzNueG9IbkdVM2JuaW1aODZtYzFySXJ6RXlJUnVVeTUxTEh5MXFJZmdPQ2kr?=
 =?utf-8?B?YzlybTJSK3pGcHA2bGlzQkoyWXdBSzI0dUE2di9EMkpuZk92VFlFcXdtRUc2?=
 =?utf-8?B?UjZnZnRJakZZRnZrNEFzVDVseUUvTHlNRXArK2JHV3ZwWk5rTEhhTk1KaURL?=
 =?utf-8?B?NEhmS1FuUzdHYWRLcXJPcUg4S083TXAvZ1Q3TnJwdWpRRTN2dUJIMU1kRmky?=
 =?utf-8?B?d2RMVDdDekZBaUxtNnpKV0hsUFM2MHViMTBBZk5iNmhDbFRYcWVFcFNaUjU5?=
 =?utf-8?B?cXNmd1dHYmcxYXN1bkd0SFAxNjZQRUZsRU5XdEZaY1lqT3c2OHVPblZWWk81?=
 =?utf-8?B?S2JNZElDQlk5QVJmVE0waDNJVUcvK3ZrSDE4MUxKMVg3bVdhV3FHcnBqQXhm?=
 =?utf-8?B?b2Eya205Z0l1WkJvOVJ1bG4vRnhqRjVsQnRLOUxjSUxITy8waTVCYk1BYll3?=
 =?utf-8?B?Z2VnTWN5ZDAzY3JzT0VKNVhpY01KVTJzTm5hT2NSdVowODJqWUVNMnRYNXI2?=
 =?utf-8?B?cm81SzhjR3I0YkM1elUrbFd3NmJzQ0pTVEt1UXJkR3B2VGYxRjNXOUpqZElL?=
 =?utf-8?B?cFhqOXRFNElLK1FvTDZCKy9Ra0pMTGZoRFlyd2RLME9EVTg2STVKYVpvWHpG?=
 =?utf-8?B?cktBR1hLWE50NGhuZ2JyWm1QN2xIQWgxaURubHI2MXA1Z0pyakpkUVMvZGRz?=
 =?utf-8?B?K0FtQUpvbXBqVWNqTzFZR1QrVmxZUDBTdFBwV2RWYmVOZlE5ODFMbmQvZWhJ?=
 =?utf-8?B?ekpzRGNpVmRycUhZS1lGV1lvMXYwSGdNWmdLUUxwSTFHWE9mNUROUHhCeVNm?=
 =?utf-8?B?Vm5kMXFpWnQ5aE1VQ1dvK2RWTEIrajE0UXh3UklmQ0NpQjZkZWx3amp5aXgy?=
 =?utf-8?B?NWZwQW9aQ25wZGJVbmU5L0kxMDZkMzh2dU96TVVkZ2RwN3dFTHg3UGV4a2VX?=
 =?utf-8?B?U2NHdXR1QVo4Zlg2UGxCdVNvYUliTzlTYk9xcm9qZks2NXZZTFludVlYTWxY?=
 =?utf-8?B?cjQ3dVB5cVE1ckFIdVpzVldZWUdnUzV6bDFZNE5nRWtubGhDUzAzZ3NMWnpU?=
 =?utf-8?B?VThVandMSzlSU2RwWDlZL2kwM3lkS3NLMWxMMWU2L1ovSEFnZEMxTHBuNFBE?=
 =?utf-8?B?Slhnem5SdHVuc0ZPbGFKZGdEa2ZjUFZqNGl2Ky9TRXlzMUFSVFhWVnEwang2?=
 =?utf-8?B?anRCOXhTMXdwZzk4VTdQa0grWUVSMndzdkUxNVF1ckVZZkNyUGZhSnRwZm12?=
 =?utf-8?B?QVZJQnByY1ZaREE0ZG05dnA4elkrY012YzMrSFVydzhmQWxFcHFXNnBSK2Jh?=
 =?utf-8?B?MTFBWkcyblhUSFZoRzd0VGUycFZBUjZsK0E5dithRjl6Zkw5Q3UrL0ViWDhm?=
 =?utf-8?B?TWk5c3Nya1dLWGxxM2t4Z3lONHJ4MXR6ZFQwcVc2d0N0b29Ld04rMEFlNUpk?=
 =?utf-8?B?aTB2YUZXZHdSSzFiemc3eUl4di9JK1RLNmlTZENNRWI4cGNVSUlOK21BQTln?=
 =?utf-8?B?ZEQzVTk3akdVSVlXWHJyT3RKM2tXc05FU0VmNmpQeUhkRm85SFJHWTB3Zkg2?=
 =?utf-8?B?THovNTNxcWZPNFlRYWtjci9NSzcrVFZDY2FVUGVsQ1dmS0cwdmRrZ2tLZnpG?=
 =?utf-8?B?b20vVmFiREtsQWJieDRLVHZQUFpVM2lWVjc4UHFIYUdwUktXa0NoWE1QZVor?=
 =?utf-8?B?QWZ5Vm1LQldsVG5QRVNNcUhpMm1LN3hscTZQOHlpN1RydE1tMDZMT01ZMkds?=
 =?utf-8?B?TU4xRjRncmU1RnVVVTBHSG9YNVEvN0llQVY2amFGYmVLdUF2MWo0YUIwTVJR?=
 =?utf-8?B?QWcwbXVGMUV4dkh6VUFNMUVHYWRaRkk0NStVM2NpQ09JN0JnWUl0bUpld3B0?=
 =?utf-8?B?MnliZUxKREZmOUxyazhQdzFFMVVueFVKWTZJTyt2UzhWcEdCTGhkRWcyQXY0?=
 =?utf-8?B?bnlRQnhJWkptVHVYUHAvNVFmRmxPN2QxcjVQMmlxdW1wbmJsQnZVNUhOcHg1?=
 =?utf-8?B?ZjRWOE50Z2ZwVHZHY0p3a0hMTUVoTEFRRTV0SFZpWDdnWjl1MTlDVi80V3o2?=
 =?utf-8?B?VEhqWlB2cE9UK2I4OWVVaGRpbEcvSEFqSThrekpGMGpHb0tOT3dZY0hVclVF?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nXT6mY027g7Tzozvgi2XG80dKFONPwgwvBPHqTAbGANV17zEo9tUb8Ujv+DnNE/ZsLYqRK7mkfVQ8k2kRXIq4d3qTewxacs7VPyAgM7MG7+qmTI6wEy8Mp2KqrRKvW+aLUfIDHL/6YwTJpYB8rsUwU4X00q2GIOoTjlPxKSqUeTNkgxx09Wdi6JWzOaVChQIF1mVss/GpqmFKfVc6MacmxoNEIwGJIE8onW/c1nVsho9eajwZKr7rMwjRLOpZNU3sRCK0vntJViZKhUv0Y+46HOF+lPuQZ2IC1xPaZsnUl5SU5sUk9TV7UiOAaQ0hGa3oeDhj8hUCjLYgnuV77FaYrzcmEp8xkW7aTkwg3N4GfZzD/2k7z139CiVDQRv7NTNIwQspodLMNACK9EnzvR+XYFzNT1pOA53jYSelz4LSUKKYt10y0lqrhyF/Vi5SrqbVMC9P/7y7fAudkbXU7946UT0+YTlHYfXV71T820+vFKMvVmVbCoyR7i+qOw9w7DDHbD+jgxEhHl6f+mLZxECLHKwPkx9dIt0LAKvJHMslbMBo/TJlw2wgYECLOaswpzV1KGtrPYF3xuJd76e+o5XsrKpsFfBXKqM3s1MZ78iXeM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd170c17-0e87-4d8d-4bfe-08dde934e1f5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 08:52:29.5643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jBQmcBJuTPOsc3mBnH4bhiyfiogMhQT3/hAU4i0hsVKk03tuT92KpyDQjeZi9qCSiSGDjtlgpVw6rH3BxPin0DyyvyHujlys6xsat6OtnO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1BDA8E55F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509010093
X-Proofpoint-GUID: ghBd4wiWlZ0uJDT06IuSNPADD8rrDRDo
X-Authority-Analysis: v=2.4 cv=I7xlRMgg c=1 sm=1 tr=0 ts=68b55ed1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=vYiJsjdQTt1lwdyizowA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX6P15j6BQnb19
 83Gqri8IHbBuQQhMa3861gbiG1f8KE+dSlyTnGi0LRFPbFoZ2wfZLcBmFwuPom+43uTieHW+1N2
 8YjeZUOwzU0w7mmwspUapSNlplVs53i44K+kuRXa5wGxdb4K+QYrLKgJ8iByoac0i0ViLxpGUxI
 +l/SZU+IhT7VobAXIhYHfmIpsSpohQO6p32RY53h7I3fi/7mCq10HlTqlFJ0GdcaSYPhEmTDQts
 wIXnaWvLD+y1Ahcks3A50LsPtzXDcUThjgFXtqAKtLLMz1LwDzt5OBYn1gRSRuzC4tvpuMTTuE2
 pxgTvaQY4a7fD8clF0iiUFmRdXjTtFZdVUzUZVkhTxUrJqBAx+rSSlo6LhTW3w/+Dlhzsu+FWPv
 J8GNO4XM
X-Proofpoint-ORIG-GUID: ghBd4wiWlZ0uJDT06IuSNPADD8rrDRDo

On Mon, Sep 01, 2025 at 10:01:16AM +0200, Max Kellermann wrote:
> On Mon, Sep 1, 2025 at 9:44 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Mon, Sep 01, 2025 at 08:12:12AM +0200, Max Kellermann wrote:
> > > For improved const-correctness.
> >
> > This is not an acceptable commit message, you need to explain what you're doing
> > here.
> >
> > I'm thinking that review will be the same for each...
> >
> > For instance, reference the fact you're starting with functions at the bottom of
> > the call graph,
>
> My 00/12 already describes that adding "const" to mm addresses the
> lowest level so higher levels (outside the scope of this patch set)
> are able to constify their APIs.

I actually found your cover letter lacking there also as reviewed.

It is simply not acceptable in the kernel to have a commit message like
this. If you want to argue, that's up to you, but your series won't be
merged.

So overall - we're fine with this kind of duplication even for a 'trivial'
series.

Describe why you're doing, it why these functions.

Something like 'In efforts to const-ify poitner parameters where
appropriate, we start by adjusting those which invoke no other function,
with the intent of working our way up gradually. Here we address functions
relating to shmem.'

etc.

As David said on the other thread, you'd use your energy more usefully
simply doing what's asked of you.

Review is a limited resource, please have some empathy for the human beings
behind the screen :)

>
> Other than that, there is exactly one dependency between the patches,
> and that is documented in the commit message of 06/12. The rest has no
> "bottom" or "top" that I could describe. All other patches are
> standalone.
>
> > and mention which functions you're changing.
>
> So you want to have a list of function names in the commit message?
> Maybe I'll write a Perl one-liner to extract that from the diff, but
> .... will that really be helpful? To me, it looks like noise in a
> patch set as trivial as this one.

By all means use a script to figure it out, but use full english sentences
to describe intent and what you're doing.

Thanks.

