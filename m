Return-Path: <linux-kernel+bounces-783067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A708B32901
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC425C07BC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A862586C7;
	Sat, 23 Aug 2025 14:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dA9IkALg"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79E31F4174;
	Sat, 23 Aug 2025 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755958371; cv=fail; b=cMGUL+XBFqKOZIVejlXFap5BtheW7VH+lN9VVHwCyvz6DHN/Cw8xLvsljGj75T3LJQaFDA/WB5/ugX5lrEXnJKiSU81/e+f+jdirZAlULPC9vTKAx6qUDC1F44ewjK8khRCAAUyJxu/9ZQzljCXCqVkaYnWZCv27AgsPzgDps74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755958371; c=relaxed/simple;
	bh=evvEqR3+eJ8/MwQqC5APVNlCklktZ8lT3PkjjutsDGM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=AwH+v/gSorh3wWpTDQUqE8Mr9AICI+xy/uXpVxfYyN1ZdH63cGOmrDPe90VvatVjZ2m7bgfs+tkXmR/b9X1Bk6gQK/vCxVSSGYge5Xx9SHfJtM/ozW4TgC0rNURB09T1/xIT/zUiU/bCzZaiii3t5SntSdYFqrKcWaDqP4S7iC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dA9IkALg; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VIWQEJRS0hyTMhqI0mN3jVd+3R/lU+ljT77Uj2jEHc7ocj+wnWrnZkA7Izid7Xos3nfTIjRQDx3RPrikphbCP4Ri0SySjKB2+Zh6DhXe9clySfTyD1Zcvm/EMVDZi6DbptPYYkkFBq5Zr48moFT0IedilH61/LmJve/a1gV+9pqULIy0GT92wmdCON/Dno6bxQki1eRe3/Sk+TxMvMGe2kRFlah+O8qjOwjGMRsw1P8GY6X3aq78ES6fWuJjgGy/EKng4PbwaVHjn2gw9Ru+6ouuKvlHxwhN+ohQHTb+8/QYOnRLXjepwLqa/r+lPMWhbnz9R4wW1WqeJBVdtoSssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScLZAwRXzjgaDwEdDU+oH+olbPhfy8uj5I1By3h9vvc=;
 b=DOB0bCX77QUP4qcY1J5B8ZRRYF7K33FuqAcUNWW1N2yPB0a//qLVAHPccCBzAnkJS7wSK1ucIRhLx1sWkoFsBkV75cjU/4dQq2hM6T1tV7Hp2Ecxg5SCV4gQDSesBoMR75E14nmm4ruY2G2vNnxHEcN2Q23nhuaOtVVHHooA0HBZB62wECBUtHWuo4ic1CktSX0Wf4bAhCeAe2THq91AZE4cRfXevLJq586dT4ydXhZHeFvYggqg5YOCp49dDLriyzdAE5yMpSIvFjIGKrx5hyosmoIhvDPlhxLTKNl1lxjg8q5U4xreUi5rOmJee19mr+NSyaih9hYNLG1/AAtdGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScLZAwRXzjgaDwEdDU+oH+olbPhfy8uj5I1By3h9vvc=;
 b=dA9IkALgyVS3zLl06A2kvJ7gKnLd8mbmMEfNGam0EM4SKPwq88EJHVfk4gXbIqGjcJO3B67TSPaBoP+RRnkySg9KUL1E6wAvIuWJPTFUxYlgQ3ROER7isliMH1dL55aEKmZmxCY5DrkhFgbZxbMtCelZKzjFsm4GMW0r5saThe+p2tTLXD8KNRIaBWLQ0tv63ryqJonOLHUyw7uAEsfN2P8ljGLKRmmQHwhrtdljGcGIG/kycV5v2yFf6sG7y4CvhubqV1QQhLGWjgFB7NZrTxdQ7FxmTA11yAjTB14ZFIAHmDeLYb7BPEUPeIjfBq+PgX0Ha2R56qagbc0JGFPsBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BN3PR12MB9570.namprd12.prod.outlook.com (2603:10b6:408:2ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Sat, 23 Aug
 2025 14:12:46 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9052.014; Sat, 23 Aug 2025
 14:12:46 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 23:12:43 +0900
Message-Id: <DC9VAFQUGJ77.3E5GETM4HPPUK@nvidia.com>
Cc: <akpm@linux-foundation.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <jgg@ziepe.ca>, <lyude@redhat.com>, <robin.murphy@arm.com>,
 <daniel.almeida@collabora.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] rust: scatterlist: Add type-state abstraction
 for sg_table
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250820165431.170195-1-dakr@kernel.org>
 <20250820165431.170195-4-dakr@kernel.org>
 <DC9U87GQ7ONZ.1489DEN1PPUAC@nvidia.com>
 <DC9URZWE8Z4B.2R7NDRMFKENGK@kernel.org>
In-Reply-To: <DC9URZWE8Z4B.2R7NDRMFKENGK@kernel.org>
X-ClientProxiedBy: TYCP301CA0080.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BN3PR12MB9570:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a940f8e-f465-479b-5b5f-08dde24f2231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wk94OVpEZlZiT0labnNseWNJOTgxV0lsdm1JU3hlOExPb0JvbGRzMDBSeFR5?=
 =?utf-8?B?T2R0Qkp6S0M2ejRvMUVKRUFORk9tcDliWkxUYlpBd1pxSDBaTDNoSmdzZU5Z?=
 =?utf-8?B?bVJsV05hRnpCMG5CL1FqV2NFL0g4WDBKQjFjY3ZZQXkvVVZEQUxpdkxyWFdO?=
 =?utf-8?B?MjBQdEp5UmpJNHUyditzSytGUTRpbmZFcGc1c1pmT3dROXVCVExWU0UwbnI5?=
 =?utf-8?B?ei9pK0ZXSkRMQ0t6Q1VleGhLR3dxRDh1d0MyTlVnalBUZ2p6aDJQMHllQzBY?=
 =?utf-8?B?d2tKcnlLTkFSVWVhSnN5T2d6dzZQUEJHYWh1VGVZNnZzWUpBZHMreEY4MlZW?=
 =?utf-8?B?dUppS2daN1JRM2xnWFE4L25hV3BjN2tQWWc4Y0RCNkdKWjNPVVdaNzkrUjN3?=
 =?utf-8?B?S0dKU0p1TzBxUmNtT1drQXp6ekYyM05Wc21mVy93Yk9SSm5JNkV5em8zWTBs?=
 =?utf-8?B?Z0FITEFDNXVIY2g5TC9xTi9hREl3c0h3U2orTmFjS2FFdVh4VEVHYWlaYlNz?=
 =?utf-8?B?MThSOUVXZ1dEd3h5VEVJc2R0UTFTMEI2NmZxVlZnbW9VZGQxb3RPN2tpY2xM?=
 =?utf-8?B?b3ViK0FmOUZTNjlpVDJKVkxMS3E4VmdMUTg4YWtCaTBnaUZQVHRlK2NqRzNx?=
 =?utf-8?B?emI0akxLOEpQWkVHSkJiWk1HdGYwZEZja1RUTVJpTCtMVXBiNWREeVEwK0xX?=
 =?utf-8?B?STI4eW1aZ25mdkQ5M29RTGMxcmNDdjZ2dHRmaHVrN2x4R1pubzJ3dVdpTU5Y?=
 =?utf-8?B?T0VPWGI0U3VSWG41TWx5NWthRnQzQjRnbjZHdy9LMW1UTG93TGFNeGUrVy9i?=
 =?utf-8?B?S2N5Nk5lTTNqb1k5cWw0ZjlpejYwZHZBNWlYU29aSlR6VlhZWWJDUmdMczZm?=
 =?utf-8?B?eGt4U0ZFTVpiSEY0UVZGOXR2YWZEanZXSGlPTStLMWJ1K0VuZEZRbWY2SWdB?=
 =?utf-8?B?V2lvVmlleWI1RDFxWHc1T0tvOUZOUlo3eEpBeUJpT2VROXAydzUycUhUaFAr?=
 =?utf-8?B?T1JkdG9nUnJqYU5RaFFYblNTbWJqSis1K01oby8rWEpQRDFYdWVjS0orUjA1?=
 =?utf-8?B?d3NtZG90S2ZMenBnSnNVbVptRXBKbHpmdmM0Nmw0QmNXNFdYZWZnUFI2MlNt?=
 =?utf-8?B?a05oR05DNFprbXBTZFYwV2s5VjJicHlMTE96OWV4aXFPVTgzNVc4UWcxaGY5?=
 =?utf-8?B?akJlNEpEdXpUUjdZdFpEOXVWdFAwQVhtZ3FaZmU2WHBPN3VqZ2wrMHdMclhh?=
 =?utf-8?B?emZjNk01b3BLOXYwMzE5MWxQMWVPaFVtTzVMTlZGS3FaVXMwaFc1TEVGbVNT?=
 =?utf-8?B?aUxYLzUxN3czbUJEOFp4Z0YycGtUS3ZDMk13MjhaNWo4NVJJUXhsOXA1a3cr?=
 =?utf-8?B?VjN3cE5ueHJXQ0VrYXFZRVgxRTlmcG9WQ0g1TXhLS0FXTnBNZk9TRmV3Q01x?=
 =?utf-8?B?UUFLMExjSzA2QjczZ3U3S0tQZlFrS3dpRkxEZGVFOE4xK0xJS1MzbUJlNmw3?=
 =?utf-8?B?MWhUdjhvRVJMZHNySHhJNnh4WVU2VS9CNEJFLzB6OThESC9VTktSc3lEeFhB?=
 =?utf-8?B?Z1ZEdmhxemVIQURpN091bTZmWU1ER2tmN3BwN1RWbFhaclN5VThRd0FBaFR4?=
 =?utf-8?B?aFlhN0NOMXhpWVpoOTA2SHo1TFZRdndyVFpNc1BVNmROTU9MQ08zR2dxaXli?=
 =?utf-8?B?RGtUOGk4djAvZmFIY1dFcERhSmVQc0ZHT3JsWWVVVDRHb3h4b1RZV3FHemx6?=
 =?utf-8?B?TGozQVpvM2hqOHAwMERQV00rby9jUUtmeUVrRjF2WUkvZGtWRWlwV1B2Y3V0?=
 =?utf-8?B?MS9aQlB3eVlBS0VST0o5RGZSUmtmTjhYLzFPQUxxNGYyQU9aYlRoOGRLUGRr?=
 =?utf-8?B?NmZUaGhFYTArUEpuWHdIa1pEK3N4QmoyUTlNZ1lnMWNhdmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEsxZ1ZCUThHOXJKMTc4S05kTkhNbWZUcEdOQzVydGJHZUtxSllaNW5oaHVk?=
 =?utf-8?B?ZDRYNk14b25rT21RTEpGZlNVR2M4MkF2aUw3enFNYnlmNUJLaVJ4cXB6TjlD?=
 =?utf-8?B?WXBnRVJrd2lGMFlOb1FtcndrUGpKbER4Wm9Lb3hCS0pJb1VqVHZkMDJyZ1Fo?=
 =?utf-8?B?SHlvb2RSdTE0NjZnVXpmQkpPTTNQeUxUbWtYVkRFVFFMYjU3Vjh4MEJqYkFD?=
 =?utf-8?B?dzNUNGlCOXJzeVBWRDVrTWNZSGJhdGJHUEQyU01ZV2JiQzUvSUhhd0NzRnpl?=
 =?utf-8?B?WmIvTDh1UzQ5T1hVcURFOWhML0NVQ28xbG5TN2N2QnlSbkZScmtpMXNzQlMz?=
 =?utf-8?B?UWdoWnh1MVluUkUzd3JrckczZ25oWWNvOGlEczhkT3l4cnpJZ01aK2FhODlo?=
 =?utf-8?B?MStSMGkwRlZoQUgvLytWcm1lNi9nbnoyQzI5Uk5wbEdtZ08ybUVuU2htZGlK?=
 =?utf-8?B?ZTRhdWUrZlBReXNvRXpuQXNUeTdKL0hLNzAxd3FDZHdkd1NKVm5Ob2tncXBI?=
 =?utf-8?B?cEl6dWY4NnA0cHZ5eStQQ1B5d3NVQytZS0E1ZkZCSTFndVQvYkR5WmtzUVY0?=
 =?utf-8?B?QzRZU3FYWTRuTEdWVHNRM0kvZ0tkSGlEL2xXT2g4V2Y1dno3YkhzWU1KdWlT?=
 =?utf-8?B?NkVpY1hTMjV0cE85a2ZYNGw1WWtSL1p0blZPWnhKZzN0UjJ5QWs4enNKcWlh?=
 =?utf-8?B?Yi9yQkNOYzZVcCtyZnovMktqL2JoVVdEUEN4aGg2SWN2WE1URWJ0N2tReThF?=
 =?utf-8?B?T3hKbGE5MDRsR25nck5TN1YxQ1E4Zysxdlo3N0lWYnhBQ1RtYnVXOU5ORi9F?=
 =?utf-8?B?NUpERzNTR0ZiTno5Q0pWZW54NzhTSTI1UndZOCtsOGk3S29ZNXpjOGYvaURp?=
 =?utf-8?B?clBTZHNjbm90aUpaOEVzeGg4NzBOUlVlV0doc0tPalNYbTBOL1BHelZHQzFj?=
 =?utf-8?B?OGdyazFOYXowOVFwTFc2bUFCOUhIaEljWXNabHVCSkRKL2hXbjI0aUlRVThh?=
 =?utf-8?B?eDFQTHhwejRLb2VHbjNMZThwaXFVZUdpU2dkMHBncUF0VFExbmtGZmlJcmp1?=
 =?utf-8?B?NUJoUzAxSWdINHFyd2hZcy9ueHBHcFdsQ0JNckxTTnFGSzZiS05kdHNSUFZh?=
 =?utf-8?B?ZHJCcXBzNlQ0cysvWFA0RjFDS3lzdTNpRUpWa0tSOUc3dkRzcjNtbDdhUmtT?=
 =?utf-8?B?VHJQK01Fd1VoK1VxcDIxQTJOMThZUjhQOW1qTzVmRlVDV2dJaHdMcmlFcCtU?=
 =?utf-8?B?VnhPWFdhcVhGME1USHNMTnZvOVJTNk13Y01WckdvenJ6Tmwrc1RGc2ovYkkv?=
 =?utf-8?B?cC9YeGdidCsvSVRQNU5hcURTRzRuWUNTOG9UY3UvSFI2OWFwRDRVL2M2ZW5u?=
 =?utf-8?B?Rnp1VU9OWnpFQ0ZKTGVJL2pjMk9BNWlaclRqVmxPM3hwb1VQS3V0b2tLRVQr?=
 =?utf-8?B?NkxDZjdpM2h2T1BDQnA2S0ZMbVBKV0NiRFU4andleTJ4dzMrWmNPczRaeW5p?=
 =?utf-8?B?ZjlUaHh1Y1o0Wnl6UnFCYm5KUHp1bWg4c0FaUk40RGgrTVIwMGxUVEs4Q0VM?=
 =?utf-8?B?bHV0Q2xGaUNtNlM1REpOVFp1YjJBckJpR2ZLbTZhVDZRWTVPOWJFeEFaS0VH?=
 =?utf-8?B?MmV1TVpvbzFxL3FCT3BrRlVHc1JmMmVoSVNPSnRaZVNyNndPeFNpckxOYUJQ?=
 =?utf-8?B?eVA4VUU5U3c2V2UrWExDemhSREpaTm5sempBNVVWSUVzT3hjYXFmSFQ0VnJ4?=
 =?utf-8?B?MjBDaDFQNXpOT2N6ZkYzbFE2amE5VXUrVnVZRFlwUkVCQXFaOWZMNTlZQy9r?=
 =?utf-8?B?NkJuVVpMZHZJM3YySGpVQXlZMGVxZm1uTEJRckZhZTI0VzJMWXYyQ3lFRHZF?=
 =?utf-8?B?VDRrMkpWUEp0OFR0c2ZXYk0yN2N1R0ZqbGRuL0VLSUNNRVAvNFpHam01SFRQ?=
 =?utf-8?B?eWtrcDd6RGZZWm5vV1ZwbVp4SzVWOS96ZXFiWnd1RU5odkxrNXJuN1ZjTWZ4?=
 =?utf-8?B?UGErdlhWSGN0ZlQ0Rys4bFFqais2WVdTVmUwSnBjV0h3NjhDYlFnbktscC95?=
 =?utf-8?B?RVZzRyt1dVgyTnVxeXoxVWdNL2NyUXE1Y0QyWENFLzRGc01JbStieVhRamFt?=
 =?utf-8?B?bUpVdmsrYnE1M1lMUkl0L3ovMmp1YlBleE56SGRaazVhaVhzc1IvamF6MHg0?=
 =?utf-8?Q?EMv/UuH33pG6Kt7rs4i6/G/K9F9xRQZK/ToUk+oOoZUK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a940f8e-f465-479b-5b5f-08dde24f2231
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 14:12:46.2163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UhTkqPe4U85QnJuGdAdMCsfaV25FXiWdfEpO0T5fWdP0VmSW9/cyJlDoamfMuzpqme409+H+TliImMsjqBUZEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9570

On Sat Aug 23, 2025 at 10:48 PM JST, Danilo Krummrich wrote:
> On Sat Aug 23, 2025 at 3:22 PM CEST, Alexandre Courbot wrote:
>> On Thu Aug 21, 2025 at 1:52 AM JST, Danilo Krummrich wrote:
>>> +impl SGEntry {
>>> +    /// Convert a raw `struct scatterlist *` to a `&'a SGEntry`.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// Callers must ensure that the `struct scatterlist` pointed to b=
y `ptr` is valid for the
>>> +    /// lifetime `'a`.
>>> +    #[inline]
>>> +    unsafe fn from_raw<'a>(ptr: *mut bindings::scatterlist) -> &'a Sel=
f {
>>> +        // SAFETY: The safety requirements of this function guarantee =
that `ptr` is a valid pointer
>>
>> nit: "guarantees".
>
> "guarantee" seems correct to me; it's "requirements" not "requirement".
>
> (I think we commonly use the plural, i.e. "requirements" even if we end u=
p
> listing a single requirement only.)

Ah, you are correct! I missed the plural on "requirements".

>
>> <snip>
>>> +impl SGTable {
>>> +    /// Creates a borrowed `&'a SGTable` from a raw `struct sg_table` =
pointer.
>>> +    ///
>>> +    /// This allows safe access to an `sg_table` that is managed elsew=
here (for example, in C code).
>>
>> nit: "to a".
>
> I'm not a native speaker, but I think "an" is correct, since "sg_table" i=
s
> pronounced with a vowel sound, /=C9=9Bs/, at the beginning.

TIL. :)

>
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// Callers must ensure that:
>>> +    ///
>>> +    /// - the `struct sg_table` pointed to by `ptr` is valid for the e=
ntire lifetime of `'a`,
>>> +    /// - the data behind `ptr` is not modified concurrently for the d=
uration of `'a`.
>>> +    #[inline]
>>> +    pub unsafe fn from_raw<'a>(ptr: *mut bindings::sg_table) -> &'a Se=
lf {
>>> +        // SAFETY: The safety requirements of this function guarantee =
that `ptr` is a valid pointer
>>> +        // to a `struct sg_table` for the duration of `'a`.
>>> +        unsafe { &*ptr.cast() }
>>> +    }
>>> +
>>> +    #[inline]
>>> +    fn as_raw(&self) -> *mut bindings::sg_table {
>>> +        self.inner.0.get()
>>> +    }
>>> +
>>> +    fn as_iter(&self) -> SGTableIter<'_> {
>>> +        // SAFETY: `self.as_raw()` is a valid pointer to a `struct sg_=
table`.
>>> +        let ptr =3D unsafe { (*self.as_raw()).sgl };
>>> +
>>> +        // SAFETY: `ptr` is guaranteed to be a valid pointer to a `str=
uct scatterlist`.
>>> +        let pos =3D Some(unsafe { SGEntry::from_raw(ptr) });
>>> +
>>> +        SGTableIter { pos }SGEntry
>>> +    }
>>> +}
>>> +
>>> +/// # Invariants
>>> +///
>>> +/// - `sgt` is a valid pointer to a `struct sg_table` for the entire l=
ifetime of an [`DmaMapSgt`].
>>
>> nit: "of the".
>
> This one I don't know for sure, maybe a native speaker can help.
>
> I chose "for", since I think it indicates duration and "of" rather belong=
ing,
> but I honestly don't know. :)

I didn't give enough context. I meant "of the [`DmaMapSgt`]" (as in, it
cannot be any DmaMapSgt; it has to be this particular one).

>
>>> +/// - `sgt` is always DMA mapped.
>>> +struct DmaMapSgt {
>>
>> Minor point: I'd call this structure `DmaMappedSgt` to highlight the
>> fact that it is actively mapped. Or alternatively document it and its
>> members so that fact is clear.
>>
>> <snip>
>>> +impl<'a> IntoIterator for &'a SGTable {
>>> +    type Item =3D &'a SGEntry;
>>> +    type IntoIter =3D SGTableIter<'a>;
>>> +
>>> +    #[inline]
>>> +    fn into_iter(self) -> Self::IntoIter {
>>> +        self.as_iter()
>>> +    }
>>> +}
>>
>> While using this for Nova, I found it a bit unnatural having to call
>> `into_iter` on references intead of just having an `iter` method.
>> `into_iter` sounds like the passed object is consumed, while it is
>> actually its (copied) reference that is. Why not have a regular `iter`
>> method on `SGTable`? Actually we do have one, but it is called `as_iter`
>> and is private for some reason. :)
>
> I think it makes sense to rename to SGTable::iter() and make it public.
>
> I'm also fine removing the IntoIterator implementation, it seems pretty u=
nlikely
> that we'll have another type that provides an Iterator with SGEntry items=
 we
> need a generic interface for.

I assumed there was some Rust pattern to this `IntoIterator`
implementation on a reference, but I cannot see its usefulness when an
`iter` method also works on a reference anyway. So yeah if there is no
reason against it I think this would be more intuitive.

>
>>> +
>>> +/// An [`Iterator`] over the [`SGEntry`] items of an [`SGTable`].
>>> +pub struct SGTableIter<'a> {
>>> +    pos: Option<&'a SGEntry>,
>>> +}
>>> +
>>> +impl<'a> Iterator for SGTableIter<'a> {
>>> +    type Item =3D &'a SGEntry;
>>> +
>>> +    fn next(&mut self) -> Option<Self::Item> {
>>> +        let entry =3D self.pos?;
>>> +
>>> +        // SAFETY: `entry.as_raw()` is a valid pointer to a `struct sc=
atterlist`.
>>> +        let next =3D unsafe { bindings::sg_next(entry.as_raw()) };
>>> +
>>> +        self.pos =3D (!next.is_null()).then(|| {
>>> +            // SAFETY: If `next` is not NULL, `sg_next()` guarantees t=
o return a valid pointer to
>>> +            // the next `struct scatterlist`.
>>> +            unsafe { SGEntry::from_raw(next) }
>>> +        });
>>
>> This might be missing a stop condition.
>
> [...]
>
>> follow the advice given by the documentation of
>> `sg_dma_address` and also stop if the DMA length of the next one is
>> zero.
>
> Doh! I was even aware of this before sending the initial version and simp=
ly
> forgot to add this stop condition after having been interrupted.
>
> Thanks a lot for catching this!

A detail whose knowledge is typically acquired through considerable
suffering. :)

