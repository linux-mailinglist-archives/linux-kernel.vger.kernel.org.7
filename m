Return-Path: <linux-kernel+bounces-897750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD122C537AA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 77335354C56
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4B133C53F;
	Wed, 12 Nov 2025 16:33:10 +0000 (UTC)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4943B2D130B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965189; cv=none; b=Pd/1durF/0Sq3UwmJRfmWgTes0wrWZvaUHpMvjaWTZI3KvBtxJdO9owwkbrkeoEySuYSTbKw3nW0s/rY8OXDG9Dv3pTGlrghKWzsxYO9lIUj8EJu7QLDGeYSfPZ1nccLOuE70iJ5yQ+ZWrzmlPxpnOmC0a6ggnr/Qn/T6Ph+oK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965189; c=relaxed/simple;
	bh=bEZZWG5YEp0Z9/LGaJ5W6d6eHDiLO+fgQxM/0wcY1HI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e52bcv31FA8omU8a+8FHX4ghsmSC5aC4KKVD1qFRCQg3j1kfVe6KJ7nOmCNad6XgoTrBiFS0YGVbqajTv3mQ4c0PJjxE6+A+O+Ear+P7CiTnMDmkYG/dNczQdQoWVN6RzJh+aF/7l3r3KnZeyzCQVdQKxkRfAEJIc1NBuYDywAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5dbde7f4341so717731137.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:33:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762965187; x=1763569987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRHI+te/6G1RkJD50z3m+CcLgrjv+TKsyW3UHSOWUNY=;
        b=scCc16qpwFSM2mCmgpaXks/oUAfFj45IV9hV8+yPzPlDbTtibnMHNkmXC/JCkAUhXV
         /KtMP6dctkQjNpv3otwzPo4TK9/XYM1LNIp9YQseO+iwQogTRRsa6f4O7c+5mMw7GCe1
         KW0CorlJe13ElJKFeIkw/qXBZFwo/uyaEKxvbDlx2x37Mc0K/+3vInsihA6Wc47Bkt9r
         La3d1yOdLl+VVYK+mvyQYbSQn4gkS3aiDIk/macbztTjngEQZrvoLtDvGqYL22lIyZVa
         wFvOvb5FTMtBhJm84e9Rz20uYwnSdKZB2cs4U7B+AkpLkHxtbYCxGcvyY9KvsQC/0Mwi
         XjBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHzWdJ2phSoXuYWCx8C/3Wfj6sDzaai7xpZyX1lzX9EJ/PqtTNaFK0b7Xo83/ipe+T/np2c5LU2LLUWHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCusTTG6z/dEnSsoj0t0uvn4XAUu/OQMcwQLXLrveGG7YIT4Gs
	/x/YdajyMHFi14P3hP4/wMCbys5m6BdGyyPoiEfMVksI2nAwigtNIUQ/g0L7HUxW
X-Gm-Gg: ASbGncvANCILWEIK8Yh0rzw6+s4tlhvnSMDOViLJRpE1IsdXSiP4Ha7kGo4qy8iThWX
	Yr1DC2pgaCtVP3qWRR4wtmQCpu0ceIz0Vejn4q50kQFFfQIq0dSjnBDlGm1vgp2d6QW+noSMCSy
	rj9B7+0ySfIrkHKLbeOb+iAZ54aVOlVnQnhllP0248fVRFR4A5UfNtY5elAX0F7nqI6njtW7BtI
	yZYWH6B4PmG8BU8Hzht2EqCaaNBZFLUGkKk0580TZOqKwUD28a57twN+v3oIcKCR8Rj2dwtrpZq
	J1UU7CFDyhVRAimD9CcVoDJP6z3yaRRj+2V6XLM4noG4HhM9HIPLat2z21tsTaPsVyh4TI9c/ae
	QMahTqg7WyL1IlE9l4NrAvVb1a1OEiTmUD2DYYbFdiPWfcsRO5HLNDQcA++CiXBFJG/i6Qif0B3
	V3rleQX9lqTl5ewOJNo3G0mWIS/IyECkjWVRck/A==
X-Google-Smtp-Source: AGHT+IEzipye7uuVbOrApEmpUgM4dBHP0Jn2TeRilPEo3nWeQu51c3tCbus2YKkcwLU6BMnjwIR98w==
X-Received: by 2002:a05:6102:e0f:b0:4e5:8d09:7b12 with SMTP id ada2fe7eead31-5dfb4026383mr13259137.7.1762965186825;
        Wed, 12 Nov 2025 08:33:06 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5de011b0527sm1262050137.13.2025.11.12.08.33.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 08:33:06 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5dfaceec8deso250683137.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:33:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVwtL173pJPezZ+lX0LlJekxOjNC4qlVU2T67x6XpPcnOBcK3b6iAXBEAY7HByjmVpAy8a19ITo9QTwMas=@vger.kernel.org
X-Received: by 2002:a05:6102:5092:b0:5b8:e08f:eb38 with SMTP id
 ada2fe7eead31-5ddf3edcd87mr2857986137.14.1762965186439; Wed, 12 Nov 2025
 08:33:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112143520.233870-1-yuntao.wang@linux.dev> <20251112143520.233870-6-yuntao.wang@linux.dev>
In-Reply-To: <20251112143520.233870-6-yuntao.wang@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Nov 2025 17:32:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVvOUNux444-O0Jsj7PuauvsxL32mdnWW+fnOWHfz1Vvw@mail.gmail.com>
X-Gm-Features: AWmQ_bl4Ty5-EElauj30wVB0g9kwj1zSnJTklAJxqlZS-opXwm6p34dFTzoL_vo
Message-ID: <CAMuHMdVvOUNux444-O0Jsj7PuauvsxL32mdnWW+fnOWHfz1Vvw@mail.gmail.com>
Subject: Re: [PATCH 05/10] of/fdt: Use dt_root_addr_size_bytes() instead of
 open-coding it
To: Yuntao Wang <yuntao.wang@linux.dev>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, 
	James Morse <james.morse@arm.com>, Chen Zhou <chenzhou10@huawei.com>, Baoquan He <bhe@redhat.com>, 
	Zhen Lei <thunder.leizhen@huawei.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Changyuan Lyu <changyuanl@google.com>, Alexander Graf <graf@amazon.com>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Nov 2025 at 15:37, Yuntao Wang <yuntao.wang@linux.dev> wrote:
> Use dt_root_addr_size_bytes() instead of open-coding it in
> of_fdt_limit_memory() to improve code maintainability.
>
> Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

