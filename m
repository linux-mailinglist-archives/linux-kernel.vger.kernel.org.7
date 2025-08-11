Return-Path: <linux-kernel+bounces-763342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D67B213A0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3D893AB063
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AD52D4800;
	Mon, 11 Aug 2025 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J3Ebgeky"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9AB22F77E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 17:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754934580; cv=none; b=UUeGjOt83bAVl7IdRLZSLrdD5ydFDDTbHUzZFz/qOapkiLShAKRYd2+eEUvwmFZSU+HeHggyx4EH0i1NHlwzX20GdR+ldV2yUN6rscSW1iN7rCqgHoxebD8Hhsy8EQtzihJWRmYfr9AMsObnYGD/YTcyBzaESpmS1vCxdkyYyIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754934580; c=relaxed/simple;
	bh=wgtuJ3qGsOI6VkGe40c91Wi5hvCn1fqxlC1DYm1KUic=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HNUenVYAL8e/FyzMfkr5VPXY8hGAeUHS2SoLxu4lCYsO1dUFL/V0GshF4CLxJ37HxCgHTfDmW15Jf5/aqEtB2nFHg+kXOiPa77U44GWEaS56vQPxsssFSxZkCReRsQYqoTCvQPycozoRJKa/qT1L6T/AnD4Jhs0cVbB5nr6eK4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J3Ebgeky; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31ed2a7d475so4682585a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754934579; x=1755539379; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rdx4suEvHgUkbqw9OBEtyVD0idjlOMWoCvF1jroUHTw=;
        b=J3EbgekyyHDz68l5QnXYFYOfv36AQDIE+Mql2k8s8ftQk+4f9rPmh5GJuEA1YgZw3u
         Wolcf6GEtNBQUaRPaWZ3yLKN31123kwZHPiJgFqdWfxTe+Wg2ZoGLQbc2U2BGVQXTj7u
         baUo/2JzqkvXfutujzwDamjXE1mOFFVTFiqDBxayl6lo6LCS+DdkuQ7VK4xbhLqnbEEA
         r0s6HuXjht7HJdFNsWB2+Kcc2NNK6HDwcGPTxx7LSUD+T6ZWA0P9hI/W+038HBPRcTds
         VNhxwWf24uZYmcrLymqvCu7l+ORZ6Ey1EpL6abe+T6PUFrp//QmnlOhnSE4wSbI+laXm
         oWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754934579; x=1755539379;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rdx4suEvHgUkbqw9OBEtyVD0idjlOMWoCvF1jroUHTw=;
        b=GqTgpRV28hnarPL+oJI6x09KlsU4XJPQdk6TesGgNmD9vPAfwWzIULeT05qdbCIOYS
         hvJHp4FWobo1wPbX7YqOyPPe/CpkppSWJsxJ2iI+19a3ga49L5cIELg958LQGhkRWnxy
         GUCDxmPSd2VrrR2m6KCprC+HdpeddeO4ZEezye6qYhbT4UXBiubYOinhRfObECjxI6ZP
         zlAQHk5Awt24MmVOwDiKfPAy8SheOWTpUiks6+l9VodgbA7vdOZQGVmFn+xS6PQaLvcL
         lR6mR+BGWRh6dJDpoLmAwb3RdlZPll05xpV1Nvn5H9ZB9Yw+BZoW3b1O2VAz9wWxM458
         5miw==
X-Forwarded-Encrypted: i=1; AJvYcCX0LvYhht96ysdtUQTNz6VhWHyJQgIvYftKLdLbKa8zHOoUB91l9U87jKmrjsRszbtpLgmKouEflfF21ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOUlaFf0bFAOWW4TopWNE8aI3mP7oSlLnzAz7+jI+QWmI3rLEq
	p+ma/JiIxZlUDI7xwInD4R45Wv69hpxyesQ1MBfuwcYmPddRHsRAib0YUpIsK1nPOHgeJpsymRJ
	teYuO5A==
X-Google-Smtp-Source: AGHT+IGlunZy66OQUvv5RPhL+BJ3Eiuf5E4Thqz5UoZ5gcFYAYBaCpzS43jTnnFPTbdtgfJ1zOO+jx0//TQ=
X-Received: from pjbci4.prod.google.com ([2002:a17:90a:fc84:b0:313:242b:1773])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b8c:b0:311:ff02:3fcc
 with SMTP id 98e67ed59e1d1-32183a0345amr19073444a91.14.1754934578696; Mon, 11
 Aug 2025 10:49:38 -0700 (PDT)
Date: Mon, 11 Aug 2025 10:49:37 -0700
In-Reply-To: <20250807201628.1185915-2-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com> <20250807201628.1185915-2-sagis@google.com>
Message-ID: <aJotMWGzChQq41oz@google.com>
Subject: Re: [PATCH v8 01/30] KVM: selftests: Add function to allow one-to-one
 GVA to GPA mappings
From: Sean Christopherson <seanjc@google.com>
To: Sagi Shahar <sagis@google.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Ackerley Tng <ackerleytng@google.com>, 
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 07, 2025, Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> One-to-one GVA to GPA mappings can be used in the guest to set up boot
> sequences during which paging is enabled, hence requiring a transition
> from using physical to virtual addresses in consecutive instructions.

NAK, this is an extremely convoluted way for establishing mappings for hardcoded
boot ranges.  Just use virt_map().  And if clobbering an existing mapping is a
concern, we should add an assert in virt_map() to verify the address is available.

