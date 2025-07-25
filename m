Return-Path: <linux-kernel+bounces-746126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FD0B12376
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930623B0840
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CFC23D2BF;
	Fri, 25 Jul 2025 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkoth5xe"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0EB1E0B91
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753466541; cv=none; b=rmtgejYpbgecAwz57tMmDjNTs5KfXrLDTuCZtkxOX9W5AyMXAh+guHBsV0wkrrG07g0Bdsd7p0RHpBnoYZDE4FxLwlLx6xNI//pgOc3h320UUuGuNVvb4qLwMp60IW55H7Up+vs/iI6eij163HUpfkvFHs909HoG4cNxjeCluDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753466541; c=relaxed/simple;
	bh=o/Nzc8UO01YPApylGg95i0cXOIKMhwQsnIS/Woiy50E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QE/dhETaR/h1cetI1CB/Li4siAncXp9RdR24U2DKVPFbzlA8EaliVTGcZxcNYQMsITlOehXtTwq0CwBgWE/tbRkrnKymqU1j926A69X5GFniPapDquz2WCuTAzzLhuxcmMaQ+H9LQ/v0VvvB6LEiM7rYVKLM1gkWb3F9CLQO/6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkoth5xe; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60c5b8ee2d9so4916658a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753466538; x=1754071338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96+16hPDVbzmYR7/3oDaCmxYXJsLYiyA9oBeZgPFSI4=;
        b=nkoth5xeCQEwtECioVO4SOxfCGdkHGczcYmhODr0SG/IRyoLJZquyZ5ez/rXX8EnQ9
         Kp8Xw3nMVW9b5tA53aV3FLvaN5RLAyaQvMeYYsh+9T4L5YuHHom3b5Wxq+asWzD45N4V
         uCTG1pSbWlWv6yCoaADdSM9xLVrmCzZkZtms1v6Oevt60FLyAhyP9+5xI04Lvdg0qnCc
         4bZWuHYNgiG4YKR8QMbii6Jmygo95M0CZ5JWeTEU6OscU3a29y8HtMIokV/VwVlK6oBQ
         1RdI3aJBI6CopS8kWx3gLI0c67IMSaeZSg1EzgmpCGw+ZP6Vlo5y4S+U9YNAVl94vG0h
         OQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753466538; x=1754071338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96+16hPDVbzmYR7/3oDaCmxYXJsLYiyA9oBeZgPFSI4=;
        b=tK7MlnK7uEQBL4bpEaCKhSAd1fqzyS7Hjx9yfUaNRNOI/LxQNVHb9G0LfIEtLeqe2z
         eHkFblBmHsa0y57xfwPz4fLzoG8AlTTUrvE1g83oZeBg7ozZoqSbjAlGL4PF46MczBh7
         W3Z5L+aoC5s6XyJHErLP5ao0MYLDSVAiXEAa88sikao7/4IwFhQpEkOwxznpPxPBGyFr
         0y5suAXpqRcwa9FOttnxoyzyf96XezGUPNLZ+t3p60VAYTHWSzHjjXigEv/TfXRYDs0R
         D9VU/4BAbCvk1rrQ1wF2EKsXo1jvL+922490BIse8FLnfTEfX5675zeqjRGDJZrgvM2h
         tJRg==
X-Forwarded-Encrypted: i=1; AJvYcCXN2UidzwSUjfwFc4J2caXzmG68pyLfLKBpP78mVDK1PULBPqLoJZwU3ULqM4zvC3q9xr+OB+Ds9w4U3Kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzluQPdHScDz+M0g5TdctQFiNQG5zZ1HqiG/CItLtmAUftum9CH
	d8LtonE7SNACwkQC99JvofP1qLF7muxHe6u8x2JHVpHwgxiCBMl+Kj2P
X-Gm-Gg: ASbGnctw5gCBeke5R9KxZjDa/cp89wjoHwBOohZ9WLoGNHRbEqz5XEUNwm5bdjjMJod
	zNJM6fvGCbOafPkjHm7LFmeQXfCrLUteb6dTXw7rVnhavPQV0Klq2HugKYlJjHdMCqTttGz3p8I
	vkFkHtslyXlotriqrOlyelrWMNHMpVwF1mqYvPWhs2gnYJHDn9+WAOF3Yd/f/kPuKBotBpS1bcW
	1Pnpu9irUQDjRNCJn1k58D46yIPzT49WwvAj+izOld9atBv/z1L4VWWBcMhHdj+uCkgFDzAaALZ
	lPD4mWg1Vv+7AyvcmiD1SFp9RsfuwjUMx2E4dQ6G//YQNLs3VE6e1SmEBljfw0Fo+nsiwgm/VCH
	du5WtIL/55jShoJe82jZ6Z+OXzleegcD4yXTDayFRsVvQSM9WE16/8+f+M0DIfwTUJzO1zhI=
X-Google-Smtp-Source: AGHT+IHNFWqx8VxQ9a3GwfF4+HeF0JVKfTYPLpwmOO78cGJuvfjawTQCiEd19m+N7BGgPHqREiX1yA==
X-Received: by 2002:a17:907:e2c5:b0:af2:4429:206b with SMTP id a640c23a62f3a-af6190f8b0amr330828466b.33.1753466538313;
        Fri, 25 Jul 2025 11:02:18 -0700 (PDT)
Received: from PC01.localdomain (094190205166.static.ipv4.heldenvannu.net. [94.190.205.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a6685fsm24220866b.89.2025.07.25.11.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 11:02:17 -0700 (PDT)
From: Bruce Qin <bqn9090@gmail.com>
To: gregkh@linuxfoundation.org
Cc: bqn9090@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v5] staging: rtl8723bs: fix if-statement alignment and line continuation in rtw_ap.c
Date: Fri, 25 Jul 2025 20:02:16 +0200
Message-ID: <20250725180216.19585-1-bqn9090@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725174504.15726-1-bqn9090@gmail.com>
References: <20250725174504.15726-1-bqn9090@gmail.com>
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
Changes in v5:
- Fixed incorrect recipient address in v4 
  (sent to self instead of Greg KH).
- No code or commit message changes.

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


