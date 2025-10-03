Return-Path: <linux-kernel+bounces-841323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1FBBB7090
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 15:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFFAC480A32
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 13:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65771E8322;
	Fri,  3 Oct 2025 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pZL5hGgV"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEE51DE887
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759498741; cv=none; b=SzDSAUtE8NxUTi0mUz5dhqykxVtCyfqGLBlFEJ/lk12X1RIcrSXBj+Al8sRBfsHXSZ98xtkUxG1dLpTIVtrzG2+1uFm1ZmZZH2Z7mkuSEJk+srZxCnu+k3+yrrtGJK4vq89el7JGbr8AIRfaQ3aXflGQFF8bssbs34yklURoCJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759498741; c=relaxed/simple;
	bh=jCel6UdKVBBhusHDhXdBf4Elma0H22ACWTajZaCTXDg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aXA0+SeTjnqbEUERkKPl+C4QSOnIgvoZ2x0LMJ1vp36fT354OJVGEyh+mQoWCLPkvEOlNH4bA4UQWFynQPtNXb2AzMVLWmY4awWKcfnYFkQ1HWF3p8XdYoBDKxfI2+0eTQ9q8BaN2VNFFXJb+y3D69W7D2t2mn149q9A3ZR6ft0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pZL5hGgV; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-afe81959e5cso338925766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 06:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759498738; x=1760103538; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5yvbWhTiB0g5MKRQJDvE9eSL8LzKl9DcqfgxeSAHNnQ=;
        b=pZL5hGgVtXOj8DYdG+wWnFQtZ7wsfe1k7fMfFpw+DA0Cr1WxDZJ+UCfWvzpCf4dTXJ
         glAxoOD6mZDy6rtCVIIwjUxCrM3pnwbWUk69Az2MVlzO73Xzc4MGz3libKAvbnERMQ0r
         wp2JwdgWJyy06aoGoE93aUbH9m+keR4CLoHel0R2do9vvxce+OVnIOdFBbET/FXgdTkd
         ZdZkcskBq0Pge4DyJBZzmpWzFw+ljI5V1Iyy0a3DpKdeCgGsWxJt6pfBa7AlMLce9H5e
         IrtldTrnsT8rYFz+Y+sBe6nVUnPb1IvmScIG+b++B2P7JOBHhnH1jWI6owIwmHSTrBH4
         bDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759498738; x=1760103538;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5yvbWhTiB0g5MKRQJDvE9eSL8LzKl9DcqfgxeSAHNnQ=;
        b=QrrwvliGVd3p+O9zcD/Q9Pw4DMxHmEUTIuTNAKK3CLgLf15KlfSe+Bv6ztpXZfTY/I
         lRipw2tHf6eN0Fwp/nbHCy6kauh0Z3qreaiXwDNxiuMvwWhJ56VUogo1PKNgQjQFzKkL
         D6nLxu2NyVVY80m9OPyhB5LqYSPCKKBzWpoIA4WsOV6cKg2D6df5GyMRFbHs6YkvqrTh
         n3SY/1p/QxkaMmyM+fLDa9j9OOgGOGn+yfOjWJn65ClLBWLz+9kmASYgA21b8Qp1Wm1d
         H833zK09pd+PsOIxAZjoVx+jR/OwZrZZINDurYgiDkfLtuvd3som8NwltSmp4EcNgFzN
         h9sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXJMblqoXatIxBfzQ7O5oysxlTj/vMpXbH7zp++1T5k70QGoPr/zHlxuoPfy155ky1oOPnw+7UNwZ1GNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx0CpjzrPPXXy20bnByoRvVpkcTAVukRQivYGoqKAwY39dpNXz
	2wSQFpEXfaIc/lLBXklUc9t4x5Yui6o7kQoWXXRYyYto/FCwh34T+CbvVlmxaVzas71d0jZmSF+
	4azZJhe2ojVXrNh+dzi5w+A==
X-Google-Smtp-Source: AGHT+IEDmCVx4kHhiREAX0skvRTb6ED4U7OtfqA8ZOw1gh/kLPh63qYxbg7uCqtcVIZm2PCNUon2JI3FP9RVn5iq
X-Received: from ejcsa18.prod.google.com ([2002:a17:907:6d12:b0:b3b:b79e:764])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:4789:b0:b04:1249:2b24 with SMTP id a640c23a62f3a-b49c3933062mr408664166b.37.1759498737576;
 Fri, 03 Oct 2025 06:38:57 -0700 (PDT)
Date: Fri,  3 Oct 2025 14:37:58 +0100
In-Reply-To: <20251003133825.2068970-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003133825.2068970-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003133825.2068970-2-vdonnefort@google.com>
Subject: [PATCH v7 01/28] ring-buffer: Add page statistics to the meta-page
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
index 43460949ad3f..2c157cb86989 100644
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
2.51.0.618.g983fd99d29-goog


