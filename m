Return-Path: <linux-kernel+bounces-785594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A0EB34E31
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 23:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16ABF2084D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF0B29C347;
	Mon, 25 Aug 2025 21:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMNh+sdc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DA029B766;
	Mon, 25 Aug 2025 21:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756157942; cv=none; b=ZjY5N6sJwWc6n9EjiP2EP5JupWGbR6VR17ihM4cmnG/bHB1/ANnKoonh/aMcpc1+hPSqKljI4kRAF1DTXlWFdMVMzfDpUu7a6OxPt3rwAF8BrGgGwcw7DYDMwt0nEHyCL8EagZhm5ke8e46oAL0xg6HVAlmGAOvmGDLECPS6oz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756157942; c=relaxed/simple;
	bh=e27rhAjFqsLeI17Ego1WOM45y0eTYHr/H9pidHm2USc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNRz07IUsh8NwPtZ2PaUjkJ8/dFAb6n5/tkaEkVxlbjcFY6IR38esaaXyXCDxWAW9iQeSKanhmt8NFZ7JvJ0lZ0MLlG47LCVX61cIW8XUt0BljY6ADDXItsLsU6WO9RW28oG2C1z5EG8c+7Kf29zymZlN4mEVp1gedASusquf3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMNh+sdc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A2AC4CEED;
	Mon, 25 Aug 2025 21:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756157942;
	bh=e27rhAjFqsLeI17Ego1WOM45y0eTYHr/H9pidHm2USc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VMNh+sdcd2bG95pIgVUQsEDjxCZpEM3lAS5mpQNrLJ8oorpGYIWZ66ReBH3lQ1Zl4
	 5zTUYMyfHG91r9icH0nc/mQPqNESjNICmwSMu9sTVCyW/xxcRrVkcTqxGzcL2T/jQR
	 zdYz1sG2WPAha2ARgEjnQmMOAZ0irq1K11ZsPSIG6C+H1TX/g3uSTUBkfKG7pY73aa
	 0ksHgeSv+LcyiuLG12AdpzXsZaaM+yPHLzhoUqVdP3UAaHBFI0jEPJPJL5U8CvWAXg
	 qtZILGYZS1T3KZD4CCcQoRH+NtfA/UFhnYvh7712XASA8N+A8krCC8zC64dEZfL83S
	 nLgDt5IjQ6cyg==
From: Kees Cook <kees@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] LoongArch: Rename GCC_PLUGIN_STACKLEAK to KSTACK_ERASE
Date: Mon, 25 Aug 2025 14:38:59 -0700
Message-Id: <175615793761.2150029.12607347712708724677.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805110754.3243432-1-chenhuacai@loongson.cn>
References: <20250805110754.3243432-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 05 Aug 2025 19:07:54 +0800, Huacai Chen wrote:
> Commit 57fbad15c2eee772 ("stackleak: Rename STACKLEAK to KSTACK_ERASE")
> misses the stackframe.h part for LoongArch, so fix it.
> 
> 

Applied to for-linus/hardening, thanks!

[1/1] LoongArch: Rename GCC_PLUGIN_STACKLEAK to KSTACK_ERASE
      https://git.kernel.org/kees/c/351b51dc16a9

Take care,

-- 
Kees Cook


