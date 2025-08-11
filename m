Return-Path: <linux-kernel+bounces-763353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB1DB213CB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3CC44E2F7E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25CC296BAF;
	Mon, 11 Aug 2025 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6i0u05o"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E9B4C7F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754935272; cv=none; b=WhWvWSFLlxL0dlUAEN0XfFtNmFnqqUhcH39pfLh1qgyxc8w5nzrig1g/tA8aXu7oaTLN3WR86ROIwJAex1AAXdc58qFLzBlv2OCg1eLUzggmsRD/OfQ6PI9Ttvj0UgozeTjxZpxAu0GgIFYzhl/qb758khRi9Qx8vwRAeNIUK08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754935272; c=relaxed/simple;
	bh=MAPofcdLb/wQvZhe7wYkr6fDV67Cvk2ibnoECqWfFB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pR7FIocFhuQjxwKHpjVl8z/XoxWURtAMhpjDAo+GEXCKFfCoFCB7XfO3JMzLJjG2USEYZwgdvHFRV1M2za/YU+gF66bXjjygen6aWqRveceF8qtD8fdq5t88QebU04ObhtLtPplbqLUhVDK9T2Af4s391zLfsUZ9oSXGQWOYjLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6i0u05o; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b78d337dd9so2903115f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754935269; x=1755540069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jj3Nxw6tXjAKos/G4yaW/f/mcL3wU7Y1WlNpr4sKcOY=;
        b=M6i0u05oWB5rvL2uixeqdh2jnuD2oNsti5obK8DK2zb79p4GpW7it1TePHryDebDX6
         kagFMsskCPSYAYmhR5G8JS3hn7+jvDl8B+oOGkaL+ZdQfceO0UVGFRVxLgoD/hSv6Xay
         gJxlpSyvSH8GBfYbZ1lyqYGQrMZswpwap/aR4m/Qw3Pe7OAT0MPVtsrspgI+CY6TVQ6g
         TABx14WGgx24C35D3U5MadiCdrjjRmUeFCELXP9rPtJdRc51EPAil0FyYzXHY/xIQAvK
         NlQTJWRCes7zRhyL8EdkmT5piutq/fcKlenWYWmanhek42yoUAc8ytkry9x4EdlYEVQV
         ahtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754935269; x=1755540069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jj3Nxw6tXjAKos/G4yaW/f/mcL3wU7Y1WlNpr4sKcOY=;
        b=OcOw0WADgxScXN0xu/hI/4JAz9HHhNLEHGCN6R5yGlC8yvF3I/nAxddR8IMbvqEPqK
         XyXuvQoYunJDZwxAn9wfzdbCtSMfbLm97qUrbYOfL+UJOI/Pj+M8m/yXr5LjPpXL8G3/
         xO2QHd3p0vx55o+sG/o0JRn0wkysBLxVcbBXO/5a6oVEUrsY2ecaF3SyJ04cDeC3Bcq9
         MRC7mBM/TIm2SxNv9pbk84d6Z5MERuujPsF6lUeBaAlzmb3HTzdsJlUGbt12eVikOf1f
         q2tnMgxZWWt0pNIwzKdIA50E3uSD07SWS8MGw7k3fI6zDgw+MirU+n80C1nWIGzTH676
         o8Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUXRDAC54P0BcwlrohZOy90UBbDzceB7aWvyznaw3UtAW2KFTqpFIdmMuKL7wyyvQw6di5wlLVfVIk/MoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv5BsnizGPIEgBYgtiKWRgDXqvXDR3XnQxqzFP4irsFoZa7Gcx
	X98MLGx4yd0AVAQbxha1XtJUZCbRZW7Q/52pk+Uzov/ykNFnT7UlbZA5
X-Gm-Gg: ASbGnctPd4cu4127DdcIqqBoqPbsJ9acExNipWCf+VwXWI/mDoyCiRdatBVxFSYNQoB
	sDq8IUtzKHBA/ABS2gEJc5vm1MhtMb3IuLbRwpuTdjYto1qVLpAJAp+ZhMS9AqmKwoelTbgk8HX
	dbqApmq1sP23cK+lgQJZIXW9VuAlUVC+uLpB7BxYy5Qw7H9VnMYZopIDk5wt0un04XaD86xK+li
	BVoTMVQCWQ3f6a22XHCfJQXIbRk/m9cYIpSRLMYFa3JwXVjOJ6+zSFXOgEz1zfvcsYzV7sXiTC9
	1JBNluzxx+qSPUB9ZI+1YMQ1eK1UswJO6oLAjA9M9Q0r8iW5MuGM8vXZsMc4v3Oq2ubWaAksDRz
	fJZre6OJ/+FXD8HcHOtTgFjsFE+Hz0sl+ONNO7ZR59y5OjjICZU4AC+Fu3/Vfz5B6bw==
X-Google-Smtp-Source: AGHT+IEZHGeLhlVsSuErKyOslWlPRxNSUT/Mb0O5Qjaw3y/rO+DYdSeRmq5TQ2u2xndiuWc+Qcq8/A==
X-Received: by 2002:a05:6000:2502:b0:3b7:974d:537b with SMTP id ffacd0b85a97d-3b900b5042bmr11222392f8f.35.1754935268622;
        Mon, 11 Aug 2025 11:01:08 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e0bfc79fsm30876777f8f.56.2025.08.11.11.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 11:01:07 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 260B9BE2DE0; Mon, 11 Aug 2025 20:01:06 +0200 (CEST)
Date: Mon, 11 Aug 2025 20:01:05 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <christian@brauner.io>,
	Suren Baghdasaryan <surenb@google.com>,
	Ben Hutchings <benh@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: Add missing module description
Message-ID: <aJov4RkRMRhCB1DU@eldamar.lan>
References: <20250809073018.1720889-1-carnil@debian.org>
 <aJoqFKYpWkDCiIJp@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJoqFKYpWkDCiIJp@google.com>

Hi,

On Mon, Aug 11, 2025 at 05:36:20PM +0000, Carlos Llamas wrote:
> On Sat, Aug 09, 2025 at 09:30:18AM +0200, Salvatore Bonaccorso wrote:
> > During build modpost issues a warning:
> > 
> >     # MODPOST Module.symvers
> >        ./scripts/mod/modpost -M -m -b        -o Module.symvers -n -T modules.order vmlinux.o
> >     WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/android/binder_linux.o
> > 
> > Fix this by adding the missing module description.
> 
> I'm not against having a description but binder is not tristate. Judging
> from the 'binder_linux.o' this seems to be some OOT version? Otherwise,
> I'm not sure you would be able to reproduce the warn.

This is entirely my fault. We saw the warning while building in
Debian, but missed that we apply the following patch:
https://salsa.debian.org/kernel-team/linux/-/blob/debian/latest/debian/patches/debian/android-enable-building-binder-as-module.patch?ref_type=heads
which allows to build binder as module.

I got confused by the fact that we have 
MODULE_LICENSE("GPL v2");
in the upstream variant, but no description.

So you want to still have the description added or drop this proposed
patch completely instead?

Regards,
Salvatore

