Return-Path: <linux-kernel+bounces-785884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93075B35228
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3256D200B8A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 03:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A29F26FA5B;
	Tue, 26 Aug 2025 03:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FowuDkiE"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6CD2BE63D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 03:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756178237; cv=none; b=Cnf/CpzK6SOjb2xEyJIVjwhbRrEnNNgvjKq1nLRAYQPyMrNbL3MEHdUm4VKs0qDEndkiQe5LFviLBZ0KkhK30rhXnz1kMfSFjrxOlA8PWes/igCdxjMVvHiP574qhe8lt4D/j28yROHxPu6EGToufsmeRLme5uY3MqYLAlVMYrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756178237; c=relaxed/simple;
	bh=lQuyaZzCmOSly1JmwYweBeBbaXEnm2B+RIRBOXir5n8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NUGWpgXxUelUgI/OptZgn/+4f/Uf77CRRCIjRfxPOyxGk59YIa6zdMfU5KaCEMfPoO3NHXax+PRHRcMwMVQLztoarYGAXqLUTXnkO4omSVH3WPkk8gmqnJoJf+IevXuALcF+R+ZDbVhdAP4lRuYZkSb+hUUR5nvX6DbjTiCvuDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FowuDkiE; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2460757107bso46456355ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 20:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756178235; x=1756783035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1h4kvq+D+km1eVNwFE06zF6nsAzszroz7jTJgfoLFY=;
        b=FowuDkiEtJEO4C7+tmcIk2xp62hJXoIgffGp3axz6hQK3Q3ayb+ufJuZb9g/v7dWpQ
         SYIwbLwHx4AoJ48bgCNa2zsTgjMgmXdUNfkMTSTI+pYcWHfnoUGnHgEerFl0EtULfjp6
         WwKEIgAePcXwyCXIFrJbafVVhi4e0quwhJmK1BOX2Fp9Ac5MGRvskOcddYtR4kzbmtJy
         UiM4JZADTzNsfYY0TNTJ0U7SDKkAJkJgZN3NjJd31RgnQvF8kR6wJAU5Q8lBLCB2muFP
         eiFesfortttybDHQJq09VMZQwcxbYqfA2aiUQLMie+qaoH6oRNz+0A5EpVAOuELlZjRo
         yTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756178235; x=1756783035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1h4kvq+D+km1eVNwFE06zF6nsAzszroz7jTJgfoLFY=;
        b=adzxRRzm4zWuE63RUs4KQ9Mtetus87xLY1RBWW9gEEZAscrR0o/wJdT7I9dAK7lt/C
         M2s9zbV6MDy2VmKeq2fbnZmAYJwBFvbjPs2Ny0acbzgEGsbOv3Kl8jXbyZ1/OVV4eIVb
         CfDRuu/DP+Ln7p2Tak9rDRegcW8+G0IvvoWAUhokPv34no21OolG5Z8AP+CzmD0dFUhy
         k8WatPOO9uNr/CQtRQzfGoJJzpanmao0BwjfBXHwxR5XpYYyhJWVpakITJpjwpqXeFAw
         Cqyw1FKj1vjtyeS2AkyV+Gi7iiFoz3ch7L2tnlFQGrJNjIAQlixpWb8vAE0OPo80CZDX
         sRDw==
X-Forwarded-Encrypted: i=1; AJvYcCVPpTD/ASEfSVWcmrcugrzCcdDBed6RWNhzEa3l6cvY1KR+gp0qcz/579lka6C0mGD1Dg7URIYJBAcVWgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDdoRZPVAyhZy1337s96dIFOvxo1cnIqTddpmHKWvBjaL2/qzx
	4oGRH35rGXLmxvhBKIksd+fG+Jq6pEmN33MODnHvF3LlrhS1AtBu/7uXD7JieKmq/9YmQGQ0aNu
	K/qulWjUWHdHaxcTtTIv5SUbPDX1qT248LysUCn7E
X-Gm-Gg: ASbGncuepK3cNt62bDn5/E5tXVRliuyPvXxUl4tUayCHa4XNWxJ7duCfUvF746HVHD3
	J9YnQ+hTFlewwt3XXeZUr85Z20fUQkxTA7Q2d4IpdpCI5EiRk1LIOzsW/DtyyeZLz7BiC+lMDgS
	Echn34QyUXMs4na7q+29oAPMln3m9iyoE166/mlT6ex1SvIU4D6RbYlBky4BtApRLv5w5fHRqLH
	dsWFZj59/4y7kf1wjHzItqaS+JP0lrAw5ssQlFw8YmiNqsk6YGDQKkIUv2FGIg0S13fXHuHMXFp
	CYSlh8hlo7Ngng==
X-Google-Smtp-Source: AGHT+IESsrXr4/A9HV9CM4eWH41gEwhxKYe0NGRGYhWCv7FkNw6cH3wSdOT9yrR2tLXLXf1QXj5cDFh41SU75hN8Ze8=
X-Received: by 2002:a17:902:c94c:b0:246:273:c694 with SMTP id
 d9443c01a7336-2462edac306mr225808385ad.12.1756178235138; Mon, 25 Aug 2025
 20:17:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826025206.303325-1-yuehaibing@huawei.com>
In-Reply-To: <20250826025206.303325-1-yuehaibing@huawei.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 25 Aug 2025 20:17:03 -0700
X-Gm-Features: Ac12FXxSntQxaYwjVLf685rn5gNURA2vkqomZn26jKlmintI2ILPln9QYxxQ68s
Message-ID: <CAAVpQUDA5gCi--n9N7PQZC3rDBxhZxMW8AUFoaGs+09oT6Vebg@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: annotate data-races around devconf->rpl_seg_enabled
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 7:51=E2=80=AFPM Yue Haibing <yuehaibing@huawei.com>=
 wrote:
>
> devconf->rpl_seg_enabled can be changed concurrently from
> /proc/sys/net/ipv6/conf, annotate lockless reads on it.
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/ipv6/exthdrs.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index d1ef9644f826..a23eb8734e15 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -494,10 +494,8 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
>
>         idev =3D __in6_dev_get(skb->dev);
>
> -       accept_rpl_seg =3D net->ipv6.devconf_all->rpl_seg_enabled;
> -       if (accept_rpl_seg > idev->cnf.rpl_seg_enabled)
> -               accept_rpl_seg =3D idev->cnf.rpl_seg_enabled;
> -
> +       accept_rpl_seg =3D min(READ_ONCE(net->ipv6.devconf_all->rpl_seg_e=
nabled),
> +                            READ_ONCE(idev->cnf.rpl_seg_enabled));
>         if (!accept_rpl_seg) {

Orthogonal to this change, but rpl_seg_enabled is missing .extra1/2
or this condition should be adjusted like other knobs that recognises
 <0 as disabled, .e.g. keep_addr_on_down, etc.


>                 kfree_skb(skb);
>                 return -1;
> --
> 2.34.1
>

