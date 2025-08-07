Return-Path: <linux-kernel+bounces-758795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A21E4B1D3E9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 10:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F7B11899A85
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462DE1E7C10;
	Thu,  7 Aug 2025 08:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbvX6hfH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C6F2E36EC
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 08:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553655; cv=none; b=i0UvW8d+lbOsvwSN073mpeBh13XWlTpPcuZk5T0wZ7N405DoKtKbkKWXaVbjPUv/twiJsvyF3+0IxchJQYaLyeAaGvO1VWC7JDR3+a+guiwtElmHIPrsfuO7zH/wr9Pg58OznN/cc+IP/P8XztrRKkZyAQ/wDyldKY6rkDj2zJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553655; c=relaxed/simple;
	bh=9hADTosUKOFNWZ5EYqpjsUWzyHnDqVR4ADC7eW1jO6A=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VdnAxU2Wrea5vzyRfm53OQUss18PhUL+qR9JewZPTdWI7ehxydI7Qmixc/hM7clyfu1bCJqH+LjbUfYkNwRRDpdxujs+1zqv0FFkUtcOElRPNGayUKT1nFpYtnO7ZEMszUSylXqz9LJOnDCtvw3UQrrXD7N5vGMGTJQD1uCUWvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbvX6hfH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46835C4CEEB;
	Thu,  7 Aug 2025 08:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754553655;
	bh=9hADTosUKOFNWZ5EYqpjsUWzyHnDqVR4ADC7eW1jO6A=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=mbvX6hfH5Bld4lKBQl8GMpFGnfx65tkxSJC0WtoSH/TTWK06hY56oR3EYHWXxNzrf
	 K0LCmvLTqN5ICXChSR1ZVn/m1cuOP8BUPZfU6oLLH7yY/m9aLggqQEIDSgZMIJ33ak
	 lU9rQdj2lDT0Hw2dRmPSyFddeQkEOx2pnq87VpFeitVWUP+Jn1vuWtadt0mO+jtUcz
	 nZ05kxcEq/70Kq4mBdNcGLrLua3E3Sqb74ybCNfJJ4hSMT5Q2O+++bdJHP+7WVLE0W
	 OXqBL7nkE5fl9q4GN1Of9QEKRi/69UUzl/vVEnLvZ0/plFGJT8haGaKxEp0weUetKw
	 LGeb3oWMGoC0w==
Message-ID: <631b2bd2-f642-43ea-b3ad-423d19eeae32@kernel.org>
Date: Thu, 7 Aug 2025 16:00:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] f2fs: fix CURSEG_HOT_DATA left space check
To: "mason.zhang" <masonzhang.linuxer@gmail.com>
References: <20250806123236.4389-1-masonzhang.linuxer@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250806123236.4389-1-masonzhang.linuxer@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/25 20:32, mason.zhang wrote:
> This fix combines the space check for data_blocks and dent_blocks when
> verifying HOT_DATA segment capacity, preventing potential insufficient
> space issues during checkpoint.
> 
> Fixes: bf34c93d2645 ("f2fs: check curseg space before foreground GC")
> Signed-off-by: mason.zhang <masonzhang.linuxer@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

