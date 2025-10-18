Return-Path: <linux-kernel+bounces-859257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 264FBBED266
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC8C54E74E5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 15:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F09227E82;
	Sat, 18 Oct 2025 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BXU+rz6r"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313A019D07A
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760800686; cv=none; b=lrmC+hx+g+KEG98pN7Zdw3nYzFh9IhQoJGflPlLubf5BapkZu/6VJ8Fc8/PZ/sPSf1FoE+3NTcFpgGtpBp3rBjnB2aDiR3GHmv2LpcP7bAjaeek4aN0OgV/w0AZG9fF7kfPGYCXQTWYRYepJ8RbW3zHPPFB7Ige0cGXrUVp39h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760800686; c=relaxed/simple;
	bh=JhyO9XvNDW+35nBiw4rGks4IugYKd7xQ0UiDyIaZ/c8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mmA9jqZAn03bNcPuqLE/1zEAKxj5xjvAFLCPlNFRN+8kYLpG7t2beZv0BTXjrpPSMEs1Z7HS+IDLWxzjpgQLdsSZ0wLfDsh1EGgT3vj7DXjx/3zNSEBLKJLbq9LAf3jPguKRo0xNfNcqcKi6Lpd1M3jtvmHstttJs+nQLNAkRvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=BXU+rz6r; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b456d2dc440so458456266b.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 08:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1760800682; x=1761405482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tBEUnZekJ5PrNAba7jx8QPCcLmqbNQY6xjID2I+xCI=;
        b=BXU+rz6rN9cmkwHCf4jx6DBYv9HsLnOkhu5zOrzYYO13Vhs1K3lulsmIxUpkyaEeE8
         FXaFo9BEPOZxmjcDcQcWrKEwCOXrQPR2Idl1xnaFW/RWp52oEeX6/RkRZ1EhBlwmFIx4
         MkjLz8KEO4mGSs4Hdy1GyTmL15l9ubSYjvz4mj3u/bP2XuPCBj5iNtI0HUZf5mmzaL6o
         k1PSuBqK9TnIA4A5xFUm6XeaCAeUly5L0Fml4fTLWWJ02ZwO3bs06pe6WdblVJaCI4ek
         cQM2B4Of+Aatyszz8zSDKnU2SnmjEbae5jSqQepxpKqmGbuoZ2chWmQU/rZ9UpkSvy2U
         MyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760800682; x=1761405482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7tBEUnZekJ5PrNAba7jx8QPCcLmqbNQY6xjID2I+xCI=;
        b=H8JXh/zlzBOoC8Qaevl2hLeKoa8Tdgtb9sDVwiWsm9CiqkU23BG5M2sJc3qYr9iGV7
         FLcR4X3TfaJ9ROH4iIe1RbevnVy2cmCYoM2e7wsIix0Av3kN/wx+SP0sHiiJOhKQjo+Z
         T34phvKrXqIQq49xXV9vvUbtrW36jyVD1Az97AGiltr33Ni7Ux04chgODhDYR0XbudOR
         hOjsQDWR2Ry7OyH4rOO4FVbSucb2lz5UIUcJC0FunqHyaq3IsKRov6PauQQgKw5WItPr
         DsydzHUsuaazGzVTt+/dVcdMm7djZ/iz94nYHsNvnUPUq+b4GeTgFP3DjhXXKEEUpVI4
         1ntQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2iQ15Ph4Eahmo/GSFJOZLjBzCmkbvNgfOrRNBTwWAqD5vB7AjE7Qo4TB/DHlD9HTVCT3ZqJiH6cG1J8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHPM2eZyXspXHe0xuq4O/ER1kx9oxBWNDvsBffIjsGzMzqucSd
	C7wpTJW4Z4t8ioIMznkdBwKIf0yvrpJLv0VslhtndcT4bMtx8JGbsSgx
X-Gm-Gg: ASbGncto+NrcfhwUmMiJvQrdUwAs6czeE94svtGW2IbkL9ORbDg/KXhC1kTPfBt1dk+
	ggNjnv7kjWTGJTH1iWudzVknA+9Xk9Og7gYFI8HZuyuhuY6+CLe5mO+WDU7Z9AGfz52RX5B88aZ
	aOfHMeOjL98kNvwMYxmJ+24BKdEEPoKgml4Wnh3+6PyysaVQO+yRuYnz5i4Igp17yAqwleb3FHR
	8dy80FR96eRvt5Pt7mKbIgRQEEOSf5xWCSUMRX72Iv3L3H6dz1y8h1Wi7KiPW1FT0TjCXCeQB0P
	SujMnqNWflf+0EGeRVzcJJM2RuWeXUcrT4JGXje2t5HiSk2qzgL42vWAki5AVDB2AHIU6fwSe5f
	ClQBqaNPu3JHqC/Spo0lHSNJXXcBOppwKb0YRRL8sK9riZOE/Rh++xNewX+h7KPE1/dxOEvP4ZT
	WIQ9zWXs9BSTDKt4fSDYn9QdPWGentaqov/MSSX6KnygDJXft+KpVhaby5zXJFNpXjZd5i9lrEN
	Q==
X-Google-Smtp-Source: AGHT+IFubBcvDe/p5FEnyUxV3Cks6QoQioHs5yaIMVYObE6b3U3QQzbJ5CaDHU8R8IMyAEZnxXnS+g==
X-Received: by 2002:a17:907:86a2:b0:b41:2209:d35d with SMTP id a640c23a62f3a-b6472b5f887mr740065766b.1.1760800682144;
        Sat, 18 Oct 2025 08:18:02 -0700 (PDT)
Received: from tycho (p200300c1c7311b00ba8584fffebf2b17.dip0.t-ipconnect.de. [2003:c1:c731:1b00:ba85:84ff:febf:2b17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb036846sm259983366b.54.2025.10.18.08.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 08:18:01 -0700 (PDT)
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
From: Zahari Doychev <zahari.doychev@linux.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	ast@fiberby.net,
	matttbe@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	zahari.doychev@linux.com
Subject: [PATCH 2/4] tools: ynl: zero-initialize struct ynl_sock memory
Date: Sat, 18 Oct 2025 17:17:35 +0200
Message-ID: <20251018151737.365485-3-zahari.doychev@linux.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018151737.365485-1-zahari.doychev@linux.com>
References: <20251018151737.365485-1-zahari.doychev@linux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory belonging to tx_buf and rx_buf in ynl_sock is not
initialized after allocation. This commit ensures the entire
allocated memory is set to zero.

When asan is enabled, uninitialized bytes may contain poison values.
This can cause failures e.g. when doing ynl_attr_put_str then poisoned
bytes appear after the null terminator. As a result, tc filter addition
may fail.

Signed-off-by: Zahari Doychev <zahari.doychev@linux.com>
---
 tools/net/ynl/lib/ynl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index 2bcd781111d7..16a4815d6a49 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -744,7 +744,7 @@ ynl_sock_create(const struct ynl_family *yf, struct ynl_error *yse)
 	ys = malloc(sizeof(*ys) + 2 * YNL_SOCKET_BUFFER_SIZE);
 	if (!ys)
 		return NULL;
-	memset(ys, 0, sizeof(*ys));
+	memset(ys, 0, sizeof(*ys) + 2 * YNL_SOCKET_BUFFER_SIZE);
 
 	ys->family = yf;
 	ys->tx_buf = &ys->raw_buf[0];
-- 
2.51.0


