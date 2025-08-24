Return-Path: <linux-kernel+bounces-783770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64829B3322F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 20:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4967417A7BD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 18:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DB622AE5D;
	Sun, 24 Aug 2025 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="ZSGN4OgV"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11C91E7660
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756061973; cv=none; b=WUjigLVDEMda32sZDQJXkC0XemE1gSZqbLvpoU6pRgTMWvJEDptzj5RY/xmaJu2o06jcAYsyjrxipbzMZp57tt4/9ZXAmejyqi68s3VtNY4ecxk0QjnwLFB4pFRurxBMnxbdBZM3vf+DPSvkZvLo7HK0ki6t/iIuQYhjhDtqZ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756061973; c=relaxed/simple;
	bh=BnvchpbfuwNWq7Nl3K1zjneGZqvsA6KybiXB/LPTQF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwZWktStD90IWWsKHBdfUVFZiRyPqGG3lbso4W0IeNl44ld9QUAAmYTPPgoEqMCaYs8lqfY0zNHWHAzmwbQ+9c028c6CDxRD7GTtj37a3IT7H87vnBsZwkgRqDKit6cytXbGvRf/hIyc3fXiiIDkk+7hkWbWOYuo3Eu1NVxRyaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=ZSGN4OgV; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3254e80ba08so1619425a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 11:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1756061971; x=1756666771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WgUhXr4F5aTrg6STFBoaBNVOBpBCCAFD9jOjviiLi7U=;
        b=ZSGN4OgVwgjXcCUFy18njiYNoSd9iH0ZuGhNJUQ54FANuJ8VNfWnYCGkNen+MF/i1G
         +PoL47SQSJlta94q5BUoAuKW5kFJ6ys7MMe3vhwdH5fBI196yIl2Yb6kBzxnCV6Nx564
         eJnkvS1OAvBMF9Cq0PMWoqjZ6Ub6JFoQ1awf7oK2gWo6BsiOpYbjB3bbAuaszwgGzqiE
         uDtKHS4rcYRFXvJ9mOJW4bWB0BwQonn9CWSBnVWJcJRkeilc5aS/RZR6TD3793H723Ra
         Qa918VrTiSa1Wi1g0xGZdSwe23sYNwgbdBpmuo8Rd+DKphhvdim/P1gdfumHink5WbDK
         52og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756061971; x=1756666771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgUhXr4F5aTrg6STFBoaBNVOBpBCCAFD9jOjviiLi7U=;
        b=rB4tkPA75jrnHtiJLbH86ad/o3jyFRZhzY6CSy5mxaPlAgZYaxYg7CTG6h0o+LYiDg
         /0i8HW6WRgyKHWgwQQDniSnvu1b3buwavIBI6qR9JG1XDnxLb2RCs3AMt7ROtsvVKJkF
         IWEtxYTPqaGjNVsZH5fmDNhD9gP+i9KMDFYdBsRbqCJwXgYEoic3QRJquP+JjflAIFxz
         EpvCwgTNVqIsxjz3IIw+zbxAmz8kOFPchzbEDVlgfKsBmGNlSEccJCp75Xyt59DQADVP
         J5oANyBS4QbhhA2QqzW9bewINRHf6kExA5EQYry+5mL9khPFMz8A3OHtZW1UMrE2ZLDn
         MFNg==
X-Forwarded-Encrypted: i=1; AJvYcCVSMjXZFApDl7OhcYFctxoOFte6NBWqNA3UcUNPX0WpgoCz1PLyi664rV8gk/58ej3ybL6xbes2TMK/lHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxlxjt0H9MLdn+sHKdwRO6jdqNgNR8LxpiGTMt2OtJf7pkw1tr
	JlsZC2MIRvVH/TicN8dbx61zSbcOKJx1QW0SRfxEuFHyuMbbeG4ByIIRs9Tof6HX/ns=
X-Gm-Gg: ASbGncvIwFABt/xHf/hCeNQiBHke5meCN7OcltSFnuaCyE8bbn0xrasBXvgeAgDHTwu
	uioRimFM7DTlEy73Z3uAhvk4uhdHw9l4hetGB/qyOZexO7xaue6xRll2MbcjpIk8/QRPRzbTnoL
	KjLmIj0k5f7gsTF4YbuIfni4zIpVxKp/hG8cgTjFt/JQ/YwegVvgnEkauU0Bf+5ONg7N7IQ6Z57
	hx1tM1mwpqyv4oV0kTAlxEs0t2r1OIbDiI6H5LyuKjzdJ7dmgiZ8af9hYv8zrig1Uk+K0owecSY
	392UPAd2kgCukVd3yaDgLHvZonHUO2hUmLZRJsC6ik7SzsbQY19H9R3FJ9J+dDTsYyQWF/c4lcd
	pGgaSCt9i56bkMCuohNxDnEh6duoJxAh0y3E=
X-Google-Smtp-Source: AGHT+IEBnPJSYGQSDsTaSJ2fe+K+NSUWm5ONkS7xAAjriSULC2FqOnxhgD/A++McgxcezIJd+A99AA==
X-Received: by 2002:a17:90b:1f91:b0:325:83:e1d6 with SMTP id 98e67ed59e1d1-32515ee21bbmr11146129a91.2.1756061971113;
        Sun, 24 Aug 2025 11:59:31 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254aa503dasm5021039a91.15.2025.08.24.11.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 11:59:30 -0700 (PDT)
Date: Sun, 24 Aug 2025 11:59:27 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Ivan Vecera <ivecera@redhat.com>, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] i40e: Prevent unwanted interface name changes
Message-ID: <aKthD02IN3-l-Rbj@mozart.vkv.me>
References: <94d7d5c0bb4fc171154ccff36e85261a9f186923.1755661118.git.calvin@wbinvd.org>
 <CADEbmW100menFu3KACm4p72yPSjbnQwnYumDCGRw+GxpgXeMJA@mail.gmail.com>
 <aKXqVqj_bUefe1Nj@mozart.vkv.me>
 <aKYI5wXcEqSjunfk@mozart.vkv.me>
 <e71fe3bf-ec97-431e-b60c-634c5263ad82@intel.com>
 <aKcr7FCOHZycDrsC@mozart.vkv.me>
 <8f077022-e98a-4e30-901b-7e014fe5d5b2@intel.com>
 <aKfwuFXnvOzWx5De@mozart.vkv.me>
 <20250822072326.725475ef@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250822072326.725475ef@kernel.org>

On Friday 08/22 at 07:23 -0700, Jakub Kicinski wrote:
> On Thu, 21 Aug 2025 21:23:20 -0700 Calvin Owens wrote:
> > > > If you actually have data on that, obviously that's different. But it
> > > > sounds like you're guessing just like I am.  
> > > 
> > > I could only guess about other OS Vendors, one could check it also
> > > for Ubuntu in their public git, but I don't think we need more data, as
> > > ultimate judge here are Stable Maintainers  
> > 
> > Maybe I'm barking up the wrong tree, it's udev after all that decides to
> > read the thing in /sys and name the interfaces differently because it's
> > there...
> 
> Yeah, that's my feeling. Ideally there should be a systemd-networkd
> setting that let's user opt out of adding the phys_port_name on
> interfaces. 99% of users will not benefit from these, new drivers or
> old. We're kinda making everyone suffer for the 1% :(

Thanks Jakub.

I let myself get too worked up about this, I apologize for being such a
pig in this thread. My frustration is not directed at anybody here, I
hope it hasn't come across that way.

