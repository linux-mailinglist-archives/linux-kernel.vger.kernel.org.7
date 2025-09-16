Return-Path: <linux-kernel+bounces-818705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178E6B59574
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B7A4E18A2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4915307AD5;
	Tue, 16 Sep 2025 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="Mqk3CajW"
Received: from forward203b.mail.yandex.net (forward203b.mail.yandex.net [178.154.239.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E213B2D24A3;
	Tue, 16 Sep 2025 11:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758022985; cv=none; b=Bs4RZ1ltlT+PyQ00tQspd1V4VuBVmf77gYF8LdqZ61wzN6rid1QciySAQ0eLSyCZPMdKBIuYQ/Aw31wxXZHiOUYO+JUikPJR8OFZTD7U87AdU08ovTwQG+JShxaSV53MDd4hxQPZw1P26HMSjzBi6smwmflLwiDAVdQbgzeRR+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758022985; c=relaxed/simple;
	bh=ufQwXgpAF7x/2e87GzztuyE/4qAuG3GmhscgNSQnQ9c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QbNgtcjZOeJWUtcWCqfOrwODnmJYwSwzn0E6D4Q5uFk2P6R8Iad3eUdKmm0+Oj9PtzlCOb13YmalzHhJDk2OiP3XQEmvRwc72eIa4m6WlIreF0vxsQgNfLOW0pESW6lBSVN8nEa7hf6Hw6jQKAo9lKWr12G+fenm97XlxRD6Hu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=Mqk3CajW; arc=none smtp.client-ip=178.154.239.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
	by forward203b.mail.yandex.net (Yandex) with ESMTPS id 0B4FD81773;
	Tue, 16 Sep 2025 14:35:00 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:942:0:640:e3c0:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id 356A3C0148;
	Tue, 16 Sep 2025 14:34:52 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id kYODtTGM88c0-q7bDjdtS;
	Tue, 16 Sep 2025 14:34:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1758022491;
	bh=tamG18SOnqflM3WTf5u2oTfNYuCXJLMJ+kcGrwAEU/M=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=Mqk3CajWO8a4IME8O98bYpJ8v70TnGSGyqJp18pc5MUpwjDlVRFlgGqCFNCJkHznh
	 ecqJ/pqIDgf/f/9NgjETKF2E1X4bFUgpTSXSDgOiHwSRmUKTFmvi7YLM9CYz1oBqlr
	 T4MsQbVwDJPuvqB1dALawk4xdkUwRsUEM8gf7o5U=
Authentication-Results: mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Tue, 16 Sep 2025 14:34:45 +0300
From: Onur <work@onurozkan.dev>
To: JaimeF <jaimefine6@gmail.com>
Cc: gregkh@linuxfoundation.org, ojeda@kernel.org, alex.gaynor@gmail.com,
 david.m.ertman@intel.com, ira.weiny@intel.com, leon@kernel.org,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, dakr@kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, onur-ozkan <contact@onurozkan.dev>
Subject: Re: [PATCH] Fixed "initialialized" typo in auxiliary.rs
Message-ID: <20250916143445.5d437391@nimda.home>
In-Reply-To: <20250916103839.17202-1-jaimefine6@gmail.com>
References: <20250916103839.17202-1-jaimefine6@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Sep 2025 10:38:38 +0000
JaimeF <jaimefine6@gmail.com> wrote:

> From: Jaime Fan <jaimefine6@gmail.com>
> 
> Suggested-by: onur-ozkan <contact@onurozkan.dev>
> Link: https://github.com/Rust-for-Linux/linux/issues/1187
> Signed-off-by: Jaime F <jaimefine6@gmail.com>
> ---
>  rust/kernel/auxiliary.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
> index 58be09871..129eae8ff 100644
> --- a/rust/kernel/auxiliary.rs
> +++ b/rust/kernel/auxiliary.rs
> @@ -317,12 +317,12 @@ pub fn new(parent: &device::Device, name:
> &CStr, id: u32, modname: &CStr) -> Res 
>          // SAFETY:
>          // - `adev` is guaranteed to be a valid pointer to a `struct
> auxiliary_device`, which has
> -        //   been initialialized,
> +        //   been initialized,
>          // - `modname.as_char_ptr()` is a NULL terminated string.
>          let ret = unsafe { bindings::__auxiliary_device_add(adev,
> modname.as_char_ptr()) }; if ret != 0 {
>              // SAFETY: `adev` is guaranteed to be a valid pointer to
> a `struct auxiliary_device`,
> -            // which has been initialialized.
> +            // which has been initialized.
>              unsafe { bindings::auxiliary_device_uninit(adev) };
>  
>              return Err(Error::from_errno(ret));

Thank you for fixing this!

Can you please use work@onurozkan.dev address instead of
contact@onurozkan.dev for both cc-list and suggested-by tag ? I am
not using contact@..com for LKML.

-Onur

