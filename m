Return-Path: <linux-kernel+bounces-871506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B87C0D83A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734DE3B1C17
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0B52F7AC2;
	Mon, 27 Oct 2025 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C4qSx2JU"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011039.outbound.protection.outlook.com [40.107.208.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9993C2F7444;
	Mon, 27 Oct 2025 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567615; cv=fail; b=DMpgRjj41iYueBvRoPkhZiR6xNRT/ro3oO4NAlRZZQLonBHWWqWws7qzXIbUxb1oAprut9HsvJWpQJMEk/eRdRxGd03RKe4YxhYs9d/Z0tw+W3xionPQhcZv6+Jrlranm9Bk0KfWYLtK+ZjNF8QiksZ7pE6hHvtSjOxM49M5wQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567615; c=relaxed/simple;
	bh=OITCrtuXIugsqwihMTD6KQBmwLw/sbnT41kgU19fmuc=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=ptjAF9clMutaU+vbNjQ4v+wclciKpZenbJULuG0MKH6N+SDYw9Ckidpv1Djc/aRr9XaeD+fBJsJL99pEErycUtldxVFileAka7MWuqh01f84Vcus/dc/jl0Nao2bZvY05RSmn8avOVWh0NsIO2U/gWusP4xrTMaY3XKgmvrjUiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C4qSx2JU; arc=fail smtp.client-ip=40.107.208.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hnna0OfJghfqUtKtZeD3iEPtxnbBX0ZwuOyBGUbXGfW09cMcNiHP/jQQk3fvMkyJWR25NLhIp6DyOsW+6TbVTZ9C0YIhVNa7Si1r8+w60Exup3VqPWHlW/5zMql2H9jp6yEi6/nXGf8Bf7GIfszJ6au+DTgCzaWKosfkkwGmFmv4UeVFO+m+QoeqVdJRK4n2MssFMHqDDGkV2A5nJ0zFnFBN75evjK0aBrsyigxypV8n/peBlaVO746ESmQoQX81A/oYWW0nrn48GGg/i6kmUlydof2Ngui+x0Hn3qc1Y0q+IB3zkuw+wzwGB1Pxg0rniX2lzciFJylV6fmqcfDtbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WW1pxIKvkSv6be8KsUMU/CebRZlmlgLkZbpRBeTrrHg=;
 b=mizMiIiUC16N5nJVe5wW2zZLXl7tQfQIlCLWz/1KWCFAlziqHc5lE16uRR73ym11Q5aBMTAC64ci+DaZUTXJIDysj3oJKjCOT7kEDB6WUs4R/unHOY9mjsGy3rMtpMxEyoK8n6pG2wI6aOE0/9tUgXUyvtC0tlz87BTtGo+AXtPugJHgpIOov2jyTe5CJL9noRF0cuwYpZ/iB4yObiQBc9xzNubPVNKqxiiN0wppeX49YTNXePD9pQBhRPbuhFNU0t7EJpuSdUdJhmb2BnEEiJVJAEzoN6ag3+RXPepBMBEosjLCVfOhohLXswohFYxUmRvzRl2B05XSOItaGCfIYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WW1pxIKvkSv6be8KsUMU/CebRZlmlgLkZbpRBeTrrHg=;
 b=C4qSx2JUkMlA+GM4mAI8US8siYIkKC9yt+zTz3zSUB5YfRQ3ABe9edE6YhuS/WlZ6bTUAsf4nMTrv/esunPZuH+LY4KTfRfVCOYFhedkWsjidYzLGpQxNkC7pUfjQiRVdoZ+KltbF8o3ddg4DWNUnzWpOKskaQz3sMA3PNcqyvIMmhHSmcO9GE5hB5moJAPz5wU5cYeZmzv7sy9RbBNHMJfFKwISuhpM2hY9Q5vV/SPnGrNL581A1XLpSkveRZsrzRsOLGm8Pd+CUP0K8M0EmszHv5MzaVVkL/CY3iT/D8NjN6DwQjZWyYZ7GrT7yjoYKdbbjfqvb/p5suJJj8pDyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB7711.namprd12.prod.outlook.com (2603:10b6:208:421::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 12:20:08 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 12:20:07 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Oct 2025 21:20:04 +0900
Message-Id: <DDT3LLSK1NO1.35CKLN5T4PA8X@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Edwin Peer" <epeer@nvidia.com>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Danilo
 Krummrich" <dakr@kernel.org>, "Matthew Wilcox" <willy@infradead.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 5/7] gpu: nova-core: add extra conversion functions and
 traits
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251026-nova-as-v1-0-60c78726462d@nvidia.com>
 <20251026-nova-as-v1-5-60c78726462d@nvidia.com>
 <CANiq72mgoW_TyWf9Nv=5t3Qij_dsDjicNpGsa=F1t+sg23vxSA@mail.gmail.com>
In-Reply-To: <CANiq72mgoW_TyWf9Nv=5t3Qij_dsDjicNpGsa=F1t+sg23vxSA@mail.gmail.com>
X-ClientProxiedBy: TY4PR01CA0113.jpnprd01.prod.outlook.com
 (2603:1096:405:378::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: a700510e-40d6-405e-967e-08de15532ab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0hQOGVMNEV4QldlOGY4TGxmZGx5QnQrbERkdWhNc0pIdDhSQUZqeHRIQ0sr?=
 =?utf-8?B?VEtyZUZBa09aVHJYeHFsRXVjZXhRWFUwVFRURXZkTE92MzZSTXRlUmM1Q1k4?=
 =?utf-8?B?N1ZhUXljQUFVNWNvUnZTSjJudG1TOUY0RjhwRFllZ2s2eWx5SDdiWGgxNWNB?=
 =?utf-8?B?TWJMR1pXc0psVk1tcklPVVIxYmN2Q1VQbjhvdUI1ZkQ0b0Mxc24wcUxuKzE5?=
 =?utf-8?B?VWsxTWNLWGhCdXFLUGVaWnNMTGh3OW9jajNXQU9lKzkwdnVvbGpDTE8rNW1P?=
 =?utf-8?B?N3BFMkpCMnNEV1FpY24zZFpwUmVhcGV6MGJNaVEyN1hZenhMa25oYXlqN2N1?=
 =?utf-8?B?MkwwRFNpSWF3RVRNZmE5YlgvQ3NTdEhybkN1YzUrZWVwcWhoWE43emM2M3Nx?=
 =?utf-8?B?bHRrTklYV0hNMXFLdjVRUG1XWUwvcFVuL1dNTjFKc2l4aTZRWGlwV2FTR1lx?=
 =?utf-8?B?TmlkRStoVDVoR2tYU2h0WjVKWHdIYVZ4WHZQNDcrTlQyZDFoMy9LS25mTUk4?=
 =?utf-8?B?cTlZT0o1bUQ0RFliWnJyMGhMTFRGckZiR3YweGJJYUhTb3ViNnAyYW9sczZZ?=
 =?utf-8?B?OC84aTBIZWUzUFl5SlRjTTJYMnRvYm1LSDVNRTVvV3RLaXB4UE1oVWswdHBN?=
 =?utf-8?B?Vk5tMDNhVGFqKytUbEJVclFkYjlVL0JUeW91aXBGbTladVgzd2ZOa3NSSTEw?=
 =?utf-8?B?UmwvaFBSYXpXYWJQNFBuZTlJc1FkckoxaFZydUs1eTErYlRRQkFCZFN5aGYz?=
 =?utf-8?B?cHJjekg2bzljZWgvT3NXazJpSlVsUnMwQ21lTVRPZ3BtYnFmM3c0YlAySTVY?=
 =?utf-8?B?QTF2OFgvcTJVSlpSWWJyZ1hLWk1lWGtYVkJVR25YNUZZMXVOdzA1a3JPWmVE?=
 =?utf-8?B?QW03NWs4aTk0eHp3Z09TUFlKdGhjbkVDVmFCTFc5SVBhV21aQlFMK1pJdWlH?=
 =?utf-8?B?eUFFQUFNZ3hqYlgvR3Z4NjY5UHZVVDZhSXp3VGI1T05BejMwaVZwcjJ5K2dB?=
 =?utf-8?B?YVZDT0NkOXo0WDcydlEveGExZXkyMFhib0dNanZlaU5zTzYyVXR4MkJtWGpM?=
 =?utf-8?B?MTA0MnVucGlJOWxqdW5lQ05jY2d0WnQwelJNUzh2UkFmLzNVTXhmSE1XWkJJ?=
 =?utf-8?B?ekVPWHZmODlrK0twVGRWclNlWjRybDFNSDNNSzZnSVF4d09TbFhmSTU3WWJi?=
 =?utf-8?B?cDRCTlJQTjVDZTJIcXNLbEhUOURaV3dkV21zWXVsVXFvcmp5elAyVWhDNXdH?=
 =?utf-8?B?OGVIZEx1WHc5YXN0QlJubVVrWnYwSmtCeVVkb2ltRzB4NU9VZTlyNmkzaVV5?=
 =?utf-8?B?d0tXQ1R6bTZOMzYyT2cyZnBBSVk5TUtOazhxRVpLcHhuNGhQMExzdFFkOExi?=
 =?utf-8?B?TTByc0ZHZXY3UEJUYVNUa1UxUUtTL05zWFpYVTZ4VlVvblNxaHMvcHJOeUhI?=
 =?utf-8?B?cDZZaHNHTFI4TmxNSnpOajJveGs1aFBLWFVSbStoZkhyVUZxdUs2TmM3cys1?=
 =?utf-8?B?YUQzYW5FYTBDRUNkb2RVd0dBZU9pOU9INmg4OEZhTitRN3BkWVhHWVVNNG5x?=
 =?utf-8?B?NmNWU3ZVY3hFdmMxKzdDdFoydmdHMm4zeklEVW9XRmdtektqdERvcUNQcjg3?=
 =?utf-8?B?RDJMcnBGTi9NMXlLOG9WSXloZVpKTXdzSVo4U0xxWDZ1Q2JZdkNaeHp4VS9N?=
 =?utf-8?B?UVdvaWhPc0RJV2JLT2s0NW84VU40anlYcWJLaXJORmlyeU53UXlPZXNUYnhT?=
 =?utf-8?B?WmRUb0hjRDMrQm81U1BvY3Z6KzY2aXljSWNxaStWMXorVEFIZGhiTUZOaGox?=
 =?utf-8?B?eDNJdngrT052OTBKS3JnN3JQTCswN0x6Q0lyOHl1RG1vc010ZHFkODJXWUNi?=
 =?utf-8?B?MkFtR1NjQ1RzZ1Ewa1hBUjU3MEE0aEk1L3hCUVgzUnZ0bVVpVHp2SGdqNUdj?=
 =?utf-8?Q?XbtrLdb2H00MeK//z54yax788OZbTxxp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWxDTGNJeU9mWTE1cHlEQUs5V25Ic0FqVTZuc1hGS1hVYlFodHlYK1NrZ28w?=
 =?utf-8?B?MklsMUJZTUtKdWVCTFg5NHd3MmtSQnR4K1N1NTJpdVFPYjVxK1p4d2dIRXov?=
 =?utf-8?B?d1BjaEpMcGtpdzZiWldNam5DNU5LVzhqSG56Nkl1SjNKYnBVWVMwYjVRcnh2?=
 =?utf-8?B?LzdqeTJrTmZ2b20xRGFvUW4rT2MyOHR3M3ZCQmNNaWN4aVZ3dFZxYTVYU2FH?=
 =?utf-8?B?N2lDMTRRODh1b0VUNE5VOUkxNnI0K0x1VnVIL2lKUzdHUllpOEVqeVl4MEhK?=
 =?utf-8?B?aUg5VzZmM3hoQU4zVDNIVDJkQWlHaHArMFR0eU1sTEpwS3NscE5KbGRqcjE1?=
 =?utf-8?B?Vmc1YVVEMUJ5WmI5YjF2bXhhY2RDYkFMMHFyNnBxQlVqN0xOZ0w0Tnc2OVhx?=
 =?utf-8?B?NUN6cnpPMndJTVpweWtTVXRRVGROS2M1UXErNlIxS29GTk00Wm8wSjc0US9G?=
 =?utf-8?B?S1pCdGxyT3RPR1RKbloxdFVrVnJjNzV0ZDI5MzhZdHZkclZDK2ZYTkN3bWdD?=
 =?utf-8?B?TEZzMUx3aWRITld3QlhDbDg4dGZqNUFxMU9IVXlpeGFQeDlnNGxac1JBa0gy?=
 =?utf-8?B?Rng2KzRYc2l1SVh2RXdrNG9LWWVaTjhlMW8rN3I2UktuL0l1R2I3cStGQkJn?=
 =?utf-8?B?Z1lYNy9hL3VmamN6cWh0RFB2aSs2TDJDd0FUbERvUFU2azZGSHREOUlJb1lt?=
 =?utf-8?B?Zmd5anRhcnU3VFZzRTBTWXVzMlZ3T1UzSFhiUkg0S2l2eHNSb1YybEtERHo5?=
 =?utf-8?B?NDIyNVc1c0xrU2w4SlZYQStmVXA0WGdVRHdYS3h3QVNYcXhYQktxTWwwL2Ny?=
 =?utf-8?B?T1I0TzF3d0lOb0RRUUNJMDc1Yk40d2lrRy9pYVVaU0FSUnNFZHBxZ1YyS2xz?=
 =?utf-8?B?UFJWeXpXZU1wK25XcFg4Wks0OFVFRjBnSFJodHFOcUR2ZEJFUHEwaVpoYkRO?=
 =?utf-8?B?akdGcGtrR0o5dzJnbnVoVDloTGJJT0FFUzB0SlFSQncxVEFQWnptUjJkZDlB?=
 =?utf-8?B?cnY0dDhkaUV6VGtzK2FrN3FkZFhlRmtKMzIxdHFELzAwSE1DMDlKTzNHeEpz?=
 =?utf-8?B?WFAyZEhLaFdCY1k4d1U2R1RqYmREYVVrcWp0anpIeEJVL2p2N21JSkJiTndE?=
 =?utf-8?B?dG9ta2xqZitaSCtmcTF0VTlDNkUyK2RlYVp4eEsyZGRVVFdNTjZGV1l1WHln?=
 =?utf-8?B?UXZqbHhzTU5GamhMSHJ2elVjcWlHbGM0VVpJTU5qbVh4Mjc0WmpBaTFPYXgx?=
 =?utf-8?B?eFRmcUcyWnMxOUhXNFhxc3pKTi9BRXRZNkF0NHExSUhSZ1lOYzBXcHFLWGlx?=
 =?utf-8?B?WTdBeWRBOTg4NElWMEJndmVIMC80dDFlQjREYi9FTVBQazc3MWx2TnJuZWJo?=
 =?utf-8?B?MzZSRU13cWJFZ0tOMWQ2dlZscExyRjFXZTA4UXJFZXl6UGIxN2p2dU0xRjE4?=
 =?utf-8?B?TDkvVFc4Znh1UUF3czQwek5JY1VLbTh1d2ZMMVR0S01RZFJjWTJnQ3FtWnNB?=
 =?utf-8?B?bHVqV1RpbExmSWlWdWN6cGR6RWc1T0xudFNyb2hrYTFvYTNPeUJSTEZlaGR0?=
 =?utf-8?B?b0Flb0h1Uy8xVjFPeC9tUC8zekFPZmZKb2ZmLzhGS3JIRDBxUVY2Z2tUNnpF?=
 =?utf-8?B?SS93Y1dFRXRGQndseWdmVFlaamliZWdMSUdoN1JJQjhNcitNN21hMzRvaXBz?=
 =?utf-8?B?V3lzRG5FMXJKenFMMzg0L2NZM2ZZZFZqZWRvSktsWVlwTXBQcGg2M1Q3TlVt?=
 =?utf-8?B?V2k4bmRSSWxhWS82NEFaUzNOY2NzaXdkM0JMYlhQUjNjVjMwNFNrSTJIbll1?=
 =?utf-8?B?eVlrR0J3WXAza2dubnREM2R0Vy95UGI5dDk1Wkg5TEU3bE5EWFZJRWczN2NS?=
 =?utf-8?B?OUQySVdsVGxqTGVrRCt2RVVjNytPeGZCQVN5akM3Nk1pTFlkM2dMVzhsQURT?=
 =?utf-8?B?M3pEZXg0bTZNeEJ3aUUvdDl4Q3JzYkt5bVdxTURuRnl1U3RSbkhOYjhjYUZL?=
 =?utf-8?B?OXFWbDUzSVBZZlhWaktLN1dtQWdBU0ZtTlllMzNQQTJqa0s1OTkwUnVLYzZz?=
 =?utf-8?B?eWh1ci9adlJhRlhxRCtLelBtQTZOMFRYZHhrOE0vTks4aUQ1QmRycjNYaU5v?=
 =?utf-8?B?WE1veHdEQ01yVkVHVzJqQTNieVBVVmdNdENzeTlyMUlQRFROZjRZWjlKczgx?=
 =?utf-8?Q?qSMVkNQ8tI5BBvSLMikvFVwZxwVnLqrF8+iXFqXvdw2P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a700510e-40d6-405e-967e-08de15532ab2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 12:20:07.7782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJpUlkORYbVF2nFfpslHbg+BPpwusO2A52QrqRLA2DKDRv3UzUpwYrTKQoAaxDYK45h43AiQqEN5R5J50NIMTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7711

On Mon Oct 27, 2025 at 1:44 AM JST, Miguel Ojeda wrote:
> On Sun, Oct 26, 2025 at 3:40=E2=80=AFPM Alexandre Courbot <acourbot@nvidi=
a.com> wrote:
>>
>> +/// Infallibly converts a `usize` to `u64`.
>> +///
>> +/// This conversion is always lossless as Linux only supports 32-bit an=
d 64-bit platforms, thus a
>> +/// `usize` is always smaller than or of the same size as a `u64`.
>> +///
>> +/// Prefer this over the `as` keyword to ensure no lossy conversions ar=
e performed.
>> +///
>> +/// This is for use from a `const` context. For non `const` use, prefer=
 the [`FromAs`] and
>> +/// [`IntoAs`] traits.
>> +pub(crate) const fn usize_as_u64(value: usize) -> u64 {
>> +    kernel::static_assert!(size_of::<u64>() >=3D size_of::<usize>());
>> +
>> +    value as u64
>> +}
>
> Since you have the static asserts, this is fine today.
>
> However, we may actually get 128-bit architectures in the
> not-so-distant future -- Matthew suggests to be ready by 2035:
>
>     https://lwn.net/Articles/908026/
>
> So this one in particular may actually not be true "soon" -- we also
> had related discussions about these assumptions, e.g.:
>
>     https://lore.kernel.org/rust-for-linux/CANiq72m9AeqFKHrRniQ5Nr9vPv2Mm=
UMHFTuuj5ydmqo+OYn60A@mail.gmail.com/
>
> So we should consider having the `cfg` already to prevent people from
> assuming it will be always available, and likely a note in its docs,
> i.e. we may introducing trouble to port later on to new architectures.
> Similarly, the docs of the trait may need rewording.
>
> What do you think?

Do you mean adding a `#[cfg(any(CONFIG_32BIT, CONFIG_64BIT))]`? That
sounds like a good idea.

The static asserts will break whenever one of these functions needs to
be protected by more conditional compilation anyway, but for consistency
I agree it would make sense to add it now.

>
> Regarding the `.into_as()` name, it makes sense, but it can be a bit
> surprising when reading out of context... The standalone functions are
> super clear, in comparison. But I am not sure what could be better.
> `into_in_this_arch()` or similar could emphasize that this will only
> work in certain architectures, i.e. it is "an `into()` for this arch"
> rather than the general one.
> That would go well with the idea that you didn't implement it for
> other obvious types, which I guess was to avoid developers using this
> instead of `into()` by mistake, right?

Exactly, the trait implementation is limited to conversions not already
covered by `From` (because if there is a `From` implementation, it is
obviously the preferred way to do it).

The const functions, by contrast, need to cover all safe conversions as
we cannot use `From` in a const context yet.

I am happy to take suggestions for naming (I also think the current name
is not great) - we could also consider dropping the trait altogether,
but I find it more convenient for non-const contexts.

>
> (By the way, please use intra-doc links on the primitives too.)

Thanks, it never occured to me that we could. ^_^;


