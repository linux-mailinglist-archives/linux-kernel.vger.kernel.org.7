Return-Path: <linux-kernel+bounces-784521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 030DAB33CE7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B38063ABFF1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF522D59E9;
	Mon, 25 Aug 2025 10:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fieWBupd"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355B833F9;
	Mon, 25 Aug 2025 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756118366; cv=fail; b=feE3pKA/2sEgBKMjR5lZChaOzIclNYAWSA8elzV/a3WeDXZ+3v0fqS8oNiJnHaz+eQk2SaYXSSQtOYbn4TER0CGTjjOIVaFMQ0QNWJPv9M36jybpjxWP3tVJqw8emhaTUFdZCqb3/ohlZGnlgBk5c61i3YI+QdNWUVC3r4ERaRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756118366; c=relaxed/simple;
	bh=UILXXOTEjMOsknvDUfr8+0Ngk1BLMAL/TVp/75LIDtw=;
	h=Content-Type:Date:Message-Id:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=FAa+o1l7RkTdAc7evJ3BDwXO2e8Uoxas9yHQ/Xhx4X+BAsJJBnwS14qvtF+ltdoettxfCWhDnFgtuQMuIdVEdVV5n/DpI40COfeUMuDUGPDWZ5Ejja7+WixpYS8yz+V8OCvcGv41l1QM5cFEI/o5mFWjiNvU84JGDJOESn2sX0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fieWBupd; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKHOhZ6QR9qPuOAqVefFUm+atORfqNyKH/UnaGedWafphCfkvvtgkl2xiJqsuBiFMu5BOOk0Pw3UMn3i9H+Te9WrtzmHtfcDleWQMtRvo3aDYa19bDqU1kLDudZr2VDkwKH6HEih9ox2mF5gfRjoPAwCWKqkhzbBENyJQrXXC/iwukQVpjWNlJEZkCHaG/Ofz/kdXI14K+AXkRe9UOZEzn0DXUh+p1lZ4agzIZjxxQRUjtLT2/UBpjUq1qXOJVjbrkccUxl+VfWkqnxAFEb2s23pv6q8ZPb0N2s6vXSSyQ2c660Z90AtZcR9bhkrjz/6S6NDemCthrGvJSxLoRWZaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWVPRwrwLD5tz9MPJFEKl2Rd1VCj7ubvGCLu3Xp8njQ=;
 b=CG448hioJNnnuZBcHkhN0lDQ0dlPkB/G45U5BOlnv8K7dyvevr9oqnnOLvfuIPByAWnyDfflqGoDpoo6osAE7Bmee1ZnFcqD9gOd4bVJZ5PwnMeOmwMzIW9bPvmP0dRCSyq2FhxxyHDKV0YpX9hMeEoTeh9BugMSfKKQ2PmLy1pkQuD5hgEXeNc2yrs04QB2bLNzMUI9jMlTuxn/sB/i9LioacVS48PSqDYxHF2/dTUHvTXF5bEQxalWMNtoSfe8X7PnN9QeFJcuTPM9M/lC/72izGWKs3YhABZ0b79AukiMmL5RG4GW7D+mJsZPv2ypXTHWLYtoodYoDa3y1oJhlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWVPRwrwLD5tz9MPJFEKl2Rd1VCj7ubvGCLu3Xp8njQ=;
 b=fieWBupdSwsvIPVeFMqur8YXizyHcm1cTacm5TvUOjYsEEXqCM/nI4ZEyIe3uWtC0EUAI8HxctgD2zaVl4bk61mxoihfF0QHZ/jqWXca6kSeL0hOVVfT0Z00hKzfm6xHwByQi8hG4jOT3g1KSETO3prJFJBoEl670rpdtqCJju7HiH0MoZwWHuxsdBOc5kMQhaVTllJdmSQ+EoaY1OOnlgT7PNz1aB/Ez0RZhUpIxNDJ142CK5po3c0TcXdRP9ZQx4gTpgAbxBFfnve1HF/Nj/FC5g4GsZGfQD7Ee/VXrFqgpZ20z1G3cKLqMQ658uHoqm8GjOQ3CIjQDzbKWYfoVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB8466.namprd12.prod.outlook.com (2603:10b6:208:44b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 10:39:20 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 10:39:20 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 Aug 2025 19:39:15 +0900
Message-Id: <DCBG0345JTPY.3A6MSWZU7AZE5@nvidia.com>
Subject: Re: [PATCH v10] rust: transmute: Add methods for FromBytes trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Christian S. Lima" <christiansantoslima21@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <benno.lossin@proton.me>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <~lkcamp/patches@lists.sr.ht>,
 <richard120310@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250824213134.27079-1-christiansantoslima21@gmail.com>
In-Reply-To: <20250824213134.27079-1-christiansantoslima21@gmail.com>
X-ClientProxiedBy: TY4P286CA0097.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: f749b130-3129-4217-af17-08dde3c3a5da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bndwNEJ3V1JlWGs5SVVNN0VJQ2dMQjV4Tk8rb2VQRHVqZTJ3dHFteWhxcnlz?=
 =?utf-8?B?b3VaVWdNWHB5TkxMWnhnbE16NzdXNHZkakZGTGMvcytOVnR2S1YvRjhxUnIz?=
 =?utf-8?B?eWdPSDRRTjlBVnhyQW1YbFFIWlpxTEFWYmlzSmlQVVUwZDZOQ3o1NHlsUDVz?=
 =?utf-8?B?TW9sSjhjTDRFZ3FLdHVjWVlyQWdSRzRGeHRnbzhISDN2ZmNrbXhFZnRzQTJ2?=
 =?utf-8?B?ZmhSTUdXNzlaeDZXY3B6aGtSUFQwb3phbFBSZnJVQ1FkcndCMWFMd0VuNi9q?=
 =?utf-8?B?a0F6akFzT2dWejlYT1lhVjBLZWhYN2NYQmd3cENDTG1GNkh2SUJ4bXRRclF4?=
 =?utf-8?B?bHBXOHVCb2xzRFhseFMxUnljWnZlaDdwQzJCelhuZ21qcVZRSllyQTQvRHpG?=
 =?utf-8?B?bTNjYWpiRXlDQXFQb2wxQ3JDOEZnZkhxRUVhRGJJUlFuR0lRNXJGaVErb1RV?=
 =?utf-8?B?QmsxbkhCQ2JTY3JpbytNYjBOdkdRR2ExQmZxNUR1Qys5YWdXOEJtL0xYWlZk?=
 =?utf-8?B?MXI0eUo2T1VyczRZQjFZeHdMVXdKZStzRS9KZFYydGtxMHlEdjhIOS9Ieitr?=
 =?utf-8?B?c2tqcjBQWU03R0FQSHFBSEFpUGkrSnhyMlluZXdsVndwdlQ3MVlEUnF3WEZz?=
 =?utf-8?B?VkliaGh1MHVQRnRYN0N2ZklSTWRKNjN5NVJOeFczaGc4eTVwaUZXRnBGYW9j?=
 =?utf-8?B?b1RQV3VDblgybDM2U0txU2Z4NmptU3hxTzdob3NpdjVWVWhZRHgrZXVIMWFW?=
 =?utf-8?B?cVhWbXdxbkRNdVRSbit1WHJybDRMQmluUzJDRG4yNThWKzFwczBpMXAxcGly?=
 =?utf-8?B?eFhxeDlwQWJ3TDY4Yk9BSkFSOXdobnhNTi9UZ0tBTHdGakVBeEJnbG9jc2FM?=
 =?utf-8?B?THN4WEhYcWVrUytxdDFsM01RNGppdEdPbERsdmprM3FkdHRpaWlkejBtb2NI?=
 =?utf-8?B?anRJdkl0RnlWS204cFJwVWdFQjhHYnFwejkzTHVyOGY3a0x4NFNFSjhJRnAy?=
 =?utf-8?B?WjRhbTFyUjZpK3RGaG5GUjVjWVlZWldnUUtSbUdjSEVqMlpiTUIxNWt6YWsv?=
 =?utf-8?B?UUl1K2NjRnpJYllCMjFGVW9NNTNzdHh3TWRhOTdIRmV0blpjMVZkOTdkTmkx?=
 =?utf-8?B?N09qdGVNMUVzZGg0SkFrWkpjT01YenovTXhSQnhsK3ArUms4WGpoY1ZRTzhY?=
 =?utf-8?B?MmpteEMrWk15NE5uZUNBT1doS0QxL3Q3WjZHN0s0OG9xczczQ0ZEY1haQnA5?=
 =?utf-8?B?djVzZXArYWFHSEhzWnd1UzJ5aWh6TVhVdG8yMHFJMFJBRzFiZkloU2R6NFhF?=
 =?utf-8?B?UDFXRFRDbGtNSEdXZ0Q3bFE2WUtrNjIvSUIvU0t3RjhjUUJSQlJXTUxHbnkr?=
 =?utf-8?B?ZGdXc3k0Qm96dXdXYWdxQ28rKy9rcm5UNGZxeDVvSDZGU3Z0WUhhTnNnWkZN?=
 =?utf-8?B?aURBY2JpazN0RU9DQmJkRkRkYkdBRnpsQkZEMXVIMjIvcUNXRjFMSjJFcHRC?=
 =?utf-8?B?aWFIbDJ3MGFxQ2p4OVowMFBaQ1dZa2dtK0lTbjJCU0REZzNPQjlMZDlFRVFT?=
 =?utf-8?B?UHozNG50RWNLSERxeFZlSXVmVGVxaDZUYldwbXVWNjhMalpwdWhzQ3BXT2Jn?=
 =?utf-8?B?QXpnaDBrc3FkT0RORENYb3hFa2tHcDFVZmMzM0M3M1crbHYzMWJreUwrQlAx?=
 =?utf-8?B?MFlFRHZ5dWhwK3dtN3E5dHpIL0xMdWVCdDJwZjZwUVJQRDJ0WG1jb3IydHd1?=
 =?utf-8?B?WjhndXhvbGtiME52eFg2Q3FzTUNPZlN1NGtYT1dYSDdvUE51bk9YUHpIdmxx?=
 =?utf-8?B?YW1JdHk0S2p2SStGZW1takwrSlEveldDYnZQMk5idWtMZlVzNGIrSC83OUdw?=
 =?utf-8?B?endzZWRBRi82aEVwdUJiZ0VCajkwUUZ6eDE0SDRaeTRZSU9GcVk4bEhReHRB?=
 =?utf-8?B?bUxaUk45UWZyTzV6TWRXRHFmcm5JbnhwNEFvQTFBbmhVeGszTjg3bHFuSUxn?=
 =?utf-8?Q?RPx4r+oHriNN7qLp5B5SIwg5cjzRko=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWE0TThpZm9GNmZHUC9Ob0NyNU1yMkNvMVdNR2w5dHllZVpST0tBemR2YWtK?=
 =?utf-8?B?WCtteUlMY2hjY2VZeVZzdGVDbGRDcFhaT3BpU05DS2pwRXR4N25FTjRXTEtJ?=
 =?utf-8?B?QmNOL3IvekV1Vk1GWm42dnNTdUE3YTU5WmZ5QXF1UEowOEFTaS9McFVPUkF6?=
 =?utf-8?B?NEZQcG1vWFo0Vnh3UGRRWjhtQjlobHR4VWZ1OUQ3dUprV3VsdHBzVnhvTU80?=
 =?utf-8?B?R0kwV0FEeGVYcHhQbWhzbE5NMTl6L2ZXVFJqdjhDekIyakJYTHBkVHJiQkJB?=
 =?utf-8?B?bVF3YmdZL1hrNGJVRnF5OGJzVG1MQTVaQ1g5d050SFdDS0lNUk81U2x1MHdw?=
 =?utf-8?B?MVlSV2oyc3ZYblBVejh3ZHNXNEhyL09IdTN3NHFrK3dVRVZrMHoxQzVVOHFn?=
 =?utf-8?B?aldEVkxGRWNWbktTT3YvQ0xCZ3J1eFFreU1VSWtrbjlYSXFka0NWRlJ6OXRm?=
 =?utf-8?B?bEE0T0cySjFNQ1l2aVZmSWhpMGQ2aldaM3JreGhaZmVORzk1RFJ2WW9aaU1C?=
 =?utf-8?B?bEREZUU0YXY5R0x0b1Z5SllhUEdVMjN2Mmh1eUZPYlY4WGlVRWFNMUwxNUly?=
 =?utf-8?B?OXJ3bDlXN2xXc09NanFRekZrb2FtYUJVOFVXbXRvcUwzcVNoa0ROL204MFIx?=
 =?utf-8?B?K1F1amVrSkJPRmJQQmxldXp4V2tIa3MvQXBYNjdyTmtFY2RZd1pRdmNWUmRx?=
 =?utf-8?B?bVZtMi83dDVXOFZ5bUpFTXJ6bUdSMGk3clUyNGZLR1o4WE1CajJRQlVxZEJh?=
 =?utf-8?B?SVRXeExwT0JDc1hhWmI0RzJyejBoclQybjNKMTlmbnUwcUlKZEZNbUlhYkNL?=
 =?utf-8?B?SGpBMzk3MkNoWjZvL1ZleG10MVBMOC9UZnJibGtvd0RKVEU1NWhyV2FDbTRZ?=
 =?utf-8?B?ZEtHaWxST2dwNy9FUE1oQ3dhcFZZSVIyYjlJMGM3SmJVL2pHYUNjaWFKT0RK?=
 =?utf-8?B?VC9yNGM0VS9WZzZGNWx1ZmRoS09FbXNmNTYxdHcwcGdlVXYrcXhaRllxVEtU?=
 =?utf-8?B?L21QNm1BekR6WFMzM05lZXQxQjlmQXZnN3FRMVF3cm5jekk2QnZkZlJNTkl2?=
 =?utf-8?B?NnIxMUxtdndyUXZwSithRW9OK29xaUZVcWlQWFoySlZ3aHliRkhLWHJKU1Vz?=
 =?utf-8?B?ZEZmdlAzNCtOQTBuMDQxMGU0RzFlYW56K3ViUlJkdGFaUFFQZmxZVzk0T0Za?=
 =?utf-8?B?a1RTRkVIOVlXQUdPNVJzWmhFeGljZUdTWnpPa1BSWVBmZ1NWWnh2dmRMclpW?=
 =?utf-8?B?Rm9yR1ZzczRaaExHeGVYSno5cmxhRzRIZ3lOTzIrVHNiaTRPTmlaR1hFV1hW?=
 =?utf-8?B?c0xEVk54VnJzajFpelZiSTlONUlQR2hLa2FuL0FBWXJFQXNsREFtbU5WdlVV?=
 =?utf-8?B?SFZlZUs2MHhPRGYrTHV0MU5Ka3duTUV4eTJEV3RURmpaZlB4ZGM2eWhxdHVC?=
 =?utf-8?B?ZTJxQlZVR2dlVFk0cVBRYlBHS1ZsK3d4WE9JY295NEhyWjJPakNoUFVHSFJj?=
 =?utf-8?B?Q2ZIeVk2Q0MwNTg0TWt0YXZiV1VRUmh6d0k2Y1NSekpKWnFQdUdYLzNTUVJ0?=
 =?utf-8?B?ZlZiWHVxYjFzdWtSRC92MWtuWjZjcDZ1cW94UHN5amM1eEZUN1VGQ2RHTlRv?=
 =?utf-8?B?c2tLRHZHRXBSdTR2ZUVZaURSak54S1hRR2NNd1k2OWN2N1BUc1NuZnlzSVZo?=
 =?utf-8?B?bnRaM0dBblltNXU1WmN4RTV6TXBUMEFGUkU0Wjhid3A4Z2dFMktSU25nc25N?=
 =?utf-8?B?bDFXR05pY0xyTGxUdkkrSFYzYS9IUDJSbVVoRnBJbFpDeSs1SzdWZDhPQ2xO?=
 =?utf-8?B?LzdZVDlmNzRCSVJXZkQyMjhGV2pBTi9FTjJVYkUxeVFXVitMU05XN0JqOTll?=
 =?utf-8?B?VlYxMC9BTEZGQUJMUkRzUisyRGFXK0VzUmFsSUppUkpFeHU4TlJLb2lCTE83?=
 =?utf-8?B?RUhINHZObldMczFyekQ1TEx0YTF6U0Z4Rm9VM1kvT3hwNWowRURQSzRCREw1?=
 =?utf-8?B?UVFvTmNJQ0NOWkh5WTRKQ0YrVlFkU2lybVBmZzE5NFUvOVZvMDE3WmFYdlds?=
 =?utf-8?B?UkFkN3kwYTVyeTMrbXArb2M4VmRncFhqN0puWkxETENJNlNUeWc1cWNmTi9J?=
 =?utf-8?B?M0JncFFYaUhMekw4THF0eW50alkxM0ptajFDK0VIT3FuVHVieklEWUp2aDBs?=
 =?utf-8?Q?zCpCf2QW26OFInvADCy2yFf0YLoyljLdCntvO99324Ba?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f749b130-3129-4217-af17-08dde3c3a5da
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 10:39:19.9859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxUUlgnDkG2haej/hXadOZ9uRolAasEfhdz/nj95UlLij3PmDEGyCgSBN2RluEHZYCd9cVpvpzPCylWGSsOGvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8466

On Mon Aug 25, 2025 at 6:31 AM JST, Christian S. Lima wrote:
> The two methods added take a slice of bytes and return those bytes in
> a specific type. These methods are useful when we need to transform
> the stream of bytes into specific type.
>
> Since the `is_aligned` method for pointer types has been stabilized in
> `1.79` version and is being used in this patch. I'm enabling the
> feature. In this case, using this method is useful to check the
> alignment and avoid a giant boilerplate, such as `(foo.as_ptr() as
> usize) % core::mem::align_of::<T>() =3D=3D 0`.
>
> Even enabling in `rust/kernel/lib.rs` when compiling with `make LLVM=3D1
> CLIPPY=3D1` a warning is issued, so in order to compile, it was used
> locally the `#[allow(clippy::incompatible_msrv)]`.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1119
> Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Christian S. Lima <christiansantoslima21@gmail.com>

Successfully tested with nova-core, thanks! This is an essential support
piece for the next steps in bringing up our driver.

Tested-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

If that works with everybody, I would like to take this into the Nova
tree (after a few more days of review) as we will be using it this
cycle. Miguel, is that ok with you?

Minor comments below, which we can address while merging so no need to
send a new version just for these.

> ---
> Changes in v2:
> - Rollback the implementation for the macro in the repository and impleme=
nt
>   methods in trait
> - Link to v2: https://lore.kernel.org/rust-for-linux/20241012070121.11048=
1-1-christiansantoslima21@gmail.com/
>
> Changes in v3:
> - Fix grammar errors
> - Remove repeated tests
> - Fix alignment errors
> - Fix tests not building
> - Link to v3: https://lore.kernel.org/rust-for-linux/20241109055442.85190=
-1-christiansantoslima21@gmail.com/
>
> Changes in v4:
> - Removed core::simd::ToBytes
> - Changed trait and methods to safe Add
> - Result<&Self, Error> in order to make safe methods
> - Link to v4: https://lore.kernel.org/rust-for-linux/20250314034910.13446=
3-1-christiansantoslima21@gmail.com/
>
> Changes in v5:
> - Changed from Result to Option
> - Removed commentaries
> - Returned trait impl to unsafe
> - Link to v5: https://lore.kernel.org/rust-for-linux/20250320014041.10147=
0-1-christiansantoslima21@gmail.com/
>
> Changes in v6:
> - Add endianess check to doc test and use match to check
> success case
> - Reformulated safety comments
> - Link to v6: https://lore.kernel.org/rust-for-linux/20250330234039.29814=
-1-christiansantoslima21@gmail.com/
>
> Changes in v7:
> - Add alignment check
> - Link to v7: https://lore.kernel.org/rust-for-linux/20250615072042.13329=
0-1-christiansantoslima21@gmail.com/
>
> Changes in v8:
> - Add the new FromBytesSized trait
> - Change the implementation of FromBytes trait methods
> - Move the cast to pointer earlier and use `is_aligned()` instead manual
> alignment check
> - Link to v8: https://lore.kernel.org/rust-for-linux/20250624042802.10562=
3-1-christiansantoslima21@gmail.com/
>
> Changes in v9:
> - Improve code comments and remove confusing parts.
> - Add a build_assert in the conversion of type `[T]` to check for element=
s
> inside the slice.
> - Count the elements in the `[T]` conversion instead of using byte
> count.
> - Link to v9: https://lore.kernel.org/rust-for-linux/20250811213851.65644=
-1-christiansantoslima21@gmail.com/#t
>
> Changes in v10:
> - Remove `FromBytesSized` trait
> - Remove implementation for slice types
> - Fix doctest not compiling because `?` operator outside a function
> that return `Option<()>`
> - Make `FromBytes` trait depend on `Sized`
> - Add `is_aligned` as feature
> ---
>  rust/kernel/lib.rs       |  1 +
>  rust/kernel/transmute.rs | 69 ++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 68 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index ed53169e795c..c859a8984bae 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -18,6 +18,7 @@
>  //
>  // Stable since Rust 1.79.0.
>  #![feature(inline_const)]
> +#![feature(pointer_is_aligned)]
>  //
>  // Stable since Rust 1.81.0.
>  #![feature(lint_reasons)]
> diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
> index 1c7d43771a37..7493b84b5474 100644
> --- a/rust/kernel/transmute.rs
> +++ b/rust/kernel/transmute.rs
> @@ -2,6 +2,8 @@
> =20
>  //! Traits for transmuting types.
> =20
> +use core::mem::size_of;
> +
>  /// Types for which any bit pattern is valid.
>  ///
>  /// Not all types are valid for all values. For example, a `bool` must b=
e either zero or one, so
> @@ -9,10 +11,74 @@
>  ///
>  /// It's okay for the type to have padding, as initializing those bytes =
has no effect.
>  ///
> +/// # Examples
> +///
> +/// ```
> +/// use kernel::transmute::FromBytes;
> +///
> +/// fn test() -> Option<()> {
> +///    let raw =3D [1, 2, 3, 4];
> +///
> +///    let result =3D u32::from_bytes(&raw)?;
> +///
> +///    #[cfg(target_endian =3D "little")]
> +///    assert_eq!(*result, 0x4030201);
> +///
> +///    #[cfg(target_endian =3D "big")]
> +///    assert_eq!(*result, 0x1020304);
> +///
> +///    Some(())
> +/// }
> +/// ```
> +///
>  /// # Safety
>  ///
>  /// All bit-patterns must be valid for this type. This type must not hav=
e interior mutability.
> -pub unsafe trait FromBytes {}
> +pub unsafe trait FromBytes {
> +    /// Converts a slice of bytes to a reference to `Self`.
> +    ///
> +    /// When the reference is properly aligned and the size of slice is =
equal to that of `T`
> +    /// and is different from zero.
> +    ///
> +    /// In another case, it will return `None`.

I'd replace "When" by "If" and "In another case" with "Otherwise" to
sound more natural.

> +    #[allow(clippy::incompatible_msrv)]
> +    fn from_bytes(bytes: &[u8]) -> Option<&Self>
> +    where
> +        Self: Sized,
> +    {
> +        let slice_ptr =3D bytes.as_ptr().cast::<Self>();
> +        let size =3D size_of::<Self>();
> +        if bytes.len() =3D=3D size && slice_ptr.is_aligned() {
> +            // SAFETY: Checking for size and alignment ensure
> +            // that the conversion to a type is valid
> +            unsafe { Some(&*slice_ptr) }
> +        } else {
> +            None
> +        }
> +    }
> +
> +    /// Converts a mutable slice of bytes to a reference to `Self`
> +    ///
> +    /// When the reference is properly aligned and the size of slice
> +    /// is equal to that of `T`and is different from zero.
> +    ///
> +    /// In another case, it will return `None`.
> +    #[allow(clippy::incompatible_msrv)]
> +    fn from_bytes_mut(bytes: &mut [u8]) -> Option<&mut Self>
> +    where
> +        Self: AsBytes + Sized,
> +    {
> +        let slice_ptr =3D bytes.as_mut_ptr().cast::<Self>();
> +        let size =3D size_of::<Self>();
> +        if bytes.len() =3D=3D size && slice_ptr.is_aligned() {
> +            // SAFETY: Checking for size and alignment ensure
> +            // that the conversion to a type is valid
> +            unsafe { Some(&mut *slice_ptr) }
> +        } else {
> +            None
> +        }
> +    }
> +}
> =20
>  macro_rules! impl_frombytes {
>      ($($({$($generics:tt)*})? $t:ty, )*) =3D> {
> @@ -28,7 +94,6 @@ macro_rules! impl_frombytes {
> =20
>      // SAFETY: If all bit patterns are acceptable for individual values =
in an array, then all bit
>      // patterns are also acceptable for arrays of that type.
> -    {<T: FromBytes>} [T],

As Alice pointed out, there should be no need to remove this - I have
kept it and things build just fine.

