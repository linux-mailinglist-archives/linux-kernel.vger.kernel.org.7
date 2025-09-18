Return-Path: <linux-kernel+bounces-799355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D632B42A71
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959D87C1D9B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8792F2D3723;
	Wed,  3 Sep 2025 20:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fqwGohOU"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD532D0618
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756929826; cv=none; b=sHgyMBHf8PvkP7hlvTxL9XtfgTjw41bbdGqPOLLt1SQC6dZg8KLYlViGJnHUmPA5s5vlJIJOswcaA3yGIA6yuNeLMm19fSQ02Ohu/v+79lRrUbBf0RKTVC4iHCc2X6knE/1KKHFGONZL84nxJ1xQ/HTRExbhAnu8WfqHkpSIlW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756929826; c=relaxed/simple;
	bh=LEw0rUqvztDs6fWEAKN1HbztMCvJ4JbkrVUUKE8Df6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PL1DdBlgDooSf22r9krslpDBf8xslKXVzmlgrhnzA/emyeLbD7LUt1kOGdsw3ciDPdvgMsiesTEmr64Qr+sL6fu/XuA1Y47o++ijxhX9b/EC1hJYzyzPcZ2wByikU3hvbUpHqfvexouyQY0iBsVvVx97XsX90j1zyQEmWDVPcL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fqwGohOU; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so228559f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 13:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756929821; x=1757534621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LEw0rUqvztDs6fWEAKN1HbztMCvJ4JbkrVUUKE8Df6U=;
        b=fqwGohOU84TjA6olsUXAftCxqWOTBOh0Yqt9GPOuaNzdJYdBN0gWl484RocwLMO0j/
         8p3Y+okGamzxjZw+1EU7kXlC/up61QFJV/fhoGIS/qHl1kurky6BwnQEjbsf1DzFtOTV
         zz90y4gkxVCcSfOPLFmqYM2iBgZ+beZPHvqz0r7YFFldtrmq40+qhcCGt2i9NEsLxYM0
         uE75WOzTCWRynUJ3yjXrRa1rWtzSNkWpPTlW0s5qHHCvmQDM1Fa0JcDoqo0JPPAe4qub
         /a6VwYT+oWA1Bb5sc60J4L4f1gnVkHGyFqitzsyqfwSQi0LpLqQH1DMfTNKkGVA6vHVB
         e30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756929821; x=1757534621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEw0rUqvztDs6fWEAKN1HbztMCvJ4JbkrVUUKE8Df6U=;
        b=dO5IzJAOZX35kA2hwp0tqp+DtxEsnwP2ThRVD28plNnCKtsg0IoiMrkX+S/gMhjibe
         OLHwPt03vJTnyXq4+pGfn44VjEAZerJb4Qq0nOwy1plB6zaeqG71cm7Z5OYSUXEwfPYr
         /VQdi696+N+3rqq66cOQ/QmJCWOXk9zYP3bQ0xITm1YohGzXe0wbahXA0Tmo0d9heiaR
         PNv1xg093WgavGjV61f9kkakW1Ym0gROHVpIRgwontLhxplzZSau7SC/X8D5mpwGRn3L
         GPJEPtRDyg3qxY0i1/H1nlecUMstjiMkVFRmrq+JN5k490dOqMkVbYSWOA3KhcItlGGn
         fF7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkas4RFVtllKBVGTAsqJ4Mfp7LYBtTYBndco0ASAX16nGlNtK6j6sIdy3KdwSM/WUGWJdqS9nB/bYSRJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNFeMcVT1TsW52lF2+nJJpAHdK7xM7K1WzM6UoMn+0ksf5KpY0
	7VtoZyuj0N4DzcTONytCcvBsY1z/9WA4N1rSQXDoTerxIyYSJYOEFCLO8G05gOh8neE=
X-Gm-Gg: ASbGncvu61n5XP2UZfDV4rk2/GY7yytdsKILhixWgGKXAGeKWWqYcF6oNveObPu5nIt
	YnSVJwa1ny6gmmjb47X6KeUjbZkDGusif5rTHFEz3lS3l9nXBDc+h+zH/B71OORKxPM0reh4oWI
	jHeCeMPQUN+vo8MTz5xG8SuE/Oo0OLsjajDDzYfKFyfYGvEpH0+ba5R3WFQ0yP6+wSoW8EONbYx
	8s+3pPs+hqXxIdnvx0jCQ2GCwv0CPcVQQM0maAWTC/00E046yGrJ8cSAhm19kRpxP7ldYBInbKP
	nndS7U2uqg4D6t7CkeVkkcQRZ7z/GHe3LfUePJOYs1UNHeaVbr4yrCYQrKtMfTuj7I2XOJKy5X3
	UpmEYmLymaUX3MDHJ8HmgZcsT5/HAZX2YhGRCx9XsJPI=
X-Google-Smtp-Source: AGHT+IGg+JstV09+BBhCR+jpyW8+OPMUmGLvbFtUU8chxe8j6dOKXLS9Tpc0uZSo5i8tFiJJFc2zhA==
X-Received: by 2002:a5d:588a:0:b0:3df:f7d1:f8ae with SMTP id ffacd0b85a97d-3dff7d1faf1mr1259216f8f.4.1756929821348;
        Wed, 03 Sep 2025 13:03:41 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf270fbd01sm25235180f8f.13.2025.09.03.13.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 13:03:41 -0700 (PDT)
Date: Wed, 3 Sep 2025 22:03:39 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: Yi Tao <escape@linux.alibaba.com>, hannes@cmpxchg.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: replace global percpu_rwsem with
 signal_struct->group_rwsem when writing cgroup.procs/threads
Message-ID: <rgjlqyeqcgi43crx4mqpwi7tqxqgy7bkmjbpv7t6eiqodreydm@6pag34zcnekp>
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
 <aLhykIPSGV1k_OG0@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ezugp5sztup6n22u"
Content-Disposition: inline
In-Reply-To: <aLhykIPSGV1k_OG0@slm.duckdns.org>


--ezugp5sztup6n22u
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] cgroup: replace global percpu_rwsem with
 signal_struct->group_rwsem when writing cgroup.procs/threads
MIME-Version: 1.0

On Wed, Sep 03, 2025 at 06:53:36AM -1000, Tejun Heo <tj@kernel.org> wrote:
> If you use CLONE_INTO_CGROUP, cgroup migration doesn't just become cold. It
> disappears completely and CLONE_INTO_CGROUP doesn't need any global locks
> from cgroup side.

CLONE_INTO_CGROUP uses cgroup_mutex and threadgroup rwsem like regular
migration, no? Its effect is atomicity wrt clone.
Or, Tejum, what do you mean that it disappears? (I think we cannot give
up cgroup_mutex as it ensures synchronization of possible parent's
migration.)

Michal

--ezugp5sztup6n22u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaLifERsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AgXGgEA/QhZPlQI4Z+oxARZ/+pk
w+grIHs60GbHyuYkeC5OC20A/1j+eeXMuRgwkj/f1FEMguK4al7BSvI9U7WrpBWg
zIoA
=77fs
-----END PGP SIGNATURE-----

--ezugp5sztup6n22u--

