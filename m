Return-Path: <linux-kernel+bounces-780554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFFFB303DF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B681CC528B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD4D3570D2;
	Thu, 21 Aug 2025 20:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FvhgezoK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E29B34F49A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806842; cv=none; b=FqjJsJSVjvUgoZxt4ThdmawJ4/p8TeZTk0fhu6t9nmpT5lonDI0PplL3BAagJQWpzpn7eZZPgx0tpYTuwKm7ROPfvjGKGlMsFYW0P50y2ybsFTuaf1NfHRFb/DOY/yhKJ2YS9mwHYj1TiESAoGbTPXlKyIdaZ8iOvXvGCQgUT9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806842; c=relaxed/simple;
	bh=rCgYuDQcQ3nJcWNFmOxD+pxeBEJSNoep86nFob2zhE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUKykHUzsZKEglcHzhr/tDmccZmVJZmPCGwd9HwWOos4RJy2oOb6ddw4dBHFWvqpBRB6g4/lIfh5BmjmFZZei4apkyDymlCh7AG4xASm9qN7TOvZhZRYv7rV84ELX9+i8oel6uDMHti3Fvn1zSRLj2FA3C59+z0oWgOO1APZSLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FvhgezoK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zfh98TqNQqR9uCNr2hB5bEgIJ/15ql7Yv0zNbj5EC/8=;
	b=FvhgezoKXHMUZ2BWrsd04lTIP8unxj540pU946NcJnJJuOAbNKVsaPENFIHuD6kkJBPSKP
	p0LfaqPL9e5jofDyReCvBx3Ju+COG6jcSU+9UKHLRmnaECy4UXAUOU1zvMDtILyXgF/jdB
	8mDdg99mU8xQvc0YJu02PswwzrZb9Vk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-CxDaqqFqPD6SWTyGnqTyJQ-1; Thu, 21 Aug 2025 16:07:17 -0400
X-MC-Unique: CxDaqqFqPD6SWTyGnqTyJQ-1
X-Mimecast-MFC-AGG-ID: CxDaqqFqPD6SWTyGnqTyJQ_1755806836
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b9edf41d07so651725f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806836; x=1756411636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zfh98TqNQqR9uCNr2hB5bEgIJ/15ql7Yv0zNbj5EC/8=;
        b=ELkRaJP2okJRueI82A+AUzjTtXHJf2tBBfe+2heWbN5oQMeD9Atckk7aCymmynRMs1
         zucot/IbvzmrvDzUYvt1vGQKCX4xhCZrNsbGmZSGGsdBgn5E9qLJ9BPC9QMWovC94JiK
         V8+1cZShezToIql8VTbHuggEFrCeEnHy/gNS20378v+97h7hkHd9gmFIZ4/x1gCqVRkT
         qC8fhX9hrPZTr3qghazHRJceuqkf4LKu3OisqiLVarxEcLiQjQu38+3fbRYql5FVLsI9
         ldSUNkglwgZcatAe5rXtAQydQyWQZaqGyUKjSslOyR0EWUu2SK1WfUBktHjy+ZdCxLEs
         wdIQ==
X-Gm-Message-State: AOJu0YwaPM7iwcYR2NEI6Xl67e/qyvqIWj2BImfZR5IUIhTBjWG5TyKo
	bCmfMQoxvWVgxQJEdv42oWUGHBXXYBDRAdT5JGdAifkz4DibcnDoxm2SzF34gp4rRvpXm+ULukM
	NklVwfb2JlWApNZlzvf9nYF3wBL49xHY7YAK5BNb5RXV3iBUpfBOzZZMZcg91IG1L740j85gbrh
	4ejwamPitQQbEGDroGySLGv6AVCCYzkoWvqdo+06sTQ9TBv+r8
X-Gm-Gg: ASbGncvaxs/BGl3uaU+DJZShjYsAJoePxtDL3Ivj+QHt8Fps39CSAzNQD3xiUlhbNgL
	Hckt+IrRK+IjDt216XEK5f9qHdNtNGv/X8NiPnvPIPGsOwBTYABpJHmZihBT9uT7e6pfLKs65Dk
	2smc2RXqqT3bXu/p+wFirYgEkw0kkbY586eEnQWIzfnFRblZ0InVKdof1bmf0j+r7wbCVxWLrHq
	9KZKj/Uh4ySGLixBr0FSPh+V/sfY5p9MAUJP01KHuhfXAmGKMXBQcQ/lopEPHbCvC7XJdSxlWym
	8m/osxlu8lHXumwsDFmZtEzWRtONjgKGKx3tOi3qeDcCcRu5X+WjHLZiZ9CEYgwLwNZOSfQdPcR
	SZ0Vcs09bqDZwQhO4ZcIsaA==
X-Received: by 2002:a05:6000:1445:b0:3a5:27ba:47c7 with SMTP id ffacd0b85a97d-3c5dcc0da36mr163019f8f.48.1755806836225;
        Thu, 21 Aug 2025 13:07:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpC+bUbLbCjHqucY3RiMYJPd72Xl9UYU3JmJwOiC1ZPXsKWXLLEiwWSHifO8HwGgrBWSbiEw==
X-Received: by 2002:a05:6000:1445:b0:3a5:27ba:47c7 with SMTP id ffacd0b85a97d-3c5dcc0da36mr162946f8f.48.1755806835650;
        Thu, 21 Aug 2025 13:07:15 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50dc00a8sm10958175e9.1.2025.08.21.13.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:15 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	kasan-dev@googlegroups.com,
	kvm@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com,
	x86@kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 03/35] s390/Kconfig: drop superfluous "select SPARSEMEM_VMEMMAP"
Date: Thu, 21 Aug 2025 22:06:29 +0200
Message-ID: <20250821200701.1329277-4-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821200701.1329277-1-david@redhat.com>
References: <20250821200701.1329277-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now handled by the core automatically once SPARSEMEM_VMEMMAP_ENABLE
is selected.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index bf680c26a33cf..145ca23c2fff6 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -710,7 +710,6 @@ menu "Memory setup"
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	select SPARSEMEM_VMEMMAP_ENABLE
-	select SPARSEMEM_VMEMMAP
 
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool y
-- 
2.50.1


