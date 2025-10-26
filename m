Return-Path: <linux-kernel+bounces-870532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE69C0B0FE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 20:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F96189E34F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 19:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF23C29D26E;
	Sun, 26 Oct 2025 19:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="FOZWhnaw"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCAE4A1E
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 19:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761506376; cv=none; b=ho2w3Wsw/mXWITUhibnS2v4khVkunlmTUXMLfhz0U+rGmIiiRrrLW4wJ7SqMTQ3BCH9vgtSkbVsr6p6XnGzG++YepwrbsrBZaIuxI3ySvpa3qzlYlXp0hEAJl+aJ5SoMZj2Qa0FL8JY9Pjt/xefPUWfxsO0ICob1xayYC/3RCxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761506376; c=relaxed/simple;
	bh=xRG7RRaOd75W2AXX/3U7vBD9xweHddWhADNXxNQKzq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDxszGsDhSZNalVt7gvUx/X4CCjbgk/AJEcsDlCSkAQJk+TBBY5LdNkOtWkXJUTftp+8i6EV8Y5jRjLLz+JfIqN6Eb9W4mHnoQDMpcDHqUq8NIZ3EeF/7CtW7fpkLDWFB7wZuDCYa0Abn2UJtZtQ7C+N/jbR+jVxgoiM6emm6J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=FOZWhnaw; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 1EA5C464C8
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 21:19:32 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 9FA3B46D1B
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 21:19:31 +0200 (EET)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id E5AE3201881
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 21:19:30 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1761506371;
	bh=u+ORu+BOBg2onDpkWcuDWZ7x2Veds5ArtmoChBMc540=;
	h=Received:From:Subject:To;
	b=FOZWhnawtQL7x8uaJbr77YpYLanLeg93H4Y4gxayvEX1CIz50xFINp9BbQNvCUGGm
	 OGljRDMjPpFbBpaWMOh6b/6GFZVYrR31oGhGXoHbr1ZTmYZaZ8Gbg+j5fbouLn36ja
	 lH6MWkfRl0hmeKgeRzY7Odk9n4QtfGUQqn1bYNUtkJpQh3E6knsglsKHuFs4FP0oao
	 CGxqy6qlQ/PK4t3YP73zmCnhqYY5MaMLfj+IOhbTMYj5rUV8QCuPRqeaxxOY8tJMh9
	 b9D6BwyeaIaIhFgIr90JU6uBJqxeEjOX31yZy5NFKuo5LtAU+qmkvsoVWf1DWxeJlh
	 /3g0FOrBCT42A==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.179) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f179.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-36bf096b092so38337331fa.1
        for <linux-kernel@vger.kernel.org>;
 Sun, 26 Oct 2025 12:19:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVxHoG/ml/ha6G4W28m9NmphXEGXy4TTXlYvcZNMyZkr6Wi3FE6JC/tFyDKsrzJ9CHB1XeDfV+c7hbt8Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNmxf8R6VbqU1FM7mXF3sj+hUZxJkKLyLOhNmp/j/B2GLEMUpp
	Wx3hJAq+1UNWk099F9ATZgDHqIZIF6GsInsVIOp2qwJSm6kzxnKV4E8c2n9gRkspAI5B1tKhbMV
	3TOPgb8mCXxkpm2oY1+FmtteVZnJtAxo=
X-Google-Smtp-Source: 
 AGHT+IH1+LrV/HXJWrcLHsBoUCuoFjWejxe4QlRyJVq8b4diRfaog1nzI0eZGKw9EqPst1KY5trhwovqgZ+TN9X3TDo=
X-Received: by 2002:a05:651c:198c:b0:378:e79e:ce4c with SMTP id
 38308e7fff4ca-378e79ed460mr23672181fa.17.1761506370338; Sun, 26 Oct 2025
 12:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026191635.2447593-1-lkml@antheas.dev>
 <20251026191635.2447593-2-lkml@antheas.dev>
In-Reply-To: <20251026191635.2447593-2-lkml@antheas.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sun, 26 Oct 2025 20:19:19 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwEwPj9VRRo2U50ccg=_qSM7p-1c_hw2y=OYA-pFc=p13w@mail.gmail.com>
X-Gm-Features: AWmQ_bnSWEJ3v7n_AQchb1SyLrMbzY5rdWIx3bGjgVVdHSMZd6IqG2sxntWuSw8
Message-ID: 
 <CAGwozwEwPj9VRRo2U50ccg=_qSM7p-1c_hw2y=OYA-pFc=p13w@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] ALSA: hda/realtek: Add match for ASUS Xbox Ally
 projects
To: Shenghao Ding <shenghao-ding@ti.com>, Baojun Xu <baojun.xu@ti.com>
Cc: Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <176150637121.1180651.8302369170193706902@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Sun, 26 Oct 2025 at 20:16, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>
> Bind the realtek codec to TAS2781 I2C audio amps on ASUS Xbox Ally
> projects. While these projects work without a quirk, adding it increases
> the output volume significantly.

Also, if you can upstream the firmware files:
TAS2XXX13840.bin
TAS2XXX13841.bin
TAS2XXX13940.bin
TAS2XXX13941.bin

That would be great :)

Antheas

> Cc: stable@vger.kernel.org # 6.17
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  sound/hda/codecs/realtek/alc269.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
> index 8ad5febd822a..d1ad84eee6d1 100644
> --- a/sound/hda/codecs/realtek/alc269.c
> +++ b/sound/hda/codecs/realtek/alc269.c
> @@ -6713,6 +6713,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
>         SND_PCI_QUIRK(0x1043, 0x12f0, "ASUS X541UV", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
>         SND_PCI_QUIRK(0x1043, 0x1313, "Asus K42JZ", ALC269VB_FIXUP_ASUS_MIC_NO_PRESENCE),
>         SND_PCI_QUIRK(0x1043, 0x1314, "ASUS GA605K", ALC285_FIXUP_ASUS_GA605K_HEADSET_MIC),
> +       SND_PCI_QUIRK(0x1043, 0x1384, "ASUS RC73XA", ALC287_FIXUP_TXNW2781_I2C),
> +       SND_PCI_QUIRK(0x1043, 0x1394, "ASUS RC73YA", ALC287_FIXUP_TXNW2781_I2C),
>         SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
>         SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
>         SND_PCI_QUIRK(0x1043, 0x1433, "ASUS GX650PY/PZ/PV/PU/PYV/PZV/PIV/PVV", ALC285_FIXUP_ASUS_I2C_HEADSET_MIC),
> --
> 2.51.1
>
>


