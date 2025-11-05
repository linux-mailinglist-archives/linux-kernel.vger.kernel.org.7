Return-Path: <linux-kernel+bounces-887290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A670DC37C1C
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 21:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F61E18C6168
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 20:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4159134AB1C;
	Wed,  5 Nov 2025 20:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h9V17CSe"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBE42F28FC
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 20:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762375060; cv=none; b=XJxG4lLImSvUGJfvHJ0f3gQD6+yKq+S+T55qAF1hJMmvjJ3aLkoOJin27sckF5P2tkxzJQBKs2nd+BldO0OBxsNVhmmQDTWguOZiVAdmJItPp7wnMSfGJk4EUliWP4mPKcdlStwqbT+3Yiz/B5DQYOwxwThftK/A8FYdOyupZvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762375060; c=relaxed/simple;
	bh=/dIXgKrc7kWPivNtkWF/fsWtXetBOX0Nm3ORbrdX5U0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oLhy9xzYQAJP/gA5oGQJZ1dpfrrJ9pt41+sBCF/y9PrvqA/BWF+go5CuDHaunVvMv2qlGnV9PCkjq7i190uqJip3XsF3kDu3MouErNjlKDJ26cRwYlsuRAFYKJbDik1Ipk/EbxlSphIG/jy2TTSXYXZrDMCEgN4RUpmXTaQrj90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h9V17CSe; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b9d73d57328so164670a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 12:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762375058; x=1762979858; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8kswFulOYsNT/YP4oovgUt/1YW5XfFHpW4akALi6SPw=;
        b=h9V17CSeOAQn/0cWL56dA0DnNJEZR/lOKBrdsi1QF8/ADtAbqD0fJlVn/0LKpEkkhL
         9+Q+oOF6xXWyvEiA354tAzO/bEQPs1pAwt98qtcuIw8XgzTmdmowPceSZwS+3Q64RCZA
         /FbD9ZiNn//daZK4vOFy3kk+pPkJ/hnfQQRCT9wGiYGV+GRN5wp7X+JClEcLRMeWWuMd
         N29n8ifTK8zJQpu97FKrh3MQ1sd3tS9N87Ze/aV4GqZZUGws6dYy4z+CH7DivtegrL3w
         JXH52ZPL9GvF0uJ6g0L8pv6Sn/vf/J2Fsm52Vv1QQBZ8cbrHXt3TvkoFuJZJhlBXL9Ib
         2gZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762375058; x=1762979858;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kswFulOYsNT/YP4oovgUt/1YW5XfFHpW4akALi6SPw=;
        b=JvS+msEu63fZUk8iTPoHGeNJvSXcQTeLlwefe6okFl3LSRda12mlKP3npQL3tppO2z
         HHYzmyrrI7zXqczM0N0M+DomuZWpgQOvlXQsvDyDRularuF/140BCCFwbqANyevdcaiw
         S5CRFiegKlLDM5uuDg1RLr2R5EA16vsbQmiF8+alhvbRkOs5Okmvo7mwwWgLKyJ4xnNH
         KpSlzvYwBNk5/xdff61zTgB82meOpiESeazAzyVAl/T/HhB6+ZfI4ONNRZThvFBMYeQj
         p9HuCZvJ2UbsQbqB3cP098hYiSgdagbycORQHmBHJ0juuYytsZTj7sypOLPwRnVdbkGc
         fKPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt2wqTyWLYUaqfoZitVGjvJzg/mmBVZrECdSKq8/jCPxezJc+4Ri6GJYAVA1dise8K64Gwiky79LehaL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGU9ur01Y5AlVBNuuImOTT7Rl20XFJNdz8gr+QXj+Msb/EN/az
	xv53LX+B+pfDXTBG4gKip2+4V3KwVPM/3xzTBPQS/cXU6GVRW+8i7N8aZRAVpJoCAp9pLMZeeYp
	7/ruZTg==
X-Google-Smtp-Source: AGHT+IHSoiymoUpGD1MQPckL3XwILZ8Xl2FA43nDVPbvC4+E+3NwwFFb1EKUYBPhlb2y0RUeDJZEG6dMRL8=
X-Received: from pfbml5.prod.google.com ([2002:a05:6a00:3d85:b0:7a6:ef83:8937])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:32a2:b0:34e:d62d:9dce
 with SMTP id adf61e73a8af0-34f854eb560mr5245526637.39.1762375058468; Wed, 05
 Nov 2025 12:37:38 -0800 (PST)
Date: Wed, 5 Nov 2025 12:37:37 -0800
In-Reply-To: <ek624i3z4e4nwlk36h7frogzgiml47xdzzilu5zuhiyb5gk5eb@tr2a6ptojzyo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024192918.3191141-1-yosry.ahmed@linux.dev>
 <20251024192918.3191141-4-yosry.ahmed@linux.dev> <aQuqC6Nh4--OV0Je@google.com>
 <ek624i3z4e4nwlk36h7frogzgiml47xdzzilu5zuhiyb5gk5eb@tr2a6ptojzyo>
Message-ID: <aQu1keKld2CT0OY5@google.com>
Subject: Re: [PATCH 3/3] KVM: nSVM: Avoid incorrect injection of SVM_EXIT_CR0_SEL_WRITE
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 05, 2025, Yosry Ahmed wrote:
> On Wed, Nov 05, 2025 at 11:48:27AM -0800, Sean Christopherson wrote:
> > On Fri, Oct 24, 2025, Yosry Ahmed wrote:
> Looks good with a minor nit:
> 
> > 
> > 		/*
> > 		 * Adjust the exit code accordingly if a CR other than CR0 is
> > 		 * being written, and skip straight to the common handling as
> > 		 * only CR0 has an additional selective intercept.
> > 		 */
> > 		if (info->intercept == x86_intercept_cr_write && info->modrm_reg) {
> > 			icpt_info.exit_code += info->modrm_reg;
> > 			break;
> > 		}
> > 
> > 		/*
> > 		 * Convert the exit_code to SVM_EXIT_CR0_SEL_WRITE if L1 set
> > 		 * INTERCEPT_SELECTIVE_CR0 but not INTERCEPT_CR0_WRITE, as the
> > 		 * unconditional intercept has higher priority.
> > 		 */
> 
> We only convert the exict_code to SVM_EXIT_CR0_SEL_WRITE if other
> conditions are true below. So maybe "Check if the exit_code needs to be
> converted to.."?

Ouch, good point.  I keep forgetting that the common code below this needs to
check the exit_code against the intercept enables.  How about this?

		/*
		 * Convert the exit_code to SVM_EXIT_CR0_SEL_WRITE if a
		 * selective CR0 intercept is triggered (the common logic will
		 * treat the selective intercept as being enabled).  Note, the
		 * unconditional intercept has higher priority, i.e. this is
		 * only relevant if *only* the selective intercept is enabled.
		 */

> 
> > 		if (vmcb12_is_intercept(&svm->nested.ctl, INTERCEPT_CR0_WRITE) ||
> > 		    !(vmcb12_is_intercept(&svm->nested.ctl, INTERCEPT_SELECTIVE_CR0)))
> > 			break;
> > 
> > 
> > > -		    info->intercept == x86_intercept_clts)
> > > +		    vmcb12_is_intercept(&svm->nested.ctl,
> > > +					INTERCEPT_CR0_WRITE) ||
> > > +		    !(vmcb12_is_intercept(&svm->nested.ctl,
> > > +					  INTERCEPT_SELECTIVE_CR0)))
> > 
> > Let these poke out.
> 
> Sure. Do you prefer a new version with this + your fixup above, or will
> you fix them up while applying?

If you're happy with it, I'll just fixup when applying.

