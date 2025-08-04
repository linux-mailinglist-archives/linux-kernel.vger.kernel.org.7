Return-Path: <linux-kernel+bounces-754908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650A2B19E42
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB5247AC2D6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810E1242D6F;
	Mon,  4 Aug 2025 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FLGfp9lP"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC60253956
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 09:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754298287; cv=none; b=MWAq6VuPMig/pZK3HnNgZEzeRrOSKI/6ADqmcwaYQNkZi7Nugd/gb9b0x3xc3/hHgPGvfKAEip/9+SGtSnhY1pFm/tsiIKPgEjL3ZazAoP6jcMZXWrYbSIiCe9IuzlH+sxzrOU8VsJxnC79vkFaQxFq/lsB5b5xaDk/3TmO7XWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754298287; c=relaxed/simple;
	bh=VYWbWVA057Y0qPzEMkQr0mmrYKKhYX7GNZV3gzsbgLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iHZEXfDYJZmV7r7hJDhwHZ8ajmwtM+MmItZoLT5L9OZ61BMZhq/zksXmsPU/V4+ZDbDzcyBi/r3UtejCx+M7laMzn7+d9mR6V1l5SxIaseamcTI/LOXRr5OUFu8YyK3HyQPesAHmTPGFhrS1j7JJ+P7JdIUJxj1U2/puvQQgtJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FLGfp9lP; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61530559887so5301968a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 02:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754298284; x=1754903084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fCXGPTGTKW8fArN1je3Wq8jIm9fq53nnnBhW5Sy8xE=;
        b=FLGfp9lPS4bFipSLKlAX9qsUbEvWDk7NyOmrntSJ4t3MfVXdrrXEpLIk1l2xY4WqC+
         iKx/j4WBiUY9SbD9Sq60SwclvSr2lwkRRnHP5WsF8N/blpsMjlgRXaq1LP0nRzMxlpbf
         GPuNG3G/58XD1tgNp362Jd8CkPFwmneqyuP7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754298284; x=1754903084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fCXGPTGTKW8fArN1je3Wq8jIm9fq53nnnBhW5Sy8xE=;
        b=MpYlqllEl97ywnJa6x+SqWDM+AKKPE+82wHn1o83RM77kQm/fp7gm57I1pH4JhTRQ1
         J7shHVwdTQNXgVMoOIYVNJXdHCWH0UB8dQdVNigzSMd0zV6vM1SDh0fkaLWGrNCEAQ1Q
         5xxBRfEthmHtDERKZBXOJJChM1hXFoU21uhxpq/dMu5ckU3uMEheOSdzOGRv8ZUKwkYz
         tvVM57jEtkzBumjTvDBOZgXE/oYO41EC+MUdQikt5ceakjRkoQSnmv5qheRTPkYt2+ql
         vcClGdhASEa+D6PgwRDK4/Vp009MjHUsQqOhWIBRUadkG+AC9cB+vuAdLTL0m6QgyXJ4
         b32g==
X-Forwarded-Encrypted: i=1; AJvYcCUeIPhUsHwjIfjOM2MMXRLLUzPF8VmFFojQkZ4XM32nRMJL7NnPE5slJ+QrDWwjkZ0tlYl5Jmh+a3Haq7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyewsTBdt4+VK9OTCJk6Extgqf+mR7dfsm77DuXEcsKIxPBhOtK
	uFxEufsz0ZjbYkxq5VtteO23lv0Ttj2VsqlmfvoLUv7MR/p5jqN7o2+QMdzdTUsZiA==
X-Gm-Gg: ASbGnctt9ECa3tP1tLFSIkCIqnCoREpWDFItc5KXB5g3cxdslaBJPVIRMCka9OJAEeP
	MfAr6xa4PF/fTtKWxYAjzuxtSfnAcoSrP8gQ6xTtG6pCckOJ5T8ulCNcJoe+52lO0Llq98lnLb6
	yzSywBha/AQVj5nApdR3z2gzOzSTp+lwsY+b5+hBD6Z1mdaZOMcMSW5303yWSMdwzAHS9BPZ0E1
	UYcUkXx3rctzz/lmX1OcbqsmnwtlAjMCzKaEoy19Y1ckP6XAAqgjN91kN3scuC7P9F8nx2EQAyW
	V2xS9snrjNy3rfo5e3Pau5KmsgTfex/JosttdAbc7qRsd/pvbMvDaFtyrjEgqMInieJxkSKk98W
	xMtPuLeJOX7Hc+geYZrXAldtmejgo3wu9zxG5hVOsAkHeBue9Xj6WoDF1w8dr4wIYNv+GUtSnKJ
	hv0UONPb0bPXnrwxk=
X-Google-Smtp-Source: AGHT+IEahG0mX+I5PDgV3Sb0a4d6qhy92gyT+o8P9htq7Mc1BKgfiFsyNZ/upIlcaxMDJ6sg67zRFw==
X-Received: by 2002:a17:907:9690:b0:ae0:66e8:9ddb with SMTP id a640c23a62f3a-af94000dc4bmr1075715866b.19.1754298284566;
        Mon, 04 Aug 2025 02:04:44 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (150.230.32.34.bc.googleusercontent.com. [34.32.230.150])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe7995sm6412790a12.36.2025.08.04.02.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 02:04:43 -0700 (PDT)
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
Subject: [PATCH v3 09/10] platform/chrome: cros_ec_typec: Report USB4 entry status via callback
Date: Mon,  4 Aug 2025 09:03:38 +0000
Message-ID: <20250804090340.3062182-10-akuchynski@chromium.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250804090340.3062182-1-akuchynski@chromium.org>
References: <20250804090340.3062182-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Type-C mode selection logic requires feedback on the result of USB4
mode entry attempt. Call the `typec_mode_selection_usb4_complete()`
callback to provide this final success or failure status.

Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 73aa25433a50..5a3d393c26ee 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -781,6 +781,7 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 
 	if (port->mux_flags & USB_PD_MUX_USB4_ENABLED) {
 		ret = cros_typec_enable_usb4(typec, port_num, pd_ctrl);
+		typec_mode_selection_usb4_complete(port->partner, ret);
 	} else if (port->mux_flags & USB_PD_MUX_TBT_COMPAT_ENABLED) {
 		ret = cros_typec_enable_tbt(typec, port_num, pd_ctrl);
 		cros_typec_tbt_status_update(
-- 
2.50.1.565.gc32cd1483b-goog


