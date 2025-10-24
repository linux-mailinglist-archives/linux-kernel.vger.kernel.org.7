Return-Path: <linux-kernel+bounces-868752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06736C0607C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BACA3B2301
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D314319877;
	Fri, 24 Oct 2025 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ezi7LHkl"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B404A319859
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761305168; cv=none; b=WYlUjdtHKR/jBQUSZZKxfVl8Gc7XpOELkTEpCaSegVYL6XxXX3K4ckuUAHc6b5FypNt4a+O6cngaR1hUtXjXYCGrrky78ZAgqCedb0G67VX/1OavPJlE2vnvsHbUzQ5TUt+yL64PgmBzmQF7OV3yOtyZH4nBW7W0PnDobomKAIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761305168; c=relaxed/simple;
	bh=esg5jJJrldcsg4Eme/FaVfbzYkFZVxjJszNLHkfgbVk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iK2oq3i1nFwbU4hlpXpd2TfyEaNaqA6rOJ09RsTxfdZ4IlK9sE62xv0KWFNYi77UY6yw7I7FqJOIFEvXAG7rXGUyYHvfLElh+aKqBEhsnwpdUl78b6S9zvHBduPF00Tj2L5CRJ0ymmab61okg3hXiz+w9th4grXYLY+xQkhTgcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ezi7LHkl; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-426fc536b5dso1401253f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761305164; x=1761909964; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6njyGgpXnyix7DPfE/AD+aT34+lBZHSBxI3vVRiYPz8=;
        b=Ezi7LHkld+Fd+HKJpLzOTKg6zBAv0QMXQ4MXOI1l4E9esahPRkUMItjQxUERJIc0lj
         3OD+qRvb6/A8DhWoH4jvCVBPUxdBK9WT9SsulZDnUliZ9itQrXYctx7J62TZTdnx9qkj
         yjmnpweYlZ9M48MNFFPoiY1ZOpu+bwyA1sry0G9R3ViEW21+x4wSnU20gGXfQM7bBnnS
         6E+P2EYaGmt7JhuaSxiGOLXt+EvPkgf0R8TuJPkcoVX/c7d1Nn/G/ZLMWuRXHwaCgwUU
         CaC0FELIc8krMLoB6/DPhIka/JysSnHD2/ozw6g6LucvxyAzv7dk3BBbJO3BgdJcC0aA
         J3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761305164; x=1761909964;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6njyGgpXnyix7DPfE/AD+aT34+lBZHSBxI3vVRiYPz8=;
        b=nJCFjiEbiYutsQDP23EdKZUZFnMiU5Tab40GFSwHstOiOedESXEcxtKBWf1A2BQ2Aq
         7AThtr7kHB94DwlcmhW9zHPQbmG8UOdsh/p0nd7dV70UXNQIE6a7Sw6R8erN7fZbKk4R
         D5OrRhxs76/OE2wQRNfOPB2FSxBL77m1H9f5FOHHmGuupBdR4/Qck/alNmPTACDNIIap
         v3Jd1Oz5X7W/XGdL8egI3GTku0ObpRzkINvgwWB7TYEqQMVubXJOiU/VSQcBU4pW6CM3
         SX+tMXWG5NUVk4WxQPbVYPkfrqjPQ+vVB/rsKfNJkbU3EwiegOEU6hXc94uVVioknjcX
         H11A==
X-Forwarded-Encrypted: i=1; AJvYcCWBUgnmuwtdWKEvpTabGCcceNS4SL1+1pgbtFUjnbmC0ezlTv24GlC28S9KbboUSQlJS1BMH8qd6AdihG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLXluyXr4bN7LmASiF/G3kSuQ9xrigMppNJ2YOpXWqwHHee1nU
	Y5iIU9A+UAgBh9F2S2yJHJ+tjzjp2aZElJOkRfZ5z/vgrmt+r2Mpjxs3h4/ZZQLC2us=
X-Gm-Gg: ASbGnctdhnIslRTkF64ARZ6ffGI29DpRxAsZNP8w2AoRXvDyej9Le7M1KXiZov7TjqW
	mQjRZVy9nFNCU7rmx69VkJl/IUW8WJSgeB06B55Ym7vlIretHFg32VN5N6YESCzkZDabirNAc4c
	9QYXTFmshJ8MoMsFm2j5XnShLc1qxg8xK4GwZld2CwB7V1enwiMyZxF7XZv5DY0NULfe6iqGAHh
	khmGbPSMLmLiQXiozgeQyl47plawLy35qwxTdfE5Gwhg6C09UlU/vWFuqgrnZ91Cnf1yfDMcJcI
	l4DgCkxNhgyqsO6ucLKpuLzmnVEAe80VctINSmTP9o4i+1blixEC9L+TG+jqNnCP9hFmTNTLN50
	g/p8OxbOO3evix9m2fOHTQKWSv0sFKnBXneCwKxWoAiguThEx1SuPhW/BXSlR/77x+++PYuXYiJ
	e5lfSYPw==
X-Google-Smtp-Source: AGHT+IHTMdM53JxT5mbRrB/df/8148lrYpgmBufghOqk/tj4eesUFtAgikytzGYIeyYeUAUMaIogTA==
X-Received: by 2002:a5d:5d87:0:b0:3ec:8c8:7b79 with SMTP id ffacd0b85a97d-4299075d0d3mr1809575f8f.61.1761305163789;
        Fri, 24 Oct 2025 04:26:03 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4298d4a49ffsm4962650f8f.13.2025.10.24.04.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 04:26:03 -0700 (PDT)
Date: Fri, 24 Oct 2025 14:26:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>
Cc: Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] fs/9p: delete unnnecessary condition
Message-ID: <aPtiSJl8EwSfVvqN@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

We already know that "retval" is negative, so there is no need to check
again.  Also the statement is not indented far enough.  Delete it.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/9p/vfs_dentry.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index c1acbc98465d..c5bf74d547e8 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -109,7 +109,6 @@ static int __v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 			p9_debug(P9_DEBUG_VFS,
 				"refresh inode: dentry = %pd (%p), got error %pe\n",
 				dentry, dentry, ERR_PTR(retval));
-		if (retval < 0)
 			return retval;
 		}
 	}
-- 
2.51.0


