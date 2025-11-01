Return-Path: <linux-kernel+bounces-881060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE19C27523
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 02:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F01A4E5CB4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 01:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFFC22156B;
	Sat,  1 Nov 2025 01:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r0HKKAaG"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013007.outbound.protection.outlook.com [40.93.196.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC7F1C8606;
	Sat,  1 Nov 2025 01:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761959273; cv=fail; b=iaVpwY9pvjFxzao/WTxPhmDQ7QuiUc5t7Hp8gSBC+ltvfQjL58MksPzQRfQ02hmQJ+6guZzyyuO/OGuk0S11mk+h+L5WCNnLmLWAFUA/J67pmbFfuo0QW64WeSoXmoLHGLfzKrQ+sRs/vZT6VAtqDCBVMAn29P0OF4wxsyZYNQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761959273; c=relaxed/simple;
	bh=XHyeZ4pUi9r2XndgI39Eg9PEBiXDajAc43atPxeRuFs=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=dj1ts5F+BpfCuJRqSEHETPwTHBb9J/4Vk/mKWDfqFS1XIgEsg3fp0eO5EcS1W20tSYwU55NrUJ/DDcPU1pqK+YjfN9u+2t8zVcoabsAzXWAd5rdiHWZjXPhwUQDjUSEiR2ESfTofGVwAa4wcFZ1QNaKqj4RWsEu+ZUHwrvO7G5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r0HKKAaG; arc=fail smtp.client-ip=40.93.196.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SAjvwPVAK992IeYjPOfMP/qBZ1sIoLADkW6rH9nGdWHNHFDYsEMI8DupmWorLXt9UAN7xKztggTRPXHTvxTasPfAcQ6cwk4Cj5pe9seMZii8AzL7E8596wqJgUM1yXucDk/ShpTbJ2Zi3nX0ua5Tes0j3xoWTBy2oxmUXroCeX6UZREHnQTy1VAb0eTlshCIMpMXvAlRzQ7euC47cGm5vTtZ9vNh4e2RtmWboBMdBReYNV1vWByklgtMZBfXyQZjvmeGEBt7ZXnU4QSM6ELW2+pmh7G10AYq1HwI142du7yocd6aZVLaFmq78aXovP0WowCqcqpft/pmsrR7qV2p5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrlDFh+1CSxlL2VuYHeVWoKvP8zJMHWBt7bq5oRCuPk=;
 b=tal/w9v6w+AcnB3yVFRuzy/FyM5Z4/iMMsUOtikdrGF0vgwpvXO4Cm8cy+bpXs8hI586DdGQU1Z8A7fmbBNSqT0+YG+itHrbP7uNgIt3gfPBFn+zuOFeR6dbPMMds69MxueiLNxJhHNrPC/J5P0PlxLh5OIp9hTCS495ILVDKwh+eZWvMR8OEnahJ7TyIoXhW30hu38pk14MFEX6siApK8xQfPmWejn+UQsd3EXuqeD6jq3a7a6dQTVecV9MVeuAYlLf1v7NZc3Vl08HbtunKg72nwanEpqj814ZCV1gLLjuVWwqd1itZOHaP9V57U3VUJe9Tq2Hwngya5X66aUXDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrlDFh+1CSxlL2VuYHeVWoKvP8zJMHWBt7bq5oRCuPk=;
 b=r0HKKAaG76dpQ0ozjs9uu/2nD/ZrCX3TKKj8Rm9c52UXBlYKtUHMxaon0capCVCD+5pfVXo0LOiydPSGrQRVBS0Hlaii9CHXOBduBcfmJBOADaHS1Eo3T0c6mQa3Bp3SKbR13yhP73eL1xN4Aprv7MjvwslaAGheW2y97mXS32zE0Vkmwb7yPFhHGhsVcnNOvCQvzIjHcpNkNScm/dkhtT31N4OkBzjo0nA9gHKWS8RHojbEX/t+A9noSClYc7f8oSm5YBuSbBszbcbnlqnp2zI4iqoSuH0JPBT8HEkAb9g88ykMKFg8fz39TGYSHkMKuuyR/FpOjLVEMLcJHZJkLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW4PR12MB6753.namprd12.prod.outlook.com (2603:10b6:303:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 01:07:47 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 01:07:47 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Nov 2025 10:07:42 +0900
Message-Id: <DDWYFIZLT334.1R58VVG8U59T7@nvidia.com>
Cc: =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, "Todd Kjos"
 <tkjos@android.com>, "Martijn Coenen" <maco@android.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Christian Brauner" <brauner@kernel.org>, "Carlos
 Llamas" <cmllamas@google.com>, "Suren Baghdasaryan" <surenb@google.com>,
 "Burak Emir" <bqe@google.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] rust: id_pool: do not supply starting capacity
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alice Ryhl" <aliceryhl@google.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Yury Norov" <yury.norov@gmail.com>
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251028-binder-bitmap-v3-0-32822d4b3207@google.com>
 <20251028-binder-bitmap-v3-3-32822d4b3207@google.com>
In-Reply-To: <20251028-binder-bitmap-v3-3-32822d4b3207@google.com>
X-ClientProxiedBy: TYCPR01CA0208.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW4PR12MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: 01feaad0-3d0c-4786-ad02-08de18e3119b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TC9teVFNY3BSc1VheFo2OTVtWjRxMG9VUmdKM2FBRGJQTkZmbDBRN3puRjBV?=
 =?utf-8?B?YmN1TmF4OWNFU3h4Q1htTHkwb1YrMnZwc3QwbHlPS1JXM1hJWHNOQ0IvanNv?=
 =?utf-8?B?dDFtT3gzcm1iRVhkSGJUOVhFZm5UTzhzVVc0T0dRS2liS2loUWI3UERYVllI?=
 =?utf-8?B?aGozVUlYbXZwOFlGVUNKSmRYeWg3Mit0eEt3L2RmVUNxL3B4ZTdRdHNtNTF6?=
 =?utf-8?B?UlRIYTkzNlBaVEpLWTh1WEJhM1B4VWdrSkd3S2JCRTh4VTVWQ0pJSnVZN3kx?=
 =?utf-8?B?N1ZQSmFwNFNKZys2TitFbXJsNlBvTDdFM1ZucFVnUlQ5d2RsRWdsYXk1SnQ3?=
 =?utf-8?B?cE9MVlA2Q3J1eER3cXgvWU45NTh4dDFLZXBaZHRLZUNRcllNUnZGR1dCajda?=
 =?utf-8?B?U0NFY2dSQU4zUEdnbXJKbUpXQ0ZKYTF6ekZKMGFyZ21qa2xMdnFsWXAxZ1g1?=
 =?utf-8?B?dlBaekp5Q1ZpWUtadU8zc1A1dTJHcFFOR0NEQSs4OGwwbHlzQXhHc0YyM3VL?=
 =?utf-8?B?ZnZCQkU2OU0zS2piQlNkd2pJQkdyMm0xOGhRTXhjZlZFSUgwOEgzUkFGeWVp?=
 =?utf-8?B?T2hFYXJ2aGwxL1ZaUytOaXlyTmRJbjFnTHZCZWd3SjI0QkgvUlBCMG9LM21m?=
 =?utf-8?B?TkcrY3ZyRnlQOHl4TWxKSHFpZVdoSnVzN2xNMmZPU0ZiSllBSi9PdFFKVnNm?=
 =?utf-8?B?Q3BPT2UrZTFxQ2xCTG9SSzBDdGQ1L2Q2U05Fd0tkTnBSdDl1VW1pNVovdnFp?=
 =?utf-8?B?SlpJMDlXUENBdTZhMzN2clVjNWJhK0RhQmdCVDJNK2FPTUFTZCtCaHlzWTkz?=
 =?utf-8?B?bnNyQmVER20ydjZqMlRnSU9IVzB5Z2hWM1VwaUZPcWxLUFRkUjdVaFhRc1ZO?=
 =?utf-8?B?d2pOSWxjcHRRK2tBZEx2cjVUTnE2R3BjSkN5cnY2T2hOSm9LYW5XRVNPTjVh?=
 =?utf-8?B?TGRhc2g5b01wY1ZyRmo5MHFJYm5OSXlZVzlhR25QaUQ0bE82clpwbjhTUlN1?=
 =?utf-8?B?UzZvcnlPTjBGTUVpRll3SXFnQnlWc0ZkQkhjVmNuUm1odUMwd1JrTlVETCtt?=
 =?utf-8?B?SU5JUWpOYnkyRmljQVorUHVNY3V2NDdkdUppY0dCWll6bThVUmZ5Z1RrWndE?=
 =?utf-8?B?Tld0dk01d3JMbU1SdGJGYzd3cERaekhybE90ZHFsTTIwWk5Mc3VmVm9UbHY5?=
 =?utf-8?B?UXI3dHhZeWs4YWhEbEdIZXlmMmp5eXdHeE1yNmx2MTlkaXBodk9jVW1Nb016?=
 =?utf-8?B?by9KaEhOTUp5amR1U3pDekhrT21Fa2RZVlhKNmJ2TFRheXgyVlpHcmY5dk41?=
 =?utf-8?B?aWVxQ0F4UzZXaWtIUTQrV2V0a0dkU1Y1YVVEa2xudS81RUlDdmZvK21uaGZx?=
 =?utf-8?B?blNHVXhGbWE5SE5YMmpCUmt5QU9iUUNxUmlMUSszRGc4d0U0WVVPaU1BTG5N?=
 =?utf-8?B?WXFHTVhTUGpaRkZ1b0JFN2UzOFRacVg4MGcwcFdxQ0N0dCtLNjI5ajFzUXBI?=
 =?utf-8?B?UGt6Z1BVVVBTQUhJcGh3ZXpLb2tUVmpGNlErVnljeVgvVDkvQi80c2QzRTY5?=
 =?utf-8?B?WkVhejR2eFJlZHBNY093VS9oalNKYjdLeWhZL0ZseWNjYlFSdktlT3poU2dR?=
 =?utf-8?B?YjY4YVd2bC9FbXVZQXFDNjBoRzFwbnFkZzIrY253Nlo1VVZhU0gvZGlpc2lV?=
 =?utf-8?B?TE9KVW5HZzRSaGFTdmxhdW1lMmtjNFlnam1wcHBXNytIYVlQVHU4OXFld2Rv?=
 =?utf-8?B?VEpPc1ZqbGgzT2xMRm5Eb0g0dSswTVpOSi8zT0cvTCthcXk4dithVEJ0cjc4?=
 =?utf-8?B?U3V5S2M2Z3FjZ3Jxbmg2bDZPTUJNLzZTRHB0ZzRXNlFpVEp3NzYxWU9XbUFv?=
 =?utf-8?B?WERacW42L1NaT1RsYUNaWDAwNThlekJRMjB5aVJBNUphVWh3S0NTWWxUZFJK?=
 =?utf-8?Q?ML6MWgcNmCtTzdGA2zPQd9fzF+swtCkf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWtKUVMvYllGa0M0VWYvNFUzZGFDc2FnTUVybzBIdk14cFI0YXFqYThTUFRq?=
 =?utf-8?B?b1FveE9sTy81LzdXTTArSTRhSkN2dkpEWWZaUG5ZczRnK0NXdWtaamliWUhj?=
 =?utf-8?B?UmlVbzgya1N1aVAyZlF1RElzbGF6SVBUNElRbjJlVUlGb3ZzWjQzNE9PYnpQ?=
 =?utf-8?B?aExlZWNGdFVyVXlpNVJKUU1aYlhNSlZHaHFKMnR6dkYzbnNTUnlONTRuSTN5?=
 =?utf-8?B?UTV5dlZFd2lBa3lPYmluOUdvWFJ1UXRVUmE2cCt5Tk5KNkpmbXdYOFJQVHZO?=
 =?utf-8?B?bmF2bjVMYkFOWU1VYTc3c0c0T3JhckNKL2tqVjA1RGlqRDhBa0c5cWJ0bURu?=
 =?utf-8?B?UmI0bWx4MnN0RGNLYk1nQ2lKM21KaDRXMytsY29ZUGR5VEl5Mm9BTkhlQ0tP?=
 =?utf-8?B?VjAyb1NhK1MyWVhrQVpJempoLzlPalJ1R1ZCQy9IcTFNQU9KeWh5QjVsNkRj?=
 =?utf-8?B?UVVxTGdnWnZuSFE2U015U2lNbUFjYlg5aFVCc2dMNkJyNlBJUFltVDlTclZL?=
 =?utf-8?B?cHBOTGFqT0xpMFVyMHN5OEhPaFEvR2lFUlVadXk5dEtwVHlLai9ERGc0MXBQ?=
 =?utf-8?B?WUthRkJGOXNFTG1mWDM1Mkt1SkhoWDRWc3RSNm5qSWRtWmVGdXBwSXNCdHVk?=
 =?utf-8?B?MEl4Tkt1VGNCQ3RpTVFPQU12NGp2MERSMzZrcTFZME1kTkZRczdiS2xlaWN6?=
 =?utf-8?B?WHJZcnpvQlZia0FZRlVXQXY2Y1hZT04rZk8xNnd2UmJYVStrVVBRelUxQ0Ny?=
 =?utf-8?B?eTZ0cGgwZHVPalFsRVFuTGxWQWJBUlJaaU5QeGtnZnFIRmVDOVN4MkJYMk5y?=
 =?utf-8?B?aENSS0xJUXgzRGU4VWg4dXhMSG9NeERhTFlDZEdMNml3UWtFdHJrSG1tMGNR?=
 =?utf-8?B?MlV4QjVQS2NOanJ3T2xVZmVVUzdabnRPTmdHZVRPeVpucXdGU3c3bjhySjBp?=
 =?utf-8?B?eE0vM1ZTcElRdmczQzI0Ky8rQk10My9rQlhlV0UwUC92elMwNTdOKzVBOUMw?=
 =?utf-8?B?WTcyOEtMWm5JbzltVkd0Ynl1RVFZUjR6aStWZ21OMjVOS0xiaWV5Y3VDTlNJ?=
 =?utf-8?B?WDFkYVFPaFVmSHE1Zlp6NHpBRld5TVd4Q3lTZDVQbWJ3OVl2cFVVMVBjbEM1?=
 =?utf-8?B?KzhHQUVHa2lCd0IwTThPZGZMTVIvZENxZ293dW9SQmovRUlJVGYzSVZDRUZX?=
 =?utf-8?B?cmhpTTYxWDBRSTNRSkhia3NKMzFoV1BIbllNZHc1VFdxS1d0VnhLWTF0UEpN?=
 =?utf-8?B?dExVN0lQVDVER3RneTErUndxMHVaTTNqVmxSNzdNRnZDcDlxM1UrQ2k2RnJk?=
 =?utf-8?B?UFRvUUZ2bDlYeCttVG5TODJKZlNpMkhjUGlYR1A0dm5laEZCM2ZQcUFBU2s2?=
 =?utf-8?B?ZlJwVjZpeTMycFFIUEtKYzRIZVU2R29DM0FMNXFrakV5US9VMWdLWWQ4c2Zn?=
 =?utf-8?B?dG1SeVFna3RvRnptVGlvUTNjOEZTRGpqaWpEUUZrcTJHN3lTWnlVMUF6eWFv?=
 =?utf-8?B?UTRnSEg0VjhQSTRtcmlIVmFiQXlLZUJ5TTJIUm51bU5WMDBEbk5wL1F4YnJH?=
 =?utf-8?B?bEpuSW9hSDZaL3pLWFF4RjhoVE5xMjVhMDZ6L2pZYUNwVWVNb2RUeGtRcmM5?=
 =?utf-8?B?ZytRSEN3WEJoZk1oWjNaeVRuQWNVbjk3TER4cXlqNkJ6R1JYZDBDOFdZMmZL?=
 =?utf-8?B?RkMxNDJwajBLdllWc0x6bnBOanZrUGdaVVFLaUZoSVNUaWxHSjN1NVIzVFpw?=
 =?utf-8?B?dkxZWW5vTDVLclByanNlcEFMdWdGZDBJR2YzdzUwblUzUmd6Yjhqem43VEFQ?=
 =?utf-8?B?Zms3TU0vaU56U0ZZcGdzeDhmOEk3T0tMTk8zRGozeFpsSHR6cTU4aVhUYkdI?=
 =?utf-8?B?eklPdjVqbi96TjJoaUliS1RrZmhTZ0tTSWlUMlcyV01WWXFub1ZQclgzdld6?=
 =?utf-8?B?V0ZOM1p1RHdHaVNiUDZPZExWdmJ2NXIzK3BvL2VoaEpXcEpqbmQydGtLeERU?=
 =?utf-8?B?a2RnV0M2Kyt6NkVuZkpYckprSmlhSUZ0bWhjTDg4Y080L25sODNacHFLMVdM?=
 =?utf-8?B?enk1TGF1YjNqd1ZEeElYbmFlOXJkQzVDUGl3enJ2M2tWbHZOMnhQU1ZlNzFx?=
 =?utf-8?B?eWRmZFVZRGtVeUpHU2ZFM2pxcWx0c2t4QW9sK05IaC9NZlNFSGtmS1lyVzFS?=
 =?utf-8?Q?X9ibu9KRNVAaXK5wT2syjOPzwfTGeeGxUgKXv+bcX78/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01feaad0-3d0c-4786-ad02-08de18e3119b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 01:07:46.9492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DT2DVMwK0meBa5oeAH9DwfcWIO1m1UeIDXqCmh6dRNuCJuz+HkdfggY4GjkwOWKIxxtHFu4WKuml4SuEdEVlCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6753

On Tue Oct 28, 2025 at 7:55 PM JST, Alice Ryhl wrote:
> Rust Binder wants to use inline bitmaps whenever possible to avoid
> allocations, so introduce a constructor for an IdPool with arbitrary
> capacity that stores the bitmap inline.
>
> The existing constructor could be renamed to with_capacity() to match
> constructors for other similar types, but it is removed as there is
> currently no user for it.
>
> Acked-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> Reviewed-by: Burak Emir <bqe@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/id_pool.rs | 46 ++++++++++++++++++--------------------------=
--
>  1 file changed, 18 insertions(+), 28 deletions(-)
>
> diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
> index a41a3404213ca92d53b14c80101afff6ac8c416e..d53628a357ed84a6e00ef9dfd=
03a75e85a87532c 100644
> --- a/rust/kernel/id_pool.rs
> +++ b/rust/kernel/id_pool.rs
> @@ -28,19 +28,21 @@
>  /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
>  /// use kernel::id_pool::IdPool;
>  ///
> -/// let mut pool =3D IdPool::new(64, GFP_KERNEL)?;
> -/// for i in 0..64 {
> +/// let mut pool =3D IdPool::new();
> +/// let cap =3D pool.capacity();
> +///
> +/// for i in 0..cap {
>  ///     assert_eq!(i, pool.acquire_next_id(i).ok_or(ENOSPC)?);
>  /// }
>  ///
> -/// pool.release_id(23);
> -/// assert_eq!(23, pool.acquire_next_id(0).ok_or(ENOSPC)?);
> +/// pool.release_id(5);
> +/// assert_eq!(5, pool.acquire_next_id(0).ok_or(ENOSPC)?);
>  ///
>  /// assert_eq!(None, pool.acquire_next_id(0));  // time to realloc.
>  /// let resizer =3D pool.grow_request().ok_or(ENOSPC)?.realloc(GFP_KERNE=
L)?;
>  /// pool.grow(resizer);
>  ///
> -/// assert_eq!(pool.acquire_next_id(0), Some(64));
> +/// assert_eq!(pool.acquire_next_id(0), Some(cap));
>  /// # Ok::<(), Error>(())
>  /// ```
>  ///
> @@ -96,16 +98,11 @@ pub fn realloc(&self, flags: Flags) -> Result<PoolRes=
izer, AllocError> {
> =20
>  impl IdPool {
>      /// Constructs a new [`IdPool`].
> -    ///
> -    /// A capacity below [`BITS_PER_LONG`] is adjusted to
> -    /// [`BITS_PER_LONG`].
> -    ///
> -    /// [`BITS_PER_LONG`]: srctree/include/asm-generic/bitsperlong.h

A word about the capacity of this pool would be helpful here IMHO -
without anything one could assume it is 0, which is not the case.

>      #[inline]
> -    pub fn new(num_ids: usize, flags: Flags) -> Result<Self, AllocError>=
 {
> -        let num_ids =3D core::cmp::max(num_ids, BITS_PER_LONG);
> -        let map =3D BitmapVec::new(num_ids, flags)?;
> -        Ok(Self { map })
> +    pub fn new() -> Self {
> +        Self {
> +            map: BitmapVec::new_inline(),
> +        }
>      }
> =20
>      /// Returns how many IDs this pool can currently have.
> @@ -119,20 +116,6 @@ pub fn capacity(&self) -> usize {
>      /// The capacity of an [`IdPool`] cannot be shrunk below [`BITS_PER_=
LONG`].
>      ///
>      /// [`BITS_PER_LONG`]: srctree/include/asm-generic/bitsperlong.h
> -    ///
> -    /// # Examples
> -    ///
> -    /// ```
> -    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
> -    /// use kernel::id_pool::{ReallocRequest, IdPool};
> -    ///
> -    /// let mut pool =3D IdPool::new(1024, GFP_KERNEL)?;
> -    /// let alloc_request =3D pool.shrink_request().ok_or(AllocError)?;
> -    /// let resizer =3D alloc_request.realloc(GFP_KERNEL)?;
> -    /// pool.shrink(resizer);
> -    /// assert_eq!(pool.capacity(), kernel::bindings::BITS_PER_LONG as u=
size);
> -    /// # Ok::<(), AllocError>(())

Is this test deleted because the old constructor has been removed? If so
I'd say that justifies keeping it around, having tests is valuable in
itself and the example is quite helpful to understand how the
not-so-obvious resizing process works.


