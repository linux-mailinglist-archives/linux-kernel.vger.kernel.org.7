Return-Path: <linux-kernel+bounces-865802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 76998BFE140
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 21:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E11A34F088F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2FF224AF0;
	Wed, 22 Oct 2025 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b="G0uVo7Bl"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FAD229B38
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761162340; cv=none; b=XTXDJDqfBzPaOaH9ni/927E/a8/qQTwJj6YTCwYr/4nE/YM8qHp9kkumDfJHsfa30QLw+3mqKSEwkAVkkh/AVbcRCGTr0DYPQGSmri+p+WwXiBKh3Wj5tDAqHP7lnFWmd0pl+PFEd+Ef4pAzN7xWMYq3XDc20oNbzCdSQ336ob0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761162340; c=relaxed/simple;
	bh=JvEx88/9/4yrZrD8oUUka3XIDqnMKIT4jMYXzVc/PtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HicAhkOmr3z4vg+h1TEIgU7Zyy3UqglclE77lbi4zc4jdgI9gmGjvgE1Yj2uOGwinrry4IhLUqxvj8rfNgfVC8FPvQwfHiZjdXmOKDeSQnbyWDtkcs/IafNhfziJmiejz9hIw6OrdSl8Hl0YsXqAYlNqniqrBxdPCb7luSLBUVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in; spf=pass smtp.mailfrom=ssn.edu.in; dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b=G0uVo7Bl; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssn.edu.in
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-33b9dc8d517so31947a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ssn.edu.in; s=ssn; t=1761162335; x=1761767135; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SdyO+Sr/onadDh4rCJAHTE0lY/KlceYK45hEyRydGRw=;
        b=G0uVo7BlsqU/Alhd2+QM2/QGU2u0NyDgGS4iBbndL3WHCzHmNyYWe2daSKXou7Rk7M
         ZYX/OKF1NgSSE8SRldjZTXn26bURflrcy26Eh6ckSY9Rddt9U8dNwPwQ1p79nNsqKBGl
         JZd+mIC3bJ3Yf87MNChZUUQjXfiMYLtr26ktk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761162335; x=1761767135;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SdyO+Sr/onadDh4rCJAHTE0lY/KlceYK45hEyRydGRw=;
        b=V6myvIoTsmaISKsmv3gfkbbJFmEP4aBO8+Ku1KIhL4c4kVzuSqpIgNXfehjUZgD7GS
         50cPlFKwIkviP8iFeM49fLH1MWXP5iKLfzZYjZd3ztmZq5wbGQD9bqmbTIxevfYH3nA6
         QIRr87FOseD1iZjvazfg8eCe846gS6KxFyyaGz87fv+Y5wEQvofCw5PYtOQxqpuj0oxS
         VUN7ly+bjtUkzYVrP6pqQvbyQx66XujqqrwssqEO3PwhIo9QivS+Jownmfna93ozlyb5
         7DW0F3eGKdXjyH3Vmf38N0f0YT4la29crRf56rrTngYGTMCRx1OnspxjI4bQ1jc2w10a
         W68A==
X-Gm-Message-State: AOJu0YxB6NUUqZb4c7wZVK/dIoMo5xa7pI6M+vQo+iFDGEP1K0FA9mJd
	g3oFFtXnW+mt4sVJ6tKlnQakahdj06VLGvfjYfHdaju/tgVcRPA+pv4DxGBY4zo7aYEnayIySI9
	QnGW43o0VXVpduxQnC0M88B8rsgOXA6z06PgH3F4PX5M7/5CVEyNZHW6gp2iPERAfajVTCpGxvF
	o=
X-Gm-Gg: ASbGncvbw1ExBv62NfCR96cirbYih9ZdZtl6wdgx+pGu4J9P5gtnu9Agkg/74zJzB6A
	hxzs54v4hTiGQEl32NcuKFH2Pesu0f5Q8ZbOJGZg1sTrNZF6WfBepnWRsh1JqmihDaDQbx9IQr1
	Z38LG9PaFyYfppmIGNcwqPuwMNM4xIbqJrwNrj74q6IFYz2w9YXKPWkxftrWsv/XfU0cQV+x8Ak
	ndcSoGkx0YrYYldPzVN/cZpOjQInFzFpsJBOsDAla3YZzp7FLjj3+nD4KccFUwV11Lz/oFVVEsY
	NsmLOeUUz4k1JIe+eCz56QbM85T9fAp58N9niDqGP7jNRsfGi3xi/Cn4iqB6jOoxRv0fK3WklpF
	51pE3CRCULmsb79qpaQIaHA9fYaSIHl0lGjmGY56NV2PjwVD6rQ2jV+sF3cYMKgfyD7mNU+xp2l
	qP+eafE0vB1Qxl89NaCoAFVw5454jZAxDT+870zMk/aa0rlNZ2Xog8gzCCbtLypdOTRvS5Db/3V
	EE=
X-Google-Smtp-Source: AGHT+IED97I1L6h438ObXwMrhI04f4auCt4isQ+Sfz/RWTVt54hKf/b03QWokE61BBKNqfmSQLySpQ==
X-Received: by 2002:a17:90a:d44c:b0:32e:ae12:9d32 with SMTP id 98e67ed59e1d1-33bcf87f460mr27083250a91.11.1761162335472;
        Wed, 22 Oct 2025 12:45:35 -0700 (PDT)
Received: from biancaa-HP-Pavilion-Laptop-15-eg2xxx.. ([2406:7400:1c3:818d:712:fe94:5de7:1d8e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e224ca168sm3318470a91.22.2025.10.22.12.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 12:45:35 -0700 (PDT)
From: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
To: linux-kernel@vger.kernel.org
Cc: peng.fan@nxp.com,
	sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Subject: [PATCH] Subject: Modifying mannual to manual
Date: Thu, 23 Oct 2025 01:15:27 +0530
Message-ID: <20251022194527.71189-1-biancaa2210329@ssn.edu.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

Spelling fix in the document from mannual to manual in 2 places.
Regards,
Biancaa.R

Signed-off-by: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
---
 drivers/firmware/arm_scmi/vendors/imx/imx95.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx95.rst b/drivers/firmware/arm_scmi/vendors/imx/imx95.rst
index 741f4eace350..933c21512411 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/imx95.rst
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx95.rst
@@ -400,7 +400,7 @@ POR, WDOG, JTAG and etc.
 |                     |Bits[22:8] Error ID(Agent ID of the system).            |
 |                     |Bit[7:0] Reason(WDOG, POR, FCCU and etc):               |
 |                     |See the SRESR register description in the System        |
-|                     |Reset Controller (SRC) section in SoC reference mannual |
+|                     |Reset Controller (SRC) section in SoC reference manual |
 |                     |One reason maps to BIT(reason) in SRESR                 |
 +---------------------+--------------------------------------------------------+
 |uint32 shutdownflags |Shutdown reason flags. This parameter has the format:   |
@@ -419,7 +419,7 @@ POR, WDOG, JTAG and etc.
 |                     |Bits[22:8] Error ID(Agent ID of the System).            |
 |                     |Bit[7:0] Reason                                         |
 |                     |See the SRESR register description in the System        |
-|                     |Reset Controller (SRC) section in SoC reference mannual |
+|                     |Reset Controller (SRC) section in SoC reference manual |
 |                     |One reason maps to BIT(reason) in SRESR                 |
 +---------------------+--------------------------------------------------------+
 |uint32 extinfo[3]    |Array of extended info words(e.g. fault pc)             |
-- 
2.43.0


-- 
::DISCLAIMER::

---------------------------------------------------------------------
The 
contents of this e-mail and any attachment(s) are confidential and
intended 
for the named recipient(s) only. Views or opinions, if any,
presented in 
this email are solely those of the author and may not
necessarily reflect 
the views or opinions of SSN Institutions (SSN) or its
affiliates. Any form 
of reproduction, dissemination, copying, disclosure,
modification, 
distribution and / or publication of this message without the
prior written 
consent of authorized representative of SSN is strictly
prohibited. If you 
have received this email in error please delete it and
notify the sender 
immediately.
---------------------------------------------------------------------
Header of this mail should have a valid DKIM signature for the domain 
ssn.edu.in <http://www.ssn.edu.in/>

