Return-Path: <linux-kernel+bounces-818652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54728B594AE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E664861AA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2A82D1F7E;
	Tue, 16 Sep 2025 11:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaCmwuxh"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CA52D239B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020570; cv=none; b=EqmPiFzPUSCxCRIqU8qGnjH1FHMqSThF8mE27HqmRPZDckEGEwRyBvamxfRAuKCm8KXWMxGFImbUtSaY50WNSm6ImZbbhuNUyB4qtrhtcN9pPLKRKmjDHkAi8EuJhLXnmW2s7qLswA6rRKBA8BcwUcpcKHk1UcKZT3HsBRVQo2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020570; c=relaxed/simple;
	bh=qdH0cwSzMgSsRxBe38syostBYt8ms24y1BNRUcCKgE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJHrUMrdXnmaOrSGmg/FpK6yaPGHaF1TNE9HmbuF2v+2VA4kPDTUT1rwTm/5glzrfwLWY+C/lLn3mvVgZy+QMs+M9eCIYPC6bnbE9wu8BZhg07xTMb+O9qHOPWLHwnqMGS3tvLu41f/Qx6u9Ay7u7xBrL+YwFFC4EZsJQcqvyb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaCmwuxh; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-772843b6057so4744340b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758020567; x=1758625367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4b6XW87JsHSuraknHjB3p/ca/yYzIT1w7Wpy7c6pfmE=;
        b=MaCmwuxht34jXbsj3VlalTsFqXFqDvIxM7MtX1ryIchJJlXEmpORU5DawXx4yQCya5
         bSmkxyD5IqYi+ESUfWJY+JR033qj25jIAHKUEPcDMEsRdaczznFPY+FDOSSRbkTWUbsP
         Zld0D14OyiDmO04DpN84ndeMtCQnI4DXcHKtkxN6q25Z0Zc9W5RNoy69psB1SAAbFDkU
         YQznLPlm+Fdn0HNLVzmp0Yj+10dkan3dh3q2I8k8ESYyfpOnzgWdcStDOTztKOXh5+ev
         +xeqkuAl5OzF9KSg6DolbTZob0OqPHKanhFASE/cTujvILq0ZbB8Mg8EqfdfoxSwaEWm
         lEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758020567; x=1758625367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4b6XW87JsHSuraknHjB3p/ca/yYzIT1w7Wpy7c6pfmE=;
        b=vgpmQ/wiixYHZmgu/ivpLj6UWGStqyh3RKDljAhASyPxUWrkxP1wAY9FoyYBTW6igg
         6KEhp8xIqcZUn86PF2FOIVy0LMjPCVafSOZ3QKXk5lN9XmxmRXsU/J0+WbkuiQdSdK7+
         l4kqwJZGXm7mhk9p/H/0dlVucqq/UCS7Jdu14rZ9Tz0ANvkkDPtarCCQ+EApm7wjXa7/
         q0WzRBg7D5ExB0biPhvt1gyJuu6w00d4eR7NMlE6A9FD0xnjVIjmJD/NpzG/Po44BiTO
         KWOwb6uFmCa8Lx1ftuRigPwUJ6uvrDCaDGGUrTqsjc+JuHDSA5rxc6xdSzY+lFf8neuY
         KDNg==
X-Forwarded-Encrypted: i=1; AJvYcCUmAFv8lSo1iLefYHbwZ8u3uvAlmGSqUJlKEHS6IjccxJYiB7nhPP6yUOzjBOH4Zi7POIzDHCDC7csjRIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMTzmOshN2R9cTPAt1ulkUqOHJxpZCOoQw/VipC5Cu1USxvXZL
	dd90CPvm12GhcOYdyYp0XNskM6hTkej82QbUp4xtTEBXaXiQbpdnICPF
X-Gm-Gg: ASbGnctJIFU3CWN8BeBJ9nRXH8ZiyDf0Li/8LTRP4k7y4fmKIbiaRwl131oTQ50/S++
	cfY9NdpQqc8dgARBgWMk0I4QuPpDBHXqrIBxoyrEO5oRQxn0QejbiK1wLLm/CFaIarzVz2aoiMw
	jqcvXtieiLXSjsmV96Dp7uyWYe+WHTpWX+NvY0YsJhg0iQt01PNLVoG6BdB1zfiSrN2UlGXc3WX
	99L7g6rdA63Rpkl5pABhlimK/gAwDtWRFWPidMzLTYKMBjmIEYmlnemg4ljHY6fXxg31N9VVGu9
	nn6lyZvVYKyVOcoVeGcsXd3OjkYU+7KyEZDGdirFK1sv5a6e7w2e2zui7vNlQOuJavLvgY7v+jp
	xqRmLbevdhVc3cW4uTw5b/kh4qI8OOOrk63skEe/ad6Lr
X-Google-Smtp-Source: AGHT+IHMVHV6SjMVaNeLwIfjTx7n2IhBfG8XbV7sSrXxMiys4dDXgEzR/rAQd2mdNKbFfT8gCZG3/w==
X-Received: by 2002:a17:903:1b4c:b0:24b:640:ab6d with SMTP id d9443c01a7336-25d26e4872dmr216575945ad.49.1758020567101;
        Tue, 16 Sep 2025 04:02:47 -0700 (PDT)
Received: from MRSPARKLE.localdomain ([206.83.103.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b304ce8sm158761725ad.128.2025.09.16.04.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:02:46 -0700 (PDT)
From: Jonathan Brophy <professorjonny98@gmail.com>
To: lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Jonathan Brophy <professor_jonny@hotmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH 5/5] dt-bindings: led: add virtual LED bindings
Date: Tue, 16 Sep 2025 23:02:17 +1200
Message-ID: <20250916110217.45894-5-professorjonny98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916110217.45894-1-professorjonny98@gmail.com>
References: <20250916110217.45894-1-professorjonny98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Brophy <professor_jonny@hotmail.com>

Add device tree binding for virtual LED groups.

Co-developed-by: Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
Signed-off-by: Jonathan Brophy <professor_jonny@hotmail.com>
---
 include/dt-bindings/leds/common.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
index 4f017bea0123..39c34d585a47 100644
--- a/include/dt-bindings/leds/common.h
+++ b/include/dt-bindings/leds/common.h
@@ -63,6 +63,10 @@
      "lp5523:{r,g,b}" (Nokia N900) */
 #define LED_FUNCTION_STATUS "status"

+/* Virtual system LEDs Used for virtual LED groups, multifunction RGB
+	 indicators or status LEDs that reflect complex system states */
+#define LED_FUNCTION_VIRTUAL_STATUS "virtual-status"
+
 #define LED_FUNCTION_MICMUTE "micmute"
 #define LED_FUNCTION_MUTE "mute"

--
2.43.0

