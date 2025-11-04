Return-Path: <linux-kernel+bounces-885267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B219AC326AF
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5E35934BC8A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F00265CAD;
	Tue,  4 Nov 2025 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G6ql2ZHb"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB672FB61B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278407; cv=none; b=Zna4HzV8bIBlsjpDUm+H7y3rPQ21UzKD8NsqWkChK+No7+7dERJXT8SlPhMBH9HmLMlV0o8t5qVyM9sXa9IYMGGLBy4iu0QeXVvbIRbkY+FWwrGZ6UFUPKidFFVsP66BZ8DHE36ieCRwO486RHnNUpr6faoWbzyAmG2/spcWj1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278407; c=relaxed/simple;
	bh=yB3/nOCSolZYFw3NqOCpNhBq8JwPtYbPpdL4/GvIScU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JhZCVmK6L2VTWXGVPLpTslnlcGfd5ViPcg7Kv2Sbkm515zPKJz/3kDlTHYTEF9Q2y9aoz/uyI/1oCS8ox97BG+fai28KoUc4InXxYCtFj58GHNdkSCjv1EsFjio3UyiCEE81AMKb563mH96rKzQ2eWyeJdKMC45UpBWfKLabhgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G6ql2ZHb; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3405c46a22eso6167516a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 09:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762278403; x=1762883203; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9zBNdPZyMQiDMIvVQuzjWZpTv+5WuzG3WL0fRvU8okA=;
        b=G6ql2ZHb3scuDi+/AcJeNTwDMAzSG1pCmV2PEgO/ruCKPwWArN8dpLLoBV8ZGt5h9d
         K2ld9UAb7GOgunAH6I0jcdcpq7dAOTUuDp96ij+HVwjO6ScOPKCmg1g4jwjJU7q1cAx1
         dsO8n7F3IRNjSHsxpGzQBKSBYvybTbkjhhH4Se/RKaAoezoVWaDWNjQ0bBaUnyylEkb2
         jycjuYHSzTPUTsvIbYpZZaXICNenoKq7N0/+SV4xIL+d+JhPlNO5rJ6nQWBP/TJcHykl
         D2PlCo4jThY3P+ql1QI/stOf6vJg3Wufe+7lA9JYwoYkypdD9hsnrmeKaMHeRNpLkKNO
         h6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762278403; x=1762883203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9zBNdPZyMQiDMIvVQuzjWZpTv+5WuzG3WL0fRvU8okA=;
        b=FU//USqzng4nod/bo0MBUHDBh1L8diLEGW2E77vWQvGmp2LTre/K2F6zAiOiT33ULu
         +GtnorLhTAGaWhFA7EDUcHD6feNIB9Vx2yBEVzGRJAahD+xZs87oQleQiEfoWwcmmj++
         aNJ3n52yeGWDUek70GEyr9HTnkUZQth6Mq5Wbz/Uy0ZSrJbxIUjCgk3fzj1jwX60CJcP
         Mc7EPUP8HIAlv7AE0NxoMbO0JYirsJcA3hJQVU9O2zPP+9Gb2SRHxGjTrr4xorJltGzr
         eryJIWRETkEP58GGlWZGVAMD4rTQ/sijib44R61NlBYhJcLqFhM+2fAeVtMQ/eHmr0Zi
         MBQg==
X-Forwarded-Encrypted: i=1; AJvYcCVWMkAqm5eKmwTEknI8g2GYQObH6e0SoABDbGEuR9tBMeVHt9KggaiR93UREGnAJejJJlvKaY0LNk4vj6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+9SEmyR7iwNjTWIgKAZN4+R3sJCwuSHcUrglZlj5L7YyyY3v3
	JRhjgvavjXYXVPypBUc2EdKzzybIZNQtEXsH0ZXDX/RX4p0QbFownDS7XdNUSdqfV8122r6LNKU
	SHnt/OA==
X-Google-Smtp-Source: AGHT+IGjNvNGh/Lh7x+2tqDDFgx64vRukJdu/nBZBUQeHayzMYjsqpnHxZxrhnzLZk7wroIFbYfjk7cXRdY=
X-Received: from pjbms6.prod.google.com ([2002:a17:90b:2346:b0:33e:384c:7327])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5281:b0:340:5b6a:5bb0
 with SMTP id 98e67ed59e1d1-341a6def359mr27137a91.26.1762278403491; Tue, 04
 Nov 2025 09:46:43 -0800 (PST)
Date: Tue,  4 Nov 2025 09:45:02 -0800
In-Reply-To: <20251016190643.80529-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016190643.80529-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.2.1006.ga50a493c49-goog
Message-ID: <176227791321.3934009.13375648150137883983.b4-ty@google.com>
Subject: Re: [PATCH 0/3] KVM: SVM: Unregister GALog notifier on module exit
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 16 Oct 2025 12:06:40 -0700, Sean Christopherson wrote:
> Unregister KVM's GALog notifier when kvm-amd.ko is being unloaded so that
> a spurious GALog event, e.g. due to some other bug, doesn't escalate to a
> use-after-free.
> 
> I deliberately didn't tag this for stable@, as shuffling the setup code
> around could easily introduce more problems than it solves, e.g. the patch
> might apply cleanly to an older kernel, but blow up at runtime due to the
> ordering being wrong.
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/3] KVM: SVM: Initialize per-CPU svm_data at the end of hardware setup
      https://github.com/kvm-x86/linux/commit/59a217ced3e7
[2/3] KVM: SVM: Unregister KVM's GALog notifier on kvm-amd.ko exit
      https://github.com/kvm-x86/linux/commit/adc6ae972971
[3/3] KVM: SVM: Make avic_ga_log_notifier() local to avic.c
      https://github.com/kvm-x86/linux/commit/aaac099459f9

--
https://github.com/kvm-x86/linux/tree/next

