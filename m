Return-Path: <linux-kernel+bounces-833910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D6DBA3539
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5902562236
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3973F2EFD83;
	Fri, 26 Sep 2025 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ffiuN8hM"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAAC221D87
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758881821; cv=none; b=o9n7JVZk4vP1R3iEPTEfGp4jngwLCFCz8bhhOFZau/IRvvEcA0+KsaUEQzaCH88pG6JV+GVKEDektgzauX0YzNDm8U9G8XlO5iTzoehAt/X1aN5dN9Eszd5V1m+mEY/JS1GqznN/8KWteZrwZO9MYJya7dMRnj4km7RIJUq8hDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758881821; c=relaxed/simple;
	bh=Zt2seZhzOrQox3Y3VvJi/bPiv4/Fj+My6hR9WfTfr+A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Wq2HOB3H0SyXlzzFgAjndnr7Y9IptwTkXbiazXVJfPvBbNZazuFUBR1sURjxXwSqNtj1Sso4dcax9mCp4Hx+CWEpyIuBOJtDvTnz3eLPeQbpOnsVVKsQOmZgjuT0pasETb+QtgiO4LVyl6G2Wkpe50FGyjVQTpVNBPKKs7Zn6K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ffiuN8hM; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0C9ED40E016E;
	Fri, 26 Sep 2025 10:16:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MeielOhjDu_u; Fri, 26 Sep 2025 10:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758881813; bh=co/BHRScAI8+L9LCtXCmIoCl9lFBof+i+cBblMAG/og=;
	h=Date:From:To:Cc:Subject:From;
	b=ffiuN8hMJWr2p07HIXNbOdgScRHkndgfqlvq3XofKHzZnfbAy6FudZWsNRBkZaGPW
	 v1srCgyOG9WExjd1K25EVTTR2V8I69VYsvZC4VrloWetnOGHNdnljrb6sAna5Xsr1p
	 Z4+sxv5kqnqvAc8x7gap2il/FRSbu4AcwTGTyEE8eoRMMUgaY1bxgSd1QZ7EykbWI0
	 QXFXQX1AdqGyslHOh6L5NMQkkFKhTxz+Qju6yn3BjuaRtXw1/VJWGzdF4Rr4KP5KsT
	 ju3mDeF9q2Ce5qBFzf38Dj13mxe29OLN6wjVNABway0pSP3rSWSejsdkxMTpy0i361
	 0hfmM1WPyKXV8ZGK72Q3Q0A3G6YwUDf9oxbHpywmAidCJvPN7fjIAsplfGfxiwrR/u
	 Thb2x7h9y0MgJxNAC4fP2KCEO7NAtuDv3M+4a8xE4/Vyflmh9MD3YdhTkTh4pBdtcm
	 WUL3qFJF+ym9NulHExOskguqe7MdLpFYTY4vB8ryX0odlscgdCQW/SCX7vYYCiMLdp
	 MdPI38fJWl2r4KyptflRKMaFeMm1Gg+qy38yvGw9HbG1zwZezxgj0vPvfcJvdBBqQB
	 qgyI618/wgKm36b3GoybOsMgooEwjDE18DQMwc8hj/3Y7bRrqVzkJ6JVaQ95+Njw58
	 lT2gs4ZXktysDgOjthB94jSU=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 6820F40E016D;
	Fri, 26 Sep 2025 10:16:50 +0000 (UTC)
Date: Fri, 26 Sep 2025 12:16:49 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cache for v6.18-rc1
Message-ID: <20250926101649.GAaNZoEZjRzw1u4p4c@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/cache lineup for v6.18-rc1.

Thx.

---

The following changes since commit f83ec76bf285bea5727f478a68b894f5543ca76e:

  Linux 6.17-rc6 (2025-09-14 14:21:14 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_cache_for_v6.18_rc1

for you to fetch changes up to dd86b69d20fb9fa7e941ed01ff05f1e662fcc3ff:

  fs/resctrl: Fix counter auto-assignment on mkdir with mbm_event enabled (2025-09-17 11:31:12 +0200)

----------------------------------------------------------------
- Add support on AMD for assigning QOS bandwidth counters to resources
  (RMIDs) with the ability for those resources to be tracked by the
  counters as long as they're assigned to them. Previously, due to hw
  limitations, bandwidth counts from untracked resources would get lost
  when those resources are not tracked. Refactor the code and user
  interfaces to be able to also support other, similar features on ARM,
  for example

----------------------------------------------------------------
Babu Moger (30):
      x86/cpufeatures: Add support for Assignable Bandwidth Monitoring Counters (ABMC)
      x86/resctrl: Add ABMC feature in the command line options
      x86,fs/resctrl: Consolidate monitoring related data from rdt_resource
      x86,fs/resctrl: Detect Assignable Bandwidth Monitoring feature details
      x86/resctrl: Add support to enable/disable AMD ABMC feature
      fs/resctrl: Introduce the interface to display monitoring modes
      fs/resctrl: Add resctrl file to display number of assignable counters
      fs/resctrl: Introduce mbm_cntr_cfg to track assignable counters per domain
      fs/resctrl: Introduce interface to display number of free MBM counters
      x86/resctrl: Add data structures and definitions for ABMC assignment
      fs/resctrl: Introduce event configuration field in struct mon_evt
      x86,fs/resctrl: Implement resctrl_arch_config_cntr() to assign a counter with ABMC
      fs/resctrl: Add the functionality to assign MBM events
      fs/resctrl: Add the functionality to unassign MBM events
      fs/resctrl: Pass struct rdtgroup instead of individual members
      fs/resctrl: Introduce counter ID read, reset calls in mbm_event mode
      x86/resctrl: Refactor resctrl_arch_rmid_read()
      x86/resctrl: Implement resctrl_arch_reset_cntr() and resctrl_arch_cntr_read()
      fs/resctrl: Support counter read/reset with mbm_event assignment mode
      fs/resctrl: Add event configuration directory under info/L3_MON/
      fs/resctrl: Provide interface to update the event configurations
      fs/resctrl: Introduce mbm_assign_on_mkdir to enable assignments on mkdir
      fs/resctrl: Auto assign counters on mkdir and clean up on group removal
      fs/resctrl: Introduce mbm_L3_assignments to list assignments in a group
      fs/resctrl: Introduce the interface to modify assignments in a group
      fs/resctrl: Disable BMEC event configuration when mbm_event mode is enabled
      fs/resctrl: Introduce the interface to switch between monitor modes
      x86/resctrl: Configure mbm_event mode if supported
      MAINTAINERS: resctrl: Add myself as reviewer
      fs/resctrl: Fix counter auto-assignment on mkdir with mbm_event enabled

Shaopeng Tan (1):
      fs/resctrl: Optimize code in rdt_get_tree()

Tony Luck (4):
      x86,fs/resctrl: Consolidate monitor event descriptions
      x86,fs/resctrl: Replace architecture event enabled checks
      x86/resctrl: Remove the rdt_mon_features global variable
      x86,fs/resctrl: Prepare for more monitor events

 Documentation/admin-guide/kernel-parameters.txt |    2 +-
 Documentation/filesystems/resctrl.rst           |  325 ++++++++
 MAINTAINERS                                     |    1 +
 arch/x86/include/asm/cpufeatures.h              |    1 +
 arch/x86/include/asm/msr-index.h                |    2 +
 arch/x86/include/asm/resctrl.h                  |   16 -
 arch/x86/kernel/cpu/resctrl/core.c              |   81 +-
 arch/x86/kernel/cpu/resctrl/internal.h          |   56 +-
 arch/x86/kernel/cpu/resctrl/monitor.c           |  248 +++++-
 arch/x86/kernel/cpu/scattered.c                 |    1 +
 fs/resctrl/ctrlmondata.c                        |   26 +-
 fs/resctrl/internal.h                           |   58 +-
 fs/resctrl/monitor.c                            | 1008 +++++++++++++++++++++--
 fs/resctrl/rdtgroup.c                           |  259 ++++--
 include/linux/resctrl.h                         |  148 +++-
 include/linux/resctrl_types.h                   |   18 +-
 16 files changed, 2021 insertions(+), 229 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

