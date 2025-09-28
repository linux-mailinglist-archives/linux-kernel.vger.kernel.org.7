Return-Path: <linux-kernel+bounces-835560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AFDBA774E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516AB1892FC1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F93267B90;
	Sun, 28 Sep 2025 19:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nI1N2sOf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A501D5150;
	Sun, 28 Sep 2025 19:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759088908; cv=none; b=qykN0S+iE3XziJo9NpNVYOHVcaCnwUbhMqrRaltibs72ay+oNgCRGUqNe64f8n+Rvxr8CUxf72DDnYLIXkQw1T+1ttcZvgZvATdMxe/SVJpVcJycFYpyMdO8JGR41kTCqH61B3t+kQsGewggU2YU9KADyWX4PzWod8vexEJhoBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759088908; c=relaxed/simple;
	bh=FiCN47fJtQb18mY9IAgpHRnPcAAnBTX9SMBd6wgZt2Q=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:Mime-Version; b=VtHfI4tEI3LPELM5mcAwvgM6h+UJRf4mKrBu5As1lGkhM9K4vcfONFUpn4xtufcxNaYKWqOMe+eLUsbjmLzTZFbtO/dBGvhgT0pubazC4o7w5V32sWvEsQ5Upwul8kOr4ocQ/wxxCLAUs2ZPIs9WcR0TUGNCQnNgf60oAS/KFo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nI1N2sOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98775C4CEF0;
	Sun, 28 Sep 2025 19:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759088908;
	bh=FiCN47fJtQb18mY9IAgpHRnPcAAnBTX9SMBd6wgZt2Q=;
	h=Date:Subject:Cc:To:From:From;
	b=nI1N2sOfs4BOeMIIQDRPpKl3jA3yoMGrOdp7WHeJZ4mhBiXzpe+kklFC+XT3FR+JE
	 npIt2dLbMllcgLjRMNaNSZT4HP5XNaxTsXaDp1WDij/BeRfzDUjPVflN0pRpNfLFtf
	 K8JVCmNPecvTe+JQ6kGoGICTu8cma6JUPKc7B6g0NiXfZ3Yt2nvt/2g5ZjIh8wwKf7
	 zmD2OckR0LMcqv7XAgkJag7p6KfxS1b8qhfGDXTUmeeunX7jGPH5B6CS2TijS2LNi0
	 PHN1gdflOLGSijOTX9xeocfZKZtAirbYgDeylbrupUozlbdc80foUY/qAtuQduIE9P
	 DJgDH1RRPacqQ==
Content-Type: text/plain; charset=UTF-8
Date: Sun, 28 Sep 2025 21:48:24 +0200
Message-Id: <DD4OZ2NDSZ6E.2KDADLOEY69TI@kernel.org>
Subject: [GIT PULL] Driver core changes for 6.18-rc1
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Saravana Kannan" <saravanak@google.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: aerc 0.20.1

Hi Linus,

Please pull these driver-core changes.

I did a test merge pulling in Miguel's Rust tree and found two trivial incl=
ude
conflicts -- otherwise no conflicts expected.

All changes have been in linux-next for at least six rounds (except for two
minor patches that change the Display implementation of pci::Vendor and
pci::Class to print the actual vendor and class name).

- Danilo

The following changes since commit f83ec76bf285bea5727f478a68b894f5543ca76e=
:

  Linux 6.17-rc6 (2025-09-14 14:21:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git=
 tags/driver-core-6.18-rc1

for you to fetch changes up to 6d97171ac6585de698df019b0bfea3f123fd8385:

  rust: pci: display symbolic PCI vendor names (2025-09-25 15:52:00 +0200)

----------------------------------------------------------------
Driver core changes for 6.18-rc1

- Auxiliary:
   - Drop call to dev_pm_domain_detach() in auxiliary_bus_probe()
   - Optimize logic of auxiliary_match_id()

- Rust:
  - Auxiliary:
    - Use primitive C types from prelude

  - DebugFs:
    - Add debugfs support for simple read/write files and custom callbacks
      through a File-type-based and directory-scope-based API
    - Sample driver code for the File-type-based API
    - Sample module code for the directory-scope-based API

  - I/O:
    - Add io::poll module and implement Rust specific read_poll_timeout()
      helper

  - IRQ:
    - Implement support for threaded and non-threaded device IRQs based on
      (&Device<Bound>, IRQ number) tuples (IrqRequest)
    - Provide &Device<Bound> cookie in IRQ handlers

  - PCI:
    - Support IRQ requests from IRQ vectors for a specific pci::Device<Boun=
d>
    - Implement accessors for subsystem IDs, revision, devid and resource s=
tart
    - Provide dedicated pci::Vendor and pci::Class types for vendor and cla=
ss
      ID numbers
    - Implement Display to print actual vendor and class names; Debug to pr=
int
      the raw ID numbers
    - Add pci::DeviceId::from_class_and_vendor() helper
    - Use primitive C types from prelude
    - Various minor inline and (safety) comment improvements

  - Platform:
    - Support IRQ requests from IRQ vectors for a specific
      platform::Device<Bound>

  - Nova:
    - Use pci::DeviceId::from_class_and_vendor() to avoid probing
      non-display/compute PCI functions

  - Misc:
    - Add helper for cpu_relax()
    - Update ARef import from sync::aref

- sysfs:
  - Remove bin_attrs_new field from struct attribute_group
  - Remove read_new() and write_new() from struct bin_attribute

- Misc:
  - Document potential race condition in get_dev_from_fwnode()
  - Constify node_group argument in software node registration functions
  - Fix order of kernel-doc parameters in various functions
  - Set power.no_pm flag for faux devices
  - Set power.no_callbacks flag along with the power.no_pm flag
  - Constify the pmu_bus bus type
  - Minor spelling fixes

----------------------------------------------------------------
Abhinav Ananthu (2):
      rust: auxiliary: Use `c_` types from prelude instead of
      rust: pci: use c_* types via kernel prelude

Alice Ryhl (1):
      rust: irq: add &Device<Bound> argument to irq callbacks

Alistair Popple (2):
      rust: Update PCI binding safety comments and add inline compiler hint
      rust: Add several miscellaneous PCI helpers

Claudiu Beznea (1):
      driver core: auxiliary bus: Drop dev_pm_domain_detach() call

Daniel Almeida (6):
      rust: irq: add irq module
      rust: irq: add flags module
      rust: irq: add support for non-threaded IRQs and handlers
      rust: irq: add support for threaded IRQs and handlers
      rust: platform: add irq accessors
      rust: pci: add irq accessors

Danilo Krummrich (1):
      driver core: get_dev_from_fwnode(): document potential race

Dmitry Torokhov (1):
      software node: Constify node_group in registration functions

FUJITA Tomonori (2):
      rust: Add cpu_relax() helper
      rust: Add read_poll_timeout function

Gil Fine (1):
      driver core: Fix order of the kernel-doc parameters

Greg Kroah-Hartman (2):
      Merge 6.17-rc3 into driver-core-next
      Merge 6.17-rc6 into driver-core-next

John Hubbard (8):
      rust: pci: provide access to PCI Class and Class-related items
      rust: pci: provide access to PCI Vendor values
      rust: pci: add DeviceId::from_class_and_vendor() method
      gpu: nova-core: avoid probing non-display/compute PCI functions
      rust: pci: use pci::Vendor instead of bindings::PCI_VENDOR_ID_*
      rust: pci: inline several tiny functions
      rust: pci: display symbolic PCI class names
      rust: pci: display symbolic PCI vendor names

Matthew Maurer (7):
      rust: debugfs: Add initial support for directories
      rust: debugfs: Add support for read-only files
      rust: debugfs: Add support for writable files
      rust: debugfs: Add support for callback-based files
      samples: rust: Add debugfs sample driver
      rust: debugfs: Add support for scoped directories
      samples: rust: Add scoped debugfs sample driver

Miguel Ojeda (1):
      MAINTAINERS: add "DEVICE I/O & IRQ [RUST]" entry

Rafael J. Wysocki (2):
      driver core: faux: Set power.no_pm for faux devices
      driver core/PM: Set power.no_callbacks along with power.no_pm

Rahul Rameshbabu (2):
      rust: pci: fix incorrect platform reference in PCI driver unbind doc =
comment
      rust: pci: fix incorrect platform reference in PCI driver probe doc c=
omment

Ricardo B. Marliere (1):
      perf: make pmu_bus const

Shankari Anand (1):
      rust: driver-core: Update ARef and AlwaysRefCounted imports from sync=
::aref

Thomas Wei=C3=9Fschuh (2):
      sysfs: remove bin_attribute::read_new/write_new()
      sysfs: remove attribute_group::bin_attrs_new

Xichao Zhao (1):
      drivers: base: fix "publically"->"publicly"

Zijun Hu (1):
      driver core: auxiliary bus: Optimize logic of auxiliary_match_id()

 MAINTAINERS                              |  20 ++++
 drivers/base/auxiliary.c                 |  25 +++--
 drivers/base/core.c                      |  27 +++++-
 drivers/base/cpu.c                       |   2 +-
 drivers/base/faux.c                      |   1 +
 drivers/base/swnode.c                    |   5 +-
 drivers/gpu/nova-core/driver.rs          |  33 ++++++-
 fs/sysfs/file.c                          |  22 +----
 include/linux/device.h                   |   3 +
 include/linux/property.h                 |   4 +-
 include/linux/sysfs.h                    |  11 +--
 kernel/events/core.c                     |   2 +-
 rust/bindings/bindings_helper.h          |   2 +
 rust/helpers/helpers.c                   |   2 +
 rust/helpers/irq.c                       |   9 ++
 rust/helpers/pci.c                       |  18 ++++
 rust/helpers/processor.c                 |   8 ++
 rust/kernel/auxiliary.rs                 |   4 +-
 rust/kernel/debugfs.rs                   | 594 +++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
 rust/kernel/debugfs/callback_adapters.rs | 122 +++++++++++++++++++++++
 rust/kernel/debugfs/entry.rs             | 164 +++++++++++++++++++++++++++=
++++
 rust/kernel/debugfs/file_ops.rs          | 247 +++++++++++++++++++++++++++=
+++++++++++++++++++
 rust/kernel/debugfs/traits.rs            | 102 +++++++++++++++++++
 rust/kernel/device.rs                    |   7 +-
 rust/kernel/devres.rs                    |   4 +-
 rust/kernel/io.rs                        |   1 +
 rust/kernel/io/poll.rs                   | 104 ++++++++++++++++++++
 rust/kernel/irq.rs                       |  24 +++++
 rust/kernel/irq/flags.rs                 | 124 +++++++++++++++++++++++
 rust/kernel/irq/request.rs               | 507 +++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs                       |   3 +
 rust/kernel/pci.rs                       | 180 +++++++++++++++++++++++++++=
+++----
 rust/kernel/pci/id.rs                    | 578 +++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 rust/kernel/platform.rs                  | 178 +++++++++++++++++++++++++++=
+++++-
 rust/kernel/processor.rs                 |  14 +++
 samples/rust/Kconfig                     |  22 +++++
 samples/rust/Makefile                    |   2 +
 samples/rust/rust_debugfs.rs             | 151 +++++++++++++++++++++++++++=
+
 samples/rust/rust_debugfs_scoped.rs      | 134 +++++++++++++++++++++++++
 samples/rust/rust_dma.rs                 |   6 +-
 samples/rust/rust_driver_auxiliary.rs    |  12 +--
 samples/rust/rust_driver_pci.rs          |   9 +-
 samples/rust/rust_driver_platform.rs     |   2 +-
 43 files changed, 3391 insertions(+), 98 deletions(-)
 create mode 100644 rust/helpers/irq.c
 create mode 100644 rust/helpers/processor.c
 create mode 100644 rust/kernel/debugfs.rs
 create mode 100644 rust/kernel/debugfs/callback_adapters.rs
 create mode 100644 rust/kernel/debugfs/entry.rs
 create mode 100644 rust/kernel/debugfs/file_ops.rs
 create mode 100644 rust/kernel/debugfs/traits.rs
 create mode 100644 rust/kernel/io/poll.rs
 create mode 100644 rust/kernel/irq.rs
 create mode 100644 rust/kernel/irq/flags.rs
 create mode 100644 rust/kernel/irq/request.rs
 create mode 100644 rust/kernel/pci/id.rs
 create mode 100644 rust/kernel/processor.rs
 create mode 100644 samples/rust/rust_debugfs.rs
 create mode 100644 samples/rust/rust_debugfs_scoped.rs

