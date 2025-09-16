Return-Path: <linux-kernel+bounces-818049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DA6B58C17
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BBAA1BC4221
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394E4242D9A;
	Tue, 16 Sep 2025 02:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M145WT4S"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F10486353
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757991512; cv=none; b=GKqRyoEOk3FqOEIcGX9eloigO4nUKrEaOa0Tfg/v2OlP3KB/KzryBo9kfAv942mYWuvbI88wJR3lCE9nd+jc2IzlRplt4QP5uVYs3qlRYi1dvfe8LnE+aVC/RATQsvtnmoYStmd1ZjdEqWEfV2+Cdbz6DlBhi0wtxu4H8q0D3rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757991512; c=relaxed/simple;
	bh=0WNzQt6DCc1oCSopHUcGNsX0og3Qo+mNU8x/1pWS9J8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DbmqCs5slVL5XuYJag3qBW9rOsbhzJCjaJN4Lf9ac8wdeRRINIZA2uS23JskUpvFbeSXRWIGYhT2iUuE4fRvw0JaRfYRvvUtZ42gB7GhW+Z0aWGFm/+1yHBXQ7HepO8VLwpbeo9h0om1uJt82uSdR+YKL0wJCW5wDH58Vi3kDKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M145WT4S; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d6051afbfso36419147b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757991510; x=1758596310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WNzQt6DCc1oCSopHUcGNsX0og3Qo+mNU8x/1pWS9J8=;
        b=M145WT4Ss1/MVQpODuXyGL91Z4sDRfDXG2y17ZS4Nbp3xb3TfZlQZ7rDnUykYpKF5L
         iaSeF3CaoRjRbg+eHPDEB0W2sFRW4oifb1ZfQ6zlnndwhd4Q6Khnfw99SIGMGX2ReYNu
         okUOHiG/f474zdp6NgauRr56mY5PQXzmRGIsJtYNKPUJibH+uSIFNxLGgna08wx6Sp10
         gvG4q+NLtj2jligTfx1KxGLIZDoCPZS7lKiDdXB4S9U5Qi9Tj5KljnEf2h3Rx128tgHD
         222jY22ZpIUovH4MLFp3j48HB0laWzhs57bPzVtrQXaNMYY2E0/FgLtDKoxsP+RpIssD
         ibKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757991510; x=1758596310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WNzQt6DCc1oCSopHUcGNsX0og3Qo+mNU8x/1pWS9J8=;
        b=oX8juoTkALucyouLwRSzOSS/Io4kUr1gAwpminN0K24cOuTZVTFhoB2dFjTjuXAiSn
         ybABG42Nh3zLIbOiJWGJGwP7Tq+b7gLG3Pgm0zv1Ttzbio70S3l/8MnuNeljRBzeP7bj
         xIL6T/MJD/vB4dapU8l1rCvh+VFlhraw9wLyeGq0HJWc6w/7jcnQcXqhYHZRTiI/Piqi
         M9Bl+Cbw7GrEoAX8irQlCA3VpNcn9Xf/1p/mPJriOiysE9MUwcPiq1W1ACIgtNHnTeA5
         dmK+QPn1AB4nPObx+X8/LrjBE/EhV/dME5PxtJz4W2VegDLuI3oXU/uxlCPNYO+r5dBe
         IdPA==
X-Forwarded-Encrypted: i=1; AJvYcCUB17+uHjE3e4NqA2VZYoIcF5jXWe1DCLeA1t/sefxwW3jQ/K4yGL/QEI06ZplxszcL7djEIqzyl9H7jUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEBmDA0CydekAMbpeD0HPfaIGfQzomoB+nDWBs/lObJWuaDh2p
	udADoAH14NJ7lskS20GFrQqyVkiFSwNIrzfGrspE17kL46X14PrcGdyiGRynnRtFkqJuTPQ/0iq
	kxh24WF041Abra2yWt32lJM0y+Oc4o8U=
X-Gm-Gg: ASbGncsbpHc2rrL5Se8auhPjeNq7f8OxFHDdKtMxNVkX0No6wABjiop2xWr8T+fK5eE
	B6Cc8cEZM4yqH7m2S+OiBKuc+mS2rbfGYkLZPt4o3f4sBiwz6N8GrEare4d/LcrjkWgLwDkvmFB
	lQE5ys7zlIJZGrZ4mMk02KiyqX7iB4ffl2ObGaPNVaBJra6cb7nS10ZaVFrqAdAwxiU5ka3lkV5
	htHzhiEnGxpsy9yHWCF0yYBXvOCe9vdqE8=
X-Google-Smtp-Source: AGHT+IFoV8QGVxMrnTri70cXeQyLaQNEjmdLeZFLqkE+amnPx3JsydwAPu1HRgnuRf2sZ6BK97hxGf+G6+9fDlrhK/A=
X-Received: by 2002:a05:690c:6488:b0:735:4c38:34 with SMTP id
 00721157ae682-7354c380739mr40186397b3.27.1757991510063; Mon, 15 Sep 2025
 19:58:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912095928.1532113-1-dqfext@gmail.com> <20250915181015.67588ec2@kernel.org>
In-Reply-To: <20250915181015.67588ec2@kernel.org>
From: Qingfang Deng <dqfext@gmail.com>
Date: Tue, 16 Sep 2025 10:57:49 +0800
X-Gm-Features: Ac12FXx5b4SkRyivmeumpyy1hPkwx_2MizrBQEAH_5KP5izuBh4_VosS6gNuxWw
Message-ID: <CALW65jYgDYxXfWFmwYBjXfNtqWqZ7VDWPYsbzAH_EzcRtyn0DQ@mail.gmail.com>
Subject: Re: [PATCH net-next] ppp: enable TX scatter-gather
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Tue, Sep 16, 2025 at 9:10=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> Seems a bit racy. We can't netdev_update_features() under the spin lock
> so there's going to be a window of time where datapath will see new
> state but netdev flags won't be cleared, yet?
>
> We either need to add a explicit linearization check in the xmit path,
> or always reset the flags to disabled before we start tweaking the
> config and re-enable after config (tho the latter feels like a bit of
> a hack).

Can I modify dev->features directly under the spin lock (without
.ndo_fix_features) ?

> --
> pw-bot: cr

