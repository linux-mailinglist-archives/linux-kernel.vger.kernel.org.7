Return-Path: <linux-kernel+bounces-863271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DF9BF772F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4509B541A21
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1E6336EE5;
	Tue, 21 Oct 2025 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAFwgZ9C"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912DE343215
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061264; cv=none; b=bt/cNG+ZE5FL9K4L5cjackgWZ+as8KJvzgN/vVmNC1bR+aQ43QPT31p+Ou2MTmeAt3JT19UepymK4V1iAgPqayKX67kUavm1Jz1IV+KAlKPhP4t5X5U8lxvcyowsBEKBhXhWUJf39NNyEwHLxOLPpExmDDXqinf09MyqeNZU7eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061264; c=relaxed/simple;
	bh=yzfgr8r5pMONAvielKsS9LR/pZd5xI0u5V4hch38KIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KKtNVa3oez1lMddfO2Ltb+YbQyyxFq0GcicQMFE6emK/EL7KkDuOaJXka4H93Cu8BFss6UYFxIjiU9FscjehSKWPYlcLJHird5CTTt4TKei6VC1BJs65TQhVGGqS4pIz5A9Jiuakia1mV6KTuf1boRb6boaMZK6uI8tnEY+DVMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAFwgZ9C; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33b5a3e8ae2so5589518a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761061262; x=1761666062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aYMOR2erEiUXBTj9UeZLW5gSBgS0b2Pmne/I+g/6pcg=;
        b=OAFwgZ9CS9gKONnBHVTIRPewvoNgj3K875KN6aV+nnvWtTyLHkkWxZPdHISk2NpjIR
         dIzVp9sk1MLpKkedFdZeUp0SyQmUMkS/S0kOiFpnlDHBFv5Mw9X61eu1/NNphJONWGr3
         RQueB03Sv5WX8gPuI00r9fTcHBE9azapqPw5Aamtuf8Y6AR4dVPhbIpOBE96jhVuHJXY
         56EBnMTBm572qzHdY0tUnHOWWGQKPL/blJ5cjjaE7xglFg/juunvi5fcOzp+MWXL2sjl
         xVGaOp9Kvcx72jTJQUh4aKFl5AxyXFhBVOqJOYzwYeesH5z5pcdKXJKnMUgsvKeyCVba
         i6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761061262; x=1761666062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aYMOR2erEiUXBTj9UeZLW5gSBgS0b2Pmne/I+g/6pcg=;
        b=tH0dhVDtqzPIGZDQC89mlUw+I89t4MGiQHBtDM9T5iBBbF5Q0p3WSL8SEisjgDCAm0
         bddiXpNxMntGfCTdO5FC/Yc85k+xttTvEXcTVHF+t4mTWI9JXDQ/Uzrvmv5jVhlx0RfP
         7b24fZNYWraMyUf28pzuys6y9TERkkcBnV8w1nSr9lz+MkMsEeRx7Nq0uRvu4dYMicAf
         A3GBgcbijSzn00rOaGu89ifZ8gNT9iTl5YqnjIe9hB81TCRVxsdbDPwfoxA5aaOIFMun
         Yb260rMuJWvUtL3hZG/r6ExHmagcojegTVbwEEWVK+VvU7DZL4XKe4ZjrQNLnSbNJkxx
         u6fw==
X-Forwarded-Encrypted: i=1; AJvYcCUBOiGrPnyQzAQMcfD0xZQDIviOiRQ1I8cQDd9nplb5/SFxg0FAxV/h6HQIyxni0BBjiq7WRAbowGPZ6Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyCky3NvyaPTmElCT1+h2kKdPW06YRZaS0qheaQWiprT219C4V
	b0IrJ0BGo9V5x3QRgvnpiB8aYnkiWAvtHjN/QL3zLFSj1h1cTnFfT69i
X-Gm-Gg: ASbGncvTKEa99Ma196e+J8B4T1gHrgaLGUjqvWozDuzfBALUIOS/rTxgJYDls3gPK2T
	MYK8hJRtuXlGhvcgiSWOiA8i2kyXztMaDPfujwWBodGzbXRR1mA2dY4gr8+EiFM2O8ql+uesi02
	x5G9CdiDeKRX46kFCtm1YnFjwUIVAZhA5RddAhIi9+0aejTrmtJB/3i152ORwg2RzcvXPq80NCA
	qmMduCeSeApn8ogJ/lKZeTSfexKa20Lkfz2QjsxxYEfEHPOUTXfK3F0+rQ6x3/rCIFhjkaSlBWZ
	FLe1iZWd3lw5aY0yCqDSHf6VyNrdV1iyUZxYTmZjMXrAonpSwKTUd9ctekKp9+sQ7ZZI4K68pWq
	i0a0So8GBPVnEWD1GXni7ifgcVDHa6RaGpPp9wHA8D9Xoe0aAhE2CIyjUnDBv4chXoirEszMcDL
	d/c5qX093upz+fMHpxQw==
X-Google-Smtp-Source: AGHT+IHEr8HED3OjmE1LgTRhk1PAS8obz4w9rYylsSzDH/CIDpOPd8lLds1qMLMc47DP+eJOlpelQA==
X-Received: by 2002:a17:90b:2ec8:b0:330:b9e8:32e3 with SMTP id 98e67ed59e1d1-33e21f08e2dmr206782a91.12.1761061261747;
        Tue, 21 Oct 2025 08:41:01 -0700 (PDT)
Received: from localhost.localdomain ([129.227.63.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de09fa4sm11293742a91.7.2025.10.21.08.40.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Oct 2025 08:41:01 -0700 (PDT)
From: fuqiang wang <fuqiang.wng@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: fuqiang wang <fuqiang.wng@gmail.com>,
	wangfuqiang49 <wangfuqiang49@jd.com>
Subject: [PATCH 0/2] KVM: x86: fix some kvm period timer BUG
Date: Tue, 21 Oct 2025 23:40:50 +0800
Message-ID: <20251021154052.17132-1-fuqiang.wng@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: wangfuqiang49 <wangfuqiang49@jd.com>

The following two patches fix some bugs in the x86 KVM periodic timer.

=======
patch 1
=======

The first patch fixes a problem where, if the next period has already
expired, e.g. due to the period being smaller than the delay in processing
the timer, the hv timer will switch to the software timer and never switch
back. 

The reproduction steps and patch verification results at link [1].

=======
patch 2
=======

The second patch fixes an issue where, if the first patch has not been
applied, resuming a virtual machine after it has been suspended for a long
time may trigger a hard lockup. Link [2] also talks about this issue.

Link [2] also talks about this issue, but I don’t think it can actually
reproduce the problem. Because of commit [3], as long as the KVM timer is
running, target_expiration will keep catching up to now (unless every
single delay from timer virtualization is longer than the period, which is
a pretty extreme case). Also, patch 2 is based on the changes in link [2],
but with some differences: In link [2], target_expiration is updated to
"now - period", and I’m not sure why it doesn’t just catch up to now—maybe
I’m missing something? In patch 2, I tentatively set target_expiration to
catch up to now.

The reproduction steps and patch verification results at link [4].

=============================================================
other questions -- Should the two patches be merged into one?
=============================================================

If we end up making target_expiration catch up to now, patch 1 and patch 2
could probably be combined, since we wouldn’t need the delta > 0 check
anymore. But keeping them separate helps clearly show the two different
problems we’re fixing. 

However, the hardlockup issue only occurs when patch 1 is not merged, which
leads to the commit message for the second patch repeatedly mentioning
"...previous patch is merged". I’m not sure if this is appropriate, so I
would like to hear your suggestions.

[1]: https://github.com/cai-fuqiang/kernel_test/tree/master/period_timer_test
[2]: https://lore.kernel.org/kvm/YgahsSubOgFtyorl@fuller.cnet/
[3]: d8f2f498d9ed ("x86/kvm: fix LAPIC timer drift when guest uses periodic mode")
[4]: https://github.com/cai-fuqiang/md/tree/master/case/intel_kvm_period_timer

fuqiang wang (2):
  avoid hv timer fallback to sw timer if delay exceeds period
  fix hardlockup when waking VM after long suspend

 arch/x86/kvm/lapic.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

-- 
2.47.0


