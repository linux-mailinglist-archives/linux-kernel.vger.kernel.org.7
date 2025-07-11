Return-Path: <linux-kernel+bounces-727961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A88AFB021D3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9554A1C80BD7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD412EF29A;
	Fri, 11 Jul 2025 16:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ej+aY5d8"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227AE2EF9A0
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251424; cv=fail; b=DrVWoB3pH7T9iPlokO9afuIEPcAnqoujGH6hxafsAIMb8lVY/K/GDk7RktkrRIr/HVJBx0nblyaW9DI4R2Aevazsn9O8z67oo4BvhEyldjwrxOmLSb/fwBVrlv77LMPqukrmfa1FaKnU4x5trr6hbOX+T5oheSQcmGxXoKlO4jA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251424; c=relaxed/simple;
	bh=IzZgHA3LNcwdUq0bjc0fAZQGTu+Ew3iKNyF6670B3Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l4VcsxDRrU3kQdqsuu8U9CUG/toxySOADIZO5bQHOAff+0Rg8kFZ6nbTHLXTsZ5N8fjKPn+V9rgULAEqq2pzETN+qFEwzJ2aXHUJx7TKC9pC0KrXMsTJN5XBBEWwK9p8hb6Rd5zXELDpuEepe9mwfgaBbLw9JwEJz/CVgIbCaHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ej+aY5d8; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTi/Va0cBYbSXbBJCaZTtmCbtIRpELUQKoOKpxDvo71hD7u6+CkQI37jpX8KH0/jpc0p2elaLWmTs9fHwzfRKO8xHjm4VVNusOk0QAGWXgKg04XQQC27K439WD0CHtYc9bvjOL5nuG3yOQO2x3xNlEHMXXykkYKvqYn4mS9vYsSeE4ZvxbhN7Few8c7ClfHKenAZdS3NUrD44WNMFA1EoyKHy1z8p/34r0YefCf5FRqwYECJbtTM8VwO2b3dGKAxdcso4Og7QI/Axa7KWJM919nybLBmu3YD7y2J3mKS8fo4xzCfmGFGQSHVPUqcybzj59MelTIXTNIfPKvoJFGX4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKjBO0NfTmUIIbxwOopigLn7uSVy05SvKwAjLvuWWyQ=;
 b=IkXOVzBIZjJjt9praR8PKwu2yfOh3PRdpPlMV9nWUVQImgnkHajJk3h5ynoKGtw70PMnyZPibn6WhYDK9BSW0DGE2gfPjDcholoUSCr2Sj7P6/Rz7S7uiOA3joOJ4AODCrfBv/lFMGx/u5tZkZrRuXYj5JHwrx4V3P0ClltwzkQfOIWX+zGOgZJggjdzI5GMUqBONBlFViiZGth7+YQD36vK9+d+8F5doTj7A5bXGiawJGnZGE9HjL//2QRMobkd1epocnliT6xjBKgyYhXAfMVhNjh4BkOVjOfeZJf+XCLxyhw1HkHQrZw7jKOwe/aLYRm611GXCNKfZj5xOO/UMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKjBO0NfTmUIIbxwOopigLn7uSVy05SvKwAjLvuWWyQ=;
 b=ej+aY5d8dU14OAVAhP+QKWO2nPjoZ/o6GiMWcGGuFJTbmFOSkpzZDz0WPIF3nvW6s5mBVYLLVcaMk7B8+Ftg74YxXknQ77D75hHTiGTUtY4Z1cA8zHZ878MMLENc1OHxugjvE3mpoR+a5f2OmdmSIROycyRAjyl82pIUhzGIZrQ9h483hh3OaMKyL6quiYfu8qcdcB6CkJUzclYOvRlMpO42cOt9W1SBd6HlVNGek0N4VUmk+AefAwhHwX83LxaHeXQBGsxV8Gj5k8nHon25aTPy2alev+pnCSK9V4DKjb1OCE54I/4mciUrETgQjt7WmQbO9qQdzbJbantifVvXRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB5595.namprd12.prod.outlook.com (2603:10b6:510:135::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 16:30:18 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 16:30:18 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: move unrelated code out of
 __split_unmapped_folio()
Date: Fri, 11 Jul 2025 12:30:15 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <17F79BF1-AAAD-42F6-BAF4-6C22A580DCCC@nvidia.com>
In-Reply-To: <0ae2ef3c-b81d-4335-9174-041b5a9c9b14@redhat.com>
References: <20250711030259.3574392-1-ziy@nvidia.com>
 <c7e82a13-aa93-4eb3-8679-29cd32692bd0@redhat.com>
 <2AE055C4-BFFE-4B61-A96A-6DE227422C7B@nvidia.com>
 <3223bd3b-38cc-45d1-8080-d62117df0e85@redhat.com>
 <B9C05B4D-2777-45DC-A229-B4E119B0E9A3@nvidia.com>
 <b38591bb-5827-4e99-97d9-03f74f231c05@redhat.com>
 <0189444A-451E-4DE6-89EF-EB472265F3AA@nvidia.com>
 <0ae2ef3c-b81d-4335-9174-041b5a9c9b14@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR07CA0025.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::35) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: c40a00aa-e55c-425a-6ad6-08ddc0983952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWVUQVppL2JMWlhJYVM4dTZoL2JBSEkyTDRnVXd2YlFMMjZkRDdrU0ZwdTZD?=
 =?utf-8?B?UTVXK2RqVmJVWmErUVJvR0Q0VDdXTG9kaEJMcjd4cGJ4MlFJdFk0eXpiUk9O?=
 =?utf-8?B?YXQyZjlQUWlSdnhKR2FhKzFSTDhuY3lyVzYyRE44UG5mL3ljZ1pBTHY3aTk1?=
 =?utf-8?B?czdvcmdQSFpuY285YUdoOXAxdmRpU1I0YUdOVnY4NmduVHZrSUFPLzIwS0tV?=
 =?utf-8?B?QXpXdXVhT2lGalNacFJqVkpQM1FtVklsM3ptR1d4aGRQb3lPVkx3WHFNN0dp?=
 =?utf-8?B?VkZLZ1BwSThHMTE4Rk9kMjY4SXEwODBxa1lvZTY2dWJGYzZoVDJvUmU4d1cw?=
 =?utf-8?B?UVQrMjBweURFRERnYXJsSWtWYS95NzNZRGZ1T3ZmckI2d0VLUlROYm1icm01?=
 =?utf-8?B?ZTlNSm9XUW0xOFM3a0RFemNZcGlqNkUwT3BBbUlLOUdDZHVTWE9jNGpncU5F?=
 =?utf-8?B?V3JEZUoyM3l3QTA5ekkwMjloVjVYcFp2RU5ZWmR0ZzhJWkVxQ0RUMjY4Y1d6?=
 =?utf-8?B?V0lVWU00d3pHbTJLNkswNFN2SDVQa2RwaXhpdXh3YTVxM1ozaGhNYW9oTUZN?=
 =?utf-8?B?My9oZnZyLzZ0WFVrdWltWVh3VENiOTRFYnZuR0hmRDk3YXdUVEdvcDkrRHRN?=
 =?utf-8?B?ekRhVCsyQWltYWk3VTU0U0pRY0xuNnBEU2xNeVhvTk9tdTBYUGsxakpIQk5l?=
 =?utf-8?B?aGVJWis0MzM4QUxOMjF6UkZJeFVKRTRTMWJldEU4OWcrQWE2ZlN2VVQ3MWtZ?=
 =?utf-8?B?Zk9MZERpNTc4ZDJReDM3Uit0Znd6c1Nzb3hmbTJMUC8wYm1sdkpQc1ZlT0FR?=
 =?utf-8?B?ZHUzTDVmNXVJRnpFVW51bzBDR083R1QweUltV1lXM0JrbzFINTViYnpJUUN4?=
 =?utf-8?B?emFCeWd4YW53OW9HYmlQa2tHVTVVLzVVZzROQjJxWXZYdmlNeTFUT0dNR25K?=
 =?utf-8?B?ZG1MOHdaUU1ZOUc4Q0VzZnA0VzF6UGFzWUNZaDN6T2RuZnlzZXJ0bmZaU0pn?=
 =?utf-8?B?c3JrOER3QytVeUVta1lJNDBiL281ZzRVSStST1RhRGpLb1dGdGhjb3FPNDlQ?=
 =?utf-8?B?Vk43b3JjQWZDS2tnd3UwTkZoYWUrSDlzOE15TndTc2ljKzF6NTUyd0IxcGY4?=
 =?utf-8?B?eUhoT01lM24zaTJrblZ6aTM4MWJ3Z2YwVGJMRDZDV09WbG9rREdDbFNCWWtV?=
 =?utf-8?B?d3dhWlB2QndUWmprY1pNNTA0ZGJBd0tPb0NMY1FmSUhzZ3BkZlVEakpDaW5S?=
 =?utf-8?B?aUxKUjBrWGZIY1oyZEluRk9iQjJ6TGJxQWhCWllDTEdybDJvMmFWdXhiT2dI?=
 =?utf-8?B?RXRncTlBSElJeEQxc1lYQ3p1UnlHdEhSZlphZEQxN2tqK0I1cFlYaXBiQzhC?=
 =?utf-8?B?WFVNaTBwY3BKRlNpTFV6UnRQWkNVaEVMUkFaRzNIZytJMmIxTG5iRURlcDVS?=
 =?utf-8?B?dGRMSlV2bUtGM3lFT3MzQkZld2RrUTZwMmJsZ29hOHpYR1pvSTBUYWdBUnNE?=
 =?utf-8?B?UHFiWTk0dW9mUUNvMktmZUVaRm5MMytjVTdSRS9xT3hNMkVZUkh1bGdnSFR6?=
 =?utf-8?B?L00zODFTOE9YYlJnRVpMdW9aRi93YUZhcnFva0k5SmRyOFVWeXRWYmM0d3dk?=
 =?utf-8?B?MXFPSTBNaVlKTlpXd1dRSVRma1dxd3ZKaGVpajE2U0dRYmFsVE8ySFpYeVQx?=
 =?utf-8?B?UllJUEpSMldzRmhMdXhyZTNlOVVwcFUvQVNqN2tSdGF6elFSOXZOckZBTCt6?=
 =?utf-8?B?eDBQMjN6R0xrRWtsOEpKUDlrdStxQ3hOdCswc0k4ZHY2SlhlVFp1cFF0cytr?=
 =?utf-8?B?MHYxbDg0SitTL094NmNFNEx0NUJsOGxxV0swWlpXaEtSTXptMVU4eUttM21R?=
 =?utf-8?B?cERSTmhQQVdDOEx5Vmk4Z3lNc09jckJOR2xMZEJhemNiN2NGOFNCbWl0V0ds?=
 =?utf-8?Q?6YVvzfQIZ6Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzhCVTNHcXhlQ1JYcmJ6ZVgyS0JaaE5oVXpoUXJJbXJzZ21nK2kvOVNXY3o4?=
 =?utf-8?B?Z0hJMldHUnExcEJzUlgvQjNTYmhIcHo0MVh3WnFOa0Q2ZzdPQ3Z2cDRhSktn?=
 =?utf-8?B?TGxZbXpqb05VM0lUWFhWemtsUXk2aHZxRkhWanhlL2U3MW9PRVorYzFKZXcx?=
 =?utf-8?B?VDNsWFRnVWltQlM4Ymd5Y3p2Zk1ySXNQNDRQK0h5TTUxV2xoOTNZU3ZBdmJN?=
 =?utf-8?B?U3BBY01pTlM0QW5vekpOY21NcXlUVFlPM1RtdmRJbEp6Y1FHMWhlMkNaay9v?=
 =?utf-8?B?NVg3azZMcDE2OE1FeGxITE9qU1k5MnIvaHBjbHBtSjF4aG9iTElGTFFjSzdq?=
 =?utf-8?B?ZVVNTjVwZHVWck5CdUlUUGRrTFp1V1laZmpCcXFXeUFMc2ZiSnlmdEVPWHJS?=
 =?utf-8?B?UjQ5SmJrL1p2dTdwU1pIR2pLNlNMVm5FL0tnV2M2UGhxVHZWa2JIRkdQdDNL?=
 =?utf-8?B?bWlOb250WExLd0hoNTd5Z0RTcmpHVTl1S3VzaGorZ1lic3JvakI2NE1xWnhF?=
 =?utf-8?B?ZHhNOElYK2JvWjlWSnZHZi9tZm9KOWJ6U0xQT0VhajVzVmdkTjFobjd3WWV2?=
 =?utf-8?B?Z3RPY240N0tZbDZBWnNQeTBZVlpoZEdtMnE2WEV5R2pXdWowUis3NHJHK3oz?=
 =?utf-8?B?MWpaMU90Qm9lTmtWRkVVUTFMZkd2ZHFOTWxPamtyQ2VhYnBBZHlzbzVtNGRx?=
 =?utf-8?B?ZnJZWHN1Nzl3MG5UWW1ma2diRHg5WVlGQ2tFeS9nRU42T3FEaGdTTjRFUU5i?=
 =?utf-8?B?MUt4bTVna2FRTUtnSDd0MVRERk9EaWppYTZQRmtuSTR5alI5S3BlRW9XVWta?=
 =?utf-8?B?c3Fnd3UyZHlkVU9rZTFTSkhsVWhvMXFubDFyY1pFczdxUFp0a0ZPb3pMQjhV?=
 =?utf-8?B?MXFiRGYrQ2RaTkM1ZTU3K0tyT25JRnI0YmZNL0g2aFRKNllodndmR0dRWkxP?=
 =?utf-8?B?R3diMzdpWFpqZ3VpVHlWc0l3cU50bVF4WWpBcUwybnczZVhKTDRNcWZQS3pY?=
 =?utf-8?B?T3hBYk4rWWdBVk5FMEpyazZZUDNtUWkrWFNWNm1hZkFBTGI1TDVHVXV0RG5m?=
 =?utf-8?B?WDRObVpIMnRQSmFTaE9hSGhYNXcwdlNDd1RLdHJzR3lUdjdXdU1sc21Xdkx2?=
 =?utf-8?B?ZFMwcE9LY3NiSTNWVjhxckFIczIrbE9idkIydS9idHJiZEVFa1JKaWhtSEFG?=
 =?utf-8?B?UTZlWGNuOVFXbzZsVDgrZ3BBbGlJbjBCUStpU0ZWWDV6UlFPTUVXOU9saGJZ?=
 =?utf-8?B?YUU2ai9BMFdMaTQ3M1g0czlZdlZ0RWozaHIzWGsrWFlHM2pvSG9yT1B4cll4?=
 =?utf-8?B?N2ZaNmxtLzNqR25JWkRHVG5lR01NY0FnTzhRR1p6TkpwS2VYa0VEWkZ4Y1hu?=
 =?utf-8?B?aWFFbnhGU3RvbUxXekpOTVJ1OHBmaVJva1BXMVlQS2IzLzJpTlRwNnB5dHdj?=
 =?utf-8?B?S1ZJQ1ErK1lLMkdDZ1pxMFhpTkZPN3BTZGU0amZielF3Qks4cEhIOGsrcXRN?=
 =?utf-8?B?d215STVxcFBzcDJYSitKaDRKTGxlZWxpTmIwVlJNWVVOd3VCWTJTZU9Senp5?=
 =?utf-8?B?TVNUVWQyRHJEU29URU9YdnRjVDFxeWJvZ0pPcUxQZUdHUjNUTmFLQXpBVlZi?=
 =?utf-8?B?dUw5Q2haVFczZXRrNzJCSlp1MURKZjN1bTZ4MWkwSVlPTWcyajNwMDY2ZGc2?=
 =?utf-8?B?UlVEOER3NCt5bytaZW1QcGdueEt1eDFpZTBWQ1BqSkY1NFBQc1YyeGR0TWZS?=
 =?utf-8?B?bE5pYkcvQkQ3R2tva3g5RVF4U25lVzFQa2l3OHJxWSs2Yjd3L3hWZ005T1Fv?=
 =?utf-8?B?S3RpYnZUQnRpWGYxWHpvOUdlZWJjVmtRU0tBSzZMSitsTnpCUjhFQWU3UGd4?=
 =?utf-8?B?bnFzYi92bmRRR3FhNTJnSWt4UnB6dGlMV0J3QVI4N1ZLZk8vb0QvWTBnWnV4?=
 =?utf-8?B?ZndQd0krY0ZRRUdDWStTWDZrbmZrZkx3dmlDUWJMcTE4Wk9JME9DVk1BQ2ZW?=
 =?utf-8?B?SkdVN1Brc2NVdHBYL1dCb0wzVm80Q1VYZVBIODJrM25oMFIrdTFGZGtzd2Fr?=
 =?utf-8?B?TXhsUGxQN0lncmk0bVEvSlNwbTJNYUpuS3laeXh0bXRmeDFwTGhqZStyQTNE?=
 =?utf-8?Q?ui0VfJnRVjQy2F2EAsTLLCzen?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c40a00aa-e55c-425a-6ad6-08ddc0983952
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 16:30:18.6802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9R20f+D22gzAy2lQKDZCvuJf9CDdH4tiJAkP7FAXBbgtlMgXKAH00cgwAg74wAU5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5595

On 11 Jul 2025, at 12:28, David Hildenbrand wrote:

> On 11.07.25 18:26, Zi Yan wrote:
>> On 11 Jul 2025, at 12:03, David Hildenbrand wrote:
>>
>>> On 11.07.25 17:40, Zi Yan wrote:
>>>> On 11 Jul 2025, at 10:40, David Hildenbrand wrote:
>>>>
>>>>> On 11.07.25 16:37, Zi Yan wrote:
>>>>>> On 11 Jul 2025, at 2:41, David Hildenbrand wrote:
>>>>>>
>>>>>>> On 11.07.25 05:02, Zi Yan wrote:
>>>>>>>> remap(), folio_ref_unfreeze(), lru_add_split_folio() are not relat=
ed to
>>>>>>>> splitting unmapped folio operations. Move them out to the caller, =
so that
>>>>>>>> __split_unmapped_folio() only splits unmapped folios. This makes
>>>>>>>> __split_unmapped_folio() reusable.
>>>>>>>>
>>>>>>>> Convert VM_BUG_ON(mapping) to use VM_WARN_ON_ONCE_FOLIO().
>>>>>>>>
>>>>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>>>>> ---
>>>>>>>> Based on the prior discussion[1], this patch makes
>>>>>>>> __split_unmapped_folio() reusable for splitting unmapped folios wi=
thout
>>>>>>>> adding a new boolean unmapped parameter to guard mapping related c=
ode.
>>>>>>>>
>>>>>>>> Another potential benefit is that __split_unmapped_folio() could b=
e
>>>>>>>> called on after-split folios by __folio_split() to perform new spl=
it
>>>>>>>> methods. For example, at deferred split time, unmapped subpages ca=
n
>>>>>>>> scatter arbitrarily within a large folio, neither uniform nor non-=
uniform
>>>>>>>> split can maximize after-split folio orders for mapped subpages.
>>>>>>>> Hopefully, performing __split_unmapped_folio() multiple times can
>>>>>>>> achieve the optimal split result.
>>>>>>>>
>>>>>>>> It passed mm selftests.
>>>>>>>>
>>>>>>>> [1] https://lore.kernel.org/linux-mm/94D8C1A4-780C-4BEC-A336-7D361=
3B54845@nvidia.com/
>>>>>>>> ---
>>>>>>>>
>>>>>>>>      mm/huge_memory.c | 275 ++++++++++++++++++++++++--------------=
---------
>>>>>>>>      1 file changed, 139 insertions(+), 136 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>>>>> index 3eb1c34be601..d97145dfa6c8 100644
>>>>>>>> --- a/mm/huge_memory.c
>>>>>>>> +++ b/mm/huge_memory.c
>>>>>>>> @@ -3396,10 +3396,6 @@ static void __split_folio_to_order(struct f=
olio *folio, int old_order,
>>>>>>>>       *             order - 1 to new_order).
>>>>>>>>       * @split_at: in buddy allocator like split, the folio contai=
ning @split_at
>>>>>>>>       *            will be split until its order becomes @new_orde=
r.
>>>>>>>> - * @lock_at: the folio containing @lock_at is left locked for cal=
ler.
>>>>>>>> - * @list: the after split folios will be added to @list if it is =
not NULL,
>>>>>>>> - *        otherwise to LRU lists.
>>>>>>>> - * @end: the end of the file @folio maps to. -1 if @folio is anon=
ymous memory.
>>>>>>>>       * @xas: xa_state pointing to folio->mapping->i_pages and loc=
ked by caller
>>>>>>>>       * @mapping: @folio->mapping
>>>>>>>>       * @uniform_split: if the split is uniform or not (buddy allo=
cator like split)
>>>>>>>> @@ -3425,51 +3421,27 @@ static void __split_folio_to_order(struct =
folio *folio, int old_order,
>>>>>>>>       *    @page, which is split in next for loop.
>>>>>>>>       *
>>>>>>>>       * After splitting, the caller's folio reference will be tran=
sferred to the
>>>>>>>> - * folio containing @page. The other folios may be freed if they =
are not mapped.
>>>>>>>> - *
>>>>>>>> - * In terms of locking, after splitting,
>>>>>>>> - * 1. uniform split leaves @page (or the folio contains it) locke=
d;
>>>>>>>> - * 2. buddy allocator like (non-uniform) split leaves @folio lock=
ed.
>>>>>>>> - *
>>>>>>>> + * folio containing @page. The caller needs to unlock and/or free=
 after-split
>>>>>>>> + * folios if necessary.
>>>>>>>>       *
>>>>>>>>       * For !uniform_split, when -ENOMEM is returned, the original=
 folio might be
>>>>>>>>       * split. The caller needs to check the input folio.
>>>>>>>>       */
>>>>>>>>      static int __split_unmapped_folio(struct folio *folio, int ne=
w_order,
>>>>>>>> -		struct page *split_at, struct page *lock_at,
>>>>>>>> -		struct list_head *list, pgoff_t end,
>>>>>>>> -		struct xa_state *xas, struct address_space *mapping,
>>>>>>>> -		bool uniform_split)
>>>>>>>> +				  struct page *split_at, struct xa_state *xas,
>>>>>>>> +				  struct address_space *mapping,
>>>>>>>> +				  bool uniform_split)
>>>>>>>
>>>>>>> Use two-tabs indent please (like we already do, I assume).
>>>>>>
>>>>>> OK. I was using clang-format. It gave me this indentation.
>>>>>>>
>>>>>>> [...]
>>>>>>>
>>>>>>>> @@ -3706,11 +3599,14 @@ static int __folio_split(struct folio *fol=
io, unsigned int new_order,
>>>>>>>>      {
>>>>>>>>      	struct deferred_split *ds_queue =3D get_deferred_split_queue=
(folio);
>>>>>>>>      	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
>>>>>>>> +	struct folio *next_folio =3D folio_next(folio);
>>>>>>>>      	bool is_anon =3D folio_test_anon(folio);
>>>>>>>>      	struct address_space *mapping =3D NULL;
>>>>>>>>      	struct anon_vma *anon_vma =3D NULL;
>>>>>>>>      	int order =3D folio_order(folio);
>>>>>>>> +	struct folio *new_folio, *next;
>>>>>>>>      	int extra_pins, ret;
>>>>>>>> +	int nr_shmem_dropped =3D 0;
>>>>>>>>      	pgoff_t end;
>>>>>>>>      	bool is_hzp;
>>>>>>>>     @@ -3833,13 +3729,18 @@ static int __folio_split(struct folio =
*folio, unsigned int new_order,
>>>>>>>>      		 */
>>>>>>>>      		xas_lock(&xas);
>>>>>>>>      		xas_reset(&xas);
>>>>>>>> -		if (xas_load(&xas) !=3D folio)
>>>>>>>> +		if (xas_load(&xas) !=3D folio) {
>>>>>>>> +			ret =3D -EAGAIN;
>>>>>>>>      			goto fail;
>>>>>>>> +		}
>>>>>>>>      	}
>>>>>>>>       	/* Prevent deferred_split_scan() touching ->_refcount */
>>>>>>>>      	spin_lock(&ds_queue->split_queue_lock);
>>>>>>>>      	if (folio_ref_freeze(folio, 1 + extra_pins)) {
>>>>>>>> +		struct address_space *swap_cache =3D NULL;
>>>>>>>> +		struct lruvec *lruvec;
>>>>>>>> +
>>>>>>>>      		if (folio_order(folio) > 1 &&
>>>>>>>>      		    !list_empty(&folio->_deferred_list)) {
>>>>>>>>      			ds_queue->split_queue_len--;
>>>>>>>> @@ -3873,18 +3774,120 @@ static int __folio_split(struct folio *fo=
lio, unsigned int new_order,
>>>>>>>>      			}
>>>>>>>>      		}
>>>>>>>>     -		ret =3D __split_unmapped_folio(folio, new_order,
>>>>>>>> -				split_at, lock_at, list, end, &xas, mapping,
>>>>>>>> -				uniform_split);
>>>>>>>> +		if (folio_test_swapcache(folio)) {
>>>>>>>> +			if (mapping) {
>>>>>>>> +				VM_WARN_ON_ONCE_FOLIO(mapping, folio);
>>>>>>>> +				ret =3D -EINVAL;
>>>>>>>> +				goto fail;
>>>>>>>> +			}
>>>>>>>> +
>>>>>>>> +			/*
>>>>>>>> +			 * a swapcache folio can only be uniformly split to
>>>>>>>> +			 * order-0
>>>>>>>> +			 */
>>>>>>>> +			if (!uniform_split || new_order !=3D 0) {
>>>>>>>> +				ret =3D -EINVAL;
>>>>>>>> +				goto fail;
>>>>>>>> +			}
>>>>>>>> +
>>>>>>>> +			swap_cache =3D swap_address_space(folio->swap);
>>>>>>>> +			xa_lock(&swap_cache->i_pages);
>>>>>>>> +		}
>>>>>>>> +
>>>>>>>> +		/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
>>>>>>>> +		lruvec =3D folio_lruvec_lock(folio);
>>>>>>>> +
>>>>>>>> +		ret =3D __split_unmapped_folio(folio, new_order, split_at, &xas=
,
>>>>>>>> +					     mapping, uniform_split);
>>>>>>>> +
>>>>>>>> +		/*
>>>>>>>> +		 * Unfreeze after-split folios and put them back to the right
>>>>>>>> +		 * list. @folio should be kept frozon until page cache entries
>>>>>>>> +		 * are updated with all the other after-split folios to prevent
>>>>>>>> +		 * others seeing stale page cache entries.
>>>>>>>> +		 */
>>>>>>>> +		for (new_folio =3D folio_next(folio); new_folio !=3D next_folio=
;
>>>>>>>> +		     new_folio =3D next) {
>>>>>>>> +			next =3D folio_next(new_folio);
>>>>>>>> +
>>>>>>>> +			folio_ref_unfreeze(
>>>>>>>> +				new_folio,
>>>>>>>> +				1 + ((mapping || swap_cache) ?
>>>>>>>> +					     folio_nr_pages(new_folio) :
>>>>>>>> +					     0));
>>>>>>>
>>>>>>> While we are at it, is a way to make this look less than an artisti=
c masterpiece? :)
>>>>>>>
>>>>>>> expected_refs =3D ...
>>>>>>> folio_ref_unfreeze(new_folio, expected_refs).
>>>>>>>
>>>>>>>
>>>>>>> Can we already make use of folio_expected_ref_count() at that point=
? Mapcount should be 0 and the folio should be properly setup (e.g., anon, =
swapcache) IIRC.
>>>>>>>
>>>>>>> So maybe
>>>>>>>
>>>>>>> expected_refs =3D folio_expected_ref_count(new_folio) + 1;
>>>>>>> folio_ref_unfreeze(new_folio, expected_refs).
>>>>>>>
>>>>>>> Would do?
>>>>>>
>>>>>> I think so. Even further, I think we probably can get rid of can_spl=
it_folio()=E2=80=99s
>>>>>> pextra_pins and use folio_expected_ref_count() too.
>>>>>
>>>>> That will only do the right think if we know that the folio is not ma=
pped and that there is no way it can get mapped concurrently.
>>>>>
>>>>> Otherwise, when freezing, we might ignore a mapping (where we should =
fail freezing).
>>>>
>>>> You mean between unmap_folio() and folio_ref_freeze(), a concurrent ma=
pping
>>>> happens? So that what folio_expected_ref_count() returns has
>>>> folio_mapcount() !=3D 0. You are right. Thanks.
>>>
>>> Right, but maybe locking prevents that.
>>>
>>> E.g., a locked anon folio cannot get migrated or swapped in. So the map=
count cannot increase once locked. If already mapped, fork() could duplicat=
e mappings, but in that case there would be at least one mapping already.
>>>
>>> For the pagecache, I think we always map a folio with the folio lock he=
ld: see filemap_map_pages().
>>>
>>> So *maybe* just checking folio_mapped() before trying to freeze could b=
e good enough, arguing that the mapcount cannot go from 0 -> !0 while the f=
olio is locked.
>>
>> Yes, but this is very subtle and fragile. I will keep the code unchanged=
 for
>> now. :)
>
> Please clean up that multi-line madness, though ;)

For sure. Will send V2 later.

Best Regards,
Yan, Zi

