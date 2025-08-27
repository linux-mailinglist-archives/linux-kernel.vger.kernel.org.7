Return-Path: <linux-kernel+bounces-787807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238A9B37B61
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB9F6366F17
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 07:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643E53164B8;
	Wed, 27 Aug 2025 07:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZRiQbvON";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KzElkXbI"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9FF1EA7CF;
	Wed, 27 Aug 2025 07:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756279250; cv=fail; b=SJsIz5hVc4VU7nagCpN5mUemlenszlmAindG3AP/Wc/SF8WDrnJzHXDYMddRL48NFb9TUVgCXnzHKHRGzSJMHTl5lkm/Tul6zQLf1ZVc5D9R6y2xyks7SFRMJVJwuTy50Ca67NXfyvQbkYsXMGu9Bnq8WxWnTkPj2in8KMOFPRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756279250; c=relaxed/simple;
	bh=BBybr1IQc2AzEoYg6avhGFsz5S15AKT/24IwLzWuQM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UbsC/8VVN132G1gOsmi0e4Z5GBEzlXQU+PTnAAuAB6sa1u2AXvC7MY6yAi6VCLx+4fT3V1YYNVdJMco1tX+AKrKMoCU7w/W2yish86cdSBtAPt+BK9B3K99iXhTHDqVt6OsDK+VwJy75J0IraPlzieadT+nc5+4bXVvXyMvAm7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZRiQbvON; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KzElkXbI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QLLMgF006402;
	Wed, 27 Aug 2025 07:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Zn15SbHkaxch7Emb4E
	R8vYRo5WUKLjWhiXgVjEfQi6o=; b=ZRiQbvONc4cqFWkhpIW38VJ0SrlFPEipzn
	6SyX5GmVm0KhNLgaJxgLXz1W4ArTeBZ7Desd8qIl9zX8YY16KJWhwQWyswU++eYU
	6a/7IYXHzAt1666IgPb186AUke79H+baBnbFfeVd9Zvz+DUJKrx8o3xUmJHBiJTz
	VdMigoL9w14N99ocD9LM3m4dxmEsHKELXUK6RObdCyZ2tDi9+nvEHEHvWzHxQ6YS
	1p49oXkGsp4EmJRVPWqkI8c7nHiJIu0q6DvSBxvWgJ1nCuaCzzpVCsZoOacBwezV
	l42sESdvVlR/6A563a29zXd3Se9Cdpb5e9J7lKGIqzqRbI44r6xQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48r8twcpv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 07:18:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57R53pe5026739;
	Wed, 27 Aug 2025 07:18:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43aar6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 07:18:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MO1Pfj3T3JPCmw1OcXsb/LuJBBrV1KA/dGwWjseysI42o0bttg3mg7ZP7HvkR//Le7e+f3llUucI0NrE2Yz1emnDgusR4MP5Ynr5jt0IoVC2iU28oD9jU+JDQ/bMf8EG1Tpq3C51hem/NymXBBntD3ufr0mnYWScyzSBUw9FUI9auMcpfUWKKnV574To7flE2AumbzkIrI3cJLr4wQCjVkSolZljD/rS0+63IpAF/JZ/CX7kr9BEEyq8qEpIKP3gtXQAFYdVGKSWMULjc+4r4cRR2VYLAEEIzyDWOWPRhWFNo5Zt2s7PakF0ANjQulX294gRb4sdwnYejvLhaGAwJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zn15SbHkaxch7Emb4ER8vYRo5WUKLjWhiXgVjEfQi6o=;
 b=pc7+lXa1hOgcvBH5wLG2R3hweiH0EEOdHqke41+nSMttdGMAqSF0cMxKN0ko/DUUv9q+NdzMHS7Ynn4ort8k1KiXUI3KBXI0tu23oTJH6RWQ8TwzGR1SY1AfRn5VDhScvBlL8xWDOOs2wMXzMlPOJrSA0xstMjzT0ww8wICpJw4shNZufxnxuDyABMS/6OhfTPo8c7ZhuPFYgmWOL84AVWvcRAcn3aD7ZJo35ufFUobPYWIjDROtXbABY70cx8veSSH7DDXRBaQOCfKKGN5KX/nSLGFyX5Z5BvtAvRyWHLf9gSNM+qXmqpYPvaU5cEULG8y+12ckTpSLG+KNkrjcBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zn15SbHkaxch7Emb4ER8vYRo5WUKLjWhiXgVjEfQi6o=;
 b=KzElkXbIX5Vds8/0325GsncXlvLEV1aZWY8CQyvYATFrDXoz3BAya7hkY3vgglKeTsFpXoLY2O2WTh5lGpRLuD37RGgqDzJoQAl43i8r3NK+4ILNIgOhOV5yb6N3lZnPsEvZw4yRJun4GRc6jYjiCJ9qb1WjAz4EebzCbhaUbtY=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7139.namprd10.prod.outlook.com (2603:10b6:610:127::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Wed, 27 Aug
 2025 07:18:40 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 07:18:40 +0000
Date: Wed, 27 Aug 2025 16:18:30 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeel.butt@linux.dev>, Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 1/2] docs/mm: explain when and why rmap locks need to
 be taken during mremap()
Message-ID: <aK6xRqeOgocTr8kk@hyeyoo>
References: <20250826065848.346066-1-harry.yoo@oracle.com>
 <87v7mabl9g.fsf@trenco.lwn.net>
 <f64483ac-31d1-4f80-8fb0-fcf15867c6c5@lucifer.local>
 <aK2C-Wuv7c_yIOJ0@hyeyoo>
 <88b41934-2c3c-46a5-a86c-0c798fb7d2d4@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88b41934-2c3c-46a5-a86c-0c798fb7d2d4@lucifer.local>
X-ClientProxiedBy: SE2P216CA0108.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c4::7) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 36540975-2a38-431c-db9a-08dde539f299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UraJO/rWeJ6jbN8KQw8Pzgrbg+svibdHSyrVWKnUEpAuq26XvPIiqOUWkXx2?=
 =?us-ascii?Q?tZGoFIECOS32+BMUw76FvWd+6ilDqoLRvkvEdcn4ciP1NJTWb1M2ynGpZCDb?=
 =?us-ascii?Q?m8WHGyIUom+BG1ADDBkbdsFIozFTqLnS1O3+eDemM8nBaBzTmKBiLG2z4Fl3?=
 =?us-ascii?Q?WyOo6zC439zHs4QbXRIaSUCdSItVN3CMBKsHyi9YApixJZy2PYG8bDGm4spk?=
 =?us-ascii?Q?TeZvKWs/jH7UPKZ43r/45sLly3hDA4arojtHsGF87SWJ/S/kFBnQft4gRYWn?=
 =?us-ascii?Q?tpInGbMJZZolqpazVl2aop20zQD05HPbRWw3aZFeGzgzAymrT5L4DwlL4sk3?=
 =?us-ascii?Q?D/AEm8f1AYbTtEVBCJRlETUkv9WyJ1LGIHTsyle2DpfBTkWyHy5YFHIWywur?=
 =?us-ascii?Q?D42zBQ/5Wr17/esBO0jcjRvUYM64iQnmBvPuo9XgTWarWxqJ48h3uXEuWvYs?=
 =?us-ascii?Q?N7ofr/1f0TT+1xqfcSPWM/kqTr01kcuVOT7wwkNAUbDlVmniDhwK2zUK6UlD?=
 =?us-ascii?Q?ie4C9WqOKruDxRaEldsvh7KZybdrJjEVNBfxNPxb2a2N2A86XZ/GUo9/zgMr?=
 =?us-ascii?Q?LFt8DDOIp47UGtiHeZsJQEhPUZtoLDBHN9DZqbjHqlak5w6U1ku21p+VHkcp?=
 =?us-ascii?Q?yBp4Gmq1oA9SY18qtAYHZGo/j21jQ2AeI6PRftp+efM5J0fLX6U2wul1ZtV6?=
 =?us-ascii?Q?SGbZFQV1azzVW2td6TAhBELc2YAKSIlKU0R/zJYarg7YzP7uX7JAYl4/AZ62?=
 =?us-ascii?Q?JMdfBwH7SRE97VAGsfz+Tj75P0476yxp4kDWOkeewE+M/YtmjGYSihmXkQhN?=
 =?us-ascii?Q?/EC4EUPwLNUKoXcqoAmz7eDAtULn3SC+AhQyUlOrHZQzcBAFL/SprOIAfXln?=
 =?us-ascii?Q?44husFRhmMJsqCxE/RyzkoX8S3M+694mReiPsJA0YATwY/AZCMQRmmzYnrIq?=
 =?us-ascii?Q?CpVfcOr7v7wuP9hKZMbsFReJvFDtziW6uThwLPuGjZ/bk7T3bIP581TeuPbM?=
 =?us-ascii?Q?Owd92vNzW6DcycWBOSOOACAGNbz9KzhuObkGnvXDHjC1oacSQYmKjYuu6Lqu?=
 =?us-ascii?Q?lzHMNSBDKRiEcqghnMUNi6ktKtNvAwhNMHnus48NBB8NZ2B72dARkbxVCv4Z?=
 =?us-ascii?Q?DoPBCuc6/SRMY1ezHV/cQYRYqyJxRPMhwlVc5wSzOwBwzUMlJBge8M61uuWr?=
 =?us-ascii?Q?Lj5zlfWtT0cXROciPqNlrrzG8ce9MJYte5bu10c8aXisURQiBASWfMiIz89d?=
 =?us-ascii?Q?F5snstBT2i4sI/I/wJfn01pwC2FLi0vhixg7zSCa8/bNw2984PU+zjQiIdJf?=
 =?us-ascii?Q?UQ3rfAhFWX/7i3pdbmqkmttse89APNxW1A98wQ3o/x0A9tHSufc3Lps4UYKG?=
 =?us-ascii?Q?vpaG8jLQ2O+IBZai0ZwExP5YSLd1DXCBDfg3rn4LLc8az8oJgVX6EzlaejLg?=
 =?us-ascii?Q?tTz6hPlE9k4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rDD9aFNJBaOxFkzRig3D+Unw6UGfcugXDJ5gRs3Oyw/tUgGPFZauNPz2hhxU?=
 =?us-ascii?Q?2/PpgPLaYEWT/C1dTVu5m0YEoduu8+RkJx0+7WYUeuitdJVTN6UwCEjRILJC?=
 =?us-ascii?Q?7VwobqqsQcxOYYmnkLtyt84K/tKCIdH2lkPeg5a1iyOdtzIqQBBaT8GgxamO?=
 =?us-ascii?Q?6wv9fWdSvZbJF5fzMz5B1y9yR5KzSLw1l46sjR1tGZ4hY7C9SQpSJ1ZATOQO?=
 =?us-ascii?Q?kgZCaLrmNMGi3p5+8TcB9+w4xX1u/r+0+NULVa5gg/ifDXb118qOBQ2EX7Aq?=
 =?us-ascii?Q?HFBVNaFezSQZtTvZOPakRRh+InY5C0FuK2hXSo2tntZAwpZCVu98EjDSD8OY?=
 =?us-ascii?Q?Fjgt28rjq+t96jrqeRoQHuHtjizbCSnGtvrQpcdAfI5+2kHdY+D8bSgNw4tQ?=
 =?us-ascii?Q?tnuEpvyzSlrn0BDt2Lk1GxaJr2BmG2PJUK1N9CPPBNgCeOK9Q/ETiPzKB6J0?=
 =?us-ascii?Q?nCd1r0V4rP8bXawukM0DMp+FvzrocR/AA95DLZK+NVRLplwR0RAwK1L0/Okm?=
 =?us-ascii?Q?dT+w89uVHcXkbpJvxKgSDTNWFsyjlIL9KOM0NB4FEqb1e4l9JofjSiSaqoNj?=
 =?us-ascii?Q?gZ+PcqZ4ODewPD893dc41uCFqXLtcbfWOeCBv1Cbuvx7t6GG5d6mZtgtBSUx?=
 =?us-ascii?Q?goyC+RECDI4CFgmO7MCeykyvVdxqpB6+LWOtjhwsOWoqqV7l764kaznWmAjy?=
 =?us-ascii?Q?O1hC/irZDtNRx+SzDeLNlHU5BwB95TOpbO3X0ueAvu2OlYPfnESKhS3y0kJY?=
 =?us-ascii?Q?/6cnBa7gtznDJYahKoDh18NI88KsbL+YEJpzEt2lHG+dC1A3MN0/G5kbefFt?=
 =?us-ascii?Q?LHcZg9EmZyHqulfERIC3aCfTO++m5qvNKgPgsxpG8USef14jj7iG8ocL/bEE?=
 =?us-ascii?Q?xQkHTKnbckC5MfjOK4hUvK/thU4gGKx57lpixVJq6crSvXI7pUrFPt5GDfhz?=
 =?us-ascii?Q?qGuB00PIZvPbOiixUh0MEaAq0YrHZzE/lZoarR4d2LIbtDpXzr/SWgAoWA9z?=
 =?us-ascii?Q?buZqyP/eC3cbudb6b6IgzSoh1o8SUx6T6NYQa++Mf2xQ26oy0yYvLKlG0c6K?=
 =?us-ascii?Q?32jL4sXt26K8wgGIuIr7piPa6Gs3Oq8xVvqeUoHzx+0qSwRgg9q5A9xwwrF+?=
 =?us-ascii?Q?GaODha50nIjPJOMIUiwLLokU78ZO0GxZx+zCdkMzT7vHDDZLshzTYWjoQlPB?=
 =?us-ascii?Q?yYtnUkRzUmabNoNntITcOGwvFHGuW6kcbZtceiqoaCDbWudzEh4QA7ZtcFAp?=
 =?us-ascii?Q?x34OMzMyYbsvdJqAfZKmDdWSc+iQ6BocqftL9hmkIHPHxQKFpTELpiQffO5E?=
 =?us-ascii?Q?Zl2EcjxFsD1FtMw/LcZNOTFqapCMBPWoLONCc88NMdF/1Km3aX7pQdTx8kIl?=
 =?us-ascii?Q?hMqEkBMQf0jZtriC/SwqBZv+9n9Ef3efHP/hJraYukF2mbjrctW2fcBMIJJ7?=
 =?us-ascii?Q?b5ZUQwWPX37ljiYVMNRly9sGnljHwqcgupF3gQFC4Yz4CDUy7Wy+ZvGWwppd?=
 =?us-ascii?Q?oulASBSsFKkC6lvS+B81fj1UrwKPO/NLzjd+b/VNDikWrcJwW4fXZslaPs0j?=
 =?us-ascii?Q?ZT3r8iwkBY0JlIDT1JDuZr/ZRlbGqQtXWA0lPZuL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RlfMXvZBQFYujqrokcan+Wy7QULRER8jZLvptZ6g07/xTT6Z5PjoJJsZTDvJqoZbgMKUNt7yRYrXEtfsUVBwPZZhsWyTLYuxYeP7hZT05v4lBWo5w3Pzn3c9mX1vwSTSmbp4NW5o4b64dAjmPkjzeuB8oUb9Yo2yF83bXPGU+OnHuQ8uG99P/bTi6GlpOtvXHI8h2OUiBaklzVnvHl6yLcOPykuGmn8/1bb4KXkNyFYn+AcJyQuImVqUgJVq5xWJafeQza+sJu0Ujx0IpptcjFqja/pumfMlfpOI81YQqbPmVKX199+kp1X6YBVLBrzr9JUXXnNEISNGg8LYps/WQxieHMUvPCBJ6c5RpFpy5azv602YlwJ9nGTnu/VRvkiiEs5oGS0QkRWARvMH2q8wSIlJvPI4MBISQuMEdBE2djC+t+Kqe7lDfY2nt6+X6vqdmmHEyCcmEEczgrByMkiRsl5blf2lX5Led1HcJCNhmUMeTftPOfqhN2DRlEfLGABocXwnxK8hQlCWf5DQNqBnkQFcJ59vZtU2LPvvaz7k/Yts5/90rgnDEEsZRwS8touODbvezvLOUK8KvsJbphn/UfPMcBGtXxQO2a27lJEt+Lg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36540975-2a38-431c-db9a-08dde539f299
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 07:18:40.5560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31A61wNylcRxP4HX3AcvLCc+f5mzrKtB8R4gC/vZE2WRkeoR4BjyIWU3e7xCiQWzHUDv2Z+ISa/SbUC5IBXEvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7139
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=873 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508270060
X-Proofpoint-ORIG-GUID: wmc7dXC_LEn05BOT-IhYd6Q57Rt1kXvy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI0MDE4NCBTYWx0ZWRfX6mku22Ah45Zl
 ZKylyPE8h9ClyY66xdSnsA9DiW6WYkfYFa4N7IB4mXu6zLATBTqqwQs4t7MvzMpDK1BDEXp7yrc
 hXpJfpyGhaAEENowt70VxIdkzYoB5+lENSwnqiUaBZPlLNzhWXSzUKRuTnfixUy9JagD+2HMjif
 LNjbnSIwLrkLi3GvrMA35zsytOSQNiUYuDBMzYrO+8tr98f/nGzfr0w1+03P/YqITKh/pKVZpVF
 91H0szBCloHdTjGozM0zxRMnVuCusujwQURBpwiMIHHXylA/9Pk4EQSS/3cPIxdRixl6WsmkQ+2
 Z1+5h0eWiTHZXqYTSK+ilKLgx5YihXclEN5AhLXpOwXjFFBGzoiDiNmbQajRXXB58vrDCWihVOO
 nGQvFgo7
X-Proofpoint-GUID: wmc7dXC_LEn05BOT-IhYd6Q57Rt1kXvy
X-Authority-Analysis: v=2.4 cv=IciHWXqa c=1 sm=1 tr=0 ts=68aeb154 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VMblobFrIAWNFx2kmEUA:9
 a=CjuIK1q_8ugA:10

On Tue, Aug 26, 2025 at 10:58:58AM +0100, Lorenzo Stoakes wrote:
> On Tue, Aug 26, 2025 at 06:48:41PM +0900, Harry Yoo wrote:
> > > Yeah sorry Jon on latter bit, I did mean to get to that but workload
> > > been... well you can see on lore :P
> > >
> > > I have a real backlog even more than usual right now too due to daring to take a
> > > day off on a national holiday here in the UK :))
> > >
> > > Harry - more than happy for you to do the above as part of this series or
> > > separately, will sling you some tags accordingly.
> >
> > Okay, I'll do as a part of the series (process_addrs.rst and memory-model.rst).
> 
> Can you please though make sure the formatting is all good? That doc really
> needs the function names to stand out, so that's key.
> 
> I _think_ Jon fixed it so that should work fine but do check first!

vma_start_write() works well, but it doens't process
anon_vma_[try]lock_read() properly. (only characters after [try] stand out)

-- 
Cheers,
Harry / Hyeonggon

