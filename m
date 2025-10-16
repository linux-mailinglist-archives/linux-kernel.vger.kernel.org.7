Return-Path: <linux-kernel+bounces-855436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA937BE1390
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 04:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2C714E659C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 02:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D906C2116E9;
	Thu, 16 Oct 2025 02:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irYzWRXl"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9FB20298D
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 02:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760580703; cv=none; b=q8vofE5wBE3HmLgHqlSEDowi+GEdWQdP18M5j3B1BJICOdOhuOITCGEmC0j3p8xyIZMMV0hoDp6lgvx93R3qeC6BqVyr1K+e/KOJD9FTe1VOXFN6ixKQSVo2fXQFU80p6CtmQq0fBJ3I9n+IFDQCAQnyg/2uNYEtDgsmvFAAtZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760580703; c=relaxed/simple;
	bh=+XyzHt2+lndqbVro9NnPUkSykS/KdNffOJt4rBBZ3DU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=PBobGB/74qDjVUFYOT5T3d8/UW7QPBeI/nRDhgKhjQQWZzUAHMXvQH4+ocr83OyvhxSGzkaSe1c3PpDKKtC+momKme/3Ca0L5H42RXpTDiUKBw4Qi5FswA9x3ABW/RDvil83mRaOREG5FSTYAEbi1eUpsPDThq59CVrn3fGa/vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irYzWRXl; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b551350adfaso150830a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760580701; x=1761185501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sdptM39vQ4ZC4ul+xKv7N2vDIBoFzhiZ3qTbS/fd4wk=;
        b=irYzWRXlibNEljAZY1RizWQ0zecxxVv3XaFPy64HsuOKsUHASNn+HELJOOWn+WTypo
         VArSfsfFDB4IoY9oeysXvQIWQdtv95KcjV1xLjoC2vU6Rdml19CA75IaQpxSXVOWMEGv
         URgdnGs9/s4QsXozI67yhvfEnNf2MdSfBI1Qs5c48ETPMoVdlmAKInhOndgrXjRjdVPc
         Ym+ocJ8TTtETpgeFHTxrVsdXDSJCarstBjsM4dlMvzI4TOClm8VANgXAAZ5UDcCoRbgz
         Y6uoU4GB7sUcNIgT9hllNsFtJJBFcmlwaJcYlwOMbsdNKcN3N0V6HZZF0xqYblqOynoT
         tMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760580701; x=1761185501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sdptM39vQ4ZC4ul+xKv7N2vDIBoFzhiZ3qTbS/fd4wk=;
        b=rBl1f5+Ahy8Bmwm68rCjseB/z3+P+H/LNR32FNaxLU61KlEVPcUzHn0KM5LYSpj+2E
         E5pkRmHhCv6tS4o7Ah4W7AURwtP6kqqSN7z+7gMQeXJTuBttfmW9t1oYohq/fyLdW1CF
         on1H18nO3hHn1D7h4hWGof1MUHJ2uXDS1NxyCNmKQCH4YB30CYmh+MAV4bjiwJFRF/KN
         RJUsH89yXtYi4OeA1/rnmxpdOwIqmNidWaft0D8920qQQQh0HcqrZ89j+fEGKXbTSPCH
         brqEpEXRENISXITANzSjwc9RyxeW4FZZ4l+vDWaR2tGnC+hEcW2rRk6pn2xS80FUXgRz
         rUGg==
X-Forwarded-Encrypted: i=1; AJvYcCU7NlqTQmxq29OJw2PyaJbeKSlZVLXymEHBtqd1Qyuum82zSGD74m1jfn6fd4v9mfTdzSILvGzWlYJZ8bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIs6uiFSH/aEL4fx9MaPmSNKVzy8pSaiMR1i9sl3/O8m6rO9z8
	f1ucp+0DKl265MInLa/8Toy/8e90A035blMeSpTt2Yfg/wK2E2iJmHz+
X-Gm-Gg: ASbGncvCxXasNWcjnwK29pbow3iNhWykLBstpwvVA4i3tGaaOsHqoARKOVfverCmUHL
	Zc8QCtz18uboTB2HNQOvgpCN1jemuVeZ4i4XFdsOF2UrJSDohJJx3haYxqsDX9eL2u4GK+z1Ol6
	Qs1u+ljACXqoFLlU4fuehzltoB06WKAQyYyaKCmyN9aQ1XA5OnrcuOAtbxvHXC0usWIhutysWQj
	kG0Y86dvADdWJoh2lBHzH/r0ouGkyruTdb365L6IQjn9EXFxw/TGTYbHKvti5MWUuuVMaiYa976
	PRbptuE3LbZmJMcHxB2/nzMrjz3PIr6sCRsPPaBGsarzwjxlINtVNJ3ciuREX0rWJqTnke4XmBR
	2usYbI8GK/LQ4dS/Sl0onglZH7wAdO9Z75qrhhABQqbINWv+vfMauk6dNqKD1fqq61LRYQ+pL/j
	xtGPoUBa8W1c/0R+nTBH4MKZEk3PwXLc/PnVYB1eE=
X-Google-Smtp-Source: AGHT+IFbCTTdrxHYHVaVBnRH7IgNG3/mtcqYbWJHh1vVVuc/6HuS6Iye7V7sP+9RojodPULKBM28tQ==
X-Received: by 2002:a17:902:ccc8:b0:271:49f:eaf5 with SMTP id d9443c01a7336-290273ecb42mr374140105ad.30.1760580700864;
        Wed, 15 Oct 2025 19:11:40 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099afdcc2sm10397715ad.115.2025.10.15.19.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 19:11:40 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com,
	Brian.Starkey@arm.com,
	jstultz@google.com,
	tjmercier@google.com,
	corbet@lwn.net
Cc: linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] htmldocs: userspace-api/dma-buf-heaps.rst: fix block quote warning
Date: Thu, 16 Oct 2025 02:09:12 +0000
Message-Id: <20251016020912.1653230-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix the following warning encountered when running `make htmldocs`:

  Documentation/userspace-api/dma-buf-heaps.rst:29: WARNING: Block quote ends without a blank line; unexpected unindent

Added a blank line before the "Naming Convention" heading to comply with reST

Fixes: 507211e3c7a1 ("Documentation: dma-buf: heaps: Add naming guidelines")
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
v2:
 - Corrected the Fixes tag per Bagas Sanjaya’s review.

v1: https://lore.kernel.org/all/20251015183402.1649988-1-kriish.sharma2006@gmail.com/
 
 Documentation/userspace-api/dma-buf-heaps.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/userspace-api/dma-buf-heaps.rst b/Documentation/userspace-api/dma-buf-heaps.rst
index a0979440d2a4..c0035dc257e0 100644
--- a/Documentation/userspace-api/dma-buf-heaps.rst
+++ b/Documentation/userspace-api/dma-buf-heaps.rst
@@ -26,6 +26,7 @@ following heaps:
    ``DMABUF_HEAPS_CMA_LEGACY`` Kconfig option is set, a duplicate node is
    created following legacy naming conventions; the legacy name might be
    ``reserved``, ``linux,cma``, or ``default-pool``.
+
 Naming Convention
 =================
 
-- 
2.34.1


