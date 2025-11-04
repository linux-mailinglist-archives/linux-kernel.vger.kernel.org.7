Return-Path: <linux-kernel+bounces-884384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F91AC300F9
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3A518916EC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01B12AC17;
	Tue,  4 Nov 2025 08:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2vlQQ6x"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C3B15CD74
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246001; cv=none; b=EPp8lu8o8/wKIxUVu6mQ3gxelGbvVJN/Eoe+1smxIyaQLH/FfCnhliYArRhT/VuAUdElvkKo3tknoOVduX375glWJ9Xg6vlIgYBrhi+gl2G+Iya42ISkkMlmLuplfQkB6RPk2Z07spcOgryNWB7JTjW9Xqp/EDJskvikHL1XYFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246001; c=relaxed/simple;
	bh=ElckniwCkRR9OspymP+wD+dOygCeLor/HhB1Abe68Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IJNILXy/n+KdhVEK0HfiNNS7NXrQc4izt4Ht2/hQQcFDH/TCpzozec3+Xjh1lxwpaY9/Bmdnguu/8xhKRHBYQXKIX6HFirzKciKG5xDvLAm6szm/DgkQPBH0YAzYveXwdq7EFW7dJ9ARz0grm+pSYs3DxT2pty9Avx7Z0LWI22M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2vlQQ6x; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47755de027eso2225075e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 00:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762245998; x=1762850798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RXqY7SpktVETsfwyWDIsUXpt3grfqqVeE+nZmdbKIDw=;
        b=M2vlQQ6xfvkxA+WZOcQ4Bwq38eaUjIp2DLoMVpkyueYl4xKtRH123f9WhT4O4d5Xps
         NSGb9SunIuuuZVi4iW6qE1oQo5zmxxCPvNbXHBwiN4H4+4T2eQxm0pRn6r2TiIVwaUsg
         YFLDFJsGjDefGd+6NjsnAHrfuuLAviDznlr0R6YD0+65sLIJd1WcYf1V99whgQ02XRJC
         LokoQWWInmaF90ba/oSPyzqWuYCXem+3ykmwzPQ6pdaBx2nhpTndcuRjsWO6WvKzERdE
         +5et00+ze7y3tPEkrXWUYltCsvSGGPyHw35nJ79oUvhCvU5cugjDQb5xk+BMTVKfr4AN
         7Slw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762245998; x=1762850798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RXqY7SpktVETsfwyWDIsUXpt3grfqqVeE+nZmdbKIDw=;
        b=rnkmTsT37Ddbf3iN/WW0WrlHYqPQFV1yAO84SyYPfQRlVZ+sJzMk+ZPlws//K8uybe
         k15OsolMVhPeWcLDUfJXCnaLSZMiMSOsG+Hvm+uah4lsfQaDX2cXy8DUE+oPVhE2B6zD
         GTIV2+bZDQIw7UEt68Cm0EIMA2BmEI8x44pWjBJd9iRlzLzAhngjb+KfuEEtfipXvh06
         yUTvo5PYdMH3HrGBJoEL1tYu9z1YOthWFdfvKfSgHSigEE1UAFioypW4T0U66O1746H5
         WEDqB56u16DG8nhzYg0x0BF8um0D6euRmh7BQtJdvThSuccNXOo73QemWY1Fl9lu1mzS
         oNpg==
X-Gm-Message-State: AOJu0Yy40W55OoAzM3xtM6Tufp718ZutYo8dAaoo/gu/CCVWu981cloP
	r3MnLIBEE85K5bV/U9dU0UXxMuQCmGKblSAcS21x1wSc4+eBCERDdXPD
X-Gm-Gg: ASbGncteANjGXOd3MgLhrhZgFAvIs3ucmpkpDdg4s5FA1SferYa1KXUlPebN5UxLvC3
	zPPmNWgUxiUMZoJ25BopjDlLe/HnGVxzoqvFFU1Rdy+0LNved0vC/QhVxmrpAqghl9p5nej40uy
	WKL4dy068xmhw0CgQjbwq+CgQW57hFmjZEzqVGUNi5C1bXmECuLb+RZwy43D+u9hCfiZioXEt40
	V+AMYhcaD/0XvQXtErgM+xYq6W54VkYbxyfoXdk4OG4ibhFcGoQ1WKAfGc4SDfYINPvxIIJmuoG
	t+1gU883KoP43EfCsRLQKLmRBW71fhXM4QetZoerbZX4QGgXjPGYlEdHA8GZuhNv61AHRbNBxqh
	n4N5gI0H+xTmbLzVacqbOm9A/vzPMA7guHHY6MQYlSoTGH52I/C4YGZZmOy6ujWIahktcDFQN4S
	uZ8r2SQnjXEF8=
X-Google-Smtp-Source: AGHT+IHHhUl9Ud+xEn5Gnt/Mc5v3hcvcv7RyFxR4dOxpzt0xz7nLGm9rMaCxa0muEll/2oeYbMw0sA==
X-Received: by 2002:a05:600c:5249:b0:471:1717:40f with SMTP id 5b1f17b1804b1-4773087259amr138572865e9.22.1762245997577;
        Tue, 04 Nov 2025 00:46:37 -0800 (PST)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c394e33sm200375535e9.13.2025.11.04.00.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 00:46:36 -0800 (PST)
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	khalid@kernel.org,
	"Nikola Z. Ivanov" <zlatistiv@gmail.com>
Subject: [PATCH v3 0/2] f2fs: Add sanity checks before unlinking and loading inodes
Date: Tue,  4 Nov 2025 10:46:18 +0200
Message-ID: <cover.1762184787.git.zlatistiv@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is provoked by syzbot warnings caused by corrupted directory
inode with i_nlink == 1 that passes the initial sanity check which will
only mark the filesystem as corrupted in case i_nlink == 0.

Tests:
- fio/fsmark parallel create/unlink on VM with f2fs root filesystem.
- syzbot

Changelog:
  Changes from v1:
  - Rename exit label in f2fs_unlink().
  - Add sanity check in sanity_check_inode() and remove it from f2fs_iget()
    as suggested by Chao Yu in order to detect on-disk corruption early.
  https://lore.kernel.org/linux-f2fs-devel/d4b7c03c-6554-4407-b823-aecfcdf7dc3f@kernel.org/T/#t

  Changes from v2:
  - Remove i_nlink == 0 check from sanity_check_inode.
  - Wrap i_nlink == 1 in unlikely() marco.
  https://lore.kernel.org/linux-f2fs-devel/1f519357-a489-41fe-8159-a8e319aedd17@kernel.org/T/#u

Nikola Z. Ivanov (2):
  f2fs: Rename f2fs_unlink exit label
  f2fs: Add sanity checks before unlinking and loading  inodes

 fs/f2fs/inode.c |  6 ++++++
 fs/f2fs/namei.c | 27 +++++++++++++++++----------
 2 files changed, 23 insertions(+), 10 deletions(-)

-- 
2.51.0


