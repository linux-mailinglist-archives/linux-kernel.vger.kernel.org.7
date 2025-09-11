Return-Path: <linux-kernel+bounces-811626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E26AB52BAE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88EE1C25106
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAFD2E2DDE;
	Thu, 11 Sep 2025 08:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggwfqerC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920DC2E06C9;
	Thu, 11 Sep 2025 08:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757579548; cv=none; b=ooYXZxYMKXXjtpYQVpSL6W2VQfnk+WLxRJ+4DUkoATKU3Pwn/+cFpqp1Y4AooR0+ASyyu67BsljL5uOGyedlV7+ZCJP3n7dafY4txxRGua0fUYQiE/aqo7omBFx4Cz1kM62GEMT4pVjoqcKEYG7P+h1TfS4P9dsDAdfx5o0Ey5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757579548; c=relaxed/simple;
	bh=b2VdI0oiFgANIQ5EcSr5TSR36SCbiu1w6XGUxBLPye0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OT8EV7w8tT6wyDRmF8s7ArRN6loCejvo7vMBCtqgdXEfZVCs06hb6tH24WWun2dWiOY8YA1eaVCs1upkGA5gQ5TZ8w7m9kRAhTaFt+flMR9tyvPTwVIb6zSfQU0hVEa/dTZP9NZyw/3Cg7tpT1iB0G8fy/4gh36mjOBeQyaBIf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggwfqerC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC5DC4CEF7;
	Thu, 11 Sep 2025 08:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757579548;
	bh=b2VdI0oiFgANIQ5EcSr5TSR36SCbiu1w6XGUxBLPye0=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=ggwfqerCBJ1oYsXw0auys/TMtk4zaG9x7lznAz0fZd/PEGMVwaFpxx0uC/OsvO39x
	 SiawMvf9VZHE+ShtVyxyx3ND5AFG23QTZC6RqijxgWVv7A/iT4xT3WqwkD+9SQjEFV
	 G16eIdL1mlAZGfESCa+MEFecoFzqyCZppbIosb/lkhblLK68WwNSwX/LhJzLFhlYSQ
	 cnkSQ7m6QIysXsCxnQM0mTpbpbScGyq/sDikZDPvF605zIhC/8WqxkIpOxdRp6pYBm
	 4ArupEjs/BkGtlCSwwFWRUXEfBCrPlMM1jVV/+yVuPaNFSJVB58j8RrqE8DEIo6Wx1
	 2ISRg3UigNqNA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-336b5c44a5bso14399131fa.1;
        Thu, 11 Sep 2025 01:32:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJ4BRTqYxOs41dFTIOJAIRbayX7oAF78wgvQgmzHErlDfMTi/4M85IRkVFML6yDEDZ8cQeUcTlZFmzliPc@vger.kernel.org, AJvYcCWzy6VwmYz0Yye08gmkajIOoyn7/0BCguCr0EWiugPJnM9LJY0Gh+30CxFEI6C5Oe2KUSeQxHKr3wTw@vger.kernel.org, AJvYcCXQQAnAm9sQTUncYMnY/0lNI/rZjmQKByfklGwutdi7SvutNvv2Jk2aIa/7fnb7Q8cYMFiqdezK2m7x@vger.kernel.org
X-Gm-Message-State: AOJu0YyzohSpiCZ5tGjJ5zb2GmUDe3RZ/xbwdWneVCbTAD2nnY8zQUxm
	58WX+lK81dNNpCiIcGPPzPLTyFuVSTSQktbd11055Jt7e76tJvCHjBmJrhEAd6VbjuDu+AuJYvZ
	y9Se3XVBJEPg7dAH7tMGOhmY5g79NhEU=
X-Google-Smtp-Source: AGHT+IEz1m0zWqpjfWD3q5Mpqcxnmo7hPZOolLE36cs3jks02zZUBgKBjW6cLa1Fu1krMrNSe+ZBiHzMUOEzh8/ZDyU=
X-Received: by 2002:a2e:a78a:0:b0:336:e03d:6f2e with SMTP id
 38308e7fff4ca-34e315d71a6mr9066571fa.1.1757579546741; Thu, 11 Sep 2025
 01:32:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830170901.1996227-1-wens@kernel.org> <175751929795.2643345.10671677254490584515.b4-ty@csie.org>
In-Reply-To: <175751929795.2643345.10671677254490584515.b4-ty@csie.org>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 11 Sep 2025 16:32:14 +0800
X-Gmail-Original-Message-ID: <CAGb2v64i8fU-KTE8A0sE+ZL2++c3faUPKyGp51S7_rWV9ydOGQ@mail.gmail.com>
X-Gm-Features: Ac12FXyr2JevaeRf3qm7Q61BcimJDVOxLg7_etSYLuUPLWauqufXTtpAA-OUUag
Message-ID: <CAGb2v64i8fU-KTE8A0sE+ZL2++c3faUPKyGp51S7_rWV9ydOGQ@mail.gmail.com>
Subject: Re: (subset) [PATCH 0/8] arm64: allwinner: a523: Enable MCU PRCM and NPU
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>, linux-sunxi@lists.linux.dev, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 11:48=E2=80=AFPM Chen-Yu Tsai <wens@csie.org> wrote=
:
>
> On Sun, 31 Aug 2025 01:08:53 +0800, Chen-Yu Tsai wrote:
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > Hi folks,
> >
> > This series adds support for the MCU PRCM and the NPU.
> >
> > The MCU PRCM is a Power, Reset & Clock Management block that has some
> > clock and reset controls for the MCU, DSP and some peripherals that the
> > MCU could use.
> >
> > [...]
>
> Applied to sunxi/clk-for-6.18 in local tree, thanks!
>
> [4/8] clk: sunxi-ng: sun55i-a523-ccu: Add missing NPU module clock
>       commit: 1ec8e9ba1f663d6ca5e71ab9f5e919c338075ff0

I forgot this needs a bit of work and a new version sent. Backing this
one out (facepalm).

ChenYu

