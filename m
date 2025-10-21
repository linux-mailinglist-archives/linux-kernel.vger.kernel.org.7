Return-Path: <linux-kernel+bounces-862346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306F2BF50E0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D811463E4F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9D32857F0;
	Tue, 21 Oct 2025 07:47:19 +0000 (UTC)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB809284690
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032839; cv=none; b=g0M+67GO26tWVu9JBopjv5JhRBk0jzBHcVCQmk318kRIJn7G9sg/LAurry0E0GSy3eW+AWGMeP+ZsOFrmX5xEHWSScfYB6fKTaWC8Gir8RPkdxrvttNC0BPnhcMoj6Di1B32ra6VRUa4Ztp/pEW14Y97pCnobYF7lvBufFoPpik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032839; c=relaxed/simple;
	bh=4rLfdYNYjsSbcnQhe0QwWJ01RmTVRIBvCLsXhlunggg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AgbLf91H1Pa9KVratIYgkNkIMmbcAbQzy95q37BXok1BvQLIKggyqHGFsIVQcOS8sTaz6rv59ZS5/EI+OKsC+GjPp6/l/yS85x2BqXwmoQkmPJngq8CK+G9K58ZpexQ3QAKBWYvZK/lyh4BTPaco9V1FpTJxfQEAmq2hGzQcRkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5d6266f1a33so2337251137.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761032837; x=1761637637;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hyBTSkqNbsTAr96ACFRRuX4nnSDrq9+ChtxprKl4p5Q=;
        b=EjMZOxBlIe2IV5qimNfnh5zy9+C9jvP/S15uVx3XUVTYSfK2+WGKpZuCbp82oNRdrZ
         TZAAYk5ITA4HRRfoaDLcUCKq05spWbqXddJDrgu4QYraFt3JChQrZDffE4GIqUnjKG+h
         20/426OXkoOHlelzG5LWAcYbxL4LRoXnqSNaNPbBKQtyVA9N6yCTp8GzLi2/TsjIFwiV
         VtF+48clxpNzesA78mkU7vFUiySVXo3y03InkgLhatO6jD84CDS/RnISQY47Ax41Y0QJ
         /jC65czBmjCE9tQRylewAkM7O29BM8HfwscmIgKz1PgH2vmr4AlLEMCdFHllNAajvLvf
         NQIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJpwJq2wsPv07w3gQEa0okh4OQEH+n2kuZ0PzRzIeP9xmwCUb5h+pAGR39jlkH7e/RRMpLv2wuyaLs4Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YymbGNRCZ5f4WXkX+9hmuuhGzIFos7cREw88AHRHiyZp6E0c9Qt
	q/1yRKlpQH2SNIVTRpfoRdg8dJ4rpzdCOsgjTu00e0Jqn11cY0namENCBHFnSDcT
X-Gm-Gg: ASbGnct+WRuTQpVuKvnd6PDOnsLB/aDe1OC6iLvaMp+lZTAlxnoDDrEp9y2lNvRsfOg
	KBcNrTXUedezniCzm6vSUkV34npV59v2/usKZHc76MI1TA9VKDrkFDNqS/8dsesedsleCgTywFL
	ARm22VZVyVlQ2/FfFMCIjanmRA9Ts0tqDO6FHh1kEbYhbsxKpMja3KhFoevuQibHbqhlb0fMj55
	w5u5BchvbzD0rGd8Kv/Ua3E4cXkD1uDJakoDxH8pVH1ucCLESmC+ZTN1jpgBbeWoy368xl0XidT
	asUIBUmBUwNBTz+4TUe5Y0WtEUA5GzBjpIbe0jaM9pyrgw9HgHMDbhA8ho5nO2dxV34l65ZnxrJ
	B/hJtPjlYEXa/ETMbk/AVCfh20Tt0UzogB+r9IuGKY18zjwGhNWlHd/cnZ0HMaVlsbpj+0Z9AlN
	xRP/BZpFgxTuib8N5MlIm+z+r5FvRqqhD2dKJJLA==
X-Google-Smtp-Source: AGHT+IFNxMONaVwWq3rLPv6iZTX+RoyW9dON0NuXNg22F7BNlQVVBP77aHVn81ob/vKkj9Whujjnjw==
X-Received: by 2002:a05:6102:40c6:20b0:5d7:df1b:6f4f with SMTP id ada2fe7eead31-5d7df1b7504mr3156981137.6.1761032836664;
        Tue, 21 Oct 2025 00:47:16 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d96c2acb3fsm3313716137.16.2025.10.21.00.47.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 00:47:15 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-930fe879d1dso1460084241.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:47:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGpWyHKCytZv3h9XU55PxIDCxzjuKJph68E8WWFUO1wyvw4r8EVg1IJKmaai2sGJVheRkIGS7L3T/7Mkk=@vger.kernel.org
X-Received: by 2002:a05:6102:548d:b0:5d6:687:ac with SMTP id
 ada2fe7eead31-5d7dd67f9a9mr4245252137.31.1761032834720; Tue, 21 Oct 2025
 00:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251005111323.804638-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251005111323.804638-6-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251005111323.804638-6-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Oct 2025 09:47:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXDGJyp-aOWSMuPR79heRGg07VMd_F_GgV7j7yb9k+RSg@mail.gmail.com>
X-Gm-Features: AS18NWBfETG-hXu7wbnQOlGl6tEMYt_Vg7yeLyUKLs2dRaA7g8MciWHBy3GKdoI
Message-ID: <CAMuHMdXDGJyp-aOWSMuPR79heRGg07VMd_F_GgV7j7yb9k+RSg@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] arm64: dts: renesas: rzt2h/rzn2h-evk: enable ADCs
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Oct 2025 at 13:15, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The ADCs on RZ/T2H and RZ/N2H are exposed on the evaluation kit boards.
>
> Enable them.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, will queue in renesas-devel for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

