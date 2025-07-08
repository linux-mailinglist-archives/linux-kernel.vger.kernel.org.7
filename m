Return-Path: <linux-kernel+bounces-721441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E91BAFC943
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4DB56228B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E8C2D8DA4;
	Tue,  8 Jul 2025 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="diCF1tfA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eqgM5Y8a"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CF320B1F4;
	Tue,  8 Jul 2025 11:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751973213; cv=fail; b=QJz00u59z/xZ3H3+KuJ+b0PdLBtBF83SBmrp3FjCer9usL6rO+7cbWfVlomGXI25KCapc6OvXwLEc4evqvqN4jXuQLacJIixSS+b+SZWF3Zo9o2lt9d3JTbGIqtVDqAwOqn0R4AxYeq2ObOBhdFbPYHDa1GHUFVL0XX7JvAi4L0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751973213; c=relaxed/simple;
	bh=jXX64aaefeTgv0/133rbFqziuw6bsrofi/kGO8LtMxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HKmjniTpcBd3TJ4qeIqOXbIE7X56uWU6AWVsHPecIeXIeupCv/6y2SY+x2h0OV+9MgqfJD7AvqHtkDdLqVJVao7bv6zKyggXMlAps+wObEpnoKjMKV/W9qd1tMJWT7YUj/tbicbrtkvmPiiLSc5EwsmxPMO6XrgIR/HSt1RJcKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=diCF1tfA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eqgM5Y8a; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5689CKhI023395;
	Tue, 8 Jul 2025 11:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=jXX64aaefeTgv0/133
	rbFqziuw6bsrofi/kGO8LtMxA=; b=diCF1tfAfFqhrR9fHgKJ2d+QBUgoiLWBSa
	5fEypcljxJYGpP2vlc4dRQPse6MhBmWhOMbHMS/N/Ebw92b4BoYc3UkCGcxANHnc
	gI91bRZqcAoqUqwjRHzKdfMlDZJnvp8OtylgcpWDgL3qNcEJVGfWOY1+myoXrIXC
	gSa054oZT+8Ymxq+YxhZQjEzwu2F+Xw4z8LIUiIMeY6cBzVyMNLajE9lqsKSnJAR
	QBvW06Df34HGKHIcCmzX+gCsPKdLN/kGFk8DpFFK+CmXZvWTHGvC+DILerWxECes
	YXLEjZwAWIOdDgAc8dUlasFQMk+aLeu/jFwHz61F85ZTrQqYdpdg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47s0g286b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 11:13:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56890M2T014017;
	Tue, 8 Jul 2025 11:13:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg9fmch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 11:13:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVxs0muteRLkznEqiK2o2JvdA8XNYPrsll2uzU5fHnBvmT8HAO7UuHT6+wQxgkJp6nuULM3zuVeTi9wsq6aBUg+LbznI8ezmhcaM1hNFIfiOZhd00qOl6z6VvI/Dz83vYeZZz4aXqcZ2h+iqCo3HQu0Q8Y65+MIOSumTq8QOb1PS3hWOSPvTJtnRbHQSiJ9tQBGr77sFeRPdGM+vjBtvfvef+ndK5LO7t5DoxQn2JJpzWso5vkgcsQnH+ZllX8MSo0+fiDktRyG6pjZ2uoQynnr9Yp7o8ZS3U1TPCxqk3Lxd344wW5rNHQq4vOVl0ePUCOG6Mm8IGqhnCuXB3y18xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXX64aaefeTgv0/133rbFqziuw6bsrofi/kGO8LtMxA=;
 b=YrZvhFd06BqY0eQVRZJwG4XmONIf/gKfgfUiVUEi703drTXoL8YA4r6b+AY2Ye6wRN5Svywma515d+J11SAPGHDzEoTCa+WQDR106ZxrIXOoRMQHkyz3sflFbf/MqA4yrs9wZOQsA5scplNEIdkuIXWye4uyvJkBau+ZroZHGT34KiJ6/ekTtXOFX+YQZWbK6cmDwe5Iy6jGIcyKdQcjIndDRR6kzvnApcgxlZQpXiMKyN9eCVeFQzgVJKWyJWW/wNBUvfUdWjiguTZJVtIN9VEqWgip6cjJ5XXc4Zkk05cAGxDRXjp9I0pduYCmcjPsksNsCK6JMgQ19nXgdILflQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXX64aaefeTgv0/133rbFqziuw6bsrofi/kGO8LtMxA=;
 b=eqgM5Y8aCj/sKdUNC0uhags+mhkaSuncPZXJGyJlMH316bZZKLQsjIxaohxeUbxcm79uCtnKTfaYIZFFboR5DIy6OQ2CC+P65TpXFb0n/CzLxIBi307aHvyhEpZm9u2RQFf0JNvqJeAj5g1ZgDkZsA288aVMKLcF8cZpJxxd8eY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB4517.namprd10.prod.outlook.com (2603:10b6:510:36::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 11:12:58 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 11:12:58 +0000
Date: Tue, 8 Jul 2025 12:12:56 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
        Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, rust-for-linux@vger.kernel.org,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [PATCH v11 0/4] support large align and nid in Rust allocators
Message-ID: <a7ebcd41-a07c-4946-be12-1e682bea25e2@lucifer.local>
References: <20250707164755.631374-1-vitaly.wool@konsulko.se>
 <824065ea-1f5c-4cd4-9917-4b7a91882af8@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <824065ea-1f5c-4cd4-9917-4b7a91882af8@lucifer.local>
X-ClientProxiedBy: LO6P265CA0009.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB4517:EE_
X-MS-Office365-Filtering-Correlation-Id: 10b1f330-6292-41b6-d73c-08ddbe106535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tEHpgJ/La6W+UL22bQte26cwU9RRprYoI9swjQoIn9+LN3zIghtF9w3sCNvr?=
 =?us-ascii?Q?81r8EX6TrazanOjhHXGvvHq3g1algO0Q497udHpQfwTxdq1MSbXhw5U/cXBz?=
 =?us-ascii?Q?//Bje61nDfOjU1G5nCuDTFYnHgGrjBEDGHgwM3ynlXF4jIR2fHe9nqmzu0rQ?=
 =?us-ascii?Q?mGP8t/SH+KYDvQfSUlsYtvuwoYCO83q1cWbkOOAfQKRoZNjQLIUuzhS4stY4?=
 =?us-ascii?Q?LuCvXOAarWrcpe5ReNAClHpcpH9DAph741W+toa/5hNUQIxMONOj7KKhQ3Ka?=
 =?us-ascii?Q?wsJbAUmKTvVXKP/stg1CcXomcWa+jlnpbxCo7zYH2rpEX8TaiOiurx+ZV9vl?=
 =?us-ascii?Q?WS23iOVoTmP6cp0GmEtGpbgzhYP0HZpWYZSCL5nmdUHvovpQNS7+wJ8azgYK?=
 =?us-ascii?Q?enO9jb9aZoVNTTzzvuytQx5cHyR7RxYpFqxEXjGzhYwVPuuME6+C07I6lNB0?=
 =?us-ascii?Q?r+sqZ5TpEYuS6X6wF3ZZVSbWKj00eSCezjK/+bCJ4K7RvphqcNNax6rppKlU?=
 =?us-ascii?Q?vDh2Irp6gXitdm0Lo8p495VLEZXJc8N+bX9OKyV+a0gMwWZi0JIwSf7iZusY?=
 =?us-ascii?Q?DQbvCuflkyKH00fMVWW7dIPX6PUUevK5xyRgFrS7nT9L3RY593tEJpnF2pjj?=
 =?us-ascii?Q?Z8Z6SkYoWSOzUzpfugtOTU4owGvqFPIsVED30CfUzHRisnI9gAlW83GzafAI?=
 =?us-ascii?Q?HnravIOcPUGZVM+3BKOpKn1kmlH6Z0PeGQEIFv1LuPUwJuWp8+CnNjD99om/?=
 =?us-ascii?Q?6YrMMoZDq/OVlvkdAD9VxLok5NJMS6B4GNdFAxawaIVEkyIUBT7uxJz4icXo?=
 =?us-ascii?Q?VpWdcrQlmGJYfpZfduKBtd2Bilu271noVvCUhmL8aFtEWAJ3LRXmZpWb5l+n?=
 =?us-ascii?Q?R0m1UG+tuU7Fvlbz4wAuBhS8ImUB66b1EIuBXh+EDIMnaKAX2sxX0d3JnkqG?=
 =?us-ascii?Q?+e5RjId8jmZhEFPxI4YLMfA70mMbLjnvd5+rjtVOMmquxM+9g613eGOB1iMQ?=
 =?us-ascii?Q?smWivX3eLjYOFuRbiec4pnj/ILszUkiGYsFIouQj2XqWanP+dJ9il8rdcskA?=
 =?us-ascii?Q?ClMRdH0M1i9N3Xjp3eXLvVcsNkSgoZn4klziPh5kF6KA1h3RTjFNcSxEvFEh?=
 =?us-ascii?Q?i1uvzvkAU3vlREtmxaffqOLPHAykdO/dDQd1P8kUzSCXx1v6LaZqOztuhWBH?=
 =?us-ascii?Q?Zm/ZGf3l+StDKv+Q1tuZWBPjYWGy7aWXgjnbxHMu1WqFRO8o7iN8lmfPL7VE?=
 =?us-ascii?Q?2y1IThh/4eCRiwAlSCladai4hOIRbfpa3TKqH+oPG83D3D0v4SZ7jMzRgfjA?=
 =?us-ascii?Q?ohPrIAm6+nDV8L0cPgP7SANwCXR8Nn3PFcJ06OPQda3ieAAgLey31gwC5Qxy?=
 =?us-ascii?Q?51aJzpkeodG2+yyu3D7u9CwmZauMexbvdXC5AqO4J0ibXhZtxNijguD0gbEA?=
 =?us-ascii?Q?lU/m28XcqHs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rpv/R9ChJP2UF1HIFOpwdgLzR3owMyheL7iR94jTbsvch3unzJHAiYN2Ufwp?=
 =?us-ascii?Q?v7UBJOR2s/JYENT7QtjgPSe6nGTsSKKesOk/TfXETPDsTq6bEl0oty9PVZy6?=
 =?us-ascii?Q?SsGbsc1TDQW4UEwFr3L1VoDLKVZytsTFGSRb562qPLvwBrQb49q9pxQETBdG?=
 =?us-ascii?Q?ZrymxaFVlUZaPdRawj+ixaI4zZumw7p+D1js3HpNkIwD+wwGTXHQZbDHB5A3?=
 =?us-ascii?Q?Chd0mZ9T9DIdb8p8YlOsI9x9rGGtu7TQeiV9MnHr8AGmW1rwKNpAQXX8fgRv?=
 =?us-ascii?Q?HbTUb9UP4hox4ybrIEKocMrOdMwYgO16qcnC/VXRVlNWKERWdIGat2ErCVX7?=
 =?us-ascii?Q?+U1JXfLZBEw4NLLM4qTFDwHkDXiUMwLZGoMVyji7EHBmAFeTGj5l08NNCkPG?=
 =?us-ascii?Q?FxFYRipPn+Vi3vJqrHJixSz7GD/p9CoOw2ldKmb+MppmF+T9Epqf0SWDBnzX?=
 =?us-ascii?Q?W4qGnB7Wl69o/H7h93MWWEdEuf2FWnXALFd31ivBZLRGoZpZgbbN2Dxr1X4e?=
 =?us-ascii?Q?tHAgT3dj16kVCad2Lw7fgNHqT0rcldZ95fvk28esBkCA8k3k1LuUc3STD8PZ?=
 =?us-ascii?Q?pS8hny2zdO7Wq50kIugc2HIZlmYc4XRgyMt5xrIX8SvtVFV9D4ZAzRMk94ws?=
 =?us-ascii?Q?ZPMT7lTxx01mBZT/CroEnJMfkZvReU+Z1Y/XB4xSL9HTGGkc8WzW3tfzTwDC?=
 =?us-ascii?Q?Oodhjb32YzOR69ql2LOdDj6IRxeD/0KPNnkSpfxopgzYNtfg3y5Z7ofTYlC7?=
 =?us-ascii?Q?48W/Y6kazvbVqsmCHSLybnjPXIzdj/cQXiI4FWxaLCcjo5ij5YradrT3jHd5?=
 =?us-ascii?Q?EZWp42j6QwmB8uJo+k53ar5KMq8Gjkn6RWBx8Rq5M1UBzeS6P3s8x7F9zdy6?=
 =?us-ascii?Q?u1ENqfLfUGwvtsbt8A4a12vT+JiLbc5BdGHDwjYQSeOOCRs8xZlXrGiJacrO?=
 =?us-ascii?Q?61giXJ/KZjkqslhShyw3Imbmmy7giogmjA7T/LiSCunzcWsE+v85rTRW/YVX?=
 =?us-ascii?Q?KjgUUuGLTS0v/p7B2r+7OnnM6U6dlub1kJ6b3+5JP/oqJr9+pKbzr9wXC2JG?=
 =?us-ascii?Q?Da2pD7T9jpIUObrHSs23GSjAES/cGPn8YuJSctLysTIMuNPx4xCu3SVo5V4U?=
 =?us-ascii?Q?5J1FNX3RbP12RfwLwWB4IfVUJ3FBk7x/4yg/RInMX51LEnv5f2mDVLKBSbIH?=
 =?us-ascii?Q?+g+MXURXhKILtuSG+YuxEAtb5EMyVQ6Wv/XD8qpTZTaQxp9yjdxZIPJFKvlh?=
 =?us-ascii?Q?CnWnZgJ23BquGtxCO15iO+VrYVROqjdX6O4SYsROq8MgoEuQIQV1A0X1kZTK?=
 =?us-ascii?Q?p3LC86AEmA2Xmo+c3QZhb3J4TNhLyXIubu+MnclovZRzJZnMwKwWSrDM8eZv?=
 =?us-ascii?Q?6Tl2dqtFGI0f4O4e+KW8jl0Jr0lMwCj/l5krblTfO4XPUO+txIhar1DE0zbi?=
 =?us-ascii?Q?5nA2Nx2rJdWbFo7M878QOUVXy4IgK3eVSFrL+j1hyUgU7JmXhycXpLy6q9Rp?=
 =?us-ascii?Q?3MHy4wTZDx6v7BuXF1FGLUPA5JFaldhoVCFdNPnqY3rVgQXOwoaW/emBpifj?=
 =?us-ascii?Q?3JOV58uCWqJ/izenDtesx6hE+TeJ+rmTwIPAPs5SeXvLFPVYadg0j/zRwJVE?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	52HdQGJ+LQLRTUK3k52hSIAYmyW5sz2LK+ueRWZXNumnXeRQ3XfTVt628M5CsftEw0IRWToiYBgYSNTPIeoi0R1hRSg/Mgz8NcH+YFu3fKx9BOYSG49Hhls1SoBAZY5rZ3DObCaqO0/cuidGZDffQmgic9VgJCW72LdDyj5kDipa6rrVew0BmvS0ynh0y+ebOwGCRpNEUC/IiQMk8vL0chLto1+S5bes1sWpGBthq01MqR0ViA8AYr/XhYPvlG7iIjeAuTuj5eSmDTIEYTphECPG2GMBeCITU3j/tkPgBpEg3TKcbRNCayHdeJ+V+NMFEVA8Ihd2LaFky7hooJsyV1XRmO/VosPEw45Lr0dVVViHwJPrPBjyXExo99QWnrEBzTNQfz2Vzww/3PpV+ePFqpydVkXxUqwxGBojhm82lXLAg0PD+BmSnylfF7Azh5ExWrW8UxAUW7jNF5Yt6S0U0vWXfi6PFa7vry8QkC/gq2pXOlMv1zrsoD8dTQhVwmUfI+leqNN2hBvWZ9ymg3wWX2s2TvG2AQFuY1J8AAPaGQxnyBaXgDeYmsjn7VA0JrVwZ1lILSqpsNlj7jRqxnAt6k4LN4bnPwz2WZu7AltJZj4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b1f330-6292-41b6-d73c-08ddbe106535
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 11:12:58.4241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b455ulnki65RkWwpTr9QMtgdtvrgXSsiV9Fg5mLtLK0HAOQQQUBUpgMjUX5yAbU3BL74nBBQmgluQWz2b5pW/LWVqqKWMIW6e+isALsDsvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4517
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=419 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507080093
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA5MiBTYWx0ZWRfX4oBAHkgTpV8l 9U5NLFE8fKYrCl0JzdhgRhajxm1vlliFMlnLqW/UP1bz9yOPGozJxd/NOyygTfucQvwoSidbdEw vRx8GRjzz1Ua5kZciIgJaBhtDvTHSnRRHzw/MVvchl+w/K7IckgIJyjNqVpQi6aSDssUh+jBWOA
 K1jFKx9zMBHO2LuLoKEKEo3eKTOtjmidtNHxjbWmHdh/g0bZb5DobzGJTa4dnfmIR+cDA+oARF+ xYbLtvsUDxKQwEDBtEuXRbZ/VZ1dmOp5+gW9DznMowNnewGhXv5GOGatsAq7DWxvZ2ezm2RRFo7 AzhUdz0vksk4BciXCRqAKZTEk0h289UjG4PV1uJwQouJVcIQ1iYJenWM3WUgbYmXOgQX9KZha4o
 oYfV3ei6reDHilKX1XN5/gLA8PFRagUXkHWFZ9tplyqmLoUcOEELHWu3GzTMQFyHRv6Eg6uf
X-Proofpoint-GUID: tPHo-bW6OzCjq-4NKpU6kMsYnPBNA1mj
X-Authority-Analysis: v=2.4 cv=eaQ9f6EH c=1 sm=1 tr=0 ts=686cfd4e b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=gNafa3-ibkkLSTXfxEUA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12058
X-Proofpoint-ORIG-GUID: tPHo-bW6OzCjq-4NKpU6kMsYnPBNA1mj

FYI I ran scripts/get_maintainers.pl on your series and there are 22 people you
should have cc'd and you cc'd 5.

While we'd all love to read all of linux-mm, for the majority of us that isn't
really practical so it's vital you follow correct kernel procedure here.

So I think you need to resend this with correct CC's at this point.

Thanks.

