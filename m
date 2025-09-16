Return-Path: <linux-kernel+bounces-819377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955B7B59FA9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3178E2A5F75
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A9A2F656E;
	Tue, 16 Sep 2025 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sh5JdfZf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480CE32D5D3;
	Tue, 16 Sep 2025 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758044605; cv=none; b=Dm1k5p/qfxh/sA/iJW6KgWeMCHEmg3I580BlTdcZA45nR8sr2Enjifhk6vAF2sT3cB0WY/ow8GeDePrVYAWU/6IwAJHc+MQzbb/hO25jKpcqUNqC+gBEPWoC2k+EPyizyCTfU+T3h1p0TlHyqFpX+5pKGexoranzm80XGQkiolY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758044605; c=relaxed/simple;
	bh=o3gS1VZdjRA3/5Nl9Domri53vUtP+1xplx+0LVfixOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYg1TEm8MaPYtkwIeuhNoaKS7dAOJuW7A4yskHaYxQtp03DgztQKl8If7/IXiCKxugd4O6NUeLpXGRa6Lu8acQvMjxEOmhT5j44zN56OWrVhwFMxEonLO3NrtWgpWlGcFOeHc+tubZiY80Vkr2RUhwUX1535vyhYos43Ra1uYoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sh5JdfZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F753C4CEEB;
	Tue, 16 Sep 2025 17:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758044604;
	bh=o3gS1VZdjRA3/5Nl9Domri53vUtP+1xplx+0LVfixOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sh5JdfZf4uohwD4e74BHkhc0AsnbOwopGV9a/l8MPq55LZrNd43ccjyFhV5brrg/M
	 zfOtpcpwRX/8J6GuVxdEZXt+XWyNycR5bstN1O0OGEEEYQyAdAenRuy8loIXwwngPB
	 dE4oX+Rv1Qkh6egD67P8Q7oCi2x5OzRXStr4uIbw9SbvEyuP8EBYCZhCIkUPWP5I3q
	 GWYRovpjAXy37PavLxaIuh/wandY995VWmVXtl3fFqPbHD9yndHETPb0N+SBYuCvGf
	 yEiePaMI/X6TdKq5ZpQMBlRdwAWH9KuUMSvM+QKAFibAH5blKvU6haNhum+K0JGQnM
	 /JDtSl/6ve/+w==
Date: Tue, 16 Sep 2025 10:43:23 -0700
From: Drew Fustini <fustini@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <anup@brainfault.org>, Arnd Bergmann <arnd@arndb.de>,
	Joel Stanley <jms@tenstorrent.com>, Joel Stanley <joel@jms.id.au>,
	Michael Neuling <mikey@neuling.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@kernel.org>, Andy Gross <agross@kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Conor Dooley <conor@kernel.org>,
	Drew Fustini <dfustini@tenstorrent.com>
Subject: Re: [PATCH 4/7] dt-bindings: timers: Add Tenstorrent Blackhole
 compatible
Message-ID: <aMmhu9ZfNnW+Zh8a@x1>
References: <20250913-tt-bh-dts-v1-0-ddb0d6860fe5@tenstorrent.com>
 <20250913-tt-bh-dts-v1-4-ddb0d6860fe5@tenstorrent.com>
 <20250916134400.GA3654122-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916134400.GA3654122-robh@kernel.org>

On Tue, Sep 16, 2025 at 08:44:00AM -0500, Rob Herring wrote:
> On Sat, Sep 13, 2025 at 02:31:03PM -0700, Drew Fustini wrote:
> > From: Drew Fustini <dfustini@tenstorrent.com>
> > 
> > Document clint compatible for the Tenstorrent Blackhole A0 SoC.
> > 
> > Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> > ---
> >  Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > index d85a1a088b35dabc0aa202475b926302705c4cf1..198146c59de0c95a2ffa052c8d4d7aa3f91f8e92 100644
> > --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > @@ -36,6 +36,7 @@ properties:
> >                - starfive,jh7100-clint   # StarFive JH7100
> >                - starfive,jh7110-clint   # StarFive JH7110
> >                - starfive,jh8100-clint   # StarFive JH8100
> > +              - tenstorrent,blackhole-a0-clint # Tenstorrent Blackhole
> 
> We usually don't put Si versions (A0) in compatible strings unless later 
> versions changed in incompatible ways. Perhaps if you already knew that 
> B0 was different, then it would be appropriate. Or am I misunderstanding 
> what A0 means?
> 
> Rob

Okay, thanks for explaining. A0 is the silicon revision, and it is
currently the only version that exists. I was just trying to be as
specific as possible. I'm okay with dropping '-a0'.

Should I change the plic compatible to 'tenstorrent,blackhole-plic' too?

I see you gave a Rb for riscv/tenstorrent.yaml but that does have
'tenstorrent,blackhole-a0-card' and 'tenstorrent,blackhole-a0'. Should I
drop '-a0' from those too or leave as-is?

Thanks,
Drew

