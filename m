Return-Path: <linux-kernel+bounces-811281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28097B526F8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DB7C7A2493
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4876226D16;
	Thu, 11 Sep 2025 03:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D8q7oZQ4"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1681722541C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 03:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757560786; cv=fail; b=MV1chVofJzCrfaQ0bwMFwPgfd5K2ivz7iivuKsu6VMS3sc1UpEgahMIJWLh0NknJ3wFnh0GgmVXOL2dR5mZxrujb1EMrRjSiCL9cCrSxTCxm8n+8QjVR0N7JbxGGhjSavj29HYQxV8ir0m3IIw3T/PPmo05uEogVwjLZHsC9kIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757560786; c=relaxed/simple;
	bh=WudZNnXwk1iU98g0E1dY3B/iARyAqJHTuL1AtlPCzEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hBVj94xUa8mySrXmuW0YFA2RiwDB3VnbXk2XK14Bh/8RLbMg53/yi1rEKcrEhxKCYbi0QOOzJgaX8rPzoMzMlvTpGrZKkgDNWngP9A80+wkY3gOmSmbxRFlILY2S9G+P6l/wM9C1bv0bYJo2+dS96/FOVQ3Q2SQG2ti2ZEx2Kck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D8q7oZQ4; arc=fail smtp.client-ip=40.107.237.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wt5Zq6V95rzhWCrM4tMnfEimkwREBQaWdH26xtb9GMG7DbOtfh/DeLAzBMkaGlXhOfRYp8k0phR77jYdco+kmQr+uWz6BNx7s12LNdiyHkz8AmvfYpqwhDXW/NSE41lF//nLmLnaw1TzOK7YyiNgILLl2lJCAO+vC1Gjs2UUTHL+FqSClzt6wIxvF3ihVViZcR/e/vvFHcB3145MjnBgZMKxat/e06VShGHdH3DGflc5o+BW+WCF4RDRfMaLevRCedgBg9OrbmGqyq0PtnozU4XNDP3nJuHRu33qbl3lMTeQNPNuoam08dkcS5ShNFV4RNmPbusIMpHOVeEyD7skFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpHj+MGARfj8blxvVka264X7OkIxIPNR/vshBaT6dHM=;
 b=crqTjQEAuikAGB0v3bkOl3OpFkJE8YLopP20CQZ5SxeI98CK2Xq3S8okL18k1eeh8YdJWP5fyxF0EDM5P0z4jGmY3+OAadMgtasvRxxBJ2qxhMzDj8XPBETYQl340oMpzRRD46OFktK2RLA5QxRa/DhnzN7+L9o/XihSNcKSNDcEg3zFwpJuM26ay60XqM458dUmaqnj83yQpMPDlXhzbGxaqr6j7fwDrs17gu3y4LiBDGW/NYVlFq33Yc2wsDH9d98sDdaRJE1X2gAoBFT6E986EGxgCyX1LChGuix3OLAlxOmF+l62z8+97RYt3ZTgdR1luypYl2Z9T8IcY1OVWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpHj+MGARfj8blxvVka264X7OkIxIPNR/vshBaT6dHM=;
 b=D8q7oZQ4SFUZV7YLNXtmj0Zqk6z7YPNVjqqIhLMwwyfWTRX647MN9avQK08WlV2nPU6pChLp96ZCt0smYh4E9SgbrpkxCMg50CJvVhsJ2of9UIjRNJi+Ny14+I74WgqybydpHTSjfoJPhimUud6LUORBpivxcDO9upxGM/+GvX/RQom6GAEOC21K1uG5bNwTwfImmq+0kju+PD9CyIEwyTyUrqThMTgXwouUR0XD23y6jfluGNET8xjMzCNndSiIWk0D5KhYWM/VTyFU7M6jbcj0YWFFtMY9VQh7Bd+4CP1LLjrJGJHO57WmxSplmcpuXqGHgodH2Kk4P0nKucL61g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Thu, 11 Sep 2025 03:19:42 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 03:19:41 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Zaborowski <balrogg@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH] mm: avoid poison consumption when splitting THP
Date: Wed, 10 Sep 2025 23:19:39 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <9CD4E5BC-185A-47E6-9A2C-1B5416DC57EE@nvidia.com>
In-Reply-To: <20250911021401.734817-1-balrogg+code@gmail.com>
References: <20250911021401.734817-1-balrogg+code@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR14CA0016.namprd14.prod.outlook.com
 (2603:10b6:208:23e::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: 07acde44-b81c-4251-949e-08ddf0e20c61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cC9sSW0zTGZ3YjA4SFhLNTFEZkdUWFJoQ01pYStqZm8wcVBEQ0RJeno4TndU?=
 =?utf-8?B?SVBOLzBIa2xWYVJTS1IxQXhIS3JKNDhtNWZnWTNrejBQVE81ZEtHTHhFRy9y?=
 =?utf-8?B?cEtLRU1Za3RGM1lEVUlTMHFXeVFHVmdHOGpreVJ2cEN2Nk1xR09ZUFZkdE4r?=
 =?utf-8?B?ckJzazcvOEZpZGVlWDk2ZVRHa1dMakcvNW1mRDk1UktGNWJlckVQQ29Eb0Zv?=
 =?utf-8?B?bUpwMEIrSFBLWmQxQVNxN1JYNHgzYUsrczVleFFET01ydEN4UzBBUUJUUnFv?=
 =?utf-8?B?SU9zNWdWRHVvSnhWSHJHQW9lWEtaZFBlK0ttOTh0RGpNeEJrMWFmTTFGc2ll?=
 =?utf-8?B?U05pWE5BZlJpcjlPN1U1a1IvZVh4MVV4VFZiakJkZGZkVy9OY1ZVYkdRMUhi?=
 =?utf-8?B?ek1NbWRGMXArNWxBTkdxWWJQaU1OMGlxYVBSNGtZbGNXVGpvUzBmVWlhQ3VZ?=
 =?utf-8?B?Vm5RV1FUYnJTNFdLMHFybnFDMzRjOG9ScHVleXV1TkV2RUdIS2lhaDl5U0dl?=
 =?utf-8?B?ODFLK0VjMU8wbzZPUlF2WEd5cUk1NnEvb25NdjYvd3VBVC9hZ1ZSalUxNXBq?=
 =?utf-8?B?Q1hZOW5RcExtM3RRZG9GemhhTWtmL2I3QjdjUmNvWktTZjkvc3hZb1BRYTgz?=
 =?utf-8?B?eSt2V0Y3MFJQY3NnQ3o0NVUzL0JNRW1SanplWmFMeWlOSTM4bjBubm9NM01a?=
 =?utf-8?B?WjJtbXEwT0FNS3ZSaFVTTWQ5UzM2NUc1NTYyalBPU25uZkxtZFNoUExvazFY?=
 =?utf-8?B?QTUzOERlNjBBWi9hcTUzUFBlTXF0UGZJS0hrRE5WelVsZmIxTlBnNm45VXdv?=
 =?utf-8?B?OStJLzl5NlJDV24xU1B6Rk1xU1NMeVJ3bnpSY1drOGE0c2d5U0d1V0t3UHB6?=
 =?utf-8?B?UzZ2Umc3YWhiRkJJeStZTjlEUnQxR3JLOVliWVVERFFnZHVPeGJJZG9Ma2k0?=
 =?utf-8?B?Slp1a25Hem04RVNZWlJ0Uno4OHJyZm14N3UxZ1R1aHdSenRuTkVwNjBhRHVr?=
 =?utf-8?B?aEZ5YVFvOERTRW51R1lrM3ZiaUdXd1U1d0g5cGxjY2FIUHBIVEZUSkNlcnpM?=
 =?utf-8?B?Slpwc0FrMnVsQ04yeitOWGFPVzV6eU91MU8vVlNFRk05cmVwYTNZQlcwNllQ?=
 =?utf-8?B?ZE05WGNTMmFUNEdhbk1aV3JXd0JJMThjaktGZmRaa3crNVY0ZUtwcUpWUlZ6?=
 =?utf-8?B?Um54VzNsTXlQMjdmOXJDZFNIaHJOUUdncGZ2akg0Mm5SKzR1bEZ0WWdCeld2?=
 =?utf-8?B?K3ljRWNDam5wUUw0VUI3OXJUR3p5dWZnMUVTM3hFWWdlNUxCT2pON3BtN3NJ?=
 =?utf-8?B?bVZwSWxtVmptaERuOFd5N095RG03UStYVDcxcmpGWXRKc0NsZ2QwWlFMaVlm?=
 =?utf-8?B?Z3Z5RXBlaGVka2NoUE55bzFFNHQzVXZTUHgwZHMwTFk4d2dYb2FmcGtMeCtU?=
 =?utf-8?B?VDRtYUUzNVlMUmZHRTRLUnlVK3c4S1VDUjRDL3Nkck5PU2Q2eFdGcmZSQW1I?=
 =?utf-8?B?dDRsYXAyNlN6YU5sZS9Pb3o3SzNMbEZ3c3UxbjBTak5CRG0yVUo2Q24veGZt?=
 =?utf-8?B?VnZlRnp5TGk2Y1NCU3lFQldpT3dPaWxyaVRKUjZyUkhXTnFheHZzVGJielV2?=
 =?utf-8?B?UXZmMktmZU81cFpPWTdvaXA0OTJuVWFKUkw2SzlDTk1yaEcxMjVjRXZCWGpl?=
 =?utf-8?B?aHU2WFFuVGNjSDA0cWgxbUxCSDhqMnlYOTVoaDFtQUFlUlc3cHlYWFNTVGg1?=
 =?utf-8?B?MzdJbjAyRUJNM1BlbGNmSHVibmVhc0o5T3h1Mk8wNVN1TFdCTHp5Y0xDSGpQ?=
 =?utf-8?B?dFdmYnJPMmZUK3NwRWlQWlJERmhCSVlCaEVpWUtRUks5SE5OZkk4Q0dNZHhY?=
 =?utf-8?B?Y2ExRTVHdEcvVVo0VVpqa05ydm9PdWtsV0RWbzVsQ3pLV0NwUk5nTk5ZbFV4?=
 =?utf-8?Q?xsvQ8iRcmYU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUp5T2EwNTB2MVVEOFNrRjM1Q0ZsOXUvRGFSVG1QY1F3SFJPcDNZRW5GZmlj?=
 =?utf-8?B?QXB0YkJUc0RRRkVvL29RV3JsOTV6ckx6ZklkWVFEMnoyR3JqQTJNQlIzMU5w?=
 =?utf-8?B?ZDNsRjVvYmJwYU83WFBZOGVqclVhbStPNUUxaUVUMCtkUFFDMy9GUTRIczNK?=
 =?utf-8?B?TUNJTEV1QlpXVFJDby8zWWFTOTViZ1lhS1VHcGpLSDY3UWsvTkkwQ2RYOWlz?=
 =?utf-8?B?OHNKc3kxbEhJVFRoTTlSaE5FNXlTY1VYTzFqaEk3SkdoZWlobC9ibkhyV1lJ?=
 =?utf-8?B?L2pLNGtpZTlBdEhyMUdqb21nVnNkZWdBN21vMGhRZks0VEg1Yi9wK01oNzZi?=
 =?utf-8?B?Rlh0QU5saWxSaklCSGxUSGp2dzhURnhWZ1ZsM2NFREk1TDFKTmlIMGFXRU1x?=
 =?utf-8?B?dG9vSStoNCs0aER4YkltZ296eU5xRmErbkhiVUFMNHR1WE5IS1FyZEVvbUtM?=
 =?utf-8?B?cDN3bkl6cWZyTEhESWpvTC9Da0JTT1dYSWRjK2l1a2lOK3FzV3ErZzY4ZkFT?=
 =?utf-8?B?Y3dnVmI3SkRRQWU2N0pvdUs2U1lKU250SXQ0aHpMRWs5UU9ETGJFVXFHcWtN?=
 =?utf-8?B?bFp3eThIUm1kWGk4Nm5HbmNWbE0weVF4SWdWNFduUGUzRGV0WGo0TWlHOUVs?=
 =?utf-8?B?T0NLOC9wenlSMm5VTjkwNEFkTFZuWVloaWdVcFlaeGRqam1lQ0UrbmFJR2ox?=
 =?utf-8?B?VmpQS2lpakJMNTUxRGwyeHZuSHhKS2NNWUZ2L0pVK1lUNCs4U0tMV0RiME1Z?=
 =?utf-8?B?bUxSZDg4TW1iVHUydFdEV2J3cmhsdmlFaHFCaHdyclpWRUZPclArM1RDSlNu?=
 =?utf-8?B?aEZFdGRwZk1uaXlXMWk1NDY1L2Y1a0NUaGNZYkFORzc1dDBlQkR4dFdVRlhG?=
 =?utf-8?B?YWZBUzlibUpEeldGYTNES3pFN0hseWhvQmtrbTRMRVpiWnJSWWMwTGlvQmJK?=
 =?utf-8?B?OU0xSkc5NWVkVVpvNWxsWktDQm1KWTZKMVY3Y2tWRlBsQ2VlUitGKzVBdktB?=
 =?utf-8?B?cE1ydCtYQURqZXZ6MzJ4VFBVbThJRUwvTWdKMm9DU2Z2SjhuaWduUGRLdmFn?=
 =?utf-8?B?a3RlNitFR2hjMU9UMXlPMFJJSUJqRzJUOHgxdXA2RThzZWxNd0sydmdVTEdK?=
 =?utf-8?B?RWtBRWZSZDNUTEk2eEJFSGRJOGJVNXk3aHpWWndvUWhPa3ozSXFsaC91NWFS?=
 =?utf-8?B?dmtkUDgxSndOYUNBOXZHbDBjcHg4WWpCTi9YWDBWZVYwV0Z3VS9ldlM2UERC?=
 =?utf-8?B?Zk43dU1hUmlVNzRXdW9qQWRJYXNRZlFnMlZiVlozdnlsbE5KSU05aHNBRjNl?=
 =?utf-8?B?Y3NZV01KSjVYZG1iVStoUHlxU3BMdlFMbnhBNi9FK3hhWkdrWUh1aUtTbVJP?=
 =?utf-8?B?L1RkZGswQ0lTbUluOGxNdUg2WU1pUEg4WDcrcllWbTZZaHhLVUVzendGOC8y?=
 =?utf-8?B?SE52TG02OHlNcy9XMElpWnpJV01tdEZiTFBpOWRYR0xTY0E5bHZuaXJyUXFH?=
 =?utf-8?B?ZlhaSzZna2RjVGlwNkxOTFpqdytJcWV6Yk5QWUtISFB2Q1RvREIyRndUc0J6?=
 =?utf-8?B?QTVVanhvdEtTcFBnd0x4Z1p2TmRXRVltdjhEUVd2Umk3QmdlWEl2a0xaMzJ6?=
 =?utf-8?B?czR1SGZHWjVOa2ZCK1Z5bnlKK3lyOERsS29kcjFaYmdvMU1zNFJybjlvVG5Q?=
 =?utf-8?B?d3VrYVlyem9NcC96K2k1OVN1Y1VwQzJJcVJtdk5vZHpMZGhRTlBEUEFUVjF4?=
 =?utf-8?B?UVR3VnVKSFhsMnNOamlwNHBkSW4ydmVQS05DSXFJQnVlVHhIS0hEdURDWlZt?=
 =?utf-8?B?c3hCcE9TTEdlWnlSMThUN0xLdXRlSitSWGtXM0dBQUR1d1gvSXVPZjZNRXVt?=
 =?utf-8?B?MTZ3SGhMMFhyYXBUTXZaU3krYVRHMk4xZjFpUUQvcU1tNjNucnpQSmRDR2xO?=
 =?utf-8?B?U09QcEtsVzNKREY3TkJaYXdUYVhDNjhMSVlJaG05aEcxSlc3cCtXOFF5ODlU?=
 =?utf-8?B?NjFCcFhvdFJrR01TV21iZWxyS2hDWnFNdFBQVzJYdXF5TFprQTc1TkpOK3pr?=
 =?utf-8?B?azJ5YXZKSHhFN2xEYjNVbkt1d3dWa3BjSDcySFBkYVl1U05oc2xEbXBTeXQv?=
 =?utf-8?Q?7uT5Joc31MlIMAQ5iL4p3G+6k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07acde44-b81c-4251-949e-08ddf0e20c61
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 03:19:41.9012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYnDe6rpNueeXYIK7wA+cJm4Abg7dfXoJnl9Jfj/FV2rJWRuSKD1mHm7b3rSUR3i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208

On 10 Sep 2025, at 22:14, Andrew Zaborowski wrote:

> Handling a memory failure pointing inside a huge page requires splitting
> the page.  The splitting logic uses a mechanism, implemented in
> migrate.c:try_to_map_unused_to_zeropage(), that inspects contents of
> individual pages to find zero-filled pages.  The read access to the
> contents may cause a new, synchronous exception like an x86 Machine
> Check, delivered before the initial memory_failure() finishes, ending
> in a crash.
>
> Luckily memory_failure() already sets the has_hwpoisoned flag on the
> folio right before try_to_split_thp_page().  Don't enable the shared
> zeropage mechanism (RMP_USE_SHARED_ZEROPAGE flag) down in
> __split_unmapped_folio() when the original folio has has_hwpoisoned.
>
> Note: we're disabling a potentially useful feature, some of the
> individual pages that aren't poisoned might be zero-filled.  One
> argument for not trying to add a mechanism to maybe re-scan them later,
> apart from code cost, is that the owning process is likely being
> killed and the memory released.

Sounds reasonable to me.

>
> Signed-off-by: Andrew Zaborowski <balrogg+code@gmail.com>
> ---
>  mm/huge_memory.c    | 3 ++-
>  mm/memory-failure.c | 6 ++++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9c38a95e9f0..1568f0308b9 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3588,6 +3588,7 @@ static int __folio_split(struct folio *folio, unsig=
ned int new_order,
>  		struct list_head *list, bool uniform_split)
>  {
>  	struct deferred_split *ds_queue =3D get_deferred_split_queue(folio);
> +	bool has_hwpoisoned =3D folio_test_has_hwpoisoned(folio);

The state needs to be stored here because __split_unmapped_folio()
clears the flag. Maybe add a comment here to prevent people
from =E2=80=9Coptimizing=E2=80=9D it by calling folio_test_has_hwpoisoned(f=
olio)
in the code below.

(I wanted to until I checked the definition of folio_test_has_hwpoisoned())

>  	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
>  	struct folio *end_folio =3D folio_next(folio);
>  	bool is_anon =3D folio_test_anon(folio);
> @@ -3858,7 +3859,7 @@ static int __folio_split(struct folio *folio, unsig=
ned int new_order,
>  	if (nr_shmem_dropped)
>  		shmem_uncharge(mapping->host, nr_shmem_dropped);
>
> -	if (!ret && is_anon)
> +	if (!ret && is_anon && !has_hwpoisoned)
>  		remap_flags =3D RMP_USE_SHARED_ZEROPAGE;
>  	remap_page(folio, 1 << order, remap_flags);
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index fc30ca4804b..2d755493de9 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2352,8 +2352,10 @@ int memory_failure(unsigned long pfn, int flags)
>  		 * otherwise it may race with THP split.
>  		 * And the flag can't be set in get_hwpoison_page() since
>  		 * it is called by soft offline too and it is just called
> -		 * for !MF_COUNT_INCREASED.  So here seems to be the best
> -		 * place.
> +		 * for !MF_COUNT_INCREASED.
> +		 * It also tells __split_unmapped_folio() to not bother

s/__split_unmapped_folio/__folio_split/, since remap_page() is
called in __folio_split().

> +		 * using the shared zeropage -- the all-zeros check would
> +		 * consume the poison.  So here seems to be the best place.
>  		 *
>  		 * Don't need care about the above error handling paths for
>  		 * get_hwpoison_page() since they handle either free page
> --=20
> 2.45.2

Otherwise, Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

