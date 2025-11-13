Return-Path: <linux-kernel+bounces-900090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 102C6C59945
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D5613B39DD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB59316910;
	Thu, 13 Nov 2025 18:54:59 +0000 (UTC)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7574131618E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763060099; cv=none; b=MDOfC5jSeLSuslJ8IByZzLjhx5dhlTj9xJfVg0BzBdykYh/9yvKDwpDfFjnfYom38JP8f73Mv/1Oedo9UrFRlal3O1t7DtWQz6Y8mNBqIRjNfaQDvJgPeZc2CCzdpqOPwk0zfJjNBOLm224pMZE3+D0YByy5KU+ePWiJG8BhOvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763060099; c=relaxed/simple;
	bh=aTL/CvYlXBXlKqttDnMbVw2A6aaApMbe0Ys8TkKMMFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DkqGgOzFcUrAxum4j7N6iHozD9fGmXyMpwtre1lXZS6iFjZzF1rzy/DvNVSjQvw4Q0mtkykHquiWtdrXRRopsXnJovhurICNFu91GaHOC9oXSkxn/+zVGlX0vIJ7OjxKMgZUoepb4DcXFHdSZJkS16+5XVOTiaaDtUmNRJ3FC10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5dbd2b7a7e3so824237137.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:54:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763060096; x=1763664896;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/YE8T+hus+YJz4kOdEnC5RNNB3F9EQPBk/to49jz4A=;
        b=mu1bNtNL97+AXvcgtKaSFR6Tbw6ZKxzrQNF4x3txIk8Je4STQz5Rha3FimX+/36Lu0
         ZqTAEtTOvfj0i3/s0pVDjaEfGlhniGyiCyb+JP8jQHy0RAhbtvdM1bwH2NdCzRV3TOr9
         Flm5o2So/1i9uDVIkRo/YZRhrECceesvDw0P1iloZ7vFJj3ev+xK4FqMEj/a8iFfyRNj
         m0xauwPc4hX/RPKLjHbENm+E7gHrHGR/B9wIJ59PRxSVvr9PrvmCZmn2FdUjZZa6MsNA
         xpO9UjWaoMxbEAfrwzvfH2rsnjoT8VIze4ZB/cHfw6KpQh02/PBwKPUunPY1fUZ76069
         43Ng==
X-Forwarded-Encrypted: i=1; AJvYcCX9h61clfHg4IWCVNIx7QRv3IqADu5NK3mWph3mSDrHlX62UiJaGkBzxKVqTnMgBcJ/GwzI3KNcjJ4uSFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHyjTnja59NdaCEO+UswTtCLM5WiFszfKUD73TMnNJrYFuY+mg
	9oWMae/9RYV6wkrQjZVDf4X1BsCoQuXzQP+De8AVuYamWkIb/bBY77x8oCpeOq4TJY8=
X-Gm-Gg: ASbGncta8woreTRtat6g40EuBcerpMOTqFtDulOAoPAzZ+nl7yazACJQQ1mxv9LMykm
	9wLtOyxQB9pCfgYJNzJXTU9i1N1rGELok3cA0LweFVol0DW/SCllfCvzgsvVsO1km5XwGakIQL3
	5UBPJAuWr77jhN6GbKfW3eMYT0DjYTB0lnLruU7WOOD/FGnjFs9H/jupujsjloMQh5hyUxf5xAD
	S8VUXCoyu7zE55OKiFmIwRmA/tTGncGnM/tnFo7wiuElizy75N8FWCKWF8SxTNVtiiaaIHRjnyz
	gJcqygRbKE/PbO0w7G3qCdGY1m2G7SmBxPKM9kOadarM2hiTgFI7+ZA66DAUSPWWUuII5BVMgM6
	FfPiJbD8iuo2hNxX+itFII8Pg/8AEZ7DfPBchkiRSPfICIPFEgle6CTtkhQPbkoCyhdd1VvAhL3
	4XVL21ifv1gOca8jMeInDsvB8ECYFw9mrky47rFYKfsw==
X-Google-Smtp-Source: AGHT+IG5YFXtz3JPo95UP0nAgCAI9HHO4c6KJaT81oJiVINnDnUYaHSitcEvaxjQNbgayOp6gbOvJA==
X-Received: by 2002:a05:6102:e0a:b0:5db:ef3f:6c7d with SMTP id ada2fe7eead31-5dfc5556bf8mr458310137.14.1763060096109;
        Thu, 13 Nov 2025 10:54:56 -0800 (PST)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b0f499dc9sm928129e0c.23.2025.11.13.10.54.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 10:54:55 -0800 (PST)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-559836d04f6so785635e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:54:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVwWk82asQ/OpBORD1H9DVZikYdvvasx61BQTHlLx056DWW+rdaRQx027UbEqc9agXuWGmuJZ22gVU2wjo=@vger.kernel.org
X-Received: by 2002:a05:6102:4487:b0:5dd:c3ec:b5b with SMTP id
 ada2fe7eead31-5dfc5b72883mr385433137.31.1763060094990; Thu, 13 Nov 2025
 10:54:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105070526.264445-1-claudiu.beznea.uj@bp.renesas.com> <20251105070526.264445-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251105070526.264445-2-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2025 19:54:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX6jBKuQ+7bkVwXDmHS+9gUqtHVofyH-WuSS-Rnp939rA@mail.gmail.com>
X-Gm-Features: AWmQ_bltKghBsZLySw-l2vh9sgIT7XEySbfTSJhtupfmI0PXdUgVSCq0B2b-psM
Message-ID: <CAMuHMdX6jBKuQ+7bkVwXDmHS+9gUqtHVofyH-WuSS-Rnp939rA@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: renesas: r9a09g056-sys: Populate max_register
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: magnus.damm@gmail.com, john.madieu.xa@bp.renesas.com, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Nov 2025 at 08:05, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Populate max_register to avoid external aborts.
>
> Fixes: 2da2740fb9c8 ("soc: renesas: rz-sysc: Add syscon/regmap support")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

