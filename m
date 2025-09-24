Return-Path: <linux-kernel+bounces-831107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F24BB9B8E6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 023E716C2F4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B443191DE;
	Wed, 24 Sep 2025 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fx6/HPyy"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F0D313D5C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758739488; cv=none; b=FZ6W2PSHI+P2ZXOngY3KjZB1OEHWT41eObXvfTT0Ee8TU9CWMnd4YQLL1EAStnaMRCh12QxoVBLg797MY/t604Uxjlut6ZsZ3XFCKhel3oLEK4QoW7fqEDAns+ufNtm2hKgymufw2AFJixhj7SY8tGLIVMmsTaF9gULZlh8sv2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758739488; c=relaxed/simple;
	bh=XrKYdpCzTJitBfTH7h3tMpzc9gUATsq6f2r027mR+Fw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UGkH8PEIMxbDGED6vP5UsCNyisCpRRRLsySkhC9HX7Ugc2RcFN7INdQtg+hFloJwsa9ydugbO/XFDtvcB+Tq35MEMu1ILV7OHEShGANrBXNt2NfOoGeibJl8b+F/HlDUjeQRgDNLlQ0Asl2swZbjon8fxGBuC7wAufugBnNnDf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fx6/HPyy; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-25d21fddb85so1641855ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758739486; x=1759344286; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L4wsQZfmoQA8Yf+bei6HdCOLaw6MvQvAF54nH254qZc=;
        b=Fx6/HPyyUpLi6odSFMy4Pt7HL+rCrPAsw9jD/NCC4YbA8ISl4/8HBww6Fjbzw2NKvK
         aCOZKZwvRcCNIc3Q8OWEebEDx7/da1ukqghYk6E/F77HJhb/n4SWwi8fug2MSmkkuuA6
         v7Duervm2Zk8mV9erm0yPCsTtK6vO3OeV7HNoWUlPfQHlPuquihNczNnuNT23tY9ljkP
         e70cdlJi6KXpBQJPa7lFcERGFong9ldIZmtWKYz1RIKbPZHffTDSp++qS6aGOLxPqi04
         nMbnlvfWpnY4eVvuILdEIO5+LGFpIxpX+APq7jcJVAW4wSrgQPu2fhGCsf7DK7yGHcIX
         96FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758739486; x=1759344286;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L4wsQZfmoQA8Yf+bei6HdCOLaw6MvQvAF54nH254qZc=;
        b=ax/ou4VxG9z0/mQWfHo5e6/+JHvyKN2mhsJlS1/K1mENfIAfVamYPBvG2wNxaUwtvF
         nBlGrjDMabIXU05bmeJAwwFhT2/DoEmXwsNMAZT7t3xfqQQ7jVBGP9V6i8qyZ+223oJI
         ZACtsU+js8YOwfKXVovWYqLb/o7KXKyhxxx5J95zagErg53ZSz/SfKGXsOvGVgIfOJ/H
         XYQRCKua+C+agwzD0uiZGm3ULNGBidpMTub4OBacBjKDVys+mhpD3a3jbUsz3AazqvUJ
         Cgt0+6+LEvTNir89CzNUtCorrKYfjFRXcXwFBUywG4OuyUyYyxoNICvDQYfh82oQX+5+
         gFyA==
X-Forwarded-Encrypted: i=1; AJvYcCV3aQ6CFX3Dh6k0JDdclzoA5ExcHNzyN7Cw/U5y5/pwECO0O/J5Igeh4r60eNuAhlt5N1tP6lyXiMGW6Hw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl2MTOm5BNzbYc+kG4xUACiFG/63/sWFcLX0j4z48zvgPPgvoO
	xuZtdZ69099I00oSce+MPvjFCHX+L5lSyQl6JBVdZn/wmGS/1Kc5fK7f6vgDnXZ+qNr9bVPzD+8
	uNruNGQ==
X-Google-Smtp-Source: AGHT+IGKhkRu8Tnpm5tsgJtAbgTyL1XLOvAwUGapjYL4K8zGN7RqMAnR/PaO0GD5m9zp6FYgrHnhaRE7GZ0=
X-Received: from plbkw4.prod.google.com ([2002:a17:902:f904:b0:269:ad1c:3698])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1209:b0:267:44e6:11d3
 with SMTP id d9443c01a7336-27ed49d2bf5mr7779945ad.21.1758739485753; Wed, 24
 Sep 2025 11:44:45 -0700 (PDT)
Date: Wed, 24 Sep 2025 11:07:41 -0700
In-Reply-To: <20250919211649.1575654-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919211649.1575654-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <175873636645.2146220.17008570618264199146.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: SEV: Reject non-positive effective lengths during LAUNCH_UPDATE
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 19 Sep 2025 14:16:49 -0700, Sean Christopherson wrote:
> Check for an invalid length during LAUNCH_UPDATE at the start of
> snp_launch_update() instead of subtly relying on kvm_gmem_populate() to
> detect the bad state.  Code that directly handles userspace input
> absolutely should sanitize those inputs; failure to do so is asking for
> bugs where KVM consumes an invalid "npages".
> 
> Keep the check in gmem, but wrap it in a WARN to flag any bad usage by
> the caller.
> 
> [...]

Applied to kvm-x86 svm, thanks!

[1/1] KVM: SEV: Reject non-positive effective lengths during LAUNCH_UPDATE
      https://github.com/kvm-x86/linux/commit/5b66e335ead6

--
https://github.com/kvm-x86/linux/tree/next

