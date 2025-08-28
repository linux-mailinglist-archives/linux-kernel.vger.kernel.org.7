Return-Path: <linux-kernel+bounces-789209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4DAB3923F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 05:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E1197A6F16
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 03:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9D9221275;
	Thu, 28 Aug 2025 03:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z7If7QHJ"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35BD2153E1
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756352100; cv=none; b=YxiSTygP/sqOc/RGFPWJ2EDrMQUWR8uCPhlFHRqUL1zdSjVIsLw3y1BMTFccANS/DT8Jr0N6KmwNES+kiFRbYhM4ahAKECuWpsE7p4MYtqHcE6reV5Z/C6jTQzaWMiRpvFt0r/Pz8KvnBJzOsuqSNQDlLAVHWj9OMggbhsLto3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756352100; c=relaxed/simple;
	bh=IhSuami5FOkMrRozidtGDdWSynBOGV5dWCTUzT0LbHU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=X7UVajlcTJmDwCNLBz3DjADg+CVhRJu8AFWp7AY1TTxj15yFONs0c0AQ4El8zCm0b+0GyzhJG/HClK+xh5aaJoZ7Sfu8wUycQb4Sw6uFDn991ZU8ifBWng49bmdywkNhnXYNLC5OrgoXSXgNFPEo4J36XPDDAFT9VSOr2iYUnZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z7If7QHJ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-246cf6af2f4so10044445ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 20:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756352098; x=1756956898; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/WqEuyTIyd5zOd3WLqQe3w2Nm5EOsfqMvIQzK+RB3vw=;
        b=z7If7QHJdZuMG7KN7oF3lBddlA0YMiX+Ms1vP5s8VIXX1f4cIkRj/6VXm+GoH7qlux
         +0fFGpqFXlGrLfBVzA9Ur0coYeqoT8USKyPVGGJX99vmJt0u8boNyaof7W6HfXNqT6d0
         J/rHsJ79hyi+HA/hyihaX6xv2TbLl8FQxFkWbLy3hUjt3Nz0yMuRpp6URaaRgPiNysMc
         LSR83Rz3iZy42suE8LUAfzG58I04di6y6U7D6TY52gfMXaCZoZY0sqK6Aghe8WpxPz5l
         MyqSTWBpSELG7cpd0OpNXPuiLZZYfyowI3XZpwJghl0u64wmj51nVCXvzht2DSgnlYOY
         PTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756352098; x=1756956898;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/WqEuyTIyd5zOd3WLqQe3w2Nm5EOsfqMvIQzK+RB3vw=;
        b=hIO5u29SjKgR05fN53zRQX5ZwBIP+fqgnyuB2xiao9974hAwI15GeDXNgzuQNG23QK
         dxHdHOZfXDH3nE0a3S0vQp3y3Vn1K/JRi82WnB3S0/U63mLjRKKKCz/4Lrch8DLCWXYZ
         7oa3RfA4BtZBXq+WxDdnmGSCZm8mKfLPuWiZHdMU+cYlilPi55NG/uvExuYKsWGHTE7v
         19lsvtRImOSbn6i8Ffi14o4x872Uc2kdLNnnv0DdO6BeXZ4hY4Rw+v8AEANoopwlOhHP
         EkerPab4FwS09mD6cNFqnNH06BaUJBhLXrxtfNv85U2ByQT0AwfXT3WBZJozCZoKqyU/
         MjjQ==
X-Gm-Message-State: AOJu0Yy2cm9ygeNU10cAeyHe7/YzGbTsrIu2lUPdlYP09M63pCOA5K2k
	C9pgqXgsRj6RO7zHV9hlSXMHnGjHU+WZWUj7vTj/CZmQWxAg4hiN+RZQG3aX/S/cpkFKOlVYqAb
	PcRWn8SS5eJnh3gFHQF5WyJqHEQyYk1TTyZCGs/voTXP532GFLmhfijZ1oyeBAC6x0cIBAIhLdv
	3BOVx+JmLqo/tZXj4eDfR+XstTyDZWuWSMDOnrJi6E2ufB
X-Google-Smtp-Source: AGHT+IEpQy3j21FWNQO7+/sSa+7qm7Lm9lp+ZdUK9K1q15QEPgaECMBM3eTWF8eeT6zhhwc2WtM9gKOR+EA=
X-Received: from plmm21.prod.google.com ([2002:a17:902:c455:b0:248:9ee8:cee5])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f612:b0:248:b28c:144d
 with SMTP id d9443c01a7336-248b28c215dmr43515535ad.59.1756352098110; Wed, 27
 Aug 2025 20:34:58 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:34:45 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828033445.3851468-1-inseob@google.com>
Subject: [PATCH RESEND] lib: parser: Fix match_wildcard to correctly handle
 trailing stars
From: Inseob Kim <inseob@google.com>
To: linux-kernel@vger.kernel.org
Cc: Inseob Kim <inseob@google.com>
Content-Type: text/plain; charset="UTF-8"

This fixes a bug of match_wildcard that incorrectly handles trailing
asterisks. For example, `match_wildcard("abc**", "abc")` must return
true, but it returns false.

Signed-off-by: Inseob Kim <inseob@google.com>
---
 lib/parser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/parser.c b/lib/parser.c
index 73e8f8e5be73..62da0ac0d438 100644
--- a/lib/parser.c
+++ b/lib/parser.c
@@ -315,7 +315,7 @@ bool match_wildcard(const char *pattern, const char *str)
 		}
 	}
 
-	if (*p == '*')
+	while (*p == '*')
 		++p;
 	return !*p;
 }
-- 
2.51.0.268.g9569e192d0-goog


