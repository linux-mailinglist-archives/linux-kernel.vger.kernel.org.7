Return-Path: <linux-kernel+bounces-620875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB38A9D0C4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 20:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA204E2290
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 18:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B4B219E8D;
	Fri, 25 Apr 2025 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="DtEiDlB+";
	dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="VPlwYm6m";
	dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="OKMDd0Wr"
Received: from e2i427.smtp2go.com (e2i427.smtp2go.com [103.2.141.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08EB21767A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745606988; cv=none; b=JyAfbFYZNdnpieNkBbBHDCvcM8YpfxNdSJzTtEKOS2sR3Enea1u/fLIUhwaeNHB1f7TXIgJOhf9G6Mub9u1Pr9TclXYFGABu4kbySBG3V23kwXhtLQocN4kNBJjotxteSNzAkm9Gh9t5+We1iRnNJ+HrecvSyGnAE1pCVfnHQ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745606988; c=relaxed/simple;
	bh=0ia0+nAnI/nsJasJHb5V2/gXM9qZLGD5ziz3qvpGdgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dn0Kh4P32SwuATsZmGatUlOJImEPt7OC4/rQpWhyfYmGcWGyW29v0/ZyOLKcqwFo3IryTKflGcafYfR0iFengPSyUre/PoXPmRWXAeG+YVBwzS2M1HE/lPriEt1pTFfIOei6XATKhLgTFz7UO8i3Ud7x7ndAopVnNGH1AcjmD34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=em1174286.fjasle.eu; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=DtEiDlB+ reason="unknown key version"; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=VPlwYm6m; dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=OKMDd0Wr; arc=none smtp.client-ip=103.2.141.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174286.fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=mp6320.a1-4.dyn; x=1745607879; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=owWeXA2qFbSxDa+WbGesCQaKVfTlr2DxYaRhX4/qnBw=; b=DtEiDlB+BfN9iPY4Zll8gv5iwQ
	kvLiy4SCBFTvVtAHylbLRQttuUOZwWblj3WAvgyjauJft/PqKkr0TO7z2HvfKXEk2wDh5i1aZ228E
	CF7Om4mwJNzz/wfS40s/0Vbd+V3TLAiBqIJb/vBCUckfnI4T0Ajmu1i0sA6LfrywLuyqniPXwDKdj
	DNBon+5dtPWcs9PUkDNSE61TrmmWpNcXSmsWBjlc8vz0jcsiicfkNdgGcRPam345HrueEiBXbZlDy
	r4fDe2p87V6mn8UfvloawMkUXc1lS2Ss1elJHjZObaNISH59VEcnzhLq0osobs8meiZqJrKex+V4u
	EFHQCJaQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjasle.eu;
 i=@fjasle.eu; q=dns/txt; s=s1174286; t=1745606979; h=from : subject :
 to : message-id : date;
 bh=owWeXA2qFbSxDa+WbGesCQaKVfTlr2DxYaRhX4/qnBw=;
 b=VPlwYm6mxv/SmkX2DI/ES3mjJIzTwVFIoZ6XS3C4iYMvBItLLQRyQ9vTxkfVgqbSuw1m3
 Sh3BQ8EmFja/2+USJ8bC2frYzjldxDUSVrik7NRgEkHlTMGJXQ9YVLQOOvcl/fNJM+MeO7O
 /sGqL19bcPPGjKnArjgJrpZKYcsGfEK4sgKN90zjbnRqHM41UwLV6ICRvgSQelbCTUfd4AV
 tQgfthEfsKSF80tgHrkVcBgTklMSuxoFpxPkRtU8bfj8Iw3QDW/azHXdnAk+uXibzZL5No7
 rWfmNlz6zs9DLMa8W/Y5cLFt4Gjt8YLDUHIM/7SM5TQW/sUdaIiKoP/k6VXg==
Received: from [10.172.233.58] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1u8O4V-TRk3EO-H4; Fri, 25 Apr 2025 18:46:48 +0000
Received: from [10.85.249.164] (helo=leknes.fjasle.eu)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1u8O4U-FnQW0hQ0D58-lO44; Fri, 25 Apr 2025 18:46:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
 t=1745606802; bh=0ia0+nAnI/nsJasJHb5V2/gXM9qZLGD5ziz3qvpGdgU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OKMDd0WrcBwM6g/L2ydRl++BzlqOyGND91Q+5n+Aa5UgL0vJpqZn49aozb/Xay0sA
 w74dEmdiMz3xybwg2bqnIOrHyzhXUQAa5YwBI6q5j97tQgBe5Yecjp+F97ndaWrunp
 BwHDDOTQ3EBRsd5R0TJ09Y3VzdNKZuJHQYZ6Hx18=
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
 id 17F0A49A5F; Fri, 25 Apr 2025 20:46:41 +0200 (CEST)
Date: Fri, 25 Apr 2025 20:46:41 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 David Airlie <airlied@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 3/4] scripts/kernel-doc.py: don't create *.pyc files
Message-ID: <aAvYkchT7RISfxsX@fjasle.eu>
References: <cover.1745453655.git.mchehab+huawei@kernel.org>
 <158b962ed7cd104f7bbfe69f499ec1cc378864db.1745453655.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158b962ed7cd104f7bbfe69f499ec1cc378864db.1745453655.git.mchehab+huawei@kernel.org>
X-Smtpcorp-Track: sEbsgQNiyBwJ.LOnxSXHovj8L.0duztQKtfUA
Feedback-ID: 1174286m:1174286a9YXZ7r:1174286ss-2np7oAv
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

On Thu, Apr 24, 2025 at 08:16:23AM +0800 Mauro Carvalho Chehab wrote:
> As reported by Andy, kernel-doc.py is creating a __pycache__
> directory at build time.
> 
> Disable creation of __pycache__ for the libraries used by
> kernel-doc.py, when excecuted via the build system or via
> scripts/find-unused-docs.sh.
> 
> Reported-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Closes: https://lore.kernel.org/linux-doc/Z_zYXAJcTD-c3xTe@black.fi.intel.com/
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpu/drm/Makefile      | 2 +-
>  drivers/gpu/drm/i915/Makefile | 2 +-
>  include/drm/Makefile          | 2 +-
>  scripts/Makefile.build        | 2 +-
>  scripts/find-unused-docs.sh   | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index ed54a546bbe2..d21d0cd2c752 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -236,7 +236,7 @@ always-$(CONFIG_DRM_HEADER_TEST) += \
>  quiet_cmd_hdrtest = HDRTEST $(patsubst %.hdrtest,%.h,$@)
>        cmd_hdrtest = \
>  		$(CC) $(c_flags) -fsyntax-only -x c /dev/null -include $< -include $<; \
> -		$(srctree)/scripts/kernel-doc -none $(if $(CONFIG_WERROR)$(CONFIG_DRM_WERROR),-Werror) $<; \
> +		 PYTHONDONTWRITEBYTECODE=1 $(KERNELDOC) -none $(if $(CONFIG_WERROR)$(CONFIG_DRM_WERROR),-Werror) $<; \

Did someone check if we could add

  sys.dont_write_bytecode = True

to the script itself instead of cluttering PYTHONDONTWRITEBYTECODE
everywhere [1]?

Kind regards,
Nicolas


[1]: https://docs.python.org/3/library/sys.html#sys.dont_write_bytecode

