Return-Path: <linux-kernel+bounces-787401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B32B375C1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1102A3AEDBD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 23:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99C6308F1C;
	Tue, 26 Aug 2025 23:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P24Ogi5n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F9B3AC22
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 23:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756252643; cv=none; b=BXHKLxe0TP9suOq68K4TycFGNdOFQqdyPb3Z11zOfk86ETNw/o3fqY88prFm7JeTwlLdA8vaU8nBArG5XLOZXkykGATklxjDNa9HwhceyHmgeB3G+8S420QcF5oNJDxiXWxasD48yp5Q0GNvXYKt2Idthn2NGe4pF+0L0YERGZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756252643; c=relaxed/simple;
	bh=RUJFOPMFXYruJFSqwE3f/FkoJzp4pl+HrCzURArIH7Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MMTy17/HQ1+OtKQ1CZXTjk670sgcc+C/yjpSeKx6UozaKNp7Ns64E2kXYDPUHTKrV8rTrX6DZY8xh5+gXquMzoCCqyoruTMxUAaebNaYErzzwfh288TAbE4wtweL3p/BnjuaqLNz/qK8FwQNGFXjAQZvIqa3TPFtcQqCbYWAWdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P24Ogi5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FBFC4CEF1;
	Tue, 26 Aug 2025 23:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756252642;
	bh=RUJFOPMFXYruJFSqwE3f/FkoJzp4pl+HrCzURArIH7Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=P24Ogi5njlNTr9LfSporit1vxf0BkFZEgM5DL/ROX5CcYsfx0PTTKts5WPn3eEOmb
	 vt6sEEMyFPVVj2QTj3YMDMIT9/PLxcGgCuOBG0OoKwmGIYOx0C6ShACkwMj0a7X6W7
	 Mn/hLHf6gC3LBf/0XEGj2zJs/DDiRNiW1LPMwQerHq0xdG9ZSTmqCdAwqeyFqDeoIn
	 0g2ZEDEXr+hCWu6hpzpeBSNXWJXYMgxbDRRL9NVGcuZhVPyVeDfM32180r8TzN/KCV
	 wlW8Am7XF4j9YpyJnZPfv00GV90hEJ9UF44KWwre2lQOWq+K6q3HyCqKpSqBnvZnse
	 fknWS0PfhhewA==
From: Nathan Chancellor <nathan@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>, Vlastimil Babka <vbabka@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, 
 Daniel Gomez <da.gomez@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250825-export_modules_fix-v1-1-5c331e949538@suse.cz>
References: <20250825-export_modules_fix-v1-1-5c331e949538@suse.cz>
Subject: Re: [PATCH] scripts/misc-check: update export checks for
 EXPORT_SYMBOL_FOR_MODULES()
Message-Id: <175625264072.3478097.15539057138489977007.b4-ty@kernel.org>
Date: Tue, 26 Aug 2025 16:57:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev


On Mon, 25 Aug 2025 17:00:37 +0200, Vlastimil Babka wrote:
> The module export checks are looking for EXPORT_SYMBOL_GPL_FOR_MODULES()
> which was renamed to EXPORT_SYMBOL_FOR_MODULES(). Update the checks.
> 
> 

Applied, thanks!

[1/1] scripts/misc-check: update export checks for EXPORT_SYMBOL_FOR_MODULES()
      https://git.kernel.org/kbuild/c/0354e81b7bd62

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


