Return-Path: <linux-kernel+bounces-761665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5705FB1FD2A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 01:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187A73B519E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 23:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DED22FAC3;
	Sun, 10 Aug 2025 23:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0A4PJI3"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1917322A4DA;
	Sun, 10 Aug 2025 23:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754870036; cv=none; b=dq5ufGVX8sMUMyIKK6+BkWylVIf4LIjb/uBqc0bwDfcLoClKcQC/UqmGBYJwD2Pe95eW30TlOqCNZiE7svQjwGUdik3xOvuZ4SoJ/eiJ276vxoVMVEZUZ0v/XNFr1FuWqL63W4Db2K4ak2lwkZl8cK8YVuoryhfD9AThPKDY9GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754870036; c=relaxed/simple;
	bh=YqmHMucSU2DlswN5+QJUfNE73hCMbH/3S1oPKLv7ipw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T+6FuN7duoswWEgWGgefwfr4Lz1PW/hBi2qUEIviKp8KLJtiSU11i6fW3FP//6dpVZ5uCQQIlYBJZryozgWmPFRoOc+/9RXoyhvUMQhmhB4SSRCpiS9lcwiC7yK1biNoC6JSM57MqIYg2ch3lFSaao7+a1t4f5f99FeUAa1Sphc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0A4PJI3; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7698e914cd2so4832869b3a.3;
        Sun, 10 Aug 2025 16:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754870034; x=1755474834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7knVGaGsoWjApLEqvHDjmolbJK36ccHbDacWKxbNqHk=;
        b=Q0A4PJI3nQo2DJio19OAyRzmuz/Mv799MLCxOwPrJR1m9TEcJ3CYjEkwF/667WHEos
         /SjPgbut68hdJbiaWXx0NTUPYCAQ9SlU32S51fGoccgD4v67Z+dTUOL1372aWSxL0Jbk
         eY/K7CVlTEbL+ct32rdBw+ZG0PA7R8rcyPZ7Xq0ieyfdwDNcUzDUdTzqqWyBRsrn6Lhs
         RcWxN1E8AH5t+yEWxT3wKF4b0JsjWHpANIR9IDnUZ4VUHLoIfxOU7V20CvlXhlYZfMqF
         PqhqlxFu5N+/E7jExjYTN+rSNRp1IOlmpMV77gBd4hC8zypmgJUvyD+vCWX46oKjnSow
         uaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754870034; x=1755474834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7knVGaGsoWjApLEqvHDjmolbJK36ccHbDacWKxbNqHk=;
        b=vM4eypv5Ek3YTj/SDvSLtkSIPHCGJG3yAjSOQ2r3j/GG1ISecfiVFeyqb9VRGqVanf
         hBvI2pVDaHjIu9cyS4R1jmrNE1KUxtOH5/a29UzcsSztEv7NeiA/Mi9LJHVcUc5VkK6G
         GARlhbn3onqxWWUyuMKr23xjG85UBDZCAJ3wh1H954UpnjPYwEjHemRyvmvJf6FvyJgo
         D/pl7FsfxQ54yDU9KxRVTAXZS+BVQIsYMPkZVpcIjFvMI8MRkUMtSMHy2txzCXLFEyXa
         jFb+A+wR9E2xI86+kWDd+SXf+xsGH3mWAWUD5SjQtIG4kZufddcjXMhrCUS9OKdNnyzG
         wv2w==
X-Forwarded-Encrypted: i=1; AJvYcCWsbH/bZN51P6lb+BwyjnI569WcmP0vuQdYnDc27rrImrQN63h5lxQm3s7cWfTJLkKnxWNpjOaC1cA=@vger.kernel.org, AJvYcCXeujet/7N6kavR7L7DNIKpJlp0hK3nm2wDRc4J9EZq3DbqDAUlmkLrNs8u7+tNerXHvZgPPaiEIZG72wbL@vger.kernel.org
X-Gm-Message-State: AOJu0YyLsvDJKKmAJShTWE6bqSv5JnpPlDGNxRTWC4iaMFsQoRAbv7RR
	QYijDjOB6z452G1+dUGNTxeWTaZ71jUpeb7qdWyCMdlrzVNZMdG/FnVJFHGeGRSNeAw=
X-Gm-Gg: ASbGnctwR9ubOgghKG+X/ftQrxmd7UYZYiNs4eZCLkGxQIbQ63aqHoyEaSAjfAJA3ae
	Z43Qz7yNrwci8QMh1WpJ+NXIrgZRrfAu9fhQTYYujL6RfcHMsM6rQ4PbrSa3yPgkiSp8cZ2FIQf
	es68v6KI8fxHHLkmgj7ZW8ZroahH+yD8wJN+Sm86Zv66EFJUwPJz3LKDbpEnpghqmJaUrxbGAZ0
	aTFwOo0Y0UIYOwRkzv2AJnx8yjbnYt1t+OyTLNr7eM3kmwk4sdvbKtnhgFhkQf6V7MwNutOmWP3
	ivuJP2LQTFele61lv8tEP0Ft5mk4GsSJl40oiv+6KHwSLWLw4ba+/UPIOx0pANiS9TLxlsn5xPc
	nWxyCISsDqb57az8mdk6eE+AWr6t+F0E/YmGZiKXDB7Y=
X-Google-Smtp-Source: AGHT+IGhK/OXz3cPQAKcMSk1OwiUpZ9lZPXMvKVLVmgTZXjh3inToIYTH0u80Hutih/F0cszD2duJw==
X-Received: by 2002:aa7:8887:0:b0:748:e1e4:71d9 with SMTP id d2e1a72fcca58-76c461bdf62mr13304121b3a.22.1754870034249;
        Sun, 10 Aug 2025 16:53:54 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfc0a2asm25281389b3a.70.2025.08.10.16.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 16:53:53 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: corbet@lwn.net
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	dhowells@redhat.com,
	brauner@kernel.org,
	max.kellermann@ionos.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] docs: folio_queue: Fix minor typo in folio_queue page
Date: Mon, 11 Aug 2025 05:23:44 +0530
Message-ID: <20250810235346.4153-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Specifically, fix typo 'hese'-> 'these'

Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 Documentation/core-api/folio_queue.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/core-api/folio_queue.rst b/Documentation/core-api/folio_queue.rst
index 83cfbc157e49..b7628896d2b6 100644
--- a/Documentation/core-api/folio_queue.rst
+++ b/Documentation/core-api/folio_queue.rst
@@ -44,7 +44,7 @@ Each segment in the list also stores:
  * the size of each folio and
  * three 1-bit marks per folio,
 
-but hese should not be accessed directly as the underlying data structure may
+but these should not be accessed directly as the underlying data structure may
 change, but rather the access functions outlined below should be used.
 
 The facility can be made accessible by::
-- 
2.43.0


