Return-Path: <linux-kernel+bounces-746099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4107EB1231F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7915C5A22C9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008CA2EFDA1;
	Fri, 25 Jul 2025 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gl+F+nLI"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B45238C16
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753465510; cv=none; b=MhxiDHNqvMPZwn2Df2GpgPSesKU3cyGdp5d0fcifWbPu9NsReTmrLH3YsUJmf9ANJ52F+yM5ovMoEPbc9pFMc+PEtgaHwHvkIpM03DDE3g26akM+kbJe6hp9rlWwwk8LhXWcC1xViUWAWN9MuWR+HXXK8WlxPWSiph6+zzx56oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753465510; c=relaxed/simple;
	bh=9sRf1xg4wEQuT9FtdI/i5Zt5IfYFrC+lTVhOM9sf6+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fASobCTdsXO5HUhmmGgFwfty9kmo7ByHBKFRSFASGZz/rhW3XEabIHZ9ul42dumEJ7LzMRXglJUhSUP3NmCa1IYm++4YABN2hXVswotnaQD37fqT1ud2AQ84hFAxdk3SKmhskUgcmwatw1pv6Vla8SJI5GKD5VOSHRtpL0TY220=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gl+F+nLI; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae3a604b43bso375024866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753465507; x=1754070307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OtzwgImI+mqwxLZh9QnNUbkg7K6nkVm9gAGvrX9Q2Y=;
        b=gl+F+nLIyNFIjJgGfY//Af6fVl76AAbpqF1dKJayp5oVULiJyYkazW67IZ7rPvFWFO
         0wKigPuDQISCxtp13dSGVVmehh6PFPtmbD6LvtR+Qlm371abvHLZQ0ud8fWIYT0tVlp6
         MYuc90SdFv67Am7GWy+JqXqLHDsTd6W7DhVpxwiSVf+Ej+3U2+Um0rd5C2pnXsSi9nsU
         6bDzEjMJq+YbFJ+QnBli4PxcydREruC2k/1btaKun/bhYro3+Py/zdT8g5M0W9xXusK7
         y25U9/YtLT8rhKIJwrhzJD0vQBSLz7HnB9V00v4hW1L/e2nsNntEae0OCPoxdHGW/zEQ
         XWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753465507; x=1754070307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2OtzwgImI+mqwxLZh9QnNUbkg7K6nkVm9gAGvrX9Q2Y=;
        b=XIvBv26il1uJppHd0vhYvXNf80A+Ab3foloJ2EpQH/ddf7Sxb12CVyukkMtGmpTfF+
         MgTDKe5lRsrOdVnIkKqdyUJDdHm7I9e8ooQSXTy28cUvfcCb+SXyis2PknPi5JxlWHSA
         cm1qAjlCCw5Plx1G5ZrbIFfZDFBYLwltsM2APPPJe8MNp8EtNZTPoT2DLsL9ptspD/39
         9f8rMIAq6NeI9STqdwikn1JZ2HYOeu2dpCQvb1gKaabXP6vaeFKoI9YR18wquyMCGHAS
         yRBCRRQb4nRRiXcOX47N7yxI0TrxZUJf4fUohTl4nQ70gOsyvLXqzN7OP97ANDelrQd4
         jNkg==
X-Forwarded-Encrypted: i=1; AJvYcCUG1l2TSNHqHDMVHwb8ZW5peDFEU+hWBIHhJt8zwxXY6PKfMxDqH8g7tvTa5YgEh9mszVFDq024gs37GLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHJqvjAisOCnHn6NEJmqEaIv/t+Qh19CWpMBuMRZGtIZUcnY9x
	Lq1Q9Qjr2Jnnng5XItIRSRcQT/9zr1e1hmXh4LKpRENvO25FdFrgHG76
X-Gm-Gg: ASbGncuK6tXNc9dFgfAfdBQilOa6+SuhOsHpKXXsQHOX4eLO7UXrcyWfm7Fi0yRqpbk
	n5IVJDBaznd9iDPUREgZJG/Jw7IPPDNxFvqYxRnIoD2s4YWKpmMNh3WUSQnDxNE8jShdO111cYb
	HNDLg+jVeYrDElISXsMkXNyk4SYc/ujg9QKneuGrDwYqd8hlGrR+O43iJocU6Y26SXUciK0x6No
	OrKxFyHz0SI/E9l3uv1Gb8un7dJEKHCAicuHlLgSFFCbCvozpiODfh5PBsecsbXwTf3cDXYJouf
	WHabDPbUF3iQvvinImYhGo3mR/l7tl5mxw7cS/B644kibJoEEcO67IMss0qdJN7bcaLOv2WVpqA
	tfcZ7xHmcgg3T59q5wA5ylaVQL1brE0Y42sf/uFGX3B0Ri34nnqpM+2sscxA4MtlFiRbh3q8=
X-Google-Smtp-Source: AGHT+IEmq5lzdiUntelzsfZ0+vVpNfXulcXdUNvkZLPLCOf6NCvEZVd9bAmaxELCyyg9xtE3PW9RCw==
X-Received: by 2002:a17:907:da5:b0:ae3:75e5:ff7a with SMTP id a640c23a62f3a-af61b6dd540mr345271966b.19.1753465506547;
        Fri, 25 Jul 2025 10:45:06 -0700 (PDT)
Received: from PC01.localdomain (094190205166.static.ipv4.heldenvannu.net. [94.190.205.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af6358600b1sm23968966b.7.2025.07.25.10.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 10:45:06 -0700 (PDT)
From: Bruce Qin <bqn9090@gmail.com>
To: bqn9090@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v4] staging: rtl8723bs: fix if-statement alignment and line continuation in rtw_ap.c
Date: Fri, 25 Jul 2025 19:45:04 +0200
Message-ID: <20250725174504.15726-1-bqn9090@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725171933.10027-1-bqn9090@gmail.com>
References: <20250725171933.10027-1-bqn9090@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes several style issues in a multiline if-statement:

- Moved '&&' to the end of the previous line to follow logical
  continuation style
- Fixed indentation to align with the opening parenthesis
  of the expression
- Avoided ending a line with an open parenthesis '('
- Moved closing ')' to the end of the last expression line
  (as suggested by the maintainer)

These changes improve readability
  and conform to Linux kernel coding conventions.
No functional changes.

Signed-off-by: Bruce Qin <bqn9090@gmail.com>
---
Changes in v4:
- Rewrapped several commit message lines to strictly follow the
  72-column limit.
- checkpatch.pl allows up to 75 columns, which led to the initial
  oversight in v3.
- Added back the missing v2 changelog that was accidentally
  omitted in v3.
- No code changes; only updated the commit message formatting for
  full compliance.

Changes in v3:
- Wrapped commit message lines at 72 columns (checkpatch warning
  resolved).
- Ensured only one copy is submitted (per Greg's feedback).
- Carried forward the fix from v2 (closing ')' adjustment as
  suggested by Greg).
- Thanks again to Greg Kroah-Hartman for the helpful review!

Changes in v2:
- Moved closing ')' to the previous line as suggested by Greg
  Kroah-Hartman.
- Thanks for the review and feedback!

 drivers/staging/rtl8723bs/core/rtw_ap.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 383a6f7c06f4..c652e0cd35f3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -258,11 +258,9 @@ void expire_timeout_chk(struct adapter *padapter)
 		} else {
 			/* TODO: Aging mechanism to digest frames in sleep_q to */
 			/* avoid running out of xmitframe */
-			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt)
-				&& padapter->xmitpriv.free_xmitframe_cnt < ((
-					NR_XMITFRAME / pstapriv->asoc_list_cnt
-				) / 2)
-			)
+			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt) &&
+			    padapter->xmitpriv.free_xmitframe_cnt <
+					((NR_XMITFRAME / pstapriv->asoc_list_cnt) / 2))
 				wakeup_sta_to_xmit(padapter, psta);
 		}
 	}
-- 
2.43.0


