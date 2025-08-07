Return-Path: <linux-kernel+bounces-758804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 598A3B1D40D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 10:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D3616BD70
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B767F24A061;
	Thu,  7 Aug 2025 08:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JnyTN5lo"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E5F24503C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 08:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754554181; cv=none; b=TXUvrYxjIZsd3Jc/Cbz2g4qJsRGh1g7ROBY9kLyINnzR7xsD6wktMFwfYhNKSqNUjz+W8mFAKEG7w9ZfGm3jAh7ks4cfeJL5hVGsnPoN4LjoWmS4Ssj8sOnVzv2mWIKwB6zcaI2LtLe5IlFxlthlSJeRdhfzfRZSxPsqlltmT7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754554181; c=relaxed/simple;
	bh=NG8aMCDYi/WL5efK/Uu3n3eKEM6SXtiTD1GUBeg7nR4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jbjsKp90ClMFY+Rzfa2/FZ9V+Mkgh26bCyzKPwYgayOMVQFIAZAPv2CXsZXm7FMy/HOT0NQR6pW6ohWK7GYepDMX6Xk5Gr3NxF31oe4w2SQJOh+lhqgyBSUqPxHF7QjHlyodb2iuy0lf70zoztMFt6hQNtxnLLyHdwyNvsLUdPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JnyTN5lo; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31ebadfb7f2so799142a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 01:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754554178; x=1755158978; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VLNRGdnrrrHWLpewd/Xb7yM5Du12QJz86ZRVs5IOSyk=;
        b=JnyTN5loA/U/zeh9EeRsprpZCyI2pJlOp6FFJmTzOB2Veeb9Wk9B6rrKu2CyOf4KYO
         oQ2w6ntg47wJMWr8I5I6NdClUJ/teNpVldLR7UHMBkykcYLVMcBGxyT3l9v7uckP+C5C
         2tuMMTgglLr9VW5vIMVpQ8rp1E0W7KaOeWSw82/hhAGnb5zQkLbjExnUMb3b6Nzx4AZl
         HY5AOgb68tmbxUo52bwyedurzoCokZxCTSSgEZee8UILfQHKRaKT7t4uO8CdvCd9IJiJ
         YZrGsDelopxNu0O7py9I7I2rREQNW/J5Es7XFfi1edBGXVRHqTSTIn5F4sUqZTb0csAj
         EdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754554178; x=1755158978;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VLNRGdnrrrHWLpewd/Xb7yM5Du12QJz86ZRVs5IOSyk=;
        b=ats9tu/3zwyIJSfoWDXfTmy+SXuVVc6ruBUSl8/8Y4fqgJnJpXUw8zGOuS+LDTSlQw
         fC93wlDEUESXuqgAb4DBR4y1Q/3maFjXFp9DNKwiRrvXZzY3ErnBUY3EpqlwqiB0oQHF
         xdKvudsdv0F+8kBDIyJySSSTbS3IAN9g2ATh3n9V0qP2sMMJYCs5Ikt4CCNoKnIFdAy3
         1s/WAf1xynoupF+GToznW40kNNYN2x/PibCp8OoihjB5g0QwKfGLejZYJj1F/9SexV/a
         A2KQLOOs9iheootWiGBBo+mw9BeCzg181A2ARkmBfar71ZTScmP7Bcpc4/cSTC/XXUB6
         ESXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNWwqk+YGdiLP3DPdggf/CWWh5x5Hvk1RA/TBDfhtSmeYOESS2rcK96j7iTZkQh6ez4ZXAaaJerLU7OD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiLDX0yBc7MB8BOwqVBdrKwKakCq9sAxbzZ6kiepfugv1qOxpu
	D9TU1cwtINV52XrazsR2hqwH/3UCoZJj1AHYZgfWB9nvdiuIaf8G5Qhi5GslHsLADL3qZ8rQxiT
	9yw==
X-Google-Smtp-Source: AGHT+IG8sljjPjemytxJ6EepEkRImkq0DnvG/hG3DgghsQDxt5WKavU7F2Clp5GAwSB/brbaER3yPagxfw==
X-Received: from pjbta7.prod.google.com ([2002:a17:90b:4ec7:b0:314:d44:4108])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4e85:b0:31e:326e:4d2d
 with SMTP id 98e67ed59e1d1-321763087famr3140808a91.5.1754554178483; Thu, 07
 Aug 2025 01:09:38 -0700 (PDT)
Date: Thu,  7 Aug 2025 16:09:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250807080932.1678178-1-wakel@google.com>
Subject: [PATCH] selftests/net: Replace non-standard __WORDSIZE with
 sizeof(long) * 8
From: Wake Liu <wakel@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, wakel@google.com
Content-Type: text/plain; charset="UTF-8"

The `__WORDSIZE` macro, defined in the non-standard `<bits/wordsize.h>`
header, is a GNU extension and not universally available with all
toolchains, such as Clang when used with musl libc.

This can lead to build failures in environments where this header is
missing.

The intention of the code is to determine the bit width of a C `long`.
Replace the non-portable `__WORDSIZE` with the standard and portable
`sizeof(long) * 8` expression to achieve the same result.

This change also removes the inclusion of the now-unused
`<bits/wordsize.h>` header.

Signed-off-by: Wake Liu <wakel@google.com>
---
 tools/testing/selftests/net/psock_tpacket.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/psock_tpacket.c b/tools/testing/selftests/net/psock_tpacket.c
index 221270cee3ea..0dd909e325d9 100644
--- a/tools/testing/selftests/net/psock_tpacket.c
+++ b/tools/testing/selftests/net/psock_tpacket.c
@@ -33,7 +33,6 @@
 #include <ctype.h>
 #include <fcntl.h>
 #include <unistd.h>
-#include <bits/wordsize.h>
 #include <net/ethernet.h>
 #include <netinet/ip.h>
 #include <arpa/inet.h>
@@ -785,7 +784,7 @@ static int test_kernel_bit_width(void)
 
 static int test_user_bit_width(void)
 {
-	return __WORDSIZE;
+	return sizeof(long) * 8;
 }
 
 static const char *tpacket_str[] = {
-- 
2.50.1.703.g449372360f-goog


