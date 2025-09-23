Return-Path: <linux-kernel+bounces-828643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BD7B9513A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9910441703
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE3431D393;
	Tue, 23 Sep 2025 08:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KMq6RO9e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3C92ECD33
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617629; cv=none; b=RclRPm8SvejvDzAUaLUwne8QjZpL7xOJlniYmTf4yGGSJUMaVn35qIl6mXn/Al91St17WrSv0sOsjdq1vF6qcQYIzym9+mPW5/n++pKY7E56lcwJ217cdWxRsVgxuITkdQ5dKb1gxwVpdcaQfMkyjFQrJC08ZA2Ucu6emrh4gw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617629; c=relaxed/simple;
	bh=IDr13+9P/xyQPLKeFz5NvinsD8c35vkS685dDkOdbJw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FGYDfq1XcC4fQBzhsoLjLZsgaF4ZQjzLkGfmYfRgSSsqtcl02qhYaFTjoVDPlddAlegpu4NGCcTsHseTOEetUgJV9zvXL8vwNNFutbfYl4UaaTL5wUQwqNy/iwixAFyHPR6lsBiprOeXDNcWbhV+FxFKbqHoYna4B0czgfYszDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KMq6RO9e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758617627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IDr13+9P/xyQPLKeFz5NvinsD8c35vkS685dDkOdbJw=;
	b=KMq6RO9ehv9rPSFw0ZP7V0Zu/zTqcqroopwgP88Kd20Z8jDSkEdgvrpgBGAKkE+qzo+g8x
	8Erxpybhy9rxpYlezqHolHN6h4rjBOtYHV7fv7G46hOQz+atEJN/4Jy/Q1ATesspQ7fvDM
	Rz5GOeLhZX8tJ1pRApRSUkqHUkzk+GU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-xFKaldT8MleQlP1YYcSmhw-1; Tue, 23 Sep 2025 04:53:45 -0400
X-MC-Unique: xFKaldT8MleQlP1YYcSmhw-1
X-Mimecast-MFC-AGG-ID: xFKaldT8MleQlP1YYcSmhw_1758617624
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ecdd61b798so2832105f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758617624; x=1759222424;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IDr13+9P/xyQPLKeFz5NvinsD8c35vkS685dDkOdbJw=;
        b=FS62hoCg+T/EE0sd8U7b/BfDPKsGFq7cB8SQvLa5H6c+dZM6ibelCOfkyHperiWt/S
         yIf7teX42t10z5uh2rWAGjraCihiB+yzVAB+dMOivrFLHlwE3dtWWef0IKIRA3NS35ic
         QA2gMa0ZngC1+68AG78pENauXg85lw4ZJ3lxegvZ1qfbF92XCS545JrMiQEUVEnfMkmA
         OELITHRYLzo5voTmeU12nFxQP2AS2h9IP9Vcsf0z2yYIh6OZ7eBWatp0jdQZPf52debN
         4vmm0EAVJ3l87FeFiCLpKRnSqJq4rCF+XYIxLtU092QVAoBc3ytLPMwaRGvWSo0dyXTZ
         gAQA==
X-Forwarded-Encrypted: i=1; AJvYcCVTpg33N7efq2ESvnUQIh2CaT3IXQw8g1FPIjELh/AZVAANklKTXVTiqLcHFyaOtH7luYi4nRIyHx260y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRCmTWAMyhX1hMPdBc0Wvfe98HxU3+i6b3dVblOGCCajmXSkJJ
	YBrepQ82A6417vs2Kyk1h3rHOUfB0fDZgVGbuZIg8Sb6xEBMhSCSJu4cqqdaHC+xT8FBNRr/F6G
	WURZqSauTJ2lGugek0IKDmexg7wW7o7Eo2GieakiigSl0v5qy5044aJsDQ7h2bfuLSg==
X-Gm-Gg: ASbGncsh/OYaUwlm/ZIsLOV8YIs35fSexMJYETW6LThNxaxwxV3GRcXQqhJJF4G/PGL
	Q7H7BCJCeiuy/kb0LHpR/8kt2IXrSBG0vagPE71dBD10r2AiRWvzt9nmnwg6OXoRHT8u9csL1Wi
	nPejtDWlqJufJzOXK0AdcyRtwd17eCcHkkSGD12Qs5CTXkAnbh9JU5RPb9Og8dreyDoswmVQTDu
	xr4wawinpH6sR6I6Skh4VbizjoQaSHZZ7uoP9LNBHzbdxNv3IjXlV3fT7iPhIVNWUEBkGxzYW/4
	WvGUM9BCZPL2lGddRBeBz2yHIizpsW71jHkA/1fqmcG9KAcZxl/6S4cq04cAawgfVA==
X-Received: by 2002:a05:6000:24c1:b0:3ec:6259:5079 with SMTP id ffacd0b85a97d-405c3e27214mr1398850f8f.11.1758617624428;
        Tue, 23 Sep 2025 01:53:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmNgw03Gw/qT+lIFaSEPvx1AN5x3Gsl2XUuzd0nfG3uHKwNwtw6FDXXpL2sgdZACnvgNCUMA==
X-Received: by 2002:a05:6000:24c1:b0:3ec:6259:5079 with SMTP id ffacd0b85a97d-405c3e27214mr1398830f8f.11.1758617623996;
        Tue, 23 Sep 2025 01:53:43 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee106fd0edsm22412244f8f.53.2025.09.23.01.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 01:53:43 -0700 (PDT)
Message-ID: <f073ef06d9d6b37b10a2800c91238f9da573efa2.camel@redhat.com>
Subject: Re: [PATCH] rv: Fix wrong type cast in enabled_monitors_next()
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Nathan Chancellor <nathan@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>,  Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 23 Sep 2025 10:53:41 +0200
In-Reply-To: <87v7l9r225.fsf@yellow.woof>
References: <20250806120911.989365-1-namcao@linutronix.de>
	 <20250923002004.GA2836051@ax162> <87tt0t4u19.fsf@yellow.woof>
	 <aacdcc85c9f8d3a51a85b6429646c38d4b239449.camel@redhat.com>
	 <87v7l9r225.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-23 at 10:44 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > Looks reasonable, can you work on the fix?
> > I see Steve is out for conferences so this won't be too urgent.
>=20
> The fix is in my previous email.
>=20
> I am guessing your email client is hiding the diff from you ;) (among
> wrapping quoted reply, but that's not too important).

Uh, that's my brain ignoring what's under the signature, need to look for a=
n
update to that..

Going to test it.

Thanks,
Gabriele


