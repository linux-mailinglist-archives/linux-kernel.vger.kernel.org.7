Return-Path: <linux-kernel+bounces-848816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B85BCEA14
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 23:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C99324F94B6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 21:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7CF303CAA;
	Fri, 10 Oct 2025 21:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kx4kS1kd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7EE303A2D
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 21:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760132551; cv=none; b=tNUuyB0/F8dq2Y26zU3gk+7jRf1oMiHTqHRyfi1cSnzv6zwrwl/6wutlr2iFJSucc05JBSyDNHbP2zRz9Jj4YQr+64O0ZXAiaWupdic9s0mlHP8D0UPy/nLVnwYuX1aQ7qGTZPUPC78YdfBH7qA3vjealy7waL6pVmmpbqVPD2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760132551; c=relaxed/simple;
	bh=iq2e/sv+Zi9ciUHjCrlUp5Jvva2s5vbwXLIaUxZ7+K8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGvJjAshRoTIhFytkd2nlbMGs09MqAaLvEkPilbaDz/zaWJHrQ/9oIrpROXlgGW0ihU1dNioGbHu4ztHf0GihdR1iooDJk1x3uqCeo1YbpURG7Q7CudnmU9CBE8RYjowk+9+tARHpot5dKrSAvHTnE6xy34XKE7vsYXJt90QfMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kx4kS1kd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760132548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kQTrdZe6qZc3CMSCwVfDCC92bOCqOE6gyRvkJ7nko6k=;
	b=Kx4kS1kds/9BoOA5CSz/4UmA8r9Klh2wClozbfB/lDWiNGugEzoHUkqcWPBgUIuJxjDyIT
	K6dhw7G0kuiNepVG0FN23x+RDMrtCLaDSV15gwMNlRd8s7ODxUCeuoxoWqXY1/GVSQyTAf
	h1Hr6z8JLD+JYqQzjluIVQ90xFZsayo=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-tVkVHYKRMcGTiFnB7nNDKA-1; Fri, 10 Oct 2025 17:42:27 -0400
X-MC-Unique: tVkVHYKRMcGTiFnB7nNDKA-1
X-Mimecast-MFC-AGG-ID: tVkVHYKRMcGTiFnB7nNDKA_1760132547
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42f86e96381so89902895ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 14:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760132547; x=1760737347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQTrdZe6qZc3CMSCwVfDCC92bOCqOE6gyRvkJ7nko6k=;
        b=rfrbj+PFFNtSmUfZjF0E6ElPCocmsQDaVAlZM19y5F64WqvsOCHfPtVUp9iM1us9M6
         9O3jgdss95zAmmUlHv2C+ghAe3G3e+w7LaFun7twq/fdBGnuMwYyUXZ1EQAPx7Rw0opL
         cCF+3TQsjAPYwyWDMAsphKLcMR8m5DHNgqaPBtRdmnab7dPAtQmXpmkCq3kSUxOj2E5t
         chdtDSQGjPl5JCW2yKHsvOAkgdtMpWyU5QuVIVNS2huQ+acLmann2BATGfov1sa41zNG
         MkwJivSColHYOF4xr2OtSfDvXQr0UYmws3mjVoRu2mWZi/F15TWP1ASRZzTMAaTIUWqf
         T+bA==
X-Forwarded-Encrypted: i=1; AJvYcCUTtoZrX83jOUAxvSNxX6mfcVnjf24/JDApPYmfKNn4RmajbdYhfI1K1j/8hhTXQ5Fugvo1eqFEKhl1Vzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU3jU/4+jQZy43fBQn70oGL5lFeqOlLPn8Kt+EZjzfb9AqJ0Qg
	U085YcPJfIy1Djj4KY8woLQhuL1BwWzUB759tD1uE5Upbx159HpTb0Xn6OT3btRfC7QkPJDUp2b
	SS8DmCVQIHZ8kz9vQLojN3A61ZWhzW2oIe3dUssqkGSbJc5YhhYDAezJfYGcmxn6JoUgYEInnpA
	==
X-Gm-Gg: ASbGncv3lLQheFTvQeK/HNssjxG6XNpHLlfXtAa8uBmOveaP9+c+nygYzA0uWKo+8XO
	5EHLzqUQ96+LDTktSGUEEVKLJJJjHQQ/+hUJFseaoSAfQ7BKAbx5ZbT+676cBKlzWECNwA32Mn6
	sIyTLXlPcfSSFDqkVBopFp3y/sso48ZgwNtNr+9YNwgAHsYi6sm9yBvTBalVdIHBCRkUvCXL1jL
	sXioC/IQLS4DmvvG1FKuRLqbuPb3hGF6d5DQE5B05+ggbN3WEVclQrnDZdYP0vc80ZltH1SWjSc
	vrmo8pBvdCxOTwOHLEfq5ijwOYEov/wkGHyRsFGFTZ/J7XP5lZcwxog=
X-Received: by 2002:a05:6e02:1849:b0:429:6c5a:61f3 with SMTP id e9e14a558f8ab-42f87373153mr127614405ab.8.1760132546321;
        Fri, 10 Oct 2025 14:42:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8wowT6uDx6IYvItIFqvayc0HgxnQWRhznxzbTVphFWlfOlNrKFLBVqyZESk0W8ghcY0ggsQ==
X-Received: by 2002:a05:6e02:1849:b0:429:6c5a:61f3 with SMTP id e9e14a558f8ab-42f87373153mr127613725ab.8.1760132545634;
        Fri, 10 Oct 2025 14:42:25 -0700 (PDT)
Received: from big24.xxmyappdomainxx.com ([79.127.136.56])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42f9027855bsm24382895ab.11.2025.10.10.14.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 14:42:25 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	eadavis@qq.com,
	Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH V3 1/4] fs/fs_parse: add back fsparam_u32hex
Date: Fri, 10 Oct 2025 16:36:16 -0500
Message-ID: <20251010214222.1347785-2-sandeen@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010214222.1347785-1-sandeen@redhat.com>
References: <20251010214222.1347785-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

296b67059 removed fsparam_u32hex because there were no callers
(yet) and it didn't build due to using the nonexistent symbol
fs_param_is_u32_hex.

fs/9p will need this parser, so add it back with the appropriate
fix (use fs_param_is_u32).

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 include/linux/fs_parser.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index 5a0e897cae80..5e8a3b546033 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -120,6 +120,8 @@ static inline bool fs_validate_description(const char *name,
 #define fsparam_u32(NAME, OPT)	__fsparam(fs_param_is_u32, NAME, OPT, 0, NULL)
 #define fsparam_u32oct(NAME, OPT) \
 			__fsparam(fs_param_is_u32, NAME, OPT, 0, (void *)8)
+#define fsparam_u32hex(NAME, OPT) \
+			__fsparam(fs_param_is_u32, NAME, OPT, 0, (void *)16)
 #define fsparam_s32(NAME, OPT)	__fsparam(fs_param_is_s32, NAME, OPT, 0, NULL)
 #define fsparam_u64(NAME, OPT)	__fsparam(fs_param_is_u64, NAME, OPT, 0, NULL)
 #define fsparam_enum(NAME, OPT, array)	__fsparam(fs_param_is_enum, NAME, OPT, 0, array)
-- 
2.51.0


