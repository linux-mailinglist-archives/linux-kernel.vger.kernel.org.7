Return-Path: <linux-kernel+bounces-870689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40518C0B74D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 00:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8707A4E7C31
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 23:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F1F301022;
	Sun, 26 Oct 2025 23:40:57 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741811A9FB8
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 23:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761522057; cv=none; b=KqEoRhtrsg4qrUueMmbMAq/PHIsUYwxD8SwK59laKz7ibwuob7vzlBllT2Mzz4bAAWknqxVCeYl9AXnJRobuBEVk6Vp2gY9wuYAt7SYtSxHAFxocEC3dCRV8cN6lAn+mMQIfMCGGIwbuPdSz0XHDYyq/0sKh4lxNaNspzJAmx3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761522057; c=relaxed/simple;
	bh=7JvXdMMlu/bIK1yNqdXOUG/XgtJolZjlv8qOXYkJGqk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l/Uo0jDUkIj2ctuTfuoMNORA7EjezTlLBfwMvorrVEIAVmVwmSm+yIUoxcqN1eLwrUphAHYKEro2R3kS8a/FcfMi015L/5b2kZuehSkFL5bXxZiaZL6jsPFloNvIA8/KF4dOeOnlwMRq2WNoEDqw+8qKq0/PqYhPNy4kmqSOUDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id C4C8812A39D;
	Sun, 26 Oct 2025 23:40:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 8F6E220025;
	Sun, 26 Oct 2025 23:40:45 +0000 (UTC)
Message-ID: <5114af1db16a396b65b798029b83d7b8a2c3aff5.camel@perches.com>
Subject: Re: [PATCH v2 2/2] checkpatch: 3 use-cases for --debug rx=1 option
From: Joe Perches <joe@perches.com>
To: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org
Cc: akpm@linuxfoundation.org, Andy Whitcroft <apw@canonical.com>, Dwaipayan
 Ray	 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Sun, 26 Oct 2025 16:40:44 -0700
In-Reply-To: <20251026202142.1622060-3-jim.cromie@gmail.com>
References: <20251026202142.1622060-1-jim.cromie@gmail.com>
	 <20251026202142.1622060-3-jim.cromie@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: hzx9y7jjjpjyfnq633e9g4jueoqcrri8
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 8F6E220025
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18iHkT0KiXCPa9fBg7nXCZJHChVGsFPB4c=
X-HE-Tag: 1761522045-141570
X-HE-Meta: U2FsdGVkX18n6MudLki0wr0726KIP1pBuQGnFmZ+PxmD83eKRMavedlOB0NZrx3wEn6fpyyXq7NLsIWuiyAYZ6Oj7HuRCVY0pzStYG8sDI3wcxDNtWKEfn19KT1Im+kfimDvtdzP8PRJdPcjDEst9PdrTuSggnuhwKUT/r2o2mRR7UVS0uwEx0ddKk8cHDOoPKI7y0g9t6x3MuqO2WtXCoxync+CtluHYjtH+DAYTi4AH13BiY0pUwvOUF5cT2b1AGsEuDnEZC8engHi1wsdCepn8y73Lq/NIbOpifAN53mbBGHh17isA+q7qC1dwXHxN6bD28OEVETAWVVOj8MaajSwssN/xMpN

On Sun, 2025-10-26 at 14:21 -0600, Jim Cromie wrote:
> Use the drx_print() helper in 3 cases inside code which counts macro
> arg expansions.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -6078,9 +6078,17 @@ sub process {
>  			        next if ($arg =3D~ /\.\.\./);
>  			        next if ($arg =3D~ /^type$/i);
>  				my $tmp_stmt =3D $define_stmt;
> -				$tmp_stmt =3D~ s/\b(__must_be_array|offsetof|sizeof|sizeof_field|__s=
tringify|typeof|__typeof__|__builtin\w+|typecheck\s*\(\s*$Type\s*,|\#+)\s*\=
(*\s*$arg\s*\)*\b//g;
> -				$tmp_stmt =3D~ s/\#+\s*$arg\b//g;
> -				$tmp_stmt =3D~ s/\b$arg\s*\#\#//g;
> +
> +				$tmp_stmt =3D~ s/\#+\s*$arg\b/drx_print("'#|## arg' catenations")/ge=
;
> +				$tmp_stmt =3D~ s/\b$arg\s*\#\#/drx_print("'arg ##' catenations");/ge=
;

stray trailing ; in the replacement ?

> +				$tmp_stmt =3D~ s{
> +					\b(__must_be_array|offsetof|sizeof|sizeof_field|
> +					   __stringify|typeof|__typeof__|__builtin\w+|
> +					   typecheck\s*\(\s*$Type\s*,|\#+)\s*\(*\s*$arg\s*\)*\b }

This might be easier to read using a qr but I'm not sure the
embedded capture groups and their use in drx_print is sensible
as it doesn't seem extensible.

our $stmt_stripper =3D qr{\b(
		__must_be_array |
		offsetof | typeof | __typeof__ |
		sizeof | sizeof_field |
		__builtin\w+
		typecheck\s*\(\s*$Type\s*,|\#+)\s*\(*\s*$arg\s*\)\(*\s*$arg\s*\)*
	=09
> +				{
> +					drx_print("-arg-inspections-");
> +				}xge;
> +
>  				my $use_cnt =3D () =3D $tmp_stmt =3D~ /\b$arg\b/g;
>  				if ($use_cnt > 1) {
>  					CHK("MACRO_ARG_REUSE",

Back with I suggested this a dozen years ago I thought it was overkill.
Maybe it is and the whole test should be offed.

https://lore.kernel.org/lkml/1352198139.16194.21.camel@joe-AO722/

