Return-Path: <linux-kernel+bounces-897774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2D5C53A3B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A0C64FACE1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB29033F8BE;
	Wed, 12 Nov 2025 16:48:04 +0000 (UTC)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ED3287269
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762966084; cv=none; b=kk2pvRNZAflfIAymDjyuyYgM5VcdtFS5fjgtEL+oP1dRDWxVH98f56jN3nyOYfoteVscXGsKc5G1pstKqy7HUL08gXYxuLlilcVQB3OVbqGz4Ljpse56QZzUBRjzNmtcJbi/jCAzURRaHX3dFC9kwuHlumbZ9MTVw6wQGzp9NNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762966084; c=relaxed/simple;
	bh=BwRQFFjStra3DsF4NaVbCbesa2D7H6XBGB1YtS1E5Wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTFPw01XZ6ltAtwWGkSmWyt1bFuV/r+cm+Pw7BP4J2NN/A4Z8wCBVIy5RJFbaomP2bqnEIXbP9nY5F1o38jWTBEGq8e52BDmBZXjOwkTEWM4bFYI1WBRWiPOmcJYgHdsAKk0qWRlzlbeNWhi9wPHXZm4vV2Dlxud7+Q01HSoyDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5563c36f5dfso246760e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:48:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762966080; x=1763570880;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fznzNSl69lKMgOov3QZ4fMUSrBwsRp9eCNzvWDgHwfg=;
        b=DnMWgB53yHsEwt9VgSIPKWFmhBGgd/u6MjjfePH6+wDjuJuJwe9aZgVPzKK3AdMwwe
         v3SVZlmtgTlZjartqBM06wdn1s2xczswJQxAtF6UMmsvf9SnXwGOF1L5jXodpGNeKwzc
         z62g392dZMpE+P41g79XdlEDHTF7o4Dt9743ZhGCUJtFI0P/nROBM+xqoe99W3goQBKs
         86HNG/eKsYEDb1YcvnGcMsa/4L6GF1TGVGL66tUPyXo3DdjtSrXTSF7vIsnz4ajyRKDG
         w2R3louZhey8eJmChtTYAGHISwjjOrkzJlqGNIDouU/tu6Z4UU6fm2H7EFIsk25DzMFU
         0N4g==
X-Forwarded-Encrypted: i=1; AJvYcCXm5crO6UQ7XHEOIrmfguUaPhRIObKbzpRSu9oHwizQMH/ekOGdAiUqjabNetRTYWFbZCtZay9NpDU9/1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3B9eWb8wdLIUwpuC/KpjAj9zwhK63yq6Ff7L7SnxAl/EvC6SQ
	TnWDj1fnJmImI7FnTLe3cJNqetqHNizy+VcjhTX0Xnr7vnFuJ/hej+LOjx538WEC
X-Gm-Gg: ASbGncvTTom7WBC8SCIFr+DqmP/XtJ+8I2Mb4Y5XVEm0ZcE8WADN2xRyN/zWgJLiR+O
	WxRz64hyKzYlyZ10ODAjo/p9hU9HcMBBikwQSoulu6VdKmx1QF73eumBCKsARsQcOXl3BiZ64ys
	RG9YQJAkbkRtTf4SPsnu7PTW6oI2jb8KbHduGRF67QhDmv5tdReNWt0qeqrVFW9PdQ9NVlWHyVq
	kyNktBVXHIUnD3PKgYNluF/hoI+bnNbXeGkwJa2+ayD/ARPAvTQUel608TpxxnnTUMGynh/kkcV
	slgK0ZD4E15yydQZ2m9PR1TSUUKkHfxusRyMXZ2XyYdO7NmW7GYfmLGdmEIHeCi39p+CgZ5daIA
	UK/7LtPh+bPeWGwr1r76r5i3bibBUa+Ziu79AIxgV6suJ4gj1njd9ZlZPTxsRoI879QSzKdz+xv
	OFcPLTElkKKPiDuY+qLP/WZcMikuuxXA7frIkacA==
X-Google-Smtp-Source: AGHT+IHMm0JfOGAR9Q48WsVjAh2Zgv4kwOdeYAq57IgZ3JvqpTTaoUXUi2vFvDQc05uJQ4aQd3Y5YQ==
X-Received: by 2002:a05:6122:2045:b0:559:f0a2:4ab5 with SMTP id 71dfb90a1353d-559f0a24eb1mr578258e0c.11.1762966080475;
        Wed, 12 Nov 2025 08:48:00 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-559958286c8sm10005567e0c.17.2025.11.12.08.48.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 08:48:00 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5dbe6304b79so443333137.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:48:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXyag1AZ9zMEc/PVla521vYb4QeOrrTnq35w6SE5YuFOcn+3lTk+Efmd9W7WYBMS/GV4WbaEXe75WTgRa0=@vger.kernel.org
X-Received: by 2002:a05:6102:c03:b0:5db:dad4:803 with SMTP id
 ada2fe7eead31-5de07ed2044mr1042935137.35.1762966080037; Wed, 12 Nov 2025
 08:48:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112143520.233870-1-yuntao.wang@linux.dev> <20251112143520.233870-8-yuntao.wang@linux.dev>
In-Reply-To: <20251112143520.233870-8-yuntao.wang@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Nov 2025 17:47:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUj1G74d9WoNJFNjeQ6tOENW8kZfr7YMwRvLUaQnuW6pA@mail.gmail.com>
X-Gm-Features: AWmQ_bl96eJ0z2R9z9MwX4iTUg9zDacFdfuBv9uJoul9zbfPX5vA8c0U1fmngLQ
Message-ID: <CAMuHMdUj1G74d9WoNJFNjeQ6tOENW8kZfr7YMwRvLUaQnuW6pA@mail.gmail.com>
Subject: Re: [PATCH 07/10] of/fdt: Fix the len check in early_init_dt_check_for_usable_mem_range()
To: Yuntao Wang <yuntao.wang@linux.dev>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, James Morse <james.morse@arm.com>, 
	Baoquan He <bhe@redhat.com>, Zhen Lei <thunder.leizhen@huawei.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Changyuan Lyu <changyuanl@google.com>, 
	Alexander Graf <graf@amazon.com>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Yuntao,

On Wed, 12 Nov 2025 at 15:38, Yuntao Wang <yuntao.wang@linux.dev> wrote:
> The len value is in bytes, while `dt_root_addr_cells + dt_root_size_cells`
> is in cells (4 bytes per cell).
>
> The modulo calculation between them is incorrect, the units must be
> converted first.

Thanks for your patch!

> Fixes: fb319e77a0e7 ("of: fdt: Add memory for devices by DT property "linux,usable-memory-range"")

That commit merely changed "<" to "%".

The code that added the bad expression was:
Fixes: 2af2b50acf9b9c38 ("of: fdt: Add generic support for handling
usable memory range property")
However, that code was copied from:
Fixes: 8f579b1c4e347b23 ("arm64: limit memory regions based on DT
property, usable-memory-range")

So I think you want to list these two Fixes-tags instead.

> Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>

For the actual change:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

