Return-Path: <linux-kernel+bounces-831755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C92EAB9D7D6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1434F1BC0C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B4F2E8B82;
	Thu, 25 Sep 2025 05:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2g+S9br"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E1633E7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758779144; cv=none; b=cNXuDR36vuTJfsXaCVcLi6+Prxz/hVk8pJ3v8fH2f/lXeM6c05vsZmEKDaIoeu0Um51Ag6zv0L0J8AMRPHcl4/Z1NFhnkqNuI+FqQKcnVENytPsD/1WgbRdmAbSkqKtYcHrSlEGwxEhxf/LhadTr3FijTZ2+E/9OMy+e3G2zlaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758779144; c=relaxed/simple;
	bh=y91CveNU8o61qRzBPIlmeKWPSA+K8ejO5zowlYxLNPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyKTAD2wybzlSiz5s+TEV4UYkKWtx55FNUKA/+ecoxQKwfk6zeS5KDH9Gk2Jn55i4RRz9lHfJrzAbWe77aJHrQcppGktqjRauFT7kykT7s/CBZBrBw0NVBADB+dHgOH0KzG+2t5Os/0Lbs0S2Y6aU2qBa2VIXzTU2Mh1dVkCdec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2g+S9br; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2445805aa2eso5798055ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758779141; x=1759383941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Q6VyKRbOn4TYUtmAcOT7qWbJ+MHx1s5wBeVwgJ07ek=;
        b=D2g+S9brKnGuc3tx2zqhfvgvLwLrlqIElr36sUgjOi2lXYO9iKupEG061yyBgpjEXE
         iYYfg+Q04QFqAWqG0Seev3IcbNtm0hp2ePi3TIQX40lTVixf8M5ehqbHhpst28B+j6NF
         ddfvCOIxD3dsbmiaR8L4D8h7Wc3smbzXwJ4V7uX6zj5g5QqbFzwE2Qjs3PqjiDIuWdH8
         ygrxPsn7tMn/0l/yfSItt2BBEEW0WEO9D3pqG1Hzz38x4SLn/WATbRCvGJVIUCdNNjNn
         OKIugOdp8wcnEEaWzl+WpECE0KTR2vu59zqiPn+V4UpaFEilHMKxnMosXUd2OTaE6EPk
         BgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758779141; x=1759383941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Q6VyKRbOn4TYUtmAcOT7qWbJ+MHx1s5wBeVwgJ07ek=;
        b=vEmedyE87Glq8lP3E+hRdH61TmepFp+79B8QYHS/jgkp7NyFCIj62COiq3EtlIfH9j
         m2tSj4hmvTb+SaWPW7VuOaohXHqk4XBfLd2og93RWzu1DYNepuRHp/sD7XdjwDhUWqOs
         YO9O6mV4/yM5P5rn1FCSSzw2MkgcsXAQ24yBuLME2tXSCfN/+OvMMO/bT/1Tx7rkr1mc
         hjBdwiVYqmXXcBko+F0N62e3eglcibtneBNFrK8AlTbzyv6QBCCoRsWqlJoSDjqQKWp0
         4IqzXwJrydKyYTFmLEu5Ji+xOYHw3dDMBogG0cgJO47CgGVzSxebfcY8tZXedhnUYY32
         fwLg==
X-Forwarded-Encrypted: i=1; AJvYcCXI1G8pQPdeSHJnHNJmwTia7Mwk3sjdJ5OHZ1AuvV4SUvSSbIHEE2oVyHj+x8IhktcvsudoF2I/BOVQVrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+xf9QzKKHhskgfDOdlTw/fUfE8iZHWUat5dyX2ROJYMP0qKys
	wqB3g9mRAyjvxciAcqfFrBuQN4iBMDwg5uSXRq2p5WXHJTuOTBVaL+s/
X-Gm-Gg: ASbGncszf0pMa+08gawUdS4iPjY/qDBrvLvTwT8VAn/pbZV+nvPomZGl/I9b2MeTBvj
	RXrg1m/BF92hdvsZFwgZEmWj9ywlgrDQMZQKYDlAfrxScH2stOr3+i3YmJpU551CECQ3P7uJF+I
	XOlkr6QqeAHNaywykZSq6qhe2fLHiTk3bv3oZi/NBNZFdnu1Q8RCGaRCQNVJMrrgGzkn8VrWHEd
	i5Iryx93hUTYxd69pzN30PEPiCalpabGDuGtfDA1Ox1IcqFYYtldRsxI9RnkTFStvvwnlQ6LTLX
	lsEb9wX4bNQTIEBV9GtIekizrY39jC+m5seRHs887+D3wQpX6w/0A+o6/+mqpUqGdbAIwvgEsqG
	UT6nQzOHc/aVIRNK4sbKwGtee0fTgsQpX
X-Google-Smtp-Source: AGHT+IFHyxcxK4Vd8sIGKGdSk7wQBBMmiacmoNUDPi5/Fxp6WTX1EZgpGu3p+r4H5CbHYpbKWFBz3w==
X-Received: by 2002:a17:902:cf0d:b0:27d:69bd:cc65 with SMTP id d9443c01a7336-27ed4a96a83mr23489065ad.45.1758779141061;
        Wed, 24 Sep 2025 22:45:41 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:5a97:14cb:a5e:6c78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671d8bbsm11739105ad.59.2025.09.24.22.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 22:45:40 -0700 (PDT)
Date: Wed, 24 Sep 2025 22:45:37 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Luca Weiss <luca@lucaweiss.eu>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Courtney Cavin <courtney.cavin@sonymobile.com>, Vinod Koul <vkoul@kernel.org>, Bhushan Shah <bshah@kde.org>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: input: pm8941-pwrkey: Document
 wakeup-source property
Message-ID: <3kww5et2q2mqddpvtqzuj3jqzvfds66qrufawcmumamrqoaugk@tiq6zoe5psom>
References: <20250909-resin-wakeup-v1-0-46159940e02b@lucaweiss.eu>
 <20250909-resin-wakeup-v1-1-46159940e02b@lucaweiss.eu>
 <efb03993-0481-45ed-8f7e-8b65519a55cb@kernel.org>
 <phctwoxml7hscwcgaipl233lotnrkgcpe7rxvhm5syoiadu3lv@ibgeib4kjyhs>
 <9e39f1b4-63b2-4c6a-8b31-6360be1952e6@kernel.org>
 <dcdbc6424db6953dfc39fc05e0e050ab@lucaweiss.eu>
 <kxgvebizxvlflu4qen3cb5v4lcuydmdixvi7624hrggo7f5u5f@zbengtjkekfj>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kxgvebizxvlflu4qen3cb5v4lcuydmdixvi7624hrggo7f5u5f@zbengtjkekfj>

On Tue, Sep 09, 2025 at 07:54:33AM -0700, Dmitry Torokhov wrote:
> On Tue, Sep 09, 2025 at 04:41:26PM +0200, Luca Weiss wrote:
> > On 2025-09-09 16:33, Krzysztof Kozlowski wrote:
> > > On 09/09/2025 16:08, Dmitry Torokhov wrote:
> > > > > >    compatible:
> > > > > >      enum:
> > > > > > @@ -36,6 +33,11 @@ properties:
> > > > > >             pin should be configured for pull up.
> > > > > >      $ref: /schemas/types.yaml#/definitions/flag
> > > > > > 
> > > > > > +  wakeup-source:
> > > > > > +    description: |
> > > > > > +           Button can wake-up the system. Only applicable
> > > > > > for 'resin',
> > > > > > +           'pwrkey' always wakes the system by default.
> > > > > 
> > > > > 
> > > > > I'll fix existing code, so don't repeat that style.
> > > > 
> > > > If you ack I can reformat on my side to match the patch you just sent.
> > > 
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > Thanks for fixing that up Krzysztof! I noticed but didn't want to deviate
> > from the style just for this description. Of course better to fix the
> > formatting in the first place.
> > 
> > @Dmitry: Maybe give this patch some time (1-2 weeks?) to gather more
> > feedback,
> > given the reasons outlined in the cover letter. Also on the driver patch.
> 
> OK, I'll hold on to this for a couple of weeks.

Nobody voiced any objections so far, so applied both.

-- 
Dmitry

