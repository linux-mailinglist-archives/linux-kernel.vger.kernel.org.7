Return-Path: <linux-kernel+bounces-736502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 478B2B09DB9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20DC716A801
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA1C1F55F8;
	Fri, 18 Jul 2025 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ayLmZxUC"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5C01CA84
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826825; cv=none; b=bRJpBMDggdo2iiRlgLBhEL81Zb76LVoAk3YGyxOgxHW02AzmLvPfo+3d4J0iFsUBzDfoHg+MLmm+mASaUF8sbTVK+vlkbPjGV59uImLh/o/XsQxNhxxCW1YXClksKqL/yEBDMiiBjDTU3aDXhW3E/uTgr8xfko8PTD8Yz+kzV+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826825; c=relaxed/simple;
	bh=dGKkJmaxhFVHM8HKQXN+ruzKyau0iJTAr3sXMaXEuLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pv1GAMue/GVg0rqMqOwOfzio1bKzp+mnD+a3Rw347icLW+pNqnA6Fz6XyEeQIFGNah8Fb4gj4yeJQZjMhefQK4OOlzcJpOkhSH/W6xvlbynkZ8oMz86S2L5NBBJnCPDUdorComTFc+FCcJGK7+rAO3OiV8psSKabQkLCzxvSY5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ayLmZxUC; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so3298306a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 01:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752826821; x=1753431621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ab4gQxsYWdk9x2tiurNH/DMpPwSVpR7XnZUZ/FhW6Xk=;
        b=ayLmZxUCnph7495FpfHRz5Julx3f4QFzSnlSJwHwgCKdyt80FAp94RXJWhdmj3ev0O
         bIa23o/5fsUJ5dVLEcqMdI1xLzx3OvW7aCnD5cOYiyg2U19Apmpg1EeJGkkbFzO91UCa
         33j7s25W7RheXYPljNKyrLORs9xWl3NXxDgH0SyqQ1muLRtDQ9GWLEd4Cw+T58xKFtxK
         SNrlh3Xh+ryC69zE6p0wfcpruiOaUzRrQLG2Np2GS1bY3jjTaa/0DK175CBNJwTbudhf
         iJ4Ulm/2Gsg7unpiRXCNsVmUcYdmmB8TZfhK9hgYwe4eTNCQc2oaA+vZ8Ia67JNe977u
         XnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752826821; x=1753431621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ab4gQxsYWdk9x2tiurNH/DMpPwSVpR7XnZUZ/FhW6Xk=;
        b=vvdOWeeGO8QKXaNMcKKhLugAu2YOY7ep8u3hwOxH4Fpklg7qQ2MBa38TA8LoUvGELW
         pa4NhCvsm0mqWiAIhxXRsXNT6J07npMaPnUShP8AHzDxixHDA/2H/J2QrmngyCVEIAqZ
         G+5Tuyt5guV5/90N7vMGs+1RGPNUWhXrhN7mRU9qsg2SPuHH3lq8fCfzW+nGL4eqUOSA
         jhcp0MBgY3R3FaCwVcreEZHGT2QpCEJXPCybdFM0m/GseMypMH5sy9B+pAY5KnKWs1wk
         uvEkL0VYcr9uf/4HO3ezZ35M4Rc4Znk/NghRXTFFRnztGBlQrrf3jE4r0ZX0hagq9JwB
         QNnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPW2bKYaqclXPDItD02TzjHLHq3IgwwFr0FvWeIPEd7HFsjeWo3oOJdwzNCC/4fZnllmvqbo2nDzM/G/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+ElKxT7c3kp/oQKIPGuVj1Y99n+iU9xnrtVImDe7YdEt7tIn6
	8uUCx4q+lQEssKYjtmVwS4aLQ/a8cq78ElX9DPlg/H4beQX31YBrpQ+tidfhlg+NNwA=
X-Gm-Gg: ASbGnct+surL0370qgD2x975i8HDEEoxlOIlNisknBaXO9ZyYksicaSfmeoafeSxhww
	qI+BL8O1AVyPXvklKNd2SQgZcEYiLtt19dxYU+fo3yNOYopgTeObcBm1qV7dOa7WNKVD1a1CBZ+
	S43ZFbPMJiMO9u0tUQxDXhK7vdh2wn9YDg/Wn8VNwGfPW5qpiNBw9ww43kmU0cPChNi+w6+UerY
	YmedSnn/iDLlrJL69/fyBs/RpDOGr1u2ztmeWxaZ4LRI01RUA05c64FUIJw73xSaFB2psHu2Xcd
	EMGlyR7ATleVJ9QC7XasuqTtRjgY3DN2NY80q7L/xX6gHhHRfFHdJL64+LomGLt9gsWJrPjFDnO
	1PnrHreR6aMFdoJa+qH4jNYenxfot6Hryt4wcvWn4Ng==
X-Google-Smtp-Source: AGHT+IFlFmeWi6E0SMdOYun34OYAUB6SXhFoP9bJcXLK1nm2xdgsaBjOm4t+cnMR1jx+yUkBsFJYSA==
X-Received: by 2002:a05:6402:268c:b0:609:aa85:8d78 with SMTP id 4fb4d7f45d1cf-61285923522mr8734807a12.8.1752826821337;
        Fri, 18 Jul 2025 01:20:21 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f07e0fsm635217a12.13.2025.07.18.01.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 01:20:20 -0700 (PDT)
Date: Fri, 18 Jul 2025 10:20:18 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: Tiffany Yang <ynaffit@google.com>, linux-kernel@vger.kernel.org, 
	John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chen Ridong <chenridong@huawei.com>, kernel-team@android.com, 
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH v2] cgroup: Track time in cgroup v2 freezer
Message-ID: <mknvbcalyaheobnfeeyyldytcoyturmeuq3twcrri5gaxtjojs@bbyqhshtjfab>
References: <20250714050008.2167786-2-ynaffit@google.com>
 <5rm53pnhpdeqljxqywh26gffh6vlyb5j5s6pzxhv52odhkl4fm@o6p7daoponsn>
 <aHktSgmh-9dyB7bz@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jv5tpzpajmrvvmyk"
Content-Disposition: inline
In-Reply-To: <aHktSgmh-9dyB7bz@slm.duckdns.org>


--jv5tpzpajmrvvmyk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [RFC PATCH v2] cgroup: Track time in cgroup v2 freezer
MIME-Version: 1.0

On Thu, Jul 17, 2025 at 07:05:14AM -1000, Tejun Heo <tj@kernel.org> wrote:
> I wonder what hierarchical summing would look like for this.

So do I.
Thus I meant to expose this only in a *.local file not the hierarchical
one.

But I realize it should [1] match cpu.stat[.local]:thottled_usec
since they're similar quantities in principle.
- cpu.stat:thottled_usec
  - sums the time the cgroup's quota was in effect
  - not hierarchical (:-/)
- cpu.stat.local:thottled_usec
  - not hierarchical
  - sums the time cgroup's or ancestor's quota was in effect
    -> IIUC this is what's the motivation of the original patch

HTH,
Michal

[1] I'd find it more logical if
cpu.stat:thottled_usec were cpu.stat.local:thottling_usec and
cpu.stat.local:thottled_usec were cpu.stat.local:throttled_usec.
Only to illustrate my understanding of hierarchy in cpu.stat, it doesn't
matter since it's what it is now.

--jv5tpzpajmrvvmyk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaHoDwAAKCRB+PQLnlNv4
CBlXAQCByFJfBP7Jk7Z1s3RPv9V0QeD7jkoLucvvfVRWjUYuhgEA4pHMWxkdHUIl
LfzPAnEZM/k+NpkUWf+uTYbOtaMqcAE=
=lUcY
-----END PGP SIGNATURE-----

--jv5tpzpajmrvvmyk--

