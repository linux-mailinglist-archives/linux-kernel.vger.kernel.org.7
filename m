Return-Path: <linux-kernel+bounces-878638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E97AC21235
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DF094ECE74
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400CD366FC8;
	Thu, 30 Oct 2025 16:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uDs+MRpA"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7813279329;
	Thu, 30 Oct 2025 16:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761841335; cv=fail; b=lZgh5TMNq7vogcxhuvKK3Bzw2k1GQ5ifH3oNqn4+BCPrwPtRKo50LxsztA1AQEl80/sP5zz5tgM5plzzrWuoQ1beVOjSYgoVE6IVtHmszzG2NcBglxaKZuwPC1x9InEahUiI/NM9W2nO4v+9O/j17YKi3RpXuh6lCAc1HkGTTR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761841335; c=relaxed/simple;
	bh=Kvu0uhN7LhZpLl1z0iXhx8fcufrkYPHS7PtcX8es2d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZiWgzt4e10He2MCaJNC1UDwRWJ9ADbw6T8U70ELTVdn48qfb9QlZ+3S7baom3kantF3HuR9S+cmWeH55NUwfpWDVwz8TUhJLd44+14cBANpXiDqIltHiVDs2jFtW/mFkkUThqY0ZnWGeR4XPCc4Hmzm366jS7w5MiQaISlnOqiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uDs+MRpA; arc=fail smtp.client-ip=52.101.85.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtoDQV3ut1N4LXvpGxbD2kdoO30bln3rDVhgGp1YUUrCNUlaWiy5Lr5ikfkrr0BR0Cbx8Hd8UNDfcvtGRcGZep0IVfvGN9k6TU+QsPAL3AZg86r5R2XHWhDcE0PDQww0iDu3azRPTVFe084TvUqNpfGBA7Bm2hQPmpsBtpTmOy1Z8fJxhiNlNF/X/uCFtJE4Ip8fJbGgZq+LiN1fcw0fY6UkRbsmBkaWXAIYPKa4NImNKc0Gdf/uqlgy4zn2tmkoOP1iwAghmwP9fPFdQWnFkt8Heu6yva7Oii+g9+yMTW5iRflkG3pf3fmMNpWzbkG0LZFsZfTzh61TF4x5HlkD5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KohMODFJ8HnBp/E4Viuy6s6oOsr1UWNpu5hYHed4//4=;
 b=TmotC+T5iS0SX+ZYcveRe8iSf1EaKo3mDDpDOuVI2YGVdqSik3v26C3xRRglxm4tVWZJD9TCwXKVSdj6P9QmbAYBEwrgp8FRpqoNPZO/7AZ1/iNud1WFtmk9Wyd7YKz9N8nWmut6ipdjg4RteT49SYob9h/7H3IgDIezDLHITdPvrvUXqhqvGk11d1tL8iH4nW6gWmqX7Yue/GbycJ5+Iumttu/QW8HjV7I2ZC721WvWvL96AtuFdxqbFdAt17uMC/mjgjVdGhKaBj9Or8Y3PgLlWa9Kcck5G09o61fqPwata3pmTdMht0MlXjilpIMthjzVlHjbc4KKuYuEye/p2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KohMODFJ8HnBp/E4Viuy6s6oOsr1UWNpu5hYHed4//4=;
 b=uDs+MRpAH5bHw2EsNOUxCwddyYumRTfI81U4EykZMzUDfvTAS0xcZMi91zUM6tPJLSAtWJxE07aY2FVc0m4B7YDK69FWFlWYt31Hhbvu8HopELAzWpyBB7rTdTJ8P8+B0NRyFKtxB7/irjQpExUXGZzxZCRkPFpwlSbpJ8mXRuSCHOxIJw2EtxAsTSotugjbeZKqjNlE1QLwSVkVhGiicyj2UbEmZAbMSL4lyG4+8r9VmGzigfOeo2BWJfmO1FyPZ8uNmWyLNhzYFXVJuhnukW6dcLVrEE7fjlPjxGS71O5UugmO0z1YIAADpn2p2G8HSzfePpDP0Vu95GpCzTT6ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 16:22:09 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9275.011; Thu, 30 Oct 2025
 16:22:09 +0000
Date: Thu, 30 Oct 2025 13:22:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhi Wang <zhiw@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, dakr@kernel.org, bhelgaas@google.com,
	kwilczynski@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, linux-kernel@vger.kernel.org, cjia@nvidia.com,
	smitra@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com,
	kwankhede@nvidia.com, targupta@nvidia.com, zhiwang@kernel.org,
	alwilliamson@nvidia.com, acourbot@nvidia.com, joelagnelf@nvidia.com,
	jhubbard@nvidia.com
Subject: Re: [RFC 1/2] rust: introduce abstractions for fwctl
Message-ID: <20251030162207.GS1018328@nvidia.com>
References: <20251030160315.451841-1-zhiw@nvidia.com>
 <20251030160315.451841-2-zhiw@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030160315.451841-2-zhiw@nvidia.com>
X-ClientProxiedBy: BLAPR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:208:335::29) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 26e4b94a-d7e7-4c55-cdcc-08de17d078cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y5I3uP3C9+/6EWVK+EvDyYQ/VOJKKu53BmVMkhw8n8BptX5qXQ4EDBc/ZCFj?=
 =?us-ascii?Q?xzi1cn7BRIArhsLm2uWJgFJn01iVXBrTVSYnn9joRJSv8qlRqSHYI/0d5MQY?=
 =?us-ascii?Q?/xCTEvYIUdc40a4+M0Jy+sAmGafc63FVonE62ykNzt+9YRhDnTacpZeLFO2o?=
 =?us-ascii?Q?RAn0F/sSPw57k3/nMrAblJ2S6ADz3FZ5wXd0nrbrQ2PvuoROh45OKMQW/nbo?=
 =?us-ascii?Q?yaRo9vkMUcB0IB8tPPn3pBPQePuGDeLal920I6k4iGEYSAtpEM6k17cM9I9w?=
 =?us-ascii?Q?LuuRdh0ZGkHEeIc40svRnnsaRda3Na/hxUW6Jw0xEJxTC46efweG7ewlHXsa?=
 =?us-ascii?Q?HeZMJ1evDpGWoWw7FEs2unGECq1ThOVePdajjGduJtFCKkC+L3cqPqoc78oq?=
 =?us-ascii?Q?5ZsZFlki/PRXEO32GiUgyqf+Y5SiD86J3F291EsH8q8vEW1bQrrnpXZam9W0?=
 =?us-ascii?Q?Ob/UXJlmKOv9MIgTfuz5X7ClUY8bJZq8iWh0pQafeyqQLiHxwIdRKqFICuBI?=
 =?us-ascii?Q?wD7/qndSAaVSjMh2/JLjwfzHz5H7/boxq8wIvdY9Ew296GDt2lj0LVxLjZ1t?=
 =?us-ascii?Q?0Ll06feOn+IGJd+aqpmBJmBXZLGLRA8whhATvhSoPjwzWUqrcdZlZ1IY6qbp?=
 =?us-ascii?Q?M3z9D6PcCH6Wo1wlS/puzZZCoHnW6hWn6YpmzdgSjOwbEFxemFFK7cG3Lbya?=
 =?us-ascii?Q?vMzxkQZ4IoE2oIvWItQdmhjjPAqsUTzXIt6DvFXSXz8zHqrArjLv/ax8HkLF?=
 =?us-ascii?Q?N+oOk4/VXR0gkNnDcNh2LwhXAGj1LF1urqRFEVYvMbqlmADfMuFHGcUwXNZj?=
 =?us-ascii?Q?94lb2pHsqMhBIUa+b6gD5NCyQN9xyd5hQtnTVx0/er3x0iIpgYQzLJRpT22F?=
 =?us-ascii?Q?QhlHm4+5M7kEzXq0FOVS/iPA+jxDrur1lUlYV42JO0A/a9olXzE7Rqv4Z7OV?=
 =?us-ascii?Q?qQ8h5RGq2Ctj+tSLkahocuIuOay+EmvxfgFsRfB81bpFHcrSuetD9qAHhCHM?=
 =?us-ascii?Q?V8FWbnL76qdKUMrnXQWYZeVS/oomDyMYfn0Ua9791zYYZQoCkiHKBQe2VMVA?=
 =?us-ascii?Q?pPX1fdAEnKnpDoBZHVCV3LT4j+UjgrX6BSx8ss6dWx5aYxx8DDMPkaS9/Fj2?=
 =?us-ascii?Q?aKystsKykChvHW54uCXIo81PwGXFIMupXY5jJ1C73JirkEOOIU3GuisMXTEK?=
 =?us-ascii?Q?fMA0VlH8S1I7zKBp/GwpUjc8ITc/EVsxvU2Mo1nj83RT6CNxuK9EhAMPOaDB?=
 =?us-ascii?Q?lM3mMb8NPyn0cKS9mT5eqCl2z6bN6RoHKHEqGs7TyYp8V/LQPwTKXMaW22rm?=
 =?us-ascii?Q?4zZYpztHx5KKhGP5F6xlAmjR6+zz7QRF1PWm3tAf3hQ58t9Y9SVN+fBMnAe8?=
 =?us-ascii?Q?qsgKiJqs6mSZgwvi5iUdBeoc0zWkOVMzYZdvNnug5fWaerUCWrxUNW919To/?=
 =?us-ascii?Q?0crDF3q9HT/2N2IWdOl/+BjabN4TC74Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BEst+SxhdRKOPkp5hg9m5Qn+qtNsDPOfDoPhmy+3C83N0BEiAWlGZOAONlIx?=
 =?us-ascii?Q?6p0sO5Wi2qq7nRyjL2tKyOHD1z2pYxDqEjm3+/O6O0UnQldG7HWBaRB5oqNh?=
 =?us-ascii?Q?wah4qKQGav++xD9Rsodi6PClNw5UFRXBhsnsJ81PG8JWh9AJhw2hW88HvyGb?=
 =?us-ascii?Q?hT9cucYq625XaSQe52d+hGN1xW7aRk+12n22v6v9nJceJ16u39MF3TrZIDd4?=
 =?us-ascii?Q?CDD6U44mhs1ucYb+eWZZ+LuZpY2i4qpuLNtledgkWRojkE8BeyOej8VTr7D0?=
 =?us-ascii?Q?NIQmIjhf+dDEEwFESWaggLWZ2+lAj6sUg7xNqOs77swY5JhJcwXdfI6HCDZf?=
 =?us-ascii?Q?+Hx/H2niTlSaKSHnsRp960dtlXYi/pFoLqFBZzPUUzK7ge1o06q2sm6Wq1zk?=
 =?us-ascii?Q?Kdeo7BRHbKstQC1rFCCco/RrEAgd0vVbFE1iS74ovCOlnmUt55p5Z+AB4Opx?=
 =?us-ascii?Q?ywwjEqacHqXSXuMcEqG1DNJ6Ii22oClek/wK/h4M8UUFegIIeiZNox/+5YYx?=
 =?us-ascii?Q?/LXnb0Go1t8pV1qlSpLw9bTXCHJ4cujRyb1XElVhT9N4w19JSSHRvZDcUMyK?=
 =?us-ascii?Q?0rO24FIwECksFBfN/IpfzbjlPi99KVrQF9JoTg0+w5sFq1DTp8Vcob8HRSFL?=
 =?us-ascii?Q?Wyc1IMh1AHUcwYMeqgUbTuAmsfT55xBGswhX71sBQ3Z2pRv1vQFaw1JEjZcQ?=
 =?us-ascii?Q?OA479BaryIdv9/GbchjDWBBmchf22DVCzcPbIGNO7Xf2fSML17PyupkyNbJR?=
 =?us-ascii?Q?Kxc5KtdEXAdibO+cynRtWrhSUKt8U8V+ZKsJHeBy2DVvD26V+llngXMzTPP4?=
 =?us-ascii?Q?cPSYQvl0km9UmlrkicUjFWq6FGk/+96Ksvie6OknXpKEWM+E2VgayKlRLT5R?=
 =?us-ascii?Q?0k/6hVUJBudwiyUUWjbuwbSbnX0WeRa/QbO2GTN8ZO4WppFWFAYFHGqqFu/8?=
 =?us-ascii?Q?snkiv0xY4uLjc/2xwsytKP23FGN7N2+mpqH3UI9zTCdArYIr6chJArQQeZqv?=
 =?us-ascii?Q?h8VPPfoFasm9C4Op4CRLrEpsnBQeoehFPTfrr/W9m2LlvdH+jeKA3liSsVaF?=
 =?us-ascii?Q?DrPB8K0l7LPVDCR5jBdwi9roxRemKmZqPuTgQOyViNzacGKIaSfaDFl5HqKW?=
 =?us-ascii?Q?1nhvt/pfWm7V2SUphGH1NotmJHi3wpfaoMIX/Ap3SSA64gvRyUyb3NcJFVG7?=
 =?us-ascii?Q?JpsG7GHi3N8DgdLIFg0rf0p6sUoRzB+ccK/8netBdzptY/mL4XDubqlVbLev?=
 =?us-ascii?Q?iyH4l9JT/LgBd7ys5gV8AUirr5rfE/PXfURsZaUvAc6rwsEqYirSLO7y+eVo?=
 =?us-ascii?Q?9IueqwzR25D/L0n4N/BStigwpHKTKhaIZf80Ua6Of56Qc1DIa9pvcM5KSelg?=
 =?us-ascii?Q?NNc1yfaMSbJQJZgQsuF8cD4VxQph1IFiF+8Vd0mnvTDvJbqklwkfruRP0NVE?=
 =?us-ascii?Q?UQwvo/CwTMRH7QY8x+pICq7sCD2voqAtysfTNfl6PEcf9zrP9r3Xno5yPokm?=
 =?us-ascii?Q?bs5yQILpYurV4N0YDYdrCgF05xae747tM1R1yS2npD1TrcZxBd4ltRchisev?=
 =?us-ascii?Q?TjAL61yYEGv4oLPju2A=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e4b94a-d7e7-4c55-cdcc-08de17d078cc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 16:22:08.7171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBm+I/JbMnculP1sq3CJLweTqwsqZrovx3T3P+mZox2C0ethA5xCjw+dnj3bEcPt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898

On Thu, Oct 30, 2025 at 04:03:12PM +0000, Zhi Wang wrote:
> +impl<T: FwCtlOps> Registration<T> {
> +    /// Allocate and register a new fwctl device under the given parent device.
> +    pub fn new(parent: &device::Device) -> Result<Self> {
> +        let ops = &FwCtlVTable::<T>::VTABLE as *const _ as *mut _;
> +
> +        // SAFETY: `_fwctl_alloc_device()` allocates a new `fwctl_device`
> +        // and initializes its embedded `struct device`.
> +        let dev = unsafe {
> +            bindings::_fwctl_alloc_device(
> +                parent.as_raw(),
> +                ops,
> +                core::mem::size_of::<bindings::fwctl_device>(),
> +            )
> +        };
> +
> +        let dev = NonNull::new(dev).ok_or(ENOMEM)?;
> +
> +        // SAFETY: `fwctl_register()` expects a valid device from `_fwctl_alloc_device()`.
> +        let ret = unsafe { bindings::fwctl_register(dev.as_ptr()) };

This is a Bound device, not just any device.

> +        if ret != 0 {
> +            // SAFETY: If registration fails, release the allocated fwctl_device().
> +            unsafe {
> +                bindings::put_device(core::ptr::addr_of_mut!((*dev.as_ptr()).dev));

?? Don't open code fwctl_put() - it should be called directly?

> +            }
> +            return Err(Error::from_errno(ret));
> +        }
> +
> +        Ok(Self {
> +            fwctl_dev: dev,
> +            _marker: PhantomData,
> +        })
> +    }
> +
> +    fn as_raw(&self) -> *mut bindings::fwctl_device {
> +        self.fwctl_dev.as_ptr()
> +    }
> +}
> +
> +impl<T: FwCtlOps> Drop for Registration<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: `fwctl_unregister()` expects a valid device from `_fwctl_alloc_device()`.

Incomplete safety statement, the device passed to fwctl_alloc_device must
still be bound prior to calling fwctl_unregister

> +        unsafe {
> +            bindings::fwctl_unregister(self.as_raw());
> +            bindings::put_device(core::ptr::addr_of_mut!((*self.as_raw()).dev));

There for Drop can only do fwctl_put() since otherwise there is no way
to guarantee a Bound device.

unregister has to happen before remove() completes, Danilo had some
approach to this I think he told me?

Jason

