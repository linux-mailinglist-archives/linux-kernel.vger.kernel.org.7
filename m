Return-Path: <linux-kernel+bounces-748027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7089B13B95
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E593189C1DD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C792676DE;
	Mon, 28 Jul 2025 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="lWi3zelG"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAD71E379B;
	Mon, 28 Jul 2025 13:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753709766; cv=none; b=GedvXz7qtJQjLKnUrarNenwf6izaLerRffv4XJ74lPKX84IsoA2eeB6fFiRkTdGZWeSyhJDQu1pyAwFGsOSG6tkp/q35Y3s99Hg1PckW7omV9L6jHsR4fHnkIRv+u5BdQR8sylcxHu6ySNmDHtC5xclqLtKGS+qN4EMjLZTMk/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753709766; c=relaxed/simple;
	bh=cKMH/l5NO1e8a5z2Dh9mCC8wzf97yxMzULdkOpRx5tM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pwBEuXARutDDUsB1sCsB0UQxghkBA6gBojCitSbVBXLlUNpuneS0VcnxFzh7cxkBNH+UnyeTZuaKU2bIuURTqOpKstGgESl7BEf90i/3mgunEIa1ov5JWvcSyiHY2kODBu54cjixJC2BO31vOXFdQLagWviQM9BpGr3GWFN0TRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=lWi3zelG; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 84B7240AA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1753709754; bh=TGOGL4+9w8rjwWq76PI2mRNxZVObIaWVG55BoXnctDU=;
	h=From:To:Cc:Subject:Date:From;
	b=lWi3zelGDPKhiG0SVH0CFrBBmqcYrw0Eq7vvmiImvXYQrnrAteGMil1LRqt65PASQ
	 J241LFWM4n3RD6xOtcSfFmVL1DYFyQ7XAUvKoBTNXQI4egx2Tot8joVgC6wpcx+kAN
	 i17DHIbhrA496XNvC8IhxSwfEzESjsQin+z/cUX5IGkyMQUNXkfOjtSL3AqLKOu4OT
	 Wm2we2jdNWqPdPfMFORpln1zNjChhg0bouleOqI2zVZV1rYVgN7cjqR3y3uCf8my3X
	 A7KlYLBnWQSQdRu6+jd2lEwrvv1YfIH5QqAd+kEeErGmtdsyDlE40FqS4AeoOf6QKD
	 +vSgC/6miaOLg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 84B7240AA9;
	Mon, 28 Jul 2025 13:35:54 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Documentation for 6.17
Date: Mon, 28 Jul 2025 07:35:53 -0600
Message-ID: <87y0s81lqe.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.17

for you to fetch changes up to 35293ebbb65e0295d3b9357f786004ae1026d00f:

  scripts: add origin commit identification based on specific patterns (202=
5-07-24 08:41:15 -0600)

----------------------------------------------------------------
It has been a relatively busy cycle for docs, especially the build system:

- The Perl kernel-doc script was added to 2.3.52pre1 just after the turn of
  the millennium.  Over the following 25 years, it accumulated a vast
  amount of cruft, all in a language few people want to deal with anymore.
  Mauro's Python replacement in 6.16 faithfully reproduced all of the cruft
  in the hope of avoiding regressions.  Now that we have a more reasonable
  code base, though, we can work on cleaning it up; many of the changes
  this time around are toward that end.

- A reorganization of the ext4 docs into the usual TOC format.

- Various Chinese translations and updates.

- A new script from Mauro to help with docs-build testing.

- A new document for linked lists

- A sweep through MAINTAINERS fixing broken GitHub git:// repository links.

...and lots of fixes and updates.

Expect trivial conflicts with the GPIO and block trees.

----------------------------------------------------------------
Ahelenia Ziemia=C5=84ska (1):
      tracing: doc: fix "for a while" typo

Alison Schofield (1):
      docs: ABI: make the KernelVersion field optional

Andrew Donnellan (2):
      Documentation: core-api: entry: Fix typo "systcalls" -> "syscalls"
      Documentation: core-api: entry: Replace deprecated KVM entry/exit fun=
ctions

Bagas Sanjaya (11):
      Documentation: treewide: Replace remaining spinics links with lore
      Documentation: ext4: Convert includes into toctrees
      Documentation: ext4: Reduce toctree depth
      Documentation: ext4: atomic_writes: Demote last three sections
      Documentation: ext4: blockgroup: Add explicit title heading
      Documentation: ext4: Move inode table short docs into its own file
      Documentation: ioctl-number: Fix linuxppc-dev mailto link
      Documentation: ioctl-number: Extend "Include File" column width
      Documentation: ioctl-number: Correct full path to papr-physical-attes=
tation.h
      Documentation: ioctl-number: Shorten macros table
      Documentation: ioctl-number: Don't repeat macro names

Breno Leitao (1):
      docs: kernel: Clarify printk_ratelimit_burst reset behavior

Brigham Campbell (1):
      docs: powerpc: Add htm.rst to table of contents

Collin Funk (3):
      docs: packing: Fix a typo in example code.
      ver_linux: Remove checks for reiserfsprogs.
      docs: Remove reiserfsprogs from dependencies.

Costa Shulyupin (2):
      Documentation/rtla: Add include common_appendix.rst
      Documentation/rtla: Describe exit status

Cui Wei (1):
      Docs/zh_CN: Translate speculation.rst to Simplified Chinese

Daniel Palmer (1):
      doc: Remove misleading reference to brd in dax.rst

Dongliang Mu (7):
      docs/zh_CN: update the translation of process/1.Intro.rst
      docs/zh_CN: update the translation of process/6.Followthrough.rst
      docs/zh_CN: update the translation of process/7.AdvancedTopics.rst
      docs/zh_CN: update the translation of process/2.Process.rst
      docs/zh_CN: update the translation of process/5.Posting.rst
      docs/zh_CN: improve formatting and content clarity
      docs/zh_CN: update git command examples in how-to.rst

Hanne-Lotta M=C3=A4enp=C3=A4=C3=A4 (2):
      docs: Improve grammar in Userspace API/fwctl
      docs: Fix typos, improve grammar in Userspace API

Jakub Kicinski (1):
      docs: process: discourage pointless boilerplate kdoc

Jonathan Corbet (66):
      docs: kdoc: simplify the PROTO continuation logic
      docs: kdoc: move the core dispatch into a state table
      docs: kdoc: remove the section_intro variable
      docs: kdoc: simplify the kerneldoc recognition code
      docs: kdoc: remove the KernelEntry::is_kernel_comment member
      docs: kdoc: remove the KernelEntry::descr pseudo member
      docs: kdoc: remove some ineffective code
      docs: kdoc: move the declaration regexes out of process_name()
      docs: kdoc: some final touches for process_name()
      docs: automarkup: Remove some Sphinx 2 holdovers
      docs: automarkup: Mark up undocumented entities too
      docs: CSS: make cross-reference links more evident
      docs: sphinx: avoid using the deprecated node.set_class()
      docs: kdoc: Make body_with_blank_line parsing more flexible
      docs: kdoc: consolidate the "begin section" logic
      docs: kdoc: separate out the handling of the declaration phase
      docs: kdoc: split out the special-section state
      docs: kdoc: coalesce the new-section handling
      docs: kdoc: rework the handling of SPECIAL_SECTION
      docs: kdoc: coalesce the end-of-comment processing
      docs: kdoc: Add some comments to process_decl()
      docs: kdoc: finish disentangling the BODY and SPECIAL_SECTION states
      docs: kdoc: remove KernelEntry::in_doc_sect
      docs: kdoc: Move content handling into KernelEntry
      docs: kdoc: remove a bit of dead code
      docs: kdoc: remove KernelEntry::function
      docs: kdoc: rework process_export() slightly
      docs: kdoc: remove the INLINE_END state
      docs: kdoc: remove the inline states-within-a-state
      docs: kdoc: split the processing of the two remaining inline states
      docs: kdoc: don't reinvent string.strip()
      docs: kdoc: micro-optimize KernRe
      docs: kdoc: remove the brcount floor in process_proto_type()
      docs: kdoc: remove KernelEntry::in_doc_sect
      docs: kdoc: Move content handling into KernelEntry
      docs: kdoc: remove a bit of dead code
      docs: kdoc: remove KernelEntry::function
      docs: kdoc: rework process_export() slightly
      docs: kdoc: remove the INLINE_END state
      docs: kdoc: remove the inline states-within-a-state
      docs: kdoc: split the processing of the two remaining inline states
      docs: kdoc: rework type prototype parsing
      docs: kdoc: some tweaks to process_proto_function()
      docs: kdoc: Remove a Python 2 comment
      docs: kdoc: pretty up dump_enum()
      docs: kdoc; Add a rudimentary class to represent output items
      docs: kdoc: simplify the output-item passing
      docs: kdoc: don't reinvent string.strip()
      docs: kdoc: micro-optimize KernRe
      docs: kdoc: remove the brcount floor in process_proto_type()
      docs: kdoc: rework type prototype parsing
      docs: kdoc: some tweaks to process_proto_function()
      docs: kdoc: Remove a Python 2 comment
      docs: kdoc: pretty up dump_enum()
      Merge tag 'chinese-doc-6.16-rc1' of gitolite.kernel.org:pub/scm/linux=
/kernel/git/alexs/linux into docs-mw
      docs: kdoc: drop "sectionlist"
      docs: kdoc: Centralize handling of the item section list
      docs: kdoc: remove the "struct_actual" machinery
      docs: kdoc: use self.entry.parameterlist directly in check_sections()
      docs: kdoc: Coalesce parameter-list handling
      docs: kdoc: Regularize the use of the declaration name
      docs: kdoc: straighten up dump_declaration()
      docs: kdoc: directly access the always-there KdocItem fields
      docs: kdoc: clean up check_sections()
      docs: kdoc: emit a warning for ancient versions of Python
      Merge branch 'kdoc-item2' into docs-mw

Matthew Wilcox (Oracle) (2):
      kernel-doc: Fix symbol matching for dropped suffixes
      doc: Include scatterlist APIs in htmldocs

Matthias Frank (1):
      overlayfs.rst: fix typos

Mauro Carvalho Chehab (18):
      docs: conf.py: properly handle include and exclude patterns
      docs: Makefile: disable check rules on make cleandocs
      scripts: scripts/test_doc_build.py: add script to test doc build
      scripts: test_doc_build.py: make capture assynchronous
      scripts: test_doc_build.py: better control its output
      scripts: test_doc_build.py: better adjust to python version
      scripts: test_doc_build.py: improve dependency list
      scripts: test_doc_build.py: improve cmd.log logic
      scripts: test_doc_build.py: make the script smarter
      scripts: sphinx-pre-install: properly handle SPHINXBUILD
      scripts: sphinx-pre-install: fix release detection for Fedora
      scripts: test_doc_build.py: regroup and rename arguments
      docs: sphinx: add a file with the requirements for lowest version
      docs: conf.py: several coding style fixes
      docs: sphinx: add missing SPDX tags
      docs: kernel-doc: emit warnings for ancient versions of Python
      scripts: kdoc: make it backward-compatible with Python 3.7
      sphinx: kernel_abi: fix performance regression with O=3D<dir>

Nicolas Frattaroli (1):
      docs: document linked lists

Petr Tesarik (8):
      docs: dma-api: use "DMA API" consistently throughout the document
      docs: dma-api: replace consistent with coherent
      docs: dma-api: remove remnants of PCI DMA API
      docs: dma-api: add a kernel-doc comment for dma_pool_zalloc()
      docs: dma-api: remove duplicate description of the DMA pool API
      docs: dma-api: clarify DMA addressing limitations
      docs: dma-api: update streaming DMA physical address constraints
      docs: dma-api: clean up documentation of dma_map_sg()

Qiu Yutan (2):
      Docs/zh_CN: Translate vxlan.rst to Simplified Chinese
      Docs/zh_CN: Translate alias.rst to Simplified Chinese

Richard Weinberger (1):
      overlayfs.rst: Fix inode table

Runji Liu (1):
      docs: trace: boottime-trace.rst: fix typo

Salvatore Bonaccorso (1):
      Documentation/sysctl: coredump: add %F for pidfd number

Shashank Balaji (2):
      sched_deadline, docs: replace rt-app examples with chrt or use config=
.json
      sched_deadline, docs: add affinity setting with cgroup2 cpuset contro=
ller

Shouye Liu (1):
      Documentation: amd-pstate:fix minimum performance state label error

Sumeet Pawnikar (1):
      Documentation: Remove duplicate word size in bootconfig

Swapnil Sapkal (1):
      docs/sched: Make the sched-stats documentation consistent

Vignesh Raman (1):
      docs: fault-injection: drop reference to md-faulty

Wang Yaxin (4):
      Docs/zh_CN: Translate napi.rst to Simplified Chinese
      Docs/zh_CN: Translate netif-msg.rst to Simplified Chinese
      Docs/zh_CN: Translate xfrm_proc.rst to Simplified Chinese
      Docs/zh_CN: Translate netmem.rst to Simplified Chinese

WangYuli (1):
      gitignore: allow .pylintrc to be tracked

Xose Vazquez Perez (1):
      MAINTAINERS: replace git protocol for github

Yuanye Ma (1):
      docs: f2fs: fix typos in f2fs.rst

Zhiyu Zhang (1):
      scripts: add origin commit identification based on specific patterns

 .gitignore                                         |   1 +
 Documentation/ABI/README                           |   4 +-
 Documentation/Makefile                             |   2 +
 Documentation/admin-guide/bootconfig.rst           |   2 +-
 Documentation/admin-guide/pm/amd-pstate.rst        |   2 +-
 Documentation/admin-guide/sysctl/kernel.rst        |   4 +-
 Documentation/arch/powerpc/index.rst               |   1 +
 Documentation/conf.py                              | 398 +++++-----
 Documentation/core-api/dma-api-howto.rst           |  36 +-
 Documentation/core-api/dma-api.rst                 | 197 ++---
 Documentation/core-api/entry.rst                   |   6 +-
 Documentation/core-api/index.rst                   |   1 +
 Documentation/core-api/kernel-api.rst              |   6 -
 Documentation/core-api/list.rst                    | 776 +++++++++++++++++=
++
 Documentation/core-api/mm-api.rst                  |   6 -
 Documentation/core-api/packing.rst                 |   2 +-
 Documentation/doc-guide/sphinx.rst                 |  23 +
 Documentation/driver-api/gpio/driver.rst           |   2 +-
 Documentation/fault-injection/fault-injection.rst  |   2 +-
 Documentation/filesystems/dax.rst                  |   1 -
 Documentation/filesystems/ext4/atomic_writes.rst   |  10 +-
 Documentation/filesystems/ext4/bitmaps.rst         |   7 -
 Documentation/filesystems/ext4/blockgroup.rst      |  11 +-
 Documentation/filesystems/ext4/dynamic.rst         |  10 +-
 Documentation/filesystems/ext4/globals.rst         |  15 +-
 Documentation/filesystems/ext4/index.rst           |   2 +-
 Documentation/filesystems/ext4/inode_table.rst     |   9 +
 Documentation/filesystems/ext4/overview.rst        |  22 +-
 Documentation/filesystems/f2fs.rst                 |   4 +-
 Documentation/filesystems/overlayfs.rst            |  26 +-
 Documentation/filesystems/ubifs-authentication.rst |   2 +-
 .../networking/device_drivers/ethernet/ti/cpsw.rst |   6 +-
 Documentation/process/changes.rst                  |  14 -
 Documentation/process/coding-style.rst             |   5 +-
 Documentation/scheduler/sched-deadline.rst         |  85 +-
 Documentation/scheduler/sched-stats.rst            |  53 +-
 Documentation/sphinx-static/custom.css             |  15 +
 Documentation/sphinx/automarkup.py                 |  27 +-
 Documentation/sphinx/cdomain.py                    |   1 +
 Documentation/sphinx/kernel_abi.py                 |   6 +-
 Documentation/sphinx/kernel_include.py             |   1 +
 Documentation/sphinx/kerneldoc.py                  |   3 +-
 Documentation/sphinx/kfigure.py                    |   1 +
 Documentation/sphinx/load_config.py                |   1 +
 Documentation/sphinx/min_requirements.txt          |  11 +
 Documentation/sphinx/parse-headers.pl              |   5 +-
 Documentation/sphinx/requirements.txt              |   1 +
 Documentation/sphinx/rstFlatTable.py               |   1 +
 Documentation/tools/rtla/common_appendix.rst       |  11 +
 Documentation/tools/rtla/rtla-timerlat-hist.rst    |   2 +
 Documentation/trace/boottime-trace.rst             |   4 +-
 Documentation/trace/histogram.rst                  |   2 +-
 Documentation/translations/zh_CN/how-to.rst        | 108 +--
 .../translations/zh_CN/networking/alias.rst        |  56 ++
 .../translations/zh_CN/networking/index.rst        |  12 +-
 .../translations/zh_CN/networking/napi.rst         | 362 +++++++++
 .../translations/zh_CN/networking/netif-msg.rst    |  92 +++
 .../translations/zh_CN/networking/netmem.rst       |  92 +++
 .../translations/zh_CN/networking/vxlan.rst        |  85 ++
 .../translations/zh_CN/networking/xfrm_proc.rst    | 126 +++
 .../translations/zh_CN/process/1.Intro.rst         |  10 +-
 .../translations/zh_CN/process/2.Process.rst       |   7 +-
 .../translations/zh_CN/process/5.Posting.rst       |  11 +
 .../translations/zh_CN/process/6.Followthrough.rst |   5 +
 .../zh_CN/process/7.AdvancedTopics.rst             |  14 +
 Documentation/translations/zh_CN/staging/index.rst |   2 +-
 .../translations/zh_CN/staging/speculation.rst     |  85 ++
 Documentation/usb/gadget-testing.rst               |   2 +-
 Documentation/userspace-api/fwctl/fwctl.rst        |  30 +-
 Documentation/userspace-api/ioctl/ioctl-number.rst | 552 ++++++-------
 .../userspace-api/sysfs-platform_profile.rst       |   6 +-
 MAINTAINERS                                        |  24 +-
 include/linux/dmapool.h                            |   8 +
 mm/dmapool.c                                       |   6 +-
 scripts/checktransupdate.py                        |  38 +-
 scripts/kernel-doc.py                              |  10 +
 scripts/lib/kdoc/kdoc_files.py                     |   4 +-
 scripts/lib/kdoc/kdoc_item.py                      |  42 +
 scripts/lib/kdoc/kdoc_output.py                    | 172 ++---
 scripts/lib/kdoc/kdoc_parser.py                    | 857 ++++++++++-------=
----
 scripts/lib/kdoc/kdoc_re.py                        |   7 +-
 scripts/sphinx-pre-install                         |   6 +-
 scripts/test_doc_build.py                          | 513 ++++++++++++
 scripts/ver_linux                                  |   2 -
 84 files changed, 3750 insertions(+), 1441 deletions(-)
 create mode 100644 Documentation/core-api/list.rst
 create mode 100644 Documentation/filesystems/ext4/inode_table.rst
 create mode 100644 Documentation/sphinx/min_requirements.txt
 create mode 100644 Documentation/translations/zh_CN/networking/alias.rst
 create mode 100644 Documentation/translations/zh_CN/networking/napi.rst
 create mode 100644 Documentation/translations/zh_CN/networking/netif-msg.r=
st
 create mode 100644 Documentation/translations/zh_CN/networking/netmem.rst
 create mode 100644 Documentation/translations/zh_CN/networking/vxlan.rst
 create mode 100644 Documentation/translations/zh_CN/networking/xfrm_proc.r=
st
 create mode 100644 Documentation/translations/zh_CN/staging/speculation.rst
 create mode 100644 scripts/lib/kdoc/kdoc_item.py
 create mode 100755 scripts/test_doc_build.py

