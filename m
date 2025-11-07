Return-Path: <linux-kernel+bounces-890154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6F2C3F584
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C7AA4ED69C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7613019D8;
	Fri,  7 Nov 2025 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UrtqO4cz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ldMaiW9W"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE8D2E88A7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762510225; cv=fail; b=rTWDDkGi+YnW044236inlDWt39IFfvHKC6RmIy4GBm5W9ueWWaC9lX8DzfVwNHchjuVjro1WY7h8m6Jbl2on++9VMz2SqdyXHNVqTPVXQJBUPsVbynXIBMz4wBl44SU4critvC9lc/YrkQ0bqAc44LsZo0H04mWXaaPcrGQU27c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762510225; c=relaxed/simple;
	bh=s/uHb1ByRyR70sjw1HpTz78feM7POyVrRiaqe4KK0Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ONp264sc8vBBwPGavo3PWBoPvUCTOht/E8uXRVE4NOjr6z9iepxczWRvO42A5GNcSOM6CCVdFyJdI4Z5Y7aMDp3+ACS6XNgoT7TGLN81pr583CDYTVBjpOde+2YJSOB/SQw8fY7bAS961wgUq80nyhH6QHYsk0uQtWqD22qKIW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UrtqO4cz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ldMaiW9W; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A78unav019809;
	Fri, 7 Nov 2025 10:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=fkbsW5VovQNGXMGEb2
	emAs9B1MHAOMjuqm8iAQKxJVk=; b=UrtqO4czZI1JyWNchOS9xja5hFd9sdbAyi
	eI+cqDKf8voy8jZqcmkZFwafXdh4xOwWyIhUxvkDDniUoVHXXv3KSuorB5JMIyha
	MxRZCeHh8E3cfoW4eocnR5f9LLzfNpi2REpQ/GSI65hqYYC9tZ/PB8am5TmlsyYk
	bs1Tmec8g5JnvCBpZ/XaH420drXta6QcX1uPuMyYWLQzo3j46aL7C1M3NJTs3H69
	OElmPRLSk+9beNz/gQAOBlDZWaq/1O5rMZ29hV4A9E40p+EjrFksHMxwhC5bP5GL
	d6dCWp3te9gN4FVxbYh3l1b0dYek3zIeZ9vXcK44Odkt7ufUWxeQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8ykwsj1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 10:09:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A79XTII010852;
	Fri, 7 Nov 2025 10:09:48 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ndk077-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 10:09:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEcHpbp955WUt/tTw7yY+4EbxOMIrp2nI5Xyi8QhsftXoHZtw8uyS42DmEJ22xm33K3LdC3eH6/i45R2yxcbn4vm8655cl98yAQjs25o/XXfVhea+EjzzfxEPZLhWQ3iEfCQPrvsy7WWuprdyShL4yfJeU2RgUe5oBeeIIOxL9B2/CDETIdZfzj1cyP5HFNvTj/aVDmxzBzYGUrrUFVEx0eZB8rnSXvIvKJYl7+7S9cd36r54RVs/QVcyX4leLKLhcVgEA7moGqePjnMu+Y3BL1E9dtRhCcif7PNzYzhKV8eNIip2IW0VCzC2FTjJ4q+JRE1DE4JcLOy0CAg4pABzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkbsW5VovQNGXMGEb2emAs9B1MHAOMjuqm8iAQKxJVk=;
 b=ywgHDs/kVskl9KDEZ/fzpbBR5hFiJt4aMV27IZMXw1wuKUDRbilumukZ03leN3Qs3xmdTu36q6PyD5XMFoKSxvaAGe4zScpcsyEQlU5suEo8ZJhUerbuhYjTQdVkeJgVL3bMLLamYgNXfNOUUIp5L6mcbREvpHn2WmpHLbwiu9VJG4BtCs8d3hTBgTRFDamj/lumn+UOYIX0TvFRnYaEnXc9eazY7JR7rSjqGZLLoQHDPkcdIyWi2QTGHQDvaeXuHOr581or5c/qW59ANVPNKWiJlucQJqjN9M2rlXC+9vxePBFZk1roFg6Y58vaN/TJWtOP6V8h3+ZBap18PQglgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkbsW5VovQNGXMGEb2emAs9B1MHAOMjuqm8iAQKxJVk=;
 b=ldMaiW9Wwzj8F+05zrxa/fpKTxJCj8eEL9HqUfDDpbE9mLj3raeobrvM1bFxYtqkL98tMVIew7dVDbIhgO9hG+tybwBcQ1I0Wa3J4OvcVVknffqq9hgzCPuAJf/09HDNGk7DILy3cofHCK3CqdTfGnQLv7k37HgtcmOCKiS3+cA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB6296.namprd10.prod.outlook.com (2603:10b6:806:253::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Fri, 7 Nov
 2025 10:09:44 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 10:09:43 +0000
Date: Fri, 7 Nov 2025 10:09:41 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "David Hildenbrand (Red Hat)" <davidhildenbrandkernel@gmail.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        "Garg, Shivank" <shivankg@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>,
        Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        zokeefe@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: madvise(MADV_COLLAPSE) fails with EINVAL on dirty file-backed
 text pages
Message-ID: <868d1103-df00-43dd-b04b-21568309445e@lucifer.local>
References: <4e26fe5e-7374-467c-a333-9dd48f85d7cc@amd.com>
 <8bc796e2-f652-4c12-a347-7b778ae7f899@arm.com>
 <ozkb6mcxuymlz7tm4vcnqf266gd4ruiik2zal2koo5ffprgxfk@35godtyix2cf>
 <43a8c8a6-388b-4c73-9a62-ee57dfb9ba5a@lucifer.local>
 <77a54f63-f5da-42a2-b24d-5c8a0f41d1e6@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77a54f63-f5da-42a2-b24d-5c8a0f41d1e6@gmail.com>
X-ClientProxiedBy: LO2P265CA0091.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::31) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB6296:EE_
X-MS-Office365-Filtering-Correlation-Id: 033e1711-0d53-42eb-e9c7-08de1de5c5de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z4dQRTFdKtArqF1tpQenR0NVAZhWYnpHQmeaJ7kUJNYDq/27s9GGzQvLoRD7?=
 =?us-ascii?Q?75y10f1fJYPJrKQgmkGCR+Uy7myrr2TFuy1u+T9tWfjR1imDgeGJzWhiRtIo?=
 =?us-ascii?Q?U76pVJ06S/o1VK31M/Y7V5OoR5wn/M/iEFItvLFpnDUJbUZHLsNenmoR9rTe?=
 =?us-ascii?Q?9vtMzo9sZ5gspql2Mc+EuHrXGFRWwNTu6OhgibdXXVwZo3cFZHOpnqyJhDx9?=
 =?us-ascii?Q?xsUQsBK/FGZtCjp5NtBobgZGZad9mktm6U8em2F24CO0kf47xHi59ncwHRYE?=
 =?us-ascii?Q?3L3DzOCEM64kaS89yJI/2ogrGU2hPA08kze00pd2w7rJPPtEuQMKKQ5cyb8w?=
 =?us-ascii?Q?/e5EijWQBw8E5DMk4NSZxGSzTaKputysgbZ+a3qruclOeal/NQc2KVPuD/I0?=
 =?us-ascii?Q?XHRLY/4/xKyB4vF+ihCft7C78oplchkXKztN8hgeniKJGQ4GDtELm7cLRRIQ?=
 =?us-ascii?Q?4wFMqTI7JF9IieKVtBDWNsCMadV7FquzjE84bWzWoRVDXNP0qwFXo/db/l//?=
 =?us-ascii?Q?F4LyrvZ6phdVDQdSdeYxqecjGpQN3jzsTXR/a/MVprG5r+aRxmXKqc/L79FM?=
 =?us-ascii?Q?fFL9ShxBKPMYnB4MS9B2PL2sJBFmVNmak83iSV5bif58uNjG44WLiBhMRTIo?=
 =?us-ascii?Q?++rSbIBJJHlsf+sH+aBJ4KBwzhpuZyTtw4VmijGfAhdXxa26taJ19hGtSCFl?=
 =?us-ascii?Q?hIfgK3VHk6PBeU/bOc3kRdD5s09VuqgWjrWhL4wue6viToY+XS/GFGGPEq8J?=
 =?us-ascii?Q?rgh5FmIr1uAbKZhuAxWy0X85hT59ZNz5wrUuIrTEJq1MuZWHXWtxiFoEiZFm?=
 =?us-ascii?Q?dxYOtotDy4FWbQDNmBsgfE22IxUsS2aqVFrNLAsqPwIH5oqQY8w7yMDaRyRY?=
 =?us-ascii?Q?ZhMkN/oHdGnqU6MLXEQEvmQIOj+KtiEIKq3j0pSfbCm1F10yK0oagRgNaP+i?=
 =?us-ascii?Q?5ETM+/vRmgv0s6WpzYWitnF+UXPooRPpVVjykCBg3qDyUgy/J4aBAQUe0A1U?=
 =?us-ascii?Q?GCxA3WOGzsQkRHXL8bGgBUY8xxaBfrLcZuGozp66TXDVV60zp9yxQf4iHugI?=
 =?us-ascii?Q?e4b7/i12bckP8Wsm18L/x3Qv8N+tJZVT7cBLUipMQ15BL0gcQYmGVXzDaOej?=
 =?us-ascii?Q?+JIEnCqdTMuVK43efHENVIodSRSB+7fM2BsKfO/sU/7F5+1LcWKJzJWXlz7k?=
 =?us-ascii?Q?vbC32c2SaOroAaZEzyYCjlbci6P7DIJbkq0Qxe1wmhh1b9IcnfG0aqiXgDJz?=
 =?us-ascii?Q?6sKHR59euGKWdfrTvCsnYq+ySdRnqxa+LhZ9gbMlebV539+HJDv9r/H9KYye?=
 =?us-ascii?Q?zoDFH5g703rScvCh6G0r6kz9skcevyrcRf1l4u4rx90xXRaElPzRqeRcCDbe?=
 =?us-ascii?Q?xXgYqTJ6HLu8s+J0vIz1Ix1tfTu/7W2JLtdgSDZ3AunpASxM/8jKvyIasTRx?=
 =?us-ascii?Q?lHJGbEK3FhV5g5QeLKkH0wFlO37F5uzo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O2YcI0QcKE51DyDLRPQIHBipXZwYnqKKzijq+WnXrUxb5OPma50/HxY7YjjH?=
 =?us-ascii?Q?34mTBV0PfEfcY+MOX/Hs6+Y4IPEQDXaULnWfGnKIQovD+U+CBosyKtY9bk8d?=
 =?us-ascii?Q?5ZJisQu4UJIBWRuRkDXptwW5irRJmFrXlmiGm7GXXTzYohFMa35AiSt8xPnF?=
 =?us-ascii?Q?9X/PBXLio+pXzNL5dc6gu618QBr33W4qzoa7/Q+B+BYwcJaeRNqb002/sTfP?=
 =?us-ascii?Q?0R7K+DvfKFv/Z0T5GcfpyFGlHvnqQ1BfZm3KiVsH2EES4NoSdPnqF2ieHK0H?=
 =?us-ascii?Q?TIl5C+3kRxb99GzaX5xc0UBKvfAgIymfVUB9pnS/AZ28Y2HhDe5iak3hh7vM?=
 =?us-ascii?Q?yHvodLP8fBBUyjKrjwxiIidbuQp8H7wld9u1O7RE+N6vPsvz27jB55FxPe/y?=
 =?us-ascii?Q?wGgU2kSposc8oRAf9GJ+K81UGYFeVbDO3A/krka00oZL3M6EnGt5Gb1NNR7k?=
 =?us-ascii?Q?Vud6GTobJSu73UU0J5t6Npw8g/2f5q4O8LE1bKhXpg6uvn0yr4VhVVpvUYCR?=
 =?us-ascii?Q?Sq3mJWJywDkZJWjK0FTwL/9Lfgmx++JTD3VlhWREPTlOQ82CONAkYvRyLBkP?=
 =?us-ascii?Q?f+4ocXhwIe116Jov5pSqlJ1q75kiih/7yNbgH8Y9oUCvVVfH2uYk1eyLmqMR?=
 =?us-ascii?Q?oIILLZjyYqcAVH+VJWcJDmlR00d33+bxZprQEdgLBo7oygIghHKuLNHlXlAx?=
 =?us-ascii?Q?+Ntjs4kqV1Dj0diQt43kGMMW297NQOrwIWXBbV/ZM0bR7OsFSEUyQBdm4Gxj?=
 =?us-ascii?Q?zqBTlGujcWzg4qz5SdTAL/KhSBa6UdEE0i3TZyZaoFCKxGgyDridMhvM3Du9?=
 =?us-ascii?Q?Nh+v0uRIWUUtRMkBdxIh12zQqSypEC2UAH6jXonqJI5ty+xd7nd0XbcITIOS?=
 =?us-ascii?Q?SPkqFvnfttx6+IqCVT7LhpCEkui3dbb9L5RxfnucP4BwQCbp93IP2vsBdJve?=
 =?us-ascii?Q?ll86Lc86/XnBEzAu46tIhV1DjTsvITC4IO9FRveq53tLxKnaf6l2e0sHMPqY?=
 =?us-ascii?Q?EzGx5nQSX2Xmq71dLebMECQE9+OBg/jb4xaXxGpdH2CP9dvQyxH8K2GMniBx?=
 =?us-ascii?Q?Jj/8c4JpxFpTszajduDwT/lfR+Bb2ZymJVSZppFEbQOtMRn3iGg6n/Rup8vk?=
 =?us-ascii?Q?XrrlcnS4gUugCMwEABtnUf5xm7MvR780i8fJWQuDt9mq21bLdsX/H6xUYPZZ?=
 =?us-ascii?Q?Lv53zyjGpi2oyCdtbHTixgdoxk/L9SW/qAHSLCYSXhxwE2HI1ZD4wzjLRUu0?=
 =?us-ascii?Q?hPDUOvC4dHA6wCH8258mvbrZc/4yFwcwjwcA89EU+9/aRNHcD5PGdmp1feMv?=
 =?us-ascii?Q?nXvAJXnY1R5t8APV8iB7iwIP/hBoU/0uNuSVWt4PXhN3pX6vCCbBzjUX8VrT?=
 =?us-ascii?Q?byMKOjH7dGeXMYqgSSpYbxCH8WG4Ud9+VAxlb58/z2dCEF/0F0E7e/pqzJpH?=
 =?us-ascii?Q?twVTpguHf9QTFZfGZ+ATen5/r/wKQ+n9qgdPd9x44DwxoiGRzbanKGZ5ENWh?=
 =?us-ascii?Q?Yzy2jO+P+suP52tQh8b6/bOKzRRbJvox1ex7TOTp1VunxzJAVe+WfsiaaVjt?=
 =?us-ascii?Q?234ggbH6hyfk53qxjmELg3S/WD57jmeA5oqJWcvsSST+d5/xs26JU/quw70c?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Po+0EybijrEMzAiq/Z4OT7W5+frixsuF7tN0oNeh+SQZvB6zC0hfuOu+ruEVdHGRHNno7ZG+xZOeMnVlulSD8I2nJejW4GmpHlYqsGOR5TeFWRPbZM183IeftG6XyoVru4TVBY8iP61WE//ITyICzpqapGrb8RfI3k6V1QhOQKwb+xkP0cujAyrCJUloAXc3h82dWXnUTo8CYwdzSaI+tj0HDfcrk2kme2yIkTQjrXv6loAMVhMwb9mSK50lP0152mnh+wjx/t2IVVtioB30L44Wj5Ixjt7u/wzxYx2bUkDOe825MkqIXiGHRp2sQDlxP91ysoi55tYcMgLwdK2g/SSeDWQ3u29yJ2jq49DHzgIsq8jxuaIuko0m2czZ/dvSjme2jDbtPlLlmt0E1UI/Xa3xDePB7XuAlqmlDBqC5Axvk3sXEKQdPXfzNokgY6bDIVMn6KJQVTfMcOaqpdcnl9/HXhhBxVTBVPhiloGfDo3U2chmYRXdNmsrRMZcuG6aKiG6LK6e2ruCZtXkr6hpQ0aURHBTMyfrkuh265nmXTkjZG/5OkYzkxQ4/kg/odFpZuWyusEppQ0HuLRA3cQSwfB4th1Yi04Qlg4fvFf9JsI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033e1711-0d53-42eb-e9c7-08de1de5c5de
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 10:09:43.9238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cu4IPud3ktobmQCL73tQGe9l4pXYMDAdoEOdAGEd4r7qfmKciL6xpaymbrIa/pJk+Y0FmA4up3eHBiBJSN78aShpIWlhDvjC6AqeUJOJqKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6296
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511070081
X-Proofpoint-ORIG-GUID: QrYAqtXQofPiw_T1TPQ7HwGw7VUow5pI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEzNSBTYWx0ZWRfX2HvnGb1Jh9B0
 oy4jR1oept3YxkdJIsSJnY3ftuhs3e6QnQmHj4QCFrpUG+gc6Aipi/5sej110f4s2cRwU9Ta+Im
 y6t+SZdUKSdvQXESuDJ5bgS9lxAvc1PpxcaBAK0GFfrhQTGH8asbzp4+J5MjDeYMPCXvzRGc0HP
 WD76fdY28M6amr37zeoASUhPNmc/L7IGal1R7Ax4ihrd/M2nCtG/q7O6jLb9JPC27/3fkjVuI4H
 DWitcIsjxcSeYC0bdSu8bFEFpCI3xPl/Kkl7oKjRgiRvcc5JT73gqJEEXo3Vl70yDH5yOp0REbb
 JCcXwyyBHT3PG5SScLFzPdyWoiHwOnsJ7YZTpz2yoErcSlsqbQFFgx/br96H0yY99nlXDWmy0bz
 TiAS2ffiROrv6slDJTFrCwAN5LcFxQ==
X-Proofpoint-GUID: QrYAqtXQofPiw_T1TPQ7HwGw7VUow5pI
X-Authority-Analysis: v=2.4 cv=T6KBjvKQ c=1 sm=1 tr=0 ts=690dc56c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7CQSdrXTAAAA:8 a=ur7fQZjpPlJVLXsslj8A:9 a=CjuIK1q_8ugA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=cPQSjfK2_nFv0Q5t_7PE:22

On Thu, Nov 06, 2025 at 10:05:41PM +0100, David Hildenbrand (Red Hat) wrote:
> On 06.11.25 18:17, Lorenzo Stoakes wrote:
> > On Thu, Nov 06, 2025 at 11:55:05AM -0500, Liam R. Howlett wrote:
> > > * Ryan Roberts <ryan.roberts@arm.com> [251106 11:33]:
> > > > On 06/11/2025 12:16, Garg, Shivank wrote:
> > > > > Hi All,
> > > > >
> > > > > I've been investigating an issue with madvise(MADV_COLLAPSE) for TEXT pages
> > > > > when CONFIG_READ_ONLY_THP_FOR_FS=y is enabled, and would like to discuss the
> > > > > current behavior and improvements.
> > > > >
> > > > > Problem:
> > > > > When attempting to collapse read-only file-backed TEXT sections into THPs
> > > > > using madvise(MADV_COLLAPSE), the operation fails with EINVAL if the pages
> > > > > are marked dirty.
> > > > > madvise(aligned_start, aligned_size, MADV_COLLAPSE) -> returns -1 and errno = -22
> > > > >
> > > > > Subsequent calls to madvise(MADV_COLLAPSE) succeed because the first madvise
> > > > > attempt triggers filemap_flush() which initiates async writeback of the dirty folios.
> > > > >
> > > > > Root Cause:
> > > > > The failure occurs in mm/khugepaged.c:collapse_file():
> > > > > } else if (folio_test_dirty(folio)) {
> > > > >      /*
> > > > >       * khugepaged only works on read-only fd,
> > > > >       * so this page is dirty because it hasn't
> > > > >       * been flushed since first write. There
> > > > >       * won't be new dirty pages.
> > > > >       *
> > > > >       * Trigger async flush here and hope the
> > > > >       * writeback is done when khugepaged
> > > > >       * revisits this page.
> > > > >       */
> > > > >      xas_unlock_irq(&xas);
> > > > >      filemap_flush(mapping);
> > > > >      result = SCAN_FAIL;
> > > > >      goto xa_unlocked;
> > > > > }
> > > > >
> > > > > Why the text pages are dirty?
> > > >
> > > > This is the real question to to answer, I think...
> > >
> > > Agree with Ryan here, let's stop things from being marked dirty if they
> > > are not.
> >
> > Hmm I wonder if we have some broken assumptions in khugepaged for MAP_PRIVATE
> > mappings.
> >
> > collapse_single_pmd()
> > -> collapse_scan_file() if not vma_is_anonymous() (it won't be)
> > -> collapse_file()
> > -> the snippet above.

Sorry I was looking at Nico's series these functions aren't correct as of
mm-new atm.

This should be:

madvise_collapse()
-> hpage_collapse_scan_file()
-> collapse_file()


> >
> > But that could be running on an anon folio...
> >
> > Yup given it's CONFIG_READY_ONLY_THP_FOR_FS that is strange. We are confounding
> > expectations here surely?
> >
> > Presumably it's because these are MAP_PRIVATE mappings, so this is an anon folio
> > but then collapse_file() goes into the snippet above and gets very confused.
> >
> > Do we need to add a folio_test_anon() here?
> >
> > Unless I'm missing something... (very possible, am only glancing over the code
> > here)
>
> collapse_file() operates exclusively on the pagecache.

Right you're correct:

	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);

	...

		folio = xas_load(&xas);

etc. etc.

And with the code you mention below, markers + MAP_PRIVATE are handled
correctly.

This THP code :) such fun.

So yeah this is as simple as the folio is literally just dirty.

And:

			} else if (folio_test_dirty(folio)) {
				/*
				 * khugepaged only works on read-only fd,
				 * so this page is dirty because it hasn't
				 * been flushed since first write. There
				 * won't be new dirty pages.
				 *
				 * Trigger async flush here and hope the
				 * writeback is done when khugepaged
				 * revisits this page.
				 *
				 * This is a one-off situation. We are not
				 * forcing writeback in loop.
				 */
				xas_unlock_irq(&xas);
				filemap_flush(mapping);
Since we do an async flush here ----^

This is why a retry (assuming writeback completed) works.

				result = SCAN_FAIL;
				goto xa_unlocked;
			} else if (folio_test_writeback(folio)) {

>
> I think we only start working on the actual page tables when calling
> retract_page_tables().

Yup.

>
> In there, we have this code, when iterating over page tables belonging
> to the mapping:
>
> 		/*
> 		 * The lock of new_folio is still held, we will be blocked in
> 		 * the page fault path, which prevents the pte entries from
> 		 * being set again. So even though the old empty PTE page may be
> 		 * concurrently freed and a new PTE page is filled into the pmd
> 		 * entry, it is still empty and can be removed.
> 		 *
> 		 * So here we only need to recheck if the state of pmd entry
> 		 * still meets our requirements, rather than checking pmd_same()
> 		 * like elsewhere.
> 		 */
> 		if (check_pmd_state(pmd) != SCAN_SUCCEED)
> 			goto drop_pml;
> 		ptl = pte_lockptr(mm, pmd);
> 		if (ptl != pml)
> 			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
>
> 		/*
> 		 * Huge page lock is still held, so normally the page table
> 		 * must remain empty; and we have already skipped anon_vma
> 		 * and userfaultfd_wp() vmas.  But since the mmap_lock is not
> 		 * held, it is still possible for a racing userfaultfd_ioctl()
> 		 * to have inserted ptes or markers.  Now that we hold ptlock,
> 		 * repeating the anon_vma check protects from one category,
> 		 * and repeating the userfaultfd_wp() check from another.
> 		 */
> 		if (likely(!vma->anon_vma && !userfaultfd_wp(vma))) {
> 			pgt_pmd = pmdp_collapse_flush(vma, addr, pmd);
> 			pmdp_get_lockless_sync();
> 			success = true;
> 		}
>
> Given !vma->anon_vma, we cannot have anon folios in there.
>
> Given !userfaultfd_wp(vma), we cannot have uffd-wp markers in there.

Right.

>
> Given that all folios in the range we are collapsing where unmapped, we cannot have
> them mapped there.
>
> So the conclusion is that the page table must be empty and can be removed.
>
>
> Could guard markers be in there?

Right now guard markers only exist if vma->anon_vma is set, including the
file-backed case.

But for file-backed guard regions after my VMA sticky series this won't be the
case any more :)

So I had better go change that...

I hate that we have open-coded stuff all over the place that makes assumptions
like this.

This also ignores any other marker types. How I hate the uffd wp implementation.

