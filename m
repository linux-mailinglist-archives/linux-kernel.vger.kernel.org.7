Return-Path: <linux-kernel+bounces-872545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F34C116B2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B35E44FDD71
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1755320CAC;
	Mon, 27 Oct 2025 20:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZusT7sM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBD524E4B4
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 20:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761597462; cv=none; b=K6mNSoBbCHRRwGdMqkkLY9LTaeue+wqLpYX6Ru+6yAM3lT0ec9eKebiUT3eC3hXCIg/nX4GoCWR8KWdCc5YQQOmaDRPimRp3yZ96U/cDpCZ+MyrToCGWk7bH7h714uWFBXbOJTnG3PrQY2sO5GX2Y8UaRN7ta6lM5K5tyeyNtes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761597462; c=relaxed/simple;
	bh=U1D99bM1CnrwEWxaa8wnWt3+xJpm3kjMIoPiNA3azUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCYcDvCyJSM37LpfuFRa5Cvl38PA3Vdlu+wMaCtKvuhGG6ZyD/TF7hY7VleH/2v5SIQN/aDlrvnaDEXqnHoWj3AziEZUbARD5aMmJEUq7yGGUi5ZHnWW/UMP0kT0lG3vIxE4AcQ0GdlGrQbTfYtYNUclEPJxWiZqLT30YHGpSfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZusT7sM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41813C113D0;
	Mon, 27 Oct 2025 20:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761597461;
	bh=U1D99bM1CnrwEWxaa8wnWt3+xJpm3kjMIoPiNA3azUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CZusT7sM0fNKFwmGUTNmGSC+s3RlDzK/CEDg0mDkNXYeAOeyZ8vGagQ9uc9S/qnvh
	 i9QhHPDaWkuZCZ0et+ZKfdUnxuPWa3hY2+EDoHCE5oIEMbqfmcvxUEtD5U7pHIOzEU
	 iPb1fkR/VJkImn2BBeVfteuSi0nh8SrxIw9Uvfb5wvhHWtIr4duqNj1yqdByqA9qmy
	 aToN1GKRfWvKS4QLSPgdv6Hg/66HHP+9tSNJWk2pnKSSgL4z3JRX8B8kwO5LHUtl8X
	 0C6NgXEh6M2YH0APl5DDPtCerJGwKP/6KgPs+/dURsv3am1w3ocEC+mZuS+1Og36QB
	 /QBEmyjxrN84A==
Date: Mon, 27 Oct 2025 13:37:39 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>, Miroslav Benes <mbenes@suse.cz>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Re-add resume_play_dead() to noreturn list
Message-ID: <rpvygldy2s2ybabzsoylbitpn5o7w6vustbox4jd22pwznydwe@6v36xs6vxo64>
References: <20251027163907.184681-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251027163907.184681-1-thorsten.blum@linux.dev>

On Mon, Oct 27, 2025 at 05:39:07PM +0100, Thorsten Blum wrote:
> resume_play_dead() was added to the noreturn list in commit 52668badd34b
> ("x86/cpu: Mark {hlt,resume}_play_dead() __noreturn"), but was dropped
> in commit 6245ce4ab670 ("objtool: Move noreturn function list to
> separate file") when the list was moved to noreturns.h.
> 
> Fix this by adding resume_play_dead() to the list again.
> 
> Fixes: 6245ce4ab670 ("objtool: Move noreturn function list to separate file")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Hm?  There's no "resume_play_dead" in the diff for 6245ce4ab670.

That was actually done intentionally with a different commit:

  34245659debd ("objtool: Remove superfluous global_noreturns entries")

-- 
Josh

