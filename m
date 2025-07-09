Return-Path: <linux-kernel+bounces-723031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4FAAFE1FA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4914C3BD8CE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A20F2367B8;
	Wed,  9 Jul 2025 08:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XMWhT1Ll"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37CE27453;
	Wed,  9 Jul 2025 08:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048580; cv=fail; b=VGtglCE/jsIt//V6E7Ze2CM6tv2WQibIUIxJcf8+R+/56RDJy9wTNivBeVkO1qggyXLlVzP2ttPkFxurwllBO/gfJ3VP3GNlNFx7HyaWXkJG9hhTWEEieUH53Fv/wuNtwWlJZPk/+7u26j1tElzVCIb3lq/YquAIKT9fUAaK1yA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048580; c=relaxed/simple;
	bh=o95KPqLTUKVTUiXDFEfxippJW4l7QwQSKAdQlYq2GLU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Uqqyk7DZFIyqbqOe3OJkmDUAMq//mgEzYWdKZzukgwEYEY+3X9OR9ID0GCWYVPhVF/Z0k8JKbLhNrToRbUiqFzO4dLVMDo3BHE/yovNQHzaJrL3TFa8SrENlEYHqERvyOld5wsGDQZdM2xhXy4gXThPkHIGMMqE40fVkeDphxww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XMWhT1Ll; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQQD524VsfLMZ4HVuXEJkJ81y/H+OWFmOCaoOVgHNRriltoewidy4Q7WrjbQYv01BZyO9SVK5La7amKt02nhwdR3qZfX0Xiavb9SWcki9g3bkV/vfvamLEr8k1ILxKSSty4/VfJ0jG5jA35A4Vi0I2nuAzfXYHr3hjLOJCs8ZjDCcwteHWKm5dWbnb+D8TBSNu47FOPxXFp4VMF2aiJQSALQr7D5vOIuCkPPP+/z51Fy9R6SubfGGJ3ioGV66QRHPD3+MsvwTPuG2fbdJ2TzzRB2o2XvIE0gznKqa5r0nK/LUSFk0nUGY9O4Rn/n3K3hvgmC+0Fbx345kqDRFIX8rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZdrFf5K2xmUC9SzSSm0Tcq3qmmbWl2iE6ZKlea86HM=;
 b=LvLABS2bUJENOSzT5tQmYmMF8i8c4m4JIImN1vhXDrvD/5X5smWmFQcdHW7sNJwENaPLA9PqESidmEolqu+jDmKR6fmMCVQEU8Ll0UqM/ocGWRAnT+8eicx782j/CI2YJmif6dD3qFPJdp7b5nwqdK9/LvUrBOyjOYAf7hAbyxSHNrZ/nmM42VSL2r0FpjW0GFpQoDRmxfiFiiNmoC1GWoZsv+B3Pw1y7epBGYDvCoBeyac38kd+egRXL3r/e/pGD6RlkF4QMto5cQRTkhlCKdaFwYFtkRNDAId+G1ba25VrFccgUypHeh4IaryA0G4UbflqaYT7Z4zFEEqm+WW/Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZdrFf5K2xmUC9SzSSm0Tcq3qmmbWl2iE6ZKlea86HM=;
 b=XMWhT1LlRs25zd/bEPo3l3GEVsILQpDJj5UJrMTMOo6u5Ou2d7s+Dy7zspjH+AQ4yp5jRxejzhwu1OvlCT4YIX0H+ACHCjK7QppFyPt80UXptzLctWDZ20zUD5S9X7TOlxv6RumrI09TjeELaZhov8/UjijipHSDsaQ5RWMlMnOVcFzhapbh3pE79oasJkTesRFmtZ825Kpr4Spzuxgjck3P6wkhO5RY0fLj8PQwuVMAN4PJFSdkK3BAFm9JRyJgxhfpQcxeEuuCZIhVR2z/1vOPUbbTw/S+ekAZyBD19+DGY3XLplaD6ZjT9IkjENJ4ZK4abGfsPiTsbxCK9QxTZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW4PR12MB7466.namprd12.prod.outlook.com (2603:10b6:303:212::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 08:09:35 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8901.021; Wed, 9 Jul 2025
 08:09:33 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Jul 2025 17:08:56 +0900
Message-Id: <DB7DDEDNP1HF.T0MDDNPF26P3@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v8] rust: kernel: add support for bits/genmask macros
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Daniel Almeida" <daniel.almeida@collabora.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250708-topic-panthor-rs-genmask-v8-1-fb4256744c9b@collabora.com>
In-Reply-To: <20250708-topic-panthor-rs-genmask-v8-1-fb4256744c9b@collabora.com>
X-ClientProxiedBy: TYCP286CA0061.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW4PR12MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: ca65a0ab-2272-4ff7-a433-08ddbebfefbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVZ2aG50Q1VEKy9SZnJuYXpIYjdYKzVuR3g0c3FpOEU5ZytlVGx2N3FjKzBL?=
 =?utf-8?B?aHE0ZTdpS0Z4ZFF3QVBZQTFvNTBHUmtBMGFHdzVqSU9YY0RLVkN3VWF1Wlpu?=
 =?utf-8?B?Z1NReXdGb1pyVi9VeU9GNktET2ZDMHFlbXUyZklFbk5aMlgrNktvTC9NbDB5?=
 =?utf-8?B?NnZkd0lpVXlyUkhqZFpkeVhneTE0K3V3R3ZENHk3cWV3YWN0Q2sxWFpwMWVj?=
 =?utf-8?B?elNNRUk2Mmlzekx6QmlUN1NsaTZ6enNyWDlnREJLaVlvaWNwNEMvK1hSOXZ6?=
 =?utf-8?B?MXp0UlZtOC9IczA1ZjhsYzc4ZnlqQVNVTWpvZlRUK2hhVWpocFFkSEN5Z0Z2?=
 =?utf-8?B?UUUzRG1aMFhzMXJkZFBtZTlIT1VpNTJyVkNFK3M3ZG05blVvZ2Z1SWJGOURW?=
 =?utf-8?B?RGVzY3o1d1VxakdCRGswekZEWmFrT0czbW93KzRTNmVBYTVJSkUxMUNxSkw4?=
 =?utf-8?B?cDhVUS9FaUp3UDVBclpBTTVwMWxyaHdwOVdyZVBUandLWXN6NVJvNU4wY3Bo?=
 =?utf-8?B?MDUrb0tUWHJVYkJpUU5iZFhvM3AxVlBJd3NFY2FjM1RoRHFrS3p6d3J6N3Vw?=
 =?utf-8?B?dHhCNXVEK29YbnVZMzRqK0k3RGcrT1FveHdLZjJaWW5NeVptaVZCWVN4Ui9E?=
 =?utf-8?B?Ym9pT3kzUTVyUmk3dWhQeUNIa2ZCODR0dEZ5QVh6MDJTOEk4Y1VpeVVjbWJN?=
 =?utf-8?B?LzQ1aW5vR1hYbU8rMkU4eSswT3BxS2p5eDU4U0FJNkFpVW1WSjhxUmR5Tlpk?=
 =?utf-8?B?bmRlTG91VG43b2FEMXlrOTVhRkRobzgvTWFQMGpKb0RodFFVZlZ2cm5vOC96?=
 =?utf-8?B?NjdaSDIxNWZldVN4ZGJVRndkTUNnS1l5bUo0dnNjMitqNXJqR0dFbGRCdWpW?=
 =?utf-8?B?TzduSjZnWTUzNlEzMFRUajNTckFEaFRGbk1ZRGtKOWxmb0l5ZEFsR0I3Tkxh?=
 =?utf-8?B?L3hGenp5UGZzRlRhOGlRdTBGbCtNSVVUOW1mL1dVeUpwWU9sTG1pdnZDYmQr?=
 =?utf-8?B?d3lPanJsSVlWZEttTzVnRCtzb1dJMVZxSzdLTU5OakduV0w4RThIc2RHclZk?=
 =?utf-8?B?RnJsaWlxQi8xdVo0ak0wWDc2dWFDakhFZUhQMUZYTCtzNkR1ekp5eEU1R3FT?=
 =?utf-8?B?RldtMGpwSUhsZFRWOUhWMXdjcFd6OHJaNHFQOXM0RWNES0d3SVFRdXd1MGVM?=
 =?utf-8?B?U3c2SGh2am9VWDh1NXJBTjJCMi8rWXNpTGVtTjRibnh1blV3eTVKSXJrMEg2?=
 =?utf-8?B?VGluTFE3cU9wbmlPNVduY00zanNzNXB6WCttcUdSd3lieU5laXBPVlBxWk1E?=
 =?utf-8?B?ekJPdW5JL05LYkplWkJyUERiRHBYZzcyOW9YaUVKd2VLUGJQODk1WlZrazZP?=
 =?utf-8?B?cXdpWGVkcUl0SlBuN1Q1cnBmSnhEOTkwWUsxRjVocTJldDBTd3UrUTBrM1BW?=
 =?utf-8?B?enE2dHgrRnNSYjl3TmJGWkl2UW5nZTdoTjFGWnJOdkYvLzNWUUdTblhTOXZG?=
 =?utf-8?B?UGtlN2t4V3lNTWkxUjhTTW9mSzQyZ1BzV3IzREN2dFRKSkU2ejFWaXNoOVFl?=
 =?utf-8?B?V1FER0ZkLzVwL0pPcFNsL3FrajJqWXBGcHJINzNpbW5KYnZ0MGh2YXBROUp3?=
 =?utf-8?B?WFNNbkNrTzJ0M3hOcC9UTVVKV2VZNWJncEFsTERaRUNBMUhYYnpJeFdyRGJP?=
 =?utf-8?B?OWRub3pmbVA0RkEvSlhjWlU5d1BIY0ZIWUJUNlVidm56OGpVaHRiL01ubXRG?=
 =?utf-8?B?MUhwTDJhK3dQZGhaZzVWSktQNUdMWWRLd0kxS1M1OW9kQVhEdzBsZkgxMVlD?=
 =?utf-8?B?OWJWRlJoanJaZThBc2NxcVBYOGYyb3djUG9TM2x0cGt5MW9rYmpsemhiTzZQ?=
 =?utf-8?B?dlVtVldkeFBpSFlKVXJDRWJqbzBEMWlVTS9kTTZ5SkRsckUrcTdaL0c1d3M5?=
 =?utf-8?B?R1pLeUQxajhna1Z0b0tJdk1Bczg4ZGNGbjdPUEJUb0cvK2pNS2d4dTR6R1pF?=
 =?utf-8?B?bkgzS21FMmFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjNsSEd5QjZ5My9qSWdJZmpneG5ib3lGTHdqUnhpWlluaTJIbTVZWlduYk4x?=
 =?utf-8?B?d1E5bVQ2WWhqVTBOck56Q1o1Uzc3UGtwZlVKZUF6Z1hUdnpObFUrZFVwb2Vy?=
 =?utf-8?B?OVRPRUYvUXRWVU1MWXUzWDYveXBHcjZiYjIxTTdqbFFxQmh0V3N5U1RCdDla?=
 =?utf-8?B?b0Z4VkNlNm55ZVZNMFQ1MVVJTGQyNnNvYzBTR1pjaVc1ZGpYS05EUllha1F1?=
 =?utf-8?B?N2c5V05Hakora3dBMUF6RTVCSytaMy9ZZTZqRVpjRS9sZ2J2UFIwTlNacU9H?=
 =?utf-8?B?V1RuRVd5TkRkN2hBR2Z3QU5VZU53Z0RFeEJIckpRajR6UEZoMUJLZkJ1K0NF?=
 =?utf-8?B?ZVV1ZkdtSSsvaXJVaGVKUHFvQXRxZjBBeFdJa05mRWNaVlVMeTVPYmhlOW1P?=
 =?utf-8?B?NWluTXNOTHpDbFpveElyZW16STFPSVlCWG52Z0ZyUEpOUCtRNXNiV013SFEr?=
 =?utf-8?B?aHREL2x0bXJFL3VqdjlxMW9GSGc1MUtzNS91N0dPZUtDaXRuei9JdzBBU042?=
 =?utf-8?B?ZnFiU2Yrd2FnanRZQUlvWXBTNDFYZVlkblVmbXFvaEJDQkJ2UjNIalBFUDVy?=
 =?utf-8?B?ZTYzOSt0ZDF4RHV2dTlrVWJLZGJuMFdMZ1NiekQ2RjVjZnljTGRuU1VXMGdr?=
 =?utf-8?B?ZFR3QklIc0VwSEpUUlBKM1BRNVBpOTJjN0NFWHB2QjZ0WnlMVlE2QXBRdFBy?=
 =?utf-8?B?Q0puenFDUVJZelZ4MFEvSXRKYWttUnkxWnlpUDRVMHZncWdVclJkbnlISlY4?=
 =?utf-8?B?V2MyQkd3NEc1WjlCdG9mNmt4TE5weTY3a0I0V243QUJzZHh2QmlXdUtnRmhx?=
 =?utf-8?B?WHNKVnNmZ21SN0ZVOXhYSW91SU9UZ0RKbEl0amxjcGNnQXVVTHhZaE45VHUr?=
 =?utf-8?B?Z3VsOWhteENuQ0FQNXNUZ1A2RjArd0xVMTMyNTYvZHp4NTU0ZlgrQmgva0s4?=
 =?utf-8?B?QlJyZ1oyT2YxRU9GTFFERUczVVJ6STZxaUtqUHRaQVEyeWpmUHdjYmpHaHB5?=
 =?utf-8?B?WU82QS9uQmFmRDNKUHZFT0RMN0w4R2RJMlJSRFI3K3ZNUEs2ei94eEZGaEY2?=
 =?utf-8?B?Tk9OdE9keW5BckFISWNaRlJhRldFeXpXY0lsM1E4Q0VWQVUyQ05WK0l1RUZz?=
 =?utf-8?B?c3RXZE95S1hYL014a29uWGNxWE1OdlNhZ3dnRG8xalIyc0w4dzR0NWhFQmtB?=
 =?utf-8?B?QURRQWhEbHFkZUd6ZXlLcjkreEZnK3hQaFNjcFVtWDlyRmozdWthaFRUZzdW?=
 =?utf-8?B?c2t2cUpiWnZvQk5qSm1MbjhxelhWZnFMZjAwNmxZUWc2ZktBM1FhdmljYmVs?=
 =?utf-8?B?MnQxd29oWldVRDM5UllQRCtETm1DQnAwTlZTeHFSdStFb1REY05Sdm1FNmcx?=
 =?utf-8?B?bmQ0TENyOVV6cDNUem5TQXdUdWpYZ1c5VnQ2djhMOUM0Q3FycldQZWxFelhQ?=
 =?utf-8?B?T01scHlQK3d6UGp4enFkNDZQZTFFZEptbC9JWFA1NHk5aU9VN0wyT3RPa3p3?=
 =?utf-8?B?R1F1ZGNhM2lzbHUvVUUzbEJwS3NaZ2dwWkFjZkRjVDdjZ2FMK3pwRW5RT1R3?=
 =?utf-8?B?d2x2VjV3OHZYeXFMZnRRRnJFVUErNVlEVzYxVnE2b0J2UDVpMG0zenVMUDAx?=
 =?utf-8?B?Q3pzUEczdEN6eFdrV05sT3JtM0RIMHZYWmxiQkFaV0drYlFGNDFyV1BCRGxw?=
 =?utf-8?B?UlFwTkJqUzRRSVMxbmVIWkw2M1FNWmJUV010YlJ5ZjY5RkJGZm1ESjd3di9o?=
 =?utf-8?B?WUp5eWFOVjRRdnQ5Y0ZkK3NGU3doTFdMdCszUHdkRXlicWRxSmxiWnpFclJV?=
 =?utf-8?B?dTdRSWgyN3JIS1dPd0NXKzlKSHVUTCtlcmx1NEMxQWZTV1BVbW1HT3Z1RGlw?=
 =?utf-8?B?bzJVdkZHTVhYVVdJek9wNjMwam5CTTdlUGQrVExBeStncWxQalZ3djhtMXdP?=
 =?utf-8?B?STNvaW5pTm10RXAvR2dVU09lMXp5VTFwWlZXaXdnNTNBMWo0cksxQmhuMEJY?=
 =?utf-8?B?M3hGU2l6eC9UV0JqZjR4am9Zd2pBTlNJSFZWYXJ5dktpUjMzOVlrSElyNS9q?=
 =?utf-8?B?UnFva09lUzdnS3kzRE40QjlseFFqTzBUaGRXQWVQUUNvVjFIK0J5SnNFVk9N?=
 =?utf-8?B?aGdIRWZ5MWx2K0FnOHFOOGhWcmJycU94aTNtbnNZQXdmbVJlVzJzQ0pXQm5Y?=
 =?utf-8?Q?IU4+vw/pWwI6mDocTVS/x2wscRTj0tMyQTokUxEysJhZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca65a0ab-2272-4ff7-a433-08ddbebfefbb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 08:09:32.9448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHNvC87mLMmQ+LzipKoqjSzgCwYOqK5EzNb7KMY8MledqolPXLSgtcV67QVFBIaJd9wYXRzqfJA7o0tcroH+gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7466

On Wed Jul 9, 2025 at 1:50 AM JST, Daniel Almeida wrote:
<snip>
> +macro_rules! impl_genmask_fn {
> +    (
> +        $ty:ty,
> +        $(#[$genmask_checked_ex:meta])*,
> +        $(#[$genmask_ex:meta])*
> +    ) =3D> {
> +        paste! {
> +            /// Creates a contiguous bitmask for the given range by vali=
dating
> +            /// the range at runtime.
> +            ///
> +            /// Returns [`None`] if the range is invalid, i.e.: if the s=
tart is
> +            /// greater than or equal to the end or if the range is outs=
ide of

Should be: "if the start is greater than the end", as the two being
equal is valid.

> +            /// the representable range for the type.
> +            $(#[$genmask_checked_ex])*
> +            #[inline]
> +            pub fn [<genmask_checked_ $ty>](range: RangeInclusive<u32>) =
-> Option<$ty> {
> +                let start =3D *range.start();
> +                let end =3D *range.end();
> +
> +                if start > end {
> +                    return None;
> +                }
> +
> +                let high =3D [<checked_bit_ $ty>](end)?;
> +                let low =3D [<checked_bit_ $ty>](start)?;
> +                Some((high | (high - 1)) & !(low - 1))
> +            }
> +
> +            /// Creates a compile-time contiguous bitmask for the given =
range by
> +            /// performing a compile-time assertion that the range is va=
lid.
> +            ///
> +            /// This version is the default and should be used if the ra=
nge is known
> +            /// at compile time.
> +            $(#[$genmask_ex])*
> +            #[inline]
> +            pub const fn [<genmask_ $ty>](range: RangeInclusive<u32>) ->=
 $ty {
> +                let start =3D *range.start();
> +                let end =3D *range.end();
> +
> +                build_assert!(start <=3D end);
> +
> +                let high =3D [<bit_ $ty>](end);
> +                let low =3D [<bit_ $ty>](start);
> +                (high | (high - 1)) & !(low - 1)
> +            }
> +        }
> +    };
> +}
> +
> +impl_genmask_fn!(
> +    u64,
> +    /// # Examples
> +    ///
> +    /// The example below highlights the default use case, i.e., when th=
e range
> +    /// is being built from non-constant values, which are represented h=
ere as
> +    /// the function arguments `a` and `b`.
> +    ///
> +    /// ```
> +    /// fn build_mask(a: u32, b: u32) -> Option<u64> {
> +    ///     # use kernel::bits::genmask_checked_u64;
> +    ///     // Ensures that a valid mask can be constructed for the rang=
e
> +    ///     // `a..=3Db` by performing runtime checks.
> +    ///     genmask_checked_u64(a..=3Db)
> +    /// }
> +    /// ```

This example just wraps `genmask_checked` into another function and
doesn't test it at all. I think it would be more useful if it mirrored
the non-checked equivalent, and also showed cases where `None` is
returned:

    # use kernel::bits::genmask_u64;
    assert_eq!(genmask_checked_u64(21..=3D39), Some(0x0000_00ff_ffe0_0000))=
;

    // `80` is out of the supported bit range.
    assert_eq!(genmask_checked_u64(21..=3D80), None);
   =20
    // Invalid range where the start is bigger than the end.
    assert_eq!(genmask_checked_u64(15..=3D8), None);

Sure, here one should just use `genmask_u64`, but the function's
description already says that - here we just want to show how it works,
and test that it behaves as expected.

> +    ///
> +    /// This example tests an edge case where only the first bit is
> +    /// supposed to be set.

I don't think these comments are necessary as the examples are rather
obvious. You can put all these examples into the same code block,
separated by a blank line, without the `mask` temporary variable. Just
add an inline comment if some explanation is required for some of them.

With these last things:

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

