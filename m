Return-Path: <linux-kernel+bounces-869202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 549E4C07433
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65951C2856C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BD8273D75;
	Fri, 24 Oct 2025 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoAtx5Wq"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8387272E45
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322763; cv=none; b=gorDVMErty2ns9QdQs1rdZRGPs37W8n1PIuEnxMfcahvdlvISkTF1cjimoyM/aTpoSsLoe+4VmVpliY17Jio+bkWT+QjlgU+3TB76FlEf5mZ04fc56U3bBZ1rU2vacE0eorW7JQCk2F66giK9IJ75NYfpw6OK1l+NgBKVBqHvN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322763; c=relaxed/simple;
	bh=9dAY0L+/fvVVmeV7rFvMJHXnGU8TyAN8gQ32/HzNzLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AHnKIoBnF7jDYhnqvdwik1sPdFQihVlsXrW4MwI8y/bQadV7ZiNLAoiTp3s1fXF+Q/4Q+kyI73yKQVdr7Gndk2exZmyaMz46E50NTggdm6dU9E7801YzyV7b1laQLJOU82jBc5rReWIyC2xKeRvPA3Piuq7yOmzd5ZQVKce3rI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoAtx5Wq; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so1562230a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761322761; x=1761927561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n8lMVMj1fovkZ+i7h1zKI+sBPWqmX8HhUJdjB0oD3U4=;
        b=WoAtx5Wqpeci6kw+NwvYkiuKphWXGOyyEOXVAAYGbNQVytzLi5p6Xa1vyp8GeIFdjF
         Cd3sKS/xiZkR8GzPEnD6Q7f0Sx3WbGT1Uo+2UljViPbpgaEjmbGMy5HVufA3Ki9P6xhV
         +I7l1pv9vnUZVwjHzWvpjG/Ckcj04cgzAIbeKmyoeemvL8HDWOK/sC98IpVRXTHj40Jj
         wwh82tLRALu/XUOoefhl5S1w/cx/E59cVBkiVrhixD/Hr5ZkHNRYxf2haLPddwj8Qodl
         suZQCIcSwZVj3EInwXTLBRvSVCPURheTo3ZmRtU9Wyem83VZlFFhzeZxnDH8u3+hFwQQ
         xugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761322761; x=1761927561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n8lMVMj1fovkZ+i7h1zKI+sBPWqmX8HhUJdjB0oD3U4=;
        b=TZ7Hd4t1pWzAVlWBCb9Y8Onovsjs12ryGIqMwZbvhDMnqkRLuUr/7Rp4Kq4Ji/b3Dr
         KKPhlyy6if7DTCubscLaS9t0tcyOGF0yCnMf5CjZLh3hwq9nE2wf4QB7O1HPF7DMqcdj
         nH1dmBZasrXs6b36hH+Z7VY/a0j9eQCk0RHR6H36iYRv39D1GkKoFEuckuO+QIee+vuE
         5OApGtALNNT4BzFDLAZSqhDWhimWrEKHTLOOgsr9LJrEP7mP0/Wyx/ifAUJYGjDn8qrN
         easZmO6sh3Z9rAbgsk6M1kWMBCuV9T+qO/JTnQAwoGMnlK1hgFjff8bt3FsCvhx0lmYi
         xvMw==
X-Forwarded-Encrypted: i=1; AJvYcCWOAgahBJjRJjdyxkvRiHR7C3OUpUxHE/ogTug7bvqm+wzsy09nZoKMmfCMW9MvrPGtpM1PZ5BhXIYxvDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC9twKOtOzIM9EUek0sBQxPjEm4DjCiA34gWdIYyjw6156rVbf
	KZnYb99bewISLTNL9LkqIX2R6u5pSVH3+WNpSuUILiSPz9ni1QOA6/Wh
X-Gm-Gg: ASbGncvtXB+3B/kdkikBHjUMOsPzAKOLxUNiS9Cif4f9d1F9nOwy+6whf5lYz8lTmUL
	u4sL975DBxQP2S4Iz9GLdg/cbDrvzWkkz4OWZKtVZI5kQ+1LwNzUcVdD58C6aAqB0zhSF+9q8YS
	1fOWq6xQQCPnJRrg6B0oi5bSMj7cJQjBO2WBdam5nyzjPRHzvp9JtCLSOPo0xkv/BQPIVMYE8X0
	uYnS5dKV3uPt1EspuW7MMWktwECg9BvDPqp5tPQliPUhvDhEirTPFMrleZcNYjLIg7jrFE0Ga7a
	dHeB9cnp3rB0D53sOqhIuLu9WNnFapNeEL7ow9c5MYnAVsJW+rPNKRqjD251U83MF00gUppaLy3
	92kN9VvdzYhy37S82Bir0ofeH/EaBnNzAbZ/RtkAbgQFzsymC5LgemFqFfXnVrGZUdEZjPwJbhM
	9vLIHAllkHEI9qazKEuP4=
X-Google-Smtp-Source: AGHT+IFNPsmsAl8NXf9o2YdrRIqhrCZlIqmrcjiRIz6/XHVLK6f87asKaFnRaec7IkTrDjOv4+L8dw==
X-Received: by 2002:a17:903:1a70:b0:272:dee1:c137 with SMTP id d9443c01a7336-2946de62ec8mr81593755ad.13.1761322761029;
        Fri, 24 Oct 2025 09:19:21 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274abf6d5sm6277685b3a.33.2025.10.24.09.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 09:19:20 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: shuah@kernel.org
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	khalid@kernel.org
Subject: [PATCH] selftests: tty: add tty_tiocsti_test to .gitignore
Date: Fri, 24 Oct 2025 21:49:07 +0530
Message-ID: <20251024161909.327158-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the tty_tiocsti_test binary to .gitignore to avoid accidentally
staging the build artifact.

Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 tools/testing/selftests/tty/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/tty/.gitignore b/tools/testing/selftests/tty/.gitignore
index fe70462a4aad..2453685d2493 100644
--- a/tools/testing/selftests/tty/.gitignore
+++ b/tools/testing/selftests/tty/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
+tty_tiocsti_test
 tty_tstamp_update
-- 
2.43.0


