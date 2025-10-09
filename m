Return-Path: <linux-kernel+bounces-847447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 161D8BCADB9
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 22:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E4584F3F12
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 20:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9517126E146;
	Thu,  9 Oct 2025 20:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SggzRCqc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB392750F3;
	Thu,  9 Oct 2025 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760043389; cv=none; b=PnRnLd0NuJCcESiZ4hLoIa3Nv5CO0yK5hgsupgp6kiaUtokovZzMPh0U8wH1O0Md5QJlfpF/3AbSAfGgHfSxyudqwT+Ag9Rs4+FI1YrYKoxRtN0AbvIrdmoREyATiacG6WnpOaX2HCITauwZf8ElU79XjUPkSHvzRGX3ERiWtPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760043389; c=relaxed/simple;
	bh=cBnUBsYPo57fkWDkcBNUjTCl/fKCpH7l/2YNldTFRCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B24iuIDWTTHARZb5jg772vjBrMnd6B+SFbkXPf1BEzMexNWJ8XGgevF00MW4nwzUrMV8KEA4A/xX2F68PqztDXawtZqNy3vp6+WSjGTqWV8kCJUdhzuYCFy85OOEuWbWmfF0FdUjXzt+iuL2DD8sxeQkwBJJjRgSLWFcTHpAoik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SggzRCqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85CEC4CEF8;
	Thu,  9 Oct 2025 20:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760043388;
	bh=cBnUBsYPo57fkWDkcBNUjTCl/fKCpH7l/2YNldTFRCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SggzRCqcE8Viy1oBFGH0mgYD2113AnGwJ6vmVXQ3ZpUZqex0nrE3J/Oss91US/1wM
	 9uT4i/BVyo78AYBE25cg/yf6LkO0Nfbs3E6aI1PlI+jOiy9rQCdohNYnc4n3Kwni6v
	 bZ6CVlsBx3NOFi4r2xOoOhcJnKiWsC1cKLO5o2D9rESczOEMJGNVhHqtbHu5AE9yPx
	 FLvprzNbOGCOLKDjOmNYR0mu05Ln53SmDI3ZLdKxbk1ZUji2QJazznY26eEbGe8QGP
	 gXCvwYiZKQehRdtIjAeHhSODFgkM9ZFANMDfB53kvHAOMxcvlRVtBSMF0Hqua2CI1G
	 FLXg5I6pcj8xw==
Date: Thu, 9 Oct 2025 15:56:27 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Drew Fustini <fustini@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Michael Neuling <mikey@neuling.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Joel Stanley <jms@oss.tenstorrent.com>,
	Michael Ellerman <mpe@kernel.org>,
	Drew Fustini <dfustini@oss.tenstorrent.com>,
	Andy Gross <agross@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-riscv@lists.infradead.org, Joel Stanley <joel@jms.id.au>,
	Anirudh Srinivasan <asrinivasan@tenstorrent.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v2 4/8] dt-bindings: timers: Add Tenstorrent Blackhole
 compatible
Message-ID: <176004338686.3327568.16422814049408420829.robh@kernel.org>
References: <20251006-tt-bh-dts-v2-0-ed90dc4b3e22@oss.tenstorrent.com>
 <20251006-tt-bh-dts-v2-4-ed90dc4b3e22@oss.tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006-tt-bh-dts-v2-4-ed90dc4b3e22@oss.tenstorrent.com>


On Mon, 06 Oct 2025 14:21:44 -0700, Drew Fustini wrote:
> From: Drew Fustini <dfustini@oss.tenstorrent.com>
> 
> Document clint compatible for the Tenstorrent Blackhole SoC.
> 
> Signed-off-by: Drew Fustini <dfustini@oss.tenstorrent.com>
> ---
>  Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


