Return-Path: <linux-kernel+bounces-746366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDAFB125D1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598C63AF067
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75E625B305;
	Fri, 25 Jul 2025 20:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KgornxXM"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4AD255F52
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753476571; cv=none; b=AS3n/ZpKnw9mXHjpGJ4Xk/TkV/v3LE9BnV2nwnqcOnUq0Q5WqFKQDgJKenYB+Z8ckHqd6o+IStuka6+gs/oljaHVi02TO6xxKBMCe/P/OwsSZNioXIqeB5hodiXluSGZQaFPLWTxL+U3MSxVGTR8FgF331zPsL7EXqtAu2uHZ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753476571; c=relaxed/simple;
	bh=ROdFTJiGd5/GLp4z8lMfSmyZbwS5owsCw58X/jelgDU=;
	h=Date:Message-ID:From:To:Cc:Subject; b=a/M7EH+6c63SlhTYcomsydY10KOLKfjcWOJ+lqfnogIWS73Juyf45ZAsSuIH54EdjFaapVI5Zyh6zH8folRBBvydMRqOROv5rPrwB+3WPwzjvAzWXe+AUOcCMeSBCo4FmeX+gLZHKrjM/eM65T70C6G6W69i+DZuR+wpYoq+x7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KgornxXM; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-702cbfe860cso22231246d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753476568; x=1754081368; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FkTgvWlgVmQ5f7CUc4jJgwLNzq3m1FsFuj0gNddDPA=;
        b=KgornxXMfRYsP03LtjWqTZsaan3uxIm4rDU+sq4UaCZI80JJPM0aRHRQrT5mFIieJe
         nQwpGys0WjkZFkwicEYCXFHx/cZUi/D8qeSZXZb+nSG1W87Nb4hiGpXLTq1n2o9rR3T2
         ZX5dd0Or7ue5b9O7hKcZh6MWbGtvbU0W7EmTKe9prcoOXIkJwmjlH20c01WrsLZxmP3R
         wq+ieH0HvA8U8VP+r3d6X5DLD0FPc+JlCh87Hb7uPP6pa9DV82qwPjucKfqL/qkVqVy9
         TbuNm6WiJlTyNtPGQ5bCAXAR3HvfcMAthSL+MX2Hkgb7wf/Mjbb2EoiAle7A0gMGk/aQ
         a9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753476568; x=1754081368;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FkTgvWlgVmQ5f7CUc4jJgwLNzq3m1FsFuj0gNddDPA=;
        b=UdsO+bS4BUC7cXUKE/jKjNwvlLFLnjLL2Q2qP853tvaFWayEm05Iq5/BhTjQih9x/V
         n4+5du/J+VCq8kCBn1sV863FKfq6kA8JFxMMlECFoQKxYXxXbTnXzU5mh3I9bikQaOT4
         BfEsdnjfllWmkQDb7JsbCzT1eMhQbeNPp1lu7FatLXWz4tWqkZ2G77MZq8y6WBs2CxcH
         bIuC/G8xko7OqIweNvpH/OF+LpsSzdjaiG+Q67yxIEjGqkrDDzKabvVQhdrIbsDt8P1C
         YLjY6RFUC6N33hnfLm66m7pxnqvUyD9Y4exsZA1LLDHKadqf7aAZ/HC/YLJPLGdDmvw9
         /yoA==
X-Forwarded-Encrypted: i=1; AJvYcCVmddYioeEkkS0E0LtTo6aVCdEz8UjloWQQJo9DO6uK/9pxJdLs6aOqT43wzeSczb7ir3m0Ma7ZTn6Hnmk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/b2oEHK/5G4nEqKnMl8YWzXOm+/f1SnFgf15J2hLlfxFCnniG
	PP2S4nKagB3wKYJOcWEEqCCyKtShaVsPYtXx6ZoOCT10u8eLoOHtE++DKFFr0qFTUg==
X-Gm-Gg: ASbGncsxSNmj3YSEk62tzXnIC69sJlpeuF++22fB219fIqATgpnKudcu4wOImQi/bcU
	NRHQzRZfvNnabJdbyilIObEFAPXtpx2Ci3OZHUCfwxy6oLk0Y2l1Eez81jgdxui5HT5lwRU/rr7
	a8bhb/NjSzAU04ALy6epA1JZ5Se0CQ7CaWI4JpcD3G8n0prHkltG5mkLRoUPczl7MdnUeZX91XJ
	njB8k8SL8YlYE+I4H3xHOdKg88xBPlHyMZyVRktPshwLr50YKDgcOc3cwhaz9rGx22Auq8fdFlk
	Efczy8qP7YNx3D0Or8tC3TSZqMEavE0+3rHLUNr4fi55bawlaQ7ZPcIz3n7pqmCy9XVI4iJqG81
	96+YcCAQBEX0C01Api9piOhEIzciSkPQY3Ow1lIS+t7S/xoyC8FSfTjIJmfhLU1LCXjw=
X-Google-Smtp-Source: AGHT+IGZjdXnqtxButa1Ssw869Og0wrfY516fhkT7Po12uDx1Dt5t8zMGMqQJq1ZQ3TwTXDsIoGl0A==
X-Received: by 2002:a05:6214:767:b0:706:c9df:8f84 with SMTP id 6a1803df08f44-707204f5ac1mr49798896d6.16.1753476568338;
        Fri, 25 Jul 2025 13:49:28 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70729a04ce8sm4555716d6.19.2025.07.25.13.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 13:49:27 -0700 (PDT)
Date: Fri, 25 Jul 2025 16:49:27 -0400
Message-ID: <6e344a8bd7d60522825222628e949a14@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20250725
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Linus,

Six SELinux patches for the upcoming merge window, the highlights are
below, but I also wanted to mention that this pull request isn't based
on the usual -rc1 tag, but rather on a VFS merge that happened shortly
after -rc2 so we could pick up an important xattr/LSM fix.

- Introduce the concept of a SELinux "neveraudit" type which prevents
  all auditing of the given type/domain.
  
  Taken by itself, the benefit of marking a SELinux domain with the
  "neveraudit" tag is likely not very interesting, especially given
  the significant overlap with the "dontaudit" tag.  However, given
  that the "neveraudit" tag applies to *all* auditing of the tagged
  domain, we can do some fairly interesting optimizations when a
  SELinux domain is marked as both "permissive" and "dontaudit" (think
  of the unconfined_t domain).  While this pull request includes
  optimized inode permission and getattr hooks, these optimizations
  require SELinux policy changes, therefore the improvements may not be
  visible on standard downstream Linux distos for a period of time.

- Continue the deprecation process of /sys/fs/selinux/user.

  After removing the associated userspace code in 2020, we marked the
  /sys/fs/selinux/user interface as deprecated in Linux v6.13 with
  pr_warn() and the usual documention update.  This pull request adds
  a five second sleep after the pr_warn(), following a previous
  deprecation process pattern that has worked well for us in the past
  in helping identify any existing users that we haven't yet reached.

- Add a __GFP_NOWARN flag to our initial hash table allocation.

  Fuzzers such a syzbot often attempt abnormally large SELinux policy
  loads, which the SELinux code gracefully handles by checking for
  allocation failures, but not before the allocator emits a warning
  which causes the automated fuzzing to flag this as an error and
  report it to the list.  While we want to continue to support the
  work done by the fuzzing teams, we want to focus on proper issues
  and not an error case that is already handled safely.  Add a NOWARN
  flag to quiet the allocator and prevent syzbot from tripping on this
  again.

- Remove some unnecessary selinuxfs cleanup code, courtesy of Al.

- Update the SELinux in-kernel documentation with pointers to additional
  information.

Paul

--
The following changes since commit fe78e02600f83d81e55f6fc352d82c4f264a2901:

  Merge tag 'vfs-6.16-rc3.fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs
    (2025-06-16 08:18:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20250725

for you to fetch changes up to ee79ba39b3d6fdcfa53de6519d7e259e284e78f7:

  selinux: don't bother with selinuxfs_info_free() on failures
    (2025-06-24 19:39:28 -0400)

----------------------------------------------------------------
selinux/stable-6.17 PR 20250725
----------------------------------------------------------------

Al Viro (1):
      selinux: don't bother with selinuxfs_info_free() on failures

Paul Moore (2):
      selinux: add a 5 second sleep to /sys/fs/selinux/user
      selinux: add __GFP_NOWARN to hashtab_init() allocations

Stephen Smalley (3):
      documentation: add links to SELinux resources
      selinux: introduce neveraudit types
      selinux: optimize selinux_inode_getattr/permission() based on
         neveraudit|permissive

 Documentation/admin-guide/LSM/SELinux.rst |   11 +++++++++++
 security/selinux/hooks.c                  |   14 +++++++++++++-
 security/selinux/include/avc.h            |    4 ++++
 security/selinux/include/objsec.h         |    8 ++++++++
 security/selinux/include/security.h       |    4 +++-
 security/selinux/selinuxfs.c              |    3 +--
 security/selinux/ss/hashtab.c             |    3 ++-
 security/selinux/ss/policydb.c            |   19 +++++++++++++++++++
 security/selinux/ss/policydb.h            |    2 ++
 security/selinux/ss/services.c            |   20 ++++++++++++++++++++
 10 files changed, 83 insertions(+), 5 deletions(-)

--
paul-moore.com

