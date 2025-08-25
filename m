Return-Path: <linux-kernel+bounces-784608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCD9B33E60
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5703AF8A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08342D739D;
	Mon, 25 Aug 2025 11:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="TufXjCpI"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012067.outbound.protection.outlook.com [52.101.66.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6528326B08F;
	Mon, 25 Aug 2025 11:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756122695; cv=fail; b=HgFmPhdguxzeYxgtmAH5YEjmDPYp8mwnDuQtLnIS6+e9PrHCfV28oa7TaGVNhPb0sp13fR+WsiloXy2L1BocyhC3qmZVrhFZm+7tJIWtNZS4xVhhWmV46C19fxrli605SEvJPLVlWqWCW9r5hlFIo7UdbjYYLT9rN/FME1eZays=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756122695; c=relaxed/simple;
	bh=ZjKnG9tDCzUURB93rifbJHeFvyg1ncmQMq2Ah+SD7XA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e/usIcnRQsdx3EsttK3NkikquuoBlmbYoUgDLtVI6wZnfg3w7TEM6QR7oPoAs61ESzefrdUPqbi1NjSvAyJp0jivQJYCsdAcZCnSDJyqXRQt0yFns7PMm3FncM/dFo1y6/20dUw9vdtnB1047sE/gVGadw+uEHEwxSaVRKw55XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=TufXjCpI; arc=fail smtp.client-ip=52.101.66.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7Swu7c+ryTUX2uaQjzXXG43uok+E/4F8Vv8Mrz+GTcWesq9oj5TJU1QzPbv9FolqMh8FBaoF8o1ihriItnLGNLrjRIqx6PPhoLWB0t0pkD9v9xvGWXJiI3NW9JRdn/8Rh4be2k20yMVKf5p/Zgn2RfO/oPlLFSzdmmIW92Om1rpyfZxtHAJUfSGWzgQTpXE1GuAkxG0XRd6je14orov8tU8Om5pjRuQeO34GZWcWOWG6thyIzwYiw5eQyzSaoLjtZfd058esseNNns9ytc1ooz9VM8bn2wk/6ZzkpzJlSKP+t3r+TLw9i/EApAJDeU63NObG519nnXJjM45soZZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQzllPSDO97LtV5sJLAenrEsFWuGV8j69ZOURVX3zOk=;
 b=AS8+dm7/usWFLitqLWVqntWpIYUIl0uo5xDXB+SDcNYSz6LkaVE8PIDg92BRLHIHaFMrRBTZfGCtOtwPKCqTX8fmZ1QXEzDQ2ZoGKi7ZblyC1xb9/tTJb7IhGmqmC5XoYkDbEnIqRrFYs3BRwbprB+nOyStACScEYRc2J0Zq69XX5WCybFaD5SmUmVcVvLPqx5X6FZe5Zlqh7iHS/KGnHCvbcfLuhu3mOKoZ6j+niQiwOG+x1sEhlvr6DFI1Z0i6SyCeoqKuiqPjyID5WLRnO/6YCCyI3eqLpb0PICR+WuJtIAR4fx0/+MwiH8304KShfrLBn86hN1eOGdMbZAxM0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=google.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQzllPSDO97LtV5sJLAenrEsFWuGV8j69ZOURVX3zOk=;
 b=TufXjCpI17qd9krBxgM9b5162jxAk/59L8N6ngVWfoBOD2hfTDpN5I5WvKhp6RvMmAPekHs++i1G90crT+boNcqxoQVxgGEWQUpiDKKs3stF+EDVdtpPc5dre3ShG8mj2/FdN2qDuRAf4Vf2wBoIjCetMfMXo+esf8DwJk5GL9ti8pkyymc6M6NhestTh36pB2M9pjo228Tr2SbVPVDI9TLmngJO+T6MhLOXSIIRWlY3ObFlvFT7+PYLKT5RmonSYcrH0ZfKack5QOqKOFQuwzg49MZKXOEJGYuXn5ZIa8UzeNri7At8zhCxWtIjLVi/Yk46dkGD3RIdWmvd2r0nRQ==
Received: from AS4P190CA0011.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5de::13)
 by VI0PR10MB8333.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:236::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 11:51:28 +0000
Received: from AM3PEPF0000A78E.eurprd04.prod.outlook.com
 (2603:10a6:20b:5de:cafe::58) by AS4P190CA0011.outlook.office365.com
 (2603:10a6:20b:5de::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Mon,
 25 Aug 2025 11:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 AM3PEPF0000A78E.mail.protection.outlook.com (10.167.16.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Mon, 25 Aug 2025 11:51:27 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Mon, 25 Aug
 2025 13:51:20 +0200
Received: from RNGMBX3002.de.bosch.com (10.124.11.207) by
 SI-EXCAS2001.de.bosch.com (10.139.217.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.58; Mon, 25 Aug 2025 13:51:20 +0200
Received: from [10.34.219.93] (10.34.219.93) by smtp.app.bosch.com
 (10.124.11.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 Aug
 2025 13:51:19 +0200
Message-ID: <8eaeeee7-005e-4639-9852-2304c8cbcc17@de.bosch.com>
Date: Mon, 25 Aug 2025 13:51:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/7] rust: DebugFS Bindings
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
References: <20250819-debugfs-rust-v10-0-86e20f3cf3bb@google.com>
Content-Language: en-GB
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20250819-debugfs-rust-v10-0-86e20f3cf3bb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A78E:EE_|VI0PR10MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f95d7e4-9813-4c0c-cee1-08dde3cdb9b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tjd0dDBrTHB5QWtpU2ZNY045azQ4d0NLZHNyZ2g2VWQxYWlCWm1sZ3U5MFhE?=
 =?utf-8?B?eE5wUFhJdEdSSWo4WGgwRWxmRW1qaHMxeDhKRVJSemFHOTNEa09ESWFNbzFy?=
 =?utf-8?B?bi9LN2dIMVI5R082U3FFV3JnckhHTWlCZnRpaHhjSDNrSkw2ZzZZUTVVMnJQ?=
 =?utf-8?B?YnFYTFl4blhpVmNQUzZaSUdQN3FKb1BtN29TcE9sbTdDUzBhWHU0NmNSWUdH?=
 =?utf-8?B?UWtvL2JsenoraHdhK2J0SUpTZ0hKUnMra3hvUzF4OXRUbjgxNmVWTzVrNVl4?=
 =?utf-8?B?SGcvUytneVJDWFJGZTR2S294cmQ0dXE0Q3FaNTNvWTRJaXgzaERSTHVETzlR?=
 =?utf-8?B?QkpkM2dMZkdaK0ljUzN6aWtYeEhVaEMyMm82MFFpSy9CdlJwdUd1SUZHV2N3?=
 =?utf-8?B?TGFmSGZPeGFqY0lUeWpIZ0dTQ05LRnVIL2RzbWlWLzVGbmxPTE44S1RrWXg3?=
 =?utf-8?B?SVAwUlhXYUszZml2NmhLS01xQmhpOG0vZ3FPeVFFQjFKa3NxQ2hCdEVRaHdJ?=
 =?utf-8?B?REJPNytNd3dhOUFzTDVkUGlsckdFWjdEdDkySE9UcmFSS2lMRCtZTlVBeUVV?=
 =?utf-8?B?OUpYbmUxM3NhdW9jUnJyOUNYUFBSc2JNS3hoL2NqTzVHQmdNQXQyczZENUpW?=
 =?utf-8?B?eTBuckZBR1RwMTJsb1NxMktlVENnZjZsNWRURlZKSmhEV1dUV0FFRUFBRVJh?=
 =?utf-8?B?Vll6Q0RyNkpidVBNaElxWEdwa2FUcm43K3c0NjJXTzJySGcvZk9UOERjNU1X?=
 =?utf-8?B?VU80ai9PZHRSaTU4VXpDb0Q5bVVBdGEwYUxZSlFvSFlnTGw0YkVRQ2pENmd6?=
 =?utf-8?B?aVI5S3E3TzF6QVFvblFzeENyb3E2U1BibGZWY1ptK2ZRZkxacVpKYUk4Sktm?=
 =?utf-8?B?Mk9QS3A4ZlJqb0U1T2dZNmNoZ0YvemhtVXpXUXhuUGVEMm9GOHM1RGk1aE4x?=
 =?utf-8?B?RW8wR3pPSFpsblpwUTVDV0JoSWM5dXh3dGtSMVV0R25kWnQ4cDdrV3doNkRD?=
 =?utf-8?B?UDNwMHFTVWEwOGp1eFpXQ204OGI4N1h1QlNWZ0loODM4NnY1Wjk2SHY1VXE5?=
 =?utf-8?B?dTZYWjgzSkcwMnRSQ2p5dzRRRVZWU2w5RmYrVTJ3MUZWUVpCUUg1Y0NkYi8y?=
 =?utf-8?B?bytGQUFWWXNRK2psc3V3Rm12algrWWxla0JZVnVRSi9CdnhnY0g4TDBNakZZ?=
 =?utf-8?B?WEtVaUZ0MUFIc05sNDZXc3k4UU5kck5oclB3OFFZcXdUMWJYcHhaeEkzMkd6?=
 =?utf-8?B?eUx5YUZNVDI4anhpZjFwZnQ4eThOWUJTMTQ1eHNTU2YyOG1hb3k2UC9wU2pS?=
 =?utf-8?B?cnNiQ0hvcGtQcERkR1ZRWVlhQzNYWGs0R0FOWG5JUFpsQWtEdzhpLy95M1da?=
 =?utf-8?B?REZFenBBK0JHSWtXSnF3bzBJTkJCOW9UV3ZmNTdSaXJKYWpZYndvSm1nbHhy?=
 =?utf-8?B?am83RWtjYmVoMEd4Skh4RkNlSjZLQ1g4UG5jWHd4ODJia1Y2OWt3UFR5dzEw?=
 =?utf-8?B?TTJ1d09qbGNsVzI5UktaQVNoVUZXRVA3YXB3ZTk3YkhOMks4TUw5SUc1Kzlk?=
 =?utf-8?B?bUsxTXVIUlNmNFhTbTYwemxMZXIwSDM5bnRwTWQxQmRrOFlGbGJkTU9nSmsy?=
 =?utf-8?B?ZWxPMWVRb1VveHhRbVB5TmkvK2V3Vk5GK2Rnd0lKTi9yTjRXdDlMVTI2eEIv?=
 =?utf-8?B?dEZsUkVXVGo4eTlhSnVlVWVSUTBpaElSa2JraWMyb1RWcFNEN2hBWlVuQzZV?=
 =?utf-8?B?YWNlcjdJYTgzTml6UEp3RlVyaVFtWk9YM0htZCtKbFlEcFJFZm00a0YwSXRr?=
 =?utf-8?B?d21QWlJvU0F5c1JyZ3NkNEZkK3l0RUNsNXMySjVxdVNWWUs1UmpkdUppbFc4?=
 =?utf-8?B?RVh0cXlVeTF0b1k0aDdLYnpDdkdQMWhmL1djWkJGV1dGN056UFh3WkZOU2t4?=
 =?utf-8?B?RVk3bWxUTFVXc0hPUVMvbjQ5M21jNHdYZE9WL3hSMGxRZm02TjZVOXEyQmNh?=
 =?utf-8?B?bzVEcFF2MlpNV25hM1JRRXdZWGFQVFpFUE9FUHhaMlFuQWh1dEYwYTc1bmly?=
 =?utf-8?B?YmhrOExBNWEwZ04vbWRBSDY0UWFMZGhyYzJodz09?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 11:51:27.9417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f95d7e4-9813-4c0c-cee1-08dde3cdb9b9
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A78E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8333

On 20/08/2025 00:53, Matthew Maurer wrote:
> This series provides safe DebugFS bindings for Rust, with sample
> modules using them.
> 
> Shortly after this is sent, you will see a real driver WIP using this
> implenting the qcom socinfo driver.
> 
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
On ARM64 on top of v6.17-rc1 I applied this series to use
read_only_file() to export some u64 proprietary values.

If you like feel free to add

Tested-by: Dirk Behme <dirk.behme@de.bosch.com>

Thanks!

Dirk

