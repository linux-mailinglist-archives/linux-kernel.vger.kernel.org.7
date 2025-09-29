Return-Path: <linux-kernel+bounces-836208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40318BA902A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD353C3BA4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E132FFFA2;
	Mon, 29 Sep 2025 11:27:45 +0000 (UTC)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56212E8DF0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145265; cv=none; b=Y7z11C+rhGfNTCZeSvQFjKcaME+lrKAyTxx56P7HszQPVOcRAp+glzy5bY7vOqfnFPEQmtg8RFgIp/cYO0NNVELFbFhx7TIxG4CpK/3itccvrWinlmpxmGOfWWLdw3R5m6UO4Ohzd81Z9RvLc49mxLiVW1p6hlice76zeXpd6x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145265; c=relaxed/simple;
	bh=rmWlDx8/WnTcn1dhj2ug2PQJyxzNzRBfLIGobT30KUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gVz7Co3DYQmbCirPqRMEzB7HssTO7TxZtakniQ2T0ZlW9m13KXfNInPfc3v51NJ85RvlrLi9a5qT9wo3fab+D4sPgQ1vm8eqLx2w5We3TGg/ShzRVHX69NC0bMTeWifPIOhmmybLkg5BzEN4M0OKET3TW27GU+q1aeNXZlOwNH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-905b08b09f5so1178785241.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759145262; x=1759750062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3p5ZyLrRZH5goQlwa/vwelLSKRvjTSePuKZhRKGtt3c=;
        b=XIC2Grn19oPkP1xNGXMo3JsdnxDQ+JPAOKRRoHtTPdwepO0EzRENIT+EoB8oqDovX6
         QfmtY32RA7MLd5wHjeUH0M02cwMcOinqzpi5+oMSDW+VoGGzuYz+8LJtL8FB5dmXyalH
         jfd2Xt+PkIeqF0MrZe0OZzf0Czq1/4ZVr7H+PQP+ZEt5wchc/10CgD2gnptm9Z+OjSNN
         x8IVwR1njXsxJUOJjQtXFuGziWs7EW9Z4Lb4GfwzZhKDN3xXbAirwmUj9+JBhWMTKufj
         HS/L2K5UP7lgqCmlmAqNK/w+r5fiFCQduUKTr7QoGT8tCF4YPyvZLymmTYAJ+ZLTq+ts
         OV9w==
X-Forwarded-Encrypted: i=1; AJvYcCXQnyz/r3Y28BrtK4w/6BL43tNEKYM0WyWyX5/H9qRlIhFHW2R4S8m5nwQpU2si7/ljFBwnPfHpeYNywFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBB1XVDkpmONJL86f/CUN7mVhtlp9vmLmjjcWaysuAC+FPpxYv
	3T+6cSjY6k70gySA8SAqIthyZZWckpOFio2OnHsuKhJrDOlXyP809iiHm1T9QgkD
X-Gm-Gg: ASbGncuUGAF8F0DCCRMNliBa35nWDJEW4YLKCtHVNoUn4HQCDuRkrzUT/SoTvJqhfkQ
	7PtRSRnKWPt1Og2wRwB8oSvDDt3caW1bYAjSUQnL39wNkv35XJ0ySAdowpnu0I/OFc9Y0QWNPnA
	sMLOnrZJb/HpoQtzX5RCY2JGEJd8APn8VnDnMS565Gs2A77rJOIPUDIAS1pyUOD9cPZCcgrMPDb
	9WdN7b8p5XNeReiaKEIAh3Dl+O2L7GgiMwU0GxR467OnVaOmHQrl6yRCZUqN4Db3QZ3/KSFESqF
	vYwoPoMtGhEt5BGjTs+PK1d9Z8mBZkGS8Aun3MulQG5d+a+JizIY0weC2RZ6VzMc/9Io1Ikoj6c
	nLLaYT0mYXgG/8103DeezZe8DK6rFIXwG2fmdOm/XHl6JhYi6aVkTCpY1zDHF2WZU3W4j8Q8=
X-Google-Smtp-Source: AGHT+IGfGn4Xn7LnyCrBxukBP368N2l02ZHwdEoReTBI0Qb0JEKkxmNXHvKuH20Zeo6X8kiJMQRlxA==
X-Received: by 2002:a05:6102:c4a:b0:525:df9e:9365 with SMTP id ada2fe7eead31-5accd2151f1mr6244724137.16.1759145262311;
        Mon, 29 Sep 2025 04:27:42 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ae3b700a82sm3386269137.17.2025.09.29.04.27.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 04:27:41 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-89018e97232so870202241.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:27:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXhr+zCeA3d5oZRchOiSXuIe8prv43zDU/wSoqDx7K2HK1j71k13TlZUjnZ1QPTdhc9zMNtWkqL+vCooHI=@vger.kernel.org
X-Received: by 2002:a05:6102:442c:b0:521:7afa:3b95 with SMTP id
 ada2fe7eead31-5acd046d9damr5432533137.30.1759145260742; Mon, 29 Sep 2025
 04:27:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925224013.2146983-1-cosmin-gabriel.tanislav.xa@renesas.com> <20250925224013.2146983-3-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20250925224013.2146983-3-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Sep 2025 13:27:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUytaS3P9UrK-bpFSP-z8ys4w37d0BWCJ6c5idnM4iNTg@mail.gmail.com>
X-Gm-Features: AS18NWB5KjkQR6-4iBJ8hPH8oU_cNUXGPtBKbJx7p1IFxsy7u1OLZLpvVydcc3k
Message-ID: <CAMuHMdUytaS3P9UrK-bpFSP-z8ys4w37d0BWCJ6c5idnM4iNTg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] dt-bindings: iio: adc: document RZ/T2H and RZ/N2H ADC
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Sept 2025 at 00:41, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> Document the A/D 12-Bit successive approximation converters found in the
> Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs.
>
> RZ/T2H has two ADCs with 4 channels and one with 6.
> RZ/N2H has two ADCs with 4 channels and one with 15.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

