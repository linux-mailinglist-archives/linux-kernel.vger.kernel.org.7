Return-Path: <linux-kernel+bounces-801070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4DAB43F7D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C6D3BD98C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A83C2FB;
	Thu,  4 Sep 2025 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uuL+40DE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2078132F743;
	Thu,  4 Sep 2025 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756997037; cv=none; b=m2c9C/7+1gnW454M1M5VSQMYoaVUuwz5JzWCABagb/H4QLUXJPxwkVPejc2VeFtcF/5rZKPX71aPdSdC4ARU1zgrTjmMROrxWXUdBfEKDwbyYNYJ40qhdicH5OjdsGgu4knISv+SN/w+jTL6yl+Pyubu98Nt0RlK+jaxG5VNhns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756997037; c=relaxed/simple;
	bh=ttWQ6WJYnUoGEp+CGFMchnrYvE/2Rcnp7BOAqXZmtI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dj5hGsTGaE58/9sO5pxmsKWJIXKICnAL/RK5FEknw5frXFRxgKERCMAFGIhZNp0ka3gv+yHEcP6eduvtXAjmfcIGsBUTxuBkxLeQokxhlIdM4GpIU3Ree53gJeQD3Pcn31/3/2b61lEhUP5jHOXhejj74Q9w5boygKCMHkGLxQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uuL+40DE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DF3C4CEF0;
	Thu,  4 Sep 2025 14:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756997036;
	bh=ttWQ6WJYnUoGEp+CGFMchnrYvE/2Rcnp7BOAqXZmtI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uuL+40DENl65FVQaY8w+m6fI1LpizI4mRPDvby2HoC6Lb6goeTvuOp6cPZVj2eYF4
	 cN36NznxXWs4zfc9ccaZUYoY1gqKw4dUNvCSpiHROQRl5oLrNXTyqwbpKcmYAmp+Cs
	 Jy8of6nLBfQQAcArovKE/RQ0J0w46XAturJwNHUp1eo2ggL7QYwsNdn6lf5QeKh9rF
	 C0ej75KlrTn3x7O0yhf2gWILVXDAdPpKnG4pya/1X445vHvr0s3J2BAZD/3PY4k2mP
	 hK/s0hCTlsviPx0dPqgmMyhdc7WcGeg+ohgUV2Zco3yQAVfJQPZnQzATR4qFrIxMUB
	 pOoRt3+1G+coA==
Date: Thu, 4 Sep 2025 16:43:54 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Bibo Mao <maobibo@loongson.cn>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, Xianglai Li <lixianglai@loongson.cn>
Subject: Re: [PATCH v2 2/2] LoongArch: Remove clockevents shutdown call on
 offlining
Message-ID: <aLmlqn6snsiGRV14@localhost.localdomain>
References: <20250904071732.3513694-1-maobibo@loongson.cn>
 <20250904071732.3513694-3-maobibo@loongson.cn>
 <aLmd2KlBzFxJc21r@localhost.localdomain>
 <CAAhV-H6ThTR+r6m-moVpLTLVsV9ozfwaJPBuwZ+VdHDXsamwTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H6ThTR+r6m-moVpLTLVsV9ozfwaJPBuwZ+VdHDXsamwTQ@mail.gmail.com>

Le Thu, Sep 04, 2025 at 10:28:28PM +0800, Huacai Chen a écrit :
> On Thu, Sep 4, 2025 at 10:10 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > Le Thu, Sep 04, 2025 at 03:17:32PM +0800, Bibo Mao a écrit :
> > > The clockevents core already detached and unregistered it at this stage.
> > >
> > > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> If I'm right, I should pick this patch after the first one be merged?

Exactly!

Thanks.

> Huacai
> 
> >
> > --
> > Frederic Weisbecker
> > SUSE Labs
> >

-- 
Frederic Weisbecker
SUSE Labs

