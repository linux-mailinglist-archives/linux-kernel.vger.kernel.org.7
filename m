Return-Path: <linux-kernel+bounces-737768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B31BB0B055
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 15:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE3A5189E9A9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 13:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EAD287242;
	Sat, 19 Jul 2025 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gzVKYdZT";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gzVKYdZT"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010067.outbound.protection.outlook.com [52.101.84.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7CC154425
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.67
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752933192; cv=fail; b=T1Kb9bpTAcpEhFLrH4AEaUhHAPfbQx7v/9x4suhElFAx4qOwg17Ccov8v5ZafUQIPKcTIaCL95tMR5pDcfl75mKsX8nbJLtfk+cQSymLVtvXVglN4ft2LDQWKZVWSf9M7A4xQl4bKHaawXjqxaNAITeDfuz2TithZ1tt4EZP82s=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752933192; c=relaxed/simple;
	bh=7JIZQXQFnWPvtIagVNLofMqBsNlMo7SNaItm55pMsVE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ngXMzrRfPScGCNoy/EfzGaZENOrNDBzNriRNquyNCLIhUp/g1qNg/OZ//VujPxt+NHF3Nenm0xQ4TmpZ7767OwQ0xhbCgS8wYgOVDkKyK79USjq2Jrw3YRfRYCMFpIYovyFkwvJMFGk84SJunFYwTMnPFroEvvYhgA5jfCgue1Y=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gzVKYdZT; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gzVKYdZT; arc=fail smtp.client-ip=52.101.84.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=fBSq/gc/oXRpqZxPqkBgHCehmU2mAPh+P0O4+uB/AMEtxJf6drwIRWS6zWFty5a0OPjUvYbMHhX179bg5j0hD04eJ5hf6hg1m8100ZkmaEGrRQMKHlrIB7K56aafVTNiOjF1XIIDAYE89CPTESA3XsIJWe4zp84lFfOhQxWDd4r1Ghk+grsudG2XMWZ2UYQFl8DhVqgGtLREZiVMcMJDJds/19rArIf3VXkA7AlSVhxtmz4wfCbKNpM5koI0aS3UTIyNpAK2uSweja4yMeo2s2g3z4220dPeHxQhc8nMOrFrTOMZ872Cmx2hnvyyge/8xE8krey9acFtcPdYt5R21w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZQiacTLF/EuF4Ak+WEU1MUJNQRelCIGrb0nvw+Wbto=;
 b=eOJAagIb3IuGzwzMe0BdTAS4bfj6qU76h9z3cq7ZxghjxdDOLkbKTNN1kD1jZzCyohG3R/OOUOBRCMRHkJQsRZCOqaLqNjkfS0MNZlhCXCl9YDE81KR3hIlHaX9nPJF+FnjPBsmYNgQGu0C/2bXgUNW8D7AK2RopP3jpyUzNHQbxMDR22raDv+ja1dR1sHOJa4rRMBxoK8HfdT+VQhdakO9lxEaL2xlBYI0icXJveWAtxWHPTLdO6fWoPd2t6S9vQgk4KpuwrCK8kSPNSPN5qoZSG9LxrUUNDJiQ1Yn4bQSMurTIRFXa7792xh3jy/cbBk3H5I/Ht5QtMmfnrCtmJw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZQiacTLF/EuF4Ak+WEU1MUJNQRelCIGrb0nvw+Wbto=;
 b=gzVKYdZTp3lDUsYsumMDrxmInG7jX9k2bzgbxx7pm3mdFm8zuuARjOPeBx0Eh2FKvvAWq91p0k1IF1Bep2jjFSasng6K/vJH7xAIAka1wiocIRrxDxjJ+OVV+a9FBNiV54dfQw5Ki80sD7SYCebeT1pL46Gf31eXgZJGaykTcFA=
Received: from DUZPR01CA0235.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::19) by DU0PR08MB8562.eurprd08.prod.outlook.com
 (2603:10a6:10:405::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Sat, 19 Jul
 2025 13:53:02 +0000
Received: from DU6PEPF0000A7DD.eurprd02.prod.outlook.com
 (2603:10a6:10:4b5:cafe::93) by DUZPR01CA0235.outlook.office365.com
 (2603:10a6:10:4b5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Sat,
 19 Jul 2025 13:53:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7DD.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20 via
 Frontend Transport; Sat, 19 Jul 2025 13:53:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfIjvAVb5tkPOFwvKRS+ePLdEtHvJSC+9tuK8gphpxL1AnqDUmSe5tNkQ5b+wiLCZaSqaOZwckOdL/Uv9rNYlbaX2O9lCck4XSwIYW7AXCk5ROg9mJhuCJquQcA4KXUU/Fj8GoDgOugZ3yT3cw7bI8a3qY3BOFDPkzXA1nbPSyDZVGc5SsILeHuWPJSRL2IZDU+6V9cWew20B7/5NCCV81HK6R4oB6+AMZI3QYBpMWUjBVsYxMz7nHL9zWLBWjEKb9IH8XT2htDrMZ/VRIQ351s9YDc+V+ZaEyd9puAflx/me+9S5Q6wZ/zqFhSq71gQayq7d7+dJIFVXDcPSEA8rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZQiacTLF/EuF4Ak+WEU1MUJNQRelCIGrb0nvw+Wbto=;
 b=qBvvHo36JekolVBrgQaaHYjhZRmPmi5Ovilpcm2LayNpGLFYrQc9HBonIaRnw0sjEeiiY2KiLNiijYc6TreAjoHvAAd5OKXwTA8qHbkcxaDJNcmk+LPiokzE8z7OZqfn7cVCLsgNELWLx8l0ZqeT8mYOM3zCAFyJdcMI8jOE/VbBZ+wuyu5JcU/4qc+WvtmV8NOJmcI9oREC5ACLgboGRg6Z4B3z+WT6Mm+SIHnhaKKqMdiHFPRrUSFI+HrbuePKYf90gAAJ5caVNod55FoT0Mu0cBKNQKFVQwY/ZoT7DE8582hx4flpdm/qYI46+vdWN0UAe3ALsL7K8AnqB61/OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZQiacTLF/EuF4Ak+WEU1MUJNQRelCIGrb0nvw+Wbto=;
 b=gzVKYdZTp3lDUsYsumMDrxmInG7jX9k2bzgbxx7pm3mdFm8zuuARjOPeBx0Eh2FKvvAWq91p0k1IF1Bep2jjFSasng6K/vJH7xAIAka1wiocIRrxDxjJ+OVV+a9FBNiV54dfQw5Ki80sD7SYCebeT1pL46Gf31eXgZJGaykTcFA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DB4PR08MB8077.eurprd08.prod.outlook.com (2603:10a6:10:387::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Sat, 19 Jul
 2025 13:52:27 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.8943.028; Sat, 19 Jul 2025
 13:52:27 +0000
Message-ID: <6e51f756-786f-4f15-a50a-73a482cc73a2@arm.com>
Date: Sat, 19 Jul 2025 19:22:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm64: Enable permission change on arm64 kernel block
 mappings
To: akpm@linux-foundation.org, david@redhat.com, catalin.marinas@arm.com,
 will@kernel.org
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, suzuki.poulose@arm.com, steven.price@arm.com,
 gshan@redhat.com, linux-arm-kernel@lists.infradead.org,
 yang@os.amperecomputing.com, ryan.roberts@arm.com, anshuman.khandual@arm.com
References: <20250703151441.60325-1-dev.jain@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250703151441.60325-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1P287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::32) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DB4PR08MB8077:EE_|DU6PEPF0000A7DD:EE_|DU0PR08MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: d58a3995-65b8-42a8-811b-08ddc6cb93bb
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?WjlBZG9WaXQzK1R2S2pSNlVpdkhzY2gyd1V2WlExOVRRSkwxT2Z5d2RyWnZB?=
 =?utf-8?B?K3BEbkk1cGk0ZnowLzIxRHZhSXlIZ0ZyalRLV2VobDFhcjZjSmp6NVJIdGFs?=
 =?utf-8?B?Y0lyQ2t5a2dKUkcvWjFrUXZLQmluY2toMk5zS1IzeDNEOHpaUmVSRm81QzhP?=
 =?utf-8?B?S21HWEs0alVGa1BFODNHY0tncmZWM28raDVvdFNFZy96cFFHQkZ3aFZteVVy?=
 =?utf-8?B?NFo5K1lGdkx5bUpSRlRWUzNKSHUvZ3dCWVUySnJpWFBPZGtwa2crbHFTT3Jj?=
 =?utf-8?B?b0poanU3cy9LVU1ld1Vodkx1MUYyTTVIVUJRNGdtbmxHYkhSR25XdFNZMitZ?=
 =?utf-8?B?aGY4M2dvQ2Z4cmxYK1BmZStEc1Jza3FOVkFJYzFZZEYzRkxoaDJkRyt0N1Uy?=
 =?utf-8?B?bS9CQU9hUHpqQUpBNGFBK1V6WFpIUVZWWmZtR3JSeDdsdXdYSEhWeFp5bHcw?=
 =?utf-8?B?WnlUSmoxa0lONTlYWjdFUGt4NTB0andrMFpEQUwwODBHTWowcmZUUXlEaG9v?=
 =?utf-8?B?K3YwMXk4a2p6dHlUMi8xeFFtNE5jdlREYS90cWdqS0ZQOTBzcjhpazBwWW9h?=
 =?utf-8?B?bG9IcS9IZ1RPcUJJcUJPN2IzcmhxaFI5M3FLYTB5ZStEU2VQRUFFM01FYVdM?=
 =?utf-8?B?RlVNdDhXTld5ZU5jQ1JjckltbmJyZWJ1TUpzOFFJbXNxekpVM3U4aGZWWUsw?=
 =?utf-8?B?dUNqSVh5VUdFeVM3cTBDMG1JSjdRVU5jbXNaay9qTlpjOVJsNVZoSlNCUkts?=
 =?utf-8?B?OENUV2MyUG5WVlRTc1hQMis4UXFGMktjM0Q2amEzOU54NERlNWErVVY5Z1U0?=
 =?utf-8?B?WGZCcytQT0w0R3h1bjdhQkhvNThqcTNCSHkxeEVNek1JUlJ6S1p0U21NTkJL?=
 =?utf-8?B?RW9WUkF4L3Z0dk5nM0ZZekN5b2I4UlUza01XNVV4bXl5S25sZ1ZjZk1yVEd0?=
 =?utf-8?B?b3phczB4SjJETFdyZXlnakE0TzEyS1Q2ejNRTk9ISGQ2K0tUOUhpaXVhNXZD?=
 =?utf-8?B?S005QzQ1cHBHQmVhSWhsRWtyYTdwT0hBam80clpJeVBpYjF3bjhFTVRCbEFk?=
 =?utf-8?B?SGNKOFJxMWRWK1RNS0ZyazRFamtpck5yRVROWVhPaWJPeUwxR2Z4THNuQmRC?=
 =?utf-8?B?MHo0MVYyWGtoMk04Z3kvQW9kaXhNbDFSQjBkTzhtQUpjcEZXeFZsV0xtbEpI?=
 =?utf-8?B?REIxUTM5aFlHZkVIY0kxeDAzb3FRQ2JOZW5rK3NZL0tNaHE1VE9ZVDF3T0FP?=
 =?utf-8?B?VjFobzVxRmhwRS9pUEwzTUMzSW0zYVUwMU56eVlWQk1ZVGJ5QVNGMGIvRU1Q?=
 =?utf-8?B?UDdUL1N3bE0yaktweGxKS05pZ0xvcG1OT0EyNUttTWtlbEU4OGMzbDdrSFRZ?=
 =?utf-8?B?NkZXTUsyOStDSmlaWkpkU3ZrcEh0cE5PTzl1RUxBMGpUOXh1Wnk5WGJRUVpL?=
 =?utf-8?B?dWcyUGNzRSthZCtMYWl4NlJRS0RCOWIwQ1pINGxCU3BIUVI5alpKeXpZU1dN?=
 =?utf-8?B?RW5PbWlnRHQ5RVRGWU05emJDcGI5Ykw2R0drSzVjanlRL25QUFNVWEVKbS9F?=
 =?utf-8?B?QUN2OW1pblpLeGJ1WG1CdUhhWGNKNzNoNmlUNHNVb0laVmhjdnEwUTZPRG1O?=
 =?utf-8?B?bmwwQnUwYjdUZ3pwRzZJTmtoSUI0VU91S3lQVFB5RHNsZmRVc0wrUHZEQ2Z0?=
 =?utf-8?B?bUFXdVhzVmVFTmFlWEJvUUwxR1RqcGVBazU5dUdidFFDbWFnTGF3WURwU0ll?=
 =?utf-8?B?UHlZejFvWHl4YVp2Y1RKcGZOU2laR3JVRFVBaTFVRzd2VzU3NzgrM0tkVW54?=
 =?utf-8?B?Y041TVhWTldEaitGUkZYWEZ0TThNaklqSWZlcEl0MWFrYjJVYUsxL3lBc1dQ?=
 =?utf-8?B?dUlHa2JHZGJNcVBUVzVpSGtyTS9SMityQWtPUGlvK0I3M0NLRWVNMFVGaU9D?=
 =?utf-8?Q?XpNLn0GIsAg=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8077
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	523f8b32-5df6-4101-c745-08ddc6cb7f0f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|35042699022|1800799024|36860700013|14060799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXluR2M4QVIwN0hQTHp0UFdOcmhFNXlrdG40bVNKNlpGcit2NThRRkZFWTVY?=
 =?utf-8?B?MGFMTXZJNzdjS0Z2UEN1cXpCUXBrclhIR2t6QkhxM3lHV2hReWdrR01pOExS?=
 =?utf-8?B?QnZId0dQM01qNytCb0R6Tkp2OGIyeEZpWnVLTWNYRXk1R054SU1MWDJBK09S?=
 =?utf-8?B?RkJ6dFNaa24ybFpxZkVSZ3pjcVVBdUZGQVRTV3d4cVJiTEhzRWl4SkFERzZ4?=
 =?utf-8?B?Vmg1YkxrdVFOck0wZDhEb0VNUk02Kzl5dFp5a0NvR0tTSnlqelFzVUowd1A0?=
 =?utf-8?B?OG16R1pNUndNeWo3WHppOWJBckFKTitodzN0ZTA4b3dmQmJ3ZURjTHJ2Mlhv?=
 =?utf-8?B?dlhycUxPV0FHYXZrQldVSWduUFZKRE1RZTBMNXovVTY2Yy9vbUZNUWppT2dR?=
 =?utf-8?B?TWw0VmRXd3FiSDVreXljN1BRbTJjL0g3aVZpOTc4RUN0RXdwT25DeGVFUk4y?=
 =?utf-8?B?Z1hrNTJWam5IYW42K3hzZHphNjFJTkhYYlNaSUg3RHpYTmE5UU4vc2JEOGla?=
 =?utf-8?B?eTN1TUd3aTVaVW90Q09oNWdJTEVNZndvZFBFNlhzUGliVnZib2Z0TUxyZEZW?=
 =?utf-8?B?anNUMmtsb0U2SHl3UkpBNjhPenFqeTlpM1NlV3lzL2oxcDYxZ2lERFdWLzVa?=
 =?utf-8?B?M3MwRVYzSTRDK0VSSzZIbkx4NUJzbWZKb1p0RWhFdGNSYVF4YmhWUWg5UDFX?=
 =?utf-8?B?dW8xblpuWFdwa3FpQU9mdVM4WGZRUWpibC9nUVpHQWxpWW9jL3hGRnBWaE01?=
 =?utf-8?B?Sy81K3NOMkM3K0kwSTYvWXR2dzBOYW5uVytQem9abk96b1hMd0dlVzlIZldk?=
 =?utf-8?B?Q1BFWEhYODJsNnhXQ1FWMHA5dHhGditZOG91RmtuYUllMHJKRnpqSXRJcm1l?=
 =?utf-8?B?WU1FYU83a1ZKNHB0bFB1dDFyY2pINFB0b0RvTXc0U2pPVU5QZlJ2cm9zTk5Y?=
 =?utf-8?B?WjNzSUlqaTZQUnhjQlhvNEtZbXhkQlFXb2JCWXpNQnplWUFCWDdFcTBHK2dt?=
 =?utf-8?B?cmtVNmo3RDJ6ZkxxdUx0SXhZMmxNVWc3NDUxSlFWUVdtVXlOUlNkQlMrMzc0?=
 =?utf-8?B?NG4zOGZIWFV1akhuQUthYVh4MEs5N2pFV3BrZ2NubTd5RGFhNHdONHRxRmtI?=
 =?utf-8?B?WjhEa2l5bUFkaFdOY0lTci9Dc1QrUkx3NHJRSmh0NjdwNFpvU3RPcGx0Y0NX?=
 =?utf-8?B?NTl3dERLTkRGeEVsQmoxWlhxR0lvTzZ5M3VVa0xNVVB6bm1LeFo2eVBFSEs1?=
 =?utf-8?B?QzhnZnRjcWd6UElGY3U3aVhNZ1I4WFJFcnJxWG5qTEFKQm5CUWhzUDBXUWhU?=
 =?utf-8?B?QU5vQVgzMTZWMURjNjh6dkFUUVBPazVPUHhEcjN0RytwNFc1YjhhMklBSEw5?=
 =?utf-8?B?WWEvZ0hCdVBWaG9lVGRzU1Jpc29ZRlU0OWhPZGZ0R1VsbDUzV2p5czNtZ01h?=
 =?utf-8?B?aHVKTEhSdXlQclM1UERpZllOT3pzanI3Mk9hVkVhZ1NyYzhmTCtJRjBYWUox?=
 =?utf-8?B?UE5WUzBrcmlLNmNuL2JoQksyK2hyZnZDU2txMjk4THVMMnJ1QUFqWHhaVU9r?=
 =?utf-8?B?ajdDM3d4ZE40M01KcmR2djJDbVBNeFBRemN6OTVEWTZnM2REcmxtK2QyQXRV?=
 =?utf-8?B?M3BEMDd1QXFiTDRESEF6WFQ0Q3ZGZmtFT3QveWd3QmdNcU4wREpNQnh1Y0Rk?=
 =?utf-8?B?M0Y3Z3g4WUN4TlUwYnVubnJydWNNc3V4NFZkMzRLVHFCVXNUSGh1a0d5ZW9l?=
 =?utf-8?B?MkdHbFBwMmdmZVJqQ040ank3VEthUVlTUWxIUzFmUzQ3cHJqT0pOUDRVeTJi?=
 =?utf-8?B?QWViNUtpUzErczhtei9LVUVIR1ZoYXhYdnZvMFFCTEdEMmltWVVPcXVQZ3hv?=
 =?utf-8?B?MG5uU0QxSUZLVldTSUdEbjNtTk9Idk1XOXh1N3FKYTVkTTZlakdadUZMbDhh?=
 =?utf-8?B?eWVQeUtkcUJLQ2xHWDJvUTRwL09GbHdmTDBMUk5ZWVZaYjFSMFZyZ1RHR2pS?=
 =?utf-8?B?dEhkdkNnampsR2Vnb3F1d1NwYTUzZDIrUU5QS3kxMUVyczVlU1lrR3VFeG9H?=
 =?utf-8?B?LzlocG54N0hhNzBPYnRrUXBkOHIwOEkzMnExdz09?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(35042699022)(1800799024)(36860700013)(14060799003)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2025 13:53:01.4592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d58a3995-65b8-42a8-811b-08ddc6cb93bb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8562

Gentle ping

On 03/07/25 8:44 pm, Dev Jain wrote:
> This patch paves the path to enable huge mappings in vmalloc space and
> linear map space by default on arm64. For this we must ensure that we can
> handle any permission games on the kernel (init_mm) pagetable. Currently,
> __change_memory_common() uses apply_to_page_range() which does not support
> changing permissions for block mappings. We attempt to move away from this
> by using the pagewalk API, similar to what riscv does right now; however,
> it is the responsibility of the caller to ensure that we do not pass a
> range overlapping a partial block mapping or cont mapping; in such a case,
> the system must be able to support range splitting.
>
> This patch is tied with Yang Shi's attempt [1] at using huge mappings
> in the linear mapping in case the system supports BBML2, in which case
> we will be able to split the linear mapping if needed without
> break-before-make. Thus, Yang's series, IIUC, will be one such user of my
> patch; suppose we are changing permissions on a range of the linear map
> backed by PMD-hugepages, then the sequence of operations should look
> like the following:
>
> split_range(start)
> split_range(end);
> __change_memory_common(start, end);
>
> However, this patch can be used independently of Yang's; since currently
> permission games are being played only on pte mappings (due to
> apply_to_page_range not supporting otherwise), this patch provides the
> mechanism for enabling huge mappings for various kernel mappings
> like linear map and vmalloc.
>
> ---------------------
> Implementation
> ---------------------
>
> arm64 currently changes permissions on vmalloc objects locklessly, via
> apply_to_page_range, whose limitation is to deny changing permissions for
> block mappings. Therefore, we move away to use the generic pagewalk API,
> thus paving the path for enabling huge mappings by default on kernel space
> mappings, thus leading to more efficient TLB usage. However, the API
> currently enforces the init_mm.mmap_lock to be held. To avoid the
> unnecessary bottleneck of the mmap_lock for our usecase, this patch
> extends this generic API to be used locklessly, so as to retain the
> existing behaviour for changing permissions. Apart from this reason, it is
> noted at [2] that KFENCE can manipulate kernel pgtable entries during
> softirqs. It does this by calling set_memory_valid() -> __change_memory_common().
> This being a non-sleepable context, we cannot take the init_mm mmap lock.
>
> Add comments to highlight the conditions under which we can use the
> lockless variant - no underlying VMA, and the user having exclusive control
> over the range, thus guaranteeing no concurrent access.
>
> We require that the start and end of a given range do not partially overlap
> block mappings, or cont mappings. Return -EINVAL in case a partial block
> mapping is detected in any of the PGD/P4D/PUD/PMD levels; add a
> corresponding comment in update_range_prot() to warn that eliminating
> such a condition is the responsibility of the caller.
>
> Note that, the pte level callback may change permissions for a whole
> contpte block, and that will be done one pte at a time, as opposed to
> an atomic operation for the block mappings. This is fine as any access
> will decode either the old or the new permission until the TLBI.
>
> apply_to_page_range() currently performs all pte level callbacks while in
> lazy mmu mode. Since arm64 can optimize performance by batching barriers
> when modifying kernel pgtables in lazy mmu mode, we would like to continue
> to benefit from this optimisation. Unfortunately walk_kernel_page_table_range()
> does not use lazy mmu mode. However, since the pagewalk framework is not
> allocating any memory, we can safely bracket the whole operation inside
> lazy mmu mode ourselves. Therefore, wrap the call to
> walk_kernel_page_table_range() with the lazy MMU helpers.
>
> [1] https://lore.kernel.org/all/20250304222018.615808-1-yang@os.amperecomputing.com/
> [2] https://lore.kernel.org/linux-arm-kernel/89d0ad18-4772-4d8f-ae8a-7c48d26a927e@arm.com/
>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>
> v3->v4:
>   - Drop patch 2, will add it back when we actually enable vmalloc block
>     mappings by default (Ryan)
>   - Rename ___change_memory_common -> update_range_prot (Mike Rapoport)
>   - Explain why changing live kernel mappings mapped with PTE_CONT
>     pte-by-pte is safe
>
> v2->v3:
>   - Drop adding PGWALK_NOLOCK, instead have a new lockless helper
>   - Merge patch 1 and 2 from v2
>   - Add a patch *actually* enabling vmalloc-huge permission change
>
> v1->v2:
>   - Squash patch 2 and 3
>   - Add comment describing the responsibility of the caller to ensure no
>     partial overlap with block mapping
>   - Add comments and return -EINVAL at relevant places to document the usage
>     of PGWALK_NOLOCK (Lorenzo)
>   - Nest walk_kernel_page_table_range() with lazy_mmu calls, instead of
>     doing so only per PTE level, fix bug in the PTE callback, introduce
>     callbacks for all pagetable levels, use ptdesc_t instead of unsigned
>     long, introduce ___change_memory_common and use them for direct map
>     permission change functions (Ryan)
>
> v1:
> https://lore.kernel.org/all/20250530090407.19237-1-dev.jain@arm.com/
>
>   arch/arm64/mm/pageattr.c | 155 +++++++++++++++++++++++++++++++--------
>   include/linux/pagewalk.h |   3 +
>   mm/pagewalk.c            |  24 ++++++
>   3 files changed, 150 insertions(+), 32 deletions(-)
>
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 04d4a8f676db..c6a85000fa0e 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -8,6 +8,7 @@
>   #include <linux/mem_encrypt.h>
>   #include <linux/sched.h>
>   #include <linux/vmalloc.h>
> +#include <linux/pagewalk.h>
>   
>   #include <asm/cacheflush.h>
>   #include <asm/pgtable-prot.h>
> @@ -20,6 +21,99 @@ struct page_change_data {
>   	pgprot_t clear_mask;
>   };
>   
> +static ptdesc_t set_pageattr_masks(ptdesc_t val, struct mm_walk *walk)
> +{
> +	struct page_change_data *masks = walk->private;
> +
> +	val &= ~(pgprot_val(masks->clear_mask));
> +	val |= (pgprot_val(masks->set_mask));
> +
> +	return val;
> +}
> +
> +static int pageattr_pgd_entry(pgd_t *pgd, unsigned long addr,
> +			      unsigned long next, struct mm_walk *walk)
> +{
> +	pgd_t val = pgdp_get(pgd);
> +
> +	if (pgd_leaf(val)) {
> +		if (WARN_ON_ONCE((next - addr) != PGDIR_SIZE))
> +			return -EINVAL;
> +		val = __pgd(set_pageattr_masks(pgd_val(val), walk));
> +		set_pgd(pgd, val);
> +		walk->action = ACTION_CONTINUE;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pageattr_p4d_entry(p4d_t *p4d, unsigned long addr,
> +			      unsigned long next, struct mm_walk *walk)
> +{
> +	p4d_t val = p4dp_get(p4d);
> +
> +	if (p4d_leaf(val)) {
> +		if (WARN_ON_ONCE((next - addr) != P4D_SIZE))
> +			return -EINVAL;
> +		val = __p4d(set_pageattr_masks(p4d_val(val), walk));
> +		set_p4d(p4d, val);
> +		walk->action = ACTION_CONTINUE;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pageattr_pud_entry(pud_t *pud, unsigned long addr,
> +			      unsigned long next, struct mm_walk *walk)
> +{
> +	pud_t val = pudp_get(pud);
> +
> +	if (pud_leaf(val)) {
> +		if (WARN_ON_ONCE((next - addr) != PUD_SIZE))
> +			return -EINVAL;
> +		val = __pud(set_pageattr_masks(pud_val(val), walk));
> +		set_pud(pud, val);
> +		walk->action = ACTION_CONTINUE;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pageattr_pmd_entry(pmd_t *pmd, unsigned long addr,
> +			      unsigned long next, struct mm_walk *walk)
> +{
> +	pmd_t val = pmdp_get(pmd);
> +
> +	if (pmd_leaf(val)) {
> +		if (WARN_ON_ONCE((next - addr) != PMD_SIZE))
> +			return -EINVAL;
> +		val = __pmd(set_pageattr_masks(pmd_val(val), walk));
> +		set_pmd(pmd, val);
> +		walk->action = ACTION_CONTINUE;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pageattr_pte_entry(pte_t *pte, unsigned long addr,
> +			      unsigned long next, struct mm_walk *walk)
> +{
> +	pte_t val = __ptep_get(pte);
> +
> +	val = __pte(set_pageattr_masks(pte_val(val), walk));
> +	__set_pte(pte, val);
> +
> +	return 0;
> +}
> +
> +static const struct mm_walk_ops pageattr_ops = {
> +	.pgd_entry	= pageattr_pgd_entry,
> +	.p4d_entry	= pageattr_p4d_entry,
> +	.pud_entry	= pageattr_pud_entry,
> +	.pmd_entry	= pageattr_pmd_entry,
> +	.pte_entry	= pageattr_pte_entry,
> +};
> +
>   bool rodata_full __ro_after_init = IS_ENABLED(CONFIG_RODATA_FULL_DEFAULT_ENABLED);
>   
>   bool can_set_direct_map(void)
> @@ -37,33 +131,35 @@ bool can_set_direct_map(void)
>   		arm64_kfence_can_set_direct_map() || is_realm_world();
>   }
>   
> -static int change_page_range(pte_t *ptep, unsigned long addr, void *data)
> +static int update_range_prot(unsigned long start, unsigned long size,
> +			     pgprot_t set_mask, pgprot_t clear_mask)
>   {
> -	struct page_change_data *cdata = data;
> -	pte_t pte = __ptep_get(ptep);
> +	struct page_change_data data;
> +	int ret;
>   
> -	pte = clear_pte_bit(pte, cdata->clear_mask);
> -	pte = set_pte_bit(pte, cdata->set_mask);
> +	data.set_mask = set_mask;
> +	data.clear_mask = clear_mask;
>   
> -	__set_pte(ptep, pte);
> -	return 0;
> +	arch_enter_lazy_mmu_mode();
> +
> +	/*
> +	 * The caller must ensure that the range we are operating on does not
> +	 * partially overlap a block mapping, or a cont mapping. Any such case
> +	 * must be eliminated by splitting the mapping.
> +	 */
> +	ret = walk_kernel_page_table_range_lockless(start, start + size,
> +						    &pageattr_ops, &data);
> +	arch_leave_lazy_mmu_mode();
> +
> +	return ret;
>   }
>   
> -/*
> - * This function assumes that the range is mapped with PAGE_SIZE pages.
> - */
>   static int __change_memory_common(unsigned long start, unsigned long size,
> -				pgprot_t set_mask, pgprot_t clear_mask)
> +				  pgprot_t set_mask, pgprot_t clear_mask)
>   {
> -	struct page_change_data data;
>   	int ret;
>   
> -	data.set_mask = set_mask;
> -	data.clear_mask = clear_mask;
> -
> -	ret = apply_to_page_range(&init_mm, start, size, change_page_range,
> -					&data);
> -
> +	ret = update_range_prot(start, size, set_mask, clear_mask);
>   	/*
>   	 * If the memory is being made valid without changing any other bits
>   	 * then a TLBI isn't required as a non-valid entry cannot be cached in
> @@ -71,6 +167,7 @@ static int __change_memory_common(unsigned long start, unsigned long size,
>   	 */
>   	if (pgprot_val(set_mask) != PTE_VALID || pgprot_val(clear_mask))
>   		flush_tlb_kernel_range(start, start + size);
> +
>   	return ret;
>   }
>   
> @@ -174,32 +271,26 @@ int set_memory_valid(unsigned long addr, int numpages, int enable)
>   
>   int set_direct_map_invalid_noflush(struct page *page)
>   {
> -	struct page_change_data data = {
> -		.set_mask = __pgprot(0),
> -		.clear_mask = __pgprot(PTE_VALID),
> -	};
> +	pgprot_t clear_mask = __pgprot(PTE_VALID);
> +	pgprot_t set_mask = __pgprot(0);
>   
>   	if (!can_set_direct_map())
>   		return 0;
>   
> -	return apply_to_page_range(&init_mm,
> -				   (unsigned long)page_address(page),
> -				   PAGE_SIZE, change_page_range, &data);
> +	return update_range_prot((unsigned long)page_address(page),
> +				 PAGE_SIZE, set_mask, clear_mask);
>   }
>   
>   int set_direct_map_default_noflush(struct page *page)
>   {
> -	struct page_change_data data = {
> -		.set_mask = __pgprot(PTE_VALID | PTE_WRITE),
> -		.clear_mask = __pgprot(PTE_RDONLY),
> -	};
> +	pgprot_t set_mask = __pgprot(PTE_VALID | PTE_WRITE);
> +	pgprot_t clear_mask = __pgprot(PTE_RDONLY);
>   
>   	if (!can_set_direct_map())
>   		return 0;
>   
> -	return apply_to_page_range(&init_mm,
> -				   (unsigned long)page_address(page),
> -				   PAGE_SIZE, change_page_range, &data);
> +	return update_range_prot((unsigned long)page_address(page),
> +				 PAGE_SIZE, set_mask, clear_mask);
>   }
>   
>   static int __set_memory_enc_dec(unsigned long addr,
> diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
> index 682472c15495..8212e8f2d2d5 100644
> --- a/include/linux/pagewalk.h
> +++ b/include/linux/pagewalk.h
> @@ -134,6 +134,9 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
>   int walk_kernel_page_table_range(unsigned long start,
>   		unsigned long end, const struct mm_walk_ops *ops,
>   		pgd_t *pgd, void *private);
> +int walk_kernel_page_table_range_lockless(unsigned long start,
> +		unsigned long end, const struct mm_walk_ops *ops,
> +		void *private);
>   int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
>   			unsigned long end, const struct mm_walk_ops *ops,
>   			void *private);
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index 648038247a8d..18a675ab87cf 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -633,6 +633,30 @@ int walk_kernel_page_table_range(unsigned long start, unsigned long end,
>   	return walk_pgd_range(start, end, &walk);
>   }
>   
> +/*
> + * Use this function to walk the kernel page tables locklessly. It should be
> + * guaranteed that the caller has exclusive access over the range they are
> + * operating on - that there should be no concurrent access, for example,
> + * changing permissions for vmalloc objects.
> + */
> +int walk_kernel_page_table_range_lockless(unsigned long start, unsigned long end,
> +		const struct mm_walk_ops *ops, void *private)
> +{
> +	struct mm_walk walk = {
> +		.ops		= ops,
> +		.mm		= &init_mm,
> +		.private	= private,
> +		.no_vma		= true
> +	};
> +
> +	if (start >= end)
> +		return -EINVAL;
> +	if (!check_ops_valid(ops))
> +		return -EINVAL;
> +
> +	return walk_pgd_range(start, end, &walk);
> +}
> +
>   /**
>    * walk_page_range_debug - walk a range of pagetables not backed by a vma
>    * @mm:		mm_struct representing the target process of page table walk

