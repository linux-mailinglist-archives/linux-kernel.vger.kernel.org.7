Return-Path: <linux-kernel+bounces-741826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CCDB0E965
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0331F5469C5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 04:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D829916FF37;
	Wed, 23 Jul 2025 04:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Ev9Ttqnl";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Ev9Ttqnl"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702E01C27
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753243356; cv=fail; b=O9nSrTfyNNALRPH7tbwbNOrK3CumZod3LqjXosM+D0Tcph4vQ7l4e8zGuZuhouoRrZ4WYtPg0DJUaacN/zpouOeACBRf8RMoLmPC/QLH3jwrT0axYled7gVR594eCZdfyQDTYmozlsthVDFPuZ2K8g2eZrykt39F104z2Mcn8bk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753243356; c=relaxed/simple;
	bh=BuEMuLgeV7sKjMc+mLHWkBUeH9qumcUX55D5zd7FSpA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S+lXgDW0g4f3/5//D2zzG1IdV1I5+n33RACicnrupOlk0kyL+IMVrRY0QQNDx9nyBuNkaJLEPbbW7F8uhqN7vbvK3hawF7u4lDm2J2zw34w7ow261qU1l3ju2lhFaAYI+JKJ99BXem0BY6iueMay9L5/PoZjOzRuIjMU9weaXOc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Ev9Ttqnl; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Ev9Ttqnl; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=QfmAwpQLbLTlT5RMt1mWyyrkBOiy/JQ0bp+b0HmLo7ZW8nzT7KzO76jZqoLv6L1U5VAWoI0V2F/JfuM7/9EMNX1KlUiXqES9cxFsVTjbFG3W7lXHiev0nf8+VPyVzmOlI3ZxgIIvj8vzlL8ru1zZPT4JEgEno5tp94myI5imgz8UBzu7JAFRFuWulrd2ut/UCpFcBb6ztUBauJRDHJoXfSXkdE0Jy1WT0085AkA9Jcbt0XUAJxlx1/Brjx6elxd1NpquuzSp01pWVUbX9KiI3YPBLQSJ9FKXRiXiRtHpBs/TrVYbeFWNLnCFiwDWcJi2BFlQ/h4vweGcnPA14x0p1g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuEMuLgeV7sKjMc+mLHWkBUeH9qumcUX55D5zd7FSpA=;
 b=nZc/v/fcNcKCGxzkke7fpMtDor1GNrCtYmCmYFMF925Ag/Mfw2FX9QYp73g7Z3yuXb23dRwtrb15xAqDNaEU+9yMZQ1h4lW6DbO6wFPfR3OANEcYkbdCgaz7RUWQk0mV2CR1j8bw893aIkirNkhT4yO2Ou3a43Bdz7FEWjNUHsuAoBsYJdyd/BhjW2AfloREymg3YcHW7/451kUb9YH9tbzJZOhXvuY6jP1cz7KY+TQ+08cN5uzxY7O9Fc2F5iw6ycbtQVQJidkFYydd5MzffsQ+FkCVNpYHyyG086v/uIuqUzSXYHZdMG7DN/OuDTsWQ/8DVCbamgSD3V72bTkvFw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuEMuLgeV7sKjMc+mLHWkBUeH9qumcUX55D5zd7FSpA=;
 b=Ev9TtqnljiGGSGdPFtDjU/pqpWbxZ7LRB77zL8IoEPArmW8Zvr5u1/FJHYhiUDY94fNm8iTjIsK1vE+r/qugHJF7p8hREUXSbkl0fDkVojiPA5qmiP9CPAbVOtKEdEvANhBCtYy7NWBLm528OiPRlImL6XR+TK4plgfOmY+gGdI=
Received: from AM0PR05CA0076.eurprd05.prod.outlook.com (2603:10a6:208:136::16)
 by PAXPR08MB6702.eurprd08.prod.outlook.com (2603:10a6:102:134::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 04:02:30 +0000
Received: from AM4PEPF00027A5D.eurprd04.prod.outlook.com
 (2603:10a6:208:136:cafe::7d) by AM0PR05CA0076.outlook.office365.com
 (2603:10a6:208:136::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Wed,
 23 Jul 2025 04:02:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A5D.mail.protection.outlook.com (10.167.16.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Wed, 23 Jul 2025 04:02:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoLdcy5vr8viH0taBVUtn9NmH70mS6tt5YfJk74mxAiAyI9ivF5sZFRiVLAZAajRpKSw9eWilyIg1w2jUmj/bffkEgohF4Toz7tF+r2FGd5ul3LwkkwjQ6QuIr36flnJ2wjedXS/qPGXohPLWQdMcW0uXQHPf16LtXicxoRtas6j4pfOkQc3OIPW5DGgfBCNdULzbWEdBuAxFtPRFyarIgEfunjHbxcHnVQGhryvOpuaLW4Y1PFSms1J2MLRKOZkKnnHm5bt7RiiUJEnJOi1CHO0b7DjMD++LF+bPTG9om61h0ZTMQ/jTDUCcYiPbStLDxviYNOXy1aFIS7lWxKH1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuEMuLgeV7sKjMc+mLHWkBUeH9qumcUX55D5zd7FSpA=;
 b=izJ6QeKhC6a1Ht98hFGf421l4zA2MJv39V4qW9Bmuf1gNiZIbD+lMyeJETqVs6xjA6IrUm/nxb9RNy7S2reXoY2+yJR83prhXNQROypoe6XTZjEj6cFYa0q8/m6/Qw9DfQ/4yI4QW8uxXPK4ylOpJ1TiidzvmSCb/A7LCKJBmkG4rr7OnxkoXT8yIF7o9/5uyjHjdfbjdwn/lNTDrVinINVIDQRCbHoAtJHuWN+tLxN+0prW86rcVgTzjbQ2FiJGGlfDnMbStZv6jSq0mrzvwvnQjQCmvfHsoSqnE7ER6Vizt0EVsT4PG0110v8DRlrBYXjP8npnXPBHpML2H5SgdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuEMuLgeV7sKjMc+mLHWkBUeH9qumcUX55D5zd7FSpA=;
 b=Ev9TtqnljiGGSGdPFtDjU/pqpWbxZ7LRB77zL8IoEPArmW8Zvr5u1/FJHYhiUDY94fNm8iTjIsK1vE+r/qugHJF7p8hREUXSbkl0fDkVojiPA5qmiP9CPAbVOtKEdEvANhBCtYy7NWBLm528OiPRlImL6XR+TK4plgfOmY+gGdI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AS8PR08MB6406.eurprd08.prod.outlook.com (2603:10a6:20b:33c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 04:01:57 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 04:01:57 +0000
Message-ID: <5dd85103-23b6-46b8-9e13-f777692b9dbb@arm.com>
Date: Wed, 23 Jul 2025 09:31:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] mm: add get_and_clear_ptes() and clear_ptes()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, baohua@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250722150559.96465-1-dev.jain@arm.com>
 <20250722150559.96465-2-dev.jain@arm.com>
 <20250722134717.b8c9b09b8915b552447cb419@linux-foundation.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250722134717.b8c9b09b8915b552447cb419@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::20) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AS8PR08MB6406:EE_|AM4PEPF00027A5D:EE_|PAXPR08MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: e71fba6c-79f2-4c92-4a3f-08ddc99dbe2f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?amlGMGJOUVFaOFR2NlhMV1VHUHdscXNDanVrZW1jSW9OWlZGVWRvbStoMVJN?=
 =?utf-8?B?UmVueDVWeTNXT2FLbWlWNlVpU0laNHRQRGIwL0dQZmlidllvdnA0M1RMM28x?=
 =?utf-8?B?OEVwRUk4NE11TXl0L2VoZXVlRFVCOUViSW1hZGc2bTVhMjgwNWhtNnUySHRC?=
 =?utf-8?B?OUlkTHpmSVg2L1BrRWdpQnZGclMxSnoxRXQ4eG90Nk5EMlFQaENsTWExWFlR?=
 =?utf-8?B?R1YwamxzLzhDenM2dXlEa2xOaHdCMW42UHlMZmM3L2FuWTNWOUNpbHBhNERi?=
 =?utf-8?B?eWplUks0ZEE5bklpbG1McG5FUDZPeHhHMVRXV0pBTmpldjdoT2RnRzBEVHJn?=
 =?utf-8?B?VDlmQUdLdi90SW9ZY1FLQ05sVDJWd0VLclRlY1UvQnBzWkJWQWVqeW41Uzhp?=
 =?utf-8?B?Qi9aNk9EWXhBSFlpaEc5N0kveGI0cnVDUDlwd3ZsdEU1dlU3TXlrNkJTSEcx?=
 =?utf-8?B?VVFFZjNuTU1uRkwzUi9BZnU3Y0drOHNVVkdYOFh4TWlJUTRseTA1L09OVWhH?=
 =?utf-8?B?OGhFNFZlZUtrMU91Y0dLRTdsQ2QxV2UzWU9ISjhqZnhaMklQM0s4dlNhMURh?=
 =?utf-8?B?cW5mcW5vcUlzakdUZmZGRS8weDZUcXppREM4aXRPb1JsbkswQm9VbEFTcmti?=
 =?utf-8?B?Y0xGZGxTOWVLd0kwcmxqV1lWUW16YmdtN3F2SGJuaC8yY2RkcjRiYkpzT0Nz?=
 =?utf-8?B?QUtPN0VpUnYxNzl0aW01WDlVR1pmM0lXQWhDelhqMVNjUnlpUEJlb2UwRkdq?=
 =?utf-8?B?NXpJbkZtbXFaS1Z2L1FCcFovUnN4VGx6eXFnM3RtV3o2OHZVbzFsSE1sM0lj?=
 =?utf-8?B?VHA5bnZoZDBlSGxsWkNYYVFwYUtPMkw4alJ1MXkrRlhyUENXQU5kSXdkZXFv?=
 =?utf-8?B?Uk1mVmt2eHZBV29ZdWxHd0NLMVBtWDhEeGpjOVBNT3NVZSsycDNJeU1xdVRv?=
 =?utf-8?B?WUtqTFdacWZjRk05VmxFdGNveFBzNU4rdXlWU3E4UEQraUJUV2pCVDk1QUxi?=
 =?utf-8?B?bjh1UkVpc2tDWFdDRmpmbjlaMkxvUm0rUlEvMUwzN0sva01ROFpCTXVoeXZJ?=
 =?utf-8?B?K0VwRVBMaWtJcGNaZlh5ejZtNllEU2YvRWlIa1NvSThRTWdvRFA4TnFybkVw?=
 =?utf-8?B?Vnl0YnlOMHhXazNUVDZ0WDBHZlZTakgzeTU4ODQzN3lVczVMaTQ4NjNlSUs5?=
 =?utf-8?B?aTZmbzJFdmUwWDU3NGZqVHFLOVhmWngrdjZ5UjRNbzd2UFdSelY1ZnRvaTFk?=
 =?utf-8?B?eG1NYVFlMGZDOVhrT2Yzcy9jQWM0VkRPVkQ4cWkwSnRSdnZ6Nk10cTBoWVVu?=
 =?utf-8?B?SjhYcExVa2h0YWFVYThBek8xOGVGOEhwMzdkUGxRTHBndC9OcUxDVktkWmpK?=
 =?utf-8?B?TG9Pek1KamU2SnhIYk9aeGMxZTBIV1BCeVprb3BZcFlMOXhGZVBsRFNDQm5U?=
 =?utf-8?B?Q0g3MEl0dkVabXRFc3VwTmhVbHNoblZEWmEzNEYyS3hpWVlwelh2eGxWVnRD?=
 =?utf-8?B?VTB6Y3FBeUhUWkJmd1ZwZGRLaFBtM0FDZnpKa1M4UDArWSt3MC9xdm9KRGhl?=
 =?utf-8?B?YnJtU2N0ZVB3S1UxbzI3S2t3TmJaQW5sQ0JwWGxkR25Sc01uR0p4TzRSRWdW?=
 =?utf-8?B?cTNEQ1VzSS9yV0Vxalh5d2lUcUhUQTRLcW1JMGI1TGdmZHhscnBibFN5RjNr?=
 =?utf-8?B?cEZNLzUvaDk2Q1JyM2R1ekQ2Sm9SR3VGaGtDVlBXM2Nna2hBTXJsMFRNVGNk?=
 =?utf-8?B?WWFYaTY3WkNGMnVQOFlJaWp0anNGZmdwU0xRcm8xSTRpc281ZHpGR2QxWjM5?=
 =?utf-8?B?YmlnREVHZWNHSnphZ1NrdXJuUDJSNXlKaWMxaUZSS1Q5T1o2cmIrYUVuZVk3?=
 =?utf-8?B?eG9vVlo5S1diZWlDbStpeGhJZnVLWVNqc2xid1IvMWllU2ZSSjBySVJUZjlI?=
 =?utf-8?Q?pqWZFEfV58Y=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6406
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	11c0331f-a967-4cc8-f230-08ddc99daaa2
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|14060799003|35042699022|82310400026|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmhCc0lYeXBoaE0vU0VnRjZhVmZsOEt2YVhDb2RMY0RiMkhDdVR1WTllblhj?=
 =?utf-8?B?ZVBSV0Ywb095eE1QanVobFNTSWhsU1grbnNrUFhtNDFSL1VicWN2UnV0bmFp?=
 =?utf-8?B?RGxZM3NSY3pBVHI3emRXcjYzNWdqTGx4eGEyTmxlUTJGOU1vY2FZaTZhQUM0?=
 =?utf-8?B?VFRwdXhwZkNDTnRObFBzcnBEVG1sSi85dXh5cWg1c2JqU3A0b0JLMjlmVEJq?=
 =?utf-8?B?eFMrRlFIYmxnVlhNZEpnSjdWRlNUY2R4MWJhUWlBcnhjdE5UNGw2SVRwem9U?=
 =?utf-8?B?UUxPc3U1QjNMTjRISkxXZVVWZ0dVakhLa3F0M1drRWN0LzNWaktxMkdJMDhE?=
 =?utf-8?B?ZFhQend5R1VYK0ZERWRJc3BzMmJpeWtDZDlaQmw0VzRSeE9GRk5OTjBsanJh?=
 =?utf-8?B?dE1FVEV3M1NMcTZIUFJaM01zbVYzSlAyc3BvUnBsN1hHYTVCeEFqTTExTXAv?=
 =?utf-8?B?c1BGeENRSVVYTUUvaytqckVBZXhIZUVEVGUveTlLenV3ek5GSGpORi9yUWZz?=
 =?utf-8?B?MkpIU1h4SHR4bEtHb3lIU3RJN1h4L0h2dG1VZ0NObmN0VzZoWDE5MEJ5b0pM?=
 =?utf-8?B?bnRZd3VUb29NdG9lT0xPWjcvVzhMa1ZxRWxOa0xnM01VSC9iSHBFK3lxeVZD?=
 =?utf-8?B?MmloN2ordTlIa1RPYkNHZ3NFa3dzaGMwUDBjR0tZZjhObG01dEp1WVVHSElN?=
 =?utf-8?B?WEt3U2xMQnQxU3hrN0VGYXEreHRZZmdJL09DNFlRTmY1REdmcytKN3NRM1NM?=
 =?utf-8?B?Y0RwY3M2KzBqQ2czbnRPVUxIb2NYTzBJYk40QUJSTitRTTdPWFZoNXN3NGhD?=
 =?utf-8?B?OU8ySDFTSE4vK0JGRThTdHpXNElOV0JZU25GRXRIaDBLMnJvOVl5b1RySHRT?=
 =?utf-8?B?QlMyRTVFQ1pZcHkzS3h1QzhhVG9wQk1FSjhyRlU2dnZnMEVvZVdVRDVNNDhD?=
 =?utf-8?B?aEl5WEpRSzN6emFMTjlPeldCZVpLVUtMMlR2MVFsUTlqay92NUltOEt4NUR0?=
 =?utf-8?B?Q2dvUGo3WXgyS2xiNE85WkU1bURhUjFXL2FUQzRwYWIyR2QxMnVvdndlTjht?=
 =?utf-8?B?aE5yZitqNmUyMU5UTm5VRVkrYjJES0orYUtuaXVIM2h5QVNwbis3SkhDVnRW?=
 =?utf-8?B?OE9uZ3o3LzJaVHI5L3ZtWW5EQm9TU1NCMVpMOTJHbld3SzAvZDhaUkpsRFA1?=
 =?utf-8?B?bjJBYWpvaFdUamZ4MUFQRHRKbjhnVGZUSDlPUnJqYUwwZllreVJHRVAwYVhH?=
 =?utf-8?B?Y2MwZXEyOUVJT1dIM3VReFg2Nk1pdmNZS3RIVzNXUjB6THpZcEFjdHlhOGc5?=
 =?utf-8?B?V29GZEEvY3pGQlVSMnRTYTNxWWxBMDVLQ3prUTZGbHgwYmFjWklkRUUwT0NE?=
 =?utf-8?B?R3VuUlFRb1JjWHJlSjFyY245Ym9YOTRqdVU3dnNXRzFCeW9IK3VGMjVlSUdw?=
 =?utf-8?B?ZUR2Q28ybklibEdGN203cEhrbzdKK00zYkVIV0NjdytOcFRnNzJqQ3J6c1pX?=
 =?utf-8?B?USt3dVF2enJoUjBvMzNoQWZ6VnlPSGo3SDlnOVFoSnh2dHNJdUJKMWZjVFVn?=
 =?utf-8?B?YW1MbDZEaTFKbTk2d0VsL0xad2tTVXJUS1ZmSE1obmUvMlpXVVRCWGt6NEVP?=
 =?utf-8?B?Y2FManN3YUQ0NytuOStQbDlTeGZmM2VGc2FVNDlCUE9QM2M0eWRHK3hBdUFs?=
 =?utf-8?B?S0doVElzdHZFVHJjTWRma0RreVlOQklRMnYxMklWWk1FOHhHZGxSWno2QTcx?=
 =?utf-8?B?dXF4NVJSUkZXbWdhdlhYZVBoU09NellVM0JIM0VZS0pLcUlrS2lJeTZtOGxY?=
 =?utf-8?B?VU84ZGVEeTIxajFKQk5XQ0VobjFJaytqbHhVdXE3SXhIOEgrOWlrdWVTYXhx?=
 =?utf-8?B?Qys2amcyay9zZ0d2aGNiN2VzbzBKL2lDSzdYRjBSM2dMR2Y4UERicDNrRHFU?=
 =?utf-8?B?R0wrRXZ2YmU5SjhJMUFtV0JpTHcyK0gwUndYVGhTaFZYSjhZV2gwNVRLQXY4?=
 =?utf-8?B?bVZDc2pyWW9nZmNSSFhCSTYvd21mdVpuUmoxd3FJazRSQ1RWMUl5ZjhFaWxt?=
 =?utf-8?Q?lqiD/W?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(14060799003)(35042699022)(82310400026)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 04:02:29.3379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e71fba6c-79f2-4c92-4a3f-08ddc99dbe2f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6702


On 23/07/25 2:17 am, Andrew Morton wrote:
> On Tue, 22 Jul 2025 20:35:57 +0530 Dev Jain <dev.jain@arm.com> wrote:
>
>> Let's add variants to be used where "full" does not apply -- which will
>> be the majority of cases in the future. "full" really only applies if
>> we are about to tear down a full MM.
>>
>> Use get_and_clear_ptes() in existing code, clear_ptes() users will
>> be added next.
>>
>> Should we make these inline functions instead and add separate docs?
> inlined functions would be preferable.
>
>> Probably not worth it for now.
> Well, as David has called for a v4 I suggest you make that change.
>
> Thanks, I'll queue the series in mm-new for a bit of testing.

Thanks. I'll post v4 later in the day.


