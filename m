Return-Path: <linux-kernel+bounces-781988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE61B31992
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1FC1D2169C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548782FD7C9;
	Fri, 22 Aug 2025 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dE0U/0T+"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B515119AD90;
	Fri, 22 Aug 2025 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869480; cv=fail; b=UdViKUj15Mg+I+HfLDnzC8MNs/wSnR4imzpD+9hsrcqjeX8t6CgP0tr6+oWI0m1cvDRGB2+dleXjsonQBc0gwFTuBUaPTGqz/6vkpMQhpwz/VLjHiCtuXw44my/PEljX2AshO2fdEThb1/kbEcyj2Cr5hZaKPa/1RI/Q8vLaKGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869480; c=relaxed/simple;
	bh=M75aoKJMckEA5T91MePMvXpF8qKsDBOX8XGinGhzl6g=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=bMbrz8dKY6wab8daNU7DaIMo1x64ANsPU6L0Bv8zxC01up6TTuFIgRTJE0T9l9Fj3Stq4B3GQm0qVD+ts3vB50E5hd3N5gwRO6BXK8hsCNZFZq2eRQ4KGaYdySfkOQX7UgLyQNjvLBOn6Xj+R4P4gqMDvOsOfhORbA5oznt0ILk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dE0U/0T+; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3TegLzjNmXi53nHaactJyYQdLUdMZCBsIhjQIL9PajsfRBlfUfAd4WolVC/6XnrgIwbsLCF5N6uSoi8LlfR7YUgftPIoxhppf+T/hVRWGbeaMONsdOjG7wRCmsqBUksVuZ4Szzwywoa1mSoESuWAUPomdUJjXg7b4yxYbuMAb6EloyN7/mQoJb07K23MSsK1VYOYu4CluYrUO/yrYW/xTg0d72XfASksbajVXtRkXP6PQvW6ZBzlfOb65zefP5lKM51+hjFm36C9u7jCbihmsMLJ6oqoviuX19bYZ9Jt7D/oTcdlzY/H5drFUDrjgBKmp7vianLPYKXt0a1PTOR2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsXVHVaS2IYJbqjfkarH3Wge3T9QZ/XRBMhu01biN9U=;
 b=MpnrLfagLYwzrqkIZafc/gk1BkgreyA+g+lSI6vLUgUMCAtDJ3J/cEUluKW+eT9osuvr9L/ooEoWKcypeFGyM4iQrvf7qt3VlvcT4c0NqMnPoW9evuj194EidoyLtBaNMfukYNeR8Z/YyKT7N91NR2oXZ+BmKvzDazf/+c+Pe3BKSf+LB43ZXVHR6Zzm4I+LQoKNV9ve0fkWL3IBmT2olCrmVzNSPyuD7sP2sxTUdXREAgKLCck8yQVjD1cVpWZimjkpH8V+TW3bq2AsoTQ05Wcl/wq8pb8ws4qtHPyRryPaK+aJVV/tRqgmemtry4LhYszGpYN9fjUagC7D40RkQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsXVHVaS2IYJbqjfkarH3Wge3T9QZ/XRBMhu01biN9U=;
 b=dE0U/0T+elevB06XiiBVdp1AgAINZ1Z1jjJGca6mmI3yeJmHsFeQ9GUbGDo4OM1RIw4HZyaMzPWQ7fEQScHgsFr+WZfC6ymHc5Aa1TVoKGJ2wb8vtyJCWYwl0U9UTWU+VVBekmCzdlpjb6146M+soVDdxJyFwBIM5LRscZ9xEG6Di6Sbur7TuM3p3hzc/5EsD153EOIc0XWn7pOwjjUnEPvYYi77YshO9gsoeeCLiNaJ7fRAQYlUfSDzVb0q2R7FI9PRC1ydX1dWHuNpQDziz9zY4yf2qhWpT+7HWpbjVJ4V4m90zoElyUiYu4z60YRMoqphkI4ZaoSCPPpxeqHqjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA0PR12MB7721.namprd12.prod.outlook.com (2603:10b6:208:433::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 22 Aug
 2025 13:31:15 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 13:31:15 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 Aug 2025 22:31:12 +0900
Message-Id: <DC8ZS3RPS2W2.1D6MXZ28MP73K@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] Rust infrastructure for sg_table and scatterlist
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <akpm@linux-foundation.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <abdiel.janulgue@gmail.com>, <jgg@ziepe.ca>, <lyude@redhat.com>,
 <robin.murphy@arm.com>, <daniel.almeida@collabora.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250820165431.170195-1-dakr@kernel.org>
In-Reply-To: <20250820165431.170195-1-dakr@kernel.org>
X-ClientProxiedBy: TY2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:404:42::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA0PR12MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: db57d6ad-f19b-4fdd-f944-08dde1802aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmZ0QmROYmxYRS9nSnZhalNHUWN0NWFVUmRVOXgyeldGcDJlbVhqbDM5RTdT?=
 =?utf-8?B?dHRJRjBVeHJ4bnRPbHNRazZiSWt2ekljNEg0a2ZBVStuS0JrSkFCY1BzeDV2?=
 =?utf-8?B?WTZ4N1N3WE4zR2NmR3g0enZ1NkxTWkJ3TXRJdkRIQlpVNmVuTXZVQjhsQkhS?=
 =?utf-8?B?eld2bGRzU1ZFQzFvVHZyY0tRMnNadWJlY0J3MG1Pa280L2ltRzY4RHcyRGt1?=
 =?utf-8?B?MFdCeGtYRmJyZTBYNnlXUW5lbEhjbVhqVU8wKzJBd1czOXpZUk9qWlp4dzhv?=
 =?utf-8?B?YStsZUdWMnp1NTNlb1RBQVc1NmNGNysyUVArV3FyLy9RNm92OVU0VlpSVU8z?=
 =?utf-8?B?c3JKaWJsTUpFa1Q2RFVYcTI1RlBWcjhPYWd5NUxLbmhPRDZmWS91NGdhdVh1?=
 =?utf-8?B?bFpoTjFzU2hIcnRIWWRiNisvcGRtZXQ2b295L3B6dVErM3F6dWZCNDF5dkh5?=
 =?utf-8?B?aXJYaG1oSFRlUG9WekNMQXp6SUduZjY5ZkNIOHR5QmpDRUJIbElMKzBnSEZ5?=
 =?utf-8?B?c3hBaS9CV2pCN2R2bmJQR1pzd2xYZlpWOElMNGdqd0JXYzhrRWZuRk9hUW5u?=
 =?utf-8?B?MWtXeUg5eWJZUXhROWgwbFV0eTVkYXZhM3V5TkgyWmZObUdaWE1ZN0RpQlph?=
 =?utf-8?B?WStuNCtmazhTbTJVbnZqb2paTWZYd2s4Vlp5bm9JbjNxclVVV2RCVXVOeUtR?=
 =?utf-8?B?V09Kd0hPNlkyM1h1SjlMS2xNME9samZCdUxIRmNDYXdKTnUwbTZuSGlYUGl2?=
 =?utf-8?B?djNIeVJUQ1BIaWN6QkdvV3VtOHRqQWozMFMzc2R6MnBERGFNREx1U1U1Z3Bw?=
 =?utf-8?B?YlpRZVhaZXo5TTZVdmgxazhBa2tqR3FuRjBaR3YvY2Z2ZHNYTjZDMFp0d1Z6?=
 =?utf-8?B?eFo4MWdqQ0FJdFFhSFp0VzkvQk5TSXBNejBpS1laV25kS2FScEMwWHkrZmpw?=
 =?utf-8?B?OXlQOThINlJZVjNTa2ZXQkFGN3BHcldicWRwVytDaFB3eFhha0xjNjZvdFJo?=
 =?utf-8?B?QU84d1VacVd1SFJscG1UVVFXNjBJbDlLeFhSUE9veTVPYmVyMzNXMS9DaFg3?=
 =?utf-8?B?YjV0K0E0UzRGcXV4VW5ORTdwUXdBZTdrYW9yUXovLzhtNCttV20zL3pUckQ4?=
 =?utf-8?B?UUFjSlQycWFVVmhWVnBPbDRKTm8vRkFBVG1Fc3NOdjcxSnRucFRDVjNLOWRi?=
 =?utf-8?B?bU9hYkJHNkNOVEcxY3RRZTUxOWo1Qi90YVAwTVlFN3U5Qk1VVlhndWpnL3dz?=
 =?utf-8?B?Wm5BcDk2eEtvZzlGMTQveFFLRHYyWU84S2Uzait3enhsUHA5M1FuYWo4cit2?=
 =?utf-8?B?OTVSMjVybDk4NkNlOWVPVWhDd2VTUFZpclppNHByUmRZL09IKzYxZU5MbHNu?=
 =?utf-8?B?cVcwUElRQm9QQUZIT1FiSUd1clBNWjJIMzhRS2F5dStmcXNlNmxCZktib291?=
 =?utf-8?B?UHQrbzU4L1d2NzNqR2s4WnJ6d0YzWUkyR3FNUW5FY3M4TUkySFlyNkd2bWFK?=
 =?utf-8?B?dWVrcVJNWVdrbWczZ1ZCL0RPNlJjQmRoM3RWZHJVOVNjZ0doUFRBZCtCWlFx?=
 =?utf-8?B?NVd4cEFMdUhlREMxYWdKeDgyWGEzZ0FTdGJraFRZWHA5UW9ZNEltU1AvbDJM?=
 =?utf-8?B?aHRzMHZQYW1JZWx1WjJERG1TSGtMOU0xTHZIVGxRTEZ6Rlo3d2h6UDI1a2lu?=
 =?utf-8?B?QVBuTU83YW9FZ0lrSUZoeExsUEVoOW1uU01ueGF3VFQ4WWdiZWg0eWpaWUEr?=
 =?utf-8?B?R3UrcSs3ZG90aXdyMXhFSzBnOW1UaDJoalhOSlEwc1E1UldjSEtvNGdiSG9u?=
 =?utf-8?B?RnVWb3dVYjdUTDZsZG5VaFZISVBGcEwwZkt5YzBCR1R3NzFSS0twWG40eFU0?=
 =?utf-8?B?M0swdDVVazEwVzFNRWlpSS96ZXlUYVlrcG1wd1lrbGFGQnpoeW9kQ2NKK09y?=
 =?utf-8?B?cVpkMVlYelpQMW1Neitaa2poM1ZCbXl4MHN4eGIyRzArY3FueUVKTWJZYXpo?=
 =?utf-8?Q?/ZDnLPcNYIkZyHfQEkyHj8KBjWHtn8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ylk0dm5kZmx6Z2t5eXpOTmI3Mm1JRG05VmlTZFNXY2kwV1Jjb1Z3WE81d1gr?=
 =?utf-8?B?U1BuR3JXWDdpbU9LK3UwTG5PT3BDLy92amxzMnRwVWdHYTYxMnFDWmxlaWpz?=
 =?utf-8?B?ajdzOFNzVHBxSTNMSHRPNWdqSFJyeTVzUWdnMTd1eTFYWklpL1FaaTRZZnlz?=
 =?utf-8?B?QmdqdTJyaVAxeUtYZ0ZheE1FQmVLVlc5TEFpdkxWV2t1SFZQeHJrQ0wybm5H?=
 =?utf-8?B?TnBRT21mUVNISmcwcVF2cXBTUFFLZmxoMytIblYrOFRmZU9xM09tS1QzRjFY?=
 =?utf-8?B?ZW5CMFphbktkWmhWbjMwcHExV21aT29ZTFQ1RlR5RHlSVm5rRjNuZkc5cGwz?=
 =?utf-8?B?cWZYRWYyLzltWHJCSEV0c0thUW9uSXF4elBOdm9PMndlSHIxWG9HK2d1MmxD?=
 =?utf-8?B?TUkrWDdtcVdFZXdDSEdpNG9kZVRLS3pmQlQrSytnODdUcXJsNkVGWS8zMjRv?=
 =?utf-8?B?ZFovV0RDbUhNd0lzOWI4Q1FFUFlQMTlIdG16cXVUc2tvRXprek1vNS9iVHpI?=
 =?utf-8?B?R1QvTkZMcTRVVm9yTDNpb2JNMm1KWUM1Q1QvZnZQUUsvUW1UaXN6MlJSNHJm?=
 =?utf-8?B?RzJCVEJ1cGgyM2w0eWZaNFBWUGpLaUUrdzV3L05nYk55dTN6K3kvTGVTNGxC?=
 =?utf-8?B?TTdRM0s0OGc4UTdyOXhwS2xmTnhiK0hJbHNQQXpCdnM3VUdyTHBLMk1wWFk0?=
 =?utf-8?B?SjVRbTdma0NaVEtlV2JoVTVnRytRWHFCN2JlVjd0VEd2Sjd3MFB0ZnZhUWlG?=
 =?utf-8?B?QWhWaW5WZzBmYlVVMlZud3pzVjZlUmZIT3o2aUU0OEhhVEpkblhnV3hVbXVV?=
 =?utf-8?B?Uk9QcDF0TERObVByMitQTEd5MmE5cDZPcmE4Y3VZaXpIWkUrMTM5ak1jaHZu?=
 =?utf-8?B?NitMSTdEUUYwOTAvTTE0Ris1K3hqeGlLbGNXL1dQQW1ENzFLeEpOTkpUOUg0?=
 =?utf-8?B?MHJ4R0wyRmFmK0tyYkZESm4yMjZRY3g5c3B6QnZhUlJzYmFRZytaYXFZSjV3?=
 =?utf-8?B?K1Q2bXBDVldCTHBObTZVbVF3Umk2S3BtVC80bVVFZVhRR1RWK2FQaHhjK1ZS?=
 =?utf-8?B?Njc2THJKcExDaDJRazFETkpwRFFNeHhvOHBqZ2cyTTlxWWpWbUl5aEhISThi?=
 =?utf-8?B?TUxKb1NDQ1Z0T21MbFQwNk8vMkhEMkJ4NXM1Q21WVTJGT2ljT05kYVFSUmgv?=
 =?utf-8?B?RFczT3JRaThUenBSd2ttZURIZE82eVFPcWJhUVkrUFBiQzhZdVNxclpabGdi?=
 =?utf-8?B?ZkhTRE1LY2ZhbHBRTFhNOWFRLzBPcnlvWWdkdkZLSnU0MUVSaUxHSERMUXgy?=
 =?utf-8?B?aWdYMmJUNUh3WklvTWZwZGJjRyt2R3M5MGF0R2tLZDdwZkhnNHovVjhNZytm?=
 =?utf-8?B?amlMMC9zNTRicE1ESlhUSUJNaXkrdVplQUhuaWl6eFh1YnRqZE0vZTZtM25X?=
 =?utf-8?B?RG1EZnhDd2dZUFRHSUU0SlF0M284REJKNWhMZ3ZMZ1JSWDZFVm11cEZuZ240?=
 =?utf-8?B?eTNZRDdDUlJQckQzSFZjdEFoSkJGNzlVZzZMTmJhS0M3Mkxva0NudGJJUHVD?=
 =?utf-8?B?RUd1ZitvSTdsN1FvaUpQSHErRDZ1M05MbGkrUFVyUVFjV1JyM2xHWHo0Y2Ru?=
 =?utf-8?B?eXJkZXFJT1V5dzZzVFEvVlIvODVrRVVqUkd5WkR4UHBsd1RFUE9jSkRPSUlv?=
 =?utf-8?B?NHIxd1kxR0hjV3JILzdSaDRWQkZ2MnNSSlYrdC9TZG5PNTh0WFZidkRONTJn?=
 =?utf-8?B?am9VbVpyQjhWMElvWUI1SndZdWNLU2FJNUdvS3AyZjhWSjZ0SGYwcitLMXFy?=
 =?utf-8?B?WXo4Ym9IblhtNmdQYXNkcGllSTBOakRGc0N2aTFYRllRcXhNbkxaZlN4NWVs?=
 =?utf-8?B?RzJNbEE0b0xLOG5wbXBGQXNxWG5xRFI1NmhCMU1JeVVjRDlmRmp4L0dGOVhp?=
 =?utf-8?B?V0UyS2RXeXc0Y1JtbmNXOG9MekQ4cnovZXl6U0p1b3MraC9pdWR4VjhFODlN?=
 =?utf-8?B?RHpKUXZUeWdzY1hhd1ppZi9ETEs4aS8rWFBCaU5ScjNQalpXcUZMSTY0K0d0?=
 =?utf-8?B?RHpjVlorR2NMa2duQjd3TTdxbXJXekFtRk5JMzU5dFpNMVFPUXFualRjRHpm?=
 =?utf-8?B?UU5HOTFjTzJLWTVFS1ZKb2JxK0Q4R3lrY2JuK0kva3FSeXlLY3JKUWQ0a3h6?=
 =?utf-8?Q?xlTT9zLCdiW+XwB0Np+/Jbw4O4Kt5pl3xnPx49robUFH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db57d6ad-f19b-4fdd-f944-08dde1802aff
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 13:31:15.2243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8dE5lYVvkHCk4a7KkEp07UjWEVffuhwi1+abVOXhyI7jPxTrO61s+C+tA1q0qmJ7Rz9QlNPLVcEpmrSLGD2VLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7721

On Thu Aug 21, 2025 at 1:52 AM JST, Danilo Krummrich wrote:
> This patch series provides abstractions for struct sg_table and struct
> scatterlist.
>
> Abdiel and me agreed for me to take over his previous iterations on this =
topic.
> I decided to send my patches as a new series rather than as a subsequent =
version
> of Abdiel's previous iterations, since the changes I made turned out to b=
e much
> closer to a full rewrite.
>
> The most notable differences in design are:
>
>   - SGTable utilizes BorrowedPage, AsPageIter and VmallocPageIter from my=
 patch
>     series in [1].
>
>   -  SGTable is a transparent wrapper over either struct Owned<P> (where =
P is
>      the provider of the backing pages) or struct Borrowed, which by itse=
lf is a
>      transparent wrapper over Opaque<bindings::sg_table>, i.e. either
>      SGTable<Owned<P>> or just SGTable (which is equivalent to
>      SGTable<Borrowed>.
>
>      - `SGTable<Owned<P>>`: Represents a table whose resources are fully =
managed
>        by Rust. It takes ownership of a page provider `P`, allocates the
>        underlying `struct sg_table`, maps it for DMA, and handles all cle=
anup
>        automatically upon drop. The DMA mapping's lifetime is tied to the
>        associated device using `Devres`, ensuring it is correctly unmappe=
d
>        before the device is unbound.
>
>      - `SGTable<Borrowed>` (or just `SGTable`): A zero-cost representatio=
n of an
>        externally managed `struct sg_table`. It is created from a raw poi=
nter
>        using `SGTable::as_ref()` and provides a lifetime-bound reference
>        (`&'a SGTable`) for operations like iteration.
>
>      - As a consequence, a borrowed SG table can be created with
>        SGTable::as_ref(), which returns a &'a SGTable, just like similar
>        existing abstractions.
>
>        An owned SGTable is created with SGTable::new(), which returns an
>        impl PinInit<SGTable<Owned<P>>, Error>, such that it can be initia=
lized
>        directly within existing private data memory allocations while pro=
viding
>        the required pin guarantees.
>
>   - SGTable<Owned<P>> uses an inner type Devres<DmaMapSgt> to ensure that=
 the
>     DMA mapping can't out-live device unbind.
>
>   - SGTable<Owned<P>> uses pin-init for initialization.
>
> This patch series depends on [1] (branch containing the patches in [2]). =
A
> branch containing this series (including dependencies) can be found in [3=
];
> Abdiel's latest series can be found in [4].
>
> [1] https://lore.kernel.org/rust-for-linux/20250820145434.94745-1-dakr@ke=
rnel.org/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=
=3Dpage-iter
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=
=3Dscatterlist
> [4] https://lore.kernel.org/lkml/20250718103359.1026240-1-abdiel.janulgue=
@gmail.com/

I am going to do a full review of this revision over the weekend, but I
have already successfully used it in nova-core to boot the GSP. Thus,

Tested-by: Alexandre Courbot <acourbot@nvidia.com>

