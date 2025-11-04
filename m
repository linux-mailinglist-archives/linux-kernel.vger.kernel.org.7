Return-Path: <linux-kernel+bounces-884856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C04D9C31556
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6879C4ED8B1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0910C32ABFE;
	Tue,  4 Nov 2025 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIjTg2vr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6345332ABC1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264548; cv=none; b=W3QJKfQ5ylqbUjK4t09/BgoBjwyVdTIm5jv/80C7Ma7mO3VtvSBHnYoGTbWOEQiVQ3PYTuhkzZSiRZ3Cu7G01OKTpDhAsptm08KRzz7Ia6OI5+suC2U24QGUC7p3GpIVjYH6TUOKAnJn8i77QMJ+ZyLEcNRD2doDe8QXAXlDfWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264548; c=relaxed/simple;
	bh=G3VU4ztVKcvkUx9snPYfkRyw4Hbg8NsZbBTz7yXbbMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2BVSq4gUPcYmlcUNqtE5h7q3uKoIuGfFkkl7+7q1LWow5pz4esKr6WsFNiDL+FINYbuY2qI8FMs0BaLUuo9gdMe/mSP4Pm1h6j1qT+RQCJS9NScS1EOvAcvx3q2pIqnBAyeNRaOnAvoxwmLn7wfK2FjI9qU1AOFNtRSWAx1clE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIjTg2vr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28B8C116B1;
	Tue,  4 Nov 2025 13:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762264547;
	bh=G3VU4ztVKcvkUx9snPYfkRyw4Hbg8NsZbBTz7yXbbMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SIjTg2vr88Jluwg0BWr2AaAiabXujExUwccYZrvT7V8wl+0qnk/o8BJKcC4D1Ydpn
	 44pgtnQ+qZwCHvvz8TAjr9NIlUcmMJH4mrDbOJ9VYf4r1HUzPbwae7vjZVYYspTOnQ
	 OpaUj5xfSCuvtvprohitxKhtSaHgWmD2XB2mJzSIMBb6Kns59YMiWwg0Q/5C4vp5mE
	 GZfoWsIP/jALMr5IUlhtvFonNrc+URSogepMSpobYHM7sqEN7ERPybfoHrHnN4s0FD
	 irzqqWSvZ+brRf6Z32MZoqo8W1tQ2mKO93nIZhnOn706dRw+jViW4Lewnj+SdW8xV+
	 grJqw4S5Gh1pA==
Date: Tue, 4 Nov 2025 13:55:42 +0000
From: Will Deacon <will@kernel.org>
To: mrigendrachaubey <mrigendra.chaubey@gmail.com>
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Fix typos and spelling errors in comments
Message-ID: <aQoF3pu8CjO3tAl6@willie-the-truck>
References: <20251011144004.14946-1-mrigendra.chaubey@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251011144004.14946-1-mrigendra.chaubey@gmail.com>

On Sat, Oct 11, 2025 at 08:10:04PM +0530, mrigendrachaubey wrote:
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index ab83089c3d8f..3cfdb77fb47c 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -3053,7 +3053,7 @@ bool bpf_jit_supports_exceptions(void)
>  	/* We unwind through both kernel frames starting from within bpf_throw
>  	 * call and BPF frames. Therefore we require FP unwinder to be enabled
>  	 * to walk kernel frames and reach BPF frames in the stack trace.
> -	 * ARM64 kernel is aways compiled with CONFIG_FRAME_POINTER=y
> +	 * ARM64 kernel is always, compiled with CONFIG_FRAME_POINTER=y

Seems weird to add a comma here?

Will

