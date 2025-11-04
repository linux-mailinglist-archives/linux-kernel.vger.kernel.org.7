Return-Path: <linux-kernel+bounces-884550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80F8C306CC
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1E94225C5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9515C2D595B;
	Tue,  4 Nov 2025 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQ53Ntyq"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ADA2D4807
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762250623; cv=none; b=Ohl4aIbXChYR8LcH04IJd48d/64SA9YWF+bjCxP5CB/YxZ95O8/H+wW8ryeFR+lrs8bQChIF+TtAtTeZFWmz48+BPNC/vdg4mQrhFst9qT5GIKZO2c1an3maqW0ib9wZg18UJHz/4jIAQkb/J3cZNaw+po57mWppBzbgteKfeK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762250623; c=relaxed/simple;
	bh=yCNhQ4a0Nk0Atx6Dr4wxtJ0ZtyqyLGT9ZWpCeh0ba7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DSeZSrRp/hpVcnEmepShxrGJi5rsmVhpFouKU0IPTTjW/T5kkiSNbh3gnofiKbakY01pdNABETqPZ4iLc1O4ym/VCPirwtAfz3X1EN9/FhYWE9X+W7udMdoyO76Q95ifP1w46fzQ+4wpmrs6gL8W9x6lioSrJNc4LdJnpoHFM2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQ53Ntyq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2960771ec71so643685ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 02:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762250621; x=1762855421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKUczaa/kE48HAcaJ5lE+YSGWpwTs3a+tEo/Ya98+Oc=;
        b=mQ53Ntyq00EMTSh035RR+uDtW7hqjDsU/ZP5ohgCtXU8iDxkKWRO+rWmFTmRd3dtve
         /9oHlAvsGwGsM7p2C1MXvAi61D0Uk3dIy6G2YyjJfgSsmY8gX3MXp3jMK7pwNmuNcqBd
         uHBqxjox4bQW/TlBTz4WEPe6EVfSCehly9TXbbO2OuQquuXC92Ulw1VY/Ubm7A+gTN0S
         LvH6K+3Z9chVBQ7YtbJ4ir7Yf1if9X0rhTIXdW/PEyCyRlKuRLOCEQpRXQEW0BWzRMAQ
         uvCO6YkLHlqWaMmAlYMUrhOdL11AIOQ6AHx7XxZhTMVc/xlY5vav4vcw3g9oeQk2eZ0/
         853A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762250621; x=1762855421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKUczaa/kE48HAcaJ5lE+YSGWpwTs3a+tEo/Ya98+Oc=;
        b=hqjNGsfHtnEnRllrIT6zgyjnYSFojowaEuNV/Yotdoiq7OxAPx3Ky0J++1+XRXi3pZ
         VaU1DkSUMy2bbMOKAeBDy4t6QMgdY/dHt7EDEmeLmp45hZlSiajOC8pbFmS5NQojEEkJ
         Z+a2+En9pMf5lXZet4WBY7amrvCJNvLWNtUgabWPe7HlOhKypS2wmD+3FYs4P+FzyVxW
         OarMmTahWMXd9u84G87yUsGNj491bP9rJZogsv1sX5BUDr26pLZrc/IYRu3/4G9/w/0Q
         sYCZV7rh5bNkxCjuuehz3g/P2WmOuh7OWDOXQwD1tZRFUjgIMxDgczqMCuc6fOzKRUPG
         /eag==
X-Forwarded-Encrypted: i=1; AJvYcCUlTDhmlKOr5VshbTG+E0WqfMSNNsJv12Wnim8wMMlUDtxAb9vbOH3RRtspjOAyEF7rc/UNKHKl9zSRMck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu8wRJiq7T9vkO14eO8wKjyqTUp1zVVofCgfogNV7rsyVnibxF
	R9slWXshs3LytWbzvZvVuuq+V43e1pHXQpMlsZdFoZFEbOLf4tt8xL9iOy6lzLGq8Bc=
X-Gm-Gg: ASbGncsyK2EG59aPVBMljVbJG8BTwzleD9kfI054jfsgKPrtRsrmpkAsyyRVHA3Aico
	K012OwTWixAtODY8H/3SBDLy4psi8kW+1+C7HC5i53G7JoYeXa4mfp2uXpuclOtVzQTkk8bUZOJ
	4qVica0km/+Zj4GjdVDPxMIsOWIr9tVzkwXnZu5QyOt5hCqp1oY53HLoOLIMXXPJB5wGUYNxDej
	djWgnwYuirYqVH6+rDc5vjyCMpmT4w0EoLhMhqIDb8k5+Cgdzdk3uEwLg16wzgW7rXw9MLws4c6
	KwrfbTwlclUyCiqOQ0iuPEnDJpaeQmrJfGtCyVPS/XtZgcNm/mxXAJwegcstt8pAiG2FCO9Di9W
	H8aur8dBlETakeAgf2VVzt23Y+GZzG/XNwij4vHVlzBGhEanEmMO/04xqYCVWDSkovVnoVtrNof
	4hqS/OTiG4nPy0LC8GG6ZAUOFveyFWlF+xNIDnPpqWssONJVk4rRngXm2jfyMQng==
X-Google-Smtp-Source: AGHT+IERjCdObduOqXZ7oaX8UqF7sHs4pQ6NQtq4FOaNwiNZd5TJwbQT+UFYEFtX/Kv19Ewgasg8YA==
X-Received: by 2002:a17:902:f393:b0:295:54cd:d2e2 with SMTP id d9443c01a7336-29554cdd55fmr54991885ad.0.1762250620759;
        Tue, 04 Nov 2025 02:03:40 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998ef7sm20672565ad.33.2025.11.04.02.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:03:40 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Qianchang Zhao <pioooooooooip@gmail.com>,
	Zhitong Liu <liuzhitong1993@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: fix leak of transform buffer on encrypt_resp() failure
Date: Tue,  4 Nov 2025 19:03:25 +0900
Message-Id: <20251104100325.343863-1-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025110432-maimed-polio-c7b4@gregkh>
References: <2025110432-maimed-polio-c7b4@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When encrypt_resp() fails at the send path, we only set
STATUS_DATA_ERROR but leave the transform buffer allocated (work->tr_buf
in this tree). Repeating this path leaks kernel memory and can lead to
OOM (DoS) when encryption is required.

Reproduced on: Linux v6.18-rc2 (self-built test kernel)

Fix by freeing the transform buffer and forcing plaintext error reply.

Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
Reported-by: Zhitong Liu <liuzhitong1993@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
---
 fs/smb/server/server.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index 7b01c7589..15dd13e76 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -246,11 +246,11 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 		rc = conn->ops->encrypt_resp(work);
 		if (rc < 0) {
 			conn->ops->set_rsp_status(work, STATUS_DATA_ERROR);
-			 work->encrypted = false;
-    			 	if (work->tr_buf) {
-            				kvfree(work->tr_buf);
-            				work->tr_buf = NULL;
-       			   	}
+			work->encrypted = false;
+			if (work->tr_buf) {
+				kvfree(work->tr_buf);
+				work->tr_buf = NULL;
+			}
 		}
 	}
 	if (work->sess)
-- 
2.34.1


