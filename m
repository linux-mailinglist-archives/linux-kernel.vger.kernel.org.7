Return-Path: <linux-kernel+bounces-749493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03632B14F0F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23DA63A91FD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0CF1C5F06;
	Tue, 29 Jul 2025 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ss7eyJgL"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436AECA4B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753798046; cv=none; b=A2HlruP4wdWnPoN0FzDshVB/HgJEr8/c0Bk3nWwWqUW69jjlgoVYel7aNN0lOE7f9ZEpsYRrTDu/NOOVngT4EmN1P6xAX/TH3ZQ7w93AUP2js9PM9unS9uHHtKcyBnwWoDVLyJQyn9tT4gSWgzCfF0/NWyMwwMZ2wCeB6xEB4U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753798046; c=relaxed/simple;
	bh=rhVc+Nyd4c2zvpnB/KdoPHZ6dbya9u3vmE75vJ3uoTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T2Emk8CPmTos2qBaRIbNx0ksmewjdli4sVpbjvnw5xOul5gd5e8jBYi8qotzxAypJhYYYs7QMPSvg3K78qnHen4Ll5E06XSb95I+KDj7cuCsRy+uviDDTFJ7gJ3DpC7fyxYjH0PivFaxZxZ3xwk7zZD1oxW7DOCE1YdBtDkPCK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ss7eyJgL; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b31f0ef5f7aso3052561a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753798044; x=1754402844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJvCmo1GMIN6PBxEyuljRYFWQLePXvKN812kyTCAGso=;
        b=Ss7eyJgL1l2sJgUhbNJ93MdYyZPjRAty1kntsymabkshcQ9pffJ2Bsr6w9i/MUFhIc
         ELNIYXFgKROZFQakipstz1HNFfKR6luBzNhtJQO/5960O+/RKdefxhYxUChV8MactKIi
         fSZKV7DLu4GT9cktCcE7DnmVCNClg5UDSAXBDLXFkKEQbC9bWGYE25QHiaZDjyhQFc8l
         CJ/HiJaaXzq84hlxgBKRYD3xIruSPGjJvW2ExMRvce4KwSgeHLgwOuz63NHx5qu8bjB5
         zMic3G6vPphQeL/yhXh1cHqtoh9T9tpbwgCzZL7swHA2pbr7V2NfHXO54gUgBILcLl5Q
         yWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753798044; x=1754402844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJvCmo1GMIN6PBxEyuljRYFWQLePXvKN812kyTCAGso=;
        b=AQhGqO0tg4xCFOgkw+P0zDE+2FOwOmlHCteCkncAAaqSJPfvbbyOuD3yWj77q9FABV
         kSYFpkJNMjQIM121kzMsFzEShJlGxCUO/5fsNF0ZPaZIdkTMpFJuixv+2WOosK1Qd8mY
         ckXhbWtyqh8axWcefmeZzW8oU5tKgEoI3UgHqIUUpmRz0HYyE2eI5ZaFEviTshgGUXGU
         PK924pZx6UpWMmGFOYnDJdVA0/cvuo6B8yVBvJWtmodIlLNcD5v1IvTM1DlBe4t8QfFh
         y0MQQBQsKYF1RHxzVzGjAiTpU/pLzmm3fgv2IIkD/oFSLCD0y6WxFOzwXrSmbAOY9Fi0
         pzWw==
X-Forwarded-Encrypted: i=1; AJvYcCWvXBROjXN1Di8zX8jU7OkR/ZhI8cRJxpCKTLDrq1ehFl1TIaOqEan4t86x8hE/IY6et0A0czpZbCKnD+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRgAg7IduSSyjj0ji3OMa/W/sV+FnYTS10R1cBs84Zy61REuyG
	tSA0vaxAWlNYRMwmVVjWcVjtuwlWN38pas0i/vGrYfHHfe1SUrxDjiWo
X-Gm-Gg: ASbGncs6Nk7OkSq4RFR54aAop3kq3Ylj86iGsypW07EwIn6LfMPgq2n2o4Ghy9dd4Xx
	VBh6gO5nYnpD/O1RVDxlpyeJ1NHLtvCxNSgO8/I8BS7+D8apFOk5kmbhy4G23vjHw05MWxZwjRK
	TI8BnoEaEvmUK4BvA2ql/7X9iz7glQFVmZICxaPrhvrZRnerQgQaBcdtS6+H5W9yWgD8Eq+5XOq
	Vdvrvdrhuon3M+T1+gYEjZjpFV9S/86h1zy7Cn/HnZU0eJRr+KIhtgNnH7Vfrgiim0WA/q7TVWR
	SklEuo3dzyPyg6UOHbFAeIL9hYP3V5p3JQWOKdvuyPPURLT1zhHhWu22Kw5n3c9/ZzPQe3Vdi+m
	7r6mQq6F6ztcnCH3zqOOAOg==
X-Google-Smtp-Source: AGHT+IGrEJoA5tk5T75MgA86AfqARR+AviOM/jK2OcPTpnsSkNLfrz/LSU41o3HahZIkErQQ4PIYvA==
X-Received: by 2002:a17:902:e80d:b0:240:5c38:7555 with SMTP id d9443c01a7336-2405c387a2emr79722765ad.5.1753798043810;
        Tue, 29 Jul 2025 07:07:23 -0700 (PDT)
Received: from fedora ([200.111.160.26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24052f80931sm30327955ad.95.2025.07.29.07.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 07:07:23 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] checkpatch: warn about novice phrases in commit messages
Date: Tue, 29 Jul 2025 10:07:25 -0400
Message-ID: <20250729140725.130842-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <ZqCu6xskqgLMQm8K@saruman>
References: <ZqCu6xskqgLMQm8K@saruman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add warnings for common phrases that indicate uncertainty or lack of
confidence in commit messages.

Signed-off-by: Ignacio Peña <ignacio.pena87@gmail.com>
---
 scripts/checkpatch.pl | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index ac270f35b..f79a525a7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3430,6 +3430,24 @@ sub process {
 			     "Use lore.kernel.org archive links when possible - see https://lore.kernel.org/lists.html\n" . $herecurr);
 		}
 
+# Check for novice phrases in commit messages
+		if ($in_commit_log && !$non_utf8_charset) {
+			my $novice_phrases = qr{(?:^|\s)(?i)(
+				I\s+think|
+				I\s+believe|
+				I\s+suppose|
+				probably|
+				maybe|
+				perhaps|
+				possibly|
+				hopefully
+			)(?:\s|$)}x;
+			if ($line =~ /$novice_phrases/) {
+				WARN("NOVICE_PHRASE",
+				     "Avoid uncertainty phrases like '$1' in commit messages\n" . $herecurr);
+			}
+		}
+
 # Check for added, moved or deleted files
 		if (!$reported_maintainer_file && !$in_commit_log &&
 		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
-- 
2.50.1


