Return-Path: <linux-kernel+bounces-807714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1CEB4A85A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835F13B18FE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043122C11D3;
	Tue,  9 Sep 2025 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+epI0zh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027D629CB4D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757410794; cv=none; b=RjroyThQfKHDb2oKQD9tpzxWGpNZmKzeqJA3ToO9F7pV6UlRw+Pe5k0EHNcGJ1YNc8rU2kBBuZjTfnV2hHhp7t3gUhcKd9PGoGJ3jmxzJkA6s1DI7SkauNTA34U+/ina+SVwAcW31OkJbmcR9bwIGb1GiNiT2udxeZQcbSwZEL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757410794; c=relaxed/simple;
	bh=ZqTIhoxpRaUsXfMaG4XVvb6F65/P00Xs0kV9aEsz0ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZm8wkEnekpuVuR5HgDmfze1Ho0aQ5K26m47qmczrc0Iqlt3l7IemfpyTztnPirI9AfapQ1vPs/wgebqOQg8Fws329rakB//ONTtNK1d3U7pltDsxWmBGjYADSOqCghO09xfMgY+pEi1UTQZNJl35RcCBH0KmkyQIwlAE5ueB5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+epI0zh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757410791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R5SuLPKP6QNmvh1TmNhSBXqAPxbhjyq+GV6/uflQ99Y=;
	b=Y+epI0zh2NvHJ8tNDM4XfDtVs0zfX/m/9+oXaBSyGwyINeR1dClIC5KHuTdTEg3dYAT+/9
	wAdLCS/QQuun/oCkIdguX57GUSsBu8pMFNhNQyhEj7UesGTUAw+3lp3dMV8FzybfobO11v
	GhswMExGX3udNIAfH8dqfFzK2EgIWuo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-0TdbfjEjPsa_95BecGNqCw-1; Tue, 09 Sep 2025 05:39:50 -0400
X-MC-Unique: 0TdbfjEjPsa_95BecGNqCw-1
X-Mimecast-MFC-AGG-ID: 0TdbfjEjPsa_95BecGNqCw_1757410790
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b60dd9634dso51144851cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 02:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757410790; x=1758015590;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5SuLPKP6QNmvh1TmNhSBXqAPxbhjyq+GV6/uflQ99Y=;
        b=Wi/Te2q6p8tfiEBc8nS27O8OuL5GxBFstZsAy09VvK6JbnGf1ga0/ZMZHirT86UByg
         57uqIEED7dboRS02PF/fwzjXWyk2NXVnX82hk79ygUanqL9iqZQcWMJ6XtPg2y4XqXqy
         jXVboyC99lEX/0wJ906HwkzPTBqIAL3+RM/AhNp1YjZsO0OlGqiuKXpwzHwErTK5+Wck
         SxHxcNdPxW/zpTSki/gH9mzVMZLEZN2wf5q8IVbIlWWlZEPMe4AofuN/r8InBpchscrK
         J46SFDIyepNOVHWlW33aLVsuykjpGQGElqPQBR0doP+kaAo20zh84NHOrFhvKmM+J5m5
         R8/A==
X-Forwarded-Encrypted: i=1; AJvYcCW0MhyMbEEvpfVZIxAbmAty5orBZ49cfHzCKGsUHKyz+fJzjYBHObfEpOiyeJemNOGcGgLXAiSHiFYEtRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YySfY7bycqVQO5B994BPgc3sKu1h+gGx6jGurmQSe5EdPK/L8S6
	wbLae4gSh+FXTd+11tMccLjjGFRM55glJJDep1EW+Izdg7xxEE9NIxSJ/n9NrheEPijgmjmfZsl
	dZJaz8GcNEM9fU/aT0cVOu2kuV2bM/GaKSCABC2CsiDIl8jGgVC8BV/SQu8B32cwYdw==
X-Gm-Gg: ASbGnct5DHU89b2uMge4HyzE9aQ0HvFGCxCwvmcgOgPP7XeVaihdu70TMcX85EhW9To
	7KyXw2ekDOwpk/SVs1X2b0SrF0tKg1eLeZWIldWVIcRfOKXQbzLvtnpE7omewGXEhYLhQLe4UVx
	nl87hFyggCNFrH1QxvQnYlFq0WD6xgNw8oCPEajQ4PtDiXU+ZaiB4hWAAv3pbkLPNU/81FPSJVa
	mV1LvvpuADaH1mcN4W5aaEfaFhIkHnCcQZiNI6FrJeck5Xg9PQ2fhl/QNSTl+iAH8bApWkjcu/j
	yM+blHjJIiegJ49gmQsU/BS+a3gx+kQLSsjH4mvjP8wJCA6NwHWoohVlngyod+yAvKqN4j1pdyd
	uez+IqMgjDIttcbWf6Ks=
X-Received: by 2002:a05:622a:14d:b0:4b2:8ac4:ef4a with SMTP id d75a77b69052e-4b5f848239dmr100627871cf.65.1757410789861;
        Tue, 09 Sep 2025 02:39:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF32u03YWf0xFsHNwv4lu2FNzdlBMcHC/jd+orwwY/MAKlb650jQ6YeSwxCEA5UmnrgNTF0kw==
X-Received: by 2002:a05:622a:14d:b0:4b2:8ac4:ef4a with SMTP id d75a77b69052e-4b5f848239dmr100627741cf.65.1757410789492;
        Tue, 09 Sep 2025 02:39:49 -0700 (PDT)
Received: from x1 (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b61bbbc28csm6792371cf.28.2025.09.09.02.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:39:47 -0700 (PDT)
Date: Tue, 9 Sep 2025 05:39:45 -0400
From: Brian Masney <bmasney@redhat.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] clk: conf: Support assigned-clock-sscs
Message-ID: <aL_14XofqnwAd3QE@x1>
References: <20250901-clk-ssc-version1-v2-0-1d0a486dffe6@nxp.com>
 <20250901-clk-ssc-version1-v2-2-1d0a486dffe6@nxp.com>
 <aLdmXcdJnoeXEJaQ@x1>
 <20250909085013.GA26483@nxa18884-linux.ap.freescale.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909085013.GA26483@nxa18884-linux.ap.freescale.net>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Tue, Sep 09, 2025 at 04:50:13PM +0800, Peng Fan wrote:
> Hi Brian,
> On Tue, Sep 02, 2025 at 05:49:17PM -0400, Brian Masney wrote:
> [...]
> >> +		if (IS_ERR(clk)) {
> >> +			if (PTR_ERR(clk) != -EPROBE_DEFER)
> >> +				pr_warn("clk: couldn't get clock %d for %pOF\n",
> >> +					index, node);
> >> +			return PTR_ERR(clk);
> >
> >This chunk can be replaced with dev_warn_probe(). Sorry I missed that in
> >v1. Otherwise the rest looks good to me. With that fixed:
> 
> dev_warn_probe() could not be used here. There is no 'device' pointer
> here.

Ahh ok, gotcha.

> I take __set_clk_parents() as example here, so use pr_warn().
> 
> >
> >Reviewed-by: Brian Masney <bmasney@redhat.com>
> 
> Could I still keep this tag with keeping pr_warn()?

Yes. Thank you!

Brian


