Return-Path: <linux-kernel+bounces-823229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516CCB85DA9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30359176FA2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D53B31355A;
	Thu, 18 Sep 2025 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b24e3GRo"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8808530FC2C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210912; cv=none; b=t+QonXGbwhCL6GBV4z9jyS6H/QBGyLv+F+ByycB0tjJOSlCRxworFIxFsVMNdl/Z9ZEq1+7BVTyGvYlm6G4Yprlzp2wiyLqfmQ+0/f+lbTXMQ3K9gpzXBFaVrHjcBbEScVUKcJprQdZlUwEzt+MMzO1foyn3fBhAyK1KvPIm+lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210912; c=relaxed/simple;
	bh=KSXvR4vDyVXeAomhS0D9LW+bHnZ13AdQvIjyN4BTAX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBU2u30p40VAmGsRqgN264lCkfScq4UIyteVLHqUOIagrUHTBZ8+2hn+yxNrRQXhVlYinowHJJpxSpy8FsWSPjPK9TZlKnbXzxOJEFTP1NZBvGi7Mfhtchr5ql5dFkHY42ZbDprucsO8ouFC8R76Mworxg/oEU2NeZdvgYoWVq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b24e3GRo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4619eb182c8so11314675e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758210909; x=1758815709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KSXvR4vDyVXeAomhS0D9LW+bHnZ13AdQvIjyN4BTAX8=;
        b=b24e3GRok2pA8zMHBhQV3KsA5CmBwVxDLsisKI6KcIQcKaA0xcg3aSk5Uh4mNSlWYG
         YcoAdRd3mnvWMn30m2dq0G49M7wBV83ZMdNczKcIvjKvmfkuYCTeI3Tw846l3AVhMrOP
         Ea87rCkLmm753YtORjsobPMfNmdhTzMMLkRfwN+e/ZlKEb8wm0eQenQkncp8iVPE/JIG
         FvZvVJxxyZQEmO4x1LbD+wCWVw41MqZiGxJfdyu+KLqh3uChucGgAJlEKzkTwCQu6Cuz
         b9dfyf45VyW1fIOK/d9nk5G3UuytSt+xHPvSjNYrpMveZUvNhc16cHvpL/I1FSWWwGop
         fYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210909; x=1758815709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSXvR4vDyVXeAomhS0D9LW+bHnZ13AdQvIjyN4BTAX8=;
        b=HTF1nUxxi9sN+TmAAzY9Shd9prl7mqt1S+L8vKrGpzh61viFksqZtheqkYUUKmmDc6
         argY+1lpJhrwGjjKPfoP1T1LxFenEX3C/ppEf8NROAX2YOunfQbRKQPp0fL4q1HlUqs/
         k+Ok4TEqOeJIUfwGdf6xhhiWvU4zzsYAjkH3K40uqrBPV3JBRgm0G8XhYmN8dQ/SSkNJ
         SsPJX/UOf/yhNMZXkojlyNhdxCT0Bd+FTBPo2sbEiSsg5Gw14qzokfxbyMKhJTjOLtqk
         RWEYO//BooHsJd38Ag2SFrB5HcO7AAnjo4u8f0jDWQ5ULyqTbPvGjQld1WLCK94KZkmE
         ElCw==
X-Forwarded-Encrypted: i=1; AJvYcCUl4gSI/Cl7Z0u+LUDBOLVFt4fxrygr8oftS3TQv+fwgSu216Um0OzsGobNd+jvMYROcK7nSy0QuvZ4ZMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7iMEODRXraiAO1FXp4niV0FidRGu+ZPD+dxBkzwR3KuxuSpaq
	FOx26KEQp6gx3zniTq1+ojiK6cGX3J08Ak3Myi5gDXYFXGVQNs8fo7MuoaI4yHQRaTo=
X-Gm-Gg: ASbGnct8ZFIVQfUBLMFrP7qNv5FWkODOpOJ2ZRPSRkQr8JRh4G/dq9HBn/LiMtvSUeF
	/WZuLRtkn6KXUirB0ZrOlCWVDCxMBDpDwap2dtJKsFqLej3sat9w6a4VPYAmB5uk5vsBXiveac7
	zm2EUegnsXMYD3CMP+F++4rrfN+Aey+dIBU3Lb86UvkQeugPX0BTR3AZev6hkxfkhKa6PYj5Bqt
	ZgKB4WlOOBkcpQvgD/MYvp6iEd15+WDmn0XyuG5ugdoF316AwVBtRXZY8C0ZquRH17B9DTKKecP
	FejwprB0JB+68ne+Q19xXKsz1V/52mVM2ZiYajWgF4l3Vb4G/vlX83/sHMUsfVetI0gtEeuJwOH
	9gsclU3NvMQqzgzA2LnXlATQ19bKP+u8iFUlms6aD4krxE98DZtx05wC+h/95tA==
X-Google-Smtp-Source: AGHT+IFzljLpICihOJPoX+88s+koepgYBCOQIaiqWwG2tVuTi04ktcXi7N717RTXmJ5IEmBUjAp+mA==
X-Received: by 2002:a05:600c:1d09:b0:45f:2828:6a64 with SMTP id 5b1f17b1804b1-462072dc8c7mr54100825e9.32.1758210908853;
        Thu, 18 Sep 2025 08:55:08 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46139122a8fsm86696745e9.7.2025.09.18.08.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:55:08 -0700 (PDT)
Date: Thu, 18 Sep 2025 17:55:07 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, 
	Linux cgroups <cgroups@vger.kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3] Documentation: cgroup-v2: Replace manual table of
 contents with contents:: directive
Message-ID: <ul3hrtvui3wuvchludb67wy7kahsroclvppssmeuqrfwieyfv4@vd3gbuuda2xq>
References: <20250918074048.18563-2-bagasdotme@gmail.com>
 <aMwo-IW35bsdc1BM@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6pctydeiqfovq75f"
Content-Disposition: inline
In-Reply-To: <aMwo-IW35bsdc1BM@slm.duckdns.org>


--6pctydeiqfovq75f
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v3] Documentation: cgroup-v2: Replace manual table of
 contents with contents:: directive
MIME-Version: 1.0

On Thu, Sep 18, 2025 at 05:44:56AM -1000, Tejun Heo <tj@kernel.org> wrote:
> I don't think I'm going to apply this. Sure, it can get out of sync but I'd
> rather have TOC which sometimes is a bit out of sync than none at all.

The TOC is in the generated output :-p

I understand you want this "[PATCH v2 4/4] Documentation: cgroup-v2: Sync
manual toctree" [1], which is also fine.
But I'd drop this "[PATCH v2 2/4] Documentation: cgroup-v2: Add section
numbers" [2], because that adds more places for out-of-syncness.

Michal

[1] https://lore.kernel.org/lkml/20250915081942.25077-5-bagasdotme@gmail.com/
[2] https://lore.kernel.org/lkml/20250915081942.25077-3-bagasdotme@gmail.com/


--6pctydeiqfovq75f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaMwrThsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjIfAEAkYzzo5GOlGI4TmYO5uBa
Vpu5ot6Ox9xV4xuLqjgNxnwBAOidGMEpjKWqOOMdVGPgXCi3Yq2k2vWDf6CcVTFs
TVYM
=NAwr
-----END PGP SIGNATURE-----

--6pctydeiqfovq75f--

