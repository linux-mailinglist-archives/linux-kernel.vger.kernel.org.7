Return-Path: <linux-kernel+bounces-881588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BD6C2881A
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 22:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975383AF354
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 21:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FD622DA1C;
	Sat,  1 Nov 2025 21:47:01 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904C12F29
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 21:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762033621; cv=none; b=c5H/Qxa1Dw1VT5za+gPi06sxNq4kCBsjI2AnkhSBwGIHT7tiS/8JVsE0UNm3276HErogczoHQv1H5s/0L0NWk6ADllXkcGrq39Ycv9n5fXcWU4DhDh45IsP4afDANdUVCd8c4F2w/WruJV4zjy1su2K2WVkRYHXJ8SXRIdviZrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762033621; c=relaxed/simple;
	bh=zy4gVDUOf2eKgnJOOt7qgv3PjAeczx3NDERBIxoVyMU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=T3wnSZmJzg2leZSUd2Mg8fLyLe7/trZQx0rDW4nzMtn/uSX2IMboewYQq6oP0JDK3z7EVHcQ1SBe/a3JLyLgA+NKEXNgZjr/LC3czSHhvxOz/+TqG6l/h+9ap+ShC8uiWYtnaFpFDzbR0JmqR9gE/FAgGc93QMrCLcVO5+nCL6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=markoturk.info; spf=pass smtp.mailfrom=markoturk.info; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=markoturk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=markoturk.info
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63c1a0d6315so6878799a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 14:46:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762033618; x=1762638418;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kMSp0th6bCxP3QA+aJKfwaw3m0ea0N2JmQOxd2MytF8=;
        b=VA3HjYV6t6FirTnRe0/WSGl1zl97InRo612dYDDVnCdf6NzKyY85a4qpbL/CVRxrWi
         Yw8CNPaiPswXf66XQVzGX0GXWGfalApHv17OQADFyJablYhzI93xhJSJWJMTUM3oe12H
         FnewTcWr232aM8DcBg1/aVSxUdyU7sM+Yj14oqDjbq0PXjyUiB4Tu6CcB3bRoDyNYUzk
         ciWaySTG0JjzwRghsdXMN6b8OPorZxxxSiFVjBrh34X+Zy0rD6hnugCNweu+slpWa995
         lnHq5h7AIT/kpRi5DEkYz54ZbwkCQVneiiBS/f8eigZcB2/AnazjsNZzXSbg3YzQOYK0
         r7jA==
X-Forwarded-Encrypted: i=1; AJvYcCVxUFwWlWQcdmtXG6CIIwI7vjYyAUJsQpN1C6NhBvPj1qhJZ6hcwyohA3E1nWlG3ieZioFItrEGgRM3gJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlpni+vTjDeq/7zARVRt1QJv6GultCS4LDyujqJMCCjami+jBU
	QQoKr8Zku7ITqDMbXIrFd0Y9yInInbBxt5c03vnq14w43dvWvdxXhD8BIsUrRbq0l7I=
X-Gm-Gg: ASbGncsIc7Y9IaAagplx0sStGlTlFXXm6h5MwU/dxmDME6isC1rmMfGiOtCNv0ybgUl
	HDMaohbQg2/KseyKsaoHwlhdd6iqu918UFB2ocfQNjDmaOgvTtoxv8MDYLrqd/Sy+BITgJt96H2
	Gtkp7QzNB1OgRX8sL9qdZQ+/atSG7Bo51m0/VhSOdoUYub/4yASGY8EjQJAi1fW28QHkM0Of0MX
	e1yuzxEtaL6o4Riq8KCrbRIWILU22D7MJJAePk7lpfeKxZ0HzLAXRogC39IWEkKzm4vUQJwAfj7
	CzS9ePN69hkaWDqY9MYfJfoLNVme/Q1rQb001Bs2C2VkKY5u2Di1uFyeETY/Bo1WAXA41X/OLNj
	UoE9qppLisuFqzBuBBPmgMCgokd+wEczFHEbu4tp1AVYxRcLtGxr0Z52dsysk7dZvuf+iG4vbRO
	oYh4c3iFHYuX90ivwxHOfTlIgd3do/ln/6JDNCRyZxg7jhfz7yHgQ=
X-Google-Smtp-Source: AGHT+IHZgcAnoYBp0Ct2JBYOEtqKXlO7t3pYEblcllzkMJBgqBpPpXdy/sVa6LJHrnC/Uo93PXu/3A==
X-Received: by 2002:a17:907:60cd:b0:b3f:1028:a86a with SMTP id a640c23a62f3a-b70700d39cbmr861322066b.3.1762033617660;
        Sat, 01 Nov 2025 14:46:57 -0700 (PDT)
Received: from vps.markoturk.info (cpe-109-60-36-205.st4.cable.xnet.hr. [109.60.36.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70779cff1bsm573428466b.27.2025.11.01.14.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 14:46:56 -0700 (PDT)
Date: Sat, 1 Nov 2025 22:46:54 +0100
From: Marko Turk <mt@markoturk.info>
To: dakr@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	mt@markoturk.info
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marko Turk <mt@markoturk.info>
Subject: [PATCH] samples: rust: fix endianness issue in rust_driver_pci
Message-ID: <20251101214629.10718-1-mt@markoturk.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.0

QEMU PCI test device specifies all registers as little endian. OFFSET
register is converted properly, but the COUNT register is not.

Apply the same conversion to the COUNT register also.

Signed-off-by: Marko Turk <mt@markoturk.info>
Fixes: 685376d18e9a ("samples: rust: add Rust PCI sample driver")
---
 samples/rust/rust_driver_pci.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 55a683c39ed9..3cbb3139fbcf 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -56,7 +56,7 @@ fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u32> {
         // Note that we need `try_write8`, since `offset` can't be checked at compile-time.
         bar.try_write8(data, offset)?;
 
-        Ok(bar.read32(Regs::COUNT))
+        Ok(u32::from_le(bar.read32(Regs::COUNT)))
     }
 }
 
-- 
2.51.0


