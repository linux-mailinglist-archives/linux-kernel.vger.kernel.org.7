Return-Path: <linux-kernel+bounces-746365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 428D3B125CD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0628D3B01C8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC1E25A620;
	Fri, 25 Jul 2025 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UvHIUo2S"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA67244691
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753476546; cv=none; b=B8J9Jmyw7Q+j0yyx48aVrpsvoyBZs99pfjogTQUkHW+8fD8bskPgu65YpUa8j6qxL7FOUn18eSrNWyRwR4iXDsgx6ujSlORLPvPj8ka+AoA7seSZ0/Hwti9ea2mBSjO/ICrW3aE9PWTQr2tGmXDE6lYmvIW2eUyo0Ff+zd7BRUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753476546; c=relaxed/simple;
	bh=lyxZL2T6toBw8OY84aCqoZTXj6QaFAi3cQGkFOnokFM=;
	h=Date:Message-ID:From:To:Cc:Subject; b=tlZtzviXDEa9bks9VJ7UQ+tKTxGD6EiPd4eSYMWqk+FFvvOtrA6VTizO2bRVKbU2e6vFeHqnHuECu9pY1DhbE5z6+PTabwvUyhsR+NcelvE3KV3ta8Jo+mjl9HjQbFlvU6h0fmGg1iIOoSCZ01ZLrMFkvw5CNOKpJdvIGSR/RIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UvHIUo2S; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ab81d0169cso32375271cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753476543; x=1754081343; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1M1cP+MULrl+CVh37saJ8iMa6fKqjPBOJaZIE1vokI=;
        b=UvHIUo2S+WISoIRRefsIbvjJbrQKhHj7z0TTzrCsOAecC3dpveDS2Bm/crYQ030btH
         9CGn7dBjNBG0HQh06G1BFfsqKYb+nc43KGK5wi/Q6aB8DpavxKo7h6LNxYuAKDFm4/pk
         J9KJKKlp3Cfi2+tTlcVwBh9RbSXmUTD59gbaXRoGTImEKIVKh67CiJKut8XfOtrxkgWW
         iVPYRi7wib3y+GT/nBtpuPzcoccCejhmtsp5wMV4Z3iumjhAPkhf/HwGh8y2qQBv3wjb
         PbT6hAb8dx6OSW0wrnG9UAOWxEyPXPNkcXD1eZ2yNT3CcKe53EBuS0KLA2R7rLj7y+1O
         2UvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753476543; x=1754081343;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1M1cP+MULrl+CVh37saJ8iMa6fKqjPBOJaZIE1vokI=;
        b=IAhMr7NPLuEJgWSGdGtayPwHomHe6RWME9cyetoXeX4T0sTJyt1xHqFsIqUCtihuvq
         vcNk6Q07kIqD60bj0kEHWfgfEWBZV/ARvb1lMvHW3smnXfqeEz3L5GsUkrSrRMiYuASx
         Yxk1P5N8ZAmAjKS9YKTO0N4cI9uHCJwsMZ1serQQpbaIW5kQkaMtyMyWrJb00GseiCXX
         43Tqp2Q1uYW9QUgIyQeEMCHMUjKoHeOx4ZxEqSk4rF9FR53ICVonFaNyUCEz0btCEv/6
         w+X6RA7Jk7NkxtFM+dQ+ndAxLJljMyxJ1Xdwxrk2lGuaukbpgmVYxa22sWvsMW+mQBTj
         e2ww==
X-Forwarded-Encrypted: i=1; AJvYcCVE+J/1CJ+jKSmvi6wpt+qC0QvyXbIymOwpSmLYIhwOosYw14z0Vu7bgQDFqbuO6DgLjPy2UZrIJ3fEceY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg19sd3zAgPqdqLFHNcYrQDlhdM56cAU1BWtW7Cme4jgfKhhti
	ae3YXZ6IEDwse07NDIgcW6aUTMYcNVfQG+YAekMiX87HBsqG8snz9Fh2SCI+/QD3Ww==
X-Gm-Gg: ASbGncvj4vGK029FAW3G3Qo0Ouccb0TrYFAGJkyNCk9yCoDAoEhErY4PeqOLMixJuB3
	oW15rWFHt0seyah6UEe5aqjAiFo3KR1Vp4vbHR/XtEvJTa9mHZCbGcngNkM3fWWB4qviMOgzKic
	9BSE9srwvmUTJsBDNqTd6NOAfOqqqej90vUhcQrxajJlxUYAaDZ8LBwC4YHbTTGMtgO37kxRlEF
	+f5VKVo+38t6Dm3KSWd7WKeBsWg6EPE/PFLFDQtNQfgROnyqWo2YVfePq7xq18So33vbJ/qdKMl
	X+DR8uuUCEldEAEZjS0664F5ocb5keA9g9E6Xymp2YyYlIF1NM+O62OiBNVKCD6/EUpH1HzLaFO
	qd5ettKmPus74OhRTr5M+lVPbt2iwlK/hhYchd9J5yqQNT8zz3uVKxFJOPeIN3F0cJOk=
X-Google-Smtp-Source: AGHT+IFPs/TGlyud/MH4FHrsKYoh28z2RodeIQw/4AflnPEY0g0M7yhSEjwOWkUQozucxcIuEV+dkg==
X-Received: by 2002:ac8:5a53:0:b0:4ab:62f0:3ba3 with SMTP id d75a77b69052e-4ae8ef33304mr35631521cf.16.1753476543456;
        Fri, 25 Jul 2025 13:49:03 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4ae9969335asm4245661cf.61.2025.07.25.13.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 13:49:03 -0700 (PDT)
Date: Fri, 25 Jul 2025 16:49:02 -0400
Message-ID: <a981f40c12a45fe974beb197fa7b86dc@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20250725
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Linus,

Three fairly small LSM framework patches for the upcoming merge window,
but I wanted to mention that this pull request isn't based on the usual
-rc1 tag, but rather on a VFS merge that happened shortly after -rc2 so
we could pick up an important xattr/LSM fix.

- Add Nicolas Bouchinet and Xiu Jianfeng as Lockdown maintainers

  The Lockdown LSM has been without a dedicated mantainer since its
  original acceptance upstream, and it has suffered as a result.
  Thankfully we have two new volunteers who together I believe have
  the background and desire to help ensure Lockdown is properly
  supported.

- Remove the unused cap_mmap_file() declaration.

  Included in the LSM framework pull request with Serge's ACK.

Paul

--
The following changes since commit fe78e02600f83d81e55f6fc352d82c4f264a2901:

  Merge tag 'vfs-6.16-rc3.fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs
    (2025-06-16 08:18:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20250725

for you to fetch changes up to 5d8b97c946777118930e1cfb075cab59a139ca7c:

  MAINTAINERS: Add Xiu and myself as Lockdown maintainers
    (2025-07-10 17:56:09 -0400)

----------------------------------------------------------------
lsm/stable-6.17 PR 20250725
----------------------------------------------------------------

Kalevi Kolttonen (1):
      lsm: trivial comment fix

Nicolas Bouchinet (1):
      MAINTAINERS: Add Xiu and myself as Lockdown maintainers

Yue Haibing (1):
      security: Remove unused declaration cap_mmap_file()

 MAINTAINERS              |    4 +++-
 include/linux/security.h |    2 --
 security/security.c      |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

--
paul-moore.com

