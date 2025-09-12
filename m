Return-Path: <linux-kernel+bounces-813756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5E4B54A5B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395C7587F51
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512BF3002CC;
	Fri, 12 Sep 2025 10:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TyJmhKaM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dTF/LbDp"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908C03002C2
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674144; cv=fail; b=eKtSSVDCbOtkGMbYQbnN3yVGnp3+yHHP4asWL+mr4kykjDZ8KslmUl6W82xF7tyvaIZfNX/xLOwTEUejzeecQtn3i2rw0X8Q7Ug5NnKisa0UHnDqlU3/fi/aDHhqjAkAoY09KuICqFt5YdK0OTkE9T2vBXs8yY7Hy9g16Buyg7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674144; c=relaxed/simple;
	bh=a607/pnUKfhqkl/0MYtczR07gLY3tBracJs7EdgD4ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jCLFfnj+E3VLVcFym8NC5qxO3866EifLroN8ozqkgjpS3KLYo7QwHc78W4O6g7czCP1WvpfFbXi3m8O8QkbfyxdV/a8cslCkQ+utQ+/gULnwsGUjOCYcKKASkWnT/vdq+gy/Im8DBMU4Y4Il6NfN++SX8TchcAySbiGc6dsGQhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TyJmhKaM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dTF/LbDp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1u6QI009704;
	Fri, 12 Sep 2025 10:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=FbAv1lA46EGTfLVNOw
	v30UMBOhNtokxKa3DnlczWnas=; b=TyJmhKaMAuZNhwiSvA6eHPZmY2Ym7IpA1N
	K9rhhjJc6ohJk6ywOpUCF9kKeSjBTOYWYVIiIGos6kTR5r4Y4dAoLdqQ2LY9Ru5r
	zwz/gdCOoZxH0MoXoOZHPTGetwbOb5c03eb9CRSp/Fo77j66264bOb780Zu+Ol51
	0M19uc/59Enblsw1v++tjeMCkmug7pA3CR6Jipa+sHZFYftV5ra3EqUgq5+hhnxb
	C1rPd2YiuOPrbqOIWndo/mwXRPOid1I7yM6D1kg6J7MHmB+bBU1jC6JPftdzZoUu
	FixsR2BsQqpj+y9bV9NakFAwjgWW4BcE1zmxrThUqeImwyNWEjLw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921d1r47p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 10:48:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58C8kL5c032828;
	Fri, 12 Sep 2025 10:48:47 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013003.outbound.protection.outlook.com [40.93.196.3])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdepdhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 10:48:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vzWHoWYny1v7wSWbA7Op+k+ETQ1wPiPpEEju3qbobe9JJsxcjEc5cKKaquxYnlOTlk81V4IhzV5wr3mgpBUEtpLB6aXXpsUdJ9rZuFpJYBahqC01QFPfVT/NeSZoF3Lcyv5vJOfl8kYeGmUk6M5xaql/h7TKs7NMm2T/fHjwIgYTbVUh20Bi9HfjDY4d3C0bcSBDTNgfndWfPT26y5LeiC46sywQTX4zEHPN1d8dVwNv08fZgTdPd/mJMrnLgJFUjngFRXxiDNJgh8+pPwsKOismTnQizOcP2tCXjKx772ZcVyVVFRFlBfe9r2usnYHColiR/ijmNT9cxTChuORlNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbAv1lA46EGTfLVNOwv30UMBOhNtokxKa3DnlczWnas=;
 b=juBYQKYP1VGCGKg9ifPb7APqUf7nnEQCwBUxR0TnfPc0MAPzF8yZjVAam/8HzacMfCzVrSInNdywnLwozy+GK8kyZQ/Sc9CIQ2EtsbVsY8o60dFLidgR38CH73jsYFT/bYJjIY6QOi/1ikL3XI45sjoj30F8yoE4dWZbklgnofMEbh5A0gIyYpPyHYNtZw5H5742HS21ecotybIpprFSgkFkSKHDPRwaE1PeYaX8IVi7BPYFX4XvbKHCn32nctCt1TiHKR/9PABMYr6jHZt4ZQsVawGXNMTlRm1KKUuuRrH+lV5zaNMKUeSsJH76JgngD3DDF9MveUttWlH2+pP5lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbAv1lA46EGTfLVNOwv30UMBOhNtokxKa3DnlczWnas=;
 b=dTF/LbDpCN/ff5bAMnf2LH8kMcl1oHUd74xU07UmJPUS5StNRoFqW4stTs7q3GzxmFkT0EI5XzitEkEo/rsZuuIRuO3wPuNdo5Q5cZFRSEiylmOW97k07+oCQtAjdRol0hVQ29G2QjcNpFNbKydHcW+mNhZXsSHpYHCE12T5kEU=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ1PR10MB5979.namprd10.prod.outlook.com (2603:10b6:a03:45e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:48:38 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 10:48:37 +0000
Date: Fri, 12 Sep 2025 19:48:31 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] slab: validate slab before using it in
 alloc_single_from_partial()
Message-ID: <aMP6f_fJ27flhdSq@hyeyoo>
References: <20250911-slub-slab-validation-v1-0-8b67eb3b3dc5@suse.cz>
 <20250911-slub-slab-validation-v1-5-8b67eb3b3dc5@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-slub-slab-validation-v1-5-8b67eb3b3dc5@suse.cz>
X-ClientProxiedBy: SL2P216CA0130.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1::9)
 To CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ1PR10MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dd3cfe0-95f1-4da6-c0b3-08ddf1e9edb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ey34jgy8p4YmhuQUu2Ho8EnSjoprd/1VlcroWHloEyA9KWLcWK44NDYySuY3?=
 =?us-ascii?Q?EbT0LKLfdNSFXEUcuXXxD0d9kGCcwNo2drApwZNBosc+y1p/TKxJDLK3e5px?=
 =?us-ascii?Q?qj6tPY0uejvwlmbQvi9N8ngAE2G+zcJQkNDmG9gwRMO7Xk8N8zFMZTJJI5HW?=
 =?us-ascii?Q?iAfHBtEWlXpOWZPgtUp5Wd0qHFcsApxNHY2iPTuvixlhstyDQff2LJIXdREH?=
 =?us-ascii?Q?IspaI6fizIjyrnjOJotCKoaBKEJSWr57uFkSmzAsmkZAUwnkYkCKg/9sDvI9?=
 =?us-ascii?Q?dUd46Y1V76EzOoiQ7/P5BIzd+4bNMtO5YVCcp8E7xinpcwzeTsAiX1B9EJDr?=
 =?us-ascii?Q?3yBydzlymGSu6ckiE/h/76lFGuc4EkNgIQOjSTy8MeQE7kZ2oxlIOihQZvZU?=
 =?us-ascii?Q?5BN9RrUu/m3eyL1gOkT3Eak/koopP/3ZcP/mckMJNPM2CXYDeqop2czbgCu6?=
 =?us-ascii?Q?5ibO0d8OvRUDBRmf+zw02u4yzQR/SZqeM026wdQokBCavdxNVtUN9P14VwdQ?=
 =?us-ascii?Q?ESXH7YtNesYhQn3lKF273KEemVrul/iRjG5KXObYtpq0Aqcfib2c3thRyGyC?=
 =?us-ascii?Q?APK4KKOOWwBG4dSlhBX869Z/vJopr0EIHDKlldEWj+JINqeyvbxKhsjksI36?=
 =?us-ascii?Q?Lv2TIlLGsZZeAuxAaOBDV2NuKD20hK75jaXxWoc7x9ejTNvNKYbbTLrwmil6?=
 =?us-ascii?Q?V6bZk4okSiPD6v3Bg6A5Tqmf9cz8RpMDkRZYfrIIdTuIE64BEcI1NwkecY1H?=
 =?us-ascii?Q?S7h2N1rg6CboosJM6WWylaf3+hwDWwwO0pn6nUCl1V9DMKLPAU+Aqu5s4c5M?=
 =?us-ascii?Q?bfS1wGZ9DMcp8q+W1KH2jrxp0SDTa70wcRq8GinWu0UYaoBvhl29Im76NpED?=
 =?us-ascii?Q?RiG5a71A2RzpfkP0u4+dVDSEzdKw2lVUHAd3BLotjRljKWGkkd9t/tHnrwKD?=
 =?us-ascii?Q?eNOuwAxpuYySX2aNhqc5WNMtct/jVpddzsbSMSRxwuBMi8qH9RueCJ0xrvzl?=
 =?us-ascii?Q?hSZxr6/j8rqgRrbF27+QinTG4JlsAHReYnvzAg6xf3iqWrJz53LEc3wLjwTh?=
 =?us-ascii?Q?0/2ZheLHfnXxMpCv6dkczsnMVynqciS9FI+Yo3O92Afbbwz9IHIUiuHmYuFf?=
 =?us-ascii?Q?ekET+yKTsrOwjYRXm6pTM+nitoUSqVh1ql2XDFcwpnMiiBFr+wumf9XMiJaa?=
 =?us-ascii?Q?v1qfoHI/P3niEkJW2aWStaHi6now1QM0TRf8DFg8UHD8pjeBZ3aNydObqAmp?=
 =?us-ascii?Q?ozKREjMBSCdHOtWgfRZcj/If9qDxSnONicwjngchO5kDwTlkrmXJnggRgXtC?=
 =?us-ascii?Q?Q7+1DIH6iJZ2DQVIMAa4gShfzYEilMjwBV3Fw259gFkCW1NN6D2GU94T3wxa?=
 =?us-ascii?Q?RgMBc2MQLyOw8Oz5yOue8W/z7Oe4Xr18lU5M23lOqeZhSJi3J1XvGtwexiHO?=
 =?us-ascii?Q?9J0NywSNitE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mDPOYgF+bCtpv2Gn12oVfzwn1Oj+9ieqnLw70ANqcsdf4TkMaVH0qYA9S5TZ?=
 =?us-ascii?Q?aTDsLLH3bOnNKCWJTawMnnaOJX2QHahB95tMYhzBYqRtrF37HGRzIb/gg4Gb?=
 =?us-ascii?Q?aUQ2BOk2JSzkfl2Z+Be60IdQM54HmxbvYu25FI23lmIThNfnB9GgYwYPUllo?=
 =?us-ascii?Q?0NcKruF1TkEZg4MtPofWXlqQ5VOFCnwk9QH4wsg7yciaFXCFJjk3u4k0coJQ?=
 =?us-ascii?Q?XBCc1lMCPGkzaI6EyeBmxYQHgjzANGW2k+MvOonOmwHVstobK0dtItr0Gyhc?=
 =?us-ascii?Q?Ci9gu2mAgDTwdFSWbUUrwsOgRP0HLZWzinWbF0xK7kwG5+CGkQHTMrXP/yPK?=
 =?us-ascii?Q?mCurg+8uINl2BUvWF7CV4gP7hZKd73NmobZ6SQwqHtLeFMynTTEgeLdUD1x2?=
 =?us-ascii?Q?+6RwYGC8FihVV/aIBzUVT9dEdWjcymbQCMQQFA+WM93JrekxkGpCJYLfVzCc?=
 =?us-ascii?Q?uqId15uGkAeKTcqayRS1cpZIkf6bHj6uvtE6tAucNZrh32LwCUDDIJZBOxcp?=
 =?us-ascii?Q?64QIh1tgvaLni6W2iNorZSajVvRnFsf/PYplMm3ZjP3hUcv2QULFV9z0DJXF?=
 =?us-ascii?Q?pudbEkmZMWzwGu8VX1F2S1JEeQunpsXebc5zCIuJV9fC4lHGmqzQOSzAiokS?=
 =?us-ascii?Q?XGFuxqcH5MxY9lXx7x4iBoE4IV4JfV5J/g9qllsYfPUmAZvxsqyUEsHnbZGq?=
 =?us-ascii?Q?HhoG5O5Twf2KFEsWP9rX3kNt0EyxjH7MBFAgZT5YrNWA8T9kORGEX9jb+So/?=
 =?us-ascii?Q?nUzhhTaiNlcQlOS3wHTfyfRwt67xScYCBJlJXdI/9kiIYQaaGYmaQEa0bltN?=
 =?us-ascii?Q?aDeri0+Z4TyicBYLptpn/DkpeP2szcbnJHLYe2iZLlfwnul3brmPa1MsqfMs?=
 =?us-ascii?Q?e9yOprYKxPGw9sXKMm9x1H3vbd4zKnZmmvLobg3ARjqOJ/ko+m9YlwZSRA3U?=
 =?us-ascii?Q?oI3CnT5jebSb8eVL+q+RtgO/iiUzvmwPNagpw7bYwLZ2nTVFBaH7QGfmjyWw?=
 =?us-ascii?Q?7kMp7tmJEocwO/7YU8ylYeZEbrVyW1JYOYrIZOdIerCN+NJG+ErYt+UwUJS8?=
 =?us-ascii?Q?nTlr81ihhCn0wAFNMLkkzY1E3y5j3BHeH90msIKIE9v8ZtJcqlqBa5E6J/8h?=
 =?us-ascii?Q?natS/N9cvzHpYAMDCMB6it3SrgZLSZna5DJejICuh3OqtzJ2IvYLAmIToJr3?=
 =?us-ascii?Q?yWddiOd4Zj4dYzM5XZIG5J7HTgVCbHq+fsJ5GUcXyVG+eWJO3HastmOhI80y?=
 =?us-ascii?Q?EKO+xYsyoViz/V/ai4fEMmTSyk3wEMgscHMx7FPpFIkY3oFYvjrYE3dkAEXa?=
 =?us-ascii?Q?nDdB7JV9AOsqkWNzmf9czb1H4hhpsx6BWoZOfkifSaKH0wT1Iio0FJ/976Vu?=
 =?us-ascii?Q?mi666dB+R8VkejtnjAnL4y52KJVT7JqSUPz8Ko99oBmRjkOcpY3UtDuzXLKj?=
 =?us-ascii?Q?qRYD+r4H3gBzGrZiA8ICd2o3dILAzSCrjQG0Q2T970bgRpk2G4gPhkQSbNWV?=
 =?us-ascii?Q?3TmkCGBNyGsCDr/1XA4F7CJoB9ixZeTDSBnD93/ONEttGooxZ2yuJcz68sAX?=
 =?us-ascii?Q?2KxLIqB/z97Kq+bKpMl0DU9DLN39CktyP5+qTYdS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mqhq5SEXsSoSwBTBVKPNHBLGebktAHPUdlyVzWrQqL47AQqlMr/UxlMqnx1dSME51GcYWFTXv5tMfENirocELSTzY0mnc77YZ7Z8tj/FNbvMBz51LuFAIC8//8c3oorq9aIC5KWmUy+Qb7RF4q1J60arcL9Ik0xFtZaY139Nn1xC+ryf5losVyEn7YQly7CucsQz6icijmJL1RMaVbJi+Nb2eedVu24+FGFwNsOpSf8dTEfMJtlck36e0sqvps/9qy0ya8kH9rh8qiNqra7E6XZ5FEGOfgUHk2QOIDX35JoHV/5fXCfsJCn7/suEcuZlTAC3cZFmFf1TwywSwM1mJrVCdIYb2P4n54Oa8/ZHeVjp4cMYMUAYmbK9ZouJFFXqToEWftrchlG1pkgAHHLgpfuLe0VdqtPu1JzOws7agviCqTzzrk9B/mOYAB5p4NKg0Rsr00YEa0YFwslfQhYZC7uWUMHqNH8PBjA/R/IDYjx7/gSh3uM9IhpYTQBwkOtOGW98S4VXGi/QtSvLyH3652T7BYdztFRKGx6eDJEx4dLQ8uOtQ8MUGtOz7FSEW7rEzB/k9/b6WGf2oUG1qcxsD6Z9X7ToLgFwBdjtHHd/2x8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd3cfe0-95f1-4da6-c0b3-08ddf1e9edb4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:48:37.7939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DYJ0ja2OfpP3BpRr3PAFbR1RXExHaThnFto/JvPAzfO3Fc8czPK9r75nziNIn0ywUOOTsySZP0z2gaiJWIOmoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5979
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120102
X-Proofpoint-ORIG-GUID: S-YbzFGrGkTrN03SDwhcr8hgBz7AV_gn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MCBTYWx0ZWRfXwnYklj6yOktF
 d+zJEHz3R6OP1apvpfl6AXY4t3hzP1QnbAxwufbTRORgSxA7RjE1GHcZqpRmCQVjGIsC+eYAKFY
 aOtEtDxc4vydCVkEhHr1AKWSo2KuzGIa4TGkvrjpf8J44uh7M2VvbNX1mgQiIGFf8iZivQYYxSL
 Vjo+HmiN7qL2XPwA/iHFzLbg/Eec/POB9r9vZRzqiSiNUWmLD0gOitkVuHKEeRit8PMY+Zu1C2w
 gwAP+WVRy5gUEUtygJ0h9q6vHBP27tGgkeJDXp1L1slIVoIj7jcVh2SdK9m24gSnXI+r+UWwqmW
 DQmLqPTTk8/xx0RQ0A00+LiC5QXmDnMT38VZooJqJyDJb+7nFoo3xpZpQ/QdFaCXr0/xQgl3jUR
 9xzX+h6g
X-Authority-Analysis: v=2.4 cv=d6P1yQjE c=1 sm=1 tr=0 ts=68c3fa8f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=j8R8Cj29S844qgnthlQA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: S-YbzFGrGkTrN03SDwhcr8hgBz7AV_gn

On Thu, Sep 11, 2025 at 07:02:38PM +0200, Vlastimil Babka wrote:
> We touch slab->freelist and slab->inuse before checking the slab pointer
> is actually sane. Do that validation first, which will be safer. We can
> thus also remove the check from alloc_debug_processing().
> 
> This adds a new "s->flags & SLAB_CONSISTENCY_CHECKS" test but
> alloc_single_from_partial() is only called for caches with debugging
> enabled so it's acceptable.
> 
> In alloc_single_from_new_slab() we just created the struct slab and call
> alloc_debug_processing() to mainly set up redzones, tracking etc, while
> not really expecting the consistency checks to fail. Thus don't validate
> it there.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 909c71372a2f542b6e0d67c12ea683133b246b66..93df6e82af37c798c3fa5574c9d825f0f4a83013 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1651,11 +1651,6 @@ static noinline bool alloc_debug_processing(struct kmem_cache *s,
>  			struct slab *slab, void *object, int orig_size)
>  {
>  	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
> -		if (!validate_slab_ptr(slab)) {
> -			slab_err(s, slab, "Not a valid slab page");
> -			return false;
> -		}
> -
>  		if (!alloc_consistency_checks(s, slab, object))
>  			goto bad;
>  	}
> @@ -2825,15 +2820,19 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
>  
>  	lockdep_assert_held(&n->list_lock);
>  
> +	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
> +		if (!validate_slab_ptr(slab)) {
> +			slab_err(s, slab, "Not a valid slab page");
> +			return NULL;
> +		}
> +	}
> +
>  	object = slab->freelist;
>  	slab->freelist = get_freepointer(s, object);
>  	slab->inuse++;
>  
> -	if (!alloc_debug_processing(s, slab, object, orig_size)) {
> -		if (validate_slab_ptr(slab))
> -			remove_partial(n, slab);
> +	if (!alloc_debug_processing(s, slab, object, orig_size))
>  		return NULL;

Is it intentional to not remove the slab from the partial list
when alloc_debug_processing() returns false?

> -	}
>  
>  	if (slab->inuse == slab->objects) {
>  		remove_partial(n, slab);
> 
> -- 
> 2.51.0

-- 
Cheers,
Harry / Hyeonggon

