Return-Path: <linux-kernel+bounces-888307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F4EC3A729
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60052350D5C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8212E8E09;
	Thu,  6 Nov 2025 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FwQWzCFc"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010005.outbound.protection.outlook.com [52.101.193.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB2E280035;
	Thu,  6 Nov 2025 11:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427110; cv=fail; b=Q/kXNZ6C2e3gsKhlwlsvC5TuXUPyv2gPxCCqN7OmHfTuAYoiuDqeHHB2Z5AI6MQtNYvcWGyQJteYqUyHul0KE/84CXasZuVbe0PTE6UXVco59pT54CxWkbizLaGKYzZIA3Cq44HNbZmqoVJa+2JS+hSAC8yGltNtI4uRq/jjnk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427110; c=relaxed/simple;
	bh=472wV1dTQOjdpCNB4LTKjzjRbhYXsBy/VjNyRwpmJi8=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=Kd2wRmmeq8VjQB1qB6PmV0uu+i1+1zrE368+0cfQsfFicHpq5RKLGKp6OQXI6vaePuklsCRAnAXRhm1NePpULAtOe1HLpdNgKToseg4KIB/98UDDjoBCkRqFELU7aG1YloISJRtPBh3GpDPJa47dz8CVdylKS/J7wi7lHUqMeIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FwQWzCFc; arc=fail smtp.client-ip=52.101.193.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tr7sd9/Uzep7IXVVJBI/7OtYHmgEUwgYOaZowAlPcle86+fdkaCpinUJfi9rnDmMLm96GXRTlDPBdTdeLJjGtqUB+MF3UAP2DYnFRCVio9P7tu4zE9cWYNwU+48mKXW3TosT6NvJEK2tfFytOUhblS8e/S+y0qt80ttQgNfSemmsRycYQ2/+RUZ+cGvECA4A8kNleZFVFlQHhtbcsnjS5ZgwyBbbC7HKrMdf4DniJLOg28m8BIIGaMmfzrLr3TNjJ0DecE/SwyvraOl4EOnRjn3Qt4mr58JAyVMJq4EFO2yHN4bboVaoUPpa/L90jIrwSRZb58Leho0NXnv6+Rg/xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9okCbxZyNqH4PsvFjLAgQUg5KVdNTc86QedodBEp0E=;
 b=Vk9TbN2s0600O9Eh+O0afvvDRSIHwyFHL9ens4B5lw7zK+R1DnazkPQZgaLeYrOq6wgZ5yxwomWVU/3+BP8AiwPP+R+Lt7ygXLZo0mr5/S8EO/GeYnFck1CeuLueNTHG9a0Q6atLvL7FCKc9N1XZrWn9OzGBIe/bcXmtv4nXsgA9lQVUqIZpGkRoLKmpaGLB9qxqE/cMPbR8lfWGzkmIFb4R0s0Ptuk/P5nGGtNEdGjxb3qgHXNKM4eUm6VCHgKG/I4oBkpaxUBOef4dYItwNEHVZaUfFI7cq9l2AJmqGPXlJnRyMdKNmVslUu9nPUwpr9RUbrkFJ03/1oH2nfFT1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9okCbxZyNqH4PsvFjLAgQUg5KVdNTc86QedodBEp0E=;
 b=FwQWzCFc06qSCD31mEYCcIv2sg5zrKPUdZKJqQKgUq1DropEOQFnCrvRHHtA1JH0+IjSXeKo/1OpsKcjhFZh1gp5M/+PwMMJjtXWcpC+hu3LDFTRbvz7oJvL1GoQxU7p/5+Tb2YcvL6HW5xdowPoyvVuUPxocJphVQRxC6JYBKHkees3BDg+0oAZk47HIAVMDV6L1fEGPaj0c5182wceMVM7+oIplcMbGdPu1wRVKgfa7VpwYe9Ap3ywumK7hEYo5qwLCZnqTWz2WLUKL8C/isgiUG1iku/4uEaFfTZdY3UyzPlZOncuiVns/tpxQ46RJvzh+Tq9DsE6xtYdwhcMhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 11:05:05 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 11:05:05 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Nov 2025 20:05:00 +0900
Message-Id: <DE1K9KGIQ0HF.1FIL2C2XHT6YT@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Jesung Yang" <y.j3ms.n@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] rust: add num module and Integer trait
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251106-bounded_ints-v3-0-47104986a5c3@nvidia.com>
 <20251106-bounded_ints-v3-1-47104986a5c3@nvidia.com>
 <aQxuXd0-EycU7p65@google.com>
In-Reply-To: <aQxuXd0-EycU7p65@google.com>
X-ClientProxiedBy: TYCP286CA0100.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: 626bc908-9854-4fe6-dd91-08de1d24570f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWRDdGt2Ylg0bktLb0VGRHRSdTIvaGNCNGJ6Z3E4aGhmVTk1b1ZQY3JsMHJ0?=
 =?utf-8?B?ekcrcGF5cEk4MVM5MWdlRjFOZzRDcEtORFBUczRLNjlWNlJKZitnVTFjVURi?=
 =?utf-8?B?cExOQ2kwbXBjQ1MzbjlBKytKVGU3RHdITlhYS3VDSDRUS1plRXpLRGtJVkUx?=
 =?utf-8?B?M2RFbUQyb2xKNWMrV0daemFBaUtKYXRCK3B1NDBiWVNUQXVUcmpTWk5WTS9Z?=
 =?utf-8?B?dXpobFJ0TmU2ajFPZlhpMGRNRjBJQVpqaEllYld5MTFydFMzZllEVit1WEtn?=
 =?utf-8?B?dkR1M2VUT0ViRDBFZVp5UHdrQW5kQmpwMldWOWtId0hYYWNkL3RNbnU1ZWk3?=
 =?utf-8?B?Nzg2bzNVVUVZd1Jod2tybzdKVGNsRWZjNFVaSlBzM0xVZ0NBR1pQR253UHdu?=
 =?utf-8?B?dkl5ODBhdkZMeGMzRVVYTHRmeldBUjVhVHk2Q0dOQkxWUHpEMXIzSkp3bUxl?=
 =?utf-8?B?dGpwZVc1UXdpbGN3TFNCcHdEa2tObHdLVWZZSmE3UEV4VXFnVlRud09rUFdP?=
 =?utf-8?B?TE9RS1ZlK0tVNC90MldiT0tmUFR2d2tSOEphOUJ6b2hhOElmRHhRNXViY0RJ?=
 =?utf-8?B?ZGY5OHRKZVRtSXNVSG42eU1FQm13aTQ1N2ZJZkt4T1B6ejQvYnlkM1JtK2NW?=
 =?utf-8?B?d01VcEZqRmhveGlJT3cwdUg0NXprdG1ybnlUUkZHam5WMzFsUUdGeURaUkR1?=
 =?utf-8?B?K3JQR3lQWkdjYjZCQ2k3Y0FtL0MrdUo5dHNaZFRsL2VIdUxFOGVlNmNJOCtj?=
 =?utf-8?B?SVpOVk83T3lHMmVGTkFuc0ZTSmdmamVwWjgvb0w1SkFXRmFSTHRDblBkUVBB?=
 =?utf-8?B?bC9BQ0dZVENmWUs3VVUrYldUMUNMN1Y0MkZ3d1BFcU1BRmw5Qk5yR3IwZ0o4?=
 =?utf-8?B?TDdXN3lUZWcyUlJuK1FqQWwvMVFqT1pqL2l3eDQ3TlJUM2theCtPV2VPYWsz?=
 =?utf-8?B?NUJiOFQvWlFoUjNXdWNDd3Q3RVU1MFBUUy8zb3ZLVitjMXg1WkVlTmhsTDNF?=
 =?utf-8?B?OUUrSmg1Y1NhK09lUlJ2MTlzSENiQkJ2NjdzNHBTL1NCcTllbldZQjJRRllC?=
 =?utf-8?B?VEZIOTdTb2h2dSs4MFJNRldkVTE5UUdvS1h4a0FnOVl5YUptV09lU2dHblYr?=
 =?utf-8?B?Qk9EbmQrT2xFc3VZMTRHaWlzdHdFOGRoUlNsUFppNmVPK3hLdkhsdHZ0Nklk?=
 =?utf-8?B?STMxR2tybktDbGlGdzJLdUNYK0VPeHNEVlpUUFdZaWdWV0FreFhvVXcyTGti?=
 =?utf-8?B?L0pNaEo2N2gxUytZZ0FxczFWSVFVSzE3YUtnNFk5QnQ3N0FTSmxMd2pjNUV0?=
 =?utf-8?B?T3h0dTRXR1ZMU3RULzkwcjc4bXo3WUVEUDF4dmNEbTRwZEVhTGxVcVB3OEt0?=
 =?utf-8?B?SDUvRWNVZ3pWcTBqWkdZeVNjd3JDUVRlaDZ5cnpibUVSNEc4Z0VNelZtK0xr?=
 =?utf-8?B?UkRwZktYSXNTY2pOT1NzZTdRTE1mOUFGcENiSFVwUWpNTVFqcTJsUUJwWW9Z?=
 =?utf-8?B?U1RZbDZZd0lLL1pCME83VkhSOGJ2MVRWeDA1RktlYkduU3VlTlZySEQ4amR2?=
 =?utf-8?B?S3dKTnlUSmZ1N2IrQW5tQjNVb0dkWGdRQ0E3OWJxcjUzNklaTkpVcmhzRTYz?=
 =?utf-8?B?U0RjTUhYUzNBY1pyR1NBRkIwYUsrTW1IZGJrNkFvczVwaXlRMjduRHRlRER6?=
 =?utf-8?B?Z09rOGFjNTNZbzRPckdONnhzenhXdHNidlhxNWN4UWxoUHRIMVZQY0gySWQr?=
 =?utf-8?B?ZUp3UURpak94TDY4bGUvaS9yeG1JdnByR2ErRlJDWXJDN0phSFdIR2NQNVlM?=
 =?utf-8?B?V0t3cStoVUU0Y2lVSXU4alBsRC92RVdWd2U0bDJDcVB1Yy95VjBVZ2ZmV1ds?=
 =?utf-8?B?YjVyTjFXQ1hBNnZlNjVOOUZzL2t4cUpsdkllVUJmaUNEcVF4bWNCY2Z3b1cw?=
 =?utf-8?Q?vDrPiiP5HDV/YFN/rn6NOWd3Hcc0dGRH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGJhUktrMTB1TW0xSnNKS0hVQkRhVEZSdmdtNGZHRFErc0ZqMk9QUUgwZWpq?=
 =?utf-8?B?QXFEZVNtT2hrenJKM1FZaFZyRUZvcG9DZHhPR3BIUHFodHNRUjc4Z1RxMjZ1?=
 =?utf-8?B?Szl0ZXpzWlZDR3dXSXBzY3dpaEhoNFp3djFMSzRLYlMrZ0ZueTFvbThwKzc3?=
 =?utf-8?B?bmp6b2FxZ1F2eFRaZW5haXcxTStKY1k0VVhnRVdHTmNYN3JWUlRIM3Z6eS93?=
 =?utf-8?B?MXExZFJ0cFRQYStTNzlIOGVNdE96eXFWaHpkRS9xTENGNVY1cGdGQWZVUnpn?=
 =?utf-8?B?Njgvb1BYVzZ5MWVKd2lKdUNvM3NTREFURGFtVmNlL2ZmTEhuL01qeFJjQ2I0?=
 =?utf-8?B?ZUZUR0NQaTRENHBJMGxweFZ5dWExeUh0TldHeUFoMHFub2REc0dDOHdUNys1?=
 =?utf-8?B?TEg3bEZ4cGZvekI4cVRDdzUxNXNhKzNsRmFCS2JmeGt5ZUJjeCt1QVp0WDZT?=
 =?utf-8?B?UjNPN3J5UWJIZ09tWUE1V0U1VTVFNmJDVkR4QjdueDNWUlRveFp4WWJvUEtD?=
 =?utf-8?B?bnFRNUxaYjJ6OTFDdE5XUW0xUGcza21KRTdjM3J0K3BVOW9hVkEwOHJmaEly?=
 =?utf-8?B?REhQeEZoMFNtUSt5WGgwcU1PVldHOFpuV2ovbkVqT0Jla3RCOWJMMGdjT04z?=
 =?utf-8?B?aXlsSHplN1YwMGd1VjNsV0w2KzNlWU9DcFNCbG05N210dUNlQlAwZW1NMkJ1?=
 =?utf-8?B?ZUV4bTA0ZEpMNHBoTWdVRERUS1ZtUE1TeVdqWjREUlYrMEZvWVBnaGFNdjJs?=
 =?utf-8?B?alA4QjN2cUNmVmpTNlZSNFlXYXMzZDZVUnI5T2Q4S1lTcy9yQlp2TGZUb3di?=
 =?utf-8?B?aUtqb1Y5L3gwejhQdHlJRmJjQmxLVEFVSE1vQXdEc3VGR3JVc2hZemlxbUs3?=
 =?utf-8?B?RmludkdxT0pmMTBzYlAvMklrcEJkS05GR0V1WHh5SHpndGx6d3A3aWYvUnZV?=
 =?utf-8?B?eTdkbVRvMmdmUTgvSWJ0aWJVTFlhU2VlUHhBWEdaQVNaUmdxVnVEM09CNzhF?=
 =?utf-8?B?UmZBQllyeHlvZ0pWTGpjbXBFenVlOUZmRlFnamtDR2Z4WkIvcDBFSy9rNXFT?=
 =?utf-8?B?TW9yVGlHRUtucXFWVnhJanlqemd0UjZYdi9Cb1JvZ2NpcXNBd2RrS01XdDA3?=
 =?utf-8?B?MklrZis5UFZVS1JTcDhBcUpndFlDa0pMKzlqRFkxaXNzblhDeG9yNU93Wmh5?=
 =?utf-8?B?UnVubUxYMkZ3MVhQS3NHWkRia243K0d0bGlSM2xGSEMzdDYvckRHenNwWmFy?=
 =?utf-8?B?TWQyeGxWcitmaW1WWm5GTHJzWC9SSzgrU1dKcEIrakpyZDVKcEJmQlVySmlh?=
 =?utf-8?B?OUtXbXExcHkwSzVsRDNKcGl3SEpZM1Nram9VR2ZRa3lZeWJqUVB3RjdVUkt6?=
 =?utf-8?B?dDhCTldGclJIQ1pVblpyeWxtTTc1bUpBaFArM0F2R0dXWWVVenpSa3dFbkNO?=
 =?utf-8?B?cHR5N0ZiT2sxWGg3b3ZkczBUdEt3N3FscCtXek1qNmpJOU1lZEdybU5IM0Yv?=
 =?utf-8?B?OEdHRlo5b3FrV29LcnlMdWtHcW1YNWpORHQ4WGMycGxrZXdZN3lGSmlWV0xQ?=
 =?utf-8?B?bTloeUxBNEU1enpzeEJjeXprR1dqNFBGRnYvRldwbkt3QTQwZ2FBUUw1TDdG?=
 =?utf-8?B?S2htUkMzeXBHY0k5NXp4QlFkcEtEL1pRdzFSVHFwb0ZTMy9pNTVtOVN0ODhv?=
 =?utf-8?B?MHZBZ3FzSUZDLzJ4UkIwMkxrdXNNcFF1c3krYWREYWFxaVY0K2QxK2R1b3hy?=
 =?utf-8?B?TGNadkVPR2FnTEh0dEtBUVBKWU1KMS82Rkl5cXU2dStVTWEvTFhxOTNVaWJl?=
 =?utf-8?B?RHVwalJuaVQ5L0JvY0RVRElTa3dmSysxUHZuK2trU1pDYmo0enQrQURnTGtj?=
 =?utf-8?B?SGpUWi9wRUxzd3pXaEE1dXFldnh5SkZqeU9BMGFnbHNBSGJRTFVpSGk2NitM?=
 =?utf-8?B?Y0kxeXRvdndLbmxndFF3azNWcHJ2akExMGJRQVRqbzBBT0Q0U2FFREdIN1FY?=
 =?utf-8?B?MzFzcUhVY09xNmVsVU9GVk9hTVNUZmJCN2lEYTV3dUxqSVA0Q1l1cUJNZ21B?=
 =?utf-8?B?UlIvWUZIcHFFOEU0Q0tvODNFSTRBZEdqbUFKSGdqOGNvc3RZRDFxNWd3TmtB?=
 =?utf-8?B?Mm1mTVRRQVBzUFFoUnB4TkJIWlJSbG5jZ0hvbGhqWHFGYStRQmN6akE3cFlr?=
 =?utf-8?Q?Vb8Yvf8jP3lfCiZcX9DGLXNsD0eIXqgDbNUxtrnRI32S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 626bc908-9854-4fe6-dd91-08de1d24570f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 11:05:05.4823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3H4lAjUMkbU8PngcRAKZQtBdTEDUb9M/ifXDsGaMo7IbZ8MYJOlAj8St+K4PyfaRt1/sKbHhyh6zSlPVcBf+7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8641

On Thu Nov 6, 2025 at 6:46 PM JST, Alice Ryhl wrote:
> On Thu, Nov 06, 2025 at 04:07:13PM +0900, Alexandre Courbot wrote:
>> Introduce the `num` module, which will provide numerical extensions and
>> utilities for the kernel.
>>=20
>> For now, introduce the `Integer` trait, which is implemented for all
>> primitive integer types to provides their core properties to generic
>> code.
>>=20
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  rust/kernel/lib.rs |  1 +
>>  rust/kernel/num.rs | 76 +++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  2 files changed, 77 insertions(+)
>>=20
>> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
>> index 3dd7bebe7888..235d0d8b1eff 100644
>> --- a/rust/kernel/lib.rs
>> +++ b/rust/kernel/lib.rs
>> @@ -109,6 +109,7 @@
>>  pub mod mm;
>>  #[cfg(CONFIG_NET)]
>>  pub mod net;
>> +pub mod num;
>>  pub mod of;
>>  #[cfg(CONFIG_PM_OPP)]
>>  pub mod opp;
>> diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
>> new file mode 100644
>> index 000000000000..3f85e50b8632
>> --- /dev/null
>> +++ b/rust/kernel/num.rs
>> @@ -0,0 +1,76 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Additional numerical features for the kernel.
>> +
>> +use core::ops;
>> +
>> +/// Designates unsigned primitive types.
>> +pub struct Unsigned(());
>> +
>> +/// Designates signed primitive types.
>> +pub struct Signed(());
>
> Since these types are not intended to be constructed, I would suggest
> using enums so that they can't be constructed:
>
> 	pub enum Unsigned {}
> 	pub enum Signed {}

Ah, of course - I thought about having a private `()` to forbid
construction outside of the module, but the empty enum prevents them
from being instantiated from the module as well! Will apply, thanks!

