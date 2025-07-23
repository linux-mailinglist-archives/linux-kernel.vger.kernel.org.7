Return-Path: <linux-kernel+bounces-742413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05495B0F15C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4223B562985
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2503728B4F8;
	Wed, 23 Jul 2025 11:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yNuPu2ee"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA972DEA89
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753270636; cv=none; b=l8sQ/UKO0n7du3ZZ12JYKjb3LLllAVFFhSfeTPt3HsiA5ypOeEMjlGUJ5MtSOP5gHPrd1jeZxMLi3anlPp8h3i21yFCOVZ1f4vBSJ9MHi82ow8CKzYmc7f52+RiMeCKh674IxHjYhGJWsw1j60UVBJOH2vc7vRes0pld9jfP3hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753270636; c=relaxed/simple;
	bh=iQQAccIuD6nz95tiBxK22UWVg/575olRSffTRrh020I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g2IBbbbvI1RbW8bZvj1Cj3cX+4ZuEW/gQSpg16aoypqShKgohiA/Wk9Nxy2vpz0qkPSenc6KXiIqot+H5N6MHzOuLCj0NBoVAdmjFOU5/S5WtkTC3/TfwZ37mJftZdQqOg99HT475yB6fY0KvjHKOS0Ifq9uO7nipQF9gJnCMOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yNuPu2ee; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70e4043c5b7so55274347b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753270633; x=1753875433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ymp8NEpVvyDseXZYWN8c8ewcIRYFU5ldp7DE0o5dQsU=;
        b=yNuPu2eeXjnWcSaCaIk1p2uY6OmJJoQJyAjT9lYtmhnwOOQz3SLoL568P1sHm2HefO
         j9iI3oJ4v6UCzr/anUzdqP5FG7r7U7S7UuOSCgTnHVRA1GIahyVhnUofmGs3CIh+RVC5
         s3YK5TVsM/XjHp6pr+gYx2MFbJbaX0qlodtJ2RK0hPRuP7YCO3egPIm16xkYeUaEU3pa
         jFyiX3SaP8l4yQ85BuhuLj+jDa9LNoaIRYOjFpt1WdqZt/FMeKqbUhRZReaOmBrtE1MO
         7+gcno5nlqhnH0cc+eAU0sv27zZPjIOkENRoFX1/kgkxJKB990mNhorItJKb3497tmAm
         TSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753270633; x=1753875433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ymp8NEpVvyDseXZYWN8c8ewcIRYFU5ldp7DE0o5dQsU=;
        b=G4yfXPDnO5uULFgR/3jaC7iL90+H/FOXxDQPgheECwKirJLKQXMavngfbSJCYl1AYm
         RA8lcxwYi+6mChaW4CkT5bTRjUeSCKQMeA0Pfiuane+/XzBfdGW1a18+oeukMjSjMPT7
         /l+7Vk03FVRTyqpGokf4Hrgt9HljSCmliLxZ2Knru993pmz3yBEO80JoirMx1yJR8CFt
         zF3ZI+EC8ASYIut3IOjSsQ5ruruRZNPWU359dXRC77kFIaFtrQmPLx6SsUnC6pcyouTy
         CBHXkE5uq9aNnxuWHPbDMKE90Vq9puqybXOYYJnkdy0VKpCOrxlPUk3ZYFKIum/gHLvb
         SsIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKM5t1ejjo0PHEvu8e2CvONBcIqw/KN7cCkelceRPuUXxzsEhqAOQVrlclP/bL3U3Gjbko368ZzhT6BQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUcpF2n4Up9cfT1XOPpWT2LSqY/2J82GJ4M/9IZi2bfhsnaQWP
	WzGoi6T9cjfmK105eLHuXl0kZPtNPFvvAAA5M7VPbP6C6DHEfnaIt3+bW+XfXbOa3Gu5MOVzg89
	X0Fhd1RI8SrGeZpxoy2jaKSzfjkFJRV3M4uoWH2DPKA==
X-Gm-Gg: ASbGnctU89P1WA2U2ahwaTfXtsDZm5GAMUtOvvSLhqitexU4MjqzvZckMX0BfnBIJ6N
	tPL/qMzSumt/zNV9/lqLAqiVqtpV9+dT1vi6MG9zvuKM1b4NRwnQY0T5Nvy559NI3EQMrSmz3+v
	5DWGHAU/gzuPGNJYtxjcU7ry1nMzP9d7RSF2/SNka+8rXlO1Bt8w8NO9OGgery3CQ0SLgsyPi53
	LnyMnY=
X-Google-Smtp-Source: AGHT+IG1u0oo2KG/eqAPkei9S9jpNUr6q6/qerBp5U6HD3spcuvFuQv+r1pMepeUgbYOloTl+BtEStxyrYSqeymqSxI=
X-Received: by 2002:a05:690c:600d:b0:70c:a57c:94a3 with SMTP id
 00721157ae682-719b422713bmr31267587b3.19.1753270632818; Wed, 23 Jul 2025
 04:37:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711094513.17073-1-ot_cathy.xu@mediatek.com>
In-Reply-To: <20250711094513.17073-1-ot_cathy.xu@mediatek.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 23 Jul 2025 13:36:57 +0200
X-Gm-Features: Ac12FXyQQsvM0KPvnjy5H8NAQhVs4FHmng7Wc1VHONXxXWNwFzyha3AMuITkSaw
Message-ID: <CACRpkdbe-0fQY7rF7u14bn4j_f3Qn7+thRzJQZRZBTadG9pjGQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] pinctrl: mediatek: Add pinctrl driver on mt8189
To: Cathy Xu <ot_cathy.xu@mediatek.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sean Wang <sean.wang@kernel.org>, 
	Lei Xue <lei.xue@mediatek.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Yong Mao <yong.mao@mediatek.com>, Wenbin Mei <Wenbin.Mei@mediatek.com>, 
	Axe Yang <Axe.Yang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 11:45=E2=80=AFAM Cathy Xu <ot_cathy.xu@mediatek.com=
> wrote:

> This patch series introduces support for the MT8189 pinctrl driver,
> include the driver implementation, new binding document and pinctrl heade=
r file.

> Cathy Xu (3):

>   dt-bindings: pinctrl: mediatek: Add support for mt8189
(...)
>   pinctrl: mediatek: Add pinctrl driver on mt8189

Applied these patches, thanks for all your hard work and
patience!

>   arm64: dts: mediatek: mt8189: Add pinmux macro header file

Please funnel this through the mediatek SoC tree.

Yours,
Linus Walleij

