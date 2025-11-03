Return-Path: <linux-kernel+bounces-883089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D26FC2C77B
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856CD3AFDCC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233A7280CE0;
	Mon,  3 Nov 2025 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EhQ4iGmJ"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011011.outbound.protection.outlook.com [40.93.194.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D220026B742;
	Mon,  3 Nov 2025 14:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181074; cv=fail; b=Quugd9rINxjHKs23E3mQ+J19Wd04sspKa4ir/aupxysMpOIQTKOpD9nWzo1OYlHUaR0NsaNhF3lGDrWtQZxWmh7h5VKaFR63PUmZ+PsEqB1rqXEzoExnkTOKlJhElapTlbRPiEEzSRhnzGODxYlh+sPXJDjH17M4P+TuuoYg/gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181074; c=relaxed/simple;
	bh=INJ6qVU4yFavU1lntD2caz2Ps+IonWeUIitqkukx/Qs=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=bxSfEjm8yWNE40aNSl8GIrqCaFWcteMfzVfVgJ7P5QaZwI7MKBOI5uPFnaIOptLlT7uCVnysZM4ujeMHgw+V5omJZE1Ukp7juPxCTOyXf+Zxh0TTzDwrzfkaZV4Vzr300vwzyzDWXPbSvpbzeSp//mVP+bZ7Jc0qBG2LnxMg8PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EhQ4iGmJ; arc=fail smtp.client-ip=40.93.194.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEhcEi4d9Gy+06exYClQ2vFEzF0Nw3x4ivLjQX6LQmukUSTmZivIyweIbivCQSVeMLZeFBio/23MBYYcSavKmJP+U3iIeS4DC+nwRISMa+8u+UA/8aidZOVpWi8mV2JltzeQavHGnIw/4r1KEQfl8Db9uDAbB2iYHzQWRsScQ9olu4cLpF3qPziOu3MG3nCtTyNJyXlizR/8Cwu4fBqMd44B3zksqCF9Z2COHFfcNMq4NxCqVz6KslsRclJA8L/DPQj79S80eM8ta/lFQJjMqSWNIm75JBusyJc3SsXfANbJCjSmV5EIdbAu/WS3bqCyUwxdwtfw+1Cwsq6vZguFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aG3CAm6PbqOkm+LUHptd/Zm1h+8vm90VB3u0UI73tSo=;
 b=xHNQshD/BNdtNnjOy9fiiKeH2DOcE1z/g7ilT7nmV+l0QL1J9v3w3Y+lnie65C8mwpgm7jU5ftwo1XbUGvxTgvwo/a/brm3A5c9bgqVAHCiL89vmPSX2qVdgW0ru++/V7m1AxbQMTgNVSx2fXVlXo7arKrlsecUY6SwnNki3K7p3wiuqMKtuvzqlS1FP5ZMtX2NaHkmsXZYJ2Y2BrRttARvp6UlDJ2GyqGw2ILUuLrZ8nI0/9ZBvCnwkCtLeG7kBJzIvSx4trongGkcXETWfIZ29tj+PUlfyUosMqeQpgF3vsthMaaaxdrFJzodRVTijIipVjxDXWXrwTocqohiI5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aG3CAm6PbqOkm+LUHptd/Zm1h+8vm90VB3u0UI73tSo=;
 b=EhQ4iGmJsBa5SMXZLQLgxKItzT07VLY05TnGVd25OFxH3m6ohLnzAjJFFnPbMzu9/noyVqvAZxHkc7LbwVIlXZiuV998+AdmYn5XMWKiyorfsz4orT0rtmCTj/tifGhqnrKxrVINz1uzD4j8XuaJEAfAgdYXXtvI8j2h4IEu2AXps9DQ1omNeUPTaj84CyIaZ6YOymnNiA6pfuHZxVOEqG1kcmHYqBsZhSWCDs5i1GP0+J7wBCM5csW93pmEQC2o/Nw6Rq1U8smLh4CI5C1DJCS1siqEjKU2hlBeL4/hd0JgLkZ3V4+7kExJwBNdaIMDMqXB9R7JmwkgSZjGgNL1dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS7PR12MB5887.namprd12.prod.outlook.com (2603:10b6:8:7a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Mon, 3 Nov 2025 14:44:29 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 14:44:23 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Nov 2025 23:44:20 +0900
Message-Id: <DDZ51VBAJJ5X.2V6GT3H8O1MM@nvidia.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Danilo Krummrich" <dakr@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Jesung Yang" <y.j3ms.n@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/2] rust: add BitInt integer wrapping type
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251031-bounded_ints-v1-0-e2dbcd8fda71@nvidia.com>
 <20251031-bounded_ints-v1-1-e2dbcd8fda71@nvidia.com>
 <aQgQv6F0Ao4DH6U0@yury>
 <CANiq72mg-NntJLf_jbigz++0hK7G3WAxbvejRq1EzOc7GE+doA@mail.gmail.com>
 <aQi7e6VgFsqpq1Rn@yury>
In-Reply-To: <aQi7e6VgFsqpq1Rn@yury>
X-ClientProxiedBy: TYWP286CA0028.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS7PR12MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: 93c03018-1b9f-4ea5-6e6a-08de1ae77aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yk55RGtWN3plMWZNL0JlTFJCbmg1RjVURitFL0hhVitCSkpIR1JBWmVlTWVF?=
 =?utf-8?B?aVdKckdMdTlEVVdpaDIyYm1ZOHFwVVlKdUhGSnd0TjlmOGpJSE8yZEdpdmFN?=
 =?utf-8?B?ZU9yZUo2RnVkSW85RXhKSDlLV2Q5NHdNdEhzKysvaFpSTTVxdnQ0OE92Y0Nm?=
 =?utf-8?B?SDJOdVBVOWxhOTYvc1U4cncwVnhaUm5NNU9iTEFTQWFIQTVvYmF0ZHQ5c0FO?=
 =?utf-8?B?eEp4VFF1cjU5SU1FTzBtVlpzV3l3Tkt6SlY3NzZITzhuaG5wVzVJbmM4WWhY?=
 =?utf-8?B?OG5UbWtQcnVSTklmaWJ2M1dDTmludVZLand0bGdiTHdFVWpFK0s1VWwrRlVC?=
 =?utf-8?B?WHZ3RVprUFBkWWRudndMNEhteUVQL2VnMXNCQXcvWnRhUGZjNHlQaUdBa3hh?=
 =?utf-8?B?bjdFQ25mVlRGSFVzUEJBWUQ2VDdXNGtuSGt4Y2dKejQrR0xxdEJmS3Q1UVFJ?=
 =?utf-8?B?NFo2c3gyb3FaOTkzRjAxcUZLYWttREFwRmw4eDhFeS83UFBQTm5oenZpYXdx?=
 =?utf-8?B?U3FMQ3pmV2sxL3BaMS9GWURMdG1CMTNTcjNqVWZCN3JJL0pZM3RMUThrR21x?=
 =?utf-8?B?Z3dtQUN3WmpRNHpkbGs3VXlYcHZITjNNSE9PS1ZocGZ5ZE5sNWl4c0JrdG9i?=
 =?utf-8?B?elA3aGhRak1WWG5xUDIwOEdCZmRCN0VMaG9kU29mVjcreE9GaDRmcTVSbGxv?=
 =?utf-8?B?OFFNQ05aa24ydTlPYkI1bjFXT0ZLbnhCMWlPUGxRby81VlFnU0NoVkNWR0lx?=
 =?utf-8?B?dUpVSDlWc1dTQVhiOVI0enhoK2x3eTdsTCtxMTA0Zmgram16S0thVEZIUHpI?=
 =?utf-8?B?TGFiSmNPVXpXMDlGc0VEZ1BpUGk0VnpZNFhNMVErOGI2QWNFVXdNenV5VEhP?=
 =?utf-8?B?RjVJTTZuZG81dEhqWXdRWVlpbWsxMXpJYk9jcDZIdG82NXlOUnlraXJXenY2?=
 =?utf-8?B?bGVMSEVuZStIdWU2cnVjMlo4VkFEcFNBNEc5ejlVVDcra1VUekpQYlVKNC9q?=
 =?utf-8?B?N1ErL0hVNGpPcEJLQjVwWm1CU1pIc0lwbEZTdnZtZmpGaEZrUU5aaDNYQlJB?=
 =?utf-8?B?ZmVvVkU0cFRVRUU0eXZLVVpnOHJocUNwd3VOR1FUSU5oUTVEcmh1Mmg5alhY?=
 =?utf-8?B?VkRzTGF2OHoyaTE0WXFhVEVsQnVrTkNXVi8xS3lXSmQ0bHFYQlhWYVpVWVRP?=
 =?utf-8?B?Z0lGek9TLzBxTHRydEJJUzFDTDBJUTNaNEY0YTZDRFJ1b1orT0JpZFhFY2w1?=
 =?utf-8?B?YThCWDVjQUxHUWlNZ3lOMDhheWkrWUNLdFRCQWxta3psYXhFQjRpVm1KeFhL?=
 =?utf-8?B?ZTQzMSttUHFrVEJWU1BhUTdnVTJtYVVxV3JITW9QekU2TWljdE1UcG9Qdk1X?=
 =?utf-8?B?R3ZwWnpROFZhVW8vWTZZWnNCSzk0ZkF4dktlVzh4WUlOd21UWVJaQjVVWUxS?=
 =?utf-8?B?QW1oRVNMNzFodHRZMWh3NWdBM0V5ckxVQVhXRmMyUlZLb2dIaUF0djRtbDdk?=
 =?utf-8?B?MjlYZXZJNFA0d3dtaHFTQjdzdlFQK0N5V1hnQmgydW9TamtROUVLMzZzNDg4?=
 =?utf-8?B?elpaQ2IwMlZhaEQ3ZnZzYXZMT0FKdHo2Y2FEMEZQQUpXVkhGb21PMkl3SDAv?=
 =?utf-8?B?WVZDTlRkNmhKcUMvSHFXSWZMVWROZm1BV1Nwb1o5aWlxVDRvblVKUzAzdzRF?=
 =?utf-8?B?clk0RDRaZENUWFloc0lqK2trdUhMZC91YVpSNmhXcndseThYRWxCT2xsTFF2?=
 =?utf-8?B?OFZRdDFPNWczWkFUTjdBako3Ykl2NlJxeXFORlpYb0xDUGhLS25WZ1VpcFIy?=
 =?utf-8?B?Y2VobW5MWExka2RweGo3RkZBQ2dsRUsyUyttYzQ0bFF0RGhralhFMnJwc0Fq?=
 =?utf-8?B?WWZkZjdScWV4bVdFMG9NelZzSCtIYmozRVBCNWYrMjQxYlkxVTRzSkwzODRD?=
 =?utf-8?Q?RVNf/jj0NAh4W2sHganXrg4cGwJ3ICBG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkZvdFdTUU90MytmZUJzenVPb2pxREtLd2VEZS9hSW9zRTd6OVgyT3F6T2tw?=
 =?utf-8?B?bGsrbGRhM3JTQ0lSdW1jb2NuZmhUci8xdjBCK1RQUnc1a21uZlQybUJucHda?=
 =?utf-8?B?ZkI2b3RiQW5vNkxaNzVhWSs5NXJUNEEzakgxTkk0b3ZIcjI0NlRoRTdzQkZJ?=
 =?utf-8?B?a1lvbTEydGMvV0I0aWpJMDBBUm5VNEE4NW1TTEc3VklXMkRTQVFpZlZZbHRz?=
 =?utf-8?B?Z0JjYUUxWG9tSlRZUzBwcVdOZHNqRUtSN3Jza2pnV0ZQS3ROVG56ZHM1TTFp?=
 =?utf-8?B?M0JkMVpoUWYvRS9QU0wvYlltdW1VRjNucURwR2dhZmJHOFBtRzhVNkhpb0lj?=
 =?utf-8?B?VElJbDdqdGUvZEdBeEdvc0owM1p5dW9pa2UyenkybkxVYjUwWndCN01BZXdx?=
 =?utf-8?B?Y01wRC9Lcksvb0Y3WVpyZWRYR2hhTmNQODVBU2ZPODNMeVN5RExHcmFQcWVF?=
 =?utf-8?B?OTJRMkNEeTkyNnlraWRkSUdwL2M5dU53VXNIbitFZlJVWGtBNzdIclVWRGVV?=
 =?utf-8?B?TUdUS1ZSWjhocTh5dVpWTFUzWjNkZTM1TEdXSFVYMFAzWTB6cFVJTHF6WGo1?=
 =?utf-8?B?WlVyR1dzV3A0cjBTOEpzeUhqSElsQS9oaW42aitCQ0ZsWXRaZjNjcThXaUM0?=
 =?utf-8?B?eE5ERkRBTDR5elVKNm8zUTE4cW45eWt4cVZtZzVkUTZTdUN4czdUQXUrZjU2?=
 =?utf-8?B?OFBhK0V4OGpwQWlQcXR6bU9hRjNvVFliVXYrTHRnQ0Zva3Rodmd2TDZMZ3Vh?=
 =?utf-8?B?czN6cVJJaFpwZ243OXNmZG1tMVlPWVVIMzZrYXczdFBCZ1NVU2dNb1JBdnhi?=
 =?utf-8?B?eEZ5SWtSaER2SXFML3dCYmNST1BTSW9Za3J2TzJFSVRWS0tPZi9qOU0zN1pN?=
 =?utf-8?B?V1FSZHZjdmF6Z0xvK0UxdlIvOG1Xd3hFRnd6VlI3T25JV09pMHc3L0NYZGZF?=
 =?utf-8?B?emJ1S1BJNUp5K0hVOHBCVXVOMXJEOFhyNEptWFh5aFNsbmR1aEU4bFIxSWNB?=
 =?utf-8?B?cFEvb0orS0M3bEE1M2xGSXR4QTZHT1J4RkFuckRuUUtwbWxwbUUrNE9KcXNy?=
 =?utf-8?B?VEUyQlo0bFVxZHAxbHRGQmJRaWVHaGhnTFBGZzd3MVdJd3Vsd0tmcmJ6OXJV?=
 =?utf-8?B?ZERLcEJzdGhXMUE5WEdWem0vdmlKUzExdWNnejc0dzFvK3UwSGQ4U0U2RXAr?=
 =?utf-8?B?d1N3NkVwSEFxYm5IMnlOckNlenNPK2RHSC9tZVBoaFlEVGJEeTQ0MFRNUHBX?=
 =?utf-8?B?WThOeUVBSnk1Q0p1MDhKNmRkRXdjN2dXWUozOXZtQVU4RXRISy96dEtWZ2VT?=
 =?utf-8?B?d1ZZcEwvU3Jra3lyazFKazZUSVM1OUNzU05COXpyUzUzbnh2YmlYc3ovWFJ2?=
 =?utf-8?B?YmxCSVEwWFExUHhJZE1GV215VkJhNkFQSWE1NXNURDJBZXkycHZpUlJkOTRG?=
 =?utf-8?B?WnlxUnJtZ09ONU1reEJzRi9WQWNvWTdybjhDOUhuS1VXOVBXR3piS1pjT3NK?=
 =?utf-8?B?ZmJCMGNtSjQ5VVBRRzNzWTNNR2NGUDlTdE1UUE82Q0dCc3NjZjBqaEQ0ZkNv?=
 =?utf-8?B?UDdXQ3hTSGUyRE13MU9lTmw3Y3BpeTQvTGdKWGUvdFdpblJLVGwzTzBaeEk4?=
 =?utf-8?B?OS9MdVFrcDlKN00rb2N5ZXRqK2RZc3c4cVh5S1ExeGN0T2duQTkzRnM2RnVi?=
 =?utf-8?B?SmN2WWhZRDU5NVFJbW5qWURFSlhmOENGVjNtY0wrcnNuVGtyK3dUeWJPaERn?=
 =?utf-8?B?RE5heFo5SUk3dHlkbWhYM0ZhWnNZZXFOVnRsdjlaTnNmTTlyaEhEQXcwOTl2?=
 =?utf-8?B?V2NyVWVIYTd0MDJsTVhUTzhkYTl5bkEvVjB0QkRPb3A0WTRCUXY5YWF1MFNw?=
 =?utf-8?B?Y3NJUko1cXYwbzJocVlmbGtwSThKMDV3VTA5djdkek5QUlhPaFJTcURwNVNH?=
 =?utf-8?B?eDJBWnJJQ0ZsRHBudjZCa3I2eWcrcXh0OFYrRGZkKy9SSmp3d1h5Nm9UblhV?=
 =?utf-8?B?NklqcFphWFpmZThaOVZST2RNa3JkNkdCcVNXbmR4UHBVYW1XZ0pXREtDNThY?=
 =?utf-8?B?QnUvNEkxSmxLdnIrL2xJVktYcnAxVEt2eXQ5VE93NXgrcXdUWHA0UE1CUUhQ?=
 =?utf-8?B?MmQ3KzI3b084WnN5RUJCS2w5NEQvTGtMRG1BVUtoVUdzd0xQYkxBaVhRRW52?=
 =?utf-8?Q?zP0tPHezGb5UFJdthe3A7CztXlCHw78pamz50XXdN3El?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c03018-1b9f-4ea5-6e6a-08de1ae77aee
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 14:44:23.6940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ff8LsOl2y1p0MjKPJTM1gvQP7l73zKj0LHOOg0b7xW4QBAOSCBaLWfp22tbiS5kOnqjjJep8e7CJ5hqrrj0QQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5887

On Mon Nov 3, 2025 at 11:26 PM JST, Yury Norov wrote:
> On Mon, Nov 03, 2025 at 03:10:01PM +0100, Miguel Ojeda wrote:
>> On Mon, Nov 3, 2025 at 3:17=E2=80=AFAM Yury Norov <yury.norov@gmail.com>=
 wrote:
>> >
>> > Rust _must_ do the same thing to at least be arithmetically
>> > compatible to the big brother.
>>=20
>> No, Rust doesn't need to do anything of the sort, sorry.
>>=20
>> The point here is not to copy what C does, but to improve on it.
>>=20
>> In particular, we definitely do not want to have anything like integer
>> promotions and arithmetic conversions from C.
>
> This is exactly what the patch does:
>
>   +/// let v =3D BitInt::<u8, 4>::from_expr(15);
>   +///
>   +/// // Common operations are supported against the backing type.
>   +/// assert_eq!(v + 5, 20);
>   +/// assert_eq!(v / 3, 5);

That's incorrect. `v` is backed by a u8, thus the RHS `5` is also a u8
(and so is the result, `20`).

