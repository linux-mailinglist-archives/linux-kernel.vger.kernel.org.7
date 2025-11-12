Return-Path: <linux-kernel+bounces-897368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A57B7C52B88
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 943674FF421
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC9B288C86;
	Wed, 12 Nov 2025 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HOojiRN0"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BE82874F5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762957174; cv=none; b=TiHEvtKbCvbq9t4/tIXD7QzfDvlvBl/MbLPQOw/wex8neUvgvCbCwiFN2lcWHYKFKbDIdAoRgB8WMi7VnrXVWqIg3pK4hO84R004VS11KMZQnOzI8La4ve6whfJ5kYVlpIhIHsN53g1yi4ULVUa+OfY1y/+URnXcvZq2YHdbG5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762957174; c=relaxed/simple;
	bh=uX5B7oEczn2bUdHHHArRmF55jEBeNfywi0qyC5aprAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=BhpiyQwWTDZ7EkhtqptDsUiu94wAs7wR00yEWOh6oN/cW9ueqGoKIL4yPcYdO3E0zu8O4DeZUdLwR4qnpJskcCAsl3zWIkOyG7ro1i+bis6pDD9BO7sCmaSA54et635qFmDnz7E/RXnKzmxh5+kJ6jK4hxTXGHdr1HsgRnOxURc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HOojiRN0; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-37a2dcc52aeso8320011fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762957171; x=1763561971; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uX5B7oEczn2bUdHHHArRmF55jEBeNfywi0qyC5aprAU=;
        b=HOojiRN05kRYhXlzRzsPMm/OG7sIguFywGXul6H86dyIAwevsjO9LEw4l2+ZpOhp/U
         BLBuvaoZXH4g/WIdPLQUrdFbs1+AGiHUgCX3qCl7COof13Tj6N5jDWJnXaowXI50zM1t
         GIuL11xY9gOYC+Ub3HtqulK+BSsjrZSl52bYQFwMwNTNBN+ySorMv1TUgqYuO8Dydui+
         Erhhm09IWqEWutCE+xYOspNSmp6DXV+x0kvppoPtAKCBGH487pfFaRjNeBcX3ZGHqDEW
         g45dbXzzREZLJNf773VwcLeFdzR/1AnD9herjelxn/FZlp5Cg2m9Sh/ExoDs8C29uQs/
         +RIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762957171; x=1763561971;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uX5B7oEczn2bUdHHHArRmF55jEBeNfywi0qyC5aprAU=;
        b=cCDdnAah5qvEXmhmQsYZustwW5UqVIJv5WD6YruDf9MVSnZIqdYziQVzOkbZ874PyE
         ffwTFUuDoQT71aPnfXdN8u3B6zpSqMtwfPyuCfkpygiekYsNw0RD4Ms1kWdhwrklaGLl
         VtEAYxLbHMJQ86G8CnStBKk+l/v5DqXQ06mG/gciPC0muVS9+Becnc1vnjPtst/2Pmov
         yClGgq1ojFEv0U4ccUD0PHoyJbVuffNTLvi0lEkffeUUtsK6rRa9bWK1oS5TRs2I+zPU
         4bjxzpu9M95grJyCGst58qLifAkIwY3IjLKbpOdrVzXz8ZdYTmgm40b5AReCelpAXNLH
         FBjA==
X-Forwarded-Encrypted: i=1; AJvYcCWN44VFQ39J/CuLJt5jZ6EXBuViA9iQwvfVA2Gsophj1S5YvC7hA1IEk8F6XMzlyLoLTa7kXheBhDuKzPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyItYMnmzBcUXvzwqibIz45P4Eshr79j1xOR1QsDztxV2wkqu0y
	QDahy0eA+JdDd7znmRFFMlP5aiF+jH3CeN0xkL7t1pMm2aE+86P2dGCFOGWlDxanJpbwPOQkbjS
	Tmki3zkw6LgL95LcyyAUobSEc9dd4h/sF4QPiaTMg+w==
X-Gm-Gg: ASbGncsRPlVhVQLbL1iyRg3+WsQpf500M9Dq49mBbwgimAHecwIbtwq5nFnJrFZm+G4
	4CvXqn4IGU8wW0liEYd6p2AaXKn6ubkMj+P0djKvCVoWkwgcQSlijWkT3MsUHmlVUoMy1fYpZ7E
	fx+vk9wkzVZCfqjUZfxNmsY7Tqql4fWp3Rg7bkFW0ZUhqlZ5/KCwy1J1Q1b72ARvh1GpiWhopNy
	FfzkYarqx2vENxeeKSdpizccMm4+H/FkHajqR+T/3yZ/3CvqhyJHh5n8kpzZdeXqTvCzf3U0B+q
	759mdKy7o3loTSwvMw==
X-Google-Smtp-Source: AGHT+IF+0h/fiUp/hWUZc3OVuqU23q/y/supTU0v4KoApZKNc/i77Tjx4CfdQWEk/Kr0uviwyjtpBjnQVGZMcgloH7E=
X-Received: by 2002:a05:6512:230d:b0:594:18cf:14c6 with SMTP id
 2adb3069b0e04-59576df8fd3mr1113738e87.21.1762957170710; Wed, 12 Nov 2025
 06:19:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112120125.124578-1-marco.crivellari@suse.com> <20251112125600.GA325192@workstation.local>
In-Reply-To: <20251112125600.GA325192@workstation.local>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 12 Nov 2025 15:19:19 +0100
X-Gm-Features: AWmQ_bn82_nUPJw0_sKmy3DZLnIy38Ef2zar9XL0ESqnDfglcZ_-zkFQRaUAmWw
Message-ID: <CAAofZF5ehRci5L2e2E+p5AsTE_C9saJ4Vc+54j4-hYOp1pdi8A@mail.gmail.com>
Subject: Re: [PATCH v2] firewire: core: add WQ_UNBOUND to alloc_workqueue users
To: Marco Crivellari <marco.crivellari@suse.com>, linux-kernel@vger.kernel.org, 
	linux1394-devel@lists.sourceforge.net, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 1:56=E2=80=AFPM Takashi Sakamoto
<o-takashi@sakamocchi.jp> wrote:
> [...]
> Applied to for-next branch.
>
> I'm sorry not to reply to your previous post since it did not reach my
> mail box... Your v2 patch is a good reminder ;)
>

Thank you!
No problem Takashi! :-)

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

