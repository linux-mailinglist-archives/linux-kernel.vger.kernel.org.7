Return-Path: <linux-kernel+bounces-785027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A95B344E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426581A80746
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5511030102E;
	Mon, 25 Aug 2025 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nQFjRF/m"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75223009F5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133892; cv=none; b=ZpeAfFvie5xu3GLfh9SqsUBR9EI25WAbei6a5DouVVxExkHmIzpwvH+ZgHuWWb20RPD3WKJ80EXUiwC5UWH9gcL9ZjgXKqCn7o+P3oAoNTSjCxMAOW0wuRpvruVTn5AetBlKSq3mLVFBJesOLZDX2prncfpcr5r/xOkRsNJIgYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133892; c=relaxed/simple;
	bh=sCzcaHvyNBs2XDXKynfkNcDEJnlMJJf0GaVUdmsnhSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JeDk4qTC/0NhnIctVhmC0kEjT25xOlyjGbBHqZSWVj90XhZCOCIrwrQFaNikOQr+GAPn5U51R1dUtoVHKQGTf7LGCp8dNJWO7QweRBzR8y09e979D9BoDI9J0PGlWm6vcYkMvqfwZVBW0mq86E21O6yiTg2vHnNQylYhuA9bVBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nQFjRF/m; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afe84202bc2so145049966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756133889; x=1756738689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEe7YY1Cpi7JTuOOA0pZSF33Y12/vgAOx6rgD/OGWgw=;
        b=nQFjRF/mRIKyWLqe4gUhep7kBD7cpHUrxARXwiwcusgeBPJEa43vJsFuH0qayHH//C
         Cy2iJKpKBVGjDirQ0nxfGPW9IY6OB5zio8PCWshuztPN8h6I2dogJQb87EGVanyMefpY
         QTPtzeDnNpHa1cU1ueGq+AApabEiW8ax2c+6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133889; x=1756738689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEe7YY1Cpi7JTuOOA0pZSF33Y12/vgAOx6rgD/OGWgw=;
        b=Zy7dAoWSM2ZVr903HcryZY1Vw0P0y2onE3+QK/lXJhq5hQWYBxL0fodcUGAqHx6+Q2
         eqKiP3iCXN59Lavhl0d9ps9d+xIHP4oYCvVAGL0TmmVaE6G9o+ZPhGMe/tiZ/9xln42k
         4IVM7jtiWsYrIwMMD00qWjzCKuicwN5/fBg8jHGZC1dmjg6or/IVYi3XVZJl7CV6FaIH
         2i6GKC9SKJY5O4gxtdRXURFmspEY12VCL4uC94E+rzb0ceBo8tXGJi/zRn7SDaz7TeH3
         TRT9ZEUfts4tuPyY8bpKi4WL1IM3d4jOxdLPB+4ifIbKMjB9n7KJMcFTehc22nlFgucR
         qf3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWV9gTAeLGiiblN5dqnj1MDxDe/3mHI62ib9WUEnQrwybs7DouKMUuMgXavYvoOc2jtLOte+JSZzGrXQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxomi3aLJ4NTQTiQrcjN8mPSUbzuxG099l0dawAP3vcXzTwFfcB
	E/fYSU60w0MNpo4tqA/PMse0DJq0v0TtpMhrRXpc0REYhwQY5rpzAWOuth4te8K01A==
X-Gm-Gg: ASbGnctQGrlOSRKi73kFvrYP/6euFtEoFqpPFzX/oXNuLtHIj5uH9XaGFdO8FQq7+M+
	GZblGcY8nM3XybEloxr2wCQuLL9ygROIzuEiD9vTmf9AZdlw7QYZzxLaW3bPB5yyRspj/JAB/NL
	ZhgyGkVS1TnwgbDMrv4FOD6d3ho7Aty/+mw4QM6mya6/szhARFr/rjlqix3FWK2tbmjfFUUAFf+
	g9rdHn8Ny0/aSw5nCebvD+gKmFjRPZSczqWhoSjkZoPOa9vVoel0D9AWsjn65rsgu1ekfp0irDq
	1p2RZt/G9V2ZKDJ8I114qVCjbzrVKqLG5OBUAH8BP49w8rLCectLKRZTDZuQ+F+aglkPkEfr8w/
	QTvAKXwVY6ihMNpMwO/yl7weAYwnKaG7dqbGjrC6yjDmXZw3ttoOdSiH2re2JQM2fHX+lnZL1bS
	dLis4yzG2fkfB+
X-Google-Smtp-Source: AGHT+IFyGVkJn7Pe4QajoYR658kFpe1L884A54RCJlaO5lAZ/VrHyO1MunmHlcOvbaeR2ixPy/zAag==
X-Received: by 2002:a17:907:86a1:b0:afe:735a:fdf with SMTP id a640c23a62f3a-afe735a1362mr500412866b.36.1756133889266;
        Mon, 25 Aug 2025 07:58:09 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (168.23.91.34.bc.googleusercontent.com. [34.91.23.168])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe8d03f981sm117294166b.60.2025.08.25.07.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:58:08 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: Guenter Roeck <groeck@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Venkat Jayaraman <venkat.jayaraman@intel.com>,
	linux-kernel@vger.kernel.org,
	Andrei Kuchynski <akuchynski@chromium.org>
Subject: [PATCH v2 3/5] usb: typec: ucsi: Set alt_mode_override flag
Date: Mon, 25 Aug 2025 14:57:48 +0000
Message-ID: <20250825145750.58820-4-akuchynski@chromium.org>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
In-Reply-To: <20250825145750.58820-1-akuchynski@chromium.org>
References: <20250825145750.58820-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This flag indicates that the PPM allows the OPM to change the currently
negotiated alternate mode using the SET_NEW_CAM command.

Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 0d6b0cf5a7cd..85a6b7fc6d93 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1632,6 +1632,8 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
 
 	cap->driver_data = con;
 	cap->ops = &ucsi_ops;
+	cap->no_mode_control =
+		!(con->ucsi->cap.features & UCSI_CAP_ALT_MODE_OVERRIDE);
 
 	if (ucsi->ops->update_connector)
 		ucsi->ops->update_connector(con);
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


