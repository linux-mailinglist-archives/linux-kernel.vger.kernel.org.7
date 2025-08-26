Return-Path: <linux-kernel+bounces-785740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D641B3504E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 02:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2625F1A86A66
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 00:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BBD257825;
	Tue, 26 Aug 2025 00:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTWWaFF5"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A7520C00C;
	Tue, 26 Aug 2025 00:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756168489; cv=none; b=reQgl+rsvm/3OINHgvO7X4sYqSsAj9etI/GTltqHmwOyn6bzn8VgHUM4Q/QwHF3Y+62h5tcDJeqP3w6zsufvrNZLneQ2LFy8yWTCPzh52NV6Rx+pug2MFclL+9vrMq6qDV2VmHjlFL2j4CoQIC7cGlLWqCrGHth5F6gsPW4zl8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756168489; c=relaxed/simple;
	bh=JpJLVvbE54zIuPG5rJ7JHRgT8c9MDiQk9/7EuJ3uJ7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OoYVQjy1hQOtv7Q6zUH+f+K9L8I4rkjRi7LUFSCTj7EiKQ002ctgW/stUlbZnyB10oePmNF2lsiJuT4PC41kJMAIbXrgG7jbpPnDMpNU5m8HWZKSdEgGjzVm5RyASWLLgIzLpezh+2gT3fuSOXjaf9SX1knay4Gsa46VvTjMJck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTWWaFF5; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b47174aec0eso3252734a12.2;
        Mon, 25 Aug 2025 17:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756168488; x=1756773288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D9SXIwGnPOZR3O9/FNFVDhvPNYl7T7tao6BpXTagVFM=;
        b=lTWWaFF5PHkAcbzOgWchRLthvNNVsIcjvOChvAj+LopacQs8ZPHr2TnG4nCXQnX393
         Vpjpt0HB4J6z7Iqj8qeNF1vZgLuaQ6mV/vyzIwyxfy2s0wtI0OHuGx3nrQSGQLZ+ITCk
         f3GtEw5dFsZ9vzM2e3v6p2LEHLTTIExxi/0WRKUgV0aebe7qyRnRLDykI7IT3sXZn8ls
         WRdYUJR5KOETZSvFgEglfuUSi6jATIZqNj4OVLighh4yTVkDsfMJhymdXdZ/SXTfosUa
         TtFGlFHs6YNy6PRqBcgyAH5upFmbmaqUd2bVgcz/X0/oJA9Y4GOly3U7ImUeW3lYLexY
         AndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756168488; x=1756773288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D9SXIwGnPOZR3O9/FNFVDhvPNYl7T7tao6BpXTagVFM=;
        b=dMo/wrzC7hfgVcN4nbEemtsgQzRAz/d1DQTIFzQKbTrsqlLArBihGAIIls7AsKj115
         8HB/8mEk+Am1+B8rqzYz5dsYC+sWlAZY4RTuFG9BWQxeuQ+n3yWe6BIlgu/szFn5ojKO
         AQCNypeiZKp5MIBWDihDiLLW/aIBY/NFBttzbsNT36y/Hh1HO5l9r4Kgle8hi2+aM9i3
         nNABeisqkl1/6hcVwL21tUMxsXT1whmnMasnpPPQUZbSw/1nNRXnuOB16I/FERG4/by+
         lEPwfxHh0mC+7UENZHJjySUJkBgOVAuvl6qjnF3Ck0P3pPDRUkp7rf959bsPxZ7jzFWk
         xSwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoO+3a/nfNf8hrXN9chXfVYFgZHTd+2V02m+uHoXsonAFEIXeskCxQ3aJKFoy0/mHxbSsvgVUrW4c=@vger.kernel.org, AJvYcCWMUgQNlbT753Ihlt9HRASdnsfLkLOoNl2Ef5w9HpGJtDPXlfxuZEAQEBP9/B/ZJC2NraiKXa9VsVW/@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf+SSdAxP23ys3iWOHCopNYsklcGHDN4WTKywutuTArYnv0AI+
	7Q/vIO7Pa+eK0acHROnRef2pkKuoSWuJlYWm0Uhf7FmXEH8qlTJsT9mc
X-Gm-Gg: ASbGnctK1xOD/czMrl+4SzeHPbDPy6a9pOi4EQBgedP8D3Vbvxb2aX6tBF7t4oHtIAp
	kOATFi1kZRjO0kcdTddhwyZlGvzJJNmP7kq2Dk4qY168sVJHf1/zLikczKUB0qHggYvqUiO6l+t
	Xnsqg7/Slw7Gyl/72B2zIJz/G9kfD0itSCb61ebi6wUefcYsHA8kByhLl9cLVzwY90SE9hFcPyP
	2wZcerRLnscrncQk24LB/AnTRBIBP1EJLloWHF22rnqpN5g+rPYBcaNZbXvAMDewm+L1+aQ9x0A
	8enIirJhJ3+5vuaRWHivKo1NYXWB0S1zrPNBiRt+vSYIvRxncdpcgMGfaqX86o8v/36m+RcYxNo
	8kTqa1DtfkZM8p5iPt/ShgksSf0EwVQhg
X-Google-Smtp-Source: AGHT+IFL3YsPjEXwzj5BwJGTdw5qv3+DWw7IH9L4tk4RaqjYnQRdheJrpGn42LLCQ48hft+VpwJj+A==
X-Received: by 2002:a17:902:db0c:b0:246:d0b:9dea with SMTP id d9443c01a7336-2462edd7e24mr199049405ad.11.1756168487458;
        Mon, 25 Aug 2025 17:34:47 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687a60besm79637015ad.39.2025.08.25.17.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 17:34:46 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id C8B09424E25B; Tue, 26 Aug 2025 07:34:43 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Workflows <workflows@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Fox Foster <fox@tardis.ed.ac.uk>,
	Federico Vaga <federico.vaga@vaga.pv.it>,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: management-style: Correct "know" past participle
Date: Tue, 26 Aug 2025 07:34:38 +0700
Message-ID: <20250826003437.7695-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1787; i=bagasdotme@gmail.com; h=from:subject; bh=JpJLVvbE54zIuPG5rJ7JHRgT8c9MDiQk9/7EuJ3uJ7U=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlr/v9rL7iU6FUZcfs3b7LjUfvHP7ftaJ17K7Nm+tapl /2e9t5u6yhlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBEms4z/PeNuRF+j9W8zlst drP9Ur0bdo+LM900Sve7/jyU8q9er5ThfwDXAf13R666K690CVC9JcfRsXjfpH7PjskF6r6l7ZX nOAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Management style docs writes on people under a manager, where they know
the details better than the manager himself, in past perfect tense. Yet,
"know" is in infinitive form instead.

Correct the verb form.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/process/management-style.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/management-style.rst b/Documentation/process/management-style.rst
index dfbc69bf49d435..1381b253b19ef4 100644
--- a/Documentation/process/management-style.rst
+++ b/Documentation/process/management-style.rst
@@ -42,7 +42,7 @@ actually true.
 The name of the game is to **avoid** having to make a decision.  In
 particular, if somebody tells you "choose (a) or (b), we really need you
 to decide on this", you're in trouble as a manager.  The people you
-manage had better know the details better than you, so if they come to
+manage had better known the details than you, so if they come to
 you for a technical decision, you're screwed.  You're clearly not
 competent to make that decision for them.
 
@@ -115,7 +115,7 @@ sure as hell shouldn't encourage them by promising them that what they
 work on will be included.  Make them at least think twice before they
 embark on a big endeavor.
 
-Remember: they'd better know more about the details than you do, and
+Remember: they'd better known more about the details than you do, and
 they usually already think they have the answer to everything.  The best
 thing you can do as a manager is not to instill confidence, but rather a
 healthy dose of critical thinking on what they do.

base-commit: ee9a6691935490dc39605882b41b9452844d5e4e
-- 
An old man doll... just what I always wanted! - Clara


