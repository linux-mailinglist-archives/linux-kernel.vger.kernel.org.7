Return-Path: <linux-kernel+bounces-893644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAD5C47F09
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4FFF034A316
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9946F283FEE;
	Mon, 10 Nov 2025 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ggpfhU9L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OCf0zTST"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E3328313D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792129; cv=fail; b=NDoIR/g0QM/EJlGQRAa3WmPz0grFa5hwQVenSLDbKhhjjSG4sDs8q3em7JaUiS1EiKMpiN4W8WGqP7WKwHVtf5kaUknG/fBFNSxZVJ65deJjPFEsXgwKuchVmUUAqz1I23ttDjE1UsKNj0L+XIm6+EgjYSxKnihwhknPs/KufvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792129; c=relaxed/simple;
	bh=MRQF62Jc/xew9KGRyXgJ5DTaBajrayA0LjxzY6uT51s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UbpUUt06MWHZLFAaQ6SX6ihzK3uZUz2D9qHgyzLNfOXKw6EqgqVceFRXLyF6GIWe7psFhG6bEWFW5mvs0Eq7RgNVfgZuJbFc9w5eJ+rQFgkxRLtkFFntYyioaKNLWE9SIv1w6nZ3DrsaZ4FbZMag+GgF31VYAt0mLEv1X70fJzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ggpfhU9L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OCf0zTST; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAGAjl4029328;
	Mon, 10 Nov 2025 16:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=MRQF62Jc/xew9KGRyX
	gJ5DTaBajrayA0LjxzY6uT51s=; b=ggpfhU9LatAu3nS2k11bD40e2kaHJ2d2eb
	kVInxeEdOjcQ//QknlFMpcHkkmJV5tJSmkNhlSOIFH2VWK9NaFLX4VoNaoJczno4
	ZvcSqF6NuBGo9kQnnBODQuAM2xFoa+I1SpgB3C/452u4H6X7FUMrErd3ewIpI8Nz
	lpPrStCksEGRu4UbYjwFwzHeLpYmsQRSRlcpmeQPqG++ShyVgkWbgFRODzwHykqY
	n+DNw9/Dt+vUsoJ8ynYtH+0Pc1eW4dFRUzQPYxYYOOymgiGZD5hCx/ta5ikY5y9q
	ZBvA3+EjCXPtwT2MxsCiMiIUbhNeUPlQtBZ+M9xe2+sA2TltF8HA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abkb6g1kb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 16:28:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAEx5uR007603;
	Mon, 10 Nov 2025 16:28:34 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va8vrab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 16:28:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pea2Y8TEOYDHPURzc55PAPRdyK71ePOuL//jzr1HGj3v9o7EULgDobSY2l5y6cxY3ymsbse3UP49tzRnSPp8r5aWWX0Frn22txjuIeG7lClXME2FM5JJbFx/JWcUWJgtO5bi61rA7w3tJo4Ftef74hT31Kydburk1+X2aXKUVFytXZK6V/Gw0X82jM01HCpt1Oqa8gRzkK3C1nu0pYoJJaG8eStRhTCL/exMyCEgaGqr0jvmX10FASVEsxBl5zw+r4rA27nbERccaEreAxlQzlCTKlyDBOxjIvzEE7ZLLIEpkanE4oQgEvJoLi2kDs1lHBCedpNkfPLwGGDYcmwK9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRQF62Jc/xew9KGRyXgJ5DTaBajrayA0LjxzY6uT51s=;
 b=S1n8jMSGuBY6EtGB/TNc2p4a8gCNso7NwxXE4O8ySSH4/GRzDTtGzgAl9THx0Wa+cr9cW7lSpxxx/dCg2dhamSBTvYyBCPX0w7l6TB35AEgpkzwny00Kle3/SZA4JU9R+pFhlIvSyAnoJHA+WGzi788YOAT85T8eQjyFJHR+x3ivPuvzNR+svo8EwexyON0niGQpXy66KyQIUXRCO4hC6Tn0q0B+s0Tmn8lgzpe7QUslUvF0gfoTFMuY0svv6JH78UqTb4zkxQ4vPnaOanvU7+6Fzj77NnALo3JoVutg5dEyNVDsR9B+6/326GFBW0XqkV5i8Msr8w2F8FS/3/3Jig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRQF62Jc/xew9KGRyXgJ5DTaBajrayA0LjxzY6uT51s=;
 b=OCf0zTSTODBZZYXb3+Czvdga30GTBQRwOHuZ8zZFmbpBPjflA1ZSNC3VuYBgULJPDz3a7JOcoM0p3WRp/NswWqWKhk5UTCswIP05RnHu/8Usb3yIHkIoObsT2j8W2HFHIdtii6gyiv+Tm9kKTgDIGypAkmR0qRxiSUqEqpnbHks=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB5082.namprd10.prod.outlook.com (2603:10b6:610:c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Mon, 10 Nov
 2025 16:28:31 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 16:28:31 +0000
Date: Mon, 10 Nov 2025 16:28:29 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: rename walk_page_range_mm()
Message-ID: <47e190ac-792b-41a0-be24-5bdd0c26e800@lucifer.local>
References: <cover.1762686301.git.lorenzo.stoakes@oracle.com>
 <2e48c7ffbd2ecec8ac189569636173fb44ed3631.1762686301.git.lorenzo.stoakes@oracle.com>
 <f7a69885-7bf6-456b-81fe-3c6a5a29b470@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7a69885-7bf6-456b-81fe-3c6a5a29b470@kernel.org>
X-ClientProxiedBy: LO4P265CA0322.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: fe74ab9f-6dd5-4e47-c62f-08de20762fb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X8HGbaScBJmOk5vOvgQH10kmUovTRhIOs6oz6GhYTm6HADC0ak/fEY2Ca9Uo?=
 =?us-ascii?Q?BCryV7VvBNjdnyAhhDVqc04brHpBygUfOzqQu/JzMiM4ywA3nUnJuBUrhx+P?=
 =?us-ascii?Q?gWq3m0DsE/9JniRoZY0+IfHXj8hhfcaOYB9aLdBOnwW4UE6FprTdS2BnfhRy?=
 =?us-ascii?Q?d5PUHHKKhhAEpKxMGV6H/h1ADsYxiLn6WzmPEDZ7rHmwTOZmsV+PpTgarhzr?=
 =?us-ascii?Q?KUohA2xPHnqDD9j6i3po01kMSngqzKuYF0+ASVlIMC3zhorC+c8vzD5uDY2d?=
 =?us-ascii?Q?+3MupqRFzIw4X6P8YBndccB2lQqH98D/P3ve/MMJtp3sZULSzTsBaxDBQCx3?=
 =?us-ascii?Q?HFqdPcvgSK7pAYCyF9qq/Uspd7tDPVd4Fw0Uad/Qs2m4jZPhPYC8+ZkYZe28?=
 =?us-ascii?Q?KwQ7Mxnu2XpsMsbRXUvy626FqT9zhIVf9qqYNI2kr94Jg1QERLkz7/iAkF40?=
 =?us-ascii?Q?R3EKHb/cF4NGMxe6URtjQzmkykRG18K2TXvMYaaa5z05eA8zw9NGNKmFOtnv?=
 =?us-ascii?Q?+B2302nH+5ru+5MnybaZ61YOac+VDBtVb1DVtJ/cGON/qxjDvyVpZlw6GhLU?=
 =?us-ascii?Q?Gltn6tHDWhgi1SshpuB5YDI2NMeHwpa7iDwtWdgZb/qZQI2AilKUltr7ZiMs?=
 =?us-ascii?Q?cL4ik1hEQsEsYgv0j5W//LhhQ1JNX6dVwg8WUYhWvN4zkVUzTEvxn601vmyR?=
 =?us-ascii?Q?i6tGItalW8oD4C8VhA1B4xDrm6UgquQZanUKZiWFGI4SbgQ0f6lxAAG+jbp4?=
 =?us-ascii?Q?olEkthh4a+U4SmX6vmotXUnuT9p/ZlaM6THf1TMo39PIDVCN7Q7rmXba/xK3?=
 =?us-ascii?Q?sWq9+9Eb/MHv6hClZbdcGl6iJJREQQmXHE6DdGAivWUrGa/zdpboeLReoRWr?=
 =?us-ascii?Q?PxFHxXtk54a5EpuQNxngjNuJQK9HRjC1ZMCtvwizOLAdLy6bldghXvezMWQ6?=
 =?us-ascii?Q?bfE1fdPLgv8ZAozIG67P0WPyauhmrPvGJGpk9GLoiM4C52KHKK0XYI/ztTjz?=
 =?us-ascii?Q?XMQAMieyD5Kfk8Hf4xcwTh+ooyKLDwNWpeF+HhjtHOg4uROJEQigLZcXuQu5?=
 =?us-ascii?Q?np+QE4HMGMgbyVphkV9wFFj28gEriIIkzKrYKZ0VsRli/xREx5i0KweE77mz?=
 =?us-ascii?Q?Obxke10Pw5m4cTAizyYvt5iBBTetKJPs5v2WhoUa8uUm+pIwBaQrRjpQz1Bj?=
 =?us-ascii?Q?QHW0Qfrwv1jKRokhHTrFivzqzral83CIq8zYwi+qBnm/Ye3wqqwvVPvcGSZV?=
 =?us-ascii?Q?L/rZBt1KhFMcBAVFvW9Y55mDhskU/bN4UQ7jH2azKnedm+alToTDfl/Tj23o?=
 =?us-ascii?Q?23pOwLMtb6ksnP3F7nNpIE40h8KTHUVEpUaYcGR9+k04DNAsge50nhkAUqUP?=
 =?us-ascii?Q?Qekwpf8dKHWtC8by7hUkwPlGZUhaJr1DnnMWumQ83WBiWxRkq33EsP0yEHGB?=
 =?us-ascii?Q?U9IgAiNihxgStd7kdAyasodkzDVfJfFW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rtVtlVe2mamzoxH/phm1R+CgqKDhmQzV+V+YsdNywxxDVI9osxeswe1m1S/A?=
 =?us-ascii?Q?9Cd5xUtPbHhUhP8C/6L6VJLG4vC7AVWvgotbjCZQ+sJ47QD+Mf8xAw+wgagD?=
 =?us-ascii?Q?PQa7r+c6sLnd076fz0eA+k/sbbUd2lRuvGBYIQ3+cZKWAk/FK96Eft6uC0W5?=
 =?us-ascii?Q?jASAl+8Yu4vmatYKzSF7WeijO9Ig5cLCG6/0vBULqL4sj5oKRT5pqr+DR9Fs?=
 =?us-ascii?Q?gUJ3v5gNdd92QCpZaFylBTQ8PufjQBsQcg65WAIZLigexYvFs6q/5tlHEKtx?=
 =?us-ascii?Q?vO6ArQ6FdvedG7JLPaIZZ8cFG2EqX2M103bvmSqHxu2qYC0nqW/1QFne/fEJ?=
 =?us-ascii?Q?Jl4hdLk4N5XHl5IalsRuPonyV3EnKAabEAU6tSpT2U14D3sMdWvDF0rmFfyD?=
 =?us-ascii?Q?W0hWcdRrdOVwK3cJkgg7cWlj7s2xXV+KUCE/EHw8R71RJhth23jMr2pvxjXl?=
 =?us-ascii?Q?0aGlKE3k5aWf+sTqMuD4f8EjT7hvCOj1/KoRLgKTGWOxFXV1SeNeR4o+GCca?=
 =?us-ascii?Q?J/LRJfGc7p9gKy9uCbCl9gocuTYO+AqjW6yLRlWD4XMPv9cR8dSdqetAODrw?=
 =?us-ascii?Q?okHNRGHmxTGqdeIMmCaU//A3oKsSnQ8WEAPFjZ/1TPCGrY/6MDXK6J9PblMa?=
 =?us-ascii?Q?vgiGok0Tgr486pdRVWAtXIO1gnQzm4eiyto9UZJ9XyzXcv+v2vLlSmFZlJH5?=
 =?us-ascii?Q?igEEKFJYjYR+H7ZrnWXYGAYjNobmGJNqgG9s/uaiTpKFatpK0i5uma/2GlKP?=
 =?us-ascii?Q?q9ekteWCJVeCYw0/iTiXksj4QudFoXJYkc3IYov2z5bULmmegHp8fNPECKRc?=
 =?us-ascii?Q?xNKA3l1YB7ye+PwuzTzOXMJSoLSaFcqy18JhwY8idywihFm7lHBrF2f0DnK1?=
 =?us-ascii?Q?86pAXbQThad7P/3Mybhgzin7T7oNBFwC8WrIwkecC1cSStgwC1YzVuvUzwzr?=
 =?us-ascii?Q?hq54kb62GrKRCGMfUklHO9i4IMpVLcu5ISsMOgO5XeFmWaO1zNvmWVy/28W5?=
 =?us-ascii?Q?ECybPJxe2yjYtwOnUq+0kMmwrighsqwUQSR3zsgJAdj5i+xSkRHpCCcjGAO3?=
 =?us-ascii?Q?On5hGKSJWmwvjn/hv2Y3meXQhDvb47tE0s3tCV3c6I/VqO9Gl34FF8yqqDDn?=
 =?us-ascii?Q?iHW1MmWRSKX7zYczvHy13Gnc5XPw+CsG9SWOAzovkQVT5dO+6tPraj9nf/L3?=
 =?us-ascii?Q?IyAU1LR76S39Tk8K0C/FFh6m+/n8ZBxp7nyJNTyDAJBwmLydIHUTRxy3Phaj?=
 =?us-ascii?Q?F4j74GjHM7xM+ojprrczD5DLZnqMYpBGakMUcuCW5TFAVi2lJmnMG4x+NNOd?=
 =?us-ascii?Q?emD8KRnS99w/bt/x0fav6n0Br8fGWCl54ZdatO3leiLXTpVXXPpcGuwRNNM/?=
 =?us-ascii?Q?rxBIl4HX7izPmbRkVV5sdXEFV278ChI/JUQOov0ahp/cuV+tYx3fqwiEVvNw?=
 =?us-ascii?Q?mKV1Z3V5mgLOSHIfG/zGEIbMlKx6vvaKa0/9XlsCRcruotzjckT5D5wbxzZd?=
 =?us-ascii?Q?F8Nl//UAvX1uEWdzJokiNpfUUuVUfytb/utpO3YNUd9WV/eSEKUZDxC1VJ7L?=
 =?us-ascii?Q?N3SGKyE5v+cLSK68PpwHLjvmUH7lR/+m2iBbnOIDkqZ2EVq1Fy9gvLb0Dxtg?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Zz7ilyzYOOGp9A3TnxhEavM5P5LdpC3sgv+2datyGbf+4w18oD+BUKFzkHbMxBi6ndQEuv1sSGpB+yeunDnosNEeNhJMLSeCNSZ6yq8psN2wVD/tD5qiOmAkufUJEpXJKetbVZ9p6cXrBzbpvca5Z5Qr8+dzoEtrIAOdHEK6n1ngSeQRGCR7sTMmUa/pFXv5vk+jsO+eCdte38p5lCP0JDJADlVxvz57ZJGpp5M4KNeF15c4RSIg6TbE+/9F8YSe/lZtf2dw0OikgeZ+ewrrhdiH+ynasvXMFZt6ZL0biNCdSjbuLYIEhXUuTQUifNPauj8TzNe20SBob7CrGb9XOn0x3qrm+gNugMpgfJ56o3x+PtEE3EZrD7iRENSmlQqc3+sV1urGmIXXTKVGrOnIQZ/sTVbZFyLl4zuDHPSXS51ASRD3gUIkBqrkJ750VhCVQMEc1vhj1h+LHXDqiFPgJOP1stlWgqu5iY2jTGRnzfZhHVzaGABjlvmJxubhjB78MIk6M5RrYYJSYF0EI9vhYiGK38d2FUCpTO37VPm9YI+r6IoY8jy3XOWCvRi+9oQx6AVeheC/yV7qe2jCWq19OLLT39QSR/a+7hFrkSzBePM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe74ab9f-6dd5-4e47-c62f-08de20762fb0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 16:28:31.2166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IpO3+oqo6b88BjUUPHXBweM7DoizdHywpRYho8ttdbJmoAiJhG06gn2N3bOjlMgA2IbaOuEiQJ9ncmDNSlNcBeC+66X8Y5XmUxWNV5ufBb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5082
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=829 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100139
X-Proofpoint-GUID: djZtmEW3Odj0bC0oPuOVvV9nQE9-UWuc
X-Authority-Analysis: v=2.4 cv=ZLXaWH7b c=1 sm=1 tr=0 ts=691212b3 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0oNxFd5zuCWQULCmJzUA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: djZtmEW3Odj0bC0oPuOVvV9nQE9-UWuc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEzNiBTYWx0ZWRfX4Md6/SNK5scH
 e+FMV8yRzQsv9vJRcEsNjQjdE1u96hdpIT2fv6ncaI3a43+o3ai6HuGXFhzoOMxGNzjP/c/VRdR
 VKVbXDygugZTOXFggAMiRk+/MBvXc2gHLm/maoqIVJwnPW4BI/+X92DZvFzJWN1tz0nHlG2dGSo
 kZvZacNMm1/cZp9v7qmmVT2TFO09qMVH0cKD+1IUi/S6VtGq/HjOV+PeM/jBEcwLCTNRuCW22wo
 K7le57StUryC9QCqy8/7/sxYj/gaEtVVG3MG16WyBX+Sq60Tv+bZuqZwmqqhiS8VbVcxkeiOn4P
 W3zhL91lTrZJbmLWe0hqo/2j3FfHMLHBAUgtSyULopFVVM7jdQ+TbVz9ZOS7Fr2QI13ARrQgomQ
 yY7/FTXOALk05narX6C32gfqRFPoQA==

On Mon, Nov 10, 2025 at 04:48:51PM +0100, David Hildenbrand (Red Hat) wrote:
> On 09.11.25 12:16, Lorenzo Stoakes wrote:
> > Make it clear we're referencing an unsafe variant of this function
> > explicitly.
> >
> > This is laying the foundation for exposing more such functions and
> > maintaining a consistent naming scheme.
>
> IIUC, the "unsafe" variants only bypass the check_ops_valid() check,
> correct?
>
> Staring at the code, I wonder if we should then rename check_ops_valid() to
> something like "are_ops_safe()" [or something similar along the lines of
> safe vs. unsafe]
>
> Because now we will have valid vs. unsafe which is a bit confusing, at least
> for me.

That is a valid and safe point ;)

Ack will rename.

>
> --
> Cheers
>
> David

Cheers, Lorenzo

