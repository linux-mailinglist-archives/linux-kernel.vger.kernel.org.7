Return-Path: <linux-kernel+bounces-721623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF40AFCBB7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0B5C7AD735
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E367D2DE1E6;
	Tue,  8 Jul 2025 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E49ZQ0yM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JfcwTGOR"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545792DCF71;
	Tue,  8 Jul 2025 13:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980802; cv=fail; b=CSKsmhqasapRPMT93FS5/ckfscY0Y/7lzo0I+oCczTN1qJ7v0m49BdjbrNbVMbbf/yG8ZFAxFofAL9yqTR8qImy5hsbM+aqseGfOv8c5IgZwsyj0+T3wzP29nDuHSU5rz5c1GuouNysVVW/cxoc7awkdC9giEdsrMc6KGfGorkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980802; c=relaxed/simple;
	bh=HcBvzLvfMzOHhkKdznHTXpI5a0RYT283Nk8A6Vn7U2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PqvQcxUGButCRYaSNo1lOPFPAVvqISahhDF81ebpN4U/CakDIuis9aU36xP1ybM4YJbu6E5XNKGM59AIactSXOp5CJjKnDr+pt5yPjWfljO2tKaIdlcjoYN7VRi2ZGPBTeN48nnpT9RYpRU7/z3V7FGnjSRA0RmmKU183RdfKiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E49ZQ0yM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JfcwTGOR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568BHal2005858;
	Tue, 8 Jul 2025 13:19:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ojnF7iZ8ulprohZoDs
	KgiIRJ0IHHvR0cXVHnQrdrGug=; b=E49ZQ0yMeu3IKGAWRlP7mClxDjlWSa65en
	RMKSrR+yCoVLfE72voFUN+qRPfBNcrprLay3jaobKg9ic3crV7I2pYn8zH+8a1i6
	r10mzeWenEdATsuxqp6pluUMA5ZkO/AuDxeLOxT4X5AtzVkkylm3Pgfe9mHmrtD8
	QsMamZ6BDKkdVzOqw1ouKy1yD39klQ7hwoLHHqdSYjxMSAUAyPtBqjicy+DeRnog
	auz+oWWL2Jkzk5422x2qTy4guutIUPJQe0wZNcpF2Mm9NNx4BtIJo0/dmhtpoiOc
	96WkWy31vFKAaWVa6ofbqCf5xB0F3AwDCO0gf5OP1vDe88uDgLAg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47s2amr70a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 13:19:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 568C0vJJ027404;
	Tue, 8 Jul 2025 13:19:43 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg9khtd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 13:19:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=acz40scUxOarq2GydC0F2MiqfCvc+nPwsk5xcX/3t3bhJze0HfBZJVuCj7r7L2c2QSxVcKmsXgqeld08F06wprfZIMDFZ+PqG82Uzs+7r8AdkEsTAGA5RF4WSYWk+pfNtCg8O8I5cuYek8AlNgIzL1adTAHKKnuf7k61dphSE5QLHthZV9xn2UlnQTxHuxHHWFrTd/2Jj3f0vozJwZwe83VKfGtcyEOP2odDkdvRWiwJY2wQOVvNHwfVuCqFUIzqNYCgzoiSAS+/JkgxavSgHTbUJkeIFJvyuIYI2CtDrU87qieUMcpVTnZmSSeMp1fAg+8jwid++4FG+0k67Sz0mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojnF7iZ8ulprohZoDsKgiIRJ0IHHvR0cXVHnQrdrGug=;
 b=FnQ3/dd+tSn6dVDd2yNNP6kTqVfwg/WpuRh3GLXdtsrxcvY7XsosnqogENE+wUhND9xqGZRYcrASxRXzc1mQ7qy++/+k3vhvAmCe6lR93XmQSxVTviqdXonrw+k5e/0y5CUNz7ouF8wRi4OaNLYQbUhuBJ6elOjVUKhwM/rUloO2gYTbgmZyCy+T6Vj2TIbvUW6YFZ3SPv9jzVIvr/3A8JtV2BejawU8hX+Ar9M9HiwGJrgTOXDWp+SIpRrAGD2omPvbXgdJKWdFI+Oo2YRxpuF6WZWs/HwW1IdIXw4DjwRqy8CSaqZc9eU+V466A8K2WPYihVYF7PkQRRE9GS5FuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojnF7iZ8ulprohZoDsKgiIRJ0IHHvR0cXVHnQrdrGug=;
 b=JfcwTGORjBpmtjvfsrF9/2aEYUROTSH9yfiRNDZu3YpEgMpkwIJItLW7G3d9G7omFLy5hCx2+RnanWx3AtyUsBFPUpsR/PwHI4o0VFUs94O5kGimwMCYe6XlgLbAhoVydFhctwUxfQDZ+7qtOiRrOT3o5Ap0/zooRkb4mSa8vpA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB5091.namprd10.prod.outlook.com (2603:10b6:208:30e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 13:19:41 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 13:19:41 +0000
Date: Tue, 8 Jul 2025 14:19:38 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Vitaly Wool <vitaly.wool@konsulko.se>, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Uladzislau Rezki <urezki@gmail.com>, Alice Ryhl <aliceryhl@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, rust-for-linux@vger.kernel.org,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [PATCH v11 0/4] support large align and nid in Rust allocators
Message-ID: <54fc10ce-c3b6-4571-93e7-eebfc538d0c7@lucifer.local>
References: <20250707164755.631374-1-vitaly.wool@konsulko.se>
 <824065ea-1f5c-4cd4-9917-4b7a91882af8@lucifer.local>
 <aG0HJte0Xw55z_y4@pollux>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG0HJte0Xw55z_y4@pollux>
X-ClientProxiedBy: LO4P265CA0195.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB5091:EE_
X-MS-Office365-Filtering-Correlation-Id: a9a6658e-13e3-4747-b1ee-08ddbe2218b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/LvqkbntpzVYnHQh1h7NItXPN8XSl1eAnrpOEtBEm3sBCGIH3BOhs3nq0DQn?=
 =?us-ascii?Q?Xs1B+6HEaPNQz2uR4bQwORq5kZvZ7RPKYKmICh0EESBB2zzM1qRc4jE4G6DC?=
 =?us-ascii?Q?5qZ9fcZ8nFb36tA/RtNu2gQH74WZUljPLV9NBRDjh6NNQWjfNVRXPNxxbKWR?=
 =?us-ascii?Q?Npu2bKRlCxQ3oVG3bYfNO1MYITaU/v8H6BpRGC4wuw9Z9A0WO1lpdeIqeOLv?=
 =?us-ascii?Q?BoDAjB/ksTygJPA878NGxfRFYnOjTClROzXXErS9E5YjFVnUBF/NindBWtGS?=
 =?us-ascii?Q?o0Yi0+LeKwNtNOtqfINp7DGX7gywnn0e9i7McZIesi9QzGfVDzxtv1cvaUy/?=
 =?us-ascii?Q?pIzDWqjFCzWYfMc4+vrCgr1p+n7BlGWd1MIi77jiSiueHE7yCZUSyHXUvNmD?=
 =?us-ascii?Q?pzFiW9cVoxUnOAf+qtkJLfU6DDYWrzqTCVQnOZXllBU1euxxFfFySla9ysdW?=
 =?us-ascii?Q?YRMBmYMOTpejQcO/qzUGNIl+o5HT+e425DLcqb2yb+s4eVY2TCqibIDBdnt7?=
 =?us-ascii?Q?b4YGg4KaQyddAaiuq1S54YI8E2fQPJa9Ap5t5/aKZVA36r5zZsMExvNi9zQA?=
 =?us-ascii?Q?Gju/cTtSbKwSv/R0ibpcsX3P41LnqjaC6u4U9Ze6l62SUyyBr+bNd6KRvAEE?=
 =?us-ascii?Q?8ppYtmkF4cm3KMi++ie5IePvdlGtfT+ofNM3Xrxs8dkWIiK5A7dgsbWYet3U?=
 =?us-ascii?Q?U8WvUSKgzL1iGGJapoX5Z1PLH7eNajEjiYKvfppKxcDbu+CjH53QRk8ewCGH?=
 =?us-ascii?Q?nFUMF40jADPfHuuY/d5pNpXrbFfe33mf6gkDjLqdgGOK2CQaZYRvY18kZSjT?=
 =?us-ascii?Q?Jwz83XQ9JNSskjB5R3vZR3t/EAL87TWACl9F00TrrPBQF8IJQGOdLOMWkA84?=
 =?us-ascii?Q?HYXNqsCI8lfIkhh0VDI/3hkxfxPMDXtc/1rP22jJeidEhZ3OtuMu5qDLbakl?=
 =?us-ascii?Q?oDRieLIWCo/uVN77MzFYUeMzVjwhs8hBu0Wxfw9nFYxRD9WjnSGOMrRsM28i?=
 =?us-ascii?Q?tu76CBhWX7tKJ1+i4/JJ+n+biNhH1c50xnT+WIp24TRDDjl9A78YTPuYLdDO?=
 =?us-ascii?Q?Zzx8tIHOCZM+KxTeSC0NURttElrHWCX4rfxxeeSIDfJlvlw7fBF48Nu588Gg?=
 =?us-ascii?Q?lDnAfJ4sSjexSAH4CLNl17s+YrTi1kHA7Bgp4mwmxh1Ic/LZhgQz0xHbNaa8?=
 =?us-ascii?Q?WIlqsf+r3d8aKxdgFh4m4PLkZlwiMcLOPkl7T66850WehPHaaluzMPMTKvKB?=
 =?us-ascii?Q?vXZB1stvx3H3/Irnjt9M1IoIiIHIl3ueL8UuersOeMwf3g7hOv9+Hmcef92W?=
 =?us-ascii?Q?tG4OCp9gFFV0RQXsmMza8OBXsdJ0l1vCmrMjfWVHISj8JoFsq796w9Ox1X93?=
 =?us-ascii?Q?FWPeeUpSW1y67L/H6CH8OgDrL0933WtrKQF9sjlo0Hq21kmAxckTWzSdooK4?=
 =?us-ascii?Q?rHf6prZTSLo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sqcz+Tg0XKH45OBPqBq72Z1EoKQ3cA47nsY1lENVdhH7Bz24B+YiYTBSil5L?=
 =?us-ascii?Q?EmlZnwv4NYVFYrJ2fjvICZP3ZBtmo+ESPhZpeXwICBb4HM/Ibw0DJxpYAQr1?=
 =?us-ascii?Q?S/HRWsNqs3ILjBzi+Fr9OXsALEhyuZYDTp1Eot4bfwcKDbFjO2IDPd2bSjhp?=
 =?us-ascii?Q?b/xKrypcxgIQ3u620rKqpDMOkyEpi51c724ZRE2DB/JaR8GEQ+RIkN7w0njE?=
 =?us-ascii?Q?SFLz7y8xKYmU2iQLveS51PgSwKAuNBru/c42fhUnz2UnG0XcjB79ujy/cPOF?=
 =?us-ascii?Q?atjk5Eeq8W0Vvqq1wvcxhYZiVAiRHRUdfx/1Z2me2kk3mfcA6kqXDsKz2+1S?=
 =?us-ascii?Q?8zb6p2L0h7ky5k8r3Lz4Qhb78EUA7BJ0wCROxRguPC9J2b0RB2v++3ag5ORA?=
 =?us-ascii?Q?dB/nk1aTis31WhyLxbv4/lbH3EpAsWQhL/wL5u1Kmw5lkvs8ka2sPUBAGoe2?=
 =?us-ascii?Q?1yLYAt2HBhRTf1Ovs0p428jZfkHPbAe/HWqAqgDDc1lhQeSaKi8TS2/e/koT?=
 =?us-ascii?Q?DfKEeSkjVOUV+B2QBl/82Z479hiqudU6Ydj2p3Tj1vudEzyGeQOJsWVCH1Uv?=
 =?us-ascii?Q?4LIGZvNHKEcjiYuhpqPI7oboC5PAGs/nLTdApdDKasYZ3+zMHZrkRoSonA7t?=
 =?us-ascii?Q?00R5v5776IRCREMhZaYPuDbl6C+8sorZY+IkfJPNhcYzuvrKPrBgEq7oomMX?=
 =?us-ascii?Q?PoHkeWj5/SI2s6KbNn0eiBMnqM/XHR/+rquCeMFZGQG68s+I8gYORiTsx+wH?=
 =?us-ascii?Q?OisKh/q5ccRdSRwtY9VR6WiNLI6c1lWbDIR/Fzy7kFiXXXrQl0fjvrIf2zMF?=
 =?us-ascii?Q?OQ5neSEW+S+3RN0v4aahpU/t45VPpvZFNDwzv1EjI/MM/aevpejZI5j3FzmK?=
 =?us-ascii?Q?5KL3RzBgrphIglYlLIdAGWB2toBMM32A/CeDq/st2rDAK8S3LHc5hNfK94o1?=
 =?us-ascii?Q?0dgycvoDpdI7JdZAbYgSoGKYiN/87kJQDX+dpowWHymIElfzqmGupS193AG1?=
 =?us-ascii?Q?eX6NBPFwtV9hE212X3QUSNndlvVK2ZsHABET38uqRql8p/kflQm9eB3bK0h4?=
 =?us-ascii?Q?tAuUMW49PNqdkbDd7abix6c8hHaO9VjenkFIcdwoIY5SDAiM6H/eEM4K8i/9?=
 =?us-ascii?Q?gqgiT6lCNYteECGiiE4uRa1FxFbO4VJIp3noEN+TS+wN6o8lUfjXsv3Khg5O?=
 =?us-ascii?Q?RFtpPUAz5fsOHwMQ2k8JK4xKWglgl/orqcFzVR2X0TJjm9AP9zI6m91LqRRB?=
 =?us-ascii?Q?wkbRng8MfenDWjaKtiAsLYx2JjoP/3Rcr5JKrH+irqFIcRV0cpXvbrIXXivr?=
 =?us-ascii?Q?KOk7Ruxom6qYKD/C5pCFbtRqTd/0FZ0kzPtNh4FqjtwG9nnsgq4QqZ/8/OFg?=
 =?us-ascii?Q?VmKIHQhCA3B8huf+Jg3qr2rlIvgsk0soF/haHH2In/iYkwdHbYFQC1yhPMCo?=
 =?us-ascii?Q?PiIc8izBN/tEWhWz2TTEdAtCMnh5+tCiIiBX0dWyYPNwSq2zzo+dpEoAeyUy?=
 =?us-ascii?Q?GYSujwZ+ds+MdBu0Vzr22hqZ3hXYfjPvHhwHb3vKIyRwFpZkCJQ897+HtNys?=
 =?us-ascii?Q?yS7i8C4qdcYlP58KTUl8OnkpujpKs1PqhL9Z5F3QCNtzaQE1h3Yupv94gOvl?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QFxo8PE/iybWIpXHRJa/HLgsIqFQnMQwDctEQOfK/Hw7uo8j82ZJoEXwKxB1paexUc2D+Ia0pUb+r6rYbg0fC8OrrljdwbGtA+GcRmlv81k4cCDZlKQ1cJvlBIXGJkIwg2mSykS2SXBuy0UkyLprdH96I6uEYE015E5258BQugfPCpQM7G61bGZeyMVI5q+MRMflRM7Jd5wLao9aLbDqk5cb85/cR5mVRWbBCdey34GIh8DDJc9IaF7o/u/EFjikKXcRQtwoDLGGBGZZePqzd4l9v+MDltOPZmFs5gkRMOb+dmTV12iocstpvw/Nhcp6lCchkMEQT7KB9x+vp9nOFf2YXIxvXIz7TuUY7LZwlYxQ/sUC/qhHnBpCuPtKckgn+UhVayOurKojsxSl4U2RRdtLTCBQXK8GGV1tjEbToh81LaZ2GgxxMr/2Src/VJ1+VXGi2wngKBwKMJA7XujK0g48+CFelwpTympxnkk507rAp28/kIKP0YOc4iCe5QY5g+6t2jxyme5/m6Z8vvTpx3gWXt7lxY8WFoEFdF/70cECp2Vjp7oR372kXg9NQxCYj4zuVba+ZErlZQYOCKpCIOsd0VwgrsiFDL9aaYpUHwc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a6658e-13e3-4747-b1ee-08ddbe2218b8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:19:41.0392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EM+qu7+0VJhKgYQZ0JGigoRxwJd4cx3Ni+F4LkML7ZAq8+RI1Lg3tF0K2uQDonGZ27xGZfyrxEv4gPYRX7dnnRW2lMwoPZ0eegrq+x0mrKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5091
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=483 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507080111
X-Proofpoint-GUID: 7qHBPJmNg1x3MHFkEkZXscJOzZ_HJAkf
X-Proofpoint-ORIG-GUID: 7qHBPJmNg1x3MHFkEkZXscJOzZ_HJAkf
X-Authority-Analysis: v=2.4 cv=MPlgmNZl c=1 sm=1 tr=0 ts=686d1af1 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=uGXvyI-4UYktICNcxb0A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12057
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDExMSBTYWx0ZWRfX7lJuba7p419O 4K/k5RmFmCl2S8ZdBSo7FO5pSPIGw6Glt5GwzjzxEaWrHDnckCGV2PwSstTPq8FeO5jEhcoMRQl F1jmBmvNOQnJVk1ib8LExVIqcAQ3mEdaSkV2bW7AoTEZ2Kahj/MqXbgcKOZ0t5VWqfJOnIMgYMz
 BkN8c4AzukGwJ67cQBfX+HlYIHX3fdOoA3NocNlRZ12orgjyY7aijUhWAbM3vnzy6nbuLcoZfB7 zGUwr7+cTy7fnpb0/muAgad2h0gbnBK4KgUSZtjiitJScB5kY4zVOm3PochjNYScQyWZNkJawGY WgoFEAhtGIHKNssy8344zsPFpEoedF46lviFhkVwg5kLjZhM/EqdnMG6XJVdGTQpfUxOvQWUrmr
 DYBbah/BCHuzljCr3t2xf1LJu3t5RoBv/L8C6y8KwuPcIiDfPApE/gVLnkYB9NkfiRt/V8bn

On Tue, Jul 08, 2025 at 01:55:18PM +0200, Danilo Krummrich wrote:
> On Tue, Jul 08, 2025 at 11:58:06AM +0100, Lorenzo Stoakes wrote:
> > +cc Liam
> >
> > Hi guys,
> >
> > We have a section in MAINTAINERS for mm rust (MEMORY MANAGEMENT - RUST), so
> > it's slightly concerning to find a series (at v11!) like this that changes
> > mm-related stuff and it involves files not listed there and nobody bothered
> > to cc- the people listed there.
>
> What files are you referring to? Are you referring to:
>
> 	rust/kernel/alloc.rs
> 	rust/kernel/alloc/*
>
> If so, they're indeed not under the "MEMORY MANAGEMENT - RUST" entry, which
> so far seems correct.

Looking at these, they seem to be intended to be the primary means by which
slab/vmalloc allocations will be managed in rust kernel code correct?

There's also stuff relating to NUMA etc.

I really do wonder where the line between this and the mm stuff is. Because
if the idea is 'well this is just a wrapper around slab/vmalloc' surely the
same can be said of what's in rust/kernel/mm.rs re: VMAs?

So if this is the rust equivalent of include/linux/slab.h and mm/slub.c
then that does seem to me to suggest this should be considered an mm/rust
thing right?

It'd be good to know exactly what is considered mm rust and should go
through the mm tree and what isn't.

Maybe Alice has some insights on this?

