Return-Path: <linux-kernel+bounces-724384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085BEAFF1F5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2343B71C4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F6A24166F;
	Wed,  9 Jul 2025 19:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CofidbIV"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99293238D57
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 19:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752090119; cv=none; b=SW6PIYtFaE1inFrbx00KLssKcFuQ2ekEMiIjTXnmPcuu0nc51CCM2saHNPVCJKEkNoRmSG7M/H8wOv8VxxVmD2M0SI7v3J1ftOzIv9DgogmG6n6c9piUHVpVeFpFnpLu6WeNq4JEXdssY5+caEf/O346dU5YqMg4STg1nXSU4L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752090119; c=relaxed/simple;
	bh=Ynz6tDenaXwMFCm6/D3VzlCH3p+V9vM+X5ZyRbXGFXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CSKZST+/cbB6Y9NTrRhAiUQeNR3ml1IeNZBQxT1OWUh9/pJIvQHF2Z0HWJqWwRAThJYUFDwR5denMcUoB6mCkBOs/vxotQZgunbGECu16D1ly+UCOThe2K51gtRdKhBqm+NsbfhG9ox0sfblH+lQnNRf9DvOhMcbqQlIQYWl+Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CofidbIV; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-748feca4a61so164003b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 12:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752090118; x=1752694918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tbo+OqvYcMwwX73OKwTeQCGLkoohI9Z0kRYtoLF2y+Q=;
        b=CofidbIVb5hbck5W++Lm1YTxTPbsnsxdCJ7vmpoEkFktTqismmZCcrSDPNe6r735xe
         LRsxLeHC4id+dhcEr5Vn/nd6WQLS2/GDahwjUm6iJOQqJbsT0I1ozluESf2/HlyA1wVK
         r7Pre/QYvl3sTATlI+SVSp3YdfsjQxn0JoJeDQBwsL3A+zzDKeQLvflYlkKDJkNFj0N1
         5vJpvzWsNIbWlcheOd/w61tnCPgQR0NQp1XcvZl8sXvpzWvnjDMNuan7CZm8arKX7+To
         uuFDje5gM+YUtaeEaH0rrKw6Uvr8xlqWUKYnVxHlP4HLfDZOrmcbV95/F7B7tkaXzYtr
         W34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752090118; x=1752694918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tbo+OqvYcMwwX73OKwTeQCGLkoohI9Z0kRYtoLF2y+Q=;
        b=GsurA/y4TtLliTFRbhSfdbRzm5OjP8KjABPsg+mJJT89OC9BFo/PH3WSF/AnQCWziS
         x7SutFMQcS+Vh6QN5cMSH6AxhnP+bE+NyOUoEI+EKoCxNg228G2ZuoDqdN886AQ8oj2g
         gD8jrgIIev9JkSpVJRI3WFUgO35lcmYqHlZE4bqt9ZJiKiDCA3jbSjSXijxpbOeoneHa
         id0iQzfpLdkj319sWCg7MKTkmIsjobqNY2rXMpWo0unGrvyz7EguPDaX7yPyLXOIjlZd
         mSQhIyjRNGq0k+g1Rc/ftoHh/NS0DjwyOQhRoX5JFValOanl8VUBEdFbbHi/8C2y4KW/
         vQYg==
X-Gm-Message-State: AOJu0Yw3V0NNN8YnLFnH6qsyRtAG3GWFVyMd79sNIl0Y6cOgomjKSXax
	6OhUAGLMRfh7aQ5ram5qR321OIX3Va4mVR7GvllRxl/CzbObFmzbOtmU
X-Gm-Gg: ASbGncuWThC7UD69bZqvBecfq3ND4ffwG4MQAMfdtTLAptwdxH3UxUQtq7KudMzlcBg
	Wv6x1N8laUlRGKtsYl6H2pJ0izekO2AyBIwBaqSocILyEUnONREr1cLPaibDRDRuJs8QqJLCQmv
	Ebak3pemuF84s27cQMOfyXlJoARXfyZmX3dAz79/bR5RDyK87ZIWhfYOJz/oVreUiOMJYgsZ5j0
	tZCr5RzbFDkLKyandOMCFccfbRkZFb++Jfg0hWcI/4NGFGnd84HNC/2YGx0RyZpA2OFGYlpJnDP
	Pr8Vj707bWcBRJovzv8qcqcsMRqNuTmvEAzit1Vap0f8xXXgYxHfiw5T/YAvfAAjNfhBbNM2kTk
	PGBDZUmjhAC4pjd4/BA==
X-Google-Smtp-Source: AGHT+IFG8fE5JG94JJiJtvJUBsG0Sk1zuOyJSvH5VBKEDM6o/BjI7VLIXa1H9m6mpeUPO045wm+sUA==
X-Received: by 2002:a05:6a21:339f:b0:220:21f3:87ee with SMTP id adf61e73a8af0-22cd846cd46mr6789003637.24.1752090117810;
        Wed, 09 Jul 2025 12:41:57 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b38ee4794f4sm15169458a12.25.2025.07.09.12.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:41:57 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Jordan Rome <linux@jordanrome.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 0/3] Remove unmap_and_put_page()
Date: Wed,  9 Jul 2025 12:40:15 -0700
Message-ID: <20250709194017.927978-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset uses folios in both the callers of
unmap_and_put_page(), saving a couple calls to compound_head() wrappers.

----

The initial rfc[1] attempted to provide large folio support for the
caller functions. Trying to do this without the relevant "struct page"
is excessive and unnecessary right now.

[1] https://lore.kernel.org/linux-mm/20250625174841.1094510-1-vishal.moola@gmail.com/

Vishal Moola (Oracle) (3):
  mm/memory.c: Use folios in __copy_remote_vm_str()
  mm/memory.c: Use folios in __access_remote_vm()
  mm: Remove unmap_and_put_page()

 include/linux/highmem.h |  6 ------
 mm/memory.c             | 16 ++++++++++------
 2 files changed, 10 insertions(+), 12 deletions(-)

-- 
2.50.0


