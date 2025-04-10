Return-Path: <linux-kernel+bounces-597786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C2EA83E8B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 11:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCAF03B5E35
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 09:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BAF20F079;
	Thu, 10 Apr 2025 09:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DL7EBaC5"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3FD20F070
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744276608; cv=none; b=tWfOSuD1z/agrVfW1UahC5S0dy9K8uYOXjYuIbuds/DLcPKxUtlAcIcglgsMVx2SEID3IK25TT8cs65LQQhVkaYDtYBToERnFStMUTvNDnwTK9yTNZtJZ7ySsqeYR1LfP7k7HKfjztBxa39ucg7S9Xuk6jFtFJYEcljSxFQl6dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744276608; c=relaxed/simple;
	bh=itSqP8ogBAobjCYHP+CFBbneh9aJwPMtMma1ImNEw+8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=an625QLA9ay9J0oW8vZGxB0XVizRYTpXX4oi9kDBCCid3dS2dk3HRLcn0OtizsglpCXDpPhffweOXXlNY8ltaq0TKHTjcA2AXtu/uJbBHlZE9olQbxUUru9+EUgdC6NBdY+DIQpoi6Zd/YhAj7mMEDHaxbvvS5qpNCw3B8NkdyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DL7EBaC5; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so4807325e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 02:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744276605; x=1744881405; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yfvJMVFhf1+kAn7tCoC+aB8KULrWlIykltXkyJsg4r8=;
        b=DL7EBaC5qkUVQcgyCv48Uo45zC7QclPvd+uf6LNgwtPRBOmezx8ek7ej9KTPM4aC91
         fdXQDcggXpCQnYJT4wtoRnfmFWNb6gl6BV9dc9tK4vSG0x4j//bIDhYiT3W2HyBK+h9v
         XksFJpUdf4oPIdRLYNB9WUbPurSh0nl8eAUKDAFIlEyARYHR/gpSZDKNE8DUoypJ8txI
         YvPsxvocDazwe56b5RHpYiAzTi1iuYDpNPgmH1tek+wR1n7MM4GpdtvyeGTmRwPSstz6
         upKN55JcTLG2he0PLvB01PmAr4JQ9W/+JsqENYHGf9KmnqkmlOtWy5CQyb9A2N/qzWMe
         jVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744276605; x=1744881405;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfvJMVFhf1+kAn7tCoC+aB8KULrWlIykltXkyJsg4r8=;
        b=P0LmMZiwPWQSJGauKNofaiH7VUqjfbOo5ptJnJ0VPzY1cxxJqR5bobdppyhKm6gk05
         8O7mGigu12TrL/vhHXPt0PYRTIpNesILjHgVmu5i6Jjwcf1s29+HJxq4xqIsNqCmwynB
         M3pkqSQYTBDjOyffhH3r0M3cuHKcH8pCpeNAK+zoo/uE0a5ZOzYsqUdIcGyARdeLQR8o
         6hydp2TiewgyqiefNHYomuICfoYFMq0VeAhmMXqsgpk2L7HUlm/Cs3ZeovTObc+o/ELc
         kEoDKCKjiNgbeQ6qTm0f6usBKIHFe9Z6B8klfSD5WI2D3DUtmIuobgbqzQBdCncNalhf
         gNHg==
X-Forwarded-Encrypted: i=1; AJvYcCWSGiTuECPGDhnHub8J/C6elAn0ztJnaA1WBqmK1a2uWqqzwWdaTwNvDKmp3YuI7sPeD6LgIrTHZgjfAu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyohSP6tsGcbuS+Fh+1IRPAeq0ehzx9gHs4l76Bvr1/cBsA1+GN
	pX4pQSOx/xWME8JdLqDXTYsXqMatyw9ZKJ1v6MHNBI5WKBaDSS64nkfI23CVFG53Cw5UEGRBZgo
	gMO5H5l4SBiqTEw==
X-Google-Smtp-Source: AGHT+IETeoAaNtvfDFEMNKBYDouZZNCtt3iqFBqsbj3dZ6TE/CPvQOWwMIom6SUQsR7LhOwbohGA98ZZqIG3vlE=
X-Received: from wmrn9.prod.google.com ([2002:a05:600c:5009:b0:43c:f8ae:4d6c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e51:b0:43d:209:21fd with SMTP id 5b1f17b1804b1-43f2d98b578mr24536995e9.30.1744276605380;
 Thu, 10 Apr 2025 02:16:45 -0700 (PDT)
Date: Thu, 10 Apr 2025 09:16:43 +0000
In-Reply-To: <20250409-no-offset-v2-2-dda8e141a909@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250409-no-offset-v2-0-dda8e141a909@gmail.com> <20250409-no-offset-v2-2-dda8e141a909@gmail.com>
Message-ID: <Z_eMe7y0ixrBrHaz@google.com>
Subject: Re: [PATCH v2 2/2] rust: workqueue: remove HasWork::OFFSET
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Apr 09, 2025 at 06:03:22AM -0400, Tamir Duberstein wrote:
> Implement `HasWork::work_container_of` in `impl_has_work!`, narrowing
> the interface of `HasWork` and replacing pointer arithmetic with
> `container_of!`. Remove the provided implementation of
> `HasWork::get_work_offset` without replacement; an implementation is
> already generated in `impl_has_work!`. Remove the `Self: Sized` bound on
> `HasWork::work_container_of` which was apparently necessary to access
> `OFFSET` as `OFFSET` no longer exists.
> 
> A similar API change was discussed on the hrtimer series[1].
> 
> Link: https://lore.kernel.org/all/20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org/ [1]
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Tested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/workqueue.rs | 45 ++++++++++++---------------------------------
>  1 file changed, 12 insertions(+), 33 deletions(-)
> 
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index f98bd02b838f..1d640dbdc6ad 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -429,51 +429,23 @@ pub unsafe fn raw_get(ptr: *const Self) -> *mut bindings::work_struct {
>  ///
>  /// # Safety
>  ///
> -/// The [`OFFSET`] constant must be the offset of a field in `Self` of type [`Work<T, ID>`]. The
> -/// methods on this trait must have exactly the behavior that the definitions given below have.
> +/// The methods on this trait must have exactly the behavior that the definitions given below have.

This wording probably needs to be rephrased. You got rid of the
definitions that sentence refers to.

Alice

