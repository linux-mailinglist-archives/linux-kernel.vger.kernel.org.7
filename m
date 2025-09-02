Return-Path: <linux-kernel+bounces-797066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F93B40B6B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 614B73A90F6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0151B33991;
	Tue,  2 Sep 2025 17:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ubud9N2T"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933022DEA8C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832402; cv=none; b=HFdLWXGEQjgcbfSDQBBCb2K4dSKt/GAFL2ki8KCYoF1gWMnDncDZq7wQBo2wH9X7+bI5hMlcD0nAr8Bt/Udw7X6V8KVU37RPOYb0H3jjezEQ62l9AU5WnT1aU0JI+WupBz7r9vaPSDo9aXGKlUKVoY4RetGCHH6QI48YU4VxqRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832402; c=relaxed/simple;
	bh=r+l3oNJ4SId8FfL4V/JF4ESC0GsDE6ChktZiYVmXEco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IF78Vk2i/ancfX2+/bPdt8FtIXm5UPgrF5UYnOOAyAWT5w1rN4tuElABtrUyfIGb0Ag9bCJbNXDSg2FYILqdd/LG087Axr9tdEsrK818DYr5lnwr5TvYiJMxFkkF09sl//fxQ/oHm9fjf7jVVguLFCLCS2Tw4chr/s9cci2sckw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ubud9N2T; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-772627dd50aso89924b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 10:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756832400; x=1757437200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sx/eWzBaFotQQku5gjUvj/pIO8VOIElH8+WudO86yI=;
        b=Ubud9N2TlvSAi8Y0jB0L2uMVmcF1zDLhu/bY58m/OoYWpdXSnvjgcVliXyS+pyXFBH
         UF9ntv6uFh9vFFoTjz8ma5Mj0xF2ty1DOrYvRBOfkCjfwh3AC19i6pkp2qD9fCaVishb
         F/oAZS7Ck20Ad2VvUYkUI2LvvGzdsNbpC1e8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756832400; x=1757437200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6sx/eWzBaFotQQku5gjUvj/pIO8VOIElH8+WudO86yI=;
        b=OsooYaCQxYCYz4oNS56Y+Ka9MnyhkVUc+DceUriPoseDn9T+7S5YE2F/vZ2Svwp4Dc
         QDKfMHnxPHYULzNoaNA0v9Vn8xpNMC3+9y5VPCB88u+DhdZtQ9BeEntzmTb383d6wOJA
         CibR1l9NioQ5NtIROHY8ZbBSDBXwQV1fERecDQ2Zw9Jhc5x4rx5nsTA9xiM9UfM/4R6V
         CwttlD7KhNConbGwKQZ0TGchIODYSIBPZQ9AYpm4JX16RHUH4sQxwZpD/44ECuacVJ0t
         Ghlh0BXQyuNxbdrb4dc8HiMAFSfEwVQZCmIotMLjeKQWUk/cqdoJSg6frjmGL+dkAez2
         JqCw==
X-Forwarded-Encrypted: i=1; AJvYcCXSoboIPf6/Sfs5ITdi5Uj17FjtPF8SDF6jgDEH1MZqr0N+Z+qElknvT22MxeQ72OQs2Xdivgfs1YPIQKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQnCdkEtekCfgjh4iM+cihgvntvQRHoWDXsYlhhkQEmzpa9ZQz
	yBn2ZvCBcX21lWomLLFCs3fOY4RjxPAXvS4Lxvjv49IaXhtNUB062IXu3QIEsuGLcayGAGe+g4F
	uTjQ=
X-Gm-Gg: ASbGncvnLL9chPUHA9WDQbLdNO7D4ELVW5Ud/GTx10ssUpXNdmmRC14BAnAW+d87nTA
	uFCl7glt8Gq/FdBokvQGEBjKpBVT7v8Cs5Cv+bT7dMO0AViZaqBabRyug8IK+VCPnga//RyYQ/m
	bnD5KZSKNXORb+TA6gZ71/tdBBOxzKqfitdDQCfWkoJAqwLzVaczwOOPNtPsfIIEeQ3cuYVw2zw
	GGQCCIt++agjJCgdjKJD6YhbvQNMeDUCfbh6DTjNPTUCAUmQIhrdIaG/hqrxF01fIOVb46CeEe2
	pcit+4eRu2VvULOA02RTB1DAbaKPx2YiAMdacD3fO0bjEaLPQByVjbdnYjgOBJ3DisqKT9Koo8t
	kLgk3ujIOdwRvlx4zOBmLcMzGIPYeMmjGl0YLclhjAN0ZnyPgHMPyqAcYnUNkZHnh9LA2/evOA2
	dr
X-Google-Smtp-Source: AGHT+IGyBP2f47aCnihc2qeU9pD+Xs4zSlLu9sES95XKszSzN1P4UUxGIAbnXXGScXwrsDb1oEQlfA==
X-Received: by 2002:a05:6a21:329f:b0:243:d160:2563 with SMTP id adf61e73a8af0-243d5236067mr18511369637.30.1756832399879;
        Tue, 02 Sep 2025 09:59:59 -0700 (PDT)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com. [209.85.214.174])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4fa1a29cedsm316590a12.46.2025.09.02.09.59.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 09:59:59 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-248a61a27acso670985ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 09:59:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzhztjlyE4jMwSwOqjfBshd82iG+9CDdcc2wCvdWH1SCo1jYDY8xbYgbfFBqusv2/YT1L/k9IcYM2DQ64=@vger.kernel.org
X-Received: by 2002:a17:903:32c6:b0:249:37b2:8629 with SMTP id
 d9443c01a7336-249448d70efmr144203085ad.9.1756832398561; Tue, 02 Sep 2025
 09:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821122341.1257286-1-mwalle@kernel.org> <CAD=FV=Xt-DPHRddZM=t-KTWiGouNfm_QpPps3MA6csd+j=YO+A@mail.gmail.com>
 <CAD=FV=XCOPeEgpjvCuDjT=OjEk1P8vszL6iJqkY-DcpXtpXTjA@mail.gmail.com> <DCH8VNHTN1LM.3068OZU8IMK3Q@kernel.org>
In-Reply-To: <DCH8VNHTN1LM.3068OZU8IMK3Q@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 2 Sep 2025 09:59:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UmZGyd9rYP_o33wC5kmLjipKgfTpJANQSpoaHTygEBgw@mail.gmail.com>
X-Gm-Features: Ac12FXxDmRDCsG9DVPcoNOc_dFYn_Vhfyw89OEI_5qUo5EjmfZKE4uUeH5xTVKw
Message-ID: <CAD=FV=UmZGyd9rYP_o33wC5kmLjipKgfTpJANQSpoaHTygEBgw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: ti-sn65dsi86: fix REFCLK setting
To: Michael Walle <mwalle@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Devarsh Thakkar <devarsht@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 31, 2025 at 11:20=E2=80=AFPM Michael Walle <mwalle@kernel.org> =
wrote:
>
> Hi,
>
> On Fri Aug 29, 2025 at 12:52 AM CEST, Doug Anderson wrote:
> > > On Thu, Aug 21, 2025 at 5:23=E2=80=AFAM Michael Walle <mwalle@kernel.=
org> wrote:
> > > >
> > > > The bridge has three bootstrap pins which are sampled to determine =
the
> > > > frequency of the external reference clock. The driver will also
> > > > (over)write that setting. But it seems this is racy after the bridg=
e is
> > > > enabled. It was observed that although the driver write the correct
> > > > value (by sniffing on the I2C bus), the register has the wrong valu=
e.
> > > > The datasheet states that the GPIO lines have to be stable for at l=
east
> > > > 5us after asserting the EN signal. Thus, there seems to be some log=
ic
> > > > which samples the GPIO lines and this logic appears to overwrite th=
e
> > > > register value which was set by the driver. Waiting 20us after
> > > > asserting the EN line resolves this issue.
> > > >
> > > > Signed-off-by: Michael Walle <mwalle@kernel.org>
> > > > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > >
> > > nit: officially you're supposed to move your Signed-off-by all the wa=
y
> > > at the bottom of all the other tags any time you post a patch. I don'=
t
> > > think it's important enough to re-send, though.
> > >
> > > In any case, thanks for re-posting. I guess it kinda stagnated. I'll
> > > give this another week on the list and then plan to apply to
> > > drm-misc-fixes unless there are any other comments.
> >
> > I realized that this is lacking a Fixes: tag. I went back and
> > confirmed that even in the first version of the driver, AKA commit
> > a095f15c00e2 ("drm/bridge: add support for sn65dsi86 bridge driver"),
> > we still had no delay between these two lines:
> >
> > pm_runtime_get_sync(pdata->dev);
> >
> > /* configure bridge ref_clk */
> > ti_sn_bridge_set_refclk_freq(pdata);
> >
> > ...and the last line of the runtime resume function was turning on the
> > enable. So I believe this means that the bug has always been there.
> > Does that sound right to others? If so, I'll add that Fixes tag when
> > applying.,..
>
> Yes, that's right. Thanks for amending the patch.

Pushed to drm-misc-fixes:

[1/1] drm/bridge: ti-sn65dsi86: fix REFCLK setting
      commit: bdd5a14e660062114bdebaef9ad52adf04970a89

