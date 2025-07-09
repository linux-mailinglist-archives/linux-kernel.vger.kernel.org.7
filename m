Return-Path: <linux-kernel+bounces-723102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA9CAFE2F3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA5C67BC71B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7B227E07C;
	Wed,  9 Jul 2025 08:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtpE+kKF"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12461DE4FF;
	Wed,  9 Jul 2025 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050444; cv=none; b=acOq6Wxpi7FSzrQ7cvrCzNvCEO9aoHfK890SqNYa+cpq9FV1sWyAfRlT4tkOEcQ9Nw+DUBts1mn6mbEm30RwIF5dXapaqzSrf2FpamQL0kf4FRUMaMjrHcJCPxhtWKb9DlXJkiAPhVDL/lCmu3RBqMyWsL4MLx2cJxKklvTeM8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050444; c=relaxed/simple;
	bh=lVmwqwXwoXoRLrgQnhk5kpKYOZmo/Np4dRqsnZuNico=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ch7RspamNvf6dcobj4ZhCb91YpH7EoJ5xvQnfEJeSQmsd33YGl4oP5xHff424yu6zD2StwpIonBUbAgrVLSjYPI4w6Q79IQebTxGJ+6HrobBErSjEAUhLR+uQJwJZIrmPmOAPCw4Dod09Zi4EBz+iPNHNxexjXg4vg9cMfkUWi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtpE+kKF; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b3508961d43so4306750a12.3;
        Wed, 09 Jul 2025 01:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752050442; x=1752655242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lVmwqwXwoXoRLrgQnhk5kpKYOZmo/Np4dRqsnZuNico=;
        b=JtpE+kKFlzlUdOrcCcY4sC1JVI1QiOIXwDN93UegtNukgNV/Uew4eoMW2IH2J7Cuxm
         ldPUDJakAPFOa1nRbZ2IbipRj1RPkVg/iXBa9CPQm/CW5iLoNSCoXapx1/tmwMa7iOnW
         RPpAdcho68cturpAr66K8/SkRSNrRbwwxmhC9yxJPAfyCCAp1zXgd6VfBZaYVfTclZyD
         aTcqxB+VLR80XHWhWVZT8BA5aXfjqyhhkYVgYfNQgHGGbHU69axXqLpFRqt8W9GNZMhH
         j/EBkEk7Rmq3QO5l/kZFR7c6AmcYBdn1KxO7vKdd9IEPNRWsnPf+vp/FFCXues7xs/bB
         DU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752050442; x=1752655242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVmwqwXwoXoRLrgQnhk5kpKYOZmo/Np4dRqsnZuNico=;
        b=GKT28xvYRWOiLGvIhdbeQwEJvTcghreXugSraCIsSso7ScaXj4ppTs0fsduhgSloyc
         NjJLmpJqNzlUO82/G9l6kIVKQZQMidXvIDA88TodH8Q5LKYxnOtR2GkBm67nt3+Ea+T7
         5PZBbpTdkvq9tki1kawod+93R/DuE+nk4R/FlYKiqOzxIZrSsbjqsDTdQyBkbm7qoa5T
         lfkNztjVfgEnl/IOTaYPw0dBVuUYRSFmDr6DUrOANA/Jsz5z/pECSm3Gjd9F9xM/sgMT
         VBkUr/I2uUacUy+WWhlPghC+k3SZoybs61P4SU+qlLVUGTYHPpflZBXTXV+tYq/5AOdT
         RPTw==
X-Forwarded-Encrypted: i=1; AJvYcCVXVz7ArlLLh7zFMVxwEwM7vxlGTRyvVoKUu/dIRJBIZjJXtpsIQ30tkEfUSprDIq2BvFEin7TN4cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVO460kCuY974DfYO8LwkT+RTIURpstUQZh3xuoT32IYR0hXdL
	yHIYiOQkszgFD3BOHFSOUC9UefSoMCkzYEKUZQZP/o3CuZts4Ghhohul
X-Gm-Gg: ASbGnctx6GlAkNcWJdbARbAsJJTxwhLjM2i85ZynNzwpU49YZww+XbQw7/IG0EBi110
	MKT2lWMKD1i0XKkzL+IMyZycz2xxyu8PUKSNyZAYoFZTIZDVRhigQRL3iuB51YHqDnvwytKkS+f
	i+CTGGwEGxbzfTgIcIJoPt7TkSapxhShhVleYMHgUsm9expJScFi1eW2fsedfOkct6unUrIyjHL
	YSSlBATJ9UmNq7N2tCkgcOagvxfs64nW6gzCC5WICTMuR6zUmQeFCSxZ+6sevPVeDChqhpaKN0M
	0tsBizISmESTdy1PCBWSIUd4NmerxBSRw5BwfBsRqvBqQeZP2aRYSQ+MOmCMOw==
X-Google-Smtp-Source: AGHT+IGF2o8G1bwQLiGet81gBmlMfqUC632G56A4Q5MAObcKdNhxT/tUUhEvHqLItldI9q1ue2k3/Q==
X-Received: by 2002:a17:90a:da90:b0:311:c596:5c6f with SMTP id 98e67ed59e1d1-31c2fda079amr3351553a91.17.1752050441904;
        Wed, 09 Jul 2025 01:40:41 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c301a95ffsm1414433a91.40.2025.07.09.01.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 01:40:40 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id CBAAA4101950; Wed, 09 Jul 2025 15:40:36 +0700 (WIB)
Date: Wed, 9 Jul 2025 15:40:36 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Antonino Maniscalco <antomani103@gmail.com>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Raag Jadav <raag.jadav@intel.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] drm/gpuvm: Wrap drm_gpuvm_sm_map_exec_lock() expected
 usage in literal code block
Message-ID: <aG4rBBJE_KEhkAfu@archie.me>
References: <20250709024501.9105-1-bagasdotme@gmail.com>
 <aade485e-0880-4c68-9b37-d8a27dc122e3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wFUsWKicYRt4Gvv7"
Content-Disposition: inline
In-Reply-To: <aade485e-0880-4c68-9b37-d8a27dc122e3@kernel.org>


--wFUsWKicYRt4Gvv7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 09, 2025 at 09:37:36AM +0200, Danilo Krummrich wrote:
> I assume this has to go through the MSM tree?

Of course!

--=20
An old man doll... just what I always wanted! - Clara

--wFUsWKicYRt4Gvv7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaG4rBAAKCRD2uYlJVVFO
o5vdAP4zYQraYcWZ5417LKimSuB/iobFIALeKUn0bIkGLhZxFAD8DstYb43X3+Wr
oHbq2TC0/1xxUZP7Zx51Yb13YIsDlgA=
=oNYA
-----END PGP SIGNATURE-----

--wFUsWKicYRt4Gvv7--

