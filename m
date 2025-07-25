Return-Path: <linux-kernel+bounces-745993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E74B12169
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEBEE7BB58F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1F62EE998;
	Fri, 25 Jul 2025 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OiXINaoO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jrDYZkF9"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C6C2EE968
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753459147; cv=fail; b=arzxbNHLAySBKby03F078TF/RDcg4RSNT6JQIqiQAcDeaHRC1k0xb16WSsYuhgomwoFOMvezNK+KBhqxtzlWUdk6aIrCO1CWoI3FUkf/ih7HqpE6et9tAEdAjhuT/qObvWXGc5vXEXnlsVnBErsSb7W3q/jPm12ckyf3BPuvFyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753459147; c=relaxed/simple;
	bh=kqGH6fS7hWpFP9Xl5a1v0WHUzo4p8ArK/rYPKmr4biw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=djIHbq9/owG1hlV55O7gt16awZ1mEKkd0GA0bAWLIsj4dIoDgWCLQxqInapi/kXYc49hMUuH3zqlQSd+DtvvpyQGyEGNjebyz/dg7ezNby7r0R6mG9tEYi3F/fm+lCQ55bhidSgR6XAOrZ2oOFALc49is+J81XEejAMAc/5aUhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OiXINaoO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jrDYZkF9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PEJ2vv032440;
	Fri, 25 Jul 2025 15:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kqGH6fS7hWpFP9Xl5a1v0WHUzo4p8ArK/rYPKmr4biw=; b=
	OiXINaoOm0sllmg+0PhT8fYmN/K8qXx+yJeKiEoJ5Nrwsg8CLMrGQoMVipgcKvSm
	Uuz9s+/v/gmnj8tf7XMrxKmurYctsfq1qydA5nxq86cyEJSdT5mOcJtqX3vjaxqX
	MVAWFj011oV9W1mS8FBQBCOasHzgGkjgoPgt7rT551i4l4vMqT9KXWTKtHcFEQF1
	LqXzsfKJ13E/jqmsLQ7y+910HuZEZtgHJ85YzQvZ5UPw29HBMvKHrEnGpyb1zyMZ
	BzQhf7Pb80WJOsZrB7gAB5+3vsCp5Y2u1hlVRvC3EsuVVhE/+z3w95qmZuz8L/Wa
	rtYluCEnIAhVHMVE1X+X1A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w3whbr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 15:58:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56PEAuho014461;
	Fri, 25 Jul 2025 15:58:31 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tkjpxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 15:58:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tz9ONlTEU7L23WkDCbiSs0gTTdHgbMoDDCV305SNHoLwvyq83tAkuV1d91NhJtgDqbMtqrcdT+0Kvj2wY19+IoNfzQ0bLwNPOrqit2E8wRrmRiHxTmEsCOQESzBMVB7kB00eYx46AquoGf1s9pY77Yfm/kv1wRkG7Lxej682Wds1t+3IqGb7LbCim6qFrP4V2H/4cQ1KEnv8f24Z2Pjx1JWJYwF3eNBwaJvaBDnA13gVp1gm7nW6YnK2+k45KaAvcWoIxPrS7waf3rHWGucdH11hDraEkoAWJ+ZKeg7xEUpsBHfhgJwpUaQqx4b+QD8R/7TiX1jOiJ81iwraMeKqWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqGH6fS7hWpFP9Xl5a1v0WHUzo4p8ArK/rYPKmr4biw=;
 b=l3vsZVnBbvt2eJKgqjh+S9YPXcGnuZWGDItlZLzDnT+ac9tkhOA4rM0W1el1xsOwTBMRjzy9RWiP5Iz3nIDqSvE07Ti6IV9povi/QlbLQxac+C4shnPRMFPWiqUb1hDHMkOiOxqLCjLo37DEr60w16/2SVhPcakIzFNqeu+2Lu5WT+A2fJrdlsKybc5wQ8qQo/tEJXoDDrezZUzZ7oIA6JhFoZdNZyDx1S9yqWka8aNGxhjTUbtY/iIxTq4RttMM5KGjss7nWg69WKmIIm5Yciz4Gy6/VSgFajBkZFNK3I+z8b/ZLEh4l9whcjQjaBoWNx5cldWUi3u0i3vqB+dFKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqGH6fS7hWpFP9Xl5a1v0WHUzo4p8ArK/rYPKmr4biw=;
 b=jrDYZkF9l2s143Y++j9cY9omq0ah0K8xHHqNYsncOuTpF0z86anty4dALLFnjRvPBokqU9jSaIvl0AYcBcyxwVSw3torrKm2K5CLNfVcLjN/tqH6IUK9VZ9j3b7N3uTBrJo7AUvNVVM+Qr+IjbS9tPc7FaczZguo/Xfynzh0s/o=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB7225.namprd10.prod.outlook.com (2603:10b6:8:ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 15:58:03 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 15:58:03 +0000
Date: Fri, 25 Jul 2025 16:58:01 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Rik van Riel <riel@surriel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/rmap: Add anon_vma lifetime debug check
Message-ID: <6e5b4a19-6496-4841-998e-ee49fca9ea34@lucifer.local>
References: <20250724-anonvma-uaf-debug-v1-1-29989ddc4e2a@google.com>
 <c3f04c75-a73b-48bb-b56e-7b18e57c2382@lucifer.local>
 <CAG48ez31aVnoBiMMjUczbmThWnRGmod4yppgMVqf2Nu5-hjU2g@mail.gmail.com>
 <50502c3b-903f-4018-b796-4a158f939593@lucifer.local>
 <CAG48ez1TOULrpJGsUYvRSsrdWBepCJf9jh-xPpurRUXbMmAkuA@mail.gmail.com>
 <3cfc1146-1b62-4b04-a2e5-997d10ba4124@lucifer.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3cfc1146-1b62-4b04-a2e5-997d10ba4124@lucifer.local>
X-ClientProxiedBy: LO4P123CA0674.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: 54bca39c-b131-4580-5cdc-08ddcb9409c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REk1WkJrWXBaYVIxZTVDU3I0WkUwWXBaN0lHOVdXK1F6WXgva3dEYkVIOWF4?=
 =?utf-8?B?dU9XVnRXZ0ppTEpDSW90eGJab2JlNWJqREh4RUVWTklPTkRQcEM1dDEyOUVI?=
 =?utf-8?B?b0s1OVFHZXFDQW1xanRGUnNJenQvaHRKcVBlOE9ySUJNeXMrLzdwcXUwM2t1?=
 =?utf-8?B?QUR3QXlXMXk1Tjh1aTY2b0xwdkpJd1VMMHBDQ0hyWDhoZSswbzVVZDhxNnVu?=
 =?utf-8?B?Q3B5Y1Q0OUUxenNyNXY1Q0FUSjJYbHE5UnBZQjNUSUJ3UlgrL0hHMS9hUG5n?=
 =?utf-8?B?c3Y2R3VqdGFtSUZIb0lNTmIwOXYwZS9walJ6d2xYUk96VXRkTkVNTjVGQUE0?=
 =?utf-8?B?Zno2cDk1bjMzZERjTVJUb2ErZWZRN1FCbi9la2ZjdWMzQ3VMaHM1a1NmV3lx?=
 =?utf-8?B?ZDNXZGl5U09LL2RmS1Q0L095QU9ZWm9maU5EZ1R2N1hOWmVrMll4cnFWVkFk?=
 =?utf-8?B?N3dDWTEzTFdHNndGTHhUeXpHUmJ0SnlvcWZkSCtvaVNDV3RWVUZtL21qNDRL?=
 =?utf-8?B?SW00NlhLVUZrR2cvRFlxWHBaSkVDWnZodlFWZHNuQURzbmlJYlBkd3AxRFJC?=
 =?utf-8?B?Y3NzdUEwb1BGQVNTRllJQXZtL2pzRGppNjNHZFdOWUlUdHhUdUt1NTBTeE5t?=
 =?utf-8?B?SDdnRTR1UnQwTkNNSlAzQS9LdERzeVhkOWRGZDJKK0lWSFRnWTRFelF0bzBD?=
 =?utf-8?B?K1REVEtpcC94WXpNVG5EL2tZTkJ4MGg5aFpvNUNUcmZGQUJZSmoxcWUzQTdx?=
 =?utf-8?B?MWU0R2lWd1NRS3p3T3kxVjM0UkEzOUVia3R3WFVCdWMzNlZJUllGVzFUSmhs?=
 =?utf-8?B?aFZzVjA1Uy8zT0Y3ZXp1Nit4alFUbmY3L3AvVW5lVTRwR24wRWpvbUg5WHow?=
 =?utf-8?B?YWZ2cWV0REhvNHRQYlZOUEtCdGNHRzNaL1FPcDJyWHFWNUJEWDdscDdNKzNM?=
 =?utf-8?B?UytrSGxTcms4OXg5dktJY25SZG9UL2d5REhBNTQxNExuMWlNdHI5NmtpVG15?=
 =?utf-8?B?K09adnpUVG91MTdRdEZWK3VXcU1DWTgvczFjaTJ3MFNBeU5XM0RtL0prUmZ3?=
 =?utf-8?B?b3FLRVpPK1FMcXpGVlFqeWphRFg1WmF3bHBIU2JDa0pyem1leUp4WHBuV3F3?=
 =?utf-8?B?TUtWMkQ2aGc5Uk1rVkxIaHNDZnV4SEJhcUVVSlZrQ0V1SXFsMTE0QmJQZkhW?=
 =?utf-8?B?SzlkaWdINmJVYVVLQ1pjRVRqWldGclVtR3AzMnZSOVBWdzF6ZFJFd0syVTE0?=
 =?utf-8?B?MlU4ZGdPTVhlbThyZXd0UnRZcGtwd1piZ3FPdU5nMFRJa0tJOTZDTk15OG1J?=
 =?utf-8?B?d3JnZGx5WE93RG91ekYyYzJ0c29WSVVJZHRtTGJEZk1iNTM4ekN2MUZmZC82?=
 =?utf-8?B?L0V5b0xkazVuQjdHSFBLWG1RSEdVekNFeWR3UkJlQk8vV2N4M1hGWjIweUNE?=
 =?utf-8?B?RHBQOC9JblFOU3duZXpUd1FGdW9PNVlmdkplZG9aR1lmVzlib2k1bGRzRTQx?=
 =?utf-8?B?dC9iOGo3cHhLZE92ZDRrQnE5OVVhSkhlbEZ4NFNPeHVMZVVxSTNCZ3JsN0l2?=
 =?utf-8?B?UTkyeWRzU28yRUE2UGRRY0VUeHdGbUNEUEtJMlRTRWk0TzkxdmlYZEp2bFJu?=
 =?utf-8?B?U3grV3BQMGsyd3A3MHlOdnc3NDVVRjJiY3QyUENhMTRaVEZXZFlvalNOMG5F?=
 =?utf-8?B?cWFwMW51YlJxWHhPY1ZPck5Fa3VnSnU4R1RLYWpKc0JaNVBWL2o1cFY5Sjdi?=
 =?utf-8?B?SGlWenJ5S0lFRUN4MWhLaytGejFuYWcvYk5lWnJIZ3lmLzEzUFR5dkcxc05t?=
 =?utf-8?B?SldVNE9WK0VnUVc2QXdMWnlmQjd1L21uWDhsbGxxT2dKcmdlMmFKMkVhK0kr?=
 =?utf-8?B?Mmp6djIrVzFsekxEMmovRThZaXc3V1lVeEI1YnNJaCtoV0twUVVtQ0JnRnNy?=
 =?utf-8?Q?i7FV4RvK94E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2h6aG5zczFnSGpHVE1CdEJGUUdUOE9sMlZQaVk0MXNPaW9CWVNSRy8xZDl1?=
 =?utf-8?B?d0FyR3ZGVW9oOHQram5td3E0Q29MT3VWTkN1Z1BPQXRicDV6cUlLd1lrY0lS?=
 =?utf-8?B?NjlMK05RR2l4MmpUaFQxUXhFSm14ZXE2ZGU2WDl1WjNMUGRMbFpUdllSOHh2?=
 =?utf-8?B?Tm9kaDZvZ1FoV0J3Q2x3QXhheFFYZHp5dGsvNUF0OTEveXRIWnZuMERTU09V?=
 =?utf-8?B?aE1NcDVwN1BlWkIvYiszZjFDTEVZaXJDZ0I4M0Rhc1I4WER1bUNQeUczM1B4?=
 =?utf-8?B?L0JDaXJ1dS9BL0IwbUtWd0ZpaU9GaDJMc1IvSjc2V0ZXVXZwa1NYT0V1cENn?=
 =?utf-8?B?dHI4TjZsOUNzUGVCeWlIaFRwaVdSdFRLeUdyZFpZWlFmUjlFeWhZZUhFenpL?=
 =?utf-8?B?OU5xeitvc2lnWE41MVJ0U1lvbkRrendnL1YxK0VGZ0plbVpVQksyR3VLVVd2?=
 =?utf-8?B?RzgvdmJMaW16RWFYamVtVmU5ZExlVVNZaXNPQW1SbUdWYkZxMTVuMGZVbllF?=
 =?utf-8?B?STBCUXBiNUlxbTZwUzB6di9rMGE5Y0lEeHByZUpUT3R6VktEK25Zd2U4SWVv?=
 =?utf-8?B?VVZUVy9rbDFQQXcxK2lJb1dFU0gwN1BNY1lBVkNVMGo1emR2eEFLeFF5K2RC?=
 =?utf-8?B?Nit1dDRkSVFZTTRLOWJ4ZlNrOVZ1NEpXV0pTWm4xYzFFSmdFTFhSTmpRdSts?=
 =?utf-8?B?UmlXaUx5blpqSEN1U0daYmFPeTZNb3E3UW9Sc05Eb3Y2bm5Mdk82bGdLbDRi?=
 =?utf-8?B?RGR0dkdjTDk4QjZIMERVUFViT21LQ0VlTUJ0UWVHNldnb0lrTmU4VnRhTzM4?=
 =?utf-8?B?OTVzQ0tsUGNxUWVsTEcvZXhYd0VuQUwrNEt4THRLcTNGdXVDaVdTTFZyQWQ2?=
 =?utf-8?B?RmFDOGE2eGlSWTR4bXQwTnF5ZkRwNDZ6WThRTUtyVklLQWhvVWQzL2RHU1Ar?=
 =?utf-8?B?M25CbGNwNStlTDcxaFFMak90NGNVUHFrRkpwRHNRMFM5clFaeWdqSk5Gd2N0?=
 =?utf-8?B?UE8xcXozR252T2tZMllacU9aNWQwczA1eXZnVUlGZ0ZWSnJCTzBxclJTVDZt?=
 =?utf-8?B?Tnk0c2NReGQwUkppMVdKcXF4YW50dWhENEJtSFRpNHVXTitSQXZOYnFINHF6?=
 =?utf-8?B?U0tRR01jK1lRWDQ4Uy9hdGUrL0xMczE1OU1COFkxdzZHdnlYbGt1eUlrU3FG?=
 =?utf-8?B?cjBieDRFVGMzdm1zMFVDVVhjNDh4Kzg2ckw5Slo5NVgrUFhRbitrQzl5R2Q5?=
 =?utf-8?B?emRMWElkUEo1TEtYcm1BMWg2WVlBVWc4alhLN0dyYmo0NVovRTBhMXA5NUY1?=
 =?utf-8?B?OXFiNC9ndVQ5dDVURmlGcnRQYUJqRk9QYlArMkl2MXhEdnpUcG0vWlhYYmI3?=
 =?utf-8?B?aFRmVWJmcTRhaHdVb0UxSjZnQkNkbUJnOEw3YzBVajQ4SzZ2eHc5S2ZrSlhr?=
 =?utf-8?B?MzJ6SzFob08weG11RjluWFdGTmFMM01DQUx2OVFoS3N5MW4wVkh1VGluWExp?=
 =?utf-8?B?cnhHaFlRR2RqRDZjbE5QUktxSTNWR25sb0NqcW50SldrYVVNdjIzVXdEQzA2?=
 =?utf-8?B?SXM2MlNxTUVQN1JrUHJ0dEkrTTc1dlYwRFNYRHlRSVpmeFVmL1NtYS9Vc21W?=
 =?utf-8?B?WnVsbzlETFBNcGhKWnIxMHlKSjlNcUN4dkY0K2NaZ3lRTTZnUEdxWHZsR2Nh?=
 =?utf-8?B?RGJkMVpkNHhZUTNGd2JkSjdXTkdqS21JTG1TcTU2TW9DTXU3LzNFSHFNUVdR?=
 =?utf-8?B?SFNIQXhwV0QrL0w3d0toMENxbUtNUzNkNDFQMTFqQUxGU05FN056cEZEeVpR?=
 =?utf-8?B?WmtpLzdYaXAzS0g0K2RqSmNkTzFyZlR4RzVYREVFRXpiSDM1cUhLVlBibml6?=
 =?utf-8?B?V2NBSFVZeVJ2VDN5d0RwTE9BZVpobkF2WVRnRTVOam5FVTVvdTdxN3hNNW5j?=
 =?utf-8?B?UTVGMGE3Nm9tTzJGdWhOZmdDU2FtZHRDSDFTeGFrYUN1VFBsNFhtNDdWUWgv?=
 =?utf-8?B?V3gxWjFzc1RsK0xwY0c5VEJoaTVyaGJXVDRlR3UwS3VtWTlGRVYrQktEOWh5?=
 =?utf-8?B?WmtNUTlPS1paRGQ0aHR0NFYwakw5cnlzUXoxYkVUQzYza1djckFTMXU0U2hF?=
 =?utf-8?B?czY3bm9BREJFZVYxajNVMTNrb24vQkNETzJKeVhCd1hHc25Ld2JORTdaQ000?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H/bv32nf2Xlnov5rVryVx2zbXincD+zK+x4EATvkCHiud7SEbk3RhNyq8qvnlPeAhle0EE5q52qgE0T21eGtviaysgrEZJmgxpbIF2+dSyOnTGvrU/eqOeICR2/FlyYwu92sDHAleIw+vvo2mpZ7PEBT3gd88qQP06In/5UH8eLQiGNg7VoRrFaK2CcT6nODbeDK3K8tCoudFlXPZJcZWuFX57hpueEp2UEpPk2cMrSoFys7J8IIexeDMi+ohdGSlbJA3w2b4s2J5FBtp9HURwfsmINFs1PY5wiY7cpJVDIGJfDhylZvUnMnDXOP1vt1ZMrCGxEHLNf5jXOByYT9HJ3xNgbLm49RoaFoMfGA/qCFpYfOgzeAZK/VzmY6i3VAMQq3xbydwTO07NrL//HSJGVWeu5wGPdbzDlryKUlLMDBIce95wmJ+T0FbZuPpKFAQ/Jz++C1HIvtm8ugd23cdTJX8yViDzfjtoPiETNs169oh9hMPPXM146QvUPEDM1oomEl2AZCfGG1tUOOFO2naL1+tn+Bv1R6oaFS+d844+14+X/dXjb0jaaIkYobwNIGnmv+lSgGhmpH5cwoLSwKk04RA6SNmVctg1DMTZN27V4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54bca39c-b131-4580-5cdc-08ddcb9409c4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 15:58:03.6779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8ag78qljpJp/ep0znvlXymSTzGTFwR8DtyPU+mEVFuxccioqqBArCABKj29kBNmi43AwqPJfZLqrxlDxuVCIZT1woYAxZh7B9qXM0pVVos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7225
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507250137
X-Proofpoint-ORIG-GUID: _hRbR9pImYQogVUQAq3NQ339ZXpui3f2
X-Proofpoint-GUID: _hRbR9pImYQogVUQAq3NQ339ZXpui3f2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDEzNyBTYWx0ZWRfXxToAsZEUjpCe
 WTZgTI+GTcIH+SGFOt1ooPVhYigVNlLOySvQj0L7jjkrYlLC7HPo/hvbxx1H1orVgN+T2W19y5v
 4z3RiV4pdb4VBVMNNblCezo3TFpZIkW2S6+Ejhed1tISppvq4yiTFgYp0BJywFdlR1cGRBEMylw
 6/6+loYqsFgmCN7x80Md8tbeS2MVXkLg/pcQv6v4vUcAHiy6MD0IulkqJu8UqT7HrGo1jFiIhu+
 kpqwEIEdF7RzUByNYVb6/Rm5AQPj8v1G2VK+4a4fx/7eB87JZbdiPqH8qln5hGk3r7obHK+j+UQ
 onSZ42eyLDCWv1Z5ApWaoOHLU8RlsX0XIslyCPy3aDzeInamOVLFs7Q17WWdYXoywqnNZn9WhVF
 BUUMvwO4UpK1dwUx9Ih3yRfAARD30/r0cO3HCbLbczZguPywXnR3qos4xyRl+8/S/q5Dyro2
X-Authority-Analysis: v=2.4 cv=Jt7xrN4C c=1 sm=1 tr=0 ts=6883a9a8 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=6g41kB_GrF0mBZyUMAcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12061

On Fri, Jul 25, 2025 at 04:07:00PM +0100, Lorenzo Stoakes wrote:
> On Fri, Jul 25, 2025 at 04:48:09PM +0200, Jann Horn wrote:
> > On Fri, Jul 25, 2025 at 3:49 PM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > > On Fri, Jul 25, 2025 at 02:00:18PM +0200, Jann Horn wrote:
> > > > An anon folio may outlive the VMAs it comes from, so it may also
> > > > outlive its associated anon_vma.
> > >
> > > Yes, I will share some diagrams I did a while ago to outline this. They're
> > > ASCII and make you want to cry! :)
> > >
> > > Hmm, if non-root, I wonder if we
> >
> > (looks like you stopped typing mid-sentence)
>
> Yup,

Lol I did it twice, yeah I'm tired man.

I can't even remember what I was saying... :P

