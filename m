Return-Path: <linux-kernel+bounces-760906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4690DB1F1DD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 03:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A3D07B4479
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 01:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A26E275B05;
	Sat,  9 Aug 2025 01:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YU7rEdWr"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2AE2236FC;
	Sat,  9 Aug 2025 01:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754703187; cv=fail; b=h8BoGg265VxCm94xvFGGp5eCPLDMNisOw7nSo6D6nxti52U0qvSs2YPEJl57JA8Wi2kjrviniliVpP//KDN8TziTGvb10v/AIIu48wNi7wtr5vpY9gUVstBeS7afeCaoRd0gUTRzgGvkLtiXKLHNBSNT3biz4O+lgD0i2jJ8+vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754703187; c=relaxed/simple;
	bh=UdYsGa/82H6eozI2WD3vCCKRI0BDpqwFie8urHoZgxI=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=WBjE5XhNRbqNWhCnsqhNg5+eyZDkrehi+2w++tWe8JJ6KpOvRpw0oBn9LMf58axgHERWlyDXwE9ajK5BB6hybCD+yVsnYRVMT+7vw32cp5/IaZXalX7A+NTYCTiKPTu7IeioN4Q3UhqmLBfS/e0IcVgwFn0Gdj+rE2+Ima3srHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YU7rEdWr; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8ns4ZjQd8JxHEPfiH6DV8aJ/buTWWuWDh81S5TANwqMJi+jc/3HU12LNjIDAESaz5f8iAULxI1ht6OxM6cH37CjZ3ZFLlE0iTLdYTTACboX6x4lbuYsiJCv3u/n9CJRwMOTkpqFR5FKoG+SzHxvRlzPlGXw7pL7+LCu9OJU3eVqjGH6o3sGhIQ1J86R2s92ssUO0WgqZdfRBwRBp7SOm7tVONJCNtlKwtuv/qppvEicTi0+axDL9VMeoce3llboc1GAGzgti/T0wR7QOA/jnUndXZNBD2Qd5KF8Pg7pFs9tiQl35I5oRfm/rM0qFr8w3hY6njnCKsPh2c9vd3X2CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdYsGa/82H6eozI2WD3vCCKRI0BDpqwFie8urHoZgxI=;
 b=OBFq149jOApDHI9xe8YUrtreWx4eSEoJXZR3HAVjk0mZwREflr01n2O/DZ98nXUbDJNdxbh7bZtnOXGXgGg8uPRipNB/gFVvcClBDXPuP6YdvjjYu+xrl+iuqMxL6EJDQDeOb78g/tnwbVrvmUhspbTbqLplxi5pUnWTlLWIDSnxCbLlPLMyb4CfKoZf9QADmQlKKU/I7AL4OMa9lI7qLR97k+zpMWdFpyWfHGvq/QEa+pSU+/ORhAz+oSWfNp8hyLq7LqX4NsT/YTG6szak+PZGYJ5TUsJjjCWIf+JUOjkX4bypBx1p+93MNaahjc45Icrk/K8rrSfAFzCawsr6gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdYsGa/82H6eozI2WD3vCCKRI0BDpqwFie8urHoZgxI=;
 b=YU7rEdWr26NXMwl6vJNv7GkMm28peJRdeTX7CySIDcOe9GXtlbk3kOlj5B3vjJ+frvrcros4fMzHcd1v6iZLQsT9KvQR9ueEde7YMHnKNB4A+13eBkA0Vn0X2pQHSpX3piu7CC987W+3UVHpWRKPyTaH777xKZqtrPfyCuEY7Dyb02K7hOKzANIfwR67VSmXg7mGEDmQuVjw5EmhGpyiq0FNkwIf4tzj99uHgrNoztQfDJIBpu3qsWT5IoiiMQRbpK+QjWzNXzjt6obb24wTmQbx82lkhCR3UmCtXfqlcutcAqwxEcoK+czriyfqp4s0XPoSYPR4m24xktZrKIuDHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB8143.namprd12.prod.outlook.com (2603:10b6:806:333::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Sat, 9 Aug
 2025 01:33:01 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9009.013; Sat, 9 Aug 2025
 01:33:01 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 09 Aug 2025 10:32:58 +0900
Message-Id: <DBXID3RAD18M.1EPXFRM5SDCCS@nvidia.com>
Cc: "Will Deacon" <will@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>, "Mark Rutland" <mark.rutland@arm.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/5] rust: convert `Arc` to use `Refcount`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Tamir Duberstein" <tamird@gmail.com>, "Alex Mantel"
 <alexmantel93@mailbox.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250723233312.3304339-1-gary@kernel.org>
 <20250723233312.3304339-4-gary@kernel.org>
In-Reply-To: <20250723233312.3304339-4-gary@kernel.org>
X-ClientProxiedBy: TY2PR0101CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::21) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB8143:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fa92229-5ded-49da-ea62-08ddd6e4adab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3Z3Y09SMUsyeEU1cGxtdWdJdU9LRms4d0tsMHdveDNoSUZOMnF1QTJ4Q3pS?=
 =?utf-8?B?dUR5bzF5V2NyZlRjakdMbXVkeHdRUzg4Zmo2ZkM1OENQTzFHZUZMMlpjZWdM?=
 =?utf-8?B?aVlvajgrYXJoOUZCNEhrOEhRMWErT2treDFVZ05nRzRnanRnNXRGN0VUNU5P?=
 =?utf-8?B?UHlNdGVlOGYwVW1VZDcxQnFZZWFWcWFhZnE3eXh1UEFXZHRxRnppWVJQVzY2?=
 =?utf-8?B?RVdhcHFXRUxjck1nV3crRklRRnV6R3FaYUkyb213UkhqTU9rbGJLWUFaczNC?=
 =?utf-8?B?QlY3Z2hEbGNZYVZhU1ZtMndncTAyWW43NGZTY0xCNmFzcVdkWHpvNVZ4dmpC?=
 =?utf-8?B?UW9xWXJSWS9jKytSYTJPSDZ4VmNFbitZT1A5d0RnMlpiWXB0c1lHd3lQU0My?=
 =?utf-8?B?bkx5WEdEWmF3WWt1MTJGaUE1c2w3eHgxa1JpK3ZLQWswbzhjNDJua2Nsb3o2?=
 =?utf-8?B?cGsxV2EzQmRSRHdKWTZBVjlhVFJjUko2Wk50NENINVd6My93dWFZa3hjUWR3?=
 =?utf-8?B?dngyOEFqeDc0eXhaY3RHRnFhd0NJMWkrVFZKK2xZSVpWZVErRGFOWTl3T01K?=
 =?utf-8?B?R2k3bkNXOEVZMk9VRVZZS0tjbVZBUGw5QktwV0YxQmZGTmoxbEl4bDZFRm5a?=
 =?utf-8?B?UFdJZ1ZQczU4eDl3WDc5ZlMyb3ROOElPQnBpQ2UrYVc0NVN1bzJUZThuWndi?=
 =?utf-8?B?VEN0Y2ZBczhTUU5yWVhNNHI0QXJYeUtyRzAxajhVc1hlaE5BTW13cDRHQmhq?=
 =?utf-8?B?VXpmTWdvMWxzcW54YkwvTFNGaXdjeHpjeHlLL3YyYjYrQ0lRUDBXVENsMUpv?=
 =?utf-8?B?akcyRTFVRDFOQXVtYTZYcnJ3c2JoVWFNUXpHU3h2RzNndTQ5L2gyUHBDQmhN?=
 =?utf-8?B?bUNCVE9LeC82Qnh2cGEwOUN6Wk1IR2pZM1ZXVnZCY1d2L2ZIOE9iMlFLL2Iw?=
 =?utf-8?B?SjZpOTdUUVFMTld4OG5ibW9FNXVnaW93T211S05tam1NVmNEWG16VnJML09x?=
 =?utf-8?B?YUtCcEJDaWtTSXp2RUJKRlJIZHJ2Q1o2d2hiMGJzZ3RMKzJhbmxyZVZwQXBQ?=
 =?utf-8?B?N3pZWWNFRXFOQVhjTmJXNlBacXB4d0hOdStyYzhXMXVqUVBPMExxeW4vbzhl?=
 =?utf-8?B?TE1BMDBnOTYzWmt0QkNEZnZSMHR1OGJDWjE2MUUrV2dVakNzNHZCb0Foa001?=
 =?utf-8?B?dFNya0V4S1U0RGpIa1JienpDWWlKSUFBZHQzY2F6UHZ3UXVvVlFpT3BhdGxk?=
 =?utf-8?B?R0dySkxYdUVjRjlEYzVBTzJIQ2daUEV4SEdaOXdKUTVsdVhQVFp3c3hibHJH?=
 =?utf-8?B?SDlrUjhQLzdhVHJhaVB2L3dJWHlkcmMrbEVhSWcvMnVNK2hscC9JVmd6Z3RO?=
 =?utf-8?B?QUtHa3VScTRWVThRZ1dJV1Y3L3VpVlE2R1ZWMFMvbTJDbE1DOXBab0lWRklw?=
 =?utf-8?B?TjJnRXFQUUd0d2pqQzk3a3ZNdjBacVFLWG5ab0Iyd1ZPSzdZcTAzNlpsQlNR?=
 =?utf-8?B?V2V1VGlXRXFmSUxZczNFL0lIcXpaK0NPQjJkN1NjbnhlVWlNN3E0NFlHWTgz?=
 =?utf-8?B?N29pUHp3bTNHaVBmeTVXakxkUjhYa1AwUnFxR0FwUjBWaG1WUDlCZTJ3OFRy?=
 =?utf-8?B?UHRicG5JZ2V4UVJjNThBejBRc2pBaXRBZE1nVmRNQ1VRRGRVaTRSYndWdThD?=
 =?utf-8?B?N3FrRU1mdFVxaFRWTUxKTXBJT2c3Z1ZKVVVWbXhqd3dtOVEremw2eERLZmhl?=
 =?utf-8?B?bXBsRmw0Um9OcXhXOFF3dzZIUmtkYVNxUS9iTEJMNGdsdFZ6SU9kL2swdklm?=
 =?utf-8?B?K0pwUVNISjljQkExUVphUGgvVkxjYS93VTJvUitobXZmRUU3UXZhOFJjYSs4?=
 =?utf-8?B?WWROVk5BSythMXJ0MWVDMllJd0xzL2I4cFkyOUQ1OWlzU0xRYlZETEVRUTQ4?=
 =?utf-8?B?Y3VjZTlvZTV1K0Flb3E2SUF5TC9yL0FVdG9PVzJPQ2E3WWJkQy93b25KUmlF?=
 =?utf-8?B?d3RkcFhJTVF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlhkUHJXNTJTeFAySVZncThUYUluZFMwb2g2Q3krZTlVckZnS2x6a3VUb0VB?=
 =?utf-8?B?Z1EvaG1rR3YvNHdQZVdDUlNGczRsYk11azhIMGR1K2thN2xXM2R1UkNYSUhU?=
 =?utf-8?B?a2FlMmhyV1lTK2ZITGxtY0J4NUU0Wlo4dlJCRjZXRWdIdVI0V1lZZXJoakt6?=
 =?utf-8?B?V3owdUoyaEpHMi9FSGlDS1loak1tYUZUUnptMThXR0plTlBsRnZFZHBXYklk?=
 =?utf-8?B?eEZIQ1dUS0ZTdGNpa1pvZXdzcEZKSENwQnRVSUdva2cwZGtHb1Nmd0NjQzlW?=
 =?utf-8?B?cE9VSCtsMEwzRzRsdDhGYWtMY3lOTGFTNUZvMjg3cmMyVDRXQk92Y2JreHho?=
 =?utf-8?B?L1pXMHExT0E4L0pTT245MkNJSENMWUdobTRuUWluVkx4WlkrTWY3TjJnWEY4?=
 =?utf-8?B?WXgwQnd0ekJxUHIvdnNUcElyWUVrNWpuc2gwNTVVWC9pVmtLOTEvLy8wVEg4?=
 =?utf-8?B?cWV6YlpaNGZ6MnRXeElmNnFMc1pmalFvekVwSzNEMkRQWVdBcnNJTDJhZGJj?=
 =?utf-8?B?VUkvU2w4WnA2ZDBFdEprbUpVNWFQUGprTC9NZXl2OVdUNGt2MzIvTHpUZ1I2?=
 =?utf-8?B?RGpjYm9ieU54STZZeFBsYVh0cUNWZnhFRUlEL2xaOHBPQ2hCSmR5QlBnSnVs?=
 =?utf-8?B?R05jZWMvZmpKblUyaUFhNkJ6aVBRRWlHVDZUbkc2ZnZvVTlSaVpwcFFPWktF?=
 =?utf-8?B?K2t1Q0x5bjZDcnpnbzlBc3lHcTZOMURuM1YrRGFxc2VxNWIwelUwbnZQUEFF?=
 =?utf-8?B?djZtQjJ5NE9VcFhoMnc4MkttM1JrZHJpdDdaVkdOQlNmR3ArZjRpRGxxRmZp?=
 =?utf-8?B?WW5ndk9VeW1kZ2dTUWQzY0ZPT0lYeC8xL051VkozTFpCTjloN3Nhb01Qb0Yw?=
 =?utf-8?B?NmdWT1Jibndtd0VWbWpJdHFPR2tubDRjT1hSTlYvd1NzMWNhaWNPS1RTVWpz?=
 =?utf-8?B?djloUUFCUlNmeDl5ZWRMdVdmaUdva1hwOThsY0FrZUM0Z3dTaXhiV2NNTmRZ?=
 =?utf-8?B?M1U1QnNYK1ZPa04zc3JuWHJLQit3OWhGclVzbnkyUlVNMHRSSTNLZlFDRWh4?=
 =?utf-8?B?c3c1RTI5VnpFY0l3cDYwbjNBaExCVFVPY0taalpxR3haeUFzeXlnSkE0Tk1H?=
 =?utf-8?B?dXJnMkorUlhOb1FKcHo1d0hPSVB3N0xpTENHb3FNNXBLM0owVmJIdThMR2pw?=
 =?utf-8?B?amhwdUlTV3hzWDM4Mjh6K3FGdmNNdWhrYjQzRUxJdTBpMk83K2N4OTdhSmNs?=
 =?utf-8?B?dWsxbHBDemhFSXQyTE1LQ0hta3BXczd1ejF4dVdVQVdiZGMxd2ZVaFd2MHE1?=
 =?utf-8?B?TjZNQXNwcG5HbTg3OElncVYvWWZrbDF2TnUwTnFpRFgxem5SQmpYR3p3ODVS?=
 =?utf-8?B?Z3REbDFKeldVaEVXdnZueWVIQjZnRksxWUUrd09HT0M5ejE5SDVKSno4Nml1?=
 =?utf-8?B?QVhOZWlTQjJKMzI4eGVOU3dpWjBJSkR3a25SWm9Damo4d21qRmFrdEIrVGlt?=
 =?utf-8?B?MGFHQmNKa3BmYlE2b2MwcUxENStZemQrWWFmbEpBS1N5U2ROdnZMcEVMREZ2?=
 =?utf-8?B?bGNZc2lrK2hCcWMzWllHQzdTdm5tcHZESmNTNWxBeXZaZnpJNXZPQlBId1Nw?=
 =?utf-8?B?Q01HWWFRUU1tRS9FWjBaOVQ0WkZKQ29IazFyK0VNS01EcE1Bb2g3dzhJUW5P?=
 =?utf-8?B?b21KMFV3d016c005ZUNjc2FWSXcvTWlpNlM1SG9MRmlOV2hhdE0yTUZmL09a?=
 =?utf-8?B?NUUrblJ6bnZabk5iUC8ydmtWY00zL2QyNnc0czROeDlZb2NMcTlHNGo1NTdF?=
 =?utf-8?B?REgydCtwMkZNdUZ5WU5oVUVXR0tibVo4RFNoZWppQ1pibDRacFhhcnlQN3dh?=
 =?utf-8?B?SUE4alVNZmg0a2o1Y0NYaWgxOFBpTHpPVTkxYWJEQnVKWFBmSysxUWVqRVR6?=
 =?utf-8?B?ZkRLZmdlRm0zNWpTaEhVODREYkdaRU9yOFc2NzcxL3NBK0dNUTd3TG54NWwx?=
 =?utf-8?B?ZjI4ekpLOVo1bmROa2xudWsrOWV2aXBMVjkzVUZSZnFpTEhFVkFEdlBHalJt?=
 =?utf-8?B?K0wwTktJTmhEcHFtdkhvZElaWlY3S282NUZaRHpJNlZNeG81TlZSM1Y0aEdu?=
 =?utf-8?B?dmtKTFp5Tnd1Z1kwSXlSL1ZuYU54VVFHdGRpOVVCby9xYlB6WWpqWDBqQk5n?=
 =?utf-8?Q?3mqqbaLllzO9LjtAEovNxNNz8aqA+y3HIYtOhVORHWvX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa92229-5ded-49da-ea62-08ddd6e4adab
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 01:33:01.2626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0I2jYjxVKBTelLdRjmAtko1pN5kf9xiUDnjQA2bpgF3fkbJiD8Y5RlaYTEMOZkqfPI2y3Ewk95IUKxREkTQMNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8143

On Thu Jul 24, 2025 at 8:32 AM JST, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
>
> With `Refcount` type created, `Arc` can use `Refcount` instead of
> calling into FFI directly.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

FWIW,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

