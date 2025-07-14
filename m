Return-Path: <linux-kernel+bounces-730443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8B1B04499
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0441887101
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FDB25D1EE;
	Mon, 14 Jul 2025 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="daxCJLd5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UbVIGXvj"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBE82459D2
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507856; cv=fail; b=Bm8SaGXOLo76lEVHQ6d5oVYsHaMfZoWIv1tIiCnR5M7v4cSOiwWg4Ds0+KNjZCsjXJlr37mfY9fKldj/MfpYaAL4QXgk2SdZSoaJONAXZIQMvu6Y5ysty6y8SySAgw7/8j401JOcLETexm8WW5QX6lWM8ayUJd+aCz1oRx1kbt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507856; c=relaxed/simple;
	bh=ABJHqHUUoYtkMnd9HK7nizWvVo0i2HMGliHEL8YDMP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P7rJvSI1xkCiXtfG1m/uJFBZw4aSfXcFyLukDESoyRZSjkYImeWSiLW+IQ+PXAfQCuemeLafWSfvtyB6w69YHQtt1g+4b6H1XBiUmo31IHyIZosS+ARl+frMcscUQaiShuX1vByLtTEAzpDsJdhLLpo9d5SgSIIICoMyDtLWKd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=daxCJLd5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UbVIGXvj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z1cd026728;
	Mon, 14 Jul 2025 15:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=BRg7NhNX0OXTKG3dmY
	lubO2auTUBRGShaqWFEgRm6PA=; b=daxCJLd5O8nFVp9vbvzkQe9cZsTmL9lHf8
	JTemf4XHW1V2S9vCPIldTxpldjwTKf4JrflWFGYzQkJYRyL8tH0+9dYryKep8R8B
	/q7BR4hXUQkQyYyNleo04OmWEzF4M6Ap4vE2wIozOOHFv9mCK9yV5zYpKQxmmXrD
	C4DN01TwcSkk2Crmipi8Jgdu1FWrtaXgCu5tJvFiMzk+RKoVvKchrJPdNauIidZ2
	OR2Y3e02a+hByEOU2SMI7RfDmRniwbgLcMPWq+yeGT4NQdMkuxSXA60xg/z09H4Z
	clZ68qmJIn5Nmbty9gw+X6nH7k64EmzwXT04lZWDDra7ncDRdzSg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjf4vsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:44:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EE77kx011524;
	Mon, 14 Jul 2025 15:44:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58nveq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:44:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktgO2OrnO78ksnP6KylfOlCaPz2VvgAqDo1518ObYZSC5zneBeeAkFBZ59YB7QgXy2xUpSNB0EWg459F79mz9zh4NDn9223oIZlSDGKVuWNTN3KnbOn0fEND2Mrj+KQ+xwVKc7LFeEjFNatew8wDTWDFhyT58SxEycZOxoxNw7KpHfw9zLDD484b6mwRzvuKXK1EBLAANOUb3okWjkD0QPXykXosdc6IVnKE7ByKbJr/vjJYfYwsXT4aNi267YaVx9DZUGiUUm8NT2pQvWGLOBk+ubFsdvEV6T8eUqyOiuZBCwqTMzKtNHP8tSm7MA4uMDx6W3GZpvoDTTLpXDSX2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRg7NhNX0OXTKG3dmYlubO2auTUBRGShaqWFEgRm6PA=;
 b=BdvTIu5GaASSvji/M5M1z98FAzW1fWGU9VQR8Ltvxzc9elkh7vIaBjnPyNxxSLh9kBnh7pMX103W0qqdgCbQeUY5sLkdH6OZXbj4gWxQXCOFgslN8ZWIVNBe9Y/9cv5bYQGUSfjzo4Eku6LWwD3oSFXZA6sNZqlhRzc4zyytjQOgnIyEoV5CxOIkUV30Ge17RptgjxlESQOiVPxuX8Zmzv2dOJBNTgJxrGd6H/ckXWkFZKXSBWMwby17XrwoPe0x7E7b2bR+PppzeEUEPo6iXMXVntV4TWqUCiijrP6rjkpB2oTyWQXA/8fifOgdeNACCZ+PQ+SGWjrxG7k0iDnWLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRg7NhNX0OXTKG3dmYlubO2auTUBRGShaqWFEgRm6PA=;
 b=UbVIGXvjw3r7154+N2yY8JItUz6w4p8y8S3YGblc76gDzL3n9yIMXl5sbjhuCWw1gh1Uo11cqdvT4Fhx8c1emVQaeGpwwDQBSOg1f64I0fG7wORn2/wxPVGOmGF3hstzJqWGJqFA7CwLccS/CXLvNFJiC59R8lEK3aww4bn8Wgs=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH3PR10MB6788.namprd10.prod.outlook.com (2603:10b6:610:14b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 15:44:01 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8880.015; Mon, 14 Jul 2025
 15:44:00 +0000
Date: Mon, 14 Jul 2025 11:43:57 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH 4/5] mm/mseal: separate out and simplify VMA gap check
Message-ID: <awqb5pkf5fvrlz5shphy26zlbeopw6oc7blpm2rdcceszqzjce@lamh3fx3ldzi>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Jeff Xu <jeffxu@chromium.org>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <f010ec1ce65f35dbe1fbd82ce002ea833a7128f3.1752497324.git.lorenzo.stoakes@oracle.com>
 <mmqwb7m76ty6gmazw7db35rfow5vq66a72qa7rwjhnkh7o3j6t@2bk55s6jqb5f>
 <bb2ece09-fa16-4f4c-ad29-bf8de847411a@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb2ece09-fa16-4f4c-ad29-bf8de847411a@lucifer.local>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::15) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH3PR10MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: 7423a9df-452d-494a-7c76-08ddc2ed409b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oa58Lyw5paBKrmIY5Z9CozwZuRYcR3dBYILhLiTXep8Knhxk/jzAWwUMLoWW?=
 =?us-ascii?Q?JsyQ5F5FeO0oNI7eYK5Y4WEmNYTQGtA0B2d4HXNn3e16KR/iKqrnSPAiR1iA?=
 =?us-ascii?Q?7tlXJ7yaBO6EaaI53qpW41z2uFeVloyiSRav0KtWOQeTQPu0jA4Xk83pMSzN?=
 =?us-ascii?Q?W8ZQbJt6ZBiAbOSSL3XwO4yhjlVcdgkN6b4fbsqnUod65/jlqxm+ZO8qQ5EA?=
 =?us-ascii?Q?Dy54w8b8NwUZovDqIEQ2aXi4XBThVmNAlJdX6vWeuz/Hj6w5s0UfgrSEKd0q?=
 =?us-ascii?Q?6GJ+8hndZoqLul371Ik6DxTrnFk6HPr9k9S2ZnCK5F8vCrk/u9FeJCPi0mHD?=
 =?us-ascii?Q?qvrOlIOi71dBz874+gWfYlupKQOGM2EWTFxrsrpOFVGPFcJR896zd27GhUVU?=
 =?us-ascii?Q?5ZcZiqJiqFp99RI5zv/Q0unDZMd1GXpQVU7Ke23gjD0+m2+NRREGzLPGgahl?=
 =?us-ascii?Q?49n23ro9Vs2Hosx5OSTo2tl4iE3DF25YbMHzIDNdeqPKSD5xPMmNcPS9/Gvi?=
 =?us-ascii?Q?+VVJSS888R9yE+qoCHE1hUq8BS0nt1o03qiEYz54p/4KDVtEs5XyvdsBZ1le?=
 =?us-ascii?Q?0mlF7Exz/kAVLyYLSRF5iDPvD4Ska+KppvlIGALlKvQBtuGRWFvEqBMfmoXr?=
 =?us-ascii?Q?oHXHRWg5RVxlTMge3HD748ScI0TNtI2a4IJUKgrIFTNd/zoAA7CGtLRAJzuV?=
 =?us-ascii?Q?mxEoFjSspy3+jlkUIpQiIbhfvXos1dDKNKMkDfNLold2b7xqHA7H2ipy13q+?=
 =?us-ascii?Q?nnJQeMjhoZmLfFVUW7tljQjDd+GDFrhffZAiBFsaVbPqKb3nzYibCLjjywVo?=
 =?us-ascii?Q?sSPh3Su+p18mWQ9Q28c2+pnrzMuxNiLcG+Puchzwxd9z6yFbDllNjTW0bHOa?=
 =?us-ascii?Q?HR+n1kCq7zfPZI1G45mgAxvPMASdYOFqj2IIvrgnCNvEMO+ECLdANzXonerA?=
 =?us-ascii?Q?lMigbHhvrDTjE5llVklSXQYea2v81vwSwJCk474SyleavaCXpDbcOv4fRy8w?=
 =?us-ascii?Q?+3FrHSmQswI4Ub3mTqMSLPRtxYVoEb1YuQArKYp+NSTY6Rlpbp9kG/vtgo2r?=
 =?us-ascii?Q?QfJgCe69/yG8satTImZGt/x1uBfEMROZJYvJ3Urg7HdLiDstDOOD4kguGLnr?=
 =?us-ascii?Q?zVEKUC7Km/4+H2Dj86A/BiVrUUF9IyUq5s65HrIh0NgPpEPhSJ/+a7Cw6Rtl?=
 =?us-ascii?Q?rwus8HJ5UAqDH9D/vnQv+rqTFD/8I44Ydm/Cszzuvba5UgNG776PvB2XPETT?=
 =?us-ascii?Q?IsVbKLiu0JcCw1OtwX793JhzCYmyt/CzmV+yVtRbdETMfhwEkzoYAOmZ8F74?=
 =?us-ascii?Q?72C9VPLWlr72cO+jQDBU7Hqc0DiQmrKC3tqtLMlPDezCaQeMZnqdepa8Gy2X?=
 =?us-ascii?Q?2eOUfZzviscKw6VC/3N9oheiqzXjELFQfHK6sKNfF3305qXhCh3xcpad3R+0?=
 =?us-ascii?Q?oylIpVK1lRo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JTA3bH9tVNc+TcDufkp9ltSUlNgQpJ7776aJdPiiKmmFbA/tNGwnlnZtEXJk?=
 =?us-ascii?Q?qMK5M9qJEHot6H41C9zfcQHx5+lKnyhSHHIIooC05gT8DsccWRIpNPPrQby6?=
 =?us-ascii?Q?3rZCU5t3BKFqOO8tKlFOy8SwnagONu2eTyPkC8DdoxQ2gn3jG/PsnMUYmGCw?=
 =?us-ascii?Q?o1jkQsSVhvgqEvDPKwumZMthcRAV8c4vqygacvf05LlQX0aLguT9YoQj91OG?=
 =?us-ascii?Q?dP21WNbvG6hIQiL87RdL/EgYh8NqsXCPTIduz/CR+FvbmhU0AcEEHdTnNxIz?=
 =?us-ascii?Q?2EBOLSfkfKPNL7yr2JY+2yNJ1AKMb/zSLK6+4zrEI2s3mTQrNMOYDtHnQd9N?=
 =?us-ascii?Q?jWaWF2v5SBIsIvGKXK1h36qd+jQ6T0GqMcFXh9n2aKd4ze3BfVqbydkoEI6c?=
 =?us-ascii?Q?CWMwU7zGeZyhU3LBKxpdoAZccsHo2ZLzezbsY39b0Iyw+HjSyXG1Jzswux6a?=
 =?us-ascii?Q?5csoVU38mSzGtrDcDv1hgY9w+pCYK0adC8Phkmqa8RXcxES7fxsuctquHsec?=
 =?us-ascii?Q?7A8pa1rgS5GFUs51TAdMZEK2rW3jB94O5gAsvu/bBtwFDT4YX6+lCOksT3zA?=
 =?us-ascii?Q?lKk2C4K0Z+CtqkWFNcrTu0OcbdIMfZlk1EgtslOE+H8VCkE3NFH5FbfKpTOE?=
 =?us-ascii?Q?LBIRIIaLyKk2ZUVYFK5380YCGI9V0VTrdGEXYvoNdry1I+Sv3lS+HHjEoSoK?=
 =?us-ascii?Q?GJp1W56gd4kw/xB6EWOo0decySySNY75gBOdjApYUdpSCNGQA6IFNugQFsm0?=
 =?us-ascii?Q?6dZOeb3c7Wg0oeheZDQTIRp/r4IohkgwDMyfX4kJvdLxhMZsVQ68RSC2QODo?=
 =?us-ascii?Q?hL27q2j4NSgG/i/zg02R31pXvpcmDoHnkr02J1XzYvc4LgRRXmU3+LeZelDQ?=
 =?us-ascii?Q?y54iGdn7cFIdA/ROKIMu66wuyWDQtJAfa4NZGvZ0xH23HHh1rqD0WEo/wISM?=
 =?us-ascii?Q?+V+VhbKuhRF9ZOZ6REwRk70uBLgrnFLBuhoPnfsoSQ9X+13EaPWb0UjkTb4O?=
 =?us-ascii?Q?BHjXaC3sld93Boy1wW9/y28kzpnOqTYtHPFdHIOnbqFt7gd3I/6dNm2hpFlx?=
 =?us-ascii?Q?8dRTLBG4KlmhXeNqL80vyDzTj8zRs/BFyT2E2ABYi1AmGKX5jrYd4/KEX/1Y?=
 =?us-ascii?Q?xVPI5G8s7nmZT4Nydkwp4rinH34np0KjKwZ39LrzhBDGweAr71VZ7Z2o41N8?=
 =?us-ascii?Q?KxG+OqVEpylWm7DrSt+ii3jdIY5udYP2bOKMvoSXNFhluY0AlPdIoF58Vm6p?=
 =?us-ascii?Q?dmxsva+GAEWzcV+AuI24itQstqd9XxyM7by/0vWZsebkjY1BU1kdkbM2Tc4M?=
 =?us-ascii?Q?A4qECPPqwSZqMJpYrWNGpOEVJZTWpPU9KQk+Y5M+FKUfwFaIeKQ11VHAp5V6?=
 =?us-ascii?Q?sc8gZaqggHWvi+DgcMhRbb6BudHagSYVfoin7h6ttC45M6JltVYO3ju4oH9o?=
 =?us-ascii?Q?1brjcULDWU74g9ZtP0Uv2KHld99GL3yB0hql5VU/ytT39Qj41YxxwEhZUA/+?=
 =?us-ascii?Q?uV+hp5EdjMVKoaRt0c1E5QvZDn0r2Rwl3ASxDF30AjK76Co6TtxeqZNBp1oW?=
 =?us-ascii?Q?uyjidtvRJeeeAzI5DWLJ005Vk04rRX4JKXxz7jCa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W7nSn9hi88YYYe9OhVDzKRutNfclvry0pR68JnpF2A5oAlBcHkGwMJeBTUyTUUXUjdpMaBB81ZjGEUr5dsKMP2HZIT5Bp2iSwu9AT43hKogbFPeqiePqsR7HVhBpQzXloTPRCDxKEf27jakiHa/1CVF0vbjZZ/8622Pn0wf6+DbEDKQ5KAyrQwdCTQdFYjzuscRy0aA0S9ThD4hb0dr0vpSYAkFmzNKEHsUbhHF63YZHXG9G0oEvIWlM5ElPGogO6EPtByoSrPjZN4x4u0F0xI8bHug8tXOpxwQ+8AWxJp3Ys3LjkQ9kIGIfH7r61+4RplWxKlQjJUcdAm3xzNA4w8rjgsG9Yja5OXcwJ5MBetB8AL9bHGVpFzYdxPsZ/qVLqi1N6P6AT4rY2XklNt5Fsr5UULQKu/uVXh99Qqb15H5u9Zo+RMO30nizV6vf2wvAiNsyvNAARLra0ouZ4KpZ6st2VNylJEUJaKhXaegSquMRmSgIg70EDTA92OnyD7dzZe45dq6cXMjkKyXvAPnG1sQ272BMM43EEgjkTB8DDsfIaMYPRzxfhNu+nR82Or83kvyySwHYkJ6QmD2TngzUWn3ghUUyQOAW5zlxlhffvz4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7423a9df-452d-494a-7c76-08ddc2ed409b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:44:00.4559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5/MKzr7F9pq5CB8gAZIxnQ4ARsxH8OTV2/xjElkJ5R4/jn6sf22dXjsFXQ4t3aJgQWVvIc0Mfh7ImMgwlFOvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140094
X-Proofpoint-GUID: NHf-n2QbyoKKC5_8nx-IhhPFoNh7za2t
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=687525c3 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=7lURLrRoTTkbVKKhuk0A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12062
X-Proofpoint-ORIG-GUID: NHf-n2QbyoKKC5_8nx-IhhPFoNh7za2t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5NCBTYWx0ZWRfX3rpCO0Q+DmHV MzMPUMAIV04eNhmpnrfAGkFR/H8gbmwih06tCGrAgfGyz/p53IlFsm9G7BeV/snDOr6z+agQzO/ +uRfsmn6zqsLjy9dqE9bcA0R2Ql3zv9kiHVLQVYj90HUjWd32T5XHqDtCSrK1KW2jFM+hTF3n/s
 Vfw93QFkqJ9q5IYtLiCxeuc9sSEmapYDZyNG45y7fPhdLDWWwS+2xUK4yzfIqdXtSB1/czOsymY hDluNKJSvTBisebe9IIOzhsa30FG5Wi/MF9d/YJPwn/QUzWjE/Fvm3uVrCx/6q5kiIDi5uYWiYc IyaHyCmc8/mULXiRnc9bJ2CU3Rd/cO6BL3jM03djZ2qKhN4fZP2rnI4xEuQkqL9h1qQvWbLacHy
 cLurpAyMctsQ1VGtoXYGHfwmpJrdOBuh5iKZwgswQfPBWmeLuuLUDCtzfunrZgniWtvPLPXh

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250714 11:40]:
> On Mon, Jul 14, 2025 at 11:35:44AM -0400, Liam R. Howlett wrote:
> > * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250714 09:08]:
> > > The check_mm_seal() function is doing something general - checking whether
> > > a range contains only VMAs (or rather that it does NOT contain any unmapped
> > > regions).
> > >
> > > Generalise this and put the logic in mm/vma.c - introducing
> > > range_contains_unmapped(). Additionally we can simplify the logic, we are
> > > simply checking whether the last vma->vm_end has either a VMA starting
> > > after it or ends before the end parameter.
> > >
> > > No functional change intended.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >
> > I do fear that people will find this function and try and use it
> > internally, it may make our jobs of avoiding this being expanded more
> > annoying.
> 
> Hmm, surely we should have some ability to dissuade within mm :)
> 
> Thing is I don't love having this function in mm/mseal.c when it has
> nothing to do with mseal()'ing.
> 
> If people want to be weird about gaps they can pretty trivially implement
> something like this anyway. Probably. Possibly. Maybe?

Yes, but the existence of a function legitimizes their thought prior to
sending it for review.  That is, seeing a function that already does it
makes okay to include the option in the planning.

> 
> >
> > Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> 
> Thanks!
> 

