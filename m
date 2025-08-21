Return-Path: <linux-kernel+bounces-780314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 169BFB30055
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6CD56040BF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956592E11D6;
	Thu, 21 Aug 2025 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NeIHIQde";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hSylZaVX"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73B02DCBE0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755794340; cv=fail; b=Sb5cu5J6Eo/oyyLMu2xdJNEKF+9RDVtP243k5AKNOnMKJpll3YggGp8XwpOTVN3mRsCJnW42VPB/HHmfdSGfyu0ASp024yCihxNz43ZLusZmi4drJgCzMqr3+ywz5B8q2Ge7MYbl5dynh0wBSzviiQ6n5IDREMEEjDJRCKNwYJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755794340; c=relaxed/simple;
	bh=ezI1UChLlm2UhbnhX/oZKSWDj1No1qpzlJREqT58mcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l51+ovw46UvQFhgXYKr+efnOZ+chFN0+Fnrhwsil+nMMnwQS6YHzkzjyUgD5nT0dBKF+VIG9Brgc7udrJY4pyfpuO+VzIGF9KF6o+ubSJpSQRzYB3vs+6RunqNuZWJBvVx/FMYUy0xcQLPjygA+bx9O/Df01d6ZoAbEqV+O/RHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NeIHIQde; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hSylZaVX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LG0wgR023061;
	Thu, 21 Aug 2025 16:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=NJhLOb3oz+LSxhRIKM
	kSz3rWdUMxsfwZMhNKfqN5H8s=; b=NeIHIQdes7BATGxULVzKXccgMxn1DxbYS2
	iwpdEb2TLJLytCdkcBTOcivjhjsFQJUK9zuolHaHi1mFcxvoD5DygiFHMCcMk4OK
	+bmFilY5+LmZWF5lMPbeXD+kdOp4K35/6d3+EtNLgW5l+ukVqgKoq1vRewgTYkVM
	iuQ1kzWyWUZZk/G5oFO/ec6iuSmMbxqoF7iavsBliFe12nhY0/74EVwa0IzdOuIe
	zF8MJeH3kIF05dyvwOAykyZoCosuJ12SOmvqEHweSWssn5HfjS5yg5bl5Zq/3Xrn
	9WFAtIYuVV7kV04v/CsE3JmDogShm5eRKV2eAxku3gCEAXKwaNEQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tqv2dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 16:38:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57LFH4RL025499;
	Thu, 21 Aug 2025 16:38:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48my42umys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 16:38:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOY3FH+t0RCNNgHXAOBFdLHfbYUAbTkdQS03YHKbNCrYXTjJRIdOENHiQQZAX2NgwBLBGERFz7EByVg6FanvTUFq5FEbwiNm9m7TiDfqYzSsvD5joBs9vnZ3oMyzIgTQQU1pdzS/xkpCRWviSEMR4RXICAEKbc5rc7+OvZfpRO7w3SLKnz5azeKzfVKh/66WnA4uU9qnIEx51bfZvabjDue0w3/QIJtWhH0tm+Wd5TeApYNkBPVQJknrQCd8VqWC7vNo+xcqc4MkiN1WxDXhVLv80eA1/CPcSmbQC6pulL7sfgFeoXn462dOGIa+VmwAJk+ScTDLTGlGVl5i+Ty4aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJhLOb3oz+LSxhRIKMkSz3rWdUMxsfwZMhNKfqN5H8s=;
 b=zUrOeS5VKsaTouoLjkHbz35dubcbM/PvsoeokoRmsmSvpLVzrkEMLW9un/ZlsqDhpEQl58DESZrcAOsL+fo94I+ETb4TatvuBN22tiTyl/u29tlS1/iPkhAyRvR/5YEu1GFtyXXQNR0zrPyb4tyw9mj/JhfimBBGl3l8xdVCniusqbWaeD/52MkEFIeoYa+3KGEickbqPwApYyh30/dnFFTYYFluzhV925SZ8M0J04yzedWU5uTmxCRsQEPbCZl6ij624WVugZDkbXOrkDBepqJkARgH6vrYQh6t+KBytSEmsHIEcaQDjZmzleLLutNTsESz2WKhQlfoL89iX1UJ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJhLOb3oz+LSxhRIKMkSz3rWdUMxsfwZMhNKfqN5H8s=;
 b=hSylZaVXrzxnAkHsgmwRM4x2tAc2u0YnHHopmFniMXA37zOy/ITZbfE5uXDtYAcYIIe2ukoPA5l+saQqrcY+hgcUNtPfdGhRxiX++hbHf+W+ogde+Q6PtORoeP1t8BlYosWHp+tAt23FaWNyYQ8NQuktTeK4CWqffzsZAbXmxTw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB6102.namprd10.prod.outlook.com (2603:10b6:8:c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 16:38:38 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.024; Thu, 21 Aug 2025
 16:38:38 +0000
Date: Thu, 21 Aug 2025 17:38:35 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Remove is_migrate_highatomic()
Message-ID: <62b63df7-aafc-4ec1-bdca-8a9c12365f9f@lucifer.local>
References: <20250821-is-migrate-highatomic-v1-1-ddb6e5d7c566@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-is-migrate-highatomic-v1-1-ddb6e5d7c566@google.com>
X-ClientProxiedBy: MM0P280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e737b83-9967-40c6-3e67-08dde0d12e71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WbvtSQe9nfIvJ+njBOMTKkTq2VGVldpFkU3e/C2fODAXWU9PeN1zuBiFxg+w?=
 =?us-ascii?Q?/m1eze0x970F+j+X70DRDF4UEH3BmQ3XRsAcJthgAuUM8mrdighWBW81Hcna?=
 =?us-ascii?Q?WEQN3hrDl6aLkdkmJPkfsW300+a4ZnIypUd4cElOMVCuaEPB+vU5YrKhNyep?=
 =?us-ascii?Q?6lRIn20sE3iINj06OWGSErk+ALgg3czrZ9bd1bYC997Cg0juv5fjyQDYIGwL?=
 =?us-ascii?Q?6c8XFW6pEQ8FpRPM8ddVcJQlVey09p5OMgo9uYmh3SmBRvGrE2BYa6vvibIA?=
 =?us-ascii?Q?Q4yl2VE0tSjimlcD5cnP35jQX5ErJEb1baptfBKKNILLZgkagY0tzwx6Oyzr?=
 =?us-ascii?Q?uI7mRNOxeBZmyaJuwTrskKdkIaXJHa4bwLAaBZn67bMBiOMHHrt2Tp1O/M18?=
 =?us-ascii?Q?78wU/CRxS4t2K01rbOnXRGwwTDepQzWRlwcnYsUqYeLw//ZfPioH3k+B7jkN?=
 =?us-ascii?Q?bDUpBmOkoQMk0rBYTZq/jsJjd2T93guJ1seqZdW4fwRE+Y/Ghan14AdLEDzb?=
 =?us-ascii?Q?d7aVLXw3eEgm9eMJo7Mg9yG74SLJtlYPBYc2iovkUaKxPqHhgApXK7SzyeHr?=
 =?us-ascii?Q?EKvH2uYrkhIZz/HHO+Ege0nO63Kk8e04bKy74rCRYsmHmD392BUSA5WEEISy?=
 =?us-ascii?Q?VlmsbV/N8k2mUcRkQov27BormovxdXVydG57TmDRisWpmGXTkU6nzikoKsKD?=
 =?us-ascii?Q?4ahchGLP3b15UmxvnM9wXl9McISP+hRVmDRug+12WTc5e8iHb5p45lMPnGnD?=
 =?us-ascii?Q?BLHb9CyzlcAUj+I7k9hwFevWDAlC+Lcjx5n2kjql1BiD84kn0gord46nFvV0?=
 =?us-ascii?Q?eyZa0BcdZFdrnNSqb0wBXsCLRKAP9vRUKkVU3lf+gknBf1ruvpf754aQ5qU+?=
 =?us-ascii?Q?7BZHoDnJZtwdSojERMRW7OIU0uEZq+apF4zehlkUqatZSI8VbXktLsTzhlMp?=
 =?us-ascii?Q?MmaMFCuaBX21E73pa1QwsBilOYoghAvYPD9MDljwTcMz0suFxSTgwCByNLrs?=
 =?us-ascii?Q?JzjSTPDFy58WgXTI3dbJjZDzBrR4x2ATRWlkX1HK6uShJDGOjDt2BqCoCQ+y?=
 =?us-ascii?Q?07nIjx+MXRMhjPAbWNryVB/XNBYkI78QRDZkvLXBIqtETYAgzqUPwrAQaXA4?=
 =?us-ascii?Q?zlVE6wTfjqlo8DrsgUiPXfDIdf4sHFNV4lZH7Yrca8hjXTBXiXsAOB77FQys?=
 =?us-ascii?Q?f1YXvSOgfKYxjC09AA0kXbkxpNld/Tzis/JWPu+h+Ct76YlH32gKWC7dphRb?=
 =?us-ascii?Q?f6YU9/GvawhNR7ZgDuAFZW3NPt5+nAJ9sOnloKnDcj8U9sOdb7W4/5kgmcRU?=
 =?us-ascii?Q?eFI8s90R499yrDs5GQhUHPWfbjSAvnXbjI8t+zZR1URPuKRR3xMwTDzB7kbQ?=
 =?us-ascii?Q?bLF9/w0g6ZiFw3ivta8xNxsURx/aPtVSJ++RoQHhyR1HrvjkMw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?INSrZmtXw96LxoiBQOB9WAHgvTVSPbivRzf1p8Mw6N0VZ4QwHDzHqU8CkFqs?=
 =?us-ascii?Q?fNnX0UhhyRgZI5YEUpIy/MqwlUJTZByD4zIJwEM4IFzFMCZdqGheGaR/SUfx?=
 =?us-ascii?Q?lLybk02jhNFdl6J8JnF/4uj/n+1Bm8fCO6iM4i4DdwEOuVp55y4HMn6zcERX?=
 =?us-ascii?Q?iyANrabGaZiYxH85JVYUN3vU0KyRjs6kRsCeO/hGvvwWxvPW8ml8OaA2lsCu?=
 =?us-ascii?Q?c6TGuzhtnVs/T4S5vt2kfdSkBetlIupvc1bua9+89SJpujd0XvNZCL7AiWMj?=
 =?us-ascii?Q?npCcSl/MQ5KgjQFR9WgY0aY2R0ywFpTEIiYUZW5DzOyqP/K/xoNlahYYIpho?=
 =?us-ascii?Q?rjuTGh1x2BDLI7rMRPeImLxlFdWyqCMp2f+OGQwWVyQpivFZbGhn30GJbi2t?=
 =?us-ascii?Q?3IxfBWAHXKmir6Ok0qFjNqvvPySkJ8oI2MSiG+M6hDICUeetGWNAjHvy+Shv?=
 =?us-ascii?Q?cR5hO7XjzOMxGrd5EFwjZqOM0ThBWy31lVHqZY3klNHpcCMQGhLWeJaU/lwo?=
 =?us-ascii?Q?Jv25iTz3fSoWSq3Y6/TOmNfbqoUFZ2frEAfYKQY4xsP94/fBYMcH1MCmHwRK?=
 =?us-ascii?Q?MQqhE8/+hpfZDPyMFnssDmHfDcXtAGzSntGQQmBMf+WowlfHt/FSrrP20xHG?=
 =?us-ascii?Q?5ci3SOrwv5Xc+mYnMlhrY6MOF/3Vf5twljaWzFzAO00fyCu2B+JNJZQNPsO6?=
 =?us-ascii?Q?zV24CuhFXFez9yWHhAR2HuCckuDEVaNVwoH+BSRddFclzpADXXdgntJq5T7P?=
 =?us-ascii?Q?2KhEoaFZma0JZfVt1fy4y0K07VsggzSFj2iaY4ILLnkqcIV2Ci+EtSnkbFUo?=
 =?us-ascii?Q?fAkzlfHuH8eUUSyKx7ULYVDcxR92rX9TdWRisnCWELRjOzY0tOAMEktTee2y?=
 =?us-ascii?Q?UG8BrR6iVm5APu6t0JKcdEh/4qOn976PpWAi76wWpldLn1m5QveZPO7QUWHp?=
 =?us-ascii?Q?u/VLui9xzAIFfeoNyPBoAk09p9egnaUKt/xVjCKvnQbZHu1OB4awmzdnEzNO?=
 =?us-ascii?Q?L30VJue8UjhFgVe9pOXkcUlNNjTiqx8LAd/e6rb4V6BDwEZ+/Ofj5goj6QtT?=
 =?us-ascii?Q?b/sLWGQf2KknrTwPBGvOV5tYVFsOh4j2+n4vJPHvIK25FI2djHqt/TOsECCS?=
 =?us-ascii?Q?3tm6+nX8xgRAsN4eRxgk1JP7cStYpC5WlELuS6qxPf/YCR2I/8/ajuGXmcht?=
 =?us-ascii?Q?gtFy8C8zCa2ZF2wLfcd0COPvttQFE94Dw0SZcvtmKmqSTZ65FaCtt3S2IAlB?=
 =?us-ascii?Q?bRZCv2hidVhAuZ9d3IT9lX2g6+LO99vBv+oBU1VRhTexhXg2C3R3HiGVOG86?=
 =?us-ascii?Q?01rVLAJRshq6icOnRfvhwKZkCdjebMr8hoWjBNcTz/oPijkQvjHWXNX51LNp?=
 =?us-ascii?Q?3ws74uPaMcZwDTWv9Au8RWB9PCq8UDLdFXKBnYMmnXOvZfTh7dtp1hEDBPfp?=
 =?us-ascii?Q?3ALHTQ0p+wyUdsKuICxR0UlRJYOCZiUCX4QZUuh5PxcA/nkfliG4P/QUseph?=
 =?us-ascii?Q?egJIdL7hUFX0wJydpg39Idmbm7GFBl1DgUR6ViI4E0yfxnMjP63b76z+N9VO?=
 =?us-ascii?Q?LiCxJWLcGuea8c1JwIwqhV1dy9hJLvKnXfld0lCBrOQFEnpS8X3/hb45vpDB?=
 =?us-ascii?Q?+A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	68OuAYV8q04SxCp8Cvrht6BFJkBavjMp6ol/6EmI0FNg7SiUqZvjJNEXZrA8tPa7r93ToMGTDmPpWeooa2Hed3TiTqQ9E/hAXzMsIrAliZ35Z7fyiqpZvgL5RPc+Db/r1AQDGfyP3cs3qNmQCSkbvuPr6Bm9V/XCQMGfJopwR6gYKCW4F5/lZBtLN8GunN14mznQVeA8FfnwK9bn9SjfP7sqS+qFq2T47TWscoztnD4zZRQCpr6aB/nNxBA/NvXuIUS5HKFLJ4++nlLnkXi3yHD970Qg81TOQkz/6Jsr7tU+MlJgDgqfotTE3ZqPIeLQfGRl3BYiiYctZq7EveRSnEKVWv5iu2luuY0PzeM6ZSxE5ZcemPm4Bc2fL+v27IfKBsuOzWatYo4ADYYVnOJNyfg0e2XZZKNfpmzjoeMXB0VV/3cydTZlAvVgUs+mq6VBGtPOEg6KkpwsdQEtKW+Z7zzfrmpQm1MnQVuhc3zDtdt2vl89hLcR8AlzgCZfX9HFGFH8uhuuiqAPRFRo3i6ESsS/I41PeOb2L2vyruMpqATXvD7DvtBJxZvUqADDVekVfs7XOk9hQ+qA+fv/G4OjR8Sv10q5577gTb7dyiEa34w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e737b83-9967-40c6-3e67-08dde0d12e71
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 16:38:38.9148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJUvUsVPzPa/hQHLy7EexTfz0NsFIF5/0BGFw3MQZ0BEdu2oyBQ69P01z7iJNpIb53HYVMw5LjQXW15fpS89IO7Ogn2WC+1JtOWtgMdI9k0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6102
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508210136
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX7wAPitmvUYVe
 qxP2yUKAb1ywRC5L4+Nm0pwnSKfodqSoVl4dCaJTIlOTeOaRP67UxonKkXgawLNFm+Mgahj7zXs
 C6BYMq4Le3A6jjY2vQsMAxiKgRKm+wrmPWXfEZndhnk4Y9wDz7v7mFAF9pGG5EsRo3WCYIf6iA9
 HgUdGLcULVf7Z7YDUGVVPoqEnJQ5dl7uFqXezdMdxcOL6lUOqKbD+yEz7dkngplbwBgzIyysc/O
 2q3FHVsUzae6RH32Uvew+dF+ORMzN8GO2yznPXCeCaxfZO9fxsAez4rxIjvVCjur58snZFls2XT
 MjlJPL81jDo7ZMOlqEa3J+FhHkkmCwr9dwdwfbP7Sd+UrwC/lMm2z/a9USyxHb46FMlbmj/Q9rP
 +N48IMlZh1jPbT9eTO9GJYugMoHweplUpHCImejHeVtTfieSwNA=
X-Proofpoint-ORIG-GUID: AQUoacIF6YPupdkZW0ifMqQJzU_wS4wr
X-Proofpoint-GUID: AQUoacIF6YPupdkZW0ifMqQJzU_wS4wr
X-Authority-Analysis: v=2.4 cv=K/p73yWI c=1 sm=1 tr=0 ts=68a74b92 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8
 a=282E_b8aAcVVDfuCOM4A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12070

On Thu, Aug 21, 2025 at 01:29:47PM +0000, Brendan Jackman wrote:
> There are 3 potential reasons for is_migrate_*() helpers:
>
> 1. They represent higher-level attributes of migratetypes, like
>    is_migrate_movable()
>
> 2. They are ifdef'd, like is_migrate_isolate().
>
> 3. For consistency with an is_migrate_*_page() helper, also like
>    is_migrate_isolate().
>
> It looks like is_migrate_highatomic() was for case 3, but that was
> removed in commit e0932b6c1f94 ("mm: page_alloc: consolidate free page
> accounting").
>
> So remove the indirection and go back to a simple comparison.
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/internal.h   | 5 -----
>  mm/page_alloc.c | 2 +-
>  2 files changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 45b725c3dc030cb22a3cb0ddb262b6300e65ed5a..45da9ff5694f628db18f740718f0a7a06c4548f0 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1333,11 +1333,6 @@ extern const struct trace_print_flags pageflag_names[];
>  extern const struct trace_print_flags vmaflag_names[];
>  extern const struct trace_print_flags gfpflag_names[];
>
> -static inline bool is_migrate_highatomic(enum migratetype migratetype)
> -{
> -	return migratetype == MIGRATE_HIGHATOMIC;
> -}
> -
>  void setup_zone_pageset(struct zone *zone);
>
>  struct migration_target_control {
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ca9e6b9633f79ff28448a6008749fa6ca2696332..baead29b3e67bb3ae2291b00d7632aaf87ebcc4c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -797,7 +797,7 @@ static inline void account_freepages(struct zone *zone, int nr_pages,
>
>  	if (is_migrate_cma(migratetype))
>  		__mod_zone_page_state(zone, NR_FREE_CMA_PAGES, nr_pages);
> -	else if (is_migrate_highatomic(migratetype))
> +	else if (migratetype == MIGRATE_HIGHATOMIC)
>  		WRITE_ONCE(zone->nr_free_highatomic,
>  			   zone->nr_free_highatomic + nr_pages);
>  }
>
> ---
> base-commit: 5654520c361a6638f9d9e889257dfce38c83f653
> change-id: 20250821-is-migrate-highatomic-871c0ff05a84
>
> Best regards,
> --
> Brendan Jackman <jackmanb@google.com>
>

