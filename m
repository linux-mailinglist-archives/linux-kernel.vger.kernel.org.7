Return-Path: <linux-kernel+bounces-721712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B548EAFCCF5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C2B3A7E92
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECDF2DECC2;
	Tue,  8 Jul 2025 14:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KFhB4vwe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NL6qZjno"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD632DECCB;
	Tue,  8 Jul 2025 14:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983596; cv=fail; b=IYoTdAAEx1W7Y3XWeVXhjYDkaJf02kyiO4Wd3mRVi1Kr53rHkJU58CmEBoYIM8jxd1a1FQreCscuwHyUi8ymG8WEZCPnInNMKTQqOGY7focjelmHRRS/wl+H0rruo0PfaDgCtPa7BjZhSuZLQdiXY/BgagKgfNPms70ttw3EEz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983596; c=relaxed/simple;
	bh=pwtBdEMslRHqueurvuSQMM5SzquHN6LEeayIozpq8e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Up7ZKSowsi9t37g3jjhRgwbWwNpM6wkrgZq3J9D3QfhzkoHQxRsvHWV0fasyTMJcp1FwhtjGzf2qbJa75Ph5e+TZgNTlNEqWfaOKcMhQ1afn6joYYicImtnqkQkWNN+mSSY2NcZhu+b7s0KcHd/kSlMP9uI/odVmtYYt+wPQuOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KFhB4vwe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NL6qZjno; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568DZ5T3029610;
	Tue, 8 Jul 2025 14:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=sHfYG+DKIvO3EDkNVv
	cZ02TnxGI1PmUIDXfqjnc6+cw=; b=KFhB4vweIzwpCY/bUTQHVYtWfKtm4jztEb
	brsRqZk/mJ1UPlmHN0uNqiihLLuFQrIDrwaAZHOC22e9zwHVhaI1lH9fRYmhv5xR
	s1TRyXmTox143/X1KR+XoHYSA3pN4Af04vEdZIfmE7Efe/S3nLMRfxP+QM6pIx/u
	6GEjlIJV8ikWk2+tU/7gIIDAr4C+kPzCtzB1J3XqPD42+KfHuGy9ESVkPd+GR6EX
	hxww1Sj7XG8rgept+t9CMYbgGPpKi4H9eXLj63alZGY+xbxdF/eQ6ZMAQYExcsww
	fGuYEPHjCM3T5U7xk7Ni4mb87ZlUqV7jxA9ogAIrGVIj9+jjYQtw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47s47f84df-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 14:06:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 568Ch3sq014067;
	Tue, 8 Jul 2025 14:06:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg9ny63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 14:06:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLQLaopKjAQQ9FBtznv6hPHUM3ar++nNrViH6b8O1nlYCynX/sj1RAS+kni2AXul//CybQQhTUAPcm2+6PndI434qXBCViuu6f/ctNirWj0tRfccz77gX3BZw4DXxxZ/8s0Va1w+qqKDsOI0OuZGvyzdDzQUqHZo25T28PX4IW2aMyHLiqqEPzutRxufZd5i2B9yl+VZ1THl8S2fMNkrtFTY4reXM5oUBLjQZnEL55sRU+FlirW2d2ONQ+q2NEAgweSdoAKyg1PlwNf69GT8kQWT0U4VY6vgZjawiAPsgo7qc+xngw4yqC+jDZCQRHte79KvODDqwH1QARGcw25pnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHfYG+DKIvO3EDkNVvcZ02TnxGI1PmUIDXfqjnc6+cw=;
 b=U08cvAPvFupEP/6ngvT5b85lXn+I3+B0z6iGNumkaz6GjJPSdmP2hEZzDPRmwCAeRVeD2uQHX4vD0xmFdFyKVjF0cDcN53HHOx3FZQ3Uo08Mc3QjYm+On03JMdMCZcRHe/DSWHUAKvisrvjBP25oKVi5OkjjFkh2Np0Zi+NZQlGO5Vjp3BJTN0N3xz3Nhi/Vwrv4HfUUlu/wdfyHXMQx+HEZW0Ap4LZPB0acXu9S/qaqI2K92Fe0HKcZm6h7nBDqkzJTNadVxjNvDFr/hawRGUFPlTLWoCEOgv7f1l5iXBXJGlvIiSDpi5i9BDdSEXae+mc8TjuX3J85zAY14iGVGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHfYG+DKIvO3EDkNVvcZ02TnxGI1PmUIDXfqjnc6+cw=;
 b=NL6qZjno2bJoWjnPifO23/4bqftO3EaJ+QkjK1bIjTLiwIstqHjNIRxoyn8RgUEYyWGlRl1TmZ70I+jzKz8OD/2RaWRi4K/Nsv66Q3oE6LuchIiSB5uhqx2hGOGDiIZwxaNLHex6ODaB6t8Db9IIfLx10ybBcomQgHaI2udny5M=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ2PR10MB7560.namprd10.prod.outlook.com (2603:10b6:a03:537::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Tue, 8 Jul
 2025 14:06:17 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 14:06:16 +0000
Date: Tue, 8 Jul 2025 15:06:13 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Vitaly Wool <vitaly.wool@konsulko.se>, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Uladzislau Rezki <urezki@gmail.com>, Alice Ryhl <aliceryhl@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, rust-for-linux@vger.kernel.org,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [PATCH v11 0/4] support large align and nid in Rust allocators
Message-ID: <07f871a2-f993-405d-9ffa-0c9a5f18b3d6@lucifer.local>
References: <20250707164755.631374-1-vitaly.wool@konsulko.se>
 <824065ea-1f5c-4cd4-9917-4b7a91882af8@lucifer.local>
 <aG0HJte0Xw55z_y4@pollux>
 <8a08931c-ce54-4e96-9e99-e7c696389dc3@lucifer.local>
 <DB6PTHLBMET8.2TN916HUP10X9@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB6PTHLBMET8.2TN916HUP10X9@kernel.org>
X-ClientProxiedBy: LO2P265CA0337.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ2PR10MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: d12d4b5f-a050-4cce-5965-08ddbe289b2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q1hPZORWBDc5cmnolx5mJKg2zKKt4De0cpH114xJ4F2RbLeD6iaATwAGIJyf?=
 =?us-ascii?Q?aZzRTwzJPWUwLYVH/LkF90ezcVe0YsN8oSx0woVb3IeMxaTPZTHps6Awb5bB?=
 =?us-ascii?Q?k+MoqmlvvTf/x/sdORwe5LIColF4MX7+VAtBBH2BOybhwcteycLgvRXM6SbG?=
 =?us-ascii?Q?4WIHo93jkerTy7N+ZU6WasjwPGKghBooBZh367mmY35SSyprDj9ml1qcqbFI?=
 =?us-ascii?Q?xxqGnig7iL+tZFAI+fyEqGZ2VD93wcQ83Z+f4Pzvg9qLqyYtsidVzr4YwBEP?=
 =?us-ascii?Q?95TgNp3CkOyOccjF1/A1jmVMPhSC35ZXZ/qDt4BbjjYKls17C8Bp0NT+ZTJ+?=
 =?us-ascii?Q?vDGuOK3RIfJ0xgnlN3PJIC1Mt1N4Avr1Z+T9PbYrG6im4FP4gLVMAe7FY45u?=
 =?us-ascii?Q?BHe54HRAlxoQxc8x0munLhKNS3hKE7yxUzMYmm6AKCD+xQEuixhkDqzW4B5Y?=
 =?us-ascii?Q?VIMFNu0Rwo4P80SbEmdQPGNfpfWjUA/OfHbjTS9xmXFxIHmfQH5sTnHXvOj5?=
 =?us-ascii?Q?UgTiQ5024wapxY+tGXxxdYrTxAbjb/LFMP5KjpY48dIeltsG4ys6VAoR4m6X?=
 =?us-ascii?Q?WLqnGBc8S4gQWrd89A7GN0crck1xdlSPZuxz6ua3GDPg1FRGqyAwt8BQfbRx?=
 =?us-ascii?Q?qf79CPSKNn3DvnxL1I2hI7VeGumvAs5zyBT0k8K3BbLLZIUiMvgRTHoTu7yg?=
 =?us-ascii?Q?2IjtfKM+Pxe6H5bi/iQzBeI8KJYgmYk8aawEYnJjHtnNLUK8gE1ableWEV4J?=
 =?us-ascii?Q?4dH0gm65OVQxQHGML7JixNKal40Nq3r8K2q+VTu1IwIh5HUyG+5s6QxUqO/v?=
 =?us-ascii?Q?/cY1S9NStKJxYFJ59DhgxCBGm2F/PYJkZC37cS9Pm0kzTECkqb3MouM3auh8?=
 =?us-ascii?Q?5YOp1EIepAqqTzqTZ0bqXQM/RQYLQRnaYqGLF5YZ1gDCfN0jplyPFJdUTs9I?=
 =?us-ascii?Q?jzwhtXQMLfxD10IdATpEzgiW1WnMTXwEI4HMmA4Ae3UtuY4zceH7xOV8poK5?=
 =?us-ascii?Q?HITBc4e7swjc9vyCbWQUKINEae/DbVPoU+EfwwKeHAeF3QbTn9HqEfhJJRmc?=
 =?us-ascii?Q?YupqbRhCuzNmCwr7IcomzR37ddx0SaF2TG5fEv/7OX/rBdyc8m/iqL3iNLkk?=
 =?us-ascii?Q?GlMc1uNl8F0s6LoTXPw9XcvxlTM6ys+Oh85+RZ5ytRwOH0gTy3eFnSyKrfKg?=
 =?us-ascii?Q?f9oDe9r6SukfYzR2Xc8EFsaeqPtO6QWXaH8EdhtWlBcX91bazC3/1YEc+gBE?=
 =?us-ascii?Q?54kbi4cai3HcO/PPGBql7bluMcpt035AiYrC5/S3a5Cf0TaTcOSAmp3/7fnV?=
 =?us-ascii?Q?c1weRzVBhT/GJ4t/U5Efm8vMqAFCO4XAlr+9HwMEsiBb0JCQLXDe5Yy9aRoF?=
 =?us-ascii?Q?TImUomXUCmC3aj+jLW5za1Pj3gn01xbG4+jwXEY73wtofF0LQkV0rqsdThNc?=
 =?us-ascii?Q?skLHoo/bGqI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d9w3XjD+vHDot3sYHjzFoQxtTkzPpfEYTM5L2S0tNrQ+699Ypih0pDp8W3wj?=
 =?us-ascii?Q?kCXp8WCUSHD9bIJ2amdjQjDGBSarfSXIhJdyZSkkAqTn1uVk9HuMpyJ8Ss+T?=
 =?us-ascii?Q?lpxsDrK93nJTVanwYwtGIPJK/0hEiq1LHmk5ALEfKy+Xp3MKFAcT4z3pNkc1?=
 =?us-ascii?Q?4pY2itiBFwy4BDKP9A9ep8uAkP6n/6j/LRwnIRV3jLB5/9pQW8LCEl6Ji8Z6?=
 =?us-ascii?Q?3H8/xb0shk7ZLT8qDtzEfgVHwUFrA7KU2TynYJ7tnxaJzxhZftAL/WYdD8Md?=
 =?us-ascii?Q?SWv1LdhltlAoXDHx5N526f2wfB78ArQs2J/PpEYQEsNUGZEAv0WdrJcq1LNT?=
 =?us-ascii?Q?PrF+jIW8eVM57XUc0k/mSse9LOiFbej/aglOf2pgA8uczp7kjmnxH8b2JBH8?=
 =?us-ascii?Q?uOBmmvSv0hd95BOgJgO+mFsT9U5NzdoRiwlTrcFBzhNqZJqOm3sNCdnlDfOm?=
 =?us-ascii?Q?p8+85RhbVBkV6IGFxCeZn2I9sFlcgPLO2Uv3Q9b7Z3vnV6budrwDUikVEPoQ?=
 =?us-ascii?Q?B5OP70m9nl6Q/dk8wCQO0UDcgNdU4osrxSDqGPM/4Z2LIAybGQL1a0eV6a78?=
 =?us-ascii?Q?EIJY05q3Cw6uWv7VpjRZ7BiDave6XZ8tnn3O5FqPPffUEeJ/aC3HnZEwdkuk?=
 =?us-ascii?Q?HlJ94e8Alxu3cTPWokOLa9uXzwDMyXAg7KBf/kp458MiR4ia1gNKG7T1fWgH?=
 =?us-ascii?Q?ZCKJISKxtlUXGKWt//iKQaQqbLB2qsc9bsGgSwKSVSfo8QdamQ0vVsGTNe9y?=
 =?us-ascii?Q?wJVJrfdbpNI4GJhuhXOsy7XJWSt9OTgJ70//pnLdaZEa80f214WDQ6s/AB4f?=
 =?us-ascii?Q?rxr+aCIBbVn9heiUFan1k+zJYys49ohY1/QQg96JeZ2gJlNIQLD9fa9mX4Ps?=
 =?us-ascii?Q?xRhW9gIjj5IcaQjdvTS3uOcslVO41rh2MShnV0E+sWemHyecUGvbZcLLNP96?=
 =?us-ascii?Q?sAM0vE18a/A6OFpVTVRadnV0yNVlJBDmyUFC/IX4Ff26D2TuMyAoNTvrDcss?=
 =?us-ascii?Q?uCArX4IaCNpTrxUE2CHPqAFmi8HLcCmlOLtbmOoUeoqwGi6LnJBCNxgu0PjQ?=
 =?us-ascii?Q?O1LnFoMEalYq2p1RoAnc89cSRtFjQM9aQRUniTdmIlAvhntybzrOFSc5LoXI?=
 =?us-ascii?Q?Q8RTfywpDaI783LR5CW35oIWjuL49z9rZ9Kooq507h1+MiBh2ds2A/f/uihd?=
 =?us-ascii?Q?4LmTQr00WEm3s5kGyGOg6ZTUwHXMlSuLrmAitD97sNeysnNVAXnVcQDuXFFo?=
 =?us-ascii?Q?zIBTxRfxRBK8+tNJfT4cLppjuZVjwNSN225Qm7oYyto3l/WJCVknRRuNSv0K?=
 =?us-ascii?Q?5Ac4Lhy7V/WvTmrXlswGwE5URTdOHozIZx5WLPPK9vuLqI/r0+HlUc9D5GqE?=
 =?us-ascii?Q?N67drC8muKlIyR5vorE+fiSop8qwjOkt8PpRCrh8Xdit//hd3l5YxoPCad0d?=
 =?us-ascii?Q?ZaKzSMVYG7msyquG4Urk9nj6ocPwRmordXhU1prTuH3m8mnHS2Cq0jSNvuk2?=
 =?us-ascii?Q?OTBCCCp2jfcUgRT40yXxrl13ibqEi0tpUMfNDay1Dat3lYI/OclEFys5jQnB?=
 =?us-ascii?Q?BE4fF2IRas8+WOzFXjFNDX1XK4oKUsK1gB9nBJNw47PlzYGUXYWsA2bphm7E?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	j4t3OxrQKpVObD3j5qSnYJ0FFIqR8LaFlmA83zXBbuUpMCXaNXdzLbGhjmrtycKmRP7XlN+CDvdWr4xIqqYO40km7zw4RqWJlvT3Nmec+qcqUCxWf0/oUqnlJaZ3RUvOKX2bNBW/Zn1crGjcNlY1szlXimWNZgvq6oOC4sqg4vZdbKikGjyYYql6AGaxdg7re8onUXxMZxSzjU+3ANK/DhMfX8vHTJL7x5jtqxQuUu3ytDm6M4Bim/jygmaMaIW5iaeCUDhDUyPy3r2aKa6G/e+zJWwo2qJ9nTw6zf1eBL/XIdtYxNi12cjNS8fpr/7SRPyKdQWSXauJtB5b8iYUWEscT4DQ4xeSQ3tw8j1hsP/KQlgHo57TbU9QbUbznXRAE31JE2Q2nyRqRPFR2TdIxRe0f65ff9SZntjDtDUtafqhDHCY0sXV7JBuYPgN8RoSr2qnzdCIGcG2OqFDktB6wqBgD0/xn4SHKRfiwswKFt6lhvGMc3SVXfExjoa22Lg8ZKILS4ZsZtpKT5WQ2Z8a/e9uSzdG6lIBTyJ4F1UYkR0Dt/u9Jv7OvyIMqjbeh2hYpDYz10p12OUqSj+7X5DoPrSYUtnBtcFGn8jFYcu8YKQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d12d4b5f-a050-4cce-5965-08ddbe289b2d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 14:06:16.8682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNVGygZ/Ld791TAh+NQgtAm6PuLYp7PObb/yo+NApAEnnwgl/hTWLFvxYtIvvG1tOe4cKXi8bB4WLU8vIOqzfxyJh2MShkoCXQXdLKRyZ7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7560
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=537 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507080117
X-Authority-Analysis: v=2.4 cv=RovFLDmK c=1 sm=1 tr=0 ts=686d25dc b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=ZquzUk1-7ksQx8ZS2gwA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12058
X-Proofpoint-GUID: x8Z04MGNIrpWp6jRDnekgkAHnLWVk4kE
X-Proofpoint-ORIG-GUID: x8Z04MGNIrpWp6jRDnekgkAHnLWVk4kE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDExOCBTYWx0ZWRfXxbtEzdJmqbOy CGzzIed1MHqKL00qoKpnNKZHJ3xIwZZWdBF76psc3UGxN3Zg45j3lRrVjue1NaCBWD4xSLJlBVd 78Qq6eqJ0KE1FQ4Yrd83qR35ant2bxaQuMXTUWcAfz0UJzgcCw+YYFMUfJeKov6KrAt8Bt1q9uT
 tiQ13HeZjZMyFHcw9Tm065glDpNj7HYUvP7l8q4FeHI2eRf3EWXdpejg9ek7qrAnYXVCHg8XLcR w9Sc/EMsogZ/R9dgi8w3BmjVef4GI2s5uT3GV2VZy6IhQcvvvCiTwAlZs97rjItYWWpC2pWnRGN 8hNwv7ZCLd7iVHYwcsenkn6dK29IQB3w+sm/ckGLt6pHV7L8DSg7HnT9aUw1kjPl6dadPn7Ervp
 YBdrR0UPEg2NgbphEuWRfNIjMpXOxhdZIRalAHlXyZtoZxnkLaKe6ZDTfk6hXtd3O4c2RCyS

On Tue, Jul 08, 2025 at 03:41:31PM +0200, Danilo Krummrich wrote:
> On Tue Jul 8, 2025 at 2:36 PM CEST, Lorenzo Stoakes wrote:
> > TL;DR - the real issue here is not cc'ing the right people (Vlastimil was
> > not cc'd until v11 for instance).
>
> Since Andrew was Cc'd and also did reply, but didn't mention anything about
> missing receipients on the -mm side of things, I did not see a reason to bring
> anything up regarding this from my end.
>
> Thanks for bringing this up.

No problem - and it's understandable that it wouldn't quite be clear that
it's important to cc- as many people, as things have recently changed a lot
in mm re: having a good + specific response from get_maintainers.pl.

At any rate, it's important to always include M's/R's from
get_maintainers.pl as a matter of course when submitting series.

>
> > On Tue, Jul 08, 2025 at 01:55:18PM +0200, Danilo Krummrich wrote:
> >> On Tue, Jul 08, 2025 at 11:58:06AM +0100, Lorenzo Stoakes wrote:
> >> > +cc Liam
> >> >
> >> > Hi guys,
> >> >
> >> > We have a section in MAINTAINERS for mm rust (MEMORY MANAGEMENT - RUST), so
> >> > it's slightly concerning to find a series (at v11!) like this that changes
> >> > mm-related stuff and it involves files not listed there and nobody bothered
> >> > to cc- the people listed there.
> >>
> >> What files are you referring to? Are you referring to:
> >>
> >> 	rust/kernel/alloc.rs
> >> 	rust/kernel/alloc/*
> >
> > this ---> rust/helpers/slab.c            | 10 +++---
> > this ---> rust/helpers/vmalloc.c         |  5 +--
>
> So, your concern is about those?
>
> > These are clearly specifically related to mm no?
>
> Yes, and if the maintainers of slab and vmalloc agree we can add them there.

And the mm/rust section. Because if that's not where we put files that
relate to mm/rust, what is it for?

I think it turns out the larger question here is really about the alloc
stuff. I raised that in a separate thread.

>
> But again, they're just re-exporting inline functions and macros from header
> files, which bindgen does not pick up automatically. They do not carry any logic
> and purely are a workaround for bindgen.
>
> For instance,
>
> void * __must_check __realloc_size(2)
> 	rust_helper_vrealloc(const void *p, size_t size, gfp_t flags)
> 	{
> 	        return vrealloc(p, size, flags);
> 	}
>
> works around bindgen not picking up the vrealloc() macro.

Thanks for the explanation - that's useful.

So the fact these came up by accident more or less I think underlines the
broader need for a conversation about about what does/doesn't constitute
mm/rust.

But perhaps best to keep that to the thread where I raise the alloc stuff.

