Return-Path: <linux-kernel+bounces-813313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A27F6B5436B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1981B27C43
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4702C2DC776;
	Fri, 12 Sep 2025 07:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H+JvqXb0"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF85136347
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757660663; cv=none; b=rKM/LbH/K2fpLF7uGpkEQCvQPVuXyvKFyn/odux3v09yTB01Sgfy+fALZQtdNebbKFQggMcsHks8o/ZCOqX4j0f/u4da5DPFkMSQ6SzMeQi2PDSFbStl5J6J29k2ywAci3uZrNxtU70SLcj/wpxz0cpLNTobx4sXvpJ6+BYXGgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757660663; c=relaxed/simple;
	bh=q/3azkhASRepTVItgM865PhVwehLOoknq13jGplyT2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5xbyMzedmsGBiBOnlzqgpizptUvexGEunkpzZVm0CVUhtLE4tH+KlnBI3QuF/0WDIw+L8XzR6MmELhGXANpeQsifep3y1sMQObovn5wU29WElCjDOLpOoCQuVLlf8PW7fGu9gYIY1M+rPaHOJYPVPG6738VqSEft23taAVpaAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H+JvqXb0; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b61161c35cso28300631cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 00:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757660660; x=1758265460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/3azkhASRepTVItgM865PhVwehLOoknq13jGplyT2c=;
        b=H+JvqXb0NTY2ziR0DYc9iXXDLkN8PxZJeA27/OMeSJvWepEJy0Wp/qqpG3P/h0zK5b
         1/UyUpMLtjd7x4jR8qaR3HENViubXEgR1JLVutMG0IHUTu7yegsxxlFKITm/yw+Kv8Yk
         9E8MIErhYLOAYb35PcLzX0e38aM3S8CCaZj6BxpnpzoLj1iSdCgongschHnFNr2EWDrL
         QWuO8Bpp9KFGmjebYDErULrUMTT/yiGpmDSfvXypMNpZP5WkM5gSjoCguwGMYnFYLGFq
         U1aWXtbz6kTKXQA10dufjq0dPu2vugkVgtSsf82WYd4on0iEb6ShvnR7qvpQydFy3/df
         mgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757660660; x=1758265460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/3azkhASRepTVItgM865PhVwehLOoknq13jGplyT2c=;
        b=iRbM7dVKH0XTdZeLkadPcjGWHTuhVmQLfGoyO5dnhq4Z5lfrDnTqTSAHH6CMygM0xn
         xZUA6Z7k2JIOHqg8CBJVjjO7GISpkK7RE5s5sLW/ifGEopykFKL5jH48nqTdycbhHbXq
         3fgBwlWscZ7HtxTVXzI9NAaPW6t9s75b7GNG57wQtdFF/ApP/e+FbiVDKPXmRXm3RVnt
         2gzIBz5oLuWfnBNyyLCj9pVHl13F/BaA9E77Odk4D9JNtUMvlHCo1rERRF9eKNnX3GK4
         1e5YMQpoe3y9rfY9Vi9byNwyf5X9lo3LpesB4D+d+h8JfsMDjmGXaOw1Hy6NEhx1AGWJ
         3hrg==
X-Forwarded-Encrypted: i=1; AJvYcCVTMTqcPYkmDBNO14doe0vxV0Wmg79o6q3rtJkk9f7Bcr/9uXvAhKBhY3IlNYq4BWgmZFNCgUMKYXx71i8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUcVgAl4KbRGb9jL9KIuSJrA9Da4F7+dTjRh6Wb0KuQQTYnYDF
	gan/Q6iDllNRAwKnC6jM0XvkS8VNUqO23Sau3fHrNgcOqfWslNRb1ChltMS3QNGI/tJ4UhC5JnR
	auW/sfucJmTAwOs76BvkcG7M+jLbj2ykYgALCsNBD
X-Gm-Gg: ASbGncuPnoTnlPv8ZTRgyLNi1ZLvmGmuesK5cIUWIUCH3a2g0KaCCm3iCpVND/pTz1w
	xRcv9zqgfDKtJIMnSTPg6BzOo4jDntkUWwsiRBJnO7Tkpjknu8W8ibLdHH7iACqpUVGKhMT5jIH
	nCWrFo0VUPuaQLhoZfBcZoXatv6gmvBRLbwZM9E2EFPARvCm3Zytg3fVDYI9g9sTY1oHWnR0WyW
	xPSWBiV6RQjx9kbup6urQ==
X-Google-Smtp-Source: AGHT+IHgWpsGKQ730X4wPp2YJnGKAlEQTxGeuAX55Bp6TeDYnQIZhudmoMoA+b7dxsgyn8zLKB8Su+Ge7eawJWqcabc=
X-Received: by 2002:ac8:5882:0:b0:4b6:33e6:bc04 with SMTP id
 d75a77b69052e-4b77d05a075mr20716431cf.60.1757660659500; Fri, 12 Sep 2025
 00:04:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911230743.2551-3-anderson@allelesecurity.com> <CAJwJo6bsZg-arM6GAQM8Lv3DivWUERu0VyFQgi4DA+SxRrZypw@mail.gmail.com>
In-Reply-To: <CAJwJo6bsZg-arM6GAQM8Lv3DivWUERu0VyFQgi4DA+SxRrZypw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 12 Sep 2025 00:04:07 -0700
X-Gm-Features: Ac12FXy4bKErw1s13GarDS8xoicxXKEJIYUhfNSFduEdoTfv6TSJEbr9zbXNqeY
Message-ID: <CANn89i+MPuFReHcGsp6B=40N7kvkDjZipY7ZFZXTkv+erzk8OQ@mail.gmail.com>
Subject: Re: [PATCH v3] net/tcp: Fix a NULL pointer dereference when using
 TCP-AO with TCP_REPAIR
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Anderson Nascimento <anderson@allelesecurity.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Salam Noureddine <noureddine@arista.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 4:27=E2=80=AFPM Dmitry Safonov <0x7f454c46@gmail.co=
m> wrote:
>
> On Fri, 12 Sept 2025 at 00:23, Anderson Nascimento

> LGTM, thanks for your fix!
>
> Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>

Same, thanks for the fix.

Reviewed-by: Eric Dumazet <edumazet@google.com>

