Return-Path: <linux-kernel+bounces-868188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8947C049C9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EDB04F003E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D38291C19;
	Fri, 24 Oct 2025 07:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVwZjAHF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194CD289376
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289545; cv=none; b=SuzOZdCRy82WV7F8hB4ortmstAOO+pynTwaQMyrXsyMUR5vKPp8EeVb1nFUW5Ga6D3KVtGeUEtCV7PyLMtryCeYlP01CMZMYushK9RQuuem5rcporikfOsfwWWAW4Gz9bm0d76N9qxI2GCP8MNuLFwHqPz6PiSeLDLdcwfxup7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289545; c=relaxed/simple;
	bh=JYRh6d35m688v18Niywoi4gb4bSrnVYUZ1a60rTqaQc=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sug1DZGtde8w830DBcZbAzfWgVHBu/c2go9w0SmwEGLePOEoIQrr5kJEze1dB5dH+JaY0PbtaBM3aUgBjHQh80efXvvvCPfnzKPe20koXZ0dq8LqhrmNUHCqLEfs34XaHWmITpB9TgvnNETr/bmmcNlLyBOZ8SH/PtBrzvklVYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QVwZjAHF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761289543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0FZBgj/9w9plr3ZN5/JPijL+YiLK2lWHoHpXfJ+sPrw=;
	b=QVwZjAHFH41h7+iYJxib1MfqRXs9oh6x+T81/yKSbg4pubCWlzzl56C87RIWpf9r2+szPE
	x89sFAOExADf5nEQASc1KCXGhw3zsVcUsdYv3vRQEKBoNgh4zTX3xw5Gri0sTsVXeGvHYo
	uyiYw4E+G+0MHOy0HQDwvIvb3m8ies8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-Ya00WYmvPLSnX1l5dv0rBQ-1; Fri, 24 Oct 2025 03:05:41 -0400
X-MC-Unique: Ya00WYmvPLSnX1l5dv0rBQ-1
X-Mimecast-MFC-AGG-ID: Ya00WYmvPLSnX1l5dv0rBQ_1761289540
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b3cd833e7b5so200448366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761289540; x=1761894340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0FZBgj/9w9plr3ZN5/JPijL+YiLK2lWHoHpXfJ+sPrw=;
        b=bH+ANpagQoeT3LS4GR/v+WIc/v7BH6tqDTGUce9KiXTn8nK4ZFgmTf1QAbRxB7n2gZ
         ZyeCj9E+cNxZtIxMKhmDrYpItqK1rD+ObWmk0qETB8aC8LPoWQ7/JVlZuWd2HXWg9T/u
         QhR0xOzGLSxUm5KDKDW5bniNJ6zbrbY5glfP0EGGeWuBS+m7Jqpbxi5uSH4EqrUKeFqy
         BKfXh1FvQX34dX8l1+1V8uU0IUypyl0nRh54JM6Gto+zxyOdXoR/R1mBpQMJVsb86o4b
         nBz1bb5ye43nZbMbwNeVwgljPhBTV9BFB+/5CD4ZDWBiBh0kHAjq/0K76MXrCBboqu+U
         3zdg==
X-Forwarded-Encrypted: i=1; AJvYcCWU3TqjnWwwTZObjKj5cP1ueyKqSnxf3znYF0OtYSnB2nzMHptN/nfhAGKrDtxNQLzSLN76gwBBMZoRUDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjy9JCiD2njmtWmEaGa3akvSnmJwqnMeDAL3lzAQ0NJINVDS4s
	+SVO8QEMyTQWzt6yPJI8w32jVr39kDBoas29qDeF4WSz/vbhnbg1VDIqZPYzrC3Cz9w8qE2vrbd
	zAEBOsOwqNtI8gXmrO4n3WQUg4cpfCPj0oArTRv0xRJUHsg3Z+dNvy5ZFg+wEltymkBaq0Lw4vM
	O/ySbjthAQ6ahHykJO8sTXNCD7U9PRLCXsh+8sCE1W
X-Gm-Gg: ASbGncuXqpawJ4Wjba/8AIDF+u6SaevUH5H9IT3qnqrw7laoV7XvOpyzyGqX9FV7uTl
	C2frWcYFoBT30ni5YVDlf75FbfQr1im/V7b5rjw2iNv+xAst4SD+ZGgl3tY/wXX4uBW3hCEwkpG
	/Y9u4hBPEPVBLuavs8BP6fJ1rBr1VZMFDYPUB9hVYhw0ugBAcA8ceryQ112A==
X-Received: by 2002:a17:907:86a2:b0:b40:6d68:34a4 with SMTP id a640c23a62f3a-b6472b5f80fmr3238324566b.2.1761289540143;
        Fri, 24 Oct 2025 00:05:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuB4wvFcvRtGcIlauvG3S3/KsjSx2Fi6dYn1JgimHrydTNVwTkvmnni4iqjLYwg/MuRLZePszZyatZXoZqyxQ=
X-Received: by 2002:a17:907:86a2:b0:b40:6d68:34a4 with SMTP id
 a640c23a62f3a-b6472b5f80fmr3238322866b.2.1761289539770; Fri, 24 Oct 2025
 00:05:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Oct 2025 02:05:38 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Oct 2025 02:05:38 -0500
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20251023083450.1215111-1-amorenoz@redhat.com> <6a2072e1-43be-49a3-b612-d6e2714ec63e@6wind.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6a2072e1-43be-49a3-b612-d6e2714ec63e@6wind.com>
Date: Fri, 24 Oct 2025 02:05:38 -0500
X-Gm-Features: AS18NWBithWB09Icf3xAiWn1GXXbmzEgZpGPuUfsraurx7GlZ0ka3mXgdSaqBxU
Message-ID: <CAG=2xmNBZ1V7kh7Y0425NPTLJCVyhLB82zNC6GpUN6cXJoyBMw@mail.gmail.com>
Subject: Re: [PATCH net-next] rtnetlink: honor RTEXT_FILTER_SKIP_STATS in IFLA_STATS
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: netdev@vger.kernel.org, toke@redhat.com, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Stanislav Fomichev <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>, 
	Cong Wang <cong.wang@bytedance.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 05:39:09PM +0200, Nicolas Dichtel wrote:
> Le 23/10/2025 =C3=A0 10:34, Adrian Moreno a =C3=A9crit=C2=A0:
> > Gathering interface statistics can be a relatively expensive operation
> > on certain systems as it requires iterating over all the cpus.
> >
> > RTEXT_FILTER_SKIP_STATS was first introduced [1] to skip AF_INET6
> > statistics from interface dumps and it was then extended [2] to
> > also exclude IFLA_VF_INFO.
> >
> > The semantics of the flag does not seem to be limited to AF_INET
> > or VF statistics and having a way to query the interface status
> > (e.g: carrier, address) without retrieving its statistics seems
> > reasonable. So this patch extends the use RTEXT_FILTER_SKIP_STATS
> > to also affect IFLA_STATS.
> >
> > [1] https://lore.kernel.org/all/20150911204848.GC9687@oracle.com/
> > [2] https://lore.kernel.org/all/20230611105108.122586-1-gal@nvidia.com/
> >
> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > ---
> >  net/core/rtnetlink.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> > index 8040ff7c356e..88d52157ef1c 100644
> > --- a/net/core/rtnetlink.c
> > +++ b/net/core/rtnetlink.c
> > @@ -2123,7 +2123,8 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
> >  	if (rtnl_phys_switch_id_fill(skb, dev))
> >  		goto nla_put_failure;
> >
> > -	if (rtnl_fill_stats(skb, dev))
> > +	if (~ext_filter_mask & RTEXT_FILTER_SKIP_STATS &&
> Maybe parentheses around this first condition?
>
> The size could be adjusted accordingly in if_nlmsg_size().

Good point! I'll adjust the size. Regarding the parentheses, I can wait
a bit to see if someone else weights in. I don't have a very strong
opinion about it.

Thanks.
Adri=C3=A1n

>
> > +	    rtnl_fill_stats(skb, dev))
> >  		goto nla_put_failure;
> >
> >  	if (rtnl_fill_vf(skb, dev, ext_filter_mask))
>


