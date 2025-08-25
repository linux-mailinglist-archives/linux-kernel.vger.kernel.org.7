Return-Path: <linux-kernel+bounces-784735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0247CB34080
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12425200443
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD76826B2AD;
	Mon, 25 Aug 2025 13:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+shQQpV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EB31F4CAF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756127956; cv=none; b=Y4dYubLkNeOXQcpA69BBPeG8fK2u9156j8t0HrKoOQF0sEGy+1LOjreA/8VI2NV7v2/CpOouCBwx9aZHCWdcf+RtJAL10WG3OIhn3qFsYs/w2yOemVFvS91akqFlSr4oRyvFmfBVrQXPauKcd4yQR4EBwywW84ZBi7iijitu6QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756127956; c=relaxed/simple;
	bh=AUjDLofzY5f8iZ5b2amlStNur/4+wlnYmlSNLlOo1hI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qy5ja8awqxChspBKZ9wePLhXpGUZRzymVzTX/njb1ULZiVqf0AWnobFALAqb40QdkbjyErCzG1THLSR+1cUQRMO6iaIIZ2aq+VLQOgXKiV7rzxcMKSl083GFiIAsX6AFuT+kDVThc3Gu+Dkwk09rRcx5b5fV0WwfleerggJmjCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+shQQpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC63BC4CEF4;
	Mon, 25 Aug 2025 13:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756127955;
	bh=AUjDLofzY5f8iZ5b2amlStNur/4+wlnYmlSNLlOo1hI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J+shQQpVp7SiwS90GuiWcyHC8sAAYQ7A79uvq88aR9snV5nVE7DhOxPWc45yDIMfm
	 FRy22gLCg18Pum3ZLrDlp+ZSZUwEREmFH4sBI6SR3/ps5cI/NLoyLqGm21X/QIwvAc
	 2QRkH3CYuXN/kBAi5UgKYwwhO81ygAyfu/gqDTRzytGW2xPj3D22IDPY9qhCI3PR/p
	 G5QnRpyAv/PT6mFQimvPranE8H/JLY0Qdjy+4mCr+AuymSDC87JHBzbNo93fS6JnYd
	 QJxLSCafcJZ+cEDxzr3T6bDDsShABTpJXLtiOF2fbjYJWyztUpmGhbLQ5hkM7SctE7
	 Kahbh8UlW8Pag==
From: Kees Cook <kees@kernel.org>
To: Russell King <linux@armlinux.org.uk>,
	Li Huafei <lihuafei1@huawei.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Linus Waleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: stacktrace: include asm/sections.h in asm/stacktrace.h
Date: Mon, 25 Aug 2025 06:19:08 -0700
Message-Id: <175612794578.1492825.5832281034488912097.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807071902.4077714-1-arnd@kernel.org>
References: <20250807071902.4077714-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 07 Aug 2025 09:18:58 +0200, Arnd Bergmann wrote:
> The recent kstack erase changes appear to have uncovered an existing
> issue with a missing header inclusion:
> 
> In file included from drivers/misc/lkdtm/kstack_erase.c:12:
> In file included from include/linux/kstack_erase.h:16:
> arch/arm/include/asm/stacktrace.h:48:21: error: call to undeclared function 'in_entry_text'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>    48 |                 frame->ex_frame = in_entry_text(frame->pc);
>       |                                   ^
> 
> [...]

Applied to for-linus/hardening, thanks!

[1/1] ARM: stacktrace: include asm/sections.h in asm/stacktrace.h
      https://git.kernel.org/kees/c/f05995cc6d3b

Take care,

-- 
Kees Cook


