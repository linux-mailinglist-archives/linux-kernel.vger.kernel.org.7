Return-Path: <linux-kernel+bounces-797226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B4AB40DAA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0271B60C0B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D580B350835;
	Tue,  2 Sep 2025 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgvQZoaO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260B42DC354;
	Tue,  2 Sep 2025 19:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756840176; cv=none; b=KTNnDHUjCTXgT7FWZi2kCMZ51n5v5v8Th8bKhO2GlKo4V1bFZNmW7PHOAxkH9C5QNTlo4aL+WMb8vmVWj7Dbn+pLyuyejZMZAoSV54vEFTaji0Y4xQsTfxNRfQEH6hbeo/fTjIoqEfCSAxdF+eM3Pt+67aB8QrqfaZutxRSmUC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756840176; c=relaxed/simple;
	bh=oG304Ugt3/o47tknnNcGSuFp6YiA53Miofy+wEi1nb0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RW0K8gqq+oCd9WAmIDnLYI8xz9EbqpMD369Ha+5SrfNbIeUSMESQ3d8xaGPSElWaqb/WpAmZ445gYephOR425lR7sygHApZGZ0Zu4OhqSJMh4qWReE3IYfXuY96zJP57ZIciO39UGV+teEoY4f2C9ck4kZZfZBsv+mu2AEWPlKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgvQZoaO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE457C4CEED;
	Tue,  2 Sep 2025 19:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756840175;
	bh=oG304Ugt3/o47tknnNcGSuFp6YiA53Miofy+wEi1nb0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HgvQZoaOijVassugQcZmMJ0bi/JhtHBlGQ9aVei9sDUXySTkfcn8G+/aUaEBhpvNG
	 lwcZfbv+RTngpzqwXg/fULcdUgvol+QM9RBVzEBWumCSFUJiUJ3AV/Hai8H/q3yI6R
	 OxudGVxl1VUe3NUYizFQMHfRjl2c9B1vK6Qt3iWexdd6DgLW9lqX4jej9rzppXwlVv
	 mcNdTyJjSX+qhBkABSCz8rWEIaqKEUgN7+8O1/LCd17oCRCxQz0I30xgEdoFcejsTs
	 iw202/E/BCTM2TWw0VyrNeKC8U/EtY1OyLi55MJVK1d7nGNpC080dqYq5gY4PkMrbU
	 lg4XO9+H3BOjg==
Date: Tue, 2 Sep 2025 12:09:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, Geliang
 Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, Eric Biggers
 <ebiggers@kernel.org>, Christoph Paasch <cpaasch@openai.com>, Gang Yan
 <yangang@kylinos.cn>
Subject: Re: [PATCH net-next 0/6] mptcp: misc. features for v6.18
Message-ID: <20250902120933.5dbd61cf@kernel.org>
In-Reply-To: <d5397026-92eb-4a43-9534-954b43ab9305@kernel.org>
References: <20250901-net-next-mptcp-misc-feat-6-18-v1-0-80ae80d2b903@kernel.org>
	<d5397026-92eb-4a43-9534-954b43ab9305@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Sep 2025 16:29:33 +0200 Matthieu Baerts wrote:
> On 01/09/2025 11:39, Matthieu Baerts (NGI0) wrote:
> > This series contains 4 independent new features:
> > 
> > - Patch 1: use HMAC-SHA256 library instead of open-coded HMAC.
> > 
> > - Patches 2-3: make ADD_ADDR retransmission timeout adaptive + simplify
> >   selftests.  
> 
> I just noticed that NIPA reported some issues due to these 2 patches. In
> short, some packets (MPTCP ADD_ADDR notifications) can now be
> retransmitted quicker, but some tests check MIB counters and don't
> expect retransmissions. If the environment is a bit slow, it is possible
> to have more retransmissions. We should adapt the tests to avoid false
> positives.
> 
> Is it possible to drop just these two patches? Or do you prefer to mark
> the whole series as "Changes requested"?

Your call, we can also apply as is. mptcp-join is ignored, anyway.

