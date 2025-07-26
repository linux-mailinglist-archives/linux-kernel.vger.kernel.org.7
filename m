Return-Path: <linux-kernel+bounces-746623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EE7B12900
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 06:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704AF4E539F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 04:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEA3220F21;
	Sat, 26 Jul 2025 04:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtjMiiJT"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC3E21D3D4
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 04:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753504451; cv=none; b=a7da0QB3CU0vFrgeCbtTE9atLeRozvTxej/epqwVkyanrlTA0uoqm04CDKtKVb/SUoZOVzmJpVYpiJ2TlRnFJ0LJB8YTHFoPcPrNrCjzWFLGpSRC2Wuo3Vi5O3hS918G3GcGO0KgJ0hgYMXHUHDCPLZLHrBhExux/GgC0ftEN8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753504451; c=relaxed/simple;
	bh=SD0zswV1u0CGmvyxeeBf8KvgCVotkDI4w0dpQTwrq4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cX4ghohqktfHFG/cck4Sz8Niw2Cl2PkgSAsU5DtiGiTyTw2vXFr/gp9k/cb/xWO3s6Rdbr2c8m2h777IoIhR87qSwcdLWKNyrLHlwRFW4OZghdq6Bls4nGMZkiqfsTVZ2INwIOxAezzWMLudkf+pyrE1LYzZMARJFVkVKRxP5GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtjMiiJT; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e32c5a174cso247081085a.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 21:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753504448; x=1754109248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXnNS3kNW1BU5HzPFn0KRN0y0JHuPkxgBF0lcn+1alI=;
        b=YtjMiiJTYvv7aD8lbFq2CBxtnZdvN5y5O4bqh4C5H+vpsPrwiTwMTMZKj5uwDQ3AB/
         eAignyxY0Mm6pe40GuURh6Su7LiBa0+8QNUfsO5w0qObAs7vNBsdNIexgXurrTSstg0c
         n6Ywje36e0Bfur+ve+1Is/bFtUppyC0IkD9T36r2uNw2c0vv9x0ZWePXuOJVaqKne/kz
         We//BRU+BW2AxzghueGz0qrD1z990kuQBViVrVl9oFz7GlkKh0w0S36tjM6FwlzWZR0F
         eAEAQnicI6u3isXY6cTxNx3UdjoyzG4wWEo9Id/6x9LAfs2d80HLsdjx1IqgX7kSh11x
         t20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753504448; x=1754109248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXnNS3kNW1BU5HzPFn0KRN0y0JHuPkxgBF0lcn+1alI=;
        b=rnTV1kVwDA4LUyDp73lfLB/f06GVUyAo6eu2KW4hBsiCHK0B3eujChim6gxUA2r8kv
         +9NYTzA4Xn8ZZ8rO3kNGQR7Oid8s9CR7MVv0xELzC27S5uj6cDAGzTBplPp5KadKOxtQ
         EVaYHX9wPSKi7YLrVeOXOfxXMW49UGXVM22vkguFn7Lpq3c9wM4Zj92gIHOW2DTi9ZGz
         9WIE9/an0ZsuOzzuMaJVTfjHW0cjyaW6K0vIYMBULVEoUqBfcxJl1WDbhfJdb8UdK9Su
         yd6g08oMfXPBHjqQtuYbgNmR4AMUNxOx9FxmTesCr8sj3VNA5NGOCuuWmcfXQY+evHGz
         /F2g==
X-Forwarded-Encrypted: i=1; AJvYcCUkHMNacXVusJjemhrxyQt8+fmKlrvflI3yHzUkOyr0WKXNQwjlQ+4tNjQmEXm56vEpujIFS0vpUjDxgl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVUOUuDAs9Eq7DIdgTWB/in+PMj2dndua2+Ca1ODeHFZ5XAXOV
	hae2LjnmYhsNk/ES62Alq9aGIeoVgjMcKKqc9SzC+jqrnvk4hshRdxaH
X-Gm-Gg: ASbGncsDod3O5cXssQNoghUnxPoX1PmL7DmgKO2oM7xvuuTV3tcKLlNdcosuD5m/OUG
	n0mbyeFhjoWSnAST4cchOEKT2YurCVDKTA3yy0l5D5As3Z9ROkUOfXiqTbHRhK+nliF2daxmlw1
	GE+RaLK+q/siP2RHki8TOvCLZGOogRaDPxdEXX8lL0BWw1adApQW2OD2jaFUcwif+8WQ5rOrjZv
	T4xtl39GDP8el+l7aah848XfmYPftpAjAvy4l1K/mn7N/mquBbnLkoyUfWN/2OCRA5taiKhpTsh
	bFMALqw/33nD7G+1oy88z4JEgDnGVsCAtb0Hc2nD1hqzEKMii4HDZZOnDbotlUKbw3/dZqgOiL+
	co+aq95DywcrqD28DLtDQDLyx3XoIc+fFE7jD2/YIvULGywZyHno=
X-Google-Smtp-Source: AGHT+IEIljk5xUO365R10IAg9Spbt4O71JMQ50AM7dIBDTN/HgutLWOPav+9wvQdCMsgptojJINyRA==
X-Received: by 2002:a05:620a:25cb:b0:7d5:f350:e533 with SMTP id af79cd13be357-7e63c1be353mr449637585a.29.1753504447839;
        Fri, 25 Jul 2025 21:34:07 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e6432a885asm70322185a.36.2025.07.25.21.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 21:34:07 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH 17/20] staging: rtl8723bs: add blank line after variable declarations
Date: Sat, 26 Jul 2025 04:32:15 +0000
Message-Id: <20250726043218.386738-18-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250726043218.386738-1-vivek.balachandhar@gmail.com>
References: <20250726043218.386738-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added a blank line after variable declarations in one location to improve
code readability and follow kernel coding style guidelines.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 7552f7e4d14a..acacc2806dc9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1449,6 +1449,7 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 		if (adapter->stapriv.asoc_sta_count == 1) {
 			/* a sta + bc/mc_stainfo (not Ibss_stainfo) */
 			u8 ret = _SUCCESS;
+
 			spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 			/* free old ibss network */
 			pwlan = rtw_find_network(&pmlmepriv->scanned_queue,
-- 
2.39.5


