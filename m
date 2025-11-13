Return-Path: <linux-kernel+bounces-898459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35532C55535
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B113A22CA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E742429E109;
	Thu, 13 Nov 2025 01:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hg9WZ1HK"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2832DA755
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762998432; cv=none; b=Zg67q7wX1fPRrRXxbQAsKAOYSBg0Rc4OrdaAtyCoWlohLriJ8gQYqXRyhSJsA09x6kDrM+3+hKqmZ5rKBhuj6IrS9jCsKkCH95mqT+EV75ebDmIW7xNoDaW9GvzFC04dbTu/e71jS724BuGaRiy3Sev+PvcW57mud8HlhgF9mOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762998432; c=relaxed/simple;
	bh=DC8FuULDAPtQHN2narc7WgVVrVXyRDKjRqZjq5V9jfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKDwbXw3UC81BqSmb/DF5X3aV70OCnuXEl0EqKlHp2T8+8XO39HP10LfaMIKYluUVILqbF+mhLKYdvoCQrDs5PP5+EY1Syp4uNfYCYkaiR2UYcBRUBCzjjjh0hkM/V0+uFZVg7Y6vQshHQBGsPh6bu+EUZZXuYpdeMQuGfIeprA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=hg9WZ1HK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-298144fb9bcso2808605ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1762998430; x=1763603230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qhRE3U098N+H4DinfMhjjqM++0OwmN0vpW3M8gUQyI=;
        b=hg9WZ1HK/zWuGsBnn6iwQmKKAWFbYuk8wl+OI0N3CUyKTGpJ0Thy1u8Pb2WgnEfDUF
         im/RsSRjOG668EuLXJpOJ7lRfTtvY/YGpYFl/TSsWu/RHddblPr05yHG6QYq6C8eVShg
         7NoLA3UF8DPvIAW0gKq5E4eMtEN9U6yXSIDIBsztrNd5xm/DjSk1Vx5zzj9BAuRJaOAP
         90kSaVVHJzIrjU6l6ZQU839Qldn4jm2yWCQUld3ma4VtjGdVMV0D9monoZZqLSEtqnAK
         xG/QwtfVBnKixNMQOJGh1IullqzB3g3P0C6kcTM7JtES3c1O0zkuHLGMDvha3W3qwGWo
         2xxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762998430; x=1763603230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8qhRE3U098N+H4DinfMhjjqM++0OwmN0vpW3M8gUQyI=;
        b=EauADWrEstFqUwFIdhkn9XyjB3PmAf9CmAv5TrzNASAhpu13s7kVLZiQFPhkGJvol+
         M2KC62rAw+AnUXG052JUZv/Q/B5Ea2Hg8dykyEvdkN9rer96MlnK1xFASNQY0f7SFDQs
         aMzNL9eRNe2we995ZLdkTAcVtJoJMy6bpOecrNdglGzBA7+cpM5ASlUxl3kjFbtp/GK7
         1Uw/Yu2mZltqjNY31/sXBmKmjtMkXOcbc3C0E2gy0XZ87NQgq+T24ddQAWzDrSssFxfx
         ngzjfW+VST8DrK91A3am9xlotu8hnn0GeG0KXETb5r0FupNrpygN64GMJS8QhI92oONj
         Ig2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVB51P0E4AtfoHQs2g4g2uuqQs/U6Wp6uMwoG+KUYhvJ5fAVtoLczwllanZnEiz72Z7RtGwxvCnnfpOdgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY2q1Xd9uf6FLW1uRPQZxigqjR+NxgwmpSuZA9kCGDoSs3thrR
	NBTP6vONNqtYcuQ7VRNM8tFUs8IhpYxy9sf88wiGjh8p32Jb2UlIxfyakg8JvtzXpsw=
X-Gm-Gg: ASbGncumf+NMvHF+ge2HTk9eWQAoCdYINMhOOPNQoRrCHBe0OR1whk1618dMSHo3Gbz
	1pL0GidCSvKWXhDqA+wvlRSWOCH/tYLcFRBLqN0kBxiQcNj7s+k3pzuQrtwbxzomVYeWjW0E5R/
	tRg4YohERu4eeeLCbX6TZX2ykFVBbWbCVgRcXZin8vclWO/nJnvGWaCgf5KrkqBlRjbSGwOm8MU
	1KN3tBlFYzu/jV4NeN5Bw8EDOrpYgNdZJWeNZsbIoWKgJsbWGatcBATXLZ5CujPFbuk3LgOyocu
	Lg8ruZcMEwC5+d/Fueq/Bg1uQS3gucBdUuvSfL1AHjDAflUzh6fVBGI76sIeZ0D4TAtiJ8m1wF9
	s6Ue5v/xPhW/LfRQU0NaheKxR8jHkSOSbX8OYSh7Qc50LTLTtFkEhrnE6thWM2BPnghVnTNC3BY
	FRYNujhgZYBumHubk1o9lrMQ==
X-Google-Smtp-Source: AGHT+IHi0LBlNRw0NLDEi/GdsrGYk9xzGMjJnjfOoAMMFPTbg+YMkWroJLJ/pOiFoVdYD5QP6kQ95w==
X-Received: by 2002:a17:902:ec89:b0:297:d764:9874 with SMTP id d9443c01a7336-2984ed46fe0mr62614185ad.21.1762998429959;
        Wed, 12 Nov 2025 17:47:09 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2ccae8sm4986485ad.98.2025.11.12.17.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 17:47:09 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	linux-riscv@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Cc: devicetree@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Conor Dooley <conor@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Joe Perches <joe@perches.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v3 07/22] checkpatch: Warn on page table access without accessors
Date: Wed, 12 Nov 2025 17:45:20 -0800
Message-ID: <20251113014656.2605447-8-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251113014656.2605447-1-samuel.holland@sifive.com>
References: <20251113014656.2605447-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Architectures may have special rules for accessing the hardware page
tables (for example, atomicity/ordering requirements), so the generic MM
code provides the pXXp_get() and set_pXX() hooks for architectures to
implement. These accessor functions are often omitted where a raw
pointer dereference is believed to be safe (i.e. race-free). However,
RISC-V needs to use these hooks to rewrite the page table values at
read/write time on some platforms. A raw pointer dereference will no
longer produce the correct value on those platforms, so the generic code
must always use the accessor functions.

sparse can only report improper pointer dereferences if every page table
pointer (variable, function argument, struct member) is individually
marked with an attribute (similar to __user). So while this is possible,
it would require invasive changes across all architectures. Instead, as
an immediate first solution, add a checkpatch warning that will
generally catch the prohibited pointer dereferences. Architecture code
is ignored, as the raw dereferences may be safe on some architectures.


Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v3:
 - New patch for v3

 scripts/checkpatch.pl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 92669904eecc..55984d7361ea 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7721,6 +7721,13 @@ sub process {
 				ERROR("MISSING_SENTINEL", "missing sentinel in ID array\n" . "$here\n$stat\n");
 			}
 		}
+
+# check for raw dereferences of hardware page table pointers
+		if ($realfile !~ m@^arch/@ &&
+		    $line =~ /(?<!pte_t |p[mu4g]d_t |izeof\()\*\(?(vmf(\.|->))?(pte|p[mu4g]d)p?\b/) {
+			WARN("PAGE_TABLE_ACCESSORS",
+			     "Use $3p_get()/set_$3() instead of dereferencing page table pointers\n" . $herecurr);
+		}
 	}
 
 	# If we have no input at all, then there is nothing to report on
-- 
2.47.2


