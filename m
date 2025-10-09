Return-Path: <linux-kernel+bounces-846988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449DCBC9989
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 651CD3A84B7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A2B2EAD13;
	Thu,  9 Oct 2025 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="A9VabX1f"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70022EAB76
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021030; cv=none; b=HuF38d2khp8Q8kb5ARRyArpF//SQgC/TRaWp00RfDbyUtr4TOLAlYJXhecWtrn84BzghiZbwIKuKRTMAxoFRk88TK0Ynwy1qhXG39n8f7360Dlg9aRfIL403jZ6qLLEJ8tk0lbOTXo79CfBM6mTuxZ3AfFix/5sumhG8xhMsCcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021030; c=relaxed/simple;
	bh=hRicmbLQWEJ8+bPspecCmobqh1Mt64hI1L8Yhs3vPYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYpY8FhSbi4cAwyJi0SlPqlnYDHTcbHpselveDYTfIRt3sQ9VNWMly8/Ffv+pqLKmGarUwFaSJ4qTxT+k3Kt9UvGUHMqFU+Y/qLhdRdVCPCoHhcwAsFTjUyOiz79ituKCO2/5obYCJ9TACjr8qUuC6cWLWm+6kPc2HarElD/Xmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=A9VabX1f; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-339e71ccf48so1515327a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1760021027; x=1760625827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82eJnEG3a2gfzvtAFqHYyT6W99N4n+MkixpvA8b26PM=;
        b=A9VabX1fKTfAj0vBmzcnMWQSmxIpDQognGLwtLAAFw6J7PvLiEI7zm4gO6hNh5tHH/
         hvQkvFmjtHDA+AmOSpgX6XRaSyT+drTwYh4LFGLenigAy3FQHbOZ66WoW0FFakEbzOWQ
         qTTf9+/mtmQcdkToN1BZLL6xX85NAygIYzvRc3GnIyKLt1qb03/jjwdknFXw6mTvZfCF
         UgQzrH24YklzgNYfH5811xVZTZtB0dN9oyB6dS0DDVzAdEdSX88IrspEH4v73UYnzcmt
         B8xECq99sCToB7tDI1ymkSzPGDoOTJf9/h+FNYwgjYzr9pFIreOMmmxotuOrkCmON4Uf
         Tn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760021027; x=1760625827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82eJnEG3a2gfzvtAFqHYyT6W99N4n+MkixpvA8b26PM=;
        b=d6A2SD76JX9HBsCEJBnraXpJxXmSiwMMJOgKXojnoGcTmd2vLLdAwN4dIm8YCZAB2W
         9q90bNM43dwmg2eYrhCqXvQdUfYLIr16+TMGlobSaZ1H2bcLMdD+dap8SH2Fxy/sFDpG
         tpETtiVc4z8DGAcy0DwteCHOg6Fki1PJwOPB1hi82v+QwbvNVDtjL9rouubD5YHXor7G
         fxyoP23BFS07BbsuvQ8aa4RWOHiYu/Q7xaliO8lAY6vjMC+kbIY5O2IxqUzBFNmGb1JH
         ac4Te6p02NfMMlJ+JMrrps7K+gnbzfEicrW8O1/mCyajc4Y64BEAihIWA5MryWVvjASv
         EhzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1oPHEPqvljicl9tpPlbFhmVkcKago3Y2lZMqgLcLGZM4vZ4yQqJC5qcZ1Eqi8Sbd+hON/UFfQYTwXA78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz0RNHytPlXoXa9tFQXlz4A/ePCf9vGyo9blrpH6gc8L+yB+mg
	C6T9/fOnthk+QWqHI0gGBjPxUDUv+S5sYqY/adWnwvJc/xBiiyTY78MZGispfgEivabOpFG6hkv
	8x1gZqCkiYEL/zfBdcubkommKZZHdInzydtno718z
X-Gm-Gg: ASbGncthu7VlgDTjL0FVAZZo6cEP1pWmtjr2L7bzGxivyei/O3N3VnruXWQv40YtXOa
	adRv/7N9sLxbELr7nmP/m2NKFTQcZOJ8dUIqhxXcuHF4RPey7/70V3TzuuzOxCxizHykf2ZrViA
	JM3WV/9tDfqlhfZx3MFPntmAv9CSb2+gJtkOf9JngQpjjvm1+vaWc7dktwCCsdTEbi6a+wWiDy3
	xErFBGF+Dg2bkgRFiQzzN+XZVh/VEpWiElMT9pFKFdcd0weMtvFz+OMljRoUoOsM7ziayf6GX3C
	raqjrvqkFQFOneZ/08g8cKcJmLsmvIVO7R1KIXiUKNJ30qJdxPwmj4hdiTY2ISIgdJo=
X-Google-Smtp-Source: AGHT+IH805V7OJYS76B/rqvAegpKx0ru2dDHeH6i2pmIfcb1qUFIZrvtv/9KKjkxayYPFQ3wLu7QgWNtfXP6qRGTo60=
X-Received: by 2002:a17:90b:4b87:b0:339:a4ef:c8b4 with SMTP id
 98e67ed59e1d1-33b513861d8mr9700512a91.28.1760021026889; Thu, 09 Oct 2025
 07:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-ip6_tunnel-headroom-v1-1-c1287483a592@arista.com> <20251007183721.7654cd3c@kernel.org>
In-Reply-To: <20251007183721.7654cd3c@kernel.org>
From: Dmitry Safonov <dima@arista.com>
Date: Thu, 9 Oct 2025 15:43:34 +0100
X-Gm-Features: AS18NWBQGRh6-gDD8buab9A_yPyWA20bkiesKGCiJxTSNNu73FtqaTqUrITm5KY
Message-ID: <CAGrbwDQB-x6t6cHS3prVxWXPuOPYQXF8mqUTuzmSn_95SBXK1Q@mail.gmail.com>
Subject: Re: [PATCH] net/ip6_tunnel: Prevent perpetual tunnel growth
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Tom Herbert <tom@herbertland.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Florian Westphal <fw@strlen.de>, Francesco Ruggeri <fruggeri05@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 2:37=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 07 Oct 2025 07:08:36 +0100 Dmitry Safonov via B4 Relay wrote:
> > +     static const unsigned int max_allowed =3D 512;
>
> nit: could we drop this 'static' while we move the code?

Yep, thanks, will send v2 with static dropped.

Thanks,
            Dmitry

