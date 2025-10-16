Return-Path: <linux-kernel+bounces-856392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2781BE4083
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4EF2734B929
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF5C3314A0;
	Thu, 16 Oct 2025 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G/viXrqj"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA554334374
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626523; cv=none; b=j6++sfK9JQ4TDr1FIB6cYs94qIY93tHJ1U57H5X9D9Uk45kawA+fETsw7FMMEexOEuuhN08MXpMLw/KwnWdhbcQ2D8NuGvT6M8ctVi6DXcu1N1WAx8m6Lm2DnQsKe8mXk+67J9cAK4tjZhUuEaJCnLEEMdjcYj6LGwLnzNo8AVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626523; c=relaxed/simple;
	bh=pvsquU8tGY1JF80cphk4TTfNj0qIiB5NUqwH9Ox+Hbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/cjiZgmpF+94g5HWnpEE9atyomcZynLI7BU8sC2H5L43CChivYLJLB+2HoECnoS0MaX0jIqbgv37T9M2u7++7Zq/RDkksYseScXWBQhtjxliJJiM1JzPTBOmqxC3gfaUCdFO3Je3ii1fbyWMP+fKhVo42Rosg13yLfggOOexXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G/viXrqj; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-363cb0cd8a1so9780981fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760626519; x=1761231319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O94wCM7ENl4SRXZGXa72i7D3gKwgEyHoGFJrIvqxAiU=;
        b=G/viXrqjmwotYeohg+byKns6lUm7dUE1U6rlQAExKtTIMApgAJqhBGOdr+M5anbn2c
         naG8LgskoYUhOWtda/PuZsARR0oDIApDRpAtFywkFJYZiRQGsvN1L3hvzVKWG7sq+RWj
         qv7yT1qUsdFdzBHq803ofU8sI121818s6VxCTQl308Pl55uN6LllXfOyE6ggruIM9yI3
         4UeU8k8Qju2mzncyTcpeIOzW0nrnZuJFkQAKGV+Te2naLWMGylxa8z1GsHwgJmEDGKXP
         ibyzWKAJJTRmRwwY/jxvwTvlvI8t6Y91ZAy9LIVBC/tYs4MeHV0ZnKakthMnZwZIMw+K
         1qTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760626519; x=1761231319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O94wCM7ENl4SRXZGXa72i7D3gKwgEyHoGFJrIvqxAiU=;
        b=fw0/4V5mREQGMqMB8UAG7DAZjlvcgtrcWYPstNtzmz4p37SeNFSu84zaqqyTNfddUp
         rhr9gOotSSADjBe5iRtNMBdH1p1d590Y1jCDemZAEBtOZrWiyVCVhlFWgrKV0RF2uiIP
         Igv0l0xrcv97JtyYDd9WrgJLjnW0AOSGsvoOI4JYe9NvKfdPNk6tV9I0u3bR3WDbi6PR
         FSNZjJiqljHYLOfKnFarXEvbD7WLSPoNoEkaZ4e7PkXajihvMjfYkRNWa1Ij+9MnATpi
         sKhvQGuLe8PYheobFc3HCG/4bjVl7Kdw+H+YRqYw3SQ7eEbw6TmzTlo+SDNDlux5gTJo
         ZfgQ==
X-Gm-Message-State: AOJu0YzsCirU/EjW7BV98mY9E4BN93r/s6TvRDqUEQ3keFHuZzfh9zx7
	VnsoaIarezB1Ebo5UAwbSbpKY3CY1BkGKqy+lDqMkOWC5ZfwlGR52xNR+9FhWDeuMmOXS3vNxHs
	uglC1hk/hieHT1IxYBNeieD1XMFGxGfNG2nQ9+RMs5C4YG7S6q5kM
X-Gm-Gg: ASbGncuSWIAvKfjyg+0pTXKx5j3eq9Xdobitl7lrWB65cVJLttn/Q4y25J3WmCLqG1L
	x1o/jz9Zw4aH+2dOI6yE6jPEgCGFlC9ytqewpT8xdIkqdpgNkaVtXUa+RWNp3wHRDYLFPP+lcO7
	1CikrENjhYQj9VNgcbNBVY9k6LIbwF4U123NmaCFT+msrOEnIsVS/r3DiZaXqcbUVmV1B17UiZI
	OGOBDmKPPmngZdRyOjgzYBPh+3uUNBWxOW+MZSvBFrgHi7xAfCyAZpXh/pbwkrw8h5F3tqLVzUP
	olNU9Z7x0aUgP9iDWIM8Rsaxm6mtmp6R6TCjm74=
X-Google-Smtp-Source: AGHT+IFutsmLksDlRv39ba1T2Qp3AEOmNxHgqp47Mcd1iJszMBQNrphoW9pRQxjcsHIRxiKnVcj0/rw/sqd6v8wn7e8=
X-Received: by 2002:a05:651c:982:b0:36d:86b8:c57d with SMTP id
 38308e7fff4ca-3779772ac96mr2035941fa.1.1760626517659; Thu, 16 Oct 2025
 07:55:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918152517.361773-1-marco.crivellari@suse.com>
In-Reply-To: <20250918152517.361773-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 16 Oct 2025 16:55:06 +0200
X-Gm-Features: AS18NWBsAlbztMJ79r3m-tpPttHsdSbrsA531nWTD2pZ1WZyjSF3bFpaOnO64Dw
Message-ID: <CAAofZF7Sraxs+Oom0Qh_rJ6F_TO74jG9O0dC707yUHhpp70LdA@mail.gmail.com>
Subject: Re: [PATCH 0/2] wifi: replace system_wq and system_unbound_wq uses
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>, 
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 5:26=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
>[...]
> Marco Crivellari (2):
>   wifi: iwlwifi: replace use of system_unbound_wq with system_dfl_wq
>   wifi: replace use of system_wq with system_percpu_wq
>
>  drivers/net/wireless/intel/ipw2x00/ipw2100.c   | 6 +++---
>  drivers/net/wireless/intel/ipw2x00/ipw2200.c   | 2 +-
>  drivers/net/wireless/intel/iwlwifi/fw/dbg.c    | 4 ++--
>  drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 2 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/tdls.c  | 6 +++---
>  5 files changed, 10 insertions(+), 10 deletions(-)
>
> --
> 2.51.0
>

Gentle ping.

Thank you!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

