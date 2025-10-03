Return-Path: <linux-kernel+bounces-840905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 828FABB5AF9
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 02:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44DA73C0454
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 00:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295781B4F09;
	Fri,  3 Oct 2025 00:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqLZeOSW"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8351EDF72
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 00:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759452674; cv=none; b=K+lPjZwSswuS2lCFxRq15gN611QB6yra28NsLAxkFMvWgasxZJBRMhwX6EiMKC/b0FGK/l6JTnxXxZUD02wdUEKVwrGDD6+YEAaQnRt8oO7tX8F7syv3iA/en0+rUNrfe1gAQDJkTtiryNuyil+v+9temHMNXwR2VpGTq7buFYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759452674; c=relaxed/simple;
	bh=X5kSDsxxb+XD9CPJBYVIOtNwcZLhvc6wqQVQXU6X/oU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kMjWMXPM6Ln0LV2DoRxfgRNWaIGw4M1XjSFRd70Klu0HPdddOhnB5Qf+AT5YgsE8lJf4TyIPVeuzeMGz8xS3lfqKQD6kkr3SCs+ytgiOo8QXOPH3rkjuFNG5cfXUO/i+mHk3wDRPh4m3gsFIKmCpzSAz0TYAjee45U45aiLfGXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqLZeOSW; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f67ba775aso2399925b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 17:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759452669; x=1760057469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T6bHVlibpYYb4K/JC7+xFZW8SMHjF8M/EaQn4o+DfFI=;
        b=mqLZeOSWe/r8sA2Y3IxX5SsGblBscay8wiM5sTHlk3B7yOi+C2HO7Hhr+EPGWkqGoQ
         6qpSCiLwQ7IMsk8Kg2AOQEkrksvkrsUtqHCi2VqYW/w15foG+zBQK1AFTvqGW6DmIKp1
         yg7OkkaYCHAisSPM9kz3sF9QdXd0jEtz26JCCbHgAdH/pMPtw2FqIER7VC9pQjeQZfA5
         IhbelqRMtArPj1qRvKn0GjEVMaQP1JneeOmbVLVY2t+9un+A9/toxr0aVHRWMBA8CsYM
         d+Ru2e0TcsorQKR2xXh7vBFnugypSOE5okQ2oUaPsrBFEfhSM4IP1gzy2+nfKujv97uQ
         1yTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759452669; x=1760057469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T6bHVlibpYYb4K/JC7+xFZW8SMHjF8M/EaQn4o+DfFI=;
        b=NkmJ6sdwvgnIG8vS9pMYCN3WJLFFel5GnnJzbli/ZO2eL8nmDSzEhWc9BM6IQFuWMv
         Lw1iGAz8GV1arPJP/yrV1KQuLnRq3UUMDJUlL7aaAIuLk0U+w6SHsZgYRX8Jq3+fAPYf
         T4bx+99+u+TASuokrGShz21YEu2TXXbD9LHehzAZvHxCw8y5IanWRnDzoCDJa7oH54wv
         LMZjYqQFiFR8Fk3o37sUfTU6KWFiiTJtLFXDs/ok58QgZuy3MPcPuYTaJbDajFqGgwdn
         hH1OBlEBUwff0eUSvBJWsVCvBpkBPOYsyJXaNapWhR4JaYZANAS7BrevC/JfyJIaCAWK
         sUtA==
X-Forwarded-Encrypted: i=1; AJvYcCU3y+pChvxDmAQy1FmF0ZgKDzgmvYCxgSZNclhjbrlwRzlLQ+09LHDl1Ffb/abQ2v1tgt0lS/BzWFe+sco=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoQpzFNnnF9PY4HXu9RqL6L3/Dm5TDiCvsNrkpAz7wJJZQ2IFA
	JMtsCaBOSKcJUPUmT9StFI5uVz6XtPemmXiDZyeFw16SdazfyGMZgDCO
X-Gm-Gg: ASbGncu/IFFEWHx+tVd9OtZ5NjuogWEucZnkGfwdCYJZnaE65Wd6e89wwTp4/YDmm9I
	Itl5Qa4oIMyRgGOcTRkmvQjvHFS/IOTGpjWimKhDErOYjFFN1aadoLVCWLBeVjII0nbn4LaqNPu
	GmqwJwTj3OQaWdGThdM51dZLt3z5C15bSPVB1RHboEwvtrRj0M6i+MQ26VS3Ld0nhEh9rQ4nbk1
	m3XHVwBtokIMi7VFZjq6bNSCDAc7EQ/k/TNiusbyBzwyyxI8wc8nQDkF6Ag53dtKk/t3U5XW/nC
	KioU1VBc+mDX2r6hNqshvrzGgR41/+S7NKQ8a9oiKKmKDWYdkB1OCbXs1g6yh4hbzRkhAnv0BiF
	KoDxYzfhAgD2PZ9Vgtg3V2BfP0ZnCt9r0L3BxogmANXC8L9hvRPh4R9BQ7Obw3gxsEem7WYetC+
	8YwmCmD7db+Vy9uQGi/8EXXSGVY8XObuMelxHv
X-Google-Smtp-Source: AGHT+IEwpomN/IBM+LnVDO+n8UtyRhkgfYEiaynqtsEYJ7oxGVacvwjycgRmKHI0Uzq7yJYetl1FYQ==
X-Received: by 2002:a05:6a00:188e:b0:781:2558:6a3e with SMTP id d2e1a72fcca58-78c98d61decmr1842426b3a.14.1759452668771;
        Thu, 02 Oct 2025 17:51:08 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:38c3:a5e9:d69a:7a4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb28adsm3271827b3a.35.2025.10.02.17.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 17:51:08 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: reject inline data flag when i_extra_isize is zero
Date: Fri,  3 Oct 2025 06:21:03 +0530
Message-ID: <20251003005103.2399934-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Looking at the syzbot logs more carefully, I see the initial 'acceptance' was 
because the filesystem failed to mount ('VFS: Can't find ext4 filesystem'), 
so the bug couldn't be triggered at all. My patches were never actually tested 
against the real bug.

I apologize for the confusion. I still cannot test locally to determine what 
the actual corruption scenario is. Today I have re-tested my same patch in 
syzbot and it is failing.

Best regards,
Deepanshu

