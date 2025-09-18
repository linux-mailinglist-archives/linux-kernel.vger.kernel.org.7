Return-Path: <linux-kernel+bounces-822814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DF0B84BA5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A49A27A906B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08D230277A;
	Thu, 18 Sep 2025 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YoAnsHq0"
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB691E1E1B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200551; cv=none; b=S/U+bXydyJWFKFpJ+9jdO1KRLzu99waVGVHqK1byzJNdwPhGbzh1HJyafTxDDBmWo0CnFTz3EFj8swvzoqNoxxKO0jwaFKkXF9SdKpi9PS/yBnntxU7MszH7fNllbrj2xRvnUZ5ygFJ/8U20NHw7LVBWpeLnIgylyKGQkRoVazw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200551; c=relaxed/simple;
	bh=pNG+InEIeVE5jh10Z56aIojWZnOwbe1cuSvsD4fE6FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9WTgF8sFoVhCLEqjS60L8wvAGCAVuyFtUnhpdmvv/n6EMIJslqSg5U1o6UxgzB2o1kd5jwQ236ovwThgm+qXByJRBWsP3eALBTfu1Fw6mK7eaDylVFQcq2h6lVnwSNTJVZ7zghanV9kIT5R6LoSgWiycMmL+cq6SCfkOlf8/Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YoAnsHq0; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-afcb7322da8so162894066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758200547; x=1758805347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aIzDbyhYpuaBXUrKMka7lKnhRt47H5xyoFzXDbV9fD0=;
        b=YoAnsHq0edX7E6Jx0CU87FeFRTtyIDPqQaODc+Ir1iiR97/ckLeQsQWhV+J8RYUraW
         YAhQ1NVCXipZOtjZHbJRBeuYeS4igmJXaPeqsKdgtlwiLBsfgy8Ax86y8UdOSOD5vabg
         88enr4NdARSkttk+iunUX01enHmNIrHi0fcjdaLPIsEkejFnVXBFRpNRHjlUHf/Qe8u6
         KmYf9SNAAmXO0rYQe/rQ/el3KqAoNBouOdBTs9MJkHHnUXpfsMkeJdlKxPtFMsOeyYs4
         94Vdy5DvL82KGnZinOSY4drVZtFEkcLwpAdl39OmDZLtk4sAbdpYll06R/v6vd/QHeoG
         HDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758200547; x=1758805347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIzDbyhYpuaBXUrKMka7lKnhRt47H5xyoFzXDbV9fD0=;
        b=neNW93BF46D+OK4pM4BQzHpw7VVu/2T4odLFBaeVru+bat+kUPSqDze7XkQEIUNI2j
         bpfV8YL1J3ILzpzqFrrRwbhvRGdWMStj/n7q+klFFpZwoFb+nk5x0jb0degz500FHkFp
         mACvNHhw7DCrlb452j/nCEATzNyWealc62pSUpIAuviuaEg5gNbSRLP/af3Xji5yN7Sw
         4NwHqrl3+U4nzBKOiLufgHnPvgKdU/PukXFHqcGfPOi5hvE/mj8eU1d3D4E8TBL3FfZO
         CGgbVviSE6JTOIA5yxTaRM26t1lQBZWOwsj4F8nG1hDpV3lcSVch9Oe3SjPNJZPC9R+L
         G9Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVRmHYMD33C8B2WYSNc7m8plfIWQJEjyzPbThG6YkjZzY7Xctf7h8JV8B0hREC3++igRsyPzSPBq9HFQ9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUuORuhvEQr1OMlUsM2EZQiY6QtWTR+qGQ8Jlwlt4DqYbH0n5j
	bF3D1bwWltt/WqW4T7Gxep0rlVzk7RA0AS1355VUXrir+GYDu3X+AuIqW0uJSEb+D3I=
X-Gm-Gg: ASbGnctoJHstJ6T116a4nYqa2hyaLuzUq5nPykIIgwnpbcZl42o5EIRqPQMFbtuSw6a
	AgWE9MqE5yR/61VnIiA9Sf9T5v2vk62k5AN6pbA9qItml4XlRz35LgAtB+znmP7L+b/gmWSI7Iy
	Vti2BBdWamPN1/O8Jc9s2wl0PTgJL61VZinZiqiJIUphHGl1DKGw6K39GIhZvzzmKh5eHf4RCos
	dxVlDolyTSZJOKBXLGDSbUfB1P8dj2ztih95Yh7kLmt3tJFZKUfmGqO/EdQ7omSQCMe0SdAS1h5
	3VB619E6lfb/FnGSHDJrzD0Z9GhGMRr4jDO11aiKyabTPFkXa3ByTWoZ6hoF1vQKH4xB42Ewysl
	gdaDWZcEQV6pG5fSbRu7V2XuOTjngmhV0rxBysn5yD+NR
X-Google-Smtp-Source: AGHT+IE4mI2rDB6qnxX4AnK+7Sl4B8jgUrUQKivo/eG6grifwlwBSBfvXGxUWSy1bqE3hTsahdhF/w==
X-Received: by 2002:a17:907:9604:b0:b0a:aa7e:a191 with SMTP id a640c23a62f3a-b1bbb733fc4mr655010666b.57.1758200546741;
        Thu, 18 Sep 2025 06:02:26 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5d437b1sm1427249a12.22.2025.09.18.06.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 06:02:26 -0700 (PDT)
Date: Thu, 18 Sep 2025 15:02:24 +0200
From: Petr Mladek <pmladek@suse.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v4 1/5] printk: nbcon: Export console_is_usable
Message-ID: <aMwC4HAYjpWpZDMj@pathway.suse.cz>
References: <20250915-nbcon-kgdboc-v4-0-e2b6753bb566@suse.com>
 <20250915-nbcon-kgdboc-v4-1-e2b6753bb566@suse.com>
 <aMp4BrEpqXOW9nam@pathway.suse.cz>
 <dad15813cfdc3b7c77ba71266e38a137d0015bcd.camel@suse.com>
 <20250917-imaginary-vigorous-condor-fccdc1@lemur>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-imaginary-vigorous-condor-fccdc1@lemur>

On Wed 2025-09-17 10:07:47, Konstantin Ryabitsev wrote:
> On Wed, Sep 17, 2025 at 09:21:48AM -0300, Marcos Paulo de Souza wrote:
> > > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > > 
> > > It means that Macros developed a patch and Petr reviewed it.
> > > The patch was not longer modified.
> 
> That's not entirely correct. The signed-off trailer is used as the boundary
> indicating who was the person responsible for collecting the trailers. When
> the trailers are collected by the original author as part of their iteration
> cycles, their signed-off-by trailer goes below any trailers they have
> received.

This is an interesting interpretation. I am just curious. Has this
already been discussed anywhere, please?

It seems that the ordering of the trailers is not much described
in the process documentation, see
https://docs.kernel.org/process/submitting-patches.html

Best Regards,
Petr

