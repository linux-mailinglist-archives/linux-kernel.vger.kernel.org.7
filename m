Return-Path: <linux-kernel+bounces-749888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA0AB15454
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 22:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5901118A1BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2180424BC09;
	Tue, 29 Jul 2025 20:28:51 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B6E1DDD1
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 20:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753820930; cv=none; b=IBCtFYTYi35S+M/ldzIwv0XEsc6kj1aquCzRyd8bc4AJu2mDsF4sjAlfbudQTrQBz665bOi7AcatGi4IwqM/+ch1OgXKvtWkbLZxaPumKWg5pM+XJYS84/RkG23SqnuQ8+kngPtyKBVDhTR5b4mRMxT4jIixqb3zRkQSKmE2EkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753820930; c=relaxed/simple;
	bh=dSODrkydRElyB5/ET632bybIEaV6fXP2g3aeUgCOyRI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sXvuxt6MbWd896DyNMVex3AfiNaIv24lEWr2C5Z6v0xEZboyvnNNfCDArRi9wSOG6efhpVNUX86unaZM39GDcAeNPCRD/7qU8yMI26xmdFoVhQbRQglogNzSkLnmnwvkQvZPNz6sTTnKXi8Lyle9DcW3hGNT1d8N9Y7zjs0esWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 10FA1111A75;
	Tue, 29 Jul 2025 20:28:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id 32A302000F;
	Tue, 29 Jul 2025 20:28:46 +0000 (UTC)
Message-ID: <afe999de5fecdeabb291dad9da186073bed386b7.camel@perches.com>
Subject: Re: [PATCH v4] checkpatch: warn about novice phrases in commit
 messages
From: Joe Perches <joe@perches.com>
To: Ignacio =?ISO-8859-1?Q?Pe=F1a?= <ignacio.pena87@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Date: Tue, 29 Jul 2025 13:28:45 -0700
In-Reply-To: <20250729140725.130842-1-ignacio.pena87@gmail.com>
References: <ZqCu6xskqgLMQm8K@saruman>
	 <20250729140725.130842-1-ignacio.pena87@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: r7kxk8iyhsw7ry93cnpczw557i6nwo3u
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 32A302000F
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+gCBsPZhSZMYo0XmxG3W0VIdWJxBOhM9k=
X-HE-Tag: 1753820926-167340
X-HE-Meta: U2FsdGVkX190sD7ZEYwMEcWHH28j5l0a249HNW9JFdEyJ68iFdheZ4gUuzj/wDClmU4XCqcqz2yVr1NUYAHZpCvWeokELmW9KuAyCSfMafA+M19ihJDxfqec4d/GgPYy5yXqCYgRCR1mKyuxBdo1C1dKK3tidXb7peYEKZeMxC0UYaiqoyV+QO/lk8ktM/3pFqJeYkdfmsjFc6z+b0soj5tg4heD3bJxlZizOJEL7vGmYFUE6dsz3xSKvfcMuuQVCylFEplKnrhXNzY1AbSOIGJCLkioE99uveZAV+vJRYAaZI13AtGBgSvERF9xOE9JU/MglypxnrA8P0gJhuMwOJraozuNqNZksjYtnA7sUjw949GAnXg2YedZMD6MyxsK9ePQnpuMLjY=

On Tue, 2025-07-29 at 10:07 -0400, Ignacio Pe=F1a wrote:
> Add warnings for common phrases that indicate uncertainty or lack of
> confidence in commit messages.
>=20
> Signed-off-by: Ignacio Pe=F1a <ignacio.pena87@gmail.com>
> ---
>  scripts/checkpatch.pl | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

-ENOCHANGELOG

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3430,6 +3430,24 @@ sub process {
>  			     "Use lore.kernel.org archive links when possible - see https://l=
ore.kernel.org/lists.html\n" . $herecurr);
>  		}
> =20
> +# Check for novice phrases in commit messages
> +		if ($in_commit_log && !$non_utf8_charset) {
> +			my $novice_phrases =3D qr{(?:^|\s)(?i)(
> +				I\s+think|
> +				I\s+believe|
> +				I\s+suppose|
> +				probably|
> +				maybe|
> +				perhaps|
> +				possibly|
> +				hopefully

definite nak.

maybe is used way too often.

Where did you get these word choices?

What happened to the "my first kernel patch" phrases?

And you have not ever answered why !$non_utf8_charset is useful.

> +			)(?:\s|$)}x;
> +			if ($line =3D~ /$novice_phrases/) {

this should be
			if ($line =3D~ /\b$novice_phrases\b/) {

> +				WARN("NOVICE_PHRASE",
> +				     "Avoid uncertainty phrases like '$1' in commit messages\n" . $h=
erecurr);
> +			}
> +		}
> +
>  # Check for added, moved or deleted files
>  		if (!$reported_maintainer_file && !$in_commit_log &&
>  		    ($line =3D~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||


