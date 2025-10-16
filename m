Return-Path: <linux-kernel+bounces-855777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 119C6BE246C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83AC319C3288
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E9A3081CF;
	Thu, 16 Oct 2025 09:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYP5srU3"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008B83254AD
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605313; cv=none; b=a5DIbGIoaWgSvtoSosvKD9ieYCNOUN6X66n9k0S+Uw9kPRj33i6LlxP6ozjG1Eg7xtyJM5Czn4urmDq74sWDEVW5lrIHWO23ZP8woI206uqKY5c236CmIL5gu/EyrLLhy1Oylgi8QtmtnpuAczf7r4NB3IyWX4d1VFfQN3l8UdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605313; c=relaxed/simple;
	bh=suc4JnIRIUGOcWs/9qR0Bix6Z/KdKrVm+w6n80ouM2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3QFL5/sech71B8rQedVEfsWXSRSTCqptoK0fNZI/KC1DAdXNrV9u4/EiHsC14FWsZ9VNvpxxwCtMl9/vGeukEE04nhWRrBA6dumNpPWUbtgnLg0v66VuwNgvaFu2gryqPfVR+QI/e9R8OGwJHLw5YBBf9IPnM2dGrsNVSsWymo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYP5srU3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27eed7bdfeeso6181995ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 02:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760605311; x=1761210111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=suc4JnIRIUGOcWs/9qR0Bix6Z/KdKrVm+w6n80ouM2w=;
        b=LYP5srU36HSTMU0+jbS3BCNJM0Cay+HD5d70VSyE34c31C4gZS9kkkyPF6C/Dh0Ahs
         aPXMxUlCe+HyJ0150QrTSztoGfrJ9lKgOnXco1S/kk2Twa2pYV+sF60MSxSQbGcn2cg1
         hHaqG28WBKpcl6PdlOfZq38I4VWqCUSQ8OraTRIoX8vUHj5cJE4hj7Nj54nt4uTN1V0C
         Yx5BNa3pFSLxjNf5Fk4I89tKOukhg5iyo41ypWxFIRBpELO9M1Y7OZfzUBi8A1g8zEUv
         46rlyXz3Hrz41qQTGldrsPJF6xtFDzycWMriO4ARZabr7ZqLKAmPLOTxcfBg+uDWp7CB
         EcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760605311; x=1761210111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suc4JnIRIUGOcWs/9qR0Bix6Z/KdKrVm+w6n80ouM2w=;
        b=PZfD1e4kk7XntLtAadPMysAQSTxxrxao4vvtDEiPOJMgd6+s2UYCyvEjA5UmEGsLX+
         tVlE21VIBYvWlivVUPsXEF19zwihsTuFkj8xI40hZN5B8ExdRpOH2kpONGPL3Bp4ufZu
         wJ/BaXKQKDw0bbBzWjfWcjweBeBAj3SBQYuaw4aXNSIfjZ5aMlXBDkoDbsIIJ9ZztutY
         XC+RGSJTBBk3zknB7SyjNCLH4CTL0I+pi1WejsUbtr8Q3ILAV4d1qELmWwXOnmpISkwH
         s+Dsc4p+kRtK45PxRrmf9ssoSJhIU3JLp9+ilGRJ42e3TOenMHphJ74EtOdyhgorKrC5
         +jaw==
X-Gm-Message-State: AOJu0YzSmfgAMs/IN2vF2eSildOQwbs+g3wBC81DlIb5vEXNMZgKTx7L
	tp149y8ZlPSAtpPub/MS8RvwngqPVP6DO5zgd0JWm/Hgcfmq/HqWy0mO
X-Gm-Gg: ASbGncsNJVfoUs4Z2qlkD7Oh/vawRxHxVxgVRYAGPbZ1Q/Zo+6Dlb3cNL9h2b8aq6QT
	7c2BMZ7jdR8kfs/voXWsqoQuoyyUkeJaCi6QZvevNq/vuAUISaj08bfZN0b/NjQMW3M/lB5Asea
	sJYLjdnBUP5Vbi422qNby3jTnX+ioKpNf4idDJ5khEs0i9YXWEQx+e3O2QeiHdvWHhiRq1ANX6n
	jKjz54kPZxmnykIRjQc3mgmaDHrABv14NS9zzu4I3nCAk2MbL/hmbh8/Q+ydiayzTwd7bC0Cman
	N7sI1Z8Mj+bfzxMVWUfYsxI+X28snZRuDdweMlgHc0U/fLnKf11qZb5l4kouk8ND4tYQISSryN4
	kqo+ibjek866p/DSEk8LqB+jXIRf3SydhCwr/AHQ+lnmWxZVJYR5xWI3rKNsoLvFgnpiL8PmLie
	MqmtudhYbf8cQ3lA==
X-Google-Smtp-Source: AGHT+IE57WvRWVQwP15WqnNytPnJ0vJwjIIRthPOsa4cpEi8X8CD2FPyQJMr+7uqN7uOBtFrHDlVOw==
X-Received: by 2002:a17:903:1a23:b0:271:9b0e:54c7 with SMTP id d9443c01a7336-29091af3a9cmr42613085ad.11.1760605310973;
        Thu, 16 Oct 2025 02:01:50 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bb66403f4sm1073355a91.23.2025.10.16.02.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 02:01:49 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 098DA40C0938; Thu, 16 Oct 2025 16:01:46 +0700 (WIB)
Date: Thu, 16 Oct 2025 16:01:46 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
Subject: Re: [PATCH net] net: rmnet: Fix checksum offload header v5 and
 aggregation packet formatting
Message-ID: <aPC0et6rtTOKyDR6@archie.me>
References: <20251015092540.32282-2-bagasdotme@gmail.com>
 <aO_MefPIlQQrCU3j@horms.kernel.org>
 <aPA1BzY88pULdWJ9@archie.me>
 <aPCo2f3lybfRJvP0@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V/bGbS2sUY816rHU"
Content-Disposition: inline
In-Reply-To: <aPCo2f3lybfRJvP0@horms.kernel.org>


--V/bGbS2sUY816rHU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 09:12:09AM +0100, Simon Horman wrote:
> On Thu, Oct 16, 2025 at 06:57:59AM +0700, Bagas Sanjaya wrote:
>=20
> ...
>=20
> > I think that can go on separate net-next patch.
>=20
> Yes, sure.
>=20
> Would you like to send that patch or should I?

I'll do it myself.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--V/bGbS2sUY816rHU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaPC0dgAKCRD2uYlJVVFO
o1RbAQDBHNO/O//8dreUmgf0Lc9dgz9gsgk+/PRYBouO4ont9AEAlEQdl9VwuHJJ
7cOjWsWj/n4O6weq7V/0N67jnElupwU=
=JFh8
-----END PGP SIGNATURE-----

--V/bGbS2sUY816rHU--

