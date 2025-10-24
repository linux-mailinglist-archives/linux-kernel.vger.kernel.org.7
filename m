Return-Path: <linux-kernel+bounces-869546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4693C0822A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 22:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 982FE4F0CC9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67612FC002;
	Fri, 24 Oct 2025 20:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Af2gGJIM"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD7A2FBDF1
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 20:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761339540; cv=none; b=S0s3goxZLJAroBDQSpsZUGdwmvB4YflWEQmsTsl6hcS7RGvHgYDkReFw++nFp6o2IlhYnegD3gjMVMwOwMWFiBQnkgno57Nqkic2jhIBQKROOUmq2FxsgNkyVmGqiF4hScrGEcOp1O5cGTRnHBiCppD9ShDZfVFPqoAPvrzo2CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761339540; c=relaxed/simple;
	bh=MEBUe227OCEBOWr2feOWQXaa+Nd3mudaBH+QFkyTpcg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ru9UI64ZPg/vY94nLoNh8Sf01u5wOh5OX90aN1bHx26/sw6S+g3502GuQarVhNzZ8IuPiyiac4wlezBkrp6t1XYD79gJt8YwtQ6VQJUCJ6MnBzA3WmZRFOEhj/7H9a32aRFvHW8JODMluoM8VC2NhkHxLVj4xcOjqdpRTtUqgo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=Af2gGJIM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4711b95226dso28109345e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1761339537; x=1761944337; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtLfn8FJtqlvARmUmpRqk3iH9kDF4BPeI9fdVEa1U6A=;
        b=Af2gGJIMTy9oY/F/8ImKOWRaSS7XLAJehw6SLZTCyOOUBKBEe8fiYap6jCHw6/K8lP
         eGNhtFO+ZrbUWCfrBlPkpzkRDy9OGNJw3wsLcb33A4EOKNfPm5n83Q1lePQNQYzkGSbD
         upEjTfcs31mHH1F7CfiAYr/LCtNp0aN2VWCUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761339537; x=1761944337;
        h=content-transfer-encoding:content-disposition:mime-version
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MtLfn8FJtqlvARmUmpRqk3iH9kDF4BPeI9fdVEa1U6A=;
        b=Xn4wdMA7kg1HvIqH2Gb8V+Ac81eVboNQlYLEmf5fviMgy9OCzitaqj/sTr5faahj3A
         HaMzXIAY0Nt1v6vkN0qjv0ivCLPG1+FmOI8lTSb1E0KQzg3aaySbBssF0xrdsSpesps3
         AYUwoSZms8qo/c8dMsBMvpjcL6uzmodNXZaja0En0HyjzwWEbOXRPYvtF/ChmlvSdjkj
         P1m2j+XH8YM4aKqqWNm2GD5pO6Uhrqj+DLq5xsLflQQnw0bdMAqKfBEKopqhMGJr3DIm
         wsz2BoaOhGI9WhLlQ5jNR168fSEQkdA/DDult+7NTUH8P4IvpDfxOejR4GJjvj1ODeK/
         awsw==
X-Gm-Message-State: AOJu0YwsLJe5cvrC55L8nGTM4qMMpm+BgFDMzBvrJFs8qjRBTDQjzSbi
	E0lEuxr5a/2ZT1ZZQhnKE0qswwC2RiYT/ZpeY/COK0iqRCJYF0K1uzRmMD0+p7lh+mk=
X-Gm-Gg: ASbGncsR9pHszJur2AHESnUk5OtSkdUn7CZa2XUW5u/2+/ZIcaC9mPmaE4OJ8ngQLWu
	3fI42AnZk9wHXCZHcW7s8PetvHJ4zgIz1MqM+Qq5I6+1HpHqigS4ITa8WT9g4/gWMKP6433PerJ
	X5lv42UT1UG6IWUnthoyEnQfudsSlMnwgbczmy5g6lCIzCpV9G7YXlz8h8q7KQto25lXAXngNY2
	W5OoNgSNWDqVZDebnynoO9sX0riK+1gOU0rKDoMbmm20RPEmGuiuIOeYIFXvOAKq2nqrSEKw54h
	FDfWTMBFicIML0jjup6DhMI2sOAvMldMtI+IPP/LsucAw3Cy02cWoZPDZdXg1nRCYiqlQL5U5lh
	Csv5aSdRGqU5f0T1tcID4yWcT44U6G4N1VRgUYgW5vCRMTE/NCV6ZPculotK5mNdKt/y5T6E2Hk
	6gBWcJILiX68u4VVNBffsvBQ==
X-Google-Smtp-Source: AGHT+IFouaNi4btVpzaPutAtdKRahw851DTPgHr7NokdJllOOD6EswA132FiLK1g0REt+rMNyIvegg==
X-Received: by 2002:a05:600c:1d9b:b0:46f:b32e:528f with SMTP id 5b1f17b1804b1-4711787639amr215959405e9.5.1761339537409;
        Fri, 24 Oct 2025 13:58:57 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd02cd6dsm1540155e9.2.2025.10.24.13.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:58:56 -0700 (PDT)
Date: Fri, 24 Oct 2025 22:58:54 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	DRI Development <dri-devel@lists.freedesktop.org>,
	Dave Airlie <airlied@gmail.com>
Subject: [PULL] drm-fixes for -rc3
Message-ID: <aPvojo5uhoAatX2Y@phenom.ffwll.local>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	DRI Development <dri-devel@lists.freedesktop.org>,
	Dave Airlie <airlied@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Operating-System: Linux phenom 6.12.38+deb13-amd64 

Hi Linus,

Very quiet, all just small stuff and nothing scary pending to my
knowledge.

On the Link: tag discussion there's now an open MR for our tooling. By the
time you see this it might already be merged, so hopefully starting next
week we'll see patches show up in drm with the new style. But it'll
probably take some time until it's percolated to everyone:

https://gitlab.freedesktop.org/drm/maintainer-tools/-/merge_requests/94

Cheers, Sima

drm-fixes-2025-10-24:
drm-fixes for 6.18-rc3

- drm_panic: bunch of size calculation fixes
- pantor: fix kernel panic on partial gpu va unmap
- rockchip: hdmi hotplug setup fix
- amdgpu: dp mst, dc/display fixes
- i915: fix panic structure leak
- xe: madvise uapi fix, wq alloc error, vma flag handling fix

Cheers, Sima

The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-10-24

for you to fetch changes up to 18b1ce0b29c41833363b58ad030b76dabf984899:

  Merge tag 'drm-xe-fixes-2025-10-23' of https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes (2025-10-24 13:39:21 +0200)

----------------------------------------------------------------
drm-fixes for 6.18-rc3

- drm_panic: bunch of size calculation fixes
- pantor: fix kernel panic on partial gpu va unmap
- rockchip: hdmi hotplug setup fix
- amdgpu: dp mst, dc/display fixes
- i915: fix panic structure leak
- xe: madvise uapi fix, wq alloc error, vma flag handling fix

----------------------------------------------------------------
Akash Goel (1):
      drm/panthor: Fix kernel panic on partial unmap of a GPU VA region

Alok Tiwari (1):
      drm/rockchip: dw_hdmi: use correct SCLIN mask for RK3228

Aurabindo Pillai (1):
      drm/amd/display: use GFP_NOWAIT for allocation in interrupt handler

Charlene Liu (1):
      drm/amd/display: increase max link count and fix link->enc NULL pointer access

Jani Nikula (1):
      drm/i915/panic: fix panic structure allocation memory leak

Jocelyn Falempe (6):
      drm/panic: Fix drawing the logo on a small narrow screen
      drm/panic: Fix overlap between qr code and logo
      drm/panic: Fix qr_code, ensure vmargin is positive
      drm/panic: Fix kmsg text drawing rectangle
      drm/panic: Fix divide by 0 if the screen width < font width
      drm/panic: Fix 24bit pixel crossing page boundaries

Matthew Brost (1):
      drm/xe: Check return value of GGTT workqueue allocation

Meenakshikumar Somasundaram (1):
      drm/amd/display: Fix NULL pointer dereference

Simona Vetter (4):
      Merge tag 'amd-drm-fixes-6.18-2025-10-22' of https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2025-10-23' of https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-intel-fixes-2025-10-23' of https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2025-10-23' of https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes

Thomas Hellström (2):
      drm/xe: Retain vma flags when recreating and splitting vmas for madvise
      drm/xe/uapi: Hide the madvise autoreset behind a VM_BIND flag

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  4 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |  3 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h  |  8 +-
 .../amd/display/dc/link/accessories/link_dp_cts.c  |  3 +-
 drivers/gpu/drm/drm_panic.c                        | 60 ++++++++++++--
 drivers/gpu/drm/i915/display/intel_fb.c            | 25 +++---
 drivers/gpu/drm/panthor/panthor_mmu.c              | 10 ++-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        |  2 +-
 drivers/gpu/drm/xe/xe_ggtt.c                       |  3 +
 drivers/gpu/drm/xe/xe_pt.c                         |  4 +-
 drivers/gpu/drm/xe/xe_svm.c                        |  5 ++
 drivers/gpu/drm/xe/xe_vm.c                         | 96 +++++++++-------------
 drivers/gpu/drm/xe/xe_vm_types.h                   | 10 +--
 include/uapi/drm/xe_drm.h                          | 15 ++++
 14 files changed, 153 insertions(+), 95 deletions(-)

-- 
Simona Vetter
Software Engineer
http://blog.ffwll.ch

