Return-Path: <linux-kernel+bounces-763582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BF0B2170B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 23:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A409E681839
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE592E3702;
	Mon, 11 Aug 2025 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SOXhcBm5"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650842E2F02
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754946439; cv=none; b=sarMOUSF9srGjqee/LRVQ4erLdkOOG1qXQHpQhOsM48XXogOmPY3IXFtPzNejFh2k6XA598IMErZzYtFE1dSCzwPcNkjcyt8X4OlE8tn7OABMpE0yHYUwjf9Li2xTjDrZ33apZ08wearloBkt7xmOR2ZcU17P78p+59bb2ujuBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754946439; c=relaxed/simple;
	bh=9UHhZ1f5P1CfRUJPW4axdf/Dd2kBUyMHpEb2juaUkjc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c4wRnQAue0x40Rh684Ig5liwINnz+I6mna73Atjqpal8yjfXJA/lu51C7evGynJcSDOJUXasMt2W0ISam1xdro4tGyN9tXRdfL07FTrltrBB7TNfAav+VpgHkgMLtkCiSbJsjcyC5tmQJo1spe1IVb6OUJhMRzljMwChrHniUyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SOXhcBm5; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31f5f70a07bso7535262a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754946437; x=1755551237; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VOk5Q+GgLWE57K5k8hPV5NoOhqeIKKYX4ebtfJIRSNY=;
        b=SOXhcBm5z11tU6ck8S5DyX4kr0SJM1IdfsMMWL06r2XaaZRpoiuufJZ7718F1GXzrl
         IRbhdGUWYxTgwd0HM1NIcn3rJWMdLW91BK3x1WX/vpDhENJuRQdjYBtsMux0+k6MN7i9
         7BqJ/Co0O8UsDokKeTrnmiqOD/2R0/y+9hVImHg9NUr50xMT0xHLp9xLuxPHwrMNoHoe
         h2V4nTKC6C1oMoyo9DrOkSZQoSC/2wO2nZVWQEOnMuipwcIhk8bIRAiVC/4CGidGpHd7
         Lhuzf0g0YSpdD0L0Aho95sMT/Ne8FTlraRh7VsI0Lwi2VD33VuREYLNxuAXxwEMcH/2S
         uFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754946437; x=1755551237;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VOk5Q+GgLWE57K5k8hPV5NoOhqeIKKYX4ebtfJIRSNY=;
        b=TyUo7RNW+0DLDlulPx2kN/kNcBFcO9IFemd54ZJ2Vj04ui2iTBOMX9Nb9rno/a3KA3
         D4Poa2tZ9jfnkanj4DYXWqXTh/xYkF9z9fwS7me1JnXazvbe766+ssq3dXmxzjxLWSfb
         y668NmLgoDUUXIKNstL8FxEuQrgHItUNVjxbD0LlMWY8B0LKpO60rvtDiSvZliVdeuph
         SdMDTWcZlXQ1SRUYqroY7gfyKL2BxLWZ4F5aI57njCfKGRwnY9MPrBjQEO+R4mPEuAL7
         IXwmszl70qDMH9gFHzQTeO8Qy4HVSRSa7MKMVwgHy0CwTaJyE2qqqsPuBOCMidq2O91U
         G/dw==
X-Forwarded-Encrypted: i=1; AJvYcCV/ykyFNDGZTbqVFkeAtIvsGei9/g9jMHjYRybbvP0kk1fevjWVpDgG5HWRe1Vdu2GfM2KiISu4l7HUl+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyICDyYCilrjD8XzvThHWnvHDYvnYcVLpofoxwh9KL9f1VbtYY1
	g72qri/IF0q9B+9YxFAvoTSKNz6gKyCqX1hpOogipG7MEBsi+zjHgxi9rq/FaWmFuHNPYO82yGB
	8VaPyuw==
X-Google-Smtp-Source: AGHT+IF1TYyL40gu00BNbXFrUtZT7DsnlgGpf2vyCUJAoQIA/twn+A4VFtHoQ4UokfA+skRyHSiSWxnWB3I=
X-Received: from pjbdy8.prod.google.com ([2002:a17:90b:6c8:b0:321:6ddc:33a0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d883:b0:321:9628:ebf5
 with SMTP id 98e67ed59e1d1-3219628ebffmr13741990a91.30.1754946437652; Mon, 11
 Aug 2025 14:07:17 -0700 (PDT)
Date: Mon, 11 Aug 2025 14:07:16 -0700
In-Reply-To: <20250807201628.1185915-26-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com> <20250807201628.1185915-26-sagis@google.com>
Message-ID: <aJpbhBO53ujqkbPT@google.com>
Subject: Re: [PATCH v8 25/30] KVM: selftests: KVM: selftests: Expose new vm_vaddr_alloc_private()
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
> vm_vaddr_alloc_private allow specifying both the virtual and physical
> addresses for the allocation.

Why?

