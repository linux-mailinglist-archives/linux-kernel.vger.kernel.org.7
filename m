Return-Path: <linux-kernel+bounces-773317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 523E2B29E35
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 506E47ADB83
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6117830E840;
	Mon, 18 Aug 2025 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vVpboBcT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T/i0uYa6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620DC218EB1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510104; cv=none; b=qCLNH2dd/Kwt//1NMwpE17/NubfINhAihCeAVvtY1JhjXLi1j2bSu80ENNNd8FNZa8pJtv/CsuK6NmJdDLP32MrSCU2qeklRyz3xg1pcCbcQTodJMiAO4ULytDPskUh/Rzgl6gZe9FHi7TzXn5RVMYu1qqORm48AXLGDLa2ACQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510104; c=relaxed/simple;
	bh=eX9RBXjuhdQMXv7ZHS39NThC4saaq7ZJTdCFZqtt3jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmP7tQORsjEBC8AxW7V3Y5uHfdGqSgDGvGA1hdFaCXFpL54qjlv9ZjRVH6pypoU+E7mryPvzC6vk6r2bcdlaDdAzfCAWeNNcWOTN64BhXsOXzsqNbycW9fLulHWr8a+YreqJ4R7RbHLSxXhYJ4M/sENpQX7E7Bo8eGKPq8wjX5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vVpboBcT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T/i0uYa6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 11:41:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755510100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4pypyIgcSCXGmvE+ZOZLzLuUiFgnf6jj8obZCRxRcnU=;
	b=vVpboBcT22xTEko3gCElfUcEq9dISG7ktRDQGTRD9CVVwbex4wstocKN+jJlZs82PwJggZ
	3evutOtcKmCFRuAJABNujIogvrwHHedmv2+alE0Tyy//0qwkCxpTGEABI4AjF3QOJkSceM
	cU/itvVe1xHFJF9JrHDqR6KExZcW4O8rKNPgx5EdQpCg81oskXBzIDJaq9//zMKBa8t9yt
	elscOhFyoGkNk4jz+Rjux2b1QMFnCWjXSasyB5TNaE2ABQOcR18jfQYLuu6YTWDtYF3QVo
	st7diAtWL+JSeb7F0Qs+AHEXkCvXvInGj8LnCMS83FIuf6ibaZexTCvJglQpMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755510100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4pypyIgcSCXGmvE+ZOZLzLuUiFgnf6jj8obZCRxRcnU=;
	b=T/i0uYa6SXGrGUaS5h6BBP9MQN8ozJd9ODi04GtEOmyaOb+w4w/3CL+ejQwJ1oq7TBxMJu
	TSyVU3BHnGPzFBCA==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>, linux-kernel@vger.kernel.org,
	Konstantin Belousov <kib@kib.kiev.ua>,
	John Baldwin <jhb@freebsd.org>,
	"<cperciva@tarsnap.com>" <cperciva@tarsnap.com>
Subject: Re: [PATCH v4] x86/bhyve: Detect FreeBSD Bhyve hypervisor
Message-ID: <aKL1Uj4R2Dj1pwB7@lx-t490>
References: <03802f6f7f5b5cf8c5e8adfe123c397ca8e21093.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03802f6f7f5b5cf8c5e8adfe123c397ca8e21093.camel@infradead.org>

On Sat, 16 Aug 2025, David Woodhouse wrote:
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
> Wheee, now actually tested under Bhyve.
>
> [    0.000000] Hypervisor detected: Bhyve
>
> v4:
>  • Add missing parens around (bhyve_cpuid_base | CPUID_BHYVE_FEATURES)
>  • Drop unneeded comment about x2apic support
>
> v3:
>  • Drop the cpuid_level check
>  • Define and use BHYVE_SIGNATURE
>  • Use the actual definition of CPUID_BHYVE_FEATURES and logical OR
>    instead of adding, as we do for other hypervisor leaves elsewhere
>  • Fix bhyve_cpuid_max miscalculation mistake
>

Thanks! For the CPUID bits:

Acked-by: Ahmed S. Darwish <darwi@linutronix.de>

