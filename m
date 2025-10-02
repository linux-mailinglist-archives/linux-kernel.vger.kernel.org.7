Return-Path: <linux-kernel+bounces-839814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BD5BB27B8
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 06:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3840117AAF2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 04:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B33428505A;
	Thu,  2 Oct 2025 04:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="E7tsWeKe"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC641DE8BB
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 04:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759380251; cv=none; b=ElrKzjfMWbGZt+DKaO5cdus6rh5vA5jVkjCinftgO/Mm1HdnXpVvzBSGbhQnieUeflVQdr48C/ju4Rm6qeKCYvLWzAJKwyQNTQciZW5yxID4x0qymIc+6whTqarUZ6Mzs4/ZwpYldmOn5kZxVyOV0VDGBh8FOJHFsEZi3NQA4+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759380251; c=relaxed/simple;
	bh=TQK0W/dKr0M+UA0oe9PokiNx/Hzpi2k4/+O36NKUOTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vAuUCwFqafeFP7P7u3T4gw5ac9Hen4iijHkF60iPhCaRtB0CXzVqUiq4sxRHPJRzyD9qUBffQ2jojsv0i+HcWhGY/2xPLPbikv660tAXpnNunON79R2/P++vsocvWUzF1UJWFd1GTzKsPpk2jhiF3i1L0tolKe8syZ89IdAUe/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=E7tsWeKe; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62fbc90e6f6so1186431a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 21:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759380247; x=1759985047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l0fNSbqDx3tVEU1b17OFCmGZksGRf1kldhowSTR+Zaw=;
        b=E7tsWeKeKvTEMOJq1I5trCeR3dWjtq3H95UBJhzdoDNgCWt6D+R3AFxIV5B5ctjf8G
         +vK60UyjL123aEJx/zk95qPsytSp8/e/zIN5tlxTQ9dCO5Pv1D8G2tR+jx6T6EZix4PU
         vYDoZsfrUgVImjMCmcQLKsqkMZo8bvNPpIlGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759380247; x=1759985047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l0fNSbqDx3tVEU1b17OFCmGZksGRf1kldhowSTR+Zaw=;
        b=n/CVCje4sAnotgEiSH/z8v98rB5WxXfxGxmV9BEbktyOta+3m+GD9QGywyq8a9Wd7M
         zUWm0y5uhZ6SePCneT/88gtCZA6+wXXOA2wO6t8y2Y4dzb2HzCU7uMVbtDoh/6NhmdF/
         iVNF7AwX7UGLLmU6GzImLbWclu2kKeV8+KFCUtdbRfPR2kBhehbDvbB9t/FGEYwI52pf
         S3Vly5YLed+738eEXZOHrQbHEKteLvX0R7dYrbeDRkpzmtIhhfTu1klZC0+mKo26T0Qn
         GgDaYV93DJtL85r/r3e91CDuWHf9b3/QPMwemKDGsi2HyZ2jmO5mCQpQKNxAH1BJzlm/
         mSHw==
X-Gm-Message-State: AOJu0YwZ1u5jk2Zyq9pHcTOA4zCpapXQoPtzWNI/hVe5jbsdJAQz2wwG
	IiYc5thOf0F4hw7fngQ8B7FTuUlLDerVvGT4lDW33E0EbfsMhLzEO/LdDJBQafegwyVHkbefRl7
	xVetGGVg=
X-Gm-Gg: ASbGncvsJmVZj6jqTpYgy8iMujchH4Z2c0QPYEUQZY+fYicvB9byCwXprodMnT9B/dE
	JrsdX+RXI3JvrX2Elo80Aentu4GEVMIikezikXy8FWthCYPEUpSEEMI8f913Ub8UTFaSobEDCSS
	V4bUh+yRO8M6d0gIp5H0HfUalN3kOi5RcnfSA3j2pTCkweztrvnQ2Q2pyNFwElNpBUy02CdH6ji
	eBs7kefB9+i6sCBixpo1XxtFekUYnWo3jYY8l44xVQllXWejD2ltqljBN4Yf4Xfs0l6nFH4AlIo
	USkm6nuI5GWbJ9c33ZuhxGVL4zSsUp3mkcF+l0v/CywDc2y/u9UmNxLz1I3os+vj2dp686Qz1Ib
	6yHt3MII2VB5oN1+Fip1OVMh67KsZkHsxIlvQfJhWlEFbcb0lqyCGmS+7TMRflpyPz+VVNNyLG4
	3v2naskYvbnJ44DYE4FZ0d
X-Google-Smtp-Source: AGHT+IHWr0ienyoaEloVzvL+owi+D+suLZBECwHYQHO5e5oQYEzkFtHsMJEHu075zedFdoVUrSpOQQ==
X-Received: by 2002:a17:907:9493:b0:b0e:d477:4961 with SMTP id a640c23a62f3a-b46e31e0248mr721440566b.23.1759380247378;
        Wed, 01 Oct 2025 21:44:07 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869c4c34dsm110318266b.80.2025.10.01.21.44.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 21:44:05 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62fb48315ddso1058991a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 21:44:05 -0700 (PDT)
X-Received: by 2002:a17:907:94d3:b0:b41:660:13b8 with SMTP id
 a640c23a62f3a-b46e6033460mr793566766b.31.1759380245436; Wed, 01 Oct 2025
 21:44:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <54b49f7b-9232-44d7-9ae3-ecc1826f17d7@app.fastmail.com> <d482931b-1779-4b49-9fa2-1c101bdf0929@app.fastmail.com>
In-Reply-To: <d482931b-1779-4b49-9fa2-1c101bdf0929@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 1 Oct 2025 21:43:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjsMPACg__N37EL8Sh=z1wkCpj+FQKpoVPXzyiVpm1i_w@mail.gmail.com>
X-Gm-Features: AS18NWC9nGx06gJW3k-2RDQkrnMZn65NQh3fTzpBmyJVcPDayBtYzYYuTR5Us6o
Message-ID: <CAHk-=wjsMPACg__N37EL8Sh=z1wkCpj+FQKpoVPXzyiVpm1i_w@mail.gmail.com>
Subject: Re: [GIT PULL 2/5] soc: dt changes for 6.18
To: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, soc@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Oct 2025 at 15:27, Arnd Bergmann <arnd@arndb.de> wrote:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-dt-6.18

Bah. I've merged this, but this causes build failures on arm64.

I only noticed after already having pushed it out.

> SeonGu Kang (1):
>       arm64: dts: axis: Add ARTPEC-8 Grizzly dts support

Doing a basic allmodconfig build, I get a

  In file included from arch/arm64/boot/dts/exynos/axis/artpec8-grizzly.dts:12
  arch/arm64/boot/dts/exynos/axis/artpec8.dtsi:12:10: fatal error:
dt-bindings/clock/axis,artpec8-clk.h: No such file or directory
     12 | #include <dt-bindings/clock/axis,artpec8-clk.h>
        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

and sure enough, no such file exists. It looks like it was never added
by commit 639f8e36baf1 ("arm64: dts: exynos: axis: Add initial
ARTPEC-8 SoC support")

That commit came in through the Soc tree and in that tree it came in
through the 'samsung-dt64-6.18' branch.

Pls fix.  My arm64 tree builds otherwise, but I have to disable that
whole ARTPEC mess just to even check.

It appears that there's some serious lack of sanity checking in the
arm64 dts land. I _think_ that file ends up coming in through a
different branch, but this damn well should not have been merged AT
ALL in a branch that didn't have all the prerequisites.

Yes, this is annoying.

         Linus

