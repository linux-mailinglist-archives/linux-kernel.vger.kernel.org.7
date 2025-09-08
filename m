Return-Path: <linux-kernel+bounces-806683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D342B49A57
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9321B24A5D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C077D2D3EC8;
	Mon,  8 Sep 2025 19:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ePWh6ADn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="psR4NSH8"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D742D3A9E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 19:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757361053; cv=fail; b=GdBYDWbYvnbrgYe0BfraWHhH7WotNFL706FV1WCJpXO7QUV3+INKgTTktAqAtIOW9VRHYlZS17u/pyThOGUNfQsdp60oWjgf6Y2gzeyqygDiF2+yj28ghBVh/1zl9rmuTWzt/aUHeoY1CBgXd7lDkiyJ22sN/VaF+GlBXspGBz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757361053; c=relaxed/simple;
	bh=B1uCyME+USh5YsgOn5T3rVzoXDCtkhZqr0sWqG7ohwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=twOYrti4ESR4aLO1vZJTIpaET44oICt+m3JOEPrWHCthw2FKlJt8oh3sWUz+E5a+dZhL/qO3LYCA3voTJhnBo8V0AG3tKhNEMOFTUFj16rSQUfd67K6j7dY1TdPqBEP7wWGNGxQf+hp+M4oiSLGggA3BRM2VMkmfTVZR3mUUFYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ePWh6ADn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=psR4NSH8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588HfdKe028234;
	Mon, 8 Sep 2025 19:50:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=4YXQznPeyxqjx8Sm
	mzk0aOhpp5slciuLdcBZxvSgQbw=; b=ePWh6ADnoVc4CBeGhIXxED75PufKjI2v
	64J9wumo2uNMy5ff8QSyLk5+3K/nQHSwVzD/tffzOOp72o76VDdS0RLsAUfQDGuv
	izsc5OETzhO+Nl1AN1xs1qQu1r+iZ1jVORwF+zzDheyrHqqALZaYe2sz6msJvCcw
	Nxp8mwd4p7PcSFTQAVUR2GJ1CmMivPtc4vMdZMchF3Di1ab2E2YJ00/ED3D0eKpy
	fGYT/mo197yRUqrD6EK9C6NezStyI30axtqTJawOH3Qzi638N8xdIpbLkOCfIDTc
	zop1F7oLVkHLj85ePVrrhqAb5T2CdSraEyeA/Q0xXUgy8doi1EVVgg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922jgrdgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 19:50:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588IY9mQ030995;
	Mon, 8 Sep 2025 19:50:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd8n0rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 19:50:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfHcvnDzRUz9E1fXp9Y5tMjGXHsWy9A+i6CQpFK1uk4ohW/MECqCWa6QRkMljZZayNrbVQrMJA4KOANoWygYq8s8JfIe6C+O/jcfSXhj5gQIqYcdccZMan3xo/zhwqdGLtFX8L2wnQY3Zbej2wXCv0M9xuW/JlUEGtBs1gRzkGrl6pSVoCMzmEX4gA3jXATugrKMMk1BCFENGhNfeL/AmRLW1xftlT4J41qnP/JvOmR1OUfD5oUqoVhdQc05Ei6KGFMoRqVZ5Ybg6pq+4d9r9WRrXnML6Tfqi4cY1gEneZZnN4wheN0GAx1mwJdsngQ5SQzLkDWRR6mt1LyAyVht/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YXQznPeyxqjx8Smmzk0aOhpp5slciuLdcBZxvSgQbw=;
 b=W8XjGOBsxxztWmsZErGijhF9m+QXpm2EVK/IIt1h0lw1NDyRACRjiQvAQzAdzmobdmyxvnq2zHHWtNuDPIi/fXrICJ4iSqpHofoDHR3SRl4sCuHH9xvaEZ4Fayiqc+gdo4YGZ7bKoD/uXxOyhHjcgCt8147YF1WaC7nANuqzkpiUoIBYevlqqp1AV+37r/v322qHCExak9WNxhA2j0r264FM8YN/oqTkTqM8x0qLmPQXJCNFu/sVoev9/nMwoJPVfGcH5V3LjKoxbDMo/CdNtR2wjHLEWTFvx5AKQmb9Fnx+phPFb8vJxpOyeVlcZc1Dl6m9OCDM0k6fzYIedHneuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YXQznPeyxqjx8Smmzk0aOhpp5slciuLdcBZxvSgQbw=;
 b=psR4NSH8u3dUBuK1O6aYJCA6xy3IPVX47UwEgoNR260YyvxE0UU9oAeSNR12feNckPxNwdi4+Np8+ldtMPGoSlF2M6ixRPIi//9oSMDWEw+IMtmTH08Zpo9svh1U7FUS2FA1pN3miDwiK5lq9F5TodtCLPIPfbafec9lmQmdAIs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPFD91C619EF.namprd10.prod.outlook.com (2603:10b6:f:fc00::d4e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 19:50:24 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 19:50:24 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, Rik van Riel <riel@surriel.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add Jann Horn as rmap reviewer
Date: Mon,  8 Sep 2025 20:49:59 +0100
Message-ID: <20250908194959.820913-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0037.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPFD91C619EF:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c30388c-0b8f-4a92-5ea5-08ddef10f3c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oC7zs4xsdLqY7kw8wY8m/yJNUKp+16upjYar4M3iVFj6opTq7Q7+i5HrNEvj?=
 =?us-ascii?Q?hMAxAfQhtjVfTFquGolVDU6hpQYX9jXX00vpisqH4QrYM6gXkzUrySdRry4V?=
 =?us-ascii?Q?ngz+IQARWphtHLlh9/QqTDB4fJHOmKyxSSwXZXW9urGmB/rdH9/tHcraT1hp?=
 =?us-ascii?Q?PMHNctGCY+stgnA/3iywTAdZ9O0RZLiK6v5uRgWW2E/CKB+lg/h1zgGuOSR4?=
 =?us-ascii?Q?dSgSJieVkfck1F087pZAiuZQESFpBFLZ8u3wLcg0WgQve0vQc1Cm4mWaWnLj?=
 =?us-ascii?Q?0sK/qLJ8BTiInzKBnuYGSH6/G2SBb08x6hu0998UbvQdnTGUFeNTBoEm/aMZ?=
 =?us-ascii?Q?no+uM1wYugpUccaZHv2zRW9kiUCIZNligkVHfKnbh85VtkcR0F8AKMbtIZC9?=
 =?us-ascii?Q?nkjXlATdNRMwyVDRPxEHgdJ2qJZ2R4rVHOPtql6Y7LgmamoRoXTKGSXJlZsa?=
 =?us-ascii?Q?HPhnFpgiuVAl6SWTe1/OBCipaOyReRr2lddwzLw7IQSg3XtH4DRiCpn+eNyc?=
 =?us-ascii?Q?bpS1cZmxktXXO3WrLHIDugV3RXQFGqepQTwK/JpahFXCVTcrTLhue5tykmYy?=
 =?us-ascii?Q?DRmi56pjyYeAeYCkrojS1I5E9e+8wwimxvm6JCPZhG9ykm6m4DlaKiIJfrge?=
 =?us-ascii?Q?pTI9XMl+NrymvgcrSPyyyizNQcBJ0bzrTT5mgRnUkMjk0I+uhvyRbQbJf378?=
 =?us-ascii?Q?BgTUJKpp51vSLe2wz1plL+hS3druWXoBpfKN8ySa1C54Wi4DtGg+hCNkKdst?=
 =?us-ascii?Q?618OnSBrw9xqMeoeXxrj1lBdMNtuF3Cc9vllpuUVvW74RPP3MMvd+NK95vQ2?=
 =?us-ascii?Q?tJQeh9egevo9qeOrXDbpchDvie7MrlLtGw57a48yDAZyXk0XzUUDYBN8EeDy?=
 =?us-ascii?Q?L6fsnP+UpV2bP4Ip7sMWaKRn8U9JBq7u/n+WKBNpjUZfynsjSL/c1yJVQ6+f?=
 =?us-ascii?Q?0b6YRR9TlAQJc2daIf+lRyVrhj0L07wOf08OB39asMEyPz9MmT9XvpJnVrrX?=
 =?us-ascii?Q?B1i43ZbTAE66I74N4xXFFXxxi/B2kqzJGVUl/gRH1LL/J2xKHI0ob+DIU+XX?=
 =?us-ascii?Q?VvhIzBCLgUIcFafE/YhMPSQP4IuKHVVoF+VsBksUqEQPjwWLS6ue5ubhI+SP?=
 =?us-ascii?Q?h2dtgB8uWPpbpcIfZPcMzPKG7zp5swYPd5RyKC45GLvX4AimqHxUNOG1a54X?=
 =?us-ascii?Q?djbR761zZ/90WczzzLSz/uu3axGzkYeF1a99Oz73iqhE246B5QGH8kZG1QNj?=
 =?us-ascii?Q?l0gcsjkAzD83LL15hPSfUzexpHYX2w8vO5cqae8CIBCDAoWQWDxHV20ZM4K/?=
 =?us-ascii?Q?ZiNcSJSRK45EqhjtGSqONMvp6oYwrKUJ6qvbT15YA2zMqagCe8+SbZrHdSMH?=
 =?us-ascii?Q?h1WEltVYXqW8LRaiWi+zLbDkZLKJt2SxgEXw87lAYtt36vFETUR8tpDxtWQ6?=
 =?us-ascii?Q?woAe3Udyxww=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UXZVXSD1XDC5k5VZJ7xug7V38Yojs0SFcWdEZsPkSxw8F7GsGoJCGNQsasjc?=
 =?us-ascii?Q?SNfJW863nfVZb1hBeddTroDLFTOgYerUxj2B/zr45wVY+97n7Vtd/xi1keGz?=
 =?us-ascii?Q?NT1LAQrsUK/4OtGhDEJg4nf21x/vnEGDGqoDmHDNRopMggDnSLrPfRtYt55P?=
 =?us-ascii?Q?ZWVSG3qVscgKi2mGPNtBwqMVwfVV1PDPqxY1MyU8RrGeNCGTJe4YXAunavnO?=
 =?us-ascii?Q?A0U3w1TBPmCVRBjcdSMkDoRx90sSxh33nEYjA+6jnWLZWJXPCiZ0gMZqy9Tz?=
 =?us-ascii?Q?3U5tjhd7F9cHgnLgeBuBDYsWCxqDI1yAX/sStQxLNyguaf76Mb/hBBHdo9Yw?=
 =?us-ascii?Q?YREUYKIXD9aBlRwQT1zdhXfNnO3Lni0/qc9QcwvXUKlnjWgvjOGXOYyVBUYk?=
 =?us-ascii?Q?ydgOvHaunNeP1rVYKrVRxYHY13THyXGQnLCPCp7aN3Z6T7/k4I3YMpbajx61?=
 =?us-ascii?Q?VTdAw5rreQsQLsSDn/Qy8m1Kgc2PzefjifI1LLH6y7B6DyjUK/G/8V1vJ287?=
 =?us-ascii?Q?RAoj4tjsp9ha8aJQkbkOerQa8ToIAx7ZxGbJdRy8LmNhradCOQ05RGGrIdLf?=
 =?us-ascii?Q?ifnmHC4JlyTnRUa6MYtrqzB2ytTEU2DlZSKKszatmobLYqyX8XA0KXJSumRO?=
 =?us-ascii?Q?VlNfTITXRGeNfFaRaSUQd8kEDzUI4P8+oqSROiirp/zEJxyyq0Zm9HFaMWjH?=
 =?us-ascii?Q?FrMDPV93PWezvoDH30cC7AqX2G/gGsHrgIMBgqhJHPruVS1vAXS8dB0Cc5Vg?=
 =?us-ascii?Q?D6+RGMDaHzoexVwAzd6bxNmkfICFqmSaCxV4+wjmlDkuTjfDNM/MkDS0YCNM?=
 =?us-ascii?Q?/1FCIVfFrRdGdvuaHexXh8maCU2kaVcliHn4qV6Y2BKQMwQtbXIPxED8NdR4?=
 =?us-ascii?Q?Ahd9o0rHZhoCGPxNlYUGVgPizAOp2S21Ir43KadS4kYp94u+skmmVnRlCH5t?=
 =?us-ascii?Q?ZtX3HRpaaCXz4RvbgHf7JoV0GJCaH5TzXACSjP/Imx2rBlKDeEGwvxG6anwh?=
 =?us-ascii?Q?61HfvpEjJQTcSzL2geGMBCWAuMU/JkigY1oSUU1DHPkr85pIsCbYJ2osIBhx?=
 =?us-ascii?Q?SX+Bw4WL+KXsK0OfqxaIt5w+K3L2C5Mb0Lsr1DStCdrc4Eb6kZ7M32OnZH2U?=
 =?us-ascii?Q?pkDXLQqHedgDVMp5GajTbipa6npg2i52e6FxatEakk7JVjnaI7E3qeB6URlO?=
 =?us-ascii?Q?RdchwTr5X2o9iVgHpGAtcY/QGkQY4IUkHbo5wjDCFpav4MN5h7FzhGsctpkf?=
 =?us-ascii?Q?OaEdJv9MieT8tm9bOb47Cowe+w7sQmlZE5WwtEEq3Vdb5zQm+iJdL8Zi2IVl?=
 =?us-ascii?Q?SSoDg8vTCxlb6rNhtmBJGWmgv7nGFHa46rr4S98/LpOyuhctxhHvf/JkiyY7?=
 =?us-ascii?Q?KJwU+bZqxKaejmQAwLxmtwOV5pDKuHaqMu80pqduyhGqN+XbWmaZpUCM7dXO?=
 =?us-ascii?Q?k/g8Te/KBZ1wmjPkILKfM3jvWXdCjpvO1krwrwCvHO6Djr3E4M75BLfKlN7x?=
 =?us-ascii?Q?/wcLcWJUyi/UHJJPLRZ6tsjn9RlvG1zymsfsIv0SsAGUv0VKHz81v+dUtS2U?=
 =?us-ascii?Q?y5y2zNGsC7cykrw/qlRJqXuCDhwPWD9WknRLysu2i5Mrk8MnVkl6l3sV7qUR?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J6cDHjwMSvbjh4djagnPaYT0qSkKiD8iW1XjJcggs2FSN2eSsa9GahC0ZgeMaBEITifFEEBESCK9+lRWVVZRkW6M1KqeYxl0AMCXIjuW3/n0mQHZlDlainUxxvXuJv83CV4Y3rIVyDqizKMIq6FINZg42+fg/8g87IFe2cA30D9SPcnaLDpyGBxIzJjD/qo6zW6tnjSqm8STaxui5xdk2xlMVhxfJh1/vGJqS+hZ6IQwr0oX4tr+uVWSSMa3foHriqcq2L2WeN1bsYkP9DaG3a4FZC5DU+CGNg60o4/nKdu5HuRa3Ns62y0KAyL1xeqL45afM7iR8yxGjzC8ZRVxwHYClqQ7s6MjHGKBTrBkl6fpUw7x37joOLvxKUOntHHV/CeM3ggeCzLjKJQZSysS/Q8Fv8O/uol3iDsByxZzvWeF5IZyN8tsmXf4ZqLxr3oVg1xq3GH1Ed8MwvWgyPrRQAzK2nSrP1DZM6vV2/HxRkhpXNaqgJsmowWincSgKJ3kjtOfvMTPh078h2Qs1c/MFvV20Q7OKG7wlIyElaLreH0hHA9PSTFoSb6ak1HVfyl2mmqVUeJMf227/CHuQhGonPLK3ZGmOHD+QCoDhYlV3C0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c30388c-0b8f-4a92-5ea5-08ddef10f3c3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 19:50:24.5392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6SW+f2ppCt+Z43wRgoZZmTZdbpT6Yvc7Zqfqhn2sywbyrM4XDou4ydgHDDSmUqliBZEDNuok6zeqacUadT++3wQk1qCCaW4Eb+rBWHIHdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFD91C619EF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509080195
X-Proofpoint-ORIG-GUID: EkbYugUubrXqbWyk7lVzPfqbOdRQRFWY
X-Authority-Analysis: v=2.4 cv=PLMP+eqC c=1 sm=1 tr=0 ts=68bf3386 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=fwyzoN0nAAAA:8 a=1XWaLZrsAAAA:8
 a=37rDS-QxAAAA:8 a=MQiP5bjvHGJZjIs2ae4A:9 a=Sc3RvPAMVtkGz6dGeUiH:22
 a=k1Nq6YrhK2t884LQW06G:22
X-Proofpoint-GUID: EkbYugUubrXqbWyk7lVzPfqbOdRQRFWY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2MiBTYWx0ZWRfX/CTJp2AkVS3F
 fxd36LttNGwci5WRR92ZwtP5litZHl2FQn7PIrXzzvrX8kxE8CGAb6uLRDsg3RhF8LiOKN2TfwZ
 Waf+kZ9fz9LOzG57CtLv5O1z8t0we+cezCjcuOV/gnNqCzsxLOcwEidh/HPJ0SAbZmmw+gnHNq2
 iDpjL4oEJKZA9zkp9qlO0BO8HvAhbH0UGpHh9zb+lREB4HYTY+KMg5zKlusNi4kD9EFcNKILatn
 t6jQNEzJyV67i8iDqlMPpau89lDan672YjDSacEw9bIo/HDnEbTM4m7t3tlva+z87AApplOOWoz
 gDzH5FhtCxbFFPu/jsWxLidiU+Rqsx4nCJ24FTKiZNDGS1F8iqrRtfpnKbvJsiNrXnSSy7jL/Cv
 mN5zeGV4

Jann has been an excellent contributor in all areas of memory management,
and has demonstrated great expertise in the reverse mapping.

It's therefore appropriate for him to become a reviewer.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
I spoke to Jann off-list and he kindly agreed to become rmap reviewer :)

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8fef05bc2224..ededb2cf8f9c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16198,6 +16198,7 @@ R:	Rik van Riel <riel@surriel.com>
 R:	Liam R. Howlett <Liam.Howlett@oracle.com>
 R:	Vlastimil Babka <vbabka@suse.cz>
 R:	Harry Yoo <harry.yoo@oracle.com>
+R:	Jann Horn <jannh@google.com>
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	include/linux/rmap.h
--
2.51.0

