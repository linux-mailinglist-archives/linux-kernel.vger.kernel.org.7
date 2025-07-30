Return-Path: <linux-kernel+bounces-750294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E90B159A2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 017F118A8269
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A5328751A;
	Wed, 30 Jul 2025 07:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hItgKbn6"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616E92874E9
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753860774; cv=none; b=QY8PicwlnXKHBAjrxMrShwUS7yxk6be7UK+uiWnK4Gw80ktFLSsignsmCiaeUUhtx2Aqgt93174q/gPER/sZg5jHgWgprPhkzpkCaPg8tmEW0S4Dl968iZiZTZU8oMi63OX79JuRCmCgbEEF/PsIscmIwMzoQQjPsTgUE8VDx2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753860774; c=relaxed/simple;
	bh=O32Ie8Am603046JA4arS3OFon7lXrwsdPMSnmBgjKFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VgRGRwSkBkQeLuB85jb3mR3w0blrWLIn9HyQWzoFBtMvdLs0CxPRHUA0SNr+dnxWHrPeuHcVLSVFSGtJ/hQVPfbkRcsvgXo9wMAqbPnjObExj29+2CGCITSXeX4e/SxJCxSeLarx6TCeHYDYGoFikoDWgXiOtZPb+5jD9vjxCA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hItgKbn6; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ae721c2f10so59807401cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 00:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753860772; x=1754465572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QgyZUt2WJh4tQvZzl2B9nRznrnVSTuASTHr5LO7G+E=;
        b=hItgKbn6JBr86Czfdc5voaYW4DR1yIMUQnbHtjmdxUmN88I03ull8+iYW3ASbeHyAi
         nGRBAGOn4FPyqfXreUBZYo0o8jyf3kdzLqqO/3U5K5SL+SF7W6AEAo2GTlghf/MeRIhl
         kVxnYK1pAJsmhDop9JSxH3z53DzMMl5323mM2kJVoixmvuSg6UKBKQAcTIqvMTLhPd9W
         2s2F/8lziLrS07jjG8fVPfGqqq7E8bYFTSMZ80WRh3fd3mW5CKEJuYYuJ8Do3VIgXj18
         LlRboMdRsxbXmsUqb+Cx/YD6BkkQnSq4KQ5pEHB7EhiBvnf+kwo4l4PPwrQh/TneLRBO
         ntWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753860772; x=1754465572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QgyZUt2WJh4tQvZzl2B9nRznrnVSTuASTHr5LO7G+E=;
        b=Ggz83+0lWir5Sh2VDi16HQqDTabbVAEh8Nor8Y78fWviw8b7eV35FR/CLcAGJj9OoH
         SsB5U5NLhfsFR0jtTdG217iTvY4wq0TD14mawk4Kugi3vc+InPCYZAwGf0uSrdRMYYO8
         tgAaFXdjY55PITRyqYCyzi5gLO3AGWHxHC7IyPv82Y3YV2AWlWsDjfyPKTNe+5zoyzdn
         ECSq8hZrxi7/xHibRfyeZQmQ50MukkmpzHCQ43LfCKZhSDiDDjCoNKrue45aWtt0glOY
         tZ4d2OmTWcI1DvA2GQoUiKV0M5LYEfLazwWMk5OdgkE600RC8+TOi8lpxp4e/TX1X5rH
         5tTw==
X-Forwarded-Encrypted: i=1; AJvYcCXZIh77ogsjkfIRvJOpaTFjgnHoGbtgrkTCCOF+fFMb9+WLW4PN1XTSsVH8yHZWLZoo0GT/OSpViuqDDx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YykoKEwau0ufOGHDXlrvkcroaQ3cKwA7e5oaGIN2+N8cqZo3scI
	Pul3QPFHioNnG3WkFm3b4LjQICJiF7U0nqXUGTQyuuNPLfW5/Zd5w+3a
X-Gm-Gg: ASbGncsnb8MyP5hn6dFPxY1J5TaihCqNXHYvwFO1RWzP9BzbbcJhWt9qo9BnkK02K4k
	ybleaTZXdEDlLZLeG3n5rqY4M9EscQIdR/+WABZzR/jY5YjPF1tRJYyPvsWYPxIdzP8tOtuL9bn
	tenXRWrdAsD14oBB3PDdEEC1Z3MPbm38f12Zo0PnVaG9cBzjBXNIoLhg5BVak5nt/9UrxdFGlea
	57C2Mctugw0CnXfz54B8H0DB8f7A63tTiHMOWM1c4x3PSU0YnK2e7JtylNgKZ7BUV6nrmrmL846
	VL8nFc3+Av85rEcsGB4hkubovzcpjKaLJ4p5xPY9Lfpk1AgesYFgbdToFGS64qH7Tv871U9JQFc
	v7l6cqsQXuzsCE7VGOsx/KVFa7HyxvgZjR26RpwcDNump6ivV1/g=
X-Google-Smtp-Source: AGHT+IHmqYte3ijgzk02Zta+BjezQKmqmxp3FWkE6qrzg1Mtefch78YALl0dEgAi+oR4A+BIuxjeyA==
X-Received: by 2002:a05:622a:394:b0:4ab:417f:aa44 with SMTP id d75a77b69052e-4aedbc59df6mr41746121cf.51.1753860772151;
        Wed, 30 Jul 2025 00:32:52 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae99545512sm62680331cf.21.2025.07.30.00.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 00:32:51 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: vivek.balachandhar@gmail.com,
	Markus.Elfring@web.de,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v4 03/20] staging: rtl8723bs: add blank line between rtw_roaming() and _rtw_roaming()
Date: Wed, 30 Jul 2025 07:32:24 +0000
Message-Id: <20250730073224.490578-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730042032.488456-1-vivek.balachandhar@gmail.com>
References: <20250730042032.488456-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a blank line after the definition of rtw_roaming() to separate it from
the following function (_rtw_roaming()), improving readability and matching
kernel coding style guidelines.

No functional changes.

Identified using checkpatch.pl.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
v4:
- Changed the wording of version from "Changes since v2" to "v3" as per
  Markus Elfring comments.

v3:
- Moved version change notes below the '---' line

v2:
- Moved the '---' marker line below the Signed-off-by tag as per kernel
  patch formatting rules

v1:
- Addressed review comments from Markus Elfring on changing the description
  of the patch regarding readability and separation between function definitions
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 357fc6a56c27..f8680124ce24 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2449,6 +2449,7 @@ void rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 	_rtw_roaming(padapter, tgt_network);
 	spin_unlock_bh(&pmlmepriv->lock);
 }
+
 void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-- 
2.39.5


