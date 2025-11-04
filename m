Return-Path: <linux-kernel+bounces-884820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 859DBC313BC
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDF643B9DF2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8CA3254BD;
	Tue,  4 Nov 2025 13:29:10 +0000 (UTC)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FAB322C83
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262949; cv=none; b=ZwILT90jZq/hof80mgtU4dcRIoQ4GTVBmWhZjbwajNqndio0Hw/npR9KZdW9x+uW90NmNF57a6n+32iRDXmWSDY1yAlyiMm2N/4ZNAVscTnns7Zfy5I7ZnXMHlbYjNvEg1KgIKOdJCgc9IIRfUJtXwyXIybCMhCZrM0JgftC1yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262949; c=relaxed/simple;
	bh=jz4XbMEhT14ABokNLSyNocUWmIjvQFrqSNdxYOhl118=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4zrilqiEELNZ5XkwRYkjygCO87KeKEVCyT3xIyQpk61fAgGSeTFwZ3ZaiE/AL73KWv9b6nfbMszWVsg1HAVUJ+oh4I3VEcwtBpxTshHH1K9gOdkcslNRGGS9OO5u3GnyTSk8qGAZaLcvUfFjC90Yt3lxsMWkuyOGcYb1r0TlL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5db394cf0d1so2315577137.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 05:29:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762262946; x=1762867746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lYDUlHzikfVS+CmiS/PszA+brPtjo5Wdl3Z2oI+5wg4=;
        b=I28xf65NjdISzCOmUo6WO716DGNxqwuN/qJbnjk5soAg9JB+Xf9A+m4cJ9oa1nMIGK
         vilzwrYwPmNzlT9clkH4GczYFZOwwA1avtZ+V5HPQ/UKb66UJfawo3Wavz5rPbqrijY6
         RfIzSIQEfPnw40LjU+tbjUQ1KTVk41M9+4XCxeaPOu6XmoCRvez7JeXSxRfhiIYzcavM
         Fg6uhIbVi2y7TR4NtvUizF3hMnmr/Wv4TSR75dHZ2zjIFDdQrhw/tcrb1pERv+XLkiOW
         AQLpGAI7tadfB7/tXtIlF0xQKNof3MLoIXi6hklh0PQ8ofhKf4kDc1vTuWYl4mIW9Wyj
         Q1dw==
X-Forwarded-Encrypted: i=1; AJvYcCWBKpNzmbFLRTbdQG483loGRoMCn20J+qbg4hQ5uhSOoI9eIcdXNvL7yUp02lXeZpsyT3VZHWqszxPVPJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YypQ0ErWdLfGBHECe6oWABRCMlK6Q2uj6RdD1ZjY5l+rXnVxsBJ
	P6EcJIDdveKBb0qGFCE6Ud80DxOgQ8paHa8g4SGiPKTijrboWMHb5F+4fQfaQvI9
X-Gm-Gg: ASbGncvSTqDqdjDoQenl7CQ35xMalcAwC77Ue8UWD5RpCjM00PsXeYlL12C1yRwV0rf
	sTO44YUdev01eHkG+NYeqUSgal95ACYTGO3r9yDx69uAvzfldkaIR7OjYFd4DbXy5HvsxQv4zi1
	xNSZ0b3EHNXabwrGx0TpTQMTxHdMqBoWOsHmIfk3h2qmcN1pleNZX05t+qBdiDR+FVgOpXxwfCG
	Sk0C6Rok/o0jpurUFH7BS8KGyGaurO4RdQoMpM7ZwvUZec68cernui/38taIpF+QsjqZMmFjrHz
	x4ARhfCOGcHM1ADTqp7UT6q2UJzBSVA0CxG3FLA8TgVr5ZxR6Pb7oYQHr0nBXcDTYgSCEf1UF7E
	K6VvKt0pLL0r04eC7IyDlIvcaqai/3HQ60hwpnNSFgm3W833u6sSQL9RRVIHEF+eOFl09oF9Ter
	4LpOn4y77TCMrc6K8Y51RhXkgXm97VCuNN6DsUxYL41vI0iCdntmcb
X-Google-Smtp-Source: AGHT+IH6rIWOZRxXGLfXM3hBFORUCVeOzGR5D+hYzdGO5CH+afHXBq5ojg8oHiSNF1X4YOi2iG7QuA==
X-Received: by 2002:a05:6102:3596:b0:5d5:f6ae:74b3 with SMTP id ada2fe7eead31-5dbb135dcbdmr5068089137.39.1762262946300;
        Tue, 04 Nov 2025 05:29:06 -0800 (PST)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dbf310491asm1059471137.4.2025.11.04.05.29.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 05:29:05 -0800 (PST)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-557bf688086so964916e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 05:29:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWLa/EuKFpxVduS7WMxcZZoHJsj7ifwxWTp8KDefFUfmyRAiOyW+rObUkrwOtEFA1Gd5ztgqNz09G7MeNc=@vger.kernel.org
X-Received: by 2002:a05:6102:4409:b0:5db:ecdd:1819 with SMTP id
 ada2fe7eead31-5dbecdd1f41mr1520007137.4.1762262945679; Tue, 04 Nov 2025
 05:29:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104-aheev-checkpatch-uninitialized-free-v3-1-d94ccef4917a@gmail.com>
In-Reply-To: <20251104-aheev-checkpatch-uninitialized-free-v3-1-d94ccef4917a@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 4 Nov 2025 14:28:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV+12MoAGNHC9kf==Bt0cLuJ39Fs+W61DN67sE_p-u=og@mail.gmail.com>
X-Gm-Features: AWmQ_blcNEGb9JhXjFZhCY93PMFoseFIULDniUnWfKSfhj8iZuZ5UaoNxtqoLrc
Message-ID: <CAMuHMdV+12MoAGNHC9kf==Bt0cLuJ39Fs+W61DN67sE_p-u=og@mail.gmail.com>
Subject: Re: [PATCH RESEND v3] checkpatch: add uninitialized pointer with
 __free attribute check
To: Ally Heev <allyheev@gmail.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
	David Hunter <david.hunter.linux@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-pm <linux-pm@vger.kernel.org>, dan.j.williams@intel.com
Content-Type: text/plain; charset="UTF-8"

Hi Ally,

On Tue, 4 Nov 2025 at 10:58, Ally Heev <allyheev@gmail.com> wrote:
> uninitialized pointers with __free attribute can cause undefined
> behaviour as the memory allocated to the pointer is freed
> automatically when the pointer goes out of scope.
> add check in checkpatch to detect such issues
>
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/all/8a4c0b43-cf63-400d-b33d-d9c447b7e0b9@suswa.mountain/
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ally Heev <allyheev@gmail.com>

Thanks for your patch!

> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst
> @@ -1009,6 +1009,11 @@ Functions and Variables
>
>        return bar;
>
> +  **UNINITIALIZED_PTR_WITH_FREE**
> +    Pointers with __free attribute should be initialized. Not doing so
> +    may lead to undefined behavior as the memory allocated (garbage,
> +    in case not initialized) to the pointer is freed automatically
> +    when the pointer goes out of scope.

I think this is misleading, and can be improved: if the pointer is
uninitialized, no memory was allocated?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

