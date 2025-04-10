Return-Path: <linux-kernel+bounces-598369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFDDA84560
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 15:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B99D168814
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 13:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF0128A406;
	Thu, 10 Apr 2025 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUeIZ92f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C9427E1A1
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744293087; cv=none; b=EgZtajVA3aiX2aIHCRn78aaHp2wFc68dZEQOiroQsp5geVRj9PisHXOJfdMvfsIKVxV/dzdCldpUK8kYO9BnvbXortBEFZX3ifXpGHk3cjaDM8j55yaDIEhlkNNnXIJ81VGXPYP3n3TbSb5/vQMAFcew+l3txOe10cCEugpr97k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744293087; c=relaxed/simple;
	bh=utXRhIDM8OuhdnKwPp92r2fhtqDPsNaKQrOpxWEpdVY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QM+MMCGFj4s/8Ja7838R0RDMiojYR0NNFJvCsQwmySSL4+tyVkrdPNWg4iWIwJiVYW1iDrYCIQYGA/BUNBh3wsQuWWp8TJYaOGRGRpLaj0VpBmeKIS0yAe5BVkWH1/d3fkqSIcHrDSkUZr2kGvtwOtji7pf6RMTYskk0tDRmJ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QUeIZ92f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744293084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eCJkVFkZua3xj5qK5zdXRtIyxMPgU/Mam3bjoK39aVc=;
	b=QUeIZ92fxudRGLk0oxjbuEVwmFA3FqzF0CeXnl829wT0+JTjk4FPBmhaNG/LiKUWH+cBEc
	h46/3CoUyMAf/oS9PG4ogE+U5McKqL1Bmg+bJPi68PG+95mTMWHnO5r8X967MGlbxCPdLz
	Yk2Ngkh8bHOhBtnW3M47LzaM5d/OCB8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-YOqZLq0nO2uC8QlomkDghQ-1; Thu, 10 Apr 2025 09:51:23 -0400
X-MC-Unique: YOqZLq0nO2uC8QlomkDghQ-1
X-Mimecast-MFC-AGG-ID: YOqZLq0nO2uC8QlomkDghQ_1744293082
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so7022105e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 06:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744293082; x=1744897882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eCJkVFkZua3xj5qK5zdXRtIyxMPgU/Mam3bjoK39aVc=;
        b=V+SKQ9zFx6rQ19WKJRiV3L/PWAwPjo4MJ4c+33APrGrRpJaE+osjU0mL6VyY0kcLww
         PkcjINiNaSuP04+kmkbi/a5NwcVpN6Ecwr+A9tFH1b1/39J1WK3T88BSutq79wkm0fOn
         oEmpf4KKWGmXUYN3vSGHNcAkXaGeUCUpfJQKC5g4hWJAGi8z5AMX07UItAo2ylEIsqhN
         runCgKJKXBdUYaixo564bKrhGVuiSqb0KJm6Ma8x84dLGPkFxRGba9aU16w5nGrqCkXg
         bX4YMgYkh/i9tczVtCsT2U1KXty/3v6fWLUh8/Q2+jZUanK810Zup9YJrWVMWeK88CBX
         YcJw==
X-Forwarded-Encrypted: i=1; AJvYcCW3QTv/j98JvTV2Hko5orwu6e25hZtrjYM1EnD+I+wox4NLzcrzs3zu6KmlGEwZv5ZrIxqx0tEACEzuPyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YynQSO7j0PxwKCJiv0YEd2PpGuxi/MFX77rA1nive6YkGGDF7iD
	KUlEpVcmKGeIyV9c6pmj0mqUHhSq+FlmhdqQQ1fjJiDBbbXtjpt3yei94+giryWgX4bHZanrd9n
	HZ5OaVMGqNVQYKTtEIKp4UXPRZiSd8xJ6m4A3npmDQu0J8K9nUqeC0u3VHOL/Hw==
X-Gm-Gg: ASbGncuZLgdrOuZcpx0Mpeq/U74EbwOf0dWMPjX9YZ70+Qa/TFIpe8v0iaKBZkWLtVU
	vFrrFvw3GfIpaAFOOt1bYdIFzGemm45LCvErD93Goxe5jpeV+giQn2wOR7o4KYTBVUvhl1hqEOQ
	lgk9X8tOxIOHOCgbp1FJk7CYCzMTEAnczPtQzwL7Si1YClfs11/tFemMga2e4NB+OvC9/+CFQH7
	HcxIaVxM8LwH/fzjUsYmjpYM95bfHkf0hUSsWgVGOyVgmyzqVgqJ5rRrue2cj8u1oKc3Zmu74g4
	XcM23v0ZjITY9Pfs5ZLoKgv+TqPlL0XENZ7K3LXU6NPtb8/9VEgsWj5sJuM6xg==
X-Received: by 2002:a05:600c:4e89:b0:43c:e70d:4504 with SMTP id 5b1f17b1804b1-43f2d7e94d0mr27813775e9.19.1744293082135;
        Thu, 10 Apr 2025 06:51:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7AhLJQ5TQN0FdSJ6VlpIhImX35R5kBoI8PUnd/UZGvl2GLpuexQwWOq8DLclviiFX8wcAxQ==
X-Received: by 2002:a05:600c:4e89:b0:43c:e70d:4504 with SMTP id 5b1f17b1804b1-43f2d7e94d0mr27813385e9.19.1744293081506;
        Thu, 10 Apr 2025 06:51:21 -0700 (PDT)
Received: from stex1.redhat.com (host-79-53-30-213.retail.telecomitalia.it. [79.53.30.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2338db0dsm54406235e9.7.2025.04.10.06.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 06:51:20 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Borislav Petkov <bp@alien8.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>,
	linux-integrity@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	x86@kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-coco@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v7 0/4] Enlightened vTPM support for SVSM on SEV-SNP
Date: Thu, 10 Apr 2025 15:51:12 +0200
Message-ID: <20250410135118.133240-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AMD SEV-SNP defined a new mechanism for adding privileged levels (VMPLs)
in the context of a Confidential VM. These levels can be used to run the
guest OS at a lower privilege level than a Secure VM Service Module (SVSM).
In this way SVSM can be used to emulate those devices (such as TPM) that
cannot be delegated to an untrusted host.

The guest OS can talk to SVSM using a specific calling convention and
instructions (a kind of system call/hyper call) and request services such
as TPM emulation.

The main goal of this series is to add a driver for the vTPM defined by
the AMD SVSM spec [3]. The specification defines a protocol that a
SEV-SNP guest OS (running on VMPL >= 1) can use to discover and talk to
a vTPM emulated by the SVSM in the guest context, but at a more
privileged level (VMPL0).

This series is based on the RFC sent by James last year [1].
In the meantime, the patches have been maintained and tested in the
Coconut Linux fork [2] along with the work to support the vTPM
emulation in Coconut SVSM.

The first patch adds public APIs to use AMD SVSM vTPM. They use
SVSM_VTPM_QUERY call to probe for the vTPM device and SVSM_VTPM_CMD call
to execute vTPM operations as defined in the AMD SVSM spec [3].
The second patch adds an interface with helpers for the SVSM_VTPM_CMD calls
used by the vTPM protocol defined by the AMD SVSM spec and then used by the
third patch to implement the SVSM vTPM driver. The fourth patch simply
registers the platform device.

Since all SEV-SNP dependencies are now upstream, this series can be
applied directly to the Linus' tree.

These patches were tested in an AMD SEV-SNP guest running:
- a recent version of Coconut SVSM [4] containing an ephemeral vTPM
- a PoC [5] containing a stateful vTPM used for sealing/unsealing a LUKS key

Changelog:

v6 -> v7:
- Moved snp_svsm_vtpm_probe() call from the driver to sev/core.c to register
  the device only when it's really available [Borislav]
- s/device/devices in pr_info [Tom]
- Added Jarkko's R-b on patches 3 and 4
- Updated some commit descriptions to reflect the current implementation

v5 -> v6: https://lore.kernel.org/linux-integrity/20250403100943.120738-1-sgarzare@redhat.com/
- Removed the `locality` field (set to 0) and the FIXME comment [Jarkko]
- Added Tom's R-b on patch 4

v4 -> v5: https://lore.kernel.org/linux-integrity/20250331103900.92701-1-sgarzare@redhat.com/
- Added stubs when !CONFIG_AMD_MEM_ENCRYPT [Dionna]
- Added Jarkko's R-b on patches 1 and 2
- Removed cancel/status/req_* ops after rebase on master that cotains
  commit 980a573621ea ("tpm: Make chip->{status,cancel,req_canceled} opt")

v3 -> v4: https://lore.kernel.org/linux-integrity/20250324104653.138663-1-sgarzare@redhat.com/
- Added more documentation around public API [Jarkko]
- Simplified TPM_SEND_COMMAND check [Tom/Jarkko]
- Renamed header in tpm_svsm.h so it will fall under TPM DEVICE DRIVER
  section [Borislav, Jarkko]
- Fixed several comments to improve svsm_vtpm_ helpers and structures [Jarkko]
- Moved "asm" includes after the "linux" includes [Tom]
- Allocated buffer used in the driver separately [Tom/Jarkko/Jason]
- Explained better why we register tpm-svsm device anyway in the commit message

v2 RFC -> v3: https://lore.kernel.org/linux-integrity/20250311094225.35129-1-sgarzare@redhat.com/
- Removed send_recv() ops and followed the ftpm driver implementing .status,
  .req_complete_mask, .req_complete_val, etc. [Jarkko]
  As we agreed, I will send another series with that patch to continue the
  discussion along with the changes in this driver and ftpm driver.
- Renamed fill/parse functions [Tom]
- Renamed helpers header and prefix to make clear it's related to the
  SVSM vTPM protocol and not to the TCG TPM Simulator
- Slimmed down snp_svsm_vtpm_probe() [Borislav]
- Removed link to the spec because those URLs are unstable [Borislav]
- Removed features check and any print related [Tom]
- Squashed "x86/sev: add SVSM call macros for the vTPM protocol" patch
  with the next one [Borislav]

v1 -> v2 RFC: https://lore.kernel.org/linux-integrity/20250228170720.144739-1-sgarzare@redhat.com/
- Added send_recv() tpm_class_ops callback
- Removed the intermediate tpm_platform.ko driver
- Renamed tpm_platform.h to tpm_tcgsim.h and included some API to fill
  TPM_SEND_COMMAND requests and parse responses from a device emulated using
  the TCG Simulatore reference implementation
- Added public API in x86/sev usable to discover and talk with the SVSM vTPM
- Added the tpm-svsm platform driver in driver/char/tpm/
- Fixed some SVSM TPM related issues (resp_size as u32, don't fail on
  features !=0, s/VTPM/vTPM)

v0 RFC -> v1: https://lore.kernel.org/linux-integrity/20241210143423.101774-1-sgarzare@redhat.com/
- Used SVSM_VTPM_QUERY to probe the TPM as Tom Lendacky suggested
- Changed references/links to TCG TPM repo since in the last year MS
  donated the reference TPM implementation to the TCG.
- Addressed Dov Murik's comments:
  https://lore.kernel.org/all/f7d0bd07-ba1b-894e-5e39-15fb1817bc8b@linux.ibm.com/
- Added a new patch with SVSM call macros for the vTPM protocol, following
  what we already have for SVSM_CORE and SVSM_ATTEST
- Rebased on v6.13-rc2

Thanks,
Stefano

[1] https://lore.kernel.org/all/acb06bc7f329dfee21afa1b2ff080fe29b799021.camel@linux.ibm.com/
[2] https://github.com/coconut-svsm/linux/tree/svsm
[3] "Secure VM Service Module for SEV-SNP Guests"
    Publication # 58019 Revision: 1.00
    https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
[4] https://github.com/coconut-svsm/svsm/commit/6522c67e1e414f192a6f014b122ca8a1066e3bf5
[5] https://github.com/stefano-garzarella/snp-svsm-vtpm

Stefano Garzarella (4):
  x86/sev: add SVSM vTPM probe/send_command functions
  svsm: add header with SVSM_VTPM_CMD helpers
  tpm: add SNP SVSM vTPM driver
  x86/sev: register tpm-svsm platform device

 arch/x86/include/asm/sev.h  |   7 ++
 include/linux/tpm_svsm.h    | 149 ++++++++++++++++++++++++++++++++++++
 arch/x86/coco/sev/core.c    |  69 ++++++++++++++++-
 drivers/char/tpm/tpm_svsm.c | 125 ++++++++++++++++++++++++++++++
 drivers/char/tpm/Kconfig    |  10 +++
 drivers/char/tpm/Makefile   |   1 +
 6 files changed, 360 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/tpm_svsm.h
 create mode 100644 drivers/char/tpm/tpm_svsm.c

-- 
2.49.0


