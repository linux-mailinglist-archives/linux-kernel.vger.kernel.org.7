Return-Path: <linux-kernel+bounces-745150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7C4B115B3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 03:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43FD2584614
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C694D1D5ADE;
	Fri, 25 Jul 2025 01:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VEcVBL0Y"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600D81C549F;
	Fri, 25 Jul 2025 01:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753406419; cv=fail; b=BK9TpP3WC7RVjk3/4SHEmjjWklVRApnxaI3I8GezbcazFRDWe6IpRdqpklHdJ+aR8fr0uuvDD0g9YHHHq1Yrlop09TTStvmW7bSnpStGl1d++Iz+W0I2KT7mnHSZfjoRqas6IGPFTcAFMfIhGeg0+vpBJWFrBzAb7IYATfDB8Hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753406419; c=relaxed/simple;
	bh=SvYaKZKn0hDFMoVJUWQPURnxY1vwrPCDYpsRn8O1zf8=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=Spyr36rLNwzeQxgMmTyppMs4UoSgMvCCKSwwx+gSJjw53Djeemn3zHW0e8exqPSG94CeW5CwRv4Mw2/XHEQNA9XbPh/+kJJeEQpcYkC6UhHrvOarLzcmlOwbbF/KjiXjRInCSAeMHB5LqvXqJAMYfc1j6ALDSo2zQIHbl9psggA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VEcVBL0Y; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xp6oYGNIIJKqspRt6DpgFWy1jrWBbvCQPfrweAr1IJI+iF4cRXkinROabwQB/+hlmM816jIgLZpW0eOw6NPAfRzbZl6bw4HaLo8q0FUpUnbtRDW5h3On2YoY1Z109E39Mpzpwk7/dVLKMf53K7KRzkQ0ZHsyob46SF7QkJp4a3ly/zvVKnRjaGvzM22EjhBzO77dORlC+hARedYUYm1in7SenNnah4MjUJniNX7ymY44tAGJXp/PRI+fDLFtxbdOmvz/3fJTaSslfLBMwehZGh10T3WcrieYuhOWKE+wT6hlRxweN56bTZnzN+T8AgWCUrXoMqwZWQ9lj5vDODsTyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCmHctwdYEh7Xa+sjtFc3mQ2EQ+c5isfsENj2MwSD/o=;
 b=EhotnMEkV2huzQZZR/VtYqqBz4o/uAkFEzC4Zs/M59WABKMYoc3U2ErsT4BLQX7PlyxcYSGHeQ+EkiCjE7Jb9I2vdAJsOVkrmwS2y/p6MZQstk0vLkasyMzL+Yl9ntNa6QyY6JrYCFWFEcyMgme3XDBmg6zE1qzRJ/h0CG3HtG+PCq25MyfTWuvJk28FG9lxV9DGTqVtIwhIkl0QqRa2i2vihCWy8donEd/sqsA/DY/gb2+q1pxL5wRg9jFriU7GQ6sEHpaFUlnt5yyHisb2iXjOY5O1l2w/tWCAI6BJOwZFlNS+rQFhlqAARQdUdzL09HmDNAmXm4cBlqlvgftQcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCmHctwdYEh7Xa+sjtFc3mQ2EQ+c5isfsENj2MwSD/o=;
 b=VEcVBL0Y2FGm/H6z+YhjF28LAbrNzOb3dzp9X2KNbBnMWV63QoX+sY567IcHRFvWEs1RxLR3zvoG22TxE/wHJBQoCDszivZMbiJm/I3FX2n/oxEKVjkW6IUkpOqFoHGW0PTatlVHuqTQwP55MgKfVFN3ewXmgY2d3gOmalZaBICtvDFvXBsK0zzaPQqioookS13Iu3pes4nlQyA+VZiFpMlUnSi8n4l48wpCLAvQBOPaCrWnwrn38Ta1LpMdqDnp2t9WjeaMaGdOSUHIByJiPQ/NUsIQ+Uj+ogRKOMQFtIg2fCuZ7NpDV537AGN3pXtma4o7G/37ZoKQNHTA0W+IIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH0PR12MB7959.namprd12.prod.outlook.com (2603:10b6:510:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Fri, 25 Jul
 2025 01:20:11 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 01:20:11 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Jul 2025 10:20:08 +0900
Message-Id: <DBKQP426YEFZ.3EBGU020XKF3M@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Lyude Paul" <lyude@redhat.com>, <rust-for-linux@vger.kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Boqun Feng"
 <boqun.feng@gmail.com>, <linux-kernel@vger.kernel.org>, "Andreas Hindborg"
 <a.hindborg@kernel.org>, "FUJITA Tomonori" <fujita.tomonori@gmail.com>
Cc: "Frederic Weisbecker" <frederic@kernel.org>, "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>, "John Stultz" <jstultz@google.com>, "Stephen
 Boyd" <sboyd@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 2/2] rust: time: Implement basic arithmetic operations
 for Delta
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250724185700.557505-1-lyude@redhat.com>
 <20250724185700.557505-3-lyude@redhat.com>
In-Reply-To: <20250724185700.557505-3-lyude@redhat.com>
X-ClientProxiedBy: TYCPR01CA0172.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH0PR12MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e97c2b6-7507-4b73-13ab-08ddcb1966cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1B5SWkzbVNwUUptVTFPMkk4aEQya3dOL1NDUHNLOXltNjRRUjNvUFZVbVF4?=
 =?utf-8?B?THU0OHFkaDhPa1JnRldJV0ZvWlovQjN5OGh1aU85c0x2dVhlR0Y4NFNOTG1O?=
 =?utf-8?B?VkZEUlVXNVVNeUpTbld4aHJCUmlNdURFZzZMRWd2Q2lieDEvc3RxdERQbXBS?=
 =?utf-8?B?eGRzZEZLaFNpcjhaRTdaV1BZVEhBb3JtMDR5amRjdFNHQ0FzRmhSZjJTaVBK?=
 =?utf-8?B?WVpLMk1laE9mWWtBdkJNOW9jQ1NnbTRzWk5XcW5PcU51ZFphTkI5eExtbVdW?=
 =?utf-8?B?dS9tSUlPTDdsYkppTytNMFNkSUlhNElpMWhScGxKR25UOVgvcTFHNXhUODhh?=
 =?utf-8?B?Rnk4MFJSSER2Z0U5MG5lMEUwbnRoYXg3MUxpSHlYZUp2TDZ1VGxDaGh0eDF2?=
 =?utf-8?B?TEpTckdUMDBDbE5wWGY4YmEvWTNQS1lEd2RJTThIZlA4b2hLVkI0Q1h5b3NO?=
 =?utf-8?B?QWhydkp5QUNoS0ViNmNjcFh0akxJVklwTDBVcXNMSmlFZlFYQTNodzVxdW9N?=
 =?utf-8?B?T3lpVTF5a21KWkN6VmMvaEx5MGJtNktYYmtLVVpiTWkvSUpwaHBqUG9PRHVU?=
 =?utf-8?B?YzBKalB6TGtuU0hsQ0xvNHF0RDAzY2pQcVNzQ0k4ZUVKTGpReTkwQTJkYUl3?=
 =?utf-8?B?Tlg4SVBtdHZ3Qk9Fem9mWXZaKzVIeC9wRTNkSVlwZlBCNzkveDVsRDRFY2Jn?=
 =?utf-8?B?YWloWjBiYTlTK01uZlB3UjVWOE04ZXBYNzZtN1NIRlZoMHRVSktHZlRvcllo?=
 =?utf-8?B?YitOd05zY09XaWlFYW5mNUlSNVlET3Q3RlFNRk5neEVOS3FZNkVVbi9VVEg5?=
 =?utf-8?B?a3ExMk94aGgwWk56Nzc3bEx3K2tXdldvQUxjVWxtOU1ZUWpmMFRYTFR1VGhE?=
 =?utf-8?B?SmhLVVQrdVhjbm14RlFDYUg4Smg2NmdXc1NFamZJemVObDFicjliMXo1NlJ4?=
 =?utf-8?B?Y2Q0VGNGUzNkdG9CTkIwbEh0dEZnbmUyVk5hcThpWkttV2VUdFJ4Vzd6bm10?=
 =?utf-8?B?cXpJM1ZzUWFKRERmVk5IY3JSakJtVWFybHM0VlZXK2RBVDMvVmxmQkVSVDlT?=
 =?utf-8?B?Q1M3QXJGV3JwSGJldlpnQURuTkFrU1FaRVg5UFpORDhLa2J1L0U2dlE4aXdX?=
 =?utf-8?B?VUs0WGNIeUFRSjlTclltQWdtWm1EM25PMHhqZkdtZU9Tb2cxelVoOVVIU3du?=
 =?utf-8?B?b3FrcEFWOFVBMXg3Qmt1dWpNaVhiYjhJMFlLNVZJMEJYMkRkRVZWTWFDQy9m?=
 =?utf-8?B?MXhSQXNLMmdDbXJRSzFMMWNIUnk0TFI2RGNnZ013aEM3dExFK0c1c010VDcv?=
 =?utf-8?B?aVhvR1pJbWNEUjllV2NZSHI5STB3KzFmOHJVeVhvRmVEc3lnT1Z2US9yU2d0?=
 =?utf-8?B?VzlJTnVWL201MjJIQ0IxeGxqWm10VE5wa0hGZnNTRmtYSlMwM0pkYU9ueXAz?=
 =?utf-8?B?dzlRdVR2UjIzakhqWjZqY1lGRm5CL0pDYUZ4ZzllOEw3d0crTmFoYjBDL2Nq?=
 =?utf-8?B?NkoyamdadTY1a0ZQUFFsUTZMenBFYmFWM3l4VW1IZU9lMzhjWlJZYkoyNFM3?=
 =?utf-8?B?MGF4ZnAvemVKS1R0c3dvYm94NDIyL3MrNHhsdUdqR2kzbm5OejZwd2pDVmdt?=
 =?utf-8?B?cVA3ZDNjbjlBbUN2TUx0aFZscVZyZm5valZrdzBXMVM4RS9kTDFuNnJEZXhk?=
 =?utf-8?B?enhma1NGUE1YcHFxVlEzYTMwdjRsbFhCVEdGWW10NmJPaWZmTTgrQ1FqK1Bh?=
 =?utf-8?B?RE9hRnplOGdMLzRURE4xL1BzM2tFMFZFSGxyckc3K0lYQmRzbzlic1R0ZzZn?=
 =?utf-8?B?ekE5S3Z5Q0xXWUdiZmNZRDF6VjRMd3p5Zk9rN2czdVpMbDRoRkwveUg5cFJj?=
 =?utf-8?B?ZFc5cW56RGVDMVNicWtrbk41VkJkVkgvclpab2Rpb3JkbVJldllZd3dOd0dw?=
 =?utf-8?Q?xyCqHtNb+p0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THdLR2Y1THJiaTZQSEJFcC8vVGU4QlNpWjY0THFyZ3FkVk81dVVVbTBYQzU3?=
 =?utf-8?B?TmVDTGpPcGFUbFBuWmg1aVBubkZVMjd1SUtEN05VSmVCRElzL0g2Q0hvc0RC?=
 =?utf-8?B?Z09wWmxQY3QyNlIxUFVaSVk1Mnc2UE5PUDYxWENHTXBDQk53cjBkd09ORk1Z?=
 =?utf-8?B?MndPNlRrMEdGajhKbFI5eWRsZ2t0a3Qvblg3ZVRBQ3JtVEl0RjNJaGNKL05l?=
 =?utf-8?B?bTdsN2xpUFB5RDJPYXVoWWZ0WG9YeWFCUWFGZFFkSXlGMEY2anVuMUlUNFNN?=
 =?utf-8?B?R29DUG5GWEh5Q3dGSU5WVnpUTFNnNzZpeDZhdmF5UzdCbTFtN05vYXV2Nkdz?=
 =?utf-8?B?SDJKeUZ0akcrTElacnBYcm0yUGdYU1Y1eVBpY2ZGZG56YXJqVCt3VU4yNVc1?=
 =?utf-8?B?MmJ1RjV5cklOTHV6VHpuc09ZTmlkRnJoRTNXYjF5YUQxZmpzOENvRWxxaG5P?=
 =?utf-8?B?L2ZmVjNOWG4vc0JOL1dYelR0YXNoZHVuS01NNGtIbEF3aSs5UDFQUnRXQXE5?=
 =?utf-8?B?N0JYb0hXUkdDU2czZjdUNWxicUhIUEJ0QWJaSjNsYUw3SE9idE1MR2xtRUJT?=
 =?utf-8?B?VzY1ckVqUm9qR2plR2ZENEVXUktiQ3Vldzk5UDlJekpJa2x6MTdlaHBmQlVx?=
 =?utf-8?B?S1lvV3dkUkJEekRRbUJjR2ZjUVBOczFtbldLdlV2SlAxWUNzL042YlRqdGkz?=
 =?utf-8?B?akpWQUlvZDR5cGU5aytNTGJZa3Y4OEorR1YwKzRXNHhCc2FyTEQzN2F4QkZH?=
 =?utf-8?B?NUFBMEd4RHVKTHBMKytHNFRBMzB6WjYwUlFqc1FSVWNuTk5PbnN6MEtBS1VQ?=
 =?utf-8?B?Z1hsR0JzTTVLdzdMSFJYQ0kxYmwxOWsxWGFlL2thR29WZ3BFTkxsSU9hSExt?=
 =?utf-8?B?TlpUajFaS3pEZ0M2R3hYaDVvbXFMUVZzbzVtOHRCSmt2MUgrUjV5OUJFOGls?=
 =?utf-8?B?dWJuVGdsVnRsRS90NUUwdGZwOWxvWHB6eG94WGRYYVk2NGd6NXAzN0JPM0hW?=
 =?utf-8?B?WnNneXFML2ZhRFFTakdOaVZJSGVFalhJbWZBN2hmQ2dsaWNjUW5zM015TXNh?=
 =?utf-8?B?eTRRWkNTYWp5dmN0TVVRcUVKSk9SYlRnVjkrQVFCSDNtQWRRMDZMTUFMQ3lY?=
 =?utf-8?B?RDFNTE55UXUyclcwYisyK3BzTDFLN1lVS3NheVRrSEt3Y0Jjc2YwZTIrZkJp?=
 =?utf-8?B?TGRidDRWR0h3VzNJMndmS2g3UUpnYWcvNFZ4aUpabTN6UFNnZjlKaVZxSFBO?=
 =?utf-8?B?a0dOY2x6djVYN2dvd0hnTWNIWlNpYTZPaVBueVpsMkx0dUtxeUY5OWx5NmVD?=
 =?utf-8?B?K3VEdnpmK1JSbjdodWJjUnlsVHV0MHNFTzBxUml2azRSMGRrWVlzbEdHd1RH?=
 =?utf-8?B?ekxodk5EaDZocldiNXNXOVFEUzJOLzk5QzcrZk9FN2VyWDk3RkNHb2dZRnJF?=
 =?utf-8?B?alZaNTVBMHZSeXYvZkZTaExPMXA0YTdhZ251eVJsVENmbnRWbk5yaHN5WmVJ?=
 =?utf-8?B?b2hXTGU2eFZseENvY25ueGE3MTRDcVVHSkZqclJwZ21rQ24vUWdtZWZGV3RU?=
 =?utf-8?B?Y0U2aGZiR1BPczhMMjhLRTk4QXg5ZmFGOWlocUsrdktpbXByNmIyb0lHckRL?=
 =?utf-8?B?Y1ZHdVI2TkpCNlNXUWs3RFZ5Vm9HWk5LdTBmYkJPQjcxYVI3Q2l0OW1ldTk3?=
 =?utf-8?B?bHBWTmZKM002dFZ3SnMra1FwQVcxelpMYmdJdGZiU3JZVjFFcE9kMzhyT20r?=
 =?utf-8?B?WS81TEo2VmF6WGR1WEp0bWhiZGp6b2o0ZW4ydGJMRVowSUhLTDBNR2t3TTdW?=
 =?utf-8?B?U243b3RDTWpkcXpvK0VGQnVpUlpzempHRCtHRmlibEJPRE81Y1dRRkd2c21k?=
 =?utf-8?B?aXV4OHJjbWN5dkNBRUNsWDNiVVp5bnhTdUJQVVQ0bjg0T1NqWUFHV2h4SS9D?=
 =?utf-8?B?Slc3VjlNejc5dnJNUjd1K0lsVThodXhyWmRjS043MEw1U3NpajlpY01ERStT?=
 =?utf-8?B?dU95ak9XQzVUSFUxQkh6eE5pSHZKbEJNN2NaOXIrdG1RUndGVVJTc3VYcEpm?=
 =?utf-8?B?NFE4MDJYMFVhZkFjMjV1b2s3Ty8ybVZ5eXNVdVI0Wm1tTFhQMkRxWGxKZUNF?=
 =?utf-8?B?RWo0R0lrMnNnUUFTTGJHTjdnNTdCRnZ1Nnl0aUxEazlnWXJZcHd5ZE5BTDZ5?=
 =?utf-8?Q?uXVO5aidHsnHNOru6VxtIChH+dqzHpSQR6kc3gE4NPEZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e97c2b6-7507-4b73-13ab-08ddcb1966cb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 01:20:11.6939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhSgmQZDie939b5Ip/deOcUPD5s2QIrq6/UypyDsk8qxNIJL4+s4uZPXoMwxi0qEwrMwYIWfbS2jLonnFL4VgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7959

On Fri Jul 25, 2025 at 3:54 AM JST, Lyude Paul wrote:
> While rvkms is only going to be using a few of these, since Deltas are
> basically the same as i64 it's easy enough to just implement all of the
> basic arithmetic operations for Delta types.
>
> Note that for division and remainders, we currently limit these operation=
s
> to CONFIG_64BIT as u64 / u64 and u64 % u64 is not supported on all 32 bit
> platforms natively. The correct solution we want to aim for here in the
> future is to use the kernel's math library for performing these operation=
s
> so they're emulated on 32 bit platforms.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  rust/kernel/time.rs | 86 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
>
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index ac5cab62070c6..8ece5a5d5a11b 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -251,6 +251,92 @@ pub struct Delta {
>      nanos: i64,
>  }
> =20
> +impl ops::Add for Delta {
> +    type Output =3D Self;
> +
> +    fn add(self, rhs: Self) -> Self {
> +        Self {
> +            nanos: self.nanos + rhs.nanos,

Should we use saturating ops here as well?


