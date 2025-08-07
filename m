Return-Path: <linux-kernel+bounces-758537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C86D9B1D07E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 03:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B89372663F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 01:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65FC24A054;
	Thu,  7 Aug 2025 01:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="h3BWZfhk"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7A0239E6A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 01:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531120; cv=none; b=MHeVeh0L1B61hKbuLLg9X5Atk+Wle1VpBjnJ9eAAgnzuc0n7H9i8j4wsa9F00eH6SCjRdzbA0DBw91HnSrK2edLu94X1sNK8Uvhyr3BstxD0XTYb5TTChFzhB8OVj0Syy11X7gdGtSWoRwToJgxbfOU3q2Tx1yd26/3S5M3Sie0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531120; c=relaxed/simple;
	bh=RZ++fAXg5VoJ9aULwrUGHh0jUgxwzggc0842qo3hOvo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLIfHdUDLum5rNNaEaGQkAOFqTkiM3FEWNWNldJ0Ek6uGohb53DCa6zUc0i4BHkSQpQeLux+qjtxl26NiYX5Bdvu4VvQYzhCqz3xQ8W308sSemMMMocbHac9EWU/rYodJ/8wt+q91XTKF6yZzU3PCBB+elnjRwjol7CsbCSM6Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=h3BWZfhk; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-7074a74248dso5529356d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 18:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754531117; x=1755135917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WtKfUzOgupFaYotRf3a7eOnx1rqlnB537wzbb8Z3Bb4=;
        b=h3BWZfhkG+WF4+EcWwY4730YQ8ldiyH3oNiieZ0NLStWuOeP9N/2b+8vNQArNgCoG+
         mLaksFDoAYGVeemswgDli5X9eI1aT7TdvLoPtyCuulwXojVEj9CeUH6m+dTeRk6JgNTN
         vq+PXePRJ6wKDdGH7O/TNoh7U4iTFA3Ys+eTAsObiPubV1iuXtQK61w6Lu5wo/7u6p4U
         BLdn1K8UBWvtJvY8epYMe0hC3kYn03Erna9X6Q9M3pu8KKuz+1YFA2k4h7LS28SxuAYv
         vstbh2aEWtln7Jzc1VE+S5WZTOCFCTp4BrwUt/yVTypuDfGumlmVAtSng/a7IwLQCXIZ
         ChIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531117; x=1755135917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtKfUzOgupFaYotRf3a7eOnx1rqlnB537wzbb8Z3Bb4=;
        b=qssHiR0CF6FyP1rIdNW/KSw7COlQkdQRc3Ghrqkpq6V0MLgEatvET+E/0zQhrReuwl
         4gzZWrRyothQtTuSJiaoUKudpZsdi+K2AyJBkBK2CmXXj8OBo6DZaNWPHJasb2jJ4naY
         YyLp5+1tSS9CqMD5vHgkAwXDL0p8h3ZI7Ae8nbQ5lrgMsqAH8CFLtRq6VUzRSRpyCDmC
         dS+3v0/jnORnVKo0AHebrpTHEwu84r2v98EKdMx9zli90R+Hwxy7VUIZFicaoyjfFKzq
         7DtSkWhpLKkorDFaw5gVJk/p+fn3hCXb9MBilaqtV5lpzJEaVknebWVDRrCnBZTRdiLW
         Wkng==
X-Forwarded-Encrypted: i=1; AJvYcCUi9bIcZegWU+DSMjGccpXlg3wweCFv2Y1dq6nqR7imyj7ywHFgRdc+ETm+lhTzVccujgreL0hzETJtxsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzguTzusnI9i8BTdw2w4IY5gD4urLKtx62oXhmwvb7SP04hKhQ3
	GJr1scsq1cHJFmNCaN0y6/8uUorva/UALckXAhAybT5TKFm/TpNjDASBaJlBvDrgvXc=
X-Gm-Gg: ASbGncuL759Fx/cXTYnDzPrrw/xeAAGqjScNEZd4TRBajqBm+ewCcsVsfnt43sA1sBr
	t6JRhhHN8kRuD3qHnR44MV/p905rLeAN9Tt/AhifVZOopSp6bc9SivSPEVuEgSFimbm0ICI7X7D
	3v6QHFu0tFf3Cym1k7CUHytFdjBnz3KRIKxAA7nxVmbYTJx66FNZyCa8V0oDJrNQtK7T3V+fzcP
	KOsyiADIRiRR7GlAEKc8rcVn2Zi/CaPHR96l9SIfEstn9IGJuhnImN9Im2u7dEu5aI5P0wFwe83
	XXFmhl3PgZanmygt+p2kjxWa7UsLdZx//7LzCtapwxZg30xMA/8fkMNlkycmjqUZLF/tBq4sgL2
	6/AaIN7Eus+mEJiYG6CHCXibDPmwWc5LM5j2HWvr8m2n0PtPEwfcgqPQonq8Ue1ILZyCMnPVdXc
	qenAGMWkjAMASQ
X-Google-Smtp-Source: AGHT+IHDHBBqboi0c0b6rcDIt/ymD1qcIlODHNQyebDLYVOHVLNPjCPlRPjhkhoVVjwmxNLgx8k5ag==
X-Received: by 2002:a05:6214:300f:b0:707:29f9:3bd1 with SMTP id 6a1803df08f44-7097964ce99mr76346136d6.46.1754531116814;
        Wed, 06 Aug 2025 18:45:16 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde5a01sm92969046d6.70.2025.08.06.18.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:45:16 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com
Subject: [PATCH v3 20/30] reboot: call liveupdate_reboot() before kexec
Date: Thu,  7 Aug 2025 01:44:26 +0000
Message-ID: <20250807014442.3829950-21-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify the reboot() syscall handler in kernel/reboot.c to call
liveupdate_reboot() when processing the LINUX_REBOOT_CMD_KEXEC
command.

This ensures that the Live Update Orchestrator is notified just
before the kernel executes the kexec jump. The liveupdate_reboot()
function triggers the final LIVEUPDATE_FREEZE event, allowing
participating subsystems to perform last-minute state saving within
the blackout window, and transitions the LUO state machine to FROZEN.

The call is placed immediately before kernel_kexec() to ensure LUO
finalization happens at the latest possible moment before the kernel
transition.

If liveupdate_reboot() returns an error (indicating a failure during
LUO finalization), the kexec operation is aborted to prevent proceeding
with an inconsistent state.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/reboot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index ec087827c85c..bdeb04a773db 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -13,6 +13,7 @@
 #include <linux/kexec.h>
 #include <linux/kmod.h>
 #include <linux/kmsg_dump.h>
+#include <linux/liveupdate.h>
 #include <linux/reboot.h>
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
@@ -797,6 +798,9 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 
 #ifdef CONFIG_KEXEC_CORE
 	case LINUX_REBOOT_CMD_KEXEC:
+		ret = liveupdate_reboot();
+		if (ret)
+			break;
 		ret = kernel_kexec();
 		break;
 #endif
-- 
2.50.1.565.gc32cd1483b-goog


