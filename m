Return-Path: <linux-kernel+bounces-876331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A192C1B8F2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D45563615
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A8526B761;
	Wed, 29 Oct 2025 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="e4qAsRXa"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F8D1C2BD
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747649; cv=none; b=mtS2QmkdBl9q/5oTseQhIa4ThECpTcUxHDhgXMFAkbDKPzNE4qbBOy1qckYmPb+mLjvPbImcL1u9us6AZ/0KKWRwO9SmKsz2pnK6XBf2uOpMZl16Xs7e9hgzabKjvAEuFkjdiwN1vkX1J7TyiUrhr1mlB8f30OvTKGS27f08Pu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747649; c=relaxed/simple;
	bh=am0/YbY3X+EDDZcjCgeLwrDMLb2LpBxcjmr3MpjYeF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ie5tA0DIXgyHJ8T+ZCglMYg1MtYqu8ZEEnVSoMSSUjsCZGjC0er9UUGVKneKeVz2tkVz9CP5WlKmK+V1Y/LRZcZgPYqKmU6skakJ7/PpGK2dITNlAIB7tX006vG1E3e3Cgg+vDv5FyblcPYJ8FdO6OcW8iSFFp3PHWeAZwSA32o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=e4qAsRXa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4711810948aso55200065e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1761747645; x=1762352445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fxBr6UEJhfUdxptPH87yDMGfOKWl61gBXcrB5pzrHm8=;
        b=e4qAsRXaZCN0Ac957vNDchZDWjuVxpaJLnRYPl+nNoiy10L0woLP3nsMf2HqatRMTf
         4yxKeUg/oDlk++HNyvAw3tDqui8UMe7vm/yLSUA5RPhm3XIs+TJ8WJ9LhrN6NSoGVA4B
         uBYyiaNFqnCYFmgIzqu0+kW+gS0HXQvrO+Oj5hLJb5n+8GPeyuzFsQkcAfWYd2N9zioF
         Bn5Cf38/ITDlzCB+teSgsbPIEu4lAhRjkHzcCqa+bWPFfVRvvomfoL2Ztj6bc+uFkzmG
         Ttt//U3awXwdxpFkE6JliMARy8fAnEf3AW7BywgR+D7FNYhTotOaUu6eKcv0RE1BCL+2
         3VPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761747645; x=1762352445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxBr6UEJhfUdxptPH87yDMGfOKWl61gBXcrB5pzrHm8=;
        b=Lc+hCR0yjGhyKVls62tH/4WBQKncmTfczZOf4ThapZ91bGPVhUa72IlgqDzhFwnwCp
         8sJccjvoYB4VFbwb2CUP2w2T+4YUcVl6ncohk0keAE47hO/Om8SwVjoWgyNiJwFlwoYt
         E9yxvJLSGTcS2obkRL+azOfZ2NOavLMlgBQSgPdm1PYVpiQTJwQGnSNhODCcbMBuOAJi
         oBH0e3NDlxpaOGbFqWW0n2TzaPXMLLtQQBVFXgxlYH2GDBQ0hwyhLYa0uN26qTX74y2v
         pqeCrczQ+alL0ege/ebABBYR/H2ulbO2xNX+kMHSq6gI5Hg4DU8L8Mf0l8fowNiy4NP9
         K1oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr7uG2jYIWiKaHPU/mhmBF/nECcCPAUZtZ58lX4rI4SrOcd2BxqTxPxBMbecBDI3KCkQw8g9aQRKRGydE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk1+Ejy+WWT9rdgbGzmvMvb18Gxb0z0Yho/iNQU6ZsEBKxg/46
	gW1s5TnWouoVCdUnI27bX3lPbQ/C/L3Pav4cNYI9s0e7CeWXz+drGaNKYyrqQRIen9s=
X-Gm-Gg: ASbGncsbwD4CfElgOSnoSTvVUE53UAn0xpPPmNqI4GOUUKZ/+UGeQtqg9vUp3RTtM92
	WB7aNO4FMiGYjlgvLGhK2tmOErZaV/SoBo8mBAmCkqDfVnyDoPOVifM7SPlfC2QhbfkW/5I7LWL
	68UfXaNuQORJhbZ5teuxjawvMS8LughUheOnOgVU6FQyiGciRjcts2+BhPn380WOTWGQMK4EpW4
	HUHo9fgdtFbcpplh2oCjYZCb8teHfWizRWpJt7yb7BWAJXVoBWocJbFSSpLkxTWDiZk0YFOgGsq
	LpHNQNymjpBZLVX/SLAxX+Jx+X6lCHALptNrEMEINAM6ETxrUo0MyanNegRWcLSz5JYYiVNVDhJ
	36KgZuuCQHjLxOW5mgAuZ1reuHCxRNwVaUEbvWaWU5ShkGGxUMfy0+H16lJeTI8qlyzkvheyamc
	yzEv8bNRyqzUQauHcyOO716370FZo=
X-Google-Smtp-Source: AGHT+IHoQJVW3GVryEUbRFPGpnxQkJbTH7OhYAuA7LrZ0+OT2N5eQIcCT1zPMqYvJ4arflxQltQRlg==
X-Received: by 2002:a05:6000:2001:b0:428:55c3:ced6 with SMTP id ffacd0b85a97d-429aef82eadmr2390550f8f.18.1761747644972;
        Wed, 29 Oct 2025 07:20:44 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cbb20sm26388404f8f.18.2025.10.29.07.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 07:20:44 -0700 (PDT)
Date: Wed, 29 Oct 2025 15:20:41 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] dpll: add phase-adjust-gran pin attribute
Message-ID: <jgebk37r4xs6w4526hjc5u6r7oudanb5ce7v4xlaw2tcswtycx@cvmxkwxvkpek>
References: <20251024144927.587097-1-ivecera@redhat.com>
 <20251024144927.587097-2-ivecera@redhat.com>
 <20251028183919.785258a9@kernel.org>
 <b3f45ab3-348b-4e3e-95af-5dc16bb1be96@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3f45ab3-348b-4e3e-95af-5dc16bb1be96@redhat.com>

Wed, Oct 29, 2025 at 08:44:52AM +0100, ivecera@redhat.com wrote:
>Hi Kuba,
>
>On 10/29/25 2:39 AM, Jakub Kicinski wrote:
>> On Fri, 24 Oct 2025 16:49:26 +0200 Ivan Vecera wrote:
>> > +      -
>> > +        name: phase-adjust-gran
>> > +        type: s32
>> > +        doc: |
>> > +          Granularity of phase adjustment, in picoseconds. The value of
>> > +          phase adjustment must be a multiple of this granularity.
>> 
>> Do we need this to be signed?
>> 
>To have it unsigned brings a need to use explicit type casting in the core
>and driver's code. The phase adjustment can be both positive and
>negative it has to be signed. The granularity specifies that adjustment
>has to be multiple of granularity value so the core checks for zero
>remainder (this patch) and the driver converts the given adjustment
>value using division by the granularity.
>
>If we would have phase-adjust-gran and corresponding structure fields
>defined as u32 then we have to explicitly cast the granularity to s32
>because for:

I prefer cast. The uapi should be clear. There is not point of having
negative granularity.


>
><snip>
>s32 phase_adjust, remainder;
>u32 phase_gran = 1000;
>
>phase_adjust = 5000;
>remainder = phase_adjust % phase_gran;
>/* remainder = 0 -> OK for positive adjust */
>
>phase_adjust = -5000;
>remainder = phase_adjust % phase_gran;
>/* remainder = 296
> * Wrong for negative adjustment because phase_adjust is casted to u32
> * prior division -> 2^32 - 5000 = 4294962296.
> * 4294962296 % 1000 = 296
> */
>
> remainder = phase_adjust % (s32)phase_gran;
> /* remainder = 0
>  * Now OK because phase_adjust remains to be s32
>  */
></snip>
>
>Similarly for division in the driver code if the granularity would be
>u32.
>
>So I have proposed phase adjustment granularity to be s32 to avoid these
>explicit type castings and potential bugs in drivers.

Cast in dpll core, no?


>
>Thanks,
>Ivan
>

