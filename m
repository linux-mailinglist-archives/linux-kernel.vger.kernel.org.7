Return-Path: <linux-kernel+bounces-815680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAC6B569C3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 16:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003733BD2F7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA591F5435;
	Sun, 14 Sep 2025 14:38:04 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ABD198851
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757860684; cv=none; b=IwonVCP/wIFQMERXHicWLdKHzUkN7AA5CII1wkOWcgJynfMu7abpln4GGT+M9wq4L55UjUfm0qMmf8TU3n//FetEyI5J/5sZ8O1EqbqD97zKz4KDPXF/FHdfLWza7TyuhQDXuFSdLuu51dC2jthVWF8k+nbJza9tmzgOJ8AITls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757860684; c=relaxed/simple;
	bh=dgsEsdam5JGmqWJk49+ad+hsFPUkC4nyvv4QvY6fmqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vz0SrP+x2VEN5xVmc4lTzPUAnvnw+Cteq3H0cdK4O5+k5aSViuILoiH8nh4HxiM4K8w8+P9yQuR9WAO0oITTgQP3PvPSvTegvFkHl2qtc2x+7Hw83m09qK5HWGt8eLCdhxll1f7bk48dnJtAuLt2iwZJHJzB5hj+plXdhXwwus4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4f9d61e7deso2086120a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 07:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757860682; x=1758465482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RmvHTqHdaE7BmVovCvT1+fW6WEaXEbDVIul7sfnvtOY=;
        b=GOSMtFey+6chYrFwTb0pffUXjDiDLQhiq0tgrn11dp/x36T3sRyzAolMOApm8OQ7L3
         MRv+2mMX+R8vIxPHnqS7Z9XW8i9XrqSwcDzEh+KdbPNwiNq2tV1+H/tinGGoOXElTnC2
         MFf2LqQFhcvSvRCqgZN5h6TyKlYT1SX5bdHy82IoJCmTL1+8MISjSlifDTXBMRdnxO4V
         goEZLvW1dyY/gm6aHY9Qky0cLfWJ+XN8lRVVeE4gjPVwf3fDVCLAciMDnUcF1owqVNju
         vBe5x0QtKbVfcxQjjZLvopjMeL0xX63JRKJSah0jjt/MIMvVFrC4UuGVldkJr8Jsg82O
         6UiA==
X-Forwarded-Encrypted: i=1; AJvYcCXQsuqB3QNQLb+yB2QakNIckNj3H1QB+YqYasa4EMlOTvNjnabWkmg3LrDqSpgNYQeNCrJazWQzQzmlnhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfBxNa4vo05BnsRmuWc0QtaLLVpsIT2tMauPix7gIe2UNSuiD8
	godBY9H/tgAHwsPaolKx/ksMnlyJQxfaIWQP9OQL7MrG2n+Qy5EmzESO
X-Gm-Gg: ASbGncsUPRa8QtrKxaAmWurM7J3VMnrXtD5U8TofGyuTQZrIdnupmiQVB9RPNpKTCHA
	O0TeH65SRPQTI9EYBvmoBhTVHLbqYwR9I4F2NUVadj7gX1H83PaXvJAuIoTTLNkjSbvIg+dnRNB
	33fPL5N117vhMETtwJcpbudXUKhrYwmomrLG4XIjwVMME2vXsqPYpisvnd8QQqjBNcsLOWo2lKa
	tOlB2MQ7VCX0c+evpO9RruqB+LLUciHqPoF66l+C3OcV3TVdCteDyzpQrCmEFPl70kFWCNRqhJj
	PaQdmzuvuky3GaooZDe8yFLUQP2y88MvZqptBZiil5kvk0PH9x+mAEDU2GomnL4IX4NQs/GvchB
	+TvOuMMhB+iySC5/w4qjqLWikZaj8IE7R
X-Google-Smtp-Source: AGHT+IEgy5aUMGrcJq0MScnJLtTMl7Y1Ye9tOVXxymZvMtyMYqBE1aPfDaPaJfRGuGgTJYfRp2tS2w==
X-Received: by 2002:a17:902:e78f:b0:25c:8005:3efb with SMTP id d9443c01a7336-25d2703b924mr119351345ad.54.1757860681783;
        Sun, 14 Sep 2025 07:38:01 -0700 (PDT)
Received: from localhost.localdomain ([2a11:3:200::10b2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b0219f9sm102571545ad.123.2025.09.14.07.37.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 14 Sep 2025 07:38:01 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	ioworker0@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH mm-new 0/3] mm/khugepaged: optimize collapse candidate detection
Date: Sun, 14 Sep 2025 22:35:44 +0800
Message-ID: <20250914143547.27687-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series contains a couple of small optimizations for the scanner. The
idea is to detect unsuitable collapse candidates, like mlocked VMAs or
guard PTEs, earlier in the scan and bail out to avoid wasted work ;)

Thanks,
Lance

Lance Yang (3):
  mm/khugepaged: skip unsuitable VMAs earlier in
    khugepaged_scan_mm_slot()
  mm: clean up and expose is_guard_pte_marker()
  mm/khugepaged: abort collapse scan on guard PTEs

 include/linux/mm.h      |  6 +++++-
 include/linux/swapops.h |  6 ++++++
 mm/huge_memory.c        |  2 +-
 mm/khugepaged.c         | 26 +++++++++++++++++++++++++-
 mm/madvise.c            |  6 ------
 5 files changed, 37 insertions(+), 9 deletions(-)

-- 
2.49.0


