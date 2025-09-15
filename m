Return-Path: <linux-kernel+bounces-817016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF65B57C72
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F46166E7C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D74530EF6C;
	Mon, 15 Sep 2025 13:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HB20rFO7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA52A2FE597
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941894; cv=none; b=jFoHDEWiJSG8oOIDo4lR4c84TelLTRyeU/S6mm7FQtETfJUoAjIvnkfum9AArCEtM+kvC8ufESqf4ifPMQjXAHinqi24Xub03ngYbAoIz/gJOXNakjiXkfLxI0fOhJVaSGma2jtoLFrQlkeC9WEgf36P5+43qzGQAlkKVUkhJR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941894; c=relaxed/simple;
	bh=6TvXG+VkHFlrKrY1aigBwFXeBnhJbLQwBFHnHT3TI1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RxwsvvrU31Wylc5xk4FzhGbJDgl5B5O4GojQTtU3IRtnSkarkQYLMEUDPuV3OEdVfHIafqYQUZCCmo4wvmDxaNjQSn2e3/nNa5fK47aKhLdK9iD4hpUOKTpqu1jTsK5/4uKDchNgK0O4DpCJJweUs0uxe2PTxYGS94bnmjc8T+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HB20rFO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0B5C4CEF7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757941894;
	bh=6TvXG+VkHFlrKrY1aigBwFXeBnhJbLQwBFHnHT3TI1U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HB20rFO7vM7DFelqeDNx5jYRc5ACpsTLVey6S+aR4ISl3L/aV/mBkPOx5ZhciGlDs
	 Bvo+yWlrxMC0W3VJPV0fW5kRKePJmCKG4dvRzRS+GM4EHvTIPYsJgYTMAyycYkkrNN
	 4BMr4qqpy6WVk8Af3KObM8JHMN3wbtI/7ztSc4Fyp2t/9N7Ao+iUL0T/ECZ+H0aRKr
	 SihwJNxhpvb6rwDe8XBV+JZVICTZO/oy/nul+hwXtM2NiQZ2/DspqwhA/95JekY3Uz
	 9mQrc+D9SRxMh9I3d04LEBhN+qjuCJ64K3YwH2kpcYH1Lo1A2by2VXoFqpte0Ilj8P
	 4G+O5l7h+aMkQ==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62f1987d49fso3009512a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:11:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9vQkvoszxsbtcnemi3GDGM+9YDg39nGc6pW4Vw5hY/rtTT+7D12UPZ/q2rOlc1XBEpPOBSBy1LkAtt+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOSn+Vd51RFM7oKOfYhViYA6tgh56b7W+wqPE3Jk7B+zq6dign
	SoBK1Osvv4T2twXShZW/Yyo2YWc3TEcmMGT/DtcqKknFtSJwawiOdeNZ0w4icRXC8wiv5mxizZF
	AmIJuZ5g0wSv44TMwfCTZnIt9sw0Zdw==
X-Google-Smtp-Source: AGHT+IHbTvPNLInOtW4HN/h5+fp04ki+WFQjYW3WLecUiIdLce17SmTc98UVjCuJ7zaa8MZv3KzUwrv+Zyf/hjwsiew=
X-Received: by 2002:a05:6402:42d4:b0:627:8d60:ca57 with SMTP id
 4fb4d7f45d1cf-62ed861ab2amr11761043a12.33.1757941892960; Mon, 15 Sep 2025
 06:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805232502.2827725-1-robh@kernel.org> <87wm63on6e.fsf@BLaptop.bootlin.com>
In-Reply-To: <87wm63on6e.fsf@BLaptop.bootlin.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 15 Sep 2025 08:11:20 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+A204rqNzqB=0tw-HHQPBdSomECoRfrwGEGOGioBYCgg@mail.gmail.com>
X-Gm-Features: AS18NWC8W2tfzXZWBP7WhUF55A16dIRiLZt7d8ihEkwdhuj29x4PSq0cBjI1X90
Message-ID: <CAL_Jsq+A204rqNzqB=0tw-HHQPBdSomECoRfrwGEGOGioBYCgg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: arm: marvell: Convert marvell,armada-370-xp
 boards to DT schema
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 7:44=E2=80=AFAM Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:
>
> "Rob Herring (Arm)" <robh@kernel.org> writes:
>
> > Convert Marvell Armada 370/XP based boards to DT schema format.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
>
>
> Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>

This (and the other conversions) should be applied to the Marvell tree.

Rob

