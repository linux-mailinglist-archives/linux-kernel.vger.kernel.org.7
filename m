Return-Path: <linux-kernel+bounces-824465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7AAB894CD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C651BC7A31
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40F030C100;
	Fri, 19 Sep 2025 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tP4QNoad"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2806419755B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758282062; cv=none; b=k9ZT/ZQ8YT2YS1PuyJ+WVCwk26o/YsUFiiYoTDlsxOUNtXeifaYbfPk8f8NwGM6uGaV7uheWlqTUByiP8qQ+Qzuf0qcecofHBC2+7So3g0Lokd8EUb3KGEihfqSzafDeOxhQr1GE0GyJn3hQ76vY2xXOV7ZDuxBkiJaRGOJUbpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758282062; c=relaxed/simple;
	bh=792DYNCBkP3tBnabEABgwGFKr8gigP8l0yyHqaUtcz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFGtFJJ7LU8iIZVj1Li/9FSGguAjN8UzLrta2AK0SUaoO4MzCUM75mgeCPSZ+97z3CuDIQ9zZ5rZY9ykzczzQVl9HIjZ3xp5NM5MmaSSFIxTake5UoacJV42LWgdst1J2hSkSURcSnIhuTp77X2WS3SY+JsLx4Aauwq18FckOKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tP4QNoad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF3EC4CEF0;
	Fri, 19 Sep 2025 11:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758282061;
	bh=792DYNCBkP3tBnabEABgwGFKr8gigP8l0yyHqaUtcz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tP4QNoadn6CKvqSo+LZcTfeyko5AvnM+HUlQ717kWW5fmRqOuDxDfUGjZZhbAq7EF
	 4wA7JNCQH3LLZpN9wWcm4RuFmZIhZyolHeBh0pBFTXhvwMaGu14zH/BlvRmqw48343
	 EEAJuynhEW4VArF/EA3Di9Za6XL/d1jwOhyxHKOuuoIzeXzR446XDbPVNPdwd4ePBR
	 IvORPciwbAPTN/AejQRQ1L7KdM8NfAApvvP25o9uQkd9eIvLGmWPJ/sCnzxNM0NQ7J
	 e46FF1RiATQ8fK5m2NY5F1/iIMDpXlOU6wLT3RVdlXW/L4AgIAYkyIlfada25QLzOW
	 LsaXWlPLLo7Zw==
Date: Fri, 19 Sep 2025 12:40:57 +0100
From: Will Deacon <will@kernel.org>
To: Can Peng <pengcan@kylinos.cn>
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm/syscalls: mark syscall invocation as likely in
 invoke_syscall
Message-ID: <aM1BSZV43DB_l5OU@willie-the-truck>
References: <20250919100042.497861-1-pengcan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919100042.497861-1-pengcan@kylinos.cn>

On Fri, Sep 19, 2025 at 06:00:42PM +0800, Can Peng wrote:
> The invoke_syscall() function is overwhelmingly called for
> valid system call entries. Annotate the main path with likely()
> to help the compiler generate better branch prediction hints,
> reducing CPU pipeline stalls due to mispredictions.
> 
> This is a micro-optimization targeting syscall-heavy workloads.

Does it actually make a measurable difference?

Will

