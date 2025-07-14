Return-Path: <linux-kernel+bounces-730375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4D1B043CC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB5521639F3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C06225EFB6;
	Mon, 14 Jul 2025 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rKeStofx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v/XLT/PN"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BBA258CF1
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506642; cv=fail; b=tw2nRxOgLGSDtSk67ndQeakM9l4BFb0Zhhyyp+p6DvuH7VuNZD3ESs+n/EOBanQKs1+UAV6ftTugB7TgaJSNi5KrpRzJX1ZU7SwgYqOv3+BFYorAWn2GsEq2D73Vykz3awb+TaNeUxWxk/o99qZSCng3vEkvU10vWgVqLDQ8cSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506642; c=relaxed/simple;
	bh=oqPAqfQy2Nk1vWFTZcrwY355SDq/E0BiwaNDGbtZeFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E5XAVsrT0CqnJDPiovDd8fgDA3pbOpUOI17fb36cBsHhgkRANbbWqeX348ZIGmPEgBZB+ELsaJPXDOXC73R/2a3LnjP9MJyV65/C1ev9sGsc1NC8Cs9Yv4NU/07vmZ/6sQEtF69CASboePY2KlY50paJ4EzLI+CdqS2VAJshCww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rKeStofx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v/XLT/PN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z61P019053;
	Mon, 14 Jul 2025 15:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=oqPAqfQy2Nk1vWFTZc
	rwY355SDq/E0BiwaNDGbtZeFQ=; b=rKeStofxXicmkOpLNRG7E3C/2ZatsnRi/e
	3PDfZkCkgyW86AWNsv8DAocJYB4W42u5F0rqelSYrCzMN0Ef+sZxfeWV/DNIXfvf
	EfkS4iepyGGYlGHKb1NO7gRVOmXcKliLOFAxDSup5iAZrmHGYiabZjO5lGX+uMZR
	yk3Gpg2V7vNneY3rGGXYDNyPZQngGn2NsWi1iRyd2RqM73iN1bgMfPTevmWCjHXh
	x3Tmmfk+EJTHX8wOObBA0zqYxioPwqBcU0A8f+g4YqgsHg9FE7JOANiuHn1uSm9t
	bUz2hjM998ABHAXnDyJ4LtYlRKUZOcLbT+rh6laQz6+hqPipWYaQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk66v93k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:23:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EDdFpU011597;
	Mon, 14 Jul 2025 15:23:44 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazon11013037.outbound.protection.outlook.com [52.101.44.37])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58nasm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:23:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SujjP79Q1UHtyUmvmsiG6dbdr1W3CK/1sGBHvzWFrrx37AG+iHYIev2mTWIUQ2D93OTi3bjVCJEmbn2euAL/iuAzizBGONlAXIV0vH043ofePUiVYeU3QGOnbXkIR5ja+yteoPXsiF6u0FbTmj7+cWgCbE0ao3dnLYfw7VvBFW6Mq7h6L0U+qi4GAi7sUBNLf2KOMT6ZjiftlzweRspsOe+OXZ5EWWX1NQB7pe4CCcI7FWecXr1FNTspf5zeswxrVo4d5nc360tHs64n0MbFy1Ok43VtCPXac08O0R3Sxqdcf+35aTgAuq3vV7/ansYUVy9EZXHj+STmpruDR0LvRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqPAqfQy2Nk1vWFTZcrwY355SDq/E0BiwaNDGbtZeFQ=;
 b=BLAIh5VrIx94dnAU9Y6DzeLPADBNcp7uKNPgWG1pakWH0seQL2fgywhNNCnZsOhD6On4e4UDmj2PjSS6GzvAlT29A7AkQLjrMvLKDl3Ow8cOIE04h/KkHDsyQjuOaCO8bzHtnyoeviOtkr+G9Xq2NpAVA/XB0+hVJv6t7Qa/12JmnpwsoVgvUXH02PM+H+zhnqKl706DhR5QphHMi/OJieUU7Xx/XqHiHGqTU/xvPeLRUm2/xTzlvHGCexl/72SCw0ANyuaiqwSHpBC5yBQ/Yyh5jI/uTILiE2EYN67xWt501ZlHGRooCLhy9kR1Q/x7/yr/Ciz4/JwvEFoFTQ+QlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqPAqfQy2Nk1vWFTZcrwY355SDq/E0BiwaNDGbtZeFQ=;
 b=v/XLT/PNMrnzh3ByVbXFSIvT39DRTIpI9tBgU69AIxxTVb9zfWiKVRyar9+md0/mDdG7oc1pWo0got4JnlmGIDi3cn0AcWUwWQ0w3VawLtgrjMbRjF1HUyUSFRf3X7Ej/2rKzgekaTVX1NtuXeJ/SqdKVkIdOtP8tff2wXBEG58=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CO1PR10MB4738.namprd10.prod.outlook.com (2603:10b6:303:93::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Mon, 14 Jul
 2025 15:23:16 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 15:23:16 +0000
Date: Mon, 14 Jul 2025 16:23:13 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH 4/5] mm/mseal: separate out and simplify VMA gap check
Message-ID: <cd3516af-8481-4418-9f72-a7738a9fd024@lucifer.local>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <f010ec1ce65f35dbe1fbd82ce002ea833a7128f3.1752497324.git.lorenzo.stoakes@oracle.com>
 <ky2jvl6uyi75qwfmpwzmwu6qfnlwxshk2zunywe3pve2pshdxj@p2ihhzov3imx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ky2jvl6uyi75qwfmpwzmwu6qfnlwxshk2zunywe3pve2pshdxj@p2ihhzov3imx>
X-ClientProxiedBy: LO4P123CA0599.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CO1PR10MB4738:EE_
X-MS-Office365-Filtering-Correlation-Id: 31bb345c-3750-464b-4f47-08ddc2ea5b67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JpWm/4+WvS1SiVq96/I0ZIFx3C+/PzLBQuE8aPUwI+t6BLjZaDaqGMyYt0tn?=
 =?us-ascii?Q?avwGUvzqHtO9psyKwQD3d2nAQ6mlKbQAW2Ape4KuTIg5Gz5Dbd/jKc8jc8lV?=
 =?us-ascii?Q?sG6Hm7pS22eadicjkYf+IwpfB8EbbSrXVTBYrJow5j+HO6kXvhYWkqgmzACR?=
 =?us-ascii?Q?QNEi55oOL3CXAUbUXgPZsvmO5BNzM5f0olfTxxxsP7vARWJ6CqY8om/ZeC0S?=
 =?us-ascii?Q?uEb8CmWwd81Bo3/Oz/WWEROwC3S9aFnAgHVRLL71ocK0NB6sfppr2Udvj8uT?=
 =?us-ascii?Q?mEJd7kK8g4fF5xThUr/y8vs9/2wc8JXIwRpFl6JjH5lU5/q60qDUx1pspU5y?=
 =?us-ascii?Q?Nb7YH94ZjeViKMAAx7sGakt+skyzlYViKRvdYmjICh3bWrZof//U8WPcdEBw?=
 =?us-ascii?Q?hsco3v5LJ4/QW+dJhyR0yLMnHlGaoDd7yb+E+FAZbJOA7d7qz+27PbY7Lnww?=
 =?us-ascii?Q?u6MqEPkjp5A+RppsyBnMOD1yRt77D7QZdndAjo57HO7KLrMsdoFt9clTQnU+?=
 =?us-ascii?Q?hRsIHBzplgNQ+b+JgHjPGGZDeQ/PzF9MUosSX4YSBzuZ5PYY8x97OSA7vdmD?=
 =?us-ascii?Q?0rSXAB5Zaxa5qqyQyNV+Yv2nzuEciNQEQPmy3jL+hQ+DZoanjv8iSUWW6eBc?=
 =?us-ascii?Q?Pll4jJ9fQmL66RT3nSURfkQGVh/X7aBav2CzwydIY0YgPpuwFl0Smq287zc8?=
 =?us-ascii?Q?FCjTS/1ABLpZIZdxUjctX0YwNhtqQWabyt8guu8ThAHtTd0Bm34Un+zjvh4W?=
 =?us-ascii?Q?sqGVrY9W1qygetbmdb80ETwV1xGt6/mXnRSOHtxFhBWXPg6rW3KzxSV+TxjP?=
 =?us-ascii?Q?roemIU3Y2rrGo9qei/SI2IO8g+Taoo0yPo8bvJ1SY9hlZrUZ7EJuD0WV/GoV?=
 =?us-ascii?Q?h7GtutgTOaLSe9uI0qxb2bsoK/a3Tlhz3TUV2+28y8I7/zXcKAH9B5H9JciM?=
 =?us-ascii?Q?oDtP0CH7sFXNYhxAWHESbKFiBgMyrqylv/ltW3P2CncbSgUHmFZ4zQCYS0H2?=
 =?us-ascii?Q?xvPDpp+gwShGnpMnKI8us7mjJb1tDr1Iw7NLO9X6StRt7cYhtO/IOyhLAWmk?=
 =?us-ascii?Q?lIuHH/LPGvlgY2GG8ozOwA1WXLrzN0TQ8eY3USN3ln5aE90B+NhUeVFlwZ2F?=
 =?us-ascii?Q?UhArm66nwV92PW2hoQuCxx5CTIGoss2r5lLmOA57zns+WOsC6syIoZETcOfl?=
 =?us-ascii?Q?+mwu7Y20H7GO6lxgwRXqcUrYchvz1WdCwvyqWI2p/7CwlLJAqt2rh/9Q/SaB?=
 =?us-ascii?Q?9GBlSMhqEuNRub/b8EOtmC1ddDMBzAPkRIb3ta3NMxeRuJXT+2IQxrf1fQoB?=
 =?us-ascii?Q?1BKpeFCP8epveGtuZVfGNWmmk3veh6JDRjdW/KJ3uSOnSCU5+Yh5auCk31NN?=
 =?us-ascii?Q?YaqOIV4AHRyLidzTjgS6HrIXDlBsNDa6z6p8TmDQHwNjBw9mhlKV9C9EPOwQ?=
 =?us-ascii?Q?9tC8BzdWjuE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wi1/KQzHQp29El0hDMillXyGaxBYja0+E7FT2lwwr+wXJBicIqQVj3EmBSDj?=
 =?us-ascii?Q?HaHvkzGS34nOV5qPV34r68vdvDmnnOUwY2zvaH8dYfrCCwlv+iHP5PZ0+pPB?=
 =?us-ascii?Q?9uvpSV2h7ori5zzLhuzcxaYIZt/k6FwY6JOBcL2EXYoqjB5oVxgMe+2prF/g?=
 =?us-ascii?Q?POyzsQkVguUqlKk/MisSC/+h7iE81cy1IGOn5ckoJ1hNs7Z6vSTPlj0fp9bG?=
 =?us-ascii?Q?2F8MMKR9k8EOB5RbwIyzaoep62UAm7o7gTZiiKDo85l0NkHLIgvwzgMlbD97?=
 =?us-ascii?Q?gG6uZbm/vYu8LIlJ74p4PPEm7n6bBUIDd1wSOyEzb6aKJrTqpGZ9UF2cOaPT?=
 =?us-ascii?Q?Nol/3xetibgPdfuJiEHttNPk/PQ/HffHQKTg1OmCuWA63Xv3/42TLA7HB8lb?=
 =?us-ascii?Q?hNIFQlm4NCS9gW8F42YQDjfrohE9KQm9CipAktga0qG+JH7qlLg1OT6lIpdv?=
 =?us-ascii?Q?MySfy8M+Qu0W8swfiXFORe7dIsftDSPL0lp2zlTzU0YlNw73TJsSEqYRejcX?=
 =?us-ascii?Q?7hmiZWDKZ0bydvAiU6+LkJVXzV8rc3/5qLjtUFxvod2U83l5DOPZX7oQR0D+?=
 =?us-ascii?Q?myyyCT+TdKN96wJMLrjP2QJ6dpPvsRxlN3bgCm/prMnQuF8v9qIjDylv4ZMM?=
 =?us-ascii?Q?Fvz2HwX+HFjeAaNpWk6cK66VWFcba6BnFxz0dUkLnM7zMD9mFvvVxZpZRAP1?=
 =?us-ascii?Q?+bYpiioJoMKiJgbiFgl6QRVUQ8nu3kQuUJfn9azvjuDCxHSApfpyvhV+tFId?=
 =?us-ascii?Q?mdUHCZPMr+zw0T6NOtdFGlNp9/4+yXzDOXzW8zKN02LGZ4kM7Er7XjEWOJGu?=
 =?us-ascii?Q?fd0mzq7+ZBOwqWRsTLSqR+DZ/QjtQIR1qLKH12QY+JKIvyO2FKRK0zpl2026?=
 =?us-ascii?Q?tSeM+Dk0b/BLJuVeHzebQR0CDvt+YZpVHHGYt3gQbonNF3EvAyqDhjusJD1H?=
 =?us-ascii?Q?G9/k1CmdHKKD26HU0Gz5gdEogZCGcaaRMhND1lcUTi+m3BdGBbtJcBWp5B+v?=
 =?us-ascii?Q?aXR9LYszCknwdC9U52CwNxVxrXgfgdaRTGyT/SiVDoCO08dQg67K/Q8sCRc1?=
 =?us-ascii?Q?nMNxIJyqSFb0KNO/0vTPkF5RuPGlsKPs2Plgy6YD7CUgtOdNYZ9cZT0/emQG?=
 =?us-ascii?Q?KrXEBwrhzbaaFKehpz+0uBKHdTLFgeFe07G6zR6Jj9NMQ7sJYbJ4L1bt9Qi8?=
 =?us-ascii?Q?DvnPHUwXwXqgVr7fGMsmkUcvxoHhcJfyUGw3Lu5GMUxnwmNP6RIX6czhJWI2?=
 =?us-ascii?Q?HTEfcQAcAAoLO8gFfcyK0/4a+UlLe7lEYSPDhOMcX0hfNvGaO4olLn75n+2E?=
 =?us-ascii?Q?gFsSXkBd1H9CzJKhBlF7ukIcNHW0G4nZCIAVMhjT2QICKymcW/tLlX37QCxj?=
 =?us-ascii?Q?ZUe6D21NWkkMsRdVIlp7wU3u7rA5iWg5q5beclx9DwecaiW2WCn7uqMA2osQ?=
 =?us-ascii?Q?Z5GajyDw+G/hP1qBjo/ZBgkqmcNgLlUl0ZpdaHhIUZFhu2MG4HYs3npi2O0O?=
 =?us-ascii?Q?ov941Ng8Hzrib+7qQI23yHEr8uEGdmjv9cKx++nT8zTqoz+zKEFt0ypj51ut?=
 =?us-ascii?Q?b/7fqTyxFlvJqeehxBHogjOR0p0lyNKBqYiyR/39L0ns+f6EufKKVf0qERC5?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7aJvT0CL5xnYAvK+zN13EjRKexxvXIODTikOIPzr+9nSWpzOaj5c2U/APrBZhkxyS1czU15l04xM7a0LB3AAk2qSR/RBWIqI69xZu6NvvAJX9u7cIq77FfL2zX9nQnZ6Enpab2JCUUbJOeqTaX6kHSDeMb9drvFSqByDGXI88i9N+tQONshsIscmSUUXF0tH+Cied0xhfZ+Fvu8P6VjoW7YJINAqunTsY+CQ6Y9ldC3u3+FFTorodtnBpMeZK981kTEFglCshWZJ3d5fSuwkCJL6bqjVcBeAW8piMeEyUcGrW5jRqMZpbDDYd0gDryxxn36tzHqMG1IDcJNYs2TM2fUy6WOXmi3XdYh5rbuteAlrB+0Dq/MxpTiFZVT9sHMF9ODgk+Nn6vnQZtUB0T6R0gnOS8SiTTx7nK1bF/BxK2cPTbTmPu2n3fL+aaG3fz4hVY53jYSfzoymba2aGJCO4WtFC00PD1Y1UCZy33F1gVpMdHHlakdMUjUjV6tCwgil6hvovoM447t3mRlkVCr+wlh4OuG/i6Sjv/dTO1LrmCnrJT+C5RDkJ/PAo9tSrvrVzWdWbb1Mw/X1UWwkqJG99ReiA9sW4MZNK0zejM/E1H4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31bb345c-3750-464b-4f47-08ddc2ea5b67
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:23:16.8846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZBMvbUh77kPASFg3o+IUAk+t6zxaPtOe/p+/p3Z0SG/inuMq1efLojUAO0pRgwFNaC/l/h/ujQHR2YU/ApIwEatdgJFwk4uWx/m+ocPv0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4738
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140092
X-Proofpoint-ORIG-GUID: pYp-fqca3wjHZOjs4bTaR66li6y0KgMf
X-Authority-Analysis: v=2.4 cv=AZGxH2XG c=1 sm=1 tr=0 ts=68752101 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=ngowPbe6-9zO8OccPegA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12062
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5MSBTYWx0ZWRfX55cBhQPTpC7N zfn6JONieA5LCUEu6goxNDBGk8OG9hxKmRCIiISfZZDHlwo8mdcGoi8tlkhcq35f2BF/oDDT7RU y1Hd9Pra7UcMYF4dmpP84AvLjYD+uf0tRYIClvmCGAuzJJwQgarRg771rMc3mpIKOjvxwO5lXJ7
 HfXkSSVXNKL/bn3zhn0Yn+XYxMYDDw8rAks5l9o6oOiTpjLtxOWHuF2OyT4ZtKctpFcMAGvG+zl l0OiP1mbxy06prEtPfmHGRhc8AOkRYQmoB43M8u0mIDF7xDcRVhSAgVyXm68z+jvx4cfaz/SSgC dI/DCjVNDxN1H7zbtxJk60j8K1GJNgR9mbg1juO6INqcluvfxctrReTDGbXkFNNs/ezQNNjad+j
 lCB7LylpTR84Az5Mb+o8PhpD58xrHGmlYijhRdgjtgLz8miylMKOJJT+w+L61eD/H3EA1FYb
X-Proofpoint-GUID: pYp-fqca3wjHZOjs4bTaR66li6y0KgMf

On Mon, Jul 14, 2025 at 04:17:23PM +0100, Pedro Falcato wrote:
> On Mon, Jul 14, 2025 at 02:00:39PM +0100, Lorenzo Stoakes wrote:
> > The check_mm_seal() function is doing something general - checking whether
> > a range contains only VMAs (or rather that it does NOT contain any unmapped
> > regions).
> >
> > Generalise this and put the logic in mm/vma.c - introducing
> > range_contains_unmapped(). Additionally we can simplify the logic, we are
> > simply checking whether the last vma->vm_end has either a VMA starting
> > after it or ends before the end parameter.
> >
>
> I don't like this. Unless you have any other user for this in mind,
> we'll proliferate this awful behavior (and add this into core vma code).

I'm not sure how putting it in an internal-only mm file perpetuates
anything.

I'm naming the function by what it does, and putting it where it belongs in
the VMA logic, and additionally making the function less horrible.

Let's not please get stuck on the isues with mseal implementation which
will catch-22 us into not being able to refactor.

We can do the refactoring first and it's fine to just yank this if it's not
used.

I'm not having a function like this sat in mm/mseal.c when it has
absolutely nothing to do with mseal specifically though.

>
> I have some patches locally to fully remove this upfront check, and AFAIK
> we're somewhat in agreement that we can simply nuke this check (for
> various reasons, including that we *still* don't have a man page for the
> syscall). I can send them for proper discussion after your series lands.

Yes I agree this check is odd, I don't really see why on earth we're
concerned with whether there are gaps or not, you'd surely want to just
seal whatever VMAs exist in the range?

But this belongs as something separate (a _functional_ change), let's get
the code sane first.

And ack on manpage, that's a horrible oversight that needs addressing!

>
> --
> Pedro

