Return-Path: <linux-kernel+bounces-883071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 799FCC2C6CB
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 648534EFF1E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4105280312;
	Mon,  3 Nov 2025 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dkVI6B9j"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010068.outbound.protection.outlook.com [52.101.85.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE3D1D7E5C;
	Mon,  3 Nov 2025 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762180311; cv=fail; b=lsX73XX5bE848PKnTpM7C+SjuddZwYh++u8/xsg3kyyFCc/Q3a/0ScEfqVOQ2brTxJ+6IqrQ/HhUiDWMtGzT8QcKlaXM0+efvjTPCHefV9daTLY85CIqFNt9kbtG2F26hgAaM+ve9NQWY1+fsQZ1jgVVHyUm9dmqrG/fqx5hPzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762180311; c=relaxed/simple;
	bh=ZCvxBqFfmMTmsmxshahlsYwTVTmWU4pE2ZFMwKFUrBU=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=nsYDIsMCYSP8cYXZSs59OpT7oZsYZteXtKOQoXlgroUjV6J/gWQIL8qqOA2USRO0FcXx54gIWhfFbEudPnuDYJ6FF27KsLGjQ2fvzcJKZ9XH70PbzegpKh/0EbXRexoeyCDV2xN4cjQ0uu+I4/ZF7BhL6qmFBYKfqzuUWGlDsr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dkVI6B9j; arc=fail smtp.client-ip=52.101.85.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/odhpea+YJQrccSt1Ecijj7v2klTq8msHeGuH7X3TxiwrbCjo1P8D5adBZnICqgMKqZdvEDqDNd14SOJ326rlhZUCmuIIbBvioyC9ahacDWM8cE4hzfML9Vi2UNIrnq8eDeobq9JcKHYj2lvOqpjzDZreVZyn2J9Tj8o8k58slz9TXOlzz/PKAMROaBYgWmAUtsBp7Kov7DZI3xz8Ma4du7dsLQD3/EsXUmCgPgREmEawalpemMQRBL4QKktJBO9OmPOQMmnz+XNX7syOJfubeZgm0zGh9VjFA80bHtkL9XvtORyusHhf0ysVqgYi0Uxxx8KSLyXNIEEFCCX7t0JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3DFc99CCVbsDGmzR/8D6/Bvv82vRTkGDDTqepVVQ0M=;
 b=h2OS7ZMwvJfrJklPz3Y8Pt65uG5cuZ79I8vj/439ORmL8KwvBTcNgyHBPBMiLKUqlzEpDwn0EEnM8qlae3Uo7xCCK4PGsXF8gArVu0Xca5BImYFnL14hVm1kUsTSSAL7hj7RYf+ujW92/NsU1kHUodhAWDOg35X0A4I9otR+a/cm4bDk5lWadxpAU8wfeF1T5GoLfth5S0Ml7Q/+FEDXgXJ8z10Ck/efovvWUUeSi1dEwp34Yi5sCH20XAkszAK4rQDQEfs4wKndxcIAGy5ZfZMVkorgHtJiuOMB5vSNI6Uazg5bgPVHqlI/vnPtYV9klDGQ38PpeVpH6l+wz6dTGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3DFc99CCVbsDGmzR/8D6/Bvv82vRTkGDDTqepVVQ0M=;
 b=dkVI6B9jMv1XxqCI2Ng5JZhMgRL53DP365O8hWOFTrW3duhxEroEjOCRZ205Nf23OmN3wyPr683PebcX9GC6iM9z2K+nwH4Vp330obpdhv3l69lJ3lxiW/E9ZThpBU8nmXGbkbgGfZgdVNJ9SzVXoaCNeAdIMmChqBJtfCx0BsAlmK+71S9Kgd9Ks/dmOYbSO3u8TVhHjvOulSXDiX9To+WN2WrcNK4B7ASawKFJXXWaIm9nK4WjrgUYHAssdMSO3oVDsa15wSUho8fvdMkqjeuVDRjAldFcFLLwF5CxWhZGJrv0cEVfv15z6LZqDzSovAdgtwgCiKjqqQgOpXPvGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB7701.namprd12.prod.outlook.com (2603:10b6:8:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 14:31:46 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 14:31:46 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Nov 2025 23:31:43 +0900
Message-Id: <DDZ4S7O5ML1K.H8QOKW85N3L3@nvidia.com>
To: "Alice Ryhl" <aliceryhl@google.com>, "Yury Norov" <yury.norov@gmail.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Jesung Yang" <y.j3ms.n@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/2] rust: add BitInt integer wrapping type
From: "Alexandre Courbot" <acourbot@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251031-bounded_ints-v1-0-e2dbcd8fda71@nvidia.com>
 <20251031-bounded_ints-v1-1-e2dbcd8fda71@nvidia.com>
 <aQgQv6F0Ao4DH6U0@yury> <aQiIUj2WfihMxF7M@google.com>
In-Reply-To: <aQiIUj2WfihMxF7M@google.com>
X-ClientProxiedBy: TYCP286CA0169.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: b87e76cf-bf67-4543-e85c-08de1ae5b784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjYxRWlYRmNGUlVlR0VyQVQvYm5Nc3czZ3ZKWlZSZ3RkemVuOWd6OWRqcnYx?=
 =?utf-8?B?NDBQdHQ1ZTdRRmhaNjBxR2I4VzNnOTJNYXgyTXFQeEx6SVlsbWs5YTZ6cFo3?=
 =?utf-8?B?OFUzNEd1VThhQ3oxeTNuakNGYUx4Qmpyb3ZaRWVNYW9WWlJiV2lVd1EyUjRN?=
 =?utf-8?B?NEwvdldqUWdrbVU5amoyeWd6WG5iTjJFMS9nRXQzN0VtRUZUdHRWOFdSU2FG?=
 =?utf-8?B?Y0NKMmFrbUM0elN3dXZkUW83dmd5a29rODBCVkZabFUvcVA3cDdHdDAzZ1M5?=
 =?utf-8?B?VTV3UEV2VE90enNZOHVWYm8wWnVKMzJLN1VJRHJHT3IwbFhMQXdxL25HMHNO?=
 =?utf-8?B?MzB4VVdzS0p4aWlUbmYyaE1ncm9yYUtTSU90U3laQXZvM1pxT3JVNitGTEZk?=
 =?utf-8?B?eWJNTWtBN3pxZ1NLWUp3UW9WSndIWkpRbjYxelBaSUY2MFVoK1R0ZGRKNmZx?=
 =?utf-8?B?cmpvbXdPdnQvVnBSaC90cUFiL0x2ZGgwZ0hGRWxUMDl5Umg0REFoS2JEdEs3?=
 =?utf-8?B?S25MVVVwT2ZSUll0cHZzMmZzdHdta1F0dVB6RDR3dGJDZmNBZnZIRzMyeE9x?=
 =?utf-8?B?VEVpQkFFZkkrN01Hd2Z5TnRDdWZ3TnZ1VVNMQkkxclNxeEF2YW1WcXhxcnJt?=
 =?utf-8?B?M291WDAzYXZ0NTRVa3k2V1VNZWcxZHNJYmRzN2k1cXBpaFV4ZEIwZ3dFUkNX?=
 =?utf-8?B?VlRLNkJxMExRcnY1RFNsMTVYMFJLK0l5THhFdktkZWFnOVgxSjkzbXNPUm1D?=
 =?utf-8?B?d1VJVTh0UHBVbUM2V1ZwSUpxcGJTSVI2dTcvRU1qWldZMERqUGZlZXFsbUli?=
 =?utf-8?B?ckk5TkwzUSsvZkZ0amY0c1YzeXZyTTEyZ3ZNZUhhazlVODUvbjFZRzVQU0xw?=
 =?utf-8?B?T0VOQ3NhQXZYYkNHWW9pTDQ4N0Q3V3hWd09GdXRkOE9ZMXcxWGI1T3pDVUJl?=
 =?utf-8?B?czZPUVNxamxFTGVUa2ExZUFSajhvczI1dlNFeFRWK1hjYVBnTVdndC9VUkZ1?=
 =?utf-8?B?eTlOYlp4bUpYQXZHQ0JQbnZ2eWdXVSsvSytqNnNwMVkySEJBZlF3SjBoTWRI?=
 =?utf-8?B?eGptaVR6aWpHQm4rTktVejFReE1GVGZYcnFwL1V6b2hEeFlWYWh3L3oxa1Zt?=
 =?utf-8?B?NHB6dk11eGE4U0ZkSmtUVUNBcWlnT0xpNUZvUnhWNEgzbmF1MklBdXljYmRC?=
 =?utf-8?B?azloUEl0VWJFYVAzK1RHSXRZaWRkT0VpRDB6YUdZUGVKNTkzRHZvNHpabGI5?=
 =?utf-8?B?V1l6aHc1SjRVOUV4R21rVGpwd0pEQmc5aGkvYU9yY3RLQTMzUFFveHdZamlX?=
 =?utf-8?B?ekN2bTgyQ3g0aDR6OUNaVzN2NWNFMm0xTy9rS3JnbG4raHEwTHZwYlJnZitz?=
 =?utf-8?B?aXJpMUdJUnBpY3pXdVdhSWRvVUFuMFQyVTBUSWxSWFJxOEpsQnUrc3R5S01i?=
 =?utf-8?B?M2xyazVINzMwWVpNbVpYSEtpWnl6bXlXUnZMK0FuclNBd1JJMlR4RmVUTld6?=
 =?utf-8?B?UGE4S3FBZkw0VmxBd0MrbEg1RkFVUlJTKytGRXYxRW1LVHV6amhKYzhPMk5L?=
 =?utf-8?B?dnNrYjdYRmlKYW9ydzZOUTdmdEN4c3Y0dExRN0N3UkFLYndVR2Flam96UFZY?=
 =?utf-8?B?QlJUWUlMYzFOUzR3N3cyYm9uZmJnemVxN2gzS0MzeHVhNktXQXdEekt2L1Ux?=
 =?utf-8?B?U25qQ0pYdlJHUnVIV3pCd1ZkTGlxRjcwZXp2Wm80K3V1eml4UEUzcXBYZEt5?=
 =?utf-8?B?RHV3NW93a042UlEzWEdSbFJOdXorcUJPWWVUSlFwWVc2bWliV0p2ZFkxYUlC?=
 =?utf-8?B?R0JpY1AvZk9nc3g5MnZZQ05NdEtnZEFjcm96WE9ub2xpbzYvSE1GOFNUSm9z?=
 =?utf-8?B?d1lVUzArb1JzWWo5Zk85b25uMXc0cGJzTzlzaXQxdWxVcWc5QThoKzFoaTZR?=
 =?utf-8?Q?RONwkf0MDDlN5IokR4WO6Md7SbQ7dEhh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjE4SzkzVzBXTVk1ZXRKM1lZRDR1c0lCUkwwejhhTUJERmQ0bVE3MDlUNDFZ?=
 =?utf-8?B?ZTVaeXIydllIWFdwNWpsazJzNCtoOVNyVnFxWjg0UzJTTURqVnYzMUc0ZDlG?=
 =?utf-8?B?a2tTT1hxc0hMY1VvcHZmdzFaWFBXb1ZzWXZPaEtQeS9BRFpUc2tONWtnbFhZ?=
 =?utf-8?B?aXVPcWdsVjFmL2l5ZTI0dUVCK09JZFViYTRoWGFBUksvcjBCNFprWTE2V28w?=
 =?utf-8?B?NHVMYkJZemhObFlXS2RtZWQ5d2pVM3h2c3lQVkwwYnZsd3JtR1JsS1hUbTZG?=
 =?utf-8?B?RjZWNXhYakg3ejdlbjI2Q2VTQlNtYlgwNHFjTisxam9Hckd0S05jMldWWjdz?=
 =?utf-8?B?UnpyVjB0SlE0cytXMFdPUTZkd1did2o1bUxoUlhEQ1JJQ2x3SkRzQ21VVDlu?=
 =?utf-8?B?c1FMek5FNW55TlFidlpMSWR1Q1dOYVFpQW1JejRLdGRtenVvbGwybnBZakRR?=
 =?utf-8?B?aENIU1NiNUhMcXVobitiZkdzNENqckVyQmRYYU5HU2w3R2dwQ3NzNCt5VmhJ?=
 =?utf-8?B?QXNMc1p0dEVlNmdBZUJLZ3o4eXhkbXR6Vnp4S0VIS29pQVlkdklRQ1g4eFNw?=
 =?utf-8?B?b2VmdGlkbmpUMWNoZmJYT3A0RytnamtMRVNEcTcybFI3VTZRNmcrc1VQQm5y?=
 =?utf-8?B?dFk2L3ZYMmVLNDdUQ1Zzb1FvTG5Pc1NPOStWWE1lbVhIZGlRUlRBSTRTMm0y?=
 =?utf-8?B?ZkRDVFNQdUVoa0tYNEFNS0VVZ2puUTIyS1c4TnVMTElicS9ISUNsY2ZWVm9Z?=
 =?utf-8?B?eEw4Ty9vMlBmYkI2dGtMeGFiY2RtWFBOOGFGQlFZaG9iRU1GOWpBOUFPYkVH?=
 =?utf-8?B?TlNIMmpVSmUwZ1UvZHJGT3pPek14Y3NBdFFIM1ZnL0pKVG12cldoOWVFeEdv?=
 =?utf-8?B?bWdUUzh0WENzY05YaUZSV3AyM1V1TXcraGNkU1VIMXZGRHZ3U1R2K1g2dklD?=
 =?utf-8?B?cEVkczFzbWwrNHFWMVl3WmQ0dEhSZGdMR05rNldRTDJkR2REcmdtaFBiVWxr?=
 =?utf-8?B?dXMxQTFOTlFZUWhtc1FpWlcvUTdmVVZiSDdFNklFZGExZ3JBL2VuYVg1T2t6?=
 =?utf-8?B?bHZpUUtWSjJWeit6M0NvN1RNK2t5YjJYOTJGMjBnd00zR01oU0krZENNd20v?=
 =?utf-8?B?aVhianl6bUQ3YUZCVk5VSFplR0U4WS8wTkE3TktTUEVPYll5cHEvSHcxckt5?=
 =?utf-8?B?bG1BbTRHNkFRL08zYzNXREFybU1yZkJOd0hBM3prUWJIMUtIc05aSVRmMlRo?=
 =?utf-8?B?cE82RGFtblhKVmJNSFdMK0JPaWtqc0NvMEFmYU4rZ1orbHNEUW9MZFYvNitL?=
 =?utf-8?B?REJPY1JjTkNqWmZtRHJTNDFwNWN6dzZOc2tXdXJGWDlzZ2RKaGJmSTZYampY?=
 =?utf-8?B?enpJOW94VWlLcXlFNVRDN0R6MFY3ZVNoM1ZuQUJjRDcyeGxSNjM2RGVMMm4w?=
 =?utf-8?B?Y0NiOWk5MWRxWGhMeVJNSGVhTGphbjZ3Y0p0dFo5Z0JrdEpkclpNS0RYVGVK?=
 =?utf-8?B?U1dHakFWaFBqSHJoZjBvdGMzcVgvMEtReTZHRnVRQmw0dm9Pcmo0Y2hrc3dP?=
 =?utf-8?B?OUlOcUkyQjVZQXJ0M2hLa1VDZFFEUC8rMFFKcVZZMzFIUkU1dXZCQ2lhRmEy?=
 =?utf-8?B?ZzkrT21oYy9SR3ltbUVBSEk5TGUySCtBZzNWWTNzWDJUbW9lSEg5bGV1cDl1?=
 =?utf-8?B?NHd4bGdEVkxBVmJsczZPeEk1dmxMc295ZHJCV1BlODBqeWo0M1hBcGwrcU94?=
 =?utf-8?B?RFpGcGlDT1R1RW9CdWFWamk5ZlJIMFlUMjUwclJqWGFpSGsxbHRzRWdZSVhs?=
 =?utf-8?B?RUd2ZFhHcktlbURaT2oxY1VNMEZXbC9hMGdrWktKcTFaR0FXZUszYU55RzFl?=
 =?utf-8?B?akwxanp2Wm5LUFB5VXZKRTl0RTVkRjlxaDE2bVVJVTZYOVJXVG5TVXBhbE43?=
 =?utf-8?B?VHZrdWxKY3dWZHRMR1hwVFV6OHMwdGRMVCs5OFVmMG9OTWVzSVBEUlluOEQ5?=
 =?utf-8?B?Q251TllMaVBwQlhxbFUzaml0R2FJbEdWNnJ1M0tUTDg4TUdoa0c0dDJwNWtO?=
 =?utf-8?B?M2pFZEVNQnU5N24wampwZXlYMitMS2dXZ2JtOTFBYk9IcWhuaC94bG1RYklt?=
 =?utf-8?B?bjliYllONDlNL21QM3JkOFNuUDhQZHhpNy9aSDdFQm11UzRPVW9nb1hOcUJQ?=
 =?utf-8?Q?atiuXyAaWxZbTCUQHFk4vUZ7oL7Udxw7XHWPwtmYiOkA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b87e76cf-bf67-4543-e85c-08de1ae5b784
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 14:31:46.4812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5UIKMKo0Rv5A2oo2b8GXQAhDSjghjfc7x/4HKvQj5cuMDmWE8nuSChS3a6/bJMgi8zOTKdJnXQhUNXR4xBJvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7701

Hi Alice,

On Mon Nov 3, 2025 at 7:47 PM JST, Alice Ryhl wrote:
> On Sun, Nov 02, 2025 at 09:17:35PM -0500, Yury Norov wrote:
>> On Fri, Oct 31, 2025 at 10:39:57PM +0900, Alexandre Courbot wrote:
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
>> > ---
>> >  rust/kernel/lib.rs        |   1 +
>> >  rust/kernel/num.rs        |  75 ++++
>> >  rust/kernel/num/bitint.rs | 896 +++++++++++++++++++++++++++++++++++++=
+++++++++
>> >  3 files changed, 972 insertions(+)
>> =20
>> ...
>>=20
>> > +/// Evaluates to `true` if `$value` can be represented using at most =
`$num_bits` on `$type`.
>> > +///
>> > +/// Can be used in const context.
>> > +macro_rules! fits_within {
>> > +    ($value:expr, $type:ty, $num_bits:expr) =3D> {{
>> > +        // Any attempt to create a `BitInt` with more bits used for r=
epresentation than its backing
>> > +        // type (i.e. create an invalid `BitInt`) must be aborted at =
build time.
>> > +        build_assert!(
>> > +            <$type>::BITS >=3D $num_bits,
>> > +            "Number of bits requested for representation is larger th=
an backing type."
>> > +        );
>> > +
>> > +        let shift: u32 =3D <$type>::BITS - $num_bits;
>> > +        let v =3D $value;
>> > +
>> > +        // The value fits within `NUM_BITS` if shifting it left by th=
e number of unused bits, then
>> > +        // right by the same number, doesn't change the value.
>> > +        //
>> > +        // This method has the benefit of working with both unsigned =
and signed integers.
>> > +        (v << shift) >> shift =3D=3D v
>>=20
>> In C it doesn't work:
>>=20
>>         int c =3D 0x7fffffff;
>>         printf("%x\t%x\n", c, (c << 1) >> 1); // 7fffffff	ffffffff
>>=20
>> Neither in rust:  =20
>>=20
>>         let c: i32 =3D 0x7fffffff;
>>         println!("{} {}", c, (c << 1) >> 1);  // 2147483647 -1
>>=20
>> Or I misunderstand something?
>
> I think we should probably just define a BitInt::MIN and BitInt::MAX
> constant and have this code check MIN <=3D v && v <=3D MAX.

Thankfully (and unless I am mistaken) it looks like this is actually
working as intended - please see my reply to Yury if you want to
confirm.

>
>> > +    }};
>> > +}
>> > +
>> > +/// Trait for primitive integer types that can be used to back a [`Bi=
tInt`].
>> > +///
>> > +/// This is mostly used to lock all the operations we need for [`BitI=
nt`] in a single trait.
>> > +pub trait Boundable
>> > +where
>> > +    Self: Integer
>> > +        + Sized
>> > +        + Copy
>> > +        + core::ops::Shl<u32, Output =3D Self>
>> > +        + core::ops::Shr<u32, Output =3D Self>
>> > +        + core::cmp::PartialEq,
>> > +    Self: TryInto<u8> + TryInto<u16> + TryInto<u32> + TryInto<u64>,
>> > +    Self: TryInto<i8> + TryInto<i16> + TryInto<i32> + TryInto<i64>,
>> > +{
>> > +    /// Returns `true` if `value` can be represented with at most `NU=
M_BITS` on `T`.
>> > +    fn fits_within(value: Self, num_bits: u32) -> bool {
>> > +        fits_within!(value, Self, num_bits)
>> > +    }
>> > +}
>> > +
>> > +/// Inplement `Boundable` for all integers types.
>> > +impl<T> Boundable for T
>> > +where
>> > +    T: Integer
>> > +        + Sized
>> > +        + Copy
>> > +        + core::ops::Shl<u32, Output =3D Self>
>> > +        + core::ops::Shr<u32, Output =3D Self>
>> > +        + core::cmp::PartialEq,
>> > +    Self: TryInto<u8> + TryInto<u16> + TryInto<u32> + TryInto<u64>,
>> > +    Self: TryInto<i8> + TryInto<i16> + TryInto<i32> + TryInto<i64>,
>> > +{
>> > +}
>> > +
>> > +/// Integer type for which only the bits `0..NUM_BITS` are valid.
>> > +///
>> > +/// # Invariants
>> > +///
>> > +/// Stored values are represented with at most `NUM_BITS` bits.
>> > +///
>> > +/// # Examples
>> > +///
>> > +/// ```
>> > +/// use kernel::num::BitInt;
>> > +///
>> > +/// // An unsigned 8-bit integer, of which only the 4 LSBs can ever b=
e set.
>> > +/// // The value `15` is statically validated to fit within the speci=
fied number of bits.
>> > +/// let v =3D BitInt::<u8, 4>::new::<15>();
>>=20
>> What for do you make user to declare the storage explicitly? From
>> end-user perspective, declaring 4-bit variable must imply the most
>> suitable storage... C version of the same doesn't allow user to select
>> the storage as well:
>>=20
>>         _BitInt(4) x =3D 8;
>>=20
>> I can't think out any useful usecase for this... I believe that the
>> optimal storage must be chosen by implementation. And it may even be
>> different for different arches.
>
> It's more complex to not specify the backing storage explicitly, but I
> also think it would be nice to be able to avoid it.

Indeed, it's not impossible to automatically assign a primitive type
from the number of requested bits, but it's a bit of a PITA without
generic constant expressions. And I don't think we can avoid explicitly
mentioning the signedness anyway, so why not give the full type.

Finally, this would also make arithmetic operations (or anything using
the `BitInt`'s value) more complex as one would need to cast to the type
they actually need to perform anything useful.

<snip>
>> > +/// // Non-constant expressions can also be validated at build-time t=
hanks to compiler
>> > +/// // optimizations. This should be used as a last resort though.
>> > +/// let v =3D BitInt::<u8, 4>::from_expr(15);
>>=20
>> Not sure I understand that. Can you confirm my understanding?
>>=20
>> 1. For compile-time initialization I use BitInt::<i8, 4>::new::<8>();
>> 2. For compile- or runtime initialization: BitInt::<i8, 4>::from_expr(va=
l);
>> 3. For runtime-only initialization: BitInt::<i8, 4>::try_new(val);
>>=20
>> In this scheme #3 looks excessive...
>
> I'm not sure we should have `from_expr` at all. What it does is emit an
> if condition checking whether the value is in-bounds containing a call
> to a function that does not exist, so that if the optimizer prove the
> range check at compile-time, then there is a linker error.
>
> What is the use-case for from_expr?

It is pretty fundamental to using this successfully with bitfields. For
instance, the getter method for a given field (which returns a `BitInt`)
works roughly as follows:

    // Extract the field using its mask and shift.
    let field =3D ((self.0 & MASK) >> SHIFT);

    // Infallibly create the `BitInt` from `field` - the compiler can
    // infer from the mask and shift above that the overflow check
    // will never fail.
    BitInt::<$storage, { $hi + 1 - $lo }>::from_expr(field)

Without this, we should need to resort to unsafe code and probably an
`unwrap_unchecked`.

Another example from the Nova code:

    const FLUSH_SYSMEM_ADDR_SHIFT_HI: u32 =3D 40;

    pub(super) fn write_sysmem_flush_page_ga100(bar: &Bar0, addr: u64) {
        regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI::default()
            .set_adr_63_40(BitInt::from_expr(addr >> FLUSH_SYSMEM_ADDR_SHIF=
T_HI).cast())
            .write(bar);
    }

The `adr_63_40` field is 24-bits long, and from the 40-bit shift
operation `from_expr` can infer that the result will fit and do without
a runtime check. I think that's pretty cool! :)

Also, this does not look very different from what e.g.
`Io::io_addr_assert` does.

