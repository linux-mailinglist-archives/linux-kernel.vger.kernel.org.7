Return-Path: <linux-kernel+bounces-627551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D356AA5276
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 19:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75B197B294D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 17:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535992686AD;
	Wed, 30 Apr 2025 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vhd5Jn0V"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5C4266580
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746033348; cv=none; b=nV3Iwyv7VJqyWx/deARD7TgfS9jGf3LjKjzw/GdwQJyM3rrpC/Phkn2PuvRtEymDV+N8Z97WQeIo6Pkf1xGbtWJtvMrvAAP4YIwhgv1GGU1thN/ut/2qHvtLSG4IAOP8pSIcttaoKA7ap/X1caam1CrclqV55sV1cw/EGVYTyRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746033348; c=relaxed/simple;
	bh=b5n+p0p3B+o0lVnDJxYolZguQtjCrIGPwnCN1vjSRAU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=lTpsDlhOXPex3LBBp+BQ9WUr5le26j1GUZMSLvnNse8CRtiQ0B4VNZXch0sLmgUffFlFvZD2tyWw93W8DBDVY1sW95xdiuBc181wza7z+c+H7haLxAe69iFUy4LrfmuO0dLfNP8cJfcCAmpwS8JG7idIi2wPtaU7k4OLVWPPOFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vhd5Jn0V; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736cd27d51fso100504b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 10:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746033346; x=1746638146; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hsdZl0+5u5nJRx5OChJBArmUD0oJ0ouyPxFpzVvIMfU=;
        b=vhd5Jn0Vm0NjAJurOaU6aQCoj+6yX8d/7ai3EpCOQLiv3AyhF1rc9xPQwSWGtAzl+O
         yrN/RltA41dkhz7N96pWuC3cnqvmPyQy0iBb8LwnxzCOIhPakHR466Tp7SEijmCLh6OU
         pTNdpkmsiRoHstoIrgwlyPhUtgtgoY55aHr2I+OWx3XAwzfkghHhj7pu2VnhyDulmFMm
         DyJByI0OaiDZ0LaDx/HMHqvju3PiuScSjLUFH+hX8Fmib0d/ibY6de/NTwyaLNVefSTU
         FjOSx6BOvsrJaXfH1dBs4dcdwpPirweJHY05o88OGdvT4qAQHzYck3tPjtN5NFnnxcrl
         HnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746033346; x=1746638146;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hsdZl0+5u5nJRx5OChJBArmUD0oJ0ouyPxFpzVvIMfU=;
        b=k0GccNSBKKaSLVN278n2nPI8J/B2T3x6JaQC/gKKR4gKfDR3dE17xV/Ubt2i8iYQel
         /x8VDerazoLVEpcV3SV0qgo3+iFwB63nO43qy2N5J13O1nqlm5XqzI0CwKYBnjwnx6O6
         hWAdxAkxJTMm+M8xE1NGjb9DUkuCUFEBgyJk0ocA0bgE027WJv1gOMPUiMiDV8GofZMg
         mjTBURJiSwNPUO5T/U0t9RFeoKrsilzW5wc+CWvURfjA8UxgtSaK9GfERPdJINTwVnOv
         tCpcZcmZy9WXUoBmIQX+Yt2i1vNX8evuDDnzkhOQad9ovbLSUjH2jnfzOEAL7j6Wxn94
         GL6w==
X-Forwarded-Encrypted: i=1; AJvYcCU8nsUOBuSn+7yX734W+UVdQZ5HXJgvtGumAPaSFA2WBKd2S/SGkPDBI8O5ZE2V8Xx00Ld2s5Fk3lo0cU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVn4ogHnOTZUFC51dN3HdQZWib9fhIcf6R90lG7gN4J7LsATwa
	Yy+HLometAbO7gOrLOLOndhdnD4xmc2fgHDG7+8+gz1yXgNG4Qb5voe8zP09GixX+tfQkPC2WCe
	/ogInkw==
X-Google-Smtp-Source: AGHT+IH5YtRVCcmk/wqXASBTNnMEzZz9u8UpGehwrJivWav/O6WKRgJlaCeWX2JmolUzo5pIQPg8Xc06cId1
X-Received: from pgct16.prod.google.com ([2002:a05:6a02:5290:b0:af2:47b7:4d61])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9c97:b0:1f3:33bf:6640
 with SMTP id adf61e73a8af0-20a87d4bda7mr6205234637.18.1746033346436; Wed, 30
 Apr 2025 10:15:46 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:15:32 -0700
In-Reply-To: <20250430171534.132774-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430171534.132774-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430171534.132774-4-irogers@google.com>
Subject: [PATCH v2 3/5] bitops: Silence a clang -Wshorten-64-to-32 warning
From: Ian Rogers <irogers@google.com>
To: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Jakub Kicinski <kuba@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"

The clang warning -Wshorten-64-to-32 can be useful to catch
inadvertent truncation. In some instances this truncation can lead to
changing the sign of a result, for example, truncation to return an
int to fit a sort routine. Silence the warning by making the implicit
truncation explicit. This isn't to say the code is currently incorrect
but without silencing the warning it is hard to spot the erroneous
cases.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/asm-generic/bitops/fls64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/bitops/fls64.h b/include/asm-generic/bitops/fls64.h
index 866f2b2304ff..9ad3ff12f454 100644
--- a/include/asm-generic/bitops/fls64.h
+++ b/include/asm-generic/bitops/fls64.h
@@ -21,7 +21,7 @@ static __always_inline int fls64(__u64 x)
 	__u32 h = x >> 32;
 	if (h)
 		return fls(h) + 32;
-	return fls(x);
+	return fls((__u32)x);
 }
 #elif BITS_PER_LONG == 64
 static __always_inline int fls64(__u64 x)
-- 
2.49.0.906.g1f30a19c02-goog


