Return-Path: <linux-kernel+bounces-779237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9D1B2F0CB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14C77229E9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670812EA72B;
	Thu, 21 Aug 2025 08:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x0LOF0/a"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034122EA165
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764063; cv=none; b=RKNC2vDQ/5hQk3D86y6O+tStWZ9Uvke3rPCDjnbXt32nqg+qGhHa68qcFlrQxo1cYHdtaUrpJpnYsWg55tr3oOhf74pV4+65dDdZDK8qesUg9iNpS/AHMdrZbP/8LaeuYNGnrQtqjtybFTJV/nzoTpMs62xJZiuWQyUNCdOGgjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764063; c=relaxed/simple;
	bh=qoDF1ovJLicBrzwJxz32Udbfhq4kyqYKtfXv9oULSqU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=syvXa8kAIz42r3+W8p+A2bbL1/IgpZmCQjNhjpmS4kW6YzVyYc6IKnvm63oNejJfIFcruFQaCPflb+2UWIDsoy1j8TX6nfdRYHoIhf5W2lX6ayuCWr/63ZkmeP4UIwY9O90ln11f6JYLw0zlfAL+TxkRgINRJ7Xu+hMD0POqWXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x0LOF0/a; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b0b6466so4880675e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755764060; x=1756368860; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dJOAg2LepmucyL506XIcO8nq6zYHDDz484cJsiMQI5I=;
        b=x0LOF0/aY0wHkDyRj4bxdvKPkz4as5p6kR8B6Ac9EfX/SGzVlaYd34cBtY2USeTcZA
         6uO4HZOCDDM2U+Jn8Ks+vwA+edA1sF248nT/umlKMGF4F4qNLhFxzXlDTpsWUMR4oFGb
         +aH3cTg/ceJ4g3AKl9vf97PZlBMrXNeuSElLu3p5hjdluManD7K0x2o6/XCj6bS2nCmf
         RYVUDh09WYtq9ssQapHYFSGUCvnMovmjJYaNgZtlqsrOIx4rVDua/Pfx73dgsZ7J7Soo
         j3cZ+JTMNVhjwKUT3SG3vmSFXhIAZW+0+zRtN4kwfClVnbh9HFxuuWxI68NhV7NbQHgJ
         DPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755764060; x=1756368860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJOAg2LepmucyL506XIcO8nq6zYHDDz484cJsiMQI5I=;
        b=IFOdi+G1dsy00N/E3g/VT1oFWanlo3BqcPNN0Ec8OC35+9dO3dFiDOuJmmRBS4XK2g
         OZw/Wsox+2FbCFL4We90gJzu3ANPi/nw9OtlHxTZ7Eov+6WZMgIZ2OaC9rv6Ex6+AK47
         MrlpnvISEEVWRXyFGrX7GKRrf7/VQs3vwJXICmHoyNHPmt4zvfJV9hjQGQ9gDQc2+HCh
         lsxX0W49kKbZd2Eq7r/wWnWxSoINAikK3TMHlFwM1ldffssNTPLl8xaTJEeeH+21fVYs
         QIOMUUiFHeT5Sppf81+RX+2EbjqgMJpybpgI4C7o1gQ9X+vNK8HYWXz2lnyKzSUk+p+C
         o5/w==
X-Forwarded-Encrypted: i=1; AJvYcCXVhggoIlF98J9oPxXC8uyJQRfz98zYNpHwZcW95fK/uD6HQiUkqwX7ttnsOLiEHRTy36KvZl0c0SkFFWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YytL/IKtXcOjfQIC33Ib75JJJikUaISoTYFy7ag+UrsNTqhKriH
	rzvYs8yxCpmJAXuF6tUNtQspub2d+jivoJgX3suXvET6WYXPX5Zoe7CuJlkk6zwBBARhrqVKNDf
	w7DqwLSd/eRkeiU8z43M+2A==
X-Google-Smtp-Source: AGHT+IHcoqwzyqcPrFsP+sYGNNnfFwMlL/y8NDzxBQBSaC+pxoZobjyvT11sCcSBD4JOgEO+Nyr7sVyBoR8vIUR9
X-Received: from wmqa19.prod.google.com ([2002:a05:600c:3493:b0:459:dbaa:93a6])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:358e:b0:459:d3ce:2cbd with SMTP id 5b1f17b1804b1-45b4d7dd79bmr9793685e9.13.1755764060486;
 Thu, 21 Aug 2025 01:14:20 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:13:49 +0100
In-Reply-To: <20250821081412.1008261-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821081412.1008261-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821081412.1008261-2-vdonnefort@google.com>
Subject: [PATCH v6 01/24] ring-buffer: Add page statistics to the meta-page
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Add two fields pages_touched and pages_lost to the ring-buffer
meta-page. Those fields are useful to get the number of used pages in
the ring-buffer.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
index c102ef35d11e..e8185889a1c8 100644
--- a/include/uapi/linux/trace_mmap.h
+++ b/include/uapi/linux/trace_mmap.h
@@ -17,8 +17,8 @@
  * @entries:		Number of entries in the ring-buffer.
  * @overrun:		Number of entries lost in the ring-buffer.
  * @read:		Number of entries that have been read.
- * @Reserved1:		Internal use only.
- * @Reserved2:		Internal use only.
+ * @pages_lost:		Number of pages overwritten by the writer.
+ * @pages_touched:	Number of pages written by the writer.
  */
 struct trace_buffer_meta {
 	__u32		meta_page_size;
@@ -39,8 +39,8 @@ struct trace_buffer_meta {
 	__u64	overrun;
 	__u64	read;
 
-	__u64	Reserved1;
-	__u64	Reserved2;
+	__u64	pages_lost;
+	__u64	pages_touched;
 };
 
 #define TRACE_MMAP_IOCTL_GET_READER		_IO('R', 0x20)
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index bb71a0dc9d69..064005c9347e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6113,6 +6113,8 @@ static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 	meta->entries = local_read(&cpu_buffer->entries);
 	meta->overrun = local_read(&cpu_buffer->overrun);
 	meta->read = cpu_buffer->read;
+	meta->pages_lost = local_read(&cpu_buffer->pages_lost);
+	meta->pages_touched = local_read(&cpu_buffer->pages_touched);
 
 	/* Some archs do not have data cache coherency between kernel and user-space */
 	flush_kernel_vmap_range(cpu_buffer->meta_page, PAGE_SIZE);
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


