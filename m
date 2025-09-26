Return-Path: <linux-kernel+bounces-833896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A0DBA34E6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474FC384BD5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FC72DAFC1;
	Fri, 26 Sep 2025 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="T/ICZ4G0"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E39129D289
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758881609; cv=none; b=dEYN6HP5XksiAQL7p/m6KN/Rsp8aDCH32Wp8ucw+GHwnWTnr3TA4bK7DBhT22S3/g/mF5K6o9P/4KB35tDYcrfjhRkciYP/mxRmcDL75Bjl69U/ewPV7J7lhW0aJwdiU4/FVQrCJppj7HrvWEP+Oc1b1cuefN3TkfLMcgO2re7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758881609; c=relaxed/simple;
	bh=5IAumXTQKjvIDpdbFocKepz0ZYr+ncIawFI89U2pWs8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ffUVBb4FCtuNx4867Wv79hpSzd1fj0Zc2ejD14DBTfx0WN3y/7Nwb4nRz4HxvJDnPFM9Ij43EeRq0Hr6Egi3dPYyZ+IrgejAkYkADAFnvTrAh1o3AqibUxaqiKVGVlZIp+RU3rxxwfAjOOgBUirbgVQQWri/j2I0VIQm/u2JnyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=T/ICZ4G0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4E0C040E016E;
	Fri, 26 Sep 2025 10:13:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WJ4NOY6N53GS; Fri, 26 Sep 2025 10:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758881603; bh=7XGZnhbmPudFh5JqfZ8SEaJ+rH06O+T8xSSl99Dxrk0=;
	h=Date:From:To:Cc:Subject:From;
	b=T/ICZ4G0BIwNR0jC1SgV4WpBFUBjm/QsqAKwHZt5SxkWrzPjApnHSxipIlXXt75DV
	 g/HdWEOdhqck8LWJvEy9y6mUx+EQ6Grmi+jpUGLAuZ6CPGIUL9hoMklKUQbGJSjn2I
	 eG11P8SS3dPRhJFksEp0VXv78Bo7gIRJ5WXz2OR2fAKcbnQiWymDzL7HrqPm53Jp5D
	 2nm/elLywZvR7c2oZgfuBJZArX0AzJc16HRSavVaBz5rPAvKDJXNs/qP6nAUP521CO
	 GT8DdffM6dIfv/f7vh+Y7NvqrCkPkE/akCOQ9PjB4SGMADRlMVUdN67lAD/4VfXCzt
	 2QU2tO+sQwDQ38LYX83Ywhk8eIE9IaXDeLcfnt4HgSc+3BZ66uGAiXFGIJ1LG6VR9W
	 BWaxFL7gEh8mFHbQ363YgUXK3FR/ivQLSWvuxaBGOqbiJElG9VchAqxP4qL7W6oZ95
	 r4FsYjIuAQw1B0aEsF36bQ1X88YW4YT2y9VMooK5GyJqc4FxSU6xBGEdbtR4W1Jczs
	 MU+RoMtslcUxaUHJV49/TseBaG0Yim/M+8ot+CB0gF6LHBKuk4OmANkMWVYbBAKjfl
	 W1nTUrROXGEUWJ0nu/f88hoMVXQBK5ahFt++W46r99ZkNdAOk4RdrNTIxE3B04s8XI
	 PAJoeWPWbV7cEE6rTTLyjDPw=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 0F9F440E016D;
	Fri, 26 Sep 2025 10:13:20 +0000 (UTC)
Date: Fri, 26 Sep 2025 12:13:19 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cpu for v6.18-rc1
Message-ID: <20250926101319.GAaNZnP1tx-bGTHlwW@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/cpu lineup for v6.18-rc1.

Thx.

---

The following changes since commit f83ec76bf285bea5727f478a68b894f5543ca76e:

  Linux 6.17-rc6 (2025-09-14 14:21:14 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_cpu_for_v6.18_rc1

for you to fetch changes up to 27b1fd62012dfe9d3eb8ecde344d7aa673695ecf:

  x86/umip: Fix decoding of register forms of 0F 01 (SGDT and SIDT aliases) (2025-09-19 21:34:48 +0200)

----------------------------------------------------------------
- Make UMIP instruction detection more robust

- Correct and cleanup AMD CPU topology detection; document the relevant
  CPUID leaves topology parsing precedence on AMD

- Add support for running the kernel as guest on FreeBSD's Bhyve
  hypervisor

- Cleanups and improvements

----------------------------------------------------------------
David Woodhouse (1):
      x86/cpu: Detect FreeBSD Bhyve hypervisor

K Prateek Nayak (4):
      x86/cpu/cacheinfo: Simplify cacheinfo_amd_init_llc_id() using _cpuid4_info
      x86/cpu/topology: Check for X86_FEATURE_XTOPOLOGY instead of passing has_xtopology
      x86/cpu/topology: Define AMD64_CPUID_EXT_FEAT MSR
      Documentation/x86/topology: Detail CPUID leaves used for topology enumeration

Sean Christopherson (2):
      x86/umip: Check that the instruction opcode is at least two bytes
      x86/umip: Fix decoding of register forms of 0F 01 (SGDT and SIDT aliases)

Tony Luck (1):
      x86/cpu: Rename and move CPU model entry for Diamond Rapids

 Documentation/arch/x86/topology.rst                | 191 +++++++++++++++++++++
 arch/x86/Kconfig                                   |   9 +
 arch/x86/include/asm/hypervisor.h                  |   2 +
 arch/x86/include/asm/intel-family.h                |   7 +-
 arch/x86/include/asm/msr-index.h                   |   5 +
 arch/x86/kernel/cpu/Makefile                       |   1 +
 arch/x86/kernel/cpu/bhyve.c                        |  66 +++++++
 arch/x86/kernel/cpu/cacheinfo.c                    |  48 +++---
 arch/x86/kernel/cpu/hypervisor.c                   |   3 +
 arch/x86/kernel/cpu/topology_amd.c                 |  26 ++-
 arch/x86/kernel/umip.c                             |  15 +-
 .../x86/intel/speed_select_if/isst_if_common.c     |   2 +-
 drivers/platform/x86/intel/tpmi_power_domains.c    |   2 +-
 tools/power/x86/turbostat/turbostat.c              |   2 +-
 14 files changed, 329 insertions(+), 50 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/bhyve.c


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

