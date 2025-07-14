Return-Path: <linux-kernel+bounces-730359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9BCB04394
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2682E3AB440
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3945226280A;
	Mon, 14 Jul 2025 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MvvmiO9V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Jvyq16c2"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA41B25BF00
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506344; cv=fail; b=eJBMuFPjnWlGLD4YJINemzanzcZ/PxoCln8TW0Nt1QncHAZDTFTYOgCIRWjm5wtZT3KPPTfE/od3YL8VpK9ApOqrVPF+UBdAGTX2FFXV/A8yLx9o1K3J68DaIPxOHvQNijiMqxaUQHDs7NTol61h9yms5HfxmuOiKuX1no+pK98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506344; c=relaxed/simple;
	bh=0ULGMMfSKwKXCpymAiBYpNqDbvpVvKyxQxscMsaL+A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s/vHw/Y/GSfA6AsArfZ0+NLpCJ1ryfXQ/3CX1/2G5w5KBQkOvAIOIGT2V48863gbLGgrjYJxHRzNTy7xM9/BoADWegvQ34l0jGNNbIQfWSH+KAKk7sxUkpq4Cz6rOj5t0Ix7bY22LMCSvZLhCgIkVxwgRT4+QH6EhTK9gUlj1xA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MvvmiO9V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Jvyq16c2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z8pt018984;
	Mon, 14 Jul 2025 15:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=RBUjgbhQb/VtbY1faH
	N3QvGvB5abQDTZVaB+9OQOTHE=; b=MvvmiO9VZbWZ26g0Zn1MiwSi5EuvW3zaYy
	yN+ebiTeinGzLnFNm81Fxf0cwadL+wIspGKeWXF/5cqkKkQ7PvOLdfqVNy0VoG8c
	FZeW9JCn8RB0C8GAoDGoBkowx2PofmQaBBJrMhCXRKPKnRO52sal85jowb2uag7R
	beJHgMuXckL0s8sOFlQDKjNGCSBG3LOlwKjQVj24/wqLCTQqLukESS/YSwa9rT2u
	ptFtaQ0uJyIGX2bY0HmCtVYlddYV4Ywl8C8F1DrHysMo5hcrpF8RPEN+whSOg/+i
	zEJeH8S/iMBKSN2wvkyuL881jtIu1+8SnGsa5eu28LilETa7Q5eg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ufnqn858-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:18:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EDl93G029769;
	Mon, 14 Jul 2025 15:18:47 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010058.outbound.protection.outlook.com [52.101.193.58])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58degb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:18:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dL9Ra7uOqb6/Tc42r8c79VMqSf/1T1tGiI6QJJAmCclr2X8jLpTzCnQVgSjA+A1q/N2VZUfcAJmJ73A/2SCwLcYAyBVD1acaMWhDKZYZt+iK92uDYehnzRBYjCUoaRmY4ssuRhTR4X6Ja2qiQhuMhk7jNqh8UywxV19zdfoVMWOlShIrun2eEiJpMybvpMYihW78IWcy81vd8jUyO1FFp9ZwUHl01frGg38aN3TpB+KCmkpVAWrxE8Yy5m33gH2y4X1EX9dK+9vP9n6CMmVPcj9wXueWPEqHozaJhyxqG+uN0rkl0xLLpBoCCSfdyY3Ngn3HAkJYfQgzDCX+F+XMKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBUjgbhQb/VtbY1faHN3QvGvB5abQDTZVaB+9OQOTHE=;
 b=YayBNmOgfPeyLVNDbv5E6ooFhBNEikWU/YSdz7M59HD298d2mkbPT0Kwur2djA8/x9Ref+UVvmIS9+zaoMkyEvdmjx7K6lMBeYa0F0qI9nD6DMz/I9zBgN8VRil2nqC1Gp41o0HYfjpQO1zc3bu7TEfF+9gXgDIU7Utqm/xOa0T5ADxONqCJzke0TeEjmfH2fYMuaD+ZBfdTjPA5yHs3YdoA8ioaSOPh/HFhjGcAuOmTntMtqLlKh/utZWRlSzzmtuShcO9xCj1AdVKndVXDz9McMfYP8AxX/RNKtdCdfvxYroC3wKcQlcyOHx8YWtAXGD5xS/rrfRLgbhzy7LoyiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBUjgbhQb/VtbY1faHN3QvGvB5abQDTZVaB+9OQOTHE=;
 b=Jvyq16c2aPnNPu6xClNAe4oRBQ74RRFY115FoXbQaNYf3osgdORR467lPTeLWL/8rUv8eQdCsfprgMBjM7rbAPffWD+UzYdbvjwdz3HoAF7QZJ9ullFnKrEhuEytd1muK9mR3+rjZGKm4eamUKKWJA0RyLhz7rfy7z/k7jwdBgw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA2PR10MB4731.namprd10.prod.outlook.com (2603:10b6:806:11e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 15:18:44 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 15:18:43 +0000
Date: Mon, 14 Jul 2025 16:18:40 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH 2/5] mm/mseal: move madvise() logic to mm/madvise.c
Message-ID: <c57a0048-17dd-445b-8d92-4c8cc6f47d17@lucifer.local>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <5d932ec1f9d0ea115aac65067e4cb8241a06e791.1752497324.git.lorenzo.stoakes@oracle.com>
 <5e21df9f-7f75-412b-a173-fe6da49952e5@redhat.com>
 <b9bb8416-24a0-4bd2-97c1-055460cece23@lucifer.local>
 <0925c64b-c721-4dc5-913a-c43a94dc64a3@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0925c64b-c721-4dc5-913a-c43a94dc64a3@redhat.com>
X-ClientProxiedBy: LO4P265CA0096.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA2PR10MB4731:EE_
X-MS-Office365-Filtering-Correlation-Id: 75971bf4-4dab-4e38-627a-08ddc2e9b87b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4q6I+PYKUSvfZoo6WI2RyuybX7VVYMMuV+hLgKoJ0ncNUuH4RF9BDa631DJA?=
 =?us-ascii?Q?LR8zJm+1h2dZG3b+4nEhxCwqsIKG4uHQqRbMztU9Lykim/6xi9z8v9rRtJQW?=
 =?us-ascii?Q?uD9SLW0j7fOV6A8NE7jggTvGu51PHGjCd4qre0lmfscgmtoU0vVTMNi/LUuc?=
 =?us-ascii?Q?2WcPvdE4MFFFgcSswFMFLHl3H50sXwGRuw8XfjsrRQB7BLt8bC3OYX570yBQ?=
 =?us-ascii?Q?jHHaiMC7ZaiTdPhb1QmiVJQJHYvEN6djWZDClvg50HKfujbIAClmbBjfykwB?=
 =?us-ascii?Q?Xu5yFkNb9P9hum/5grlpoi3DIix1TAyRn7AYaPNdcISNT/v3zVHBX+bwAQQH?=
 =?us-ascii?Q?0DEPqwuBa+jr878FbPkdUzCBfTobljT3c3HZ+upwfg1b5EGehJmN123KMJeb?=
 =?us-ascii?Q?dzXmE14n2n/rP6Y15gFjWe7Ra5u0okr9MCXeM1athJUIkB4KoYyVNm1YEsyg?=
 =?us-ascii?Q?oBqtQKrd7DqtLtPB9s9vuqISyDFLS7yTQ2MNEcjTzIPe8Kw0rR01/CMK3P9F?=
 =?us-ascii?Q?zT7DYQy4Qa+oD/uRwMYoMevfF+Z6PJvCykV1/SzUd1Yr3S8fOXc4XgAv/6q7?=
 =?us-ascii?Q?Q2AOIySAlWWFifXcJBHVUL18Qk9KTHynsgWMB7iICf8Vf5trA2kHK5lRivIu?=
 =?us-ascii?Q?jgo5zKYOLwq9YUOFmHb5wNB1yutUYe7ZH4ULprV7fo04aiPiwUHS5AT8gSt5?=
 =?us-ascii?Q?cNZtqpbvnHSlf4JBfmALA0OxXCvCAtBP0wfnPGQIU/oOiNkWuoOD1gbJ3Vh6?=
 =?us-ascii?Q?HelUPOSGiQXjVdrxfoQYVx16ezweP8PAQzkgknX50R9TtGygB5wnoqi1Pm8i?=
 =?us-ascii?Q?0kQhYifSL0cO49dcBSSTCR0CX+2bD0VB/5Teem7xk8N2WVeZxUWaSdA/7CED?=
 =?us-ascii?Q?8zgAjMWbiWS5ft69ybglVt/cZCsGMu7UzcbJpeNrZtHTFnGq85YmDAYaZoaF?=
 =?us-ascii?Q?Dft6P7AOgIjJI8IiBfcxaxLYdlTniJWJ0QqCuTg89e2dZptr6CbIymRCRLUv?=
 =?us-ascii?Q?CpTdMX9BB4GwFUD5r3G68sc2XAkInCJHGZJI+GelEae/Xgf9glo9VjrlvUiA?=
 =?us-ascii?Q?P/v1U7++Z8s9XgCMXV7c0eWSSt8rzfJ2tfCvold0fiLpbjw5URwyLHWLQBOO?=
 =?us-ascii?Q?E0Hv6/kRplgqYizzaNVZNzAbfMJ7CnYdIveXAwjFZam7zJaEkJzJjZRM0zFv?=
 =?us-ascii?Q?cmk1rguLjBGV3jfv606ISiQsG9/v67+4a+qehh3KYrmzeYaB9kdNPyYw70gX?=
 =?us-ascii?Q?gzBuj5q1xxnaGcQlCBkV5ZYUauHmnIS+jDvUov1yPECnXe516TVxmZNgxA9z?=
 =?us-ascii?Q?3zKKP6bCd0W9Nkjv6KdCbWx2znP3CKKZHUsw2ZDLivPvVpQZIAG2T2UskkMP?=
 =?us-ascii?Q?0Dx0SNwI0SETocbNVONyafZ5vR9R8oIQEeFCWn6ZEt6NP0KJiqh+puHQ/EtF?=
 =?us-ascii?Q?nLB1HhbSlG4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xpiuPwSKcUCAtfZ9Hs2mysK+Xu4PxQrKdq2EDAX+nwAF7iw4eXq2IR4mIGmc?=
 =?us-ascii?Q?S4f/Cli9TcgiNaOkvMoOg1LvL6SMwDEvEM9fQtA1l26wcO1d1R4OerdVqh14?=
 =?us-ascii?Q?p95JIMZvHj8eJF67+7C3vFNqoye3Xvd2ULOOXJU8ovSQD83TvnfoD42DTP+w?=
 =?us-ascii?Q?O7A7YVEG41Cln9wJa7AaqT/YR6rky8/PgfrBQgeIz4dquaoZJmslPKIMNEb1?=
 =?us-ascii?Q?V58E6DUfp/WeVxyqwX21yiLSBzDpSCn9gKrnqmFEnT4zDNpWkyt0haI0YTnE?=
 =?us-ascii?Q?3riCBtVR7ndkA8+1OpvKEmnKFd0tSwec71qheCeXCdZjXR4FsVeMYj7M+sBW?=
 =?us-ascii?Q?zQDeftBJ6dzU4MfeLZ/9QSX8/sLw1OhE0DyCg5bwOFnj5qOPs7W3Bad6rbef?=
 =?us-ascii?Q?wLLvXj1eJtCnjEj3wvC50i3JilpZgvI2HzTF53zI7hx6OHC3YDaU7Cz8tGDe?=
 =?us-ascii?Q?plvphXR4OR7hOxZEVXkxJl00OAnInvM+7OmiL6nGTldJpX65xERIovEYc2qc?=
 =?us-ascii?Q?mEcWeEzEkjmtJaD8StBapoO+BULLjz1P6J7NOR6nC6Ptdgsl4qPTlFJmIZ6K?=
 =?us-ascii?Q?fnHgYlaQDdflERp+eg91uL+ANsJaYiHWCQEBoqM6eBU41RNsVSMOyy/osjF3?=
 =?us-ascii?Q?Sb0SqdfGn6Gzmc6tng7qPh/ImpFt2hB3H4Xx2HWgcxKFV+/BeTVOxxOksemQ?=
 =?us-ascii?Q?qS956ubYExbrutZ70r/kRAS6BRjJTDukAHM4F2pHWw6N9afdL52dbseVh5IE?=
 =?us-ascii?Q?fIqdpobqvgaWMxnxHAIsglLsGGpkI5BzMLTjck9BfhgutPFoIm3WXZZ9vgW3?=
 =?us-ascii?Q?deGWhY/Vb3V6IxfG/8LdRnU8sRv2rXl0WLBI1Q2bels4bGc25qbboi7Ua6+o?=
 =?us-ascii?Q?tzzXF9BKTggYyrdYccsFnYTzlSXEV2KOUUIDfMNjvmHsDGW+d++TWPORz6Le?=
 =?us-ascii?Q?fFK6esmNq1KJ3+K1HUnFvYvkLn0WAezQl0XiR5By5njKz7sG3rF4Q+NcAoJ4?=
 =?us-ascii?Q?nSioxzQvrbx+OFpdrfgOOZv72AqcNMKbCss9la3nri5qyiLg+yWVd0cQk06E?=
 =?us-ascii?Q?Nv+VNmj31pzeMuYy8clmYCwaa0DkhCNpJLMEwcXimuMF1gpqkKUsUAqogUAP?=
 =?us-ascii?Q?U+AoxgR7RQWH8AKaaZeRhpxvBeIIi8H/uirR35kIRKnKw3FFrCyvRAW5kwCO?=
 =?us-ascii?Q?DpghZ24eqA+n2R+iH805i2ZpRVA62uxd7+GvV6G3QF5RyimDi4pm0U28pskD?=
 =?us-ascii?Q?6TCNofBC7q7p4Klg5EcwGt6esO8/laY5yx62yMwgD58cniGaHxo4zlR86BJ5?=
 =?us-ascii?Q?04Z6ogGlhGi5/Yf5zOmWhTkyy3GPO4wM3HwAttZOxSu0BcL1Lz8bhH6SC5La?=
 =?us-ascii?Q?pIfIoWLqvRFcLyz1J8Q1sADg2e3Un8glGwTVy5hMjKjtdxDdH8mdiW0ZdJll?=
 =?us-ascii?Q?RZcvPV9Cex6Dm+H0gaMSGeksFSNvI2h9Gn6DHblS4pQG5BhifeaauQ5FQnQ5?=
 =?us-ascii?Q?luyX3LCOrjdoWIZgvpZcHl6Jy7xzxd/MUc/Tz++6isd/Jy6DSG92ostd7yuv?=
 =?us-ascii?Q?qKMzO5XrX0++LFR3cmhUd8+6rSbZY6gM3qrb4dDPqpykIccNLllM/EQ89AiF?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xh6aDFC7osHd5JXYL+NHWlTn1nU9tMXv668uoH48A1oneXMerbKDlyQahRaBRFlSqzDkclH4XoLzRgf+I4lIoPNYUGhrNoxTnEV9Cu84rmX/uWIt9d/N4fEcUzxPeYit4a+ccs/L6DVijjItMFNHYf6LiBhyuJs3DVdsHFs67zGDXGiOdsxlcZ3xfJvOMGjJYskpB7zFD6WTXwYoXA/XRmAyT5O4teo6kZoatWiJFpZi9ySypyVAls+hQOGxbM9t3E+QfkPOqE5HIEeN5SDtLnOXZQb3Nl01CakVuzWDpBEH5iamlmE88Jv8/xFMqNRrJj2ADbGfX/zq/B1oQ3vN4cdEmSJdrlPUab+aXUv41CiiadwOd0rMqyHmdmmiJsTaGf7VMmlAgYUs4mg1iK4T6KSevcXX5/YSvqwTIn7dxYj4tgVtQOgjXIU/XeJXus+wX4IzmQDSmnSYDPViAlc3ZdQzpnbuGdJUuGfIi6xbhqvA+4ydJIpKoCuP/I1XBJcdxGKt5RjpZCF9zhKPuJM2kSbDHN7AQlz5JQPbHioSVTkc6QGZ/zKlfBcicstAjY8Y6XxDAtPHW2QHhSjGqbu9eYpaelZiYrPmG8K9AVWX0+I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75971bf4-4dab-4e38-627a-08ddc2e9b87b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:18:43.5380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RdBbdtEzK7EOTOtk+GFoIDqHZmdK8utNfwgwkqN8Wk21aMzTptrLtfP8HNF4J68QSXKeRCPxNYJAYP54XssjfFBuKM5qsC9nWbNrD9XLSeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4731
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140091
X-Proofpoint-GUID: RiHttj4cgF1t9afko851yX5tjT-k27ag
X-Proofpoint-ORIG-GUID: RiHttj4cgF1t9afko851yX5tjT-k27ag
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5MCBTYWx0ZWRfX4wbRGVNSIKNi CeuBu5OVfVIj8SaOqrxXjaXoay//F9PuiYV3ORzdzzUI99SXnWu4NpdHy+08HKtLzxkr18/ACj9 9EfrUAQgDCw9YJSSgzcLe0Us3bhVI/91eF0Kkq3aPbAfj52iO/GBNs58j200kToGIcDtWHeb8Bv
 uRyLIvm/F6awi4BKpAo7sKIpHtk4cjxZtigfHuBf/ExlsTatJIJbjqZcM+iwk1CtTMr6lggtvms LmOf7GO8gxhdXkumeOpI5fMIs0EZbeh27DpIUUl2Xq5f2ksRKA0uCP2u4zrL5Iujax4qvXIAvbk QWFFKqoipcW3i1zToOMO+R51vNMMjtbFLd4PBR0U+PruUOE8rpBzVg68RT7Q6wyHCDBUvMTr8z/
 UeCip4+Pn5NpsA36u6mq+5Q9eculRLRHUPzUaVnvv0XTPSK7EkYaddnwr/cwC7UJlpiakiUr
X-Authority-Analysis: v=2.4 cv=U9ySDfru c=1 sm=1 tr=0 ts=68751fd7 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=I3mwuPAd26DWc_mIGaIA:9 a=CjuIK1q_8ugA:10

On Mon, Jul 14, 2025 at 05:03:03PM +0200, David Hildenbrand wrote:
> > > or sth like that would surely clean that up further.
> >
> > Well, I plan to make this not a thing soon so I'd rather not.
> >
> > The intent is to make _all_ VMA flags work on 32-bit kernels. I have done some
> > preparatory work and next cycle intend to do more on this.
> >
> > So I'd rather avoid any config changes on this until I've given this a shot.
>
> Sure, if that is in sight.

Yes :)

> > > > + * only do so via an appropriate madvise() call.
> > > > + */
> > > > +static bool can_madvise_modify(struct madvise_behavior *madv_behavior)
> > > > +{
> > > > +	struct vm_area_struct *vma = madv_behavior->vma;
> > > > +
> > > > +	/* If the operation won't discard, we're good. */
> > > > +	if (!is_discard(madv_behavior->behavior))
> > > > +		return true;
> > >
> > >
> > > Conceptually, I would do this first and then handle all the discard cases /
> > > exceptions.
> >
> > Hm I'm confused :P we do do this first? I think the idea with this is we can
> > very cheaply ignore any MADV_ that isn't applicable.
> >
> > Did you mean to put this comment under line below?
> >
> > I mean it's not exactly a perf hotspot so don't mind moving them around.
>
> I was thinking of this (start with sealed, then go into details about
> discards):
>
> /* If the VMA isn't sealed, we're all good. */
> if (can_modify_vma(vma))
> 	return true;
>
> /* In a sealed VMA, we only care about discard operations. */
> if (!is_discard(madv_behavior->behavior))
> 	return true;
>
> /* But discards of file-backed mappings are fine. */
> if (!vma_is_anonymous(vma))
> 	return true;

Right yeah.

>
> ...
>
>
> But now I wonder, why is it okay to discard anon pages in a MAP_PRIVATE file
> mapping?

I'm duplicating existing logic here (well updating from the vma->vm_file check
and a seemingly pointless !vma->vm_file && vma->vm_flags & VM_SHARED check), but
this is a good point...

For the purposes of the refactoring I guess best to keep the logic ostensibly
the same given the 'no functional change intended', but we do need to fix this
yes.

That change would probably be better as a follow-up with a test change added
too.

But I agree this is an oversight here afaict.

>
> --
> Cheers,
>
> David / dhildenb
>

