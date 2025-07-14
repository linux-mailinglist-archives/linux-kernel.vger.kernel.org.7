Return-Path: <linux-kernel+bounces-730439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B012B0448F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5803BB5A4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CCD25DD0B;
	Mon, 14 Jul 2025 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kKZ7WnM/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VKkrfcSh"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7716B1C9DE5
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507620; cv=fail; b=jcP1UJu/bf9hcluWRO9Pb7rD+bOKwboaGbvNHGWgXERTRh69jO2/1LfIxVZQvn/0P4aDU0s/NOeX6Kf8K+/3ZyncUDJKxwYJl2UXHiKkwcELAhKMWH8YL9XLqUecdl0vYRF0vI5HjXEOBWPsACSk/f/BMtv0uTjhyLNLYPFiPKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507620; c=relaxed/simple;
	bh=PJU4nl8eCUJpwpdMSQZzRbfTmHOms1bY4R/ayaRSZ4w=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=okFZhVGeaum3O7X/EB0IhtMatdgwkBwz5JXmT29xvE/iB3f1lSc204nHMhrxLxlSk3frDhPHux86xdCQE+wIJ4oC0QBAqGgUY/Uekg/WrddPMkPXy9C1F1BYpaDyAel6yDI/fvNVcL1jALvCxVHJBfInU0Q0wpP5ljPhk9M7sVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kKZ7WnM/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VKkrfcSh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z3BP004530;
	Mon, 14 Jul 2025 15:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=yrifCYK7apBqqCJrDY
	GlhTW9guFYB4OJu4zwaqyIEqQ=; b=kKZ7WnM/llyPjkMF5doVHOS5LaCyaMeLC+
	ALGgS5DKEB0qK7DTGgdsG6Sl1usapn8W2k4AN3E4TE7KBaSS2bj76Fms1BCBiKmH
	pGtWNZHjKRGlkupPyke4/TuQ5MHcapJLtl9pDV+rV/GluLwrTDop4CAT1qkv/etK
	gvDNXM83thtXicr+a0kJ/Ey8OPb+jtbIWicesyVzvXTXDmXGSxMBDIOqhKr4E17x
	plpTvfeLgx1WJ/ZW4mjGE07MZG2pvJwP4YWIK22mFL/89KHS/204yHRq4iELQCPs
	pRKw2bkEpxNmgioDvYcJDW8T71V38kzNq1MoPMMcYmdFt/kBfzCQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx7vpvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:40:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EF5vmQ039729;
	Mon, 14 Jul 2025 15:40:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58p8gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:40:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVDHtnWVXnFd7bpaEb2qKbWdjlrnb/AaWcaAg1YG06euOLn7hskelnoKYr93zyC8XLaafBQgQ24vGGSIvPcZSGNk9FqfR0Qv5rE52rp5rq/vofwWod8uxEwDD0Ay80DdP/HA27BeV0bShgq/CB0sjRRgdFUF0F3oYwfSW+dKlEo6A74MIEkZFuGYRUR7Y3JvQHgiz2+l9s+HUG4oZL4uqS+qG0tZS1x9oCCp9sLV3owpug9CVOXSMcx7lcNCMPOANYIhQ1igJf1zkEdbYZTXZHiZJAMnDbKuD5Cy/AzHGhfF1hZfPjqi8cQXVJwrjMBJmbZ7E9fy5G3VoFCd6fs1Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrifCYK7apBqqCJrDYGlhTW9guFYB4OJu4zwaqyIEqQ=;
 b=vlZXnuxOonm35qKd5Rmi75SM9b7k6xN0T7iMltbG02RRdvA0Y+TUMmDOXwJG7xMWy+P9Qqqfc8xdDOxEHNQTkjjtINeiXDxPvrqpVRXRFVge0d2gZN34hVOmo47O2Jf9kRh14WuljYnZPqhJ/+2RQ6iU75nXLR7Rt1KU6pt56knNyAJFERuFuiWAhBdqAPwcm1erB0xdrCqLiqGTXfi4InuzzNPJA9oGcbPIpeS8zVgw6vt1+Se/UiwqcnnogmLRVAQmNzIXk3CrioQLUcfYSaOUpUehlvNU9NglM6DeH4wDOi6NmuuFiFN6XTkwQ+/c/724SsLblLczLeZy0SSeGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrifCYK7apBqqCJrDYGlhTW9guFYB4OJu4zwaqyIEqQ=;
 b=VKkrfcShTIFmuuf8gWVqzTjpA4rOsmAJwjvy13hy1Rm1Qw/sf7FEaPQrNwCcydcF9n51idkvjrvenZVJ52KNpHtmukpQFigyhAWlG/BgyrLQpHVqJ0z1f07W6666mM44N71O9qWULFhgRJcdHkOE030Gz2tySoAukaqEFsphGMY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB4597.namprd10.prod.outlook.com (2603:10b6:510:43::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 15:40:02 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 15:40:02 +0000
Date: Mon, 14 Jul 2025 16:40:00 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH 4/5] mm/mseal: separate out and simplify VMA gap check
Message-ID: <bb2ece09-fa16-4f4c-ad29-bf8de847411a@lucifer.local>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <f010ec1ce65f35dbe1fbd82ce002ea833a7128f3.1752497324.git.lorenzo.stoakes@oracle.com>
 <mmqwb7m76ty6gmazw7db35rfow5vq66a72qa7rwjhnkh7o3j6t@2bk55s6jqb5f>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mmqwb7m76ty6gmazw7db35rfow5vq66a72qa7rwjhnkh7o3j6t@2bk55s6jqb5f>
X-ClientProxiedBy: LO4P123CA0600.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB4597:EE_
X-MS-Office365-Filtering-Correlation-Id: 3acda384-5cd3-47a0-51dd-08ddc2ecb2a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DojZpBGDPVe809aE0977GA26vmUmtKUR5gwY74LduEs8qfgaMvFGdek4g5xY?=
 =?us-ascii?Q?0JXlEz10i9pmclC2TPZQKK2sbyQDg2uKzSe8JC6/NYqFn38qD3gx+YA1UWFG?=
 =?us-ascii?Q?9vTlniuF0N/6O35PhrEaGi5Oqju/eJv/WyVbJqQ8gsO+dlapFcMdRU3fJJYT?=
 =?us-ascii?Q?lEQg1T4kh7Xrb6PaZsZ0im1g5gPzA7fIyL4yWDe0dxchWJdAfxRcrBBW3/mw?=
 =?us-ascii?Q?73lidl5YoiqaeulAsi5UgExMCI0eFphb866rh8E/GOQPDso2z7W8OJVaFpKN?=
 =?us-ascii?Q?QCXilj97A1JKyv40JI6kpS48jFU85EJ2JHRc5W+jzqbcfjFh2rbZMU7yscNZ?=
 =?us-ascii?Q?/bhIz7Q/ZOLH9VHoqGTd+qSc70TOGB3R/GGAh1ZPlL3wty43Q5QxTFjKJ1zy?=
 =?us-ascii?Q?w8OjoG+js0zi9oSfzX4IIRKv/gOeKf+iSL0sm/w0W2VeZCXZJJrFsMJQ1j1e?=
 =?us-ascii?Q?UJWA47v0509cR04Onxi/tUYBdKSyDkyKamF0Uk7dZ1lLCiyFS6ZIV996xsJK?=
 =?us-ascii?Q?BYTwy1ttKkMW9fFStWEGox3j502vifhTbRe8wGCdt0Y3oKmtxMm4hxdvGiXD?=
 =?us-ascii?Q?kRNfaujC42Digazqh5lso6GFHgMDh56DZf/4LP2EiyCNd17J1o5L22lZJXqe?=
 =?us-ascii?Q?BHOUxgGhDnIjc8zJhxGxLPy+MDPPo7hIca1iBcbXnzZzm0DDSsvH9pY1ONA2?=
 =?us-ascii?Q?KhrN6bO9lcplfxz+K8njNR13iAg+HOWxA0BL6me2E1wVPHdQQr/6OhGr7hL5?=
 =?us-ascii?Q?xCja1JfmcWROxx9JC8ppwckI9aAibWbL7w4QL7izSbz/dohyOORh+jyvmuOt?=
 =?us-ascii?Q?4sbvl1CYs5ysRrNWbysnRFv9ubyJLwVN9Hy6m8PGsgBynkG5Vx0v1h1HVVdi?=
 =?us-ascii?Q?FeiVpqtgz/Tx/puDD0Eao5qklxfaWzfUTlf/TLRAisZmDW8iwqcZV/4OW1qX?=
 =?us-ascii?Q?IwWIWPG/RUtJh03tijYhOYc2+vDLWyNFZk7hQ7c/QZqzf7+hw5BF+4f3NU7K?=
 =?us-ascii?Q?8ebjMTO/P6dml8fFb10i+mSWRj+sAp3yTzcmulHUize/FUxi2yfnrjkP39+I?=
 =?us-ascii?Q?Ty1zxt8EDe44M8QWgKh1NCgiuD7lN7frKn3iq+Su2Z4NSE4cw24dR0HRtWcd?=
 =?us-ascii?Q?3XuEHXujTuPQbTh44FKe3htx/WXoHp6GEWHCVut9iXQ8dCNAaioRqghZ7hAM?=
 =?us-ascii?Q?XUwJgy3xedorbYcAll8fw5YXREiawUinAJEHqPkyEKpVsYqj+AvAiNrDMUtO?=
 =?us-ascii?Q?tu37JUIONM0uFTt8N2t+BvvzIubmMW7Zsqqpai+uv5h6wZ3IFRY+6pP9QglQ?=
 =?us-ascii?Q?TX4DKM5nQmiojoZU+xb89qHsUZhM33qGoEZDsEo6LB8cQgFtL4/LE4jUZq8j?=
 =?us-ascii?Q?ApCvv2FCfaKfJIduN/VCr0E8FejJQYRnBTU3aMNeSaCc8aSM4mSLkoOm8ogn?=
 =?us-ascii?Q?JxDXj9y3d4k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kD/PAOQ6gCPIXv26G+aY2F/C7E2HKjo8LMDjrZSANWpJ7EQXhE6i5jdrFmnl?=
 =?us-ascii?Q?tu1edAfcycT4QY8u0lMG8tUMJ6u5SbXLbNPuUHTWAraj75cgDJ2X8inSDTln?=
 =?us-ascii?Q?R8Vm4ie7h+f9MUsoXvN1kkVnGOmGKFqa8SIhv+OgMoq4WxVPC1bT11pvYKmN?=
 =?us-ascii?Q?78apV64x3v7DSzu4sd23piSExgBRTYX4MbCZ2SJGqGY/V5+6MiQ+OvVH6Uu5?=
 =?us-ascii?Q?5If8ff7Qk7Eyj6Ik6S9U1o/QarpFSAUE5PYc94m2TYJrvPneapgmPKO1SNzl?=
 =?us-ascii?Q?V9UskLKR4Lkf6Ip9HIHLQ0ygvc2UJ2nKdlYMtq8DCRya2bxgM1mxzrMFw1li?=
 =?us-ascii?Q?MIY2S1QpmooWLTHln4u+gnEUrlx1bS21pAkDErOjhtewztvXZeHlAomQVUQS?=
 =?us-ascii?Q?bM4SiQWN/uPjIbqljm6ZbLVuwWO/Xrj1FpCyLaLFl41K3KW08UjnyGu6HMSJ?=
 =?us-ascii?Q?WO6P8Uvs4FOsQt53fZcgfduRINsSkrZS/HMhcYUg+b1AF/lg43LGEDLB3asK?=
 =?us-ascii?Q?X6vNPytGlGNElemP2gJccRdCGA0dVYkY+sWSwpOSky5Vj3JaYcIsFWJxRWGD?=
 =?us-ascii?Q?r6ELaSxvrbUgdvH8wlBG6Zd9o7quIQE8sC70pf2mxF2T1FP8fc6m0dryeMwI?=
 =?us-ascii?Q?AC7U42oFMU+4p57ChA+4D2nw5UGVfZBWTCX4PGSPqqSUjNWQpx/7VUXHvQSK?=
 =?us-ascii?Q?dBZs0BlbjEjK2joiKfkIMgWSBr+0RG5Ve7HaxRcLV0QO4pJZTJVGOLsGnQjQ?=
 =?us-ascii?Q?69CQ21F8cPq35JuMtVgNLWiE4MOXvkj3CDqD6rGB8w2J3RjrkXLswrAc9kNw?=
 =?us-ascii?Q?uL/h8W5vhsGZfAhc/YZbU69Fr4HZJ9F4/VxoNZTVxnyo6uKFtety/R1DUkL+?=
 =?us-ascii?Q?/RcOB8TfWh68fb1PYa1JYRxbsanfo7y1StEYVhHJAfQPkrNMIUKbmJRfAG8d?=
 =?us-ascii?Q?POVwzfTI6e8a+qRiEQnfaQ1x0ksaDMwkfNnrHuVtrlu6kcmeE0gkkzIAyPSJ?=
 =?us-ascii?Q?WrtRMmGAYk1k9nPne1ynvedEtTjisTrkqDrI2/y65Lipf/4AIXIT/goZAW06?=
 =?us-ascii?Q?zYUuJg1jnel6vVLiR8P0CcW/f/QZ94ZljwT5wEG7qojwz9JDX/m5Su1gnjyF?=
 =?us-ascii?Q?CCrj7iRfJIT/o5DaneiUN4XTX1743LBWv8/CtdD4QR7AIRKcslCQCBhBv/gL?=
 =?us-ascii?Q?chX4xNzntHmT3hsSZ3WYwtfobPidwUBWyhK4tUijUHId4rXez64k2RUCQhcn?=
 =?us-ascii?Q?UvH6d+vMgC+E9EX0CIVR3mCR+gOUIzfhdMSVnulry9lImWbpIJyOprwTn8IE?=
 =?us-ascii?Q?dV+W7vKYUe3M2A+Damsfs+ReDGDAx+zbq17262+au3WL3N7vIzznFT71mMnb?=
 =?us-ascii?Q?gpi7yX1RPb/mEuUy3vsJ42JNWSPXEwl2afuXjZa8Se5bKbx8n2+hhhks9G1u?=
 =?us-ascii?Q?cfLFqYeiM1geAgdBk2Q/Kr7ItyH6w5cXEQg/ReCqXqfcvvIa3ZhXnFTXfK+A?=
 =?us-ascii?Q?+VrZbfMw0UuVi1Z1AjK1GXkK+912BB2LcI9T38si3TAOZi0AH2LCvtv858US?=
 =?us-ascii?Q?s0CcEqi+LWa4QfEvHL3W/7faIGZxmn6l7T5YvdD6fWkufwrvPnyi/GgeYnRD?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9p1rhIbmv+Kvb9yzkEfLwJQRAVi2OtD0P2PWfIfPrMINrQRSQ7xlASCzwehzN8JbD359jvO9hrFAMnCt4p0OIv/rupuSNM4K27pfdWMKk5QYpCnqJzpD+5DabOK+WWD4EmE7hAGAPt0yoGvJ32H7YCxxBilvxhBUqdkSyLajV1aafL05UUmqNGwgyEP4RGmCxUGsHN4Y5K/fPLJNgyMl7fP2RQRknHQgkTk1QGLClk+rIWJtbLHe1bUCZdCIpnr6bDFOGN2uMyAwiW0uwbigPrO++DAqI+tC8hmEOGXuwf/DNE8FUqD7dv5m9MwqLVxxwymTPOaoNi8bwb4G49ckEz8W+D6Gp5czjJBM82FhF5OkynicGjOiZCkUGIWsiLMJnuZ2/9ZIqIBf+fWmcc+JoJ6x7y0t4bwBMJI5fIIunY63/l8pPFB60WyI7q0J2lZit1VlRRriyC0a0/oN/2JbkWV/qIrtTkksbvdhLQQQfa26UaQk7b53VVUe3OEZxR4PPC3Q2J0MNuuNzxRFwQ7Uhxnz8PHh4uFGA47EaHlVzkuvG+B7EuWOd+thHuZGsHKPXGLnd4L5oFzALW2FH0nxwvj4VSEj1VhA6Vf5Cm9q1Cc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3acda384-5cd3-47a0-51dd-08ddc2ecb2a3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:40:02.2231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cp32x7rFziIUIAf4mHNfFu1Fy8ufhpgrddoVEE3m6DVGe1FOUInVHjrETnP111Mt4KPFePPA7Qkg2GuVLS6rQjtoQbGD2u4GrWcdb6xkErQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4597
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140094
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=687524d5 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=BGuz10lNKG4oRBaA8e4A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: 4_uJvK23G1ThLTtG3gG5LUd4MaV9dI0-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5MyBTYWx0ZWRfX9k/75pxJ6+Cc H1eTXr96SJya4A6fQqTLiDJ3L7xDBHcig79lq3/qFx4CoVhYLRUXWQpLyuDMN5VZ2Kdo7wFFUhG RCNpLpIw651kid2VgVWBmhU+v0hvuUYEFHAEet1NEneWnA37j2quywCwGk4oGEtAK1v1RpnLXMW
 H1WfSRnbeEITDWG6i+zhKwcstFXZqQxyXOfwWrIKBZkJeZ0Kv/rJtnsLGYL4QchVJXKnRskNmtN PB6UgKJDZlNtZbrHO27Zv5HqQN4Dgx7CpnlFhju/N0uUD2olrPXI10P8poCZPv6DuWryIWB+Vzf RicvNpkb+oGMOgeqkxVNg8eqvCSnlfI5J2GLbCplu3F9Ev3jmJHgXHZpmZQG9OTSOFRn41AfAow
 uAw0N0RcyCBsolqBjEnuTYQJDXr3a43QwIhcIAk2HOsOMmk3tbltfj36oKFIxC961C8kEgKm
X-Proofpoint-GUID: 4_uJvK23G1ThLTtG3gG5LUd4MaV9dI0-

On Mon, Jul 14, 2025 at 11:35:44AM -0400, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250714 09:08]:
> > The check_mm_seal() function is doing something general - checking whether
> > a range contains only VMAs (or rather that it does NOT contain any unmapped
> > regions).
> >
> > Generalise this and put the logic in mm/vma.c - introducing
> > range_contains_unmapped(). Additionally we can simplify the logic, we are
> > simply checking whether the last vma->vm_end has either a VMA starting
> > after it or ends before the end parameter.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> I do fear that people will find this function and try and use it
> internally, it may make our jobs of avoiding this being expanded more
> annoying.

Hmm, surely we should have some ability to dissuade within mm :)

Thing is I don't love having this function in mm/mseal.c when it has
nothing to do with mseal()'ing.

If people want to be weird about gaps they can pretty trivially implement
something like this anyway. Probably. Possibly. Maybe?

>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Thanks!

>
> > ---
> >  mm/mseal.c | 38 +++-----------------------------------
> >  mm/vma.c   | 18 ++++++++++++++++++
> >  mm/vma.h   |  3 +++
> >  3 files changed, 24 insertions(+), 35 deletions(-)
> >
> > diff --git a/mm/mseal.c b/mm/mseal.c
> > index adbcc65e9660..8e4c605af700 100644
> > --- a/mm/mseal.c
> > +++ b/mm/mseal.c
> > @@ -37,34 +37,6 @@ static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  	return ret;
> >  }
> >
> > -/*
> > - * Check for do_mseal:
> > - * 1> start is part of a valid vma.
> > - * 2> end is part of a valid vma.
> > - * 3> No gap (unallocated address) between start and end.
> > - * 4> map is sealable.
> > - */
> > -static int check_mm_seal(unsigned long start, unsigned long end)
> > -{
> > -	struct vm_area_struct *vma;
> > -	unsigned long nstart = start;
> > -	VMA_ITERATOR(vmi, current->mm, start);
> > -
> > -	/* going through each vma to check. */
> > -	for_each_vma_range(vmi, vma, end) {
> > -		if (vma->vm_start > nstart)
> > -			/* unallocated memory found. */
> > -			return -ENOMEM;
> > -
> > -		if (vma->vm_end >= end)
> > -			return 0;
> > -
> > -		nstart = vma->vm_end;
> > -	}
> > -
> > -	return -ENOMEM;
> > -}
> > -
> >  /*
> >   * Apply sealing.
> >   */
> > @@ -184,14 +156,10 @@ int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
> >  	if (mmap_write_lock_killable(mm))
> >  		return -EINTR;
> >
> > -	/*
> > -	 * First pass, this helps to avoid
> > -	 * partial sealing in case of error in input address range,
> > -	 * e.g. ENOMEM error.
> > -	 */
> > -	ret = check_mm_seal(start, end);
> > -	if (ret)
> > +	if (range_contains_unmapped(mm, start, end)) {
> > +		ret = -ENOMEM;
> >  		goto out;
> > +	}
> >
> >  	/*
> >  	 * Second pass, this should success, unless there are errors
> > diff --git a/mm/vma.c b/mm/vma.c
> > index b3d880652359..b57545568ae6 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -3203,3 +3203,21 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
> >
> >  	return 0;
> >  }
> > +
> > +/* Does the [start, end) range contain any unmapped memory? */
> > +bool range_contains_unmapped(struct mm_struct *mm,
> > +		unsigned long start, unsigned long end)
> > +{
> > +	struct vm_area_struct *vma;
> > +	unsigned long prev_end = start;
> > +	VMA_ITERATOR(vmi, current->mm, start);
> > +
> > +	for_each_vma_range(vmi, vma, end) {
> > +		if (vma->vm_start > prev_end)
> > +			return true;
> > +
> > +		prev_end = vma->vm_end;
> > +	}
> > +
> > +	return prev_end < end;
> > +}
> > diff --git a/mm/vma.h b/mm/vma.h
> > index d17f560cf53d..bfe9a04e6018 100644
> > --- a/mm/vma.h
> > +++ b/mm/vma.h
> > @@ -598,4 +598,7 @@ int create_init_stack_vma(struct mm_struct *mm, struct vm_area_struct **vmap,
> >  int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);
> >  #endif
> >
> > +bool range_contains_unmapped(struct mm_struct *mm,
> > +		unsigned long start, unsigned long end);
> > +
> >  #endif	/* __MM_VMA_H */
> > --
> > 2.50.1

