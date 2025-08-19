Return-Path: <linux-kernel+bounces-775307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45C8B2BDAE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45632684ECC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38FB31AF0A;
	Tue, 19 Aug 2025 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vECM7eRe"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD9926C39B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596482; cv=none; b=HGpZnSvmRQyX52iG2IT1I1Gc+wYIpExaAkzTd3MApGfTNTRMu9mYNxetVneQskENyW6PvxOLZ7hWxgFe+JYrBmiAWeL6sJi4yrXrysRACMGyxE5XA0QcqBLiLz/wCe3HjBccs5a5Nch4LSYPRVOZF4dbgaIfXQoAEQM1EYn+QXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596482; c=relaxed/simple;
	bh=8OzrB53Bn5TxGHC664tdW+P0TA2+NR/DwiZkzjNkzZg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BI8KeM61nRCqqAE53piPGbeKsg9QDdk9mHOFLDZ0LJl6vqV7PuzmEyBQdixb7m0oLvcJo4P6s7KarrdLAmb+7Gb3eWxkTudlFK0oIMFSbMiGWHbmDYrOcKAfdBPA5mKe7X+hwO7nI+tDiiubRgKOMglp3aJpkbTVftjL2e8bkHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vECM7eRe; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b9edf504e6so2415963f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755596479; x=1756201279; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vKExw4rCJH6z3V+PveKbUj2X+7GksrW0bl8/wkUvABY=;
        b=vECM7eRed+zPnhTQQ6tRAwVWn5fTpl368Jau591Wr2fZij3Yr7XyNaVxSrPIjzKD5w
         U16QCwvxBZNdS3ZsHQ6cgPoyv9Bmlr3Ub4+W5BRNpGxEzumyL3Uj2nkzD51YcDGg0Lb7
         FK3qHQLqJ7VyCygn+ttLObvv+YOmIls+svsyHnG0bvIaNds/2ezTKyvyu8HOeG2Zi60U
         fuqEX/vstVyYMt+Qf0AfuqdeqwH7lyRoHhaZu3xtOiG0iVHqec9plpW5BLTs1IX3wXOD
         NK8c7/I/WvA9O0TvVPR//s1nf4R8Mv1FkLHOF4deJ6PHn6Xf+w37CJR6hGO+Wiwb3frb
         PJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596479; x=1756201279;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vKExw4rCJH6z3V+PveKbUj2X+7GksrW0bl8/wkUvABY=;
        b=YtmMrEO1YMLxIuTp7/1TvfK7w2rjnFmQA460nsWsNLv/xJ9tIXGFoAgyBlRRsomgbw
         UqVq+0AJPvPKIJte5NJvED7/ecBzJzETl9+Tqh2svTqQQ2gMhmP7vyMC+bSuquIvYUxl
         Sw9klsWi5fm9q67ih/SdLvOduS7epjioyFmUtls4KD9h/dvY7CcHPifTJAbZK9s0E1iz
         1K6sDJM3XT1pvAKM10CnRV2jSG6O/LdDk7dksk6UIqTaBsFHZa03dkLS3G5RyTjBh6tb
         Uwi1k9ZIIFZHRhDV6OP1oisG1rQvJHPHaPsB7gOxBy9KCUaKUZWu8v/7DcEwpCKPe2CX
         PGrg==
X-Forwarded-Encrypted: i=1; AJvYcCV6F+Jq3fJwYSly6xT0z1xCrKqUk3pOiVCuWGuejUyi4msMFlFrcloSzjfyKmTXT9E6+qnUbQRbkMNguFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyprQmfJIcPCaNpoVwBOUFjujgfTBI0CqkbiKXpkfg1GW6NKsg9
	93LbapZ3XvH9SmrrQqY7ruj/txV60AWeDJ00aTxZd3cag4o/EBirXt1/hNfH6iCTDP4=
X-Gm-Gg: ASbGnctUSBKVFofoPDItz3loVt89dSDek5RvOLDmcfYRuJHP9lzv8RlY9l7cxcR3rpb
	CxgqEqYsOPjIZ8OhOG0/1JMiOf5x68BU2IC5Fpj+NtqWH+X1PwwNtkcXWO/q6rVo8WDdlDnbKGE
	jq1WGfOjKoZ+n0Ch62ngh74FQKr5ZJjWKiv7yMrBtG9uSVwDuP1KPzRRj/Sg/YFY7Neb8fnAvW2
	hsaxhtEAf9FeKeW0KjPKVwBBtHw/RgmLEbzfSNLAIltks42eBcELhXLzh3hnZ/pZit32TXfIrM4
	SSgMVPQIoikJFFQYu9pvVsnxwO7gCHI0O9V7RsWpu5DLncQqzqmqO5rohmhAbEjTyRK8anZzNPL
	l6lew31ofVsR+vqS+WWRR4amktPI=
X-Google-Smtp-Source: AGHT+IFPnGBxUMbzp7/ciRb/4QDD/AoPuRkeVnisBhwmTgmtd+TF2XWKrPM0uJzG+Ht4NJS9oAj7Vw==
X-Received: by 2002:a05:6000:178b:b0:3b8:12a6:36b8 with SMTP id ffacd0b85a97d-3c0ec195bb7mr1400850f8f.46.1755596478926;
        Tue, 19 Aug 2025 02:41:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b42a97c02sm35092625e9.23.2025.08.19.02.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:41:18 -0700 (PDT)
Date: Tue, 19 Aug 2025 12:41:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] coredump: Fix return value in coredump_parse()
Message-ID: <aKRGu14w5vPSZLgv@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The coredump_parse() function is bool type.  It should return true on
success and false on failure.  The cn_printf() returns zero on success
or negative error codes.  This mismatch means that when "return err;"
here, it is treated as success instead of failure.  Change it to return
false instead.

Fixes: a5715af549b2 ("coredump: make coredump_parse() return bool")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/coredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index e5d9d6276990..f9d82ffc4b88 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -345,7 +345,7 @@ static bool coredump_parse(struct core_name *cn, struct coredump_params *cprm,
 				was_space = false;
 				err = cn_printf(cn, "%c", '\0');
 				if (err)
-					return err;
+					return false;
 				(*argv)[(*argc)++] = cn->used;
 			}
 		}
-- 
2.47.2


