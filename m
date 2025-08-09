Return-Path: <linux-kernel+bounces-760905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF36B1F1DC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 03:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 348BE7A6C2B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 01:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BED27702E;
	Sat,  9 Aug 2025 01:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dy/qAP12"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3027197A8E;
	Sat,  9 Aug 2025 01:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754702964; cv=fail; b=UTmzxjKAd6y/L9Ic0NN8BiDtEW3t84L5vLpKgosQKB8YvWWi9WQL/ktSamEvR9YKnj3ySdyXK9Lq7WboRG9KweIRRdMZSF0Ok6FO2NdueRVm7+U/V7aMBqu4PDl2IHziwHBciOUjaovPRanWdrW3Ekdp3r66FDdWaTUVBtiB8zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754702964; c=relaxed/simple;
	bh=NEPksGcc6TX9WWYa64O+hYCnZ4tRxcAv+XCfYog+Xw4=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=NakE+Ibx3ndHn55v1D+X7CnVLL4YjefXOtmZqtzgIg81rL+5d+ZQDnm6F4sHpU8suUcKdrDJNOuM53yfAk0y9Lh/fI/hYO4fgSexWKZKdYwlA2ObC4MK8kGVLHGgAMPFeJUttxC5Z6QigJQQAPCoVYzPgeBmVLjPSP7Vv5RsJnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dy/qAP12; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uu03JhXRWTdAWYFeWJYGMa/aWa0WJ+piBFOUgdHkTTxybJokqjGDQ8BLHYy+IymxmgLKvSDz5QnJhs1KFr0S8KwyLWTHwa+PL6AxXdzNsAcb78zuZN93l80HG/Usyiwvf5bk5mpAxnQDSSlif3isDPtIgJJhATjrQY0u2a/uO/15ip5dmxO3li1uF1OZeO9x4GYjSehFfZnLYe+3dQZV3knyqCE1cR4a/7RyuQSACVF+AqCQ8JEKFbYqSp24iOpZa24E0s/97WbTnN3OoHHwiQlTS56gv+erJEmYMZmYzKnQdmPn/8jD7TrZ7+VUIp5q0s9cooavRbMZD8qWdnsJaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEPksGcc6TX9WWYa64O+hYCnZ4tRxcAv+XCfYog+Xw4=;
 b=NpyHUnqFnUuKz+vY4BTIwIGwnxBZGBDXPNT5VO74ZU1Acgjgr7Pr15/v9lAd3UjuOjyHpnHpO+un9So5+C3sgwzRuobqw83n2myYGH8tHM2629OxI96yRHcv49H7pN3aXSw6nvZOqqG0lSXZG1NZGkanLRiX6LN+LJoGWVf+Jp/Bo/MnalVsdA7YZgNVQTTMwKAzucNLPc1uCiwFlmRRugVJB3b0ZKqNZ6EYLIMLaNuMZ2odLbyU8HhZp0K6OSElqmiOM8pHRkS7G5+xk7TOL3ugprBM2I0AP1pr24mfynHm9xA05L4XdU5ghLUcIgGHVbRHtlE/mmqpCWBgqet2Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEPksGcc6TX9WWYa64O+hYCnZ4tRxcAv+XCfYog+Xw4=;
 b=Dy/qAP1264qsFDdtlMlZHen4z6GoZ7I+EUhqBWtzpae5xdpFOeXT3J3MMe5cxW0qojniMOGAOmIlIwfW6QGLPYwAdpB2Rb42KMbkqlHUktTGAypSAKow+sCUaU13UAGfZnb53d6CmQQq2iosMSj0h6vyYded5OVHSRPXEsVssd+QBxa4Hx1lR7uym+uQrWLjQ6BfdiRcgnIOUptk8o+ChSnCHvvmxRfStZWnr0CX8FzVybOe4fuSBwRmtFdIZEj7CR2PgkVwF2NTevzmO4IovYgQIlF89Zpt8JDUwWf7nvWS1wGg77DTI3QuHJ2XbTKwmD+XBK4TNFYlb0LuNeWsKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB8143.namprd12.prod.outlook.com (2603:10b6:806:333::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Sat, 9 Aug
 2025 01:29:19 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9009.013; Sat, 9 Aug 2025
 01:29:19 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 09 Aug 2025 10:29:16 +0900
Message-Id: <DBXIA9OM67GN.9LNQ05ZB36GU@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Tamir Duberstein" <tamird@gmail.com>, "Alex Mantel"
 <alexmantel93@mailbox.org>
Cc: "Will Deacon" <will@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>, "Mark Rutland" <mark.rutland@arm.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/5] rust: make `Arc::into_unique_or_drop` associated
 function
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250723233312.3304339-1-gary@kernel.org>
 <20250723233312.3304339-3-gary@kernel.org>
In-Reply-To: <20250723233312.3304339-3-gary@kernel.org>
X-ClientProxiedBy: TY2PR0101CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB8143:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c913d60-5a4c-4add-13a7-08ddd6e42952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFZkRkdUR2t6N0J3S0MrZUtFaDFNRzFPc204OHdBZlhkQ1NzaUdJWmp0dWxa?=
 =?utf-8?B?Qk80ejRiWEFMcUNYNDBIRjczWURvbHQzSjhvSHgvQTkrWUYwUEUwZ0p0aUtr?=
 =?utf-8?B?U1pHbk1Da0U0c1NMTXl1Y2hreEJDUUNtWGMyMm05WFo4SnhHOG12R29lc21N?=
 =?utf-8?B?TDRhdFkzY2NObTlDcXhFQmpoRkUraW1NZy9CN0t0azUvNlRTb3E0dS84bmFw?=
 =?utf-8?B?Wk9aUjVabmcvMDFpZnQ5ZWdVOGpnTG9mVTJ5ejV3am84VlR1dlFGK1FUbzhh?=
 =?utf-8?B?U1FzelNTVjI1d0JXZjZudjhTSGJwejhGOU9neXhQbndtSFNMYlk3NG9YZ1BL?=
 =?utf-8?B?SUdtR0h4MENXZXRORjVNb1gxcUxRckFSS1JPZ0ltanBuUHNkTkFCamVMbFpV?=
 =?utf-8?B?SjhWQURnTFlKUVZHQ0UxZnowQmVWVjh3Uk5CSTZtbEdTcGRDKyt0VXB6L1BE?=
 =?utf-8?B?OW1mcVZ0SUtTUWk0ejVoTlBaWFFDWXd2OW01TXB5OU9nSElOOExMUktIWHQ3?=
 =?utf-8?B?WFE5WXVxbm5FK25iNFY4amlPZ0VrQVBRdUlDM0RHTzlyd09uVGNrMEpJZitt?=
 =?utf-8?B?RnQzajZEYktuQlZSeG15SVJsLzdEbTNzYksyOEgwaURSMUNlQnlJTnpNRFRD?=
 =?utf-8?B?bHhpQ1NndnU1SVlaQVVjT1hMVjdYalF0Ri9iODc1UndRR0RoajI5T3dJcjVo?=
 =?utf-8?B?cWhWdDM4L0Y1bzhKWjlPRytPNmFOZG9nU2hzbkZxM01oM25VRVkwd00xMUts?=
 =?utf-8?B?c1BQd3VUYWFKUkNrRUFaM1pKT05GOEp2THJOWnFOdFdpbWN1RkI0U0lGK1k0?=
 =?utf-8?B?NDRtT0s2bkp1QVhkdGx0eXI5TWlVU2NCdjhiVTZPRkQvRGRGQmFkWTNYRjNZ?=
 =?utf-8?B?NVNHeGs1cXZBMmRyQnlobm1iYUUrTU5IdFY1VjhUcFRoN0FFRnpOb1c2Vmg0?=
 =?utf-8?B?NG1VSmpsWWtrcTJDaDZiajFiay9wVWZYV3dlMGI1TDZDYmx5RStpMDZLdDBL?=
 =?utf-8?B?eGxsTjhWVUNoOWZrM1Y4NWNRbjhINmRGd21pc2E5K2dsVmJjbXlzeEFpQWVC?=
 =?utf-8?B?TEFRcUNLTjRMOEVPZkp3bEE5ckxMdS94M2phVk5EOE9mVzFMNndYdWFVMWhm?=
 =?utf-8?B?VXJtZkNpM2NIL3VrU0xjeVF1RTNIc3dldXBNQm1NYUZZN3BCRjRpUEh2Q3Va?=
 =?utf-8?B?NWZ1OUFJNGlsRVgvc0NrUXlua04vZ2NoWm9xTWJnM2xmRisxc0svdXl0VDhr?=
 =?utf-8?B?aXozT1B0UllYVjlrUU5temJNQWh4S0hwT2Q1MFEzZTRUZ1E3WTRhRjJLcmxw?=
 =?utf-8?B?RWRMaU84aEpIUG9CL29USnhTcWZxZFBsNTNmVHRDejA5UXhOWndBTUlZcWd4?=
 =?utf-8?B?bGtNOEo0ZUJHME1XMG1LeGpPTFJsL2FsLzhUbFkyR0orMFlMTEF4ZmRVTkth?=
 =?utf-8?B?SmpQQVhySENsY2RaZmRtQjgwVTZiUGk2YVJjV2gyOTlWYmZJOG5XZDY4UmQ0?=
 =?utf-8?B?Q1dySUpiMnE0cFVlNmxSNWxUT2luQjlWdytuNy8ra3U4MEJraldFTEFFWkdF?=
 =?utf-8?B?RFhhcGhjM1ZqY1dRejVnVzRFZGY5Wm5jV1ErK1gwcTZ3dDQyNnlGbkZWT2Fr?=
 =?utf-8?B?SDl1L0lsVXpBWnVQNVpVUStKdDkxWWhjaC9hYk9WTDY1TmVRUW5xa09lbVR0?=
 =?utf-8?B?S1orNFh1emdCU0h4a3JOM3o5bk5UL2szWFM2a0dTbHl0bnM1bFl3TkdUTkV0?=
 =?utf-8?B?NXRWNXVESVZScDVRQ0NzMTBBNmxvMVEyYXJwMzhvaXdiTzFKVU0xV0FtVFU2?=
 =?utf-8?B?MEhaYVM4bDVOWG5FSjVaczdOakZSeUIxeXRiNW4zSmJTK0hYeStVeFAxd2xw?=
 =?utf-8?B?aXVzUzM2SkQvVDYvSDVPZUgzU3Noa0JMZnl4YzVVTTZ6dE1tZVYvTTRKeFlQ?=
 =?utf-8?B?S2l5dEJVV1pjS2ZoRE03RmZFQlFlQzhRWnBtWHBRSmFzQWpUWlIrTGlsMnpv?=
 =?utf-8?B?Q2F2c3B0REtnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0QvK3NXTGVqMHFtN09Va2JvQ3k3bGMrSHhZS05LeHkxM3VDaWlCQit2cTdM?=
 =?utf-8?B?N250MFc4WDJhZ0ZMWDhGck5HS2UrVWNISFd5dUZPcUl6R0VOUGpwQ3JyUWZm?=
 =?utf-8?B?bG9OQnJiV1ZZUndKZndraVFCRDV0M3NaK3NPajZ2dlRGYW1YdnV2b1RPVFFM?=
 =?utf-8?B?Nkp0MEQwZ1pNMnNqKzQrOUdudXJ1TEY1cGVoc2x1ajdPclB5aGNucW0xUVpk?=
 =?utf-8?B?NFhvRE9RaTAweEZ2NnN1cUQwb2xKQ3VuY05iTnBOSVo1elZIWm5yc3NPakQ1?=
 =?utf-8?B?RGFENzFJajk1SVBEdDUrYWZqYnEyY1RlR3kzNytMeFJtKzJLeExZTUo0Vklz?=
 =?utf-8?B?S3hjenA2Yjd5b0JicVFQZnpoVEk2ZFpteC90dEFlNzBwRUMza01UUlFQZ1Zp?=
 =?utf-8?B?TG9oSDUxNEJSTWtaQ3B6LyttcGpQTXMzc2orYmlsNEJiaWROcGpQclNUTXA4?=
 =?utf-8?B?S0RodS9DbUZjMkpndmZUR1NKdjZISG9TSHFlZW81VldaR2swTm1ZOWpaYUJv?=
 =?utf-8?B?TGhLc2t5YndOR0lqSTM3VFZCZU5POUt4T3RVNk1qQ2R2dUkvRHROcVllK0dp?=
 =?utf-8?B?VXBMOEVISHRlR0wrT3daMnQ2NUU1Zm55TlduaitLaEdFdFE2R0xXazI2MVBy?=
 =?utf-8?B?aEN2RS82Z1BQbWVKZkVCVzc5WXdoTjI2RDdkNkM4QThOOXkrV2pRQ1pPSU93?=
 =?utf-8?B?ZmdlNFloOWI1ZXFyYWd5S0NiYVZnWlZ4cTBVTGg2TVQ5YXhKdVJyemlvOWgv?=
 =?utf-8?B?bVlTV0RUWSs5SlA4dllsckV5ajJ1bDhTbjdsdkd6a3Z1ek92cVVORnowSXRi?=
 =?utf-8?B?Q0pDdFJXeERsWUNyTk9PdmpDNS9GZkdUZnU2L01NdG0wQVBGV2dZRXFhT0Fk?=
 =?utf-8?B?ckF3OFZjVnJKUXZMR3AveEQ4bjZLaWV3YVFZd3kzcTNBUzNNSUVsOG50K0Qw?=
 =?utf-8?B?SXc3ZHJqNlpEL24yN3dqM2lLYVJlM0RaQlNpcHphY2hUQ0d2L2RQTjVEYmJB?=
 =?utf-8?B?cENGWHBRZ0R3MHBxd2FCMWpKcXZkWGFYTDIwR09TeElBKzVYLzRGTThVVkd5?=
 =?utf-8?B?Rm8ya29FbzFXa2hYWVNpdFR4dG02cDd4clVRbzZiZGtFTnh4T0ZkdmFGWkxx?=
 =?utf-8?B?RWNaaU41Y1JGM3JPZitUaHdIOFpINDRmMVVqSjY4Z3ZTSEJVK1V6dlZQVHBD?=
 =?utf-8?B?dFpDZFN6Q2s2RUhnWEVkYm1wRkprNG4rc2tvVWl1RlV4ZWRjSXJtZGxPeGdC?=
 =?utf-8?B?UHY5NXdqZHJPTVVUNkp3VW15S3MrUzA1aUxLWmw5bWsrMlgrNGV2SlRlQ1RX?=
 =?utf-8?B?QXFPNzhVQWMvZWQwNVlxSnJuY0Y0eUxiNVVOZTdnT25NbTR1U05tZzRmMWdD?=
 =?utf-8?B?VUJId24xcHBMSzhWbFMxZGpwUE0wZkZkODVEQm9kZnpiMi9pVy9iSkFGVFB2?=
 =?utf-8?B?K0JQTmVYRW8rMVNqV05qdFRBOGtoMDNpVjZ1TGpWdmZnbDdLY1NUZm02ZWdO?=
 =?utf-8?B?WlYvSTA0SVhRSHpqdklmUGduRnZUS1VSendLM0ZWSnZ1YnZxVXFqWk85OVBE?=
 =?utf-8?B?Z0F6UEJSQUZ5WEJqcTkzT2JSWndiTU1mMVpxdmdQRDNBOWV6dVRSKzRyOURy?=
 =?utf-8?B?bXZOMTBHamxXVW9aSEt3VCtXalJqajRRUjBXQS91Ti9La2FQN3ZnK0dqNVNl?=
 =?utf-8?B?YXJ3MHpURUoxSktpOGJ3SlFZZnpoOGg3RFFtMUpyQW9FbklOVGYzQ1ZRS0Y5?=
 =?utf-8?B?UkEvUDQ2TFNPbXVveGVNeFNKK01kMVd0WFBsMTlqZXFORE5pV1lWdEthcnVC?=
 =?utf-8?B?Rm95cHFzZ3N0YW50MDJYN00wMHdMb2R3VEMxdmUrRjZvSmtHKy9qY0dEaWwz?=
 =?utf-8?B?ek95cmQzZGE3L0JrLzg4akJ2QjJ3YkloY3RDWHJhSTYzU3NRazl2bE5Nc3Rl?=
 =?utf-8?B?UWQ1V0RRUzFKU2phNUM3NkRPVTNDVmZwMUdXenBoVlprUlVGUnY1ZHdIRFZx?=
 =?utf-8?B?UTh2VUQ2RC9GWmszV3doVXhjajhLTDZzZFZVTHFROUg0MFl3MFBBQmxpVEpu?=
 =?utf-8?B?blg3bFhLbTNtUTJpZHhuRE4veTdrbWMweHBHeXNHUzNZUXVWRjhic2lhZmZG?=
 =?utf-8?B?cEZwZmY2MmVGS0lrSDF1RVNMa25DUlg1ZHlvQUJKa3dvM1VFZVM1MzBjK1VE?=
 =?utf-8?Q?5KxAPDBsy5RUPJBfWdKZz5WE0CxT2ZHfE8nL4SziNFT+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c913d60-5a4c-4add-13a7-08ddd6e42952
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 01:29:19.2375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olGPKdAZ+EAOjZMcc0jYIwwLQxZqfFVUwVNeAY0OGjvD4ng+BKNtOEjQg3Bdmy+shfe/4hLaeqdPA7FuSn+syQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8143

On Thu Jul 24, 2025 at 8:32 AM JST, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
>
> Make `Arc::into_unique_or_drop` to become a mere associated function
> instead of a method (i.e. removing the `self` receiver).
>
> It's a general convention for Rust smart pointers to avoid having
> methods defined on them, because if the pointee type has a method of the
> same name, then it is shadowed. This is normally for avoiding semver
> breakage, which isn't an issue for kernel codebase, but it's still
> generally a good practice to follow this rule, so that `ptr.foo()` would
> always be calling a method on the pointee type.
>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

