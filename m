Return-Path: <linux-kernel+bounces-739641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1529DB0C90C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EFD67A3473
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E8F2E11BF;
	Mon, 21 Jul 2025 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGgZd2i6"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D80E2E0B6A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 16:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753116287; cv=none; b=WIEtGnyqV2dOIvc3DWz3K7fk3AElTLtMLlhznMmXF1DNGP3UmEXqbwdxMbm1Rh7h9qsmDnbx8b45nc57C6wIPPf8Z9sPvrTkX5IKEfkriRr7BP2Uj324neAznSPTRV/XXldz3nmg8+D/3+Fhp1R9smDhKcb9p/5WfpK5CxAPd4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753116287; c=relaxed/simple;
	bh=1J2UIt1/++cEIeXiIaXaU5l3rUWWsg9IBhLXYwqa42E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=golBFArQVdYwCq+TQVFAWHaBPPKohQzI05h6Lu0UooR4AE+3spKPXD9lOWxKO6cfzfT1wI5nn3efhwRisp65Ook+u0RejWVVfdihE65045vYYUZ635wkc6E1cDOnmy3CSzNNGsIEW2gnQYNtzyeL263TzSBvXqOgzvj5kJCMXuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGgZd2i6; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60702d77c60so8938120a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 09:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753116284; x=1753721084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGcYfMvKQ/FUSKqjitpjkfo3TUjrMEXu5wiAHdK8B9U=;
        b=NGgZd2i6fb4foP2zTfoKSfH6rFHjJUVK224I9gjuWvdna/1aJVlMc9qNmDXYlsNkWa
         vSjzAWgpmTM8LRtrGVvPvPYMvoD/aV/ScRi3AhVffemI5wKGQ1H7DTektH4AvTOm8mtQ
         xGFop0YLftIpu7l0jemZ+dszGN7D+DfsZI1VZGP0OE2w6VGfVKstxZYhXoEXB5RR6VJD
         //9CHFbBB2i4GkJWJ3XTqJt7FA3lbRXHoRvlxUJ5JwtDi821uAJZsCefxck+pe3BaDqJ
         yRIb6q/0FgMcNDf0mQwLcgr3PjZetU4jMIlqHwDYn3fNt59T5yUGoQ2txJ821wslQ7EC
         bujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753116284; x=1753721084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGcYfMvKQ/FUSKqjitpjkfo3TUjrMEXu5wiAHdK8B9U=;
        b=Kf2AOyuKSJIhhXCnNJnlUFP8oUt/sFr0rT4VDLquUrWcsNnlGlp90tjuANDc6MXsjt
         7+ifYYP/ZTnm42xHI8Fz3bC+qaeyAMcIFLfME/Owe1ny9H2eeNev8zFPuGlVAOPaujPO
         QmcfYSMcn/9cVRVv5v0rQqk1Wf2RgzE8jD7JJfQPJ6LhspzYaXjui4zAtkUMUw9XQSK7
         tDWM0K5Vsy8tG/oAycHcIqUrB4IL2FIxbeEfaPKDTU4kGcghLHzIjDM0UIFE2huSvP5Q
         7Nn61sf8BwTbRwNp85/Xy9YRR8bvbjKadOeb+v9LnBdCvfTVUkDinZp19ohIhedgAwaf
         BjWQ==
X-Gm-Message-State: AOJu0YxP4Bu4iIdfu4z+HcLm2tF5IqRo5laZEctCY4Hzps08reAAgWKG
	Z0E/nRl5l7TLDP3zuBNCuNqEqDlWad6IIwxIhNxwyArvwyG1rj9tsN2iCeym4SSK
X-Gm-Gg: ASbGnctXJzIlDaT/IOXr8oj4CnVcURDxYOxLRJ/4vJU89KVTygjYQRpKGa/bH/gS1OD
	rU8+e5yh2R/tRWFKbg9P0rZaL4x2FXpyM+ZW+icxguVSLCdWP9XhJqS91rUeRXr45K8+aQTiOcn
	M3Yi7ruCU+x4x/t72/D9yvOd72+KuCD2oBSElK9KVHuKFBnXUeRYxV9yfHBRdm1xDe+Z3AOaT3a
	1F6kfMUPKcpr1MmSRJhBCNcvy17HS94hyiG4wuz8Xq93vIZwmQ8IdIVx4e98LJ+/4tf94Rd0iO1
	nbDG0D8t9lu3rITpN9YaejJWxhKkWgwzOLle08PbXK8vH1BNIwmBYjVdKShT4e+E31p3brXQJol
	4YYmWXe7fQoTN2Ofi+X4=
X-Google-Smtp-Source: AGHT+IHWoTcxNymJShB1UbPuaN9MrUzPk8urCiRbLaQM2bKMOLhHbI/7xBsOFKjPmx/IIazECz07cA==
X-Received: by 2002:a05:6402:268d:b0:604:a19a:d84b with SMTP id 4fb4d7f45d1cf-61281f1d19amr17229801a12.5.1753116283936;
        Mon, 21 Jul 2025 09:44:43 -0700 (PDT)
Received: from zephyr ([77.237.184.54])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-612c907a5b1sm5662655a12.53.2025.07.21.09.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 09:44:43 -0700 (PDT)
From: Ali Nasrolahi <a.nasrolahi01@gmail.com>
X-Google-Original-From: Ali Nasrolahi <A.Nasrolahi01@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Ali Nasrolahi <A.Nasrolahi01@gmail.com>
Subject: [PATCH v3 2/2] staging: rtl8723bs: fix comment style and formatting in osdep_service.c
Date: Mon, 21 Jul 2025 20:13:43 +0330
Message-ID: <20250721164343.8395-3-A.Nasrolahi01@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721164343.8395-1-A.Nasrolahi01@gmail.com>
References: <20250721164343.8395-1-A.Nasrolahi01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ali Nasrolahi <A.Nasrolahi01@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/osdep_service.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/osdep_service.c b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
index a00f9f0c85c..60c3da009a5 100644
--- a/drivers/staging/rtl8723bs/os_dep/osdep_service.c
+++ b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
@@ -7,9 +7,9 @@
 #include <drv_types.h>
 
 /*
-* Translate the OS dependent @param error_code to OS independent RTW_STATUS_CODE
-* @return: one of RTW_STATUS_CODE
-*/
+ * Translate the OS dependent @param error_code to OS independent RTW_STATUS_CODE
+ * @return: one of RTW_STATUS_CODE
+ */
 inline int RTW_STATUS_CODE(int error_code)
 {
 	if (error_code >= 0)
@@ -152,7 +152,6 @@ void rtw_buf_update(u8 **buf, u32 *buf_len, u8 *src, u32 src_len)
 		kfree(ori);
 }
 
-
 /**
  * rtw_cbuf_full - test if cbuf is full
  * @cbuf: pointer of struct rtw_cbuf
@@ -204,6 +203,7 @@ bool rtw_cbuf_push(struct rtw_cbuf *cbuf, void *buf)
 void *rtw_cbuf_pop(struct rtw_cbuf *cbuf)
 {
 	void *buf;
+
 	if (rtw_cbuf_empty(cbuf))
 		return NULL;
 
@@ -226,7 +226,8 @@ struct rtw_cbuf *rtw_cbuf_alloc(u32 size)
 	cbuf = rtw_malloc(struct_size(cbuf, bufs, size));
 
 	if (cbuf) {
-		cbuf->write = cbuf->read = 0;
+		cbuf->read = 0;
+		cbuf->write = 0;
 		cbuf->size = size;
 	}
 
-- 
2.50.1


