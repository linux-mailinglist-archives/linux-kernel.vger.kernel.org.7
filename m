Return-Path: <linux-kernel+bounces-747302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4346EB1320D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 23:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630A6174EDF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 21:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5026524729F;
	Sun, 27 Jul 2025 21:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UnljtTXh"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2F04A11
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753653553; cv=none; b=H+nDzhwX+qZc1LymFt45OgNSdloh2GzL3g/lX5bJUSUfIY5nDv86ZkbPcr22NEFlEtlYIQR4ACKYtQKZ12lAZZ6xfjP6RA4rpLlT9+DZgjGsd1FEyyj+4dA84cFwr1Gu5KEv3HLRtCI8WxaLQVgq6ee8VgM16MMU70ExjBE5NKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753653553; c=relaxed/simple;
	bh=xNRJyHs14TJJQdv1J1Eb2o1HR/ctW2zgTS/cvNXAcH4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=CnOWcwcu6PG6SWG1Sf3mS/oNccGu9P2AJJrXtjWL6Hndwv6edFA/3wZHEtcstypHdnwPSFexpoUDrm2jInTLyzOI7xUIw3DFyMF0X9iPlk/oK0fBGq7hyo/bkjv+T3TQ08WtJPex9C3fb3wAiQnN+dzy/+VOcWPGT9bSZlNSVXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UnljtTXh; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae3be3eabd8so804582466b.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 14:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753653548; x=1754258348; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aGb5TdSu7kpg9jIB6ccnGpd+BCuGK8AbWFoU798kBrc=;
        b=UnljtTXhoyNplaJ2ImyzBjSiQ/by9yAwFTuQ5OFXLEqjeVa96Bt/UKCtNDfYr9DL5V
         hPFRQ0qEQS7XKkf4h6zf9t+EMYaPCOFS2gS3prsdDONAQZQfIoYe9eH8tMc7noRKQfJx
         D6/BXhY9BsrfzVBJrtgk+XyaZlrZqMpRk9g+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753653548; x=1754258348;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aGb5TdSu7kpg9jIB6ccnGpd+BCuGK8AbWFoU798kBrc=;
        b=hG8HnsXL8wdYpTmm3pwjAiowBh7BEMg4JndetEQwp8HuAtK1FbfbckeZjb74Ri6A5O
         7LY+91pSMPMHwbimn4AyuV/K02jjTPudxYzjMVsfQnU/lqW8CWFUmu/iO/+vJDQ6oS4+
         FEoKcIIXBwGQOD2tnM561jSZZAHUUihWQTnkaBHHdkGaNGDfkBI1u5QAjWgccDbiYajh
         KhWILYTOZAZWTk6aipBnvw12pmWbcyvBN0qcuOJEs6i8q1yxsKHIANNC/JiGg6We2GZU
         NRIseTz8SPJ2KVcwAixb3bOonOfUFRvHEumrMqr2E/qvoezGVqxfctDZzmq8aZJypW30
         xeQw==
X-Gm-Message-State: AOJu0YzlxQUDSSZBLOdrIvYu6YWpqLoWctUgtCF+ATDt7J+9D5PEiLRn
	AEgtNLO5S2g9XJ2as/JqPrJ+p5HOnCIx/XAuTapsWD/Y2iyL9Q8fGf/2Y7PSCJP5NUi2Mq/xuWm
	GOpYAYwOrVA==
X-Gm-Gg: ASbGncs8dMS0CKf0+zlqVvDeXWXJ43jodOm+Ec+Y25aa/ZG95/WMs4uaOIO0vaonwx3
	kH0oAL0XByefCOBxhLYKN2IxcaSHjUnwdHJTCS/uUg/uM9UcG7+lm/nMF3PQImya6g0D6e15zoe
	o2pwaPv4YTys3a6Zw3/mb6wcSGYYurtmP7fzlk+XkVfpgaYIgpVT2d3GnO4WNkj8Qy4GukE7HbY
	RZd08ZdWZoDxoYiUrDurDC82ypNsu5Uyt++pMQ/Hc46QC3zrPkLarDBp/XTcyx1tFzc4uQlmWDU
	oI5lT4sr+R4lfXxWUAx+1uIUAiVY1BErDFo434B1DijzGptpErizg5U8UuKfU1qzg+I14gaTDU7
	p/DBsVInVmi6yDkbpn0G796XXzko9FzqIbrzZCK6uycH/VnBZe6T26YmywADPCysfmzhayYbS
X-Google-Smtp-Source: AGHT+IHm84SxCZt4Sl9NBneX3mbS9oHTwu5TkL38ZDzOJRuuAhs8X+0GtLPZEB0GI7Z9+XzNg65YGA==
X-Received: by 2002:a17:907:7254:b0:af1:4c23:c8c8 with SMTP id a640c23a62f3a-af61ca9a136mr1055342666b.12.1753653548168;
        Sun, 27 Jul 2025 14:59:08 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af63585fff3sm333866866b.21.2025.07.27.14.59.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jul 2025 14:59:07 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae0b2ead33cso690979166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 14:59:07 -0700 (PDT)
X-Received: by 2002:a17:907:9486:b0:af1:69e3:c074 with SMTP id
 a640c23a62f3a-af4c242952dmr1579713466b.8.1753653546884; Sun, 27 Jul 2025
 14:59:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 27 Jul 2025 14:58:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh0kuQE+tWMEPJqCR48F4Tip2EeYQU-mi+2Fx_Oa1Ehbw@mail.gmail.com>
X-Gm-Features: Ac12FXwqzO_968yuOQM4ul7Flg8sTmDtlX1M7__z0yNqnOSWsUBV385uogIQAI0
Message-ID: <CAHk-=wh0kuQE+tWMEPJqCR48F4Tip2EeYQU-mi+2Fx_Oa1Ehbw@mail.gmail.com>
Subject: Linux 6.16
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It's Sunday afternoon, and the release cycle has come to an end. Last
week was nice and calm, and there were no big show-stopper surprises
to keep us from the regular schedule, so I've tagged and pushed out
6.16 as planned.

It's worth noting that the upcoming merge window for 6.17 is going to
be slightly chaotic for me: I have multiple family events this August
(a wedding and a big birthday), and with said family being spread not
only across the US, but in Finland too, I'm spending about half the
month traveling.

That means that I will try very hard to get most of the merge window
done the first week before my travels start, and I already ended up
giving a heads-up on that to the people who tend to send me the most
pull requests. An indeed, I already have 50 pull requests pending, so
thanks to people who took that heads-up to heart.

So I hope that the merge window will be smooth despite my travel
schedule, but I wanted to to just mention this just in case: if I end
up unable to deal with all merge window pull requests the second week,
I might delay rc1 a bit just to catch up.

That does not mean that I'll be more lenient to late pull requests
(probably quite the reverse, since it's just going to add to the
potential chaos), it just means that I might have some pulls that I
ended up delaying until I got back home (only for then fly off again a
week later to the second event). So if I don't cut a -rc1 like
clockwork in two weeks, don't panic - it just means I'll do it a few
days later.

Again: I *think* it's all going to be fine and we'll have a normal
merge window schedule, I'm just mentioning this as a "things might not
go as smoothly as I hope because I'm off gallivanting on family
business" possibility.

But enough about the next release. The *current* release is out, and
looks fine, and as mentioned last week was really small and calm.
Shortlog for that below for people who want to see the details, but
it's really not all that interesting (in all the best ways!). It's
almost all small driver fixlets, with some random noise sprinkled
around elsewhere. Not a lot of patches, and they are all small.

                        Linus
---

Aakash Deep Sarkar (1):
      drm/i915/display: Fix dma_fence_wait_timeout() return value handling

Ada Couprie Diaz (1):
      arm64/entry: Mask DAIF in cpu_switch_to(), call_on_irq_stack()

Akhil R (1):
      i2c: tegra: Fix reset error handling with ACPI

Akinobu Mita (1):
      resource: fix false warning in __request_region()

Al Viro (1):
      fix the regression in ufs options parsing

Armin Wolf (3):
      power: supply: core: Add power_supply_get/set_property_direct()
      power: supply: test-power: Test access to extended power supply
      platform/x86: dell-ddv: Fix taking the psy->extensions_sem lock twice

Arnd Bergmann (1):
      Revert "drm/nouveau: check ioctl command codes better"

Arunpravin Paneer Selvam (1):
      drm/amdgpu: Reset the clear flag in buddy during resume

Ben Skeggs (1):
      drm/nouveau/nvif: fix null ptr deref on pre-fermi boards

Chen-Yu Tsai (2):
      clk: sunxi-ng: a523: Mark MBUS clock as critical
      arm64: dts: allwinner: a523: Rename emac0 to gmac0

Chiara Meiohas (1):
      net/mlx5: Fix memory leak in cmd_exec()

Dawid Rezler (1):
      ALSA: hda/realtek - Add mute LED support for HP Pavilion 15-eg0xxx

Dennis Chen (1):
      i40e: report VF tx_dropped with tx_errors instead of tx_discards

Derek Fang (1):
      ASoC: rt5650: Eliminate the high frequency glitch

Diederik de Haas (1):
      arm64: dts: rockchip: Drop netdev led-triggers on NanoPi R5S

Douglas Anderson (1):
      drm/bridge: ti-sn65dsi86: Remove extra semicolon in ti_sn_bridge_prob=
e()

Edip Hazuri (1):
      ALSA: hda/realtek - Add mute LED support for HP Victus 15-fa0xxx

Edward Adam Davis (1):
      afs: Set vllist to NULL if addr parsing fails

Erick Karanja (1):
      ALSA: usb-audio: qcom: Adjust mutex unlock order

Eyal Birger (1):
      xfrm: interface: fix use-after-free after changing collect_md
xfrm interface

Fernando Fernandez Mancera (1):
      xfrm: ipcomp: adjust transport header after decompressing

Florian Fainelli (1):
      net: bcmasp: Restore programming of TX map vector register

Florian Westphal (1):
      selftests: netfilter: tone-down conntrack clash test

Gabor Juhos (1):
      spi: spi-qpic-snand: don't hardcode ECC steps

Guoqing Jiang (1):
      ASoC: mediatek: mt8365-dai-i2s: pass correct size to mt8365_dai_set_p=
riv

Halil Pasic (1):
      s390/ism: fix concurrency management in ism_cmd()

Haoxiang Li (1):
      ice: Fix a null pointer dereference in ice_copy_and_init_pkg()

Harry Yoo (1):
      mm/zsmalloc: do not pass __GFP_MOVABLE if CONFIG_COMPACTION=3Dn

Himanshu Mittal (1):
      net: ti: icssg-prueth: Fix buffer allocation for ICSSG

Jacek Kowalski (2):
      e1000e: disregard NVM checksum on tgp when valid checksum bit is not =
set
      e1000e: ignore uninitialized checksum word on tgp

Jack Thomson (1):
      arm64: kvm, smccc: Fix vendor uuid

Jackie Dong (1):
      lenovo-wmi-hotkey: Avoid triggering error -5 due to missing mute LED

Jamie Bainbridge (1):
      i40e: When removing VF MAC filters, only check PF-set MAC

Jan-Niklas Burfeind (1):
      platform/x86: dell-lis3lv02d: Add Precision 3551

Jason Gunthorpe (1):
      mm: update MAINTAINERS entry for HMM

Jian Shen (2):
      net: hns3: fix concurrent setting vlan filter issue
      net: hns3: fixed vf get max channels bug

Jijie Shao (1):
      net: hns3: default enable tx bounce buffer when smmu enabled

Jinjiang Tu (1):
      mm/vmscan: fix hwpoisoned large folio handling in shrink_folio_list

Jithu Joseph (1):
      MAINTAINERS: Update entries for IFS and SBL drivers

Johan Hovold (2):
      platform: arm64: huawei-gaokun-ec: fix OF node leak
      ASoC: mediatek: common: fix device and OF node leak

Kees Cook (1):
      MAINTAINERS: Add in6.h to MAINTAINERS

Kent Overstreet (3):
      bcachefs: btree_node_scan: don't re-read before initializing
found_btree_node
      bcachefs: Fix write buffer flushing from open journal entry
      bcachefs: Add missing snapshots_seen_add_inorder()

Kito Xu (veritas501) (1):
      net: appletalk: Fix use-after-free in AARP proxy probe

Kurt Borja (2):
      platform/x86: alienware-wmi-wmax: Fix `dmi_system_id` array
      platform/x86: alieneware-wmi-wmax: Add AWCC support to more laptops

Leo Stone (1):
      afs: Fix check for NULL terminator

Leon Romanovsky (1):
      xfrm: always initialize offload path

Lin.Cao (1):
      drm/sched: Remove optimization that causes hang when killing
dependent jobs

Linus Torvalds (1):
      Linux 6.16

Lucas De Marchi (1):
      drm/xe: Fix build without debugfs

Ma Ke (3):
      bus: fsl-mc: Fix potential double device reference in
fsl_mc_get_endpoint()
      dpaa2-eth: Fix device reference count leak in MAC endpoint handling
      dpaa2-switch: Fix device reference count leak in MAC endpoint handlin=
g

Manivannan Sadhasivam (1):
      PCI/pwrctrl: Create pwrctrl devices only when CONFIG_PCI_PWRCTRL
is enabled

Manuel Andreas (1):
      KVM: x86/xen: Fix cleanup logic in emulation of Xen schedop poll
hypercalls

Marc Kleine-Budde (1):
      can: netlink: can_changelink(): fix NULL pointer deref of struct
can_priv::do_set_mode

Marco Elver (1):
      kasan: use vmalloc_dump_obj() for vmalloc error reports

Markus Bl=C3=B6chl (1):
      timekeeping: Zero initialize system_counterval when querying
time from phc drivers

Matthieu Baerts (NGI0) (2):
      selftests: mptcp: connect: also cover alt modes
      selftests: mptcp: connect: also cover checksum

Nathan Chancellor (3):
      mm/ksm: fix -Wsometimes-uninitialized from clang-21 in advisor_mode_s=
how()
      ARM: 9448/1: Use an absolute path to unified.h in KBUILD_AFLAGS
      ARM: 9450/1: Fix allowing linker DCE with binutils < 2.36

Nilay Shroff (1):
      block: fix module reference leak in mq-deadline I/O scheduler

Nimrod Oren (1):
      selftests: drv-net: wait for iperf client to stop sending

Paul Kocialkowski (3):
      clk: sunxi-ng: v3s: Fix CSI SCLK clock name
      clk: sunxi-ng: v3s: Fix CSI1 MCLK clock name
      clk: sunxi-ng: v3s: Fix TCON clock parents

Praveen Kaligineedi (1):
      gve: Fix stuck TX queue for DQ queue format

Ranjani Sridharan (1):
      ASoC: SOF: Intel: PTL: Add the sdw_process_wakeen op

Rong Zhang (2):
      platform/x86: ideapad-laptop: Fix FnLock not remembered among boots
      platform/x86: ideapad-laptop: Fix kbd backlight not remembered among =
boots

Ryusuke Konishi (1):
      nilfs2: reject invalid file types when reading inodes

SHARAN KUMAR M (1):
      ALSA: hda/realtek: Fix mute LED mask on HP OMEN 16 laptop

Sabrina Dubroca (4):
      xfrm: state: initialize state_ptrs earlier in xfrm_state_find
      xfrm: state: use a consistent pcpu_id in xfrm_state_find
      xfrm: delete x->tunnel as we delete x
      Revert "xfrm: destroy xfrm_state synchronously on net exit path"

SeongJae Park (1):
      mm/damon/core: commit damos_quota_goal->nid

Sergey Senozhatsky (1):
      mailmap: add entry for Senozhatsky

Shahar Shitrit (1):
      net/mlx5: E-Switch, Fix peer miss rules to use peer eswitch

Shravan Kumar Ramani (3):
      platform/mellanox: mlxbf-pmc: Remove newline char from event name inp=
ut
      platform/mellanox: mlxbf-pmc: Validate event/enable input
      platform/mellanox: mlxbf-pmc: Use kstrtobool() to check 0/1 input

Shuming Fan (1):
      ASoC: SDCA: correct the calculation of the maximum init table size

Stephen Rothwell (1):
      sprintf.h requires stdarg.h

Thomas Zimmermann (7):
      Revert "drm/virtio: Use dma_buf from GEM object instance"
      Revert "drm/vmwgfx: Use dma_buf from GEM object instance"
      Revert "drm/etnaviv: Use dma_buf from GEM object instance"
      Revert "drm/prime: Use dma_buf from GEM object instance"
      Revert "drm/gem-framebuffer: Use dma_buf from GEM object instance"
      Revert "drm/gem-shmem: Use dma_buf from GEM object instance"
      Revert "drm/gem-dma: Use dma_buf from GEM object instance"

Tobias Brunner (1):
      xfrm: Set transport header to fix UDP GRO handling

Torsten Hilbrich (1):
      platform/x86: Fix initialization order for firmware_attributes_class

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915/dp: Fix 2.7 Gbps DP_LINK_BW value on g4x

Viresh Kumar (1):
      i2c: virtio: Avoid hang by using interruptible completion wait

Xiang Mei (1):
      net/sched: sch_qfq: Avoid triggering might_sleep in atomic
context in qfq_delete_class

Yang Xiwen (1):
      i2c: qup: jump out of the loop in case of timeout

Yonglong Liu (1):
      net: hns3: disable interrupt when ptp init failed

Zi Yan (1):
      selftests/mm: fix split_huge_page_test for folio_split() tests

