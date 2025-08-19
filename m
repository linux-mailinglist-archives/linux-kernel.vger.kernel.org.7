Return-Path: <linux-kernel+bounces-776629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E685B2CFA7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60063565CBC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC649277CA1;
	Tue, 19 Aug 2025 23:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="actnGd3y"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E740E2620C3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755645207; cv=none; b=TGZfOtpNJDm9JlQ08QeXRfrgyznvY1ntXyldhN+2MLY/3L3cbURIM+wwfRLDf02OwwvVFFUpB+LuETEBYWLL2PJJS2g+JtwsPOWP83nEjzhLWCV5EuJaO5HzfEK3uKVP6CSar1mX+asH32S37ZKHWyzj8T4DWnXWLC7TPRBTIBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755645207; c=relaxed/simple;
	bh=p++GG/ObvF+SS6gDWcAUbzhAmmexypAi0D1ulUdCK2g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c8FeH/Qz18rVdK1zAYs/DVOiRKae5nBXulK/AAxdjNVp4o/Q+yPQiRAuusKKch5/R2Bu1sgy5jNzDLD7EvmP/yU3d9Cht7uOyIXQPyTXfjZiMvvTfU5O2zhgaPmk9q4btPmUUuMjeQZeZEVHKzy3DghGsqzfXjZ3giHXy5C+Pfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=actnGd3y; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244581ce388so132358545ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755645205; x=1756250005; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P2AqbEbgJChiE/jeWfGZrim3Ra7yr8HvmGOhQDLGFW0=;
        b=actnGd3yCrKjoDrW61rmtJzlaKTZNC3l4ezee3UamZAxONX1fGgZVIDxpal8rvrz6+
         bBpVfrk+C9ocYqj5YROJ9wCCAS2lAU2J+/04P53KtDNBzIvxqTG8qdT2cEWZCMMc9guC
         9hPYSwxIgRJc4ftXLHdsGXFz3F/ZyP7k5qvtL16Hzn0Xd+xfgeDDUt7lQZopsQ/7duRL
         AFd1iMLL4t+j4CUuz8mc9STA1uvqsqYaeuDbWhcM8yVs4lAgznJWVa5Jr9mfN5i9WMrp
         4/z7aqj5S0kvFUT/54CcfYvPZhh492rGL8mA2RUfjuYphEtCtq2tfskFTBSJyYiEArRh
         rV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755645205; x=1756250005;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P2AqbEbgJChiE/jeWfGZrim3Ra7yr8HvmGOhQDLGFW0=;
        b=I4XNR3A9hx4fYDAGtOjukeR8qmK0pIpmhb09195IMDhDbcShtSi3qyorHn4OjS0/GG
         RbF6I94J0nK+uRJE3bVlM9wDCMvZj/ZSIz8EASj7BMO8KCewUwE+wYe/SF7OozH0GESa
         xVRziazMpqHo1dQXUa13B2Q/zeRRONQYfZiinjxz28vIyKwhC78v4ViSZSYLavELXY8R
         fBpOJVeQr3yx4f2wKy6dmwzl3CmIyZ3qQb1tlnKBVyGqeS3a8DYmWaDf9/c9Hr6sJxap
         Xq5WRiqbqNT98s1V1YM3GBy8zXoRqnCFfo0IZe7bWvt30yA2gmW6Bth7uHQAQ5qbQcD/
         y0YQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7+ifcAv+R+PDaXqmfXx8KbzAiEDlbk3msPWdRtEdVHC0ZQUKXEU+kFOlBdcfG2ihj6nbI979/4b1OHr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyseGTQusHr5dJ/Bk5nUF0udJzPAfLmsxjDRm/wWhNIx64xsn15
	XGbLnhvHsldS+XrlTsemwFRCu8ylxYK5oI95fEpGMr1U7KMs1/hVddEFmUQtFnTIABEDey+1vRd
	ERMYroQ==
X-Google-Smtp-Source: AGHT+IELQdhlYrR//sHGRCKXtQ83DOPYrULud3cOubQ8r5LmPFAQWcs6NmK7qDt0JhFzp/fYFETvlZziMrY=
X-Received: from plbmo11.prod.google.com ([2002:a17:903:a8b:b0:243:93a:a69])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d503:b0:243:3c4:ccaa
 with SMTP id d9443c01a7336-245ef137424mr9793635ad.19.1755645205360; Tue, 19
 Aug 2025 16:13:25 -0700 (PDT)
Date: Tue, 19 Aug 2025 16:11:53 -0700
In-Reply-To: <20250807144943.581663-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807144943.581663-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <175564425450.3063067.5245793553248033855.b4-ty@google.com>
Subject: Re: [PATCH] KVM: remove redundant __GFP_NOWARN
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Qianfeng Rong <rongqianfeng@vivo.com>
Cc: willy@infradead.org
Content-Type: text/plain; charset="utf-8"

On Thu, 07 Aug 2025 22:49:43 +0800, Qianfeng Rong wrote:
> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
> GFP_NOWAIT implicitly include __GFP_NOWARN.
> 
> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
> `GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
> redundant flags across subsystems.
> 
> [...]

Applied to kvm-x86 generic, thanks!

[1/1] KVM: remove redundant __GFP_NOWARN
      https://github.com/kvm-x86/linux/commit/cf6a8401b6a1

--
https://github.com/kvm-x86/linux/tree/next

