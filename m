Return-Path: <linux-kernel+bounces-868614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D33EC059FA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 370E91C20858
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33BF28314A;
	Fri, 24 Oct 2025 10:39:09 +0000 (UTC)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E46C2FE041
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761302349; cv=none; b=jK9USosOSODe/hQFpnYZU3XSjWu27MZlK30BWM8j/ZzS6PnKLJP4uQgCqxUpWFZHKbNooSZxdt2n7m0hdkTC6/jqaoJOm6JDMQi0Uthd09inkYx0FpZA53TSRcS2jcLv3z3v0WfmuW24hDhokI/GaWkmI1a3NVWKizCvhXf+QZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761302349; c=relaxed/simple;
	bh=xYDIaAtHlpq4aCLHhr2Et9EWkrcN8tXhB/rgvIKV8FQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MXtn9kH3gvOPuyFazbrJNSF9kEBQef3XrgZ/zBpY/j6C8ng2gQzsQThosFaDmYOJj4DsuB3dFCsLRXrIAy8ZRLpxZYK/0pyXKjVxfX3X++pKu0gisixddyvOppqAunUFWcZPUEVlt6CettQGTHbNSYExL/DcFLK0q/Vu9cZIor8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-932e885467cso1418942241.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761302346; x=1761907146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nXbJXdZuwtjDIdswroCFJwLSL36xsyFBW0J7iQ7tGA4=;
        b=eiyD6MVM7FA5abwgDXOW8m/yON+5kyW3UAQ8bFmfw2hGSUi13LIyM2EUyavwqkz7X+
         r7sUrMtQ5DBSbgLJNXZaUaDYIA+/sOYBlOZr8BAKt+mBpmJP3aqZnXIZ+dP+g6qm72LR
         hnggM+RMBIdsKzFXRnZ58NDBJY2t4RNJcFAp9S/rZrSvSnjhffY+mUXb0MJTgCqdNdbr
         HwaAATtVz8XNpPPJjmJr6cCt0ENMbqu3HgctXQo3eakIziNxg5b4K5h6sBf/6+qPVzAy
         JJk1xEsWGqHfnSFQVCn689DYdOyNL8EWdSgP+janeU+JyR3Xtv1v0SsBhbLFWwmfnjSl
         WCBg==
X-Forwarded-Encrypted: i=1; AJvYcCUHGcUrngPUDEphbm9geJGWaswvTFopo9kxHhiitYE8Ys8Qej1fSXhjRbiX7LusaD5ZuVTluMrlh2b+ASo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuGySTIxWqjSa+8+zI/JJ788+ATr2JiMry9m1P5Z9ODMkQgDMa
	OY585l99XfinY6NmId/WwMUVU4XaIyIro+I9rkvo1c/Qb5Qew8ry0102G8s98T+u
X-Gm-Gg: ASbGncs9+eP+yWsu277Eegw63zHsg2+IUEjCNiZPZ18iVyb93ND512CSz8s/yflW0D1
	2dH7aX+QEjGOld38nISTD1ykFbwS++kvQNZPDTV9jD6gI8TxDyGqjfdNleW9AGXNncmO6c2D69I
	22rS6JxcIwtFsioOvUEHjijlmgQYCgrZkKm9mL9tuiZYorLOI/WFw/HkjzZyfa2dRRE7kbfjPNF
	oniMfsptyetVojBjLPxPfAQrqAVQ39qA6xTDaZgSQpDNMjgIW6DRY711/3UXulekXU7PolMnffC
	9//T7H06m3MnyL2rq7T8U/npFCTMuQztaUyvvwsH1TBAtZxylkavNem5y6JtiHAflPZw/qS07vN
	Y/8GfavijraFHOkLPmUlMIpkNxkP8HqpjM/Hp9yHW9i5wmoG5j0kupomqBvWdz3zn7siMf7EDj5
	knUZpSV0EkKzZJYFWAjqQxMLrApP08tFHaGrQnX8MJYrXDwxOj
X-Google-Smtp-Source: AGHT+IHr9LnHRV0KZCbZiJb7JNy/tsOIaJPToSfOiZcov3KV4A+ihLcVU/bd5xwD/Qnq1J1J/snhUA==
X-Received: by 2002:a05:6122:2206:b0:556:3bd1:85aa with SMTP id 71dfb90a1353d-5564ee4997cmr2594862e0c.8.1761302346153;
        Fri, 24 Oct 2025 03:39:06 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557bd8e5e87sm1895914e0c.11.2025.10.24.03.39.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 03:39:05 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5db30731362so1587397137.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:39:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWari4Y/VhtwwcfOiZlTqJD7/MggpeUA/DD8dukyT5+dOzI6uei/vr86v+UYRXffPo06BlinjTRqH5grpk=@vger.kernel.org
X-Received: by 2002:a05:6102:161e:b0:5d5:f79b:e93b with SMTP id
 ada2fe7eead31-5d7dd6a43ebmr10434893137.32.1761302345477; Fri, 24 Oct 2025
 03:39:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023210724.666476-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251023210724.666476-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251023210724.666476-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Oct 2025 12:38:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX6kXwnN+xej9jcr--NQqWeEX+a_V3EUP6YRnwv83iVYw@mail.gmail.com>
X-Gm-Features: AS18NWCn2ugKZLkqYLpsP9JDnV7zmuK_otCIXJWTBFNHqvbQ0CEn3hVk_jPHMqU
Message-ID: <CAMuHMdX6kXwnN+xej9jcr--NQqWeEX+a_V3EUP6YRnwv83iVYw@mail.gmail.com>
Subject: Re: [PATCH 3/3] clk: renesas: r9a09g056: Add clock and reset entries
 for ISP
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 23:08, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add entries detailing the clocks and resets for the ISP in the
> RZ/V2N SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

