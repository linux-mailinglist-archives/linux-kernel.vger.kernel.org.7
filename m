Return-Path: <linux-kernel+bounces-786625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F594B35F3E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AEF13BAA3B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED64E2D060B;
	Tue, 26 Aug 2025 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0duExL8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512A1191F72
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756211902; cv=none; b=A1nLS4CjUaXRhAFSmg2/KHvE6DSg3IFwBpuHGDRFJuh9pakBozZw9WS1cSGRxUBUy4vIih+qxvRXgFVoVN9ANcOso00iAmYmOKMVCWzpe/LlgnKf20idBes8EEOC30zBPujuf9WnElLthSEFa+1kMnjFw6PThNucAwmIpRBjsD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756211902; c=relaxed/simple;
	bh=eMENLqxHzQQRExGaCUyCzfHRWShUoYDQAQ6JsPXHglU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D7BvDOL890u46gdRKsW0FbjbRsaUVehb51EPh88G1720PrONZ7tfXKUG4APF09pbFtHODhSshLFW2sAMpuUvoCwgEDIDX9mvK10pT1d+XROE+M7KRNXAIOS34B3ruYoWlCuJ8jiNQgKtSM1tqE2RbY0OEc2tLLQSw2GUkIiUtNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0duExL8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F13C4CEF1;
	Tue, 26 Aug 2025 12:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756211901;
	bh=eMENLqxHzQQRExGaCUyCzfHRWShUoYDQAQ6JsPXHglU=;
	h=From:To:Cc:Subject:Date:From;
	b=H0duExL81okpSlnLoxs1EG1AhCa+yp/45AQAWEWwP7Z2oxsc6tdDlyY0XRd/cUfJa
	 Ji51alkHHqhzK+HtwCMwYnCp92/k3M/9XW2NRqE520tCPcw4cn0Z9krYBhxTdNHCBh
	 l6bVATbp/FW5SxW9sO3Qmte/6N2zttf+cKphDOMiw6KpNDbJmSivqK2gy2eShjTPvs
	 Gjkhrx9HzO2jI3/HFUGgFUkYsM/Bs/uiysC2YC1hnyHVAkXLc2O83Y8gtcri8bEMZu
	 +ls7hgta7LSPO3y0spLUHYnEC+ft/XgXV5dYYhHRhxxJ6Al59rDKP0RP86i8busKmm
	 FOr/DLHl24C0A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kho: make sure kho_scratch argument is fully consumed
Date: Tue, 26 Aug 2025 14:38:16 +0200
Message-ID: <20250826123817.64681-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When specifying fixed sized scratch areas, the parser only parses the
three scratch sizes and ignores the rest of the argument. This means the
argument can have any bogus trailing characters.

For example, "kho_scratch=256M,512M,512Mfoobar" results in successful
parsing:

    [    0.000000] KHO: scratch areas: lowmem: 256MiB global: 512MiB pernode: 512MiB

It is generally a good idea to parse arguments as strictly as possible.
In addition, if bogus trailing characters are allowed in the kho_scratch
argument, it is possible that some people might end up using them and
later extensions to the argument format will cause unexpected breakages.

Make sure the argument is fully consumed after all three scratch sizes
are parsed. With this change, the bogus argument
"kho_scratch=256M,512M,512Mfoobar" results in:

    [    0.000000] Malformed early option 'kho_scratch'

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---
 kernel/kexec_handover.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index ecd1ac210dbd7..a90d55121a7a0 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -446,6 +446,10 @@ static int __init kho_parse_scratch_size(char *p)
 		p = endp;
 	}
 
+	/* The string should be fully consumed by now. */
+	if (*p)
+		return -EINVAL;
+
 	scratch_size_lowmem = sizes[0];
 	scratch_size_global = sizes[1];
 	scratch_size_pernode = sizes[2];
-- 
2.47.3


