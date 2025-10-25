Return-Path: <linux-kernel+bounces-869787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E037C08BD4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 08:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 90F0634F77B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 06:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B4A19E819;
	Sat, 25 Oct 2025 06:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRqzPBq+"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFEB1CAA7B
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 06:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761373039; cv=none; b=nJqDHVaSxNfnqcqDr+L/Dxx3khGLxxE61T2Btrn7zWmasNjEQjAOeUs90IWHhzCCFWoplNy5xXorDqYBPJYqPH7EqBKYLBEHnimFjmVzRRDDT19StBZov6HrGRw/SdnfDLqA/oAzkXsb418B/AayOGPiRVa/GoyajxJFKPhsxd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761373039; c=relaxed/simple;
	bh=cn1oi11LG/pF61ql1VCKF0X0phsVnfYnbM22lp/uDU0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KEimtH1iXyWpnTqpR4cMUFcqOr9u1hl4jute2Zm+k+ieonV3C+q4GKtJCxH9bpVpsSXgKCgeRiPRTMKUrPJH3WFfmd8DAH3nhXJAc9YXzYw/lG9k8oxQnXIh6yGGVGk0zFmK8lj7/xxYZz8Mis1lbbdV3i+fmJZBwC783MaySfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRqzPBq+; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a4176547bfso119618b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 23:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761373037; x=1761977837; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6p7GK3VvKhA8P74byFxrt2YZTTWqdb0ZlXuHY4d+0hM=;
        b=JRqzPBq+QgOktLnq13zp5shoPGgLCx7woOK62GSPQpTXNtW58jLvS2lWsUc87Qn2wO
         kd10em+94SBSSXxpLljambxISaKONWmIqvUlonovmcS95abp9AmY/YKl8v/0Ets0Xg3E
         fGiJnvEVcRjCkCQETTL2/xHsQ2gKU+rfyOg7fCJF+3SikciGYsCp6N97rGRabtU8uH0H
         0fouLrCQRQysWiD0/+6dIdMcZlpDYo2n8KPTL2ojwvqak4mvAhimOj52s07AJsYVDYjL
         2VE9UzCEqmjmUxhyZ7wHwAFrZwxe2hVuMVh0vRh8agR7M/9EJD0qrN+m6o0rsuavuU/o
         4LNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761373037; x=1761977837;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6p7GK3VvKhA8P74byFxrt2YZTTWqdb0ZlXuHY4d+0hM=;
        b=e3fx6CWPpK6HSxmay2zUenXSgVUwR7GAGzof1tn1LkTe0voGpIdGuH93m9TBw87uQr
         lkaIWzt7NSDgeEvANzGWFkdbRn2wOZEn2RxtayuG8H7FvkNvcI2oMcGIQpb2WQagZFgK
         QStMqNbipa5hq/H5mJB5zipL/t8zuIhnlUsQ+CM32E7cDoXcmS72iuuCi39PZsBQSKu+
         00I9ufOumOPW4xJ9JgobuIRjHMSX8UVXduicxKCR8aduamlc+28YVZWjwJ1LCuo94lGr
         0aK23QFYqWegtvmdt6rlF002Ky3FpB/Pm65ZyTcai1jmtOntK/uF7V8lrKtnxAVOyu39
         34gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwypyrhkKC+LkE9f6Dy09kMY6sg7Kepcl5GaldrIUtA2LRgOCl0jcex8A+RZ+WxFE+rSUBGz3T9ipSPZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8crkwboLEcrmrpo7d/qfpqjIZnIEmNE+RVLgBdYuegACUQ1Tq
	dBfwfvRK5yhnKfiuLHlaMcDcJWBBhcDrd0QltOK3KS+GIDNy4TspYqCa
X-Gm-Gg: ASbGncsCK4+NieW0FZ1NPNwfAdlJwaiDV3E7F2aHR+TOpPGDqgapo55VeeHSoSig+XU
	GNwL+rK65WB9lnpVsDIiPlOI6IBabxoNuPLcW38UWzHdjURcDHE5ShnhSDOejGKYjnuVzMEKWGv
	ZlWMTrWvXdLaTvnopqhk+iAF4OLqEdQZqFkGN9EpWRJDZnO2R8fSxwdXkVWarLu2I3mnjIMGb99
	u6xE1JiUfU9SK8SvQKrCH8eakiHD8G2dCwL6spNSF/kxodXukUsOhpBc3Ja863FbDPrBlmbUPuO
	eunw4jyo6Cris0Ywt82ZPVIgT3nlNdIt0ppblEhMpTTX//600gB7jWjBDXw8BU2UrnC0Dl8JID5
	x+7btKeZVvoh/vpJPmYQKDKcZvivhGUQwtzpe/219c0UwtCKdUzAZ4A2OQMX5kCFEIrEohJJ2EW
	TDsmfDVc9SzkxJilVY/jpVOAqg8pUac94LeaYKO+HUmvVytzoyFMrrht0o
X-Google-Smtp-Source: AGHT+IEnx65olDd4wUsKq9Ohdp5aWegEgeLRj2EY+h3wY1HJDJOM27r0YRmfqUrDPBEW/wTGvWKOoQ==
X-Received: by 2002:a05:6a00:2e26:b0:7a2:1b8a:ca22 with SMTP id d2e1a72fcca58-7a28685edf4mr5915593b3a.25.1761373036774;
        Fri, 24 Oct 2025 23:17:16 -0700 (PDT)
Received: from ?IPv6:2401:4900:88f6:d7b0:443:a828:b6ba:688d? ([2401:4900:88f6:d7b0:443:a828:b6ba:688d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414087587sm1158573b3a.58.2025.10.24.23.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 23:17:16 -0700 (PDT)
Message-ID: <14a56a50d5d8803bc822ae99fbe527755323623b.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] add check for pointers with __free attribute
 initialized to NULL
From: ally heev <allyheev@gmail.com>
To: Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Andy Whitcroft <apw@canonical.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 David Hunter <david.hunter.linux@gmail.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Viresh Kumar	 <vireshk@kernel.org>, Nishanth
 Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,  linux-pm
 <linux-pm@vger.kernel.org>, dan.j.williams@intel.com
Date: Sat, 25 Oct 2025 11:47:09 +0530
In-Reply-To: <769268a5035b5a711a375591c25d48d077b46faa.camel@perches.com>
References: 
	<20251024-aheev-checkpatch-uninitialized-free-v2-0-16c0900e8130@gmail.com>
		 <20251024-aheev-checkpatch-uninitialized-free-v2-2-16c0900e8130@gmail.com>
	 <769268a5035b5a711a375591c25d48d077b46faa.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-24 at 11:01 -0700, Joe Perches wrote:
[..]
> > @@ -7728,6 +7728,12 @@ sub process {
> >  			ERROR("UNINITIALIZED_PTR_WITH_FREE",
> >  			      "pointer '$1' with __free attribute should be initialized\n" =
. $herecurr);
> >  		}
> > +
> > +# check for pointers with __free attribute initialized to NULL
> > +		while ($line =3D~ /\*\s*($Ident)\s+$FreeAttribute\s*=3D\s*NULL\b/g) =
{
> > +			WARN("NULL_INITIALIZED_PTR_WITH_FREE",
> > +			      "pointer '$1' with __free attribute should be initialized to =
a non-NULL address\n" . $herecurr);
> > +		}
> >  	}
>=20
> I think this a poor idea as almost all the instances where this
> initialization is done are fine.
>=20
> And there are a lot of them.
>=20
> $ git grep -P '\b__free\b.*=3D\s*NULL\s*;' | wc -l
> 490

Sorry for not checking this earlier. I looked at quite a few of them
none were real issues

>=20
> And what about these uses that depend on struct path members
> .mnt and .dentry being NULL.=20
>=20
> $ git grep -P '\b__free\b.*=3D\s*\{.*\}\s*;'
> fs/configfs/symlink.c:  struct path path __free(path_put) =3D {};
> fs/fhandle.c:   struct path path __free(path_put) =3D {};
> fs/file_attr.c: struct path filepath __free(path_put) =3D {};
> fs/file_attr.c: struct path filepath __free(path_put) =3D {};
> fs/namei.c:     struct path parent_path __free(path_put) =3D {};
> fs/namei.c:     struct path parent_path __free(path_put) =3D {};
> fs/namespace.c: struct path old_path __free(path_put) =3D {};
> fs/namespace.c: struct path path __free(path_put) =3D {};
> fs/namespace.c: struct path old_path __free(path_put) =3D {};
> fs/namespace.c: struct path path __free(path_put) =3D {};
> fs/namespace.c: struct path to_path __free(path_put) =3D {};
> fs/namespace.c: struct path from_path __free(path_put) =3D {};
> fs/namespace.c: struct path new __free(path_put) =3D {};
> fs/namespace.c: struct path old __free(path_put) =3D {};
> fs/namespace.c: struct path root __free(path_put) =3D {};
> fs/namespace.c: struct klistmount kls __free(klistmount_free) =3D {};
> fs/namespace.c: struct path fs_root __free(path_put) =3D {};
> fs/nsfs.c:      struct path path __free(path_put) =3D {};
> fs/nsfs.c:              struct path path __free(path_put) =3D {};
> fs/nsfs.c:      struct path path __free(path_put) =3D {};
> fs/overlayfs/params.c:  struct path layer_path __free(path_put) =3D {};
> fs/overlayfs/params.c:          struct path path __free(path_put) =3D {};
> fs/pidfs.c:     struct path path __free(path_put) =3D {};
> include/linux/path.h: * struct path path __free(path_put) =3D {};
> kernel/acct.c:  struct path internal __free(path_put) =3D {};     // in t=
hat order
> kernel/trace/trace_uprobe.c:    struct path path __free(path_put) =3D {};

These are not valid issues too

