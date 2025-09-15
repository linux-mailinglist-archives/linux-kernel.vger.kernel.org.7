Return-Path: <linux-kernel+bounces-816351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B529B572BA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4BA417C868
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCFF2ED845;
	Mon, 15 Sep 2025 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfJa1qXD"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A69C2E9EA8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757924397; cv=none; b=QajtGzh6vSBxV5+IlrfSpV6aM9LS82zLLFYBHZME6kztvnQzXN8R1zEi1f5rEmSJwu4RacRyNMbuZQMY2OK+YXYBp/ml/JqyKEXTvaEbJKLLoK2+u8cv0gyvh6RZ3yvgKVyJ++YurXk5zvaXItKVHJiRWBAo5XYjBcyL7Udvrtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757924397; c=relaxed/simple;
	bh=gvyVXDAN+PRAExWv2YFpEC6fbhrhU8H3L0vY5TSVLGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gr3uMM4uIujFOHwr6SqM2NXtLQ3C8+PE+nwa6RGF1BpPTnap63cVOcaygae8KiO8EYSayvEgOagXhFIIKeUv5RPzGsVeqNI/jy1oqwwY2W3//mpcP8okty4JH38E4GwWP0vFymkM8LpWxIMVDlKyxFyc180zhDxxZWOYvsY0nOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfJa1qXD; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-772301f8ae2so3611365b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757924395; x=1758529195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EXJupOmkIaxYSorJ/E2Lxs1az8QJSAWePObgIta/6Wc=;
        b=jfJa1qXDjRGCGIFTDFqeAEZLL1pPPSTZo1GOGv0MD2aKDgB+Bu4sQb0xwGT4oslWF8
         5pjuQbpI4taYvvbOPxSxkOeD1AUErGpfDFoi44aDaEf01fPu+fFyBXjdqZKEwMNj0p2Y
         kmVJeGqDOK+r7Mtgvc/SV+Og6qEBxWs+loN7+9nFKIxw3He11E9vrhFDVjXZawnKx8gQ
         3T60zYMhkZX1F/L8kx2YsTyWiG4sUyqBdSN/GQviY9uJ17hT9DFYypdfF5VpeAqXA4sN
         jyxePJ19oI5tvycF8FFS1WkNIJN9TLXDk1+Q0LxRTFK0B7t9DEZZBIt3jK2z22P18Kn0
         dK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757924395; x=1758529195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EXJupOmkIaxYSorJ/E2Lxs1az8QJSAWePObgIta/6Wc=;
        b=PWwi0thTGqyZFudoWGA01pGB7uONk56inmPfCY+S8JGxqI8eNXvUSbjiFA/V35C1V4
         zSmIOsXWwj1DfjXtMBpu2EtsaJZzb+D5UVgvxZMo/NEoHm5t13/mi2vXRswcBpvXr29b
         IfuzGe93DeLACXFGgqtAt1SKpCbxQDoTZtlqC+Wzbl3MdzzoObH6LQf5D6jCBwYhkBRN
         XiJz2pZ2F5G4SyAL1LsvkrbDWxMNn9I3fFUYuICOFDxY5Pdt4NkejHMPIR7LHO08arZS
         IxKGtgG+LLLdjisM2xy2oQmUhB5H1t7Q4gCMjKkDw27D+KHf7GffsqB4FR1BncWa/BI5
         Pqtw==
X-Gm-Message-State: AOJu0YxHqbMf92LvIaqj7mJRQlH8A2jXmLlX71t0URpCizkF2aofnNWJ
	9/cB/7ainr+OZnqm+yCn2iR3oM8s6LD3nuQbNe1MuYkk4dyBKoCpXklN
X-Gm-Gg: ASbGncs8UZ90ERVsUDmS0mUWX3xnHmZJhalwMp4xTpEzNNWfVcCkOj7RgzH8dw4+Zon
	r9hYvs8sCBKjorrjPYv7awywE9Jct4oBtNIWoXi9+ZXSXaz+zonC2dxcJR803jrVe93Hh29ZFU5
	RAWS96GZAu9mfoNfGVO0ef3KfDvJyHZUv91l26Yv5CvIg6xYtI8+PjvQ1nQftGxcGgLjZ5cYzr0
	l6rhGpxH7C0UekEjn4F2M/PG7PqyoMXfH9ruRCBfVgMTZuti5kadCh+RsjoO+GxWgDXCey854Tw
	jranx2UQAU8cuswxnJGfrXFlT8YioLerKp4WwMY22EhByx9Qye/7R/N9vRzjMM5uJgbvjQ3vHDq
	02XzWtcyRkouGzaXOA4MuElJsJBnn3N1RyBjO
X-Google-Smtp-Source: AGHT+IFaPTKZ5L7QGynopLRlymyt3sutrsE9UT7Flmj2NzAt7FTbK7sGSLueOqI3SFAEwnGEtIVHhg==
X-Received: by 2002:a05:6a00:139a:b0:774:2274:a555 with SMTP id d2e1a72fcca58-77612167d2fmr14310264b3a.15.1757924395491;
        Mon, 15 Sep 2025 01:19:55 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607c471dcsm12581782b3a.96.2025.09.15.01.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:19:54 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id BFF114209E9D; Mon, 15 Sep 2025 15:19:48 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux cgroups <cgroups@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	"Bagas Sanjaya" <bagasdotme@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrea Righi <arighi@nvidia.com>,
	Johannes Bechberger <me@mostlynerdless.de>,
	Changwoo Min <changwoo@igalia.com>,
	Shashank Balaji <shashank.mahadasyam@sony.com>,
	Ingo Molnar <mingo@kernel.org>,
	Jake Rice <jake@jakerice.dev>,
	Cengiz Can <cengiz@kernel.wtf>,
	"Mauro Carvalho Chehab" <mchehab@kernel.org>
Subject: [PATCH v2 0/4] cgroup v2 toctree cleanup
Date: Mon, 15 Sep 2025 15:19:23 +0700
Message-ID: <20250915081942.25077-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1542; i=bagasdotme@gmail.com; h=from:subject; bh=gvyVXDAN+PRAExWv2YFpEC6fbhrhU8H3L0vY5TSVLGQ=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBnHT+ftFawoT5Zt8rHS15fm4uvyO2PHpBQjnFv++hiP3 pSwLxwdpSwMYlwMsmKKLJMS+ZpO7zISudC+1hFmDisTyBAGLk4BmEjDd4b/KZ+jZZ235Ztdyb/8 5eBx69kaq3c+MefaYTIno+HLSbGXkYwMO45O5qncVfb4hM2CnGftDy+zfph+89v8m3enrz6QHy2 0nwUA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Unlike cgroup v1, cgroup v2 documentation is a rather lengthy single document
(Documentation/admin-guide/cgroup-v2.rst), although is not as long as KVM
API docs (Documentation/virt/kvm/api.rst). As such, it needs a roadmap for
allowing readers to easily navigate it: the toctree.

While plaintext (reST source) readers are delighted with already-existing,
manually-written toctree, readers in html format (including docs.kernel.org
visitors) don't get such luxury. Let's add reST toctree for them.

The first two patches ([1/4] and [2/4]) are section numbers preparation (just
as one would see the book toctree). Actual toctree generation is in [3/4],
and in the service of plaintext readers, also sync the manual toctree in
[4/4].

Enjoy!

Changes since v1 [1]:

  * Drop unrelated cross-reference patch
  * Keep the manual toctree, but fix it up to sync with actual sections
    listing/automatic toctree (Jon)

[1]: https://lore.kernel.org/linux-doc/20250910072334.30688-1-bagasdotme@gmail.com/

Bagas Sanjaya (4):
  Documentation: cgroup-v2: Use dot delimiter in manual toctree section
    numbers
  Documentation: cgroup-v2: Add section numbers
  Documentation: cgroup-v2: Automatically-generate toctree
  Documentation: cgroup-v2: Sync manual toctree

 Documentation/admin-guide/cgroup-v2.rst | 447 ++++++++++++------------
 1 file changed, 227 insertions(+), 220 deletions(-)


base-commit: cf9c2bbba2735831f1200227c7f13404b7d7908e
-- 
An old man doll... just what I always wanted! - Clara


