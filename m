Return-Path: <linux-kernel+bounces-754087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A69AB18DE9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 12:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0EA85605EB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 10:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7E520E00B;
	Sat,  2 Aug 2025 10:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNyps3Sh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02B9A55;
	Sat,  2 Aug 2025 10:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754129527; cv=none; b=A6Cgnek1CQ8h5zfVKAO4SfVUqCylAvhzF4r5iZvrH1evJaVpXs3oDPxlhDB6Rj9cd5BdNth183UvH4LMCWROXjOFQxmZKRBht3LVy1i6v4FNGwEAzYzzodsGVejpaTaXOawVFK4mpYDHpvqa7XAjAqGZYHBCuhwI5y95BFdBykw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754129527; c=relaxed/simple;
	bh=RcIxv8CNranSikYqIfYh6Wu6F4BH/n9VDoB+wiP/7uo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTOe13gLVaF9hQXSBIyY23SUBaHOmr3SduCY7qogS8SmmKR2ZNLzfbDhSWbUV4UHO/tQsd8uprwB/kF7qFN3CnTg5/SZTHa8EY8ufn83LqWAglkfLxilPWiOcBzOWw9YTN2TxHNG4Vomk377+m4c/4eIAkiljKXgQiPQP8b9opg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNyps3Sh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFFAC4CEEF;
	Sat,  2 Aug 2025 10:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754129527;
	bh=RcIxv8CNranSikYqIfYh6Wu6F4BH/n9VDoB+wiP/7uo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kNyps3ShYsIWdrdiIip+VBES7YtLPsL4ackBY330zHkCdbbkfgPh/m4Y+rdFZ+ju+
	 UshLLaq2/xnvuAOnDCYqd9GFlMMMCi8Q///A30JmhIqA8HOGSUxDz+oSoK4jM9dzyx
	 t3T7BKbSRkt5l9DEJ9q98DAp+4bpI0CvXrkNsLqhjJXz4AO0S4I3zd2L8Gv4ZSTEXd
	 SjIqNpr5oFZZvCwwYNrIvwm8Qgmc+62xfsSFIJCtaVJSaQ+Ni/OasmUFgHJwWGOhv3
	 oe4SgVl/7YfIX2+ktdbRabHJCr/aDZt12QY7JW8ZQhUyELbWmR0bt8Pinf1ecsA80y
	 jL9E/wpl0LjHA==
Date: Sat, 2 Aug 2025 12:12:00 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jani Nikula <jani.nikula@intel.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Hendrik Hamerlinck
 <hendrik.hamerlinck@hammernet.be>, dwaipayanray1@gmail.com,
 lukas.bulwahn@gmail.com, joe@perches.com, corbet@lwn.net,
 apw@canonical.com, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Konstantin
 Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH] checkpatch: validate commit tag ordering
Message-ID: <20250802121200.665ea309@foz.lan>
In-Reply-To: <3e9106d35d41a044adeadffeea32fa096c9e1370@intel.com>
References: <20250724072032.118554-1-hendrik.hamerlinck@hammernet.be>
	<53eb0068-008b-48e6-9b92-d92de2ed4fc9@kernel.org>
	<CAMuHMdU2e+5Hf3v=C=sE=+25f_A=2=Zzw5rxvcT=hb75VC=iFQ@mail.gmail.com>
	<45f0995f-17ac-45a3-8bc0-3b276ee91a9d@kernel.org>
	<3e9106d35d41a044adeadffeea32fa096c9e1370@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 01 Aug 2025 10:55:55 +0300
Jani Nikula <jani.nikula@intel.com> escreveu:

> On Thu, 31 Jul 2025, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > On 31/07/2025 13:55, Geert Uytterhoeven wrote:  
> >> B4 does not follow the proper order:  
> >
> > There is no "proper order" in terms of absolute facts.  
> 
> Let's just decide whatever order b4 uses *is* the proper order, and save
> ourselves endless hours of debating! :p

I don't think it makes sense to have a "proper order" verified on
checkpatch, as some tags may appear on different places.

For instance, the custody chain was designed to have SoBs appearing
in different places:

- author(s) SoB together co-developed-by are usually the first ones;
- then patches may have been reviewed, tested, acked or passed on some
  other trees, gaining tags like tested-by, R-B, A-B, SoB, Cc;
- the subsystem maintainer will add his SoB in the end.

non-custody chain tags, like fixes, closes, reported-by...
usually comes first, but I don't think we need to enforce an specific
order.

Link, for instance, could be used on different places, with different
purposes.

At least for me, the only part that shall really follow a proper
order is the custody chain: It has to follow how the patch was handled,
from the authors at the top up to the maintainers at the bottom.

Thanks,
Mauro

