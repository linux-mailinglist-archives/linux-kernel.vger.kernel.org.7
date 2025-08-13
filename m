Return-Path: <linux-kernel+bounces-766102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C058B24256
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3CB11BC383E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307252D46C3;
	Wed, 13 Aug 2025 07:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eY+UvI97";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uVX38iv+"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FA815DBC1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755069022; cv=fail; b=NRDcnELHpczZHWw4+8kbtr4OXx7CdziuBUu8tr5zW/sj6uri6F5gt2sWuSygxCKJTABX4aF5PiSMeNi3wqo9HMrCTIjGvij61y6K4xZ0gfBzu8zdHcr9zNuSh5kiqStjaA85bj2S7PyxWaDyFf2uwnmaCLm2smWjDhNf8HoLGj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755069022; c=relaxed/simple;
	bh=oq7NDA1Kg9PjDOjyzjslsrJHjROUgbWyDwbB5D5/fiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iu66SCBfth3C2jR16+xGmMzyuY/394y+kLORrpTgSnm0ywbJvpNg9+YebnDh69JvkLPKnn/SCBg7T0Ed/KXRXj7sdAid+9K+WSAXi94kWBrpXKxcGu74sD07GGSzmZkdrXHNFAH/EOO/Gy8XCoO8nHOEzLMqcdgMCUanMU6czQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eY+UvI97; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uVX38iv+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6u6NJ027146;
	Wed, 13 Aug 2025 07:10:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=zsD7/DY/mBvBpbGI05
	9/RaKh3In28p9dBTo1AcrOUHo=; b=eY+UvI97B1p0QICOFgvrULZej1UxLAHKqW
	GPQeq66VhHXYEhLDxGF9j/gtU7yN6ec1rek9tK1vZ0H1/hBWoZrmiA35mJDH3i7d
	uV37GuKhi6nAWN2KqpyolXxCWr0H3eErM2IT1Y/kjo/JwcJCVXUaPV4q2v0osc4U
	GjTl44TH5Iyzfec1Dp4zLqmFmjFTDsQhC+2x2omp3oCOFjIjMWHh3jRvOwsMFKXE
	SM9wkKPK2ZoGDn4nkuXGZYoKYPFypWjHsn3UTuEFq7y//R05+wHHhT4nGNFFs99K
	fZFccFsQO/wERO8TWTx5pVP3byxI+kDDJAqHLKxEZ9jVfe/MyskA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvrfxk86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 07:10:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6FBlA030076;
	Wed, 13 Aug 2025 07:10:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsb17j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 07:10:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2X/1Dz0pPuuxjjZh5f0OAcEbjlkTd6jw9wn/UBjbGSjpQqXR1gGHxvNT7/OTLsKubyL0Tlvo66M3/vBwESeThHzfKMbgC3g37FMlZFqwrv7GAuPWxbMSI0mOnp/nuOGLlPUDTvMPeujbTD4c0Q1XhL8UFDdjixlZVD4kT8FNSCBufstS82MGqFbqVlZWsQXScNhqKJ9r5g+UcaqNwFamujbJ8Cs7XYh2wHiOEYyjCgZcJdnG9errW4ThiU4mImjT+tuyAnrkClnxmnJe0kMK1ns+r+aSRVe7Hk5EMWiaFqDrLZO1zs9GxkFE1ABDqmjMmS7hlnz9l9pv9BakpVmEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsD7/DY/mBvBpbGI059/RaKh3In28p9dBTo1AcrOUHo=;
 b=aVwNdNHo/zxMryqYOc8ZLHzZp+EMGUhHXx+fO9krISihT9NGCPDKv8Fy5E30vNKBb6rfnYw/TLQlAwWjrims/+UeU+Xsnyn0cUHN2VjlCIiXEvauEeZ/V64bLFevCMe8FkNIEwupsi+DN5PlNRTuOluAQMI9IJldRdTPktQMAgFexRV0mdMuqf1hwG8ogmIpvFsxikn3nF7idgzENliTYKP6HCAZrNIYE7yabZX60Rtfl1zkWV3YHF2Yh7Bxcio1Y9EjOvtKHIFa9mE5bb1Lb+Zz4fVEZM2qvBAHi84NUERPXBElllu2pGLaZ87FhEv0DLbv/l/9rU0kfLd5V9VOjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsD7/DY/mBvBpbGI059/RaKh3In28p9dBTo1AcrOUHo=;
 b=uVX38iv+WKq7tisozCzNJKGdYpQTmf0RNlgstaXeX31JQTup4iXghbLPwsutAgQivIlOIZcy51XpnGPXCsj84mUsi1qvVrKqkNUMPKeK7qK/DUG87ceWp+0JM9iTMAvVrX67yVKwtYdr1DDP/Xkx9h30W+Lbbqrx+1LB5ZcGuMk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4413.namprd10.prod.outlook.com (2603:10b6:a03:2d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 07:09:59 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 07:09:59 +0000
Date: Wed, 13 Aug 2025 08:09:54 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linuxfoundation.org, mingo@kernel.org, namhyung@kernel.org,
        acme@redhat.com, kees@kernel.org
Subject: Re: [PATCH v3 15/15] perf: Convert mmap() refcounts to refcount_t
Message-ID: <aabd9668-bd22-44de-a4ef-e3bff9c48c28@lucifer.local>
References: <20250812103858.234850285@infradead.org>
 <20250812104020.071507932@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812104020.071507932@infradead.org>
X-ClientProxiedBy: AS4P195CA0015.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed56eda-7e5e-4f79-fbec-08ddda386a57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L9Q9Xpg4jzlcYMtDrjr/JpCuGklOBM/HuQ/g9ukA1eF8rYzHh9+tyuhuBdpt?=
 =?us-ascii?Q?/C9ccOwuWEIxP8cDp26rD0PvURDP9xEMmel0DdDUGh/si39Bs0zmEtlVn4kx?=
 =?us-ascii?Q?MxPP83wFdWGGHFowWPeNEbJLNlCG16N1YvpWyzGI49dLwIYg++XxzxXscRCc?=
 =?us-ascii?Q?MJParK49nLk6PRBrVYah29rC5/XiyDGROM0nsSkV0ozGpFjckxpmo6Qrt0hX?=
 =?us-ascii?Q?R+1zktA6r/MTSUdPb625adB/S6MlCu50kPulFaP3fmB8IPwUYJ195oqUkN7G?=
 =?us-ascii?Q?ODWnzsgA2/UrBex8NWKCtE/cr2q1WMJFJ20/9VZKPx9IpiB0AZZymCRhjoWJ?=
 =?us-ascii?Q?GF6Mw/Ig9+/+w9Nj04xx12yuzfrtiHbvsG8UzeTTOSAFNXJ4AU6WpE/ujHWs?=
 =?us-ascii?Q?vBkEdgh3LzjvB3VmUVaQ+9kPJw881J0z/vGDit2drJ/hg4a2szVUGhc82dd7?=
 =?us-ascii?Q?SaJu2WylnvDJNOVJpPkArQxu0QnmlNyg+FRG6AQybIrRVfZZyfLbP/TZm0Ib?=
 =?us-ascii?Q?6UiCa/WzThMSY2DqS6r7HHE2Q2zd7GD7iOUBM5GaROCBS3mF2OyUZms4WzZE?=
 =?us-ascii?Q?p1R2qXr0P4NKGKjOO5lDLUGRVvoba+dK45js2Fz0NEMjuxlc2PFt4Y6xWtuy?=
 =?us-ascii?Q?UTj4BeMK2EIA7V0oXDx/mEKOjLpIdCg2VW3SA5UlUXG/ZXjYkiC3OAB6ddu9?=
 =?us-ascii?Q?GsVUuLCLAdXpQe0qzs/4QEI7LDaMMcPuAWy2/sTmaptIIrB07M5BnvVKdlyN?=
 =?us-ascii?Q?L+M/cM9rrUbYu4ZU1SOrVciI8Ju34tYhU0KFOrC6wqdf+lcnImUjQHJ7pA6+?=
 =?us-ascii?Q?TB8yYGFyUK0i3GWYDqjiAwDAAAv1WsMTD2VE5eCXt0kWr9UDAsBvilzTgJcS?=
 =?us-ascii?Q?Xs+8trKIXVY/mYfrlBSnLyACmrh+E+SKYL1aTe/nM1HgRPG3koAPSL4ReXPT?=
 =?us-ascii?Q?hkAOVW9L13xMr8qBf5Oos1+2xYR3IcPj8IIOkW0vBQUjPyuXAmmlOvx6q9Ux?=
 =?us-ascii?Q?nYex5HQ0aaZaSMS4+7C1NgIJIdvm7xsnVEV+fy822w6Rmd+8jaLE81JWmHL5?=
 =?us-ascii?Q?At0LoEwcykqzrpPs9zpletQwjSDzh2fLOOXlF2r20fwx4P59g5rGJ2oBYfay?=
 =?us-ascii?Q?1x/yC6fB/cK4M70NeH104Pit+KruTK6KLcyIb6uzuSIY6cvV5Wp9WaIrWTb1?=
 =?us-ascii?Q?BHRQjgFvCzb2cfbUAohq++4+2VWCKqgAtVcFppy21xKuUtoW0V74mm7BTYGY?=
 =?us-ascii?Q?UljBjKzE4RUG7slIBdRG5XtyHLSWF0RYy/F7nu3g7KFm6izGJH+79dLAtdFY?=
 =?us-ascii?Q?f0MXy6jCsayJo5/mLnG9vccRW4INdH6psC2as9F9UZqU14Otxz16TLMb+Mxc?=
 =?us-ascii?Q?k7jQjzlK9LvMxuCcPJffks7WqTTg8L9ACzbvrfXGAK7SUuOtzc2NBAz3w97A?=
 =?us-ascii?Q?D/uavM1tcKU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/ZkTwf8DSndg5fHnuKmWHBL9NVUfFxdIq1xGmR/7XgIIGclWJw5d8jK5c2qS?=
 =?us-ascii?Q?xk+ipnQmkLi39MARi63BsFPzcWWNYnxr3YthWpxkniYhJo2n6Bw4EPD6h+km?=
 =?us-ascii?Q?zVqsd3nMc0GOy0WmdwtnaHgpVh8EggEfFA3+ISf3xFsWRpIN4jRbY/kRKHpP?=
 =?us-ascii?Q?bmlsFiLY6C+0QY6XB/73L+H7EhkrqzRjuZiBVeJKnWZIil50VlFx3Jl4xPq0?=
 =?us-ascii?Q?55xnzPnMRem3imSZGqGf0rrdokJo4LiyM8X+7QgqcxUENtTFSsdmASVb9G9p?=
 =?us-ascii?Q?Be88qJe7Zjdb7niBMwnHx+Q2uhbr4ETguXMvbHJjtBTAxrK7JrYWe0rJURlJ?=
 =?us-ascii?Q?fkGDfgaCpxHOg0oriBED/3Nx8EhUyhBppNOzzMlwEJpfWiv0lw07Btn0OYGX?=
 =?us-ascii?Q?bnbRtROxZCKYavP8HulFhs0KSujVqq/O3Ebqq3oPppUXCHM6IizmN8FpmW7R?=
 =?us-ascii?Q?ldeNCaGNuQtTrYrXJjtfvZJRFSE+co/jz4dhFQ3un8QyygobuGWO2HMMOfRX?=
 =?us-ascii?Q?GrYI14Qd7dqcd7TaNCIHcHp4f61fe6hPTh1xr1V0oYm5TjDsP82cO7DmtWq1?=
 =?us-ascii?Q?2MM8FCKz8IFdhrAov8WufARxM9/w7aGHDGN2wf5sEcDMdqA/YyI8vknUis3J?=
 =?us-ascii?Q?lOiweagqcHLzOtBt3Jmy3RinqLGxsvcI7CMkupfPPvyPDfdUdqRtjGMGF7RM?=
 =?us-ascii?Q?SAwzjlYKHwxoZwCOjkIIh+YZTQphJPTdMZZ5jc5BGyGDESFNqqvi+4g87U5U?=
 =?us-ascii?Q?IasjMg8RTBGKGuYq8Y14j/O6EbbboHV1S1PGxvCqdgiu95974C93oJZjE8Ik?=
 =?us-ascii?Q?fkqKPbRatAS3/1HxD1tVe0OmzNDbosDJOcH2qgjpkdKStb23DH3YGQylKyTD?=
 =?us-ascii?Q?b0jYfKw2uwX5bH9gLnwadkvl1xG5iEDxjt8foRpFjvX9UeI7+xUdbw/RrgDl?=
 =?us-ascii?Q?zKmvEp7oBOPg+8ru5LKfRC3+aW8A1DiQNUHBZnGsptbT4AXnjHKaetMwyPps?=
 =?us-ascii?Q?us2v0TzY308f2phcm/J2xVW4/JEF4+P1z4ZpLdKmGxmfGK0SpGljoRONpyRL?=
 =?us-ascii?Q?cj68wCY+e1s6jqEuG7NSVHvUYXCio5FxpIUiG4oQcIgQCMUfiY0b910Kps2A?=
 =?us-ascii?Q?o+0JcWCilTOv0esK60KbcwiZxiKYropuk7xul2spmy3Cgag7RwEmZZNI7PqT?=
 =?us-ascii?Q?8hjWAs7YddCPRxPatQB+jnF6zWVpu6gQtYEVCiqSCzYM46JnN1ZbmY2J+mLP?=
 =?us-ascii?Q?ArUyo1Pu+QJ1lXT5Zju5mHkot9f4rKyQBMGgsncqDCa+MjeaAjEueVeCk+eK?=
 =?us-ascii?Q?h7kXoLrFsqryBxFqRmyHXVgwZXLqT/oDjhYLZwGeu/LbNDO/L599qkx8539J?=
 =?us-ascii?Q?GTzYAHY5xkuUPbuRJRPhJnKShIc2/8hZdnEHQoTIVKtycdtmi8WXEJZ5+GgF?=
 =?us-ascii?Q?S7VLE8xZIdgll+J6+J/woprr7+OkYZTuB28yyggaaAFW3Ar+ZEetsMzeRnhZ?=
 =?us-ascii?Q?m5zsZ3aURGNAek2MC9lwZm/M/rFeCx3HCel+dRdKTzCPK6Q+JGHuWyyj63kB?=
 =?us-ascii?Q?mDbX42ftQIxlIpqFkRqlwOG48M92WvaMgUp1iRIDSE+sSW6+jbnFy8+3Vr0E?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fdbAPRH0KGywOIe+UIk9sLrt0jy+JeGs0WYvyTWuzT0NqJacrw5JZag5Wr8NahCEW2d98ah6u48qK2RR4E/YUkVSp9B8er2FHE6Txo3exAMIYAOXj4A9hTO4i1bvMK18Lj2h53H/BybEwk629pvXBzaIcyiL+eAmriGj3mBQtqLBRXWDrK0jLk0nqIYFu1n5aKoNjZ4ySIdHZHQMLrV/g1BZ7fCZL2uOBGHtrP9F6jPfB3ptCsxN1ubGYHCEbXkXFX+5D0YrZ1Fvh0zN5FKtwbY627OHApPPlt4KuA7rlvwl5Si2yesH1BjSgErbvf3zrE5K1ePDZa8rfHq0Fy6+lC+qX+1b7n2rJBZY1BPGj3afwzldQ7KOL7HcZhbQEZFMo7QY4MekZ49AnIALQskcogux7KKPBxczbtOvdU4jHNFHYxZbEmJ/FSX4GoaaemVSHgD2N8PpqZ7edNjOKux3oVp/zcwzvVRpiTiNMRzczltCLaXBhyJ3Wn/w1yysuEagGX3V8jHaKZ2NsqMjC2NZN6hPIRLb+CXPJ/UgO/PP6GvrOwdfePUsCl/XV1e7r84ULtfpUUq4jBLmTzcIpUWd5EYGCmz/iJhwPBSTliwvJ1U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed56eda-7e5e-4f79-fbec-08ddda386a57
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 07:09:59.4827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7YmJc21BgTx2hL26gdTsIDfCNvaOZj7cL4G7QMTlaUAgl1EG0llpjsH6LsLJ53J2r4smslFGNnIZ5s3pU4Xk28+m5uxZsvCqzarek+tK2dc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4413
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508130068
X-Authority-Analysis: v=2.4 cv=B/S50PtM c=1 sm=1 tr=0 ts=689c3a51 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=Voe9yz9E1jMNdyWnBJsA:9 a=CjuIK1q_8ugA:10
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: 9wnI6bdV9QAKXir_L4B3eIkkF9bUY14p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA2OCBTYWx0ZWRfXzVTM6bRi1yPm
 EInqgv1jSXOaBthH7NB3gWRFLye6scGBIIv6rn8n6xGnf5PIGYQhELNuZPz7DKSHyD0om2S5WcO
 Tmm2iVVkDaxqCR+n+MozDyipjW5VVDog7OLK5QlBiwohGmaVXyYems6jKEWJAoq+/GUw0yE8ktO
 0WjHdE1zufgtvJWUq+OdZpBeDndk4zg52e55+PX0LiKeW/A2MFZEX3X4sorjCyixu+/LMfpGie7
 yjFlHT0TEPTSFefQlx9uS7Tn49Y9rTiyuNWiEigP5PiY2mjGRZ3FOk8p6i1ETHMfhJAUI9rfbfN
 hMTtXSBTKbCjgmJgKCc9xljR/oLQ67oR/yzJGiyd+0KrB3CXwDuWSuoBLS87bbGJt7XttrOkoOp
 rDVwoGeKYy3zXCet9fCWGy1hsTDdIesKxP2bIBNxbdI/p9reedDaLMgYen8BpXTVGiO2w67M
X-Proofpoint-GUID: 9wnI6bdV9QAKXir_L4B3eIkkF9bUY14p

On Tue, Aug 12, 2025 at 12:39:13PM +0200, Peter Zijlstra wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> The recently fixed reference count leaks could have been detected by using
> refcount_t and refcount_t would have mitigated the potential overflow at
> least.
>
> Now that the code is properly structured, convert the mmap() related
> mmap_count variants over to refcount_t.
>
> No functional change intended.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

All LGTM, checked the mmap test passes and no splat, the atomic_inc() ->
atomic_set() on &rb->mmap_count (which here becomes refcount_set()) sorted
that out.

This is a nice fix up as is the rest of the series, kudos to tglx and
additionally you Peter for adding further nice changes + fixing up the bit
we missed.

This is a _massive_ improvement :)

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> Link: https://lkml.kernel.org/r/20250811070620.716309215@linutronix.de
> ---
>  include/linux/perf_event.h  |    2 +-
>  kernel/events/core.c        |   40 ++++++++++++++++++++--------------------
>  kernel/events/internal.h    |    4 ++--
>  kernel/events/ring_buffer.c |    2 +-
>  4 files changed, 24 insertions(+), 24 deletions(-)
>
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -859,7 +859,7 @@ struct perf_event {
>
>  	/* mmap bits */
>  	struct mutex			mmap_mutex;
> -	atomic_t			mmap_count;
> +	refcount_t			mmap_count;
>
>  	struct perf_buffer		*rb;
>  	struct list_head		rb_entry;
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3968,7 +3968,7 @@ static noinline int visit_groups_merge(s
>   */
>  static inline bool event_update_userpage(struct perf_event *event)
>  {
> -	if (likely(!atomic_read(&event->mmap_count)))
> +	if (likely(!refcount_read(&event->mmap_count)))
>  		return false;
>
>  	perf_event_update_time(event);
> @@ -6704,11 +6704,11 @@ static void perf_mmap_open(struct vm_are
>  	struct perf_event *event = vma->vm_file->private_data;
>  	mapped_f mapped = get_mapped(event, event_mapped);
>
> -	atomic_inc(&event->mmap_count);
> -	atomic_inc(&event->rb->mmap_count);
> +	refcount_inc(&event->mmap_count);
> +	refcount_inc(&event->rb->mmap_count);
>
>  	if (vma->vm_pgoff)
> -		atomic_inc(&event->rb->aux_mmap_count);
> +		refcount_inc(&event->rb->aux_mmap_count);
>
>  	if (mapped)
>  		mapped(event, vma->vm_mm);
> @@ -6743,7 +6743,7 @@ static void perf_mmap_close(struct vm_ar
>  	 * to avoid complications.
>  	 */
>  	if (rb_has_aux(rb) && vma->vm_pgoff == rb->aux_pgoff &&
> -	    atomic_dec_and_mutex_lock(&rb->aux_mmap_count, &rb->aux_mutex)) {
> +	    refcount_dec_and_mutex_lock(&rb->aux_mmap_count, &rb->aux_mutex)) {
>  		/*
>  		 * Stop all AUX events that are writing to this buffer,
>  		 * so that we can free its AUX pages and corresponding PMU
> @@ -6763,10 +6763,10 @@ static void perf_mmap_close(struct vm_ar
>  		mutex_unlock(&rb->aux_mutex);
>  	}
>
> -	if (atomic_dec_and_test(&rb->mmap_count))
> +	if (refcount_dec_and_test(&rb->mmap_count))
>  		detach_rest = true;
>
> -	if (!atomic_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
> +	if (!refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
>  		goto out_put;
>
>  	ring_buffer_attach(event, NULL);
> @@ -6992,19 +6992,19 @@ static int perf_mmap_rb(struct vm_area_s
>  		if (data_page_nr(event->rb) != nr_pages)
>  			return -EINVAL;
>
> -		if (atomic_inc_not_zero(&event->rb->mmap_count)) {
> +		if (refcount_inc_not_zero(&event->rb->mmap_count)) {
>  			/*
>  			 * Success -- managed to mmap() the same buffer
>  			 * multiple times.
>  			 */
>  			perf_mmap_account(vma, user_extra, extra);
> -			atomic_inc(&event->mmap_count);
> +			refcount_inc(&event->mmap_count);
>  			return 0;
>  		}
>
>  		/*
>  		 * Raced against perf_mmap_close()'s
> -		 * atomic_dec_and_mutex_lock() remove the
> +		 * refcount_dec_and_mutex_lock() remove the
>  		 * event and continue as if !event->rb
>  		 */
>  		ring_buffer_attach(event, NULL);
> @@ -7023,7 +7023,7 @@ static int perf_mmap_rb(struct vm_area_s
>  	if (!rb)
>  		return -ENOMEM;
>
> -	atomic_set(&rb->mmap_count, 1);
> +	refcount_set(&rb->mmap_count, 1);
>  	rb->mmap_user = get_current_user();
>  	rb->mmap_locked = extra;
>
> @@ -7034,7 +7034,7 @@ static int perf_mmap_rb(struct vm_area_s
>  	perf_event_update_userpage(event);
>
>  	perf_mmap_account(vma, user_extra, extra);
> -	atomic_set(&event->mmap_count, 1);
> +	refcount_set(&event->mmap_count, 1);
>
>  	return 0;
>  }
> @@ -7081,15 +7081,15 @@ static int perf_mmap_aux(struct vm_area_
>  	if (!is_power_of_2(nr_pages))
>  		return -EINVAL;
>
> -	if (!atomic_inc_not_zero(&rb->mmap_count))
> +	if (!refcount_inc_not_zero(&rb->mmap_count))
>  		return -EINVAL;
>
>  	if (rb_has_aux(rb)) {
> -		atomic_inc(&rb->aux_mmap_count);
> +		refcount_inc(&rb->aux_mmap_count);
>
>  	} else {
>  		if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
> -			atomic_dec(&rb->mmap_count);
> +			refcount_dec(&rb->mmap_count);
>  			return -EPERM;
>  		}
>
> @@ -7101,16 +7101,16 @@ static int perf_mmap_aux(struct vm_area_
>  		ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
>  				   event->attr.aux_watermark, rb_flags);
>  		if (ret) {
> -			atomic_dec(&rb->mmap_count);
> +			refcount_dec(&rb->mmap_count);
>  			return ret;
>  		}
>
> -		atomic_set(&rb->aux_mmap_count, 1);
> +		refcount_set(&rb->aux_mmap_count, 1);
>  		rb->aux_mmap_locked = extra;
>  	}
>
>  	perf_mmap_account(vma, user_extra, extra);
> -	atomic_inc(&event->mmap_count);
> +	refcount_inc(&event->mmap_count);
>
>  	return 0;
>  }
> @@ -13257,7 +13257,7 @@ perf_event_set_output(struct perf_event
>  	mutex_lock_double(&event->mmap_mutex, &output_event->mmap_mutex);
>  set:
>  	/* Can't redirect output if we've got an active mmap() */
> -	if (atomic_read(&event->mmap_count))
> +	if (refcount_read(&event->mmap_count))
>  		goto unlock;
>
>  	if (output_event) {
> @@ -13270,7 +13270,7 @@ perf_event_set_output(struct perf_event
>  			goto unlock;
>
>  		/* did we race against perf_mmap_close() */
> -		if (!atomic_read(&rb->mmap_count)) {
> +		if (!refcount_read(&rb->mmap_count)) {
>  			ring_buffer_put(rb);
>  			goto unlock;
>  		}
> --- a/kernel/events/internal.h
> +++ b/kernel/events/internal.h
> @@ -35,7 +35,7 @@ struct perf_buffer {
>  	spinlock_t			event_lock;
>  	struct list_head		event_list;
>
> -	atomic_t			mmap_count;
> +	refcount_t			mmap_count;
>  	unsigned long			mmap_locked;
>  	struct user_struct		*mmap_user;
>
> @@ -47,7 +47,7 @@ struct perf_buffer {
>  	unsigned long			aux_pgoff;
>  	int				aux_nr_pages;
>  	int				aux_overwrite;
> -	atomic_t			aux_mmap_count;
> +	refcount_t			aux_mmap_count;
>  	unsigned long			aux_mmap_locked;
>  	void				(*free_aux)(void *);
>  	refcount_t			aux_refcount;
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -400,7 +400,7 @@ void *perf_aux_output_begin(struct perf_
>  	 * the same order, see perf_mmap_close. Otherwise we end up freeing
>  	 * aux pages in this path, which is a bug, because in_atomic().
>  	 */
> -	if (!atomic_read(&rb->aux_mmap_count))
> +	if (!refcount_read(&rb->aux_mmap_count))
>  		goto err;
>
>  	if (!refcount_inc_not_zero(&rb->aux_refcount))
>
>

