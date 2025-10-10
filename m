Return-Path: <linux-kernel+bounces-848453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA18BCDCE3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6911518898F3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394E12F7AB6;
	Fri, 10 Oct 2025 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SZEZHA8i"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332FD23FC66
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760110269; cv=none; b=AViRC83XhXWc9OkTW7l350RRLgCAIvsur12/WCbRH0JISIJW0Yk2ybBB+YJVpsniDcB/UFyDNi6hh/ulTBTN4Gxg/DFBj9keuvF7EKFWkziBAXpjvSd0ZtGO/qJiZ0jT97w6UiQMwM6imF4c4grEoCwBab1bFxFmCdqRpOky2U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760110269; c=relaxed/simple;
	bh=lOGLGjlMyLICkMjmwtSZ+vlC0SyDUVqe+Vg7webstPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J2WJASg9U56I7u9TvEaCoOAvw3PWaMMPK26Cm6x6SeHbLTR/E2c6rdJznYQt9TrNumizb2YXgr1yXDcwoBhjvQWwh/azJY40ESYp5I/rgAbwmVxLx+qZTcVSHc+RHZi1jHy387d5gORSWFp4X9ytPYRZJo1PfB7N7VyrBAqePhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SZEZHA8i; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-637dbabdb32so4216046a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1760110265; x=1760715065; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BO0E0MWC3ExBs2Heibpgos4vG9p8jnA6/CsJGcLsoMk=;
        b=SZEZHA8i71uNZwvYj792iGvGO/wM8AWLCDaF3nbLesDt5781HuTkeNroVY3CCsKQZT
         PDmDPwakGl35zndqR1IdXJFaEWKN7MICqR7ejcJts4jcI8CKaMnSARCNv3UbG+qR092S
         IeL3kZZFBU1xacvAgTJmDrrli+uvFzH/HumBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760110265; x=1760715065;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BO0E0MWC3ExBs2Heibpgos4vG9p8jnA6/CsJGcLsoMk=;
        b=XGr+BMc5IeM4f4E4in7JZXxSNABiNuJVFa0M3ztfCO8/dXxbgsfVq8UPVHDwkeiPGJ
         YG+c10ujKujRHQK6k81XCQQVDRdyHdFMSiR5AU+DkTkSxu4Khctx3uD9Z/nOVkiCbTZ7
         Zixhe9+6muAazJTiV2Mi2J6IcUzGDGAOUOdQ7CiZVGDNluz5KQfq44gNL30WwrkndImm
         prkd1wCpl1MPr/RHEV7la0QD00HtM5SMLdwx8kjr0h4cBzjcuYnW88MnQjtL1sktTeXu
         EuIi7IhMPzV9Tr7DfCzz+mLBWgIVUuI2XzEuYUVJRAPDI7QQNuqqNKOCou+R3Tpcv/OJ
         ga+w==
X-Forwarded-Encrypted: i=1; AJvYcCXd1Jgh1/W0RV0TF6q5kgAmbv73BTURfpeXRQC60IBgFsTqYjm592vS1P7fNx15YW92VFIDVvbyW4IRGvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw45XBVSva0kxI6aEiuKNb9ZNazaLrRuyW+ba2ylBe8VA4nt7Jo
	oXSjlp/QYzg6FPxJuHqCt9rOuMisDt3xwPSl7xuW/QA470pU45C/qjRHU1KQEXRGPD/fw/YAUcl
	qqOVxU+U=
X-Gm-Gg: ASbGnct/MYg4wm4sxzxExnZU2PTa/c52L6J5gHfN2gCfuued+/z1b6cn4WZsmPSwmkU
	AjCjgJ0OBQbLeCVI5wFtpRkCqycCl1RUMwPMMnldcg17N/8ETgtTJN6h/nfzv4qq+dvw3eP/Vk1
	awaXjnJbEEbrG6LgkaAPIULkt36aRSUx4VG8DrPbT664IMW8k0ZMiuYwvpdF/vmDLp+Jp0VCw/m
	dZstWjj8qjCLb2Tc8KmhkpzdmcgxsjIPc1kzwrz24Lwtu0hxDYPorXKdptl2vxAE7fem4eYV2WH
	K9Vl3tfWno0SceIkQOjzsLO3lSTg3bPk/sxhLY5ikMwmP7t/eInun0xJW6wSJDZOijKmH5L/mXK
	jnGRhjFWnuJH7ZQ7NT8h3S7kY3hENrGojo1khVVNkIKQ2E50nEUZgbTLFZYnyN8pKu+8Il+753o
	axTOiDpoyfM7qFAntGLC2zOoWFqg==
X-Google-Smtp-Source: AGHT+IFi4YvgkqJgsieSHohOfVLWl2YR2+B6K0SIUVmOWms7YTIyQ7uWNHXgF8Vg0OVnZzGjVmwgcA==
X-Received: by 2002:a17:907:6d28:b0:b45:2612:255c with SMTP id a640c23a62f3a-b50aae92195mr1266238466b.28.1760110265254;
        Fri, 10 Oct 2025 08:31:05 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d900e2bcsm252662166b.64.2025.10.10.08.31.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 08:31:02 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso4643151a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:31:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXuGxKSm4Jm5JMkKf9jIMLXlqgfrwOHv1R7Bet449cHH7vG6By/4BZPWJAp77hwd+03ue9hTivUUMRCo8Y=@vger.kernel.org
X-Received: by 2002:aa7:c54d:0:b0:639:7781:ea20 with SMTP id
 4fb4d7f45d1cf-639d5b807bfmr7675381a12.11.1760110262066; Fri, 10 Oct 2025
 08:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjozC9_JCdEW9K_uruJqzTLzhtcVpgDk1OuqErNRUS7Mg@mail.gmail.com>
 <CAHk-=wjuoFm9yZur_T4VOnX2iyDYD6T_gDRXE5ms9538W6Q35g@mail.gmail.com>
 <CAHk-=wiHbN+_LCmSj2sHswDRJ0yG3kkjptMvCXcMwk7jWK1F=Q@mail.gmail.com>
 <20251009143748.GA2704@redhat.com> <20251009195024.GL3289052@noisy.programming.kicks-ass.net>
 <20251009201154.GL1386988@noisy.programming.kicks-ass.net>
 <CAHk-=wh3h5cV=UiTg+gvqB-T6+pStDNH0+6w4i34qMC1BQwmpg@mail.gmail.com>
 <20251009221242.GX3419281@noisy.programming.kicks-ass.net>
 <CAHk-=whmjm0BbirO8HhT_TZQ2JJMs_FpTcT9SXXaA3NifW2a4w@mail.gmail.com>
 <20251010080327.GF4067720@noisy.programming.kicks-ass.net> <20251010122347.GA8798@redhat.com>
In-Reply-To: <20251010122347.GA8798@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 10 Oct 2025 08:30:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3_ahAMbR8gqh3kKf1BK-UC09cGUMVZCojgNtGD3-UVA@mail.gmail.com>
X-Gm-Features: AS18NWCzxH8cnAYvlJWAYxGrxNbdL_YhK4FY0rW6dBbFKEJ55UKUy7opueqWB_8
Message-ID: <CAHk-=wj3_ahAMbR8gqh3kKf1BK-UC09cGUMVZCojgNtGD3-UVA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] seqlock: introduce scoped_seqlock_read() and scoped_seqlock_read_irqsave()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Boqun Feng <boqun.feng@gmail.com>, David Howells <dhowells@redhat.com>, 
	Ingo Molnar <mingo@redhat.com>, Li RongQing <lirongqing@baidu.com>, 
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Oct 2025 at 05:33, Oleg Nesterov <oleg@redhat.com> wrote:
>
> I leave this patch to you and Linus, he seems to like your code too.

Yeah, I think PeterZ's is the best of the bunch, I like how it looks
in that latest iteration.

           Linus

