Return-Path: <linux-kernel+bounces-887597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C03C38AD2
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 02:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A953B0D87
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 01:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863CC1F0991;
	Thu,  6 Nov 2025 01:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mg6b+Jal"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AA91E32D3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 01:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762391692; cv=none; b=mgZX2koYUofGuAELQxsLuCHV4jQ/ZZweGeOuIJQBmTfXOsUCNp5ubtCkJl4qooJ4b1TeqBurk/um1OmQhXXpesnptdnBy7lc4ObS6oNoFp+tOEOPfMFCPuclAJD9ITe0KILOlzl5arL++YZER0ng/YuXB3xp/7boxC9POvvpSSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762391692; c=relaxed/simple;
	bh=GqiSEFjJpS60vknr4o7YkvEXtHCaMxx+InwVSzChCtY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JAfBP545or282kuZDNCuNzhNqw5Ors3901dAbS2+9D3MDXzrEsRwRfRWf0RYeoOP/A5VpQHEW8ai1o8B+k33dMngIq1XIRtN7yAScfWiCaX5fSjX0o45Q4Y09kw0RukTkOVLSTHYlsMZV+yQZBAd3Q1lEJ+cWJiFuIn42LkxZ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mg6b+Jal; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b62da7602a0so372725a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 17:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762391690; x=1762996490; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=39ivioua6pnMjSf3oDat2VB6KzK+NMcakhy3huJbtbA=;
        b=Mg6b+JalVoK55gYj7KWr+vHIEhRFW2jczU3YZQZolgfaOLStelq/+gu4wcgCvewRXm
         F00O6SsG9rH8E938T3kWelwnzji4ohv5qywMuVeSzwLfC/kzvngQrh34NB7C+PQ++WJP
         i5zSY88fIhyUaqwc3HzZ56TIywyegbbl7ixUqOAE9nN+SZkqUsP/WnSAvF/50yoSnD/r
         2KotY7vI62JCNhWUZ25mSoJs/MKvB10jV7JF3OnurzNPSRtdkZB1q/7417zGh9E2yyIm
         6XKGFNUMmLdrJIh2fcWdcjhX+EYJ5VMJoZDh6uBHr2Mx6BfWTb1xrTBn3NvdVVrVN4kS
         JIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762391690; x=1762996490;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=39ivioua6pnMjSf3oDat2VB6KzK+NMcakhy3huJbtbA=;
        b=X+Zswsuz7RT6ULCMnY5+sTYO9pJZPwGqfnB1hvLmRROriRZ3j/BfCmrZwYN6YWt4lr
         w4Ou+55ChJnvwEB5hfPLmIrF3gqm7kXFyLKPuRmBxGxNwEzNZf584W1MVDjCpb3lNon9
         YFGYIMTn7UCGM9TTYWjeCdRbiKuQjtyPycs+nONPnXFV0g/pDvkUsRJQQMUzCu9SWvZn
         BIEams5MwjrvInpCHdCgKwGB5YYlANEy3e7rzJzesFYPV9Dy2VENHEt8Eak92/PS19O0
         qGhhWyuzSq+q3bNlHEgsTxnOPXLstBUiPZhhflLVultPuW2kLoteCr5X1u/mBnLrebvd
         qNXA==
X-Forwarded-Encrypted: i=1; AJvYcCXRrboAZRJqBRPVV1difM+aNG7oXaiYVbIx5FoA1RLb1pOdd0qKfpKoNKW06laeHSSw3vBC31F8IM22NVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQAaFRxLDOA+Tz8cJGt1kd7+ZDGNmWnqNxAxncEluU3DvuHzyv
	6nq7uGdZAIVN15+zuVoOQ1y3XicxMJHZDE+bw2EJkZz8KuKDc2o3RQQo/psmnK0GScjcc4uNDvB
	//tWo0A==
X-Google-Smtp-Source: AGHT+IGHknY9aqu1w+W4IBmjhbnbPVtNg3MS81ewEb5IJ6RCNy2Yl/JqwF6vF+FFSuv2t1tS8YOwfKaj34E=
X-Received: from dlbqc8.prod.google.com ([2002:a05:7023:a88:b0:119:49ca:6ba4])
 (user=jthies job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d8e:b0:343:68f2:3728
 with SMTP id adf61e73a8af0-34f83f06e42mr7119443637.15.1762391689940; Wed, 05
 Nov 2025 17:14:49 -0800 (PST)
Date: Thu,  6 Nov 2025 01:14:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106011446.2052583-1-jthies@google.com>
Subject: [PATCH v3] usb: typec: ucsi: psy: Set max current to zero when disconnected
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org, 
	gregkh@linuxfoundation.org, akuchynski@chromium.org, 
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com, kenny@panix.com, 
	linux-pm@vger.kernel.org, stable@vger.kernel.org, 
	Jameson Thies <jthies@google.com>
Content-Type: text/plain; charset="UTF-8"

The ucsi_psy_get_current_max function defaults to 0.1A when it is not
clear how much current the partner device can support. But this does
not check the port is connected, and will report 0.1A max current when
nothing is connected. Update ucsi_psy_get_current_max to report 0A when
there is no connection.

Fixes: af833e7f7db3 ("usb: typec: ucsi: psy: Set current max to 100mA for BC 1.2 and Default")
Cc: stable@vger.kernel.org
Signed-off-by: Jameson Thies <jthies@google.com>
Reviewed-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Tested-by: Kenneth R. Crudup <kenny@panix.com>
---

v3 changes:
- change log moved under "--"

v2 changes:
 - added cc stable tag to commit message

 drivers/usb/typec/ucsi/psy.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
index 2b0225821502..3abe9370ffaa 100644
--- a/drivers/usb/typec/ucsi/psy.c
+++ b/drivers/usb/typec/ucsi/psy.c
@@ -169,6 +169,11 @@ static int ucsi_psy_get_current_max(struct ucsi_connector *con,
 {
 	u32 pdo;
 
+	if (!UCSI_CONSTAT(con, CONNECTED)) {
+		val->intval = 0;
+		return 0;
+	}
+
 	switch (UCSI_CONSTAT(con, PWR_OPMODE)) {
 	case UCSI_CONSTAT_PWR_OPMODE_PD:
 		if (con->num_pdos > 0) {

base-commit: 18514fd70ea4ca9de137bb3bceeac1bac4bcad75
-- 
2.51.2.1041.gc1ab5b90ca-goog


