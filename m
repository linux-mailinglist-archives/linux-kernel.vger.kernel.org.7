Return-Path: <linux-kernel+bounces-783361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2705BB32C85
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 01:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E83C24E0FF8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 23:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43447247DEA;
	Sat, 23 Aug 2025 23:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yRdiKf6X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BpFVnIAG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B3B23ED6A
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 23:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755990743; cv=none; b=EjDVSpYG/Lt6XIbNHuxOKFVhxCdgkSG1cJdELUvVoTLj5l+O3ZD+fnuB9aw4tVmwZYif42StBBO35aKGWDqGIN4vRnyK9pJCCmtVuHK0h/k1WuEIL2zj6y1haSwSMm9XjuujPrFkCk9I3fvgh10LvY2nnJHE7WqfBRklYDDcX8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755990743; c=relaxed/simple;
	bh=dS1uT1eaHt4nRTNbshhYaC327VYhFMOY8M/tZ/f0++k=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wpehi37dozdBbsL9670pMeTbKu3uMaRpYg1cFj12lYbJfOWoDNDP8HHWwi77XIxBb9i3WCxvfbCA1VO27OlrcViULheySgypZHsK4ol+p9/wm8UTT+o6+gIHbqZ7VEtBmcTVfRVVbZ4jYmSAX0uOqv9NCZ8NgsshTtcuHIgyO3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yRdiKf6X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BpFVnIAG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755990739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h4jzGM5ciMuBpgya6EDzB+qy3/uT7PQPf5Xeg1kYKXQ=;
	b=yRdiKf6Xzdg0tg/k8BJeYcAjhOTTsfcX6Y3gXWyFLHf76YpHsENIvM10l3VJQaJ3UKoFz6
	VZ4ec+HSIZEcYRQGJg5jWbSAMZbb6pVHDSSGBQFhqQXT4dhrRjiqaKCg2WMleYHsyMEKZD
	R7E1kashRF5S7K2HtXE7a90FllMEzYmkQxGqckbmmzIRUQyjU2/AG2vDrH1IQ8IKGUVeby
	awrNxSLMbS9vFZj/mOGPm8n7eDV87DESJt0WNOpznMObtZBHxKgsL683SDzvTPf+eKYRK/
	Ejr9i0wGmMFnMhcoiQsfPMWvH0RcDQpOt1OyvfFpxsV/MIRqFsZg/b1hTVg/PA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755990739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h4jzGM5ciMuBpgya6EDzB+qy3/uT7PQPf5Xeg1kYKXQ=;
	b=BpFVnIAGmmQb2tGQruKrp9Du9sPs2/cTF+FZuruKmFAshH8CoVP85R7eEyyFAG6VwowkEY
	Jhz89y1rTxtkNVDA==
To: vishnu singh <v-singh1@ti.com>, mark.rutland@arm.com, maz@kernel.org,
 catalin.marinas@arm.com, will@kernel.org, jstultz@google.com,
 sboyd@kernel.org, akpm@linux-foundation.org, chenhuacai@kernel.org,
 pmladek@suse.com, agordeev@linux.ibm.com, bigeasy@linutronix.de,
 urezki@gmail.com, Llillian@star-ark.net, francesco@valla.it,
 guoweikang.kernel@gmail.com, alexander.shishkin@linux.intel.com,
 rrangel@chromium.org, kpsingh@kernel.org, anna-maria@linutronix.de,
 mingo@kernel.org, frederic@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] time: introduce BOOT_TIME_TRACKER and minimal boot
 timestamp
In-Reply-To: <871pp14pkr.ffs@tglx>
References: <20250823044034.189939-1-v-singh1@ti.com> <871pp14pkr.ffs@tglx>
Date: Sun, 24 Aug 2025 01:12:17 +0200
Message-ID: <87y0r93a5q.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Aug 24 2025 at 00:53, Thomas Gleixner wrote:
> So the [0.000008] timestamp happens exactly 1.0 seconds after power
> on.

Let me correct myself it's exactly: 1.000008 seconds after power on

Sorry for this fundamental mistake.

Thanks,

        tglx

