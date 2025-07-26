Return-Path: <linux-kernel+bounces-746585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB627B12897
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 04:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8CF1CC1BA8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 02:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC151DE4E5;
	Sat, 26 Jul 2025 02:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QQrZjQSY"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780FC10A1F;
	Sat, 26 Jul 2025 02:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753498056; cv=fail; b=b6L3DPi+uelCnDOauw5VHiUZKpapg0Yi7PbZoERYakyXDGPm+5rQt5vmvvZkjNwDAcZAOEsJk9zdZ24Iocp+n03d4HKeKAjOWRx4k6Cutkeh0ASqDlbC6J967DkadOWrsa1cUp2dOfaJQrg87VJSh5euwPccMhqOeA1FJcUmT8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753498056; c=relaxed/simple;
	bh=YC6ct5WFyVJO4R05RIU5QY8Gte/GwNKMHfiF1HF1dls=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=Rz+9OrZrNzj79Z5Pxb09Xa2HtSYDZ0QrrMr7srPSalK/IslL+HCq5DJLicHzQin13uBfJjSCI/kdUXdiePzzAsC/40+LmJS4uEx2Qzp/W325K0ifXZoGUUDeA0NE4EHA4+Qm4Fv+8cTVmNXbbsyVU9g7a6u3/vRi+dAWU9qMY6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QQrZjQSY; arc=fail smtp.client-ip=40.107.102.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+5NiFRj94zxP9DvU8MdL5NuZXET4ymTeN5NQUrKglJQsFrxHKB2FWg3zJbayoAV1rw4vM6+rvp8cjLC/7LnIGaKNuBbIaFbAa2BCOwwNYk+tIrv7HEfyB6hruLIWaxqx02xgVQ50/d90B3sdzTVedEHVAQQmCX8REwl0lXSCvZ6fDlotWsMyu+6D0TZ7PWzJ3eupWkPdXjFNzVgQddmHmc4DwvpU/MFOm4D5lJK+9cWl2NsVpzt2hmAwogDYku7u0WpozPhQdugfrYRkv66Bg1bi/bl/bGDwx9eeAcV0e8DCAB8SUTWUvz2mUHe87R0md1I6jyqbaFAvob44He32w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwRveN0a+scjd4ch++Rnianv5Djc17OoDHFwpHuYxi0=;
 b=v2WTn8fcGfp8vQWZBE6qDuK7R69ki3YAWcCe4rALKwiYoc9objq83tlzvKbPNNOBYarcHDJ+omrTSodAR9OcdCS1BJxC07oGh7LI+E5ulu7Jyfv5Vo1N0Q1t6m7771r5GB6a+RCESBXkmMJANvVAoP2zeKEe4FusvD2fnrnOS4slO3iw4jWrQ1uNsv/j4eLKJRD9N3nXB2PrMHk0Xf1Nj/VmOfnJOxBp2iGW4TrSYaDb/115WDBLZ65588isI1Wdtao7+pSraygIkam1BkU7pU0Lu80e/tcPEpY6xGF8oflRSWk2aC+lFzYN8Cwpl8EWamqDBMx6GgT7M7VlQuNLrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwRveN0a+scjd4ch++Rnianv5Djc17OoDHFwpHuYxi0=;
 b=QQrZjQSY3iPD3SQmrBKRUUX2/OaZDw8LE1trSl09ZjGLB6+PeD56oYX/5uNQhb4ZbRsfgvBvoxmb29FIzxWYz6qSVWS/527Q1y01Vzum0m+iqtMLjEUc7uoeBx3nJZNpuHVQM31pgrMGySjgK0qc+J8yUk2YRkGlYUShLfKpObjwqE4ol4KeoNW0Zg2KhksHNnijzJROgZjMfYPIggCVIB+oF+UI6nKir5zuMUG48E4CAG7wC3rhj4Q+CgBel4l9iOgFxr4YFomUZqDLK/iK3gW85Gw8FPs8nOsH+B2qQYjOotA1IQNCeO6nvG6xlM05qhm3/hhhYO3afUzDb4P07w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW4PR12MB6852.namprd12.prod.outlook.com (2603:10b6:303:207::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Sat, 26 Jul
 2025 02:47:30 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8964.019; Sat, 26 Jul 2025
 02:47:29 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sat, 26 Jul 2025 11:47:25 +0900
Subject: [PATCH v3] rust: transmute: add `as_bytes` method for `AsBytes`
 trait
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250726-as_bytes-v3-1-eb7514faab28@nvidia.com>
X-B4-Tracking: v=1; b=H4sIALxBhGgC/3WMQQ6CMBBFr0JmbQ1ToKAr72GMKcNUZiGYljQSw
 t0t7Ex0+X7+ewsE9sIBztkCnqMEGYcExSED6u3wYCVdYtC5rvJaV8qGeztPHJShlhCd5oYKSPe
 XZyfvPXW9Je4lTKOf93LEbf0RiahQGZcbW9Rl6czpMkTpxB5pfMJWifqfqZNJpmpK0ojW0Je5r
 usHjLOOr9sAAAA=
X-Change-ID: 20250725-as_bytes-6cbc11f2e8c3
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: "Christian S. Lima" <christiansantoslima21@gmail.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: TYCP301CA0029.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW4PR12MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ef827ab-9e69-4ba6-ab49-08ddcbeec2e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0NYdXlvdnRqUUFRRjV5cGVsODM5cGRWY1RkWTdXSGFEcWc2K3pJNG13SHUy?=
 =?utf-8?B?TlRIWm5DbTl5cjgwOXJIUzdSUEFKMnNVZDZoSlhEZUJ3ZEwzWEg0cFlJdTlM?=
 =?utf-8?B?TzVUM09OYTNoQjNsYWI1NDdRR3hybUxVUkkzdHIyY1lLT2FkSGtEejh0ZlBW?=
 =?utf-8?B?bkhKcVRmOSt0dkRhQ1RDZ1h1OTNxWWZOWWwyVHNObE01bUJNTWw1UnVRYkdG?=
 =?utf-8?B?ZTNZbXpWQ2J2T2I3RjhoeERjZkZWUnBUeHR6MnNMOVpHQ1M0blZRWUFvMG9S?=
 =?utf-8?B?S2h6ZHY5Y3lyWm4yNkpCTEd5NFdwY014NmMzbCtjUWV1akx2YjA4bDV6NGZY?=
 =?utf-8?B?TVhKYTRNU2EvN2R4ZzFyZCt1NnY2d3lOWXg4Q1QzSnRKelNjWVRvVXg1U3dO?=
 =?utf-8?B?UThTL0Zuem5zSnRsM3VmNllSL2F2by9QajRLYXlUV0dZT3dyakEzMm4wL3Ri?=
 =?utf-8?B?eUJYdHJUcmpsbCs0Y05NWjR5MDFaTStBT25TclNJcXFkUnRsZDhVTHRsbEs2?=
 =?utf-8?B?WmRxVmdFcEN0Nm1ZeElHQXVtMnpwQzdOQnZ2eEdWc1RTMFN6azFnK1hBMU5E?=
 =?utf-8?B?bUhUVUMvWm5BUGt2YVNGRm00MnRLZGlWMDFWd0NjYzdXNHBqWjRBZW4vSXdS?=
 =?utf-8?B?dVNYSjJtZnY2R0g4L1RrNHp5M1pwakZLYjFBeUdyQmp4UGFYd1hwNE5xWkJV?=
 =?utf-8?B?clFxdjJLZGlySDJaMFdpR01hYnQ5aitNemFTNVFORmNkWkdjd1B5NER6dzBS?=
 =?utf-8?B?ajEveEFSL1Mrb0hJUkJvcUoxQ3BuQlVwRDlJanZQMzVHYXBMS0d6OFluOElE?=
 =?utf-8?B?ZWR0NFQ4OHc4SEFvS0xLc0gzbXRhYWNOT2JVOVc5TWo4SVM0cDNCcCtlSHJK?=
 =?utf-8?B?UmU1WEZHT0JxS0lodkhXS252TmRIM3Rpcnh3U3diYXZxeWVzZVNCZlVlcFZn?=
 =?utf-8?B?Um56c3p2cXFPQXB4eWpHZE1HUTdlT1pUYVNQM3JzRzFsYzhPcjZPRkV1amJi?=
 =?utf-8?B?UnRwTFFTbTRDQlA1M2Z6ZmJrNHhIZGxKQ2psSTAwajN1OFdFL051ckRxUjYw?=
 =?utf-8?B?OGg3NjJoWFozbDRzUTh5S2VtT2Z1cDBaYWVPdlp0UHNpUkcyMGNDaDFvZlM4?=
 =?utf-8?B?UTRQRE5aT3QrMzlEeTU4MTJZbklUQU1RVS9wQUJLZG1RNTFFNzZhdjNvMDgw?=
 =?utf-8?B?Ri8yUDY1czROUmxibDFoSXVsTXNJNGNmajBLVXA4d2xRZFZrQjh3WEdEYlhZ?=
 =?utf-8?B?YUM3d0xKOGMxOERrOFVRZVFSWUhORmxhdVRMMjFRRlMwT2ZJU1U3NXVmZUdF?=
 =?utf-8?B?bVJoRjZpdkdPbis4RVl0Q2FRSjFKc1Y3U3IzZEt3bXZrczZTTXppdmM5L3lE?=
 =?utf-8?B?Y3QxSWFVNkxrOXJGMUVodGFsTEdOYUlsM3NyTi92R1dFZDFZdUhpMld0djBH?=
 =?utf-8?B?b0Y0SFZqQlRWSHdDNSt4WjFxNUhFd0VxRjkzUGlFNlJET0xZdnhLclcrV0F5?=
 =?utf-8?B?QnVlUkhwUXFxQ0FseHJqbmpBYjRZNUlNN0NHZ0wxOEFQMVpTbjQvcDJjbXZm?=
 =?utf-8?B?ZFRxZ0dURVkrbVJHcUFFWm1PYjFodXZFSWZ1ZVRpdlN4Tjg0SVlEd09yaFVt?=
 =?utf-8?B?OFV4OEQxYUk5ZzBySGJlUzg5bGs5MTJhZmwrS3IwYmdtc0ZUN3N5Y1kyRVVE?=
 =?utf-8?B?QlczRGRiMXU0M2ttSEJ1bFpSMFg5cG5Bd01TamdVZlJFOUgxUG4zOEF2S2oy?=
 =?utf-8?B?YnNoWjFPOE5zdjRwWDhSVklxM1oyU1dWQ3lEdjJXdTF5V0N5N2VMVjhkaFFS?=
 =?utf-8?B?czE1QjN2V1lTMk5MdWlVc2JoVElpNWNxNGdPZEpxV1hFK0pEbkFRRkFBRzRG?=
 =?utf-8?B?OG5IWS9jN3h6SGhMRkhnWnZlamo0RzZJdFFxZ2haSzRObXIyd21Xck9HdXB0?=
 =?utf-8?B?ay9hdXZUaFNXaGNXT1IzcHF0aVFPbDlWOTZVZFpaRS9yMnBISzBwVGNBR1Vh?=
 =?utf-8?Q?xRC7Y4BRUiP4+i5jriXQyY7PCEnAp8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTNyYjF3TWpIRnVLbkNLSXVMT3F3T3FTVFY2UVVSZFlVR1ArTDh0Nm9MSmQy?=
 =?utf-8?B?QU1TcXhUbG5PYWpsQ3YrSVhtYkppMlNYV3ozQ1hsaDNYa3F1bVovTm5kOUxB?=
 =?utf-8?B?aldsc3BrR1c1Wjk0M1ROY2M3RG1xYUk0bXFDTEcxTWVKZGRSNFBraTdrR1NC?=
 =?utf-8?B?MFpNUG9VYmpCazFrWmxVYXJjcnVWckZ0blc4M0M1aUhGOEdjTjA1ZjFjOGVG?=
 =?utf-8?B?bkhIZUNuNlhwZjEvcjZKdVJEanNIOExvVnpkc3hUWjFFRXZIaG5lSmNuL2Y5?=
 =?utf-8?B?OFE3Rmk5ZGVpaThZTWZGcGpOd0F4S05xcTloUFZDKzFkZVBRU0l1elladmhE?=
 =?utf-8?B?OStJT0lBMjBBTGw3MENZWVRTb3BYbXRYcmlKK21zRVZwWDVGVEFPdlBkM0pm?=
 =?utf-8?B?MkRJYTM3TDIxVTFQRmY1UFFXV09iQWRYZWlBNThCZzFwR0NxTDVjRVZWQ1FD?=
 =?utf-8?B?RFgrZ1Fsa2xHN3pXS0tWSWVYNWlTdjV5eTNDVGNQK3FrdkJhOW1QamZ4MXJV?=
 =?utf-8?B?amZyaEF4ZjdTYXUxTWR3ejNDKzh0STBpZzdVdVNUdTlGNnNPWE9pSk9hQ0Zl?=
 =?utf-8?B?VzFER3daallGaUEvbFVHd2U3LytnOXE0R1BZT2F1THRSVG5VbWxoM09rdklO?=
 =?utf-8?B?M1VCRmpzTElhUHVxUEJlQzJBRjd2S1UwcnZ2eDJmN0J5TVlyUng2UFJKKzQ1?=
 =?utf-8?B?K2svQlZYb3l6a1Arb0oycHlrQkJlbWh1Z2RJZWxVZXJyVmNXSngzT01zVnRQ?=
 =?utf-8?B?WDFkZVErQkNJVXF6eG16TGpQQm9DdWQ1T2lTV2REeGpRME9tYW51aGs0TGJS?=
 =?utf-8?B?TkFtdzRZeWtzM2JOTm1nb243RUFPWXRCM0tGRCtBb2RsQnRHVFVBQlY0NXdL?=
 =?utf-8?B?Wm1rbVZ4RUV2OHYxcWtYMksva1NOemFGM0J0YXlUUDVnbk9BbzFnZjNJbW5V?=
 =?utf-8?B?SCtzWi9TNndjRGlJTjhVd05SWkVDWkVDalNhWGNpZmVUMDRBWGw3S3h2VVB3?=
 =?utf-8?B?MzFyeTRTYVZuYnBLdXVXN1V3VjhFQTBsaFVUUUd0QXNZak43aDcwd2NNZm9K?=
 =?utf-8?B?MExrZUtCY3B1dDRtQVlROEhXS0FSL2lsVW5RejZlM1d6cFBGTjJEZWgyd3cz?=
 =?utf-8?B?V0djbCt5Um5naHdlSkVQbmdSbGlRNjFaeXRlYTNSc0pwcEE3a0J0ckZQK1g5?=
 =?utf-8?B?SXR3Mjh3Y3NOdEwvRjZVdW83bm9oVk8wdTZpVzY3ZjMvN3p5cHBoZkwrM0Zz?=
 =?utf-8?B?Zk0yWXpDS0k4VHo3ZCtHRGRrS2VOQ2NzYlE1bnIxMmVFaStub1lOSTk2QUNF?=
 =?utf-8?B?MDdlSm5VczJYcTlXSlpwNHV4VGRSenBscko3b2VEbmZidWtrQ3RXRDQyVG5V?=
 =?utf-8?B?d3RhMjlKcTBNSVlBY2NMQXhNVndjbmMrMTJ2dGlGUWFIbTNaNnZuSERSamhh?=
 =?utf-8?B?eXN6Y2dhc0JhS2FvZk9rQU11STlpMldBT0ZFYmZQeEptN3NpWENPR09jYWND?=
 =?utf-8?B?ZnMzNjZyazNFUVJXeHVXRnJ1TWhZWmoySVVvbU9RK3VRUENmNUQ5a2lCaEVM?=
 =?utf-8?B?T3ZmVlViYmg5VU9Zeno5VHhseHpVd3NBK0V1WE9iWVFQQXE5Vjc0c0d5Q3Qy?=
 =?utf-8?B?VTNqOUFjMStlYnp1WkJRcHQvd3VMeEZlRGZha1NtUkRBaXEzTW5BQ3lndjhm?=
 =?utf-8?B?STdPUXU1cDluVGlDVlJPYVN6cGY0dUJodHFFcEFCR3cyZHpFN1NMNCs1TUJr?=
 =?utf-8?B?bXR2UzgybW8rMWx3bkdHNHFMdzF0ekVtNlFidjBaMDhXbDUvL1RNQUlmVEJL?=
 =?utf-8?B?UGFLYnRvQXAxbjBERzVyNFJXUnAxRkxFWmdjd2xnbHN5d0tULzk0U0prK3Zw?=
 =?utf-8?B?NHI1Q2FTYXZUQTBlQXl0bldvNi9VSFBIZHZZVFE2TGlFNWgyOTVoNDJvMTRk?=
 =?utf-8?B?ZDNORzVOaXI0Z2NkajQzOWtqL2Ntd2Z0UUZjcU5mT2VESmZDSW8wcXpjVUpR?=
 =?utf-8?B?YWxtRWJFWnFHRkh0djg2ekRUSUNjb1pDMjQ0RC8rTTFKSFQ1a2RIbzZGZXBy?=
 =?utf-8?B?QTlGdU5FNkdRRXI5MjZQcXBPU21UcEwzSXoxYUdjVWNHMzlLR1ZvM0R3ZThE?=
 =?utf-8?B?dHNhRTdRQ0VQTkVSYTkrb3EvaFhoZjVDUXhadmRrRWFMQ2NZMHQzVmk4MDNr?=
 =?utf-8?Q?G1XMqWRMRPrMneknQ7xZeeUrnyuIlCiYgDl8mRse/RwV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef827ab-9e69-4ba6-ab49-08ddcbeec2e9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2025 02:47:29.8939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ldtPqtjCTMFNh1iiZ+bD7wCPOCX6CSMH5hm+LJgq/jvduQxNcSNuoE65Aja2MGS1sCuJL64KDezXoX+/QQ08w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6852

Every type that implements `AsBytes` should be able to provide its byte
representation. Introduce the `as_bytes` method that returns the
implementer as a stream of bytes, and provide a default implementation
that should be suitable for any type that satisfies `AsBytes`'s safety
requirements.

Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
This is the sister patch of [1], providing an `as_bytes` method for
`AsBytes`.

It is going to be used in Nova, but should also be universally useful -
if anything, it felt a bit strange that `AsBytes` did not provide this
method so far.

[1] https://lore.kernel.org/rust-for-linux/20250624042802.105623-1-christiansantoslima21@gmail.com/
---
Changes in v3:
- Use `ptr::from_ref` instead of `as *const T`.
- Link to v2: https://lore.kernel.org/r/20250725-as_bytes-v2-1-c6584c211a6c@nvidia.com

Changes in v2:
- Use `size_of_val` to provide a default implementation for both `Sized`
  and non-`Sized` types, and remove `AsBytesSized`. (thanks Alice!)
- Link to v1: https://lore.kernel.org/r/20250725-as_bytes-v1-1-6f06a3744f69@nvidia.com
---
 rust/kernel/transmute.rs | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
index 1c7d43771a37b90150de86699f114a2ffb84db91..69c46c19a89191d8a2abc5801564cacda232218c 100644
--- a/rust/kernel/transmute.rs
+++ b/rust/kernel/transmute.rs
@@ -47,7 +47,16 @@ macro_rules! impl_frombytes {
 ///
 /// Values of this type may not contain any uninitialized bytes. This type must not have interior
 /// mutability.
-pub unsafe trait AsBytes {}
+pub unsafe trait AsBytes {
+    /// Returns `self` as a slice of bytes.
+    fn as_bytes(&self) -> &[u8] {
+        let data = core::ptr::from_ref(self).cast::<u8>();
+        let len = size_of_val(self);
+
+        // SAFETY: `data` is non-null and valid for `len * sizeof::<u8>()` bytes.
+        unsafe { core::slice::from_raw_parts(data, len) }
+    }
+}
 
 macro_rules! impl_asbytes {
     ($($({$($generics:tt)*})? $t:ty, )*) => {

---
base-commit: 14ae91a81ec8fa0bc23170d4aa16dd2a20d54105
change-id: 20250725-as_bytes-6cbc11f2e8c3

Best regards,
-- 
Alexandre Courbot <acourbot@nvidia.com>


