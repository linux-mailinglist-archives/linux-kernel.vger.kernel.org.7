Return-Path: <linux-kernel+bounces-883368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC548C2D2FE
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2ADFB4E38EF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30903191A9;
	Mon,  3 Nov 2025 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ncDcDXtE"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BCC3191A7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187922; cv=none; b=UWpSGumeOZHwcdBd3b2yJXDvdSDGDJ+nANUnw8XGiss6ipLxn5JsNqRlvrzFmzzQvmc38bigSTp4c6TYeK1M/1iVTbMSARPaC0fMYtVhk7d09+syDyI6mvPzD/JBfmC9+tu2eK2r3xZhTJJmTCVYtURfmcI0h6NcJ8PhD+FgDYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187922; c=relaxed/simple;
	bh=ugpnQsXckZt8k/jK2GvgevsO8E2hSbtVUXhEJG2Fh90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acgt32uLjsw4Ol6gyCbIJcj3jCHqEG7e3tJQTrMTw2DQnIdZrhqw9EypxipvJuYmciS48POWsncgEZKcD0TJZ9lh8JMsDGFy39vkTo73j5x0dUFVzurqYFAI5goO+v5pxF+f5UsfONmCrehM+nUcnMTl5SCkjB88HUaWOINhNo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ncDcDXtE; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b6d4e44c54aso608012266b.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1762187917; x=1762792717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PghuBkXqlQuLQvvfx47tjZsK1SlCyBf84+57arPAJ2o=;
        b=ncDcDXtEpGPZMLHrSGh3BxkYRAOgIf2LvSVaKfq0C1Q1hTVQSb2UxeiBAXUZeb1Osr
         5BxouHvNa1eAUEpq0SOKokNuP1NJjHMw+Qs259+UwLKIOJHcRNek1dJe2EmCZMVv8zeT
         CVggCJHSCb0lMRcmxf3xw4314BLjhHtiiUbYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762187917; x=1762792717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PghuBkXqlQuLQvvfx47tjZsK1SlCyBf84+57arPAJ2o=;
        b=KPwVRIqH/VLGkTo8jdYOnFEJYMZTKYBD2zGtugFLi22yu7UpCUlI+wXNBNw2MwUwX/
         GbZX7/Dq3g2EgPTYoKn8IDdwZaIP1T94RsKL0OL0m9AYR4eFzshXAwSAukjOEB9fZQ9s
         2+xv3M3cml0KRnrmZmWCOJJ5LjFmXY55Ocw3SOEc80ph48vZqlPLpWxxvtZz9RO6Lzi4
         Jved8L0pNYl6gt/Dwqc8gQrnMQOFcmC26xXNhwIyRo9RQ46mO7HGjx6kgzXN/X1J7r8l
         8uiymldFzeq4D5yXuwWBXIZhg5upEpK5IMDzOMdgzLSEcDmqYrWkCjIk9kil/vAkJBkV
         OloQ==
X-Gm-Message-State: AOJu0YxS3+vmpYXs+mYgFIcT/WmX1RJqNvl2UuZ+9X7w+ZOf+3MxndFR
	Shi/rMnNariw1rTSFT7o5vr4s+bz+AuakwDsyhsnBc1EiuqQ4avos8gME+dFiURevBX62Ilnne+
	mQyQ=
X-Gm-Gg: ASbGncvuQDWrKeaIggOoBqzuP55Z65fTCdL3NAjEkjN5LnOBlkRKnAGu03Ek9gK4Jqf
	sX3+m93vr9AqvyLrkMM39tJNUKqjSKPtirlsxKjFtZNPmENq1l4XsNJwgg5qfKQqk8T+oaChTmz
	gglYfXM5ElEAcHOIbETwDl5s120mCULUyvg8oBpHnDlikBY+cmlB+W71V1ajlBnQARLTQ/HUZqc
	9agtxk7o4uUbrqBC01t0r773PGfSxGAeNl8FOZgt/dTlrSttsqPNQBWskoLaGA6QdsqZK0jAa4l
	y/vndHFhMWOIumvqRrxO+RYq1mmsP8wdkWg34GqUFcSBysAMShotjEKxsrpL2H1PMBiGM2tRqX3
	WYHIB3w0cO/Ppc4cs9RzfWBA1Tjg3k0dbEuXt40KeBw1oBZGl2Je2GFVprBEVNEvIOmrjAWKrjo
	h7vfctLhjPNwFoH2naFj/NpqSJn750MNhndU+dGxo=
X-Google-Smtp-Source: AGHT+IGnvCnzB3igf3IOw89IjbxREMhrTSU0yHFohN4KYHgBeiQJuzB8y7FvFQlSThgA8MGR5lp2lQ==
X-Received: by 2002:a17:907:3f02:b0:b70:f2c4:bdf2 with SMTP id a640c23a62f3a-b70f2c4c118mr368662766b.23.1762187917292;
        Mon, 03 Nov 2025 08:38:37 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70b2b4a802sm498811666b.23.2025.11.03.08.38.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 08:38:35 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-429ce7e79f8so1188073f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:38:35 -0800 (PST)
X-Received: by 2002:a05:6000:2383:b0:429:d66b:50a1 with SMTP id
 ffacd0b85a97d-429d66b52cbmr2236083f8f.22.1762187915153; Mon, 03 Nov 2025
 08:38:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101040043.3768848-1-ajye_huang@compal.corp-partner.google.com>
In-Reply-To: <20251101040043.3768848-1-ajye_huang@compal.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 3 Nov 2025 08:38:24 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XqgkgLLOeozooypbwiO-8j0ZNy_GJ1UD2sXL1EKzC=Fw@mail.gmail.com>
X-Gm-Features: AWmQ_bkbUC_oSCELL5XoimElzVvNkzBNl9O2Hy0wzDnBb9GrSFRmMX5_QbbO5eA
Message-ID: <CAD=FV=XqgkgLLOeozooypbwiO-8j0ZNy_GJ1UD2sXL1EKzC=Fw@mail.gmail.com>
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

On Fri, Oct 31, 2025 at 9:01=E2=80=AFPM Ajye Huang
<ajye_huang@compal.corp-partner.google.com> wrote:
>
> The Sharp LQ116M1JW105 reports that it supports 8 bpc modes,
> but it will happen display noise in some videos.
> So, limit it to 6 bpc modes.
>
> Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
> ---
> changes from v1->v2:
> * Change EDID_QUIRK_FORCE_6BPC to BIT(EDID_QUIRK_FORCE_6BPC)
>
>  drivers/gpu/drm/drm_edid.c | 3 +++
>  1 file changed, 3 insertions(+)

There was some extra testing and summarization on the internal
discussion about this problem that cleared up my confusion and I agree
that this is the right fix. While the panel does properly link train
at 8bpp and generally displays images OK, showing certain images on
the screen displays consistent corruption on just this panel (other
8bpp panels are fine). It seems like there's some sort of subtle bug
in the panel at 8bpp. Limiting it to 6bpp, which is what the panel was
originally tested with, is the right thing to do.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

