Return-Path: <linux-kernel+bounces-867130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88736C01AA8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36FCE3B5777
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5429328B45;
	Thu, 23 Oct 2025 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pu/6SB3+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A8A323411
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228074; cv=none; b=cci+otdAJceRxOk2RCCbww33nAiKmkjl2EtSHxFTbpb0Tyn1jXxfqCpG/ZMgYOJygWAhuJQqkuCdaWcT0d/y6mxETEWG5Bym2HmbFUJMAzdKtFPD7jfF+I/mQRbzBH8PQ3nUPey2ax6QSA94NareYRIbhJR8p/kYRsRIruqQQYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228074; c=relaxed/simple;
	bh=GwdorghP7pkx6jrL0xNhcOjrQ7rW+RmSi107hDe95KA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FpGkqkLEZHH8KjLxcH1quF4NAIodAeaBUBFp/aK+MeOgyJrkVCys7FPI9Uep5xV5Abmjhsogry8/6JMfZAAsbNlDgOmZwDx4JhObsg2qGyfQDvS58UaKfyvZQs8667y6uM1/zsgySbdAWBUeplsrhuEzcvX8qJSOOKNk/5RhrBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pu/6SB3+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761228071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NyZc7IIr5uPHqqlmg8fs1xLiepRwuPem5qvpkm3Ay88=;
	b=Pu/6SB3+iIjTxvf243Nn3V0VZjF93V1EtOSaItUrxk/6gW8jIbn3cijZH0/Q52FE2Bxn0f
	SkBGU+SLO0lzF1821l0Xckhjab9XJHaGZ1AGgTWsf/P6rd/zSB0vb7UJe8bayJdYSeCqS3
	FfXUOe1pKZ80vYVvGhyzGzdDpguk+WM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-3bd7OgP8Oa2VLHha7w1p0w-1; Thu, 23 Oct 2025 10:01:07 -0400
X-MC-Unique: 3bd7OgP8Oa2VLHha7w1p0w-1
X-Mimecast-MFC-AGG-ID: 3bd7OgP8Oa2VLHha7w1p0w_1761228066
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42814749a6fso452343f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761228065; x=1761832865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NyZc7IIr5uPHqqlmg8fs1xLiepRwuPem5qvpkm3Ay88=;
        b=Y5ooAhNfYdBn2ok8W3i8t4L86ff4Vt2Y9+r2XktdzM4ZTV4VLOwtcaHdeMKVSAZvme
         +vefa0pD6wjxf926koutyoGa20bp/ckao4O+bKpZ2CtT9428vmazNTRg1nuze6upvuOs
         /Dl9xDY7crywqAYDwPOIm7MTY4TqWfHm5iButP1ShISAa83nNg9r3HixzYvoitag3RtX
         i6il3tv+ivYZOsOEMLlzZwd+0+SF/V8QHr2yBDC+/bM7KEsKhYzZR4Y22vEdU5eQ/3V1
         i5d3bsgeiCMXU48YaWwd+WEQfK2q89wqcU1O2KV6l31Txgml8wCtzfWPEylHPkVLInMO
         D4RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjS8TGQ3Zbg1v4YXdCf9Pfd9v8HRvF6BbioZ0ZzgAZTwC7cIcIFx3eNwYE0Rei9kvHqbZuCVTwcOuVzWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT/abV/TXKJQ7Kt4SCF9+eaKB8nSzIu34W4MO0TGpYDb3Rl3mP
	eGGahVvMt88s2FIwqBAwcICCrMiptqzdP+Ensq2tVTLc+hTISn9QvzGERtW80VLFg1Vb4RX892V
	T5KlQyRFd0cTBWDRsV+A1dkyxW6v+pCmr75NRRrE5GgLfOls1vZhu06geZ1YYsr01Um1lluH8ym
	dJ
X-Gm-Gg: ASbGnctcRZACbazkyJLVPD72jq1W27y8TAJmUIMkXY7N8IFCwqs7BQ2CaIdVOzW5vP5
	l3iaz+1aAL+J0NSWl9HhP2B7NIqoS0BXUNtti9Al/2zMAaFIY7GX4wkwBCGbxN8rD6pRzekCI9d
	NnyB+MX+MXZOgshC1WU0ninXsOAp0+0iRNoj8dNUzNXFiwDOYDgDus5RaQSh1E2sRU7USgRYU/p
	8tBVxU9d6Ca9cwl6XbwFM7BkoG+h58m918lVycoYt6SeA9KCrMEMhTZoiBQKHfLTIrwyoZCZLtt
	HVjDQqlhGfRzYi97hTt+XRupwiN+LT3XDHI2x1Oc2CBPvfAN5pr95zm6F1fY9Uz9FFi2K6AsemB
	zygk=
X-Received: by 2002:a05:6000:310e:b0:3e7:5f26:f1e5 with SMTP id ffacd0b85a97d-42704d623acmr16053904f8f.23.1761228065055;
        Thu, 23 Oct 2025 07:01:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUJZMivJm75Uw39dCdUfRrfDXZwOWqWp5mZ7JKvKlDw5WhQsR7ZPZTgl0xq6VXuPm4KMweVg==
X-Received: by 2002:a05:6000:310e:b0:3e7:5f26:f1e5 with SMTP id ffacd0b85a97d-42704d623acmr16053863f8f.23.1761228064464;
        Thu, 23 Oct 2025 07:01:04 -0700 (PDT)
Received: from holism.Home ([2a06:5900:814a:ab00:c1c7:2e09:633d:e94e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898add96sm4116154f8f.30.2025.10.23.07.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:01:04 -0700 (PDT)
From: Lucas Zampieri <lzampier@redhat.com>
To: devicetree@vger.kernel.org
Cc: Lucas Zampieri <lzampier@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vivian Wang <dramforever@live.com>,
	Charles Mirabile <cmirabil@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/3] dt-bindings: vendor-prefixes: add UltraRISC
Date: Thu, 23 Oct 2025 15:00:50 +0100
Message-ID: <20251023140057.204439-2-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023140057.204439-1-lzampier@redhat.com>
References: <20251023140057.204439-1-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vendor prefix for UltraRISC Technology Co., Ltd.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9ec8947dfcad..887bcb792284 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1642,6 +1642,8 @@ patternProperties:
     description: Universal Scientific Industrial Co., Ltd.
   "^usr,.*":
     description: U.S. Robotics Corporation
+  "^ultrarisc,.*":
+    description: UltraRISC Technology Co., Ltd.
   "^ultratronik,.*":
     description: Ultratronik GmbH
   "^utoo,.*":
-- 
2.51.0


