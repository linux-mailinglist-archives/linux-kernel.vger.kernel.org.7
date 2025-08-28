Return-Path: <linux-kernel+bounces-790838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49726B3ADDE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0617D3B097F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809E52980A8;
	Thu, 28 Aug 2025 22:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZMj2glJm"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F966285CAC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 22:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756421574; cv=none; b=t26fkP9ynNdvaLWcxNdQDb0lgOHEr86hsrW+ogHMnNd8eaZPIvkMwchwhevsZ+F6h6xTk0k6/JvU/A0+f1Jqk2kFSCEWXVKbkbbkSRV25S++YXbsZTvbczo5P6ZiTGTt2WLPZS13S150itqlJJDZQhm50EXJ9kVkn1IhpJ7btd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756421574; c=relaxed/simple;
	bh=fu86Ald7tqqA3nYrxZxsFpT0WhbJBu30dcAkxkqb9jU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XLiCkAI9+Gir5GppI828Y74Y+pv/O8Un3zM4xt7RswFRygB0XlSxbQV86M3jD4nXQUS8D8qtIRnQ3Ggs+AHWXdgGvT8XxO0rlDAhjhAI64SUYglstkJXX0Epwqbb/2DtHDgvMcLWcsudiTNkYFt3tIr/ECZOu/3SjKElXoeEKMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZMj2glJm; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77201f3d389so1644566b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 15:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756421572; x=1757026372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fu86Ald7tqqA3nYrxZxsFpT0WhbJBu30dcAkxkqb9jU=;
        b=ZMj2glJmhw50evkmIEnIj4zJvyOKK5ToBm4/mPWLb2TwQ9FpUGOjIiKG+LpLM2Uu/1
         3Vh68q9M7M8o5GSdV43T4eLT/Xv1oyM5lc+nhiAKfb/ASAzmWQGwFx4FjStFupQcMSSn
         64hHFSMj/xGOQlliNb7TfPWX79jMrxRHKoiTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756421572; x=1757026372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fu86Ald7tqqA3nYrxZxsFpT0WhbJBu30dcAkxkqb9jU=;
        b=dk3HnLFIMJ0yZrl2UUdVa2E0ZGZygc6J1YcBoTo5HGC/u/x+0CPMHc+XTp1n4qxjCW
         12vEqv6obNcS0ik/BUxq+BaFizZ266nhB9plL4lAOmtB6S0BbCrXajLbDWJurk6ZcDyC
         5gV0iQ5WijJolO4Mig/9HDv0R1ftdZ5JmBURxpVk/27WVvgRiT8EsbG6kwvsCF+DMK2E
         mbEwe0S5x0XuOUwvhZS8m3TY/yp10wuNNCkJQVzlT0SPNqfdM4Fi9HiTiF6KGmTkQ0JM
         bJ5tJYsl8ujIcazBNkNPX3nKc2k6o2YdnzwBvXNc3dmIHo450K3apMiAcIvH8YXvM3RN
         zlmg==
X-Forwarded-Encrypted: i=1; AJvYcCV//UHO9QR1uGU2a8LnARRPwTJ6SllamGnXT0TaT6DuyShoR/s537nEm7TMZCyoOQPQh55wdx2tGIBS4Dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEeDeB5BPzVrAsMfarAM/D3pSOY4VxpLc7HzQHkq7JoS11jusd
	XdMH6uhVlseD8KdxIoRSdBbNiA6eWGk0zBGreje1AlOT0LrgnpQVkgBYTeN597VaIxwdHOiLCGd
	/Ums=
X-Gm-Gg: ASbGncu+Y4+5ggEsQZxJAhXVhHj4VMi0HrCvh3ZXBSWf9Xv8APP3rFRfZ6cCKgFs98D
	7dwORmxDlktBf5Gc1nBByf0jNggzfr31QSQxT8eSXRu0fBTdp0UBPFqd0+XBhgwlh9Vsp7XB7Bs
	DkJlvG+RUbsCpEw0oBEgXGgxbpJtiIN45WvHKrpMhCVtmJvmkAo+zlNoSYVD6eR6MhhgWL8t8FO
	lFuzogRpEM56WdBxPTLwJhvWRLsVUQd6sUztE0326Ymw4mBPEh4kzJx9ls8YujE9wxBZIEij2hP
	U8g2fBxBZbFJe3M86P4jzm8yLwKNhLBSIN7UBYWwzxV1sxz01mN2xky81uQXJGaXqH8zfZ8m5or
	UZtbWtS3BfqT8ojcJhimZpkSNuSQTUxiW0ZIvoGfOyNtcoB/Q60w39wZyYq901Z/kupwdtSiTqw
	Jo
X-Google-Smtp-Source: AGHT+IFy9nNNrZ1UEBJq9CJIZ05PsEc5bynrXBMuLnHkOl9NEaHPAOZcyLFSVgS7UiNwfSkuR6AGIw==
X-Received: by 2002:a05:6a00:7619:b0:771:b230:f0a3 with SMTP id d2e1a72fcca58-771b230f3a2mr19150489b3a.19.1756421571883;
        Thu, 28 Aug 2025 15:52:51 -0700 (PDT)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com. [209.85.214.175])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26a0b3sm531889b3a.10.2025.08.28.15.52.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 15:52:46 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-248a638dbbeso13602545ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 15:52:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdK8xHYOPssM4SaaQbAFD26WJ2usweYQ4voq67G/BHjQLIQPtVbpXco19vSfqs4zgYQT/zAxCLJOWJNW0=@vger.kernel.org
X-Received: by 2002:a17:902:f612:b0:248:b25d:ff2d with SMTP id
 d9443c01a7336-248b25e0a84mr76625375ad.51.1756421563760; Thu, 28 Aug 2025
 15:52:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821122341.1257286-1-mwalle@kernel.org> <CAD=FV=Xt-DPHRddZM=t-KTWiGouNfm_QpPps3MA6csd+j=YO+A@mail.gmail.com>
In-Reply-To: <CAD=FV=Xt-DPHRddZM=t-KTWiGouNfm_QpPps3MA6csd+j=YO+A@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 28 Aug 2025 15:52:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XCOPeEgpjvCuDjT=OjEk1P8vszL6iJqkY-DcpXtpXTjA@mail.gmail.com>
X-Gm-Features: Ac12FXxGQ3gwKFNpja0uZrKs0DRled9vAzxyIxlYJEziCVKJJ63hTgomuUTkhic
Message-ID: <CAD=FV=XCOPeEgpjvCuDjT=OjEk1P8vszL6iJqkY-DcpXtpXTjA@mail.gmail.com>
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

On Thu, Aug 21, 2025 at 7:36=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Thu, Aug 21, 2025 at 5:23=E2=80=AFAM Michael Walle <mwalle@kernel.org>=
 wrote:
> >
> > The bridge has three bootstrap pins which are sampled to determine the
> > frequency of the external reference clock. The driver will also
> > (over)write that setting. But it seems this is racy after the bridge is
> > enabled. It was observed that although the driver write the correct
> > value (by sniffing on the I2C bus), the register has the wrong value.
> > The datasheet states that the GPIO lines have to be stable for at least
> > 5us after asserting the EN signal. Thus, there seems to be some logic
> > which samples the GPIO lines and this logic appears to overwrite the
> > register value which was set by the driver. Waiting 20us after
> > asserting the EN line resolves this issue.
> >
> > Signed-off-by: Michael Walle <mwalle@kernel.org>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> nit: officially you're supposed to move your Signed-off-by all the way
> at the bottom of all the other tags any time you post a patch. I don't
> think it's important enough to re-send, though.
>
> In any case, thanks for re-posting. I guess it kinda stagnated. I'll
> give this another week on the list and then plan to apply to
> drm-misc-fixes unless there are any other comments.

I realized that this is lacking a Fixes: tag. I went back and
confirmed that even in the first version of the driver, AKA commit
a095f15c00e2 ("drm/bridge: add support for sn65dsi86 bridge driver"),
we still had no delay between these two lines:

pm_runtime_get_sync(pdata->dev);

/* configure bridge ref_clk */
ti_sn_bridge_set_refclk_freq(pdata);

...and the last line of the runtime resume function was turning on the
enable. So I believe this means that the bug has always been there.
Does that sound right to others? If so, I'll add that Fixes tag when
applying.,..

-Doug

