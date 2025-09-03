Return-Path: <linux-kernel+bounces-798361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B98B41CE9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5D601BA4C78
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B622DA774;
	Wed,  3 Sep 2025 11:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r3+xe0jS"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7112E2DE701
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898334; cv=none; b=QKKAJUVXQPwJr/aREWZ3nZ3CHxQB/A6d10k6/je/SuMaGfiDBYQHyDKbS6XMy3CN6E+ossNCJSsy/AwKIGKec0JEI0JvraiNsKgO07N/naNttiX2ItEthr/NgTrlHP34uSGu0PpiUc82aDdBzbN7caz4oC/rI09elsjZgyJMmHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898334; c=relaxed/simple;
	bh=wQiM/5AZS8Rs9dKwc19dQHM6v3kDpVefyLPtNeG0C4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvlG17jFAKqOk5MjtpxM5OzYzO53hXtsmjso6nqrd2FIjjk/MIVdrXgsIL2WRYKH0YZWOI7PZ43Rh2j2Mo1Q96B+dGlmAold3e6mwSO0ByCP5aTKNNsgRJXJ3E8jeEF0oXslfYHPA0V1bFRZHT+Nk6aN4/nh4V/sskamJnOkPFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r3+xe0jS; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b38d47fa9dso11259181cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756898330; x=1757503130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g65usQiEADiywraoPq3aeiL0ohX+1gqW8ybEa5s0ySI=;
        b=r3+xe0jSXqKImdG+ozNYwt2xRHgya4iJQVrTQflJLEFK9lGpOp9Ui5y8S/xNzVi+Ix
         CEuFIVadKR989jjJG0P+Cmw+QPxSH0cM+H9PaeudDEiv3Lel3n8dPbN05gpiKBxJNjja
         8Eoyn3rA/C8hjwht46Osl/u6NARZUyDm0Egh4aDIZf9daV9aVvi6t6ytkz+BtXjcNIqL
         ZhkM1filUybaEPztEkybGcG65QvHRTaxAWIhvbG/5VRFgy4pSDHLnGBEN7OFj1ZDna+I
         y1r+jDBFGIefQ71/YBVk4jaay0/SkWgKvngNn2Fn+fPUZO9ineKbSDWrzBkcGVCWRQs4
         pZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756898330; x=1757503130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g65usQiEADiywraoPq3aeiL0ohX+1gqW8ybEa5s0ySI=;
        b=EjAhtXX50AwzUguFjrJ9tJH2W/0f8NRyhRGDGkECAGFTs/n6EqTaxAcAuBCzVtk3Z1
         UTURgm3Yh1PGXleWPT3keZMGUNcquktYApzY1irl4I/35AdzwZCYew5SxKMalvNDoADH
         cjXMDUQvsXzC2DwW9iLJjffZek2woalqfhgu1oWJfuKjveG76VxQOFsc9VqQkVzF5CWd
         WcrlgWNeX6uDd3IYR2V7jHWvkkYtthwxR0un5wAr0stx0TxtFUw2OmDXpcuUGThE+lfh
         nWgyX2K+oDnurSEyEoc88OxnCsxORP8sW4Fx++wkZiOlW0lvqX1yM2o8jRpvcRA1i8qH
         TgCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVjzwuq4dsOQK63NNe+DQkh9v/4qdWTssdt21gyQJ6SIujdimTlqrHqas/wJyDOusEkMAXUpA2lLM9+3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYAGLBT/F2cBK2Ba/y0LoePBJ7okPzPtyroA/UkjO/RwwLjtdp
	H9zr7TkkvQthvf9fHK2jAtmvmrbbicWQOlAH/gNYpPtyQtm3FTy/wuuBUYmY26Ggpb+6HczSC6s
	m7Nnla2JjyRpIjdALh3prefSqg5qRWqQN7mb+FR1a
X-Gm-Gg: ASbGncu01qBDAV+NzMvDlxqTBSRzOeJzASN2f1nAC6c7mVxtpw66p+iiM4pKjE72vec
	AAapgOkuMKgkQut7NURmqTjJGH1lQLxUKkbca7+VzjF/8jIWof3PCM7izDj021l9L7Vu22gZMff
	8F4TtgchHx8MrSAYi0ntxlyHGHS2oO1rr/smQnB/PRfrPyJktciGJJlbOHwpcds2ibMA3FxsN/Y
	4/S42UVkezH3iet9qWOufsM
X-Google-Smtp-Source: AGHT+IG7T+o/X0aqJDtHlsUzsDC+Wkotc8u0nlkLWn9pGaI8xqUZoO6jGHO88KFm5axoLJRxpmQLqYaZHmrlg9EeFIk=
X-Received: by 2002:a05:622a:1a8b:b0:4b4:8ec7:2a34 with SMTP id
 d75a77b69052e-4b48ec72b50mr28090041cf.4.1756898329940; Wed, 03 Sep 2025
 04:18:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903100726.269839-1-dqfext@gmail.com>
In-Reply-To: <20250903100726.269839-1-dqfext@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Sep 2025 04:18:38 -0700
X-Gm-Features: Ac12FXwYWjMG9LIOcl_3Pd2ndTXw74bH4r6NAmReUG5ykZjRGoGz9MTaZaZZBGU
Message-ID: <CANn89iLKpJaF0VcWxqCUuouJw8mZ4Fjk_cc89yMmuZWCLx70-w@mail.gmail.com>
Subject: Re: [PATCH net] ppp: fix memory leak in pad_compress_skb
To: Qingfang Deng <dqfext@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Paul Mackerras <paulus@ozlabs.org>, 
	Matt Domsch <Matt_Domsch@dell.com>, Andrew Morton <akpm@osdl.org>, 
	Brice Goglin <Brice.Goglin@ens-lyon.org>, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 3:07=E2=80=AFAM Qingfang Deng <dqfext@gmail.com> wro=
te:
>
> If alloc_skb() fails in pad_compress_skb(), it returns NULL without
> releasing the old skb. The caller does:
>
>     skb =3D pad_compress_skb(ppp, skb);
>     if (!skb)
>         goto drop;
>
> drop:
>     kfree_skb(skb);
>
> When pad_compress_skb() returns NULL, the reference to the old skb is
> lost and kfree_skb(skb) ends up doing nothing, leading to a memory leak.
>
> Align pad_compress_skb() semantics with realloc(): only free the old
> skb if allocation and compression succeed.  At the call site, use the
> new_skb variable so the original skb is not lost when pad_compress_skb()
> fails.
>
> Fixes: b3f9b92a6ec1 ("[PPP]: add PPP MPPE encryption module")
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

