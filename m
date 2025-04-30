Return-Path: <linux-kernel+bounces-627681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 401CCAA53B0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 20:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39F84E0564
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 18:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768E4265CDE;
	Wed, 30 Apr 2025 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qop5rON8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38F725E444;
	Wed, 30 Apr 2025 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746037841; cv=none; b=GksXfuXslN8nJk25hqvlf9dXkrIDW3OlgNgoOQNxznx7dKQj1qIAP6OsMtNtcf660WzQvsROXOEAnXxX0std0mODXfd5blmOo+RwHfN6HpkdNs2ap9USjQXczYHwH8/cPbmRHsMuspd8R6FnCnhYGrkYB31jPDEj4T+5Rk4trcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746037841; c=relaxed/simple;
	bh=T4eePFbM5LSrE/2KS+Bqr4adCBt8knMhqfA8OjbYrTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQ2kdsWPeAMGsEAnOSyifJ3oRQUUeTYwhzJP0eQedwaETS2sV9JNGjwbhMn+MccbtjkWXPGfdHZHM7q0nO2lLvH+ZkE3DEfXGCP+swboCL/el8i6AcNAkOPropqezVRMIjGRGtISncItBzTce7Rjvhpz+6svgj9laEvnJFe95u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qop5rON8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F53DC4CEE7;
	Wed, 30 Apr 2025 18:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746037841;
	bh=T4eePFbM5LSrE/2KS+Bqr4adCBt8knMhqfA8OjbYrTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qop5rON8lnLTAy0Dbg56VCAOI7RIIuxOiV8MxIrqC/2X45QRWrAXHobrr5JdmCqaW
	 UEHoYYd4ydI0Cbyd8mY2FVUBnesQglBpYOI9UrOgT8tQo6CZmW6WIcjtgr50MaYprh
	 mnQByuCFdBvoms8CI9ayxMitQ/PTS62hptOLj90TStt+iSQcaIk5lAT3GgLkQgJXss
	 aJkNYgMjgNE5mXwFywXgJ8ObyxRBW5a3atOi0vffbxvJET5gF0WrMZ2cAeLIi/3Wge
	 ivkUJIrqKEG0aIoarLZkmqcUdc6k3L26vA7d4N+6EtsPWrTXnsLLuGr9oG/GED3Z2a
	 BTyoubY1Uqosw==
Date: Wed, 30 Apr 2025 11:30:38 -0700
From: Kees Cook <kees@kernel.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: kvmarm@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	will@kernel.org, maz@kernel.org, oliver.upton@linux.dev,
	broonie@kernel.org, catalin.marinas@arm.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, elver@google.com,
	andreyknvl@gmail.com, ryabinin.a.a@gmail.com,
	akpm@linux-foundation.org, yuzenghui@huawei.com,
	suzuki.poulose@arm.com, joey.gouly@arm.com, masahiroy@kernel.org,
	nathan@kernel.org, nicolas.schier@linux.dev
Subject: Re: [PATCH v2 3/4] KVM: arm64: Introduce CONFIG_UBSAN_KVM_EL2
Message-ID: <202504301130.3AACEB0@keescook>
References: <20250430162713.1997569-1-smostafa@google.com>
 <20250430162713.1997569-4-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430162713.1997569-4-smostafa@google.com>

On Wed, Apr 30, 2025 at 04:27:10PM +0000, Mostafa Saleh wrote:
> Add a new Kconfig CONFIG_UBSAN_KVM_EL2 for KVM which enables
> UBSAN for EL2 code (in protected/nvhe/hvhe) modes.
> This will re-use the same checks enabled for the kernel for
> the hypervisor. The only difference is that for EL2 it always
> emits a "brk" instead of implementing hooks as the hypervisor
> can't print reports.
> 
> The KVM code will re-use the same code for the kernel
> "report_ubsan_failure()" so #ifdefs are changed to also have this
> code for CONFIG_UBSAN_KVM_EL2
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>

Thanks for the rename, this looks good!

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

