Return-Path: <linux-kernel+bounces-881246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1466C27D0A
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 12:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6FEA4E2EB5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 11:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FD1285C8D;
	Sat,  1 Nov 2025 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwLj3MaS"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D180A2566
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761997817; cv=none; b=Bk1PeRpEU1UBDXM8icMylfn1rZy1A1zl9oFtKUMkXZ87kzYjsYXZXO68TOKNTGQYa/7RIxeCXdDbFQUApxjmcAgBUcLExpwT44A94k0Mqobbb3sZuIg/8GYzPjGoyxS6lpXD1S+RrIATsq0j9rga2ZMKObhgip+LhIH6Wp/TVHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761997817; c=relaxed/simple;
	bh=HaqqRDPrZWoyjq8JRavr3wToxJeyCzQAvF+S4eMFlcE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+VJ3AFChAJ4ZRGUcjGHdD5VcS5Y2OvmFl48wfxYrSyyu6AW8IMm5d6pnNIOnGU1b/s4RP5fwUgNQyhMnq6QHD42IwQ6zfesDEHvFpj40M1mmzabLy4Z81ZW29PfkonBG/0dXU/myTxbndemnuJ352DwERAezUPsyIkbLTzuHfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwLj3MaS; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-429bf011e6cso1772002f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 04:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761997814; x=1762602614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sZ1LVmNuWNRShkFgZkqHZfQpdnjfb66+76NdCRKKg0Y=;
        b=jwLj3MaSe/N73KvxVxRodKnwYBgcC4UwTUhEZTtatCwzGKIbt9GzBn/wuUsKoU2dpG
         NhUfFyMUIRTEdX9SKWE5qeGIzfmQzmeqrb5mjlkc3uBoAidT1+nCsJ/mIOwSbKGYYMZU
         OHb5TU6lUrp7ljRx5lJBu9c+oaxYbFIzdyI1OAGFKOe6crzCL89HKMBlnSnly6zO02Wa
         Qa7fDI4s6JXqmfwLhTcq5RPLHPwNW2iq9YyBpAYF7v9sT/YjSymxrS16rT2X6HdQ25zh
         FmQ5OR3cSlMGPGLJkdYooNAu8a5xFRPTxModYyL6++tGA3EAjrWZa4lQTww5dABOQ8yX
         B8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761997814; x=1762602614;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZ1LVmNuWNRShkFgZkqHZfQpdnjfb66+76NdCRKKg0Y=;
        b=lotPw7u1MTEJOUfj0A7yjYCGemVhdsrl94RNCVMGE1ChWNKHMZyHjrLOE2kBUghX8e
         +8VyftWrOzk2o2bbcqUVEAr2S0sT4oXnO7NbVSyz2v1d/nuNUPpY2vxHNb001UcY29wM
         /mI7OVE4H8+pDVjOH9CU0B/zcElRRBhVsPQsJcXFrAxqEnblq9keWWunFOM7zC1Ut5sK
         WK+La53MsLGMtQWAmGKAnco7y+YJhsn+BcPGqyGHX8U4+R21vLPHP7EHVWKYiuRNsTlJ
         qFPE0F9zP/bAWr39cRCERstleMlPVLMPfvASYbbN5H+ZHdLkbrz7u5wdICs7Qgu0nI+I
         peXg==
X-Forwarded-Encrypted: i=1; AJvYcCU6lBn8zUT4BEV67SfZK+z3zKiV86RgyZcWfvVcILvn5qR0RuiEp7w/lHI3yB650cl/d0gvPkRYRg8F4O0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6KCUcTSZ1uvVvG3XB+lJU0tabF6LL6CLysnFpz8x9Eb6s61rF
	0hNuR3dhtXLDnMF7nAFj1adLnCte7WzF/cLt22INLJlc40Kc9xi8lcU1
X-Gm-Gg: ASbGncsJmTGAcPdsv4T+rrR2pwwVoTxG9XqzltCNIHK4oPpapkdvQUoleoHzRcCoxvP
	xEeXx7DZTN/WfyibLwp7y31GQmwRvJGnJnoKiljEf66KgNZtPVvofjivdemlQwlEG00poE//MAl
	a5ZkSYZOKzvAzYeTJ7jH5q22mCsbUWAcDdmulZZBSbzarNfv2jrqqxIaZV0SntjXWt/UoZYhxyP
	0MOKCdIeU99WW/CPD5VUIvopxPw5sd+fkYXeosUlW18o7kbLXyvw9n/Og7XDLzUAx2A4rnvhjpb
	x5/3MoErrXdWdEw58vZjOGGNjovPWC3GUuEYEoL4ediyiLEvFF5j2mG0KslyBKYSm+awmQ856Hq
	znzmmpzIX8/M60NgQw7d09EjdAmBnRKyK1HWuS9tcYROr4+8kOmImD0FGJK161YPX7X0abt3jo7
	lAx+RlF8fLQBA=
X-Google-Smtp-Source: AGHT+IF5Vi/R2DP1IElourozRko5CrLa0/NoKSzqRc9YHLEWiuOxxp/36gk0/Flt/0Dln2p1OLfZhQ==
X-Received: by 2002:a05:6000:400d:b0:3f7:b7ac:f3d2 with SMTP id ffacd0b85a97d-429bd6be4e8mr5734048f8f.43.1761997813915;
        Sat, 01 Nov 2025 04:50:13 -0700 (PDT)
Received: from Ansuel-XPS. ([109.52.237.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13e1c9esm8842790f8f.22.2025.11.01.04.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 04:50:13 -0700 (PDT)
Message-ID: <6905f3f5.5d0a0220.27a792.7a13@mx.google.com>
X-Google-Original-Message-ID: <aQXz8Wz10HnVaiMm@Ansuel-XPS.>
Date: Sat, 1 Nov 2025 12:50:09 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Raag Jadav <raag.jadav@intel.com>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] cpufreq: qcom-nvmem: add compatible fallback for
 ipq806x for no SMEM
References: <20251031130835.7953-1-ansuelsmth@gmail.com>
 <20251031130835.7953-4-ansuelsmth@gmail.com>
 <aQS5FpuOWk1bWnQd@smile.fi.intel.com>
 <6904c563.050a0220.a13ee.0212@mx.google.com>
 <aQTI7o1HQYbQ_Pl2@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQTI7o1HQYbQ_Pl2@smile.fi.intel.com>

On Fri, Oct 31, 2025 at 04:34:22PM +0200, Andy Shevchenko wrote:
> On Fri, Oct 31, 2025 at 03:19:12PM +0100, Christian Marangi wrote:
> > On Fri, Oct 31, 2025 at 03:26:46PM +0200, Andy Shevchenko wrote:
> > > On Fri, Oct 31, 2025 at 02:08:34PM +0100, Christian Marangi wrote:
> 
> ...
> 
> > > > +		if (of_machine_is_compatible("qcom,ipq8062"))
> > > > +			msm_id = QCOM_ID_IPQ8062;
> > > > +		else if (of_machine_is_compatible("qcom,ipq8065") ||
> > > > +			 of_machine_is_compatible("qcom,ipq8069"))
> > > > +			msm_id = QCOM_ID_IPQ8065;
> > > > +		else if (of_machine_is_compatible("qcom,ipq8064") ||
> > > > +			 of_machine_is_compatible("qcom,ipq8066") ||
> > > > +			 of_machine_is_compatible("qcom,ipq8068"))
> > > > +			msm_id = QCOM_ID_IPQ8064;
> > > 
> > > A nit-pick (in case you need a new version of the series): I would expect
> > > the conditionals be sorted by assigned value.
> > > 
> > > 		if (of_machine_is_compatible("qcom,ipq8062"))
> > > 			msm_id = QCOM_ID_IPQ8062;
> > > 		else if (of_machine_is_compatible("qcom,ipq8064") ||
> > > 			 of_machine_is_compatible("qcom,ipq8066") ||
> > > 			 of_machine_is_compatible("qcom,ipq8068"))
> > > 			msm_id = QCOM_ID_IPQ8064;
> > > 		else if (of_machine_is_compatible("qcom,ipq8065") ||
> > > 			 of_machine_is_compatible("qcom,ipq8069"))
> > > 			msm_id = QCOM_ID_IPQ8065;
> > >
> > 
> > Hi as said in the commit, parsing 65/69 before 64 is needed as we might
> > have compatible like
> > 
> > "qcom,ipq8065","qcom,ipq8064" so we might incorrectly parse msm_id
> > ipq8064.
> 
> Oh, this is unfortunate. Wouldn't it be possible to use some API that returns
> an index (or an error if not found) of the compatible? I believe we have a such
> for the regular 'compatible' properties.
> 

Well also using something like checking for the virst compatible might
be problematic as real device have something like "netgear,r7800",
"qcom,ipq8065","qcom,ipq8064".

I will check if I can implement some alternative logic to have
consistent order.

-- 
	Ansuel

