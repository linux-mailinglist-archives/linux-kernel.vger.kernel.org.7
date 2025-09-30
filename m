Return-Path: <linux-kernel+bounces-837601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5B0BACB75
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294151C7B20
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E248E2609D0;
	Tue, 30 Sep 2025 11:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="DbdtZaW3"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846DA34BA29;
	Tue, 30 Sep 2025 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759232409; cv=none; b=rm8yTMLlghpM6z6Ey6pRwOswFBL4REH0tUIbIXamFcDjHI38bJoabeyvPvGAA6Egb4cQW0JHcicm8eTGuqWvYsHhSjPbbYPnm9kEGnQe7SmWwiUPU8wOlNve/cXmiTBI5WGw6+J24HylmtXQ40Ob9RAjFnbtXUel6I00FLJE0x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759232409; c=relaxed/simple;
	bh=uMfZtcbLynWtgfWD6mjC7UBp3eDRi7LIdh6azfvO6c8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rMdl0ldBH/wp42iGkqa4KchxDgmY6wKlJrsxZdfPIEss2tRwLg9PU6Oonk1j+DMgzECvmDMz+D03zy2y7YUjA4Efi/AHr1Za2m8cgp/eFqmPmgqruOGdK8OuyQc5mhaw3x5Phd6AvlSRP2c+mOI9KClxFJ+ah1j3hy2cViGITsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=DbdtZaW3; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B4F12406FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1759232399; bh=KCdpsRgDd36EyHobBelvZdQy6zDKRmNmAndkAU7wHoI=;
	h=From:To:Cc:Subject:Date:From;
	b=DbdtZaW3V0/KVHFCSa5blNv7Mab/h9wmIr2orTp4zqAbDZyH/tTSfl8IjXh9liCcD
	 4GqbYWgJPBVvLzFhoCTARaKLFF7oebq/weR0RM1uYTyjn3+yAV87YNUMFK2zM+hKWA
	 MjgXgum9OW3BBfOWmU5/8WFTSrPuTpSWb3phDcWT3o2mZ3bYb6ewAZGjnwWH1Y9y50
	 hvEicMgc49lXo57LIZLdvzTkaxpNpOAw4UTZxeWoxgKMPyAGbhzkV9HYPLcfi46Cqh
	 HdHfAKW5S4Sqc2I+Wf4gYcYSglw+/h4yPYK++Zre7FKVEl1jFAEq7r798GZS2/vs1o
	 Yr+rWoHv9q7KQ==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B4F12406FA;
	Tue, 30 Sep 2025 11:39:58 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation for 6.18
Date: Tue, 30 Sep 2025 05:39:54 -0600
Message-ID: <87ecrow4mt.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.18

for you to fetch changes up to 99510c324e531addd9f7b80a72dab7435ca66215:

  Documentation/features: Update feature lists for 6.17-rc7 (2025-09-25 11:=
17:56 -0600)

----------------------------------------------------------------
It has been a relatively busy cycle in docsland, with changes all over:

- Bring the kernel memory-model docs into the Sphinx build in the "literal
  include" mode.

- Lots of build-infrastructure work, further cleaning up long-term
  kernel-doc technical debt.  The sphinx-pre-install tool has been
  converted to Python and updated for current systems.

- A new tool to detect when documents have been moved and generate HTML
  redirects; this can be used on kernel.org (or any other site hosting the
  rendered docs) to avoid breaking links.

- Automated processing of the YAML files describing the netlink protocol.

- A significant update of the maintainer's PGP guide.

...and a seemingly endless series of typo fixes, build-problem fixes, etc.

----------------------------------------------------------------
Akira Yokosawa (2):
      docs: Pull LKMM documentation into dev-tools book
      docs: dev-tools/lkmm: Fix typo of missing file extension

Akiyoshi Kurita (1):
      docs: w1: ds2482: fix typo in buses

Akshaykumar Gunari (1):
      docs: arm: stm32: fix typo "busses" -> "buses"

Albin Babu Varghese (1):
      Documentation: conf.py: remove repeated word in comment

Alex Tran (4):
      docs: driver-api pinctrl cleanup
      docs: filesystems: sysfs: remove top level sysfs net directory
      docs: filesystems: sysfs: clarify symlink destinations in dev and bus=
/devices descriptions
      docs: filesystems: sysfs: add remaining top level sysfs directory des=
criptions

Alperen Aksu (1):
      Documentation/filesystems/xfs: Fix typo error

Bagas Sanjaya (18):
      Documentation: ktap: Correct "its" spelling
      Documentation: ktap: Separate first bullet list items
      Documentation: driver-api: usb: Limit toctree depth
      Documentation: ocfs2: Properly reindent filecheck operations list
      Documentation: sharedsubtree: Format remaining of shell snippets as l=
iteral code blcoks
      Documentation: sharedsubtree: Use proper enumerator sequence for enum=
erated lists
      Documentation: sharedsubtree: Don't repeat lists with explanation
      Documentation: sharedsubtree: Align text
      Documentation: sharedsubtree: Convert notes to note directive
      Documentation: w1: Fix SPDX comment syntax on masters and slaves toct=
ree index
      Documentation: fbcon: Add boot options and attach/detach/unload secti=
on headings
      Documentation: fbcon: Reindent 8th step of attach/detach/unload
      Documentation: fbcon: Use admonition directives
      Documentation: trace: histogram: Fix histogram trigger subsection num=
ber order
      Documentation: trace: histogram-design: Trim trailing vertices in dia=
gram explanation text
      Documentation: trace: historgram-design: Separate sched_waking histog=
ram section heading and the following diagram
      Documentation: trace: histogram-design: Wrap introductory note in not=
e:: directive
      Documentation: trace: histogram: Convert ftrace docs cross-reference

Bart Van Assche (1):
      docs: filesystems: sysfs: Recommend sysfs_emit() for new code only

Bartlomiej Kubik (1):
      docs: kernel-parameters: typo fix and add missing SPDX-License tag

Baruch Siach (1):
      doc: filesystems: proc: remove stale information from intro

Bjorn Helgaas (8):
      Documentation: Fix PCI typos
      Documentation: Fix RCU typos
      Documentation: Fix admin-guide typos
      Documentation: Fix core-api typos
      Documentation: Fix filesystems typos
      Documentation: Fix networking typos
      Documentation: Fix power typos
      Documentation: Fix trace typos

David Sterba (1):
      docs: Remove remainders of reiserfs

Dongliang Mu (1):
      MAINTAINERS: add File entry for scripts/checktransupdate.py to DOCUME=
NTATION

Geert Uytterhoeven (1):
      Documentation/printf: Use literal fwnode_handle

Gopi Krishna Menon (2):
      docs: folio_queue: Fix minor typo in folio_queue page
      Documentation/rv: Fix minor typo in monitor_synthesis page

Harshit Mogalapalli (1):
      Documentation: dev-tools: Fix a typo in autofdo documentation

Iris Shi (1):
      Documentation/sphinx: Fix typo in automarkup.py

Jakub Kicinski (1):
      docs: submitting-patches: adjust Fixes definition slightly

Jonathan Corbet (41):
      docs: kdoc: consolidate the stripping of private struct/union members
      docs: kdoc: Move a regex line in dump_struct()
      docs: kdoc: backslashectomy in kdoc_parser
      docs: kdoc: move the prefix transforms out of dump_struct()
      docs: kdoc: split top-level prototype parsing out of dump_struct()
      docs: kdoc: split struct-member rewriting out of dump_struct()
      docs: kdoc: rework the rewrite_struct_members() main loop
      docs: kdoc: remove an extraneous strip() call
      docs: kdoc: Some rewrite_struct_members() commenting
      docs: kdoc: further rewrite_struct_members() cleanup
      docs: kdoc: extract output formatting from dump_struct()
      docs: kdoc: a few final dump_struct() touches
      Merge branch 'dump-struct' into docs-mw
      Merge tag 'docs/v6.17-1' of git://git.kernel.org/pub/scm/linux/kernel=
/git/mchehab/linux-docs into mauro
      Merge branch 'pre-install' into docs-mw
      docs: kdoc: remove dead code
      docs: kdoc: tidy up space removal in create_parameter_list()
      docs: kdoc: clean up the create_parameter_list() "first arg" logic
      docs: kdoc: add a couple more comments in create_parameter_list()
      docs: kdoc: tighten up the array-of-pointers case
      docs: kdoc: tighten up the pointer-to-function case
      docs: kdoc: remove redundant comment stripping
      Merge branch 'bjorn' into docs-mw
      Merge branch 'mauro-pdf' into docs-mw
      Merge branch 'mauro' into docs-mw
      Merge branch 'renames' into docs-mw
      docs: update the guidance for Link: tags
      docs: kdoc: handle the obsolescensce of docutils.ErrorString()
      docs: kdoc: trim __cacheline_group_* with the other annotations
      docs: kdoc: tighten up the push_parameter() no-type case
      docs: kdoc: remove a single-use variable
      docs: kdoc: move the function transform patterns out of dump_function=
()
      doc: kdoc: unify transform handling
      docs: kdoc: remove a couple of spurious regex characters
      docs: kdoc: remove a useless empty capture group
      docs: kdoc: Simplify the dump_function() prototype regexes
      docs: kdoc: consolidate some of the macro-processing logic
      docs: kdoc: final dump_function() cleanups
      docs: kdoc: remove some dead code in dump_typedef()
      docs: kdoc: remove redundant comment stripping in dump_typedef()
      docs: kdoc: a few more dump_typedef() tweaks

Kim Tae Hyun (1):
      docs: update physical memory documentation by adding N_GENERIC_INITIA=
TOR to enum node_states

Konstantin Ryabitsev (1):
      Documentation: update maintainer-pgp-guide for latest best practices

Lukas Bulwahn (1):
      Documentation/features: Update feature lists for 6.17-rc7

Mallikarjun Thammanavar (1):
      docs: fix spelling and grammar in atomic_writes

Marneni PoornaChandu (1):
      docs: driver-api: fix spelling of "buses".

Mauro Carvalho Chehab (97):
      docs: kernel-doc: avoid script crash on ancient Python
      docs: changes: better document Python needs
      docs: netlink: netlink-raw.rst: use :ref: instead of :doc:
      tools: ynl_gen_rst.py: Split library from command line tool
      docs: netlink: index.rst: add a netlink index file
      tools: ynl_gen_rst.py: cleanup coding style
      docs: sphinx: add a parser for yaml files for Netlink specs
      docs: use parser_yaml extension to handle Netlink specs
      docs: uapi: netlink: update netlink specs link
      tools: ynl_gen_rst.py: drop support for generating index files
      docs: netlink: remove obsolete .gitignore from unused directory
      MAINTAINERS: add netlink_yml_parser.py to linux-doc
      tools: netlink_yml_parser.py: add line numbers to parsed data
      docs: parser_yaml.py: add support for line numbers from the parser
      docs: parser_yaml.py: fix backward compatibility with old docutils
      sphinx: parser_yaml.py: fix line numbers information
      scripts: sphinx-pre-install: fix version check for Fedora
      scripts: sphinx-pre-install: rename it to scripts/sphinx-pre-install.=
pl
      scripts: sphinx-pre-install: Convert script to Python
      scripts: sphinx-pre-install: Make it compatible with Python 3.6
      scripts: sphinx-pre-install: run on a supported version
      scripts: sphinx-pre-install: drop obsolete routines
      scripts: sphinx-pre-install: drop support for old virtualenv
      scripts: sphinx-pre-install: Address issues with OpenSUSE Leap 15.x
      scripts: sphinx-pre-install: fix opensuse Leap hint for PyYAML
      scripts: sphinx-pre-install: fix support for gentoo
      scripts: sphinx-pre-install: Address issues with OpenSUSE Tumbleweed
      scripts: sphinx-pre-install: only show portage hints once
      scripts: sphinx-pre-install: cleanup rhel support
      scripts: sphinx-pre-install: output Python and docutils version
      scripts: sphinx-pre-install: add a missing f-string marker
      scripts: sphinx-pre-install: fix Leap support for rsvg-convert
      scripts: sphinx-pre-install: fix rhel recomendations
      scripts: sphinx-pre-install: remove Scientific Linux
      scripts: sphinx-pre-install: improve Gentoo package deps logic
      scripts: sphinx-pre-install: fix OpenMandriva support
      scripts: sphinx-pre-install: move package instructions to a new func
      scripts: sphinx-pre-install: adjust a warning message
      scripts: sphinx-pre-install: better handle Python min version
      scripts: sphinx-pre-install: convert is_optional to a class
      scripts: sphinx-pre-install: better handle RHEL-based distros
      scripts: sphinx-pre-install: move missing logic to a separate class
      scripts: sphinx-pre-install: move ancillary checkers to a separate cl=
ass
      scripts: sphinx-pre-install: add more generic checkers on a class
      scripts: sphinx-pre-install: move get_system_release()
      scripts: sphinx-pre-install: add documentation for the ancillary clas=
ses.
      scripts: sphinx-pre-install: add docstring documentation
      scripts: sphinx-pre-install: fix several codingstyle issues
      scripts: sphinx-pre-install: rework install command logic
      docs: Makefile: switch to the new scripts/sphinx-pre-install.py
      scripts: sphinx-pre-install.pl: get rid of the old script
      scripts: sphinx-pre-install: update mandatory system deps
      scripts: sphinx-pre-install: add support for RHEL8-based distros
      scripts: sphinx-pre-install: add a warning for Debian-based distros
      scripts: sphinx-pre-install: some adjustments related to venv
      docs: Makefile: Fix LaTeX paper size settings
      docs: conf.py: better handle latex documents
      docs: conf.py: fix doc name with SPHINXDIRS
      docs: conf.py: rename some vars at latex_documents logic
      docs: conf.py: use dedent and r-strings for LaTeX macros
      docs: conf.py: fix some troubles for LaTeX output
      docs: conf.py: extra cleanups and fixes
      scripts: sphinx-pre-install: fix PDF build issues on Ubuntu
      scripts: sphinx-pre-install: add missing gentoo pdf dependencies
      scripts: sphinx-pre-install: fix PDF dependencies for openSuse
      scripts: sphinx-pre-install: fix dependencies for OpenMandriva
      scripts: sphinx-pre-install: fix pdf dependencies for Mageia 9
      scripts: sphinx-pre-install: fix PDF dependencies for gentoo
      scripts/sphinx-pre-install: fix Archlinux PDF dependencies
      docs: parse-headers.pl: improve its debug output format
      docs: parse-headers.py: convert parse-headers.pl
      docs: parse-headers.py: improve --help logic
      docs: parse-headers.py: better handle @var arguments
      docs: parse-headers.py: simplify the rules for hashes
      tools: docs: parse-headers.py: move it from sphinx dir
      tools: docs: parse_data_structs.py: add methods to return output
      MAINTAINERS: add files from tools/docs to documentation entry
      docs: uapi: media: Makefile: use parse-headers.py
      docs: kernel_include.py: Update its coding style
      docs: kernel_include.py: allow cross-reference generation
      docs: kernel_include.py: generate warnings for broken refs
      docs: kernel_include.py: move rawtext logic to separate functions
      docs: kernel_include.py: move range logic to a separate function
      docs: kernel_include.py: remove range restriction for gen docs
      docs: kernel_include.py: move code and literal functions
      docs: kernel_include.py: add support to generate a TOC table
      docs: kernel_include.py: append line numbers to better report errors
      docs: kernel_include.py: move apply_range() and add a docstring
      docs: kernel_include.py: remove line numbers from parsed-literal
      docs: kernel_include.py: remove Include class inheritance
      docs: kernel_include.py: document all supported parameters
      scripts: sphinx-build-wrapper: get rid of uapi/media Makefile
      docs: sphinx: drop parse-headers.pl
      docs: conf.py: drop xindy rule
      docs: kernel_include.py: fix an issue when O=3D is used
      docs: kernel_include.py: drop some old behavior
      docs: remove cdomain.py

Mehdi Ben Hadj Khelifa (1):
      docs: Corrected typo in trace/events

Nikola Z. Ivanov (1):
      docs: Replace dead links to spectre side channel white papers

Osama Albahrani (1):
      docs: aoe: Remove trailing whitespace

Randy Dunlap (1):
      docs: sysctl: add a few more top-level /proc/sys entries

Ranganath V N (3):
      Documentation: Fix minor typos
      Documentation: Fix driver-api typos
      Documentation: Fix spelling mistakes

Raphael Pinsonneault-Thibeault (1):
      docs: fix trailing whitespace error and remove repeated words in prop=
agate_umount.txt

Ryan Chung (2):
      tracing: rephrase for clearer documentation
      tracing: fix grammar error in debugging.rst

Sebastian Andrzej Siewior (3):
      Documentation: seqlock: Add a SPDX license identifier
      Documentation: locking: Add local_lock_nested_bh() to locktypes
      Documentation: Add real-time to core-api

Taimoor Zaeem (1):
      Documentation: staging: fix spelling error in remoteproc.rst

Thorsten Blum (1):
      docs: maintainer: Fix ambiguous subheading formatting

Vegard Nossum (4):
      docs: sphinx: remove SPDX/copyright comments from HTML output
      docs: add tools/docs/gen-renames.py
      docs: add Documentation/.renames.txt
      docs: add tools/docs/gen-redirects.py

Vivek Alurkar (1):
      Fix typo in RAID arrays documentation

Vivek Yadav (1):
      docs: remove a duplicated word from kernel-parameters.txt

Yash Suthar (1):
      Documentation/process: submitting-patches: fix typo in "were do"

Zenghui Yu (1):
      docs: admin-guide: Fix typo in nfsroot.rst

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec (1):
      docs: admin-guide: update to current minimum pipe size default

 .pylintrc                                          |    2 +-
 Documentation/.renames.txt                         | 1191 +++++++++
 Documentation/Makefile                             |   28 +-
 Documentation/PCI/endpoint/pci-endpoint-cfs.rst    |    4 +-
 Documentation/PCI/endpoint/pci-endpoint.rst        |    6 +-
 Documentation/RCU/lockdep.rst                      |    2 +-
 Documentation/RCU/stallwarn.rst                    |    2 +-
 Documentation/admin-guide/LSM/SafeSetID.rst        |    2 +-
 Documentation/admin-guide/RAS/main.rst             |    2 +-
 Documentation/admin-guide/aoe/udev.txt             |    6 +-
 Documentation/admin-guide/blockdev/paride.rst      |    2 +-
 .../admin-guide/device-mapper/vdo-design.rst       |    2 +-
 Documentation/admin-guide/ext4.rst                 |    2 +-
 Documentation/admin-guide/hw-vuln/mds.rst          |    2 +-
 Documentation/admin-guide/hw-vuln/spectre.rst      |    6 +-
 Documentation/admin-guide/kdump/kdump.rst          |    2 +-
 Documentation/admin-guide/kernel-parameters.rst    |    4 +-
 Documentation/admin-guide/kernel-parameters.txt    |   12 +-
 Documentation/admin-guide/laptops/laptop-mode.rst  |    8 +-
 Documentation/admin-guide/laptops/sonypi.rst       |    2 +-
 Documentation/admin-guide/md.rst                   |    2 +-
 Documentation/admin-guide/media/imx.rst            |    2 +-
 Documentation/admin-guide/media/si4713.rst         |    6 +-
 Documentation/admin-guide/mm/damon/usage.rst       |    2 +-
 Documentation/admin-guide/nfs/nfsroot.rst          |    2 +-
 Documentation/admin-guide/perf/hisi-pmu.rst        |    4 +-
 .../admin-guide/quickly-build-trimmed-linux.rst    |    4 +-
 Documentation/admin-guide/reporting-issues.rst     |    4 +-
 Documentation/admin-guide/sysctl/fs.rst            |    4 +-
 Documentation/admin-guide/sysctl/index.rst         |   18 +-
 .../verify-bugs-and-bisect-regressions.rst         |    2 +-
 .../arch/arm/stm32/stm32f746-overview.rst          |    2 +-
 .../arch/arm/stm32/stm32f769-overview.rst          |    2 +-
 .../arch/arm/stm32/stm32h743-overview.rst          |    2 +-
 .../arch/arm/stm32/stm32h750-overview.rst          |    2 +-
 .../arch/arm/stm32/stm32mp13-overview.rst          |    2 +-
 .../arch/arm/stm32/stm32mp151-overview.rst         |    2 +-
 Documentation/arch/loongarch/irq-chip-model.rst    |    4 +-
 .../arch/powerpc/eeh-pci-error-recovery.rst        |    1 -
 Documentation/arch/x86/cpuinfo.rst                 |    2 +-
 Documentation/conf.py                              |  126 +-
 Documentation/core-api/folio_queue.rst             |    2 +-
 Documentation/core-api/index.rst                   |    1 +
 Documentation/core-api/irq/irq-affinity.rst        |    6 +-
 Documentation/core-api/irq/irq-domain.rst          |   38 +-
 Documentation/core-api/printk-formats.rst          |    2 +-
 .../core-api/real-time/architecture-porting.rst    |  109 +
 Documentation/core-api/real-time/differences.rst   |  242 ++
 Documentation/core-api/real-time/index.rst         |   16 +
 Documentation/core-api/real-time/theory.rst        |  116 +
 Documentation/dev-tools/autofdo.rst                |    4 +-
 Documentation/dev-tools/index.rst                  |    1 +
 Documentation/dev-tools/ktap.rst                   |    5 +-
 .../dev-tools/lkmm/docs/access-marking.rst         |   11 +
 Documentation/dev-tools/lkmm/docs/cheatsheet.rst   |   11 +
 .../dev-tools/lkmm/docs/control-dependencies.rst   |   11 +
 Documentation/dev-tools/lkmm/docs/explanation.rst  |   11 +
 Documentation/dev-tools/lkmm/docs/glossary.rst     |   11 +
 .../dev-tools/lkmm/docs/herd-representation.rst    |   11 +
 Documentation/dev-tools/lkmm/docs/index.rst        |   21 +
 Documentation/dev-tools/lkmm/docs/litmus-tests.rst |   11 +
 Documentation/dev-tools/lkmm/docs/locking.rst      |   11 +
 Documentation/dev-tools/lkmm/docs/ordering.rst     |   11 +
 Documentation/dev-tools/lkmm/docs/readme.rst       |   11 +
 Documentation/dev-tools/lkmm/docs/recipes.rst      |   11 +
 Documentation/dev-tools/lkmm/docs/references.rst   |   11 +
 Documentation/dev-tools/lkmm/docs/simple.rst       |   11 +
 Documentation/dev-tools/lkmm/index.rst             |   15 +
 Documentation/dev-tools/lkmm/readme.rst            |   11 +
 .../devicetree/bindings/submitting-patches.rst     |    2 +-
 .../driver-api/cxl/devices/device-types.rst        |    2 +-
 .../example-configurations/one-dev-per-hb.rst      |    2 +-
 Documentation/driver-api/device-io.rst             |    4 +-
 Documentation/driver-api/driver-model/overview.rst |    2 +-
 Documentation/driver-api/driver-model/platform.rst |    2 +-
 Documentation/driver-api/eisa.rst                  |    6 +-
 Documentation/driver-api/i3c/protocol.rst          |    4 +-
 Documentation/driver-api/ipmi.rst                  |    4 +-
 Documentation/driver-api/media/tx-rx.rst           |    4 +-
 Documentation/driver-api/nvdimm/nvdimm.rst         |    2 +-
 Documentation/driver-api/pin-control.rst           |   10 +-
 Documentation/driver-api/pm/devices.rst            |    4 +-
 Documentation/driver-api/scsi.rst                  |    4 +-
 Documentation/driver-api/spi.rst                   |    2 +-
 .../thermal/exynos_thermal_emulation.rst           |   14 +-
 Documentation/driver-api/usb/hotplug.rst           |    2 +-
 Documentation/driver-api/usb/index.rst             |    1 +
 Documentation/driver-api/usb/usb.rst               |    4 +-
 Documentation/fb/fbcon.rst                         |   42 +-
 .../features/core/eBPF-JIT/arch-support.txt        |    4 +-
 .../core/mseal_sys_mappings/arch-support.txt       |    2 +-
 .../core/thread-info-in-task/arch-support.txt      |    2 +-
 .../features/core/tracehook/arch-support.txt       |    2 +-
 .../features/perf/kprobes-event/arch-support.txt   |    2 +-
 .../features/time/clockevents/arch-support.txt     |    2 +-
 Documentation/filesystems/erofs.rst                |    2 +-
 Documentation/filesystems/ext4/atomic_writes.rst   |    6 +-
 Documentation/filesystems/gfs2-glocks.rst          |    2 +-
 Documentation/filesystems/hpfs.rst                 |    2 +-
 Documentation/filesystems/iomap/operations.rst     |    2 +-
 .../filesystems/ocfs2-online-filecheck.rst         |   20 +-
 Documentation/filesystems/proc.rst                 |   21 -
 Documentation/filesystems/propagate_umount.txt     |    6 +-
 Documentation/filesystems/resctrl.rst              |    2 +-
 Documentation/filesystems/sharedsubtree.rst        | 1347 +++++-----
 Documentation/filesystems/sysfs.rst                |   25 +-
 .../filesystems/xfs/xfs-online-fsck-design.rst     |    8 +-
 Documentation/locking/locktypes.rst                |   21 +
 Documentation/locking/seqlock.rst                  |    2 +
 Documentation/maintainer/configure-git.rst         |   28 -
 .../maintainer/maintainer-entry-profile.rst        |    2 +
 Documentation/mm/physical_memory.rst               |    2 +
 Documentation/netlink/specs/index.rst              |   13 +
 Documentation/networking/can.rst                   |    2 +-
 .../ethernet/ti/am65_nuss_cpsw_switchdev.rst       |    2 +-
 .../device_drivers/ethernet/ti/cpsw_switchdev.rst  |    2 +-
 Documentation/networking/index.rst                 |    2 +-
 Documentation/networking/netlink_spec/.gitignore   |    1 -
 Documentation/networking/netlink_spec/readme.txt   |    4 -
 Documentation/networking/rds.rst                   |    2 +-
 Documentation/power/pci.rst                        |    4 +-
 Documentation/power/suspend-and-cpuhotplug.rst     |    2 +-
 Documentation/process/5.Posting.rst                |    7 +-
 Documentation/process/changes.rst                  |    9 +-
 Documentation/process/maintainer-pgp-guide.rst     |  158 +-
 Documentation/process/submitting-patches.rst       |    6 +-
 Documentation/sphinx/automarkup.py                 |    2 +-
 Documentation/sphinx/cdomain.py                    |  247 --
 Documentation/sphinx/kernel_feat.py                |    4 +-
 Documentation/sphinx/kernel_include.py             |  528 +++-
 Documentation/sphinx/maintainers_include.py        |    4 +-
 Documentation/sphinx/parse-headers.pl              |  404 ---
 Documentation/sphinx/parser_yaml.py                |  123 +
 Documentation/sphinx/templates/kernel-toc.html     |    3 +-
 Documentation/sphinx/templates/translations.html   |    4 +-
 Documentation/staging/remoteproc.rst               |    2 +-
 Documentation/trace/boottime-trace.rst             |    2 +-
 Documentation/trace/debugging.rst                  |    2 +-
 Documentation/trace/events.rst                     |    8 +-
 Documentation/trace/fprobe.rst                     |    2 +-
 Documentation/trace/ftrace-uses.rst                |    2 +-
 Documentation/trace/ftrace.rst                     |   14 +-
 Documentation/trace/histogram-design.rst           |  175 +-
 Documentation/trace/histogram.rst                  |   40 +-
 Documentation/trace/rv/monitor_synthesis.rst       |    2 +-
 .../translations/it_IT/process/changes.rst         |   14 -
 Documentation/userspace-api/media/Makefile         |   64 -
 .../userspace-api/media/cec/cec-header.rst         |    5 +-
 .../media/{ =3D> cec}/cec.h.rst.exceptions           |    0
 .../media/{ =3D> dvb}/ca.h.rst.exceptions            |    0
 .../media/{ =3D> dvb}/dmx.h.rst.exceptions           |    0
 .../media/{ =3D> dvb}/frontend.h.rst.exceptions      |    0
 Documentation/userspace-api/media/dvb/headers.rst  |   17 +-
 .../media/{ =3D> dvb}/net.h.rst.exceptions           |    0
 .../userspace-api/media/mediactl/media-header.rst  |    5 +-
 .../media/{ =3D> mediactl}/media.h.rst.exceptions    |    0
 .../userspace-api/media/rc/lirc-header.rst         |    4 +-
 .../media/{ =3D> rc}/lirc.h.rst.exceptions           |    0
 Documentation/userspace-api/media/v4l/videodev.rst |    4 +-
 .../media/{ =3D> v4l}/videodev2.h.rst.exceptions     |    0
 Documentation/userspace-api/netlink/index.rst      |    2 +-
 .../userspace-api/netlink/netlink-raw.rst          |    6 +-
 Documentation/userspace-api/netlink/specs.rst      |    2 +-
 Documentation/virt/kvm/review-checklist.rst        |    2 +-
 Documentation/w1/masters/ds2482.rst                |    2 +-
 Documentation/w1/masters/index.rst                 |    2 +-
 Documentation/w1/slaves/index.rst                  |    2 +-
 MAINTAINERS                                        |    4 +
 Makefile                                           |    5 +-
 fs/btrfs/tree-log.c                                |    2 +-
 scripts/kernel-doc.py                              |   34 +-
 scripts/lib/kdoc/kdoc_parser.py                    |  848 +++----
 scripts/selinux/install_policy.sh                  |    2 +-
 scripts/sphinx-build-wrapper                       |  719 ++++++
 scripts/sphinx-pre-install                         | 2669 ++++++++++++----=
----
 tools/docs/gen-redirects.py                        |   54 +
 tools/docs/gen-renames.py                          |  130 +
 tools/docs/lib/__init__.py                         |    0
 tools/docs/lib/enrich_formatter.py                 |   70 +
 tools/docs/lib/parse_data_structs.py               |  452 ++++
 tools/docs/parse-headers.py                        |   60 +
 tools/net/ynl/pyynl/lib/__init__.py                |    2 +
 tools/net/ynl/pyynl/lib/doc_generator.py           |  398 +++
 tools/net/ynl/pyynl/ynl_gen_rst.py                 |  384 +--
 184 files changed, 7615 insertions(+), 3974 deletions(-)
 create mode 100644 Documentation/.renames.txt
 create mode 100644 Documentation/core-api/real-time/architecture-porting.r=
st
 create mode 100644 Documentation/core-api/real-time/differences.rst
 create mode 100644 Documentation/core-api/real-time/index.rst
 create mode 100644 Documentation/core-api/real-time/theory.rst
 create mode 100644 Documentation/dev-tools/lkmm/docs/access-marking.rst
 create mode 100644 Documentation/dev-tools/lkmm/docs/cheatsheet.rst
 create mode 100644 Documentation/dev-tools/lkmm/docs/control-dependencies.=
rst
 create mode 100644 Documentation/dev-tools/lkmm/docs/explanation.rst
 create mode 100644 Documentation/dev-tools/lkmm/docs/glossary.rst
 create mode 100644 Documentation/dev-tools/lkmm/docs/herd-representation.r=
st
 create mode 100644 Documentation/dev-tools/lkmm/docs/index.rst
 create mode 100644 Documentation/dev-tools/lkmm/docs/litmus-tests.rst
 create mode 100644 Documentation/dev-tools/lkmm/docs/locking.rst
 create mode 100644 Documentation/dev-tools/lkmm/docs/ordering.rst
 create mode 100644 Documentation/dev-tools/lkmm/docs/readme.rst
 create mode 100644 Documentation/dev-tools/lkmm/docs/recipes.rst
 create mode 100644 Documentation/dev-tools/lkmm/docs/references.rst
 create mode 100644 Documentation/dev-tools/lkmm/docs/simple.rst
 create mode 100644 Documentation/dev-tools/lkmm/index.rst
 create mode 100644 Documentation/dev-tools/lkmm/readme.rst
 create mode 100644 Documentation/netlink/specs/index.rst
 delete mode 100644 Documentation/networking/netlink_spec/.gitignore
 delete mode 100644 Documentation/networking/netlink_spec/readme.txt
 delete mode 100644 Documentation/sphinx/cdomain.py
 delete mode 100755 Documentation/sphinx/parse-headers.pl
 create mode 100755 Documentation/sphinx/parser_yaml.py
 delete mode 100644 Documentation/userspace-api/media/Makefile
 rename Documentation/userspace-api/media/{ =3D> cec}/cec.h.rst.exceptions =
(100%)
 rename Documentation/userspace-api/media/{ =3D> dvb}/ca.h.rst.exceptions (=
100%)
 rename Documentation/userspace-api/media/{ =3D> dvb}/dmx.h.rst.exceptions =
(100%)
 rename Documentation/userspace-api/media/{ =3D> dvb}/frontend.h.rst.except=
ions (100%)
 rename Documentation/userspace-api/media/{ =3D> dvb}/net.h.rst.exceptions =
(100%)
 rename Documentation/userspace-api/media/{ =3D> mediactl}/media.h.rst.exce=
ptions (100%)
 rename Documentation/userspace-api/media/{ =3D> rc}/lirc.h.rst.exceptions =
(100%)
 rename Documentation/userspace-api/media/{ =3D> v4l}/videodev2.h.rst.excep=
tions (100%)
 create mode 100755 scripts/sphinx-build-wrapper
 create mode 100755 tools/docs/gen-redirects.py
 create mode 100755 tools/docs/gen-renames.py
 create mode 100644 tools/docs/lib/__init__.py
 create mode 100644 tools/docs/lib/enrich_formatter.py
 create mode 100755 tools/docs/lib/parse_data_structs.py
 create mode 100755 tools/docs/parse-headers.py
 create mode 100644 tools/net/ynl/pyynl/lib/doc_generator.py

