Return-Path: <linux-kernel+bounces-865038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B544BFC12B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7778E564AB8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6118C34AAEA;
	Wed, 22 Oct 2025 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nmqDb2Hk"
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB47434A799
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137922; cv=none; b=Bf0wUblD8y8j7MtVbcRNIcwfNQmxo5el2ZQpkrMbco6JlqFUBvbbi37NM91dHU0humI7O9T/jleDOhP3CDHv2PKdgvyXRcPn2Y5uYAmFHGSKrwxsvabZcAoy6hYe1b1S6PXaHn0zknhBwNz7xduKxe5zhh+o3rYf+Ev0JITVG5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137922; c=relaxed/simple;
	bh=jSSjnCM4ER8aKOW0t6/ZA+XtyoMrKYkP+HhxvOTGTRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0bg3q9Vlwgc1+AUDnvn1PfhIP2LPffiHpJb2TOrpxzKYGkaQJ5I4/qHziZd5sI+Hhd3IEdpGDchHAelE/STqfZXUN37+0BFCoxZ1x5ltsMz7O3+Z+Ee2xl54pVCxQCpIHAztuJlnzt7mO6nUdXPSOX65K/p664eZYmpYXL3WWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nmqDb2Hk; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-63d97bcb898so1609033d50.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761137919; x=1761742719; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LqfpXhH8oikGFpnElT3hOnVI48sa1H9J9/n1+8f904w=;
        b=nmqDb2HkjgVL53xtQOZCewrjRcYrK4sr5mhoqEx4Z1ziGkwRAmC2mHotDzhgOQf1Pu
         aj1IcllYgahfMp/jUyHoAI7OwiDKjLxlaS6dMgmDRlNdNTLBmBxDzF2GjiFShrJaYM3N
         BZCONm1ijU2AYhhOez0Q89RT6RRyMUPO/c5r5R4XhB4ApufYIOtOBqCQFDhVwMf3ioD9
         fSDpJiKroLniC5hkho0XLRJc212KheA8vmiCIF9R4yZTcrfHY44GXGBzbuMQf5ZGGHgi
         2afCKanK2fDPvEet1IX+CCSgVj13CXSVnqUeFezeptPiWTtvnAHnhOoP7tRmwFI8chCv
         nysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761137919; x=1761742719;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LqfpXhH8oikGFpnElT3hOnVI48sa1H9J9/n1+8f904w=;
        b=XdeH5xZ6pw2Ukeus6PzRqr1YiY5ZLRWyCBVZPSUthSYL/6OEAB6PJK6fUIcuQJuhen
         3i98N64kxUCXOca2DkatZHDBsUCQZcB9V1bKn2KXC8me50Yh17Er6DFuYA9322kcrNY7
         jY771ecNq0d42Ysu05yqstCpWcMtNtK+sgo+wA62wjFce16SxbamxDFFOtjzCWqabgXi
         BBrgXCfVK3AVZt43npl/DWbQqplZBrbJN6pbXN80JPsPQquiEymy0Zhgf3Sv8Lw/FrNr
         HIRdAvmwSEGDj0tABrw6On6CFgVABzr/t8djJ1Zs3+cba5Rwt3qWSm25tz4qzyyJEt/V
         m7KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI3qms7U6QCaocQsQCCUFBIDKjzyDHviOfoZdvXlDYNKGVaRtccvjah/adVpdAkiNNOJ8UOcyOjuu5c3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAiHOZjwcn7DAi3n0q/IzEndAwHT29wduK7tYyY+Te1PDAJsvD
	fqGt4OGOudIwoswj1jyvUBFyGAw3wOwLxQuaavVpKnnb3HeauAFLE1YTSueOsq/UH53mUHfEcIs
	L0FLYmavt/06rTrQNmdlWXJ7a8je6ff+NM4K/A9Wi/g==
X-Gm-Gg: ASbGncsXGtukB4atphdE+Lk2yZYTdq+F3r/X7NTc8oBaqmP+/JUnigBYHdaHi4Q1SuC
	twHr+qiZWmNwZ7aJgeSd3iP8tPH1vGEvt1HMU9ahrWZBP9KTq7O0Wpwlz2LyaTcCmn/Cj4InaZS
	/H4WnY2L/P/jypHZSIC4nnNhZ7pQ+wMupmn3HFaqsuRrHS2oh/4EzYPvGqeCc1rRrH4dLkGg1w7
	XdcogCUg08AaIr0sAeUZcddSzUSgPLoW8QvRIszRsbWrpCHaZxV6oijycZwhXWTDPsYSYCs+yXt
	9JgN5Hc=
X-Google-Smtp-Source: AGHT+IEjyOT6ZnWjtbuwKFmQbeLCXJvC9+ovHItNxLtceyMzt5RJXygROmaPW1mTzx718f9fX9ymVtGCF2aAo4JR26M=
X-Received: by 2002:a53:da0d:0:b0:63c:f5a6:f2d0 with SMTP id
 956f58d0204a3-63f2833575dmr2112548d50.31.1761137919613; Wed, 22 Oct 2025
 05:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017093834.331998-1-finley.xiao@rock-chips.com>
In-Reply-To: <20251017093834.331998-1-finley.xiao@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 22 Oct 2025 14:58:03 +0200
X-Gm-Features: AS18NWCPlgQ2C3y-wODiJDQlKOeRdWjBY3paMVLSMS-IfDxCiXVh7nLiSG0YRnM
Message-ID: <CAPDyKFrDAmfN16fQdf5en-Du=sG5U61NK7vRhd_CtiSz19rU_A@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Add power-controller support for RV1126B
To: Finley Xiao <finley.xiao@rock-chips.com>
Cc: heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, zhangqing@rock-chips.com, 
	sugar.zhang@rock-chips.com, huangtao@rock-chips.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Oct 2025 at 11:38, Finley Xiao <finley.xiao@rock-chips.com> wrote:
>
> Add support for the power domain controller on the RV1126B SoC.
>
> Finley Xiao (2):
>   dt-bindings: power: rockchip: Add support for RV1126B
>   pmdomain: rockchip: Add support for RV1126B
>
>  .../power/rockchip,power-controller.yaml      |  2 +
>  drivers/pmdomain/rockchip/pm-domains.c        | 41 +++++++++++++++++++
>  .../power/rockchip,rv1126b-power-controller.h | 17 ++++++++
>  3 files changed, 60 insertions(+)
>  create mode 100644 include/dt-bindings/power/rockchip,rv1126b-power-controller.h
>
> --
> 2.43.0
>

The series applied for next, thanks!

Kind regards
Uffe

