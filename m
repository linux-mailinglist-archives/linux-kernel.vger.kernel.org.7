Return-Path: <linux-kernel+bounces-720225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C00E8AFB8C7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C87918815AF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F24022D79F;
	Mon,  7 Jul 2025 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hFrg47bn"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652AE2248A8
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906319; cv=none; b=ea+rfmPTYfY8mH3+kGkvXPmWMRZDP9LVyWrYY+oMwaD30DBkL0l6p2B4rDIT9aecRvUveW23TAEu1ih/1GzOGRMLp2xhbsa6F+uc60gtT0j0FXa+E7r3jD+cm3eJ7CLRlUuA8sHIMU2hcMTXL+MyU3IzbgxTuthSbLDOMT19ME4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906319; c=relaxed/simple;
	bh=S3amwlujUkc5UJJ8aquZiBQnf83DeXQQ7Cd8Fx38bII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyPMtBqwZJtJ7NvpCA3kUIQG7DgKB9G68kj/xKo3fyIh9hBlh4R61ClEtnzqSgHmc9RAdLJ8eX6pNwJeZSW5ysonOWiMN4stkEjk4Lfo6g0euHIgP/CmoUkU2Ebc9wKHbwJrYAwAX9vEtjqlOji1J6hO40D0EAuYabGfpePGifM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hFrg47bn; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso26542105e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 09:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751906316; x=1752511116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S3amwlujUkc5UJJ8aquZiBQnf83DeXQQ7Cd8Fx38bII=;
        b=hFrg47bn3oGSaJ8TYTi7uFYP/TLLKVuEJD9wlrnmatFoEpq66zXTXHMy31OkBU8Nz3
         CkS+80t+iBMsXee3jg+xAyaix7dwDiczlWc8GvrLSBegL7UnPYEDq2WNvNaBWcA+PgOe
         3Vh5cgke8csovGL4d3wG1/dgxywxJhNy+l2kCiZMHJis6FMEYW6mK1nBddAMt5ST6pkl
         nOXbMau0aKgrWNvdOP1HFOu0SGdo8q2n2OH56EqrYDBn/aD5attPtjK0AkL1vuo+YPOB
         Gs1NN5urCK9MD2n+iOwlsbWv/7CFS2Kh/eN9cRmR9negd8fe0hTKV8es9kQa9PkVTAd1
         jQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751906316; x=1752511116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3amwlujUkc5UJJ8aquZiBQnf83DeXQQ7Cd8Fx38bII=;
        b=FJhG+lu56n6x9lAVlmiofz4a/5uPWLALzHvRiMDxko8ewWDERwqdqNMWv4s2pKA3Mh
         o42ojDg/n8VxTo9oCKqptHb/SeX5X5ErjAv7ajVGPhZ2T4pfsIWlmxIH6IkSUDbvGICo
         1+RKRoUgX6ZUEsuli1CMDejehPFVlwka//EwmAmC8BD7Tk0waBLltwwotxetEkNmAdGI
         7WqBh3s6aeIFWpsOxh8JWl395ngl2D5oXFi+j6Q22CuMCCKWT8hlGVveR1m3mqymn6hE
         92J+7X3t+gCJTeFJC/RcgW+1T6x57uvGR79mk0NmtYHCVOP5hEqJTA9IQQM/9gKRGN29
         cdfg==
X-Forwarded-Encrypted: i=1; AJvYcCWRvBM5JCVVQJvV+6691eKOpeYsXOC8+MWqJzTi9CxhRkJLzBP+EsG7bK4hEqVhkYR482+XDD8w9gIHkfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyKkRmx4vv/93fjQzl2/HX8wFErbB5u16s1bUwYK176Xc1XLfr
	Cw9prO+0blKaEzIYX2LraawKwgOWjlskPScy/chy7rWe9qF/BqeZtEA98uHpAsknSoM=
X-Gm-Gg: ASbGnctHschmggd3+ht3w6RBnXK9YvSCObQwGNneCtO61sajvMJRm4c+ovB87+R4mZ1
	GPkZ49WeD378LYT0KLhZ8iZiq4oRI2+Kbko+4CVXuOBxCaOfsQ8vW5uZMen9kIWSxvn0odEu7ea
	PWUAbpME5rgsYoBVqZip1WofDHWRGQcEmKeq6ul6zaMAn4kalsVpJepVL4t0dFlyzqFqr0J4vua
	STY0WHLIqN606Tq4oMa3aaBQjuJ3AphTCJaJ9bwSX9I1gXQNmKURYCNr+vdmmLy49mdu7YJ4wh5
	JmSnqUIfwDVCu+iW6/Jvl3A1dmamyK47aQ0bFSM3ukY89nBgxMNJwq8lzv0hJEDh
X-Google-Smtp-Source: AGHT+IEcytjspScMaqVQ9Um6yyQbzDnCUR35ZFequhb17ooZKv5F3UDEUBaebbJ6Kjo7xHpVLJe9MA==
X-Received: by 2002:a05:600c:530c:b0:450:d367:c385 with SMTP id 5b1f17b1804b1-454cccb93afmr3367165e9.16.1751906315548;
        Mon, 07 Jul 2025 09:38:35 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a997ae2esm145978095e9.9.2025.07.07.09.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 09:38:35 -0700 (PDT)
Date: Mon, 7 Jul 2025 18:38:33 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: peterz@infradead.org, rafael@kernel.org, pavel@kernel.org, 
	timvp@google.com, tj@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com
Subject: Re: [PATCH next] sched,freezer: prevent tasks from escaping being
 frozen
Message-ID: <3omgn6ualvnncessgeuc27nmrqmn7ufjvuqfy7v3ppc6irp5xg@unvxbtff3qor>
References: <20250703133427.3301899-1-chenridong@huaweicloud.com>
 <n23vsu6y6cjf2vwdbfcjl2mj7venvpzpblncoa7adn3q5r4lph@qsfa3deqtamc>
 <f4c4f465-72b9-4682-99e6-c249ecab8572@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pedi25sm2ripaoax"
Content-Disposition: inline
In-Reply-To: <f4c4f465-72b9-4682-99e6-c249ecab8572@huaweicloud.com>


--pedi25sm2ripaoax
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH next] sched,freezer: prevent tasks from escaping being
 frozen
MIME-Version: 1.0

On Fri, Jul 04, 2025 at 11:02:52AM +0800, Chen Ridong <chenridong@huaweicloud.com> wrote:
> Regarding your question: Did you mean that the task was frozen, received
> another signal to wake up, but should have remained frozen instead of
> entering the running state?

My response was a knee-jerk after seeing the move inside the loop.
Since the task is in __refrigerator(), it would've been already frozen,
so the 2nd (and more) checks should be OK and it wouldn't escape
freezing despite the concurrent reader.

A task in __refrigerator() shouldn't be woken up by a signal, no? So
your original conservative fix might have been sufficient afterall.
(A conservative fix is what I'd strive for here, given it's the legacy
cgroup freezer.)

Thanks,
Michal

--pedi25sm2ripaoax
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaGv4BwAKCRB+PQLnlNv4
CN48AP9CGbMaWlet0JJRWDJPP8tZt7TWUthxoNxXutxy8cUFdgD/Rtja2l4GZrb/
19ugZNDMwDQO+gArFD3bC+aIChoBogg=
=5Duw
-----END PGP SIGNATURE-----

--pedi25sm2ripaoax--

