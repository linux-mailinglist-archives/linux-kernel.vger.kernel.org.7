Return-Path: <linux-kernel+bounces-875117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B1AC18418
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 068F44EBFAF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 04:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EB32D0C8A;
	Wed, 29 Oct 2025 04:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUrGlVvm"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253CF285CAD
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761713299; cv=none; b=SjpWHfUyinjY9Br+w9Op25n0fnVxmIpJPbIOhmjb5PCzH2+qlsTTMofmmId84OJM9vNDJtoEQgKh1DapyERZ2/9joBQ/BEi3/SigXoIJo8YYgLpCKaQWuAWjh0/REHuoiyy0rykk4byrK0NL7pDPzdHkpP9vukjMj+p5lk53/y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761713299; c=relaxed/simple;
	bh=kHz9dCjzGPr/TBnbHcUyEuqYu5rhLLgZPHHmF3a5zR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+9f2AFAc5nx/jWW1Jh0sAs1L5XU/46wtL7Sc94hF+STQK3XrPgn6bRWL2QVygTbu/YUFDTdPgLWYut0bPaHA3ijCiJBY37yjVL7j0iyXis+PbGOE8+3YnBgezGqUGgJxKQt303Xe5gat+EEbL0WySfIyd4ggEka58j5+skeJDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUrGlVvm; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-63c4c346bd9so13148208a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761713296; x=1762318096; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dbq9nt56FgGYWix4HcpRFcizCDr6bw5OvUlM+bYyv48=;
        b=aUrGlVvm2vWzoIrD0vxd0zYhoYI7uh5FT6ImD5xYjkC+Y9Q9mhbrfd5169hZwnmd9c
         Dw9v4HLVoD9afyO1zoUZpD553SkWmbl1pSFAvrkJQ2VJ3ZSr7+86lJOq+IigG6D9D4SK
         szn1bqMYU/eKKYexvV/KdPAd8o0rX36atASg/e3zDZ4dgj2g+vIIe5Y9Lx9Shig64Asq
         6yjYU4swhw7ramNsT5Pq4ZwDU5Yl5KiMRCn4RKeKD2HUQmkXE9/2bB+OMbSxGSojykTJ
         7wd/6l1Uvf5YkLnvn+xUxvc6Wvu6ZwT9MJXgaVpUNEob7Y1kLoOsATsfQEaNUNwzXWp6
         AD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761713296; x=1762318096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dbq9nt56FgGYWix4HcpRFcizCDr6bw5OvUlM+bYyv48=;
        b=AJUU0txduQKASyek7c0wxXcfzX8pbCOxMuKM2md8YbrCB5/UaFOnOaq1OFv5fyPy7y
         67hshSB2N3EAbE9rITEsOPxYobbchCeCaEHUfKpP4RHlzvEy5CGXrOKwNzJaZaIqXYFF
         Fcc4ZiWihpxDmJwlxyPNdhaPIgFIcx4ukzDLX6tM1S/r2gsFdxXwgdoqWAr6CH8Jxj50
         MJFeUd1VhHApXOFxT9rX1I4Be4ofSgBzxy5dIWjCdMxPp/hezubp4qzWOT/VZ6RgH1ZF
         J2N18vW7sx4F0MW1niyZo0nlaUaeM4o/KpWYtXLZpOycuCMN5e9J0CNm/qnXSTrJ66hv
         /MJg==
X-Forwarded-Encrypted: i=1; AJvYcCXbHUebaLDA/FXQwXq9oV/bQTI1Laj9Y5m1nhxdPB2ddou7GYD4ag1eSb3bm3S94rfly11vsS8I3tLwVnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNNtHgeCNv6UzZ2UFX0VA8hywEwwGEJK+fYRYrMNwexEN/uHTv
	Mai6usRvMP9CSYyTjSLw1sPqDwFRSHd+fU+pxgsoFC3QEkzGWQECOwybFYFKZfpW1prf71h61fN
	vTGcXJ9yeYimO+GQUTIaO9jechzXuarP7WgfITj4=
X-Gm-Gg: ASbGnctcjtRIm4eWOEXHNhNmju0lOwxNkRMK2RyZsVjpGDuHhJFqB54BUnCN7RC1DBG
	9LisakkaTyH85meOKIxBVK1G1nihXMrU/tRVvOBsFYsFsXsVGT5pl7/Lea4IZXXKmSnyF3eTuvK
	w5Od93vIcrM+PvAlevy862hFCu/voIBWVU16A22E+23egaWZTDV8MRpzvv29fMRYdMstuVbHm5H
	Sw4wBHgelSZ3Ar08IQEiFP6cX5lc0y84Is4ju8qWMFg37GcW7Js/nolyYaavbM9cw3sQmR3fUpL
	ter982IyCasoHNh/zb9evbfyBFedYqsfjw5l5sJNqA==
X-Google-Smtp-Source: AGHT+IG/Y3CfWbdVX41gQBZzCyhI7Mz/jKAEDyoSdZ9xeIABB9XbwtrOeNPc5GqcWolvq+reBSqHpgCJ1sBQNXdIxSM=
X-Received: by 2002:a17:906:8a54:b0:b70:4757:eaf0 with SMTP id
 a640c23a62f3a-b704758054amr7191366b.44.1761713296230; Tue, 28 Oct 2025
 21:48:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028174222.1739954-1-viswanathiyyappan@gmail.com>
In-Reply-To: <20251028174222.1739954-1-viswanathiyyappan@gmail.com>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Wed, 29 Oct 2025 10:18:04 +0530
X-Gm-Features: AWmQ_bnX6Xg8VY3oeRVLdkgI_IKLI94gd2JcIj2LeqnuQY3vbZpxM7rRQ_Ai5L4
Message-ID: <CAPrAcgMPFnypR_zczpCbrxN3h9grBrS1WhH6u1bJfO+H0UjGWQ@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH net-next v3 0/2] net: Split ndo_set_rx_mode into
 snapshot and deferred write
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, kuniyu@google.com, 
	ahmed.zaki@intel.com, aleksander.lobakin@intel.com, jacob.e.keller@intel.com, 
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	david.hunter.linux@gmail.com, khalid@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,
     I forgot to cc you on the original patch. Here's the link:
https://lore.kernel.org/netdev/20251028174222.1739954-1-viswanathiyyappan@gmail.com/

Thanks,
Viswanath

