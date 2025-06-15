Return-Path: <linux-kernel+bounces-687205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF244ADA18E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jun 2025 12:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1E916E8E3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jun 2025 10:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF302638A2;
	Sun, 15 Jun 2025 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OBdxtMX1"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2847A2E11CB;
	Sun, 15 Jun 2025 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749984674; cv=fail; b=qHahZZYN7m5phpzsygiozDydjpXUXafeA2XTE8rtLy7OsI8hCHsPh7Ffn5g//cAU2jP7BQTC9oxHwTHm9oCswINbT2dxsyRwTuXMDJUxlnTC5AeIQSZwyGoWSxeAa5wSrBjFiIFCk+vz2kw98wFECbnHMUNi8c2Mypk7/qYDvWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749984674; c=relaxed/simple;
	bh=8wQ95+7v/qbDPRUsLiZQzrt/ahByInhSeZRj79+udmk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=GuQB0tOWlyB8NFE7Qy/PWHiarrM7bHhgCvvTRZIxOim4B6P8NVksPxm26S+hgmNAXKrxdZTBSvjc5yGpFev2qROOjfV1eaZrBL5zxQ/+/T0zDXRC+l4yQuXPtrLjB263Mh1LfPwmFRT5faeuwivngZmSGrm5j3RT/flbE9G5IhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OBdxtMX1; arc=fail smtp.client-ip=40.107.96.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqJ2TBjOCXXZ1UZ9sA9Vr3JBi7oJWLq9lvByy9vBGtew71Aro9egmtXbrTw3vXkHNLibJptaGdx3JmCtL26hAIh3MoHuWIFZXjCWx+FRdaaRRZi/rreodYCOKdVi0VnJh99GG4AGlzEXEwxoZITXe3eoty0chE0IxrDiREE0nL+SMBZZfh9ZnPJGfOSwlk+UjKDzZN/By6OYDRO/FIRyit2F5PTuRHjPCaPI6HegnlocaiV06rB9TYtnR6KqlNSxBP40Q6Q1F485EDNTZQ4ulDxLdOHU4Imkf2yTET36BAeOZJHAPhblpmk4zAQvK1jY8DjOatONCXhFXk/eEl+59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COG+RycvWuJkTeQ84CeFtHmh40C27mNKLJWoxX/guAg=;
 b=Yxfu77lpMglpxeeXVfA7YuZ2HcbXObxhNZLKl0BUwNij/ZGYpeIWJt4+6WOQ0wc/zwN9+aU6KAAiukrjVm8ZZM4XF9dQeQ0DTu74yrbk3WppETirRxb6zrC2xXCXdhONAT802ht8zDMe4aAe4/myMDiJXo1HS2D5aII719jwI0XHeyng/Ie1aKucxjCAh9huSChnCqTpvifzv5UCriu7+tsot+s4vtKMsY46cxiKG1n8LUSOawGyBfujEBe+ox6Y+im+SW/yjhN0O15BsmEVfoRLlLNPp310JM9KrwNpD6JmHGqBY9iX34FaNl55bxQFt3+VVoHLYZTPGxnmmAJ8XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COG+RycvWuJkTeQ84CeFtHmh40C27mNKLJWoxX/guAg=;
 b=OBdxtMX12ENu1NDblVHK8NDKXqzATtXYBv+jnh8nRerAUND9ITbgctgkKtg/G86eWb8UzXoB4KQuvrQnPX0EctMnDkNd+hgPSaQaNQUr/8UveeKNSEjFqt6zdtr8AUKnSGQ4H/vhgA/WSOypgRtNdxdcBy3w+Vbx80GfJmREGdK1OLT9ErX4WrWZw1JdzM1PP29hztTyrCO9NLTyQZJBJb9c8VT67wsMi4k2YC9UEja/pOhVdnnxlyp4i4ilUfzMzxKBGEYimq5UuDdxH8iQXGTOYJtpFx5P3NIL+1x2CmyfpPIO/VJ0HdVxov74VzL0rhoC/mOXZqHm9Ga3MEo4CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by LV3PR12MB9257.namprd12.prod.outlook.com (2603:10b6:408:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Sun, 15 Jun
 2025 10:51:10 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8835.027; Sun, 15 Jun 2025
 10:51:10 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Jun 2025 19:51:04 +0900
Message-Id: <DAN1SGG5DPVE.UUW0B523LQHO@nvidia.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Benno Lossin"
 <lossin@kernel.org>, "John Hubbard" <jhubbard@nvidia.com>, "Ben Skeggs"
 <bskeggs@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v5 05/23] rust: num: add the `fls` operation
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250612-nova-frts-v5-0-14ba7eaf166b@nvidia.com>
 <20250612-nova-frts-v5-5-14ba7eaf166b@nvidia.com>
 <CANiq72=3nDR=J2OXu9nWwZW_kcWfZ4KhZ3aS12_dcB=1EP2icQ@mail.gmail.com>
In-Reply-To: <CANiq72=3nDR=J2OXu9nWwZW_kcWfZ4KhZ3aS12_dcB=1EP2icQ@mail.gmail.com>
X-ClientProxiedBy: TY4P286CA0008.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|LV3PR12MB9257:EE_
X-MS-Office365-Filtering-Correlation-Id: 4198ec15-2a65-46d4-b63c-08ddabfa8993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDFiR0tqR1lrRzhic1AvckxUK01nRXpjdC9CMENCdmpJK0l1emh3ZUVKOWRx?=
 =?utf-8?B?Z3A0YVVyTUI2d05yUHA4K3ZNYmMvallCYlhFVlFMWGJCbkVTaTdUZ1VBaTIv?=
 =?utf-8?B?Q29qSEJ4NjU0R1V6SHoxb2p1Rllad2JxRnVmcUpGRmFsK1d2eGd0Nk1tenNh?=
 =?utf-8?B?MEo3Wlo5eURmc1haNFZOYVdKN01LVU4wOTZBazlLbUhvQVA1VXQxbGMraHRJ?=
 =?utf-8?B?MFFNQ0twb0VtWGVXeTRkcWxJNURFU1oxM0lGT3FOaHh5bnQxYkc2VWF0a2Rm?=
 =?utf-8?B?L0JQcTA5Y1F0dHIzQWxIU1A4d3hGOXdhUjdWNU5VUEZpaVRSRnFTR2VBSysw?=
 =?utf-8?B?c252c3p1MjNwdVBNd25aOWRGWGRtNVEyNXNaZVRvNFBXamZhUVdnS1krWnFw?=
 =?utf-8?B?TkhiUHlodkxHTElYSE5FTk5GRmUwd25DYjNVZCtPMVRLTXF3cWI3OFMvSG9D?=
 =?utf-8?B?LzdzTlJGQ2pzYXNycmpUQjRMWjI1ODZ4NllNTDhGdmVtWHplZTUvbnlaWFow?=
 =?utf-8?B?dDR4MXdCNTBITSsza0VLUXgxRXFGbWpabWNTZkx5TlQvSnNtaCszWWV5bWRC?=
 =?utf-8?B?eVcwT1Z2ZWI0eWZKUngvOCtPc3pKZGJvdlVJT3h3SWloTm02MzRvTmY5aVpk?=
 =?utf-8?B?Ukdvc05NOEJBV1Z5ME80dVpnUmhhenZkTlN5YXFiNUM3Y1EzYmhFMUdGbTFL?=
 =?utf-8?B?MEFKL2ZSZk0vM080MEEwaHQ2VTVIWllQWXVsRXEvd00za21CWXVqM0FyVVhz?=
 =?utf-8?B?R1Mxd0JSdDlyYlVYUGNWRmVpK3FyQkhxYmJiMG9EYU03c3YwZ0twRmJqbzR1?=
 =?utf-8?B?bS81WFM0VS9RMW9rem9tenJZaVIrU0ZuRFVuclNJeW5kVVRSSWpuN0VrRmp0?=
 =?utf-8?B?RWEwdGNnbG1NaFBSU2JkQU8xeU5idXVZWm83RWYwbUpIamFtV21LWmN3U1U3?=
 =?utf-8?B?RGd3Njc1RkJ0WkZyd3p6ZHFpeWhzaDhtTnFheXdBZitHNmllT3hpMjdqMG9s?=
 =?utf-8?B?T21weitsaGR2cXZxR1ZCbWJzb1BmUEgvVy9CUGZIMmZpdHBrZXRYTTFHUTB6?=
 =?utf-8?B?SXE1ZmN6K0VDMlgyc2NCUHFDbC9wRUl0aXljRWxoQXBQTlpZRThmOGcva01o?=
 =?utf-8?B?T3VnQWE5dzJGbk5kOEhJbi9uT3NJQU9FcGhKb05vME1IUUNXcXYvZlM2TGta?=
 =?utf-8?B?bDM2N2JzVy9FbkNvZ3BteWdMTmluNU03Vkc1WFJPTlhxUnJBb1QwVTk3dmVp?=
 =?utf-8?B?NFJ3WUlTQlAxMDBvWWdZb1l3ZTIxRWZRaTZwcVRuZjA3dnZjd0dXK0ZYMm56?=
 =?utf-8?B?WGhxaVdUUzNRMFl6NnJteDViWnI2a0V5QzgxTmhFWjJTS2w4WE42SzQwZ0Vq?=
 =?utf-8?B?SmRCQUhkemx0WWh3UWJ4T01hRFZpQTBYWHFKMi9VZ0RyRmtJTE5CcUE1Ynpt?=
 =?utf-8?B?dnZKQVRSSmp4ZFc0Z2ZDeFUvU0VnVCtFYm5KRFpRMElZdGhLNGNiUHh2d0tI?=
 =?utf-8?B?dEpNNHRSSDRIbVdVV3B3Z1BKL2F0Z3diamYyNnl4eUtpZm9iZTh5dk9SUVNP?=
 =?utf-8?B?WHVZL0FXSFM0c1pQYVNLUy80c2FKWi9YSFEvREFneGlVWm5UME5GUy9JVDAv?=
 =?utf-8?B?L1pGRUp4Tkl4RGsrSjMrYVM1azRzaEdLS2JrcmxrUjhOaGY0RmxzZWRIZ05M?=
 =?utf-8?B?NU42aFQ5TFlSZTdYNUF6YW5jYjllalBRV2Y0elgwSXFvZ29FV0toUkhJTE5Y?=
 =?utf-8?B?U2dwS1oxV0lrSEZxeWJMYTJuYW1EbVFPWkc4M0R2UFJUekl3K05OVHhsV3M2?=
 =?utf-8?B?elBxNkgvL2xrd09zbWtxdGtnN1pHMzNocHpxeTRHazFJTlZKQ0ExKzBFeG9K?=
 =?utf-8?B?N2NxUUpISmdwMnVjRlF6SkFzaStZZncvSlBBWlFNd0xCVXRsZlQyT3BFTjVi?=
 =?utf-8?Q?EI1E1ciF72I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STh0RUhxSEgwMjlNd0Y5TUNqS0xaK2VKY3FBK2xtQlpTdEV4Y0FZczhaYzEz?=
 =?utf-8?B?MXNxbUY1ajlqM0drQnR4MHp3VVBIbjBLczk1b3RrV3c0RWM4dzBuUXpKOG1F?=
 =?utf-8?B?ZEpXTTBVekNyaXJKLzlnWFdGaHcrSEJBUU9pSmQrRWlXWk0xV3pJQ2xvdVIw?=
 =?utf-8?B?Wkw3QVF1NTU5ejFXeFpSVktBNVJpa3YwMjd4THZobkNIZXhIZmw2NllwNkdW?=
 =?utf-8?B?VkJCQ0VWM1FObFMwLzA3OWw3NE1ib0NFT3F5eG9vdU1vdWpzY1lWS1c2N1lk?=
 =?utf-8?B?QUllRDVzRzFQWitxQ0dNVHVMc1JVMTJlQUorc0JZS2ZraDJSZW1Db3MwWGk5?=
 =?utf-8?B?Q3h1ZUR1R1RCdmNVenZPUWJiOEFzTWdmbHF2VENDZ3RnZks3T2M4YzhzK2FN?=
 =?utf-8?B?RzFZU0NLejg0N2x2YzZPTTc1OWE2VWswNThqWDh0REV6WlRFVitWTFVlcGhj?=
 =?utf-8?B?VUtBSi9Nb2xSQmxmQmNUWnpsK3N6cWZISUtVaUJrOVdVR3ZQRHVFeFRjck03?=
 =?utf-8?B?MlZxRFk1VFRtUk9sUDRkNmU5TlhHKzdiZmJHS1RLRW9WSFUzczhhU2dxZjBn?=
 =?utf-8?B?TEFnNmZFOVlLaW1jKzc2c1NZSFVDd2pnZlQycDlYNzd1ZEJPdGlsaEVnZUlv?=
 =?utf-8?B?cDRaVWRkM0lRS0NvNldZZXZyMEVuRXJzRWRTdFg5QmFrSEMyOVo1SlFDTW50?=
 =?utf-8?B?TEFuSGozdG1NcGlGR2lTMVo2aS9mV0xDWHMrZnVJNFBGUlpLOUNqV0tWWGt1?=
 =?utf-8?B?QzRTNTdmUmtsZXNEd1laYU9hVEFGeWlSZGo5a2ZrUENaMVpEVHU3eHdkOGFH?=
 =?utf-8?B?elJ0Z1Z5RkoxZXpTMFJLSVNIZlAwQzhaVVlVTlJOTVcrOFhRQk5WcnB0SDlm?=
 =?utf-8?B?c0RQL0sxalI1dHlrTGYxUGpqWmpNUytnejdBYkU2WFJlOEpobUFoWjA1V2Y5?=
 =?utf-8?B?aThKOFl0dnpyTmx1YkNaMXh1TW5PRnlGVTFjZWpoQWVPcFNKTEdBajV0ZnVW?=
 =?utf-8?B?c3g1NjA0aFNPSVdZbkU4bSt0UmNkc0Fpa2ZmeXp6Zjc2UkhiRkFCc1l2czRh?=
 =?utf-8?B?cTZuM090Q21USzg3VmJ2bFpiL0JSMThkQ1B0c0w3MVJQMTVTaTJieG5YMEts?=
 =?utf-8?B?NlQ1Z2Z4dHJqNFk0M0RqOGxoNDNJTUhiKzE1NHUyV3NQSUpCU3REalQrK0dO?=
 =?utf-8?B?VTBBaUxPeUR1Q3JPa0tDUkJMbElxcHZKZkkrMGQxSnhsVWgwMmtReHBFcWdJ?=
 =?utf-8?B?WEVyK1BxYUN4dE13RTJ5Mlc3TlNLQXBiYjVPcDdqQzRxellYVE92cjcvYTBU?=
 =?utf-8?B?Sy93aTRlNjFVRm4rT3VkNWFPeWdtNDFuWm8wdlNteWM0ejh0clFDL0hvY0pM?=
 =?utf-8?B?M0xTdmRXeUorSWJ1eEdGK2V4UXArczVzYlZZZVBqMmpmb3Y0TW54Ty9FK0xp?=
 =?utf-8?B?UFV1OGs5WlhCNHZVT0pKcCtUclJkYjlzb2tuMTRtMDc1RlFUL1RRbVJHNWwy?=
 =?utf-8?B?UUN2dERUckFNdm5Ra3NiUlpuRWNvN0dKUVRXSFJjTVhhbzFNaGR0Z1hJanM5?=
 =?utf-8?B?M1ZndzZkQnBwZjhURHB2ZmtwVlFDMUxwR3RVQkh2R3diQjZlbWhzOTE4bitv?=
 =?utf-8?B?YUwyRVRYMk5jdjdrQ1dYQThaQWVLby80WlRMU05xYnNQczMybW92aHA2K0d1?=
 =?utf-8?B?aXBQbEVNcHFFOHpYVVJ5cGxQd3pZazMxdEF3cUZQMENCeHJ3OHFOS01VQUhw?=
 =?utf-8?B?TVdvamdPTk1vSldnK05NVkN0aWdyQUhDRkY5ZzRzcm9OYUd3aUQ1d2lvRjF3?=
 =?utf-8?B?OC9qQjJzODdzRU9Id0I2ZjBzb2FiaTVGbGg4NzVzMHlTUHRZRGY4Zk5NVDJM?=
 =?utf-8?B?dnRFaFRXUkNNYk9LNE5uNTVlekZoMFE4KzBFQUhDSHU0QXh0cW0wWUg3ZExW?=
 =?utf-8?B?Yk9pSER5N1NqWkRtN3o2NzVoS3Q2dnlxVUlERXh4Y1JObDNqM2MzcWxKOHJq?=
 =?utf-8?B?MURabnhpV2w5eFJwRGV4K0o0RnJBdzV0ZkFKSnVock5KNjM1blRsbUNFb1lO?=
 =?utf-8?B?S1cwMjVZRzJ1OFN0dVdNZzVoK1FsQmlqZlp5ejVSRFAxZi90NUw3clpCeG5W?=
 =?utf-8?B?dmtNL2I2RFNvOEF0cUkyeWVMb0YxWXhtd1JJNFhoOEpJaWlLN1ZOUmlnd3Rm?=
 =?utf-8?Q?YwdxbfwmBbHx2Hul+UaUKt6hlM+BwEImkIV8+YncRXL/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4198ec15-2a65-46d4-b63c-08ddabfa8993
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2025 10:51:10.0122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5M5hZrQtN0RrXwJYe1s/4ow1wk0KV0XPfC3P8FnkpPBsULA/WV/lD1CkcQuc0MlGPa/ciWqzWq+PDJP80iE8xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9257

On Sun Jun 15, 2025 at 6:37 PM JST, Miguel Ojeda wrote:
> On Thu, Jun 12, 2025 at 4:02=E2=80=AFPM Alexandre Courbot <acourbot@nvidi=
a.com> wrote:
>>
>> +            /// ```
>> +            /// use kernel::num::fls_u32;
>> +            ///
>> +            /// assert_eq!(fls_u32(0x0), 0);
>> +            /// assert_eq!(fls_u32(0x1), 1);
>> +            /// assert_eq!(fls_u32(0x10), 5);
>> +            /// assert_eq!(fls_u32(0xffff), 16);
>> +            /// assert_eq!(fls_u32(0x8000_0000), 32);
>> +            /// ```
>
> For a future patch series: this could provide examples per type
> (passing them in the `impl_fls!` call).
>
> I can create a good first issue if this lands and it is not somewhere alr=
eady.

I was worried that the examples would be mostly duplicated, although
it is true that seeing how the function behaves at the limits of each
type is valuable. I'll prepare a patch to either squash for v6 or submit
as a follow-up.

