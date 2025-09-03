Return-Path: <linux-kernel+bounces-797820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7844CB415C0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45BEF4E150E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D9A2D94AD;
	Wed,  3 Sep 2025 07:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4X/3Ewf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514621F92E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756882981; cv=none; b=ErBu//ah6TUTaaWyt0Dt72mwlunK1zv9Y3wtka4KQe3I8P9u67LQoX0w2XG/J7KS9+42Bi7PkqG1JtznuyIfB/8B8FqRqW2NKuaptxOyRPyRXOeo4cgjzR1P0rMX84PuL6JQVVq8aGFflq3e80qvx6z9kl8DRrtpuTw4PSbLPiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756882981; c=relaxed/simple;
	bh=TqFzKWeRTZdCm/cvkUCA7aEx7pP5X8qJ7Iyq2g/ihz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g2dC6LwJVPIJ8etaWaJPwS+UKEExDP6nuHwQ1jNBcswzYEuoIJLVDFg1OHsRWoGyu1FSzky3GscWYFYJ0g379d49KyVxAZBsUrG+U+cdppUL1au0tf40YRSa4LfrvVl4oKlFslPP6c4eKIhUtlpjKPGjNtn9cKwcHVz1lIEydqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b4X/3Ewf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756882978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Nc4ZGDL32vdkqTp2UxmErkTt7s51BsabNhqnOcOJ0vQ=;
	b=b4X/3EwfnI7PcI1DCcjsIEVmeMCeUpGJHRvBKEVqD38c5ACUcNWeBRShdgnlpviLQUDhV/
	RfF+/nhH25fBBDDqVkmqZm1z8PxvYlggans1B7oMGpJyuWgJXllqRV8yuV8QxyA8NnumTc
	tkWoCoBMej7aX5V/Z78VZwwmBQfwxrQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-AjB5zGT2O76Rh3tNTrj8yA-1; Wed, 03 Sep 2025 03:02:57 -0400
X-MC-Unique: AjB5zGT2O76Rh3tNTrj8yA-1
X-Mimecast-MFC-AGG-ID: AjB5zGT2O76Rh3tNTrj8yA_1756882976
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45cb604427fso1036915e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 00:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756882976; x=1757487776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nc4ZGDL32vdkqTp2UxmErkTt7s51BsabNhqnOcOJ0vQ=;
        b=w8/teu4x1VH+bWd6+eTpxpJIllKuMpvBhiQA4I0YL+7OPJK0TzRO92m1+WjXAncEtp
         70n04x4CMBGCOTivWbnKqOfduT2njNgd0//fiyM9ic4iLm1EVNh0iB24FbLlWleGPd5M
         dM+SUBaNefPLUWjB9eu3NsRAt3Bc1crurdQ1aECeViOBGo2tNuoZ5owPdeZN2F8hgEDF
         RkEvHqYVMsMAnti4q6B3i5oZdb0MqH2IGf12NC8DRJ90PoKkuqdFxuzbbrFIgbpurHXQ
         WJo9FmGQgGNshhPP9bINoidU3SChZGakffLk7yqwDEbS+BPjZ88zw9kQ0Jwyzz0vUTfv
         fsLw==
X-Gm-Message-State: AOJu0YxCtz0y99ZT8wzpMxOPQ4at/WCgoIPge8Eboa33uYcPzq6WckFn
	IyokiXTMH5yfmrhbGzB5a/0OLTtQGVz+vLFdG7BdYz0z70UcQDHL4wQADRm6EEcNmegtwCAlZ6Y
	W37isdvAF89oVcU01Fl0IS1bjUu7ERI7y1qNobmbE1nWymCNBWZiKDz72S7PnmwnEMsoIzoCAjR
	dqEeUnnbb7Ieg8/76yJdB9871XWc2aQtYQx6GUi358JCWQfg==
X-Gm-Gg: ASbGncv2Bl3zu1Gyf5piSo/JvTyX09iTaJbiD44h9dXATSjz3YxkN/t/kiPFrIK0Yz5
	Rm0ro3+9WmonuY62Ev7zsPi+he2dp3LWbc83atjmMXZbe+pNaP+RSrgviudMQ0PUh/iWhcze2dP
	UnktirKNjLgQq1m4d5K/hjJrYDvC4gDj46BmsE34pM5SDYgjByHtp7cjmjRSjdnOGO3k/+sPVSG
	FeMtmOr9ZRbBYznPuDHsiKpsq4FaExHatuoeoqYcCt8s10Y300dzstwN5YCca1JBZimj4GpGjhr
	mFCq1CPrdrz82W5LQL5GBO3wmOgQrD0XsIniGLWQm2DwKL9ULSe9bGe3EkkVldXo3A8tNgk4dFN
	Eb9hGsqsYMI5byGCAjlFG/gZs
X-Received: by 2002:a05:600c:35c8:b0:45b:8939:8b1c with SMTP id 5b1f17b1804b1-45b89398f5emr91180715e9.27.1756882975857;
        Wed, 03 Sep 2025 00:02:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/9mgihyp4H/Sd6HpN2hGIHH2BAgbt8Nw3A35djnCsNu46HxzvDh72AIsbnyyE/AU8sxs5IQ==
X-Received: by 2002:a05:600c:35c8:b0:45b:8939:8b1c with SMTP id 5b1f17b1804b1-45b89398f5emr91180285e9.27.1756882975345;
        Wed, 03 Sep 2025 00:02:55 -0700 (PDT)
Received: from localhost (p200300d82f099c0081732a94640ddd31.dip0.t-ipconnect.de. [2003:d8:2f09:9c00:8173:2a94:640d:dd31])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b7e8ab093sm237018805e9.22.2025.09.03.00.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 00:02:54 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v2 0/2] selftests/mm: split_huge_page_test: split_pte_mapped_thp improvements
Date: Wed,  3 Sep 2025 09:02:51 +0200
Message-ID: <20250903070253.34556-1-david@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One fix for occasional failures I found while testing and a bunch of
cleanups that should make that test easier to digest.

Tested on x86-64, the test seems to reliably pass.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>

--

Mostly a resend, because I accidentally disabled "ccover = true" in my
git config so people were only CCed on the cover letter.

v1 -> v2:
* "selftests/mm: split_huge_page_test: fix occasional is_backed_by_folio()
  wrong results"
 -> Fixup missing ")" in patch description

David Hildenbrand (2):
  selftests/mm: split_huge_page_test: fix occasional
    is_backed_by_folio() wrong results
  selftests/mm: split_huge_page_test: cleanups for split_pte_mapped_thp
    test

 .../selftests/mm/split_huge_page_test.c       | 138 ++++++++++--------
 1 file changed, 81 insertions(+), 57 deletions(-)


base-commit: ef42a39c44ef6da64ae3495d27e28dd6fca62a51
-- 
2.50.1


