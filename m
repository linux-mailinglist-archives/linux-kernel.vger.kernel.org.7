Return-Path: <linux-kernel+bounces-872827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F0BC12202
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 01:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971941A25B27
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982401EC01B;
	Tue, 28 Oct 2025 00:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWVGCeLX"
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC4635940
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761609625; cv=none; b=YTqlAUb2R66H0v7g4fnfYQiTnpa2nmOFcL2GOOarQs3sKd5m1OSquNC/qmj1YSGSqjJZd2EGdnDKH2d9XM2FJRJsgNsRwFGR5UpWfjvDeQwhutN42x5rIYhoJHIAZi5I6FO2fxx4vUSQOTWEcIdq/UqGP5Opa/c4WcWvBSodMeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761609625; c=relaxed/simple;
	bh=bcETCkepaF74e7lPUMskBIH6KkDLfN5id3lvNhxFZ9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/npJ0UDjeDVfkwW8sTdZeJ9JQ+yOmgA+yhKsnHgd447ojkrOFSfBMrfiJWNZqdsI5VNz4eAfZPzmV1BMJWVzH9fJkvPhbsCANBgzQMEv/l0WMzRGE6+eTqZuJDw1XLF8s/SRG/BRkVsA8977zzJ3kJmiS0Abcqdz1UKvJCYUzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWVGCeLX; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63e16fbdd50so5005185d50.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761609623; x=1762214423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hXmhTJZAlfrfDbx5/TiDoR6puyEL1cB+IP+R3Vobds=;
        b=LWVGCeLXfF1jJPfpWH9nlwfD9/8dVFUUr0vaLTfLZb1ouBFs2JGsaiVG10UN/7B/WJ
         xJjm5DLAL7GSZIxNCF8jfs4G4axwLR8/sRkxR7SXnwxAEggqpphSt5pzZXFUyMK5DBL2
         GjTFZX9ISxEa7T7oO9DcCtHbbU01DM9WwkTiVf7TXSbqLTyUKYZQTnbTuj3JAcKjYnZf
         0XbCBDh61zkQM4Kaigkxa9zPziq+UELBy2zTcWb8VpanuKmRUAk1Dm+fbsuayJRXBIRD
         jhumMlpM/pZ3KDJgL3nyxWosUYF+81JzvVrRYWm0CIzq+APir7pFhH/Pf7xSIeZKUk/P
         gT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761609623; x=1762214423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hXmhTJZAlfrfDbx5/TiDoR6puyEL1cB+IP+R3Vobds=;
        b=irpMbla45FQYmfSNNEqDYpPguJ7kAgqS0wmXHEnj5X5iEDfpultaF32ZTE5QUkbJcX
         ZPt6ly1GO6JLupdhCRNfCRzISOk/M22zj4mwPNf+Q1Iuz3NAwJs/7z2r+648djLCMN1F
         w7tSDRQzae3UxS0p2jidc82FsgGOIjFVrrrdHGVZkHnFwYSax8tfosQ3U5w1E0p41jDG
         FlMuxuniOoP6r7SbS5h5JWxrrBMLijbjKLK7LIhZygp5prhY2CtfXTk0XvHpKR/vQqgk
         AX541L7qGV5gx2AEm/5OrF7TvaMXQfg3eOl5NjPgPfeahau4sEECm41YuOhtQEjYjJ38
         0PaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMong6fZh7DHONBdqM1kDQ52D3z06ytZLBWzqbSzLxYXRxvvhhz8MHCfW5DHlZTL5t3k8dhkXEiVOigOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEdrZVWI99+3Gm5H1gYP+3Z2KGl12gmCDb9Vg3SwVAIIQkE6m6
	cH/xA4Dsk1YzHV2+EDKwwoihqQGq8ovr7QQ2e0HYW+hCrm2f1mJGNBTh
X-Gm-Gg: ASbGnct2qFqKmllj54s6c33orrtL0gm+CVbFw1Ok0RBPISTAjlD27ANVSIItvHsk7e8
	safJPSm9wZr3IIUZRVToUasEDjL3Q2cihE0jbwdg/AJSx7wltKj7sodzf5vI8O1VVc+WcqpjDLX
	HCaWHsjTb4Z5xkhyB974HSlDOTLHL2rGkGJN7O1OcgXHCx+FvQfPf5dr3kR9dQg5dU4IZ/+eprw
	Ya+FedvlukxxE66v9HltTYhcKamRnKEK4hQ5r3jcfjewzMkyHx28sCSC0GfCo8ZQ0jz5yV74+HI
	H3HB8hp2euxXPm7yY3R3J3GtDrBZy/ZIdC3ZnbWa9Ch2RgpHPjdfMybmFsv0ZaKFMXNTQgfOr67
	weYhI8+i2RV23qmou1zk6XKPIzym9DgVWELpUf7li2sYVSqm/bbB9RFxNwcZvqef8hCvbPmUP9e
	h8jwbKcepzYEBXfb1LYpg=
X-Google-Smtp-Source: AGHT+IFM7FoSp+6n8D1h1RGRzyioBT8sthh2seeo+TigunDqVeBpnwtLnUyA0CdAXQqwjeY66Eaicw==
X-Received: by 2002:a05:690e:1652:b0:63e:a2b:70db with SMTP id 956f58d0204a3-63f6b9ee47amr1322903d50.27.1761609623183;
        Mon, 27 Oct 2025 17:00:23 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:9::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f4c3cc4a1sm2776554d50.11.2025.10.27.17.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 17:00:22 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 2/5] selftests: drv-net: psp: add assertions on core-tracked psp dev stats
Date: Mon, 27 Oct 2025 17:00:13 -0700
Message-ID: <20251028000018.3869664-3-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251028000018.3869664-1-daniel.zahka@gmail.com>
References: <20251028000018.3869664-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add assertions to existing test cases to cover key rotations and
'stale-events'.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 tools/testing/selftests/drivers/net/psp.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 4ae7a785ff10..06559ef49b9a 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -109,6 +109,10 @@ def _check_data_outq(s, exp_len, force_wait=False):
         time.sleep(0.01)
     ksft_eq(outq, exp_len)
 
+
+def _get_stat(cfg, key):
+    return cfg.pspnl.get_stats({'dev-id': cfg.psp_dev_id})[key]
+
 #
 # Test case boiler plate
 #
@@ -171,11 +175,16 @@ def dev_rotate(cfg):
     """ Test key rotation """
     _init_psp_dev(cfg)
 
+    prev_rotations = _get_stat(cfg, 'key-rotations')
+
     rot = cfg.pspnl.key_rotate({"id": cfg.psp_dev_id})
     ksft_eq(rot['id'], cfg.psp_dev_id)
     rot = cfg.pspnl.key_rotate({"id": cfg.psp_dev_id})
     ksft_eq(rot['id'], cfg.psp_dev_id)
 
+    cur_rotations = _get_stat(cfg, 'key-rotations')
+    ksft_eq(cur_rotations, prev_rotations + 2)
+
 
 def dev_rotate_spi(cfg):
     """ Test key rotation and SPI check """
@@ -475,6 +484,7 @@ def data_stale_key(cfg):
     """ Test send on a double-rotated key """
     _init_psp_dev(cfg)
 
+    prev_stale = _get_stat(cfg, 'stale-events')
     s = _make_psp_conn(cfg)
     try:
         rx_assoc = cfg.pspnl.rx_assoc({"version": 0,
@@ -495,6 +505,9 @@ def data_stale_key(cfg):
         cfg.pspnl.key_rotate({"id": cfg.psp_dev_id})
         cfg.pspnl.key_rotate({"id": cfg.psp_dev_id})
 
+        cur_stale = _get_stat(cfg, 'stale-events')
+        ksft_gt(cur_stale, prev_stale)
+
         s.send(b'0123456789' * 200)
         _check_data_outq(s, 2000, force_wait=True)
     finally:
-- 
2.47.3


