Return-Path: <linux-kernel+bounces-771085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBA2B282B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424A31CE45AF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F1828CF7C;
	Fri, 15 Aug 2025 15:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FArBhRyR";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FArBhRyR"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011055.outbound.protection.outlook.com [52.101.65.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7621DF74F;
	Fri, 15 Aug 2025 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.55
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755270702; cv=fail; b=BE0+Gcgq+WIRRqicC324flSJhfHRCk0FpdS7kpJiR4bMREMFUHyvWw6+5O5Es07tZAH0kTNJZ1SNGE1Ms8FbuU8vWU98mGxq2YbkFU34YUPePP/GA3YL0Pp98VG6aHYRRodqSHLKHkGxwfzQPNgRM2CaRBXGcSJTNBXDBESMoY8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755270702; c=relaxed/simple;
	bh=JRhf4CSgDZHDzyqUwItdL64comGfTSFsqfkQoNw0fqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oeRHu21lL7Lx7GT0Ey1UdYvz5lrXZD61QpZDWdOM2JI9/DB4koeithJJPfZONRI2QqWU4s+jYfz3/uD23U9eD9blbqVJeepwPrF/9/cKWak6EiaT2Wl63hMCTCue2zKaAkbL4BYCrbtiOCEKUnEUKLXfokqi1/0ztmAkZKnSIAA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FArBhRyR; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FArBhRyR; arc=fail smtp.client-ip=52.101.65.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=uMSs2Rp97sHDj7k9n3a3i/nVvijwwiHuw7eyKaomiiJfCOuM4F+rTyFNzs97RwsE2jCrQ6NcTb+YsezjJh3gzcv2D4d9j8AcfU999GdLiVooP4TY1uA0PaW++mRs55h4Tvo1zv6SDOk1nG8iMIIaCjvLbn06LVTJ9QlIjgpEriPrUHcxEJnezICyzUB5zx6zZz4QFXSciesCREwWnfnm5tMPCDLSlUISJSVSDgrtJ0pTMTEBNXXBsn9Ae3VNbgxOjbP7rTqAl7/jgsKqhj4Xam//ny0ZDTQIFbz7WC4e/RXMv/v/iRxf0xirzQdOLVxWJJpP20qBomYyUgp73UCJEA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LyzwvjqH8zDyBmgBULVL1FOqczlPPa6/80Ho9a3qv8=;
 b=MsjTawyQ/qKON5F/KdWkQ/yugWdGhoNS84tMV4PJf2gsAB0QhbNuf45CnV5suu6rZ211kM8Q2lbN4QAF2JOepVyFTJ4zTMd9WBr9sjYNf9Pgqek2dm0JxBDp/sY6yj1MgLdOcZK7Qy/YTAM0leMNOuHL7FJwf0dELBYvQ+sn0e9WGCKAhPx2BAASQtK/sWUCkCNoHVLDHJjg8Qcy1D4whW9k0w03pOnoPIgJlMTojiyCECFXUe9MR4m0S66X9CCIKgnm9WJsn+bVl7rapgzjoY98V3HUfruRpEWE2IimuLLRSRWrRbCzXBIIMFKUrz/mjDy6uEhVX2xrNW8wWKR6Ow==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LyzwvjqH8zDyBmgBULVL1FOqczlPPa6/80Ho9a3qv8=;
 b=FArBhRyRG9sD8w6+g5uD1SfZgYp0R49HTWooTC5tVzMdHbrGSzWoZZnK0PvjaVycRgqiBmfS1dvt+ymUiw/+rvdF5poGQNpwlI311ZVElMHSEobPIaSp7rhj/2Csm5l9iC3EHR76Up1Rf9QVfuP8YYayfYRtpiRjsjRMmCLPQKs=
Received: from AM0PR04CA0092.eurprd04.prod.outlook.com (2603:10a6:208:be::33)
 by DB9PR08MB7675.eurprd08.prod.outlook.com (2603:10a6:10:37e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Fri, 15 Aug
 2025 15:11:37 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:208:be:cafe::b4) by AM0PR04CA0092.outlook.office365.com
 (2603:10a6:208:be::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 15:11:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.11
 via Frontend Transport; Fri, 15 Aug 2025 15:11:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWf7GIEX3Bk2CeYPCNzwpDIPmTOSvdMNaRhIzwCJ02TRyB1VT+gBPzA2s5gtt7S3wp5cQuSCR30ZxKY4Ie8ixGC85eE7qDAkEMzZrVLG8K7kSnw7xXG2fIwQhLKjrBYmh2vbmp6K9mB5QUguqRiOsPosgRhvSGXqq/ZgYCxARurl7axuMi4VZouyA8B3fNQzQGu1/RGm6uI1ScQ2ioYyoYHXL5GEb4tTCvbmBxrSe7yRxw+StyDxnHXcsn0a7fh09FA3HabaD6wSEEptg2gSljejJo+o8ZqbEd+708SmQoFXEigduAXWSQst+hv0gtRWgKwWxC4kHAEFcN8ZbhBWdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LyzwvjqH8zDyBmgBULVL1FOqczlPPa6/80Ho9a3qv8=;
 b=KKcqlo+iCE+pmOSGrJQG3HRw5J1KcA6FKpGf+kRyyO/aWzQQOnN/lR/biyEra7e6gL5OoYDWSrjvK9r+lkVuge1exw9dk2m9LLrJ5mGH0Q/GlEZXHJuMNQZB2FGs5Pr7/iYigyKiMLZdCTqiXQ7nLMPSwexWPWgBLGzV+bhYy8ylA+87gPLhbECj9WsC4Wc3Qi5aqe8JoWaI1aHrLL/1u50T3FkvgryuSBy+bgkg9h1yE9f5cjslEA/07yjdeCdUJfKw59QRJp4Sf4/HfW30+zxFRNC77H2112ris156tetPa5FxiAwE9dtryqc6CJR8eQkJJEI6AqtSNmRnMWOQRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LyzwvjqH8zDyBmgBULVL1FOqczlPPa6/80Ho9a3qv8=;
 b=FArBhRyRG9sD8w6+g5uD1SfZgYp0R49HTWooTC5tVzMdHbrGSzWoZZnK0PvjaVycRgqiBmfS1dvt+ymUiw/+rvdF5poGQNpwlI311ZVElMHSEobPIaSp7rhj/2Csm5l9iC3EHR76Up1Rf9QVfuP8YYayfYRtpiRjsjRMmCLPQKs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by VI1PR08MB5423.eurprd08.prod.outlook.com
 (2603:10a6:803:133::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 15:11:03 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 15:11:03 +0000
Date: Fri, 15 Aug 2025 16:10:59 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
	dvyukov@google.com, vincenzo.frascino@arm.com, corbet@lwn.net,
	will@kernel.org, akpm@linux-foundation.org,
	scott@os.amperecomputing.com, jhubbard@nvidia.com,
	pankaj.gupta@amd.com, leitao@debian.org, kaleshsingh@google.com,
	maz@kernel.org, broonie@kernel.org, oliver.upton@linux.dev,
	james.morse@arm.com, ardb@kernel.org,
	hardevsinh.palaniya@siliconsignals.io, david@redhat.com,
	yang@os.amperecomputing.com, kasan-dev@googlegroups.com,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 1/2] kasan/hw-tags: introduce kasan.store_only option
Message-ID: <aJ9OA/cHk1iFUPyH@e129823.arm.com>
References: <20250813175335.3980268-1-yeoreum.yun@arm.com>
 <20250813175335.3980268-2-yeoreum.yun@arm.com>
 <aJ8WTyRJVznC9v4K@arm.com>
 <aJ87cZC3Cy3JJplT@e129823.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aJ87cZC3Cy3JJplT@e129823.arm.com>
X-ClientProxiedBy: LO2P265CA0374.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::26) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|VI1PR08MB5423:EE_|AM4PEPF00027A69:EE_|DB9PR08MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 7db7fe2f-280d-4677-c312-08dddc0e07b5
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?SmhXaGhRVTdObVF0akRHc2psbWJ1OWpCVjlPZGV0ajloL3JmcEIxeHdKYVh0?=
 =?utf-8?B?R3NGTkVxQXhzZitFZVM5d3E0eHBqMVhZa0wyVkM3bEZpKzRoQTVxM2hiZjM2?=
 =?utf-8?B?ejhWRjVpQVZsTGcxaGRyVHV5M2NudmNIeUlLS3M0UVkxMEc5THpCMkdxMFBq?=
 =?utf-8?B?ak5IZGZiTUlFWmFqQnAwUE1aZ2xlQ1pYaWJVZG1nMG5Sb0RLOG5LbkFvTjBO?=
 =?utf-8?B?dlpKNCtYaHpQNnU3SFlqUFRWbEJWdEpBNngyQi9nWkNMZmtYelhBUU95VFFn?=
 =?utf-8?B?L0xnZW03OEdsOXNpRlAzS2pzSFpGOVJhZ1dNZk9iNU16VzVSWmRyWVhCa3NJ?=
 =?utf-8?B?aTlvZWNWVzQ2T0RmTDZ0WmVMMHZ3MDdkZ0c1bmRHSldEUENXdnNVMG1Eam1T?=
 =?utf-8?B?SnVZZ1FCOTNJUzl5MFJVNVo2VEQ1K2N6UG8rOWxLN3VobDhNeGRxSnUwTnll?=
 =?utf-8?B?ekFwcys2WlFUNkRkSnlVNFdvNzg2aUExQmVtRmxQWFhaYUJiUHNKODJ3L1Uz?=
 =?utf-8?B?NUxLMDU4S1V4N0t3Y1VMYmhoMzBGMDgvQ1hKSkZMQWJOek1jbFpjWEhxcmxh?=
 =?utf-8?B?U05JUENnby9TZyt4dWw2NWVjZHVhVFdIMkZOeUlyQUZJNXNzeEtZc0I1em9h?=
 =?utf-8?B?Nm9RV1I5TWNrQTYwQ2ZydDhiNnNCVmpPcHVTOUlseWhKQUFZbUkvSTBKQkNX?=
 =?utf-8?B?TEU1NkNZUVRNc28rSmRGOTREYmZ5VFFyeEFyRzlhaWlVMjVUS0IvYU41SEtU?=
 =?utf-8?B?aDh5dGd3YlpGSGRZUjVZbTBMQXZKRWhGMGJhL1VWOGlEbTRROGluTEFUMmsr?=
 =?utf-8?B?WHc2QVFzQktZRzUrV09ZNzBGb3Z3ajJFZE9YNnpzelJiWUFNRXl1cjdaNGNR?=
 =?utf-8?B?NVk4NTdvYWNiTzQ1dER1WUNOYkVVVG5QUjArdWNaOTduWlR1ZUhjRTlMTmF2?=
 =?utf-8?B?RVhZcjQ1NVQ2UzI4MEdSZmpJbVpDdzdWd3h3eHY0TFpuNU1uNGVuRG9ZTktL?=
 =?utf-8?B?eFRULzhLWS9SZGlva3N5ekNXTHZ0bmV2bzZYc01xbFR2MWFBN2lHMDFmODZK?=
 =?utf-8?B?OE9HTDZTTW9ISE9WdzQvajU1TGNjRDFGdStEenNucmZiOGc2cFdkcm56TkU4?=
 =?utf-8?B?MkUrdXk4VUNta2ZkQS9JaDJmbDcxOVNJYXdmdEwra2VNbmtib20xdSsxTk9Q?=
 =?utf-8?B?WTQxOGFaS0VrM2dMYXBDcWFWdE51WWFDOWwzZk9jMXgyc1lKRVRUNExpbzEr?=
 =?utf-8?B?eDBIYkpWL1hCWmNWY0orQ2JNYUtvZmcvTENuWDhUSm9CbS9hdlVjLytDSEhB?=
 =?utf-8?B?U3VzejJqd0hHaEpSYnFkcTZLTjhWSDJWVXVjVi9YSEU4eFpEeVRialpDZFRF?=
 =?utf-8?B?UUI1ekdzYVpLdlJLQUhITnR1NXMvelZHa1VpaG9JY2xPdGxacjJpamoxTm5Y?=
 =?utf-8?B?bG1yMllFbTFnQjRUUXQxN2N6cFpvYVkvdlpQb25xRFBqejJjSVg2Y25OaDFl?=
 =?utf-8?B?aXp0WlpYT0VEQ2pIbi9wSDZmdkFQbzhnNkZvZWwvMVk5YXZmSFJ2NXlRRzFX?=
 =?utf-8?B?M3RBQkMvNmFlWThvMTdkZ21rcUZ6bXBhUmc1Zlk1SWFNN2hBckx6MDd2VTBS?=
 =?utf-8?B?Y09LemtzQkdTdFVTNlNKMmUyS2ZvMHppT2VhWWRoNHBTNkcyRDdFell1UHgw?=
 =?utf-8?B?ci91NG84SlBHMlVtWCsxUisxeU43K0hpZEp0Yy9NUkxtVjdoelVOTjN6SzRP?=
 =?utf-8?B?Y3kxb29SZURJNDltTmRrMkFpTUl5S2hoc1E4ZmcrT3AzUDVYYTRiZjF3WVN2?=
 =?utf-8?B?YzJ3cFd3V0wwMWR6MFZhSjFCN2dQaHYzSEtycDZqdXBFVjVkNjVjOFE1U2My?=
 =?utf-8?B?N0RJYVhSKzJ4T2hMcnJVZTVJRjM0a0t6Ymhjd0p6clhEN3NDY05mcmh5NE5W?=
 =?utf-8?Q?pC9rMKmxgx0=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5423
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3248e2de-d1a7-4b1b-5eb6-08dddc0df38e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|36860700013|1800799024|82310400026|7416014|376014|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enZsZ0FmZ2NkckVaNy9YcGVTWWo4R2xHb0d5TFhVUW5xaFJmbVExLzBBQndG?=
 =?utf-8?B?V2N1anYvaTNZaDFJTEp1SVlZV05zdEFRMGQ2RWVvUUhUdVdRdnJKWWhIYjg0?=
 =?utf-8?B?Tnh0MkJlS2R2T3JCb0Z5NmRXOUwva0lmVWdXdWszM2R5WkR2VlNEV0dGR0dP?=
 =?utf-8?B?bUNCUEg2YzJtL0V2Njcwd2xwalFDWEozWFBFNjhOb1QvcEkwRjF6Wmh2YUNL?=
 =?utf-8?B?L3NIVkt1dlRaK3E0bE5zNThVV1ViRjk5YnRjckVzeldLaG1BcUZxbnZTdFZp?=
 =?utf-8?B?dkFKM1lvdDVuSzc0SHg0TUt2bUNjRDZCdG90aktwOE8vWUJrWE92WTc3RVhG?=
 =?utf-8?B?VE1Hd2xWdFArb0xObm5yMndGd0ZoNXRtbDR3WFRDWVB2ZnpqMmdTenJxdEkx?=
 =?utf-8?B?SnNNMFdnenpsNEFVNVpXa2FNV0N4MWUxYzc4czhOMXBERTdYc0M2SE1uMGFn?=
 =?utf-8?B?SUgxaHl0RmdzbitrU2RwQkY0OG9COFJmcGJCNDRWaURTbWlMdmVCZlhzRDc2?=
 =?utf-8?B?L0VqSVBydjd2ZVdPS2tUMURoaGcwTmg3eW0yYU1QZXRITlJQQmtEUW91ZmpG?=
 =?utf-8?B?QUExUnByTkc0OU5mOHhicUJMM3VSTDZmTnRvclV4ZGM1UFV0cWxRSGpnMi9w?=
 =?utf-8?B?NTVCR213VnhEWlUyalNUMW42S050MXdma1ZFUzJ1cHRCM2tjUDJobGw0K1ZS?=
 =?utf-8?B?WUZ1UldKTHBsTXltOGpoUEtNOVlrVkNjNnFTOEZYSjBpZ0RRNFU2d0dxMHlF?=
 =?utf-8?B?dFN2OWZGRjU0b052YWx1b3ZPU3ExUG5ENjZ6dEM0T3JEN2xhYmx4UFgwK3kx?=
 =?utf-8?B?ZytQQXYrUm5rMktleDQyVjVxRXZ2cmxCamcyazU4VmVHbmlPQ2c2TDdoV1RZ?=
 =?utf-8?B?SXIvK1czOG0ydS9COEx5RVBsV1NGZFMyTFN3UlN5M0xTWnRuTFovbjR4RUtC?=
 =?utf-8?B?THpBTmEraUtSeGMxZFlscnZRTVVFa0w3UXdGOU5IRm9WVXNPdkszU2J1UVM5?=
 =?utf-8?B?N25wOUxweVdkM2htRGNSc2VnTEt2Y1NSaVMwVXVBMndLaUhEYkM0dVBzaGZm?=
 =?utf-8?B?NlI3TWZtcmlyNlVTTGxVMVlnbEJHeGNKdWxmMG83bHlSSythTW14aGs0V2d5?=
 =?utf-8?B?RW5HdUxEcldhWURTcnNGVjRNaTV5TTJOUFRqRVRJVVByRC8rK2l1QzNvbU9j?=
 =?utf-8?B?QlpCRHdES1laV213Z3Jhd2YwdXkwZTdvTldWc25NQ3BRcU9xaUdoSzd0bm9B?=
 =?utf-8?B?RVF1cDY2N0VWNTFJTW9GVllUa2hKUXJMM0dwUWpJRGZmTEVsbjNxS0Q4L1JV?=
 =?utf-8?B?dXVzdmMyd2pOSGx3NnBHWXJudEVZV2crRTFqSjU0VVNFN2piQzR4eStaTENo?=
 =?utf-8?B?dWt3eDNqWFNZUjFhY1hVYzdWOTdINHdWMW5lWm1oM0NEd1AwdDZ2dVVucytF?=
 =?utf-8?B?ek83NFpDRXRvZXdRU25kK3MreDRWVWw3YU9rL3NRMjlxY1BTL1Q1M0lGcVlT?=
 =?utf-8?B?SlZvZ1I3MU56MVAzczU4SzNHLzc0VWg3VTF1cTJSL1FKQ3ZqczlOR3JDdkV2?=
 =?utf-8?B?YkZHek05WmV2RTZMVnJOUnRKZHZxbmR5YndaNDJMTHhQYnhLVjRTZkNRNmpr?=
 =?utf-8?B?M05jSnR5NFAycG5XcGUzMHV2VGJkYy9zTkJMOVBWTU9vY3NhYU9rbVFCMmVX?=
 =?utf-8?B?M0xiaTNCT2xjWko0Yk9uWlMveHhTSWRhNW15VFRyeE5YbG9yUUJqZGhvYUFU?=
 =?utf-8?B?VTBiT3Q4Vjc1YkRKQW1sYXE4VGhIalVBMzFHdFkwbDhseWY4Mm1ENFBTYWpt?=
 =?utf-8?B?MTRJUkcrN1VNWEZlNnJKZ3dnY2JZbUw4c1BZSkRROVBpZXJxN042UEx3bGlE?=
 =?utf-8?B?SGdhSUNOQzBRUG5GV0VpQUt2MFRQOTFMMFp0YU9oZzVmTGdQZkJabXRlbjFN?=
 =?utf-8?B?dXR4WFZtdG1qSnZXNEJkdDcwVjNtdys4ejV6aHdoeHFvU01zY00vSGdaRk9x?=
 =?utf-8?B?YzVqbWZ2MDdtajJPcG1jblgwN0RyZmppa2tkbU03RGVOZ0cxVW1LL1dYcTZ6?=
 =?utf-8?Q?ZkDYew?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(36860700013)(1800799024)(82310400026)(7416014)(376014)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 15:11:36.1249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db7fe2f-280d-4677-c312-08dddc0e07b5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7675

[...]
> >
> > > + * Not marked as __init as a CPU can be hot-plugged after boot.
> > > + */
> > > +void kasan_late_init_hw_tags_cpu(void)
> > > +{
> > > +	/*
> > > +	 * Enable stonly mode only when explicitly requested through the command line.
> > > +	 * If system doesn't support, kasan checks all operation.
> > > +	 */
> > > +	kasan_enable_store_only();
> > > +}
> >
> > There's nothing late about this. We have kasan_init_hw_tags_cpu()
> > already and I'd rather have it all handled via this function. It's not
> > that different from how we added asymmetric support, though store-only
> > is complementary to the sync vs async checking.
> >
> > Like we do in mte_enable_kernel_asymm(), if the feature is not available
> > just fall back to checking both reads and writes in the chosen
> > async/sync/asymm way. You can add some pr_info() to inform the user of
> > the chosen kasan mode. It's really mostly an performance choice.
>
> But MTE_STORE_ONLY is defined as a SYSTEM_FEATURE.
> This means that when it is called from kasan_init_hw_tags_cpu(),
> the store_only mode is never set in system_capability,
> so it cannot be checked using cpus_have_cap().
>
> Although the MTE_STORE_ONLY capability is verified by
> directly reading the ID register (seems ugly),
> my concern is the potential for an inconsistent state across CPUs.
>
> For example, in the case of ASYMM, which is a BOOT_CPU_FEATURE,
> all CPUs operate in the same mode —
> if ASYMM is not supported, either
> all CPUs run in synchronous mode, or all run in asymmetric mode.
>
> However, for MTE_STORE_ONLY, CPUs that support the feature will run in store-only mode,
> while those that do not will run with full checking for all operations.
>
> If we want to enable MTE_STORE_ONLY in kasan_init_hw_tags_cpu(),
> I believe it should be reclassified as a BOOT_CPU_FEATURE.x
> Otherwise, the cpu_enable_mte_store_only() function should still be called
> as the enable callback for the MTE_STORE_ONLY feature.
> In that case, kasan_enable_store_only() should be invoked (remove late init),
> and if it returns an error, stop_machine() should be called to disable
> the STORE_ONLY feature on all other CPUs
> if any CPU is found to lack support for MTE_STORE_ONLY.
>
> Am I missing something?

So, IMHO like the ASYMM feature, it would be good to change
MTE_STORE_ONLY as BOOT_CPU_FEATURE.
That would makes everything as easiler and clear.

--
Sincerely,
Yeoreum Yun

