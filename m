Return-Path: <linux-kernel+bounces-884498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E774FC30520
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 876B43BF504
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891922C3254;
	Tue,  4 Nov 2025 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="b9RhNZVm"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7349E22154F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762248544; cv=none; b=rVsuEZ17mx/cSqm9c+FoJOTnAZ5dZRE/B3EJxEXCYcel4aMd2ytu0VN4IhX1tDmv2jTnv8kUVKAHqbSzKn0h6RlfHV8mWbNOGrFDkfaQ3WpiYtbNocGWjRTJHh5EmoZNdJYR2orEJnv43+ozUrvuHmx+Wd3p9/wd+JoSV7PT8VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762248544; c=relaxed/simple;
	bh=9NZz8+0HjGiYkq9QMHNT4BbNht0YbASLljRV/7ufeE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kdBhodxdDvX1fqayCJtUv7q66ZWV0QdN/y8rE15TkAJat5YdWkY38AyxgkzbWYVn01NwRzqpDRiFe0/oxVhOXDnokmn8N3fBVaevkACR6kjHeXD3L15IKk/F2iHgyxh2mQvOaK16nGlCRzxt/M7jsqIGagIJjcB6WtzLSAXURXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=b9RhNZVm; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29570bcf220so32803375ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 01:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1762248543; x=1762853343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Hk3PYE38Zzgv3m8VQl8wYmuHsU1MqZfGLEy/1nq+zs=;
        b=b9RhNZVmpTFrA5vL/Nmr3PaZ2aHcswxQaeLJqxgNmGUmuJaspv/fofl9LSjBKASwlx
         DOuzg7pVy6R+VT8QfWn5s/KlaGoTD5zI0D4K1YO1oB48xT4JVP3CXIYwM03n2pPff+Ap
         781IeBnfJJ2hB8YVXrB7jKZX1snSVKLHrjbZP0RBED5gnBygBENQWCMCVas68ZNPZtxj
         Wa0sm3vPr5pb+UHlggw8k75h2f7jfqgKx5/AOXj3XUu0gk8xhqHutsSC/9ihNwhjYnE2
         mxsMxveRZX1Lvp4zUTSrbgbJJLk6JFO7b5e6/W26gsVZUuESlGt4cnmXYubdkSuGgszh
         wIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762248543; x=1762853343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Hk3PYE38Zzgv3m8VQl8wYmuHsU1MqZfGLEy/1nq+zs=;
        b=ktzNkFn85XKo3z41TsGoDlXk6jrXLjpI+NIqzAMQuIhG1NAYlWFKgjWsr4azMFx7Pw
         AOUfpMIEr6cMzJHgehgsXNnpxdG/IuBGcg4M5qzNe3KhmVtcPEBK5GjxFET6h1zUSerG
         o17oBszPVh2Xg04OntkiyUxtiXnYxW+nL8/cgDzvWd1eqXG/MDrvff4kyTapaI6y0V/E
         6caFn0dl7aguG5fpCgeQL+cPUIW0239LBiVpQHgGdgUh+bWCBO3ieSZ2PAyORiNtXRug
         NedeQla5sw/EUOC+emGrGbG/Z4mau4YkRm8MhgiQHWInK6R+cPyxqTsUwjw1FCOudZKJ
         7kuA==
X-Forwarded-Encrypted: i=1; AJvYcCU2hthdwaa1w8VwTdoL7mU57cCla3YQ0R8ULbt3ayIoCc7FVU4k+ltlaGWd/JYmqt8VIY1Nyla6DNcxVy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlJqUAX3hBu3psB/FV2qYRhyYukSXUDJj1YVLtYXB4fvAkomt8
	0B+zwEvUxIsQQw8XfDDpAbrCUBjBx0gBqVMMiEQRkRjqBLhYFmiGEO4l4+n1BGk2Xpk=
X-Gm-Gg: ASbGncsFvlwxzV/ueAVx4KhEPGoGmU9ZyMpQGyUlHyY4pGqMI9zacI8hQSS4+Ia5Hzv
	42iyV9u7jE/2xSFKGbtxw75P8KC8Vg27ZYkWQr9/5sQr9yJ/ruFAj0/59eTA7kLHU0rBqwm7OSM
	wAFu86y0AGWU7q3fAbSzpNKcoZh9rE0Kdv2HxevMGHt1z8QI0lC29f4TeFvzPjIQr2S9iU0TlT6
	HVBlp1XdnxGsrpG0+T79lrDQfbSoHg/tHYXP/ui1tOFxQGiyROFFeX2iWoN+tG47jiVZbmEgvt4
	Qiq3UBnsQ19XnTT09ZGF+QDNor84Vh8t6VvemEcijLkgwvKvkWkdI/b/4xzr0UNfPYovHX7F2Ws
	bfk0937h+TmretLAdVvtTzGosF47eTLXTm4qXZK5czkCaTMHT3kz7CtbfGJrDYGD+3LURcszRgD
	HDb13G9WgoUgeVwxA=
X-Google-Smtp-Source: AGHT+IG7RTH3tWAxCPZkbkFtzG+dpb0z6mVERYHnwx86lq/fCclFo6zqdFexGNibOW+avSxjFq5S2Q==
X-Received: by 2002:a17:902:e749:b0:295:7f1d:b034 with SMTP id d9443c01a7336-2957f1db313mr114052945ad.4.1762248542808;
        Tue, 04 Nov 2025 01:29:02 -0800 (PST)
Received: from localhost.localdomain ([147.136.157.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415c8b78f8sm3874700a91.20.2025.11.04.01.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 01:29:02 -0800 (PST)
From: "jingxian.li" <jingxian.li@shopee.com>
To: stable@vger.kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	adrian.hunter@intel.com,
	sashal@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "jingxian.li" <jingxian.li@shopee.com>
Subject: [PATCH 6.6.y] Revert "perf dso: Add missed dso__put to dso__load_kcore"
Date: Tue,  4 Nov 2025 17:27:42 +0800
Message-ID: <20251104092740.108928-3-jingxian.li@shopee.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit e5de9ea7796e79f3cd082624f788cc3442bff2a8.

The patch introduced `map__zput(new_node->map)` in the kcore load
path, causing a segmentation fault when running `perf c2c report`.

The issue arises because `maps__merge_in` directly modifies and
inserts the caller's `new_map`, causing it to be freed prematurely
while still referenced by kmaps.

Later branchs (6.12, 6.15, 6.16) are not affected because they use
a different merge approach with a lazily sorted array, which avoids
modifying the original `new_map`.

Fixes: e5de9ea7796e ("perf dso: Add missed dso__put to dso__load_kcore")

Signed-off-by: jingxian.li <jingxian.li@shopee.com>
---
 tools/perf/util/symbol.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 4f0bbebcb6d6..ea24f21aafc3 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1366,7 +1366,6 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 				goto out_err;
 			}
 		}
-		map__zput(new_node->map);
 		free(new_node);
 	}
 
-- 
2.43.0


