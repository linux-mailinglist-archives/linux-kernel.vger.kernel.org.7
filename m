Return-Path: <linux-kernel+bounces-868453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1053BC05430
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B88B427F04
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EF42C027B;
	Fri, 24 Oct 2025 09:00:42 +0000 (UTC)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910532D249E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761296441; cv=none; b=W7xf+rvaLU7WkjyBG+WqKZfZ/8ra2hjDy5Wzp7VNIS0qYHETIwJM2dYC59amb0M/+ievmQHs96Mr5TC5wv0tKdwJv0NbwtaU2Sebm/mhBtPrlQs2MQpbWzrYn54bc9m0sNEQsjWWPGO8q/lU2Nvbo3crOe6ZIlKA5mtlM5aiWgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761296441; c=relaxed/simple;
	bh=VTwfEDA9O/4R6v1xPBzrfJocZUu/+v/Lfn5nRGgSQOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a8nJGQhh0pVMrAD8/kXQvn1AOmPTf3UZblUTNuav/z6Z/2XW/dERmdauXHuhKsLJh3ui+wlz05KmLL3HOza7UP4lwBSVi8+P+8d1CeQ39+68D7eVKlsSHHStv5Gnzo4GvPXIQN3IRmRucga4b+zSqAlNBk38pWHqKfod3/Frhq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-54a8f6a2d80so126596e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761296438; x=1761901238;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3v1IEsc7lG0F5yaUsZFsiMjA7EGPtVnzD5XrOqlrERI=;
        b=d+Kd4OqEahK+D1AR+wYwdBDTns/Hcfyx91KZKZihov9KYHwn7w1TNE+LJk8U6JVHYv
         g8NQ3x3dqOeKF/YNcHyjdyTMlpp+O0SUQntbB5jkMvDJTlpT9Eu0nu0fY7UDaN6TcCZW
         V65NhSoLka2dXHMbqs/wFbETr/ot/q3oc0FjYIGzq765SCiIOg9+X8lhL224nGP4Gn5+
         CSFEhLGM57KHxPIArlXlA8GbUuDISLuKeCJ8xr/4rLLT+7/HpeeXlF//2rQh5r6c1g/v
         xQH/N+VRxUMtuUzk4Ed/CFZ+sr7Ulz3Ky2n3epT2uxgYUWlI9NeoRtqxvoxgwO/ZssMP
         9eBw==
X-Forwarded-Encrypted: i=1; AJvYcCXzQW8VXa8P64wLpFRu7wNnGWmoCcydHjgtzuNcXm7iQ7wTnS4exdzT3ESYz1rpMLBujF6dliXzfwjfTZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/nkEIpemeHHkUZtY2+CQB/6VluwV+iiBdIk11lJx57bT4N5g4
	i8bJjhCDtHN0XBKtQmSoS0cmd2GXdVZApbUIFwJ14wI8gX8nhe23ZLfg6lj2Waka
X-Gm-Gg: ASbGnctyX0fSmg16pJc/bcBZEF+J9dHNFvOrqYJ6v6EzHKWwosqlXH01V14sNgwF0Kv
	4P0rKWyyuQQ6XyeJQjWRATKFL1JboUQplw1gqZmHntKmEGgiHGlEOS4KHk3r/siydkoEldBpO8v
	1RmUnXl3LLzsyAybQaezcWECr9OYgGjzHuwlBcBTRZ27reaFBKPUvbNhT3Xnv817RdcbsP9iO/8
	dG61MGYPX5jZJmIla8Z+QcgEUwVRtfTPuSz8DkouK8dtxnDy7XqecSjKzRE59nPcZy/L6gTmUju
	4rg965oW09EiF35ijv71F7zx3mpvlw1w8D7+EWJ2PhhGvApf4Qz2pYfUxdsgoKFuqxIhWG8gjJI
	62jlFV2xeRFlFSvAegknalOs2dmQHxWC32YzKX/1c12gIaqlSC8kU7mflCXq8Q2RjMKNJbX8Xm/
	zYDopbyLz1rZl/roehCuU27d2K2cK/VGL7fQ/+RloyAjb/85zx0vvJN9k2Ffg=
X-Google-Smtp-Source: AGHT+IFYasdu6cJNw4E0h2HsKoeMpZPjU97hOokFhMZqTDS/dMuUULOzkhRptuyhRkH1oHMnUiDSPg==
X-Received: by 2002:a05:6122:65a4:b0:552:2c5a:c057 with SMTP id 71dfb90a1353d-5564ef828d9mr7103194e0c.13.1761296438143;
        Fri, 24 Oct 2025 02:00:38 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557bd8e5e87sm1842396e0c.11.2025.10.24.02.00.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 02:00:37 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-934ad40c2c2so675489241.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:00:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURg/74/B79SheE1uO+K7n+CORnWEpIeLxi5Rso1tHt4WOHuOvoBlcZxQB7uhvD1NPvgdouVMppfAQ+EVU=@vger.kernel.org
X-Received: by 2002:a05:6102:6a81:b0:5db:341e:94c2 with SMTP id
 ada2fe7eead31-5db341e98c9mr1497710137.4.1761296437697; Fri, 24 Oct 2025
 02:00:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022074100.1994447-1-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251022074100.1994447-1-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Oct 2025 11:00:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWaw0DXz7AgdLORDerNqGD=juJvHOAevTODpMiniDyRjw@mail.gmail.com>
X-Gm-Features: AS18NWA1mnJX-CfRjNX5MadNbQ2xKcHaLUi92Y49yOhA0Cb_I7az37noXQXhEEo
Message-ID: <CAMuHMdWaw0DXz7AgdLORDerNqGD=juJvHOAevTODpMiniDyRjw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: renesas: rzg2l: remove useless wrappers
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 20:27, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> rzg2l_gpio_irq_set_type() and rzg2l_gpio_irqc_eoi() only call the
> equivalent parent functions, replace their usage with the parent
> functions and remove them.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

