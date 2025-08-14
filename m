Return-Path: <linux-kernel+bounces-767915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A55B25A79
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69B3A2A1D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 04:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CB41FDA89;
	Thu, 14 Aug 2025 04:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zJzVGlIh"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA6C1F8F04
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 04:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755145588; cv=none; b=OUnBNv46PuNVLZbMAE1QlpTGbyZGgZwhIKs3nqTl3Vbu08mkNnXKY+1xSogwHBsVvTMM8PzpJpR0UQc00LDc0cAeuWhpXP5rAyTU4DY8iuJluhVpkCiT5/1CDWViKQJQ8yoiIrosS51xKNDdLAf+MGG1yWT6oJwcDakgjtmRcwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755145588; c=relaxed/simple;
	bh=M+zbR6R1Nm/4pCp0B7gheJGuNDaXY/XrNqF/Pyj8bmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xgynju76i+cXpeQ7zV3KlBpkSucF0pjYKSa+gSacgI9Gph0XqIaOmFctB6H/bnY+bFaN7fzI0cDYvCCCRBO/cRv0PtBwxt4OaMsnZP2uyKWRcR9JbDJ369/MeS+zPvigx9fOFLAZJABEWOtRQntHZg9IDbH4IBNtl/nK+hr/Sms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zJzVGlIh; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e2e613e90so427083b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755145586; x=1755750386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Y4+VbSY2gENC6vjJLIhD6H5q5HP7szxm2F2pf2ubmU=;
        b=zJzVGlIhOOZynWHY+t7mRu8y3SWCOAPEcC0ucyRK12R+yWvC05JlQ3kKWYyoFTS4W0
         3Rtv6Iiq4omT8z/bs3GsfWgiDZWRllOvEorxYQyaqYSZBST4JzvcdF7Tkc/HRTy7OqrE
         cPY4tIZwxUWgmIyA9MTBZzOtualAg954lX8N8/6lEkkHfECN1oGAdT4s9WxkGVzE0mam
         1Q8xRe9atpVbOcHoWfEUaMpqA/ouqwq+KvMxpzJu8Ys4nAF5e2i63sW0JRvZZohyarRd
         8gfz8Sa84PUTu8vHnHURHgz1Uf6j93ow6VqxmC9hILfGqwi3SSD1FxJKh8YMCsJvizhd
         7pVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755145586; x=1755750386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Y4+VbSY2gENC6vjJLIhD6H5q5HP7szxm2F2pf2ubmU=;
        b=FOjhy3a2dE9oXJpoZlPw9cO/fi+hSdDuTVLvEYM1see+2A+sWl24gMHKfKggCcxeoe
         vwKHwUIRZS4o++2I12WlmH2hEaxco4wYuhjvtHlogV293E5XzvHbwCDVXJkgZmvi6MP8
         12XqS03nSa2SyeGHLag9cI6emF2XVBiA+3NZas/QQtDbzHPJCRQ2RV0vXDJbG5wBxCXr
         1yIMtaciRDuKSTg7FlJn5O4fozprrp4UNM95LIze2OrARP31CmrBAcbEhSZdmb78xzwR
         Hf/n2n+kBd9hwHd7AWkVGBmcWRwzz1Jdie9/q69GjiV+D5eAosH6gk5UP35EjvqJmdt1
         esDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJchu3/oBBdb2ZBJSdATR9iKnfJ54+iPYyGP8YUwwsvBtsy+BeFyzq92feBBNBJvQgIk4dugpRlTk9cIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwG05UpHqPPoyGbUJwaKSz6/1Z8bwa5b9F2xKzgYZVwQXjD1Bp
	EHkbyGK/WROg688GjIq2dx0iH9PLFlhMPYdeKP80gR78rt8XMbNUcRIq8BPkENJOZzw=
X-Gm-Gg: ASbGncubCA2h2+fKdN55jTUzshJOEF99CycCxhaVYvUSs8yfa5PwnsHSSQNbYusNCCm
	+E6fwqI79FQ523JHVB0o7xTbJuhP/+CA6nA4IP6j7YnDrFnSi9fZGH3n0oo9L0fbv8bTFm6HxVR
	wyahBXhqxfZYND8lIvMmVkM4t7xpa4ofRTyB80/HIOjfmEJjxEeb/Gki/xajkxIbDOL2xpSjRVK
	zhVS9wvhP12q1UFEGDXndFuES2TdW1YsYKqud6HttN4vV/47zD1iJiSusTaZwuGLKBrMrQjaPKt
	2QimYaddie02WqR14S7C0s8y6pr6VT5U0YyBPnIQQNlfC3aHCEa1btGVRLeOJVtDBo1RzN/T+Gs
	9J1hretRGyaglSswju6pcVSoSSMr3a1SXmYI=
X-Google-Smtp-Source: AGHT+IHTIvSY9FFJNBppNNZLO9sn/8s0tAcL4Le93FVv9JRJ529BpdCYJLpwI72ZJr0ZEnJN7dNv2g==
X-Received: by 2002:a05:6a00:1304:b0:740:aa31:fe66 with SMTP id d2e1a72fcca58-76e2f8cf708mr2713273b3a.4.1755145585869;
        Wed, 13 Aug 2025 21:26:25 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e2037acf2sm3493102b3a.112.2025.08.13.21.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 21:26:25 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:56:22 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Baptiste Lepers <baptiste.lepers@gmail.com>
Cc: stable@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: cpumask: Mark CpumaskVar as transparent
Message-ID: <20250814042622.t2qx6mlelntxi77b@vireshk-i7>
References: <20250812144215.64809-1-baptiste.lepers@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812144215.64809-1-baptiste.lepers@gmail.com>

On 12-08-25, 16:42, Baptiste Lepers wrote:
> Unsafe code in CpumaskVar's methods assumes that the type has the same
> layout as `bindings::cpumask_var_t`. This is not guaranteed by
> the default struct representation in Rust, but requires specifying the
> `transparent` representation.
> 
> Fixes: 8961b8cb3099a ("rust: cpumask: Add initial abstractions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baptiste Lepers <baptiste.lepers@gmail.com>
> ---
>  rust/kernel/cpumask.rs | 1 +
>  1 file changed, 1 insertion(+)

Applied. Thanks.

-- 
viresh

