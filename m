Return-Path: <linux-kernel+bounces-760902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE94B1F1D8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 03:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DCA3585763
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 01:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD9F276050;
	Sat,  9 Aug 2025 01:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VBvb7fTH"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12210264A60;
	Sat,  9 Aug 2025 01:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754702889; cv=fail; b=ZDJslTWJJ/x4BU76cQ2hIJZ7tZQkg/4UiBVC4z6ixb4N1jsVFQcdMgLhJlf+UR+xCfupAQ96xU8p5Ncy7Pn0jK5rRINDch7KnIiRQrzL1ExqRI//TDTT2+MKFP2wfDAeVAfRn6LfW8UyPZDfFFOcFW/NVnkjWBedhZF/DgiDinQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754702889; c=relaxed/simple;
	bh=SoGa28xF9OXb1NRt704qFwZ9FnAOsh7Z5jgcoZ/xCZE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=V3bv9bRZ0ezcogygkH7ARXgeURmfIKxGUlBMwCh0orA04JemjRY5DOOaqzxHESrnfmdHRtleEmrFdthpROSIgssdqa5/3TaMVSxMMqM4eP73IjtHseiA3tqmPYokOrVV08B0FC21kXK8gq8p+RhIMgByEbaxfBBSyZaLEL46ljI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VBvb7fTH; arc=fail smtp.client-ip=40.107.95.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGYIIhrnHSkTboEoMwwRN+dVR2s4yQS6DliwCY+h+oEd19dU63WM7+AjZ1RlOMnmP0g1ZdcAto4jZFL3aeJd6O8eMI/Vr5oAYhBzLaZTolyo/UbTFMzQ4vtTG0XisOiUoT5DyBqJFA4wGUwwNQEEC87IhjV2vR+kpfFMHJrbBARQO8akvdoenBmBkKlnjpqBVfImp8zBUUlXFiXYWlnS3wEbWPEW8Vz6QSpjChwTjUvNDU7I7GSpIMwRHxdXp3q8AX4gKZd67AHD+hxnrJPQFtiaNW9XxZM8Ys8F+Y3+KImu/3mWcZ3QeozspE2Rt4puW3Yh8vbrjSbgcyUk4jJnWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofyyo0K8CI35rv3mJSb9ueOgBsEcfgHWgbJqnUjjlaM=;
 b=MAnvHzvFvxpIQYBWYJhnh5Zb+IylUgQ58gopCoKNxFVrLSmdFx3vsUXuYG7w+dinC9uqC8SgtQixkmZ7bIRN37xAD8gkhqpG7o3CRyuy5Gc+73OrUoA2kl5sEoPsw5PtgnJ6Rs9PIvhRffY7JujuYNRjfUvE4/kl1hn9qhzrRTCz3sNizwAnICwuZ5UGFGbQ5fPAz6nM/KeXg+7Jo1pP5F8I8FHlqpMRMDGqYf2qHlkDbiQToSxkPfm4q0H3b4sbArPr07tLoi505SQKVt7uBCIPTdAxS32OYUkNPR38uwpBNWcKgdwYkZeijDxb0qfETmJhc4utDubpwN85JFO94A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofyyo0K8CI35rv3mJSb9ueOgBsEcfgHWgbJqnUjjlaM=;
 b=VBvb7fTHfh0pHXmCcwek8Ggl27vcUF9mgk5jviSI0OzijfRjSLoN3JDKQMX39Am5eg1osFKKAOTvijFRxQ0l3uUqgOCp8S7qZo2BHWi7sEfE2jIvxlBJ7/tFj90HxGMIN77z1xlShqBSXq/8nV7lMdOF15ufad37G+xGWRZNVcdTdnXaMEY0OJbopxa21uUkMuIdBY6dZdlrhbWt3dWdOewO2nRgS0fFMpImXqL0jtkWBYlQO8Yp6avFxrR3DCMfu3uDEKkoWqpqiInONNWW0a/lfLWTHD42BiJ79so7IS58JOwk0X7LnvfRZp4b51AQCGosvdERFd9CeVWjkfl33A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB8143.namprd12.prod.outlook.com (2603:10b6:806:333::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Sat, 9 Aug
 2025 01:28:02 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9009.013; Sat, 9 Aug 2025
 01:28:01 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sat, 09 Aug 2025 10:27:51 +0900
Message-Id: <DBXI970JGY3S.35LGOC2FO3EOE@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, "Fiona Behrens" <me@kloenk.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/5] rust: implement `kernel::sync::Refcount`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Will Deacon" <will@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Tamir Duberstein"
 <tamird@gmail.com>, "Ingo Molnar" <mingo@kernel.org>, "Mitchell Levy"
 <levymitchell0@gmail.com>, "Lyude Paul" <lyude@redhat.com>, "Wedson Almeida
 Filho" <wedsonaf@gmail.com>, "Viresh Kumar" <viresh.kumar@linaro.org>
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250723233312.3304339-1-gary@kernel.org>
 <20250723233312.3304339-2-gary@kernel.org>
In-Reply-To: <20250723233312.3304339-2-gary@kernel.org>
X-ClientProxiedBy: TYAPR03CA0008.apcprd03.prod.outlook.com
 (2603:1096:404:14::20) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB8143:EE_
X-MS-Office365-Filtering-Correlation-Id: 83eceee3-c1b2-4479-2bb3-08ddd6e3fab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnJGaG52QWc5OW9Cd2tVNFhzamNTdTQ5VllxNlkydFl6YmY3dE5EcUNjZlho?=
 =?utf-8?B?RUo0Z3NNbjhpV2h6cHpLRWJBK0ZXM3N3VFJRNW9Nalp0MGYxQkRmbU5xcFM4?=
 =?utf-8?B?UkNzYW9MN3QyTXhoYVZLamI1QkROeWdKc1hwaHlXUjVVeG5DVE5UOXhMZU1i?=
 =?utf-8?B?NDJwVU5OSXhXVVZPYUo5bHo0aGxGYnFXL2NPalZsQVNXMEwwdUExUnNHelNI?=
 =?utf-8?B?K3JWajlYMjBnczBqU0hoek05WWRRVG5xUGFyQ0c5VDNLUkVlTUhLd00wS0ZW?=
 =?utf-8?B?eUFaMmxiMGMzbG5NWU0rOW9PVCt6RDVuTWc5MEgvUnp1alBHTkoza2t2eXdk?=
 =?utf-8?B?d2FOcFJHMmpiVU4vdU1NQ2tEVWxBb1ZUMkVhaHpGVGhNQUI3ME92MEQ0d3NZ?=
 =?utf-8?B?RXN5REhQSWdGVmxmdmIxdHFzNUJ1SGxIUEtBbnA1ckM4NUhydDdLTXJwbVhh?=
 =?utf-8?B?aTlTMS9PenhydkNQbE9RUzZwOUVIU0NwMlhsV2V4bXJzSUVOUzFqNkpqa0k5?=
 =?utf-8?B?S0FYKzRVN2tJZktLZk9FUE5wWU03K0lSRmI4RWJ3M01qNkR0dFF3UDRKWjV6?=
 =?utf-8?B?YUpxYjRQNTljMnRlRVdWVC9jWXN5UlFMalhPMFk1RnZtUHFoQXVKbE4vSlc5?=
 =?utf-8?B?UXJSRVlrUnp3MWVNUGdneFNaTkZjWGZubFlNbjZ1bzZ2ZTVUNEp5MFh6TWZW?=
 =?utf-8?B?eWFOTzNEajRlcFRqdXVVYnkvOHE5ZC9UYnVTOWNYaUhoc0lic1BxaDZTMmsw?=
 =?utf-8?B?WjdlR2hPeXRBU1JXdC81U2huMGRvUjYrVHhNR2x3QnRkZFNXa2htYzBGRkV1?=
 =?utf-8?B?c2wyY3JKYnhiZGl3dHNjRmhtNGRBTEZ1TC9zZ0RCWTlIcHBoS1h3dWVkMFRK?=
 =?utf-8?B?NWt4aEIyeTQwNVUyNzdKUGdmK25JNWxXbmRqRUpWN3FYRXYwTlpURS9iSThv?=
 =?utf-8?B?MncyOGZkSnJ1Q0EyeitIVTJZRHB3QkJHQmgzbnBDTXhQOEVBbUcvaVlBcjlt?=
 =?utf-8?B?ZEV2UVBDRDdhR0tnUEN5NWNVYkRZRWNYYlRhZ1A0Tng0MXc4ZWxabXFyNTVY?=
 =?utf-8?B?TG80M25MbVVobEIvQkpMc2FDTXRFc2RQL2ZTaDh1Y2tBVE81VndSc2kxN25R?=
 =?utf-8?B?cmVCeHZONFJURE0rU2NZR09wcWNoOWQwelVZc2FMNHNYT1VudFZYUjY1K1Vn?=
 =?utf-8?B?RHlad00vcmJHU0dta01iQWU0cUxZd21rUG9zUjRRdVljM1ZqczA3WVVnNVhr?=
 =?utf-8?B?ODlYS01GTlpHdm9HS1l3TjNSalpTaVorUTlKSmVBV2NQRzZOcmpYdmNuZFYx?=
 =?utf-8?B?eWJtZ2RwNk4rbldMUEo2MkVIOGRrUGZ1RFkwMVNxOUd0L1lpaHFjMlNzWktB?=
 =?utf-8?B?WjlnYjN2TmpHOFhIOFk3ZVA0cnhJVU41U1FmMFVuWTMwd3Q2UGhpWnovYVYz?=
 =?utf-8?B?c2hPRXhhbWg4cFNncFNEblZGWnRGbnVaZFcrOXE0Yjc0Z2NoRSswT3cxZGVI?=
 =?utf-8?B?MThuNDlERmE1c3ArZStCSGh5MnR3L3BRaitNYjVTNUxVcGtxVFY3ejRqci9O?=
 =?utf-8?B?bUdwRWF5bHo1bFdFWVdqeDVETjNxTEpEMFVleHdlSCtWSk9iTm1OUXpHRXAz?=
 =?utf-8?B?UzRSODRpcGFyN20rS1Q3UFM3OGxLa2UyZzI4dFcwMURQYk1uaW9MYThxSmhB?=
 =?utf-8?B?azRiRW1BVHBuM1NtdG9MVU1WOU45K0FhZkVUT1F0Q1FXVjJmTXk5cEF5OGxi?=
 =?utf-8?B?M0F5WlJyMWwvUjJJQUxMa1l5MUJGSzdEbUJUejNmL3czMXlmQm5kY2ZUSFRY?=
 =?utf-8?B?c01mTzlBekpBUnB0a3JPMW8zRWlCYWJkd3ZmaFlUUEkwNWNlSmh0T1c0Zk12?=
 =?utf-8?B?UjNiV3E5Ni9DbzVRYituQ0J3dFpjRkxMLzZxcnVac2JBekMvYXRzQmd4cGNs?=
 =?utf-8?B?Y1ZqUDhWYWRZSTZGejBEY2JLK3ROTnVsNFY0NTd1Z0ZtOHlGSlRwWGE0VTQv?=
 =?utf-8?B?VytJanVYOHpnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHJHYzJQaC9IMVZsT2ZrWGFxY1dwdFRVamdYczVtblpPZEoyUXhoOXc0cE1Q?=
 =?utf-8?B?a1F6VjJKZElMZ3pUbVNlbm16YVRoaGFjTklkcWxBS2dxZnJjUWljN0hmUE52?=
 =?utf-8?B?djhIQnMvVC9EU0NGcTlBUi9uM2dlS2lEL1hYMzVRYnhXWFZnZ2hSMTM0VURr?=
 =?utf-8?B?VWJuS0M1bHExc2tOVjFHMVBHNVRsWGxMdFNDMWVBTnFNWTRQRHdpd3ZBcFRL?=
 =?utf-8?B?YXVvV1llVThYSmt4YzZnekhENHRwOEFDbWVtTHhrUTdrTlgvQUs0dGdSWGZJ?=
 =?utf-8?B?TGVRRGg3Y3hmMFprRFd3WjRxaFlHalA5dzkxa3NzOVh2cDRHWkJpVVEwTTZF?=
 =?utf-8?B?djFsVlRtZ29VWGxnd1ZqUXRqUG9KcVZxaUJYR0VzK0JyYVlKZ041WUIyNEJk?=
 =?utf-8?B?Qmc1YXN0MXducERTSHRPYWZJUG0zNUo3S0k5QnJ4bDhEWDNIQTZpc3FabzlG?=
 =?utf-8?B?aW1PVWlJUUJPeFROZTkyWWduUUw2U2wyTU9HWWlEYjBVaktESFBiZm9FZWdU?=
 =?utf-8?B?d3dvWXFXc29ueUtsaCtSN1JxUnk2aW5xTUF2MGhQMlB1Z0tkR3Y1aE5BU1Vp?=
 =?utf-8?B?M0lYU2V0L2haMTRnRG93a2x4a0puV3ZFbTlQUjdOZHh1Q3JDMVMxeWlSS2dm?=
 =?utf-8?B?RC9qQlBCcERha3U4eE1qaXRIWHVHRS9oNmljY1p5MFM4LzMyaTdQREFMRWJB?=
 =?utf-8?B?dUNnUjIxYlVFZ1lNYm9BRjZBUnh4STkrdk8zbDRKd1NlUmNqR1RqQmVPRCto?=
 =?utf-8?B?Y2xJUUwyR21VeXR3aDkzOG1KT2pVek42NDh2NGYyWFd5THR1aTVFQXdTT2p3?=
 =?utf-8?B?cTB4RXhjd2lUejcwWHRlUW9QaS81SlFraW12Tlg1MnU2ZFkzQW00MHRYVDVJ?=
 =?utf-8?B?TGtKLy9BR1ZrS0w5SzhuMGdrTlAzNmo1ZU9XdTFTemt2WTllQlBvdm9aZklJ?=
 =?utf-8?B?L3lwazNQT01ENGUwSFBNNTRTYlZPUzhERVEwbUlWRXRkbXRpbVF0VEpLZDZU?=
 =?utf-8?B?ZzdNVlk1RlRoT3RHWERScmQ2cHY0bTRyZmNoVUVhZGFGRGhJUWFzSnl3SXRx?=
 =?utf-8?B?eVdTeWtRRiswM056QktXWDgvVHlkZzBVQklOa1I4bzJ6RndVVVBVNGRIMWs4?=
 =?utf-8?B?cGNhQncvRjJURXlqbWhhcGo0Q0FDOE0xM3kvcmx6VmJZcUhZY3N3Z05hUnoy?=
 =?utf-8?B?Qld5ZTIyRFJ1NFMrVkJ3R1ZFSjdpaUlDZ1F6OWxvQnhwVHd4ZVU0MTI1M0hF?=
 =?utf-8?B?NGl6UmZQZXZVWEZMZFJGVjdHa2tiWTdWNEdrSE4yMkgweEo5U0VJWS82RmJu?=
 =?utf-8?B?d2ZBSHN6WGVWWnBZUGkyNU5NWjVZdlJFUEE4S0FPa2VFWHY1UUpodm9uNFNq?=
 =?utf-8?B?djlxUWprMGNPTzhGRk9CRk1GdDk4VjdkSnNBNDRoR0FPdUNnNkRxZFFwdjBJ?=
 =?utf-8?B?WDRWdTFXUDJhRWIwY3oxcEU0TDZ5Y3p0OHhOQm1aektzOEZ6MmlMaTR1d2cy?=
 =?utf-8?B?eUwyMGRnUU9tVloxR2kvTVJwRlFWZDdoMUlBOGdtVkx2bHBWZkExL2YyZGwx?=
 =?utf-8?B?aGoxSTVZY1FyVEtFaVFqMHJBYjVZL1RCZDJkTzdtQStvTWhLRHFYZEt0Y1g2?=
 =?utf-8?B?bFZwaXJBcVlhWmRjUDI0Nk9jNlVqVkRUb2hLa2hjR2MrbE1NM3Y5TkYxYjBs?=
 =?utf-8?B?Z3g3amhMT3BMc2pCdXYvMThVSC9VclFGWWVLOGNCaGNXT1JkM2phMVdmdjFu?=
 =?utf-8?B?K1cvNE1vclQxNUZEcGZRS3hNWS9LVGw4NFU1RFdlR3RMaGJZV0VLT1gvMEFl?=
 =?utf-8?B?MnA4SmFMbTFRSUI1bXpSRDcrcEtxZGxRajQwQUMwWm5ubHRPS016ZlNlR1Nv?=
 =?utf-8?B?OStSNUNtdDdWcmk0QmMyd2FsUElVMldDSk1lcUoza3BCSmgzajl0cXNIY1B1?=
 =?utf-8?B?M3BtMVdXU3JicjBFT3I4NWE5N1ppSlBqWG45dGNkTXJHK3htK292OEdxYmtD?=
 =?utf-8?B?Rzhrb25VV0U3Z0JmZmJIVVJPOU1ta1k0ai9CWkNqQzVmdVltb2lTamlKRGFQ?=
 =?utf-8?B?cVArU0x0S2Rmd2hHZ2YzL2FmcTZkVlcxcmdWZG9FQU9QNjh6TG5EZzZvTjVL?=
 =?utf-8?B?QzNSNXJBcWgralJDNTdDbGF6WmJDSldFL3haUng1Y2dGbmJ5TUpqYVlCWmhE?=
 =?utf-8?Q?cMpYjJ+aJht+Svm4ZJ+B4PxzyvyaO5l9aADtlyg5Q5nB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83eceee3-c1b2-4479-2bb3-08ddd6e3fab4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 01:28:01.1038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: io0LvX8LIU+KFrJVZCznTStLc8UEk7dHDInEiBqT+yNrDkl+kJP4WG0VMq07jWQ2WNbNn/Ia/2jBumthkwf2hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8143

Hi Gary,

On Thu Jul 24, 2025 at 8:32 AM JST, Gary Guo wrote:
<snip>
> +pub struct Refcount(Opaque<bindings::refcount_t>);
> +
> +impl Refcount {
> +    /// Construct a new [`Refcount`] from an initial value.
> +    ///
> +    /// The initial value should be non-saturated.
> +    #[inline]
> +    pub fn new(value: i32) -> Self {
> +        build_assert!(value >=3D 0, "initial value saturated");

Given that `inc` will WARN if the refcount is `0`, do we want to accept
`0` here?

