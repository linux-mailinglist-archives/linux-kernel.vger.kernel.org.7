Return-Path: <linux-kernel+bounces-851912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71D7BD79A6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21AF33B3BF7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF412D23B8;
	Tue, 14 Oct 2025 06:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ga5U1W9x"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC2923F412
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424268; cv=none; b=Gws+4w78WvgCa2LcyElNrxdpTC8cVKLsYEFlbi6Yc9XWEDOS/PWD4j/4bTWrEYqE2Izz/K13YFSIZZOzCWW7Ga0SBzAd7RmLuCO/DrQpXz3ZfJysMUrAQ9mnPgw4cRHI75Rn946VXZIHJuJJXxh/mwYRvONzNiqRh6EiJvQCFfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424268; c=relaxed/simple;
	bh=V+CC6CqFHTaY1+NyeeC+80xDdqCLgT5Z9/vBgh37BLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kaJv6GuSLgciK7fhAobNaINs3NESJKdFmqeY9Hzs/YEhtwsHJ5ZkEGgGrgPCPjm73YzzpB1TljtSpaaLbVBzGEIK39zf57eTrP6c2QfCuCDTaJWmFgUna01ltJvBeQ9YKaZaBAUR9h+iPnlQ0X7qRQ77wpdtIzA1CBLag2lRlNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ga5U1W9x; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3737d0920e6so53538061fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760424265; x=1761029065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f5+eQwI0Mb1HF7qS+pk7CGxcaFFpKMarYKASKjNogEU=;
        b=ga5U1W9x1f6TWvN0A/mf/H3nHmuu3XlT06iCzeKiwKQuOk05FS0Om3Dij8mkhf/Mhf
         TEnrOa0KiQo9IlUyITGbWd8UH/Pl3JKqAcagUPhZSCvKMLtXQBpiWS1Ayblr7iBV5DKY
         LNjAHEtNffqqgzbDOZCy/HXjxCGpGafOwecufUKroQQZLv1eaPxoPjjtFEDHaDmrxg8p
         HRfKvJh5xvWcSUo0DjQmLKx12m9c3SycTXkG0yp8CBl7YuoOz95DhC30i7Kv0hZv6s0a
         q318ZhDKyexwjOsCl4NJSM1NxDds+jGdiV/p9URr/OWZYBpp5a8vwhbegl4lZCtQODIk
         M84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760424265; x=1761029065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5+eQwI0Mb1HF7qS+pk7CGxcaFFpKMarYKASKjNogEU=;
        b=TRU/RcwO8TKY86EDUIqgO3cToaocze9RCZxSzU3D6klr0EPfXE/Bu3xOo5rWae2N7L
         Uq8oSE44x5BntR1WEKx68ilfXnCXI/iLk/kJPKLq087sv6drt3E3iiBOKZy+GXBhnEZ4
         6y9GOKtnNMaN5BnlnN4QqbyXHAfyz2ISPXR9I2AhB0nt+6v3rJ24+N60/tstDJmPj04I
         XnkHMkqPIS57CeIUnE2kkPhWL8GU/S8sJ8IcfAKl3/DIzsKWfO4AN0bs2Ye6Lob1/CvG
         it87RO3nc7GKhCsDi/tsVwykQw2c40LrxguNAo7BfDHNeRP6HZyOCQnvhoMgV/hEHYEZ
         GBpw==
X-Forwarded-Encrypted: i=1; AJvYcCXX8oaG/U9SH/9KlWQ1xTwdM1cNyiPTwqhS4RKFdfr+YYvu+kWTa/TcgSfEy1bhYCpj5jp2G435VhGNg88=@vger.kernel.org
X-Gm-Message-State: AOJu0YySWEMYduoassESvjBidZvpueO9jPszpkw8D6aPtirCNQsr1v/q
	A4l02MqnTnq/Tc1aic9WN4oysLkSnWMrF1ddv4WZgSqNnQXNzyqYLBkJ
X-Gm-Gg: ASbGncsoyQLvBttGrtDM2Zqf0ECVg6s8DMURohTciuvhRFVHAnB+XOmgJ+6CklnPf+X
	mj3ao3nihhJyVLBvWJVSZ9xVcB17wA79fvl48hC2N4Jwm1gaV5MzS36gwzsenz4m9KKOjXUi6Ov
	YxqLubmVjEZlvYXtgx3LVgnJdJYwYSgHeSMXqxWk7mCdezuyoC9iVO6F0E6YGfkdkwo8GW8J2aB
	oSMS5sE5XUqzkOXwmsxr63uEHkqe5Buaf6l1J06WTcEZdNMaxDSeGSP2/d6lY6HrETiSNclVUQ9
	U1mq7+cOkA715doMY4oDuFwPFmTWJz9NP/WDroL/KmcxV1S4q+pLsXOHYzSzD9Kg7R2XKTbhs1P
	Mfp3B6FI0GF5YAf5Eb2V7Rw4m92FTdvr5jJdGV0uNPSNIRaszU0fa3ALlzMWuIODnf6fog4s4gT
	k8fh6W5aWJr9OT5Q/ynhxV7z7qEwNinuLXfpLgZLfKc1e8/g==
X-Google-Smtp-Source: AGHT+IFmJuJ2Gq+zrXFJtzs/AN5vXoWk3MaDdcP/25nb997AM9Z7OgvW2leEKAh+3KjJwP/5Rhr/KA==
X-Received: by 2002:a05:651c:35c5:b0:36f:77e6:d25a with SMTP id 38308e7fff4ca-37609efd7d5mr59354151fa.43.1760424264333;
        Mon, 13 Oct 2025 23:44:24 -0700 (PDT)
Received: from localhost.localdomain (broadband-109-173-93-221.ip.moscow.rt.ru. [109.173.93.221])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762e7b47ddsm37943311fa.21.2025.10.13.23.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 23:44:24 -0700 (PDT)
From: Alexandr Sapozhnikov <alsp705@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Alexandr Sapozhnikov <alsp705@gmail.com>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v2] drm/i915/gem: handle drm_vma_node_allow_once() return value
Date: Tue, 14 Oct 2025 09:44:16 +0300
Message-ID: <20251014064420.11-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing return value handling of drm_vma_node_allow_once() 
since the failure to insert the file tag for the node should 
indicate the whole mmap_offset_attach() failed as well.

v2: update changelog and return error directly as Chris Wilson, 
    Andi Shyti and Ville Syrjala suggested.
link to v1: https://lore.kernel.org/all/20251002084828.11-1-alsp705@gmail.com/

Found by Linux Verification Center (linuxtesting.org) with svace.

Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_mman.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
index 75f5b0e871ef..eb76f8f2bd95 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
@@ -758,8 +758,11 @@ mmap_offset_attach(struct drm_i915_gem_object *obj,
 	mmo = insert_mmo(obj, mmo);
 	GEM_BUG_ON(lookup_mmo(obj, mmap_type) != mmo);
 out:
-	if (file)
-		drm_vma_node_allow_once(&mmo->vma_node, file);
+	if (file) {
+		err = drm_vma_node_allow_once(&mmo->vma_node, file);
+		if (err)
+			return ERR_PTR(err);
+	}
 	return mmo;
 
 err:
-- 
2.43.0

