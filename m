Return-Path: <linux-kernel+bounces-787524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D35B37778
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471B03A9F75
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BAE1E7C2E;
	Wed, 27 Aug 2025 01:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHPF7qYf"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E94199E89;
	Wed, 27 Aug 2025 01:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756259930; cv=none; b=Cs65+I37KS9/bfDHt+UUypUdTTYH6ZLq1wEFazOxttBSfQ3XyReX2bCujwDXFR5u9vpkdqurpEBkIOE91UP2MRNM1azj4KgoEyQkn983AKDorwueB8Rb0hkMa2cxDzPA6Wk6AZ8YjmEHLRsDbvsckllWLLtgzSTIzgELcNSTs8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756259930; c=relaxed/simple;
	bh=/PHIjzfELyEcjuWJ6n7CUV26b4SYqlNVwYA00Smv+GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTvnSk7Z3R48y0DsYlDB0ACPwrXV/4KnX2nw9eSMyUtVvm1QYQRI4Zg9/ct055Iz6+yv24RPgg4pvDwnp4cpGQZtebbEyiE5K5LYKTgE4aUvYs4mWtV/mv6OTUnPtsOuD+xcTNlIlHwTKGS+2KwuLq8EAy/CvzKQ921xEcO8dAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHPF7qYf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2466443b37fso40617075ad.1;
        Tue, 26 Aug 2025 18:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756259928; x=1756864728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dwAVKmX/I1s2gxmBmbB2NeF4sEUvQzRSn/zd7XkVykY=;
        b=XHPF7qYfvMOrWzp4+9Oqpej1yH96bgLlQ9U01NHDABaQuL8UzcWn11ub4N0qOzAza4
         YvR+amRnXWM0r1QhRpU6CtNkw73oHcOZQ04CAaQS3X69XmHZB9n3mrEM160c0aTv3KXh
         aWOV5SnXtqI1G3oraxDdFVyPw6yjs3f3duUSzsQ+e3kzakwUPXTVcPW56Iwyd6skT9Wi
         LB0w4g/y1gm0MburFZfGAz+ZLFB1SsqAj+SCanVTaWLDSfS6W/k+ytv8HtRn0f5JHEds
         xiI4uRT9lDer9lNHilE4YON+3FSPKlbTc5u3rurnciILQ5vnQuDtuBqlxy5Hc13xBeF/
         gRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756259928; x=1756864728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwAVKmX/I1s2gxmBmbB2NeF4sEUvQzRSn/zd7XkVykY=;
        b=FwY3JNZ8z/lsbmQddlPD+9ofJ0XBE+avMMKSu5RDV5xgHYYpGqUlNihxugQL2zQxnF
         YiSQGRB9RTjnFgKJEs3DpcVnim7ECWTDXUicin+MUYO5ZDlaQccfwWpSl1/sEdAMwQK8
         hfxoKtMlHuhM0oqOMqw7vKvUJSspAiQxv5dJMPsNEw07oPhHQlUj/M4c22HKNg8+FtHR
         VExZdH3Lv9S81ct7R5bOMRHvJE9B4QJ9osnikcQJ8D3aRtykt7Q+XQPi76oSz4MHHZpw
         aLgCIxum7Ddotgp6ixhgJemHaubfM7WjrG/8oKgDanYLVvyEU08uScmL5eXCyAro/uSp
         ujBw==
X-Forwarded-Encrypted: i=1; AJvYcCU6Qorqr28Ei9x5hs+5sZnc+p56ysVBL4thvFEUXUBLdtli8VGpG2aSoLRGQHGRpKkL+a5BncRYi0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRzIzm+S4U8bdVCxLgt0zo8ip1pHut71vhWsZF23nxY4TeRXlV
	iTl6c1+XVH+bI5KfgI10lr6V9bfk2qHvlOT9X/9/f7X7VI++oiAplSur
X-Gm-Gg: ASbGncvBAP+zVTe7L8BW4+WageMxtprKFhSAFfT58NIpsvQQu5vnK6wiTHQUz/VHhC8
	PuCTcGLKCJKDUmZ1sm8BY/EYKODihx66ELT4ns9pxuFT2MH+VNsZkZoBQTU1qsZ7/TQXEloqN5y
	lOVApmfuLwxjbdvpeGMzzyA6WIfY6IBQZRjjGNKijG+FOMYEb/3MbtCxtip4z9Rq1IDbmk8kuuQ
	3EkP+lpIhYSmhCdDgcCjersFs6+EK4M7d4xj0mnlblxCkj362tOy+NNJkcfbwk+SjT1aVAPxT9H
	iCaasN1bd1WJ6DO3aGZg4O1LxuMXgRSZ9+8FJn7qzBjPjdC7xEuPE5gkgI/GMGGi7KX6gheEWat
	3eC+veRsGS15xWWe2tYYtmw==
X-Google-Smtp-Source: AGHT+IEqu4RZC/Mv07+32USt1O0T4CAeeWBTAgLYfe5hG6hvOS8qLArGzHVKAadPNj7IRfcUIr4W9w==
X-Received: by 2002:a17:903:1b6d:b0:246:b1fd:298c with SMTP id d9443c01a7336-246b1fd2fc8mr146952355ad.1.1756259928099;
        Tue, 26 Aug 2025 18:58:48 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7703ffbb605sm11724412b3a.7.2025.08.26.18.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 18:58:47 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id C0A69424BFD0; Wed, 27 Aug 2025 08:58:44 +0700 (WIB)
Date: Wed, 27 Aug 2025 08:58:44 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux GFS2 <gfs2@lists.linux.dev>, Jonathan Corbet <corbet@lwn.net>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	James Morse <james.morse@arm.com>
Subject: Re: [PATCH] Documentation: gfs2: Consolidate GFS2 docs into its own
 subdirectory
Message-ID: <aK5mVOTFZhv53M8s@archie.me>
References: <20250826023913.14888-1-bagasdotme@gmail.com>
 <aK2iTlkp9iA3zESf@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8VyT8roYB2Ttt/DO"
Content-Disposition: inline
In-Reply-To: <aK2iTlkp9iA3zESf@casper.infradead.org>


--8VyT8roYB2Ttt/DO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 01:02:22PM +0100, Matthew Wilcox wrote:
> On Tue, Aug 26, 2025 at 09:39:13AM +0700, Bagas Sanjaya wrote:
> > Documentation for GFS2 is scattered in three docs that are in
> > Documentation/filesystems/ directory. As these docs are standing out as
> > a group, move them into separate gfs2/ subdirectory.
>=20
> If this is to be done (and I'm not sure that it should be), why preserve
> the 'gfs2-' prefix on the file names?  We know the files pertain to
> gfs2, they're now in the gfs2 directory.
>=20

I'm just moving files, though.

Anyway, thanks for the suggestion. I'll apply it in v2.

--=20
An old man doll... just what I always wanted! - Clara

--8VyT8roYB2Ttt/DO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaK5mUAAKCRD2uYlJVVFO
o/uCAP9GnbqUmuPnJizdP3UtvdrYHXV3y0wVhJEKGAO4a+a8dAD/bXtMoOL/d/Gd
22Rv85+RYilLre0239ddCTI+8COycgg=
=7WaC
-----END PGP SIGNATURE-----

--8VyT8roYB2Ttt/DO--

