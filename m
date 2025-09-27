Return-Path: <linux-kernel+bounces-834804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F46BA58E0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 06:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8202A83B0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 04:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C80221FBA;
	Sat, 27 Sep 2025 04:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxH+Ebd/"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D528248B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 04:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758946533; cv=none; b=NerMSFuErlIAqaHgrgh9DDYFiUUxdwOoCtCWA8dlVyxY3JyX0IrH6XmwolglgpBA4GR2HaEwa2+bVOdTECN447QEZcrvVY7bHqu7E5i0X/yXO4DVEmQScCFTeGGbmWiLplGj35ktIMRUUsFnoMlIN2Z+i2ScP/cc9ykqseOwOoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758946533; c=relaxed/simple;
	bh=1S7qkacQtOJLn4B5dSDEdf4PQhZDBi/JrvSfER614yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WrD4zd6EPxRj3vwePSpPhnFmLT4X9SzUIwacIShCw2Pln+TK2VCzTfmzBz1ZV+mgivqtrHLOYW/DFBOW9Ml0ixq/5YW/PqL/H7hddAlvvjFx3zT6UGliwON5YW9itSJUkdXw24F423r7QbReIxHtz6XVWn3VawsOkI4K6oyvUP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxH+Ebd/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e23a6617dso28759595e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 21:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758946530; x=1759551330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQ5MmPkHxZioIeQfPFm5x4+gWD/pC2wMeHLaiRdBbYA=;
        b=TxH+Ebd/wfXSrcLxUmPbl+DDKzRyM+RLb7nNFfyfwo/vKj9UAThW/A9cK3eFa3fYOa
         QOKIDwbFlJDk/eaWHe/St26GBFfym6skNoznrbSGr/QG6L9NFIJqbxTHTwrWbNo9HZ1N
         HGbootu6KcU5YrumDKwMQbGolILgHvkcubwgyo4Rn4Ii9mswUpfbuVnBB4qJ0fhx6ETU
         DhFSUwmMT/rad8J0OKW4MsLGJGb1YqeaU3oBXzC2emxyHBhBs3rPmFcmk0ZVdNpP1f8r
         tFPKr/2oUr1NahuGQ4Pwg0aA1vUQq+NSx0vR8mYMmxv8BOw47DSt7tv7RdZmf8XjzYmZ
         A5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758946530; x=1759551330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQ5MmPkHxZioIeQfPFm5x4+gWD/pC2wMeHLaiRdBbYA=;
        b=ixO25h3nD6mum7g5V0r1ucaDryrwpvlM4MXqwN+tmRb4zXQ0IJqSBHaRMI+NxwR0Dw
         /BpKtODtqdF3VvuTKLVDpSwr1KEzpadg+k9jncMT17GpbZG6T5tL+lJoplxho4rzKIe4
         XxGOuNQD6hwvX/5Tfz3duSyIN5+j94D5wl/AVNbAD7liX3F1SFNBMOxeIWu/47MqUXq3
         o8gF62luwGXvnyH5MFYVZPawdzm0HT+KJe1Ski+u2YaF4BPYI8RqiCS/xS4sOQ8QIdgR
         BKld0K8nBUZaC7jsh1vM1bqz1T8xIMlVPMHncVTUS8Y5e2H5FAoOEv7XVn/eQBzJ5exm
         NDLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgLIBCIaW+pEmc7iBRpLD6LD8WwsYnDtTdtvDUkC+vaUqgaup0oVZpR5F5oURZTg9i+7eagiUhAyH+tWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwARqjPKLawWW6t6DArLzkBWPjpfkV3DwgNHzWdpxxtYYl1Y23y
	KOmNw1brK03QfZ0Yz759HN2/pdXeAO5OnEcjJ1eY10EGiCnQYsRYd0CHsED61A==
X-Gm-Gg: ASbGncsMNfkuC0vcnA3Le4DRq0dIVNDjy6DYpZq7EtnQH5SnNVmeDDTvW/x3gGvQzu1
	willN8mK2wNoaSbYWiLMxt+b8MrHdHtlyYOaJ4TmjtSH1ZS/bmGK8bKeCThn2vVHtQEJa9wTsKu
	Z9eFPJsqllv6rXv7viI6TOkrPDsveUy9syvCqY9KmG0WiLDeP1Bw3JvLm3Iw2S1mhgVA3YGQD4K
	xdMhDaq5INIMI67cy7HauiOz2BdFJ6ahqjWv+neQdxHsJ2u0zkU9oYriTWxLuf1nZOm5R4KG/NO
	+/wlysHrkgNIgmNyRrcZeT/y9bMVLHWp/hMToQJ7uk/faA7B3d/PLYtlH5BymoN+9RrrUgJg6oA
	pmVUgporVw09AFSCwvHM1v1wKkxUY4ivtufO2Qqg6
X-Google-Smtp-Source: AGHT+IHNltIrUty9L1vjsZ4/Hwqq3Wgf3VB8CTDHf03NWXIxmr7SHAgznCOWO2DvuwbAOd1ynDRO+w==
X-Received: by 2002:a05:600c:4e8b:b0:46e:38cc:d3e2 with SMTP id 5b1f17b1804b1-46e38ccd4dbmr47800515e9.22.1758946530076;
        Fri, 26 Sep 2025 21:15:30 -0700 (PDT)
Received: from hangmanPC.. ([86.124.200.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33105e0bsm50386665e9.5.2025.09.26.21.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 21:15:29 -0700 (PDT)
From: Cezar Chiru <chiru.cezar.89@gmail.com>
To: wsa+renesas@sang-engineering.com,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cezar Chiru <chiru.cezar.89@gmail.com>
Subject: [PATCH v6 3/3] i2c: pcf8584: Fix space(s) required before or after different operators
Date: Sat, 27 Sep 2025 07:14:00 +0300
Message-ID: <20250927041400.172949-4-chiru.cezar.89@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250927041400.172949-1-chiru.cezar.89@gmail.com>
References: <aNbWejNZLYGuNvCI@ninjato>
 <20250927041400.172949-1-chiru.cezar.89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Require spaces around '=', '>' and '<'. Add space(s) around binary
operators.
Enforce errors fixing based on checkpatch.pl output on file.

Signed-off-by: Cezar Chiru <chiru.cezar.89@gmail.com>
---
 drivers/i2c/algos/i2c-algo-pcf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
index 41a81d37e880..d675d484fe66 100644
--- a/drivers/i2c/algos/i2c-algo-pcf.c
+++ b/drivers/i2c/algos/i2c-algo-pcf.c
@@ -183,7 +183,7 @@ static int pcf_sendbytes(struct i2c_adapter *i2c_adap, const char *buf,
 	struct i2c_algo_pcf_data *adap = i2c_adap->algo_data;
 	int wrcount, status, timeout;
 
-	for (wrcount=0; wrcount<count; ++wrcount) {
+	for (wrcount = 0; wrcount < count; ++wrcount) {
 		i2c_outb(adap, buf[wrcount]);
 		timeout = wait_for_pin(adap, &status);
 		if (timeout) {
@@ -272,7 +272,7 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 	struct i2c_algo_pcf_data *adap = i2c_adap->algo_data;
 	struct i2c_msg *pmsg;
 	int i;
-	int ret=0, timeout, status;
+	int ret = 0, timeout, status;
 
 	if (adap->xfer_begin)
 		adap->xfer_begin(adap->data);
@@ -284,7 +284,7 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 		goto out;
 	}
 
-	for (i = 0;ret >= 0 && i < num; i++) {
+	for (i = 0; ret >= 0 && i < num; i++) {
 		pmsg = &msgs[i];
 
 		ret = pcf_doAddress(adap, pmsg);
-- 
2.43.0


