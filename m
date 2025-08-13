Return-Path: <linux-kernel+bounces-765982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAB4B240CB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83D977B15A8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4306821C160;
	Wed, 13 Aug 2025 05:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ljB+2Ms6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qHpId3dz"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3992BEC24
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755064575; cv=fail; b=JW8pPAdENpUPA1GCki70JReVRpO773A0VThdwV39Jgf+RHdzvdtDyDoqt3nL9zH5rMVEP07AxgjRU2kAx1C/Pvsu/lpx+tVAOWnZgdjBvpnmnELTFUJFyWWiT9Q0zD4i6llyqMB31vE+MXzxlfFKQ3pzCgDwQCr16vhXSJuhU80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755064575; c=relaxed/simple;
	bh=UIHBP7TXvCQ4ObwBC0nWZWSRL8yyFiMAM4JaMQwYIrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uJU7kHqqTT4alL8tHh+MMBZJJOZ/KiGT2xsEFWhKibZami8rvtbE9nes+iZ2JcHbCrFGGC6OKd0LF7B3Eje9wmVz/roWYu4qV80AL78Khl+iVhr8DzEaqwe5zWYLDslJFKKS7M5ctB1XBSQai05tBWIhzeAIFEUkdL/gOgYTtUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ljB+2Ms6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qHpId3dz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D5u0l9007709;
	Wed, 13 Aug 2025 05:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=/NfwGMrIOtcV27xwyN
	OK83IeoN+IJZKSJ0T3Mw3uPAo=; b=ljB+2Ms6XCRpYNoRYOopOyD6tZU4SgPwBG
	7ZhfIieK9ZZ30mk5DkVnrjSc7M3yETm3fl7W88Vh14eJ1ctBKYeNtQB0waeEIgqj
	u/MbkEljp6yGHdKv6pGI0AdFaaWTacJanoopwciKrmpx293E2HhcHV2vAnVqI41Q
	XOgsKHDp5TCnHOUIMNT/5pX9ScSKMdOgGz+3mpGvVfbKWe22xFbVabzKx3WgdiKW
	mFoeAw2gAOCupbmONCReR+vUdUkIbXgwV5UgInHjvxNslsWTsZbjyr4y1gmoVQxU
	VoyAjifibki5L672ZC7YuO/GesmYEIawv0eTLDrOkwvlFNd+h0pA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxvwxcte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 05:56:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57D5JOoU030376;
	Wed, 13 Aug 2025 05:55:59 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsax3aq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 05:55:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUkr1HXKzy50YmyJEsMDBev8J8acDimN4mqZQyHTBnIl3h2DSDSyIDGCDCNJHXMm4TfaDW3J6QULAy7PpEJOUaOp7bdtqsWqWlaNVNxf8C4F0HlLzvud1U/jOkfu9MdnwvlOGgETGn176UE5pFHr39mbt8gEQja9/L5kP4iKa9pnnQ77KZrXLHIl2UiEL1elyEhAefbfM6r7zqhMGpvlB5VfjOrAI5IK/PodVxjX/EBzhxHG9L6NxSwRpMtqqSfpV0CeqbPCrMwmli99N86WMPvPVxyXsf6IO70+pmdC6BjuwXGzuEMMhKrKN4Wt4F6IVGurTu7x85/dC6aHYmpnLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NfwGMrIOtcV27xwyNOK83IeoN+IJZKSJ0T3Mw3uPAo=;
 b=MM/iK5JYXyAs5C20NSNvNcDPw+ZnSSTGnqzjG9KOov48ulmfZY9N6qewSMPZwqiQdEEkQfZPs/j3SPNmKQRHENO/J+vXu6Sif4SWTUmrzmGWubB7eLjqUYkiLY8w3Meb7KHPJdVFm9P7YvipdhbyIb5IEHY+y007Jc1qXie+YM9r8ydlgeSZlid9acJmv07Y0Pf8uUogseflcQVLDSgorv98KgZu98Vl8hiaO4ogWdVcLDlXw7xZlRJ2ViT2VOFXYQ1JHN+KZ05/rCMNq4845tL1pT4orhGmxVh0jUmRZXM6NjeEN7/1XI2dePEBv2N7tkNX+nhKbJNaw1twb/5Ksg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NfwGMrIOtcV27xwyNOK83IeoN+IJZKSJ0T3Mw3uPAo=;
 b=qHpId3dzze2KvRd+qlV2cKrad63W7wn+GCeqF4DQVt/2GCoscNudvj5WVIXBZGOrZ1+RKMwPl4OkPxurUIwfptuYHBiJZ0lPmCacQUJVRnOt/UYSH29vsO1bGuCt6ZRjdp8eCnPJ+/CQu00SGQJBckbR0+w6jshZHqEnfx/BLbQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Wed, 13 Aug
 2025 05:55:56 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 05:55:56 +0000
Date: Wed, 13 Aug 2025 06:55:51 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linuxfoundation.org, mingo@kernel.org, namhyung@kernel.org,
        acme@redhat.com, kees@kernel.org
Subject: Re: [PATCH v3 06/15] perf: Move common code into both rb and aux
 branches
Message-ID: <9982e7b3-1046-4da1-9569-52bffe71c9e6@lucifer.local>
References: <20250812103858.234850285@infradead.org>
 <20250812104019.016252852@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812104019.016252852@infradead.org>
X-ClientProxiedBy: AS4P195CA0044.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c0fc9d-c3f6-436e-b3fa-08ddda2e123d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?93d8LuM33sWBE8O7MdVFcSA70vw0lruUYzQdBx/QJVlG0wIlGLurgO/1IXbN?=
 =?us-ascii?Q?Gi7ogvtqdK55jZc9rqF3/M8pMWqzHsSjg2IQYnPfcZZxvahjTOmHnoLc2dQ0?=
 =?us-ascii?Q?EiwCcSWCaT4xxocQWiLfMmMRtla1gYVMyjmQ+36Ox2JVXPLVx9TkT3eNL0Ne?=
 =?us-ascii?Q?VwSIqErpGLlRRH+TQWolwYlJ9ZoLAZ1WarLhOsVQlx8NN4RGg2ERdRU0auUr?=
 =?us-ascii?Q?bl7Kqj+FzhRIz9aSMY2YCHP64I7pIphNLB0U+y7Jr5X6JvXgCm1xvnlI5g6v?=
 =?us-ascii?Q?vFJtpx6NHw7qkhKvjxSzKQXeRKgDCQy4WnG2wiUeBMFAwvDY+7Dozzjq89Wi?=
 =?us-ascii?Q?uzBiyeHeogeysg10s+UxmhayOOKLHKlnPZ/74blPxb4eTQFa9NuZepD9gfxB?=
 =?us-ascii?Q?dK1C68kczTCtDS1hmLE687vfr59MqnWkdRYmRnSH/Hi9hyHSCcTavgyY9Ogd?=
 =?us-ascii?Q?Hu1C/GRVK3tJKPWNHysv6ILSkJZZUyguQzkEXRJE8HYTuSI7qqZf1DtWK/No?=
 =?us-ascii?Q?xQAyBLi5LED/MaxkTXEz2ROue2Sv7P/EL/C3YFVPaBKHVVkOHzbk/dFx1iJV?=
 =?us-ascii?Q?V23awFefhOdcPFKDcrQlaKqNHG6yUkB1N+Oon6JkXQjgVj0R5IWaAxXnv943?=
 =?us-ascii?Q?Il38B3MyM9v6axLYhpayqut1KigyVs7U4EBZJnf/SnzFpTy4LKssYztaLKiH?=
 =?us-ascii?Q?Rz2/sHsG/MDx0KKXOlDCCdQkEe6ojk/dhWbw8gyVq1oL7bo8bsVZ1Jqvdx7z?=
 =?us-ascii?Q?9WCaWS4PSnbQxHVEEtQUyffPujPXxaG3irRjpHFQX3FIcsjZRXb3yasx3RSb?=
 =?us-ascii?Q?gOO/SgiWBiXdHf0HOmqefhDThTNBJ72KBY8vlvlzqAS/Qg3+oH00FKGxLiy6?=
 =?us-ascii?Q?GLye5KtbPxbB7jZ/HS8BzcgYoKu7iUYp3GLz++D+eeMpouJlYc/8i+yKQIb/?=
 =?us-ascii?Q?gxCN+zPhTIKfDspasauouFPneJG5s46WN0I8zTGIEGF6zkUntKfabAlh/pMh?=
 =?us-ascii?Q?HL47iAEet6BFsl+TxGIB54+EhF3wyEB4VkieieWXhPY0drzi8tkeItnQAvjS?=
 =?us-ascii?Q?kxh1QeT15qRpyMN7p+DGLDAwxQAnFDC4XK3eui+ze3tTNqVO4nL6DwKuExVK?=
 =?us-ascii?Q?v2QaoQ2garcM7Td11xIasE4UuwNFMasAvEB2Q9AA8GcQjY1scE2HeAPwWVuS?=
 =?us-ascii?Q?+EMjZHeZN0cd0SxGjJppaaFm4eu8cP6dEDhK7bBIon+zBM6nrcqIUPmLC4q1?=
 =?us-ascii?Q?mBEp9mA+QkSggBN09FJsZcEyuj3cV9JWxsFW+bgHVdhDSB1SAKi5nAxRd70A?=
 =?us-ascii?Q?Ex7/PO4kfOeconQNImwhLcbZMkvV4AKdhjAwMgKKcsJh6CZMgvHJHeKVYNFR?=
 =?us-ascii?Q?c3zwcua8ef9uqgeIbm+EPMY8HXNgC4aF3RxEaHenLufp9Ul8KQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FOIyGbAYZzrg6FCfyJYIEVo+HWC35ZFYGx0SfKAlBhD36+ts14qmjBdhlWT6?=
 =?us-ascii?Q?kYUQGyQOWvq0DapgKqhDxIhpO5qPcb+eAfnh6PcpxYMCA6yHK579g9iDaYkI?=
 =?us-ascii?Q?2OztGV0m0fC8ZKGFBlkablOITd7dLaoFh6NXLt4rAqusls3CfO0seRJ6GkGH?=
 =?us-ascii?Q?ebb0D2QDOSLqLL17GL4mEGkOm+IopUNHIjn+iXSdZGO6Fo9fwIy3X3NNtl6I?=
 =?us-ascii?Q?lr3lCMrC7we6HPne1ehxocxe0s0ObAN6G+OIUUwH6c7yUDScbzvxPztG5G57?=
 =?us-ascii?Q?I9mpCL7lK8x71f304zXPy0YTr86k+tCHaRH+7AW9mHKqOUIcLV+RsEPaK3M6?=
 =?us-ascii?Q?+s5mqX9ATbA7GxG6gEDcReI6EV8fRqOpWIIWOUyzGFqfNVcx4s8o4DY4ouFf?=
 =?us-ascii?Q?Q+yZ5AnNrlPN8cLfHi5/7Ou5dmmhe5CwgWeW0lblg+aiy5Y+hZpGWTtcer/Q?=
 =?us-ascii?Q?AnzbgyRswqGIS9fWmy09mv/bHodLkp5pzmEAmPegm9/NkfMGoaMkhp6EBXzt?=
 =?us-ascii?Q?3Ct9huq1gJmz7l443FvP5b04fGD5zR+HdS00kzfN9XZbr7Ozd4HfsQ4xrX+N?=
 =?us-ascii?Q?fLFhVKtoTmgebbc9koJV5lq5d4U3lBcJ5GufVwI3qNJV2On/xKPnrjhsnz3b?=
 =?us-ascii?Q?IteqkNREktpRMSGodmg168poJJF1z9vkQvlS/5VV9oquwHh3bIckuxONcrAB?=
 =?us-ascii?Q?UP+m945Br9Lrev6iUJzAADdkDRZtzccxTaZE9Fp8BpbX6cnblqSzu9pQVz3K?=
 =?us-ascii?Q?dvsZ0+pd+BG3e0mqrr/wVUhii3IPr+fb2RVAHePxz1wMcgEHHWz1X2byKysy?=
 =?us-ascii?Q?P9FlijQXk/LTLMjuk21M2djG2uPyz5dv7JQad9h6lk2IRArMBd5yN3gaP7BB?=
 =?us-ascii?Q?lgaeSHGBZ+bu07GG0iryiQngcL3Kcc15UGbwnb1aKjuMTi+D1cQ4a2vWcddt?=
 =?us-ascii?Q?hG07ggHxS8V1K8t/XejrJsmAeHF4TbdSSoE4tIbszq/eShH0GT4UchLR/bGF?=
 =?us-ascii?Q?/fiejvCLQx7lI7jjawJJjAs0heU2Wfho4kHLaTsi4m+3LX+ovBTHwNX0NrMM?=
 =?us-ascii?Q?pAtMjW4I6I5yfyVZeXkq/HU/LieWH4+vioE3kDXMO7ez6qSGHj971JWj1vET?=
 =?us-ascii?Q?9WpLbH6Ri0B4/nVqiXut1tbSNO1Ix+CO46iNtAVw9R3qHOskK8q0BE2SLvQj?=
 =?us-ascii?Q?mxy/1fU57MlpfH05sobP6/aILSBwrRUE42BEoq1ahYasCzqNoN2eKwytezI9?=
 =?us-ascii?Q?vDSTX9VhG2QCUPHXOni8o2j0BG/C7mLlzbW98SkN+Fo6tdySBktLn1W2/oxW?=
 =?us-ascii?Q?yEtKCk7JYZvMyjMVP3LS/P8X5G+0Rq4SBmPSyGBCEXI+vASOSR4WuA/p7a2j?=
 =?us-ascii?Q?xGSoeN31RE24FxwuoX851cV457NowvWuq9YS6qYWHpf+eJdCfX4VYpU2aIdS?=
 =?us-ascii?Q?ukkgFIa4nvY/dWYumVFNZ62K6D5fzeO8h8KD972RGtsFPHz3VxBe1xSWBa/b?=
 =?us-ascii?Q?HG+UEiZdblaWaCdl9b3A7/N90adbCmCE3mjPv/JU1zBQWHqKaZozMXIikBwH?=
 =?us-ascii?Q?zs+SYhD/0cJY5ffdJHBB/VJbxGn3GdqhCYSCOC5d20pwZ1llZRRvHbcYWMLP?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4Q6ArYNerdIyAJBoPPzIreYQ0Y01M79WZkWTfq1WSfAv5ezZWcBXDYuyDweAswROuChUz/LWME3wGrFc8MTgdsbuXcrdFPGkY3wHAovyF2V45+mxRzT4OXJWMA354XCn0W0I30il8aGCPRT6+5SlbYrTwg5FsNsmELv0Ow0FcWWoGNhOM2DfweorYGNNEVeZQoINsqUvbWiySC/xVXOnknx32FJoXKbT33cv11MqImSdBBiEki4Vxe85rxgSL63v3QwqezieMj02TRSSdiKnk3Nyen5NKds+O9jU6LBxj0QmIVsRoBWxvG00a80wbFA8v57TsJl8E19mw9qdpVzF/s7H8g0LAeplprgWwvmEPi/NpT70QUsRSlK6h7mtoBcZ+QDThqGX9fhqb4f/gAYEAzCOiMdlvW4Vy3NvR7NnKk75lD0LIArXwMXCvU0hf3BJAVDAKnQPIpQ6ynIPq82vTruSHDRZgcuEZZigV4RxdNwu/d9SjT2a1+81gYzZMpsKq/1vLiSt4erujuZJQ0Us6anjfIdiDSS5K1JezXAXEje6w4F3rpbXlIU/wFIC5Kza7lrpL4dCyDMy3ZOLtQfCiVjH4P4r9JkTaGa2QldkgX4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c0fc9d-c3f6-436e-b3fa-08ddda2e123d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 05:55:56.7787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NcOROmHam2GVeCnivfBJz9vaYbZJ7ufHqTu5STsoyPlXFbwPwfqH5+CWBK9f0GdLjLZaCq31EAJ2P2u/KOTWxaO0/TFiPvkgGYIM6m3oWIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7730
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508130055
X-Proofpoint-GUID: 64u9snuNRXlkwjI6LIcrdTc8OevclbgC
X-Proofpoint-ORIG-GUID: 64u9snuNRXlkwjI6LIcrdTc8OevclbgC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA1NiBTYWx0ZWRfX/TTVggRgh6vt
 5zgrrlKlO8RAj+Kxg9+Dy9k9s7k8RXCFaKk06rYXceSXiBbWLr2BvesYXXuiAJVNih2YTE82Unf
 xvrBmf81jw1ik+Gnal64wD6VDA9GkKDjTwgtIG4YmpMAX/RG3BeNTYyAHv2MPCuG1nMe53BhgOP
 jxYllyz4dzT5NlNl0xrW3UdrcbEpdewwkDDfXQbBs5iUi+QDcz2862JRKRRZEL/3A/vj02aPL6E
 21HMJhurvFhZbu8oYxBLCllLuaTECRWoWvKb5CBCYnTOI50q5CDDg6o+QC+AyxYw8JvCTya6x+M
 K6qFDgCn8EpYvJvGGESfypKEgJCR9/9N1l26qe/pvkbwFO5JB3wH/Tm/Xp1Kw4Q36AFNqYALAfp
 nuNzO1MNDqQRdMyvMt7MRiL86upx1mYfevHTzHbExO8uO5XFj/34r3H13RVA10OJWn4cg+ox
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=689c28f0 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=JfrnYn6hAAAA:8
 a=PQF3-QNx63FB_aKa8XsA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22

On Tue, Aug 12, 2025 at 12:39:04PM +0200, Peter Zijlstra wrote:
>   if (cond) {
>     A;
>   } else {
>     B;
>   }
>   C;
>
> into
>
>   if (cond) {
>     A;
>     C;
>   } else {
>     B;
>     C;
>   }
>

Hm we're doing more than that here though, we're refactoring other stuff at
the same time.

I guess you're speaking broad strokes here, but maybe worth mentioniing the
tricksy hobbitses around the rb_has_aux() bit.

Anyway LGTM so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/events/core.c |   25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7043,6 +7043,8 @@ static int perf_mmap(struct file *file,
>  				ret = 0;
>  				/* We need the rb to map pages. */
>  				rb = event->rb;
> +				perf_mmap_account(vma, user_extra, extra);
> +				atomic_inc(&event->mmap_count);
>  				goto unlock;
>  			}
>
> @@ -7083,6 +7085,9 @@ static int perf_mmap(struct file *file,
>  		perf_event_init_userpage(event);
>  		perf_event_update_userpage(event);
>  		ret = 0;
> +
> +		perf_mmap_account(vma, user_extra, extra);
> +		atomic_inc(&event->mmap_count);
>  	} else {
>  		/*
>  		 * AUX area mapping: if rb->aux_nr_pages != 0, it's already
> @@ -7127,11 +7132,12 @@ static int perf_mmap(struct file *file,
>  		if (rb_has_aux(rb)) {
>  			atomic_inc(&rb->aux_mmap_count);
>  			ret = 0;
> -			goto unlock;
> +			goto aux_success;
>  		}
>
>  		if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
>  			ret = -EPERM;
> +			atomic_dec(&rb->mmap_count);
>  			goto unlock;
>  		}
>
> @@ -7142,20 +7148,19 @@ static int perf_mmap(struct file *file,
>
>  		ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
>  				   event->attr.aux_watermark, flags);
> -		if (!ret) {
> -			atomic_set(&rb->aux_mmap_count, 1);
> -			rb->aux_mmap_locked = extra;
> +		if (ret) {

You dropped the 'AUX allocation failed' comment here, but honestly I think
that's fine, it's pretty obvious that's the case given the literal previous
line is you trying the AUX allocation... :)

> +			atomic_dec(&rb->mmap_count);
> +			goto unlock;
>  		}
> -	}
>
> -unlock:
> -	if (!ret) {
> +		atomic_set(&rb->aux_mmap_count, 1);
> +		rb->aux_mmap_locked = extra;
> +aux_success:
>  		perf_mmap_account(vma, user_extra, extra);
>  		atomic_inc(&event->mmap_count);
> -	} else if (rb) {
> -		/* AUX allocation failed */
> -		atomic_dec(&rb->mmap_count);
>  	}
> +
> +unlock:
>  aux_unlock:

Hm, this sucks, I assume this is a temporary thing to reduce churn above
and effective prove that the code paths are equivalently going to the same
place?

Which, given the complexity of the code, and the enormous ease with which
you can miss stuff (from personal experience...!), this is probably a
sensible way of doing it.

>  	if (aux_mutex)
>  		mutex_unlock(aux_mutex);
>
>

