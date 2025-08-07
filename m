Return-Path: <linux-kernel+bounces-759191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D14B1D9EA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027983AD49C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CC425B311;
	Thu,  7 Aug 2025 14:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gv0J78Gk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bymSHucb"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644B82B2DA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754576778; cv=fail; b=qzcYW8FXRyL8wzhbWRXJSWM5XFZWoPBbiiU4ZFH9FsKJnBVTdAPlPvD59lAxcb5xddXCm7DP5yJYuBTwGEJ7qkuqf3hRRcwNzQ0ASbre5l8vn8JZjN9YzEL6oNUY+AjhPaDhlyPni5dRHv7XG1xI2bYRsMn2sqclFoTxf7lgCA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754576778; c=relaxed/simple;
	bh=EeXYF3J6sQ2jpEjlFFfO1kVLYSesLFat9IrGAOXROrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UxfPBMh5dxcPLadnuS6F30kev6APlXwEog9pXRL9XJTjsPRh0moB62vZLZQWXr1p5Y2VPoFs99+Jvj2Qnyfcl7zZaTZnP2PdldPOb2spXo43DvU0Qf6G7wNgbd4R/VlpFfjrAKs/vMngO2SSMbK7aT8tNU1eVvCHzQ0a1MtXgmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gv0J78Gk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bymSHucb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5777NFrc027311;
	Thu, 7 Aug 2025 14:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Yj61uaKskyly45vkM9
	ktv8jU98i0tJI4I5wAWaypyWc=; b=Gv0J78GkGF2NaUZbtkduodJ2HAQLoQU584
	UBA4Sc06C87687FG+9ZrbZHT1anOAcLRRyoka+oa4PncaG0zrT9OUv1pcnxMeUTj
	8gYmW2mIb/cMgMABPEBxd2ToWjYMIkHWzQj5HjACZMVYDQVKmkTbNs5rvNj0wb+7
	MsSu0I6EAOYBHbX63RcTGdLCgkDEQj3D2aN0R3WQXQrfSTxrcpiAKOtXnGDHcj/w
	wHM39k5JU0TnGSZg06BYsrlq3AuIOH3MEqdZI/vaoXl7dfA4aSvBdvp7oHtNwRRy
	T4lptS39o/ZY/h35ddufHd0niKwC+gmTpdsLW4S9xcD7LU56EIeg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvd4ack-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 14:26:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 577EF8PW009761;
	Thu, 7 Aug 2025 14:26:04 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwng4x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 14:26:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMLXx0UXLSzJOyMQhPD82pO3KqC9DUVr3w0bFEV3PNE5uQOzLyLK0wKv31FxDbj1viWZrosGY/ZJNGLAXxTndKbWnKhcgCUeyCqNd6VZkg5l+G7/DTXxV3PBK9CTbHLXgGB0TBM+QFikU43UTf9OjhuTWfYW2wkfh1Ep/voj4G6gjGBsG+/SwNL9WEtfUBKfQdNtDpM3eYx8un0RrtkLgMEO5V+tqVEHJjxJswEoJHrDHkSyd7nYD4ve6zXuPgKqJ7Uc05EzmYeQ3qWIZYspGOwUmhHo3VzDsTLRxlMOQxLQnSvAA2/EDwXbKFNUGaUzZ/c1oFjOdw4ypJrXZYPgpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yj61uaKskyly45vkM9ktv8jU98i0tJI4I5wAWaypyWc=;
 b=UNfreaUDd4ru+kX66MoAxymi+2uh4Fhi/+ScqJjEeSgk3ReUApX92WP7f7IZwL/56IMm3flrwdNy6DijibN9EZqeHjTaDMDa+tm2xvmrbv5v34+RLNrsIXrm3HajEh8+yAQJSEGswp1zkJ9ZnFRisRoWIQZhHPlUqc73AzQXu3pXmpIuYpEXFIur+9ECrmSPMNa3k70KW3zHr2PFaXTBD6a+zqgcFBiQFYjPcT2i3i1CoZgLxDhlziQ0goeuNTLdRXcYWAplaeAxGuRGWjvf2TKGVLvrUfhfKLwHd3PHa2YewJs+UrIno/UlbsL0zV+xVq8HzLoQHWGJtGsg87TEGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yj61uaKskyly45vkM9ktv8jU98i0tJI4I5wAWaypyWc=;
 b=bymSHucbJEv3vliZw97mdqxW4jyexVmfk//ij7uWi0D/tQiFgztS3uljM8WCRrafeZ3p6ZfWHWUAqOhrFlDAdoKXZZnRRTqH8sAkq0IapUG9TGXiw0utmglXE9h+dDrKjY7oSnlgZQ1xWSeAgipji+hDseP5H6jWr1KetkLP3Oo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4735.namprd10.prod.outlook.com (2603:10b6:a03:2d1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Thu, 7 Aug
 2025 14:26:02 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 14:26:02 +0000
Date: Thu, 7 Aug 2025 15:25:59 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Kees Cook <kees@kernel.org>
Subject: Re: [patch 3/6] perf/core: Split out VM accounting
Message-ID: <49f5b901-c920-4402-8f59-631ee53dc280@lucifer.local>
References: <20250806195624.880096284@linutronix.de>
 <20250806200617.386748791@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806200617.386748791@linutronix.de>
X-ClientProxiedBy: LO4P123CA0589.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4735:EE_
X-MS-Office365-Filtering-Correlation-Id: b260ad51-4f82-427c-a8c3-08ddd5be5611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VvWpC2L3Z3peKQ7BB9tOyPQM+t07kFQIWeav/tH4+2MXM9vvDzsBgwd/+0BB?=
 =?us-ascii?Q?Rs6mDajBiKqcugnbUlGCaifeSfpc9xEOyP24m8RoXDFPTJTYceiUIZOduj3F?=
 =?us-ascii?Q?2l1nrEWCQ6o8/hAlsoYOIdhvsp/nJxhuH+nimKfMkxk7JT11Kq1Tr+uLbed9?=
 =?us-ascii?Q?lUu7WT0kSdUGEZqm6LPjwgp5KkBv5sJgkAxmAf3AeTl/45drG5srsaf2j7tH?=
 =?us-ascii?Q?IFrWI5MQjzsQ4yS4hx9QzixEHbve4Q58ts33EUpGQ3p+qu2cTRLNFONSkGF6?=
 =?us-ascii?Q?XHvHBaNPvAqmhwF284T9x1cf71xPE7HXqfox1gnv/ROCgUl4pgcWjLg6vnGp?=
 =?us-ascii?Q?s50qdc9xZ9lBtM8SMqRdXfldSRQmwPPXvioV7VDbvioWPOY6UqDNLjmUShGU?=
 =?us-ascii?Q?N9MEMinzfC7JQE+BgROPeVcM491KfwOCdjnZK5zfnGXXTnDmucmCiR0Iw+ka?=
 =?us-ascii?Q?ybZoXN+nA8/zvfuK59B2sfbVYxq55oCXupCZ9FtR6qNcxbpkmgM6sZkaNfU9?=
 =?us-ascii?Q?8hIo61p+JFSPK1PitE9wLQF/A76jSfOVZMiegxhXWwCH0fP/Y79V7PBzb4H4?=
 =?us-ascii?Q?5VMYVgPe2yhlH4gBzd9EfvfobhjFulJOwnhPXDUBtmK+tIUyZ+QP6d23rI+E?=
 =?us-ascii?Q?JcSYMdSyuSAXh/2IlN7OnGvmb/X2ymjwtFyF+waEg4CWmqR2+zhFMvxUt8p4?=
 =?us-ascii?Q?W3hTBhKFdITEywTcqltDDPvZ4MvVCbAytCTQjOQiAeqSd0R7FuDOUyW36AFD?=
 =?us-ascii?Q?yACsk7f4uPO7db6gHGivMcaJH72s4JTupwN7Yv4s6IAJGqrNLKOZjqFJ5IS0?=
 =?us-ascii?Q?VXYyCm+nbLPOU2XTB4Rbi6GSLV8DokZ7jXZ4kdZ8zGs5DO3LXDvdgGZufj7k?=
 =?us-ascii?Q?diTfet39b0Anr5o8hEwes3TZSjF5IZOK6Fnkby01jdb5eaWMG4Ol7dzEQNiO?=
 =?us-ascii?Q?p+UpoUEkuW3SnoZusniA2lKSupW8uVCff1hfvIXW0Nk8d/DwCXpYaQqb/ATR?=
 =?us-ascii?Q?MNNy6HOylS68Pb/GyZUKggOlcMOmrxxKtMjAh1MJA70aLM5d4pn2vOvUP0zL?=
 =?us-ascii?Q?zLqOwQ5O1SyOb6PmuPoU0HG/Sh6uSV3sF3JmSvEfsopFI1RaxcrsUU5NCnuZ?=
 =?us-ascii?Q?+8M73kMMmRqkjwpP8v30fhFdtOel7dS6ZwyGOovHThg6OIKK/jH1lGtPll/l?=
 =?us-ascii?Q?pRi/Ha0dzCvJakp+LH6Jp0X2DePQbs2cTPGT4xPmxEtbLb/Nm42ri+XR8LhK?=
 =?us-ascii?Q?N83xwSQ38fxXKClNXg7nPUkIF50wQ0H9mAwr4cPwTijxeLmvx6A3N57FBBMe?=
 =?us-ascii?Q?AXGPvKK2s/td4ml1hyf3hUgP+rAcK/5t33X1/BR1xen7XbmKSMQ+figsjD4g?=
 =?us-ascii?Q?QDrTuk1Rr1enGy5B7c1QUCxDkl2iVjipJmI7BhI3j/NGSGIEZKD4tNkOP8OL?=
 =?us-ascii?Q?gkwukxi6NR8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xz64jDfzp+uNt5mw16cjQyV4zJOin6BYqbcPiLLpD61IY0y7LX5CXyAd9nc2?=
 =?us-ascii?Q?uhhMQIPxoCPuh5ul0Ki7rIHC+F7kAXq2nLBCMrvQWDKYz0aeIMUMolqkJ/y6?=
 =?us-ascii?Q?K04tJBKZt4YPLG/6JG5qk6Bda2rIwGDsCAlbYvFeV3yuQFlQRmImgbDy81mI?=
 =?us-ascii?Q?HprOHgjQbBNhaAnAkGIt+ejMPfHjX/tnlWeg1JMXGfYIO21ewtpn+lh4UxB5?=
 =?us-ascii?Q?QSgQgWJYFkPBYy9JEBO35We0sNFJ6XjdMdII4ckpv5l5vWt4r94VdfsSDDC+?=
 =?us-ascii?Q?aUUWkXHn+sPw2mJ1tU7OlxpCG2xbhFI8jmNqi5mxSVuya0X/f6uu7SsyZofl?=
 =?us-ascii?Q?Gf+yp5WtvBbWTkQL8WCyoOVEeS5einQbt2BshzFxQ1ZV+WTPk8Gbr9x3NPvc?=
 =?us-ascii?Q?qiDcPTrzWz7KVnNavl83n9fP593ikqwOGxVxAGwVF2xoH3oEWihsr7cfnGtF?=
 =?us-ascii?Q?pqQpUtXvjC/nBkB1nSNVIlOEgyOsQ+ZJxd9ESxP4drQZsOSOWZlw8LlHHGlD?=
 =?us-ascii?Q?/7sXjrZ+AzMjcrekOT+oelZ4vRPbv0bXVXc43ffW2nzvZ6Oz6R8e1SR6QQk9?=
 =?us-ascii?Q?8BG7LIokQstWAhPSX3wIwxI0e9WSPKTW3SpBJgsajFnX/SVa7xfmdC3e+CxR?=
 =?us-ascii?Q?jISA9THLrNSkfXNBq6aM2NMZ9w29dAUlFi9jOrVZVCgKysYdraY/WkP3kUqi?=
 =?us-ascii?Q?OCFLAWEt0oyyuiDRZdJcXXK3gzJBzcXZumVth2oFPNY9ipOKmx9DdmbVGgxD?=
 =?us-ascii?Q?z475y0RQ9f92fPIzUo2WHM46iM0gaH+2MhjGS+01baC5VeXjoz0wqwO6pKJV?=
 =?us-ascii?Q?j8N2k0LKJiu0BBGQ/aBUJBwo10NFMKHKNUkRHq9Uh7WVGwJPyJaI7Xhwaxyh?=
 =?us-ascii?Q?kzn0pIHaImYXOWGlia9MSpxuuz0pLkZKoMvZeoIrhMj+M/KZo+ktNTy05V3A?=
 =?us-ascii?Q?79/gn0gE79ZnLY8PX7op3UmtZOpVVdkZdcNV0TrNf+8PiqH8hRDd+u0QxWZ9?=
 =?us-ascii?Q?0r6Up3XnfsFQ5QpK/8sHOag9lLHLq+zE42Te+LQ2uvxIGOR78nrV3j3kGfAE?=
 =?us-ascii?Q?7ySpi6WNG8v+TyPpMMUlw/knRepnczMzrTe3nzSPTJpMcu0KC5rsxy+hMIkp?=
 =?us-ascii?Q?8L/AJFQ0RvDA/UNycCyNFj8+3RSvJAbfHoZaQb/iq9tB5UPd+seOKZd39iUw?=
 =?us-ascii?Q?5HqRjVw6537kM0CO8uzwDOieCyeyV920bPvYDkZspyFHdyc3JcfFlz7D+D+A?=
 =?us-ascii?Q?Oikkj9+dzcyVE3vXPMxJcZtGx+U7Oj+wvXebWnJ2whUQ7htVPA6UcEuEugEQ?=
 =?us-ascii?Q?u3jQhka44lKZSkQN1k926lGXYKmiocKCRCim7IVCbBeS2AcfyU7ALYO/grzh?=
 =?us-ascii?Q?LLD0GuZ/dMynFDpuJ0UU+PENW35a8EgjBL6ItHJJJgZsyAP4eDFb0p8FJjPK?=
 =?us-ascii?Q?vnvhpDHd6ZM285+xIsEl/CYEVLmMuIV/5F9UrJ0MFfZTJl0eeW0Q1mgXosSP?=
 =?us-ascii?Q?0bWTg/Qi/CCLwYUFznt+Cr4pmkBMjI/ELEpJsGEk7qmyflNVNisEeIiRQePH?=
 =?us-ascii?Q?uJqgY/vdHeFKNkzVWSIzE2ory0xnMmRyxIw84GiAUf2jru/J4QGUYkPGtGuo?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cA6bHA13jOTXRUrF4yZrFm5mT87I/++AGDUaiNsb6g1WEis/FqQYkC8i1SYfrhyPJkwUvtx0c2B+kEbE08XvaPGIQEYV+rVw+MXOE6tURzyxCSgVzUDvAMa5iT9TpR5qv7TgKZOPreWV221yC7LLwAFpkf9O8uOq6tXbi8kGiUPpRIGwzko7H+Ihye4tViAL0RW4MdL7gG7F5h3aNFN2K2pvJkreoX7ZWHtwpRObC4qBYpSmzU7g/HGJWO8If59MIeDBrd1ABYT5inLVDtpOMOw/0aSTHzP5tSzM4g4UYNYl00UpgRqLLFbncs8uZG0coWHZcBstzwGM9hZG9Svv0mFp6pd/I/DhaDLtQdwn73lR/phdOUEWlEBFe5BGMQ1IfeWIJL1reZbGFmII9edoXsIQpnWCi/Xafcbgsar/nJD2omepNDZamWvaLTcq6H7CoyOqO+QjivpoDMOR31ofxUukvU6zacqZtEBJw6SxwprXX8ZooXOOnuDc72angnHO29R9Dit29sovfsEWdwAgT+OBs8zz0x47PIexPqP5o/OrPzDHan9UimJpknxYVsu13uKQSLAJeyf2biVT0wjw1Qs8HIaEP01g/4ABwwiiWKA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b260ad51-4f82-427c-a8c3-08ddd5be5611
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 14:26:02.1643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 119ptuc9HJ7rhzBs0qYQ/462rkAbrIN07ddf4OHJQB7tl859WJNjwyLtitwQzGEeX5upsZH2sn5xddWbXg5dDMC8gwITecYUvINo6JB2Cjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4735
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508070116
X-Authority-Analysis: v=2.4 cv=fYaty1QF c=1 sm=1 tr=0 ts=6894b77d cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=B6R_Zrf-BUC6JCrMxZwA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 1MPMBSeu1TnVGQssmEqKjWRZx8R9uBM6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDExNyBTYWx0ZWRfX3LocnuVZSkWD
 8IsCnwFT5NCWvLHFxnDU9UoSVZIOGOu/FVSKuG1zrzW6+mJmUseTWi1XG/Y8bFyOs+QUp9YNCZc
 YFCyZ5gR444mawyhRCmJkFQR1fg98ZcK8KF1vjOKTTEGvrR+BOwEsBGctceXzz2wuWozntbxEwP
 fuqNAuM4ND4/s/x23YZKrnuURAXwbFvAE30sIibTcSRVrlA9ct0MxlY0lXi5WhFzMxGcHxVdZgY
 /GGgrQi9gTxr0vl5eOVOtbF/IGIBOTlXgfwxm6g+WyU7TNkhq3SiDtZK79u6nBppjWyIBLaYfTk
 BGNNGgIQhoLl93+1Htw1JxILA2HxTJM9pwPVVKk7prdEG5Lwj6TAN4hznI1faOFRYMmZf22Nss/
 vS/fpGJ0B7j/j9JbQ0nLuzx63qTMMY3KWySVpKkYY5J4YBt7Wl0MKoesLrZF2K+UfzgDj0t5
X-Proofpoint-GUID: 1MPMBSeu1TnVGQssmEqKjWRZx8R9uBM6

On Wed, Aug 06, 2025 at 10:12:57PM +0200, Thomas Gleixner wrote:
> Similary to the mlock limit calculation the VM accounting is required for
> both the ringbuffer and the AUX buffer allocations.
>
> To prepare for splitting them out into seperate functions, move the
> accounting into a helper function.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> --->  kernel/events/core.c |   13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6962,10 +6962,17 @@ static bool perf_mmap_calc_limits(struct
>  	return locked <= lock_limit || !perf_is_paranoid() || capable(CAP_IPC_LOCK);
>  }
>
> +static void perf_mmap_account(struct vm_area_struct *vma, long user_extra, long extra)
> +{
> +	struct user_struct *user = current_user();
> +
> +	atomic_long_add(user_extra, &user->locked_vm);
> +	atomic64_add(extra, &vma->vm_mm->pinned_vm);
> +}
> +
>  static int perf_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>  	struct perf_event *event = file->private_data;
> -	struct user_struct *user = current_user();
>  	unsigned long vma_size, nr_pages;
>  	long user_extra = 0, extra = 0;
>  	struct mutex *aux_mutex = NULL;
> @@ -7136,9 +7143,7 @@ static int perf_mmap(struct file *file,
>
>  unlock:
>  	if (!ret) {
> -		atomic_long_add(user_extra, &user->locked_vm);
> -		atomic64_add(extra, &vma->vm_mm->pinned_vm);
> -
> +		perf_mmap_account(vma, user_extra, extra);
>  		atomic_inc(&event->mmap_count);
>  	} else if (rb) {
>  		/* AUX allocation failed */
>

