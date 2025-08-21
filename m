Return-Path: <linux-kernel+bounces-779611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 336F9B2F63B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022151C239D0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B772630F531;
	Thu, 21 Aug 2025 11:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b5GGkj9C"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270D330EF70;
	Thu, 21 Aug 2025 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774808; cv=fail; b=N7wInHLxs6iP6P+rdyzpJNT4DGKMtp6l01aOzV0v9dxXMA2giOQbrbgCz3J7+k/TonkuAcXSeYIETCZMZDbjWzfcXfjt10ShrTR/midOIM8GnTXcD58KGiWiApnnCaBmyTa/0M7TW2ykCpP1+g9wNtDujjhPq1aVlH6CXKQXLe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774808; c=relaxed/simple;
	bh=VabOItb8OCsGTvP/B+/uDLGXqV3Am4f442wK7ZamSOM=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=C+ztrJogWtClqwADRAUSBzh91y/L8GDBqg/3dPMpx9dGfAMq9gjhU6xCV1l57s/6cLRFhJjtYOJF7is+/pwfOKBq6aYrH2JMPqiPVt7Imfyw1WnF6Pmb3vfARfaNwEzsY35KdPdtNUIRuLNjHaXqLwuUyf+osiWMSWfHer2S4U0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b5GGkj9C; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8TLYd+TOw8MZ6A90h7uthEMLO0Ze4748/XWixeUi/NAgPDIP93x3b5ilrjKmdn3duKuXPftj3qc7i+nyVGZ0GEFweYJY2wJGgIorw2lC49/sg38wzBIqlhlSzyx/jFXSclGZB6oz4HoXzFz1p2sxUkDhmPRgSeYPIwLraJe+0TFpxsbbiOGI7q/cZL3URKCIH6aL7g/sbIHQLOcq3D2YBjbjDeRz35I4y+zZqqfIb8SsFAmgVfThSOXX89ESoV4iU+M+giG2uQUnrj1H2fsJm1Gj/RsfY6exNVdGsCO06R9a7ps47CnW9bgHRIFI5bmc8yRIV5T2TWf6UkUe8sXPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFB5emy7GHqlopCzIBtVx7itVRs/kuKeTNRqOoxXlLw=;
 b=N0WqxuxnWIb2o733d//n7qwmde8qgX21RVAcf/wveCWiTehOm/wwvs+CzBbagEWxLHjSQ+cahxfveHHrspcsQqZTlnLb55DipEWxNu6/WBZMJZBtccQ8y2Ye1jcp7OjgyrIdb0HthzPdT3vjHY98wWDIte4/+PrP8buyVS566JCdqLY9hjQreHqGsStIwO0rX1VvCFHGBF5g7i1BGubeH4/NhSq4Ys2W5HJ/zgk2srGYWQdBlkR94vDaW7uovrLLuHO5z7AsT52+iKOXpXMN3P/HVLkhhOelY/uWX+6YKF+qgdIAO7OE7eNlhDtP9plNy114sANnc2TYtiXP2jDA9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFB5emy7GHqlopCzIBtVx7itVRs/kuKeTNRqOoxXlLw=;
 b=b5GGkj9CtmfPSv1e1mCapgo9Cm1xeFdm1jhGCBdM5fTdOh9E5LvipaQAotpSAR3whJxUjrmjUybCjHnaJxe8jpWCoPvQat2Bow1Gpuq0nXDOYnrOKnFCI2ZO2B1nKvB9YEXsH1we8mKcUHYgZgqiPRw09LVshtGOYJsROhZXfVCk0mWgoD0LRR9J6/x/gEpPT5++VlnWS5xthDXRlAZzegXnWJHELuZuT35kXxgAnHFbMJqcqGBH8YXaxfkSGiJLw/Wc6zLbA8qHdDI9+gaIJc5sI2CVkoLpi13sj1jZ+DBPFnBh4s+SSxNgq1l6E+XJDbje2qfwX48c0Q0IhrGJuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS7PR12MB8230.namprd12.prod.outlook.com (2603:10b6:8:ed::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Thu, 21 Aug 2025 11:13:24 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9031.023; Thu, 21 Aug 2025
 11:13:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Aug 2025 20:13:20 +0900
Message-Id: <DC828042PKDV.16NDVKIGBNTJH@nvidia.com>
To: "Christian" <christiansantoslima21@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <~lkcamp/patches@lists.sr.ht>,
 <richard120310@gmail.com>
Subject: Re: [PATCH v9] rust: transmute: Add methods for FromBytes trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250811213851.65644-1-christiansantoslima21@gmail.com>
 <DC0INEKNZPSE.WLEQH24SLW1I@nvidia.com>
 <5204b598-7792-460b-bec2-e3a4a4c7e32d@gmail.com>
 <DC5INTQKY0EX.1T4HD6OU8C4PI@nvidia.com>
 <CABm2a9cyvsXd1OS+tvDoDDEfMgBOJeetBVQU0x3m5E1vV1CApw@mail.gmail.com>
In-Reply-To: <CABm2a9cyvsXd1OS+tvDoDDEfMgBOJeetBVQU0x3m5E1vV1CApw@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0105.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS7PR12MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: b55fcf6a-65b8-46cc-ba04-08dde0a3bedb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjRuWFpSczdRR2dlVkplbTVWNjVtdVQ2SjBjUmNyekdzdFlPMVVRNTd6REFP?=
 =?utf-8?B?V1UwTzlvbitnaE52UVVSWHZFSjdRYW1HdTVtTG9UY3huMWkyQVNaTmFhV1ly?=
 =?utf-8?B?U2VBcEExdVhGc0I0RVJxSmhZZzJRQmxpTm4wTEVYUFJZNkNaYlkxTGlMZUhF?=
 =?utf-8?B?NkVqTWJsbUJHMGhCM2tyWGF2cVQ1THhwYjJueEMyMnptSDlaUnNleUUwZlVh?=
 =?utf-8?B?YVhyUzA1Nk1wWXpmYUpEeWVyL0NJTVB2WXJRN21qeC80OFRORnNTbGU4TW9h?=
 =?utf-8?B?NWxXZzkydWlMb05KWDN3QlIzUU05SHh1Q0RCbjhYYUdpQWxiMC9xR3RzL0lv?=
 =?utf-8?B?Ylh2U0ZmMHh2OU5aWndENVAwWWxwRTFoMXpGYkp4MEJBMTV6SmpIN1B4Q0lQ?=
 =?utf-8?B?ODh2VWtoM3FISkFoR0grRlhaK211d0dZQUpWb1JpOVlQTHZMZEkvWEpaRkxW?=
 =?utf-8?B?UjYxVjdCbGJqcjVrWTZFZ1l3UWdFb0pRbEZkS0NDcjhZalI3R2laR3Iya21L?=
 =?utf-8?B?QldqNVFxdnN2TVlFNi90MGdiWEN5cCtRVk1nMGlZcU9SbldOWGFuSUtNUHFS?=
 =?utf-8?B?QzhlSlBVd2p4bUZsbmxwM0RyT0JXZmROM3hDcVdsWUduVXM3eHpvdG1FM3Ay?=
 =?utf-8?B?RWFaR1dsbERERkp6a2JOSFpFeDJ3SWVGOHI1MUtFRmNSYkxvamhKNHdiVTN4?=
 =?utf-8?B?YVVDZDhZZW1YeWRiT3UwZWloS2hKQ3lRbXdmL1ZxRnNsdlo1eGxNTENwdmJv?=
 =?utf-8?B?K1BiTzNYcUZZZGJyVm9qVkIrN1MrVng4TEYrc0ZaaWI1YktVWkJWYW9Bb29i?=
 =?utf-8?B?YUpsNFJwZFZsWWtKVFdkZURqbG0rS240dlZhclYrV0lHZkdqa1BBMEQ1VVlk?=
 =?utf-8?B?bG1LS2c0bDBPSUU5akxyWHNWR0k0cHBIQk8yV1N1UGdnaHVWbUdnSVA1cFc1?=
 =?utf-8?B?cm1KaGNwWk45TktxeHFvcmdPVExaR1ZCVExXUXpsUmswcVd5RFV0MWNDS0gw?=
 =?utf-8?B?V25iT1hGMDM0Q2lhUTdkSHExMHVvbXRpdEx5TlpXMmlDOFhOdHk0T3BIcHNT?=
 =?utf-8?B?YUJzR0tZOGw2YkFxNXJseTUrMVR1cDl0VWU2N2JYbEdxbnc1c29GeCtLQzg1?=
 =?utf-8?B?a0ZoK3NmcFVrL0ZrazhBUnA0djF6NXN6VTNoN0NidlcxUWlBT1lmcVkyemxW?=
 =?utf-8?B?RTZZdWtwN28vSm1wTlRNczVxN0p1ZW1XZXZ6WDFVSkhvaThlQzRlNkh4c1li?=
 =?utf-8?B?MHp2ZzRLYjFDUnlmQzhBOThQaERYcnNlUHdBaXVCMC94M0xSRTh2cGdkVzdp?=
 =?utf-8?B?b3NHcm9LUkZkRkdvb0VMc0VpeVRpa3pJbXN4K2xSWTBxaStqU0tSQ0gyK1VU?=
 =?utf-8?B?UDNPUVFEOS9KYm9jVzJHOFo3V1A2T1JBWGVkbTJlaStyU3ZhcE5NLys1SU9D?=
 =?utf-8?B?NXl3aDNGM0prZFM5WjJlQmRTSmNudE40WEpZc2Q4UXd5UG1xTnNWQXFMbDRL?=
 =?utf-8?B?WTBVUk5XZW9nQUZXdndnczZlMXExdE90Y1ZXbDRWek10TGNDM25MYnQyN2Iv?=
 =?utf-8?B?eGJEdXQ1UE9XbWdscFA2L21FVFJ0QVJ1U2J2aFdRS25NOGNsRUhjZGVEcUNM?=
 =?utf-8?B?UkhMaE94WFgyRkk5RDNuRUl2QytqUFBnVGh1b29wcDNqZUQ4QmdmTHFnWGJo?=
 =?utf-8?B?S2FMM2lNMmFFWkM0QjlvL3JtVzJETVprL1BscUNNNmxjenR3U0xNOVdBV3lk?=
 =?utf-8?B?M2tnNUdFQlZydDAveEtXVzYybmZzd3Yydi9uVTVYSUdYeGlKeFN3Njlkanl4?=
 =?utf-8?B?bkhPbndOeC9WU1RXUk5pTXFQVVI5d09SN09hME5MRnIxT0hJTFo0QndNYUdl?=
 =?utf-8?B?NXo3cWRETGZQSWVtZGdLTm5HVHdVSjUrdDJKNkNqL3NrMzNvemZTaVBmUE9O?=
 =?utf-8?Q?P28BUo2hfes=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1JpMmZrYjY5SkZyODlEajVCbi9kOXZsRnFRYUszcml2SHpiTFJJRWN0ZWE2?=
 =?utf-8?B?emlyNkJycDBkelFxR0hOdm9BLzBHOVdpcXYvYW9XazZ5YUxzSG9lOFh4U1Iz?=
 =?utf-8?B?aDJkeWJVYm5WRlhmZXArZFBJQm5DbUlaazdWQ3R6TnVOcFdzYXIveUNybVVC?=
 =?utf-8?B?ZDcwcm1RSE90S3lvV1Y1QTNnK25Kc3JDT0QxOUtodEx2VXhObVFzTEVQZDVl?=
 =?utf-8?B?R2F6MW5PY0hNWHQwQkcrZUthRkh1Q2Z6cW1aSHMzaUZ6YmdmTWZHNGxOc1Nl?=
 =?utf-8?B?eTVGTHk5Nk1IVXhsbDRRb2dTQ0V2NTE5WjRtbnRaVGVKdmZyaHQ4UjlNNXJM?=
 =?utf-8?B?b2VEb053VXh4R2NIYXljZ3ZEQ0xxUHE5aDdzUjhpTHFJdXN4LzVkNWdRbzVB?=
 =?utf-8?B?b2M4bEpNVzhmdFB1TG8wMkJ5OThWRHR2dnMwT1N4NlUwSGp3SE51STRNMGRX?=
 =?utf-8?B?Y2YwSFI2UXBwdFkxTk5mbnpYSlZidkJ4b2VaVnYxZGRQSGZac3prRTlWNVE1?=
 =?utf-8?B?TkhvVmFLZnBNTWZTdXltR3kvbEZwS2VwODlWckpLMVZuT3AwYlFmdUYrOUZP?=
 =?utf-8?B?TWFzNzdSQzhGbC9pT29RdW05RXpKbWR5L0U0Vzk3eDJhejBpT2cwSGljcmdL?=
 =?utf-8?B?UU9FQ015bW5OZlRrci9DQUhCK2E0OGN1bkFmOVlQeU1KWnAyTTZRMjAyclo4?=
 =?utf-8?B?ZTl1c1VmT29ERHg4VXk4MG4vK0FENGRrSWRBbkpTWGw0QzFBQ0JFN1M1ZTNF?=
 =?utf-8?B?aGhXcHZ6cTlkZFkvcGZiY1JhUWJNcktBU2FJVCs3dURMNzVGeW40ZFpaZG8z?=
 =?utf-8?B?WVNic2lUalhhTTZhc0FveFNNbkRiMzh1MStHUVRQVnZKbDdPU05Qcms3aHha?=
 =?utf-8?B?Y2Ewa1VBTE14cUdDODFKS1Q3L29MM0JkNkRsNXJrTE1STHBIZlV0VXFYemRO?=
 =?utf-8?B?R2hpK2EyWXBzYjE1TVQvVkZYRU1tcC9hZlFkYTlkTmw5bnZyZnFZNFRSTmJt?=
 =?utf-8?B?S2ZDWHBqL2pTQk12MVZuelpIVzB3VmdyOGpLL2ZOME1FQklxU1JVLzVZQWdE?=
 =?utf-8?B?ZnVwamNZeTF1MW1ZSUxkeVVuWnhDeEtoNW9OYU1qWlJvcnV0d21nTFlGKzAy?=
 =?utf-8?B?VGN6aytENWJJeEFMVE5QWm1IYnZIMXFaYUNlYjRRaWQ1QThmSWJBQVpUUjFO?=
 =?utf-8?B?KzBIQThWWGNuTFljWFBhVzV6TFpHcTZzdk5mMlpXVzVSemdJUEFMN3FHd2lx?=
 =?utf-8?B?OEF5WGRzcEJXNXpZVUs1b3FqZ0w0UmlIUHVWeTlUSmNxdmVINzVEWG5ZRnpL?=
 =?utf-8?B?Y0t5U3pzNnQvd1B5dFhJSC9jNHVaank3cDRia3ZZaUFyd0dmV2wva051N3Rj?=
 =?utf-8?B?SUlCY2dRcW5meHJ2eEYzUDNwK3NRMEhCbXdBOURTQnVwRFNVbER2ZEkxNXc2?=
 =?utf-8?B?ZTBud2gwT3BzaFdWWi82OHRrTnJLcy9DWnJoMjE4YXVIMS9pclJ6dk1MM1dF?=
 =?utf-8?B?Zm53aVIzRTlMT0Vka1pwamlIaCt2WUtFSWx6bjJ3MFRHdkMyMnI3ZFFFcmZo?=
 =?utf-8?B?a0JvZWxiT09pbE8yRUpQNTQ3cS94bk5PMTg3QmNWVUhOY2xpRUlmY3ZiSlM3?=
 =?utf-8?B?T1dkdDhmcEtUL3hodlh5L3NpUG5NOTdnSXFic1pQQ1k5V0s3eklrZ3dUc002?=
 =?utf-8?B?dWEycEMzdXlsN1l3ZHpFMFZYS0M3d1kvWXJJUC9uU01mcm0zTkJ4d1pYd1Z1?=
 =?utf-8?B?b2hkT1BCZWNLREliOXR3RGlwUXh1dVFrVmFaRUtxWWZ1WXFDNEIrUUVrejlu?=
 =?utf-8?B?cFc1dTByZTdFNS9sbEpoWGpyUXhCTklSK3FjM2Mwa1l1MUlmZWIxN0NKWFll?=
 =?utf-8?B?M1dWMi9kS1kyNmdSUXNsSlpvdmRDZVBKS0dDOWkxUHRlZEpqY3hrT0VzK1Fz?=
 =?utf-8?B?Qy8vQWJiK0JSWk1ZdGxaNEJSdFZFcEFUUVQxOERhaVU0cjVlNFdnSm5QT251?=
 =?utf-8?B?TGNsVmsxUnR2NGdMUVhETW9xang1bjUvdVNCZWFFNCt0bmpCNlplREJ1L0Zt?=
 =?utf-8?B?OTA3Z3NLTjJpY1FodDZvV29aOUZqam5vais0YkJwK3Yydk5HU0ZVdDFoZU1i?=
 =?utf-8?B?RVRBa2xjV3ZRbnB3WkhTSHJoR0x6eUNhTHZUT2ZHdmlEbWdoMkxjOTJkVXRP?=
 =?utf-8?Q?uYlRGzfwmHdi4elRC9yH2TDSsleK2Sl5GmPtP51z4BeW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b55fcf6a-65b8-46cc-ba04-08dde0a3bedb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 11:13:24.4826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycn7CyA9ZuO6YChb1giqn5qPJJ5zafhsW1h2uciAkymkUuXauUhzRbNzl4Ov0zhgIHlhZHK2AhoQxUjDa0d8Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8230

Hi Christian,

On Tue Aug 19, 2025 at 4:04 AM JST, Christian wrote:
> Hi, Alexandre.
>
> On Mon, Aug 18, 2025 at 8:28=E2=80=AFAM Alexandre Courbot <acourbot@nvidi=
a.com> wrote:
>>
>> On Wed Aug 13, 2025 at 3:00 AM JST, Christian wrote:
>> > Hi, Alexandre.
>> >
>> >> I mentioned it on v8 [1] and v7 [2], but the tests that break due to
>> >> this change need to be updated by this patch as well. This includes:
>> >>
>> >> * The doctests in `rust/kernel/dma.rs`,
>> >> * The `samples/rust/rust_dma.rs` sample,
>> >> * The example for `FromBytes` introduced by this patch which uses `?`=
 without
>> >> defining a function.
>> >
>> > Sorry for my inattention, I'll fix this in the next version.
>>
>> Ah, as it turns out you might not need to.
>>
>> We discussed this patch a bit during the DRM sync, and the consensus was
>> that it would probably be better to keep things a bit simpler for the
>> first version. The `FromBytesSized` trait in particular was not very
>> popular; a better long-term way to provide implementations for
>> `FromBytes` would be to use a derive macro, but that's out of scope for
>> now.
>>
>> Instead, we agreed that the following would make a good first version:
>>
>> - Make the `FromBytes` trait depend on `Sized`,
>> - Provide default implementations for `from_bytes` and `from_bytes_mut`
>>   directly in the `FromBytes` trait,
>> - No implementation for slices for now,
>> - Consequently, no user code will break due to the addition of the
>>   methods, which is a big plus.
>>
>> The simpler version that would result from this covers all the immediate
>> use-cases and would be easier to merge, which will give us some time to
>> think about how to handle the non-sized use cases (probably via a derive
>> macro).
>>
>> Do you think you could write the next version along these lines?
>
> Yes, no problem.

Thanks - I also noticed a few other things while building with rustc
1.78 and clippy enabled:

- The `is_aligned` method for pointer types has only been stabilized
  with 1.79, meaning we need to explicitly enable the feature in
  `rust/kernel/lib.rs`:

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index ed53169e795c0..c859a8984bae1 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -18,6 +18,7 @@
 //
 // Stable since Rust 1.79.0.
 #![feature(inline_const)]
+#![feature(pointer_is_aligned)]
 //
 // Stable since Rust 1.81.0.
 #![feature(lint_reasons)]

(adding Miguel as a heads-up, and in case enabling a feature is not as easy=
 as
I think :))

- Clippy was no happy with our use of `foo` in the doctest. This is easy to
fix:

diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
index 9bb707aabdc9a..9e4413fe9c32a 100644
--- a/rust/kernel/transmute.rs
+++ b/rust/kernel/transmute.rs
@@ -14,9 +14,9 @@
 /// ```
 /// use kernel::transmute::FromBytes;
 ///
-/// let foo =3D [1, 2, 3, 4];
+/// let raw =3D [1, 2, 3, 4];
 ///
-/// let result =3D u32::from_bytes(&foo).unwrap();
+/// let result =3D u32::from_bytes(&raw).unwrap();
 ///
 /// #[cfg(target_endian =3D "little")]
 /// assert_eq!(*result, 0x4030201);

- The patch adding `size_of*` to the prelude is not available yet, so for
safety we should probably import them:

diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
index 9e4413fe9c32a..3320e9e95057f 100644
--- a/rust/kernel/transmute.rs
+++ b/rust/kernel/transmute.rs
@@ -2,6 +2,8 @@

 //! Traits for transmuting types.

+use core::mem::{size_of, size_of_val};
+
 /// Types for which any bit pattern is valid.
 ///
 /// Not all types are valid for all values. For example, a `bool` must be =
either zero or one, so

With that, and the simplification discussed above, everything should be ok.

Do you think you can send the next iteration soonish? We have a consequent
patch series on nova-core that I would like to send which depends on this, =
and
since it is also very handy to have generally speaking it would be nice to =
have
it secured for the next merge window.

