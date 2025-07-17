Return-Path: <linux-kernel+bounces-734990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0427DB0892B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7B9C7B99FA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6758B28934D;
	Thu, 17 Jul 2025 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X4XLnwDe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BHDI6yx5"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE20289351
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752744100; cv=fail; b=pUn6fXnE8qNwAE5GoiHGWuDw1V57e+9c4b1RgwWfPLIvEzuFP44Mi+2V7jedgsrLHohctVHklSG+V5Iqys+jmqqV/lD652sX/6YQvV+V3bMBJcBy67SdKq6tH5sbfwpmjI89Z8yqwis1utOjbkzmN+4psdhJEh+356c0+1yvVHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752744100; c=relaxed/simple;
	bh=M8JiCSR8yCXSSITNu1/e/w8/FtsnnuwOtXkUzqtfd9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D5jx/GWUUUfZ8nrwq3yGuWIe8930JTzmcZkjRV65F6r1I0PNUZesJl5wjTGy6/7b3WhcLQAvNwG7ll7SHo2vzSltQkxEiMNEraUG/UxMslbA95hvqUfKI2B9nqtQDZiqPvwYjEY99QKB/a7fNqZDTX+EByiY92PvYeffNYLcS2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X4XLnwDe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BHDI6yx5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H7g8bQ021147;
	Thu, 17 Jul 2025 09:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=M8JiCSR8yCXSSITNu1
	/e/w8/FtsnnuwOtXkUzqtfd9s=; b=X4XLnwDe9HlKLY1Xn0jiJrv52gPN9wpzHL
	qwOpfm/LQ6yTL1vCTqNzR4K2k9b+8rbSaM1To90KDyQmlMxTXaz05GQXeS9NO/GH
	ZxTf2xiQKdnXWe5Oaz2xOoYKlcVIfmG39b8bZHl6J0mKEkO0EkPwhO8LbN9T9fvy
	QEGOYgYFDp3kuLVCXh1ceS6vitn2SUJkObzTDZkaTVIgEGrftkogHpxknQvOyep2
	OIAJjFE3TVmpjDsHAIlefq0R71QFifsqTzeKAMvr9rIiKsy7aAkYXpn6WHIkfNn7
	QL9nR2JXs+ilNnqhsNSKfDsbGcyNOMMaTiVkvpk4e0Zr/4kRwgvw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4tkhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 09:21:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56H9GKH2011593;
	Thu, 17 Jul 2025 09:21:03 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5cg4f0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 09:21:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8zyZ1fXrHD5YZPV0dxEQ16ezAOdWRGcIZ//jQSWoLTu8cvjsK1Nx1wjLZ+c6ZWtlSLG7Fzuh/y7rTSV3Evapsxgbb8GuIJB3JRjrRD9AP4aL5cuI5O1FCvZItpAa/9ouaxCF2dr3RMOK7SP3ilgw3fN6dYz6rhPr0Q6zzDn/fgP398NYZL9tP6h2Zein4XWFhAYnYfvFkElkV7zIvaHnTadfRgGPXuzIPaEnNZadOjsMNl8XXLIi4QEdwFxkTEyddf+jWJPODKO2XffU3AezGR5wXIzL3sO+i45EsRlX79fhO5M2ryJ3QjIzkDmYK7dxozEfdE+wGCqAC/WVtnb1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8JiCSR8yCXSSITNu1/e/w8/FtsnnuwOtXkUzqtfd9s=;
 b=ydcLk3ajMJlp+X9Ze5+hAPdhDEGrMApbtA5IOcVTsRF/OQae8ytcKbOeoFA4gCu35j9Z9aWZgNuRJm0QSduuyxdKSKIhsgOyZAcXy/PGNvHT/TZMxzgPT8H/kqzDMw5XzAO6Mj0K1pr2qQs+Fh4yv6laE68vo0r32ex8ZYE6e4O5ws0EQaPNGpLBxsKIKdJr4lUGGA9LkzfyjS2nBbxRHdVmTnSV4bfQDMQ05iNizb315TcU1P5SEWh9FNubD8JR9eScjYyr21hLXjmC6PouxSPL/aUReqgyk1E683XBUq9zxruOuI38UqG4165vpACJ1esmQsNdjJsiGhi9Cic0XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8JiCSR8yCXSSITNu1/e/w8/FtsnnuwOtXkUzqtfd9s=;
 b=BHDI6yx5KdWSVsB7AjVhqDPut1vzvFfLwc5ive9Vc6ht+K0Rdn3/LqFZ2gAVSr5dV6zMdQOKRxDV05DUzUJBVb4fu5bfygA0ZaSz/+GIcc4a4bfAq/KZY2+pTz3imhv+Wd3qo7qEgXCc+s7RFIBkeXCu9IagaGIZm8PoRRo2038=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB6778.namprd10.prod.outlook.com (2603:10b6:930:99::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Thu, 17 Jul
 2025 09:21:00 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 09:21:00 +0000
Date: Thu, 17 Jul 2025 10:20:58 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, ziy@nvidia.com,
        Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
        dev.jain@arm.com, baohua@kernel.org, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: fault in complete folios instead of individual
 pages for tmpfs
Message-ID: <048c8d4d-5e5b-472f-850b-6392b8f4d2a5@lucifer.local>
References: <440940e78aeb7430c5cc8b6d2088ae98265b9809.1751599072.git.baolin.wang@linux.alibaba.com>
 <20250704151858.73d35a24b4c2f53bdb0c1b85@linux-foundation.org>
 <4c055849-d7dd-4b9f-9666-fcb0bccf8681@linux.alibaba.com>
 <007c4a94-c94a-418e-9907-7510422f8ca4@lucifer.local>
 <23f1c3ab-16ca-41db-b008-22448d9e08f2@linux.alibaba.com>
 <d0b24095-d7fc-459d-85ed-9c0797e9fca3@lucifer.local>
 <3bf50873-4d1b-a7c7-112e-3a17ac16077f@google.com>
 <a1c9ba0f-544d-4204-ad3b-60fe1be2ab32@linux.alibaba.com>
 <2513a63d-b11a-48fc-922a-288785817df4@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2513a63d-b11a-48fc-922a-288785817df4@redhat.com>
X-ClientProxiedBy: LO2P265CA0482.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 55c9c58a-132e-44f3-cea5-08ddc5133ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PfqDOW26u2Q3JLAkjaQlq079zpzFVIEt1mhnxDhpTbCc9yZYUsZW0lrjgcPY?=
 =?us-ascii?Q?fYyvIWmBMVVM5Ec9+yP+lKquj3fsTBKbkx7orlLNeYGpXR9LLld4D2mVQeqa?=
 =?us-ascii?Q?fGCbT0Sdizht1qr3E/7n5Q2waXyszmIrXpgsGabLDJ2KO8Hka1dNh+TWOL5/?=
 =?us-ascii?Q?4bKJXE/zd2yDsboouZ81rV9a4fCRSVptn4c0fq6OrhjHUX6Z4AHxTsFyIg3y?=
 =?us-ascii?Q?XzRcM70+M5YC2pI6tlYPLqiXuxwT4XKCLtZVdVVHZ4qARfAughPW9RPn8RXZ?=
 =?us-ascii?Q?xGIyQ9SbDLhtYNcx1/9pkde5JMP+IoSSjz59A6l8PWjMFscILsX9S0l1DsyI?=
 =?us-ascii?Q?Gtlq2nN2v0U899TK4smqXZ+pMH23YhkcgWu5/XR4aEvhg6U0IBRr1VC1QTCu?=
 =?us-ascii?Q?MZjy5djGXLsRuQdJHzrBi7MQKwFgHXjHj2nGef1Lh1MhYKQRY7WpG9+xWHZq?=
 =?us-ascii?Q?1CR/93SbPOdfJxWC2LmCYMthdD3A2qCNJYMIO4kuj3iuEsdW2dm9KT8ILCfc?=
 =?us-ascii?Q?wXxV2/qEEvEsKq9XitbBXZLt/pzukiL419Jg6p8TfJ/jwjGkGA97ZulOLTCg?=
 =?us-ascii?Q?lVdRmkWX8v8RX2emRtBCec2u1SbVl6n3dKVLTzWDXQNXtfqoWyde7yy4I+Ky?=
 =?us-ascii?Q?raizDRvJpe+CKLzTa3lMk3KNsxIZ56JDh40zkofpsJDL459EKdZf54AQB2HH?=
 =?us-ascii?Q?MVolGa5SqxFh0iUlVjoW1THbVvGoIEZx9yzKMrng5sD4MKaCDUsbp49HT/JY?=
 =?us-ascii?Q?pMyGWU9frfbPf8DJXbWd5jSBDuvNdvpyb+4QP50iUFTb+1ttEzIwK7NmLsYz?=
 =?us-ascii?Q?5rflaTBVnR+5ziKQxGHxBvhcAmBXzh/4SDmz6lX8J0xa7YmU6Q28IRGDx11z?=
 =?us-ascii?Q?2vph/1Z2sg2i7Iz6hbqFonsWOW1wGBLYaKkrIUsNJq0nrRX4CuzzDIJUuCYP?=
 =?us-ascii?Q?zLzvA9RZnJ20+jDhMqHh2H/peilvUSx+JGmuQ7Kk1qmB17m1lT6BplluOLwa?=
 =?us-ascii?Q?TiAERx3Gp8Mm4H3jQ2+Lr7weBBZQ8rsqMcuyrn9HprM9Kilhxu7Hv1UG3mIl?=
 =?us-ascii?Q?BARPQa+n6jWKFSnS5qOiPD89vvyaU2kveYNYAzOJMDYoueIRXpYbIfcj5/31?=
 =?us-ascii?Q?HVO9+THgbQxUX3zkEVSU8UO8yPB6Rdqpom6tvhSo4dc30KHMaTz1panF8r/D?=
 =?us-ascii?Q?kzNDj4z+D4Rl6C89sEuYipCkJB2POxSVT9Kr8erllcbAmgJOClwR4NJCN8Hn?=
 =?us-ascii?Q?3CIGF4Cbb/8Q0UqJt+VetF8vqSG9oVHByM64PIqg7TZ89ECdPnX84fPpgQDX?=
 =?us-ascii?Q?s8FEk6wCQw8wQGSrJJ2hLPk56XqaVSkqdELBQU+NIPvTK2YEBKwtZW4JFBXk?=
 =?us-ascii?Q?zQwFIDc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a7HzIUqSQORg0w6nlkqGRl6Oi7RK3mgPdugoJwJY3KF94+Ho5rl6cg5HfYQ9?=
 =?us-ascii?Q?beR2BCsMLaQK3qqbeepvnw2NrNh3G+oC7L7/P2TSI4UB4zMFtwe8NceVyfMx?=
 =?us-ascii?Q?nJNHvaRUsC4O31rgtQxv7fk1Hw4iuaf9xBYzzk/3oFmSXWiiQnHDAskMT8/R?=
 =?us-ascii?Q?2D1by/HlI3gB/tH2rOXAkNWXpg0hU7caQNse3W/pbgTBDtZoASywTgx2vhEf?=
 =?us-ascii?Q?gTLqo7F/Tdny5RoYs9cjUMugnJ40Q0SgF3j/H/aK4kwlurTHQ3yTCoeuWota?=
 =?us-ascii?Q?2fLJVimhnprM4f+U6EdpzbgMZIaW0fFWbjkjpDTRg7tIza+0gkVpU0Cs+b7J?=
 =?us-ascii?Q?LP9R6q5wU1MnsRsuHw2tubcyiiwxwZQu9jy8HULXRuCsCIMNVnJWUZg4vuEb?=
 =?us-ascii?Q?ipMPhD3iXNYk0If5JqJIIWgAU8cnUyO0qs9ZbgYy4yj67ejp0BNnuQgQKWs3?=
 =?us-ascii?Q?iBmv+1Fta5b8DAFJ3pvZkkK67pkKZlmZgu65Nbxw28H86M897FZtsrVdur4p?=
 =?us-ascii?Q?EU/17+S1ColG4eIWE7xb1aG9qy15Ixi3KjrMuU0n/LzuHaIzTso9Nzk06lZb?=
 =?us-ascii?Q?AkbOXouGv4XHXT56PctLxY2AlWTsa41fTqz3/1UMQoHkte3fQ5G2AaeG7Ink?=
 =?us-ascii?Q?Y9OXgniszj4JSd+vHgKdSVGTDMlmdcnEpjSMjTOwsgsFc01We/6p8PIzvcVv?=
 =?us-ascii?Q?Gwy39NY2iKlgjQ9K1tzIu+oX75yBrl8ZuNyBCH28NmiVYeB9BRHSieskCPSt?=
 =?us-ascii?Q?QYRVLax56N3tFEAgBoV89xEFPUajUe+B7UkwcCkdTuemotpb9jm2BAKcKIF6?=
 =?us-ascii?Q?Va0SqKikTXZ1Xm0NBlye0mEM8YNyQ6/3e0TZLCnAHx1Rhp62/L2StNosE8g0?=
 =?us-ascii?Q?yMx6YssyTCY5xFaMVpHWUW45aBpkYNdwFuy6BjzCZDUrgKj24rtvzCd2aZ1F?=
 =?us-ascii?Q?T1a97C0cq1TR4ZeuSkQruuWKR423cRxfHCI86BkJnSdB+PsYnqynYY8MnS6O?=
 =?us-ascii?Q?TMTH1cHFHy547tihBjY964Zzuvwk3M5b6Ni5NlTAvqkNpO5TlQNi66IeLuMH?=
 =?us-ascii?Q?71aNxiUwdogDCahSfsdMqaTudb44GOh1PlUUxgpIlgRWAb5zch1aPwfBW7mc?=
 =?us-ascii?Q?vxDZSmxLISqpXF2xvw/DA+tXTqLBcDaUmFZbhO8CitYTfath+aNQs5++AGqg?=
 =?us-ascii?Q?51zOP1EHXzUqj4mtnwqe7hiylnsQJCV0yg26/2hhehzpQkiqE3zJTsfXCYJG?=
 =?us-ascii?Q?GE/QpxhFeUNNHGm6uy/pFPsftkRQ7B33Ise+WCT8R8zE2ogN438KUxPebXqJ?=
 =?us-ascii?Q?zqjqQ7Dwi7bFB9MXo3+AWcMIY8ii+0s7MWHw8agldxg2dgi48BoMlKSOXunq?=
 =?us-ascii?Q?Wikipyay/YT/vy3uim3FhdfvmnVPCB/dmgCRACj77Os7+QZfEngTeF3Vu2e+?=
 =?us-ascii?Q?HM/fpII4jeb+8gVaIwAWlZZNt7xqey5XQ23yhkaudqs7IN9QbZ0jOk1T3BsB?=
 =?us-ascii?Q?cde84vQ4ZAoi0LVztvN2CMd2bIvJelDUpzbTrUD7PGq1woUjsrPXHcqyKEzh?=
 =?us-ascii?Q?TENrDCxyeQl0zt/2Cf07gMnb0t1JjOWddjPnnbnbA4H8fK64P5VPL6U5Jgic?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wsalcPd8NdxS5RFUOmPGiDzUv+oYrI2sUfDgJKpcltIrFEkm79NtrMtXja6/hggSIXK2QgLnoc9Ceb9Ty9dOc59pmou2in+3/kERQOUDO1nbprL8T4sE8SyPidx+MjVx2jvoHDBuhAIeoMeDNU4D+2uy9hnuQHysfaDTeDkM33OMfJWRlBwfMQ2ZtupO9X4y7QP4mCgnKAfRAhVW65Rtc1OkrNdj3cWsEZ7527Jrbq5vcwvAfEEEfvKd+W59hWkGb3ZT1Bp6pGz7jUjyOVBwKBp0KxrlzDySXOVrQ1US7cS0eC/MavRzeAgIx2iGM5/pKuHBlT9dhT6J8KkezmrHAuEJaRjNEP8U9QpVVc3EF61yTfgpEQTw6VZkxtBHKGtKqWwWzDg5zqkDUgIxFCPf04cz3TGYlrVkl6YOksgZwu5IKl0b0Vx/cOZr2xXltZpwp4QT6yqGz8ewioJ25EQA7RZq5Vm7eDB+T8/W/fd/db6URvdIR7E6UhAQy9mB9GN4B+JOs4QOHZTKKhnVYSn9BuQyKC8UEToMr+Vnl4oQ+Ppt3XZaCBAphuJYnSpPsItGpb8RgqE6wk2EdqAmarE/aSSVviavRlLDoVs9W7QQs6w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c9c58a-132e-44f3-cea5-08ddc5133ec7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 09:21:00.5437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WnPDvavdYzNEe6dwunczKCe0pqSWEyuW3mpJDIO0x9y8ckbHu7qzqs9/tJMMNuKbfP93wxFa0e1pFl3n10aeiR54bWF+0eJtFzxoH1vCDhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6778
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=712 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170081
X-Proofpoint-ORIG-GUID: NN4u4JvSOjE6opFelgJHkECsZODrp7f-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDA4MiBTYWx0ZWRfX/pXsXafh4MdJ POgk3ECPi48DjV75d7CJgff1GWXTi1lG/HSEWHZISrIYNRj6lBdtp6skrex0tM/MJ2mO+ebpk9j 9ND964feWFt/h65a15u/oJWS9cO8Sw6NY2b6fPQCyJEjkLVw/oIay3adriSoFVCqLZU8hhDv0w4
 e6VUmC2rOIUuT/nCAAzeHlZmt60Ql7O3Oc7G9023CCNMV0VTnuHbSVX87JjDi4kgIzhj19ME2pX im321Skc1b7NrwowbwDBxpwWVLpSCGVm5gUYhm/S3ob1w1xpg2tjOLhkn8XAQdO9alZ1mfIafD3 sWQ1KVbfhvSY20age0+88T3/7a/nseziknzeTso89wZM6zbL1qHn/Lz3pi80fwXalEJwy9SVose
 dYbqVM4+/ixUfCRqg/wMd0Y0ofg5X7UNcO4IsxHQGQ16U5NCrqMn7PW3fBqLKXJ8nOG48jXF
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=6878c08b b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=PFqfypgZAAAA:8 a=iox4zFpeAAAA:8 a=RIyoVIlKZhAhAO5SsjwA:9 a=CjuIK1q_8ugA:10 a=5ui7DTw2F-RQtU_4I9DM:22 a=WzC6qhA0u3u7Ye7llzcV:22 cc=ntf
 awl=host:12062
X-Proofpoint-GUID: NN4u4JvSOjE6opFelgJHkECsZODrp7f-

On Thu, Jul 17, 2025 at 10:22:47AM +0200, David Hildenbrand wrote:
> I recall [1]. But that would, of course, only affect the RSS of a program
> and not the actual memory consumption (the large folio resides in memory
> ...).
>
> The comments in the code spells that out: "inflating the RSS of the
> process."

RSS is a pretty sucky measure though, as covered in depth by Vlastimil in
his KR 2024 talk [2]. So maybe we don't need to worry _so_ much about this
:)

[2]:https://kernel-recipes.org/en/2024/schedule/all-your-memory-are-belong-to-whom/

>
> [1] https://www.suse.com/support/kb/doc/?id=000019017
>
> --
> Cheers,
>
> David / dhildenb
>

Cheers, Lorenzo

