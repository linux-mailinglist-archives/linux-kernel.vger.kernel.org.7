Return-Path: <linux-kernel+bounces-887087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3F3C373BA
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6B918957B1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 18:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0CD33BBBC;
	Wed,  5 Nov 2025 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wtm5i7Ve"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70322BEC42
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762365576; cv=none; b=E9FR+osLB5h4duX3aqIulhuTEMkdtXwSA3d/wSif3JX5OEKtik4BmtKaTYmCNsE3NV/xQachFqU/nhilQ4763pwQwUw55QgkYtVtAgS6DCClAmDViTt31FECExy+n7QPpzBAOFfT5wuA3ZiJ/5ih9nk0pEnXn+kzWTTzJetjKLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762365576; c=relaxed/simple;
	bh=Nnp1wDC3H73w3jI8NtJcSVR2N83rdAhx/dtATqrWYag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fv+wUZCB8DMtkjQApJpGVZvNLKKxjMvzqJVnNc1aGtT7bqtX+15DrKUT67ipoXGuGhrnUVmZiwVNJVoCTBTugHdaq3qhqWeg2WoX2B0rIHZH+kB/b/r/1+b2dSBWOu8CIOF/dy8c5WPqxgXX7AFQnXlQtf4uawy4tiMmfxGyrvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wtm5i7Ve; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-786a822e73aso521847b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762365574; x=1762970374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zSHtYrMJfyWXNB5+D7qGmo5liVfUAPUmYconSQ05yJA=;
        b=Wtm5i7Vel6og71cIYNi68wga2ylq1eSG/Yhr/KPEnj+sHZCTbCPH/BDgN+LYIacV8L
         skAnPmPwk4Eq8LfFcNj/KAz3bxnQfryS83ZS8mxM/pRUehxODb3wQhjs1uRRVXtKD9e3
         8UNcK6mT7yf7agUTYTdUEWqrnLhOFsqKzwcsp01gtWEWpk5T3qEUz6nxByKQ0DJkpwK2
         d+LL5dDSB8eSgK36DMExPxtwDq2/GiG2e+8hNze0WH3Iats5Xv8ipySifO952J1Uf0Fm
         +EpbAKeOuGqhSpdNO9E7cZf1Pp7ocaGLOZzN4N6pu8letXaCjkrOYHWc/4egXZ00I1NQ
         nabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762365574; x=1762970374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSHtYrMJfyWXNB5+D7qGmo5liVfUAPUmYconSQ05yJA=;
        b=lrs+3kRaX05OLR3Xmkb/exnu12FWlseylcNVrHDVYoE2vXljQE+93yFMyWV0eFYBUQ
         BV9ATkv1aj1G52wS05BOhzf6ALFyihd+zmgq+YZSlfj7aPX1DV7852vw0SJNGpUyPTh8
         NkS3VuzBzCi1Vm/nbn8GBAoh2/Dtz+S/3g++pe4Dw8fwm1AQPaIXTrX88POPISyCEdpE
         MARkIWUIp2WwB+Pk5keKUr/5BDsyJv04XVBD84H0ZNKGi/MGa0+vOxI5KfScELy1zw7L
         gl5uf8hzibyTWw3CuQe0Gu9Wie6eDrsAntlnSLW3a+VYQs8kqKsQfj9rVakYvk/gj+Sv
         8i+g==
X-Forwarded-Encrypted: i=1; AJvYcCUzKpehZWhcodjSZm8ZC1PPgKBeEp67WucisxDcZf4/9bS057kEMFV1RRcRRmOuXtndWTZC7l9ugzCMCQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Kry6BEr7uhx7zorDXTaAU2HftyqONITtf3oG5j1/2xIqc+5N
	oFUS0Chj73S7dDzyhf8xNrc2zpatmecXBiwik/IAtvJzJJAx2Emipcgf
X-Gm-Gg: ASbGnct2UVmMu7HNpr7WhptF4+rgpQuMle29KZXIGPlKGwBFXAG8+jtWeWgbEj6JxCS
	rXtY1OkWm5eB0EZDvKcOBadPA/jhTJY8a+wzAQYD6hPwM9RPgb3BbvTQTC1nXxHPS0H1Vobok28
	k03WfOGpaY3rw+162tGq1Bs6B/FNMyiOps4PTJJ68/AQ4YqCB73axH9DKlZFTLs31DOwU9dFZp0
	lE9ko9O1uxs2FfTmn8YeqQZYMCctbFLc3Zf/TyTArIg53WLUszUJVeDo1NX70ZXbK/BjUM7Qlvz
	aZmE+eeFLENP3GStg+a3luhfOO90rP/tjF0J1gN2I3bB4+Vf0cmvbCMjSMMe68xZRuG/2N6DGdk
	79N3zuITtgslVMQSlldN88GXtNb6LIflonYRo6U25S+ABh7WwwDBFOP9PvPIZjIZs7U7yj9ummz
	80qe9v1UGUs9aUn7BzjIfpdepwUHGFL6S4Uzhr
X-Google-Smtp-Source: AGHT+IHHyTsN8YO880iJh6XJa9T07Q+L4vBMRDgiJVACQ1JdCPPRDqaW0LijeD633oiPcNo5B7xioA==
X-Received: by 2002:a05:690c:fc2:b0:787:1aba:3081 with SMTP id 00721157ae682-7871aba3718mr18241127b3.58.1762365573471;
        Wed, 05 Nov 2025 09:59:33 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:59::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b13b6954sm735637b3.5.2025.11.05.09.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:59:32 -0800 (PST)
Date: Wed, 5 Nov 2025 09:59:31 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 5/6] net: devmem: document
 SO_DEVMEM_AUTORELEASE socket option
Message-ID: <aQuQg2bNj9NYNW6j@devvm11784.nha0.facebook.com>
References: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
 <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-5-ea98cf4d40b3@meta.com>
 <aQuKi535hyWMLBX4@mini-arch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQuKi535hyWMLBX4@mini-arch>

On Wed, Nov 05, 2025 at 09:34:03AM -0800, Stanislav Fomichev wrote:
> On 11/04, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> 
> [..]
> 
> > +Autorelease Control
> > +~~~~~~~~~~~~~~~~~~~
> 
> Have you considered an option to have this flag on the dmabuf binding
> itself? This will let us keep everything in ynl and not add a new socket
> option. I think also semantically, this is a property of the binding
> and not the socket? (not sure what's gonna happen if we have
> autorelease=on and autorelease=off sockets receiving to the same
> dmabuf)

This was our initial instinct too and was the implementation in the
prior version, but we opted for a socket-based property because it
simplifies backwards compatibility with multi-binding steering rules. In
this case, where bindings may have different autorelease settings, the
recv path would need to error out once any binding with different
autorelease value was detected, because the dont_need path doesn't have
any context to know if any specific token is part of the socket's xarray
(autorelease=on) or part of the binding->vec (autorelease=off).

At the socket level we can just prevent the mode switch by counting
outstanding references... to do this at the binding level, I think we
have to revert back to the ethtool approach we experimented with earlier
(trying to resolve steering rules to queues, and then check their
binding->autorelease values and make sure they are consistent).

This should work out off the box for mixed-modes, given then outstanding
ref rule.

Probably should add a test for specifically that...

Best,
Bobby

