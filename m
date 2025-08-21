Return-Path: <linux-kernel+bounces-780395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC45B3013C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00CFA02254
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781AA33A010;
	Thu, 21 Aug 2025 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llqYODL/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB662E1F17;
	Thu, 21 Aug 2025 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755797872; cv=none; b=kMaWPU3mCZWpu7KTe4jZNBDo4DQVjP1SazwCUpmq3wETXdf39IVsybXuMPPiTyLWDg9rawVei1GQ2uI6LA00Mv5EEnbVYZh6Nrhw4krVNxZmEb4SMBoVgNQMbaCdEOloBP2vJn2FtxppA4vGlLJv/v0PduhhapBGtw0U7O4by4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755797872; c=relaxed/simple;
	bh=j4paEgwz2ck7L/uXa3mD5VBiDcbgbkEUiQjCpLZq09E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SvpBephQFZMts8kFWVOXfLwKVZxvcgAbckKleuAruGIf41jmThV0lZNJZZFFxdeahOIqbs5iLaT+CE//h0ebO0s9jB2Tj4s4ACTK+iOcov1IpASewTbeP+yDDm0lHU5SuckSR2uZ+NxQ9dznvaDVct3vyltGbc1j4dwTSt6Am3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llqYODL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B7AC4CEEB;
	Thu, 21 Aug 2025 17:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755797872;
	bh=j4paEgwz2ck7L/uXa3mD5VBiDcbgbkEUiQjCpLZq09E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=llqYODL/1g6OyaZHDHwb4iMXZnHSz3neZVSxAHdFoXCgBjMeROCh/WWqauUii7e8h
	 Fj3CanA9uDAK4Ef0yjVRxLGUFQOM9gOaYkuGTf25FapHEUrCuDU+WagKsO0wVeeD2I
	 ty3LSzFkfpFSX6TZR2EnACFwJDCPKjgROQdK3dcW3uHZjfNvJw0iTQBagOdnv12fQT
	 P7wHmT1DP6vIzXmLwA7P+UZFPq4nzI9DA9SNjHjrOOdg2HzW3x4F7wHtNWleBqlQ3e
	 6iynS5YGFFuMtF/xTv9lfdBqDC+QhIVoMK3usLIE1yDBxj4wPWwJbIrJjo98nqkSFu
	 gwqEZAhrJxqYg==
Date: Thu, 21 Aug 2025 10:37:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: Re: [GIT PULL] Networking for v6.17-rc3
Message-ID: <20250821103750.252c2126@kernel.org>
In-Reply-To: <20250821102721.6deae493@kernel.org>
References: <20250821171641.2435897-1-kuba@kernel.org>
	<20250821102721.6deae493@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 10:27:21 -0700 Jakub Kicinski wrote:
> On Thu, 21 Aug 2025 10:16:41 -0700 Jakub Kicinski wrote:
> > Hi Linus!  
> 
> FWIW I'm hitting the splat below from random code paths (futex, epoll,
> bpf) when running your tree within Meta. Takes some time to hit, IDK
> what exactly triggers it. Could be a driver tho I can hit it on two
> different generations of servers.

Looks like it's this FWIW, so it's known
https://lore.kernel.org/all/68a2decd.050a0220.e29e5.009a.GAE@google.com/

