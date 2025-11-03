Return-Path: <linux-kernel+bounces-883726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79925C2E328
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 22:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15C7C4E22F4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 21:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560362C15B7;
	Mon,  3 Nov 2025 21:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HLC99ka/"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5933328C871
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 21:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762206769; cv=none; b=aoiIdp4VZcKLsrvgP8/L3QV7fTFObHVMN7WEQ9fTsH1UQ82PwoX+h72mYBtSLEU9DXMNPuJLa3Gutynkk+LVKOBrS0nHLrgk/fzsbhPfILE+xXdMRE6V+CnJLeDkhc5E9EKTe98NoHZHAiDzqFwA2wMwtOjlaxtU2u0fbHlG8/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762206769; c=relaxed/simple;
	bh=bTBuRia61m/jG3EkoaOE4nkFZOW8WgwnoXev9wiHOvg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Arylsi4Yrz3C8gAYtSpwxzrbLE6FOoo6ML1/9wVicn4wsKHXVsMvFYxaq1kyaAMvEhE4+EvuEZOg8JYksX0gYcXnwzbdiL2e8sIH/Z5NSsQYHbKTjxtI+GCM92oO47ULSIqiADcr1e7AG9GDUanFNRntOBmvj3DMVSLF/l16bfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HLC99ka/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2904e9e0ef9so114179845ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 13:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762206767; x=1762811567; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uFkcIttTXz5VeiXUFc/Q59ETx+8xz3MvAyheQfgOvCc=;
        b=HLC99ka/5un1BN7nHVwkjjYTOe2JJVW3s1M1rXaAgGSATnDkrVM+qnUYopayRDoJIx
         fwB/9eIvtMFYoPcLSNh12UxO9xIBpfnWv2Kl8KGVAavoYtG+hzpVbCU18UnrXRduiUCX
         TcyEvaoFsB7zZO6Xxw+WbiZjRQaJKH1tWZKXAvn6H/fHBo8I0D8WGkghKAlSAmkWJCDV
         jSi7vdU+qEamcR9kgPz5N9/PgOKfQ0PzcUn/hwiBN6sqEK/XTxE+DBt3qSRUQ9AsrXUO
         ZlXbFrH4KXoGXRDAEEf07Fx/clXBnkfoa47buGO0QEUab7HCvviwUg8mn8138rt9H2ej
         M4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762206767; x=1762811567;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uFkcIttTXz5VeiXUFc/Q59ETx+8xz3MvAyheQfgOvCc=;
        b=fN88U0hjbbcVM8sUG6RvCImZCwBRm/+xsvCMwHGMCB7PeYQVmyNcJg5NfN8BBeklLE
         x8whKmtp2zahHLlZsMarNTeiyTYQRtpzMsQIivLLmAPMZnGW5fgx4XU0ywo4KJjIENsh
         tB0UVzQa+uHeRmpbfqmUQYawfG0tgn5Nw59YLNlyFwRx3dxKA8bS1tdR20QOmgE0hY6+
         j7jT79zGMkZhAR69cyvbPucdbX/UZXynv/HoMVultQMk/hJwuTVjsI35kDoQra+vY1Mc
         x5L0DQmpQbJir47El4fXvqWTqBifJrzvLjahUHeHivKkKCa+Y/7x8xA3vUwcrvdi19zH
         jE+A==
X-Gm-Message-State: AOJu0YwbUpBAerPq3LRZZuJfrA2yd10lDIfizOKIqybsq5h5GtQ212Iv
	sW78NZjoWWf35t8u2E7Duj+U6Lu1B7gDXNRTY7HsWvtAlV0rk1y3nbZ6GwaqUyZuqwkQsw==
X-Google-Smtp-Source: AGHT+IGXrXuz4lDC3hVuJg0c2xaS47MRIDYRtQmPg5kmZHqfpLCvaRNykNojZzFyu3ZD9CMIA7p9nUM=
X-Received: from pjboc4.prod.google.com ([2002:a17:90b:1c04:b0:340:bb32:f5cf])
 (user=xur job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2308:b0:294:9813:4512
 with SMTP id d9443c01a7336-2951a38de1dmr177469615ad.3.1762206767581; Mon, 03
 Nov 2025 13:52:47 -0800 (PST)
Date: Mon,  3 Nov 2025 21:52:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.997.g839fc31de9-goog
Message-ID: <20251103215244.2080638-1-xur@google.com>
Subject: [PATCH v2 1/2] objtool: fix the check for dead_end function with
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


