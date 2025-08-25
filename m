Return-Path: <linux-kernel+bounces-785025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D5EB344DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9E917A35C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B32E3009C2;
	Mon, 25 Aug 2025 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VDbqnCk6"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3B13002AE
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133889; cv=none; b=l1doMcrYn9xH4eu49++7L8f15en5h0LRyHOnuxiUXsY86b5Y8vdzj/98cSfxFcHb7dST3nFaO/phwJgMgu809D0ETwW2batHoGa4r6CYOHjENDL23JRnI2eZE7lZq3vLgZoutEHV1RXoG+dIrDv/5YV3njFUoZLRcDBQsVCJQv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133889; c=relaxed/simple;
	bh=tkimgEY4C8jjn4oRfroM6cLsK17WffIXDAl9IE7NHq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdlBWWJENm9eCax/cfySbQ8vzcwDLCIjc1W75Y9XOLvGDl5fHux3h79CwygMVfrbE9cqPYR2x5UkpZK0VM4xfNFOYrtpgvXopYoC9+qF3QNOoltIdzy0kAnd93resSsgNpR2WQChuw9llKUK7stz11Q80WXkN1THqoHlXYgHKI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VDbqnCk6; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7ae31caso822951966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756133886; x=1756738686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhhWTF/hAYz+kqb7eG5oSk05Be3U3tovVz6EKeBpeMI=;
        b=VDbqnCk6jwaqWXC12jUfgzaKWOlOSzV4moyqkx7FrPWdjORbOTV7LlWNOLXp+W+voU
         mkQAaPJeQX6A1dkDDiabFx+m9CKYzpnYL93QsGSu6RODH64p+GDj3aXbJln8swo077Ou
         FrO/PTyKXja79XfveOi4ltsx4qZaikggdgehw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133886; x=1756738686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhhWTF/hAYz+kqb7eG5oSk05Be3U3tovVz6EKeBpeMI=;
        b=NYwn8NQLMXg2h5XR1gw/piT+E5C+zPHNG3+2TyeKm8S/lU3Sin4ZxKtyhbpjXORdHS
         3o81/bOUzGwtvUzgrtkb0lbu3sbZbGAtzckM5ciwahaneP7hvKnThohPhjUt5CA+fyd8
         eVUu7KJhcq8Dao2kZC3ofEHBRmNrYD7lTPcvTjMncFy8iag8E+Cy/gvsmyyxWXoAxbh2
         qUShb8BVOcmnXm52I8ag7kXWCXKojjHNAFU60XITL8rBI5eIYj/o58Hwl0hQz6CxWFAv
         4GstjrWgIdNzOLXSCDX/SYeMTPuHq7QWOHwhzJR5Mc79ysYwcHA6BNHvm6+RBVYCSRTA
         3CZw==
X-Forwarded-Encrypted: i=1; AJvYcCXj+TY33nKozjYL5dyeBpROD6A9qBzdBbiFLuFllRKMfbsJgQ0fc19tdgWzqVDOFeHQrWbNCSkQSVKJtsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHu6t71fHNxkW8cKROMCiN97dXOpRuNr04ns7mwLbqupPfn3fc
	0Zhp47kR7cC0El5mFgoJJlJzSbqkyDZKetX10CAd7Ct9h1XVEMKtpHAaVh6Iwg3JnQ==
X-Gm-Gg: ASbGncvhcCEgnJGnTQzQSjwLl6RK0lg1YUnS2QvFzAhYmyVAzG8qXDoG/QX9TfkrDdg
	ZDnr3BIKf8mowDmzFKCkhoE4pGnh43G2kIvKWY3yRHF+FfQtOF1oJCED4aQOmNMMmisFIALTWF1
	ESdRgwYIGpX2BX/XHXXEMBTFXvaYaXWcyXPWkYAb0HchstqXnjytLRHLAxVOR6VFd2URW6eiEOy
	Z8r53nvd8XHa+UOdRNlIKvz/mDkO2UuY13jTfD5ZPFDlS9PnvsUWYwUq95s5/cBgjl7I2nQIZYg
	5K88MJ3MrtrbBUlJTa1kh429sD4OoIn0+JF5JKiwqOM24Xy2KEBckio0gKFSsE/4KPjZ7avnGI6
	y8t7PxQXUJ18ygOs6DMWRHRrJW9nfNckbA2p98OraTocQbAJ070udX1iSE8nXa+aNvljlFh5ff3
	hMzXqnqGZVDFuP
X-Google-Smtp-Source: AGHT+IEzjvHrN1iQIq8FAKzUqb34qM6bbiS8410ZZtrIWblYT3InjbPAMTBFJWEl9Bykqq/40gzsjQ==
X-Received: by 2002:a17:906:6a0f:b0:ae3:635c:53c1 with SMTP id a640c23a62f3a-afe2974ea3bmr1211128166b.54.1756133886030;
        Mon, 25 Aug 2025 07:58:06 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (168.23.91.34.bc.googleusercontent.com. [34.91.23.168])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe8d03f981sm117294166b.60.2025.08.25.07.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:58:05 -0700 (PDT)
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
Subject: [PATCH v2 2/5] platform/chrome: cros_ec_typec: Set alt_mode_override flag
Date: Mon, 25 Aug 2025 14:57:47 +0000
Message-ID: <20250825145750.58820-3-akuchynski@chromium.org>
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

This flag specifies that the Embedded Controller (EC) must receive explicit
approval from the Application Processor (AP) before initiating Type-C
alternate modes or USB4 mode.

Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
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
2.51.0.rc2.233.g662b1ed5c5-goog


