Return-Path: <linux-kernel+bounces-793881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3E5B3D99B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9111B7A52F9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FA225B302;
	Mon,  1 Sep 2025 06:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="aUr8lRlL"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9881C25784C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 06:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756707162; cv=none; b=An6dJZD5Bthtzi+Q21sAr6/4q91tJt906WPqtrvBEn0SpO9aTfAvg+/bWxrjmshfJzGkX97VmxD13mx2f/Y77p6psqyY0sR0hO7qjr/eFZBW/hF+17UfKwH+m7KZPQFom/BhLx1F+oG8YcmQc+OyDsRQUNmCucL5X2Nf3vhsfI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756707162; c=relaxed/simple;
	bh=BfourEiQytOZURa51girR3hCEwPjkmcFXu9c4X2cuw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQXGAql8u03k5Gki6jS1ZJzHgZofvr3izfbIHJsx+/2YUAMaTRK41KoVoBNj/ujM5xQ8idpsaAO3+U2ui169FU/zPK6Ybzcwb96N0dHtFqJeanLwyGGSSBh7EM5HVTw3v2/BYdsLICHAcHnORABTSkAX9jcbpDIaykl4MXpbGNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=aUr8lRlL; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61cb4374d2fso5598662a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 23:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756707159; x=1757311959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+6TrnZpXfWUfs5R5hmEGqosfCHRnwv9JCMokN8V3u0=;
        b=aUr8lRlLZXpKKfcG3U1XArb+D8+Rb2sp5Jd9LeLcJQISDkjMCCPMYuu+BMoXZFkg15
         2yIBw0eZHDINYOKROswlf3Zu/HyC6M/IdmFdA6JbREgE9UcbOFBSxWlvrFdsGPMcJ2Ji
         MIKce1zZCna4pmDHXF/nAkuaANzxpkPOlWTd0WcjzAJjblxfpBT3xVLxDQNisqiZrC5V
         6cxj8NQ6qqIwwTapg8e2uJ/ABS7HMOOE/H046vh8e3niYcGZPPv/19OOPqkH+dV7Mypo
         LHO++gKba6VBRRUefOTSQi9RFVKvV/nmMFTUJAe1SKfurL0JtsaUI39QEoRg/tL7fDMD
         ABRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756707159; x=1757311959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+6TrnZpXfWUfs5R5hmEGqosfCHRnwv9JCMokN8V3u0=;
        b=ObD4LwsWUqyTSGHGb4sCIb4OOOZeaj9Ef7zRgrExqRcQ5w5Tj9Z16C6+98IsXvd8xN
         68o2mctJw+h+DitCYoM+Bz1qs/DqkXBTdRXX0NZSTXFyxf1LT50kPBlFd4hJ2pna42ly
         qYk9cB/e4NW43+Pa53LoaZlPO473w5hlS/EWo/VbE/3MPGa8stWokRvCSLRNsE6o6x9b
         C4FS10312+zREn9GqArCfjQgRaS8htJfOsc/7VePCLHMy2rromWgkgVce2XAW5OvEH05
         Dzy5VtK3XTlUzG0g7XLLkcYvphXnChIyKvC3OO7ffO8ag+JFxLSMM0Bnb4SeMNysBYQ6
         nA1A==
X-Forwarded-Encrypted: i=1; AJvYcCVaK+Qlz7YiNktIEbUR9B2ZdKxTOJcYbRkL8E8npMkh9TKrjFPgrdJUQ1kI5f1ciCk1JMfh+rmopNUD63Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUUEzlnVnS53XONMQj/gQzTF45NrZ9zQyBf3Nk5auFQS3VqNIp
	rrluaKE3+6O+n2N6+/DRmEmkTUvVMVTGP8e1M+8TsQ8beE4zpLPO+BtxdpgiqHA5ox4=
X-Gm-Gg: ASbGnct+er9wLEGkl2CPMixEwzTaLpedieFnUvA9rdIeBZWkVhMsrANEF9AGdgONLKX
	C8jGSZvWzJhG5cQuL673NyBDZJpUqPXt+m+7JcR3e0VTM9diuCSWhZXYbUB9N/Uu89DCuTNKDV5
	C8Xo3dk3X6M+c4ex/JjxQyPqQEAKuxF8dxWXZDuq6xyxUaWeWTJmTSGa4FmZ9qW8z7aya0FmeWZ
	prvmIZE4VwN+8UmON9Xluzfu3oNlnk5Loa7fXU0czH8Um8IQRcC+07fTPupGz3/ebBHKbuAk68J
	BOAVcX73RrXuSGslIBgXQ7UKOexScl6CGZYDj1Td/vTgHKMxmJTBIDIm/L7mQ3++PY7k8FBVaFo
	9gon065THPPuH5KLHLTSFJ6JprqKHT8elkjVu2PtW/6VYkB9KIxtxhOWf/3ahYmUPDyjM7C8GI5
	OsaL3Zvo0l4xX4Ok7T4QphHg==
X-Google-Smtp-Source: AGHT+IFWkdcM4RcAmhz/n+Efu+qXJCifj1zR/DVBAtOqTkxm9VZW/RyLABBNVHQDHruJ7fqXDjXWyQ==
X-Received: by 2002:a05:6402:348b:b0:61c:5342:7d81 with SMTP id 4fb4d7f45d1cf-61d26d84f7emr6290550a12.23.1756707158967;
        Sun, 31 Aug 2025 23:12:38 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc231561sm6374533a12.23.2025.08.31.23.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 23:12:38 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	vishal.moola@gmail.com
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 07/12] parisc: add `const` to mmap_upper_limit() parameter
Date: Mon,  1 Sep 2025 08:12:18 +0200
Message-ID: <20250901061223.2939097-8-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901061223.2939097-1-max.kellermann@ionos.com>
References: <20250901061223.2939097-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.  This piece is necessary to make the
`rlim_stack` parameter to mmap_base() const.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/parisc/include/asm/processor.h | 2 +-
 arch/parisc/kernel/sys_parisc.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/include/asm/processor.h b/arch/parisc/include/asm/processor.h
index 4c14bde39aac..dd0b5e199559 100644
--- a/arch/parisc/include/asm/processor.h
+++ b/arch/parisc/include/asm/processor.h
@@ -48,7 +48,7 @@
 #ifndef __ASSEMBLER__
 
 struct rlimit;
-unsigned long mmap_upper_limit(struct rlimit *rlim_stack);
+unsigned long mmap_upper_limit(const struct rlimit *rlim_stack);
 unsigned long calc_max_stack_size(unsigned long stack_max);
 
 /*
diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_parisc.c
index f852fe274abe..c2bbaef7e6b7 100644
--- a/arch/parisc/kernel/sys_parisc.c
+++ b/arch/parisc/kernel/sys_parisc.c
@@ -77,7 +77,7 @@ unsigned long calc_max_stack_size(unsigned long stack_max)
  * indicating that "current" should be used instead of a passed-in
  * value from the exec bprm as done with arch_pick_mmap_layout().
  */
-unsigned long mmap_upper_limit(struct rlimit *rlim_stack)
+unsigned long mmap_upper_limit(const struct rlimit *const rlim_stack)
 {
 	unsigned long stack_base;
 
-- 
2.47.2


