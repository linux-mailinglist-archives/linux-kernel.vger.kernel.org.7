Return-Path: <linux-kernel+bounces-594476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CA0A81285
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 18:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D80B4257F1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 16:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A0122FDE7;
	Tue,  8 Apr 2025 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yUNsmZbl"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D8D22F152
	for <linux-kernel@vger.kernel.org>; Tue,  8 Apr 2025 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744129930; cv=none; b=aRdwEewXqNNxef/dq2U0ILXu6gC+TkAEjCjM8aXx+BJ4s3Eopbb8LJZiZSZRffP0XVF1SeBgv2n/5hhCDnaNWV8KkVhIRKZT1pBSy1qUITklEnUyaECDsmkFAsDdJkwQmI6xhPqrQSp5+clxgpn19ZZXdMsdQxPx541C/96VBT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744129930; c=relaxed/simple;
	bh=OjHDl/nvN0c8R42xruw4HTc+EiYWMR7pN+bjy/oSC+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MappJScV+amqaitHhfapuZ3a9942Bx71/xUF3NsJeWSSjnV9H/GuOjmRTcfZOOmawt9N4SnX9HrSm2Snk47UDSkkf049xi/3gGLzU+m2l7ImZFT+CO8HNTTy5JEKTLOvcO/YvhpCvw10iAzUWWD62r9Eeohu8KKSnBsABBjQ3hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yUNsmZbl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2260c91576aso49129725ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Apr 2025 09:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744129926; x=1744734726; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mge8I/Oyjp6jRE1SjTLJ8hUfDhnJXn2HEAVEbabtqKQ=;
        b=yUNsmZblprjVSZ4bYZYanENOEVV9hzB1D/l+iT3ihiX2xsCUW+yApyvFAufB2U/vRi
         r9pi8E+uc1DFo3Pm4hWER//AnUb4VwcSeug+ARcykCFWWTIuexA2FrmruqYvdi2BJHNL
         t/03Fd75VFpZfBQ+6uE4DMcceyl2dz9Vg1WQZVZGpVn3TuzpvVTwL8V4p4i4jk4Oko5F
         5nbEEG8FwMxtFtuHXOjIhN/DnzqICZQyT5iHTumP5GPWYg3YbUddlJ7vkokYQLQaRF54
         Wi4icoxIWl/NjtGJY30bwnJPpw0WHuHyxjg+lquAxKwkW9xXWy45WQ4ihEVYVPv1er1V
         yJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744129926; x=1744734726;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mge8I/Oyjp6jRE1SjTLJ8hUfDhnJXn2HEAVEbabtqKQ=;
        b=IOsjuhB4eNnYqVxZymKwg2tZN9V+uoGJ6WldS2xuV0Hmf2Bdn2Ul43i+w7Mbm6YjUX
         +O6MrFuXCoKTNF8fIULS86x/Gp63nd1RQI8Qw9xONe/Hdz3SrxQGH1dSqxF9MktZTHto
         tjZm8MLZHqeOfEHuTfnP0V6753eecU7ZVfpcGagcCHOkYmOkoPxdsYIoqQFfdk5P7xxb
         kqA1zY9NUJqqSFuZMQ44iBHgRDaMSvjebkIKPH7uuFvJOsyn8wh9XFEpOR0q+CQDZzBZ
         RbGlXgq2/kOHK6tRW7Wh6r3xvn9rTTdA9IQvm9LxweynGlp7Lo8XeeffeIR7DnWFO9dI
         uGMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlMz3IZSj8bR4NqDRTYdOBp1iFu8srWMvJqBM5ua+peHMyBDGzvdloJw1WmxkHDQo/uFTMfd3EKa0z1W8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGvjhfUAppFFNVJuTNpJQFSXSV10D/BIIKrOpKeZis24vgOXLq
	qKq5r9R8A8xC3mMNQfvrlU/YeY//jVyFsC3tjalEomIx+n5Q8NyIclolH8bVBQ==
X-Gm-Gg: ASbGncv8cKgMq7Nv2e6oErkojhByZ7/mGgTzSiuVRsJOuonwWM/+UcH1V0SA8PUY16Z
	Wy0p/ErrWT6FCH8JIflULdqPrAx9bawLr6d6xkUU799x/55rnd0dEcVxLJmsjRvJyO904CGp6SI
	Z8hxwaV+24M/TQVCU/413Sv2wOWhJ9g9bimuleiiwzampUPn6i0t6SkprIkrc96XPW7D0dyrNzu
	1NojUoYAa8f2s/3QW3Mid3J1N14MRA53lncZa+J9uMiAb5d0oakAPSajpgvU7KG5twEJCDiwsCS
	liBnB8MLjxWsaheZYh99qT9feGU493N5VQxLAMyJQIF59HCUei3B1EPM
X-Google-Smtp-Source: AGHT+IHS18q49vs+Zvn/dzMdk7KWD/IBZlqEWj/QVkFDBUKcPlA3rEO0nYaDPyLvqGvelpq0eTzXtQ==
X-Received: by 2002:a17:902:f690:b0:224:912:153 with SMTP id d9443c01a7336-22a8a04ab76mr245334115ad.5.1744129925962;
        Tue, 08 Apr 2025 09:32:05 -0700 (PDT)
Received: from thinkpad ([120.60.134.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e2b6sm102338545ad.191.2025.04.08.09.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 09:32:05 -0700 (PDT)
Date: Tue, 8 Apr 2025 22:01:58 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: MANISH PANDEY <quic_mapa@quicinc.com>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, quic_nitirawa@quicinc.com, 
	quic_bhaskarv@quicinc.com, quic_rampraka@quicinc.com, quic_cang@quicinc.com, 
	quic_nguyenb@quicinc.com
Subject: Re: [PATCH V2 2/2] scsi: ufs: introduce quirk to extend
 PA_HIBERN8TIME for UFS devices
Message-ID: <cwwf4z2lrdhyv3nsj7do6ycn4tmdaii3wsr37vehgqpvvkgkwv@iugp4vu5srdm>
References: <20250404174539.28707-1-quic_mapa@quicinc.com>
 <20250404174539.28707-3-quic_mapa@quicinc.com>
 <hcguawgzuqgi2cyw3nf7uiilahjsvrm37f6zgfqlnfkck3jatv@xgaca3zgts2u>
 <d09641c7-c266-4f0a-a0e3-56f63d8c9ce3@quicinc.com>
 <l6xao2ubcvv3ho56dv6qfr3b62ve3olfbhvywg2is2xdhod27r@2nyjfwinrxzm>
 <25d8a781-14ea-4b97-b6b4-f9d472c1b692@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25d8a781-14ea-4b97-b6b4-f9d472c1b692@quicinc.com>

On Tue, Apr 08, 2025 at 01:14:50PM +0530, MANISH PANDEY wrote:
> 
> 
> On 4/8/2025 12:53 PM, Manivannan Sadhasivam wrote:
> > On Tue, Apr 08, 2025 at 11:07:58AM +0530, MANISH PANDEY wrote:
> > > 
> > > 
> > > On 4/7/2025 12:05 AM, Manivannan Sadhasivam wrote:
> > > > On Fri, Apr 04, 2025 at 11:15:39PM +0530, Manish Pandey wrote:
> > > > > Some UFS devices need additional time in hibern8 mode before exiting,
> > > > > beyond the negotiated handshaking phase between the host and device.
> > > > > Introduce a quirk to increase the PA_HIBERN8TIME parameter by 100 µs
> > > > > to ensure proper hibernation process.
> > > > > 
> > > > 
> > > > This commit message didn't mention the UFS device for which this quirk is being
> > > > applied.
> > > > 
> > > Since it's a quirk and may be applicable to other vendors also in future, so
> > > i thought to keep it general.
> > > 
> > 
> > You cannot make commit message generic. It should precisely describe the change.
> > 
> > > Will update in next patch set if required.
> > >   >> Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
> > > > > ---
> > > > >    drivers/ufs/core/ufshcd.c | 31 +++++++++++++++++++++++++++++++
> > > > >    include/ufs/ufs_quirks.h  |  6 ++++++
> > > > >    2 files changed, 37 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> > > > > index 464f13da259a..2b8203fe7b8c 100644
> > > > > --- a/drivers/ufs/core/ufshcd.c
> > > > > +++ b/drivers/ufs/core/ufshcd.c
> > > > > @@ -278,6 +278,7 @@ static const struct ufs_dev_quirk ufs_fixups[] = {
> > > > >    	  .model = UFS_ANY_MODEL,
> > > > >    	  .quirk = UFS_DEVICE_QUIRK_DELAY_BEFORE_LPM |
> > > > >    		   UFS_DEVICE_QUIRK_HOST_PA_TACTIVATE |
> > > > > +		   UFS_DEVICE_QUIRK_PA_HIBER8TIME |
> > > > >    		   UFS_DEVICE_QUIRK_RECOVERY_FROM_DL_NAC_ERRORS },
> > > > >    	{ .wmanufacturerid = UFS_VENDOR_SKHYNIX,
> > > > >    	  .model = UFS_ANY_MODEL,
> > > > > @@ -8384,6 +8385,33 @@ static int ufshcd_quirk_tune_host_pa_tactivate(struct ufs_hba *hba)
> > > > >    	return ret;
> > > > >    }
> > > > > +/**
> > > > > + * ufshcd_quirk_override_pa_h8time - Ensures proper adjustment of PA_HIBERN8TIME.
> > > > > + * @hba: per-adapter instance
> > > > > + *
> > > > > + * Some UFS devices require specific adjustments to the PA_HIBERN8TIME parameter
> > > > > + * to ensure proper hibernation timing. This function retrieves the current
> > > > > + * PA_HIBERN8TIME value and increments it by 100us.
> > > > > + */
> > > > > +static void ufshcd_quirk_override_pa_h8time(struct ufs_hba *hba)
> > > > > +{
> > > > > +	u32 pa_h8time = 0;
> > > > 
> > > > Why do you need to initialize it?
> > > > 
> > > Agree.. Not needed, will update.>> +	int ret;
> > > > > +
> > > > > +	ret = ufshcd_dme_get(hba, UIC_ARG_MIB(PA_HIBERN8TIME),
> > > > > +			&pa_h8time);
> > > > > +	if (ret) {
> > > > > +		dev_err(hba->dev, "Failed to get PA_HIBERN8TIME: %d\n", ret);
> > > > > +		return;
> > > > > +	}
> > > > > +
> > > > > +	/* Increment by 1 to increase hibernation time by 100 µs */
> > > > 
> > > >   From where the value of 100us adjustment is coming from?
> > > > 
> > > > - Mani
> > > > 
> > > These values are derived from experiments on Qualcomm SoCs.
> > > However this is also matching with ufs-exynos.c
> > > 
> > 
> > Okay. In that case, you should mention that the 100us value is derived from
> > experiments on Qcom and Samsung SoCs. Otherwise, it gives an assumption that
> > this value is universal.
> > 
> > - Mani
> > 
>  << Otherwise, it gives an assumption that this value is universal. >>
> So with this, should i add this quirk for Qcom only, or should add in
> ufshcd.c and make it common for all SoC vendors?
> 

You can add the quirk for both Qcom and Samsung. My comment was about clarifying
it in the kernel doc comments.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

