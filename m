Return-Path: <linux-kernel+bounces-799603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8679B42E1A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11FF71C22AFF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AC7207DF7;
	Thu,  4 Sep 2025 00:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRAus1nI"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA9A1A256E;
	Thu,  4 Sep 2025 00:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945358; cv=none; b=u1aBalrtipWaLni8Ju/TahSgUclR1h9a47UV7U/TU+81A3Q9LQ0BApp3AIEcwUD1M14QaHdc5yA1aFyFbKb/A5gcAoYDl+Yl7evFFpfFeJReah1CvcQo5oEsFrcNfvOmX7GIf39XeACtSGY94hHvZt8UHvmaz9XvDkZ1O18NgG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945358; c=relaxed/simple;
	bh=EbDRs8jVEyTPoShvrlIQOnlqcNkZ4iZROBNRv8M/EmA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pKwkuwIei463ZJPumhZzDsXnIlCX6ijbNyIZbilZYFvYdCl63GQELhz4/TRjQw+gxQFesToqyKGSsbxiikQWIKg9CBViGbJL7aUIAlyEbwuQlJKt8eFo4FsBCe2uvmmOr7ikNqN+dYBLvAY9i18wMmCcj+lzaaTAbouWbcw1G9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRAus1nI; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55f7cd8ec2cso528606e87.2;
        Wed, 03 Sep 2025 17:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756945354; x=1757550154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cRvY1i3eeK8uU5EXQ8tuV00NMUEY0gXTuGA41ZnQTAo=;
        b=jRAus1nI3RnPQkbe/2DGTsAs616BCvR5adIzSCVMIFo9UM4IUJh4O+x86RqyL5B185
         fNxoaO2cSeAusmPbunICxlgyjE/jXyzeEdLWGZFe4UKO5eCWIA0AtgCVV1WpeYTa+1NC
         IwgU35tNQs+5I34OOJX4hfPDdETvgx1tOlI4y0/+UDlrrhWC28IMB9J7Gnrpi3y1dItn
         tAEkF/X4yZYF0QFfVdGS8bVBHlS17rm40kT5CuocWm6bhWVVN+svG0wXwn+U85+9g7FV
         T+LH8PEmowOsURBBpnZtUWAOstN4WstjIbW0dZme2n1IAmSfAAe2NXHAzE5SJmEySksN
         Qaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945354; x=1757550154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cRvY1i3eeK8uU5EXQ8tuV00NMUEY0gXTuGA41ZnQTAo=;
        b=G/LGpGrGhc2wWKbkhKywwCLULw4G6+WATKZ3/To544lMmDJLQ58DIhJv0s1uX8GFL7
         uHhrg849BqatJWgjNrOqTU7b/Nkl8sEF/KMfHEhY1PpsTiU9BFjrBwM2SbqdfRFjHVwW
         sTbILSvgxWFX1I6AvMAPZtsvnp84GSwIzAwTZtIaumVO/Ae9hYWO/jSO6jGQQmRnLopP
         O9OdFk/L8fPAobOppOVbiesj0qoC+44qBxIHs0Xdar+vGbiUA5lKJPz2hymSCn5LpK6E
         B3BP1cPMR6lR/AQUaeyNQDSlIuC1CeOm+zXaMdH1KNJX9/0bHz0vsFgQSxU/LW8f+hCX
         u+ZA==
X-Forwarded-Encrypted: i=1; AJvYcCV99SLXWb3RFkCG7/UUtYc1dWLtEcN3xaKs+bovvNiJQ6TRcAT3k1DL/sr2c0ulVp+FVUuFpmBG3Kq337Rl@vger.kernel.org, AJvYcCWHjuKu6Udrvtsh6U/YU5A1/b0mUMYhDGm5lK35WB0hdYv0g6wYOBxdcwh93nD85hAAhtHxoeq9sB9l@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm/Ag+BB/swtIs6JUDMJwLxymhnHrPpDQt713n5Ph53Vr8Ac/z
	rQ/rd2+XK1TNePSkCXT5K2zb3oMQh84bUYkFzKtJQanbKARuyUlWIq8x
X-Gm-Gg: ASbGnctl9N/gfk8NijdM9lVJ1ENwCISqsw0DwQOC6PwF0jKFt9nng+OREsxh/ruxSMj
	Gx/+r6i/EqvJod98Cjt45tLaTJlTZz7lrEgORxY8UUeTMgdldyWdUKxQjBxmeP34SCb/13p7Z3H
	UmGwz8D4et0ORFOOpheQI0bMICFswWOhAC0+qzm7Ks5UEIYyTQHCJvZPyJAKEG4boyJuCB/QJ3b
	5Soq8KPtqk0fdVjMF9zBa/IsW9OFgYxvuai3z0U0bxuwXdJPdxMPYSQwZ92xO6Oo9fRuZtRwh//
	TgH3mLBxajZpwBSRVH3hqEalMC4cC79d2Zrss/udHekSc/Y7DtnMoGXUYw8Idz5Aro/4f7lt7R4
	ZNgH0hHgJcvjmOKPS2gmMdalI4IwSZMOONkEiA1ni7h9Hsp4PCelX+g==
X-Google-Smtp-Source: AGHT+IGQYJrReh76jTMJs2xkORkCKN7mTZ3yHyfY6cgCRALHPcO7cHaChEQ2cH2SUktxRValZPoV5Q==
X-Received: by 2002:a05:6512:2313:b0:55f:46cd:2c88 with SMTP id 2adb3069b0e04-55f708a2c31mr5338174e87.9.1756945354277;
        Wed, 03 Sep 2025 17:22:34 -0700 (PDT)
Received: from vovchkir.localdomain ([95.161.221.106])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-5608ab8e95bsm821613e87.34.2025.09.03.17.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:22:33 -0700 (PDT)
From: Vladimir Yakovlev <vovchkir@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: vovchkir@gmail.com
Subject: [PATCH 0/2] support for xr109ai2t panel
Date: Thu,  4 Sep 2025 03:22:30 +0300
Message-Id: <20250904002232.322218-1-vovchkir@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello!

This adds support for the STARRY XR109IA2T panel based on the hx83102 chip

Thanks

Vladimir Yakovlev (2):
  dt-bindings: display: panel: Add compatible for STARRY xr109ai2t
  drm/panel: himax-hx83102: add panel starry xr109ia2t

 .../bindings/display/panel/himax,hx83102.yaml |   2 +
 drivers/gpu/drm/panel/panel-himax-hx83102.c   | 193 ++++++++++++++++++
 2 files changed, 195 insertions(+)

-- 
2.34.1


