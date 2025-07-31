Return-Path: <linux-kernel+bounces-752048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAB4B170C9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BFAA3B6297
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661DD2BE65E;
	Thu, 31 Jul 2025 11:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWueW4Gh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48F1230BE0
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753963036; cv=none; b=Fo7IvYizfQqK2YNV9aRMSL3rbD1cwNKEDVe4hVJiiuCB7DP2S+iSimXdeuRhss5+dPUiDvVhOk3qHO7SCTKfs9ruGiRBnMBcLc4ljQdVqMvWYtNIVbMQCvgjwmU4y45SHx6KJV+ZBhkfQQMEWBrxozZNby6tkKH48MQWX+ZE8Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753963036; c=relaxed/simple;
	bh=YnrRDbjFN1VLfeYbbTB4TO2j0wYbOlTQF/2iHKqKw4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t+SzLj8rZDgRO98qawCsgKXBuX0lNjSWm8TdMVfTPKvvUoSY6iU/Vt4l5mfKhUEc4JcUEK/WYXVoe+hxI3SH+xGNteeniLay1xDAXz6+2WGpMcMvJeEHm4dftp3LAuzR9BHFcufsfgCO1aejZ5TEvvixpyIy0ZB7sI/qAX+lzBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWueW4Gh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD7DC4CEEF;
	Thu, 31 Jul 2025 11:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753963036;
	bh=YnrRDbjFN1VLfeYbbTB4TO2j0wYbOlTQF/2iHKqKw4I=;
	h=From:Date:Subject:To:Cc:From;
	b=hWueW4Ghw2YBsaCqW+R6LzjOHoPvSFYikuFbj3TO92V1ItTLdxZK8rh2Z6engKC+m
	 hwxdG6Jy1c7sT435K3ZNSWx3t20grPitaMFh71WrA7L0hFeO2J14XPLSsWN8Cf5KR3
	 eryS1lsBus4PF95TF4muFCXc7qIZdegsJTJZCg6Yhh1NSrVg9hpYqnafGvVEYpgTfv
	 KwdAdkFAq9wbHRxTSw9z20pNVUyzH7tiC1tVj+B5Yn8Et3bcIm8sVHECmal3Fnzm7H
	 jSmiqnE8tcBAZfHaI5tkZVToqepenqH7d18OkSf6JZC5AdgSUuHKuJShDfZOrrhTrG
	 hSpVK/X8aUgVw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 31 Jul 2025 07:57:05 -0400
Subject: [PATCH] ref_tracker: use %p instead of %px in debugfs dentry name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-reftrack-dbgfs-v1-1-143ee1cfda44@kernel.org>
X-B4-Tracking: v=1; b=H4sIABFai2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc2ND3aLUtJKixORs3ZSk9LRi3TRLy8QUSyMDM4ukZCWgpgKgfGYF2MD
 o2NpaAL3IrWVgAAAA
X-Change-ID: 20250731-reftrack-dbgfs-f99ad92068bc
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1327; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=YnrRDbjFN1VLfeYbbTB4TO2j0wYbOlTQF/2iHKqKw4I=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoi1oVYhfyyOI8W5tSnHA7t+p6GaRGgjqhif1S8
 eylQrShV0yJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaItaFQAKCRAADmhBGVaC
 FVf6D/9h5YVMvxbNi/7U1mYRYoL/1sGkqLJ5uwETCY0hgpzwKzxw1VZS57PE1e71NLTphtnT6DR
 CReCbLAzE0KwJUFf2Ppdoc9holThH8CX37x5kYypUbLdqy9hOGk28XUcXq1QVw5KntECBP5KPBQ
 FS/EqVfvj9fpQFB0cByhup+nSTFW8cMh9s0ngvdEjCpMwTJFVSte4lUQOg4KDNgcF+pS8LIzUlh
 yNRGzuWrVlHgD2Z85MeL7q4KUJw4PsMPECjncPs06sNO6w9SgFAX9EEP+8/PfIMezPaq389gO8Z
 t9izalQXmRILbQ5oC09BcwUdk++IopIxbdY2AZ2POPVy91eZU3CsVUKBcrx7pVtHKV/aj8+Y9dR
 UQYIZfnJz45iTj6lOOyJjzn1XEtcQJOGDi167IfgctHigX68Sn5syH7b0BVvQslbHjINZLOItC/
 UC6GLt8jlrJdYAOeb5UK2oSs7n+UPwCnWJMP05WjEOv2lGrl0iarJjR2SRpeHbbzQUCO5yIxSsG
 HUzqlCgFikMhuv49+vj4Vu/jShfCL+YpxG+6SOHU+oPgq3wHFmjmwP077yYUAemJtzNa2uuj4lN
 f+by5OqZaLym7vULT1b12XIuM+gEZ8xfeoqnckuObTwQjP2xJ2iyiSwfr5Bd2W0TIH++2uy1UkU
 GrucnDgLi1VdKrg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

As Kees points out, this is a kernel address leak, and debugging is
not a sufficiently good reason to expose the real kernel address.

Fixes: 65b584f53611 ("ref_tracker: automatically register a file in debugfs for a ref_tracker_dir")
Reported-by: Kees Cook <kees@kernel.org>
Closes: https://lore.kernel.org/netdev/202507301603.62E553F93@keescook/
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
I trust that Kees is right here, so let's go ahead and fix this. I gave
this a quick build and boot this morning and it did the right thing.
---
 lib/ref_tracker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
index a9e6ffcff04b1da162a5a6add6bff075c2c9405e..cce12287708ea43e9eda9fe42f82a80423cea4e3 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -434,7 +434,7 @@ void ref_tracker_dir_debugfs(struct ref_tracker_dir *dir)
 	if (dentry && !xa_is_err(dentry))
 		return;
 
-	ret = snprintf(name, sizeof(name), "%s@%px", dir->class, dir);
+	ret = snprintf(name, sizeof(name), "%s@%p", dir->class, dir);
 	name[sizeof(name) - 1] = '\0';
 
 	if (ret < sizeof(name)) {

---
base-commit: 260f6f4fda93c8485c8037865c941b42b9cba5d2
change-id: 20250731-reftrack-dbgfs-f99ad92068bc

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


