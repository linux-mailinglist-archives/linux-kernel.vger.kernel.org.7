Return-Path: <linux-kernel+bounces-728273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 228E5B025B2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 22:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79201584981
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64331F4181;
	Fri, 11 Jul 2025 20:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a2H1odTE"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D591E3DED
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 20:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752265250; cv=none; b=qQcku6IeA4Ye2L4vTDDzyVv8fQg8D+/biw92xV1S3+vH+a5vMB1cCNQ1gFXZvYmL6RULa2iR7ZCEX9ePKbzhYgQsv0Fl2q7HYL5NRZLcJOrCSyb274v56E6Kg44xY6XSrpJ9TjZWwxHSIYwItQ4v2Zg11jTDEc/9LJwhuMG+wug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752265250; c=relaxed/simple;
	bh=E9M5LVZriBjPPfBospdk5yU2oDbUHaY85GbkjDHpjMI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=C2QlPQXS/6dKgWwAD02ngZmutnwQ4LdpDYVbgmNW2ckmHCoYsVhPpHxUnjoSadn2iKAl2YTy4MzR4ShTPiKk3UoPiUDd6PjjPW8zQDVWvMTABreJ94fY3oZSsNXNrdcAHS7Dc45l0EThIdeo7Y5d8OndcKe9BCF+uLShIJ5S+og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a2H1odTE; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748b4d5c045so2404622b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752265239; x=1752870039; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b7qTPqSZKgznYOOrcEeVLOwnEg+Rvzuj1rjCF+e4+H0=;
        b=a2H1odTEm3H7E4JOJ7SNLvOO6hUpbmL4Nq+6VZZUMu6LSUbG/fO4LTlGYqank6aV8n
         QO23KzOaFFH5sR681xYrZ/Aintb0zVMvlabewWcpLvCaSvIJIzgZfEi98fnSw94WMqB9
         TbZdFEtLABFA956dCpXos/MT20flo6YC3IMyOEafsiPMTwFH5RdT2+DLQ6XaYE11eCsn
         BvKkODpPUV89+0U+ND5Ewu3DaQznGBbH/iLcXr2fVSoxg53qX3X0v5LJXCBMctEyjr+d
         Y+g/eDZsFFEwlBga6yKBQODUvUQ7gqxEqMrkO6cc2RVivELwsMdNCc4Sl0UxzVGq1cwE
         D01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752265239; x=1752870039;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b7qTPqSZKgznYOOrcEeVLOwnEg+Rvzuj1rjCF+e4+H0=;
        b=Fdkt8OLYSscMT7d7jlTa5VepcqxPTVVmMqidhaC2orGOZQc79CUf+CqAv9QmidvINJ
         vjj1CcvT6/SJhKhyt9YvgCUVwVkTYw4Zr+P+3zipDVCgICQNB9MyUBefHSTGs8oX612Y
         11STaEXztcIQKzL8jorTCPg/UOV518pEFXT2HWM3RZiimGP10UT0hlTWCyxsr3cezgUO
         IULDyXmyR+ff3/uO3FFOM/+ccYuzobMs+5LS1XJ44FLN3dBte6XLjQq/zUZF8kWpDOCJ
         WY+Kf1F6a7Jxlnqp038jtMIO2hoa2gv9uCkvUIPST8IjPKotNowur8sxRIMxzx/mlAei
         wSlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvUJBYuRqYLInXKybG52MNYWxEaqtbiIHtFKWnZyZGrkDuWH+VIM78hG+DudeS14oywUxczGzx8O+liCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtt+fncfWAmZXwMG0lOB9uUP4WtFUz5aZtNeeqSXibdx+MO5JY
	RcDtuI734LeA4mv2vcYMAc1Es8/nc6B+VJg7Drz2QC10KslhzFmuvbFIktbzLfGmOrw1+7id36M
	RGPkU8w==
X-Google-Smtp-Source: AGHT+IFIqrP7jK/cjDCR7SM8TKcIRk17etqtWNnbv4GApH3TZfaWemB95AGSiBbYaq080RzIWmJYIBy0KGM=
X-Received: from pge19.prod.google.com ([2002:a05:6a02:2d13:b0:b2f:dfa3:cb81])
 (user=jthies job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c6cd:b0:21f:ff2a:af83
 with SMTP id adf61e73a8af0-231351481b7mr7503449637.15.1752265239088; Fri, 11
 Jul 2025 13:20:39 -0700 (PDT)
Date: Fri, 11 Jul 2025 20:20:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711202033.2201305-1-jthies@google.com>
Subject: [PATCH v1] usb: typec: ucsi: Add poll_cci operation to cros_ec_ucsi
From: Jameson Thies <jthies@google.com>
To: abhishekpandit@chromium.org, ukaszb@chromium.org, bleung@chromium.org, 
	heikki.krogerus@linux.intel.com
Cc: akuchynski@chromium.org, mattedavis@google.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	Jameson Thies <jthies@google.com>
Content-Type: text/plain; charset="UTF-8"

cros_ec_ucsi fails to allocate a UCSI instance in it's probe function
because it does not define all operations checked by ucsi_create.
Update cros_ec_ucsi operations to use the same function for read_cci
and poll_cci.

Signed-off-by: Jameson Thies <jthies@google.com>
---
 drivers/usb/typec/ucsi/cros_ec_ucsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/ucsi/cros_ec_ucsi.c b/drivers/usb/typec/ucsi/cros_ec_ucsi.c
index 4ec1c6d22310..eed2a7d0ebc6 100644
--- a/drivers/usb/typec/ucsi/cros_ec_ucsi.c
+++ b/drivers/usb/typec/ucsi/cros_ec_ucsi.c
@@ -137,6 +137,7 @@ static int cros_ucsi_sync_control(struct ucsi *ucsi, u64 cmd, u32 *cci,
 static const struct ucsi_operations cros_ucsi_ops = {
 	.read_version = cros_ucsi_read_version,
 	.read_cci = cros_ucsi_read_cci,
+	.poll_cci = cros_ucsi_read_cci,
 	.read_message_in = cros_ucsi_read_message_in,
 	.async_control = cros_ucsi_async_control,
 	.sync_control = cros_ucsi_sync_control,

base-commit: b4b4dbfa96dea8e299a47ef877eb0cfe210a7291
-- 
2.50.0.727.gbf7dc18ff4-goog


