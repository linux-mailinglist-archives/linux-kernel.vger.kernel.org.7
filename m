Return-Path: <linux-kernel+bounces-741560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF08B0E5C4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82ECD1C86101
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0AC284B5D;
	Tue, 22 Jul 2025 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsTvRtsm"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3250A1B808;
	Tue, 22 Jul 2025 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221386; cv=none; b=BlC7eR3ygHyE4zwhPUlOKgM0MMNU4CaTC5goJ3mZE1LjhUnMR+nJTN4alal4oYabEBWwFzA2EEJwCsPMTAVa333s0XJxsboMNiMf1nFujz8WbCtfn0rpv+RxJW/WGSjYInTOmcC1gO4+40xAUPq4V8nVMaZYMoAQHktWpsmgJ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221386; c=relaxed/simple;
	bh=TiCgWHNJLNjsufpxxCLX2Z0L7DyrlPmjNAxGcgG+w3o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oD5IIIvkAKcM4jBdJmPYmLhfEfNGZ8B3TvV/H8m0FdandD82GuE4i9t60hT8nCvY4PN4jkxT97/evEo7k/pYHtjdzAEN374jrlYJ7Bbv9QlypbfAOLGgiqBGP8/BhxMOti7D1Wlf6hTWi1sC2VTACR4dsVSLOBizFRP4NMNvvg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsTvRtsm; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ab6e66ea68so79427101cf.1;
        Tue, 22 Jul 2025 14:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753221384; x=1753826184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TiCgWHNJLNjsufpxxCLX2Z0L7DyrlPmjNAxGcgG+w3o=;
        b=BsTvRtsm1sSaOboV+2/xZNXlAid6msdE1TTZSj4s6yg7ALBc++4XqTCP7tSGSIoRwD
         GkJSjA3cIyR/eRf2N73w3edkhqvlVSft10Hy4+RvkefsxL1rR8v36vJQwEDTcJLzSQRP
         pRaUjwJg+dA4RCHIWAZ1PPEaIMuvYgndcspglOh/0knr492riZEbJjh6KXjsJPpFu1Hf
         72S3oJGjfNQES6wcJpKFlVBhzLjXpJbjn8N6b1P2LIyIL5sM8N99iqI4wtJdYw18utiP
         93ByrWCfM0VT88UaRMpNFMHcB6q1qgod+/2zPiSqdtrh7wT838GuS4eXnCyBNq694EzN
         Y0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753221384; x=1753826184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TiCgWHNJLNjsufpxxCLX2Z0L7DyrlPmjNAxGcgG+w3o=;
        b=qZJSdhpohEy2dNQbl+r3fSmYIvBoktfUo8gT+wjXJvWTf96/jye4EA1DUT3GyCclkb
         9h+shPzFdYgLKy1ywutIUmdoJ6dc1NKfeWb+kDtDw997jlVGnTP7YFzK+8Vcdk3IwfiU
         vLPhZgDLK8FV8IL3cD2FH2QhTD0OV+yQ/a7EIfNTJ8A+SIgZpEO+ZoBmem0RghjiIXHN
         daRVy1faenZw8uW2RrIeBaiZDZum/GfMsL645h5tK67Viw1XR19+60SV9uR+RIijym1j
         64jBJg28MGUbKjOosoDuwv7cx6qCBxXMNStwkqqa18u5pAFlIjTfRXygGIyoL0D6YtPq
         SBEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVFZe7AwJz+NaDguIX33P1l58UROjWXw3xnI9ov5TSQW1LDfu5iZwMQBixK3O7chfDzImX92JjjHY=@vger.kernel.org, AJvYcCWLxDuMkZ+3ip4cq5ZSPXxKlEkaihMq2+5sxJTzsbb1cUmlC/9ItIaPT4O+q4TghCO88kr3s1u8bo9wMP1m@vger.kernel.org
X-Gm-Message-State: AOJu0YwyZ/FI0EH7TX2tadz4HZNWClnE+8kw6WM0zQP48hCwlyhHDG0M
	K9cP8kWb7jk1vd+WzCdYSjQFi+PF4ils7Ia0g4EoBLJOq1VK52U4QUumWYmtjfRlT9E=
X-Gm-Gg: ASbGncvDmSaVIEu5KepQySYLZqSYw64fFaAlfDxRXlgcutDirRhYGoMXbpil64idACv
	PnfX7IQCjec0w5/6OThlJgcIvYfrGiq+7MG5ceDyaklBci+3sVx/ZmcHOpChW8/HoGHZbx6S/uD
	B2LG7fin9JvKMJl1jOcv2E8hl6BO7aL99FXuc2+VzAN8Inx4KrxLBAmfMpneNkYv3AcEWTwy+4W
	eABqaERbI5OUS/g6b7R/aQYkr0ofKgOP6GWggLLYW2DAcrMuhocWwo7TA0O16UhG18MQhDQfZ93
	AH1x0JzhA0uQDu+XEQbuMUnit0IGkBMuWuf/vUlING9G00RT2OnaK9JLN2S2eBp9BadzK4dJ824
	LNlM+r6OX9RFt5gGwCJYwgBm/jFqQ8ec=
X-Google-Smtp-Source: AGHT+IEJL/dEHql9VHWkImNBCL67ezfpLV7zwPClWLTa5dho+5ZrHcI1Y8nk8wNg5fLmZ7oJN8C5Ig==
X-Received: by 2002:a05:622a:144d:b0:4aa:f43b:ba82 with SMTP id d75a77b69052e-4ae6de2b58emr12467991cf.4.1753221383918;
        Tue, 22 Jul 2025 14:56:23 -0700 (PDT)
Received: from Gentoo.localdomain ([37.19.198.68])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4af4585sm59414671cf.42.2025.07.22.14.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 14:56:23 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: corbet@lwn.net,
	unixbhaskar@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Doc:features:scripts: This file was missing shebang line, so added it
Date: Wed, 23 Jul 2025 03:22:32 +0530
Message-ID: <20250722215336.17327-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This file was missing the shebang line, so added it.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/features/scripts/features-refresh.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/features/scripts/features-refresh.sh b/Documentation/features/scripts/features-refresh.sh
index c2288124e94a..a908704fd149 100755
--- a/Documentation/features/scripts/features-refresh.sh
+++ b/Documentation/features/scripts/features-refresh.sh
@@ -1,4 +1,4 @@
-#
+#!/bin/sh
 # Small script that refreshes the kernel feature support status in place.
 #

--
2.49.1


