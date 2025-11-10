Return-Path: <linux-kernel+bounces-894344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D08C49CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A913B09A8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A295E3019D8;
	Mon, 10 Nov 2025 23:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPN4Sai3"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58F92E62BE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762817971; cv=none; b=um/v4mUDaKLrh0wEYo1aJrNEANt7VPDPDqP9zriIgSHyx8Ml1Ehkd7cT+XRkUIF8ITBnbq95LXBq7SIJx95ua/9w3IFZ2uLbvXVnhXOhNjFwaf5YhAobu4tn0te6zUg6qcohUKrkAXk6MLLv3YfZP9PG+u8c03fP2OPpYKqUbjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762817971; c=relaxed/simple;
	bh=1cCEzFjzFyynAjNG1FFpcR8zgbzlE7XPHiymBHl+NSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhXvME9g6kq5t+LDQDG67kFrAngBdtUJs7H1KZThLARQLV7Ax3O5pOj/G43LTtx3XEzbdb/jeX0S/XJTHlzHEpthk4Qagwmtbzja8cukT1AbtpRxtKG61FJOivXhVl8+/ol6oby/12SVc5p4RcCpUWh+53w0fO8QON3i4c6r3ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPN4Sai3; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3418ad69672so2411995a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762817969; x=1763422769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1cCEzFjzFyynAjNG1FFpcR8zgbzlE7XPHiymBHl+NSg=;
        b=OPN4Sai3Vd//m/qP3LSL5aIWMF/Oj7ZKNf41fVeidX+FH6BiyE7U22ug52jcnImDO1
         Oflm8p3VbkU+YtbWWFB/DGMS80m5B6ieRhcihomDguGxx4O/PJvTqe1AIeuRtda5bJig
         WYBYbe4VIVaNAr1lr2uhlibsjdrWqLktagHOk1bPJ4Hrp1iR6HFWEziLuOioDFTm39zY
         yReSqXyt9NmUH6Eqtdppfc2i+z6/aol4DTrsKgI200typa5Nz081fmng1D0SBbTLRZPR
         34J3Ym9MntMXTZjLFzjAxA70m4UKaO7/wpRpEX1FxQTkGqCIWvP+EG5oHelA2T0K6z2X
         6YoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762817969; x=1763422769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cCEzFjzFyynAjNG1FFpcR8zgbzlE7XPHiymBHl+NSg=;
        b=XENTsuR6hToKWX2oq15Q77sMqa7gSyMplsAIw4Sv0Z+hAdP+xOHRu6LOrRwt+ycWnc
         C95o4aE2g9I07uTGDsPYPZ0C8JOAcyhbZG5tLB6A2aShqC7lXvADSIl6uHOhWiYbKMKl
         w98BoeuQFojnJ2+xAE9Kqh0pfM8pWHX1AUaasLkmfmfDM8GQbcB/kMvLByEEmMxhBxwj
         E5wJGSMTuB4A0Zt+qRC6X9cqV8D+sTylfcCxswaUcOEO1THiucLBVBP1XWpS9bCaNJr8
         GfqNYOJsPna6iB+colVp42/lz13sCyNrv7BCSDEtPYp+C3yLhSNoBqKbNlciXrCU8qN+
         0Ahg==
X-Gm-Message-State: AOJu0YzFwyWox2HfOecB9bPSPotEv/7Ttp40PY63BoozWphgzgBqovng
	92NXZU/oMEf9jhSbkpBV/ldiOPaB2w1sRWEhZNGwA3GSyL8A7Lr0jcC3
X-Gm-Gg: ASbGncuwVlz7eGOa1yRWMpcbvmZTF15PrmJOX100fksCDvkviCfWggDYJAPh5Zbqo76
	4ThHMYR8tY+4GSNObdKEZwLxnPMfsH/YztF5h9N+QZZpaULZa17BtflTlfxq1JS21L/XBuJc5TN
	ql89SJe71HnLaaHHtFc60RtSCrEp8Dh1XPrswuURJHHKZvE513kepXbTLpgYBSY2SV05dOVC7tH
	7dVKMANLCH12iu9PiSE8icFCd95S5SMxxdIdbLBkqJe7fOjVbBmznbuyMWquCr6iRBOHH6in9q8
	mRAlUU/+RQPh97h5tkc77+hGWBEJE3La1N3X8YQTXiZGPyog+frQcB42iAHRFKkBqLtcc05Hfoy
	4M7zihGHCqw99+4jOsN0p+asEdHSmxfPLIR+/bd0jpClvuQUJwTVkyCVR6QldXSipByZnKmkxDc
	G+tbOBnQraP3c=
X-Google-Smtp-Source: AGHT+IGNoUDFbEycsFFzEVxa73D1puHH1tGo3xImIbeJfxgr+6wQcg9RSQmi7aGMv0B/b6rZU75/ww==
X-Received: by 2002:a17:90b:180e:b0:33b:b020:5968 with SMTP id 98e67ed59e1d1-3436cb8de8dmr12568294a91.21.1762817968931;
        Mon, 10 Nov 2025 15:39:28 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba90307193fsm13641074a12.38.2025.11.10.15.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 15:39:27 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 1A7E541D950E; Tue, 11 Nov 2025 06:39:25 +0700 (WIB)
Date: Tue, 11 Nov 2025 06:39:25 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH net-next v3 0/9] xfrm docs update
Message-ID: <aRJ3rVhjky-YmoEj@archie.me>
References: <20251103015029.17018-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aTusp3mqYER4Xr41"
Content-Disposition: inline
In-Reply-To: <20251103015029.17018-2-bagasdotme@gmail.com>


--aTusp3mqYER4Xr41
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 03, 2025 at 08:50:21AM +0700, Bagas Sanjaya wrote:
> Hi,
>=20
> Here are xfrm documentation patches. Patches [1-7/9] are formatting polis=
hing;
> [8/9] groups the docs and [9/9] adds MAINTAINERS entries for them.

netdev maintainers: Would you like to merge this series or not?

--=20
An old man doll... just what I always wanted! - Clara

--aTusp3mqYER4Xr41
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaRJ3rAAKCRD2uYlJVVFO
o5l2AP9QdLeK5UwYeR12qSi/P8HWRDJPVuEZJ/D/TUwwWhp5ZwEA5GOBAq3sdTDK
qdxwxx2kZ6EszBRgO0Q1LlJEWpmjZgI=
=emxr
-----END PGP SIGNATURE-----

--aTusp3mqYER4Xr41--

