Return-Path: <linux-kernel+bounces-828073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB13B93E11
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69C7C2E2EF2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927812D5427;
	Tue, 23 Sep 2025 01:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KD7BUALE"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA06279335
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758590979; cv=none; b=K6BhmtiJ/hxXHAg8FERP5/w7YXChUG7RK2cVJQhky0yo4/cUyv6rmG5tIB4ED/TwCimGy4jIZSj3DmmqRHUxReqow1VHZctED9k0G3KY5VMBHeWvT2rAdPFKamFNvP5rHmIbd47xIVngsxXmoJ2LS70oLThtWgO+qUFHZDqHwW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758590979; c=relaxed/simple;
	bh=Keih4ozM2ClJ7bLKolp4rzu48rFOC9n6MVTSF0I4RXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZH0LWkSVUgsuxclEO8RRTd25IpxnaW9wPh/vfb7jgQdCp+boynNIUNg1vIc85oT0rynyMrLCZr+njVf2jIu1JVtN8r8RXAOChBttmKKPqZnH+6mY3L4iS4u0YXDv+Sgek+yfcRTPX9ECcaH31v8wq3yWjetk3r17bCssE29X/g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KD7BUALE; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-330b4739538so3132114a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 18:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758590977; x=1759195777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGIEsRlxQ6SB/60aNk9YuezwzaWruzT6GSumf3z2VMQ=;
        b=KD7BUALE4v6krkpM1w5HFveuUWLHuqKX0i8IedmTFjKuihlgcte6bH0rnx/uwFWa42
         uNysOBNbybAjUJmWGpM9dGQsSyC7tipoEiQswPILeP09U4LIFBI/0RcQob9IS+OQFY+n
         zXpS21Ub3LESB8d/W7bUjw8xJWUdqbRrEA02S8nvqWJmcBZiXo0lSNRZ58r+CUW8wCTP
         cRBkl+V1XaFjTjdJjS5foK5pzi2WgJiASaC/RXiAXi9M0kwFFUntcVoczNfELNfGysN/
         oYqcIiHpu8gw+0ihek1QJnMU8o7FkNCVulheGXq33Oj43smU3sUL79pFlM2j+zZy6Ck/
         ZApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758590977; x=1759195777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGIEsRlxQ6SB/60aNk9YuezwzaWruzT6GSumf3z2VMQ=;
        b=YLpkgYrk9FWyLBzgXOm14nxkLgkaNyC1iPrHK3I2Tj1LOi4DGODZssomwsNEAZU7dM
         MhlzrYj9zhXXPle+tAeCA8JTwikstOlyyxM+cVTTNjTScTaCYajEmB3vqqvRi8mlYDge
         Fy5qvMWcZYmP/6W+CHS681ickCpTyHgcM1imqKk2t4izTuo3H9DrrIBYLR9F1hKjD+ZQ
         piwXF8juSAuNdp3dcpH3NrJLuDI+/dBWGXdQcoSI/N0lt5d9OZE6jJUzuYusqZU9Dr5k
         1FGnFuBFj4Ycn8C0UhBfmPpsML3eP0D3fiR3BrMHtppTVarGwpTDf3idht0jEw6F2o2R
         zVoA==
X-Forwarded-Encrypted: i=1; AJvYcCX7B9/W+9PoUTDD41HZAM5qQK2cJx1zZdZF6ETcpWA/3Ho0FHwre/shkKiIC1onEqvDv845DTXYK0K6a/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY01d5Efi4WNg9jVLazUdlHPanUcTWVmoAwM9RdYrXMJKrDG8h
	eSfcqBpLuR+XYndXJfX0jsI0Z0xGEE0Lawr5LaAD2DOgVu32q6xGxXPjDcDSFaLNZl+CAjXqUDs
	JncAyeMka/9kalWljWp+MFj9qC2WuC+Y=
X-Gm-Gg: ASbGncsTNjC/FwNDDEghBLhqB1RpzVb6vt0HzmyvgnIZ4/fS5eprAOG15sinUHJlHwU
	s5YCEAHBA59ROD1TPS7r8jvQDWUqctWq8tXGiR0eZ46O+UPNnsNqLogzmPXn0oPbPi3aUWtOYyH
	83uNJrZ7voAnLuLf05kI92CTQQxT6blRFrjtV9jn/fKVlNaRH1xr8gc21SfAOjOhtDfSUfjQ7h4
	RSj5EA=
X-Google-Smtp-Source: AGHT+IGBT9LTfm84q4DXIRoJSFR8hZ2WWRU49SsvtumqUnLfaKU5tnx1duKBXoUog0HE+Dc5+BSde4IFSplat+4nyaY=
X-Received: by 2002:a17:90b:33c8:b0:32d:f4cb:7486 with SMTP id
 98e67ed59e1d1-332a95e8e19mr1041351a91.19.1758590976762; Mon, 22 Sep 2025
 18:29:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821073131.2550798-1-shengjiu.wang@nxp.com>
 <20250821073131.2550798-5-shengjiu.wang@nxp.com> <20250901185208.394cd162@booty>
 <CAA+D8AOCTqb5jLeRapYk4wRGZrsrPiuAR=ow3OA1B0+M9X4k7w@mail.gmail.com>
 <20250909-omniscient-honeybee-of-development-adca8a@houat>
 <CAA+D8AM=aRU-0QcgtxZ+=YBZ2+kMrP2uzSE3e+NJs3Z3zkrSVg@mail.gmail.com> <97288c51-954a-48a9-92b9-e165ce480707@nxp.com>
In-Reply-To: <97288c51-954a-48a9-92b9-e165ce480707@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 23 Sep 2025 09:29:23 +0800
X-Gm-Features: AS18NWBhgiBnQW_QrjL4oCw3YUyblBEb719xz-MBTlZAVwouH205ucQ6fmr_z54
Message-ID: <CAA+D8APA85PhWVkW7c=d_qWF7L1ERxe7cS3Gg00SV-3TSyLwQw@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] drm/bridge: dw-hdmi: Add API dw_hdmi_set_sample_iec958()
 for iec958 format
To: Liu Ying <victor.liu@nxp.com>
Cc: Maxime Ripard <mripard@kernel.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Shengjiu Wang <shengjiu.wang@nxp.com>, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
	rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, lumag@kernel.org, 
	dianders@chromium.org, cristian.ciocaltea@collabora.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, devicetree@vger.kernel.org, l.stach@pengutronix.de, 
	perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 11:01=E2=80=AFAM Liu Ying <victor.liu@nxp.com> wrot=
e:
>
> On 09/10/2025, Shengjiu Wang wrote:
> > Hi
> >
> > On Tue, Sep 9, 2025 at 2:39=E2=80=AFPM Maxime Ripard <mripard@kernel.or=
g> wrote:
> >>
> >> Hi,
> >>
> >> On Wed, Sep 03, 2025 at 06:41:05PM +0800, Shengjiu Wang wrote:
> >>> On Tue, Sep 2, 2025 at 12:52=E2=80=AFAM Luca Ceresoli <luca.ceresoli@=
bootlin.com> wrote:
> >>>>
> >>>> Hello Shengjiu,
> >>>>
> >>>> On Thu, 21 Aug 2025 15:31:28 +0800
> >>>> Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
> >>>>
> >>>>> Add API dw_hdmi_set_sample_iec958() for IEC958 format because audio=
 device
> >>>>> driver needs IEC958 information to configure this specific setting.
> >>>>>
> >>>>> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> >>>>> Acked-by: Liu Ying <victor.liu@nxp.com>
> >>>>
> >>>> [...]
> >>>>
> >>>>> +void dw_hdmi_set_sample_iec958(struct dw_hdmi *hdmi, unsigned int =
iec958)
> >>>>> +{
> >>>>> +     mutex_lock(&hdmi->audio_mutex);
> >>>>> +     hdmi->sample_iec958 =3D iec958;
> >>>>> +     mutex_unlock(&hdmi->audio_mutex);
> >>>>> +}
> >>>>
> >>>> Apologies for jumping in the discussion as late as in v5, but I noti=
ced
> >>>> this patch and I was wondering whether this mutex_lock/unlock() is
> >>>> really needed, as you're copying an int.
> >>>
> >>> Thanks for your comments.
> >>>
> >>> Seems it is not necessary to add mutex here. I just follow the code a=
s
> >>> other similar functions.  I will send a new version to update it.
> >>
> >> Let's not be smart about it. Next thing you know, someone will add
> >> another field in there that would absolutely require a mutex and now
> >> you're not race free anymore.
> >>
> >> Unless there's a real concern, the mutex must stay.
> >>
> >
> > Ok, thanks for comments.  Then Patch v6 need to be dropped.
>
> To properly track the changelog with patchwork, can you send v7 to add
> the mutex?

Yes, will send it.

Best regards

Shengjiu wang

>
> >
> > Is there any other comments for this Patch v5?
> > If no, can this series be accepted?
> >
> > Best regards
> > Shengjiu Wang
>
>
> --
> Regards,
> Liu Ying

