Return-Path: <linux-kernel+bounces-749727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9ACCB1522B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 020494E5202
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E19C2989A7;
	Tue, 29 Jul 2025 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnjmzBjJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C917F293462
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753810818; cv=none; b=JbfnziFuNxAwOg1nNdV4VYq7bnuBK2Pqf12UCFPDNmCibfBB67MV/gTFeWyosQv1mpvR//2cDakLTa4Tt8PQWZ2AwNsTH1/ADqS7/koVpPmUISn8qH/iAahbdb8mNoeFKuWhDY4nVSYaJYWvF1aJYubqO6CVgaleQc5acrfRvEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753810818; c=relaxed/simple;
	bh=q5PPUlg3pz6zbhOUWBYzGnkESilZTgkhlnlrf9dCnJU=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:Mime-Version; b=i7RHxxwfr4Pa3z3m/nebmjeGWnJwE06V4N3P3OZ0LX5GqohBDCYVQB9wn6uAAGxgTPRSDhrYNtfvFrFYeh0FMLAqgwyztsGBW0FyS7rvcA9Ej1QqiI9u6phd8up15ARIMcKeeHf9396kgrvGi+zZd80PlwOLSIwFM3oJ4Udbt3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnjmzBjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0CBC4CEF4;
	Tue, 29 Jul 2025 17:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753810818;
	bh=q5PPUlg3pz6zbhOUWBYzGnkESilZTgkhlnlrf9dCnJU=;
	h=Date:Subject:Cc:To:From:From;
	b=KnjmzBjJvhdsfCfnEJBtaJL7fprBHM+cZLs5VFVqky+szM1civSYteEiQK601OW/T
	 9VU4jsA+Tn4fN39li6f6EneY+rYUVlAxS36HL4Q++C/KjH257epPoMPL8shHCUk0ca
	 rZytsYyFTp4qp5o+BDVMOrWK6sGt1snmzkfTrFai1jGT+6J6TCYH+pwmxFe08fcLMm
	 YKZpXTDhEq+yEpha2U9IV5w87GGJ+yh/rw4Pj54ZH9NJOTgmZTzMf13thhIFcf9d2h
	 G9h32rjfMZimlZdSRhrDVkOQxGDPQg0CXkdChV4s/UI3vnz8vsTc29zaaLdvqlzT6I
	 Xh+09U6/owLig==
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Jul 2025 19:40:15 +0200
Message-Id: <DBOQ1PS4Z00Q.ARCY8VPIY909@kernel.org>
Subject: [GIT PULL] Driver core changes for 6.17-rc1
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Stephen Rothwell" <sfr@canb.auug.org.au>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>,
 <linux-kernel@vger.kernel.org>
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

There is one trivial conflict with your tree in rust/helpers/helpers.c.

There are also some non-trivial conflicts with Miguel's Rust tree. Addition=
al to
the resolutions in linux-next, which should be correct, I also did a test m=
erge
with Miguel's tree:

  https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.g=
it driver-core-6.17-test-merge

All commits have been in linux-next for over a week with no reported issues=
.

Independently, preparing this PR I noticed one minor issue with one of the
debugfs changes. I already sent a fix [1] for this, which should reach you
through a normal -fixes PR (unless you decide to pick it right away).

- Danilo

[1] https://lore.kernel.org/lkml/20250727105937.7480-1-dakr@kernel.org/

The following changes since commit 86731a2a651e58953fc949573895f2fa6d456841=
:

  Linux 6.16-rc3 (2025-06-22 13:30:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git=
 tags/driver-core-6.17-rc1

for you to fetch changes up to 51a486feac0ca002bee6429f03da0a6c206d0dc5:

  rust: io: fix broken intra-doc links to `platform::Device` (2025-07-22 11=
:08:59 +0200)

----------------------------------------------------------------
Driver core changes for 6.17-rc1

- DEBUGFS

  - Remove unneeded debugfs_file_{get,put}() instances

  - Remove last remnants of debugfs_real_fops()

  - Allow storing non-const void * in struct debugfs_inode_info::aux

- SYSFS

  - Switch back to attribute_group::bin_attrs (treewide)

  - Switch back to bin_attribute::read()/write() (treewide)

  - Constify internal references to 'struct bin_attribute'

- Support cache-ids for device-tree systems

  - Add arch hook arch_compact_of_hwid()

  - Use arch_compact_of_hwid() to compact MPIDR values on arm64

- Rust

  - Device

    - Introduce CoreInternal device context (for bus internal methods)

    - Provide generic drvdata accessors for bus devices

    - Provide Driver::unbind() callbacks

    - Use the infrastructure above for auxiliary, PCI and platform

    - Implement Device::as_bound()

    - Rename Device::as_ref() to Device::from_raw() (treewide)

    - Implement fwnode and device property abstractions

      - Implement example usage in the Rust platform sample driver

  - Devres

    - Remove the inner reference count (Arc) and use pin-init instead

    - Replace Devres::new_foreign_owned() with devres::register()

    - Require T to be Send in Devres<T>

    - Initialize the data kept inside a Devres last

    - Provide an accessor for the Devres associated Device

  - Device ID

    - Add support for ACPI device IDs and driver match tables

    - Split up generic device ID infrastructure

    - Use generic device ID infrastructure in net::phy

  - DMA

    - Implement the dma::Device trait

    - Add DMA mask accessors to dma::Device

    - Implement dma::Device for PCI and platform devices

    - Use DMA masks from the DMA sample module

  - I/O

    - Implement abstraction for resource regions (struct resource)

    - Implement resource-based ioremap() abstractions

    - Provide platform device accessors for I/O (remap) requests

  - Misc

    - Support fallible PinInit types in Revocable

    - Implement Wrapper<T> for Opaque<T>

    - Merge pin-init blanket dependencies (for Devres)

- Misc

  - Fix OF node leak in auxiliary_device_create()

  - Use util macros in device property iterators

  - Improve kobject sample code

  - Add device_link_test() for testing device link flags

  - Fix typo in Documentation/ABI/testing/sysfs-kernel-address_bits

  - Hint to prefer container_of_const() over container_of()

----------------------------------------------------------------
Al Viro (11):
      zynqmp: don't bother with debugfs_file_{get,put}() in proxied fops
      hfi1: get rid of redundant debugfs_file_{get,put}()
      regmap: get rid of redundant debugfs_file_{get,put}()
      resctrl: get rid of pointless debugfs_file_{get,put}()
      vmscan: don't bother with debugfs_real_fops()
      netronome: don't bother with debugfs_real_fops()
      debugfs: split short and full proxy wrappers, kill debugfs_real_fops(=
)
      fix tt_command_write()
      debugfs_get_aux(): allow storing non-const void *
      blk-mq-debugfs: use debugfs_get_aux()
      lpfc: don't use file->f_path.dentry for comparisons

Alice Ryhl (1):
      device: rust: rename Device::as_ref() to Device::from_raw()

Benno Lossin (2):
      rust: pin-init: improve safety documentation for `impl<T> [Pin]Init<T=
> for T`
      rust: pin-init: change blanket impls for `[Pin]Init` and add one for =
`Result<T, E>`

Christian Schrefl (1):
      rust: implement `Wrapper<T>` for `Opaque<T>`

Daniel Almeida (3):
      rust: io: add resource abstraction
      rust: io: mem: add a generic iomem abstraction
      rust: platform: add resource accessors

Danilo Krummrich (25):
      rust: device: implement FwNode::is_of_node()
      samples: rust: platform: don't call as_ref() repeatedly
      samples: rust: platform: conditionally call Self::properties_parse()
      rust: devres: require T: Send for Devres
      Merge tag 'pin-init-v6.17-result-blanket' of https://github.com/Rust-=
for-Linux/linux.git
      rust: revocable: support fallible PinInit types
      rust: devres: replace Devres::new_foreign_owned()
      rust: devres: get rid of Devres' inner Arc
      rust: device: introduce device::CoreInternal
      rust: device: add drvdata accessors
      rust: platform: use generic device drvdata accessors
      rust: pci: use generic device drvdata accessors
      rust: auxiliary: use generic device drvdata accessors
      rust: platform: implement Driver::unbind()
      rust: pci: implement Driver::unbind()
      samples: rust: pci: reset pci-testdev in unbind()
      rust: devres: initialize Devres::inner::data last
      rust: devres: provide an accessor for the device
      rust: device: implement Device::as_bound()
      rust: dma: implement `dma::Device` trait
      rust: dma: add DMA addressing capabilities
      rust: pci: implement the `dma::Device` trait
      rust: platform: implement the `dma::Device` trait
      rust: samples: dma: set DMA mask
      rust: io: mem: enable IoRequest doc-tests

FUJITA Tomonori (4):
      rust: fix typo in #[repr(transparent)] comments
      rust: device_id: split out index support into a separate trait
      rust: net::phy represent DeviceId as transparent wrapper over mdio_de=
vice_id
      rust: net::phy Change module_phy_driver macro to use module_device_ta=
ble macro

Greg Kroah-Hartman (1):
      Merge 6.16-rc3 into driver-core-next

Igor Korotin (6):
      rust: acpi: add `acpi::DeviceId` abstraction
      rust: driver: Consolidate `Adapter::of_id_info` methods using `#[cfg]=
`
      rust: driver: Add ACPI id table support to Adapter trait
      rust: platform: Set `OF_ID_TABLE` default to `None` in `Driver` trait
      rust: platform: Add ACPI match table support to `Driver` trait
      samples: rust: add ACPI match table example to platform driver

James Morse (2):
      cacheinfo: Add arch hook to compress CPU h/w id into 32 bits for cach=
e-id
      arm64: cacheinfo: Provide helper to compress MPIDR value into u32

Johan Hovold (1):
      driver core: auxiliary bus: fix OF node leak

Matti Vaittinen (1):
      device property: Use tidy for_each_named_* macros

Meng Shao Liu (2):
      samples/kobject: fix path comment
      samples/kobject: make attribute_group const

Miguel Ojeda (3):
      rust: acpi: remove unneeded cast to clean future Clippy warning
      rust: io: fix broken intra-doc link to missing `flags` module
      rust: io: fix broken intra-doc links to `platform::Device`

Rafael J. Wysocki (1):
      driver core: Add device_link_test() for testing device link flags

Rahul Rameshbabu (1):
      rust: pci: fix documentation related to Device instances

Remo Senekowitsch (10):
      rust: device: Create FwNode abstraction for accessing device properti=
es
      rust: device: Enable accessing the FwNode of a Device
      rust: device: Move property_present() to FwNode
      rust: device: Enable printing fwnode name and path
      rust: device: Introduce PropertyGuard
      rust: device: Implement accessors for firmware properties
      samples: rust: platform: Add property read examples
      rust: device: Add child accessor and iterator
      rust: device: Add property_get_reference_args
      samples: rust: platform: Add property child and reference args exampl=
es

Richard Weinberger (1):
      Docs/ABI: Fix sysfs-kernel-address_bits path

Rob Herring (1):
      cacheinfo: Set cache 'id' based on DT data

Sakari Ailus (1):
      container_of: Document container_of() is not to be used in new code

Shankari Anand (1):
      rust: miscdevice: clarify invariant for `MiscDeviceRegistration`

Tamir Duberstein (3):
      rust: platform: remove unnecessary import
      rust: auxiliary: remove unnecessary import
      rust: devres: remove unused import

Thomas Wei=C3=9Fschuh (4):
      const_structs.checkpatch: add bin_attribute
      sysfs: constify internal references to 'struct bin_attribute'
      sysfs: treewide: switch back to bin_attribute::read()/write()
      sysfs: treewide: switch back to attribute_group::bin_attrs

 Documentation/ABI/testing/sysfs-kernel-address_bits    |   2 +-
 MAINTAINERS                                            |   3 +
 arch/arm64/include/asm/cache.h                         |  17 +++
 arch/powerpc/kernel/secvar-sysfs.c                     |   2 +-
 arch/powerpc/perf/hv-24x7.c                            |   2 +-
 arch/powerpc/platforms/powernv/opal-core.c             |   4 +-
 arch/powerpc/platforms/powernv/opal-dump.c             |   2 +-
 arch/powerpc/platforms/powernv/opal-elog.c             |   2 +-
 arch/powerpc/platforms/powernv/opal-flash.c            |   2 +-
 arch/powerpc/platforms/powernv/opal-msglog.c           |   2 +-
 arch/powerpc/platforms/powernv/opal.c                  |   2 +-
 arch/powerpc/platforms/powernv/ultravisor.c            |   2 +-
 arch/s390/kernel/cpacf.c                               |   2 +-
 arch/s390/kernel/ipl.c                                 |  18 +--
 arch/s390/pci/pci_sysfs.c                              |   2 +-
 arch/x86/kernel/ksysfs.c                               |   8 +-
 block/blk-mq-debugfs.c                                 |  12 +-
 drivers/accel/habanalabs/common/sysfs.c                |   4 +-
 drivers/acpi/bgrt.c                                    |   2 +-
 drivers/acpi/sysfs.c                                   |   4 +-
 drivers/base/auxiliary.c                               |   2 +
 drivers/base/cacheinfo.c                               |  50 ++++++++
 drivers/base/core.c                                    |  73 ++++++------
 drivers/base/devcoredump.c                             |   2 +-
 drivers/base/firmware_loader/sysfs.c                   |   6 +-
 drivers/base/node.c                                    |   2 +-
 drivers/base/power/main.c                              |   2 +-
 drivers/base/power/runtime.c                           |   6 +-
 drivers/base/regmap/regmap-debugfs.c                   |  10 --
 drivers/base/topology.c                                |   2 +-
 drivers/cpufreq/rcpufreq_dt.rs                         |   3 +-
 drivers/cxl/port.c                                     |   2 +-
 drivers/firmware/efi/mokvar-table.c                    |   2 +-
 drivers/firmware/google/cbmem.c                        |   2 +-
 drivers/firmware/google/gsmi.c                         |   2 +-
 drivers/firmware/google/memconsole.c                   |   2 +-
 drivers/firmware/google/vpd.c                          |   4 +-
 drivers/firmware/qemu_fw_cfg.c                         |   2 +-
 drivers/fsi/fsi-core.c                                 |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c                |   2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |   4 +-
 drivers/gpu/drm/drm_sysfs.c                            |   4 +-
 drivers/gpu/drm/i915/i915_gpu_error.c                  |   4 +-
 drivers/gpu/drm/i915/i915_sysfs.c                      |   8 +-
 drivers/gpu/drm/lima/lima_drv.c                        |   4 +-
 drivers/gpu/drm/xlnx/zynqmp_dp.c                       |  38 +-----
 drivers/gpu/nova-core/driver.rs                        |   7 +-
 drivers/gpu/nova-core/gpu.rs                           |   6 +-
 drivers/hid/hid-core.c                                 |   2 +-
 drivers/hid/hid-roccat-arvo.c                          |   2 +-
 drivers/hid/hid-roccat-common.h                        |   8 +-
 drivers/hid/hid-roccat-isku.c                          |  10 +-
 drivers/hid/hid-roccat-kone.c                          |   6 +-
 drivers/hid/hid-roccat-koneplus.c                      |  14 +--
 drivers/hid/hid-roccat-konepure.c                      |   2 +-
 drivers/hid/hid-roccat-kovaplus.c                      |  12 +-
 drivers/hid/hid-roccat-lua.c                           |   4 +-
 drivers/hid/hid-roccat-pyra.c                          |  14 +--
 drivers/hid/hid-roccat-ryos.c                          |   2 +-
 drivers/hid/hid-roccat-savu.c                          |   2 +-
 drivers/i2c/i2c-slave-eeprom.c                         |   4 +-
 drivers/iio/imu/bno055/bno055.c                        |   2 +-
 drivers/infiniband/hw/hfi1/debugfs.c                   |  28 -----
 drivers/infiniband/hw/hfi1/debugfs.h                   |   9 +-
 drivers/infiniband/hw/hfi1/fault.c                     |   9 --
 drivers/infiniband/hw/hfi1/sysfs.c                     |   2 +-
 drivers/infiniband/hw/qib/qib_sysfs.c                  |   2 +-
 drivers/input/touchscreen/goodix_berlin_core.c         |   2 +-
 drivers/leds/led-class.c                               |   2 +-
 drivers/media/pci/solo6x10/solo6x10-core.c             |   2 +-
 drivers/misc/c2port/core.c                             |   2 +-
 drivers/misc/ds1682.c                                  |   4 +-
 drivers/misc/eeprom/max6875.c                          |   2 +-
 drivers/misc/ocxl/sysfs.c                              |   2 +-
 drivers/misc/pch_phub.c                                |   4 +-
 drivers/misc/sram.c                                    |   4 +-
 drivers/mtd/spi-nor/sysfs.c                            |   2 +-
 drivers/net/ethernet/netronome/nfp/nfp_net_debugfs.c   |  15 ++-
 drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c   |  10 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c      |  34 +++---
 drivers/net/phy/spi_ks8995.c                           |   4 +-
 drivers/net/wireless/ti/wlcore/sysfs.c                 |   2 +-
 drivers/nvmem/core.c                                   |  14 +--
 drivers/of/kobj.c                                      |   2 +-
 drivers/of/unittest-data/tests-platform.dtsi           |  10 ++
 drivers/of/unittest.c                                  |   2 +
 drivers/pci/hotplug/acpiphp_ibm.c                      |   2 +-
 drivers/pci/p2pdma.c                                   |   2 +-
 drivers/pci/pci-sysfs.c                                |  12 +-
 drivers/pci/vpd.c                                      |   2 +-
 drivers/pcmcia/cistpl.c                                |   4 +-
 drivers/platform/chrome/cros_ec_vbc.c                  |   2 +-
 drivers/platform/mellanox/mlxbf-bootctl.c              |   2 +-
 drivers/platform/x86/amd/hsmp/acpi.c                   |   4 +-
 drivers/platform/x86/amd/hsmp/plat.c                   |   4 +-
 drivers/platform/x86/dell/dcdbas.c                     |   2 +-
 drivers/platform/x86/dell/dell_rbu.c                   |   2 +-
 drivers/platform/x86/intel/pmt/class.c                 |   2 +-
 drivers/platform/x86/intel/sdsi.c                      |   2 +-
 drivers/platform/x86/wmi-bmof.c                        |   2 +-
 drivers/power/supply/ds2760_battery.c                  |   2 +-
 drivers/power/supply/ds2780_battery.c                  |  10 +-
 drivers/power/supply/ds2781_battery.c                  |  10 +-
 drivers/power/supply/olpc_battery.c                    |   4 +-
 drivers/ptp/ptp_ocp.c                                  |   2 +-
 drivers/rapidio/rio-sysfs.c                            |   6 +-
 drivers/s390/char/sclp_config.c                        |   2 +-
 drivers/s390/char/sclp_sd.c                            |   2 +-
 drivers/s390/cio/chp.c                                 |   2 +-
 drivers/s390/crypto/pkey_sysfs.c                       |   8 +-
 drivers/scsi/3w-sas.c                                  |   4 +-
 drivers/scsi/arcmsr/arcmsr_attr.c                      |   6 +-
 drivers/scsi/esas2r/esas2r_main.c                      |   6 +-
 drivers/scsi/ibmvscsi/ibmvfc.c                         |   2 +-
 drivers/scsi/ipr.c                                     |  10 +-
 drivers/scsi/lpfc/lpfc_attr.c                          |   8 +-
 drivers/scsi/lpfc/lpfc_debugfs.c                       |  87 ++++++-------=
-
 drivers/scsi/lpfc/lpfc_debugfs.h                       |  11 ++
 drivers/scsi/qedf/qedf_attr.c                          |   4 +-
 drivers/scsi/qla2xxx/qla_attr.c                        |  28 ++---
 drivers/scsi/qla4xxx/ql4_attr.c                        |   4 +-
 drivers/scsi/scsi_sysfs.c                              |   6 +-
 drivers/staging/greybus/camera.c                       |   2 +-
 drivers/thermal/testing/command.c                      |  30 ++---
 drivers/usb/core/sysfs.c                               |   2 +-
 drivers/usb/usbip/vudc_sysfs.c                         |   2 +-
 drivers/video/fbdev/aty/radeon_base.c                  |   4 +-
 drivers/video/fbdev/udlfb.c                            |   4 +-
 drivers/virt/coco/guest/tsm-mr.c                       |   8 +-
 drivers/w1/slaves/w1_ds2406.c                          |   4 +-
 drivers/w1/slaves/w1_ds2408.c                          |   2 +-
 drivers/w1/slaves/w1_ds2413.c                          |   2 +-
 drivers/w1/slaves/w1_ds2430.c                          |   2 +-
 drivers/w1/slaves/w1_ds2431.c                          |   2 +-
 drivers/w1/slaves/w1_ds2433.c                          |  12 +-
 drivers/w1/slaves/w1_ds2438.c                          |   2 +-
 drivers/w1/slaves/w1_ds2780.c                          |   2 +-
 drivers/w1/slaves/w1_ds2781.c                          |   2 +-
 drivers/w1/slaves/w1_ds2805.c                          |   4 +-
 drivers/w1/slaves/w1_ds28e04.c                         |   2 +-
 drivers/w1/w1.c                                        |   2 +-
 drivers/zorro/zorro-sysfs.c                            |   4 +-
 fs/debugfs/file.c                                      |  89 ++++++-------=
-
 fs/debugfs/inode.c                                     |   2 +-
 fs/debugfs/internal.h                                  |   2 +-
 fs/resctrl/pseudo_lock.c                               |   4 -
 fs/sysfs/file.c                                        |  10 +-
 include/linux/container_of.h                           |   3 +
 include/linux/debugfs.h                                |   4 +-
 include/linux/device.h                                 |   5 +
 include/linux/property.h                               |   7 +-
 kernel/bpf/btf.c                                       |   2 +-
 kernel/bpf/sysfs_btf.c                                 |   2 +-
 kernel/module/sysfs.c                                  |  14 +--
 mm/page_idle.c                                         |   2 +-
 mm/vmscan.c                                            |   8 +-
 net/bridge/br_sysfs_br.c                               |   2 +-
 rust/bindings/bindings_helper.h                        |   2 +
 rust/helpers/auxiliary.c                               |  10 --
 rust/helpers/device.c                                  |  17 +++
 rust/helpers/dma.c                                     |   5 +
 rust/helpers/helpers.c                                 |   2 +
 rust/helpers/io.c                                      |  41 +++++++
 rust/helpers/of.c                                      |   8 ++
 rust/helpers/pci.c                                     |  10 --
 rust/helpers/platform.c                                |  10 --
 rust/helpers/property.c                                |   8 ++
 rust/kernel/acpi.rs                                    |  70 +++++++++++
 rust/kernel/auxiliary.rs                               |  49 ++++----
 rust/kernel/block/mq/tag_set.rs                        |  12 +-
 rust/kernel/cpu.rs                                     |   2 +-
 rust/kernel/cpufreq.rs                                 |  11 +-
 rust/kernel/device.rs                                  | 108 +++++++++++++=
++--
 rust/kernel/device/property.rs                         | 631 +++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
 rust/kernel/device_id.rs                               |  91 ++++++++++---=
-
 rust/kernel/devres.rs                                  | 289 +++++++++++++=
++++++++++++++++---------------
 rust/kernel/dma.rs                                     | 156 +++++++++++++=
+++++++++--
 rust/kernel/driver.rs                                  |  87 ++++++++++---=
-
 rust/kernel/drm/device.rs                              |   2 +-
 rust/kernel/drm/driver.rs                              |  14 ++-
 rust/kernel/faux.rs                                    |   2 +-
 rust/kernel/io.rs                                      |   5 +
 rust/kernel/io/mem.rs                                  | 279 +++++++++++++=
++++++++++++++++++++++++++++++
 rust/kernel/io/resource.rs                             | 230 +++++++++++++=
++++++++++++++++++++++
 rust/kernel/lib.rs                                     |   1 +
 rust/kernel/miscdevice.rs                              |  10 +-
 rust/kernel/net/phy.rs                                 | 108 +++++++++----=
----
 rust/kernel/of.rs                                      |  15 ++-
 rust/kernel/pci.rs                                     |  87 ++++++++-----=
-
 rust/kernel/platform.rs                                | 144 +++++++++++++=
+++++----
 rust/kernel/revocable.rs                               |   8 +-
 rust/kernel/types.rs                                   |  26 ++--
 rust/pin-init/src/lib.rs                               |  40 +++++--
 samples/kobject/kobject-example.c                      |   4 +-
 samples/kobject/kset-example.c                         |   4 +-
 samples/rust/rust_dma.rs                               |  14 ++-
 samples/rust/rust_driver_auxiliary.rs                  |   3 +-
 samples/rust/rust_driver_pci.rs                        |  30 +++--
 samples/rust/rust_driver_platform.rs                   | 147 +++++++++++++=
+++++++++-
 scripts/const_structs.checkpatch                       |   1 +
 201 files changed, 2956 insertions(+), 963 deletions(-)
 create mode 100644 rust/helpers/of.c
 create mode 100644 rust/helpers/property.c
 create mode 100644 rust/kernel/acpi.rs
 create mode 100644 rust/kernel/device/property.rs
 create mode 100644 rust/kernel/io/mem.rs
 create mode 100644 rust/kernel/io/resource.rs

