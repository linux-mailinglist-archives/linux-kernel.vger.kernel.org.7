Return-Path: <linux-kernel+bounces-858559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F574BEB246
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 746E14EC90F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFD8320CB3;
	Fri, 17 Oct 2025 18:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="npRBgRq3"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0781B2FE580
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760724160; cv=none; b=erpE2Plwpp5tOMTJscveeZVyxuHwzThb3LbVCHUptCCiOymVCBVmoyuZP6jG0clmQbajI3NblwqqKfs3+VF4Eh8Qxd0oAfU2wjTq74NjxOSC+ADr+tly9YeNIDOPFZrSrKP6eUTBNHhCDxHdlm8NFjvxmuZlr73duZUg+U1AffE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760724160; c=relaxed/simple;
	bh=jwRvVCNYLGeSa+0leHMXF7EXzjGL8SPjU5bfAoQyeFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jMUg2Ei17HODv5P8besi3ZjHBD6nOqlEN2KFtxMLAOtz9QvcYv8e9tPvqDGaPpeUeY5a97JEvYycH3gHTOyczANYqFmhv1hZVQrxgMgWzeqiCfW20v6PFn/yfbXeyAUlzaq1T2Rv5IvrzoMGkrVDfP6Tzs20GO82tbNaL53uesc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=npRBgRq3; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-78f3bfe3f69so2072126b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760724157; x=1761328957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ukAYWQ0T+S/AD9w3VhmapO1quF1wQBT8B5YkcopmuU=;
        b=npRBgRq3dkB+a1KVrRA/IjdAauC0zH/CrON+lsaBqe2S+v1U/f2DnAUjRupS95b+0s
         HQHqNO92ARYR97LAFks467282SHj2Moa+1crMV+J4Q14rMuADcsGJTDG+u8rmnGvVGyZ
         SkGy9hMu4MIJPwBn10UmdTR1hr3d04tL6hQiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760724157; x=1761328957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ukAYWQ0T+S/AD9w3VhmapO1quF1wQBT8B5YkcopmuU=;
        b=U5pdvHWM0L9Yl07RN4QuMu7xg/kS7YlMyfeU/QWVKYLFM5fCCeW/4oqMvVoVUsIODC
         vgxFE6WfXIZ6Ma3LsGLUPCkDfer3UW6IRrHy5kot+jJerGU7U5kQhKikQVtmQpj/lMLb
         igX+PzG7/Jaq3u5E215CBSDDmOWykVf0PIhPn9dFNneKCS9SKUnucathgqm/TNskFwFy
         6rT/8ddT8xNSsHZiQlsdb2TnpNdLdGpZqHlwAwLaPvop1jZLacY2z4tQI2IgQh9pC1ie
         zeaXbeJTKlVondop+Z5MIh/8+xKmAkgQPp3W4/p1aeUzGb1iy6mzuNcg47plaITADLTk
         DmFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZxJYBIlAYyIhtB7o8KSrWaeBzERSfUyBI51sThmgBfxOCC/ozai77XkaVCneR4EK7+vNnalbJGstAjLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw50THQGQGODfd1RL1ELo37iXnAJoX63UyZ2uv+K5uDqb4lm4Ak
	UJVgqffov5GYPv8UTa3BLpHKe2P587AZaKSzkh+kz/5Rckja3IkRK5vVB45o7cGHhQ==
X-Gm-Gg: ASbGncv8Um5VV/ktkiGOJqA4Dwx2tQm4CEsWG+6jxHjzKFcRL4a/HaCUhDIhN0Uiny1
	g9HWzIvl7SJy5VDQB76wAlBHyoXPwMJYYwGPYCY2wxB+E3GoIixUIIHJ/jm0LTLpNvGxcddwBPd
	r350Ob7n8Ymf5Ycy2bviVNuhjwPKKDa3TGaz8RpxUmoLwVEKYxvS638liCDhvu6+6HtZAsXscMX
	aEGkMMtL6818EKZRTj5n32tj7kGG4o5+LXwzAW59mN/pQzBwWN5d5Jl5utwsaxEuqVmfnMiOD7g
	SnxPrmSpiqDWtC0dY+WrujtwiM3nPWjPoz7oBFCKn2CvKv5yQTXOKEOk3xlA+IuoTOyzXvRCLRG
	o27WTBmbBqpn1JOGVhZkd06lUv9H6mxNhbI09hu7kUcHypGvt4UaesdZTJW+aAQ/O8TL6GiHx7k
	VzZ02dccCTvXdi1EVG+XPZBo+PqaDopdtcJj+kaP6zuiX+gUwf
X-Google-Smtp-Source: AGHT+IEY+KGbfcrrIWW9UFIVstpKYMq5DjhrzNx35qx3JyQw0vx6QrYeoAPZjdoiMrwc8TIfDGRpdA==
X-Received: by 2002:a17:902:ce0e:b0:264:befb:829c with SMTP id d9443c01a7336-290c9c8a738mr59262805ad.9.1760724157127;
        Fri, 17 Oct 2025 11:02:37 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5ca9:a8d0:7547:32c6])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-292472193c2sm1227785ad.104.2025.10.17.11.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 11:02:36 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Joe Perches <joe@perches.com>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH] docs: checkpatch: Align block comment style
Date: Fri, 17 Oct 2025 11:02:19 -0700
Message-ID: <20251017180225.1489398-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ironically, the block style comments in the checkpatch documentation are
not aligned properly. Correct that.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 Documentation/dev-tools/checkpatch.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index d5c47e560324..d7fe023b3080 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -461,16 +461,16 @@ Comments
     line comments is::
 
       /*
-      * This is the preferred style
-      * for multi line comments.
-      */
+       * This is the preferred style
+       * for multi line comments.
+       */
 
     The networking comment style is a bit different, with the first line
     not empty like the former::
 
       /* This is the preferred comment style
-      * for files in net/ and drivers/net/
-      */
+       * for files in net/ and drivers/net/
+       */
 
     See: https://www.kernel.org/doc/html/latest/process/coding-style.html#commenting
 
-- 
2.51.0.858.gf9c4a03a3a-goog


