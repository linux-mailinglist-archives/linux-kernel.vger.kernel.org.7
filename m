Return-Path: <linux-kernel+bounces-887903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22288C3956D
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 08:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 188894ECEDB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 07:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C112DCBE0;
	Thu,  6 Nov 2025 07:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BLEwC9qt"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475C22DF141;
	Thu,  6 Nov 2025 07:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762412899; cv=fail; b=Enj415su6DPo8Cwn3Xh9o+vW1RxrRmgtSDSSHiGPkVvu0BPHgpl6lHHUVqo+VBosno7OYKB+qhmIys0g58yblslMK48JpVx8mVJ2PQT2H0YNjGUhOvJ5GlMZaCtdSC5ZhPmqkAiMeksCmBOgazfc/R/VDAcUbx2BFMzcKjJIIzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762412899; c=relaxed/simple;
	bh=3zRpPJjaWfRyr3xEaIM6lAMSdycB1CRH0KLHMVYPZBM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=B0rumVLk6e5RqeG1IPJAIuA9tQHX61DkTQFdti/ytiK8FanE/MuqB/iMtIEOTOGJoXD9fn7lEN3BmCsOZ0Tdq1v3mr0UxaFZ+M8Yl+41bpUbIFvw9O93GsV8MRyH01shi4WZtnoO4ClzF98fpDi7vcgZz5D3lhYOdaPVL5CmzI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BLEwC9qt; arc=fail smtp.client-ip=52.101.85.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrD3d2c2pDFuf9PkE+cPAiqUEwnXyV6a1IYUJX5dikMoNb/2z8l7rnlcm6tkrBqtJmdNX5OlGCN0Q5Mq5PFHKl5oNpI3vIxxP6amYXJtToI/M2dA7cU5IKsqARHcAKGIOFOizkS0xNGeR/TffybUVAZP7GQ9cUGRGEJahW6kXGiMjsNdbG0injrgpE+hHf+Exc9RxJBC2Er8HKxGn3/KyNq7FhKnD0f0pss8ENSix3esxQ1/xHaCQABDVnFZFgAnWCdGUK0+EL7hIVe1NL6Qrw6WHMDw2O1leg5o2jBXGHhV+HrmZ74hoW9cPWps7GizULreotcjGxDrLT3i0ygqYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZU52KZgmuHh4Bgh1GD4k8qt6qtLHOvspfRspftpLpQ=;
 b=yWmo/TtvsGdh13CaS308IAVXzJZ7amWDOpRyt7ettUcG1JG0is7I+cEHaaTJE4Fn3/Fd0hNKCmX25lxJm9f6r0ijSiDavFer7B5DKKG4EWbSvmjsC2Dcx2wEwSOrROgf3JE6kl6N1BsH+q5ZV1w0Jxx2SkaqdV2yQwkd/snLRrUlC4TneBUfXaSFVSTO7rfiPpFfua9eKH5NabVi4xCXl9q7jiHUkdjOc6QSnX0fZUJwkwmqnaE+tREGTTnLS60fheyNFwVm+cAlAZ4xuV7jkk3OHeZdBbbOT58QJFt5EjocnMexWKEXr/WvPJ69rbx2VsW0zNcQM9XrqSNvNvSX+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZU52KZgmuHh4Bgh1GD4k8qt6qtLHOvspfRspftpLpQ=;
 b=BLEwC9qtpwoVjpIUcOr8LejONvCMLVYdle01pTCVyBciv7JNoQ9u5edbZ4x0zOx7sp1mAP+Cg2VtX5kwB2b7V67dPR9cjfCeAAtay212JFI8gzT9kv4vmPM9/pb/4Jn9Q7nxk/Snhy7Y7ASteUPM7vdHEmuajTiTqtwCKiCtQOEiK73ias/uWKvBP8pGtGP7LYt7T6USiwBbMRgJKz1Td68SfwHO8Z33ZADywPBJmjRbjHvItu46UdgpO53+TtI3uBecu/0iMDLjnqfsYm/EJZbWgKm+Vkp8T457xoNCUI43HbJj710OO1o1kgjtelBLGzE6Dob8+IGmtuUem9JNYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA5PPF7F0CA3746.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 07:08:09 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 07:08:09 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 06 Nov 2025 16:07:15 +0900
Subject: [PATCH v3 3/4] MAINTAINERS: add entry for the Rust `num` module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-bounded_ints-v3-3-47104986a5c3@nvidia.com>
References: <20251106-bounded_ints-v3-0-47104986a5c3@nvidia.com>
In-Reply-To: <20251106-bounded_ints-v3-0-47104986a5c3@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Jesung Yang <y.j3ms.n@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TY4PR01CA0119.jpnprd01.prod.outlook.com
 (2603:1096:405:379::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA5PPF7F0CA3746:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f53377-a96b-4350-7a36-08de1d033dd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dE5tWStDNzFXWFVWRThqUzY3TWN5K0t0dEtQV3JtalhHVUFqclF6V0M2VXFz?=
 =?utf-8?B?YnV4WTFLL0NMb1RPOHRzV3BmVjJBU0xMdzhNNHk2NTFYL2VMaUV2eFV0YS9V?=
 =?utf-8?B?aGVyQUhyeG9vU0tjd3NjNlFHMzZXTXdFZXordVlSa2x6YS9iNnBkNEFibTNy?=
 =?utf-8?B?Nm02anl3a1g1T1NxeDJSeXRMY2xnamZpYjAxbzBJaGdOZWZhTWlTTU83aTdR?=
 =?utf-8?B?UUxKOWhXakh1QnVxa29QaHY2c2xnbkx1cHpwWnJaSFhwSm81YjZma2VCNExm?=
 =?utf-8?B?bWpCRTg4dlFHbEhyeEpJcUIzM3FWa2lZdGtoby9Ld3dEVDVtK2lOWFd2VXRT?=
 =?utf-8?B?S3lkbWpBVXE4c3R3UEowU002Z0RyT3gva2dEMHA4VjdhNVd6cTFIb3IxalZN?=
 =?utf-8?B?L0pXMVhnTXkwVEU0VWZxZFF1d01MeHVaR2hkcjNlVXFTc0t0UTEzWnVoOEsv?=
 =?utf-8?B?WCt3ZTQxUE9FUURZRUdjOEwrLzJTeDNiZUlRb0lBOFBpQm4wa3I1ck11cFBz?=
 =?utf-8?B?SHU1ZWMzVTl1ZExpVmZHOHZmdTRuWFAzR3NKWmtZNi9maGV2V3hqYmI4WXJO?=
 =?utf-8?B?QkVMRTNSc24wZnoxZVczZkVJY01qSkpUbHVXMzVWb3ZiK1NZOFROcTB5REkw?=
 =?utf-8?B?UC80SVA0TkJscWxCRkVPTFRuMFhVSElway9qMVk3UTZBaWphdW1POG1qdTkr?=
 =?utf-8?B?RnFHaTFtUCtVSEkzY1N2SWQxRFVSdkJUSnlTdis4bDFqeGVCVGpKT29uZDVM?=
 =?utf-8?B?SWtVRFR3MGtmRzRHQ3F5ZVNhSi91a0IzbFdQSlpXd2RqYVdmWXdDd2JqYWIv?=
 =?utf-8?B?SHBKNk1ndEQrdnBTVU5jTUpGOFhDRk1HNWw4Q2RrQ3lGL05BYjdBbWdCV3l6?=
 =?utf-8?B?d1VHYk9CM0pNa215ajAwck1hSXE0OFEzN0c0SllicEZ2bmVZM1ZxK3ZyMFFY?=
 =?utf-8?B?NkFhN2RncWNSTTZRUlpETkQvamV0OW9idUZ6dXl3bkRQN0FvdmdZUGhnWWc5?=
 =?utf-8?B?WG10dzBialNjdG1HMzZaQ0ZybWM1Q0tYMGplOHU4Nk5aTnJ6T1M0SzVhdTJl?=
 =?utf-8?B?M1dTZCsrSTdQaExxK3c5cGxaVUh5OGYremh1ckR1MkZwTkd0L1Z5Y3lZTTc2?=
 =?utf-8?B?V0hTa1FRQTFvb3NnZTl2cUp4Y041Undaam1PQStTc3h2QjZHeWdtWHEvTjNO?=
 =?utf-8?B?WDA2T1FrQkltaU55K3dodGNSanZrNnEzMVVYc0I5YVFHZFVLWENJbFVoZW04?=
 =?utf-8?B?QWk3TVFlNyt3M0JRR3FvcktGZkIvUTNHRFZCTzRnRGwvUG5SOThEak5DeUsv?=
 =?utf-8?B?cHFOZldPK1d2dklxWkZSU0E3amZzKzdjRS9kN2RLc1dQYVhoTm9iVHFrNi9P?=
 =?utf-8?B?alY4OUhLdlFtc3pZblArMThFaU8wWlgyWXo2TXJHQ1h6Y3VlcWYybytnYXkz?=
 =?utf-8?B?eGlvdE13NW1BRi8yb243WS9ibmxua0owQk9JWUwzcVFCWXBpRGhuZmVLY1NC?=
 =?utf-8?B?SkhsUmhOR1hjMUVHYk1vRmtnOTh1NkFIM2h2WmFTa1FHVWRsbXF6S05NM2hj?=
 =?utf-8?B?SDdOWE5scm80SE53Z3pHZ21wZk1vU3pmMDlnaHdKRytReCtMWmNyQVVjQWhF?=
 =?utf-8?B?blZjclB6RlJsaEc0WWtzMWhuTmlxck5sMm41ZTg0clBja0grT0pTd1RkY0xU?=
 =?utf-8?B?V3ZybXQ4YmxsSXpkQy9DdnJSODN0a2RLcTZRbHA3NXRYR0hUeWN4YVhLUXJ2?=
 =?utf-8?B?cjJRWUx1dTN5RDFJVGNnNVVlTW41TUFnSFBNZjBoMmNaWHRscXVxN1FFUWxz?=
 =?utf-8?B?dDFqUVArSGRwaFdVTGJJcXZZUnM5MkZqNisrVjYvZURyNEIwaHJYb01uckgz?=
 =?utf-8?B?aUI2cFFJWVVHZ2dFb005aWx3eTI0eGxQamRSVmNTdWlCTDJZVkIyb1FIRndq?=
 =?utf-8?B?ODdVQ1owb2RTTW1TWGg5YkJ0bTZzNy9BVkxjSkJJRWpyNnJyOGgxcEJKZEla?=
 =?utf-8?B?MTNaMDhLdFJEaGMzNXFJN1FPa2daWjEzQ1d5WW4rd01ETjQvSktlTjRZZFlS?=
 =?utf-8?Q?1MaJas?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGVCaTdzZ3JBSzVqQzI5eTlKUVJ0SFJIZDhZeWRkZERMN1VSd2l3M0traGJX?=
 =?utf-8?B?OU1NdGNCbEx2Y1cxcThuS0pkUVQ5ejI1SitDSEtHZ3ZiNEcxU1YxcEFqRHNt?=
 =?utf-8?B?UnI2YnRibnNPeXBZQU1YTHFXZ0RQK2VvOTFtSkY0cDN1dmF5c2Z3ZlNUVWMv?=
 =?utf-8?B?Q1pvcHJYUlNieWZOMlNrVGtneGUzUURYOU1vdmI0aVFiUVdXMDVjY0hMNkg4?=
 =?utf-8?B?b1BzWFp0ejROdGJUWWcwZWI2bWovWGQrcHk2cE5XY1RzTWhPcEVXSGVPelhU?=
 =?utf-8?B?ZExMV1FyVGlkTEVHRkgya0hGcDFESE5TQ3hJdEdGdHR5d1VSTWtQVHkyMEtO?=
 =?utf-8?B?QXAreXMrQXlyT0ZuYUMvZWdQWmlJZldxUDh2eDVTNGpINlltblh5SC9FdzZy?=
 =?utf-8?B?WU03UTVVMHU5UVpENDdIUG5saFNiYjlpWDRDamhrTXhsZSs0b2pEZjFPTEwy?=
 =?utf-8?B?NUt2bnZTOEk0SWNqM25mZlFFbDhYZXBYWEZCbml4RnFMQ25hNzU4N2szcFhR?=
 =?utf-8?B?SnNyUGVVeTNzeVV2aGNKZ1k5cTFyampBSDExWkhiazJtOHNhMmlTKzRkK3k3?=
 =?utf-8?B?akhTd21VUy9LbzU2WVVkTlE2Vk9qRUEwekJzQXZRcm81cHRmcVlGclkvL1BD?=
 =?utf-8?B?NEtRYnZ3bHdwb3lOSEJ4U2JzZlFubTF2ZVJ5Q3h2U2pSd3FvYkMzcGNHaXc2?=
 =?utf-8?B?VFNndm9GcS9yV1JWRWRJcXNuRUdzSVVWWjNrYW8ydE05TEh0bm9xZWx4TC9L?=
 =?utf-8?B?RG5XL1piVVB2V0pXNVBPaWUxUTdmOWRDY01oVUlqaDZQMEJqWXdiT3dYR2pX?=
 =?utf-8?B?cU8wdVJBMCt1UVBjdk1HblIrcjcya1AwWU1LcHN2YmhyTG1Dczhic0lyZDVH?=
 =?utf-8?B?KzVLZVBrZy9PaHN4amdqaXQ4OEtWM0VaclVhQVJCdVRvZXYxQlRtaGs0OXlq?=
 =?utf-8?B?eEduL2lDTk13TTNhb0p5QTI4ZTA2RGFxLzZhS01Fd0NCYWY2ZmpvOUVjTmds?=
 =?utf-8?B?cW5HVXZlMFNpVGcwQ3pHMmhQWForTkpaazF4WUlobTcwVUNaejdrT3ZKYnBo?=
 =?utf-8?B?YjY0OEVGbFFrRmhpMWkvaGpHV1hKS3lWeEdySzM4cGU5dmtCOHZiYVl2SWgz?=
 =?utf-8?B?RVRqc01GajJpczZkbXcyM0VUQW5aODhRbHZweGQ3eE1sY0Ixcys1MDAvYTdp?=
 =?utf-8?B?dVhTQzFITHpGRkQ2TDJMeWFvd0g5RlgxMzh0WlVuYms4ZURiVFlJYXhxL2pN?=
 =?utf-8?B?cU1wYk1senVzNDI0QmE0dkVrcGxod01yWmxEZHB6SlRHaWNhYUJ1ajVNVDVF?=
 =?utf-8?B?Y1VIY3QvVHUrQ3EyNXVLWEpFWFRGc2s1eXdvQnZnM0FIbEhvekFsdTBwWVpm?=
 =?utf-8?B?Z3pDL2FOWEg5dGRnM1FqcHppenV4ZFFlaFBtUEc3dkszYjhCUjF4Q3FiK1Fq?=
 =?utf-8?B?eHFUbklRdkk2TkVqdkRYRFF6NWM1LysvQTBKTnd6VWRNbHh6QSs4THJxSUcw?=
 =?utf-8?B?Z295eEtrY1VzUHhVRWp5Wm1lb0lRVjJ6dExMOVozRENDUk1iQTJiWjlnR1Jm?=
 =?utf-8?B?Ui9IeElHay9SZC9xRzhMY2VnNEJhQmhBNC9vOU9FZGd3NkZzRWNKMVNtUTJD?=
 =?utf-8?B?aFdFZk8zNXBQRWFtblp0NW9tdWdVdytMV0FiT0lGU3NQS2V4Y20yZGdUcEJo?=
 =?utf-8?B?UkROakkxbERXRko0SkNOdU1kU2REVGZzR1FMenVheXBEcjYrL3hOSitSckRL?=
 =?utf-8?B?U0pmTUFSQ25JSzF1Rm1kZzNsbWpNckhPaGtUYWZLUG9taHlJMzlVQWliY0pa?=
 =?utf-8?B?UnNlVFdBbUNGR0VnRWFwNWhLakF0cytZRitTdW1EWjNnenduQkdUQXdwMnIy?=
 =?utf-8?B?VEJ4UUVxdklXc1VGUGNNTmlBeWt3VW9XaHVJZ3V6Y29peUkwSmVvclBZRDV5?=
 =?utf-8?B?YVVKVi9ETUpJNkdXVmVMU2M5Y2xTdlZsVmxjbm5zWnM4QklsdDdaOE01RTFl?=
 =?utf-8?B?TUhkOEZRZ3o4aVBXOEMyeHJTVDJsa1krQlNJQ3V5cXVKQVZjUTZXcnRuWk00?=
 =?utf-8?B?RThCeXp0TjRUbTMzcEkzWldWd0VQNlJldUh3ek5tdjZQRjA2Vkt1WlRyNGtq?=
 =?utf-8?B?TGExTVp0N2QvYlljZUg0R3orQm4xSERTRnJaa1c4MmpxVlJCUkhLaUZaak1p?=
 =?utf-8?Q?D/Df/DD1ET0J0EPaA2rBIie2FW9YVitJL34x59Sr85tm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f53377-a96b-4350-7a36-08de1d033dd6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 07:08:09.3859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gz8R4kL6/HKPJ35pBdr70rP8Cvzi7Thw4aDOGbKZOXNOQIek4aCuT8cgcdhVvXDwRlhNa9rfkBf52TMpEDNBCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF7F0CA3746

This new module provides numerical features useful for the kernel, such
as the `Integer` trait and the `Bounded` integer wrapper.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 952aed4619c2..b6294a2903c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22521,6 +22521,14 @@ T:	git https://github.com/Rust-for-Linux/linux.git alloc-next
 F:	rust/kernel/alloc.rs
 F:	rust/kernel/alloc/
 
+RUST [NUM]
+M:	Alexandre Courbot <acourbot@nvidia.com>
+R:	Yury Norov <yury.norov@gmail.com>
+L:	rust-for-linux@vger.kernel.org
+S:	Maintained
+F:	rust/kernel/num.rs
+F:	rust/kernel/num/
+
 RUST [PIN-INIT]
 M:	Benno Lossin <lossin@kernel.org>
 L:	rust-for-linux@vger.kernel.org

-- 
2.51.2


