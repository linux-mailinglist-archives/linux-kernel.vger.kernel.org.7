Return-Path: <linux-kernel+bounces-893604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 274A9C47D33
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7EA91890B15
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910B12773F4;
	Mon, 10 Nov 2025 16:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjywY3vc"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F43205AA1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790739; cv=none; b=DZep2Jrw0znhIMmPexz96sLeqjhmxjruLJ0beXyfKOGUvTMh8r2e/dKiCbtkZDRRMLMhYUxzRm4G8k74OS/zGT76DqU+93Zt+ubVdGFqBkDc6m9em6G8LJ1DXwXAZgYC5+ImRnTSUgV3IKfp44yfWBgDNiTu6nbw3N/M1KajBYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790739; c=relaxed/simple;
	bh=onmwgzWvrykN1fzVZiejcYemdHDzwD/isE77f44YfsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZpP/duRWydAHLnkeZTaHQeRYevqs568rLhIutFbJ+MYvQxVjLq60zM60GO+CVUHOu8BuCBiSuwlpS+jfl8ybwtAtu8LUPLrB2gzTuCnz5Gj7hS33y+/UuWiEYr8TUmSRUshPL2elshNoFtS4x1rkPtLgKHPIXy3IpF0FmpEvK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjywY3vc; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso2788470b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762790737; x=1763395537; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TgZgArONH6lr9XvODSMICWYyuVWCZCYNoJZs+MKJ66o=;
        b=TjywY3vcQXDoDhOBL2QUPL3GrA9bfCkCgSDkEN0ZkZ6QUTpCX2HfscTf7vUlOejh2g
         yGFpKy7Iv3SR+lxHXIrxE3fIEjJtKsLBe0UAkGofwtSPUihwUfEN0JpTE93NTf7XpPt5
         WjlBK0qsBbipX+zh5dUAy6p/Tn/ay/UbU+vmReprN4QBeRJuPTLHloueGF/yXZd/7fb0
         M2DRdOrSsiyNULogKUUgFr53pA9Y3sIDfURklD0RF5RW6XWY6sLeqa1z1JxBhHAnZqfD
         8jT9emaNuxMfzvFBwLpzcxfSE0/IUWRN5D0MAxLeygtGdoQBGl27tx5cH17RaE1oeBTm
         3pAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762790737; x=1763395537;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TgZgArONH6lr9XvODSMICWYyuVWCZCYNoJZs+MKJ66o=;
        b=VrVpRM7MiHjnBRa8FX141D1r4hD6wKHCkbqwP1RPZOb8yK7BPZUUznkkeBhMFk2BrA
         rkNXhMTwzbUvyNeNK1WznhCocs2iMBZOSKKaiR6D7mlddgkKiH1Wx89qt+rbUipW9eJG
         ZvNg9rUJjA2Zj7K2amWb68xThtaSzhgJQbBoCb8+TrnombWDTalNqp+Q2LncGG2bUETb
         zZSo+cMYuGQW6st+GBpCji45Cex6F4BP/OPb+ToZu2guFZTOteRwFJRvl/Yn/bdBmli3
         ZEmTottj1p7I/01dtbpCP8FYBNzqBoOKNy4wcAfef3R/O9obrL+OtMjrtKZaCMGm38eb
         jFKw==
X-Forwarded-Encrypted: i=1; AJvYcCWvPGM3saPUE8o0mBKpMXhEfHbg+4Gnf2E2puW2cUoj8qKuuCv2tJbIkE98oh+x38SioOPrDVBtYGeydME=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYhRFBnIq9owLmbKtjgviA8nK9NahyVnZ0+hkUtTyhiGH/POXe
	KgOPzYjg2zRp+D6nzQ9QWo0e+wqRxJgXKxnp06AGuxYJU9Ou+htSYiAC
X-Gm-Gg: ASbGncts7+NibJ9DBNrIAQ+cGVVSw/ES4GT1O+BnoYdadMGR20IYqrs91ZwXzIqksXi
	yiuUS/c+xnQHzF98y/Bt+X7yX4M9sEo01O4UOkXH25IqJ36v+HrUIIcf+b+Kx1C6OO7y/Llr+Qy
	L+hePm/B2ielDUkiqDTFEAYL+uTCGcF7TtcXUXURpqHjUJWCXFyg50HD0fzDStP4sHlXgAkr23s
	subk2YTfM0d0Cg7VAEhSF1qbq146OXIWxMnCe/eHliGN9Qw6SEsmKiJ0oCaBiQybri5T1WKy/Ab
	PT309d7DWb9gJ5WUz4EVkKCVYLhZGstjZXduXyVxXGH9xTdFG80vv0fsQG2NLP8r9Ew+T0X1+HQ
	NckQZSmfTfdYPNqoc87BjVzOh8wKpkIQ73fPRYCfdKMoO+VuSMaSyW35OC8SkvuBhGFUtGK1mWx
	bSndfRnlw=
X-Google-Smtp-Source: AGHT+IF6WNNBzThjDgikYB/HqeiGseOlAPwbhWtHTRN1quM7bZZi7LqL9mv+idqwSvzAApOMFvrtbQ==
X-Received: by 2002:a05:6a20:1584:b0:344:bf35:2bfa with SMTP id adf61e73a8af0-353a31550dfmr9952656637.33.1762790736506;
        Mon, 10 Nov 2025 08:05:36 -0800 (PST)
Received: from localhost ([2408:841b:d00:77aa:3e0a:b50e:a68d:6665])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba902207227sm13072965a12.33.2025.11.10.08.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:05:36 -0800 (PST)
Date: Tue, 11 Nov 2025 00:05:29 +0800
From: Encrow Thorne <jyc0019@gmail.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: spacemit: fix comment typo
Message-ID: <20251110160529.GA18666@hailin-HP-Pavilion-Laptop-14-dv0xxx>
References: <20251029-b4-fix-ccu-mix-typo-v1-1-caddb3580e64@gmail.com>
 <20251029223337-GYA1549833@gentoo.org>
 <20251110141251-GYD1651402@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251110141251-GYD1651402@gentoo.org>

On Mon, Nov 10, 2025 at 10:12:51PM +0800, Yixun Lan wrote:
> Hi Encrow,
> 
> On 06:33 Thu 30 Oct     , Yixun Lan wrote:
> > Hi Encrow,
> > 
> > On 00:05 Wed 29 Oct     , Encrow Thorne wrote:
> > > ccumix.h was copied from ccudiv.h and the comment after #endif was not
> > > updated.
> > > 
> > > This patch fixes the incorrect comment to match the filename.
> > 
> > Just describe in imperative mode, see
> > (since this is trivial, I could amend it before apply the patch,
> > so no need to resend)
> > https://elixir.bootlin.com/linux/v6.16/source/Documentation/process/submitting-patches.rst#L94
> > 
> I have no other clock patch queued this cycle, so how about you respin a v2
> then let's ping Stephen directly for inclusion?
> 
> for commit message, I'd suggest simply as below (short/clean, also enough):
> 
> Fix incorrect comment to match the filename.
> 
 Thanks for your feedback.
 I’ll send out v2 soon.

 		- Encrow
> > > 
> > > Signed-off-by: Encrow Thorne <jyc0019@gmail.com>
> > > ---
> > >  drivers/clk/spacemit/ccu_mix.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/clk/spacemit/ccu_mix.h b/drivers/clk/spacemit/ccu_mix.h
> > > index 54d40cd39b27..c406508e3504 100644
> > > --- a/drivers/clk/spacemit/ccu_mix.h
> > > +++ b/drivers/clk/spacemit/ccu_mix.h
> > > @@ -220,4 +220,4 @@ extern const struct clk_ops spacemit_ccu_div_gate_ops;
> > >  extern const struct clk_ops spacemit_ccu_mux_gate_ops;
> > >  extern const struct clk_ops spacemit_ccu_mux_div_ops;
> > >  extern const struct clk_ops spacemit_ccu_mux_div_gate_ops;
> > > -#endif /* _CCU_DIV_H_ */
> > > +#endif /* _CCU_MIX_H_ */
> > > 
> > > ---
> > > base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> > > change-id: 20251028-b4-fix-ccu-mix-typo-038c19fe30c4
> > > 
> > > Best regards,
> > > -- 
> > > Encrow Thorne <jyc0019@gmail.com>
> > > 
> > 
> > -- 
> > Yixun Lan (dlan)
> > 
> 
> -- 
> Yixun Lan (dlan)

