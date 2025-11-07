Return-Path: <linux-kernel+bounces-890545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABADC404CA
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D27DC4F2DF8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E1232ABCE;
	Fri,  7 Nov 2025 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="To2POnNR"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9858032938E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525327; cv=none; b=AMkiQFyUq6oG4cp2McIa8rKuYiGGvPcgdLvATiZXE2i9zBOvPkJe0DTfLlkcZEqaxmI3cO7jYAFn2fbaMdDQEFf6zDoDaePrHinuKV9SCu5r3mkaZ8MrR3Tly9mPq06iZu+wWczV8ihI4C6OzZANCk1Sfk9Jwl5wGk3VzgiCQgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525327; c=relaxed/simple;
	bh=wS2imuQ9BmkOhIkqMvqqB5gl66Z+pbAiZyZ4vNX0hTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAgIg/7z8hzHhWmZBWAPtVyisiEs2x6BywDAF1X1LZU3sn1rzjtvc35ajkC5asK/gjURJ6/24TJzbeNXeSsBwiHeT7QFNqrwQeOzAjAzex6bZQy0UeeLuId9ikHBVCZH9DQhEiPQfcuutSHWid4W1aDxYmMgh/zc5pQm7HsONCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=To2POnNR; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b72cbc24637so129510466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 06:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762525324; x=1763130124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALuLKFw+mr0eVU5vuPj8LnIxQt3AfWAYuS4LghXi6Bg=;
        b=To2POnNRLv1Z3RMuB327G2Bf9yjQ9YNRisL8V7Ov15aKZICI4Ofq0UP/LIsjXK3XcJ
         VM/LwdnxjyCrL9PnHBrxhsZCG+NPykzg0l0pv5mRfhqC4hWrY5m+Ozha1bnoZfy6+iYy
         l11vn2RvuaI5l0OjlNCmjYC2kJUYPQzX49GitXv5ByPDkv57UpscjjzZEbRaW9uWdpv+
         mZdwjpZyiDA7wRjBTnWpbImi0ZQl+ClMQo8gZfEUJwOETqt2ZIYoZ3Atbr3xsPzg11Sj
         6Sh9e9DRaAWTOuIlOxUa4w5h6K+nKUNG3PSqzYyCRRclZ8b3LfN9EDfyBN3NIdY6GF7j
         mAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762525324; x=1763130124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ALuLKFw+mr0eVU5vuPj8LnIxQt3AfWAYuS4LghXi6Bg=;
        b=sXOBj0RWt7TFCCjPsWynQkgE5/s24YZpD1vaWc2vDRSp8uz/BS7otQAME2uIiU7xro
         x8aBvqYNmadmbMLVd4OjG5QsOp0hwT64bzsX8a1SDpIaVfZsQ9OZvoCaGB3yvv3VSnYN
         2knP5Dr+c4DxNqC7CRFN1fHVGRpO01WIUuSo9ohxVHUe0Ch0wjpnrWroFNc71dJhRT8w
         0sY2OFrEIa9pJw/QYvsst7khLR/GF0eCWYl1h5HOzcnLG10v3dHoffKqymmo1sf8A1Ez
         oMX9xQqOHeRHBr3+q+3T8zILACWuCXDoc5bAcA8DBS0YdQkF/CmubZOV36IfE64BvV52
         YGFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUu84kbYT0P7UH4wTDqTGe1xN/R0ju+T8ToHL7I+5V5+EGtDIJDH97HAEkA9BqkROc9+j7Acs+n3qUtHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTTL2Um7mOSlvJzLUZzCd8PJeocwK6aTDMvXfv3f3sjP3pm7ce
	UCiaqGKk2WRk9HKOj9oBsCFvV0comwTnuOxRVAlWZK9FcZBdTpC4dgI5
X-Gm-Gg: ASbGncvDp5VouVeGhcjtWw27u+Vo91lLiGAjlXTvb4kUvKdjS6sLZnREdRv/4MNAjqT
	LR7KDbsYQnSKXs8ljd1iS/0dngFRW9MdYvhsROOOOd2el72ZuecQQUhlWDWPNxJcBjQo3btSPKr
	s4QQUJsSEPlgadYc+apDo1JJZROYzp80eKE5vigPBHPD7SLMbchK3KOape4fzTs0JsIJjIoHbEe
	W+iFRMOfm4eOfzJiU6jC237oCwY6SzK/aCy9vS0FNm7ib+wCFVJZkYNThNe+73iNy6JW5p/6cQ1
	jnUXbIcv8Lne3rECx1ZXV+3X8ArTYAit4wsRS+SEjZrKiXWc5sq7VktoTZUtaVu7TL4E5tqCCNd
	oh82GCvib+TeEAQZCeLblevPWKh9PDFxXxZONG9wCDlghijIWP5wksKfA23wnEyj0zqU0oMnwkV
	586lkl8CEvgKVfgbiuw9A4V01B6LyE5H2z/1mFPlbqMfICP+e6
X-Google-Smtp-Source: AGHT+IFYK2b9ojdXtTAd4PTW5XlFiit6Z3g1OoNfduNaJTNxwuPOLhjJOAV1QVecyGCifhAj28KZcw==
X-Received: by 2002:a17:907:3fa5:b0:b3f:a960:e057 with SMTP id a640c23a62f3a-b72c090e626mr342966366b.31.1762525323963;
        Fri, 07 Nov 2025 06:22:03 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97e563sm253322766b.41.2025.11.07.06.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:22:03 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	torvalds@linux-foundation.org,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 3/3] fs: retire now stale MAY_WRITE predicts in inode_permission()
Date: Fri,  7 Nov 2025 15:21:49 +0100
Message-ID: <20251107142149.989998-4-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107142149.989998-1-mjguzik@gmail.com>
References: <20251107142149.989998-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The primary non-MAY_WRITE consumer now uses lookup_inode_permission_may_exec().

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 6b2a5a5478e7..2a112b2c0951 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -546,7 +546,7 @@ static inline int do_inode_permission(struct mnt_idmap *idmap,
  */
 static int sb_permission(struct super_block *sb, struct inode *inode, int mask)
 {
-	if (unlikely(mask & MAY_WRITE)) {
+	if (mask & MAY_WRITE) {
 		umode_t mode = inode->i_mode;
 
 		/* Nobody gets write access to a read-only fs. */
@@ -577,7 +577,7 @@ int inode_permission(struct mnt_idmap *idmap,
 	if (unlikely(retval))
 		return retval;
 
-	if (unlikely(mask & MAY_WRITE)) {
+	if (mask & MAY_WRITE) {
 		/*
 		 * Nobody gets write access to an immutable file.
 		 */
-- 
2.48.1


