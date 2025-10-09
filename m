Return-Path: <linux-kernel+bounces-846853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA18BC93C3
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2953B4ED902
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8C92E7BDF;
	Thu,  9 Oct 2025 13:17:45 +0000 (UTC)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7622E11CB
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760015864; cv=none; b=EPIw/G/xi1/+tkn2CZ9U0GIKY6qVBm3lV9s5EhbEpZry2dR1iqGo7c/mqHMAd+RlssXKNC4DehbxidfsBwHk2qaPo7dMNHhwWyxQlKZeSgGeO3IktjzIUfEerLngVcWYc1Amef17wPNAioiKAaKHWMbSziSJDSI8EjRTMobZVDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760015864; c=relaxed/simple;
	bh=Ltmobvy1f84KfY6EIOg6LAsOL7fbdFI22vqu7qYDFx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D7cvzifYmjp8cnEjraNbBm876HrsK624TY5xZDUMlOtO681CHUdINKlMX9Wg7q9oC3LkoWXhsCokH5NjyWlyzz3Ee6NK+joFybFIm5C9y42J9oftifrMrFnRIEGE+PYfBIoqPMUdChYh/y/iDAN7ABxI5cGTJ1w6LIZ6fYLFx+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5aa6b7c085aso1192698137.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760015862; x=1760620662;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZDDJZzAoOLlZiieGR0CA2H6w2gRSUvJq4uwBr2r9KY=;
        b=t57lE4xpuEBClac4hEg6Fw7EA7FX4I3AuCI/vOzbWLfuXsDA+aGE4cS36XYiocVDPc
         zk1K1H3opxPwSKwldUt6ccoIS5rCvkn+fuHI2LSLrSW6KEWOkHHgiQkjgSSvkZA6yAPM
         BlP+TB7REMgtDXHUqZ0W54rllL3yXj2J1Ya8l3nmhAvkd+ZeMB6R8nWU5rZEuYNoM28d
         kNzHC6IEh8mxPTBzbx4Tduj8ZfwmsbgTYWN7HbSLYmWlHgPHxUhENmFTMJSQp8E9X/Pc
         28whNOf8iIdhNpg+NlSLLagAfva35Lqfokl5FmSbPvdvOZ58BaWIM6/pq9Rr7U21aD7a
         47Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWVZyLIalwg0BBVzFP6ilnxYI1SwPZyg0QZFQ+slpVsdw4DF9Mw/3urwJ6lST4u2BakKQJMlKSdT7rMYuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoc1OekEf0kv0ASEHEic0wdSn40E6I0J1Za0vtsJNVVlg2h1K0
	2WNJXH65dFOQQvexANMRutTnfDPh5Pt9YmXPnBLfFUoYF8UPJ39yBlyqdHYO4Bon
X-Gm-Gg: ASbGncujR0qj9G5nuO2oeAangc1bWSuSu3AOa4urIUDG5NfZ8AsfcvUuo3GpjZ6OjA4
	fMJsHltDhwdzrne96V4JQXha2wKmXpySdjSxZosEdsIFINKgwPqi2w9NKZzW7S2kz6PvEdF9mYE
	B5DzwjPwAQqOqia31AbncgPnspAVeCUq3zen+RFTeS6Q9JDx7+yaO+/tYUowCCGStmpzlzopNbv
	gXasJ3zqaiTJ3tS1geFaLAe5yjcROC1guTplih3BQuV+d07k5eF6XH9zrEFU4mZkzP/CGVKQIlM
	VKWygTPeDCkhuSTba0A2YmzeMWQVnURfgmyRznF8iJxCesL9wg6LnDKns7+ixvRk18cUwkJ9AEc
	JteIj07QM2on1sHRZLTzh2/YT4amaPukcISyXBqj4dSUHVXoVvZBc6Xt6l4K1GykuIp90cV6W3D
	H5SkYFUwVb2o/kqgxE0yqJUCE7jE3t4Q==
X-Google-Smtp-Source: AGHT+IGeQfh+G1R3NuDE68WwLAd3UbafFeeqCcfg+JlDrbKiHjnCvCiKlGC8FXnSWxWEyNvSFZgmKA==
X-Received: by 2002:a05:6102:5a8e:b0:5a3:eb34:6105 with SMTP id ada2fe7eead31-5d5e23ae1demr3326941137.26.1760015861593;
        Thu, 09 Oct 2025 06:17:41 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-92eb4dc8b4esm4601455241.9.2025.10.09.06.17.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 06:17:39 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5c7fda918feso1144353137.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:17:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXiAIdBFqVPh1QKy1KADADGu3LjZQZFfMUccshSQ2KAz8XKFDoA2FlYyKfXkTL1SIVAWkW4K2uK+2pQyhU=@vger.kernel.org
X-Received: by 2002:a05:6102:290f:b0:5d5:f6ae:38f4 with SMTP id
 ada2fe7eead31-5d5f6ae3ec7mr514763137.43.1760015859180; Thu, 09 Oct 2025
 06:17:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007121508.1595889-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251007121508.1595889-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251007121508.1595889-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Oct 2025 15:17:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXTvANxZr5wYD2EG7WGkkqGw5B5O-3=bVuRv3ToE2mvkw@mail.gmail.com>
X-Gm-Features: AS18NWAFS_XUFRrNgdqk12yyHdAEMQhOLAy2yQ8EvwK3P_MM9bEB4ZpzZb7CSuA
Message-ID: <CAMuHMdXTvANxZr5wYD2EG7WGkkqGw5B5O-3=bVuRv3ToE2mvkw@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: dts: renesas: r9a09g056: Add Cortex-A55 PMU node
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 14:15, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Enable the performance monitor unit for the Cortex-A55 cores on the
> RZ/V2N (R9A09G056) SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

