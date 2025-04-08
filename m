Return-Path: <linux-kernel+bounces-594353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9BBA81096
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 17:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A4EE88128A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 15:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474E722B5BC;
	Tue,  8 Apr 2025 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbA0LEQh"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1470A22A7F0
	for <linux-kernel@vger.kernel.org>; Tue,  8 Apr 2025 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126961; cv=none; b=BXGcXf3hAzHoTZcuqLQbC6xm6gGYAizjM+OeUaoOfveGJzsifiSOIs12lLNAZnIGcE/oYcXS/IMeMmdz/Y2x9M6YGMPaXi8DHdl+0hBtgvCKiHLHxO8yjdeZ+wDym6D8C7LCNFvvxoG1xJpUOpyLjzUHg70b0s6wjUAIY3r4Y58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126961; c=relaxed/simple;
	bh=v4G89NW+J7KcVBj/0BwQdW8oYNVC8jECShg4GvbLmJk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OKHWhNB28ElAVKv4ibgqjJZekfeaSZBTlKw3CflWCZGt6fbA/0oOF6rkeQXlUgUcgk1g1Zt8FuKnsKUxgWABfH0wx9IgmfjxjIvvEDs6dtYuTbaDGBIN5Zp36MOZfVDQu+6rtWrKea/OW5PaXQRt/9Jlot1n762hPonQQki8jJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbA0LEQh; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c592764e24so611171285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Apr 2025 08:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744126959; x=1744731759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=au2hVGhc6RCG2a+LY1ynx4zQowEJeA8CTuCAqDV5tTM=;
        b=BbA0LEQh2HI/tETFYgERl2vryTfAXa7S+K4MUnpPTbpdLlYaulF8Ec4fAivSxuY8iN
         FvjSTpeq+kG1mT+rpAXJ9bt2HxyTqAB7asIU3hrW2o4Ro6kq0zEz/CPgpyonfOKcbpd0
         OPU2otglQWoB/kHEdQz8z9N+69F7rsBaMLsFAVX3f3o0qzxaHs5bwM9bpL7/tL3u9iCY
         ZvXOypw2DwHruixuYmxSyMvpkt5bBxAcDMuSkNB0a/vH9M35atrCb0hpWwrVFY3w1SJW
         Zlzo7qSLbkviy/vc6sVPF/x94p2v6W8m/7lhPUQgaTJ2yxnWKGZShLCtTtI/owU5i/cj
         p+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744126959; x=1744731759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=au2hVGhc6RCG2a+LY1ynx4zQowEJeA8CTuCAqDV5tTM=;
        b=mPhxxjnd9R5HawzX83wG0/y4iOwTDvBiGh3ZD+edZFfoMkVARyK+eVs3kQYgmwMg07
         DtMBsLqF/sIeWgOcYChF5T+GtDaAeK9JM5xavPNEG+DPxWwUu59AEMtjS0OPSSXqcM24
         W3MkRZVBFp9uvsLYbB6IGBwvX3sOUkFoZco09oP4AQkPsXLeL11DdurklwXgRg6KzlFj
         +ogTX6VxwCM6N7oKjWtp6XxDBRx0qUzbNKhihzldSDg5rzwSbFBj455OWYH16f2+TCFH
         wUhmX2YH1t2byIurfjHwq94Vm0DzKUS5EiSLvB2fCJWzcVx176+LIyEclqlYgIYWOc/U
         2CkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoude6owKkizW+a2JvIhggq0euSen3WZaQvyxdd8Uw2bDMwDHC5f5S0kXcbTvzzX0OfZ/5BNLa9LY48o8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnLtHQB3AiHSW8tVjz+OYGTVpG2BGyiJs0dOCuEBELEJyKhU3l
	sl64Dj8qW/9U5JnpPFmzlLBjq5dy5a2YoQYaVvrH6Sc3ompexP9T
X-Gm-Gg: ASbGncsBLnjRmSnJomgvQ1uyPxXgzkJM6mLFAgtRU5A+2mjNPAlN9COgsl79N+1uNsp
	43NpHrYrbBMKHqqeD3h4EYeeNjvXqPLuJUl9FQCWMeM3mulpaDJg0pby+tovaVTMwwB1Vu6PiNC
	jvZS6i6umtIx5C2yuA4zT4bNo8mmqkHvESW33DlaTPu/giU64290BKMpZx7tAy+aceCcRbP8YTA
	8CjiqYy31QixaZEOhMLSOIPA87KGNj8tJtXUQp3K1t9qim/kx/7IvOheWY1l/qbAoOVpIH/ZB9G
	Ar2RwIcVJiRnvQnn0Mn+P8+z0coBgubcslYBlLq+9zFnhvQ=
X-Google-Smtp-Source: AGHT+IEfPShIHBwOhW/JJVAWr1k7BuDIr1u0Vc6XzTyDNngh2KPE4R491ZGuszkLejP+zPxe7mrabA==
X-Received: by 2002:a05:620a:2481:b0:7c5:ae70:b081 with SMTP id af79cd13be357-7c7940ba295mr522007985a.20.1744126958886;
        Tue, 08 Apr 2025 08:42:38 -0700 (PDT)
Received: from ubuntu ([105.117.1.177])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76ea82d61sm774717285a.97.2025.04.08.08.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:42:38 -0700 (PDT)
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: outreachy@lists.linux.dev,
	julia.lawall@inria.fr
Cc: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	david.laight.linux@gmail.com,
	dan.carpenter@linaro.org,
	andy@kernel.org,
	Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
Subject: [PATCH v8 0/2] staging: rtl8723bs: Improve readability and clarity of sequence number wrapping
Date: Tue,  8 Apr 2025 15:41:55 +0000
Message-Id: <cover.1744126058.git.abrahamadekunle50@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patchset adds spaces around binary operators, breaks long lines to enhance readability
and provides clarity on sequence number wrapping by using a modulo operation % 4096u, in
place of the bitwise AND(&) operation & 0xfff.
The patches are required to be applied in sequence.

Changes in v7:
* PATCH 1:
	- Added blank line to enhance readability
* PATCH 2:
	- changed `power of 2` to `power-of-2` in commit message.
Changes in v6:
	- Modified cover letter BLURB to reference newly added line breaks.
* PATCH 1:
	- Added line breaks to long lines to improve readability.
	- Changed commit message to include the information about the broken
	  lines added to the patch.
	- Changed subject line title to also include the newly added line breaks.
* PATCH 2:
	- Changed instances of `& 0xfff` to `% 4096u` which were now in the broken lines
	  after the broken lines have been done in PATCH 1.
Changes in v5:
	- Converted the patch with the subject "Use % 4096 instead of & 0xfff"
	  patch to a patchset.
	- Added a patch to add spaces around binary operator.
Changes in v4:
	- Corrected patch to use '%' instead of '&'.
	- To ensure this change does not affect the functional
	behaviour, I compared the generated object files before and
	after the change using the `cmp` which compares the two
	object files byte by byte as shown below:

	$ make drivers/staging/rtl8723bs/core/rtw_xmit.o
	$ cmp rtw_xmit_before.o rtw_xmit_after.o

	No differences were found in the output, confirming that the
	change does not alter the compiled output.
Changes in v3:
	- Added more description to the commit message.
	- Removed blank line in the tag block.
	- Added more patch recipients.
Changes in v2:
	- Changed the commit message t a more descriptive message which
	makes it clear why the patch does the change.
	- changed the subject title to include `4096u` to show that an
	unsigned module is used.
Changes in v1:
	- Added more patch recipients.

Abraham Samuel Adekunle (2):
  staging: rtl8723bs: Add spaces and line breaks to improve readability
  staging: rtl8723bs: Use % 4096 instead of & 0xfff

 drivers/staging/rtl8723bs/core/rtw_xmit.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.34.1


