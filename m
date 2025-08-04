Return-Path: <linux-kernel+bounces-755682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 480F3B1AA55
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 23:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67430165B79
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 21:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B793227BB9;
	Mon,  4 Aug 2025 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b9I9qFjG"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E2F19755B;
	Mon,  4 Aug 2025 21:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754342452; cv=fail; b=NQqx0OaBw8QEJtEQi7eNFxMRqsjJWxRhVefQvLXc9y+zgnyEwD4T/peNV21AFZQQfTyZWd3Lva5O6/FdY0M7ihIGaw5uZ4+Bj4uKrQGI+677Eea2UhO3ixKwl74eja1Ez6y9gc8uh4SnHGuGOGyNa2Huy3uqWbU2kRFSpufhpgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754342452; c=relaxed/simple;
	bh=il47A+WeR8oHsKeHujwUOQeYTistNyUgf4vOwfL+Q2M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tVh84w3SWL3s7Jsf+T81svKdAICpNkwhPG6KGvFrBwAYABys8QVKyqOi3ZT7ydKaU7hJN/knzDk+K2jCVh3ZRFQj87vo+mzJB3uPy5bstAnHGIQwnxHfv4wPvaHKPRTvxTQr1KGdEx31T4lBqrGWNSTV0o3qWksUHhPGDzFBUeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b9I9qFjG; arc=fail smtp.client-ip=40.107.244.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zl93bHj57ilMX6u72Q2Bg1POVkG1BJUK5jOUAVikOjXDa9JXEbaosRzNJHTBZUpAlNzhezEXc62ISpa8/0R0O7prI8jIcMlQDxF1LGwfjI2hGzhBzZ+isHIfHsOiuSgOdp7AdvyNO2lnSsAyZMgVyUXtndSRIFsJg5G9fmYZXPTc/bDn5MtYGSEHXqW7Mp41hWmFbl4hpmtzoUlFdjh0PGNUib7Fs3K3Avolxu9XBMMN/TSvwk7oe12MHAdsjNsX7WZ7pwwY9sCQ6gnP7+rwwgEVc6cio7PxHNtd/2S5czRjJmeIvbOdzZ233EvFC0z3sqbsjBvXlpv0nFyQ+hd52g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsrGXOWvWWnxv2jFov5/2fG0b+mdaPigKVYBnpWvwG4=;
 b=u7O0HT/Pcg0iZ01+QWOodMNbTFDSmB5FKdy4KYdoO6Ox3nLGfatAgTvUCd3NhPHIM4dyRFgjJ6l8z3HlEcZ7Cw7Y8SFMqCjeccJBFZ3b591pnLgQpDpl19389lBAfo63nXuHTvPnT6u2mXNqyrXgBjpOmhCVEftS9W6Df5ybSlLSG0MnxRr4cLSL+ebm9X8yMCbSaqcKW04gkuZmsBP3M6Zk0CellEx6NciSGMB7luCIGcZewgaA4pBVKIakmwFfcYN39XA52cv8BIIAkUWmd5ow1cyADHa7QAiY7aLsYsyeQ5N1IyQaecnQimrUGWxB8nOHvPXq47v5MDOdqAZqdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsrGXOWvWWnxv2jFov5/2fG0b+mdaPigKVYBnpWvwG4=;
 b=b9I9qFjGbKnNC3K2fUedXqaO78YSiRDlsq78Pz7is4Pa59unqhGvRXeW3+EwiFJLczKGxgA3qoymhBeDAD/V1VlsB6iA3oJ8ETaibFLTY2y3z2KEK1C0XZNFaSDVFNAssGHR3CdbpwMnKXpeXHzL3DbXNovrmRvgMUEkGv6FrOU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by MW4PR12MB6922.namprd12.prod.outlook.com
 (2603:10b6:303:207::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 21:20:47 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Mon, 4 Aug 2025
 21:20:47 +0000
Message-ID: <f1721eba-2963-46c2-a68d-dd53f274df01@amd.com>
Date: Mon, 4 Aug 2025 16:20:43 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 05/10] fs/resctrl: Update bit_usage to reflect io_alloc
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, Dave.Martin@arm.com, james.morse@arm.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, akpm@linux-foundation.org,
 paulmck@kernel.org, rostedt@goodmis.org, Neeraj.Upadhyay@amd.com,
 david@redhat.com, arnd@arndb.de, fvdl@google.com, seanjc@google.com,
 thomas.lendacky@amd.com, pawan.kumar.gupta@linux.intel.com,
 yosry.ahmed@linux.dev, sohil.mehta@intel.com, xin@zytor.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, peterz@infradead.org,
 me@mixaill.net, mario.limonciello@amd.com, xin3.li@intel.com,
 ebiggers@google.com, ak@linux.intel.com, chang.seok.bae@intel.com,
 andrew.cooper3@citrix.com, perry.yuan@amd.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1752167718.git.babu.moger@amd.com>
 <87e1a53201f3e539fc917a5d901f09bce432f720.1752167718.git.babu.moger@amd.com>
 <94d075e0-6703-449f-9c0c-8e5973349dff@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <94d075e0-6703-449f-9c0c-8e5973349dff@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:806:f2::16) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|MW4PR12MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc40de0-b6e0-4745-5364-08ddd39cc78d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjE1eHJUV21MSXFreldtYUFFaWJveEpUcUtzaW5ROWRNbWhsclZNUDJKSVFL?=
 =?utf-8?B?TnQ1NmwxTG1QVXl4K0UxQ2VBdlR4ZVBSdGpBdFF1Y25OVUhlTFdyNHV2ZXZU?=
 =?utf-8?B?WWtWYkNtaHJ1clloRUl5Q2t0eVcvSWpnaDlYZW5OOW5tZjhpMW41aWlFb3py?=
 =?utf-8?B?REl4bHpkblovcGhGMDVNd3pYRGtXZ3Zyak5yVTVPTTZjVkdabnFqWkhvMlcz?=
 =?utf-8?B?b00wbzlYb3VZNmdVYmRPNGRQUllPdkM5UXNPQnhxMHlUVmNhZWgwVHcvcG1m?=
 =?utf-8?B?WElWb21Gc1RQTlAyVmVPNVEzbmQ5YUhxRWx6dEFuSEZ1ZENmMGpqUHlHZDUz?=
 =?utf-8?B?OGNPenVxV3J3azNnUGJUOS94QUsxeGlaZXhKb0xWMzE2ek5HNmFZRGg1M3Y3?=
 =?utf-8?B?U0FqSmlTRHM5SGxyVGxWRWVrTHVPd081WDVGejgvRjFBYlpvVEZjbGpCY21a?=
 =?utf-8?B?clN1aDBlRWVyYm5FZFZsNTByM1lVczgwZFc0VU02V3d0U3YxRGdQanZNTnhZ?=
 =?utf-8?B?SSt0RHo3ZVc3cHhJZ29jWFFvU3liM01qL0tvN2NrQUZrZkJVdi9tZDNhNEhF?=
 =?utf-8?B?b2tNYmxBa0hqa2REaHNETXJpYWVGeDBSM0lHVlVTTFNpWUtKbjVKbzgrb0pC?=
 =?utf-8?B?MFFXNWlmM2FZQWtLZ1pCTDhhejA1d3JZOWU3dkR3TzRrYmxta3RwRDRPREwx?=
 =?utf-8?B?R2FJK21lWWxRR29Hc0UvbXkwcFk1S3RzOUhUa1p3V3JXaTU3TW1ucUNzRmcy?=
 =?utf-8?B?R2JMUy9rQ0NGVDF4ZGNJd3FPV3h4MU9LKzE2NlArQWhxOEZqRDJzKys4UWVW?=
 =?utf-8?B?TGlUaE5SN2pONVNqcFNRWUwyc2F1OXhiNEVjNDA0akJjY1c1MVdacjBXM1Yw?=
 =?utf-8?B?OHcwODQ1UDFPaE5WZ3RYd2NBN3JvVTFEb0taMzRMdTJrOVFWTmZobDUyUlps?=
 =?utf-8?B?eHozeko0WHE0QkYvSFk1MFF1S3kzcXFIRFh3REhva2FybGlYem9xZERVWDhk?=
 =?utf-8?B?OHFKVGl0VjRWVzZuSGdndCtUMUlYU2Z3UFNnUWp5ZEpLVE9yTjN1Slorazk2?=
 =?utf-8?B?YzBkbzRTYmtTVS9nWGZwcWN0dVZuOXk4NmRTRDdNMERHL3JtdStMbFlrRWxU?=
 =?utf-8?B?cEJRZnlKd0pyc3VQVXRnUm9ON3IwRVhQRk93cTd0WjVKUm4wai9mQjhHblo1?=
 =?utf-8?B?UE51NlZHb2JMRUQycDNZdjhIemZJWVZmRVFmYVY2Uyt4R21Malg2d003SWxM?=
 =?utf-8?B?RU8wc1hFdnZSL1o0d2FHdDJvSk9SckkxYVpJU2kybWp5eEZzN3NENmRReFly?=
 =?utf-8?B?TkkxZHRWMi8rRnNPTUVHL2J5KzBqdUpPMko3MEJTVjF1WFYyT3VldE9oNEdG?=
 =?utf-8?B?SWpCalUzV3lPVGQ5Tmh3TUN4SnhaMmZCSGV4QkNzV3NjNTdxRFc5dVZUUElz?=
 =?utf-8?B?SXhoMFpicTRLdmg4UWl1U08zM3BONU1ZM0tCcmN1b3FzcFhNTjd5b2p5eXVj?=
 =?utf-8?B?S1psamtNQ2puZ1pZY292bFZ2ZER0NUlNeWtCY3l5TXZCVldsNlRWSlE4QTJV?=
 =?utf-8?B?ekttUGdjR0NnalB3N1JPeFhTTGppcWpyQm9LYnpIckVRZ0YzVW94Q3lVUm55?=
 =?utf-8?B?L0p5SkxycnUwVmphZW9qdFdmUDB0STEwYXpML1hUUjZqdXBiSkpSQXNNZlRs?=
 =?utf-8?B?d1RRSkZGS1dNRkpEZ2xTRVVmVXBScmtBYzA4aGxmUFFkSHg1RGVPR0hhSmd0?=
 =?utf-8?B?OFF2clhRVmhOUHpCMlRDWHkvTTdsQmtGb2lRNThkS0tMM2JIbTBvVVhmRkVw?=
 =?utf-8?B?d1hGTHd4VUY0RGphQ1FhYWJic0t2MG0wY2FQSzVRNllmTUJRQlp1a1ZWYzZj?=
 =?utf-8?B?cFJiOVpYaHdBYnpxSlJRYWdUc2tZV1kwRzBFYUJ1WmRJWk9KS3BNUzMyZU5u?=
 =?utf-8?Q?FaKYTZnLTX4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDE2VlhuaVJORHo2bFF1enl1R0dxNU1MSzUwY1dRcnVnbEpqV3lxSVFPQkZF?=
 =?utf-8?B?ZGhabjAzZVhBMU5HRThHV28yZlM0YUFkMmUxY1hacUsvMzAyK3Zoa2JuREdU?=
 =?utf-8?B?ekU1SHQ0TlZzSDc4MXZ3cWxFUzVZcE5mVjlEV3k3a2RQQlBjd01MOUErM0hQ?=
 =?utf-8?B?UWVFb1hNT3RlU0dxcXg0aHZuZ0dLdGpEQTJNNDh6bUxWZkZYSkFoeHFkb2JY?=
 =?utf-8?B?azJnSlVIOFBGMkFqeGlJanE3RTJCcTBuL3BDYlJZeEpjKzRxd0FEbmpYdmNT?=
 =?utf-8?B?YU5YcTB1YldCLzVQcGNENklLWWMyZFRpWkhCQlppVlBMRExIRGNhK1VhaUlD?=
 =?utf-8?B?Mk90Nm9RbHczR3RZSmE5ME9ETmhpUGNqQ1Zxam8wcWZHSkI3bElnUXV3Y250?=
 =?utf-8?B?NXVPakVJeUFlSHN4MU9YdjByM1d4WkJQYUVWWWtockNzQlE1Q043czlhNDBT?=
 =?utf-8?B?bk5vR2F4VVlYaUNPK1VwN09rS2dBMGhBbWN0dk1lZWNTS0srdUM1NDJldWZu?=
 =?utf-8?B?NkE5Vi9ta0pTcnFHbUdzVFRwa2tEQU5HNHIreDM1RERDOFBuMFBhbTRYQVdm?=
 =?utf-8?B?Q3FrTVF3bmtTUEdUWis3cldjVWhBL0N0dndjK0xnUFU5Q2lPSkkvL3ZtT3ZI?=
 =?utf-8?B?alJ3dGZDa3RIZy9saElvSWN4SDR0aG11NHU3UjFVS1JCWDBnMEZwUmc3N0Ra?=
 =?utf-8?B?NG5ZenhiWjdKSXBtN0lteXIzV0RzckVTL3ZRbzVvd3ZDOEk3ZmsxZlhaVGpC?=
 =?utf-8?B?aW9GandDdnhCMGZsclhacldpcTE5MG9UZDZEOS9pU2hGM3RrVjBYWnd1VXRW?=
 =?utf-8?B?Mk04T2d0bjNUVHFqWm9XcEF1WjIxcXpkY1dweHBsVjE5THVrbXduQUIzR0lV?=
 =?utf-8?B?MUkyQVZVZGRxZDlPM2paMWFGcm43UmlrQ2IzV05aOTFlU0o1UnpYaG8zWVVo?=
 =?utf-8?B?V1NhODB0SmRCWFhWeWh6SlgyZktWZ1NaL1JtQ0FkY0djdVp6bnNkRHduaFgv?=
 =?utf-8?B?VGdpUnA4dEtwdDd6VlVkTDJKSGxTemJJdjh1QTdzeTVmTENSamRpbCt6bWx1?=
 =?utf-8?B?RGg1czZTbVF3WjhwRW51OTlGb0FaMGxBd1d1ZUZvOGFFMkxZL0RPQjFHWi9u?=
 =?utf-8?B?VzNNajZOQ1dhcWVGMjdFNDg0cEVYTDFLcVNDYm9oaDRrK05DNzlrNVlQMXM2?=
 =?utf-8?B?NmNzK1dXaDdiWW1rVEkyRDdyZkhFVEV0WmJraWdWYWxTeXIza1d0Q05SL3c1?=
 =?utf-8?B?Mmd2WWxwaStwSExNSm95TmxpUG1SZWJ1RnZUVS9yb0xYcnhkYVNlZFNNQkQv?=
 =?utf-8?B?NTQ0WkpEazBlRlhlZEl6OFlZYmN3ZXpQV29EL3ZwbnVqQkUrU2RIRjBPK1ZO?=
 =?utf-8?B?dG41OWcrNnI0WFJmL2IvWmM1UTJqVDcrK2p6TzJidXhqbHlkUURaOTBpY0Z6?=
 =?utf-8?B?VkY4RDJTM0N1WXByaFQyeTMyclNETzF5NXBWZW5jbTNUSDZBQTZMWU5LdEt2?=
 =?utf-8?B?UVkwYWMwSzFXUDlQWnZISWpwU0FOcm9PQU8yNGZ1T3dHd3J0b2VtR1VpaWNF?=
 =?utf-8?B?SWdSMlkyNk5LMmR0SUtoN0M4UnBrMFNaVk54V3c3OHBxSVc3bWozWXFPSy8w?=
 =?utf-8?B?cmRwNi9OMk8zYXpmd0JxZEhrTThkK0xBb0J2OVAzVXZ1b3YySWJLZmIxbkR2?=
 =?utf-8?B?MGtuSTBFZURISEluUnJXR2V3cGxQUWN2VXdJN1B2aCs4T2I4SlYxRFdNdXFr?=
 =?utf-8?B?ZXNGMkJ4RVZhNFppeXQwdFA2eDJKc2R5clJIdSsxUlRJRHBLVFkrQkNwMS9C?=
 =?utf-8?B?VXZIcHJycWxuYWV4L2JoYXhteVhSMFJDb3BMV3ljeEwwVWE5VGtpY1lyMGFq?=
 =?utf-8?B?Rm96UnRKcGxySzR2S2pFTElxZ25jRlEyekJ0V1FHcnpJMHFKMmhQeDd3RWV4?=
 =?utf-8?B?UEQ2OGM5V3lOV1doK1dsamNSSDk2QkZDVDRFWmREUmRQbjM1UE8yYU1JQ2Mx?=
 =?utf-8?B?MjJEVThMZDlCbW4vZXRHUjBSTXJBZUtjYU1pbDdNejkzTkJzNHBORGxUQm1a?=
 =?utf-8?B?OTZXWCtXK3VVcUZRSVRodUtMdFRlb0orUzVZRUJVMHhuYXNwRXdMN2Ftbk8y?=
 =?utf-8?Q?aGOI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc40de0-b6e0-4745-5364-08ddd39cc78d
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 21:20:47.5173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKIkHUZkGpNV25ccn6gagEG2QWK0jyZxM/a3n1Aoq/ObzfDVXUV0p60QRWnT9qrg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6922

Hi Reinette,

On 7/21/25 18:35, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/10/25 10:16 AM, Babu Moger wrote:
>> When the io_alloc feature is enabled, a portion of the cache can be
>> configured for shared use between hardware and software.
>>
>> Update the bit_usage representation to reflect the io_alloc configuration.
> 
> This patch is early in the series but also relies on capabilities added
> later in the series. This cryptic changelog leaves a lot for the user
> to decipher. For example:
> - How is the "io_alloc CLOSID" chosen? This is mentioned in cover letter but
>   not here. Doing so here may help explain the hardcoding of CDP_CODE done
>   in this patch (which seem unnecessary, more later, but a lot depends on
>   changes that follow this patch).
> - No mention that when io_alloc is enabled then an associated CLOSID will
>   be allocated. This is done later in series but assumed to be known here
>   where rdt_bit_usage_show() implicitly assumes that when io_alloc is enabled
>   then the "io_alloc CLOSID" is supported AND allocated (otherwise array overrun?)

Make sense. Moved this patch to the last.

> 
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v7: New patch split from earlier patch #5.
>>     Added resctrl_io_alloc_closid() to return max COSID.
>> ---
>>  Documentation/filesystems/resctrl.rst | 20 ++++++++++-----
>>  fs/resctrl/rdtgroup.c                 | 37 +++++++++++++++++++++++++--
>>  2 files changed, 49 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>> index c7949dd44f2f..c3c412733632 100644
>> --- a/Documentation/filesystems/resctrl.rst
>> +++ b/Documentation/filesystems/resctrl.rst
>> @@ -89,12 +89,20 @@ related to allocation:
>>  		must be set when writing a mask.
>>  
>>  "shareable_bits":
>> -		Bitmask of shareable resource with other executing
>> -		entities (e.g. I/O). User can use this when
>> -		setting up exclusive cache partitions. Note that
>> -		some platforms support devices that have their
>> -		own settings for cache use which can over-ride
>> -		these bits.
>> +		Bitmask of shareable resource with other executing entities
>> +		(e.g. I/O). Applies to all instances of this resource. User
>> +		can use this when setting up exclusive cache partitions.
>> +		Note that some platforms support devices that have their
>> +		own settings for cache use which can over-ride these bits.
>> +
>> +		When "io_alloc" feature is enabled, a portion of the cache
>> +		can be configured for shared use between hardware and software.
> 
> To help distinguish how "io_alloc" is different from "shareable_bits" this can be:
> 		When "io_alloc" is enabled, a portion of each cache instance can
> 		be configured for shared use between hardware and software.

Sure.

> 
> Please merge these two paragraphs.

Sure.

> 
>> +		"bit_usage" should be used to see which portions of each cache
>> +		instance is configured for hardware use via "io_alloc" feature
>> +		because every cache instance can have its "io_alloc" bitmask
>> +		configured independently.
> 
> append " via "io_alloc_cbm"."?

sure.

> (but io_alloc_cbm does not exist at this point ... another motivation for this
> patch to move later)
> 

Sure.

>> +
>>  "bit_usage":
>>  		Annotated capacity bitmasks showing how all
>>  		instances of the resource are used. The legend is:
> 
> Please note that this "bit_usage" section contain several references to "shareable_bits"
> that should be updated to refer to "io_alloc_cbm" also.
> 
> With all these new terms introduced as common knowledge it is starting to look
> like this patch would be easier to consume later in the series.

Sure.

> 
>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>> index 77d08229d855..a2eea85aecc8 100644
>> --- a/fs/resctrl/rdtgroup.c
>> +++ b/fs/resctrl/rdtgroup.c
>> @@ -1030,6 +1030,20 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
>>  	return 0;
>>  }
>>  
>> +/*
>> + * resctrl_io_alloc_closid() - io_alloc feature routes I/O traffic using
>> + * the highest available CLOSID. Retrieve the maximum CLOSID supported by the
>> + * resource. Note that if Code Data Prioritization (CDP) is enabled, the number
>> + * of available CLOSIDs is reduced by half.
>> + */
>> +static u32 resctrl_io_alloc_closid(struct rdt_resource *r)
> 
> Please move to ctrlmondata.c.

Yes.

> 
>> +{
>> +	if (resctrl_arch_get_cdp_enabled(r->rid))
>> +		return resctrl_arch_get_num_closid(r) / 2  - 1;
>> +	else
>> +		return resctrl_arch_get_num_closid(r) - 1;
>> +}
>> +
>>  /*
>>   * rdt_bit_usage_show - Display current usage of resources
>>   *
>> @@ -1063,15 +1077,17 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
>>  
>>  	cpus_read_lock();
>>  	mutex_lock(&rdtgroup_mutex);
>> -	hw_shareable = r->cache.shareable_bits;
>>  	list_for_each_entry(dom, &r->ctrl_domains, hdr.list) {
>>  		if (sep)
>>  			seq_putc(seq, ';');
>> +		hw_shareable = r->cache.shareable_bits;
>>  		sw_shareable = 0;
>>  		exclusive = 0;
>>  		seq_printf(seq, "%d=", dom->hdr.id);
>>  		for (i = 0; i < closids_supported(); i++) {
>> -			if (!closid_allocated(i))
>> +			if (!closid_allocated(i) ||
>> +			    (resctrl_arch_get_io_alloc_enabled(r) &&
>> +			     i == resctrl_io_alloc_closid(r)))
>>  				continue;
>>  			ctrl_val = resctrl_arch_get_config(r, dom, i,
>>  							   s->conf_type);
>> @@ -1099,6 +1115,23 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
>>  				break;
>>  			}
>>  		}
>> +
>> +		/*
>> +		 * When the "io_alloc" feature is enabled, a portion of the
>> +		 * cache is configured for shared use between hardware and software.
>> +		 */
>> +		if (resctrl_arch_get_io_alloc_enabled(r)) {
> 
> Here is undocumented implicit assumption that when io_alloc is enabled then
> the "io_alloc CLOSID" is allocated. This is also outside the closids_supported()
> loop which adds the other implicit assumption that if io_alloc is enabled then
> its CLOSID is supported by resctrl fs. None of these concepts have been introduced
> so far and is not mentioned in changelog.
> It is not obvious here that an io_alloc CLOSID must be supported (this is just
> something enforced by later patches) and also not obvious that an io_alloc CLOSID
> must be allocated from same "pool" as other CLOSIDs. Without a good changelog and
> context of later patches this is hard to understand.
> These are motivations for this patch to move later in the series and then the
> changelog can just refer to these assumptions as fact, making it all easier to follow.

Sure.

> 
>> +			if (resctrl_arch_get_cdp_enabled(r->rid))
>> +				ctrl_val = resctrl_arch_get_config(r, dom,
>> +								   resctrl_io_alloc_closid(r),
>> +								   CDP_CODE);
>> +			else
>> +				ctrl_val = resctrl_arch_get_config(r, dom,
>> +								   resctrl_io_alloc_closid(r),
>> +								   CDP_NONE);
> 
> This does not look necessary to me. Why not just:
> 		if (resctrl_arch_get_io_alloc_enabled(r)) {
> 			ctrl_val = resctrl_arch_get_config(r, dom,
> 							   resctrl_io_alloc_closid(r),
> 							   s->conf_type);
> 			hw_shareable |= ctrl_val;
> 		}
> 
> Since the later patches keep the CDP_CODE and CDP_DATA CBMs in sync it does not matter
> if the io_alloc CBM is obtained from CDP_CODE or CDP_DATA and just providing the
> schema's type to resctrl_arch_get_config() will have it retrieve the right CBM, no?

Yes. That is correct.

> 
> This may also be easier to understand/claim if this patch is later in the series.

Sure.

> 
> 
>> +			hw_shareable |= ctrl_val;
>> +		}
>> +
>>  		for (i = r->cache.cbm_len - 1; i >= 0; i--) {
>>  			pseudo_locked = dom->plr ? dom->plr->cbm : 0;
>>  			hwb = test_bit(i, &hw_shareable);
> 
> Reinette
> 

-- 
Thanks
Babu Moger


