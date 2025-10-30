Return-Path: <linux-kernel+bounces-877607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0FFC1E910
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3FE54E6C36
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879471C5F10;
	Thu, 30 Oct 2025 06:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYXNZEWP"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751043A1DB
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761805914; cv=none; b=m/0vfKP45OEgQx3notJ16HRh2ZhBr50lAve1X4/tujmtpsAq84f7mmC1KlhwIcs2gjUmF+ajkjeVmfLdo97U4WYep8SdjHRnm6UL1AXi7uOWjWujGGoy/jLW9qIVF7tajY0nLNOWDBb6uPDsWuM05bY5ibrmGobBZUCKzYlo1GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761805914; c=relaxed/simple;
	bh=EvEXTz0KOxz6r+4dee3gAhObDEZ9RzGv4u6rNYbYStE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hCHdXqoDbtFal5WX/qj+PFmwlQ1NrgvdHwJ91wPzagTnuTskYmGmnEzMwQOIJgKcTpy7d6GWErTmJ7MK8jfA7SS9WrWkMmQd0oy4qei5L0beGB1FSnfyl8ssBD38TfY12iwpk1Fs2zWH+dRRzQP+cGenyRzm1+NWWq8P4ayLKjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYXNZEWP; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77f5d497692so970825b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 23:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761805912; x=1762410712; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IteJbnpQxtDfi0VoQZa3f0/zEOSuD+t4NwFKFFHXmzw=;
        b=lYXNZEWPQraeOzIeTVwCFgh6o5YTNq80RGG4/gq7uj8JddmmstXd8U+mguhWFGk8co
         rCv59mC+2iIJNI6LRsFbHVKXOZNNkFUcaKsbiipN6yaQhqquD3WVtrc4SFpW+W3ggGx9
         41lAXBRok5aK7YElkCPQSf+FKYEeCPQpDKBfG8iBtkUFdhCXMRko04k2xVrudPs8IZn5
         2OUtVGJ5Ay04EEqplI31FiJtA7J0pVp0XP2vfUr8HoKHZDQ2tfbRn9E/RgwcKUIUjvgt
         FSiREuPyfdNnDp2DPhPXF8/e0mdMSUZTPrdOiJKmauPHn4/pkq1DkKMQnEP/Thgwb7gu
         XJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761805912; x=1762410712;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IteJbnpQxtDfi0VoQZa3f0/zEOSuD+t4NwFKFFHXmzw=;
        b=qxcAH69bRUG8ikAqPIl2PwDAZc5RM7SL3UKdrn7jcPjEbtYNM/mBB3v/kK0V4GRNRo
         b55E5XAkyMEhgdtqKai/9Cy69/LBFxZbs3tonRBu83Zl1xwqyQi7Z9dfiS7OIrXr67nS
         gj3ibBEhhie3cIEZ8/7eGwTks2reA7urJP6EqaIz0hscoSobR8bRhJmToInOAn+HlB/j
         7KwC2qfMGHjw5c8j13k0xIKC4ZUUkP2VuTD2y21lObdPB2s/Q03M7Wh1l7VKqxGjXAg9
         d8/ryhC63SeJVQ2RGQSqPXT6wN61P2IGkzw/LfboUFwIFpKpvKSNbBjDmbcEoUWPEZkz
         5HyA==
X-Gm-Message-State: AOJu0YzKq3QiuDjTO9OLYr1E7KxFuj7xQLwVezeHks65jyaTKgLxpIJ8
	LLDc9BqOE7jf354UqJLXApUMtr+JcFnBOYNid9x292AIsUssFtrs+4mg
X-Gm-Gg: ASbGncvVeweGWa3XYpVAWk6qEYSlh43vG0nfqhfl7IHHgz7NugNJCNVzANcJSaHcuhj
	QJg9ZhQ9x1qW152lgwMlgn1z5v/Z3Xl+Jv4HTACWmtO5nurcEJkLonB/jKKsbzoc6jMRjseF82u
	8SuKBuArzTbImLjYRNsbuvnudoc1urCx6A19qlk4QIdqBUly6NoJxr7KM05lyIXlX6hCqDPW4Ny
	TUNyjkxYnQ4K/jLRXvu6wdv02hy+ms3vDUqHvM11tYh/xCxhra3A6X17Rn6kCQyHSCIRhjEbSBz
	7yjL6u9NJkA/l3nmmhNlCUzUxymtseJZv00bzZz/kwE+olXYKyvelhsKhjK9uUB0ohwQE3lQztF
	I4D2LeAhb/eVUvF6ZX8txyF4VmU7qYWSBs1cM+hwwoGmneovtyiik8E/zyt7PoFKIpKMGkPpnDb
	LSbzbwMHJ8JfXjuY298cL774uVcCRtFQ4Fm24ekEc6/tYBOaI1TXKVVNQ=
X-Google-Smtp-Source: AGHT+IHNvKCn04TUtBKiitaic4J2q30Yzc+qOqNpAkIf4/fyYDmwz0RWuqOmy8D+jYX31HnPUWKBbQ==
X-Received: by 2002:a05:6a00:2e23:b0:780:f6db:b1bd with SMTP id d2e1a72fcca58-7a62a361761mr2569135b3a.4.1761805911695;
        Wed, 29 Oct 2025 23:31:51 -0700 (PDT)
Received: from stravinsky.localdomain (ip72-203-100-4.oc.oc.cox.net. [72.203.100.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414049a44sm17200296b3a.35.2025.10.29.23.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 23:31:51 -0700 (PDT)
From: Jessica Zhang <jesszhan0024@gmail.com>
Date: Wed, 29 Oct 2025 23:31:45 -0700
Subject: [PATCH] mailmap: Update Jessica Zhang's email address
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-mailmap-fix-v1-1-8534ffa12ed3@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFAGA2kC/x2MQQqAIBAAvyJ7TlDTkL4SHcS2WkgThQjEvycdZ
 2CmQsFMWGBmFTI+VOiOHeTAwJ8uHshp6wxKKCOFsjw4uoJLfKeXG6FH7Y22Vk7Qi5Sx6/+2rK1
 9ezZC/V0AAAA=
X-Change-ID: 20251028-mailmap-fix-50434c548816
To: neil.armstrong@linaro.org, lumag@kernel.org, 
 robin.clark@oss.qualcomm.com
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 Jessica Zhang <jesszhan0024@gmail.com>
X-Mailer: b4 0.15-dev-509f5
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761805910; l=1226;
 i=jesszhan0024@gmail.com; s=20251028; h=from:subject:message-id;
 bh=EvEXTz0KOxz6r+4dee3gAhObDEZ9RzGv4u6rNYbYStE=;
 b=4AiNnU52GcTLFxFVrVFNRtBIYgDMcsTe1X5gNVFGem6rW0dpFbRAMuLF/g8ZuCZZ4pAV7ZETd
 /Cm12ZhzY7PD6ExKeMtG+CG5/e/RDBmWXFODJU9FyALDeZ1gLr62emS
X-Developer-Key: i=jesszhan0024@gmail.com; a=ed25519;
 pk=Qjsztzh+H8Xz0uqVst7N2PHX5Vnd3JXONpkaTHqk/Pk=

Update mailmap to point to my current address

Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Jessica Zhang <jesszhan0024@gmail.com>
---
 .mailmap | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index b77cd34cf852..1c57bd649f04 100644
--- a/.mailmap
+++ b/.mailmap
@@ -352,7 +352,9 @@ Jesper Dangaard Brouer <hawk@kernel.org> <hawk@comx.dk>
 Jesper Dangaard Brouer <hawk@kernel.org> <jbrouer@redhat.com>
 Jesper Dangaard Brouer <hawk@kernel.org> <jdb@comx.dk>
 Jesper Dangaard Brouer <hawk@kernel.org> <netoptimizer@brouer.com>
-Jessica Zhang <quic_jesszhan@quicinc.com> <jesszhan@codeaurora.org>
+Jessica Zhang <jesszhan0024@gmail.com> <jesszhan@codeaurora.org>
+Jessica Zhang <jesszhan0024@gmail.com> <quic_jesszhan@quicinc.com>
+Jessica Zhang <jesszhan0024@gmail.com> <jessica.zhang@oss.qualcomm.com>
 Jilai Wang <quic_jilaiw@quicinc.com> <jilaiw@codeaurora.org>
 Jiri Kosina <jikos@kernel.org> <jikos@jikos.cz>
 Jiri Kosina <jikos@kernel.org> <jkosina@suse.cz>

---
base-commit: b5bad77e1e3c7249e4c0c88f98477e1ee7669b63
change-id: 20251028-mailmap-fix-50434c548816

Best regards,
--  
Jessica Zhang <jesszhan0024@gmail.com>


