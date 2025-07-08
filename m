Return-Path: <linux-kernel+bounces-721102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 433D0AFC4BC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B861AA1437
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4410829A9D2;
	Tue,  8 Jul 2025 07:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="df6FoVcg"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382AE298CCD
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 07:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961309; cv=none; b=ApYnbMozJy+fo5QdfFE7bRWKtc1LwaTgYfSfG8MhSOwK8dwIa8cmuWPufOhvvmYwo9kVSPXFGovq+EoylXOMELLoBpZKdCl7bV5J2XDSlCkyJKBNRT5dSew42AAA/iWIRF9crrGCB+Ns46p3e/W8WC98ePFjyni+oEgksD8Rltc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961309; c=relaxed/simple;
	bh=SFYJ9F7huYqGN3attK23C+QMdeDJac4QlSPKRrDU4Dg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=r2f8onJ4ng9I4kYR+oa4XE9yeeJOYRJMF8IZEe//4GdhfyJ1eoqv2y/3Ac/h+H9jLFP2poXsMdxuNvvyTTKtTFMmYi3wEA27OYXfyiawXOeMOQsgQwD3tTiaVobU8kGX6B7z4vFveqjcgfoTUssZxO7c+kjzf3PyQ118/Q3cGOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=df6FoVcg; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70e3c6b88dbso27129267b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 00:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751961307; x=1752566107; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=unanIWyMjQ+vHf7d8Wd5oX37FaPuC+rf95W54Arze8E=;
        b=df6FoVcgP6jz+tA+aARFu+cjhzKIn+tlxRcs/w1Ajt/PveIbitd94b248feZ0c0Hob
         BSqg3t19CcnKb080GbUA6xfRGbFyy12AAq0KFMYDv1EyAZdUD476mcoVPryB/DP48d5P
         tVtZVpRLdWBcxM05y+4eqiABCoLq99xifrTxJi7PWaHt1QEqHEIu+SGFYw7v9KFrqSRH
         EVNl2ZuUMz178pClWzn34JjWTINTmaj5cA7AjluFCROY69+7JSAOsj6FoWXwd+p/cAWE
         K5ake2x6JU7zCatAv/VKKh+Ngs5cwuS8DHqrC1KE8/yBgOcKYhkjJDDPMZp8ZivhaGGX
         e/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751961307; x=1752566107;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=unanIWyMjQ+vHf7d8Wd5oX37FaPuC+rf95W54Arze8E=;
        b=IFyUfLYDc39kd3khTqMVcxm1JAWP3BdWUxWF2PSMbUurDYkL9yP45yM8R/+PaE02ri
         8/rrCB7SppJ/L1dPC01ep+D4RNOLMo0F/501nwjquTRdwe5LmZPA2nYMwzmXo1g00wWu
         AR5vz+VgqAp6yVvR0b5yXpiu7UmvmAAnDQKeP3sw24kvpx5tfEu0R/W8YlN7HHdkPiKB
         JmOkO1FWS2wcxeUd5+8HTgI4TJrkYitJbJ82yivdnhfOqIf+EPdOQEv2DubalZwms0gV
         BMFgAhsFDCLYDs9TkikB7NCyXxiCKLRLM+lSQBzpeJovlvkRNj7TUhZpKQX0ZuVy2pXF
         GKRA==
X-Forwarded-Encrypted: i=1; AJvYcCX4cq2lH5nJtjhIToLTVqT+z854fPYBfYWhrrPqy2sKEJ01CHRT+wL+pH0hKDiAe2EpCBtSf2DtrLMa1R4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMlZbHowpj3ZQ4LlTMzrkFzeOdnzk0ecPxNOy2s+TL1dv5kYp/
	Sbn6+W6U0/b9V6VPc31DB5d1mA0XM5ijvoSyPny5Mq9yQxuo+wVXx9HE/fxwn/mHV4RRLqXcnSg
	P5o1QNRwDWDjTZa0hngiy7TrSU66vIIA=
X-Gm-Gg: ASbGncvImsPda0r7+MAeX2HnnijO186LuGEa8rBu/wxSsOyLLWEc47MPPItvjh9h1W/
	qHCi1ePFnahkuvcHWvnHp3OMqbrHkG+XS7UoVsJSKjXOtJol/y+0bk/4KPA6g4ilImh40Jr8KkG
	2H2T9aXRFPRlxB9atEmEsq83bz5sppD0WFlBY6HgiMeJMh6fwJcNE9pbvChx+xS32VxfF8LwLsX
	vr4
X-Google-Smtp-Source: AGHT+IFXKifAScORyZguiMoMWqTCt3CMHazmqXK1SBZk1Sap7bwF7y/fZva4KW9i9L5nvFPJCpqfn7D9xvuKGJD++hE=
X-Received: by 2002:a05:690c:7241:b0:70e:7ff6:9ff3 with SMTP id
 00721157ae682-717a047fe9amr23118597b3.35.1751961307087; Tue, 08 Jul 2025
 00:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Moonhee Lee <moonhee.lee.ca@gmail.com>
Date: Tue, 8 Jul 2025 00:54:55 -0700
X-Gm-Features: Ac12FXwGPoEdJrb6bmrbXp7t12R6zeJ0T_YO1VBL5JsCd8QHB1bvQPjmPk1YL3A
Message-ID: <CAF3JpA5n1Xb7h_RWG+y10zu_cbciPsppv8Pnetmxw6QXxi1D9A@mail.gmail.com>
Subject: [syzbot] [ntfs3?] WARNING in ni_rename
To: syzbot+b0373017f711c06ada64@syzkaller.appspotmail.com
Cc: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz test

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 1bf2a6593dec..15f3a711ea0a 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -478,6 +478,7 @@ static int indx_find_free(struct ntfs_index *indx,
struct ntfs_inode *ni,
        struct ATTR_LIST_ENTRY *le = NULL;
        const struct INDEX_NAMES *in = &s_index_names[indx->type];
        int err;
+       u64 bm_size;

        b = ni_find_attr(ni, NULL, &le, ATTR_BITMAP, in->name, in->name_len,
                         NULL, NULL);
@@ -488,6 +489,17 @@ static int indx_find_free(struct ntfs_index
*indx, struct ntfs_inode *ni,
        *bitmap = b;
        *bit = MINUS_ONE_T;

+       bm_size = b->non_res ? le64_to_cpu(b->nres.valid_size) :
+                              le32_to_cpu(b->res.data_size);
+
+       /*
+        * Allocated index blocks require $BITMAP to contain at least
+        * one bit for usage tracking. A zero-length bitmap in this
+        * case indicates a malformed on-disk structure and cannot be used.
+        */
+       if (unlikely(bm_size == 0 && indx->alloc_run.count))
+               return -EINVAL;
+
        if (!b->non_res) {
                u32 nbits = 8 * le32_to_cpu(b->res.data_size);
                size_t pos = find_next_zero_bit_le(resident_data(b), nbits, 0);

