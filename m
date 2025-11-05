Return-Path: <linux-kernel+bounces-887241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF606C37A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 21:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A9B3B4F4B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 20:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACB63469E3;
	Wed,  5 Nov 2025 20:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6649L9w"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4CC337B9D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 20:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373457; cv=none; b=D+sGEtWksgLjqB8ODAU/pfu56o65UJHJhIvs7aOO04EFQlj9VPpdu2lHmk8fqFEIMOmcd3tJ6GnzQNymYmM9ZYt65FwlZwP8bl8FzCzsmyx+XvjYZVObE+xTI01wfI0rdCA2RyfSm6G8Y/wt01xYpMGArGkGglKc0//7R4vG14I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373457; c=relaxed/simple;
	bh=Ci+D/Qw6aHWTzp5Pft/ve9w2p6PO9IAnnt5sqH7yjp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bzspUfGYn2spw0+H2rBR+WjnVjH2SpVqP67ltT4ijQfsbG7iL3XblPcJOZRg7uM1MY9mglcudj8fOmtxOeOKXUWzfHXxGcYha+qYh1MPlou2kFiLHf0ES/qz6ps75ThPng9S6ac6gkfWxvVwWzUcU0/J1sHBCJftA8jnpj76cRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6649L9w; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-426fd62bfeaso92175f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 12:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762373453; x=1762978253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gly6MdE7U0LBD683F5RPW4SXNIn5sbTqp5fs+Yhen9Q=;
        b=T6649L9wYrmYNzdlRubC40B7yTQ7BTSWYRD0nbXYit+2FGRtunGGiJ+mvKn+Trs9eJ
         UuQpknoBXqZYwhqdRuSyDQvQuMhCOtGYlhKk/735Mjx1nXbhmrOhrR6Lnz2B6rw35hzr
         nkkmvSN3UNpvF2amU3aFsMsK4tVpeIO34O1wCV//bUt8pKDAINCRXG+jZk8y+NtlFOOa
         1H89l5cZpQT+dbjvUf17Zhped4HFXGOKXTsOQ5Jf4cUwjWuPMdYDaBvjNbX6BKIo5g1z
         kNIntspa5sKiRXp2jbYFd38OYj2mVPDJNDF3xLoopxeUqg21bRgqDxa5rjf4UD4vjgNy
         mDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373453; x=1762978253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gly6MdE7U0LBD683F5RPW4SXNIn5sbTqp5fs+Yhen9Q=;
        b=BuqAQSbVQVXuFLN6j1bXxOURuMO0820f2I6qFNzjC5r0V1QrC/PXT6rGy7m6v68z+h
         2jLDE4JAQTvdMF6qdkYbo4Y1O9UM4nphyPAaRh3Me43a6CWbIbawpYDqmcIBg365F49M
         0dCoJsQFSi5z58KrBJHcVw4hVfgpyvPaJeXvQT6rPVtVP82XwkUo93V36vAGiky3INm2
         TENi8nEv2oKdnZEn/eK2qx/0DFy/oDsxbC36RhGAbSENtOnieHw6Ofv/ALV8dilO3rw2
         WyIYUfQIFWyXD5upJpKR9Ba+vujSl1GQcFAw92AqXgPmba38qFdyPHXYCPOYXCSyQt2X
         Zf5g==
X-Forwarded-Encrypted: i=1; AJvYcCVFYj4KyzsZ5l0nPY4VfRfDe9g9r0fY1xfMESqnDRx+Tl4fMdDb0tUCULiZ0due7JONhr1TCUGnXO9roMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YydYUU9FW5O8/loQB1WpUETkqOvbRRa16kZdAMYuc2NY0RFbPAw
	q2dOSeeMeGUZQscuvdBJVTGS6EDV5CkJOYwKqMHG6/Sc+VCMa2E0dg8w
X-Gm-Gg: ASbGnctMccKpXkh+TOh+zUwEsSekPnWqJi9vgLLa4A82qQc9x6fzKT43D6jq3hqepsE
	Vu0J6l4HAsoju1PfbEd0+TiqabwjhtxlhfKTqJvqCb9r4cmHDVBA6W8lcxZisy+57GZlPdCmSwh
	tzAxqzqfeTBZRGzx1vy6dtemsbN5OPpPQEpHE6jWWFCu4snZjYo/DsDxix4oaI4HZcmd68p7dnN
	t/ltz4GFkNYLw/Z++jxvBIbXWbqBbI9vfeut3dg1haQ3AAfs/IBSgrvl8DqIcvJifwmWdvUw2CG
	W80uMsp63m54xNRsETxkm2PE+aXinNgUR7veThskl6RxqM+bPSs8bZS9rvDfZKEPxT2a7JYD8gP
	efNMC8adAJV5JotV4vTMisv9jcLQ+azIeztNx+jQUVN/9ClLi4jc9Q1BgSpB2oRbSIwZSOA9GcX
	7v57Oa5p97ITFOW9sPgSGV6wzAjmZaa1QDIQ9GcW9iF/6t4aQ58/DUW5aQmMy02A==
X-Google-Smtp-Source: AGHT+IHEZqct1HXIsFvsGs/AM1wuRpHV2gnkZFVBv7Nc7wk2RlYL60/xFtEUiz95ye+sIqSkSqBMqQ==
X-Received: by 2002:a05:6000:2885:b0:429:cf86:1247 with SMTP id ffacd0b85a97d-429e331395dmr3891845f8f.57.1762373453495;
        Wed, 05 Nov 2025 12:10:53 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb41102bsm619857f8f.17.2025.11.05.12.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:10:53 -0800 (PST)
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>,
	u.kleine-koenig@baylibre.com,
	Nicolas Pitre <npitre@baylibre.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Li RongQing <lirongqing@baidu.com>,
	Khazhismel Kumykov <khazhy@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	x86@kernel.org
Subject: [PATCH v5 next 3/9] lib: mul_u64_u64_div_u64() simplify check for a 64bit product
Date: Wed,  5 Nov 2025 20:10:29 +0000
Message-Id: <20251105201035.64043-4-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251105201035.64043-1-david.laight.linux@gmail.com>
References: <20251105201035.64043-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the product is only 64bits div64_u64() can be used for the divide.
Replace the pre-multiply check (ilog2(a) + ilog2(b) <= 62) with a
simple post-multiply check that the high 64bits are zero.

This has the advantage of being simpler, more accurate and less code.
It will always be faster when the product is larger than 64bits.

Most 64bit cpu have a native 64x64=128 bit multiply, this is needed
(for the low 64bits) even when div64_u64() is called - so the early
check gains nothing and is just extra code.

32bit cpu will need a compare (etc) to generate the 64bit ilog2()
from two 32bit bit scans - so that is non-trivial.
(Never mind the mess of x86's 'bsr' and any oddball cpu without
fast bit-scan instructions.)
Whereas the additional instructions for the 128bit multiply result
are pretty much one multiply and two adds (typically the 'adc $0,%reg'
can be run in parallel with the instruction that follows).

The only outliers are 64bit systems without 128bit mutiply and
simple in order 32bit ones with fast bit scan but needing extra
instructions to get the high bits of the multiply result.
I doubt it makes much difference to either, the latter is definitely
not mainstream.

If anyone is worried about the analysis they can look at the
generated code for x86 (especially when cmov isn't used).

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

Split from patch 3 for v2.

Changes for v5:
- Test for small dividends before overflow.

 lib/math/div64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/math/div64.c b/lib/math/div64.c
index 1092f41e878e..4a4b1aa9e6e1 100644
--- a/lib/math/div64.c
+++ b/lib/math/div64.c
@@ -186,9 +186,6 @@ EXPORT_SYMBOL(iter_div_u64_rem);
 #ifndef mul_u64_u64_div_u64
 u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
 {
-	if (ilog2(a) + ilog2(b) <= 62)
-		return div64_u64(a * b, d);
-
 #if defined(__SIZEOF_INT128__)
 
 	/* native 64x64=128 bits multiplication */
@@ -212,6 +209,9 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
 
 #endif
 
+	if (!n_hi)
+		return div64_u64(n_lo, d);
+
 	if (unlikely(n_hi >= d)) {
 		/* trigger runtime exception if divisor is zero */
 		if (d == 0) {
-- 
2.39.5


