Return-Path: <linux-kernel+bounces-813104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB4DB540BE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19DF5A640D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580412264C8;
	Fri, 12 Sep 2025 03:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cal3f4WE"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BEE3597B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757646430; cv=none; b=M3JSe3OyMEDCW3vjtgqKUPfFp5Wpp7UnK9P2DmPqbkwAclQQF1GvMyyw0j7GLd3EHXJJ1HGrZc5pIaQvWOQBVztFcf+giPWowxyLsvOVtkS8o53Ez+bXCon9ukBEfTPMzD+sFQLRFJPRLFQaz5zjaU1vvHjTgWTB4m1xET1sQIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757646430; c=relaxed/simple;
	bh=IfF/hI9lhmkpYCouTi4ehbxXGIBbx16OJD14AfpkqXY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AwB97+RzBAAEnh5dGM1JGBjbbUKonL/RsKpAwlHe+QTtQlGJMl9FMv+w9mRECIEEq9o5S6JJh0rdHpB48O+PNrIT94dx8b75pXScrVfyr9Z5PHwyCZPXgrIsa0FsVDsVyACkLkzPP+yP4ujQAjx4A8q+XDETnHHvX+k7O/mkaD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cal3f4WE; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-722e079fa1aso14560126d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 20:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757646428; x=1758251228; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nT8Y466Uxi+WHOhvi7Em/wp+AvYruQ2l8K6jEQK6cFo=;
        b=cal3f4WEwrPri7JLpV5mELMDJGzOkPGGJKa4n5/6KYrM+nCLOOhYpBVCBWNYqbK6o6
         Xmj8fuz8EUvtAPxUKpUHDFbkO62JIVcYen4K2bCTbpvGhgVtidqhqj7w0P/4hg5fvpXb
         XrktCwVtt6RMNDpazhX338QChlzKAZWWzd8Kmz8n0kDHrYYqau22wW3dojKayc82hVJ0
         lmjCJF0IUvzH9dh6/bPSpcZ8JezQYxXVie3c9OScvvVk5QsG1xr4w9H8fLu6gYhtbiBd
         xjNtum3FVjpq/wqDJy0++8sOw6zLIH6HIXWdTa7z3tHCD90xC0PalV7YXg4/YamtfeN7
         Zgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757646428; x=1758251228;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nT8Y466Uxi+WHOhvi7Em/wp+AvYruQ2l8K6jEQK6cFo=;
        b=Uqpc3nIoVTj60nFeO9YtX6NI+CPRsyNJhSmlobQa3+l9CtFS/jt87+MrEKIxK17GzC
         S7JbOTqpsuxlCNvT6h8XhEY9NxWPYIrXWTZfOceIIGqN4tmuXX9NRV2sEhtBKBgLcJ8k
         B4ZodHi9+ifLpS0bgjerKz7qUwLbWOBpDBoYSBVa9CnrMtCw425mRvt3ov8ZYv5nvgpm
         Dmh8/3rHKndTOhBaDN5IhctVY1h5AzHuHhcUULmWXvnJG9/oOTvR3R0pWTuw7h8aBsZL
         H0W8Ty7iytH2dFYTk5KP4M+4ej/W/9MZrRfwFgHYU7HjckmTW6NBJDA5LHuP2+lnGo0N
         eAiw==
X-Gm-Message-State: AOJu0YwKcK0oBDPXgtLHxHpKnk85xAy9RAfwrv3nxvqz7ZN5xRPSFNKt
	GmPAFChuyDCSiND+hekftGDDl4iCyWYo6ROmk47/4J0OLu2onK4TRkCndt4SzU4U+edDsYGPJKR
	65Hnbx+HwKWWTzmiTYBHDecjzt7vQiFc=
X-Gm-Gg: ASbGncurbNLf8hU/mgrlsJEcXh6zV5Aq0wQ/ERwN+U8SBT/Uo4XmEnuiS/jQe3wxprp
	F6iVt52S2+leQmZVQT0pm/WpLK2q+7NjBrW4+vZpGoQEPXXNnrOjz/9zupdhvWOH5mgRptO1X1i
	FC5mtlxf6C3vbWNUAFOB5chdMlq3z0o4689dRAlZag1pmjrfCIuRExHEKGL7zpdTwM3BvmWzuZS
	DLXts4oO0sgr79zneKREHBQfvSDEWM8p04hDXhHygGuO3lgIJQj4+Rw4SSG4z3YIkDzoZcB21RW
	slpRiZqiR9IwJOvch/uXfdI7TKw6Lpdbc0fnC22ZWUOysm5KGbIbZwpBwtPPlZFPMsjAnTykvcS
	4
X-Google-Smtp-Source: AGHT+IF/yMtPWmsvOyJI97PAV8q1eS7/H3+F6/EEhH6Ne7jU0CDWHGKFau1VtqIwSlIwhZJcLUxO8YgUyJh3kSTJn74=
X-Received: by 2002:a05:6214:1d24:b0:70d:fa79:baf0 with SMTP id
 6a1803df08f44-767c1f71e51mr20165386d6.38.1757646428228; Thu, 11 Sep 2025
 20:07:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Thu, 11 Sep 2025 22:06:56 -0500
X-Gm-Features: AS18NWAzmGzBaUXHsLEBDRX5cmmgqXeSIlG88se-7P2p7Q2LtZ1MM64C6LXorIY
Message-ID: <CAH2r5mteAcfR8sgQuCEKHxWn2H32BEQ0pJcTuiRmAs4Yo0dYJw@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:

  Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/v6.17-rc5-smb3-client-fixes

for you to fetch changes up to c5ea3065586d790ea5193a679b85585173d59866:

  smb: client: fix data loss due to broken rename(2) (2025-09-09 18:39:58 -0500)

----------------------------------------------------------------
Two smb3 client fixes, both for stable
- Fix encryption problem with multiple compounded ops
- Fix rename error cases that could lead to data corruption
----------------------------------------------------------------
Paulo Alcantara (2):
      smb: client: fix compound alignment with encryption
      smb: client: fix data loss due to broken rename(2)

 fs/smb/client/cifsglob.h  |  13 ++-
 fs/smb/client/file.c      |  18 +++-
 fs/smb/client/inode.c     |  86 +++++++++++++++----
 fs/smb/client/smb2glob.h  |   3 +-
 fs/smb/client/smb2inode.c | 204 +++++++++++++++++++++++++++++++++++----------
 fs/smb/client/smb2ops.c   |  32 ++++++-
 fs/smb/client/smb2proto.h |   3 +
 fs/smb/client/trace.h     |   9 +-
 8 files changed, 293 insertions(+), 75 deletions(-)


-- 
Thanks,

Steve

