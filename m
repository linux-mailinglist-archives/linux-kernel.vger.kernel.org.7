Return-Path: <linux-kernel+bounces-880275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A53E8C254A8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A020188EE54
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3D722D78A;
	Fri, 31 Oct 2025 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lyJWnBvO"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010067.outbound.protection.outlook.com [52.101.61.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE3E2F6577;
	Fri, 31 Oct 2025 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761918021; cv=fail; b=oMrkJ4QRw6C8Ij6CLs/DokXu4XMrouRYR/emuRoEMNYR++Fdd+mok4luF+oub1AaLf4E8zEZ86EbN43/zubeZETBPc1/VL11qgaE59afpwl+gQIl5xGckOnAnQhuA9mPjbePM2hYaYm3PUgxYrJ1GTqODHVT+vveFAcDdecEWDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761918021; c=relaxed/simple;
	bh=62O6nVVE+gwZNyHku9oYjGj9NCgvoSfnyUWC6wTBPE8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fkidWTgPr+Xe9y9jyvqhkEBGQtx6SrV6Ab5sADLueMHxLFoIp1V2882m0mmQJH50yOXrmzeEzqflBPXOClqkIx2dnsS0Y9LVS1sbwQRIgYbHkNQ5xkaMImpdvoWJN6eVjnbOQRKv6ZhueMb2nj0mDbJz+5xZj3NOn+1KDadfEzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lyJWnBvO; arc=fail smtp.client-ip=52.101.61.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnqoYZJkKkgz4PYsGI9/DiOwycd8hoN6PwqQALscnSZ3uvF1Qek+BLwJh1j/RzpfSdYO8mMXGdhkaZOfgk3AvGdo1d8BZSW31NTJ/8NtSMUSKcwqCxLUONQo7uhQyuA1YZvBr6WmdfcmouR+NVgA6tO1qRRRLfHHCMTtQysbHPvJ+qSA5xILTndND8a5NWIebThXrZwuRtyA+ki+K5Zq/LY3ky/xlOmSZ52Z9CJKeqWuqJ1E27Me96UXHnq/u3P2zsWiLbbHDTICBL1zgy8ESeiH5kNvqv1GMeM4tTgAo0ia0XYOm3gQUnmXCMYS/lhQNGlTO2Ebq4Ns5GeDtDMDyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdsZdTOsSnNBTXBjHF3k39FpCLdVxDPHbFPLiAWnEmU=;
 b=rbQQpfs6xl8J10y2HQ5gduOA79trv85WcjU6IXuvDNwNWZgYKiSRRdoMGpvcVclAoGId8872uxfvd/NqK434KQ5ErW2oMG9VNwPUpMl5bAVVaryYS/MLD1gvi/pXqNQNOKBD5FZJfZsaQZr4Mgt7ZgEyiATay1H2RVQLA6WcM8dEPac2xx97i1/Y/iAzTptU/z+DdSM3h1pGm1yFhWZKQJ5JEX3MfQuzrcGJjhqccfzEF48KgfBZv+zn/3pigJN+mQI/uQ5GONbwW0230MrH0on349sOeWAkKlowqvGlFEN4m3zqhs7o7UVT9VJVO7TldA1HAt08OkExW0hrpZGZxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdsZdTOsSnNBTXBjHF3k39FpCLdVxDPHbFPLiAWnEmU=;
 b=lyJWnBvOuMYuKrF8q5pd9x0TAEQ2sILm3KjsHMQbZ39i6DichBTjSi7c+hQzI3uoT7lZJg83tkrJwJIfZaAtKSMe8lGkbl9MqOw3gppP93jt5pI7NFEpNT7SNleeEwNRscy8qLhfc3iMT/YZ/kZop/UrUM51gSkJ91qo4lDx0zWLQ/YOmxkBe3viP0oC3GLWNYWlsySbQmGSt+0BtgDk6oVY7vfk+k4dzWUocjvyp0pz9XNODCI+2TJ6V4B1TNPZjwEy+F0iso1sHlfmiViw5Yl2mfttlgTZ2x54ouwSjTah9NCT1d1T27XL+qTF3mK0TNfKR2b2mAQZu59vV6KVeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8211.namprd12.prod.outlook.com (2603:10b6:610:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 13:40:09 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 13:40:09 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 31 Oct 2025 22:39:57 +0900
Subject: [PATCH 1/2] rust: add BitInt integer wrapping type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-bounded_ints-v1-1-e2dbcd8fda71@nvidia.com>
References: <20251031-bounded_ints-v1-0-e2dbcd8fda71@nvidia.com>
In-Reply-To: <20251031-bounded_ints-v1-0-e2dbcd8fda71@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Jesung Yang <y.j3ms.n@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP286CA0246.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: 572fcb2f-babd-4b75-1df3-08de1883028c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z252emlzQmJhMVFUZC9SeHpoRVVYOFpQZ05nN0VsbW5USGJWaktuc3dMc09Z?=
 =?utf-8?B?TWFHcW1JSnIxYXdud2ttV0hOVGtKTUJBS2YrVjlqY2NnMWtFM0o3YVloWHBK?=
 =?utf-8?B?MDFNZmJmdDlYcFVpaUpIejRZSHhDNUtNN1psV1hiNzlnR2ZzYWhMTldkRjlQ?=
 =?utf-8?B?eit3aUwzYTVJY1NaN2ZEN25KWkdIOUlEdDdSdUZxUjNodEpVUlFHYWhwUVRG?=
 =?utf-8?B?ZU40TlJlNDlyNFRlZGJYWFV1N0VqUVUrbzNaMWlSNHcwQ1llbUJoWWlVREpp?=
 =?utf-8?B?U0VuMWIrZGVzc05acHlLYjFYUjhJZlRxUFhXZ3hSZnIzSXNSd2x0eHI4ejl0?=
 =?utf-8?B?dkpSNnBxcEVDU2tRL0xKQ0pDelZ6M3hqSCt3OUxkWDBzNzYxTnlFMnMweE9u?=
 =?utf-8?B?dWJjdTZINVlsSFFLcXRnQUxzdm9Td0xIaHBIZWMwVEZFeXgzMmpsREdrOFVO?=
 =?utf-8?B?ZEtXeDdOdVp5MFR4ZDE4TnltVCtQaWlRMUs4Umd4WG1jQXJFL2FISFVjWmpQ?=
 =?utf-8?B?d2RiWEJ5d0NGaDV4SlFCTHU4N081TTFmWmdXYXFPYUp2SnJXYitEM3ZOMzJ5?=
 =?utf-8?B?bm5NVkRiRktoMy9GOWFXK2lVMTFKY0FBOEVmektmdDgrZ2ltYmMrYm5NL1F6?=
 =?utf-8?B?bGlHdWpxWGJzckM0SCtMRENpTFNWdGlSMERSYkJnLy9idCtjZndYZ3BUejE4?=
 =?utf-8?B?SXlWUXN3SEVBbXA3ZnJQQ2ttdWE0NjQ4dkVqL2tMODE2M3VjRVk1QlVGeEha?=
 =?utf-8?B?eVhjT3dGY1BQSGpXdHNTMTNLQ2FHaGFiNGFJY3JRbTFTWDBNaGhGSmtia0JU?=
 =?utf-8?B?R1lGbFNZZlJMR09RN1ZGVFl3M0ViSStsTU1ONkhuR05admJUVE9XaDdhNGdV?=
 =?utf-8?B?MjhvVHZTbnZxU3MrRDFaWVFLaGNpRUJCS2poS1ZZYUIzWHFGTE5ZWGVJaVVW?=
 =?utf-8?B?WmwxMEFHZDk5NUVJYXJ5NVlJMENVdWV2VWFuVDl1ZjQyc0w2REUwYUlkMmIr?=
 =?utf-8?B?YmE0ZVB3VEt4dWYxcU5sKzdtNGdHVXYzMzBBT3lkQUdDNDNVL1dVN1pGdWxS?=
 =?utf-8?B?Y2RtTGhJamFOQytlemhXWkYzcGw1UzhKTlVINWFiQWtKMUlQZXBBU2FiZEdK?=
 =?utf-8?B?S1dROUc2TUdCeDNjbng4bHhCQk5yWitmNldDRmdYbjkxL0pQc0ptM1lXY0xv?=
 =?utf-8?B?MjZiaThvMEVVL1hCR3hRUlp2Q1BQcXBOditIUSswOVdZanJpZjM3aXlhZXU1?=
 =?utf-8?B?cyt5VWlVMkkyZDVUQmlHUUlXQlhEUW5pSEFrK0MvVWhGMFV6TUo1elUzaFZV?=
 =?utf-8?B?UHNjVm5xTTd4NHBnRGRyUUtRNmNsdTFsN0tQcWVhaVAyQ09HczdnRFdJWTBC?=
 =?utf-8?B?SGxkRWdNRWxLZWVXNGlXYUpialdCenpreXJRWkJqUERocjMxd0cxWWlNWHZD?=
 =?utf-8?B?eHhuYThEWElHZ2RhbG9ob09CenI2KzdqckllMHh0R1pZcEs4UTQwWFBsU0g2?=
 =?utf-8?B?VzlkZTVEUFQ2WWlWQ2ZwZ3BXZVl6V0svWkllM2hkOWI1ZTV2UjFZZytOSE92?=
 =?utf-8?B?OHVCaUJNV3l0MmNLZVF1YmdxUHdOTUpUT0NaR3ZSK1lXRUNxSkJBQXgxYmlJ?=
 =?utf-8?B?dFJ5V3NCaS9TT1UrdkZkMzNxOVdTU0xtK1hQWVVMcjd5YmNudW1DRXRWakts?=
 =?utf-8?B?V0JObmRpdThFK3FDMTd5UTg3LzFLWnpPZVkrbzBuNmFwYU9xWDRXRE8rTjVn?=
 =?utf-8?B?STFBN3RJUVZ3RW52WVc2clU4ZGFaRWF6OHhNbHlDUkIzMWhnOWFPOGRjUElM?=
 =?utf-8?B?ZFVTanJTQ2tnTlpxc2FWQ0E5TkVmWTcrTzR3Z3NabU5BS0QxNnp2VkUwYkoz?=
 =?utf-8?B?OTJFUFhRZGZvekFDR0dGeGtkVXg4Q212Q3duVXZVSkJrdi91MGFkNkxEMlor?=
 =?utf-8?B?MkdzQVF6OEtMUENIa1BnVmw1RmRVVVk5NEhJN1FJZ29qc3ljK2g0RzBEdjdv?=
 =?utf-8?Q?YODGk88ZKU83vX3D6j9EjZDfPF92ZE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3IvdFhiZ2dzc3NDMjBhYldRb0FzaEVhaFd2RUlPUUREaXBSamUreGRRTmdD?=
 =?utf-8?B?SHJYTGtNUkZrbmpGTzF1K1dpYU5CdW9QUXhDSmh3RGxtNUhRellqOUZnaTBw?=
 =?utf-8?B?US9FWmVMb09UV25pdW9ReTBYa2d2WlVEY1VqSFJJNStXeWxNejNIdmo5OFhp?=
 =?utf-8?B?SElqYWRjem1DQmVNdUhTWlQycmxURzBzQ0s5c2hlTEtsRVVyMXFoYkdjTWQv?=
 =?utf-8?B?SGlONkc0Y1REMVMwWUxkOTd3V2ZWTGNPYzNzZmVQTTlvWGZ3cUpHMElFMTF6?=
 =?utf-8?B?MHFESVVvTHJYM0cvTzQwd3ZOWXZzb0xlUlVKTHN2RVZIdXE2ZzFVb1RKZU16?=
 =?utf-8?B?SStCQ0VxR3RTSm9HTWhBOFdyUmx0RW5hTGFZVWQ4N2ZTVW9FR0I1SmR0UEhQ?=
 =?utf-8?B?bWVMSmxmcElpWFdVU3NxckxyZWV0cFBNYmZNRm5JMjRvNHZXNDlQajkremxE?=
 =?utf-8?B?UEU4Yk9QRHZ3Z3RpT3NieWlKRWg5UW5uM0lMMzhmUDdHNjlBbngvTzVNNm5y?=
 =?utf-8?B?U20vNEhJTHJTNzdTbVNjQUhYUUgrTVB3VzVoc3ZYby9OczBrWnZzWFlwTUh6?=
 =?utf-8?B?a0E1Sk1PNDNMaGZhbmY2OFFscGl6a2RYVTFmRHFNVE9WZ2Y4R1ZWUEsvb292?=
 =?utf-8?B?UWZxTkozTmJpL1Z2QWU2amNRcFZZVWxVbUdCNnJMUStUVzUrVWdRMVp3aThl?=
 =?utf-8?B?QkVrQkR0U2hWWVBKT0tKd1pJaGRjY3gxaXB0aTl0YlRaaHd1K3k3bGtXUjdi?=
 =?utf-8?B?RXJ0enNoTTVRY3NValJ5S3VVSkdDdy9BNDVKcDZEd1liMytNb2FNZGNGcC9O?=
 =?utf-8?B?L1oveWNQOVF1dTNYZHhMWmtWaWJnOTVpSnhqamRFMWlaNkZ5TnVvMi91Vjl3?=
 =?utf-8?B?T05FZzcyN1N2NXZkaWJRc3BSc0VRa2Y4WWJzZnpDVFBoeU8vMytZMmhiR0E5?=
 =?utf-8?B?N2RENEs4ZytpV1pJUnplWmh3UmpWSnR0MStKbFgxaU5WWU1iLzN0NnRXYmZV?=
 =?utf-8?B?bHpzeUd3NWdvMkprN3RDVEE5c2NzZ3c5RkdnVXVvb3pURndiN0xLNTU3V3ZD?=
 =?utf-8?B?bWxCeTd5V2Y2M0NLcFc5UXRNQ2xDazdOR1ROZFd0cGVBZEdWaU93M1hmUFlP?=
 =?utf-8?B?QVVaeW94RXJhZncvRmhsUFRRQ21UVkxwaHVXWlgzMkFtemZkQTMzd3padldP?=
 =?utf-8?B?bzFvdVdlaFdDZ2RwclJCVmVtcnp6dzlZN1dWaWFaM2VGcDJ4bENyZTJ2Rzg0?=
 =?utf-8?B?bEdZTHNhVVVSZzdQc0Z1aG1kYUl4a3FTc2U4T1FjcjBBMkpXdHYyVlkwYmRQ?=
 =?utf-8?B?dUpOYU1YcDFFUWdjL1BuR1dsUVZmcTJyczZkVitCdjhsWlhHdFZsVis4a3F1?=
 =?utf-8?B?ZkFWNGNBUXBDOXBuMUhwWlV1OFRiUTFPb3RpdWhCangzZk9WZFFTbWFzVnhn?=
 =?utf-8?B?T0E2d2Y2SktENlQwUzJSM1JkS1QvdHU2STNzemxNT3dySnMyYy9kRHRrbC9L?=
 =?utf-8?B?blV5clpoWDdyWmE2eGRsblMzbHZXYUtMZm1BMnNoM3loRENMWndKaDZIWjFV?=
 =?utf-8?B?MVJpd1JyYmU0ZTZESWVkUy9aYThwQW5jZnVtOFh5SC9jUFNvUzhtazI3c1dH?=
 =?utf-8?B?WkhiVnd0QkpvYlVKZTZ2M3ZWNjJEZ2o1V0FLR3d0S3cyREpMaTJ4NGk0SHl2?=
 =?utf-8?B?RU9uTHNnLzVwT2lrUFoxcVloRnY2VDZ2T0Z6ZjdLK1JrQk5XTlZWWEtBU2xB?=
 =?utf-8?B?Yk4yaU8wL05TR2hYbzZaMkFtOXBUQXo5SGZpS0ZPQmdUaGh1Wi9SNVVwZUlE?=
 =?utf-8?B?WVNGelpzczNSQks3eHkyeGJYb1NyOWpzVTl2dGFVaXRyc3pWUitNL0NUUGZ4?=
 =?utf-8?B?REJPR3ZhUVhRbTBLMFl3bDBjVzZMZlVINEZOZmsrRmYyTmgzL1R5Z0hRVGx0?=
 =?utf-8?B?QlJyNTNORzd1Rmw5U3VTcG9lcFpCcHpKb21CN0wyUnFWaHRaanFvTnd4ZXFM?=
 =?utf-8?B?Z3Jyd2FrcWFXcVpEOGNQdFh3Q0tYMU1pQlNRZjdUM294TGY5dTJRQVFMc2dx?=
 =?utf-8?B?UitGdWJUeW9qOVQ4bGhhRnNIVFVITytTNHNyUnNhN2M5a0YvWTM1MmRGVkM5?=
 =?utf-8?B?LzdIMDBLOE52UGFPU0t2MGFHRGRmM1BQVk40enFvMjY5aWp6dXlISTR1TmVC?=
 =?utf-8?Q?5dXpvXGMRrGfmCVz3W6L7ydHYqsjaKbr7Ji0EdW36sey?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 572fcb2f-babd-4b75-1df3-08de1883028c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 13:40:09.8552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N04rhIQkZAZIQS2uWfMDfVd4s9KQEuBcyt2jMBMFq5JDIKH1tv1yCPQQ2KHEiUAW5gfdmDl0qxGWqAkRxMzsSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8211

Add the `BitInt` type, which is an integer on which the number of bits
allowed to be used is restricted, capping its maximal value below that
of primitive type is wraps.

This is useful to e.g. enforce guarantees when working with bit fields.

Alongside this type, provide many `From` and `TryFrom` implementations
are to reduce friction when using with regular integer types. Proxy
implementations of common integer traits are also provided.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/lib.rs        |   1 +
 rust/kernel/num.rs        |  75 ++++
 rust/kernel/num/bitint.rs | 896 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 972 insertions(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 3dd7bebe7888..235d0d8b1eff 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -109,6 +109,7 @@
 pub mod mm;
 #[cfg(CONFIG_NET)]
 pub mod net;
+pub mod num;
 pub mod of;
 #[cfg(CONFIG_PM_OPP)]
 pub mod opp;
diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
new file mode 100644
index 000000000000..4e81879d88f7
--- /dev/null
+++ b/rust/kernel/num.rs
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Numerical features for the kernel.
+
+pub mod bitint;
+pub use bitint::*;
+
+/// Type used to designate unsigned primitive types.
+pub struct Unsigned;
+
+/// Type used to designate signed primitive types.
+pub struct Signed;
+
+/// Trait describing properties of integer types.
+pub trait Integer {
+    /// Whether this type is [`Signed`] or [`Unsigned`].
+    type Signedness;
+
+    /// Number of bits used for value representation.
+    const BITS: u32;
+}
+
+impl Integer for bool {
+    type Signedness = Unsigned;
+
+    const BITS: u32 = 1;
+}
+
+impl Integer for u8 {
+    type Signedness = Unsigned;
+
+    const BITS: u32 = u8::BITS;
+}
+
+impl Integer for u16 {
+    type Signedness = Unsigned;
+
+    const BITS: u32 = u16::BITS;
+}
+
+impl Integer for u32 {
+    type Signedness = Unsigned;
+
+    const BITS: u32 = u32::BITS;
+}
+
+impl Integer for u64 {
+    type Signedness = Unsigned;
+
+    const BITS: u32 = u64::BITS;
+}
+
+impl Integer for i8 {
+    type Signedness = Signed;
+
+    const BITS: u32 = i8::BITS;
+}
+
+impl Integer for i16 {
+    type Signedness = Signed;
+
+    const BITS: u32 = i16::BITS;
+}
+
+impl Integer for i32 {
+    type Signedness = Signed;
+
+    const BITS: u32 = i32::BITS;
+}
+
+impl Integer for i64 {
+    type Signedness = Signed;
+
+    const BITS: u32 = i64::BITS;
+}
diff --git a/rust/kernel/num/bitint.rs b/rust/kernel/num/bitint.rs
new file mode 100644
index 000000000000..5af1447347a8
--- /dev/null
+++ b/rust/kernel/num/bitint.rs
@@ -0,0 +1,896 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! [`BitInt`], a primitive integer type with a limited set of bits usable to represent values.
+
+use core::ops::Deref;
+
+use kernel::num::{Integer, Signed, Unsigned};
+use kernel::prelude::*;
+
+/// Evaluates to `true` if `$value` can be represented using at most `$num_bits` on `$type`.
+///
+/// Can be used in const context.
+macro_rules! fits_within {
+    ($value:expr, $type:ty, $num_bits:expr) => {{
+        // Any attempt to create a `BitInt` with more bits used for representation than its backing
+        // type (i.e. create an invalid `BitInt`) must be aborted at build time.
+        build_assert!(
+            <$type>::BITS >= $num_bits,
+            "Number of bits requested for representation is larger than backing type."
+        );
+
+        let shift: u32 = <$type>::BITS - $num_bits;
+        let v = $value;
+
+        // The value fits within `NUM_BITS` if shifting it left by the number of unused bits, then
+        // right by the same number, doesn't change the value.
+        //
+        // This method has the benefit of working with both unsigned and signed integers.
+        (v << shift) >> shift == v
+    }};
+}
+
+/// Trait for primitive integer types that can be used to back a [`BitInt`].
+///
+/// This is mostly used to lock all the operations we need for [`BitInt`] in a single trait.
+pub trait Boundable
+where
+    Self: Integer
+        + Sized
+        + Copy
+        + core::ops::Shl<u32, Output = Self>
+        + core::ops::Shr<u32, Output = Self>
+        + core::cmp::PartialEq,
+    Self: TryInto<u8> + TryInto<u16> + TryInto<u32> + TryInto<u64>,
+    Self: TryInto<i8> + TryInto<i16> + TryInto<i32> + TryInto<i64>,
+{
+    /// Returns `true` if `value` can be represented with at most `NUM_BITS` on `T`.
+    fn fits_within(value: Self, num_bits: u32) -> bool {
+        fits_within!(value, Self, num_bits)
+    }
+}
+
+/// Inplement `Boundable` for all integers types.
+impl<T> Boundable for T
+where
+    T: Integer
+        + Sized
+        + Copy
+        + core::ops::Shl<u32, Output = Self>
+        + core::ops::Shr<u32, Output = Self>
+        + core::cmp::PartialEq,
+    Self: TryInto<u8> + TryInto<u16> + TryInto<u32> + TryInto<u64>,
+    Self: TryInto<i8> + TryInto<i16> + TryInto<i32> + TryInto<i64>,
+{
+}
+
+/// Integer type for which only the bits `0..NUM_BITS` are valid.
+///
+/// # Invariants
+///
+/// Stored values are represented with at most `NUM_BITS` bits.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::num::BitInt;
+///
+/// // An unsigned 8-bit integer, of which only the 4 LSBs can ever be set.
+/// // The value `15` is statically validated to fit within the specified number of bits.
+/// let v = BitInt::<u8, 4>::new::<15>();
+/// assert_eq!(v.get(), 15);
+///
+/// let v = BitInt::<i8, 4>::new::<-8>();
+/// assert_eq!(v.get(), -8);
+///
+/// // This doesn't build: a `u8` is smaller than the requested 9 bits.
+/// // let _ = BitInt::<u8, 9>::new::<10>();
+///
+/// // This also doesn't build: the requested value doesn't fit within the requested bits.
+/// // let _ = BitInt::<i8, 4>::new::<8>();
+///
+/// // Values can also be validated at runtime. This succeeds because `15` can be represented
+/// // with 4 bits.
+/// assert!(BitInt::<u8, 4>::try_new(15).is_some());
+/// // This fails because `16` cannot be represented with 4 bits.
+/// assert!(BitInt::<u8, 4>::try_new(16).is_none());
+///
+/// // Non-constant expressions can also be validated at build-time thanks to compiler
+/// // optimizations. This should be used as a last resort though.
+/// let v = BitInt::<u8, 4>::from_expr(15);
+///
+/// // Common operations are supported against the backing type.
+/// assert_eq!(v + 5, 20);
+/// assert_eq!(v / 3, 5);
+///
+/// // The backing type can be changed while preserving the number of bits used for representation.
+/// assert_eq!(v.cast::<u32>(), BitInt::<u32, 4>::new::<15>());
+///
+/// // We can safely extend the number of bits...
+/// assert_eq!(v.extend::<5>(), BitInt::<u8, 5>::new::<15>());
+/// // ... but reducing the number of bits fails here as the value doesn't fit anymore.
+/// assert_eq!(v.try_shrink::<3>(), None);
+///
+/// // Conversion into primitive types is dependent on the number of useful bits, not the backing
+/// // type.
+/// //
+/// // Event though its backing type is `u32`, this `BitInt` only uses 8 bits and thus can safely
+/// // be converted to a `u8`.
+/// assert_eq!(u8::from(BitInt::<u32, 8>::new::<128>()), 128u8);
+///
+/// // The same applies to signed values.
+/// assert_eq!(i8::from(BitInt::<i32, 8>::new::<127>()), 127i8);
+///
+/// // This however is not allowed, as 10 bits won't fit into a `u8` (regardless of the actually
+/// // contained value).
+/// // let _ = u8::from(BitInt::<u32, 10>::new::<10>());
+///
+/// // Conversely, `BitInt` types large enough to contain a given primitive type can be created
+/// // directly from it:
+/// //
+/// // This `BitInt` has 8 bits, so it can represent any `u8`.
+/// let _ = BitInt::<u32, 8>::from(128u8);
+///
+/// // This `BitInt` has 8 bits, so it can represent any `i8`.
+/// let _ = BitInt::<i32, 8>::from(127i8);
+///
+/// // This is not allowed, as this 6-bit `BitInt` does not have enough capacity to represent a
+/// // `u8` (regardless of the passed value).
+/// // let _ = BitInt::<u32, 6>::from(10u8);
+///
+/// // A `u8` can be converted to an `i16` if we allow at least 9 bits to be used.
+/// let _ = BitInt::<i16, 9>::from(255u8);
+/// // ... but 8 bits aren't enough as the MSB is used for the sign, so this doesn't build.
+/// // let _ = BitInt::<i16, 8>::from(255u8);
+/// ```
+#[repr(transparent)]
+#[derive(Clone, Copy, Debug, Default, Hash)]
+pub struct BitInt<T: Boundable, const NUM_BITS: u32>(T);
+
+/// Validating the value as a const expression cannot be done as a regular method, as the
+/// arithmetic expressions we rely on to check the bounds are not const. Thus, implement
+/// [`BitInt::new`] using a macro.
+macro_rules! impl_const_new {
+    ($($type:ty)*) => {
+        $(
+        impl<const NUM_BITS: u32> BitInt<$type, NUM_BITS> {
+            /// Creates a [`BitInt`] for the constant `VALUE`.
+            ///
+            /// Fails at build time if `VALUE` cannot be represented with `NUM_BITS`.
+            ///
+            /// This method should be used preferred to [`Self::from_expr`] whenever possible.
+            ///
+            /// # Examples
+            /// ```
+            /// use kernel::num::BitInt;
+            ///
+            #[doc = ::core::concat!(
+                "let v = BitInt::<",
+                ::core::stringify!($type),
+                ", 4>::new::<7>();")]
+            /// assert_eq!(v.get(), 7);
+            /// ```
+            pub const fn new<const VALUE: $type>() -> Self {
+                build_assert!(
+                    fits_within!(VALUE, $type, NUM_BITS),
+                    "Requested value larger than maximal representable value."
+                );
+
+                // INVARIANT: `fits_within` confirmed that `value` can be represented within
+                // `NUM_BITS`.
+                Self(VALUE)
+            }
+        }
+        )*
+    };
+}
+
+impl_const_new!(u8 u16 u32 u64);
+impl_const_new!(i8 i16 i32 i64);
+
+impl<T, const NUM_BITS: u32> BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+{
+    /// Attempts to convert `value` into a `BitInt` using `NUM_BITS`.
+    ///
+    /// Returns [`None`] if `value` doesn't fit within `NUM_BITS`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::num::BitInt;
+    ///
+    /// assert_eq!(BitInt::<u8, 1>::try_new(1).as_deref(), Some(&1));
+    /// assert_eq!(BitInt::<u16, 8>::try_new(0xff).as_deref(), Some(&0xff));
+    ///
+    /// // `0x1ff` doesn't fit into 8 bits.
+    /// assert_eq!(BitInt::<u32, 8>::try_new(0x1ff), None);
+    ///
+    /// // Signed types can also be used.
+    /// assert_eq!(BitInt::<i8, 4>::try_new(-2).as_deref(), Some(&-2));
+    /// assert_eq!(BitInt::<i8, 4>::try_new(7).as_deref(), Some(&7));
+    ///
+    /// // `8` doesn't fit into 4 signed bits.
+    /// assert_eq!(BitInt::<i8, 4>::try_new(8), None);
+    ///
+    /// // `-9` doesn't fit into 4 signed bits.
+    /// assert_eq!(BitInt::<i8, 4>::try_new(-9), None);
+    /// ```
+    pub fn try_new(value: T) -> Option<Self> {
+        if !T::fits_within(value, NUM_BITS) {
+            None
+        } else {
+            // INVARIANT: `fits_within` confirmed that `value` can be represented within `NUM_BITS`.
+            Some(Self(value))
+        }
+    }
+
+    /// Checks that `expr` is valid for this type at compile-time and build a new value.
+    ///
+    /// This relies on [`build_assert!`] to perform validation at compile-time. If `expr` cannot
+    /// be inferred to be in bounds at compile-time, use the fallible [`Self::try_new`] instead.
+    ///
+    /// When possible, use one of the [`Self::new`] constructors instead of this one as it
+    /// statically validates `expr` instead of relying on the compiler's optimizations.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::num::BitInt;
+    ///
+    /// # fn some_number() -> u32 { 0xffffffff }
+    ///
+    /// assert_eq!(BitInt::<u8, 1>::from_expr(1).get(), 1);
+    /// assert_eq!(BitInt::<u16, 8>::from_expr(0xff).get(), 0xff);
+    ///
+    /// // Triggers a build error as `0x1ff` doesn't fit into 8 bits.
+    /// // assert_eq!(BitInt::<u32, 8>::from_expr(0x1ff).get(), 0x1ff);
+    ///
+    /// // Signed types can also be used.
+    /// assert_eq!(BitInt::<i8, 4>::from_expr(-2).get(), -2);
+    /// assert_eq!(BitInt::<i8, 4>::from_expr(7).get(), 7);
+    ///
+    /// // Triggers a build error as `8` cannot be represented with 4 signed bits.
+    /// // assert_eq!(BitInt::<i8, 4>::from_expr(8).get(), 8);
+    ///
+    /// // Triggers a build error as `-9` cannot be represented with 4 signed bits.
+    /// // assert_eq!(BitInt::<i8, 4>::from_expr(-9).get(), -9);
+    ///
+    /// let v: u32 = some_number();
+    /// // Triggers a build error as `v` cannot be asserted to fit within 4 bits...
+    /// // let _ = BitInt::<u32, 4>::from_expr(v);
+    /// // ... but this works as the compiler can assert the range from the mask.
+    /// let _ = BitInt::<u32, 4>::from_expr(v & 0xf);
+    /// ```
+    pub fn from_expr(expr: T) -> Self {
+        crate::build_assert!(
+            T::fits_within(expr, NUM_BITS),
+            "Requested value larger than maximal representable value."
+        );
+
+        // INVARIANT: `fits_within` confirmed that `expr` can be represented within `NUM_BITS`.
+        Self(expr)
+    }
+
+    /// Returns the contained value as the backing type.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::num::BitInt;
+    ///
+    /// let v = BitInt::<u32, 4>::new::<7>();
+    /// assert_eq!(v.get(), 7u32);
+    /// ```
+    pub fn get(self) -> T {
+        *self.deref()
+    }
+
+    /// Increase the number of bits usable for `self`.
+    ///
+    /// This operation cannot fail.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::num::BitInt;
+    ///
+    /// let v = BitInt::<u32, 4>::new::<7>();
+    /// let larger_v = v.extend::<12>();
+    /// // The contained values are equal even though `larger_v` has a bigger capacity.
+    /// assert_eq!(larger_v, v);
+    /// ```
+    pub const fn extend<const NEW_NUM_BITS: u32>(self) -> BitInt<T, NEW_NUM_BITS> {
+        build_assert!(
+            NEW_NUM_BITS >= NUM_BITS,
+            "Requested number of bits is less than the current representation."
+        );
+
+        // INVARIANT: the value did fit within `NUM_BITS`, so it will all the more fit within
+        // the larger `NEW_NUM_BITS`.
+        BitInt(self.0)
+    }
+
+    /// Shrink the number of bits usable for `self`.
+    ///
+    /// Returns [`None`] if the value of `self` cannot be represented within `NEW_NUM_BITS`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::num::BitInt;
+    ///
+    /// let v = BitInt::<u32, 12>::new::<7>();
+    /// let smaller_v = v.try_shrink::<4>().ok_or(EOVERFLOW)?;
+    /// // The contained values are equal even though `smaller_v` has a smaller capacity.
+    /// assert_eq!(smaller_v, v);
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn try_shrink<const NEW_NUM_BITS: u32>(self) -> Option<BitInt<T, NEW_NUM_BITS>> {
+        BitInt::<T, NEW_NUM_BITS>::try_new(self.get())
+    }
+
+    /// Casts `self` into a [`BitInt`] backed by a different storage type, but using the same
+    /// number of bits for value representation.
+    ///
+    /// This method cannot fail as the number of bits used for representation doesn't change.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::num::BitInt;
+    ///
+    /// let v = BitInt::<i32, 4>::new::<-3>();
+    /// let u: BitInt<i8, _> = v.cast();
+    /// // The contained values are equal even though `u` has a smaller storage type.
+    /// assert_eq!(i32::from(u.get()), v.get());
+    ///
+    /// let v = BitInt::<u8, 7>::new::<127>();
+    /// // This doesn't build: signedness cannot be safely changed when casting.
+    /// // let _: BitInt<i8, _> = v.cast();
+    /// ```
+    pub fn cast<U>(self) -> BitInt<U, NUM_BITS>
+    where
+        U: TryFrom<T> + Boundable,
+        T: Integer,
+        // Only allow casting from types of same signedness.
+        U: Integer<Signedness = T::Signedness>,
+    {
+        // Make sure that the target type can contain the required number of bits.
+        build_assert!(U::BITS >= NUM_BITS, "Cast to incompatible target type.");
+
+        // SAFETY: the contained value is represented using `NUM_BITS`, `U` is larger than
+        // `NUM_BITS`, and `U` and `T` have the same sign, hence this conversion cannot fail.
+        let value = unsafe { U::try_from(self.0).unwrap_unchecked() };
+
+        // INVARIANT: although the storage type has changed, the value is still represented within
+        // `NUM_BITS`, and with the same signedness.
+        BitInt(value)
+    }
+}
+
+impl<T, const NUM_BITS: u32> Deref for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+{
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        if !T::fits_within(self.0, NUM_BITS) {
+            // SAFETY: Per the `BitInt` invariants, `fits_within` can never return `false`.
+            unsafe { core::hint::unreachable_unchecked() }
+        }
+        &self.0
+    }
+}
+
+/// Trait similar to [`TryInto`] but for `BitInt`, to avoid conflicting implementations errors.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::num::{BitInt, TryIntoBitInt};
+///
+/// // Succeed because `128` fits into 8 bits.
+/// assert_eq!(128u32.try_into_bitint(), Some(BitInt::<u16, 8>::new::<128>()));
+/// // Fails because `128` doesn't fits into 6 bits.
+/// assert_eq!(TryIntoBitInt::<u16, 6>::try_into_bitint(128u32), None);
+/// ```
+pub trait TryIntoBitInt<T: Boundable, const NUM_BITS: u32> {
+    /// Attempts to convert `self` into a [`BitInt`] using `NUM_BITS`.
+    fn try_into_bitint(self) -> Option<BitInt<T, NUM_BITS>>;
+}
+
+/// Any value can be attempted to be converted into a [`BitInt`] of any size.
+impl<T, U, const NUM_BITS: u32> TryIntoBitInt<T, NUM_BITS> for U
+where
+    T: Boundable,
+    U: TryInto<T>,
+{
+    fn try_into_bitint(self) -> Option<BitInt<T, NUM_BITS>> {
+        self.try_into().ok().and_then(BitInt::try_new)
+    }
+}
+
+/// Allows comparison between [`BitInt`]s, even if their number of valid bits differ.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::num::BitInt;
+///
+/// let v1 = BitInt::<u32, 8>::new::<15>();
+/// let v2 = BitInt::<u32, 4>::new::<15>();
+/// assert_eq!(v1, v2);
+/// ```
+impl<T, U, const NUM_BITS: u32, const NUM_BITS_U: u32> PartialEq<BitInt<U, NUM_BITS_U>>
+    for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    U: Boundable,
+    T: PartialEq<U>,
+{
+    fn eq(&self, other: &BitInt<U, NUM_BITS_U>) -> bool {
+        self.get() == other.get()
+    }
+}
+
+impl<T, const NUM_BITS: u32> Eq for BitInt<T, NUM_BITS> where T: Boundable {}
+
+/// Allows partial ordering between [`BitInt`]s, even if their number of valid bits differ.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::num::BitInt;
+///
+/// let v1 = BitInt::<u32, 8>::new::<4>();
+/// let v2 = BitInt::<u32, 4>::new::<15>();
+/// assert!(v1 < v2);
+/// ```
+impl<T, U, const NUM_BITS: u32, const NUM_BITS_U: u32> PartialOrd<BitInt<U, NUM_BITS_U>>
+    for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    U: Boundable,
+    T: PartialOrd<U>,
+{
+    fn partial_cmp(&self, other: &BitInt<U, NUM_BITS_U>) -> Option<core::cmp::Ordering> {
+        self.get().partial_cmp(&other.get())
+    }
+}
+
+/// Allows ordering between [`BitInt`]s.
+///
+/// # Examples
+///
+/// ```
+/// use core::cmp::Ordering;
+/// use kernel::num::BitInt;
+///
+/// let v1 = BitInt::<u32, 8>::new::<4>();
+/// let v2 = BitInt::<u32, 8>::new::<15>();
+/// assert_eq!(v1.cmp(&v2), Ordering::Less);
+/// ```
+impl<T, const NUM_BITS: u32> Ord for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: Ord,
+{
+    fn cmp(&self, other: &Self) -> core::cmp::Ordering {
+        self.get().cmp(&other.get())
+    }
+}
+
+/// Allows comparison between a [`BitInt`] and its backing type.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::num::BitInt;
+///
+/// let v = BitInt::<u32, 8>::new::<15>();
+/// assert_eq!(v, 15);
+/// ```
+impl<T, const NUM_BITS: u32> PartialEq<T> for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: PartialEq,
+{
+    fn eq(&self, other: &T) -> bool {
+        self.get() == *other
+    }
+}
+
+/// Allows partial ordering between a [`BitInt`] and its backing type.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::num::BitInt;
+///
+/// let v = BitInt::<u32, 8>::new::<4>();
+/// assert!(v < 15);
+/// ```
+impl<T, const NUM_BITS: u32> PartialOrd<T> for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: PartialOrd,
+{
+    fn partial_cmp(&self, other: &T) -> Option<core::cmp::Ordering> {
+        self.get().partial_cmp(other)
+    }
+}
+
+/// Allows adding a [`BitInt`] to its backing type.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::num::BitInt;
+///
+/// let v = BitInt::<u32, 4>::new::<15>();
+/// assert_eq!(v + 5, 20);
+/// ```
+impl<T, const NUM_BITS: u32> core::ops::Add<T> for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: core::ops::Add<Output = T>,
+{
+    type Output = T;
+
+    fn add(self, rhs: T) -> Self::Output {
+        *self + rhs
+    }
+}
+
+/// Allows subtracting a [`BitInt`] to its backing type.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::num::BitInt;
+///
+/// let v = BitInt::<u32, 4>::new::<15>();
+/// assert_eq!(v - 5, 10);
+/// ```
+impl<T, const NUM_BITS: u32> core::ops::Sub<T> for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: core::ops::Sub<Output = T>,
+{
+    type Output = T;
+
+    fn sub(self, rhs: T) -> Self::Output {
+        *self - rhs
+    }
+}
+
+/// Allows multiplying a [`BitInt`] to its backing type.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::num::BitInt;
+///
+/// let v = BitInt::<u32, 4>::new::<15>();
+/// assert_eq!(v * 10, 150);
+/// ```
+impl<T, const NUM_BITS: u32> core::ops::Mul<T> for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: core::ops::Mul<Output = T>,
+{
+    type Output = T;
+
+    fn mul(self, rhs: T) -> Self::Output {
+        *self * rhs
+    }
+}
+
+/// Allows dividing a [`BitInt`] to its backing type.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::num::BitInt;
+///
+/// let v = BitInt::<u32, 4>::new::<15>();
+/// assert_eq!(v / 3, 5);
+/// ```
+impl<T, const NUM_BITS: u32> core::ops::Div<T> for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: core::ops::Div<Output = T>,
+{
+    type Output = T;
+
+    fn div(self, rhs: T) -> Self::Output {
+        *self / rhs
+    }
+}
+
+/// Allows getting a remainder of a [`BitInt`] when divided by its backing type.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::num::BitInt;
+///
+/// let v = BitInt::<u32, 4>::new::<15>();
+/// assert_eq!(v % 10, 5);
+/// ```
+impl<T, const NUM_BITS: u32> core::ops::Rem<T> for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: core::ops::Rem<Output = T>,
+{
+    type Output = T;
+
+    fn rem(self, rhs: T) -> Self::Output {
+        *self % rhs
+    }
+}
+
+// TODO: implement more of std::ops.
+
+impl<T, const NUM_BITS: u32> core::fmt::Display for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: core::fmt::Display,
+{
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        self.0.fmt(f)
+    }
+}
+
+impl<T, const NUM_BITS: u32> core::fmt::LowerHex for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: core::fmt::LowerHex,
+{
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        self.0.fmt(f)
+    }
+}
+
+impl<T, const NUM_BITS: u32> core::fmt::UpperHex for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: core::fmt::UpperHex,
+{
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        self.0.fmt(f)
+    }
+}
+
+/// Declares a new `$trait` and implements it for all [`BitInt`] types represented using
+/// `$num_bits`.
+///
+/// This is used to declare properties as traits that we can use in later implementations.
+macro_rules! impl_size_rule {
+    ($trait:ident, $($num_bits:literal)*) => {
+        trait $trait {}
+
+        $(
+        impl<T> $trait for BitInt<T, $num_bits> where T: Boundable {}
+        )*
+    };
+
+    // Variant declaring and implementing two traits, for signed and unsigned integers.
+    ($u_trait:ident, $i_trait:ident, $($num_bits:literal)*) => {
+        trait $u_trait {}
+        trait $i_trait {}
+
+        $(
+        impl<T> $u_trait for BitInt<T, $num_bits>
+        where
+            T: Boundable + Integer<Signedness = Unsigned>
+        {
+        }
+
+        impl<T> $i_trait for BitInt<T, $num_bits>
+        where
+            T: Boundable + Integer<Signedness = Signed>
+        {
+        }
+        )*
+    };
+}
+
+/// Implementations for infallibly converting a primitive type into a `BitInt` that can contain it.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::num::BitInt;
+///
+/// // This `BitInt` has 8 bits, so it can represent any `u8`.
+/// let _ = BitInt::<u32, 8>::from(128u8);
+///
+/// // This `BitInt` has 8 bits, so it can represent any `i8`.
+/// let _ = BitInt::<i32, 8>::from(127i8);
+///
+/// // This is not allowed, as this 6-bit `BitInt` does not have enough capacity to represent a
+/// // `u8` (regardless of the passed value).
+/// // let _ = BitInt::<u32, 6>::from(10u8);
+///
+/// // A `u8` can be converted to an `i16` if we allow at least 9 bits to be used.
+/// let _ = BitInt::<i16, 9>::from(255u8);
+/// // ... but 8 bits aren't enough as the MSB is used for the sign, so this doesn't build.
+/// // let _ = BitInt::<i16, 8>::from(255u8);
+/// ```
+mod atleast_impls {
+    use super::*;
+
+    // Number of bits at least as large as `64`.
+    impl_size_rule!(AtLeast64Bits, 64);
+
+    // Number of bits at least as large as `32`.
+    impl_size_rule!(AtLeast32Bits,
+        32 33 34 35 36 37 38 39
+        40 41 42 43 44 45 46 47
+        48 49 50 51 52 53 54 55
+        56 57 58 59 60 61 62 63
+    );
+    // Anything larger than `64` is also larger than `32`.
+    impl<T> AtLeast32Bits for T where T: AtLeast64Bits {}
+
+    // Number of bits at least as large as `16`.
+    impl_size_rule!(AtLeast16Bits,
+        16 17 18 19 20 21 22 23
+        24 25 26 27 28 29 30 31
+    );
+    // Anything larger than `32` is also larger than `16`.
+    impl<T> AtLeast16Bits for T where T: AtLeast32Bits {}
+
+    // Number of bits at least as large as a `8`.
+    impl_size_rule!(AtLeast8Bits, 8 9 10 11 12 13 14 15);
+    // Anything larger than `16` is also larger than `8`.
+    impl<T> AtLeast8Bits for T where T: AtLeast16Bits {}
+
+    // Number of bits at least as large as `1`.
+    impl_size_rule!(AtLeast1Bit, 1 2 3 4 5 6 7);
+    // Anything larger than `8` is also larger than `1`.
+    impl<T> AtLeast1Bit for T where T: AtLeast8Bits {}
+
+    /// Generates `From` implementations from a primitive type into a [`BitInt`] that is
+    /// guaranteed to being able to contain it.
+    macro_rules! impl_from_primitive {
+        ($($type:ty => $trait:ident),*) => {
+            $(
+            impl<T, const NUM_BITS: u32> From<$type> for BitInt<T, NUM_BITS>
+            where
+                Self: $trait,
+                T: From<$type> + Boundable,
+            {
+                fn from(value: $type) -> Self {
+                    build_assert!(
+                        T::BITS >= NUM_BITS,
+                        "Number of bits requested for representation is larger than backing type."
+                    );
+                    // INVARIANT: the impl constraints guarantee that the source type is smaller
+                    // than `NUM_BITS`, and the `build_assert` above that the backing type can
+                    // contain `NUM_BITS`.
+                    Self(T::from(value))
+                }
+            }
+            )*
+        }
+    }
+
+    impl_from_primitive!(
+        bool => AtLeast1Bit,
+        u8 => AtLeast8Bits,
+        i8 => AtLeast8Bits,
+        u16 => AtLeast16Bits,
+        i16 => AtLeast16Bits,
+        u32 => AtLeast32Bits,
+        i32 => AtLeast32Bits,
+        u64 =>AtLeast64Bits,
+        i64 =>AtLeast64Bits
+    );
+}
+
+/// Implementations for infallibly converting a [`BitInt`] into a primitive type that can contain
+/// it.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::num::BitInt;
+///
+/// // Event though its backing type is `u32`, this `BitInt` only uses 8 bits and thus can safely
+/// // be converted to a `u8`.
+/// assert_eq!(u8::from(BitInt::<u32, 8>::new::<128>()), 128u8);
+///
+/// // The same applies to signed values.
+/// assert_eq!(i8::from(BitInt::<i32, 8>::new::<127>()), 127i8);
+///
+/// // This however is not allowed, as 10 bits won't fit into a `u8` (regardless of the actually
+/// // contained value).
+/// // let _ = u8::from(BitInt::<u32, 10>::new::<10>());
+/// ```
+mod fits_impls {
+    use super::*;
+
+    // Number of bits that can be converted to a `bool`.
+    impl_size_rule!(IntoBool, 1);
+
+    // Number of bits that can be converted to a `u8`.
+    impl_size_rule!(IntoU8, IntoI8, 2 3 4 5 6 7 8);
+    // Anything that fits into `1` bit also fits into `8`.
+    impl<T> IntoU8 for T where T: IntoBool {}
+
+    // Number of bits that can be converted to a `u16`.
+    impl_size_rule!(IntoU16, IntoI16, 9 10 11 12 13 14 15 16);
+    // Anything that fits into `8` bits also fits into `16`.
+    impl<T> IntoU16 for T where T: IntoU8 {}
+    impl<T> IntoI16 for T where T: IntoI8 {}
+
+    // Number of bits that can be converted into a `u32`.
+    impl_size_rule!(IntoU32, IntoI32,
+        17 18 19 20 21 22 23 24
+        25 26 27 28 29 30 31 32
+    );
+    // Anything that fits into `16` bits also fits into `32`.
+    impl<T> IntoU32 for T where T: IntoU16 {}
+    impl<T> IntoI32 for T where T: IntoI16 {}
+
+    // Number of bits that can be converted into a `u64`.
+    impl_size_rule!(IntoU64, IntoI64,
+        33 34 35 36 37 38 39 40
+        41 42 43 44 45 46 47 48
+        49 50 51 52 53 54 55 56
+        57 58 59 60 61 62 63 64
+    );
+    // Anything that fits into `32` bits also fits into `64`.
+    impl<T> IntoU64 for T where T: IntoU32 {}
+    impl<T> IntoI64 for T where T: IntoI32 {}
+
+    /// Generates [`From`] implementations from a [`BitInt`] into a primitive type that is
+    /// guaranteed to contain it.
+    macro_rules! impl_into_primitive {
+        ($($trait:ident => $type:ty),*) => {
+            $(
+            impl<T, const NUM_BITS: u32> From<BitInt<T, NUM_BITS>> for $type
+            where
+                T: Boundable,
+                BitInt<T, NUM_BITS>: $trait
+            {
+                fn from(value: BitInt<T, NUM_BITS>) -> $type {
+                    // SAFETY: the impl constraints ensure that `NUM_BITS` can be converted into
+                    // the destination type, so this conversion cannot fail.
+                    unsafe { value.get().try_into().unwrap_unchecked() }
+                }
+            }
+            )*
+        }
+    }
+
+    impl_into_primitive!(
+        IntoU8 => u8,
+        IntoI8 => i8,
+        IntoU16 => u16,
+        IntoI16 => i16,
+        IntoU32 => u32,
+        IntoI32 => i32,
+        IntoU64 => u64,
+        IntoI64 => i64
+    );
+
+    // Conversion to boolean must be handled separately as it does not have a [`TryFrom`]
+    // implementation from integers.
+    impl<T> From<BitInt<T, 1>> for bool
+    where
+        T: Boundable,
+        BitInt<T, 1>: IntoBool,
+        T: PartialEq + Zeroable,
+    {
+        fn from(value: BitInt<T, 1>) -> Self {
+            value.get() != Zeroable::zeroed()
+        }
+    }
+}

-- 
2.51.0


