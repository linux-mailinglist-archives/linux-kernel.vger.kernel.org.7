Return-Path: <linux-kernel+bounces-834791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D00DBA5871
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 05:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E5F94E10E7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 03:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43142222D8;
	Sat, 27 Sep 2025 03:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TxmI8HtB"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC562206B1
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 03:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758942465; cv=none; b=CqZ9ajS1pwS0TbAfCzv/NWRGUtFtruF+iVtNmau1xHd0P+zRqET3lMX133PPq8qyssVTI3hBhIHlrnQEiVEdXB5Gx3tvNh07iUYoHI/hhEcl6xduXDCkZXxTm0q9e1RC4hPhXaZaSaD5hbhdiO+K4457+RWPYQZLk5EOSueBm5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758942465; c=relaxed/simple;
	bh=aPobOO7WnjJZOB+RNqo/7lhEQ6V6+hKlbl399mJh0Uw=;
	h=Date:Message-ID:From:To:Cc:Subject; b=P+9Nj2Wy4smqF3unCu+cZyqQ1MU/d7Q86aCO4/3QsL965lQCOG/KwLE+T8jlbIospD5nSDYHXDyi72jBwTtotxLzQj2yO+ZppUE8w8YoIq/jur3sN6gSrVsBDkNoyTK6YD2VQzj7bPBF58zBsUunRgRD3f2oZf0EgOIqc9LQ7hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TxmI8HtB; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-7957e2f6ba8so26472396d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 20:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758942461; x=1759547261; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yp3lKOizHfbYQMLxItAPWev9U/XlTvHIGNeFDnSx3GA=;
        b=TxmI8HtBtDPF8hAzAWq+wEly+fQNvwU+ipQnRhXpBNRJRvMkkoqhwhN5aqySBGhiM4
         P9cddEjxVAL5oSPD2bukxQdWzo3fTUVlyDTP8ZGNiLvYSAAtXMH+H+CxiMmTgmjaRyB+
         uHvdBrVKje31+cEK6Z+No8BrDYOXXRV6CvNfHdu5kcanghVWJLMAB9VN5XXbKLCzyNki
         zwnb7f0KCBsCXV9EeCqxuh61PWtpxUZj8AGEwWjMkOeoNkY1rd8OxUjwjd2USP5LAc6k
         w3MbXEaUqIUeA7idg8rPKfdwBdWYBxS0rGoGyaiwq3FCsId/o4LsqyFC9jX/hIPwPEuQ
         KEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758942461; x=1759547261;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yp3lKOizHfbYQMLxItAPWev9U/XlTvHIGNeFDnSx3GA=;
        b=PLzZXXzkCR1DbFsPzz9DAsD4YQlGG6kaUKs2JFm+/k+3bTAYrYwZRkQHwmL5l2tvYz
         OyZBB9MjXI3MqZJ6KqA80Jv70bwVekB23CLBC7Km7QWobna3b4+OVB+fW1RT2L/SOuev
         y3fNIl0PzOUWGrj2uWd9CYi6G9bYi3LjyB5iHMXluEatNkvdPLC1gC7oSkZTuuIm0B0Y
         K/wpExnogJu7OyH81busvnGoo9xuYp9K6ElxW7C7H35rl1OPOHf++kLEkGCG4fcoiits
         LPfJ1KR7gzrGZhW0nAAoP8cUUxj2Y+GV3riOcU//L9nYvsgmZG4P1mFuutjBR/rfk2R8
         WOvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/1s7AuOpwB8AsUT/+Glcb7o0X/7dYN6pzzi0Ks7EaSz9EHA9Ag8pb6MgqHxhcdLx+54+TRZEjgBbBmy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9BoIG/EhKKJ7ZfcfsRKhVcZoeVrvkyGTntZV0I/cdX4fmQQ9c
	NR2rhSeg33H0IgbV5qsO1bhU0x3T0Ha3bSlMoOhIRq/YynvjIhLo7/3+LyVfd5Gf8g==
X-Gm-Gg: ASbGncsCIW53RdJbEdIs64IPceCsYq15M902vnHVOq1l4mvdB083tMpyqJV/UiaYLHz
	QopoSA8zgKoS6xDgvQdGsHinwB2yxS9mcGsVgdi7FPG5LUZbERjpjj1tXvocoB0PU0ajaKiuuKI
	t55XOsKUecoW35cXXk1BA99iEczmW8bdYEjkAlGBXnp2gftA4IoBZWy0Eem+9wLcmM3rPySKu2D
	kSHkwrvY59aefOzzeVteHlFHmetB9kqtrKhTIbZi+wpv8wSG1cOAVxipCApGaEjPbFcZWEDt8WH
	RTJrnk5OysSpY+zT0brcCSwzn01nE7Pa8VPyynYOqShqaaQjSubPp3EBDuGUtP1Y6nF8/vR0ZYf
	PuRS3/PhxSdOkAMivBrzATctI4jLbYPXWfNth38v8JBUUOZPw3+Qc1mkYjSA6DtHtIw4whwG3Hg
	aQvI4=
X-Google-Smtp-Source: AGHT+IHgpHHxgry3Lut9EVp65Mvkk+TNQ6IbpO4i4j4mh5u/pHY+SXg2VgTUPKyqxzQ+9Q5p8aATlg==
X-Received: by 2002:a05:6214:5294:b0:7cd:91ff:6214 with SMTP id 6a1803df08f44-7fc4ec01d2cmr132041536d6.62.1758942461293;
        Fri, 26 Sep 2025 20:07:41 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-80166e2f32bsm36429156d6.41.2025.09.26.20.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 20:07:40 -0700 (PDT)
Date: Fri, 26 Sep 2025 23:07:40 -0400
Message-ID: <1c4f33b7d1e986bb09ce18410200f91e@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20250926
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Linus,

Here are the LSM framework patches for the upcoming Linux v6.18 merge
window:

- Move the management of the LSM BPF security blobs into the framework

  In order to enable multiple LSMs we need to allocate and free the
  various security blobs in the LSM framework and not the individual
  LSMs as they would end up stepping all over each other.

- Leverage the lsm_bdev_alloc() helper in lsm_bdev_alloc()

  Make better use of our existing helper functions to reduce some code
  duplication.

- Update the Rust cred code to use 'sync::aref'

  Part of a larger effort to move the Rust code over to the 'sync'
  module.

- Make CONFIG_LSM dependent on CONFIG_SECURITY

  As the CONFIG_LSM Kconfig setting is an ordered list of the LSMs to
  enable a boot, it obviously doesn't make much sense to enable this
  when CONFIG_SECURITY is disabled.

- Update the LSM and CREDENTIALS sections in MAINTAINERS with Rusty bits

  Add the Rust helper files to the associated LSM and CREDENTIALS entries
  int the MAINTAINERS file.  We're trying to improve the communication
  between the two groups and making sure we're all aware of what is
  going on via cross-posting to the relevant lists is a good way to
  start.

Paul

--
The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20250926

for you to fetch changes up to 54d94c422fed9575b74167333c1757847a4e6899:

  lsm: CONFIG_LSM can depend on CONFIG_SECURITY
    (2025-09-11 16:32:04 -0400)

----------------------------------------------------------------
lsm/stable-6.18 PR 20250926
----------------------------------------------------------------

Blaise Boscaccy (1):
      lsm,selinux: Add LSM blob support for BPF objects

Paul Moore (3):
      lsm: use lsm_blob_alloc() in lsm_bdev_alloc()
      MAINTAINERS: add the associated Rust helper to the LSM section
      MAINTAINERS: add the associated Rust helper to the CREDENTIALS
         section

Qianfeng Rong (1):
      security: use umax() to improve code

Randy Dunlap (1):
      lsm: CONFIG_LSM can depend on CONFIG_SECURITY

Shankari Anand (1):
      rust,cred: update AlwaysRefCounted import to sync::aref

 MAINTAINERS                       |    2 
 include/linux/lsm_hooks.h         |    3 
 rust/kernel/cred.rs               |    6 -
 security/Kconfig                  |    1 
 security/min_addr.c               |    6 -
 security/security.c               |   98 ++++++++++++++++++++++++++----
 security/selinux/hooks.c          |   56 +++--------------
 security/selinux/include/objsec.h |   20 ++++++
 8 files changed, 124 insertions(+), 68 deletions(-)

--
paul-moore.com

