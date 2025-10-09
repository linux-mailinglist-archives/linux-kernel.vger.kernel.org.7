Return-Path: <linux-kernel+bounces-846897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF7BBC95DB
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4CB74F2A52
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053552E9722;
	Thu,  9 Oct 2025 13:48:22 +0000 (UTC)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3952E92D4
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760017701; cv=none; b=J6GUHuhlqis7W2CnYp91B5T1IartuVUdXpfDzAtpEVFpalHO5Gdcv/5NTlgUjwzplyhPNqghtaXgk7D1txf6YRbWB46ufYmiSyZalKrnbJdiLH8oNd5eDU/V9/eDIMPzGPsE8G+DygLrypgNygO3JGOElg1fPRIN6qWIqN0HhMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760017701; c=relaxed/simple;
	bh=JjQpoyc0JbwG+FEvkuaWThczaXfrHcuUfCyMSt2Iwi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GaVKqHXzrXpUcjtv3ewjlk20BIzJOR2jMG14/XSZk18/ajFjp//wmXGUge2dK58i1CwdADD/DRRxguc4ywMdVq3zxozy8TCu+XZemfCf61iWLGTI8YdAUMqijcG+q3J2B0fQpnaC/3TjasA3ZeFCP9D4iCGiADfP/Uh6cKNhXoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5d28f9b4c8cso254938137.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760017698; x=1760622498;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i8nqM9b1HtBdmvYyNLXKVVMOUuh6yunOxpZ3Ex1Hy4k=;
        b=bjSaijETLrYpOSjkxaQWPVEUho71wnJwMYdLsbjlByV5EvnCkFCSeo5oUTOPaldrFQ
         ffOfmrQP/tcfFUhZ3hGVxB7ATT1pGEtIhs1K652mdKOsOIVLC2djbK8kA8UO+f8Tm2ic
         103/yV6eWqX+bCQgHBa54Hts7XEi7ZjnPn8rfaH5JcLJLAGgE7GJd7H9Zp3U/38LcNi8
         JgLmMhZjyImJzW8OB6pTHQDaNazrDcoHl5CpJS5L4lY99tiM45fHXOFukIXd7JspBII9
         7/dO5ekN6mYsFKcWX7Pt+CoKO0Z+DqO1dZBV2K+wXFuRxd4QHYy5ii1SoqjDaHS6Fclr
         9dhg==
X-Forwarded-Encrypted: i=1; AJvYcCVckU82kFbQnrKS+HnLei/FC7U+8HU3dw439KOaTU6CbgvUiWmlkyUkcTVsvI7pi0jDPKp1K5uNMVDAYNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzplhRiLSQ27zhZvDRyfUSz5JnjyJdNqmlSkED1mCTYamWH6iIG
	SgR3Av4huouHbgtWB8grixDextlh/qPz3FaGQyvJMKspYrdZUXbvUig9oVbnqcfk
X-Gm-Gg: ASbGncu5x1+bWcYvrS+DxSbHF05HGoSnpp9wPPVfskCSP2Z97XuXakdJmitXC9za9p/
	iEf8zB7x6PCI7clLrAn6fyVjDoNZOr91+30sfe3q9BlsetObtFxzzlC66K+oK4zFAQtlPiLkJfx
	Z0nqkZRzZLbT9cIRkiDdMTkgN7L5Ncz1addQn30OgbxlZwnRgAPiX5zBfDRHXPRkN9DQMp8zwFM
	qfCRMpqBu+OG8FLQstGF7v7TtD5bbhjQ3ntWH7KxKS0yHxtcnRYn74qV6JR4hJOUGAM151taKa5
	Wj7snrsJ/gNH4pUID7o7xDOpvbWP9XEv0iCekmF0z33SbPu47wpIl0dYl0Em1KRLbVVCFPwCI3I
	fEGtZYFa/Uap/aCLxwn+J3uRZ+VbGFfM3zFgyna8VNTIhKl6J+juU/2sYXa5ObcfwdQyeD18ZXz
	wz3JC+bRrvPVKge0YtNm5AgT7hVoDhdg==
X-Google-Smtp-Source: AGHT+IGn8Lyfon1psVduOmDbCqNDcKbQHofZAS51lmIZtth9gEghVN5zGx124Zb6/5xHgmds1m1Ovw==
X-Received: by 2002:a05:6102:a4e:b0:528:92b8:6c3e with SMTP id ada2fe7eead31-5d5e21ce95amr3616431137.1.1760017698325;
        Thu, 09 Oct 2025 06:48:18 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d5d39adafbsm2396021137.11.2025.10.09.06.48.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 06:48:17 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5b62ab6687dso1049320137.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:48:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQIqRHyPRyCR8ZMJosB2vVdz6lRD2d+RDlsMCj07qT98tfnL2HwzKOLAc9OSc9ZZOaDwBT66Xzd25S+Es=@vger.kernel.org
X-Received: by 2002:a05:6102:418a:b0:520:dbc0:6ac4 with SMTP id
 ada2fe7eead31-5d5e21d04b4mr3948255137.2.1760017697372; Thu, 09 Oct 2025
 06:48:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001212709.579080-1-tommaso.merciai.xr@bp.renesas.com> <20251001212709.579080-9-tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <20251001212709.579080-9-tommaso.merciai.xr@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Oct 2025 15:48:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUHe7KWiUiLLTYpn2xhq9B-xUoZ6pdnTst0NTMMwuKoow@mail.gmail.com>
X-Gm-Features: AS18NWDDR7-ixkdtwTI6rYs3jroTCBn6LCN-Tix-imcePNZM2CXum5UmVX7CU2c
Message-ID: <CAMuHMdUHe7KWiUiLLTYpn2xhq9B-xUoZ6pdnTst0NTMMwuKoow@mail.gmail.com>
Subject: Re: [PATCH 08/18] dt-bindings: clock: renesas,r9a09g047-cpg: Add USB2
 PHY core clocks
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, linux-renesas-soc@vger.kernel.org, 
	biju.das.jz@bp.renesas.com, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Oct 2025 at 23:28, Tommaso Merciai
<tommaso.merciai.xr@bp.renesas.com> wrote:
> Add definitions for USB2 PHY core clocks in the R9A09G047 CPG DT
> bindings header file.
>
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in a branch shared by renesas-clk and renesas-dts.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

