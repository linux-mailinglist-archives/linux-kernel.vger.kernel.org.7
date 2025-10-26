Return-Path: <linux-kernel+bounces-870303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E71AC0A6C6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 983CA3ADDB9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 11:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309FF1B21BF;
	Sun, 26 Oct 2025 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b="E8AIVkep"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170551E633C
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 11:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761478753; cv=none; b=pjCjROF9JzEbZN2ByeYtvGqiNrYX1Rzg1eZes5OsCfUHHxCrj4bYa7GpyevuDZgQFgnY3f0ieojkJlEC3C8t6FKkt1c8CLYsnsZNI7c41wksLP06/0gmneiLwFTNLTTAfm5D66Rke+i/eL9a4QvK4zR75x/b3JlTLsTSni5K7sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761478753; c=relaxed/simple;
	bh=j0DSqnJo3+ZWQare0kWlrCZ5/Tm1ZDbwWXOuuuFqhMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l7yB33XmwWlGleRfJoTt2CwD7vG8oR0OZ6riUUw27AEQ04qyO+cNITdmARqFfmdX9nzxUMhpN7d/QFHQhChrXLKWebIrEB8yBjClHhE9ChdF89tEswLpSZ74eiaXhMweyv1HfgiAjdLtZv3t5ABebDA6IHiA+XJP2dUejQJq7Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com; spf=pass smtp.mailfrom=vayavyalabs.com; dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b=E8AIVkep; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vayavyalabs.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7847ee5f59dso50840837b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 04:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vayavyalabs.com; s=google; t=1761478751; x=1762083551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkEJC8HtsrIv4zgbYuistKh7eAOhGGJ2bEOCqXpaWog=;
        b=E8AIVkepdTKDKBvR/u/Kcau33805U9xRvCzsPNMBzICakqOdX2kC+hwQTleNl6ShvM
         pYrQ4yv7VftTtjJmcER3VQRr1cgbPbCfyOzrafg9I+yYlzH9w3VKhRV+QANZ82/CMBZU
         c+ySz0kNgvfyoQgt6IOTRE6sLl92yiJagIesQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761478751; x=1762083551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkEJC8HtsrIv4zgbYuistKh7eAOhGGJ2bEOCqXpaWog=;
        b=hGnVMkBuKeGA0Zy8XzuUMQ1omaJW5zseOMpzJKSW04urcPplM6r2wlvyUtMHmpTHxF
         tVbeBhOWjZFIFLqfHyh/Eg0AOoYUtsGBMuEONVjlOoG/jB1Iw07rpwmKcmS7LiYfGmBS
         qE5O0/+P7EssxPUHrj6hCkUexsp29iVT6zGfNrUp8AOUvAdvjsNpOE316t5E+7YoZSJh
         DDkAy8pELlaB+ATy7bbWEL173zRQEGOuOekFxinDlBBK5Vi4SfI5WSkuwCmkZUpt9Pta
         AyYsBEYY4ECFFxukjRkulfJMWNKL2edNih7g5mBhQdB2Ba89UBjx+WBMkgYotgdQVYm9
         oUkw==
X-Forwarded-Encrypted: i=1; AJvYcCV0iDPu5mHV9F6Zgp+eaLQtmwId3u4vKdqCNBfzQHY4HuCI/DL6FcJ64Yl7Db9Av5EFUM2eF8fbucmSUtw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg7OtQJkEmTnrYR08fC0bSxB7vJGqXlY3nvKbwsTqK+9hLaqI/
	iBk8y3brL9lI4caHH90nyDYn3X8faGeAccskMSFz98f+cAqvUcEDd/gWSEYYPeG5jdXztQ45iwj
	SUhUuCFZL3mMZuqAgfC6eX6n5CaOgNIu27kdSi4tWgQ==
X-Gm-Gg: ASbGncuEVb7ovhi+9i6L0tpmh5sjni1Re/ry/HIvJ5Mt/dQBKdoUhmawF//bv5ovTkq
	2+Dsh1blCrLKY6WNdsROD+CuCy8uGgQrDhc9dtJOCXY4pjg+ckWFUPNe4l6KBztwfkjxWmw0TND
	nqSDB45QAGRilAudEVfKHmFB3z5CaIihW+awYg7jXn2gWRiUwxpX+271oBL1fl2xBcXCop5gWnL
	TqFhVMp0/Ljlsu+D7BnfCXyGR0tgwa9yVeFzfMktoDXQQfXEMYZk/msucvkvr4xUd8+G1A=
X-Google-Smtp-Source: AGHT+IE5wi1pOk5gMg7t44CcjUcuDJu5krHIn2apqIczzrvUxBYy/Gnl8HzIxmhmuF6Z+BqZbysVKsYMZFeUOs31qhk=
X-Received: by 2002:a05:690e:1598:20b0:636:1a27:6aba with SMTP id
 956f58d0204a3-63e1617624bmr24007856d50.12.1761478751060; Sun, 26 Oct 2025
 04:39:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007065020.495008-3-pavitrakumarm@vayavyalabs.com>
 <fe4d7cd9-0566-4d1b-97c0-91cc1f952077@web.de> <CALxtO0m1R0kf5Am+oEPAgqommQph9zs6+xfTM0GzGHV+YEXT3Q@mail.gmail.com>
 <51baad8c-6997-4e3b-81df-6d0380fc48d0@web.de>
In-Reply-To: <51baad8c-6997-4e3b-81df-6d0380fc48d0@web.de>
From: Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>
Date: Sun, 26 Oct 2025 17:09:00 +0530
X-Gm-Features: AWmQ_bloZmHf3HWYJNFPPTUzK-vc0K2C3sQhcOg1pi8KCo8VnNlMuW1t0ziEdx4
Message-ID: <CALxtO0=4iJho3fqVuQbV+CQyhYqc4zbmNNGeSy03go-iy758aw@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] Add SPAcc ahash support
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-crypto@vger.kernel.org, devicetree@vger.kernel.org, 
	Bhoomika Kadabi <bhoomikak@vayavyalabs.com>, 
	Manjunath Hadli <manjunath.hadli@vayavyalabs.com>, Ruud Derwig <Ruud.Derwig@synopsys.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Rob Herring <robh@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Aditya Kulkarni <adityak@vayavyalabs.com>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, T Pratham <t-pratham@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus,
  My comments below

Warm regards,
PK

On Fri, Oct 17, 2025 at 4:36=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> >> =E2=80=A6
> >>> +do_shash_err:
> >>> +     crypto_free_shash(hash);
> >>> +     kfree(sdesc);
> >>> +
> >>> +     return rc;
> >>> +}
> >> =E2=80=A6
> >>
> >> * You may use an additional label for better exception handling.
> > PK: Ack, I will go with an additional label.
>
> Can scope-based resource management become applicable for more use cases?
PK: Yes, wherever applicable we will make the changes. I do see a few
use cases in the SPAcc driver code.

>
> Regards,
> Markus

