Return-Path: <linux-kernel+bounces-797716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 873E0B4146B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F971A8747B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3B42D6E4B;
	Wed,  3 Sep 2025 05:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XIBXbEhT"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41FD2D640A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 05:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756878078; cv=none; b=YEek4kxZMd9WbZdHNDOz/aUHbK4d+9XdToxPV5o4E+51GbHxn7mVB8WE5moJiZ0EM6nJFyhcigtBLsrZk+h7q3x21sOwX5WJx0KPmBwtPbHO72TDw9L2od+Dstk8dQhM0GPFQedshk97kQV4fzRVEWwVhCH+DXSSYm99a6fFqGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756878078; c=relaxed/simple;
	bh=2ftnh6mUbQV2VwxzdEaFkbisMrXw57eGT0ZxeRE5+04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d1/eS19Xy5zmR3yZUFF8UUxdUB+k3srzxcp/2+18Qpv1T/d9AH8YvCXmt/l5UrAgeKpDEM33zqlSc45/7sRBHWpGAzbZt4xtnIar5nht1rQQV6zbGgE9wN5GTJgkLzYzUitOcRHSlHJctXsy4DJ+S0ioUm0+1kjdNQ6NKPSTcz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XIBXbEhT; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ceb9c3d98cso2728702f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 22:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756878074; x=1757482874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cGGqNv75aDZgJPDC2W0J3s0SshlafB4qIj16FjDedew=;
        b=XIBXbEhTMzSXGT3u7DJMNYnbeluH5VQn2tDjZg7rV5bCrWVpUQ6zm+N8EmuJZ2816b
         TcGXRLZ4gOiVVCpFWcy/4GzTfnVo+8u7oJTOfFRhomd27njNNXipo5kLM1M1zeiba6fV
         qaMaeNYs+zHUWGpSw52uPbQUTFgdLN0FVdEXKoE240wMnxhSOQrlWY33T3zOKzl8ULmO
         Vxfo8wYHlpXIPcwlOJl+/7NnaJm14eG8bJeC8buBjHq64K0H2DtcwpvAlGeZMd5Oi48n
         spEJ+YB2VtKLvmW3skaWS6avS9MlFWLxSXRjk3Qek9OmtzFa9o5DWF4WKwyCRlPdLgj1
         pojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756878074; x=1757482874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGGqNv75aDZgJPDC2W0J3s0SshlafB4qIj16FjDedew=;
        b=efPkJlv4ODo35qtWvA6KmkMb+BqwI0ORLbhGy0DgnFAPUzlisrkdvlDBmA9t+VLTxg
         z2E1jxCGGdClOZ0GK7/yZHzwbcebRzincUiQ99N9YiHwEXGOvY7pjxFgtmj13P8xCxuR
         WnZIl2s/mF7E2SSNv4JawkofDjEzfItZv8YzIy7/4KIJxMscpLHoJBlmhFhG0GVBbkUB
         3rKaiQA1qgwH5wdvsXGFFgIjiqTWwEguws+l6QUugGKNH8Ch247w0OUMQpTwsdPB2E5t
         1+6sBpNFABiAOw0MI2ZlQGkNkRXkDCt9DSEq6iL5AM4jNA+apgXGUkZfsfSS2NmZlwOv
         NGPA==
X-Forwarded-Encrypted: i=1; AJvYcCWL7l0YOq/zHoU0VJge1sFAcIfgSfsXz0WnHpSKzFPPSk63a6KhBkqQ73Xbbg/mzWwbWTr2/USX0pvEstA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLDRXncJijnNi5+5NFjuWA3ZHG2GI/1PCyNCO8LQ7z146KAdsB
	7/aoevhfJC09F3Micknr2rb6ouCeOPUfYW/akBTPh4H3NmhAi86pKiQjT0Fs+MhWQEw=
X-Gm-Gg: ASbGncsbi/7nHxzZs7wwagGXG7RZLysquCClsL8gU4rvVKxrzeeBkeKGXPtp1ioCwXq
	2qA8IMdPKoNviugSef0Vy1n/lL/Q55Kth8lQIqjLsq400HSqCT0hLJJUaqqYsdijzJh40zK+esp
	zSO3z+TcOth9yXJOr7oLkumhlkUIUzSVuZESmFpvIjqvQxziDhN/Huc2VfetcXA1X8qwFQU8rSP
	jt0OL8ns38N7Wm3vucKnHjdOBQFeUIEyO7b6DzjUl4cDjXZWjzbj0dX3a/T8UX3mEG6cEhRV60x
	AWaP6mb4qFSSGB9hrZnpv7bvo91jpCPw/p0VJs1vEAPCJvYOW1uJyWLozHiegckT6bWZjv+4rs7
	x0Q5sIzFX0TYfuABFmGnkIYnsqXOofhk6/Urr6w==
X-Google-Smtp-Source: AGHT+IGASw0swdB3AonHgvetzJbWtfo0v6MiV/UAAFMZVGiv6PWo/IKa0HNPCPsFAeEMxqNI1FNfRQ==
X-Received: by 2002:a05:6000:21c9:b0:3db:dd47:b612 with SMTP id ffacd0b85a97d-3dbdd47b922mr1311527f8f.33.1756878074016;
        Tue, 02 Sep 2025 22:41:14 -0700 (PDT)
Received: from F5.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249065899f3sm146911965ad.113.2025.09.02.22.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 22:41:13 -0700 (PDT)
From: Hoyeon Lee <hoyeon.lee@suse.com>
To: cve@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Hoyeon Lee <hoyeon.lee@suse.com>
Subject: [PATCH vulns] add a .vulnerable id for CVE-2025-38608
Date: Wed,  3 Sep 2025 14:41:07 +0900
Message-ID: <20250903054107.221958-1-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue depends on bpf_msg_pop_data() helper, which was introduced
by commit 7246d8ed4dcc ("bpf: helper to pop data from messages"). Fixes
tag in commit 178f6a5c8cb3 ("bpf, ktls: Fix data corruption when using
bpf_msg_pop_data() in ktls") incorrectly points to commit d3b18ad31f93
("tls: add bpf support to sk_msg handling"), which does not provide this
helper. For this reason, the introduction of bpf_msg_pop_data() has been
chosen as the vulnerable point for CVE-2025-38608.

Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
---
 cve/published/2025/CVE-2025-38608.vulnerable | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 cve/published/2025/CVE-2025-38608.vulnerable

diff --git a/cve/published/2025/CVE-2025-38608.vulnerable b/cve/published/2025/CVE-2025-38608.vulnerable
new file mode 100644
index 000000000..f0336d0ed
--- /dev/null
+++ b/cve/published/2025/CVE-2025-38608.vulnerable
@@ -0,0 +1 @@
+7246d8ed4dcce23f7509949a77be15fa9f0e3d28
-- 
2.51.0


