Return-Path: <linux-kernel+bounces-761693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CDEB1FD6E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 03:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301AE3B928E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 01:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70921925BC;
	Mon, 11 Aug 2025 01:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bw28DsOf"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64E4C147
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 01:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754874286; cv=none; b=QBug9PEP/0/7javIomJx+ij8yGE92/wpc4N7p1p/lCHS+tXz5octiIcbQ9nAAB2b3yhtalmAl3ehRndTEABOijd0wLkD4UP6DCuge1xhT7AQQDH4Tvtbj4hG086MMkQU/ZanInmeDQKGFsh8RdtqfzqgCArc1eOLZc8jt3qSzv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754874286; c=relaxed/simple;
	bh=B6oyv/X37LPDXw0LmafAsn/FNUhBjWdT4tDlq1eNqp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NA9fqhuSQw+a1vnjRlhPtJcgLKG9Lvjf2XZXL19rHQvAGqIKr97FWQz6fOdOVrIoVGp33wnpS4LPmi7s2Z6IX4D30w4JPAU+DVYggPx5qBTETEgoMeBVUNnh5KY9Is8aWSEUWiTsWLNwahGQ3KbwHK5DxOMefT9Gi4TtxZHLipo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bw28DsOf; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7682560a2f2so3797937b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 18:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754874284; x=1755479084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jRN1Wbruw1yhIqIXNefQXV7Pb6BqC3Ov7h+E7zrZSyE=;
        b=bw28DsOfVD4rv0wCccd+nnOB8JuQZ3VBCK2dDxEJTJnxNhintZXD1CzkmYYyISQCxL
         NjCDkCK6R49Wk7k2XkhwlW9xqQGLtPYi228m7l1E3w4ql3zECsejOfnglBgYRS0VnKBw
         sOtziACdP1An+2uM4zW9SG54zyrJzI7wonqyut12lKLqEaMVVfAK6yqDpjPv+6cWNoM+
         FonlFdkvZtu/cvG2ESgrjU7L0H5YQUdIMz0PBv/7fuDEd3TMMhG71UbnpDQC+HYscFHp
         fOCgvTQRRRZlPNYnxdo7gY3J/XoMa/hUR5Rnng1mOrV3k1Ehu6TiRops0EIQPeILak2X
         wyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754874284; x=1755479084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRN1Wbruw1yhIqIXNefQXV7Pb6BqC3Ov7h+E7zrZSyE=;
        b=fmIlGgUVZdZZ8xgI+hu7wahzZzmKhIAXelKC6+9Dh3acoyV2TJlI8Vsw3NTMXBJdVn
         nHUe3GyIkoyt11Rl15Nvknv36qaf105OY+qXVh39bHBjVZvp/mcgTWx3tDC5ozONxj3A
         LAjxk6JnXIfjMBqQvh5AfBGd/E+4qOg7KfHUymloa+R9n/3IIOGAUIppHh8qtoyA0mLn
         FUdHP3CgjIkQd92RPQgQ3VlbSf8bx7B9OfeTIN2i+vaqwgKJyJWX/bEci68SFJ72uwgO
         clyL3xp6DVnXHvhXbdAjgAi5SkL4YZRgWxsagBRTt2b3Qwv0mLu38LTTTEZDyn7nuLLx
         SWyA==
X-Forwarded-Encrypted: i=1; AJvYcCUnK8ovJCmjvTZuhinP0lNeQBNRbpH0eBc1XejaQufxBp7iy/9W5yPk8W7CIIsX9jfsVvuc/R8rbaeZ5fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCFxYxnZBogBZ1VnuUYx8Ju7jboQmqJDjL0hZWQre25H1r4pkG
	veDRyaOcFy5lB47Q2DimnfSB9e70HSwznChO6oiYhWf/jgi4ItA9zmNBHVeiLdET
X-Gm-Gg: ASbGnctPZNA7sleE7XTSugcE8ESimwx8aMkppWGsZV3FJ+nke3HwGUN03EOAyTJBK0a
	uR2FUrlENKLDKVP71VdmyTD40XEMveMv37JC/E4zxwITpamH+8aDM06BUOZF3q1/w140OdsEfYt
	kUBlO7LFtZOxjRmjG3LL7FC/CgR5kf5e3ZWaZBG6jwxWJtxBu1cpeqPQQ+OmhjP4H2zSPJj1v4+
	sVseAfBCpfGQ7siCOzR8dVNVm1NiGGPYCR0oeZFkAqGfH8ZpoZTTgvNi/++A+XrxcgKnrpVKNIa
	YJVv53joChy5ii1/K+Sbdxho6JmnCDn5zvbA1f3tMTn/+vyyadRZjFOrFwTLuCJD+rGjjXJz3ix
	0zANUHCv2N3rmtWJB0G0KzQ==
X-Google-Smtp-Source: AGHT+IGRwhALPKGKe6wbfvqJkaWd/T5yglTToXt6dfb6zZqHe7Rs6Z/+KgDHz3gRHxs1wzfOOTUg+A==
X-Received: by 2002:a05:6a20:748c:b0:240:10d2:adf5 with SMTP id adf61e73a8af0-2405551e54emr17612097637.2.1754874283855;
        Sun, 10 Aug 2025 18:04:43 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f911sm25427918b3a.47.2025.08.10.18.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 18:04:42 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 034D7424D92F; Mon, 11 Aug 2025 08:04:39 +0700 (WIB)
Date: Mon, 11 Aug 2025 08:04:39 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Javier Garcia <rampxxxx@gmail.com>, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, dakr@kernel.org, robin.clark@oss.qualcomm.com,
	antomani103@gmail.com, dmitry.baryshkov@oss.qualcomm.com,
	me@brighamcampbell.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm: Add directive to format code in comment
Message-ID: <aJlBp1MN7fnJmcTu@archie.me>
References: <DBYS3FAEVMHC.178SXO45NIBI8@kernel.org>
 <20250810150706.305040-1-rampxxxx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="77Vx7DeEfmVtV4G6"
Content-Disposition: inline
In-Reply-To: <20250810150706.305040-1-rampxxxx@gmail.com>


--77Vx7DeEfmVtV4G6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 10, 2025 at 05:07:06PM +0200, Javier Garcia wrote:
>   * The expected usage is:
>   *
> + * .. code-block:: c
> + *
>   *    vm_bind {
>   *        struct drm_exec exec;
>   *

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--77Vx7DeEfmVtV4G6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaJlBogAKCRD2uYlJVVFO
o4TwAP9dMPv5ZR8cLm7KANxcXrKp5M9kQdju+JhOFbbGOXIh2AD/bkXhxWzQUBs2
xMjEAvKlmpmjETOjOs5ZO9KNxhahnQE=
=Pxl4
-----END PGP SIGNATURE-----

--77Vx7DeEfmVtV4G6--

