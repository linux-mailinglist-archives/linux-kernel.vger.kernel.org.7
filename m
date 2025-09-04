Return-Path: <linux-kernel+bounces-799972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88764B431CA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED94D18990BA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EFD2459C5;
	Thu,  4 Sep 2025 05:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PWzAy9wB"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F41D227B94
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 05:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756964999; cv=none; b=Eu0CoogZqahTYSLoEf4UVZkTvfFK1o7KPYZrmWVQpNw8gW1bb6Hc8hac2MmyAAlW0KvXBMbZGuroIVHqEIV42W4/puA7TLO01+1jrwNpw0BNqsQ3FTelxxz1J0fr+sB1ga7Zxvw8V7tUWCUF5vxXnCYE7ruTy/OvfMWEZQ16bR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756964999; c=relaxed/simple;
	bh=cHXL6xHUHiNr78dezyhRkZqCf3fXZn4s6BpkJKXpUTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XtK6yrZLiU5aqMr/S2dGPSnaFgX42LJyHbQ9CwOtTvK6ATvaTfS7k2u2VUAiMIhR/RR/H8xfuhIbNT3si9szeAOqEHjPVsBwWd3mRq2AD+sEqwGqDx/btZ/JQB3dX1XHT7P7ZDZgyh58WlmIxBRXO7ffsM2X8D1rGNZHQzIuXgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PWzAy9wB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b8873085fso49565e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 22:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756964996; x=1757569796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZekwazS2g2pYhPPIj8vSuvjbizjS9SUCjW0PdNHHTI=;
        b=PWzAy9wBy2SRDWfkd7iPMJv3ENxLy50CSD2Pq0enS/j7x/LIq5uBrHXdaZXbAZXAwP
         HLc8C367SntH04TRBZrsZNM89idujw/a70LbUvtvWqM0hvKMkd38MrLlpB6CjQ47wBC4
         JklXA/2gOrnBXg0X5WH9BDLfLVgGZ0+kE/FQhO9NMVGniFLI+IGxgdz2sauA9YF0bg2Z
         Nh7tWF7YWRHGr/hTfyuRdc6J58ThCQChFFAp5kHMf89IwtPJvEh12dFpMRBUZpgV+zPD
         i0RCivn/v3S1c6/YYRoR+BiQ87Q0aXeE3r8CPBFVVHo55wyltyK7nIp4uAl+MfMNNW+P
         TFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756964996; x=1757569796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZekwazS2g2pYhPPIj8vSuvjbizjS9SUCjW0PdNHHTI=;
        b=jn1GQ6du2GLGjWQ3210PYQn8FeeKjG2hcdjITPnISNZtu+2a2CiULyTLzkfogp9uZ4
         L+BTutTv9vp/GvPVvTL7eaZ2zBUK3O8yK9Omkr+gZ2+jKdEjLFCv+bZ6YzN4H5ydI7Oq
         odv95TACaR1tsSNEkel+v+wGG4N6RwaAWOfk+N0KoZPb8ZHjuq4bW4zZVjBvWgk/mwxe
         a+64o6iv+WUBAvJKk0lWp3QqlvRwbY6aLL02JVScZiaLDQNyofoP4uP0idIULDLxGbNg
         m7/c3/JNoXZLG0oiRvt3S9hg/P6p1eohu+VNIgxnnHJtLxw+dZA0MX4Y55snsi7KuBqz
         /r7g==
X-Forwarded-Encrypted: i=1; AJvYcCVtEgDdddXWjl1KlUffsRk47rkYESat7x8r+btBe6A8CFjlqs9/u2wX4BCk+GGK01pyD5pwmhs9XfVZtNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGGKT8x3PFIqwZO+CGhnRpiUuPgK4mOwOeaIFeOUrqtlATKpA7
	WN3MRNTjJ+oSZ40PZkC7aPP/Q30sViNqh0XFaMxFlJ492kXGELOnFmm9Q+tb95TC+v/htPoYMcQ
	T8G9N8MfZFSA62bGeM1nDaJxqQF5f7ajYsMwtkCV1
X-Gm-Gg: ASbGncvHPN1QwHXHvXAhgX9gOTWk6r3hkgexwvxOzg2DdGVUoiSR9GhgukWE9rC8X/C
	eCqKubSUM4t6xcs1Bz6i7pgZSdVMGj9oucaaNpvv8QW+9WmLN+IK4qk6JWsfcTXBrlGi+B8iwm4
	/mATP6ZuF7mwemMguHhE/rW2sYpuwH6g9I7fUY9GSEPxvGAA0aizTBKhbii7fk5PFA1Q1H4u6Im
	XbY9PiePNL5O/yTaUHmv9XhJzHTznCcZ9oF20uL
X-Google-Smtp-Source: AGHT+IGKXKMOwaX1XwiLYd9cWPAOn8fRshNus9S9PFRUt8IGNa0sD7+Q7RKYMmonPYpj8+GPY4e60I9X1xIgZWTCRrM=
X-Received: by 2002:a05:600c:b96:b0:45b:9a6e:ceaf with SMTP id
 5b1f17b1804b1-45dd0d16286mr549045e9.0.1756964995324; Wed, 03 Sep 2025
 22:49:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903083017.795065-1-khtsai@google.com> <b50f9d10-88a3-4b1c-a75e-6c67b9d1504c@linaro.org>
In-Reply-To: <b50f9d10-88a3-4b1c-a75e-6c67b9d1504c@linaro.org>
From: Kuen-Han Tsai <khtsai@google.com>
Date: Thu, 4 Sep 2025 13:49:28 +0800
X-Gm-Features: Ac12FXwuISttGL2s4mMoPJlKjujNxzCkzweDYjIHvsxMp4VbNeORKHN870izq7s
Message-ID: <CAKzKK0q4aioOOYZyXVp1-GTcQFaU036YoecKzvVCRPjeUAyNKA@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: f_ecm: Fix ecm_opts->bound logic in bind path
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: gregkh@linuxfoundation.org, prashanth.k@oss.qualcomm.com, 
	Thinh.Nguyen@synopsys.com, s.hauer@pengutronix.de, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Wed, Sep 3, 2025 at 4:33=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 03/09/2025 10:30, Kuen-Han Tsai wrote:
> > The bound flag in ecm_opts is being set to true even if
> > gether_register_netdev() failed.
> >
> > Set ecm_opts->bound to true only upon success.
> >
> > Fixes: d65e6b6e884a ("usb: gadget: f_ecm: Always set current gadget in =
ecm_bind()")
> > Cc: stable@kernel.org
> > Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
> > ---
> >  drivers/usb/gadget/function/f_ecm.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/gadget/function/f_ecm.c b/drivers/usb/gadget/f=
unction/f_ecm.c
> > index 027226325039..9f5ed6f32a62 100644
> > --- a/drivers/usb/gadget/function/f_ecm.c
> > +++ b/drivers/usb/gadget/function/f_ecm.c
> > @@ -690,13 +690,14 @@ ecm_bind(struct usb_configuration *c, struct usb_=
function *f)
> >
> >       if (!ecm_opts->bound) {
> >               status =3D gether_register_netdev(ecm_opts->net);
> > -             ecm_opts->bound =3D true;
> >       }
> >
> >       mutex_unlock(&ecm_opts->lock);
> >       if (status)
> >               return status;
> >
> > +     ecm_opts->bound =3D true;
>
> Now it is outside of mutex, so this is raising questions you should have
> answered in commit msg.
>

Thanks for the review.

1. Commit da92801c647c ("usb: gadget: f_ecm: add configfs support")
introduced a mutex_lock in the ecm_bind function, but this lock did
not protect the ecm_opts->bound flag. Subsequently, commit
d65e6b6e884a ("usb: gadget: f_ecm: Always set current gadget in
ecm_bind()") moved the status check outside the locked section but
neglected to also move the assignment for ecm_opts->bound.
2. The caller, configfs_composite_bind(), binds functions
sequentially, which prevents race conditions when accessing
ecm_opts->bound.

I will update the commit message and submit a new version shortly.

Regards,
Kuen-Han

