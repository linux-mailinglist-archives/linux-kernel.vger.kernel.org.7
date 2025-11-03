Return-Path: <linux-kernel+bounces-882549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B50C2AB51
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 065794EF169
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471D42E8B73;
	Mon,  3 Nov 2025 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2HkE+tx"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135D92E88AB
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762161566; cv=none; b=b0G4MDsWrWcu54oIQsAeYQFulB0HsG9YxyGuZZMNCPLRcGxO0e78LBY4zRVkwTMajhDW2XN5FV0I1NP8Kx28AMDxXOvd8I8PKqSBaE9hoMIoZTnh4j2i1oBt80CZgNyzrn3sOzqA9f7jiuJ+fIQXgWv9dJDWKyWk+LqAOPiBskA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762161566; c=relaxed/simple;
	bh=64WyXbZBGRcOcQoVJNm15w+ojDOMFdwYnePw0UWBpkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvZSFU2tEDl5TLaPcQ0gD5FRKZhaDZOa9sIjr1B/dclPdt0EOSlH0CcJNIC9g3RIXOVtY9Z80iB8IqMph8L5v5wMx5gzxDv84lpaEKngc4twxMz6BiLtbwCkBLHT/m8Am58YNvIlMG9YevkkD0g+pabz7eEI7wXQd9NIgCGYidM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2HkE+tx; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-640b9c7eab9so1353720a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 01:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762161563; x=1762766363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UpnhjL6BlD7mlBTw7qWADXf7LUA4gVzRlp5FlU4tTw0=;
        b=W2HkE+txKgOWjMxbSMD2HxaD9QSklnWoP4iOIA7bHrlDjG2Z6VsxFY0zzDrLl8JSz5
         FW1PoOC+h2lLcjXgaqF6uvFUD3+VqIrcQRiyk/nQ1ibT/C7JsvLXOme93C8gwjGEvSru
         XEHjpphH7h5/wdxcasaxbiZOoK/3gRQ+MHpEMTtnFaEL3wBoOdyL047yAeYWkc9mq1PT
         boHgqitGMxnGYtA8IpUyj2ZZ1zCEQ6fxSV/FamvUmTMq5K8icjYCjJ3EzXct0dcyMy9G
         u/QYNWBXNmtAlnRh4ttJifVlwJhPWecYGNiFqmu9Tlp/PDZ6pKCp/mMgGHDRERjjKb9t
         2n7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762161563; x=1762766363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpnhjL6BlD7mlBTw7qWADXf7LUA4gVzRlp5FlU4tTw0=;
        b=ejht7XKZFrXetw6/0OZ8ml/8v0kKa2N9SwFpf9dkdMZzL1hoXXyIzgW9Bcl4kJrr6J
         SLN3IFJztuZJebZiJr3vTR8LNB5B/DpmHJvOLhcTOVSUmPcE5KJYhKLIld73vdSm8K4l
         hzDjqzRJ5/oPphzAZAXRNBfIJgKLndtEi30YbO+y+W28VlJ1HbIkIiz9D5eUi6ZoX9bl
         cIC+9OVPmqg9dVB/RX1DcVpep2YFenZ+9A7EauTaIK1377+owXX5e9mJ7loNUHrLHiXd
         DeWwRPNjhp5n8E5AKSCvOOyF/YgtcZaQicyaAGQlB4YMKS0envlAjoNXO/KjciNIqT14
         +rng==
X-Forwarded-Encrypted: i=1; AJvYcCVu6TAyoRuXmNupA3suFs/0r6CR7N0cEl7u4oa8WjkQKLu0sMLaXvjV1run0VOtU4I4bI2LZ0TuC6Uc6I0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsByoV4mBeMDegt8X04kA6sj4cVE1n563YCf8DqlRvEYXhotP2
	Mz03fM8JP8TyTKngvIwko85KKgOQvHszgXfycPiTiHqg8jlUeSzndDkp
X-Gm-Gg: ASbGncsQQRKRNxyA8HP29P9pcse6bIAELUof0f0ShM0wexdxvF4XzfAexJ3TkpcWoFG
	JudMTiZ5vvWSLOTDnqQW8KGAncMaQi5C3XS0jVdnLc7d6F3WBn7GGtwOOrqE4wclJkKIygQHEuc
	KOPlFnfdXtNsUvjDwpyPStE6jWIAbW9m2b77DJN3C0odxKyc0q1qAg9dlLHMHL8LUy8CU6vk5EP
	MH8AYW2mbekDyNBg6o48CgVyDYNDFQi+pZ1JxL8xz8AUMxV3Wf+YUfCI+amljp02I0aQUooAPg/
	BWEdq3MQWgoY62cxSeQV+4fm3kjcnteB/FWFtsP9v3MrEJezPN3IQhfTF6RFoFPrDy8ettW/2bw
	rt0Iuz80GTLeaqAm9qd3bzowx9GWVL9h+Pfo0HDcWHF8F91Crr2qyHf6sOBmfhMtCu23Evy1xZj
	8P
X-Google-Smtp-Source: AGHT+IGTDVhFKCiXTzjjSWvc/4QVd/+rs6wcNLKUEar6MkbyabgQICHVWUtg7P1teeT4t38DkqkZiA==
X-Received: by 2002:a17:906:9fc8:b0:b6d:5ef8:4bf1 with SMTP id a640c23a62f3a-b707017a5b7mr1195881666b.19.1762161563116;
        Mon, 03 Nov 2025 01:19:23 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70bedcec19sm292220466b.7.2025.11.03.01.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 01:19:22 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 077AB420BA55; Mon, 03 Nov 2025 16:19:16 +0700 (WIB)
Date: Mon, 3 Nov 2025 16:19:11 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Accelerators <linux-accelerators@lists.ozlabs.org>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: uacce: Add explicit title
Message-ID: <aQhzj8PXuZ_zB59Q@archie.me>
References: <20251103025950.23159-1-bagasdotme@gmail.com>
 <e95704fd-68fa-4093-835c-ca220a9c3f5d@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vShbojS9UlSxKJs9"
Content-Disposition: inline
In-Reply-To: <e95704fd-68fa-4093-835c-ca220a9c3f5d@infradead.org>


--vShbojS9UlSxKJs9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 02, 2025 at 08:58:32PM -0800, Randy Dunlap wrote:
> > -Introduction of Uacce
> > ----------------------
> > +Uacce (Unified/User-space-acess-intended Accelerator Framework)
>=20
>                              access ?

Oops, that's my oversight. I'll correct it in v2.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--vShbojS9UlSxKJs9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQhzfwAKCRD2uYlJVVFO
o8ZzAQCHxerKfSip7s5lgPkyBTJSz5cb3DRiCat9GUPIyBO9eQEAtBXlIdZh9t0R
9j05JGLCtupdKx1f5aPG9jiInm50bgg=
=jXaG
-----END PGP SIGNATURE-----

--vShbojS9UlSxKJs9--

