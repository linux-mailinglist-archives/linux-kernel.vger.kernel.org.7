Return-Path: <linux-kernel+bounces-798314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FD7B41C31
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA493A7A87
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD932D47F8;
	Wed,  3 Sep 2025 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Edp5VoE1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8g7ZmmO/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987A122DF86
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756896604; cv=none; b=iH97nUFkjwqyAnnw1KmpZvIx8neeMB/671cXTPipWUgeXlrgkFoHN5gm36kw4AQPcMLbj0vbTWvq9gmIdEbPxEg0nOudfeSk5/NiID4P+pwLUjeqAlNa/1XL1WAI8sKSvKAmtVKO0M7SOb5Cfxpqu9z0D/ts6KBO5eofT3RTqr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756896604; c=relaxed/simple;
	bh=Dsq5ENtOZGjjYxqT8/QSf8TMc3hKrCLp6igtbfl2kf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJHwDLMNW5HQQT3i+8x3fStDQSYA4h3JSbcjiHSWz0LLzGNalugEyEu7Zskwlj0cPPK7RLqvbg0iMb5zjtNWDZOIGPI4FBCsOIfoEPw2feWtx6rUccvfxUM/UgcF27LDlLQDIp/KZVOGofR/FAeD+1CIU/hZNrpA8VSY9ZPGAG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Edp5VoE1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8g7ZmmO/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 3 Sep 2025 12:49:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756896599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j6RJiG9LKdMiF6JHUgt/C676r7v1TC9rEint4KQ3yj4=;
	b=Edp5VoE1mfxAQsPaKzt2DFJgUvT2YTcfW4Fs825/HOglXQzoMIoUM0J5gc/EQ7i0+nAopc
	r+84KlJ3Ak0A5juv7Q4Cj1AVXHtAYpgXEX5sg0x1iWxqtDDTq4darlByJeoTIEJZuYwAgf
	Na89kCg+E4PKsKkko58WOPoVTjSfsUAtgUiAADiOwTd/tsGmb08UaYslJjmdETPrbS0XA8
	+lEeT9NmcExZtlV54ghoEiNVPekg3fUxN8k3pZaci+pJgrVD4FB+ld3Gy3XJ1nZ/FHeu+K
	gcFcBo9qm8cMRzO8a+DDOP1ejRWRTaexXFBRH/J4CA6d6eOTa3lfBVhjdXZilA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756896599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j6RJiG9LKdMiF6JHUgt/C676r7v1TC9rEint4KQ3yj4=;
	b=8g7ZmmO/QT8/F2MQldoLuxcXIMLtJdf6KmIJgbamVe7nrdXUyrz4JIIhtCluFUSERUhA9/
	W1Sw3g5HXR9NxRBQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, 
	Andy Lutomirski <luto@kernel.org>, John Stultz <jstultz@google.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: uapi: Provide correct __BITS_PER_LONG for the
 compat vDSO
Message-ID: <20250903124853-7dd41845-8939-4a01-b50d-42f87cc6583d@linutronix.de>
References: <20250821-vdso-arm64-compat-bitsperlong-v1-0-700bcabe7732@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250821-vdso-arm64-compat-bitsperlong-v1-0-700bcabe7732@linutronix.de>

Hi arm64 folks,

On Thu, Aug 21, 2025 at 09:56:43AM +0200, Thomas Weiﬂschuh wrote:
> The generic vDSO library uses the UAPI headers. On arm64 __BITS_PER_LONG is
> always '64' even when used from the compat vDSO. In that case __GENMASK()
> does an illegal bitshift, invoking undefined behaviour.
> 
> The first patch should go into the 6.17 tree.

Could you take this series?


Thanks,

> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
> Thomas Weiﬂschuh (3):
>       arm64: uapi: Provide correct __BITS_PER_LONG for the compat vDSO
>       arm64: vdso32: Stop suppressing warnings
>       arm64: vdso32: Respect -Werror from kbuild
> 
>  arch/arm64/include/uapi/asm/bitsperlong.h |  5 +++++
>  arch/arm64/kernel/vdso32/Makefile         | 13 +------------
>  2 files changed, 6 insertions(+), 12 deletions(-)
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250820-vdso-arm64-compat-bitsperlong-4f59ae7ef6e7
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 

