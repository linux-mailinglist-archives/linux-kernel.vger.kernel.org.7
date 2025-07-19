Return-Path: <linux-kernel+bounces-737468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 712B1B0AD1F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 02:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61994E75AD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 00:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEE678F43;
	Sat, 19 Jul 2025 00:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ecLe+vCs"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0EF3FE4
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 00:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752886618; cv=none; b=u9VQpXmN2bskkdaV1ygf5wAgjyMAZNqvIaJnsf0QyjE3oYLQ5zOtl2TblZ+Z6w0PpiBjly1e7aH3Rm4rvp1qjw4N9eym1XhKCvbpMods0E5eQOKo3GR/bjN9yPVDAJqoj5j21Coc3VcCuAT/aadXYgd/PCRPi0PLIFFQ4k5jL9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752886618; c=relaxed/simple;
	bh=LXL2AkK+VyRY3vTppFqT51nHYGgVRU0InJp+JEjCc0g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qWRhzgosy1yVKFFFvvfHlDg6YBm0/h0HY4nNGeTxrgtcOf6VGttECbnagxksrXpXUoZ4E2azG359hqyleZmp/e38oVfIet/l6Uw90j7QmBPNBfsVubg4i03hzINh/QWJqM5MLsy8VxspDssDgHWqlroU9Dup2ny8ngI3dgQnfdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ecLe+vCs; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-70f862dbeaeso26666547b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752886615; x=1753491415; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tvjWKrqM3/pfyd3dDvfrPky1zMQRK0wQcAKw52KxzkY=;
        b=ecLe+vCsBFZd8G3bKXvy3n04v+g/OiUV9cIztdHmmG8uf6Ghf3RHBhIgS4TVDKLPVm
         a9nKgaqglQRnTMAOplbjTNmOcdIj3g3AuAn8BaDZR83i7t8+hidnfWKdso9syoltsb64
         9BCBQ6SGZxGWtkk0V5+o93hJ5TixvpsrQwcMWlRi+TmvrUkqj6q3xzSce5RyzqaylvDj
         Yh+HCL8tp4MEFpJv3R42WCu9NmjEfuJhc4mcXt0KOvf3I6yZ1Vv9fL1MZddrLtpTUpED
         GB397Eo1Y1qtFV93lU5JkjKWDkn+aaIi635m7HDuuwbV2B9zQHAnBln8u79dRiQa6R3l
         TrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752886615; x=1753491415;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tvjWKrqM3/pfyd3dDvfrPky1zMQRK0wQcAKw52KxzkY=;
        b=wYVl3EGwLR0Cz8Pt/DC3A8zRx9RwYrH+XsU9IrJG7CYW4pKR7+yx3jvnKTSIo4V037
         wy8QRvd+tXKfBnbBQfuSxZew/aSF5bnsqCfnfUfJXOvH7leIT9R4UPPpMYE9reOMEhcy
         8gFOG1eqxPHB2Azbwd/maRJjr8vMX1fOWYn8a09ud1f2SrvnLbtrHGl5itI5YkSF/G7w
         dEZU5b3U7kBkQ17DVf0RWsYa6racKD7ucwjVwo0VSXJtMeoVf9elyEVM6qatNj2sk68F
         Blqpgo/tmmvarES5XcW0HDHw9v4CLTewoB9dyYvEelFFBhhMq3VWm7O8OZvv5zoOnEkG
         C8jw==
X-Forwarded-Encrypted: i=1; AJvYcCXyi5dNPsvi0JEp4M+1qSpAemgzzY4EM4G0LTQm+UW0iYhA8P9qjmJj3LNKqARoSiwr77M3XXsqCu/Fui8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKNZjuR3cueC1Gi5457yUSmGqgwgLYssoWog7k8tP/qZpDCBZy
	BgejOTiRr7ZWcWVBRWWMYxSYoMZSnwjtSDnD/NZhrLOmuruVTu1S3W4j4r8m5od0XQ==
X-Gm-Gg: ASbGncuJVpCzziCmky4+Z5qQV2RnVlrBUW8nuiXH1IQ8R32/S6sQkLNrrfU/MAFnawr
	kHq+48rsLpTjmoooGb1QcxdGyhn9JOMiVPyiaBeDrMoM1St7tP8xm/82H7WF/k0oSpyijEn4AK3
	lMpu2A5O+G4JxuClObWBpXyZCwmXLNrrcjpY00gsvaCGGs4TrzVP+1oqbUW7mbaoorEBUXSbXvT
	jRJhMm1l9jYPyAPBpyRa3LSiWwOzo7xhJh9PWBZT/vCvAs5djDtUc91QIkO11JeweJwMj3zlzoc
	7+cunFUna/Hr9DdMTrRtdgl7Se3gt+Bbya0Z8Pg+/jgALjDDoNTece0/nWOo9AfwLjaR3xxwhPa
	Y3iFYY3+9oL3LMUplXVj0f5EqQlp22IOptu2KNxBs6eXBFQzbinefhtBIqT9pPnH/PClWE1ipd+
	njyl5z1Yg=
X-Google-Smtp-Source: AGHT+IH2S9GOEjq3DKZG3hMbJWt2FMSGD/zk2L7pcTc980Q7BT5Z0q0tVPU4LwF7uUMlTaIR1eTSxg==
X-Received: by 2002:a05:690c:39d:b0:70e:1821:a219 with SMTP id 00721157ae682-71837469b6dmr170590507b3.36.1752886615135;
        Fri, 18 Jul 2025 17:56:55 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71953139839sm6062007b3.30.2025.07.18.17.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 17:56:54 -0700 (PDT)
Date: Fri, 18 Jul 2025 17:56:52 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Hugh Dickins <hughd@google.com>, Baoquan He <bhe@redhat.com>, 
    Barry Song <21cnbao@gmail.com>, Chris Li <chrisl@kernel.org>, 
    David Rientjes <rientjes@google.com>, Kairui Song <ryncsn@gmail.com>, 
    Kemeng Shi <shikemeng@huaweicloud.com>, 
    Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: [PATCH mm-unstable] mm/shmem: writeout free swap if swap_writeout()
 reactivates fix
In-Reply-To: <853a5211-cdab-4bdf-b0c4-8092dd943ff5@linux.alibaba.com>
Message-ID: <101a7d89-290c-545d-8a6d-b1174ed8b1e5@google.com>
References: <87beaec6-a3b0-ce7a-c892-1e1e5bd57aa3@google.com> <5c911f7a-af7a-5029-1dd4-2e00b66d565c@google.com> <853a5211-cdab-4bdf-b0c4-8092dd943ff5@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Per Baolin: use shmem_recalc_inode() rather than open coding.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/shmem.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 5a7ce4c8bad6..927ccc4a6002 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1692,9 +1692,7 @@ int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
 				__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN);
 		/* Swap entry might be erased by racing shmem_free_swap() */
 		if (!error) {
-			spin_lock(&info->lock);
-			info->swapped -= nr_pages;
-			spin_unlock(&info->lock);
+			shmem_recalc_inode(inode, 0, -nr_pages);
 			swap_free_nr(folio->swap, nr_pages);
 		}
 
-- 
2.43.0

