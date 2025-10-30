Return-Path: <linux-kernel+bounces-878691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3C1C21490
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532313AF290
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2550F30102D;
	Thu, 30 Oct 2025 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkqIp5+g"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C952E0B44
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842625; cv=none; b=Aw794pxQSiIZXwOySuCISGAVxsr552hD1Dzcbfshl/CmN1TBgAVAzgnc8oPeT5XWB0c52SkyTxYVw7ZpRFmITj6nHoLYkmJ624Tqfdt5UpzRfwc5lsobIOmS5ufPQtZBA6t/SCa4WitHA7weshG3+114a2rpc7386asdqtU0fYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842625; c=relaxed/simple;
	bh=qOoIy6dapyftgudgvwC6UKFb+j9vGCSqKRXB7LMvdao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OKE26DrCv1HtlPzkkWCKX3YvXW5iNYhnYU+TmX/U3/rsjxdJCt7zRjodGNkSgpqlz1o3349XGQl9UC/0Gr0KMWmXONTZ3nYBmP2yMxDqato2Ra198RfhDUhw+JmuMqO9D6MDCz+RhIdqkN8kM+WcQXLXOFRvxFjCMqmWrIY8axA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkqIp5+g; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso1578493f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761842622; x=1762447422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m6k6XNHyblLB3jubL9kSmrYdZGI6TYgp6RIv86S60EI=;
        b=PkqIp5+gRLVla8a7OhD8mNQ5YiFJf8D04a1A6WhKokzdEmYFieg4/wKGZxjB05jEiR
         G1vq3NIOFyHeqIVqxWLpnkbFFGQ14XZM7cbDkSVsWiGOvRhNt1vCTSKIQCPx2L4l4ahy
         SISuo52mUEIkQK3rSFv32ZgcGe38qMjTJTrY4RIYD4EHLutk4XIrOgkE0awUrjfzFuMH
         ocGk7QMhIAFV/20x0XlZbCDeeZ6Uu1+6dzEQB4qTjiChnVK9vAMJSk1FL7dzCBkDempN
         R1fI6rGwBa9ayBYI2uWV0RcxXp4Tp1FfE1ncF85IpNUZACF6v8dnIn/Qmr4sZ7C2b0Xe
         bmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761842622; x=1762447422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m6k6XNHyblLB3jubL9kSmrYdZGI6TYgp6RIv86S60EI=;
        b=OmcHWQhd2V0yp2R16AwQ4uui1O8tBiKhtciow07VK0pWPt4bFvnmahvlillS/m0Etq
         4FQqsBXciNL6ojnw10gMUBjhYJ1AF+VTRs7zWsaxnrPyfg8N0IVHQ1OMkFRqbdXBMcVT
         Tc8qXKix82HUoUU0ZNpUze5mXRpk2/2v3Gfk3oIAOrXVfLpMr5PkulJzqwn8xsGJueZc
         hK6UaqQnDK+/qDPr5GFMCI7tQo8l7yDv1hvZD3wWu4i7cb1TNfnosIvhlmOSuG/m9QeD
         /YPa4uGdJRDILzF46WZXS2Yr1Ys4g808m8y3+0Lcoq9TjQdiWLHK9syBhraKgcMPM2Mk
         pSXA==
X-Gm-Message-State: AOJu0Yy9Z8rSeXHzRF63Hd/1XkPEntb1t1QchL065Pywe7RdDIYVagqf
	7Zu2MgxnSL2ZCKFQPLFYxDfbBnhGsZDa9o3OKTHg01Q9e3PzuUbXgen7leUVU4rZTbk=
X-Gm-Gg: ASbGncv+YwPL3Zm66HVj6IyzcdwdGtnsyRn5DXMIyqqUoWLHcU2DcsHZ3h0ndYP7Fop
	OTiFs3OOQYDjc+kkk6wQsDpb3CXmRkkFdYEWFjBzXfCYoTB5pAd/8yX3CMQwCDgW+1WPeVUsk7i
	EXtp2wYq/ooEd7W5TzfL9OD+tdxO0AjUUzZKLFHnN13T4ZXH1fyrbSsHWtetFD2UWCIrNtXYsky
	WsUhkAC7/j0zt90a8VsWt/+n9yj2URzAyk6HB2tAQXZM/osO517xYjhb3G+5S1bVkQ0ps/yYkvk
	OxNOtbJx4r7YTa/SXaJilGpmFt6tDI3R0pqjU8lKH6Vs2ey4uFCe2GVXw/i5AMTZLDHp9jkPRoZ
	fBkEOZcViOqEn53DrLuiJiWR0+iiuIeGm7VLdQIbK7ptvxucAMxuTh8BcSYSpjsjzqCyiWjZOU8
	3aUq1F2l/hL9JZElFXaZ7cwQDc4w/7r6GHvRZBW6XOkvkZJO7nvuI=
X-Google-Smtp-Source: AGHT+IEgur31w7PpEABIuUIKSb3JLUGXc5YSFWC+gqstPuiPKTVTHH/djKSDsdIJB+2srU8GdUsZuQ==
X-Received: by 2002:a05:6000:1843:b0:425:86b1:113a with SMTP id ffacd0b85a97d-429b4c68afamr4108786f8f.16.1761842621567;
        Thu, 30 Oct 2025 09:43:41 -0700 (PDT)
Received: from fedora (cpc92878-cmbg18-2-0-cust539.5-4.cable.virginm.net. [86.16.54.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-429952df62dsm36796839f8f.45.2025.10.30.09.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 09:43:40 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [RFC PATCH 0/4] make vmalloc gfp flags usage more apparent
Date: Thu, 30 Oct 2025 09:43:26 -0700
Message-ID: <20251030164330.44995-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should do a better job at enforcing gfp flags for vmalloc. Right now, we
have a kernel-doc for __vmalloc_node_range(), and hope callers pass in
supported flags. If a caller were to pass in an unsupported flag, we may
BUG, silently clear it, or completely ignore it.

If we are more proactive about enforcing gfp flags, we can making sure
callers know when they may be asking for unsupported behavior.

This patchset lets vmalloc control the incoming gfp flags, and cleans up
some confusing gfp code.

----------------
Based on mm-new

I did some digging and am not entirely sure what flags vmalloc does NOT
support. Is a better idea is to have explicitly supported flags and drop
all others?

__GFP_COMP is an obvious one due to a BUG call in split_page().
~GFP_BITS_MASK is also obvious.

Then I started following the kernel doc and added NORETRY and
RETRY_MAYFAIL, and after forking a couple hundred times, it turns out some
per-cpu allocations pass in the NORETRY flag right now.

Does anyone have a handy-dandy list of supported/unsupported vmalloc flags
that we should reject/clear? Ulad?

Vishal Moola (Oracle) (4):
  mm/vmalloc: warn on invalid vmalloc gfp flags
  mm/vmalloc: Add a helper to optimize vmalloc allocation gfps
  mm/vmalloc: cleanup large_gfp in vm_area_alloc_pages()
  mm/vmalloc: cleanup gfp flag use in new_vmap_block()

 mm/vmalloc.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

-- 
2.51.1


