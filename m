Return-Path: <linux-kernel+bounces-747525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A2DB134CA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531291737A2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974DA2206B2;
	Mon, 28 Jul 2025 06:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cr+H3dbe";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cr+H3dbe"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010012.outbound.protection.outlook.com [52.101.84.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F442157A55
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 06:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.12
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753683326; cv=fail; b=Q6R3kbofs9E8mQpfQgHMVfysc7U2bd9StuJ7lFR1nehds4u3v9hAiIIGfoKUaFdHIeHpP8egdRg0Vsrl4C1YB6cF0P2mw3fpyYvB85dRVhwHOuPF5CmMjXkGE/CyjI9RyWFuVGCzTgSsfj2AxX0i6MckbkktUemvY//eW/SFvos=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753683326; c=relaxed/simple;
	bh=gQPIQy6m6FAUtCtir79yEuZBvX3vme8jfr5hrFZumUM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c+GV5+1Uhyh4owz8pknyYS7RRxc/vzOr9+HhFkevgFeuFCwE7EiGSItxrumd9+PTP0/L8bfzBIMHw3zzRMlauqNoBBDEKqaPqb68uVXbQw8nhb0eFLm1YUcwSQTTHO0ivTXDv6LjRA537A+CR2+MtVWzw7/SL5RmsYvQeMfA3i8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cr+H3dbe; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cr+H3dbe; arc=fail smtp.client-ip=52.101.84.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=jMHm7a1C76iIlZQAeQc2HindKLk/AwEEZpsMi9oRfBGVyFUxCSP5qImaRs1fgACA6ACqW8J7O5U/tItVc0wdIeA1g2ZPy650OgYdaFolPvb8H+FMIfZ6dFAybn6etqpGT/qpaMXCuBaSZweE/ccJ+ub1Xvbd7i6qn7MqbBAqRgCVjZg4qB4/DZYLkUcQgSH8GEfNtQAzfl9N99Iwj+EoIZJOGF/uFWgy+xsgNg77MHgrJg1NtRq3Gsk9/Spdovn9sX3hERPfWQCYSovY9UKNBuTw7wlZ0NR2paeEbjp+oko/O6h/I9W9tSTMJNa9acnj63p/MsvdtvRb64xwyl9Ynw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQPIQy6m6FAUtCtir79yEuZBvX3vme8jfr5hrFZumUM=;
 b=YAdIAp2AJ0JMaQpc4TsbHsjDXQbAojA+GR3dH1hXdYHR4QhHtkoVt4Q26lFpIGVl4xkygVDbYdrooa9j8WIAd7fs2DbEbgOB+OhrC6Ype+zq6XHr9rNwJq4vmt2xL3QpWHPPvXqaG7GDDp7ecCArt2PcxCQXCR7q59WmZbI6iul0wydM2N+icPWaqVcbiIIyjduCjL+yTejJMWiF10mkELV+py+KQtBXlJid3FZUL4BCzB3Zy9/+sUeaaYZJJ3zQL5798UWbi6Uk+khjR0aK/hv4A2TtHxrEgo/E9Vg2KweTEmhsg3L2YUluXrXihISe+2/QXKKSFi8IL2INauErOw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQPIQy6m6FAUtCtir79yEuZBvX3vme8jfr5hrFZumUM=;
 b=cr+H3dbekM+nRQcHsK957wOclGrL92xsRlSLsb212FkbXPv4I9cspGTOKG9cpnHaXIqHJzSVjjIsnhI8P6QuE5Umi4e9RsVDm+q1BD79r5RGRZmrnY2VqpdLAzmTpP4Cfj76DvNSxwU672WWTG2Tbpf3LkO26uNR583qECreWDs=
Received: from AS4P192CA0003.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::13)
 by DBBPR08MB10412.eurprd08.prod.outlook.com (2603:10a6:10:535::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 06:15:19 +0000
Received: from AM2PEPF0001C70B.eurprd05.prod.outlook.com
 (2603:10a6:20b:5da:cafe::72) by AS4P192CA0003.outlook.office365.com
 (2603:10a6:20b:5da::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.27 via Frontend Transport; Mon,
 28 Jul 2025 06:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C70B.mail.protection.outlook.com (10.167.16.199) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.10
 via Frontend Transport; Mon, 28 Jul 2025 06:15:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTExVBLoEviOYqkRVNwY90rk6N9tKjb2z3qkUqcnmSZtKlP6yerG+Lo0/O5oBbHNl7k2KFZfiYKwivJUoLh7STH1lthoAeLM8cAEz/eaNDKFa3eVDW6XgMYbnjJbOGK2oKQHjlWw5CXKCO5P8JfDiS3AxoA96qyWJekj23Gc1mNBiLMsvaxzlcD2/eCM3+zBUFugbFwuCfPqMwyIvGSn+qImUQ7HXE2F21kv8Ow82pz2k2iWSEu5T0nNCfdpGN3jA0ArxDG/KNaJWsXQjM33kiLHXcBxo53UjAzNFLHEErNTJLy2lcp85TkI0YMuJW9OgyhUqze4nqUWkOgjeb2cZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQPIQy6m6FAUtCtir79yEuZBvX3vme8jfr5hrFZumUM=;
 b=vS5YzZKh3paDOI87exFxnzUBWegtCtzWbN+2gQQETVbBP1wNnzTQ5d80C5SaOP67XedFXEObYZw8X0d6OHfVS5qeCKDA/WiW09fmum9FkhRe/nApuzzJPHw3He7peEkDovGaie3DgbgsFwjNVBvNWwivKH4RaT91INxhGN0/LYfL0CQrErN6ZkTHlVB40dALf1nH1Y+OoQlyBYKCCVZJHoew11mhpZBgCXAtiD2DAbCGvgYp8U9hrYkLETHPuigtQWCyHwnSK/KX2Do22lYPVXNr24IRQxizDzbj32vhakRuj6KxNooqnWNONO5ob96g9OG4qyJ+3gYuJhR8qMDB5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQPIQy6m6FAUtCtir79yEuZBvX3vme8jfr5hrFZumUM=;
 b=cr+H3dbekM+nRQcHsK957wOclGrL92xsRlSLsb212FkbXPv4I9cspGTOKG9cpnHaXIqHJzSVjjIsnhI8P6QuE5Umi4e9RsVDm+q1BD79r5RGRZmrnY2VqpdLAzmTpP4Cfj76DvNSxwU672WWTG2Tbpf3LkO26uNR583qECreWDs=
Received: from AS2PR08MB9786.eurprd08.prod.outlook.com (2603:10a6:20b:605::22)
 by PAVPR08MB9603.eurprd08.prod.outlook.com (2603:10a6:102:31a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 06:14:46 +0000
Received: from AS2PR08MB9786.eurprd08.prod.outlook.com
 ([fe80::5de8:31fa:51f8:29e1]) by AS2PR08MB9786.eurprd08.prod.outlook.com
 ([fe80::5de8:31fa:51f8:29e1%6]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 06:14:46 +0000
From: Justin He <Justin.He@arm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich
	<dakr@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mm: percpu: Introduce normalized CPU-to-NUMA node mapping
 to  reduce max_distance
Thread-Topic: [PATCH] mm: percpu: Introduce normalized CPU-to-NUMA node
 mapping to  reduce max_distance
Thread-Index: AQHb+r8gfQL0R06fgEqHshXLBSLgJrQ9og8AgAk7zQCAABy0AIAAAcvw
Date: Mon, 28 Jul 2025 06:14:45 +0000
Message-ID:
 <AS2PR08MB97863FD18B6D7D779CBE9B9AF75AA@AS2PR08MB9786.eurprd08.prod.outlook.com>
References: <20250722041418.2024870-1-justin.he@arm.com>
 <2025072202-june-cable-d658@gregkh>
 <AS2PR08MB978689001CDED54ABD33FAF7F75AA@AS2PR08MB9786.eurprd08.prod.outlook.com>
 <2025072834-getaway-fling-0d66@gregkh>
In-Reply-To: <2025072834-getaway-fling-0d66@gregkh>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	AS2PR08MB9786:EE_|PAVPR08MB9603:EE_|AM2PEPF0001C70B:EE_|DBBPR08MB10412:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7d108b-0485-4279-f1fe-08ddcd9e202f
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?aHppaUNFejdzVEo4OTBVSGQxV1JDK01kUnhEMXQyekpIS2s1U0dha0NycE5y?=
 =?utf-8?B?L0VQMjg2WnQrRnRGNWlRMGludmJqUURteHQ5aUNGQlozZ1puVmh5cjBoRzlH?=
 =?utf-8?B?UDlCZXFxdklqeUhyRTVOV2w5ZkxZK3l4WXBRMkdoNlloQ0U2cnpRTVQyekJ5?=
 =?utf-8?B?NkFZK3pHaU1LMkdMT044Z0phRUdaenZ6VHdzUjVEdFIyZWJNSHZQS09pQlVV?=
 =?utf-8?B?L3RQTTRFcWRrdXhqQ2R2V2NJQi9FZTJCc25UVGc1clpGVTlMQXJ6WjhhZCta?=
 =?utf-8?B?ajBJQVl2RTJrcnBRRnd3aVZxNitiUTNKcVZCSythWUJJWlZQSVFjSEJHeGJK?=
 =?utf-8?B?UVpITFBTejNRYUhQa2dkTk85eUNGNisvY0xQTzdYdHdCd0VCdlNKS21zWnBu?=
 =?utf-8?B?eEFmVUxidEJUS2R3b1lleHFxWEJwYUlOQXdZZkU0WUwxbjNUVGU0RVlOeUVa?=
 =?utf-8?B?L0dUbGFNWjlwT1YyL1lVeGZycjBSV0p2a3Z5VStFK3lUZE5NSXNoMzVST0dy?=
 =?utf-8?B?K1Q0OGM4eHd2Q2Y4K2NWc0c4RjRWeVV2V2dPemRPVGlxTVpwa0t0UmpFNjJQ?=
 =?utf-8?B?M3Y1SVpGVEh3dUg0RlNUNUNRNWZBa1dlL3RJZ0pIN2RqQWIwV2FXZy9ENnFq?=
 =?utf-8?B?cHk0dFlyL0thQTZRUjZqczEwUDFGc2w0SWdzSU1ScUhFR0dzR3I4c0dCaUt4?=
 =?utf-8?B?MVJSNDF2aWF4Wml3YkdCQzJkSFBLRVlmZnk2V2JyeFhTazVlbHE3dnhubTZC?=
 =?utf-8?B?S0o5RWtwUmlOdExMZ2hHU2l5V3hKWEgzem1mamczR21EaTVQQzkyRndnVU9m?=
 =?utf-8?B?cVpLdkZneDFzUVFicEZqdm9MN2V3SU02M2hsUUJEclFPK0FRMVovMHVYY3VE?=
 =?utf-8?B?V29JV0RsZTc5UU9IQ1d0WVQxUXlHbU5iYklKRXZrUGhHNkhoeGRYbjZFaGZ6?=
 =?utf-8?B?eHpWdGtHNkFVL0liNGk5VER6ZmRmUExObmJrKzBqVVF4MzgzRzNwRlJWNUVx?=
 =?utf-8?B?Z1dnZnU4TGxSaWV4d2RHWHNLSUN4NFB1Sk91d1Y3cC9kbFVyeUN4ZStINWJT?=
 =?utf-8?B?RGhRNkRHa3FnRDNVdmoyWlVWcFE1UEgzcFJEOHVGVEcya1NkYkgzd3JjQnNH?=
 =?utf-8?B?SlF6bENrcEM1MEhyOERxUjN1V0VoK2tLem1IOHdpc3c4ZUE3OGFmdDJZU0hz?=
 =?utf-8?B?ZXdrdGU4RUVYemtuc2ZnaDhXVDdkcXZ1TXFyTzgxZi9PQ1ZMZWlwWGpxYndi?=
 =?utf-8?B?aVBteGFJRS9hTjkxQ251S0Y5STBkREp6ZVYwcHkvWEQ0aDRuODY4ZzFXaUMy?=
 =?utf-8?B?bVNsaW5CZlFHUjYxR3ZwY3lIZEprVVFubk9QcDh1NEJSOW5pMlJPUW00ak1k?=
 =?utf-8?B?em5MLzdCdUFDWG14NmhFSy9FTHhaVW40bGlHSFZ4bzZrWHhMU24zd3NxT3Y0?=
 =?utf-8?B?UlhFU0x5dXBGSnpvY2Z0OWRWaDNaZGRtTFF1MjRJMDc2VWxLTUxETmdqTWts?=
 =?utf-8?B?ZkxEamJIeGE5eGR0Z2QvSWhSa1RWU0tCNDJJN1REdVBxRCtLL2w4Sll2RVlz?=
 =?utf-8?B?S1JJTDBTb3UrY05FZ2plOE9POVlMcmJBYi84Q2xhc1ArMHNHR3lZOWdGU0dB?=
 =?utf-8?B?dldsekIzY3VNVS9mc2ZiWHZENUwwZzNKbFFjMlBTRTlJYUZCQm02cWpZYnht?=
 =?utf-8?B?NFpIV21PTklGeHV5MW1QNklGbm1nNDhHNENELytsbGtUVHI2MTVJcVg2ei9N?=
 =?utf-8?B?K1l3UG5SQTN0TEYwNVdtaElYWU1UVWhpMEZEQUhFb1ZyMlcxeFJjRFBlcnd2?=
 =?utf-8?B?THhDem9VWWQyZjNvWFVIN2ZEK2R3V3J5TzY5THd4TVRCQUhLYVA1UlgreXE5?=
 =?utf-8?B?OUNWSXNlQ2V3UW5tWjBxam9uWExSU0FCMTNQWG9KV1JTaEpiNDk1ak1MOGhy?=
 =?utf-8?B?aFNPOGk0YVRoa0pub0VwVE9xMS9yQ3VnaHhMeWU2S3daa0x0SEVpbmF1dkt3?=
 =?utf-8?B?eS92REFMcUNBPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB9786.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9603
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C70B.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	06dff764-8cb0-43a2-8431-08ddcd9e0cce
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|14060799003|376014|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VG1haHRGZVlHdzh5Tno1b254NkQwRzRpbnh1UThPSkxuaHVMY08zbldlUGZI?=
 =?utf-8?B?RlByajRQZ3hyZXBwRnYyelphejJCZW5MdzdCTk5XMUhhendPTk4vczdiZ1U5?=
 =?utf-8?B?V2NndVY0K0xwcVRPRzgwZmFGdkR5dVBtMk0reXYyR0VsZUMyWHlHMEp2ZUcw?=
 =?utf-8?B?N2xSalJqU0k0Q2gyNldtTll2WGtRbmY5OE5vWjlhSEFNUmxoVk01WGJ4UlFj?=
 =?utf-8?B?TGptZWtzd0d0bXJWVXJGWVpxODhoeEhKRDFZa29CV3RITXVCMmtQZDYrTlJ6?=
 =?utf-8?B?T0VDdDJGUGl3bEJDbzZrTGpCN2dBaHJibUlkSDROSU1nNXhYWko2c2pOWjBy?=
 =?utf-8?B?R0pDS2dBRm5nQlJNSWxZWUlGeURVbkI2WDNpNWdBSnJvT2Jnak43V3JuSWVr?=
 =?utf-8?B?YTZUc3Iva1BjRTQveFd0OUloTGYwNnkxWnVCczVNTzJPZndnM0xVRm1GSENG?=
 =?utf-8?B?ZSsvUkFqRVRUNHh6enp3M01uWFR0d3QvS1hicjhNNHgrc3R1QWs0eGxWa3hL?=
 =?utf-8?B?UW1NZUdndUNLWklRd0dIM04wdkIzczdtbGtRUmhjcEt4Mk5RL0ZCM3drdEYr?=
 =?utf-8?B?UHZqL09xNE53OVdKSlRjUjY4N01RbnNwWkxBOFdGcThKN2hZc0l6NVBWZEU1?=
 =?utf-8?B?cGRaQU53dkJESGJhWXVjOU5oOXNmS0tqTkxsaWNaeXZ5ckRSTHNISUhwZzBv?=
 =?utf-8?B?TjZwR0lTM0YrUU5mK244MmhaZTRIM3dlby9EUVZEV1VWK3VGYnBWT3czTEJi?=
 =?utf-8?B?QzFiTjJhb1hPeGVHZWM3YmY2LzQ0bUl0QlJwclQ4L3JNS0wreWkwWnNKSDBD?=
 =?utf-8?B?eHdSdVpESHZQYzVBellTcjFlRXlYUmhaUWlvd08wSzB3OGFMR2FDNHJiVVRU?=
 =?utf-8?B?dGJSYVBWZkFoZVJ3SkJscWlxdUVheDFXaG9MN2FFZXRCamlvK3V1TW0rU3Vj?=
 =?utf-8?B?K2FmZ0NiV1NIWGltcmM4Mk5kTER3ako1dXU2L0xjdGlRWFlzVnNMZmowUGJU?=
 =?utf-8?B?Z2x1NDBFMkp2YXQxVGxwUjN3bW5tb0NlcFJ1UkYwU0tMUjF0UWJQVGh0a1k0?=
 =?utf-8?B?dTJmNzNPa0lLKy82Zy9uczdyeEdyYUk3NlRoRFNWSDlFTklGQm8xNXRzM2lU?=
 =?utf-8?B?aFlESGtnQ2dmb1AzREd0SVZIZFZrY3AxSHpFTUhRZkovV0dENk9BODNKSVN5?=
 =?utf-8?B?Z3ZOd01IRFZGMmxadEtyWkprODFWK3B5LzdOV1p1NDZvL1FsRUxtUHg1Y1NU?=
 =?utf-8?B?NjZvZ0Z1L2FQb3FXZ2Z0d0lGTUNRaVovYjMrNlN5ZlNHUTFOQ2R3aG5LRDFa?=
 =?utf-8?B?V0dZT2p1U0RiK2VuQkNvbXc1SU5xbVR6dG9WU011S09LYXlIWURQRDdSSHVq?=
 =?utf-8?B?L1FvQzNRaFcxbmVrRUhCQjJQR25zZjd0RlJFYm5xR1JWcWY1QkNUM1Z5NUYv?=
 =?utf-8?B?TVV4TEhTM1liZHk1TVFsUVRuQllpeHRJaERlS1BKeGVVUVFYTWxUdXliVWpL?=
 =?utf-8?B?Rm4xUEFNbGVFaitiL0N6VnFQMWw1dHlWRmw1bzNYdldXdVhvUVRJNG9zWVZI?=
 =?utf-8?B?SHlVNHhDcHZjSjJ1dmxZbi9rQTNNM3ZsTkE5MklHZEt2b2RzajcvbnRyTm5F?=
 =?utf-8?B?d3FMQUY0ci9XSi9uZ2FLaVlITHhqS2JxbFRBZlUrcnVmb20yaThYK3pVbEY4?=
 =?utf-8?B?SExmSkt0czJ6eWVHUVJPazBVbjVyY2ZpeHorNmsvWFpTbjU3S1hGbXBmQ0Nt?=
 =?utf-8?B?eGxoSWxJUXBmeXQzUHZzK1FNSGNvM0lDOXVRN3U4WnFHa2lVRitYanVmeGFE?=
 =?utf-8?B?L0lmK0dCdHg1MnNmNG5jT0k5TndtRzd0MDVvNXY1bzBzeXYzQTc4SVYyZWlG?=
 =?utf-8?B?ZEYrMUVIQlRnT0FPQWlRN295ajUrWWxnbzgyUjlrQkN4Q0dJbXNUK24reDZl?=
 =?utf-8?B?WkZML1U2VlFRWFVsZGxLdVBSVXZjRlJmbHgybW5OU0V1TXlYQXZaTUFXWEhY?=
 =?utf-8?B?L1BUOFEwUlJjSzBIcVEzMW1NTUI2b2pmVk1tbWk1N09QaHpjRmRPRExiZDhq?=
 =?utf-8?Q?PmDg8S?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(14060799003)(376014)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 06:15:18.4050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7d108b-0485-4279-f1fe-08ddcd9e202f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10412

SGkgR3JlZywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHcmVnIEty
b2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiBTZW50OiBNb25kYXks
IEp1bHkgMjgsIDIwMjUgMTI6MjggUE0NCj4gVG86IEp1c3RpbiBIZSA8SnVzdGluLkhlQGFybS5j
b20+DQo+IENjOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+OyBEYW5pbG8g
S3J1bW1yaWNoDQo+IDxkYWtyQGtlcm5lbC5vcmc+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG1tOiBwZXJjcHU6IEludHJvZHVjZSBub3JtYWxp
emVkIENQVS10by1OVU1BIG5vZGUNCj4gbWFwcGluZyB0byByZWR1Y2UgbWF4X2Rpc3RhbmNlDQo+
IA0KPiBPbiBNb24sIEp1bCAyOCwgMjAyNSBhdCAwMjo1NDo0MkFNICswMDAwLCBKdXN0aW4gSGUg
d3JvdGU6DQo+ID4gSGkgR3JlZw0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+ID4gRnJvbTogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZz4NCj4gPiA+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMjIsIDIwMjUgMTo0NSBQTQ0KPiA+ID4g
VG86IEp1c3RpbiBIZSA8SnVzdGluLkhlQGFybS5jb20+DQo+ID4gPiBDYzogUmFmYWVsIEouIFd5
c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPjsgRGFuaWxvIEtydW1tcmljaA0KPiA+ID4gPGRha3JA
a2VybmVsLm9yZz47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IFN1YmplY3Q6
IFJlOiBbUEFUQ0hdIG1tOiBwZXJjcHU6IEludHJvZHVjZSBub3JtYWxpemVkIENQVS10by1OVU1B
DQo+ID4gPiBub2RlDQo+IA0KPiBPZGQgcXVvdGluZywgcGxlYXNlIGZpeCB5b3VyIGVtYWlsIGNs
aWVudCA6KA0KPiANCj4gPiA+ID4gSW4gdGhpcyBjb25maWd1cmF0aW9uLCBwY3B1X2VtYmVkX2Zp
cnN0X2NodW5rKCkgY29tcHV0ZXMgYSBsYXJnZQ0KPiA+ID4gPiBtYXhfZGlzdGFuY2U6DQo+ID4g
PiA+IHBlcmNwdTogbWF4X2Rpc3RhbmNlPTB4NWZmZmJmYWMwMDAwIHRvbyBsYXJnZSBmb3Igdm1h
bGxvYyBzcGFjZQ0KPiA+ID4gPiAweDdiZmY3MDAwMDAwMA0KPiA+ID4gPg0KPiA+ID4gPiBBcyBh
IHJlc3VsdCwgdGhlIGFsbG9jYXRvciBmYWxscyBiYWNrIHRvIHBjcHVfcGFnZV9maXJzdF9jaHVu
aygpLA0KPiA+ID4gPiB3aGljaCB1c2VzIHBhZ2UtYnktcGFnZSBhbGxvY2F0aW9uIHdpdGggbnJf
Z3JvdXBzID0gMSwgbGVhZGluZyB0bw0KPiA+ID4gPiBkZWdyYWRlZCBwZXJmb3JtYW5jZS4NCj4g
PiA+DQo+ID4gPiBCdXQgdGhhdCdzIGludGVudGlvbmFsLCB5b3UgZG9uJ3Qgd2FudCB0byBnbyBh
Y3Jvc3MgdGhlIG5vZGVzLCByaWdodD8NCj4gPiBNeSBpbnRlbnRpb24gaXMgdG8NCj4gDQo+IERp
ZCBzb21ldGhpbmcgZ2V0IGRyb3BwZWQ/DQo+IA0KU29ycnksIHRoZSBwcmV2aW91cyB0ZXh0IHNo
b3VsZCBiZToNCk15IGludGVudGlvbiBpcyB0byBvcHRpbWl6ZSB0aGUgcGVyY3B1IGFsbG9jYXRp
b24gY2FzZSB0byBhdm9pZCB0byBnbyB0byANCnBjcHVfcGFnZV9maXJzdF9jaHVuaygpIGJlZm9y
ZSB0cnlpbmcgYWdhaW4gdGhlIG5vcm1hbGl6YXRpb24uDQoNCj4gPiA+ID4gVGhpcyBwYXRjaCBp
bnRyb2R1Y2VzIGEgbm9ybWFsaXplZCBDUFUtdG8tTlVNQSBub2RlIG1hcHBpbmcgdG8NCj4gPiA+
ID4gbWl0aWdhdGUgdGhlIGlzc3VlLiBEaXN0YW5jZXMgb2YgMTAgYW5kIDE2IGFyZSB0cmVhdGVk
IGFzIGxvY2FsDQo+ID4gPiA+IChMT0NBTF9ESVNUQU5DRSksDQo+ID4gPg0KPiA+ID4gV2h5PyAg
V2hhdCBpcyB0aGlzIGdvaW5nIHRvIG5vdyBicmVhayBvbiB0aG9zZSBzeXN0ZW1zIHRoYXQgYXNz
dW1lZA0KPiA+ID4gdGhhdCB0aG9zZSB3ZXJlIE5PVCBsb2NhbD8NCj4gPiBUaGUgbm9ybWFsaXph
dGlvbiBvbmx5IGFmZmVjdHMgcGVyY3B1IGFsbG9jYXRpb25zIC0gcG9zc2libHkgb25seSBkeW5h
bWljDQo+IG9uZXMuDQo+IA0KPiAicG9zc2libHkiIGRvZXNuJ3QgaW5zdGlsbCBtdWNoIGNvbmZp
ZGVuY2UgaGVyZS4uLg0KPiANCj4gPiBPdGhlciBtZWNoYW5pc21zLCBzdWNoIGFzIGNwdV90b19u
b2RlX21hcCwgcmVtYWluIHVuYWZmZWN0ZWQgYW5kDQo+ID4gY29udGludWUgdG8gZnVuY3Rpb24g
YXMgYmVmb3JlIGluIHRob3NlIGNvbnRleHRzLg0KPiANCj4gcGVyY3B1IGFsbG9jYXRpb25zIGFy
ZSB0aGUgImhvdHRlc3QiIHBhdGggd2UgaGF2ZSwgc28gd2l0aG91dCB0ZXN0aW5nIHRoaXMgb24N
Cj4gc3lzdGVtcyB0aGF0IHdlcmUgd29ya2luZyB3ZWxsIGJlZm9yZSB5b3VyIGNoYW5nZSwgSSBk
b24ndCB0aGluayB3ZSBjb3VsZA0KPiBldmVyIGFjY2VwdCB0aGlzLCByaWdodD8NCj4gDQo+ID4g
PiBXaGF0IGRpZCB5b3UgdGVzdCB0aGlzIG9uPw0KPiA+ID4NCj4gPiBUaGlzIHdhcyBjb25kdWN0
ZWQgb24gYW4gQXJtNjQgTjIgc2VydmVyIHdpdGggMjU2IENQVXMgYW5kIDY0IEdCIG9mDQo+IG1l
bW9yeS4NCj4gPiAgKEFwb2xvZ2llcywgYnV0IEkgYW0gbm90IGF1dGhvcml6ZWQgdG8gZGlzY2xv
c2UgdGhlIGV4YWN0IGhhcmR3YXJlDQo+ID4gc3BlY2lmaWNhdGlvbnMuKQ0KPiANCj4gVGhhdCdz
IGZpbmUsIGJ1dCB3aHkgZGlkbid0IHlvdSB0ZXN0IHRoaXMgb24gb2xkZXIgc3lzdGVtcyB0aGF0
IHRoaXMgY29kZSB3YXMNCj4gb3JpZ2luYWxseSB3cml0dGVuIGZvcj8gIFlvdSBkb24ndCB3YW50
IHRvIGhhdmUgcmVncmVzc2lvbnMgb24gdGhlbSwgcmlnaHQ/DQpCZXNpZGVzIHRoZSBOMiBzZXJ2
ZXIgSSBtZW50aW9uZWQgaW4gdGhlIGNvbW1pdCBtc2csIEkgdGVzdGVkIHRoaXMgb24gYW4NCkFS
TTY0IE4yIGxlZ2FjeSBzeXN0ZW0gd2l0aCAyIG5vZGVzLCAxMjggQ1BVcywgYW5kIDEyOCBHQiBv
ZiBtZW1vcnkuDQpJdCB3b3JrcyB3ZWxsIGJvdGggd2l0aCBhbmQgd2l0aG91dCB0aGUgcGF0Y2gu
DQoNClRoZSB1cGRhdGVkIHBzZXVkby1jb2RlIGxvZ2ljIGlzIGFzIGZvbGxvd3M6DQotIEF0dGVt
cHQgcGNwdV9lbWJlZF9maXJzdF9jaHVuaygpIOKAlCBvcmlnaW5hbCBsb2dpYw0KLSBJZiBpdCBm
YWlscyBhbmQgbm9ybWFsaXphdGlvbiBpcyB3b3J0aHdoaWxlLCByZXRyeSBwY3B1X2VtYmVkX2Zp
cnN0X2NodW5rKCkg4oCUIHdpdGggdGhlIHBhdGNoLCBpbiBub3JtYWxpemF0aW9uIG1vZGUNCi0g
SWYgaXQgc3RpbGwgZmFpbHMsIGZhbGwgYmFjayB0byBwY3B1X3BhZ2VfZmlyc3RfY2h1bmsoKQ0K
DQpJbiBwcmFjdGljZSwgSSBiZWxpZXZlIG1vc3QgbGVnYWN5IHN5c3RlbXMgd29uJ3QgZW50ZXIg
bm9ybWFsaXphdGlvbiBtb2RlLCBleGNlcHQgZm9yIG15IE4yIHNlcnZlci4NCg0KDQotLS0gDQpD
aGVlcnMsDQpKdXN0aW4gSGUoSmlhIEhlKQ0KDQoNCg==

