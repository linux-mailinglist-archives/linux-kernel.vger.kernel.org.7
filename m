Return-Path: <linux-kernel+bounces-823570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0647B86DCF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98A91CC497D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F7731D754;
	Thu, 18 Sep 2025 20:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLsGYu0D"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FD931D72D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226328; cv=none; b=NtdB6QjM5qd5QSRVWw4iYHkr2gRG6UOEFbO5b3lI5LYMB/gcuCSgtFZkzFBhxmjMmhEItxaF9r9LnJJrG2ait/pf89VFhrno+tfYbgrIqpHWVJ6DBhOYY0jq6PfJKCSiNdlK1005rDIBNGUsYh7R1weUSzug8J1LY4jdBKPUbw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226328; c=relaxed/simple;
	bh=ny1wrXLDh3RsyooyRx8m8um2skd/fs2vW4vIYfk/ANU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYA8RUYCwvHjxYnRlcvHmY3b35s/bSBtgpx4zUfzKyUkr11gHijyQYpDU8djfGB9/SMeIaJEAQnsbWa99xo+gwuidxXG76jEGrzL97nCZehAKBOOJ+8ZSSDZoCymWss5PniDh/Ac2K4M3gIr1IVK9KLvvqDwvLapnNFVE7TE7Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLsGYu0D; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8173e8effa1so97237385a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758226326; x=1758831126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpKJ4FYn851/u3+mSRW1KYRDrW2vMaNsMXQSquJ7H/s=;
        b=XLsGYu0DdShuSsoaSUFUO0WHrhEeMSiFGSrJfsdtDlY6e/NZcWcQWzeykzfG0LR7nU
         USt/7f+gFcm0PvuwOPwWgmhr1w33+ge11hVGWYM9a/qSLucA6yslo+FrUXyvi06A3aOl
         k3gDZ9IIx57rPtdrL9Y8zyvBMmWdSmm2BzmNlpAt32T7FkOFpo79viDJqj6ls7FMDLtb
         IAU1w4yQQIeKmzW3bOeSimp2jrmpiXeLC+fLstz6mhhYj2se42ZW5mnC7kjC1d9hqyNE
         QBRwyQZeGAFf4x2vwsl38pueWvh0FSb1E8uVYhRJpfKN2GYNS4fYTnozWFRikHJWNXEZ
         Kc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758226326; x=1758831126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpKJ4FYn851/u3+mSRW1KYRDrW2vMaNsMXQSquJ7H/s=;
        b=SbhKbmBUK/6WEHoP4fqKfNuANmN2sqcIopuEWi267NMMVEcHWQmsnR3F84vh10ZXEB
         NPz+H3TVkZtqZ2gkW2gWAmEnmpqRcv2hvmMxsKPmqCp/W7gLviBtujqkbS3qc6i6C4Md
         gHt+4fK6Xf11UU2znCb7I/vL/zVfnxtHE4uPHCzeogxaDVfUGlFSTdlDNLndh7ku+knt
         Wj9HLZPONPs6gdZvwNW764+rjBF4sdq/DB+NKCue7v3lBKwa4biDQE9Eh07CFG4Hck7i
         lO52U2vKi2KyxaqgY+81qO04SLg4GiQNe1vOtFYYBRtu5FjXEfGLZlRyxi2Gn9W6xNmV
         mGgw==
X-Forwarded-Encrypted: i=1; AJvYcCWxGvauk9RECUOAj2oCC0lONoUFm+jBGLMdeKlkwhb2q65bi0nndSgDGNdGuOzc57mBDEyC4jVkZgdaWFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgpcK9Nuv+iOwK6CoE0cFldHgylIQshqPkkDUKscE84iqjCHCM
	bk9QOkpGqHs62tOqMJp6qNfFWZlieM+pvXx7i14SUfsuvdRCa0sRu9Uk
X-Gm-Gg: ASbGncseM8mGlRdOr5gwzHRwF4ttUlm4AobKh9ygysA7SaFZKXXgPA+PgObjIxJ9/u4
	b0MlsWbt9ekzAog431xNay7+/mxGhzGtSGR1lRiHPIcT6kVAJ4VaHOogE21M/dxUjGSnOqXwbea
	zZ+Z9R7jOK//ojrE3GQza1sFVN9muPovtNf1vS7dvOSySAeQ83aLR6F+QQQTCtYKbIRPgFPo9cN
	EXnVvqv/sBphN/zUEwZ3oRMr1GOawMhGRaUSd4cfiyvzZmnlXOhViUGMX4zc6Dybdj6YmI6xEqh
	ZIWVP3kbvJxDNgP6aSx7Sf7CllvLdvAHjxX7s7SjkVYwl0QjIOj4Y5rS6g9xlbpLm8skGwFrQXi
	dUw3tcUdpSAedGFo9oetxZDeFHi2atEe6XZzz4WAszOPchJUDoK42UX0=
X-Google-Smtp-Source: AGHT+IHO+x7rpttILqBrr+bkLB4ACuWoLHRLLqhfpvVqyGjEJFvteQaJ5DbjiRTmgT2eKE95zYRvdQ==
X-Received: by 2002:a05:620a:12da:b0:82b:15c1:5a3d with SMTP id af79cd13be357-83ba2e7eb61mr109879285a.1.1758226326112;
        Thu, 18 Sep 2025 13:12:06 -0700 (PDT)
Received: from jl.umd.edu ([129.2.89.30])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83630299579sm222392985a.41.2025.09.18.13.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 13:12:05 -0700 (PDT)
From: julian-lagattuta <julian.lagattuta@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	julian-lagattuta <julian.lagattuta@gmail.com>
Subject: [PATCH 6/6] module: comment describing new codepath
Date: Thu, 18 Sep 2025 16:11:16 -0400
Message-ID: <20250918201109.24620-14-julian.lagattuta@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250918201109.24620-2-julian.lagattuta@gmail.com>
References: <20250918201109.24620-2-julian.lagattuta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

added comment so future authors know about this codepath

Signed-off-by: julian-lagattuta <julian.lagattuta@gmail.com>
---
 kernel/module/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 256e30259bcf..f4ce431163fa 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3220,6 +3220,11 @@ static int module_patient_check_exists(const char *name,
         */
        if (old && old->state == MODULE_STATE_LIVE)
                return -EEXIST;
+
+       /* 
+        * Can occur if the module was forcefully unloaded after
+        * its initcall crashed.
+       */
        return -EBUSY;
 }
 
-- 
2.45.2

