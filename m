Return-Path: <linux-kernel+bounces-842158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51963BB91C0
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 22:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5CB33464F5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 20:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600DE27EC73;
	Sat,  4 Oct 2025 20:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Efz+PsKc"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD722153E7
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 20:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759609372; cv=none; b=fypiyEByQLSmdDqEmS2nAC3TDS8xLl4/sdm6tm0Ues38Se3kTu7hiOUFLcOohJ9VLTG+VPEXtKdWmNMnIRK2MZVzsP21gS/5Cde5WqgXU9enzz9gJdMsYQgb1lF6+wtrTOio3ojsJZkUMFP1zmBakz2Rb506X0JDQgAerb9p2D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759609372; c=relaxed/simple;
	bh=jSRj5ycKivK3RnNzwZhYezJzwU4Zrd6FLzZRchx/Hkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZqzSCWa+/dIttTyqERXjP2dLK0iERwPAR9GBEz6QNtierQRmC2WCQiSsG25/+MK9gaxIkmwS49ftZllV/Rnvxwma4jZxlpGarK38WAECe0W+qeyvX2hgz+jHO8fQPc7vKbEcOMzofpQES6VvYkSnpnrkADM5RKnCgbI2tvSldc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Efz+PsKc; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27c369f898fso40050415ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 13:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1759609370; x=1760214170; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7iOjCRTv/UOLRas4QoQfI+GQphzTaP2e17HJMdbYUcY=;
        b=Efz+PsKcfZ6sxzjzVvacbvb6SAMCHKcytqXNdKdzlFNOGYF74g3tjJ0Lhl/PmxE31q
         uqYAU52x9lcGF1GR1n7MUW6NMpLGOx46I2rXagY6uRtUgHe2L7yIhpy28rjyvC4swWiq
         zHcQIEkXuFdEBGO9W4kXarwkwE+UHbhNcLB3XQrPa3gS8wISkA6ZFqh9x43fTO/3ItaR
         4FJRIeybs6I8UqfJku2dTWqGMpMv8gHS6dRP/tQN+3Ptc39tMuQ81Uy1kqVRm6gd4enE
         8esOvdM77rtGE5DXzT5Oz2Sgkj/XSAByWZDIRhLSNZw61be/0lfmj2PC4p+n2LXqncw0
         3uaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759609370; x=1760214170;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7iOjCRTv/UOLRas4QoQfI+GQphzTaP2e17HJMdbYUcY=;
        b=L7uiGEnGWFQCgxbxEkk+YoCQiaOBm+sVP7Gz1S19kf6eVz+EDczX8DXZbT3dmR4++t
         58hLUhegVMwSHHnvLdpREm5r/D5FJLWnAYsqfmgplmgBT96wp1drUc1K1hCkQXiJn4y9
         tN/9tW3VIdnPzZfjX1AR0cp3UKMwO2hm53B7bUXSomDIgxzVYZbQqJXh6rSRB0cLcMq4
         OZiRMPsa7YopNcL9BsspQrGzuVyFrZHhXcWcBavG2DE8mmQDOqtQmsyChG286MJOimEJ
         H8Dwlcfc1R8ghLjELdGAAmjEia765LtZcYT5gsFEk6nUOoV+jsTOcilqd7J+b0ZIIKoS
         uHnA==
X-Forwarded-Encrypted: i=1; AJvYcCXCf2Sn26ceH7U0SHEa63baZLWhuYHGIiX5HDTgTEXVG9DeK8fAY/GkSfrYoRctbZJXbt4mJh0BGIvGGQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBEDJ334Bb+WZmu4LyT36oPv4+6kM8rlqfDA/5tQDguauNGY/5
	KNmvpEf6vNNpWjj7L/RPZCCkbE/aMM3VTUKlJa1SmNb4RIpiTUDEkg6fQ5lSIJ5REJO2/mDFn2t
	FrhV8zbYIduy2qhtiljSTfF7JUoABazQ=
X-Gm-Gg: ASbGncvMz19ItWE2DRpq/ndrbXkl3j88ert037bRHoRd/LDouN9PK9+Xi43RiGFhENC
	vdUha/oblq73eh2BwBwmOg/xx2O2FZvOWL33S9dO531P1fzVKKCgrJXTOKniujXePIS7D05ZZLy
	Wz/c9nfouH9zemeVIBgXCuomvLB+mLxLjbdaErLoaAuEcZ6dVIYrDfRA8m7RR4GUkex8codU983
	7C8DrN6J/UWhXFKA8sBhUSYZza8aG3rLJ3Hsks5PuTWFqShLCdzxYAEQQ4r3zwc2rP7cx6cWR0=
X-Google-Smtp-Source: AGHT+IEvFiFYb/yXN2Hbuqa0QsBGFUfYWmFw0Mzqwu753oWhqXU6HdGuLh/esJRyH1nG43WsG1wWRCjs/qzkq/JOeVw=
X-Received: by 2002:a17:903:8cc:b0:269:b6c8:4a4b with SMTP id
 d9443c01a7336-28e9a56172amr94357475ad.6.1759609370443; Sat, 04 Oct 2025
 13:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927130239.825060-1-christianshewitt@gmail.com>
 <CAFBinCCsTqsn06A5oVXGTW6PgmSQH0bHE+8PSftyWNRAbYUTcA@mail.gmail.com> <C8A273D4-5F5F-4BD8-911A-67EC9C3FF1F4@gmail.com>
In-Reply-To: <C8A273D4-5F5F-4BD8-911A-67EC9C3FF1F4@gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 4 Oct 2025 22:22:38 +0200
X-Gm-Features: AS18NWDKVbe_cLdtewuohc2z1hdjWwhtLw5dUx7qZDgCz70wIOVm6d51SxXp1TM
Message-ID: <CAFBinCB9hxgJt_rqdy_1bM0FjnnCt1K=Au77yxeuWox1wSvdDw@mail.gmail.com>
Subject: Re: [PATCH] drm/meson: add support for 2560x1440 resolution output
To: Christian Hewitt <christianshewitt@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Dongjin Kim <tobetter@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000007818c506405afb9c"

--0000000000007818c506405afb9c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Mon, Sep 29, 2025 at 1:58=E2=80=AFAM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> > On 29 Sep 2025, at 1:24=E2=80=AFam, Martin Blumenstingl <martin.blumens=
tingl@googlemail.com> wrote:
> >
> > Hi Christian,
> >
> > On Sat, Sep 27, 2025 at 3:02=E2=80=AFPM Christian Hewitt
> > <christianshewitt@gmail.com> wrote:
> > [...]
> >> @@ -894,6 +908,10 @@ static void meson_vclk_set(struct meson_drm *priv=
,
> >>                        m =3D 0xf7;
> >>                        frac =3D vic_alternate_clock ? 0x8148 : 0x10000=
;
> >>                        break;
> >> +               case 4830000:
> >> +                       m =3D 0xc9;
> >> +                       frac =3D 0xd560;
> >> +                       break;
> > Initially I thought this was wrong because it's only added for the
> > G12A (which is also used on G12B and SM1) code-path, leaving out the
> > GX SoCs.
> >
> > Was the 2560x1440 mode tested on a computer monitor or a TV?
> > I suspect it's the former, so I think it expected the code to take the
> > MESON_VCLK_TARGET_DMT path, which automatically calculates m and frac.
> >
> > I'll give it a try on Friday as I do have a computer monitor with that
> > resolution - so any hints for testing are welcome!
>
> The original patch is from Hardkernel sources - I=E2=80=99ve picked it se=
veral
> years ago and then updated values semi-recently after 1000ULL changes.
> The user who originally requested that I cherry-pick it (and tested it)
> was using an Odroid N2+ board (G12B) with a Dell monitor IIRC. It=E2=80=
=99s not
> tested by myself as I only have TV=E2=80=99s not monitors, so it will be =
good
> to have your confirmation (either way). If it=E2=80=99s wrong I=E2=80=99l=
l be happy to
> drop it - I=E2=80=99m just trying to upstream and offload some longer-run=
ning
> and allegedly good patches in the LibreELEC kernel patchset.
So I've tried it on a Le Potato (S905X SoC) board. This patch doesn't
do anything here (as expected, since it only targets the G12A and
later code-path).

Doing some more analysis, it seems that
meson_venc_hdmi_supported_mode() simply prevents using any mode with
more than 1920 pixels.
I attached a simple patch to overcome this (discarding any
meson_vclk.c changes):
$ cat /sys/class/drm/card1-HDMI-A-1/modes
2560x1440
2048x1152
1920x1200
1920x1080
...

My monitor's OSD tells me that I'm running at 2560x1440@60Hz.

@Neil, should we bump the limits in meson_venc.c to "4Kx2K@60" (that's
a quote from both, S905/GXBB and S905D3/SM1 datasheets), most likely
meaning: 4096x2160?


Best regards,
Martin

--0000000000007818c506405afb9c
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="meson_venc-hdmi-support-1440p-screen.diff"
Content-Disposition: attachment; 
	filename="meson_venc-hdmi-support-1440p-screen.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mgcps9pr0>
X-Attachment-Id: f_mgcps9pr0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZXNvbi9tZXNvbl92ZW5jLmMgYi9kcml2ZXJz
L2dwdS9kcm0vbWVzb24vbWVzb25fdmVuYy5jCmluZGV4IDNiZjBkNmU0ZmMzMC4uOGExMTEwMzc3
YTE4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVzb24vbWVzb25fdmVuYy5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9tZXNvbi9tZXNvbl92ZW5jLmMKQEAgLTg2OCwxMCArODY4LDEwIEBA
IG1lc29uX3ZlbmNfaGRtaV9zdXBwb3J0ZWRfbW9kZShjb25zdCBzdHJ1Y3QgZHJtX2Rpc3BsYXlf
bW9kZSAqbW9kZSkKIAkJCSAgICBEUk1fTU9ERV9GTEFHX1BWU1lOQyB8IERSTV9NT0RFX0ZMQUdf
TlZTWU5DKSkKIAkJcmV0dXJuIE1PREVfQkFEOwogCi0JaWYgKG1vZGUtPmhkaXNwbGF5IDwgNDAw
IHx8IG1vZGUtPmhkaXNwbGF5ID4gMTkyMCkKKwlpZiAobW9kZS0+aGRpc3BsYXkgPCA0MDAgfHwg
bW9kZS0+aGRpc3BsYXkgPiAyNTYwKQogCQlyZXR1cm4gTU9ERV9CQURfSFZBTFVFOwogCi0JaWYg
KG1vZGUtPnZkaXNwbGF5IDwgNDgwIHx8IG1vZGUtPnZkaXNwbGF5ID4gMTkyMCkKKwlpZiAobW9k
ZS0+dmRpc3BsYXkgPCA0ODAgfHwgbW9kZS0+dmRpc3BsYXkgPiAyNTYwKQogCQlyZXR1cm4gTU9E
RV9CQURfVlZBTFVFOwogCiAJcmV0dXJuIE1PREVfT0s7Cg==
--0000000000007818c506405afb9c--

