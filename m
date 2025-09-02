Return-Path: <linux-kernel+bounces-795753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86846B3F76D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51EBF1B2172F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114DC2E540B;
	Tue,  2 Sep 2025 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeTFCFyy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E16120297E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800059; cv=none; b=EEjwF5EspZWfMLT/gavEDskvCZZu0xwAK+yqoRshkc9bAK2NXROjgzq0kIAqWaqugwcfDq87PO5IYi5Z7FurxbgjiQYpZxiXeCnaT5hA5U7xKfemQAZxPwr0kUYy0r/hrBAm4VKThXdxwD5LQrEXXf2qXoft8GD16+8I1qcIJJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800059; c=relaxed/simple;
	bh=U+MvfhFa9jg/7JowvKdjixRXmxepRFfHPp4jEN1XWpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swPD6UcjEuF5rHygsq5yJayDjm+sFOoQg0lSFXILBGIvaNBdA3RlqkmexM8nrodIzwJ5vUKBYTLnbrv5gTpiZR3Zb34o5q3jQ4QWYQBbHXA7hwRrj02EhgOLFIA9N0MABjzXgpjXDuYMNQEAaIB5b1zIPS1W0EHsRuAgFUKdrR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeTFCFyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D5BC4CEED;
	Tue,  2 Sep 2025 08:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756800059;
	bh=U+MvfhFa9jg/7JowvKdjixRXmxepRFfHPp4jEN1XWpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HeTFCFyyt1v+jGbQdLyEfvQbNDKnpabyXEmBRCkFv1/Mca0UL7RZwf64w5Wda4YBE
	 tvjPj/2yvDHMTBxXLRQV7yDPk57wHi+Rd1Ctd0lQxJXzL8YmCjMjvMMfq4N0/5MegI
	 TRQErpLbxqUnKAHliKPb7f4JNyuWIMgpoCbUAnkhYh3YJRGrbeUtIz+J31Y/mKQ2Hk
	 Li9u63kYKlgc2+KHH/cwYq39t/CR/v62KISitxE2QDbKpvVbyoQBFZLAhIEfkapwrC
	 Idjv9wx40LqWcV6qFjKqpo2Xse7XyBtO/mb7C7Q1UjfDM3HK0Qtl18nfWkNqab2WCE
	 O2Owzj6Etg+Cg==
Date: Tue, 2 Sep 2025 09:00:55 +0100
From: Lee Jones <lee@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] mfd: qnap-mcu: Some fixes / improvements
Message-ID: <20250902080055.GC2163762@google.com>
References: <20250804130726.3180806-1-heiko@sntech.de>
 <175679988816.2174534.8796703637805096491.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <175679988816.2174534.8796703637805096491.b4-ty@kernel.org>

On Tue, 02 Sep 2025, Lee Jones wrote:

> On Mon, 04 Aug 2025 15:07:22 +0200, Heiko Stuebner wrote:
> > While digging through the mcu functions, I came across some deficits I
> > introduced with the initial driver submission, so trying to make that
> > a bit nicer with this series.
> > 
> > 
> > I struggled a bit with the ordering of qnap_mcu_write error-check
> > and conversion to guard(mutex). Converting to guard before the
> > error check would need dropping the ret variable, just to re-add it
> > one patch later - to not cause unused variable warning.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/4] mfd: qnap-mcu: include linux/types.h in qnap-mcu.h shared header
>       commit: f7ef7c03d8599a0d86b2a05929da73358cd56dcf
> [2/4] mfd: qnap-mcu: handle errors returned from qnap_mcu_write
>       commit: 3d02c538ec5337b66750d83ce6f861aef263fbff
> [3/4] mfd: qnap-mcu: convert to guard(mutex) in qnap_mcu_exec
>       commit: 5fd101541c6d0f0ad3b14d86dfcf9347c3f3bffd
> [4/4] mfd: qnap-mcu: improve structure in qnap_mcu_exec
>       commit: 6cdb0fbe090be966432db041d5650907a4dceac4

I fixed some issues in the commit messages for you pertaining to
spelling mistakes and expected format.  Please not that in future, MFD
and LED (the submissions I've seen from you recently) take a capitalised
word as the start of the subject description.

-- 
Lee Jones [李琼斯]

