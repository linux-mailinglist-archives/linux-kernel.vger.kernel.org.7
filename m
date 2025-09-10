Return-Path: <linux-kernel+bounces-809825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8DCB51281
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF12B1C219B9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CD730596B;
	Wed, 10 Sep 2025 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b71AZ6bt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771612417C3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757496659; cv=none; b=L2pShdoLXV+J5B/QnfjRGgOkGLgCe6hFpCh+rFN+D7kGeFLT8w/5mQh+P4b4EI+E70dwmGnS6NLtnaJouj8g9Nz4gOg/W3/5wVm2rFuIHk8sfKaaVuqjRK8N/nw4txc5f1f8jvVwXhjx0/nyU/BE1WzqMBcbMBHoa1bzqKiAB2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757496659; c=relaxed/simple;
	bh=a21Cu+J0U06Xk6062QwlPqOlBDs91JVnwm8k0OIr77g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HVu0YC1G1T6dCf4XXYvMkWhp8mt08Hvwfwc8z69o/OwOnMBNAVF2VDAZLmEckFCtn8HZK/8SIBU750L3n5sayhi+v4QXpKgE2ky82NZWt1Uyxx+U8ORYanLjSZjzBZmHmLIb9hGDFh5FYdMXuwQ/ayF9RlJfflpaiXDv3b6WocI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b71AZ6bt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757496656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2qzBA9zUbwBtQk09XBYRmyAB+zZC5CxWhnXgvnYd3No=;
	b=b71AZ6btBzU5G/vro5L9zD41LROOiFpW1X87rVTJdSxvhM4v1NWC7PoHBO2jTfXfU1OTnK
	hKYfaFBHbfPXShzHpqGcigzVDY1NSAZ01RIcdOh7jL6CBftwaomFH0nH+OEes2DaC/38Pj
	e7QZYWbaDY2eWuOSTdUsfsp3e0SVHAs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-emuWtDjoM0adJFIChP0qJg-1; Wed, 10 Sep 2025 05:30:55 -0400
X-MC-Unique: emuWtDjoM0adJFIChP0qJg-1
X-Mimecast-MFC-AGG-ID: emuWtDjoM0adJFIChP0qJg_1757496654
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3dc3f943e6eso4076014f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757496654; x=1758101454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2qzBA9zUbwBtQk09XBYRmyAB+zZC5CxWhnXgvnYd3No=;
        b=OW7x3CVz8NOIzY/AjOW58kcfYJa8OiWW2lRRRpJdhJoTQmHsNBZizgHv67CPYvARiy
         Ihr/BMs1sUnhVvjZmamlb97kATL92X/1vNR62EvvmFDhEDQKxoK9ams4uzn6AcI+mu6g
         LKqzFqAorJsIJ1JJoIM7JN58nh1o+F2gqII+7nuj/ReoLRCEUj3erV2T+zu86we8mJbC
         MIe3kldTnr+hu8/6HTW+HAYVOnVDUgpo5qI7P6NN8v0cRWjQE5TaffyKNwquxT0xsouk
         EctNOsMD+HfoiQNXNYsnGQ7/3Btn3WZQZPfPVWgdVZLrSMwluVX0uJeHnO2xLm7eyHjI
         KHwQ==
X-Gm-Message-State: AOJu0Yw47/xLyMqnDMHsPUcaCYhd6SqLWSRP/bPZc/cwnkgBcFxzEp/S
	uHf3Mke2F+HGBmsopJcxwxHlVfIc7gHHuIFTvCb3ED4erHNGU2OE1fnAr4UCtCZ19SYxPPDUppc
	N4KhH3/zcmIS44KOeQ5fyveBef5na1+HeKfDk3bORBX2vmflPm/fEUl1t1/BtKrJywL74HQwIpx
	Lv5dNZrTLENAImp5axsP66gELOGrfMC7ILeLQKy7MLK6Asqw==
X-Gm-Gg: ASbGncsv+E4tCjnpIK9ltl16CJXukWGBGVOWMiNqdWgCMFFJjgBXOkq3V+o7x7GTVrS
	eCmUTJlQKF58skMREtPfKIrT/Zc9v5YdDygPpmo3ARg3gXbS/9wLjly8eaVuZJdRl+AOkpoU6hX
	B0nV+D00DKiwjUVnYAKLaN5ORqQ6boMMZJq0nzDwzpZRmPxcQsk4wgRZQs90zUZfY80StX06DqG
	1Rzf/CNc2ZWaq0DIRJ9k672irGpktGwHoeEtf62+7vlkxp46kS6o8HXS2APKUaF79f5A5IigWp8
	7b3CZ4cCTbj8nL+rpzClo/oW0oQb3RpmIUo49YDC/wBBxWRo5slykvqlSbPuM2xV2/u/JgrSsB1
	HsYJWnEpHdFokroj3ImTDX/FN
X-Received: by 2002:adf:e611:0:b0:3e7:42aa:1b3 with SMTP id ffacd0b85a97d-3e742aa0327mr9054286f8f.27.1757496654013;
        Wed, 10 Sep 2025 02:30:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEi3IitV0wCKvn7oRCPMLTVb77zHfNWhPGpq1wNihRoL3dQO3S5kiGmSFpyN3gxcJUcHXYIQ==
X-Received: by 2002:adf:e611:0:b0:3e7:42aa:1b3 with SMTP id ffacd0b85a97d-3e742aa0327mr9054232f8f.27.1757496653393;
        Wed, 10 Sep 2025 02:30:53 -0700 (PDT)
Received: from localhost (p200300d82f179c00d650ab5f74c22175.dip0.t-ipconnect.de. [2003:d8:2f17:9c00:d650:ab5f:74c2:2175])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45df8247bdesm20861465e9.14.2025.09.10.02.30.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 02:30:52 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH v1] selftests/mm: gup_tests: option to GUP all pages in a single call
Date: Wed, 10 Sep 2025 11:30:51 +0200
Message-ID: <20250910093051.1693097-1-david@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We recently missed detecting an issue during early testing because
the default (!all) tests would not trigger it and even when running
"all" tests it only would happen sometimes because of races.

So let's allow for an easy way to specify "GUP all pages in a single
call", extend the test matrix and extend our default (!all) tests.

By GUP'ing all pages in a single call, with the default size of 128MiB
we'll cover multiple leaf page tables / PMDs on architectures with sane
THP sizes.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/mm/gup_test.c     | 2 ++
 tools/testing/selftests/mm/run_vmtests.sh | 8 +++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/gup_test.c b/tools/testing/selftests/mm/gup_test.c
index bdeaac67ff9aa..8900b840c17a7 100644
--- a/tools/testing/selftests/mm/gup_test.c
+++ b/tools/testing/selftests/mm/gup_test.c
@@ -139,6 +139,8 @@ int main(int argc, char **argv)
 			break;
 		case 'n':
 			nr_pages = atoi(optarg);
+			if (nr_pages < 0)
+				nr_pages = size / psize();
 			break;
 		case 't':
 			thp = 1;
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 9e88cc25b9df2..6240e579b3ba5 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -138,7 +138,7 @@ run_gup_matrix() {
                     # -n: How many pages to fetch together?  512 is special
                     # because it's default thp size (or 2M on x86), 123 to
                     # just test partial gup when hit a huge in whatever form
-                    for num in "-n 1" "-n 512" "-n 123"; do
+                    for num in "-n 1" "-n 512" "-n 123" "-n -1"; do
                         CATEGORY="gup_test" run_test ./gup_test \
                                 $huge $test_cmd $write $share $num
                     done
@@ -313,9 +313,11 @@ if $RUN_ALL; then
     run_gup_matrix
 else
     # get_user_pages_fast() benchmark
-    CATEGORY="gup_test" run_test ./gup_test -u
+    CATEGORY="gup_test" run_test ./gup_test -u -n 1
+    CATEGORY="gup_test" run_test ./gup_test -u -n -1
     # pin_user_pages_fast() benchmark
-    CATEGORY="gup_test" run_test ./gup_test -a
+    CATEGORY="gup_test" run_test ./gup_test -a -n 1
+    CATEGORY="gup_test" run_test ./gup_test -a -n -1
 fi
 # Dump pages 0, 19, and 4096, using pin_user_pages:
 CATEGORY="gup_test" run_test ./gup_test -ct -F 0x1 0 19 0x1000
-- 
2.50.1


