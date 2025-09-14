Return-Path: <linux-kernel+bounces-815735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86162B56A76
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 18:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D62337AD497
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 16:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22F22D9ECA;
	Sun, 14 Sep 2025 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="R6D2Rgv2";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="R6D2Rgv2"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013001.outbound.protection.outlook.com [52.101.83.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AF01D9324
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.1
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757866640; cv=fail; b=DMVLfHQpxhSuTl9g1/VfWNAIinlfRcWAU7VWghnS2+F3shbwhCPqte4GUPRKiUCssG2N96TlEOPR4cN+vZhoVH0l7YugGAOcxSn7MfJToZWi8SLzWyK51nSRLbLc73MhVMt1EoTPqAj81+YX3h6DIUepF3BKAvhhEF9YloweOBQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757866640; c=relaxed/simple;
	bh=q7gxR42Z379yG8W4PCmxKzxfsqeLTP6ozs6kziIJMZE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cu2hl36XAYBc8TrNNDIGcfgrTGI2QBX+X7/CpRVW7du2qaLIg2zUhbBfPXL/N2fbXfYewVRUKW1/brdoYQRZtxmaxyZcPr/BDJo6+nwrtc1GVy/Of7Hj6P5jRe2Fx3pKCeBfKgYFanoIDZECrvHOguk/H9DD11A4UB29YLeeb/4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=R6D2Rgv2; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=R6D2Rgv2; arc=fail smtp.client-ip=52.101.83.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=AiLQdNTbwfbvGzbfkYd3AnMl1KnM3q+MthCRJDOMWULTmOSe41Ktez/A2l2SULgm820HgPLHdFjW6CvtI0GW2FQgNRjy7mdJWl7G0frdztq+wkJNY846Mv/29iPzrS0xv5GR38xP0D26W0vfbxEbeAxqXeCuAEVS7j6f3dHt/O08pJ8ux9ZlmOVrEusqa8xF7D7DfFtDKYra6/A35DoZ0z1tdMpVXwwnJ2SjKbHvalYEnny6RjY/fyAQ916lsbZNjvpZphhK4KaW9dBrAug+8BwOYDCK2jnE7Thzu5mL5MOR3mNDat3S3nk27MpCdKdYgFzQRTP4Cl5jH0Gi62hITA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEcX3EOHm29MDxZcH9EHhUBQpC5KNh9maRZJeM1Y+iM=;
 b=Gc3xBmEyIfJKbg85F+Sgj8NTodB1OY5rEXq7I0ZwHZHWIEmnS7EciCUMwtm+709pt6ohKlXXz5xDpVs0AtJDg7FDkqP9rJo8pyKMCLIafGPhvSro/OS5LhRnd/e8cZetl+B5qcb+cQGM1Nd4UqDisrrKacqbPc/5qAzgCDQpZRkZSFq0WqLlPTBvcqhNiw4X0FRyBnVva7CZeGKXIrR1lGG2qLyK2wZiZeZ2XyLIlwPHzWgT2VXyYdkxJhXF0sk1vOtcgKicUfSxeA56WmZfLNuiTU6KL38hJUKDHjcnOOa0ka1oXOgJmJDZ+5XFuHX/3r32m/9tInQ0BYZf3BqvnA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.dev smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEcX3EOHm29MDxZcH9EHhUBQpC5KNh9maRZJeM1Y+iM=;
 b=R6D2Rgv2i8BumhrPLinQIJWicI7WBTuhKx7f8VT8Xj4bEKjDJqzHkq9ROpblX1KFSNONlB9NsHA2tUBiPVY4N0Z32zKqi1lpUswwpKDI+rdJkapA+GZgxjAYbHCpmSaZQjXyeZinC4U1tDdI3unovnqmD7ZYiJRa2dWm8b/77ts=
Received: from DUZPR01CA0011.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::19) by VI1PR08MB5405.eurprd08.prod.outlook.com
 (2603:10a6:803:12f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Sun, 14 Sep
 2025 16:17:07 +0000
Received: from DB5PEPF00014B90.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::a0) by DUZPR01CA0011.outlook.office365.com
 (2603:10a6:10:3c3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Sun,
 14 Sep 2025 16:17:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B90.mail.protection.outlook.com (10.167.8.228) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Sun, 14 Sep 2025 16:17:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pEceh9Y/26DERRhvCvBES+k7F2bSQa4lnMeLKOMlAaIc5A+wPzRcLQG/PHP3OEcibPGqzixDOZ806Nkps8tLu2/+SN1vTJBYSCY4pw4L0MektVwigSYQsJtTuHynDvM/AigKMK7s+zYOZNplhCW0RBdKSClPvbD6J0Xjs9r1m4dlp7FFOulKg9GEBMJpXopaYU738f64dz9haInjsaexyMRCl//DzzAAbLnweF8X/TB2SUWtIVv5QIQQkvosm34Kdv64/QAdn/k53gZIzrZ3+F62aLhS4GnZTRVJfFbmh/T7xSTW8L2nlMsIsz1whOuVihFPBh215iVU5NC43peYDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEcX3EOHm29MDxZcH9EHhUBQpC5KNh9maRZJeM1Y+iM=;
 b=JgqbtpTIJ6cWlz+NUF2EkWgufyioehcBrQ5ltFnNID/G8GkK1OdylxyWkPhMza3PiNP9TtU0esmy0pwsYSIwHNZ5F5h9A9Ss6zxymJWNX4cWeMcOWJCArOk37Xn7RKiedxODUKvLrZCtSBMKdFgVcq1X1/lBVD++kvijrjNYVfM+baTL+tJFAgVXClltmKp+feStbQETFX9P84uqsADn4FHlOlWxgeI9u+MZDMEkvn2VDRu2YCm3Pjj3wPdECEMHQgY2V+6QlqRqpraGHVwsr+xc4OQysXqdag6Yi/2IyXBIPTagIpQVXplc+VVOduWHBJOZD1xMAOKJ9sxI63GHGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEcX3EOHm29MDxZcH9EHhUBQpC5KNh9maRZJeM1Y+iM=;
 b=R6D2Rgv2i8BumhrPLinQIJWicI7WBTuhKx7f8VT8Xj4bEKjDJqzHkq9ROpblX1KFSNONlB9NsHA2tUBiPVY4N0Z32zKqi1lpUswwpKDI+rdJkapA+GZgxjAYbHCpmSaZQjXyeZinC4U1tDdI3unovnqmD7ZYiJRa2dWm8b/77ts=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by PAVPR08MB8847.eurprd08.prod.outlook.com (2603:10a6:102:2fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Sun, 14 Sep
 2025 16:16:33 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.9094.021; Sun, 14 Sep 2025
 16:16:33 +0000
Message-ID: <a62b7461-3faf-494c-bd00-0206de184a5a@arm.com>
Date: Sun, 14 Sep 2025 21:46:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new 1/3] mm/khugepaged: skip unsuitable VMAs earlier in
 khugepaged_scan_mm_slot()
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 david@redhat.com, lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250914143547.27687-1-lance.yang@linux.dev>
 <20250914143547.27687-2-lance.yang@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250914143547.27687-2-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::24)
 To AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|PAVPR08MB8847:EE_|DB5PEPF00014B90:EE_|VI1PR08MB5405:EE_
X-MS-Office365-Filtering-Correlation-Id: 989e2143-ffc7-46a9-2a34-08ddf3aa25fc
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?bE5KRDNBUmNzbzBmZTNYeWZjSFI2YmNNNWJOSmdEQkl4MjFZeXV6OThQa2JG?=
 =?utf-8?B?RjF2ZzFrT0hRamt3OVJudEovUE8wcXpXNUJQclNvekNDTXhtNCtkdWRMSm1o?=
 =?utf-8?B?Sjcxb2gvdTdiNlh6bExWM0ZWWVBhcWhtVmFCQXpqWHgxMDBFTlk3NEdmaE1Z?=
 =?utf-8?B?RkRFRzFTZUNuRTBucjh0cCtWWkMvdG5GNUgrTzNKQTU0UVJZbFVuVEllTDU0?=
 =?utf-8?B?dTBTdHRjb3hubVZVdUhSTFY2MlVXVVplYWlTTlI1SkRZRHJDQ0RENjF4cXJF?=
 =?utf-8?B?NjhRdDdaNUZPalJDSWpzaHdSZFh2Wll5TnRHU2haRnQ1OUFOZ1VlVnNGa1hN?=
 =?utf-8?B?VUdHYlRBdDlwT0hiWkZGOHdSREFYNXU5L1ViclhQejBWaWFXRitDYUV0VERK?=
 =?utf-8?B?MnpUeUZGRnV2V3p4SzNFSDJuTUVKNEVIODl1Sm1YdWNKSnVVTkhtdHlEeDBN?=
 =?utf-8?B?d3BUWWswM3lBUGQwTW0wYnRVVmZDMmlHL1dZWkNzclV1RkVLM3UrWFZrREJo?=
 =?utf-8?B?WmI3MkY3bFFEODhUYTVEdVpMbVhYNThSbnRiNVFVUHpPbld5U0U4S0JFdEk0?=
 =?utf-8?B?MFgyRUIraS9UdU1PT1N5cnowTGxFZXpxelJuQmlhcnhtMWpOSDlUM3dBMkRr?=
 =?utf-8?B?R3ZKd2gweVlESmNkUjlRUDNvOHBhbFVPLzRVVkxWeHZBNmQ2Z0xNRVZJY2c1?=
 =?utf-8?B?elFPWDk2YitpNE8ydFkzZjZGbm55bDBnaklIMHkyejhSVFN6d1g5eUFhZ1RO?=
 =?utf-8?B?SXVvUmRGZDF3bENJQkJjbnlITHZRbVY2WlIyR2g4TlFyK3l3TWR5bHdoOVFK?=
 =?utf-8?B?bkZGS2lEQkhvN1htNys1Y242aldkRnpsc2tvWkFGVVpPdWtkK2lyTUJ6NGZP?=
 =?utf-8?B?L2RzaXdhQUhkSVZiMzJaU29MbGdlOXJ1QXh5Z2RidUlJUHAyQWFpNUNCMG1x?=
 =?utf-8?B?M1ZVdlp5RTZpNzdBazZJWUJWMEFrMndYWEJYbVgxRUdPNms0TnNKbEk3dVdr?=
 =?utf-8?B?V0RJL2ZaQ3ZPTUZEMC9KUkh5SFNpZ1ZieUthNmNiOGNQSEdiUmR1YWt1dkZP?=
 =?utf-8?B?WXdtNmNhQjljc3JxWE5tR2hkTnlIa09hZm5Vak12WXVJQWtpdDZVNFp1K3hW?=
 =?utf-8?B?dmw3WFVsbE5nTTd0L2p2VTd5UlhTOGZmNXVzNmlCekVlaXM3SjE1ZW00dTU0?=
 =?utf-8?B?cHhSODhjakNrNDJJM2E1K3pkUXJCU2Q4c3BKSXpaOFdxZzdjcjZRanJ2MzJw?=
 =?utf-8?B?VHFRY05VeHNlT0hYeE5Rb1pRalFZSzVaMTdBUWc2eVRJYnFKUXVnUllyM1NZ?=
 =?utf-8?B?cDl0R05VV2JkWjdKdWp6eFdzWkhSQ2luejVoUEhpVEJUY04wL2d6bk0zbUMz?=
 =?utf-8?B?Uzd1aDNIbUZOYXYxQWg3UGRGZkJDUTZyRjNKSnVmZHVGSWpXTGhwVU5IS2Na?=
 =?utf-8?B?WXpjVmUvaXNzdmJ3cjBocEpjajM3U2NQUTRyZ0owVDBkUWxXbUxYMGE2SFRt?=
 =?utf-8?B?bU4wazdsaHlnRURmcVlyS2dCajNLRHlSeCtXeEdUTUxCT2FoenV2QjdwWlhF?=
 =?utf-8?B?LzRYM2hxSlkrMDMwaUFFOVQ2RmNvSGVwVTJDSjJxKzE1Q29FTHp1a1A0eklo?=
 =?utf-8?B?OVdUcVNEZTkvb3duZHkyMDVlNjM3UnRIWTRFN1QyQUtoVXNnYWk3R2dVbkVw?=
 =?utf-8?B?cSttekdRM2lKUGNDR2pVWnNFZXRwdlpIZjNPRFJPRU9iRXRLRGJXNnRmU0Ez?=
 =?utf-8?B?cXVTZ2RNeGc2bGJTMy9OZ201WDNpWkVCb2M5bmFTUWp1V1hIVEJKRHBMY3R1?=
 =?utf-8?B?cW5LeElPSEZtWGdrMm4xWEwvQXRkckw4S2xMUW14VXdpV1Y2THpObFdFbmV2?=
 =?utf-8?B?Vks5clBoY0REY2c4WWltSU9TaVRFTnlvSktqekhXSGVWRURRSHFOeTVKQlJo?=
 =?utf-8?Q?+4/Dg1KJj+8=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8847
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B90.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	abd68510-0e30-41d2-0813-08ddf3aa121f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|14060799003|1800799024|36860700013|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFg4cDdWUU54aWIvQ2dVM2V2WFd2RXZ4cmQ5cW1pOWRXMXRiMGw4d1UyL25w?=
 =?utf-8?B?emxWZWpNN2FjY2Q1bSsrbXIvMExiamxYUHFOWEp3TmFEN2EvQUtzd3NMOEh0?=
 =?utf-8?B?Y3VERVZHTU1DOE0yN2J1MENqcEFBSkVTUDE5OHhJZGZ0Ti9EOXVRcmg5VzRM?=
 =?utf-8?B?eWNWeTdSbitmcUdsWlAvN29JNmRyaWFteTFyKzR5SmFCTzlwSWdDYnFLMmVD?=
 =?utf-8?B?a1VZQ3lUc1Z3US8zSE5MTzNVVjhEZHJ4dmc5bmVtOCszdVdCS1pjQzRHY0t3?=
 =?utf-8?B?cXBxNFgwdzI0ZTdzQ2wxdUZ2Ly9TMCtqaDU0aUtkVnZNN1E1OW5tbHRpS1pY?=
 =?utf-8?B?QzdJUk9KTllrWDJ4ODd4TGRSeEZOYmJIU1FNSVpzem1FenFrNUlxdEdBTlRS?=
 =?utf-8?B?MEN5a01aOXUzVmJoaXNoQ0QyOXpTM09SOElJbU9NME1Qd0FLM3N0UVBFMFJY?=
 =?utf-8?B?V2tWelRnZDV3VTNwcU9ONG50WHVPQzZ6OWtPUURQSTQ4YVVyajFpR1h1ZjZL?=
 =?utf-8?B?UkZLRjJ3akxrNDJvSlh4ZWNxVHhpM3VONFU1Tk41dWF1cUlJb3h0dmR2ZjRr?=
 =?utf-8?B?SGZDSW1VYmp5MllvYng0ZWRyaXRFTk8wcTBZeWpmM3hJcHg2LzMzNWpFKzMy?=
 =?utf-8?B?ZWF6a1lwK0ZET2hVUi9sU2xzbndlUUZmM040UjVlb1ROaW9KNTVpV0tnMUJS?=
 =?utf-8?B?SDZTNVNtZ3VtSzE0VjlrelZJS2xyTnM3bWpHb2Vya0ZUbHV4bzNQNGh1a25O?=
 =?utf-8?B?UjF3c1VVVGVwSFA2NGpxdzFtTGxRVk13Q1Nhb1hJcWVOQVZnUXFzV045VXc1?=
 =?utf-8?B?WFdnRTl2cEFWV0VNZ01tQVg3c3l3WWg5ZzA0SjVRYUpTVmhmTjRDWE4rUlVM?=
 =?utf-8?B?NUlUem9ENC9UdjlDTmtlUkFucVFsNysvL3MxNmR6cXpDWnFPaFBMSEh5WkpE?=
 =?utf-8?B?SXVGTzIzU0YxR294NXB3c1pzVjFZZ2lKYzdPZDNiZlg4ckZXd1laNmVieTNV?=
 =?utf-8?B?L1FpUTNkeGdpbVgwTklKU1pVdUx2M2JpbFI0czJKSzM2UFZLTHlxRUdWMGpH?=
 =?utf-8?B?dGpyV2FBa1BMUjE4d3Z5N3VGSmorWUVhZUgvaStQaXVuSkdVSVd1UU92cDVK?=
 =?utf-8?B?S3JlT3JReC8zNDB3TEtVSGlxeURpV3BiYWNObDVra0F1OG5kWGtGRjVvTWlO?=
 =?utf-8?B?SUdCWWd0T081UkNMbXRlTWhQYnZYSVJDa0dEaGlMTUd0clMwSWZTVzdKdE1m?=
 =?utf-8?B?Umxvdi9FUFZBZXdHTkRjNmNHQUtoSGlrRUhDTldOeXMxVXZveUJRb0YxR3Zp?=
 =?utf-8?B?Y0pKTFVOOTBOWm9QbHdaWWdoL2JSY0tRUlFnWUpRNGZxb2xlVmlDR0Fac0pn?=
 =?utf-8?B?c09vK20rOVBIZE9vOGxoOTV0Vkpzb3k1SEhYdEhYVDdUbWFiWGpIa2dJekRr?=
 =?utf-8?B?bmdqT0k3a1ZqVjg1WDNxMkRzdWRNeExPcnNiSHNTQXRVNzNHamd5elo5aVBT?=
 =?utf-8?B?cUF3ZTF2SEVzZ1BINzJWdTUvY04rcVdwM2hQaldUMXgrNFZpV2thQ0cyY1RB?=
 =?utf-8?B?djc5TFpHeHl3SC9DM3pGVHNtRm5wZndaOXUrUno0NnJmQ0J1Q0hQSjBiRkIw?=
 =?utf-8?B?aG91eS9jY2VuaDdvc1RDOHVDeTB6UEcrQi9QdnBZVlVTd3ZRRDEvamlPV2pB?=
 =?utf-8?B?OGM1NWttSVpHWTBPbFVHMXE2djlSL2ZHMElPMWxKWGh6LzBlY3hNOHZYZ3BI?=
 =?utf-8?B?RVpPK29laVFkOENPOU9DTkw5ZFlabUNOSDhlR211alg0M1dEeFV0bENjODlB?=
 =?utf-8?B?cjZFVDhaUUhhRkdSd1BqeUZnbFdxb09sR1Y4UCtUN1N4SmtqenplWklSYk0z?=
 =?utf-8?B?TkRiUkVLb09jdmVqOE5lK3RDQmFHYlhYWnFuODBGU05wQis4SU1sZkU2Mk9n?=
 =?utf-8?B?dXBVSDhvVDRVVmhaQnYrbTlpajVKZzlTbkE5cEU1OHJ2NVQ2cUFnbldPdmhC?=
 =?utf-8?B?dGtwQTBBUW83ZVpCM0oyVmpUTlI5N3ZWUnNlUXBSOUFzOTArWW5qQW9UWXdj?=
 =?utf-8?Q?TtSPzc?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(14060799003)(1800799024)(36860700013)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2025 16:17:06.2765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 989e2143-ffc7-46a9-2a34-08ddf3aa25fc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B90.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5405


On 14/09/25 8:05 pm, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
>
> Let's skip unsuitable VMAs early in the khugepaged scan; specifically,
> mlocked VMAs should not be touched.
>
> Note that the only other user of the VM_NO_KHUGEPAGED mask is
>   __thp_vma_allowable_orders(), which is also used by the MADV_COLLAPSE
> path. Since MADV_COLLAPSE has different rules (e.g., for mlocked VMAs), we
> cannot simply make the shared mask stricter as that would break it.
>
> So, we also introduce a new VM_NO_THP_COLLAPSE mask for that helper,
> leaving the stricter checks to be applied only within the khugepaged path
> itself.
>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
>   include/linux/mm.h |  6 +++++-
>   mm/huge_memory.c   |  2 +-
>   mm/khugepaged.c    | 14 +++++++++++++-
>   3 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index be3e6fb4d0db..cb54d94b2343 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -505,7 +505,11 @@ extern unsigned int kobjsize(const void *objp);
>   #define VM_REMAP_FLAGS (VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP)
>   
>   /* This mask prevents VMA from being scanned with khugepaged */
> -#define VM_NO_KHUGEPAGED (VM_SPECIAL | VM_HUGETLB)
> +#define VM_NO_KHUGEPAGED \
> +	(VM_SPECIAL | VM_HUGETLB | VM_LOCKED_MASK | VM_NOHUGEPAGE)
> +
> +/* This mask prevents VMA from being collapsed by any THP path */
> +#define VM_NO_THP_COLLAPSE	(VM_SPECIAL | VM_HUGETLB)

VM_NO_KHUGEPAGED should then be defined as VM_NO_THP_COLLAPSE | VM_LOCKED_MASK | VM_NOHUGEPAGE.
But...

I believe that the eligibility checking for khugepaged collapse is the business of
thp_vma_allowable_order(). This functionality should be put there, we literally
have a TVA_KHUGEPAGED flag :)

>   
>   /* This mask defines which mm->def_flags a process can inherit its parent */
>   #define VM_INIT_DEF_MASK	VM_NOHUGEPAGE
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index d6fc669e11c1..2e91526a037f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -134,7 +134,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>   	 * Must be checked after dax since some dax mappings may have
>   	 * VM_MIXEDMAP set.
>   	 */
> -	if (!in_pf && !smaps && (vm_flags & VM_NO_KHUGEPAGED))
> +	if (!in_pf && !smaps && (vm_flags & VM_NO_THP_COLLAPSE))
>   		return 0;
>   
>   	/*
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 7c5ff1b23e93..e54f99bb0b57 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -345,6 +345,17 @@ struct attribute_group khugepaged_attr_group = {
>   };
>   #endif /* CONFIG_SYSFS */
>   
> +/**
> + * khugepaged_should_scan_vma - check if a VMA is a candidate for collapse
> + * @vm_flags: The flags of the VMA to check.
> + *
> + * Returns: true if the VMA should be scanned by khugepaged, false otherwise.
> + */
> +static inline bool khugepaged_should_scan_vma(vm_flags_t vm_flags)
> +{
> +	return !(vm_flags & VM_NO_KHUGEPAGED);
> +}
> +
>   int hugepage_madvise(struct vm_area_struct *vma,
>   		     vm_flags_t *vm_flags, int advice)
>   {
> @@ -2443,7 +2454,8 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>   			progress++;
>   			break;
>   		}
> -		if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUGEPAGED, PMD_ORDER)) {
> +		if (!khugepaged_should_scan_vma(vma->vm_flags) ||
> +		    !thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUGEPAGED, PMD_ORDER)) {
>   skip:
>   			progress++;
>   			continue;

