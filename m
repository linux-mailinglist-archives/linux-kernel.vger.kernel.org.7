Return-Path: <linux-kernel+bounces-870158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5739C0A10E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 01:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E9621AA5AD7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 23:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3102DF71D;
	Sat, 25 Oct 2025 23:24:26 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87FA26ED57
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 23:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761434666; cv=none; b=Jcd6I1/SaDyLO3Aq+Mr4mtdvsv+EyVGRgD3kk0DS22eN/f/ZsMa4bD/I43hzkJAPZeu2TSHZxORhH2zNjkcL3KwVBpvhI14OhQCmNn301yFCaS8zXEZbt2bBwOe2k7WyuZ3WwjldoJ+e2N3uCSiN2KQeAqr7cTb1qI8pao/SMeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761434666; c=relaxed/simple;
	bh=I1RbZPvC2yKDhMIXI7+25mj9WRlo2kh2O+HpP2BU7rM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qkce1Ed3r6/Oq9UW9jkxwyumZdwvSkT3gqWO5BgxngIA0S2lW/blvitfMreENrW3CuFYnYCd2BWQ1632KGfo8qzv6kHz0tsjcrOXAzVFNe64EIV/JpGNOJrQL3bsFYfzxV5LVhJRTKX7xR7ppbbCdKnT03/9FqfLNG3eKymsZNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 33ABEB6A8F;
	Sat, 25 Oct 2025 23:24:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 160682002E;
	Sat, 25 Oct 2025 23:24:15 +0000 (UTC)
Message-ID: <603e564ce2de6a66054760b01fd82d1eb0da9c66.camel@perches.com>
Subject: Re: [PATCH 1/3] checkpatch: add --drx option and drx_print() helper
From: Joe Perches <joe@perches.com>
To: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org
Cc: akpm@linuxfoundation.org, Andy Whitcroft <apw@canonical.com>, Dwaipayan
 Ray	 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Sat, 25 Oct 2025 16:24:13 -0700
In-Reply-To: <20251025211519.1616439-2-jim.cromie@gmail.com>
References: <20251025211519.1616439-1-jim.cromie@gmail.com>
	 <20251025211519.1616439-2-jim.cromie@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 160682002E
X-Stat-Signature: m5d8ccbgn8ix1izde67kcpj9udieaws3
X-Rspamd-Server: rspamout06
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18emd/0gjND3pvY9M6PqvaZZd20LIr+FPo=
X-HE-Tag: 1761434655-849858
X-HE-Meta: U2FsdGVkX1/dyWjYfPeTbvDfoIFa8hC4F/A+fbDj/+ixAdbW4ch9UXav3CkZxlE8qb5MO3vMVGjFCNduDvbEmVgppqC9UwpEW2Hv5Z1GgLOJAVNMKcpjmUncZa3RjF+W7q1Hm21POA+yGRNE/hFl9YgW0LxFBLw/j3QSZ9d7ExDWxcWPh2RUFGOjcVT2l5RkmTMnEKm2XcPmN74eRAs9p8YLZyFDZRhyFBHioue9l6Y9/oysQo4SBBWM575oaSWzzPVKEBhNHNJylLe7DhjFXswOjPGlpciOHq7k25JFH65NDDflm4stI4baN8U/nT7a

On Sat, 2025-10-25 at 15:15 -0600, Jim Cromie wrote:
> checkpatch has ~235 heuristic s/$patt// statements which strip
> code-snippets that are "OK", leaving the remainder for further
> heuristics to apply further "cleanups".
>=20
> Many of these have obvious purpose, but surely some are inscrutable.
> For those cases, add drx_print($reason) helper, which is designed to
> be called from a s/// or s///g statement (in the 'replacement' side),
> to "explain" what it is doing.
>=20
> You can use it to instrument the code to "explain" itself, then
> validate that explanation by experiment and exersize:
>=20
>   s/$patt/drx_print("why")/e;
>   s/$patt/drx_print("whys")/ge;
>=20
> To activate the "debug" output, pass --drx or --drx=3Dwhy to enable all
> (or just matching) cleanup heuristics to validate the "whys".
>=20
> Here it is in action, on a patch which triggered enough noise that I
> wanted this visibility into what it was doing.
>=20
> $ scripts/checkpatch.pl --strict --drx=3Dbuiltins ../linux.git/pt-1
> drx_print: -builtins-
>   >> Matched (`$&`): <__builtin_constant_p(cls>
>   >> Capture 1 (`$1`): <__builtin_constant_p>

I'd prefer you extend the existing --debug KEY=3D[0|1] mechanism.

