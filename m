Return-Path: <linux-kernel+bounces-886350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCEBC354E4
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 869664E703F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F257430F550;
	Wed,  5 Nov 2025 11:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMvarayR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EA62EC08E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 11:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341273; cv=none; b=dJUtTLyX/2ZIAy2G4j9PPaUoDn1B6B1fqYNkrBov1Fs2eFTtlO6TEtvt7bXuHTxDNwocchc91T0xDhKDMbP2UjMiKz3Xer2WH11VWimlWmCvhE1J5a1pQ8vMcjwEJpqHkTR0qlxJX18CTq8OY7sT/qDbVZ5/FYT/VEOy3PVJt0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341273; c=relaxed/simple;
	bh=Jy4/pQIGMv6ouvKeaMvAaVdAit3SYqxr21RQJFEBS9c=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UjvRS3DOSf0CVkJ088w73s5X+pZIJ00ySRVuvjWmz78lyMaVly74BqAdgWPymYqwe7r7p+dIQ0x83zQDU3m6OwDxuYYSmcK0ampE7sJDciH03a+Y332q0rGdfw2V+EP3BbT5whtO5HppyK9deYPUTGLbEQRFjzaQ07Mf/XKzNm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMvarayR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404DEC4CEF8;
	Wed,  5 Nov 2025 11:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762341272;
	bh=Jy4/pQIGMv6ouvKeaMvAaVdAit3SYqxr21RQJFEBS9c=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=GMvarayR+VvpDw5CWp2/Wj7iPJZdttohLNlXgZkINDoPrkSQl1qraYdducma9qf2f
	 1OSwN8y5ksmzdAKrvJnbNmKtKHDNjSgcjzqexlOkUuRC/URVUuIfCrvZvt2XVylQnc
	 I9KzbpgtTM1G3yQIoVSDRYu/wjeltrCWMo62ARs3/7LF6s+BwTQzbUNde494wco31H
	 lTd1mTWs5ptfHPLce+m7D11S6U/2EiUSXdXige4GhpaeiNEQYzkUfBxmpCTE2P6d9t
	 oNmtZheyGoT2aJUGiq9NehCsyvaN/m2r/Sg1+d0QwcyNISjRVNF8EyyHgCStSUvbrB
	 vqltOsI3d/LhQ==
Message-ID: <c101d5f4-f53b-43e4-959d-16c74a99eca3@kernel.org>
Date: Wed, 5 Nov 2025 19:14:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com,
 linux-kernel-mentees@lists.linuxfoundation.org, khalid@kernel.org,
 stable@kernel.org
Subject: Re: [PATCH v4 1/2] f2fs: Rename f2fs_unlink exit label
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1762339963.git.zlatistiv@gmail.com>
 <eb59e101f0b201afb65cb40b38e1b1598039ac82.1762339963.git.zlatistiv@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <eb59e101f0b201afb65cb40b38e1b1598039ac82.1762339963.git.zlatistiv@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/25 19:09, Nikola Z. Ivanov wrote:
> Rename "fail" label to "out" as it's used as a default
> exit path out of f2fs_unlink as well as error path.
> 
> Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

