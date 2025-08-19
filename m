Return-Path: <linux-kernel+bounces-774922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FDCB2B93A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F8DA5286E3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164301E5705;
	Tue, 19 Aug 2025 06:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="aRzNuSld"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C83A25DB1C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755584105; cv=none; b=mcId4puygXNrTsuAU32RORGvwCuUWW3+RjkDdq7CRBEhikWPoDTs+41uDO4NhTnsTl8sA6m1Wr56hjLsP9Fc2scE0A4Pc2PTmC84kWTlJeepe6Zf6o25oMSR4X/06pAAUk/KG50KAWvKLV1hDa1jrM3Kg7VRFkJyHdy/QUIKkdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755584105; c=relaxed/simple;
	bh=Vsvobzyd+pWIGRqDH6FmhjP2NbQY9Nu/5YdKYy+n1fE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RdZdBu+TAj0VmiNujCtSFOM+S/bGLXgYE+Uj3MdzepNWjS5et0nZqShehnv5PGgrG5yH3Mmtidlo+H7h8N8IziMif0IjsE+Xv8AE57O9res36cNymL/1OlvVAu8KQaRxBPR2lzjzy2p9EktQru2GTfHBRrjprS0qtAxTn1Vqbzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=aRzNuSld; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61a54560c1fso198173a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 23:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1755584102; x=1756188902; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vsvobzyd+pWIGRqDH6FmhjP2NbQY9Nu/5YdKYy+n1fE=;
        b=aRzNuSld1sdQXu/TnnDu7Q/xO2hUhS52ZtD8ripb2VB0q8XZfOKfFXdYwgyn8xRmbu
         IuY2wEOWK4PbRwRscBDPlUTOmuCj14wMmtyrJiqUGlpkR5RTghjD3YGg5TXo6XnFLv97
         ZkHmEF/Utqai4POYrcQM5lnhKOEzEZDNRbyequ9bve0al7yER1wUdX0NMueNArYsziT0
         zR76z2sA/SMrF5d5RIdlbA5H7wB9r9dus6IxWvB/bNVs/NfxtSozLFc+1o21qrGHtS9z
         RkISXC2SRvdRGWv+htWvW09G1xsKpXabEEAbzVp5ATgz2oyTNvVlhKMcyiTu8J6RXD6/
         7K4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755584102; x=1756188902;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vsvobzyd+pWIGRqDH6FmhjP2NbQY9Nu/5YdKYy+n1fE=;
        b=ICnRG3VGGnk8NXa9t90WIhkl947rITHZ4O8J6bwn+lezLM00u4vWrxNlf/j77Xb8T7
         jnrsQjRYRkvISSrf5ig+c61X/h5h741P5Iazc5e4EGJWyMsdjgaMCA9PkAvBjFsBIVHe
         HikMWFHwzr53rKIvx52nPH+4V3QBEWnwTKXCxao3Rr5uR7MIO+MpYqJsS/6aqHFR4Dem
         cJloCrvwTGZ6j4qM2s7u2vxxdlf5Gal6Ncj9/M9fB39QTUtKxJ0ixtx9Qtu5KpMwsTSl
         9PNi78e24/Bj2HKWNfncndQ93V+vxNhWvEhTXNcqNfsqCMic19j/F2CK5fFva5lLDJ7T
         Jabw==
X-Forwarded-Encrypted: i=1; AJvYcCWHWlRXjXKaeTgDRyoFRTqJyxIDpoCJXupVlDjSIos8FFkkbrqh3ugKZxoa7+zloenPDTxRZ4PgrpNsS20=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU+IH1gHwVmTOTuE/T2r2MOSm5s5LEZWgpZBEx0/idpgKm26lj
	EnbR8OT5x5W30FfheHiQcZqswdt22j6CxCaJ/EqqUcd7YUIwLJ6wfxlQn/i4wUGa2ZSE9D1VFw8
	Td8O+HM4I2erRlDgDrUFhf5nYEzaGx5aNpHbR97b6yQ==
X-Gm-Gg: ASbGnctSD4FkJe1K1wsTlwPRp0oZgipUsqgd9CM4c4KjNWB2f7cbBd5npKS0TCSkfqp
	POPh7gvbVe2ov6C90W0owowWAKU0BUskq40LRhwKtEF6yiLrH1naQOwJKHP+nPkyBMapEfKYYvx
	etuRUp32NDscHLms3wx0z9VXWD+V+gLPPs0+nF+FnJdn2LmuaGBEMOodBpqaoPNLjw68E0j9l9O
	4DGYiin/i4Z/bRqsLt4t81/Gu2LWqq6UefjvweL
X-Google-Smtp-Source: AGHT+IF60qmQBNGeuGMzeBotisgEDbW7PjNxj5396q9ryZKwWzXVpap9pJfjv+PyBl7UsTNLGVMAKw9ukmWer7/vSv4=
X-Received: by 2002:a05:6402:4407:b0:615:d492:5bf3 with SMTP id
 4fb4d7f45d1cf-61a7e754f7emr553281a12.6.1755584101577; Mon, 18 Aug 2025
 23:15:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Tue, 19 Aug 2025 08:14:50 +0200
X-Gm-Features: Ac12FXw85l4E2Qzdz4eZU-25DlZgTxIbtrb7-5QJx5Gc3_Ih2bUSGVXILRmFHlg
Message-ID: <CAMGffEmFm8wvgiw+s0ZpOhRxBLOz3dQiS=sQCkgJLD6qC3VwJg@mail.gmail.com>
Subject: [BUG] amd-ucode 20250808: "No sha256 digest for patch ID: 0xa0011de"
 on Linux 6.12.37
To: x86@kernel.org, Borislav Petkov <bp@alien8.de>
Cc: linux-firmware@kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I am currently testing the latest `amd-ucode` from `linux-firmware
20250808` and encountering an early microcode load error on Linux
6.12.37. The CPU is an AMD EPYC 7713P 64-Core Processor (Milan, Zen
3).

Upon boot, the following error is reported in dmesg:
`microcode: No sha256 digest for patch ID: 0xa0011de found`

When I use the kernel parameter `microcode.amd_sha_check=off`, I
receive the following errors:

```
jwang@ps406a-1.stg2:~$ dmesg | grep micro
[ 0.000000] microcode: It is a very very bad idea to disable the blobs
SHA check\!
[ 0.000000] unchecked MSR access error: WRMSR to 0xc0010020 (tried to
write 0xffff888034ce5fd2) at rIP: 0xffffffff90064eeb
(__apply_microcode_amd+0x3b/0x90)
[ 0.000000] Command line:
BOOT_IMAGE=(http)/live-images/liveboot-k6.12-test-2025.450/vmlinuz
BOOTIF=58:a2:e1:b1:82:60 boot=live
fetch=http://mgmt/live-images/liveboot-k6.12-test-2025.450/root.squashfs
consoleblank=0 PHASE=Testing crashkernel=512M quiet
salt-master=stg-salt2.stg.profitbricks.net saltenv=base pillarenv=base
microcode.amd_sha_check=off liveboot.roce retbleed=off amd_iommu=off
intel_iommu=off iommu=soft
[ 0.018728] Kernel command line:
BOOT_IMAGE=(http)/live-images/liveboot-k6.12-test-2025.450/vmlinuz
BOOTIF=58:a2:e1:b1:82:60 boot=live
fetch=http://mgmt/live-images/liveboot-k6.12-test-2025.450/root.squashfs
consoleblank=0 PHASE=Testing crashkernel=512M quiet
salt-master=stg-salt2.stg.profitbricks.net saltenv=base pillarenv=base
microcode.amd_sha_check=off liveboot.roce retbleed=off amd_iommu=off
intel_iommu=off iommu=soft
[ 0.143803] Transient Scheduler Attacks: Vulnerable: Clear CPU buffers
attempted, no microcode
[ 0.014489] microcode: CPU1: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU2: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU3: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU4: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU5: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU6: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU7: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU8: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU9: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU10: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU11: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU12: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU13: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU14: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU15: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU16: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU17: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU18: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU19: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU20: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU21: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU22: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU23: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU24: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU25: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU26: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU27: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU28: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU29: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU30: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU31: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU32: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU33: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU34: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU35: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU36: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU37: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU38: update failed for patch_level=0x0a0011de
[ 0.014489] microcode: CPU39: update failed for patch_level=0x0a0011de
[ 0.01
```
Seems we have to patch arch/x86/kernel/cpu/microcode/amd_shas.c for
the new patch 0x0a0011de?

Thx!
Jinpu Wang

