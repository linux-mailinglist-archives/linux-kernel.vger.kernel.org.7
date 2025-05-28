Return-Path: <linux-kernel+bounces-664732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C01CAC5FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 05:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBC307AF206
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 03:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DD91E1A3B;
	Wed, 28 May 2025 03:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZWyu1Vbv"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D545E84D08
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 03:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748401992; cv=none; b=nDGHO1ckjmVlmAwHMBttMJGSxszuM9WmUGebkL1Nptwd6yZ+oKjpE6PrY9WSPtiwAA92etEsp8ZJ92V5E/PoU9kwLuVzi3GH7EuQdt45kMJk+H42hlGUBskFve6SVV+VzXyzpfUJ9HMGZqtv04AjU7ym9Z1EwqUh4vcqbEUn1a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748401992; c=relaxed/simple;
	bh=zzZKAu+ekb5wfUFWFWxFj7mtfUTDEeQOhI9SgqQhXNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nyZb7WTkzhq4PZQMxPpq8yIgJPo0K4d0SrpG6m3r1rqDnXUp5ONjMiA/AM+gmSyKiLT1OX5M85T8UbTUusTfBLbzzZtaY/jsrPOOLNy++hOzlXtnC/zXhotFqwJrhuX5M46xvc4o/D/LBg8chCIssQyYEG+yTVyPSZOfkyzhz7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZWyu1Vbv; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2348ac8e0b4so69695ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 20:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748401990; x=1749006790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzZKAu+ekb5wfUFWFWxFj7mtfUTDEeQOhI9SgqQhXNE=;
        b=ZWyu1Vbv2ejyjuwmvqu1s5LfjEB+ZlDCoQcWYYNoKJEIHuwynv37TA4DSBtp1UaZ0S
         zuJRuTA+hcMV3KHX4mCcQuBv+9ATmxDFcW1KDMbqI3vgmdVEBlR3+86X/gnC/kjumIqo
         hpUv4Z8VF64uiEztKO29w91LCXXBm7SB4I/vRih3EVRgbicfFWwMWAnptFa45ZrwtrwA
         3Vkq3epp/y39JSoFZA72R55fuSQflQs7VGkORFX/afLDoMqhcUcxbL+A3PXGw+R8XuYt
         ehXEjMr3F8JgaNKtCttMdDn0q/wht2A2DHeROq5FlhKDhmnDC1MRv7OnIiWcp7MKB8g9
         uv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748401990; x=1749006790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzZKAu+ekb5wfUFWFWxFj7mtfUTDEeQOhI9SgqQhXNE=;
        b=Cxav2taHvBNo2R/CgsE/UYFEs+ktgNxgZiVtNj3wBCiouutP6XiQwXGGUvPK+PtDXU
         BhBkJj9CyT2ZuaaJyUF8llFBMWgZZU/sn9CZ2WdB7ylYD8hroKTgHcx2pgKoIZCXhYTV
         cfbp/tNyORuXJq84AOw3LupMpT3eJoa5HnrrK04dth/iak8QlaUBrfdkyAWwoKe4sTr4
         knbsYK2kWbcGENtOFF1Xaz5s6/XYBDSQj570712c0o5JiX3dIBOvobJjdWFTv8O7H8xI
         zcFV5QnvqsnHQ5DKPJJKmHmfv4SLtRgsQn55tiTvptmNSEEFkp0ylHMUTrr1jdHiBmVr
         0Q/w==
X-Forwarded-Encrypted: i=1; AJvYcCUb9DpDqW/057RHNPeBgAY00FVtNRbqKEIqrSbl2RPQrZnSRr6N6oecqE5K5iNTzYLI+g29bQEiwlvXAao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3wNERW0doZ7JsD5iTkIej6meBE+S8MK+uteXm+5c3tBlPT9xj
	mispZDlGXNSPBNUgwfjtXTjFo/ujh6lQw961GFyZw3+KHjGVbwkqvzT697Quw5AH3n/BewYNZvK
	PWxQGJvfEvire++RU6cIrMYvLf8lFDDKrXMu8vLHl
X-Gm-Gg: ASbGncv9Qb5Dwafl6N0sdq9oGubZQ+hbRfhF25qARZZTGHXwtCU+OC8ti/ffLIpX9X2
	EAxO69eeoyr5AsF6Ywra+5hqAIlXSA5CRK2ajqW4L0f+jU/0/mZTI0D8MF+UdJKZS19AeYoij8S
	8hIi34VWYWALSyidAZvVAhdFdxE9qFuH+vNK6foYO2k96N
X-Google-Smtp-Source: AGHT+IEDUY7riFOOR08zN+pI5SwQ05vmhq98GyByeU8awQ87xrmYDNUTemcQa8sUY7rtO1VWlklZOkyX7GAf8CRHf1k=
X-Received: by 2002:a17:902:f785:b0:22e:766f:d66e with SMTP id
 d9443c01a7336-234c5256552mr1833575ad.12.1748401989824; Tue, 27 May 2025
 20:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528022911.73453-1-byungchul@sk.com> <20250528022911.73453-4-byungchul@sk.com>
In-Reply-To: <20250528022911.73453-4-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 27 May 2025 20:12:56 -0700
X-Gm-Features: AX0GCFstQ8TSymZiP1u3KsDOqDNDhSVZvkeBqi3jCf2XyHkp_VooW3rcyXYh7Xo
Message-ID: <CAHS8izO_ypBm4htYOZ6mDqn5hge5S_3DBKHHTdEW7ay86MsSZg@mail.gmail.com>
Subject: Re: [PATCH v2 03/16] page_pool: use netmem alloc/put APIs in __page_pool_alloc_page_order()
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 7:29=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> Use netmem alloc/put APIs instead of page alloc/put APIs and make it
> return netmem_ref instead of struct page * in
> __page_pool_alloc_page_order().
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

