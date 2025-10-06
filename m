Return-Path: <linux-kernel+bounces-843328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2801ABBEF01
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 20:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D9B3C15D4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 18:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9656D2DF71E;
	Mon,  6 Oct 2025 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zMP98BbM"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A310C19E819
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759775195; cv=none; b=NKAA25LHAAp+Ju6omoE4M6RwsNKc2JqS8SAEIVSb2qFsqV/z1UjbdKuT6CFQVUz239cYmUtIp0MsA8oyNxilhrpUR5tAH3e3yjPNejOnMfEJJhh/JB52zerqAHBKLV2qqmaLKBPMpMcE99Z6kpIAg8X4+8bndFQjFuqpJ6pqY0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759775195; c=relaxed/simple;
	bh=X0sOZMUaWSC2Co+C5hojmaTO19UZxe7xu+zvydubhWI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PaVP/w8jtlV6ssQQlpSSFU1gp/i+EIieETWW/1KLvO9P5fg3LEfeS6Og9FynpY728elZ7gDRuoWpqRGUUyo6yPwFwEdYGHUfRYVJOwpIRBDWgesp75xLr4Zgk5i2ugtODO6lwct0hDAGye71nu32GmSlef93QIvIFf1DcfrmjWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zMP98BbM; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-27c62320f16so51959365ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 11:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759775193; x=1760379993; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YB1IXvHihFuX04lg6CIXT77vtdHIdA5ayJ1ljk1t0Og=;
        b=zMP98BbMe1abmCBRtvUEypDS7Q4bqC7Idh+wJ+i9UQJ5isoeW/DhNKlnCE0BQ5JzmT
         29ztmyBMeTEURPi9LmobIdx2N1jIcLF832g+1KhGhAeujdFZQwWwrPxOANqn5mdouuVZ
         xBx1G/ORJ00r9w352xtI2Nl5o9dXTy+XbSMHsDVO+tysQfR5bvYlZUYxdbp0/QfM3wpY
         pMZLbhtESQYWfzBPAjhGzKLXyTCXUF95d1OQcB4/z1Dbf0ZNeN1hd/jqxC8hF2wW7nvP
         B1J5CfNOGxOqx8AAosuUwfeHZcaR4zMN6dd4qrr+GHjnGvOv5c8YKK+aooBuoKUtH0qi
         ew3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759775193; x=1760379993;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YB1IXvHihFuX04lg6CIXT77vtdHIdA5ayJ1ljk1t0Og=;
        b=L+23zYjXsoGYdc5l2BOAjlOIptq+pACu4W5G7cLb3v0vDFJWnHdVPnCCjlU7K+11pm
         Pe8gign+gf2pCqg5bbhmkyqXhkD5fy8ji/pULVusW+3qwyrnYpZqe/NIMUb+GJS23hHY
         HauJepi4rNxjcbYW/Vf6sPfwF2L7xXZfrWtz8pvBovHgLrvqBcMR9sVL94/I/d+j88k4
         3GQWWl2k3oI2s0bpKvaALELRD1hnw4W2o7Ej0DxQ/5tX22bwAXQZ2Og+QdY1xwM2lj2R
         5HycNySUrwhSQIpnWRraRMPK8QRTdnRv352idk9LTv/hgQKOcM37tA4leTsP/TAk0PVS
         eOrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWddQc5R74mZMufKKctfuAuP7WM5MLIPdHcX1dSV+n9t3oIqa7RWUjo+POSw+4PropV82FTAcD6itKixZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9F1V+g17NzRR7kjouvY3MyNhSAkXVtL6PerTGeTbcC1EfSd4z
	NCg9wD8VUjI1zqJhEyX5qLJ3SOtTjh8GS3bKRnNTH+4iZlRI82ymfRFAzG/2uEnxAS74cBwxycj
	6g/+tNKDeL1R3AN0oYpIIa1dxOQ==
X-Google-Smtp-Source: AGHT+IHElpwNO9rtmCU4B3pLi9Ye3Sml+4MFucjmj9yz1EOyW7YL1umfBBHW7wJ3NF91C2V84fTYHWw9sbHl+kVqog==
X-Received: from plsh6.prod.google.com ([2002:a17:902:b946:b0:269:ab8c:6531])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c94f:b0:269:9a71:dc4a with SMTP id d9443c01a7336-28e9a648547mr152043045ad.41.1759775192854;
 Mon, 06 Oct 2025 11:26:32 -0700 (PDT)
Date: Mon, 06 Oct 2025 11:26:31 -0700
In-Reply-To: <20251003232606.4070510-13-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003232606.4070510-1-seanjc@google.com> <20251003232606.4070510-13-seanjc@google.com>
Message-ID: <diqz347vga3s.fsf@google.com>
Subject: Re: [PATCH v2 12/13] KVM: selftests: Verify that faulting in private
 guest_memfd memory fails
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Add a guest_memfd testcase to verify that faulting in private memory gets
> a SIGBUS.  For now, test only the case where memory is private by default
> since KVM doesn't yet support in-place conversion.
>
> Deliberately run the CoW test with and without INIT_SHARED set as KVM
> should disallow MAP_PRIVATE regardless of whether the memory itself is
> private from a CoCo perspective.
>
> Cc: Ackerley Tng <ackerleytng@google.com>

Thanks Sean!

Tested-by: Ackerley Tng <ackerleytng@google.com>

> Reviewed-by: Fuad Tabba <tabba@google.com>
> Tested-by: Fuad Tabba <tabba@google.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  .../testing/selftests/kvm/guest_memfd_test.c  | 26 +++++++++++++++----
>  1 file changed, 21 insertions(+), 5 deletions(-)
>
> 
> [...snip...]
> 

