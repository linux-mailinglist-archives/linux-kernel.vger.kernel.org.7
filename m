Return-Path: <linux-kernel+bounces-734123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49169B07D5A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CFE2586B34
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413D8288505;
	Wed, 16 Jul 2025 19:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PmgPQn0k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d8U8cTD0"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A641263C90
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 19:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752692667; cv=fail; b=D3l/1X2MLCxpd/+ewl/p/npNKDewq51oaKWjZh+5RHDQnXgTPH8L96bIb/PnJZcNSoK1QpQfspdlwXjTMtvZKwn085yX0VyjC77cFBBZ1w+0QGTkt4hpM1SIFAm4rEqOQbDPfrdjguO/0fnnyCdm/kcVKAArm57w8SD2+2uV0rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752692667; c=relaxed/simple;
	bh=kMmJTVh7vpWuqKtSBRMwZOVuOcN+zPb6+POaHU/fzGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lZU475UddYkt6ajGLK4Z+iDjxXa4ZKaXGcKBZpuEdXI1voqGFfgIDd6ZlhZN3PIW2SeZ/Xdu0Y8mm2HWaeRBl5fCdwpMwVn518nRKk246tbqgLMDMe/Lps1E6l4Nzy+2u2ZDQXkseAR1QWIwo6I/6lukDCABpBcJmdEii+yihbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PmgPQn0k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d8U8cTD0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GHfmwL025773;
	Wed, 16 Jul 2025 19:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=dcgzY6AW4IWy6kv/zQ
	Ydkwbh1iuoe7P/PM7yZbVcZCI=; b=PmgPQn0kGmlWobaMkQ0FDHTnptxj5jspYi
	QwjTmaWQc7CQQAlTnoeDSe0ImUxiKzjH23XSQvir/2Oo69FURYzQdr1OcU7jIP0s
	rMK9CF3Iga4SBDkp9/ZwWrzorO3OH2GRUholkFUjwRBrSzvO+DlAuXeyiXPXJ+iu
	tUb3IuJLrh3tFgvEOlNJ27YLaYO9EBWINTY0yTEc30dyyEZ4yNzkhgXGvoyEXkh8
	6VE+Ac1yUfsYDnMDSW1Yip2YkGXsmAcIa/9aNy1hj1LgfcCA4XAw74xNdstkfW/C
	NbVhPUw7fspERXlG9c10TIRPrBZhjWFbaO6n4dWHH09mYIsh3KvA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8g1nm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 19:04:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56GHC72L029672;
	Wed, 16 Jul 2025 19:04:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5bq7a9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 19:04:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bT17j27tj8q88Afw3mcVEGkobY9C7GVYUlwLBi5uU5mBitAF+wYbfdPC8T96uZjO2k1YBceBhPSFDLbw1+iQiqIfOEEyXr5qWA0K6hIR6owe6rKihPwFcbt/kXaLQsW7lV1r7sruNrzH8RFxViM+1PAHbDM3xD5GLQuDGzPIwZsRTkjyBdtrtdOLtPYvAXFhNf2I++dkLZAaHhKL0/CBOkVvopN279UUUzFeWoh9aO9SKoiOJel691AGJsG7pWPlow93QwDlHSnWdLYJMGXslL+fQ2iB+s9Qbb9VWII8LCyJlbcDD1BJ1ovIvIAgqNmZltu1Mad/nSAMsn6VkQ+O9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcgzY6AW4IWy6kv/zQYdkwbh1iuoe7P/PM7yZbVcZCI=;
 b=A3z+7zcfGLnIFcjd1Btj20e1j0ppP2iPMHL8TJdiarDhQgtF05889Hq2AXp0+xdzH0DgR0YkKpYW42/B/wD/oZ2T5+q9bTprJRqBgrcgm7EC9VpjuACW8lM2XReDuEvM1odUyfL8btimovRYfnSz7A0nS9Hqb2pQqEOyiiW4CbV6bKXIlW9iFKXr58L/3Hxq+d4KfYU/xdzmHo0wpDVfAEnkDLChY9+ckHaAu5NHmri4nD0TntrMWUzHvodHwDuhNWktwofo2HmXP04C22YNXbdTmLcqmablbx2D4poKntropIFtO6CZt+95tAs2Gj0LoJ5wcc90VEFAUZt8A3reCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcgzY6AW4IWy6kv/zQYdkwbh1iuoe7P/PM7yZbVcZCI=;
 b=d8U8cTD0CTON+/rLdRPPXKBxU9JWPp0etA/rxeKiCuksBvCLozRLmgQmlFHKtb5vzcswr8705o3r0NGqMt1Fgdr+Lwc6Yh9lnEZWvLBdT/qjWFFHRjBIVNX/ST8on+th+n5SoocfUTdCAfEEVEhH6BeyyXXeQxT3lkpsobRaVW0=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by LV8PR10MB7823.namprd10.prod.outlook.com (2603:10b6:408:1ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.35; Wed, 16 Jul
 2025 19:04:05 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.8901.036; Wed, 16 Jul 2025
 19:04:05 +0000
Date: Wed, 16 Jul 2025 20:04:03 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: syzbot <syzbot+ebfd0e44b5c11034e1eb@syzkaller.appspotmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, pfalcato@suse.de,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in mas_next_slot
 (2)
Message-ID: <11538f64-3444-4427-a167-f3c7301fff74@lucifer.local>
References: <6877e797.a00a0220.3af5df.0012.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6877e797.a00a0220.3af5df.0012.GAE@google.com>
X-ClientProxiedBy: LO6P123CA0027.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::19) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|LV8PR10MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: c58b87e3-0942-4cb3-5335-08ddc49b88f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CGDOoP2of28AFdlzQa6phr8TIPqV91hEB9LWnRLxgYGNgMxxDRwnH+SV+x6l?=
 =?us-ascii?Q?Bq5G5xTlalatq1Bhgsjvq4NOeG8t3mnboruxXnupO+9l8zoUNK5ZHCK6Bjm6?=
 =?us-ascii?Q?pQybXzbI0qsrRZautWlTG4Hjodz6+ergeVG18POfJTxAvuWfEaqB87asWuw5?=
 =?us-ascii?Q?YTHU5mWhyfhUV7cViZBaZBAYu2jEXOd+zLt5qatZgZX9pn0GOWQdNXP3Rzoe?=
 =?us-ascii?Q?r12k0KxN7+MT+TSBMTK5rvQs23j4EtOzqrP3v4QcJ5g5ZAsfgMrEwvEc8rvg?=
 =?us-ascii?Q?+t3/rXBF3BCEsmPaXweFVAnKCne6I/qqZUSN5YuPl2SP+MPm1Q+MpDi7GUhf?=
 =?us-ascii?Q?1eesddTmuBTo2Sr2irOp1JKVqlw1v3MQsPUrAtY54EysG4SXmjytx/FeQNCB?=
 =?us-ascii?Q?nmOb6mVs3MacjVZib+4VfQbBWhsKUG20iy+dh155PHR8KNydQKLs71h2OOak?=
 =?us-ascii?Q?epekcB1Sw0LpKMjyMJXL3TVOqcO30R7JYw6NxCzLPwEk9SAKk4AjkRTx+uBg?=
 =?us-ascii?Q?DB1EwJPJWMtgb5uZMUlJQ9wfocugb/gMbIKD63feFnKSer0Z/je2GK22dqqB?=
 =?us-ascii?Q?E9jtsSP2WsxU8XLeby7EPh6mvX21mlnyKKlf1tLpgFhpAdZvECcO+om6AeMM?=
 =?us-ascii?Q?NEztOBaELxnQdMFlTVAu+vHWvlyjCiXTO5ymIvoVSa/R3Y9rAhOVhHc/NRfD?=
 =?us-ascii?Q?vYFIv7QYZFfxE4awnABW4wG8mHxnZk4azb3A+1NJf67z99NnfsFtigyN1Nqa?=
 =?us-ascii?Q?iK7gO4KG0IE2RdSOHMcsn1elQy9Iapj+stpbXvT5CFnqFgSmDJk3dszLIFWr?=
 =?us-ascii?Q?+ZJ6l0eybx/HKT3hkPukCJu4GA7m7YXnxRXDG73sAP6Z4E6muCTha6ZKP6tD?=
 =?us-ascii?Q?6h6h4bb0sxfnKTWNSc0y09TxlurpHvsUkoSOCbQpqO0kYX2Z8voWqNLDU+Y2?=
 =?us-ascii?Q?L0Gwh1RwCH05RTPwAJM5sS9gK3OeE69w/F8H6GkpWq95GqZly0Q/6kBORA9s?=
 =?us-ascii?Q?2aZ2Ta4/EwkyzMfqqF0ySlOu7j0lOJwtNL4x8Nb0c4C4kIKycyn97b3Fkk8d?=
 =?us-ascii?Q?INu1nAOSB/uzZS0mSGWEugUG3JN7jmdNel6ZaQTzZaobGpuVM0UqqPT/AXTw?=
 =?us-ascii?Q?E0AybnbuaNF8xwV9+7CbApDJ/43iR5lFeypceIcHjgJCJINQD6EmlWo70SCx?=
 =?us-ascii?Q?7rD94YhOG7791RPBzZY/os+QeK70TwjGFwNe1p84iPuCrfMqVBx5Hk/VB1TJ?=
 =?us-ascii?Q?e7+EunCiSHTSg8Ig4sx4mUZlT+27bHkN+ND+9qt9ZmYEx82nD7GstwC3tPKo?=
 =?us-ascii?Q?j8nO5s6qRnAT8y5fdvGJzRBZ5Ye6U1viPwW/E0sYHKLb9T5+ydanF1/pGefi?=
 =?us-ascii?Q?W2adad3OcWJm8J48VF/I+lb7fDG9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wdLka2pvfvrSIKfmQl74cIHhNL1ps3pdn1EJpoqgLgT7V0PpbkDC/j8RweE2?=
 =?us-ascii?Q?sSmM6vLGpAQG5VPp12lsaVtMuXMMLW/punq3cb08ElbJ85kgT7izmm5jmVac?=
 =?us-ascii?Q?IQBO8z+l8VNDx+jyxEB+XFzx3twt3x8cdt0yX/qrD5IlmXZFRKTk0/wDhNM0?=
 =?us-ascii?Q?bfimtXaem+heFu4TVGT9i6SwEfmxnt1MP3fM0xL7GYNwzJCYB9nJ1dL0QzkQ?=
 =?us-ascii?Q?QoL9trjnk4gNo5z94gfU2exypJ4MrkfUdzXbeEU5zUBZdkiTXOj58YsyTtXv?=
 =?us-ascii?Q?tU5o/gIrvgZVvFaCRgKA08UUo8D2B+m4Fiquj9okP8F0W1oRCvI+eRbREHjK?=
 =?us-ascii?Q?tj+lcfKiMA2MWNqzJQJ85t4Oviz2mnI8AuPHW+XS5NmyXhcQzmCmKFYOS+sI?=
 =?us-ascii?Q?LwyahPoHwI4vcKFm2V2LYqfGNYoq5ftZV8+tvWfCot4KN8G69NKKq45Uh0g0?=
 =?us-ascii?Q?KSl+X+0bwqf0JleTVVGMt0oEiPv6hHTSfZmsQOEnZdwIoSvv7nKXHBWJYPNw?=
 =?us-ascii?Q?BORRCLbaUmUx7+s2b7CJRZ8OxzJ6pQyWZ9argIW0a5VgrnUdRay1t2o+dEks?=
 =?us-ascii?Q?ZzgpHtvwL5H/XSiuZku21h6yI/Wl0HUL8fecFxFZwLPGUyrMJ0Ww8zoejjp5?=
 =?us-ascii?Q?L1DA4VJFL16i8bsGA0wEAgz2z325nx+3NZ1hodX/Zi+dtBj/f6jjsmdMoUtD?=
 =?us-ascii?Q?+4Ksrwc5S+1ib6KK0MGILxLuw77ARFwOl1Jr41tr5tgpqzxKY6co6iaGNksT?=
 =?us-ascii?Q?CqHe+vLDY0Ze6dVcwmWHxs3yjYMU6Sb5E5JBYBwvgHVLX7dx0i1sctPq9vR7?=
 =?us-ascii?Q?Hv2bUzf611LCKTU04DZZyYI8jEmFZ1FNVhSh5FJ21NBVUbIf74niU19KPGWF?=
 =?us-ascii?Q?k/wMXvSmcrqgbd2wyNp1yRv+t1hQPF6cocP0pMvsV5gCgMcbgdNGFOiBPRTg?=
 =?us-ascii?Q?Iyg8lWigBLzcQdOw0VfwPGO7TS1eYQxMi6m3Qqz0j+kZk4PHJWHlSLAOZ2m6?=
 =?us-ascii?Q?59FYKPkaN3aNVHEWwaGO8U++cDvUhcubGiz3eMdQyiQ+kjEc6qZrIbfj/jgv?=
 =?us-ascii?Q?/ooA+iAHm3H3jIeiiThm3JC3eRaO1fStPDWgxHB/4Fn4k+OwHnwcmeznHdJx?=
 =?us-ascii?Q?krgV4nWWpKsoSs7boAj66jkaeIIwQJplZ5pHTyPwZcIm204NZPRToCtJJzDD?=
 =?us-ascii?Q?p5D8qiJCKaruRcCC7P09lAFvGpJ005gE6z1HnUoAMSsiGcgy56fmtl9xo1iy?=
 =?us-ascii?Q?giHE+y5aRBd0ZMkIspymsXS9TSYZ//yrZhHnD36nsmHFS2dAkwVkfg9PZ/ZG?=
 =?us-ascii?Q?e3DO7+RhX//KH6WKV56Ima3+xX/WXaap1xJu1llJLMNDiixw2RHNtBCiAywr?=
 =?us-ascii?Q?yLPOK2dqHr/fc4mNlWqSDs8YIIrY5TthtaYLnO0m45+j4pZN+fM4o6K1ZR6h?=
 =?us-ascii?Q?qg4lPT3OasfhogMkCQV0TGBc69gSwJT30kVBWgdwi5Loh6X3mOv177tILzcL?=
 =?us-ascii?Q?r7QY33CIhPp+5D9XwYrttPsz1slhKBQvSPWoQLZSSePbZUwnsGyNK17tfEW2?=
 =?us-ascii?Q?09K5LC/E1qYqOXdsY1Bp72CpErtlJ+7O1El1zssFvWUbOwkoiqtoEVuF9wA0?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Rc/xAnohS6tLol+DRYXz+G80kp7CMyLHDBCHhozcjRgCjHAV6ThftTH4nEsQIBTPwjNiGMtA1ZOICGUSfsb7M0DRkUIubQ7R03/cXAl4jFLvIZON/syYPB5yKJ67g29d6fmCeyr2Zw2uN+1tOxGBKpzOYKve0Fy6fzfRy+gdFoXsiTvpTNqsGMNIK+X01juaMPOMU+DKMrlmsokIKpZ+A6S9hT+jPTQiraXs5HoqHmqdxAsbQCfJ838r7uPNCckIbRqwvT5pgf/WKTxvF0mncGzO01aIrPiYIjK46bYIwN1aW4qtuWodxAxDMCNAc+AXio66/pgq1F26cST+aPJduQDptZxyui2EpnegFKRpt9KGcki8VylpEQX1dIENkmTGCKUe2TsBLe7e/cwFo27lNfUOaLzlnw+cUK7SIb4ST7FXDyJTl4VEAMsRLqa45CFesNG2BMryx+q6l+NkezB+Lke3qExB5JsAGEnkrBk5cwQpqxUKV5qG9TxlpPO/Prg8xSv7OVqgYV/UfxdK4rhAAjuW1YLJY++3kEgTE34bUZ+zgpdiDx4R3omHO4Qx2dQvOzpmZq8W4hBAbh4Tp3Gx9PDujS61+G8JYYnW39HnIl0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c58b87e3-0942-4cb3-5335-08ddc49b88f2
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 19:04:05.4322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxvvpYfShNnDbk9DzrSO09/MiObiN01LEUCqOFMxbZ740qxBRHsADXT747yRRpX+AyQI+FB6vHRb1csQBDAzW2q6XNVCFBenTudjWl3ldSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7823
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_03,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507160172
X-Proofpoint-ORIG-GUID: WacIe1Dbi5UErz0le4LFvNamaBfY1u1C
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=6877f7a9 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=edf1wS77AAAA:8 a=3g80flMcAAAA:8 a=oHvirCaBAAAA:8 a=hSkVLCK3AAAA:8 a=4RBUngkUAAAA:8 a=hMFDTOyKs6d5ScOmRKoA:9 a=BhMdqm2Wqc4Q2JL7t0yJfBCtM/Y=:19
 a=CjuIK1q_8ugA:10 a=slFVYn995OdndYK6izCD:22 a=DcSpbTIhAlouE1Uv7lRv:22 a=3urWGuTZa-U-TZ_dHwj2:22 a=cQPPKAXgyycSBL8etih5:22 a=_sbA2Q-Kp09kWB8D3iXc:22
X-Proofpoint-GUID: WacIe1Dbi5UErz0le4LFvNamaBfY1u1C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE3MSBTYWx0ZWRfX3LQShcqq0zaK YD2C8bnbpdj/uAEZk8SjLDhSis4rvOalLVG/T5nwdMiCLxXcLTvVnoK+GzcIBkm32MGLKj8KUHb 3qDm2HexYa6T3+JW4YVn6AkzSM/0I9R2HO8WPUrdwuFFnZZ3VBd26AUkpWweyPtZRX/4m2ixPAG
 7uhbj48fE7GKqHazxirldIRU1qYnRCjyVu/ncvkFrH4Z4pZFWZ+S+21UnqrAS9lT9/Ceff0c358 SG966Hr1WcJJeusVDmmojW6f1RkYtPSbE98r8IMW1rA/3+rPzGHhd8Bm1Aj2QkBXzPAWDMwN2Fn qCyFWg09IwNX4G8G8PCumHQqcu4gYAgAzMrRw3ZwJ+LmlKb7OdjgAe/L2Fa9BQn7yvVAr6UfOzU
 sLDOtOvImv8tCNy68BarhgycW+aPFvRP5M7cEEjyEJzhfGdaSPBVsEGqDwe0nZXsHRsv82oa

OK looks very much like the removal in v2 of the resets on unmap were a mistake.

Working on a fix for this.

On Wed, Jul 16, 2025 at 10:55:35AM -0700, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    0be23810e32e Add linux-next specific files for 20250714
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=11a9a7d4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=adc3ea2bfe31343b
> dashboard link: https://syzkaller.appspot.com/bug?extid=ebfd0e44b5c11034e1eb
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d0658c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dd858c580000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/13b5be5048fe/disk-0be23810.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3d2b3b2ceddf/vmlinux-0be23810.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c7e5fbf3efa6/bzImage-0be23810.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ebfd0e44b5c11034e1eb@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: slab-use-after-free in ma_dead_node lib/maple_tree.c:575 [inline]
> BUG: KASAN: slab-use-after-free in mas_rewalk_if_dead lib/maple_tree.c:4415 [inline]
> BUG: KASAN: slab-use-after-free in mas_next_slot+0x185/0xcf0 lib/maple_tree.c:4697
> Read of size 8 at addr ffff8880755dc600 by task syz.0.656/6830
>
> CPU: 1 UID: 0 PID: 6830 Comm: syz.0.656 Not tainted 6.16.0-rc6-next-20250714-syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xca/0x230 mm/kasan/report.c:480
>  kasan_report+0x118/0x150 mm/kasan/report.c:593
>  ma_dead_node lib/maple_tree.c:575 [inline]
>  mas_rewalk_if_dead lib/maple_tree.c:4415 [inline]
>  mas_next_slot+0x185/0xcf0 lib/maple_tree.c:4697
>  mas_find+0xb0e/0xd30 lib/maple_tree.c:6062
>  vma_find include/linux/mm.h:855 [inline]
>  remap_move mm/mremap.c:1819 [inline]
>  do_mremap mm/mremap.c:1904 [inline]
>  __do_sys_mremap mm/mremap.c:1968 [inline]
>  __se_sys_mremap+0xaff/0xef0 mm/mremap.c:1936
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f4fecf8e929
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff93ea4718 EFLAGS: 00000246 ORIG_RAX: 0000000000000019
> RAX: ffffffffffffffda RBX: 00007f4fed1b5fa0 RCX: 00007f4fecf8e929
> RDX: 0000000000600002 RSI: 0000000000600002 RDI: 0000200000000000
> RBP: 00007f4fed010b39 R08: 0000200000a00000 R09: 0000000000000000
> R10: 0000000000000007 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f4fed1b5fa0 R14: 00007f4fed1b5fa0 R15: 0000000000000005
>  </TASK>
>
> Allocated by task 6830:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
>  unpoison_slab_object mm/kasan/common.c:319 [inline]
>  __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:345
>  kasan_slab_alloc include/linux/kasan.h:250 [inline]
>  slab_post_alloc_hook mm/slub.c:4180 [inline]
>  slab_alloc_node mm/slub.c:4229 [inline]
>  kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4236
>  mt_alloc_one lib/maple_tree.c:176 [inline]
>  mas_alloc_nodes+0x2e9/0x8e0 lib/maple_tree.c:1255
>  mas_node_count_gfp lib/maple_tree.c:1337 [inline]
>  mas_preallocate+0x3ad/0x6f0 lib/maple_tree.c:5537
>  vma_iter_prealloc mm/vma.h:463 [inline]
>  __split_vma+0x2fa/0xa00 mm/vma.c:528
>  vms_gather_munmap_vmas+0x2de/0x12b0 mm/vma.c:1359
>  __mmap_prepare mm/vma.c:2361 [inline]
>  __mmap_region mm/vma.c:2653 [inline]
>  mmap_region+0x724/0x20c0 mm/vma.c:2741
>  do_mmap+0xc45/0x10d0 mm/mmap.c:561
>  vm_mmap_pgoff+0x2a6/0x4d0 mm/util.c:579
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 23:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
>  kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
>  poison_slab_object mm/kasan/common.c:247 [inline]
>  __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
>  kasan_slab_free include/linux/kasan.h:233 [inline]
>  slab_free_hook mm/slub.c:2417 [inline]
>  slab_free mm/slub.c:4680 [inline]
>  kmem_cache_free+0x18f/0x400 mm/slub.c:4782
>  rcu_do_batch kernel/rcu/tree.c:2584 [inline]
>  rcu_core+0xca8/0x1710 kernel/rcu/tree.c:2840
>  handle_softirqs+0x283/0x870 kernel/softirq.c:579
>  run_ksoftirqd+0x9b/0x100 kernel/softirq.c:968
>  smpboot_thread_fn+0x53f/0xa60 kernel/smpboot.c:160
>  kthread+0x70e/0x8a0 kernel/kthread.c:463
>  ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>
> Last potentially related work creation:
>  kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
>  kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:548
>  __call_rcu_common kernel/rcu/tree.c:3102 [inline]
>  call_rcu+0x157/0x9c0 kernel/rcu/tree.c:3222
>  mas_wr_node_store lib/maple_tree.c:3893 [inline]
>  mas_wr_store_entry+0x1f1b/0x25b0 lib/maple_tree.c:4104
>  mas_store_prealloc+0xb00/0xf60 lib/maple_tree.c:5510
>  vma_iter_store_new mm/vma.h:509 [inline]
>  vma_complete+0x224/0xae0 mm/vma.c:354
>  __split_vma+0x8a6/0xa00 mm/vma.c:568
>  vms_gather_munmap_vmas+0x2de/0x12b0 mm/vma.c:1359
>  do_vmi_align_munmap+0x25d/0x420 mm/vma.c:1527
>  do_vmi_munmap+0x253/0x2e0 mm/vma.c:1584
>  do_munmap+0xe1/0x140 mm/mmap.c:1071
>  mremap_to+0x304/0x7b0 mm/mremap.c:1367
>  remap_move mm/mremap.c:1861 [inline]
>  do_mremap mm/mremap.c:1904 [inline]
>  __do_sys_mremap mm/mremap.c:1968 [inline]
>  __se_sys_mremap+0xa0b/0xef0 mm/mremap.c:1936
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> The buggy address belongs to the object at ffff8880755dc600
>  which belongs to the cache maple_node of size 256
> The buggy address is located 0 bytes inside of
>  freed 256-byte region [ffff8880755dc600, ffff8880755dc700)
>
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x755dc
> head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
> page_type: f5(slab)
> raw: 00fff00000000040 ffff88801a491000 dead000000000122 0000000000000000
> raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
> head: 00fff00000000040 ffff88801a491000 dead000000000122 0000000000000000
> head: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
> head: 00fff00000000001 ffffea0001d57701 00000000ffffffff 00000000ffffffff
> head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6828, tgid 6828 (cmp), ts 120765032919, free_ts 112542256570
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
>  prep_new_page mm/page_alloc.c:1859 [inline]
>  get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
>  __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
>  alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
>  alloc_slab_page mm/slub.c:2487 [inline]
>  allocate_slab+0x8a/0x370 mm/slub.c:2655
>  new_slab mm/slub.c:2709 [inline]
>  ___slab_alloc+0xbeb/0x1410 mm/slub.c:3891
>  __slab_alloc mm/slub.c:3981 [inline]
>  __slab_alloc_node mm/slub.c:4056 [inline]
>  slab_alloc_node mm/slub.c:4217 [inline]
>  kmem_cache_alloc_noprof+0x283/0x3c0 mm/slub.c:4236
>  mt_alloc_one lib/maple_tree.c:176 [inline]
>  mas_alloc_nodes+0x2e9/0x8e0 lib/maple_tree.c:1255
>  mas_node_count_gfp lib/maple_tree.c:1337 [inline]
>  mas_preallocate+0x3ad/0x6f0 lib/maple_tree.c:5537
>  vma_iter_prealloc mm/vma.h:463 [inline]
>  commit_merge+0x1fd/0x700 mm/vma.c:753
>  vma_expand+0x40c/0x7e0 mm/vma.c:1158
>  vma_merge_new_range+0x6a3/0x860 mm/vma.c:1095
>  __mmap_region mm/vma.c:2666 [inline]
>  mmap_region+0xd46/0x20c0 mm/vma.c:2741
>  do_mmap+0xc45/0x10d0 mm/mmap.c:561
>  vm_mmap_pgoff+0x2a6/0x4d0 mm/util.c:579
>  ksys_mmap_pgoff+0x51f/0x760 mm/mmap.c:607
> page last free pid 5955 tgid 5955 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1395 [inline]
>  __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
>  __slab_free+0x303/0x3c0 mm/slub.c:4591
>  qlink_free mm/kasan/quarantine.c:163 [inline]
>  qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
>  kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
>  __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:329
>  kasan_slab_alloc include/linux/kasan.h:250 [inline]
>  slab_post_alloc_hook mm/slub.c:4180 [inline]
>  slab_alloc_node mm/slub.c:4229 [inline]
>  kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4236
>  getname_flags+0xb8/0x540 fs/namei.c:146
>  getname include/linux/fs.h:2914 [inline]
>  do_sys_openat2+0xbc/0x1c0 fs/open.c:1429
>  do_sys_open fs/open.c:1450 [inline]
>  __do_sys_openat fs/open.c:1466 [inline]
>  __se_sys_openat fs/open.c:1461 [inline]
>  __x64_sys_openat+0x138/0x170 fs/open.c:1461
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Memory state around the buggy address:
>  ffff8880755dc500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff8880755dc580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >ffff8880755dc600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                    ^
>  ffff8880755dc680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8880755dc700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

