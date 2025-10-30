Return-Path: <linux-kernel+bounces-878976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAA8C21E4E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 40E0E34FCDE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FED2BD11;
	Thu, 30 Oct 2025 19:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zUB8BlfS"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F5318991E
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761851735; cv=none; b=OddnuaXvFdjbSZRnG3V1LQH6iawrZo+97Vz0c5oKKmH6lllPAcbyHtUy/ditCuyc4NtV9baA5n1FJ4LWopHXN9/Z666P7VV3/ZNdf9q1pNV4WKijTj2rQdgeAFEnrWQYD9UkVE9xbnncRsyWP1LUpI4ahiEpPQnbj2Y790hHru8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761851735; c=relaxed/simple;
	bh=lWzlB0iKIoWvR0KWONloUbPP7jxIV0kTEpcbpDhzXe8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=P53XGhgj97PjNPagiNi83qDlaCJwHIaZ6hligXgi1y5fJi9oGGJ7uioL3h5JDr7qFLuRr6s8Hl7Zxoc7rFtSPsvkn8Oky2O85Xw+cBWLoPN3XUYMXOVdGmlVz9zPkDLwXTRl7Joz1Rg57lyly4KZ4S4HTRGmpCAAf/yvvRcxkZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zUB8BlfS; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-286a252bfbfso33283505ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761851732; x=1762456532; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuU0G1rKKzQ0bN8b2xmtCp6y8rTt4E6EmC8pujr8+1c=;
        b=zUB8BlfS/r4a3Qid6rhqzwEG0WCqgEAhKU+UaR09CGwFXd5eW2w6I8yGUMWNRbmQhS
         +rrLQWo9iZG8hQtLHLL/OIUmddueWG0xQL3VUQGm67np4KslP3vPCQy0Qs9fmKQ+14Sj
         aXxBpxX3J6xJHD+PruRWCgvMlke4lAA5tSLyIbmPoZOdXOAWNLTbZepoMESoCPoKqJN5
         s0O1BVfHJGz1ioBTDaWgM040T1iIetPoMUOlfopa9MBQf/T3lURfI2UbRNB1cSlb5kAF
         0Cw6KufY3SbkyIW29BWU8dnNFoFVSL6JFwNHNvcFQPBrr1BZ7OJm5o4FufsqQkKOolBt
         s75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761851732; x=1762456532;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cuU0G1rKKzQ0bN8b2xmtCp6y8rTt4E6EmC8pujr8+1c=;
        b=tEf3aV15GS82OFwf3DVSLKtGdKx1a3TpFVsjLqr1rOuKfMgt1Uu+VwTveyTimsLjJD
         vRP/yA91Be4TSey/5WZ5os88T1ToBZ/dOeZ2gr/fxojTvONO3IaT5bHzw9oOjMC6CR7Q
         5697EX68MJ32SsOaiWmuHFQvi5ju+VoNOHzL8bHVDBHao1rnyb0wYXu+cCC6CmcnyuLo
         h7qd916e7RE72j+IQv3NwCE5H5CBj7jOkEMlbtb1PFt3Lng3PQIuofvpiZsn/oKfzjiW
         xJvmpLt3+/WidEr0VVm5ulwRoUwDlxqN0XoSrCHIc8xLhgh9m/reeA8zOkkWaR5+Q86v
         Ae3w==
X-Forwarded-Encrypted: i=1; AJvYcCWcAEJhPl8y9qgCLThW6qTqKER364rntNywCkVl2dbSMBXMxiXhsBUCcCmw9SgT3n6ZWbJau/CET+hcO6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnHC8wHpR6gmrrZiuzLRRK3AoxgZrcjujlYjIL3aqgULx5WRQ4
	V+J/faTsPPMXf63YhsJHrRHulp6O7IN5IzNxNGRNq44PljDofIJs7PO2PNuR9WzMnqLak1blbY9
	knWVEvw==
X-Google-Smtp-Source: AGHT+IHh8pk9JaiOfs+9/GV0orbjyBBA2NWN7A++gjRGRE1BeSyhooYBSK8ujIaLO6y5tDeY0PhwGLCZviM=
X-Received: from pjbbf22.prod.google.com ([2002:a17:90b:b16:b0:330:a006:a384])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e892:b0:25e:37ed:d15d
 with SMTP id d9443c01a7336-2951997e352mr11605825ad.0.1761851732223; Thu, 30
 Oct 2025 12:15:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 30 Oct 2025 12:15:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251030191528.3380553-1-seanjc@google.com>
Subject: [PATCH v5 0/4] KVM: x86: User-return MSR fix+cleanups
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Kirill A. Shutemov" <kas@kernel.org>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yan Zhao <yan.y.zhao@intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>
Content-Type: text/plain; charset="UTF-8"

Fix a bug in TDX where KVM will incorrectly update the current user-return
MSR values when the TDX-Module doesn't actually clobber the relevant MSRs,
and then cleanup and harden the user-return MSR code, e.g. against forced
reboots.

v5:
 - Set TDX MSRs to their expected post-run value during
   tdx_prepare_switch_to_guest() instead of trying to predict what value
   is in hardware after the SEAMCALL. [Yan]
 - Free user_return_msrs at kvm_x86_vendor_exit(), not kvm_x86_exit(). [Chao]

v4:
 - https://lore.kernel.org/all/20251016222816.141523-1-seanjc@google.com
 - Tweak changelog regarding the "cache" rename to try and better capture
   the details of how .curr is used. [Yan]
 - Synchronize the cache immediately after TD-Exit to minimize the window
   where the cache is stale (even with the reboot change, it's still nice to
   minimize the window). [Yan]
 - Leave the user-return notifier registered on reboot/shutdown so that the
   common code doesn't have to be paranoid about being interrupted.

v3: https://lore.kernel.org/all/15fa59ba7f6f849082fb36735e784071539d5ad2.1758002303.git.houwenlong.hwl@antgroup.com

v1 (cache): https://lore.kernel.org/all/20250919214259.1584273-1-seanjc@google.com

Hou Wenlong (1):
  KVM: x86: Don't disable IRQs when unregistering user-return notifier

Sean Christopherson (3):
  KVM: TDX: Explicitly set user-return MSRs that *may* be clobbered by
    the TDX-Module
  KVM: x86: WARN if user-return MSR notifier is registered on exit
  KVM: x86: Leave user-return notifier registered on reboot/shutdown

 arch/x86/include/asm/kvm_host.h |  1 -
 arch/x86/kvm/vmx/tdx.c          | 52 +++++++++++-------------
 arch/x86/kvm/vmx/tdx.h          |  1 -
 arch/x86/kvm/x86.c              | 72 ++++++++++++++++++++-------------
 4 files changed, 66 insertions(+), 60 deletions(-)


base-commit: 4cc167c50eb19d44ac7e204938724e685e3d8057
-- 
2.51.1.930.gacf6e81ea2-goog


