Return-Path: <linux-kernel+bounces-781130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E433B30DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26C977B26F3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 05:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC3E214A6A;
	Fri, 22 Aug 2025 05:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hhy3ifP0"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB991D88D7
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755838969; cv=fail; b=LvjlVApBf9qx1YJWN1gJbk5R2UsunsNXETEeO+1y/HYLsv2eYD2vZhUZaLBRHMdV+qpPcPWwz6uSXCZheUW2PGOZGxhXmx5LtZQNBzP6DfBZUNA5NZYaG4GFHO9JJAt8RZcW85St58wnitsDv2HFo0Jl9clTpMw8Mf27Ct7sDxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755838969; c=relaxed/simple;
	bh=1+4U2h4cUCHn9rkPud13h3/6GmECkjvnI7xSx5W7gvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ghEVD5JstGQB+MLomaKiPeoUd5GYeVlqZdUE+Yj+R8QIQQX/9dDbsTvI+c7DmByF+MiMq7sVh6KYKtW3ydNFa12LsNhi8nLS9ZncpvrL8dkAVrt2D12pAjZSl6vUgH+JzYrrlb15kYqgboaGxgF6fM9ZFSZ81ZC5g0leOEx3kGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hhy3ifP0 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8SSp6UaWAiAor8Q+w3WOM2uMrlRxkDm63eh6x/Cck0ddypU7bqlHWrzJnXkGdg3+8+fLEPfJAMiqFHY1td5VrM9hx0AIpfcIkGTggwX3Y7oMx/iIlRq7OqZ5A6VNOADDX670xf6lEGUyf9yi+Wl3MM6WBNomV02oewZF4AcEBXivC9gwTTbuGdOHvd6qif0yUdjQS0YDiY+fSKWsllU1TVBmcY7UP1KICr7074X9htszT5mOlXbUZAQIOLJzRjEkf7yfvA5HLy+JbS83JNn4A+r5ecOYBKYgzcix0kRHgsa5XN/SjMpjorz8VBXVBMM3SBg+D0tr7QFEQmrcWedXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceqpTrbNcOJ6+s5ZxTCQxzpL3aLpbqkomF8N6JlGOSo=;
 b=lzAv6jhBhU3D5rF2prkDjPVWxMd6uujze27j1cpTCy1o1ICPmpf4fanXYGEgtjeiLmWko7ZQD1ShnyESdor6FPhw++tnH2D15xE4XIAUcfdaqlWrjYI0ul0EASPFiOqi8X6TNtglZyeGdfgwYQD/JK7e9gZ6eB47gFmoEdx5Q6WKZhyXtbQTBQPMywl+J52HEEC+df2v6g3fO1PR40Es31WKmfniAqJHCs8er+12td6tktqwjKyjLK6QA48A8JZF5EP8/RylzBOiGVCVj0lE/MyvkwMZfcpZha1EG+LXaKWuHDJ4+cCvkbnUIcM7ATXHxruM0x4e7dl4OLU3sKLzMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceqpTrbNcOJ6+s5ZxTCQxzpL3aLpbqkomF8N6JlGOSo=;
 b=Hhy3ifP0uiL1bH3wQJsIy59kC0eVOXmVF4Z+Rs4kuoZNvBrO6EAL8acrY3DwEDtK++QFdu1IjC6Vbc3t6BRvavM4ttJSHXwQHu97Yn7oe4keaf0T1KlulKHc4aTSPoemCnHB5C/p6CHdUPdFjlN+vQXnstQQQCyTel+sl2HHHYD4KorzxBiauo+GwXtyYp/Fnvar2GfEBfbq4oQ6u7rDRNlbUqmhbNGa9t9TtoMT0FOmNadKWZeYu/rV0yDrswUR+rUW6yWW/dyiLw27HuKFvlindPiZOGWQj9Y+TeXQT9j6Yfq1hlPiZT2hnpLMA6guUA7Mqotzfrt+YTW/jo0XQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 22 Aug
 2025 05:02:41 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%7]) with mapi id 15.20.9009.017; Fri, 22 Aug 2025
 05:02:41 +0000
Date: Fri, 22 Aug 2025 15:02:36 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>
Cc: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [RFC PATCH 2/4] mm: unified fault and migrate device page paths
Message-ID: <gdkzd45iweec7cnjxzyfmbbnvk5m3w6cv4gsh7mo4gn4hlz5l7@ihtpp5hiifu2>
References: <20250814072045.3637192-1-mpenttil@redhat.com>
 <20250814072045.3637192-4-mpenttil@redhat.com>
 <099ffad3-489b-4325-b5dc-90fa002132f7@nvidia.com>
 <953cb2f5-a27f-4eac-b2b8-ee67e35bd1e4@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <953cb2f5-a27f-4eac-b2b8-ee67e35bd1e4@redhat.com>
X-ClientProxiedBy: SY6PR01CA0089.ausprd01.prod.outlook.com
 (2603:10c6:10:110::22) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|DM6PR12MB4385:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a93951a-de82-4e41-4df3-08dde1391f3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?WEEZIsSjbzYdzgRvgEM0GuZ9Xe3JFrvIH4YV4Kc4h8be/joiVhEJxjaSIj?=
 =?iso-8859-1?Q?eANgPr4G7gzmzZzrLNvMAkihFuB3FWoZ5w6o7jYIdFgJgK9b93dPRLlJzZ?=
 =?iso-8859-1?Q?gRqx63JcAtPV7qc+QEd2jqA14eTRP6A2aXlmphpUt12g/UFU1VIZt10F9G?=
 =?iso-8859-1?Q?OspN2gNI0Q3jL6nCOx64cupPvqy0pkqUcWdl+BPEZZ176/1AT7dIeg/iCD?=
 =?iso-8859-1?Q?iMvIX2JBkYUTPpwKomhkFDUsgCv1w3KMadCpmragiZjUth8zfVICFAZUk6?=
 =?iso-8859-1?Q?t899WOjllXQYIVsy6lbQgb8uPWAulTYDCR5PrfJSyyOyFoAQSSWpNJed02?=
 =?iso-8859-1?Q?OxF8+3qrgwSCAAOYU/A2VrlmMgvL5XMABi8Bw+tLLYZef36CV+6X+cOpQs?=
 =?iso-8859-1?Q?uYKZBd3YOKUTP4fGOoMB+FDygPhvDs3uNTNB+BfIv9FPW8fPJ4GG6gvM58?=
 =?iso-8859-1?Q?SCW9GPPTevptBrweqPN7BC7V4pceGEEvOgnP+Oyd36xl480oKosjZrHPsW?=
 =?iso-8859-1?Q?2JgwHK/XeTS38+ZYdhP/Dh2VuiSy6eCu3H7FmY22s/ndYlzLWTvTkwj+tT?=
 =?iso-8859-1?Q?ybuRmXNMl1U9J+iDEVqU3OcJqWNd7tB69Atr2YlnJKde571q1IQpV7cUSx?=
 =?iso-8859-1?Q?MsoLNBJiS8o3Ph3VhxIbdU5yJSMqRuIQsluo/7UQ+S713zGJpLQEQP1juk?=
 =?iso-8859-1?Q?tTgB68z3K8zdKrPynadCMlYH5z9b/0MtFuzM2zcutHZT0ZHs+peu3rXyDb?=
 =?iso-8859-1?Q?EHneq2NDxq7UKO2nt7Y0Z4xhAI9KjpnPJWvqUjXwS4afUM1Y61JEYnrwg7?=
 =?iso-8859-1?Q?5JfYvJM1orupxtNY8ydA1rF5dUFOpg5rodgvk+gNJ90ZAiDmAZaR2U//q6?=
 =?iso-8859-1?Q?mq5c9X/ZzLwEjGaT/bwWhep2srwxmIn+mnI5o/bWedP/63Oyox1Z8DJ1fG?=
 =?iso-8859-1?Q?8kJ6qENAbnXCbsq3xYKuciaoA6ZjUSVhFwGQ3CdFQhdtMUPFG1879tlosk?=
 =?iso-8859-1?Q?gX/qP3V2Kxzy8ju0iLRZh9U8km0rPeKABHAQ4ntR4r+wd2L5PNwP2waEGk?=
 =?iso-8859-1?Q?PYWbbz4mXdN4XMzfjrPaW9cPKphj+gX2jo0/KmI1rhK2wsLf5Y1lg/wvlM?=
 =?iso-8859-1?Q?0xplyD6L71q9pPmit4Jgvhp6BKou8gmx6zH/itrSM19UyGKedn1AhIWDUg?=
 =?iso-8859-1?Q?pL4CwhZkM5bOrnTIUMwJmt6dLC5iRNsE2fDzMQ9QmWKgiH/7SDBv5EqlzD?=
 =?iso-8859-1?Q?GOzRrfXnSXlYLe1spfq2HnWNJ+RLr7oGxcuF4N2Y6yJMgvw4xIdJUvBQGv?=
 =?iso-8859-1?Q?njmLpduI9M8Iaq/phgR5B1/kOhfeROgv0S4Q6vyekcYCVD5FnNDvCX2RMq?=
 =?iso-8859-1?Q?nZaaUTbSULb3V1J1jkoQ1agOARXMphZF0TbHWawrr6Qv7gUSvuWpk9gc0W?=
 =?iso-8859-1?Q?xzZn41Az1SSND0yeiMYE7nxIu5GE5hno1syTww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?y1Pjnfq5Akq6mqT/9q/OwOVRx40kK2HvsFdycIXlCCDmtmb+ZXmVmax5Rl?=
 =?iso-8859-1?Q?l7gDuDX76Bc4LaPRHAPDG9+likk8bLIVl1rv7/4WM5M8ZWLtzBOqE0AwRw?=
 =?iso-8859-1?Q?l2YBT5jDPawjdHQWgjnl8PuDs7XIAGZ3SNX31AmLD6Gw0IOiRStMERl8q0?=
 =?iso-8859-1?Q?KfPL5HHEz5KQgHn9nPKjZu/GTu14fFqZfIK+YUViwxOsJx51cOnX/oZgGP?=
 =?iso-8859-1?Q?7RW+K8UONkxvRzfr/4l/X7OOTluFLknkFdycVQuwAsMOL/EHVR/lFa/3+v?=
 =?iso-8859-1?Q?968QV29F1aLgZzuz+yf6o/mX1LdYiTF/xeymQQS4UUqtOa23LHteedIYqC?=
 =?iso-8859-1?Q?YPmJXZIqSSSW2wTltENQGo0thd7/yY1G3gSdU+jl7p1gYGLWl4QTqP/xw6?=
 =?iso-8859-1?Q?4QuslL0osd59GzsP6eKeMbfT/IBNcKgHfjxmI7RuyX6tXH6+fDdqMR3YNk?=
 =?iso-8859-1?Q?yVWLwWjqKmMk8XyR4OO1Y6UE05o12/y9deqKDJz+Z+qjo50QdkMcQ6Ou7K?=
 =?iso-8859-1?Q?KfFD79d2vCtKHPXAE8xe0B9KJ1mGSjJnztFqZDZAiaTt7CdTNsNFdtTy6f?=
 =?iso-8859-1?Q?CPXgoOMAbeuHwrkjM661MNBpIKxv8kgtdyQxX5zaYkWvmj+ugTDL8Hgd3B?=
 =?iso-8859-1?Q?yFK0Mu5zsfceltWog1oQMq43kWLPfcP4i3zzoo8cnQZTQ4R3us8qaLgNJk?=
 =?iso-8859-1?Q?KPiY5q9sUGyn8XE4/zT+SjjrLQRr4tN7eCuAQGbO2yyLmsTwOWVZwKb/5n?=
 =?iso-8859-1?Q?LVVNib+is2+KlEHj7BGtk2e3M7aWN6Wfg1rSLuEytUgQ79GiPC108xf/tP?=
 =?iso-8859-1?Q?Vr1IsW6bJk+XMNigCZpI1I+LRcbr3cP1PlS8w6X+ESw0fY4dUgUOnTH8Az?=
 =?iso-8859-1?Q?e0i0iE3TKcxxm1T3uZ8Cwu40vaaf3CBsf0q8OyxDH+sKjN7xa6GKzJVuwj?=
 =?iso-8859-1?Q?sDSSp8zFNVqOrJvny87IvbLdqfZqm1kG8dKt6nNFhA1AumCCU7QREP+exf?=
 =?iso-8859-1?Q?0SDsLMOuP78mgHdPK7nLZASSiI41K5xI0/MzwfcuocpVEI1u6/aKO3+3TZ?=
 =?iso-8859-1?Q?w+i2HI8hhwv2yIMkg15lj098Riz2+2iODRNiL3OoVXnzQ6gF6KtLr0WPbj?=
 =?iso-8859-1?Q?LC4p8cTb0jEf4RN+ncPL53KzxCEA8n+W4pApHada/Jk/Lta2qCFycMgduX?=
 =?iso-8859-1?Q?FEQMNIENgbr9W8bkqQdAkUr5yNDWlB7DjKCpbp5BrPOUuH7ENvbrsU80Zk?=
 =?iso-8859-1?Q?yfsjDkTF1KY1ZRMKporDuqz24GDKn3TKaUgVwhKroF1zN91C4At5/Y6CcB?=
 =?iso-8859-1?Q?loRLy+czT6u+DvuNstlRTX28PQD6SCFhMRv/HWf4OSZkQ44KHjdLWTF9Y+?=
 =?iso-8859-1?Q?MJ2uvbOPqUu0EEMvfahKY14Aurc6hgTSHwApkVKJaK8++diUKQ6VcRdGOb?=
 =?iso-8859-1?Q?QYXp9yg+zg+1fertpInk6yl3rBXtCI9sFmdq9H2duv4Zo6i6sPGzTxXvSU?=
 =?iso-8859-1?Q?wOF4xl1rFAgb7oLAO7Ow1Sag0HBmR6kXsggO98SAf0NIg1QgN/NWlt21tz?=
 =?iso-8859-1?Q?yQjakUEHJ/q5jydMfy9ZdCrxvRoX9db5dLm1IaPL4Uhrbff0e3i9AwZbGI?=
 =?iso-8859-1?Q?/mxXRKPooefdUVnUm2wrrEQ8vfT5LSzyuM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a93951a-de82-4e41-4df3-08dde1391f3c
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 05:02:41.2728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ei0TD4CQM8Bc99ahXuzoF8sINkkAEnIG9IiWEslOuFTfAtySRkipM+K0f8atwDBxgu9t/w1YchAqYRYiF51Dig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385

On Thu, Aug 21, 2025 at 08:10:31AM +0300, Mika Penttilä wrote:
> 
> On 8/21/25 07:30, Balbir Singh wrote:
> 
> > On 8/14/25 17:19, Mika Penttilä wrote:

[...]

> >>  EXPORT_SYMBOL(hmm_range_fault);
> >> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> >> index e05e14d6eacd..87ddc0353165 100644
> >> --- a/mm/migrate_device.c
> >> +++ b/mm/migrate_device.c
> >> @@ -535,7 +535,18 @@ static void migrate_vma_unmap(struct migrate_vma *migrate)
> >>   */
> >>  int migrate_vma_setup(struct migrate_vma *args)
> >>  {
> >> +	int ret;
> >>  	long nr_pages = (args->end - args->start) >> PAGE_SHIFT;
> >> +	struct hmm_range range = {
> >> +		.notifier = NULL,
> >> +		.start = args->start,
> >> +		.end = args->end,
> >> +		.migrate = args,
> >> +		.hmm_pfns = args->src,
> >> +		.default_flags = HMM_PFN_REQ_MIGRATE,
> >> +		.dev_private_owner = args->pgmap_owner,
> >> +		.migrate = args
> >> +	};
> >>  
> >>  	args->start &= PAGE_MASK;
> >>  	args->end &= PAGE_MASK;
> >> @@ -560,17 +571,19 @@ int migrate_vma_setup(struct migrate_vma *args)
> >>  	args->cpages = 0;
> >>  	args->npages = 0;
> >>  
> >> -	migrate_vma_collect(args);
> >> +	if (args->flags & MIGRATE_VMA_FAULT)
> >> +		range.default_flags |= HMM_PFN_REQ_FAULT;
> >>  
> >> -	if (args->cpages)
> >> -		migrate_vma_unmap(args);
> >> +	ret = hmm_range_fault(&range);
> >> +
> >> +	migrate_hmm_range_setup(&range);
> >>  
> >>  	/*
> >>  	 * At this point pages are locked and unmapped, and thus they have
> >>  	 * stable content and can safely be copied to destination memory that
> >>  	 * is allocated by the drivers.
> >>  	 */
> >> -	return 0;
> >> +	return ret;
> >>  
> >>  }
> >>  EXPORT_SYMBOL(migrate_vma_setup);
> >> @@ -1014,3 +1027,54 @@ int migrate_device_coherent_folio(struct folio *folio)
> >>  		return 0;
> >>  	return -EBUSY;
> >>  }
> >> +
> >> +void migrate_hmm_range_setup(struct hmm_range *range)
> >> +{
> >> +
> >> +	struct migrate_vma *migrate = range->migrate;
> >> +
> >> +	if (!migrate)
> >> +		return;
> >> +
> >> +	migrate->npages = (migrate->end - migrate->start) >> PAGE_SHIFT;
> >> +	migrate->cpages = 0;
> >> +
> >> +	for (unsigned long i = 0; i < migrate->npages; i++) {
> >> +
> >> +		unsigned long pfn = range->hmm_pfns[i];
> >> +
> >> +		/*
> >> +		 *
> >> +		 *  Don't do migration if valid and migrate flags are not both set.
> >> +		 *
> >> +		 */
> >> +		if ((pfn & (HMM_PFN_VALID | HMM_PFN_MIGRATE)) !=
> >> +		    (HMM_PFN_VALID | HMM_PFN_MIGRATE)) {
> >> +			migrate->src[i] = 0;
> >> +			migrate->dst[i] = 0;
> >> +			continue;
> >> +		}
> >> +
> >> +		migrate->cpages++;
> >> +
> >> +		/*
> >> +		 *
> >> +		 * The zero page is encoded in a special way, valid and migrate is
> >> +		 * set, and pfn part is zero. Encode specially for migrate also.
> >> +		 *
> >> +		 */
> >> +		if (pfn == (HMM_PFN_VALID|HMM_PFN_MIGRATE)) {
> >> +			migrate->src[i] = MIGRATE_PFN_MIGRATE;
> >> +			continue;
> >> +		}
> >> +
> >> +		migrate->src[i] = migrate_pfn(page_to_pfn(hmm_pfn_to_page(pfn)))
> >> +			| MIGRATE_PFN_MIGRATE;
> >> +		migrate->src[i] |= (pfn & HMM_PFN_WRITE) ? MIGRATE_PFN_WRITE : 0;
> >> +	}
> >> +
> >> +	if (migrate->cpages)
> >> +		migrate_vma_unmap(migrate);
> >> +
> >> +}
> >> +EXPORT_SYMBOL(migrate_hmm_range_setup);
> >
> > I've not had a chance to test the code, do you have any numbers with the changes
> > to show the advantages of doing both fault and migrate together?
> 
> Not yet, but plan to have some numbers later. 

I don't have any recent numbers, but I profiled this a while ago and having to
walk the page tables multiple times was a significant overhead in our driver
at least.

> >
> > Balbir
> >
> Thanks,
> --Mika
> 

