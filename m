Return-Path: <linux-kernel+bounces-875527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7D4C1947A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D2F427EB4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DA13128DA;
	Wed, 29 Oct 2025 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qQpqFvc6"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE7C3126C1
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727314; cv=none; b=SrSVvGNlz9lH+mPtxT0av9F+q528KAH39SODPQb2EnCSdypwHUZxTL6V2Ii7sW6gSExYIPViefTA1Ypn1E+JcN8x5o4KliLpQJiW67Sttph5M0t30qGs1KzHlwvxUlfLj8hO/80Vn3NaVKoPntuWnqvC1SgR1lCUi64MpVw6/L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727314; c=relaxed/simple;
	bh=ctX4MdZfx84lGeX25UkTupRgmJNk4fL9fRD5FVPxirc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wq5IJTNp0j28V5Uqve12mYVM0/Tzhjxn/knOWzU25qZ8AhVscuhIJyYrx0ZKJFDT88NJNBCtRtkfuOBNEkyD39ztli27nJK4qOdH0ZjBMmYjtT9ttKgfeaCIwIsX7jZn3wi48KheFwe/hnmJ855ksjikMmOFbadpzm/MAvjt4pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qQpqFvc6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4710a1f9e4cso56058145e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761727310; x=1762332110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uBBrlwGJ2FMdv5DZLLDl2beUjlm3lE+s6lLf/CTiy9Y=;
        b=qQpqFvc6krdl/hQx7sbdpAM7M8G/L4AdCP9Pdndk7L145jQ1siUlq2Q1ct/IiNWrLt
         38rBdReML8wpOipsJZGf1ZC5K0m5o5Z5lufwV0RwCXKRFMXDmaxVB2NzkD+J9dMC+hSS
         JlQ44uTUWR60b9uOkk0epFaE8209KerHMojNge8SOSEqS6t8E3CBlus9nCNt876xQ0h5
         p7OnPbqD+8TpiCpSbREQsDUXAJOOvRyB67oV3mqlPcR1lD1WxG3uRATJxKCo/2N99mRx
         bgJYAfyPkHNDiwqSlpAB+1VngXYzj+D6AHXbc9tjEsoxG/gNkduebBQxlM5dBtsY+Tbh
         PYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761727310; x=1762332110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBBrlwGJ2FMdv5DZLLDl2beUjlm3lE+s6lLf/CTiy9Y=;
        b=idUTRwSEgG8K8jqSyb8cJgXs2nHMOS4mkxj0mHjI8qjYxMR7L6rbFRHTtCnbZQ5fQf
         7pNy6QooIxoN2uMfLxNNm2VXcXmuFgFpk7GlteZ+44U1njVmdHJda9Ev6SeUSjtConG9
         25D+AUe5iaIu+clRUsvl6cR6ub6W7SVhvDpfyczcN0mnSXzRRcYhKnqnTiPTFUxqYZN1
         vJ/rWpmGe2LKBB0c+C+1AiyOu5tVp/7PIX3rODtfQJUYCzfYk13fxwFLeeTHaDSveFAQ
         7pRjq9B+dNctEFZ16szYD3ZEZ/nXKF57zJm8YQO/Plf06kjkIZWKccpf3/KDQIRBR5oR
         eEwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTd8vs0nJFpOgToqJ2MA3pPKhvxjijvrSSk/sb754aXH5Z4efdKgh5x1XcvlGsHqsaqj8lXLYkPT6pTi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBaRGXdEHdzSYfKSFenEXe50/fXBB73swACJq89PFToJ7vegoM
	IwsVWIVh5PI3RO91SNpyNp9jUml4kVYkvBfhnkrglwHgzWTn08/mBbWx6x2OHHn5WMA=
X-Gm-Gg: ASbGncvgEb5qtFzPMZv6ei8xRBU9BIGGlPrBkTimr031/m3F2Z9XF6kPKGekFX7AAdF
	TeQXxYW6FU5PV4b9ZN1l9Npj7Ovt2xDTQ8Mr8DKxLpQslkNBT5CgVVdeh7r9zRT9RNkNJ/cVBRw
	QUJnoA+tAnfPcWG5Yl2bWykgCJmwanuOgbNwX795u3ALTj1Kem5w+2wn/5Nb3/Hsgnl4INrDGdr
	ThuBnIgAwVUIMe7jvcojbBgH1T10dBn4a2ZnkHac7ETyWCd+HHMwWue8A9mvphGCOAvdxAH8Q2E
	sIeBSQs3Un23RI65W3yq5J4L+4QlE0EJpFsc9xQDoQpAbHdn9u18t1NR3URzAcN7T9P3LjyKVqu
	IbF7RDAUJfq7oFx3jxKjPy6ZDACImp2f1z8CYGI8Nc3Rl/x6qntmaf4MeBiu8G8VM50AbEvIf
X-Google-Smtp-Source: AGHT+IHUTSUOs0tGv7zl7KpB9ykYP2sqLOmcbk6SjkJaIKL0XDNrskTIK/G1sv7thpTY/0mBbnnZgg==
X-Received: by 2002:a05:600c:5491:b0:475:df91:de03 with SMTP id 5b1f17b1804b1-4771e20e433mr18472465e9.39.1761727310407;
        Wed, 29 Oct 2025 01:41:50 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e39380dsm34585935e9.7.2025.10.29.01.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:41:49 -0700 (PDT)
Date: Wed, 29 Oct 2025 10:41:47 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] soc: qcom: pmic_glink: Add charger PDR service
 path and service name to client data
Message-ID: <fu7rrczguihxdri6mhnc5pdllokzbaxl7heymuea2ybhyrzytj@g63qicfzbyvn>
References: <20251027212250.3847537-1-anjelique.melendez@oss.qualcomm.com>
 <20251027212250.3847537-3-anjelique.melendez@oss.qualcomm.com>
 <5uyhz4uv7ccsj7cevimqrsoywne6f5ax5j2t4uosz6a7due4ac@3x4ouutt5nwy>
 <54602e66-4692-409b-b520-2f880e0c3dd3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54602e66-4692-409b-b520-2f880e0c3dd3@oss.qualcomm.com>

On 25-10-28 16:30:28, Anjelique Melendez wrote:
> 
> 
> On 10/28/2025 10:20 AM, Abel Vesa wrote:
> > On 25-10-27 14:22:50, Anjelique Melendez wrote:
> 
> > > -		goto out_release_aux_devices;
> > > +	if (pg->data->charger_pdr_service_name && pg->data->charger_pdr_service_path) {
> > > +		service = pdr_add_lookup(pg->pdr, pg->data->charger_pdr_service_name,
> > > +					 pg->data->charger_pdr_service_path);
> > > +		if (IS_ERR(service)) {
> > > +			ret = dev_err_probe(&pdev->dev, PTR_ERR(service),
> > > +					    "failed adding pdr lookup for charger_pd\n");
> > > +			goto out_release_aux_devices;
> > > +		}
> > >   	}
> > 
> > But this does nothing on Kaanapali and Glymur. Am I wrong?
> > 
> > Yes, you do not have a charger PD on Glymur, but you do have an ssr,
> > for which you do need to register a notifier instead.
> > 
> > You need to be doing something like this:
> > https://gitlab.com/Linaro/arm64-laptops/linux/-/commit/2cd84e303d263d8fd5de3730714a16c29cc6788b
> 
> Please take a look at this change, just applied: https://lore.kernel.org/all/20250919175025.2988948-1-anjelique.melendez@oss.qualcomm.com/.

Fair enough. I think your approach is even cleaner.

Thanks.

