Return-Path: <linux-kernel+bounces-751704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA46B16C74
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02D2156265E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CE9296148;
	Thu, 31 Jul 2025 07:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Q6igckgC";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Q6igckgC"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011065.outbound.protection.outlook.com [52.101.65.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CA2293B42
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.65
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753945987; cv=fail; b=dQzW7yJskVdXjN1oHS/P29s9ADjCEL9B++akozuocVRflTEPy41gozzvgKB9PftNQ0+3QaWd0pvfK5oB2ORSiAFc7DsrozB+cGlMNlgaxTIsSfieIer7vvW2uAHHCLp05RdPom1+p1T+VzaTYek836PbjUlmwmrOHtB436G9u4Q=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753945987; c=relaxed/simple;
	bh=gvllbx6ks+wPqd+pL5ZwoIkF9o1XtCTVLY/cZdachjM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j+0wmCJgRsBhCnPWcfSDHODYEdc8rqQa5fgRzUtY9Gx2GfAsxJlZuhJOhSt2nRG4IeCP8OKamnY+HSDJSD5xoa74AT+kKuFHBiUrIVHnoq6k4RBFjdNvaAxEETSarrHbiLbPr18cGJtp3Fd3nLqf9rrllL4Bf0j+0MvRvg2u4uY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Q6igckgC; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Q6igckgC; arc=fail smtp.client-ip=52.101.65.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=RYEdGxvJHdnT/+qaHY9JlHAEJri27BK0rtUqlHBiVXtglHNnF0dAh88kVr8teuyDg476vapr17rNxz3LgsqRV3gLKR08S6fprubq6IjixjsSvmWAmX3qq4XSGXki6TEpMlo3+GjjEJQzuUE0CiSsWvdPvQPMe38RTP5UcYNBNKuji1tOMK4gtpAnauiOt3cI/vkNJL6kLanvKFogMJyE88eXV6fZUeK22KN9Ex9BlYA0OtR/oDyjh+vjlfnKksBefZaQqaxc4EBdUbQJSEHYBhkSDJuHPUgmXBbLKUBd+vdJ9cao4s5WSTzRlYvK77/rdLTDdG+z16WpJqBqcn/zhw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLLZRbFiRdKgjhCo2OtesQ+8PQ3akA77xJyNVbMDPkw=;
 b=rqdSFvVIx6+qhcGQgPeHLrUL/+zrvCvAaxn3qmYvXsqUsjFAG0LArS7t57vdPoqGmotT8uew99w9pXJCD1XL18Q51+or7scWHy6MEF2NWHgs6Dj1bnZ6ZlVUINxdP+e2Z7TElQnn8dMY0tJREpm+iRucK/4hcsDuhHBZhtbTwa6vsufek+YDZNlmNayV6E0TOlvSPCce5pVJgONG1cpKYJ1C2bZgs3P2ko8sCM/HGzbyGQl7FUk7EuapKZGRFMjyRo75c2/1P34IUKSAJs64zzVM3jw3dC8nKxqv/iQYdsFrgMkBLPkHHp2Fj3e4yg3Do7a8iY5Q9mq/PFLp3MmDWw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLLZRbFiRdKgjhCo2OtesQ+8PQ3akA77xJyNVbMDPkw=;
 b=Q6igckgCbjF4smwiN7faemFS/5UqZFAFOhMSXxNVzQs069Ohve+PBhltS2Vew5szt/nDOcsDFW0+Fb7pYS9UEKdrh2TPLVzsnRAr62lOR8DbDBenWD39Z0RJz82/5JHnJO1LsPD1GcJhTSpCxk8/G2yR+GE5whLO5yETsvcUlNg=
Received: from AM8P251CA0011.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::16)
 by DBBPR08MB6041.eurprd08.prod.outlook.com (2603:10a6:10:206::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 07:13:00 +0000
Received: from AMS1EPF00000049.eurprd04.prod.outlook.com
 (2603:10a6:20b:21b:cafe::9d) by AM8P251CA0011.outlook.office365.com
 (2603:10a6:20b:21b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.13 via Frontend Transport; Thu,
 31 Jul 2025 07:13:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000049.mail.protection.outlook.com (10.167.16.133) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.10
 via Frontend Transport; Thu, 31 Jul 2025 07:12:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFUtzKvelD0yPjDuJlVEj4BqP6b5l5Jlt0G4sVD/jn1KmCJP7sbT/Qjq1qySxI7nV48iim4x7QUQi7W9HHkSNPHmAhW1D3V/6eRAmYN/jQFAamViQOA4jJtuCImgsNL+INabVM6oKDv8vmWx9r0FYbsXpSVPBVy3MAyft11X5W+PtEqMPm6ycd2x3JmJcrD9p9ZFe0Qp8PhWvMUEPop5yuoc+wak1NV/BtzykgJk4mFnTPm/b38hwMeWY9rjG18HuEd4VmEhjjUPFhmPEkgFBXjLuuOZ//uZ5b1oWUBKu6yPGZ+3x0SsYHAvSVGQyzMxvNH/IfBy4L9rmRazbJj8ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLLZRbFiRdKgjhCo2OtesQ+8PQ3akA77xJyNVbMDPkw=;
 b=PknVfgybXUTfarjFq62JBX6tt8Oq28dLYw9lEgY9f7Am28assx7Oz1BLYPN+nZzAJFYuHAIrPu7PhNcImm4FojQe7Jxlfov5JyvmfjA5lNNfENBh4CtBTUgkzYLiRJYRLSULfieyEH/Q0SCAAqxV7vdjlyIqv0TkRembxek3GmOJN5Pikpm8GcXFaaW+dGKwBGclH0VXeX6xTBIjs6giRu3ZHIwqeBusrK/QD+mplJdeA4D4O+Vrk1vHF059NmEu7GhSd4PI6Ksn18W2T8LTThcfnBcwt49+oCPE03Ka49jRcuAiKQjT1RedbqIyQutICfy6vdZNVbZg8KWvCsVy8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLLZRbFiRdKgjhCo2OtesQ+8PQ3akA77xJyNVbMDPkw=;
 b=Q6igckgCbjF4smwiN7faemFS/5UqZFAFOhMSXxNVzQs069Ohve+PBhltS2Vew5szt/nDOcsDFW0+Fb7pYS9UEKdrh2TPLVzsnRAr62lOR8DbDBenWD39Z0RJz82/5JHnJO1LsPD1GcJhTSpCxk8/G2yR+GE5whLO5yETsvcUlNg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by VI0PR08MB10460.eurprd08.prod.outlook.com (2603:10a6:800:203::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Thu, 31 Jul
 2025 07:12:26 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.8989.013; Thu, 31 Jul 2025
 07:12:26 +0000
Message-ID: <9169f4a1-1ad3-4ef0-8d16-eabebfa64cf0@arm.com>
Date: Thu, 31 Jul 2025 12:42:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v5] arm64: Enable vmalloc-huge with ptdump
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: will@kernel.org, anshuman.khandual@arm.com, quic_zhenhuah@quicinc.com,
 ryan.roberts@arm.com, kevin.brodsky@arm.com, yangyicong@hisilicon.com,
 joey.gouly@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, david@redhat.com, mark.rutland@arm.com,
 urezki@gmail.com
References: <20250723161827.15802-1-dev.jain@arm.com>
 <aIpPsg1Kij8Knnjl@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <aIpPsg1Kij8Knnjl@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::7) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|VI0PR08MB10460:EE_|AMS1EPF00000049:EE_|DBBPR08MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: cd64e724-429e-42f6-e39c-08ddd001ae3f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?bUVjMG1uNVNWTEV5bDFBUHNYRnYxamFneXRCdnVQN2VFUklzKzNIT3V2b3B3?=
 =?utf-8?B?d0c2SjdPYWxaS1ZpN0NMTWJUZDRZMklpdlhGSlJ0akpyd2UzK1ZGUzR0MUR5?=
 =?utf-8?B?TlZPK0JXS0k3dVJNYjZhajJaQWV5cU1IUVlxdHd2OVRYUGdjTFgwUXJya0dF?=
 =?utf-8?B?RTFxWUtqcFZMMkxpZjloZHoyS3ZQeFYzWjZuT2J4UklMdlFlWGpseW9iRVNZ?=
 =?utf-8?B?Smo2MU9CYXd4VUorTE5XSTV4UzBvYk9seEVmNXlZRDEvNW5LcDJVVk5ScjUv?=
 =?utf-8?B?Z0dkS1Vwa3lZSGQ1QlRHL1M4aFhDdW1TMDdMYWdCSkQra1R0MVVhdXE5RnMx?=
 =?utf-8?B?RjRjUUJxa0xsWlNOdGdCUEtxUU04MXhkS2NFdE1GVHY3SEFFbXRHTEIvZ2Zq?=
 =?utf-8?B?d20reS9vM29hRTU5RUlmZUVJYlFQL1pXYUt2OWkweEhhQWVIM3BvTVFKQWJn?=
 =?utf-8?B?WFNTTWpsMjVZNmxNR1UxV080Zll2TEJxQ05PdEwyVmFXM1hrRGRkVytUb1U0?=
 =?utf-8?B?dHVCRzY0aWlkSTF6bXJQWGVyR2FkN01qYndDZXlqd2J3a0Evdkx6cW5PTVAr?=
 =?utf-8?B?eG9LYUNyMkc0WUp3MVFBd3BTV0paUUprVCtiYkdQWW15YWRET2daeVNaUXpa?=
 =?utf-8?B?cnlJcVZoQU9Wdk8wK2ZSWEtCLzV6SVYrUE5PTHV3cElCTktiK3kzUHMrZ0VT?=
 =?utf-8?B?OWdiTC85UnhmdEhiMUcrSUFBZXVrK1BNakcwZUxNY0h3bWlsalpDMDNid1dO?=
 =?utf-8?B?bGJWWWZxS1NGWmNvTmc4czdNZFVqTDZ5RWhiYnAwN2pxd3pvejh0TzJLRXJC?=
 =?utf-8?B?eVFid1I2Q1Via0JSNzFiTmJUU0NPNklhU3hjMlI1YzRxenRMYmNkVk1xaHpm?=
 =?utf-8?B?cDlOTUU5SWdqaE5vUnRpTWlIcWttM2EzWXcxSnRiN2F6bi9TaWlXZkROc2k3?=
 =?utf-8?B?SXdlbmNYNTlXMlNpcERRQndXNFNmZTVXSmVpMExVMjFRdWFSZ0xzNDZqWE5G?=
 =?utf-8?B?UlJFbTN4UlpTL2FmL2tWcW85WWZZbjN4UWxGWFZzQzJKTTNMODBYT3VRcTY5?=
 =?utf-8?B?SU5rK1c2ZWIyUWc3VkhDUlM5SXRESjRBb1QwUHpnSUlaSHRIZmlab0VyTk5x?=
 =?utf-8?B?TEh6R3lHM21xS0puZUlWVDRKTCtOZ0Q3eHdmZ3NoL2I4MHdmN0gwaElHQy9K?=
 =?utf-8?B?WXdwU0l3RW5hRmhscWwxVnoxZHVLOUxyQ3NsVmNybnlVdHh6UUhidlJoYXNT?=
 =?utf-8?B?Y055UmdBNGxhVTZMU3FsQ2F6QnMwMmt0NVh4MzAvNzZjM3VZWFRrSzl2UkpB?=
 =?utf-8?B?ZC9KUndvLzg4bUJuQlArSTFEVlBEdjR6U3pEVVJFa3dIbkFqTndWczN2UkpS?=
 =?utf-8?B?aEgreVZCR1Z4SDc2cUNSYk1lRmlNWFdmVkhJUjhGN29OL2VWMndhZC9scWp5?=
 =?utf-8?B?RUVqSlA0VHpsL1FoTmJYSVArbXBEMVpGcHJNeGZJUnB3MkVMN2pmTkJhNklx?=
 =?utf-8?B?R3dpdUl5Q091OXFnd0FEb01xWEQ1UFk0bGdVd1Z6dUUrZ3Y4QzRvSzhMRDcv?=
 =?utf-8?B?QWlEd2VFTVdDcW4xc3pMenlza1N0MVovNTRBN3NXc2tBakFKQTJYeE11bnZM?=
 =?utf-8?B?ckdoYmthMzV0QnJlbTBSOTdzc0VWVWR3V3RYRWxxdkZwb253NExjRVZZOXBR?=
 =?utf-8?B?cmd0SGd1K3AzQzNZRlc4VEcyem5vQkkvUjg0ZDkrYWNVYlhnejZQUlcyQzdl?=
 =?utf-8?B?QytkY3IrZGJKc1NEd0c5ZC9MSGFPM3pBbkduVUQvOUVxS1NVeHRaT2FIc2lv?=
 =?utf-8?B?aHduOFI3aUhpRmV3dzZMWDc1M0pzYUNFeWFFTGIrUGsveHNqRERpMXRUSU1F?=
 =?utf-8?B?UUFvN1ZGYzI1OTZhSHRsRDQ4QVdjWi9yOE84VEJRRXZXdEIvSGZFN2RpUUxm?=
 =?utf-8?Q?ZScCHHdgeqI=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10460
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000049.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ce4766a7-1f19-4c19-1e99-08ddd0019a8f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|35042699022|14060799003|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWhaY2FlYzVxdHlFN3h6YVFUVitPZFc2UkZXaEw5b0JlRndzdzdjYkFBd1l6?=
 =?utf-8?B?Qzh6U3dMaXl6YnB3WHNkbEw1dDBvUUppUHREaDZmai92NFoyb01Wbk9QOTMy?=
 =?utf-8?B?eDVLbnVnMVQ3dUVLemN1R3h0OXdGRG9ISUNIeXlrU1pwamNWQlViTzVmemJU?=
 =?utf-8?B?RjRia2g1cmZQekUzQnpYRmI2NHg5ZVVNcGJwSlNMRG96UjhvVElQREYyN0dt?=
 =?utf-8?B?aTJ1Mk4rc3EvOEFXWXBaQitYY2JxWXZIUmFWYWMwRFF6aVg0U3J6bklPZzUy?=
 =?utf-8?B?YWNaWkNKbDFvRUNrVHhYaHVzSjFWcjVtSHBqZnd1a1BHMjEwSlMvMThGY2VT?=
 =?utf-8?B?MFYwcXByd1dqMHh3dUM4U0tqcmp1d0oyRkJjakFzZ1lUQjdjUk1ST2F5eldu?=
 =?utf-8?B?MVRuaEdPdUt1OTFJS1hKVnBtemtRcmFBTHlyc3N5TTYxVjRjU1RuZmVQekNq?=
 =?utf-8?B?UzhTbzNhS1VVUVNQeGJaWWlyOWR1TFVBWElDbU41aEgwZmZxdEN4UEI4OGRU?=
 =?utf-8?B?RTllUi95bzEvZURoK3hMVjFhWWR3MGtGNG40QUdsUEt0cUhENEp2UlV6L1Z2?=
 =?utf-8?B?L2NhdUdBeVl6bmkzZDRmZHl3TFNTd3A3czI5cVhLb1FWUC9FN1RJVDBpNkpR?=
 =?utf-8?B?eHFEOFZ1OHZjVGprOTZacVNFa2NTR2Y0RFBLZ1k1Q0MzV2MxSUIycE1HUVJa?=
 =?utf-8?B?aHd6WVNjV2lKdnN5UXRvL0s3SFgvUGV0bS9wbFFhd3ArS1hzeVpyMDRDSzdz?=
 =?utf-8?B?YnBTY2NlYWd6UTgvcGZNY25Wd1ZJZGFkMWtiMWM0dmpWMzVvQ01WY3psM01w?=
 =?utf-8?B?Nzh4Rm9ZTkJvSTgrTHlZcStyN3NlS3hVV2gydjhzVjV2aytSaldBQitHd0w3?=
 =?utf-8?B?Y0NmajRWVU12bGlXdHNjbFpMaWlnZDZqZldQOHhsVFRGTUc4eHdTSUlPL3ZC?=
 =?utf-8?B?cU9tVUsza1FEVWpleWZmK2g3YzRNdVpxZkdpdm5icG5ZSXhCYktuQXNWNTdk?=
 =?utf-8?B?WWdXZHg3UkJKRGJSNlRNU1ExN01HRERMZXBObEpZSjZRRlljdmZvMklsK2Fi?=
 =?utf-8?B?MXpqUjNUNXo5QWhuWnRlMjRHcjgyRjZMdEdRTXZHOWVxT3ptS2NqYThreWti?=
 =?utf-8?B?UEsvWjhFZjJHN0VGMFUvYVRONzhXdjNFYW03cXQweUYrTzRiNEhQOGFIaVJi?=
 =?utf-8?B?WmovNXB4RjZjQzhaeUR2UEhRaWdyUmRBb01YNHNWbEd6djdKWGdDTmt3SXg2?=
 =?utf-8?B?R1dwYmtHY3RkOWg3eEh1TGUzc05FZXh5VTk4V2FKUTlDdjlFeVhwQzBWQklS?=
 =?utf-8?B?L2VoaFB0VUU3S2xUQXk5NGdZTS9LWDgrb0NRNFh3bDc2T29xREM5cjlGRlpU?=
 =?utf-8?B?eXVvTWplK29qV3VqWGpHTm0waUd0ZkpYT0xoRFJ6L3llaG1vSnlGR05Day9H?=
 =?utf-8?B?TGQ1dmFvMU5IQWRudjUwb0N6bTZsSW05UnNzUjNXaVFZeTVJZzBaeFdBcXNO?=
 =?utf-8?B?WVBwNTBHc3I2UHprM3hFaDJMY3ZkaFRKMkR1dXZYalp3em9vUyt0T2ZlUGNL?=
 =?utf-8?B?OTdpRHpzV3hIV0NoS09YcWJFV2t3V3BXeENXUTd2cWtYVzhoTXBnNzBSZTlV?=
 =?utf-8?B?eDNsOHBwTXIxREtUZnIzK294QzIyM2hPeGtyTGZmVFNvdFMzODB5NFdFR2t6?=
 =?utf-8?B?Y1hoNEpROFFvdEQ3ODk4U2V5ZlJzYzlNZVZXVUFkZUU4ekFIc1hDL21xREIx?=
 =?utf-8?B?aExVMnpiTkJvU2RFTmJ6MXZoZHQyK2xXekNsTmxlZmRTN1ozZ24xT1hTZ0ll?=
 =?utf-8?B?aDZ3QTI3TU9aWDdidjdRQ1RXc09TQ3FGY0xOS00ydEVkU3hsMFRtZ1dIWnc2?=
 =?utf-8?B?dThuYzFucTE4Z3VIcXZHaHp4UU52cWNGMmZjeVRGL0NOZlFmUXZMc1c4cWxj?=
 =?utf-8?B?KzVybmZpeTVDcDZQZmlYZnBYd3gwNFdWVDNwVzh3WlZqeUtFdjFRR1NFa3U3?=
 =?utf-8?B?Z0hzaVdYRnMxNWZmcTZieEljcldBQU5NV1A1NHVzUVlXQkwyMUtVd2VaWTB3?=
 =?utf-8?Q?QIIn43?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(35042699022)(14060799003)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 07:12:59.2457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd64e724-429e-42f6-e39c-08ddd001ae3f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000049.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6041


On 30/07/25 10:30 pm, Catalin Marinas wrote:
> On Wed, Jul 23, 2025 at 09:48:27PM +0530, Dev Jain wrote:
>> diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
>> index 12f534e8f3ed..e835fd437ae0 100644
>> --- a/arch/arm64/include/asm/vmalloc.h
>> +++ b/arch/arm64/include/asm/vmalloc.h
>> @@ -12,15 +12,13 @@ static inline bool arch_vmap_pud_supported(pgprot_t prot)
>>   	/*
>>   	 * SW table walks can't handle removal of intermediate entries.
>>   	 */
>> -	return pud_sect_supported() &&
>> -	       !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
>> +	return pud_sect_supported();
> Does the "SW table walks..." comment still make sense?

Anshuman pointed that out, I missed dropping that.

>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 00ab1d648db6..49932c1dd34e 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
> [...]
>> @@ -1301,16 +1319,76 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
>>   	}
>>   
>>   	table = pmd_offset(pudp, addr);
>> +
>> +	/*
>> +	 * Our objective is to prevent ptdump from reading a PMD table which has
>> +	 * been freed.  Assume that ptdump_walk_pgd() (call this thread T1)
>> +	 * executes completely on CPU1 and pud_free_pmd_page() (call this thread
>> +	 * T2) executes completely on CPU2. Let the region sandwiched by the
> I think "executes completely on CPU*" is confusing. Just talk about
> threads as they can be migrated between CPUs and the memory model is
> preserved.

Okay.

>
>> +	 * mmap_write_lock/unlock in T1 be called CS (the critical section).
>> +	 *
>> +	 * Claim: The CS of T1 will never operate on a freed PMD table.
>> +	 *
>> +	 * Proof:
>> +	 *
>> +	 * Case 1: The static branch is visible to T2.
>> +	 *
>> +	 * Case 1 (a): T1 acquires the lock before T2 can.
>> +	 * T2 will block until T1 drops the lock, so pmd_free() will only be
>> +	 * executed after T1 exits CS.
> This assumes that there is some ordering between unlock and pmd_free()
> (e.g. some poisoning of the old page). The unlock only gives us release
> semantics, not acquire. It just happens that we have an atomic
> dec-and-test down the __free_pages() path but I'm not convinced we
> should rely on it unless free_pages() has clear semantics on ordering
> related to prior memory writes.

I replied in the other mail to Ryan, hopefully that logic is satisfactory.

>
>> +	 *
>> +	 * Case 1 (b): T2 acquires the lock before T1 can.
>> +	 * The sequence of barriers issued in __flush_tlb_kernel_pgtable()
>> +	 * ensures that an empty PUD (via pud_clear()) is visible to T1 before
>> +	 * T1 can enter CS, therefore it is impossible for the CS to get hold
>> +	 * of the address of the isolated PMD table.
> Is this the effect of the barriers in the TLB flushing or the release
> semantics of the unlock?

Yeah you are right :) the release semantics of unlock guarantee that
an empty PUD will be observed before unlock, and the unlock
will have to happen before T1 can enter CS - the associativity leads us
to the conclusion.

>
>> +	 *
>> +	 * Case 2: The static branch is not visible to T2.
>> +	 *
>> +	 * Since static_branch_enable() (via dmb(ish)) and mmap_write_lock()
>> +	 * have acquire semantics, it is guaranteed that the static branch
> Does static_branch_disable() have release semantics? I think it does via
> some atomic_cmpxchg() but it's worth spelling it out.

Yes it *should* have, but this proof is already getting complicated so I thought,
let's not mention anything which is not required in the reasoning of the proof :)

>
>> +	 * will be visible to all CPUs before T1 can enter CS. The static
> As I mentioned on a previous version, this visibility is not absolute.
> You could say that it will be observed by other CPUs before they observe
> the write_lock.

Hmm. I probably am bad at explaining all of this in English :)

>
>> +	 * branch not being visible to T2 therefore guarantees that T1 has
>> +	 * not yet entered CS .... (i)
>> +	 * The sequence of barriers via __flush_tlb_kernel_pgtable() in T2
>> +	 * implies that if the invisibility of the static branch has been
>> +	 * observed by T2 (i.e static_branch_unlikely() is observed as false),
>> +	 * then all CPUs will have observed an empty PUD ... (ii)
>> +	 * Combining (i) and (ii), we conclude that T1 observes an empty PUD
>> +	 * before entering CS => it is impossible for the CS to get hold of
>> +	 * the address of the isolated PMD table. Q.E.D
> OK, I nearly got lost. That's not a straightforward memory ordering with
> as we have instruction updates with ISB as part of the TLB flushing. I
> concluded last time I looked that this branch patching part works
> because we also have kick_all_cpus_sync() as part of the static branch
> update.
>
> Stepping back to a simpler model, let's say that the static key is a
> variable. I wrote this quick test for herd7 and the Linux kernel memory
> model (fairly easy to play with):
>
> -------------------------------------8<---------------------------------------
> C pte_free_ptdump
>
> (*
>   * $ cd tools/memory-model
>   * $ herd7 -conf linux-kernel.cfg path/to/pte_free_ptdump.litmus
>   *)
>
> {
> 	pmd = 1;				(* allocated pmd *)
> 	pte_page = 1;				(* valid pte page pointed at by the pmd *)
> }
>
> // pmd_free_pte_page()
> P0(spinlock_t *init_mm, int *ptdump_lock_key, int *pmd, int *pte_page)
> {
> 	WRITE_ONCE(*pmd, 0);			// pmd_clear()
> 	smp_mb();
> 	if (READ_ONCE(*ptdump_lock_key)) {	// static_branch() approximation
> 		spin_lock(init_mm);		// mmap_read_lock()
> 		spin_unlock(init_mm);		// mmap_read_unlock()
> 	}
> 	smp_mb();
> 	WRITE_ONCE(*pte_page, 0);		// pte_free_kernel()
> }
>
> // ptdump_walk_pgd()
> P1(spinlock_t *init_mm, int *ptdump_lock_key, int *pmd, int *pte_page)
> {
> 	int val;
> 	int page;
>
> 	WRITE_ONCE(*ptdump_lock_key, 1);	// static_branch_enable()
> 	smp_mb();
> 	spin_lock(init_mm);			// mmap_write_lock()
> 	val = READ_ONCE(*pmd);
> 	page = READ_ONCE(*pte_page);		// freed pte page?
> 	spin_unlock(init_mm);			// mmap_write_unlock()
> 	smp_mb();
> 	WRITE_ONCE(*ptdump_lock_key, 0);	// static_branch_disable()
> }
>
> exists(1:val=1 /\ 1:page=0)
> -------------------------------------8<---------------------------------------
>
> I sprinkled some necessary smp_mb() but in most cases we have
> release/acquire semantics. It does show that we need a barrier before
> the page freeing. We also need to acquire for enabling the static key
> and release for disabling it.
>
> Next step is to assess that replacing the static key variable read/write
> with code patching preserves the model.

Thanks for the litmus test!
I ran it and I get the same result. But I still cannot figure out where is the hole
in my proof. I think you raise an objection to Case 2:

T1:						T2:

WRITE_ONCE(*pmd, 0) : t1			WRITE_ONCE(*ptdump_lock_key, 1): t3
smp_mb() // flush_tlb_kernel_pgtable		cmpxchg(acquire write lock)
						smp_mb()
READ_ONCE(*ptdump_lock_key) = 0 : t2		val = READ_ONCE(*pmd) : t4
WRITE_ONCE(*pte_page, 0)			page = READ_ONCE(*pte_page)
						smp_mb()
						cmpxchg(release write lock)


Let t_i be the global timestamps of the execution of the labelled instructions
(note that each labelled instruction is atomic so assigning a timestamp makes sense).

The fact that we read ptdump_lock_key as 0 implies that
t2 < t3 ... (i)
Now,
t1 < t2 because of barrier (ii)
t3 < t4 because of barrier (iii)

So we conclude that t1 < t4, so val will be observed as 0.

Alright I am horribly confused now :)


>

