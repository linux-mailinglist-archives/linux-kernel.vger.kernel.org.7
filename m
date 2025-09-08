Return-Path: <linux-kernel+bounces-805157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 201C5B484AA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4A3189FF95
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856462E370E;
	Mon,  8 Sep 2025 07:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="sQKyE/hx"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010010.outbound.protection.outlook.com [52.101.69.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9BC22333B;
	Mon,  8 Sep 2025 07:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757314908; cv=fail; b=lbUUL2oYXx5fqTFs7aEF8uwW9esnNScBqsUFtqlJSG6aE9aQcP4mDtynK5kYwjulmqyFogFID+7si8OAP0CC2piYEzi89dHRIfd9Lc1OxmJ2E9hFicmLx7i2051pJRCAkRm+izzPLdEi+RFnTrKwgLGR2HKlNFu1MPMePYxgv8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757314908; c=relaxed/simple;
	bh=2iBgwtDz5SwYD7SLiNtSsRW3Y9vHS8ESsxEgd8XZkUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s/Y5jWAu5bBC2FrPcwRKpzf3NjpAJ4ZdzNqZBdmgFIjAA4syiY1bkE9e1X5ZK5XNXW/TCtEQQQ5ePBrGp6v4ex8+GwIGfRYSmUSCvTMUes2nHe2JLfuIuXNtQWOPCGk9oBeghn13Xz60jCugp7EDFSpp7BNwq8AtmmK/WTvlxFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=sQKyE/hx; arc=fail smtp.client-ip=52.101.69.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrAbMiDE9FVPAyjFz+k2ewN1onCC+9/0Axgv6YZ/mjyWLzgo2hJGICsabPhd0t+5X9bVZ5c2DP2Ce1veG6FZeqSKHam70OcIgJ2p+0xQxQOAkTBbO02+Kehr/giIBV1Hzjv/lg0lJCUXXLAPoGR+9jb2yAjyMx/bPkFCfoayh8Hf72hgSDKxgmggoYIXQub+vxQjdnLMfYB1pkwZdKCSxP76Q5gssV3hrA6LCvcJt8BHHp2rVy93GxVMUDF2YLGfz8gYPlWIpdKaw78Gzwq7puUHttqRx7CUG1RUeyBX+skKDpsrANAhQ5wJpXiSEmtyaFHzqwPLrpIaiWJyfG1YqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euoiDbmgvc4wzTbyl3qGHz0Fd51MmyYA7gLVAAoSMWs=;
 b=WKfKmVcW9eulcUwf1y1DuOQgGdlHWjRdnUxFUz9A/agB0ICJbeMBgasfzdhYP8TuVZC1Ruk692qUKKpGxb33CukdmwKI21qUWym0x+psPg6ksac9MbZNHNk/NzPxGjII4pjSTSLIlSEwJj4Ke/lZWL6xFPyavWgGvrEho47UEjru5lXcxsMJuD5akbycOf8dpROa4Sy09zYoUulnue/xu+U45uZ9QlCn1p5KVUJQjQ8iyeP12busN17sMLKzJv6hBEErJslwKZQi6pK3qPk5GOkvAE/rEvXx88zv06n5kOvRDtpKTQny4JpCk41/Ens3eS6MO8xIrosqBqaZbp8PlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=google.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euoiDbmgvc4wzTbyl3qGHz0Fd51MmyYA7gLVAAoSMWs=;
 b=sQKyE/hx4N7x+nkYJTOwN4zkqXDEQAnSnOIaOjCbKitoT//UgFf91J1iiU4H8Qh70B+wMmsJr0oChRpldeA4wcr2N0e5nDvcWh1xhhxrRU7DrICyGkgoD/MjJ+1w60YERv6TmHdf3I2KxGe5Jbyk+RaQczVpu7m+BOEYUXlkMwrVtSd18+S2eETQjBeVENPf6Q1ymhVk2XTlJrvZwtO+lZ+apEl/N5pbBc9VFaPzYj2FbrNMlck6oVNDzYbeDU9SiLEjhCe4g3p3FD8Z7c1fdQIPsXEmfNSigT1dqGNgUV3tVmJI4FC9bXWW4pd1Wl9UFl/357F6xTxAj+4bd2u7Nw==
Received: from DB9PR05CA0007.eurprd05.prod.outlook.com (2603:10a6:10:1da::12)
 by PR3PR10MB3817.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:42::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 07:01:38 +0000
Received: from DB1PEPF00039231.eurprd03.prod.outlook.com
 (2603:10a6:10:1da:cafe::e4) by DB9PR05CA0007.outlook.office365.com
 (2603:10a6:10:1da::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.14 via Frontend Transport; Mon,
 8 Sep 2025 07:01:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 DB1PEPF00039231.mail.protection.outlook.com (10.167.8.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 07:01:38 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Sep
 2025 09:01:24 +0200
Received: from RNGMBX3002.de.bosch.com (10.124.11.207) by
 SI-EXCAS2001.de.bosch.com (10.139.217.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.58; Mon, 8 Sep 2025 09:01:24 +0200
Received: from [10.34.219.93] (10.34.219.93) by smtp.app.bosch.com
 (10.124.11.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Sep
 2025 09:01:23 +0200
Message-ID: <ee0e1fce-8b5d-4e3f-a261-b36a286525cf@de.bosch.com>
Date: Mon, 8 Sep 2025 09:01:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v11 0/7] rust: DebugFS Bindings
To: Matthew Maurer <mmaurer@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
	<gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Sami
 Tolvanen" <samitolvanen@google.com>, Timur Tabi <ttabi@nvidia.com>, "Benno
 Lossin" <lossin@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
Content-Language: en-GB
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00039231:EE_|PR3PR10MB3817:EE_
X-MS-Office365-Filtering-Correlation-Id: e6a85688-9592-420a-45b0-08ddeea58e74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkIvaE42RmpFT2tNRVRsSnhNUGt4TURZbk1BcU9pWUhDb1VwWXZNYm9nS2FX?=
 =?utf-8?B?elNrZkFZU3Qyb2dUakxBQUc0VTFiOTV1bkhPQU9OQStsNXQ4cG5yeE1ZOHdZ?=
 =?utf-8?B?b1BjM25SMGFIMXU3c0g4NDgxUmJSaUxRanRISnAxU240STVBMjRwcVptVlFZ?=
 =?utf-8?B?Z3FoN2RtMVF4SUkwOUNPM0xMQ3lkcXVTUHVlMC9RcENCK3paazMyWmZqZ2xP?=
 =?utf-8?B?VTZVelplVUtuNS9IbXF3cnNWR3NqQTJLdnB3OUlxY0RNb3VoN3lkUUNaSzI4?=
 =?utf-8?B?cUI2cGR3b0x1Y1I1ck5jQmR5aG1rd1VJQk85YXNYbEpJRmRLUUYwcndwRWho?=
 =?utf-8?B?eWNQYVZjY2xMZTNYVzdTV0hGRm5BTW9rV1lFdWR4SWxId2t0VXBQR2s3MExG?=
 =?utf-8?B?VCtuUi9qMGNjc0Q2eXo2dFEwdE9VNWdyYVhaWXROZ2cwd0NzSkUxUUM3N0hW?=
 =?utf-8?B?MTVBdVBEYWlwdlZTUkJNOXJsYTRNOVVQU01IWTgyL1I3UFpWa0NWb0x2akMy?=
 =?utf-8?B?MXNxUXlCUmJ1Vmpzano0VndoVU5OeUt4elNiK3lOdGk2Qk1JOFdSREVyUFFF?=
 =?utf-8?B?WjZ4aWRlRERUMHNTeFBOZm9IU0xSYm9rNDIvdFVQbWd1L3hFSFJMTi9yVG94?=
 =?utf-8?B?UnRscmY5VFQyYjBxRC9xa2lsYlg2V1l5QVFldjR5bVlpdytTSVRiR2F1WHI3?=
 =?utf-8?B?Y1lYZHdrN2d0ZUhBSUdXeGVHWTRpV2s4WjhiOCtlLzJpcHdHMWdZK09YN3Ay?=
 =?utf-8?B?c0FscjhieXZsQWIreGJYZW1DVGkzb0FHR0lVUG5la2s4dFYwSFBpcFVpTlR2?=
 =?utf-8?B?UVhXM2xpcU1nd1hIaTdLMHRkU2FvZzNzZlJLT3Azc0hjNmNuN2huajNZUkNO?=
 =?utf-8?B?OW9BUy9uWDFQUi80TkVIbG1KNVdFOU0xSTJSNXZ0MWZBK2grandhV3lVMDVT?=
 =?utf-8?B?TXJVTjhXV3pIWVgwb3ExT0NkU3RocWx1Z1dnSWJ1czcwc28vc3RqWWZqRE9a?=
 =?utf-8?B?bGNXWThqQnlSOEJTQ1FIandIZHhoME1ZUTBOaXdpSCtpbVAxSCt0dFM4aGJj?=
 =?utf-8?B?VmdIQkYzeWcxRE1Ka3hyTi9BM0lXb2J0UVVHdURNSU96NUFKZzFsQTJZNzJT?=
 =?utf-8?B?bXVwQjR5WmxUMDdjRHdsRlZvaTBjN2dja2Y2ODAyVEpvSnZ3MFRLNjQ3N2g3?=
 =?utf-8?B?Uk5SMzBHc2xPZWZHZzJacmFYSnY4NlNDTTdna2x4NzFkS1dmOExTR0IvaXVw?=
 =?utf-8?B?N1BRMmIyVTkyNUNpOEwvUU9MQnBEcFhneEoyanpyeFJDRDZ2NDI4NTdQd05T?=
 =?utf-8?B?RU1WTWxueTUyMW1XS1ArTGtUZGQzV2RhdS9FcHlLeC90U0VGeUZwRXF3OElI?=
 =?utf-8?B?RVIxazEwcVViNFpFbTJHOE1RYm1SSkthd0JUVm5QMzRpRXpKbTNHdWpnM2Rj?=
 =?utf-8?B?TXZpSGVvNlFhQ2t5RVI5SmJQRk96Z2hjRkg0QVc1OW5sMmJkUEtWVjJHeGl0?=
 =?utf-8?B?RG5sb282SXJaVHR1UENBd3lGN0N0ODZyZTNjWVN1STBmUzF2MnYybElZWkNv?=
 =?utf-8?B?Ly9UY2JQR3lXTG9FR01OZzE5R0J4RURQR21PZXBxeS90VkpyRjN2L3RrTDNy?=
 =?utf-8?B?ZVoxOTh6aDNLVVNGMExsV1pnc3pEL0gyMkRCYXhzeEQyTDBhNUh3NnQzVFhG?=
 =?utf-8?B?c3VPcVZUYTFuYURzQVZLb3pZc3FpWTVTelpCT21RY0hGTWxjSWx4T0dsNEc5?=
 =?utf-8?B?K3pqK0Y2NSsyK0VUZjZTRnFTbHpzbnpsRWQxaUVRc01TUnpiallNelRnNGZZ?=
 =?utf-8?B?VCtKbFp6K2Iwd0QwRUo5MWZmK2lHdXpIQUhWOTBsTCs1SFVTeGNuWmxLNWxC?=
 =?utf-8?B?dlpSMHJYRU44djd5ejdRRU5sNkRGeHg5aTNETEY0WXRnSm1RcnU1U21jeWVM?=
 =?utf-8?B?bXBXekM1alJtdnlhZlRFS00wYTNDaTVMODRia21FekxCbmlaT1VGRUZzQUNo?=
 =?utf-8?B?YWtqaklTcmM5bWllWnY1NVRnekpqSjZHbmxOdW5HTEN4ekVucFZBVVZjanc0?=
 =?utf-8?B?MzM1cDhBSlAvYkZseG9Qb0c0R3o1c0kyWmt4QT09?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(7053199007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 07:01:38.2474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a85688-9592-420a-45b0-08ddeea58e74
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039231.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3817

On 04/09/2025 23:13, Matthew Maurer wrote:
> This series provides safe DebugFS bindings for Rust, with sample
> modules using them.
> 
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
On ARM64 on top of v6.17-rc1 I switched from v10 used previously to this
v11 series to use read_only_file() to export some u64 proprietary values.

If you like feel free to add

Tested-by: Dirk Behme <dirk.behme@de.bosch.com>

Thanks!

Dirk

