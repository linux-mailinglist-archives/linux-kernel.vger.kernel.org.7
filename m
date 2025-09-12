Return-Path: <linux-kernel+bounces-814755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8575B55848
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582505C31FA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 21:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BA92253EB;
	Fri, 12 Sep 2025 21:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oUx3Gugt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D8XjqUSL"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9271FF1B4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 21:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711879; cv=fail; b=FvvgsLShyGT7EY8ndsq07F7TyeJhHEvZnp/UWR5Xq1qjl2jeScPFB+RWTEdL+7TOOCPXjm4bUuHU6rrma7uanzmMu8J2BUfsDRxN/MlNmUcK3+F3JNzlxFMPdcciQXnzJvYxB4LN88ap2+dlke38VOXgt9S2WMmOfWDC9Z9lHD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711879; c=relaxed/simple;
	bh=nthvfQUFwGRDhGllP0zfEW6XWnmAsroJWLtsXFnVzaw=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=Ppt/ZMJkKLNMNfwqoxXSYHsjQu0WHn1ezsXjK81gkK2x+vRHZJahL4964UdUqesaH08MH8vMgtw3LJDwi3oZy++SV8slKJ510+HWW5YGdvr98AGfkoSFUKB0wdiqD5mZ1BALRtBbpucY7CNVcwvSnVc+pp0NMm8+AlXMN/eMmPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oUx3Gugt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D8XjqUSL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CLBttD001478;
	Fri, 12 Sep 2025 21:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=NNBtzoHNtWTOXabiZV
	b1pl6vbBN2eQ/4dix+4xf0MlY=; b=oUx3GugtTSyXz2ZMKM/YlAfuqpIyjXrcvE
	dUaPog4KjpAT4YGDvO7SbZO47oAE8xY64mOGDFa0BKyldziZz/qryxhd1gLG7ar4
	d92taGYhOmhn1/opXrPQ5pXzHUP5aFFNyPBCF1sPwzT2GviWy6e+rLI8zImvMyTq
	+yJIqfFpQrMOZv5E2PXhrVwqQddkLxE+lLMW1w0r1EQnhMh1oVTLQ1rxC0kFi0AG
	YLWgpZK0GgFpARgN88w+fRSN9kXB9c6WvztKZDhgM8xn1IfAqJBconmsm7i4g37K
	yez16JzhdlhQ/IguqU1kJGFMCiFIbeQjJg/1BJZ1bdxybozgf6Yg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921m30yx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 21:17:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58CK0ZWf013581;
	Fri, 12 Sep 2025 21:17:17 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010057.outbound.protection.outlook.com [52.101.201.57])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdejqm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 21:17:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZmwlDRopL0DDQPXUe+uYCJB6ZjaFIqkqpQUr35ab7mHu4N7ANp36fTd4da+Oe5oz5PPkRm0haRw74U5pcVENshtTtppAJrtkIXN4X2qr5xGG4aIuKAx+wl0MNXFCvxUJtXIPPB3DZdm1bgPU2BtuEKKbCTbrW60FcG6Z0+4pb2z9B4cxVNxiBjfN1Wnip9YBLRb8pd7wPSTxc6XU/Tzi17CI+G5XdYhOD7Ta9gXsbo6WFu+k6Ap6DAflou/3wUqV28tQ3ldfuNkWaY7Y93Xz/MJl2pjd0J3bpc5TVFw4yE+2al9R5CILBGlnyoacHpsLg1DA8fizOj2nkGbjhvMOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNBtzoHNtWTOXabiZVb1pl6vbBN2eQ/4dix+4xf0MlY=;
 b=CjmtwoWmZ+sntOTNgFRbpuW0CvcKGc0A1UFrUpvkFpyUPHeSiEPiXbD8uEG5ePSOsIoLAQphu5LgiyFHEhD68pUaMaWHIv/CxgWQv66e+Gjzn59yKH+4d8wKWw4ruMbtE59RStSUawANQuYBkXExEs0jsNDUUDSo0fnOArXpruk2neXb992ANjC/On1ZB5IZf6AO+HwQD7xeCqwEnXdNnN1Hy6AU5ooZDVjg3gX9f1vTJd3IWq8Q7WhYrR3jrWqPbOLhACo9Uci+fpZocsyIRXbUCfUPST47NQ3/5AuJ+muwGAMx31wsGvqvlgl5nVaj5LplcHLDM0QYMbeBiGnHbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNBtzoHNtWTOXabiZVb1pl6vbBN2eQ/4dix+4xf0MlY=;
 b=D8XjqUSLnUAmmSsv5CPdozN8ioABmuTeYDRnHUTYTQAN4n/dwG7Ue3RyLDzkeWHy6GZAd4NE42QvA9Ng9hgzFMyww6qtOH/WxwES1fww15CZHUPIH+62VLk+Ir0rOfLh8nd6d9KI/IRLpYnnGffpHWsTCGst19Cb2zz5+SiGf0I=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH0PR10MB7464.namprd10.prod.outlook.com (2603:10b6:610:191::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 21:17:15 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9052.013; Fri, 12 Sep 2025
 21:17:15 +0000
References: <20250902080816.3715913-1-ankur.a.arora@oracle.com>
 <20250902080816.3715913-12-ankur.a.arora@oracle.com>
 <643f5482-cd34-4534-8cd8-69f32482bc27@redhat.com>
 <87frd4p49o.fsf@oracle.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
        peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v6 11/15] mm: define clear_pages(), clear_user_pages()
In-reply-to: <87frd4p49o.fsf@oracle.com>
Date: Fri, 12 Sep 2025 14:17:13 -0700
Message-ID: <87o6rfid5y.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0034.namprd16.prod.outlook.com (2603:10b6:907::47)
 To CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH0PR10MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: 9efc81d5-5f51-404e-8e0b-08ddf241bf23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eS0g4IwzjtI/dxhdQZeSM0r9GHzBXK8GmgTtUiNSaQ1X44ZZNrcLhQ6yeeF8?=
 =?us-ascii?Q?tpz5y8OEIByzp8+EGcbzIf4QIMmoTtBZXZ3BH/bwQsgA65O+K41lqfVj/fx8?=
 =?us-ascii?Q?y/jyLQ9zVpOs2lZR+fqVQlBN29ZuPNKO2H9Mk3MqL6nDK7gOMpLZgnH1/GuG?=
 =?us-ascii?Q?sMJvur0wEDbxnIPr05s71mNQ55ER8iiju/xEvvA37bYqezWL48uZMsI+viCQ?=
 =?us-ascii?Q?XeMObJY2E2e0fcGtUPwLameDg2yOndwyDHNRcmHvxEkhoPQ9QRE2T84KSLjP?=
 =?us-ascii?Q?Y6AKFmhIcLDR5IShkIfdpZBYm5D4clHoqDp2oNy49EkoSluoF+Fsvxu1YRtJ?=
 =?us-ascii?Q?rT+Uc4B6wV6h1oHyYVn4KoGEUDFS05aCarOFCRlWIGNeR8dLxcYwVsYMTpub?=
 =?us-ascii?Q?gquSnEMa77PCmNUYTeTAEnCAdDD6ocb4zxshlkcNvDQFLfidLVCErLUgdhqh?=
 =?us-ascii?Q?A9GsatDGVz3J9yMNkFH8ojIZIhimezO1lOseVPJ0oJrNzGpsWdHoapgODwtj?=
 =?us-ascii?Q?0P63k7ECfKuqKBN9v1TYA9iOl/bGYSuZ7F3fwOjQbK2EqvijpHOf5ykTBAIp?=
 =?us-ascii?Q?XfWEtxkBfh7s61PCw2UzhRoJS0zNy/8SEYWjGH6S13Q1xtx17kEIGxJDmHb4?=
 =?us-ascii?Q?08FoAMo4NoDDA1b/dFzrz8HCbVYCHGanWb7iQon3HejyoOe2Mma8DlxoV7+7?=
 =?us-ascii?Q?58jy40gz/oskAUNjiGxsv60aK9aslFJ5R3X/2Qv2dXnJXBIyV3eyomS2+WJg?=
 =?us-ascii?Q?ptpQa+AmTsasPvJFsKpIa6t4O6E6yS8bUiUi0mzPXcdUiRsXfItjnvcuNu1+?=
 =?us-ascii?Q?KCdLQOrUI5VYeKMPeqAQSL66ws8ShUzcl2AMRvxqqiaQKHieaHOBw+Ev2p9Z?=
 =?us-ascii?Q?f9ruTcrkp6AFzKl+vYGXn6L2xx1QjL2uLncZ7Fn16WiWlFHGBSy9kUXUYxzn?=
 =?us-ascii?Q?NycQegzYg3g4SA/xyrHKGQ6hrvgFenm1SNg2968NSmubP47e34gg2bquqPXB?=
 =?us-ascii?Q?8AX5GTAeQ7lmgqKUQmF4e8CtUm7a4UieapPR952dye9frdvd2aLYvQlXAyxS?=
 =?us-ascii?Q?I6hUmJy/3+fX8seEHOhOv2IIenSOSo5H9RqH2f0l5MlOLqT6NkfVCcVWNJdg?=
 =?us-ascii?Q?Qsi/CR+WhGJ8Aw8rnsOGsXrzYDD7X+9ns+Tzpuiyu3X8/TK+OmkpAs0gmykF?=
 =?us-ascii?Q?h5N9xmafkqmOUzYd2ucJy7GxCqjc+TYGKNzqUtNMqchFh6YUY1FAQBclnCwX?=
 =?us-ascii?Q?vMM9yCkJcOwMk41sr2jyMjPzQeu38QaHZGLM91yAbTqib3eoCnKT8qzxRW9j?=
 =?us-ascii?Q?g/BYsucV3277Fql1Kljw8Bi+M5RQ7BzsxGugMLFpGsUW3kW2pGwy1LNMGUEn?=
 =?us-ascii?Q?OBrQAijnja+SHfCyOGMRHuqH22ZrDE7nPHUWaWIdxQ0WULVB6yEFtJA12Fu2?=
 =?us-ascii?Q?SICG66eXTNI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eRrkzB9IoJ4KCiYNb5exdyslriHB6zGoVkXGIDqaULom4xW+peTigJAsiQXQ?=
 =?us-ascii?Q?E5G5s3/hDgDhERHSnNS+8GO9/GBETVhluRQ14qzLj2a9Jgp1BoQxHHdYg+Wu?=
 =?us-ascii?Q?0D7DOUcXurx8F1soTpyNeHoVLiNHQHD9jinH3R85AvzgNhTMm/RJTKukfZbS?=
 =?us-ascii?Q?4g0RKmVeFgRUIi0j8YFKMMe93i7OuWCNL570Y4Uc2PNbOMch6N3wCr69qADb?=
 =?us-ascii?Q?FQ8wwGDRuLMs1RBAy1CW3nNYNoisWftZbLeYXWCYb3+FPHG4arHIF1OBtcSS?=
 =?us-ascii?Q?i7V/r/LFEMTnZQpcpdmGINqL2byZV0dA89ZE51vnZpDSjmYeqfYPR2HqP+So?=
 =?us-ascii?Q?Bw0cXWBcm4Qxe0XvY+GfEWELNVay9Cc7Wq6zNVZ1dtXEaFXOG6DkUcw03MzD?=
 =?us-ascii?Q?By1hpPd23UJWilMmVSPvyMOBGfsb0XjDTg7CnwnqX0nMCjO2eFThV6ucaOKw?=
 =?us-ascii?Q?UZE9W5uIfYgMT6Zi5gHnLUdkCCClrCEgTqDtTY86RKvBv5lyG62R6fSbVxDN?=
 =?us-ascii?Q?CdQqljfrtVr0wVyzoqUx8uStWd5EfR5LsrYrtp0YmRqbURqkQpOhrEIovWKD?=
 =?us-ascii?Q?X6cKhkCRa+cGT/d0XXpQ9FaRR2ROaqSz9rSc+cvAOMyQQXjU98T1uX/3+oha?=
 =?us-ascii?Q?8IggQDf2gYk8EwgPcBhHY1JGXo7WZqHqmZRi9uOJhpDJjGqqJyzhudR0YwWT?=
 =?us-ascii?Q?xo6PYv4uIXG9M05VMlA4rSTC8v2rWlz1zwb1oJ9DyxVscdELVG7XHcALB+t1?=
 =?us-ascii?Q?Goaqn6p5pXBSq53xIUQ8G0TxZGIMTA7uM+NFNhck7eMOYGfTuz+t4aRovGho?=
 =?us-ascii?Q?aSfDj6jLCVVekhQd+39ZbeSoJHEfQL+9NN8VGAeOmZyQg+9JJ82T68TqSyuq?=
 =?us-ascii?Q?KbNOYsesO4BEsd1vO3IvsWyl/mxTWYmvq2MDKQSph0O2bKFqm3xSadXdTYW6?=
 =?us-ascii?Q?h3IpJyT+DzLpedAbY79+XjqpjTZF6VJpRJNMOVXRiXf+T6EG1dXrrxTeBWen?=
 =?us-ascii?Q?GElOcXjyKbBhcQ7lr6IK3j5zcpJDbsN8l4Sm4sjqLDTWqys9i1jc3sNLrWoA?=
 =?us-ascii?Q?85Rxy6HtsXstvcJCvOjiCnoHVpXX9uS6za0ASP97iSjWfGJmG8xXwPV4eu/U?=
 =?us-ascii?Q?FA1HudM6XcOoh7lkw2HwuWUzhR1rBTOWfJp8WfiDUPtOu5H7OFQCCigwjIB2?=
 =?us-ascii?Q?ACtXuz2zhaIEUlqaNSXvke1502mj7GiUJiswWQ85LM2dEyvUxmfKzmjPxjlU?=
 =?us-ascii?Q?+9YlWzKvbP6oZWSGcrI+9ipbaDVaZVgtaTMbh4kYcEk0igwGrIp66MCc3df2?=
 =?us-ascii?Q?1e6A5q/649c3/7LUIg2d+SPPkzncKSVGHQO79M6LurCzbEl4riu1xj+0h4MY?=
 =?us-ascii?Q?to1DE7bcFnJACo/65BcoPVKXzCvpMQDxcaSo1zl1C4BKBSCmSxe9VRX1jZ7b?=
 =?us-ascii?Q?95/f1fFu2Cl/RQue7dY9MkbMViJ15Kq4dhCJOn1fGS+O7pNqRv1x4HCzy9hB?=
 =?us-ascii?Q?D9UHC9+NuO15Qltv+gykxwM0KPbLsQ5poh38n+EOfAfi5D4ofVTXmvLTbhXC?=
 =?us-ascii?Q?szlWq/Z6jDP/tAtyfQ1ctRruSwGf0geA2vF4Tgg/0zobihjU9i4aekN4vgES?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AbHbk+FIROVOSDamWg7urbbrWbdYAHd3R9wmG/V0neUjXSY6jM7A9flbQhyXvezyrcYCjnF1nX+gL6PBSYVIrSyy4enKJ1oDF8Wjukim657TOBpRAptb29HF3qvGPohI13EYLx0+YYg5NOjDUoRATOGdE56p4PLwfXyhzSyoYOqWhz3FB7+7n2AcRy4MgE+uY6HYFCLsC/eSEggzB4eQWH5rnVD/LNU/oD7nL37vYSJuPubpYQdZbIh+l9aUVlzu4P0TMLuLKartjG+a3ihkaSra7MkoYqwTpzHH78p3k04VYQABLLMxPttrrXfAp72iJyBfvERejPy/vQicaKQ9PNLvyAN/kgd+je06IDawT2L+mqki50IhQeI43IwR5CgomdLzQ4k4sRk4NWBf5boNRNktVa7v5+/USjrBWomvWeqsCQWX38UbIXVqcKQHwqm8NfTvmC1w0yxPjjaS5+Q+EVN0PWbkJkIOMBR44bTGkHvV3Z1pgbETmccnDTh8LeAmgjRO9hYZ0K6ZB6bylzNay4MIuyHPsXNstRf6LHTqZOpun4+qpqra2ZrdwjoJlt/5lIFKLCnCpI9yDXkJbMukHma0upbESgt5w5vGycUYR7M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9efc81d5-5f51-404e-8e0b-08ddf241bf23
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 21:17:15.1551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dT+Syyjf7/2a2v/7cZ+8jBiM9oQymSs7dZkUHBZdXkssHTsWK8rDepSaF0oJW1aTXeeuirsIrFx6jpQzrLeE9Y1MAt8XnRPqBSEvrX5Yy3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7464
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120195
X-Proofpoint-GUID: HP5_LUcoBZX_GfiTUSqEHaZTJIQ9lFGa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MSBTYWx0ZWRfX4ShZbZRyNiHu
 R2oH5X8KvX1lLptV/3fFYNRntxSGu2JY09/aZk4sipf5k3m3oWmYnRTaLqRH+PIV+XW2zP3i9jF
 hE0UyzfECmxEthYsJw6u/+Jn4cRrMOSGaVyq/YsPwRZA7x2y2+A/zlPY/+Rlg6lp50g8r3y5JtO
 22yk3sa/9n6DEEHTA/0MsFzBxHhYbAQLBzieaA8pDY40e7iDCrf0C91jT0zzYrGi1/bmCqi/dVl
 kdQ83hlzkETTIL/YYVAvuDgVoxKgzUnUx+V5azSwdEAdEXQqjEYEYN9xLc+Z3XSCyJ56l4VmwMZ
 Mck87uR7CYcWc0PEs5x+M6Xx1lGY3b1KuKCr+cesBlZsTL3YjvO2XuOzFJlZcELvXvVK+Me4Dwc
 T/sFNmng
X-Authority-Analysis: v=2.4 cv=Dp5W+H/+ c=1 sm=1 tr=0 ts=68c48dde b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=QESFZE03i8gkwHoeSNwA:9
X-Proofpoint-ORIG-GUID: HP5_LUcoBZX_GfiTUSqEHaZTJIQ9lFGa


Ankur Arora <ankur.a.arora@oracle.com> writes:

> David Hildenbrand <david@redhat.com> writes:
>
>> On 02.09.25 10:08, Ankur Arora wrote:

[ ... ]

>>> + * clear_pages() - clear kernel page range.
>>> + * @addr: start address of page range
>>> + * @npages: number of pages
>>> + *
>>> + * Assumes that (@addr, +@npages) references a kernel region.
>>> + * Like clear_page(), this does absolutely no exception handling.
>>> + */
>>> +static inline void clear_pages(void *addr, unsigned int npages)
>>> +{
>>> +	for (int i = 0; i < npages; i++)
>>> +		clear_page(addr + i * PAGE_SIZE);
>>
>> If we know that we will clear at least one page (which we can document)
>>
>> do {
>> 	clear_page(addr);
>> 	addr += PAGE_SIZE;
>> } while (--npages);
>>
>> Similarly for the case below.
>
> Ack. Though how about the following instead? Slightly less clear but
> probably better suited for caching the likely access pattern.
>
>    addr += (npages - 1) * PAGE_SIZE;
>    do {
>            clear_page(addr);
>            addr -= PAGE_SIZE;
>    } while (--npages);

Decided against using this reverse access pattern. I would need
to replicate it at three places  (clear_pages(), clear_user_pages() and
clear_highpages()) and this kind of policy should probably be dictated
from folio_zero_user() or clear_contig_pages() etc.

--
ankur

