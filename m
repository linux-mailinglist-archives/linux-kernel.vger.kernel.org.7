Return-Path: <linux-kernel+bounces-787001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CA9B3700F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C8A46868D0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C51260586;
	Tue, 26 Aug 2025 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="c35nvrrW"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7979A3148DE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756225071; cv=none; b=CMkvKvvUMdcMM572lRTSEB8EVbw4JpMfKouY2UZYYm15FMZv3HZVqvRC2CAsQIyjrMw9UqpKPKlemwn1raAWdPBNrrLt3PzDLE3lbPYA53OipF9H0wPmIuvtRWDLX2pl++d3KBvT957+7c5C5MQFQUlPWCy7Zm0b/3JXS3KL16U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756225071; c=relaxed/simple;
	bh=2lH8ioH45Wggjb2juAbdEGnnEZreYmNjG458FfboEmo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z2DJ+Yy2zMw2MYina9AHqx1jpHSkv4WqJdz9bYP8ClkjLAK4SwAhiLThM/l4ErJTXmek05N9iL/B3QIAaHzEAeHaCbMroYgCF+tgXOclG+aMyzyjY0fl/UlhUOqIGGzBcWiPgc6z8C9fXaenFAXEWSVkvMd/zynsARmuEjro3Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=c35nvrrW; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-771e15ce64eso1879899b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1756225067; x=1756829867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J54+ADUp4D0RUe8Hc4o8RWAXq4/n/q5XI2Fh/l1VXTs=;
        b=c35nvrrWlo8e6/JYvJ7g/2OEXtxxSFe81EI4pV7e6Dl1Y2lKR20QB7X9TyBrfVvL0t
         Oa5yJhA/eIax063XEmS8FpxvOPI6c1P0/T26x4rKj1rrv27BMTG6RqFmu4kHdVP/Bi1d
         3/GadnlUh6z9tObRYjMZcRqWp590gYru+1+bpfW8CehUSUoV1qCdOyjSClp9EV3DpJMM
         LT4riVC+H67PG1NwC34mR7YbnuWV9qjnzTeC8V++fkLhsJNrE7G+bTUtkI+X4hOGCYKD
         hgQqvsY62354a+jnGphFLg5NqBc43Qx0dwyQ9YT8V3xsBCpYtSslESsg2/lKImp9Yvw9
         Pa2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756225067; x=1756829867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J54+ADUp4D0RUe8Hc4o8RWAXq4/n/q5XI2Fh/l1VXTs=;
        b=a97359gY6XZOUNVknzcCRYBFMxn3P1xbkjcRbUTt59iwhAML1Bwju9pdEfkyz2ByoA
         NiRWuNGi2XNubAK9YyGdRRb1EayBJUi/m35VP7OeT19lYRnJtBHwTXHcEMja/9o0Wb+Y
         lyY7hIXyAfNvL4MxHLZ71RWwJ9Lx+KWCcIYH9AvD+dfQ1XzmXo7I8NV3DZqOQeJFwu70
         WK+sffZ+iKO9W46oEvHd2zogu0OInz2nNCk9kPc31e9Qujg78eT/IfE8e0UJKwwh/QLN
         5WfbuvHsoY5Z5Zyu09UVihtcKLyaI0/OslxfOBAPgpRbGwjrHZ90sIMUklG0jzfnUHpV
         OQrg==
X-Gm-Message-State: AOJu0Yzb2PuMa9D6IOqk2yxK2v+mQRwxKfzSQzBvfGfjrvWFfdjKoNdH
	Jj5zhQQI8JZe7YsaEU3WbNL+GpBBYT5BfEF6cMucvzSsziueC8ixLlmtV4WjaFBLrc1GJszoEkM
	pYgkl
X-Gm-Gg: ASbGnct6TiaC+wY1gfGQkPSZFCIR49RJ3ymU9xSDJhAzPQuP6gcOPN7Xev/uCuz5JuS
	FCQ0dCy2EX3q6KdnroDItIItbeC4rQdUxAVbBEPScfDHsNyeK/YbtNtNH69sZvkgFJgVxsskZSg
	8CQ+ILgJ7QWEWEfryOCyY2e5hP14bt1bWhE2YMIObnCtWMrCfryUiIvYJO6hjX4ZIhG2q1TriFT
	/kkcS0kD0waH0bLHkoIPV981Ia1UHPuuQbjEZCPCftYa/7Ti/lATOfSevmkjYz1megctWY6sKqk
	+74gpcLGwVRvT4yObkd1CsNB95b9T7Fo05xcwh6EeGbGLalBmLh4aWNRWpciubvpkJdnf+/wgrM
	x21LoM6bNee+Sj7y/BgLkIVGo3qpzZAufD/tXbj+yKrbkEVoMx+TLm7XhOS6WJg4adJq6
X-Google-Smtp-Source: AGHT+IGfkWq4vB5y+zmEhXlAoKPuOuQ2Ri9EyJbqKiXJ76sAFWnpy7JCz0yq37L+mnAqL/fWSUXOGQ==
X-Received: by 2002:a05:6a20:734d:b0:240:22a0:f232 with SMTP id adf61e73a8af0-24340ad1fb9mr22848901637.5.1756225067150;
        Tue, 26 Aug 2025 09:17:47 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:f8d5:8589:bb53:d71d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8c369csm9566177a12.24.2025.08.26.09.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 09:17:46 -0700 (PDT)
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	409411716@gms.tku.edu.tw
Subject: [PATCH v2] btree: simplify merge logic by using btree_last() return value
Date: Wed, 27 Aug 2025 00:17:41 +0800
Message-Id: <20250826161741.686704-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously btree_merge() called btree_last() only to test existence,
then performed an extra btree_lookup() to fetch the value. This patch
changes it to directly use the value returned by btree_last(), avoiding
redundant lookups and simplifying the merge loop.

v2:
 - Update subject to clarify this is a simplification, not a bug fix

Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
---
 lib/btree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/btree.c b/lib/btree.c
index bb81d3393ac5..9c80c0c7bba8 100644
--- a/lib/btree.c
+++ b/lib/btree.c
@@ -653,9 +653,9 @@ int btree_merge(struct btree_head *target, struct btree_head *victim,
 	 * walks to remove a single object from the victim.
 	 */
 	for (;;) {
-		if (!btree_last(victim, geo, key))
+		val = btree_last(victim, geo, key);
+		if (!val)
 			break;
-		val = btree_lookup(victim, geo, key);
 		err = btree_insert(target, geo, key, val, gfp);
 		if (err)
 			return err;
-- 
2.34.1


