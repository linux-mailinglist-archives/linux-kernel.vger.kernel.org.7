Return-Path: <linux-kernel+bounces-891025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3691C41A31
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7018D189AE47
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9758030EF7E;
	Fri,  7 Nov 2025 20:53:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355F1289374
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 20:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548786; cv=none; b=Y985RuL9e93ZrfJbAf52vIKsEj198qfAxq0aYNqI0dGKqKHrCwjPhYdJHboxeRX20SctvxvuTsEWNH2YjVfHyahmW2e7VMJ8XmqTEkx7k/zKKLcGXjpTPhzukE+cqarzirhmDKz4Zq36E6ePZiC8TouccxW4XsVvYe8PUROAMuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548786; c=relaxed/simple;
	bh=dC6nbTXv90pan2v+lGcJNYb5N/o+ftTL/dwVsV+tN5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dMYnHFqHPxlFqcSKbXVDSx0817Ji8ikrurJJ0JVVWen+DFMEeSZJNmU0EqrAO+EQHkNzqq9LvdORQf4HPG8BhDQ7f1Z8t+Zg9u6WngY8ZtO/apP02jVQfD1JsnLzlMRi2sKomqUPMyx+GsTndS69Tl9r0vWheaT0w0zCSR7SDfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F57C4CEF5;
	Fri,  7 Nov 2025 20:53:04 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: will@kernel.org,
	Dawei Li <dawei.li@linux.dev>
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	set_pte_at@outlook.com
Subject: Re: [PATCH] arm64: Remove assertion on CONFIG_VMAP_STACK
Date: Fri,  7 Nov 2025 20:52:59 +0000
Message-ID: <176254876743.3846522.17168409346525738867.b4-ty@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251103152345.175463-1-dawei.li@linux.dev>
References: <20251103152345.175463-1-dawei.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 03 Nov 2025 23:23:45 +0800, Dawei Li wrote:
> CONFIG_VMAP_STACK is selected by arm64 arch unconditionly since commit
> ef6861b8e6dd ("arm64: Mandate VMAP_STACK").
> 
> Remove the redundant assertion and headers.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: Remove assertion on CONFIG_VMAP_STACK
      https://git.kernel.org/arm64/c/4002068508ca

-- 
Catalin


