Return-Path: <linux-kernel+bounces-861246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4A3BF228E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717603A34F7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A3B26B942;
	Mon, 20 Oct 2025 15:40:47 +0000 (UTC)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E8D1A316E
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974846; cv=none; b=N/S6aM4e/MQIr7qC7+ZGMUMVGZ/VVeuMNZ+z2WdcYBjsjoAQ+a7+qyqxkJ3bSYRkpio1RUjxJrk1RiI/26PDgeHjwia67+y9dqnDiqpPyoCE84ZS9gDGQxZdpQYo20V3EKb+Z7ra39S7KFg1JHUgsZvMCHbr/d9L62WmAFveozY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974846; c=relaxed/simple;
	bh=4DKHKFyBAmyK2BgLCKUFm0JrhnOP/BzT/3dmXspoqjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEN1LW2x8lhu08ew2JQhWe3A6NMEXda/A0q4eUaQdeAGN3D7VVNAIlG43iR5dQaQs7jEArlRwmbS24C/UtdD0iQrTk3/KNlE0z/xDstriwPXGSqnhJ99hDemAIAvCACJC2Beb06FG2vKVJUtdQdFSnGky+oMgHBUzUmataGK1KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-54bc08ef45dso2947779e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760974844; x=1761579644;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sAe+WQqu6fcSNUZobRe7LcvjFpLmnKTcy0F52mBYB0Y=;
        b=KnelnpTPJsWlKsWCHu+45AAAkt8+pHyoU8bH7dbOxWRSpEC3zsy5/zL9R+hY1lwMpb
         4HisFJfu3lxnjleOEZdP7CVW95Kdd129D2wKgRL72FIhC4EEr6lQDAYgyMygHbpSwFrE
         nIHRboo56Z0y3sKyXYGrSNeKWG2YJL9Vw+8nRphJvHubd+SHTPvJQUK4IruVklj38Q2j
         jqvKQ4ZUhtiGlizWS1nchWp4cW/CCFoAwHPG1T5Ld6caqbX75bO3DJvciCxyC0ayxy5z
         enTfaT8y4lxHayaqkVxHIby2L0zBDrKx4guIvzC/QpZyfkdkb28AtUV7rrB+HaZK653a
         UIVw==
X-Forwarded-Encrypted: i=1; AJvYcCXNyY4yn/914anlFgBp0DaK9di5qgPr/ap9iIz+eMlb9sll9pTo0AJnYCQ3A0eVKcdXv59IUFq1vIHSCb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL2FuoR0wRZWGdVzAfunnRCju48yEatVURdmYxsNvz8U9+yKYu
	/jHm2XJYv19UZwxUf9meTGuo4xuraaN+R9CcLdCBeoHLj/PrOtSlDwXWxS/nTQrL
X-Gm-Gg: ASbGnctRkM2FqBSV2n+HZWxgnSzqjLHrxx+T6asZHcQyjEezt8hNaBYijft3Tunbnxp
	TR8gtwmdeMXc+1Iy76ubwsswhMVXbC2B3Hln/Hg8zCSlfTp1rfKYf+T/NF8yQiht+NmsQMkTJBn
	mGEqslcD2blWdQ0b9g/w7G6HyjBdYoiJSxD/lN/4Rs0+CvMNDj7dVyFp8WBvDB6y3JnVkGiMagC
	eR0OzON9iwT2rq9oNryIk8Cj8Wyb7jDyTQDIh9FxCNQlUVIUCk6h0uKeP6wXLkuqQDRkK7KyzZ4
	DRZPuecZQeF4tE5wu5VAKkQV1JHxYABhapIzfQyHKkyWE1ZK3LDj7/fmm5z7Z2oT/qK8em3Ty/n
	ici/6C34bML4VvBQIzSJ2tnUInsLpL01uRMICaaxUnuuhsBPyQ6CX9jmdGoiHBVEf+9i3exvll2
	MbtENzcMgB5I7xIZ8rc8qWhGI0K58o7j2RyfUGBVsguu3Jtlu9
X-Google-Smtp-Source: AGHT+IHHdABC9wRiaf2kZx6ivZOgTcWnAZIY7U2Pinz6zOqfJnUIeRyxdHer6xpFCgDCNBjqJ1Gfnw==
X-Received: by 2002:a05:6122:2a14:b0:544:71fb:f49b with SMTP id 71dfb90a1353d-5564eeeb9bamr4500048e0c.10.1760974843856;
        Mon, 20 Oct 2025 08:40:43 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-556620a6677sm2395421e0c.15.2025.10.20.08.40.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 08:40:42 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-932e6d498b2so228936241.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:40:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWcb1KkVTYXt6rvc7qIEnYF/xCMvRLfThnN7ZYYPKjMsPPE6FVrHrsjswGO3meQK5IGVbbbpAxyGQgLcd8=@vger.kernel.org
X-Received: by 2002:a05:6102:e11:b0:59e:2c90:fae2 with SMTP id
 ada2fe7eead31-5d7dd6a1252mr4587724137.30.1760974842316; Mon, 20 Oct 2025
 08:40:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251019100605.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
 <2d514d61-121d-44fc-aec7-637dd0920de8@infradead.org> <CAD=FV=VNyt1zG_8pS64wgV8VkZWiWJymnZ-XCfkrfaAhhFSKcA@mail.gmail.com>
In-Reply-To: <CAD=FV=VNyt1zG_8pS64wgV8VkZWiWJymnZ-XCfkrfaAhhFSKcA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Oct 2025 17:40:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVT-_UVAO=1jvTPEjKO0zy7H1rUrQz1ubMfHivF4HWJNA@mail.gmail.com>
X-Gm-Features: AS18NWAGPS6U1vpFVxAXAcPF5VqsDdi1XmS1uIUwOJPCGix3sCBjoYnU96SczyY
Message-ID: <CAMuHMdVT-_UVAO=1jvTPEjKO0zy7H1rUrQz1ubMfHivF4HWJNA@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Wrap long kernel cmdline when printing to logs
To: Doug Anderson <dianders@chromium.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
	Andrew Chant <achant@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Brian Gerst <brgerst@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Francesco Valla <francesco@valla.it>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Guo Weikang <guoweikang.kernel@gmail.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, Jeff Xu <jeffxu@chromium.org>, 
	Kees Cook <kees@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Miguel Ojeda <ojeda@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Doug,

On Mon, 20 Oct 2025 at 17:33, Doug Anderson <dianders@chromium.org> wrote:
> Printing the command line to the kernel log buffer is one of the very
> rare cases where:
> * There's a legitimate reason to print a (potentially) very long
> string to the kernel buffer.

arch/s390/Kconfig:

    config COMMAND_LINE_SIZE
            int "Maximum size of kernel command line"
            default 4096
            range 896 1048576

Yummy...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

