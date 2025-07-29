Return-Path: <linux-kernel+bounces-749397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C223EB14DBF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E393418940A0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1711128FA84;
	Tue, 29 Jul 2025 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nwqVuqvm";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nwqVuqvm"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010058.outbound.protection.outlook.com [52.101.84.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A796E2877CA
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.58
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753792510; cv=fail; b=qUckPum6f3AcmOZGwzJKJjL4hZfTw4lr1+THVvxtl/C8LdKneSnqC/7wRfFQyYhoC2tVM1PmyAuj8FqV6aOS8cY7EHxbfAeg36B/JTcEYb8RCQozh6k8cNAvEoX4e8ACI0sGjhtiUuLGYlE7adbhhnrwfvOU3EvqkWHR5JxUpGo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753792510; c=relaxed/simple;
	bh=EMY7oP1/pAdSOVGSm5cuFGt8jqACc3nBXjCQilHiRvg=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tC5QSPn9kuHoxLZ3yC25whfolcHeWjkAAqcNqzP5rm244P5+MfvPBsjeTzqhC8/Gi/p2bVrInm6oZTpC0/frYp9Hw6QtdE6VAyyde3OHZV/d4lcyBXsnIQDw8TnUQ60+fWCqew7Da/ljOEQZv6OrYy75JwUMxm0RoQuK7I4VMGY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nwqVuqvm; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nwqVuqvm; arc=fail smtp.client-ip=52.101.84.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Rk8CzAhxaE0C35HbV7ZM+FvD3pxpz0VBdx37P11etYRKl0HoUmB1OFlcDJjn5YFBtLB8Gh42Z83QEd5LD3pBBOH5ko+NzdWyZPvpZd12JAUgziLCKTFFh7b3qKaSebPE+GsWxAocS6038blrDpouQKlUXBj4lfmdpiXiUjlLdA51nJDQdbhMy+bDH2ELDuj+oyupzHs6iu6BXNxFy/IlJhLgwiEwrurxx5VXFmRLzgJhquvwlvub8P9fUZZRF+Sx6LArSHpGYmA1ggzGAc7+e/VXc2GcB4tUTH7vyNnHACNbmanQ4TqXpJJ4kKeGgfgyhqvTcUcsyKOxn4HzqyxLHw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qALDe+HJY/8IsSVrMxpGPZ19zcCPj0nTtQc3EzSPJ/s=;
 b=yzrN6pG3F/hTUuvq/KPlYKttmVGmEjem4PyFKc4x9Qp2Z0gYwAB6eLIONT5E9f/F+f56CtwKkMTxTXNx/zrCfNRKmqBpYscpGvOU3RGD1fvgpOtFFVlqAPn7sSh2tdJCFYVtmDIc3lZ845VjwrqybyAfU2oOfU2z/XLFGDtykc4nA1s2tFj3f7dL35Uox6fNkiK5z46KxRo5pR4+GAHr5sWkz0315TCY/o2YPnhHdFQKZ/YHYXFho4R2iclXhYJp370CRL/I0AhNLVlfzxieKipGaIwI3UTpJxuixV47t2XVJ9GDy6VDlT2LEDAS+KTnK3u19WlqKpmDqmDaWU0O0g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=os.amperecomputing.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qALDe+HJY/8IsSVrMxpGPZ19zcCPj0nTtQc3EzSPJ/s=;
 b=nwqVuqvmRMuBGRboM1AXIPC5xen4Z6nmhBLP60mTXq8PinO1X3Ikj3JQaeOCMlmAc07jbV6WsH2t0198T1tXdkep8ROLzkDhF4K4+QVlwI0WEzriW0sD6tGT5FNJfSu3XvAMVvBzxpi5Va5kWnsdJTQEteNPARUV10shNayARxM=
Received: from DU6P191CA0038.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::22)
 by AS2PR08MB9270.eurprd08.prod.outlook.com (2603:10a6:20b:59d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 12:35:04 +0000
Received: from DU2PEPF00028D11.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::54) by DU6P191CA0038.outlook.office365.com
 (2603:10a6:10:53f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Tue,
 29 Jul 2025 12:35:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D11.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.10
 via Frontend Transport; Tue, 29 Jul 2025 12:35:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxIQqkRqzGT0uT5u0oYN8wI5Pdx1bAZn1W/CVaPXWEwUMcbH2n8H5d1yYrTPOsE9KwJf/LNcC/BPdNHHkqwUbuvAj4R8E7QGdoZJsLdUn2bogOzhSEevU7sd8IuzlIU2kJ6gPSqHBsxRqtCtf0Ok32tPh2W6uNDDEcge1zAEwN9KnaPcxNpG63kwCWCv4sD2dEunhDxayod/gTc5cAD/RqSo0snRc32YtI99PSs6kmWgGNmG9f7gSoBuy6KkDSxttdWN4zPd3XsAouvRHy4DOTz3+83k30Detz3SeXYsdWH+/Kw9JDIuEIl35cDzOwa8n1Ye388sfoDekQB3y4JQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qALDe+HJY/8IsSVrMxpGPZ19zcCPj0nTtQc3EzSPJ/s=;
 b=ZO2eizWVR/krPk95ObikEvy+3ZpuUNGuIqzr0xd8J4GOw0Ih+q6b/uxKlX/W/bHQ/HRYqse98A5Sc7QXc2LBS9sLZLaQv9bYJxZAdYfrBZ/iBdFYTCCLUmc+LJqpeGgsVfalw2P4DppatYaW6WDRr07Nzy1at96jZn8h0z3Bs0m4lkVYstKnjB7ra3NbOH3wqDZOoZxpwUuyof5DKhOmqSn0Qr+mez+tt3PBGFOjszgK1bOVtWurSY9QclFPxjK+GT3p5vcfHctNMvAPrCKZcxs8vXW8KV71doBfr4XMJncz8FsGVX/cE7YOPpYjw5oCFy5+g6YtCepOtfV/Q2+uYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qALDe+HJY/8IsSVrMxpGPZ19zcCPj0nTtQc3EzSPJ/s=;
 b=nwqVuqvmRMuBGRboM1AXIPC5xen4Z6nmhBLP60mTXq8PinO1X3Ikj3JQaeOCMlmAc07jbV6WsH2t0198T1tXdkep8ROLzkDhF4K4+QVlwI0WEzriW0sD6tGT5FNJfSu3XvAMVvBzxpi5Va5kWnsdJTQEteNPARUV10shNayARxM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by GV1PR08MB8284.eurprd08.prod.outlook.com (2603:10a6:150:a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 12:34:31 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 12:34:31 +0000
Message-ID: <d9960dbc-376d-4d33-9334-e4eb546b69ae@arm.com>
Date: Tue, 29 Jul 2025 18:04:26 +0530
User-Agent: Mozilla Thunderbird
From: Dev Jain <dev.jain@arm.com>
Subject: Re: [PATCH 3/4] arm64: mm: support large block mapping when
 rodata=full
To: Yang Shi <yang@os.amperecomputing.com>, ryan.roberts@arm.com,
 will@kernel.org, catalin.marinas@arm.com, akpm@linux-foundation.org,
 Miko.Lenczewski@arm.com, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250724221216.1998696-1-yang@os.amperecomputing.com>
 <20250724221216.1998696-4-yang@os.amperecomputing.com>
Content-Language: en-US
In-Reply-To: <20250724221216.1998696-4-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::26) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|GV1PR08MB8284:EE_|DU2PEPF00028D11:EE_|AS2PR08MB9270:EE_
X-MS-Office365-Filtering-Correlation-Id: a3b8a81c-cd34-460c-a281-08ddce9c57d3
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Mm5uMnJsVTVsSmdBSG9YM1NpMUJlNDR0MkFHOHc4N1poNEp0djZ4bENFSG5S?=
 =?utf-8?B?UElRVzlJWEV4NDdlNVRaazdyd3hLUUU3d3UrSXJXd2hycGJLUGpMV1VqQ2U0?=
 =?utf-8?B?R1VOenFYVy84cE8zVXNOOXZUOEY2VEJ0cVpzQmp0N3JKRmFINThsUmx0THgw?=
 =?utf-8?B?VzdlL3FJckp1NW9ZQXdHSTh2OTFsL0l1SGxLcmZNRkJnRnVFUklDVlNMOUxP?=
 =?utf-8?B?YVNUeG9FdmJnRDVueklrY0ZyaUMyZXZ4TmVOODl0eWZsUWowZG5jMDEzT2tl?=
 =?utf-8?B?dEVpNGs4aTA4YWExZWwydVN4MXo1L2g3alg3dkZBRWI2b1RpOFhGQThhQnNB?=
 =?utf-8?B?ZUZLdmRwUElaVm9qSUoreGozZmhUbCtMQ1JkeklLUnQ2WFZScXN5THZVWS96?=
 =?utf-8?B?VWF1N2liY2ptV2ttYk1XcldmQ3V4MU5sQkdnZ3MwWlpka0RTbnRCd0cvbWo0?=
 =?utf-8?B?bmZwTWtxelA0cHVNaHZtSDlWcmZ1Nm1CeG8zaExwdTg5eXg3M0VkOUwrR2Nm?=
 =?utf-8?B?YkxvSFdDR1UzMWZWWWxiZjZ2d0xxZXRZOW5JRiszT3ovWkQrbEJyQXpKY1px?=
 =?utf-8?B?eXlRQnFQUWczMzdMK2Q0dnVxUS9YaUhYRWpaTndMVSs4ZGsrS01BZmFmTUta?=
 =?utf-8?B?TStnMitxN0p1eVdhQVNWWlI5UzBLT0tuTWE0K2lhaXdOM1ZHVFZTNE41WHNq?=
 =?utf-8?B?VTkzaC9sWDN4KzJxNlUrUGV0N1hFUDNlSDJtREFVVUtRSU9SZThSUldaTG5F?=
 =?utf-8?B?Q296S3dYUU5nM1ZzYnMrcDRZblZuWnkxbU9KdXc3d0k4TlMvcWszYThMVFAz?=
 =?utf-8?B?eVlGdUY0TXRmaWNGbTRodUxXSTdiZW1qZWtRNHV4TjFpbDhOQzQ3THptYjFE?=
 =?utf-8?B?OWFvcURKRk1aQThBTEYzcmpMUzI3T2VZSC83Ty85ZXN3aisvcXUwWXc0djFx?=
 =?utf-8?B?RE1oeXV6cERENHNQKzZJOXhSUTlDcmF3a1U5eUJBaCtRMW9pbE03MUowejRt?=
 =?utf-8?B?UVFyU2VIRGhDMVlLTm1SNXAvUGN0TGpIZW1xckNUamxLNjFiZStweEJWbHox?=
 =?utf-8?B?T1d0ZFgxa244dXgzWk9iNng3SlRKZWJWMng5MTc0ejNWUi9yb1V6anJPWStN?=
 =?utf-8?B?NmR3bUllaHJCcWFaRjlYN3BleTRYcFVWOUpuME9JWnBkcGJ4YmNTNzdOWDRt?=
 =?utf-8?B?SUN0dFVucVkrdTNyN3luUHBOZmlmYUpJTDRMOXU2UnRGV3NSRFhXWlVjOUZ0?=
 =?utf-8?B?eEVaa3pKb203MjI1ZzIrM0hOYlZCanE4TEdhOGtZcTBBSThQQ0hsb0szdytQ?=
 =?utf-8?B?ZmYwME9NVnl5YXBwd1gxQ0o4U0NjWm1TcjZ1eUVsbWc0NTI2eXNSR2dNMDFV?=
 =?utf-8?B?bG4rdUtobHZ3K0dhUGVlc2wwU3VJZjZFYjFsOFU1NW4yQS9ISkpjQVd6VFo2?=
 =?utf-8?B?OEppWGx5QWQ5bVVnZDhkSnhoc0NDSlNOaTN6citQbUR3bmt2ZExBN0pxUWNj?=
 =?utf-8?B?UDF1dndWSU5WNlhickhMUXVEd09xWlQ3d0hUT281bVVJVFh4cytCVnpFVjU5?=
 =?utf-8?B?RkU5bVF1emRBb0N2cDlHa1BOZzhRYVY1c0RJR3FtRHkrSGR5dTZPWktxV1Bp?=
 =?utf-8?B?azMrMHI0a1pqaWVLYkxVcHNjck0vZHhEVFQyaHROYVRLcXdDSm9IcFRmemhL?=
 =?utf-8?B?S1Zadm9xbFErNjNHVzlGVmRuS0xlejBPTmZvTGlLRzl3dVUzNTBQSVhIVFI0?=
 =?utf-8?B?OVZZTVE4aFpadHo4Z1RzTjNmbTVPYW16d09WZUE2K1VSbzc3eUpOSVRQeXZ0?=
 =?utf-8?B?WW1uMGhJcnNiUnZXdEhmQTBCOW1xS0hEY2VBQ2wwY1hZVXRyN3BkNU9PZXI3?=
 =?utf-8?B?ODhIRGlCMnBGWG02cEtNc0hvMHdHcVFlcDltWkhjUXZ4Znc9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8284
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8845dea9-e129-457e-03aa-08ddce9c4403
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|14060799003|36860700013|376014|35042699022|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UG5aNk9lOXNydDN3UGV4VDRsUWlyU1pGcG12L1JDZS80dWdzTmZkeDBSbTA3?=
 =?utf-8?B?amZwRHZWU3BBdkxhNTNyUkE1RjdEMk1QRllzR1FmS1BFTDMvbWNBeXVIUDhV?=
 =?utf-8?B?OXhIMEk1dzZvMzJYc0J4d3VNWFV1YjAwZDNPdExwUndaaCtVQlVNUVdzWmp2?=
 =?utf-8?B?RzVxK1dRSE0xbzlOZnJWdGRIUXlQRkJrY1F4T2RhWnNZeWVoSHUrSU1sMFVv?=
 =?utf-8?B?NVZSUklQN2JOS1Q5b1YrSEkxL1M0WklUdGRiSEhucC9CTGFFenNRai9XS0hv?=
 =?utf-8?B?TXZSTzY2ZUVtY2dTNThXS3JvU3JMVXVWMlFrbGpoSUV3a29oTWo3Q0JXWlM3?=
 =?utf-8?B?MTB3bUJrdkhDZ0JiWjFWaUtXdXpIWUQvSlF3d2w5RTNJU1MyS3dGUEtCU3ky?=
 =?utf-8?B?OGZVMzIza1F6c05RRWh0blVqSU5MWEwxUnU2RFpQYk9xSGwwNUorQ0FTanJN?=
 =?utf-8?B?TnZDWm5taHc0aTJmd055QlNrOHVUNVhvSCtuN0l1b3lPV1hjdkhwWE5PZHRB?=
 =?utf-8?B?eitTajNSMEpUYmk5dlZTclVMWWVud1BkeElabytGb1NjYWZFOUs0MzJoR294?=
 =?utf-8?B?ckcwU20zR1Q3L3Q2RTNEb1p3RmFCYkR1bjFzbXRRcEUrYUNmOUdyeG8vS1c1?=
 =?utf-8?B?bXo2ajdtcFd1Wk1VWG5PcEhaaHZnNUhwdzhqZ3l6bE10NFlEL2JLb0xzYlRH?=
 =?utf-8?B?dk1LNldSWXlQVE9hc2ZONFFONzIzZnU0UnB2Zm1xRFJGME9GNlQwRE9uMU5R?=
 =?utf-8?B?MFNIMzk5eU56Y3JLelUxWTgwTktSSlJEYzI5REhEVk0rMGxURkhVd1FpNG12?=
 =?utf-8?B?SFhYQ2pldjUrUE9KNmx6SWZ5Y3pKRjloMTVpTW9nZFZnRXJLQXZwSE9JYkoz?=
 =?utf-8?B?OHNoWDlUWkh5UkViVytnTzhTbFZSSk1xT3RrZW8rNU1ZaTFaRjViVms5RDBM?=
 =?utf-8?B?WDYxRXZiek9BU2UyTGdSWlhiQ3VDK3dMa0dKWkVjTnIwVzFwRENhbmIvTmJB?=
 =?utf-8?B?eXY5OVlhUWtlRHo3VXJMemhqRUl2T3NiTjlHaU54Sk5ISWtIQ0xBRmFDZFZ0?=
 =?utf-8?B?MDBnVWpQQy9LVSsrV2VTV3J1cVFFWm84S3d3M2JvUFowQjhHUjd5SHhlLzZ0?=
 =?utf-8?B?bDYySDVOZ0pTMmd3YXBkTlhVODlLQUNjWUtOOGlDRmptN2p0NCtsM0pSOHdG?=
 =?utf-8?B?L05ZR0h4MkxmTkRrcVB3a213SjlJYWR6UXJsM0NJdlo4ODFwOEJlNGxMK0ha?=
 =?utf-8?B?YmR3WC8rcG96OURrRFZpK0h5aG5VSlZIV2JXeTExYWN6Uk9oMmJZc3ZBM3Bq?=
 =?utf-8?B?c3FRSGtHeVhwQytKazNadXl0a3Z4aFRPSCs2VmxnU01TOWRCMUQ5TGFEdGVU?=
 =?utf-8?B?ZUhyVlUrcHFNRTA3ZVR3Z2c3Mk8wRUNicnREMVpONWpUK0JqZ3ZDQXNOTHdJ?=
 =?utf-8?B?NFltNjJJK2N2Nk1DYUJxZ3JjUVJhajdPRE1tOGVmVTRHYkV5YTc2N3EwSmZm?=
 =?utf-8?B?Tk40aHNhUlNkSitJNkxNZGtCRmlOMW1sRUhWdnMvakEyUHVGRmNpVWgxYlJV?=
 =?utf-8?B?enhnejVOalcwcmFiWGJvQzdlQzJ6M1Jpd3VYVGJpT3RGOFFWS0VrM1ZidDlX?=
 =?utf-8?B?UnNRdEZCVzVHV0x3LytPTDF3cmRBY2Q3dnh6dEoxbzNSc25QRG1lelJ1bFhJ?=
 =?utf-8?B?NmR4MUxleVJtUnY0YXNlaXliL1R5MUlGQkRVZ2Q1RUVVZ2w5N2F5dFJtS0tN?=
 =?utf-8?B?bUxDQ3NlaU9YRkJHdGFvN3UyTytmTHV2V2VhNUs3YUo1eWRkcG55WUJxckZ3?=
 =?utf-8?B?d1d2dis0dVM2UUpZM2hKdldDZXlRcWVmdS9PVEFKRGsyUWlaMDFvcFMvSFhi?=
 =?utf-8?B?N2R4Y3JIMjZoYTUwNEdzaEd1allNWFFsWVhBQXJ5NXhxM3VjYlpiclNqWXpS?=
 =?utf-8?B?MXI3RVArSmdudCtMeDRIaVRpVVZFc2NhL2NlOWJ1UXVoT2FOQ09KUmpxcmZI?=
 =?utf-8?B?QlZGY2U5RVY2Vkg0MHBKY1k1eE9Kb091OU5hVHNqZ1llQmhuSWRRU2dhV2oy?=
 =?utf-8?Q?tjwub0?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(14060799003)(36860700013)(376014)(35042699022)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 12:35:03.9142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b8a81c-cd34-460c-a281-08ddce9c57d3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9270


On 25/07/25 3:41 am, Yang Shi wrote:
> [----- snip -----]
>   
>   #ifdef CONFIG_ARM64_PAN
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 3d5fb37424ab..f63b39613571 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -480,6 +480,8 @@ void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
>   			     int flags);
>   #endif
>   
> +#define INVALID_PHYS_ADDR	-1
> +
>   static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
>   				       enum pgtable_type pgtable_type)
>   {
> @@ -487,7 +489,9 @@ static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
>   	struct ptdesc *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_ZERO, 0);
>   	phys_addr_t pa;
>   
> -	BUG_ON(!ptdesc);
> +	if (!ptdesc)
> +		return INVALID_PHYS_ADDR;
> +
>   	pa = page_to_phys(ptdesc_page(ptdesc));
>   
>   	switch (pgtable_type) {
> @@ -509,15 +513,29 @@ static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
>   }
>   
>   static phys_addr_t __maybe_unused
> -pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
> +split_pgtable_alloc(enum pgtable_type pgtable_type)
>   {
>   	return __pgd_pgtable_alloc(&init_mm, pgtable_type);
>   }
>   
> +static phys_addr_t __maybe_unused
> +pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
> +{
> +	phys_addr_t pa;
> +
> +	pa = __pgd_pgtable_alloc(&init_mm, pgtable_type);
> +	BUG_ON(pa == INVALID_PHYS_ADDR);
> +	return pa;
> +}
> +
>   static phys_addr_t
>   pgd_pgtable_alloc_special_mm(enum pgtable_type pgtable_type)
>   {
> -	return __pgd_pgtable_alloc(NULL, pgtable_type);
> +	phys_addr_t pa;
> +
> +	pa = __pgd_pgtable_alloc(NULL, pgtable_type);
> +	BUG_ON(pa == INVALID_PHYS_ADDR);
> +	return pa;
>   }
>   
>   /*
> @@ -552,6 +570,254 @@ void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
>   			     pgd_pgtable_alloc_special_mm, flags);
>   }
>   
> +static DEFINE_MUTEX(pgtable_split_lock);

Thanks for taking a separate lock.

> +
> +static int split_cont_pte(pmd_t *pmdp, unsigned long addr, unsigned long end)
> +{
> +	pte_t *ptep;
> +	unsigned long next;
> +	unsigned int nr;
> +	unsigned long span;
> +
> +	ptep = pte_offset_kernel(pmdp, addr);
> +
> +	do {
> +		pte_t *_ptep;
> +
> +		nr = 0;
> +		next = pte_cont_addr_end(addr, end);
> +		if (next < end)
> +			nr = max(nr, ((end - next) / CONT_PTE_SIZE));
> +		span = nr * CONT_PTE_SIZE;
> +
> +		_ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * CONT_PTES);
> +		ptep += pte_index(next) - pte_index(addr) + nr * CONT_PTES;
> +
> +		if (((addr | next) & ~CONT_PTE_MASK) == 0)
> +			continue;
> +
> +		if (!pte_cont(__ptep_get(_ptep)))
> +			continue;
> +
> +		for (int i = 0; i < CONT_PTES; i++, _ptep++)
> +			__set_pte(_ptep, pte_mknoncont(__ptep_get(_ptep)));
> +	} while (addr = next + span, addr != end);
> +
> +	return 0;
> +}
> +
> +static int split_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end)
> +{
> +	unsigned long next;
> +	unsigned int nr;
> +	unsigned long span;
> +	int ret = 0;
> +
> +	do {
> +		pmd_t pmd;
> +
> +		nr = 1;
> +		next = pmd_addr_end(addr, end);
> +		if (next < end)
> +			nr = max(nr, ((end - next) / PMD_SIZE));
> +		span = (nr - 1) * PMD_SIZE;
> +
> +		if (((addr | next) & ~PMD_MASK) == 0)
> +			continue;
> +
> +		pmd = pmdp_get(pmdp);
> +		if (pmd_leaf(pmd)) {
> +			phys_addr_t pte_phys;
> +			pte_t *ptep;
> +			pmdval_t pmdval = PMD_TYPE_TABLE | PMD_TABLE_UXN |
> +					  PMD_TABLE_AF;
> +			unsigned long pfn = pmd_pfn(pmd);
> +			pgprot_t prot = pmd_pgprot(pmd);
> +
> +			pte_phys = split_pgtable_alloc(TABLE_PTE);
> +			if (pte_phys == INVALID_PHYS_ADDR)
> +				return -ENOMEM;
> +
> +			if (pgprot_val(prot) & PMD_SECT_PXN)
> +				pmdval |= PMD_TABLE_PXN;
> +
> +			prot = __pgprot((pgprot_val(prot) & ~PTE_TYPE_MASK) |
> +					PTE_TYPE_PAGE);
> +			prot = __pgprot(pgprot_val(prot) | PTE_CONT);
> +			ptep = (pte_t *)phys_to_virt(pte_phys);
> +			for (int i = 0; i < PTRS_PER_PTE; i++, ptep++, pfn++)
> +				__set_pte(ptep, pfn_pte(pfn, prot));
> +
> +			dsb(ishst);
> +
> +			__pmd_populate(pmdp, pte_phys, pmdval);
> +		}
> +
> +		ret = split_cont_pte(pmdp, addr, next);
> +		if (ret)
> +			break;
> +	} while (pmdp += nr, addr = next + span, addr != end);
> +
> +	return ret;
> +}
> +
> +static int split_cont_pmd(pud_t *pudp, unsigned long addr, unsigned long end)
> +{
> +	pmd_t *pmdp;
> +	unsigned long next;
> +	unsigned int nr;
> +	unsigned long span;
> +	int ret = 0;
> +
> +	pmdp = pmd_offset(pudp, addr);
> +
> +	do {
> +		pmd_t *_pmdp;
> +
> +		nr = 0;
> +		next = pmd_cont_addr_end(addr, end);
> +		if (next < end)
> +			nr = max(nr, ((end - next) / CONT_PMD_SIZE));
> +		span = nr * CONT_PMD_SIZE;
> +
> +		if (((addr | next) & ~CONT_PMD_MASK) == 0) {
> +			pmdp += pmd_index(next) - pmd_index(addr) +
> +				nr * CONT_PMDS;
> +			continue;
> +		}
> +
> +		_pmdp = PTR_ALIGN_DOWN(pmdp, sizeof(*pmdp) * CONT_PMDS);
> +		if (!pmd_cont(pmdp_get(_pmdp)))
> +			goto split;
> +
> +		for (int i = 0; i < CONT_PMDS; i++, _pmdp++)
> +			set_pmd(_pmdp, pmd_mknoncont(pmdp_get(_pmdp)));
> +
> +split:
> +		ret = split_pmd(pmdp, addr, next);
> +		if (ret)
> +			break;
> +
> +		pmdp += pmd_index(next) - pmd_index(addr) + nr * CONT_PMDS;
> +	} while (addr = next + span, addr != end);
> +
> +	return ret;
> +}
> +
> +static int split_pud(p4d_t *p4dp, unsigned long addr, unsigned long end)
> +{
> +	pud_t *pudp;
> +	unsigned long next;
> +	unsigned int nr;
> +	unsigned long span;
> +	int ret = 0;
> +
> +	pudp = pud_offset(p4dp, addr);
> +
> +	do {
> +		pud_t pud;
> +
> +		nr = 1;
> +		next = pud_addr_end(addr, end);
> +		if (next < end)
> +			nr = max(nr, ((end - next) / PUD_SIZE));
> +		span = (nr - 1) * PUD_SIZE;
> +
> +		if (((addr | next) & ~PUD_MASK) == 0)
> +			continue;
> +
> +		pud = pudp_get(pudp);
> +		if (pud_leaf(pud)) {
> +			phys_addr_t pmd_phys;
> +			pmd_t *pmdp;
> +			pudval_t pudval = PUD_TYPE_TABLE | PUD_TABLE_UXN |
> +					  PUD_TABLE_AF;
> +			unsigned long pfn = pud_pfn(pud);
> +			pgprot_t prot = pud_pgprot(pud);
> +			unsigned int step = PMD_SIZE >> PAGE_SHIFT;
> +
> +			pmd_phys = split_pgtable_alloc(TABLE_PMD);
> +			if (pmd_phys == INVALID_PHYS_ADDR)
> +				return -ENOMEM;
> +
> +			if (pgprot_val(prot) & PMD_SECT_PXN)
> +				pudval |= PUD_TABLE_PXN;
> +
> +			prot = __pgprot((pgprot_val(prot) & ~PMD_TYPE_MASK) |
> +					PMD_TYPE_SECT);
> +			prot = __pgprot(pgprot_val(prot) | PTE_CONT);
> +			pmdp = (pmd_t *)phys_to_virt(pmd_phys);
> +			for (int i = 0; i < PTRS_PER_PMD; i++, pmdp++) {
> +				set_pmd(pmdp, pfn_pmd(pfn, prot));
> +				pfn += step;
> +			}
> +
> +			dsb(ishst);
> +
> +			__pud_populate(pudp, pmd_phys, pudval);
> +		}
> +
> +		ret = split_cont_pmd(pudp, addr, next);
> +		if (ret)
> +			break;
> +	} while (pudp += nr, addr = next + span, addr != end);
> +
> +	return ret;
> +}
> +
> +static int split_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end)
> +{
> +	p4d_t *p4dp;
> +	unsigned long next;
> +	int ret = 0;
> +
> +	p4dp = p4d_offset(pgdp, addr);
> +
> +	do {
> +		next = p4d_addr_end(addr, end);
> +
> +		ret = split_pud(p4dp, addr, next);
> +		if (ret)
> +			break;
> +	} while (p4dp++, addr = next, addr != end);
> +
> +	return ret;
> +}
> +
> +static int split_pgd(pgd_t *pgdp, unsigned long addr, unsigned long end)
> +{
> +	unsigned long next;
> +	int ret = 0;
> +
> +	do {
> +		next = pgd_addr_end(addr, end);
> +		ret = split_p4d(pgdp, addr, next);
> +		if (ret)
> +			break;
> +	} while (pgdp++, addr = next, addr != end);
> +
> +	return ret;
> +}
> +
> +int split_kernel_pgtable_mapping(unsigned long start, unsigned long end)
> +{
> +	int ret;
> +
> +	if (!system_supports_bbml2_noabort())
> +		return 0;
> +
> +	if (start != PAGE_ALIGN(start) || end != PAGE_ALIGN(end))
> +		return -EINVAL;
> +
> +	mutex_lock(&pgtable_split_lock);
> +	arch_enter_lazy_mmu_mode();
> +	ret = split_pgd(pgd_offset_k(start), start, end);
> +	arch_leave_lazy_mmu_mode();
> +	mutex_unlock(&pgtable_split_lock);
> +
> +	return ret;
> +}
> +
>   	/*

--- snip ---

I'm afraid I'll have to agree with Ryan :) Looking at the signature of split_kernel_pgtable_mapping,
one would expect that this function splits all block mappings in this region. But that is just a
nit; it does not seem right to me that we are iterating over the entire space when we know *exactly* where
we have to make the split, just to save on pgd/p4d/pud loads - the effect of which is probably cancelled
out by unnecessary iterations your approach takes to skip the intermediate blocks.

If we are concerned that most change_memory_common() operations are for a single page, then
we can do something like:

unsigned long size = end - start;
bool end_split, start_split = false;

if (start not aligned to block mapping)
	start_split = split(start);

/*
  * split the end only if the start wasn't split, or
  * if it cannot be guaranteed that start and end lie
  * on the same contig block
  */
if (!start_split || (size > CONT_PTE_SIZE))
	end_split = split(end);




