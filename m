Return-Path: <linux-kernel+bounces-780047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A143B2FCA5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC96CB610E0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E23F2882D4;
	Thu, 21 Aug 2025 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="PHuUhUtE"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6E82877E4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786225; cv=none; b=BFLGgmkseKati9fuETsH959niaBm/qrVKYR2r+qC1AJxhyodZQIdKFM4vP56zH03bLbO7lkS4HyyID5wvya+wnWbGAV0k0s7bYreuoIqq8eBkzT7WiZHeBYLGm9f2Mn6t3dCqGxRpAyFOUzyBiwn5uFs8M02mlkcX0T3An3fsMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786225; c=relaxed/simple;
	bh=/Q42VOBv5rtxb0pQz7EKEZooplEopOXO5j7KPdqQ/U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2QuLksqtL3VOeAX5AQZkp7tT5LobWwjX02ZtrASY8rnYT7ge7N+TPiQNxnBJPO1OmSKNztvavAE6TCbUWc0SKOlvmI/t+zBYRrnDqv/S9X9eBtUUEkvhFltfeMuhWA1R8h5eZd5DNsHCfXXKuKstQE3Zuuqgw6TdFHUZWxrCsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=PHuUhUtE; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2ea94c7cso1061712b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1755786222; x=1756391022; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gltw2YB8idtK1To8X9NeA2NjVxqELvTwQkrDIQqvz6Q=;
        b=PHuUhUtEoNZg6ZiytAWpNhYKglZiNMNurT3t9fPRCto/opRDgsWecwuUfpMG2sc6P1
         AG4SZT6kWgSWfCKd4LRZ+c+keiNqG++GiV7+lVjA6+Dw1/UYGqDYvf2y8oeTbe/08XvK
         Erhkw5rvRIQspIbSOLmWSvjXJuM+oKJ9ddnTiLUF7W19vAXXo7QLDYo7/VPqrVlljs6X
         NANeskRIPBEsrWwT4VoeQRqeY0ejJZ0GstYYYMXgRrYqu3RqpqwpLV0MxZ1By/PSAOwE
         lVp3YBbG7aYUUZdbJvI4XXEjcug0diYYO8W3FDDEAvI6yaNItgsuBKYPlkEqAkU68yeB
         CEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755786222; x=1756391022;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gltw2YB8idtK1To8X9NeA2NjVxqELvTwQkrDIQqvz6Q=;
        b=h+a+CVifyL0ea0y1jvj4HpfaEkJfNW2f0dULeBVc6yNJHC/JEmsf+po2gzgXouBYf7
         4HfWmQ2AvGY6BGC5F07+lVZpWmQETwoN+NZzBnuZmOKUtSlpnZ4JuITQtUI+Ar9MMstM
         diCtWoHjxvyKMP1fRrSAvQB7M/bJThcIwoudxC0pxK+FH+oqughblbO4LLWwD/lqioDC
         WTJrzY+FqpUrtwazfFzkpW2mPiepsyX/U4/8kEQoqYEitY8ez2RLHjuxn9Prvy3ToheB
         06ODZKY3yFSo4do9bxVog2sRBOWwsu/vsWJtflIJE0pFBskJ0ZXkaMnVufyG7pfMULCP
         JLww==
X-Forwarded-Encrypted: i=1; AJvYcCUrOgVjrEY8DbHAOss8vmfKTn6Q8rDcv7Q7YxgQd77dmS/d8triA8FCrU/8e0QjOHMamEgzYLdTWCy1kog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx22S90gWkfg2wjqSTXiPP8OWKQPi0168pSSjEMlbrShDLMmGTt
	/OSciHCmZbYWx+6B0dn2QiWSbJiT89T5sURTbm9W5s5Wtjk+KrINsoIGCURjBgMqODo=
X-Gm-Gg: ASbGncvYeGjNsCmKy6Q5FMyZuhFEG00cHy3MhPJs+WDBErBwqULgLfTLU1PHocfcS/I
	MlF1/YBjBUkk+08J4530DUmVr1ZLY2I/GJ9pGD6ccq8UYfdza9fmA9uClqsCO992z1YnThS0RSJ
	BfomA32XFE8qraTEdRPnTvVMBzs3rDa69wD3fF5GKfDrWPWdaz6cFIOH82SiC1Vv+/d4c+NY2pt
	knyxKlWODasc07Yw1lzLZ31rTyjusyi7HdjVM1dKpJ7vivoAq7hEPfRI+xKBA3LTBVfUQjE7Gat
	pDXi7IWxXiaAgZJZltzX3b2j2WUEZftBfSRqLLuUuA5UDy07OwqFWh/f/8hcT5y6hbTnmgx02Us
	j59LK2l0pN520vuL5Vujb94aL
X-Google-Smtp-Source: AGHT+IHC9kZMbllRdoU5B4ZJo00K1PDPDVqdvazp9vl34+r/qKCj0BP9ePp+tekV3D9iBLHdu8oAsA==
X-Received: by 2002:a05:6a21:998d:b0:240:27be:bb99 with SMTP id adf61e73a8af0-2433074e72bmr3189057637.9.1755786222380;
        Thu, 21 Aug 2025 07:23:42 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d62f3sm8455613b3a.19.2025.08.21.07.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 07:23:41 -0700 (PDT)
Date: Thu, 21 Aug 2025 07:23:40 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Michal Schmidt <mschmidt@redhat.com>, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Ivan Vecera <ivecera@redhat.com>, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] i40e: Prevent unwanted interface name changes
Message-ID: <aKcr7FCOHZycDrsC@mozart.vkv.me>
References: <94d7d5c0bb4fc171154ccff36e85261a9f186923.1755661118.git.calvin@wbinvd.org>
 <CADEbmW100menFu3KACm4p72yPSjbnQwnYumDCGRw+GxpgXeMJA@mail.gmail.com>
 <aKXqVqj_bUefe1Nj@mozart.vkv.me>
 <aKYI5wXcEqSjunfk@mozart.vkv.me>
 <e71fe3bf-ec97-431e-b60c-634c5263ad82@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e71fe3bf-ec97-431e-b60c-634c5263ad82@intel.com>

On Thursday 08/21 at 10:00 +0200, Przemek Kitszel wrote:
> On 8/20/25 19:41, Calvin Owens wrote:
> > On Wednesday 08/20 at 08:31 -0700, Calvin Owens wrote:
> > > On Wednesday 08/20 at 08:42 +0200, Michal Schmidt wrote:
> > > > On Wed, Aug 20, 2025 at 6:30 AM Calvin Owens <calvin@wbinvd.org> wrote:
> > > > > The same naming regression which was reported in ixgbe and fixed in
> > > > > commit e67a0bc3ed4f ("ixgbe: prevent from unwanted interface name
> > > > > changes") still exists in i40e.
> > > > > 
> > > > > Fix i40e by setting the same flag, added in commit c5ec7f49b480
> > > > > ("devlink: let driver opt out of automatic phys_port_name generation").
> > > > > 
> > > > > Fixes: 9e479d64dc58 ("i40e: Add initial devlink support")
> > > > 
> > > > But this one's almost two years old. By now, there may be more users
> > > > relying on the new name than on the old one.
> > > > Michal
> > > 
> > > Well, I was relying on the new ixgbe names, and I had to revert them
> > > all in a bunch of configs yesterday after e67a0bc3ed4f :)
> 
> we have fixed (changed to old naming scheme) ixgbe right after the
> kernel was used by real users (modulo usual delay needed to invent
> a good solution)

No, the "fix" actually broke me for a *second time*, because I'd
already converted my infrastructure to use the *new* names, which match
i40e and the rest of the world.

We've seen *two* user ABI regressions in the last several months in
ixgbe now, both of which completely broke networking on the system.

I'm not here to whine about that: I just want to save as many people out
there in the real world as I can the trouble of having to do the same
work (which has absolutely no benefit) over the next five years in i40e.

If it's acceptable to break me for a second time to "fix" this, because
I'm the minority of users (a viewpoint I am in agreement with), it
should also be acceptable to break the minority of i40e users who are
running newer kernels to "fix" it there too.

Why isn't it?

> > 
> > And, even if it is e67a0bc3ed4f that introduced it, v6.7 was the first
> > release with it. I strongly suspect most servers with i40e NICs running
> > in the wild are running older kernels than that, and have not yet
> > encountered the naming regression. But you probably have much better
> > data about that than I do :)
> 
> RedHat patches their kernels with current code of the drivers that their
> customers use (including i40e and ixgbe)
> One could expect that changes made today to those will reach RHEL 10.3,
> even if it would be named "kernel 6.12".
> 
> (*) the changes will likely be also in 10.2, but I don't want to make
> any promises from Intel or Redhat here

But how many i40e users are actually on the most recent version of RHEL?
Not very many, is my guess. RHEL9 is 5.14, and has the old behavior.

If you actually have data on that, obviously that's different. But it
sounds like you're guessing just like I am.

