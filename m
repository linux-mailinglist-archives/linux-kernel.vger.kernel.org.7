Return-Path: <linux-kernel+bounces-774627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BE4B2B535
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 02:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A0B19634E9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F08D18E3F;
	Tue, 19 Aug 2025 00:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dCBBE1A2"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7114A11
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 00:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755562044; cv=none; b=Lqhy++31v5TXJcfS/NwGJCGlnAUhm39ppMaQlSxG5g+Lf/EcVgOhSO24YlVzyGrf2/D2NEnB0Zo739vlBYpQCMOKBWLp0AgfTt7OkjDCqHo7SuKh8LGMJ8ssdhpgh5Xry7f7AHrhZaB/v0oJ3BBqfsocn04HbcGnoYXm/KiASgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755562044; c=relaxed/simple;
	bh=N3pRRETvDbhldeHYBaWwj/U2MHd/CSkmqAYUU00fkCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tHON/taZouVJDK5QN4ieLRDdJ+SSvkMZSVe56JWS7pDvGfj3qCUsrbgBqCSivuIvwVTSGsR/wDei3S/ktxTGAMiEOTNVfF4cFqeVt+GBPeHzg5/GPnwlnCyjSKXf0SY8OsZkPWmmqHCdJa1+fUgqyZosIxjD15yoLiVwMS1HBc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dCBBE1A2; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55cef2f624fso2061e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 17:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755562040; x=1756166840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3pRRETvDbhldeHYBaWwj/U2MHd/CSkmqAYUU00fkCQ=;
        b=dCBBE1A2MlkuYtxvbmUansJU1Cp7lGhUCpelkoEIbwZIpEUotb9TzosHXI0arG2w7y
         d2CnPU/s2yejoJb6U+HdFxoTAnxOnKWXnuS1Eafb1J8oOKrwYPaslGIvWWlBhLTSarD7
         u/LdkycVgXdTi/A0z3DO9QcIG0wirxP1NG9k9fd+ZZHjdWsGhU14opWx+P1QIrDDtoiX
         Sk2KLyGt/1Kb5btcOOmC+zJOEPXbWfg4kXI9t9oHxkUkVVNypFh2GUvcG9EGrU2IZVOU
         MnjpLmhE7Koeti5BjzbqRK40qL7wgdyZpVZk2LoU5C8NyeE7cJaQrBj32Lk3zQJP7gkr
         F5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755562040; x=1756166840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3pRRETvDbhldeHYBaWwj/U2MHd/CSkmqAYUU00fkCQ=;
        b=K5I8NKBd4xdGqLrOVl2iraWpzzwqCVz6OxiRkCTkaELBANR/5J4sPZ+QhrYkBZRDHd
         AEuhIOH1Pn8PIlMV7t82T1GrXCN6Q6RR9rqiHZ1He8vGVGbxZQ8tWh3WOyp+JqhUXnxr
         49q/rk++Ut60/uVqx3QTZYiQsQ0uOTfLMU/0Q494CWMOvPquVBAK63lj4Oc6k+NIJb0T
         m3U54AsOFGbLtNoZIOMUZk3c2FSfCW7qclrZMig2eIZweS0mA93oXKkEAF2vFV7bz1Ii
         1V8UDZ7/DpzLhRExjQBu0BQ2We7xALucek+TbysZXYW5On9Y2nOieKhOfR2oPHDczQkc
         f66w==
X-Forwarded-Encrypted: i=1; AJvYcCXzZy+XRJ61LbjPwooiYD7ddWtHrmoOBYHpOsR8tdUK7lbyQN4JKoMY7psZkr1n8qRH43NTXJ3+SI8Svm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUwy4Av7GHkdoxnaTdT+BxIgZMnW+STzDUVTWupd4DJnuzPsPC
	626iJhXjUwEVvs8Ra7QRonT7HJGc9bqSugrOoCbdHWrSLS+U32P1P2JNak1qZrZX123jv/7pRs6
	9pA/fHEws8ACPCUBpAezHWzYwGM261nLr1mBBrrAF
X-Gm-Gg: ASbGncsmNtDo0dFdZFxodLwCEJGPFnWOw0D77p76zFBRylO3+NbZlOE+7NrqeWO5VvB
	Yce6KfBTGoCBTYK9MmmakW06a9N/v12UttwgIGu9YQ82I/bnuXWLjKJ1bGSnIIN+MUQOmp0isYC
	c7axngiPVDLlwkA/4cxT+z4fws/Sk5WQlXUrlt+Eh4KLfuqxx5yMc+c0GQ2cgRvnZAlxxy/lvD9
	q7GlT2bcbDMGCmYbONwXlT8xvXKXPXGNnSAgcw1LIZhIWBnSqXaHUk=
X-Google-Smtp-Source: AGHT+IH8QR9XM3HVwygeTPkrgKju8SNdrS1lWW8eUw7kKiB8f808XKy73VlR0zxzRFL1iygyhjeNQ1MNS+CqwEdg714=
X-Received: by 2002:a05:6512:e86:b0:55d:9f5:8846 with SMTP id
 2adb3069b0e04-55e008bca39mr96231e87.0.1755562039838; Mon, 18 Aug 2025
 17:07:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755499375.git.asml.silence@gmail.com> <d36305d654e82045aff0547cb94521211245ed2c.1755499376.git.asml.silence@gmail.com>
In-Reply-To: <d36305d654e82045aff0547cb94521211245ed2c.1755499376.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 18 Aug 2025 17:07:06 -0700
X-Gm-Features: Ac12FXys-FgbC9QrXib0NwGDYjFEejqhlssYCN6AMvN6gxmzcokZAnqcu_SvM8o
Message-ID: <CAHS8izO_ivHDO_i9oxKZh672i6GSWeDOjB=wzGGa00HjA7Zt7Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 04/23] net: use zero value to restore
 rx_buf_len to default
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 6:56=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> Distinguish between rx_buf_len being driver default vs user config.
> Use 0 as a special value meaning "unset" or "restore driver default".
> This will be necessary later on to configure it per-queue, but
> the ability to restore defaults may be useful in itself.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

I wonder if it should be extended to the other driver using
rx_buf_len, hns3. For that, I think the default buf size would be
HNS3_DEFAULT_RX_BUF_LEN.

Other than that, seems fine to me,

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

