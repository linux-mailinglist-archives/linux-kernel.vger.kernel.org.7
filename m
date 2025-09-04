Return-Path: <linux-kernel+bounces-801058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA008B43F5D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453DD481908
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28C931A563;
	Thu,  4 Sep 2025 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="cmdAZ5Kq"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3500D31A55E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996579; cv=fail; b=h7mpZmCbAbamMzPJvMds6N0jkHKubEQWcLm9UItDGsTv7kjpnikoodcnfLhFXQRiNDei2+63c+OAlI8rV8UkFdgU9WO6faK/xs+EWpAfeK9nuMuowDKxIKNyJh0EAsdLwmrLYqU1/uPk3IZZnc/h3ppmGFEkrTRzknLdrdWSPhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996579; c=relaxed/simple;
	bh=KVgTren5XkZti+xxy3kE2CYYuwoZoe4N2iOJK84sV2c=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=RrHkLEz3D20c0y+wrH+3BOCZ8jMb3WnCDoEZM+T1HueL1hcGqCUs0odI16PXjGWnOff5wbSXZyAEGxD2LKdXSD6LT4r2OUusEgyi9xr9sbOEtc9T0spBtkBR4oqlMs4BrifFefd75NW7WU69YdnJGmFYokNBxmNvd/BtE4r/KTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=cmdAZ5Kq; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58492Oip2472115
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 07:36:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=uSWteRBpuCWpKlufE57m
	dCuakySfq8pRAmiOy16IZEg=; b=cmdAZ5KqerUigPREKuFmY8GFiP9P8Ic108Yt
	ytvp0lclQUqzw8SirxF6HIO/2wyXw5SRhu6Lf6tO4u67smbThLsbfNHy3SQVrnP7
	xpLBaAuIbAj1n0M/BUQWnz7qu2nHafoEZVk5o43gx7qQjbWbw1qC7D/x9OKkIP/d
	1Pf1jd9DWLM79sA7SnmMoKsTRD8BVitBDdh+wJ5VaCwGTUNub4Lp58aydZ0b0ge9
	lrFQp1Fz13rul8uedp0Ti2dea5UadL/gU6sCL/2BNjR+8UC1+fJDJ4rx3yZNTR79
	OmLJARRCGydRKHYsP3qjaZSGNonPVbol4Hv1tlcTyH+o04xI3A==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48y7sb09us-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 07:36:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUeVlLLdWaIdPXlEUDBpsn7zwh7lVqmOOpEKYxtloSxm+0Ha8vgu7Z3n2se9dkGtCksASztu6aPciTAWWdvtI5zCgVdRWntoQTFI/jT48syhv+IBkuugNA9cRU8KZFWgRYkaCOtErteeyL2nkTVwpx1jaGAaT+5w1rxoP37aRgOp3BsFDex3D51YUWC0lV7GEZpEnEbecIvoDs6DujcD1hqZ1ZAdLFqOsgnSmWtfuh+wZJrZnk96AYt2pl9OrnxmEEwX+VCfT4ER8v2JE5XtTqMzXh8t6lX+dUxsVrJUBoRVFVJr8gHUdn/VhcBU8m7ErBaVDw8V064i+k6TpIiK7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSWteRBpuCWpKlufE57mdCuakySfq8pRAmiOy16IZEg=;
 b=gfz5uVH0uPsiOU9KZURNmAq1gAlrKwPMjp1BLiMwck7rTh/QBsMOjkTNvvXawCUPE9h1A43B2o5snJapLnuwX+vOyV5esAwniGq0A31OxCn9sr+Se1NmQIQNdyDcXR7i7bgDd4X9zEGpk0i3ZyCPJhVblYCXKbtsUPETemFw9Xt7tRIrEWFrHRJfujzsEWuO9d31pyke2qTCDZgsq23EQ565MfTP7AHQxF/xSAQOJXYqZPqHHcZm89jTVekh5Wt08XK/4biV7kRU6BM9fY+S35tfLMZhhPuiBNpj9oeoQiUnJDgO9QAUxHccPNbJKNgInwgnti11Pi5AX51pNWsyZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS7PR11MB8806.namprd11.prod.outlook.com (2603:10b6:8:253::19)
 by PH7PR11MB7431.namprd11.prod.outlook.com (2603:10b6:510:273::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 14:36:07 +0000
Received: from DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::fd19:2442:ba3c:50c8]) by DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::fd19:2442:ba3c:50c8%7]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 14:36:06 +0000
Message-ID: <82fed98e-a4ee-45e1-a4ae-e9fc303a4f67@windriver.com>
Date: Thu, 4 Sep 2025 08:34:23 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: LKML <linux-kernel@vger.kernel.org>
From: Chris Friesen <chris.friesen@windriver.com>
Subject: sched/fair: documentation on fair server sysfs interface?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0889.namprd03.prod.outlook.com
 (2603:10b6:408:13c::24) To DS7PR11MB8806.namprd11.prod.outlook.com
 (2603:10b6:8:253::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB8806:EE_|PH7PR11MB7431:EE_
X-MS-Office365-Filtering-Correlation-Id: 98ce100f-5626-4cff-be40-08ddebc06183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnpraUpRaUxDRjNaSDZnbGl2RXVwT1B1NU5LZy94MS9qOTNUUUo0UkRZMGVK?=
 =?utf-8?B?RjA3OTJBTDkwbkxMR0gycmcrZGJHRFM0UzIxb05NaUV3bmJhTTJXcVNDc0Ex?=
 =?utf-8?B?MWJHMXpRR1RiNVpkM002RURWSzY1bXlKZkR2amxZMWd6YXpWRzBIdmtyb2tl?=
 =?utf-8?B?MTZQZmd4TWdxbFQzNVdjZkZlVFFJRVY4ZFNIRkVVUjZFdHhLVWM5Q0VIWS9D?=
 =?utf-8?B?bmJMbzRkSytiT2t2UFUvRVN4MTBKbm9jVTNKYW5TK0ViZFA0KzVEQnByZEpQ?=
 =?utf-8?B?Y0g2aUVaK2tUWityaEtxclNUMnhzNGZybGxtSW4ySHRPV1hlV0dGelN6aTlW?=
 =?utf-8?B?T2cvSGpoM09VdWZLa1NUZGFOWmNLeHBlUXFpOXAyZ3dXemQvRnFpZkpHNUs5?=
 =?utf-8?B?dCt2UUJTR1hqbE9Ib2d4WDgxWkRDaC9BMzhUWTY1TEhUcytMRDdvbENSS2VG?=
 =?utf-8?B?USs4VTl5bUoxRk5QRjVsaWFXYUlNZmdEMHN4elFQcW9YZkFLZGM5TWUyVnBv?=
 =?utf-8?B?RG9lRi9EdThZM1hwSkd2RkdxSVI3SWY4MERaNDJmSXF0ell1WFlsVDdQNnNJ?=
 =?utf-8?B?em53WHliYWo5OWtwUURoL3ozMTJFbHI2QzhjUWszeldsTWRzZmZtYXgwdnZk?=
 =?utf-8?B?RUFjRW04Rysybjh2bFIrRExXVGlWRjZ5YjBaOFM0dzYrYi9BRVMwb3dwVlpC?=
 =?utf-8?B?aG01bkl2Q0hTYUZxOXhQYXpiNjlBU21HQkxnS2tVNDYybjVYOWU4OWxPRys3?=
 =?utf-8?B?bVBqTTVQVkVGNlB6ckZLS1NFbmV3SFB0VlRMUjdGazMzQ2pzL3ZPYWpaUWxr?=
 =?utf-8?B?d2lRSzBEL1EyNENFdktYK2RCQXJOSWhtRm1ybXR3V1dwMW5NQlpCa1Z6Qlh1?=
 =?utf-8?B?ZWg2cVpWMk1ZWEcxOHZFYm5OQ250dTM0KzBsSHRkNWFTKzRVVnowSVVleEFW?=
 =?utf-8?B?Q0U2ditUYjQyZWY5VENjTXJtUmNtVFlnSGgvVk1wQTZ6cXNNdWVOek53UnFh?=
 =?utf-8?B?SjRDelhXUytnNFIwVFoxRHExNElKWjRrZnRiVmd6U2JqNk1FMkV3ZTFUZHhO?=
 =?utf-8?B?RHZWcGFqL0ZheVJTMTFJYjRCcmpvSTkrYmlqQ3ZJRVVVa0luVWhTeENTWUtI?=
 =?utf-8?B?UlRaL0hWWGV2RHI1ZlJPTE54MVBhbzRaem8xd3lxaU9wYWRZeDQ3NTdVcEpF?=
 =?utf-8?B?djJScnZLckFBWTFDQ0tqQk9vbkhmZzJLTFRTaHJVajZ3NUdIVmZCd3FBc3BL?=
 =?utf-8?B?OCtnWVJjWEVybjBaNEg0aGxHOU00UUwzVEFiQ2doenI3aXp1dmMxK0RONDFa?=
 =?utf-8?B?bUgwTGpzQlBnNmVHN1R6QnpZem02RFUrY2JYb29YUzAyMGFUSWVLZllRV1I4?=
 =?utf-8?B?dnp4aVVST1dqWDdqK2UvNG5uaU56M0dGazJQMVRZaFFCMzFWMncwMTBBMDBM?=
 =?utf-8?B?bFhYWE5nVFZiQklzb0xkUWtGL2IxS0MyRmdqWGFXYnh3WGFDUWkxT1pEaGZV?=
 =?utf-8?B?a2ZwNzZ6L0dJMGN5WTRRQ2tIVE1Jb1V4YUJ3TUptaWEzeDZtbUh3V1BLOFpD?=
 =?utf-8?B?aW90UnpjYWdiR3RlL0lTNlpDemFoalBiMHlIbzJDeldtWlNxY2N4K1AxbklZ?=
 =?utf-8?B?blZnaXNpSWg4MUJZc0JXQUozNnUydVRHems5TVhnQUptaktwMDBjYjRjdTNS?=
 =?utf-8?B?Zk40Ni9zcXBEZGpRR2hUcjMwYWY2c2VDdWpLKzMwWXAvZjBVS3h6Ty9hR0sv?=
 =?utf-8?B?TEpzb0xSZUUvWmNIY1psYUVhS2NIYWhzQ1EyWTBscFJ5YWgreDg4NXV4M3Vp?=
 =?utf-8?B?UlZmczhxNDZRc0ZrOFNXWURjV3JRcS9zV0ozdE5xZ2UxMjdDQ0U2bkRQU0ty?=
 =?utf-8?B?dXkvUUQvY1IxWnZRNjJ3N0dvcHRUeHpObmh6ZlBJN2ZzTjBrcnNrTUFhcnJY?=
 =?utf-8?Q?M7+4WrfrcQM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB8806.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHhOVTBGSnVVejFTekp2QzZSSFRodnEvRzhMcVFIc2xwQ3VjaVZINFcxTmZW?=
 =?utf-8?B?UExyMUJtMlpWZGRyaytwZlhncXE0ck1qY2lFN1FuSHpZTGo5aW92dzE0azZX?=
 =?utf-8?B?RXgzdVdNSGJGVjRtNDlUdU9xWk91SjNCeXZXOGo2Y0hwS2pLdnlqY2JlN2xq?=
 =?utf-8?B?WVB4NWxmSWdOaTAxNStOdGpPU3hPSHB0Uml1TjZSaVUrS1BUWXcrS2pRTkFu?=
 =?utf-8?B?OWt6SHNhWXkwbkxINUVnS001Y2ZONEZoKzVocytQeWpFWUFibklFL1htQVov?=
 =?utf-8?B?K0VYenFIZkVSK0dGK0pGcndWSnNjNGo2YVVBVGw4bUtJdDl5NlJkY0V5S3RO?=
 =?utf-8?B?MGRJUmc3ZFBFRzhQelFNdXJzR2d0b3R4NWdyWEF0c0NEcUlQSVNCQWFIUmN2?=
 =?utf-8?B?RitoemRqTC9vWnhBcUNTRktvWXhzTm82N3h0cWpsTGROd1VHREtVVWJGamxV?=
 =?utf-8?B?ekx2S0tWclVXNW1WVmR5T3BQTGRhb1hMbFNEaVZoZVVqdDlpa2t1WkdxRWMr?=
 =?utf-8?B?SVlUVDJuNTJnOFdzaDRQN2ZsYjdIcllFTnVsS2haVGNZbWJkNXNBSGdrT3o4?=
 =?utf-8?B?NmJqeUJEaTJ5WmpqNjhHNlJ1YU1udlZZNzE2YjFLdUZtWklVeE5PcEpVR2dz?=
 =?utf-8?B?V0dYc1lNTkU3MlBUOER2U3FJcUN2d0tzeG80ck83QnpwUU4xZWFzcTUxU3Bw?=
 =?utf-8?B?S09qYjlwQkZhZHNDaXNNcEtnN1MvK05SMk5lUzRZaW9uK0dDRnc2MGJuNUlz?=
 =?utf-8?B?TGRFcFJKZys5YjFsMDFaejh1eVFRanp3M2d4b1JlM1lGblBuMU51LzROYWMz?=
 =?utf-8?B?YmNYckJxWWpqQVgzSXY2Mjl3U054a2N3dU53bHV6blJpUmZ3WkJGVW93cW5N?=
 =?utf-8?B?MnRUNXNxQUxhRi8wWXZ4MWNyZXc2VVcrd25sUllQcERKemQxcUxJbWp6bkti?=
 =?utf-8?B?eGpCYjlhckxkUHhnd2EwQkljYjlKOHRua3pIMTBwYzRYR3czUEhYMUJhQlJT?=
 =?utf-8?B?UURoSnRaL2wxeVMrSXFobzVBTE11dVZGaWNVRndSc0IwSkx1dTVxdWF0S2xt?=
 =?utf-8?B?UzB4L0VlTnk5dDJaME5hTkIxWVduMXZrc3JJZDJTWk4vNmVOYjRjSmZnemNL?=
 =?utf-8?B?MWczK2pjYTdxYjloYXlXSUh1aU5VWWJTVzdaTEwxNzFvcnJEZTBtQ1o1R0ZS?=
 =?utf-8?B?V2RNeGFVWGVQTk1EV3h0c2ZHU0NJMTBtbmllWjZtOEJKR1VKNXlTZk03a3hv?=
 =?utf-8?B?YXh0L2p0QXdaUS91OW1RTEp4NEd5V09QTFNETjFuM2VDb002SFQwNko5UXZC?=
 =?utf-8?B?RFFpMVoyQXRuM3luQjBnOVBXVUordzVlMnFaM2xBdlk4OTMwQ3MyR25Ma0sx?=
 =?utf-8?B?VVlsS0dFZXRFVGRxUW1UZHRvekVsV0F2WVcyVkJraXg5TWw2ZkZoVDJQNi9h?=
 =?utf-8?B?ZzBBdEg3ZjBLdnovc2JXS3ovV1pkODNTa0RNVm9Wa3NpanZZYWRrTmxib2ZL?=
 =?utf-8?B?RzBoMlBsR1c3KzMvWmlIdnRodytsSUhFUUVxT3RlZFIraUtjOXoyNUpTM0NH?=
 =?utf-8?B?Nm5UcEt1UnNRdE9jMERTOUpncUZ0S2YwOENyRE93a0FkaTlMSjVmOVl4dFFR?=
 =?utf-8?B?OGVlcExNeTYwYU81SDNBczlJb1c5ai9QdEg5eDkyV09OZ2xEU3grUEtrazRn?=
 =?utf-8?B?QjBCRGFCNVZTQnR5bmpWMDVvOGp5NTZybCticmJqbFdINFJRZGM4eUN6Mkdx?=
 =?utf-8?B?WG16TVdrNXo3cjJLWU5YM3k0LzFNUjBUY0h4T3pMSXg3RWcreTE5NExNWmZC?=
 =?utf-8?B?WkU3alBnYXR3dXRDZjdWU0tLdWczNzRaZUJ1Q09JSG8vdlJySDhWSkJLSDMw?=
 =?utf-8?B?azQyL0FrTldUYkRNUUVNeHhad0xrQ0cwYlB2dHNBMlA4VmhqVTZ2R1VFanF1?=
 =?utf-8?B?VG1JcTFUaUJoV2hHbk11Z0JZSW1LdDkvcWdoV2orUWhibnF4bnUyM2o3VlhD?=
 =?utf-8?B?azdjRE5paXpEd3ZzZ25OMitHUHpVUTFLdXA0QTNiNFhCZXdtQnV5WWhTWWw2?=
 =?utf-8?B?VnRjeS80MnhBSzdTSHhZeWhxK1l1QWRjVGNTN3A2eG9nai8vcVlmWVF0aUpY?=
 =?utf-8?B?NTZtbkJoVExlNHpKTmdtb3ZxZEJrWDNUUGRZcTd0NEJLVitJYXJhRWRUem1H?=
 =?utf-8?B?QlE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ce100f-5626-4cff-be40-08ddebc06183
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB8806.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:36:06.2057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMZdXGwRoDTYnCbwij7GCu+I1eVm4sXozQ9vuU1ecE+r6m7dOoy5LwVw6riL5xBGA3wgflGOM2hV4cfxYS0R23apSjl3RGVm8Vg8Oqpuf4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7431
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE0NCBTYWx0ZWRfX/4WjlgE4bm3R
 5j6zzKfUcHOXPyjyuUyOHNHnMy2Jp9IjvhBX/kBQnA9E81A4D3QpabEFSmlr0I0tAQPooCM74mo
 lPSv6DtrO1VlJXz029x2LUUJFJgzBzsjs3Vid7mEDKu+Vd9csAC7sNXnOcnWssXs3EgP430wh50
 pW0kHInabsaklrC8fh+9RooNMEcKegmK/cszf7QR7C/bJdydkwVI3QPIcMsZiaz10YM5VHMnFKr
 qd8VnrR+hP4uy419PdLSpzp5its2mmct/u4qk18VCbCUEId5ejYVB9JBjMdpgHwVWSJNYGMrNbC
 y0kpiwyPeGUS93ll0DqNhQdc8v2SF/xebPTMYygvK9AgJxQU4e9RdGRO/MP618=
X-Proofpoint-GUID: hI0npa7j8L7EMaAnBytvrNR2bOPC9JrL
X-Authority-Analysis: v=2.4 cv=M5BNKzws c=1 sm=1 tr=0 ts=68b9a3d9 cx=c_pps
 a=hFyXiFHt1z/RcV9jVS6qVQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=Z2n35bXOAqdSw-H3LtUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: hI0npa7j8L7EMaAnBytvrNR2bOPC9JrL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1011 adultscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun

Hi,

I'm not subscribed, please CC me on replies.

Is there any documentation available on how 
/sys/kernel/debug/sched/fair_server/cpuX/period and 
/sys/kernel/debug/sched/fair_server/cpuX/runtime are expected to be used 
and what behaviour should result?

I'm especially curious about the interactions with SCHED_FIFO and 
SCHED_DEADLINE tasks.

I had been using RT throttling to protect "regular" tasks from 
SCHED_FIFO tasks trying to hog the entire CPU, and it seems that doesn't 
work the same in 6.12.

What is the recommended way in 6.12 to have a realtime task that is 
effectively a CPU hog, and non-realtime tasks that sometimes need to 
run.   I'd like the realtime task to have as much CPU as possible, but 
not be able to totally starve out the non-realtime task.

Thanks,
Chris

