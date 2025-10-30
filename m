Return-Path: <linux-kernel+bounces-878508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC73C20DA1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84AF1A2399A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4023271E1;
	Thu, 30 Oct 2025 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IeHc4XkC"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C549F31DDB7
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837037; cv=none; b=MK1Tz7VAhoqG17Olq3e6XWMzF/Hn1yrmM6qBQ0Ld80VfO7iGIZhDWjHv87FF+RCSMSZA9JZuy6uIgPvStBptDIiPFvLBnJH2utpGYoLVj2BvwaoxvEqxe/xd6BIjA1RvYuwyML5+HlLvEGgAWgCEqfd9ZUpCfA3g2o2v6OjGlhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837037; c=relaxed/simple;
	bh=jr7wOno/Ia9wUunoGjpcuP2yL0+uRPnaoSdEgJfE9Xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBDpbye0KkUQ3gGnQZoq7gJe8GMadxwopAiNUSLKgrO9axzb/+DkzY9qOsFal3a/Giv9mQ+J24Q3mMXArBYNeNqshG1kSf9NfDuCmIn0maIhxRtLaQI1vN4t/bT2jdCGCjILXuyORJuXsZlzRto9cnXsEXWLRu0N9QWqpQHd9ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IeHc4XkC; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b6d2f5c0e8eso250205266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761837028; x=1762441828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQGJPENlwCBSnocB8Fdfhdqupe2Icc+kg91PRDHOC+s=;
        b=IeHc4XkClza5UMtw1c7x7fPcn3w4BpUFu6ouF4Y/D97v8JdGSw5Ee76B0Y3sTZzXKA
         L+sGH4bgDjXNBrxDLkCEH7wGp0SARqs8CH6T9Kvs1YUEey0kOrbJhGN3N2upt3yZItm3
         5qZizMg9B/x4LGqXRb9wmoY3G4WdSyP4HJWTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761837028; x=1762441828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQGJPENlwCBSnocB8Fdfhdqupe2Icc+kg91PRDHOC+s=;
        b=wKUdnUA9dLYAi3aLnBPhYRd5MvQp5o9WuTe8yO0oRP2T/Gcr8QhYwnRT/4r+TSYkox
         k1f0FxBeiFeDAYp3QCfG48jb8XiG0quf/+5WYwIYFh1o8JlfYjdKHuDcd0NhGr4JZ8ct
         fmip5eEEePJCAmfjBS9ppH0zv3Cu7bzRvvL4E9/eA5Ez9WZDDwCTZvd9uVVHEyRFVwtN
         BHcG/lu9wcRznZkErCr+7uiAxBN+jdtER5U8PrdfhfYkNIjLjwDoPGCUj1nb5td65EzY
         K5taxfVe45HJ4Fs2Oqc+7FY44FAturUCJieZ9o7JymssanzbZfNs57C9mPXI2mP9563L
         7MJw==
X-Forwarded-Encrypted: i=1; AJvYcCXJzvxQmeBw+w3SpNw0gYKU0C97MO/93rGwj8YYnAZpA4e53eBb5QmQLR/yGMpF0+97RofrQXUQExM3KKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0l/7X5Kf03cnAxCIUw2grU34vYogNtmOfc5395oGjxKuy91SH
	gGpaR/ZjsGbMnL7cXgIdW85qckg3mRQ71hoX6+zWT3T3rp3WBpGjRJa5nglTRWQ9SoyqOUxhmKT
	wpF6AmPFs
X-Gm-Gg: ASbGncsmol8HIsyqlgmqBph2PnGP67NzzQaBYPYraxAI90s94P8X/JSq8BI5h0J3zpM
	2ZUknWjQPHd0RO/aHyP9XUjevpgwQWLmEWmoEziedNrT9E3nd5B8O78A8XtyAB6UXRAv69EZLf8
	zmiQSPUpMbCdtd7DSnov1NSlZ6/6u2mEXkLfQGOW6UvwK3orF1qdP7QMRwIQS1p1xAreJEW7/EE
	uy02YrhOzeeF1C7EP1eJdIFXdU9pLf1Fjzj7RYlqu0dOWD9yYRVWtSLTnPAgZeJBqV96YlIIpvY
	793poc33K36IcZEhzC0FUYbEKt7cKseLob3hzWJdgySICWO8oyguQlvWIiNA+na4u87F4Ln3+eU
	eEzYuQFYpBSVCFQyd3bOY31htHHMmCKQ+ePzUBwGkfLPgVEscM+3326ih8KWINkZAmiE/aAtJWk
	RcKgcINmT9gIm9gv+6bGYXjWynhBIJlpSFblckF+c=
X-Google-Smtp-Source: AGHT+IFHH+uUxvDhhTgd0TwVsh8ZSENRGoAda5dusiVZIbx/V4RrjoLDFVWG5h0Mlpf3tHf46NNJ+Q==
X-Received: by 2002:a17:907:7286:b0:b3a:7af8:c4a2 with SMTP id a640c23a62f3a-b703d2e2094mr833035566b.10.1761837028556;
        Thu, 30 Oct 2025 08:10:28 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8541fb2esm1777102866b.59.2025.10.30.08.10.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 08:10:27 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429b895458cso578743f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:10:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWRIeqs+K0GZDf6l9XZj1vtd7LUpvUtYJCOLvtVuDLqEISJ+ZTRdJAUq+IxoGQ/dbRcSs1zFbhXVNtqS5Y=@vger.kernel.org
X-Received: by 2002:a05:6000:2282:b0:427:8c85:a4b0 with SMTP id
 ffacd0b85a97d-429aefcd9ecmr5434709f8f.56.1761837026324; Thu, 30 Oct 2025
 08:10:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029081048.162374-1-ajye_huang@compal.corp-partner.google.com>
 <20251029081048.162374-2-ajye_huang@compal.corp-partner.google.com> <d6fe55b210888b9279c776b2bbfeaf38bfc44dcb@intel.com>
In-Reply-To: <d6fe55b210888b9279c776b2bbfeaf38bfc44dcb@intel.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 30 Oct 2025 08:10:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UTP-kdjp2DD0YYnwmQ7ppLKXSHLRybPbyPeSqE_FEQMA@mail.gmail.com>
X-Gm-Features: AWmQ_bke1tjou5F_4-QfM_8iUzksOVca3RFZUdxwYykUtaSqGBlpmT8eCCU_9jE
Message-ID: <CAD=FV=UTP-kdjp2DD0YYnwmQ7ppLKXSHLRybPbyPeSqE_FEQMA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] drm/panel-edp: Add override bpc quirk for generic edp
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Ajye Huang <ajye_huang@compal.corp-partner.google.com>, linux-kernel@vger.kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, jazhan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 30, 2025 at 2:44=E2=80=AFAM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Wed, 29 Oct 2025, Ajye Huang <ajye_huang@compal.corp-partner.google.co=
m> wrote:
> > Adding override bpc to EDP_PANEL_ENTRY3 quirk.
> >
> > Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/=
panel-edp.c
> > index 944c7c70de55..da3e8f223ec3 100644
> > --- a/drivers/gpu/drm/panel/panel-edp.c
> > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > @@ -218,6 +218,9 @@ struct edp_panel_entry {
> >
> >       /** @override_edid_mode: Override the mode obtained by edid. */
> >       const struct drm_display_mode *override_edid_mode;
> > +
> > +     /** @override_bpc: Override the Bits per color obtained by edid. =
*/
> > +     unsigned int override_bpc;
> >  };
> >
> >  struct panel_edp {
> > @@ -586,6 +589,9 @@ static int panel_edp_get_modes(struct drm_panel *pa=
nel,
> >       bool has_override_edid_mode =3D p->detected_panel &&
> >                                     p->detected_panel !=3D ERR_PTR(-EIN=
VAL) &&
> >                                     p->detected_panel->override_edid_mo=
de;
>
> Unrelated to the patch at hand, since the pattern is there already, but
> something like this should be more reliable:
>
> bool has_override_edid_mode =3D !IS_ERR_OR_NULL(p->detected_panel) &&
>         p->detected_panel->override_edid_mode;
>
> It does not look like p->detected_panel could have other error pointer
> values than -EINVAL, but it looks awkward to check for NULL and one
> error pointer value, and then go on to dereference it.
>
> I guess even better would be to always use either NULL *or* error
> pointers, not a mix, but I digress.

Yeah, that makes sense. If someone wants to send a patch cleaning this
up, I'd be happy to review it! :-)

-Doug

