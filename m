Return-Path: <linux-kernel+bounces-721865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B413AFCEDF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628E816D140
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF672E11B9;
	Tue,  8 Jul 2025 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlJLHVws"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0802E0B72;
	Tue,  8 Jul 2025 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987915; cv=none; b=MS6Zx/kLHy3cjpreX09Sz3YCCyOJhbM4W3bsvhNlvZpUmriWjiR4DAm5Ex1VnOYzy3L/1Bprz7xeRJG/aUZvr8ONpdmYZc3EsgKjAHxfJfA3KChrXZKPp/jplzwjC9p6yXT/5iC4e4SxkF8Sax4CQZ9PaCwBqWgk92olT05qvq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987915; c=relaxed/simple;
	bh=Mp480WM/+Nx3sTsCmu8c+teMaB09N8ViriZTK2+Sg50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lWURrt+WOCzCjfm5G9oo+DI+36mvNptRT6LYeCipSrUWlZStoemhLKUzJ5XcXWnKORI3SVsvcp8O+6+afnzWRkWGezU8gvsIlCjv8YYA4fPQEo3TCBsAQF35nYF4btPxApe7ONXLuz6y5TVWX19oLYtYckyLj5g535fDB4Rv9S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlJLHVws; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a522224582so1802333f8f.3;
        Tue, 08 Jul 2025 08:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751987912; x=1752592712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XG40PwIoFv8ISVaQTzep6bW+GYjOoA/4fnGXyh9BwhY=;
        b=DlJLHVwsKBxdf9Jeg4RxGnZOXEihEAm2igrstN/nwF6U6H4VSyb+g4D9d8CLhy/34s
         Cy+ruvLKKEZbLqWJwOEc61OJ3uR5/9dTNJUiwsV6+/Jr70A86qgNibsYOvdeG0iZgmd6
         n6D6pg5WCaeJT99dctOyDeKprrZY5QpULQYSBBXlBrCWdsev+5OIbopewu50SMVBMLb0
         VAUDTM+I6Uf+0IfWCQvppNWPlHy8QPlyoBFmaYJVioISnWZfDEWIqgTot0WprRsD4OYh
         YKujVCYPXv2epumD838tIbDZ7K2l6+aIZtoJYRiBm+R+yLzskJlUGqFp1sNk+gnauUjM
         hLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751987912; x=1752592712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XG40PwIoFv8ISVaQTzep6bW+GYjOoA/4fnGXyh9BwhY=;
        b=MuE+nbWawagm+P19ouzaR9hJTFqVsSfz8rkeMBcMfrZV7axLh1RZDy5/d3PBxCKsvx
         FmBjhFfUnsC0vzJacpZE9F+Z317Jc2fAE8XlPB8vPGskCmoE2eXpZ7A6BSw8wOkP6FPV
         5oEl0jkcblNoK2y1jaxZ62NVvrTTKlCbaX3MKx5l+/CJsmDWa524SDGkuIi5sPeCwXIB
         6yRSkjKdOX3pRr3m5XO1molDmbt6Wca22788cZ5tr7jB2OCCoWqyri8OQgPBVb76VJk8
         yqFVh3hHdNbL0/+XlCfkakjlV7f3GTkIVhQaa8XomlDJdQ/3azgJkZedlgU3DE0qXpyF
         jTpA==
X-Forwarded-Encrypted: i=1; AJvYcCXTDAfCfNplXsg+PPeSGgo0tpKlwQUSRc01BRJagTQADAQbI4+nHtcz5rMTJsIrHUwgLu9fICCUi0BA8r0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzhNhMeFy8Pq3d/joz8xqvk5xYTZ/qZNVQneJCpdsFt5v8GB+e
	Kskevo1k9NaHojdqXWE5BxwySNU/fYsVMkWrCQ1/aqSoDkdJA9RoJ/9p
X-Gm-Gg: ASbGncsCtLic3KJDRL0GtBw/m/wxR51m1hwxJY5q5NAcX3bEsHlqSWgYR67JkdIbOAC
	5lDfn+Pz8rgn766BDgel2mR1ReiYSBb1woIMfCavQyy+7MIlQJ9pCrFqpEK8auyATcNL4cjNGEi
	aakoJs/kq9h83TaVwgZs8Ti4UxHxA3EfR+cgKsGPbLDqNagQv9kuxVQVdGX5qbeDnCgU01dXg1Q
	1KV+FE5MeUp9XU+zc0qeB75saNNzEmhnjGXAnLLFzJQYy8AFNkzEySsSc7qh6NMNeP2VqLClGsD
	j+dkms6UNz/XBM4XBzIoZXZaATEgWRNAYG0a6jPoZYbgOgYKURJH1kinuBeq
X-Google-Smtp-Source: AGHT+IF8ilJk7zPxekXBSDqLR+QOUxIH/3u9W9My3I94vG6RNZ79i/0IDC7psl8ApnEea4OcTdO/zw==
X-Received: by 2002:a05:6000:2707:b0:3b4:9b82:d43f with SMTP id ffacd0b85a97d-3b5dde4d89dmr2276946f8f.16.1751987911982;
        Tue, 08 Jul 2025 08:18:31 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454cd4f398csm16328925e9.2.2025.07.08.08.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 08:18:31 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Corey Minyard <corey@minyard.net>,
	openipmi-developer@lists.sourceforge.net
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] char: ipmi: remove redundant variable 'type' and check
Date: Tue,  8 Jul 2025 16:18:05 +0100
Message-ID: <20250708151805.1893858-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable 'type' is assigned the value SI_INVALID which is zero
and later checks of 'type' is non-zero (which is always false). The
variable is not referenced anywhere else, so it is redundant and
so is the check, so remove these.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/char/ipmi/ipmi_si_intf.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index bb42dfe1c6a8..8b5524069c15 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -2108,7 +2108,6 @@ static bool __init ipmi_smi_info_same(struct smi_info *e1, struct smi_info *e2)
 static int __init init_ipmi_si(void)
 {
 	struct smi_info *e, *e2;
-	enum ipmi_addr_src type = SI_INVALID;
 
 	if (initialized)
 		return 0;
@@ -2190,9 +2189,6 @@ static int __init init_ipmi_si(void)
 	initialized = true;
 	mutex_unlock(&smi_infos_lock);
 
-	if (type)
-		return 0;
-
 	mutex_lock(&smi_infos_lock);
 	if (unload_when_empty && list_empty(&smi_infos)) {
 		mutex_unlock(&smi_infos_lock);
-- 
2.50.0


