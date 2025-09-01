Return-Path: <linux-kernel+bounces-794311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E559BB3DFE1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 141067AFBB7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919CF30EF65;
	Mon,  1 Sep 2025 10:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="X+cx/0Oi";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="X+cx/0Oi"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011016.outbound.protection.outlook.com [40.107.130.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A9430E0F9;
	Mon,  1 Sep 2025 10:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.16
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756721693; cv=fail; b=bcul7D4HmKBPek/CkI6MetDwkXcZ2Pe9znlxhOffuMJEmLVNRCLuiBq/qEy6RFXcGCH7si+J3g9hFwHSyXe8xyIgt7mc3+/OKqaKXNAwNDdne4WpzoinDbWIbl5kjWM41Nsl5qc6fH0YbBFahKrfgF4p9KzvRaGLTzaHzjWJpRw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756721693; c=relaxed/simple;
	bh=LeK6pHFi8TtB/QfOM3nDZ4oILORU6w8KyrfY7YSDZ/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t7G3rKwLFiwp290xVrfQG1miWZ3bOp5YPITH1/IirmKg4laanMpo7BfN/oKY7p8hVGaEV81ob+TjW3B1RFnT8ManlhsQOU/QQY1ZHWpj8pcAmtiWaSU20kf/8kT14fEFEe3FDhiW6gHON/ifB20tE8IYbvrD2AMQUTda/h9V1uQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=X+cx/0Oi; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=X+cx/0Oi; arc=fail smtp.client-ip=40.107.130.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=SLSrTzLjBCn6HxVvHPspwv6AG2SQ+5kQn0t6iVgP6Jmmrf9+7SdMV/j53bLzKl42tYLsuZz2j4CrLUNy+OnAuL8hLds4NWKOGKH8PMZCKCJHyzyTSWI319yM5SiAMCHBm4NffpLekJ/Q8MAvqAdTWmTzvK7v2YTMi0nKHWBLWJ00EUOiV9db0hJ4lD1SZF/DSFVF2cXxo9LkDpkTTGPn9/haWRDwBhLRRYqpofpfnrqrrA8oTY1aju/gFDgw5ep8kaXQCokOl7mKEELQeH1JRXAlPOXSKlMRhzMgzpt3C2tKNoS9m2bE0w7PAeCAx0buPq+uQoRbtFTLTbd9gMIENA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVA01w4bi/NkBxEwXo2razR+P4a1alwO7TaelDcNZa8=;
 b=mFRFMsHN1ndXITdlteleoiOEZfEVb/G2NHVykcsWCHvLYT/3/6UaNjNBebQHi+UcbuiJZJcGPbaU5sGb/HX3FEoln51h4zkO4L1E/umRoq3WwqInYNxttNmL2HfbMoJpNvowWEhZDvWqf8e1KGHr5f9w//yoAqBhVnW82Atni0gtpsOiNZaHAtIE8TApDs9fCs3POHroSaPugdGNcCRt6aotroeXbDoNE+kxVWYwh6qjpQjnjuMI0yQOAo66YxUGuogL5HEX3PWHMFkJbMFoWjetmMEYwq+AdEuu3oQBllgUjB3t2bC8+bku63CeizkYTNAEaCmZVhGF7gy+nKDUUw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVA01w4bi/NkBxEwXo2razR+P4a1alwO7TaelDcNZa8=;
 b=X+cx/0OigfWc4wWZ9in9odofsklz5GLE/d1ETqqr8w96fWquL+BmtC1jGH4H/HYvvy13ED1ZQXVYU2I1B4dp08hymOl8PKLhjvObMnU/vYSh3ZlxEhCkOWDHZxPygiKx11fX+EUXRtzLnD9l43+/Ap8gAI5X+ehzOFox6Fl5+Og=
Received: from CWLP265CA0392.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d6::17)
 by AS2PR08MB8877.eurprd08.prod.outlook.com (2603:10a6:20b:5e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Mon, 1 Sep
 2025 10:14:46 +0000
Received: from AM4PEPF00027A61.eurprd04.prod.outlook.com
 (2603:10a6:400:1d6:cafe::23) by CWLP265CA0392.outlook.office365.com
 (2603:10a6:400:1d6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Mon,
 1 Sep 2025 10:14:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A61.mail.protection.outlook.com (10.167.16.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.14
 via Frontend Transport; Mon, 1 Sep 2025 10:14:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1Hm1jkhM4KhYDz+H6HRrpl1Vm7qWFiUnS/FR54TtTXHKA7AXqtnFXu2M+qgq79EBrttfRYeL6K84ASdFl09lsuqlNCESn8CFcfb+iAMVFQ5/JeGuhsB9xg/Ofa5hO3DwjruVwUVZQlyV6oNjQbnByUKCSt7bd41xK5B39PWN+uHJV2/cl8foaw/EEF4r/UHH3UOU1WAFCcgFe2IYBPxkYv9DXmSs/iKjQqnnkiKG0+5E8/jY/SmOablIFbEVz6jMKnFXuh6hUEQZkYuHYA/4zyqmyIVr4slvuA2Pt/Ue+kwubvUq0tGvyJQ8HGZ+H+xDa3unV1GmSkJ87a+MKoM8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVA01w4bi/NkBxEwXo2razR+P4a1alwO7TaelDcNZa8=;
 b=fKeF6XbzNPLGMIYB0N4ARDbfDW5s1zE0T6hEBEv8X1PB16ot6yU+BTQNMLnmMbCejaTcnRLy91lOftIKNTJ4AGLg3prFMLxaEM1Q035OSO/nYGnE6QvkYWQVSQBL1W5CWGKe5kyvRTGUyqAfaK9TeClFrMUbH2X5dm/tmLFgFA5hoMfAnFFapCnZkCOLg64uUrby6KwD4FZCTDbVUgNlBzNFhhDCs0O694jiLgqOvRTHv9Tg+wr6waCKftF7zblfqtyZH8itb4TkzU9sjsGze1tSjs8lgWZnk2UOId5zLEqD+cDufMH5YyrtWXJdMGIU9wYn+FUfawYq6EsF2nnyZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVA01w4bi/NkBxEwXo2razR+P4a1alwO7TaelDcNZa8=;
 b=X+cx/0OigfWc4wWZ9in9odofsklz5GLE/d1ETqqr8w96fWquL+BmtC1jGH4H/HYvvy13ED1ZQXVYU2I1B4dp08hymOl8PKLhjvObMnU/vYSh3ZlxEhCkOWDHZxPygiKx11fX+EUXRtzLnD9l43+/Ap8gAI5X+ehzOFox6Fl5+Og=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AM0PR08MB5298.eurprd08.prod.outlook.com
 (2603:10a6:208:188::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 10:14:12 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 10:14:12 +0000
Date: Mon, 1 Sep 2025 11:14:08 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com,
	vincenzo.frascino@arm.com, corbet@lwn.net, catalin.marinas@arm.com,
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
Subject: Re: [PATCH v5 1/2] kasan/hw-tags: introduce kasan.write_only option
Message-ID: <aLVx8Pxq7eZgu/8A@e129823.arm.com>
References: <20250820071243.1567338-1-yeoreum.yun@arm.com>
 <20250820071243.1567338-2-yeoreum.yun@arm.com>
 <CA+fCnZfv6G19P=bWqEUpbA36E9zaHBqDBZyDYV5YnMuAX1zGug@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZfv6G19P=bWqEUpbA36E9zaHBqDBZyDYV5YnMuAX1zGug@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0650.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::20) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AM0PR08MB5298:EE_|AM4PEPF00027A61:EE_|AS2PR08MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d8f1765-4bb7-4161-3bde-08dde9406087
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?lZf0P+jk8MTKNMTGMdsYUdXrqM62xfWK9Oyhjo/boqha1slEW8Z7LKlp+1M/?=
 =?us-ascii?Q?1NxTmSPNo3nWXJ3RJQvkKR6xjGGeg4xBuv3j97xlfuhAzPWjwsp8Ec6+Xl54?=
 =?us-ascii?Q?9TST5IFHfCCDaUwggvD2zh8bU4iRbexmQ2yB+ityrXyS38kzN3T67f9ydmRz?=
 =?us-ascii?Q?BVX23nnfKBJHrSzo/vieRZmaa415bdgrzJ8BqH9cJPNERhKruNt5cXOvzOKq?=
 =?us-ascii?Q?I9KlqgQHSg8yZnv4EKIyxJBzEiuMYYedY/mAzr1TlVFjWLCVjuuiZY88tY6K?=
 =?us-ascii?Q?yhjCr9o7xqjzsrv460LYBH+Kq2wML+LvocKvx2gw9Zk9bIXLmlPMaoJ6hy/u?=
 =?us-ascii?Q?8OwiUoaO0QTWyGHUcei8TJiZhbMJGdOLgmpy53u9X7cBWbfZ/IzkJQ3X2x2p?=
 =?us-ascii?Q?1HqDOYcHkoFdpzzxWvbhZ2bhO6hrCt/E+tapI5SD+6En/STgxZRHDic7rkbW?=
 =?us-ascii?Q?AhWER888CeALYarfIb6zo7QhipWvdlbAnI584jnTenzAbt+TlVaddswY2921?=
 =?us-ascii?Q?ZlqTeLqBLs0oDQDxWZsukWXzcRFKrkMnBKMq1cjKwj4yBAVkWH6xtBWvngMz?=
 =?us-ascii?Q?AqlELKZ5A8iPFS5Kb4DCGchU765xJeftHOh4px8oe0n51N104oSN5oODFO9C?=
 =?us-ascii?Q?ECe6giWcCh5UUEK2nuoLaqdqZinKsnWtKT0OX2qtq/7V+98OoPz0WV/9FEE2?=
 =?us-ascii?Q?H5hExYHEllgcDUEKEB7/qSxxngWGm9xzpiTGkpuae3UcALeByr0oiAMSz9c1?=
 =?us-ascii?Q?l7ERUmwW+4oZoxYb2nX33u3crTEbEVeIGhYXb5QcN/KcQWuOi6wBERbDjmR6?=
 =?us-ascii?Q?RwGK26pSgahIPNdNFksXw0O9VFYatsQ+C/TZMSBykfZLqqngcc/q4qMxw662?=
 =?us-ascii?Q?iOtx9YzY42tEUKgVxDtL7o6h20mV9FztBGdbiHRaKPrfydLCR25jQVj4t2jY?=
 =?us-ascii?Q?smTVnn21wyk/tNs+SFKAJlC5rYMfOV7nQa4udjYCnLHpCs6Zfbsv2fq+VZe6?=
 =?us-ascii?Q?tspOMys8nNLd3lbGxVWgSbPXSNUZeeBUxNg6c/C7Dncpyu++xQ78bPr/uc1L?=
 =?us-ascii?Q?OHFJLcjhdsU9T0DfKql/BEhmyW6oWq1NZtlTuKpTIpnY6klifY2AzgP0/Xb7?=
 =?us-ascii?Q?jHS/TvEPAwbe7yhk2Leq5Kd4spcBb9k7VvjLRIbW1tOgCyt33xc0/jHuB6kd?=
 =?us-ascii?Q?UKFNsplYDT8FDgs0DuBMjSd7wvzJBztbZtAEMqUF1Xd/vEWqcs1J4XW2nVHA?=
 =?us-ascii?Q?GlqeZVAinIJn3xrr2A7LIcIS6bfCYdFhpsnyJj3egLsKua9DHUHkklFZVQRD?=
 =?us-ascii?Q?aBsIMqfKeMKxSqdbjZ3l4uR9K6763LavigiS8ojqSOe6rcZNJAK4hG36wrp+?=
 =?us-ascii?Q?GCfkom4UzBNhf7iPuoKdzEoVUedBC3qZsicJq1mqCxObELLwrA=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5298
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A61.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	036e298e-b700-43dd-5fa8-08dde9404c46
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|14060799003|7416014|36860700013|35042699022|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TEqRFksL+no/8lMry7yvt+tiym80o3ioPlqNPMe83m/JIhbRoHdIU4RncxJK?=
 =?us-ascii?Q?2vJR+EJuKvNdM0CA7HwBQOianofK5K0GWb6i8L9/MZ4sReC2jNg4ogV/hjLH?=
 =?us-ascii?Q?F6E740N0dZ9qxAjFrWSmy7m9Pgv4qOO8PKNEjB35R/OcsKQdxYNeA83PHgXl?=
 =?us-ascii?Q?6aIJS/+8w+Bv/LZH1Ei+UFEOMmECm4nFVIjRIjAslIZFdJwdrukMWe+B+Qo7?=
 =?us-ascii?Q?+ZzXQ4TscZizKzW9k8Q0KybiFa1jTodJLZt6jKXQNzp0Bw47TFvTVQupA4kb?=
 =?us-ascii?Q?z5tnjUYqpVvrgURAobsLSqw6V58GB4uH3b9Czoyny0PH9Zbispe+/zT02+j4?=
 =?us-ascii?Q?fBRvAc3JKfHwt8US1qasGTEcb76jXFO9WzgqTWR9qGQH7OMuRQvUJzhxvhXV?=
 =?us-ascii?Q?XsTE4aZx68mJyVFnnGH+xYx4w/gEQubl+U/NAJWFUk0Mn4h7Gel+T1IIuESo?=
 =?us-ascii?Q?cmVXmsFmrVFW1WU26vVT90X/OJMhZjC0cmHYpPnKaHLAA8fmTv4Ji0I32Afn?=
 =?us-ascii?Q?ygiSAtQ9Uhho6e1ZUUKEgAdwnM71Ea7CfsbtO8ucTHdnnOZ8Fl53lzTfzcQB?=
 =?us-ascii?Q?Z5gXCT5/V0TFkScb3d73mmKHbTIs7uqyoLsJp2k7N6UZ+3oi+/AHs5GCm6L9?=
 =?us-ascii?Q?zYIBXstE/eZL56/49YI3Y0inLK2YcVa6Rl8VanH21G0VTyPxp5pjg2jJEFMZ?=
 =?us-ascii?Q?wPcwsrLISERdd6dQ+4B7J8Wsq4FQvGKinUZj7UHpEUdejb9kQMZs8mZFtfs6?=
 =?us-ascii?Q?YTrA8RSZjRlgafmzjiokY1Khc9ZEPBbaV4nuLErj/gejmHB8w+nMLPo7Kev7?=
 =?us-ascii?Q?At3j20J3KxbZmm8PFBH78mRXCJ5cMlT7HcOiqnHvmGVTN6Wd373W1DUlXFl/?=
 =?us-ascii?Q?1B+Wr4XRac9qzBUVBEI/eO+0HSx0CNeLVd90bbU2Jc6yarhZkuH9oqzA8XoJ?=
 =?us-ascii?Q?L89vGvh82ofcbb2n79pt/onxK8pROId7Tgv8h3SnPDNIXvNYDDS1JCyDpoH6?=
 =?us-ascii?Q?V2k3o4IH1seQOefwTSiJN2ruNxrv7OESGd3bvG6oneyLcuhFfW+dxZtGVF1e?=
 =?us-ascii?Q?5aQWsX8VuimhDFzSJEcmu3OwFoQbaUe4D3rZWtyU7hG1KpQpkKIpkdOtDZsK?=
 =?us-ascii?Q?pBRkKsEsNqUCNHfxnxdjHy91jcqiAMXL8kdlCtbLYQqkEkJP8BPwLD7psGsc?=
 =?us-ascii?Q?T/9qpAqI425rLUWLIRtP97yUpYK9j169PDyv+V6s+PEDughoX7S8L+OI9tIu?=
 =?us-ascii?Q?K9+lxLnBlOv83qDXZuvgjf0zRViG8B0oA675HwNg2JgdFiKyhTGuco+MTbOe?=
 =?us-ascii?Q?LBs9fbVLyTEcn4tGwxtIceanNLp71WzKbDa+OetFnXxvJzv2MpfPnZNODqpB?=
 =?us-ascii?Q?f0NAAFswX0akVeXOHOfB2WeriMLZ69RxR5CSbgBnFeB8JSHxc5EX7SBzHNyE?=
 =?us-ascii?Q?JmDwmqsCcKUQtOHza5E7rRjHsXUYBXgFSJicefKrQuEjNjTIcVZ8Z5Ph67bd?=
 =?us-ascii?Q?j6Ki2pmdtkdS75Tf8bp+KQdbK1UsvASUzIA3?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(14060799003)(7416014)(36860700013)(35042699022)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 10:14:46.2284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8f1765-4bb7-4161-3bde-08dde9406087
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A61.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8877

Hi Andery,

[...]

> > diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> > index 0a1418ab72fd..fe1a1e152275 100644
> > --- a/Documentation/dev-tools/kasan.rst
> > +++ b/Documentation/dev-tools/kasan.rst
> > @@ -143,6 +143,9 @@ disabling KASAN altogether or controlling its features:
> >    Asymmetric mode: a bad access is detected synchronously on reads and
> >    asynchronously on writes.
> >
> > +- ``kasan.write_only=off`` or ``kasan.write_only=on`` controls whether KASAN
> > +  checks the write (store) accesses only or all accesses (default: ``off``)
>
> Nit: a dot missing at the end of the sentence.

Thanks! I'll add it.

[...]

> >  #ifdef CONFIG_KASAN_HW_TAGS
> > diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> > index 9a6927394b54..334e9e84983e 100644
> > --- a/mm/kasan/hw_tags.c
> > +++ b/mm/kasan/hw_tags.c
> > @@ -41,9 +41,16 @@ enum kasan_arg_vmalloc {
> >         KASAN_ARG_VMALLOC_ON,
> >  };
> >
> > +enum kasan_arg_write_only {
> > +       KASAN_ARG_WRITE_ONLY_DEFAULT,
> > +       KASAN_ARG_WRITE_ONLY_OFF,
> > +       KASAN_ARG_WRITE_ONLY_ON,
> > +};
> > +
> >  static enum kasan_arg kasan_arg __ro_after_init;
> >  static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
> >  static enum kasan_arg_vmalloc kasan_arg_vmalloc __initdata;
> > +static enum kasan_arg_write_only kasan_arg_write_only __ro_after_init;
> >
> >  /*
> >   * Whether KASAN is enabled at all.
> > @@ -67,6 +74,9 @@ DEFINE_STATIC_KEY_FALSE(kasan_flag_vmalloc);
> >  #endif
> >  EXPORT_SYMBOL_GPL(kasan_flag_vmalloc);
> >
> > +/* Whether to check write access only. */
>
> Nit: access => accesses

Thanks. I'll change it.

[...]

> For the KASAN parts:
>
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
>
> Thank you!

Thanks :D

--
Sincerely,
Yeoreum Yun

