Return-Path: <linux-kernel+bounces-823435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E5EB866C0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A680161E83
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E960B28C00C;
	Thu, 18 Sep 2025 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EWUZJiTO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I5enh4rw"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316A234BA47
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758220390; cv=fail; b=OEUyiUeRVH6yiAXOwFa9SmgLyRuWD44SBVkbmce9E3QuSpF1DgWF5Op+rnSPTp5og/Nnk10VMbuWQaE3AS8kjBzixHVjWrRaOfCYkoIne9jxA4KpvQV6jC0bYKdzs6ngu9gtRnZCPhqfUu+sEAbM+IayaTB+1WjhtS29ASzafmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758220390; c=relaxed/simple;
	bh=eS3G8BzsD5C8vqXV+Sg9X+uTqDAMs5c/w+ELPSi1RGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t3MbxffWZIoQmvt7UjT9Wb/OKlZZyYY7xEMIeh2oWZiDL5vh7u+AYzllaCgRTbcbmrvgSystdJ9s/PCCmniw5Ucsf4fEdJXE8ibuJiaEpKbJtIhXKavPc2OvlbDtrqqsMNhycl5QmkY3XLiVGlmYEs16qwLiBVKr+DaOQQhXgY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EWUZJiTO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I5enh4rw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IGHmx1003450;
	Thu, 18 Sep 2025 18:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=jV44iazHgcNFT8W90m
	0AoacVoJuzz1jIyZg0XjQURRU=; b=EWUZJiTOZWC5josP4JA++Kcjf84ICx3Zr5
	AIoNpiFektfE3BKSH4sEc2IX+75hCpXFSjeTQDw5gmPv9KrAqELgCyAEsHBIRbj/
	X3UETP3w+67a/9guQ5NQbvw5Aovtcal+Za7Rngexr6L22YLJPHM1ooVgLA8i5ARg
	8iwD5I//9S/y7H8QuIDB8SVH4uOoleN4rr6JRFhulN949p95xQVEunFSmLXBjSMl
	NkZofPMCy/vl/Y+pTzHTvuzjJSNg/ZN1iu5km0M//atzLbdLmXZfJR9CiiAxTh4u
	kc7eQwAR0b+UPEFjYyQEtGcLdTnNYq3aFjnsMSmEE7OKb+w2CtFQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx9437s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 18:32:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58IINeR0028734;
	Thu, 18 Sep 2025 18:32:39 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2fj0v2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 18:32:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Afzd2M1fyUxmNum7sf/LSYbPYIM99xJ9rPSNxCl4P3c9VYt0xSD/issPKgMzT7e4DOjXdYf9DriThANAWpKSd5kZ2FShYLZojpiiy5BpC1EBZ68pucPZQr3BSYTH+d1XmLiceoJ9CfpBojnM68Ey0v85BBXwefjUOOPzAH2OAT8kwS/po9qmGVsOzYbKYTqfQtCJa59/WDzJmtMCSQscW2ngMEpSyQnZOe9BgbvVMS6O1tMUwOJPQvD8XX5qHC7P7eMWfo6cbOI8JCTaDu4ODckjMrp+DjNYVI7Nz0dEksPxdwMBEgDlIvqwcEQ8feFGpdBpB8e1hrLav5KnUaDx+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jV44iazHgcNFT8W90m0AoacVoJuzz1jIyZg0XjQURRU=;
 b=XP84k+W2T5nVt7mTI3+kBNE2+T1Bf6aRreqP1oK5iJnyVO/y+jCedEoadtShZLk/k+VTaSYxe9jI8uT4Q50Ae0mvilq3MzQ9J5OfL5dUeduzk3NBBBSnnY+0tlOC9zvI1koUT+o3bzcSpE1oJ0MRWpbLi8nD1aG0GDkOKlyLdyg3nJcGW7SPv7yQiTa17+AJ679xktcynI45iiTHtws/ggly1tH5ABcxNxoj+NpeXMIpxfNVRDGEseEHtHgTtArX/4O3V58Uy91dAtbSlwdsmtlRp3cmfD1/irqLuX94rnfbQdRib5RDR8Y5QpM1wwRU4YbsBaYC5WDiH8BJClFNHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jV44iazHgcNFT8W90m0AoacVoJuzz1jIyZg0XjQURRU=;
 b=I5enh4rw88PKek1kJWh3FsS+RvIJurXauyK9IXcROt50nnkRJERLzuEuVM4RgRZSjhhAStXTc3vU5nT8QQKfATrbmRb2/p772nlpJMMmBrU9FoOAwm6E1ybx5gWdK4Ik0RmNsureCGtMhF6X8UzqXObJ1mom+UZ4D48Emj94s/Y=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by IA0PR10MB6795.namprd10.prod.outlook.com (2603:10b6:208:439::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 18:32:36 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9115.022; Thu, 18 Sep 2025
 18:32:36 +0000
Date: Thu, 18 Sep 2025 14:32:31 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Nikita Kalyazin <kalyazin@amazon.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <muchun.song@linux.dev>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>, Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ujwal Kundur <ujwal.kundur@gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Introduce vm_uffd_ops API
Message-ID: <2rkvuudmsf5tv66wya4f7m5niwnodu42owzmro5jzyc4fcep5n@lre7hir4qjli>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Mike Rapoport <rppt@kernel.org>, Nikita Kalyazin <kalyazin@amazon.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Peter Xu <peterx@redhat.com>, 
	David Hildenbrand <david@redhat.com>, Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>, 
	Muchun Song <muchun.song@linux.dev>, Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, James Houghton <jthoughton@google.com>, 
	Michal Hocko <mhocko@suse.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	Oscar Salvador <osalvador@suse.de>, Axel Rasmussen <axelrasmussen@google.com>, 
	Ujwal Kundur <ujwal.kundur@gmail.com>
References: <289eede1-d47d-49a2-b9b6-ff8050d84893@redhat.com>
 <aGfsaIIzHWfjcNFd@x1.local>
 <e7vr62s73dftijeveyg6lfgivctijz4qcar3teswjbuv6gog3k@4sbpuj35nbbh>
 <930d8830-3d5d-496d-80d8-b716ea6446bb@amazon.com>
 <jxekhkhbn7uk23oe24svxrs3vfuhseae57sqagndqgh2e7h33o@kfkygmrvjb5n>
 <aMp-kW3OLqtZs8sh@kernel.org>
 <du5pzxmfk6lile3ykpaloylwz4eni6disj2oe25eq6ipzqemiw@ybcouflfnlev>
 <aMvEu9m7fJLnj862@kernel.org>
 <4czztpp7emy7gnigoa7aap2expmlnrpvhugko7q4ycfj2ikuck@v6aq7tzr6yeq>
 <aMxJ3inEs_RRyqen@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMxJ3inEs_RRyqen@kernel.org>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: MW4PR03CA0219.namprd03.prod.outlook.com
 (2603:10b6:303:b9::14) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|IA0PR10MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: f6bab216-a7da-447e-5532-08ddf6e1bd43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pa2l0jKTIVBH95Dj+FqNOnn38OYAgeWa7WGtSQ8/e/pmLM6Sa+W3sHUra5Uk?=
 =?us-ascii?Q?a/IEfJHG5+jg77cTNYCDaL+B4ywoeAdu6pLvGPc+kXXrSMslChocerkXXJCo?=
 =?us-ascii?Q?GOpGBAhqzHgkRZ0eX5Y0YIzrqkCPdotpzAz9uIP3R2rrcWxANYcXzsyZK/cX?=
 =?us-ascii?Q?VuuDofPWGnE0IpjMtCJdK1rju9Ezh1Eo9c7jbf1MNRR4v39lCuDq1CJUIV1V?=
 =?us-ascii?Q?Dg5j4+eirY/q0fkRi85Cll2c+7Ys7JL6XrD5+olOJ9i/SaGuPTpbsNnn3v9+?=
 =?us-ascii?Q?i7uImz7h7PA9fqv0xSp+V1Rf/kA6fKXX95Gr62ZjaiIazkecE1T0Go1BDayf?=
 =?us-ascii?Q?oJvWskJnuuAtyVUmpAn1KsVIUhbUyMHz6ECjbx79xbVz3zdJmN6WMCTtrsTR?=
 =?us-ascii?Q?l5JLP2qSVyRi87JAQT5qcuMq1cqPERvn5SvscpOWI02g21ftoVdzxcFkBuh+?=
 =?us-ascii?Q?z7c3ZCpcFytdSxJLIlN0HUuyGRsVspyWuH9SQxvfycIe8raM4+DuoWJ2OZph?=
 =?us-ascii?Q?0/+KEcfB67YocG9HLPwglPkfn+CNiLfP7ePBv4NctwttW8jE7IzsNZUoS9VI?=
 =?us-ascii?Q?g4Rx1nVRJEn547SfI4DAMvMS0zr/T9FoX3XNJm5U2H1TLWEm+fumZaiGD3Sb?=
 =?us-ascii?Q?s+LR1Z/Pd9n9Ep16ZRx+90sBs8ZjhQHv46WbPfKsL5XGjDzXOcWJIHe9/GF2?=
 =?us-ascii?Q?7+Qg7JiPPD8rLH3M8LKIEmjSfYOZKg6SRo6a7Wsu8WBzUOovdiEcdXK/J3/j?=
 =?us-ascii?Q?X6+ZITgOeRBj3o4zhIiaZJ9nH405c7ChRjSD7bLtAV7R0fGtVTrcg9ktM/m5?=
 =?us-ascii?Q?OQ2WgcKUUoSToRY8knsyIVtQUOm1qhnBFa86c44qZzBOP7TBCrLMVF9KPSUa?=
 =?us-ascii?Q?7IBXdVlp0JATOX2ufes1Op0IxVuITlIgFUBfDRvK7I55wxtD/FIejKTt4uDB?=
 =?us-ascii?Q?F6rA5GxfRCCGiXuFtkz/OysWOjkAjOGKRXx7TkwN5pWiAqzyDU2tri5XUkIC?=
 =?us-ascii?Q?ZF159ukcXoNuP2ldgkp+aduTEoS1W/AIBMZ66+nfM+fW32fNmVm0otLqWLpm?=
 =?us-ascii?Q?N6F41aNTEPRGaj3i0xYTCtH0X9bCgiQ+W0KQ9c7A5eW/lQ4CS3TfXG+EY45R?=
 =?us-ascii?Q?gqcj1dN4uYSVGqzbKjrMN82kXApoUXKolQkRdiVrw73JmIX3WUPW5KZ5ZOwd?=
 =?us-ascii?Q?tYtNlgmUdadtXMF/OaEj1mNmuQrwjy8wm+V6pRJqHM/f88uQ49dM8xqU2SZf?=
 =?us-ascii?Q?zh/VLyS0zNl9npK5rDJJZ9pgpr/7Vx51U6UQLbghRkuoID/omIC0E9sApfd0?=
 =?us-ascii?Q?Cnb3f2LQkUqv9UyUhI34qvHQYY9qIK6CtH1zdHmPRCXUuKt3aBF9Sr0qvERi?=
 =?us-ascii?Q?p4BsDrzg7bbWaEZhwVSmJt6Sp35Y7VvlCQW/S8kBvZufF+vErLpcMJEwybBA?=
 =?us-ascii?Q?HlnL7bDRv7Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2MUpA/j8NVXHgsPuz2PcBPN1ZdpjApuMJHazZhuH6CYVZWfeyTxPhpc9/aED?=
 =?us-ascii?Q?r2/CZZJqf6pQg6NxkLWXPYK3Tv8fTRZK2l9fgFNu4grW6kyjxBlRJo3Zg0qI?=
 =?us-ascii?Q?GxZkNyEUAa8YAM+kmPqClK6qDTxSawoqc/nu0atdy3RxCw+s/5N1fxI/cV6l?=
 =?us-ascii?Q?Hcn/lfCUoWQJ0iZLUQPyCbO/1TLkArhbh0hoAeF+PQXWMyhizJe/WIPeAJiD?=
 =?us-ascii?Q?pMKRoJ60MxYoZukZ06USogI/h25BJi4AO+joUsURIalMI413iXgUeDi9XYrD?=
 =?us-ascii?Q?hFUICepGMlh2ZBs2Ys3WqyHr+mzTplPkfQBnglUYYFunF5DZXU4DzUw5NbIW?=
 =?us-ascii?Q?IQ3VAU2Mh0xPv6LDTtYHJqYW2qOr5oWr3VKsHSoukN1ICt99GDDNsX8Ldonq?=
 =?us-ascii?Q?LpCOODaQ8kEUNaW5jjPup5QXf2n/vAsn5p+g7f5VToXY3LseHycETPs7C4yC?=
 =?us-ascii?Q?rkZtiP9m33pTB9R5eTbJFoQJwKnJ/OlkqJZRZOn+11YTIexRU4uXVv/JnoW6?=
 =?us-ascii?Q?94XHTUGNUsa3ZIcoFCFkNa66tro4uKZwwOj/VJHcH9o7AtrRnKD0j6MdQHfZ?=
 =?us-ascii?Q?lBZf+22niWafWdQyRBPjZ5uHQ3PJ/80kDMchDWGRZvRzTYUiRnL/5x66UwWR?=
 =?us-ascii?Q?Qt0Kpxf1NOIadgWpNQeBB3wiwL60nycwxz8O67Nv2d78Y1Mcwt7UrM1B3osz?=
 =?us-ascii?Q?XS9d44t3uKoafg+Z3mdd2w4DxKq3HA42YXy2wX4xvulcD6MMYnU3Yj3IsGtT?=
 =?us-ascii?Q?6P+uqUWgoIIWrEE+zpPtDzDoUKj8KyDa2EsC7DSKxaB5IsuskqE+dLFIdEuE?=
 =?us-ascii?Q?qzR6T4Q2jKUUyBvDZ9rZrCkZoQAML2Yi1hLaJls3Fe0dsHwCHYU9InOiALp7?=
 =?us-ascii?Q?GRUnjvpuzlP1G+Oz4gJgs2Z+HQpzLLYWB1+Ak6iy8Tq2RO5DIoKjvMqDuCcE?=
 =?us-ascii?Q?pBhbY0AtQC/9oUjqYbllGyr5DEUwaaYSPQLtqBaKetRvVI0fdfmeFGMLucvF?=
 =?us-ascii?Q?26sX/mwrGJ1jx7zVkmjZc93tw/J/H3Vn4xOJZiudVBkx0ltMdpkpEzbRPHoV?=
 =?us-ascii?Q?8JYqNF3yz3QUHg5H4easJatACXPml3FtMSCkPodjVnu4A3kjI8+E+OCEng4Z?=
 =?us-ascii?Q?iiSsdOARf6NNN1baN/ZEWZS5wWw1OR3vK/+WQDJD/dzaOQKnXYu+nEeyqTce?=
 =?us-ascii?Q?ljAC/k/pEa+SabOwN7YwRzFQqBN7TVlKENNumtspA60p/9K6E3ERGbdifwL3?=
 =?us-ascii?Q?F6LzErSelHBEpgP8X+Fa/aXd8KokzAKpn3Za3oqQ6810MhIYlFACWv05+4Ad?=
 =?us-ascii?Q?jGT6IIyRvPNtCh8rFGcbGGgezdblVY9nfZVjSla+RGVv75lDa0xe8Y0vfnl9?=
 =?us-ascii?Q?Fh+pLJLwiGf51Nnq4XCQlBWyJMzTLJJF9zmznvfww4TJdrsTZg30VCYAPPlf?=
 =?us-ascii?Q?9l5bIYLM8UZ1+z2g2MGDtb/juBHwnbHbxAcn3Ac/b3/q3oIH4+hqxWDSdBDT?=
 =?us-ascii?Q?mzybIjG+zsuKy3Hn5G3PnZRtUlxmXuI0d3FBQXrSq/w0A5+UPzJMgXr3W9v/?=
 =?us-ascii?Q?VepXOI3DQh93bwIz0wLUJRAmxg405oV9VPx0UEWU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pxsRmlsgCXv/g7XPFcEy0R6s52kBTFGSXEBp5UGNa0NSA46joHiIqp8pkvipIBosTrdB1rTOdUfBZ6GmjBXuGRt4Ka/h596+YZ/SJQrCWEptk3c10s9hO08Y4UfnruambM1j5t0eJhdUSV1Nl0AmbDSHgo6Rp/ovGVKnuw67t0AmduIBLzwEsRw0rz7i8wTkpeMjITkYTH4ElZ+9D5DLAijPnFk5GN571cydq/TQJ1sHaDyEcGkQ4xl4kFyFa0F1KWDAgifQjciVGwmAFXVwDnYGWV4QdWyZijskAsI2uq/q4unI+Kko6Q7nHVtpCdzjMCWhifLNIq5+nbJohgcvH8I3Nm2y5WDI0lUlF6H899c9hHbLAlWAq5x7wXnntlJ11Vq+rSXCGOyUjd5tKePdp/BQ5qwMmXqflqsuF91GNhHJloMD/8ir3cK3VdAuMPBFMhogj1+bDYCXT7hpkuRKMhYCW6nuFC85fj7XwWmUD+pyHzKmoeF5zQAWC2i1dcbP/AQ32DkLKel7/ugpnpo4V0llqLZ91LnuwI56V+X6JCP95E/xX1g+af2ZjzKwdiVeePTnLUC7j/w2PsJ2/0ChKlJ9dks9dpraMiuQd4IJBUA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6bab216-a7da-447e-5532-08ddf6e1bd43
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 18:32:36.1795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FqJxwAsX/aKDPwCSEfRGfQfw6oiBfKvNy8jzN+HtyuaC8VJQplPFxF5zaTI4SfeRGI2MiLuEw2jblQnJKMdFhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6795
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=782 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509180164
X-Proofpoint-ORIG-GUID: o0lzETaf1CRCvG4lS9dwKh9vgRH3W-Ei
X-Proofpoint-GUID: o0lzETaf1CRCvG4lS9dwKh9vgRH3W-Ei
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX6Sz5v9mqR6T3
 Ap7bk67ewP5HCAbLBLAAPvZXtZq6eHx1XAd90WdWkoEi0k/hq7rkxxEe+fEVRV+ChswSDB6/v8w
 kkeUGDZ0VMVfhKex8nJVnnRvViGUYDfBIlnu5c3KUmbvWFRQiPU7SLgQ/ruArsD3nRZgz7nUB7K
 IDCzM3HJmFWDcvBjp9dhCJ+FNsdJLpO1B1ApLTpV+lgn1pfa+0DMSQVDW7avY3ktWiTHFuFkJ1E
 Do/oTeNAzW+AxdFEQtKIzlA2dHUfl00lj+xuaMbqy4AeRmXJQi6u1MaaWzX0K4E7vFcz2LUeAb9
 0NnyojFQZHk+iP3cpbA9XkXeF3q4LPeR4qoLrUhVrW7TnC+l1luomqHHPXHgUZA58H6BTnY9BdW
 m0c/uy2U
X-Authority-Analysis: v=2.4 cv=N/QpF39B c=1 sm=1 tr=0 ts=68cc5049 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=aABYaP5e260sFojQ6OYA:9
 a=CjuIK1q_8ugA:10

* Mike Rapoport <rppt@kernel.org> [250918 14:05]:

...

>  
> > I am under the impression that we don't need to return the folio, but
> > may need to do work on it.  That is, we can give the mm side what it
> > needs to call the related memory type functions to service the request.
> > 
> > For example, one could pass in the inode, pgoff, and memory type and the
> > mm code could then call the fault handler for that memory type?
> 
> How calling the fault handler differs conceptually from calling
> uffd_get_folio?
> If you take a look at UFFD_CONTINUE for shmem, this is pretty much what's
> happening. uffd side finds inode and pgoff and calls to a shmem_get_folio()
> that's very much similar to shmem->fault().

I believe the location of the code that handles the folio.  One would
decouple the folio processing from the mm while the other would decouple
which processing of the folio is done within the mm.

Does that make sense?

