Return-Path: <linux-kernel+bounces-887538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C69A0C38787
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 01:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6CA1A200C2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 00:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD3A1DA60D;
	Thu,  6 Nov 2025 00:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoZr23Kz"
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE6D19755B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 00:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762388774; cv=none; b=AJtTPOWyBJV9J4TalbW30THp/SQVyJdIw3gtTiMOS5eDPe6upkLxIs708VDvNKjkQtwhQYg42h0t6o4GSq3gfMrof9mt7aj4i/cMm0ZEX5mwJ1iwVV89nBJ83AWZQOwPsVpj/bESH5qEkl+1fMA6dkBP/0c40uK95bC1xHkaQsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762388774; c=relaxed/simple;
	bh=bcETCkepaF74e7lPUMskBIH6KkDLfN5id3lvNhxFZ9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4H8/nuAU2pAPYf3zbI7lolRvpmbvehdkmRokGE4mutb6ObNX39WYw3Ai/PZV8jdMbz9v6HsEFaoKMbHYz4tOEDvvGsx4MoS1odCnBmjQGmIdg+BTcSyQ8xYIyyR4IUBcrZF2EV4eGPSfI6fhU5f7GD3LLQGaIO/9LUMI7Fu3IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoZr23Kz; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63f96d5038dso490971d50.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 16:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762388772; x=1762993572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hXmhTJZAlfrfDbx5/TiDoR6puyEL1cB+IP+R3Vobds=;
        b=AoZr23KzUWN59YOfbzp7y0Y04/tJgWDRFFCOSUMgeTvZxyVlnZ8502wg/vsX8HNQC/
         fjr4jKs5/vdBGMULFbUEwvkpNI8JMFbrhA6uR+XsbniuslywQVmKXSTLxqnw9WkJ15N1
         z+45Mjp+iTAKxo88o4zEHog1OUgFU48BS+qMElH6nXJuH4jDFSFATmeAzCudxvFa0XdR
         gBIyg3/ttkMfqwgOdw7DeimP7nwDjJwVrAJtYJbZk70Iaa20NxHF1HtW9BVvhFoCwIK/
         IhZiKeMuFz55MDVo8UqvajR0wFjr0uDKjCOU9K4lJHoXUVqrvdggoYwbzISi26IlQ3pg
         jX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762388772; x=1762993572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hXmhTJZAlfrfDbx5/TiDoR6puyEL1cB+IP+R3Vobds=;
        b=DKvO5gj44/+2Q2dZNGvTQlqDJcITgiIg/gzmLz9ny18j6sKPFLBEd1d6c+NnVHHfA4
         nE00Wr+OHscbzaxLlkuge6qLe5h57g+Kyhxi5zykXPJHrDkhxOXf/98ZJoLJI7S6cxBC
         fTZ1WkdXMQM7Kb7oGNhHfBt3bGL2Jj054//Hhi9J0I5mSk8WzGocHmSpvybI0NH8Btxg
         RILDhGO8SVcq/Q6MAEpzoozUl/1VIGYdRDEs7mqmHKUHPdV3S3C/hbYWQAVRLaRr1Ruc
         yAOlll1hKcIEbRLUxt7I7jiaNE+dTqzjHqhEdnhaC+SxXKmtiy8RQTy6X2uzkdxRullO
         PDgw==
X-Forwarded-Encrypted: i=1; AJvYcCUjPcQUFkUNaDAEisaOQ7xXsSEYFBGEOo+Mck+1huTQq0BkF3Wt8eFgrGIQ6uBSKVnRRrO50VjCWJxABas=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVD7qpotS1PXglC5CCFEcSJgEL0Z4cewmCzHs6yvvEbFnEgF7A
	IPuFyp/sjvuRjDyYZAx9fjTmTtAapzXR9Avwhm6Mn8sBuRVskrxXYUQk
X-Gm-Gg: ASbGncumgsQ7IXtT/t+ksbOEs8RWz2bxRtbPZl3/NPmsx9kmkmwMWLym9BSFk5DDVBd
	Vt0eDbDH2eA9HYhj/3sHw8Fkx8RhRrhP1H96RWCvPGz7XitBAosCn2nwRH34h0gdlqFjZZKQUGM
	Io08lGSv8XWeuwi7c2/bTgag20KqcXLsxFG+xlGH9NLoTaNK/UN3BlanBcWOkZQm/gim7M9Sp17
	7Fra9ZxuB5r6mQqRQIIcGBChoRlEs82XYXGWOtCi2gsnhG5AqDy1dV/fA3Gvasrp9wqtub3NM7B
	dlCtAvRrNSqmnGyGCZY+bUi34ePAnMpczak7ZJOraOFRdT1lQy1qlWZjUh64PTIBLO93MbJmSI4
	Sz5pcbRrCXnhnqDWv82Bs0fv7WnYdpTbffqH+Rk9zTpHLXpUPx6sesZQIqWHMvpOZypq6Fqyv9w
	iRvDA6Bpot
X-Google-Smtp-Source: AGHT+IGUs2EGrmJcpX8sLWFVHcWr4tdUrasTklxf9Bp0ULYKHhGWtlazRWy3T6CE6OmD8o7jNEYSVw==
X-Received: by 2002:a05:690e:155b:10b0:63f:beb2:9519 with SMTP id 956f58d0204a3-63fd34b5e50mr3795617d50.5.1762388771781;
        Wed, 05 Nov 2025 16:26:11 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:8::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b142d5cfsm3513297b3.26.2025.11.05.16.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 16:26:11 -0800 (PST)
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
Subject: [PATCH net-next v3 2/5] selftests: drv-net: psp: add assertions on core-tracked psp dev stats
Date: Wed,  5 Nov 2025 16:26:03 -0800
Message-ID: <20251106002608.1578518-3-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251106002608.1578518-1-daniel.zahka@gmail.com>
References: <20251106002608.1578518-1-daniel.zahka@gmail.com>
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


