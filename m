Return-Path: <linux-kernel+bounces-726300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA1CB00B4B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827255A7EFC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4811F2FCE38;
	Thu, 10 Jul 2025 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qT+Gzrgf"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC85D2EF2BE
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 18:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752171931; cv=none; b=ZN27nW0epTzQ93mo3sGk1cGltpafYs4VZJcVG3SnHG0HnPPdIeANwwPDEvF7cotXUqqHdJqgvYIjsQKwK9pCSj9HReyLFk+nZQ0Ckt7hy44n3fUkJAEdCXsxM8oo7sGROYzQ7C2h7BnJwNiB7tjV3veNB1iuQbJJJKERYKuoVaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752171931; c=relaxed/simple;
	bh=lzOg863td9wmwIzdOW1a8mSXM5R7uBGHNR/Wq8C+XKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3ilv6Ya6tsAcnVy7gnoe4o1ZtWnOpLY8nhKCokawZHIYkj1RrQryCb8CSOdolp189hZGkAZMRnpedejb73YwBhfIBF4/TDni+nrhyfoPUzKhfrKAYCpAKuFJpww/Bl9B9kdaqkOVuxWQxqBPspUIkqlZdGtuOtawZRFAxYaqRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qT+Gzrgf; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60b86fc4b47so1637a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752171927; x=1752776727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGttGecOUfnj2vDKboTFLlNArn06kYu+jY7WB+vGDSo=;
        b=qT+GzrgfFbv7TNCyvI1nwQhemlew7h2QPaGYd69Kqi499zFAgpcsA9L6Ql8C2UR+2b
         z67/WVydCFIO9AGIyO1OsXS/QNtLnHPNtzbW4xhg/W7vGQqQ0v819gJlOeguSiYqoazk
         yMTfvUrnnPivCdLvSRZcCBY1l6MvszfzuWVhO4rcMWA7DWJFMF0dFW5zKB2ae7KxMgpZ
         fQsioD+YvOSbxnDPApSnChHOEQ7WgMczdqaCs+9KmDuuYoiQI34SRzh8O3sJQLGt4fOc
         +b1hMmPhnAM2GtRhbfsEDW1nlV0Dlnerr9J/1xLuLVglKv5j2qYJvI6pA9uC1oWpWxyH
         6ceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752171927; x=1752776727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGttGecOUfnj2vDKboTFLlNArn06kYu+jY7WB+vGDSo=;
        b=KPUgx1J+ijD0VuJOzXrdPrMV7cA9R2S4ImnODf19WTtyJVgNMxR6jk/cvWN0yNVtNu
         8+RjBaVZVqjJsyIT1pCNed5MMIq+xxIsIbMcmCInt5Fa5NXhn2v/Kf1oP46/aAChqPCG
         HVWnpAZU4tSj+30SRXwzsWsGIHFteNWXzQ9cmvLnmJqAfQBFmCUOJgsMTLwpIUb7bxHd
         E/dQZbMAc8iRAb3+MIjyY+/O1jvF9khmq+cr2WWsLqvOnRjKHEJGngwN8Xj/selqi5qA
         BDE5JJEz7WOHFK8CcigmqmsagE1d7FS7UWIwCwUSGuK1EJxWj2QznVcMm+6ZaKAqkSTB
         nsWg==
X-Forwarded-Encrypted: i=1; AJvYcCVsrDIpQ2412yNwljRmlsHXX8vqXWLM/7jXFV689s505xUaUJ9xOM//RuTh/OXysunvBegbxQXZF4M2c3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6LEAC83kDhVc6CxGDdrE3UHlrfCaUIse/1cWOrmDX/yyzM4O3
	WlkLwQjOCIzejsq+PX/VQzWH4bYanOu7VvbBqAXuAmM2P4hAQrjq8FbkV3+ykVuNKgN6iULYnFu
	0NdibO+jGAEqHEZrdqFmKWi1StJ3NJbUWtYB1xXpz
X-Gm-Gg: ASbGncvrlXZSQxazNmX2M8YuAtExgtQ6FJa7u0UChq5mLsUDgvY3bR6z03uFxr4Ps3W
	5eeJUOA+U419BcJLhy4E9C7ScSMz6Lk4AkAlS02AjKC/4urhteAsOUvIhNNtCdZVstfg5XbONCu
	4E7L5UJPuzfnUFZteGAB2/+UYYAKWFCRMOZjsGByObIqxoQdIJOBmwSteCdlgDJxT6hUk38Lc=
X-Google-Smtp-Source: AGHT+IFYbu4F77iXBeAnMl5OLLUNqSyy6NKKa5nSrUrX3MSMLO1UBBwllp1ZZ2m2gbUJ8CJrAGBesZolk6+61YYGeCs=
X-Received: by 2002:a05:6402:30a6:b0:606:b6da:5028 with SMTP id
 4fb4d7f45d1cf-611e66aa77bmr9269a12.0.1752171927040; Thu, 10 Jul 2025 11:25:27
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710082807.27402-1-byungchul@sk.com> <20250710082807.27402-5-byungchul@sk.com>
In-Reply-To: <20250710082807.27402-5-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 10 Jul 2025 11:25:12 -0700
X-Gm-Features: Ac12FXxKh5TJZHgIcSqvUZXVnJGYFBLJKrIZOv19NnRAZsweNKYOtzi0atTHg_c
Message-ID: <CAHS8izM8a-1k=q6bJAXuien1w6Zr+HAJ=XFo-3mbgM3=YBBtog@mail.gmail.com>
Subject: Re: [PATCH net-next v9 4/8] netmem: use netmem_desc instead of page
 to access ->pp in __netmem_get_pp()
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
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 1:28=E2=80=AFAM Byungchul Park <byungchul@sk.com> w=
rote:
>
> To eliminate the use of the page pool fields in struct page, the page
> pool code should use netmem descriptor and APIs instead.
>
> However, __netmem_get_pp() still accesses ->pp via struct page.  So
> change it to use struct netmem_desc instead, since ->pp no longer will
> be available in struct page.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  include/net/netmem.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 11e9de45efcb..283b4a997fbc 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -306,7 +306,7 @@ static inline struct net_iov *__netmem_clear_lsb(netm=
em_ref netmem)
>   */
>  static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
>  {
> -       return __netmem_to_page(netmem)->pp;
> +       return __netmem_to_nmdesc(netmem)->pp;
>  }
>

__netmem_to_nmdesc should introduced with this patch.

But also, I wonder why not modify all the callsites of
__netmem_to_page to the new __netmem_to_nmdesc and delete the
__nemem_to_page helper?


--=20
Thanks,
Mina

