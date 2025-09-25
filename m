Return-Path: <linux-kernel+bounces-832525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D066BB9F943
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DF8C7BCC9D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF25A248F4E;
	Thu, 25 Sep 2025 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KHhaud+s"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE605244684
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806929; cv=none; b=NU3Q5MeC9JfVSwJHwYVECkBMvwKWF0R4C+zfNibw/ldtCMXeptGNOKdfJHLuW8azD2yfOMMVXIrCAIJ/v75dlCL4ZPCOIjZloQITDvoosD2t0duzwRL4pMAsGwQqJ/I0BW9jjrVKQ/oGU7+DGAUoWaBkG/pUHyXtTHNyrej6TOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806929; c=relaxed/simple;
	bh=1FiNIcneYN0lx2HvUgcqUBdFJAhxJjJ2x/onBI+Yrs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUuGcOGv7GM2EThvAv+btmi/ghWWfMzQy+OfUQhVIAnovUfCOXoTerwI4ZjPpP524eKYomiJRA1HaqIttnrGuSqbBQD1tfmIHq1zCJ1gI32UPN2hbvVPMpQrPco0jIMzCG+nj3rXhstDrALR/UsHLrzjtKbg81A2Vr5F0WNG4rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KHhaud+s; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3f0308469a4so614178f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758806926; x=1759411726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wp58/Fg9Zw3xoKwG1DXjRBI51T+T1GKwsDLk64qZArA=;
        b=KHhaud+sKfU9GmJ7mcrVLGKUOYK06gbcMRTOgwvCbMmQY6zBc8tsg5EBWu9tvCFTOv
         xkEcmWNS/FsRnqu9zm3Ev0huYQZja+d8dI44wgOkiY4456V75zBwgJiTfkMnKmAJxssl
         RpZnaGEkcY/EIYWC0neFYTEClurx9W3CR3ap1PmZDflZ5muMGvDXZWs0kuET+SqKybRR
         Q/61fU5FBOAngp4U4nQGtE+7Ac+a7HSv9in9LKdTvlUVYgHQRNyr/ZiJqEjuxHfGatsp
         gDrQ+ZUzgFGNnAhl58hMrLGbgn4TXFxMd/gr1rErJ8FHgdkUS6VmiyEuyTFqXgGaQriH
         aaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758806926; x=1759411726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wp58/Fg9Zw3xoKwG1DXjRBI51T+T1GKwsDLk64qZArA=;
        b=UV2afwT3kig7nkDSJeozkQw9B3VR9tVlTOHPdy9aAPAsoz7kMEKfA5r8k7R+QxMYeD
         aNJs66i3UwGL+Pg3uWc/OTdSBY/1ESppjUJnhoEEixQZSno60wB7hkEUNbU0xE33CqF0
         ppUlFC7ap4qExQSoa66R+sRzJTRnJeL4JP/+lSiDN7gaEtkzCgAx57A69ptflD67i2p+
         HsAXnMiwSMfHE6+hDBy0l47mNyDAbmOtNXT2/AqVgCtbo7LGZQpzmeSVEPtK9KYQifDD
         MJSuw2baklFxIqVcA/4XaW5XcQ941T/mQZnaVOtSqJXGP//Rx7YDeOM0tOmDxVcmOYFB
         6HSA==
X-Forwarded-Encrypted: i=1; AJvYcCX2sf02ZWI7N0j0+Vw+T8jUZxgiiMqG9Nfjxi0ZQDGMd1cLQpI3SRJcM0tgZqahFJPBRCQKIP4vnzwNmMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNFrgi+oPn57nd0nXOBy031zmvcHM8CBVFYzAgX78Qn9WhQn4D
	75ohmzevmuBG6zz/TksZGjvPf8KOrqoxzAxO0wrL0aJxLKuWFhbI4oa572717mxQbHA=
X-Gm-Gg: ASbGnctpD4qaCsxwsCfV44YiH6Xp0UeWT7h6FlU3aKNYoDsgIaSvMnkwUVj7koAynHU
	DMbRsEC5ow3edEnzD1odoZrb23+D2IQdgQxejbfw5roFEZDBfpmp6N5nsvF4SBuNGag9iMhbEzm
	guPhJ2DQ94P5TROPBYy7W1pfZle3/zySHkJ+wHE7yu0yWRZgLzMYw/khg6BpXM/WQoqpnHDjx2D
	20Fn7fsMFB5/yvZDi8vgI2t5uBdwYHzj/yHGq1yx9ZYJbkVP6lVK+lWHS9Kz+zbhv1IzTVsFjRg
	ur9IxGK5B/esNlbe8Rn3CstegIUWi/Hw0eaiWSHPYb6LaljORb2zxlkBGfUGH2T2Law8QAv1X88
	c2Z1r2I3O/C/NN6Rx3OsBpDYSknSI
X-Google-Smtp-Source: AGHT+IHEfXijaL+23iCR11cBYBG6j0gp/yAlAN7xoxHtuYkzjN8fDbBiJ7bNzYz3ne5Aj8wBn5ePpA==
X-Received: by 2002:a05:6000:2c0c:b0:3ee:1294:4780 with SMTP id ffacd0b85a97d-40e4a05bf15mr2460323f8f.30.1758806925981;
        Thu, 25 Sep 2025 06:28:45 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-40fc7e2c6b3sm3258932f8f.54.2025.09.25.06.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:28:45 -0700 (PDT)
Date: Thu, 25 Sep 2025 16:28:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: Ivan Vecera <ivecera@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] dpll: zl3073x: Fix double free in
 zl3073x_devlink_flash_update()
Message-ID: <aNVDijGWI3ZO2aOw@stanley.mountain>
References: <aNKAvXzRqk_27k7E@stanley.mountain>
 <20250924170057.GQ836419@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924170057.GQ836419@horms.kernel.org>

On Wed, Sep 24, 2025 at 06:00:57PM +0100, Simon Horman wrote:
> On Tue, Sep 23, 2025 at 02:13:01PM +0300, Dan Carpenter wrote:
> > The zl3073x_devlink_flash_prepare() function calls zl3073x_fw_free()
> > and the caller also calls zl3073x_devlink_flash_update() so it leads
> 
> s/zl3073x_devlink_flash_update/zl3073x_fw_free/ ?
> 

Sigh.  Let me resend.

regards,
dan carpenter


