Return-Path: <linux-kernel+bounces-786072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 716E0B354A6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2329E2083EE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 06:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7020321FF29;
	Tue, 26 Aug 2025 06:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F5K8jR+a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C0C17B505
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189984; cv=none; b=btB6AP4u8w7vspDRzykhxvSDqXkq+eyBkI9Jx91zI1jguvBWc1R4hQ7qrk9eTA5LNQMRJcUIth2wLMJEJoabdy/1Cmh2Pn1J+QxLN25btZ9N2wbFh1QVQAAmVxNMAR8cyu4TvWRmbJcg4LMukOolyCcFGxMa1nRuQINqFbY9n0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189984; c=relaxed/simple;
	bh=k1R700Z2+gqjiMvUOhAJnMVBUMz2mNDlbwad6gs5mnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kWZr6rc4QSr0G6c/Rhyzi453VOe3IQoSpHWa/r/S+Ow+K5F1ddYyv7Pa/eHbXr7p0brAntMoCFe9cXDa1wtMMbvpIJpQNtmFW7PGLfSUJL/RM5JZmbRiN6XH5vtqKelwGtHi4zlCLPpFbaAGlXXB+cN0T2vme61pvHg0O6tqG10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F5K8jR+a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756189978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZbpsP0JVSHBALAr4RXTkvJiiQWMCbeHRvXA5B+Ppf8k=;
	b=F5K8jR+ay/cwrAAQBP+VJ1qwu2kYwEXQN0es6vze43XI4sA2Seoj9QCHJ0dQrF14KRg8qt
	0GH8HvfL6HL5cfHCoJyGyinvhj62hcwi89qq2W+v8i1xRC8dYJ/zVlNAsvo3P/HrUu7Peu
	8HkYLv47vZvyTdGs1S22cOdyae2diII=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-o2pmtz37PQi82Gn4Hm9y5Q-1; Tue, 26 Aug 2025 02:32:56 -0400
X-MC-Unique: o2pmtz37PQi82Gn4Hm9y5Q-1
X-Mimecast-MFC-AGG-ID: o2pmtz37PQi82Gn4Hm9y5Q_1756189976
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-afcb7338319so475218966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 23:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756189975; x=1756794775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZbpsP0JVSHBALAr4RXTkvJiiQWMCbeHRvXA5B+Ppf8k=;
        b=nCsStsjtq9InqhMwE3jjP4/YoTlgKm8etaWfOLmJ3CX0E++GIc1bEuUgG2tuhf2aEK
         9U8vsLnk7q+5BfiHm1Bd+GHiE3fpVYudKQUZnzVZFLcrbJ0ciQif1znhPv2gytnxQoa7
         hKWh/SxxETEfESEqRwiG1TLtnt6WtYY4SC/GqT3rJTizD1szCFHSPlnCSdyu3ekoX/lM
         IhFuJVgSABEn/L7D/vrHLKu1OcNmxYL8YvRxU07bIoNnCSE8xDW7DAq4U4zpEEbC4vPk
         UbcdNk9ySxmYL5A8N29Ew++uH6ZU46xdS0j+nyOz/49GOF1mIt5YKfMXdS9Cd/+CeD6D
         ABzg==
X-Forwarded-Encrypted: i=1; AJvYcCW8vvMB4G6gDO46Fd2bnEzug8nZ4LiylgSgNIy016ncniCTE/PSA0RRIzbJJnmexW/Ip68KEWVdCqNMeHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YynPLZA/g+AaRs6PL9O6RpZcxHDlZPphK/OEW2sNNvFkg8a8f6n
	QcU5An3OGeTNL3vEp93+PFww30TrhtGkk6qVF5oWGs4ubW80SDfKtXYNWVGNMi5b9vmYFHFxqRu
	dJ2fVOJMwW9fJu7Glius8/a1lT2vd01KVBBJL6pIA9bGoYm0VrD0igd8wfzp0wIbGJ9MLClo0GA
	==
X-Gm-Gg: ASbGncu8718srUPXWo5+wYuTr3hXCpJdFiga8gcePQ3Fg3B9L4WOVEcgoom9YE9Zymn
	jfNJoHUl2CoNQrk8dmxDILSbu01BU71H8Pd/+jcqTBG5hsF/HGsPwIS4e28qRmVwd8NCT7tmhsm
	ISfaOsXqp5L0RrzOUaf7fgbE26wemmws9gStPShY653mbhUdH4jj9y/5Kg+shGsK90ZOwNiDi44
	2qhNKIZzEGZ1VFjo8YNXNAZoMGQ60fim6qbjxTAI29KxtGhc8izvzTPqHjsJA5iDfFgIr95KnT2
	gNYPZuMYirvyAkSOz+Pkzry2W1w4OpsvOCn3QcheRjzRPokCUcoh6pXcV+3VCz83G9tEGfk6y1v
	BoBrNHLrVjQ==
X-Received: by 2002:a17:907:86ab:b0:af4:11e1:f877 with SMTP id a640c23a62f3a-afe28f162a8mr1291526366b.21.1756189975119;
        Mon, 25 Aug 2025 23:32:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmSRbT/Wld10PpqjSUmNkXsFiZtdZslyiz4ToZl4XaqIzH5GqNA9prjgy3b7ugqVJ4b3iyig==
X-Received: by 2002:a17:907:86ab:b0:af4:11e1:f877 with SMTP id a640c23a62f3a-afe28f162a8mr1291523966b.21.1756189974678;
        Mon, 25 Aug 2025 23:32:54 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e01:ef00:b52:2ad9:f357:f709])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c3174f806sm6346137a12.52.2025.08.25.23.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:32:53 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust file entry in DRM ACCEL DRIVER FOR ROCKCHIP NPU
Date: Tue, 26 Aug 2025 08:32:48 +0200
Message-ID: <20250826063248.32153-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit a7352c849492 ("dt-bindings: npu: rockchip,rknn: Add bindings") adds
the device-tree binding rockchip,rk3588-rknn-core.yaml, whereas the commit
ed98261b4168 ("accel/rocket: Add a new driver for Rockchip's NPU") adds the
section DRM ACCEL DRIVER FOR ROCKCHIP NPU in MAINTAINERS with a file entry
referring to rockchip,rknn-core.yaml. Note that the file entry is missing
the part rk3588, compared to the added file above, which it intends to
refer to.

Adjust the file entry to the intended file name.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d4bddc462c07..a569828c9f3d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7542,7 +7542,7 @@ L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/accel/rocket/
-F:	Documentation/devicetree/bindings/npu/rockchip,rknn-core.yaml
+F:	Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
 F:	drivers/accel/rocket/
 F:	include/uapi/drm/rocket_accel.h
 
-- 
2.50.1


