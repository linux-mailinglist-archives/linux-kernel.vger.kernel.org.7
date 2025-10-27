Return-Path: <linux-kernel+bounces-872195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 82100C0F84E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCFDA4E2413
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D6231196F;
	Mon, 27 Oct 2025 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="JX9DzY+0"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6861030C35E;
	Mon, 27 Oct 2025 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761584671; cv=none; b=gvPINT1kBw6UT6Wi6TBpRkxAqeBSYXGqNH3OkXTFVVWcrZepDZpbHD2w90jxhqZxYOaxz4HZMWWNf3JTGTTU0ItPFXhTgkJ/g0hQ77nK3JToW8vi5QdghckbrKTevHyr94LUMAwG6qDNIPh2M7UBSTbjX9PHQ6laYBS8A1F0alo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761584671; c=relaxed/simple;
	bh=eg8eCkMtnxXdBHTy6SvQZG9y8vWb6H8b7Fb8X9VO6L4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gU6vty+5lfybHfLVI8YCAFzHH+BgM8C4zljmYipQDBv7LC778HuDlvI4aV7BnVEKe1ZBhuToEsm0NBuiZ1Lgcw9TR1CvQ/nptxTdpXC73JZbL/q9NXaN/GQFlwz//M1gtifSFqjns0sxHarSsP+IsGbY+f5kFbTgo7SxhPNiVAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=JX9DzY+0; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6F84440AF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761584669; bh=UbmYkDItxVSm6XujJ/1Ex+f0FGC6PJyQP0m6yEHg91M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JX9DzY+0Bcx5B6TH9mNhamqqgGvlMsx12I6xgJ688CSRST9kQD4uJFMj6sK4qoA2P
	 U6WM9G6XbJBJt13Z1y9xRewVi+eYHtxVs+fZrGDhcxbPGozr7Mqw3iEPNtYqVEpAaY
	 m9P0cl3Lu/yxhbrnLm36/He4wuaQY+bHUdfp5xuT+ijyOeP6UDOcHFgOqvvDTy8wUU
	 Npbds+2JC89wJUF+R1Dv6Z0q7mumdSGIxQowdmaCj2D4sIWP8/kSGd/zC7oFGDTJ9g
	 86nlja8mcncOktASpwq6S0WqzHhrg/dK4ynMsPjlRuhwxHofD8DdbrAH7jaJDGufv5
	 KAXgTpgwy81zw==
Received: from localhost (c-73-14-55-248.hsd1.co.comcast.net [73.14.55.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6F84440AF3;
	Mon, 27 Oct 2025 17:04:29 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Akira Yokosawa
 <akiyks@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Dunlap
 <rdunlap@infradead.org>, Jani
 Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v3 0/8] Collect documentation-related tools under
 /tools/docs
In-Reply-To: <20251026073405.0672c9dd@sal.lan>
References: <20251024200834.20644-1-corbet@lwn.net>
 <d3f4c7ee-6351-4c6f-ae93-f423245c4c9e@gmail.com>
 <20251026073405.0672c9dd@sal.lan>
Date: Mon, 27 Oct 2025 11:04:27 -0600
Message-ID: <874irkp97o.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Patch is incomplete, as it doesn't drop the logic which forks
> kernel-doc script run, but see below.

So I clearly hadn't fully understood how this works.  Before I went and
broke things, the logic seemed to be:

  If the kerneldoc_bin environment variable is "kernel-doc.py"
  	don't actually run kernel-doc.py, build it internally instead
  else
  	run whatever program the variable points to

  ...
  set kerneldoc_bin to "kernel-doc.py" by default

This seems ... a bit obscure.  Given that:

> 3. change the core of the logic to be something like:
> 
> 	# kerneldoc_bin = env.config.kerneldoc_bin
> 	kerneldoc_bin = os.environ.get("KERNELDOC")
> 
> 	if not kerneldoc_bin:
> 	   out_style = RestFormat()
> 	   kfiles = KernelFiles(out_style=out_style, logger=logger)
> 	else:
> 	    print(f"Generating C documentation by running {kerneldoc_bin} binary")
> 
>    this would still allow using KERNELDOC to point to a binary
>    that will handle C files executed as a separate process.

This seems like an obvious improvement, and one that, perhaps, should go
in ahead of my current series in the perhaps vain hope that we're
finally getting to the end of the list of things I can find to break...

I can send a patch around in the next couple of days if you don't beat
me to it.

jon

