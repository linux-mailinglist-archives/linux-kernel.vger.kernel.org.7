Return-Path: <linux-kernel+bounces-789749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7FEB399EC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F237560E47
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A64830C61B;
	Thu, 28 Aug 2025 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MbXLV+BE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UyD01yiT"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DC630BBAB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376917; cv=fail; b=cBjrOZnodTxZJ8mjDMwJzO2Fgz/saB1g9u0pTvb6iBrAXzmghlLSpUJm8rjvxxgXoBu9wU9N6voqhvlWuTdkGEyHiJYsdQKUQBRmd8mCM9Zdj0Aq6uezHX0xjg6AzEbvhQa75/VVVIF+Keh+WTySdA2OCwv8gZz0ZFtqNOQ0YxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376917; c=relaxed/simple;
	bh=o4xQk1vSPQvkkxwAJ12GBj0LZ9Hxgs1i8AbpKCpSQp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mFQlVU1H3JmK+VH3I7cIvJqa9RZmzLEjNDtj8DA5n0q90AMOvjNE9bZahWphLuxbumsY9W9mhpJ4tYzj/HEaJPo5RkTOUuNAgTIiwUsO5YSv82drCltL4a3Vher79LqI0CjXXX4wjBtmIk7jhSQtcT+kDNRCzbAmsbqOCecCv2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MbXLV+BE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UyD01yiT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S8ttpI021702;
	Thu, 28 Aug 2025 10:28:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=o4xQk1vSPQvkkxwAJ1
	2GBj0LZ9Hxgs1i8AbpKCpSQp4=; b=MbXLV+BEQOiDln59+FuabEu9HgsNpxq8Y3
	kriTyjloaMaLaHP0qmzcrS6kbZZO5EN/KzfOUj77/kzilfYgfc+J4Wjpol0MZm/+
	mG0hhhmBrcNNqQdxiBQYipnebCcFsm4E2vcwrsbWdChpmByO/Bk1GwQGChAsUoCC
	KTRBlUOpHtwrdvJgpSOseNV5bQ0zCzlVSnTzReUVf0j9RRnHk8WauLNRC/Mmf50U
	tRoR8OVYWCrF603NBCIQP9v8tpFiM+NuZ5gUNrIBe0Fa9ZvyEeCHiTN9V3cOFWsI
	o8mqxMZxSyiBSlPutsTZk1RHsbJsY8dyoGnIHrqeoesg/NUE1rig==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4e28am2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 10:28:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57SA9BgJ005047;
	Thu, 28 Aug 2025 10:28:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43buktk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 10:28:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTA1yJx9GshN9Mnv3kahdkYfPRalJhtex1O5BQQDjqBJCNyQ+iccM0LSXKoOBVueL3+jkV3ZarVx8W3WjN/MWLgfsA/EHS5y/S0GoDwuW8JsfE2RQt1mzUaVit+RnkOpOwUWQ/j4GlMwrWSmOY+5BUrKof42kMeS3oOLimD9SbimiZGxIimV01jsEJUGOC/pHBEXAmLIzBB2xw97S1yvWE3f5J0zdyOwMwVNraMo6bMOXtWRicqjK86EVTkzbabdPWNOC5IbFbymkN4S21hxxbMYTQkUciyDqCjss5T9k9zpvvZqT2QPy05wQYHY3My1nXt6ES6pgJgzKSi5npE9jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4xQk1vSPQvkkxwAJ12GBj0LZ9Hxgs1i8AbpKCpSQp4=;
 b=JxttKpUxQpvTrHsz6gQMBehoElI9lIEzxa31OmGErJXQZI7JFfN7yeDGiafIzBgrHX/4uHEnbMkQLVO9cd03Xk6JFxkgdcVtCIsRW4MIMCR9VYQxTRT4VrWJIwsMk61VKpA3eI4KY3lrSsntA+eQXOj2nWbtMDBkq0hCJ7Ay75C1iCckMEQruV7KDWDpoo1cbGTRfUL+wXf7ZIgjScAquy1dAnnhVW1g5xqiR/YqqfcNpJHuo6bd0AjN2hu9unsHjQUT4eYcI9/3XG2gaGHvKQP/av1LV4ZUr4ZMKjSEUaqFPsN7vnt0EuTTpDtbG8XgumP4BWPaYOHR4eohf9inig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4xQk1vSPQvkkxwAJ12GBj0LZ9Hxgs1i8AbpKCpSQp4=;
 b=UyD01yiTBQ1+Gs8/mjgABKNdhDgxb/p6vfoupDOhFkWksu8l7FbxhxLjo9m8gaC4qq3nEtaHyRGzcRtM1jWr10w7jswMHuSK17DjzMbg0FN0WtSZIdUsxrACZ6F3O3Vre0puHV/g3XBfcKMAubgSomL40ALWZ2eJWn8n6+NycFc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8544.namprd10.prod.outlook.com (2603:10b6:208:56d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 10:28:17 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 10:28:17 +0000
Date: Thu, 28 Aug 2025 11:28:14 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Brendan Jackman <jackmanb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/3] tools: testing: Use existing atomic.h for
 vma/radix-tree tests
Message-ID: <9cefb766-d6ca-4c82-84ae-8a47b1fc6e84@lucifer.local>
References: <20250827-b4-vma-no-atomic-h-v1-0-5d3a94ae670f@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-b4-vma-no-atomic-h-v1-0-5d3a94ae670f@google.com>
X-ClientProxiedBy: GVZP280CA0007.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: 2699a8e2-1f52-44b5-0a9c-08dde61d9a7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?udMF4izngRGdXFPjYUf+wmYVmZPXJJVhEMYSyCiYINh24PwY1EuPI+bMMRo7?=
 =?us-ascii?Q?OjzRG68NvD3YRcHnm4FhaVNbruPcE7XVX6TD9ikZTgqJR81m0B48yu6eCB7w?=
 =?us-ascii?Q?sFqt+LU6/U7HhpLEBPbDTL4aZlCC2PRFQob92MaNw9qgqq1F1BOVYbWcdG3q?=
 =?us-ascii?Q?FYvPJ4Y3tzPwAaqgDKEdDED1YLI/k76vc6OFQh+MhbPYqrJ0HK5cvY8pEvRw?=
 =?us-ascii?Q?NAMAMk8fripygYXlGBLiQ9V5GJKdjFi9ZkP4vJ6LryliyBonClCciffSiRJV?=
 =?us-ascii?Q?nd1QfSN422M9142xBUpdER8V+iEs11byLsMpgqqkpxkwmfYyGBHHaWNxpOFt?=
 =?us-ascii?Q?PR8QVKASRBGAgaw37wwhVGeG6n960xgJmG6VeTu3DjXYm6AYSibXuTPPqwxC?=
 =?us-ascii?Q?Ex+EdWm51IQTOjcFKvJhIoroUo5VIEuhgciW30Z6+Oxdkptn7GWjNHB6noej?=
 =?us-ascii?Q?Wk1KNCNrW+dQG4RP0fFHZ5Isln8UujcQ4L/r4RP+Xnj/D03wgbbNNUGxfCs3?=
 =?us-ascii?Q?EDHBSnpOKhxArw7XpmC2EKJ2LcMN2tseEwtefHrsqi3RtxTA4xgecSMur+UO?=
 =?us-ascii?Q?+O0auvjY92jj1bqqJeSTdhCS77xzjZs8VTk2JPleMEMdF1RKtMt4a5QdPx1K?=
 =?us-ascii?Q?uHMxDg8D2Im5l6J5tzSuZC5fbLdKBIUMEaXl9W8n/+XYEJUtawo8weEUn9dR?=
 =?us-ascii?Q?BBMPHAvsk4O3vwZNwberLYG64pREgcY6wgQRaKcHj6QZt+u0ylEZJUClA0p4?=
 =?us-ascii?Q?uE16j6Dgg1eKYvQLkWKRxTJH/6oxE4fsljfaBq4onV3KjPojTCJ2w21REfnT?=
 =?us-ascii?Q?wVcgFlMM++Z2gecPPRFJHnnTs6Yigl2wQ3/8Im7m0GFQv8bNXtF4epkjAvNX?=
 =?us-ascii?Q?cXsnOGfHppgrkiGjzsIzNNlEoMeTimZ0Wbf+htJ/5QPx/t/afgHwef/gEmxi?=
 =?us-ascii?Q?VXmv3qAI7AyOh0waIlXbddT0CIwNFnX7IDDR0WhWtKiM/sdlkahSBBL1xIpz?=
 =?us-ascii?Q?yoZmJy0y7kjjSrHfwLjCfCR//k3RyX8ElsReO3nO4kyimZLz0XKMpRX3kdfO?=
 =?us-ascii?Q?xwKCuJyaEdo3m6ljoaXMwO7nnnZaU1WJxKBUgW+TZJEtbhTMib4kFw5dcEeP?=
 =?us-ascii?Q?m/LQwFeXmxR7LsDeT8PZDWEl30o+PVcUGsH1xUam7x4N/yJ6kI0zjgvIWAAY?=
 =?us-ascii?Q?vrbyJTzy4YCl/dTI+YhXwQT48PyHSVKOBQAFnrssznvTz7Ai5zJ+ae5MGAZd?=
 =?us-ascii?Q?V6D2z0lR8IelZ90HgvQzdyDLQZoy76GKpbpNfrDFu/d2bsCD/K7KDKNH27iF?=
 =?us-ascii?Q?QJ31rmLoGw5IcweQUbgmm9SnTO4kI8ewPFf4driIKqulPkNpWnnt6gvulH9t?=
 =?us-ascii?Q?b/GwVu/IHKSKpg80aMKD11AOyVtvKLYlu+nhEaqhcmiKBBmAVi2OdP2G3Plg?=
 =?us-ascii?Q?p6L2yko9rOQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XSE7DPyjHm1p//6FEPtWMICzJq7A9DxUlW2I/XOMOBuVWz/z58n7uVOwngvW?=
 =?us-ascii?Q?bhcLL6wf8okbuVauuKNroF94HzZu6BHdvelDQyWYTMrFaRrZ/u54p9ZagRzS?=
 =?us-ascii?Q?f+8U2a9jSiqCDLopCm4PGs3XDpiQ+CSQENhvqd5j1PNzOomnRkwlrhhzsL3r?=
 =?us-ascii?Q?ZWGV5bzdN07GN4eJ784VM9DnGexk9w6PWuvGP+ym3HpIoUCaSrcG6OsEEA4A?=
 =?us-ascii?Q?JC2qQH07JeYtYDTBpVWaU4FFaS6vQhaS+B7FyRIGyyKinnfPAcMkuhGSzEHi?=
 =?us-ascii?Q?5MsM57Tusk/ou5LATXBaRPy5kdzBCCYzU9wGkgTWiQZc0/raCVov4MN0tSgV?=
 =?us-ascii?Q?geooK0vJIfvDqas+vDnEcez1F2Jh8BnRkhfC6Z4DPx6MgPp8XG8jbO++9wGg?=
 =?us-ascii?Q?VIEUCu77DoTyP0deShqcJkJTsDd9fzjdBQtS7Sr5gt0VTnnSZS8GBXj5/32/?=
 =?us-ascii?Q?tTDFhTjgE7eyaNchjfkmxkBWJY7UeneobeOQOQ1U6TdRMKWYxSeDsTbtNrKq?=
 =?us-ascii?Q?nYNyZcl0pkvaYLV+wjJHtqfS+8m05ay6F4i4jC4/BkQb4nx2C/IQiiBVxAwS?=
 =?us-ascii?Q?sgKdzWLi3mreS82y09rljHlB36ufiqvKzJUTPhKCG2ZPaNZZLZGUPJEHrGWs?=
 =?us-ascii?Q?Wy6JuEENbFkp/z1/N8+jVodgKjid7A35RWZ58Nmn9wzmSFYjp8eW4IH2uOHH?=
 =?us-ascii?Q?HWM0TPRgPvOg/P6nYPYEfs4PDRv60OIZ0z3HxKpmgDrds2HIfVNViIgJyFyh?=
 =?us-ascii?Q?S2oSezUogoOP8aK7bfo/iKuPEb/6//SsXYO+l4yeUvGceGHfhkexQnWRqJyn?=
 =?us-ascii?Q?DIXYxtGscMcLlESefl/0JUKfJXDjjmdbE9p0snRAtW5awUaXiA2CdAmvuWwo?=
 =?us-ascii?Q?VQfBntu71lWfPyiyjamwN7V4cAvBo4opJQpJaDxUzmqVw+Icq5EtJEDOQ0cV?=
 =?us-ascii?Q?ziu+/St7fmBvO25uhGUewsMAKpHN5x2suX5w+eSRUO5WT+cOWmuSVP7Njab3?=
 =?us-ascii?Q?HVpoNUcb3UXFh2P73d+bOPfLmdkwj4xYhbuXd0L75NIjLf8Cx4DFWXJjRq2G?=
 =?us-ascii?Q?2nPCn30A9fm2WKJRvMtvVyMF4k/rM1jUcbS4ldrLrQBOFjjaZwwnxHjB6H9k?=
 =?us-ascii?Q?+XjXRwMqcLKX4lZO/6MF1nj0wviPFh4kzbq2QsE641DQoDTQwybq+Bd4kGrr?=
 =?us-ascii?Q?PSmyKR6DVVsritW5LABf/KGHx+W9XYk2lO+aPXjGlSJFfZCeDsrwMgy9P/db?=
 =?us-ascii?Q?/iNxBddxNdOqLfwhrhKFGuRoKaGn6CPCh/exGjOvY+M30wrXZPAOYunX3u/A?=
 =?us-ascii?Q?ht6aSDihEoncBy0HCY31AuumdrP1WOPpghd1neWcK57ZUlIW8d8fYm1QoI+p?=
 =?us-ascii?Q?rIXgK84mGNbnyvCgbzJS5q1ex496Z3+m+SVxJytYGv0X+119GxCQv0CLXyEF?=
 =?us-ascii?Q?rS4ViZeOBHzJxqEnE2ymHXpaqr0YPT5g1OEWrtCVDlUsV7eENxfIjZNN6uQg?=
 =?us-ascii?Q?TJJBvTXl3O1304Nlq9zElu7X47TVtBgSCiL5ayYHyNZwTNgQC9w31neSKnHq?=
 =?us-ascii?Q?2veY/rAmbwXAJT2gul7EpiIxuJW/qt5rgcGnmzQRVqbAaPGPC4pZjcES9b77?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2r8oLdjV6a92/dAncn/jmCHpXHrsz42AsIh+8TbpVawstcWPrRwDH7PYlEB7y0mdkbu3qQ8/tOqWse8ZX6PerUCyfPDy0Lb0fjslWTZhTWHH8JkcSc1uLOIfvG33hRQ4M9gyGv/dr7QBTxA9501W+uEyMjszqAMW/DdqlX5MrUxQa6y2Ra9N+rjtDokXrXioiQBnLnqk73UAmJLOCsLdTtqaOXzodzBI9tE1r5ALsbDdMLDflUlYs2xfBMbS62PJTbAyySSD4jPecacvRiYX8zVcueEuolAO7hdUeuncHwLmD1SigLotgncRpV7wYrTHnj0E7oFpYH2Hm+r43naL4Vb6wJndfL7Q80XIMJcmAXz+8O6fSkgXFRXorEPPgOMjnX2LyvNoonWiwQYFg05mzIOd16RuwBQAaS1JhH+wuS8flQ5pjewM5tHhagb6oW2WtVlFP2fkyJCLB1vy5Y4PiNZlj+ibv0A+uMPEID9U1KjbUtGFS+RKskkT5MTfuXJ9Gol7GSnZ/v8meV/qQJt0GHJJyFdF5At+TRSPuTX/v3B/uZU6vMpME1MOf8KgKq5L5FJf9blSOwWsjaY756e/1Phs7z4u5tfcte2v1LihWFQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2699a8e2-1f52-44b5-0a9c-08dde61d9a7c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 10:28:17.7312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /IAmSQ/oRxM9nOs9PwW1Wez+NfATsPbM0hFZS26+PrzIteHutFwWUAp8IDSmVofWCBwtIA/nQpQyUBiw9GjMSqWURW8v053D5rCqYD+jE+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=343 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508280087
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNyBTYWx0ZWRfX1To1lV4mftyN
 ufl9uwKJNRCRsPEAuM5zZYHG5M9/ZvQs8gJRSD70nARkaAdmZCL7BIF0cv+ZRCGECDpPGfsRs7d
 CI4N+HxC/N2C6bcU3DIRRy9/9Gle8icUfwRnG2T5VuTEaBR2xGUF/9gEHmYNzO7htKlQEIG3/Qn
 G1vGNGXBdknREvp06eMjuZIpWV/M2wvfbHstXl2ewdW4bv60BhW0+MgKl5CWM/iNi6Ed3hW/Pgf
 UuJbbaZbbceRK04CjNvZ7++PldX9J8T9eZsi6XscqvrxZNKWrC899/pKdoTMuhO+PPEWHS9QWOq
 rmYag62wU2tE10Tw4dZXC8rQTQMI4gP/DZ9KigI2u15hxFMIC5+EWF33mL00o29ExyEkOhp4kDA
 XqOFUeh8
X-Proofpoint-ORIG-GUID: omohcW7PjBglPHjaTZZmWTCl0loIFfeS
X-Proofpoint-GUID: omohcW7PjBglPHjaTZZmWTCl0loIFfeS
X-Authority-Analysis: v=2.4 cv=IauHWXqa c=1 sm=1 tr=0 ts=68b02f48 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=s1m6ZhuokHrNuwRQD04A:9
 a=CjuIK1q_8ugA:10

On Wed, Aug 27, 2025 at 11:04:40AM +0000, Brendan Jackman wrote:
> De-duplicating this lets us delete a bit of code.

Thanks very much! This is nice stuff.

>
> Ulterior motive: I'm working on a new set of the userspace-based unit
> tests, which will need the atomics API too. That would involve even more
> duplication, so while the win in this patchset alone is very minimal, it
> looks a lot more significant with my other WIP patchset.

I hope that my + Liam's work helped inspire you :)

>
> I've tested these commands:
>
> make -C tools/testing/vma -j
> tools/testing/vma/vma
>
> make -C tools/testing/radix-tree -j
> tools/testing/radix-tree/main
>
> Note the EXTRA_CFLAGS patch is actually orthogonal, let me know if you'd
> prefer I send it separately.

It's fine!

Cheers, Lorenzo

