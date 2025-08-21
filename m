Return-Path: <linux-kernel+bounces-779411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AA6B2F3CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814B2170908
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C4F2E7F11;
	Thu, 21 Aug 2025 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dMCyPtUY"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94742E7F16
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755768102; cv=none; b=ttlFWmq9gwcs+PxaqnrAiR+56wrKMAs3k+DtQrKB9fAzroxITL4+ipIRnTESJQX20L/Ug0+AcKAi6z3eX0UpZ2TTCxTbyOfLLiWCeLuOydp1KRVoFlC5S+yHbkYwc0jxmWJwo0X0ivZXs2/fLxmH4mDMYvzmTnJM1hbZqS4bzPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755768102; c=relaxed/simple;
	bh=ijPoGdjzeNrat6vrwS2Sn0CzPWVJk5y966fhUtipBas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEUe8vm34KWYeXuQHR6B3YCjkpmXDLOZ+6QqRj6gNZPZFq/a18KTMQVjZr8EyhTL5fw8AedkvKvdKCOI3KVFKZPGuGGGPcjflmeKWOdsTtRuPqspdPs1yyzEwh+GmY1CdB59/xAkzymhYG7o/pWHgxZ/cLSCBrWGc/TIaDbE8t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dMCyPtUY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24456ce0b96so8462635ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 02:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755768100; x=1756372900; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zJKypcai6x92HNXEJAfDnNbD+B+6yE1R6+hogPfBXqc=;
        b=dMCyPtUYvR8gFYvQEwWnT/ek4/oeHKtK4CFokwteo7v4sMxoWWYDsskcqz2iHKRjJv
         464NQ8uyehUfDNXCmrwtUO1KA2MBcwzuA+qc5RIXMzl+IZTFhobY3dP8GD46qkeBze7T
         cRiNcRx1QGvmAmq5QS6BRksqJ8hfq6CuF2mNAsna1nz6tg4o13hExGpDQPYloy3nRP6E
         s8xba+DWFbKji52VMDntPQdifDIq6YBpP4VBiWOc82Zwp3R4zzoNB3CM6+EzdrNXHtBz
         eIMTcIIGYFZfKoyZ+6NsOCSI22jK/DtGcM47ZRQ9TNl+abD9wcaAsOiCYzr/Yt9JkMTA
         4S/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755768100; x=1756372900;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zJKypcai6x92HNXEJAfDnNbD+B+6yE1R6+hogPfBXqc=;
        b=xG0DgFnYvTQ/A60QpCe0q53Ym2Za1pIZ8zqmNv/XCqM0A3qXhZmR7TyyC7dgTZe5q3
         4zYlQOx798lURw3N6tEa5VnPNJTrI8UfbrKskSejFHtd41aSqRJaJzSWCDGSME23lJ+x
         7xLSNtttXZ8uoGIBBF7ElMPgQtX77hqyh2CRyFrFf9TirBH5Ifw7peFmlq5men6SzYhF
         7ususz3H1+uhPc3ehJ2VQ1+xuZkG6hni5dCwJ7AmkqeHn7NUAMPVSLLRAI5kpPijFtSx
         jve7mWen0CfQdZMCwvzkJ98zq8W8PM9ZXgUjc2OaQE5c+B0vaH80yFAb0OU98wUmfA05
         7ItA==
X-Forwarded-Encrypted: i=1; AJvYcCVRJEEQk1FfbYNm1vX8KcnrwVW/g7oTgji7VJRHSXPMVF+iiw+W6gssMl/XdrXkVqu8Mp6pyvMTe6L7e2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/iZ95o4YvJJL0ZjP20tsS6eINQOhzXMY+rNjU8i0DFpRkuWFc
	E93TT0QWYF2Sp+z7VZtJqCZUO9G0Hg1rA8s5PETo8YqAFUwslfNR0BNAvKLH6WCHqhE=
X-Gm-Gg: ASbGncvDOSEEP5SVeyS++8j0EvUvv6izcM6hjDFyHTWwEjRGB8fOOVra5Ctkl5ChV5W
	I4+c5g+iNSdjgV++ndhHamOHeIOD+hw/m1jZPxkzuPORJQJzi6ysZsB/5p69zW14LDmtKeWArIK
	211wyUtbur2UUDBt6CDQBKf5wpL71K3kXZqf5vIJA0lWnf3uwFFKoctlxdfKpLc4Zn38Bpc9yY3
	Wo4RAcZtmPMIyvHmeA8Y3EtujlwU8OZGSdJYqyatY7JsQyHQBRqmuR5cOEpHln5hcIse4Iozp8C
	9zs6U7b1J3z9Ey1arJKscaBxtuCMUU45xWd02BgEoxFSrMdO6XtI/ShEivapqF0RCHYeMReMNSz
	pjnlQ0rXMzHwNjFTscjaodbYu
X-Google-Smtp-Source: AGHT+IEcS/tuNVZrG+fDd+9f0DpmfNWHCLvje+/VQyO7/Ge/2qxOY4o5KiHN2KOvKZ3Zwoc4LV4bzw==
X-Received: by 2002:a17:902:e751:b0:245:fcc6:a99f with SMTP id d9443c01a7336-246023cf093mr25599545ad.11.1755768099946;
        Thu, 21 Aug 2025 02:21:39 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed375bc4sm49914185ad.60.2025.08.21.02.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:21:39 -0700 (PDT)
Date: Thu, 21 Aug 2025 14:51:37 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, vireshk@kernel.org, nm@ti.com,
	sboyd@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: opp: use to_result for error handling
Message-ID: <20250821092137.wttiixhiidt27hnq@vireshk-i7>
References: <20250821091606.7470-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250821091606.7470-1-work@onurozkan.dev>

On 21-08-25, 12:16, Onur Özkan wrote:
> Simplifies error handling by replacing the manual check
> of the return value with the `to_result` helper.
> 
> Signed-off-by: Onur Özkan <work@onurozkan.dev>
> ---
>  rust/kernel/opp.rs | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
> index 08126035d2c6..9d79c2816af5 100644
> --- a/rust/kernel/opp.rs
> +++ b/rust/kernel/opp.rs
> @@ -12,7 +12,7 @@
>      clk::Hertz,
>      cpumask::{Cpumask, CpumaskVar},
>      device::Device,
> -    error::{code::*, from_err_ptr, from_result, to_result, Error, Result, VTABLE_DEFAULT_ERROR},
> +    error::{code::*, from_err_ptr, from_result, to_result, Result, VTABLE_DEFAULT_ERROR},
>      ffi::c_ulong,
>      prelude::*,
>      str::CString,
> @@ -500,11 +500,8 @@ pub fn set(self, dev: &Device) -> Result<ConfigToken> {
>          // requirements. The OPP core guarantees not to access fields of [`Config`] after this call
>          // and so we don't need to save a copy of them for future use.
>          let ret = unsafe { bindings::dev_pm_opp_set_config(dev.as_raw(), &mut config) };
> -        if ret < 0 {
> -            Err(Error::from_errno(ret))
> -        } else {
> -            Ok(ConfigToken(ret))
> -        }
> +
> +        to_result(ret).map(|()| ConfigToken(ret))
>      }
> 
>      /// Config's clk callback.
> @@ -713,11 +710,8 @@ pub fn opp_count(&self) -> Result<u32> {
>          // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
>          // requirements.
>          let ret = unsafe { bindings::dev_pm_opp_get_opp_count(self.dev.as_raw()) };
> -        if ret < 0 {
> -            Err(Error::from_errno(ret))
> -        } else {
> -            Ok(ret as u32)
> -        }
> +
> +        to_result(ret).map(|()| ret as u32)
>      }

I would get rid of `ret` as well in both the cases, like it is done by
other users of `to_result()`.

-- 
viresh

