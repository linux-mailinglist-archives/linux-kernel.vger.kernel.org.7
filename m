Return-Path: <linux-kernel+bounces-884482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98076C304FC
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A173AA099
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2BD2C158B;
	Tue,  4 Nov 2025 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Te1tLShQ"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A462C3247
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247741; cv=none; b=BftWy44a1fM64YESh6KbnxCJfIs3/52atKaj51BxBbylxDU9jjW3qyezCKIG5f4K9GB7uy0MgRgg064fx4B135b1aC7smP9Q5+MHSU+QdmRvnFA5Qmcl9varraSiMS+/rA0EuAoR0yjjWgUskNgkIxbk74hFy5rZvH8JDjp0pwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247741; c=relaxed/simple;
	bh=6LzZWjVJcFU98fCf8/h2lu2RvX3zaBKLQyEx9qouKxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JPimIFqwi1HeOgtkC9go6nVb7XUqxLJoggom0ybuHkJ4IB0AgBK41KZnes/mb+hS67ztfUxhJUt1rJZFNlLWl7476O+wUy77/6fNWPlCLmdMesbEK0+3BuXE+FC+kGKKp3yJdOuhjyCKyuLiiGkRGBHCY5ny+GcyvsqZVe2iAnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Te1tLShQ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477563bcaacso2440685e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 01:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762247738; x=1762852538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5AKn/YxRVDEYvb4oQWy0Qdk6zkNgjLRrHytCLlPapA=;
        b=Te1tLShQOa+2OngAfqQU4v6j5ylN1ipJpYDbdWbc+DNPyTWIUBDxCqsyataybvXtSS
         FIpjdy4dXOuD479/yYVetZqIuud5oRjEc0SUYPcreRRMkG9go6HowxfhWc0nCJB4SJ/S
         QH7ykOnJg1sE0PTejvuvyF5Hc8b07/YxqMJrz3GLfFGNR77pgTv0Zr0LFSbAyPjvQh1W
         TupedITI2xRxziPmW0lAOiDwNStwG+RcjZOfayvLkhkNjwh+hi4MRyVdIytvDI7IeJK5
         9Y1T0qTCjrQ2x5GuiLK3W67FYAGAWrODWKNmKdhfHDCA8mXzKT9Mm7z+TPijomkEz4S2
         U1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762247738; x=1762852538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5AKn/YxRVDEYvb4oQWy0Qdk6zkNgjLRrHytCLlPapA=;
        b=BX62HeGY+t2eYRRERxa5iRtego7T53G1IdX9CsrPoMnnKa3dBTubvlbgMN1oyJVoD3
         ZUx+KvOUI6d8+Er8l/E4bH7Jgm7rJDnKr1U1ZSYkbqBU36798bfmvOKlQLgCA6LbQNGP
         +NgF9/VSAuoE3493A6jRFeoS39kQ+rU1KE+dlU4BwQ4YrDtgqoBHqmemzyo3JW0sxFnh
         5fhFMLZ9o9drTaDgbVq+6bs6vdDqWbhK1I9RmWQMQbH3r0HuJnCYwYqAbGOSGVV6HOOV
         DomVDqA5ps1tD2RR4GyUpqNgoV6Ri0qBs4PHKOksPJqgPJ+i0KCNewa/8AqCSkQ7PPT9
         45IA==
X-Forwarded-Encrypted: i=1; AJvYcCV5lv59NUmrzHxZDOYvcBGr5n3pLqAhVnVy5vsfHxuKNqEwhNuqkA2bOaHuTRYbgDFNCflDX3kJGrEJqcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXI4YIxra5/pvgIMaT/RO4XNqH4/v20QEPLKHpDbaKIgC6CQtv
	19gyZJ4ROAybWLBpLWaxhvYf862vhg+8Da74tsW8zRzQTaoV70LQv3LW
X-Gm-Gg: ASbGncucabf+Ync1158Lu5YPsSz+WDrCo0jnKUy8l74N14OyW1c/D0FiRYyIPDpOrNg
	au/MSUpdVHee4OvG2snlusP7g/Mxa/X6DR4OOPP5mNo+Y6B+QTHs/rjvQdDS9mBpYgiOKzyPxfY
	bTWvDEcbKCMTyNq/BJBa+RraJbrWQAxJduyE5t5bz2gN1vdRSW+5SlstCzx35JPSflsf6O5epFR
	3uLXPZz0eHuYv4eGnp6VqHVRcXrdfUwpsVnmCQVnFp58HEtCJPDmgYuGbUF9s8uvjmE+RNSC8VR
	tZRX28Isg5K5bqsrFHkFgHXnTmVGEc+zjK9p9dtfj5TWreq8mWlEhwK+PrXlsd24EGF9bWgNYRD
	rtcqWqyJl3nyq8Hrpf0xIirXNovuRE1bhebPRAT07I15/Bov7YtLs0zuPkKebqSzGPMJNmGADfy
	g65mrcFucCRn90LK6v16PLIE8TrHkKSBterDQnEEjmLFrq8rTrLyxg
X-Google-Smtp-Source: AGHT+IE01J8SoxNA5Pd+GaPMNOkQJ+QLl955gVCc6gXNOpRKu0U4lo5w3aXmIsKuWk0ctoxNOogwzQ==
X-Received: by 2002:a05:600c:1d20:b0:477:559a:1ca7 with SMTP id 5b1f17b1804b1-477559a1dd2mr15968465e9.39.1762247738009;
        Tue, 04 Nov 2025 01:15:38 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477563fe1e7sm20848025e9.4.2025.11.04.01.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 01:15:37 -0800 (PST)
Date: Tue, 4 Nov 2025 09:15:36 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Kuniyuki
 Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/8] net: Add struct sockaddr_unsized for
 sockaddr of unknown length
Message-ID: <20251104091536.29d543f2@pumpkin>
In-Reply-To: <20251104002617.2752303-1-kees@kernel.org>
References: <20251104002608.do.383-kees@kernel.org>
	<20251104002617.2752303-1-kees@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Nov 2025 16:26:09 -0800
Kees Cook <kees@kernel.org> wrote:

> Add flexible sockaddr structure to support addresses longer than the
> traditional 14-byte struct sockaddr::sa_data limitation without
> requiring the full 128-byte sa_data of struct sockaddr_storage. This
> allows the network APIs to pass around a pointer to an object that
> isn't lying to the compiler about how big it is, but must be accompanied
> by its actual size as an additional parameter.
> 
> It's possible we may way to migrate to including the size with the
> struct in the future, e.g.:
> 
> struct sockaddr_unsized {
> 	u16 sa_data_len;
> 	u16 sa_family;
> 	u8  sa_data[] __counted_by(sa_data_len);
> };

I'm not sure having that example helps.
At a quick glance it might be thought of as part of the change.
That particular example also has all sorts of issues, so any such
change would have to be very different.

	David

> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  include/linux/socket.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/linux/socket.h b/include/linux/socket.h
> index 3b262487ec06..7b1a01be29da 100644
> --- a/include/linux/socket.h
> +++ b/include/linux/socket.h
> @@ -40,6 +40,23 @@ struct sockaddr {
>  	};
>  };
>  
> +/**
> + * struct sockaddr_unsized - Unspecified size sockaddr for callbacks
> + * @sa_family: Address family (AF_UNIX, AF_INET, AF_INET6, etc.)
> + * @sa_data: Flexible array for address data
> + *
> + * This structure is designed for callback interfaces where the
> + * total size is known via the sockaddr_len parameter. Unlike struct
> + * sockaddr which has a fixed 14-byte sa_data limit or struct
> + * sockaddr_storage which has a fixed 128-byte sa_data limit, this
> + * structure can accommodate addresses of any size, but must be used
> + * carefully.
> + */
> +struct sockaddr_unsized {
> +	__kernel_sa_family_t	sa_family;	/* address family, AF_xxx */
> +	char			sa_data[];	/* flexible address data */
> +};
> +
>  struct linger {
>  	int		l_onoff;	/* Linger active		*/
>  	int		l_linger;	/* How long to linger for	*/


