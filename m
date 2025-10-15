Return-Path: <linux-kernel+bounces-855090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 364A5BE0336
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F1E5506929
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9252924DD0E;
	Wed, 15 Oct 2025 18:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mJbP4emm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a8vUfdB8"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E2F3254A0
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553271; cv=fail; b=WYeR+xZF0XfyHw0dkBv5lHp70v1C0uuAO9jdtGjcoADk4DfiKBye5wqNNVcZjc3hiwwcLotTaTukxixyz5qcPOEdEqfs7UVcVA5QXjKj4s5u1GLh7XZJN0YCDXMEFoZHpeqyYOoOU1dpX8xud6jtw8WXtQUuLtABZBBajslEjzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553271; c=relaxed/simple;
	bh=7xqB5i8OLSIuZf8QEPw5MQf0ThsVS8iISfv3BgaeQng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Quz+so6gFAnXtMXUHXAJ64MSUU7spy8yz+8pi4NgpXwFdhc//lX3hnbJS8rd9Lve6u7ca9oJjc2wt2QGWitV+LkfJfyev0GkgpKzJjtHt+l3sKnyWLpsXyGRbB48xkz0yb0av4vhjT2fkjUwvhHxXqKk/8Q9Q81Wm2hajYJkemU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mJbP4emm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a8vUfdB8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FGC8Cq015700;
	Wed, 15 Oct 2025 18:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=PzZD2MHTtTTyn5+8Ci
	psDxbjI1pQu3jUL3q9OzUoanw=; b=mJbP4emm0lQyPcg/yOfAk8l7nTCMAFe1cb
	jU/mk2AY5uXPBCFCe1ZVr5TpZdmJi3waBTOWMwZkTy6Kr+NBIJh2lyP3WTprAfnE
	nNPMCWh07MrM8/Fbj8Bfmcd4kI5aXAHdkDt5GVkViIzbmV+RAXXL7K5Pj4DBjv3U
	Sza2hz/9mOZOA4SQqTNEMXmcuTVcvuNWGRSv1KMgaHZuTwIGj/o86QwiupBcVLgB
	G1Rb1rDS1913eAiU++d2tk5/258yGZuydUuOPwiOVTPb+iEZhjhDKQ1eC/8qGlx6
	QNTja0QdjrvRZQj6u+DH404cr4j5QHxYi7sQWeooelgumA9/7bXg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qe59fa14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 18:34:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59FHt6v1009793;
	Wed, 15 Oct 2025 18:34:02 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012010.outbound.protection.outlook.com [40.107.200.10])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpgq3ud-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 18:34:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBJhSkXIPaCEW2cvqPd14Ye3xt1tsonYUjdzPB34N+GUe0Wf1o7KgDCadzzlsbebErT1dGPE04HDseF8cyejZpxG1fVbzwahTmy02OfP4ARBF88I5krFIXzoIozU+Q/G26bO9qtfHzq9s0v5/N1YaGBdGut71Sk6PiLJn6hIuO1cpxroBDiv1NnbLSuW3tQ5zSk4NJkQtpdbzG25gYWJCCiFapcgHvgCZ51bmdlRFmsBJ4CrdypB7hR78x5QuWkXZ/NnINB4msu/VK2U4yIA2c37UiXQVzutVrzIYgvGU0LxZVnnnlObzRlh68UU5OKG5FlasCT24JDlO4M0e7s16A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzZD2MHTtTTyn5+8CipsDxbjI1pQu3jUL3q9OzUoanw=;
 b=KbJgQe6hclRnhZy8HgUUFLktOQo2oxjrFVx7ZEz7YjvPHfB3ZANOmug3IcM910oedw5wTYLUfVbC9Aio+UU9/02fxF21CT8CIO44ZxBAPtcCayhZMrC171LWydIyAqwNudqhOjdPf7fCH7a0/NAaaGnS43U0ta6St/DAzc/sYQnTaWt4jFTPfkLCDjXznXpuDCPGzC+GZgvKSr11SCzw6/qIHLdv9rG+yGKlDc1rWGXzawUZMey57Qw5QjQqtysxsRTqZ0xuhuxZzYYTc8yMY4h7K0qCgO/S+h+IJiM/++D+snaiNNlSfhDIk8lKRUCsS4HN12xB/pxTsqrx+QxTMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzZD2MHTtTTyn5+8CipsDxbjI1pQu3jUL3q9OzUoanw=;
 b=a8vUfdB8owCm8Iz8VNXLl3iQETmua3w/ujx5nOSxNrmBZEd2kUsFwEdpx1ZhaGtHMgNBzopojPBnGqJ5MuuB9c8uZIKbPbR4ZPt3z8ETTwWMUe7FhD+r7G6z49mlKMz7M1r4+Nr8YJDqrXUvuTFC60oArYr9bCQbKYAQqYV0Cb4=
Received: from MW5PR10MB5764.namprd10.prod.outlook.com (2603:10b6:303:190::15)
 by SJ0PR10MB5720.namprd10.prod.outlook.com (2603:10b6:a03:3ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Wed, 15 Oct
 2025 18:33:58 +0000
Received: from MW5PR10MB5764.namprd10.prod.outlook.com
 ([fe80::412:f26c:21fc:faae]) by MW5PR10MB5764.namprd10.prod.outlook.com
 ([fe80::412:f26c:21fc:faae%5]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 18:33:58 +0000
Date: Wed, 15 Oct 2025 14:33:54 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Feng Chen <feng.chen@amlogic.com>,
        Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@kernel.org>,
        Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Tao Ren <rentao.bupt@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Linux 6.18-rc1
Message-ID: <b74ike3nxjmhjsfdwq4b3732sgyojdfy5mwt2hflkc7aaqalnf@iclsvge73ibh>
References: <CAHk-=whPJTtX5u1m47fPUD2g2Dc=Did_6OqCVj6OQPKFgfKn9g@mail.gmail.com>
 <f594c621-f9e1-49f2-af31-23fbcb176058@roeck-us.net>
 <c45a8502-3af2-4d5c-a660-2922b4e040bb@roeck-us.net>
 <68841c19-c54e-4837-80bf-d180f2c35499@roeck-us.net>
 <3exillpepa4jjxsjkp5vgn4347tsvt7q22m75tp3ncavkyzgl7@juvt3p4h53km>
 <81c865ca-a9d2-413e-b43d-eedd7e4e88a1@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81c865ca-a9d2-413e-b43d-eedd7e4e88a1@roeck-us.net>
User-Agent: NeoMutt/20250905
X-ClientProxiedBy: YQZPR01CA0165.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::16) To MW5PR10MB5764.namprd10.prod.outlook.com
 (2603:10b6:303:190::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5764:EE_|SJ0PR10MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a843342-4c29-444b-52c3-08de0c19674e
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?9S906ezCwukIxRvjJsRlCA/V8wry4ZV5fFjQt1BuKYjOf0xEyoex0lUQBpQn?=
 =?us-ascii?Q?hyHlpWURMUQXLAtj89Zw8S6eiyZceYrqBnlPXdcdX8zxE1Zbe6hI3jOp4Czq?=
 =?us-ascii?Q?KEm3yIkp4v4ijelauLN9XwiS/mMFOb9vlpY9k4SxtZUAOdt3Z9Vm28k5Myk8?=
 =?us-ascii?Q?NMZvMbg6Y3C4Ak3qB9Qu5swAeuSKPBJ260FlNiPQcmfA7hvUUw3dMYwQ8ahz?=
 =?us-ascii?Q?mCVDOL9HTAxK8DSuY220Avi8yhubDJ4I2JNJiGwOMVbqfANzHPUNi0Qt94Iw?=
 =?us-ascii?Q?BYybNSf1bubsCdYm5JDlOycZPS12xdW33QooE38sYu3V64EjwL3etuz9JW72?=
 =?us-ascii?Q?UH0WkAOKSYXRq5p7vqD0ll9WxgMkjBo2+BzbU4JE0Ym2B6CAssxtEODZZTq1?=
 =?us-ascii?Q?LJFHMwYGJUxmVsFD3M5xZU245v/ZY5XHhlxm9SeCikCJx3ZDuekXL+YHBcxb?=
 =?us-ascii?Q?oLn/Ov+sGmE1sfXuQuX2zdN6r7ydAJgsJD/WbMs34HbAQJCHI2N5aTNEnBhC?=
 =?us-ascii?Q?VDUzQfempRN1IAk3tKj5IG//LKc4V9X4j0eOU57kkdfFhI/ehlZYFyDL8LJ2?=
 =?us-ascii?Q?ZlruFHEwW/2A4UWejA3ItJEzQ2i2wn5f55mbqAoepVh4GJySBgtR1A0p3mCE?=
 =?us-ascii?Q?rw5+nIVzAMB6uDJSjdGivj5gGi3+HLKaz8AbJuRZA1Z1Fxb7VTsTjv6JPCbv?=
 =?us-ascii?Q?WayBieFzz3Q6gaP2m3Ha4hviQGqeN1o303WsjQTz8Af+6RnfP/nwK8ZNQbpl?=
 =?us-ascii?Q?vOTPBL8CaI9hTd/w14RP2qcCEbFKi1DO+arBNLgC2JRBZUkLxpld0HfCdASC?=
 =?us-ascii?Q?cupg9/rSg06znSCnYtaC9laXgJKmEmDY5Kk41uR5kCcp0kF+QGO7yftlnTKJ?=
 =?us-ascii?Q?gJpbKZAkkj2pvt0RgWnIIeUw77opSoP/HDRh3HXwbqIlQOkYPAY5Ijlkw+ni?=
 =?us-ascii?Q?rAXQVi70aeYirUjuULB+nMB3Gg9uy5QhNHi2NuGYglG1yyZEB3+1CEL48U7B?=
 =?us-ascii?Q?qFtCg1sPD8ROCfxhPipfTKd57ut2XFup4XPhTE1sLRKxEUHU+StvqBC4kntH?=
 =?us-ascii?Q?tnG7AGqwQTpX+uMYN/H3VkubXCusodz86DmRA+HEBoNR3ybrC3K+0XuGWctK?=
 =?us-ascii?Q?W05NXVkyFpd1gTDllLQYKsca7yFjGtNpSLlm3jCXYF22NiqNabIFy9rc+3K5?=
 =?us-ascii?Q?S6NsqRE0uLlE3G6cak6m8J6OhtDXmiFmoUgPhQSPb7j4Rp2Kdpv9pgokUJ3R?=
 =?us-ascii?Q?ycIthfof3vb+6nAtL9xCk2g3lkPAxq1Khei7mePV1FZuK0aI889iWuN7E9d2?=
 =?us-ascii?Q?qTzGLmIG0HJJBi8/oHmLPHzMh9eOnZNTuDqiPAmFSBcEctHtoMAcww2/3nJI?=
 =?us-ascii?Q?7L6iwsmjK6dYFpwIs8NimHrLHUNJB+Z7v4hin7XSUiTxuZA25KcPqiseThoI?=
 =?us-ascii?Q?xbPeW7KvyKa9d/3R9pOt55+ec2YPfIIW?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5764.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?r7KS/GEnrelo5/mkB5pD3BnI/LylXofevNFAv9Z+I2CqKTc9sGU1G0HdsI2i?=
 =?us-ascii?Q?LYca42sVP3sJzrN9wtKtYs0HuRxuYISGAibSsq9CUupgSj/wHdF6fhiigRwp?=
 =?us-ascii?Q?Rw4GN9z6dTxZk69gdHrw4TgVSkXugTOZDRD5mQ3SRyVpsK6WkqvVpLYiTuhD?=
 =?us-ascii?Q?L1AxB2RUSTjW7iRGMigQ9tCOHfc0/7fuQu7lt+e+QCK5M89BMEBLWgi8hcS6?=
 =?us-ascii?Q?eVXsbwzpUZ/JAKUAGKR9FNrxJONT5jaJ+ZWoiRJndifIJXiU4iWNsxjaG/kM?=
 =?us-ascii?Q?6cqzw3n8ikTEO4ZP6aD7qkqOAuET+gzeZm1y2fxMcmVzS1NB+MXMtGEwAzLg?=
 =?us-ascii?Q?nuYY+7nnKdHym4HmhHTAM74SYLqNd1IBETBxF1fHd6O6jpVXtqd9LsWkIkDL?=
 =?us-ascii?Q?RTIhpotKGy5a5C/whSUjIM6boPaaJbqsL6JLXtCH4l567F9yqfffe+aXBUuK?=
 =?us-ascii?Q?yuaKIOMAGWViHdzhdR6DS7A7XTeAzhObQdbbymnLq8m3B7v46rAsijhunaOt?=
 =?us-ascii?Q?o272gzZ29wr26kY2eP6YBpuQDGoxufV3SZOLB5PTovjpNFjd9Xi7OTo7e/37?=
 =?us-ascii?Q?io1a/DsPk4iXY7nL9DoG0Y3IkvSYRmnjRU2gUbTdKmeZAamwelvFi4kEJPuX?=
 =?us-ascii?Q?4rH/vHs682+Ffiuc3Lzp9lTMsc8m7v0xycIH91ieE6GQqHl31wovl71BPiZU?=
 =?us-ascii?Q?HnqyXhl8U5aTyqonSywVg029LuhRVRoXmKIuBEALtGkqUdydwyAgVrRVJ9YD?=
 =?us-ascii?Q?SCpPEVtsGwC93MfEexL7CFPklkDQzTTVXSYLxCbHBY0u8fofkNAZM+tkV5RT?=
 =?us-ascii?Q?u6SrWo2sVmr3+o984BFx4oPXMBVAT/943n3ylin2++VXqPhXpJ1M+gIfzJYF?=
 =?us-ascii?Q?tu17wjJLlzFra5NYCf5CBSjOE3+osW9IgGHEh4PE0P7HOIDIC0bpyf0pXROn?=
 =?us-ascii?Q?Ltx+S+vpEjlXx7SGKplLF+2+Tb11l66maupgsnmBuHrnd2Wr1nbQ6o/6euF4?=
 =?us-ascii?Q?qsd2lxJ90hqgw5MndeBQQzVRHn7OhKkYGzd7pF4uvKGlQCLcJ2T3eZwKX8Y8?=
 =?us-ascii?Q?2/LPlJ4u55eG2JN7+Kxyn3h7hCsmn5t3mv0RCTSM9N24CeUKqgHEvRECjRZQ?=
 =?us-ascii?Q?b7OrxrRDIkS5vFsk8t6iJhaL7y4hLWy3umPy3FHB2F1FUZKWvguCIx9YlNny?=
 =?us-ascii?Q?XxxgtNoKLSDOngUe21IsfZgOZ+bJc/6kQR6NMiOV44tMsJYKkTvn1bIbdacN?=
 =?us-ascii?Q?a0i0iRInVwCt2QKlhKI/hra2crqiKLVZByKtUEL7yKNSDlDbLpYo/rApaFFK?=
 =?us-ascii?Q?3HV/oGIBl6acTH+GzeU4LrcBWi69T6sAKmDa7A7K3ZsFBD6Oag0elYO4pq1a?=
 =?us-ascii?Q?z60DG8B0ibeBgP/kEk8m7uMPqV9KODN3paYAV/jvrKoxeUWBqY8GfhLzzzxm?=
 =?us-ascii?Q?ARP3KU3ej6LkSmuKc+2VBa0H1H/28BKc6s3gX0vOaoq0b0c6kUyo45Ib52eO?=
 =?us-ascii?Q?ebwauT/mr0ywhk78pilrZI3ky61zklPOhINu7Xs4oQ/4z02VpGseXxo2aF1L?=
 =?us-ascii?Q?K1lhmP0l1erAp9PB7YcJB6Vv1KIWeX8kg+b5MxZL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vwjKso7gaYRiU+GCzfaJGAhQDXI2I3C6Eop16/uYt3an/t7GzNuGtGR8+xSpvQO+ngEnruJMAiG/SCVUahEgnfgJOMSXz7tJN1lpDa8p4wn789mPzObPNW5/6D1guF4AWNtc+jNMObxjG1G6nGFFWGBCbEzNDhJK52o+P3BmN3zlk+enzFm98OjycrcxNy8b2YGhfP8XLzF86yPNTi6OZp91QeN5O7A16ebMyTa39Mv2Hg8gqM1cVWTiNky+S/QdvnjbQoULrgkXrBI1RIiFfjedwcgDXGqrwd/7mn1JjNnOqMPeKdbgwnxaEFaWtep3zUUTRM4dAIy5N+f2p+7syYQuYGEYVPCCSI3MzG093+aFL/RQwuDgyZxoVI+uboEOIvpF4J+3fIQci0Czo7CUZ0iPTchALyiOiE28ENf6Nig59rjXPoFlKLkGEtQnAwdEz2C8ozIxsbLrAfH76baFEVKf9wCLZNPwvlKF5SKw8lsMkhni92vR9XjMtztNASIwqM94ORWNAXo5OWXaILTOVw1+BSTCFkVLBM7RwGc5N3zxFXt4BxeWdB3oU41hximA+AmFbPEfhJKwkjOJbi8BXhOdoW4Xjo6mTpQK4UXnIj4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a843342-4c29-444b-52c3-08de0c19674e
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5764.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 18:33:58.2161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98v7dyfaPOyfeeUGflXRbIWyljAf0RWvNpmotuPXYoEflo7f9ArnD50EVVWZ6RdDcsarzy8xUMQScPvfixEwoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5720
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=772 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510150137
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMCBTYWx0ZWRfX6ZfP5y42Q1ce
 E8aCky1zoZ4Llpxu+3hGYZRcTD5XDgxnj2Fr6bqbWMV2HgMHxcFQBHo+HxIFeY8Gwj/2UDP4rlF
 DFPOMO0wvBXZ47GqmAjevSt36B4vEwFLfJDbRop8ns30IV+40+y23YT9g9/XDWJ/mLC85BxG2fh
 BeR1VVxZEeWH4Nwv8OBGB1e02gAjXhkhSoQQ25g2cu3UfbgmrTc25HnK/Dr5zwdV5JGEncny7iK
 FzBz4niogt1gn2ErmFHRBMsmUmlRmFBCJhn4ZOpbmirE/GEgAXTJlWyghu8NLfa0Wj0m2jZ7+tj
 hy5QWK4MR6+580/A4rlC42UMuagCWNfNGqhwI9pDbjiJ0gBYh2lSnSCX5ALtpZ8BbKCRryaHoQ3
 IE8B26ExwNtIFqLSLba5q1nNfTjTmCTmrvS8tL3WY+4Ton6bUZ0=
X-Authority-Analysis: v=2.4 cv=V7JwEOni c=1 sm=1 tr=0 ts=68efe91b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=_jlGtV7tAAAA:8 a=VwQbUJbxAAAA:8 a=Y8er08sv4TkccAeGjroA:9 a=CjuIK1q_8ugA:10
 a=nlm17XC03S6CtCLSeiRr:22 cc=ntf awl=host:12092
X-Proofpoint-ORIG-GUID: YCdu7ijlNRptX6wQOtwgz0YWOKVuWCWs
X-Proofpoint-GUID: YCdu7ijlNRptX6wQOtwgz0YWOKVuWCWs

* Guenter Roeck <linux@roeck-us.net> [251015 13:48]:
> On 10/15/25 10:28, Liam R. Howlett wrote:
> > + Cc Vlastimil, as you are indicating the slab merge.
> > 
> > 
> > * Guenter Roeck <linux@roeck-us.net> [251015 06:02]:
> > > On Mon, Oct 13, 2025 at 09:46:44PM -0700, Guenter Roeck wrote:
> > > > On Mon, Oct 13, 2025 at 10:08:26AM -0700, Guenter Roeck wrote:
> > > > > On Sun, Oct 12, 2025 at 02:04:32PM -0700, Linus Torvalds wrote:
> > > > > > Two weeks have passed, and 6.18-rc1 has been tagged and pushed out.
> > > > > > 
> > > > > > Things look fairly normal: size-wise this is pretty much right in the
> > > > > > middle of the pack, and nothing particular stands out in the shortlog
> > > > > > of merges this merge window appended below. About half the diff is
> > > > > > drivers, with the res being all over: vfs and filesystems, arch
> > > > > > updates (although much of that is actually devicetree stuff, so it's
> > > > > > arguably more driver-related), tooling, rust support etc etc.
> > > > > > 
> > > > > > This was one of the good merge windows where I didn't end up having to
> > > > > > bisect any particular problem on nay of the machines I was testing.
> > > > > > Let's hope that success mostly translates to the bigger picture too.
> > > > > > 
> > > > > 
> > > > > Test results don't look that good, unfortunately.:
> > > > > 
> > > > ...
> > > > > Qemu test results:
> > > > > 	total: 609 pass: 581 fail: 28
> > > > > Failed tests:
> > > ...
> > > > > 	sheb:rts7751r2dplus_defconfig:initrd
> > > > > 	sheb:rts7751r2dplus_defconfig:ata:ext2
> > > > > 	sheb:rts7751r2dplus_defconfig:usb:ext2
> > > > > Unit test results:
> > > > > 	pass: 655208 fail: 0
> > > > > 
> > > > 
> > > 
> > > Update on the sheb (SH4 big endian) failures below.
> > 
> > What is the qemu line you use and the memory configuration of that qemu,
> > or is this real hardware?
> > 
> qemu. I tried 6.2.0, 10.0.5, and 10.1.1. Sample command line:
> 
> qemu-system-sh4eb -M r2d -kernel arch/sh/boot/zImage \
> 	-append "console=ttySC1,115200 noiotrap" \
> 	-serial null -serial stdio -monitor null -nographic -no-reboot
> 
> initrd or root file system doesn't really matter because qemu exits
> almost immediately.
> 
> > Are there sh4 configs that pass?
> > 
> 
> little endian - all
> big endian - none

Do other big endian targets work?

> 
> > It's a bit odd it says "fail: 0" here, Is this message about something
> > else?
> 
> This are unit (KUNIT) test results. All 655208 executed unit tests passed.
> Unit tests not executed because the image crashed or because qemu died are not
> counted as failed.

Thanks.

...

> 
> I checked out a test branch at 24d9e8b3c9c, rebased it on top of
> 24d9e8b3c9c8a6~1 (07fdad3a93756b8), and ran another bisect. Results:
> 
> # bad: [c5e19dc4c1db098456ee6a924e276a26e692f26c] slab: Introduce kmalloc_nolock() and kfree_nolock().
> # good: [07fdad3a93756b872da7b53647715c48d0f4a2d0] Merge tag 'net-next-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
> git bisect start 'HEAD' '07fdad3a93756b872da7b53647715c48d0f4a2d0'
> # good: [10f17a5a3befa328bd9a78ca6b799dd1933f108b] maple_tree: remove redundant __GFP_NOWARN
> git bisect good 10f17a5a3befa328bd9a78ca6b799dd1933f108b
> # good: [f97515baad5efa6e1963abd37188fad42515edc8] maple_tree: Replace mt_free_one() with kfree()
> git bisect good f97515baad5efa6e1963abd37188fad42515edc8
> # bad: [4df642aa2128c2c346f9c945bddbae37c59bba82] locking/local_lock: Introduce local_lock_is_locked().
> git bisect bad 4df642aa2128c2c346f9c945bddbae37c59bba82
> # good: [a20be9b8014abfe68acc2efd81bfb5d2dd4eaf34] maple_tree: Prefilled sheaf conversion and testing
> git bisect good a20be9b8014abfe68acc2efd81bfb5d2dd4eaf34
> # bad: [40696586bc008ad34db8135c35ec4b459691af3c] maple_tree: Convert forking to use the sheaf interface
> git bisect bad 40696586bc008ad34db8135c35ec4b459691af3c
> # good: [8387347ae261c5e74e9db3f73b91d47f11f8d6f8] maple_tree: Add single node allocation support to maple state
> git bisect good 8387347ae261c5e74e9db3f73b91d47f11f8d6f8
> # first bad commit: [40696586bc008ad34db8135c35ec4b459691af3c] maple_tree: Convert forking to use the sheaf interface
> 
> Reverting just 40696586bc008 in that branch didn't help. So I reverted "slab: Introduce
> kmalloc_nolock() and kfree_nolock()" in that branch as well, and the image started
> passing.

This does not make sense to me.  The first bad commit being reverted and
it does not work means that it's not to do with that patch..?

I'm not saying this patch is fine, but surely it indicates a previous
problem and potentially (most likely?) an intermittent failure?

Is the failure consistently reproduced?


> In mainline, 719a42e563bb ("maple_tree: Convert forking to use the sheaf interface")
> can be reverted, but trying to revert af92793e52c3 results in:
> CONFLICT (content): Merge conflict in mm/slub.c

Forking shouldn't be running so early that the console output is
affected, so I'm not sure how this change would cause what you are
describing.

Thanks,
Liam


