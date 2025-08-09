Return-Path: <linux-kernel+bounces-761233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C66B1F5F2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 20:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA481624890
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 18:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD201F30A4;
	Sat,  9 Aug 2025 18:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VTOEWujO"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9879812E5B
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 18:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754765935; cv=none; b=luGm8/Ao+6uTV5tXR1os/skKkBTUys/MCgMUoImjO2UvIpdou2iLTLfSTJ1QPSESSBFQL2BXg8q9MBQcrSLujX49uMVTVx9yLaEaN8HIj7BcEFaUJDzEZ7vxjmejxvGLP8AdVC8rRZDmyluKSYmUqN1lwKuEllmV7E8F/dH9I4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754765935; c=relaxed/simple;
	bh=T992w3/2j3B4chrxA1XfMiV/tuX+wgZfSIPLNdT8ZFs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dSGUMjJVoypn3d7GchDw41VteaRU5HLE0P8Y8zikoyAO+omBiXbfVPDr+V3vCLnDkz/z7aVgBf+5EU+S1+tIrosBBP1e3i0DO2214EO2sZDRMlJISRsw1da0sP1jcO/Ag9Q8j8IO5njakgdHSH/2ljGTCnAsVd0RowDgHt4z3hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VTOEWujO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C52F940E0191;
	Sat,  9 Aug 2025 18:58:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qe-i6MTIltVG; Sat,  9 Aug 2025 18:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1754765928; bh=WUSmsARBuH/1IGseH27lUIoaCYyQkR5MZa7MGFsEC28=;
	h=Date:From:To:Cc:Subject:From;
	b=VTOEWujO3MF7gglCurfj3d1WhM7F4Ide2R2GndlZvqGu/5VgKWeI9Co0yebEiNw7c
	 gSKQ3iXASfQiFwrljCgOQdCeQgnsKPseH2E0tJzvUyRQ/fitR+34ij9PmGBFVdafLy
	 Y5yutg0NjKmHhjtH/qbl4GeBDaSnTO38FU9jSIzbKSSc4SNyVHCcHD2yHsB5ica6AK
	 qVLV2BeKvCJKv3cYqUN3YiDXQSIHmcGy9RkMS3nmchHJju8o9HHpdCHMi064lcMqV5
	 MN4TX1vCiax0ThSxX+395euUsfm/Cif2lENM3/I2en2wjPaNEZpZ4los3GURb++jG+
	 b0CmyYiMO6b8pRs7TUUX8Jh5WEkxfpFJl3Nlis1x+b9wi3uZnTTNnbHPkQAz4FTmb+
	 WCSdvsiWVCtmdrR1T5GDZkKRF0zT5kDSUKdPhpoD35cXqVGtraNPRuboMcaScKBUh1
	 K6gfS7x14y+iFL4equrAJC2Nfz4OVa/Lir6KCrwIIwYzL/+/swb7rrZdfo53/4y0ak
	 g9hXeJsRROUTx3T45V1qga3oWRuTWQ1WkJ0pkQP8uJmDHiacPWxTgHESTcLpGrrgC7
	 r2qDTAORtWwgSn+VGvnqNFnZrRSlQUx9vlgoX2Eo1PxcbR4YNaBy2JrhR2+iy6aE57
	 YZw5XrNCPDj3GuFqx5v83sUM=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 68B6040E0176;
	Sat,  9 Aug 2025 18:58:45 +0000 (UTC)
Date: Sat, 9 Aug 2025 20:58:39 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] smp/urgent for v6.17-rc1
Message-ID: <20250809185839.GAaJeaX7TVfVJHa2Oe@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the smp/urgent lineup for v6.17-rc1.

Thx.

---

The following changes since commit 98e8f2c0e0930feee6a2538450c74d9d7de0a9cc:

  Merge tag 'x86-platform-2025-07-29' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2025-07-29 20:05:06 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/smp_urgent_for_v6.17_rc1

for you to fetch changes up to da274853fe7dbc7124e2dd84dad802be52a09321:

  cpu: Remove obsolete comment from takedown_cpu() (2025-08-06 22:48:12 +0200)

----------------------------------------------------------------
- Remove an obsolete comment and fix spelling

----------------------------------------------------------------
Roman Kisel (1):
      smp: Fix spelling in on_each_cpu_cond_mask()'s doc-comment

Waiman Long (1):
      cpu: Remove obsolete comment from takedown_cpu()

 kernel/cpu.c | 3 ---
 kernel/smp.c | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

