Return-Path: <linux-kernel+bounces-855785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00987BE24E4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 583CD4FA598
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33233112A3;
	Thu, 16 Oct 2025 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5WBK0Dz"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE67C314D01
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605805; cv=none; b=pSUVE8K80eLiZ/ut2bgXX3gwUNzLQM7Obwq2aCA8s7yLVMYPA3Te1JF1pyKIu3LfzmwNl4rbINksE/fS9Kn99w3j7MerhOSzjWT2ExmGiHH+v9KNZ9duHgoQ1inN4Jcte1b3biD1JVIUKgPCHdxdjpPeE47jgPRi8+T4Eo6A/0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605805; c=relaxed/simple;
	bh=DlEwdt/1oVvgj+xrSw5FV5rN/OT/QnCBBXeLUsuO/CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBE+13yIaxXqp4/0Xm2GpNllFnU50/5UBourAN2Fd6mwMKI4g7hA/VN4X6fJZdrBJzelSiuS2mYsKGRVgSTrDC5x0WYN8Hyx27OkmT/fovS+JdAUxFGsUMvZJY7VeBNtw9dipEmN2TZIKKPq4eS0t3fLvpgN64kj5fmAkTjSQm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5WBK0Dz; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so347265f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 02:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760605802; x=1761210602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7I572VwB3nES0NLPbfC3fYspX+uBVXbkfV10orvQCLo=;
        b=f5WBK0DzePhTo8w3CFQoNScJs3P5bSWlf/fBVkSehcJJotw8QJNxYXOHQ6Vhz0Z398
         Vg7kE4x2tqZdKk0tO2uFGWGnbGC4+u3CCJn+uV9pfvdHQnWm6FVOaW6iEWPALhrdbTfS
         e9w5e3YBfHBlwehSA/l45JzUpiUMZtq/PZ84S7es67NMEUmg4Mh3mpHh5IwuW7uYIs3B
         TBmSsSRzwNC4XHl7OLKzodSg/jlwJgr+CzHWs5006+7tyhwNYG0MPfv46CqidaNA0n9s
         aGtuU78Mu2ZYUOdVG65HvjzYT5KO/micqqU5SS8wlrXE4Sf+aaq9DPMEVksF5XmOjqqj
         MOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760605802; x=1761210602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7I572VwB3nES0NLPbfC3fYspX+uBVXbkfV10orvQCLo=;
        b=xKOVsFJ5UqBjbFvxIKHuOYur5/yMmCpjWp1ZeFcFsx328BcmPaUv9reM//M70g1ryY
         TlramA/HpWOIik2uEvluBGxUAzBEz4fWp2B3Aa1+LQyKjKsz5kvxAwPw2il+PknJJmQX
         pIVdtR5iheoOrJ9xWxgb8UojMGz7K5wlMVjJhsFAHgIqOCihvUb35+EXzQ/Nv/0HQPip
         moGPcqe1Ywk9+wr5z8sSm2IFF2D0C3VbQiuelQAFIxw7CBzg1SI6/oFEjd3ppk9nAVGL
         vIaVrSIHv/i0OHpM5Lm1X7OXyIbKXoq1oroI+8LvynSvfWx8njiEOenSd2Fu+PqoWWPj
         +FAA==
X-Forwarded-Encrypted: i=1; AJvYcCUYgoBc003y64kXJcdqtGmQStyfIuYWRrVNpmMQnh1gY1/1cu2pt0mGcbht5MzH0L/AxQ1BcNFkqvNRfl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnoqFgntD1qtSvxQeNjlNoS3TCRCB6LVkUSkXR4wMtVRwB58xm
	JwfcPmDKvjAzC2gtgyeDtMFsZoZ0E8G3dd7w+256STLgKv+dmXiriRC8
X-Gm-Gg: ASbGnctHH3VAcvAOoLJARauZg2uJ+3/K7lqSGgh5GPQQr4uWIm/NpeGpLJWHX7ro5K1
	UufOeXRwgOvHMiIUf/+JJMWILpedhBtNUyQGtm0iaun/8//CIDFTeBvD2QSYopZlMM3WarNxB1w
	IIYN4cOtsQepc8GIlPmtPk9CR7UNpMH2SUveGk1DB4yzjQCYc0uocfgkSajZ7JB9FTjbe3CRHSa
	bmX/Y5Lb4uuqqJxKWOKHgjUtDB2utvC/OpqdRsk/HQPptCSab0WTMqGelrPRqFxzI1oN7gaR4Di
	M93m5FVgkylxep6k+xw6qzxgjB6zvKgRiEeqbdMS/Rx4K0Voa7ok4xz7dK8VzJHScQgKd4dfIT7
	EYqdMPUsSQAHUFTBnSnbTOicLcwrQcemTcNauRM1bfddt6drmaXgrwARHi8fxzUWw1NN7J8qc6e
	5JhhnxW8iFq+evkQgNdqp7Fy20du1OBqcczRKIs3WgaXlmpY6d7w==
X-Google-Smtp-Source: AGHT+IHu9qsVuasRZJiri7bGvjUh1qF8593kOXqmfugC2rLOQS9cOi8nsqbJlHpNN4XuyqQi9YJqbQ==
X-Received: by 2002:a05:6000:2c06:b0:40f:5eb7:f23e with SMTP id ffacd0b85a97d-42666ab2b15mr17600109f8f.1.1760605801871;
        Thu, 16 Oct 2025 02:10:01 -0700 (PDT)
Received: from alessandro-pc (net-2-37-207-41.cust.vodafonedsl.it. [2.37.207.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42704141cdfsm147894f8f.4.2025.10.16.02.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 02:10:01 -0700 (PDT)
Date: Thu, 16 Oct 2025 11:09:59 +0200
From: Alessandro Zanni <alessandrozanni.dev@gmail.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
	"shuah@kernel.org" <shuah@kernel.org>, "alessandro.zanni87@gmail.com" <alessandro.zanni87@gmail.com>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rc] iommufd/selftest: Fix ioctl return value in
 _test_cmd_trigger_vevents()
Message-ID: <gn4l62kroj74d765uojx2vmu4tugxbmwnhodckfbath2pafeuz@nw2kudzcucv2>
References: <20251014214847.1113759-1-nicolinc@nvidia.com>
 <BN9PR11MB5276834E90A7990269EBBF608CE9A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276834E90A7990269EBBF608CE9A@BN9PR11MB5276.namprd11.prod.outlook.com>

On Thu, Oct 16, 2025 at 07:47:20AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, October 15, 2025 5:49 AM
> > 
> > The ioctl returns 0 upon success, so !0 returning -1 breaks the selftest.
> > 
> > Drop the '!' to fix it.
> > 
> > Fixes: 1d235d849425 ("iommu/selftest: prevent use of uninitialized variable")
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

With this fix a positive value returned by the ioctl() ends the loop and returns -1
to the assert.
Maybe better to put ioctl()<0 in the if condition?

