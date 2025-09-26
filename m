Return-Path: <linux-kernel+bounces-833774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CECCBA3087
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3833BDF11
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCC129ACC6;
	Fri, 26 Sep 2025 08:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j9VZcdX+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VUkQWXSR"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7315F28AB0B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758877055; cv=fail; b=ARX8BoAkgh52f+pEA0Fm7jHcOxTfFcDaum1jjOYbQsNwBITprO9Hn/bzxc/rFcnmMJwCNE4ZmJ5Jn3ZpM/ksf+cvW0HcrOC+0ZCnZeHYIbBHcoduCrqA+7HMrLLBIOylC+F82S0SkKTznrnQI6X704v7AQXGWzEUH8o+CN8/QQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758877055; c=relaxed/simple;
	bh=PpTxnp/Qn7TSJGMe1mRskBVYgV+d8P4Mlplk82YRmlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=psUnSfzEv7gjRccDPfTYQkZNYNVcyyvz1LuWBqKO1sB77e3qiZvqVHDeurJ97FiVwU0LDzRgEtfAGik3b4b2xHOzh0YdGiIGQNmFEBq8+xjsiwnCLnSl8VWZRl/2/rBwY3sQrwS8kWT491k5bZ9u2be+rXA/hPfs+N1QCVsvdQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j9VZcdX+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VUkQWXSR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q8YkOL013693;
	Fri, 26 Sep 2025 08:57:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=aJuAicE93JoijTtrvt
	1IZ11n0p9AGm5XD/LSscMHMko=; b=j9VZcdX+1wj+OBWR2AQ9fh2fjZAeZUSusm
	VMW41zT/FXnGf2fCXNp9QjdEys04KdNFzwwx97yAksR28LcgnUK3zFNC9GFYx4w5
	pGiv9WOtAcOBJ6KFxol3wOYSwBhRF1DSNAzfumppcNSudGpSVSDvhbGKeFjpubTp
	SijvE3l5uw+eQmU8Jnf8YxYDECrbB+tndlL7h0zfaNK/hnhAy4DPfhhXZ1K1TohF
	U3CspPyOSZGFa0ObcvwlrER72anT+Q5ZDw7j0Uk8RPKlm8JmzPOdKwvTHsEqwVgM
	RZ+6mShveVQf9wEz+RSmTo/DY08xyWdWI3L4JoRpUY0nycalYAfw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49dqefg1sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Sep 2025 08:57:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q83ZPR037541;
	Fri, 26 Sep 2025 08:57:09 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011056.outbound.protection.outlook.com [52.101.57.56])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49dd8kjtr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Sep 2025 08:57:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6Lt9cE4tvTdT48nju9rIwMoNyolqhOZfwpTNk+ZCE+D9f9mr87jBUr6s1k5Px7PebO31RLuNpahWAm2Sguqb7iXMaINQK3o24kqZhBbBlulJOPTSrUBQt/YixBdjH2I8rKC3MFQSOmhenrRLCx+oOiPr6cwQD7lzZUPdKyMiEaj3A7y44mSet5GahowNSelM1TEp3l32+u9xTyMcYyLx38wVr/2Ft6BeTAoMINygc0K/IkdG6c3cI35Z0phkHulKfdNOuZIVcPTSpeAr+5v0WDaYzCgoV9JosWmFQcpShf3nzK8c49UvkLJKx7Qd53B937gfWopa8/kuQZLzKhYlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJuAicE93JoijTtrvt1IZ11n0p9AGm5XD/LSscMHMko=;
 b=IyFccLzGyYOV/eqyyLyiwEUWJVvXSltoFPJMXwn+FKnURtV6bj20lEQhIts31PPyJhgmei1roksSJJZsiIy8a4ZxOAJDszwWeSRUVrPw8SKg+q7OwMauq3t5qA/yWxiOWUx3z0oma76EpW1k2F3hfRz2qJkxDjBqJa9szU+bAApiOeDR7373rVqNZzx8SabgKSFrG7afk1oYaPagW+Nmvi/mHOfoVsMehbX82KKP+2IjgHoYDe5EuXiHLKpxsPifusfET+EcfDASpbU4PP2qlUbs7raeN9V4h6bJHslY4OhbJhzbAOAwAWUe05NKdjBTzDGD9cNwyU9iI0Bj/qzKhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJuAicE93JoijTtrvt1IZ11n0p9AGm5XD/LSscMHMko=;
 b=VUkQWXSRtfqJ15HQE8xJV0+EO1Za1cGqGzDdEXrvz/a/ecPh9aX6EHAbIJLuva170V8my6XIJ3iMB/Ha42E8Pn/RKTxqV3KvuZYCWS5KC/mNdy7Tv8mFBxSztc3SfzsE0vPT8l+KCAd6LilAq1qvg/XazUx1lSVvOq85nha0KE8=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ0PR10MB4624.namprd10.prod.outlook.com (2603:10b6:a03:2de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 08:54:41 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 08:54:40 +0000
Date: Fri, 26 Sep 2025 17:54:31 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: ranxiaokai627@163.com
Cc: vbabka@suse.cz, akpm@linux-foundation.org, cl@gentwo.org,
        rientjes@google.com, roman.gushchin@linux.dev, usamaarif642@gmail.com,
        surenb@google.com, shakeel.butt@linux.dev, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn
Subject: Re: [PATCH linux-next] alloc_tag: Fix boot failure due to NULL
 pointer dereference
Message-ID: <aNZUx5J-atXpKHnY@hyeyoo>
References: <20250926080659.741991-1-ranxiaokai627@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926080659.741991-1-ranxiaokai627@163.com>
X-ClientProxiedBy: SL2P216CA0215.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:18::9) To DS0PR10MB7341.namprd10.prod.outlook.com
 (2603:10b6:8:f8::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ0PR10MB4624:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a30fc6e-b9f0-4d28-06aa-08ddfcda53f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xNDTr4Uuoaio3Qzp2fGB2IQXiJy3IA0rEpkxhyDs/XS5K/1gdgJ8TXbT5El8?=
 =?us-ascii?Q?0AY7MbzhEe587EXZkPjFEn7iLOOY/RwPmtbDZSm+g8QupNUR/Jdit1f6WnzB?=
 =?us-ascii?Q?0n279b8iqnEw9aT1zyGdVnn7dFokRNOy1dgunjO4OZ2PIvjOYAzUulZgnCDQ?=
 =?us-ascii?Q?fUtCbmbkV3R57y5dI/Kh80PFc60wDQYJB2WlGm1RivTBzx7gLeOwZgurauqJ?=
 =?us-ascii?Q?PKq+4eQCrgYsgY3RkOSt94z3XCnxp/fjZyAXi6SXkqFfKPM6F1trPkzBZsuJ?=
 =?us-ascii?Q?rx73cd82JYrrbQ0/dVtXgGtyLg0Keh5+XgoEWvzkdt/LXSILHEUl38pns+xV?=
 =?us-ascii?Q?GPJr3L/LMv2du+Oumnc18WWp24gVH1ziN6+LYzBj/5gjCBh2KHkZTHi1nfPm?=
 =?us-ascii?Q?PJO0o2MSE5SMcdu8eR2WY5oISKilRd+pcrxwV1g46kf5spi52hMHYrIULjl0?=
 =?us-ascii?Q?n3WcMNQY9YtR8nfDUrhZ8tqvdMibIoDqdU7IcrivxkEa0nSqSCDzunHZszVa?=
 =?us-ascii?Q?UgVvtZ7dm/CrWs5E8iQ6J1hUlZXFj3EYm2hPZ8jEt0sD31ipKL5BA7D75Xq+?=
 =?us-ascii?Q?Ui/JE03ILMSCaC8iEMObEiqk/BHo4qT6IpNAZCT9dBqVtXkGK+39RefFWX9m?=
 =?us-ascii?Q?Uhr2ArBdEmnDJiUvzPSwxWoxFjEoQeFL0JBU39tQI2g2mF52LxZ22sT4Pr2z?=
 =?us-ascii?Q?QIrIaR9/4zvAKeStuhALdBY/oqyaj3xj0FF25sTST78pqv7yVJvkx2eRNzCw?=
 =?us-ascii?Q?J5yeIaQjNjjXsXiNvcX5ovBvIIw8uDG/COYBytko1UPmocApiy3tUtq3jr9X?=
 =?us-ascii?Q?ixQxyiuQfjNGqm3FQNbjE5wG/E3YJeWwrWupfvf6r6sp2afdQa1n0cE7gM3S?=
 =?us-ascii?Q?NsaDTC+EgQFv617WwDFyzTiJEHXQKOfRgpUEA3BUrwBXhVUW4APRVihv+UEA?=
 =?us-ascii?Q?jBu+Ff9617Dof65WWG6Ess6wQED4xyhu4AeSyfvOKAS1Sl0xwdi7fZadCgXn?=
 =?us-ascii?Q?tkeDaxp2u8Omv8MvwR6Sej1dmiKP5FdFSdAyiLjblqGAbXrTt5OFMde1HgCy?=
 =?us-ascii?Q?5lvonPHIYvtojMEgTa391edTxNt2/GSf7HhqUSpH1Ks2zUlZL0zGc904xgHH?=
 =?us-ascii?Q?sHX+ptft5bd3u7sPCXlzuQwFA1WxnMXw6YfWfK84qHblbT0Qt+FHSxtUOu1o?=
 =?us-ascii?Q?BRx94eNmuuud9V05Sh7zCKquI6G1bf0UbRkhccFxiZ4dzSO9M08rJ1hZk8xq?=
 =?us-ascii?Q?FVwohhvyqTd2OwC+T/TH9i2LjaKquu8PeX0qDRy7UqLcdjvpFAG6ATsWwYlX?=
 =?us-ascii?Q?N02NybOv/yAhbTvMD6sm3wQCo6EAqsbYkHqEi9BgAonhpL2iQ4qHAX7v+068?=
 =?us-ascii?Q?3z4SDS0fXEkzMdpLZengwP8eLuA4jMjSgDLUwme2zNw0/xx1dSt47wfOoE9y?=
 =?us-ascii?Q?SXG7rR/jcDUZN0+PD5FdMALojfI+V6gz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0RcgfOv2qN6hX5XFc/P9HTxDqQ2bHo8Kw4I7PnguploK4GUEUygpcLyXKr11?=
 =?us-ascii?Q?bL8Ol5sCZQ1YpWqT6DUwnKOy3al6HS5GKz+ag91ymAEg/gBM3rXdhnA48p1t?=
 =?us-ascii?Q?UxnAA6oBkGyp1r8EBy5amEZOCjzM3HkinoX7y2hzuYRl2ZDE92VW3XvtGgBv?=
 =?us-ascii?Q?/DZRfSoA096lLByVd0QRCW4MdzEd8l3nivPOZPq3eibOzmzdMrDXER2pWvST?=
 =?us-ascii?Q?KqHplT1YM9S8sPjPc+aAgsp6NDKJOfKFTq11FYNYwkyE2UEXUWoaaZuhX6QE?=
 =?us-ascii?Q?+98vYDU1JOVn8tixSi7opOzlOJH+Q5iEkhPKxwGP6W7p+MMDrYht/3jw4mu4?=
 =?us-ascii?Q?9+YLSmQ/Yn51w10SWwrUpefODaYHV6sKdQDfl5UiWJ7vaPlF5DETfTIKlHtz?=
 =?us-ascii?Q?rzzWCv1RtI+chYu0d0rv7D3gU438uNqXe3X1cvP67hFMSLoCwOCg1KunnZRZ?=
 =?us-ascii?Q?sm83FAARy5QRoBT5UR4aQ1CLAo8Ml7aIBtB1jLpWDxj9AJBW9VXeIc/V51Tp?=
 =?us-ascii?Q?1uh+yEvzG6hKcmo2cSLEKpDS4zptuCVReo1xglLSTvayg0CfEZZFaweAUGjr?=
 =?us-ascii?Q?YVn8Nw0QXChpGWvoPAS3rkc21Epx83A/aOaG4SYPaaIJZaPz+qsDZ/0I1FfV?=
 =?us-ascii?Q?cshiU2iQy3wO5Y8ZNa7Wc3uRWhBbnZMDx4APuW7LOmDQJIr4EoZD/tY36/tR?=
 =?us-ascii?Q?kGhDDqk5UsuLUBnfngUzSFkSdDnRC670WGNC4CGD7Y4/CCtOLv2TiO+kBt4R?=
 =?us-ascii?Q?OWtxJvnNhNkZFhqLsr2u2wd5sPI/CLjJEKHtndZguyEFggHrhdVaZGRMQb39?=
 =?us-ascii?Q?P9LmczY6Tnzg1zpxU3571h3vSy8VGxOo27/v0bkdjbzIKBRtbkQ1RR/IOrXf?=
 =?us-ascii?Q?DArJ5tGhWqCzRI6p/cXAdrpuxvInufmuZhF4pqDNSwdd5Nv3zUCgJ2MqEFeK?=
 =?us-ascii?Q?t8o+Ohm0STkOFpW7Ir41ihKYXpQUhmLe0w24aoC1fYKc+QwDlbjtfzX5PoiT?=
 =?us-ascii?Q?U/klVY+/yW6UAy+YMutNDiUI6Yh2vsz73C79+LUzUJUUFfWttArYFWjA3L2D?=
 =?us-ascii?Q?V8cbi0gD3kGXyB/RhLC3Qh/x7wFfXnHGIOO/pPgieDjSgRENKWLcDNjgPGlx?=
 =?us-ascii?Q?JtumVV6FjeSMbJQ6mUrDMlIdPByQZaCEu/eGt/S3fF4m32aUyHO2crwkFccD?=
 =?us-ascii?Q?QMOGA3KMd6qsGO33EUZwBzlgbOL/jH13MgV2kJIszfkUp5B3ERx8q+bdZlD9?=
 =?us-ascii?Q?FkJEELi6Tl3oaqLX/NWy1adTepnRbFbXneqpF3S7FzEFaKlve6pmXfF4DovZ?=
 =?us-ascii?Q?+x5k8dam762tCW8/v83d4TycTa4kBnJnICTcBFampvFKCglhvPOfw1v2/cum?=
 =?us-ascii?Q?K+hmd5JoJ7J5Hy1JnAfmdQi9LHDhZjwlwdoQJ2At9yHq0QN4WkVSUZKRqaLH?=
 =?us-ascii?Q?dfXxE32wnhaDT7Bx16QZa03viDQQacrUPdeHbA9HPfPJKhMnsBM+btlPdVmi?=
 =?us-ascii?Q?Jrv5AquWEqAITS+LddO2oUaFvQwyHvsiTUj4Uh/3DDGXpBbOzY529cxnekjl?=
 =?us-ascii?Q?ccr96Y2NAPH3wTSfhE0L2FV4xchHcPWyuKwyZbfG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t6FHtgrBQmVZticmGd1rKmH79JCk5/xWbKge7vRLP0e98S7KztBJx75bRSgQWtkT+jTc4dX4kOf5Hk8bad+u/zH+KvmNBfGhx7udZL72JvfJC0140rLMgHmuenIWFIv16zt5zMeuARhRVXmhFGa8tCefYXvjf+cxIyiuMUS2B5SIGDVvI9h0tn0XOxmxIjy0YQ4ijqhMquq4DopfcXytkIjhVn8XEhSiYImhF7o6j7sN7T3O+yqtMB6MRLBvaPvfyHk9H0dPLQxcBim99Vfl4vnnj9rwFqWR8QEizV6RDBHwpG/OMuN7jPC7ZQKSdNMjHK9GJJsb7P+WveWwhYrkEfLH3D4xRTlH1x7IgvXrIV70qbXJyzkqKK05FTyJ+kq1G9y3AtSDSRT/Ft2ng4suNiQb9fGohLQ/JUNwB48Ek5kjzJ+PuHV20eIRiBN72wusW1MSSlI5BepUSzZBqCRSkF5Nx1rxXb3TUZCxVd8ntBwIUkMPW/np6nbCfsLt868OcYKhfqJco+vHwDn5KQ9Y9WtgTd+gD0sdt3xr6avtHaqLkpHY3dTN1yPN1rtPq3d9fjWVyM/WIZjANnDqfgsMsboKOtz1Wwkfs7TS4sP6ugU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a30fc6e-b9f0-4d28-06aa-08ddfcda53f7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7341.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 08:54:40.7325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: goEgN+0AxnUMzthiucZrYQw8nZnFqrzK+OiQ7YO5pJOt/OeUGLsw7cmAHaLa+ulVSbNmuur79zRLKuiJ6Lr8Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4624
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2509150000
 definitions=main-2509260081
X-Proofpoint-ORIG-GUID: IAYjulzcNBgAOUGHSLuRHFWEcS-J2Ovc
X-Authority-Analysis: v=2.4 cv=dPSrWeZb c=1 sm=1 tr=0 ts=68d65566 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=Byx-y9mGAAAA:8 a=1RTuLK3dAAAA:8
 a=yPCof4ZbAAAA:8 a=CvQm_iKvT4VRFp9-BTQA:9 a=CjuIK1q_8ugA:10
 a=kRpfLKi8w9umh8uBmg1i:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: IAYjulzcNBgAOUGHSLuRHFWEcS-J2Ovc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDA3OCBTYWx0ZWRfX5XzcXWI4LEGt
 Bc9flUuKBbpqCzLA/k1FoJuFF2/f96HBN8zZR6LdMsYClPoewbchQwucanvx3vi7D3i/NfZJjg/
 r6D+KCiGpzJpuHghk8tKcDjTWJZ/jLMMRABXzm93RKmUK5tNHbn8lkdY7KL6f3QNXNMJ8et6TRe
 HFpRukqDHgkDDseQDzq2TD5WZ938kN9PZcivDbS1E2C2LNMtJrtd1hzw2GN27a2/SxzD8TO7zTX
 kupSlfhMU5DZqGwi1fiR1wuh71voRdTC4UoAVnorUFIHvON5nWSA87WsQYX6DmGYqXoGaui2XON
 VAUsgvLlJdzhtidMJ7Uzavx7SOVYSr9cU8Axm32QovONkLGXlynMlC/7tpSMJchiF3nAimbWxId
 xn0VO6oDBpG2AEhP+cca+PZHt5fwLg==

On Fri, Sep 26, 2025 at 08:06:59AM +0000, ranxiaokai627@163.com wrote:
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> There is a boot failure when both CONFIG_DEBUG_KMEMLEAK and
> CONFIG_MEM_ALLOC_PROFILING are enabled.
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> RIP: 0010:__alloc_tagging_slab_alloc_hook+0x181/0x2f0
> Call Trace:
>  kmem_cache_alloc_noprof+0x1c8/0x5c0
>  __alloc_object+0x2f/0x290
>  __create_object+0x22/0x80
>  kmemleak_init+0x122/0x190
>  mm_core_init+0xb6/0x160
>  start_kernel+0x39f/0x920
>  x86_64_start_reservations+0x18/0x30
>  x86_64_start_kernel+0x104/0x120
>  common_startup_64+0x12c/0x138
> 
> In kmemleak, mem_pool_alloc() directly calls kmem_cache_alloc_noprof(),
> as a result, the alloc_tag structure associated with object_cache is not
> defined neither initialized.

nit: "the alloc_tag structure associated with object_cache is not
defined neither initialized" sounds weird because here we're talking
about current->alloc_tag being NULL, and it is not something we
associate with a slab cache.

> So current->alloc_tag is NULL,
> leading to a null pointer dereference.

> Move the checks for SLAB_NO_OBJ_EXT, SLAB_NOLEAKTRACE, and
> __GFP_NO_OBJ_EXT to the parent function __alloc_tagging_slab_alloc_hook()
> to fix this.
> 
> Also this distinguishes the SLAB_NOLEAKTRACE case between the actual memory
> allocation failures case, make CODETAG_FLAG_INACCURATE more accurate.
> 
> Fixes: b9e2f58ffb84 ("alloc_tag: mark inaccurate allocation counters in /proc/allocinfo output")
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> ---

In general, the fix makes sense and looks good to me.

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

>  mm/slub.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 867a07260acf..09cbe580842c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2197,15 +2197,6 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
>  {
>  	struct slab *slab;
>  
> -	if (!p)
> -		return NULL;
> -
> -	if (s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE))
> -		return NULL;
> -
> -	if (flags & __GFP_NO_OBJ_EXT)
> -		return NULL;
> -
>  	slab = virt_to_slab(p);
>  	if (!slab_obj_exts(slab) &&
>  	    alloc_slab_obj_exts(slab, s, flags, false)) {
> @@ -2223,6 +2214,15 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
>  {
>  	struct slabobj_ext *obj_exts;
>  
> +	if (!object)
> +		return;
> +
> +	if (s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE))
> +		return;
> +
> +	if (flags & __GFP_NO_OBJ_EXT)
> +		return;
> +
>  	obj_exts = prepare_slab_obj_exts_hook(s, flags, object);
>  	/*
>  	 * Currently obj_exts is used only for allocation profiling.
> -- 
> 2.25.1
> 
> 

