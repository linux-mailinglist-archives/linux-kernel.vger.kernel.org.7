Return-Path: <linux-kernel+bounces-726052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013ABB00786
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38CBA16AF55
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D13A13B293;
	Thu, 10 Jul 2025 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VJHGUBTM"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA882749CD
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162302; cv=none; b=ZOeKA7K4YxEedFRJqHNXD7+j7yhoKFkIcxk7aiAAqFSxs0dEfTcSXw3zc5A+eheAT9Df8h3zgDH3qTE9wu/cMj2ANoVFSLlqHOXEzhO39Bvb8qouvH0fMYHAsAOig8y1M3yXVVHOKmCFv0WlRkAYPxKJi6Fwit43FaV5LU3M1uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162302; c=relaxed/simple;
	bh=QmujRR/DPSYeyQdUA2QOLtioAeBLj6yZR1ReOaTTl+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4UEojHaZ1/6i2yET3oPrBTqgzilLvmqvv/gk2ejhha2lE9RbAHT0Q0eUmk0oVlmaxOsgMuESkWQ+4dT/ceptxcQNy6uOsqe7+TB3g5WJraG204/4Nx7A+H4+mta1WuFWJj7TjGfBo3+oC8XdMz0a1QyJV5OWCMNtxPZNa/Iq+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VJHGUBTM; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso555097f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752162299; x=1752767099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DfKz8g7IocA8u5rsIUzAiiuZKjZKWsYc3v5k3LQbtY4=;
        b=VJHGUBTMrwMERuPq97dXUa1f3iWn0ttX6YUPPU3Bf64GuLg08iC/mOmzAbhEXMt963
         QFGir/+AUhFavobeK6ga7QThe5y8TidehjGwrxBScWT0W2otPz7JTPBri5eyfdxjxjjr
         WgtGihaGQ5PGjxyWytU04/ZbJQO/eqaiJk+k7ryUN6sA1AuMLIElY7sO2skSx45m+0Y9
         LBjWx+LCYBHgZ9w9mNilyJSpIBGen428HNXQXT2HLuTw/QUE9oQzqf79CRFiKnDtlDM/
         tsyjK76Z6OoZ/uY3qCmIWazs1QCGKjEYMFT0GT3+fPdlIAOuFvHAhs8ixJrWqtpoIKv4
         PGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752162299; x=1752767099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfKz8g7IocA8u5rsIUzAiiuZKjZKWsYc3v5k3LQbtY4=;
        b=U+VPwoK7ZoYbZ3hIM4eqk9DcxnxaT36unWr4vuMaCjg4ICW0LARNy5ivYSn7+l/s4i
         MpCKGcDxFn1Z0a4qUFFcIWL+dxyvhxZws4WLNZal8fEmUcOfaDXNxeGs9DGAF94OnkEO
         ZpBaCpPAI7SU+wNYxuhOywtm3qbBxqqudR9IIQpL/B9sE5eP24GC0IL/SryNopvPh4Qk
         cbAqosB/S1w+A1idM64nG4snBWi9vO7kC4ADc8TavtqirYuZZrtCJUNbaVNU401V8TnA
         ugJ8Yr4qtZy8hjRnf08VEvPkUwrKdvEoOM6jFSqb4xGHWE5LZCYkcVhKuBukN6PJ9XsE
         5Tag==
X-Forwarded-Encrypted: i=1; AJvYcCWzMB9q3fIhwYrvcy7AFxa4uLwxyEtRdphP2iwPsjCiPfsUqk51lIwAlTjGm2+2g9lyKoOlkT9vkUwBr2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd95hJndphopJyYalOXrVpgYn3Sqwjp1Qo2+5zIW41Ucb+1SWR
	TOppyAOJEkwJbXwIt0WQPLZ5qoGNaeOsnOpDlPxOmDw7CO/aKHWgmQAVFFabVwdGRso=
X-Gm-Gg: ASbGncsDgb0+OtyN/wJ+faeVGWSQzZbzo9ldBVQuc8ib6E3OoK5G+TX9BZNSYG4LEoF
	bhFEd1gJY2D/NH3iAPFilg8HD6eiN1ac/pwQejOZBnd0LGpW8yDawQAzV34+cL/kEoO/iLe6dPf
	ZOw+e+o2UL3gWH7ie4lCRpnSeNQY6P6oIm40JBlIiQtAmJaP3r5mM4Y79Hvyjhc32hCPKKko8+w
	gHRRX8LW4VH1wTrWRrqpiuvBWkUzTBSb4etPU19sc4DWsogGBZCduW8noGGcxmb0mbcReeQgFi5
	MXEYByztsNXIpo2+SPwr1jPvJpiKUDoHTD9/5PEwSzlULoeDU4Sb1NLuwHrltcSN
X-Google-Smtp-Source: AGHT+IEi2g5/DN1K+2wwgAq7qMOuInWE+sU8AeJJ+3cUVcc8tWGmi1OpKIHzd2MuXTKU6wOxwERxHA==
X-Received: by 2002:a05:6000:4603:b0:3a4:dd02:f724 with SMTP id ffacd0b85a97d-3b5e4536c3fmr5408824f8f.43.1752162298609;
        Thu, 10 Jul 2025 08:44:58 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50dcc84sm64914835e9.24.2025.07.10.08.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:44:58 -0700 (PDT)
Date: Thu, 10 Jul 2025 17:44:55 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>, timvp@google.com, 
	rafael@kernel.org, pavel@kernel.org, tj@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com
Subject: Re: [PATCH next] sched,freezer: prevent tasks from escaping being
 frozen
Message-ID: <2v47s2xlbmuz2mgxk2p7o2q4t343nde6hkyqxpmfgmrjygmrz7@alrwuxvupe36>
References: <20250703133427.3301899-1-chenridong@huaweicloud.com>
 <n23vsu6y6cjf2vwdbfcjl2mj7venvpzpblncoa7adn3q5r4lph@qsfa3deqtamc>
 <f4c4f465-72b9-4682-99e6-c249ecab8572@huaweicloud.com>
 <8dae8006-e63d-467f-bb7c-e8470878e534@huaweicloud.com>
 <20250704075718.GA2001818@noisy.programming.kicks-ass.net>
 <85fc85e8-af92-4d58-8271-9bf4aeb0a63d@huaweicloud.com>
 <bdc5a4d3-6942-4ba2-a13d-35f2e13c0b37@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="paycgh4vipu5nayz"
Content-Disposition: inline
In-Reply-To: <bdc5a4d3-6942-4ba2-a13d-35f2e13c0b37@huaweicloud.com>


--paycgh4vipu5nayz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH next] sched,freezer: prevent tasks from escaping being
 frozen
MIME-Version: 1.0

On Mon, Jul 07, 2025 at 12:02:47PM +0800, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> I was looking at the WARN_ON_ONCE(freezing(p)) check in __thaw_task and s=
tarted wondering: since we
> already have !frozen(p) check, is this warning still needed? If we can re=
move it, maybe reverting
> commit cff5f49d433f ("cgroup_freezer: cgroup_freezing: Check if not froze=
n") would be a better approach.

I think freezing(p) (the part of global freezer) and cgroup_freezing(p)
should be consistent with each other. AFAICS, the former predicate is
derived from pm_freezing and that is set all the time between
freeze_processes() and thaw_processes(), i.e. it stands for both the
transition (freezing) and goal (frozen).
With that, the warning in __thaw_task() is incorrect and the solution
might be the revert + drop the warning.

(Or transfer the logic from cff5f49d433f only to the warning like
@@ -204,7 +204,7 @@ void __thaw_task(struct task_struct *p)
        unsigned long flags;

        spin_lock_irqsave(&freezer_lock, flags);
-       if (WARN_ON_ONCE(freezing(p)))
+       if (WARN_ON_ONCE(freezing(p) && !frozen(p)))
                goto unlock;

but I'm not sure the warning buys us anything in either case.)

0.02=E2=82=AC,
Michal

--paycgh4vipu5nayz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaG/f9QAKCRB+PQLnlNv4
CD0AAQCwacgAQtPb5lDXkPUYXAxsRthQNUdqxkR0o4AUiOIrLAEA1ffpWdi73UAZ
BXGSp+kJOxD2mYefTfoKzPggWAziwQs=
=VYIq
-----END PGP SIGNATURE-----

--paycgh4vipu5nayz--

