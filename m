Return-Path: <linux-kernel+bounces-756861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7FBB1BA7D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794BA18A71E6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6659F29994E;
	Tue,  5 Aug 2025 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Z8mysKSa"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2129.outbound.protection.outlook.com [40.107.243.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B951199939
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754420013; cv=fail; b=DA2sLQam2ZQgH9c22TZIqCGjlcMscL32fKCwQxBscl932pTGJPKnlJcCqpd2cbEQqrCTPO1LFCWNi9anRWWz9zHVtk548GASWzs/CMYH3a0kKnb7CQtfwaIhQerGE5fwjOdNhyTmSkBElF3D9176YqclIwn3/cjRt/6arKsId9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754420013; c=relaxed/simple;
	bh=Yd/ThawZFU90H3cBgvS10KJ9PTMO78T/XAXD+bLcd3o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gLbSl4QhQ+jmyorkIG503xoUGPRrI1YjSipEymt0DoDxDiBkpt+nt1NShQEKLQhHTytJe/RSM9DDCWI/jKJGetezHlr4d2Q/tA7GHHnaZo/PDDOm+0zSynX7uB0BeypTwmWpzG/lqpbd+DIchrnE+cebHqPfIrLzcMS41xw77No=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Z8mysKSa; arc=fail smtp.client-ip=40.107.243.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJDJsQdHdnKdiWgIAGgMpnLNjoWn09arnGlWHGAlDQ+De/wGJrmiOVsRsyUAG172aOoIhtwwydCzknthKMouele4vVijYfdfBy5MxCOeb6lRYe6CgUNAy4e3kJf4SHWZorLh+Wcu59QexzG3OSajtJAeRl5HO9UsFWK32LDU1ZEXLU1NOdUeB2Sm1NGrRj5pui8CmWR5MyHVV14b8TttUu57svBvtZ2Uzzvx/Y/++Uy8peOBzmBUyEDGy0rumLXat/7KJ4Sj3lTonhHf8Ar5AA8bN5bEcTgP3wU4J4VtOGYq1nAZSvMBl2xFbGenpQVQsf0ENHmVp4EXKkpgwZFSvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUAha+Yp4sO0YQHye/GdpPYhJltqX0M9sPW0J4zof4k=;
 b=JUSXL7q92oxKJ/nMK01GFLIPDOPRG2Hp0HLa8Ataf9SCPHrCLyxdWcRtWLO1Uc2H6+ZUnhzIt6jzA0oLleCxcljzHMlRsLx5UJgeqHmx6EtRKUBdGHX0vpzyapXjMabBsu1aopNnmAV8DWUqqizGddGtEi6szLasYZNvle1UqKbgdV9YxvU8hjiJhFPPpIRgFNhnjtsMkVtfl965uzShhBozTkohpXqlWs8IoBOkRA2Kj1XoJtumplrAWwEbFrdgSDYXaJaGh8wCqXFcK6dbrg+toZ+KbJtoEqJ7taQozMWb7kpXvtQulXjatTUETv+lP4iZloMhcdBySBQQqNxoDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUAha+Yp4sO0YQHye/GdpPYhJltqX0M9sPW0J4zof4k=;
 b=Z8mysKSa4Y7XTXipI3pii4niH2kW3jYvfKi8ZSrcXN+6i/jaAff9JEFsLUw1dpXkLLX5kCpCaFnuTmfiGp0KRwh9JwCo8utHSxcQBFrGzfZqu3BqcA4mLBfdNh8yDDPRli6I/pkgMxbQMOC4Nh+Wv6zRKt2uKQzBAhF2hhdwEuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CH5PR01MB9055.prod.exchangelabs.com (2603:10b6:610:211::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.21; Tue, 5 Aug 2025 18:53:27 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 18:53:27 +0000
Message-ID: <e65ed11d-68ef-4b9c-80ad-7e880743b3d3@os.amperecomputing.com>
Date: Tue, 5 Aug 2025 11:53:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: mm: support large block mapping when
 rodata=full
To: Ryan Roberts <ryan.roberts@arm.com>, will@kernel.org,
 catalin.marinas@arm.com, akpm@linux-foundation.org, Miko.Lenczewski@arm.com,
 dev.jain@arm.com, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250724221216.1998696-1-yang@os.amperecomputing.com>
 <20250724221216.1998696-4-yang@os.amperecomputing.com>
 <0e86671e-18bb-4f3b-9294-c583299ad49e@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <0e86671e-18bb-4f3b-9294-c583299ad49e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0287.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::22) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CH5PR01MB9055:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f9cf275-a08c-4220-a62c-08ddd4515ca0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkxSWm95VFJ2ZTIvM0ZhYzc0azZGTHg2RDBhWGF0aFg5aDJyZDJQSU1BSUYr?=
 =?utf-8?B?UUJiSk4vL2pUSStJOXlHdERlRDRuNUhkeG1wN0RnRFlyMStpcHBmdFJveStN?=
 =?utf-8?B?b3VsV2RKL1k4emJkMHhua2IvMjhXV2twdFh1bzdwd05MMCtDN2lGRWo3S1Rv?=
 =?utf-8?B?OW54OFN2eEtaK0FuYjloZG96aVF5enBMaWJUNEUwTjN1Ly9Id3VGR1VBTEJa?=
 =?utf-8?B?WWlRcTVEY2M2eTl3Rm5zWWw0NFBOKzlZU0Iyb09sN0dtSFNXSFVlcmtoSE1W?=
 =?utf-8?B?UXJzWVR6TnNXcXEyUHN5bTJGb3hGcU0veFFXRTlOYnV1cnlYbzZSQTQyMnVo?=
 =?utf-8?B?anlwaEFyb1FVem5pL042SXVWUFpMdG00b2IvM2FmSWIxdzhCWm52L2xwaS9Y?=
 =?utf-8?B?YnM3aVA5YmNXbDJxNWk3NnJuVEZIN2NkQTRMbHZqNEJ0V3AvNkpjYmdrSmtu?=
 =?utf-8?B?QXdHQXV1bzBVT2R3Skx4U3dkc09POGlwcUg0M1N3d3NYY0NQQzJRamhGbktq?=
 =?utf-8?B?TGVpM3FGUzh5c3RpMXpqK1J5Z2ZmdGQwVDJWT1EzTUNWaFBVb01pQzZReVJk?=
 =?utf-8?B?NDcreERPczBFcTBLM3RjdG9HUk9CNG5pa3l4VE9nZjlRTjQ1aUlIOU9CcWJi?=
 =?utf-8?B?KzV6Ti9BQUZvVVozblhEajdXSlNhV0FZQlZNZ25Xd1gxY0o0K0xaT3FXTHkr?=
 =?utf-8?B?cUxkZFh2SlpjQVNmRGxQcSt5amMyT0lweXFvaGZ0UHozaEpJM1dhcE9oVGJY?=
 =?utf-8?B?OEJhWjRpOGxwMVBDS3dENmZuK0h2aVpEYjg3bkkrRk53aXFsVE9RY1lTcVBF?=
 =?utf-8?B?c0xqeG1JZUxuaUlFR3Y5UUVLaVIrNDhvTTB1Vko0ZW1OVUdEbzNCM3A0ODg0?=
 =?utf-8?B?K1BRdTljRmY1YndWRFJaNVZ1M1JmNHdvS0JFUHdCYnhZVWtIcEo0Z3FaMXJT?=
 =?utf-8?B?UGxZWExNbXF4OHU2dG1TdFlNWVJ0ejlOZkQ3ZGtDSHhFajRkK241MFVmZStK?=
 =?utf-8?B?OUZ6UFhxRk93QnJlb2xFOEJDdUhUdzNoaGxXT2IwY0dFTXZpRUVNaThOR3B3?=
 =?utf-8?B?K2RudXlsUGowU3FFekpnY1RSV2NZS2pSZG1FYW02VDNEUW5kanVhVDFhYUZx?=
 =?utf-8?B?SzVnKzZ3cnJwWm9ncWpKOXFibENET28rMjNVRVJFNGExWDBuQTRUODZERG9s?=
 =?utf-8?B?alBYanc4a09ydG5VV3Urb1JxQUF1SjdlRFJMd1FSTEZtak9ieGtSK3hXVG81?=
 =?utf-8?B?emZPUTVOaXNDSHFac29INitxdjdocFY0WnREM3hYRDM2MzZGMGNUdUNFNHl5?=
 =?utf-8?B?b2cxNEdEK2t0MUd6N082NGMyaG5kSWNKTDAvMXhXeGRPRml5cVNUOXdMZkxS?=
 =?utf-8?B?aDFSRHppeTVpaFgxT3hHNFpQWUxYaENUOVZIbjI5UjJkMU5ndkZscy82d2pN?=
 =?utf-8?B?eXFXYUgrbkdnYzZtdVB4b1FEamlDbHFpQ1h2aDl6OVFVVUU5bVNRVFYyNlhI?=
 =?utf-8?B?QWhhWDAzQmF6S3JzN2NHWGJoTGF5UStRYU9wUHF2LzlzMHg3YXFZOWZqN09Y?=
 =?utf-8?B?a0YwWGRvNy9LTmNmV2ZQYTlUM05rTDBvbzFQaDZiU1RYREtGU1dRRzJFT0hu?=
 =?utf-8?B?LzN2L3VKOXJPZGdRRVZkZSsyMTE2MWxQMnVCYk9jdHN3Y2hHLzhXeHI0RVR6?=
 =?utf-8?B?S1BiNzQ4Z2NvN04yNXMyVCtlMXc3eDhReUpnd1U0bmFWTkRmbjR1Z2JoZGpn?=
 =?utf-8?B?S2dOK0tZeUlsSStoNkx5dVpPNVNTWVJGakppSnVBQlZWTzlHMkpYTGxwVXJR?=
 =?utf-8?B?T1p4SmN6OXU3a0R5SURpbEFwTEdXWU9uRWJWcS9sVVg0VWJ6MmxoRXhaUzdQ?=
 =?utf-8?B?ZkEyUktJdjBKcnp3MUpRODIya3VuclB0WEVZelR6a2ZxVldGSmpnaHlpUzdr?=
 =?utf-8?Q?T/KzCiJ5+Nk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjhoT1ZURWNNZVNFb0l2UHZzcVBHQ2VsdFN3WDJteHhvV25PR3pOSldKMzRP?=
 =?utf-8?B?NDhOWEZSdHBicWpiZW40S2pMUHh2UmdGaEt2eFJrU2lZSHdZSktjbDR6VUJS?=
 =?utf-8?B?OUNiYlFFTWxwbk93aHVGdHJvSGREeStvUFlLQjk0b2Z4ekl5R0VvV2xVSmYz?=
 =?utf-8?B?TnJnSjdnZkVXTkNjb3krMlVDbHp1L0dtOHlKL0NMcHNZODF2bXFVZHFhZ2pP?=
 =?utf-8?B?bmN5Q0NPWGtwN3NjNUpKSml1K3VtMDBWdys1cTFRbHhJa2Zlb2NSM3JnOVV1?=
 =?utf-8?B?T1liM2x1aTIyTjU1dVVnM09kejQ2ZVFHaGU5WWFqcGlWcHhmT2RTUVhQQUVh?=
 =?utf-8?B?ckZvNUY3MGNiTUxIZFNtYzluT3FGby9ubC9lL09XYzZ4WnVHeUw4RzZTTlB1?=
 =?utf-8?B?Rnp6ZXZYNzNteGJkMnhxdjc4bHk1bzNuWDdGcWFoNnJuVjdwOWMwM2dmRzA4?=
 =?utf-8?B?RFFqelZBajlyaXFvYnVFQ2dsTzBseDg5Z2pySXczSndXbTJkM25xYjh1ajk4?=
 =?utf-8?B?cWZMRHN6VURZaE9aM2pGZGxVOERZM0pQWC8xWmlUblJBUVNraWowRURqeDZr?=
 =?utf-8?B?ZW82QXo0Z1RaZXdYZHJ1dU0rYy9NNXdRUnN2WGRvOStuVmVuNkFBMkVYTm85?=
 =?utf-8?B?NlFPQWh0bm9DaVdVdkxVdHU4K3g2VS9WZlg3WEcrb3ZvMUdPUkhwbU92V2dH?=
 =?utf-8?B?dVFWTEEzQ0dqbWpYTkJKMGtyTTlNRGEvVzZOTXl4OHhpcDUyRUFrV2lMS3Ax?=
 =?utf-8?B?NDFSa2lYWVo2Qm5HQUE2aHdoOFd4MVNUZWpwL1IyeDViTEkyTmxIUkp3eUd3?=
 =?utf-8?B?WThDNFpiUzQ2WXUyTzVQdnNoUUMvSWxCczRMVlFncWhoWUNBbkZsVzRtSWFK?=
 =?utf-8?B?NlJjdkhObHE0NGNNSHBrdEd2MDE4c0UvQm50bjVQbCsyb3hPaFVldERqWU5X?=
 =?utf-8?B?Y1VIbHhBa2owdndnV0kvTFNxNVJUeXREbXIwOHBvdXA3cFFDYTh4K1c0a01y?=
 =?utf-8?B?TElzU3VvbVBCcU9adU9KWVBJd1VOd3pkdGpSVlluSW5zc25JL0wwUGFFWHJ4?=
 =?utf-8?B?UzgzOWZxQTRmd0VQUnhnRVUyR1ozb0dqc2hiTEN6VmhlemViT2RhVWk4cGpQ?=
 =?utf-8?B?d3BlVlFRdWwrc2NaSWF5eGo1UUNqdUo1RENMaHdIKzl4ZVM4VUc5QjA0ditJ?=
 =?utf-8?B?aWFiU1pBQ3lJZEhpNnppeSt4VkpTOC9wZWYvb1M4UmlqSnJaT1ZjN0YyTzVC?=
 =?utf-8?B?aDMzYmRLa1diZVo2UnJyTUthei8vRE8wWDJaUzdBQ3JoOWxpUXJjajF3VXVX?=
 =?utf-8?B?YlVtS3p6N3lhWUY3TERHK28zMzZZZm93SU5NLzVRUzArRm9CZmlDL3I2cWg4?=
 =?utf-8?B?NEtnNEsvTjZ3Vk5XaWRldEh5UW9nWHJLd1NteTdqa3I4Z21KY1oxVjBjbDJL?=
 =?utf-8?B?aFVnSEJiRGI2VDVwdzJxZVJUODJtMzdzNWVkNVNrK29pd0xnNW14UWszZ2RH?=
 =?utf-8?B?ZC9ucVFSdXBHQXRtaU1GeGpKV0VnOXY5RzZwWHY3SHpXbDZleFB3eTd1UHNZ?=
 =?utf-8?B?M1E4Y3pqd0hUS3F4TFpBaTJaaFRMYlVhRzVxRXgrbkVWTndNMjlrQTU2RUl3?=
 =?utf-8?B?VHRKb2Uvbk5aejY4WWxhV0tPenZPc3psQ1pZNUhPK0wrM055eitqSHpFNVY1?=
 =?utf-8?B?OFpzbkl0S2VsUnF1VHpFZnk5WEdhWnZkSHUyWWVTMTM2R2tTVGhDRHhPV3Yr?=
 =?utf-8?B?QkRqT2xyR01tYmNGcDdjK3FScGxvNXpkOVhqVmkrMG1UMlpOaEhyT08vckFQ?=
 =?utf-8?B?WFUyZmVhcDB0cWJES2dKZFFKck52czQyaU4vc0pPL0JOdHJzZEtYMDQ0NGFZ?=
 =?utf-8?B?cVVGV0tQRVZEenlza1JwZVhLejQxQ040UWJJdk8rVElReDNiL09wcENxaFg1?=
 =?utf-8?B?R3E4eDRmWUJHWkZ3azhpdGVuZWk5c3Rpb1daWW5HWnZ1MDFLeHF3M2Z5QWJK?=
 =?utf-8?B?cXY0emxvMC9IQzhxMEViNFFrckg5SE9XNk96VzErUEpjejZUczlyd0c1VmlT?=
 =?utf-8?B?QkE5STVCeXVNS0FBR3VNR2xEVE9TaTdIem45ZzFWclhMS01XbWpnZ0hYVkZY?=
 =?utf-8?B?VmtnTG1tL2JwVFBBM1grdXZGUHA0eVZOeXZZL2xxTmhlMWlna1RhK0dDakJa?=
 =?utf-8?Q?ZQz/r89Pp93VVj8552Pndp0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9cf275-a08c-4220-a62c-08ddd4515ca0
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 18:53:27.0668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vb5YYiWwr6SKzuwCt+fs6YCQkpUdB19GibOVuJIxsmHtLjaiRxpPXPz4mK09WsYfTRvBtqr4g6lNUIRi8cmu1Ik8nDtoVAgV61cypaQ7IQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR01MB9055



On 8/1/25 7:35 AM, Ryan Roberts wrote:
> On 24/07/2025 23:11, Yang Shi wrote:
>> When rodata=full is specified, kernel linear mapping has to be mapped at
>> PTE level since large page table can't be split due to break-before-make
>> rule on ARM64.
>>
>> This resulted in a couple of problems:
>>    - performance degradation
>>    - more TLB pressure
>>    - memory waste for kernel page table
>>
>> With FEAT_BBM level 2 support, splitting large block page table to
>> smaller ones doesn't need to make the page table entry invalid anymore.
>> This allows kernel split large block mapping on the fly.
>>
>> Add kernel page table split support and use large block mapping by
>> default when FEAT_BBM level 2 is supported for rodata=full.  When
>> changing permissions for kernel linear mapping, the page table will be
>> split to smaller size.
>>
>> The machine without FEAT_BBM level 2 will fallback to have kernel linear
>> mapping PTE-mapped when rodata=full.
>>
>> With this we saw significant performance boost with some benchmarks and
>> much less memory consumption on my AmpereOne machine (192 cores, 1P) with
>> 256GB memory.
>>
>> * Memory use after boot
>> Before:
>> MemTotal:       258988984 kB
>> MemFree:        254821700 kB
>>
>> After:
>> MemTotal:       259505132 kB
>> MemFree:        255410264 kB
>>
>> Around 500MB more memory are free to use.  The larger the machine, the
>> more memory saved.
>>
>> * Memcached
>> We saw performance degradation when running Memcached benchmark with
>> rodata=full vs rodata=on.  Our profiling pointed to kernel TLB pressure.
>> With this patchset we saw ops/sec is increased by around 3.5%, P99
>> latency is reduced by around 9.6%.
>> The gain mainly came from reduced kernel TLB misses.  The kernel TLB
>> MPKI is reduced by 28.5%.
>>
>> The benchmark data is now on par with rodata=on too.
>>
>> * Disk encryption (dm-crypt) benchmark
>> Ran fio benchmark with the below command on a 128G ramdisk (ext4) with disk
>> encryption (by dm-crypt).
>> fio --directory=/data --random_generator=lfsr --norandommap --randrepeat 1 \
>>      --status-interval=999 --rw=write --bs=4k --loops=1 --ioengine=sync \
>>      --iodepth=1 --numjobs=1 --fsync_on_close=1 --group_reporting --thread \
>>      --name=iops-test-job --eta-newline=1 --size 100G
>>
>> The IOPS is increased by 90% - 150% (the variance is high, but the worst
>> number of good case is around 90% more than the best number of bad case).
>> The bandwidth is increased and the avg clat is reduced proportionally.
>>
>> * Sequential file read
>> Read 100G file sequentially on XFS (xfs_io read with page cache populated).
>> The bandwidth is increased by 150%.
>>
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> ---
>>   arch/arm64/include/asm/cpufeature.h |  34 ++++
>>   arch/arm64/include/asm/mmu.h        |   1 +
>>   arch/arm64/include/asm/pgtable.h    |   5 +
>>   arch/arm64/kernel/cpufeature.c      |  31 +--
>>   arch/arm64/mm/mmu.c                 | 293 +++++++++++++++++++++++++++-
>>   arch/arm64/mm/pageattr.c            |   4 +
>>   6 files changed, 333 insertions(+), 35 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
>> index bf13d676aae2..d0d394cc837d 100644
>> --- a/arch/arm64/include/asm/cpufeature.h
>> +++ b/arch/arm64/include/asm/cpufeature.h
>> @@ -871,6 +871,40 @@ static inline bool system_supports_pmuv3(void)
>>   	return cpus_have_final_cap(ARM64_HAS_PMUV3);
>>   }
>>   
>> +static inline bool bbml2_noabort_available(void)
>> +{
>> +	/*
>> +	 * We want to allow usage of BBML2 in as wide a range of kernel contexts
>> +	 * as possible. This list is therefore an allow-list of known-good
>> +	 * implementations that both support BBML2 and additionally, fulfill the
>> +	 * extra constraint of never generating TLB conflict aborts when using
>> +	 * the relaxed BBML2 semantics (such aborts make use of BBML2 in certain
>> +	 * kernel contexts difficult to prove safe against recursive aborts).
>> +	 *
>> +	 * Note that implementations can only be considered "known-good" if their
>> +	 * implementors attest to the fact that the implementation never raises
>> +	 * TLB conflict aborts for BBML2 mapping granularity changes.
>> +	 */
>> +	static const struct midr_range supports_bbml2_noabort_list[] = {
>> +		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
>> +		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
>> +		MIDR_ALL_VERSIONS(MIDR_AMPERE1),
>> +		MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
>> +		{}
>> +	};
>> +
>> +	/* Does our cpu guarantee to never raise TLB conflict aborts? */
>> +	if (!is_midr_in_range_list(supports_bbml2_noabort_list))
>> +		return false;
>> +
>> +	/*
>> +	 * We currently ignore the ID_AA64MMFR2_EL1 register, and only care
>> +	 * about whether the MIDR check passes.
>> +	 */
>> +
>> +	return true;
>> +}
> I don't think this function should be inline. Won't we end up duplicating the
> midr list everywhere? Suggest moving back to cpufeature.c.

Yes, you are right.

>
>> +
>>   static inline bool system_supports_bbml2_noabort(void)
>>   {
>>   	return alternative_has_cap_unlikely(ARM64_HAS_BBML2_NOABORT);
>> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
>> index 6e8aa8e72601..57f4b25e6f33 100644
>> --- a/arch/arm64/include/asm/mmu.h
>> +++ b/arch/arm64/include/asm/mmu.h
>> @@ -71,6 +71,7 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
>>   			       pgprot_t prot, bool page_mappings_only);
>>   extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
>>   extern void mark_linear_text_alias_ro(void);
>> +extern int split_kernel_pgtable_mapping(unsigned long start, unsigned long end);
>>   
>>   /*
>>    * This check is triggered during the early boot before the cpufeature
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index ba63c8736666..ad2a6a7e86b0 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -371,6 +371,11 @@ static inline pmd_t pmd_mkcont(pmd_t pmd)
>>   	return __pmd(pmd_val(pmd) | PMD_SECT_CONT);
>>   }
>>   
>> +static inline pmd_t pmd_mknoncont(pmd_t pmd)
>> +{
>> +	return __pmd(pmd_val(pmd) & ~PMD_SECT_CONT);
>> +}
>> +
>>   #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
>>   static inline int pte_uffd_wp(pte_t pte)
>>   {
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index d2a8a509a58e..1c96016a7a41 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -2215,36 +2215,7 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
>>   
>>   static bool has_bbml2_noabort(const struct arm64_cpu_capabilities *caps, int scope)
>>   {
>> -	/*
>> -	 * We want to allow usage of BBML2 in as wide a range of kernel contexts
>> -	 * as possible. This list is therefore an allow-list of known-good
>> -	 * implementations that both support BBML2 and additionally, fulfill the
>> -	 * extra constraint of never generating TLB conflict aborts when using
>> -	 * the relaxed BBML2 semantics (such aborts make use of BBML2 in certain
>> -	 * kernel contexts difficult to prove safe against recursive aborts).
>> -	 *
>> -	 * Note that implementations can only be considered "known-good" if their
>> -	 * implementors attest to the fact that the implementation never raises
>> -	 * TLB conflict aborts for BBML2 mapping granularity changes.
>> -	 */
>> -	static const struct midr_range supports_bbml2_noabort_list[] = {
>> -		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
>> -		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
>> -		MIDR_ALL_VERSIONS(MIDR_AMPERE1),
>> -		MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
>> -		{}
>> -	};
>> -
>> -	/* Does our cpu guarantee to never raise TLB conflict aborts? */
>> -	if (!is_midr_in_range_list(supports_bbml2_noabort_list))
>> -		return false;
>> -
>> -	/*
>> -	 * We currently ignore the ID_AA64MMFR2_EL1 register, and only care
>> -	 * about whether the MIDR check passes.
>> -	 */
>> -
>> -	return true;
>> +	return bbml2_noabort_available();
>>   }
>>   
>>   #ifdef CONFIG_ARM64_PAN
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 3d5fb37424ab..f63b39613571 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -480,6 +480,8 @@ void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
>>   			     int flags);
>>   #endif
>>   
>> +#define INVALID_PHYS_ADDR	-1
>> +
>>   static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
>>   				       enum pgtable_type pgtable_type)
>>   {
>> @@ -487,7 +489,9 @@ static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
>>   	struct ptdesc *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_ZERO, 0);
>>   	phys_addr_t pa;
>>   
>> -	BUG_ON(!ptdesc);
>> +	if (!ptdesc)
>> +		return INVALID_PHYS_ADDR;
>> +
>>   	pa = page_to_phys(ptdesc_page(ptdesc));
>>   
>>   	switch (pgtable_type) {
>> @@ -509,15 +513,29 @@ static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
>>   }
>>   
>>   static phys_addr_t __maybe_unused
>> -pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
>> +split_pgtable_alloc(enum pgtable_type pgtable_type)
>>   {
>>   	return __pgd_pgtable_alloc(&init_mm, pgtable_type);
>>   }
>>   
>> +static phys_addr_t __maybe_unused
>> +pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
>> +{
>> +	phys_addr_t pa;
>> +
>> +	pa = __pgd_pgtable_alloc(&init_mm, pgtable_type);
>> +	BUG_ON(pa == INVALID_PHYS_ADDR);
>> +	return pa;
>> +}
>> +
>>   static phys_addr_t
>>   pgd_pgtable_alloc_special_mm(enum pgtable_type pgtable_type)
>>   {
>> -	return __pgd_pgtable_alloc(NULL, pgtable_type);
>> +	phys_addr_t pa;
>> +
>> +	pa = __pgd_pgtable_alloc(NULL, pgtable_type);
>> +	BUG_ON(pa == INVALID_PHYS_ADDR);
>> +	return pa;
>>   }
> The allocation all looks clean to me now. Thanks.

Thank you for the suggestion.

>
>>   
>>   /*
>> @@ -552,6 +570,254 @@ void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
>>   			     pgd_pgtable_alloc_special_mm, flags);
>>   }
>>   
>> +static DEFINE_MUTEX(pgtable_split_lock);
>> +
>> +static int split_cont_pte(pmd_t *pmdp, unsigned long addr, unsigned long end)
>> +{
>> +	pte_t *ptep;
>> +	unsigned long next;
>> +	unsigned int nr;
>> +	unsigned long span;
>> +
>> +	ptep = pte_offset_kernel(pmdp, addr);
>> +
>> +	do {
>> +		pte_t *_ptep;
>> +
>> +		nr = 0;
>> +		next = pte_cont_addr_end(addr, end);
>> +		if (next < end)
>> +			nr = max(nr, ((end - next) / CONT_PTE_SIZE));
>> +		span = nr * CONT_PTE_SIZE;
>> +
>> +		_ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * CONT_PTES);
>> +		ptep += pte_index(next) - pte_index(addr) + nr * CONT_PTES;
>> +
>> +		if (((addr | next) & ~CONT_PTE_MASK) == 0)
>> +			continue;
>> +
>> +		if (!pte_cont(__ptep_get(_ptep)))
>> +			continue;
>> +
>> +		for (int i = 0; i < CONT_PTES; i++, _ptep++)
>> +			__set_pte(_ptep, pte_mknoncont(__ptep_get(_ptep)));
>> +	} while (addr = next + span, addr != end);
>> +
>> +	return 0;
>> +}
>> +
>> +static int split_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end)
>> +{
>> +	unsigned long next;
>> +	unsigned int nr;
>> +	unsigned long span;
>> +	int ret = 0;
>> +
>> +	do {
>> +		pmd_t pmd;
>> +
>> +		nr = 1;
>> +		next = pmd_addr_end(addr, end);
>> +		if (next < end)
>> +			nr = max(nr, ((end - next) / PMD_SIZE));
>> +		span = (nr - 1) * PMD_SIZE;
>> +
>> +		if (((addr | next) & ~PMD_MASK) == 0)
>> +			continue;
>> +
>> +		pmd = pmdp_get(pmdp);
>> +		if (pmd_leaf(pmd)) {
>> +			phys_addr_t pte_phys;
>> +			pte_t *ptep;
>> +			pmdval_t pmdval = PMD_TYPE_TABLE | PMD_TABLE_UXN |
>> +					  PMD_TABLE_AF;
>> +			unsigned long pfn = pmd_pfn(pmd);
>> +			pgprot_t prot = pmd_pgprot(pmd);
>> +
>> +			pte_phys = split_pgtable_alloc(TABLE_PTE);
>> +			if (pte_phys == INVALID_PHYS_ADDR)
>> +				return -ENOMEM;
>> +
>> +			if (pgprot_val(prot) & PMD_SECT_PXN)
>> +				pmdval |= PMD_TABLE_PXN;
>> +
>> +			prot = __pgprot((pgprot_val(prot) & ~PTE_TYPE_MASK) |
>> +					PTE_TYPE_PAGE);
>> +			prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>> +			ptep = (pte_t *)phys_to_virt(pte_phys);
>> +			for (int i = 0; i < PTRS_PER_PTE; i++, ptep++, pfn++)
>> +				__set_pte(ptep, pfn_pte(pfn, prot));
>> +
>> +			dsb(ishst);
>> +
>> +			__pmd_populate(pmdp, pte_phys, pmdval);
>> +		}
>> +
>> +		ret = split_cont_pte(pmdp, addr, next);
>> +		if (ret)
>> +			break;
>> +	} while (pmdp += nr, addr = next + span, addr != end);
>> +
>> +	return ret;
>> +}
>> +
>> +static int split_cont_pmd(pud_t *pudp, unsigned long addr, unsigned long end)
>> +{
>> +	pmd_t *pmdp;
>> +	unsigned long next;
>> +	unsigned int nr;
>> +	unsigned long span;
>> +	int ret = 0;
>> +
>> +	pmdp = pmd_offset(pudp, addr);
>> +
>> +	do {
>> +		pmd_t *_pmdp;
>> +
>> +		nr = 0;
>> +		next = pmd_cont_addr_end(addr, end);
>> +		if (next < end)
>> +			nr = max(nr, ((end - next) / CONT_PMD_SIZE));
>> +		span = nr * CONT_PMD_SIZE;
>> +
>> +		if (((addr | next) & ~CONT_PMD_MASK) == 0) {
>> +			pmdp += pmd_index(next) - pmd_index(addr) +
>> +				nr * CONT_PMDS;
>> +			continue;
>> +		}
>> +
>> +		_pmdp = PTR_ALIGN_DOWN(pmdp, sizeof(*pmdp) * CONT_PMDS);
>> +		if (!pmd_cont(pmdp_get(_pmdp)))
>> +			goto split;
>> +
>> +		for (int i = 0; i < CONT_PMDS; i++, _pmdp++)
>> +			set_pmd(_pmdp, pmd_mknoncont(pmdp_get(_pmdp)));
>> +
>> +split:
>> +		ret = split_pmd(pmdp, addr, next);
>> +		if (ret)
>> +			break;
>> +
>> +		pmdp += pmd_index(next) - pmd_index(addr) + nr * CONT_PMDS;
>> +	} while (addr = next + span, addr != end);
>> +
>> +	return ret;
>> +}
>> +
>> +static int split_pud(p4d_t *p4dp, unsigned long addr, unsigned long end)
>> +{
>> +	pud_t *pudp;
>> +	unsigned long next;
>> +	unsigned int nr;
>> +	unsigned long span;
>> +	int ret = 0;
>> +
>> +	pudp = pud_offset(p4dp, addr);
>> +
>> +	do {
>> +		pud_t pud;
>> +
>> +		nr = 1;
>> +		next = pud_addr_end(addr, end);
>> +		if (next < end)
>> +			nr = max(nr, ((end - next) / PUD_SIZE));
>> +		span = (nr - 1) * PUD_SIZE;
>> +
>> +		if (((addr | next) & ~PUD_MASK) == 0)
>> +			continue;
>> +
>> +		pud = pudp_get(pudp);
>> +		if (pud_leaf(pud)) {
>> +			phys_addr_t pmd_phys;
>> +			pmd_t *pmdp;
>> +			pudval_t pudval = PUD_TYPE_TABLE | PUD_TABLE_UXN |
>> +					  PUD_TABLE_AF;
>> +			unsigned long pfn = pud_pfn(pud);
>> +			pgprot_t prot = pud_pgprot(pud);
>> +			unsigned int step = PMD_SIZE >> PAGE_SHIFT;
>> +
>> +			pmd_phys = split_pgtable_alloc(TABLE_PMD);
>> +			if (pmd_phys == INVALID_PHYS_ADDR)
>> +				return -ENOMEM;
>> +
>> +			if (pgprot_val(prot) & PMD_SECT_PXN)
>> +				pudval |= PUD_TABLE_PXN;
>> +
>> +			prot = __pgprot((pgprot_val(prot) & ~PMD_TYPE_MASK) |
>> +					PMD_TYPE_SECT);
>> +			prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>> +			pmdp = (pmd_t *)phys_to_virt(pmd_phys);
>> +			for (int i = 0; i < PTRS_PER_PMD; i++, pmdp++) {
>> +				set_pmd(pmdp, pfn_pmd(pfn, prot));
>> +				pfn += step;
>> +			}
>> +
>> +			dsb(ishst);
>> +
>> +			__pud_populate(pudp, pmd_phys, pudval);
>> +		}
>> +
>> +		ret = split_cont_pmd(pudp, addr, next);
>> +		if (ret)
>> +			break;
>> +	} while (pudp += nr, addr = next + span, addr != end);
>> +
>> +	return ret;
>> +}
>> +
>> +static int split_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end)
>> +{
>> +	p4d_t *p4dp;
>> +	unsigned long next;
>> +	int ret = 0;
>> +
>> +	p4dp = p4d_offset(pgdp, addr);
>> +
>> +	do {
>> +		next = p4d_addr_end(addr, end);
>> +
>> +		ret = split_pud(p4dp, addr, next);
>> +		if (ret)
>> +			break;
>> +	} while (p4dp++, addr = next, addr != end);
>> +
>> +	return ret;
>> +}
>> +
>> +static int split_pgd(pgd_t *pgdp, unsigned long addr, unsigned long end)
>> +{
>> +	unsigned long next;
>> +	int ret = 0;
>> +
>> +	do {
>> +		next = pgd_addr_end(addr, end);
>> +		ret = split_p4d(pgdp, addr, next);
>> +		if (ret)
>> +			break;
>> +	} while (pgdp++, addr = next, addr != end);
>> +
>> +	return ret;
>> +}
>> +
>> +int split_kernel_pgtable_mapping(unsigned long start, unsigned long end)
>> +{
>> +	int ret;
>> +
>> +	if (!system_supports_bbml2_noabort())
>> +		return 0;
>> +
>> +	if (start != PAGE_ALIGN(start) || end != PAGE_ALIGN(end))
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&pgtable_split_lock);
> On reflection, I agree this lock approach is simpler than my suggestion to do it
> locklessly and I doubt this will become a bottleneck. Given x86 does it this
> way, I guess it's fine.
>
>> +	arch_enter_lazy_mmu_mode();
>> +	ret = split_pgd(pgd_offset_k(start), start, end);
> My instinct still remains that it would be better not to iterate over the range
> here, but instead call a "split(start); split(end);" since we just want to split
> the start and end. So the code would be simpler and probably more performant if
> we get rid of all the iteration.

It should be more performant for splitting large range, especially the 
range includes leaf mappings at different levels. But I had some 
optimization to skip leaf mappings in this version, so it should be 
close to your implementation from performance perspective. And it just 
walks the page table once instead of twice. It should be more efficient 
for small split, for example, 4K.

>
> But I'm guessing you are going to enhance this infra in the next patch to
> support splitting all entries in the range for the system-doesn't-support-bbml case?

Yes. I added "flags" parameter in patch #4. When repainting the page 
table, NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS will be passed in to tell 
split_pgd() to split the page table all the way down to PTEs.

>
> Anyway, I'll take a look at the next patch then come back to review the details
> of split_pgd().
>
>> +	arch_leave_lazy_mmu_mode();
>> +	mutex_unlock(&pgtable_split_lock);
>> +
>> +	return ret;
>> +}
>> +
>>   static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
>>   				phys_addr_t size, pgprot_t prot)
>>   {
>> @@ -639,6 +905,20 @@ static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool, pgd_t *pgdp) {
>>   
>>   #endif /* CONFIG_KFENCE */
>>   
>> +bool linear_map_requires_bbml2;
> Until the next patch, you're only using this variable in this file, so at the
> very least, it should be static for now. But I'm proposing below it should be
> removed entirely.
>
>> +
>> +static inline bool force_pte_mapping(void)
>> +{
>> +	/*
>> +	 * Can't use cpufeature API to determine whether BBM level 2
>> +	 * is supported or not since cpufeature have not been
>> +	 * finalized yet.
>> +	 */
>> +	return (!bbml2_noabort_available() && (rodata_full ||
>> +		arm64_kfence_can_set_direct_map() || is_realm_world())) ||
>> +		debug_pagealloc_enabled();
>> +}
>> +
>>   static void __init map_mem(pgd_t *pgdp)
>>   {
>>   	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
>> @@ -664,7 +944,9 @@ static void __init map_mem(pgd_t *pgdp)
>>   
>>   	early_kfence_pool = arm64_kfence_alloc_pool();
>>   
>> -	if (can_set_direct_map())
>> +	linear_map_requires_bbml2 = !force_pte_mapping() && rodata_full;
> This looks wrong; what about the kfence_can_set_direct_map and is_realm_world
> conditions?
>
> perhaps:
>
> 	linear_map_requires_bbml2 = !force_pte_mapping() && can_set_direct_map()

Thanks for figuring this out.

>
>> +
>> +	if (force_pte_mapping())
>>   		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>>   
>>   	/*
>> @@ -1366,7 +1648,8 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>   
>>   	VM_BUG_ON(!mhp_range_allowed(start, size, true));
>>   
>> -	if (can_set_direct_map())
>> +	if (force_pte_mapping() ||
>> +	    (linear_map_requires_bbml2 && !system_supports_bbml2_noabort()))
> So force_pte_mapping() isn't actually returning what it sounds like it is; it's
> returning whether you would have to force pte mapping based on the current cpu's
> support for bbml2. Perhaps it would be better to implement force_pte_mapping()  as:
>
> static inline bool force_pte_mapping(void)
> {
> 	bool bbml2 = (system_capabilities_finalized() &&
> 			system_supports_bbml2_noabort()) ||
> 			bbml2_noabort_available();
>
> 	return (!bbml2 && (rodata_full || arm64_kfence_can_set_direct_map() ||
> 			   is_realm_world())) ||
> 		debug_pagealloc_enabled();
> }
>
> Then we can just use force_pte_mapping() in both the boot and runtime paths
> without any adjustment based on linear_map_requires_bbml2. So you could drop
> linear_map_requires_bbml2 entirely, until the next patch at least.

Good idea.

>
>>   		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>>   
>>   	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>> index c6a85000fa0e..6566aa9d8abb 100644
>> --- a/arch/arm64/mm/pageattr.c
>> +++ b/arch/arm64/mm/pageattr.c
>> @@ -140,6 +140,10 @@ static int update_range_prot(unsigned long start, unsigned long size,
>>   	data.set_mask = set_mask;
>>   	data.clear_mask = clear_mask;
>>   
>> +	ret = split_kernel_pgtable_mapping(start, start + size);
>> +	if (WARN_ON_ONCE(ret))
> I'm on the fence as to whether this warning is desirable. Would we normally want
> to warn in an OOM situation, or just unwind and carry on?

I don't have strong preference on this. It returns errno anyway. The 
operation, for example, insmod, will fail if split fails.

Thanks,
Yang

>
> Thanks,
> Ryan
>
>
>> +		return ret;
>> +
>>   	arch_enter_lazy_mmu_mode();
>>   
>>   	/*


