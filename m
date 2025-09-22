Return-Path: <linux-kernel+bounces-827092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 760DFB904A4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43657175B10
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736722FBE0D;
	Mon, 22 Sep 2025 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJHyDnug"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6361E0DCB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758538770; cv=none; b=nhS0qYZkRTRTzNxQcvYEBTcjz8io1oEzTTz5BPOKQJ8qVDjix6yHt7Ji9Hcz7zb0ZpwJ9U+V40SyBJcK5mbU7Dg7yM72+vDEBYE4/7tLHZlPDbHYeDHkz72C788zF7qQR9eEIJqsp77IUSM/keyN7NIbF5C97Ns2LIYbVt+WDT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758538770; c=relaxed/simple;
	bh=o1lDqlMsk1yFq192R+5MhB3fFWbg6PgdL1q31dVJ8go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6VgnKUR2RiggAdleufYHPA2VdC2TNaWkKKs4nVoxZzaRZoJXk6L902OzVskfifFdPlHw4t2+WTwmzjFBAlPjY9eHOjTfb8eu7JRER0JRnZtl3RTaJjIuyjuYoZJL8FdqV7trtehrXIr4PvtpaHnoIwk7EtEz1W1jJaBPlCMB+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJHyDnug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7644DC4CEF0;
	Mon, 22 Sep 2025 10:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758538770;
	bh=o1lDqlMsk1yFq192R+5MhB3fFWbg6PgdL1q31dVJ8go=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NJHyDnugZam9/507Uer/BvX23Rt/Zp0pHkiESat+GwwtnWps2p1Sjrpudl9DV8NAx
	 S4kku1VpodBdzRdhUrVzMoEsgeFc3HFPmf4mi59eTjMX8gH2LqWV28ZSROcOj+S38D
	 B8TiNfCAA6O0xueTRmuO+ht9Dk/fsoxxZFlDDl2eWVrINFaIQDlso2i9qp+XKtF7Vv
	 igAWDWAEFrWLdaiZH7l+LX+HQt5gmn8WiVKt9UAToaewkq3mXH9eyoUE5mxFxdJFs/
	 pWoiE1gmzCafpQLJXq1sKUJ07+zdq1eU2qmiBD1Vc6JK0SowncgqnInGpMsQZJQRwF
	 F383Vse4cjD3g==
Date: Mon, 22 Sep 2025 11:59:26 +0100
From: Will Deacon <will@kernel.org>
To: Li Qiang <liqiang01@kylinos.cn>
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: add unlikely hint to MTE async fault check in
 el0_svc_common
Message-ID: <aNEsDswLSpBkf-5S@willie-the-truck>
References: <20250919033327.1942730-1-liqiang01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919033327.1942730-1-liqiang01@kylinos.cn>

On Fri, Sep 19, 2025 at 11:33:27AM +0800, Li Qiang wrote:
> Add unlikely() hint to the _TIF_MTE_ASYNC_FAULT flag check in
> el0_svc_common() since asynchronous MTE faults are expected to be
> rare occurrences during normal system call execution.
> 
> This optimization helps the compiler to improve instruction caching
> and branch prediction for the common case where no asynchronous
> MTE faults are pending, while maintaining correct behavior for
> the exceptional case where such faults need to be handled prior
> to system call execution.
> 
> Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
> ---
>  arch/arm64/kernel/syscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Does this result in a measurable performance difference?

Will

