Return-Path: <linux-kernel+bounces-874136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89771C1593A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED0BA355481
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFCD347BBA;
	Tue, 28 Oct 2025 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aI7T47Jt"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18227341645
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666277; cv=none; b=t0ZlhuchtjD638jfNeJJuHlBYpbwZ8OSEcDy9QbS9OndEmoONfvaH03wlemb24RFHVnjxGWEmHH62zUCEGgNQEra+2H1vKB1N7YbaNKvmM5fr2Kg8vD4ls+yZ3GF9x+1284L85OwIVNrvcNNLFkyVbwWshuc4U0WKQiydjD6ZPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666277; c=relaxed/simple;
	bh=ZeWbW3cwFzTk+snUQ1YZru5uS3rdocJhJhmNIAkZTos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Elg4qRBZ1hod11jRyPqaGpVNMGkt9eSGEBu4GDggSIod6cY4B8s1d8smVBi/uSuIhvHWOSrNz+JqFrFM4MkXSoN7WCe9QVRaItWZ03InbyrCH8U2ljLwXx/yeqO4G8CxA8sOKQn3MPBUEHgkJxdk+KCgWZeY2asXDMMJj8iaM+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aI7T47Jt; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-475dae5d473so36370565e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761666273; x=1762271073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kxDtTm5Uk2GlvziLH671chbdmWE90Ft/hZE2+B8F9lE=;
        b=aI7T47JtgV8TEWD/on7n8AyrcVYxh7MD90BkXCGHPwbX8pP9tco9CL9WLzg1OHL7oP
         tv2EJLkXIeyd0dOt/OPaKBdXNVMsWvHEniGMRW48UCQNhTb/uzeAU38E9IaPrO3mG4I2
         g1O5OyohVFvNP58oNm/1HTkjNPQ+y3MINs5iDd6xP4yr0dCP4+Mwt3jSpmPoeqOQuRWR
         JivNwjGapCJeckXJfpXrBt95VUiQ+mj5/sDlroucvAFSjvqPg+DdjcqfKFy6N17S/f6r
         UwqJL5ZjXzjZaE+9hOFTv0vpBv117p8+WOTtEnsVdm9tLKBNmpTT77wa2Y8Go2NdWWqt
         0DzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761666273; x=1762271073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxDtTm5Uk2GlvziLH671chbdmWE90Ft/hZE2+B8F9lE=;
        b=Ag0b5WEEonIsoblM1aYxmeV/QN0A9gKr05U8uTCqC6YlwojUx/7BgaYrC6L3ut/QGT
         Tg6igAeSdcczOX0SyT7D21kFkhqRilLnSnQl0uMTe1VXz9HCJQ27/rvH/v2zyEdzNLp1
         TUY1Vwxj2J+xp6yJDoD65wzZwafThfzu1e3cGZxVbntmYLCnaNF2+6enhHIes7l4raPS
         NDv+QIB1XfJY7CBDs5wKWnrdOmPSQb2l/YZ85Woeoyn20Ew03pxn4xhIHKF+SMS7N/8n
         oPtOr9SFGtS4ddkaxxk90csNQ7ER/1giTaGxccZSvv3/aR45gwIJ9h4aOE2rFcIH+dPU
         9x5w==
X-Forwarded-Encrypted: i=1; AJvYcCXF1ZsR0e3qDHv2vyt6cbKNF6Sd5PHYquVmgB5FD22R8aPqrC086sy9+fAIdXGyGSAF/EJknPdX/1pZTRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfxIqSnLN5BFnm3wwe8X/39zr5JCRVGWxYOYz5uIIK+P4gabM/
	h0i2mRPqp3YHuk24JmMi/CvjnEnr2yHiQ2KmfCSJR0UUGC2F+AZEOrO8ButzujSfs9A=
X-Gm-Gg: ASbGncsRV/zSRmIe6LM9wHiblCQyxGRCQZAeRAA0j+faFjwYOa59pEmdxPRiZpShW+3
	FwkNLY+RWvUmh7udTMCKeRw4NvP/ZuATg5iF9YYqbjeiPzs31tr6yj96l3IewwdQ0K9F0Q29Zy2
	iKOFqNNiVSaOiTp5BXo749lTwJxW8V+RN6lW47ai6D/sxTthIMT23ZZnn4Znm3bvVxx8b3SVvf7
	xiECcF+KeM858nKXbr4PwZ8fW7l3CqMbIBgqKJrDBdSJiclgxm2o2wBNroPedsGubjEEZpAgPL0
	fxmPtM8e5NjxNV15T8saqwY5LtlGGY+0i2quQ9IqtDvRl+M7WbfvbOA+GXKsmHFYRx8P7zfkYIx
	Kj4Q27eut1qecK1QVAAM0xqQlIQ3Q1Hh409kLfXQdo/CMH9OA6GQqOtp7OpNOOr9GVcA7V9d2
X-Google-Smtp-Source: AGHT+IFaU/N5jEahD1Hr0mgcuydBUovhHsTFqREepEo8khWPEdTWoHTHChqz2NMEQuQxs+evxhHULw==
X-Received: by 2002:a05:600c:46c4:b0:46e:46c7:b79a with SMTP id 5b1f17b1804b1-47717df4dd5mr41181545e9.2.1761666273275;
        Tue, 28 Oct 2025 08:44:33 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd374e4esm195344815e9.11.2025.10.28.08.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:44:32 -0700 (PDT)
Date: Tue, 28 Oct 2025 17:44:31 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Skip setting orientation for UCSI
 version 2.0 and above
Message-ID: <ikwmc2pigfq3pagcetssxkl3u27ozucrwku2f64qd5hvaonna7@3dj6s24dc7e3>
References: <20251028-ucsi-glink-skip-orientation-for-ucsi-v2-v1-1-93e936ac59b4@linaro.org>
 <a4f3yhhz5sntno6gnfbjnjjsbtyo2e4y3da2aywsg36gvxkaxg@vw2vryukrepl>
 <xboq73zw752odclybviqnl75pp2nl2eamdvcdv2idqljck7qvu@zdh6ny7nja3w>
 <jworx6dkoykwimfn7b3wlatgvk6engrbzyuhzsqbgjivlpicjw@xg2aenqcwkmz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jworx6dkoykwimfn7b3wlatgvk6engrbzyuhzsqbgjivlpicjw@xg2aenqcwkmz>

On 25-10-28 17:37:45, Abel Vesa wrote:
> On 25-10-28 17:30:37, Dmitry Baryshkov wrote:
> > On Tue, Oct 28, 2025 at 05:19:58PM +0200, Abel Vesa wrote:
> > > On 25-10-28 16:39:19, Abel Vesa wrote:
> > > > In case of UCSI version 2.0 and above, if the orientation is set from
> > > > glink as well, it will trigger the consumers along the graph (PHYs,
> > > > repeaters and so on) to reconfigure a second time. This might break
> > > > the consumer drivers which aren't currently implemented to drop the
> > > > second request of setting the same orientation.
> > > > 
> > > > So lets leave the orientation setting to the UCSI generic implementation
> > > > for all platform that implement UCSI spec 2.0 and above.
> > > > 
> > > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > 
> > > Ignore this one please, as it is incomplete.
> > > 
> > > We need to also set the orientation_aware in pmic_glink_ucsi_update_connector()
> > > if the ucsi version is at least 2.0.
> > 
> > Note, I think it should be set in the core rather than setting it in the
> > driver.
> 
> Yep. I agree.
> 
> That's what I'm doing next.

There you go:

https://lore.kernel.org/r/20251028-b4-ucsi-set-orientation-aware-on-version-2-and-above-v1-1-d3425f5679af@linaro.org

