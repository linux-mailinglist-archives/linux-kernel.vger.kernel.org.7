Return-Path: <linux-kernel+bounces-835993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA85BA8887
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646C7189D6CC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDE9280A51;
	Mon, 29 Sep 2025 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9GjvHgE"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101BB28000F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137029; cv=none; b=AOZ7jQkMpZlzf8vyYgaLprgftOn7wr+VNg+kk1Qha2alPOdGdSJWDuZoQZxbrIEJDjNVlVJN9qJxKMQXIN0p7tDSKKvTSKEU+WrIyjdRKCyi7nCGb67jKB/g1NDIk3DXhSMQ6kE8l0xxNPag46XRGcM8ACi3AfgOaiRa6Y+3/7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137029; c=relaxed/simple;
	bh=znmLt5OfomzaGPDrSDsHdUSQfq4aMbq0Q7xNVKrUKFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kpLXVWtRE2dBjy10rTVl9gNV7NCeAO+uor3I4WmD5JUgdIDh9cXK/gkIYZJiRDsZAofz0QDDwm3gMy+Y7JnDbQ10/7YfxcdDGGRe0TlXxZVQTUzOr2bhGVRamaNcVgS/bMTCl/cjs+Pow0PXN2+jHeFFaRo6XzQA0vzK3kxnDmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9GjvHgE; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b54dd647edcso3844148a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759137027; x=1759741827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lj4WWsaRXLilwfaGRGcs2JcLn8T7vU8abZJFdf46IYY=;
        b=h9GjvHgEnJNOz6zFe4s1MknNq185piy4E4JUtA7HzxKht/rUPUiGcD2xqxIJe/WvmH
         j4sYKy1LJJd5+5JNBFwdqXc7PWsCClRAGVgynB7fF7XMrDSYIpD0wSbgambvRmEou+iI
         2vxDJHJvzeW2zO2dm4LUjtABHlRZRXY0w0sitpL5Uo6zbLeITbZokOEUISRX2HktNrtU
         6hFmdVbHqhWUpUIoqdqtdd2/CfBL/aDkleQsJtNj+tOaEz1dsXOwufX589RMyDJnYA/u
         gHrOeQYHD76Mj8b0t8PA9dRF8z3xrANrhcVBbU2nbeoXMxGbmqMD1klgdFWzfcHa8vzJ
         UoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137027; x=1759741827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lj4WWsaRXLilwfaGRGcs2JcLn8T7vU8abZJFdf46IYY=;
        b=V/ju05AxZumlHuz9TuPgkqQ2mCvccR7PiJXGGod0FRvB8fE0fI5aAA4P+PQOYr7Bvc
         eA+FiwobW+pbo5z0ACD82Nwz+RkRuwN8FqxIcWFC8RCv0Jn2N8nG8H3R7yXHFYAiV1UO
         qGcLJ7boE9Rut+YfNFZHrAZrsGoOaxzSklIQm4TC4p/Y6pPYCjS2SYdW2RFTsFEaOl9s
         djN9LB82R4zfg3/qvCzfsbF7f0tYO215wbHZw3nhJpxrZRovBvkAjdhRkEcPPqifnynm
         +KRdyP5k23qgOsXOrFMJtRbA4dMaz8HvyKPrYKLtfHFbARCd+QH0dmnwKvsj2PbkJgHA
         tRlw==
X-Forwarded-Encrypted: i=1; AJvYcCUYVgxkuO1ucwbT/cYQxxwoyaUAw2JTfKo7ioz34wctDw1AFVGwnUp1wR1HQ7JW0yHkr0fSSN/r3Bsi2RI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk9kEXuRF08KrUyLuJVUAl1VcMBK8VckkvPF7ur6/wVMPHbPpI
	QpdorGNARoyfK8N3BA9ojafr992Hg9iGjv6LNlMeP6PvIZsc2y+5SZYlVDKiNCQG9lY=
X-Gm-Gg: ASbGnctRAfaK0BHkH/lHLnxbPAUpKscd4pMnVKPVhQxDmESDAlmYTjm1jrUEdneNoem
	8qZ+TaFGlrWoFLkrwQ7Eb9wHspOWSXWLcoW/q1DHfVjQBk4s07CcMxiaT6C59JNed8rS+xVGzyK
	D/8dnuZKY5A/tVXrgCaNrNTATsZETkIDR5ymQ5/KJjw4nYxWi+vRNeQVdiSGhhtIfqs3fJUgp5f
	8fXkvpPRJ3AxoeqwsaPkPv9SfGboPbBbqhZMQrVQdZMR31QeRA8Z83Y5xXE5OkQnCH16s9+cxMb
	NvmHlURWZ8xjCHtqaIGe1JDJw/a3O+R7FkKbzaQFgvvaWLSsCOBmpen/IceKAc6tgUdTJJSkDB3
	IInLweCJO3jCs3GlZNlJPgoR+BNz65TipR+QM3dlJP/u69yVI1OcGoj0KQg4+jOIS9UDVMZ5kK0
	u8gZU0E3wAK4QSbQ==
X-Google-Smtp-Source: AGHT+IFQIlqwwlBzXubHVrRdsRMnA5V+YUkZjEI9lMxoHXiUXcNO/5V5bqXJWDQLGg8sqFpsyeZnqw==
X-Received: by 2002:a17:902:f54e:b0:266:272b:7277 with SMTP id d9443c01a7336-27ed4a6723bmr208637375ad.59.1759137027244;
        Mon, 29 Sep 2025 02:10:27 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:b352:f8fe:e89c:72bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cf6e7sm124929985ad.2.2025.09.29.02.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:10:26 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: kent.overstreet@linux.dev
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:  [PATCH] bcachefs: Fix deadlocks between fallocate and readahead
Date: Mon, 29 Sep 2025 14:40:22 +0530
Message-ID: <20250929091022.340341-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


I found that bchfs_fallocate() only evicts pagecache when FALLOC_FL_ZERO_RANGE is set:

if (mode & FALLOC_FL_ZERO_RANGE) {
    truncate_pagecache_range(&inode->v, offset, end - 1);
}

The hole detection code already skips ZERO_RANGE:

if (!(mode & FALLOC_FL_ZERO_RANGE)) {
    bch2_clamp_data_hole(...);  // Only runs for basic fallocate
}

The syzbot reproducer uses mode=0 (basic fallocate), which doesn't evict pages but does run hole detection and hits the deadlock.

The fix should be to remove pagecache_block_get() from bch2_fallocate_dispatch() and add it only where pages are actually evicted:

In bchfs_fallocate():
if (mode & FALLOC_FL_ZERO_RANGE) {
    bch2_pagecache_block_get(inode);
    truncate_pagecache_range(...);
    // Do allocation work
    bch2_pagecache_block_put(inode);
}

Similarly add it to bchfs_fpunch() and bchfs_fcollapse_finsert() around their page eviction calls.

This way basic fallocate never holds the lock, avoiding the deadlock. Does this approach look right?

