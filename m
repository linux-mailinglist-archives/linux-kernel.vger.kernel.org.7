Return-Path: <linux-kernel+bounces-675559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 791C0ACFF72
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 11:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61023B1C4D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 09:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962982857D5;
	Fri,  6 Jun 2025 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="czIXUc/X"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9231F4701
	for <linux-kernel@vger.kernel.org>; Fri,  6 Jun 2025 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749202781; cv=none; b=cC8ZwM374b1v6VPG5O/Mlkm2DxGdGl/c7iJIdnLtEe7y5ShCmU+sKe8hm8xGwwj4oclzzXZWSwETg+Dby3bVwU6Zthdksr12XAmofOB1dKj5MhDm6L+7v31PZfB7ddfXQic3TVMRQAk/WczgMbCmVm5Ua8TVa6OmesXUocsvECY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749202781; c=relaxed/simple;
	bh=N9gt6zoeOojtVaBP1jlkmM2TL467uVikZEZwQ9GbU2k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RfSmBd39iMorRNVnc4shv78yKkUEgXXTwZzHuksSV8WfDqye9CbVSdcsRogXzSTKpYLtqxshH4c3hZ45dH4VgMC6Ycakz3HLg88yvQHJLq6Tx3+a4ZQrbi3dshbS96iPEDHpDBC/wSCWTseB1Lm+UJn9v/6X7HtOiXBt3g4kBwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=czIXUc/X; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a5840ec53dso22388791cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jun 2025 02:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1749202778; x=1749807578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tPFP4ZmRAhjJ4I3wEZwmt/w3eZJoSPjBDwx/NSazgHI=;
        b=czIXUc/X6IcDpUOA3IeEWcwJMdXR87FSYsf5ixCCWiLNSx0kMQWKuXOOc+l8f17ERN
         hQ41vSzEECLEU99+vsNVlAylbqd35o/yPNwcNy9N75OSqWTi69PL2nxbGPEcVp61PN+/
         ChGwVsZBiKuG/G9s44uLpKp+eT2Re14ssbP9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749202778; x=1749807578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tPFP4ZmRAhjJ4I3wEZwmt/w3eZJoSPjBDwx/NSazgHI=;
        b=HaA1fo8HbH8PamZhxWOT4k8sZgfoXyq861VxrwOQfWtOm0pCYWNDavB4ab5kJqyKcC
         ZitdmI9waKnrXEFO+W7Llfd/flanWwSCA5uHKtcJjWuZuhdqLaFJ9HHFZOaE8+dspac3
         JxtQF72qf6WPYS6Cls7amgsYGD5VvtXdNFA3Q+pM04J/rYpVX6iIrp6ts9SY5sE3wUaX
         iHigzG5mHO83i/xoLzy3r/RLnIUv6zxvYbBq1/d2OnBrlkJwA/4r+ZgvrC/inhPPpSBS
         ZpORt4C6Q1EfGliEKRAEandd6yoYvJXHK+Xcl4PjXFemCJkEGNNd5hsVGBSWB5K53JYo
         BNSw==
X-Forwarded-Encrypted: i=1; AJvYcCV0NmINkKLcEVRLTJCXLBjwrvcEMsiSxoOZPOxiG8JRJVqJhyiVRi5CrFxee748oFBD0Gl7KkK2tYbO2Xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YymXmIfQo1/o7xvLF2NgpYnTrtpwgDU9ayvsMZ11Rarc0/w/Fm3
	SZ69GDDoWQVnMy9bA5B273Czf8wu41gfqKF2WuXpRkifuT3xaGHpEGwZSm9Agw5os3mHNJKmxOo
	GkXQgtJwql2Ahqp7HNDMQs+a1qklQ5uy0x6comRykLQ==
X-Gm-Gg: ASbGnctFFQb/KQNFAUs3ze4Ec+2OgNeTba2g3mC/byQm6jD2rTHdDuNGe9EvBev4Hy2
	gZJaJbiaDqJ5zAd+NRw3gm9Os0cahM4jLcNleoqUR3uaBCuxq0j+mxWxAPKWsnSXZMl1pLH2HNi
	GhhyhjPm0f/gIRJHpeoX45Lst+FS7ZA1dlE2ipswxuClU5TkUmMOmn
X-Google-Smtp-Source: AGHT+IHI9ky3s76fSv3Zu8lWTiZqJ/uarX5vedd0MSl6G+9c+iOb+o0VwnbkevaSB0b6iGykHy5yDFmDXJLp6vQ0kM0=
X-Received: by 2002:a05:622a:4010:b0:494:a495:c257 with SMTP id
 d75a77b69052e-4a5b9e21cd9mr45032831cf.17.1749202778321; Fri, 06 Jun 2025
 02:39:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 6 Jun 2025 11:39:27 +0200
X-Gm-Features: AX0GCFtZRITQRM4IxzsfgyjT1CJY8JlGN07qklEcnKGJyagr2TeGe-HdyBll-OI
Message-ID: <CAJfpegssS_nOs1T+LTZBY9afFcmvpQH3gaSEph0NDx4neXNGRA@mail.gmail.com>
Subject: [GIT PULL v2] overlayfs update for 6.16
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: overlayfs <linux-unionfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git
tags/ovl-update-v2-6.16

- Fix a regression in getting the path of an open file (e.g.  in
/proc/PID/maps) for a nested overlayfs setup  (Andr=C3=A9 Almeida)

- Support data-only layers and verity in a user namespace
(unprivileged composefs use case)

- Fix a gcc warning (Kees)

- Cleanups

Thanks,
Miklos

v2: dropped constification cleanup

---
Andr=C3=A9 Almeida (1):
      ovl: Fix nested backing file paths

Kees Cook (1):
      ovl: Check for NULL d_inode() in ovl_dentry_upper()

Miklos Szeredi (3):
      ovl: make redirect/metacopy rejection consistent
      ovl: relax redirect/metacopy requirements for lower -> data redirect
      ovl: don't require "metacopy=3Don" for "verity"

Thorsten Blum (4):
      ovl: Use str_on_off() helper in ovl_show_options()
      ovl: Replace offsetof() with struct_size() in ovl_cache_entry_new()
      ovl: Replace offsetof() with struct_size() in ovl_stack_free()
      ovl: Annotate struct ovl_entry with __counted_by()

---
 Documentation/filesystems/overlayfs.rst |  7 +++
 fs/overlayfs/file.c                     |  4 +-
 fs/overlayfs/namei.c                    | 98 ++++++++++++++++++++---------=
----
 fs/overlayfs/ovl_entry.h                |  2 +-
 fs/overlayfs/params.c                   | 40 ++------------
 fs/overlayfs/readdir.c                  |  4 +-
 fs/overlayfs/util.c                     |  9 ++-
 7 files changed, 84 insertions(+), 80 deletions(-)

