Return-Path: <linux-kernel+bounces-699744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F76AE5ECC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 10:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6FDC7AF290
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 08:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D00256C7C;
	Tue, 24 Jun 2025 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ki6sLpFq"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C33248F7E
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750752701; cv=none; b=kXzy2SHf1LylFghhzhT6S9LiMxoT221FNkH6s9zG8QuVoMcd6vBaUA0RXItRtC/Q5Y7ujnzFm6J70bQu0dWd9w26z9D8xhGzZ5R8tFYZ9ueRpunBWgjelyJ5ahyA80x7QH/LOSKDng/bgnvAtW8OlRYY0G0CfunBMSZ+YFNBU0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750752701; c=relaxed/simple;
	bh=rI0uwKqpI8TL3OkoRjh2LE5DiqTpenA9zQsDRWjrj40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eP2kghGcaaevJpCxRArCjK1tkiZTXlSOfZXDuDt600knhMQkvo95QEL+zWOFaUNEpasAze1Rk0GO7nQO4gSVE7shrbpCj9udJppxHmiDzw6bLnxdbAZlXgcoExS66+fPOSLqbJLxVOA9JaWmSvueUrbhX8lDRwt+3vq1N/IyxkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ki6sLpFq; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32add56e9ddso41950971fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 01:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1750752698; x=1751357498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnZJLJCW800VkWoC4YxYE6tZ8WAA+yiK65lcySNG5GY=;
        b=Ki6sLpFqoe+SwV4ivOkWz9nsIPFHyox++9WOBeg6ybSYGbxJ4GPM1uR03G13oPHSMx
         4/kfCs7q4C39zqV+7RIesENMCoPD6arxC09NavItsGnAfEn1r5C7+Opcci5PUa8CccLg
         IzT7L8O0nzeFKKxe0DnYuF/PkgTwmklDfJdkNm6S/Vu+I6Xr2iA8bIqgbZlJppSGO449
         G+HKFCQYiLOHw0yDQyNKAalYA75iUCHOi7do7kKNV+wTqGP9GG9yFEAwSInYUW8Z2Gxz
         lQsA0Khe/IWYIneao13SoabxbDb4EtxtikA17yeF3bSmVymiL65MYO9orLj5i3igZ2EN
         TKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750752698; x=1751357498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TnZJLJCW800VkWoC4YxYE6tZ8WAA+yiK65lcySNG5GY=;
        b=ZRNA5qTTs+/q8flrfgNPJRcMbjZTexvzdyIPrB6/GHK9nJzH0GiVXMBpGtkY1aXIQ3
         guPqvk6mHI1mFvboeh51+i1EIXzp1/eJ+VFZXOWfpZcN9QjrcUw9rULUa5zYPJsDmzXU
         8YhSGPEJGNnkUkow14OnwSa6BwGc6AosvzjM+k6YNN5LXY8cAtsqp0UxQ+4an8S/5/jN
         HX1vAbaEV7L3Y3sC5nz0wVxzim+QVKWQfwHuJfp7ch8XpRooCCKgIDd86o3EYqonF3WK
         pqm00qFzrr3iBZYKNqoFaHtifINSQPjahN7Vhafe9QZS2G4Yz+hykBDpeS/QRzUPWcrN
         hvow==
X-Forwarded-Encrypted: i=1; AJvYcCW0vDFeeZt85n6YsbRPStvO4XgflJVbIR2bm5aiOY0VkUjmk4Y5gIqE6l3J5+5QTjapR6LMJu+c4FAZD8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAaxIPEudmzy5lDeWa1YxqIxdsK47G4oooDXWFJglBnimgzHAM
	trYiVvigw2praASYg9CJY5dCAkdvsH8WqDSHi/b21gyGFhhJJr/cfmdU8kN0Nk3LBOaq58Wz8dZ
	xaM2iFkR+Alng5laaTtpI2AcWQim8GB/ALfH/5nlfGQ==
X-Gm-Gg: ASbGncvJ7o5/V5YYuTNPcmrBzjhwSSQ3II4DL69BSiZBUD/sUMBfKHwmLKnnCnDLUTz
	hPDW+NeLyADL/DxAs2Q/Z9nWDWezOQKf67TwF+OuQFQsKBxuQGSXNoIbvXt0IzPOheaCIrTk+I+
	L3YC3jyGi1YnKQQLBzqkIlvxPhh0MeHhqYOI2uMY1YDWn2LX61dNRszW3ErVaHd54+8g8=
X-Google-Smtp-Source: AGHT+IHl6yvkOmuagpboELZZTK40KqLlogiqJwZ/l6BnYAAjul2G08F0BtiFYG8ppq0ZNO6KSFx+D/hxcK9JExNI53w=
X-Received: by 2002:a2e:a7c1:0:b0:32b:533a:ef76 with SMTP id
 38308e7fff4ca-32b98e6dc0dmr40907051fa.13.1750752697501; Tue, 24 Jun 2025
 01:11:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aC4J9HDo2LKXYG6l@slm.duckdns.org> <CACSyD1MvwPT7i5_PnEp32seeb7X_svdCeFtN6neJ0=QPY1hDsw@mail.gmail.com>
 <aC90-jGtD_tJiP5K@slm.duckdns.org> <CACSyD1P+wuSP2jhMsLHBAXDxGoBkWzK54S5BRzh63yby4g0OHw@mail.gmail.com>
 <aDCnnd46qjAvoxZq@slm.duckdns.org> <CACSyD1OWe-PkUjmcTtbYCbLi3TrxNQd==-zjo4S9X5Ry3Gwbzg@mail.gmail.com>
 <x7wdhodqgp2qcwnwutuuedhe6iuzj2dqzhazallamsyzdxsf7k@n2tcicd4ai3u>
 <CACSyD1My_UJxhDHNjvRmTyNKHcxjhQr0_SH=wXrOFd+dYa0h4A@mail.gmail.com>
 <pkzbpeu7w6jc6tzijldiqutv4maft2nyfjsbmobpjfr5kkn27j@e6bflvg7mewi>
 <CACSyD1MhCaAzycSUSQfirLaLp22mcabVr3jfaRbJqFRkX2VoFw@mail.gmail.com> <jtjtb7sn7kxl7rw7tfdo2sn73rlre4w3iuvbk5hrolyimq7ixx@mo4k6r663tx2>
In-Reply-To: <jtjtb7sn7kxl7rw7tfdo2sn73rlre4w3iuvbk5hrolyimq7ixx@mo4k6r663tx2>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Tue, 24 Jun 2025 16:11:01 +0800
X-Gm-Features: Ac12FXyk0voBgT8_FFyuTzOzG8dPqch39FrARLntQAdqtu502WPmum__939WsjU
Message-ID: <CACSyD1PhM=U1bxqYeZXHojSRWWPB3Y7j30jLLykjRzLuQQzn2Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] cpuset: introduce non-blocking cpuset.mems
 setting option
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Waiman Long <llong@redhat.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, muchun.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

()

On Thu, Jun 19, 2025 at 8:10=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Thu, Jun 19, 2025 at 11:49:58AM +0800, Zhongkun He <hezhongkun.hzk@byt=
edance.com> wrote:
> > In our scenario, when we shrink the allowed cpuset.mems =E2=80=94for ex=
ample,
> > from nodes 1, 2, 3 to just nodes 2,3=E2=80=94there may still be a large=
 number of pages
> > residing on node 1. Currently, modifying cpuset.mems triggers synchrono=
us memory
> > migration, which results in prolonged and unacceptable service downtime=
 under
> > cgroup v2. This behavior has become a major blocker for us in adopting
> > cgroup v2.
> >
> > Tejun suggested adding an interface to control the migration rate, and
> > I plan to try that later.
>
> It sounds unnecessarily not work-conserving and in principle adding
> cond_resched()s (or eventually having a preemptible kernel) should
> achieve the same. Or how would that project onto service metrics?
> (But I'm not familiar with this migration path, thus I was asking about
> the contention points.)

The cond_resched() is already there, please have a look in
migrate_pages_batch().

The issue(contention ) lies in the fact that, during page migration, the PT=
E
is replaced with a migration_entry(). If a task attempts to access such a p=
age,
it will be blocked in migration_entry_wait() until the migration completes.
When a large number of hot pages are involved, this can cause significant
service disruption due to prolonged blocking.

Thanks
Zhongkun

>
> > However, we believe that the cpuset.migrate interface in cgroup v1 is
> > also sufficient for our use case and is easier to work with.  :)
>
> Too easy I think, it'd make cpuset.mems only "advisory" constraint. (I
> know it could be justified too but perhaps not as a solution to costly
> migrations.)
>
> Michal

