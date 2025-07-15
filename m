Return-Path: <linux-kernel+bounces-732241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80442B063ED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1D75580F5F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E9C1E531;
	Tue, 15 Jul 2025 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bZfiqfxy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X3zinA8F"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3A815B0EC
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595777; cv=fail; b=Eq5WZaKFYPiinjxcDj18n3phoAjnifPyHcgtvSC9jof9p6NeT42evWRKoM8YpcOWFZdsfXmnM7yfQcBKEhm0JGp0XBzc9d0a10v/l82zQyE6bMAQHYBT1UgNRYE4h27j1/p1xishml5ua7zB0s9/t6dtqjYuI/4RLwc9NW/58lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595777; c=relaxed/simple;
	bh=s42T6BgvvCHDgYixR1l/vYOrhiCN9mSp7m36Dnakc7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MHxn8S952oADx+InkiPR80FRzSrt6pnQ186AxClmt4W7rHbdURTSRoAQT9b1fzwJhigJsejQq4h1WuOmFBEgod6AlklEyKO2EimO4RbmeCijHEqKnc8Vd7piAn3LUIPvGYxJGf7MoZ7AQW/o4JQEJmONx+nTc+HL6YXC+HwVmWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bZfiqfxy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X3zinA8F; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FDZCJJ019089;
	Tue, 15 Jul 2025 16:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=FnFtZogJaL9YGK2C/f
	lETxdtTWMMN/4MAgv9CVQgIxM=; b=bZfiqfxyh//zOqrzkf7w6+LnM0E6nltxOj
	b4XvZxyOuHjIr6eU1WNbQA78c+3zzyg+Q19SQ8g0peEUPB66zVU9P5Dcvq8lofeG
	UVVfpwmfq5z82EBJI6GvgQK32VO3U1e/ZFw735TX5VS28HXhyBEuuJAJinxVyuMa
	70G3XeyhnQDp8dm5G9NIXIqO9aphr+R9wH2nIHXWrWzSrmHbUtOh35486C2/+oyG
	EjCu11eZY9fZ2D4EOa9L39NJMqtTxnJ5rGxY9k2KFeZ/RBdM5B0kTJ02utUpihX7
	nbGd8sna+zEMT48XLmoPsHRBsO5FVtikF9cZOdpphCl0uSDC2qKw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjf7hg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 16:09:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FG5FbV013045;
	Tue, 15 Jul 2025 16:09:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue59pj8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 16:09:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qcvM6KAOZOGdBagCOH8sEOC/XtiaOCf6iwpUIcbaMbaZKppKXeknKjGOGCsiQDJ37aZVNuKx5uAHP0cfNIf5F1hJBTOO/Q0yji5GMCDyd3a9vFYMOEtZI6sNFUayDjMqH04OqwVFSJKLKOUsrtlAiuQWaBJtvTpRM4oAuA5alhWXkyjzm0rnuG1W6JpOyhdUwenHGwFMZE2pwkT6ZcD5hjfEAzgKun2RHeXZonbeS+I2h81WGSdcbLiCwzo+lI8Flu261199AeBwM63maGfoOeKPrScBVtWHcToojSd9y4ZhVywkd8OdJ8lVPY5sAm2gc/bjfMgWz1iqY8jcBkX9UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnFtZogJaL9YGK2C/flETxdtTWMMN/4MAgv9CVQgIxM=;
 b=zRxn3qQUWx8KEoaC+WzhulWKrm+EfmHc/5MD9fSq5hqOC3zmx1VxCQbBqBHjsvIv37xHovxSXGVhB/yj6YvfwAI2dpjux6YMrZ1UGmKO55vudQsulozRRT8+eVSlAw3uNyfcqL6VD6ETZ7jbn8jNkpFg27JA6kY6+bZUFJixLJ6ESySIeGMiDar/T0NQC59ont7K1ADzYHV9zTHz/c234saJprJk9ktG7jHrnk1LL1hfdOXjrjrLW5Fgf6m242QWJR97u3NoypSPu8j2wvo6Y7E30EVeHa5glGxVrH/bGU4C4j820oSASx+pbYfwCPt7BCygN3Zn/hnaH+tCyXOf/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnFtZogJaL9YGK2C/flETxdtTWMMN/4MAgv9CVQgIxM=;
 b=X3zinA8Fa4u8ErXzXMrQ4zJUch4lEXBcOaULwfdVIy5Y7PFSsk4UydWxOfSRol0No6QVRuqquwPUOB4wC12q4n96bjFjqB1Ksyuu9GPlb1xvH0Hj+2DZD05XlXUNO9ioFVf/85tQM2JSXnv0omiH3+cVned/wJ0iun/8cl8sOO8=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH2PR10MB4343.namprd10.prod.outlook.com (2603:10b6:610:a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 16:09:19 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8880.015; Tue, 15 Jul 2025
 16:09:13 +0000
Date: Tue, 15 Jul 2025 12:09:10 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH v2 5/5] mm/mseal: rework mseal apply logic
Message-ID: <nv7vxhx5cpkl337f4qp6gdg4xvir5e3mggqaxxzgvnzl47o5b7@lvp6si5qerlq>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Jeff Xu <jeffxu@chromium.org>
References: <cover.1752586090.git.lorenzo.stoakes@oracle.com>
 <1d6abf27d8eac0001f8ad47b13f0084ceaa6657b.1752586090.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d6abf27d8eac0001f8ad47b13f0084ceaa6657b.1752586090.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::12) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH2PR10MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fddd30f-b2da-411a-3526-08ddc3b9f091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UK3N9DnlTqrY9lVl2MFTacxIdSUbQIahEYXl1BUCoislkrV1hfKr/ft9nc5M?=
 =?us-ascii?Q?oHiQRA8OdH5iEqoKR182e/wg0v8bcjJSvwL4MA1VZn/jjKbk2rh7e6BTROlw?=
 =?us-ascii?Q?8/Rja+FUpwp6yEjYbk7rNl40/bUzjNTf5hDK2Z8J+gLrPYiFwzfynaAHfhm3?=
 =?us-ascii?Q?HnzeDY/bOFAJ5oqZGDVSlkyP8eD2z5W0JXYvkoZOImfLDJ9VeGt8ggSDcQAh?=
 =?us-ascii?Q?0hNu/l7DDi93pXl81OQUIWXN+YjuteWHk9HSWSemvqSSiAsiDAPW3xXtWG1f?=
 =?us-ascii?Q?YHrd7Zd6zVy5pvxGDyW3vne9sOsaO9jicvv0tSVvqOJ+IDpuEckQCF2f8BrQ?=
 =?us-ascii?Q?SM/+YZu5INC0mXGoZAjlEU+vpyIyoR9olzVEw9Xvvu4eHSXY1ZZzhMT0obpv?=
 =?us-ascii?Q?0BX6O/rkntny3HoRx3QejICLsr7gECR2mYmkHi5qOUBgcLKjwwtjtHe+bi3s?=
 =?us-ascii?Q?IHwqF8omAJJcfjjlTi6Iayl67RRKnUqUTutQog7WduibyiouXIEWwIPnt8MY?=
 =?us-ascii?Q?una9cApyMbLqsF+Xa3Xx1vrU+Fty0wdDgcKKeSZ/A2kfJwNTPFF/0jB6ucMi?=
 =?us-ascii?Q?uSJ9AbF158gqrD59J2JzQ+aVvLFq9OkeLUrKydHfmY2RlwPKdqubYXq/pmmI?=
 =?us-ascii?Q?DXD74yVWiro7C0Q8FNwUMTrEFSgjw7+rxHNFgJS4wfUu+axkI8V1T8ABY7XA?=
 =?us-ascii?Q?pNKjjlnHA2WPiG+g8wxzMMwnktQq0hIXtnCG6s6hkzjK4jm82VObL3clqYgB?=
 =?us-ascii?Q?UNI0zmEo8HJZ73A6XqLR+/mvrfXFIgL8FzBSN/usb0NpBHd/9Ex9n4B6DCws?=
 =?us-ascii?Q?9j3Y+usEtROPHDFtmMlVVy3jXO/HygwVE+prYFqnkWczsr2kwfziBQ67R9Bt?=
 =?us-ascii?Q?p+N8optSo7EoMB8GJ68Er8ufb3MfzMKxXgiXDHFThnp8+WtPsg42XSjphqCy?=
 =?us-ascii?Q?Uq1/Z2PO022yiTYhMET6+vMIdmV7A7Pq2AT223wwsSRTBHerC7ZIg+sTUlRl?=
 =?us-ascii?Q?muEPSIUUO8+EHrfPLT3Cna5/jQLdfcLGLGdyihSLeknbBdDkhtb+7WXhGLiT?=
 =?us-ascii?Q?cbus1JmvusLNUIk/ouHkEcr7EthbNf/X2nsDdQZPTszamZlHFhQG5mubsDjL?=
 =?us-ascii?Q?cSmwZxmgT3rCBOynIl/t9EdDXtrTYrs9yHC5vCzJa0LM5/CsJgpSR8Ecdff9?=
 =?us-ascii?Q?2i2aUpSQIBByj3Sp3nn2KfrOW3v84fcyt8OYpv0Jes5DMm8pjutvipkx68GV?=
 =?us-ascii?Q?7WczWWxmcDf0THGmKd6JZYW9gJZVJuc2bFUAxN0lV/v+hM/T6FEh1fP4Oqqi?=
 =?us-ascii?Q?5G0A6f49prOfRocRzMjtoFxS9LhevyKbQ0QhcdwvZhqvZMCKmOBCIrTblQt8?=
 =?us-ascii?Q?rLHEYWajFFgmvXgnCJH0CMTf1NBziCTPIcQJFL6OlnKp5kJZSkTNxM6Yx+6b?=
 =?us-ascii?Q?JT74a3r5COM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7IIi1dPKusqC0zR5ytV8AhENE3zxkxjT7k87df73vsolLS/D929XzRe2mc8l?=
 =?us-ascii?Q?c6rhp0r9DHchK1PhU3iS/nbPei4P8xEiIiOQS0V3rhf8jxfjkzWBBJOlJIPc?=
 =?us-ascii?Q?jXD4rKdus9vz8xCBjfUblIP7DZS8hXV5cWI253erUYXIq9BfpjYK/DK0nmj9?=
 =?us-ascii?Q?Nmezsrl6q6r/oszcsh/IXaxfdiQWSo1/bnlXybh+oUPv1ANbHKdf5XJjS5FU?=
 =?us-ascii?Q?vmcVLe6lKTUAuk/WsXz+aokc7cplR6otlEHEqFk2nHsahkBGn3ymvCyxq+GK?=
 =?us-ascii?Q?5//MjuTgZFFGuLO80lF1a97bgPXVuya5p7ZZmatuFs6cyWVuwCRjyoRMo7gZ?=
 =?us-ascii?Q?LON4E4J05MvF0F/CWkwSVyPheXr40nDKaskmi7zBb5Phd+bTdepSMBLkt3sr?=
 =?us-ascii?Q?c9mKQHnToV+6MqF4kdtCl2cUh3h4YG+4Glb1L4zhWnVz8osqZAtAJYh3UpNR?=
 =?us-ascii?Q?NhdDauPGDXmfDi4wc3zStIEyYVFAm3uSsaVZJNnhzGCz4wEwKReMcB+Q45LX?=
 =?us-ascii?Q?Oc9M9GHMHEz8aXICvo8Q2f6lKyDK157HZkghd2cJ1TPc1BNJFOEtvj6emWJ+?=
 =?us-ascii?Q?mz2xpS4ZkjAlwbRpkPluoSfD7BFE9LDbK3OXjvc8C5JVUtGIbsyBwRJ92Kqe?=
 =?us-ascii?Q?7GDwd0zss61c0OL77DS0F6lHZ2XISqw4pxRy2GGRHGJMpY7MHbNz431IKGVC?=
 =?us-ascii?Q?HH9gVLyxow1ZFQxrvns7A75QvNEJuOcNkCS5f/zlMAskOzmiExW3AhiFSVmY?=
 =?us-ascii?Q?9w85xEa1AF9WsImT0BCNu4N36DgDnRSssJigbVqfL9PFFInhID4Q8ALJ65Uc?=
 =?us-ascii?Q?fvVPMdBqFMUjs9k0slLRzBR61fWsuEGUAogTDZB/XGqvitqSea+DataC0lar?=
 =?us-ascii?Q?QoAEqWVaAdSqRISz6Lo62GCUE55tOSQAFLoWHsd998eGz3bmTA0uUpnWJUtQ?=
 =?us-ascii?Q?i8sYRLK6qW1gdP4Gzu0iAYOAXJAzRUbixZ3z5Y5SzF1tM3Dy4kbalV99sspZ?=
 =?us-ascii?Q?UcwSEIZD2NDoC/18t+DmxXGEnUKONxUopDe30OnIqLstP+5oR02tetwtf6r7?=
 =?us-ascii?Q?dGiDnFTVhKTOrx7W9BBLOdKMASZkCnlSmbb0UxdUL8UZKxbn1hYfYbSTgEIR?=
 =?us-ascii?Q?NwTHR4jT1c3p8E95QvmLxSAUwYBDjO3+gc1qnn/PqP75CTFzJm6rO87iT5KL?=
 =?us-ascii?Q?T1CCFbg3w2RgLeQ0mrkG+rD+FrucIfMFOYNQj6/nfFsjZJvXVSV/L/bu+YsA?=
 =?us-ascii?Q?O1ESIPMQmLH/7AdT1OMcna+ZJ4JEPUEn8R9GfJPFl76cW08JGQzMVUWYqWjU?=
 =?us-ascii?Q?DZ+RLrKP8ODTtbm8NZPbYn7Af5fXU3r5nx56ZW41fACNG6UispO0+340GJOh?=
 =?us-ascii?Q?dXR/MxFoAYW2xpV2eA9sT7Fe7YlkS/T4apndi1TAJRbrrUVBBsl2aqBYhP3M?=
 =?us-ascii?Q?Ww3hrIfnPj1wOdwtpe1cqgi6AQmsD4e+pPd9EPKNzSCQnWH90oY7Zi0pl1NB?=
 =?us-ascii?Q?6cnMMChsdPA0cLHeHuzbG7VxgHwFSpqk30L0uT+TEyX/XUX1RlHCB7Vl/OKi?=
 =?us-ascii?Q?PuEMlpmxr11f7H+j/CDfXKqYhpNMutWd3qs6kpK/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qv6ydUz7UGAkQEyx+NDfbqqeThkcvV+ZRUYVGFn+Z/Npoldf9/j9FkB2RZ9AeZ2HHYMIzxSditZVWyZhJbDPnNZPLUim68ND5dT9HToA8i3TwycVwfcz80dcg/aMpNaH06TcEr0MJgblyL7lxz2bPgu/ouz0J9UvpFjrijgayxyv6RNg03phn+qb6aLZyFqPu9gldn9o0f0qbf0x8goz59tC7RB1NBltsAmxgfRTPCqNcJEtbDpcgkZb4tjwjVx6DjqCo4btpbkPmlzPPkfuaiN7372kIz/vzW8UcXm6au0QGhJOp+HiZoMmr+Gamaw+1BeAzzFLmlu8negFIheIW7QvAqqPMIvTj90GmomNW1BMcyZQPGC+KesZ93qgVMrwIuiQQM0g9bst6iYOqwoVo7xZuxDh1m+RegLf9LlPBZhphMOpSz+v+R9JWyBULf2//aNNKwzZYkH9QbTHy1FjpiWwiQRhqiT0NiVaAUIgaGjrT89fQJZdyG1MJ15DnABLRgwLPXepuI/Qxmg1Hj/++vNlCg0eEzYILKmGvjVBP8jXOygmSaiskZpQtSpGUCztCkmzd9WkplJKy7PTvVkhe16D+kjx6JvjOQP4T7VpQpA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fddd30f-b2da-411a-3526-08ddc3b9f091
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 16:09:13.0898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCCj0uZVao2oc1pCeMjmB8+pVqQkNHO/vjyAISchv+AdmGBEDOlVrK80YP9DTAKBa7+irdSIeirwdEvNBYRsXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4343
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=868 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150148
X-Proofpoint-GUID: 3cVcNDovAXOY5UALSlffvVZ-ku36bBNS
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=68767d34 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=pHnra1Do9GtSYUKS5sMA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12061
X-Proofpoint-ORIG-GUID: 3cVcNDovAXOY5UALSlffvVZ-ku36bBNS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE0OCBTYWx0ZWRfX9nQfMA12jZJU fco1tNQSllYJsDc2qCAWnTYT8On+6np8GU95FVVKGvh7NKkc66L3RRvMJIB9PdKCOJ4UDLDQTCE S9UjN+7UXA8rL3+qPAaxzeJBHvVv4G6SxF1U5F43ydCUMzSQhl513qVM655EAAbGOc10X7Ybbeh
 TKq6TDRI2AvzRrzq/sWDr/KWWeP3LZDeRfWMUtv853tdbAZHp1Tbb5cs157JGO79j5AzPL5bSIs oAcyXT1inyX6Yibj01dJxhfEHMX+/4ujQEum4NumuqqSXJLBEKS2JDNhMIwZ5Z4WwghoK2WwljF T5JdgF5+KODQCz3T0cSCWdGDZ9rFBXwJXYZU2IyWno1Qldk4HwqvaeoJaj2jy8OROeapbvmQDab
 G/1vhrfaVofMWHU6j2kDyNw3p+XQk/0uzh6x+9EtL7Jc9ge+JSFE/kgms/BV/8lPj9/rm2MF

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250715 09:37]:
> The logic can be simplified - firstly by renaming the inconsistently named
> apply_mm_seal() to mseal_apply().
> 
> We then wrap mseal_fixup() into the main loop as the logic is simple enough
> to not require it, equally it isn't a hugely pleasant pattern in mprotect()
> etc. so it's not something we want to perpetuate.
> 
> We remove some redundant comments, and then avoid the entirely unnecessary
> and slightly bizarre invocation of vma_iter_end() on each loop - really
> what we want, given we have asserted there are no gaps in the range - is to
> handle start, end being offset into a VMAs. This is easily handled with
> MIN()/MAX().

The vma_iter_end() was to detect a merge with the next vma and use the
new end, since the code you are replacing didn't update the vma pointer.

> 
> There's no need to have an 'out' label block since on vma_modify_flags()
> error we abort anyway.

Ah, in the mseal_fixup()/mseal_apply().  The out label still exists (and
appears in the below patch) in do_mseal().


> 
> And by refactoring like this we avoid the rather horrid 'pass pointer to
> prev around' pattern used in mprotect() et al.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> ---
>  mm/mseal.c | 69 +++++++++++++++++-------------------------------------
>  1 file changed, 22 insertions(+), 47 deletions(-)
> 
> diff --git a/mm/mseal.c b/mm/mseal.c
> index 794d1043a706..e0fe37623632 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -15,60 +15,35 @@
>  #include <linux/sched.h>
>  #include "internal.h"
> 
> -static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
> -		struct vm_area_struct **prev, unsigned long start,
> -		unsigned long end, vm_flags_t newflags)
> -{
> -	int ret = 0;
> -	vm_flags_t oldflags = vma->vm_flags;
> -
> -	if (newflags == oldflags)
> -		goto out;
> -
> -	vma = vma_modify_flags(vmi, *prev, vma, start, end, newflags);
> -	if (IS_ERR(vma)) {
> -		ret = PTR_ERR(vma);
> -		goto out;
> -	}
> -
> -	vm_flags_set(vma, VM_SEALED);
> -out:
> -	*prev = vma;
> -	return ret;
> -}
> -
> -/*
> - * Apply sealing.
> - */
> -static int apply_mm_seal(unsigned long start, unsigned long end)
> +static int mseal_apply(struct mm_struct *mm,
> +		unsigned long start, unsigned long end)
>  {
> -	unsigned long nstart;
>  	struct vm_area_struct *vma, *prev;
> -	VMA_ITERATOR(vmi, current->mm, start);
> +	VMA_ITERATOR(vmi, mm, start);
> 
> +	/* We know there are no gaps so this will be non-NULL. */
>  	vma = vma_iter_load(&vmi);
> -	/*
> -	 * Note: check_mm_seal should already checked ENOMEM case.
> -	 * so vma should not be null, same for the other ENOMEM cases.
> -	 */
>  	prev = vma_prev(&vmi);
>  	if (start > vma->vm_start)
>  		prev = vma;
> 
> -	nstart = start;
>  	for_each_vma_range(vmi, vma, end) {
> -		int error;
> -		unsigned long tmp;
> -		vm_flags_t newflags;
> -
> -		newflags = vma->vm_flags | VM_SEALED;
> -		tmp = vma->vm_end;
> -		if (tmp > end)
> -			tmp = end;
> -		error = mseal_fixup(&vmi, vma, &prev, nstart, tmp, newflags);
> -		if (error)
> -			return error;
> -		nstart = vma_iter_end(&vmi);
> +		unsigned long curr_start, curr_end;
> +
> +		if (vma->vm_flags & VM_SEALED) {
> +			prev = vma;
> +			continue;
> +		}
> +		curr_start = MAX(start, vma->vm_start);
> +		curr_end = MIN(vma->vm_end, end);

If you assigned curr_start outside the loop, you could just set it to
vma->vm_end after you change the flags, this would reduce instructions
in the loop.  But this is hardly a performance critical path.

And we probably hardly ever execute this loop more than once.

> +
> +		vma = vma_modify_flags(&vmi, prev, vma, curr_start, curr_end,
> +				vma->vm_flags | VM_SEALED);
> +		if (IS_ERR(vma))
> +			return PTR_ERR(vma);
> +		vm_flags_set(vma, VM_SEALED);
> +
> +		prev = vma;
>  	}
> 
>  	return 0;
> @@ -185,10 +160,10 @@ int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
>  	 * reaching the max supported VMAs, however, those cases shall
>  	 * be rare.
>  	 */
> -	ret = apply_mm_seal(start, end);
> +	ret = mseal_apply(mm, start, end);
> 
>  out:
> -	mmap_write_unlock(current->mm);
> +	mmap_write_unlock(mm);

It is nice to see the local variable being used.


Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

>  	return ret;
>  }
> 
> --
> 2.50.1

