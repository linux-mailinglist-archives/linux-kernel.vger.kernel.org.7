Return-Path: <linux-kernel+bounces-764065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F325B21DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B130688348
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B886A232395;
	Tue, 12 Aug 2025 05:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="codgUbls"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238BD1A5BB1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754977567; cv=none; b=glU6m08V3UuGfS0e6yxX7gbMmSlHvfqfcDtyLIql/uv1ZDTRmLDdYoqAIVQmTLsJ/RAVOxQZBtvptNFgl8s00HK9UWXEuedubjJ5Bp417pRQJpK65N4mxvgXEbK/ejU4+FyrayW8ZAEKtKLBGkYTniXUCjYbWO/bl8RtMmTLagA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754977567; c=relaxed/simple;
	bh=FMFubZzw5IsK4kYuUJoxjkzx4VzJv3nuhFsuIBFsRLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q12KlEYQ3sHnTk3S+TX/CoS2SYF8+aCbTnePnowiYjCg2U4xGMYKXqj7PLOW/62fPAwdl0/fUgN3l4zvGEsO5xdnU7saD/BCiBBKrdvPGKZK+ODbjXItU6DwARbWbtHlZPh+ju/sDRpDaa0gK/yuixffSji721mdLsMoHGbwv5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=codgUbls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEA5C4CEF0;
	Tue, 12 Aug 2025 05:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754977566;
	bh=FMFubZzw5IsK4kYuUJoxjkzx4VzJv3nuhFsuIBFsRLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=codgUbls4Jz8D1XxnqnT/EyunZJUa9myWZ6KM6clwyGUJ6WEPqJZaW8dW1l6LmCR6
	 HV764gnLlxlkLNykXx4JDVpET2TYITdaH6XLQSdaxoN/nW1/dBEDf8XR19kQ2cukyZ
	 ekOySjByBeQxpGA8jVU8pZ6CH/0uA35Z18MUh1rPKSolwbKqfkaMH41MxfC/sPnvOS
	 BiJBfrVSHpa8b1UFS7xtaTGxczxvZuio7abrv2I8I/sLZdocmAgK1vBX09PB8nT6ZA
	 JCQT9BhD4zK5vNhtkK5VRbofDm9VltutqHmoe4zOsUMZ79btNRR9OV42jsnmEXM6Ce
	 C8dhIXrTcWyJw==
Date: Mon, 11 Aug 2025 22:46:05 -0700
From: Drew Fustini <fustini@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Darius Rad <darius@bluespec.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Samuel Holland <samuel.holland@sifive.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Drew Fustini <dfustini@tenstorrent.com>
Subject: Re: [PATCH v2] riscv: Add sysctl to control discard of vstate during
 syscall
Message-ID: <aJrVHenvkMTRYcsS@x1>
References: <20250806-riscv_v_vstate_discard-v2-1-6bfd61b2c23b@kernel.org>
 <aJXvWuPKIc2lCSX3@localhost.localdomain>
 <e4d21516-23b5-404b-a7da-cf6ebfd02dbc@iscas.ac.cn>
 <aJb+wifbIAsit+me@x1>
 <5a96d08e-0714-4925-a9c4-ea66549623d1@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a96d08e-0714-4925-a9c4-ea66549623d1@iscas.ac.cn>

On Sun, Aug 10, 2025 at 05:52:54PM +0800, Vivian Wang wrote:
> >   Discarding vector state on syscall entry can help identify userpace
> >   programs that are mistakenly relying on vector state being preserved
> >   across syscalls. This can be useful for debugging and test suites.
> >   However, this behavior can negatively impact performance on some
> >   RISC-V implementations.
> >
> >   Say Y here if you want mandatory clobbering of vector state before
> >   entering all syscalls. If you select N, then userspace can still
> >   eanble it via the abi.riscv_v_vstate_discard sysctl knob.
> 
> Typo: eanble -> enable
> 
> Also, I think it kinda makes the false impression that the sysctl knob
> is only available with this set to N? I think this should be structured
> to say something like this being the default value, and also say that
> userspace can override this behavior system-wide via the sysctl knob.

Thanks, that is a good point that I should clarify that the user can
still override via the sysctl knob regardless of whether choosing Y or N
for this Kconfig option.

-Drew

