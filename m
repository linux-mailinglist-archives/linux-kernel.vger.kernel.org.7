Return-Path: <linux-kernel+bounces-850311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 202FEBD2791
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18ABE4E8993
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99D82FE576;
	Mon, 13 Oct 2025 10:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DjsrcUe+"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C702FA0D3
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760350146; cv=none; b=ozAImyPZvBvg8Au9mRabiL7m/A3zL2cK/20GFz1roiYxclTB+ebBMHBOTlzTEz2EndRwp+NFZ6JdXZiugKXe6kX1OkwiNzjwS7FbBN4iJcY3x85jVG3k3StcFn9qZHJXb0Ic/yIO5zO7NbEMBXjGRe5nBI0kUY//+fOXshCRosU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760350146; c=relaxed/simple;
	bh=BziZsaJ29p2j7+qiYkwkwh65tBbEFmB0tndDU4KHhFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ilKiCG1BhcgfRpgFS9sNIsTK++FGSt3DkcV5bROjaIWGDEKVyjXWyvb3v4cgjFHfFmY3F99dVH7Zue61SYHyJHeYZ430S/hxyzNPD1lDy3VBPNVQoqAuVzyiql/AmmVVcQ0t++ABgYYXJab6fVluv2/YrE6ZxNA2GvWnCRMyuw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DjsrcUe+; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-367874aeeacso42803021fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760350142; x=1760954942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdoaiosx8DP44wjr+FKhiex7U2OYK/4Wfm7paNeyJNs=;
        b=DjsrcUe+143ghk582CASiL3M0tTr3lNi/MVxGGQWoDxtntew3wLey6tTHfH5EIVdSk
         Hsw1rjIIbUefcE5YNTwy/XenXF23Usez/ELTaWjBsgvyldnl6mDDu4BXLwCMCJPScdRL
         zn7qG1PG6/Kjs5sgMllzn9+NnsIv0nNdXXJd8eNlPeVxZiGmH/qtNPj7gku7gikaSwyq
         vgdpURq2KyJWnV9TdqWu1aRDIErqP7TkWNms3BHgq7vGD2JBI4OUaJyb9LOh5JDCcQIb
         0NZbjwf6s25DtHvmk7R1eVnBWguBj7P/8L6I0Ifmmcw4FYjAiFkoQLT6P6Go2rq+zRl7
         o77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760350142; x=1760954942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdoaiosx8DP44wjr+FKhiex7U2OYK/4Wfm7paNeyJNs=;
        b=b1s/huUU64GOG2GoZpW506la8EUi5vH+6BoRBkOlQgKkmGsNt5nPzbh5RueFJP7SBs
         nRsXu1H5x5vxloeIxwVII1EXg3io8bfADfPcw2vqAq6lVotlt+QzZpEu4LesNfVGpI+n
         94WMQS/lKwbmJLIBf8dxyvevy9CQkjo+kLQf/EKkVJ3lHx4IDYLkS1tOX3xzz2VO0Xb5
         U+Sgkc0bKjV1cbGxribBLZy0Nj1pBSbAV1w63m9f/tZmy5QFf07i9p9ud+0V0QOPHuYp
         pH9q4sstp/a0sTJla6mAnaLgxWJ7Gqqu4ValJJdtw30igeN3p6VeUK4eFLpaRag+QKs0
         szuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWawTyjg6E3yIEdVxd8wDg7v34IqayWym9rnZnxzwThxvLIJ/Vu1kDEUqtQtqxfRuVR2NsLFwJbjWiu08c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNG8DENYTv7LPK9naguUjxxHmDNSDIHRuFKv095gJbpeDDzo94
	/bV1TFz+v9RkkByTDgeEXz6OwXMxRD4K/Wlb9zbGF2+h/VqwI5book/mFDJZqcwUo5Pkhmh3pDW
	vVPsBBu2IGIP+V3deJu06mORHUna4Jbi8drmh6YSeoA==
X-Gm-Gg: ASbGnctRtJZD1I3INMo8lfaDQpnapgx4TCtBi16yYlGMzXXtGcJi3Qs95Q4pErSji+H
	pkjimoW3F0/dwtZIuZbV6GkM7jjLyBCQEB5A+wGBOzcbhqcfZ0ZSuqGLllPW6DagVtfQlVeNTBw
	9NNTxXkdysC28prfJeKyn5SIK1y6nlh5aQ1PPBqbUeulgtGQriin1itWryKbFEBlHVKxlTP25Gj
	yl+M0QrRA26CBqsGsU45dmMMvgEpWLyoGhVBqMC
X-Google-Smtp-Source: AGHT+IGw5FBPHMZY98OuHAGpmxfzqUBjohFZCP4Y+3ye7G2Bxk75SIlnTIXF/kp1jPOVfGXssHiDF3M9kkzcVBZy+WM=
X-Received: by 2002:a05:651c:4385:20b0:376:41f5:a709 with SMTP id
 38308e7fff4ca-37641f5d53dmr17660371fa.48.1760350141633; Mon, 13 Oct 2025
 03:09:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915-mt6878-pinctrl-support-v3-0-593cc007d4cf@mentallysanemainliners.org>
In-Reply-To: <20250915-mt6878-pinctrl-support-v3-0-593cc007d4cf@mentallysanemainliners.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 Oct 2025 12:08:49 +0200
X-Gm-Features: AS18NWBxwqEgY4X_LszokVA-g-bopo-7ZyTrk7rGuaWxNocfJ07lm54aMEbkhdM
Message-ID: <CACRpkdbvTfJOBKOaEjje9dhnnjMXr1NqWpVBspe4Y8_WphaPSQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Add support for mt6878 pinctrl
To: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sean Wang <sean.wang@kernel.org>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Igor,

thanks for your patches!

On Mon, Sep 15, 2025 at 2:46=E2=80=AFPM Igor Belwon
<igor.belwon@mentallysanemainliners.org> wrote:

> Igor Belwon (4):
>       dt-bindings: pinctrl: mediatek: Document MT6878 pin controller bind=
ings
>       pinctrl: mediatek: Add debounce times for MT6878
>       pinctrl: mediatek: Add support for MT6878 pinctrl

These three applied to the pin control tree!

>       arm64: dts: mediatek: Add MT6878 pinmux macro header file

Please funnel this patch through the SoC tree.
Acked-by: Linus Walleij <linus.walleij@linaro.org>
FWIW.

Yours,
Linus Walleij

