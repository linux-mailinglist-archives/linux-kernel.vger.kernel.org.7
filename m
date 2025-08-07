Return-Path: <linux-kernel+bounces-759237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6626B1DACD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547BF626FFB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E861269B01;
	Thu,  7 Aug 2025 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBlIVhwW"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AF12686A0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754580459; cv=none; b=a2AWMJ87epFJkUOwC6tXkOCWnLG2LfiLarUuQrZv7t+66dnE2/5Ivgsi+tU32fEwb3tIpIlKUvhuKFOCUIPncqRlVQAAt2j6n86o0Wb8Q42R7CRTR/mVx7CURD4ennnyHvCaslC8+qKOXXKq5rZ5OcJXWeUfVkUvTcfESq7a5uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754580459; c=relaxed/simple;
	bh=HScgKSCvc0aqtEouHRD6nbYXe/fN1pJqDJMEJMjP9bA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TGug4lWVloiMPqyS6JTRz+kSu46zZU65w1wuIHW6jXYBmEvudaQLuFgeB8ftnNhWiiQkC3CVKJBWlwxwENJ5lECFcKzJvCO4t/qTu+CuJ7SnNzAZ7QyRkEd7FH841v7XWo/4LA8BKGdZvaoxLhHR+WtJARwGuNWUyFqD5C+sFD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBlIVhwW; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76c18568e5eso1346407b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 08:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754580457; x=1755185257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DwNT7dW2/m7U6b9mOpn50Hlu8qReyNYgvDKR7CG4bYw=;
        b=MBlIVhwWZYyIvrsbf7vUKX8y28OVVpd++NnOGzUq0ljXuJNk9SZ9yW4CBToJ+jh4V0
         vd1rYmCQvZzYLIRdyw+epD9YUu2hiUKaNvarJb/Jkl1cVCBkyouJ7SyeAAvI7MHHNXRs
         USR//JQu1E/7wejTWOojkt00VcUMpsI764ZuY1vWHJRjzN+/0WVrPDmsfcIhsKGYeNpt
         bwm/CHrpWmxdY/dA1TEXBg0Igo4S8uoDFhIL8CvbAiIcVNGaQ2c0kKNL1l/dQYvKEhBd
         zCVuzevDb9LEvErP8jsm0TeG15tJ9MJBahzjTbqDk2IsCOWZOlApaFue6I+jAGv13U0w
         4SoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754580457; x=1755185257;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwNT7dW2/m7U6b9mOpn50Hlu8qReyNYgvDKR7CG4bYw=;
        b=EUYLa4qSHltHk546pQeGWkhVIzTvMTMH2nmE7dKCM6IctQ3ZfqNfRpxH2kORqYuu6V
         s2MXT1AOw3j9qiOfNgoeWPW8m4pAE3OAeBCY0okXcsWzDXvy4paJK1ubKXWH0RdjnP6g
         MvY2jocLJuoojjjs5LJt7hJvPcJ9t9MDxBhxuvfO7thnb2ZpXdtY0bwROy6CZ80u8/zn
         5KVRJW5mCJotcJWsNGiy5f15cdDLVaB/Pp1fTOCaLU71cmywc2yKXzlX4nn8dNmQezDd
         LkbizhNqwBScIGVyHw+Fyy5cQ5jGgYcQDJrfuKIB8ndG5pohtx142MUl8gK8t6s1w4Gs
         zZkg==
X-Forwarded-Encrypted: i=1; AJvYcCVkEUrVkLGlPstiO7S6cr4w+/7P+Vo+5eDTRQmKEVpUUAclkl/4SFBSGDqprKWRdo6J7OiurG5b0kcSaBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFVaZpg6ZiR1XKVoXmWPU2YlJgCMH7wok6amWYudlqVPy+0T+v
	Qfk0aLmidsEp1aiTP7jG34lGdBWVKsuZQ8ZuU2TxgnIm0ZXbwwZfRwwG
X-Gm-Gg: ASbGncvENYCy4KT3Q5V/b/U4lFrm+mX0RP7Rbzr6QngycmJgH27GtLcG8kjcC9KJkIy
	3MN9bAC8p7rUlyo+1+1CWAuj3b+NSP+gEOeXz+yQnNpuPN1XObPb/1OhC6pivPMKS2RESDwyws3
	p4/RprDddGXcZIcSwXwckJ+5b31EFsQdEWk9hLCYNYAzY8+10J33deitll+g+VL6HxvnV8UQvM7
	5DxsyP8qgKiGUSNSR6cXtmSbm7AGRKGGBAFicBfvlZ7d6qPjSpzl5wLFqVu5cwG8f7vFfygoi4f
	IU2QJekVXzK4QVuZ8ggTmh3c28zg4DFBQ/D/SmzEWX73JNMdCfaWurIaLAhHG1KjTSlCKw1UW8A
	SFQRQsp+tk3xY5nNmbcFaYXyveeuWmt8GMiNS1A==
X-Google-Smtp-Source: AGHT+IHUEMkzIs6sGCBEK7uIhxHW9mD0/IfEBuS7WV3HY9lgjM/Si26KklbYhO8GRSVlZzAmoRamrg==
X-Received: by 2002:a05:6a20:3946:b0:230:8b26:9d47 with SMTP id adf61e73a8af0-24031252281mr11358527637.10.1754580456487;
        Thu, 07 Aug 2025 08:27:36 -0700 (PDT)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6f319sm18430540b3a.18.2025.08.07.08.27.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Aug 2025 08:27:36 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [RFC PATCH 0/3] mm/mincore: clean up swap cache helper and PTL
Date: Thu,  7 Aug 2025 23:27:17 +0800
Message-ID: <20250807152720.62032-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.50.1
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

There is a swap cache helper that is only used by mincore. It was
seperated out from mincore some time ago to be shared with other users,
but now mincore is the only user again. So it can be easily merged back
to simplify the code.

Patch 1 clean this up, but I'm not very sure about Patch 2 and 3:

Realizing that the PTL seems only useful for stablizing the swap
cache space now, by grabbing the swap device before looking up the swap
cache space (patch 2), we can drop the PTL locking (patch 3).

Let me know if I'm missing something. With mmap lock, the mincore result
should be reliable enough without the PTL.

Kairui Song (3):
  mm/mincore, swap: consolidate swap cache checking for mincore
  mm/mincore: use a helper for checking the swap cache
  mm/mincore: avoid touching the PTL

 mm/mincore.c    | 53 ++++++++++++++++++++++++++++++++++++++-----------
 mm/swap.h       | 10 ----------
 mm/swap_state.c | 38 -----------------------------------
 3 files changed, 41 insertions(+), 60 deletions(-)

-- 
2.50.1


