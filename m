Return-Path: <linux-kernel+bounces-741796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 907CBB0E90B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 05:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8304A189ECE1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 03:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1E823BD1D;
	Wed, 23 Jul 2025 03:26:41 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABF1F9E8
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753241201; cv=none; b=cyU+2SpJlPrlGXd8cex5ukfHEqK0USY+cDcnTLxUmNX4mXlhwEiwU2nj6u3iEMg6O5vUBX+qm+wdp8l0c2D1Ke/N2+JeGgGw47vjO3zTu5JQHfhfPmWoiEBy4LqBDaStMnBjlYXjxN4YiYKIGnAJBOr2b06QMGDDCPnRJ3ngylQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753241201; c=relaxed/simple;
	bh=U6ONHhOzfLX8SWqkmjPIpZtAQaDc4DnwPqYBOiweT7k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WWT0ckbPhC4zOf9TjpkrhvnRzi90M8BPccS8FUE3AxI9nUBoi1Kgc5sgM8XOxs3GT7iqrq+8p94xqOeXCS91aIZmJ42eFkdolgYWiyIXBpix6pSYbi9o6P8Ms3jiZuRpf0D5xU5reIZMvIuJ2i8FTsmIguEp+pYBJo9nZMqzg2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 86F7F80570;
	Wed, 23 Jul 2025 03:26:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 790CD2002B;
	Wed, 23 Jul 2025 03:26:36 +0000 (UTC)
Message-ID: <51bece321fb6cda098e642ebd82ce1d43452e7da.camel@perches.com>
Subject: Re: [PATCH v2 1/2] checkpatch: warn about novice phrases in commit
 messages
From: Joe Perches <joe@perches.com>
To: Ignacio =?ISO-8859-1?Q?Pe=F1a?= <ignacio.pena87@gmail.com>, Andy
 Whitcroft <apw@canonical.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn
	 <lukas.bulwahn@gmail.com>, linux-kernel@vger.kernel.org
Date: Tue, 22 Jul 2025 20:26:35 -0700
In-Reply-To: <20250723030257.66560-1-ignacio.pena87@gmail.com>
References: <20250721162437.6691-1-ignacio.pena87@gmail.com>
	 <20250723030257.66560-1-ignacio.pena87@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: n5saaakjkfhtc8nyrp4xzefoubaibgbt
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 790CD2002B
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19viOR0xrr4CuxmgSDX/ZjhM7X/vwpts4g=
X-HE-Tag: 1753241196-176659
X-HE-Meta: U2FsdGVkX1/xrZ2N55xW8ZTZgj89K3alhcYjYKD47S3SA/ufBpMIzB4FPJBc70TfdcRQTkeLC8L2V9nd+sQY51vQgDBgs/bZnxCA7HwqUdbA8lr4n1UkZHjKJqXFuJRYZDdOk4x/PGGAvTyjg0BLunJarJ/hZBad4JZ6p40rZj1UI20V3+T/4zMAekafDtD6xWP8+FI73QrDlwkNFgquCrHY2/QNzjyW5vvEqXYY2PirYXzGZ1Z8UA4a9eYnaDN4D6rW09obY8E29nYPTw7aOXCeUsoD7psX+4L5eicNcne4sSdWTPsMrFbXbogOeqws

On Tue, 2025-07-22 at 23:02 -0400, Ignacio Pe=F1a wrote:
> Add detection for common phrases that make patches appear less
> confident. A single regex efficiently matches multiple patterns:
> - 'please apply/merge/consider/review'
> - 'hope this helps'
> - 'my first patch/contribution'
> - 'newbie/beginner here'
> - 'not sure if (this is) correct'
> - 'sorry if/for'
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3266,6 +3266,15 @@ sub process {
>  			     "A patch subject line should describe the change not the tool th=
at found it\n" . $herecurr);
>  		}
> =20
> +
> +# Check for novice phrases in commit message
> +		if ($in_commit_log && !$non_utf8_charset) {
> +			# Single regex with all phrases, using non-capturing groups as Joe su=
ggested

The comment referencing a suggetion should be removed.

> +			if ($line =3D~ /\b(?:please\s+(?:apply|merge|consider|review)|hope\s+=
this\s+helps|my\s+first\s+(?:patch|contribution)|(?:newbie|beginner)\s+here=
|not\s+sure\s+if\s+(?:this\s+is\s+)?correct|sorry\s+(?:if|for))\b/i) {

I think this is unreadable.
The qr{(...)} was and might be a tad faster as it could be precompiled.


