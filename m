Return-Path: <linux-kernel+bounces-763736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EEFB21989
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 01:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E4D188D96C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 23:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A682266584;
	Mon, 11 Aug 2025 23:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="RggXwxys"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4628D222591
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 23:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754956257; cv=none; b=kbFhe+Auz/3K9tV1VPBvsaKhijQnTOB7x186dJpZS0cmURLW2zSVlJc7R9/kJC892tBH663pCRkmpRsLrC1RQKce+rWU1fdsx+a6g1UZ4+l1zkd8q2ThqAog0YFo/fK7NrjjkDoM01XUT8b1QeWZTsQ6NPmiH3Bv1C46A67wLpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754956257; c=relaxed/simple;
	bh=nyObxS/2Bub4mAdPZqrA0gIV7yIxbeYsYdIS5GnfdJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRuH3aeUdi253tDrW4GRvvP7fR+IR2WFOpCXMrwBJ2BD2tOcTzHDKP6K805kJbmCkZ/WJ0yRmB4Nc8ljiq76BlIu7zbAH0+BSdzFQFHaQpSmcSPpN2EcOx/4DEB+MOMeOkIvg6OeOB9/GMHWjkQNOVlduYWVVnUJizdd6k2n7LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=RggXwxys; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23aeac7d77aso41429555ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 16:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1754956255; x=1755561055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TJtTTLwYllxpu5x9aN3bNHJxvrplAr8PtWCWw4sa64=;
        b=RggXwxysY+rFMZDmiLG6tuaqnarPA7Mw1yoTcAF75W9NmEnmnk77MEAGwIrb/kbUPq
         mYMIB1wlELbauyuJ6+YjW6aJO3uY7EYsmmLA8rHDOeKtUXRz53hdWZ/WVnVA2bzXj0h3
         VDgH7tFs9Q0LgoxTk7lPQ17cajj7Mzdu5e4tsZOMlGLdNYHDcGPWjyIl99fPH+jRlJZN
         PFR64sjfXKL4gqGlwKdBIMgS5cFVGmBGdaW+kpa+4BpUOAeXgcJ5KCwEbAAD4WTcsifL
         j6vRX3qH1OMZSBbvCj2Tx9Y7huXi4BI6g/JMrMz7P+esBjmnpLHy0iT8rMGcFA62Cjtc
         tErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754956255; x=1755561055;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/TJtTTLwYllxpu5x9aN3bNHJxvrplAr8PtWCWw4sa64=;
        b=ne78P044akrE/Kp5TLRGC3003uDTrQT8FevplO11Pvu++MBm2oDUiE/um7BOO3kBc2
         AMuxSmFfAOtPF6vI/AN3beYdhUKSHgptEstQc1s8NVfZod89BIx/7RU5QMSfevy57EkJ
         X93s7eVu+1WERDP/64ZhPQk5HE32m9E4YNV+3ELPE2G6Bq6poH/F04NFj+6uwcb/c5L9
         0udhNul9na2+CuRNV665a9+5YwXkSn3YWQJ3nl++CqUV4XeYScjn+klzi7t8LoKhNr+f
         7lWtDcdbA4r1hASFQMMUDxd5bYb4zk3W7hclmTMNlqtSqXsDMRaqOzbqVwkZENe0D9d5
         QPcw==
X-Forwarded-Encrypted: i=1; AJvYcCVB6whLlWQ7slRbxMHbCCcWM/LyTut7wkX9nllLwqPwetgOQV0B5O11X5eYgDvagA/N1/W5rVFqTFfGkJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaXd5jG6ZSZITgEwPk+gQksJ7Ooi+GQmCbZ/plIg8L4Xcs7RDk
	5oIwzj3rJ1VL7bhqJkA25OEatDlpak5TiMEkxLCUI32gEbMGWG9JdZ/KHGLIg0YATTA=
X-Gm-Gg: ASbGncsCkdW9qYVuKcbmvDdk6WSPO+xbCnVRHHg9grhpw6fW/tSw+NEhF/6PV/6tB/I
	lq4lEi5FZGZWMMkS3AhCqmE4qqR9kw+sHdcvwdG6MM0fb+0S1rPjic477HQJYjTbhpoYUuijd6w
	vHfFKiVBTvyB3TIzxf/YmDpnnTtZEzE0Mfg68C5sQsxEMd7AXdfjWKbzrSXh2QiEs9h6Dj2VNIT
	2enahPbjq/kBnnc+o5SToBSIkfdOZHLr5gma/Sj8lhacSXKXKGkxd5+7E4YHNFhTZRvASsv6yZX
	t7TgQW6u+7XbwOWNHEgABc/7m1qY5IE1WtnpUBAt1u6dSU0FeUIetz6b0nALiR2J4Jg+bVIeS5T
	4beHcWdfcX+N9eI4a+qsBsGCtLP+gnb9ZU+/LW4J4FxUnKrzXqqjhNYh0UPom5wDDK3U=
X-Google-Smtp-Source: AGHT+IExhl97fHMJWOi2ei7Jgh0a4kSisSp2agHJTiHAKS403k5IyWnTeUF9b0oHIPPRoej3Wih1FA==
X-Received: by 2002:a17:903:2a86:b0:240:92cc:8fcf with SMTP id d9443c01a7336-242fc3700a3mr19346545ad.49.1754956255632;
        Mon, 11 Aug 2025 16:50:55 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef6a8fsm281608045ad.23.2025.08.11.16.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 16:50:55 -0700 (PDT)
Date: Mon, 11 Aug 2025 16:50:52 -0700
From: Joe Damato <joe@dama.to>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/sched: Remove redundant memset(0) call in
 reset_policy()
Message-ID: <aJqB3A8LMcocbfRT@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20250811164039.43250-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811164039.43250-1-thorsten.blum@linux.dev>

On Mon, Aug 11, 2025 at 06:40:38PM +0200, Thorsten Blum wrote:
> The call to nla_strscpy() already zero-pads the tail of the destination
> buffer which makes the additional memset(0) call redundant. Remove it.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  net/sched/act_simple.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/sched/act_simple.c b/net/sched/act_simple.c
> index f3abe0545989..8e69a919b4fe 100644
> --- a/net/sched/act_simple.c
> +++ b/net/sched/act_simple.c
> @@ -72,7 +72,6 @@ static int reset_policy(struct tc_action *a, const struct nlattr *defdata,
>  	d = to_defact(a);
>  	spin_lock_bh(&d->tcf_lock);
>  	goto_ch = tcf_action_set_ctrlact(a, p->action, goto_ch);
> -	memset(d->tcfd_defdata, 0, SIMP_MAX_DATA);
>  	nla_strscpy(d->tcfd_defdata, defdata, SIMP_MAX_DATA);
>  	spin_unlock_bh(&d->tcf_lock);
>  	if (goto_ch)

Reviewed-by: Joe Damato <joe@dama.to>

