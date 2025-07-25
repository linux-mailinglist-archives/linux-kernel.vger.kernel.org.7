Return-Path: <linux-kernel+bounces-745493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB82FB11AB4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B698C177C05
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC9A2D028A;
	Fri, 25 Jul 2025 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A+PongbX"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15AC253932
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753435122; cv=none; b=HMcKsArJmaq5a3NijFTNVlWi5RybR9r7lTPLMfC2n9b7YucfkcS5s4VYF7QT8Bq6L7Dbzq/XX4B+otOgSFESfZPedcsxWLqbCxUF1fv6ODWffGR5Zb6XzDCRW/3FSt2d2lsP3hYrdSenKQu57Tk6sGUkF8z1t+ENyOVoJpFtWC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753435122; c=relaxed/simple;
	bh=xpef2y2maBnIdrYwyhOyyrKOl5EEcqRqvsYz90m6gd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FClbnPFBm0IOGbHg/SralcLL5uIXb8Ug/mYyuWb6P5X60lFgtu6VcI2qvJUzmEn+yc0bFLYI4ucMpHVrCWe8HvJJFT4QAjwvAGpNN/cOr2qGiXuQ1SWdv3ecoERq29nuKJLw4xUvbD/Xy8j5cnb3VvbrHvDfEgjItQBOFAAD4MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A+PongbX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4562b2d98bcso27345e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 02:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753435119; x=1754039919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rx1cvWLmG31uLnbCDZX1np35fkcLxkLr007ob70MLnA=;
        b=A+PongbX3p6F5vV3Y8nPX7NDUJis/U5Z6z/e2eCdkuIA2JJsEV6A0vNz41Yj/sw3WJ
         bi+ajPClBlc0mMuIf+aQtEO4FK+b/uGUrZ2qWZP6hKSX4WMGh/EtZcYwwURdnHiFIHK0
         wpNxp/NI4Rwtv5/NlAOfeHNFPC1zHiJz8waoRQ/cBwsPKt03fO6wAedz9AaUiWb+PtI6
         bRVIoutD9L/NTyJpRrvB2sHPsjE4tyxGEbxDYte2aYhXPOt22L61FgK2sWyk+DtY0bzs
         2244N0c1btwUPCRrAEhoesVbS7XATw6GoMC3rgyAB4q3UnHaXFuaObXH2fT156U92W3L
         /gwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753435119; x=1754039919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rx1cvWLmG31uLnbCDZX1np35fkcLxkLr007ob70MLnA=;
        b=q64Nzw42JYusmdgJw1aGfNYJvTG3QYgje8zR8w1J6T4GqlXDzc4aAOEicfhLb0pJfW
         95uHDVvqhhRzHvoXtphA5Yv3K8LNJIzi25XTrmsYWZEATK6+0K8p45YVJ7UUIGgYCpPB
         XGeQad39Vm4Gr+t7mlmooQTFDzLXCTVNl9tr+25NPoFKXnuO5Yhuz90Ow6kC3mKkazsi
         jp05Febb/w7V9YvaCQG+22Z88qFzysRkjILcrOqFmMUl9m09+U7Bl6RElzd3Huo/VOem
         1J+bGsImbYUcPC0M/UAHKOHv4szX6V3pt/g74NE5jYGFDBWYYJzlO7DnvbIA6UCvMSK7
         g/8A==
X-Forwarded-Encrypted: i=1; AJvYcCWtdQvizBrvgxvj+dqnK1GytJrL8RTlA14L5XYuQK94dPaz0khRIolo+fsMLH6J686VHc2OSkrSMMfEzJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjXrophslelqDJ9oN6hEFvjqcuMp1T9sccGPGpj5qNDOkdFRgZ
	6PHaXd5FUg5eUllGwg3w7kQ5pmiSWTGhhul3J8LCEIV708gFWjIqC8gNrCTmiAUTqQ==
X-Gm-Gg: ASbGncsoSxw4mXG/uNh5yQArhRT5G6eLnfnATBWYOFvpV4sbkNIWMw5g03wnlPxde59
	gaNZSLjUhcGEi9/YYa/uiQT7Zc8Bv2jNUx0dFSacAP/dwmf8+UyF+uOIbVEnzBKx4oL29zmXFhQ
	w3dsWJo6gTw8ZjibAscidkuuYVU3MZvBub0Lh3hJ9HoTEoaud+ZIhlErWHblH5Wf55AkJC8beXs
	KDuTxEKyuZerY5k+ESYzSnYNSqA3zIchDQcxNXcUSiRZROFBu3DVF5K5RCxgjd1PrYMaM0mxT1X
	IgoP3PQ6mt9ZP91P3ONakGi7FHC5qGJizx+TKjeG1+kV3UdD5yUr2gcQ26ZwJnLWs/83+XyIci5
	QSFmRKLsPQpQqS+xgEs3luIu4xLLZvHw5LQeXNURZTzoN/PNiZ2WuB125c7LX++Yhw7Rb
X-Google-Smtp-Source: AGHT+IG/k0Q54xhpN2oIpbKY4vSeV5TCdZSBuTuoauwrucxpglZQHZulK/b5JzyYYm2oFY7AoMBuLw==
X-Received: by 2002:a05:600c:548b:b0:455:fb2e:95e9 with SMTP id 5b1f17b1804b1-458730cfd06mr1447805e9.6.1753435119066;
        Fri, 25 Jul 2025 02:18:39 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705c4dbdsm49065635e9.25.2025.07.25.02.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 02:18:38 -0700 (PDT)
Date: Fri, 25 Jul 2025 09:18:35 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>, jgg@nvidia.com, will@kernel.org,
	joro@8bytes.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Replace vsmmu_size/type with
 get_viommu_size
Message-ID: <aINL66r_1NO3Nx-f@google.com>
References: <20250721200444.1740461-1-nicolinc@nvidia.com>
 <20250721200444.1740461-3-nicolinc@nvidia.com>
 <aIDlsUvF2Xbdelvx@google.com>
 <aIEkZoTOSlQ0nMKd@Asurada-Nvidia>
 <aIEwzM7mKUI8-h9U@google.com>
 <aIKd1owebUNQeN1-@google.com>
 <aIKqaGMMpsIuAVab@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIKqaGMMpsIuAVab@Asurada-Nvidia>

Hi Nicolin,

On Thu, Jul 24, 2025 at 02:49:28PM -0700, Nicolin Chen wrote:
> On Thu, Jul 24, 2025 at 08:55:50PM +0000, Pranjal Shrivastava wrote:
> > On Wed, Jul 23, 2025 at 06:58:20PM +0000, Pranjal Shrivastava wrote:
> > > On Wed, Jul 23, 2025 at 11:05:26AM -0700, Nicolin Chen wrote:
> > > > On Wed, Jul 23, 2025 at 01:37:53PM +0000, Pranjal Shrivastava wrote:
> > > > > On Mon, Jul 21, 2025 at 01:04:44PM -0700, Nicolin Chen wrote:
> > > > > > @@ -1273,6 +1279,10 @@ tegra241_cmdqv_init_vintf_user(struct arm_vsmmu *vsmmu,
> > > > > >  	phys_addr_t page0_base;
> > > > > >  	int ret;
> > > > > >  
> > > > > > +	/* Unsupported type was rejected in tegra241_cmdqv_get_vintf_size() */
> > 
> > Sorry, if this wasn't clear in the previous comment. I meant this
> > comment must be updated, the "unsupported type" wasn't rejected in
> > vintf_size, rather the type got corrupted which brought us here.
> 
> Any unsupported type would be indeed rejected by the init op
> callback. There is nothing wrong with that statement.
> 
> It indicates that we shouldn't see an unsupported type here,
> unless some serious kernel bug like data corruption happens,
> which is implied by the WARN_ON itself.
> 
> > Had the
> > vintf_size rejected it, we wouldn't be calling the init op.
> 
> A data corruption could happen any time, not related to the
> init op. A concurrent buggy thread can overwrite the vIOMMU
> object when a write access to its adjacent memory overflows.

Can you please elaborate on that, as memory corruption can happen
any time event after the next check and there is no way to defend
against that?

Thanks,
Mostafa

> 
> Nicolin

