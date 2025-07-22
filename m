Return-Path: <linux-kernel+bounces-741354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A685AB0E320
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F9E1C8557E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D625227EFE1;
	Tue, 22 Jul 2025 17:58:19 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBCE27D770
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753207099; cv=none; b=nDofyFywtp8K2PFVGwTbA+M3nl40c1GZUMNZFCd16/wG2k9byo9nwTRglnTeZitgOVaambIrQJaBAVdKpbXcBj8me0AEJf+WbCsIDS5Ecgnqo6y0w2rupATiFzfijAxTkgfADNVoYrUFyynUPtyXH+OvGg0zII5FEYTP6dtfNWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753207099; c=relaxed/simple;
	bh=uxJIMWyCN3b9+SqgmVUmo+o7NkorvnASgb/XRfk8/eU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PwdiXKVT1P0rXgrJ830seNExnu04fXwxA8LvAJPwLMzA9KcFvkrl+QoAnqOK8Tmhld/ZApPknuIMqAI0ZyFNaN6cUiRCz3YDF0A34mNPcNF1hafV+gO7+9s5SDH+5PDsaUnUVYUffAQfZEQp67cHoF+hdFFr/8YVLzouOPnY+lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 839221404AD;
	Tue, 22 Jul 2025 17:58:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 5A46332;
	Tue, 22 Jul 2025 17:58:12 +0000 (UTC)
Message-ID: <51648015c2032c0b6fc9b10c6420cf73c4a93846.camel@perches.com>
Subject: Re: [PATCH 1/3] checkpatch: warn about novice phrases in commit
 messages
From: Joe Perches <joe@perches.com>
To: Ignacio =?ISO-8859-1?Q?Pe=F1a?= <ignacio.pena87@gmail.com>, Andy
 Whitcroft <apw@canonical.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn	
 <lukas.bulwahn@gmail.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>
Date: Tue, 22 Jul 2025 10:58:11 -0700
In-Reply-To: <20250721162437.6691-1-ignacio.pena87@gmail.com>
References: <20250721162437.6691-1-ignacio.pena87@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: q7rjfic4zo6ngjzkakpr6r8zqiksmbkq
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 5A46332
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18465LVRSDvrERDxjVjZVTGExOPQ9/6whA=
X-HE-Tag: 1753207092-801072
X-HE-Meta: U2FsdGVkX1/zfGnatilSj1cUChMeW0epsiMbIeS0g09d2DB/HWMv0EIjsc/H+cyCd9fPeuIuf55kQxZfbbXnDzH4w6GVsslZvFVbx+zq+lxSE2bO9b4wdLYEM5G72SjDxjYzHmzfeYKWCSd8yFANuH1wQx4nNkFsPj2kzJ33pUt48YyTYe5z8pVMsigtRxmp7iozLvdHYJjO1NtjFvu1o65/vOd+RZzk6RatE5zg3OQA3Stjo3n0pCFrZsGO597TBTbzhoaZO3CmadXzMP+j/yFxd1oCokk9WhT9Amck7Lf21C4FT+sYgbkgCaq9vzFL

On Mon, 2025-07-21 at 12:24 -0400, Ignacio Pe=F1a wrote:
> Add detection for common phrases used by newcomers that make patches
> look less professional, such as "please apply" or "please consider".
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3266,6 +3266,26 @@ sub process {
>  			     "A patch subject line should describe the change not the tool th=
at found it\n" . $herecurr);
>  		}
> =20
> +
> +# Check for novice phrases in commit message
> +		if ($in_commit_log && !$non_utf8_charset) {

why !$non_utf8_charset?

> +			my @novice_phrases =3D (
> +				qr/please\s+(apply|merge|consider|review)/i,
> +				qr/hope\s+this\s+helps/i,
> +				qr/my\s+first\s+(patch|contribution)/i,
> +				qr/(newbie|beginner)\s+here/i,
> +				qr/not\s+sure\s+if\s+(this\s+is\s+)?correct/i,
> +				qr/sorry\s+(if|for)/i,
> +			);

No capture groups - use (?:..)
			=09
> +			foreach my $phrase (@novice_phrases) {
> +				if ($line =3D~ /$phrase/) {
> +					WARN("COMMIT_MESSAGE_NOVICE",
> +					     "Avoid apologetic or uncertain language - be direct and profes=
sional\n" . $herecurr);
> +					last;
> +				}
> +			}
> +		}

And this could like use a single search rather than a list like:

			my $novice_phrases =3D qr{(?xi:
				please\s+(?:apply|merge|consider|review) |
				hope\s+this\s+helps |
				my\s+first\s+(?:patch|contribution) |
				(?:newbie|beginner)\s+here |
				not\s+sure\s+if\s+(?:this\s+is\s+)?correct |
				sorry\s+(?:if|for)
			)};

			if ($line =3D~ /\b$novice_phrase\b/) {
				WARN("COMMIT_MESSAGE_NOVICE",
				     "Avoid apologetic or uncertain language - be direct\n" . $herecurr=
);
			}

IMO professional is unnecessary.

