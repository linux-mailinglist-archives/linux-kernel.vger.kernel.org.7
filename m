Return-Path: <linux-kernel+bounces-760028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E30B1E5C2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118BF17FC13
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF1024E01D;
	Fri,  8 Aug 2025 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J9BGv/WY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A9FfQxUS"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822172AE74
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754646081; cv=fail; b=XknehSYT0zNjRpss4Csgp5tBSfHM4fKdscxP2E29hm5zFiIFw0JPEWFLaZy+a4WUXxwycj0ZMOiMV275EJl8VgIPNZQ346cC9xOKYTu4V4pDngpAS6WEGsc6L+qDtY7r13MHeoQMCVO92fpyhRvmzRbgJVMENdll+xf/n6A9FiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754646081; c=relaxed/simple;
	bh=+15/hbPuLpmLrauAiabvn7+xETHc3Qmbm6qs6If4/Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cXZVto3+ZdhA+UGL+0y/YrGpFopf8NJaPLJ1YY2ZRQxIXOPWnvyNZcHTA3lKFqhf/Y5QbryR1XAkY/cvOBUZmiuOBsdNy1gB7khNJzrv2/UqjH7cv5/LcEojg9y3yY4UzvUlExAaASmv7MLpa2BHwXSlTjrS26HoKm+oQlhHog8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J9BGv/WY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A9FfQxUS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5786YiiK002776;
	Fri, 8 Aug 2025 09:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=+15/hbPuLpmLrauAia
	bvn7+xETHc3Qmbm6qs6If4/Gs=; b=J9BGv/WYxar9R9+jI/hyXbqoLBIxf9uUZz
	mY7/02jGBX3ZREOWnFowAtgXkP1iX3rJGUbduLTkcG/SqNNzQvwPYSRaI3sgpJW4
	GxA8Qodghvdf4HtJairHEkP9lEvoTq/f06Pyo+vlCgo1cbgBE6yG8icrlwHjMggB
	x+DpMGnJ1NYoJxZJrbufe1cF9HL2D4aIjOo9kRZbv7P2SfjmYtB1ucHUg7VhTVpN
	7n1fPw2L66edXjQox6NbW9VZzZIhpKTS3Rvg8FcD6NKcPLHJIHzS41p0WZYn8TRQ
	RoKbAV7TC47mXXpuJYjQUMYsrrtXr6f1gPTM93b1g+9py3XS3oXg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvf5v68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 09:41:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5788d4gR009798;
	Fri, 8 Aug 2025 09:40:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwph4js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 09:40:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRaOdFJV8wBmlUTuOTZldk86hKYDHbSK5aO4lreG747TgCuBOya64bUzOZHTvBEAIvKu7dIwWfhZrzogE4hO52qpIjz6KLduQkOTOKH8h628rV56CzCCnvWy13kOvgehxFD5pcNNeBnE8zWpYtv7f4RCz/SAdoJkCjujcIL1TgGzZ78tV3gWlXnPv7hjcqOPuqoFihkdgS85lpuzmAZVwsDNIjE4PdyMQ6Iwd/5jtYjbcXuCfdgUa2zghtiddW1CLMQ4lTGgtL+cTgkt9nl0eo1uwgymt43hD9DdXutO+/NPd1d6qdna4z8QCRsdXUo6kmWrVzjKzXDGNSok8XcBPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+15/hbPuLpmLrauAiabvn7+xETHc3Qmbm6qs6If4/Gs=;
 b=V0NJx6gUoAzX1ZjZlVtMjBqKYre0+FFlG++4JtnWYCxazn4QRHZffs/xN9wNNYXO6VXj+Fv2UhVGVki+2S/nDNtlgWz538/o+vShU32tjU2kL32nZwb7/vjA7PvZq9RyG09lTAy4Ult5To/cqVWiAgK38/jw/V8s8L6qSNZg8Mto+IOh/Z/aMl2kWGD3dcYkZQBFfGPFKe8QN4GguOXXCUvpgy53l1empI9hOZgunbyLj5NNJxVghdAO6OSCqxdfG2mkPpVb2RVYQ7PIjXh0E8c1oJk11fUnQ23tGZa1khkNqlSBvKJecPQJ8Zup4nwGdzmVtoIIkkrrZyJhw+OqMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+15/hbPuLpmLrauAiabvn7+xETHc3Qmbm6qs6If4/Gs=;
 b=A9FfQxUSPQkf5yg9ZBqaIw98HrrnG7Iagg/lrkPzNXkOyC8JT8+TDm7A8FUZVGCVaFdvSnC2jAgsA3r5ZzmZmRg25Mtq2Nxu5COPRHQPsa4n0a8tP/+OUiJr8EekqU6FoEaTY5usqf8Cu95asgp/N6qnsc4pIohjnQCo/0WFCbw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB5658.namprd10.prod.outlook.com (2603:10b6:510:fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 09:40:42 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 09:40:42 +0000
Date: Fri, 8 Aug 2025 10:40:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Barry Song <baohua@kernel.org>,
        Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH HOTFIX 6.17] mm/mremap: avoid expensive folio lookup on
 mremap folio pte batch
Message-ID: <2117e7ac-a848-4acd-8ec5-7ae88a0bf4a9@lucifer.local>
References: <20250807185819.199865-1-lorenzo.stoakes@oracle.com>
 <158e6422-fc82-4d6c-a442-2ebe956a66da@redhat.com>
 <3fc75720-8da7-4f6c-bdce-1e1280b8e28f@lucifer.local>
 <6870e24f-dda6-421c-8df8-58294927b62d@arm.com>
 <ae01c6bc-019a-4263-8083-8ab073e72729@lucifer.local>
 <303b1764-6471-421f-b4c3-6a2585cee2ae@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <303b1764-6471-421f-b4c3-6a2585cee2ae@arm.com>
X-ClientProxiedBy: MM0P280CA0108.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:9::9)
 To DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: c715521d-f4f6-48d2-cd3c-08ddd65fa44d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ez+7f3f1SNRjGiZ+vH1P1016D4dWRs6yPMutPHz8T0T/HSGQb525/5QakXu9?=
 =?us-ascii?Q?Ss54F4bPm6kKvUiO5Rs51+TJTPVl5DznFRGg9DsOUojRDNL32DD1LEk7a7Gp?=
 =?us-ascii?Q?jiYF20gA8bRR/+LSiQT9gGGgQR2LxK8/7URmYcOESxUWBOEg888BJP+uZ8o8?=
 =?us-ascii?Q?zfRgHY15K0EhIbmhv/gRD9oZR9ARrkQk+c1j9hw34xUB7kYtc66DYHX1VjGo?=
 =?us-ascii?Q?u+R8F3aCAbgXhRViEjDZE49S63mUUKjh4nfUKZF5h7aIEdiP4vldd/mm6mqa?=
 =?us-ascii?Q?cK4bQG8/dxAiZ4e3ZDA263P8SK9/NfBgUt1/lp5LnS6KT6JlwmPrTT2vgaJa?=
 =?us-ascii?Q?boWC+kE5wMjJJsQgTQ14bZNGkLZ0lDki38Zj5QyxW+alNbzqiq+lR7dHQWl/?=
 =?us-ascii?Q?JlhskhOgJod3iP0hBMNRqu6jc6Tjw7/0wrwyhOFmJlda8jMcG7KHy/0JOtHQ?=
 =?us-ascii?Q?Iw+fRN8EclKkxyq/d8szZyVVzpmuQLQMkJ4YDV083+FfTbr1iYk/Cqv7a5ig?=
 =?us-ascii?Q?lt88EhXsLu46B0dftXDxLtrst8iyfkwOa4SrGNIYgxwGtxk/R3SYGxfURkDR?=
 =?us-ascii?Q?qBO9g+zD9gZ7huBdYhTOgjQZ6h3xVR4WA5wcLWJNB1xBAfsXEOOZRRxvCq/c?=
 =?us-ascii?Q?fHFtu4/hCcqpZndsis5lFvGWwL3a2RPc3jXZnnmI1FRnyE3nhC/iyIuU0xTj?=
 =?us-ascii?Q?Z7HuCqt3g+fB5fcsgkLO9v4otmrnFxtW1cQ/KzzN22TuTw+nBfnh2NNqI/gB?=
 =?us-ascii?Q?AKGLYkBmyQy9EilBDfCOsWF9pwYhw3JwwidSxsp72fkJm8UnFdym+ZRCNxFw?=
 =?us-ascii?Q?Jmea2PlvnxJo7zQzK+1pxIjwDgmz9Drj7eCahhebGusJu6tBgY1cPMpZX4+V?=
 =?us-ascii?Q?b1bZ13yG+5ctVSdqbc+oWxYZ5axC4HDOiiI09OSgtxQJO4ctvIA/sPr3y87K?=
 =?us-ascii?Q?oZt3H2TWQc/Oo53MHHskORW0vPWKtgNzTw4AJ6nEJLPgI8kYgh/SvNrxTsrc?=
 =?us-ascii?Q?XVExXDsRUdt38LkF6XHdVIasZi60wZdw9xkGIGjjb8Z7fiPWegTXTzdVj8IG?=
 =?us-ascii?Q?1cc7ryLedK0m6CStQ8mRPd+Y9+WIJNDxZJMNWUCvkfXGwwONXTk+idEUK2zU?=
 =?us-ascii?Q?/2TMi6ODgWhzcKuKLNlipzAWd8T+gGxHk1dRN91zWf3qOXjZvENL6NdCr8q9?=
 =?us-ascii?Q?vC0IXXfSJFYvRZ9dt8iNeNhGa22AACJ+SciuGkf2RQQQWpzGSGlMATejDrP2?=
 =?us-ascii?Q?+GZdu1rpPBiVw3b3+sHyNqYbn09+/ik9aT7FEdPB1Gi5KFU2PsKrE6sCCq9J?=
 =?us-ascii?Q?PidDjvBArkMG/5CNKlc1+FOq/rAxAmgEVJVhmWbY5yXujQgrMMOy96W2d8gq?=
 =?us-ascii?Q?OpgZ0RbDDyA+8j1XG/07yWfvSDuPsVBg1cPigr2Q2qNO1uXFI+O1udox4Mqj?=
 =?us-ascii?Q?uW0qVGVsnq4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0S/7J5NtWCkKuBf+6zr021ZSSxGim9TmA+ZaLfsEsSA/2woGNIG/Vabt2iJ3?=
 =?us-ascii?Q?7qrN75sUB+Xj5I4yfWZWqQLxGyIruihHtv8REtfdNAe+GtIRudZctO86ieiZ?=
 =?us-ascii?Q?n49pzDJ6uVGIqS67URSEHIs+a9lvBpsbJcX82/vclwALxrI9WfFuxJCJB2yn?=
 =?us-ascii?Q?Vmxe+Y5VssmJFub4Bk62lWtzdFNehbv3OiG9xZGeihbfGgcQgG6OGdlhDQ2P?=
 =?us-ascii?Q?f7tDgY+nncXI/KVX2MATYgXdVZdO1aOJe/LprwqgIsfI1GP5/uL/9xqraruV?=
 =?us-ascii?Q?xBsvSJsJDPSmemuNK2Bw3qLuH4CHCBo9AWzk0OozHAVXwXw/GG6gCxs7YgI/?=
 =?us-ascii?Q?G5FDHc46LghofwoeKBqM2CStRuu4IdSwM1wfiratjco8YY74JXn/ZWaW5Zys?=
 =?us-ascii?Q?iWi4/oGX3HnUjgM5ty0QbrXM9NcnKyzKP0FZVWSPXmRZG8rXcOPbebe7D+dm?=
 =?us-ascii?Q?rlRrTjfnXXfYULd4sWEFfNqWCml0138k+emlLqPgYvWHU59DefrwsViIy01L?=
 =?us-ascii?Q?+FFi7Tqs8nTf0jkqBfzpftedgH3MZCOVaP4vMsLT4pRpqFFyQ7irGf76GyOO?=
 =?us-ascii?Q?l58cp5OUhiAn9pK32V7oJIisow7KlHSw7ZB9F5K80nDda+g9V+AcHDn0ldNI?=
 =?us-ascii?Q?PU2OoaZ8qDtbEJ1SO57TQfiB3ghtXmatYz7pMoQ8zdP9mIys+hR+D3qsdQQX?=
 =?us-ascii?Q?2VKqsGgX9MYc/o+CEtTBoJFJlFjSBhwJ0t7gaGBkl9/3BPTXJdF8sk0DJYw4?=
 =?us-ascii?Q?5hvxuMn08EJIUsq8fjJTpc8vdHF2bXFpjLKHHFGuUYSk8ggGEBkD6vsAqdno?=
 =?us-ascii?Q?aX67xPWeZiL/OpuYGh6plZ4Xk8gnyAD24vB84bU2q+i4onabOhlLgc4bdIZ2?=
 =?us-ascii?Q?+hzAR7kgdo7mZHExopd41XWor6uSfDqJfSdrNb7W6AkcnnojmBRaxFbcz79a?=
 =?us-ascii?Q?SDXtOXGm3XtQ1hWSmcw85B7DsZGfwPtp77GN5IFCqCsVyob9RRRlmf2wEXI9?=
 =?us-ascii?Q?QlmbzCPDCFuIq9uyDVH9FA1qTV3xIlZ5gxiDYgtsbFoy1gNSoDpXDc7mnQan?=
 =?us-ascii?Q?iMAPsfXtmdY3gahCBntrUEkwJm508t9vkZ0TwLbGRKxLPU951S6rFeUAAxm5?=
 =?us-ascii?Q?CN8G8CXAxDueMl2ydaJYzuKpINkjXXiCkBXC4qE6svPbQDDlH/NXsUGZwZ0t?=
 =?us-ascii?Q?3Y+rtUp6FCF+kSpf7dOy4XdtOR+alJCYUTPJ6UZu3ixNyaVZmNePE84uQ9Ez?=
 =?us-ascii?Q?xGsAAsQt5fYz/2+NQ3p/xcPMbolMsyA0JqPZmbPyC8NI4V2jnq3JKPDG8bbK?=
 =?us-ascii?Q?lJJ94PkWTl/ti+l/qnssjLnbWrpwj7L0FF4v1kI342+G7eQzJY01fxkti4yB?=
 =?us-ascii?Q?XUccbkOgPt4LOjS3JUpdaKMmZvqgAfwHQ6lNdRI9i3+vwA/q5OFXZiAjv4Av?=
 =?us-ascii?Q?QdlXXnI2A0hb6r7XtVZqlx/viriagjhuGcWOUd2JcCWkslxYGVWtf+SjYOj0?=
 =?us-ascii?Q?sXuzMbb5UiDMccLjD65+khjFjYxvnnOJ8SiNX10+MWtiMSmgRdtT9Ydb/IdL?=
 =?us-ascii?Q?Nxwwta9BWe7GJELxzCxv7TVUD6O0bRm3wX8Ww9GZkG3XG1S4gS8ZjWFZ3P8o?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	izXjTzGIeKYBc9DfHTYfBrmwyLbGg+7XNxaSUuUTx7Svk7aFktu8WLPWL1+W3JuJ/ewwNv0Ioy4j2VN0ngOPQcuo2MB2kQa82L97JoLDruw2QKPqqh9ANu2DZPzH3G6usMiCmYxor9YpdnF5xlZkLqtQ8cxCzNPTlZaIrhD99lGi2CKjD/ty5UapKVsKUZjLyiK0l3LL9C9eOA4T3L3vBHygKk4y0wLFCRAmTAzuPeh5+s73k87JpnYv7Y74arPkEg2H8e1ar/D95RWxmSMERb6ppuJZzzwbegsL0qn3+EU+OmLFl5uSTMtgRk8eCP5r3eflpbQhNXURfqaR7uZnWGfP9yDqCqpqyuGmk3+Ka62wixvmK8b0J76xF3VTBQnYYmlp1bSvJek6g4DQxArvmnaQZUAilK1vulC9rqtCHobqu32ZVJi1YZVVloRSwQ8lWR8qJXUGzxdVvJhiy+jLICm5hmDfCGHJc1zawAMdU5cqj5GxoR9lIl4iZn20wi28FQbxQZJ6ROOMFjnjIctcS/QUAVzZRw2nQGf8tLvdu5j7tBv+cU7T8IT2EH2ozs8f9PnIDK1ytIzOTPC5iBlj0Sq8+/1hUKLjgoxhuZJ/Gn0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c715521d-f4f6-48d2-cd3c-08ddd65fa44d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 09:40:42.5094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iakEkSHy2zn0rNrRJ0S+McsPqm53p3dOaWObUEGhPwzi/VZq3nN4SwXlLlyr7b7OfUlJlVW20KJQYDA1JzhT3ElN2lQmJFmmGipObjZjuQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5658
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508080079
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA3OSBTYWx0ZWRfX3FdZHNl0J3p6
 DsK7x09TmA0nBKaavZN3kbfwuPvZc535zIIfM1Mf6xZGU2DzBoAzKM0aDwRphoidO6sVEzPEZey
 6HKCING5V9nBmeMhm0akykFNFqZY2yw1OJBkmii3ODzpXPsp8zBf+gU2fy7XGs1bZN2Yg0uxIxd
 bHLNosxP2oRMYFdi2Bdpu2CLyVhx/nA4GgdYr76pzT5BTtCftel4125yfYTLfum0ZFikCK9yr17
 turfmnsT7cB/ZicOF4sNj2Bs9arjimgaHzGn8E90h83CQQaNY/tDT5erO8Z2eOID+3KVdu6xvEn
 1Su/8xpHGTkwJ9BP1zdJCNfsSIBYBR6aHwWTplG2LxLC07JCCu/zq+O597PSNzA748hbNNjIIW0
 iHhs14f4c0kX358SJsaob3slgKi/8x1du/740HilAZUwmdjHUAaQIM8qpmeVBJkUaSRomAiU
X-Authority-Analysis: v=2.4 cv=RtTFLDmK c=1 sm=1 tr=0 ts=6895c62e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=CEhHzXULe2qCZuwJhVsA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: _wsbf63YZaKJU_xInYHefHEOLs1g8YmU
X-Proofpoint-GUID: _wsbf63YZaKJU_xInYHefHEOLs1g8YmU

On Fri, Aug 08, 2025 at 08:19:47AM +0100, Ryan Roberts wrote:
> > Yup David explained.
> >
> > I suggest you rename this from 'hint', because that's not what hint means
> > :) unless I'm really misunderstanding what this word means (it's 10pm and I
> > started work at 6am so it's currently rather possible).
>
> That's a lot of hours; I certainly appreciate you for putting the effort in and
> figuring out the root cause so quickly.

Thanks. Of course not all these hours were spent on this, it was really my
very sincere attempt to help out Dev who might not have an x86-64 bare
metal box as readily available (literally, physically next to me) as I did.

I'm glad I could help identify this! Jann, Dev and David gave very
insightful analysis also, and all happened to be entirely correct!

>
> Not sure if some sleep has changed your mind on what "hint" means? I'm pretty
> sure David named this function, but for me the name makes sense. The arch is
> saying "I know that the pte batch is at least N ptes. It's up to you if you use
> that information. I'll still work correctly if you ignore it".
>
> For me, your interpretation of 'the most number of PTEs that _might_ coalesce'
> would be a guess, not a hint.

I feel we need to drop this subject for sanity's sake... :)

In my view the crux of this is that a reasonable definition of hint (and
first that appears on google) is that _partial_ information is provided,
which I interpreted as a bound.

Of course it's 'partial' in that there may be adjacent physically
contiguous PTE entries, and the whole thing is made murkier by the fact
that the cont PTE bit itself is a hint, which is again presumably why we
named it so.

However, if you, David, Dev and possibly _everybody else_ interprets this
differently, then I'm happy to concede perhaps it's just me getting hung up
on semantics here.

So I won't insist on this changing, though personally I'd still prefer it.

At any rate what it does is now abundantly clear :)

The comment is good by the way, I kicked myself for only reading it after
the fact.

From my perspective, I think a misinterpreted conversation (from whichever
side) was the underlying issue, and I've again had it reinforced the need
to always work from first principles on review.

[snip]

>
> >
> > I see that folio_pte_batch() can get _more_, is this on the basis of there
> > being adjacent, physically contiguous contPTE entries that can also be
> > batched up?
>
> From folio_pte_batch()'s perspective, they just have to be physically contiguous
> and part of the same folio; they are not *required* to be contpte. They could
> even have different read/write permissions in the middle of the batch (if the
> flags permit); that's one reason why such a batch wouldn't be mapped contpte (a
> contpte mapping is logically a single mapping so the permissions must all be the
> same).

Yeah I suspected this might be the case.

Sooo. Now we're rejecting if the first PTE isn't contPTE, is this a problem?

I remember Dev's first attempt at this checked hint, if == 1 I believe it would
then manually look ahead to see if there was a possible batch.


>
> >
> >>
> >> This function is looking to see if ptep is inside a conpte mapping, and if it
> >> is, it's returning the number of ptes to the end of the contpte mapping (which
> >> is of 64K size and alignment on 4K kernels). A contpte mapping will only exist
> >> if the physical memory is appropriately aligned/sized and all belongs to a
> >> single folio.
> >>
> >>>
> >>> (note that a bit grossly we'll call it _again_ in folio_pte_batch_flags()).
> >>>
> >>> I suppose we could not even bother with checking if same folio and _just_ check
> >>> if PTEs have consecutive PFNs, which is not very likely if different folio
> >>> but... could that break something?
> >>
> >> Yes something could break; the batch must *all* belong to the same folio.
> >> Functions like set_ptes() require that in their documentation, and arm64 depends
> >> upon it in order not to screw up the access/dirty bits.
> >
> > Turning this around - is a cont pte range guaranteed to belong to only one
> > folio?
>
> Yes.

Great

>
> >
> > If so then we can just limit the range to one batched block for the sake of
> > mremap that perhaps doesn't necessarily hugely benefit from further
> > batching anyway?
>
> Yes.

Also great.

>
> >
> > Let's take the time to check performance on arm64 hardware.
> >
> > Are we able to check to see how things behave if we have small folios only
> > in the tested range on arm64
>
> I thought Dev provided numbers for that, but I'll chat with him and ensure we
> re-test (and broaden the testing if needed) with the new patch.

Thanks.


> >>>> Not sure if that was discussed at some point before we went into the
> >>>> direction of using folios. But there really doesn't seem to be anything
> >>>> gained for other architectures here (as raised by Jann).
> >>>
> >>> Yup... I wonder about the other instances of this... ruh roh.
> >>
> >> IIRC prior to Dev's mprotect and mremap optimizations, I believe all sites
> >> already needed the folio. I haven't actually looked at how mprotect ended up,
> >> but maybe worth checking to see if it should protect with pte_batch_hint() too.
> >
> > mprotect didn't? I mean let's check.
>
> I think for mprotect, the folio was only previously needed for the numa case. I
> have a vague memory that either Dev of I proposed wrapping folio_pte_batch() to
> only get the folio and call it if the next PTE had an adjacent PFN (or something
> like that). But it was deemed to complex. I might be misremembering... could
> have been an internal conversation. I'll chat with Dev about it and revisit.

OK thanks.

Cheers, Lorenzo

