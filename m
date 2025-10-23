Return-Path: <linux-kernel+bounces-867800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE91AC03859
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 23:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B39394EFC91
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369422C1780;
	Thu, 23 Oct 2025 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUs7fhCJ"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D8A2C15BA
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 21:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761254618; cv=none; b=LWQ89YgKgcRxnWM+Zia0AfE1s7oUsq7rRrc5O5eFem8Ng2KF3t+idOQ8VxjQPyQlw9YnOOvRnJ+XDtBvXqIAL+jmAgDlIUZQQNG4F1HbLXaxy1xiYDj5Bp58Kn5KNQgFuIasmSnfyWTmQ9OU2ZIW4XEJGi0gtlt/GR7RjsLI5AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761254618; c=relaxed/simple;
	bh=meYvtrmKv07gqrmwodd3FByMIYqzsBgP0MII/Eai7M0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cDtIphQTEkZOreStB7E3vaSZv55Cuzwu/6JUPTPvJuZFOO8BsA9OhYe0PjowM0QORQs4cQ/q3+1TTSsJ4aBxkVuj22iECObfFs+BvTY5TFY37fBGP/xrPp9AffKkVAX1Ow+YjDtgap4tb/I+FuFQiIkDtEng8fot7Kdmta3zS+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUs7fhCJ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so959347f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761254615; x=1761859415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qne65SiazIyCHeItNfpA60F00OPSmb7OGxSP4ODT34k=;
        b=DUs7fhCJQlEf9d5BdULUEhAlgC6LbgRTRLwMgwrOW+SUHZDj4SKFlA+VG59EzBtRs3
         mX54oaLeTHbFxXp+px1nw4NZYYAVsjblbfebW4SIopUB7u6uyV/hni2ne7nF+nSNxZvt
         TSpNiOFeE0qjze6Sg8fX+3FhtR1S/3g29fDGeHoarhJFAYK9xWKCfMwbKWR5DwpQUX2n
         qyuwTmxspMRc9NrIT0vfqh7gjQKcJWMRoAEvj7V6Cku2+LbeW4DM9llcK9GO9a8TiE0l
         Y2jXwjmoQcCXi9yFIez6NaWF4LzI0t7MhbZJKrKC5WGVcpZEyCDa76CmPeCz8moCv2DS
         hHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761254615; x=1761859415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qne65SiazIyCHeItNfpA60F00OPSmb7OGxSP4ODT34k=;
        b=Ee+uAx771fEVnt1rb3OcnLfBnRct3JlLsgQ+In1Vrw1Lwwc/pshkrCOp4pBqrL6KYm
         437a80kfAUuapD7aofogJxH8I8jHPuFp3XzFJkvyE0bbwl4qpHhxF2hyYJu+yLYWNQsS
         lCE7Xqb8LG3mll+xTnyXJK+q3JkZ4pBVQI5ferLcE+0JJW3gU/J//KuNk1QQr2BuRwRo
         v7P+M8i0Xl9V/qT/1tMoRaej6qa7fXZLajo1kgqy6ovvkgQqcHZeeErpihIYbOzZ8qm6
         1ZC5LysmfotWdHC4PKBGZ2mkYP95MInKdb64P/+PdRQolkDgaHvznhzUWga094HFxaE5
         Ld9g==
X-Forwarded-Encrypted: i=1; AJvYcCUzgtDaELa3qjWcyhSflIqp2khMsjqsBQnOWV7gidQkCUPBSoHSc7hnsQnh/MH5J9TV105TdRTv2oXs68M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXiZc6/TE0B5b8t6Gajy/J+6mpjy9WSlv2B8MaKcdM/G3s7BMV
	8PLQG39ZF4R1Jf78Gb+A8sPcOeBAhGFNPMhaaNhS4VmezLu8x8oh1Huz
X-Gm-Gg: ASbGncs/oCVr+fBN4taWe/PGryEm9tqX/vRF4XkahUV/53mggCdIfA9otkkp6cjamzI
	N4jK6MwvJBLAtWWkxigeDLrHfCKGZbV7br/7AUeJEi018hagSRT+myt6/drhWpypTCCfS+KBeW5
	AdWFrbXly787qYFI+rD9/PXNTO8r7Xg7/NCVdlInX3qEIFRR/QLEalfh6LP1CtWZ05YaHLWyriW
	0W9iFvX+iB5Ojxyo5ycjCFGuklmIKo2SgTjpQgtnO4pIbfqzAD6SwGpecdayfeASCO9HW1yC2fS
	sFmINl1Yr/jTaWTvtdDIaqtCkks31Tlfbf5y3KxyeuW1ao/YT+SmQylP7Dyw0rPRqXKmILmLkRa
	vogbifPNJRm8kdE8FT/GGsmwtGUJLiA873I3fqqRd8Sto8rWqFJD4UYqY4jBcxZdYhC6sWK/LLA
	RCRzimMnjD9cufSin9INM9W6rE+vs+VPbizhAI0OS/jg==
X-Google-Smtp-Source: AGHT+IHx7WDbJNbP1cnSbn4DYejOjoPTrKfXZg+Lp+yzBAu3G9kkLDxwpgQJGIv5tmGyd4q9MNyGYw==
X-Received: by 2002:a5d:5c89:0:b0:3ec:d7c4:25b6 with SMTP id ffacd0b85a97d-42704d78abfmr19670558f8f.27.1761254615378;
        Thu, 23 Oct 2025 14:23:35 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897f52aasm5709612f8f.12.2025.10.23.14.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 14:23:35 -0700 (PDT)
Date: Thu, 23 Oct 2025 22:23:33 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Kaplan, David" <David.Kaplan@amd.com>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Alexander Graf <graf@amazon.com>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 40/56] x86/alternative: Use sync_core_nmi_safe()
Message-ID: <20251023222333.4cac1430@pumpkin>
In-Reply-To: <20251020150133.GK3245006@noisy.programming.kicks-ass.net>
References: <20251013143444.3999-1-david.kaplan@amd.com>
	<20251013143444.3999-41-david.kaplan@amd.com>
	<20251016103549.GD3289052@noisy.programming.kicks-ass.net>
	<DS0PR12MB9273D987B842D9E80081261A94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
	<20251016144730.GC3245006@noisy.programming.kicks-ass.net>
	<LV3PR12MB9265DFD04F0F17DE7AAF204994F5A@LV3PR12MB9265.namprd12.prod.outlook.com>
	<20251020150133.GK3245006@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Oct 2025 17:01:33 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Oct 20, 2025 at 02:49:56PM +0000, Kaplan, David wrote:
> 
> > Coming back to this, are you thinking we should just create something
> > like 'text_poke_sync_core()' inside alternative.c and that can use:
> >    1. SERIALIZE (if available)
> >    2. MOV-CR2 (if re-patching)
> >    3. Else, IRET
> > 
> > And maybe someday we put MFENCE into there too for AMD parts.
> > 
> > Right now, of course this is the only logic that would care about an
> > NMI-safe sync_core().  So maybe this makes sense vs creating a generic
> > version that nobody else is using?  
> 
> I was thinking something fairly straight forward like the below. Yes,
> there are a few more sync_core() callers out there, git tells me:
> 
...
> But none of that seems like it cares about an extra few cycles, and why
> complicate matters with another sync_core variant and all that.
> 
...
> +	 * CPUID is the conventional way, but it's nasty: it doesn't
> +	 * exist on some 486-like CPUs, and it usually exits to a
> +	 * hypervisor.

Hasn't support for those 486 cpu been dropped now?
So the comment probably needs updating?

	David



