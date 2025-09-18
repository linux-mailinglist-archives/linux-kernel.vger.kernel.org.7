Return-Path: <linux-kernel+bounces-757633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57676B1C485
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1204C624D99
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF75253F11;
	Wed,  6 Aug 2025 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kge95CBC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J/T+1SZ8"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB4421C167
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 10:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754477189; cv=fail; b=przEIjavwQhmwZRk99zQdBqpmtC5IEn/5YURBvDEXffe0mbqQXmsGqWVW3SvYDAR5HAraPrYqA/S7b3cmGnqkt5yZaoe2uRd/wRjVzQvJ173gFzl+SP1XXVQVGeuTO8Xmb94P+FO/1WHjuvhXCBr6WFTo/uPLmALGhnR6eKHZEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754477189; c=relaxed/simple;
	bh=MeZEWxwZPytE6sOtWOf4G9cHhRDyjssQtDmXRPNkC6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ew/df/2msZUyVLGn6y9H9B+6nFoMdcjesKIJcFeNec95OLDzMvKEEFDAYUjMvylC6IgFkfWXJoYrXlQDsbHoiHX0TN1d/7L9auF1ZoSIb8sJkI5yaLE/P4vYaGgs34jkyHwd+Hp3RH5B4PlyQCayWtbQZoRDevG1q5jSOV7zCds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kge95CBC; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J/T+1SZ8 reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5768RYih002480;
	Wed, 6 Aug 2025 10:45:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=MeZEWxwZPytE6sOtWOf4G9cHhRDyjssQtDmXRPNkC6c=; b=
	kge95CBCbmgzByimjxjA0YOBNBF9m3jBjBRQJkePqYotQIhI7tD9rk7/GyiUUbcr
	NhnRLgKvRxEYURooVWVIe8Gh2erpNN13PDo3LWQOJ/AF3UdOY8+ZvSOjVYcxEHvr
	11aU6IF31vHx161jT5Q6jpIG2n7+alhR7rOJ0Ui38kJC6Ea8n0vaamL65vo5R8bq
	4oN85zS/PjZwrnRTjAUIHofsjdlPurxJuqD6W/xF1idZ1/vxPa6b0rywkgQgLRO8
	tlDTTln7aEOC/dPqCNnzAn+IcJYRxx3lRDNHq4Oh987xN+ByvrnXLECqGmtPM4Dx
	YbbiwH093TOdacBNMD2jig==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvjsb0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 10:45:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 576AESC4009726;
	Wed, 6 Aug 2025 10:45:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwkunvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 10:45:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onPS7ZPzPRjJjVj+rK3CjtiDQrxFlgHasv90ahLxP5DBF6UcMXj00KZAn8dJsk8vWJYlPeN1f8Ei4zvPZPIUPUWxEox4T5rVEOez8a4ZlOTkaHYdk/sreM2x79rifrjaOsbwMGM3bKsnrG/TUnTjcuT9aIxALY4ueE6zzJFDBZzkKWfY6t2FWGT32Bz9e8XV3jY2Lgdb6T27rpAscFQf3716E2fBdba/XeqTnDq3pBi2nZ/DiytzS6oJfgzyP/k+2NQdfYLWQgSYGD2shqIo0VxX9VrCFFKsQHeahlV8yonMHpLfyDq1xTXZezG3OEgCQ0HzfZUk5GPPfunXq2F0YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ik4gPyA0vgdMGy7LiC3ARhO7KkuDZbFv3DVHCst7AsU=;
 b=ZhEAIbc3TY5VS69e7lxmO4qvVuSCazH99snw2hdC+T5LyBaDi868WgmKTg0POos1+5K2auYEJTbir71qCXB0J9IvXLYGfLAV5Elb9wYMGHB5TyF8ePBNgoebS4p9+KwzeYAy3kVq2AWubf+8XaNASEvRcJ+9B7co4yboihLHHHNntSx4+lG+ibn4XtzfZzQ0TEWthCIfxkc4c+eOo4M9RILzpoHSZeJ+LBoxaCrhapGom5+XQUg9zcJTYjhICfpIPgVy+MAmd1Cngx63Ihj0FbMdH188dN7auvcDk1qYuW0yjjuPmf69l0EcbHW5eFzoVBDYf630QYrmBgJbm5js5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ik4gPyA0vgdMGy7LiC3ARhO7KkuDZbFv3DVHCst7AsU=;
 b=J/T+1SZ8K5cgEbQ5J9bhgg+zP58PZyh4rV8pIdaaiv/7DtCNGuEWI4qx3s43cYP/OFBiVauiI9iPlUcaTT7jB5rp/yniAJyuu25oMEK3mGY5UYwfo8GAL4mwxkIts55Kq5UpGearGZGIn3owCGsaL1Ffu8xbg9l5AMT1dHXO3/4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB6318.namprd10.prod.outlook.com (2603:10b6:806:251::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Wed, 6 Aug
 2025 10:45:54 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 10:45:54 +0000
Date: Wed, 6 Aug 2025 11:45:49 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        ryan.roberts@arm.com, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
        Liam.Howlett@oracle.com, vbabka@suse.cz, jannh@google.com,
        anshuman.khandual@arm.com, peterx@redhat.com, joey.gouly@arm.com,
        ioworker0@gmail.com, baohua@kernel.org, kevin.brodsky@arm.com,
        quic_zhenhuah@quicinc.com, christophe.leroy@csgroup.eu,
        yangyicong@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        hughd@google.com, yang@os.amperecomputing.com, ziy@nvidia.com
Subject: Re: [PATCH v5 6/7] mm: Optimize mprotect() by PTE batching
Message-ID: <7104783a-a6c0-4acd-8a50-50208846d7e5@lucifer.local>
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-7-dev.jain@arm.com>
 <7567c594-7588-49e0-8b09-2a591181b24d@redhat.com>
 <9552ddff-d778-4934-9349-37c7237cbb78@lucifer.local>
 <54ee1971-d91a-4fe6-90b8-16212c8568d1@redhat.com>
 <0d52d680-f3d3-454f-8c12-602f650469ab@arm.com>
 <9cbe9c6a-0013-4239-9347-bf5d43021fe3@lucifer.local>
 <e3d13396-8408-49c0-9ec9-1b02790959aa@redhat.com>
 <2d0d58a4-bd27-41ac-9b25-1cd989c02383@arm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d0d58a4-bd27-41ac-9b25-1cd989c02383@arm.com>
X-ClientProxiedBy: FR4P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 38625d5f-64cc-4b7b-d066-08ddd4d66b06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?Af+x9zCcYbnuJ6s/u3SRC6yZN9C6Tz//S4UPGpY5tNBO/M4vzK5gObtTyM?=
 =?iso-8859-1?Q?qikd/PNnjM0YcwWugZ/3dVS/K7Fg3xREBObVEeRSO2y5AZzXt/LX9KqH+i?=
 =?iso-8859-1?Q?M8G5cdufIcG/BJigVHzyr/x2xPhcua4ko4xwSGqastqj/ooaMcVy/pR7SZ?=
 =?iso-8859-1?Q?BHhsLXdpkQoqFExkeAGs4Y95qcUSazP1jALohZ6n/YbmGVwFSdL4qsq5LT?=
 =?iso-8859-1?Q?bXblfUjbXpXenUAob4QgtKspMvd87Mj4SdpgnPGtWvqCEingbN0lTDBvQN?=
 =?iso-8859-1?Q?48mPK98wmVXjikLqlfcm8It/gxugqWqwGDkKBUk6zm74Dt8VEL7GbiKpqp?=
 =?iso-8859-1?Q?jB/doa2i1Kq9hCLFk95JPijreKshnE5y5VQ0aTHQ/b6Y9H484ropThJKpI?=
 =?iso-8859-1?Q?Txz/1DzPBNhHrbuVYIwqMINvOqcXRLt/hRikfimSWIc4kgoO3h5FTsrIgN?=
 =?iso-8859-1?Q?C/Qb6foDdM48XfBD03cmm1i/3b+K2TJyeQZOVD2xbMJvx3ri3k46Z83mPQ?=
 =?iso-8859-1?Q?L9piFxsDHQ997pOGWjaHXMG1p2UlgSMZqGA87YYn9m6lkJnfqNRwcAkviS?=
 =?iso-8859-1?Q?C/iqaLSYRjHOxjjFJLV4qWIFoglLzBm4dPpVwPGwu0/2QioxKaUBG+b7fa?=
 =?iso-8859-1?Q?WQ2IMBWtSLnceti9oufFDRUfD6pbcVGuBOaRBvQM4z46WYMGrDCN+KuIFc?=
 =?iso-8859-1?Q?womUhH4lJ1qtoTv028WFG85yH0P2BKrnL+lTvc03R1bhsi/OQD97M3eYf3?=
 =?iso-8859-1?Q?oYQY9CmgtQ8fuTPESzmcpTBbh5TSQsBbJ980fKkfFJuXgKIiUpPK7kz0BQ?=
 =?iso-8859-1?Q?XiYSyjh1u3vTVy1qFK9XE8mqU0tBZny36CRyPs6HEY5V4owQokP+M7mtJZ?=
 =?iso-8859-1?Q?4VrlDJtn2rV4HjT5oZU0tiXp1cI4g7BmG2Gw1GTUgEHEFV6aeviSMbCuvf?=
 =?iso-8859-1?Q?vjqrN59CAOE6/aPsIhAMcG+2KkX2wdU1LB982UB60y5GRdclFV3Yz4PZXP?=
 =?iso-8859-1?Q?qI+BGSDPInrHJ+w3ilL51bOkwuIqyTC79fXXMeXiR4NAnCzH++OYQYWFgR?=
 =?iso-8859-1?Q?NqzLIAzpqgOpwk8Tm3jWPWXsu4Qc8xi9yJAIzy+zOnRDJzXG+qq2QvFT77?=
 =?iso-8859-1?Q?4IOkA6dBYq5/kDvUfZ5vMFyh2aN1Dbi0CMNfTj1Ap9De6mdEtndXjN9TmI?=
 =?iso-8859-1?Q?Vm4Dj41xKE3uY2vsXYU/HcvEcC4ljE3v420RKIUyBkK+8J8fhPQ5v8SCf6?=
 =?iso-8859-1?Q?EALwoJTo2rl8A9NFQ8P2DKVTIgyaXVfDeWJ0jTliNSUz8FZZZPhWnO5u/s?=
 =?iso-8859-1?Q?El0v0LtK7TRrfcl9ByNhgvucHrFGSHPF3SFI+FOkoz9USYIaxj87eg8yAT?=
 =?iso-8859-1?Q?7Yksqrl4TY/AVP4Azale2DxVYBKp1CeyyyIGVrFLaF6eQC06HwXxcv2h7i?=
 =?iso-8859-1?Q?XOYXF1HZYftbaLADgUQX2YspBpNTROxaUG3k2cKQpNheDzgHfq7jeTLypm?=
 =?iso-8859-1?Q?A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?+eR0G4tEx11qQsPl4pj/AP++quozZOsc3GcRA14SpA2HtJr3BKCUFhzV6W?=
 =?iso-8859-1?Q?0i6waO3cQ0dnD63Osng/S6fsuj+ZU0+chPHN3fjgx5uYClxT7BvzsVGy6G?=
 =?iso-8859-1?Q?hB+cXbupHMEuSAhI/mFKwYADwLbFHiS3z+IjBOV0nGcN9c5FuVd5CNzYZF?=
 =?iso-8859-1?Q?seDqNEQLEmjlwEbAwcUMpTPBmSIUla7dmWcc3edBEBJoUUwbmumbgoNHpS?=
 =?iso-8859-1?Q?0eH7zGqxvUx3qKuqbjpC/xKAqzr6o/nwrcOfe/a1NOMXa1fwbXkq/DNLpr?=
 =?iso-8859-1?Q?hzyhyInwHuLN6ErcCk2kvlQDo9Y2zd9jyAm49wPQ0Mn9vZP2xYdbn5WFN2?=
 =?iso-8859-1?Q?6VO+4qQD6p2gyU5R5M05h1T+92F9chqet6xzIutH/SLtB6vx5fsfVmbHZl?=
 =?iso-8859-1?Q?0vJS/Ohd+4i+O2UmKOD07rdoq41XZDoXvWEQEJgrI5HWv3WNQeyUSkZGHo?=
 =?iso-8859-1?Q?TtA5ZKbc3i62KQNK+11pT4GdS5Sm1Oi1hEwHIzJ7lF6xn68R2fo94D+QXS?=
 =?iso-8859-1?Q?uEiZsuIX9ybemPbHOU8c2NUYY/B9fL9aMnAh8NO1koLsLXzi56jhX0S4cS?=
 =?iso-8859-1?Q?r2L2tBu1xjWoBSbqBOeaXZmuzBv8/sz6mcpXek1bxuI/KMQioL4eimjHkT?=
 =?iso-8859-1?Q?4JzfVHvKAlnNwYukUcOBbziRnsqwblqkHck1mRSTPGlRI4Y44JzeueqB+O?=
 =?iso-8859-1?Q?4tPku6xavZfRiE0sxlwo2jebFsQIybZBZ73naZfBOqu4KvukONrvdrmKeD?=
 =?iso-8859-1?Q?8H+oKuVJ2SMnJlOIPGCUC7euk43PXQiNGNvWFspEciv7XRjoLwrRA1f4y2?=
 =?iso-8859-1?Q?nnQl4ntkcmIw+jHOYR0yznJMvQV9HzeG4fUURhrKkzq4cn1pJBVHHhUQHs?=
 =?iso-8859-1?Q?2XUlbdS7ODbuEctckIsXpGzstZZdGhq+iXFH8xWUNT9naAgVg9ipGq4OV5?=
 =?iso-8859-1?Q?X+9fxxQ7P2KzVfbp+p22yn/NjqNKijy2oPIeEA4G44DObpi8oSRCvbE/XE?=
 =?iso-8859-1?Q?S+4mZWzjlHiCJ+FF2fZJv+nLI2MJe/C5yv1Rus5lMmXxtgwPuGrraTUGtf?=
 =?iso-8859-1?Q?JSYHTR/PbHE8habuetiH+1mimWU2o3CPPOrW1mP078ktKHkzsCNipqxA19?=
 =?iso-8859-1?Q?eYuWS1OF3wCQPYg2Cud/YatENKWlGY0v7jUVGgCzoht6FnOkP8ggjN+W3i?=
 =?iso-8859-1?Q?Trnsw3SS/yAtUV9lUVXIrERntgqiOdk+EK5yYt9HgfeOpqLOWVscbDhJlv?=
 =?iso-8859-1?Q?jCmGPpNI94DA2JGOlvmqs3IAr8jnHbYx5w6S2tRXwaiXyWWsBkK7KK+hz9?=
 =?iso-8859-1?Q?UVtWcA6vXVtIB1tzO3QAzNNu9MgpfS+bVn9Lb4PNC/EY2dMvusYpnFSxs4?=
 =?iso-8859-1?Q?adYToQzj+I8vPSPvUaL+/haGQFkDeLg51GroZ0l60/9J3Cp7qzvmKoy6bd?=
 =?iso-8859-1?Q?i6X+ahHzdAG+TmPJsHRS1VEJdMvupQmvRPiRWOhKKLB7eBitbRBjc9bWzp?=
 =?iso-8859-1?Q?mvkA+IAsUvEahfnPzsOoDdaCkd8e3P8xGXHAwAYrHa3ej9Jx3yK8RZd14V?=
 =?iso-8859-1?Q?9ieHu6fZLPVnJfdAKyedvn+OAf4K3bpzL9MiW1wdXed9EFjsxgzbfSaMC9?=
 =?iso-8859-1?Q?rFoLkib175UJhc3vlYcsPLPSWJdCIyLvtb/XBA8k/1hjexs6NdKXihug?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NZwFWm5drGBeRWOYFQ6nNvi3sTyVYYOxlEHw6lBueJtv8BE+GCHrdZ38Hr3VuFIyDUmcx0V8fNkdY40EUTRIVCKqmTxd2iWPokBZ9nmDNADWTd2juw+/Ii1+6vG+LwhuHMywITp9KDeOcKTMGVG+R5iomEhGEdNlqLRIEP4xSRDIMLTRCWN/e2fjbMAV/NMG9T0m7Yh+QhsEtMUtSC4apppaJkn3LxWk5HfuojN9IyIk9tlHsyI3RnWrBOflavtRzCukFAe1wM7zezxEMN2oi6GdljHsr918i9UMk7lwkQR2vwM385UdmcqTozAGBibCLwuLtveD4+fzp8fVx+Iw8rK1ANZU3C86LYKILPSAzDI3T6BgatSbmThYw5IbWzAlmeMCpVY96NA4QNL76oifT9nN1H+dYCkUaji7+LKKVON92uLCXOVCGHYURhQmuexNv/caCcBzZla1h1LON2Hd2MV4KjbRcP04N8juInMfjKHt7Ra0nPc1/fmYxc5zp249jkPA4jRgA0FaPLjqa0Dwtk+TJL8PiZujeHfy6v9PSWylkmjsdtb8Ok9BLle5UaO/UkPQNPPnHCWag5CSTsGgS5BGDo+HrYD5lvxY1YmMKeE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38625d5f-64cc-4b7b-d066-08ddd4d66b06
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 10:45:54.1911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6yauGST+3k+htBYwAUWNhvyL82sKWtAaiFLmjzvXrWNwoD16vP8nHpQh0/J/p7SMAoSsO8vi2+nevblEniSLkuNPJmswFP+RMiYRp0pFYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508060067
X-Proofpoint-ORIG-GUID: 6XW8m4vbfZHp-TfwATRyWNWWklqR2lxB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA2NyBTYWx0ZWRfXxi0garxKVqKT
 jQrC7Rvg1/TKcfPBX6FE4Gmi1/Y7vOqP82neUA88vHTvBFgznGsCyt8a73/SCnSk862rn3b1y/Q
 YenJQTUcKXsBqMXEs3HhS4Spkq2/bu6Em7Oq6KbY4mNJ0MiOL2/McsBM+hdP6h5tdvID9MdTu23
 U7Ei2gk+QWt4uQ0ewrBQzJtO/LZJePPlIhUSGPoPe7tsJ0rVhCygK/oPTp/JlKijpNh4axkqYsg
 uYns0UcQoOw55HWsFQSuy9JSGsl+SnVLjeNvmWCsoWY6MchCokqlJj1rHrOF5V7X2tsjL0tI4s1
 oWQUezx3/XAcX8iy57VQXCCS/f2Dd2/LnrhdSz/INsuCxzEPdll1A/5g41kMejpJ/T3iHdFajDl
 hoqp0t67Fga3UgzlD5+0wkltwVjDZH5IBLcVlFZULL973+WWe7QsEu655bM7wszvOLIVJDx6
X-Authority-Analysis: v=2.4 cv=dobbC0g4 c=1 sm=1 tr=0 ts=68933265 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=mEP-drfSLmSOQCV8LAYA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: 6XW8m4vbfZHp-TfwATRyWNWWklqR2lxB

On Wed, Aug 06, 2025 at 03:50:21PM +0530, Dev Jain wrote:
>
> On 06/08/25 3:41 pm, David Hildenbrand wrote:
> > On 06.08.25 11:50, Lorenzo Stoakes wrote:
> > > On Wed, Aug 06, 2025 at 03:07:49PM +0530, Dev Jain wrote:
> > > > > >
> > > > > > You mean in _this_ PTE of the batch right? As we're invoking these
> > > > > > on each part
> > > > > > of the PTE table.
> > > > > >
> > > > > > I mean I guess we can simply do:
> > > > > >
> > > > > > �����struct page *first_page = pte_page(ptent);
> > > > > >
> > > > > > Right?
> > > > >
> > > > > Yes, but we should forward the result from vm_normal_page(),
> > > > > which does
> > > > > exactly that for you, and increment the page accordingly as required,
> > > > > just like with the pte we are processing.
> > > >
> > > > Makes sense, so I guess I will have to change the signature of
> > > > prot_numa_skip()
> > > >
> > > > to pass a double ptr to a page instead of folio and derive the
> > > > folio in the
> > > > caller,
> > > >
> > > > and pass down both the folio and the page to
> > > > set_write_prot_commit_flush_ptes.
> > >
> > > I already don't love how we psas the folio back from there for very
> > > dubious
> > > benefit. I really hate the idea of having a struct **page parameter...
> > >
> > > I wonder if we should just have a quick fixup for hotfix, and refine
> > > this more
> > > later?
> >
> > This is not an issue in any released kernel, so we can do this properly.
> >
> > We should just remove that nested vm_normal_folio().
> >
> > Untested, but should give an idea what we can do.
>
> This puts the overhead of vm_normal_folio() unconditionally into the
> pte_present path.
>
> Although I am guessing that is already happening assuming prot_numa case is
> not the
>
> hot path. This is fine by me. So I guess I shouldn't have done that "reuse
> the folio
>
> from prot_numa case if possible" thingy at all :)

Don't worry it was a reasonable suggestion at the time, I think let's just
make our lives easier here :)

Can you check David's patch and make sure it's ok? It looks reasonable to
me (other than the eobvious typo I pointed out).

