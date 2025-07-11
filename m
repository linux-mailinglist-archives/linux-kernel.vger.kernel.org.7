Return-Path: <linux-kernel+bounces-726807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E40BB0117C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 05:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A30568420
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 03:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1764118DF8D;
	Fri, 11 Jul 2025 03:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="KZD5bMDF"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E20017736
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 03:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752202928; cv=none; b=HoLN8D3+oVQP7IN0pPD3as8LVl6kIx15BW2YorQifhJiggmAouw7YH/oNpvq+fQCZM2Ff3qIYeFQjiRl6m5NDy1J4WYurnxSAnI8e4L4dzRl4dXYSPJ0GtftztB1/p+K1IkN9uzuf9keZ8S1H7zCPNpMMOELWckzolUzDcqPncQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752202928; c=relaxed/simple;
	bh=LGWAtyXrM2PxxMeZprVLJBwaxJToCaYtQ/uTGw3d918=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rOeMBtYtjwcmqUwZPxWSFbSZZPijOf84KrFF6KB4wQY1uG9kYceex9tIu23O1kUe0HlalA20JsbYA/aBJxIkqQ1fEtnakOJwSR3zo8ZX0dcszA2umiIif1/zSGd9Ysgvs1akGHmMR+NCjZrFDhL2wGl817f1LqBGr3rduxjPDTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=KZD5bMDF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23526264386so15686345ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 20:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1752202924; x=1752807724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sadpaz8PrWvHMkbxmc3mROAwLmTsdYFXlPsL8N6jUTo=;
        b=KZD5bMDF74gWp434LcIvPJx3Pe5rLUkY3df7/onhWNTp19WhDKNaWXosGoCcQROZBn
         mY9RY6XKyQF0RHFO+bpr92ql2+3LnJBsrEakbkCsSJCPqGuxQoAl7QSQAy0DvM89IkOL
         /3FUQVgZxjbJGzYZeTPPZO5TJ6n1c5Dsee0b33GIimWpXgsIRRD5fphu2cqqyXLg/kZc
         LIozeLQZD7VsFy+ofnouHUOial79M3Cl+hLEFnAXSTKUQO5qXvNHaSYzaVkGiCI/cnBX
         Sf2E5WnubCgrfRrl3Ek7U971gKpvHQM3UF6pMJgkU/Uih72cvrSpoyE7IKVcnBS8YgVG
         aVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752202924; x=1752807724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sadpaz8PrWvHMkbxmc3mROAwLmTsdYFXlPsL8N6jUTo=;
        b=qXLzjANmnhh4bqIQrykGf6aGhqOhKpczv9L+VQJsV8XcLGuZsXRyR1Dvw7A6YuGgbd
         uCYiLKeuqrezvqyRgxfixJyGeWdH5kY4OglZuaSUs8nenFK5eooNvGUtwvE3YQIidTcK
         jvqNzAfSbt640k0M+F/+i3OalNtmoy4uPqaexiM4z38OpbXPp7vapmDAN7JTpjF7XQO+
         +YiVqQNyDWtPeZnfhOiA0TJS8ScODThBvJkDh+qZAxFgc1Yciye0J8FI2AiUmCewfUue
         rnzf0fzDswLw2rmQOxIOydKIEilA+dmPvZvi6shB86cptiShzRJqTpBaN9NbUnSqAP3W
         77gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbfWUDUwEuHiNJMxmPHJERTFn5/to7vV8g2ewiCpJ4Nzaa28ttYkkItEHKK05qo2006oN8y1ccyBntE9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYkfJ+WyMxU0IwH3NxOm/C0sz3FZPsU+7OITRpwxhcI/81wjRN
	paXLGaGgI2Oyrb84XsREbGhBdQi4eaS6vsZM2D6Jh2nJN0B9ScLpmjL2KxczPZLw5bs=
X-Gm-Gg: ASbGnctuexlCwwsNI1SbMYmT/aXj/OlhxpKny3t7ZxA+HzamZ+8/KBx3sHsB+qFgooj
	UeQkUc4CFEgrp2WoDWfu1HHdKohYMvFtEIuKXdwH7jS66iL1nIYC+pyxk1cHybACnvxjF3d9tRp
	JbCzkaDJKyOIWr9ZyFcuakhZfP1lqd19l4ItuZIxHVhPIQJQb5ZP4QMInvNbXWW7Wl1f5/nKc9e
	W2UyovGfw5L4IBNAlCmQAQUb7lB6c5nk+gqJHXgHERueBMQ7rr5eDB+WSIdiB+Oq56kCMcfvAqO
	BrFsQJiR2+psgkSQgQ+UytM+C03mMagejLxAMTr00Jsv6zYR/W+cVoFCEcb3QE/Zm1l/GROqOL4
	vE9aIm9oZD7cv6KPqhtd+o46rTK7h/BWsJe1ZMN5S016Z2CqcW6eHIg==
X-Google-Smtp-Source: AGHT+IG3BdlUocDPxEIVRsXKPoLXrNsAE7NpPAv9kznyZrwFjv8MOOYM3yOY/fwUdxGzEatLzBzkSw==
X-Received: by 2002:a17:903:f87:b0:223:619e:71da with SMTP id d9443c01a7336-23dee28523bmr21809105ad.49.1752202924535;
        Thu, 10 Jul 2025 20:02:04 -0700 (PDT)
Received: from mystery-machine.brighamcampbell.com ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad25dsm34219115ad.64.2025.07.10.20.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 20:02:03 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
To: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jonathan Corbet <corbet@lwn.net>,
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Cc: Brigham Campbell <me@brighamcampbell.com>
Subject: [PATCH RESEND] drm: docs: Fix typo in introduction.rst
Date: Thu, 10 Jul 2025 21:01:57 -0600
Message-ID: <20250711030157.124778-1-me@brighamcampbell.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo in Documentation/gpu/introduction.rst

Link: https://lore.kernel.org/all/20250620180258.132160-1-me@brighamcampbell.com/
Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---

This patch has received no response as of June 20th. If it's
unacceptable for whatever reason, please let me know and I'll drop it.
This is the only typo I happened across while reading the document. I
scanned it for more typos when I prepared this patch, but found none.

 Documentation/gpu/introduction.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/introduction.rst b/Documentation/gpu/introduction.rst
index 3cd0c8860b94..39b4c943fa00 100644
--- a/Documentation/gpu/introduction.rst
+++ b/Documentation/gpu/introduction.rst
@@ -32,7 +32,7 @@ member, only the structure.
 
 Except in special situations (to separate locked from unlocked variants)
 locking requirements for functions aren't documented in the kerneldoc.
-Instead locking should be check at runtime using e.g.
+Instead locking should be checked at runtime using e.g.
 ``WARN_ON(!mutex_is_locked(...));``. Since it's much easier to ignore
 documentation than runtime noise this provides more value. And on top of
 that runtime checks do need to be updated when the locking rules change,

base-commit: 667efb341917bde19f5d7517b65defcdaed67c9e
-- 
2.49.0


