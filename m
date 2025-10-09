Return-Path: <linux-kernel+bounces-847289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52244BCA7DA
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF0B482C16
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7C7257422;
	Thu,  9 Oct 2025 17:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKSlUEEH"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2B525394B
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032733; cv=none; b=CWxXLXnLCiNXXkwZkfoqmaGImsaCOnWwq4tZJ5cY2ucmYJuQbApuiu76rFxrxBpl8U+RaeMFYfMpy8HmYwrTUVuqw7W50Djq3AA8P4tVwLqXyTscgO1pyk6CwlCmyqfYtPL4Zg7Cq/FWzLRFNZPQRkbVbP7gv4nOd4bmw94LPsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032733; c=relaxed/simple;
	bh=xfWOQ2T373ADf+tcgIBcHrGpfWd78TIqVBMM75aiZ8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7Pje2CVDaPNKEWulI4RWCtOae/7Iwsj2rrnqPCj+GNwa2nZdVbiB/ixb30q5jzd/0DOFSZ5N+yEuAeLy4fOvnfRF5931WJDt22lmfp4SPrxE579UCaCrkvCPJkBLjV6el0P83klQ0JuDUwtvCbqeOdRO3201N3dkVTss9taP7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKSlUEEH; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-42f5e9e4314so12590165ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760032731; x=1760637531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCaJXGEEoKxacl2B/5AyBFFUSkEK+Qm7rR3SS8wI7Gk=;
        b=jKSlUEEHaL/BQmC1dLqKdIxAsvvxQtfk4wZiic26K4932N7d8TRarNoJq33NOSZYbp
         ClGI4nw/jcfLogW4NJa2KyHe7B8WvgitqQ5SyBuLcb3Jm9XJpodWrkxN0iv72KMnAWHY
         860m0VFVLlIZUv7qqgz+1kvOXYvbltZmtLz8TZvjMLy9weryBzn531lOge02TkbdSmU2
         MfvSN0vz45dxoAWmtBKLdyloyJppDFxekPFjCwHuI6kQp63UmvZZPt6GvskPGAoHyg0/
         h+gHhzebxalwRrb0LpZIKxZYtRooh4xNwt3whBoEk+FTRyrmXIUaG7IKxKoLVAtMi+JD
         /vnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032731; x=1760637531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCaJXGEEoKxacl2B/5AyBFFUSkEK+Qm7rR3SS8wI7Gk=;
        b=O0a57wi2SPYpjBT6O3rfHaJ9VNuuc7jF/o3ekzYEilrlR6LHqpZWNUIv6xPc3aeG3e
         aqn9q5EmXovnjwNkPHr6ilFRyURYg9OiUt/A5SJTErNUjR2F7yhrYcOnjkHkUAyZiIBz
         OfGUIg5nWSy6bm6XW4KRZrapU5Hg5G3zQU14zhHsmTHqWDZLvB30E/PUg1fN9l50Hi4U
         QPLf6Ykfl+UdbElJSJFi2v7OhEYS+o3TeeBbYt3fjFOv6TpRKc3nZVIJiNmCGHvw0cTH
         wwA8NtjcKy5pFqYgpoqFCNxkt3ThBUW+VYfvserFw9vONoWJB3JXVL7VsLVsNlLgzb3E
         1/Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUqrZA36kHfGvhpO3pHP0ehe+CZUeIx3Xp4pbKemtyJf+Xrb5C7lVT/C5PgDS+g9un6tq1kHydN27L1j14=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpkCma85p+V5Mds6lFPtD50HwrdnI+uIq3+NsOhjpWDYvnyGRb
	TkxMsfS3H9/P053Z6dkMpuWT+QRhueLwK/ujeHCJihR5w0HyklgucXSn
X-Gm-Gg: ASbGnct9xTAGUAocS/uJ2kZ+vYykoBa2m8obgfSVrkWfmfkMzuO151n8PQmlr29UUDR
	UH1Psxhv/PqcJm0gpnDc40s8Qp7iq5AdyBrAi2mmn4+ebKEYW0DD4QK5j0vzX469SEjnsRjOLd+
	q47UmorJg1gvPLko/SPif0OUqqKFB5025KgxYSGwTsIL+9VNJsyHgdpThoxKDFMPHZSavOlIe1g
	LE4vbj0zF6hTnRIdGAN1fVno6Exxn+B2aFGnGnrh2yrSCzwh7thqlq1t5fEhgSufNo5fMOVpoQ/
	R16uN5uRvcFqCmk5OvMM5ktV9hAOTDKjtS8w/9/VpSVO7H6bB4KP6mgkpa2RTYnJDkWazkds6bs
	XCtAb46sUetTWuTkOpvuzati3e3V1jF5bI9iaA6qY1bQEUK5ZssKd79+Ijg6kEp1sqU+D5WLOAA
	gwPz7UftQz7v3tSaGHMu4T9PHkYIP1RDAOf6JGrA==
X-Google-Smtp-Source: AGHT+IFGYwQAi6/+LnQSrv5XVqN8PJXx4dyNZG3PIv3e3G7kxepvzgPF7iyA+hTKfqnZ5PXXLeiArQ==
X-Received: by 2002:a05:6e02:4706:b0:42f:8eeb:499e with SMTP id e9e14a558f8ab-42f8eeb4a3amr54728835ab.13.1760032731025;
        Thu, 09 Oct 2025 10:58:51 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:58:50 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 04/30] dyndbg: reword "class unknown," to "class:_UNKNOWN_"
Date: Thu,  9 Oct 2025 11:58:08 -0600
Message-ID: <20251009175834.1024308-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009175834.1024308-1-jim.cromie@gmail.com>
References: <20251009175834.1024308-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a dyndbg classname is unknown to a kernel module (as before
previous patch), the callsite is un-addressable via >control queries.

The control-file displays this condition as "class unknown,"
currently.  That spelling is sub-optimal/too-generic, so change it to
"class:_UNKNOWN_" to loudly announce the erroneous situation, and to
make it uniquely greppable.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 5a007952f7f2..147540c57154 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1154,7 +1154,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-			seq_printf(m, " class unknown, _id:%d", dp->class_id);
+			seq_printf(m, " class:_UNKNOWN_ _id:%d", dp->class_id);
 	}
 	seq_putc(m, '\n');
 
-- 
2.51.0


