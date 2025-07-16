Return-Path: <linux-kernel+bounces-733765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0EBB078AC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC74179103
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1370E223301;
	Wed, 16 Jul 2025 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j41zqCw/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OwF1olzC"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D434B26A1B9
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677655; cv=fail; b=Wj2wetM9BnqH5QgcHTmOoZL96/x+ElQVJB3O/2jwrG6n02lQ1aYHJgD86sXpAGUoUstsz3nv3CSze2lw3XUOaKF7s04fsI/nz/dod+rqx2F+xXa5WO9yb3I+zrAaU81xOrzI0fu0WLDhC686hmX4DTzQ3XpYogg2DH/M5VcrAnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677655; c=relaxed/simple;
	bh=YtjKZ2Q7kEX2gndzYtHfIhuE8YFejKfpjQnowTu4ZVk=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G9or7SWpOSaa1NFRt+f1qpdi1zPTAS2M4tWEWYhYy0luu/D37nX+OQJrSzWNibyMlnZJURJ/uIvbG/nNpZ5xQIVLVm0QuVWPXdHzR96DU3zBe0vm1HXZzQDqakOr/V+qWsEgHgc3efBEsUGs8E1GfsIFZHfpzj5EIWUhmILwcIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j41zqCw/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OwF1olzC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GEofiH026705;
	Wed, 16 Jul 2025 14:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=5lU+tPoP1I92PzVacl
	1lvrnDFPHFj68EpiUbpl8MsIU=; b=j41zqCw/PeujxwD8x3QVqyqnhbxtq0LEVd
	udO2lbIWi0RH842mho5Li3dstbUtn8wk9EiAhJhKxmE/BLtzikCGGYjTOmXl+W97
	UTe4/dHUjddw+QsIUV5a94O4IYbuHS/+ef2ubRRD9XTbLTff2V0RrdEUvMk8XIB3
	NMg1Zc5v6NSVVxSDydVo3AAMsXoRNxJ5FtD5rP72KOzj1TudrtGRGZwf5RvPt85n
	HjcgY8yRIQTX2pFWnwBsVLxzfZ2nDNSPznauxurhc/TLC+HQgcLGFr6vMe7SIlac
	gjv15fxIXt0BQ8z3YC/yWVOHEJocDnivy2p5u3EJdCSIwtElbrHA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx81agn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 14:53:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56GDVFtM013003;
	Wed, 16 Jul 2025 14:53:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5axx5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 14:53:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhY7WGmVkyltCq6M+yXxH+YWz0XxSvSi6vtlf9iYhmEPD9wKqO7NlIDvdn5DrOhRiiGJZiD5H4cvJvJWJ8bj608MXekq8+wHC+nlSvfZAVQzRBQ+f5jXD612WiPrZZGHRuDPxGqXUSrPlVNvmStlvOjNCkvX6Q5GyVbNT8oTFq1r/6V/QDoJtyJ8qmN3EcK2FvX2Z/FlHlA3lVh35eepyTqjLLvz00Y5NT2OxnutttymNiXieOVpnLQbMyhOgsy4xNPaVOC2HsuqyTNuHZ5/24gkeErokvvSUkOzAJLElIFg3UYfo2/bZmSAYlrj3KFiZdfkrmJr/4cgTfoIPSOX7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lU+tPoP1I92PzVacl1lvrnDFPHFj68EpiUbpl8MsIU=;
 b=E45y0JQZgRZ+IB7WPy6Tma9Ro5B/zHg0P+xi/+5knYr4lnomWiF+1s+7I+hx5/1En7RVwjTAF+2nhqbFav5hjTBP31TAyapfQBPqz/33ixTVmYlEdF4xNtTskoBMSk0Fa+ARhkgVEKMNWUei0+34NIQfxgQeNkqkbTADJ8bOJ2JVJWHvJGWyq84oHjCza47B/gI9wOYtBau/d2Axn/RwQHOzqvJYa5z4iYo3IfOTq8gZ54vUbN+81ZV/HVl5cUlgv6GM4EldsgBF4EkRoPh6xHSuhTo1vGn79eR7UN71SRd5nJEuwCJOAeKWLuo3+B8dDfE3Dp7apo0bILl1r3A+oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lU+tPoP1I92PzVacl1lvrnDFPHFj68EpiUbpl8MsIU=;
 b=OwF1olzC+QPeefQPZd0KyG7hCl4eBXpytg1lXtJxZ5a+ugQaU1ffUzZRtUDg4nJdwXh0Sa6B3699faxRxCVfAOXm01SrU1ZkgPUevr9TxKBDPR3SFiK9D9xQoQepJ+d6c2RqYm/yE87HVNyk31PudcSM/QMTdOT2Al/h6kfvMX4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BL3PR10MB6114.namprd10.prod.outlook.com (2603:10b6:208:3b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.31; Wed, 16 Jul
 2025 14:53:47 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Wed, 16 Jul 2025
 14:53:47 +0000
Date: Wed, 16 Jul 2025 15:53:45 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH v2 5/5] mm/mseal: rework mseal apply logic
Message-ID: <4c51bd5c-59cc-45b8-8d17-1a2b7b99cb55@lucifer.local>
References: <cover.1752586090.git.lorenzo.stoakes@oracle.com>
 <1d6abf27d8eac0001f8ad47b13f0084ceaa6657b.1752586090.git.lorenzo.stoakes@oracle.com>
 <nv7vxhx5cpkl337f4qp6gdg4xvir5e3mggqaxxzgvnzl47o5b7@lvp6si5qerlq>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nv7vxhx5cpkl337f4qp6gdg4xvir5e3mggqaxxzgvnzl47o5b7@lvp6si5qerlq>
X-ClientProxiedBy: LO2P123CA0068.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::32) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BL3PR10MB6114:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ec68324-7f42-4309-432c-08ddc47891b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6xVh+/Eixftj2OwLAnjmVXozTRR8FPzEWHzzgdDscQL00B1pGEdUhq85WB5L?=
 =?us-ascii?Q?GNxvZFWZ5c6ke1p0WHSyqlztrWE/a9M9yKTI/TxteGdE9re2WTT6y7/lTi0U?=
 =?us-ascii?Q?5l8mXe156XfvoVbRJOUhCHaLQqZ9bpzDQemewA7f+sS0SEOP4sh7AqBUsxrE?=
 =?us-ascii?Q?KXg8JxGtNT/uBMnJRie0LKRLA2TlX7HTRD4K2a0TgzeOGivjgREPPUk7wlpc?=
 =?us-ascii?Q?ufMRh7krP13iL3dNuA094rFenrsi8YDNte4KhuSZywzXONZ+XpdSwh7T2xpJ?=
 =?us-ascii?Q?TVatJPFe1rlmf36IVZd+q6wn+FAFYcv/big2OBl4ofl5ZXU/ioktH2zHx300?=
 =?us-ascii?Q?0muhQu9u+BplYQqBHL0Nbynus1Ob2cFiAqWTjXwqefFb0UGh9XJPJfSv8dBS?=
 =?us-ascii?Q?glwpn/0bhMASgfFxdIeh648S5pKbFuLeU16ucR+HCtcBOO3EiDeKktG89BAz?=
 =?us-ascii?Q?8JmgV3WlFQecnXqKRJFBtmiHj/RtumNCS2ynVwL0ZgGBVwz5fbH00/lSK97d?=
 =?us-ascii?Q?pcrUND+DMi2MYc37LXB5wlGURNuURyyLKjhvxaokrskHEy3Es06wEAIm3BJz?=
 =?us-ascii?Q?7gCq19gZp9SfqQa7vpgcP6putFz8c3L6YxgL9PZ3RkbcAvhgzjWnQhuQiQUA?=
 =?us-ascii?Q?NKtjpahaMHBRu7K9ii1vgGo9RuJiZM32uJxgBWqJJiMkiB5BMogYh7gpGesn?=
 =?us-ascii?Q?LoVrMUgHwIblxvLuLR31ahjAGo5dFfvcNZOaYRdKYPA+cp+jyLR11APU3s3i?=
 =?us-ascii?Q?/z14ujBTyQSJoWEIZ+RxHb6lDzmrjEAlw68riD0FI4IGIHkVGCh1+Ml7Ooub?=
 =?us-ascii?Q?wB9speTspb9YD84yBeU3EukSjS5Aa1a28x5fR9Z31dAGIRz1nLeAUz58s8NH?=
 =?us-ascii?Q?uA6pA6sS5UAKcHaS7Hw7nI+kkWsFRmmmfl2OCtWeaeR/cyMVs5ms/PDRiWAy?=
 =?us-ascii?Q?p/dC9XU0W6mPvwUwo6zNN5nj5QqJ4QPne7txhSD3mZQhBEpV6leLaRTqJLh6?=
 =?us-ascii?Q?LOVUU7yZL7vX69ZtSwuwnnO6Wsk8Oy6Xo/sc1W9uUdsQwriNVoXbusJMZgVM?=
 =?us-ascii?Q?aKm6nHe++j7ssHDGBY2Pc/mpCWbLE4LPHE0VhDDEMWnDPpvSxxN4ItnrPt6m?=
 =?us-ascii?Q?8a6MOIP2xFRADvba3NLehRyV08atc56wzU+HzfKosyk2n5HkP6eEZ5xIJo+u?=
 =?us-ascii?Q?fl6OxNQS+4MsMGft4adge1lm831d0UfA5wWbeBRl0bx9L6gn/XqvWIt0DlCm?=
 =?us-ascii?Q?sj6kvL06T7jxmpYe9A+FD/J540M701wl+q15QhQuNoXSUbCg54FXhJD/1LJp?=
 =?us-ascii?Q?tBYc8vteRjTy0B/g9nP4c6R64BJU1J2jr0PNAFr44SIIiGRMlbYjEMQYOJ1j?=
 =?us-ascii?Q?oGvN+NIkBhoQn/eS49+jo6tKA1sElsY91qoqKY7nswqr+ZzTUoRk6931LaGU?=
 =?us-ascii?Q?QIeYkXZJH1k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BzEmSpX2uxtmhq0Mp7gfgX8GF9RSBq84Qi4tj94fprtjpSJ56P1PEZ3s3/KI?=
 =?us-ascii?Q?esQfWkn0pDyYop0Iy6jpa57pqNbBFJnmef39Dy2xK25hisRW5I+9UNB9mLvT?=
 =?us-ascii?Q?dQ0gAbd5EcueAhQ8rkg0CMUVosBTuHdRr9gjQ4c1ipgmPWeLokmzK2cY9oSo?=
 =?us-ascii?Q?W1ehJcsYvKc9Cnah6S1gUbLRagpGVuIj9EdnXL1O8ZEKuJpkPcnIv3sZpBDN?=
 =?us-ascii?Q?84/cDdIwa5roYzgrpK7escRi2j5NytLUU3b44PsFDcR8IMIgpal6mNozIIwd?=
 =?us-ascii?Q?PDJucvSWXxWnmHrPmD8zWFzfYK2DJDulk7W+MQc8lEp3a3ZhTmzPFIOQRQ+2?=
 =?us-ascii?Q?+PE2r4fD2ktSAjSjdu3vW8H3aY0CSUnrtvJdBhx8sxvr/pJPfSBQJ9KNIjJV?=
 =?us-ascii?Q?EFw3mUGG1fYycYjqzLPa9rmx/+JaUfL760fisljDKIc79mTdlkjfdX+1Tqgk?=
 =?us-ascii?Q?14xs/oJEGsMr2XMuV4EM5Xql+9S3Ffy8pKe3MqIbEe1yi+i/vLwoZK03sIu4?=
 =?us-ascii?Q?vBkCOjPmH9KzgbR1VspVSEBdjWhWVF84Lk7aut8S3aOQM2aiC0VL5O1LhWUL?=
 =?us-ascii?Q?WMTfL3aZMt3dAkoWe3Zm6uo/vZxGn/ry0h/aoatmIV2HVhMo4U6au+ePR+6+?=
 =?us-ascii?Q?a9oBXejvno0i6MJUmBKEWZzqzZ39MdR4FYIWmg5OOYlZB7dRFm4MhOPukOXT?=
 =?us-ascii?Q?ZALRR1VGnbvMxce69Wei0bNGCd4GjPz/OqQADM77RWajG0PuhFw+xYQnzMyd?=
 =?us-ascii?Q?l+mD+llNTAvA36Kh9wK9kku3XoWB4D+mM8XssbcRhCL8MK/DJGJPaSHOP6XX?=
 =?us-ascii?Q?S8VtLjUKpool+zYX5lsaH4VV0fFSclhzyqyCzJpPfXEXqRuH9Ve0I3zpyIjK?=
 =?us-ascii?Q?Cdp5cW7or2lMyIhFtsFKozCwvfoZ10L84RCm/1OW/neBtYrAiBGfMrBdBfcw?=
 =?us-ascii?Q?AGUZyBpo93fdslc/VNTv0EFxVToqKZpqSzy9bovxNH+2XLE3C0pOPqaCtxSu?=
 =?us-ascii?Q?QUzXFLWobHN66Cj1uZmcBcRBcoNqjsNxohqw7esn0aOAFd2RzIoWDcLjMC5s?=
 =?us-ascii?Q?2IUD/nyMZ2bTeG53Q2HTjXVOIqzQVrdC4Ojmp9PjVvqvrftW/6n2UWrmVHKW?=
 =?us-ascii?Q?TJwfU73sOAKQs0Hliq37A3Ai+NNLuPDuwRGuNMKE6pBdkFgDm6wZiM1dFf3I?=
 =?us-ascii?Q?TnuS9CPeIHMAiEZZAB4u6ePOmH9eQfim49TpHl7BkIoQIwImwrJHBbTXhndt?=
 =?us-ascii?Q?49BsAe4P96BlN1y3HBXOzD2H3qWO2GxsbMq64q3d6i2BXzhqVP75p0s3oBTP?=
 =?us-ascii?Q?0DhL7ZfPZtmWA2ljg1Xoe8Yvo0Uq4KcSa709rCShTEJUazltg2FY4mRxrWHO?=
 =?us-ascii?Q?16E7iSedpO8TMfMwIr+YTs3xX2qwMjqHAQlHsAb7nMP/mt2Ia3AQL2oqBf/W?=
 =?us-ascii?Q?xfUfNxZgaQxfj79CeZmgKFteU1m3Cedl+9sTabFt1iQ8VgxxH+51voJ2Dr5h?=
 =?us-ascii?Q?qmGvDLCOkQ8do6hug+QYJWEgqKMg0FC3whCA57YwJlX+j/s613jFVlEaGL05?=
 =?us-ascii?Q?nHj9gnzzZeKYOAlYuoOCaB4eT5t00cLanhTBhHqwwQZ43CNY2MhVx+JD5Mfs?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eNqaL/aHqZNBPEG5uyDoQbZxG9upU99WFzFDI+WpO4AQJatYDSZorL9gS0m1ZnRNBqjZYcPD2Yk5W1ZqSRtQK0O6VE8sXAwGtUodmFBHUs+engPuKcTL8FiDvVlI2X/7PZI6y25LgN/fy2VTzc0frP6REoWgCuYbzEJyQb6zqGnOAXqGcssIlhQ9uNMe2bEYyRf2JJXnvLtz68daBguD6kgFieiQrchI97SyffO6ooVKa0y7NTEZjR9n6WcynuYVAysp4ptNDM/13NeSaJESVhreNBd1zN2u3/i3KDHjwrNlzVyITkIti41mpVxKuak1NLcz+KMWPKlaVlljSQii6Qf0FqdZmeAuZNXwAlwG4PmyyU0XlTetbJYoZmTwaCuPmXGjo0gFSrxikxLq4DjxftAmwkvr03o88jlRel3+smM6tAX5mT+cd7HMRe8Cm4mj1elH7WzhJ71MetDz/kXL+Al73lSAx6EiJW5FOHPviikbPa3/ObFDLIX2xqfNOA37/FS3kgaSfIjW0Zzkb0eCQV7ZGDc3zbj1T2To1zpQUxoIOK+pfETtfU3rJE956u2QO+em+YXOP/79jgQQoE3WxxwIzvHerHYfH9dVojaGceo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec68324-7f42-4309-432c-08ddc47891b6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 14:53:47.6990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23FJQbAtDouQ0Wq5Poo0VHGn02N/5XteKTD9JdfTe5LJDkxOjtnJ4ncN3wcmFiVTlQGMPYDPBTg4/IF8XHtpdBha3djR90KTFrmZ9is4IIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6114
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160134
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=6877bcff b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=fcAvc9LaO5aEp0G5gfIA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12061
X-Proofpoint-ORIG-GUID: NOgu4XMCxPseAyw2zrEqM3hkcCV-kgp_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzNCBTYWx0ZWRfX1Ka2CuFukddw OzcljEWpXpnE18Vw8sS/xeHVRYHgo6dWIVITbboBb/0cErYZrwcDPBLwD1xAA0ezLQn+vRfWNal 6FgLvp3ebTT944aMgtU7is449sHim5R6+x96p/8D5sBE8SolY7CuzqX79A7sUuxhyjHZfz9JlwQ
 kH7ONy+gFH3a27av0qDRop1EEB3q15CogaEvLX0exuFLMiEnMkY1egOfhg8vQqsNBt6lScMSVa/ HwBoPS2WURFmliNW8/soJuaJ1FxWyGtCNYWDvR/1HF33A2VaLw7kJzVVzuL7gKsXGIlj0QcAoYi CiGKK1XGzhrNmqtTyOYE+ooIfGGDzZdfAl3jGsWN7eDHT1wmZtbOXCxLCQ+/oHGuZ5H+SJbRq4k
 RP3jXiJXUBiNvBRTS+3RkrekzfRGwW5xWhG2jCXiqqdseUqfymU8uIkj2OQ7U9zsCIpnxDxB
X-Proofpoint-GUID: NOgu4XMCxPseAyw2zrEqM3hkcCV-kgp_

Sorry I actually replied to this yestreday, but then closed down emacs and
turned my PC off before I had sent it mistakenly thinking I had :P doh!

On Tue, Jul 15, 2025 at 12:09:10PM -0400, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250715 09:37]:
> > The logic can be simplified - firstly by renaming the inconsistently named
> > apply_mm_seal() to mseal_apply().
> >
> > We then wrap mseal_fixup() into the main loop as the logic is simple enough
> > to not require it, equally it isn't a hugely pleasant pattern in mprotect()
> > etc. so it's not something we want to perpetuate.
> >
> > We remove some redundant comments, and then avoid the entirely unnecessary
> > and slightly bizarre invocation of vma_iter_end() on each loop - really
> > what we want, given we have asserted there are no gaps in the range - is to
> > handle start, end being offset into a VMAs. This is easily handled with
> > MIN()/MAX().
>
> The vma_iter_end() was to detect a merge with the next vma and use the
> new end, since the code you are replacing didn't update the vma pointer.

Ah interesting, good that we now no longer need to do this!

>
> >
> > There's no need to have an 'out' label block since on vma_modify_flags()
> > error we abort anyway.
>
> Ah, in the mseal_fixup()/mseal_apply().  The out label still exists (and
> appears in the below patch) in do_mseal().

Yeah indeed this is what I was referring to :)

>
>
> >
> > And by refactoring like this we avoid the rather horrid 'pass pointer to
> > prev around' pattern used in mprotect() et al.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> > ---
> >  mm/mseal.c | 69 +++++++++++++++++-------------------------------------
> >  1 file changed, 22 insertions(+), 47 deletions(-)
> >
> > diff --git a/mm/mseal.c b/mm/mseal.c
> > index 794d1043a706..e0fe37623632 100644
> > --- a/mm/mseal.c
> > +++ b/mm/mseal.c
> > @@ -15,60 +15,35 @@
> >  #include <linux/sched.h>
> >  #include "internal.h"
> >
> > -static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > -		struct vm_area_struct **prev, unsigned long start,
> > -		unsigned long end, vm_flags_t newflags)
> > -{
> > -	int ret = 0;
> > -	vm_flags_t oldflags = vma->vm_flags;
> > -
> > -	if (newflags == oldflags)
> > -		goto out;
> > -
> > -	vma = vma_modify_flags(vmi, *prev, vma, start, end, newflags);
> > -	if (IS_ERR(vma)) {
> > -		ret = PTR_ERR(vma);
> > -		goto out;
> > -	}
> > -
> > -	vm_flags_set(vma, VM_SEALED);
> > -out:
> > -	*prev = vma;
> > -	return ret;
> > -}
> > -
> > -/*
> > - * Apply sealing.
> > - */
> > -static int apply_mm_seal(unsigned long start, unsigned long end)
> > +static int mseal_apply(struct mm_struct *mm,
> > +		unsigned long start, unsigned long end)
> >  {
> > -	unsigned long nstart;
> >  	struct vm_area_struct *vma, *prev;
> > -	VMA_ITERATOR(vmi, current->mm, start);
> > +	VMA_ITERATOR(vmi, mm, start);
> >
> > +	/* We know there are no gaps so this will be non-NULL. */
> >  	vma = vma_iter_load(&vmi);
> > -	/*
> > -	 * Note: check_mm_seal should already checked ENOMEM case.
> > -	 * so vma should not be null, same for the other ENOMEM cases.
> > -	 */
> >  	prev = vma_prev(&vmi);
> >  	if (start > vma->vm_start)
> >  		prev = vma;
> >
> > -	nstart = start;
> >  	for_each_vma_range(vmi, vma, end) {
> > -		int error;
> > -		unsigned long tmp;
> > -		vm_flags_t newflags;
> > -
> > -		newflags = vma->vm_flags | VM_SEALED;
> > -		tmp = vma->vm_end;
> > -		if (tmp > end)
> > -			tmp = end;
> > -		error = mseal_fixup(&vmi, vma, &prev, nstart, tmp, newflags);
> > -		if (error)
> > -			return error;
> > -		nstart = vma_iter_end(&vmi);
> > +		unsigned long curr_start, curr_end;
> > +
> > +		if (vma->vm_flags & VM_SEALED) {
> > +			prev = vma;
> > +			continue;
> > +		}
> > +		curr_start = MAX(start, vma->vm_start);
> > +		curr_end = MIN(vma->vm_end, end);
>
> If you assigned curr_start outside the loop, you could just set it to
> vma->vm_end after you change the flags, this would reduce instructions
> in the loop.  But this is hardly a performance critical path.
>
> And we probably hardly ever execute this loop more than once.

True, could do a curr_start = curr_end too which is sort of nicely
self-documenting as well.

I need to respin anyway based on other feedback so will do this!

>
> > +
> > +		vma = vma_modify_flags(&vmi, prev, vma, curr_start, curr_end,
> > +				vma->vm_flags | VM_SEALED);
> > +		if (IS_ERR(vma))
> > +			return PTR_ERR(vma);
> > +		vm_flags_set(vma, VM_SEALED);
> > +
> > +		prev = vma;
> >  	}
> >
> >  	return 0;
> > @@ -185,10 +160,10 @@ int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
> >  	 * reaching the max supported VMAs, however, those cases shall
> >  	 * be rare.
> >  	 */
> > -	ret = apply_mm_seal(start, end);
> > +	ret = mseal_apply(mm, start, end);
> >
> >  out:
> > -	mmap_write_unlock(current->mm);
> > +	mmap_write_unlock(mm);
>
> It is nice to see the local variable being used.

:) yeah good to refactor that.

>
>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Thanks!

>
> >  	return ret;
> >  }
> >
> > --
> > 2.50.1

