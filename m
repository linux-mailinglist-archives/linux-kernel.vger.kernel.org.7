Return-Path: <linux-kernel+bounces-880264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BB6C25430
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ECB04241E1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D5734B42C;
	Fri, 31 Oct 2025 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XccuECJ1"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C61832D7D1
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761917224; cv=none; b=oNYHHEJKUlu3ZF/cI6zRQToaY29LA8XtJJu0DmkNm+gmRhQXpmFO4BHc87FLSrQZ2o/kw+dP/RtCI1VZSK/SL5P6ioSiI+PtnzkjA5iKQ0hivR+4ezDJa2eJaVzJcl1RpmYblX2ndDwRmLr9Ic4SZ8+maFNG2YXufmfvk5pzOKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761917224; c=relaxed/simple;
	bh=uhaCwSbT1CmynaTtFkFUfd6VKh41RVQZwtYLimsYg7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PUeS+RQfTvweXCD4jPI8mrDiDr54rjLiyKF4ILxEDJV1jf5TEpMN1YTNkpQFpodZyXsfE+n5p5Pli79gkej8t2FI56Cb4VGp49tuFUOxsttxV8ASEii6sUsR6gSpQKoQEH5NMmmgdnFhyo2+5qnjrIqXmSIwaRfRRwojeJ+Dko0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XccuECJ1; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3408dd56b15so644165a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761917221; x=1762522021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WrmdlO7loopDlm2CqslnppoVSdxtVgkxG6FfUB2qsow=;
        b=XccuECJ1h8F58ezeiX+S7pyhbOOK97N6iub3dkg4qRuM3AjINAZ1HO/QDn+qRPdRtV
         uWnR5NPk1jCkV8etFYcJtQ0dUpx+WISpOYzq5KpZtYGzJyOWyvc40G7cvM+r1AbWJdPG
         WagHtNzTfX0muUpZqGH782C/fIYDX/zGkPt7JBOyUOBSGq2jB59SPx9vvOXd6UJc/clb
         c4ApnE/lBxPAX/x24A4tUPVQquHK89dv9EhmD8Cz6MYHad7h5W0d+td4pP9nc63XW4II
         Nx3iBEVDLdEQmIc4Beh7g9BvIq0i6HIS0RwArPJTP7/uzejKduHz0O4m0H9JTqC+G8F6
         zt7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761917221; x=1762522021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WrmdlO7loopDlm2CqslnppoVSdxtVgkxG6FfUB2qsow=;
        b=hSW0LANDM+WkFntZBmcwW1ttC5MIDcxe+bb4+lPbOc3CHVlGR5wUQuJMs9z7wGO435
         loMQEZ0wxNK1ENmZhZZx1fUEe0KWbf52AZ1+2QSR+WNg+Lo353nz0vUgP8+rwkaGLuZ4
         qCIteblrHGuac2XLVbKNh/n/lmVEiPhXfPZ9ZMVQ6es+0DZ9wxqZHG6KjpbV6W91DJV1
         nKsAHBU5uhtC1NknQL5O/Wfu1MnXh3fBdWOTf6hezDXYLwDQ0eUj29MoXjhZVSvrvW7S
         Ai6uNp9LImSnI+T2Ga0hUkXV1hz0j2HkePpKCG2JTl/wYLVIv25CkmVlDrWFba+TsU99
         ja/w==
X-Forwarded-Encrypted: i=1; AJvYcCUzrcjZ00Bdhmb01TCwL+dj6JZS7InofkBYpVDYPidaSyvj/sYuubyHAHnjmxVGo9QCD9ywzwwEOa1zgjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgvbiIz0ECBsp6tpKf4Yj5qX7Mx5zR5O8aOM9Kmcr6cGm8Rxnq
	FhP5AjhKSrK4iYrri07C0xwFW8Fvu2sX2iBs3jstQq+XJ5L2T9xaQf5YTmAe7nI=
X-Gm-Gg: ASbGncuo35vnMyldVf2K1+rbeLEvTFiLvIspkfgPKMhNvcK9O+JXP9TEEM99/6hLyjS
	AZgRlWfBglUTKSMJ/a9qr7u4oZ5j4EZ4a59Eq0hNbyiwFdgTVkt7QK5zCo/sC2jFE/SN8UOBGiO
	kyq8gO3jQTBlkF1rhiynWam0Q8vjsoKltdQwYsW6w4yZdc7r1ok8V1tcl9oxd+LsBJ9Im2hxR6P
	zjUxqXhwmWntP7e1MefvfgcAKGzdRI/FGHvtw5tgvwJ7taZmw7yw2YGURquHyY3OKnP+ZxRZco4
	defZTzseMNw2HipDW2/QYgFuneTGN3zYx/ay9Dzx128qmVIeG8kbYaAjMhEE7JTUfb/rbhF4uVh
	TNcY92RopaR2peaClI17faUM39eO72HvVSjVW7SZ7A+Ag37sSAamhywk7jm5T1mQvi52ZqHWLrX
	nofsa1mj7d
X-Google-Smtp-Source: AGHT+IHzfVYSO8+J0zNhvwv1+BiO2sqnk9KJnssYCkr+vJvVNaYHRPB82I8IkIFPSwlKvjWLwIcZzA==
X-Received: by 2002:a17:90b:39cc:b0:32e:a54a:be5d with SMTP id 98e67ed59e1d1-34082fc92bemr4683310a91.2.1761917220515;
        Fri, 31 Oct 2025 06:27:00 -0700 (PDT)
Received: from VSPRIME.. ([2401:4900:52f2:3b59:ca2f:95c0:7c6b:6e6a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34092d48252sm2232712a91.15.2025.10.31.06.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 06:27:00 -0700 (PDT)
From: vsshingne <vaibhavshingne66@gmail.com>
To: skhan@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vsshingne <vaibhavshingne66@gmail.com>
Subject: [PATCH] usb: core: prevent double URB enqueue leading to corruption
Date: Fri, 31 Oct 2025 18:56:51 +0530
Message-ID: <20251031132651.219859-1-vaibhavshingne66@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: vsshingne <vaibhavshingne66@gmail.com>
---
 drivers/usb/core/hcd.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 87fcb78c34a8..66861f372daf 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1758,16 +1758,15 @@ void usb_hcd_giveback_urb(struct usb_hcd *hcd, struct urb *urb, int status)
 		pr_warn("usb: URB already linked to bh->head, skipping duplicate addition\n");
 		return;
 	}
-	
 	list_add_tail(&urb->urb_list, &bh->head);
 	running = bh->running;
 	spin_unlock(&bh->lock);
 
 	if (!running) {
-        	if (bh->high_prio)
-                	queue_work(system_bh_highpri_wq, &bh->bh);
-        	else
-        	        queue_work(system_bh_wq, &bh->bh);
+		if (bh->high_prio)
+			queue_work(system_bh_highpri_wq, &bh->bh);
+		else
+			queue_work(system_bh_wq, &bh->bh);
 	}
 }
 EXPORT_SYMBOL_GPL(usb_hcd_giveback_urb);
-- 
2.48.1


