Return-Path: <linux-kernel+bounces-880346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E91C25917
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766813A6CB0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCC633E363;
	Fri, 31 Oct 2025 14:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jxbxuuNg"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7622B2222A9
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761920666; cv=none; b=e1YXyCTcEjbkDPg9aHOrCL3YOt/l32lLSJ9BFC9pFethgaF1f2GDcf1Ef1FvuIwWqm5V4VkakOFMsE+NXORP/Xeu7NOnxjwdhS7B+Q2kp3i3ZGpwTaO5Zmhv7wgePOuO0mH2/9LVYnQcO8pmYOFe42jBiXCm/KVDob0zB0pt+BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761920666; c=relaxed/simple;
	bh=sn481Pbtg30Ig0+fkdFzlUzNl+Bj8bdorFW34ITxOpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9KcuES3IxSeHW1AK5i5g+w/DuqV2204/H1C1C6XyrxD2yTZHd9v+a1rpTBWb/TBZfLTO5XVLFWeQ3L7JFnEQv2EjJjdGqZjBTOCxVyBlkm1+rY8R+GzxA9ZJmOJ8if7ljSviSyuGaHKH0LIEtQHhTad5GcPkuKI8qZnJxO1RLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jxbxuuNg; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63e076e24f2so4446655a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761920661; x=1762525461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyvLR/aTPgdHtklMf3S8VVUt+hq3yvjQCoTbWQpjR1s=;
        b=jxbxuuNgUu+4p/wp7E3/ls+hDjBuG0+0diJItQIq4Zulpe7Bh+Lv3C8aYVYthJKq0R
         zXYucfeVQlU1y7Odfbvy6sLnVO58IKCtKBIbgKi0ri8RSHfvk86gQkMo8wjKZUd6gBHA
         Vz1Uyq2NVBlkVvb5vyaQUWJtTvezOMEjyfISw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761920661; x=1762525461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UyvLR/aTPgdHtklMf3S8VVUt+hq3yvjQCoTbWQpjR1s=;
        b=pMAqnlQJbikOCllcBp0Qc/0i6QaRLO8/KZESP5yD/7TpVMnVFMkaA6Qqvdemujuyjn
         DidlW91YTJfKbRgkEth0VK7zu8CCdOb3jO+irDT95d7oETCXV7RpnbGoLy/XHVVw93CD
         0vZD3XjNKxaTkQDean3d9Em0FvacfF+6MH1zmQpRZiZ+ZqF+ezUfinBLdxrFr415xWvq
         /3tiPz2pbsgxNZcdVbNGzqpuigHtZ1jxym5T6It+oB1Po20+CvYLq7YDjWl0tJaFpLQH
         MAx34aMYl4N85fYtUC54LAxCzyCn+pMyj/LES+5WuqeR+cpYKX9BC9SkP79HX/U6bu5c
         P+6g==
X-Forwarded-Encrypted: i=1; AJvYcCVCYwKDT5jhSRwcl8nUH7FFawr9zfO7Lnz/N0unee7qRGyxzfMbAVQZYDx0T68d0gpNoiQN/xOUgGpoXa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT7tTzdJY0pMf8QOuM32abiNMPcVauG9FOExSJhFCFwG0JGw0S
	HKpcSUw607MYxCgeSXGeqw4VxxJed9bZ04RU9BCezbuXvdKiXCtG8SoAqEvkABkgg5AbBPdy9gy
	uMfN8YO5G
X-Gm-Gg: ASbGncvfPFvPy3NfOGV3LPzwaO8qYHj1gvMiIYl6Ig+fqhbx5MmHQxbCXLwBI6mNIQC
	bmoF66aiamdLg2PiT3VpHYLNYBWyOXwPMbDgS875JkDC1LNgzWDtlM/X051p1BagNxsGTMZQf1m
	ULIv0fQjZtpV1f2/CYt7dzjwqFge7taf4siqAjWMu6+T2+Yk3Ox1xfUmx2hseRmdPYO/LANNfXq
	4nwzQXhftiS9iSyA1E0+EaOyw8fkPDZG2MvVepJEsufPD7SrNTW270MJBn/EJUjImjlb0oAos8u
	oKMRdOfmGDk1zlqBdCtvrbOFk0778s2JD/NluN6ZnvZkge296PU3gQfcI3V/sBtxaK8SyRTdzJs
	z8/xtAg5HgJrztOvWDvb0eQCpvu+bek+5Zh1QeQOi7tT8FX69rZCeg+WpY4vvxYE4CpiYbywber
	+ksjilqakLQ+bZIVltnldPq/QlG6sUeQv5cWYYbtq/2cO/ejr3Rw==
X-Google-Smtp-Source: AGHT+IEql6BAZVVTd6HvruggnAFDB2lp07x5sOSofoDEVRG+Mh+chqo68Wat6RXtykRmHvydYLjHHg==
X-Received: by 2002:a05:6402:51cf:b0:63c:45fc:7dda with SMTP id 4fb4d7f45d1cf-640770bc399mr3103494a12.20.1761920661223;
        Fri, 31 Oct 2025 07:24:21 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b390d7dsm1691217a12.10.2025.10.31.07.24.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 07:24:19 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47118259fd8so17365735e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:24:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjofHRRhftzHYKB0H6OpyMAu/BMMSLmbDM6DVzLuuTprniwIaMRZrCE09U4pDkd8dLTTHJC9GpePirVfk=@vger.kernel.org
X-Received: by 2002:a05:600c:608e:b0:475:d952:342f with SMTP id
 5b1f17b1804b1-477308cb956mr34652905e9.39.1761920659162; Fri, 31 Oct 2025
 07:24:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030094434.1390143-1-ajye_huang@compal.corp-partner.google.com>
 <CAD=FV=V6xV0m4pj=7f2dxDP-0A1AaQuYJP5NAnXNz1_bzH7nSw@mail.gmail.com>
 <7071a2b8198c09011c84d39b45dc6d1da4b69d12@intel.com> <789d88744fbd3a05758971dc8d893fb4599475f3@intel.com>
In-Reply-To: <789d88744fbd3a05758971dc8d893fb4599475f3@intel.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 31 Oct 2025 07:24:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XuWkudYB3OhPZrLJ0jNXFRyV1c6=czqn2RUo2M9CES9Q@mail.gmail.com>
X-Gm-Features: AWmQ_bksWOd0CYzbEkU8DSTG-gAmtEAtGD6CyOC4AsR3tFevBy5nPue1f4Ho5ks
Message-ID: <CAD=FV=XuWkudYB3OhPZrLJ0jNXFRyV1c6=czqn2RUo2M9CES9Q@mail.gmail.com>
Subject: Re: [PATCH v1] drm/edid: add 6 bpc quirk to the Sharp LQ116M1JW10
To: Jani Nikula <jani.nikula@intel.com>
Cc: Ajye Huang <ajye_huang@compal.corp-partner.google.com>, linux-kernel@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 31, 2025 at 3:40=E2=80=AFAM Jani Nikula <jani.nikula@intel.com>=
 wrote:
>
> On Fri, 31 Oct 2025, Jani Nikula <jani.nikula@intel.com> wrote:
> > On Thu, 30 Oct 2025, Doug Anderson <dianders@chromium.org> wrote:
> >> Hi,
> >>
> >> On Thu, Oct 30, 2025 at 2:44=E2=80=AFAM Ajye Huang
> >> <ajye_huang@compal.corp-partner.google.com> wrote:
> >>>
> >>> The Sharp LQ116M1JW105 reports that it supports 8 bpc modes,
> >>> but it will happen display noise in some videos.
> >>> So, limit it to 6 bpc modes.
> >>>
> >>> Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
> >>> ---
> >>>  drivers/gpu/drm/drm_edid.c | 3 +++
> >>>  1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> >>> index e2e85345aa9a..a73d37fe7ea1 100644
> >>> --- a/drivers/gpu/drm/drm_edid.c
> >>> +++ b/drivers/gpu/drm/drm_edid.c
> >>> @@ -250,6 +250,9 @@ static const struct edid_quirk {
> >>>         EDID_QUIRK('S', 'V', 'R', 0x1019, BIT(EDID_QUIRK_NON_DESKTOP)=
),
> >>>         EDID_QUIRK('A', 'U', 'O', 0x1111, BIT(EDID_QUIRK_NON_DESKTOP)=
),
> >>>
> >>> +       /* LQ116M1JW10 displays noise when 8 bpc, but display fine as=
 6 bpc */
> >>> +       EDID_QUIRK('S', 'H', 'P', 0x154c, EDID_QUIRK_FORCE_6BPC),
> >>
> >> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >
> > FWIW,
> >
> > Acked-by: Jani Nikula <jani.nikula@intel.com>
>
> And as soon as I hit send, I notice the quirk is missing BIT(). It's a
> bit mask, and the enum signifies the bit number.

Crud, that's not good! Sorry for missing that. :( Definitely glad you notic=
ed!

From off-list communication, it sounds like there is still some
digging going on to see what's really happening with this panel, too.
There is still some sort of mystery...


-Doug

