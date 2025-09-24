Return-Path: <linux-kernel+bounces-830603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C596B9A173
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F9E324D90
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91389304BDD;
	Wed, 24 Sep 2025 13:44:22 +0000 (UTC)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFA12D73B5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758721462; cv=none; b=YBuHvcrOucXuf03GZia+dWVKPz8K3Y9D5kVuOKcTYei7DcxA7RaYLNnOFhe91TQzpsr/zElHumLVFVBukS+3ze4Dgy+1ebOHFKKD9BTJp+goxn64lwavBF2TUvTZLn3eie3s8+XVPGPXF9jgowKdKuKl/Lx+xWRtGkhzxWFUF24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758721462; c=relaxed/simple;
	bh=MaTNhkQHyFmJQwS+ctA2quBLbt8KbQCGyEQl3AcBgsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbTFWYnQCwxNkJsxoVmBOg2D9CbMhd+t6o7TqnAdfooYw5+ChrqGUq2yozJUButHFn1HR9dNv+TnS4KBX5jj+h7zG59rlmfjifZz/L+uk3CV4OfQewoU+AmM+ns1BH3IiKzBrZvmKv8OAHDuvOSXrXEt2ZJUShF4d3hJunAV5LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-8e30a19da78so4372037241.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758721457; x=1759326257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ud+VdfUL7qeLttCIpK8GnWcnYhqw7mGxqeGHH/+haJ4=;
        b=B92YhNH0U6tubIxAYwCXNVkmEh0OnZrCSdxR0YrT+uMPFISd2Iyo7etvonIpzRojBR
         gV4/6xHmqHfZ1z6jJkHnNRwXizD4TGSVRPdTaQOTj6CZyHIOCjGoHHSNKLJw3q7t1xQE
         VhOEfqkk8qKq1LzPgQQmGjg5o8s15KiVJYGhxQl0RhbswPMaJDNI5o7TrHGtIknqssVv
         a/t+o/Y3XgmHiER1dkjRl3tO88jdPYF974RXrpct9/D0YgSgLbe1tkAH+PVeSZ7JihNd
         o5m5AY1k5Zc0k4SgAC1kK+UYqw7L1o0Yae3Uq+qT7yrK8x9562GqTTvqjh8r0BOnyGnV
         zC5w==
X-Forwarded-Encrypted: i=1; AJvYcCVOf+L+116KiNF7wBoFjepdxaDO+os7IG9WvDYHdlmGzCGsqlSReD1lmxpcm/suRtGkp8m3EU/yt3E/pss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqL9CxR6xqgA+nRT5E5xQQfUjo6tkku+2G4hm/jJlVbpcyIljj
	jsaYigGIAip10DyeAbeGj2MqXRgrmIic9oChKPRBfKbtxEHNQFh3yF/m5rlKWtz4
X-Gm-Gg: ASbGncvxeBfjytThCQjFsO4Ka61GK8f1RVXKhFlDsXvhsYoant1rQ93aHhW5j+SwEQu
	llaildiT0tHhBvSzGTwCxoW2NtWonqK3Hp+E6+nv7Fi+4oSj4CD3JnyXFauVTVXGhEoAh2RWqs9
	IrF6jDtMP5sUVV1Ig2TRPXru0mxwKARAWD16uyzwYD9ppZVj3gF/ubT7lwbUqx9ZjAIct8f3BKP
	vTTbxl6pIjMVqhtHoSsIkALCV4ezASXUMrkLDGfo4EEnvv60Kzag0mk7zhJ3XqTNtS1ajgoigSJ
	Dc2+en+UQLK+19sZsPGXWixrURwarOVkeaMS2ZO3WU616QhzUBKrTlc2jOW8kv+7diCWAhyDKOl
	HjgCz1IcBmfKUbzJBpEOaVAtsx+uuhQD7Ieu2jTgIuv/iop+XpD+GANduHQtQ
X-Google-Smtp-Source: AGHT+IFhHp9LX6eXz2z4fiDa1pSAPNAjQPWfj/md5o+Up3XMmA4Iek1ABeitAUbRDg0DUgnSuSYZiQ==
X-Received: by 2002:a05:6122:7c7:b0:54b:bf4d:558b with SMTP id 71dfb90a1353d-54bcb1cfeafmr2208462e0c.10.1758721457021;
        Wed, 24 Sep 2025 06:44:17 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a8685e515sm3341747e0c.21.2025.09.24.06.44.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 06:44:16 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5aa6b7c085aso417213137.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:44:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvGT8yLp23oyy+TwpZBe24dRmfqvmufu3tFVEjGJFkaEue0dGodzXryQBcFAvm5piajeSPRehD+6k81lE=@vger.kernel.org
X-Received: by 2002:a05:6102:418a:b0:525:9f17:9e55 with SMTP id
 ada2fe7eead31-5a57c841ca2mr2580466137.32.1758721455932; Wed, 24 Sep 2025
 06:44:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922074101.2067014-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250922074101.2067014-1-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Sep 2025 15:44:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXKbPGqAnAcL2kFyF6K3hH9=gr8ECAFVpkgj-OL1mB4eg@mail.gmail.com>
X-Gm-Features: AS18NWDtZK7ut054Ynx0fOpihOfMi0d8Hu_LC6xa7NuQxZWkG8VW8DC_8cFyNCQ
Message-ID: <CAMuHMdXKbPGqAnAcL2kFyF6K3hH9=gr8ECAFVpkgj-OL1mB4eg@mail.gmail.com>
Subject: Re: [PATCH] soc: renesas: rz-sysc: Populate readable_reg/writeable_reg
 in regmap config
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: magnus.damm@gmail.com, john.madieu.xa@bp.renesas.com, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

On Mon, 22 Sept 2025 at 09:41, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Not all system controller registers are accessible from Linux. Accessing
> such registers generates synchronous external abort. Populate the
> readable_reg and writeable_reg members of the regmap config to inform the
> regmap core which registers can be accessed. The list will need to be
> updated whenever new system controller functionality is exported through
> regmap.
>
> Fixes: 2da2740fb9c8 ("soc: renesas: rz-sysc: Add syscon/regmap support")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

How can this be triggered? AFAIU, registers are only accessed as
obtained from syscon_regmap_lookup_by_phandle_args(), i.e. based on the
register offset stored in the DTB.  If the offset in the DTB is wrong,
there is not much we can do ("garbage in, garbage out"), and the DTB
should be fixed instead.

Is there another way the user can access these non-existing registers?
Thanks!

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

