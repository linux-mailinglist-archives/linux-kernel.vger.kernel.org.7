Return-Path: <linux-kernel+bounces-856515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA26BBE45E5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9660E540ABE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDE634F46B;
	Thu, 16 Oct 2025 15:54:50 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBC51C84B2
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630089; cv=none; b=LWQk8J3UkyPV4YlLnxCa5lOVWm3/xsZRcGFJYwz4QJJPqQXjYsKH4GhUtelkr8eqYth4FLhkraQSsKs3lzCAeeT3X1ghVVmTxX1Dq7qfUxAxDpi7f6/hc9sk/VbJYtPhKL8eGUtwgW5E2KDd9OM5olbmeAXhlFv9y7AhjMKFIxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630089; c=relaxed/simple;
	bh=jEfnnajliNZ0uOLCjVtzCNaIQBHgNZ0s8h4ipXYK9Xg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FliXdYUcGfp4ES9BeB4O7XooYF+RHCTahHOTsIf9dVUpVkBT1Ay03nbfoj2/hHOBOV46oxY0ufNtS+MDYrgGIhOmIv8BgELToM2VrJV5yx4I9+upAzfQ+mqwS7/U5dT2jouiZsxLDQ1QIAaNbPQjUZ+UIIl+Y2iTAAQwlryAjfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 9540A160251;
	Thu, 16 Oct 2025 15:54:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 0A88620024;
	Thu, 16 Oct 2025 15:54:39 +0000 (UTC)
Message-ID: <1b3a9a196ddf4127e5148e33d3df7f70ae77a080.camel@perches.com>
Subject: Re: [RFC PATCH 2/2] checkpatch: cosmetic-style tweak
From: Joe Perches <joe@perches.com>
To: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org
Date: Thu, 16 Oct 2025 08:54:37 -0700
In-Reply-To: <20251015175137.2178263-3-jim.cromie@gmail.com>
References: <20251015175137.2178263-1-jim.cromie@gmail.com>
	 <20251015175137.2178263-3-jim.cromie@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: rh6rsbz7insyp7dignb7jngq6za517ar
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 0A88620024
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18pKaZvPUxeapWhkWUCC8Rhfew2mb7vZvM=
X-HE-Tag: 1760630079-795467
X-HE-Meta: U2FsdGVkX1/Q55V6+TYwNOtXJpY1Q6ClC/Mg8jxwwNaZZeTdUDJt1k09GAEdANq4Pzz+j9R8+/Bx+eStTJaD5sRNJAcTxRbBuN4calN/bIgZBMxHksjDu7u+BNI5X135bXjgWkg1z8wx/fH/pdwQKIG7tw0zmwOAMCrIU7DcuNE7Ej26HlbPFwWJ9dtcDX6Jds7znJ2q6BvYmtNgrZ82qPojTRjsz6NOYIAHhDcX/KLGlZcJOS+jUz+/gBtAon0KDv5T4u9ncpSirgJG4zvGejIDy7CaobFnaWhQwUYpilH/b1Yu+XGu8/LhYGArmTuI

On Wed, 2025-10-15 at 11:51 -0600, Jim Cromie wrote:
> no functional change, slightly narrower on-screen, maybe clearer ?
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -4019,11 +4019,13 @@ sub process {
>  				if ($newindent ne $goodtabindent &&
>  				    $newindent ne $goodspaceindent) {
> =20
> -					if (CHK("PARENTHESIS_ALIGNMENT",
> -						"Alignment should match open parenthesis\n" . $hereprev) &&
> -					    $fix && $line =3D~ /^\+/) {
> +					CHK("PARENTHESIS_ALIGNMENT",
> +					    "Alignment should match open parenthesis\n" . $hereprev)
> +					and do {
> +					    if ($fix && $line =3D~ /^\+/) {
>  						$fixed[$fixlinenr] =3D~
>  						    s/^\+[ \t]*/\+$goodtabindent/;
> +					    }

nack.

"and do" is not used anywhere by checkpatch
and I don't want to introduce it.

