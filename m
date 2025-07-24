Return-Path: <linux-kernel+bounces-743666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D83B1018B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF7533B8DA4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0642264D7;
	Thu, 24 Jul 2025 07:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KUBg7i/n";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KUBg7i/n"
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012039.outbound.protection.outlook.com [52.101.71.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDB41FDA
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.39
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753341669; cv=fail; b=kHRy6aFlNC4oypXM3WgoqMZLaplF7d57XNDg2o6ZstCez/sqlkCXq7FfOiq/i17P2kiI05ShqboMwncVwhF5y4bqn0UDfolqfCX55cwrEmOAm7cj+nmfo4unhYr1CLQ9mUyE828mczFXth85yVYL/GaOB0hA+OZ/QmsE7CA4wp8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753341669; c=relaxed/simple;
	bh=SwiYuAnD8D8Z+4KK41GIK45aGOUGRfIUI3lX9GgdbEo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=semTQH5BuobwV1oNk2ESx2oOFHRVQJDeaQ6XL16rXbRYsFSy7uGA36molfLp8aG6r2KJl+flRBE5wLSOOjdIjAso5hhQmLw8tF0cA+yGbaLNS2Dh2UIIEFFOzk9/p7bdXw5Hah6rVT5OXCO4fAsLyqAtQYF2kOy7VffORozcKqs=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KUBg7i/n; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KUBg7i/n; arc=fail smtp.client-ip=52.101.71.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=W14IeIDAc2uK/sbmykn8aZZP03oOK7w2/QZJttbIjrnMylroqqT2L92yM2pwWXO51/wXN10CJGpCwE1ThMd3OGfMd80Dy+ponWX3S0h0iFzGVeuSf1ZVA/2GW+E0qBxR2XVcwl3jTNjEdsQsDzVgxQ4Yn7IMJzXc5ZHpWLxum6CQojc2dlT8oQELvpQ62KP/QxCO85TIHDwdlxV8zLs0oFbiNyaw4cJfAu21aOnUWTnAUIpLJZ1zUoiHWA426lN019WW7GLfX+luSziWgSMXPZymF8pYever1FBw7z2SWlEH2ohbLv+A99oWhqBJf4704GBAVzRVByEuHMWw59Cplw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZB4qdhXzYjeqnDCsOjFZcwlJXOdrgfltpHX6FMXSGo=;
 b=tN4F/SNQM+Txu9q26GkWpMNg/cxTMJo5Wc8o+zlOkmGRVlkwn5eA2nOK6dYMmjrC7kOJe+FYyttTPDWISiuABO9fyP6pGh26om57YRAJUTtYxksTz7SvaB1QvfGExdyTvPG8JDwCFw8wrlUEsgoXJm7OszEZK8WiIrBu1rO7VDQwnZ8B4LPVDP4/T7pfmTL/53uQd25YlEhHuh4lyJaJQrwPO0M5l1EZrySZN97tYw2vsouYXIYHuqr6MgGeWgECI3yaVBbzwjn1ezP9Xi6i2ffoLRylguobB4TMUa0eUzPQCYk8b2jbVNyCNPGoX66vecbZN6rKOGyTc5E1JAevFQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZB4qdhXzYjeqnDCsOjFZcwlJXOdrgfltpHX6FMXSGo=;
 b=KUBg7i/nF7oO5+3EfGO9b3Sh+TT/1eYhwCcWh01BJY6y+V6MLFLka3it+Z7j/7uj6EjCBxPJd5RIw4mrvSJXvIsbBgKZMYmE/EwFKuLZ6VLWqwM4T3d3L15ws0bfPyBaJi/qekrf+YeQET2CDAb4quG+GUwDn9Y67L8aRw46IIw=
Received: from DB7PR05CA0044.eurprd05.prod.outlook.com (2603:10a6:10:2e::21)
 by AM9PR08MB6674.eurprd08.prod.outlook.com (2603:10a6:20b:302::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 07:21:01 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:2e:cafe::df) by DB7PR05CA0044.outlook.office365.com
 (2603:10a6:10:2e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Thu,
 24 Jul 2025 07:21:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Thu, 24 Jul 2025 07:21:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1hxzW7BpY/fpfBClXu7h39U/worw59JuUvIs/exIEDSnsA12h8yRoWiBXbXohJnHvEdssckZFU/4wgrx9TYS4O7I+oKjGsdyeDZQ1wHCNnus5zBTVy4hvrTPg0ioHntVoJMHFaMecAO39n1KdttUQabEeVaK1ienJktcWgvl6qdK+8YMgRgaEOFGK8/Ubr989mQgZHx9EKYbII2/HqmERb6lHC90Zc0+JMzg/Ov56CiJccenXI0RGAx6HBEV+azfS17HsHUTqDeiigswBv0kHlwaVJpKGm3MYgQxw5uW8opWOh0ArvFVfJ+DKNq/hxFrW4drJ/FDb8NfLxuf//H3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZB4qdhXzYjeqnDCsOjFZcwlJXOdrgfltpHX6FMXSGo=;
 b=P5EoGCvGFfRGd/IZ21RqDi2C061t5A8AAfnRqyOnfSJGuff79IMZVGA8LYhxPXkcEFYX/OaRu8gdQdLBDdvVrJHrG8WnWI3FDm4MyJhXxEVkSDSE/b8hzx84z0i2F8cRxJD9IfrVsV71o3uQgadrR1Jfd/w6Sf/MMV20tLOp2W6ey0K77CgXFwe0ocE4ctbT4M8QJpc6OdRK+acgLpypBGlonjzG7UzFtA7C1nhOT0urXi1YFOqiqFPEPfvFpudhIzo6CyS521Ll0Pt85BlEAcFIfKnvaa28xNYMD4RMKXgTZwZAbVdvaPD00YFsJT2eofBfxDzVAyyYr95qDupCzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZB4qdhXzYjeqnDCsOjFZcwlJXOdrgfltpHX6FMXSGo=;
 b=KUBg7i/nF7oO5+3EfGO9b3Sh+TT/1eYhwCcWh01BJY6y+V6MLFLka3it+Z7j/7uj6EjCBxPJd5RIw4mrvSJXvIsbBgKZMYmE/EwFKuLZ6VLWqwM4T3d3L15ws0bfPyBaJi/qekrf+YeQET2CDAb4quG+GUwDn9Y67L8aRw46IIw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AM8PR08MB5730.eurprd08.prod.outlook.com (2603:10a6:20b:1d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 07:20:29 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 07:20:28 +0000
Message-ID: <4593d24e-2e90-484a-aaa8-b7211038c757@arm.com>
Date: Thu, 24 Jul 2025 12:50:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v5] arm64: Enable vmalloc-huge with ptdump
To: Anshuman Khandual <anshuman.khandual@arm.com>, catalin.marinas@arm.com,
 will@kernel.org
Cc: quic_zhenhuah@quicinc.com, ryan.roberts@arm.com, kevin.brodsky@arm.com,
 yangyicong@hisilicon.com, joey.gouly@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 david@redhat.com, mark.rutland@arm.com, urezki@gmail.com, Ash.Wilding@arm.com
References: <20250723161827.15802-1-dev.jain@arm.com>
 <90f56b8b-cc09-45c5-88d5-36d39a00ea14@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <90f56b8b-cc09-45c5-88d5-36d39a00ea14@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0176.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::11) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AM8PR08MB5730:EE_|DB1PEPF000509F1:EE_|AM9PR08MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: b1be4ddb-f6ec-4e7c-587a-08ddca82a481
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?a2xqTzFiWm41bHpieHp2ZXNVYk1QcEJMcEI4VlkvUllRSDlLM0M4OWo2Zjhu?=
 =?utf-8?B?bDlJUUNEMlZLNHhlbVMrRjFPZnRvS2l2ZXBZOTRKSnViaFpKZkNFVnk2eVVl?=
 =?utf-8?B?TU02Zlh4Z2VLaGJDUTA4T1d3WHlvVURZSnRlYzY0NENJckhHMUVkUmNEZlZw?=
 =?utf-8?B?ZnZLekZYUnVEc1Q4VkI5ZmNNYXZuL293aFdESGhwK2cwRjNJWS94RXdPTytP?=
 =?utf-8?B?MjhEY2ducU5KSis1czZkVVhGR0kzV0ROMXFWNTYyelhkVWlRN0ZJNTZwV3dh?=
 =?utf-8?B?SnkvOGZ2ZlVSTjR5QnpVd1RiSFJQeEpoUWxIVFpjN0krQWRZdjJjbFQvcVps?=
 =?utf-8?B?eEx4OVZ2RlRBc2kvenRsTzg4eHYrcU9lOU5takt6c0NieC93TnloUlpvcGtx?=
 =?utf-8?B?MVlMSGJrdkRkQ2tVbFc3QklFVWxpK2hmWVFnazc0TXZTd3ZzVkN4RGNUaHhn?=
 =?utf-8?B?Z1RwSXgyN0NxUE55ZUh2b3J2UUp4U1BjcklvN1VhWk9TSHJySDVLT1ErRWt1?=
 =?utf-8?B?SmttNm5qblQwemhyOVBJeUxRZzJjVmhTMG5BUXQ0SUJUS1hmZWVxSG02UXky?=
 =?utf-8?B?eHBlT2lFRTRubS9RNHRJOUhOWjZDWk1YUUVmUzdxa3ZLMWZXQmtUQ1J0MURt?=
 =?utf-8?B?OExQKzRMamh4dXlZZjRWS3hGNVk3RVMwTjNZN0ZnUFh0bVEwZUFUTDVRb0N6?=
 =?utf-8?B?VUVQdW9mdkZxQ2xyRGVLdUdxZUY5WHEvTTFwNDBtMnRmcjQrQVROcjcxd0tI?=
 =?utf-8?B?ay9mQVlSVStXeTJqaUtZczh5Mk9WUjA4WGYrOWM1eGl3MTN0Um9ULzlEN2NO?=
 =?utf-8?B?eGN6NnBTdS9oWlg0VjlMTmRIZGNqbU9qZDhoWjd0azFBMW94WG9RZmlQMFMv?=
 =?utf-8?B?ekNpNkhlbkJjZHM3eEFMdG9Lc25iVU9yUENIWTQ4NWNzZHEzNlhTbHF4c0lV?=
 =?utf-8?B?L05ST3F0ZzkyenRGWFY0cnJUc2tnRCtGZDNQeHpzMkxoME8xOUtmamRjNTFl?=
 =?utf-8?B?bDl6Qm0vMytUTlZpNnYwZU1Nd1ZKSDIwWUtmeE95c3JDcklBQWx6dG1zaGEx?=
 =?utf-8?B?MWliYjg3NVI1NnlnQ2x1Vmg3V0FBK0NjWVdLSVZlSmtrbzRKQSs2cVlXM1Yy?=
 =?utf-8?B?M3M2SlEwQWNicHNnL3g5RVYxZ0ZpYmVxUnRCSjJrM2RHWGtwWmR2bm10NmdW?=
 =?utf-8?B?MW9HTDhNNUV2akdJMC8yNGJha1o1bTc0MEFTYTlFMU44VHFIWEhWeXJnZWVK?=
 =?utf-8?B?MDlyQWdtc3daNGU0cVZCQkI4emQrNTF3TEZkQ1BwaG5WNUk3b2dnUCttQ0xU?=
 =?utf-8?B?SEc3OGtuUGFaaTBUVnFUNWlDSUNwVncrQjhTd01JTGNSQWNYTHN2eSs2dWRD?=
 =?utf-8?B?Y0dCakxZZVVONGgxTEJ0Wm8vTmxqZkIvS3RTUHhTcU15L3FxY25lVjRWVGdm?=
 =?utf-8?B?UlhHSDAwZEhnelowOHRMdnZLbFZidzllWGZSQW8zYVEySVZuT055bG5uTFN5?=
 =?utf-8?B?ajFDSGFKYXM0YS9hMXV2alVrNmZHOU1VWjRLWi83Q0NYaXNuOVh1RVAxck1Q?=
 =?utf-8?B?MHQzQkNxUmJ6aUtjN0FzakJVZUdEaGU0SzJTb0Z6bnVLaExBYjZQcDNjZHdP?=
 =?utf-8?B?RDg0a1ZDbE9veUdKRnNGaWRya2ZFNDczcnFDNFp3VjByZWhhRnRseVFMeExP?=
 =?utf-8?B?WER2bGRtdUF0eFFSdkpzOEZpZFVHbVFWVmpITlNkZnFUckpwQ3pOU2ViVmRn?=
 =?utf-8?B?SUl5RFRhNzZHekJSYTVDNGRMdjVCbXZtRisyU0VYY0d4MHlCOGVUMEdDeUdZ?=
 =?utf-8?B?OXlTQ28wOU5nSHlNQVZwME9DU2dBVENzR1dyeHFSeTRwSGE0dmhKa0ZBRWth?=
 =?utf-8?B?MW5Wb1ppdXFCSEdqUG1xTmphck1vR2tuOUphQUdjTGNqZ0FvTjdDcExqdWZj?=
 =?utf-8?Q?9GhWiMJo6S8=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5730
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0250679d-3609-4bbd-3981-08ddca8290f3
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|36860700013|376014|82310400026|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjN0L0F6Z0I3Q0pxVDlsTWlDZndhWjk4OFpBd0o4WXFCT3RZaVRnVGZaTGp3?=
 =?utf-8?B?NC9jSjFyMlArUVQ3dFE1YmJYMEE4bHdRVkd6dkdpWGJYd1V5M2NvQ20xL3V1?=
 =?utf-8?B?Z0YyeHprRHFqS0QzOVQ2ZHFSbmZqT3l1VHo5R2VjbS9aclJlZGV5c1pjWThH?=
 =?utf-8?B?UDZrS0xySFhtaXBHUksrSEtDUG1ZUTcxeVhVbTZBa0JBTU1oWi95a2x0Smts?=
 =?utf-8?B?NGFVQVRWaWppRmVHVk9QUGovTFVKVUltK0xVSDdFUVdyZzNseGJMb2h5N1Aw?=
 =?utf-8?B?L2dPbzJVOVBjM3ZXTThiYkNCZ0FWeDVPTUI1OVhtSWpaZHdyZXJVMDNvQ2lI?=
 =?utf-8?B?N0NYZU9CblNGVGtjS2VQUlcrWmhqWXZmR2NmNXhaKzVtTEg5V0hTZ0x6K2Fa?=
 =?utf-8?B?SnNVNEhpY0M0WmVjS0JFOUN0L295OTNaZHFjOFRHbGRkaHJRRE5jbW53OUww?=
 =?utf-8?B?UlBENjJOS2JvSXRMNlRnazdrSG1wVTl3Nm9LN3VGMkljczJXTjhiQXJEYm5w?=
 =?utf-8?B?QkFlcFZHZHBKNXR2UnFlRW9mWDkvSlBXRkUzT3lMeHdMZllSR3NpS2tyRXY0?=
 =?utf-8?B?UkIvVzNyckFUaHF3OVpkSEFia05ZbEgzVkRWK1h2Sk51dVpwdjNpa2hRcjRH?=
 =?utf-8?B?MGMxTU9LeUtZU1RmbGQrblVEZTIyTWVMa3hZRjRYNWxFLzhrMG5pOWJBT0p2?=
 =?utf-8?B?ZnhKdklGbW5sSVJyZ0YrMEVrRElKUXNJWFB6STJMbjdYRW4yVmRocjJiRVlx?=
 =?utf-8?B?WmFSaVBrbWhaczczdTFiZVJvbk92SGdkeHFTU0tGQmpkR2t0SU13OE93S0p6?=
 =?utf-8?B?ZWtpZFhQZkZNbGFvbVV1QnRmRlZESkU0OWovT2NhZkltS3MxZnlHdTd0S0dG?=
 =?utf-8?B?U3dBK1lYN2RhM1hUQVdWRVNEK25rS0J1WEVDcDRmcDYwaFFOTU5zalV6MFcy?=
 =?utf-8?B?cEhlMGc3L1p6N2loaU8wTVNZOFRtQkR4UUoyYUxYTm1nZCtQak54enp4YlIv?=
 =?utf-8?B?UVBsSlNVdG5COFNEL28rSzROMlVteHJTQzFVRC96ZUFHejVldUo5MzU3TFYr?=
 =?utf-8?B?aGk2dlExOTE1eXluL3BlTC9HWDIxcEZ5bUxZVU1QV0IxamdDTXBSSmpiNlp5?=
 =?utf-8?B?VmRHL2tzZ1VsK2dvei9wS21CZDVhN3FHcjVhQVhKR0FxL1oraXM4R0psNU5U?=
 =?utf-8?B?bkZNYlh6dys5ZXp2ZEVBbmVzT292WUhBSTU3UVl6N2RpY0lMSEw4b3RlblV5?=
 =?utf-8?B?U1I1WHpaM3ZWcDdlSXIzcVpNMW1MSTRPOGpJWGc4UDRyRFhnM3Y2K1VNTWpS?=
 =?utf-8?B?TmJ3Qk9YSkMybHlHMjZldHkzSGdtazk4NEFnaHczSFJuU2h0VWN4NVBkK2ZB?=
 =?utf-8?B?SHBzUmJpVFNlSW9BTHU2MmZpQVQvT2tLWUhtQ0xaaFFKNUhNak1QODRjU0li?=
 =?utf-8?B?ZmxaL2srSE45ZGtkSFkzVFBmS1FYRGJ5eEc2bWQ2UkE0aGdiYmh5R2s4S3k5?=
 =?utf-8?B?Wm9ENlk2dGN1bTIxRVhjUWhKK1ZzL2NxZlFCc2hEemFlclR5Yk0zeExGbDJp?=
 =?utf-8?B?ak13bS9menAycm5pQUlTVTRLanUrU3FOdEsydE1qZmJmTjUwWkVid0NvY1Y0?=
 =?utf-8?B?QTFnZnZRS1pkeFpWWkQ3bzdEVm4yTU01NHhRdkhPSDJJUGhLZlpST0I2SFpZ?=
 =?utf-8?B?ZDF1UVpXYUMrc3F1c2RoUUtTbXlHRzNaYS9WZ0JRK3RuQkJVM2ZiU3RGVXJF?=
 =?utf-8?B?b3crSitTV3dRYkxYZmRYZjV3MFlKMmZhaWVMYnZqZEdqQkhpME1tYzhtanN5?=
 =?utf-8?B?cVpBc0tCVGUxVEViTTd4aEt1djFwcVFHZy95ZGo5QjVCaUpoK2l0Q0NBYkw0?=
 =?utf-8?B?ZEVuZUNPZzd2MVNBRGpTakk0WmxlSzJteXdSc2tIeHlKRDlSaWNRRmFrZHhm?=
 =?utf-8?B?eHNmSjg4VUNwM0RzVE9wK3Zlc3IzM1BvM1J3Z1h3bDFuRTlrWTNwSjFnRlN1?=
 =?utf-8?B?ZnVvYkNkR29Sc21VejEzZDVnd2g0c2ZCaXVST2l2MEdpRk1qWGJ5a1E4NGxD?=
 =?utf-8?B?OHBVeWZjZXpsUk94dW4xeEREWlE0NkRIdXdTQT09?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(36860700013)(376014)(82310400026)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 07:21:00.9810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1be4ddb-f6ec-4e7c-587a-08ddca82a481
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6674

+ Ash Wilding. He may be interested in this patch because it concerns memory
barriers, and I always refer to his youtube video for this stuff : )


On 24/07/25 11:20 am, Anshuman Khandual wrote:
> A very small nit -
>
> arm64/mm: Enable vmalloc-huge with ptdump

Sure.

>
> On 23/07/25 9:48 PM, Dev Jain wrote:
>> Our goal is to move towards enabling vmalloc-huge by default on arm64 so
>> as to reduce TLB pressure. Therefore, we need a way to analyze the portion
>> of block mappings in vmalloc space we can get on a production system; this
>> can be done through ptdump, but currently we disable vmalloc-huge if
>> CONFIG_PTDUMP_DEBUGFS is on. The reason is that lazy freeing of kernel
>> pagetables via vmap_try_huge_pxd() may race with ptdump, so ptdump
>> may dereference a bogus address.
>>
>> To solve this, we need to synchronize ptdump_walk_pgd() with
>> pud_free_pmd_page() and pmd_free_pte_page().
>>
>> Since this race is very unlikely to happen in practice, we do not want to
>> penalize other code paths taking the init_mm mmap_lock. Therefore, we use
>> static keys. ptdump will enable the static key - upon observing that, the
>> vmalloc table freeing path will get patched in with an
>> mmap_read_lock/unlock sequence. A code comment explains in detail, how
>> a combination of acquire sematics of static_branch_enable() and the
> typo                       ^^^^^^^^ s/sematics/semantics

Thanks.

>
>> barriers in __flush_tlb_kernel_pgtable() ensures that ptdump will never
>> get a hold on the address of a freed PMD or PTE table.
>>
>> For an (almost) rigorous proof of correctness, one may look at:
>> https://lore.kernel.org/all/e1e87f16-1c48-481b-8f7c-9333ac5d13e7@arm.com/
>>
>> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>> Rebased on 6.16-rc7.
>>
>> mm-selfests pass. No issues were observed while parallelly running
>> test_vmalloc.sh (which stresses the vmalloc subsystem) and dumping the
>> kernel pagetable through sysfs in a loop.
>>
>> v4->v5:
>>   - The arch_vmap_pxd_supported() changes were dropped by mistake in between
>>     the revisions, add them back (Anshuman)
>>   - Rewrite cover letter, drop stray change, add arm64_ptdump_walk_pgd()
>>     helper, rename ptdump_lock_key -> arm64_ptdump_lock_key, add comment
>>     above __pmd_free_pte_page() to explain when the lock won't
>>     be taken (Anshuman)
>>   - Rewrite the comment explaining the synchronization logic (Catalin)
>>
>> v3->v4:
>>   - Lock-unlock immediately
>>   - Simplify includes
>>
>> v2->v3:
>>   - Use static key mechanism
>>
>> v1->v2:
>>   - Take lock only when CONFIG_PTDUMP_DEBUGFS is on
>>   - In case of pud_free_pmd_page(), isolate the PMD table to avoid taking
>>     the lock 512 times again via pmd_free_pte_page()
>>
>> ---
>>   arch/arm64/include/asm/ptdump.h  |  2 +
>>   arch/arm64/include/asm/vmalloc.h |  6 +--
>>   arch/arm64/mm/mmu.c              | 86 ++++++++++++++++++++++++++++++--
>>   arch/arm64/mm/ptdump.c           | 11 +++-
>>   4 files changed, 95 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
>> index fded5358641f..baff24004459 100644
>> --- a/arch/arm64/include/asm/ptdump.h
>> +++ b/arch/arm64/include/asm/ptdump.h
>> @@ -7,6 +7,8 @@
>>   
>>   #include <linux/ptdump.h>
>>   
>> +DECLARE_STATIC_KEY_FALSE(arm64_ptdump_lock_key);
>> +
>>   #ifdef CONFIG_PTDUMP
>>   
>>   #include <linux/mm_types.h>
>> diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
>> index 12f534e8f3ed..e835fd437ae0 100644
>> --- a/arch/arm64/include/asm/vmalloc.h
>> +++ b/arch/arm64/include/asm/vmalloc.h
>> @@ -12,15 +12,13 @@ static inline bool arch_vmap_pud_supported(pgprot_t prot)
>>   	/*
>>   	 * SW table walks can't handle removal of intermediate entries.
>>   	 */
> This above comment can now be dropped.
>
>> -	return pud_sect_supported() &&
>> -	       !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
>> +	return pud_sect_supported();
>>   }

I keep missing something or the other :(
  

>>   
>>   #define arch_vmap_pmd_supported arch_vmap_pmd_supported
>>   static inline bool arch_vmap_pmd_supported(pgprot_t prot)
>>   {
>> -	/* See arch_vmap_pud_supported() */
>> -	return !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
>> +	return true;
>>   }
>>   
>>   #define arch_vmap_pte_range_map_size arch_vmap_pte_range_map_size
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 00ab1d648db6..49932c1dd34e 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -46,6 +46,8 @@
>>   #define NO_CONT_MAPPINGS	BIT(1)
>>   #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
>>   
>> +DEFINE_STATIC_KEY_FALSE(arm64_ptdump_lock_key);
> A short introduction about the static key's purpose might be helpful.

It may be, but I don't see comments above static key declarations anywhere else
in the codebase. My opinion is that adding a comment here will be over-documenting
stuff.

>
>> +
>>   enum pgtable_type {
>>   	TABLE_PTE,
>>   	TABLE_PMD,
>> @@ -1267,7 +1269,12 @@ int pmd_clear_huge(pmd_t *pmdp)
>>   	return 1;
>>   }
>>   
>> -int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
>> +/*
>> + * If PMD has been isolated via pud_free_pmd_page(), ptdump cannot get
>> + * a hold to it, so no need to serialize with mmap_lock, hence lock
>> + * will be passed as false here. Otherwise, lock will be true.
>> + */
> This comment should be split into two and added near their respective
> call sites with and without the kernel mmap_lock requirement.

That would be better.

>
>> +static int __pmd_free_pte_page(pmd_t *pmdp, unsigned long addr, bool lock)IIUC 'lock' is the need for taking mmap_lock in init_mm. Hence changing
> that as 'mmap_lock' or 'kernel_mmap_lock' might be better which will
> also add some required context.

Makes sense.

>
>>   {
>>   	pte_t *table;
>>   	pmd_t pmd;
>> @@ -1279,13 +1286,24 @@ int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
>>   		return 1;
>>   	}
>>   
>> +	/* See comment in pud_free_pmd_page for static key logic */
>>   	table = pte_offset_kernel(pmdp, addr);
>>   	pmd_clear(pmdp);
>>   	__flush_tlb_kernel_pgtable(addr);
>> +	if (static_branch_unlikely(&arm64_ptdump_lock_key) && lock) {
>> +		mmap_read_lock(&init_mm);
>> +		mmap_read_unlock(&init_mm);
>> +	}
>> +
>>   	pte_free_kernel(NULL, table);
>>   	return 1;
>>   }
>>   
>> +int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
>> +{
>> +	return __pmd_free_pte_page(pmdp, addr, true);
>> +}
>> +
>>   int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
>>   {
>>   	pmd_t *table;
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
> T2 blocks here because ptdump_walk_pgd() takes mmap_write_lock(). This needs
> to be mentioned.

I have declared the case as "T1 acquires the lock before T2 can". Then I
write "T2 will block until T1 drops the lock". This exactly means what you
mention above.

>
>> +	 *> +	 * Case 1 (b): T2 acquires the lock before T1 can.
>> +	 * The sequence of barriers issued in __flush_tlb_kernel_pgtable()
>> +	 * ensures that an empty PUD (via pud_clear()) is visible to T1 before
>> +	 * T1 can enter CS, therefore it is impossible for the CS to get hold
>> +	 * of the address of the isolated PMD table.
> Agreed. mmap_write_lock() from ptdump_walk_pgd() will proceed after T2 calls
> mmap_read_unlock(). So protection from race comes from the fact that T1 can
> never get hold of isolated PMD table not because of the mmap_lock.

Thanks for confirmation.

>
>> +	 *
>> +	 * Case 2: The static branch is not visible to T2.
>> +	 *
>> +	 * Since static_branch_enable() (via dmb(ish)) and mmap_write_lock()
>> +	 * have acquire semantics, it is guaranteed that the static branch
>> +	 * will be visible to all CPUs before T1 can enter CS. The static
>> +	 * branch not being visible to T2 therefore guarantees that T1 has
>> +	 * not yet entered CS .... (i)
>> +	 * The sequence of barriers via __flush_tlb_kernel_pgtable() in T2
>> +	 * implies that if the invisibility of the static branch has been
>> +	 * observed by T2 (i.e static_branch_unlikely() is observed as false),
>> +	 * then all CPUs will have observed an empty PUD ... (ii)
>> +	 * Combining (i) and (ii), we conclude that T1 observes an empty PUD
>> +	 * before entering CS => it is impossible for the CS to get hold of
>> +	 * the address of the isolated PMD table. Q.E.D
>> +	 *> +	 * We have proven that the claim is true on the assumption that
>> +	 * there is no context switch for T1 and T2. Note that the reasoning
>> +	 * of the proof uses barriers operating on the inner shareable domain,
>> +	 * which means that they will affect all CPUs, and also a context switch
>> +	 * will insert extra barriers into the code paths => the claim will
>> +	 * stand true even if we drop the assumption.
> Do these all rest on the fact that static_branch_enable() and mmap_write_lock()
> have acquire semantics available via a particular class of barrier instructions

Yes.

> ? In which case should the generation of those instructions via these functions
> be asserted for the above T1/T2 guarantee to hold ? Just curious.

Nice suggestion but how do we do that :) I feel it will be being over-cautious.

Although one can check by tracing the code paths that static_branch_enable()
and mmap_write_lock() will emit dmb(ish), one does not need to bother about
looking at the actual implementations. Let us ask ourselves what these
two functions must guarantee us on any operating system.

In the below sequence, let CSI stand for critical section instruction.

Take lock
CSI-1
CSI-2
Release lock

Since mmap_write_lock() is about locking an rw semaphore for protecting a
critical section, the computer science definition of a lock must ensure that
CSI-1 does not get reordered before taking the lock, CSI-2 does not get reordered
after releasing the lock, otherwise the critical section may be expanded beyond
the locks, thus contradicting the definition of a critical section. Hence any
implementation must have acquire and release semantics for locking and unlocking.
(Note that we do not care about instructions operating on registers since registers
are local to the CPU - we need to synchronize only memory loads and stores since
memory is shared). A similar reasoning can be used when one CPU does static_branch_enable()
and others observe it with static_branch_unlikely(). In the actual Linux implementation,
these converge onto __smp_mb_after_atomic() -> the atomic cmpxchg must be followed by
an smp_mb(), so that no CS instruction is executed before the doing the memory store
corresponding to acquiring the lock.


>
>> +	 *
>> +	 * It is also worth reasoning whether something can go wrong via
>> +	 * pud_free_pmd_page() -> __pmd_free_pte_page(), since the latter
>> +	 * will be called locklessly on this code path.
>> +	 *
>> +	 * For Case 1 (a), T2 will block until CS is finished, so we are safe.
>> +	 * For Case 1 (b) and Case 2, the PMD table will be isolated before
>> +	 * T1 can enter CS, therefore it is safe for T2 to operate on the
>> +	 * PMD table locklessly.
>> +	 */
> Although looks reasonable - the above comment block is going to be difficult to
> process after time has passed :) Just wondering could it some how be simplified ?

IMHO it is easy to process, but I have written that so obviously I am biased : )
I can only comment if you can give a suggestion of your own.

>
>> +	pud_clear(pudp);
>> +	__flush_tlb_kernel_pgtable(addr);
>> +	if (static_branch_unlikely(&arm64_ptdump_lock_key)) {
>> +		mmap_read_lock(&init_mm);
>> +		mmap_read_unlock(&init_mm);
>> +	}
>> +
>>   	pmdp = table;
>>   	next = addr;
>>   	end = addr + PUD_SIZE;
>>   	do {
>>   		if (pmd_present(pmdp_get(pmdp)))
>> -			pmd_free_pte_page(pmdp, next);
>> +			__pmd_free_pte_page(pmdp, next, false);
>>   	} while (pmdp++, next += PMD_SIZE, next != end);
>>   
>> -	pud_clear(pudp);
>> -	__flush_tlb_kernel_pgtable(addr);
>>   	pmd_free(NULL, table);
>>   	return 1;
>>   }
>> diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
>> index 421a5de806c6..65335c7ba482 100644
>> --- a/arch/arm64/mm/ptdump.c
>> +++ b/arch/arm64/mm/ptdump.c
>> @@ -283,6 +283,13 @@ void note_page_flush(struct ptdump_state *pt_st)
>>   	note_page(pt_st, 0, -1, pte_val(pte_zero));
>>   }
>>   
>> +static void arm64_ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm)
>> +{
>> +	static_branch_enable(&arm64_ptdump_lock_key);
>> +	ptdump_walk_pgd(st, mm, NULL);
>> +	static_branch_disable(&arm64_ptdump_lock_key);
>> +}
> Encapsulating generic ptdump_walk_pgd() between arm64 platform
> specific static key enable/disable requirement does make sense.
>
>> +
>>   void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
>>   {
>>   	unsigned long end = ~0UL;
>> @@ -311,7 +318,7 @@ void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
>>   		}
>>   	};
>>   
>> -	ptdump_walk_pgd(&st.ptdump, info->mm, NULL);
>> +	arm64_ptdump_walk_pgd(&st.ptdump, info->mm);
>>   }
>>   
>>   static void __init ptdump_initialize(void)
>> @@ -353,7 +360,7 @@ bool ptdump_check_wx(void)
>>   		}
>>   	};
>>   
>> -	ptdump_walk_pgd(&st.ptdump, &init_mm, NULL);
>> +	arm64_ptdump_walk_pgd(&st.ptdump, &init_mm);
>>   
>>   	if (st.wx_pages || st.uxn_pages) {
>>   		pr_warn("Checked W+X mappings: FAILED, %lu W+X pages found, %lu non-UXN pages found\n",

