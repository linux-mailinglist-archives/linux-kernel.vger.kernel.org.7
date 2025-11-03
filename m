Return-Path: <linux-kernel+bounces-883576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5B5C2DCA9
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE49F1898E6E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606D81FDA89;
	Mon,  3 Nov 2025 19:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrAMt21J"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50647BA45
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196683; cv=none; b=Ysxm1XkfKCm0VosgyWb5fEge2nhNLEltaBJErK/w3IDqa8HqvhgkEQRhXcEdjNsVtSQZxPopRGxs4oCspryE5dIj6MrXQTnbXUKS+I17h+pLrEmiz2ef+vKk2tYLTAbDCXkoEhK7XVuyRwfQlxHIXT8c8/v9ZZbt2izylfX/IuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196683; c=relaxed/simple;
	bh=zfWobVz93n3B/FAHTEHVa00P1p2GfspLCyOSxE/kNm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZPGKOngqAEmhDx60xA+3WWgDLxSl62mgax75P+Ewe5H9j/jZQBiL/LgcWGU2IEAdMHaXk+nuf4/bX6KqQZdFA83pMw1Db3+JTsJzzh1+na+UqSphYlVweCyMUce0wcyRMs+IIP9EltdLkaPJzQQd06LCxcaJiNXI8DvCQOpjEgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrAMt21J; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4298b865f84so2161193f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762196680; x=1762801480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fexCSefmQslz1ffdDiamddZkpHXIYvXyJ6JNPYg30cY=;
        b=PrAMt21JLwW8JP+FWknGvvDmJyuczmESmlCUhcEOC2E6dszeEpEM79kmsO0hmV6/cX
         WIhiPYL6n9sK0Z4ugba2r/R3v8S9D062nVVSEH6lwi930xoNfesaEirwSBTsI3JCS8IH
         4bkh3pYDB54iRK3lsbc/y8TyJ+Bjf/EcOkdbYGYo6zsZt0bM6JR+OidiJsvUhOYt7Vdc
         t/IvWiuzm6Cp2y0lSMR/ghMiKjg/NFoNMi1Wjs9QFYBm3sjDyrjZzjRHSR63tR4c+fW7
         gGxKGOcpJwBOeEOXniefQB49SZgZdIs+T5w6Ad4nmi4N8ETw7X+8knW0kvnQjvg7eRqp
         KiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762196680; x=1762801480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fexCSefmQslz1ffdDiamddZkpHXIYvXyJ6JNPYg30cY=;
        b=TzMO4I655One86rysXVhOyZYxQGTbsaY/XqT7CaJrraGRJ9hj+uYhmaOUFrUdXnejD
         xgSK23KOlILqqDSm/W4pQRsHESjE+uOTWAZim2JcIkzYfwk4qAHBNW3ENdcuzaOXJ53O
         ywFMgfiMGiWz9++Zk6HVMuZFQo5hDoVAJxofE4fELOrxZ7+lt3JCDZP6fanD8cwIDGgr
         ZCRevjQtrLy0Rm3K22UdqfJrx2vI3Tkiuy2z5OPAsNbUkUSbXSGv/OOFX7oWpBQVwdd8
         WIr13l0aT6f1ILmdZd1+BKD1/0ha8cuIzdpLzaHoLKFPiOU+FLzK7np1r+wn4dF7cmm+
         mwqA==
X-Gm-Message-State: AOJu0YxBoC/9kKnnwh78v8TkWa5Pa7JzdrWdcXkBCkTiyUqWeZSThH44
	T7F6XL6cRB2ba9Oead9B4L+OzkDj4emDblyqC3xOoDpPqq1dd5shdDYv+fYrcJqO
X-Gm-Gg: ASbGncuZZiKwtp4JfIj1CRFNRmFD93Kwk4nCfH0ARhAmU7cBBbnjTxEO0iMey3GJ6G1
	ByDY03vX+RMNyQn8tJE7MKBx6o+QmMEitZ7xu7MASlvkZu1U2tGdqD83VGTyQcKW1PRp4Xv3QTN
	vwE+V5GXoRxZEgVtgh5Nwo+ZXT2mL+EBSLMX/G2YPiSrJd3iEyEWilSIPsl1z46dJuNUWYIcArP
	GG/ersMy0ufyMq4aAjnhiqVGZwd8Og9Owi4T0nDzVMqXY5Q+Ed3AayWT4mRKfY+G3VVF8MDlBKX
	aTYbu5NHZPula5vuV5XvG+Hwrlj6GEaj2yIJy9B3Q6syCbw+0TFQicycjnnraAit7+ODZn6U2vg
	h4juw/ghmiX+8bsdKPbCGPimvQbiZMuEpGAFJgqpPz37/NQ3TYqxbRnxx18iTo+OLHxOPwNkbS1
	56/iyWA/ZK/SP8le9GAcQzstamlauspwvPzeWJRaBH3FfDDMCRDICNMypNa6xX9g==
X-Google-Smtp-Source: AGHT+IG2fVh1qN85r1cd+mUxA1KUwJ+pMLth8UL6voFWjtFCEOmLBM0dU0z1uJI3EhqKm0/d2PfG+g==
X-Received: by 2002:a05:6000:2383:b0:429:d495:7c8 with SMTP id ffacd0b85a97d-429d4950a5bmr3272773f8f.37.1762196680030;
        Mon, 03 Nov 2025 11:04:40 -0800 (PST)
Received: from fedora (cpc92878-cmbg18-2-0-cust539.5-4.cable.virginm.net. [86.16.54.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-429dc192ac4sm327407f8f.17.2025.11.03.11.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:04:39 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [RFC PATCH v2 0/4] make vmalloc gfp flags usage more apparent
Date: Mon,  3 Nov 2025 11:04:25 -0800
Message-ID: <20251103190429.104747-1-vishal.moola@gmail.com>
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
some hard to read gfp code.

---
Based on mm-new.

v2:
  - Whitelist supported gfp flags instead of blacklisting the unsupported
  - Move the flags check up to the only exported functions that accept
    flags:
	__vmalloc_noprof() and vmalloc_huge_node_prof

Vishal Moola (Oracle) (4):
  mm/vmalloc: warn on invalid vmalloc gfp flags
  mm/vmalloc: Add a helper to optimize vmalloc allocation gfps
  mm/vmalloc: cleanup large_gfp in vm_area_alloc_pages()
  mm/vmalloc: cleanup gfp flag use in new_vmap_block()

 mm/vmalloc.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

-- 
2.51.1


