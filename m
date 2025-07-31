Return-Path: <linux-kernel+bounces-751608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0533B16B6A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD897547100
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11722405F9;
	Thu, 31 Jul 2025 05:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fFyonqjh"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5BBEC5;
	Thu, 31 Jul 2025 05:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753938322; cv=fail; b=FSUYms+nqhST4bHA+dnHohUbnyDQYag/QFsfrDz+lsz6ZxcJMLOWJ+hgs3V7eh2Q02HdaC6Ko+sdeM9P7P00KN1V4F2CZm0+NH+nUpjoGaN8Rwju55/U6xqVDrh/5X/hRklh4nhlqJAkpUPhkMKoU0tHoYyZbWlo3fNjOFJ/4BY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753938322; c=relaxed/simple;
	bh=GKgF1Ma/hrs7uyY9wBFMX2wAOqUFel0U6w+u355iPX4=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=PWHBDXH5e88uNpX90v+/LOJY+4p0XGyFi2PRC4TrP0aDySn7Xchr5pBFHR3wbVoTdx761yoP8maSechbB1taUXmss9uTv5r4vCLS1z4GOLHvD9KUXsu9cFdXzw84vr/AkYrRXVgmG1JEZObXjzsYy5BD/qjSSVE5HSD51TNyM+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fFyonqjh; arc=fail smtp.client-ip=40.107.100.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdxn86rTrpexSxh7VY3hDhqT1Cpit6XxhGSIOv892fPqh/LnUbyd2LIKV7Scv5n1Xpa6PgpmnNll3x7DR6wUbSILqd0pJlCNRD6DOAIYAAs4f/NfTIIBUJC984UBgZXF12t+0sHRH3SZ9dpeBtTID8u1I/fEme/UYuS8mWAiSlZom4dwFrGIM0xMxWCylW4Ww7+Xl6JHiwKld72lRdb8PGmqUqQYmYZ2ujnmvOFysd8gJVzFoVnWCGLKClDtyR/abvphaO5XufwzRIjduoGeKqcBOm8g3EfWB9oUKQjYvr0DqXQguLZQFEFQD6LiPq6Zi3/Z+hUDv4lz04/IrlGRlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKgF1Ma/hrs7uyY9wBFMX2wAOqUFel0U6w+u355iPX4=;
 b=y/2HtQlB8Mud/rqDDnDMXU3rYGkGIuA0fNze4q2dSSVrnTIDUb6jd43xTDOyak2prm1AAqILXIAzeR2JvueWRCjhFut2DS9QffZvoYtHsLD7u2WNnFvQj/AF7jKXA574Yh9gTh7WjNaFdozRduj1MdfRmE9YLsPBPekIiJ3SbCZDO+evLgVxlxWPNYshUGF4/6A9ptFTc70sPWiI2gjY0Mc+CXMXIi+/vXEJm2aN1e1AyIm3RogyK6vXXxWeGFhhHPXsCktm1L9Ea+gkkl8QJ/WU62oSlMrX0RGnNo/4PSSDZxD/b92YfaZvH8yVv1w/38BPrkacSUhegkLW4WcVUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKgF1Ma/hrs7uyY9wBFMX2wAOqUFel0U6w+u355iPX4=;
 b=fFyonqjhMtKA2CGsbqVFs9TYHhiVLeuJLo08ohVw70TKJGiETrC+LtUm9HWff7fL10nKVB7zasGcYxnnK1WhTaKdgBDsoy+bYvKAAHh50vaJsx0zFHnW9YFMZh7ki3XMr22htrbBYvzuvMlJwNHACYNOeJD4GNIJ61p45KAfzmo+nlZYOszS9NXlunO7lQPadNw4O1cTB2TlLzIVVrMgv0e7gTArdX/75EHS4KjhVlGprZDvqV5IhoiEw2Fof8otDpfBefFgvkfze4sBL9aHbaPPkdWjX+ZfRcC0k/EVrYhTm41evBAuskLCUUjjAq45kIdsd2zC4ugv5XYfGADBUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB6329.namprd12.prod.outlook.com (2603:10b6:208:3e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 05:05:17 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8964.026; Thu, 31 Jul 2025
 05:05:16 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Jul 2025 14:05:13 +0900
Message-Id: <DBPZ8PS2LCF6.20O09TKB7LCD6@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 0/2] rust: regulator: relax a few constraints on
 Regulator<T>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Daniel Almeida" <daniel.almeida@collabora.com>, "Liam Girdwood"
 <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250729-regulator-send-sync-v1-0-8bcbd546b940@collabora.com>
In-Reply-To: <20250729-regulator-send-sync-v1-0-8bcbd546b940@collabora.com>
X-ClientProxiedBy: TY4PR01CA0073.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: 65613c6c-3eea-461a-a44f-08ddcfefd6d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0ZpVFhmTXo0Q3FNejBTenRVMWNvUm9aR3pIZmJhREQ1WUtBWjB3WGQ5dHpk?=
 =?utf-8?B?a3FTdmNUUDEya2dwck80c2Q3SlU2VHRWbFd6OGVJcmhmc21xc2oyd2lTTzhi?=
 =?utf-8?B?R3hoTTJjL3duMDNWU0FkZTgwTk1DbjE0MHFUK1F4UDJCTkhHaHBVckxURjhI?=
 =?utf-8?B?OXU2S0pTMHpGaEg0WjhNKy93MjJRcmQrV2lKT3c1cUgwRDJnbUV1cURJZm0w?=
 =?utf-8?B?elNjakVoS01jMjBNVnJMSTBNYjMvcmJ6aVJNNTB2S2oyWjZoUnl2cW1iRFRZ?=
 =?utf-8?B?YUhpbHB6emNQeGJPVngwWWZqZFlMQzltVnl2OG11RkFPQ3craktKYmRYM0tm?=
 =?utf-8?B?cktEOGc5Nm8reHRpVTcxaTl0YkJ0eGt5czAwWmQwZ1ZUeG5SV0RQR0pZSDVi?=
 =?utf-8?B?Qlo0RGd5SzZOZkd3eVNHUUU0blAzbWxJWjlsVXNlRFV6bkZjSkxYZzdHNDdp?=
 =?utf-8?B?bDZTSWFadUhlU29NL1NoZEp2MHN6R1NCOHI1eTQ4WVdKbk5oVjJLbzFtRWRu?=
 =?utf-8?B?QkF5Y1RJRFhQeEZTM2RGcnc2VElTak8rcVVWQjFtY1RZaXZyT2Q5dHg5Y1Jo?=
 =?utf-8?B?bFN3amdhdHBldDZsQm4zSE94SWFIV3Z4OHg2Uzh5MWhPWWc0cjJtNk1HUzBq?=
 =?utf-8?B?NDJTWHljS2k2Rkx4V1RwdnpId0Z6bzFpTVU1eW5yY0F2ZEpDcjVPcnlUZy8r?=
 =?utf-8?B?QnZtT1FuSk9FNXNhazJCckV1THArZ29EUy8ycSs2eUVPeXdJTjdyWnZhMkYv?=
 =?utf-8?B?MW9aQXZmV1B0dGV2Ym9vZDErdFNDQzNBVGhBZnBhUDk1NXNFZ0wxSXNpOXMy?=
 =?utf-8?B?VHg1amQ0TDJCSGpqR1NKcTZQM3VUTmxzU2dzcUhLM0piWW1yQTB2bk1wRXhu?=
 =?utf-8?B?VkhVVWI3QWNrUjlKSEIrVHg3Ym1wTExyd1h5WERuZzNGbCszUCt0aXJuTitM?=
 =?utf-8?B?ZUwvUzJDb1pCbU40cjR6eENDQ1hyZFhzdUcwclR5REJIeUdqL3oybTBqM0ZG?=
 =?utf-8?B?VTNJY1RFOFQ2bkl0MVlocmc0YTBZTUtJNnFqN1czVDUrQk1pWEx3eFVkR0hw?=
 =?utf-8?B?Nm4xbVpia1c5S3h5SzNpSHNsM2x0R3RsQ2dUTDZUaG90WU1HQXRTVFM1ekxq?=
 =?utf-8?B?eGhZVE50ZEt0a24ydnFTU2ZycG1pdlNYSG5Fc2dhZ0VZK0RBM0h3eks5VnhX?=
 =?utf-8?B?V1FDUUF1aDBZcXZsVElVbGdtNm9lL3MzWHZvd1l5SDBsWUNXRXlHZ3RaUEVi?=
 =?utf-8?B?bkRZQWc2VXdxT3phaUQwQ3k0M21CcktTWi9UYzArNm1uZmNsY1N3eHY3M2Fj?=
 =?utf-8?B?K1ZuRXMzUk1kekxCeWU4TVFhQUlrWVhKV1FVS2k4NmFxKzNPVzRkQnV5bW9z?=
 =?utf-8?B?bnhFVVhybmI2R0RYcEplNllWS29KNjZPMzYwOXRJOFNubHFrVW1ZaHUxd1Jt?=
 =?utf-8?B?SGlpODlnbUdSNzBaK2lzb21mNk5JUTR5aFFTMTZ3Umc0MUtTcW9wV0tKMS9n?=
 =?utf-8?B?aGZhZjRyOUVXd2ZaREQzTXd6R3VPREx6VGdPZTFOamxFRmlsbE53MzJlKzZq?=
 =?utf-8?B?NHVBYUloTWRCUmw3WFl5amtUM3FremJlakVJTUR4MjNsZVpiT1lMdHZrdEUr?=
 =?utf-8?B?Z2xZd2FqazJQdy9JSDRibkVGSG53ZEtMZlhtd0VMZDVSSXpSMWViUzZZZ3ZY?=
 =?utf-8?B?OVdKNlVqVmM5MHg5bXBDeURMV3pWZmx5QTMyRWdBenVpN1c1dFd3cTFkVCtT?=
 =?utf-8?B?NTh2NXhVTmVRNDBncllNbmhOWTd5aWFDUkJxYkNMVC9QYnFLcHV3bC9yM3hp?=
 =?utf-8?B?SkxhaUxOaFFLeTNybGdFUXg5MTJHSWY1RWlod2VjaVB2T2RubStCc3lzcDVD?=
 =?utf-8?B?OG9VbGhFVEZNeWE3UjM1aFNPZUhsTDBad2t1aTJhQWVTR1NsbmgwT1hjNXNn?=
 =?utf-8?B?V2EyazlDdFNMcCs0WTBiWkg4aGZmUzF1MmppelRGTUNSaWg4a1FxYnZadzRx?=
 =?utf-8?B?SVNBRHVtTFZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmVoVHdMTlJaTW1MN1cwMzhoOG9lYllrU3hab2laVEdlY1dXZGFzWWZpcmR1?=
 =?utf-8?B?RytuOTk0R0w5SUp4WHpISTMvdW5jbnZVQmlISGI1TGlQVFR6eDlmQTViclY4?=
 =?utf-8?B?eUFMQTY4OWFjU2xIbFhNcGVsVTZmV01jTldaOFk0MlhMWEM5MHFUdDNsaGda?=
 =?utf-8?B?UlBrYzdqQ0ZFY2xjZFRiR2VJOThLdXUrZzdtUWVEKzBOa0premxMR2RCV2Fi?=
 =?utf-8?B?RXNkdjRwSWhwWEI4dHhhYis3Ryt4Mi8zSGYrQ1gwTmJ2ejFJekYwdllKN1Uv?=
 =?utf-8?B?TE5lbWN5NDNsUWt5ZGQ0V2JhTjdYVG01dXRGa3M1QnE1Qk9yUWdpbjlvRi95?=
 =?utf-8?B?cGhLQVJCQjFydDVsSEdBVnV5WCtTVTB2SXY5ejFVaWczN05McW9IVVAwWnM0?=
 =?utf-8?B?dExIcHBhNE1SbXhoMkZGc0F5dStnOS9STnVPOThRM0tuTURvUjhHNml0K2VM?=
 =?utf-8?B?amp1ZnBVcnZtQS9BVXUxMmFDT2xRVkhVK1EyRExGeDhFWXpKS1NOWXJUNDVN?=
 =?utf-8?B?T3lteGlaNWl1Z3BXWDdXMW1Vb1VFMFRlOVVhVzA1QjlraEJGbDl3ZlBUUE9k?=
 =?utf-8?B?aU9aN2tlSE1aTDkyK2dZbnZJWGVkd3lmQVIrdHBvaUFObUZhNmc3cEFoY2VX?=
 =?utf-8?B?dThqdWV2UjNkdnI2L1V1RzFiZTdYL2xrSzEva0k4ZlZyRHM4YkpUdnJRdjd4?=
 =?utf-8?B?VTlaSkxuVjI5Vm41TXIyNGxHLzJxL0VWbkZ5bnBuUU9GcEM3MVJTRFpBQ3Bp?=
 =?utf-8?B?STIvVjdiYS9lZ1ZlVHBXc1FxQUhTbkRoeHdXaU1ZNnU4ajVaRnhRNjR2bGRX?=
 =?utf-8?B?dTN0NC9vTWdjQzFPTWg5OUoxMG1TMDRZOVROU3NweitWS1R0RVdxak1NM1VJ?=
 =?utf-8?B?QS8rUlNRdWNQbnAvVlV5V1ROQ3NaZXV3WnhrUHU0Vi9EVHF5NnREODk1Uksx?=
 =?utf-8?B?TjFOTW95RzBGUTFubjVML3RiR010SWhoZm54ckZwQnhEUVBlYkQ2SmlabGZw?=
 =?utf-8?B?U2Q1WFNWN2h0ZnJFWmRBTGRYa2VsZS9UbFRtY3E5QlFRbWhaYXc4bVlYa3A0?=
 =?utf-8?B?Qm5jS25QZ3BJdWpLNTZUcXdWYVB3Tm8ybVM2V1FYWVc1cGdCYmQramhDZWhs?=
 =?utf-8?B?cEk5MXg5RVRQQWliRTI2Yk9mSTd1elU1NlNiSkY5RUJTVzlOVVJFZUVBUFk3?=
 =?utf-8?B?TGExcHdxaU50OUgzc3dESlJnWUtGQVhoNnFRUXpnSGw5dWx3Tk93R01JZ0J6?=
 =?utf-8?B?M0szdmVOWVpqK0Q4MkZmelpHR2gxM3NnSmtGbFdkbEtvclZBZ3JYUERpb1BP?=
 =?utf-8?B?ZVQ0TnFhbW40RHR4bVZWbG55d3U2S21Lc2RTbDZ2amdIdXNTWW9LV3ZpZml3?=
 =?utf-8?B?NWNBMGl2aTRYK2p5d1J4WGJxL2RWUlJJQjRJV3pBUjYvNGZCM3pXWnNFU2JM?=
 =?utf-8?B?V2FIVVlzYXBjS1VKUzhJbGhuc2EvWExyNnZpT0czNWg3aFg4bnZCQlEvajZX?=
 =?utf-8?B?ak41aHh5dnMvcEdnblE5ZzI4aldrN0RINFY3YkJLM1dUbkpwZXBoaDJXcWg4?=
 =?utf-8?B?ZzJKcTRtZjYrTmVVR1hIaVkva1Y2dHQ3K1BPRHF0WFZyWkxvcWtjUE8yLzZu?=
 =?utf-8?B?VlFFT3NpOEJGalpoQjdzbFVlZWtJVUw4d3p0aVpaOEluU3BoWWtNZEFLOGEy?=
 =?utf-8?B?eFRUcitoZ1JjeXRBUXU2MWVKYk9sc0JVN25OcUJ6VGI2TFY2MHJuL3VkR1ZS?=
 =?utf-8?B?czl1aXdJREx4dldHOFdVWEVVRStvOTB6K05CRGZEbS9yMTB4bTdoeWJwajVK?=
 =?utf-8?B?Um9qMDF6RHRxeFFUUFM4VFpVbVNVaTA2OW1kWmN0K0lDdzBqQ2VkeTVDbngy?=
 =?utf-8?B?QmlzVGN6OUdGS2YwekhhZ0x3UW5KOFRhZ0p1SDJsK0JldWhNRllyWW1DaVlY?=
 =?utf-8?B?b1ZUbGlrZTBEV1BKV0sxamZLcU94SkRieWZXZXpyVWliZUtCUnZsazBHZW9G?=
 =?utf-8?B?SE9RQ2RRZWRoK2t4cW9kRGFUd1V0T1A4dW1sQjhkTkVKMzhBRkhCT3M0YUJI?=
 =?utf-8?B?alJ1KzJTREdpU2t4aTBlSlMwUHk2ZzVNSXh4SXlscUhBbXMrVlYxbXJWKzZi?=
 =?utf-8?B?eWw2SEhCOTRvczJwdFBzb2xsSlpLbjkwcGtDR1Y1ZGR3SXlwcDByS2xuWms1?=
 =?utf-8?Q?GXdF4EI2P+OCBFXq4MG59+CwUKuuOPru9Vzh7Py4D8Ns?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65613c6c-3eea-461a-a44f-08ddcfefd6d3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 05:05:16.7257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hhsr/+vgJC+VPPUX+AgCslLZxH2BvE/g7ijXWxGFbK9QTehmfjbrzmPp9163wtn5lrykgpdr/PJL3ySNlwLqCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6329

On Wed Jul 30, 2025 at 2:31 AM JST, Daniel Almeida wrote:
> This series implement two related changes to address a bit of an oversigh=
t
> on my end on the initial patch for the Regulator abstraction. Note that
> this is not a fix, as it just relaxes the constraints on the previous cod=
e
> as it is safe to do so.
>
> Patch 1 removes some needless &mut self for functions that already provid=
e
> their own locking on the C side.
>
> Patch 2 implements Send and Sync. In particular, there is no reason for
> Regulator<T> not to be Send, and as discussed above, it is naturally Sync=
.
>
> This is based on linux-next for now, I am waiting for 6.17-rc1 to be out =
in
> order to rebase.

FWIW,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

