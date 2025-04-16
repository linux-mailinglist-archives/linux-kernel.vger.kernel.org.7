Return-Path: <linux-kernel+bounces-603831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936DDA88CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 22:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92CD017B657
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 20:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B911DF24B;
	Mon, 14 Apr 2025 20:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uHhTqbQR"
Received: from mail-ua1-f73.google.com (mail-ua1-f73.google.com [209.85.222.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ED61D86F6
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 20:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744661377; cv=none; b=OIUxBlO98UB4APRJykD5Eg0QXn4caNdAiwNNETYIHwl0TZRd+re2+sCYfcWLJm9wbETjJ6SXeA515Qk3UX2F8HKRgLrKeSj8PJLWNyYqCYozhX1t3f5HYxfAYPUEXpIz9iOPKzAMVZAVZMDEFM4a72pKoysFfuwTeSqsQZO+O74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744661377; c=relaxed/simple;
	bh=hoRuSec7O/gOBiU6cRGLKLi2QMX0P2yXAb5skEgMRFs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lN/yxXgxT6pa76wTKyFRSzefkHGIGGRznQjEZcloL8w1hI3SfL35oGIMFHbw0lZ7VK6TSpjrhHMJj2Z9A04Mm6rhepAOzDsjfTAKYjW6xfNlVDGeTRLGmze61a3upVjk+mVnzqqKErmQuLy27e73aejt6fYeQTFeecRRgp/yeKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uHhTqbQR; arc=none smtp.client-ip=209.85.222.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-ua1-f73.google.com with SMTP id a1e0cc1a2514c-86c428a6bd1so1532354241.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 13:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744661374; x=1745266174; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XiDc6SJ1mh8k7LeOCYg2CUSls9p4ca2akmEeWWUl1Eg=;
        b=uHhTqbQRrNvOIT6VQd3odKZQUlBFHdn4hqSHczNNhH6A1dNXCrZaHsLq7PidMnbF6Y
         FxvIQiblBGnJVMe69L7QbmH9Pe+RdXWH8hxx3iYDxkzKspywfICJnnWPfVdYuJ+tAmFd
         jcQzaQzu0Gj+lp3iC9ZO1l6NbXqnmOHXAdg0q87CxQ/eby361op4ChsGwOe9hFFBcIXe
         4sMceJVIDUA5kG4Mj04vxkYMxL3NsQxNfW75CJiHx0H6bPLb4FBC2dDlYyj0JBObYFXE
         J/cGiDVIq9n/EFTGg4R+r9o/gyxaindKh/0SVKIewSoV03AyLM9CSC6B5MmrIr9reb61
         WquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744661374; x=1745266174;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XiDc6SJ1mh8k7LeOCYg2CUSls9p4ca2akmEeWWUl1Eg=;
        b=jwgRPOD7Bc0bx5T6L6eQTc+SKCtsLVv28+cYIuqjyoXxGbLkiD/3VveO6PObaw/h1d
         p0VZ7kpgRHM2r8lCnvzhyzd12BWkLq9M9YcxHBLxqA8qIvx9dz5m7X092du295w+r8A4
         lk5Lrms+t3LUyeNc0OzzeS2fvQM3Pf4UZ7La6CimwjjJ0ldvuoghMaeWfimLyvkqfVqF
         LstVATT8w5aETjClwceqhdVAYpitO6h24/mrrOdpObS8qNcQQ964aNKIgLRmllN/LXIX
         nMHbvtBj8xnDibZMkpkeie3x003C/w8r+M6D4Sk2l7fy1pFOMPT390A1IUFjwaR8vJEM
         EJ+g==
X-Forwarded-Encrypted: i=1; AJvYcCVc9zEInouq1Z5WBtly1Cf3a6rGriWaod9EBdZQQvvbo82/FblS+D0BdN6cbYPNqhJdhHO4g0ScAXuTR7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZsaYKEMkn5cOi2SZ03v7EgGh40rqC456Gw9s25JUEvoTui4WC
	rTJ0xSwACgo0k0Rxblj5Ru8/sdsKM2x8YO5iwNirbdha/6v9yfxVNxqBQlZuyoBvCYeg4SYdX5u
	L+6uYMklsytCHIdemhw==
X-Google-Smtp-Source: AGHT+IGuo7be8B4P3vY9QtZ1/PAZEf8kgO8U0u7S6xaDlVa8vsy8+mgzqAfiaRZ78PdHRIFfm42L7C+ao9DegXPF
X-Received: from vscv12.prod.google.com ([2002:a05:6102:330c:b0:4c3:1981:80b])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:32d1:b0:4c1:7a08:9279 with SMTP id ada2fe7eead31-4c9e4f1f3d3mr8382414137.15.1744661374125;
 Mon, 14 Apr 2025 13:09:34 -0700 (PDT)
Date: Mon, 14 Apr 2025 20:09:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250414200929.3098202-1-jthoughton@google.com>
Subject: [PATCH v3 0/5] KVM: selftests: access_tracking_perf_test fixes for
 NUMA balancing and MGLRU
From: James Houghton <jthoughton@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, mkoutny@suse.com, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Yu Zhao <yuzhao@google.com>, 
	David Matlack <dmatlack@google.com>, James Houghton <jthoughton@google.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series fixes some issues with access_tracking_perf_test when MGLRU
or NUMA balancing are in use.

With MGLRU, touching a page doesn't necessarily clear the Idle flag.
This has come up in the past, and the recommendation was to use MGLRU
generation numbers[1], which this series does.

With NUMA balancing, pages are temporarily mapped as PROT_NONE, so the
SPTEs will be zapped, losing the Accessed bits. The fix here is, in the
event we have lost access information to print a warning and continue
with the test, just like what we do if the test is running a nested VM.

A flag is added for the user to specify if they wish for the test to
always enforce or always skip this check.

Based on kvm/next.

Changelog:

v2[3] -> v3:
- Applied David's directory fix on patch 3.
- Added SoB-by, R-by (patch 2, missed in v2), and A-by.

v1[2] -> v2:
- Re-add clone3_selftests.h for cgroup selftests (thanks Michal!)
- Some comment fixes, patches 2 and 5 (thanks Maxim!).

[1]: https://lore.kernel.org/all/CAOUHufZeADNp_y=Ng+acmMMgnTR=ZGFZ7z-m6O47O=CmJauWjw@mail.gmail.com/
[2]: https://lore.kernel.org/kvm/20250327012350.1135621-1-jthoughton@google.com/
[3]: https://lore.kernel.org/kvm/20250331213025.3602082-1-jthoughton@google.com/

James Houghton (3):
  cgroup: selftests: Move cgroup_util into its own library
  KVM: selftests: Build and link selftests/cgroup/lib into KVM selftests
  KVM: selftests: access_tracking_perf_test: Use MGLRU for access
    tracking

Maxim Levitsky (1):
  KVM: selftests: access_tracking_perf_test: Add option to skip the
    sanity check

Sean Christopherson (1):
  KVM: selftests: Extract guts of THP accessor to standalone sysfs
    helpers

 tools/testing/selftests/cgroup/Makefile       |  21 +-
 .../selftests/cgroup/{ => lib}/cgroup_util.c  |   2 +-
 .../cgroup/{ => lib/include}/cgroup_util.h    |   4 +-
 .../testing/selftests/cgroup/lib/libcgroup.mk |  19 +
 tools/testing/selftests/kvm/Makefile.kvm      |   4 +-
 .../selftests/kvm/access_tracking_perf_test.c | 263 ++++++++++--
 .../selftests/kvm/include/lru_gen_util.h      |  51 +++
 .../testing/selftests/kvm/include/test_util.h |   1 +
 .../testing/selftests/kvm/lib/lru_gen_util.c  | 383 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/test_util.c   |  42 +-
 10 files changed, 733 insertions(+), 57 deletions(-)
 rename tools/testing/selftests/cgroup/{ => lib}/cgroup_util.c (99%)
 rename tools/testing/selftests/cgroup/{ => lib/include}/cgroup_util.h (99%)
 create mode 100644 tools/testing/selftests/cgroup/lib/libcgroup.mk
 create mode 100644 tools/testing/selftests/kvm/include/lru_gen_util.h
 create mode 100644 tools/testing/selftests/kvm/lib/lru_gen_util.c


base-commit: fd02aa45bda6d2f2fedcab70e828867332ef7e1c
-- 
2.49.0.604.gff1f9ca942-goog


