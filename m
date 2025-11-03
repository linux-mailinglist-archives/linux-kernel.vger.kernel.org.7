Return-Path: <linux-kernel+bounces-882997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 398EBC2C3C0
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13AD84EF73B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46153306B06;
	Mon,  3 Nov 2025 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hcQAWtSj"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013023.outbound.protection.outlook.com [40.93.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF4C257854;
	Mon,  3 Nov 2025 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177346; cv=fail; b=BqeWYybBc2JP4KfBF/VMVxoBKEBchAh2QheuhvsLVQFKdrt8uS0CwL/ijD2GWFRXDp6YHvE3wSJaRGa/6eYL4w1q/3sO3TZimH9Kkt1SsGjD4WqCPsiNJLcEcKSaj5szDWmdBHGu1SrpsvaJ8mTpcgVf6dMhUz2UYrknEBOMSZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177346; c=relaxed/simple;
	bh=y008HL00jqbDy6UdbcSeRPj/MugCZPUkekBZMyVjOfQ=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=WlAhX0uWUdpp5ExkNKTzrlR3mniSmSsaZFKXTnLRNI1Iem2gIqrVbvXA0R0w6npLbOrGhVDEYM57iXh77VGcWNTLfJZKbNi9jak9eNIrjA9lGdn5PR/olQ80ACsh333T1kENpc8xHvezEkkKJdU6XSDQslaHKqjZz8FZ+shPjeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hcQAWtSj; arc=fail smtp.client-ip=40.93.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tziMLkczDtGRpRrJk2TmLXzUdDhyjV6JJtjCOTyz2Iqj+84DmUewASOVdzG1Aeqh2HpuWelSRHksujAAV+ts14dOO55jmdfuUPSAzmVL8CYYrnftoYKQf/7pgJBIfo80yg7dKOyDP9H+/guQ2AdpHdF+2QT3eQBjqpD3VoOBOHm3tye8Nhe34r3ZlBKfWOH6uTeRwR++CMb83OwboT4u/Aeb+rEHmC4vsOj/d5jp55NhhQ/NdDhqU8xtvatBl3SCEqITT0vWrVjYQCFdwbEPzxvU45KL7Qj1aFMSB1yZh2VoW/Ny3bQjWs7dYgBwWAAragWC1rb9BxnKkpPDfWLANw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10S63iNKliAfDPmlJKoHcjs4xEQQL8WNBVSxlnHMGAw=;
 b=BLcO4mKaDsv9W9cbnXHnli1GxkEUE4d5NoYtru3LL2POiYmgVF3t7rezlT3WHNtmqeFAALJhUrxCpIX3L4N84X2WTBZpNYv97vgC1huky8i6ZdXlarFUKp+jjOxN00jB504523LpFMIJNSTfVmdl31fOCzrJ6vv0Svx047+TzGXO5WMTzq8Hr/v0WiJbEJFGZZwbaNFk197sVxEm3bF8g3D4z+YZpKakh93EyCdv6t//uvhjOmVIW1X9u3aMwos0NLTjCwyeY0dubDVFkt06/OVh/cNiQl+dn8TplG5ekPhY9mQkpFVVGprSCyXFDpnYd9cqh3se43AzbD6UJG6wRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10S63iNKliAfDPmlJKoHcjs4xEQQL8WNBVSxlnHMGAw=;
 b=hcQAWtSjnpF56GcnPBz3kJfx3UYkTeGw9sPkivW2ctX+aII37J5zSIE5jcUsYNK/OK4PIZxuzpaj9fLWMdHVzHqh1+Baeg8rN+9OGaS9Dp7+q4DIDtO3f5T6ZzM51gbrvUZwZOYFfzaSJHmO0DLsyxg4HTKZpSE9hgBnxGhR7KFHynS4uhqB+QImm1N+yHzAOP+F66TwR6iwthpQOljEeYoq6hcstiQHJjZW6nMN7L9EiDl/Fd1+ofZhns0UaE+VJwMFNS/CH0GrJUhgPINeLRcRhiCpvmULh7gN6Kb25ghxp84Fi5IyB0Sn7dTAOc4ef9W9Df2ZeQR2uaOW5urvfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH0PR12MB8097.namprd12.prod.outlook.com (2603:10b6:510:295::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 13:42:20 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 13:42:17 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Nov 2025 22:42:13 +0900
Message-Id: <DDZ3QBBUM27H.MJS1S3WHWJO0@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Yury Norov" <yury.norov@gmail.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Jesung Yang" <y.j3ms.n@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/2] rust: add BitInt integer wrapping type
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251031-bounded_ints-v1-0-e2dbcd8fda71@nvidia.com>
 <20251031-bounded_ints-v1-1-e2dbcd8fda71@nvidia.com>
 <aQgQv6F0Ao4DH6U0@yury>
In-Reply-To: <aQgQv6F0Ao4DH6U0@yury>
X-ClientProxiedBy: TYCP301CA0077.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH0PR12MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef1b9d9-4a68-42f8-33f4-08de1adecdf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0wrZ09YVDNsdC91U3RLT1YyRS9iRkRLLzVUenZpS2V6SDh4N0VKOE5VMWpX?=
 =?utf-8?B?OEFld243UmpZNTdEak9GTTRWUTV1Y0xqcjFwcUtWa2I2WTNWejJYZHdHRFNq?=
 =?utf-8?B?MzdydklIY0ViYytoc1ZVQnl6STJ2Z29HWjErL1NHS3dzc3ZQVVMzdnM0bDZv?=
 =?utf-8?B?YjZSUnFxelEvSml6OVJ0ck1WT1V6TjN0bEtieGNsMDUrYjZOa2psYkMrM2Nx?=
 =?utf-8?B?cmVzQjkvRlYwTGNpbTluNVh1Rkk4blZqbXB2cHYyWStJTXpseGVKOFNwU2Jr?=
 =?utf-8?B?YWtzcG1lQ0oySlkydzZWNFZwUzROS21XbmJmZk1FcEhOVmRBWkxBS1BHTjh2?=
 =?utf-8?B?T0xTRW9Cc09FYzZwVzhDdTBvUXJIc2N3eXJYT1pyNi80QXpXV3owbzBLTFRO?=
 =?utf-8?B?ank0T1RlRWx4UEZhbGNCbkJpR2Vmbkd1Nmg2aDRiNUxyM0dlazkxenRpTHR5?=
 =?utf-8?B?SDVmNG15Rmx0TjVQRGdEbjFORW9URjJDOVk1YklvRG9zRklRWmtUbVhDSVps?=
 =?utf-8?B?T3JITHQzYmswZU9kN1ZtK3ZLejRrSnVkaHVLWDlRNlNWRit4akhUcjFTblpX?=
 =?utf-8?B?STJlalFleEh5bXgyUnN5Z1pZcktaSXkrTGl4aVpQT3kzRWV4d0U5VzVIYnIx?=
 =?utf-8?B?Y2c1THBCM3h3cnlGS2RKcEoxQmRtYldvZUgwOTJRTzRFY1lKNm5Ba0MweVBI?=
 =?utf-8?B?bi93a3hrVCtSOWtKYTBQQ2ZoTFlSOVZaTzJsK0o0VXpKL0RXalhkUXl3YXla?=
 =?utf-8?B?YVl5em9PVmh2STJ0NDdFQ3huYTRqMjFGM1hrWUd5VzlKNGJpWTNhM0Y5cEZ4?=
 =?utf-8?B?bERzblB4UnIzSWloR0FRdzJaZzZPZWN0c2ZqenllK0FqYzd5WlZnRFRURDV0?=
 =?utf-8?B?NkpTcjRKTXExc25GR2VqUjhHd29FK3pkaEdrR1RySnRIUkZEdXRGdHRhd2dG?=
 =?utf-8?B?U1FTOENvTUlkOGRlZVFqaTZ4RWtNUkd3bzB1NmhlSGxXc1V0TXVob0U4N2sv?=
 =?utf-8?B?dG8xZzMvYmJEcUNsQURkK0xCcHZ5bHI3d2pRc015YXNCR1p1Smk2NFhyY29l?=
 =?utf-8?B?b0k0WVJ3L3Z6Umk5TE5MblFBWW5BeEJ2ZXllQlV1cXJhL2hlbWx6bGpuMnhr?=
 =?utf-8?B?aml4ZFVFdy91UzFMeVF4aDZCSFY4LzFMSjFUZkpRdzA3Q0RkNXhhWEVKY3U2?=
 =?utf-8?B?Q1N2SHpjWnlJODZQSjRiQXk2Y1hkNUVkL0pnSDdzbVhjZVMwZFIvTHYzYnV1?=
 =?utf-8?B?dFdRc2VYemY0TkpjM3lCR0QyYWtFVi9KMEsyL2RrdERXUnJONjFOd2tJc1FB?=
 =?utf-8?B?NDJKQXN5VER6djZpMjluZHRuWWtqNEloMWF1MXpBbTNaMjE5VHZWNjJKbnIw?=
 =?utf-8?B?RUViNksxM1J3MFRCOWVRVS93Z1pPaVpyeUlkT3NLdHY4Mjhia3kyV2JpaHNG?=
 =?utf-8?B?QnBPbGdTcUVmaGpqWGozcU9COVlXWFNXOTJBUGNleHcyamxCUFY5NTQxKzZu?=
 =?utf-8?B?UDNCNGkrVXhyM01Kd1ZZUUpnZDA3NDk3NS9CWXJ4M1MrZCthR0Z2aUcrSlc3?=
 =?utf-8?B?U21tTFgzb0JlSHFhTjYzeml2LytaRkUyRmV0SVlyZ25keVJzTU1QbmdLejU3?=
 =?utf-8?B?TVNhTXBZY2hoRWFQV05zd2gyaEtFcEJMUDhuclR4ZFJOcGVWZUxDYXRnL2dJ?=
 =?utf-8?B?RUtPRWZyNEwvRnhYUDgvSEhJL3ZEYUJhekhLUjRBSXVZUE5qbUpBSGQwQkRL?=
 =?utf-8?B?U3pFeXl5YXoyQXZ6YkJRZ3BvZFdBNVFBaEJpY2VhaXRlb2VMc2lnWmxqSFZM?=
 =?utf-8?B?OGFYVFIvSDlDSXJkVlozOVgzb2hKUS9nUThEQ0FIRyt0WTFJa0NMUjRiRjRC?=
 =?utf-8?B?SnhrWXBScTZJQ2FueDIzZ1lLVGxKSWpKR29iQW8xYUNsUFA5NU83OEJHeXJh?=
 =?utf-8?Q?Pfmoc9qS/TmJ7R6mDm2NALo1yUDQ8WVK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1BtaG1HUGZ2cW9IMjlPa3FMVUFTVTNmdGxvMHRtSkVnSm11Q1Y4SXVrcm82?=
 =?utf-8?B?SGl5di84M0I1OVkzODBSVDBIMDBjalBxWmNnRlVRbExqZTZZMU1UZWJxWkhx?=
 =?utf-8?B?WlBWVFFGUk9hQ1FOK0RoRm5wekpvejkrNVBWbjloY2JnVnJ2TGZ2Wjc5QXVS?=
 =?utf-8?B?NDkvY2t2VzgydmR2MXFLQ1owWUtTVnBWSmpKTW1nL3pkUnVhYVhUR0RUOHJ3?=
 =?utf-8?B?T1NqRVlnaCtqUmJPaytXeFhGbGpwWFJJMUtNMHg1YU5mOUNPTm4xQ1cwNDRq?=
 =?utf-8?B?bVZVWGREeTcybkxacG5peXdqTVFDYm1mazZoWFpxcHNVenRHNVRFQVJ5Q1Z6?=
 =?utf-8?B?emVZY1M4WjVYNGduTFlSZGF6TFYvY0FMUS9ENlBZS3RodnZWYTRzdStBdW8x?=
 =?utf-8?B?RVIzZG9jWTNWMXAyRm14OFlhZHpFeTkrdWZ6SlppcTBvZEEyanBtbXlxVnRa?=
 =?utf-8?B?RFBaVkl0K2V5UFMrd3VBNmQrWjhobnp5QkhSdElBYjMycktqWDRhNnowMFBR?=
 =?utf-8?B?aldLa0QxbnUzMHcvNll3TXZHVG5oaFFmbFZPSHlKS1h1bGl3dW9QckFmbE16?=
 =?utf-8?B?amVhSStXNHBXN3UrSmxnc09YckdtRlQvOEdMekg4Q3hhTnU3R3hjazhxV3ZG?=
 =?utf-8?B?SXBudzZsYUlySC9GQ2l3bHdDdzlSWVdQN0xTaGc5azBwMUluWVgya0FsRGVv?=
 =?utf-8?B?Y2loR1ZoblZoQmtsZXNFeEptaTllS1BTQWpIRWQrTVJ0aEZIdjZScHllZ1hv?=
 =?utf-8?B?RklMVVZlYWpKVmtSRzVTVnpaNkE0ay9nWmdreVRGcmZLcWpFdHB0RTlxYlBQ?=
 =?utf-8?B?V0swRjkyWERmTVVYZ2d0MEVnc1pBOWhBWjhEdG1kcTNNc2VIYnV5T3R5eXhB?=
 =?utf-8?B?N0FEVG9LTjUxUUdHVGlqbGJxeW9VaGhNQzdUZGNBSDF6WXBrcUdSb2RTQWZZ?=
 =?utf-8?B?Q0V4TFhQelR2VTBIMHN3bm5RVkxMcTdzUld3WGFQdTQyNTQyd3N3VzcwcWw0?=
 =?utf-8?B?UWdzMEx0U09BbmZSdit2dkVVak5tamUvNHQ4c0NMS0s1K0JFWmwrSnQ0ajFC?=
 =?utf-8?B?bjk4TkdPR1lFYnJVL1Jrc1ZqaXE3aDFJSmtDc2ZXWjUwYjl6eW81ZjZnRlAv?=
 =?utf-8?B?emp3REhySWo4N21KZkgwSDlQcThoWnVrT0cwaGdVVk02UlVvejRBVFJOOTRj?=
 =?utf-8?B?RjExVjErdlozZFBGMXFvM2ljdDFyWTNuN1NqUjJKQml5RThCMVFoeEE5cDBL?=
 =?utf-8?B?Q2JxeEpMT2tmYS9wUmFoY09Kcm5WbkxINUVwS0hVZCtqcVd1SkhMRlpUby9Q?=
 =?utf-8?B?YXh1a0YzRDg0bGphcjBMbzJsOW1HemRNd29NeG9NdXdJclBld0liZENWanZU?=
 =?utf-8?B?Mlp5bytYcUZlZnJ4bGNnazE5bGdIQmFFOGNEUm1GbTNTZlEweWFoYU5FRDht?=
 =?utf-8?B?WnVZOGI1STY0T3VDMlBTUWM1bG14N2JmMldyK1FDcVdRNU40K3V3d3pVRHhw?=
 =?utf-8?B?T3RCdnBLY3grQU1SWFRrZ2hUZlE5MDByY09uOGJydTEzcWFnSm93b0JCYlJV?=
 =?utf-8?B?UlRLUThGQWptTVNWdFBEdWZ3T0Vld3dVUVhSeUFVbGxlREtBUzZzVldXbDJV?=
 =?utf-8?B?aUI2SElmM2NyZkttakFMUXI5WWZBVW90ODZlOHRYUDAwU25od1BDc1p3NG9P?=
 =?utf-8?B?QVZnZGlTS1RLQURhVFh2WHk5OUszbXlBZUlCSHdVUW9FbjRkN0VUMzcwdXla?=
 =?utf-8?B?K1J1anlGZ01pS0cvMGF1c2FGQVVvZlNReFl5cWdETWt0WjRUS1ZZU3FHektM?=
 =?utf-8?B?cHpRRzZEZ3FQYXZmYXFLYmp4NzRJZnpHM3d4UjI0NWg5aUtNQmpoSWloRTJL?=
 =?utf-8?B?bndsNjFzUXRnQ3dNOU9hZlFxYnJaRWtWQTVEQ3pub1IzdmhQYm9tOHZoM3Yv?=
 =?utf-8?B?b01HdEFPTFp6a0lScFBneEozbUVrbldoZitYTThUZUYzOUM1NmNrNzRkVFUx?=
 =?utf-8?B?WTMrYW5RYzcvSmVJOGNPSng0UitGSXdEbE9HSHR1eFZnYklvV3JQc0lRV3Uv?=
 =?utf-8?B?eVdJaDBXYTdPbGhuMlMrNFN6aTM4bnpGUUNpSnFPWi9NZ0IrK3dCZ281STIv?=
 =?utf-8?B?eU1mdzNWYW0wRm42b2RIYlVudkxlN2xvMStwb0VFcWtDc1QwcHBrcDVDeUg5?=
 =?utf-8?Q?WuUx+ON8/mMvH6aggmjK4eVtaH4Qtb1/mQCj1mLHxwex?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef1b9d9-4a68-42f8-33f4-08de1adecdf3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 13:42:17.7211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axrNUySyMlV+qD/wjtTW4b5KUVIbK9BxPT1xY11GS2cx+lFWy+NrPdbqfyTQ6IUoAupuGLkJ9N3jPC0rmN79WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8097

Hi Yury,

On Mon Nov 3, 2025 at 11:17 AM JST, Yury Norov wrote:
> On Fri, Oct 31, 2025 at 10:39:57PM +0900, Alexandre Courbot wrote:
>> Add the `BitInt` type, which is an integer on which the number of bits
>> allowed to be used is restricted, capping its maximal value below that
>> of primitive type is wraps.
>>=20
>> This is useful to e.g. enforce guarantees when working with bit fields.
>>=20
>> Alongside this type, provide many `From` and `TryFrom` implementations
>> are to reduce friction when using with regular integer types. Proxy
>> implementations of common integer traits are also provided.
>>=20
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  rust/kernel/lib.rs        |   1 +
>>  rust/kernel/num.rs        |  75 ++++
>>  rust/kernel/num/bitint.rs | 896 +++++++++++++++++++++++++++++++++++++++=
+++++++
>>  3 files changed, 972 insertions(+)
> =20
> ...
>
>> +/// Evaluates to `true` if `$value` can be represented using at most `$=
num_bits` on `$type`.
>> +///
>> +/// Can be used in const context.
>> +macro_rules! fits_within {
>> +    ($value:expr, $type:ty, $num_bits:expr) =3D> {{
>> +        // Any attempt to create a `BitInt` with more bits used for rep=
resentation than its backing
>> +        // type (i.e. create an invalid `BitInt`) must be aborted at bu=
ild time.
>> +        build_assert!(
>> +            <$type>::BITS >=3D $num_bits,
>> +            "Number of bits requested for representation is larger than=
 backing type."
>> +        );
>> +
>> +        let shift: u32 =3D <$type>::BITS - $num_bits;
>> +        let v =3D $value;
>> +
>> +        // The value fits within `NUM_BITS` if shifting it left by the =
number of unused bits, then
>> +        // right by the same number, doesn't change the value.
>> +        //
>> +        // This method has the benefit of working with both unsigned an=
d signed integers.
>> +        (v << shift) >> shift =3D=3D v
>
> In C it doesn't work:
>
>         int c =3D 0x7fffffff;
>         printf("%x\t%x\n", c, (c << 1) >> 1); // 7fffffff	ffffffff
>
> Neither in rust:  =20
>
>         let c: i32 =3D 0x7fffffff;
>         println!("{} {}", c, (c << 1) >> 1);  // 2147483647 -1
>
> Or I misunderstand something?

For a short while I though this was indeed not working, to my despair as
this looked like an elegant solution.

But then I considered why we are doing that shift by 1 in the first
place: that would be because we are intent on using only 31 of the 32
bits of the `0x7fffffff` value, in order to encode a signed number.

And the positive `0x7fffffff` value cannot be encoded as a signed
integer of 31 bits, as after ignoring the MSB the next bit (which would
be the sign bit) is `1`. So the post-shift value differs from the
original one, and the creation of a `BitInt<i32, 31>` for that value
fails, which is working as intended.

If OTOH we did the same operation for a `BitInt<u32, 31>`, the
non-signed nature of the value would make the shift-and-back operation
produce the same value as the initial one - allowing the creation of the
`BitInt`, which again is correct because `0x7fffffff` can be
represented as an unsigned value using 31 bits.

I have tested both cases successfully - so this way of validating still
looks correct to me.

>
>> +    }};
>> +}
>> +
>> +/// Trait for primitive integer types that can be used to back a [`BitI=
nt`].
>> +///
>> +/// This is mostly used to lock all the operations we need for [`BitInt=
`] in a single trait.
>> +pub trait Boundable
>> +where
>> +    Self: Integer
>> +        + Sized
>> +        + Copy
>> +        + core::ops::Shl<u32, Output =3D Self>
>> +        + core::ops::Shr<u32, Output =3D Self>
>> +        + core::cmp::PartialEq,
>> +    Self: TryInto<u8> + TryInto<u16> + TryInto<u32> + TryInto<u64>,
>> +    Self: TryInto<i8> + TryInto<i16> + TryInto<i32> + TryInto<i64>,
>> +{
>> +    /// Returns `true` if `value` can be represented with at most `NUM_=
BITS` on `T`.
>> +    fn fits_within(value: Self, num_bits: u32) -> bool {
>> +        fits_within!(value, Self, num_bits)
>> +    }
>> +}
>> +
>> +/// Inplement `Boundable` for all integers types.
>> +impl<T> Boundable for T
>> +where
>> +    T: Integer
>> +        + Sized
>> +        + Copy
>> +        + core::ops::Shl<u32, Output =3D Self>
>> +        + core::ops::Shr<u32, Output =3D Self>
>> +        + core::cmp::PartialEq,
>> +    Self: TryInto<u8> + TryInto<u16> + TryInto<u32> + TryInto<u64>,
>> +    Self: TryInto<i8> + TryInto<i16> + TryInto<i32> + TryInto<i64>,
>> +{
>> +}
>> +
>> +/// Integer type for which only the bits `0..NUM_BITS` are valid.
>> +///
>> +/// # Invariants
>> +///
>> +/// Stored values are represented with at most `NUM_BITS` bits.
>> +///
>> +/// # Examples
>> +///
>> +/// ```
>> +/// use kernel::num::BitInt;
>> +///
>> +/// // An unsigned 8-bit integer, of which only the 4 LSBs can ever be =
set.
>> +/// // The value `15` is statically validated to fit within the specifi=
ed number of bits.
>> +/// let v =3D BitInt::<u8, 4>::new::<15>();
>
> What for do you make user to declare the storage explicitly? From
> end-user perspective, declaring 4-bit variable must imply the most
> suitable storage... C version of the same doesn't allow user to select
> the storage as well:
>
>         _BitInt(4) x =3D 8;
>
> I can't think out any useful usecase for this... I believe that the
> optimal storage must be chosen by implementation. And it may even be
> different for different arches.

Alice provided a good justification in her reply, but let me elaborate a
bit more.

C allows itself to implicitly cast values when performing operations.
For instance:

    signed char a =3D -128;
    unsigned int b =3D 120;
    unsigned short c =3D b + a;

    printf("%d\n", c);

This absolutely not confusing program is perfectly valid and prints
`65528`.

For the equivalent code in Rust:

    let a =3D -128i8;
    let b =3D 120u32;
    let c: u16 =3D b + a;

I don't even bother printing the result because these 3 lines alone
produce 3 build errors. Rust doesn't let you perform operations on
primitive integers that are not exactly the same type.

So that's the first reason for explicitly passing a type: so you can
perform the operations you want with your `BitInt` without jumping
through cast hoops. This is particularly important to use it with
bitfields, which is the primary goal.

Another reason is that even if you don't care about the size of the
storage, you should care about its signedness, which is part of the
type. I played a bit with C's `_Bitint`, and managed to produce this
wonder:

    _BitInt(8) v =3D -1;
    printf("%d\n", v);

This programs prints `255`, even though I used the signed "%d"
formatter? Maybe that's because I should make my `_BitInt` explicitly
signed?

    signed _BitInt(8) v =3D -1;
    printf("%d\n", v);

Nope. Still `255`. Go figure. =C2=AF\_(=E3=83=84)_/=C2=AF

You cannot do that with our implementation. You either specify

    let v =3D BitInt::<i8, 8>::new::<-1>();

and get a proper, signed `-1` value that prints properly, or do

    let v =3D BitInt::<u8, 8>::new::<-1>();

and get the build error you should get. No ambiguity, no surprises.

>
>> +/// assert_eq!(v.get(), 15);
>> +///
>> +/// let v =3D BitInt::<i8, 4>::new::<-8>();
>> +/// assert_eq!(v.get(), -8);
>> +///
>> +/// // This doesn't build: a `u8` is smaller than the requested 9 bits.
>> +/// // let _ =3D BitInt::<u8, 9>::new::<10>();
>> +///
>> +/// // This also doesn't build: the requested value doesn't fit within =
the requested bits.
>> +/// // let _ =3D BitInt::<i8, 4>::new::<8>();
>> +///
>> +/// // Values can also be validated at runtime. This succeeds because `=
15` can be represented
>> +/// // with 4 bits.
>> +/// assert!(BitInt::<u8, 4>::try_new(15).is_some());
>> +/// // This fails because `16` cannot be represented with 4 bits.
>> +/// assert!(BitInt::<u8, 4>::try_new(16).is_none());
>
> Nice! Maybe .is_overflow() instead of .is_none(), so that user will
> know that the variable contains truncated value. Just like C does.
>
> Can you please print the exact error that user will get on compile-
> and runtime? How big is the cost of runtime test for overflow? If it
> is indeed nonzero, can you consider making the runtime part
> configurable?

`is_none()` comes from the `Option` type, so we cannot change its name
and it's the idiomatic way to do anyway.

The runtime cost for overflow is the double-shift and comparison with
the initial value.

>
>> +/// // Non-constant expressions can also be validated at build-time tha=
nks to compiler
>> +/// // optimizations. This should be used as a last resort though.
>> +/// let v =3D BitInt::<u8, 4>::from_expr(15);
>
> Not sure I understand that. Can you confirm my understanding?
>
> 1. For compile-time initialization I use BitInt::<i8, 4>::new::<8>();
> 2. For compile- or runtime initialization: BitInt::<i8, 4>::from_expr(val=
);
> 3. For runtime-only initialization: BitInt::<i8, 4>::try_new(val);
>
> In this scheme #3 looks excessive...

This example was not very good. The v2 features a better one:

    let v =3D BitInt::<u32, 4>::from_expr(some_number() & 0xf);

Here assume that `some_number()` returns a random value. You cannot use
the static `new` constructor, as the exact value is not statically
known, so the alternative would be to use `try_new` and check for an
overflow error you know cannot happen because the value is masked with
`0xf` and thus will fit the 4 bits.

`from_expr` allows you to create this `BitInt` infallibly, by relying on
the compiler being smart enough to infer from the mask operation that
the value will indeed satify the constraints of the `BitInt`, and throws
a linker error if it couldn't. If the program builds, there is no need
for error checking and no runtime validation.

>
>> +/// // Common operations are supported against the backing type.
>> +/// assert_eq!(v + 5, 20);
>> +/// assert_eq!(v / 3, 5);
>
> No, v + 5 =3D=3D 20 for a different reason. There's nothing about 'backin=
g
> storage' here.
>
> v + 5 should be 20 because addition implies typecasting to the wider
> type. In this case, 20 is numeral, or int, and BitInt(4) + int =3D=3D int=
.
>
> I tried C23, and it works exactly like that:
>
>     unsigned _BitInt(4) x =3D 15;
>
>     printf("%d\n", x + 5);                              // 20
>     printf("%d\n", x / 3);                              // 5
>     printf("%d\n", x + (unsigned _BitInt(4))5);         // 4
>     x +=3D 5;
>     printf("%d\n", x);                                  // 4
>
> Rust _must_ do the same thing to at least be arithmetically
> compatible to the big brother.=20

Rust doesn't do implicit casts. I do agree that "backing storage" is not
the best choice of words though.

>
> It makes me more confident that this 'backing storage' concept
> brings nothing but confusion.
>
>> +/// // The backing type can be changed while preserving the number of b=
its used for representation.
>> +/// assert_eq!(v.cast::<u32>(), BitInt::<u32, 4>::new::<15>());
>> +///
>> +/// // We can safely extend the number of bits...
>> +/// assert_eq!(v.extend::<5>(), BitInt::<u8, 5>::new::<15>());
>> +/// // ... but reducing the number of bits fails here as the value does=
n't fit anymore.
>> +/// assert_eq!(v.try_shrink::<3>(), None);
>
> Not sure what for you need this. If I need to 'extend', I just assign
> the value to a variable:
>
>         BitInt(3) a =3D 3;
>         BitInt(10) b;
>         int c;
>
>         b =3D a + 123;    // extend
>         c =3D b;          // another extend
>
> How would this 'extend' and 'shrink' work with arrays of BitInts?

I think this discussion would be more productive if we don't rely on
examples in a language that is irrelevant for the current patch. :)

Rust does not allow overloading the `=3D` operator, so these implicit
conversions from one type to another cannot be performed. Having
dedicated methods is an idiomatic way to do this according to my
experience - an alternative would be to have `From` implementations, but
doing this elegantly would require one language feature (generic const
expressions) that is still not stable.

>
>> +/// // Conversion into primitive types is dependent on the number of us=
eful bits, not the backing
>> +/// // type.
>> +/// //
>> +/// // Event though its backing type is `u32`, this `BitInt` only uses =
8 bits and thus can safely
>> +/// // be converted to a `u8`.
>> +/// assert_eq!(u8::from(BitInt::<u32, 8>::new::<128>()), 128u8);
>
> 'Backing type' is useless here too.
>
>> +/// // The same applies to signed values.
>> +/// asserkkt_eq!(i8::from(BitInt::<i32, 8>::new::<127>()), 127i8);
>> +///
>> +/// // This however is not allowed, as 10 bits won't fit into a `u8` (r=
egardless of the actually
>> +/// // contained value).
>> +/// // let _ =3D u8::from(BitInt::<u32, 10>::new::<10>());
>
> If I explicitly typecast from a wider type, please just let me do
> that. In the above examples you show that .is_some() and .is_none()
> can help user to check for overflow if needed.
>
> Otherwise, user will hack your protection by just converting
> BitInt(8) to u32, and then to BitInt(10).

Doing so would require validating that the value in the `u32` can fit
within the 10-bit `BitInt` one way or the other, so the protection
cannot be bypassed that way.

After comparing this implementation with C's `_BitInt`, I have also come
to a more fundamental divergence between the two.

The C `_BitInt` is used to express numbers with an arbitrary number of
bits - which could be less than a primitive type, but also *more* - for
instance a `_BitInt(4094)` is a valid thing!

Which is really cool, but also not something we need or want in the
kernel. Our purposes here is strictly to limit the width of existing
primitive types to provide extra guarantees about the code. And even if
we wanted to mimic the C `_BitInt`, we simply couldn't without compiler
support as literal values larger than a primitive type cannot even be
expressed.

So although I liked the `BitInt` name, that makes it quite a bit
misleading for our type as users could think that they will have an
equivalent to the C namesake, while the purpose and use is different.

The original `BoundedInt` name was a more accurate fit IMHO, but I hope
we can find something shorter.

