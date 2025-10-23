Return-Path: <linux-kernel+bounces-867280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C95C021F1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61DAF3AE0ED
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE27335068;
	Thu, 23 Oct 2025 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="addQnBq6"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A83328B4A
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233012; cv=none; b=Yqeh7QU5x5fY5CtRgmBUCQOWcYcn55CxZ5IPCRb00Ky6Nn56IK8QumEI4d7LlJ8tR0wcrMX3G+oucwvODtAM7449DmZKpqshYjmIhivPbiSf7+riGXTazMkDIs/EbO6r/39HqnuYncH63uY1pHS09ChvOcTRkFlRHmS0lWpFnfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233012; c=relaxed/simple;
	bh=YCILTNSbyosfdViBsQ3Dn1szo1k9Lccn/kFvybxH4n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HycWZoTyPIu6OGE/vNMlwvSCfeTLYcllRsA4zp1SFHBOU/+aLuc+zcHUOpIfCefsW6qjqE3xSWwUBifzS8ezIgrcl9tfjWzxCZZ+YZ9ymqFMY2D7r4iimzMTD8kg0oFrXfx+LdiFHj2t8FYQ0lKLy0FP+XYSPZstxLD6pwJhLDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=addQnBq6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so13496625ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761233010; x=1761837810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Jd/YojK3x6BAqKg2xzVCUWKgrECDyhwMyyAZSD/iCQ=;
        b=addQnBq6u4m1d4YQyx87rwEkhOeQuRPuWrOJza7CHZUj//K8wYOqPMvyXt7HAfXZkO
         1FBRuqGjEoPPXLI5On83j67UXnVVNEwJoQ/AUSeFtvzwl43ecYB8knAQaJk6yCc8nDOV
         4JcKUdPjO4+yMiWwavK73utMmIYqmVf9BVy9jIh2XB4S0LhYo4kWAsyZ+73aONbLKSXN
         ZbkgLRaxKPV6+OItxljaOfJ7jvzNis4HhG/BiCPjXN7+oGpw2OS8TM2KOMylcgMsOwv+
         xwXAfIA2xU/KN6u0Md2CFTNcquJX0TgRfrDljfzf6Gn+kX70GaD3VQDDoZCXj+H7o5E8
         EZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761233010; x=1761837810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Jd/YojK3x6BAqKg2xzVCUWKgrECDyhwMyyAZSD/iCQ=;
        b=ZBn3xQ7QZG/PnV6C8WX8Jg4CvP/feYHEr7GWZV+csrgtv72d+1BPxAeSi3XJM4Lhyp
         UKSkIjsFQbYkQGoCYEfNFcDUGyZRB2PZjMxePZXY2qdkKDN9cSiAufFdllO9GvxDCPuB
         wa4Zl2J7LUcqR2BhsLURsRezy+XiThboLVOPgL1SLcQljFokSocUCaHk5mu2ETPDqn/v
         PzjVhHrsqahzt6P4EtxZhI4g1CeNAU+Gbl5m3nNTjDZ5B+mgBItRejc+SWjQzWBvzzb3
         Y0KQMYNWzCojXyXAqOdP4XFKNpGx5+RTy26Vsyb54/FvZekWNCfCfHnvBGHqySMFLtM9
         4n0A==
X-Forwarded-Encrypted: i=1; AJvYcCVA95hnNZ9xgBZVPGA7S/RVctAYoERTg4n8lHxW/q7BdiUKW/f/k4FC/Ox2OSrbz0S+jPcgdIhcj6rLb4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuUMQ0A/ThpH1O+AHYKp2XQDg5GgIIZtocUsGOu+mKAU38UHNw
	CYS3/jnHC2fA8QmxuLQEjklDmxAkNJHHKgE0LO5oxVeaYTsh54n2+9BBy9n1T0R+jV8=
X-Gm-Gg: ASbGncu/ZJ7SxsfDy638xy/UjMdoSWtC3Mk9iUGd+mM38lngo6sl8V9DHywG/J6rCmt
	PQq5LggVAgzt4RfqkxyE5Ee+qIf8YrE8QMc4LTA8ZRsmB5jvDRVddQhuAfVc+gGat8mOe8Flc1y
	VsMKgQlF2oNUXZnZvysjCdQmpmajEBZ/8jmM0oQkDr9b8VSh8HX/7vtQjyX8kG1CQeMkfej9/IK
	y+4DQx6gExgRX7jg901vdSuNv3w2ZQpERlCbrqnD5/1c3Lb/6XAGvZYqc5yHL4EHbpl9xUZu/io
	TU0JlbZ9tyq5QaQLEkdNl9B9EJlNOrxMvLnXBZAcHj209q5MD5vNcPky6lddSqPozRnRBkupLJ/
	v3vcctki3+dCa942PCAEfcngxwB1nskNAjMLXapt0WrZL/2fMJr4ymoxV9seD3h7TqVtE4QXH2b
	+prA==
X-Google-Smtp-Source: AGHT+IHq3h6LfhWY2rBpFaDKhPiyqhG73CHPD/V2qNHnHKDNAg0rCU4Vtju+XrMqjCggiDc/6zvHtw==
X-Received: by 2002:a17:902:ecc8:b0:290:c516:8c53 with SMTP id d9443c01a7336-290caf831d8mr319027295ad.40.1761233009992;
        Thu, 23 Oct 2025 08:23:29 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e0f5de1sm27115915ad.87.2025.10.23.08.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 08:23:29 -0700 (PDT)
Date: Thu, 23 Oct 2025 20:53:26 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tamir Duberstein <tamird@kernel.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: opp: simplify callers of `to_c_str_array`
Message-ID: <gjlcd7nrmipdpim4dr2kfrk5mleo2yt2btwbhxdflzfcpckjjl@fieqlaavqja2>
References: <20251023-opp-simpler-code-v2-1-44230ed00fd8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023-opp-simpler-code-v2-1-44230ed00fd8@kernel.org>

On 23-10-25, 09:59, Tamir Duberstein wrote:
> Use `Option` combinators to make this a bit less noisy.
> 
> Wrap the `dev_pm_opp_set_config` operation in a closure and use type
> ascription to leverage the compiler to check for use after free.
> 
> Signed-off-by: Tamir Duberstein <tamird@kernel.org>
> ---
> Note: this diff is much smaller with whitespace suppressed (`-w`).
> 
> An alternative approach to compiler checking for UAF that doesn't change
> indentation is to add `drop((self, clk_names, regulator_names))` after
> `let ret = ...;` but that felt more prone to becoming out of date if
> more owned data needed to be added to the function scope.
> ---
> Changes in v2:
> - Avoid use after free; add compiler checking. (Thanks Viresh!)
> - Link to v1: https://patch.msgid.link/20251020-opp-simpler-code-v1-1-04f7f447712f@kernel.org
> ---
>  rust/kernel/opp.rs | 112 +++++++++++++++++++++++++++--------------------------
>  1 file changed, 58 insertions(+), 54 deletions(-)

Thanks, tested this and it works.

Lets see if someone has any more inputs, otherwise I can apply it.

-- 
viresh

