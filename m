Return-Path: <linux-kernel+bounces-836728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C41BBAA6F2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 21:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16B3C1C5D17
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D2A245014;
	Mon, 29 Sep 2025 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuKiQe2N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAF8244677
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759173025; cv=none; b=l2iGxPSe+6y6qrnZwEoq+zbuyUrXRfhfwrC8FIYenz6/eov02cMJqW6ZruNw4wzY3HMOi8f9ijkLriOyaazGK9FOov37A/Vcq36OzJC2f4u+BE4AQ660KhVgcNIlyi60IWvJd2FBCSEOwyzOtLLWy2f94HxJBFz//i/na/uTK3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759173025; c=relaxed/simple;
	bh=WC13JX3jF7GAGIt3wBKiRUtpFRFWQgsifIsM9n+40bY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DSYuwv8zBibpwY+I3pBbpXcbVdeWX/c6C7dvq9kYOVDXiMuE5BsygK/YDJCusltH5emdb2lnz2oWK26Scf89ctTipTGUQCqUp34c9T8x/UiMBYYgnAqi6h6RBcYo+vB2TYMnmXN0TUDAepjCiYdVbRGMzaRd7afiE6hzaE4b2G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuKiQe2N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31857C4CEF4;
	Mon, 29 Sep 2025 19:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759173025;
	bh=WC13JX3jF7GAGIt3wBKiRUtpFRFWQgsifIsM9n+40bY=;
	h=Date:From:To:Cc:Subject:From;
	b=nuKiQe2NkYKa/K0N+TTBLGSc3Xu+7AXFZ6YBi5YOhO2RA0ucK3SHXNrUco5EUryOV
	 m5UjvVx0dFS9v9AYCX4U1RWjpG7OBN+e9XUZpI8r6aTvHAg5y9XcGWr6Bn9TOOVYqh
	 Kr8I+p4nPsPPWhQkBfvuwYRn54E2wrAeW9FKcfAR8wvrbUdH8mhqQEjPFzPz8NlJ8b
	 djt1FM0SqdJW3lTosCvSM8x8JRkVb2AkYDqqss/yoUAFsXYYXOt16Qi5+Am6UPg41I
	 CZb0llwOQyHSBoMVcSvLca1t89Dm+TIiFiLzXT0xzwy2cIAsQLjhsGlmakQ6n7Nwl2
	 t3ioMNzrd8x7Q==
Date: Mon, 29 Sep 2025 12:10:24 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Eugen Hristev <eugen.hristev@linaro.org>,
	Kees Cook <kees@kernel.org>
Subject: [GIT PULL] pstore update for v6.18-rc1
Message-ID: <202509291210.9BBE978@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull this tiny pstore update for v6.18-rc1.

Thanks!

-Kees

The following changes since commit 8ffd015db85fea3e15a77027fda6c02ced4d2444:

  Linux 6.15-rc2 (2025-04-13 11:54:49 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.18-rc1

for you to fetch changes up to d679c2e1e8d96f71f85e2ef3877407d264212cc3:

  pstore/zone: rewrite some comments for better understanding (2025-05-09 12:09:58 -0700)

----------------------------------------------------------------
pstore update for v6.18-rc1

- Clarify various comments for better understanding (Eugen Hristev)

----------------------------------------------------------------
Eugen Hristev (1):
      pstore/zone: rewrite some comments for better understanding

 fs/pstore/zone.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

-- 
Kees Cook

