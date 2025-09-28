Return-Path: <linux-kernel+bounces-835601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3661ABA78D6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 23:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B855D16FBCE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4DE23B615;
	Sun, 28 Sep 2025 21:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dnUndF0Q"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695D422ACE3
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 21:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759096318; cv=none; b=f7bcvwKZyNlabJR49E//f2DLKl7k+zmTgcPEew9hFCAED2zojiGwl3GQlSGzsJ5T5ou0wrKLf9ulB0SJhadl4CQNChmiOMfmOIaGxNV2XZqIjFbQapYOUtoAJuC/aipOhQGFfe4RljVeMNcgdVkEeYx8UJSmNK5++0KaQUymYoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759096318; c=relaxed/simple;
	bh=jJjF9Z1If0vp+RkLq9QYvhHWOZlDdvvl02FzrjAZIuY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=i+O0FFtpBHx15kPrjptQ1QfkaF2UmqOHqPkq9S7yYg3S1FPNWfMCjD/hSV1e/ZugO7ArNYEtVXYtdaVzLx11KUaOxQ+xcMI/lS+xbaprbOVdb2qNSKNlmMlELFutvNQrKWbogF/ep2vEoUv2uJmy2UjTY2878LRWEYOMRzbAY1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dnUndF0Q; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3d50882cc2so138033266b.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 14:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759096312; x=1759701112; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O7gGrCqDLoDKgOMYir+QQzr+d0F80cmzls1C9OIIknI=;
        b=dnUndF0Qr+AsyEvgXv6YGlXMiC9ILpy67XUkmE1wQPSiY43TbyclE8+pJQg3Ph82zF
         aFCfX/jX/96cJUAGfiaEF5us+GjT96fnsq3IZRGCN8jmihlEYNrs1wuV5ys9a6w3L9sT
         A+SOe61Fevur/32eLN21MLIvHNE2NalPDUbc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759096312; x=1759701112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7gGrCqDLoDKgOMYir+QQzr+d0F80cmzls1C9OIIknI=;
        b=jyTUoZGXnHxZxy/q8kNoNuJ3SiMBIUd2R/hoSuDNXkO3W7Ov4P+5rfJgcw24GkI2HA
         phhfoPsNseSDjG7/kLN8Eztve1cz6TUXt7IYFED0yoetEZYQtOOY6aVfBWwfg33MB5vM
         mB34uvbLvOBKEjyBSQM823sGBg/2ieJk55nYBlhYavw18C6XmJRPBB9AbsCj2N19Vj3k
         ExsqHSopZXL6CIP0PzRTnKzgqfbl0PpCSUW61wL6QdBCU/V3vOgPz2usQwiDA4Wy+Kl5
         exXwZqSwZVVAGuJ8weRILubQi13b0a6H0kKm7mrdpY0RrY7r7fzR6tOR+DLMiRHOEjNa
         XvcQ==
X-Gm-Message-State: AOJu0YxHq3gYafJ8gmN7hZmKs/yw5H4QlvDpGPDVu75UEdUtFKbykZbw
	+74+wWNnQawKTfuxakwp0kq8YyOadJlWDKMhSXLFEc1SqvHupybD0HwIvYc5ROo91V+qnSbHCQQ
	rhdyL1Q8=
X-Gm-Gg: ASbGncvgSSawx2kfrGOECMSgvYX2SqExNPO9IGFgVlmSg3QdXTGMLQrROaZWA8Mk9r8
	j3MErYxg/2+xGM3jeP17ufSpaxhfVlXWiMDNgM6KA9YdrM8lMv5omKxYX3gjNpydV+KRRN5d5Ga
	IioHFAJ3q4MJDVKnhZFRS3VN2SGIXXvUzQ44NLaCKb+4vC1C4uyuSdlp27GwS1U5IQ34eac64Q7
	6fwtEfnJ746jQ1UIPJieBq+yFmbBvuYU5l60vuFPKFW4mOTD9s+cxebYlxsBnWO6+/Bh8Gd2zLI
	lWMRDOcESpybOlrHbPIqFg+/qndcu3MDyc2L5ZrLu7fpTxWBVLPTs+gFg35ZJciXav0ZQ4BlY6u
	/J6ROX+GWfft/rYlFJYJIQf7k79BY3IMuW5mlblCO7TrXEoffjjB/KwohpjPZaZ6SGKXWH3xE24
	I5sahqu80=
X-Google-Smtp-Source: AGHT+IFK9a6ANIJQAwAcozIsr92Alr4U0mnZKMZM4eMee39KP2qN9/0f1AIsKp6M8Q2fSC5snVpQ9g==
X-Received: by 2002:a17:907:3f9a:b0:b3e:26ae:7288 with SMTP id a640c23a62f3a-b3e26ae7cc3mr232110566b.8.1759096312279;
        Sun, 28 Sep 2025 14:51:52 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3f7b67b883sm23974566b.79.2025.09.28.14.51.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 14:51:51 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-62fca01f0d9so7687281a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 14:51:51 -0700 (PDT)
X-Received: by 2002:a17:907:7b9e:b0:b0c:b51b:81f6 with SMTP id
 a640c23a62f3a-b34bb50f1dcmr1551723566b.43.1759096310911; Sun, 28 Sep 2025
 14:51:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Sep 2025 14:51:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiX38oG6=xFBNLO0pnjqHfxzjd6-1kZ5Nv9HfqNC2PoFA@mail.gmail.com>
X-Gm-Features: AS18NWB-qD9nAMXn7q5q2sG6Y6Fl35JwUtEiRCCRDmbuGj08dohVZv2hW5A2CV0
Message-ID: <CAHk-=wiX38oG6=xFBNLO0pnjqHfxzjd6-1kZ5Nv9HfqNC2PoFA@mail.gmail.com>
Subject: Linux 6.17
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

No huge surprises this past week, so here we are, with kernel 6.17
pushed out and ready to go.

Below is the shortlog for just the last week - not the full 6.17
release - as usual.  It's not exciting, which is all good. I think the
biggest patch in there is some locking fixes for some bluetooth races
that could cause use-after-free situations. Whee - that's about as
exciting as it gets.

Other than that, there' the usual driver fixlets (GPU and networking
dominate as usual, but "dominate" is still pretty small), there's some
minor random other driver updates, some filesystem noise, and core
kernel and mm.

And some selftest updates.

This obviously means that the merge window for 6.18 will open
tomorrow, and I already have four dozen pull requests pending. Thanks
to the proactive people - you know who you are. But before the merge
window opens, there's still time for some final kicking of the tires
of the newest release.

Thanks,
           Linus

---

Adri=C3=A1n Larumbe (1):
      drm/panthor: Defer scheduler entity destruction to queue release

Akinobu Mita (1):
      mm/damon/sysfs: do not ignore callback's return value in
damon_sysfs_damon_call()

Alexander Popov (1):
      x86/Kconfig: Reenable PTDUMP on i386

Alexandre Ghiti (1):
      riscv: Use an atomic xchg in pudp_huge_get_and_clear()

Alok Tiwari (2):
      vhost-scsi: fix argument order in tport allocation error message
      bnxt_en: correct offset handling for IPv6 destination address

Alvin Lee (1):
      drm/amd/display: Use mpc.preblend flag to indicate preblend

Alyssa Rosenzweig (1):
      MAINTAINERS: remove Alyssa Rosenzweig

Alyssa Ross (1):
      virtio_config: clarify output parameters

Amit Chaudhari (1):
      HID: asus: add support for missing PX series fn keys

Andrea Righi (1):
      sched_ext: idle: Handle migration-disabled tasks in BPF code

Andrew Morton (1):
      include/linux/pgtable.h: convert arch_enter_lazy_mmu_mode() and
friends to static inlines

Ashwini Sahu (1):
      uapi: vduse: fix typo in comment

Basavaraj Natikar (1):
      HID: amd_sfh: Add sync across amd sfh work functions

Bastien Curutchet (Schneider Electric) (1):
      spi: omap2-mcspi: drive SPI_CLK on transfer_setup()

Bence Cs=C3=B3k=C3=A1s (1):
      mailmap: add entry for Bence Cs=C3=B3k=C3=A1s

Calvin Owens (1):
      Bluetooth: Fix build after header cleanup

Carolina Jubran (1):
      net/mlx5e: Fix missing FEC RS stats for RS_544_514_INTERLEAVED_QUAD

Chen Yufeng (1):
      can: hi311x: fix null pointer dereference when resuming from
sleep before interface was enabled

Christian Loehle (1):
      cpufreq: Initialize cpufreq-based invariance before subsys

Christian Marangi (2):
      pinctrl: airoha: fix wrong PHY LED mux value for LED1 GPIO46
      pinctrl: airoha: fix wrong MDIO function bitmaks

Christoffer Sandberg (1):
      platform/x86/amd/pmc: Add Stellaris Slim Gen6 AMD to spurious
8042 quirks list

Claudiu Beznea (1):
      i2c: riic: Allow setting frequencies lower than 50KHz

Conor Dooley (1):
      riscv: dts: allwinner: rename devterm i2c-gpio node to comply with bi=
nding

Dan Carpenter (1):
      octeontx2-pf: Fix potential use after free in otx2_tc_add_flow()

Daniel Lee (1):
      platform/x86: lg-laptop: Fix WMAB call in fan_mode_store()

Duy Nguyen (1):
      can: rcar_canfd: Fix controller mode setting

Eric Biggers (2):
      crypto: af_alg - Fix incorrect boolean values in af_alg_ctx
      kmsan: fix out-of-bounds access to shadow memory

Hans de Goede (1):
      gpiolib: Extend software-node support to support secondary software-n=
odes

Ido Schimmel (3):
      nexthop: Forbid FDB status change while nexthop is in a group
      selftests: fib_nexthops: Fix creation of non-FDB nexthops
      selftests: fib_nexthops: Add test cases for FDB status change

Ioana Ciornei (1):
      gpio: regmap: fix memory leak of gpio_regmap structure

Ivan Pravdin (1):
      rtla: Fix buffer overflow in actions_parse

Jacob Keller (4):
      broadcom: fix support for PTP_PEROUT_DUTY_CYCLE
      broadcom: fix support for PTP_EXTTS_REQUEST2 ioctl
      ptp: document behavior of PTP_STRICT_FLAGS
      libie: fix string names for AQ error codes

Jakub Acs (1):
      fs/proc/task_mmu: check p->vec_buf for NULL

Jane Chu (1):
      mm/hugetlb: fix copy_hugetlb_page_range() to use ->pt_share_count

Janne Grunau (1):
      HID: lenovo: Use KEY_PERFORMANCE instead of ACPI's platform_profile

Jarkko Nikula (1):
      MAINTAINERS: Remove myself as Synopsys DesignWare I2C maintainer

Jason Baron (1):
      net: allow alloc_skb_with_frags() to use MAX_SKB_FRAGS

Jason Gunthorpe (4):
      iommufd: Fix refcounting race during mmap
      iommufd: Fix race during abort for file descriptors
      iommufd: WARN if an object is aborted with an elevated refcount
      iommufd/selftest: Update the fail_nth limit

Jason Wang (2):
      vhost-net: unbreak busy polling
      vhost-net: flush batched before enabling notifications

Jens Axboe (2):
      block: fix EOD return for device with nr_sectors =3D=3D 0
      MAINTAINERS: update io_uring and block tree git trees

Jihed Chaibi (2):
      ARM: dts: armada-370-db: Fix stereo audio input routing on Armada 370
      ARM: dts: kirkwood: Fix sound DAI cells for OpenRD clients

Jimmy Hon (1):
      arm64: dts: rockchip: Fix the headphone detection on the orangepi 5

Jinjiang Tu (1):
      mm/hugetlb: fix folio is still mapped when deleted

Johan Hovold (1):
      reset: eyeq: fix OF node leak

Johannes Thumshirn (1):
      btrfs: zoned: don't fail mount needlessly due to too many active zone=
s

Josua Mayer (3):
      arm64: dts: marvell: cn913x-solidrun: fix sata ports status
      arm64: dts: marvell: cn9132-clearfog: disable eMMC high-speed modes
      arm64: dts: marvell: cn9132-clearfog: fix multi-lane pci x2 and x4 po=
rts

Khairul Anuar Romli (1):
      spi: cadence-qspi: defer runtime support on socfpga if reset bit
is enabled

Krzysztof Kozlowski (1):
      ARM: dts: allwinner: Minor whitespace cleanup

Leo Li (1):
      drm/amd/display: Init DCN35 clocks from pre-os HW values

Linus Torvalds (1):
      Linux 6.17

Lizhi Xu (1):
      netfs: Prevent duplicate unlocking

Louis-Alexis Eyraud (1):
      pmdomain: mediatek: set default off flag for MT8195 AUDIO power domai=
n

Lucas De Marchi (1):
      drm/xe: Fix build with CONFIG_MODULES=3Dn

Luiz Augusto von Dentz (4):
      Bluetooth: hci_sync: Fix hci_resume_advertising_sync
      Bluetooth: hci_event: Fix UAF in hci_conn_tx_dequeue
      Bluetooth: hci_event: Fix UAF in hci_acl_create_conn_sync
      Bluetooth: MGMT: Fix possible UAFs

Lukas Bulwahn (1):
      ARM: imx: Kconfig: Adjust select after renamed config option

Lukasz Czapnik (8):
      i40e: add validation for ring_len param
      i40e: fix idx validation in i40e_validate_queue_map
      i40e: fix idx validation in config queues msg
      i40e: fix input validation logic for action_meta
      i40e: fix validation of VF state in get resources
      i40e: add max boundary check for VF filters
      i40e: add mask to apply valid bits for itr_idx
      i40e: improve VF MAC filters accounting

Marcin Juszkiewicz (1):
      arm64: dts: rockchip: Add vcc supply for SPI Flash on NanoPC-T6

Masami Hiramatsu (Google) (4):
      tracing: dynevent: Add a missing lockdown check on dynevent
      tracing: fprobe: Fix to remove recorded module addresses from filter
      tracing: dynevent: Add a missing lockdown check on dynevent
      tracing: fgraph: Protect return handler from recursion loop

Matthew Schwartz (1):
      drm/amd/display: Only restore backlight after amdgpu_dm_init or dm_re=
sume

Max Kellermann (1):
      netfs: fix reference leak

Melissa Wen (1):
      drm/amd/display: remove output_tf_change flag

Michael S. Tsirkin (1):
      Revert "vhost/net: Defer TX queue re-enable until after sendmsg"

Michal Wajdeczko (1):
      drm/xe/vf: Don't expose sysfs attributes not applicable for VFs

Mika Westerberg (1):
      MAINTAINERS: Add me as maintainer of Synopsys DesignWare I2C driver

Moshe Shemesh (1):
      net/mlx5: fs, fix UAF in flow counter release

Mukesh Kumar Savaliya (1):
      MAINTAINERS: Update email address for Qualcomm's I2C GENI maintainers

Nickolay Goppen (1):
      platform/x86: dell-lis3lv02d: Add Latitude E6530

Nirmoy Das (1):
      drm/ast: Use msleep instead of mdelay for edid read

Nobuhiro Iwamatsu (1):
      ARM: dts: socfpga: sodia: Fix mdio bus probe and PHY address

Or Har-Toov (1):
      IB/mlx5: Fix obj_type mismatch for SRQ event subscriptions

Paul Walmsley (1):
      MAINTAINERS: Update Paul Walmsley's E-mail address

Paulo Alcantara (1):
      smb: client: handle unlink(2) of files open by different clients

Peng Fan (4):
      firmware: imx: Add stub functions for SCMI MISC API
      firmware: imx: Add stub functions for SCMI LMM API
      firmware: imx: Add stub functions for SCMI CPU API
      arm64: dts: imx8mp: Correct thermal sensor index

Peter Hilber (1):
      MAINTAINERS, mailmap: Update address for Peter Hilber

Peter Zijlstra (2):
      sched/deadline: Fix dl_server getting stuck
      sched/deadline: Fix dl_server behaviour

Petr Malat (1):
      ethernet: rvu-af: Remove slash from the driver name

Petr Pavlu (1):
      ARM: 9458/1: module: Ensure the override of module_arch_freeing_init(=
)

Russell King (Oracle) (1):
      ARM64: dts: mcbin: fix SATA ports on Macchiatobin

Sabrina Dubroca (2):
      xfrm: xfrm_alloc_spi shouldn't use 0 as SPI
      xfrm: fix offloading of cross-family tunnels

Samasth Norway Ananda (1):
      fbcon: fix integer overflow in fbcon_do_set_font

Sang-Heon Jeon (1):
      smb: client: fix wrong index reference in smb2_compound_op()

Sebastian Andrzej Siewior (3):
      futex: Prevent use-after-free during requeue-PI
      vhost: Take a reference on the task in struct vhost_task.
      futex: Use correct exit on failure from futex_hash_allocate_default()

Shyam Sundar S K (1):
      platform/x86/dell: Set USTT mode according to BIOS after reboot

Sidraya Jayagond (1):
      net/smc: fix warning in smc_rx_splice() when calling get_page()

Stefan Metzmacher (2):
      smb: server: don't use delayed_work for post_recv_credits_work
      smb: server: use disable_work_sync in transport_rdma.c

St=C3=A9phane Grosjean (1):
      can: peak_usb: fix shift-out-of-bounds issue

Suraj Kandpal (1):
      drm/i915/ddi: Guard reg_val against a INVALID_TRANSCODER

Sven Eckelmann (1):
      i2c: rtl9300: Drop unsupported I2C_FUNC_SMBUS_I2C_BLOCK

S=C3=A9bastien Szymanski (1):
      HID: cp2112: fix setter callbacks return value

Taotao Chen (1):
      drm/i915: set O_LARGEFILE in __create_shmem()

Thierry Reding (1):
      firmware: tegra: Do not warn on missing memory-region property

Thomas Gleixner (2):
      x86/topology: Implement topology_is_core_online() to address SMT
regression
      kbuild: Disable CC_HAS_ASM_GOTO_OUTPUT on clang < 17

Thomas Hellstr=C3=B6m (1):
      drm/xe: Don't copy pinned kernel bos twice on suspend

Thomas Zimmermann (1):
      fbcon: Fix OOB access in font allocation

Troy Mitchell (1):
      MAINTAINERS: add entry for SpacemiT K1 I2C driver

Vincent Mailhol (4):
      can: etas_es58x: populate ndo_change_mtu() to prevent buffer overflow
      can: hi311x: populate ndo_change_mtu() to prevent buffer overflow
      can: sun4i_can: populate ndo_change_mtu() to prevent buffer overflow
      can: mcba_usb: populate ndo_change_mtu() to prevent buffer overflow

Vladimir Oltean (2):
      net: dsa: lantiq_gswip: move gswip_add_single_port_br() call to
port_setup()
      net: dsa: lantiq_gswip: suppress -EINVAL errors for bridge FDB
entries added to the CPU port

Wander Lairson Costa (1):
      rtla/actions: Fix condition for buffer reallocation

Wang Liang (2):
      net: tun: Update napi->skb after XDP process
      tracing/osnoise: Fix slab-out-of-bounds in _parse_integer_limit()

Wolfram Sang (1):
      MAINTAINERS: delete email for Tharun Kumar P

Xinpeng Sun (2):
      HID: intel-thc-hid: intel-quicki2c: Add WCL Device IDs
      HID: intel-thc-hid: intel-quickspi: Add WCL Device IDs

Yevgeny Kliteynik (1):
      net/mlx5: HWS, ignore flow level for multi-dest table

Yixun Lan (1):
      dt-bindings: i2c: spacemit: extend and validate all properties

Zabelin Nikita (1):
      drm/gma500: Fix null dereference in hdmi teardown

Zhen Ni (1):
      afs: Fix potential null pointer dereference in afs_put_server

