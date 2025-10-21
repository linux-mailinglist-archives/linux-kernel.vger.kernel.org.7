Return-Path: <linux-kernel+bounces-863466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F8DBF7E79
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F64B19C6ACB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A1313A3F7;
	Tue, 21 Oct 2025 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b="IyX1Arr+"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914FD355815
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067748; cv=none; b=JkUVHVHyj3mYrVJgHi/fRdwCkPUxeRAbakwLO/gX4+hqTuRaRy0Yo1dWgEVz/lc0U3oRfR8CmJU+jaMCQslZC03F9jtgtJfanXW9JUHSzWcLG2cv3M/n/FBn8k9uSEKPe6ygd9F/1qUHBMeyAnQwYo5OgAxef/74ncl7Mxnp194=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067748; c=relaxed/simple;
	bh=wJgfNGawsYoQWeS2qQFbtDDkK0w0jeVCHSgcs654+xc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q/ro3/VG8+pYmpPLOno3iT/iux6+6TGsFnnOuo7oDFfQItE9YulRW0jQaPUNsC6/5Uzw2bF+sc7UqmJk78eM+K7GjteVXfIXmYx4+UVebwFSZjq6fA10g730CuuEX9iA4dacJ2YokNN+7IGgeXjyinEKwgUE+aDraof0rJJrR0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in; spf=pass smtp.mailfrom=ssn.edu.in; dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b=IyX1Arr+; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssn.edu.in
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77f343231fcso4043211b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ssn.edu.in; s=ssn; t=1761067744; x=1761672544; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=48KjAevuPrNZ5hb5wHQ10qBMSO8hHpORZo7YBfYxs8Q=;
        b=IyX1Arr+jyoZEXSarWwpz2885ot0HQmueEGFRJx+7FoYJkBHXpFy+fmyIRg+jvxIWC
         YfjMvx/fEudtiOwmEMN9ru6rHPgaxGCq6BymqHeTxBI0zxNvobyduTIr7X/iDuHrbBAg
         69pLHMgvTnv5GERsdTLwX5di9NXRJjO+5YE0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761067744; x=1761672544;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=48KjAevuPrNZ5hb5wHQ10qBMSO8hHpORZo7YBfYxs8Q=;
        b=asz6Cb8pLZGqJXv84husLy/KPfGsuHTEyy4BklPtHRIY2/n/UVRm7cHZTGqHzEWDBq
         6g8sRI0asf4Zfzjb6JF3NKObVfDiBX23PG1l4ya9zGpfswndvM7+vv+M2I9zeFrDC3si
         XU5Bxud0qJk4h8mewwVSZRAp1OKEkC1uRftPbKF4HTeQ89M9cAiXJp/WChhowmEqoXhS
         D78B49kmLVOESwrNibTWiOZ6CtK+pU+JoEFgLsWac+1MMWoC59+tLE+9kMvKIdxGwe0c
         i7YAybCaz97+LQjDk7Sr2bN0E2hXaMbsPvviiyH2yK5nSjyrsztdBDjDJrk9g0tHg2fN
         HLjA==
X-Gm-Message-State: AOJu0YxKY9Cd0NI5dKypOA25hdAnj8cwsANegOqVjnUacGju6sKH1KH8
	ZsTeBFlDX/S1VcBrLf4yvWLML1+K8P+N4Jmgfcn0B9xwy9SDHRCsTxNf+kUdT0003Rn0ZtqWH+c
	GasjkIX+51PvA4DKIB3YwDfEwiOVHq//A+IQym6ogMHaI7I4/bKJE8h3QkR4GyI7Fc/Gzn9JuLz
	Y=
X-Gm-Gg: ASbGnctK6BnirAXS5N7IFDS2qaW9pX8vJgzhSu7lqWBGTnvr7RfSboPOYotGrqskM63
	o5otXDt5WP3wnD7rp1hCPNmLRI9f49gYv8cxXJ02tiUzKWqwKgm9rTky95rjUUmemaeBKTtE4nX
	aYeufEGZyk9u69amm3YYQzR3Hfbg+3yvwdSshGe98R4ZW9OXgnK/+X0HrwMoEAIRqXqZ8UXz2EB
	foD0ZQfOONLt2N6fmtv1ycw/c8fCEZokPpMxmwWo41XTAAodb/1pQXpNCeZADePz1GRVvErYDJY
	l1Mqvct1IMRhXlK0PuWS7X2PwvEic4lgJPR5rYGyT4dtd2enyAybEmwAfzWewYhL4jEWW4zbChP
	djaYK22WZP+vO531ddSUJx8Fc9H9stoTS2CC1WKvYMNlQ50xTfhFlDMIm9bNXaAAL8bAFTmLHv1
	vlGHo13gsAxm4hKM2Drcmf5jJ2kwZ0Axv4ZofZPuMi5jq9CXYXZL+s2gJp9c/VBnAHNgcYYKTYd
	nBitIrUTg0Bz5w=
X-Google-Smtp-Source: AGHT+IFzDCj33vDNW2bel52Yxir9ZDCPlQdcgEcX/znC+j3AFNzsdS7Qe6eNbOBP+xHndeIPQ+ld9Q==
X-Received: by 2002:a05:6a00:2e03:b0:781:17ba:ad76 with SMTP id d2e1a72fcca58-7a220b34252mr21508847b3a.24.1761067743531;
        Tue, 21 Oct 2025 10:29:03 -0700 (PDT)
Received: from biancaa-HP-Pavilion-Laptop-15-eg2xxx.. ([2406:7400:1c3:33f3:d5f3:33d1:a1e0:46bc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f159csm11903333b3a.46.2025.10.21.10.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 10:29:03 -0700 (PDT)
From: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
To: linux-kernel@vger.kernel.org
Cc: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Subject: [PATCH] Added size parameter in strscpy command
Date: Tue, 21 Oct 2025 22:58:51 +0530
Message-ID: <20251021172851.47561-1-biancaa2210329@ssn.edu.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

Signed-off-by: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
---
 scripts/kconfig/confdata.c | 3 ++-
 scripts/kconfig/symbol.c   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index c0fef4cd6b60..5c61ca1cb2fd 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -154,7 +154,8 @@ static int conf_touch_dep(const char *name)
 	if (depfile_prefix_len + strlen(name) + 1 > sizeof(depfile_path))
 		return -1;
 
-	strscpy(depfile_path + depfile_prefix_len, name);
+	strscpy(depfile_path + depfile_prefix_len, name,sizeof(depfile_path) - depfile_prefix_len);
+
 
 	fd = open(depfile_path, O_WRONLY | O_CREAT | O_TRUNC, 0644);
 	if (fd == -1)
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 0c6746854617..c88840cafe80 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -809,7 +809,7 @@ bool sym_set_string_value(struct symbol *sym, const char *newval)
 	else
 		return true;
 
-	strscpy(val, newval);
+	strscpy(val, newval,size);
 	free((void *)oldval);
 	sym_clear_all_valid();
 
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

