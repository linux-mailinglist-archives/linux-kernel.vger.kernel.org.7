Return-Path: <linux-kernel+bounces-870285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 684A5C0A60D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 11:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67C404E55DE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 10:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D66D22B8AB;
	Sun, 26 Oct 2025 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPxa2L4x"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360301DDC0B
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 10:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761474501; cv=none; b=S5yUvRB+X0SI4opfKmMdr/M7FCOb/DDY1ph0sBQ/rV+d8eqPvATVq+Xcvr6o5WkE+cnuNs9oUrZvQXkzlzGFP2HVcPxAzlUkhFaGk4dnynlbouaoN2VeJvcE6YyisQdKyjlG6kYn4YxvQEbwD3QD/TfwlMCFA2DHXUUGIbirXak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761474501; c=relaxed/simple;
	bh=8dzXp9/KYqQYHVACjQCZvkxplsXyD0cYJB0DhrM70So=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RCsk1HYpXaZ0uxIoHwG4y07yDcPdDZoOnJmAEsNC6qwsdZVx7vMgT0C84Z2Bk2FdLm5rDSm6b6m278UFiOMWg+N56mf8FtEOU9/cR50hWkeNfFjVLH4IDCUnm271ZU43+0LKJCUEWgFwP7ga3bJn6iAOCkmRokIeBRToHraSAws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPxa2L4x; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-475de184058so3131795e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 03:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761474498; x=1762079298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=51VY72e9FEkKqG6+2mvOCEhCmlAcbiJMrlSp3dN7Jrw=;
        b=UPxa2L4xjlSxrVmahynXt2RcrjuoawQmb7szsP8iv1HBSpJkprtyurQFQRJ6RBKe+C
         CL6iWDWjDWAndetHa9ymLViCq5Fl/4wW85HFzg/DohPjU7D76K2HG3ggH+lYO1Pp199N
         XPcy2skCpXhobTEsoU5R0BNUdJtcB7WI8nCK8y7a9O1KsPDvdHnbWmZX3igmd60dO2qs
         6oBpmlD904LQwJH0ZjdRWPLXMCQDaOrm6g2/YvAKCWgcv5BzqJIt1667TN106ZBy3UGo
         JoCwjReBv2Rw8O2uXQHC54fzOCXaM70vVFQaYdi9wAb0JhqRBpAv4oxPfwSe6RVE7D0c
         rhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761474498; x=1762079298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=51VY72e9FEkKqG6+2mvOCEhCmlAcbiJMrlSp3dN7Jrw=;
        b=MGX+fKGzqjTz/Ik9bvo9N007l4b0e92zm1MH2KjdhHo3Q8gDxqMKsDvMyBbjCTpcLo
         FGDRBXeS8qIz8Uq3OeuZul4P2anEEExsJWqr3q4HZceW1Mabv9lgHft4L9syvTdr3LS2
         kWIUPPOYrxDJb+wF6tQsUc2Bcer7nipOKQ0jgIQoxjI8OOwzaEfIq6hbvBcFeMLe6rQX
         HRTSLDjut36UIwiS/ScZD0DzAsrz1VtgcjO/UlCmqSGYck5K1EegO8ihMeCXndrbXlVr
         zJNVn09YB69KSuozZUhMg2apVOsGs2+uO/Q9wLFal8BssM9o1/Y4sz7TB8Jk8A436PSk
         19Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWeYIxhd44xO1m32bPC0URXE8J2jcdv0Ol0CgsqmffFfBSnZ7PCwt0JIDOkmd8t5BzzfR7uEynEYBpcqCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFQt28G5zICK+0dSrUA+gQghbHhb+w5nSjSdQeqwicH9kerZNn
	LSFmnngSaLC+1cb5o/QyuMQIt+olhFhjNC22QXJwx+Jj/6EIIvF59wVN
X-Gm-Gg: ASbGncul2wVvKhrtAxwktTN7taNOugV118fOC6M357aC6oeGRz+/1Z9hiHZadHBM9PT
	UYT9EqckRtXdt2Z1q7ipwoSqCA36L4zPziYTXJixAGNUcPlo4Mjz1QqBPk1DSRRSEPaCX7y84yG
	U4AAvPQGhk+Czc0BlbeHF91vxBlP8QVR7CZXmWJwYOgPGvbWGIDE6sZcDnRtCojK+ktMxAoMdmz
	m8iGuHtl6Kdwl6/PEdqYDLb0zOaAVH5acNerF78KwMsw3StEuZ2/vH0LIm4rCr7Vmh9epUK5lIH
	ptmPLMfxsz3kZl+o1lW5SuGnJKo3UWEpUst2NC6azNY3Lq+Dhh3/W2CjKN2SN0XOQOqV0GtSO5E
	OHE5lRdBU1YNcR4I0bdPr+I6Yx8If+TEdMvkPLbcaPw10lQHV2SL2Xqz9G+6ljywekp8x20T9nU
	C96ailT5kV+pDSPLhos9mMFTS9LKdgi415J8vcghs=
X-Google-Smtp-Source: AGHT+IFan8YLfXlnFjdb3HdJpuP0WEmGtDW/qHZWAeEkrfQ3GytKpeE1q5lo/KTTnMIwVAsGRbrQ6Q==
X-Received: by 2002:a05:600c:4446:b0:471:1717:421 with SMTP id 5b1f17b1804b1-475d2ebf3e0mr65347725e9.19.1761474498216;
        Sun, 26 Oct 2025 03:28:18 -0700 (PDT)
Received: from cppmashine (82-132-212-167.dab.02.net. [82.132.212.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d3532sm8320758f8f.20.2025.10.26.03.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 03:28:17 -0700 (PDT)
From: Nikita Aleksandrov <n.aleksandrovuk@gmail.com>
X-Google-Original-From: Nikita Aleksandrov <N.Aleksandrovuk@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikita Aleksandrov <N.Aleksandrovuk@gmail.com>,
	syzbot+e55106f8389651870be0@syzkaller.appspotmail.com
Subject: [PATCH] mac80211: tdls: don't WARN_ON_ONCE on missing STA info
Date: Sun, 26 Oct 2025 10:25:53 +0000
Message-ID: <20251026102553.29195-1-N.Aleksandrovuk@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot report e55106f8389651870be0 revealed a crash in tdls handling
when the STA or AP STA info was missing.
Fix: replace WARN_ON_ONCE with a regular error log (sdata_err) and
return early if STA info is missing. Avoids panic_on_warn.

Reported-by: syzbot+e55106f8389651870be0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e55106f8389651870be0
Fixes: 3a8660878839 ("Linux 6.18-rc1")
Signed-off-by: Nikita Aleksandrov <N.Aleksandrovuk@gmail.com>
---
 net/mac80211/tdls.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index ba5fbacbeeda..7e54dcfad651 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -608,8 +608,12 @@ ieee80211_tdls_add_setup_cfm_ies(struct ieee80211_link_data *link,
 	sta = sta_info_get(sdata, peer);
 	ap_sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
 
-	if (WARN_ON_ONCE(!sta || !ap_sta))
+	if (!sta || !ap_sta) {
+		sdata_err(sdata, "Missing STA info for peer %pM or AP %pM\n",
+			  peer,
+			  sdata->vif.cfg.ap_addr);
 		return;
+	}
 
 	sta->tdls_chandef = link->conf->chanreq.oper;
 
-- 
2.51.1


