Return-Path: <linux-kernel+bounces-844905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C46E5BC3073
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 02:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F7C3B7BAA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 00:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D3B54763;
	Wed,  8 Oct 2025 00:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQRKuo/D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E5C2110;
	Wed,  8 Oct 2025 00:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759882103; cv=none; b=k7veGde2U2RTo7niZCW6wo5TSQ3IlctFLv5GBwxbCs15Cj5pE88jg60NjIh7/DriY75n2/4hPbP9gLyu3pOBszKKNUoubxnylF9BK6LDvDsXz1LMUem6VTyCKJOdhxusP8odO1KrSArlyr/eo2ViRKAMCMttlrUJEwkBd5F8nGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759882103; c=relaxed/simple;
	bh=zwzuDUqs2zW/KGFmmY0CnbIDRBr/A48Fdn4lYnyq4g4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IGtXOs2C8//rYhVfGBs194xmwC2VbL1U2BBueXpyOTcEAI5gBT/82b4iFLKUFoIONi+lZL3WkUEWEQ+uveUC4FAuGcjzxg+KbxhRnmXr5uSxsciBAVuV7aMo4gXdRPe9NHeOCJzqSY2SVClldMQsNXlIkFOlGzU19LoMJbTv/hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQRKuo/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7F5C4CEF1;
	Wed,  8 Oct 2025 00:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759882101;
	bh=zwzuDUqs2zW/KGFmmY0CnbIDRBr/A48Fdn4lYnyq4g4=;
	h=Date:From:To:Cc:Subject:From;
	b=oQRKuo/DuYUvwmyCIixJqfGsZiYXA2ou3ww2vRCCQhurjEsfkUkAXhJnYanDgBPqA
	 KQ3KotwVdlE8eLbyV9E9OkHpP4XeXUwJFzLevCikAgsdVw/AKFcarlVZ0GLrbbgyG5
	 T4WCUwavD0Gm5Ftw4j43VgRCZtDp+IWZH6rGWD62eng6ldhZ/+F7M29D88XF57/Odv
	 iWEA3PFKAhqzcG+8Ut3Dv6FZwfUr2a///kc7r35Moebwl6EqPo7sRTfUyjLqYmX9Kw
	 wLrTxBFNKFxPmanyNWmUq5ZwmUbAxaDjusVYAq/kEFHJ7NM/9rPOGEvhbNvnebtnEG
	 PFWy4/MTE8A8g==
Date: Tue, 7 Oct 2025 17:08:16 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: ojeda@kernel.org
Subject: Prebuilt LLVM 21.1.3 uploaded
Message-ID: <20251008000816.GA1856596@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded LLVM 21.1.3 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

If there are any issues found, please let us know via email or
https://github.com/ClangBuiltLinux/linux/issues/new, so that we have an
opportunity to get them fixed in main and backported before the 21.x
series is no longer supported.

Cheers,
Nathan

