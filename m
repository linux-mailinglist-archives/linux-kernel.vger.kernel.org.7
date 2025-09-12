Return-Path: <linux-kernel+bounces-814068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6396B54EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845E47C67FD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DF3305077;
	Fri, 12 Sep 2025 13:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="E8abxVX9"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025D8303CB0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682682; cv=none; b=X2/Z5I1VgJRAlF+SGJpWnypqiQPcdW6ZMkSG5eEQrsEde7Vz2czu/X8EGkdWeyOxC4OokRN7KUiyktn7yh2KwGBhRsVIlZhL6R69TqG9zQBw+oBu43uLmINjah/fdX2MB87rggD6Vkf9sjb2X35uKWyH+FmgfNzUsVIlDP/nx94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682682; c=relaxed/simple;
	bh=h6+naf7ZQX6/kGa0qjbJnJkaPWtpHQCnJ2h1m8d6Gic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=spKTmfG7hG2MveUb4IsnpvJyWTdtRtrdqUP5cllG2djho9Ugbt8YfiBYSwxur9JTG5gfvNMQZ0W3jlTaZe0qhtMA3sAMF0cT9nJbk8aEkN5ug01CfghbUtpO213ntEAx1NvVwtlCORI3EULQVuvHKcrAxoSDwDXEtJ6jz12QhgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=E8abxVX9; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7761578340dso765752b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1757682680; x=1758287480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5lYJndhwGZVcx3e86xFchJKHdcqwz922OhwJ5EumsKA=;
        b=E8abxVX94tZE0gH2ghEFzVCqTUmnyFfhQM51NO5m5uNLvgagXTzEJmfGeeNthqp1us
         P7gcWC/xeViC1Byy2XGpFje4qlZmenP/eDhTvBu9vexkIocskm4CuKT0As82fq/9DJm7
         3SLdMWXWmpcI/tQ2NaiFdqt36bICzJCi7ZptIidC2li977WoM9eN5j/GOyAQUWxgwq4j
         x2SeTcWogn2NZiJKhR3RPvLt7m2DuUKebvarNEBXOFn0MeH5umS/dT75lm2E3gl3Tozf
         UARgnJyl9JItJTueZ3Aeur4BzI0dMw8JGrTBx8pIC0UGjLqaR7RBXwMmRKiKC9/gj6wJ
         Yl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757682680; x=1758287480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5lYJndhwGZVcx3e86xFchJKHdcqwz922OhwJ5EumsKA=;
        b=aJ703hmEjTsp2+mrbi4o9/FcY0RP5pWhYiZvg9WddCzixHMKIOs++jGKDUNp/Zh/Hm
         xUDGtOqkwTMCWq8TFW28INLnixVbQTDqfGUOTQv6Y/wmIuebznNWShaeo6Hta3hdqgXb
         zRSJwWl5DmJ71QQJxTlw5rkaHQZTawCiU7fWrMQMRAUUZA+OMytbTBMnXcvHrovjEKdL
         Wxr6a11jgx6y/wLKFBm0NuNHS7VknbchMH8AqaDXQh0O/Q1wb0gq+4CHFq0vHGXxp3pg
         ovp2W06IlBnOZyGy0pA1J+VHypkrz/EFI2wJhDvDastBKRlBNbRrF+wqAnLWKabr5Jbq
         WwaA==
X-Forwarded-Encrypted: i=1; AJvYcCXBbSWUeKFnbQPEz4WPbEIZ/42mu3hTfAYrjm1gEO457dYNtpBpcupyoithLhsxuY9I3m5eS/M4HSEKmt0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2+CYss0/0w3/6laTNAvL3xRu89fFg5lFKnkVfWI1asHrrTp2k
	nbgYU71Ixo8a0DGK7ZCZ7MrL2+FtjfYVTDq2rAOli7ym9aARjlPkwW+VHtmovUChk9Q=
X-Gm-Gg: ASbGnctLum/fuN6AxjlsPys/ZWi8SH1n3GavO7q0dutU9dSjNx0uYJuSQ5LOZwC1+82
	cvam5Ad7UpKKMAH9F0EtHIe3PFdetJQAyIVACYAw+PPA360J0Q+/Vr/liBAE2ClIKVS5Y6yZlpv
	W+h4+EKyI8UgfneoEvsNFH4uXzSLe548jQqzJ8Rzm5+SRKQJGGhvDnOVRlxaQh/SczNa2qt2gBN
	3ivTGrLe+uwhb0gESVxRI5PXhAL7WdhdDF8RofMOq1e+W1AKgZM1AXYbhFVSmppBqHAqNqyNDPO
	AihSXVk3QQC/KM/mqbYwDuZGAva2E5fMQW1GnJTPl+qZJOGHV1L09sw6dknSU9OiUzQvkWOosZL
	dod8J3cIvMkhBIZP4OokK93CWQo698dzeMXCu2twc372lfK8Ao7jbLMsN06I=
X-Google-Smtp-Source: AGHT+IFEAfQaJvImfeU+Sk332OoSdcbRzDlcnv9+uIupkz35lfqKRBWb80cXg6os9Y5lTDSczShf6Q==
X-Received: by 2002:a05:6a20:4321:b0:251:da24:9435 with SMTP id adf61e73a8af0-2602c91053dmr4105496637.52.1757682680347;
        Fri, 12 Sep 2025 06:11:20 -0700 (PDT)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a3a9e25bsm4724864a12.47.2025.09.12.06.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 06:11:19 -0700 (PDT)
From: Zhijian Yan <yanzhijian@huaqin.corp-partner.google.com>
To: sam@ravnborg.org,
	neil.armstrong@linaro.org,
	daniel@ffwll.ch,
	dianders@google.com,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhijian Yan <yanzhijian@huaqin.corp-partner.google.com>
Subject: [PATCH] drm/panel: add support for KD116N3730A07
Date: Fri, 12 Sep 2025 21:11:04 +0800
Message-ID: <20250912131104.1726775-1-yanzhijian@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Zhijian Yan <yanzhijian@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 62435e3cd9f4..2c8536c64c19 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2046,6 +2046,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('K', 'D', 'B', 0x1212, &delay_200_500_e50, "KD116N0930A16"),
 	EDP_PANEL_ENTRY('K', 'D', 'B', 0x1707, &delay_200_150_e50, "KD116N2130B12"),
 
+	EDP_PANEL_ENTRY('K', 'D', 'C', 0x0110, &delay_200_500_e50, "KD116N3730A07"),
 	EDP_PANEL_ENTRY('K', 'D', 'C', 0x044f, &delay_200_500_e50, "KD116N9-30NH-F3"),
 	EDP_PANEL_ENTRY('K', 'D', 'C', 0x05f1, &delay_200_500_e80_d50, "KD116N5-30NV-G7"),
 	EDP_PANEL_ENTRY('K', 'D', 'C', 0x0809, &delay_200_500_e50, "KD116N2930A15"),
-- 
2.48.1


