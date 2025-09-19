Return-Path: <linux-kernel+bounces-824499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41761B89679
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED504164FF9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9A624DCE6;
	Fri, 19 Sep 2025 12:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XJwyIpea"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04B730F948
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284257; cv=none; b=J+77GZwH3MMkd0tVJjw8b9hWQSen68Cb3crfo2o9+TppKSEywAz2Zrc/ewxxP9SVTUFbZKWMSkQoczlrFw9iogc0TZC5OaA6faM4+iRHt82O/iAERJklYsoquQK4vfBy3pS8JD5CaJOZW4EWm6KAevWRDv7YhSagaWTb2TRCnMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284257; c=relaxed/simple;
	bh=R262FhlfMsFW0q5HHRD+q/V6p5+fuuWiE3osv+OGGWo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lvv5e+Pe5bA7SQu0/kLMKMXwFLKJZNXrysSkZf7H8C0yC67k3fb4jkp+NjxdcQ8DOgUDh7R52Re83/XeyJkQi85RCEMvR7gSxvK0kK8v1qIDfdBTIyULfGaqQizS/LIE28YYP0nUC9qxt8UtbK8wS6FhhOeLYY3kIJTf/5M7YW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XJwyIpea; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45f2c9799a3so15501155e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 05:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758284254; x=1758889054; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sTcOVCXQ8KqzC5yCQ0h/griplU6alFzdRxVKdGTYkrU=;
        b=XJwyIpeaXmBjkRJfUFL3RX3QO4FPwhRZqd4KE6eN2nPu3cjHy9aI8LiU335/+g0DUs
         s6iz6SHQLshUeT7LOdmIHEhBvWcahbgvsdDWo3OMba8ktDV8fDLL5PvAXUlVWLiuWP+b
         fJcyeOf69++oOFDIG8tp/Cir0I2/CRvCb4dFOWFYgZCFY0ziuPG+ji63ATCNcf71RD3X
         PL89amlX7/VVBit7mHmd/QRYohjlQtGRvad9+0UWd4VCeqc2Wjtn8S5ObbLQow1KWrEc
         GRuMxyULXmZzeG6RvnvfV3MTXxf2CtqRaqXWzOAoOjMmcK0MVhHsAfM++FR2tXFM8tNL
         Igmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758284254; x=1758889054;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sTcOVCXQ8KqzC5yCQ0h/griplU6alFzdRxVKdGTYkrU=;
        b=Rn30Q3TtK8EHeco22NDj0O7Wrr8U/1nU1Xj7/CC6sOniqBJuCK2YOl0B/pYrBvh4mQ
         Silnqzu3wXYsE73mG82K1+cGVh/cpdnjUwkiFR9xbF32ctc+0U6nhjqHS7jbg7Eywmbv
         ZMu9JgvHRSnRR1u6PxZL3iONcfoAebfcTmJEDtNrYT2briVeEUSONbIPS+hQyXngxwTM
         +rf3a+Z2xYKh+7YPnzd68B/Glh7baXRUqh5q6rH68TtVfE/nMpT/BmUaWetcSTTkoE8X
         zzP6X1Udg0JVlDB2PgYkNEm0ft6IgCIFzKcalzVhETVm2Dg7J+/zRpF7pHEl1REosLYe
         YlhA==
X-Forwarded-Encrypted: i=1; AJvYcCVb7F4eWwj7yd1CqpzL3923t/HDTCMHjpYEJxkzRY6OkraJ4bVjsEVmflJW8s5V7jHD6l1UnN3NprrqNRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwphlhA3TGBgZ2PTNKGx1liTRxM/drqfgVNiLJvGRiH3EIqC6l9
	Ba7eIBrPNddBrggVacYYGGzu34kQ8Qri9kkX0RB1wctiZibB6jIm91iYORYsgqW4rmycwtvoQ8N
	obAEr
X-Gm-Gg: ASbGncuJCvQjCmAiTbKszwcdUhvM/794KLo2pRLD4eFI7wkynnNvfsQRpztNQYPrNLI
	b3UCiPe51HkA912+Ghrmf0vVbdc2OAPVxRE27uhM307abaVI0WmmAMX9wjr+eFdYemBf8CEzCC5
	w4uQ1umYbCV32utmyuw9nTTeo5z2TlHVBM3/O096yJ8RMqhy6qQw4bIn13JSZKS0zMaRJmx+Rhc
	oLA0tmm3OQPuwsdNP4XkM2BqGg8v/ZrEi3RX4iTG88/O4XvWND1iKN3Qq/kNf4hmztTxOoUt5AC
	Xv+7PujwWZOBW9eljSot0e0prtPyI5945BBNafjdqzWnYXKktSZNxUT+FhtlqsOsxaMqfa2uGE9
	5FDdLqoWLsNAEAnpXoLRqO8A=
X-Google-Smtp-Source: AGHT+IHdAAsZy+REyU3RhOvOyagGKottFzSw++8bG0EdOWNNXW7I3fY5OjUbfyjqPu4Dwme892bvOQ==
X-Received: by 2002:a05:600c:4748:b0:45b:4a98:91cf with SMTP id 5b1f17b1804b1-467e7f7d874mr26313575e9.15.1758284254001;
        Fri, 19 Sep 2025 05:17:34 -0700 (PDT)
Received: from hackbox.lan ([86.121.170.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbf20b9sm7655176f8f.57.2025.09.19.05.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 05:17:33 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH 0/2] pinctrl: qcom: glymur: Fix gpio pin functions and
 clean-up match table
Date: Fri, 19 Sep 2025 15:17:10 +0300
Message-Id: <20250919-pinctrl-qcom-glymur-fixes-v1-0-426ea410aa94@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMZJzWgC/x2L2wpAQBBAf0XzbGqX5PIr8qA1mGIxi0j+3eTxd
 M55IJAwBaiiB4RODrx4BRtH4MbWD4TcKUNiksyUtsSVvdtlws0tMw7TPR+CPV8UMKc2Na7Qsre
 g/yr0C93r5n0/eJzJsGsAAAA=
X-Change-ID: 20250919-pinctrl-qcom-glymur-fixes-7ea30c8202f1
To: Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=971; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=R262FhlfMsFW0q5HHRD+q/V6p5+fuuWiE3osv+OGGWo=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBozUnSGht49TvMo96sfKQQExA8xvC8FWGMyjUxO
 Qt3oupUJ/uJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaM1J0gAKCRAbX0TJAJUV
 VoH2D/4pKFeHCkR5O2ABF1HFvHMH6tHzLI+PYBbClqGsbl2Dobm2U+g95o94iUx4aLQwW0SbVk4
 ptmJz38hZsciS8Phtv71KNylihXlwoST51RrysjFsERDIFDtcEBd/CxhWEeKguYenWuCj9HRxta
 1h3Gsx5Qc4YD5mGzvKeuRZjsYNawtS19WO7ae7a/tHkuTisZ4yglcIcORuNP0myYRCkuH4P8bq+
 8T+rah+aXDs9WXbm+IX3RcM4LGrBcbVoNamT7lviQVwDKC3Iw30Fiinx30mU9Dyic/L5kJJLHn+
 d5/E7Fof+j43HthkUJrMAo6nSIpOlXMCeIxB3RIqwMIDZvnJFHSgnXddUUyhgxS1WE3qRnl/yfs
 TJRl50nQCsqvK3oOsiO6pSxEcgfnEycGxAl33VMLN1Mr1906yOle/TdjSrjDt/R5Frsi07uSUhW
 PSEDw76y3W50NhZeb9cZdn3ibww4p1StWLX1rH4kQn/WdyLy6iNHk9YPblzB+At74hh/GyICfr3
 QYYt/E0D6lVwsnkcQwZhQOY2N2xbC6JqYR+Rbz+HX/Fii22iuTjmOZQzqj+fq2VAt/QiCPtZiZl
 3QvHtvnmCrJLXq7Vb8oP/SgXBUsZ3CkO3tmcHln3km2NTjmqvBWky+XbiX1vqNdybdrbDbo4LtS
 0BFRMaGmevCAPKQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

This glymur pinctrl driver is not currently being used by any platforms
upstream, but once the entire platform support will be merged, there
will be some issues with the gpios as they will be wrongly requested by
the pin muxing config in DT, if the gpio pin function is not marked via
the generic macro as GPIO category function. Fix this issue now by
marking the gpio function properly.

While at it, drop the useless compatible specific match data from the
table.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Abel Vesa (2):
      pinctrl: qcom: glymur: Drop unnecessary platform data from match table
      pinctrl: qcom: glymur: Fix the gpio and egpio pin functions

 drivers/pinctrl/qcom/pinctrl-glymur.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 8f7f8b1b3f4c613dd886f53f768f82816b41eaa3
change-id: 20250919-pinctrl-qcom-glymur-fixes-7ea30c8202f1

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


