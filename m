Return-Path: <linux-kernel+bounces-875705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8623FC19A49
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08412461AEB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECB22F549A;
	Wed, 29 Oct 2025 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="2NchK2zG"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798E82F3C0E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733096; cv=none; b=ZZabHrBJMgxQtT8+4uy5olv6wQncba4ae6yFTTp/5kv58UUjcvQ44Oo+u4AEUGCmRMyVhG7bxnWUEsqcstkfoy1+HuOju1h32NyQATXuI04CzjvjCRUuG/AuxTAtldhxg1y5xMPAMlfYGdXx33hDTm6i2LWp7n+URsWtLuvb0sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733096; c=relaxed/simple;
	bh=QssEUbUYx0izMJIUmHudPbCRzHZCBlewAEJ42z/4KAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lr46IhZBDz5IZRFUzglhJ+zLr3XxDg48kbNO1gsGZPJ5MXyk6zFT8HoZc4h8qrEi21ktg4Vhy5StXFKmTAUNqazUvhz163406vKLmWu4+BYQ12e1TkZgccN0uOP6d05bTJ/My9iRXENw6mkcZh9vgzUyjt8SuOAsLL9ABD/kzd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=2NchK2zG; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77f67ba775aso8712420b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1761733092; x=1762337892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MnA5k8KsoV1ze5vVhBRV2+hvyms9kuv5Kp74LGBGZE0=;
        b=2NchK2zGlv+EVw2pnSu9QGxyAddEydVMwf0/imllChQpH6WJ8kbriJ0PdusBLyJcu+
         kCsLs8YDFXk66kA2woWkk6cJPSWhvBcbycD1+Ph5BcBAWPq5KOMa8yzJ8nv/+RTf9LN0
         5gUb3H3ubb9nBRfJ9g7z19oaLQp+uVncPVQvRLC+/pNBgEkSnBzqdI9dw4Nk9LbiJsGW
         GObBqFm4KFo4vUsCyRirEfuNz54AO1Mpn6t5CAwH3mVases6NsjN0hmWX55uZDTbyH6q
         7v1uIYidN8IAHRqNrR8mHkPeSbA4M5BydPE+29xEE0hV0X4I9bGzeeCw4kjyBtIoWCbW
         LTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761733092; x=1762337892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MnA5k8KsoV1ze5vVhBRV2+hvyms9kuv5Kp74LGBGZE0=;
        b=XMPUr6ruOmEhgIO3XnZjfaAASJEe4Bkkh6p7pteOzx03IQqb8TWupkfBlZB6cjFuuY
         GiFrlO6PJBDaGkAPrOYf+K5j14xldbkH1/R8T82uyDFMuenn/pPmaBctUKlBkFalVKpT
         7tMwQpFNJPGroROZxgqkn5MA71bBOSixH2aket/BpokYzy/0B02omeBmU6gN1DCT92Tc
         jAT6p8bN8336ZlCVESLqef+P3FqDNHK0nwHndbr5tycF33M2Qb1qPDtiSuzbU5a153HM
         8r8L6pN+HuaneDh6/03Ysx+wcQpwCWzjZMAZ8DcGgBjGfwxibTlvs9P+0gJ4y8CWjAoH
         0gsg==
X-Forwarded-Encrypted: i=1; AJvYcCWKm+E7ckxJ3BSflRrOH7h4RwlhfJN7jUl4PId3h32ZIyo7UGx5WyhfBFnKoeBbc3T1RXVL85+7OFoTQOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMWFNXzWYFSKezucseMQrfFw0/R8sHbTtSO3vYldqZT+W+OY6i
	kEUYOpNNNS9OYXzK8weL1MS44BNjY6t5FQgXonnL9zY25rG17BC6LL2U8hzljIAUWhg=
X-Gm-Gg: ASbGncsNzJTKDzokGfmHuHX6Zx25qyLJqQxPQQ43GGs9JBkLPxwjIkM7YCx7qUTS5mv
	IbME97A86l/zsEHAw/SYNFRgPZ/ERn6EmsdYQyr9bRp+65u7hSHxzQlzdZfzgoGWmHpz7shqT9l
	HwaqNlxPNHkAcnJVBAcHL12uTFwzw2jUcXSi/J7Vz5Iu+CxNZpsiJM/ddVayW2qJ+bkfGnW4kcv
	1IE1cBe3D6kyR/whKEfzyp7NusAGOouffggdj7HkvKsesQWqt1qmh1C000zPMbIb8CaTu/QfZ26
	XEhKa3EhoXRiqBZoBMnqYhP9w+aGEoxnmJo08mDcGvGSSdH1BTqikSIS6XcqP70bFm+0AnMgjJR
	BlVijv0hshSTEDwpootT2fPd5e6bP9c2ItntSbOL01Ys0ohmlAjBBCVYSn66BCcvGOhblRBbmBd
	yOmwTPgv92OgxNoREisJ7Yy9D+
X-Google-Smtp-Source: AGHT+IG12NVk5cbJTGyTVKHLaQKC7YUnZ6JUn/xWRMCP6ZX7N2wYfe554nd/X6z1OGt87h+b+ioXUA==
X-Received: by 2002:a05:6a00:1785:b0:771:ead8:dcdb with SMTP id d2e1a72fcca58-7a4e2dfdfebmr2813190b3a.8.1761733092228;
        Wed, 29 Oct 2025 03:18:12 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:3fc9:8c3c:5030:1b20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a42aa5d9a6sm11080454b3a.62.2025.10.29.03.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 03:18:11 -0700 (PDT)
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: akpm@linux-foundation.org,
	ebiggers@kernel.org,
	tytso@mit.edu,
	jaegeuk@kernel.org,
	xiubli@redhat.com,
	idryomov@gmail.com,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: visitorckw@gmail.com,
	409411716@gms.tku.edu.tw,
	home7438072@gmail.com,
	linux-nvme@lists.infradead.org,
	linux-fscrypt@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] lib/base64: add generic encoder/decoder, migrate users
Date: Wed, 29 Oct 2025 18:17:25 +0800
Message-Id: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces a generic Base64 encoder/decoder to the kernel
library, eliminating duplicated implementations and delivering significant
performance improvements.

The Base64 API has been extended to support multiple variants (Standard,
URL-safe, and IMAP) as defined in RFC 4648 and RFC 3501. The API now takes
a variant parameter and an option to control padding. As part of this
series, users are migrated to the new interface while preserving their
specific formats: fscrypt now uses BASE64_URLSAFE, Ceph uses BASE64_IMAP,
and NVMe is updated to BASE64_STD.

On the encoder side, the implementation processes input in 3-byte blocks,
mapping 24 bits directly to 4 output symbols. This avoids bit-by-bit
streaming and reduces loop overhead, achieving about a 2.7x speedup compared
to previous implementations.

On the decoder side, replace strchr() lookups with per-variant reverse tables
and process input in 4-character groups. Each group is mapped to numeric values
and combined into 3 bytes. Padded and unpadded forms are validated explicitly,
rejecting invalid '=' usage and enforcing tail rules. This improves throughput
by ~43-52x.

Thanks,
Guan-Chun Wu

Link: https://lore.kernel.org/lkml/20250926065235.13623-1-409411716@gms.tku.edu.tw/

---

v3 -> v4:
  - lib/base64: Implemented padding support in the first commit to address the
    previously mentioned issue.
  - lib/base64: Replace the manually written reverse lookup table initialization
    with the BASE64_REV_INIT() macro for cleaner and more maintainable code while
    keeping the same behavior.
  - lib/base64: Simplify branching and tail handling while preserving behavior,
    reducing overhead and improving performance.

---

Guan-Chun Wu (4):
  lib/base64: rework encode/decode for speed and stricter validation
  lib: add KUnit tests for base64 encoding/decoding
  fscrypt: replace local base64url helpers with lib/base64
  ceph: replace local base64 helpers with lib/base64

Kuan-Wei Chiu (2):
  lib/base64: Add support for multiple variants
  lib/base64: Optimize base64_decode() with reverse lookup tables

 drivers/nvme/common/auth.c |   4 +-
 fs/ceph/crypto.c           |  60 +-------
 fs/ceph/crypto.h           |   6 +-
 fs/ceph/dir.c              |   5 +-
 fs/ceph/inode.c            |   2 +-
 fs/crypto/fname.c          |  89 +----------
 include/linux/base64.h     |  10 +-
 lib/Kconfig.debug          |  19 ++-
 lib/base64.c               | 161 +++++++++++++-------
 lib/tests/Makefile         |   1 +
 lib/tests/base64_kunit.c   | 294 +++++++++++++++++++++++++++++++++++++
 11 files changed, 445 insertions(+), 206 deletions(-)
 create mode 100644 lib/tests/base64_kunit.c

-- 
2.34.1


