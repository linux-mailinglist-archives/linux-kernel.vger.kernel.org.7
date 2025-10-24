Return-Path: <linux-kernel+bounces-868113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE66C04666
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208023B0F46
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 05:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2E2224891;
	Fri, 24 Oct 2025 05:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FG5Wuwsm"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9922A1BF
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 05:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761283924; cv=none; b=mBE0JUqqzql/0eKsvujKrfJDIl8tMYx1y4y6NNlXWTCQIo8UIcdr9yFwV/Zseqm7COAp7Nnw4t7VLtaBtx6XgTXevvlvn7oEb1kqmUj1zCia/vpM7Nza3xoPMd5/g+Hsun3jzaV+sNiSBW2jJPwG8d16c+KPDwe1wyRS1xv3V6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761283924; c=relaxed/simple;
	bh=jrZFDTVAnVgZ12PpGzZA6oTE8Uvz8Wa0TIbGoyoIcmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYVJBB3uUa1qZc2w7Z8iT4aA5p0RxxXkGVEKNq6ajIzB1An5mhit1eBvrTxBUOu3MNseq9cY6cXeUWsVIUXDTfqXYVj1W6DveP0bhvJPvVOlNX+xZe2rrHjJPPPILBW/TUElzgPIL5OxCU3cNTW3wU9DLhBjJT9kJqIx8quwcFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FG5Wuwsm; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c556b4e0cso3268811a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 22:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761283921; x=1761888721; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jrZFDTVAnVgZ12PpGzZA6oTE8Uvz8Wa0TIbGoyoIcmo=;
        b=FG5Wuwsmi0i9CuE5RfHexYc+eh9TInLYYI8KVrzMq2vk0RiHZbSMNjt3mSu+gqRwYU
         yb7ezkXe7gGXpjBqwkO1eH3wPNsWx22o4YVnSEzfYZXUBARSTn3v/v989kKrZNH9d0tm
         nwl1oH5/lEbtFnxFhijolzDtxjrOBo2WWy1evTeuUjNsTNxpUrh6SUi3D7Q+rSFAiJvH
         8jtG3j9/gNQWhJs9Q3EUoqd8uuoWJfzjiwnQQvdh2Ud4LIaQvDDj9kzKU2k3xpavqh/h
         wU4veUzblYnD1CTdlt2A/v6i2+dGegMjfOAMYxd4IMWQnUuw2klzX/9AAkquXNOqfZQX
         cdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761283921; x=1761888721;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrZFDTVAnVgZ12PpGzZA6oTE8Uvz8Wa0TIbGoyoIcmo=;
        b=JdPFnUHMta39/Ij27t0F4x4WJ0RsC0yzRztdbVxaWA2mwIEBnmjf0A1dyXNm08CN01
         4ECxz/wTj6riI73ECF6ybYuMysHccR5NUidK8RGmBvrsMpZan2Da21Aa7NwC286I1jVa
         IlRsljmGLj9V+8SGoSmmL+dSEQavlnZ872CyaTnzTRdRC21OlOD6dx0slItCg+ssCzUW
         5YbxWXodmtt23mcajGGJW5KOhIKWnL2XhSVbMoZ7NVtrBwoMBeRcGGsCNdH9gbV6T2JE
         XWR3pQJFYervVigtDhOZeN5p/Np/yl4lP/MDp7irFrI1Tteub1oG7FDPPsVzc+eQQW0z
         F8fw==
X-Forwarded-Encrypted: i=1; AJvYcCV8Y0V9VT3fumdxNnmSCQz2QlbLjNWVZnrFAlml6j+eNqokBvb4SH0cwJGwrRo56eb/Gwa9oPTkRPBH7EQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYFdySaAZgJX8Myz/XFGDh7HnZC64DfDkgfK7bW+drp453ietw
	gASWnepJNA0TDef9ZFFIMZwXuLNVOPf/qx1I+5jXkwgBoSQfvQPVbNeYupq88pX+d8nuVTeB0Rt
	tHdFWROMWGly3xj9M/Uiy17cAB8Jc1vA=
X-Gm-Gg: ASbGncv2s/LRmSvnzwAF5iXDmw7Zm886pgyxpfJ3XNz2b4uns8RF1usyFUF0uxjgJBv
	g3sxMUB1jW611oX3153jxbmMbu1IORabQKB/SXVZrU2WEoPohGRB2DTdRxPJs0eMEvwftmNxEWt
	qIlhFlOhljiSM0BfictEebBMFR8CDCld9aDHDMBOj5e/x9Ixc5/F790PpusjMGEyVIRWC3oJyqp
	xTDYfPLO7F83fjUU+FSAftHzbrJIqHNiDxkQYi9YKnjPFpUN+vJrgwMpSPgJvNUxw5Dar9eOwdd
	Fe6t5/3h/Q/f8EpCg6tgSzE9fFRoT8aa1apKxQRF4A==
X-Google-Smtp-Source: AGHT+IGFabAhZAJYuPfr/6rC/PYhEDpQyVDuFdX5CgymYZMIeCEsElgNay6QkpiOoSX+UbWLt45lbDkjDPoIV9KaDOI=
X-Received: by 2002:a05:6402:2787:b0:63b:d7f0:d940 with SMTP id
 4fb4d7f45d1cf-63c1f6300fbmr24095995a12.1.1761283920553; Thu, 23 Oct 2025
 22:32:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020134857.5820-1-viswanathiyyappan@gmail.com> <417c677f-268a-4163-b07e-deea8f9b9b40@intel.com>
In-Reply-To: <417c677f-268a-4163-b07e-deea8f9b9b40@intel.com>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Fri, 24 Oct 2025 11:01:48 +0530
X-Gm-Features: AS18NWDs_5xaC29vC8E21DedXs-dJA_wBfE3U9f9TDVAjvKKLnU69pQirhtU_eY
Message-ID: <CAPrAcgOimjOR9T5K07qR4A8Caozq5zimD23Nz4G2R9H_agPgWQ@mail.gmail.com>
Subject: Re: [RFC net-next PATCH 0/2] net: Split ndo_set_rx_mode into snapshot
 and deferred write
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, kuniyu@google.com, 
	ahmed.zaki@intel.com, aleksander.lobakin@intel.com, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	david.hunter.linux@gmail.com, khalid@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 05:16, Jacob Keller <jacob.e.keller@intel.com> wrote:
>
> Is there any mechanism to make this guarantee either implemented or at
> least verified by the core? If not that, what about some sort of way to
> lint driver code and make sure its correct?

From my observations, The sane drivers modify rx_config related
registers either through the set_rx_mode function or the unlocked
version (prefixed with __)
I am not sure how to convert this to a validation of that kind.

Basically the end result should be that warnings are generated when
those functions are called
normally but not when they are called through ops->set_rx_mode.
Coccinelle might be able to do
something like this.

Related to this, I don't think a sed would be sufficient as there
might be (in theory) cases where
the function has to do a "synchronous" rx write (flush the work queue)
for correctness
but it should be good enough for most cases.

I am also not sure what is to be done if the scheduled function just
never executes.

