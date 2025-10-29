Return-Path: <linux-kernel+bounces-876325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3299C1B78D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A2A565A24
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8DE265623;
	Wed, 29 Oct 2025 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P2g8vCBS"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E58625B687
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747316; cv=none; b=PY9iFblTECFRuCigEn1NvQCE9kRoONzu07aWR0tC4yPo3FT523tbjslKDkiMIqGpm6H80ZLiQYmW4ncUmArju4WxJ+kwTPysRzL4KTCj6ayPiW6uUi+QsA7H0OJ6DoYPmdcpyGeNZWIugmGrrEXYOLlwSFAZjccoedaV2X+P+AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747316; c=relaxed/simple;
	bh=JnGN5D18R/9fVPC4aATiOOBzgu+WBuLqDytyaFyTYec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqAqgc/vpCortbcwwEVANzlazREfcbL+2eWSVvf1ReFdSJlbWCi/d3tQYMtwvd0SEFyEN3QT1CcKLeI29/SHATcjlJKMB2KMLAyUQy1bz4wHW6kM2TgCCTeFsABqLImvBLLbZLnxEnwdCU8Ft61kfwKlrf9Pt/6A3qxQca6uaVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P2g8vCBS; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-591c98ebe90so7276217e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761747312; x=1762352112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnGN5D18R/9fVPC4aATiOOBzgu+WBuLqDytyaFyTYec=;
        b=P2g8vCBSKm9qQSx8QMCRipO+Xunm+j0kPjkxsG64Pa2AOUwbg8kkHaKAGR0ysqs4ZE
         7nCpNOO4ghqFN+9+aZtZvEolZbEwDWhY72CBEXuKZuzIe0kcLpkrDGivAWWaJt/cjixC
         ChVGaU/exsl35QMJWjWHqe8BgtmKJTK0NMiFpH2nW91PFrzqGRYdkjTWIq65qchYOGQD
         hVihrAC+CEAHE/utWhWqNk6lzGVoNW/3hlKFs1oUxQAU+mAzk8o8epDhvTu4zMsPmzNA
         qrPd4IcYiE8TK7qOQa6pyi5mP84Nx8R5M3toFhZ9450iSivFZQrPlt6lnKZd98d8Zpbo
         DFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761747312; x=1762352112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JnGN5D18R/9fVPC4aATiOOBzgu+WBuLqDytyaFyTYec=;
        b=Be0ZlGJ7Oo2wROoH8NgS/wUQT9wMS3TDeBIvAJdKQbqlIw9jz9afA/qUuLcHsczgGC
         GQjAlVRs4aWBUFHVQ/XZjg2Sd27wYOf8/W2EK06wwM5I/GbeNqeGMaKGfT0owU5G1fK+
         LWN1xcettxjUcK3So1/lw948NbsMCbX8t9qjMRXlhMnXO7FxAFvCf2koYcZh+uZaDO4y
         fu0tHkUQx0ZTMMwBhZnkykU1mJvvUuhvTRjBWWqrd1h9+ysQYC1A+2bve7eGWopLoDzb
         vUSEasm+KuO8JhlsJsOG+onM7nt8bHioJZzH2ceaLrFsHtEQwoP3Ih1OkZZtVIsBn3cp
         YKtg==
X-Forwarded-Encrypted: i=1; AJvYcCWhyyYTgJY2CIkISkgRg5+z8oCK+1LXEvmRkij7TqlTyzn4egaJPoJBwIimlSxLcaiVNkMzD5naZbsprss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyudzFEnrZ/7gM10VSZffwWTfr9btbaa9g6rqU59NiRksB8oFJn
	gBM6+kON5CUs9iCKV2gdQT1ofrCrOHnVXX6PIBk83YIJxpOkLKDIwz/cu3MWDVM27pzXf5Hnrfk
	dBfETtRnMcOEDljqFGtCix2p+EW3ORkNDNi0x5XpbWQ2QcXV1Whxj
X-Gm-Gg: ASbGncs1rV5Kq7JhpFD64wyQU+1XNujFRbRISLwrJpgFQ+hHD5P4dAyzxX7AxQpaslJ
	fu/l26xedur+jQOXdCuOnHZQfEO8xfKPY4Lk0jaG+z341o7JD6scFBuDG1F+4W8WGFn011m1Fkh
	tp2EKpahTOENJ/SdyDCC95BTINOdW77h8Ycsvyr1Gv5bmVQ7r9EU/LXCue797/tM0frH/HVqQkd
	hFyF24QyWuZ9gRDpJ9b+iLNoi0F+aGegcME0Htf7LguBSSX7PE7FBJ8ELxPEWsleIXnIWwZKWay
	PVhzVw==
X-Google-Smtp-Source: AGHT+IFHbNWWVxA87snhrR4IbvJu5TGV5/GUfJgAIFivqMT+b8PLCXPg6xBSIPiXG/dy8RZjJuiqgOtncZYWj0XE3mk=
X-Received: by 2002:a05:6512:4027:b0:579:fbe5:447b with SMTP id
 2adb3069b0e04-59412877a64mr997730e87.25.1761747312519; Wed, 29 Oct 2025
 07:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027123601.77216-1-herve.codina@bootlin.com>
In-Reply-To: <20251027123601.77216-1-herve.codina@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 Oct 2025 15:14:59 +0100
X-Gm-Features: AWmQ_bnA7g7AcaUJgpDisQ6qYyEHOuq4LuFcqR2x-CFiQFCGVVARLA-FUYgDIHk
Message-ID: <CACRpkdZMj84AJu1ZgDLin1Ef1JaBRHsevB2auTFvn4h3M66yGw@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] gpio: renesas: Add support for GPIO and related
 interrupts in RZ/N1 SoC
To: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Hoan Tran <hoan@os.amperecomputing.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Saravana Kannan <saravanak@google.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Phil Edworthy <phil.edworthy@renesas.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Pascal Eberhard <pascal.eberhard@se.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 1:36=E2=80=AFPM Herve Codina (Schneider Electric)
<herve.codina@bootlin.com> wrote:

> This series adds support for GPIO and GPIO IRQ mux available in the
> RZ/N1 SoCs.

I think I sent some review tag at some point?

Anyways, here is another one:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

