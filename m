Return-Path: <linux-kernel+bounces-814289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F432B55205
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FBB316ACB0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF0119D8A3;
	Fri, 12 Sep 2025 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EOo58T3k"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153AB12FF69
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688118; cv=none; b=dFTnBncqJs9HVfQ1QCD6o+kRVze+1NiDfCgFZ5qeNkEXWp1DgaMKPwzRMGFomrjpuOT9X4FMO7mMjhO4Lu6zAjzYF/SZKOQG2KmFN6nVGU0VUTbaks2c8j8bNXSnyxrHwVE5tdQ0fQZ7Ai3IPm/KE4BQcnH+7QNf08+l15tTlTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688118; c=relaxed/simple;
	bh=FHjbJdtudyt0vGhKMApu2KHBlfl47fZMhc8fNsFkBJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNYULTvxHOH+NdbJQ/UHDbqjw7iolL7GMf8tQeeoOXzB3eCRCMwY3bqnrvkDxCazwXtHqOt0E17/0sA53U5g/vPxrCYNAUU01ITbkyl6j2E80PSAMzg1EXCkSFpPnLWurKWzS2vLqy49kfzKkfGCpCpwLzbbao713bHssx2+g+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EOo58T3k; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5688ac2f39dso2306102e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757688114; x=1758292914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHjbJdtudyt0vGhKMApu2KHBlfl47fZMhc8fNsFkBJo=;
        b=EOo58T3kd5XIpsTxxM4+JwFhsnF+OAtJIO4BQ1zsY8vM+Kshj1PyXJqnfB+v2F8IWz
         zo9Qj+imAK67ZOvFNPfjqtfiIX4YVRdxLVc3+2p5y25IEmRhfWbX5X+18hFzS976pFJd
         QKeNos/2V1YmQpZnXLz6iO3lT77QjjxAo1shKYIcqJ3bMNFHhnrm78qx/yovIdrqBnzA
         r0GhwfetXtC4ziMWKI2q76bnZvbLcR5N7oWSUnZhqjxJirgKOnkvLp9j7kocgrCyUUKz
         P55S0/nuXYjt6QOvYSiB8rfgcUaVRjWww2Z+hMy6s1BEEkA6TM3bmXiLfUb9eisMGtNe
         z91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757688114; x=1758292914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHjbJdtudyt0vGhKMApu2KHBlfl47fZMhc8fNsFkBJo=;
        b=hkT1ogOmmJB+Ga58Eui+5LH8/Qqs6fL3vU+fabmjrl60BWOPzX6dDM3soxMYd0uLAp
         jfIijsnhCYse9qXls9BlH7T1IBspffF0gxuxYSKWEF1LGQpK4H+gyA5v5suA8U9u1gyq
         Dz95f4zczXHC6uxNM6lqMTawFPrqZgEBvn2pHf8nFau1HMeFJv4aEPEhPfHXEUXZATba
         MGjUBPsP3ekbLJ6Q1I+xVuB0ARuWKo6KkNqswyefTnN7ERs37pzw/7YSmAq4OJHJei94
         ITJ9civi6PiqIZHi5uwHGSxK1gRXF1Jzbyc2BVJ3X1/E9B6BF4RlpMjztsj3phpMdfpR
         MnWQ==
X-Gm-Message-State: AOJu0YzZvdk6AGH9xSV4KHqUTRhv3gP8WV13XMXmUbJXWV6/K8KJ6FJV
	BG2vvqmI4qufyEUJ/qtZhhp99nIM+W/Vo0eYKoEXIzW9Gt8LqyuQgK7ZYxDOhpbxvZqA850+tXO
	c4QHPos2AlWrpePKPH0uS7+O0wCqMdciiI93DcvEWTg==
X-Gm-Gg: ASbGncs/tkSnhwLNm3nDPWfYZqO41JDEZZJrhPdYOf21vivPYe7MeLj3x9FX+BMFE1i
	g/Yt6L19YStuASKWATXTHAs3z472kfv/SyGJJMCUO+4xkcZbiYNqrqodHXJ0E1TdplYytmvaOdC
	obMu/7jc7mTTD8v/OdO177Q30zztZvOSCu470E9zOtlKtND9xeZGGuhAMol5nziFnpZymoGF5d2
	wVZSCV/yeleHrl01XUV4dPFn3SDN/6wOHs3Q63J
X-Google-Smtp-Source: AGHT+IG83mg8C15DLml5L4U3tdpjf0VWv0vGOneubDXR1XMdjs97C4rBDul+MA3shLn7lg6vC3in887d/AjcxERRYDw=
X-Received: by 2002:a05:6512:3b95:b0:560:8d61:8c03 with SMTP id
 2adb3069b0e04-5704a8b5ae5mr969535e87.25.1757688114063; Fri, 12 Sep 2025
 07:41:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905090505.104882-1-marco.crivellari@suse.com>
 <20250905090505.104882-4-marco.crivellari@suse.com> <86200ee5-c0dc-4a70-823a-ae36b2e6c544@redhat.com>
In-Reply-To: <86200ee5-c0dc-4a70-823a-ae36b2e6c544@redhat.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 12 Sep 2025 16:41:43 +0200
X-Gm-Features: Ac12FXwV1cD9lEMSZ-Wc7hO-DGas0od81NQNgf1aZIWSP1dpFq5I19w78J19LHM
Message-ID: <CAAofZF53u_AfOMbGE1d0RW8-M=VZhxCzvMSTxUbxsrhAAg-8wg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: WQ_PERCPU added to alloc_workqueue users
To: Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 11:25=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> This and patch 1/3 do not apply cleanly to the net-next tree.
>
> Please rebase and repost.
>
> Also I suggest to split the wireless bit out of this series and send
> them to the relevant sub tree, to avoid later merge issue.

Hello,

Thanks Paolo, I will do as you suggested.

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

marco.crivellari@suse.com

