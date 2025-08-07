Return-Path: <linux-kernel+bounces-759022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2EBB1D727
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED38D18918DD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AF621C167;
	Thu,  7 Aug 2025 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OObStDQ5"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068B8748F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 12:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754568051; cv=none; b=E3WV01e9NFRg1MiIPcqJLclgxpJXZ9A7HpvHiY/F6HJAXp9eC+30ZMvZOGPibuptgc0djnmAxNGDsjgeCHbT7BEmmFbMje5HECzEsEH8ZCtMJabL+QE7hrqF3Eg4hGDzBm7o5IFrXN2C5Hsa9skLL1BLSxz+JwZ7FWaHa/7vJ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754568051; c=relaxed/simple;
	bh=LdY/i+rMPmKQZOWkhSXJPPTOIyh9JDAEwzRhIXeqI2I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=u5qPY+MDFNoiKG4yV2bqxNZDcj57EcU234djbXfoXRxmd0pMq/CkWImMBsrKD+zz/zRB/wqlT+i71vaVk8blyH5wMVW1KS/Aojh4rPly8EvCtK7xWMwxXRUZn609tt1w501qYsYvvmbYzcFE07oRrBsVChknIINYHehPaVdCWEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OObStDQ5; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24249098fd0so12077295ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 05:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754568049; x=1755172849; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NVQMzpDcKZ25lxhvOtkAAfHad41TvtlPkpgkU/8pXts=;
        b=OObStDQ5dTcKUWemSHj0uMpZj9uah+wcneL4Sl0BpS3DqJwC7NZNj+OcPfiLZ2nk4d
         pbmPg5inXtU+9mu8ySoW8dGPpcxz0heVMpDJVaqIRVTJ0hBwawrWShM6xjXqu7uj41QN
         9mn70pZoFDb0ZWvUaOuLFHR9MCVIogEh9egvQLfDC/A61DfA/pjHfhc51ZMiJH2pp5jP
         Dt5MJQHK//yuv01UZUWnOiN9tdgW2J1yIr2CaYqWLcwk6KtkLYCQIYC13c0zDrjus7Qy
         REDtEZ7LIYVnJ9WfX/VLhgFr2fSuik/+wrEm/15qbzbCGgVMliMtaRH01/8Bzm2vBySh
         TFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754568049; x=1755172849;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NVQMzpDcKZ25lxhvOtkAAfHad41TvtlPkpgkU/8pXts=;
        b=DpvHdyRo68wNGoPSy16NhCtdPQ2te867kkCz6ENTbdULL86ApSri4gx3FsBJgsziIa
         dNhRo+30nNYeVqx+XA0GyGVDV3fHQeLIU+FzfCOx+9Aj/XEjtRugH6s5ztp91KefeCZh
         dwoxc5ULmqJwOk6ljGay3sta6jfAMfegFLltcirpY5nOcvNlYb4shFWsyBdBtAcc87yz
         N1TKkGgcvV1eqPbF1pQTL1P40h8HBMZsvKtSS/TIbeeeJ9BVJFhX5AZhidZkFnphHEiN
         5yIJol+BMQsnVYgznRQMdfpYa8IwT8llIChXcQiYMGSV0Rz+LXyyGPFcQT4aNfMzDOQ6
         GzWA==
X-Forwarded-Encrypted: i=1; AJvYcCXZmLgSY31ani7ZJrIuP3iYvHFesf7UMfwe4X5h7aNpbZPDLeoXzNnKwSrnJblMIxqhAHQfxbhQ4W+Mhps=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfQy07muk1FUl4TzCtrd5BssZfwvzZ8TYbWtIOm4HlnGSk8XxX
	LB22TqRyVZuGmzw4D96+M+BqiCUdmtj/0AprSsi3ojVpEguaXPgYFc+ZmTWgKkg/mhKaPV3suX0
	Nvw==
X-Google-Smtp-Source: AGHT+IHAQEVxCio5STxDcfDDBOE+qECR7XPXNMNLX8/DgAGu0ZsKEeHIC699gNm6QUfd7tqb3Uw+frWVBA==
X-Received: from plgk7.prod.google.com ([2002:a17:902:ce07:b0:242:86ec:7de6])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5c8:b0:240:9dd8:2194
 with SMTP id d9443c01a7336-2429f5772camr112852665ad.22.1754568049158; Thu, 07
 Aug 2025 05:00:49 -0700 (PDT)
Date: Thu,  7 Aug 2025 20:00:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250807120042.1761685-1-wakel@google.com>
Subject: [PATCH v2 0/1] selftests/futex: Check for shmget support at runtime
From: Wake Liu <wakel@google.com>
To: tglx@linutronix.de, mingo@redhat.com, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: peterz@infradead.org, dvhart@infradead.org, dave@stgolabs.net, 
	andrealmeid@igalia.com, wakel@google.com
Content-Type: text/plain; charset="UTF-8"

Changes in v2:
- Restore RET_FAIL assignments in error paths to ensure the test's exit
  code accurately reflects the failure status.

Wake Liu (1):
  selftests/futex: Check for shmget support at runtime

 .../selftests/futex/functional/futex_wait.c   | 49 +++++++------
 .../selftests/futex/functional/futex_waitv.c  | 73 ++++++++++++-------
 2 files changed, 73 insertions(+), 49 deletions(-)

-- 
2.50.1.703.g449372360f-goog


