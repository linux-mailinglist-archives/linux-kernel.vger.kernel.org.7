Return-Path: <linux-kernel+bounces-890410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59604C3FFE2
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 13:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AED1234AFD9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 12:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074A22BE032;
	Fri,  7 Nov 2025 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QNjRTMBx"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF2B274FE8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762519953; cv=none; b=tepAEEMfQ26BUKn7nr72jDpYF9CmAyVMOMLUruEicF2uRveqqvL2MqQrzpC+6Ng2A+DqwWS/GKI5qpDpFutoqmRuqhq2BltdNX2Bzhxmd+7PkmNJwz0zGsq5hfJJpFniB6BbMK4td3ZX+PfLVGPY7FWZ0oFYJaVHYJQeL6cMFj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762519953; c=relaxed/simple;
	bh=snI4yqGepDdWNnY0kbg2UNmoXx+IQh7u1C5ywqjd/MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4sG7cknx0x9P8mDMh6BLhhW7Vkfyd8qPlQwhaYZaBZnmIQLkEgZNhTnEpLJMLqVHI9ofgJprJsfhk7BnKpXuKqh3rSN/lWkrPo/9/huH+F6z6Tn0LsP6RnLUbypJ/UsmZiDQ/qeL1jVL/nVmndm+A1IUQEvXy3F2qsC9Xna6tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QNjRTMBx; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640b0639dabso1359608a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 04:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762519950; x=1763124750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1K/WGyrSvPxGdmHGTAm83AxLQquBqybYtMrmz64lWv4=;
        b=QNjRTMBx9T1Yw861AigEB7mgXG7Psqi/QMo+dMfXkN91Q5iYliuex0rGKMWT6rj7qL
         8bn8ptrpyQWiuGeDyJxQZCFw/EVUlIYCjWK/oi5QxpNtps6YAIKoZDKNgKrHYYjx5KXM
         +oPsZu9VRu6bgzD8v2oHwG/tH6QqH0xs3F/Km7gqEfAMuWX1zCftLp83nmw+3tAhdS9b
         Uu+uI049IB8dMHWkv+JYeJrpV7aiT73Z62y5RnftF9OOh5tFpeaKHfvVo6nD75cU/VWI
         iDE0psv82sm7u9EJk6UjVmVsMW4mZF+8HTa6b1s6uAEJKrydG3LA3bkvZbfCJKohlyiV
         YwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762519950; x=1763124750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1K/WGyrSvPxGdmHGTAm83AxLQquBqybYtMrmz64lWv4=;
        b=iq4FqLEPxOSEBBF3kVz5LAwGDJ1I2QFWfCn9k4pwPU6Us/ycZKN+9EdccIteCmrj2B
         wwsfk6/04cSgok7+vlqSa8BxqCrewQ3VKxi4Tfn+k9CKaNtVFV61wNXJkA+tflbkzynB
         9JaDwTRzkYu6UqnFrPmHa5odW34+2wMsoxUEZrceEtD0q4xFEg/0ep36EfHedMDwKryt
         OZp0OmXDd2QobtM44VlR4Yl+zXI3tuEn0DZWAQhNEwYgLiHPmd1IgknTifCyYxNXnQsg
         o8Hel2l8iKadyTtXOsOxep7kn04QVnbcjFjSf2TJcaeYpqDDVAOi7wgin6xSnqHt+kp0
         s4MA==
X-Forwarded-Encrypted: i=1; AJvYcCWbFTG+JB+zmsnLSqEzGgDQBcaHWEL5EN7Q/AqrTKo20MsFXDWP292DZAabboHGhdNvGLOpUcZzq4TbUEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHleVPvuZjFj/+/Wz0Wsy0cxZDjRwQEnmc7m1vpqepSXBVwrdz
	n9aOPEr3VCOnT9nmG7VvLycBmEgQpD9iFbfahjaTyrcwoFAh6HlZ9Cy641vGxy9bSsXNjvrFR5P
	OiEPa
X-Gm-Gg: ASbGncvmXhwQSA213G8uSdIL0as2sPs3hGJ8rTKSaRYqNRzHURNLHlj2RhBDLQAfOb4
	0VxokHnvPtHnOuSXYxOeuuG2j0TQBbz+U4RPdoxQfMEyaahyXQwwJFEFZfoL7zEmyDrGNrscSui
	EPycUze//SO3a+gtB5wnVB4C978fMZrK4JJwWLTYnhPPiegRAG1xDjHGpOgi3kBjoFfCv4+WjNJ
	OVtgA1KJmLZTPs0qd+El6IanwjOq5P2cgPyqVCU84pE6sR3Prg4/ZBNxVKaElopA1aavbFotaxZ
	C9TwM3istifbJdCg/WTecjEoPaviMB2nY24I3VJegqKfizjsCV6HY+zYyHaH6TohnOGzWTJ4ivk
	hU/uitNKLBEqGxonUMlGIKSa+NQjYjQE9yC+C+XnjouSXO4r0LDJDo45/BCPFaFPamVQJ8cho3z
	MaQqGRc67J/slUbA==
X-Google-Smtp-Source: AGHT+IFRXKZs5/2DM3+3kiNXkbk52MOjdWuG5THbqAxP2FWnWGBNPVkzgPQQurODQzOo7kyJEIWPlg==
X-Received: by 2002:a05:6402:3551:b0:640:c779:909 with SMTP id 4fb4d7f45d1cf-6413f05a3demr3023096a12.27.1762519949785;
        Fri, 07 Nov 2025 04:52:29 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f8142b9sm3988302a12.12.2025.11.07.04.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 04:52:29 -0800 (PST)
Date: Fri, 7 Nov 2025 13:52:27 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Laight <david.laight.linux@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Junrui Luo <moonafterrain@outlook.com>,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org, tiwai@suse.com,
	perex@perex.cz, linux-sound@vger.kernel.org, mchehab@kernel.org,
	awalls@md.metrocast.net, linux-media@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] lib/sprintf: add scnprintf_append() helper function
Message-ID: <aQ3riwUO_3v3UOvj@pathway.suse.cz>
References: <20251107051616.21606-1-moonafterrain@outlook.com>
 <SYBPR01MB788110A77D7F0F7A27F0974FAFC3A@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <20251106213833.546c8eaba8aec6aa6a5e30b6@linux-foundation.org>
 <20251107091246.4e5900f4@pumpkin>
 <aQ29Zzajef81E2DZ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ29Zzajef81E2DZ@smile.fi.intel.com>

On Fri 2025-11-07 11:35:35, Andy Shevchenko wrote:
> On Fri, Nov 07, 2025 at 09:12:46AM +0000, David Laight wrote:
> > On Thu, 6 Nov 2025 21:38:33 -0800
> > Andrew Morton <akpm@linux-foundation.org> wrote:
> > > On Fri,  7 Nov 2025 13:16:13 +0800 Junrui Luo <moonafterrain@outlook.com> wrote:
> 
> ...
> 
> > That is true for all the snprintf() functions.
> > 
> > > I wonder if we should instead implement a kasprintf() version of this
> > > which reallocs each time and then switch all the callers over to that.
> > 
> > That adds the cost of a malloc, and I, like kasprintf() probably ends up
> > doing all the work of snprintf twice.
> > 
> > I'd be tempted to avoid the strlen() by passing in the offset.
> > So (say):
> > #define scnprintf_at(buf, len, off, ...) \
> > 	scnprintf((buf) + off, (len) - off, __VA_ARGS__)

It does not handle correctly the situation when len < off.
Othersise, it looks good.

> > Then you can chain calls, eg:
> > 	off = scnprintf(buf, sizeof buf, ....);
> > 	off += scnprintf_at(buf, sizeof buf, off, ....);
> 
> I like this suggestion. Also note, that the original implementation works directly
> on static buffers.

I would prefer this as well. IMHO, it encourages people to write a better code.

Best Regards,
Petr

