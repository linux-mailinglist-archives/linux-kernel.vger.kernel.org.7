Return-Path: <linux-kernel+bounces-884953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 729F9C3191D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DFD218C6BFE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E421A2F5485;
	Tue,  4 Nov 2025 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4K0r7+T";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rf2nDdUw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC7232D445
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266769; cv=none; b=fUKdkoFzNJP7qlEx/2/2Z/lqqF3NjEZ6PoxJVrIBpYA9r2jTQZUP2ZCCQ//cVyUQNi8ENSn6qM0lyb+y7ylbGcI6Qvv228WATJNxEtG8y83GRubnIWajBpxybprw1t/0pgeqT7otUx8Tf0Uc6/usmq2gs0TjNc/w2/FhBLF/JPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266769; c=relaxed/simple;
	bh=s6xj00J7/R8m5+mYh3Y2P/mCOquMh6MbMiGoIlq9A+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e3SOSVzTOSwRm+6CCjovVOJukC1cOYZrAQ5Siub8UFj4Y50LHyUvnDVGX6tCTD93bIXk2Rja6Mkfv/DVkg7EJWCGjas13TrVOAnJZm/s4oGKYWiVE2lsay2zpk68MNmez5IOzky4BrIr7scaf+eenfrvyW8KVMxNzXVxVs2H31w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4K0r7+T; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rf2nDdUw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762266766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vEZHRadoqRgO4IgyXPFxluBKZrkdYFiHDtDy5XP6kDo=;
	b=E4K0r7+T/2twvEYYoHvtm0NjLz1hq1Izw47UqVfiNJFkcJuX6xjdbyX9yeg+TExx6Vd0hd
	QRD/3sX+53OZ+FbB/ymR3XqccgD/1xcOw7cEJQrcyOi2FekIoYj0LmvEOnUbXEF8F5ro2J
	PWV40+QZ67cdZb7McflICgH8SodOCR0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-IUpgMbTXNvOm0f29GvgJwg-1; Tue, 04 Nov 2025 09:32:44 -0500
X-MC-Unique: IUpgMbTXNvOm0f29GvgJwg-1
X-Mimecast-MFC-AGG-ID: IUpgMbTXNvOm0f29GvgJwg_1762266764
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4771e696e76so56793165e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 06:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762266764; x=1762871564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vEZHRadoqRgO4IgyXPFxluBKZrkdYFiHDtDy5XP6kDo=;
        b=rf2nDdUwnMs1aUgjxzgUztjFEApAymHmRCA7ZCqAISOJPyWciP6OEJfQqZ8xrQZ75f
         ZtOUchys51gi5ayLW83txa7/KvvMEZS+qxOL8V3yOZJ0JxN6N5lNQXQtedbmvlt5ad5W
         ZvbHcm58KU8VqyVZFjWb0xREId6wOz5ZpmFFO06fxezS/ZayKRe9xW7RZQbkVo/XnwWE
         TIe0lNk+JL5NLO5iPpN3i0VbBKJaQA0fN8YjriUWKx6LIxpERdqgH/xLYW0DaP10GufC
         uM8fHBj77ZpzT7J8bVx/SuxiePtmPyqTmBpqGbXAPDLFd8KdWS/0Z21aviWwvxvO3VVf
         DO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762266764; x=1762871564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vEZHRadoqRgO4IgyXPFxluBKZrkdYFiHDtDy5XP6kDo=;
        b=W72qw5OTiQ+sBraykZrVUT+c9VhJ2YAXFwhq+0rLbi5Lw9sjzk9BvF4wFBlhsncU78
         AW8i6bcsvG1jJyPfV+ZnslMHVT3qECqXIS/Ud5PdAf5WzWP7WVHO4XVgV6MAcNlzaKvU
         IIMPWLYInQLOfbls55b/mAUTSULsat9R+jE3nPgavm9Lus59VKQQz++tQpYZFZzp/6di
         EMT/mUQgvNWvYjiDWgvgrK8VrLJFz9zEu8dFgRYk+t5EkWUdoUrNFOwUFIb02rAnouW1
         iK9yGfndU2llXQ22SFwCfKKsCiT8nu/2wvGZQxp/j+m9bWbKeLBj9OC0n00X+Eu9Pfl5
         r45g==
X-Forwarded-Encrypted: i=1; AJvYcCXfbop9OTf2fEcNQNK3Ebte+J0BTaL9zJstKdzkVH8GSa2kHAMeFSkOb1Fp/CJ18h4S0xoOj2Rwu2Q/ZXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz90TK/Y9n/h00NA6E1h6yNXzcWuGrRol+nuxL7LSPVlXn+fLvw
	3DN9VCT7N1fWrb+uDG9lnQa8uWg4OZ6ocHO0IlUJzTk7FXi3sSNnjhffeqwnDP31AMMyi0Y9koP
	H2faI3dkvOIimjhWlyNp9e8UnuYP3FZXPQ5dZsKYb2Z/+UWpyNm1Vb9nO3flBK+bHKQ==
X-Gm-Gg: ASbGncs5AQqciZvz7KC0TgA1G9EtVt9GILwkeStmjCSk1VH2sJIKRdNFH/Zg13k3Bpb
	nTkN6Rs0DE71UT68F3+1Qvw+VPCbJDUwwjWLnfeuIGbd1UorYBu/Ntlao6ymMqwCCRK/YJuXpU7
	xte34oZZzIXqYYQYP3ttoYlaSxXpQlA0JiDVSwdQSU6GoM07L9aqm97I6L/ePkrnompcP8/6KKC
	dG5XJiJiMZrnObsYMdcQUuV2SkdXQUHw+WXnIi3dq/G5t1cCPhKIYmhMPlE/Na+qrwsk5mkiQy2
	o1z3j2GZ1r96qP+tDW6EcPautvPH076cHeIceSmUtj2hY3qj1wne/jRk1o2BvopQABHz59JBrHf
	c5aHVgLTJjCjcvuvHqUP1OY6TetiRgLpk4wSE8LDo8zWqTTYh
X-Received: by 2002:a05:600c:820e:b0:475:e007:baf2 with SMTP id 5b1f17b1804b1-477308b6d72mr149701225e9.41.1762266763626;
        Tue, 04 Nov 2025 06:32:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuFO1RurfhxQ8KoSwXSsJCryYZmg5ZaBALPYzQvFuAwcNRk3r60dzVnYtxJMdeRZ/p/LV9eA==
X-Received: by 2002:a05:600c:820e:b0:475:e007:baf2 with SMTP id 5b1f17b1804b1-477308b6d72mr149700945e9.41.1762266763179;
        Tue, 04 Nov 2025 06:32:43 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:1622:5a48:afdc:799f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558d8a1bsm18898635e9.7.2025.11.04.06.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:32:42 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: extend file entry in KHO to include subdirectories
Date: Tue,  4 Nov 2025 15:32:38 +0100
Message-ID: <20251104143238.119803-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 3498209ff64e ("Documentation: add documentation for KHO") adds the
file entry for 'Documentation/core-api/kho/*'. The asterisk in the end
means that all files in kho are included, but not files in its
subdirectories below.
Hence, the files under Documentation/core-api/kho/bindings/ are not
considered part of KHO, and get_maintainers.pl does not necessarily add the
KHO maintainers to the recipients of patches to those files. Probably, this
is not intended, though, and it was simply an oversight of the detailed
semantics of such file entries.

Make the file entry to include the subdirectories of
Documentation/core-api/kho/.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 06ff926c5331..499b52d7793f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13836,7 +13836,7 @@ L:	kexec@lists.infradead.org
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	Documentation/admin-guide/mm/kho.rst
-F:	Documentation/core-api/kho/*
+F:	Documentation/core-api/kho/
 F:	include/linux/kexec_handover.h
 F:	kernel/kexec_handover.c
 F:	tools/testing/selftests/kho/
-- 
2.51.1


