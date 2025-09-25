Return-Path: <linux-kernel+bounces-833452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418D3BA1FD4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 01:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0418563D4B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA5E2EAB7F;
	Thu, 25 Sep 2025 23:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rIkBulRx"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BDE4502A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758843924; cv=none; b=d240afxTGF/n/7sy3UAH6PRuUASs1GImO3li7MyacoHoE9Mz3x4Za1C7ONNY2garHtAJh+EMqhgvKSLRVuomKBSbl0pXC4WUg5MHV/Oi0TJ1iP5ezChlGc/kO7USjyDdkWmyUHzwGf7Zf+KJzS90624Jn/6V97NsZTaE2DIiKTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758843924; c=relaxed/simple;
	bh=I6Ydgfc2v7hNN8vU0Z4GiGF59ehBkmOfll0Wv6sZitY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F7+8stM7LI48g5sHCSWz4N77w53OoqY4BGsCLQFx5U7G9YHpRU8iyOwcn+NOk7hmkUj4OxXLg7rU+dQ+jUXSazCOuuq+ZlV8aQZw3+oyQcv+cBOP9jEQSb2gr84OZQwIuwzYgpafFZSy2o+U4FoRek4MJndFnJT4z70vmAjlV58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rIkBulRx; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e3bcf272aso20545e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758843921; x=1759448721; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dGC41HLAdfIjYQifpR0ZqqtXMnDJzzLlr+J9hH+QMsc=;
        b=rIkBulRx8kVw9J/s5ZsSJhOjG3AMvkLWiO1Pva2MuJ9KHUQ704YRZCG0dDO4w4hdLq
         hpbetgC8/WccL5ZMP4DSUys8pySx7dbrst4Tk6KfFzQ0hgDPKPb0HD4SoBie0geeKq/F
         30cUFe6Q+5/mGbvLodQrr47BOZ89EPhEQC3g8xya2I8WCGZp6PfuujpdLr1rrshtK1LE
         tsEfwgj5nUBIGPsFjc9w12zwMJcppRxYigQGI022ZlKCPTEOlVXTwgkybeo6PMa3xwqz
         wQadhqqlZ6SfNE+dOgXZmrp4ySM4h+mmDfcrY4Dg77FeaakfelXujKihRqwmkyV5zFR1
         YRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758843921; x=1759448721;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dGC41HLAdfIjYQifpR0ZqqtXMnDJzzLlr+J9hH+QMsc=;
        b=Q3SrhnoPPyOs/fz3WQ+yYJ1NZzvYAT2qWpb8LlEz85SAH+OFBcxP0vDg/iLu1LeS4F
         91PJSTYMg1z20CoGLf/hpY3IovJr0rCfpJCwq2RBdnnBGcnJq0oPBOtYm2Fqxuz95+Dt
         4mNznBTEvnz1GIOp/D+c/4UuDbdiR+gJ2A32PC1h1E3LmglW5Ey+PMgxAZmvpdYZcFfI
         MXjT0AqU3xZBfuMJjmESZHUALxUZPBx6WLXqZWr/YOOJh0B06/Dk/W4//JOC9UFsdCkN
         2YwGxNAhXR/EpSsndggNQ5jUPA1kwYcI15v5j9MXv7ULFAx0IWtvm/V+EOKj31Hf1pMM
         /zDA==
X-Forwarded-Encrypted: i=1; AJvYcCUEjGvLSAJUAfWiGhlvfDoEcm6ZywmKyXdgZw2Ds1JttbvfkwcBs6jQsVJVETIahfpRWzwgPPJVBC0/O4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAU8yEKrNbhHmdewvksna02zm7MDLeLMatJvNGlvwADDTNvxY1
	mdRJKZvP38vmaTb2tsC8bJNLZ7Jn/NtfO3zrnad8krUiRpCePrIpF2Q0R6Em+FQW1Q==
X-Gm-Gg: ASbGncurZwyBtbj+S6SBXRHZsZmQqPVhsXlC6X4wNlcPk3J4sIG86xDeWyzLActTDYF
	Ji3f/VIUYuf4I1dEtIDHrH8qzLKktw+NXCrGaqiUpXVAw6pxOLaElq66E8E5FG2+s5IKM+3xyc/
	njVxHJ/aUKQdkERUM9XWjacO0RkqjbsNVh+dOXHx4Z6griY0DnBxdKNInt9IlTjnlU+ddbqrPO1
	mosOlHWbSm1Rr33wfFbYtOOpiRoAm5L+dv5JnOU1glh9iw/k7V+HYxCk8+32NK/YmMLA1Afopf1
	pTPLXr0pklz+Ep8Nc7v95OG/AedXwLXa6gUusb089XLhQ4vjbEYuqcZq/5SxBSBQEh/2rg81P5j
	2K7dI7PGWElThZABnLw==
X-Google-Smtp-Source: AGHT+IFW+K/NGydmot5DfKK68l9tdnpwSIK5cgXaxZI8zhEwRTxPDW93Kj6jmV0U/7IUYCXMapMmtg==
X-Received: by 2002:a05:600c:1516:b0:45f:2949:7aa9 with SMTP id 5b1f17b1804b1-46e3b009caemr429065e9.6.1758843920952;
        Thu, 25 Sep 2025 16:45:20 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:802b:ac1b:7bf0:4c9a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e2ab31bdesm92177255e9.11.2025.09.25.16.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 16:45:20 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Subject: [PATCH 0/2] ima: add dont_audit and fs_subtype to policy language
Date: Fri, 26 Sep 2025 01:45:05 +0200
Message-Id: <20250926-ima-audit-v1-0-64d75fdc8fdc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAHU1WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyNT3czcRN3E0pTMEl2LpBQjQ8uU5GSzNDMloPqCotS0zAqwWdGxtbU
 ArMIBRFsAAAA=
X-Change-ID: 20250925-ima-audit-8bd219dcc6f6
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>
Cc: Frank Dinoff <fdinoff@google.com>, linux-kernel@vger.kernel.org, 
 linux-integrity@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758843915; l=1259;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=I6Ydgfc2v7hNN8vU0Z4GiGF59ehBkmOfll0Wv6sZitY=;
 b=TR67dF00Kbu3UTSn/q8bhk4Mhq2kSm9KMuTlj7mIMngL7XF5pp5tQpE1zzflNubEt0whBKh8N
 kBplw/6C8hcB7s308R9QAz+OBWDekRZqQpN+Dl3X6AHnXqu0WbjNpVL
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

This series adds a "dont_audit" action that cancels out following
"audit" actions (as we already have for other action types), and also
adds an "fs_subtype" that can be used to distinguish between FUSE
filesystems.

With these two patches applied, as a toy example, you can use the
following policy:
```
dont_audit fsname=fuse fs_subtype=sshfs
audit func=BPRM_CHECK fsname=fuse
```

I have tested that with this policy, executing a binary from a
"fuse-zip" FUSE filesystem results in an audit log entry:
```
type=INTEGRITY_RULE msg=audit([...]): file="/home/user/ima/zipmount/usr/bin/echo" hash="sha256:1d82e8[...]
```
while executing a binary from an "sshfs" FUSE filesystem does not
generate any audit log entries.

Signed-off-by: Jann Horn <jannh@google.com>
---
Jann Horn (2):
      ima: add dont_audit action to suppress audit actions
      ima: add fs_subtype condition for distinguishing FUSE instances

 Documentation/ABI/testing/ima_policy |  3 +-
 security/integrity/ima/ima_policy.c  | 57 ++++++++++++++++++++++++++++++++----
 2 files changed, 54 insertions(+), 6 deletions(-)
---
base-commit: 00642a06d60c897a8348784e1eee9e5369219ce5
change-id: 20250925-ima-audit-8bd219dcc6f6

--  
Jann Horn <jannh@google.com>


