Return-Path: <linux-kernel+bounces-773345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3E4B29E9D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858F3189E93E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8D93101A2;
	Mon, 18 Aug 2025 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kuEHS/mf"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCC2226CE5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755511164; cv=none; b=fz0GrYqinYKodSHKLO4qvshfH0GA5IEQsWp5RXiY6kQWnog5w5WvT0B9cNYcgnnVaIjJA7oyFgQfsY//9CgSscH4H2ZI+gl8U+TvlkEYnul0rZpfV4EwtlJeylP3hFY1fFCe3wxploqwkFff6PQ2JBghSg+/knemE3aP5IANV8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755511164; c=relaxed/simple;
	bh=/C9Csrxdh1sYcqWltONMtXTrt08x9QqeTMlZNgDLvCI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m/tgY7nBQYOtITt6xW2nZmguiz6a2P2/SeSf0B27FPZIh+kFXU5QNBL0wjDR0paAjzbOeF0TNdPi7iSg3JcKJFOnYB6BCSrOjpRfcOLu3SZP+N+yEg3AdBpPCUUghc5V+xYXiNlkVpQurVgtISoAP215v+BBa5k25+9je/9rw/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kuEHS/mf; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b9e415a68fso3739230f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755511161; x=1756115961; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qZDLlNuYLU9UmeoCuzZO1+X4n+CJQR7oR8AjhafJt6M=;
        b=kuEHS/mfIyAN3GAxIk1mSA1lt4VDPAKXPuOoZDzsOUvJgimm7zdIbPsix6fbyNMtZt
         kEfQvqKia2oFQHzd4rOLd+gwM9DlKm0NrXVLZ3KOXKvTPtEoY/y4bbTvAu1qeU46Vg2H
         mJNChdIixR2De/GddNzrHS+/ktE5suyDaulm96HyhgpdE8i1UjDk2oSIuegAvmDJGAjw
         WtxG0X1O+dTVQHgR/K83bjTwq8dg1tlt2zOgAfcdWybu7HR9lPN/hnq22Hak9hxdQoyH
         54FqEsRRakwPnoS5UYxTR68itfMc4INvkLOD0YYXtk3W+JgVvpeeKCQccmoDppARhaBB
         wcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755511161; x=1756115961;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qZDLlNuYLU9UmeoCuzZO1+X4n+CJQR7oR8AjhafJt6M=;
        b=fhtVMBryD0dLqIf23627Pghx1icJtZd/IRUkLY8T1PaqsN5Rel+IUnwckY3HVTZk2z
         H+Y3NYInLvJhpJIr+DnTHgvUELLnYFjDyzMuciN0CzjbwNjq6MyZ+JK0RhgUQkmXmeBD
         MAtJceSruZ5JyzeROwRjL6tUYq0QFksdOicBTjg4vV0FWIzoKski4lBRlFPc9sco0LT1
         9XndPtMyO2Bh8Fzg5cEiKofSJNFXQBo/fNDyFEgOupKtQuzS1gNGdLM7xIye2ZOIzSFk
         YhZwhzKFANuZYjIHtAkqY3GcCeDX/QwY09kGMaLgWCzcaZCqyUWruck0EFFDYcwPPXOt
         hrAg==
X-Forwarded-Encrypted: i=1; AJvYcCUBDxcBWlsN0i3OS2/blFDIZ91ZP6ZaVmHO1dY1E0E+SkBwVFt55EFWFBt7hgHGS6A3i/06O3DBfuZs0Cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YziPc2fl16FUwyRTjBYSvychlzbORPGXhxhH8L4MxifJDFx4xgU
	97Ed2WO9wiqf+9u1fU9ukJkZeuCl7czjNhymni/Bllu9pxq7G802PFt8CWikcCTedEU=
X-Gm-Gg: ASbGnctE3lC3N2AhD0g/hzVCr5Sioo67VXWsdJGU1aAyhAsy1EnjB9tTxAT+cDo697k
	qVFFoYtCSKUCJ1o33slR5ka7oUluwWYDXt76Q5jgPIf2Nu3oqM7AE9PkoCxL7IqsrBhf8B3xM77
	HkT450pfgt0ZR+1EmV/YVcrOaqbyDCLFU85yby2iNNv4+/1Z0W3uqjGjA3DSOyJRS/3jSvU2kRI
	/un+7ZqYuzAprg1p4iyoWGkcnsjRDpZeQzVASBkw2n7lMdrqKwnndxBrIq+/t+asxuUdnpACGjP
	OmP6w2GO0iwuwEN4vX5Rxi90b1mQWJM+G6G95f0F5roTR1JTDUVN4RNtpZsdABTMw1YLbQWUGST
	qeYIzX/rIzmS0A1QkUIhHzeR+L+nmQrPS9pMNZEx2u0ZKZG9+yQbmJg==
X-Google-Smtp-Source: AGHT+IEAVhk6tBtT8QiYf3c/clKbpVmq0dinSHoKmOjMnv18pQ2Ji8dtljdjZJFXIYwlEZU7sho8fA==
X-Received: by 2002:a05:6000:24c2:b0:3b6:936:976c with SMTP id ffacd0b85a97d-3bb66f0f6f2mr7896857f8f.17.1755511160898;
        Mon, 18 Aug 2025 02:59:20 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a22329b12sm126502615e9.24.2025.08.18.02.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:59:20 -0700 (PDT)
Date: Mon, 18 Aug 2025 12:59:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Wang Zhaolong <wangzhaolong@huaweicloud.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] smb: client: Fix NULL vs ERR_PTR() returns in
 cifs_get_tcon_super()
Message-ID: <aKL5dUyf7UWcQNvW@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The cifs_get_tcon_super() function returns NULL on error but the caller
expect it to return error pointers instead.  Change it to return error
pointers.  Otherwise it results in a NULL pointer dereference.

Fixes: 0938b093b1ae ("smb: client: Fix mount deadlock by avoiding super block iteration in DFS reconnect")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/smb/client/misc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 3b6920a52daa..d73c36862e97 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -1116,7 +1116,7 @@ static struct super_block *cifs_get_tcon_super(struct cifs_tcon *tcon)
 	struct cifs_sb_info *cifs_sb;
 
 	if (!tcon)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	spin_lock(&tcon->sb_list_lock);
 	list_for_each_entry(cifs_sb, &tcon->cifs_sb_list, tcon_sb_link) {
@@ -1141,7 +1141,7 @@ static struct super_block *cifs_get_tcon_super(struct cifs_tcon *tcon)
 	}
 	spin_unlock(&tcon->sb_list_lock);
 
-	return NULL;
+	return ERR_PTR(-ENOENT);
 }
 
 struct super_block *cifs_get_dfs_tcon_super(struct cifs_tcon *tcon)
-- 
2.47.2


