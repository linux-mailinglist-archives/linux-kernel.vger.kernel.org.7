Return-Path: <linux-kernel+bounces-746954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB4FB12D98
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 04:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519B04A252B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 02:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4052C17A2E3;
	Sun, 27 Jul 2025 02:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6xVvedw"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F229218E20
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 02:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753583454; cv=none; b=bA5LVkX+jh9eyPyXZOpjnZA3syptXi04/mq7YwN5q5XMAh9V0nNEY9iWsEEmbAzf0Dc1uc/hDlE42Clu9rpD/cLnsVc4+K83M9olfclPa01Yx7IoBzE+gIPF+T7HtTMnmR/pOkfJwd2HyfE+cC6b95qQclDXV5A/0TCpN88gHPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753583454; c=relaxed/simple;
	bh=kQweJYy4vULjalqnzjhGTzZNtDQh9Q3p15qFBCqFvv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eN6kr4uV1DrdzDAV40d4iMRvxlakSXENANPgYfRAWrNF8eUvqbRv/xB0W5Fs4Lg8tcr4sKHPYYK5TpfIPfac46oJbhobg/QtcoYwflRkxbiCNYlPN45LECR2VjuiJgSUZOfe53QZDbt45apQTeOqZdNwdo58tKBQXBjuBYlh9aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6xVvedw; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b391ca6146eso2983773a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 19:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753583452; x=1754188252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mtmsfby4tiJfC8lHKr99gD4KyJGKPH4a+yc4eRxlOA4=;
        b=C6xVvedw/GWGnJpXQ/zEJY6q9LPLf7hdYH7OtrL9mHIr7aDt+OSEdqzB/0FQ+g+qt2
         6ioHJgkTBa3Dn+y1fqbMG6U68SzuAF+Lsx0EljtX6Z/63kgMQiB+3U9vZW39sIRfbG9l
         JszF46n78LIL89hw7a1I/px6sOF1US+G5w5uwXmPhoqZedbhpTZtq13BEkw5TlSMGEof
         XilZr5BlqWw+rAgF4wxXbSxM3NAglXlIeRMNoQJdWzBxiGLHhY7edNYk1WdRS10dxVjf
         CcAZDsA4L6cnUhKSLNBF+8ZdJFR1VE2zdQXDq6POcu3vh5doPAW+zkqVW7EMwQ7jsOz3
         ZVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753583452; x=1754188252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mtmsfby4tiJfC8lHKr99gD4KyJGKPH4a+yc4eRxlOA4=;
        b=A6QxtTvuM7J1PNkIPtNpk3hs5uQ0ZYUu3RSVASSpdjClqoN32y29SJ2pFIgAYxNVop
         E8Mtnlx6521AWLNCGLkpkmfK9jGe1mp7fpzUDWtSiFWQ2G/UU6100Y+7piXng4nf8CMs
         hOfdDNt5QxVc119+hKpSjZZWa1/wTtZYSZOLIsWP/SsHeMoEaDINFYVdfFZkfh1mmJgv
         vXXzBcpjvHrVs7tIkcgN6A4Mu2eb5TlZtDhEO0V1Yd1j6KhHVGuxzcFzIexuy8SFbX1a
         YTJQDNnj/hX0eKvaPWfkHnnUdHKt20M1cE+L0ZqSeG2gIQu1XKp54uR/cZF44r3pGz8I
         fcPA==
X-Gm-Message-State: AOJu0YxRcyNtNtaU3oNEdBJvzYrj0OGIroktVDMbPzuyZy5lp/QpR0gt
	O3FcqAoyjY0TZOWpzOrIw/qOKKVXOfio1HnAYo1rN9ceyJUD1NHqWTczEKtQL16u
X-Gm-Gg: ASbGncu2wbrBCYr4I1wOUzYTDC/wP4sDRGYCfyAwNDEH8xuBo43cfA9JagKOzpNIeu7
	uTKCBskxuHiwOcRO9eeSfXVkWnzK0NZ/KHHbIabth3EqSvhM0PzYMbbC6p5QSD/NXRAWXBhINkn
	u6njnJS8BFPUa3IFabDph2fEORHTsENJXLDcqwqPaLcU0iN02RASyplh4Kll4OBB5AfEoSjpZU+
	NpIBh7xt9CFT1nOEA8CdjMwOyuimyCPU0YsQ1EVEJUZ0TLx5ag8F+Jm6cSRLugOyZKyRy6YMpKt
	wqLnGf1L/VlpGLszFU9rCN4ANQhj05IYj545Idvjqy/5F2Wm54i47NADYU5OEbtBjilytNNoG6A
	J9iBnZSYNl25FDS8RKiUSSiZAsKvNOcowncb3Pv4SGCrF1ouS/6WnqCqf4+u2WUwKmzY=
X-Google-Smtp-Source: AGHT+IFm9TQyftGBhuFI57PxigPwEj3lx08w9AfjGPOu3+pNrouUPAZ7pFCgsdGb6IPcMjH7+DiEXQ==
X-Received: by 2002:a05:6a20:7f8a:b0:233:14ec:4f83 with SMTP id adf61e73a8af0-23d6ffe8db9mr11312989637.6.1753583451737;
        Sat, 26 Jul 2025 19:30:51 -0700 (PDT)
Received: from fedora (181-162-135-125.baf.movistar.cl. [181.162.135.125])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f58bc0fsm2334638a12.15.2025.07.26.19.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 19:30:51 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ignacio Pena <ignacio.pena87@gmail.com>
Subject: [PATCH] drivers/gpu/drm: Fix typo 'isnt' -> 'isn't'
Date: Sat, 26 Jul 2025 22:30:56 -0400
Message-ID: <20250727023056.82391-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake.

No functional change.

Signed-off-by: Ignacio Pena <ignacio.pena87@gmail.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index c587b3441..1584c13ba 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -4061,7 +4061,7 @@ struct dmub_cmd_replay_copy_settings_data {
 	uint8_t aux_inst;
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which psr_state to use
+	 * Panel isn'tance to identify which psr_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4144,7 +4144,7 @@ struct dmub_rb_cmd_replay_enable_data {
 	uint8_t enable;
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel isn'tance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4192,7 +4192,7 @@ struct dmub_rb_cmd_replay_enable {
 struct dmub_cmd_replay_set_power_opt_data {
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel isn'tance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4212,7 +4212,7 @@ struct dmub_cmd_replay_set_power_opt_data {
 struct dmub_cmd_replay_set_timing_sync_data {
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel isn'tance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4232,7 +4232,7 @@ struct dmub_cmd_replay_set_timing_sync_data {
 struct dmub_cmd_replay_set_pseudo_vtotal {
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel isn'tance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4248,7 +4248,7 @@ struct dmub_cmd_replay_set_pseudo_vtotal {
 struct dmub_cmd_replay_disabled_adaptive_sync_sdp_data {
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel isn'tance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4262,7 +4262,7 @@ struct dmub_cmd_replay_disabled_adaptive_sync_sdp_data {
 struct dmub_cmd_replay_set_general_cmd_data {
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel isn'tance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4308,7 +4308,7 @@ struct dmub_cmd_replay_set_coasting_vtotal_data {
 	uint8_t cmd_version;
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel isn'tance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4416,7 +4416,7 @@ struct dmub_rb_cmd_replay_set_general_cmd {
 struct dmub_cmd_replay_frameupdate_timer_data {
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel isn'tance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4449,7 +4449,7 @@ struct dmub_rb_cmd_replay_set_frameupdate_timer {
 union dmub_replay_cmd_set {
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel isn'tance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
-- 
2.50.1


