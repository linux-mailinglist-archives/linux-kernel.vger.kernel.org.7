Return-Path: <linux-kernel+bounces-889565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC221C3DEA2
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 837024E9B96
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF3835504F;
	Thu,  6 Nov 2025 23:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I79DoYxp"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895283559F9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 23:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762473440; cv=none; b=GaV5nDob/2eBAEwmgk5xTLpM+aOYaHw9NWKa1i86YJrBNebggqwH+fC7CcH7T5TyfnLqyEPT5ylJvUpVOF5ZHQzM9l3Fdu9zVYnUoitVcAlFfkzETFp6RwGl8mdtV9M3Gp4Gj8vNqv8TSuDUGZOExdxCsgArzh17snPAtZFrbKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762473440; c=relaxed/simple;
	bh=IWxoWu8rXqXa0LUhIlSBBtlEVdGorhIf64yYRWvjZgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fkio5kFmOQ7kJl9TSiN8cyoG0gX9S479NOAYZ2thPzJuuyDcEFUC/eQk52FusvVkyq8S6xTE9nxYoIXYr8eLN277GafZlPq4+aS5asn/hCNTL9jOVH5pohlaCtYzSGd+irKizNtQzMLTX4a268SdXg3FhctfWRoEOl11LfAijDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I79DoYxp; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so24851866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 15:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762473436; x=1763078236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Y0A68hlyrNzH2iLR6wRxqsJflj2t44wqvP4Uo+gLMc=;
        b=I79DoYxpvvc6Sfn90vNT8iEOKAtzNxNLz8R4NdKyr2Q7/ogMCXwXzARpp/k18jZer1
         64D4hKfFDJLD5plzEuw/BsQQIvDdEoOMMuNkkeb/BQx0U/ewKtFv1fPKOYe+17YmL8Sk
         Q141hNjlFeX1Rsi2QJpkDCIVMCeVEqwgGl7Fc3YicQmLBIg83DUDDcyRPAwvEgpuAZ88
         XDNnCro6XWm+k+xOedZPi67P5mQkiDg2DYdCVoOO39HiP73EUnWHMof/pIFFK9nwiiTb
         P/1Dq5XIoE7pUKyqIy9Of3aRqznLfdHAGbOrgLGiQvc6N8rRDw2rNH8kNILS10FjSIj4
         uYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762473436; x=1763078236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Y0A68hlyrNzH2iLR6wRxqsJflj2t44wqvP4Uo+gLMc=;
        b=aCkSEvEKYOyLw39IFGspBNraCF6ZB3NCRejZu3jn14F+ZoEOAvpwBkWisQJAXVT/JN
         fx6WNe5pyuvBEFX9Pf3iRoGQIFeBTD3zhnKj1UFxgV2fmxqJMh/0IMA7y+cMN2jC9lIW
         zstIO3V9cjeSFNzJ069BTstrZZZKjdGOQhM8Z2v6Q+dVYZguCz9ZjCPeNud9QQ53JrAD
         tfyf1CIWtvLQorHNLLczwuTcDztRDPpbWQf+ps3xXEivHYOrksG4QY9eF0/bPNmZhK/u
         6qHbzf9vJSys1h+Mv5+6rU8BPl7Cs1ko5x9RCBi2ra/GBEqdlpyfplt3zARZWajkw24R
         drTw==
X-Forwarded-Encrypted: i=1; AJvYcCUddzJfRM5ouDRwOnNmX91MVWGWAbopqjwEOuoeKJkjmL83hRJ1W3K+we4s7NqdJx3SpXDpi/W3clItsaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZLTqH2XZbkeUbUpcuqe3vViaVzvvrCsWvRtCwtZMblO8Y5Ael
	22Il/ymfA9DpDRiFGPd5xjWPIva04bxNwsvwuoWiENdWKo2YrcYmj3NeJh76qmTClYIBLdlbXDD
	mmLEZwBTKHgLQ6muV2151QlILjW/mJYCbmFygRjV+rye9ls3I9ikU
X-Gm-Gg: ASbGnctS5S8yGNGTY59HZJXf5ds4f+M1xqtu08BQr+KOmSgonr50Jqt5aqgkBye/0J5
	Plz14gTZ1o+QG1U9JuOM6+ybleiJ0+IYvscQQVVUwRWWTFx51/zhx59tvTQ1OdUEJWwPd+LYyRg
	Ltib5Cb+KC5vCHXVy2claK36Zd12eatZ/kHfJRGTubKbj4Kqz15ntQqGRtKW68KmDowG1dfdmOD
	fvs8GyIawYYlJoGxSQz0zRKPACfF+8ycqmdtzfKrqOP8KypsBxpQ5NDnA+v0CXMP8cQPrBVEc0d
	QJ5+EXGoushCkHM2hwO1iWjBSwSp
X-Google-Smtp-Source: AGHT+IHskI3NPaBM93s3aGR+lLiRMwTDGW9yJJLcgo0ttSscGMzfUiyz1/5T9E6opnMLv3sjCAHiQMsu+5aeY2Db8Zs=
X-Received: by 2002:a17:907:d1e:b0:b72:58b6:b26f with SMTP id
 a640c23a62f3a-b72c0d10a47mr79390566b.42.1762473435501; Thu, 06 Nov 2025
 15:57:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105122808.GK988547@noisy.programming.kicks-ass.net> <20251106105401.220218-1-sieberf@amazon.com>
In-Reply-To: <20251106105401.220218-1-sieberf@amazon.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 6 Nov 2025 15:57:03 -0800
X-Gm-Features: AWmQ_bn1DegqWn-ulMOm_PrZS8aXfVAqK2UomCdSnn0-gDRXKjgdI6sr0FU_VHQ
Message-ID: <CANDhNCpZWFsxZsmbXY2Q6DBfovqas8haepdYyx=RpWsZGDKN0A@mail.gmail.com>
Subject: Re: [tip:sched/core] [sched/fair] 79104becf4: BUG:kernel_NULL_pointer_dereference,address
To: Fernand Sieber <sieberf@amazon.com>
Cc: peterz@infradead.org, aubrey.li@linux.intel.com, 
	linux-kernel@vger.kernel.org, lkp@intel.com, oe-lkp@lists.linux.dev, 
	oliver.sang@intel.com, x86@kernel.org, yu.c.chen@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 2:54=E2=80=AFAM Fernand Sieber <sieberf@amazon.com> =
wrote:
> > But yeah, if the task holding your resource is doing yield() you're
> > 'sad'. Basically a sched-fair yield() means: I've no fucking clue what
> > I'm doing and lets hope we can make progress a little later.
> >
> > And it gets worse in the context of PI/proxy, because in that case your
> > fair task can deadlock the system through sheer incompetence.
> >
> > Anyway, consider the PI case, we bump a fair task to FIFO and then
> > yield() would do the FIFO yield -- with all the possible problems.
> >
> > And we want the same for proxy, if the boosting context is FIFO, we wan=
t
> > a FIFO yield.
>
> Alright, makes sense. Based on your suggestion I've submitted a patch:
> lore.kernel.org/lkml/20251106104022.195157-1-sieberf@amazon.com/T/#u
>
> This is essentially the same as your suggestion + handling of yield to an=
d
> scx.
>
> Also confirmed no crashes with this patch + v3 of the vruntime forfeit pa=
tch
> https://lore.kernel.org/lkml/20250918150528.292620-1-sieberf@amazon.com/
>

Fernand, Thank you so much for root causing this, and helping validate
the fix works!
I apologise for missing this case in my testing.  I'll try to see if I
can include the trinity test in my regular stress testing.

Do let me know if you do see any other proxy related issues!

thanks
-john

