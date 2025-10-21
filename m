Return-Path: <linux-kernel+bounces-862943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2FBBF696D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D4D94F05FD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE90334371;
	Tue, 21 Oct 2025 12:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVwYabna"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738FD333457
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051580; cv=none; b=RpQzxO+bNX+/s3+yRituZVg5OtW0XkqdMP0XrugmZYL8e0ATGrTmH1d82tJOddSv+kcJ+XjIQ/N1u7UkJy5/HbUbEwj2qC+UANzA0GNNJu+6rxUAEtAt92Z1c7lGgttNF2ifSpU+zba39I71AS9Si1RtT9UkEBUlTkC9sq6ywsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051580; c=relaxed/simple;
	bh=uLM2aZ8rWOYNYhXo8M9ClKVdKdX3HbPbC0z5JcD2olA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGTV/B0InZg7vmh7RAs0CqGblGIlk2AXn33dzE0Dro8ZiUN4zKfAPaSIRulUld1giilrEPwh8j+w/I4s/521G6BGZuI3lbYUEU+D1j2x2+AMvZbRcLQ1dGmFFAUAqC+SkpE3r6lR9Lv9Ady5k128yTqi/boZyRZW3IU1HMlMRqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XVwYabna; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761051577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aJ8O3oI3PxPdSYdHMVP+xUJdXO9FbTcv+rg9gD/qHfE=;
	b=XVwYabnaErXgWIP7f1P8n3a9dhLltrX9jIdiL8gZDVYTPLZXfNzQC4tEhQb2cg7cTwZHE4
	RDkpCadSLE9JQFnb5CFuHeeYM7DAB+gA5tfBLxNVrdkDwFtuc5g8DYKseqBT6pmNknhFr8
	4RRM2z21FqS8RSUUc+d9OZctM0mifUQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-IO0DDB8TOi6vuPlPvVEEPw-1; Tue, 21 Oct 2025 08:59:36 -0400
X-MC-Unique: IO0DDB8TOi6vuPlPvVEEPw-1
X-Mimecast-MFC-AGG-ID: IO0DDB8TOi6vuPlPvVEEPw_1761051575
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-426d4f59cbcso3474047f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051575; x=1761656375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJ8O3oI3PxPdSYdHMVP+xUJdXO9FbTcv+rg9gD/qHfE=;
        b=U8Rgc+FgEjrZqQC0JZkTDTlUr9ZM52AR/bm7pZM+Auy+DARu4AhnL5Gv15XJNerhd2
         dFdf4HCmXiDA/TDhQduqLAF41/L9RwNs1xL9r1fUW2KB5jupQZRJc/RmMybIm+vTAS3H
         C+ubPHmYYkjYJUtK8AkApUQkAbjqdly/xUDfHjg10/HtbiuUz1pgu12i51J25uawRul+
         XHqq2mMLuZl57rgUPJcEzEMGBrzuNQcx+zvT0gIzBISWQBDlmgtuMao9NmwW3q8yO0pw
         K7G/WaDKrW4fYc3ajkAtw+MxTYFLz/EeRDb8gQKDRtneFcBiViWUvW7ryo03lVzTNT48
         vdJg==
X-Gm-Message-State: AOJu0YwHJwlH4l8WYKOcdjXmhjgCHRm9VVP9us1bYn4ThFl3vs7Mbg26
	PPpbrvNio8wcTySGiMDkL5bmNd8RJEk6VIYfIjLfbElWU5PF87BN0fVY/m8ctcCzK87dvfbxIl6
	LlsYEeUvV29r07S0pmdfLMj6Qnj1sa02XinCua8z883gmAItzhz8Io0XW8vidjym/CuNnwKftIv
	I6wpVkWCbB92xG3cMn535TKuZOYl9v6PwHMIHZRIoBrHsoKw==
X-Gm-Gg: ASbGncvTg3rlIxbpUqY7PkPxYDGdbCyTDyXBhCGPXEFmhrpEcznPjdqUZ3k7O6Tfy6C
	zZUGIEuD757I5XjLCDofd6j4QMkVG6gDg35cjh1gYqLm9cqxFWWx6qe6tPxl9Iob/ikkTWcthxk
	Ykz3vzsmv7rtynXa3RxvgZRAi5GvYMhRpP+iJTKwWUPwpcvoPsRbAl093NHrkAn936duaM3qtzE
	6QltMyvF3aDNtXNj3fkhPb0hid6zGyecgCPOypUlyvLHa1vWL49SZYJfneAMqA2GkqgKwyxtWld
	vtz9TeES1wg7Z5Exyqj2v4Ot31d1iSumzXYDeK2233mQM2B3Co7Yuj4Vyaad/badgBdXwWOxKYg
	gyDl0VsPbTXd69qaJ0+mV49iQTo5STWXnADnJQ6CzO9mygvCQMDpCizl1PpoN
X-Received: by 2002:a05:6000:2287:b0:425:7e33:b4a9 with SMTP id ffacd0b85a97d-42704a62705mr14069870f8f.0.1761051574863;
        Tue, 21 Oct 2025 05:59:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECa0A/SeCpIiHVmJluGV/YpnUcjGB4T+0tmg/6h2iDdcNEnR83hKR+rxH2jY97xv4J3P/Z8A==
X-Received: by 2002:a05:6000:2287:b0:425:7e33:b4a9 with SMTP id ffacd0b85a97d-42704a62705mr14069824f8f.0.1761051574412;
        Tue, 21 Oct 2025 05:59:34 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f00ba01bsm19979250f8f.41.2025.10.21.05.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 05:59:33 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v1 01/23] vmw_balloon: adjust BALLOON_DEFLATE when deflating while migrating
Date: Tue, 21 Oct 2025 14:59:06 +0200
Message-ID: <20251021125929.377194-2-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021125929.377194-1-david@redhat.com>
References: <20251021125929.377194-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we're effectively deflating the balloon while migrating a page
because inflating the new page failed, we're not adjusting
BALLOON_DEFLATE.

Let's do that. This is a preparation for factoring out this handling to
the core code, making it work in a similar way first.

As this (deflating while migrating because of inflation error) is a
corner case that I don't really expect to happen in practice
and the stats are not that crucial, this likely doesn't classify as a fix.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/misc/vmw_balloon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index cc1d18b3df5ca..2cc34c4968fac 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1818,6 +1818,8 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
 	if (status == VMW_BALLOON_SUCCESS) {
 		balloon_page_insert(&b->b_dev_info, newpage);
 		__count_vm_event(BALLOON_MIGRATE);
+	} else {
+		__count_vm_event(BALLOON_DEFLATE);
 	}
 
 	/*
-- 
2.51.0


