Return-Path: <linux-kernel+bounces-811774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371E4B52DA9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A278F7B5BEA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0644C2E8DFF;
	Thu, 11 Sep 2025 09:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxosJhHf"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10892E7167
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757584219; cv=none; b=Zhy+FpA4btRkLQP5J98Uy/Kq6GZUT89HyiZmZzhK8EDJT6zuG6osSWc9/uz9W+um4/hRqi37uI4ai9EJvJXlLmfEjdheyN1R1sdhBCwRD6/cK9OVavqZZSVEJSNU8DvbDmMVXnXjx+3CufAyykgP/WmjZ2hxOVKVdzDr1i1OL1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757584219; c=relaxed/simple;
	bh=I2mAuNAWpA4CXYyRv4L1JrJBlRZdLJ3+HIroxofPWtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djmIRl0DajMSLLNuXIMMU+oZAJGu+KMrFiRt91HQ2LsLcnibnATNAWm4zVIyYni5dzHlAYMZYQz2AT8HLTXCeFUM3Q7jQRrA/xY7V6Bj7U+Roiq4KKM8u9HFlT2Mrtdk12rfaN/Hih/dSzh7c0eT98Kn5Yylgq/f4x2gXUJWzJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxosJhHf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24cbd9d9f09so6218465ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757584217; x=1758189017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QM8m3A/WORgRLBVKtapiYGsj57OrgF0zShq0IHwFP18=;
        b=kxosJhHfSl6ckhhj7UAiMsmBnGr/br/1L37YXC6RtJEp7NsmKFRkR1wlbSf5kbxA2h
         8Gzf5jpooQyQN5ilC74yBxuBLDC+QnO39aLdTdiXLVjYEB9G5NrFIqcF5I2oK9IoRVSs
         ld3/qSudPHeHHk6cstLCDitOEMGFPKAHZ8AVZqdyt3suWLlGB6BdW2TSoRzXpeQJq7jm
         Adwmjk8tssiJjf+5xiWlZ0M6Qtlju4ClV1x04Tk+ZlacXJUKi+WIVGYrQwQjN6FQSlSw
         jtknRuNDSkTxOb11AtiGPOwQAuRW0K1mjhtUP2inioLIxuaWA63CqsUSY36P0qx6iuxE
         eWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757584217; x=1758189017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QM8m3A/WORgRLBVKtapiYGsj57OrgF0zShq0IHwFP18=;
        b=ajO23bgEtvVoQFlCLFbhGnhxzZkDzkw1B99XhS8PK8ICG5Kr7G1tnedH5SbTlJ9OQd
         QqccTJrmgCM5ctDEDxSJhf1GLDILEdf9UVKU/KvyFX9FhYtDZ7nz9xx11bxHok9MZIkl
         ahQbZfOdfBNMAoSnlQSLA0jZQxhRWMx2sWE46KKtDE3cunTCKrhzTwRm8Ri8G8ME7yWe
         c1hIjGGowz12Jmlkh7C0IvDQTcBdZSUIEZgYzsVHjT07o8VTg9aJZiwRk3x5rpUglKWJ
         2BcmmP0UvjwcnpBWdKaxWqHNmBVFAU19QxKh6QDjDzGS9yPIiB4iQBT9u0IqakGV71H3
         eGJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTyorbBxm32sxuL6Fq3oNcGoVN+WbGys8VyjrqFYDK7ETVm3i4U14LGkvJ8EYmACvZLw76D+d+1Go3Ep8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDsvzGXjJbpFOGNJcSAvbWgk4+ubJUtRfGObKs6bNT+qYOWcP6
	TRudwW3CbI/Aa4dujtYWTavm4viYM9pHzumO+dlybEVSLlnlty9XX1S2MuZ0KnfU7A88O+2emJP
	aHSAuS01UwoxAg/V5aGFpjqwkzXEbcw==
X-Gm-Gg: ASbGncuhZ1z47sb9E/HSQvDXPB/MkFYHX+yu77TmU7i+y4/c2gzmryeIdikoGoKA8/t
	Ajg6Uifwj+rQbaGV5b8JMfi40gCyl6jx0Gztq3weViZWXBDNZy7v+zvwu3KznAqgPiPdAq6Rhya
	c406u28s3cs45Stk3TmL2j5dVzaRF93OQUc01oluMSoa7vYEpNF15+at6bouphgOmBQdtPekYiV
	1OJkjw=
X-Google-Smtp-Source: AGHT+IEBmgIN8y37day1fHQTsYlRnKNk+ippWXmTT2HrserdbQaq2AVuWWzBeCg6JNXtus8ev42dc3GzvLMJo+zz9qA=
X-Received: by 2002:a17:902:ec8e:b0:24c:d33d:418e with SMTP id
 d9443c01a7336-2516ef57cdfmr269642205ad.1.1757584217162; Thu, 11 Sep 2025
 02:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910160704.115565-1-jihed.chaibi.dev@gmail.com>
 <20250911-dainty-penguin-of-fragrance-9b4cef@kuoka> <20250911084323.357caec2@akair>
 <8a8f3589-482c-467c-8a13-199c51e0331a@kernel.org>
In-Reply-To: <8a8f3589-482c-467c-8a13-199c51e0331a@kernel.org>
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Date: Thu, 11 Sep 2025 11:50:05 +0200
X-Gm-Features: Ac12FXzDahEquaYeXVEfztGaEk3INHCZrXHNe94GxMS3IoKFdye46FBH1ftGQ1o
Message-ID: <CANBuOYprmtSd6wuQur-bmaXHncogiOngNxAn7pkTcgf2dAOVWA@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] dt-bindings: mfd: twl: Consolidate and fix TI TWL
 family bindings
To: Krzysztof Kozlowski <krzk@kernel.org>, Andreas Kemnade <andreas@kemnade.info>
Cc: lee@kernel.org, krzk+dt@kernel.org, tony@atomide.com, robh@kernel.org, 
	conor+dt@kernel.org, ukleinek@kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 9:07=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 11/09/2025 08:43, Andreas Kemnade wrote:
> > Am Thu, 11 Sep 2025 08:35:32 +0200
> > schrieb Krzysztof Kozlowski <krzk@kernel.org>:
> >
> >> On Wed, Sep 10, 2025 at 06:07:01PM +0200, Jihed Chaibi wrote:
> >>> This version addresses a final piece of feedback from Andreas to make
> >>> the twl4030/twl6030-specific child nodes (audio, usb, keypad etc.)
> >>> conditional by moving them out of the common block, which now only
> >>> contains common properties (rtc, charger, pwm, pwmled..) ensuring
> >>> the schema is fully accurate.
> >>>
> >>> The complete dtbs_check for this binding is clean except for two
> >>> warnings originating from pre-existing bugs in the OMAP DTS files,
> >>> for which fixes have already been submitted separately [1][2].
> >>>
> >>> Reviewed-by: Rob Herring <robh@kernel.org>
> >>> Acked-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> >>>
> >>> ---
> >>> Changes in v7:
> >>>   - (1/3): Moved twl4030/twl6030-specific child node definitions (aud=
io,
> >>>     usb etc.) into the conditional 'if/then' block to improve schema
> >>>     accuracy.
> >>
> >> Who asked for this? It's wrong code.
> >>
> > maybe I was not clear there. That was not was I meant. As far as I
> > understand, the correct pattern is to define things outside of the
> > if/then block and
> > then disable it with property-name: false in the if/then block
> > Example: Handling of regulator-initial-mode property.
>
> Yes, I read your comment afterwards and that is how I would understand
> it as well.
>
> But the patch here is done differently.
>
>
> Best regards,
> Krzysztof

Hi Krzysztof, Andreas,

Thank you for the clarification. my apologies, I
misunderstood the correct pattern.

I was following the existing structure in the original yaml
file, where several board-specific sub-nodes like 'madc',
'pwrbutton', and 'gpadc' etc. were already defined inside
the 'if/then' blocks. I assumed that was the correct
convention and that the main properties block was only
for shared nodes (like 'regulator' & 'pwm'..) which is
not the case.

I had (mis)interpreted Krzysztof's earlier feedback about
top-level definitions as applying only to properties
that were common to all variants (like 'pwm').

I will send a v8 implementing this "define then disable"
pattern for all sub-nodes. This will be a good
opportunity to clean up the pre-existing definitions
to make the entire binding fully consistent.

Thanks,
Jihed

