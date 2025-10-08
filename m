Return-Path: <linux-kernel+bounces-845930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0367BC6849
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 21:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884253A86A8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 19:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186B52773E4;
	Wed,  8 Oct 2025 19:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0yVrD7w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBDE277013
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 19:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759953579; cv=none; b=BP3rvG8IUJQnL0fLkpy2fTAEHXsG+RgBpyEqy7aXadOpycAf1Yv6TNRhPs0CAwXihXyYdmPWIH9+GMj4ghnAZ1kLpyAjVcDXgLos72D2sETGU/dQLMHifT1FDXropac5yVLSW4rpmtHVp+aZwb2Lz9FYQfI6Jk7kKcsFJ8RZvOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759953579; c=relaxed/simple;
	bh=lnrEKzHOYdxbMxx9t78Bx8tEtDr03iuoV0ODUkIlfkY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=up43P65OYG/v19u9q8Kh3pJDwhV3Ypga8+FtIdxwPdVhThg36BOhWWgJ3L8vxrQLusoyLQYdJ1f4U+4zms58/8Caby7BMwEb4IHKIEcSyfacdo7vAybyObOOme0hNSEJ7Dq2iCdw9TlYmU/fXBtS9vktWwOOkJsSO4A4Y7m8cE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z0yVrD7w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759953577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5vmiHk+8zHsqmOPIZRro69RF9ZYYZvm6wLS2qBi/vW0=;
	b=Z0yVrD7wiULtv/GyE7TsXxmmHjByXqhU40SiPBAUpIgYyxnm3mjRD2I4BwAue4gKHBI0Ct
	z95ce2Bz0tubJk2ohWY30nmsgaWY6jnlEes+/XaOEeg9zOwG0CJotP02v/mhrgl0KHMZAX
	M9F6tfL86nWzGsYoMDyJUiDyx0CZtkw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-tS6-sqjCNX-PKVYeVXOCtQ-1; Wed, 08 Oct 2025 15:59:35 -0400
X-MC-Unique: tS6-sqjCNX-PKVYeVXOCtQ-1
X-Mimecast-MFC-AGG-ID: tS6-sqjCNX-PKVYeVXOCtQ_1759953575
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ee10a24246so544819f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759953574; x=1760558374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5vmiHk+8zHsqmOPIZRro69RF9ZYYZvm6wLS2qBi/vW0=;
        b=ONoKV/tLUORQDqAx1sEBYE/Xsms4PDMT0WE61kZJun5wkBolHE9RdvcBJOQE5zJe7o
         s7L1f8JpINTMfSBI/WVznmEJrXHqpc1agURJRkV4my8PeudPlsdUKBt60J8ChvuaWtEu
         AdJ3jchCWvi+ip85h/mJ52a5jDOJYKrOnS71xZitkMrTbjjMx1R+dRuVETMaYiOKQmTr
         GV13Ktboxx1DFmws+Ny7LZC20vPCQSwqk6guTQXU4w2bJmqOmZKReoKuvbmB0d5GWvvs
         mDdk6Rcz+Qr7570ZOg1aXH7sNMIy+Xb7MtQtu1uLRRAtGlGL5Z2Adq6B66OkLbaj2rBC
         8pdw==
X-Forwarded-Encrypted: i=1; AJvYcCX4e+qhuvYzL3lEtxpYArspbK9RK4nKSGstD2Rchn2u8Jkr3hXjm2roG4aB9K1qw1n2GcSKJ4dpqChlcK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxotoF2o8CYuLL63ZneCuNzJtpTA87E+VralMdXyNVQWRNo0kmb
	Ri01VZQ+awCoutrTzBm028Tb9+5jIVPOHBLiZIkRvTtwuP14G44NIC7DpXEok4G8uJf6QXQhpHG
	UO03GxqErq4btfDM9XBmRS9QwuRdXVvh4N3pxucZpAhA16eGvCmCWs7pEgdqbTkUhlQ==
X-Gm-Gg: ASbGncvWm1fnDhrGjsn7EhZz3feWZ3cHRoDCZ2iTvafRjZ4XHSGhMPPWzzMwNco08yn
	iX9cM/baYpIjNAsFDwXbyNq4w5tjyDLD956nAu8pm6d3BKVzZQmkfild4RKS4DwKucSbzDrMF/l
	0iG8s0gijIoVNOOEAashf+8s4LRRKnBlSnoky9ccdqqPEBFD+Uv69utvNlYQxiDenvNmhSPHWRe
	pdbml0y+rm4W697yewDqRwgPtSwKCKbKcAmH85t0k8dwxMKLlNtc+Yo/LpSdgkIjX/GD617PzQo
	QV/vTDXJdbuB8f0SUZBfoeoL4bUcs+kWS3RgBd/JbyluVEGgPgVPt1ipMEoVEYg=
X-Received: by 2002:a05:6000:2c0e:b0:3ec:de3c:c56 with SMTP id ffacd0b85a97d-42667177c79mr3125792f8f.16.1759953574614;
        Wed, 08 Oct 2025 12:59:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeDk1T+mofjbdTeoqZInB5e6nHlSzZa5o4r2OFHcrqzydR6gR8O3TlE5Rv6mr6mJmuJuRGPQ==
X-Received: by 2002:a05:6000:2c0e:b0:3ec:de3c:c56 with SMTP id ffacd0b85a97d-42667177c79mr3125777f8f.16.1759953574226;
        Wed, 08 Oct 2025 12:59:34 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8efffasm31209583f8f.41.2025.10.08.12.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 12:59:33 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Jan Stancek <jstancek@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] tools/rtla: Improve argument processing
Date: Wed,  8 Oct 2025 22:59:00 +0300
Message-ID: <20251008195905.333514-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The long-term goal of this patch series is to reduce code duplication
and unify argument display and parsing across all four tools.

Costa Shulyupin (5):
  tools/rtla: Add fatal() and replace error handling pattern
  tools/rtla: Replace timerlat_top_usage("...") with fatal("...")
  tools/rtla: Replace timerlat_hist_usage("...") with fatal("...")
  tools/rtla: Replace osnoise_hist_usage("...") with fatal("...")
  tools/rtla: Replace osnoise_top_usage("...") with fatal("...")

 tools/tracing/rtla/src/osnoise_hist.c  | 74 +++++++++--------------
 tools/tracing/rtla/src/osnoise_top.c   | 68 ++++++++-------------
 tools/tracing/rtla/src/timerlat_hist.c | 82 ++++++++++----------------
 tools/tracing/rtla/src/timerlat_top.c  | 76 +++++++++---------------
 tools/tracing/rtla/src/timerlat_u.c    | 12 ++--
 tools/tracing/rtla/src/utils.c         | 14 +++++
 tools/tracing/rtla/src/utils.h         |  1 +
 7 files changed, 127 insertions(+), 200 deletions(-)

-- 
2.51.0


