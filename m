Return-Path: <linux-kernel+bounces-860135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A7EBEF62D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DEF54E2808
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 06:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7112A2D130C;
	Mon, 20 Oct 2025 06:01:21 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF791F30A9
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760940081; cv=none; b=Vww7jNyn9wmG/pJRULZRejLlfb+ob2v9bmYoUFtiUXtmPX8DYGZj6CkZI7mYJr1IPXvIpdRZRMxKPTPIxOdN/LET3SyZVzG2OLvU1M8+rtlAmFCXiHJmGnlvxaxaxzogteNlUFqK7ZgLRF2pJ1qnrIaFtOYlfStFgwRZai3g7A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760940081; c=relaxed/simple;
	bh=zPx/qHajOmP6Qog6UePYyw24VcXnPdZWtnfS4h2h30I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=nSu27+0Gh+Xapt4fvvZkvygZ1zn2Iqi8PpZWlSyA59YLMkG943SUq9CCl8wnQZ8FxoUEH9M6mzZBkaU6Y9gxvMomydng5Ue0boHjKVqkHvypWb83dq+STMB7JtDe06dD8HtDEg9jPN2yQ6H5BQe6uG3OZRJfb4hK3Ofi+tLlM5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-940d3efe58bso95101639f.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 23:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760940078; x=1761544878;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qDD8Ubc5Av0L90IL8EuqGy3Z2uaxhW47eENinTlYn0s=;
        b=R3atOIuy1GbdpGMQc4tSaixmUZBv5gXYAEFS75JT3/OsqyD90MZzyp9G2XRayKVTug
         w5ch9PN9/tweocv9bIiWk+QQnY8M8O0u/ahSghoAz9BV+LT88K1pCxAAbI35rTDHVwun
         HrUtAif3rItOVrRs71H2fX43WYZ4v+fZCkMsd6ei+NL8T79eVvPY9lFqbbJ8MK9VqbK/
         fpXuQKj+x3sA9tHmurvBldqvebY41CBWhORzUsvRPH9nuSeyf8hNUJN9XF8q1K75WlZO
         EudViyGrcNe3A23L3JGjj6qgozy4IlYJctvl5LvLP5qeGMlKbHRLh6ed7Feyl3zFki5j
         Fd9A==
X-Forwarded-Encrypted: i=1; AJvYcCUTSIVqppPML3i9nMKbbkYJhvQz4SBNdhRGwtuvvKRRF29B83dj/All6Qu5GM3tZukBdeDCm4PEMMkysKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2z8Jioz2iMoPsmaeLRdyTZ0RE8/alQukeG0gsjyJTOAXm5Bnl
	mAI1OrEpGC3/mVOnQbSDsTEfP+QsGflZuEDP7MF0Oo5xZKr6SEN1AaaRraMHI7dOI62RF/z4AiQ
	GggF6s5sHEVpIYhy+i6enb+vyXvUZedEfaa6jdrhVuOC4ZERPBqVBDkxU/1c=
X-Google-Smtp-Source: AGHT+IEj9qyfg/IroSssxxfUTR6ez8zaAKoPAwc6VRxxAK8shZj0Z9kW2XzlzJS26xBJt3sjwCybZih8L4SBskLHCJKfK1iuLHB0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:640e:b0:940:d700:3a01 with SMTP id
 ca18e2360f4ac-940d7003b01mr409890539f.3.1760940078571; Sun, 19 Oct 2025
 23:01:18 -0700 (PDT)
Date: Sun, 19 Oct 2025 23:01:18 -0700
In-Reply-To: <tencent_03EA78899E616FF00CC749FE8840EA81410A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f5d02e.050a0220.91a22.043e.GAE@google.com>
Subject: Re: [syzbot] [net?] kernel BUG in set_ipsecrequest
From: syzbot <syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com>
To: 1599101385@qq.com
Cc: 1599101385@qq.com, davem@davemloft.net, edumazet@google.com, 
	herbert@gondor.apana.org.au, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test:

want either no args or 2 args (repo, branch), got 7

> From 2edfc8833e43cdf5ccda8bd5be3da5d1bbdc69c6 Mon Sep 17 00:00:00 2001
> From: clingfei <1599101385@qq.com>
> Date: Mon, 20 Oct 2025 13:40:35 +0800
> Subject: [PATCH] fix integer overflow in set_ipsecrequest
> The mp->new_family and mp->old_family is u16, while set_ipsecrequest receives family as uint8_t, 
> causing a integer overflow and the later size_req calculation error, which ultimately triggered a 
> kernel bug in skb_put.
>
> Reported-by: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
>
> ---
>  net/key/af_key.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/key/af_key.c b/net/key/af_key.c
> index 2ebde0352245..08f4cde01994 100644
> --- a/net/key/af_key.c
> +++ b/net/key/af_key.c
> @@ -3518,7 +3518,7 @@ static int set_sadb_kmaddress(struct sk_buff *skb, const struct xfrm_kmaddress *
>
>  static int set_ipsecrequest(struct sk_buff *skb,
>                             uint8_t proto, uint8_t mode, int level,
> -                           uint32_t reqid, uint8_t family,
> +                           uint32_t reqid, uint16_t family,
>                             const xfrm_address_t *src, const xfrm_address_t *dst)
>  {
>         struct sadb_x_ipsecrequest *rq;
> --
> 2.34.1

