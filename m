Return-Path: <linux-kernel+bounces-799263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9033AB4291F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43E8D544158
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B183680BE;
	Wed,  3 Sep 2025 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="MI6o9n+u"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DCF36208C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925623; cv=none; b=Lqk6swnNKGk5DSPQOL21DeLdDeBwmzGN6p+QKeSHajTur7RYVFEKuat3sG0pTH4F7qbR9WmpXtwn7p4EbOE+yu+EuLKeA2cRzWSqiyJdFw3S5QupE0ojdt6sqT/4DcGoE/wHvPMVdHNuAqqEcHzInogOlJOFz2WKw9JpJAlcW0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925623; c=relaxed/simple;
	bh=pxMPTepE/BoV6j6uiZYi/9vKVoScEgdWT2VjiTnZE+k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Heeh8y6o6DyakfssafMZICNBqV6A9Gxb+l/teoRkNRrhquaSI1gWx4MC5mC5KV3NVVKocNBXVO+ZUOPC/jFDWfv977wMoXDVtFMwDYp0RnI9QwC7JtuS3xSWWoXISaKYRk2vLo0clBzHaeioaPXgqeZtTgpLCVgXm0jt0oA+kyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=MI6o9n+u; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3df35a67434so160374f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 11:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1756925620; x=1757530420; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dY74Q/u3Ru6+r/HyEqSFai1CTbjcPGijqxMV611+B5w=;
        b=MI6o9n+u6TFeZ7XVvMASXGp/D+8+zzYsuP+w9i2QNfivU6JcJvAlMy6dyU9TQhyeaQ
         hBuqYkAFkb/iE9BOo1utLqrY831WMGAdmjJ4yV6hma4iU8l5CDOygvlJ5tPRDslMuxHq
         JemevkDnyoFqCcPvwn9hR7tATRUFcy8PiaKaWHZV3BtDEBuYavS+wQmt9Hu+LYI5hWro
         nQAw/qbymK8G+QaS6Hu6nyVMs/KONUGtfSVO6Jn0Z1nEW1Zq8soPCI2lZWChKzA0uSg9
         FUaeZBuTvVwp3GR6/F1KBZdvFA61xREEzw9jO763QrOC9ElXkKss8plf1RQeAKnoDvGv
         5yHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756925620; x=1757530420;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dY74Q/u3Ru6+r/HyEqSFai1CTbjcPGijqxMV611+B5w=;
        b=SWQbDd7ublNgBZD0rEMddH22jOJaU/2drpywLz70Jw6N9aQI17GJvIpNYP7D49IbCy
         wuduqWj8hxFruRa3nKU9bWZfzfKd+a01rWHxZWMIBRMTyCp7+sWjjgPov+PMtYmrTpp0
         B9II4XW4Bn0JHFSj5xTG1kB24M4VHkHpmOZrTXTwtnXI9ZKGSA+S6tCvQHOHkwggQ6tw
         mHK8g9vtziNhR7yz7iVs2uMIqHLEvqi/w6O+6tnVT/XD+n5CTSkRvH2yfcaVYObXjvXL
         ftKpZnzcVeSD4d9EqGmmMB2IFJku40AVoch3O24ILilb/WoU+M0kScwDObuDZ4oB+Co6
         Wm5g==
X-Forwarded-Encrypted: i=1; AJvYcCXOH5fcme6s4f3AVD36G/IyT8uBYkKFiyadVsLuhxX2RmnJ2iMhNIQhBvYEdbUmngxicn7BlN9/mPTEd1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YynQcqKgDegrhoe3xzmo+zQEIK5WkkeckvHC8byJs5kRb2rUKr/
	8M2J149E0f0DYUOLWYvOEXjOpEM10n9QRL2+RUDU7BGUeG+kAjZmDP6cKVjF8qwv0JM=
X-Gm-Gg: ASbGncsKbXYEGR1Q5kePRusg4lm9vNEBwLsBefL/GXEEbIEhox6LCsXHx/06gfYVotq
	0CqwS8zEsiHtcyirFhMzKNIAd15nzNGQCiL+nQlnT/i5VyLcTasmOaGVHDtYfi4XrWQx3xLtKER
	9ko7t0GQ2wYvZVjBkgMTNIy/pxCo27asvLqGaQJHCsr7rH0PbXWYcPdISDpE54tb1pisj8ZUl7j
	gGipORo3M69h8l5G0KFEUR7pUEZ3xUhX7Oq0rAplOOtoU4iUOSUhwCGD+z631rO/wsE9SuMMyBR
	Wl2kbo4GcpOLd18IsOkxOFSdFRsfzFFUBw4landTGCIpSim5Wzo/gJR+q8Dhd/BYDqy6dH6bobS
	MMQ0dux5ArGviUieZ6RyE/kOzukqjGFQ+VOzRMkfOTF0CQ5sDnIUWWRsskVydQUGELTQYZqf30W
	wBh6J7
X-Google-Smtp-Source: AGHT+IF8a0A0l2XFuegks2zhsw3pv5dzYkgXtxgGCif7IKK2HfLokVKOJojcWFNnAOtt5tRuZbv6XA==
X-Received: by 2002:a05:6000:2c0e:b0:3e0:3a67:b361 with SMTP id ffacd0b85a97d-3e03a67b52dmr664526f8f.42.1756925619939;
        Wed, 03 Sep 2025 11:53:39 -0700 (PDT)
Received: from alexghiti.eu.rivosinc.com (alexghiti.eu.rivosinc.com. [141.95.202.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d690f2edf1sm13920647f8f.16.2025.09.03.11.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:53:39 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 0/2] Fix riscv sparse warnings
Date: Wed, 03 Sep 2025 18:53:07 +0000
Message-Id: <20250903-dev-alex-sparse_warnings_v1-v1-0-7e6350beb700@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJOOuGgC/x3MQQqDQAwF0KtI1g2MTruoVylFUudrAzKVBKaCe
 HcHl2/zdnKYwqlvdjIUdf3livbW0PiVPIM1VVMXukd4hsgJhWXBxr6KOYa/WNY8+1Baxvi5S4x
 RppSoDqth0u3aX+/jOAHjxIWWbQAAAA==
X-Change-ID: 20250903-dev-alex-sparse_warnings_v1-ecb4a333afdd
To: kernel test robot <lkp@intel.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Cyril Bur <cyrilbur@tenstorrent.com>, 
 Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=554; i=alexghiti@rivosinc.com;
 h=from:subject:message-id; bh=pxMPTepE/BoV6j6uiZYi/9vKVoScEgdWT2VjiTnZE+k=;
 b=owGbwMvMwCGWYr9pz6TW912Mp9WSGDJ29K2SvbPoyTSBe8LrL58UOm4tx17NMX95TNS2E9Msn
 8btk7yr11HKwiDGwSArpsiiYJ7Q1WJ/tn72n0vvYeawMoEMYeDiFICJ7HzNyHDwbGbwq6C87MyT
 HNcbHkbm5Xg4lM/w2uwv9nbqyi6G50KMDNPXR897KrR9yalubrF5cmq3H3zmNVoSbLO26H/pI93
 NYkwA
X-Developer-Key: i=alexghiti@rivosinc.com; a=openpgp;
 fpr=DC049C97114ED82152FE79A783E4BA75438E93E3

This series simply fixes 2 recently introduced sparse warnings.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
Alexandre Ghiti (2):
      riscv: Fix sparse warning in __get_user_error()
      riscv: Fix sparse warning about different address spaces

 arch/riscv/include/asm/uaccess.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
---
base-commit: ae9a687664d965b13eeab276111b2f97dd02e090
change-id: 20250903-dev-alex-sparse_warnings_v1-ecb4a333afdd

Best regards,
-- 
Alexandre Ghiti <alexghiti@rivosinc.com>


