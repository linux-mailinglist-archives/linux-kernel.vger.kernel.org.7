Return-Path: <linux-kernel+bounces-745182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34343B1163A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 04:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0BF53B950F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 02:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AF92063F0;
	Fri, 25 Jul 2025 02:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OTUiQn3d"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23BD1373;
	Fri, 25 Jul 2025 02:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753409517; cv=fail; b=MszHEapvYXEMSWhXh1OQKw0T8wMmdRpbrmYRMkarW2/5lriwMYmG6G4du1/JOw1TpmCk8fgm6CDfGlsxOMSnve8k9RH7ljFIR7DVoBOcX9Co2BqcqaLV9aOd0tPNCvrC0k2p1THRXfz0Trwh1FohW6vwDtZbERCR+YOIqG7MmhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753409517; c=relaxed/simple;
	bh=tsakTkVoz2OvXOGrRxuw2NYImMIf8vQHNY8CEWM6UiU=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=Dr+rk0Rk42ChV/WLMCGESu+tmJFeBxVXabzRw0ApJpxPftaw26FSmQeRsqxXCWIw6ByTlmYNA3IXZsV77CUl883r6eN/Al2FjYn/+5eHnSyAvJglEWvo5A82EI0gYkwPLxTq9TC42goFiLCjeRM+2KJBR5/90cHJ6vdTKR7DKkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OTUiQn3d; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuNZ2fLl5ge1xLxhqXcK2KKL+BRbG8HCv988/pLnWWHKy4ma+bYkLa7bDrWVPu/+NQwg3dhOfzUExRJZJAiZB+rSaMLC7ofJUPVLe4z7u8ylOc+SxfkKaz1zvcKJDMHh6jeIDa2KvZAZKyTGAb7lZ4jCQtrLZaokUUK1GxH7SwqVLDuvwgimoJlbysW852fMqiPDHRLMupvvs3UDJhPXbSorkKcgXmqpkjCGvkrfNTSrWolpysKBNPnWmVElHsTOT8ZKTRUN49/k1/uskNS7+1ZAN9QEC34Y2MGIF19rhe4xy1B82PlJtCmJPjgapTqf6EvIkneJ/DuoRxTfRUhrIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Log5RJq09t7V/xOstjVeH6DzCRRcq9DJO7hd5Gusle0=;
 b=QLO7Mnk6uBJ8GwDefYhepf4ooZyZkD1ypvGd3pDXsCIDUJ4AFA6+cedHIcgcQ5wX2IR/hGHaEL065AjGjFvXPQpQQpjR+JvGNFn/8yd0ROgbo58KYarGKYd8GeXmhgD1ddpIIdQjtwCG8qWgjF4HOTJbPiVt9E9+sp1REqSigU8O9/WkehrJmMxcuGMrIlaSYyl2LgVBxdjNE5q+8VraaECnTAlcxNXr0lVXUwUMlOCvmHsXwZYjc70RdsVvBpWkMiHgBfhuIh6kkTUs2CHIz9PnY+ZVEFHezhQPwnRWza+nhF9rKWhpBXa3iTclZ+NW6kmeJB9Wpc18/V+Jp+hoPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Log5RJq09t7V/xOstjVeH6DzCRRcq9DJO7hd5Gusle0=;
 b=OTUiQn3d9G+yHJbQJdWIZA41iIjNlL0qSzURddTIIM8L/yx40RNZgqF40SB0pGiKa82HYveRlTMT1vfNGPBkHMR+eDN5Y6VvLuCBFkDEc8J7LK9i0jiv9i9JR9Xx2F4ujTeBfvOuEFc4Iu+UfwOWT1F+x0aybHW2UT1YgBmPU2fCn/3y3lMnLRZuJKTbbGekjNbNqgfNYHyLO27J5PfYiF8lpCe48s5/y87Tdp4x/JdcvrKEMW3VyMVaEcg25JkabMTqABgnpSnKDRwdTJg1YNMf0/iScrxszZVrVMq+QNLrMWkdozqFPIS250+cNtZuwH2Be0apczgX5pWs0Dj30g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB6391.namprd12.prod.outlook.com (2603:10b6:8:cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 02:11:52 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 02:11:52 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 25 Jul 2025 11:11:18 +0900
Subject: [PATCH] rust: transmute: add `as_bytes` method for `AsBytes` trait
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-as_bytes-v1-1-6f06a3744f69@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAMXngmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcyNT3cTi+KTKktRiXbPkpGRDwzSjVItkYyWg8oKi1LTMCrBR0bG1tQD
 I509AWgAAAA==
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
X-ClientProxiedBy: TYWPR01CA0028.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 037fcdde-14fe-47d3-09d4-08ddcb209eae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHN0SzViSis2dysrNWJYbkN1SHh3dlh2NWpDelJMTFo3ZVVDOGJLbi91ZFBI?=
 =?utf-8?B?cjBpNzlQbnFBQTJYYlhIMTk5YlVtcjFaK2VhMlNlb0hlNmk1Y3BydkVkZnJs?=
 =?utf-8?B?UUFrWVhLWlFYTGI2SzRWcDFERUZqYlZhUjd4VHhtc21WOTg0YU5kMWR1My9L?=
 =?utf-8?B?bExBZTVmdWM3U0NVUWh6SVN0dkQzcTRwSU43RGtSQUNmc0FrYlBEU0p5RFdU?=
 =?utf-8?B?QjF3ZTUxZWhsdDBRMWRTZ1BwM0hwRnFUNVNlaTRmdWlJOUZOUEVoRjEwN2ti?=
 =?utf-8?B?bXErRlpoYnJtN0ZxWkVkckhXRGV5d3FQTE5WRkUyWWhzWlpwdmJaeXBIR0tG?=
 =?utf-8?B?WjRacE0yRTZoWUxEOGM0amsvUXpud2svZG1mQUJhQmZHK0RXcHBLQVVtQ3Fw?=
 =?utf-8?B?V2VUcXY4ZXpYT201NTU2YVlqMmpvUExXckl6dVFxTHdrZ2pRUUIrYVgrK1Rt?=
 =?utf-8?B?bkNaaTZ0c2JpalJYMk51ajBMZE93Qzl6WmNpMi9mQ2pTbWNMcnBmeXNWbTY4?=
 =?utf-8?B?S2NWV0daVnNyc09iWDBQUVliaVlkV1dMdFh0SHNiS1lDOVJSZHBta3BqcERQ?=
 =?utf-8?B?cDZ0OXlNRG9QSmV4OU9WeVBaM3pQT2dQTWtnM3FDVDVMQ1N1OFc5MFFEWCtx?=
 =?utf-8?B?dUhTbUJSdVJmNTdqTloxcWw4cGQ1TTJjdGZnMmEvTkMyMm5RVnZuL1JaMmFa?=
 =?utf-8?B?MXpoWjNtSE9wcENCdStyajlFTzVER3AwYTNXTWtxVUtxNlYyeFZOcFN0ZWZr?=
 =?utf-8?B?U3J4VFRFV2tjQUxjQXRxc2UvVGVhTUtQMGhZWjRYa0pMMWlxWTUwRCtIM3B0?=
 =?utf-8?B?azVZbnV3NHE1d0Z3azcwZXcvWnBCN2h0MFMzdng3dXFSZFROQW1GY1I2bnAy?=
 =?utf-8?B?cFo5N3dReTVOTnVDY2tsZlVXK0MxQ0ZaSEJkVFdmeko3OTRyMFd4R0ZoaXR3?=
 =?utf-8?B?WlVJMzBWL0swU2hma0lNdVBtaVZYWW9pYkZGcUNaZmhadENBMlFKcUhiZUQ4?=
 =?utf-8?B?cHhpbzVsM1NJS29MVHNuaGxJVFZ5MUZERDRObWUrekE5czJKdmZ1M2hHUS9O?=
 =?utf-8?B?VUtLaDN0UVQ3YjFqekh4TW9tb1BrRytiU0I5WnNLaU82L2ltL2s4YjNWSDY1?=
 =?utf-8?B?NmxiZUErRGdFd3Q3MHk4MkhSYnU0YkFFMkMrWWdSaFQ1SDdBZW5SRmpSWTdF?=
 =?utf-8?B?TTBTUVl5QnJ1Q0lkQmJ5T2tsV1RXM2ExdlYrUTVRUEdEcWpvL2I3NlZWMHdJ?=
 =?utf-8?B?RzJnR2VSc05GSEZKcnBOREZ6RDlWcXFHRWEwaXY4cGF4NDc5N0tZN004YW9x?=
 =?utf-8?B?a09lbVVXeStsdUd6NngzcEgrRDJESEgweUptQXNzNGJlS0V5QVQxaFUvcGVw?=
 =?utf-8?B?OUYybGJaR1E0dDFsVXBhZnhUdE5PUFY1QndhQTdhU29RUGNIV1NLT3o3S0hF?=
 =?utf-8?B?MGJSU3lnTklDRTlic0ZFY0VBQ1NzWXBBQzl4RllBWko3WTlxR0wwSDAxbFNv?=
 =?utf-8?B?WHRIS0Q3MGpQS0hCWmpib2FJVmdQUHNnWTRFZlAvdFZYVHVRcnM4ZElGT0d4?=
 =?utf-8?B?YlNVWDAzQUxuS2VLU1dSYktVUVc3ZlJ3bngwdmc3RmF3cFVCZ2ZYM0k4bDE1?=
 =?utf-8?B?S2oxYk5sZTdLQU4zQSt6NzdIN1JVL2FwcmcyS3ozV2UrU0tFWDZ5TEc0RnNW?=
 =?utf-8?B?UmFMRmwzK1JUazhMV2k0M2N1YlFHSUNxcy8zdHVBS2p6aWJhYThxeElxZHdJ?=
 =?utf-8?B?YlA3QXdXWUYyVGZCM1dvbzFlZTFmdEF1Qm1qV2FSZ0V5UWtYR21FQS81WG03?=
 =?utf-8?B?YVBndk9WUVJGSlpsS05IQkU0MncvT3I1RS95TUVydFl0djdaN1BHcDQycG8y?=
 =?utf-8?B?dlhWQ2NvMEhHOWdxZHk3SnNvVFdtaElVVXNRemhPTUFBSDBLb1hZaGRHN3lo?=
 =?utf-8?B?M09DbmpTOW9zN0Zvb3RoVHZqVTM0ZlJSTTZEQTBQZ3dJUU1KTUw0eSsxcUdD?=
 =?utf-8?B?bjU4WEcrM1ZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1orWFlJWWNhNlFKQ1I1ZWh4QmlBbXRwWVRQSU9ORXlmdlhmT0JYTDhqNUpt?=
 =?utf-8?B?Q1d3OW5NVHRXZVQzMWM2SkNxT0tQdWFQU25LcnJwRVBjU3M3ZWVMMytkMWN0?=
 =?utf-8?B?WGgxdDliUzBqbjd4Z2VnK3NMN1czbVpFYUtxMmp4NC9URTlTalE2Y1lzamhJ?=
 =?utf-8?B?alJDYXdIRFE4RlgxdWJQcGU2a2VxTTNNTDZpU0hJVE5ta3poRzE0R0pPYTRq?=
 =?utf-8?B?S2pGdmNMZDc3ei9sTUdMNGp1UlFSdlJ5a25ES3F5UXo1OHFBRmZqQmtkbVZx?=
 =?utf-8?B?QWxsUm9CREtjTjltdVZxSTkvelZaYWVmcWx1TnQzbldkSEpKMmJQWkFMQUFU?=
 =?utf-8?B?SXd0dkRZUC9LT3M5M2lKbXJpUTBCMDl6YTZFQ2tFaGxmQjRmR0tzSkpFalpQ?=
 =?utf-8?B?azhyMDlIL3BFd1NVYUtRWWZMZldhWWR2MmIzT2t3WlhkNzNvRDhoYk81d0xi?=
 =?utf-8?B?NnNOSyt0R3dIOHhSNWMyWjZTNkczOThOaS9pQzE1OUJCelQvNmJhUERhMXov?=
 =?utf-8?B?Zy9jNWxIU2V2bTd6dzBhbENOMU9sTXZoN1U5alVwSVc1Snh5MGdlektpR2Z3?=
 =?utf-8?B?bXBFcytwTmJRRkRXNGVWQVlndzNBRVZWaUdIUDhSbkRGTytkYTd2b2pqcmF5?=
 =?utf-8?B?c2lJNXdsZzFJRXRZNVBVbG5iQXpaVVZGZ01qT3NoT0JaQ3d3Yi92VWJFUk1Z?=
 =?utf-8?B?UTNvMTFaVGJ0cGF4Ky80WVQ3bnMvOFExVVAwQ1hzaitEUzZZQWp1NisvQ2ZP?=
 =?utf-8?B?RVl3L1gvUnBrYW5OWnJhNW9LR2NHSVAwRXVKUHpYUlBuRFhPb3lPMjRWU2VO?=
 =?utf-8?B?VGRhYWR5SmZuejRDenBxOGdHM3B0RTVCWUxzWkhWMVQwUnJNSWhNTHluSnBq?=
 =?utf-8?B?L2JIbFZrMVI2azc1YUpMUDRnY05uUkcxTVJ5VVRKaUdUK2pabldIQlF4cEZ0?=
 =?utf-8?B?Uk83WUkyUDgxdnpJVU5Db1lKWE1yZ1IreWhYRlVnODJvMGxMRzRhQk9qaEZ6?=
 =?utf-8?B?SkUrbC9EWUIrd2NGNkVvWldMT0JSSGNtWVA5MXJRRnhMZFlRNVVsckFDam05?=
 =?utf-8?B?aDlqdGZ1QVpVMXhOSnJmeStzc3lSeC9XZExMTDliL1E3QnUxekRhT2JNYzVG?=
 =?utf-8?B?bDl6bjhUM2NxSlh2VENaaXZlNWxSVGovT0F6eThsYXJDSlVmVWJJNWV1MlVY?=
 =?utf-8?B?eWR2clh3M3NiQlRyc2ZIVFlUTDdndUhJOEN2SERYZGxDbFBvMkhvVW16QmNE?=
 =?utf-8?B?cVJ1UlYyN21WdUNQZXBwRWlDbVhybTMvVlRTT2pVcll3Qk9NaEU4OVZnY0x6?=
 =?utf-8?B?MFZvNU1SeHBtak8xWUgvYkxscFgxeVlBQll3aXhpMi8rMGJNSlNJV1dESmg2?=
 =?utf-8?B?dGYrSXYyYVhUUHZZOU94V2ZxQUxnZXMwQkNCWkZKam5yak5Na2I3ci9RWlky?=
 =?utf-8?B?Q05DK3g2cHQ4djZueTR4a0RjT1BRQW1OMjRKb1JGYk9OYnZZYWJXemRJS2Js?=
 =?utf-8?B?ZUZLNnIxTEJHRXdoWk4zMXV1NitReEtpUDVvYTI5MDM5M3ErT3JIdVpuU0Rt?=
 =?utf-8?B?RFhvV1lGTmpxOVZkazlHVnZBMUIxanliU0VFZHVsVzNHcmlvMEdpeGQ3UU9h?=
 =?utf-8?B?WDhpY3VnODUzcHdCNk56UWZvTkQ2RllyeDhnS3VFdHRxWnVXQytzSGRJZ1g0?=
 =?utf-8?B?TTZ3OWpPdEFaZzRxNmNRenVYQ01zZkNzbmlzL0NmZ05tLzJzaXBWdkd4eXcz?=
 =?utf-8?B?WnlpbFpZRUl5OGI5ZGRwZ3YrV0ZlMUZSUjN2dEE1U1hDTms5VXRYL3owU1lZ?=
 =?utf-8?B?SGNlL01Nci9DblpVbSsrSjRzMUpqLzZaQWsySmtnaUtJT29vTjBYWFhuQ1dW?=
 =?utf-8?B?TnFxVDlNNEdsU1duZ1dMQW9lZ0ZaaVIzbHh4WjlWZUY4aGZ3MWJiVlFsYjZE?=
 =?utf-8?B?REVZY2JJdFZ1anNsQUlDaGE2ZmtaMElUZ1ZyL2JqalVud0tVaDJiTko0S1VG?=
 =?utf-8?B?MjFnQWw1eERNMXBQK09CSWxjZW5vY01ISkJuNkw5TnQ5Yk5vdVE0WnYyNXBY?=
 =?utf-8?B?aE5IMEVQdlJvNnhMYlFJamhOMXZnWjVYR1hLZFEwYXZTUW9JbE5mSUVuTGYv?=
 =?utf-8?B?N1poc1l3NWhpeklRaGhUK0tOOVlWNXc2VDN1bm1SRGt3cmIwVUZQejVNUVJq?=
 =?utf-8?Q?eDAdaxH0NsilnTakoMc3pHtjbjUxFhAvFMDMYaSRUm0e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 037fcdde-14fe-47d3-09d4-08ddcb209eae
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 02:11:51.9940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8pliC9HcEM4ho+9c/Zv6euu1aABg31ZlEqX7lNSOu18aih+Uje36cXc2/pY+SlRzxSJoNHRpJqLEdj8D13uMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6391

Every time that implements `AsBytes` should be able to provide its byte
representation. Introduce the `as_bytes` method that returns the
implementer as a stream of bytes.

Since types implementing `Sized` can trivially be represented as a
stream of bytes, introduce the `AsBytesSized` proxy trait that can be
implemented for any `Sized` type and provides an `AsBytes`
implementation suitable for such types. Types that are not `Sized` need
to implement `AsBytes` directly and provide a method implementation.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
This is the sister patch of [1], requiring `AsBytes` implementors to
provide an `as_bytes` method, and adding the convenience trait
`AsBytesSized` that can be implemented on any sized type in order to
benefit from a suitable `AsBytes` implementation.

It is going to be used in Nova, but should also be universally useful -
if anything, it felt a bit strange that `AsBytes` did not require this
method so far as for unsized types the bytes representation cannot be
obviously inferred.

[1] https://lore.kernel.org/rust-for-linux/20250624042802.105623-1-christiansantoslima21@gmail.com/
---
 rust/kernel/dma.rs       |  4 ++--
 rust/kernel/transmute.rs | 48 ++++++++++++++++++++++++++++++++++++++++++------
 samples/rust/rust_dma.rs |  2 +-
 3 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 25dfa0e6cc3ce50aa85463dae00fbdebcf8975d2..2ada95fdb41186957ee8dd39d43e473286f01d2c 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -439,7 +439,7 @@ unsafe impl<T: AsBytes + FromBytes + Send> Send for CoherentAllocation<T> {}
 /// // SAFETY: All bit patterns are acceptable values for `MyStruct`.
 /// unsafe impl kernel::transmute::FromBytes for MyStruct{};
 /// // SAFETY: Instances of `MyStruct` have no uninitialized portions.
-/// unsafe impl kernel::transmute::AsBytes for MyStruct{};
+/// unsafe impl kernel::transmute::AsBytesSized for MyStruct{};
 ///
 /// # fn test(alloc: &kernel::dma::CoherentAllocation<MyStruct>) -> Result {
 /// let whole = kernel::dma_read!(alloc[2]);
@@ -483,7 +483,7 @@ macro_rules! dma_read {
 /// // SAFETY: All bit patterns are acceptable values for `MyStruct`.
 /// unsafe impl kernel::transmute::FromBytes for MyStruct{};
 /// // SAFETY: Instances of `MyStruct` have no uninitialized portions.
-/// unsafe impl kernel::transmute::AsBytes for MyStruct{};
+/// unsafe impl kernel::transmute::AsBytesSized for MyStruct{};
 ///
 /// # fn test(alloc: &kernel::dma::CoherentAllocation<MyStruct>) -> Result {
 /// kernel::dma_write!(alloc[2].member = 0xf);
diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
index 1c7d43771a37b90150de86699f114a2ffb84db91..91d977e035626bfb23910829653f1fc971e0e0f8 100644
--- a/rust/kernel/transmute.rs
+++ b/rust/kernel/transmute.rs
@@ -47,25 +47,61 @@ macro_rules! impl_frombytes {
 ///
 /// Values of this type may not contain any uninitialized bytes. This type must not have interior
 /// mutability.
-pub unsafe trait AsBytes {}
+pub unsafe trait AsBytes {
+    /// Returns `self` as a slice of bytes.
+    fn as_bytes(&self) -> &[u8];
+}
 
-macro_rules! impl_asbytes {
+/// Proxy trait for `AsBytes`, providing an implementation valid for all sized types.
+///
+/// If your type implements `Sized`, then you want to implement this instead of `AsBytes`.
+///
+/// # Safety
+///
+/// Values of this type may not contain any uninitialized bytes. This type must not have interior
+/// mutability.
+pub unsafe trait AsBytesSized: Sized {}
+
+unsafe impl<T: AsBytesSized> AsBytes for T {
+    fn as_bytes(&self) -> &[u8] {
+        unsafe {
+            core::slice::from_raw_parts((self as *const Self).cast::<u8>(), size_of::<Self>())
+        }
+    }
+}
+
+macro_rules! impl_asbytessized {
     ($($({$($generics:tt)*})? $t:ty, )*) => {
         // SAFETY: Safety comments written in the macro invocation.
-        $(unsafe impl$($($generics)*)? AsBytes for $t {})*
+        $(unsafe impl$($($generics)*)? AsBytesSized for $t {})*
     };
 }
 
-impl_asbytes! {
+impl_asbytessized! {
     // SAFETY: Instances of the following types have no uninitialized portions.
     u8, u16, u32, u64, usize,
     i8, i16, i32, i64, isize,
     bool,
     char,
-    str,
 
     // SAFETY: If individual values in an array have no uninitialized portions, then the array
     // itself does not have any uninitialized portions either.
-    {<T: AsBytes>} [T],
     {<T: AsBytes, const N: usize>} [T; N],
 }
+
+unsafe impl AsBytes for str {
+    fn as_bytes(&self) -> &[u8] {
+        self.as_bytes()
+    }
+}
+
+unsafe impl<T> AsBytes for [T]
+where
+    T: AsBytes,
+{
+    fn as_bytes(&self) -> &[u8] {
+        unsafe {
+            core::slice::from_raw_parts(self.as_ptr().cast::<u8>(), self.len() * size_of::<T>())
+        }
+    }
+}
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 9e05d5c0cdaeb3b36fcf204a91b52e382e73fbe6..ab4814c848f928240fc49d57ac6a2efe636fb39f 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -30,7 +30,7 @@ fn new(h: u32, b: u32) -> Self {
     }
 }
 // SAFETY: All bit patterns are acceptable values for `MyStruct`.
-unsafe impl kernel::transmute::AsBytes for MyStruct {}
+unsafe impl kernel::transmute::AsBytesSized for MyStruct {}
 // SAFETY: Instances of `MyStruct` have no uninitialized portions.
 unsafe impl kernel::transmute::FromBytes for MyStruct {}
 

---
base-commit: 14ae91a81ec8fa0bc23170d4aa16dd2a20d54105
change-id: 20250725-as_bytes-6cbc11f2e8c3

Best regards,
-- 
Alexandre Courbot <acourbot@nvidia.com>


