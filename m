Return-Path: <linux-kernel+bounces-796981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A61B40A55
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600BC1BA22B5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56F03376B2;
	Tue,  2 Sep 2025 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xELmc28H"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C5A2B9A4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756829664; cv=none; b=o+5vBQ2tXyKYJ6Pyp0fyk/OvrnWk8AT2Ws+AC92eZ/5JYaioJ0xcuMJxRe/KSjns3lSOGf/YzJ4D/oBX89Hug6uZskwdD2e8xfX0yTIKugwASMXtfosN0l3KmstoV7P/Nxit1jfxNXGy6OmTUwBDB5d3rg+NGLEUqKvmlcDFPFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756829664; c=relaxed/simple;
	bh=M23v3B4ETS5TnVqJIjRlGEDwj13+wEieeVmUiquYmXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0VgDq2psSf8sk9qZNUA50OW88ofykIKCBwdN/uA3OWwzEtZC2TI9XDuGZI2018O38CaoLK6nnsRUMAWgZyCadeyoT/NK5x82iGEWkHiMX/IBi3OQn8MkN4RPqVivRq/J7405VvNeGEaXRWI/UhGt1nfmHqIvFa+99Id+8TUvl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xELmc28H; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f62f93fdfso16194e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 09:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756829661; x=1757434461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M23v3B4ETS5TnVqJIjRlGEDwj13+wEieeVmUiquYmXw=;
        b=xELmc28H3oy1stMi3PaRZF7SArZ29ELNuJtPYR4ldOfpZZPU/aN8HJeJpxYXsG/qek
         WlYkOO/6FvtxWEfOJV58x0VtHTV+pA+uOA8XQO37kOz4H5+rUOk9Bc9sinZzrgIVHOUa
         D7nP+e7J4/7otP4Zn8FAl7Mvunjv/Xwp1Dt8WOiDaIYTTHo8Q8a0nxtGSD4qkCrBktZ4
         dRhbzU7VFmHL9GJMwIA0IR/umuj3hagff0AVws6J9jnVPxMbNaJsi81HiikCW1dTcTKi
         RW7uCF3FZV6cDQz0Z3ppjCMmzMpIw+UTu4G2MFwxWGosquhTNyKV5jSN7uMgUOTZWCQN
         bGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756829661; x=1757434461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M23v3B4ETS5TnVqJIjRlGEDwj13+wEieeVmUiquYmXw=;
        b=AFYS+9rRM6OvfIsnCWRm3bNfmR4kTcoeS7Y8tswMMVpI3JF16+o5gdlmKra3zG8890
         0bqH7knoHWfKjWPYSaIUMmo9eH1S7Zr14BiaOieZfpXI5Zx+AapSdHKxRHavYyJLedfW
         UiyxWMn6rqHl9rE5EwEQAx1IAG96atBXCdeLsQsH2JC5CSYGVRZ7yw5Rpw6RoMRvX3oh
         EhoDRSM/+rmV+ie7GoRCYFafE9bifwMs2NIVSrgloK0Gdkr4fZZz3LIKmfGE8dHqGKJu
         k/uaam/yXOgGedSDYwOoPqpzSLbuZemNutgPtIDv/mJhHNP7dGaCCTfK8IB+fJ9WN/5f
         h2BA==
X-Forwarded-Encrypted: i=1; AJvYcCWlSlUKBUqAulHTN23oQ8S9Ih+Qh/gGxelhsnYuYuQqtpsaNntaIzvzmZTjF43k4/8JCgtXD5FDUDWTIhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz5PDlq0+cT+mFQIk9FQ5mYel5PW4wKVt9ZbNmnYSHSIeRM/VI
	SHtHems3GXJ6c6n+3nC2GkCvTR69qpniEufswUpxQrQ3sV8bpEafUe5jsOH7nGnt6OmC0XxEVOe
	Jf8cnejpckmpUXWC/FYcUyMHqmB2xigReM3ZWXGe3
X-Gm-Gg: ASbGncvpefU+1Fb7ZSAYnXoaaxzRv/Oyk/IWZ9/Ab6+KvkRKCzoEXF9Qm/jkTMuQW6s
	ZSHZMpGhSbo1bbeiPMro0zomq5zYVukadj8nDg/+M/qUgao/8BW+oU2qiqniU/XtpBWAcqcOnDS
	BGDyF/s+jDxcX8uy04ETrnCE9VwjANE73wcGAWjYDGulItiyLFVKQupOmYVAQe5cz8zYUXgtXiy
	Bp1LT/uUD1SW/bkAn5+LiHYxUF4G5C3/UiZ
X-Google-Smtp-Source: AGHT+IHmVNH7wPjpYsvWB5ZP3rfd0MpHTgi37ddHFFGdCMiTb5F22lPHppg0uXxCGgrlm/MDvnoS9U7m8fLlmHoKjCM=
X-Received: by 2002:a05:6512:3b0c:b0:55f:6a35:dd47 with SMTP id
 2adb3069b0e04-55f6f4e88ffmr689274e87.4.1756829660517; Tue, 02 Sep 2025
 09:14:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829220003.3310242-1-almasrymina@google.com>
 <20250829175222.32d500ca@kernel.org> <aLcTQEN-sAHxASMI@mini-arch>
In-Reply-To: <aLcTQEN-sAHxASMI@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 2 Sep 2025 09:14:07 -0700
X-Gm-Features: Ac12FXyRSJwzr0bcBZWnsHSVXpf48qrqBOFx_2zrCXBIIplAxm9Uu_7v8G06n_w
Message-ID: <CAHS8izNdAdLv9_ExJFrFxJxpXr2VbHSE9-bTkAhQ4NVco9SSnA@mail.gmail.com>
Subject: Re: [PATCH net-next v1] net: devmem: NULL check netdev_nl_get_dma_dev
 return value
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 8:54=E2=80=AFAM Stanislav Fomichev <stfomichev@gmail=
.com> wrote:
>
> On 08/29, Jakub Kicinski wrote:
> > On Fri, 29 Aug 2025 21:59:38 +0000 Mina Almasry wrote:
> > > netdev_nl_get_dma_dev can return NULL. This happens in the unlikely
> > > scenario that netdev->dev.parent is NULL, or all the calls to the
> > > ndo_queue_get_dma_dev return NULL from the driver.
> >
> > I probably have Friday brain but I don't see what you mean..
> > In net-next net_devmem_bind_dmabuf() gets a dma_dev and returns
> > -EOPNOTSUPP PTR if its NULL.
>
> +1, the description and the fix are confusing.
>
> Unless I'm missing something, the intent seems to be to avoid hitting
> a WARN_ON in dma_buf_attach (really dma_buf_dynamic_attach) when the dma_=
dev
> is NULL. Mina, can we do this in the callers of netdev_queue_get_dma_dev?

Yes looks like I was the one with the Friday brain. I missed the NULL
check in net_devmem_bind_dmabuf. I'll check if this issue is on net
and send a fix there if needed.

--=20
Thanks,
Mina

