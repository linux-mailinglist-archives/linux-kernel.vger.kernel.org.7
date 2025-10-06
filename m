Return-Path: <linux-kernel+bounces-843330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8BCBBEF40
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 20:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F876189BCF3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 18:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C402DC328;
	Mon,  6 Oct 2025 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/mRPlbj"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56692D979F
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 18:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759775286; cv=none; b=EFX8V/8xE5A4L5FLaqbnUTrzDDWxGjmger8XVo/KJTOFmD/YtQEzqkIGyy13ZS+/vjWktqY0NN/P2HOFFHzl8ufoL5TUV4d49FIEi2lLbMv0I2LZBanjmhihdMcSGElHqeKPtscqm3iEVxKxE1cARGlDiK1YwYcpL0lYIYSDgwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759775286; c=relaxed/simple;
	bh=iByJ1fVscW5W4F+cs4ecy8OClDdYZUUN/XybSiZqT30=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KuAAhySkko95+3IzqCNtFziLtiEPo44qiCrZawGAdWi6v+WX+r/fSXnHIKh/LKPEkrcYEnP+LgFWp0EPP5o5Z8y6WSkkcFo5EKV4NQSsJvchzDnEYTwpbCEPGAePmLwsO0AiN4Q9DbX1m2cvxugcHcfLEtzmJ/5A2eM+oN92djU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S/mRPlbj; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-339d5dbf58aso4958806a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 11:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759775284; x=1760380084; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I2O1LHrnLayz3jZMtWyP5NedHNDuE0QV5RRuTM+R5JU=;
        b=S/mRPlbj+bgh+ckLGmal2K7BHmfkKmsZYQGCHr6SCDZZSyY6ebG/Ri3lUBwWGHnIv9
         1wKF+gmRTs+XPgMSV8Ajq50bJEtzGFUuKTMcUF9aANpDFPmUBKzO7BhP4lLhFLS43tcY
         /MMT4Bm5o0mPVV0kwXSQGQCG7qMZnMJ9durzGKnTDwZD+Kod0DpNze/IirkK0oCpPmeK
         9cXu8LqLE/xDP1Z6qr/6pe7QkeDxf0Tq5LCjLpZduyT2R8l+DPM0LkCJicI6t8zVWbLu
         rBxTWBeH2dT3fEQZApeMMA2FITG0m6NC92FvXBSXZSvrGSc7QmHAy42rNX0H7+AnYwaE
         rTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759775284; x=1760380084;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I2O1LHrnLayz3jZMtWyP5NedHNDuE0QV5RRuTM+R5JU=;
        b=MX2++Gn7DKPPJZtygRQQHfF/PJJDOchca4SMm1j9bCfp5P85xgoSwNFyNrZymuxznT
         q9pTpXOIxdgGqiLD6TgcRA+oOkvZ3YpGnsH5vbvopowIwiTnKT41DVprjwq8MCCPl1EZ
         JB8Hgha4G9QOIweLsE3LicoQUnJpJli/+h4iUkYfHxsxH4qQ80aFRf7/gjk8cjxsNo0L
         iTOGiWVUMMOE5p9PpUXe3SA6IHhlTeoM/bhDdVKuOuuR07cl7EI6l5qzul27FPLuLHLQ
         as/mCVysL4IDpG/2WSlGDyTQ8pxSa6G1XxYHdWSLLi7JdG0NQx6M9MCTE+WQhXH2GzTZ
         g4Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVsbPCIjw/Gg9EY0Lx/hXzMRj6DQE6G/ztm+SDHoo1Cl9/n3wUsaoSZbR07S6LMsSqck8e6tXAHNzLPTWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwgj0yTlVPiBawz6BBbjDd5H0QCdJtHPtmE6h0v6hTtFsb3YIw
	KZFE6xi4BD7ZIDz1gUnwTQ5NYClu8v0h/FefFujMxbFCTjIVLHMxyMIzltia1+//6VZXD+11/YG
	QZN6XuVe0UzFwIzHIVxRHznbseQ==
X-Google-Smtp-Source: AGHT+IFMJwLBrp2rEMeLDG14yNkzmKPoVFGBhyV1fkq3ZMxYnmCJvU/RuM1xX87pM3P5FVvM9FTSiXQVKcBNV2mrfA==
X-Received: from pjis7.prod.google.com ([2002:a17:90a:5d07:b0:330:7dd8:2dc2])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1a91:b0:332:84c1:31de with SMTP id 98e67ed59e1d1-339c27b6a6emr16543901a91.25.1759775283663;
 Mon, 06 Oct 2025 11:28:03 -0700 (PDT)
Date: Mon, 06 Oct 2025 11:28:02 -0700
In-Reply-To: <20251003232606.4070510-11-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003232606.4070510-1-seanjc@google.com> <20251003232606.4070510-11-seanjc@google.com>
Message-ID: <diqzzfa3evgt.fsf@google.com>
Subject: Re: [PATCH v2 10/13] KVM: selftests: Isolate the guest_memfd
 Copy-on-Write negative testcase
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Move the guest_memfd Copy-on-Write (CoW) testcase to its own function to
> better separate positive testcases from negative testcases.
>
> No functional change intended.
>
> Suggested-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Tested-by: Ackerley Tng <ackerleytng@google.com>

> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/kvm/guest_memfd_test.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> 
> [...snip...]
> 

