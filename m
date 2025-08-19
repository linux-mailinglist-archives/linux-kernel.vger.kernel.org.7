Return-Path: <linux-kernel+bounces-774871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72D4B2B8A1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A922F3B746C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F97130FF21;
	Tue, 19 Aug 2025 05:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zPLpZ0HC"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073F92FE06D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755581243; cv=none; b=JP/mvxs/yTUZKk0V6Z83jxUceJlnY04SRy5AZFD/G7453b/jQE9znYMxrcGUYNYx1lB6I0uFimKtOAaoscuXVXV7xtw3Ij3isldCIQWpdwYe7Ik/gVrxnS2iMHh/6MvAGGhIlU0HXm+x8HxQaCJgFfUucjJorCXRT+K4PnKvfWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755581243; c=relaxed/simple;
	bh=m58pm/y93ex8Ncv061DlagzVcecj++xj/Do3CRly1jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjqdGmNmeMUXyO7zjmbFfT1ad9+EALXVVldSPry/MwNHvb6sKjoS1gqLblpbKomvFD3gDczy0S960U958Uf+yEE4t+E3iN+8SFlbN1luKATzc2jGvbdomQptIiAVb/5UbMNcx/Qb+8PGcyuQEpsQwC5RlvosQKTGDRqbWp61JIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zPLpZ0HC; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1b0cbbbaso34574675e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 22:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755581240; x=1756186040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=POjRSSun8byVdEQqP9DQ7UyrlJnob6YXd9k0xYVJVr4=;
        b=zPLpZ0HCZkNozIEAPnEkxbwb6aFyUO7jvyzQiDo1EpGW48gD8lw/iejvSJXlX1yh0T
         c5UYxE0/Z31W10ilKCSRs5MeDdkcD+OxGkPHHvZcHnPyqtQRnY7vRAosKkIc06mHumbF
         Myi11mLHljGKPLmEaHRsAt7hpptzXH6RswpmiSiubnaUxfOiHtI0pm5EiADf1pnr8O1/
         C12Nov6eLKolum/j6sq4Kqsl+PbqeJIGiL6/VjCCHM69aikjtruWFwubwyUU0ElfVOkY
         F3XkPgpcYrS5zznIjVuofxJTbHfUskIkxZY2Io5Uc6ylEg5WoxdMN0Jk2dZOndapUFna
         YFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755581240; x=1756186040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POjRSSun8byVdEQqP9DQ7UyrlJnob6YXd9k0xYVJVr4=;
        b=DF+8mB7lnzjP1LqRoOcY7zWYk9GLnuLNrPCy6hBgLuRCVBNHiL8ErexMMovLMVG/T+
         lsw+Ynl/gGi4QaS8LTYjrKvJXu63vI2OQfSuWmJnXxC871rkCrN2V1FnQyzsq8Gw2YsV
         JwdoBIUdrCsX6FQzC89Y55JMNRq2LHEB6ZnguOa8J40n68eJPl6YL5cmOPMfcSptdT3A
         7RNw/iYunrJmoxLZIUE93XCckUOOnuoGv2U3rLwDdU6uSklkz+LhR4rs7W3BvXpy1kHv
         msy1SjC0NYZAtE7ktPx4flqcdfHD020YckkyJOcVhlw6MJblXU+7cIZKfqpSBiY7t2hc
         elPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKeP9DTPi1+4Zs7nwPg/94rghjr9miHo/OwV6TFHg9B+05ro2D9erp5UrvWZsNTGgK23OFKDdT8+GFliw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzcCzsfb1j8+Pr/yeRBk3fw+OEuE+rDZPh4gwTLOr2bp0LidOj
	cnxdCBUIIDyHEcJM9aIVjCtNR7T3znt6yZyrJ0kmjRDGfEnuncZkWIqj4vWNSJpd/Ds=
X-Gm-Gg: ASbGncsFFHbjjdSKDI21jrijwLnfkAAymxuVJhEdIcvL2SDRBXX+jzIxbetngG8Jbe8
	NNUq7iNhApkCrbnNQUb3Zf6U9LXE44ZEDNsQyEqIjPVuqW+Ooa0WAKyjrwCrhloO9dWoMBoTStz
	gwexeQulKwYAGpscLzSjy4k1TOyc7sPeLY8rSk+FQ87+IL1r6VZE+334nfRrR5KgBcxz63MZGnW
	3iXkC0OCF9dmaHAPcBC8ZCSs+2vhw42x5gq7hGdRT9onKpyYv4p4W6+G6eU7ByCpzAwN21S3klg
	x/aPENyGN7GskjhPdnra1K0oihGZnmGCyWpPHVbmREuYJVKuXRMAE4BdYeO4fju+cq4qucR39gV
	mbZwxyK1iJOw8aXbaJN8QNH+Ky7o=
X-Google-Smtp-Source: AGHT+IGKYSqUDzbc4GjhgW3BDdJh5Ev2IvdZsejLJPAp4FscOBlrz16sEekNNDLRTobugxi8K9O8Kg==
X-Received: by 2002:a05:6000:2f84:b0:3b9:1c60:d795 with SMTP id ffacd0b85a97d-3c0e3337785mr885643f8f.22.1755581240310;
        Mon, 18 Aug 2025 22:27:20 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c074879864sm2110199f8f.13.2025.08.18.22.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 22:27:19 -0700 (PDT)
Date: Tue, 19 Aug 2025 08:27:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Steve French <smfrench@gmail.com>
Cc: Wang Zhaolong <wangzhaolong@huaweicloud.com>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] smb: client: Fix NULL vs ERR_PTR() returns in
 cifs_get_tcon_super()
Message-ID: <aKQLNODuSBvUP4_F@stanley.mountain>
References: <aKL5dUyf7UWcQNvW@stanley.mountain>
 <89a2023c-e383-4780-83e3-ba8f9e44c015@huaweicloud.com>
 <CAH2r5muVjS+Y_NFSWwYoisPGfynyTkmynjpQHi2_Kk6Z8AiG0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5muVjS+Y_NFSWwYoisPGfynyTkmynjpQHi2_Kk6Z8AiG0w@mail.gmail.com>

On Mon, Aug 18, 2025 at 04:41:52PM -0500, Steve French wrote:
> Since Paulo pointed out a problem with v4 of this patch, an obvious
> question is Dan's patch "independent enough" to take or would it make
> the v5 of your patch harder.  Let me know when there is a v5 of the
> patch so we can do more testing and review
> 

Probably it's best to just fix this in version 5 instead of sending a
separate fix patch.

regards,
dan carpenter


