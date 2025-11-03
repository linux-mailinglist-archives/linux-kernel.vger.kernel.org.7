Return-Path: <linux-kernel+bounces-882998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E26DC2C2E8
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C7949348C42
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BA3309DCB;
	Mon,  3 Nov 2025 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L4NpVGDJ"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012029.outbound.protection.outlook.com [52.101.48.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD65257854;
	Mon,  3 Nov 2025 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177363; cv=fail; b=UBDuZrsvS4Y8sVL0FClgxtUxIh8KRXtD1/12SxSk38wgE6C+uWfANs3u007K1jU59/o/5wgDQI9MTGrW+QekfeAcMpBk3GgyVsHydO5kgYnIDN6vG5/dRs0GLjs1I7pcsdrFyDuiBHsC34Y/j2hQPhlut72kUNWu73omC/0Kf6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177363; c=relaxed/simple;
	bh=Pxh0CNJT5Dtj7H2Y7XA7h0W6K9DF5Md5RvV2fMm0Oc0=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=M+oTS0n/rp4GIXNlL5kNX7iCRtrREYVuxFJu3HhRxFbRRcEZVhH558WwbX91vJ7aWPqz0rtceFOADt8X4MAzy50y0i3SYnzHATTUCx2m4uM5oqMjeCloQTBZKcNii7IWQ+W+FJ0fQntZWuxviGJPA9Dr2TzqXIzUgfzE6MDsdCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L4NpVGDJ; arc=fail smtp.client-ip=52.101.48.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpn9d5FtpYiZfrqZvAveGBKsJREIcRSUAQEjo9JnZm/hAG0/SuqqJoNOXlg5p6IuKDTPCkJH2Gr0r7AlHx5c6l6lboFqJfkFJyISXLB0NdyUbIQrKP5IdZZWXLgbAucfTLrhTB3hirL79tufv8dJSOqF1shY2AqPhFCzjH06U/vr2vvbJCDXo/6oyRu+xjpPldG32RU/xjSVjGmt6vcKvnC/bDm1kqBj61/J7xJuO3EEgdsi8nJSB35VJCB2hsgY2kGYGPTHHs3+EJGFJslHkP/QCtMgbJC33W2Schovz4sflYeckbk/6LmgV55T8yXLvkO6i18Gz2qMLbqIE9gqzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pxh0CNJT5Dtj7H2Y7XA7h0W6K9DF5Md5RvV2fMm0Oc0=;
 b=T+Hi1/LxZ6/zb3bnbBJPJ9OD79eSyn9HlDA+hgelL/sJpa1elrXj8BPT0wIYaWlEkSNhowC3tpaYrVPJID+rLm1oiTFTdIz36PDjAXe09CREDvwcOAJ2p8uR175GTxr2UX7doGv0S0VIP3nvvMyp1xg6+KHxDFT9YK34iO5NBxJhHZ9vh9tXl5bXpA0/2FqQRBA8tcz4ltg8iGVMPri7eZOZVQE+mUo3xHXfFpBgPuR0qcBScyXpCgazaz/plJpBTfDhxz6UpXt3gOqBnxiuBn+WnjSenPKFXGPxmkOIDupS45T8HRDjgFpksFhpIUmBF04WMA1DMRNFe4Y4GLASmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pxh0CNJT5Dtj7H2Y7XA7h0W6K9DF5Md5RvV2fMm0Oc0=;
 b=L4NpVGDJ3Ud2hbyh3V0qdMAsMTy6fTpAGP4OxZH8TxULRpadgfPXapyZXvI8XtQOQt7OABe9ssowY1e3riRxr5oLRK8gErxGqnZA+wAnfCCMIdxvfaKwysLrkLhV69W/9ouiREtUYiuCxkEFMzLc40tWJpoEkmZotq1k36C2RMeShK6hGLLguucsbqpwsz8pAT4/AEDsWwzFet1v6Z8B1JCgE6+xrzXHDCk9hV/iUaWoejqiyTuOYOH3qd4MOEVj6+a4hK/1WuN6DiS/bdbua+ZrkrtG5yLN9/XyqIv433kHSdzyh1/XX5HIoLC3mpuYZALALI4E0iBXesedlJqUfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH0PR12MB8097.namprd12.prod.outlook.com (2603:10b6:510:295::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 13:42:39 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 13:42:39 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Nov 2025 22:42:35 +0900
Message-Id: <DDZ3QLIXUP5Y.1W6RGF1RWGNSL@nvidia.com>
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
Subject: Re: [PATCH v2 1/2] rust: add BitInt integer wrapping type
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251102-bounded_ints-v2-0-7ef0c26b1d36@nvidia.com>
 <20251102-bounded_ints-v2-1-7ef0c26b1d36@nvidia.com>
 <aQiBTOj1jl4xM3pJ@google.com> <aQiItc35Y19l4HOc@google.com>
In-Reply-To: <aQiItc35Y19l4HOc@google.com>
X-ClientProxiedBy: TYCP301CA0062.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH0PR12MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a0ef7a-f2c4-4eca-1216-08de1adedab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGUvUXhSUFBMTVllclltUmx4M3BZTUZnbUVxTVZnUUlyZkVzMVFMNUttM2hT?=
 =?utf-8?B?V2NrQUMrVzNQRmVsN2hFQ3BZY3ZLWGJlcnEyVVh3VUM0K3FBUWhXS0JNWTQz?=
 =?utf-8?B?UDdvZzE4VWV4dGMvUDFsbnJOd3RyTC9ZVytwNGRWNW5WU1hsMllkZ2VzR2Fr?=
 =?utf-8?B?Z3hrbDRUZVA2STdkb0tNN0p6NWFYamFZYTliUGZLRkJVNHFNdUx6N0N3N1FO?=
 =?utf-8?B?dlZCMG5ONmFkeXRkcEtlUGw5cnJXYXZCaEFQQVhWeXJoNUpsbmdlZnkvaFhU?=
 =?utf-8?B?NnBQbmhhbnRLVFY2Tm55U1NKY0ZhVU95WFhuQmdaS3VsNFdOeXJ6NXpEWTJU?=
 =?utf-8?B?Qy9mU2JQd2t4QUliZTlIT0JzamE5TW1qcnowWmhvUDNtaW1VWWJPeTVyVFBK?=
 =?utf-8?B?QjhMQzVNMlVlRXV1MWlYNlBzdU1yZFZGWWN5OUMzNlZXSmVXSkdVQ05URE9i?=
 =?utf-8?B?VGVjaHg4UUZXbXBuV0FicXZ6ZXBsL3c0TVNhN1B5UkZPNlFRNWx1L0xkMGpC?=
 =?utf-8?B?cUhBbDhsM2pGTFpHbDBOcVAyTFFHZU1GbDVRRitWRk1jdnJBcGpGbDlQcGRB?=
 =?utf-8?B?NFBoMFFHNDlCTVpKK2dYdzlRNHZWcC9QM3k0U1RDcC9tVXpMbHpqQjhPQW1o?=
 =?utf-8?B?WnNmMUVNSzNGM0N3TTRlNk42K3NlR3o4RXNPbmJkYnNCTXI5djBmOW9WdnJ1?=
 =?utf-8?B?amxkLytoa1F0VytLSmZzVVlOV0gwRDRRQlB0YWo1eGtFaW00YXB1ZE9hbE5H?=
 =?utf-8?B?RDhRN3dJdTNtOHRpNERGTkJ1MStkL0ZKckk3c3IrNUg0elBiMzlTREgvRGFX?=
 =?utf-8?B?bllYaG1CNmUrZXQzS0pzV2phMXo5NitOMStpeDdoOTVVcUY3d0RWbWdmN0VX?=
 =?utf-8?B?Mm1WTXRyOWcyemVNejhUR3ZCSEVTa1Y3VzR6TzBZYmwrTXZOOUFmRHF0QTRi?=
 =?utf-8?B?ckhaRW9lbng4ODNnYko1a1pIZVZ1akpNd2wzeUlXb0V4VmR6Vk56Z0FqN1ZM?=
 =?utf-8?B?RjlEVTZIbTEzVWhGSGtkVnJCKzNFMURpQkw5SE5PbEI5SndrRytWenVaZjJH?=
 =?utf-8?B?RHFMVERNVnRtK1hUU29BOXdJTlByYWxZR28vTXA5UjVEMHRVOWx1VDFZMmtW?=
 =?utf-8?B?QTI4cXdwUHBGRFVKSm56cW43TmpNMDY0bHpnQm1pVlNyNWtiNkdBY1g3ZGpV?=
 =?utf-8?B?cmUyaDAyZjBJdVBEdEhCZ1VXRk5UWWlTYTFoVkJWNms1Q3U3d2hUTk9GRnkv?=
 =?utf-8?B?REJTSXBnYXpTTlc5N2dLK1pPdHVlRXNwZFJmc1FwOUhxWnVIZnczTXpWYm1L?=
 =?utf-8?B?Yk1yQ3lDWUJ4YkQvcGF3aEwwRzRZbTBwODRFaDZtQUNwSXIyQ2VvazgxcnhQ?=
 =?utf-8?B?UTVLVnNXYWhhbXFWRDl6dStCcVdtMjJzenovcHVuMmxXYlhVZWd1Z0djVGJv?=
 =?utf-8?B?SGViSE5xUkxTclMwZWNodFhhTGJiVXhZVFBPTURCL3NCZkI4amM4MU1XMHVM?=
 =?utf-8?B?SVhiZXNRdTE3aTBUaVl4R1d6c0Y3TUJNa01wRlh1NkJyRGNjMFdTZ2VpM0Y4?=
 =?utf-8?B?T0NqSStQYkl3YTRYUkF0RUpmSFdUbU14ellYVGlBRzBjTUF6Z0MzaDVreXVM?=
 =?utf-8?B?RDgraUdkNlNqWWVCZ0s3dUUvYzlaYzgyd2cwNTlnMzBZSkRoTUxMUVdxNmw2?=
 =?utf-8?B?NENrclpIRU9HYmg5aUZRbDM5cDFHRWVZOURVblNnZFRCdVdIUmJmYmRrSlVN?=
 =?utf-8?B?dHhKRUpjUUJZcS9NQUNsN0MvU210RytnMFJ2eWxjWHIvRUZkK2NJOCtMMzda?=
 =?utf-8?B?N2dqNUdrbGZiNHdiZ3ZqNjNoUldoOVRWMWV3czJQeVNZcS9rK2hNb3JEeUF4?=
 =?utf-8?B?TURBOXp1TVhQQUxuSkY1dDNkQzJyYTBYV3d0RlBla3k1cEZLOTJvMXFMc1h3?=
 =?utf-8?Q?yxtDYYf8kYdQrxngMqpJfvoxkeAcorU+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnBUOWYzK09Yd2JCWmp5OGJiTWJHdkRvcUJmTU5Ha1Z1M3hLelBZbFlick53?=
 =?utf-8?B?NW8ydll6QThFOHY5TldQZnVObllDZGF6WmhQT2Q3Zk5WbktMZXl3VjVic3Jq?=
 =?utf-8?B?S0loWXVhZFhwSTNiTEtMNGo1bUdGcnc1ajFXSkVHQXV6cFgxaWhaaHJBc0J1?=
 =?utf-8?B?b290b005b1VGZ2I5OForWVhhV0pPQkZpbUxScHVOWU9aZC9OSkI2bjlOdlJz?=
 =?utf-8?B?WTlUaXdpODk2QnI4Rk5YWWhhcVVaWDRQUXh4SlpRVTQ3QXcyZWRDeFlWWGI4?=
 =?utf-8?B?VTNRM3RUNnFDWnY1Vk83OUFBczcxVzNTYStFaEVWKzJrUm1CQmpVQzhOR3Bh?=
 =?utf-8?B?bWI0Yi9yODI3Zms1Q0hLRm1HbjV6czhSNU12MjBzZDI2Z2RBZUpPb00zVE85?=
 =?utf-8?B?V1NFRmpTdVROQkdCN3dSaXZEbFNuMmkzbmR1VWtSV3Jrc0hxV2p4VWpwOHcv?=
 =?utf-8?B?Q09rdmpGQml1RGJzZU4vclF1T1FKS05vdkR2TDZvOUk1YTQ0TXk0NVcrZDRM?=
 =?utf-8?B?aXU2b0pMWXluZ01pVnl5bW92OUdRY3BYbk9zelBPY2p3V29CZXlZa3ZtajZz?=
 =?utf-8?B?cG1vMFAyRUtGSGIyUE02blkyWWtaUmdSNG1zMU9zSE00endIL3Q2TFRyRmlh?=
 =?utf-8?B?OUZWZW9JTFd6eWN1d0JGS1ZXZ2NpV0lYWXI3YTlEN1p4K2JKb1dNZlNBVmcy?=
 =?utf-8?B?SU1KQTlNUFRjcmlPUlc2TDdESWphYzNwdGYrUDdyS000dHo3aE84MU9GQ3dD?=
 =?utf-8?B?TVdjdGxzaE9JdGw4RDdNeHlDc05uYk43T2g5TFQvSHFaNjVYSmg3UG1uMG1F?=
 =?utf-8?B?dzcwZllCVnJwbG9ta0NNQThrM2RTSFpzSzV6aXZiblBJZ0Jaa3NiL3Rma3Z2?=
 =?utf-8?B?YlRNazlDcE8vSUNhTlVGaldvM3UyMy9UN1lCdkI4dmdFK283cTU0WEREMjdW?=
 =?utf-8?B?Ui92L2JYcERVWDJpU2pqeDBHcXZBd3VoTE1oa3FYdXl1bVlnOG1QTVhQQjEx?=
 =?utf-8?B?elhjZk5BditIdXFKdEZJanJIZWVTT3ZSODZldUl5M3lGUmMxVFZuMlNEcVkv?=
 =?utf-8?B?MlNQbDFvVFRiVXlTMnYvRTBvYkZRV0lTeGZQVDBvMGlaQWpvQjRTRi92YjlE?=
 =?utf-8?B?ZnpCN3JtQXZwNnhkVENYUzgyNDdmeXdtc0hvV1FreWwxMjhoaWtoaTFOdU12?=
 =?utf-8?B?NTBtWEJaNTJXWjhyQTFRSUVSSlVYdFY2WFdZemlldktXdTc2RUVvWjMxSFdu?=
 =?utf-8?B?WEJPS1lYaHhPSjdYTzU1RlNHNDAvd2NqS1dURTJ6eW5Pd1VHK0x1YU1HcFll?=
 =?utf-8?B?eGdOVlBUOVYwbU80dEplQVNGWDN2T1EzYzlYRlhpOEg5dGIyT01saFlhWEVu?=
 =?utf-8?B?TlI2cXgrRE1MemFzL0VDS0l3eVRqc1g2TDdxb2dzci9wOFI0LzlHQVhtNUR6?=
 =?utf-8?B?MDFvbXV0eXcrbkVJMmFLWDVWYWhPekttcTlHaFVrZGlTbTNvMzZvV3RiWmNv?=
 =?utf-8?B?ZDNTR1hKOTREb0ovWkRXVUxKMUdQS0U0eThQanFpYnI3LzR6UmhCdk5OMnZT?=
 =?utf-8?B?Rm5leUkxMkZoUlBaQmh5M1FwN1gzUEhmazIyZXZ6cmVOZzBBVk5KUkovUUlE?=
 =?utf-8?B?T1dFdXNKaktza3FqRjhUZHhIdG5pWWJubHFUOTU1ejlaSmZLSkpyaVNyN2p3?=
 =?utf-8?B?enUzZUNyTkdzUzRaa2g3M3cyalRidytDdXZ2NWJEbG5xUUJJRlhYQzJWL1BP?=
 =?utf-8?B?Y1JlYlJ1S3JXbFBmSnlsQWRMNmJNODJMU3cyeGsrYjlyZ3lBVGFlZ0VOaTQ0?=
 =?utf-8?B?TzhtbkdFcVdDSDZ1Ymhpdzg5a2RMNnFlcitFRFdJOEdpcXA3Q2VMOFZnMTNw?=
 =?utf-8?B?MXBQbGRnblhlaGN4MDExMjNqaGtVb1E1QW9sRVBFOGcycnFzcnptNXRxa2pX?=
 =?utf-8?B?bU1SQ3ZMZUtoekI1VTFpQ04zbzlaVytoaGdkWEFNdE1aNGplWHdmcWF2SGp2?=
 =?utf-8?B?cm9wYnBDTzNGNGU3UmYremRkYUFLcXRHbHAxdzRCWjkwTVpBZnhrc3BTK21O?=
 =?utf-8?B?QjZMdjlRMEVaWkovaHNSK3E4WHk3cks0Uk5GTGZQZUN3TCtHVjBLMUl4OC9L?=
 =?utf-8?B?ejdBdlkvUTlUcUU3MDZTK1kvL3FsN0s2NmJwWnhkUEd2Zmo0YXBXVlpYZDdl?=
 =?utf-8?Q?Gnb3PXP14gcZmXSOK92HaU/LCRSMEE9U8ptYGGAQs0Go?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a0ef7a-f2c4-4eca-1216-08de1adedab9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 13:42:39.0670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PFQjBcnMZpTtcYLH/YET1z45FwOhtJxPBOWSx8vruToTxjkG5jnGMlImjZvZ0KfHFRnbFE7PJMWJV1o8M6zmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8097

On Mon Nov 3, 2025 at 7:49 PM JST, Alice Ryhl wrote:
> On Mon, Nov 03, 2025 at 10:17:48AM +0000, Alice Ryhl wrote:
>> On Sun, Nov 02, 2025 at 11:24:42PM +0900, Alexandre Courbot wrote:
>> > Add the `BitInt` type, which is an integer on which the number of bits
>> > allowed to be used is restricted, capping its maximal value below that
>> > of primitive type is wraps.
>> >=20
>> > This is useful to e.g. enforce guarantees when working with bit fields=
.
>> >=20
>> > Alongside this type, provide many `From` and `TryFrom` implementations
>> > are to reduce friction when using with regular integer types. Proxy
>> > implementations of common integer traits are also provided.
>> >=20
>> > Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>=20
>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
> Actually, I saw Yury's comments on v1 and I have some additional comments
> as well. See my reply there.

Gotcha - ignoring your Reviewed-by tag for now.

