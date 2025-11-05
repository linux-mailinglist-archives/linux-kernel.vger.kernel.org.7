Return-Path: <linux-kernel+bounces-886258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC2FC351A8
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375874622C4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26D7302CC9;
	Wed,  5 Nov 2025 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ds6kPG7i";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ib856Rdn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0B0303A02
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762338523; cv=none; b=LYciRtm79U+UJ5Q/KpvLLveJnrOuhmT8wipVaCuzlnJQ+rVJRyAWi1oQyQoNzKyfYiAxnIqmPD5aqyqBv7RgQUQMVVBltKGEKt7CTDdYVNTtOTSEODRfsXw7beHpDWuDXT0vrWIQF5t1IRK2/ynlgyEoFklghI5S68OZ2sVmMms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762338523; c=relaxed/simple;
	bh=2g3Wq4c97gj933lxG9X1AENf5UzQvkiM4ATmI5KeWkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jxgGftdCvQL3LhoSFbRSGoIhe+ZQy/nUtvzC76UiwhhPU4u8StyA4QwHXCHd346JnizpZtLMAwe9dHVLLCgDQkhM/74NIHlX+KRJa1KLaDV9KhCljF6h24lCdvfrUyPeDOkwkxSl/el9xCh/hTMxHaSuzs2rF+9rKdfEK6vnAEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ds6kPG7i; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ib856Rdn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762338520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/VUtH1lMTAvDzvRlcMfC41+492vEghGBhl70lNg8bcE=;
	b=Ds6kPG7iTR4J+56Xc+3YfLaJB5n9KyEqjSLAifH9W7ecN1Yvw5ZX2K7ByNJvrkzlt3Vhex
	hv/Hes2WJM06rLCCpQWJVSyrpH0Qxew0qoj4BtXArxF7fs4zhnjC9CrVOBPyKFUsATaRbl
	wwszZHnAv9VTGsdH52HyvqVYYbe1g5g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-SVF3HCAjPFiQq7FLjpeCXw-1; Wed, 05 Nov 2025 05:28:39 -0500
X-MC-Unique: SVF3HCAjPFiQq7FLjpeCXw-1
X-Mimecast-MFC-AGG-ID: SVF3HCAjPFiQq7FLjpeCXw_1762338518
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-471168953bdso6046815e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 02:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762338518; x=1762943318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/VUtH1lMTAvDzvRlcMfC41+492vEghGBhl70lNg8bcE=;
        b=Ib856Rdn+mHKalC27oXtAHEgjdSjrTwV3KziHRXmq7BCIySIM57MWEvmyIN71TbZVP
         Xj54jR2v42yW+jJTVARMh6DCPf+kye9bJ7KQ5hb1jz9Ct4+T/d6hKys19h0XfCI5vdkv
         HuMVQKNw70F8e2cEA4NBFam6xIYha2fAhru4MfZ6JCpwbxxybG0jFb7SwYy5fS60g4cP
         f8NM7sMq5K6WkHjXQzR+USlqSXxjKbVIAdRwiYw41lNZ/xhrV+YxqewOcjAcAe2rRb+x
         wRLY9a+V6MuAMDQ4xZIbwGWtcMF+R1Be9D8rgg1A5I6GP8jA2wSLEoaIHUHf4Cq6jdyR
         dAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762338518; x=1762943318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/VUtH1lMTAvDzvRlcMfC41+492vEghGBhl70lNg8bcE=;
        b=tiQ+3SNoIKKV+MEsFf5U7+FPFagA0cl+QZdfevVozw85fBHh7E7Zs3vzr2kuNEaJgo
         O9Ptm41DvPakc06ovalewtTMJMOykG8W+/59N5q0J+eeK1HR/g2tVw2LG0nLHAvHsC7V
         Qg4bzZAgHqsEuygySuVcWR6Nv9/SYisutNoUwWJD/4JJfZNJqpfhprAEXpOikc4fdxIZ
         pr9zzBaHumraxGDEeP/KWco/K+2g3x31baTdD0mZ1PFE9x7v0zO7J27tlb8baCG5vZTR
         19bUEwr2R1xOXo7ZKWKgX9PCaRTsbWC+CJBUbYHy3ucctzKyQmzsc6sGDKSr1JHdDxyg
         yXWA==
X-Forwarded-Encrypted: i=1; AJvYcCVQzgJnI88yuAngSAVMX11LE+Jy+mRkI9xzAN0yjxbbRxV6gv9H3j9KkgqRATlksypBd29uhAjlQery+W4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0/9+n+SOps7+F2Ct31f5qDln0imuipIaKWgqSB3PxYGp3cwHn
	2OqAVmGkzoJaWlmJrzqgX5UfQP9x6XY++Co996tKlfEQMJfyDpVXjVJ2khNEbAe96OVhJTkjHMK
	iPu+4lJqVMcL+pqxZ5nffzOVNc3OsaZpIPhLa9DWJ3bX+RAHO5RfTLdgvGicznV1GFA==
X-Gm-Gg: ASbGncuN2sy8+/vOULfO2bZAA8dqUlwXD8dNIU56gnmf/qi7VT5QPowJLzX7omxm85R
	UbzESBeZWaqMwq7H/qqedtF270PHKwPB61/HnauAzooxoYTEMIh5MAHAV5SlkZrz+FR9N8OeuAe
	qQPUYGO2vEpacSCX5YE2C+EbxY4ECEdrccPV5J3N6vE13SnCBeM4n4NkzrHLQCi3SQi4iNZL7KS
	ixBGf3nRL24A2YtWyzm4hyDSeDYhGQNkvrHt/9k9RanbplaDHJhsMSJRg74SFPxbyhdXljDv5LC
	6VQLirN45rCyAeDnSgaU4KKcQpZAx7Dl5M4zzSn6fly45LQ+jGRb9Dz705r0ZIBXDYdkWlXOZIw
	fDCvULinGHEkY+kTtNHXn9M4dl2PQbOaQoMOZTRptwYsPHtqv
X-Received: by 2002:a05:600c:468f:b0:476:8ce0:a737 with SMTP id 5b1f17b1804b1-4775c8a174amr22510545e9.14.1762338518095;
        Wed, 05 Nov 2025 02:28:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxircFOf0rNRre+DrFhO4ILR1mp/CcibmKKLMg9H2yNUp6Yh1vehKqZ63e3ywj4w2w9Bp4jA==
X-Received: by 2002:a05:600c:468f:b0:476:8ce0:a737 with SMTP id 5b1f17b1804b1-4775c8a174amr22510345e9.14.1762338517729;
        Wed, 05 Nov 2025 02:28:37 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:1622:5a48:afdc:799f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47755922591sm38354495e9.10.2025.11.05.02.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 02:28:36 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: add printk core-api doc file to PRINTK
Date: Wed,  5 Nov 2025 11:28:32 +0100
Message-ID: <20251105102832.155823-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

The files in Documentation/core-api/ are by virtue of their top-level
directory part of the Documentation section in MAINTAINERS. Each file in
Documentation/core-api/ should however also have a further section in
MAINTAINERS it belongs to, which fits to the technical area of the
documented API in that file.

The printk.rst provides some explanation to the printk API defined in
include/linux/printk.h, which itself is part of the PRINTK section.

Add this core-api document to PRINTK.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 297358d26bbb..2b5f86dcf898 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20689,6 +20689,7 @@ R:	John Ogness <john.ogness@linutronix.de>
 R:	Sergey Senozhatsky <senozhatsky@chromium.org>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
+F:	Documentation/core-api/printk-basics.rst
 F:	include/linux/printk.h
 F:	kernel/printk/
 
-- 
2.51.1


