Return-Path: <linux-kernel+bounces-821146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D42ABB808EA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914CE1C25B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E50130C112;
	Wed, 17 Sep 2025 15:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S+z3tMSP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E/U7gEJR"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8231130C102
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122750; cv=fail; b=M3VIebKVu6kq9iBdMSse1VGcgiIvQ3L4o/ApSO9S5pe4f0D5WGlqfMHAdlzMlotSPKl/FwBAwVu1ryiruy49YMRuSrjjb5d4d3Y3IpmZWRmoS2ey1NxHgSf+9jNmfKBR3fBAaCxCpeMmo3ml5mg8Zz5vk9WwlCBhrh/g8OY8bZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122750; c=relaxed/simple;
	bh=Q77j9+x1UdqLKlBoSzT87TFPZ4cLUrbzsmvFBhp1BqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qdjh08FlwF8I56SRMF/+qRPLjKTE8mbz8IcYA8s4SzRGQ0aXv7TTA8eDm5EZIsGo/oiVZbk6Lz/+ybzqVBxjKyvT9TMOUcmr8avFO9CQj+McaXKxojeqJw+E0C2YR0XRN9CWWSaCZnzJ6/Ex7PYtc6XdNp1bd4X+kQOLDB0xrPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S+z3tMSP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E/U7gEJR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEIUTF008312;
	Wed, 17 Sep 2025 15:25:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=84lptFBxxgqNLrI7jsnGJ4vN3KlwOmAd8W1hpUqr+AE=; b=
	S+z3tMSPSxxWRFPoccaLWJk3ZyaBR4rcfhMNvOm6uMfJKiKh9m7ZVQ2TUSAVsBoo
	xwNL/4V8m95fkhHXKcWt1QTTLVB/VtPnJ1gpChqce/NZp54CNMT7JIv4hf95NrE5
	pYd38fNX2JSrTEuV7aCeBWmSwjPnxCp+s4Sf4Z2XBDIh6yCG/2EYRXlzpmfhaJMM
	Oje5HNA5GUmUW8wHH7jpQa4B5lW1jziT0fQurZqYBwd0lpF6hxhDQ7NUdw3WNIo1
	miKqgnvDHwhIU60dT8lGVrGc4lIglpLBMZY/pWvdBFqMdsucbnP9JPO0Gmnfa80S
	e4DlW0TN6nV7znb4cOKaVQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx8hfw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 15:25:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HF6p1K028818;
	Wed, 17 Sep 2025 15:25:28 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2dwam9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 15:25:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwZM0xSbHoM0lnSQfjdIWU5vduTKG35XNvYklCJxUWFrJWlvjKvFkypjG31ktRDb/DfECmORJFE8educYjkcX1ZEynlHjaLICypJQcGWbsD0CTqkuvRDOyZpZ0WW+3PQu/ZMMa6v3mbqqL0ClmdyIu+BEiROI6QI/fa+80slKxUpKAS7QHIsAGXGciw+MStI5Jke9dfo+MJcSXBgxPGOjjzKh/emiSO985wqJUFd6Pwty3/xycJ5i3wfLBLkuzjRZnr+YDKidQ+TXs2vLTs4B8660Lo3hwZmRLxUgVkdyT0ykxEpFGgWwCA3o2Ef+kFaEqAOw/ri3O0+q/7LsWMHnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84lptFBxxgqNLrI7jsnGJ4vN3KlwOmAd8W1hpUqr+AE=;
 b=tWCEzsoFED7SdcT0aGUAv/syJTp8Gk/mvFIr7CDxEWE4O7X8lxGLk9pKFTWALj0EW/GioT1rjbo5sSTHgCq1op7A2K4om8hiUrosEBW+9opW+DSV+GxoVnObz+tnSpPG68GgPA7iV9/WkH9TqTc5U9GwkPorIZo/YJdc7KvB7kzj3/1GrTEXtFDI+j2Curn+TnsfqpvB1a0VoW50ViTZSTDTpGPytG45ba7V2euCYo1/iz0ih2iwzCpTHBwNXE4tn/dSNtnq2skVEVRxi5NYZBqeLRp1UPjS/QX+7QHYg1aUeDRTo+TPW3P2/Ioy4d3Kn5KOuulUaVe7Oq3AF36v5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84lptFBxxgqNLrI7jsnGJ4vN3KlwOmAd8W1hpUqr+AE=;
 b=E/U7gEJRVaBNy28+j7ah1owIZqf/0iFOM2AHb03gFo5an6J1Tz/frpcaQ9UsUyBkGFOa8bmoTdTHTk5oxiQm+Sw+Xtxy8Us+qW7K2gIX+HI6hSM33t8bTVTXDuhXv0+HBmHGe/r3v9KP7rh4EXt97GtwBJ1nlIrcIAgLvrD/7OA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ5PPFD020A49E6.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 15:24:52 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 15:24:52 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v7 16/16] x86/clear_pages: Support clearing of page-extents
Date: Wed, 17 Sep 2025 08:24:18 -0700
Message-Id: <20250917152418.4077386-17-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
References: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0061.namprd16.prod.outlook.com
 (2603:10b6:907:1::38) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ5PPFD020A49E6:EE_
X-MS-Office365-Filtering-Correlation-Id: c76dd038-4b17-49e3-9cfe-08ddf5fe5913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Va7bpBGEIdJWSXpZfaVDDNGl3UzsYYofR6bVXT0vUaelzzbGBhW3Vu6Pg3Ny?=
 =?us-ascii?Q?PPLB3OcLx02h9NyFpQayv0CPC03bHgM/jWcnmai0knl2tXUF99g44ADqrHlf?=
 =?us-ascii?Q?ofkoLM58sKd6NanV6PGwazmNntFmWCC8Z4OI8JSVk3+lMhAwsgYdNxrCzFgL?=
 =?us-ascii?Q?PnvFsleuzNh8nP2pAF57Yz+areFv0F2Rsn1Wq81ipBi8H/d6bNP7/EVFAt5T?=
 =?us-ascii?Q?UKCB4NIfcRU3kgHfcBOQjDHA0SlIjP6JuvGfmsjZIOVvMxEATPKm70OrnZ4m?=
 =?us-ascii?Q?gXMFqu6M8m5X+6SRti5recQ4aTFfantTtzPIuIt/cWmb6DK6PRLPj2OYegJ2?=
 =?us-ascii?Q?gCrI8neJ0fqs84KY+J3Ukdiq4DfRIg3WtEFPqIvhuMdQG4/5KI0f2OwPGFBM?=
 =?us-ascii?Q?ceGLJIqb3HIReNtEEXY2fyR32YMvwl+xHdxab1RfSVcwEateRLZeLGSunZj2?=
 =?us-ascii?Q?OpV07M0SwbA6VRWBlAjq/TyunUWviklQ+ZY+YvwhcRZnc0iwwec+Ec4o8udx?=
 =?us-ascii?Q?A4PTDU14SCt1X45MMr023x9Pf/OD9wwDN5QtCnh72BknuA7L/vzziah8/poM?=
 =?us-ascii?Q?ryhy6KBaIV5JKw8GYfuHhIIIDbr0h7lj3rNxDSM0Jrp128OUGgWKqTbKr30i?=
 =?us-ascii?Q?RgGyt+Qs5PYKSFXOcIYkeDI1hlbu62j+h14owXmzmgsyTyvFNSkwNGLnigU+?=
 =?us-ascii?Q?SBGAi9ZXvOu6jvBI/8Xe0DQK0ikXcXenprrEPkN0qigpa+53mGfcKETCrBQH?=
 =?us-ascii?Q?HNNzJAXpc2+Zpp5zGJopoYLUmeBM+My/jtoWDDggFrRJW+vPBOsdTOEs7dxw?=
 =?us-ascii?Q?nimVPKAYtALYx86UpkDMH0C7De/g9P4/M5ngOOb51LgTjZQHp5m0RL1U7iXd?=
 =?us-ascii?Q?8tF88Ujnx4gpOesr81qBKlpFwMPfeqOmurv2fs0GCvQcSFv9D/Q5tLqGycG5?=
 =?us-ascii?Q?c4XdwYOQoEQ7sXKnWWQz39gAbL7FCVx04C/Q6a8Ug7sgl3+pQhDwlc7fOm1G?=
 =?us-ascii?Q?k73Y1glAntHlvVScN/eeNBj/6xsizZP3uKbGGmLHQj/X+SF9LiEV8LqJRid+?=
 =?us-ascii?Q?6qIueyeezfdsnfpm/WUx26e5yGZk3F6htNnuW6FefUynpKpRA7RP7eYTxUe+?=
 =?us-ascii?Q?U9s+EDnTl4IeVPY4FwxdhSnkUETo7xKOQCAaxphlKMYjPxZJnJy+ytPWYg9I?=
 =?us-ascii?Q?rAlAqTaSA7UnxtZXPcuj4J3FN+02TVBzBp8oWEAHpVBVTd5A/RTJUbIHyB6K?=
 =?us-ascii?Q?ojQpjxrXLqx/MNNe4p99XrFk5MpFEkSmtjF0bT7i3wUV862hxT5Ahtny93Pm?=
 =?us-ascii?Q?1qGKKOZXTIpS2olc3Hr2MmiMLN0WS8JFEpU9YAwXykeoieZZcogUd9g9MTWq?=
 =?us-ascii?Q?6JlUvQAx2ioQb3fMGhzqx3jxwNGjsYLjJGhUMRq85e3cyt+V5igiRDraVFTc?=
 =?us-ascii?Q?5ebazLRu1t8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v1UmIDniO7A2aDHf6690UaaZdHHVQsufjuOcxTM2vA7vlTSD2vX2STWoC0Xm?=
 =?us-ascii?Q?tPGPil5q3de5vb3DBS66nY2RMR0C1ZtWOXKvvPTlbC66AyPLv4dNZsllKd3E?=
 =?us-ascii?Q?l4gHwd1DeenXdJICXowKO6RKS3W06TJz8RC4D/oz1Ob3cQ+Amk4RidH+tgPr?=
 =?us-ascii?Q?y3unmKEECOarqY4MZn30XNjGGd9EdOsg7qdsqAp9Ubbqbeq1cbpfktylSXBF?=
 =?us-ascii?Q?RCC1M//Sk1BR974KynnINaygRjmuWxZfvWte2n/0523/0dmXSg+BiUV7eV53?=
 =?us-ascii?Q?IrptmAk9ZFAT4oW32Z7XOtUszr3dvOniZpNymmFw4FBatfxEj+YhnfKl9zWM?=
 =?us-ascii?Q?E1MTB9J5DHRx9lAKZGgchEbniNyPzwBFkkgpTK4HEyNrfFu0KWSR/S6Oj2eL?=
 =?us-ascii?Q?HftCGNsY+4AlTC48/o0zMkpGpd88nzjABCo/ILwEIfAmcylJ9eRkbjiHCzLd?=
 =?us-ascii?Q?S9OZ6plUG7XAY3fqjmnUhgR7U/dkhu6FMBc1QgNB0GiQoFP+CSe1YVPZB4+N?=
 =?us-ascii?Q?3e5PovqIs29eTc9bAkR7Lz/4CkdgMi4p0+aHKbN+1mS7xTUyOvCf/vXX/6SL?=
 =?us-ascii?Q?8BYlx4bkRg9ZecpljzttghmLcy3naSclqP+AMr+toanAB54PRVHV8P92Sf6K?=
 =?us-ascii?Q?DmF94KCD6VgBR7KtRJpTrVxRqWdvdxYr1CimahmYu5rYftcI3UEsrzBqWR9G?=
 =?us-ascii?Q?vQenWlkfTSgjjFglQEk8xqpZe+e4fo1MCElvtvn9/xDSXQVFdJLC22VjaYIN?=
 =?us-ascii?Q?VxWMak2Q/niFBWqg3R0pukKMEdGbCQIJZRgpM4G2THm8XK7lcOn/Q4Y4Sb1y?=
 =?us-ascii?Q?LxdhrpqGPgdQLZ50kfEKt7oqYWz5/MYqjS2YAmrXiQuvq8Ymszb+a9GodMQl?=
 =?us-ascii?Q?SxX5n4OWOAMYT0YK2jDxP93ZjCN+teyl2+5fme0gZVX7KquYKttPgQDEqj9w?=
 =?us-ascii?Q?BVt/JWxW7HxPXzx74VjmxsOzZH+7kQQHsTYnZgpiP2rfnyheUuNlv5+PDpER?=
 =?us-ascii?Q?Ew0aheNlye6ByXhY7L4shRBR1wIQhygrXiuY7ZAZlRpAovk3FJ6kOCqM1vMA?=
 =?us-ascii?Q?q9lod4LCwtKXEY2GoC2qW5IUtbIg3yFrHDXC38wAAdJu//mFgYQsm0zeMs2S?=
 =?us-ascii?Q?tQXcR/2DxY6sYPnoTPmvSKhaEfp+ti4KCbtHvHhk6NCKTGiOawN9zOEXNBMO?=
 =?us-ascii?Q?wh+1rZp5bZucshypT8POtFKS24ZvXxswF0VoxNmsILZeRxdSiID9v4RoX5k5?=
 =?us-ascii?Q?Sa4ob+h9Mty8/tPGnEX3RFmuBXdNeVCQr8dGgUnFMn4OucSR5GqtTx1bPZmC?=
 =?us-ascii?Q?j/sUOlT78A9PmNhwDXxgiZyNoAZSf22cl8S2WqDGfKcOQ3QjtnIskXI0el5z?=
 =?us-ascii?Q?ghQnhLOR0FtbR1o312gZe54TGTWT6TW3yLeFbkA6+A4YY8or+SeZTeAaHUhr?=
 =?us-ascii?Q?ujG9K05qi7hPLYrDRpPuQXtU2DhZjRRektXlpEZiPvhwFmFb97gWmLTOm1aE?=
 =?us-ascii?Q?m2S/rmeSjzI5zkOyC3ArBCtHm/44ELzL+Pfqc9dNtgh5A0lO0BLCgRe6IUOj?=
 =?us-ascii?Q?qeI5SUVuYPOR78DYobh/169OoIihwHS29RIAuDqQb7Tnw1vYR2oljyi5HjMM?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cpAXZ3crd6T9JokblANrT9LuRMvqmr/YhnHOgQ4sH3D+plM+cJ9aztel3ZNW5mPLmDBSSBG/q++53XOjxEku9vVNahYUgh4hihQr4tqFROHlYe3mSDFMBkRIVdhXdFktlW1zfq27im9M/mQP+4Ou26+PyQBJTt+X/3s/JvkC6a+JBvH370CLgyGIjZZtyqu5rHhLzaZWixkNvmfrXnCdOu61E2yhrf0LUqzW6fDjN8Txsc9HztgNHPHQgXIzpJB+FfAM4XwQDPpnIaBO4+D/TNopym3wsRMrCbwMEhae2Q8LetrVEMqtyYOcSk254Z0JzGSfYj54o6ICffCD49es6Kq86kFMsEoYwmhvboc5Pje6GE5ONmVbo8/va0WVF2C2RteVJqEB+a5d0r+P+lzYO2C7EvtzNkYLgnQ8gEEe6GaDiwq9FyO4IXIfDas15gDBy5HrGa1Sku9KoGrJmfUJU+2Txn6vgpVegoZIojQSD6h/CHD5sKoK4XrIwK/mZ573Z3auvXMQ2niQsSNMzvjueGxx6xMacd/5eOopUh/0DVHh52aaZEAzvzJeJL0WZcP9Wj9SOhKldxqBSt/eWpeHelrxab/RDTLwlFerwwd6sNI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c76dd038-4b17-49e3-9cfe-08ddf5fe5913
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 15:24:52.2885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FfEyNcPM2sqFj8/2V4WE4PQoF2GQNXgxeaJzZ9giIMmMvAmKse2jhgKFIFp8TKquKpRqpwd2CunP18542iGQMnC+JKiGP8JGNZvKTLD5keA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD020A49E6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509170150
X-Authority-Analysis: v=2.4 cv=JNU7s9Kb c=1 sm=1 tr=0 ts=68cad2e9 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=RmA6VkjFzPJuhqsbX-0A:9
X-Proofpoint-ORIG-GUID: j1kS58BopQFstm_F2L-iCefQvEyHdh3J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX8BdttaFLsq/3
 mTwvnlIDG2eiYueDbkISJdxnweLSP+nltYrA7PkdkSB5u7cM/zzWEXWdbPSFNu97TEXJueKK7xq
 3A67FM6hK+ZXvI/REHVCMmUWtCD3fU30GWJ7R4ZT39605kHsO/5WzaHEYqAVGR8h1/mzM3r8l6n
 W2OXLm5TJWnl4S/PvqPTyCqXo3O4pq13+4PtIoQLRlng3OPl5rGC88NllFuj+TAfQS5i89Jk5Ig
 9PcXYZphJSbYZ5Jpx7ZEhm8xw2S02HXDYATsX5eg+35hj+A4+KP7UATlSMiiPLi0GgcAy4l9RKC
 n2aARFDVTYI2LBA8Lw8JBdSmS7ke5cwQEDdaFT3Dump6wMXaMq/0j+cFt0ea0uWgIXntq/II3EU
 kWR/jGAl
X-Proofpoint-GUID: j1kS58BopQFstm_F2L-iCefQvEyHdh3J

Define ARCH_PAGE_CONTIG_NR which is used by folio_zero_user() to
decide the maximum contiguous page range to be zeroed when running
under cooperative preemption models. This allows the processor --
when using string instructions (REP; STOS) -- to optimize based on
the size of the region.

The resultant performance depends on the kinds of optimizations
available to the microarch for the region being cleared. Two classes
of optimizations:

  - clearing iteration costs can be amortized over a range larger
    than a single page.
  - cacheline allocation elision (seen on AMD Zen models).

Testing a demand fault workload shows an improved baseline from the
first optimization and a larger improvement when the region being
cleared is large enough for the second optimization.

AMD Milan (EPYC 7J13, boost=0, region=64GB on the local NUMA node):

 $ perf bench mem map -p $pg-sz -f demand -s 64GB -l 5

                 mm/folio_zero_user    x86/folio_zero_user       change
                  (GB/s  +- %stdev)     (GB/s  +- %stdev)

   pg-sz=2MB       11.82  +- 0.67%        16.48  +-  0.30%       + 39.4%	preempt=*

   pg-sz=1GB       17.14  +- 1.39%        17.42  +-  0.98% [#]   +  1.6%	preempt=none|voluntary
   pg-sz=1GB       17.51  +- 1.19%        43.23  +-  5.22%       +146.8%	preempt=full|lazy

[#] Milan uses a threshold of LLC-size (~32MB) for eliding cacheline
allocation, which is larger than ARCH_PAGE_CONTIG_NR, so
preempt=none|voluntary see no improvement on the pg-sz=1GB.

The improvement due to the CPU eliding cacheline allocation for
pg-sz=1GB can be seen in the reduced L1-dcache-loads:

   - 44,513,459,667      cycles                           #    2.420 GHz                         ( +-  0.44% )  (35.71%)
   -  1,378,032,592      instructions                     #    0.03  insn per cycle
   - 11,224,288,082      L1-dcache-loads                  #  610.187 M/sec                       ( +-  0.08% )  (35.72%)
   -  5,373,473,118      L1-dcache-load-misses            #   47.87% of all L1-dcache accesses   ( +-  0.00% )  (35.71%)

   + 20,093,219,076      cycles                           #    2.421 GHz                         ( +-  3.64% )  (35.69%)
   +  1,378,032,592      instructions                     #    0.03  insn per cycle
   +    186,525,095      L1-dcache-loads                  #   22.479 M/sec                       ( +-  2.11% )  (35.74%)
   +     73,479,687      L1-dcache-load-misses            #   39.39% of all L1-dcache accesses   ( +-  3.03% )  (35.74%)

Also as mentioned earlier, the baseline improvement is not specific to
AMD Zen*. Intel Icelakex (pg-sz=2MB|1GB) sees a similar improvement as
the Milan pg-sz=2MB workload above (~35%).

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/page_64.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 289b31a4c910..2361066d175e 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -40,6 +40,13 @@ extern unsigned long __phys_addr_symbol(unsigned long);
 
 #define __phys_reloc_hide(x)	(x)
 
+/*
+ * When running under voluntary preemption models, limit the max extent
+ * being cleared to pages worth 8MB. With a clearing BW of ~10GBps, this
+ * should result in worst case scheduling latency of ~1ms.
+ */
+#define ARCH_PAGE_CONTIG_NR (8 << (20 - PAGE_SHIFT))
+
 void memzero_page_aligned_unrolled(void *addr, u64 len);
 
 /**
-- 
2.43.5


