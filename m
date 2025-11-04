Return-Path: <linux-kernel+bounces-884085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FAFC2F532
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 05:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53C53B8185
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 04:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380B5299922;
	Tue,  4 Nov 2025 04:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sc89tCCE"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012022.outbound.protection.outlook.com [52.101.53.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B849C8248C;
	Tue,  4 Nov 2025 04:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762232169; cv=fail; b=XNlnc/y94uEMbQ4hAEghXhQQ0Nxa0J68quJzS4ecfV4Dae25YnE0Rzka4PKnUEeMS4AuEMrdte6b9DT3oLg7HBVAVPZl7MyCJn3HTzv7g8CWW6evrsGVkEnzCDz0fF0KKm2tUu/KaQhb+kh0yfYZbFy3xe3lY2mp4UyeZ4DQ8+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762232169; c=relaxed/simple;
	bh=ZDAH7jYMDDMwOjxirtjWdr/YHQBAxjw6/ksMOgM41o0=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=Oy8iVCiBt+WkxEupXA6MvoOQdXiz+5z76jemVX7oKnCKN2aqrm40rWxiYjSy4OK+C8ywipu0mJjprtY9ukQTs2Ya7aU4fEsy/PbUTaw+AlLTaUXC+kj/H/R6k6Fx4J+zJzSuiPAxvM07ouxOWl65wlNGbXqBj/2mbGEdBoaaJ3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sc89tCCE; arc=fail smtp.client-ip=52.101.53.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBVU48vSSRp3oFuKFxo8PzSwT/9+27shD9Rq1hChgwZaw7OXpWLPmFkGq0GPh13XdXhC+QvusmdaOQVL81SxpQ4b0zta0GeDgGnpO2ORklW7FmxLj/OQ5G2et+VCofV3A5GtASs9q5gU3GzOo7ILDSIa6TlnrR4cbByZrVIce8uvsI0joBb+ugF6jKOug0eJ8oqiV52JJmwYC8jVoL16g81XCy6XkjbZT+KQSpWSUYxQLvAUe7LzK/8Ogcp5TZ2jMsn8WRDyQcCnWX/cE3UAkECys6F35XhVFN81zCWfvGbG3TXJnYxCL3AWCxFgUVALDrEPqy/TTXStQSokdNL+CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDAH7jYMDDMwOjxirtjWdr/YHQBAxjw6/ksMOgM41o0=;
 b=QxM/Q/NEU9DtbzMxQHLnU25uZ4dNVdnXxv+QZAFbLvyCqjeN1arDi8dI+Yo3ILikS7fH0hHT036wc+dgOCr2fgIl70Uc2qfn0AMpQzZmDT1umKzv0+LKfYPvlzqkXsBnf/gvdYO0XpieK+oPYWpRNJwkktbCsnrm7wgftdeaZ5eQ/vPFH8GNHUH8ZPJa1c0Z+aKR/xHjxNfjfzex44MDM21p96KyI76hPhv0xYO0NQFl5SU8ueSG6rpiVZ4MZKTBoS5yKFe5TSZcbfN/X1k2pQO5LClTxWaeIuoze9daZY++Np130VdU5SwyoupXIFsVwTZhtfWj5mUOQa+ChJsfxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDAH7jYMDDMwOjxirtjWdr/YHQBAxjw6/ksMOgM41o0=;
 b=Sc89tCCExT57OlBIOGfgNz5gcMgXGLpajDSGBKLVE9OPY/vMfqfwrK4yA3LH0H4sVX2OLzCvq+WKd6RZXGm5sNm2nP2I8XSACEuFCvb1U+x8oefcali/OtwCAbERqvTZ04J6HETPuSH+WMlIh1yqcOTTOCfQ71nbSYRHEAR/5BWmyOEjX+BFvnwOe6T7i9lFqDnbsz8JP19YUfTz0obR0HASy8el6UqNaIrkmB7qIa1qGK4q5aywvNgARhPX+DtHolv1gCH8tUugPRddQ4th/lqByDil1KLScCCW5E/HkMJ4M+WNSsSMDWQ8cxsXjQDYOFYRkx6VOJ5875Icth5Z0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by LV8PR12MB9133.namprd12.prod.outlook.com (2603:10b6:408:188::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 04:56:04 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 04:55:57 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Nov 2025 13:55:54 +0900
Message-Id: <DDZN5VK2OK1W.25NNI77Y315WW@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] rust: transmute: add `from_bytes_prefix` family
 of methods
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251101-b4-frombytes-prefix-v1-1-0d9c1fd63b34@nvidia.com>
In-Reply-To: <20251101-b4-frombytes-prefix-v1-1-0d9c1fd63b34@nvidia.com>
X-ClientProxiedBy: OS0P286CA0119.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:169::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|LV8PR12MB9133:EE_
X-MS-Office365-Filtering-Correlation-Id: ec444ea7-f27a-4d2e-5e0d-08de1b5e7147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGtWZG5WQ3pELzhETUxnZy9tSWE5endQSDFlbEJ4VzMwb2E5c3hGVXRjbjIy?=
 =?utf-8?B?V0g5MEU0MGhHTTBYbDROSEtPRy91ejVrcnRjOXQ2WFFqZ2l5aGgxR1BadXp2?=
 =?utf-8?B?N2JaRTBGZWlKZ3dNN05RamlYZTNvcExPdFRoZjhWeDM2ZU10NllkUE1qV2FD?=
 =?utf-8?B?Nnd4MVdMUlNoMnFlV0RzUGl2bGdOa2lSdGFGSmtoSW9hZEozaXZmeU9WN25G?=
 =?utf-8?B?TFE5clFNTEkxbzllMnEzMzBxL1pQZFlkanlQQWNrdXM4V3NIMllIT01rdGpn?=
 =?utf-8?B?Y2NiWTNBa2g4bXpGTW9NYVlLRklZZG01dmFTVU15MTBqMFkwd1hoV0Q2WGZh?=
 =?utf-8?B?S0JEZ2g1OHRaYWcvRjFXZi9tVXdyTlJWS2UwMGl4aEVxS1pWeTRvVStoa25E?=
 =?utf-8?B?cjNaZGFpS1pRVThFdEdrTjcrNWM2VlcwN1pGUTFQamJKYWFBOGtMOWxBeTdO?=
 =?utf-8?B?YmhXanNWcXZXaHVMVkJnZElzS1ZQOXpHNWFWcC9YRyt2UFJSdTZ4ZzZFQzRJ?=
 =?utf-8?B?YjU0U2VISU5ZZlRXQjEvRE9qM0xsTlZIS3dIeEZLVGp5VzRoUW41NkVXT1Ux?=
 =?utf-8?B?Qy84Y082T3RIKzdRb3p4VE1sOERUTW9SNEtWT0M0bHdEQ2Y2L1UxeHdDK2U4?=
 =?utf-8?B?bTMweXFVK1lRWDZsMEUrelh2aHFwV3MwbFVvU0FCdGpBU2FocVZERk4zdnpa?=
 =?utf-8?B?SXppcjA0clVnbU1TWGhWbk9DUzRyWnVieEl1NDlpSi9wbHlLbHdMbGluWG96?=
 =?utf-8?B?eFZMU0Y0TldtRUdyUnArYnFMNm1GWVlmMHlyb3BYY083cUtnUzN3Z0tTTDNL?=
 =?utf-8?B?NytGWFlSVVByMVhwbW5nYzhxTXIvL2ltWThndElBbzRRS3BBM1FjYmNjZ0dl?=
 =?utf-8?B?TjVMeGtDWjY3TkZFNEhwYUhJdnJTRE51c0FpT0JLc1lrZ0VoQURoZ3Nkbkh5?=
 =?utf-8?B?U3AreERhTzBpUE5zdFk4WWNLUmdTOVc1MGRKQ2YrNndYMjdDdm10WmZzY1lV?=
 =?utf-8?B?aGgzVkdUcUxqanhYaDdQWk41OXpIdWtIT0VyT3htenJkOUkrclpHR3h2cjVJ?=
 =?utf-8?B?K0FIVHhUalhGNk1QR3B5L1I3VmttT2QzcHJqaDVwZkFGNk5qWDJZY1BUeWNG?=
 =?utf-8?B?L2hVY0ZkVDI4a2E0TStwTUdqYnVrS05URVF2d0hITTk3ZDN5VWhmMzViNDJ4?=
 =?utf-8?B?eWFUNU00Y0ZjVVBYOEI5RVdnZHdpRUpCU3hTb0lKckY1VkM3V1hMUDBaTkU5?=
 =?utf-8?B?eW9DRTR4WTgwcGRpejdLZ3pXM0NHNVVmSFFkWk5yd0x2UGxFalNDQ3RzYVFB?=
 =?utf-8?B?ZmpPUi83YlllR3lLQzJWWjk0ZzYzblgxRWE5TE9ST2JvMjFDYTJtYjNUYWsw?=
 =?utf-8?B?QlZXQTJIaVhEMjUwdU5yYnE4WWJGeEdXRmlXYTJJY2laOFUxOTBqKzFxb0Jq?=
 =?utf-8?B?WW4zVGV0Sm9tNkRIdlp0QkRENjhDY3NJWHFzS0dTV2JVUUU5OUp5SkJzdEFQ?=
 =?utf-8?B?TmNBai9nSG9ZSmxIZDJnOS9OZXlkWHkrbHhMenlENi8xVmZObG1QdmFCSVIy?=
 =?utf-8?B?UVl0VFNOV3g5VFNvOWZrS0tNRzRoQ3I3bTdBQUlEeGR4RktqSVZyb2dyOGdS?=
 =?utf-8?B?MFZJYjBjS2o4NmRrZk9TVFUzeWNvVjFST2JqMzljOWZta1NCd3psN1JaRWlL?=
 =?utf-8?B?enJoZUNoV1pORG9mLzVoNDZVbWZTVVoxemFscjJEYkFoTUpWQ3UyRndHbUI3?=
 =?utf-8?B?UkZDc0VITnpSV256ejdvUlpFaE9vd2tadGFMdWpXRFpwVm9ycHBOVWJXWmxC?=
 =?utf-8?B?RFpjZDZMQUFTUHVqc3ZKT0gzRVpTY2NnQUxJa1RhdXZ2QmoraEs5WUxhNzVq?=
 =?utf-8?B?R3Z3NXVNaFRvUkZjNW9QRFhUbU92RTFlYUlNdHNQQU5hcnQyeDFLQW1ycVlq?=
 =?utf-8?B?QnQ5dzF6eldoc3RsRENVOWgvTEFGV3B5ZFBPSlFNdjlialpnZU1PbENnUjNX?=
 =?utf-8?B?cXFiMzZQQlVTbjRnSUJYbjd4bldRU0lTRGNZK3hXSjdNaGxtNHhsUlNLelpB?=
 =?utf-8?Q?1ShZ+8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWFxQnRMTXVndmE0d1o1NnlzRWZjVjd4WFI5bDI4NXJXRjU4SWtacFRGT1Vu?=
 =?utf-8?B?T2RpYTN0b2IyNXFCUzNzbHRXQlBCQkVraFpoWVNTcnFMMzl0MS9NekQ4cUhI?=
 =?utf-8?B?UDd6OWRrczFGTUpLS3d6MFMveHZXQ01wWU5ubTNvRlpQZXltemptYWJQQ3Nj?=
 =?utf-8?B?VkZlT2FabGZTRWl4eWlZdXFXNjhla05sa3JHR0s4aXJ6NU9ERk5nMXp2ZlI0?=
 =?utf-8?B?OE5EYzY5WUQwTjFuVG1aNkk2TEZaZTJsUTR0QmlPK2JjUS9PTXVQeU1ROEEv?=
 =?utf-8?B?dkxhU0p3ekQ0MFhWOTlmRFBIV1orNEFPanBjdjBjc3FjT0gzS1hnSEgzd01O?=
 =?utf-8?B?Tm9lTjlISFlKTmxMSjM0S1JCQ0FWakt6eHhpaWgveTZab1BUVFV5TDVJSVQ3?=
 =?utf-8?B?S1JRajgrUnZQaXRaRVFqRit0djZSRnpEU3ZrK0RNeHlQdnF4dm1JRkl5UEp0?=
 =?utf-8?B?Nmp2NWhJTDVibTJBSHBVRHpvalBteXRacjlyNm11RDR4ekxSOThCQjNzaVRD?=
 =?utf-8?B?N3k0dHVTSGJESzdpc2lZZWFMSzc1NTdER2grMEpPaGtWdldYWTlHNUpIbGt4?=
 =?utf-8?B?dlI1T3VlOE9jSjNrRi85eXJiS0VxM0dUZFlBR0tYY0tUdDI2S1lBRy9Tb25y?=
 =?utf-8?B?THpGUCs1QStwOEtJdnl1akNNdFljVjN3VUtSNlJVKzRXMnJtenZsL2h4a20z?=
 =?utf-8?B?QnJ1U0RpMnJMcldmWEF1bzRRdWFPQWw3R0taRjVmbmNlQkgvaVpvaE5OTi8x?=
 =?utf-8?B?VFg1UHZVSE1OaG92YmFkNHlWNlB4YU1LNE1oenFZQkV4TVAzeC85OWJub3hn?=
 =?utf-8?B?REJaWEU5eWx0aC9VSjJaVFBpa3RxSGoxcjZmeXovU1YrU29meVBLQWFQMGZ0?=
 =?utf-8?B?cXYrZjVGU25RaHZtL3gzVFhUSGlhZTU4ZGh1SlEzN213QXdXelFzamtJOTBK?=
 =?utf-8?B?WXcvaGxLZSszUlZwRjlIaVo5RmZDUm8xWUIrZUJzK3JJR1NidXRuRWxNY1dF?=
 =?utf-8?B?Z3VpcXY5K05DOUtFRzRHNDVLTTRxQjJKWU1sa3pER1k0dmR0RlF5NVJPTE15?=
 =?utf-8?B?ZGN2aTlhMTlwNEUyTS9EQkpDbHhtamgwWDlVNXRkclpnQUtINDJac1pKSFNJ?=
 =?utf-8?B?aHNOTy83eGpvYWk2eEZhWHc3THlrN2FjUWFpYlViZVVzbmw5VjhoeGpZREFM?=
 =?utf-8?B?dFhpL1M0Q2hFcWhxUm9jMWhONi90VUtaRjNKL01wRU9PQUlVTDhGK3UrZzJP?=
 =?utf-8?B?N1lOWERzdlY0aC8xc1JUVURNajZHOFowRW9TMzdCRHlxRE5EZ3RoVjVqNVNv?=
 =?utf-8?B?M2ZyZzFHakNuU09tbXZwYlM0ZnFJL1BmTlIxZWV5UC9GdmNRQzBFbVRuUkpk?=
 =?utf-8?B?YW53aEltUWFjdzBEREVLL1BtVUI4S2w5YzdPR1h6aWFYZHREMk5CcWlac1RK?=
 =?utf-8?B?aWlpa0NIS0pRajFyZUpNRUh5VGJBUUExZmVjSENnRjFPVnoxcmpFcTN5TDdP?=
 =?utf-8?B?MVpVNnhaVzF4cHJtdW9yVUFOOXdkbDNybUI4eFN6ZkFhbjZZN2lJRk9tM3Z2?=
 =?utf-8?B?eDRHTzFnbU03YjM3MFl2Z0JNQXFDK2hlTXl4cWw2Z1BIOE0zaWdaTGJpTUdX?=
 =?utf-8?B?MzBqOWR2NEs5R3g4MGhxSk5Vb2Q4cWZVM0VmeWNmVlIxWCtTcTN5YlM5ckpw?=
 =?utf-8?B?VnM0NERxSDFUa0syZmt3NWpOd21zQVhNSTYwK2ZKWEhSQjZRb0NBUlhpTFpx?=
 =?utf-8?B?VmU3Y1c0LzROUHllV0lEUC8wQ2NNVm5XaFVLa1N4dGRDblk4aDBWM0FYejcr?=
 =?utf-8?B?TmpLTWVRK3BndHpjWmxVNWtGa2paV3I4N3U4dXFhVlNyYjAraE92WHExQVJk?=
 =?utf-8?B?emI0Sm9VQ3lLODhmb1dub2oycEhTcUwranNDa25vQ3Bvc1V1VlROcDVFZWNu?=
 =?utf-8?B?aVZIT3JRcjZCV1NtRXJjbTdOT29zUElXR0s2am5nbDJneXdDSDA4YWdKRWpD?=
 =?utf-8?B?dk5jM3BYSTliMWg0Skg3K1pkSjdCb1hrQXBZd1ZFSStJK0hhZUVQOGNycEo4?=
 =?utf-8?B?L2QyRXJRVlVrUGNHUlBJYTBUTFNuV0swUnhWb2RYa3ZBcUNOOWF4L3hFWEVz?=
 =?utf-8?B?eGVkRlhKQm0yelpudXJhdVhsVUJwY2Z4TUR2MFIxdGk4bEtYZU5TYWtaQytZ?=
 =?utf-8?Q?j8RtenlRoudG5d8kuxOz8xXfHA8q0xpjK2AmHuRqoxHh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec444ea7-f27a-4d2e-5e0d-08de1b5e7147
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 04:55:57.6184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DaWNNcZbHNKvHmGecv/pE+Cw+W2cz6JqT+W/qdiE4wr3zyl5jP+fvVhbdJ6b6KOwc7ibftcr6Usu+nyyaL4cmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9133

On Sat Nov 1, 2025 at 10:41 PM JST, Alexandre Courbot wrote:
> The `from_bytes*` family of functions expect a slice of the exact same
> size as the requested type. This can be sometimes cumbersome for callers
> that deal with dynamic stream of data that needs to be manually cut
> before each invocation of `from_bytes`.
>
> To simplify such callers, introduce a new `from_bytes*_prefix` family of
> methods, which split the input slice at the index required for the
> equivalent `from_bytes` method to succeed, and return its result
> alongside with the remainder of the slice.
>
> This design is inspired by zerocopy's `try_*_from_prefix` family of
> methods.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> This patch was part of a minor Nova cleanup series [1], but since it
> requires attention from the core Rust team and is buried under other
> Nova patches, I am taking the freedom to send it separately for
> visibility.
>
> Since the originating series makes use of this, I hope to eventually
> merge it together with it, through the drm-rust tree.
>
> Thanks!
>
> [1] https://lore.kernel.org/all/20251029-nova-vbios-frombytes-v1-0-ac441e=
bc1de3@nvidia.com/

Rust core folks: if this looks ok to you, could I get an Acked-by to
take this through the drm-rust tree along with the rest of the series?

