Return-Path: <linux-kernel+bounces-760696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6ABB1EEF9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 21:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1B07202D0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 19:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A315288512;
	Fri,  8 Aug 2025 19:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="B8InPqWO"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274702882DE
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 19:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754682043; cv=none; b=HV8cFmhUK58sWwZ6yilSr5J+xICh14iMoWOR8r8kjT+71CFM1fMGKEtf+/Z4+IE4+AJhAS8lG+lWSOoz+aVwiQqEMksGWUP757R4zyzX697v3usrwSXwHao1Iq+ij3iL4IDJBiE59oxvzzo3NIb2C/XTin0EJt6ke055EwKMHSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754682043; c=relaxed/simple;
	bh=fbC1sfGTRwM9KVR6ISJbEGyq/BzRDCIS9DtaXdb/r/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdcsYJA5GTo+AkYVDexG9hqFTKE3vUmJlzQWrYX5f6uHKo+zHaO5uI+kMq0V4ki1b0KWqZYPtnXircV9VWIt0haPAeZtQrBH5EWD1PVpnLpknfArcEPftc1bp8F49Z1yrX1af+KVxigecBamkEJceyfD0WtcX8pWBWtZ4eFopd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=B8InPqWO; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3e40ac40940so11014585ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 12:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1754682041; x=1755286841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMTURUrnQNZrOBYjWC1Rn+SnR4z6iblLoVxNeceVQhw=;
        b=B8InPqWOcC6SuFMU3Zyp0g+xxcwJoCteiIftxSlM5dorsvmt423jpqIOIMUYFJ7OMr
         X3BXZdMfkkf+ndfAMR8cBQiXiItcl1U2MtEtKaZ9KD2z31slE7/QFKEMROgNCcEF+/fB
         qF1jo6j+dQnF/pkdE2DZQhiaYQfXZpCqW+nkp4SEi6biEjUHZXA4rIRVGpeacwQjDYly
         1QE5AHbkbMwnR/w5kpCrv6eYNDD2SRuF/ozCRsVM5Ey+nO4u6WmN5O9vgHQbE3vqPaZP
         VwIVoOU6yu/+iAnCb4acGyPZNeh70nyvi4RcCZ8ZHcpW0VB9Y4m/yQV672QibgwcZHsx
         XMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754682041; x=1755286841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMTURUrnQNZrOBYjWC1Rn+SnR4z6iblLoVxNeceVQhw=;
        b=gBgBmbz3WNUzCvQ0aXEd8geuE+28Umo0C16DDzWHQanMfUPwwLUoPJID+dFA8pHVlk
         7JXjPksv74zwDwycP1gxAC6bl+wxxWFpSz6+sYLwxFE9Xapm3QiIrt3ndPxh3LEDp6tI
         Q8rl1zBokgEPAlTxGCqAMnh0wgQz12XIRy7ccY8obwTfYJQl+edMF7OKE5Z7etINQcyF
         GCY/DUaAoBQ27aNnF2ZFU/8r/DDPZRVJddBcEHRagyV86CaJt1c/5Kdb3fKVzQaowEXg
         cHfwocrvvxgaMZ28XNBkQLD5P9OdZhSg9FVFYRnJAPnR24FXgKVR6jwfoMIRt0OM7xRQ
         GaZA==
X-Forwarded-Encrypted: i=1; AJvYcCXfQ/BdxLqCkrLIDlUXlpSVDNg7/kbQL1NsAWjBX6M64SMBa2GYLGmh3tkFRk+eyWC5l+apOvMZHqYT4mE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyusabdFk3lqpy9m4cyQaoWkmmz/NWBri5TiKZRK61FUbnP4U73
	AsL2boZmfRTaGJpF7963RC6lTzqVNouYM5k6a9DwzuqA2Gpr80G9B24FnjpFUEDG3kU=
X-Gm-Gg: ASbGncvXzD9z28AN6l8DJBD+eh2XxuCWoLErZZKsrH6vQmQ2pPjddEr2/hPDlsdFrf3
	qAenga64xGmfXRgTcIkiprU7z1vpZxdRu56kZcEnGxjIcrvV1y//NTlGiE3U55accS475Qpdf+M
	IFVWZUD/+Hp7IVpeVBmOF/DhQiY0skuY317Y/qpVXgdWQwOzgeoWPAM+t8z8/lfyh/GLwQQrEIe
	SR4qp9+6l54KGgNvjJgzU4Ca1wLmVRulPEpNfEJc6tcusPEzjkqXjPQXotGC2WH5duwvwNof+3c
	DNzq/we3ueot9+TWdbJCFEe++zamvctZyIXUo06iMZm7zNmdF+xOKsPHduSl2zyU4ehpr4co5fE
	21yzK
X-Google-Smtp-Source: AGHT+IFlTg6qyesY84rUV5KNJ8QLoCgYNF59EcWDBZiEsfgkJ/Ld63VaD6K6KCZdZ5B2HMUbA03MLA==
X-Received: by 2002:a05:6e02:1a07:b0:3e5:31fe:a47d with SMTP id e9e14a558f8ab-3e5339b2925mr68396935ab.2.1754682041073;
        Fri, 08 Aug 2025 12:40:41 -0700 (PDT)
Received: from CMGLRV3.. ([2a09:bac5:8255:4e6::7d:6f])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e533cdd3e6sm10482345ab.55.2025.08.08.12.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 12:40:40 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
To: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>
Cc: audit@vger.kernel.org,
	kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org,
	Frederick Lawler <fred@cloudflare.com>
Subject: [RFC PATCH] audit: make ADUITSYSCALL optional again
Date: Fri,  8 Aug 2025 14:40:34 -0500
Message-ID: <20250808194034.3559323-2-fred@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250808194034.3559323-1-fred@cloudflare.com>
References: <20250808194034.3559323-1-fred@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the introduction of commit cb74ed278f80 ("audit: always enable
syscall auditing when supported and audit is enabled"), eBPF
technologies are being adopted to track syscalls for auditing purposes.
Those technologies add an additional overhead ontop of AUDITSYSCALL.
Additionally, AUDIT infrastructure has expanded to include INTEGRITY which
offers some advantages over eBPF technologies, such as early-init/boot
integrity logs with. Therefore, make ADUITSYSCALL optional
again, but keep it default y.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
 init/Kconfig | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index af4c2f085455..2552918deb45 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -487,16 +487,21 @@ config AUDIT
 	help
 	  Enable auditing infrastructure that can be used with another
 	  kernel subsystem, such as SELinux (which requires this for
-	  logging of avc messages output).  System call auditing is included
-	  on architectures which support it.
+	  logging of avc messages output). Does not do system-call
+	  auditing without CONFIG_AUDITSYSCALL.
 
 config HAVE_ARCH_AUDITSYSCALL
 	bool
 
 config AUDITSYSCALL
-	def_bool y
+	bool "Enable system-call auditing support"
 	depends on AUDIT && HAVE_ARCH_AUDITSYSCALL
+	default y
 	select FSNOTIFY
+	help
+	  Enable low-overhead system-call auditing infrastructure that
+	  can be used indepdently or with another kernel subsystem,
+	  such as SELiux.
 
 source "kernel/irq/Kconfig"
 source "kernel/time/Kconfig"
-- 
2.43.0


