Return-Path: <linux-kernel+bounces-776605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A1BB2CF81
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B2818845EB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB39F22FF35;
	Tue, 19 Aug 2025 22:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iDyvCsyk"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F20353368
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 22:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755643775; cv=none; b=XPQgGHwpTl6vZuUBypJ8hZUYzfxJOsNt8sSFGUWyqVQgYpLpr8nAKpIllukNzqZGd6MjNrczTI0Gv+K/CXkkfckqW3q6PO8ae9YNnB4yQ6KsimVUnQmsLT5EXXtSW5mrX1s7Rc0oi+v4RF1CGGzUR3BcxC1mVm5BG6KXBhQGIWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755643775; c=relaxed/simple;
	bh=fvxwuSCfRSD+twSz5Gb0eEyXaCFiz+gsVdWdoqPh9lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JgkQDdT9AWBH75vwIcTca4oUK4vpzsQ+/SrXGJgiQC0fpJbt7Uml2jygGJRk61bJithGkE/w1uipXKj3IeFxLymzc6gG6Bmvvge2o+WIO779XEnMoWPrZ3FskLgoAzl9aXa5dki2pz3AdmCU0vZGeMtDZOwE+W1Wc8LMQsumZPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iDyvCsyk; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55cdfd57585so1005e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 15:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755643772; x=1756248572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvxwuSCfRSD+twSz5Gb0eEyXaCFiz+gsVdWdoqPh9lk=;
        b=iDyvCsykgJZcsYsXTohLvX7Ylc1S4wklpRgAb4ynFcENavI6NxuxPsVrXtCOCbu9ey
         foMfJJVbT6mXW3hdUYt8BhHl3/DIe72aXhfZ9Wd7IkLfCAJrM9CQgBNPHtRjEuUeoJ5Q
         z6eocIeH2oGMdRsYDfbWZd5DtgQr9rZWCR4NLHzTu75V0QGqHXHpkl6MYLVxy/tYs5dh
         9xu9ziiK51RjVCTgDeDmz5q78SwNGFlCQpgLh2YkTW1kbvrgc17SFeNYvs6salU3dC5h
         hUybR4tx+0LPa4MKKKA0ZUalYimaZJqXqPHr/LSK1yX+LJgQxJ1g6mKtUvkYmseGhPyn
         SA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755643772; x=1756248572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvxwuSCfRSD+twSz5Gb0eEyXaCFiz+gsVdWdoqPh9lk=;
        b=dy+ntwZbOq9GS0vF6cEPxn+O1YdRKNe37H8KdurdLd8nW63UcKFaAaekzBOZam1dMR
         H/8410Nf1ehLtJolHGxDgGwah/u6Sa3dtqaHZKxqfdO4ERc3nFa8opWyIYEKyNkMdr/6
         mR4P/SwMx3oW3bRKG01Vz15IUtbZCOgkgdgQOYhr5tPmqh9YG3PisCoqwlW4QN2MJOKv
         /oXzErmXDVxm+bA02Grlm+Pnoipcj1GMeXNuMae9i3LO4IXgXdrW2tEx7ZXi0Wtqhrup
         4Rc4/CMXsen0QhtcnpIrkFi6oWSMXlekjw1jmt+hnARoikIv4iA9qCY93WBIZjDdWeXl
         IKMw==
X-Forwarded-Encrypted: i=1; AJvYcCUOhGlSc9cFdcUuloWLXpmiKf4BnbmCYLCHmZr8ouEMIyaR4NV/6/Agl9oFhWec8E9/ccphshTf0ZaGW+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzStzcywyMjkFdjYOF4ZOTgnECd3hYF5rZ6dYOSmxGvHBaz23l
	B6HUz7XehHmONT5+UySSxZQ/jWsfruNgB5cMm+0FZ+NJYdeI7JjC+6hXk0oFn+6q0qYpnEBXQUq
	TBUhCAxmATd0h638hTLx3IrRuyZr812NUlk24Ryel
X-Gm-Gg: ASbGnctvsNENJ8bWiJ2JBDO7i+Xv6QoiB29dqI5ir0KoVApqdsK1zGW/bU/vVd0bMpw
	FsjwoEtE3jenuiOsELtW+FDLCT7iEJz4/Q5U3QAKBrkhQfYS8XuqHV0dLj553p4zR6cX5Tux00t
	dWodPsYuhcb18OxAkFG3momduGVXJBpWofRiDmU3xbhx3w8L2op+rKNNBXt4v5CvifsbxZ+2mA1
	brs4jwTEKibwzjU3660iteL3KJL/8Gnl98PkMXPb9390e8T2rhW5YE=
X-Google-Smtp-Source: AGHT+IEmYxxYzU8DjQH4U3y7gdcuj6fyI2P2sUFUnAoDbFPxhCsmZmBLl5HbvLkotXIKN1zE2OsjYMUqPyw5kzo6ryA=
X-Received: by 2002:a05:6512:4388:b0:55c:df56:f936 with SMTP id
 2adb3069b0e04-55e06818947mr113782e87.6.1755643771563; Tue, 19 Aug 2025
 15:49:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755499375.git.asml.silence@gmail.com> <0ac4e47001e1e7adea755a3c45552079104549b9.1755499376.git.asml.silence@gmail.com>
In-Reply-To: <0ac4e47001e1e7adea755a3c45552079104549b9.1755499376.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 19 Aug 2025 15:49:19 -0700
X-Gm-Features: Ac12FXzsId0yCBo7YoLtpLEhq9SLD85yb1Q2qrwcLNfXEbhtrBTCgGQJ0OuhPvo
Message-ID: <CAHS8izOkTpdMSn+0kWYL=qi+WrTy7b=qARXxWjOMHWEKdHZWaw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 19/23] net: wipe the setting of deactived queues
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 6:57=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> Clear out all settings of deactived queues when user changes
> the number of channels. We already perform similar cleanup
> for shapers.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

