Return-Path: <linux-kernel+bounces-637624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C18CAADB4C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 11:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F1C9A26A1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 09:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D43F23D2B7;
	Wed,  7 May 2025 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y+zvK4NN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zl+p1P4U"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC651F1905
	for <linux-kernel@vger.kernel.org>; Wed,  7 May 2025 09:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746609333; cv=none; b=EB5woJG2nEtdSwCFVw6yZd/vtGXF/sjCUgQmlTh2v8PkmnJvz4uMY8MKvhconWcrgx/Eq1o8TOkBIxNZZT1vm1LhDFoOQuTTxi0RKZBIS3OJVQ8sgbwSwTbt9se/hNt3AN+QQvv816kdf+WtYZ8GFRHbkA1G+IoxxbLR5mPvJaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746609333; c=relaxed/simple;
	bh=G2/2XpBOhsww7ORMVPPsSJT8mP0ZzF2Yf1LmkHm/5Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kon5HalMGO6AS26X1z1fWUpsLViSpW1hKCkoHQQQfdzgCTSqkssiqT/6S18lrI3u2tYlCyLh6UDEneGR26Kf/vGz/dBLoMzdwIN6mvURyooy05bAYJ26e/o47nU+JmD4JvclWQsCVeJq3AMtiajvTKtFCAHz1ZsTh1JPJOMSV+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y+zvK4NN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zl+p1P4U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 7 May 2025 11:15:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746609330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JimTckZl2BytKdqLsH9N1Q1dX2kn4sCMUIjmguZkJvY=;
	b=Y+zvK4NNmknV76UVFiqZN3mPtZo3aWbNlmdQZFwycoDt7M7xnub04pVGttX1VZ7YUd4M3Q
	4hrKyWPZ3Bl8XBEjHq5fWQMV1Eg47TSoq1EnC8nKV/W/EfVGntP6hqh6xPSNVBlvGmfRHF
	l5RFpwNl9VvyDIxcOsQs7zB38FQoahRYO5uzK+aFW3EfRS92nnjyWr45FtXVzhN3o5S2/C
	F1BXcAwt98UeVBxSNVANpnlksw6ZrgVbl41mXV3wNsNWHn2hy3dbeRuXUWHVmC+uU15Dip
	TSVuI7r4dGWYSK21j9bb8o4admMQwj9YIRyvD7JZQXXg7PqDbiQarNL/y3V+bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746609330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JimTckZl2BytKdqLsH9N1Q1dX2kn4sCMUIjmguZkJvY=;
	b=zl+p1P4UFM8IXQIqgb6kwcNnZJ908mbDXslHmV+fZ692VHLSMlEi+Ve+TPW866fkm+7A56
	TaPf6niGtCv1zvDQ==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 17/26] x86/cpuid: Remove direct CPUID(0x2) query API
Message-ID: <aBsksJx4URuKYGXQ@lx-t490>
References: <20250506050437.10264-1-darwi@linutronix.de>
 <20250506050437.10264-18-darwi@linutronix.de>
 <aBnPVj9NZlROyA0W@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBnPVj9NZlROyA0W@gmail.com>

On Tue, 06 May 2025, Ingo Molnar wrote:
>
> There's one mention of this API orphaned in the
> for_each_leaf_0x2_entry() comment section:
>
>   arch/x86/include/asm/cpuid/leaf_0x2_api.h: *    for_each_scanned_leaf_0x2_entry(regs, ptr, entry) {
>

Nice catch; will fix.

Thanks,
Ahmed

