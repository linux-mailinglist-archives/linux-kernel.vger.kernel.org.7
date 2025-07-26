Return-Path: <linux-kernel+bounces-746790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2C0B12B20
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 17:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75D754672F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 15:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66D3285072;
	Sat, 26 Jul 2025 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="bfpmKY9q"
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020097.outbound.protection.outlook.com [52.101.196.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515082E36F6;
	Sat, 26 Jul 2025 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753544741; cv=fail; b=t1COSaE0Fw/wFabWui/hi3iHBz3WdqdNbwzUGz/C00u+DY17h9QtoZRGMmPZ5Vvxo6wBF9n04Fb1wdPE/YzM45ondYCLqKcqhXeFuVxpr0Z+j0ZcWSZ0pEN+IM++/a93yt0GJBwQVG/HJ/PxdU56O65KqG1bl0lVY3E/e9p90Vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753544741; c=relaxed/simple;
	bh=87Svxsme++PiGpT94YbPPzxjP/08P+6qnvI1QcdpNT8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LMlcRieJ3zAPrFoENHqLGHhzMbz1YrD+aNHI5Fne8LMCSWwJ8+5WN1TsNXk2DKfGBHq1aqtSDVYBMnxnKXXmQB5R7Mq5Tq77x7J10mt1QlqGx4oTBfog4fKgOKGV6UC/ulTMZqxuAQXMna9ASdRwB5gGwR5KEaVe7qjR/Hbbw/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=bfpmKY9q; arc=fail smtp.client-ip=52.101.196.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJvRgJhYGzleeFL17xEdY/eatW4xVwsNAloVathmVArn6Ct3HJK9BjrIrgT0b87jMveiGIa5PJyuA6pxcSC7dxiZ9LFQRCPyrQQ5ZEHX4zM4IBaMWTSx09bCNN92n3/pAxnQbYrvMbUwWJDuRtv79xHnRIDNvUTisW93MMefdvrGJbYASurE1unF8nC4M9x4ZgEFlq9ivy/8PKwXtCnzMf9yQDpd5iRTkH+CIP3RMS1NBxs221x2fygvpiah5gWrMa9t3U+zsyVBN2CqiHqOfXuiMOA/zuL/79j08c75i17M7faCIoedZUWHdmgtOAvfm+YuU+qZsZg3pQwlcmLDOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDEGCCCCBJE2s8yP2zc6L/zS4GI1kcCtV6PZudRt3FI=;
 b=MOdx6+tyOFqKneclLgR2OUJXv2dLzyDV7JaVzxYdMGLA2W/hxTw8qOv3ku3tovvd5CAd+CgfGsAHQCFtJNoIRLUGhgtjfKZghaYqRnCu3Pr7nZVfAzgRekaDyQP95F/bxC6pQ2pnB+tApn2ra+DoO+Dk1Fdo1lkSmcldUMZ4VVIXJ1kgqIvPXjj0SjBmZu5jBp1lSRk22yz0dIpxPDn3feuhK4jtsqvS2+nLe+RFH0ZVXJP2o3u7uSCZA0Oe+zeTdiidGnKTvip8wVP4c5ijHQmcFM5xbtmZvbZjYFm7OiuHSlqXXZKBhvsj7/tCca6U44+bkKGsuJoqcWdKLfVavA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDEGCCCCBJE2s8yP2zc6L/zS4GI1kcCtV6PZudRt3FI=;
 b=bfpmKY9qQh390XdtBkhkoNN9ryR9EpQ7N4QO77ToCVneVlPkjIjNrk9lxdaslx1g1rcuvbJU1jeymn8aOSDkukdcJqW7F0cWW7yYwfYAttHwaQzJQf9FvvS347PnI3wuTZL0biUDskY4vu4kKqXSlLpdZmyjv9j6uZiCFaVdqgw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO3P265MB2041.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Sat, 26 Jul
 2025 15:45:34 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.8964.024; Sat, 26 Jul 2025
 15:45:33 +0000
Date: Sat, 26 Jul 2025 16:45:27 +0100
From: Gary Guo <gary@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Miguel Ojeda <ojeda@kernel.org>, Andrew Ballance
 <andrewjballance@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, "
 =?UTF-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross
 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
 rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] rust: maple_tree: add MapleTree
Message-ID: <20250726164527.6133cff6.gary@garyguo.net>
In-Reply-To: <20250726-maple-tree-v1-1-27a3da7cb8e5@google.com>
References: <20250726-maple-tree-v1-0-27a3da7cb8e5@google.com>
	<20250726-maple-tree-v1-1-27a3da7cb8e5@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::6) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO3P265MB2041:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b60c32-0174-4f3b-ef86-08ddcc5b752b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KG3QzarCO625MRobT9ZMXNVa5slW9DH9Fgr/W/LH+J8uMwwN0Tqm51/yA5cg?=
 =?us-ascii?Q?MLsNFwzvRmPxPjRIEwoBYYckgqcQ0D2gZ9HLpjwAe1o2QwZoZvkEJujStFrE?=
 =?us-ascii?Q?qMGyLeCW8Ev4ORHhyNHDJ8j9SBAEP7QKvzZ6OMPPRmoHuUJNlMJF91Ig4slq?=
 =?us-ascii?Q?A0Fs04jY+wpwh+STKD7w3EMwh8u3UV5dE6rthjPMApGxMmsnJn3IGZ8bCkPG?=
 =?us-ascii?Q?TY32AYI7b4qfq7vtFzaFW5XofEbxKVWMKBUF+KqhZ2NZOrAjXG3ugSdtnuB0?=
 =?us-ascii?Q?upIRknCK5BFZfMrVwlM2hcravmGkPtzWEhw+de7o/bod1ySnY83balefCcib?=
 =?us-ascii?Q?Sb5IdlmlSfbPA4qqotFsSMMeJY/cKEUw3snFxct48Btt08lKVoF6NJs45pYf?=
 =?us-ascii?Q?vMlj3Pt/31SeKEIErTA4hDbPqPge4xRbg2OeLRfnd8zEjQrGjc4Kn9Ny4c/Y?=
 =?us-ascii?Q?U3FZFZkcYZ3mui/UvbK/g9tJrU7pkhFv1eDl+fyJWV4t3TTdWZCSG1O5U0xn?=
 =?us-ascii?Q?GUMjKma75OsHcziN1InY6TISvu3vHKbZ1hHQJJz12YF0/ulaitdqjMsejtwp?=
 =?us-ascii?Q?USyeerFUESQaYsQKsXBWhS7PT+1Fjae/+3TqYxsNhOfhNT9TaFZjPZURkxfM?=
 =?us-ascii?Q?lFkkS65vIBO8YTvh1ecSmmRy64hkL5jNR0pHCbqcXKJ9M5EywYz7Kw1LoDdM?=
 =?us-ascii?Q?UbX5eMlqwYCJdpRFeerpPL6Chhc3BT4JupUrjpipWIxtZWH1fYKgomg3qBgT?=
 =?us-ascii?Q?WWDZoQhpbWgFeQJPfi4vfwroDL8J9uFwIfDqFW1B3J7CDgbZBGiORbfGY1Ah?=
 =?us-ascii?Q?hAqA2R00bvCBdXsEHOEcBsHE8QnmumU8qj9Cv8/qNHjo6QS6S7PwTW5FYnea?=
 =?us-ascii?Q?D5sgvRGcrWyOQZxqwUwPnstHPHbHunLq6PI+o5VCUqxu5I4G97DkF9vKG/Hs?=
 =?us-ascii?Q?70yMxFJS79r2rB7OmEXn3CpgAyTU5GpO66mwH3oK1IikwwSQ+7UrKUmysMAf?=
 =?us-ascii?Q?O+m+2SeYlkfKAadX/5LHZ64h6mxbi6x211i7g5REiqQekdtcqJVt4Kfc4rWY?=
 =?us-ascii?Q?Tx3GlF3ORxAb1YlZILDm56vc2IvQ+hJyu4f7TPf/fWmEc2+9WinzyRpAfH2X?=
 =?us-ascii?Q?pFCXVdqI6X6DrqV6fAH6jxm7gqakUpvGAhoY2henjnqnYucbEm/d3I29m+k8?=
 =?us-ascii?Q?P+2raax+K2y/hpT+SMetA/ZoBjaf/LCK1UF+TS9pEAEkBm1y/R3ozJxyWeBW?=
 =?us-ascii?Q?7iTaxmZPdeSm2Dnqlqcib+8zkP6i94gUF0vahp5/L4TN+K9s4AxxrYNen1Mh?=
 =?us-ascii?Q?abp600QaM2+XdRBdQw/aXEHXZv1WJTU9jJWd8sNEJRXdh1mP8XlJDdLxxpBH?=
 =?us-ascii?Q?uSzk3zY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ezdphamgcmLYaCCjp1Dz1P22N8XuzE0egHsqznapSsKVJerWHVWJG7G65fRF?=
 =?us-ascii?Q?gB6qBThxgnzfm1if43DYv9rasYOgU38DwyJsEaCawIGLweq6/w7YTqgkXeuz?=
 =?us-ascii?Q?tlch2Luf3Bfye2AYvJNMUumy25LhqTHsgIfzxHeyzRlASTxctgggHwuoRD2t?=
 =?us-ascii?Q?PyjU+f6VzX2oMeiDzxGnTqqufkOh46fOdlnh2VCzM7I04+xfgrPdOD/q7Q4K?=
 =?us-ascii?Q?3J4fk7I/A7rSOkQe3PLLyWRIJTqAQ/P2Ag8nAUGstXidc3V6eNigzUx5YnFd?=
 =?us-ascii?Q?NVnr31JjaU1IBHsDTqDr6wG7pphpIUOwj8lLCPhbusB3zIPgl2z2GdhxlmAs?=
 =?us-ascii?Q?aXkob/9rupx+ZJVjgYPv0DnpGOqc0IHZOwnzSHvWdwTsv8ispNx4tkVF+B4S?=
 =?us-ascii?Q?As8OA6DS+zCxOTECIANidNGAUWtGbEytWO8QJ3ukojCjt6OViFgjXCXXrFbS?=
 =?us-ascii?Q?3tGUKXqoccMQ3sqXWit/xG+qyS3HgyILK2kzR25h/fNPP4xQdSp6Mt+Rw6ip?=
 =?us-ascii?Q?UHicWE/wPfYZFwTYfnLol55xpDSzn7WUb2Y2FmW6lhXRVl/PHr1MeJRyNG/+?=
 =?us-ascii?Q?kdjYbrxG2dtOu3VqOzZbHljNQwM6wUPQH10NNwv4JaIEuOVAhC6pw1i11BIR?=
 =?us-ascii?Q?juR2wkAE1L0FsSFbwVWW+5oaL/ReQ/5sTeX8Ltiwod7Vk4/Qc8Yw9r51IhLh?=
 =?us-ascii?Q?VVAWNMG3UjoQ4POAZ7Zt4v+eMAlofQineMS4Opj7XH1iotY1Rx3QqzaZCUvs?=
 =?us-ascii?Q?bFooig7tI4sL6nyqAuMdG31sJJ9V0ZYsMtmz+o65sSpciVSOid0UjVRIvpVc?=
 =?us-ascii?Q?MZzRV7Izxmf0SvGcqTZCsffJz3ve4kDi2GyAlikavGTpuu9C9MFNVTCQd+QT?=
 =?us-ascii?Q?Sx44EKopeEJdk8+Yb/gEBtsmmpWFHst6KX4GwuFKp9P7hyqn0miZpkBWkb6+?=
 =?us-ascii?Q?owVPd4hRciZn4IwcmRU/jxajkEJwqQpOimRZe9Alw9L0U3ORL2Ol0f68FmtM?=
 =?us-ascii?Q?g8WBc9GSXkWVG1Vs3HUYbyx55T/7r9sr7l7G/GTpWSC0JAb6DKG9hyuhiZKD?=
 =?us-ascii?Q?0Q5pryQYtHDGQSMNqPOeHxcjoPpx8mMlHKG2ZuKtKknw94A8+DzyX3d1ETba?=
 =?us-ascii?Q?PDdVBt/s7+kYtRiNjcdDqaGnLpa8s04YLNqO9pf/2vtK4ou92XVfHB2dKywy?=
 =?us-ascii?Q?23wF81GPzw+aO4E+5/WE8TPZYz3RpFNWLkRJ/SoxqFuFUS4Oqc4xEgX8XhOt?=
 =?us-ascii?Q?0R8+UmLAy+SCuONUw9+C0sEm8P+BQA71kXd0D6KSTkc34+TyZ1f7dwRhbMzj?=
 =?us-ascii?Q?T2Quz3R0MBrbiyjnvIjr1RHq0luYdq0cXbeKsxZET6yvpPss4UCDEZiQv/Sk?=
 =?us-ascii?Q?YmT9k7N1b/AEokLq79dIbfnHbYLbppmiVYI18nlNU4AvW7tsNjmP5PUYR4wd?=
 =?us-ascii?Q?m4gZJWuLFhW/0mJHSoe93e2JceiT+rRTCFR1LNmoy9BHUhL7mYu9F/3UycMP?=
 =?us-ascii?Q?uLEJjItJ4FQ+59EcdvCQizVMAlV8nQa1Gx9Q0+SAqr/XVJEaZ1OpCkn9bn2U?=
 =?us-ascii?Q?i+4yqOuOhid8FZyCteNK+6q6+f0P+V997rkOpZv4SXTQjaeRlaM3wFqyP6tj?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b60c32-0174-4f3b-ef86-08ddcc5b752b
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2025 15:45:33.8358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xPhVuMR1SIN7y2P6hlKNpnoJle7/oCpSKeUR8yTAhZqdCN4EWJzrO8ZBLyI8dru64gHkqbeavK2njdXLms4N3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB2041

On Sat, 26 Jul 2025 13:23:22 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> The maple tree will be used in the Tyr driver to allocate and keep track
> of GPU allocations created internally (i.e. not by userspace). It will
> likely also be used in the Nova driver eventually.
> 
> This adds the simplest methods for additional and removal that do not
> require any special care with respect to concurrency.
> 
> This implementation is based on the RFC by Andrew but with significant
> changes to simplify the implementation.
> 
> Co-developed-by: Andrew Ballance <andrewjballance@gmail.com>
> Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Overall looks good to me, some nits and thoughts about the error type
below.

Best,
GAry

> ---
>  MAINTAINERS               |   2 +
>  rust/helpers/helpers.c    |   1 +
>  rust/helpers/maple_tree.c |  14 +++
>  rust/kernel/lib.rs        |   1 +
>  rust/kernel/maple_tree.rs | 286 ++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 304 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dd810da5261b5d664ef9750f66ec022412e8014b..b7e7308ce07c050239c14c4f3a0fd89bdd8e8796 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15956,7 +15956,9 @@ L:	rust-for-linux@vger.kernel.org
>  S:	Maintained
>  W:	http://www.linux-mm.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> +F:	rust/helpers/maple_tree.c
>  F:	rust/helpers/mm.c
> +F:	rust/kernel/maple_tree.rs
>  F:	rust/kernel/mm.rs
>  F:	rust/kernel/mm/
>  
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 0683fffdbde25b89d285e3b0d8e6d8f7f5fd7474..ed7888a2661ad91f0fb78023311b3a266d30615c 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -26,6 +26,7 @@
>  #include "io.c"
>  #include "jump_label.c"
>  #include "kunit.c"
> +#include "maple_tree.c"
>  #include "mm.c"
>  #include "mutex.c"
>  #include "page.c"
> diff --git a/rust/helpers/maple_tree.c b/rust/helpers/maple_tree.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..119665846e8e8b018f8dc791a22fe20ace8e9c2c
> --- /dev/null
> +++ b/rust/helpers/maple_tree.c
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/maple_tree.h>
> +
> +void rust_helper_mt_init_flags(struct maple_tree *mt, unsigned int flags)
> +{
> +	mt_init_flags(mt, flags);
> +}
> +
> +struct ma_state rust_helper_MA_STATE(struct maple_tree *mt, unsigned long start, unsigned long end)
> +{
> +	MA_STATE(mas, mt, start, end);
> +	return mas;
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 11a6461e98daab597e1eb2b513c5123686a1bb73..6cc152090a2f1986781800897ad48947c2d02e40 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -88,6 +88,7 @@
>  #[cfg(CONFIG_KUNIT)]
>  pub mod kunit;
>  pub mod list;
> +pub mod maple_tree;
>  pub mod miscdevice;
>  pub mod mm;
>  #[cfg(CONFIG_NET)]
> diff --git a/rust/kernel/maple_tree.rs b/rust/kernel/maple_tree.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..0f26c173eedc7c79bb8e2b56fe85e8a266b3ae0c
> --- /dev/null
> +++ b/rust/kernel/maple_tree.rs
> @@ -0,0 +1,286 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Maple trees.
> +//!
> +//! C header: [`include/linux/maple_tree.h`](srctree/include/linux/maple_tree.h)
> +//!
> +//! Reference: <https://docs.kernel.org/core-api/maple_tree.html>
> +
> +use core::{
> +    marker::PhantomData,
> +    ops::{Bound, RangeBounds},
> +};
> +
> +use kernel::{
> +    alloc::Flags,
> +    error::code::{EEXIST, ENOMEM},
> +    error::to_result,
> +    prelude::*,
> +    types::{ForeignOwnable, Opaque},
> +};
> +
> +/// A maple tree optimized for storing non-overlapping ranges.
> +///
> +/// # Invariants
> +///
> +/// Each range in the maple tree owns an instance of `T`.
> +#[pin_data(PinnedDrop)]
> +#[repr(transparent)]
> +pub struct MapleTree<T: ForeignOwnable> {
> +    #[pin]
> +    tree: Opaque<bindings::maple_tree>,
> +    _p: PhantomData<T>,
> +}
> +
> +#[inline]
> +fn to_maple_range(range: impl RangeBounds<usize>) -> Option<(usize, usize)> {
> +    let first = match range.start_bound() {
> +        Bound::Included(start) => *start,
> +        Bound::Excluded(start) => start.checked_add(1)?,
> +        Bound::Unbounded => 0,
> +    };
> +
> +    let last = match range.end_bound() {
> +        Bound::Included(end) => *end,
> +        Bound::Excluded(end) => end.checked_sub(1)?,
> +        Bound::Unbounded => usize::MAX,
> +    };
> +
> +    if last < first {
> +        return None;
> +    }
> +
> +    Some((first, last))
> +}
> +
> +impl<T: ForeignOwnable> MapleTree<T> {
> +    /// Create a new maple tree.
> +    ///
> +    /// The tree will use the regular implementation with a higher branching factor.
> +    #[inline]
> +    pub fn new() -> impl PinInit<Self> {
> +        pin_init!(MapleTree {
> +            // SAFETY: This initializes a maple tree into a pinned slot. The maple tree will be
> +            // destroyed in Drop before the memory location becomes invalid.
> +            tree <- Opaque::ffi_init(|slot| unsafe { bindings::mt_init_flags(slot, 0) }),
> +            _p: PhantomData,
> +        })
> +    }
> +
> +    /// Insert the value at the given index.
> +    ///
> +    /// If the maple tree already contains a range using the given index, then this call will fail.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::maple_tree::{MapleTree, InsertErrorKind};
> +    ///
> +    /// let tree = KBox::pin_init(MapleTree::<KBox<i32>>::new(), GFP_KERNEL)?;
> +    ///
> +    /// let ten = KBox::new(10, GFP_KERNEL)?;
> +    /// let twenty = KBox::new(20, GFP_KERNEL)?;
> +    /// let the_answer = KBox::new(42, GFP_KERNEL)?;
> +    ///
> +    /// // These calls will succeed.
> +    /// tree.insert(100, ten, GFP_KERNEL)?;
> +    /// tree.insert(101, twenty, GFP_KERNEL)?;
> +    ///
> +    /// // This will fail because the index is already in use.
> +    /// assert_eq!(
> +    ///     tree.insert(100, the_answer, GFP_KERNEL).unwrap_err().cause,
> +    ///     InsertErrorKind::Occupied,
> +    /// );
> +    /// # Ok::<_, Error>(())
> +    /// ```
> +    #[inline]
> +    pub fn insert(&self, index: usize, value: T, gfp: Flags) -> Result<(), InsertError<T>> {
> +        self.insert_range(index..=index, value, gfp)
> +    }
> +
> +    /// Insert a value to the specified range, failing on overlap.
> +    ///
> +    /// This accepts the usual types of Rust ranges using the `..` and `..=` syntax for exclusive
> +    /// and inclusive ranges respectively. The range must not be empty, and must not overlap with
> +    /// any existing range.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::maple_tree::{MapleTree, InsertErrorKind};
> +    ///
> +    /// let tree = KBox::pin_init(MapleTree::<KBox<i32>>::new(), GFP_KERNEL)?;
> +    ///
> +    /// let ten = KBox::new(10, GFP_KERNEL)?;
> +    /// let twenty = KBox::new(20, GFP_KERNEL)?;
> +    /// let the_answer = KBox::new(42, GFP_KERNEL)?;
> +    /// let hundred = KBox::new(100, GFP_KERNEL)?;
> +    ///
> +    /// // Insert the value 10 at the indices 100 to 499.
> +    /// tree.insert_range(100..500, ten, GFP_KERNEL)?;
> +    ///
> +    /// // Insert the value 20 at the indices 500 to 1000.
> +    /// tree.insert_range(500..=1000, twenty, GFP_KERNEL)?;
> +    ///
> +    /// // This will fail due to overlap with the previous range on index 1000.
> +    /// assert_eq!(
> +    ///     tree.insert_range(1000..1200, the_answer, GFP_KERNEL).unwrap_err().cause,
> +    ///     InsertErrorKind::Occupied,
> +    /// );
> +    ///
> +    /// // When using .. to specify the range, you must be careful to ensure that the range is
> +    /// // non-empty.
> +    /// assert_eq!(
> +    ///     tree.insert_range(72..72, hundred, GFP_KERNEL).unwrap_err().cause,
> +    ///     InsertErrorKind::InvalidRequest,
> +    /// );
> +    /// # Ok::<_, Error>(())
> +    /// ```
> +    pub fn insert_range<R>(&self, range: R, value: T, gfp: Flags) -> Result<(), InsertError<T>>
> +    where
> +        R: RangeBounds<usize>,
> +    {
> +        let Some((first, last)) = to_maple_range(range) else {
> +            return Err(InsertError {
> +                value,
> +                cause: InsertErrorKind::InvalidRequest,
> +            });
> +        };
> +
> +        let ptr = T::into_foreign(value);
> +
> +        // SAFETY: The tree is valid, and we are passing a pointer to an owned instance of `T`.
> +        let res = to_result(unsafe {
> +            bindings::mtree_insert_range(self.tree.get(), first, last, ptr, gfp.as_raw())
> +        });
> +
> +        if let Err(err) = res {
> +            // SAFETY: As `mtree_insert_range` failed, it is safe to take back ownership.
> +            let value = unsafe { T::from_foreign(ptr) };
> +
> +            let cause = if err == ENOMEM {
> +                InsertErrorKind::Nomem
> +            } else if err == EEXIST {
> +                InsertErrorKind::Occupied
> +            } else {
> +                InsertErrorKind::InvalidRequest
> +            };
> +            Err(InsertError { value, cause })
> +        } else {
> +            Ok(())
> +        }
> +    }
> +
> +    /// Erase the range containing the given index.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::maple_tree::{MapleTree, InsertErrorKind};
> +    ///
> +    /// let tree = KBox::pin_init(MapleTree::<KBox<i32>>::new(), GFP_KERNEL)?;
> +    ///
> +    /// let ten = KBox::new(10, GFP_KERNEL)?;
> +    /// let twenty = KBox::new(20, GFP_KERNEL)?;
> +    ///
> +    /// tree.insert_range(100..500, ten, GFP_KERNEL)?;
> +    /// tree.insert(67, twenty, GFP_KERNEL)?;
> +    ///
> +    /// let twenty = tree.erase(67).unwrap();
> +    /// assert_eq!(*twenty, 20);
> +    ///
> +    /// let ten = tree.erase(275).unwrap();
> +    /// assert_eq!(*ten, 10);
> +    ///
> +    /// // The previous call erased the entire range, not just index 275.
> +    /// assert!(tree.erase(127).is_none());
> +    /// # Ok::<_, Error>(())
> +    /// ```
> +    #[inline]
> +    pub fn erase(&self, index: usize) -> Option<T> {
> +        // SAFETY: `self.tree` contains a valid maple tree.
> +        let ret = unsafe { bindings::mtree_erase(self.tree.get(), index) };
> +
> +        // SAFETY: If the pointer is not null, then we took ownership of a valid instance of `T`
> +        // from the tree.
> +        unsafe { T::try_from_foreign(ret) }
> +    }
> +
> +    /// Free all `T` instances in this tree.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This frees Rust data referenced by the maple tree without removing it from the maple tree.
> +    /// The caller must ensure that no reference that remains in the maple tree is used incorrectly
> +    /// after this call.
> +    unsafe fn free_all_entries(self: Pin<&mut Self>) {
> +        // SAFETY: The pointer references a valid maple tree.
> +        let ma_state = unsafe { Opaque::new(bindings::MA_STATE(self.tree.get(), 0, usize::MAX)) };
> +
> +        loop {
> +            // SAFETY: The maple tree is valid. This call to `free_all_entries` has exclusive
> +            // access to the maple tree, so no further synchronization is required.
> +            let ptr = unsafe { bindings::mas_find(ma_state.get(), usize::MAX) };
> +            if ptr.is_null() {
> +                break;
> +            }
> +            // SAFETY: By the type invariants, this pointer references a valid value of type `T`.
> +            // By the safety requirements, it is okay to free it without removing it from the maple
> +            // tree.
> +            unsafe { drop(T::from_foreign(ptr)) };
> +        }
> +    }
> +}
> +
> +#[pinned_drop]
> +impl<T: ForeignOwnable> PinnedDrop for MapleTree<T> {
> +    #[inline]
> +    fn drop(mut self: Pin<&mut Self>) {
> +        // We only iterate the tree if the Rust value have a destructor.
> +        if core::mem::needs_drop::<T>() {
> +            // SAFETY: The tree is valid, and other than the below `mtree_destroy` call, it will
> +            // not be accessed after this call.
> +            unsafe { self.as_mut().free_all_entries() };
> +        }
> +
> +        // SAFETY: The tree is valid, and will not be accessed after this call.
> +        unsafe { bindings::mtree_destroy(self.tree.get()) };
> +    }
> +}
> +
> +/// Error type for failure to insert a new value.
> +pub struct InsertError<T> {
> +    /// The value that could not be inserted.
> +    pub value: T,
> +    /// The reason for the failure to insert.
> +    pub cause: InsertErrorKind,
> +}

Hmm, we've already have quite a few errors that look like this, e.g.
`StoreError`. I wonder if we should just have a generic

    struct ErrroWithData<T, E> {
       pub value: T,
       pub cause: E,
    }

> +
> +/// The reason for the failure to insert.
> +#[derive(PartialEq, Eq, Copy, Clone)]
> +pub enum InsertErrorKind {
> +    /// There is already a value in the requested range.
> +    Occupied,
> +    /// Failure to allocate memory.
> +    Nomem,

Given that we already have an error type for allocation failure, how
about

    AllocError(crate::alloc::AllocError)

? I know we're getting ENOMEM from C, but this would match what the
error type would be if it were from pure Rust code.


> +    /// The insertion request was invalid.
> +    InvalidRequest,
> +}
> +
> +impl From<InsertErrorKind> for Error {
> +    #[inline]
> +    fn from(kind: InsertErrorKind) -> Error {
> +        match kind {
> +            InsertErrorKind::Occupied => EEXIST,
> +            InsertErrorKind::Nomem => ENOMEM,
> +            InsertErrorKind::InvalidRequest => EINVAL,
> +        }
> +    }
> +}
> +
> +impl<T> From<InsertError<T>> for Error {
> +    #[inline]
> +    fn from(insert_err: InsertError<T>) -> Error {
> +        Error::from(insert_err.cause)
> +    }
> +}
> 


