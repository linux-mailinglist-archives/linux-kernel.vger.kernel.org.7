Return-Path: <linux-kernel+bounces-899173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4618CC56FB2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5B304E62EE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AD133375F;
	Thu, 13 Nov 2025 10:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLM29ZFc"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9E933554C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030753; cv=none; b=h1tP5C1eFYihJSXg6gvXiQTjNe0TPvlDnJd2xn3evBeSutQcmV87CB/YwP+QPUaDlnifEb6sHdL4M/kVve3Bf6LSKneAYw596ISKS+wYO+Hpx/5E2dN10BiyYpz2h6MCDes8fCfO8/GFBHZPHkKyLzp0kQVQJxEjEDNvyz7/gwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030753; c=relaxed/simple;
	bh=DgA+YQZ2PXtKWbfJH1XR71F2ykLEULNrwbgH40vjVnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vA2bvW/ZaSphCOpvm9TEzMUkSTYPyCq7HMjF7pNnzIGuKUXOpWE4WhQV5VfzfSQm7KEfOYu7n87LPsK6BcVfXls3bK+Txcdon0f5XZr6IJIH7Y3sLxDKlbOV1ZoV9zp4DfjKA4Jm2EG2Y7i8OmsAhaszb3Cy2p4sNaWE+MlLP/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLM29ZFc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477632d45c9so4773815e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763030749; x=1763635549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Q6cLMd5HkJMSjJpe28rjQcWfQMB7GUBaFpYg6qXkBE=;
        b=TLM29ZFcbsLaGR5sVBredL1uuCHCD8WnIduxBAB3iL0UUXbbNTCh7xizzYqIx5h+S9
         QcG1WylVM+9qB8fH/QMb0ZWrpHSvV1NL28/WHpr53XMrgCdfvoOqXPwZ/8A4zuB60Tvc
         Rgpq4eRs/2h18AXRHyRBvS9KTnZd07wq5IOe/UGu6n19tahM/kyxw60yDCqiw3joefFX
         mfJd/zZEvQBTkTuCQd5xhllseFqsDZO+oMj0FB4AI0KYKZrjKfsj2a9uMO2m1ZPmhjna
         KA8593FzAHl37aq3BKfekSi5sJN0woxwdRFKPCDz2aYPM6EPnD8zfealvICKkkyI6gOi
         VVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030749; x=1763635549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Q6cLMd5HkJMSjJpe28rjQcWfQMB7GUBaFpYg6qXkBE=;
        b=JXHv+x5vi9hogyAqt5Cz1GR0x7ReZPetYkmYmW7aHVwFguVyQqiTBzVVWjl8n2zKjP
         Aohazu3FGQwqDrB/nqyDpWXfe/7Qq5DMr7rbAdBtzT8ByLUaJH6zeUAEs1tbXlMSeQGU
         x9Qcl16DcgcIAhn4wF9+vov4y7ImUV4+oGmR4PJXCGY+GIldVVvqV5wHzeRojUjRVo2Z
         eSMmNJ3vFUdy1uqz860MGhEL5DX7+0sB66a8VaUuQDPhG11Z4IZyGw0euA1fVE91r4hQ
         KCCxO7js0f9xnovvo43FXsmeqfXbR6fKw+7Rjl5hxvm/QhTBBXi7nCdoeqaLsKszVBz9
         YjMA==
X-Forwarded-Encrypted: i=1; AJvYcCXXkkZ4lWlc11sFxvg344+MuIyDZqOB7XsR/lwx4CIzbLvAffD+Ht7THXh73Rp6g7tlDlxjY8m9Cw7U15M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS0nrVfjksENlZ9b0PjutM9vrvEhwasdQxOQAi1ScPLjFjJCcD
	mdE4H+nGLRBbeKtnir7pzO3TC4qnWxAPFPROc4Jv+6KGInxjxx7tWyQP
X-Gm-Gg: ASbGnct4xzb9Q79evdn6D+KU5KcoDhKGCfhd9Zsrkky0eaQ2wwSkw8UTLduEfuWD+PB
	P7WGvqgBQ7mYfNuNrR36nnC+tkcsJ+Bu2BMHlH1hhB+kK7ltmkIH+jOFKS2gBm49xHJbvW4CtLj
	ptONLU9tm6G9WASuzEijVpsD5S9nZOyBW+HGbyoBWSQ32C7xgjSoH7GOleoPag7YePn9cH2QYE+
	6ju42YhGuiMOtAD3hfASCpOJGp7zT0WFcd8rl7VpBsF8jbu2R+DhctVUunTA4J9XycckIAm4uY9
	a/AubsJ+KUpdUYBDJfq0jrKdedZYp71ut7KhQ7OlhuJY/Nhb6JK0vOBio+rDPXZCbSv0h1UaioP
	N4QChvvEqWGO2tOdbFXGDhlxJ5jFqv2sfoYNPePVwwZIqm8hfSbpuEdpyersVNTOiuV5en1+tEN
	G/lzHxrfzUfNqcS4c4
X-Google-Smtp-Source: AGHT+IHyTFt35dOUEl4C7+ARegy2Feho33shK60lCQ7QsAOD0eQRQVF8cgi3sjrl8oM5XURyD5xYPw==
X-Received: by 2002:a05:600c:3511:b0:477:54cd:2021 with SMTP id 5b1f17b1804b1-47787041346mr61868365e9.8.1763030748717;
        Thu, 13 Nov 2025 02:45:48 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778f247821sm1444975e9.5.2025.11.13.02.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:45:48 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: johan@kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH V3 2/6] staging: gpib: Remove gpib/uapi from search path
Date: Thu, 13 Nov 2025 11:45:39 +0100
Message-ID: <20251113104543.5875-3-dpenkler@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251113104543.5875-1-dpenkler@gmail.com>
References: <20251113104543.5875-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The gpib/uapi header files are being moved to include/uapi/linux
as part of the gpib destaging process. The latter directory is
automatically searched when building the drivers.

Remove gpib/uapi from the header file search path in subdir-ccflags

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/Makefile b/drivers/staging/gpib/Makefile
index d0e88f5c0844..2d44fed2a743 100644
--- a/drivers/staging/gpib/Makefile
+++ b/drivers/staging/gpib/Makefile
@@ -1,5 +1,5 @@
 
-subdir-ccflags-y += -I$(src)/include -I$(src)/uapi
+subdir-ccflags-y += -I$(src)/include
 
 obj-$(CONFIG_GPIB_AGILENT_82350B) += agilent_82350b/
 obj-$(CONFIG_GPIB_AGILENT_82357A) += agilent_82357a/
-- 
2.51.2


