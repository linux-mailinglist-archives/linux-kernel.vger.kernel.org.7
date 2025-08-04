Return-Path: <linux-kernel+bounces-754909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5B4B19E47
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DCFD165B3B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA09256C6C;
	Mon,  4 Aug 2025 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xg4tAtW7"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1933D2550A3
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754298290; cv=none; b=cQKrgFVN5f/uZ5bEf2812xhZPrVmg8s5PSvPD2LYWVysOtswE4nJ2cAbLmFviIh1/5vc4a1IzSmZTeiFduoo8Ykvv1rghjLHv+erOtPLIgLTsrs5/Yb+psh6pe2g8Tl1Y5Ex0+1jYaR1KtcVWnF87vHPDzFjbL9OTnPDi5hEd1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754298290; c=relaxed/simple;
	bh=3x19bC4TEkjCbZhfuYqU5c/VjurC/2Z6kwyVqMzBqdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9AGYdyFchSrlokLdYMCLsp4hMf4o+864D3Vm2kWKkASr78rTq5sd+4oSmQrhfYbcrhw+8SyRlxDdXujTrZ5qGnFsKBmQjhW/mAInw+8tuuTxggUoXzc0e1oQVRx7fJp87/Am73w5PUKr1jm1P9sVxhOrjmFKPz0XGnX3hzJRwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xg4tAtW7; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so7303920a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 02:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754298287; x=1754903087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnQpTwABThBxdUskT3LdV6JNdqJ4VQSfDvVtzabNNUU=;
        b=Xg4tAtW7xI5NriBCXr/EdjYAbEtUfVMZ2+Qf9K+XZt8Iin1MVlmenKAaFiPkbbczgg
         5nMpBLjUSxSvkgJF1tWRiwhQ4yIWmVG4sb5wU7nCWcRNeffEH8NQL4AK3RhVg73PdOXD
         AZO778+w8MLZJ4+3SPDV2uLLWECf3YYeVOLK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754298287; x=1754903087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnQpTwABThBxdUskT3LdV6JNdqJ4VQSfDvVtzabNNUU=;
        b=w2+FoExLI5RpslfHm0K63VrBWejdRRXTkTDkm8EPtMfuOzSHOnjWEn4FwvFJ+GK+Ir
         eN6+RP6CX7PNAfCfVzSDglP9Q6q9pZIcoaLU4Rb/n/i5OEYPc1xJbqYDloFnnSyNjVTv
         cH+ro5lEHMPEpPWeTVeIaiIRR2G1K/A22rK8cUOGZ1SSGGpdZQ/fnW8rprBy6C/N+OwJ
         X7jxOr5hubq36+Mviu1Pr4wPf+FD3etlQD03sJTuQrA6wskEDTSHk5FclGQMeXqT11dQ
         jxD2tNxNpQbIynRSQXLy9/viCBca9JhmTbMpFnZ3i60ThfssF3jRoVVeMWY9L6cUhZIX
         VywA==
X-Forwarded-Encrypted: i=1; AJvYcCVrw0KB+w5itcSbRjsRYQMg1/WLjzdJ1jpibF0qGYUOvcsadLmytzpwLgcMmdrzACvImCuHshk/5s4IggM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSb+KmMKR/yq+Dkcglbqzqi1W006d1+l6o/z9J5/A7rPXoanBu
	ONLe/WjrHSE0ymp+/HaqxChj4EMsm3dAuUxkp8i1Y1UC6XGkF8exixGAM/42DWPz9w==
X-Gm-Gg: ASbGncuy6O6agUb0PQYWItvlcZTvLQBrebD1k+DBAhSUbYJ2bag2gZZF9npNJAZ36D3
	9JyeT1vvaO7rgyclHjq6eZysJvrh/RDuKWrFWPuOe+nVGXl/2UN9I+dP4197iRC3caZVO8S1olg
	SlH06g+ujWCg8aKpOYzjaVNpfgbEHnMK4TWXHzb9c4PLCoptolmlH9rEduJdizxGxdBwAvvt3AM
	B8VCpWPoaB8c+N9AoFM4deKjbgmzlTA8RuqjkUCUI9errp8NEPCY9aL5ppvcIikvq3WCn7BSs1H
	FiROZE7kRKnypEqMaM+BAanUO/IkJRco+KVN5H6XLCIfFjLlWOiGtz0SvjMxUZVCurvGlzWhH4q
	YGCnuYAaf1KYv2YnnSt+2KT0/Gc9dVyArKkvDLJupXyFwFGXie+vvPpzKsVANi7ZoW75osv2hro
	fqP2Xd1aS5WqLJTltBLs4J9sOOVQ==
X-Google-Smtp-Source: AGHT+IHrHxXdeaPG9B8IlHKEHEVk1KBLXqnoXcB8NheI8LMoc58AFyO+W+Fv2Eq44g8cl/NgunqeAg==
X-Received: by 2002:a05:6402:3788:b0:615:38e6:b739 with SMTP id 4fb4d7f45d1cf-615e6ed456fmr7575534a12.10.1754298287331;
        Mon, 04 Aug 2025 02:04:47 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (150.230.32.34.bc.googleusercontent.com. [34.32.230.150])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe7995sm6412790a12.36.2025.08.04.02.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 02:04:46 -0700 (PDT)
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
Subject: [PATCH v3 10/10] platform/chrome: cros_ec_typec: Add default_usb_mode_set support
Date: Mon,  4 Aug 2025 09:03:39 +0000
Message-ID: <20250804090340.3062182-11-akuchynski@chromium.org>
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

The `cros_ec_typec` driver currently doesn't directly consume a default
USB mode value. This commit adds the `default_usb_mode_set` function,
enabling the `usb_capability` sysfs attribute to be writable.
This functionality allows users to dynamically activate or deactivate
USB4 mode on a given port.

Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 5a3d393c26ee..9bfe78e315fc 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -44,6 +44,11 @@ static void cros_typec_role_switch_quirk(struct fwnode_handle *fwnode)
 #endif
 }
 
+static int cros_typec_default_usb_mode_set(struct typec_port *port, enum usb_mode mode)
+{
+	return 0;
+}
+
 static int cros_typec_enter_usb_mode(struct typec_port *tc_port, enum usb_mode mode)
 {
 	struct cros_typec_port *port = typec_get_drvdata(tc_port);
@@ -140,6 +145,7 @@ static int cros_typec_pr_swap(struct typec_port *port, enum typec_role role)
 }
 
 static const struct typec_operations cros_typec_usb_mode_ops = {
+	.default_usb_mode_set = cros_typec_default_usb_mode_set,
 	.enter_usb_mode = cros_typec_enter_usb_mode,
 	.dr_set = cros_typec_dr_swap,
 	.pr_set = cros_typec_pr_swap,
-- 
2.50.1.565.gc32cd1483b-goog


