Return-Path: <linux-kernel+bounces-889078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA512C3C9FD
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 77EA93527CB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEE634A78A;
	Thu,  6 Nov 2025 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Na8DiMyd"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C151347BBE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448186; cv=none; b=iUl3/SElxSG7tKsID8JNWlxAy0dCBlqaMLLojKHOZp9PUMRt6l0HB1CHpQGaRhiiKXG5q8mGp+oy5mrNhXQZD2DnnoX27J1ahnP1V3j00sk2BkpUrWdLkoDSLV05uEL1uVG+zxsRbkbib/5Lv8Csnlr8sMfrJaUHZwp8eVqW6l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448186; c=relaxed/simple;
	bh=069UhOXOJgsi1oIjqBENDlkBNgO/tL7N/jC2rM7iMA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rqXxbu5/G2SklQZ1WKdQNWHXykO9meNVjnFYewRdmQIvKMsWjvAReEIm5BSzfHcHYAdz9RcmpJTWMR0t1xJ5zYlpUPd1T/4EIBE+Cws5+1Efww6PkOhrLPLsliNiq1dnrYCDuyMQRt7RJ7s4krcQYOOVYcoRtvQCvLT4m2uTOpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Na8DiMyd; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640f0f82da9so2121043a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1762448182; x=1763052982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1d33Qfkr/UySDlVInSW41vMX+/10XV70RYaxgiV9H4=;
        b=Na8DiMydQN2WVmieNbNglQINnhzqan47t244XAjhIkPu8H/cHjeHyAgUp//4QJiXWR
         8HZMFFXfOuYoTd2QzhCOIisa93dHIYpw0tt3iZgfyqdmnLkvfkid2pa8A2lrQMCMbjCN
         zuCc+GyF9lYHrZh1SVk4XifTtBNZRiXvAzUZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448182; x=1763052982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y1d33Qfkr/UySDlVInSW41vMX+/10XV70RYaxgiV9H4=;
        b=Qh61he08KFoba5nCuIIcMpVvyjaUMSjNcdQoBkO1DnW1+/dZNwN+ysvKGf8OnP/+BH
         uw4+IVzG0BL2aQTM/MxEf5LbAHfu98EjnRjDLpGU+4JBq4Cam4fjdTif9rEPJozfd8wL
         7KROZ98njELPTnXpuGc26PoOqdmoLDVNxidaok5XUoFXjaAioh112cjPAfrRRPo7kbnd
         3imfmXPvl2dCtHPYmczomqzWlvynKlGICBYalYHhtOvCkJnPhcXtX6/PSPN9+7BDbS1v
         Pb5dCetHg53Upq15SDFOGw1mwrXBX6ZVIrsxUJr6OINTiyegkCuG5GrPSWDJhMrF/60U
         6fQg==
X-Gm-Message-State: AOJu0YzVna3rfsDdcm3YMgtNSlQaoBWPCJjGB/GhdLkT9cdPhQRbe2fJ
	zp9NJlLv45ZFtPO1Gcu0/AVu/3njzqjxdW2nWU6DBSUM2biwgT1nReBICUmSFl/7RDck097EYgl
	/FyA=
X-Gm-Gg: ASbGnctp/q6tgMwlnEe0GR+INHpK0PPCEfIFLnOwunrU5nvNVE7hsTkl4UZR9vr1wZ5
	Vzy9i/6iW2u3YG/EwPg4xsqS88fqLKo2sZC0Z9UDh2nXB1JyVPsNqFH/dCEWpbaYaNyy+MFWW55
	wh7dCEeZwPofxUm3cohHfPQ5AA05ZVsfHONTGPxd+vLu9ZlDdiVAbeL/+Yhukr2PswffUpfjzJ3
	GmRp1ldU+8gTe5dkBG88Xv6yt6xHU1mQ5tLaQd8J4/jeNv305Xl2azTFPD0ngAYjRIXFniTeQC2
	mRmRJXWR72jbUb8sC+pm7RbPXc1mhdAxJ6BzvtIwH5WEHmSgz28bDO9TWTCBZ/v038DY1JwIzFD
	BeSHuICoietYilmB3mLKG0GsY2UoRbbVu7JyQxSOO3slV54eJ7+FcPLen5+Wo8YoVC4gVQZw7Jo
	HfNunJEBZ7u+Wzcm5IxqnK3jQL/UKdLtfS1mAu9Mo=
X-Google-Smtp-Source: AGHT+IFJ3VQix7tPWRjOC2nHaPrM1agPeTtri+WJU4m2j2aqDdVQvIRjy1m8vP/8H1H1PbxHA+JOjQ==
X-Received: by 2002:a05:6402:26d2:b0:640:6653:65c1 with SMTP id 4fb4d7f45d1cf-6413f059d91mr48283a12.5.1762448181688;
        Thu, 06 Nov 2025 08:56:21 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f857839sm2331726a12.21.2025.11.06.08.56.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 08:56:15 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso797475f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:56:15 -0800 (PST)
X-Received: by 2002:a5d:5887:0:b0:429:c505:99d0 with SMTP id
 ffacd0b85a97d-429e32e4484mr7115033f8f.25.1762448175160; Thu, 06 Nov 2025
 08:56:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101040043.3768848-1-ajye_huang@compal.corp-partner.google.com>
 <CAD=FV=XqgkgLLOeozooypbwiO-8j0ZNy_GJ1UD2sXL1EKzC=Fw@mail.gmail.com>
In-Reply-To: <CAD=FV=XqgkgLLOeozooypbwiO-8j0ZNy_GJ1UD2sXL1EKzC=Fw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 6 Nov 2025 08:56:04 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UoiSAhHOs=HUoGU-kX_ARc_EJP5p7_Ozo7u5vcY33GSg@mail.gmail.com>
X-Gm-Features: AWmQ_bkJiA0NM5kHBq2AiPq1aBIwz3sEY3uTcdzu4ZMGksAVclFhXHwVsuamfP4
Message-ID: <CAD=FV=UoiSAhHOs=HUoGU-kX_ARc_EJP5p7_Ozo7u5vcY33GSg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/edid: add 6 bpc quirk to the Sharp LQ116M1JW10
To: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Cc: linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, jazhan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 3, 2025 at 8:38=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Fri, Oct 31, 2025 at 9:01=E2=80=AFPM Ajye Huang
> <ajye_huang@compal.corp-partner.google.com> wrote:
> >
> > The Sharp LQ116M1JW105 reports that it supports 8 bpc modes,
> > but it will happen display noise in some videos.
> > So, limit it to 6 bpc modes.
> >
> > Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
> > ---
> > changes from v1->v2:
> > * Change EDID_QUIRK_FORCE_6BPC to BIT(EDID_QUIRK_FORCE_6BPC)
> >
> >  drivers/gpu/drm/drm_edid.c | 3 +++
> >  1 file changed, 3 insertions(+)
>
> There was some extra testing and summarization on the internal
> discussion about this problem that cleared up my confusion and I agree
> that this is the right fix. While the panel does properly link train
> at 8bpp and generally displays images OK, showing certain images on
> the screen displays consistent corruption on just this panel (other
> 8bpp panels are fine). It seems like there's some sort of subtle bug
> in the panel at 8bpp. Limiting it to 6bpp, which is what the panel was
> originally tested with, is the right thing to do.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[1/1] drm/edid: add 6 bpc quirk to the Sharp LQ116M1JW10
      commit: f23e40e378a0858da26e8d5a6f09f82ecd95e247

