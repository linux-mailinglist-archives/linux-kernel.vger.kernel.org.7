Return-Path: <linux-kernel+bounces-743241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 173A5B0FC59
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C153B7975
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAF02727FE;
	Wed, 23 Jul 2025 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aeDD4uoV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD80258CD9
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 21:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753307766; cv=none; b=QddEcotfb5ufHmV0U/esYJMmWMSXhBULhdiQgARB2BRnKQBJKI3eOTK+pFe8h7D4N6HJ5HV5q6IogqmA9NQTqXo56lr/4Vf0kpAeKk4SUoX61RpHZ7wRMo7SooLJhR2pnoaw1mUkKVVpXt+2HGyTU+ZjyZC4jYDfovXkG4nqags=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753307766; c=relaxed/simple;
	bh=rFRYrwm+DOUX9xSeAUwEf3toe5F2mt6lAjC8IjY+S64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=juN30eHBeNov7yDBHOSI2GtWGR9jNZp4uIDp1/v6JKm1JPyeKLy7SqPlbyv4WUTEt3/9RlFFjyK7Hlg5nYjTi9rHRel9VkCmasER3yYrLbe6AU3W2Tt0Nn5UalDrOURlEgU+f3TMLdA4+32FEzf2C+zLSDyXmsIoyYm32vlxYjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aeDD4uoV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753307763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VNyF4uOWBx+H0ptzy3xhOM9MUH24yGLru2zp+eruyEw=;
	b=aeDD4uoVvGq7gkEnLTrRah5ktf2ED3zGy7Gy7AZBQSNIFMJ+og+xnfM2TH0+Ie+SynjEQd
	8E3whvufECjTk1rLJaibNiDx6Wgq0bQMwxLEFVU/luCPk4Gj6ZChNonqhPQxKn9iYBpT9a
	MiXbd/JnhnFwUzcBgMR0rcqdKbzpoyM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-DSE8C38KM8C3SND66HxSUQ-1; Wed, 23 Jul 2025 17:56:00 -0400
X-MC-Unique: DSE8C38KM8C3SND66HxSUQ-1
X-Mimecast-MFC-AGG-ID: DSE8C38KM8C3SND66HxSUQ_1753307759
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-456267c79deso682055e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753307759; x=1753912559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VNyF4uOWBx+H0ptzy3xhOM9MUH24yGLru2zp+eruyEw=;
        b=oR8kC+LLqO8U3ORQYys7+u5iN7Ti5cwOs+gQ3o9ICM4ouyWuRdSjrTRjfeNADTl8YR
         yqHAdr6L78LfTkuj+1Sjc0zZ07rmsAVHak5k+fqbxvnBsT2sRFd9tUCegoGPBOeqzyCe
         BG0wtposZNVo21iQaK5L0uGDOI0Rscrv4+IzoyzAGTIRVC2CtPKrYMH6rJIJpYu06Gke
         IMwrdTc08TIB/ry1OABEkqkNNfSzcgTLvDtVdoIBY/5CEvohbj0JSxrfj04KYCXoMI3I
         OE+h+I/LAB48TACYvKkg/D0+bkEQzMo0pr97HP3A3nwHMhh6CRoCP6TpXylRhVkTrDtP
         Xijg==
X-Gm-Message-State: AOJu0YwLeHIq7jmKUzTzIbNMjG4NYh8Dbk6amSt4hfAPdN33eOYTL5y1
	5p7tHW4Pr1cFyy3JipCsiRKn1EvQgm2WaCIKw/VVanNX57Ddmci1i7n+rZ2iM5eyiYIgfuEyXYF
	U0re09SVNNBNdIjdCcG5V2W0PNjYxyfBPdggEvbxPGPKbTxB7F3Ei+ycKFQZozl0taIeEY+qntQ
	==
X-Gm-Gg: ASbGncttLoCNoVi3nvmu6yIWW4fS8QuGd792oCmkDqRNtKhUga5cARshyNV+w28jara
	wkyvgMP7zevvxs94A600GUGbJNheCfd5+9ygpijKowCeHK6F7s1MTLDVlb7U9dZazw6KBgknKGZ
	ljV35aAL4/GZmXCXEuH4jMXkdnpHbAhbTn6wI2P1sHJFKTNnTzmcPXUX3V3ULYDyCokx3uL1AkN
	MSigr+nUH1yBIsd2yXg3LndwXRAzvt22Y4qwiy+Sns2n1VcXbbVJzQhK6WDhUQTWeg4AKZ9qp6w
	k84/zojmgEDXa6xCW44D8vYqXi/yS/UDWt7op0OHIVc5
X-Received: by 2002:a05:600c:190e:b0:456:1e5a:8880 with SMTP id 5b1f17b1804b1-45868c9cf1bmr40352105e9.13.1753307758820;
        Wed, 23 Jul 2025 14:55:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDybqmhAfgpmbV80V72LiLYlwQT3s2MSf16SaizlQdvxbUuDyl916gLncW4mae4vXrdvcvDw==
X-Received: by 2002:a05:600c:190e:b0:456:1e5a:8880 with SMTP id 5b1f17b1804b1-45868c9cf1bmr40351915e9.13.1753307758355;
        Wed, 23 Jul 2025 14:55:58 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.154.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45869198e5dsm35517305e9.9.2025.07.23.14.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 14:55:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] (Final?) KVM change for Linux 6.16
Date: Wed, 23 Jul 2025 23:55:56 +0200
Message-ID: <20250723215556.866784-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 4b7d440de209cb2bb83827c30107ba05884a50c7:

  Merge tag 'kvm-x86-fixes-6.16-rc7' of https://github.com/kvm-x86/linux into HEAD (2025-07-17 17:06:13 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 5a53249d149f48b558368c5338b9921b76a12f8c:

  KVM: x86/xen: Fix cleanup logic in emulation of Xen schedop poll hypercalls (2025-07-23 23:48:54 +0200)

----------------------------------------------------------------
x86:

* Fix cleanup mistake (probably a cut-and-paste error) in a Xen
  hypercall.

----------------------------------------------------------------
Manuel Andreas (1):
      KVM: x86/xen: Fix cleanup logic in emulation of Xen schedop poll hypercalls

 arch/x86/kvm/xen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


