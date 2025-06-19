Return-Path: <linux-kernel+bounces-694387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F179AE0BB9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 19:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683DC189EDA3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 17:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAE428C871;
	Thu, 19 Jun 2025 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OFexaoMA"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1860A275B08
	for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750352755; cv=none; b=e46jbEWkJI5OckVovi2IOTuYs4bcRiEiywvEFNq7b3bkM9I2A72o6pFGM/lIAXXfHvX9pQF41dV2kG2glQTMFPsa1iwxgKczqASHRp5hniPCZpNNVr/tkDmR+mW46whvQv5JIN1v4ShwugrkL6jzMSsQCMbc/lgCJ2941rz8jHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750352755; c=relaxed/simple;
	bh=jN36V+UkEMiuZ2N45ZKWPsXe0sBoHqUVgJq6tSmNwXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bpkL7dveQoQjga5UDrVuyXFsFUCGGhPy7V1ouAIJgoBgV3D566yhxuXli7lSakh4hAWsvMnIa5bGb4g2K15HmAUpnJw3elzFMGaHEnJm5jtpTyIn/b5aIt9OfAc3/pDKJmVwHZh9Z4FpjcSszFJ3Avid6jNAFSGQ+NSPtU848P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OFexaoMA; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2357c61cda7so143575ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 10:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750352753; x=1750957553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jN36V+UkEMiuZ2N45ZKWPsXe0sBoHqUVgJq6tSmNwXY=;
        b=OFexaoMAKOV/tVthYS/EtHnoIm2b3NB3ePni/RQmFNtbaKi8dZpwZ3kWU1uAjIyCuP
         TSCYe335Apb6xf7wIvOimbdHHUIQ1u6yW7eQU9ICyDJcGu70kaEB/K4V5BLVXDahOSsm
         3F9US8gdqQA8F8gVmTysqAw9JDkImOwBSujqcu3mVWfQRUqjBeNxy7MYFxIIpIu3ZT1l
         1et++0bHhdOyKOX2Nwrt0WJZA3hLAdxXxyLqG+vWqoSMJjVnc3RY3w7w2HShMRpKqKR5
         Kfg9j+8w/Pv5eZ1TdDU41b4Q8hzXM/gjjGibDTcdTCDCS6c8W3kgbbLp/qc9GN8xjoQa
         dS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750352753; x=1750957553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jN36V+UkEMiuZ2N45ZKWPsXe0sBoHqUVgJq6tSmNwXY=;
        b=O/REZsZY8lnAHBDuNB+KcQYBtCuxL6Zo9gygphY3PfFfIBrdTc+/ePbLsuT5V7CmKg
         d1DzjK3W1yGBM9vx/t1QceZsbhgmBxqVtbJHjkFj7pwEChBzoCDpxTt1jGmrvT4BxA74
         IThWfxE7Gl+I7UKk9o0lk6UU2UwpIZxJbwAWRSy+ur8hA6WZ1jnHB6TcAVmKQl6Axx6S
         +6eM4ZJ9PUjTZW8THj+GufN7LuklbdRLbRLDPpLzbkIrc3P8Ic1mV8hLcWqaKhOXgdTH
         9lJU6lIzwgYLAyK6l474hQi6YLkR9ZZUGwnoZhnW7qkk+RDBAsb8JsY/WlRR8ReWu1Fd
         2Hdw==
X-Forwarded-Encrypted: i=1; AJvYcCWxy676j9BeU+AAE4FxKhC4iO/+Zfff9Yj7NqfryM04czyAK+LjmnfkaA0vzGtQvbxxJOMh/560+FgIsfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1CV8pVu6/1dUB1/eXZnqZwhEKLUyt/m0DOoSVwR0st5yFMqvQ
	v4K1P16KV0q151m9pFZz8k2dMxIe8jWK4LhEo5s2VE3lfZwiAQEqxvJuSMkAHzFyhF6Aap5YgEu
	zY6yy/3HalPJDIU6Sd2F6YY0y6QY+qJvvpYbruySc
X-Gm-Gg: ASbGnctJyTOHypz4Z85oZIFcguI4DnLvlLsHaQW6G13eCP8/nVlpm0TWRIEbCbD2xRR
	HTGcgx5dMld1mVCl5AKZzgfc/Iu0U50ZGGjPCHxR7d/1krN4IZCmuON9GTJnPePvCSo1jdD2oSd
	RbS8kuOKIG897M970Fa2EEDL4cX5TWe//Jpx+eXc0MrYci
X-Google-Smtp-Source: AGHT+IHBoqiPScR/zsv1kvJMCwfwqRmUY/QUQzO9Cn9XCeyjsUJZbuwfk7x6aYyXYdOhd+nVFvJsQ2gPWXvq3cUBLdg=
X-Received: by 2002:a17:902:f64f:b0:234:14ff:541f with SMTP id
 d9443c01a7336-237ce047d0amr2886185ad.21.1750352752967; Thu, 19 Jun 2025
 10:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615205914.835368-1-almasrymina@google.com>
 <c126182c-8f26-41e2-a20d-ceefc2ced886@kernel.org> <CAHS8izPyzJvchqFNrRjY95D=41nya8Tmvx1eS9n0ijtHcUUETA@mail.gmail.com>
 <f445633e-b72c-4b5d-bb18-acda1c1d4de6@kernel.org> <CAHS8izOhNRNXyAgfuKW1xKb8PTernfer6tJfxG5FZmq7pePjwA@mail.gmail.com>
 <a122981d-ac9a-4c7e-a8a3-d50a3e613f0b@kernel.org> <CAHS8izOQLvPAE_E2dgMS7-11ZGFK5jmZ7q58LZCnhymhhUj2bQ@mail.gmail.com>
 <20250619095835.6ef52aee@kernel.org>
In-Reply-To: <20250619095835.6ef52aee@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 19 Jun 2025 10:05:37 -0700
X-Gm-Features: AX0GCFv562JtizA2SIM9AYmy8maTRimTtqBBXtYOtPbIo-G_JCECNhN71fZG13Q
Message-ID: <CAHS8izOeQ7RPHABQCLP8XWfH=V+hDwBg4HTyzWhS=7CS1ZzFww@mail.gmail.com>
Subject: Re: [PATCH net-next v4] page_pool: import Jesper's page_pool benchmark
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Ignat Korchagin <ignat@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 9:58=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 19 Jun 2025 08:37:05 -0700 Mina Almasry wrote:
> > Jakub, this patch was marked 'changes requested' for good reason, but
> > after investigation we found the patch itself is good and the issues
> > were elsewhere. What do I do here? A resend of v4? Or does this un
> > 'changes requested' as-is?
>
> Do you want to update the numbers in the commit msg?

Oh, I thought it's fine as-is. I can update them if need be, no need
to trouble yourself. I'll upload v5 with updated benchmark results +
make a note on how to cross build it (specify the KDIR=3D arg).

--=20
Thanks,
Mina

