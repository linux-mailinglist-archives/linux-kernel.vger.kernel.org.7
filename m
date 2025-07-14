Return-Path: <linux-kernel+bounces-730415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A791EB0444E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175203AB4AE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E32E25EF97;
	Mon, 14 Jul 2025 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gitm15pj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xaRo6QzL"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999D926B750
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507183; cv=fail; b=VZnnUSzQBSEpE2Agx4HwSLe/j6fPKAOEe5GyGcT8JR+EsCZMcAJ3LGwgX+yHcE1nqRl5w5WtzdBNCV4EMWIYOWacNTusTc0901fvSgrzF0irdKH0vacuH+xJjMs9sGTQuCUe2bVvjXqWd0qiLLoe1fzelTGBba83KLfov5gsc8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507183; c=relaxed/simple;
	bh=UwzEV21eSe8/WrPdX3S7bJrMtLI/MKO6oEvoh+b8Kow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p1+X/O2Px6GHsIXz5Wwnx/6I+XY2jnk9Y1PBp99S3oCbWauuDnXk7RCNxpWe4Y35VBMboUNEUcwGgRG4GEpKu07f1FQdtPFuCfZ516F4FfFGp1TufdsWsSIyyS11QEt3dtkpWLimwGtwqeNp/tf8osPFPfUvhiBgN9vkSXomUCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gitm15pj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xaRo6QzL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z5FI031349;
	Mon, 14 Jul 2025 15:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=orMkACIvoFs2NUcFKM
	ufXVV7vqBZdpf7PM73Ehdwwc4=; b=Gitm15pjmSpYGgjHE1cgbhUA2r497nnkJg
	1U/sWanphUrlizYzSNqSsdrBJtZnuh4n689vPBILW4wTHAMhyIN6xNOcNJVgOIum
	wIcaokcticp/PNjRx0WQfmaC3E3wgHcYfNDSJ9DmyyU1utVbHexdSMqhN5eg/BYh
	jdMuqysLUKTMKZu57flouZfPNdgMc5GfK65mI9o1p54s+VVLb1J6cTKdJK1zEaNr
	ISNYf3MUMrQPngEA1aPLjdAxD1yP/+N5x3ECmYQtpH622tse3pJfOGMQLL/WHfLa
	VXd7tlG6BuOkJOMQeP+I8Qgu+AX9fLSjMWn+uBcoWz21dehc3YGQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4mf9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:32:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EEb2qs030319;
	Mon, 14 Jul 2025 15:32:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58ncph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:32:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1L73JToLxzHhiDl7XvVhhzQDqM4WBkCWlnKYWRolydO7vVxvQRVcsaWUYrdn2mU1/5zDaawwMTrPguoWY6ZywLCgGsJeZtjgnMQl/I7927/QRlfjddozGy+kYQOUrFDtDFt4OLuk1U/tn+6oxId1YkKbeQDHw9JVEodTZXZRrGMjyNL5eEJ9z+6ByeGsnMGJOalpCMKcTk1uiGwQqlyCYq97kqJmdeFMewveboIuxHovJQhKo6r01qXHOjfFM0o3icMTAIOumgtv6QrD8NHFICEKdJVcIeuyc+2uQv3juHgt+WzoIC9Bku+HygvGmL37RkYQ1KGpXC2PTaDWmqSAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orMkACIvoFs2NUcFKMufXVV7vqBZdpf7PM73Ehdwwc4=;
 b=bxhvelUXIy0R4BS2YYb2PIcpRQzWN0T1WWouQ6xZrMHufo/4QvJAUfAsQNtno0AW6KY67yPMM8RI0L9CXSxXMT1eT/qGKwNhAD13j39o4zydVVzqMXREhiB7udbrAdlHUdv2Ekw6H6n2LVq79NEdfFLTW+TZPIBlvN2p4cQY5fiLsUYs2cx5J68JdvHI+k3mYmOcgrjoPO5gnvyh0Uwlz/6e/kBCrTpyM7t3XmaqKmOed9RzjRtbyNaaWPCK57e/v0szpmAJbOJFkD61RtSkiHldNiLqb+hr9Qv32eZN+bflCFLSAnBTnBPpaslrZPsLudEtqSDtDfHnI4Rj2Ao74w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orMkACIvoFs2NUcFKMufXVV7vqBZdpf7PM73Ehdwwc4=;
 b=xaRo6QzLiwcfWzlNgDCzletRuwItudFLcgyEBBTIYpiYioVFcqrGUG9Ig7pV3N1Z6q8kTb+Qb65oUw5b/acRxSzieVr61ATj55s/JrLGuur/aR4eiD4BbdcqsbNmcJQliU96XCwjidj+hPGud+BbCkVp4eWsFmcY2ezHP3UGN7M=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by IA0PR10MB7350.namprd10.prod.outlook.com (2603:10b6:208:40e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 15:32:43 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8880.015; Mon, 14 Jul 2025
 15:32:43 +0000
Date: Mon, 14 Jul 2025 11:32:40 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH 1/5] mm/mseal: always define VM_SEALED
Message-ID: <lfobd3726nr74z45yvwt4h23b2ar33lx5sxsucm4wxqpz5pc5e@llqheqqeddxr>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Jeff Xu <jeffxu@chromium.org>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <f6dd43a1111677145b815b31bca8a04db0862c53.1752497324.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6dd43a1111677145b815b31bca8a04db0862c53.1752497324.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT3PR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::26) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|IA0PR10MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c619e3f-187e-428f-bff4-08ddc2ebad0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9ZK2ZeYxLhCqKssPLJLczPZKtH/Lx+ud/q5nGq1lluTl7ZeYcVGgUitWk6sH?=
 =?us-ascii?Q?QSYEi3gLg3OH3H7eg1JAAshIOwlDjCBMLekOYg42ryYa3Kjch3Au3vwwPvh6?=
 =?us-ascii?Q?fskIuUv1l6ChO4SDD+ANEdoy7kQJdXMFzrqToyAsldFwE368bO9Ye/HUZWJs?=
 =?us-ascii?Q?Lhl54CkN2VzIjcwVWzMgj7UpiGd36geAB+Uaoet1hQsoZxXHJ73WxPiZe5gh?=
 =?us-ascii?Q?3fpz6fgx731Z9TCf+zbLAuXrxlyBFR11NnQ8kGyK2hvPNTLOImokA+NV3Bd6?=
 =?us-ascii?Q?v2KutKmqlrxVyjhu2G3uWGF4xLH3G+heSkQv4T6GW8MNFtRGZyDPBL9RMNN5?=
 =?us-ascii?Q?86GoCAC+0MR7mw7kXqcf4hVjTOXzkhgqD5tHzq26kcKDJvmCyuWr9P4+hBM+?=
 =?us-ascii?Q?DXjDZpfrlTvfecvtTCzroYBOzxo08d5g6xLKDhgb/jrHGB1Phyy3W7YbCChI?=
 =?us-ascii?Q?gbKC4a8FZTZ0khsNkcSSrxHwchX4+wErswBPOTwbt1Eug/dKwlKR2+7yoYbI?=
 =?us-ascii?Q?nTZ47jGEJUdSKjYmY7p2B06mirHgR0ZOIWzm0NW1SHxozl5M/Ic2hjV0awXz?=
 =?us-ascii?Q?/VwZsctLNpz7o+GuofGJktUnedr1NkZ+2b/03QnaAoQMWBXrY6MC6Bw1PDrL?=
 =?us-ascii?Q?+C91RJRPtiQWUCbAEo4ebfKHf+AqGhspjPUjdvhmAbZXoEN2JnMGG/yZ7w0d?=
 =?us-ascii?Q?LytEV2KDZcO7hwG/LzAB39uK+eVUb9SVYTGi1SE6N9mUBMdCoRM/Lwct8UgI?=
 =?us-ascii?Q?c/dyHaWF/nxSpWVRxcMP1sbUkUUTWeEM5M82gxK+LDTs4QAWcZ5e7Eu0WiSg?=
 =?us-ascii?Q?YxATfmmTExIo5zC8MRd1shT+gpbbCRVZOb0BGPp2gERbE3/xJKKz8jNCNNV2?=
 =?us-ascii?Q?fOgS2hltGryzBY6PoG7w0iM3jCdeH/4ukKv568EY2vLs4gEJ04WZCQUzHkDl?=
 =?us-ascii?Q?w1FpccGS1Vo07KAnib1Id7Ku2qk/fFqyxL6uPHknasu+trhMXeVZTb8hiuE1?=
 =?us-ascii?Q?oxMDYb+uN53ZwkVrbiX9Ss3nhc4Rqk9DYe/fOwpqiHESfOBsSJK6pi7qfsqE?=
 =?us-ascii?Q?YeFECd4299Bv8/o31/RH6H2tkMeTm5/9rNAxom5+O4P8qXYgxxio9gEmv5CA?=
 =?us-ascii?Q?oDvqW0V1VI0ZesO/FND2KVtjv5GwYkTYhaKmi9CvrZa1sm7C66IfYf3ZRx8e?=
 =?us-ascii?Q?lVxaqv8UqVigd4HBPunK0S2oeLVquQmCtfU1pyzu0hdDI2DFroVdq8AQqFNk?=
 =?us-ascii?Q?ugUJyb6Vzlr8F99VPl7TT4jOCd6fsiAtwJHOaIT7jUgcX73Y3BeYTwcZDTAH?=
 =?us-ascii?Q?XLd/BpiL6oBOm5WyYe3JKl9mXo7A3XBIA0lH6OndnRd07X/iVtWHKkxJ76jY?=
 =?us-ascii?Q?RzVyf2NFOkkkbChn2Fs3fDbR/2Ay2ZrETXllUqoEzLAzg1kEZMZwM5zYNZ2L?=
 =?us-ascii?Q?KIPowbLuT6BIhe3oLxkfVOQxg7LGTlgUcJZLV+BSUSvsDeqyE4ZK1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QF6ty2URBk/4kFMg9NXvXe0Ua6AGTlva3yHgDIS7DxyLm2aR85SXFhcYvwhd?=
 =?us-ascii?Q?iBp0lC9xjHIGu8JU6Iyslqaktmw0c1tx7IzqjHf9lY/wnpbzQ1GDPN6QaMqg?=
 =?us-ascii?Q?tsg9L9WnKRDHH3FTU5BI64HWpJydMQbiEGKh+vPRLbBHnxnZGB8DGg0lpTrd?=
 =?us-ascii?Q?DTDc6uNNfmsjrh/tJbYE/d8UHA5KBDT9xkbVdEAjftAsG1KsXTMl/ZIuwJQX?=
 =?us-ascii?Q?Ut53K391aRIZrchyZy7vZoBHxDCIVJ1X7VATI26gbn4DP0uTUV3GLSUVZU1j?=
 =?us-ascii?Q?/lEPWrWxCZG8qG1hI625xWsKVMMfvqbX7Um2wM8V+NrSIyW/mcyKENBeg787?=
 =?us-ascii?Q?sWafkbM1ZqV136kypJy3YVGmr3envMPiBdhzva40fx/tlHuWhXmAuE7A33d0?=
 =?us-ascii?Q?Ep8OzGJk9LYVDgpm1u+Yoojez4gaIBZUli6LmSxa2yKnWR5FVSXZR9WUaBEl?=
 =?us-ascii?Q?Ckz2m3FNwg3aMEIAG7T6mmNSG7gMSjhmfy3LbHjjp/fEZ1scRiWbKe2QjU+t?=
 =?us-ascii?Q?gzf2sMWtcHlkU3UIWJnO9QLvDCSDEXNFxqI1ZYwjUcpbv177pb/wfOwPsYEt?=
 =?us-ascii?Q?tkHWruvKwTnKEf1cVGnQQvcS0qwk/DAUNBuCvtwjWINTZw97bZhQYuh13L2A?=
 =?us-ascii?Q?5V/q19R0zFtQLh+OBuwg8pRB19dFj9LDl36GkcAWWwsQuv0Qbew0P5jyAdrp?=
 =?us-ascii?Q?jPf4tW+5pQ2DxuitUkjWwj76Wt3gBx8CiPqTJfkI+1ssB02m9rsX8byoDigQ?=
 =?us-ascii?Q?6od2HL/JhbMiKKxLhzrcpkqh940rz0m+zz2ZIAuiTy6hHkeSh+235//WA/cM?=
 =?us-ascii?Q?NUoXVi7F/RU96RMQP+jFCDcgcg+KFsXEi4jiB4jaYjqlQHw6bHGHgJPN4TBX?=
 =?us-ascii?Q?v20jfRG3JfFYG16G3TgDqiFqlOxwksLKa5slFxM+UPIGbNt9F2DMwJW+hC38?=
 =?us-ascii?Q?XyLbtTomW1WIFuW00QBUL007KbKZ+zVXuKJIJ5LOFltveDXzEQmkmcsdvluN?=
 =?us-ascii?Q?//QAYRr8sUfkEgDTwB76DUs7Bv7jFPK7z4fpuooVQELiWRugO375AadpUNhl?=
 =?us-ascii?Q?ozBxTy6MoVCjcGHxP2DycEocOkBfkIFaB6HIztKwcv0cf/lx+63iNR6OOtlR?=
 =?us-ascii?Q?pJNj+N2v3fh1TU8VJwk1FcC5q22p9shyuPLNffjDmWoRFT171yCit51beNlC?=
 =?us-ascii?Q?SZ7Z/nkWgayuosJkh9D3lrri+alT6e1FTwycacM+T0Rx1hPswclj08K6J4IO?=
 =?us-ascii?Q?m47iqm2bIo2CkfhNLdL5kDEgOZJWT02XRqsf0Ny+bKU1hwHmkiYW1Pe86t+r?=
 =?us-ascii?Q?psxm2OpHuIatvxQBz05ZmGrkKxtS9d60wSwPTftY2EN1H4hZ6vjnbJdSDlky?=
 =?us-ascii?Q?UYHqtbK7IJLXuQ7TynXxdC4RO6X2TeAfwJnIpcNuBPx+kV4xSXaRuzrrsdtQ?=
 =?us-ascii?Q?JopJef2DLikoSMCBY3jFOsipfkFfwNFor/WBK+ssxKwPCA4V25iwqHuE8VVO?=
 =?us-ascii?Q?mJTkfyZ4AOd47LUQrt07M5dfismoREmVGYg1urfoh0JO82zNN8bXxKx2j8zV?=
 =?us-ascii?Q?8F5WGE5AzLQIht4XuD1QkhFTRhf+HEu5hry1qPy5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rrejMhGmt2F/vuhClZ2bZZdicrj/sejBAGrtjikwIPmdhuqUc00D2w/9HjoxILIWcDuN7Cre81GxzDD31zOFui1fcQJrJ9b8GTTaHr7lzsoHRJ83RR2saoEAJ1Ou5iEJ0jbPdK9Gkle5TkkygdF11aqA5mpiW2laQIbnlMyMWgDk82ex07oTjkHBpm1iz5KeEzvBMy4IJPyoPJg5FVRdM7hOGBktRoRttWgkV6Xrr34d2/M8+XObWJwdYV+rdeIy6wrPHeHOpIUpNbWmNFDmw0X5azvLRkGNIv80W/MgsNHqLAnDspCkulWs5RHbVm47gsNQG+itvkFjC9t9LwOhJJf7bVY8wSSjR3jO9z+v59Llv8A4vz9x4xGgVU1Z8PLuXejJwL3cKgYONmPd2aXxlOnC80hy8xr++jG6h5lETOU+3deCm4hg+eLS/aw+m7OnRj/MC94PVKhOSkscTV/fBsFHOudIQsSPQpDd/Ql0G17zPvBVk/vxYNbsJhGkG4pjBRZe/k1ATr679/sgB9L9duTrO6/GGYii0qDRrSkh15dd3bHMth2gy7UYkemy41/WAeMe0eI6PNquD5/tG3Q+KLagWrV7INgO7uvHujLOuEU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c619e3f-187e-428f-bff4-08ddc2ebad0d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:32:43.4190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRXKt9l9KEGpN9K+Rn4vXaxFvjk7qZmpWmEQmapG2WDaV/xBExTGWXaxHtTTqfZifP9lskyEaHiFxX0TVBSC4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7350
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507140092
X-Proofpoint-ORIG-GUID: dO7UPJThUmurAO-sp-4OTKZn5HW4hhIB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5MyBTYWx0ZWRfX6EG3kCe+kk8Q p0d1mxDrw9TOpRwAzYHFb47Ws2Z9bjFf9Bixkv4ZUgznCS63GBzFi7+0oFCuw7d1dyWsPq13xOB 4gnibceeOcj46Zu9hXU8n8ws0v1rLOkXz5w1f8SbS9m7co9wYB31Us6CidPB12Z7R7NRz2G9Pnc
 42Ke5Smy84wqScYiLBc7IPSZ+KMaI3l8RQsDNTbcciWkHRVCJI2JtHGIFKlhLWdVRuKEvQYWJaq Sb7O9IzwNAoKzMLW04ZXLm3fLOp5AALzzG4+WdxbEcG9dC9PwfSpGw7wmJMTNPMmCH22iNQ0xbc E0tGjCgoGF06TTgwXIE7IAss0+FzzZS/AJampX0s5zLnbZG3cSEP+yYz55hFNZFDK646x7tZW3M
 LaWvcJG2CmjyANq0ftJd4hMEynC9mzMrINIa+wieCt/8Ofd4e7iFlm6tTnmt4AaBbWzhPKHd
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=6875231f cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=M2nniEUejT3jo-J_yr8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: dO7UPJThUmurAO-sp-4OTKZn5HW4hhIB

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250714 09:08]:
> There is no reason to treat VM_SEALED in a special way, in each other case
> in which a VMA flag is unavailable due to configuration, we simply assign
> that flag to VM_NONE, make VM_SEALED consistent with all other VMA flags in
> this respect.
> 
> Additionally, use the next available bit for VM_SEALED, 42, rather than
> arbitrarily putting it at 63 and update the declaration to match all other
> VMA flags.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  include/linux/mm.h               | 6 ++++--
>  tools/testing/vma/vma_internal.h | 6 ++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 2e5459d43267..aba67c3df42b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -414,8 +414,10 @@ extern unsigned int kobjsize(const void *objp);
>  #endif
> 
>  #ifdef CONFIG_64BIT
> -/* VM is sealed, in vm_flags */
> -#define VM_SEALED	_BITUL(63)
> +#define VM_SEALED_BIT	42
> +#define VM_SEALED	BIT(VM_SEALED_BIT)
> +#else
> +#define VM_SEALED	VM_NONE
>  #endif
> 
>  /* Bits set in the VMA until the stack is in its final location */
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 991022e9e0d3..0fe52fd6782b 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -108,8 +108,10 @@ extern unsigned long dac_mmap_min_addr;
>  #define CAP_IPC_LOCK         14
> 
>  #ifdef CONFIG_64BIT
> -/* VM is sealed, in vm_flags */
> -#define VM_SEALED	_BITUL(63)
> +#define VM_SEALED_BIT	42
> +#define VM_SEALED	BIT(VM_SEALED_BIT)
> +#else
> +#define VM_SEALED	VM_NONE
>  #endif
> 
>  #define FIRST_USER_ADDRESS	0UL
> --
> 2.50.1

