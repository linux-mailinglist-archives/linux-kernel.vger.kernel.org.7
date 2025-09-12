Return-Path: <linux-kernel+bounces-813709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C04DBB549CE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3058A17C975
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AF2285C8E;
	Fri, 12 Sep 2025 10:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i31HVHOG"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3962E612F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672905; cv=none; b=gSHS1E1H8pmOdpibCehdB0j0cmcSx21+GUflrlIUb+f2e/xFkUt1qE6CKYSLKmCt0ZqrJ0JERYObKO0PHVKKzx74AZG6fqR5KJGJPIhs/RWK7LgzTK8OmSM/7uCrUCEsN+bzxZ3PigP37v0tQSPdeTAPgdiX/7aS8164e+h4g6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672905; c=relaxed/simple;
	bh=EBD8IpI6A0wAsbVRfB4i9rlCjO4G0tJXxd7ni7KvAx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Erg1J0e9ED4bpyOMrslDfjW8RxLbE+41EZPSalw82gpLXtAmmAGmzeCn/bXZgw83hykROpkBNWeNJMcDqLxNnFkdRs9C+EgHoGvp2xYegr7C1lEzwLu69k0km4BDGpBUaS6uAEQq0svcba9UeBY+YFSc7XnNZyNa3ZM4mmjY6TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i31HVHOG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so20644285e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757672902; x=1758277702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JA1IUMCbOH/Rs2R4k6eNlR5l2tk1K0Ele5rCkcSibNU=;
        b=i31HVHOG+qiCsjTxKfAtyKpyk1qeBGSRqDqMwmYqFDBa8ciMMR0or+gMPviXHF81pt
         ZHSNk4CZM9J53PwdbJ1c7TkYTSCl/eQyt2CllOb8KMpWAB8KNy1eOWsrMOETj9x0ZcxH
         3V6DtG1+EWUc7eKbJoEJqFNXbUUYWlDkaLI0MkNCfeKFX6wlMue8W6clzBjPLaJWBQOo
         8cswCJm9MNqfMWP4i4C+FH488NOuBWyj9tiNa4k+SI3T/+JoYYsvIK+7IePor6FFkyqr
         wU4cJUJUBlOYHevTy8p9HsL6QLu8OWvwnEhX5Y0N8gl6vM6/jtuzdNLO7EInFZxkNZge
         opow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757672902; x=1758277702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JA1IUMCbOH/Rs2R4k6eNlR5l2tk1K0Ele5rCkcSibNU=;
        b=NnT6ZVkQnzfbApVkOiw7fYODiD/4ml8HrJxZKoDL7D4g8HSOZ0yalAyvr+J2E2R3Ml
         fQi+Esz/o0PMDbnKD9kDgoKtwdU+s2p2PS7KUwfZ7W4VZ2eLCJU3QmXgTC7SdH07iQBp
         B5MkR+hb79n19H4utSnJRr207SZLmND9gNsGy2C2Q1hh0ctGwk/9twv+qoTOY9smkmiy
         cg9k6yHtoFJxmVjjPzYt/0VzFfHox4Aqn8CPDOboTkSKGl98pFjggZw67GyGQVdc+g4D
         bFsgOCNXfYmMkX+a/ONEP1kfUvtsWRlhC38qZ+yLFCEvygt8kTa9BVv9fHob7TE24hd6
         UZJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXn1Kc7dQC/d+5aNjr0AH9yZ8rfNvm0RmK9FdMdCoju+814IILr9IzG6xadr90xeL9qlB89vJ0X8yE61uA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3umfvC9la13t4pxxr7RPQx2G0bUQi4//Y49+ML3NFyvbt6Pc2
	TWozW/RHDLl2eIY7XUdZTScDFdAWoSkkxjQEdDl+96JW4YHV1oIw7uMU
X-Gm-Gg: ASbGncvlSchigXImOwcXTslUVCbkO0pE0KdR9HDMJDCJaB9bGxZvGZfrDpuc6bLIjoS
	n+xJQVYLebduDSe63d1wAjkIf2u7a8CsIRKBj7ELnlA58GNwzUU5VGuXvzQgby9CAQFziGGvkeV
	TQOtYbmMbh5KHpwJ0ibJTh0H/DqsUXVKYL06nZqgP3xwjybDFFglEdc/rKG1e/4SBcvMHZhiHjc
	Pez45QAgS7jeyv1MRVtCDWFvDaaJk8QhB9UNxxJ0WAcRYQN5hcNzLusHwBYOsFyftPte4L3xOR0
	eA+NievlnYISdqYXNWQsC32Ijw5e0D0UdHIzIQRiQ6+qQTT/iC2iX4b0eaFtnT/8ggSse5QbFW4
	PvG9sMb9EzKrzxfqJtlrPEYjK/dva/rtOLmgbr7yluFO9ZS7fwmCX8UIs/5DYqzohRwktfEZuci
	GM962GHJRKaESMQ7QNRRE=
X-Google-Smtp-Source: AGHT+IF4AEGaMMn/CUIZmhYMMaPgBH8SYmjhY2GIRnf93okgdn9S+OTIILcyErnNpIWu0CDXM/Slfg==
X-Received: by 2002:a05:6000:3109:b0:3e6:116a:8fe1 with SMTP id ffacd0b85a97d-3e765a16066mr2111938f8f.61.1757672902386;
        Fri, 12 Sep 2025 03:28:22 -0700 (PDT)
Received: from orome (p200300e41f1c4d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:4d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607d7b67sm6041450f8f.49.2025.09.12.03.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:28:21 -0700 (PDT)
Date: Fri, 12 Sep 2025 12:28:19 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <treding@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Ion Agorria <ion@agorria.com>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] ARM: tegra: add device-tree for Xiaomi Mi Pad
 (A0101)
Message-ID: <cj5vagef2b6nga7vrfk5ulall3zbnlftekguqn4iydu6ow2zam@ucoqrk2e4pg7>
References: <20250909074958.92704-1-clamor95@gmail.com>
 <20250909074958.92704-3-clamor95@gmail.com>
 <2tmlhaymx73frvv3qv7qvaagzwvh3cepringiyvhsmqrdgfy5i@fvspt74y6nj7>
 <CAPVz0n0WjOaBrn=stpwjhT-fZ-K7_YQHDUnuKUccZaqLJGXJ-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mahnu5no6cnokx6g"
Content-Disposition: inline
In-Reply-To: <CAPVz0n0WjOaBrn=stpwjhT-fZ-K7_YQHDUnuKUccZaqLJGXJ-A@mail.gmail.com>


--mahnu5no6cnokx6g
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 2/2] ARM: tegra: add device-tree for Xiaomi Mi Pad
 (A0101)
MIME-Version: 1.0

On Thu, Sep 11, 2025 at 07:20:51PM +0300, Svyatoslav Ryhel wrote:
> =D1=87=D1=82, 11 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 19:00 Th=
ierry Reding <thierry.reding@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Tue, Sep 09, 2025 at 10:49:58AM +0300, Svyatoslav Ryhel wrote:
> > [...]
> > > diff --git a/arch/arm/boot/dts/nvidia/tegra124-xiaomi-mocha.dts b/arc=
h/arm/boot/dts/nvidia/tegra124-xiaomi-mocha.dts
> > [...]
> > > +     host1x@50000000 {
> > > +             dsia: dsi@54300000 {
> > > +                     status =3D "okay";
> > > +
> > > +                     avdd-dsi-csi-supply =3D <&avdd_dsi_csi>;
> > > +                     nvidia,ganged-mode =3D <&dsib>;
> > > +
> > > +                     panel@0 {
> > > +                             compatible =3D "sharp,lq079l1sx01";
> > > +                             reg =3D <0>;
> >
> > Looks like there are no bindings for this panel and I don't see any
> > patches anywhere that add them. Am I looking in the wrong places?
> >
>=20
> It seems that there are no archive yet with panel patch, this is a
> schema part from patchwork
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/2025090907=
3831.91881-2-clamor95@gmail.com/
>=20
> I would ask you to NOT pick the tree commit yet, I have a few
> improvements for it and would like to send v2. Meanwhile, bindings
> related with this tree should be approved.

Alright, I'll just merge patch 1 for now.

Thierry

--mahnu5no6cnokx6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmjD9cMACgkQ3SOs138+
s6HcYA//fFhnevw+HejFG5AQMygj1lfdsYEaYVqqZpwPo/PmuwghOBAx/0p/8Hpf
LwmLxnw+NL9pPsnMBxWEGLJ2GKKEaFhEhB/gxDc+yBHeFG9filV+Id7pWGqu9sgv
j2J8Rff/m+b66oCYTcgniAoA9H7iX/qINpegc4PZW6Igi/Tcv7A9Az7kVT4ewJqv
IB93bhzn7M1jVjeOvkNHwBcM3D9jv7Z58XWSt6hDGbvltAJmHw3YMZtIg+YeYo/a
Ga76QVmuZw8RpX7qIEUTDojFSEyV7sQSlQ1nli53OhQGQAaEzTh0JH+L/OLN0LUK
X/PjX2PbVkNMt2fPKiHGtclPyo7HVQ/WwLqrTXS41SkZ4hs2BcfV6C3zzjObxSvp
9EQIOojvp88cDO4+ZwhOkhD5FgPl4TYX40XPsQwS9tWfJk+42FQG+Sw9mVTUkdwa
uccs7o7NmSDhPwAfoab653BQ4b6540LIa48R+IKn5n49gvnlCG8NTsGLwyC6LeZZ
doROR9LbaTectrXEzhvCLzS1yxv9Zg6zUwGXndVFfGrmA/0aTuf++hcX6WqQJM4t
chCeOjVu/a4vQl4BCgoO+qUZxzthArITUq61buTMhv8n923TAvC/BkUrvad74ZqV
t4avlQTng2WtWgKMjisM2jjiWUD24eGRSArTSEKfTZ05Yb3R2eg=
=0NYn
-----END PGP SIGNATURE-----

--mahnu5no6cnokx6g--

