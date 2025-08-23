Return-Path: <linux-kernel+bounces-783042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEDCB328A0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 482507BAA2D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 12:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4823A25E813;
	Sat, 23 Aug 2025 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H+DlLhJO"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F2625D208;
	Sat, 23 Aug 2025 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755953068; cv=fail; b=eKCtATBixTD4aAFWl/JEjCdsNZOAoPrqLZjdebdSI5Qv5UP8cnChtheB+Kv4//wKoMZSw/vprCmbSfWHLB6QRGlWkCtcO/4gi+S+sEmTN2Yw8XV5VtMnitndoegyKjr4FBTfxLFB/MgMvBTjgfd+ZPgF5trUO8WwU+ccZpEVhXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755953068; c=relaxed/simple;
	bh=5IV7uw+Jgd5Vn7EmWbmoLoEXS8Y0ytqfO1iWre7NUMc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=BmXKispTZWlCPx9az027q8H+D/5CRJqnn2KKktEKrRPm8pyof21U6DiuAqTqHY+vFwTF1irbTViuV5XM+znp18BG8czPM+5+Bdz2SdvTkDvlp+ei55AV+eJszGHFBi/gzR8RrtENCItGbNN/7PCAq7nT0jFG/7qKo3mI+KQ1uME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H+DlLhJO; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJn5ZAbwAZELC4aRF9wLKX6yZZojavNxtT6iPBwRVJy+B4shXYB5fS7kp7BVcmyhV6DMT/yUq/roeLogDpe8ImGZFYrrd/n2h38QrXN8lphP1OYXWZyEs/pccYh5EZIFvXnOWGi0tQf25LBs0SyKjaGBMbtg7cX+XK1QIfrgW+emivFZ+2RsQhHzs/V4OC+nz07WBIIUs0tIwnK4BY0hd6j6ZdNk7aSIzQg3XGtgYPN2dSLcazZDZ8/n60ucwT2dbzg7q9dtyZLLUDAmv2JlbFrNkkYnwVB6HKrjvbz/ZVi9fT/Mg8b1ukNp1a5jomDOv5qXXfZqr+EMGp+kB5PZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9P4jCpxfmOQ5zD2HAYz6Y5mJ1XVuzXLu0GMFrnoo+o=;
 b=r+2hqiHcVBKP9nvRJ1ltOErmXvXbo2Aqrg9w8TStRyFB9KIEQnd0Dq4jv55KXtoCWJed/b+UQW7SCrMZk5A86zsjK7N4/RcleH67z1JpoIAvAsicG1O/rxua8ph5tyNaZkIxgejBZk23vzU+LDQNwLTbZdlqeN3Bft9bwBX3xBbrvxBD4IhyNBJn0heG32JF/CeErWceQRxxqgjv3jUy8YaiQICdn9JrMh3PjWKvRlgquNxLuFxWq+4BGJaeVsklqzpMlA3AvD3R45OeoF2E037paYaH1SQ2nZs4gLxlVy9uHMghLfoDJzbc9JO0DSPT+XoEQG05NvC9gv2nGOcsTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9P4jCpxfmOQ5zD2HAYz6Y5mJ1XVuzXLu0GMFrnoo+o=;
 b=H+DlLhJOMi5ObLpUAVvnuYd+kMOyEpNoHyp/TMaA0wMMNLsn391IBMRYVyviALbdXrz+FLv/qB3mHEPX6hGBqLO6hE6HORDgcgpGxsiV0vSpLceHkv6ytgHJ5PLwwV3C+U3aSEh5QU6Hivmg6r0glol7ioZxRB60+TyqZOtJueQok85Y+iVjd4cDLJpITeFo7WAdKZcwnPSBGU0Qeojjj21+FD6V8Hs8EqDDqr5ZvpuijLoPj3Za3ZDDv03B7TJEB9nXmV37x7RnlonUZxJLdy7fooY+e7Oij1jG4NnYNwISF0OotvUqRzzgy7BT9taFkR/h3a9x/Yl+4SOesMfVog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW3PR12MB4476.namprd12.prod.outlook.com (2603:10b6:303:2d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Sat, 23 Aug
 2025 12:44:24 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9052.014; Sat, 23 Aug 2025
 12:44:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 21:44:20 +0900
Message-Id: <DC9TERXGKWSK.IYHN84FXHS6R@nvidia.com>
Cc: <akpm@linux-foundation.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>, <jgg@ziepe.ca>,
 <lyude@redhat.com>, <robin.murphy@arm.com>, <daniel.almeida@collabora.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] rust: scatterlist: Add type-state abstraction
 for sg_table
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250820165431.170195-1-dakr@kernel.org>
 <20250820165431.170195-4-dakr@kernel.org> <aKhYCf6wgSztcdXU@google.com>
 <DC8XLP6C3E5I.10QJQVI4LORSF@kernel.org> <aKhZ9jdiNS2SAZv2@google.com>
 <d30f085a-a031-4208-a15a-e85c7a56347f@kernel.org>
In-Reply-To: <d30f085a-a031-4208-a15a-e85c7a56347f@kernel.org>
X-ClientProxiedBy: TYCP286CA0075.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW3PR12MB4476:EE_
X-MS-Office365-Filtering-Correlation-Id: 60938530-a393-45a8-8cba-08dde242c9dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmVwRmZ2WURFMnBLUnU2eituYjhnQWVFR0RqSENhMXlGdVhpdVEvMTJCZ3lw?=
 =?utf-8?B?K1RTc2xUMmJ6NHlKOWsySnp0WVY4TWYzRUI4RHFqYXRqc2w4Wko3dzFjSml5?=
 =?utf-8?B?T0hrNmpWanlNbGhuS0dGVmIwdk1xWUxaQ0R3c2l0QjdxbnNuREFZbEpTMTND?=
 =?utf-8?B?MnJSanM5N0ptYXJWQktJSkV2T3NqblNsOEFuT00reTNIc1JUd2MyMUxod3Vo?=
 =?utf-8?B?MkE0aUxwR053UG44TGltcEtpUjMwaUhIMFM3Nms5OUcrWVdWWE5jQkdVb3F1?=
 =?utf-8?B?amJTR0U0Q2drQ2wwRVNKVWFKWkZxUGRLZFhMaHQrVkFFUmluWUIzMUdrSi9h?=
 =?utf-8?B?Zm5OblNOMXdOeEtNOURHOVM2RE1PT0JsbEhRc2FaR1NQRXVqNmt4a21UdVZV?=
 =?utf-8?B?L0JnQzRWNi82MU5CYjVEdW1zanh2NXBSMW55VmowUzZuVG1lb05oM0Q2QXYy?=
 =?utf-8?B?UlhsUnd1cE9BUG1wYnlwYXhrSllDbG1EKzA1YUVNWXJPUjdsclNNczBibTBO?=
 =?utf-8?B?QWV2V0F1N2FRMHVCS2RmSHZCU1RodktpUUxHaXVvVVNzVFFQSzR2VmUzV0lS?=
 =?utf-8?B?N1o1ZEdzNzNQSHRLaVRZMkZzNCtnM1JyRWpyeStQWlBScFlubjRNSnQ4M2Er?=
 =?utf-8?B?MlAvdStjNWZLR2VLVnRNYXBUZG4yeDJvdFIvTllLMy9KUXNiUVg4WEtaVDhs?=
 =?utf-8?B?YXVWdktnV0l1SVZ1c1NRQVZiS3ZVbDNPazh1NlIycFdYNjZzY1JxQW8yY2Iy?=
 =?utf-8?B?Y1lBWnAyeGJWVzZ2L2NUM0VUYWZ2bTMzYnQwUmpoNGsyZElyN1MyRGF5STJB?=
 =?utf-8?B?RGtHdFRrRWFMeGFrRG1hOHBmNXNIQ3RHNE9EN1NsUDJyb2ZuWFVOQjRoaldq?=
 =?utf-8?B?ZUlENWdMeVZIUzJ6b2lHY1lUZDJxL01GZVhnTXVoNVFYUXU3TWpPLzVSa2la?=
 =?utf-8?B?aWE0UHRGdWZiTnBpTk1nUGRmR3ZZMmpaQWJTOTRFKzk5dXgxamlLZ3JuTGht?=
 =?utf-8?B?cDhwdUEvODA3RVh4amkwVkdhMklPWGRKTmp5YmV3S1plUVJzM3dMQ0dCaEpx?=
 =?utf-8?B?MHRkVXZTRVdnWCtNSzhGZnYxMHhuV0ZMYVJrZHBSK1NXUW9ybW15Z2FLM2F2?=
 =?utf-8?B?ZUVjaU1kM1U2dnRIMU15MVF6am9jUU5VenhxRFZmNGFzWGp6Zm42b1U2Z1dw?=
 =?utf-8?B?MTR3ZDNpckloOVQwdFdOMnZ3bFpFT1VuZWUwTDl3MmNISHl2TGcwZENBdHR2?=
 =?utf-8?B?eDZvZk9ydUdleDlRMFc1dzdYQlN1K0J5NWRad05rTkdRT0VVSFRxU3VNOUFN?=
 =?utf-8?B?azIzaTdRM2FkcC9Pc0tEY290anFob1dqWlRvYjd3VHlIWE9BeEhaNmlEY2Fi?=
 =?utf-8?B?Q1RoK0kyTE4zTFdDUmZEUWlNVW1xMHlCMFQwNmNpYyszUVhYRktKcEx2TFVp?=
 =?utf-8?B?MklNc0UxODNnVGlIVTljWGttUGxnaWxPc3JvYmE5cndTRllmZTg0dG92V1lT?=
 =?utf-8?B?d2dhbWRCL09LRERSdnRpbUlmYm9TUGdlL1N5TEdaN1E5VUhIOXphQ2ppdnln?=
 =?utf-8?B?V1JaT2JNaFBhTmFnbXR0SGtrd3JaYnVSZDl4a1ptMUZOc2laYXVmVnVPUW54?=
 =?utf-8?B?bFR5d3JTby9jTVoxUjZ0VzJFK0dQanY1Tk5neWdtYVlJVG5QWFRyZFpmN25Y?=
 =?utf-8?B?SFdxa0VDWWEySllUQWQ3cTkvSVpRbHhYb2RSMC9wZ0ltVWVEZ3pVbjJVSStQ?=
 =?utf-8?B?dWluZTZOQjBCSDZLSEZJTE02cVA0aVZtaWF6cUZqREtBcWJTMnQ1QUoxNEFK?=
 =?utf-8?B?dUdKTitNNENjQXBkQUFVbXROeUN1ZlJCUmZjaEdxMm5BbnU5WFJKdlJYYXND?=
 =?utf-8?B?QVl2WHhVN0g1NzRnb0RrZzI0ZjVBZGVlUnhrcFFtNTlqclE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amF1bTgrRjFwclJwVmJhZ1pJOHhRV0N6a1BVcytsd0FjN1VOUW5DMmJ0UEQy?=
 =?utf-8?B?UnR6L2xoRk1FeTNrMjQzNVd1TXN3dTJaTmRJUEtPeTZlZGhLVTQxV2ZjN0Jq?=
 =?utf-8?B?VWpTTENKZk81eFhwZHBFbTFvUStRdmFoRFhEODkvUDlHdlFucWowRXJ6OHRw?=
 =?utf-8?B?UTJmR1ZGYkpoWHJSTkI3MlFaVU9zQld4Y21CMlppOEpJS25GMVdnRjlFRG9E?=
 =?utf-8?B?VjJsMDNLbDZUb2hDemZYbUJHb2RnKzdHQ0p0eWMwRENmdFZRWFJxb3JqWGJs?=
 =?utf-8?B?d0VheGdsRVFRRDE3cGdpdCsxSVBhT21WaEFSTE95U29URWRMNjJmZVJXR2gx?=
 =?utf-8?B?dEx1TzZSa0ZHUWlJK2JlWDJpL1A5dkFiWXJpYzNkKzNsL0NRM3hvQnJJWWdK?=
 =?utf-8?B?ajJLMnEyUkpaZjBiYWlEZzU0NmZsMzBWTmFrQnhzbmVvcTdiN0Z4ekxjVWs5?=
 =?utf-8?B?M1pBTTZNY0RsY243MUVDRytoSUpzejZPb3hxK2xFeGdqQkRHaGVoMkQ1cDA3?=
 =?utf-8?B?LzlpNUxOTnBHRVo5VktrbTBYT2I3cGdMY2ExMGVGUkt3bkhvbTBvbDRkVjRn?=
 =?utf-8?B?OW4vUHRJNW9TWUh5ZTVsbmFWa3RIOTJHWHhOTFNaR1RTMWkrZWlaaXI2SGc0?=
 =?utf-8?B?bnY2ZlRycDlvME9Cb2FzRStteVQ0V01BVlZMWjdiTDZtek0xRDhQK01MdVNx?=
 =?utf-8?B?SUZQZUNnU0kzL1pQWk5FaXJtVFh5aTVIKzFyZHd1SkNWdklLOXptTUxZTkp3?=
 =?utf-8?B?cG5VblhKRTA0UW1FbHBMZjB2Wlo4VFlnNFpCQ2o4VlpsYnE4emNJVjU2YS9Y?=
 =?utf-8?B?K2E4Q3hBTXRkZzB3VWNudE1nT2N2WXFsZGtCR0lwUy9naFBnUjB5Y0lwZmFM?=
 =?utf-8?B?VzdPaWJyL0NuNWxrMTN2VHhMaVBnN2FDQ0dDOEU0V3B3dXF6dk9YeXp5Ymth?=
 =?utf-8?B?MXlmaHcrRkxZNCs4SndJN0RqZVc5L3dFcnk4VHhudndqbWZCUWZPVDd5REt1?=
 =?utf-8?B?OWJxWEZmcmxNNlJFd3NEcGVqcFNvdG4zTVpRMGpYR2VzWVZ6SVdXMmRENE5F?=
 =?utf-8?B?ZU91SDFxZktQVk01VS92NDA4OWYzem9OZkhTWWJId3p4VEZvWGZlQkFpS21N?=
 =?utf-8?B?cUpnZkxxRFoybExzRkllK0J4TytjUGtHMzVNYmJEL2hPYjdSdkIyK3laNytO?=
 =?utf-8?B?ZmxQWWxIVCtqRHRRSG1RaDREcnVSUWlZNW1hL0dqc0JFa25OZzlTa3hFeXBF?=
 =?utf-8?B?SnpDdUVTUHk5R2k1Z1lqQllNblA4ckx5MlJVN0NvdWl3aHZBYTk1ZEVLOXNE?=
 =?utf-8?B?U3ZSamVNQVlyMGpuNVdVa1hpVnJ0MFZJQkhHNFVVd1UwRnpHVVJzMEljZUxu?=
 =?utf-8?B?TTNKaksxc1JFMHNjcG9EN1l3dHpqeGk3VndWSDlsMG1LUWFLQWJ0Ukx6eG15?=
 =?utf-8?B?bW9qM25nekd6NllFZlEyeXRHT0JjWi9Tem9sYncvWk5lRnZSZlZxejJncktF?=
 =?utf-8?B?MGJGRVk2c0JvSzU1Tzg2cWNVcmpPUzVPUUpIN0k5dzljeldPeVVMRDRHRk5r?=
 =?utf-8?B?MGhCVlh3YmROUHBjMW8vUDFEZ2dmOHc5bkVZQThFcWErelQ4a1dXNGJpK2dK?=
 =?utf-8?B?bkI0dmJUa0UrS1JMYXI4azl4MmNRcVpRWEExNXdBM1Z3cnVhc25wTWF1TXov?=
 =?utf-8?B?ZHo3RTFqUnVFclkxRjJXeEtXZ1dvbjY4d29SVk5Yc3RsN21Gb0dWanNnUVFH?=
 =?utf-8?B?UHJMdjFIZTFJSzRXUjFqRDZSUFNBWDNuZVlicVhWQjd0M1d1NHYvaVhUcnhH?=
 =?utf-8?B?dkNCZnNVMmhlNjI0bVZabEVMeGx5KzFDbThpNzFRRk5oRTlsQVBRK1RNY0Nl?=
 =?utf-8?B?N0VzWXNQZFIyUzZ5Z254UkFZdURQcWErREswa0R4bkZ5M2Y4QXd3R1QzL2M0?=
 =?utf-8?B?S2ZCUUVpQmZpdnF4VGt5a1pZT0J1eGQrNkhVSTc1SzJ5UVV1dWZkRGExVXhw?=
 =?utf-8?B?bmwyRHVuWXVIakVnVnlCa2FTKzhteGltRXB1dkpqVTE5dHo1L2RzcXVBVEN0?=
 =?utf-8?B?dGw2M0NFbEtoVE5WWWFnSUY2TnRFUU1za0FzdVdhOFYrSmVheWcwd1pyeFlM?=
 =?utf-8?B?L0pxeXVreDF2OGs1dzA3N1VrdlpuanAyb0RDcmM2QXg0bnBKM0lNbWtWSjFm?=
 =?utf-8?Q?/3FhW0k5+eStfCOfnwFhbqpGBdjpJlybwkMRXcbJQRLs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60938530-a393-45a8-8cba-08dde242c9dc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 12:44:24.0658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzPv8dFCw/kvlPVJFyOSpW5uuLNblgY3laAUTXaOJ5WSbIW5oWYniTjo4nwqGbzULJGJnXnGW7JLJFHmYx6RvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4476

On Fri Aug 22, 2025 at 8:54 PM JST, Danilo Krummrich wrote:
> On 8/22/25 1:52 PM, Alice Ryhl wrote:
>> On Fri, Aug 22, 2025 at 01:48:47PM +0200, Danilo Krummrich wrote:
>>> On Fri Aug 22, 2025 at 1:44 PM CEST, Alice Ryhl wrote:
>>>>> +impl<P> Owned<P>
>>>>> +where
>>>>> +    for<'a> P: page::AsPageIter<Iter<'a> =3D VmallocPageIter<'a>> + =
'static,
>>>>> +{
>>>>> +    fn new(
>>>>> +        dev: &Device<Bound>,
>>>>> +        mut pages: P,
>>>>> +        dir: dma::DataDirection,
>>>>> +        flags: alloc::Flags,
>>>>> +    ) -> Result<impl PinInit<Self, Error> + '_> {
>>>>> +        let page_iter =3D pages.page_iter();
>>>>> +        let size =3D page_iter.size();
>>>>
>>>> Variable naming here is confusing. There's another variable called siz=
e
>>>> in an inner scope, and then afterwards in RawSGTable you use *this* si=
ze
>>>> variable again.
>>>
>>> I can change the size in the assignment block of max_segment to max_siz=
e, or do
>>> you have other suggestions?
>>=20
>> How about just this?
>>=20
>> let max_segment =3D {
>>      // SAFETY: `dev.as_raw()` is a valid pointer to a `struct device`.
>>      let max_segment =3D unsafe { bindings::dma_max_mapping_size(dev.as_=
raw()) };
>>      if max_segment =3D=3D 0 {
>>          u32::MAX
>>      } else {
>>          u32::try_from(max_segment).unwrap_or(u32::MAX)
>>      }
>> };
>
> Looks good, thanks!

Would this also work? It's a bit shorter.

// SAFETY: `dev.as_raw()` is a valid pointer to a `struct device`.
let max_segment =3D match unsafe { bindings::dma_max_mapping_size(dev.as_ra=
w()) } {
    0 =3D> u32::MAX,
    max_segment =3D> u32::try_from(max_segment).unwrap_or(u32::MAX),
};


