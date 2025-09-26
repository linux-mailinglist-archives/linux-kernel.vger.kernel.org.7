Return-Path: <linux-kernel+bounces-834002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DCCBA3938
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7804A2B9C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6A32EB84D;
	Fri, 26 Sep 2025 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tUBqAgWV"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63A027AC31
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758888345; cv=none; b=p6M4mgmLcEmcudCmL+JwlfvNSpkezAD27U78mzUwvwWzHko+h6ZxcFxmvG58ypQ9hAtOFdWWlNUnMW3qEL43z4uNZ4xAnCRmx8BtmEWurXJYRAGJ8GxEQT6hHjJHD6kmf3MAdmPgcauQvANCKmIS066fbeAPxcrl0ULVnZpm3UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758888345; c=relaxed/simple;
	bh=0TP+8hdoSAkERstQA78VRAN5sTgbvs3RBPr5mvjNn7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EjIcfMrKa65u1so6T9N2BZukfA1RSxgqcAiTw74Thbfg7iL4EnKlN18K7HDIobQJ0pbGhM46RwYpGsAbum9UCUmQ8/WbeS3VTK8MdzI/O4/0TjZVBLRithFDLgNSdww2s9lVz4n+h+zAf4qB5lm1yj+HNDda4srxlnoysF5f5v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tUBqAgWV; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d71bcab6fso23840027b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 05:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758888342; x=1759493142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TP+8hdoSAkERstQA78VRAN5sTgbvs3RBPr5mvjNn7k=;
        b=tUBqAgWVxlyCqCpm2s4vXulsiXttNZW9/+Pw0MxPdv8G9ABdtyIp9L/vPX1yHpWg2f
         wdE4yJV6FL8fBbtV+v88Zf5GWKNx+TQQN/4H/EwaptqSXFXwAuLgd32guuUX5b8Cmjzh
         fYo5s/PwUsSAVdIIonho7S29BN1hRgkPVGUHfU3EQR0O6a6By8phAtUVrwYn1PmT9HDH
         E7LgBxtkuBh3+w99yeHegGGiSB5IzmnKki5WDzWLkFsKeX1OscljStduy4zlc2DHTXAH
         EVnaXHWRMpOqJ2Yp1G4tQWK9B2JgUJf/fVEWKeV3NGGrlgF/MvdJjSslNsoKInUV988T
         PiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758888342; x=1759493142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TP+8hdoSAkERstQA78VRAN5sTgbvs3RBPr5mvjNn7k=;
        b=KcXhJGw6DEGby6MbTvhgUk74+YBaN76OJA9loE3GkOHPy7zrfUXbV55inJ4m9r+HfQ
         bHF+6in57d5F8/eJuDBr+U1B63SJFcHpJXf9RvlD1esnUQcootapQaVpjYvi5A0MhJjf
         J4fq+T983cYOb2Y8strC8zqV6QuRZId1RaQy8PESqpZuJFTqqcqBh9NDUEiu0hYTVFen
         RHlGsViEfAo7Aaa1k7syOLKwgtK/MgVN2Uiomj7MNfgFJ6OkOkMIK/PhYbLHnGWtKR0M
         kiB/KZ6OFh4c/YQjfhtlvuhaIirHhPZmWg/dkk4nAB7uLxZN4nT2J3u1yb7gyECz+yet
         Okpg==
X-Forwarded-Encrypted: i=1; AJvYcCVswEOcAlzevBZzjg4FR6B8MsYnsXrOdu6Kt86s5OODIPenpTBAGOpwyTIyBouKwMmPm8TMiRq8lh80xY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQCNTnuBXpinrogVGLXjX6mUDuyHi8m8BP6mtwHQmtzZqgHrag
	AH+JQB4iap/FfsWGg9DuQDhcAiQsoBS+8LASPmQdZfv2vPcOHm4zqD/vlZqxnO8cW4l5XIEfi2I
	lgAyy1j2fUt6DTdbfeKLYy7/uEMKA/q0gjTS0gfZB1e57XsNxSUDQjYk=
X-Gm-Gg: ASbGncuaV+UgrIl8GV4o08Kz9Pl8jr1JSg7rtDKa9O606N/iuZcEFOXRfrLI5txZd1Q
	2caZJ5BxLMTKC4iJ8R5xZS13URE8WVkO05miCeJ+QL8TgQLKbHiUOll0D4NVwcj63puPlO25wa+
	Xjbt2QyVfVd5+W48W5ulgo2FqY1yYbkJXeYe8ItK2XcSlqBo1LiSOEhp+BKxB9uMYe8Ct6tbuhX
	etY9Ziy
X-Google-Smtp-Source: AGHT+IFpst3LXzx1Tq4PLgIty1+eS+58cwQoh3HNSZyTfCuJz5+TvVyNnNmlTvzX9guzqldlM2Jv1pKgKvuJHT5Cmj4=
X-Received: by 2002:a05:690e:165a:b0:633:a95e:ef08 with SMTP id
 956f58d0204a3-6361a6e6c15mr5078517d50.5.1758888341664; Fri, 26 Sep 2025
 05:05:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925115924.188257-1-ulf.hansson@linaro.org>
 <DD1XOHE6P5OC.2JUQRAGAE1KTU@cknow.org> <CAPDyKFrKP2bdpKTHzqDdhEpRAjYu+PFd2Bst=-WPddByxcAX_w@mail.gmail.com>
 <DD22MGF3HNLM.Q7S70RX4NZXS@cknow.org> <CAGETcx-WY1x_ud8Ef1jbpYQVtFv7MZHMpHfSVKA9R9tya0Lxjw@mail.gmail.com>
In-Reply-To: <CAGETcx-WY1x_ud8Ef1jbpYQVtFv7MZHMpHfSVKA9R9tya0Lxjw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 26 Sep 2025 14:05:05 +0200
X-Gm-Features: AS18NWAKTgOg0DoWt4DwiJMugagxp-PZXuEf5kMf0e6fNFZs94EGFqwIW10RP38
Message-ID: <CAPDyKFp0uV2WaQGjwsO8JG1zF_1oXj7-GVnaejih+dN9RAdykg@mail.gmail.com>
Subject: Re: [PATCH] driver core: fw_devlink: Don't warn in fw_devlink_dev_sync_state()
To: Saravana Kannan <saravanak@google.com>
Cc: Diederik de Haas <didi.debian@cknow.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Heiko Stuebner <heiko@sntech.de>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Sebin Francis <sebin.francis@ti.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Jon Hunter <jonathanh@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Sept 2025 at 23:49, Saravana Kannan <saravanak@google.com> wrote=
:
>
> On Thu, Sep 25, 2025 at 10:52=E2=80=AFAM Diederik de Haas <didi.debian@ck=
now.org> wrote:
> >
> > On Thu Sep 25, 2025 at 4:26 PM CEST, Ulf Hansson wrote:
> > > On Thu, 25 Sept 2025 at 15:59, Diederik de Haas <didi.debian@cknow.or=
g> wrote:
> > >> On Thu Sep 25, 2025 at 1:59 PM CEST, Ulf Hansson wrote:
> > >> > Due to the wider deployment of the ->sync_state() support, for PM =
domains
> > >> > for example, we are receiving reports about the messages that are =
being
> > >> > logged in fw_devlink_dev_sync_state(). In particular as they are a=
t the
> > >> > warning level, which doesn't seem correct.
> > >> >
> > >> > Even if it certainly is useful to know that the ->sync_state() con=
dition
> > >> > could not be met, there may be nothing wrong with it. For example,=
 a driver
> > >> > may be built as module and are still waiting to be initialized/pro=
bed.
> > >>
> > >> "there may be nothing wrong with it" doesn't sound very convincing.
> > >> So there *can* be something wrong with it, so warning sounds
> > >> appropriate? If there is (certainly) something wrong with it, I expe=
ct
> > >> an error.
> > >
> > > Sorry if I was too vague. See more below.
> > >
> > >> FWIW: most of my drivers/modules are built as modules.
> > >> I do seem to run into 'problems' more then average because of that, =
but
> > >> to me it just signals there is something wrong ... which should be
> > >> fixed. Not silenced.
> > >
> > > Well, why is it wrong to have drivers being built as modules? They
>
> IIUC/Remember Kconfig correctly, FW_DEVLINK_SYNC_STATE_TIMEOUT should
> be off by default? (if I don't give any default, what ends up
> happening?)

As "FW_DEVLINK_SYNC_STATE_STRICT" is default, the "sync_state()
pending due..." print gets printed for a lot of consumer devices that
have not been probed yet.

>
> If we can assume, timeout won't happen by default, then the only
> people seeing this warning are people setting the flag or setting the
> command line param. So I'm okay with making it an info.

I think you got this wrong. It's the default behaviour that triggers
lots of prints.

>
> But the "sync_state() pending due to" is for the default behavior. I'm
> assuming without the sync_state() supported added to power domains,
> the ones getting this warning would have been powered off? But after
> the sync_state() support, it's not powered off anymore. That can cause
> increased power usage. Seems like something worth warning about.

Yes, I certainly agree, but...

To me, it kind of sounds like we should change to use
FW_DEVLINK_SYNC_STATE_TIMEOUT as the default behaviour. In that case,
I don't think there is a need to change the log-level for
"sync_state() pending due to..".

>
> Also, another thing I want to understand is, for all the reports you
> are getting for "sync_state() pending due to", is it actually correct
> to have them pending? Or can fw_devlink do better in those cases and
> turn them off? It could be a driver fix/fw_devlink fix depending on
> the issue.

There are some cases that we potentially could fix, in particular for
when a genpd-provider, provides multiple power-domains per device-node
(#power-domain-cells =3D <1>;). But let's discuss that separately.

>
> TL;DR:
> 1. For timeout messages, since timeout isn't default behavior, I'm
> okay making it an info. But
> 2. For pending sync state messages, I think it should remain as a warning=
.

See above.

This means drivers being built as modules will trigger a lot of
warnings, in the default behavior. Is this really what we want?

[...]

Kind regards
Uffe

