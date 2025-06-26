Return-Path: <linux-kernel+bounces-703494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15058AE910A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 00:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575ED3B15C0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 22:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4E12F3C17;
	Wed, 25 Jun 2025 22:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ABYjDTl2"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC42226E6E1
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 22:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750890394; cv=none; b=fr+UgtlpXHKe+g1iCQQ5gktv+OiA7DRJWLxI8daCqPDtcCztKmfwP9Qx47FmoO4fofUdhYIm91iK/bEqDvoB155+rDgX869dZ7Ap8i0FbxxCsrrHs75i+GtvQzTwvr8FNh7wXlMHDdIWu7FNnLBt9XVO16OQh90kMWvk1UBH8m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750890394; c=relaxed/simple;
	bh=yyzQXPsLkcBr0oSLAqWgPrP77tRf2tbQ5z6fMMbApCA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YTGmZISHbgyFCCgoYIiuN+or5ktzNFbQX0mVwRnN+op5/aHMG8GOu0PF3wUToHvUD2XWmBFDGkYpFcbQ/APWbyZqzutgZ6PGp4sdUHtTsvvnpEE3d2Oys9WIdlK9bEBaSqjcF2hRLN76yr3bPjXikuxD9k1e7ibTXLcNTAJVf5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ABYjDTl2; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3132c1942a1so423925a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 15:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750890392; x=1751495192; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P6WauUfkkK2gO5jt3CCxoOdLFQCfPyXmm+Bs1EqbQ8Q=;
        b=ABYjDTl249M8tZGSpTMa7f/f3VujH070MZiy95PhgWNjrZGMoEUPpF+5tP47Yfw/x8
         +QoULexv4OngwRAMgKnwgTP2UD/QRcdrF98nVLvK0zfxV7drUQCvkbqX0c1TSUIZ9rYU
         HLktP5DaKRDTSR5azszy1ec+CpA4YkL5la7t+dVbJ3KWSUJCI+P6vMPE+gBS0QpZDPJJ
         e3bur91ur1uAqrQOZUzXc4YhVWRi9kecPITA5VhVGkgbVmBqephJZQkekRvihWvpvqzj
         3rsh1Z4oNsKxS9ZvsaOCxOVBRF688fAgTFog8LC/r7jvlGguPPlMmSadF+T0O7S1XJkB
         sIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750890392; x=1751495192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P6WauUfkkK2gO5jt3CCxoOdLFQCfPyXmm+Bs1EqbQ8Q=;
        b=QB8IaOC+VorxVU93nUHbsVtXlzcF4w5wmazCDI/KgHdhbieSTlhQLVaE2dzVZnqbhb
         19lKJLClIFSXnJXbD0ALTy8HoCffXEUefCnqn5lVU38iUoNQS0SEUnyXuk4YjjZiXvzq
         xU5ealkVhY6nTOjdNKWFe9LvBRW0B1VM37tCVaUa9p9TAZ6CPqW/m8Q+0/jHJ3dk3u2W
         Dfwm1Gq1Q0+5I23UL24cbjvyXNliXP5aViJp+h29VOhR57NnlQ3Uik9kx9QxRJj2Rlk1
         XbocKPdiW74sWtX+GuRTEHFvPyOgtuxwEWwt0wrLEk61klpIooSZmCSAVGeTJ+qZ4ADN
         SEgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC62b5RsfntNmQlYusR4+rNBNmSxEjkjqBvS4EJxL8srbx8ayE1Uzd5onqu0tr7pcikGrqt1WTpHdg60I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSyUlWrXa7qnmhNINYLcbKQqxirDPjeMboNBEjgQa/u7sYBHyu
	zEPDOj7F/o4vLofYD+TTHx7WEFHn+dMqM14ZYcadOJDmiT2sfgTITwIf8J5w2AWyZrtkKvk0exd
	D4+yAFg==
X-Google-Smtp-Source: AGHT+IH8WNh75hYFjly4SyW+lveTdUM4hXthSziwr0cb2a0IZY9ZfUCJrswlHz/oV1Y45+ll7+bwKdTMwNc=
X-Received: from pjee7.prod.google.com ([2002:a17:90b:5787:b0:311:b3fb:9f74])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a91:b0:311:a314:c2ca
 with SMTP id 98e67ed59e1d1-315f25ed82amr6242747a91.6.1750890392115; Wed, 25
 Jun 2025 15:26:32 -0700 (PDT)
Date: Wed, 25 Jun 2025 15:25:33 -0700
In-Reply-To: <20250602172317.10601-1-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250602172317.10601-1-shivankg@amd.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <175089020166.723091.4300884010519691582.b4-ty@google.com>
Subject: Re: [PATCH] KVM: guest_memfd: Remove redundant kvm_gmem_getattr implementation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shivank Garg <shivankg@amd.com>
Cc: bharata@amd.com, tabba@google.com, ackerleytng@google.com
Content-Type: text/plain; charset="utf-8"

On Mon, 02 Jun 2025 17:23:18 +0000, Shivank Garg wrote:
> Remove the redundant kvm_gmem_getattr() implementation that simply calls
> generic_fillattr() without any special handling. The VFS layer
> (vfs_getattr_nosec()) will call generic_fillattr() by default when no
> custom getattr operation is provided in the inode_operations structure.
> 
> This is a cleanup with no functional change.
> 
> [...]

Applied to kvm-x86 generic, thanks!

[1/1] KVM: guest_memfd: Remove redundant kvm_gmem_getattr implementation
      https://github.com/kvm-x86/linux/commit/87d4fbf4a387

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next

