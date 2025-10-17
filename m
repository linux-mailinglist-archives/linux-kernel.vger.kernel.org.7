Return-Path: <linux-kernel+bounces-858745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 39550BEBB30
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3B68344D26
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1412F0C75;
	Fri, 17 Oct 2025 20:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gqI4ABPY"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC64254B1B
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760733464; cv=none; b=tH4OY/h3vPDX/exaAb6rsKEhEL6o1+ABc41+RUOFh+o5o3mF6wnj3mRyeK3Q324MqVweZQh4T75eqNnO1w0ipgzk3brZzurxM13XVau2H4VJBDeunBKuj/5zYXuYsAzsFPEC30bb8ea5ivawoEUL/vVvyCOBYJpzF3OrgL7FqzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760733464; c=relaxed/simple;
	bh=MctnxTuATai4l54nWLFKFelAF8yZCCN6uTLE/mlmEHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XdguKzC9Q/37QugjYcIKEqUxsmZCXKnwL2vx5Onon0G3pW/XP9soNplM8091X05mQibvZWGuTtukdW3Ku/NV4HY68+XhOjaJutpu1tgxB14R5+TRApSVdqKiBt7GeVYUJopKRHOnVI+flH+Gggua4pHWcRfIMuokYRSFjIPHZtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gqI4ABPY; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-793021f348fso2267542b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760733462; x=1761338262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZeBq3Lk7BVfi39KwhzSp3L/wgMnqHyapiXXWG829qc=;
        b=gqI4ABPYZ4QxRCc4QY3quTX9wWdAeBGRG4f2PXIHFN3czNr438NrTWUk8dW6xUs91Z
         IqDmV28cJc8njMpB0h5e6xXleESDsYjrODmGS6FduS67qsKnILcQCObgOz6J5Q0PJ0SZ
         U1p4pUfI6fQq4zt1eEvwMffrKUtyF1tfAfGDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760733462; x=1761338262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZeBq3Lk7BVfi39KwhzSp3L/wgMnqHyapiXXWG829qc=;
        b=sLc7d54GO+sapVx87Yh15yCsdvM/YF1ES603mR0ejkyLqc8ETIlVBrrozin1hzW1HU
         PtAM+f99EYFHcDn4DoCvbBmqiad9274mw+5nxiZ9VAk8rfWcdQlB7rFgNSfGqiTj6YXw
         cBBvSIQFeTBj3dnTv8tmIFPHQJZqvEog6iReKmMr5oL9B1yIwsNg+iYcKCE9NCQ+Y9oF
         BCHB69PU0zQW4tQavSYvrMy88h0cs2UbNruCrIrQPFBLH67HpdTuVcuPqY2DJ07Dum2h
         D2Kl7pMzlYWqr4ZZd/hP6GIT4M58Th0J0X1ebJvJhUiE8HQNvUqLk7EkqOrsLA7bhz01
         dDSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvhCa/UwQEZDAtwW31qxKPW/Z/slZEFZfm0+0iHrWaAaDeqjVOWtmTvldIvQRiN/N3kEynQ53oM27OpfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDBHW4gPK7p6ZwR0gT0nVQlIS8lZOokNSL1pGGJgQSNZzp7+52
	xqnlhRdSZLrlEKyR/z/wuYUnXYvI78xs2QDeRWIlqa/KLeHAhcS64RPNTU1KvpiBoA==
X-Gm-Gg: ASbGncvcVzZPmGXUoNfPCYEm7jKgHEqSptFcSQ+8ySD4dyh7BlEL2y9sBQdUPNhcm6q
	9WERf/ZvcDjWv8/1GKUXT/0EtRD+ELWcV/BmapyD6FiCaKOLIpbrqhqCN0qHGcMas6Jhkecjbxr
	StY1Dc4DKAknN2BZcQ+xjHtsKZZgLHE0U7Hyj+JKjlYzpfowJUGic1ciPFrfM6VEYJTRfuABEeO
	nJHSNrTtmHs9WoO0vDwWNQ0Y6TFRipWHF+ZPh4eZK4e2C7wqnpHpHfeiE5XgyMi+8pKoKP+Kq8p
	owywfsf+ErqAuLZpWABLj8ohZaApRxjJl6aCI1H0nvIbYNs4Po5ZovI75EJFk9PBlw4zBb2twST
	0bLOj0bcJTZFeYqR6/fYnkJ16/g3e7ahXKeWVp5//VzARqmBOt1MEXy4Us0SMWta3m6v93+ZicX
	BAP5U1vZjpcyCtrwME0kMz8Cg836GleNsUIaEsJg==
X-Google-Smtp-Source: AGHT+IE/YYS3o1+JuvtET9j/q+byOk9MK+q6kmDUXS3KntYy67SnJd6kX1S96rUUu+Rtdegc54AW9Q==
X-Received: by 2002:a05:6a20:2590:b0:334:9fbb:35c3 with SMTP id adf61e73a8af0-334a862167fmr6473965637.46.1760733462564;
        Fri, 17 Oct 2025 13:37:42 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5ca9:a8d0:7547:32c6])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-33bb65268b1sm2837858a91.2.2025.10.17.13.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 13:37:41 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joe Perches <joe@perches.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	workflows@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 2/2] docs: checkpatch: Drop networking comment style
Date: Fri, 17 Oct 2025 13:37:12 -0700
Message-ID: <20251017203719.1554224-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
In-Reply-To: <20251017203719.1554224-1-briannorris@chromium.org>
References: <20251017203719.1554224-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Networking no longer has their own comment style, and checkpatch no
longer checks for this.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Suggested-by: Randy Dunlap <rdunlap@infradead.org>
---

Changes in v2:
 * new in v2

 Documentation/dev-tools/checkpatch.rst | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index d7fe023b3080..dfaad0a279ff 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -465,13 +465,6 @@ Comments
        * for multi line comments.
        */
 
-    The networking comment style is a bit different, with the first line
-    not empty like the former::
-
-      /* This is the preferred comment style
-       * for files in net/ and drivers/net/
-       */
-
     See: https://www.kernel.org/doc/html/latest/process/coding-style.html#commenting
 
   **C99_COMMENTS**
-- 
2.51.0.858.gf9c4a03a3a-goog


