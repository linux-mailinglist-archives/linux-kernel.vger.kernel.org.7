Return-Path: <linux-kernel+bounces-893837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7D3C48783
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 499AF4E06DD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A302E92BA;
	Mon, 10 Nov 2025 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Qc+tLPkT"
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7EE2D877E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762798044; cv=none; b=fzzWHGnLBG6GIZbZFnInHFRoek3HxW3eDb7G+qyMRZB7eHCosuGZIetFyMPxM0Bw6NeRRLttSmv7silDeDzO5JI98KeHh1GgbUuN9p2jsBdg7GSpgOeCXsjck6C+ptVKmxbSHNOHpVmIC8pGD9FzedQ5zrNwHGoJN4Coy3M9RzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762798044; c=relaxed/simple;
	bh=VyNx6LSk1rPawkaGefXghtNCiVu7lxr+6r5EZNgS9dk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fEFMivtv4peRy4kLm4Lzqf9PGR1a/mG2ZNmShu/3DOKCpDFRCEW8QqfWUZQpnmjA2DP3+WOQJxe9hsNj+xEvGjLFwa3fMn2UBYcEY/w+uZYQV4OUlDgC4xA+TQ1arEPUp+VMyKXEWIo0j1G9HragIeHeqP4KkVSu+T3Q49SHO5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Qc+tLPkT; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63f97c4eccaso3073531d50.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762798041; x=1763402841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qL9D4+vuZNdcA1n/TETU1FBv3lcXALq5Yj616FCh89Y=;
        b=Qc+tLPkTvF4Tc9IGINAgDBhYp4lKYUMRuXynP7i5350BkoquH2lPAE5K0upBGbg9Sw
         pSTTUrDQDQhaWm/YSWoYxWMuc2wFmj7jMVAitDwWHDImMC/We3HxrMKvwlIP2jWGwtAj
         Qterb18xr4scD0td3Ld5IDpAfoc0crVf8I1foB9xuC/+sq0GBwhm5uDYH+gSfEG9+48A
         keEfmPz9B0DlD03yKX6yEs85E1xrxZl7DLvjyMnWd5Lw2phL7vy1sg7I9WoxxT85YOVD
         D7u5cE8pKrMRpgewexeHZUrKnK3gL5gyJlV1X+ojhwxZPFOMSzgVN9TjUD+5aahcEZ15
         mB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762798041; x=1763402841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qL9D4+vuZNdcA1n/TETU1FBv3lcXALq5Yj616FCh89Y=;
        b=Y2A3h8Oc/HmqkBfmYUIkfo2E1M2MpJW8D+xMLhuj9hhDb1bjCfrQNebDyusPBB+oSF
         Ggnfq1QMUFlN4Fk+x/um+08Z6KuwVs5dz4crw4a1mDXHdCFDWWz5HWNLcScl12Ubz4/h
         s81u/x2SSRnWiAj35jDciuUaR9xrpilzYlsY6qN/IuVnjkabT8CWWpuSvnLRjN52AVCy
         aKJjJ1DY/ySReu9Cy8/xK135wfYGnPh/bDLRovLpWQEQPZ/C2U1YoMA2sSnOU6672072
         7tgj1ehTUuASvfIjANAQdM7dbgOZ0kYZjku93xL4bak9KroH6k1dTXHN02WYGVxsNUnT
         87Rw==
X-Forwarded-Encrypted: i=1; AJvYcCW/+ayRtFnIAAoA/wfa9PUsxG934fSalPRs7+t4M1kNi9LeWIKsUupkRrEEknNgqvl+8D/egtQSQazf7aA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmKZp0/sVQMUQAFSmxdTkhS/FQoA4AY7v6UWWuwD6amHnfvX5I
	oMuGUXF/0Zo2/YPAX9UAFA/361O/WMDcslqZxWNX3zGdknYdDlx+gHUe+j5nTrIjBZE=
X-Gm-Gg: ASbGnctQVdooQw9n6R+3ZnJ4N979DJp7UevQZW3WG/WJKevXA3AvXylEKh+akAPP7fg
	6jo4PaGNy1U0tszRLpXRq33rHd0d/UdEvk2k9cd6X967Dc8igGJrR801kSDYYiFBXKIjOFFhmzk
	YJl1KoCoiv/2JYOXJc08ODMDGXK37ZoyDKzzoeYBR6V38WAIm6eZYFAJQ7HHdPaqUctZloZT2bp
	k4oJrHIZIKiHM2Uq0h0BwYOUoQnwuEOC7z93ewc/yM2/RiVyqa2WF0cZdRdj0dPOnf24zr4WsDd
	thTOLDwSUTDhA1TLeTFUFM2JpkWKSj5VAbMhopGF5Ar8cDbZ1ml/aiW5GALGyVS7dQrVff9bEL0
	13XJ+8QOYVjQM48niqqR1+CImPKcLNm7YHEY1foScqXa7a2V03Ec6SvKGgJ1r2ZEzLAlDfagUQ/
	QYypATcoFJhSV2nPniPyqeYMMH3HVPqJpm7liEhk88rigjXLgR3Jk/065cbXQFNiEEevADQDAW7
	2NcGKU=
X-Google-Smtp-Source: AGHT+IFI8k9m6fstEvlSakNx4eRqRGXfQ5gFh54/EdAevddbPRJpRnpFRHjsRRXHMaEqb+vKcs/2pw==
X-Received: by 2002:a05:690c:3505:b0:787:cad1:bdac with SMTP id 00721157ae682-787d5473912mr97384637b3.65.1762798041432;
        Mon, 10 Nov 2025 10:07:21 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d6a3f334sm25489757b3.60.2025.11.10.10.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 10:07:20 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	graf@amazon.com,
	pratyush@kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [PATCH] liveupdate: kho: Enable KHO by default
Date: Mon, 10 Nov 2025 13:07:15 -0500
Message-ID: <20251110180715.602807-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Upcoming LUO requires KHO for its operations, the requirement to place
both KHO=on and liveupdate=on becomes redundant. Set KHO to be enabled
by default.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index b54ca665e005..568cd9fe9aca 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -51,7 +51,7 @@ union kho_page_info {
 
 static_assert(sizeof(union kho_page_info) == sizeof(((struct page *)0)->private));
 
-static bool kho_enable __ro_after_init;
+static bool kho_enable __ro_after_init = true;
 
 bool kho_is_enabled(void)
 {

base-commit: ab40c92c74c6b0c611c89516794502b3a3173966
-- 
2.51.2.1041.gc1ab5b90ca-goog


