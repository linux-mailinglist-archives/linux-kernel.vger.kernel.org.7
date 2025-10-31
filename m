Return-Path: <linux-kernel+bounces-880663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79618C26478
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CFDA1A62E8F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD41303A34;
	Fri, 31 Oct 2025 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R0I0SIb2"
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E278B2FE593
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761930369; cv=none; b=fK1rjw/udkyJc97VgIFefOuOM3eWd6XRPP/356WU0RODEc+jiJ82q3Df/NZ/1NlRxTfkijT6xT982xIA+IuUiqOY50ztzdEfMX+AUS5lszxRqiQSDuuCMD9h/9zpWinfnDQAB/DKsH0hjWMNEDFox72L4XKoMWU8lGeNt2p+EFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761930369; c=relaxed/simple;
	bh=3zO6hJh3fZZRnhxmcHqGuW4F0oTnh1zP5aEQTYDADeU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iKTtzk5cMgd8XoRC01bqIQADHF4zAFykx30PIHMOzur6I5bzvh5ruQcomqlc/2D2zHfhNiMVCaw6R1XdY9SYatEt3BlhIz/JIVBkUVHA6DXZyutZZEGWODHux5WgFiyyzBT33Vha/D+z2aYsOVpuskQcU0yPmLJDsKkk5bQPfMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R0I0SIb2; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-93e8839f138so269268539f.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761930366; x=1762535166; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L7rkGekV8xK6fIdrAf10YJdw8xerhp0arb9+9f1J3v4=;
        b=R0I0SIb27ZQzuq6qJ+2HtZe1nvq34AfW3Dt5vlqaad9wiz75EMA8yLb6bpH/M7rGpv
         wfbaP5aP6P4e3eX94vJ67EVUgWgtuPTubSKYyh+S7xL7ivcEJnbAJHffn1aRQv5dj+He
         2Wr2+oJekKCg4eR0pB19LfXDBebbSnBmgKn8qwxOx7z2oBIH0ViKITY+NQ/pDi3/VPmJ
         FR8GIpjqTSErVbUXDAtDcbgcFH62eGs9EZ6GvtbSKbhNv+Qeq4hYtph9Mk6hpF8KB/6P
         qH06olGdZ3X1GiXek2aHn47zjSjjGj2/Zyr0f2atrg2Xv4re4+iE+lM7IF/S8/PwI0io
         1Row==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761930366; x=1762535166;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L7rkGekV8xK6fIdrAf10YJdw8xerhp0arb9+9f1J3v4=;
        b=uGMo/q4SgjE8Z9Wi4tyhJZ1MA4lqc+Dr9KI6XIsdwiS8qI4FBzFaXv3ZsSbPXO99vy
         +oAK4j/zVKe1aDV3iWFqMtzyrSbvR3vutSI87TBvLyZT2y4OfBNTCfmvvzsWfnXR9rFs
         UgI/pE6ANtOKsPznLo5E69Jt97CgLl1Bk2o1R9Wl3l6XDfchpVeBWTfS40YDuL2Docuo
         ekYIbIK7ccUIeDiASBxXfQL0n4fX6a5RKQ+y0yXMawHrjttjVX6QjFZDiCeNctn/1nTg
         2M3Q1n2oGzF7BzDLk6UB6L3Q7ftcrwfsznYSAZmyq4ewNM2PJDzqdv6vodHMazM9HTh2
         osDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlT8ubHyJgE3gbSwZ3R5iZWPHqORaLUwKwwS2tS4/DGyUozCT4d0Kc18iQGIaFkEDYPr2er/fE00pEfW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVvB86AZopEX4s/PGMzS3aZhkUt0o/+dV7F4WSo7hkhvhPI41S
	E3OqLj130kOEH4OiNy57weKBSW7iggWRiXP/NhFYUd8UNkeaWRHBqQXt7Sx1fkkpaMjH+Oy1q70
	m1E1iHodvWg==
X-Google-Smtp-Source: AGHT+IGPppdgWImmiqMllVHuCL0LVBd1POfNbnkt1XP6pw+qeSasvHMVbc9KRJdiIi1IyT4HZNv81Doi6WQl
X-Received: from ior5.prod.google.com ([2002:a05:6602:a005:b0:948:1a37:3c2b])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:6c13:b0:945:afe6:4bfe
 with SMTP id ca18e2360f4ac-9482287e91bmr722109939f.4.1761930365863; Fri, 31
 Oct 2025 10:06:05 -0700 (PDT)
Date: Fri, 31 Oct 2025 17:06:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251031170603.2260022-1-rananta@google.com>
Subject: [PATCH v2 0/2] vfio: Fixes in iommufd vfio token handling
From: Raghavendra Rao Ananta <rananta@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson <alex@shazbot.org>, 
	Alex Williamson <alex.williamson@redhat.com>, Longfang Liu <liulongfang@huawei.com>, 
	David Matlack <dmatlack@google.com>
Cc: Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

The series includes a couple of bug fixes that were accidentally
introduced as a part of VFIO's vf_token management for iommufd.

Patch-1: Fixes ksize arg while copying user struct in
vfio_df_ioctl_bind_iommufd.

Patch-2: Adds missing .match_token_uuid callback in
hisi_acc_vfio_pci_migrn_ops.

Thank you.
Raghavendra

Raghavendra Rao Ananta (2):
  vfio: Fix ksize arg while copying user struct in
    vfio_df_ioctl_bind_iommufd()
  hisi_acc_vfio_pci: Add .match_token_uuid callback in
    hisi_acc_vfio_pci_migrn_ops

 drivers/vfio/device_cdev.c                     | 2 +-
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)


base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.51.1.930.gacf6e81ea2-goog


