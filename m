Return-Path: <linux-kernel+bounces-632475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F804AA97C8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 17:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 522CC3BA95E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 15:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002E025E46E;
	Mon,  5 May 2025 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Caw48MFF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4043156C6F
	for <linux-kernel@vger.kernel.org>; Mon,  5 May 2025 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746459943; cv=none; b=NVbj1gdFTHw+/5jBCXmjzKcoglYItIegnZhAiYZBUsPd+xm6/OHlMof/ZfjapV1kN7UjIOG2twOCLHp6R5DoQOKnlJchXTgF8ZGw5PcGW6f4Tm8j3rN8Y+ji+wG2YOgcjDwaTzFwqJUS89T3oxDQjwth71vHVc6HDj8GxOzkT40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746459943; c=relaxed/simple;
	bh=YtSScPrekyu5eNTQAd0GHkgYudHcgU73cqfgqDDKsFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jq5QpcaUS5d1KFPxJsekXFRslo4cV7iFpy+R+9B7Nnh0BaS31/Kf80b/WJhj9nFk1sKr2BvQ0PsXXsFc454xblTBB4/egubjDNTfbZwDYQiHicCDxkYGv5S/zLV0cIcWbFyEPrmL2EBVrsrZvwvporDmx0dakCBXBG5jViCVBM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Caw48MFF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746459941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Awzo7DI7AJd+wpwgJ5wGQ8SIQd3qq+gLPnXP8U+TGDg=;
	b=Caw48MFFqncqU+fuzvqwT0Mry9dbB/vTCp4wBOEdxZCpUMYf16xbEeYbwL2bitQoihnxMu
	NQAQLgVXM+uWCx/as8YeOkauVPAKAplLcpKWdIeYTl8Va46lHfwB/k5hjdDdJyfj9EW3Gh
	nwBUCcH6sRyuRWnjJK+Ca2HQ4AJJtrY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-E2DIrUWNOUKANXqO-vlJSw-1; Mon,
 05 May 2025 11:45:36 -0400
X-MC-Unique: E2DIrUWNOUKANXqO-vlJSw-1
X-Mimecast-MFC-AGG-ID: E2DIrUWNOUKANXqO-vlJSw_1746459934
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ABEA419560AA;
	Mon,  5 May 2025 15:45:33 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.34.28])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8A48B30001AB;
	Mon,  5 May 2025 15:45:25 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: x86@kernel.org,
	linux-efi@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Peter Jones <pjones@redhat.com>,
	Daniel Berrange <berrange@redhat.com>,
	Emanuele Giuseppe Esposito <eesposit@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Luca Boccassi <bluca@debian.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] efi: Add a mechanism for embedding SBAT section
Date: Mon,  5 May 2025 17:45:21 +0200
Message-ID: <20250505154523.231233-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Changes since v1 (Ard):
(https://lore.kernel.org/linux-efi/20250424080950.289864-1-vkuznets@redhat.com/)
- Get back to the idea of putting '.sbat' in between '.text' and '.data' as
  the later also covers '.bss' (and '.pgtable' on x86) which are not present
  in the file but must be accounted for in memory (see the discussion on v1
  for additional details).
- CONFIG_EFI_SBAT is now automatically set when CONFIG_EFI_SBAT_FILE is set.
- Simplified make magic for tracing possible sbat data changes.
- Dropped 'sbat.S' for zboot (x86 stays as there's no good place for it in
  the existing 'vmlinux' compilation units).
- Other necessary tweaks.

Original description:

SBAT is a mechanism which improves SecureBoot revocations of UEFI binaries
by introducing a generation-based technique. Compromised or vulnerable UEFI
binaries can be prevented from booting by bumping the minimal required
generation for the specific component in the bootloader. More information
on the SBAT can be obtained here:

https://github.com/rhboot/shim/blob/main/SBAT.md

Currently, shim checks .sbat data for itself in self-test and for second
stage bootloaders (grub, sd-boot, UKIs with sd-stub, ...) but kernel
revocations require cycling signing keys or adding kernel hashes to shim's
internal dbx. Adding .sbat to kernel and enforcing it on kernel loading
will allow to do the same tracking and revocation distros are already
doing with a simplified mechanism, and without having to keep lists of
kernels outside of the git repos.

Previously, an attempt was made to add ".sbat" section to the linux kernel:

https://lwn.net/Articles/938422/

The approach was rejected mainly because currently there's no policy on how
to update SBAT generation number when a new vulnerability is discovered. In
particular, it is unclear what to do with stable kernels which may or may
not backport certain patches making it impossible to describe the current
state with a simple number.

This series suggests a different approach: instead of defining SBAT
information, provide a mechanism for downstream kernel builders (distros)
to include their own SBAT data. This leaves the decision on the policy to
the distro vendors. Basically, each distro implementing SecureBoot today,
will have an option to inject their own SBAT data during kernel build and
before it gets signed by their SecureBoot CA. Different distro do not need
to agree on the common SBAT component names or generation numbers as each
distro ships its own 'shim' with their own 'vendor_cert'/'vendor_db'. Linux
upstream will never, ever need to care about the data unless they choose in
the future to participate in that way.

Vitaly Kuznetsov (2):
  efi: zboot specific mechanism for embedding SBAT section
  x86/efi: Implement support for embedding SBAT data for x86

 arch/x86/boot/Makefile                      |  2 +-
 arch/x86/boot/compressed/Makefile           |  5 ++++
 arch/x86/boot/compressed/sbat.S             |  7 +++++
 arch/x86/boot/compressed/vmlinux.lds.S      |  8 +++++
 arch/x86/boot/header.S                      | 33 +++++++++++++++------
 drivers/firmware/efi/Kconfig                | 24 +++++++++++++++
 drivers/firmware/efi/libstub/Makefile.zboot |  4 +++
 drivers/firmware/efi/libstub/zboot-header.S | 22 ++++++++++++--
 drivers/firmware/efi/libstub/zboot.lds      | 11 +++++++
 9 files changed, 104 insertions(+), 12 deletions(-)
 create mode 100644 arch/x86/boot/compressed/sbat.S

-- 
2.49.0


