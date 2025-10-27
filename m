Return-Path: <linux-kernel+bounces-872647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B12C11AAF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B807C19C8488
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67879327790;
	Mon, 27 Oct 2025 22:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fNbIOiBX"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A4025F7B9
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761603727; cv=none; b=d1wFRRx6GOr1qVoRuKrwv18Xk9DXjwI8t11vd8Wh/Ef+ABs2e14HgXJe7QHhicdbBkdmBAs4ZsHXznj/lCpzM2FASbpenKOeIh7OQ03qLZ+g5oIQugQXOgCZCdmH/ouc/Aic7yXZ5juoq6AaMIhTmIynu0hllmK6UCJzF8woloo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761603727; c=relaxed/simple;
	bh=mk6CMIMtIPdATtZ5umlYg1fI23JT3IVr09wXtRVUQbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pBr2yHae9gjt5yeAPEDIyiEZdBw8Nl6ZNGWWMrXcnBfdS/rSk+9ohRy/a4YOewIu2P6JwtP4QfIj6EtPIxtz2/aCd0QHtbGIW9kpUoQEFcp2bIriT2K4xFB4AEF5m36H6gMy/uPnpSca9YTGw2AkcpELJJ2P594NpPN6HFxHZT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fNbIOiBX; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3737d0920e6so86301731fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761603724; x=1762208524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mk6CMIMtIPdATtZ5umlYg1fI23JT3IVr09wXtRVUQbs=;
        b=fNbIOiBXDVwPkJTtPTLfD880TP7BzJbz6Ub+lM6JoYGFkIp/AX3kU2BSuY/dhNKgbe
         eM8gkuQYAQBQtvQvdQE92VCM6i1cLQU33xJlDI+ETgKs2I0+Rx11wHoJzUSXvNXkhqcT
         UlGRL/xijZVOMf3RT5oWnVjIW/QUaCKN0SAlZdox4ROGsqdHWLv6PoaOEG0GEo9ZwacE
         gikKKFk2sTeZnbkAJVjHFmhMPlDO0N6UgRF26RKNyPOdHbHXKQD2H7Esp/4btIp+mCBG
         mxSDSEMh4LRzjiG7cLnj09EZy4LGtOruKNMe6tUG1LK8YzTPFhs/5lQq+ykvjwXBaIVR
         HQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761603724; x=1762208524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mk6CMIMtIPdATtZ5umlYg1fI23JT3IVr09wXtRVUQbs=;
        b=YRvnXubBgvNb0d1df3ismhdfyrFdayAWQ56u4daZ+ysdlc0axG2UQGDwapS+p3zPvZ
         P4Ci3cVQxuRmij71NQszIKjSLuMcj8m+YGe+ziEnhBx/5DE5FtxryXa+JY2KTssMSM4S
         rQktcDSrqbfq43uoylN94os91z/8nkxAyvkrOlJrRSYhA+MMhnrEtgA6vZSIpZsB2Khm
         zNH2X3Ejg7ozLYdYZPgwmNVGz/NkvTPIVU1ByW5ytvPxsGDXw+cHHU7xZN22D+OrygJC
         OVPmlkhvlRdVQpeyh1u7k73tPP3YqbIP/3eACt5GzYVsJExJeB7BQOyt1afOtdiNnlqN
         yTMg==
X-Forwarded-Encrypted: i=1; AJvYcCU8+2kjRWeFLhUnN0pHNDc8avTkNUj7l5uTKlY29qrxKyTY8z37Y1rMUyiBB5MLpgbj6B4htLqcQM5lrDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrZG2YY1blv0v4nOyjApjLjT1qzDKSwzYGfitIfToNsqvdyNRL
	ncIm1TYrt3xIJrI6nfgM71oh4DXAZY0vGxttt64AAic7sQ460323hSgmPZXnvR6QesL/dQyq7A9
	fuVfcK4jafivETOmtIJ/91CBu/vlYMCB+j+5i3Iky1niJh5PF1Xoi
X-Gm-Gg: ASbGnctOapXvoGLlsVW5PAxNVEuZtYksf2LRR1mzlW249YsDFpYBNtofuPcstUfwFT+
	55T1NcVrI9NaWTHYpk6j3Z6Bcv6gBFH/9z4jvG/L4baS/AFd8hk3dZJCSp29JEWYGhJLs8BP7ex
	QJgZlweZ5yGLltvKHiGxIX6nc6ESOitKjrKdfTH0vZRKi9qhe/VxPNj7loHDEmXjYDmdle1VirJ
	r7Um1hkmQpAoaii6s2puSUKLovOaz8xoBSvdo9ljW1nU93dg+Vcj5XjH+9NCPBT0o65bJo=
X-Google-Smtp-Source: AGHT+IGqZ8GiKsDXabPDIT7bgFYq/ZQGGvVGH/EZuTGyr2JhwzJhwciN+FMdAj7bErLSx2i0RsqhXtjVHaI7A0Vxzr8=
X-Received: by 2002:a05:651c:23d3:20b0:365:e848:b7a2 with SMTP id
 38308e7fff4ca-3790774b8e9mr2942961fa.33.1761603724165; Mon, 27 Oct 2025
 15:22:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025162858.305236-1-yury.norov@gmail.com> <20251025163305.306787-1-yury.norov@gmail.com>
In-Reply-To: <20251025163305.306787-1-yury.norov@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Oct 2025 23:21:52 +0100
X-Gm-Features: AWmQ_blu3pKz5p6Y6BNpnAz7Uh8TYZgX9iuMKAedvYHIEM1RmEe5NceEsDx_Lp4
Message-ID: <CACRpkdYFqjrOb1nySjvQH7xFFqp7=w_gAz+kxpkT8GRMWU5Xkw@mail.gmail.com>
Subject: Re: [PATCH 08/21] mfd: drop local BITS() macro
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Cc: Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 6:33=E2=80=AFPM Yury Norov (NVIDIA)
<yury.norov@gmail.com> wrote:

> Now that generic BITS() is introduced, drop the local one.
>
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

Nice work Yury!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

