Return-Path: <linux-kernel+bounces-819283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44555B59DE3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35F974E25C4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14259283682;
	Tue, 16 Sep 2025 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3FTTHf3"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2082131E893
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040858; cv=none; b=RybOrSvJur0PSHsQBWpolVXNX0vspVcczUt0yrVcsJ0qpIaK/n9hYJtD6seziD0+V82aE7OY0wgpUuUW2WYM/Om4NFtCYEOYBp5HcBAULUg7D0mq1UMd8kFfoxerrVID0gnE3CSbKOGBGUSS6OsTkOrO+GNc6jLF1+iWZtTAdDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040858; c=relaxed/simple;
	bh=g60Tzjs4O5LCL0qg3eeCW1cmWOXfWP3kS/U69raDg1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/LWRvbuBwp7hkRxQsad1HmQ2UWutGwCc3BUaJJ95NboYUT/wHWYU59IYQChbYiAsA8EaURbjyNdhUbPTM5oMohjz/5Bms/xyPH0rZEPdgEXUpX1TjHSWQZj/1VaZGflQkCTr/ZZpVClukM0mAmWX6mCNXDjjQFTPA94zskIkaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3FTTHf3; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-329b641fda0so716823a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758040856; x=1758645656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qT6xFwbttKqsz3xIF+BEqzCBG7ZO/EJyLZpLfjCbqc4=;
        b=k3FTTHf3+2kufxWFVJXESsrJlP6XrpnqvnYTzeAuBmXvYLYauHUGo6evLvIsXUiJO4
         yYdVfwdRDd3yIwdakMGgMAaoX5Hian3I14RxuiOQjowMa7yyXB3V2pMGmuI45v3pOdZ7
         lDGcCgIVIaRk8dtBXdYO5Sje8P59zFV70nacSYKGBa53L1NrCZLGx6+RoIJ8pWvmPZov
         PtoFFkvE1F8nlZuhib3Nkdr13HNfnNYGpSDUhwFA7WULRMAIw92RxNFqVdzyHz9hCLgL
         45cXiIDFBa7+vgfC8lL3AJK7aeTywEPxNzKM+gv3tKFlmH4BdS52BwuxgxMC+8GJl2CK
         uO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758040856; x=1758645656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qT6xFwbttKqsz3xIF+BEqzCBG7ZO/EJyLZpLfjCbqc4=;
        b=uKZ4QWZygYkEbm1ev4TFGCUu4wicHr9OTY5kGDDgPDt8maklSvxK4RP38OVvVeq7vb
         aEQILqu+eRw7f+g5qmn+OoLDzg5q8Tms0dsbynUJ28hWK9MMH2Vmf6x+O/KxSBUY9enr
         JG7xlPntcVW6rfiOhtbBPUzVSPvMnAih7jnWb8aGaaZTytMPg1NJOYy1+YjyYpSsjnhd
         VILmEUgQsN73Wat+MhzC3IRhT5ka861wy+r6rNcuOiFjMgzNmy98dr2w0aO8N07o9EKD
         fVD08xSwEfweOgPC6TtFiljUE7z/RK/lr7CFiHeKq44hPawHvv3EeXk8RWYow6C9iX7Z
         SZjA==
X-Forwarded-Encrypted: i=1; AJvYcCWEJHtjOMjp08gEnjYTVE42aMw/oHFyAoeP9xxidL9mSQFrEymw/q7sKEzy0VlIackB08rVcpYd0l4sN/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDwJva/+LX0Qswjp9+GDbq7ctfvb2s00qZB74zA4Fylws/XoHS
	NZORcS3a1TqWEut2/K+Kdfp4f7qHS1JsL4mnFY2/qYPExjwSNQK70B5dJg/meqD/NfOQKVcoSjk
	rRn6CQcL2+QKXBXYo0jRHwQwkOfMAtmdc8eeeHVLwGw==
X-Gm-Gg: ASbGncvYGlGQSweX6eDq91ogcbepDx/6Z7puwxDDwTWl7QhQ2I33hWsA6nqn9oNNQhQ
	pnSA3cHNRITPj9NFyhWpzo5tfcvsGATSsXP04Low/cUBmM77ehs0JHW1Bj9pDUo4ciWovKty2hl
	V7HFWNWz6Ewu8gf26WxFgv/XTv2OzQE1nUo8H6RwxI4zs1U5TnwjgWojBnwUyRF6OhfpU2iKYTU
	rUGv+tP1TG9IjaxRKfVBJze9JiAY6h0hQAWEYTk3YLigIZzxnG+YuT2W0YiF/eXkDMGECsKjzs2
	GVj1Hf5E0YkC+w5NKP4JcpBOuQ==
X-Google-Smtp-Source: AGHT+IGBabsxkqsMdP6Mj42hWfXp0yd/NwdNGOjJPOcIz1HAPNEo2Rfj6PVd+Epk4FzX4D+qrBYZPf2vtsY7bgWpScc=
X-Received: by 2002:a17:90b:3902:b0:32e:731c:4136 with SMTP id
 98e67ed59e1d1-32e731c435amr4683218a91.8.1758040856362; Tue, 16 Sep 2025
 09:40:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYtT7HNBM2XBbePeZ-Fw+ig7SJ+JE_NpQ1VuHR_TvAjX2w@mail.gmail.com>
 <CA+G9fYs4JB0ngq+aryXHVQSq-f05cb4agCfyM9zN0SgprQf0_A@mail.gmail.com>
In-Reply-To: <CA+G9fYs4JB0ngq+aryXHVQSq-f05cb4agCfyM9zN0SgprQf0_A@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 16 Sep 2025 18:40:42 +0200
X-Gm-Features: AS18NWDpgJqn2it9JPJgJZvek4xILevkaOGq8NT3omdX_EFldQlgE0iGcw_8yjk
Message-ID: <CANiq72==_ch0_7ZD8EEc2AOW7Yz1-b8i2ae0X6xDSkLJy=Dm6w@mail.gmail.com>
Subject: Re: next-20250915: error[E0425]: cannot find function
 `atomic_read_acquire` in crate `bindings`
To: Naresh Kamboju <naresh.kamboju@linaro.org>, Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>, lkft-triage@lists.linaro.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alice Ryhl <aliceryhl@google.com>, 
	Benno Lossin <lossin@kernel.org>, Elle Rhumsaa <elle@weathered-steel.dev>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 6:26=E2=80=AFPM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> Anders bisected this build regressions and found,
>
> # first bad commit:
>  [eb57133305f61b612252382d0c1478bba7f57b67]
>  rust: sync: Add basic atomic operation mapping framework

That is very useful, thanks.

We (Boqun and others) are in the middle of Kangrejos now, so we may
take a bit to reply, sorry.

Cheers,
Miguel

