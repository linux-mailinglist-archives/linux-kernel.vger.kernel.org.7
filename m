Return-Path: <linux-kernel+bounces-883556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF74CC2DBFA
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F32F4EAC9D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2793831D74E;
	Mon,  3 Nov 2025 18:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jDFr/gHD"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A6F1D63F3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195919; cv=none; b=qfud8QiJAtA6E0k2L5D2Hob14YEHZnfVL+Eo4l5KYUDsoKCwMV22CP2QCnFoA8he1GqaKwtArt/78SFsJo5s4V8HF2H2it1+xePID27Ohf6JnDpWm/dUSDcTaAFnLuYsZ9A/pVv3sXsUs7sE58FQUnE/HNBww9IpTtLMZHMMx0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195919; c=relaxed/simple;
	bh=bTBuRia61m/jG3EkoaOE4nkFZOW8WgwnoXev9wiHOvg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Z37gTO9j9L4+2WMOFYM7ltupZUQa+TGKhqKUTGAjdXB2veu7uaFwjTyY70gC/k3Y1yEliu5k5gq6e9wVYh/PJOWiYEAEzlppw7g4CDDOCtX9hIxAJby4VErIhWal32t8tengERKG8ULrDsy2KJyUJdgoElN90CPnri+gYMCmxn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jDFr/gHD; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33dadf7c5c0so5707249a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 10:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762195917; x=1762800717; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uFkcIttTXz5VeiXUFc/Q59ETx+8xz3MvAyheQfgOvCc=;
        b=jDFr/gHDK0bHh0KrZkTqF9EzJ9zVzpH5mo8jkOEzOJwabn4fpO4whqnHAqgeeZhHjn
         tzzzjmH6h+KnW+Nqp04eG1rHEKZTccnbIETvZyVRUezxbPwfaTGqJ1Mo74oXCXaIUySh
         3/LDMAkV2l4+7+vwfLLM39aPh7Z4vkpWIV2zY6dxoRMiwSxVX6m2zrYQIUDwWjXAZ/N3
         QbeKB/7BlVOcedS8hPWAyqzvwucTT2c/WOrKnpDbqfbBH4ezjp6PD8ceiyWjdTE3MYQV
         +YtnSVJA8U50jul0zO9QIP12M3QIfvHYYIOZl0aXZILYxHThoHQW4yPXZA4wMvIFwSR+
         NuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762195917; x=1762800717;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uFkcIttTXz5VeiXUFc/Q59ETx+8xz3MvAyheQfgOvCc=;
        b=gg4kZ1QM5soSjotPfYOsliU65eVlgVZvAu/9Jsud9MbrmXx+hlYQooGgibx8rhJDw+
         cbxtACMe4S35GalW7FSuo/Gqz+QUqI7L1cBLT8NQIdj+4C/ff2r8XC1r9WMdyuZkh9ac
         NwnnkkjgJ5gwhSBgDfQF9ylEfU7/jMcbbl+KelFRELx6HDwBefeeVYqctGfl1WIQgE6x
         jJ+L6kiUCl+T906S/BBLCVcu0do/ha6r51p/DqgaUm+s/sKUo4nJhbqakz5cbR2o/uaI
         DDGkeePsRDHTPv3UZLLiGCDvhMzeeYkDw0gmcG0ximjmWV0aecG2lqzeRGBkJq60WBUt
         GxXA==
X-Gm-Message-State: AOJu0YzeBkSqzAtPgxoeAue5/KqDp9F8pZJMovVGNCf5aF6slYDV3HyP
	iQpJOOjnT0G/TXz+47mJje/OATjcR2AhymZqiVdIDzzesNE4y/5rNsahv7ybMHc5UhDysA==
X-Google-Smtp-Source: AGHT+IE+3Q9Xu+JdN0fNYbBRjVNQ3NNEznlCeElFxqEHSr7vWn/S1xs7ymIP8V3CA26bU5i0sBR0bJ0=
X-Received: from pjblb16.prod.google.com ([2002:a17:90b:4a50:b0:33d:6d99:1ed4])
 (user=xur job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35ca:b0:340:5b6a:5ba9
 with SMTP id 98e67ed59e1d1-341718d05d6mr570755a91.11.1762195917280; Mon, 03
 Nov 2025 10:51:57 -0800 (PST)
Date: Mon,  3 Nov 2025 18:51:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.997.g839fc31de9-goog
Message-ID: <20251103185154.1933872-1-xur@google.com>
Subject: [PATCH 1/2] objtool: fix the check for dead_end function with
 multiple sibliing calls
From: xur@google.com
To: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rong Xu <xur@google.com>
Cc: linux-kernel@vger.kernel.org, Sriraman Tallam <tmsriram@google.com>, 
	Han Shen <shenhan@google.com>, Krzysztof Pszeniczny <kpszeniczny@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Rong Xu <xur@google.com>

If a function has multiple sibling calls, the dead_end check should
only return true if all sibling call targets are also dead_end
functions.

Signed-off-by: Rong Xu <xur@google.com>
Reviewed-by: Sriraman Tallam <tmsriram@google.com>
Reviewed-by: Han Shen <shenhan@google.com>
Reviewed-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
---
 tools/objtool/check.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 9004fbc067693..c2ee3c3a84a62 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -314,7 +314,13 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 				return false;
 			}
 
-			return __dead_end_function(file, insn_func(dest), recursion+1);
+			/*
+			 * A function can have multiple sibling calls. All of
+			 * them need to be dead ends for the function to be a
+			 * dead end too.
+			 */
+			if (!__dead_end_function(file, insn_func(dest), recursion+1))
+				return false;
 		}
 	}
 

base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
-- 
2.51.2.997.g839fc31de9-goog


