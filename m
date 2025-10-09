Return-Path: <linux-kernel+bounces-847407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F24BCABED
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 22:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD40B4E225C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 20:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008E52638BF;
	Thu,  9 Oct 2025 20:01:19 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AE125A655;
	Thu,  9 Oct 2025 20:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760040078; cv=none; b=OqMl+sLKslPCWLTHKIZNm19OehM8zHqv4Vz3tGs9cW5CtbXCwabbKS3VzIK1B/ZBVYotgpIyyMnMgnqGh2TyPSxYgAwIq7TVMteYn+Ftr3POr5pw2p8x6qlprC6emmzuRJf9PwcVEtca3ps9BIivDhZMPHhT4IcfgovxMvJTDYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760040078; c=relaxed/simple;
	bh=RUvu35+0YNtAinjMsjdcUAfU4+Xz002c5lWxDAfaSEg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=efIOKOWJCSFlyirqDisqsQvzVZvmn4NUOzIEUbbuq9NCiHfjh/p1UJ8uN2FrWX+pBG88O+s0PIr0cvbQfrR0Y8xQRYVEqbhcahcWu8l64d9Q9Te3or0raXoO2IbIOp1sv727zJBqAgz01DRUs7imr8z9ANFDA/0MsE2zQgVDsDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 48BA746826;
	Thu,  9 Oct 2025 20:01:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 963AD20;
	Thu,  9 Oct 2025 20:01:06 +0000 (UTC)
Message-ID: <cd0a44fcedec36fdfb9540106ce62279613564e3.camel@perches.com>
Subject: Re: [PATCH v2 0/2] checkpatch: add new check PLACEHOLDER_USE
From: Joe Perches <joe@perches.com>
To: Onur =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: apw@canonical.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com, 
	corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org
Date: Thu, 09 Oct 2025 13:01:05 -0700
In-Reply-To: <20250917173725.22547-1-work@onurozkan.dev>
References: <20250917173725.22547-1-work@onurozkan.dev>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: g34q1kzz84rxm8ze4zhn59kki3mmapu5
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 963AD20
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX184dOLiXLyLh3s1X/Pt0yK+BJmlv0WYWg0=
X-HE-Tag: 1760040066-35579
X-HE-Meta: U2FsdGVkX1/zpFW/evcjquidmgjko7O7pqGck5cHdJXp2geKrSEahCYhrjsg32m5YosfPj+1PyshkBXXxTXEiyUxurK4OaQwugsxP9bs+a+TjomIbeZJrJSaGguJeTBZGv9FCcxEhSJnsF3ROa2GaKaOEpuse816sowIwRdBXknRLwRpIGmhzFSSdws7xPvR7ADrpIq70VjsWY4Hgk5pVH3b4DVf/sguNWW4fDtGuJgnY3BuoO+yKbw/BJxANVgP55ItOsM4u5iNRPr5qrwtmtmI06IwYPSkpirCdUsBRf4Pt7RZo3VuBFoK3hCKXms4YA5OxnTZnG9uuqiDQvI8tNBXMGakIKXOzycFW40qSb1uyG3jKeZARlw9EQgy3A4+

On Wed, 2025-09-17 at 20:37 +0300, Onur =D6zkan wrote:
> Changes in v2:
>   - The check is documented in Documentation/dev-tools/checkpatch.rst fil=
e.
>   - Used ERROR instead of WARN on detection.
>=20
> Onur =D6zkan (2):
>   checkpatch: detect unhandled placeholders in cover letters
>   checkpatch: document new check PLACEHOLDER_USE
>=20
>  Documentation/dev-tools/checkpatch.rst | 10 ++++++++++
>  scripts/checkpatch.pl                  |  7 +++++++
>  2 files changed, 17 insertions(+)

Acked-by: Joe Perches <joe@perches.com>

