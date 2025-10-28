Return-Path: <linux-kernel+bounces-873604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 236B5C143DF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 991985426F6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DA02FD696;
	Tue, 28 Oct 2025 10:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yy/3i9ZL"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA822E7F2C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648833; cv=none; b=EGqQavFOBOJP/kWOd/NMFwJyoOPGBcLgn9OalEQieXvkLodAE8FO8mdzETbdTtDJND/CRKDYO/fV4NeCW5RPM3NqcLmxx5xXHpEoyPU0Hj3tXFE4xTEiVGh/ZmhSBr5syoi2i4bWnazEGTFOYMzbJJepjXIvyePQvnXk5b5982c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648833; c=relaxed/simple;
	bh=KAAq3UD42W1vG9OmM9VYHYbQDySbjL7ySIBoXYb+P6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4BXkGiPFrXD6H2xXNUIR2ZAqxiXdM14m6uuamCj2Gz8lMqpJfmT++IGL8rLH6o7HMzo/Ry23BgYAQNfbAbkFIZdk0Cr5VO48FsJm6kwUB/3VoysH11OS+PgEgfYjRMV5M1NoYlx1e8d86j3TlXigLIVc2QXvcTXPkZ4nysvKcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yy/3i9ZL; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so2966433f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761648830; x=1762253630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ciiMP+aVPTGP01jthAKSkaUntJMAjHCa/1wZcaGOww=;
        b=Yy/3i9ZLnTph6l90l0/LWiSjVJjFFrdB7gzpReH19Aigawc8qKerqf2BoIb2Z3O/th
         3CoMu0Ww8AmvCDWxQx3rmdXWiBLYQeN97T5iWohg9m+o7gKRNEHT4D4yZAhRiTKoJ3a7
         jIoB9i8YPDV7ney8HRyUDM61CedfEH2wdqb7KGHcqgMq1sbTvhv1G2fmU5MIZnWDW9aA
         mMKEapUS1wJDZ/bEVjtG6psYobGTa94j/fsLeL5WYgBMeYvgNQJ71Za8n8v7bJholgzX
         VkDPrXGLD8xLPnMvalQbhA9YgyvHvt7U4++6gFiBcTxUDfr8K7o8apYWqPZeS238SLS2
         ZWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648830; x=1762253630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ciiMP+aVPTGP01jthAKSkaUntJMAjHCa/1wZcaGOww=;
        b=fzm5AhAmv9w9QLo+uQr1zyN6aafvRi33ISy7E3b23JLCFY1y9F/IRporBy62k26tL/
         9v6mhTw+6Gq36d244YDXAzzDs2sKbStyyk5uvMa10hFEaiQle+A2mBVN2QK57+qe4Trv
         UdraIB4MUzSpm9TGQAwedCr+pYYFvrgBjb+hBnSWuzhJfQ+HKmfCaPiI5Uus+gAC6y7g
         bgxlsxFSCDilLzVNa18inNlgZ0OlVzrm1iPPJFk6EjDoLAS+dmIB3YPvairPgGayDuTq
         FLZApBGSxcmQ8ePmWovw5qq1ZAiUonBXvzlRY6exyAH+zKczT8koTXVo2WL8IPOONxRD
         +XIw==
X-Forwarded-Encrypted: i=1; AJvYcCXENT4OtNeM/ofVvXEgZajqLRDImF2KGYbsTGxGJTDT0aonR5axbPt2qyKJ5KR9lPrE1iIyecU5Ddu+TYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFR5fhz1OO8iEJmMqU22McT/8/Io4tJPHE/D7syluyNo41RXRn
	Lgq8pR3ueVCZzYO+3aODhQ93kQ5uATGIxHcRj6ykA0HKJPM5LgHzCGZ+q/N5NOyZk8o=
X-Gm-Gg: ASbGncsDYOp0Ew05FsLcSQ+OQ7DDTMwd7vGutD0+wJRO6wUmvw8OMHU2eGloN2rxKGj
	+tER2L+zf0iI+cVy1jzzCNwe75s2rQOTFsuy519F0czTfwaTow4kiBqSlAreQb1sCdEXJmo9xAT
	z81NGKExId9Lk9On7fqNwxxHoZ8TU6sAFye+ydHd2yCyqSklERkPLggtw1HsnyeOY2a2O+HD/JZ
	ME6JPfeTV27c/GnUkXM2SQhfPlIfE3rzPZssQmiKvZg2q2+CHDzrQ0S+a1H/PpMSGpZ5lnVcVd2
	/IFfFhHBefrKLWqIqY4oroFtNWg6gSUVA2jh+x57Vo+juXVOaFCNHwJW76tjPrOrCL3Ynfo3SOQ
	w0saGWSBu2zys3JeFFLaifhZHbkP4WDsC7UXUJUS+NobnVzOpOe3tCdF2u1Z6ylNKsoFHWqY+eX
	S4cS3casrHsj53W/2cPdFN
X-Google-Smtp-Source: AGHT+IGNt3x1+qvnQdvPMrB8YbMOh25mEuFQD2Py5L6FbHFNPHpPfAZVVrBrzGdO5MKQniNEUyPgGA==
X-Received: by 2002:a05:6000:26d1:b0:3eb:9447:b97a with SMTP id ffacd0b85a97d-429a7e8e222mr2559278f8f.54.1761648829920;
        Tue, 28 Oct 2025 03:53:49 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:30:7f41:186a:1d61:ae59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd374e21sm191479545e9.9.2025.10.28.03.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 03:53:49 -0700 (PDT)
Date: Tue, 28 Oct 2025 11:53:44 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Enable use of all SMR groups when
 running bare-metal
Message-ID: <aQCguL11h6oa5Y4C@linaro.org>
References: <20250821-arm-smmu-qcom-all-smr-v1-1-7f5cbbceac3e@linaro.org>
 <aMAkJ7CfPQuhvhfm@willie-the-truck>
 <aMBJNzXpQTMg4Ncs@linaro.org>
 <d73e5026-ccb0-4a19-9742-099a0443f878@arm.com>
 <aMsJHheI6Y1V5q74@linaro.org>
 <aM0LZVudBKjWuVrT@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aM0LZVudBKjWuVrT@willie-the-truck>

Hi Robin,

On Fri, Sep 19, 2025 at 08:51:01AM +0100, Will Deacon wrote:
> On Wed, Sep 17, 2025 at 09:16:46PM +0200, Stephan Gerhold wrote:
> > I realize it is weird to allow non-architectural features like this, but
> > I haven't found any indication that the additional SMRs work any
> > different from the standard ones. The SMMU spec seems to reserve space
> > for up to 256 SMRs in the address space and the register bits, as if it
> > was intended to be extended like this later. That's also why it works
> > correctly without any changes in arm-smmu.c: the bit masks used there
> > already allow up to 256 SMRs.
> > 
> > What do you think?
> 
> Although it's all pretty ugly, I think we really only have two choices:
> 
>   - Teach the core driver code about all this and use an rmr-like scheme
>     to leave the upper SMRs in bypass
> 
>   - Hack it in the impl code as per your patch
> 
> The latter option is probably the most pragmatic (especially considering
> the need to handle the virtualised case differently) but I'd like to see
> what Robin thinks.

Do you have any thoughts for this?

The stream match conflicts that happen without this patch still exist,
I've been testing this patch for quite some time now and have never
noticed any issues.

Thanks,
Stephan

