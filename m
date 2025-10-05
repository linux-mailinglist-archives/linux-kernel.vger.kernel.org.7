Return-Path: <linux-kernel+bounces-842393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BD9BB9AC9
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 20:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5151895572
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 18:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11D21D5178;
	Sun,  5 Oct 2025 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="giKTBQge"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC5C81720
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 18:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688670; cv=none; b=XqNmnMn41pUBaBVEVh30/LPGRBw1lEH9SgB8b09FW2oMHgaA27sRWmW4OXQ+wvRXBmFq+fNuh8k0dBDUEWpI5OTkut9BxhFm1BpJMpmRGfpBG0KONR1clOhnQ3Irxz0q0vcbfvoxtHJOkmBtIAK/CEE7g8c3IC7QihVPtb/iEbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688670; c=relaxed/simple;
	bh=9WjzuHBdxag7kq4Nilmq5RRZAta4IJxqsLveY2PxQo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1EFu2ddbCkGx7EacY4r4h98hEjm1iM6vbz2dXC4Qx2QvLNNdz9SpaVAOfifbzc74XFtczYMcm+q4vt7P5pYlEmw5wJs+u4a0/pLFbS+tWm/OLYbMECP8gmNuDSn4mPOVbBcbbV4t1fVySEebw924NVkZ1Im4EpnMH0WcZkVbbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=giKTBQge; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7a16441so671193066b.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 11:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759688666; x=1760293466; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wpo9TLVZT45BbNVhzNvMd0DcfN1QJDQZVUcsc3h68LA=;
        b=giKTBQgelJMv8HlzSf8xwLbFS65/lNgWtn9YRMEJNc9oTdvd6vnjl7OgWwpguQTiRc
         wOUy+vNsdL+yiw9k8TYte88zYuC4NG1Q/PxLePT9UU5XAep1uhtCgPAMTbYEJbFdCRH5
         BQWO6FAd93kmuQ+pgXDDr3+R4dClbuK7CjtQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688666; x=1760293466;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wpo9TLVZT45BbNVhzNvMd0DcfN1QJDQZVUcsc3h68LA=;
        b=IWjgnUM+g2WmOeXwByCEzsYDQ+NXcX85QWPGE8nvq10ByMtA6ns5MkkhxuRi/3hAMO
         zrzQk6dUj5I5gyp3x/5x7oaR5osyksxD6ibDPqxaJhF/Eh8jVuRjQUQTD3A97nhepyRc
         +XOQAEaLxb7m1vq+IkwtAQ3EOR4ZOE3nNs1VGNYmA+JJCBSJ6LYC9chSU2NZci3DDn21
         ITRJmNjfAPz2bUW9DX/p3bqyKxTgvNB5J7hDRFUgnT3GV/J1/EUgyWhmDaQ4GqDAKkQJ
         ypHx54IP/9mJXiNjT63sQqrQUWF6q408YR0UF17Wu/sIjcYWZd1SWq0D2i392FAnK+AB
         ibnw==
X-Forwarded-Encrypted: i=1; AJvYcCUBoe6wtAKcHI3mSbUbBz6PuU5D1fiZQCiAgEfxufsMODDDAwcfRhaU+EsOLTj8LRVUA9U2HS2Cem5Hvgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD4603xRmv4QRjB8MeuW5M+sxcQ+IqnChatkhrQwffLW/316iT
	AAaix98sGiMu0PT2KYId3CQl2eGcgrZU0vje3njiBsIzXAUH4uN+sVXvuH9MNqdAbtmC1lywinm
	X9MDwTkM=
X-Gm-Gg: ASbGncvk+n2r1zJasFzVspEcZJAH+ufjfNXKbFR1MkrBpzZFJpDhKOTDlj2buA4tWGs
	WQ8tGxsd+Ec0VNNBcAkXMvY8o58neGF+26bZYoSUBjYZFA2ZQNJDWfTnlJAqfLh60rx0p1jV/B3
	clEbNdO0xuRnrtK6zIbrlkUMQlw0HZCZy2+8ZL9jDwL2r4uYzlGzY7o6GTZ5TAHlQtGivEMZutr
	hxzqORVEgRu9kYrlytf42dQqsVUok60FaVrKJXU/yYurEdDyepxZIRuri4PhKnSyIcLok7jwRU3
	wOfOjKPDRAbgJc+cK/SZu9GinIi6z0qTKb2iQq4jwL1lHFKT+Z29f566Zy2WtDPJWRlD0Znr9XJ
	9SmYEXGh7L+w58UH9vP+ewjcQwWBkVDaBI5irsqqVYtZBCE6w5fbunx7kTHbo+lJZBkHrfAuKlx
	7i3T/PPQ0ZrYdnNsl9DuVjVaiUKt7ffOo=
X-Google-Smtp-Source: AGHT+IFSoRnWbztvFEg/q1xcvgaWcGMwgAGQ9m53pez5ctJAohydEV+J1UCkRmfQ3Fz/q3ZWBslCbw==
X-Received: by 2002:a17:907:3e92:b0:b3e:580a:184f with SMTP id a640c23a62f3a-b49c1b6bf0bmr1200466066b.4.1759688666142;
        Sun, 05 Oct 2025 11:24:26 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b5acsm962058866b.60.2025.10.05.11.24.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Oct 2025 11:24:25 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6395172532fso4548989a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 11:24:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXFQeVZswU+cGeh07igN7O6FR7InXrs9eSOh8QVaDks20JwmD8XLmeyFuNIe+CX8tav0BonwMhDqGs3LAk=@vger.kernel.org
X-Received: by 2002:a17:907:2da6:b0:b3e:ac8a:b1e1 with SMTP id
 a640c23a62f3a-b49c27518demr1450075066b.27.1759688665152; Sun, 05 Oct 2025
 11:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aOKTFv1vh1cvvcLk@kernel.org>
In-Reply-To: <aOKTFv1vh1cvvcLk@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 5 Oct 2025 11:24:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whSe9AGigVydkwo=ewE6_GFTJ_rU=XzO=v1N1sWyfVmAw@mail.gmail.com>
X-Gm-Features: AS18NWBWjtRNMqiFhMnbqxI4QyLpCSEY68UKMaGvljy0AnFZ4D7Y6Tta1dBrPrw
Message-ID: <CAHk-=whSe9AGigVydkwo=ewE6_GFTJ_rU=XzO=v1N1sWyfVmAw@mail.gmail.com>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-v6.18
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, 
	keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Oct 2025 at 08:47, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> and apologies for this late pull request. This pull request disables
> TCG_TPM2_HMAC from the default configuration as it does not perform well
> enough

So having looked more at this, not only does it disable that
TCG_TPM2_HMAC, it does a lot of other things too.

I really am going to require a better pull request, and I have thrown
this one away.

The exclusive access looks debatable to me too. I think you should
also require that the open was done not only with O_EXCL, but as a
write too.

Exclusive reads do not make sense.

Now, I certainly *hope* that nobody has /dev/tmp being world-readable,
so it probably doesn't matter, but that new exclusive access thing is
very different than what the code used to do, and if I read it
correctly it will also disable the kernel doing certain operations. So
it needs to be as limited as possible.

And damn it, it needs to be *explained*. Not have a pull request where
one single line is explained badly.

             Linus

