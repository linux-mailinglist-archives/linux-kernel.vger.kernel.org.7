Return-Path: <linux-kernel+bounces-813291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5AFB5432E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C159D4E150F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F7A288C20;
	Fri, 12 Sep 2025 06:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kh9zipaZ"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEFC287510
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757659685; cv=none; b=IU0rJwgy00ppHYUwopQSAIMohhShLfPA3t2VksVr47PAcDEiHrESHNrRLYeLvTZJkUgw8nsxPFcO+rlxXaIfBgo2paXBQPnJTQTb5XGPpYydCn/5IQLNiuvld1fjFQkgV3ia8I0a31xuomclyEpI2yVbxFfqQ1X5DGOC4UXEpwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757659685; c=relaxed/simple;
	bh=6KQEugjnx2rJCM48+qtPictQnwqObzm5rcbLajzHMU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGk1KeNN+Fe51X0g/PnkBqFZJ0T+AWiNO0x7miBF4zchhPnsUQUMifNqKgjCpTv7EXpIr8sW6t4ydhlRv76I0CMCV51xloC6Mx+RuH8Z0LmfEzOLppcqV3owlqzdVpk8h/mzlHtB/iZcF/ujycdWEQKkFkpJvaNctWwwAD0oRvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Kh9zipaZ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b046fc9f359so236538166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 23:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757659682; x=1758264482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NeNrKd6NoBbgDfjKGLBumkxmas+f61lF0BwvgkVNtg=;
        b=Kh9zipaZxajVGH4xeN3ClG+zRHVb3Y+jlk/+SdO/tjmygNYJQa29LOkZsepxHUwuTv
         l6x24eCmWHrmh9AVWcpoE/GK1ETizP5gbC10GREXP+iBEQAU5VJ90LFXRonc5K1Z/umk
         DtrWByY9SyhMon+UTMCxRIr/ChaoRai0H69lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757659682; x=1758264482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NeNrKd6NoBbgDfjKGLBumkxmas+f61lF0BwvgkVNtg=;
        b=M6MfkFIZ6D2EvXLe7Vqxu0SktxrgJsya7j1bZj0s7njaglcamLbTYFdtLzhCfoxARX
         KjanQgg7HN8BrswEeEASDpzFbEmpxQfW9vMVSwx/xeuXcF0mxVlxAcMcdXnUbqvh9uLg
         1x7o5eIUfBocASiTmofbQMR3z0hBHVugwipzpDPOrQUpOTtyUh012MWPV3sfINIYeCTw
         +Fo3GthjeP+Hc9tjNPqz8lCApC25issrL97toDvSRnnOt2QpSl4eVgS+QbIJokVo7cL8
         0xkW/O2aqINqdUj06yoo/zcyG1MsrbA3Y0hkcRDTLzXhjAeu0Ipk7pcZ7texYO6be98T
         L2xA==
X-Forwarded-Encrypted: i=1; AJvYcCXO+4OYo9HgOR5xdCvgx2Aw7/waKXsCinfoc9iQ1lswGErmx5GAPX6etkRALwYn799k7u5KzaMrow+/HtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT8ETt3f9Fqx6E3VcGitGmgNI8E1NrvwoxG6kgDm9EOJOtlIzA
	jUhMmQVpdi33ls30afCz+MVT6AV4CZdNkS3biFU6FmwYtljMp/IhAwx+0nsUzOpezw==
X-Gm-Gg: ASbGnctY7D1E9mCoDWBgxr0ei00q2tVzoOSkDGzkwZ6sbtAyxZ423K/kjERO4+UjuZO
	LIt8hNS/7AOyEPIesbpvXRaQ9TA7aLKZ6kEt/kd9wfsHDK8MiNVYr9I5biCER1V+cYoGsYoFRxJ
	cSCVp8yq7W4J8Gq2k4qjGM5ghq3cJlxMP8MY9QHd/eajLdtpzNgeHMQlo8b9eBB+BSZT8FCkorn
	vUls/ujDQX/R5kG07BYndtQgFwNOZ48OVvPbvVEi2aK5Hr5wSA7Iz+GveJkwBdgj7iUsSF8B2Cg
	SxCHfrGmENjUwQc0aW/mHZ/SoIaw06Ie7WLMWSp4KSP7LaTv64jU4X6jBVy5toKQzuP/OIzTkMW
	W5puxOFwZp2dhEY83tm0UdZhoJ4S7KQhZmq3+Wn9c9/OoFWOW9gYmcy0Y7SzWVfR0oIW9uVXwKk
	a+M/aGjGgdiEoORUE=
X-Google-Smtp-Source: AGHT+IG1I03T5HSq2OfkiQuee3J0Y3gSkDAX+xUtryPFhxhfXEKh52whMlG6mWqFElm4wgmiKoe2Pw==
X-Received: by 2002:a17:906:794d:b0:b04:8701:7304 with SMTP id a640c23a62f3a-b07c3546e64mr171386666b.10.1757659681595;
        Thu, 11 Sep 2025 23:48:01 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (240.225.32.34.bc.googleusercontent.com. [34.32.225.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b3128a1esm295465366b.29.2025.09.11.23.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 23:48:01 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Andrei Kuchynski <akuchynski@chromium.org>
Subject: [PATCH v4 2/4] platform/chrome: cros_ec_typec: Set no_mode_control flag
Date: Fri, 12 Sep 2025 06:47:49 +0000
Message-ID: <20250912064751.1987850-3-akuchynski@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250912064751.1987850-1-akuchynski@chromium.org>
References: <20250912064751.1987850-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This flag specifies that the Embedded Controller (EC) must receive explicit
approval from the Application Processor (AP) before initiating Type-C
alternate modes or USB4 mode.

Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Acked-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index b712bcff6fb2..c0806c562bb9 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -491,6 +491,7 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 
 		cap->driver_data = cros_port;
 		cap->ops = &cros_typec_usb_mode_ops;
+		cap->no_mode_control = !typec->ap_driven_altmode;
 
 		cros_port->port = typec_register_port(dev, cap);
 		if (IS_ERR(cros_port->port)) {
-- 
2.51.0.384.g4c02a37b29-goog


