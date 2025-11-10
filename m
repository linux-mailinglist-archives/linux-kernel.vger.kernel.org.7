Return-Path: <linux-kernel+bounces-893279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A86C46F6C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFAAB4EBEAD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB15231283C;
	Mon, 10 Nov 2025 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oJB4qjh2"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012051.outbound.protection.outlook.com [40.107.209.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215153126CB;
	Mon, 10 Nov 2025 13:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781950; cv=fail; b=R5xX3xmOj45XehkfdS41yCajoX4RR9h5V+p3/1IjdZd47aIz17sGeLT5kdHsSNA6BGPk2IXseG87P+SDmxN/5BYqTzzl0lNQAmO7s6wkfI1mG2kjWttowUiCYYVhj30b55306pBKo8VOEHtWgni3uu9bXns5fw9RAxO7uzItsV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781950; c=relaxed/simple;
	bh=Lb7kCofSLwmBN7pnAzuJ8RbSSVCZSCHw4VLTxVaRHzA=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=XEVRJyXQNeP8k1pfNpkk0R62a/rNWj2RjftkSYvrZHQ5PdTZdh5ulGhptifs8CY+kSy5W8VRU681RCeKs40veSYbFn6Lykkmc4VO2/gzHWwXTzWqrx/pMROhosG4CIsh61P05fkw4PFBwZc/t7mBWpZysev9Fo0vNh/+NNrRgZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oJB4qjh2; arc=fail smtp.client-ip=40.107.209.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpF33Q4fZtYW32t2o0+5HA+nClWm6gG+SEIy3EIBNpg9wpui1wbico32dut7WNfetXDitpjG9aLb3IT3mqdfLjRMqx+/sPX2RP39qY8V7xnADxwTGsMfk9JMAK/bdmqp6iVgWnWrpjRBGlRFE5PAEHN/cMfgrDtd3JAp1RBU9ZGfxqtTakFJK2fVeLyMU7rmEj1TyZlga5dWKW6/uSV2dr+4yk+/82450WwzJCwB6m2ZP+O890Wdje0/2Z0+v+80lBEXOwievzMvihl4G9xbXfOvyHy5DtsuFhGZT7y3FeAM7KcbIHEUjtn9YJR93ZNpLZ0XahXmgAdD12yiCkrDIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIU9hY0k/TX548rxic2iBh4OhY85wdtGTEj2uXR7JDo=;
 b=zArIftNB2kx2AkvH+Nklivl8fPwV3m0TE3rQYkc/RtCFvgg3YC0axccgBe4s3uH3FiJSxJlqCogcUe0TgV86v9T3bdy+7c/InOp3OJ0a99kpPkJog8Mi416P7opi8V50yX6l9nbDRJncyT2BivynVOcvbpTFDlA15Xp4XPU/jE7Q5BHbZDSgPvVWtp930v6VLBBA0tYg8qB8R+eFWU47ocMzVa739iLK5oAMjLMmKTvjFchapv9wnFsycOQ6rP2omFACWX3qSdjnns4Gp+oG0HwYvyPZGwRniQLpjHGro4EgLT8Rdl1OTxbEZXkQ80dPpR4tTPlt+QX+rsZgtCLhNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIU9hY0k/TX548rxic2iBh4OhY85wdtGTEj2uXR7JDo=;
 b=oJB4qjh2g5WrILqYzZHqK5S3qSPUyTU3JTsbRhc53IZ75UyoHbQAfWu9o/yULtYrmgz+90TsxLhHFsJOVdq9j+12n0tJAA/Szq3BEqSDZL+6Z/iSFvhTRiOGsEIQvpoJe03bIXQPjye5TNK9qwi0Xil8BBlM/2kdK8r+Yy0om8iKV3kuMnSdcCSgekFHIRFt1Zu8PvFHfCKFVt42vPFFKonTscqPrvSKYDSO7s5JNFSKUyMlrOA02WsaqIvpOIUEyr+dbXEzoJe7008q8SYW5fxqc0zkiiBI/SO2N8dPgLPZcJhshtLdXefsTp3tvsuvIBIEvz8w77t5RY3LACEUzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA3PR12MB7784.namprd12.prod.outlook.com (2603:10b6:806:317::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 13:39:05 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 13:39:05 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Nov 2025 22:39:01 +0900
Message-Id: <DE521OFQRH29.ZNUPX2POGN1V@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <dakr@kernel.org>, <acourbot@nvidia.com>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "John Hubbard"
 <jhubbard@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <joel@joelfernandes.org>, <nouveau@lists.freedesktop.org>, "Nouveau"
 <nouveau-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v2 06/12] nova-core: Add bindings required by GSP
 sequencer
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251102235920.3784592-1-joelagnelf@nvidia.com>
 <20251102235920.3784592-7-joelagnelf@nvidia.com>
In-Reply-To: <20251102235920.3784592-7-joelagnelf@nvidia.com>
X-ClientProxiedBy: TY4P286CA0006.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA3PR12MB7784:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f03a884-f871-4b39-fcc5-08de205e842c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFBOZVY4L0ErdVlUY0dreWhCTDk4QTZZSXptSDRuMHZMVmYwT29wRjQ1QTNS?=
 =?utf-8?B?d0FOQ2VCaXl2OXdCWkxVUFRWYlIwSC9GYjlvVm53R0VUNHA5TEVsY3A2aTdL?=
 =?utf-8?B?eE5HOFJ6MHhCS1ZyTFJoOWtPcERiekhZZkNnS3RhL25raU5rN1JlaUZqMFRQ?=
 =?utf-8?B?SEJjOW0yS05UZm5TRmxRNTVIbGRodGVMWE94STQrcXRMZTQyZUF1YUtuOWpp?=
 =?utf-8?B?b0lvUTdYUG1ZcFNrUWtXaWdUdm9OMkN2cmwzd0lodTlIZWRrVHpCOXdWNFRw?=
 =?utf-8?B?bDRjSzhWbzZOd0hQMk1UVEFuRjM4Wm5KNEdsMlpiOXFMMVNmdkQrMXFObllI?=
 =?utf-8?B?dVZMRkZreHNEMVV3TDEzTHBkdVVyR3NlUlkwWFpaWHViMU5GamVXUGNLeEJN?=
 =?utf-8?B?clJXaUF2NjdGNXArWlkrejBRcGQzUFNIM1JNNENNdGZaeXdveFpMOGg1clh5?=
 =?utf-8?B?M0hLTWpHbmN2Q2xxTkdacU9SdjVJNXVGaVdTMGhrS3ovTXN5WE5GMXhpUDd4?=
 =?utf-8?B?enBuQ1NMYVJ2WkpzdHBoNWIvZnVFVmtNaERoTlczenoxVXQ2bExSenE1YVMy?=
 =?utf-8?B?ZlVBYTBlclpDZ2t4bDZxbFBDZnRyYnlnaktrK1ZIMEoyZ0JvaWVUVlNXa1VU?=
 =?utf-8?B?Y3BpQkRja3d0YVFESzlIUWd2WlFQV3k4dFZIR3psSzhNSWgyT2c1dkdHd3Zv?=
 =?utf-8?B?Q3J4OCtDdGFwQi8xMitkQ0c1ZEZZUUFLT1pwa29xdUt1Z29lelJsTnBidDJo?=
 =?utf-8?B?RDV6QmduczV4aFlNWHFnTlM2SlFhaHpXR0VoYnRqRXBoK2FySnpUUVNlTW5L?=
 =?utf-8?B?Uk9iQVVYSnAyUVJUeFhYMm1JMmZueFJBeWplTGNwc2xLYlJDWjNyM0FEZVR4?=
 =?utf-8?B?Z0xDdEphK0JXOE1QS0tML2VGWU1INGkwRlAxVW50Y1QyUktwdElIbzlRRDRT?=
 =?utf-8?B?SUljTDNSdWlraldyUTgwMTNvK0IzQktPZE1aUllva0FTdDlieFF6Y0o5bVJq?=
 =?utf-8?B?RzVzT01CbklBbjVTTnh3SHZKejV6c1J5SG5NU0hMTzhJRGlHWVJpNmllL1p1?=
 =?utf-8?B?cjIxUTlTajNXeDNQeUNmdWhXdktYdUpSczYyNzIzK3FRS3hhYXcrMUJlU1R3?=
 =?utf-8?B?VWlBQlAvSUxvMUkwYXZLSzVlOXNGTnRKZWtUdWU4ZkJmTWJEZ1FScXFpZ2Rp?=
 =?utf-8?B?bndaemFxTENSZ3NuSW41ZHZOcFFIM1l0R08yS3lFdWIrS1hXRHYwdnBKMmUr?=
 =?utf-8?B?NStuck5UK2xlOE1VWUNMOVRjZUw0elpxalZDNXRRSCsrcG9TTHNuTnhDZDZh?=
 =?utf-8?B?bDhOQ2xDRm96TUxrc0xIR2crNHB5MWpTTTcrZTVvemR3T01ZQVR1ZUhDV21k?=
 =?utf-8?B?NmRNbkpnaTM1VWpVZ3BtZTdKNEhDa1dNRkl0a2hyaTgxNC9wQzFLYmR5Nm5o?=
 =?utf-8?B?a3dGZ3RVcEo3UmhCWG1JZUFyYmg5Mys5NTlHUk1RYi9veFIvQXdJTnh5SzQx?=
 =?utf-8?B?SUdFdU1ZVkt6M3VxdUthU1VHSzVibk5VVkhHcFpWLzIvSGc5NzdDWjQ3eFVi?=
 =?utf-8?B?bGJ1N0IrQ2lWcWJENjhhNlJWdUVYVlJUUjNlcnhOb3orZnBFSCt6YlBLNW54?=
 =?utf-8?B?c1FvTVFSdC8wQmZCU29ER1JhRWlDNkFtNnExMDNmcWtqbUFFd1ArNndHRVpE?=
 =?utf-8?B?M3B4NHNGVkdPR0IycVUwSkI0Uk5hc25IdGlUYUVuYTFrbTRXUndieG54eHpC?=
 =?utf-8?B?czRXT3hjS3VFYkpPNlB0ekFZTkZZcVkrakExYmFKbzEwcWVMaHE2ZVFWbm1u?=
 =?utf-8?B?YTlScmd6VjRzdFRIVWtnaHNzd2F1UHcrcFBGWTdhYitqYVJ3WlVjNnlVSFIz?=
 =?utf-8?B?Vjdnc2owTWhIVjg4SkplYzUrY3psWHlhT1YwNTlOeThLTHdkSHpJWEpQVlpj?=
 =?utf-8?Q?l1+0ftZrJulHmDDTlHaJuqF3/BC5wUkA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1FVL1lKUmg1WG9RZVFlTG1uRXlLSDFQb2tyZVFaNkFISlpuR1B6QTQyckN5?=
 =?utf-8?B?dkpkNTNrOWNDbEhEOFI1V01veVpxNWRUVWkyZHZEK0E1VWx3V291TElFTmRj?=
 =?utf-8?B?ZjZJSStCeUZ0dEd4U2ttSVZ5K29DbTlpSnJyTXNUTUQxUTRBbzgvS3VJbzdu?=
 =?utf-8?B?SjZqYjhRVkZiYmx4dGpEUmw1dHAzaklRTllpZ2l6T1dyZjB5cnZMa0pvTG5C?=
 =?utf-8?B?NGQ0WDZ6L0VaT0VHazI3b3I5Q2tIUUI4SkNXL0hSdm1Ldk8xSm1FeVR1SmNC?=
 =?utf-8?B?SG9iTFh2cGV5UGJEcG1ObFlrZ2RZRHZoaWxid1F1OXN1TkhoV1hjR3hzVnZY?=
 =?utf-8?B?Y1YzMjlrSXJIUU03anZvUlQ0Q0tHeitnOTVhcnFTeGtvaHNDdVJkbmhBQnMv?=
 =?utf-8?B?NXNFdVRBdzlvSnloL3AzcnczdTZ5bGtrYUVIS2JtQmJiM2U5Mk1hbFBNaXU1?=
 =?utf-8?B?ajBpNlZmZ010eTlkcHkrcTNjTFhKU3MwL3A3YXZJa3hTekJOa2F0WG13OUhy?=
 =?utf-8?B?VWN0c0pSN1Jjd1VESWQyc3hhWGpJZXFTVmFCeWhoZE81d2E1RDRRNmk3ekpi?=
 =?utf-8?B?Z2hXYVdablcwYkVOZXBEMGgvN1hmTGE2a0VrcUV2MENmVjBBTHVwU1VPZWJx?=
 =?utf-8?B?UUR5Wm1QbGRLelk5UlpSeVRZQmQzQlpIcldlQ2loWTZkTkNoVm5VWWg4OTQ2?=
 =?utf-8?B?SmRuOVlXZGQ2RHppYXdLRFlOVTFZdjh2Rm52R0UwOTRweCtocVhjTElONWI3?=
 =?utf-8?B?NTU5VUJZQ1QvdUlLdnA4TGJBWDB2RWl3UEY3OEcvenVtTTkvYjI2UkZUZGdo?=
 =?utf-8?B?NmR1dXFPVkJKNS9SK0RWM3NIaTVXSVE0blF6Q2RRanZkRFQ2MUxXNm1pT05M?=
 =?utf-8?B?WDFlRzNnWmNHS0NXYXRYM1NEcEtBbi8xM0g3RDFxcUFBSjNnM2RCVElISjUz?=
 =?utf-8?B?MlI0MC9OWVMydDJLWHNBN1Jsd1VnTEVuN3FBcnphdkZCZTN2OU13a2VBeTRR?=
 =?utf-8?B?bUlvdnYxR2RLbFJEMlAwQ2RBS3RWNUhZSXpGVktEOTFqV0lvemxmUVBsaXdO?=
 =?utf-8?B?SnhCUk9xTFBPTm1LRUlzUG9FVUlWNjZDcExhRzh5WVl0ZnAxMWpwYzRmM3A0?=
 =?utf-8?B?UDZ4VUxXM3RGeG5udlF6V0xZSnpFdEQ1RmZKMWh2a21aaCtIczUzMEczV0gx?=
 =?utf-8?B?aCtoY2FUZmpxK3hpRWkwUDgxaW5GTHpMZVVQMmM0L0Z5NVB0djhqVWNPQ2l3?=
 =?utf-8?B?NUZ1OURJdDV0aXhJaVJyU2ZmcmF2b1BYTFZ2UkVUcjdGRndNeFl2d3JsNDB2?=
 =?utf-8?B?U1dmbmtEUXlURGdPRm8xa3M0bnF4cUNWQzBaYUdPV0VzV1NJRHJWdXNUaVpO?=
 =?utf-8?B?OEJLemxIWHVPSnlKU1FHa1VpNUFOMnduZGMvc3kvZWFFZjVFamZuQWxtREZn?=
 =?utf-8?B?cmdwZjlISzF1L1JwdkY4ditNOE9LdTFtcWp0TUpZRFQ5M2JvRlhJOWFjUDRs?=
 =?utf-8?B?bmhiUEZnVlpOazJmakNJZzd6UVdqZnhZODh3SlZIQWlqUEZrMEtMbFZLWHZn?=
 =?utf-8?B?WHphVEJzOHRYcFVZQlAxVUJIZ2FkT3hnbW5zNHpGeGhZZUVtVHB0TlJPOGR1?=
 =?utf-8?B?YkFEQys3Yit1SjJ1YnFtSFBtSlBMaElUenhOaUw0Q0p0cEJQWjE4WVJBbVpO?=
 =?utf-8?B?WXQwVDAzQkhLRkZ4Z3d5anlDekt6NWZRcEE1alM4TFJ1Um95bWV6bTdidm1i?=
 =?utf-8?B?d0hPZnNtT3dadDVqNDU5Q1hTL1VkUGlpV05GdFlRMDhEK2hPNmJpU1lKT0RX?=
 =?utf-8?B?eG1SS281MGw3RzZja1JRM3BVNzhkU28vN1VPQldNQjdhVzN2YXQ5MzU4V2d5?=
 =?utf-8?B?dXNuQnh2ME1NYkpXNFkxeFRSU3ZqV1BXMTVoM281blMvdExMdGpHTWoydEwz?=
 =?utf-8?B?WGs2S1RjRGtUQ3ZuQjZjK0ZSakF0S28rTEpQZzZzZ1dkVUphb2RWSFlaU3Ro?=
 =?utf-8?B?bzRZMGo1enlPNGpVY2hNTTBqZVZWbUJzc09qZE9mdjhnVWdUUEtwSFYxTXRD?=
 =?utf-8?B?eC94QjUydk1MdFIyMGJtYVNxczJPRE5PbWlYUGVqQkxSaXlRbGFXbURTZ2Rr?=
 =?utf-8?B?d2VRb2pjMkZZbHcvWWVMZlpBaVBTVXlva2FUNVpwRmZ4Y2VkaWsraFBBanBw?=
 =?utf-8?Q?z9ug2W3fw/Abjlt4mfmHM+yyRNaeyDICMp61gG9ySFLS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f03a884-f871-4b39-fcc5-08de205e842c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 13:39:05.1919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /A04Fm4mTgsPsMzLgx/ckJ9zhG/XdXcSE/7Ks5fdqB0VTChLHMVoQDCEosznp70wRdSGIf/awUFc/4PGOQqQww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7784

Hi Joel,

On Mon Nov 3, 2025 at 8:59 AM JST, Joel Fernandes wrote:
> Add several firmware bindings required by GSP sequencer code.
>
> Co-developed-by: Alistair Popple <apopple@nvidia.com>
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/fw.rs               | 45 ++++++++++
>  .../gpu/nova-core/gsp/fw/r570_144/bindings.rs | 85 +++++++++++++++++++
>  2 files changed, 130 insertions(+)
>
> diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/=
fw.rs
> index 687749bdbb45..53e28458cd7d 100644
> --- a/drivers/gpu/nova-core/gsp/fw.rs
> +++ b/drivers/gpu/nova-core/gsp/fw.rs
> @@ -543,6 +543,51 @@ pub(crate) fn element_count(&self) -> u32 {
>      }
>  }
> =20
> +#[expect(unused)]
> +pub(crate) use r570_144::{

We are trying to avoid that (direct reexports from the generated
bindings) - some explanations for how to abstract these follow.

> +    // GSP sequencer run structure with information on how to run the se=
quencer.
> +    rpc_run_cpu_sequencer_v17_00,

This type should be wrapped in a transparent type similarly to e.g.
`GspArgumentsCached`: its internal structure hidden, and the needed
functionality made accessible through a constructor and (if needed)
other methods.

> +
> +    // GSP sequencer structures.
> +    GSP_SEQUENCER_BUFFER_CMD,
> +    GSP_SEQ_BUF_OPCODE,
> +
> +    // GSP sequencer core operation opcodes.
> +    GSP_SEQ_BUF_OPCODE_GSP_SEQ_BUF_OPCODE_CORE_RESET,
> +    GSP_SEQ_BUF_OPCODE_GSP_SEQ_BUF_OPCODE_CORE_RESUME,
> +    GSP_SEQ_BUF_OPCODE_GSP_SEQ_BUF_OPCODE_CORE_START,
> +    GSP_SEQ_BUF_OPCODE_GSP_SEQ_BUF_OPCODE_CORE_WAIT_FOR_HALT,
> +
> +    // GSP sequencer delay opcode and payload.
> +    GSP_SEQ_BUF_OPCODE_GSP_SEQ_BUF_OPCODE_DELAY_US,
> +
> +    // GSP sequencer register opcodes.
> +    GSP_SEQ_BUF_OPCODE_GSP_SEQ_BUF_OPCODE_REG_MODIFY,
> +    GSP_SEQ_BUF_OPCODE_GSP_SEQ_BUF_OPCODE_REG_POLL,
> +    GSP_SEQ_BUF_OPCODE_GSP_SEQ_BUF_OPCODE_REG_STORE,
> +    GSP_SEQ_BUF_OPCODE_GSP_SEQ_BUF_OPCODE_REG_WRITE,

The opcodes can be exposed through a dedicated enum like `MsgFunction`.

> +
> +    // GSP sequencer delay payload structure.
> +    GSP_SEQ_BUF_PAYLOAD_DELAY_US,
> +
> +    // GSP sequencer register payload structures.
> +    GSP_SEQ_BUF_PAYLOAD_REG_MODIFY,
> +    GSP_SEQ_BUF_PAYLOAD_REG_POLL,
> +    GSP_SEQ_BUF_PAYLOAD_REG_STORE,
> +    GSP_SEQ_BUF_PAYLOAD_REG_WRITE, //

These ones are a bit trickier to abstract. Since they ever only use
`bar` from the sequencer, I guess we can have their semantics in the
`fw` module, exposed through a method that receives the `bar`? That way
the sequencer won't have to access their members which are private to
it.


