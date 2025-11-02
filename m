Return-Path: <linux-kernel+bounces-882069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B05D8C298B0
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 23:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C445188CD56
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 22:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A311923E229;
	Sun,  2 Nov 2025 22:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VwQIp+1Y"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABE88C1F;
	Sun,  2 Nov 2025 22:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762123978; cv=fail; b=egkYOOwDJibnx0iFtsMQ8ujJ7btVW1SIYlNlIGSQxwGRBfhgl7d5r6LODGrS9ci/K+rQEeFBw4Iic5CBI9o3J/Tv+ZJSv7wCRZWUex9dn/+d8xfbq1TRSJdE/XZzFu8WwtFP8iRaWYIzBTdOTUSRfwwt2M5nbXearHAgqCViHHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762123978; c=relaxed/simple;
	bh=SNfQm47dGFmByLhN1npGRe1+qIrnyjLNF4I2ipPHAiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RrqfPuRpeNGvZZCIt12CWmqY/MYmIbrz0dwYJ7Vomnwnzo5iee9jdprR7aKW4ezu3waPPZeaNfYl7wuluNI5QcsgBPSTeTZMU0j7p8a/xuFWDaC01wGQyAnPxk5hnlB5vzaYx8W/0vaeZsyHPuM57PsCHkrXcQ3pRYpQjuWprtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VwQIp+1Y; arc=fail smtp.client-ip=52.101.52.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuPilc1EvDvmk/7crSay1fQmyMsV3VynI2ken4ZWi6DoYuZN+nvrkazwJ9PryY5iPrLLlCP4zG2J4TZrChV10KzbFx4AmENzrY1MoT1714OBOuC6xqUKdhf8ebiFMTUOrpeTFrmZNRDRGPYAN92+S1GyemM8a//NCvHv4MU7+1aPxbVYWO8qr867GOQhuKbhu/ySYEW97n3khY24tsCFY897oBWyLXvQJYvPIKJt74A6iO5Kc0Ic1NfjWQNfiZH3FnszjrLcRS9nAIVDVzhvwfzWMiaqFcVb6MCtGC5gq3VeG+GuotAUxztc5xKF2RkDdUhKxaz4Vo+xkiXuPjrOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcSOHkthajwkYFmKJIz/72kag4xDAtHlpWSutSJ3Rtg=;
 b=r3MfE110GgbpnvvdzTSPBolwms782miCmKR/BkJuaMk9hsJGEUV0ct6DsRUPdMscoLRlCFMaXGHAude0posaaOrOT15oAadmvYtblGy3Ysb465gP4zmxNDPvXWWKHFx73WA+r2OdnFEiJB/KuGEdfBb/CO+jvTiG3XpFudxMQx22TqC0/naXEN3UvyHsUZ09i4OjUwJYwsZnSQO27qbnTogtKp3HQjzAncf60girpDUzp7619hxH3AI9aZEsocMCdZmg5p9JXX5hJYWjSJjozzz5Wl3/8uLMITkUlROQwHAPW96lB0OPsyeWCObTN/xC8xrRJ6WElMTPZaaaVA4P1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcSOHkthajwkYFmKJIz/72kag4xDAtHlpWSutSJ3Rtg=;
 b=VwQIp+1YfKuQAVofBRbdntixknVx7yPh3+zG+kkbRA6tjR0MCtxpWu38W/ZWeR48jO7no2ucsnqHDjOW0ildMe2RWN/xwLBJ04W2xalMHJgDewArH7SU8OV3MZYYOIJSu1gNhaWodexyaS9p3rlCGX64Xol86VjnmkFDMCAZMXs4h3IOvRp/CtH1pDc8u9URrYTbe9SQ9Evi5Y7+rLEjVoPSxRYhFiS/p03q8z+RbCyfVTF4kchBS2Zv+lCRUH0ac62drEcUcKx87Unr6WdxxtMXvTMTSRDd6zzIbPt71hBz1xgKYXpbbJjRq2I56TcXIPOCehGksu6edfXHefDRmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DS0PR12MB8018.namprd12.prod.outlook.com (2603:10b6:8:149::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sun, 2 Nov
 2025 22:52:54 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9275.013; Sun, 2 Nov 2025
 22:52:54 +0000
Date: Sun, 2 Nov 2025 18:52:53 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org,
	bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu,
	linux-kernel@vger.kernel.org, cjia@nvidia.com, smitra@nvidia.com,
	ankita@nvidia.com, aniketa@nvidia.com, kwankhede@nvidia.com,
	targupta@nvidia.com, zhiwang@kernel.org, alwilliamson@nvidia.com,
	acourbot@nvidia.com, joelagnelf@nvidia.com, jhubbard@nvidia.com
Subject: Re: [RFC 1/2] rust: introduce abstractions for fwctl
Message-ID: <20251102225253.GM1235738@nvidia.com>
References: <20251030160315.451841-1-zhiw@nvidia.com>
 <20251030160315.451841-2-zhiw@nvidia.com>
 <DDYDVUFTJFVY.3U00QWH6LOF5D@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDYDVUFTJFVY.3U00QWH6LOF5D@kernel.org>
X-ClientProxiedBy: BLAPR03CA0158.namprd03.prod.outlook.com
 (2603:10b6:208:32f::24) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DS0PR12MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: 18cec1c8-abe2-4982-42f5-08de1a628ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iD4BKbEi0AF+UixfUc0g8MfaBkjCuQfcOoQ1IdKHgUou4rwzr8RA4iPmnsr8?=
 =?us-ascii?Q?qg8q127I0l945AtVVdSDR+Zc6a0wNA70dwe5xDxLwHStmVXOEQrnduSNgfx3?=
 =?us-ascii?Q?TqymMXFil/4iZWvn1BAG7xx4/sXbc6hlk8QD5h8B+Tg99T17Wf5GshQaYiK5?=
 =?us-ascii?Q?IhiQJLytLdh86KVHzGXnhcVd4Dd2eB0vKrkMc4AYf9nnNsLz9DKhvqGKX2CF?=
 =?us-ascii?Q?SQsQoUtmW9kocLD3JFisPaZYsxZ+Zgz4rO/GYNsDaX0VlX74Oc5Ji53jP0a3?=
 =?us-ascii?Q?yi3vRhPpg1TMk+p3uzESsw8Qm4zJfjUw1xy0Wp0G0OuXfLjh9EA0P1tXs5BR?=
 =?us-ascii?Q?LtxgeSx2MzSKOEzHgFs/8OwXOEV8PBvBg9Kj5Tqo8W7AOU0YwxNuziyTC3dX?=
 =?us-ascii?Q?3MdANn+3HwuXx7Ejy1pYE2yTQdKV76Az+JXoJjlWg2CmnRTvSJSvWGqGjWO3?=
 =?us-ascii?Q?mR3Bn+TbNw+6JOk3lsWliGMM3ERHy/EM0rTXKz+/sSrDXqh+OCSffoT/RArr?=
 =?us-ascii?Q?voDo6O9mQZKOBU9wzO9uzTJeeqIX+QyGoqK0bC1XYoEL2tkkfC92zdrEdPwn?=
 =?us-ascii?Q?g1/yk1kEr3LxgeQ8a3HXConhOypEu6LULHq8mM8sFGVFbMQ71NrtthWSZQr5?=
 =?us-ascii?Q?2vBix4ARykU+AcsVeZQvN3IuD85/VPKmum+weYFuFqlnTNHHLXjMdpT8oSN0?=
 =?us-ascii?Q?SWyxwSfr3ApB0Rw2bIX/Ce9j6UobSOmHcF8pI214zzml774BQU/D2tz4K7m+?=
 =?us-ascii?Q?kiVk9jZ5wrAIsEsuV6gseKDc/16Q4nLISAvYuHkRONKUWoIFuQPdzR3u2kvY?=
 =?us-ascii?Q?C1wSyOz2hD4ODnndFr98hEHNPiytnZJjh8bvJS+3GlUwfaXKCKbM0vLjsxQi?=
 =?us-ascii?Q?BooPriND3xBShWktVMQfTDehYVl+Wlgx+YMSV2RXW8Pkx+9BHUysih2lelFm?=
 =?us-ascii?Q?jBfs2pm2o3Dw9tJmgtEhm/ZCkmdDhhglyB8RIkbaL339SAI3usW8KtkktzBK?=
 =?us-ascii?Q?KFDTAxjnJPOKRF+VSI6xM5NT/IysqenFDcHl89eZ2fIcT5m+oAqFo9dpS3aS?=
 =?us-ascii?Q?EpwL+Dx2uhUU41TYgS1kxhj7nDfmucyL3ydAjlt2k0wNZ3RfA9jg7Rwkb9+O?=
 =?us-ascii?Q?DZDorb+DRysLkDO5Yo3Dgk/QRQa5T+49og/ij9OVTRso8YOIw4fu6CW6llmO?=
 =?us-ascii?Q?FXEdNhijFdmBiTevb1VFgBMipF6EAWc7m30P1oWiEu+/Bh3cjJ0p+e3XbCc8?=
 =?us-ascii?Q?LMgsAiqtwTGxVjvhmii0ZFNwIoeQnjAUmDM3W29KR8MP+j7oqb5/QzPAr6gF?=
 =?us-ascii?Q?GobwJBfvqWGpP9WYfItt0WtkWPNvwr5MtFFCR1s0ODsnJtjl/YFaAEOoU6mn?=
 =?us-ascii?Q?28pWj0k19LE7ZlnbDw31N6S+DMmm28SyJhcsqJsdP238YbMfZEVZmExAOITq?=
 =?us-ascii?Q?opDHlZ/6btzwmqcx/Bxu3WEeia07M1uR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yYk8u27MoqfXOKvppItW9OA3cwWupzI8FSrCCQlL/Up/afNoNvNqZcwlR670?=
 =?us-ascii?Q?jFAwcutQijtu9SnVuUfngeis9LvY87wjqT2Tk6MtBN+L4oXl1x+PPtCTfIRI?=
 =?us-ascii?Q?Xu2WJHt7u6FxQC9rzVahd0NbZ5aJ1gfZy1eWMCFQdLS/MXC+ltGqF6xU49JP?=
 =?us-ascii?Q?X8pQi9s/SJjZcE0TqlRegol7SCU6eHDtz8BIo0oCMRWqaZoUmdsxXkJY1uHB?=
 =?us-ascii?Q?Wcwv0l2Iyf3N93i/d7G3zLQd+hODIKoaM3C4NS1U5Qw4W/JqPXzoooL+8xhh?=
 =?us-ascii?Q?YDvMErPSmfxVqYENbbcIf1FQZobnWh+3dspVNCG/PY4Yx/PGOKRQFdYrRwKk?=
 =?us-ascii?Q?xQT7BYU/fRw5Jj57QU9plSpNl+VqwXM09xSLIDMgeUGPtztrOW3VCaRnsNoa?=
 =?us-ascii?Q?3AbrPXGY6fjA/cDRypG/g/ElHBIRR6cunQ4nQQdI6ShYCvror8tylESZnAQ5?=
 =?us-ascii?Q?trD1wj+37ih6Sqmn3+3DUV0w3OdtMgmRFLpgL/h1ko85UnPvvqiGNRsU9EYd?=
 =?us-ascii?Q?Iz9rrKTo6RmSTYD5b0yRQceyFl2WZotA33nBXZQrLOKGu9CFLyki5xwhB4wR?=
 =?us-ascii?Q?ufadrtPftyYyzYiglyCagVCJvfR5gs9Ma2rjMBpgqTuEerknwxLPFSklKYs3?=
 =?us-ascii?Q?dSux6uJFcq/q+Ay4+icSyuot5r8VPeuCOhlKf7b81bCm03OD88fD7wM45BIi?=
 =?us-ascii?Q?zE4uKTabYiloyj0ngKEBju6C8/iTZ0RXK1dfLD89ICNKi7yAcv/Ui00OMk+l?=
 =?us-ascii?Q?zYd7YL6t5JvAHEwMMETMjyscbaRcWnbPH5TdtJQeQQWaxA10DCMGW0HpE/Rs?=
 =?us-ascii?Q?KeWfHhnfMiSo6QX8uTy5G7HUQH2ZSiS3zVlM3x5LPdXDeV3UwG/VsFr2X503?=
 =?us-ascii?Q?6bDoUd13AuYeE0bfrWOM68OKqUWCwmBruvV7LmhotOJqpSYjD9l7FxRLSp2i?=
 =?us-ascii?Q?hEOhhKuUPd3ynm0ctJtd5mzeFKov5Gf86fb9n01B0MYVZUlvxIk4lsM/KjhK?=
 =?us-ascii?Q?wC9PhWMTFpWcdGllGLvBXPYxSiXoqDbty8/VHJwiPXLqEvIh/AKSwxV0+FJV?=
 =?us-ascii?Q?P2tp+55MUxbufLNwD2wr+aFzwcgFUFv04JwBaxRRkNy6YozzUKnAg+PaawCi?=
 =?us-ascii?Q?ajDz56FaSCMeQGKUHqcYPGihvnkeIpaJuEEU4az7pvIhRqKs8w0pjJ7GZjAI?=
 =?us-ascii?Q?Tj9hxeXP1foYaWYH1cOuxbGvC42g/HWFQazJwEreWWi1fPZYWNC2aC3Knb/a?=
 =?us-ascii?Q?yRGU5DxZz73sESD20NZmmwwxJH0DaLYPIay21Vlyuyej24SJCzhVHFG396xP?=
 =?us-ascii?Q?ONzWv1rHIs5EAGWzrkVmetY0QD4d6M1qg2pUK8cSL0aVh7FTrvz9A2up8YMN?=
 =?us-ascii?Q?a3Chw+uM8BSkX5wWY5zqPUBEmalPXDHkmREme5QmHSYcPWoNYZLvq+rcXA2D?=
 =?us-ascii?Q?SB0hLh9AXNkMkj2boAQ9Bu36J0RO2rHjWDlLMGjNvhrDMzphhpewHfxoFNMk?=
 =?us-ascii?Q?ObttQYpKvlWcQzjH0EO/1TqqxJBM0nI645SPcCxloYsA0hD/w+7i/Ff4zfBT?=
 =?us-ascii?Q?TIB7lBpil65b0FNBMQY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18cec1c8-abe2-4982-42f5-08de1a628ee2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2025 22:52:54.1286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M0bSWGOheS+t0FLs6A2OT7fpD7htfDFHbzc2DQ+sgHBkTzlkjPFSPp3Ekm4DSv8C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8018

On Sun, Nov 02, 2025 at 06:26:58PM +0100, Danilo Krummrich wrote:
> Hi Zhi,
> 
> Additional to my other comments, some thoughts about naming.
> 
> On Thu Oct 30, 2025 at 5:03 PM CET, Zhi Wang wrote:
> > +/// Trait implemented by each Rust driver that integrates with the fwctl subsystem.
> > +///
> > +/// Each implementation corresponds to a specific device type and provides
> > +/// the vtable used by the core `fwctl` layer to manage per-FD user contexts
> > +/// and handle RPC requests.
> > +pub trait FwCtlOps: Sized {
> 
> Up to Jason, but I usually recommend to take the Rust module name into account,
> i.e a user of the API can refer to this as fwctl::FwCtlOps.

I don't have any knowledge to have a preference, I trust you to guide
Zhi to whatever is the most common and appropriate thing here..

Thanks,
Jason

