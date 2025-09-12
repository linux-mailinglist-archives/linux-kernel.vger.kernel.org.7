Return-Path: <linux-kernel+bounces-814835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09655B55924
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 00:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B351B5A3FC9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 22:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B67286D62;
	Fri, 12 Sep 2025 22:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fj2GwCDE"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357AB2741C9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 22:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757715943; cv=none; b=oA3gzaGisBdXXLlgNv4hJ0AS/pCC6f+gl1cP2mk41wKN+TlA8jCbhazRjszMJjY11bjzw5AwPowDP9bfOX0RKmdDQy758rYyZO9oVg1j8Mu7zlI4GeLq8CuE5Pup8JUolfB2Ov626OFfQIZ2SjG6WAOvxlQs4V/6FHNN7XbZug0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757715943; c=relaxed/simple;
	bh=kK67gOsMKdnTk8XfJvCFmZ1AgZVmladu8chilWBm6No=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ug2n+h6p4IVJuWRS4O0c5M8hLHKI6mhUTiSIg5shxXFVh5GynQmvuTJjqXrAWxebqC1j//iL1+UF5UcOp4FMv+X2BptdDho59R4l+dT8lZxUN1Poc7gQCL2pCc4HmSI5ZtuNIKo78lurcfZnIQfcCgguPLNR4KDACwHZMDrEq88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fj2GwCDE; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-80e3612e1a7so401650885a.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757715941; x=1758320741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pzZnnPEt3bRj9xxliys6aMLfk6CSAaQd8ndI256Y7tQ=;
        b=Fj2GwCDEF42NjL5js8RIKxSdYKFiwRb5qkfg6dTzNVdpHb1HkMIPrurM/TXlmoIKMO
         /Oj5r3RUe0Ute1cDJPaWSsNGEuEfwEusmmYfuogCbILQeeMPGEW1zV4M9rQS1R43MNjf
         Y+CouY+I3Ypeg8fzOFzGEmuvj4Z+6yjWr/024m/kqueLMYR90yp/gtx6afy7zgLZpPAo
         iHUVEaG+m2OR4TBndXtGSrv5M55BzIUxEZEZFugth11wkY+bIz/fcWKwuxjGbW9g65Ac
         K45FNKjYs4kPn7fNcMrLoT/GMRDT2HOBrywdW6+qzKeBrHBPHAHA2qkpLRHdhy82PnnT
         cbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757715941; x=1758320741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzZnnPEt3bRj9xxliys6aMLfk6CSAaQd8ndI256Y7tQ=;
        b=mXhOiSgcOLkJ5F07EpOG9weI3wZdXb6AxI8vBbLuzxHKO2QgfMJn1hYt0uqU2hDJz7
         uQ9zcbmlSxWpkKqqiquP72vEiaM8524b7ztZcGg3FpbiEJ5X+z34liscAktCNJYKdCqz
         d3qk7pZ4cqSjhzwru2HP34qtpC+b7pRJ5CvlvFD/nGYNHJIuam8ouj1SrN4KyybF9EEa
         COWsOGUXa72NgtCgFGZUJ3lr2+uruFgCvWkJJDw70+WBW25TURlAkoabn7+b1+pnfvBN
         Hrqv00e24QtlGN2Q9qU53ioqOa/N9czpN+VI+uYcbAZbJV6myCMgNI2cQMEktUCO1cWw
         67VQ==
X-Gm-Message-State: AOJu0YwgAPRDhL+slXB6lhyBISPreHXRYTFoBfSSqwn4hcxs63kSK2GX
	05CqkpUCSaSLZI9btf7egpEhFrxszl5Nm+moBJFLYOuUHVM4jP8s+tU/
X-Gm-Gg: ASbGncsh6aug5HX1IWtW1r3iMCUbVFpjHgIETksUG61Sf3VBtq30zX3ilv3rrzr746D
	ANKrp2qFk/CgrgHd7GIVrTC8BxL8fLKK0V/CAu7NN9T7y//bcW8wqIw+kG7lFg4RZ7F/mc5nXgO
	6BB17rSHi3YVmF5clMN5XHcHrYBfusukbUdOSGu+Wn7BJTArjvgF8/XBIbVHUgDqRb7R0a/aEzz
	a7NUydxGgue3lhD3L5LC/nURjF2jsrK6J9TPsFxbyaosqNsqAAinxliti5KGbhxl4WTbaP0nad/
	okfgmfybbtXaUuTqRnx6nAfH9w/nNcQtXbMmpCmg+HXxqonwk+xOp8/6RKoi+JyO7II/0lWMk+N
	CPbbvvWl3M6qJb90x7mvHQC7IZkkOcCXQHwgYk/mWEYTfa2ye35AQjQT3FxLEaO2H/GmiIFni9H
	nUdh7P6atCUilH6/axc8xQ5pOu/jbjwcqA1obb8aroUJo7pnNc
X-Google-Smtp-Source: AGHT+IHDnmgT2LntxCPaqHLYhzHzjBtnWhONEJnC/8/CEs6lbcLFbVpRT6CWOfWsSwot3fYuSD9/uw==
X-Received: by 2002:a05:620a:3185:b0:826:c5c8:7cca with SMTP id af79cd13be357-826c5c87ccfmr82561185a.24.1757715941058;
        Fri, 12 Sep 2025 15:25:41 -0700 (PDT)
Received: from kerndev.lan (pool-100-15-227-251.washdc.fios.verizon.net. [100.15.227.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820c974d635sm339136985a.25.2025.09.12.15.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 15:25:40 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	dwindsor@gmail.com
Subject: [PATCH v2 0/2] bpf: Add BPF_MAP_TYPE_CRED_STORAGE support
Date: Fri, 12 Sep 2025 18:25:37 -0400
Message-ID: <20250912222539.149952-1-dwindsor@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds BPF_MAP_TYPE_CRED_STORAGE, enabling BPF programs to
associate data with credential structures (struct cred).

Like other local storage types (task, inode, sk), this provides automatic
lifecycle management and is useful for LSM programs tracking credential
state across LSM calls. Lifetime management is necessary for detecting
credential leaks and enforcing time-based security policies.

The implementation uses kfuncs (bpf_cred_storage_get/delete) that return
bpf_local_storage_data pointers, with map values accessible via the data
field.

v2:
- fix kernel ci build error

David Windsor (2):
  bpf: Add BPF_MAP_TYPE_CRED_STORAGE map type and kfuncs
  selftests/bpf: Add cred local storage tests

 include/linux/bpf_lsm.h                       |  35 ++++
 include/linux/bpf_types.h                     |   1 +
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/Makefile                           |   1 +
 kernel/bpf/bpf_cred_storage.c                 | 175 ++++++++++++++++++
 kernel/bpf/syscall.c                          |  10 +-
 kernel/cred.c                                 |   7 +
 security/bpf/hooks.c                          |   1 +
 .../selftests/bpf/prog_tests/cred_storage.c   |  52 ++++++
 .../selftests/bpf/progs/cred_storage.c        |  87 +++++++++
 10 files changed, 367 insertions(+), 3 deletions(-)
 create mode 100644 kernel/bpf/bpf_cred_storage.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cred_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/cred_storage.c

-- 
2.43.0


