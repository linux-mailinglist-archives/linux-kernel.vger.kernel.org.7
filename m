Return-Path: <linux-kernel+bounces-728819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC71B02D6D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 00:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D1677B58F9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 22:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8FC22F16C;
	Sat, 12 Jul 2025 22:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0MxG1lzu"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF89C22A808
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 22:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752358386; cv=none; b=Q6oJTkqg3+TOZSbIHuc5/rXbNC4amWdt0/jwwa66AhWZR+9ys4niEFa6aWpsymeu7FLc5+eQtInbtE2MHMI/RupxMz71Y7PcOl2N7D8j9J/MZXGY/yKxLG+WraDeOGFxX76D1T2K0o9eJjQOnn8bel4BJ9hxcm2HMMjpUMoDIf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752358386; c=relaxed/simple;
	bh=5XXI0zqO9HMq7gS6Sutik+M16ZOwrBzNAUpGoe9/fK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F34rXSbQkLVc393dElWogstbxYRoBRxTmEs8cM8fYDRQFci6rQSflMHaw0BRuaCZS0nBoXBs7+XdTrPJzga1scrd45oI1xeP71BABZDhqsvKeWi2Y6vJoqG8MgjMq7KKgwIMsgvHudA3Tm5oZ2yjbEAbWhqy2x//VXnSOnc3Mic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0MxG1lzu; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3141b84bf65so3095319a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 15:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752358384; x=1752963184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3IR8E8NXgqdr3xTjXmNxa9Xtvc35MpTBYH+CEWW4Zs=;
        b=0MxG1lzukfNP/3qBbomj2SouCx9pw8McxtVXRsyjWqNFiMqhktlUwZMy3YZ79w7HqF
         VVPIWPKs8WPWXSGcofRKkUBGS131gXOhmfKBtduV3TIQLO3WkPmIAm+FNguLSk4zUU0c
         w44KB+HyyT7mAloxwjUTFVsl3oTAXRChe0F3yKAIqgUXgKUDwqxBamPPSn6D0sowb2r7
         QzdgHV2iOhJCXnFroml0KxpwAtMmq0dIyo01UPTUdbooXzo/s4lYzW11wqUnY0AjwFKb
         p9ASViWskui/tvb0Zjmm9hGknCMYKKsOo78mP+11XyDLyjoY709MVaLaJlVuCsGZRGp9
         Rr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752358384; x=1752963184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3IR8E8NXgqdr3xTjXmNxa9Xtvc35MpTBYH+CEWW4Zs=;
        b=Y7FoePTLxCp4EZGpD1LMLvO4MDY7udS2pawVoCI8aExokZ5TvCio4i0V/vR83xyKVh
         ApfCtb7JiNeUReFTU14AvB+ZmUhhe5EQQc5k9pr5hKPSG91xIfcYUyJ8RI6RoxfWcp7+
         Qb6gO5+Q/oERUgfT72Q+/5532FojvIfXtD6Jh6Zum3k9E1VbAEY+DlhkUaT4L2IoH6U4
         6Ju1rejX0xCFzaypaZhzE/R+aG5/OWPjgoQ+931NglA5JgvcNtKmREmGbLEtSNIX9bxs
         IkVYi/FUqad0BHe8/aM/TRw43YwexZ83KRtWIENcFKBtgCRkDog33rk+2aADPlhb5Opj
         BHiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpr1+R3wlE7vRuEWxxed9ABaGcTXwGtnOKgjO/XU6hzT1MP34lomKUFcazNS5n6W4/kkPeDYzw9khkhZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywils+PE2ylQdnQ36qKeMkKm6iLxcM1540wXI/uVrRPChEBXzD9
	Gi6QOuL8A1DfJdBhAUVybue4afiU9mWTRsMJRcJsV3N/dNExy4DgsQx7anBtCVI3WIM9TJGyB74
	YNblztbMPwClSHNVywFeRYtmypCn6CDDumCZ7ZaC9
X-Gm-Gg: ASbGncsX7JZDd4QM0mvy2L+xyil+Kf5FaKn790memtlEXvQT0nbAgukH23fGrbtSC0m
	/rBpGEbGAE4LvIpiEc3k6dfWTqsJK74bZJv0ZMvAAdt70qd+OLb3Ue97CSumBWYzqbYbw4BTKRe
	kEAaQk9OatbkasF/HAOA4t6Yx2IldqRnAPeUKL8YuUmM3JhetLKiBEewuOEnrX7jilC0sYkSkIN
	AC+ERKvtMsTkx0jlATZOp8mbA7dg1LytDemV1356X2H+CsJgpY=
X-Google-Smtp-Source: AGHT+IFALuoDtWo+OC/rzMxiROtsngZC+Ie3sK8eJASz1Je4/SFJtyP+rSk+kQfuqv5DmUOlVxMITIXRbZY281qGXfM=
X-Received: by 2002:a17:90b:278c:b0:315:7ddc:4c2a with SMTP id
 98e67ed59e1d1-31c4ca84b16mr13015237a91.12.1752358383922; Sat, 12 Jul 2025
 15:13:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250712092811.2992283-1-yuehaibing@huawei.com>
In-Reply-To: <20250712092811.2992283-1-yuehaibing@huawei.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 12 Jul 2025 15:12:51 -0700
X-Gm-Features: Ac12FXy611-09B3FFXu8FBr8o8MzwuFwjv5t8T30MiI--EPnB-Ej0E20BluI0Zw
Message-ID: <CAAVpQUC-mV=SuNNhKbpy_1Mbh_sOs856+oNqDVJ4KcLjhDh2kw@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: mcast: Remove unnecessary null check in mld_del_delrec()
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 12, 2025 at 2:06=E2=80=AFAM Yue Haibing <yuehaibing@huawei.com>=
 wrote:
>
> These is no need to check null for pmc twice.
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/ipv6/mcast.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> index 6c875721d423..f3dae72aa9d3 100644
> --- a/net/ipv6/mcast.c
> +++ b/net/ipv6/mcast.c
> @@ -794,9 +794,7 @@ static void mld_del_delrec(struct inet6_dev *idev, st=
ruct ifmcaddr6 *im)

Rather early return after the first loop if (!pmc) and
remove 1 nest level below.


>                         rcu_assign_pointer(pmc_prev->next, pmc->next);
>                 else
>                         rcu_assign_pointer(idev->mc_tomb, pmc->next);
> -       }
>
> -       if (pmc) {
>                 im->idev =3D pmc->idev;
>                 if (im->mca_sfmode =3D=3D MCAST_INCLUDE) {
>                         tomb =3D rcu_replace_pointer(im->mca_tomb,
> --
> 2.34.1
>

