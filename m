Return-Path: <linux-kernel+bounces-830506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE723B99DD4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5FA19C3B4B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F44B2FC038;
	Wed, 24 Sep 2025 12:35:42 +0000 (UTC)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861992417C2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758717341; cv=none; b=CNIJEQk7qzl2PxQTHA+orWAgrmF9rd6brxmaJYnwyoxlCHv0aDot9KZ1VObkWye9gh/Qz5NGvGr9ydqGXfdC7DYIDwBuk33W+8mghBgj9AIximD/IsICzTJPuP+c5J9Mi8Pj06v5YBuGkTg3Tuii7YtXzgF5a2UUBj9Hr6BEPI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758717341; c=relaxed/simple;
	bh=VfwWAfLpuGLpI11UmODqos9TpOLKsiUzfr7Q1yFxZ1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTiPdUb5n48TlR+nJsh+ZAbYxN2kXQoaakFvYa7b940Z6gYP/aQ61PGxOOZZFXd5dE77TIWbuxK8P87HZ9TecwIp40OgQhAdeCOpdWdcedsqYtOUEJkWIaV+iPOKdhVxErpUR+v4/HbgCSSDYNWh2cUUG0c4xYXMu+UDX9FtqjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6327423f190so936741eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758717339; x=1759322139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+EtM0NmDXgJTrNIb6JfBeypppOPW5YnsWzYvqHm4pFE=;
        b=c6ByO6ngnU3HgiM8z22a+wqV81CxBrLjVuxtN+o8LbAcKKnvqn515ajGALNZBp3Zjo
         5XlS4YMDWlrsKrQpHk6ZNg8AetNyBdraI+WURJ+LEk3yB/ilakA8/TSikWl+ljbCvqz0
         fzAHkAiIbx7B7ZFDQmPa3GJ7IH7sbsYPA/3KSWw4bm8XfGjeJyVP/ZHrE1rPCjaCmMus
         9IuElP9FwlDjx78TRA2S0C5dvHa2N4DwiV1QnwDCpd8+WizGc00+apHgBivaw+L0g/GG
         2SogptPYXDWpgs4X6fuuxi+IfLR9Ril3KelrXCNIUYdv8gL4evSu/RelUaWG8AAfifZq
         6LtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXRMrT9fra31dhcjWT64e0GN9e+sOEAs7179oQz9wT6DORxybLRjb7Yy/caVBceKNUCEHHNOHtFijFSYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Fk/fWll0RzATys89/giQJNhpTwaT/ZLHE+km5Q9112ZP2EV4
	ECHyhu6MBpokwTDzNYUsPDYKZ2t8gWj3o+VWLriIL9A62CowAt86//XtUKrrCqzK
X-Gm-Gg: ASbGnctoisZlddIBEyUcRLVDRuW9ZoOduOK4e4+kK7EbgpCGe0ocp57CDDB5KIZuznV
	CQzYSEqQlbwpaYhrvWaGZoTNsrlxpKYIdfiFt9T+baO7WAsvw5SrwOWxgy/ciedx+yFP5xI2fdA
	tS9t0z59BmOOYqyq9dAgxtSIPXnvexic+greEZQh1UYQ9O7o8FzkCesdyxqLxmzjIKdnd77JG2t
	BJnf5p0L5hMzTGKV2FZX8Ullkb9VulNlGizzDg219tEF0Ejd8jriA/ot9AypZgjH4db1nfcVYPN
	mS7KleNW7p7Tr/kJHGNVsUcS8I+N1YqdkXy+aCaejjjjtB70n6WXWkwBiC1cL/HDWjBcdsgiPjx
	cDE73/yp/wRk9ftKVowvNi6WHxH5etg2D/U9jF0W+YaSmo+4iF8S0UdcBz53z
X-Google-Smtp-Source: AGHT+IE9IeRTPnSP/ACNWOhEE3OiMnlQDJG6DUe08yHUETFaZzyaUzn6FvI/b8kLyQTFa4coWK24tA==
X-Received: by 2002:a05:6808:5094:b0:43f:1e7d:7c7b with SMTP id 5614622812f47-43f2d4a3cd4mr2348385b6e.47.1758717339285;
        Wed, 24 Sep 2025 05:35:39 -0700 (PDT)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com. [209.85.160.47])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43d5c8232c2sm6582471b6e.20.2025.09.24.05.35.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 05:35:39 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-31d6b8be249so6225000fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:35:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWM/pYRAYa6QtGBTfWg5My9k95BgOXy09hEjc+1OtzzgelP+4W/f06m0Nz76TJBcahhRyK00SLoaPqZjx8=@vger.kernel.org
X-Received: by 2002:a05:6102:26cc:b0:4e5:980a:d164 with SMTP id
 ada2fe7eead31-5a56fff866cmr2086659137.0.1758716909035; Wed, 24 Sep 2025
 05:28:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916150255.4231-1-biju.das.jz@bp.renesas.com> <20250916150255.4231-10-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250916150255.4231-10-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Sep 2025 14:28:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUVrxtMoR7nxrVwuDuZRNpG1a41OfRJm521vo=S5EOY8A@mail.gmail.com>
X-Gm-Features: AS18NWCMDKVUGKQgSB3C0NvRa7hF5DASAIBkCuYR4D0F9J6oYSce5vNi2fPDjI0
Message-ID: <CAMuHMdUVrxtMoR7nxrVwuDuZRNpG1a41OfRJm521vo=S5EOY8A@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] arm64: defconfig: Enable RZ/G3E USB3 PHY driver
To: Biju <biju.das.au@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Nishanth Menon <nm@ti.com>, Eric Biggers <ebiggers@kernel.org>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Taniya Das <quic_tdas@quicinc.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Sept 2025 at 17:03, Biju <biju.das.au@gmail.com> wrote:
>
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Enable the RZ/G3E USB3 PHY driver on the Renesas RZ/G3E SMARC EVK board.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

