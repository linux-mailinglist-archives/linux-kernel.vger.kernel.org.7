Return-Path: <linux-kernel+bounces-760387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7169B1EA8D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F75CAA02AB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2573827E04F;
	Fri,  8 Aug 2025 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="puPQIl82";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c9hOaIsG"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B92282FA
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 14:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664229; cv=fail; b=AmwGUJ94mbUfmL5bNI1/Xaw6oaPeHIWJNzIFiqGAnjQmkCxV6pLbcNNYSPHal9D3CNlNtYmAatZp0pxPhVp8CBJoj1mPtugGZV+DopBD2faJazYPllUA0zpBewPN4PvnuRzdTiryi2mUGhg8V6NUUba5YHw6Zh4Lexfg+rh2rwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664229; c=relaxed/simple;
	bh=h+9jifE4g8G1tZycRa9MtGwZmCG6Y4+hUC8H7bHIAe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CtMvkMgw3MRnIg2YRZNcVhODfpZke5G/AiF0QCRCqiqFiQfM6BxIm8TABUP+EPc2P0FAavL/vTvjYx1bA1e9l6caOMiHXUf97RWH304PMsdfgqngk8QtiZ+ENfZ1YhQ0lKR4HGNtPLmFDf2EcRA79NeBkpX51Ic+tnRBCyRacoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=puPQIl82; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c9hOaIsG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578DNRj5014640;
	Fri, 8 Aug 2025 14:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=h+9jifE4g8G1tZycRa
	9MtGwZmCG6Y4+hUC8H7bHIAe4=; b=puPQIl82jolRzPQYTbrgfW1IrSnrfyhjLt
	JkCtoyOHKTdN9A9+HdMc3UNN9VZh9rE/zRP6q/6XwJtj4hHxwmRjUJxgJiS2XBTP
	NO6keRHBOyU3XWNA+KYBfrlmgPEVguVlGxghwgwatkOtFLmGg2pKbPQUL7X05dJX
	ly+mK8n4s7k+qzVdYbaZjR/sKQnJjjXHrOgZKm3AvYualYjDK5MP8CXvN0KWV1RY
	ZOzQq2jPRkly8QCbVJTcJf4PGgz0zdu1X384jUBcLOlNbLnu8GbodaXVoCAMXl9r
	5fbaRka0MdJE5IkgV4e5sBavzSuZ8YnboXnzAeEZw8QLKDFao5Qg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpve6fbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 14:43:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 578E6wvh009907;
	Fri, 8 Aug 2025 14:43:33 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwptxc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 14:43:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9A5BTsqI9UTpoPk0tUA/mf4cWG9XSizlT9aVjV5Bz93uK2gMVvKeb1jMwslQQ90GmC/rnvaFhkmuzycU967v6eKaC3Ql1wK5ptC9t7G9MyiaXwJuxpgHHB54YdSPw9y3te9xp3e7Ki0og8JIx53jmhJ1xe14T88ywKm3AOqxMtzdcj+0z8AXFVvm5iPb+sttVLJQtkPw5naYLdd6LbYoQLxM5b9ka7wVEKk0MvV7HBW9C/65S+3+9zRTKDrP5f04Mz0wiBwvTDtXe1SmaJvpXQvwMAViAqo2VDuJgeEm7v6zUlL5uO7Tbh796pvRlEqAbxaJnQvcKLQgr7NMmTJOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+9jifE4g8G1tZycRa9MtGwZmCG6Y4+hUC8H7bHIAe4=;
 b=alZ58Qc2AnvUS/cYYdyzapWhDG5cb0l7q9SuAtHfqbcpJGl1F4LFxOlkK8a5BAI3DO0rvc5cXYQ8dGWFPe3SQQTh7o4xPDR9jnVTRfVBfLXOsPud07ha6k0ueoS5pQ+W9MVJU0p1iI+tKqLW471n2fSeHB1lQNmyVeML3Txah75gcxtez+C2voVCQzBOAhi87ze8jJM5uUtYZhIqXTP3hWbjLd88YzizkeZwZG1FOYi+XCLZqS8jLoUiyMZqx1n5B9BzewXjaLgVgfRjRUcQSV+yKQQMFQBbpvnyQsI43gr9Tf/GlrgV2x7QOsUoGsA56O6fV6/wBafEEWswFwSezA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+9jifE4g8G1tZycRa9MtGwZmCG6Y4+hUC8H7bHIAe4=;
 b=c9hOaIsGAi9MATDdsQjY8td6svMEqrWRlFn/OF1fbi1ZrvUV5I8eZscscorfv8BXhPEQSyH1t7qBnOQ2i90ZlpogEKa1bkXR3jFEzRzxFV4JUmbTCFkQHkEf5RHLLAnesnpbH8FkQ+cyt1BvNp+UcdpEoNOSJCEdCoQ4GLPa9lI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV3PR10MB8058.namprd10.prod.outlook.com (2603:10b6:408:286::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Fri, 8 Aug
 2025 14:43:30 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 14:43:30 +0000
Date: Fri, 8 Aug 2025 15:43:27 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.17 2/3] mm/mremap: catch invalid multi VMA moves earlier
Message-ID: <df80b788-0546-4b78-a2fa-64d26e5a35b8@lucifer.local>
References: <cover.1754218667.git.lorenzo.stoakes@oracle.com>
 <2b5aad5681573be85b5b8fac61399af6fb6b68b6.1754218667.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b5aad5681573be85b5b8fac61399af6fb6b68b6.1754218667.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: MM0P280CA0109.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:9::7)
 To DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV3PR10MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d7bb36-6838-499e-1f66-08ddd689f14d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dMKZKH2BeHYe2e3SMXOf948nAkGT4cEfFOURTXm1jbHwe3m7D6fI/5+AVmA0?=
 =?us-ascii?Q?z6EC7ePcyvCevVFY08YkNUDtx/HesdMOZmM/dTU36SYsQ44O39OQhCttvtZt?=
 =?us-ascii?Q?uw3ihea+QVYoPbdWl6DMwQdbye25YuU1QaXlFZgRNDhUTRAu6GcylFfAAn/4?=
 =?us-ascii?Q?uJw+jmWCQcMPodVejK4aLxFe7pJWrpdrff6WRZsltKhfsV0FRH7gAZ0AGMHA?=
 =?us-ascii?Q?02ioe8JZ0IuNUUjTGJ8yx2/DgXjcvLr1JJP7inEl9h1qUUdSSfZbFJsjyK1N?=
 =?us-ascii?Q?6joHRptFmzq+ycwQqAtnHxOLODCk3Lbt/w9usTEKvBiduLZqRm7FTNrCmB/S?=
 =?us-ascii?Q?Epdw/G8Z6fPZ7nHFB4vdIhtANmJkybH/myY4hiGhh86lmZT34q5VqByZk0pk?=
 =?us-ascii?Q?9gi0TVkj/6PlGE1CfXzerT8XyaitZf/v0kGkGyRIpBnkk9OSSDRjtzXfCZEe?=
 =?us-ascii?Q?8E0KXWJFEn6+i1pdzYIVvAI0Rw0QCXj67kNDJA2XMDiv5nB+pXy53nlachbZ?=
 =?us-ascii?Q?XgnvIzcZrhO/Zcz3v1sKcKDQ8zsv7FIHchrC4AbULRyQRn1OhNHdTvTW6Z3P?=
 =?us-ascii?Q?JKoYENPRS51XVC2ERz45HfE3nZg78sqw6owTwYWqNcy2as2lcUHC529uZzXT?=
 =?us-ascii?Q?/z69+ZHdyjAKA6jKbSxa4QWkcQmYYL/RvVGUXWUCF15pvptYQ9FYd6iKmGKV?=
 =?us-ascii?Q?X/yWG98yJ/tpL1vTb35xgD/AMKsDfEW4jxit68UpdLKOCnsRba0G8YSSlLU6?=
 =?us-ascii?Q?bBpBIrYQ2vvElX2xZycVVHluHKSyHrT2VkYGlJvjdj+P0NRHGkMuCFXetdV+?=
 =?us-ascii?Q?wE5Z5IJXA4d5l5f/l+40atj6HaO3/GjPpEUewFg/3KlenGsAGW2GB3usCWri?=
 =?us-ascii?Q?RVJTVjde4giKU8i2oJpDK33+Jj7AuCY4deyT2QJuFYWpGAidV7JnwrHncxAe?=
 =?us-ascii?Q?AkLRC1Y/97PAabCKkQBvIa9kCbgltPlpjdDyi57veir9klghMnn+08dsNrHx?=
 =?us-ascii?Q?k988SoACJ1RxcUG07iB/hNJtnV27HS6BxRUkpAkD5bUBuunpRDppqKMmQq3J?=
 =?us-ascii?Q?MYCV8ggnCq8aiBRtHe5A3nuZ4IK5cR/DaF84H27sipycFP0wN3s/dfejspnC?=
 =?us-ascii?Q?+06R3s2VtjI9wQW+lTrqS5GQTojp6Rl9VS/MLAt9TAmho7lZoA1Sqb0YyrYw?=
 =?us-ascii?Q?2Q9rcRbx+O4R1VA5IWCRnCohfAeRcHnm3hUBdkYZI763SFbTihP7oKEfjOuV?=
 =?us-ascii?Q?NuEMi4jF2YDxWOWfHGaBUgK1k3MD4Qwm07givJ9Fh6pi/Vg+RHNJ1M7/tk7W?=
 =?us-ascii?Q?BEr0aopPXWTAyg5+R768nW8IQd2krYTHwI2XCY9gKXlA0MBUi+otnWMgaJ6M?=
 =?us-ascii?Q?7D2qclmKIfRgRPpY4bWbRykx8ERyCo6P1z7Mh1OnoHvPhYxpDkigRhXwhjPF?=
 =?us-ascii?Q?LIb49jnmOn0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9f2nVCacR73/gJWj/b0uQGwAN+1PkWLu9BFW+716NaAaMeVAcNc48njCgIVF?=
 =?us-ascii?Q?/bS8hGloW4O5P7XbXERJUcs67PeXBXUs4g1SOlTyZyoapMeWFun31aC7MNng?=
 =?us-ascii?Q?fzP0O8kXziVVF1lWbPKC97Pm1ueAQXOuiFpF3YDzCWB8cfPpf3e81p+89kCQ?=
 =?us-ascii?Q?FqLPKxXK8QpDcMp9rXzLntU9ug6pR3XnUtkKW+VqEob0sYDSNQs4nMwzPWGk?=
 =?us-ascii?Q?OEM55AllSNguC03MHta6DjTU1B9JRdoGZJnkfTM/BV0wKW3KN4FCncGPaDtU?=
 =?us-ascii?Q?czzOlIwTDxbj9zcMd1xt+T3WAhvFFLCkVfmslmlTQMpatBVBcmLQUEYP0/Ex?=
 =?us-ascii?Q?RNX7DgslM8Y9rZTPwOIRGJSuW/d/DuyiRHBPL6bhCDVu0XI8KvW7TePI3n03?=
 =?us-ascii?Q?Iwgc5wS+NturV1oZmDYP3gcufhBAAJXCuu60K5raUIsDyFHN7WRuxbTx94cX?=
 =?us-ascii?Q?yyvn+tlbDZRB2L24bnrNIo7ZDOyPGjSP0kAiGVBTqhxHb5zC6Om3rtJczFog?=
 =?us-ascii?Q?+4F6+HbRYwc9a0cz/p76WHaepYal+9zNndtIvxLYAw421ozYjACYJmW9ZLPu?=
 =?us-ascii?Q?3SHu/auekTFnabBUfSl5P1kmK0Tnp9mNdSM/PCvo4galB7seZ4SevdoY8Djc?=
 =?us-ascii?Q?7jYf9xExL7D4sjJrbQSqN216zmY5F74Kc1Z1zSSjquis34tZr9nIK5ETfu69?=
 =?us-ascii?Q?qeQK/5jJSrqXefg8hqmftBZQDQFLo0W6j4n5vb4jA3Xi9egLmG5QJ341pb/K?=
 =?us-ascii?Q?12gPEBegGrBIETpFuUNZ+Hnk3ro8irE83G3NAv6NEuwibTvgvx3ynwNfOlz+?=
 =?us-ascii?Q?AabXsxrA7TKYSM2KYPJpo2CwSN5Pf0IAUrzLi8n0s/tCPsqhroE1af8CceX7?=
 =?us-ascii?Q?HJ8WfUiypptp8v7D8uX4gckt7Y5MNSyyLjdzwYJ8+d9eSUGEg4dgCX0vEhyf?=
 =?us-ascii?Q?TZj9EQWFRVBSOHDGLHOm6fjYwJOR2shsi+syDnb8anXKJeoKyFcccEG38cQx?=
 =?us-ascii?Q?H3JDWo8Y5o+YmLlsMlY97xyTZM/vrLy/k4/ZtTxHn/pGx87wf9piuGjgkGxD?=
 =?us-ascii?Q?xGUi5+TOoyzv+GTzBWQ1D/+mcBVvP+s3ZoNvqNves60DwcFPvWOWKbhTuYZq?=
 =?us-ascii?Q?tHqXZ7lO3ci86aOp9o2b+LUJchC7OL16p5kzMYezkCww0LRr0N622bkm07XJ?=
 =?us-ascii?Q?4pn9k4TyA6QfNFesQU+sOF3LulD8qekzb31ZjjQU78f6Ey+/nkd+O0febTo7?=
 =?us-ascii?Q?mbBCr2JmOv5DDDdWWBM9ShFC4wg19zMKYXthtn6WUCOllHJ7kM62THg2dMOW?=
 =?us-ascii?Q?VLAsl2dm0KHD17NGOGbOnnLOIGHpJ4jwSXu2vqEcgVVGb9nPEhxOLAQvqwNi?=
 =?us-ascii?Q?r9CTacapzviXu303+zHwvYsDU/aivLBpbgkIcZ57vQ2VwO4zgDEZDf50Vkg+?=
 =?us-ascii?Q?QPmSlZtFYj6V+QTUBS0zqO+kMJY0oYlpqNj+qRAX43uZ7V2xR4epNanLjnzz?=
 =?us-ascii?Q?RePNzD5tQdyHJCw2txuBRKPEBpqVmktq/SIfrNf/EhfCJ9fUVD5a2/kCQgl1?=
 =?us-ascii?Q?v54bbf4fEIpOx4CYRJ/I3RQsy7w0Xs8Rrmp6vXclYf+Hj+4cUxzAKWxzt94E?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vd/rkf1yN9zUVphqpwtPdB2YB70NxX86HrDeMlldTQK/Qka1raLesNOGp5g28K+cRMI8RS061yW1AvZ+1HvhglZy4GjJQSmOYpVe2b5lH2g1mhOpyyToYGHrOmUHhI5CckgzB5+eCSGNdlXkrhrn5AyCrTYPb49PcggGH5FbNvgbBzijNrW3/dXB6cMuDRdwY2Uqh68H50uoUOOY3D5aOwev/3ZT94qKW6V0Kd8BR9+GcmOTzF1xKjfl1DoUHeKj29Gqwwo4pmwN6kh4cdDzOGFxg5Qmbc+Qsp3aZjV7ZtJ0BhXB1tJiIAq3PK4CY338nRx59a3aHsrcGqwn6th8EMCIWbQ7dqD6JRjVtZWDL/IctPpzIdiYNOlNkyM+DJMu8p43BguttcztjaHJBqG+3O1eApbvRmz85yd5ydTZU1zjtQAVArI7N6+fCLVGARY/YY6hmwuVVdaT2F8Or59Xy9nHaze6fZyGsPgm07ZqDA9KykwFeijiflBEmxTlxNFFwooQErOgvFTgm81NPdJ71sd/l07keqbqyArmhZSZhHA6NzTh4YuP4VUqJqd6qfJF3/b3fJqafPJs6kYMwGWB/HViwatc5Ajp6+i0Xysj9og=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d7bb36-6838-499e-1f66-08ddd689f14d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 14:43:30.4381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zDBm7tyuFF7pMFmud11pBu7FtLc8BRlb8xYME78kDDtQjgV6lZD+LwWqy9s9Vjfng/pcSc2Fff0gH7xpYZ+1QPPG8fFj4G7SdcmKfwC4PQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8058
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508080119
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDExOSBTYWx0ZWRfX7rxDGW/gLMlZ
 oFCfvxamg8IXglKYszEJ79IGVdI+KJKCC9l/hmmgyFwXE1cGTo9N0xOZZot+XivXMMqxekZIh8q
 TSCoq4McAaDbgcZI6s6GRirwo7Xxsj6XQQcTW9pbQ6kj25WS/kdC5vWHCNIU75IzHlHy4TrGDsu
 1f8SolV4P290hy0n7jKvVkwx55eBREsn92tUcK0kBwJ4jRulmB0+z9u7Kg136aMSixxsm0/0ed8
 n25i2eHb5es0ulbCRUOdscMD1/TxkFZ2t7or1npv8AubNWvLsE3nsM3Y/+Ny2WfVeZ58Rp0z0lS
 jKhHKG5c5XvO1mmVFrmwMUgK9wkJErgUChNRyRbb1ihVW8orOO/voPLOcxBCHd5EpzwhR8vph4v
 GFfx+iVBj87JJ+TOLy6xsgs3kwMrWqyZD6YfnpXpVGmNdnCr8zo1HfiQlvuqxcMYea1dZRr8
X-Authority-Analysis: v=2.4 cv=ApPu3P9P c=1 sm=1 tr=0 ts=68960d16 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=dcBggzdMNExk7EU297YA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: H9QCm2XPWMvusPg0-swnwHPLAT7G0kWF
X-Proofpoint-GUID: H9QCm2XPWMvusPg0-swnwHPLAT7G0kWF

Andrew, please adjust commit message as follows:

On Sun, Aug 03, 2025 at 12:11:22PM +0100, Lorenzo Stoakes wrote:
> In remap_move() we must account for both a single VMA case, where we are
> permitted to move a single VMA regardless of multi-VMA move eligiblity, and
> multiple VMAs which, of course, must be eligible for such an operation.
>
> We determine this via vma_multi_allowed().
>
> Currently, if the first VMA is not eligible, but others are, we will move
> the first then return an error. This is not ideal, as we are performing an
> operation which we don't need to do which has an impact on the memory
> mapping.
>
> We can very easily determine if this is a multi VMA move prior to the move
> of the first VMA, by checking vma->vm_end vs. the specified end address.
>
> Therefore this patch does so, and as a result eliminates unnecessary logic
> around tracking whether the first VMA was permitted or not.
>
> This is most useful for cases where a user attempts to erroneously move
> mutliple VMAs which are not eligible for non-transient reasons - for
> instance, UFFD-armed VMAs, or file-backed VMAs backed by a file system or
> driver which specifies a custom f_op->get_unmapped_area.
>
> In the less likely instance of a failure due to transient issues such as
> out of memory or mapping limits being hit, the issue is already likely
> fatal and so the fact the operation may be partially complete is
> acceptable.
>

Previously, any attempt to solely move a VMA would require that the span
specified reside within the span of that single VMA, with no gaps before or
afterwards.

After commit d23cb648e365 ("mm/mremap: permit mremap() move of multiple
VMAs"), the multi VMA move permitted a gap to exist only after VMAs. This
was done to provide maximum flexibility.

However, We have consequently permitted this behaviour for the move of a
single VMA including those not eligible for multi VMA move.

The change introduced here means that we no longer permit non-eligible VMAs
from being moved in this way.

This is consistent, as it means all eligible VMA moves are treated the
same, and all non-eligible moves are treated as they were before.

This change does not break previous behaviour, which equally would have
disallowed such a move (only in all cases).

> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

