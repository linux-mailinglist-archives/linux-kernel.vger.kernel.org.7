Return-Path: <linux-kernel+bounces-776607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C334FB2CF88
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A0CC16F757
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7599F23AE95;
	Tue, 19 Aug 2025 22:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAMwpERd"
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F509202980;
	Tue, 19 Aug 2025 22:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755643879; cv=none; b=I6XlAe6jqj9vjIYPD48VYp9Nzkz/ab8aU/lQzLlYDuXlXNs4eRr/sg3S7yMtt1AKBNakkAMn+v61f8tKDo2eZaMllem7q5Ho0cE+ZEhmUg+pGoJfCdK4rGlZEUm+jvSD/hvfpxSSq1XNUt+jiBrzke+FMQjfU/HTXIQfeTM0d5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755643879; c=relaxed/simple;
	bh=oJ22349EL2XHEtGg6jM/vc8AGMGDUVBvJzvBkmp8xTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BiAFxQB7a9R2xGN01g6ZRjp2evXGUfeljmFniA09Lqtsw6tZoa/GiAj37K5Nc995FubZKb2CaeEkYEbTVTAZ4b9YZisF7ku/FmuSXDzHn37Wt9H6dvyHPsgYbJlm/PYnDmBlWkaUPDTXlvEwZuQanPVIDs97WQN6VWETiOU4rnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAMwpERd; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-321cfa7ad29so305545a91.1;
        Tue, 19 Aug 2025 15:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755643877; x=1756248677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nfoBdX0Tov8AX3bmnwCFuwfCT/w+2/RjttzP8RxelqA=;
        b=YAMwpERd/KvCaTHt454BxbMlFHZ45wJEjsNJLTgDRgkIk66Cbk9tK8LkQfBFiSPRCX
         AaeXw6cHxqXV90olAEL7JTtn344MtCnlWyb9bvI2wwq4rF7P+xUt1QIDqQrLKxRpsuNL
         jQud14DwFv5xkaK/KwCW6XkLfEtnxIuF25YhLF9Jal6jLCOBG//3nrgl2Ns/90Rkkjyh
         2InOSR8EwR44OfLgmG6dGZSGxd65k5gDAPDHXncyAel8T3gwuEzs7c/04NZZaZrw5PLs
         LdbEzyriu9Og3b1qW7yvs1QEd1z6ta5Luk9VC7r5O8W0P3YxySFL08JC1BH5LlP2+pRe
         tNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755643877; x=1756248677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nfoBdX0Tov8AX3bmnwCFuwfCT/w+2/RjttzP8RxelqA=;
        b=AJr3wzheWYQIm645gSJx8J4IEPEtKIPb4ytczmiQoQipjbNiJGfaX5ptpyWFIyp6IB
         /zENH19noz3YOdyUUJLPpvRn5pi8UZI1It3Va3xyFGRiuvnxLfbZl/IyHY+JMX8Z8six
         3BXL+lSOfTJ8ZlbMuQZe4/GkBMPpzdexe/HqvQgfaCrKugsP5ebwLMEseyihYK3RShqj
         QD8xt0UMSuEDQlmMN07twyImQb2N8rZ4rYQpOtB9aZA9J8ue2o+Km4UMKhlnOgdUNR5I
         GlhIpyeOz479TgDv89H+ANh7OWuMygjAGClyiCCioJ9FqEkiuAeEH8mja9BFg4Vszy7+
         gorQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmhuE6pcHv/VYsD24sQ4akjNFG5b9dr5hMqsmqNei/NEMHGwV+74Ne0OpvosaUGRIhUQEiSPehd7w=@vger.kernel.org, AJvYcCXqxBPlHQVZ+TW0zP7U8M6B0Sb72ge0qij17lGZpAIJqHK/PWExeBQZ+bdjIGsfCri4BpX8gbnC34mtIR5v@vger.kernel.org
X-Gm-Message-State: AOJu0Yznc5p/WDVvZVOhvlMbiOTHn2FZlysKBN2O6YkF/qJ4FrkcjEvt
	clTvYMgPPzuPiU5YQI/iK25c/9irvGVAXb7P7w3LW9Bd16LqUP+DC/Ek
X-Gm-Gg: ASbGncvFgyydQ/SZAWzFgOj0Cb0c+i6JkOA4WM45xB7cZW3O6uR8TFuVwITUWQxnUr1
	V7hRSlF4r52u7Gb1atlQFghJgQwJ8fPhksU9Y2mIAU47E33YrWBYjIQQ+oysREyVmfC1JjrwZm/
	BkybenXivT17SPJ5R7QiCosOUP7whh3Y0dTb5ZGaJY5hUdkYuwwWx1rZGN3zoPJi+AZP4F3ddn8
	/WZ/TqbjSkLMB9n83MjGYpaNHtH9hvEFZXmqZ5gOKsIJxRx+nUoRHpJZD5EL/BevsQpS2mWKz8J
	V3D6nR60X5T+f8UypHXZF1IPnrfn9iKxqXRE6Y1KsOau9ZSr9tk9Y6M4Y5YQx2aWVKC7MQxSut7
	F1rTJBjEHCXtVPxFFTAm75Ocl7cBO8MP8SPfD3jRllAI9OHTMY8kTKrj13S6R9g==
X-Google-Smtp-Source: AGHT+IE80zrRdknPxonsTThO68UT2PygfiTcozDdJMAjg7zruSz2CuFtBrDLLBAerfeggg9rrKKCGg==
X-Received: by 2002:a17:90b:2d0e:b0:2fa:42f3:e3e4 with SMTP id 98e67ed59e1d1-324d33f9646mr4872042a91.3.1755643876589;
        Tue, 19 Aug 2025 15:51:16 -0700 (PDT)
Received: from primalkenja-desktop.. (c-98-207-35-177.hsd1.ca.comcast.net. [98.207.35.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b476408e4casm651400a12.31.2025.08.19.15.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 15:51:16 -0700 (PDT)
From: Vivek Alurkar <primalkenja@gmail.com>
To: corbet@lwn.net
Cc: Vivek Alurkar <primalkenja@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] Fix typo in RAID arrays documentation
Date: Tue, 19 Aug 2025 15:50:29 -0700
Message-ID: <20250819225034.8739-2-primalkenja@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changed "write-throuth" to "write-through".

Signed-off-by: Vivek Alurkar <primalkenja@gmail.com>
---
 Documentation/admin-guide/md.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/md.rst b/Documentation/admin-guide/md.rst
index 4ff2cc291d18..8b9866cacb87 100644
--- a/Documentation/admin-guide/md.rst
+++ b/Documentation/admin-guide/md.rst
@@ -758,7 +758,7 @@ These currently include:
 
   journal_mode (currently raid5 only)
       The cache mode for raid5. raid5 could include an extra disk for
-      caching. The mode can be "write-throuth" and "write-back". The
+      caching. The mode can be "write-through" and "write-back". The
       default is "write-through".
 
   ppl_write_hint
-- 
2.48.1


