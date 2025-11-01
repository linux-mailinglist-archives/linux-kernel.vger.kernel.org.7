Return-Path: <linux-kernel+bounces-881128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2EAC2786C
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 06:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19FB94E30F8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 05:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5ED27466A;
	Sat,  1 Nov 2025 05:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="axp8tN0n"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012020.outbound.protection.outlook.com [40.93.195.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F40F1E231E;
	Sat,  1 Nov 2025 05:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761973921; cv=fail; b=eALqIryAeRcbZWGL154Wi7VPJlF6tfLnXJqZwoSqdGmVGqCgBd2R2apz1YNGTyGU7cDbOWZqZtZgfhiWmalgw+KvlHgi0NDhBi5Fs/QRTNXpRO9Z/sxPX0ip1jF/RFqf3+MLtr9bzALBcsfSxuF8XP1tio+HjxSChn7TxTjhUWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761973921; c=relaxed/simple;
	bh=XA7aF8jz/zQRy7E9JzHuHcnAP/vdGdguRpRnPrS47ck=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=XbknVMKoOCrIOCgYry1HDD/GC3LgrSeclObmHPeesA07mgxI7bMWLL1Zz+b7plhuFj+fKMy4Vxt6aJRE8fWEWulNYCPJuUzR53RRJxGoCCEOZ87a2c+N5D7RYox1EG5Aph5wsFq72RSHDeUgaqeo5/EBMKkAENQCv/3WBYmRfAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=axp8tN0n; arc=fail smtp.client-ip=40.93.195.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwB4lg1fhDCwo+nz6xTmEf9SmBO7jI09mU9eilrV19PFtXbvipeZTY5SQWAYDTGqBE13Fwt7QQsYYSbELzyD4+/2ZgPkyBkbx30AUrPNODp2MIOAldxlu5qdghfhtNxLKrOKpQbkGBBXpMkhr5aGjXDLu1tCkfYSI7ijhJroTdUrb9kldfIuFOVRPYUtjU2doo5jrTjxdV87kWONJG9XuPegFJTImwWXqPhwrN+fbruN4Aig8G22w6Okh00XMLH2KujtjP44VxNmLrEnBzz9ACF1DHKTbBkk7M3fqAVCYNXyroJYqkUaxZLmvtatiBWNXr2flHyRK5l7HSggXCDdsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XA7aF8jz/zQRy7E9JzHuHcnAP/vdGdguRpRnPrS47ck=;
 b=dnUX+QgXPbQVclwE0xZNPY7uf7NGSYTZu0ptuYuUEWXR1203llUtyJ51wrlzWwC4iNECsHkdF4LpUh4UGTf77/mpKvgES7SjQDXp7wGVyE5c1On7Reo0rd1FIMAmKvyx/b/hBVP32S1vvPbmUCKOs4+l3IYX/uH0/GQNzO3XL/65sj21Q+3D+WHbEym6l7d2VP0ULBajQQ52OYI0mJT8ItmY23VOYYFSDHGNCENMTFMPMy2FKD25EjZ/GVQWyzy9nE4+fy5EROEX3VDEdT3OViKRJd8PvWOhzQz3/+9yY9DG5OQJtxpXSgrvlgevLTxgMjGYCLN5whV3H0eb0Ysncg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XA7aF8jz/zQRy7E9JzHuHcnAP/vdGdguRpRnPrS47ck=;
 b=axp8tN0nxJxTXv3I6m2KzDv5m7VI+rCboYWx8Qy/M0vTr1kZ+90NskLqhdi6VvU1h+xLouJJK4hy4TJsBonXdnUSe97WIG1rhxaCR833Zn7cN6tWu6YE4GUVrTPpyhpLY9zV5+6y4SJkLbvuVZNGArCheZjvcd1kULHqJP4qH2boliO9NhMZSgnC51cszlfa2ByDK/yUzEGErLCpmA8w9KNLOGh6bvPRtRvrdN/S74bWmrZnHkif7/TF7qomtGYnu5p2z6hIv/qvao+3oErDcb1K4CLcR4ugwoZlUHA7cPMIIwJSXJQu/a7QlfoVL89iqDR1VenTydtYtrXX0wS3Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS5PPFEAC589ED8.namprd12.prod.outlook.com (2603:10b6:f:fc00::667) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 05:11:55 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 05:11:54 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Nov 2025 14:11:51 +0900
Message-Id: <DDX3MGMC3NXZ.PSIO2C2B6QVC@nvidia.com>
Cc: <acourbot@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Simona Vetter" <simona@ffwll.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "John
 Hubbard" <jhubbard@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <joel@joelfernandes.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Andrea Righi"
 <arighi@nvidia.com>, "Philipp Stanner" <phasta@kernel.org>,
 <nouveau@lists.freedesktop.org>, "Nouveau"
 <nouveau-bounces@lists.freedesktop.org>
Subject: Re: [PATCH RFC 4/4] samples: rust: Add sample demonstrating DRM
 buddy allocator
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <dakr@kernel.org>, "David Airlie"
 <airlied@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251030190613.1224287-1-joelagnelf@nvidia.com>
 <20251030190613.1224287-5-joelagnelf@nvidia.com>
In-Reply-To: <20251030190613.1224287-5-joelagnelf@nvidia.com>
X-ClientProxiedBy: TYCP286CA0374.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS5PPFEAC589ED8:EE_
X-MS-Office365-Filtering-Correlation-Id: 2539fdfd-7e68-4e6a-3455-08de19052c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2xzNnU1dHluOXBzSEs1dXV5eW5pMzQ2UWY0VXM5bmZudTF2TDRQa0JzaDZQ?=
 =?utf-8?B?bWJQTi9nSFhERzUwNVBzRkM3UDNhcnlNYUZ6R1RjNlZLMmZ1WXhqZm4rdThG?=
 =?utf-8?B?RUlBSjJnY0t5VU5vMzJYbis3bHhqUGg5bDlsb2k4YkpKZjh2RDBrakxhOWlG?=
 =?utf-8?B?ZndIZ0FkWDM0RGoyby9xTUljRndhMVM5OWwzLzVtRm9YcU8yZXV6Y0Z1UlhW?=
 =?utf-8?B?N1B0cTJyL0ppLzcwM1dybU1NOWJqcEdSUjdwamZTeFJ1YjdMT1RnejdvMkJk?=
 =?utf-8?B?YlB2M1VsbFR1WWpmdlRiQjBGeDVVWUhZYk1EajArdHFZcTExSEJmclRoN1Jl?=
 =?utf-8?B?Z0ZIeXRTVFJsOWtocHpPbW50TTZ1SloyTHhwNnYrVFNEaUUwcVRzdUZ4VCt1?=
 =?utf-8?B?bWIzWkl6ZUhRakZ0dThjRzRqblJTN0JOQUZaK3VvZWJsQkZOa2oxTHhCb1hj?=
 =?utf-8?B?enhGaWlQUURTT1BNTjQrRlVRV3ZMQkgvano1MStLMldDdW8rVWlHS1dES2Vi?=
 =?utf-8?B?QWRCTS9iZmtBRXVHdVlrVmlDeEs3V1pSbVdQMFZnUWNJb0pyQkFFWHpBdldY?=
 =?utf-8?B?djYxM2FaMU5oYkNGNUZQU2dQejVyMTZyY1A0M0RaOFhpWXoyWmg0VG5XMEJC?=
 =?utf-8?B?WDRIangrcGlkVko3d3NqV3E1cXRqS2lVM2l3eWkwV2t4WWh2dlJuM2kzdy9k?=
 =?utf-8?B?VWo4bWZrZ2R1YjE1OTVtYURYTlpLOUxVNlVjblJtc2k0QVdMSlNBMGo0N3dQ?=
 =?utf-8?B?bHZia3IrTW1nNVlEWHVhQm9HQWFQa0lFUFFNRngvaGFSY1ZGQUFjYzlKQ3pk?=
 =?utf-8?B?SlRXcWlINkk2RXlHY1p3Z01LMEJ0WmV6MzVIdVU0eWVMZVhyWGJ5ajBlZE5s?=
 =?utf-8?B?SDlDUE10NElzWWJnb0JYZ1Fwcy96YlRDcHE3WW5Md2lOdm1DaDJOUVdpaUcv?=
 =?utf-8?B?NWh4U0x5RjF5MTRTVmI4VlhtdFpMSjR3b1lvSFllQlJzNkl3WHA5NGxWbjdY?=
 =?utf-8?B?dDRTRS9qblZuNmpTYi9NVmtIcUJ5aFA2M1hYWUgrYms0aTNuSC96d0lHdzVv?=
 =?utf-8?B?WjNMK1VKcHI1LzNyMWthb0o0b1o0TWlBOXRBUEsxUUhWZ2R2dXRRRUFhenBx?=
 =?utf-8?B?NnBOSjNWdUV4dTlCOCttbFJ2NTR4dVJXZlRxbEdObEhiOWtwTGlodEQ5U3V6?=
 =?utf-8?B?Wm1FU2xGM25ueTM3bXpNckRyT2pKR3Z1MllGeVZFaFZHK3dNTTFOWDZxc29T?=
 =?utf-8?B?VFlraWRSUzQ1UnpXTEsxTHFHVUQzbWhHOHRmcXF6VG0xN3IzSXFZRGhDMzRm?=
 =?utf-8?B?WGFFV2Z1OEpncFloNm03RlZZeXd3TlphV3p4R3ViQndwb0RqQVNmM054S0FD?=
 =?utf-8?B?dUlaa1NkTGo4WC9lcUdJS2wzSUFpQWNLYTFXbmdCdzQyY2NZVWVpWW5PSzVw?=
 =?utf-8?B?Vm1hc0FCaXFIWmw3b2xsbWNaam0yVjhiTGVHMFpCWkhsOGVZbVlwU1ViUGZv?=
 =?utf-8?B?dUw2MDlab3crT1NiUzN2bG01eldsSldLeEg5T1lkM0taVHNteWdaeFAxZUhr?=
 =?utf-8?B?aVpPNXRpakdZUlJ0emR6M0t1bnFjdm5jUVJoa0tINmxOVlR5TS9nMDJoVExi?=
 =?utf-8?B?NVFYcXpkS2ZqbHp5dldYUG44WHo0bXBieFJEU25Ld0FiTm9rQkVMeUxNRjNC?=
 =?utf-8?B?dmNueUh5NFU4RHNXMWI4VnEvK2FNTzJ4N2tqQStvbC8xTExZWE1mZWYvUmg2?=
 =?utf-8?B?TS80blVNanREcXYvSkY2UUw5c2xYMUhUK3VrRHlMQklkelJLSm1wQTB2bTcx?=
 =?utf-8?B?enFVSVdtdzVlaDFuSE4yUkh4TWl4WlJFM2NzM1pBcDFpbkdjTVg2Ry9WSkxR?=
 =?utf-8?B?cStnSStVS1FuR3pzVktMUE9GUUZ5dzVKVVU1aGR2UEN3cFhpZHNGU2lHVk52?=
 =?utf-8?Q?5SOP5gtp1Mi72Fy2+5cBCN2mox3owkRw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmtlVm1FNHN0M0RmM1dEd0xBYUlMQTZIeVI4V082dHJsanUvK1hvU2RpRjl6?=
 =?utf-8?B?NHVXWmJGb0o3c1lrd0hyMGVJTE9nNXZGVDZYMlpXRDgxWHdMSG5JME5WSm9n?=
 =?utf-8?B?RkVXbFBna1Y2Ny9RQmhUc2JEakQyTFJLRkZWSHNNOFBmYWUyWEhqYWdyQmZw?=
 =?utf-8?B?RFY1MFpZZEh4R1lmK01hbjk0TDQwb2g5U2pGRFQzaDBwYUpRdGZJcWd6U3dw?=
 =?utf-8?B?UzNqc2s5WS9LalJUUGp2YU15VW03Tkc2cDNNNDNnaVFSbEN5NURaZGNZa1Vh?=
 =?utf-8?B?ekhDTHJCUHhVTDZKdTIrTSt1TGp5ZktYeGNxSzNpMmVVNEpSb1UxeDBxcnVv?=
 =?utf-8?B?UkpsaEN4TWZHRThpOXZlTlJHcUdtaFhNZDNoNmRLUkhmdTlZZTFMc1N5ZUZI?=
 =?utf-8?B?Qm9BaUlGV081elpJd2JoZmhZVWZac2RDRU4vZ1c4OUhCOVpUVnU2elMweEF3?=
 =?utf-8?B?V21vbzA0YThxZVJML1g4enZBY3FwdTZFMzhNOEhLYjVvS3dkQlc1TjNSOVJH?=
 =?utf-8?B?TFEvQitCaHBKNTBEOHAyUzBQbHB0N1FLSWw0bTlYTXJXMlBxQXA4dDNTUEE1?=
 =?utf-8?B?OVR5RmpEOTBwdVdnUFFwemxXSUFkZzRLT2huUGIybGFiSnlkN0o4VGxKSEZn?=
 =?utf-8?B?TlZnZHFUMlo3TzJNdld2RjJUaGI3NlJReG9jYVZVaVhVampYaWlJeFFvQ3A5?=
 =?utf-8?B?SHpCMjlYbXY5VUNVQmZveFkxcEpyQzIxWVAyQWxYNGxmTHl2MU9tTUcxcWVs?=
 =?utf-8?B?NGhwdFk3RHowYnpZYmxPODlRREx3YzlFd3RnZWM2dlpLWk1PWWFxRGZQK01C?=
 =?utf-8?B?TEJIKy93bG9PVVExdDhPZzRuVDZJUUtuUnViZk9wbDRJRG5Jdmk2dmEwYXdw?=
 =?utf-8?B?YzFEN3J4OWJVMEpnVlZqT2RBeTdPQ2hhTEdCZmFVS0duSXFFZnpHQUs4dExz?=
 =?utf-8?B?TGY0U3JPQXUrYktzS2hsUW5tc0dQVHROQk5hMnJFM1hBanpGVGY2UVhnV0tx?=
 =?utf-8?B?Q2ZEOGp2bWRBbDJiOXVwSGYwcDQ0UGxOdXhZc05LZmR5dHcyOTVFZitoWTBI?=
 =?utf-8?B?dXI0eGpDRXFmcDdSVlpCWXVKV2JRQjVnb3I1TTVUNCs0djBNK3BSNVRmYURk?=
 =?utf-8?B?aEZlYWt1Z3NMMERSMmZBSExCSGRaS3JWMlNuOHdzTmNmN3VlNFJkK0VmZXR1?=
 =?utf-8?B?Vi9QSy9uY21aMVhXTFh3c3lOSE52RUs4RW9WWWZ4TkFaY2lKaGxjLzFveHZh?=
 =?utf-8?B?UHhaalRUbk82OUo5cWo3VHlwOXVuekFYRmJCMjNUR0F6QXkxU0NMTUdvN0V4?=
 =?utf-8?B?WE52WE9mNzNwY3hlSnV4ZjJkYlZJSkVma2tCd2ZpZ0I5alBKRWY2UDZ0OThO?=
 =?utf-8?B?clZRV3hlMzF6ZTJmMU9UNmhRekN2cVB6SkE0S29ZRzlRODlvTnhWZWNxNXJM?=
 =?utf-8?B?SC9WVS9KY2JWTFhXMnladnBtY0xKUisveU04cVBCR05idHk5SEdSTU8yZUNI?=
 =?utf-8?B?RHZaOHMvNHh2c1VBdVRmNFd0eGJDS2hNWXA3R3BEaENyZVBJMVI3TmszL2pm?=
 =?utf-8?B?VEN0RmFQV3JwQkk2RjJTY29FWUR4bWJvUEtyZE5BUU4yS2UwUGs1blRHUVVh?=
 =?utf-8?B?TmwzTnJWMnlhc0NsNmFIQ2pPclJ0NlJOd2IxaW5YODY2amRFcVlTWFJsanRY?=
 =?utf-8?B?OVdLNFJHQnV2bFV5VXArdVREU0lxeGdHQ3gwejZDVk9PbThKRDJXYTc2S0dY?=
 =?utf-8?B?OStmR1VjQmtrQUVMcFNMWVBDc0dpYmhHZmgxakhRU0lpRnVmSTlGS0c2b0hS?=
 =?utf-8?B?di9BYS8vSnNjMkpPVFlLdWt5OWNnL2pad3JCVkRHVWhEaFk3TGdvSDlya2U4?=
 =?utf-8?B?bW1ZeldsVnZBd1M1QnhrN24xUUJ5SUNxVHlXMHYxYWhORTR6ZCtoaVBlV0ZH?=
 =?utf-8?B?SldxK08yOEM1K2NjZUwvYTVOVms5ckVXeHNUSlBPdDBGYzRoSVp4V3hkbWFB?=
 =?utf-8?B?M0dCcUJOaWZIQXFvNWF0ODlhQnFQRllaZ1pnTklVdDRodWNEaTNFaHV2QXBo?=
 =?utf-8?B?S3lpZXlOZFJFSGowN2hoRnIyYmNkNHZlblF2NXd0UWoyMkVXRWJtc0ZHMmlp?=
 =?utf-8?B?bUpaME1OYmR4VCtpS0ZnNnJ2aEc2R3hIUGFFblJzVC90WlJFUFRUUkxBQ0Yw?=
 =?utf-8?Q?SEzi0Mk1dzf005WUlB5i3x12ZX+MWR9kSfrwSsE3aSXb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2539fdfd-7e68-4e6a-3455-08de19052c8d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 05:11:54.7651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0PohFM/Uudff1rqO7hyjklqOW+zzg7JOVvFw90Zc7zRx6iLBW7mPJG6641564LllsLFua17OPHiLD07SKmDZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFEAC589ED8

On Fri Oct 31, 2025 at 4:06 AM JST, Joel Fernandes wrote:
> Demonstrates usage of the DRM buddy allocator bindings through
> a simple test module that initializes the allocator, performs
> allocations, and prints information about the allocated blocks.
>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

If this can be run as a kunit test (and it looks like it does?), I think
this would be more useful as a module-level doctest of `buddy.rs`, where
it can also be useful for educational purposes.

