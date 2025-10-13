Return-Path: <linux-kernel+bounces-850560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19009BD32EB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B213C2424
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FBA2E2657;
	Mon, 13 Oct 2025 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kIQjON5U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lG6vv7T0"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE37C2E1EE0
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760361651; cv=fail; b=p5l1/j+19ZzGMnpJPlo9coAg1GP3InNAr0a30+WTmFn5TknQFMI6qVHDMoLtYt5InHHsm0dib/nkKME7F02bOmC9z/UUxkwMYxs9OZxLMqTY2dVtd4f/jzAVtpdNNLEmSkJizbHHKAbsCaqUjgYpMlOtRfwrWUiUQLt+Dfk5Y8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760361651; c=relaxed/simple;
	bh=QvqYO4iHXYNJN1IMgGPdN+E+AFhNYyYvqfvimPmU/MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iocdtvw9DwNUCnGMOmP9dsV8QpJqptYubXAERQk/t+4SGj1UQtGsxJnU2+nSXKr944q8Ypd0YrgooQZMn0Q1JiRQ38O05PmWq3l2gMgmCOQOL9Vrsc9o/S8/G4hJ7eyHcIiKRY6AzyB/VDhK9LQyFMWKH+ZawQMjYr0iiQGO3ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kIQjON5U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lG6vv7T0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DDC2UK003519;
	Mon, 13 Oct 2025 13:19:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=QvqYO4iHXYNJN1IMgG
	PdN+E+AFhNYyYvqfvimPmU/MQ=; b=kIQjON5UPhA2s1opk+QYKbp315G/5AgdVm
	4gQzlauBcdFc7IUyLn3SLZohqfugu5YFq4qWihItXG425cWWQAfTOVL496jeQNmc
	Yf7cLIKVvqBZi63N/DXmsRW4HPfjdUMshnHtOnnQWjSg0GbnDlAkSgNyaelBGsdP
	nAYic0oKEHdpf79K/en2A+AsRkkVKmTMC/VfokPmw/Y9L9w1YqJ/vvUWIF1IRXj+
	rCSotryKXCxFuZboEM3bb+e4wXXh+/9PFsc6T5oAbOnHW6qozzGBT0vYymQG4b0y
	9hbsyXVRUBOmw4jXqcRk84NnDxO1jzo/rRB6YIn7evr4OBU9UvUA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ra1q9aqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 13:19:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59DBieG3037124;
	Mon, 13 Oct 2025 13:19:29 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp7jpm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 13:19:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLkxcjkKbRhMGHMwEFV9PGTLq2mpTEWJem+F8JSh67datoroeUyI9PY7Ne7JqN7V3XcCKNdikPbg+Z6TonuPgArqf1UIwvORJaV/4EBhxrt/74pHQXrWfJvvVfn6O0EEIVCu+CBt4t2QQ2s3Q5mn3zGWHK/LGRjMZWuoktEYtIgwiNk4M3WC8pt3o3wtam/3sFtjTCf2ue6Dia/cWL+irPJRGk/6mhdwxWT+1ubTLwUgypNUlJ2Vz1o18RBs7+zeMwf3Sd8CfGN0Lzof1zbzfjixYygiy0d6Y3zv7U38/k08VpeGHqL00LQSceQYfmg2PSrf5t+Eq8re/4LO+ks3+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvqYO4iHXYNJN1IMgGPdN+E+AFhNYyYvqfvimPmU/MQ=;
 b=ya1szkagLroeJOKlN+BnKlyaI075V7qz49xzdTPLHMgXR83hcfHZjOm5PaKY3QkDarVEoTYQaE0v+HCy7ccSfJauAD2NcC0KXG0FMeFFHSDMQrVUSrxf5h+1wSkQwlhjzckI8c1KcYfz8+kqgqBMNK/fOpNWROrU9ODydpuV+0Qzt8BTv8aXBxiaxaIvlzKI+RTcloqT0sSoArfd4Unx3TAHG9EFczp9CtnOeyVlEz5g6Hcucbl6m65KswfvEytoxcbtClFIdtIczXNwGUdTIFICHZNkGJboF4qlWUIStmPRNZFI/pORGPQE3loRbeH/Q1SndjRZnm3Ax1PRULuqHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvqYO4iHXYNJN1IMgGPdN+E+AFhNYyYvqfvimPmU/MQ=;
 b=lG6vv7T0SbhkcR9I9XRil2oNrVz2Mn6prniu9PzEdPIHrPNLoDJ9LD9MTCkQyCZX3HSUKbzKOA85IbY8v24QftBsI1vnI8bosNEgJzTKYumN46VUep12WKOAR1g+8roq+Y3wI/XLQjfVB9YiAaCCe8hdAGBdAZlZknlYg93Uxmw=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by SJ0PR10MB5804.namprd10.prod.outlook.com (2603:10b6:a03:428::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 13:19:21 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 13:19:21 +0000
Date: Mon, 13 Oct 2025 14:19:19 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>, Ye Liu <ye.liu@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, Ye Liu <liuye@kylinos.cn>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC RFC PATCH] mm: convert VM flags from macros to enum
Message-ID: <bb9cd331-326f-4ddb-8848-60195e41f012@lucifer.local>
References: <20251011093054.886460-1-ye.liu@linux.dev>
 <809f552d-3282-4746-ba49-066d2bd8d44f@lucifer.local>
 <7ca0960f-9d1a-4ba4-b074-a6502578b82e@redhat.com>
 <d619784b-b967-4795-aad9-6e79d4191b83@lucifer.local>
 <dfc18351-bb77-4099-bcdd-eb2bd4f1bea5@redhat.com>
 <fa2d7db5-688c-4d04-abcd-a60f79a6bb7a@lucifer.local>
 <71803dce-3fa6-494c-a4b1-55d98fc4aadb@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71803dce-3fa6-494c-a4b1-55d98fc4aadb@suse.cz>
X-ClientProxiedBy: LO4P265CA0173.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::18) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|SJ0PR10MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: c7688082-8999-43ca-6f7e-08de0a5b1ef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4jCK3Y9VEj7RLPBELY0C6WzlBXWzCsgYK/9gUtvwp0vkkAyACik6hMGQFm42?=
 =?us-ascii?Q?zA1MKIP7HckC6HY3M/0h2MT1T5w0CyQA4b3q8ve73qMCIGOzCVzwOtXA2uyj?=
 =?us-ascii?Q?LTbHMPgD2hOORhKOCYRN4Rw9OjSwO/xiyla67rXyjQnoETlVGaQhHYy7P8FY?=
 =?us-ascii?Q?THNbkABfRPhYg2LO8N9J9O7KPeZBV3ek4dvJBo9pSu7Hr1HrChAsqU4GgMb4?=
 =?us-ascii?Q?kzPxICEktWn8LBysWttpTy0iVO8mgWlmTnrQ0KFOqR06gdXNEcQaCI14qZS0?=
 =?us-ascii?Q?Xh16tWzaJthGhphe0LP4wnPMi4Y/dE3gHuCqRi6QQawdh0w3XE9kA3AaFtXR?=
 =?us-ascii?Q?Vlabe/6eDc4813dKIVV/IYGkwmIg2rk56H/NlT9rrP6eCLC5Vd1NivKAP0uo?=
 =?us-ascii?Q?tiNhHgx4GIfxLz7BzebafJzAzYC3w1H49/oOrfjphMclGwe1Y6tnZL+aJg/h?=
 =?us-ascii?Q?iY4F2VpreYs/lO1lwB2sQ4uO58j9UUjC4lDoQXVTGMeMTioPPQdd33ZuZA5F?=
 =?us-ascii?Q?4CX0O4ZFigtEUqCFRPSKm3Ftooh4FJokOiT592dj93GoImf7/+Nrcdr6QigN?=
 =?us-ascii?Q?LUyGZZTIJ7SRetxo/oOCx4WpUnWWHMaWBFJS/K9bSlprj87aO+RFYWhGNLPg?=
 =?us-ascii?Q?9FChjsP5uyHqpJSTh3rRDj6DvmPwWIbnOwNK7UJjzF27X8TFMzq7BYyyk/wU?=
 =?us-ascii?Q?ngVnWHQ4gIACP8XHPzYg8G/EGg4Ffmh3yu7KYjubgBwQV+0X7MiFjRgPkarO?=
 =?us-ascii?Q?aMGFrtg1ZeXcuGI+pC3NVtOWdInbPSMclF+0kxt1qYMi2+yvt8dWdCfM/kc3?=
 =?us-ascii?Q?dmg78pTfCrtLxbJezIfmDBl60shQhzHFSLMMctKkhAFb0+WMhynWV3HvV+zp?=
 =?us-ascii?Q?2/cMr4Z5vNdZikJi6poosaBARTaSwnyObo9JythOaV6THZhQ904bIkCywZwc?=
 =?us-ascii?Q?3RWhITJfvjfTAK19CBMON2aQCxY2QPV7z55iz0+BtoxPcKua8GE4FOnftUPZ?=
 =?us-ascii?Q?KPRQ/89on6NA9RBQHJvBQycWTbgOM0yREPhOTl92dsNxxMeQfFARyTvouSer?=
 =?us-ascii?Q?/uXc+sOgrAQ1TJ4EjIoO/GjKYbPVorbo2BCGNV5uWIAhG+U0LYqtrdKZnEke?=
 =?us-ascii?Q?e8yXIUb0O7QbC3eaUbjrkG9BhEhbBLmf8WrhP7BIk5OXB+QHoY0FN5Uza1hR?=
 =?us-ascii?Q?fqh3GGlI+wrs+BfyXxnEc7SxLCNhk0srW/sbllqFfOLgO/r2LAFODPVXWz7A?=
 =?us-ascii?Q?MbP/E0awCgp02HnShTYBxMRKtoGs27jor619zZxEbZvbkdP6CuOE165iolJw?=
 =?us-ascii?Q?1OKF1gNZyXOnJXdMk+tEtFiDP4MMsYcv7nSkvC6foHULa4ew0/DCRgtLMrva?=
 =?us-ascii?Q?scznc6K/Q03oYAu0J9ao9Mttz34nRum5TYVYDjpGbR+aighgLeITxT032cLH?=
 =?us-ascii?Q?ph+ED1B6ihU0Y0knr0gXL3C+78feOzu2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BMfW90M+xFI1xr42YaVEHnoQhpgl6w3fINVr3kMK9Nma+lxqwm+gI1K448EX?=
 =?us-ascii?Q?rolV71xipPY43o+U1hBDBK2zq3l5HGQdOqJ8cgUER3/Nt0D4QNoPf6Yl8msJ?=
 =?us-ascii?Q?Ukn1dth2eOHQ6H36SENkGKntVyb5nb5DiMw4E34GH0UkyrlE+/vRRqF9jywo?=
 =?us-ascii?Q?0FH5itLRUTEiFf3kWuLlDdVJsDE00QPLHWXlkpClcv3F20UQdR7qUzuBYSsy?=
 =?us-ascii?Q?AiZgxkGw1V9YaRQIj/YZqKng4FtnmYhhoO4lUKBaUve3JtN57A/tI6EyqSWY?=
 =?us-ascii?Q?doW2Gko1FFzD6gmbMeDEdebjdXeemaa730dP55j6mcEZt3ular+GO6HeL5f4?=
 =?us-ascii?Q?FTzv10Hd69gaMPBxTMDxmeiXh6e0um7ViaN3iSlmXoWOOgWv+F37wSfIaEDk?=
 =?us-ascii?Q?VqH5gRTjsIAiA+7iXrHoTC+14IB68yliHFH6E+0p9pdshr/MbXEgvcP505jg?=
 =?us-ascii?Q?xHnBE0MBS12jZF6ORvI9yfmUGV7hkM6AfveVj7IOfvoZzrKTSNezgJzkn8d4?=
 =?us-ascii?Q?aGgfHq/r2JdL/ecWExgvKhnkKA6At9rXy1Ly5aqiDurQpjjPzNnke3dCifR1?=
 =?us-ascii?Q?IPiGfNda82dNgF51HsCHtgEHci3zi7dNOl2lCpUYPuZkIicrG/EgjofLEwBf?=
 =?us-ascii?Q?9Su7P0mC63B7V1irOKhUzwntaJrR95GGeQxS+daKjYWSYgElgCaceD/SgWA8?=
 =?us-ascii?Q?4aCdMuV+cEF03caYYkNZjGJSM9QuCuhA/cCCHV2bP7zM9ZeOG4iaTs6t70YS?=
 =?us-ascii?Q?JDtoN8WYtIAz6GLi3YZKiUUeh9C99G5bHwfHYafSrRx/BpmBryMaLuW4su2A?=
 =?us-ascii?Q?UnsSpEixdvFmRjWf+wMx7BVCc5wWZXFh5+QNN0t5j6VuIZlotn2XP1gq30mW?=
 =?us-ascii?Q?9+mevYmX/M0EH/Vx4zF/OOG5z+wyWgJgV0iveVzqScYijr/Tta0KQ2WtrxIm?=
 =?us-ascii?Q?4KrdoGAO9TAYeRmi0qUHY2KyxEOzeilCPdfdn2lsjT39W45HshGxa4Ra8dyT?=
 =?us-ascii?Q?frc5NDQ9mRj+DKalWloy+WH+lpHTy/4zO971xbTt6nV+ESr3aZaYVeI/Vu27?=
 =?us-ascii?Q?Nxixe3hitcIy/HWoJuSKBFEduyXsAumvP49eQAOOwfKLUEqozPfP2ZgpsMOW?=
 =?us-ascii?Q?cHzCQ9d4yaE6LeKt99tZFQhvM3gJWOeKWApuZBY7SL1q4dmOrEv5VkJv+hWR?=
 =?us-ascii?Q?8iku03u95wYGHLKHQXnjpGDGf5ZjFeC1wu3XHM4daimJO9PF1FlvkQsUHyUM?=
 =?us-ascii?Q?hsDFIskeRQW4MZZb1Nms3AQq+Ivm+9WcML4XXAG4hV++JasqCKdvJnojvHht?=
 =?us-ascii?Q?2K45LCWfCPyLbrgqbGgbyK5I6v9glaEHkZte8fOyhKDUPjtpurNpgGhz4/Wx?=
 =?us-ascii?Q?kwAbCrkPyn3VGfUtrVv6u0htsJd/Aq9c0SaZp51LH+iHQK58JmdnBc6FnhiK?=
 =?us-ascii?Q?YIpevcPA/zArpVIjaJaCvlqyRdbYqlaOLqDrvKLru6BLo6ZRoYm4rPL/z3fp?=
 =?us-ascii?Q?sV8lxse4jETkneOFFywqiLQAfzvL8GvGd/ZE5JmcbSMTH3c6w6BOa2159Sl4?=
 =?us-ascii?Q?fwkcOycM9WABdgmg/VCPBHAYVVLrqSNUd3e9gqnhBpSahnvxegvWJ0RnrPAh?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q+UUdKgyq12kZuBVQ/wT5ANbACICArgbi49yoG3nasK84HLOdNoR3ZC8wDYDrN8cmKp3SYrhN7K3LJQlv7AqjgCr3DLPXvukHmAZmQOvwsiQuacsuBs0FiIPeNXfUPl/67Z5tKnfOzJaP7f9tyaLytEUYqdYk8oF2jmzfZ1/6gW9qKsos0bHKRW2HgyHLFMMhtY6T7l6WhaS2xnmDGB/d8ffE+AanjUxXL7UHyWct4DgWa3n1EuIHUpYzgk2QA+6t7gv1Hz94Rss/wevPTf4/6tDBXzq1CCiTDATktc2i6zX6EOktumLiIFMrNP8CLV4UZnDn+bDD5A9Y1BJPo6+tFVz2rLUbUagQCsysQhVQVOtBSi6ryH05iFmoLzjehfSEPdGDJxMEFCPgRrYJxNH8ssYwwNFB85nB42pR5VthRHYvoBiMz2KlexJJVZTBlxXot0EuK4BRT+VeFD15hFhFgJJru+WsrlucU/7c1KFTApMvIQ9PGhqB+wjIdQV1jdplRySM5JZe919bkjnvugbnmnnXc6tS0vC3a2CX1DEvt/3wAY9+Q8LYMzrk+uYXIhRSkzKmB62Lg/Nqfxb2kMkRy0KgXM4pvY0d2SyYmz6Zns=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7688082-8999-43ca-6f7e-08de0a5b1ef5
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 13:19:21.1493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kg4KeljGHHe6GNaGSRHf+tkk0Zx9H8NLnRQp9Tqv4t2sknr+/oZLmlwkAcbV91VGjvnsz7L8L10vSU1gkK0edlUhU5CwTKEiBadcc2/jL6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5804
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=764 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510130059
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA1MSBTYWx0ZWRfX0UipNDC72PY+
 IddYIbGLyhwdlHK9LpnlJW0SYeuCB9VlW++br+Ncz4e4jXQc60X3ARLTWHbiLQf0PpAh0JcbNG3
 PuyGWwTgfB398zxxWGf2qEEpIsHsidpvKQNDDeEzks0lvhK1PRMKlwDNTwDgB7wk9cr+v4fK8RX
 gH9KclUmU7Jiw04QTZQogCZk3FIXa0K6W10gDjtQCGCOUd6wjIy0ydFyEBmnZ/8QNdflcUq7JTS
 Z6Ev/k8hiV3nNpGDdS7s2oHiZRWFJ2dq6KsIw5ZQuDdQUcLbbKWMOuEI4shjX5sKQ+Lwk4PU5dI
 KihKOhoU4y6RRdURqUo1Rw/szpZ6SPnz/AMrTnKakTswX2tj9cKG7HNzLyy5wQpvxusuxJywYWi
 /siitwxHLkug4KRIdu/AZLt23Pqj/g==
X-Proofpoint-GUID: mcoxf-8NGGRCLWn2Qb2IGENBTFtT3yFr
X-Proofpoint-ORIG-GUID: mcoxf-8NGGRCLWn2Qb2IGENBTFtT3yFr
X-Authority-Analysis: v=2.4 cv=GL0F0+NK c=1 sm=1 tr=0 ts=68ecfc62 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=f7RMMt1Z4ssCEtSHmpEA:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22

On Mon, Oct 13, 2025 at 03:07:18PM +0200, Vlastimil Babka wrote:
> On 10/13/25 14:57, Lorenzo Stoakes wrote:
> > FOLL_* flags are an anonymous enum, enum fault_flag is not used as a type
> > anywhere, nor is vm_fault_reason. So those are both kinda weird as to why we
> > even name the type (they're in effect anonymous).
> >
> > But also 'we do X in the kernel' doesn't mean doing X is right :)
>
> I think the example to follow could be GFP flags. Nowadays there's an enum
> below it, and a layer that adds (__force gfp_t), so you could do similar
> thing with vm_flags_t.
>
> However I'm not sure how compatible is that with Lorenzo's plans.

That's defining bit values in an anonymous enum so isn't really comparable.

But what it's doing, ultimately, in broad terms (other than the opaque bitmap
type I'll be using for VMA flags) is what my changes will do.

And yeah, trying to do duplicate that is not really a good use of time and will
conflict with my work.

Overall I think this change is generally unnecessary given that I'm about to
radically alter how VMA flags are implemented, and actually will cause me
problems.

But as I said before, I'm happy to prioritise the change that specifies the
flags based on the bit numbers, I actually have it ready more-or-less.

Cheers, Lorenzo

