Return-Path: <linux-kernel+bounces-769478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA6CB26F32
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31B13B8117C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1783529D267;
	Thu, 14 Aug 2025 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JtFmhMsV"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB25F239E9D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755197106; cv=none; b=N2NTeg4V59Qt4CZ3nIaik80JNQfduSgYVI3A3cY/pJrFTwZbMUnoNtWh9TrlM84p/A8T0NYS8wfDa6vA9CWLABtNDBbct5wfyqPMikE7sHemmMwzE5i+jR22ZNXKNyl9qgC97xybyluz+uaTpv4/Tx7nSMS+sK2pgbwZI05AbNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755197106; c=relaxed/simple;
	bh=E3gkZiMJy3Qekd4+VwlRIk3WdC/Pz+bTehDrLOXH3ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dtxtx2sx4LzVEQ5ib3Ns0wGosz5wXKopn0GrPnrVE/E/Qq6Z6wcNoyb//w1F/xXSF4emtLHKJvtsTJBKSD+t2TOK7oVbUCivvu9gVnVpGb4B2BkCEEv8aEqFYH3+98suIsgCPxbZhefFAlZGpfWS56F+6ka8zcCBh+6+3MpXCx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JtFmhMsV; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb79f659aso196493166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755197103; x=1755801903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuaFAn8mD8lF/OW0DQcqSD5HNRrV4Il3w/RtqwKWzZ4=;
        b=JtFmhMsVn0wR42xfLk5wFPhpavl/Fqp1ZzbQqgJOtOx+PL9kwc33Izqekd+RyMsl4f
         +8/LK47jDfM5pJWgD6Rr7KJLekE64dmJ9HLRQ/dEPQo6NAufD1Y4tGrqnvl/UZbtK65R
         yB2e1bY/L35fVCJKH/A4Bef1N64KZusOCY3SU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755197103; x=1755801903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuaFAn8mD8lF/OW0DQcqSD5HNRrV4Il3w/RtqwKWzZ4=;
        b=UyYL38Zj1nawxkiN1eGjyHEAjbRo5AlLBK1DRCQxLUwJr9gr0dGp4la6f0PCp9fVoO
         2+Vr5K+owOSSbMnB44SAZuZ+gsI5p/EP6nIZtVzCYl8L9uw4sWN+KWwIh2/RTX83vee9
         5mGol1gNygudAES8kHMcCIDidpkuGjmClxtNkB8U8i4D5zEowiUH0n4/lxWddrPzPjt8
         hHcVlmnb50ydNshkJod+TpvVnObVFwS6EmwJalV/wQ/xTssVs8I7SBull2wdRqrOCvOr
         bWGqW9CaFHwxXvFExli20UUVvcrddS/FtA7TC2cHZdsKJay2Imz6KCADaiaDNcfX2Wwg
         33kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcAOp9ZKcgopMWjheXi28dtSbZEVMwTayzJXw9W9Y2MfIT2BcuBzI/UBU9t1pUyEW5NVt3LHEZ1cFoKzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOkRR5ntLPJANd277zCH0z/VEhlSifNr095KOzBcVnawPbU2zl
	heoK6Iy1Ju8Mb/Dzvn4TSMoUcyev2q7s2ZsO3QMvXNSc9e9jrU25vrtcTTEGx13/yw==
X-Gm-Gg: ASbGncvyfnd5ki1dDTTW+p5x2bE2Irfj1dQrE86ls/OUmxdjgoBtEevmv+BhZ6a9h+h
	8GyHeRur4r+y/YebWP4WTsSkODkLUKs2vESh6RFDnV5UZJWd7OfGPRMmISLCzWauGZsSOXxXExq
	uk0mgrEUq9AZ1QsFaw2TgLmVdaRWzXIys4BIJCEYKoQlqKM0FwRwwdjeaiBLpYgCIPf0Uh6iukh
	BiZeP6TUNhtuQPf6rAPSMFvwmXtVWrMlo/RCZAwU7d+lJH44AMX4lt531B28xJi5pCY03QmClL9
	lMEjbMqvDNzRnbeMtS/eQFMbf0SkDtA0akrVJhzmW5SDs6y0Z/G0TDhqvYdQ0lHLJQvsi3zha5n
	t3vkwMY1bnhcD0bzSNcii3uwCaQjJ1HKghNrDsuNiMTTHj262suOKldNKk5AQOZ7HP7XwMTJryI
	BYIYjaGb1u7QLPSUlhc7+ptR0=
X-Google-Smtp-Source: AGHT+IEqCZJqh3teh+GhByw+v1VIC6n/AQos6jbLx57TxiI9cPnPVwtbFarEeGQNwPBfnwrymbSlRw==
X-Received: by 2002:a17:907:97d0:b0:af9:2bb9:ea36 with SMTP id a640c23a62f3a-afcb9395356mr407563366b.7.1755197103114;
        Thu, 14 Aug 2025 11:45:03 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (37.247.91.34.bc.googleusercontent.com. [34.91.247.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c0f4sm2614772466b.106.2025.08.14.11.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 11:45:02 -0700 (PDT)
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
Subject: [PATCH v1 2/5] platform/chrome: cros_ec_typec: Set alt_mode_override flag
Date: Thu, 14 Aug 2025 18:44:52 +0000
Message-ID: <20250814184455.723170-3-akuchynski@chromium.org>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
In-Reply-To: <20250814184455.723170-1-akuchynski@chromium.org>
References: <20250814184455.723170-1-akuchynski@chromium.org>
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
index b712bcff6fb2..99f549263c37 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -491,6 +491,7 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 
 		cap->driver_data = cros_port;
 		cap->ops = &cros_typec_usb_mode_ops;
+		cap->alt_mode_override = typec->ap_driven_altmode;
 
 		cros_port->port = typec_register_port(dev, cap);
 		if (IS_ERR(cros_port->port)) {
-- 
2.51.0.rc0.215.g125493bb4a-goog


