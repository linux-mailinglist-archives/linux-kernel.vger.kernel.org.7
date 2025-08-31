Return-Path: <linux-kernel+bounces-793556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AD9B3D51B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 22:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EB2417847A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 20:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB5B23C512;
	Sun, 31 Aug 2025 20:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="hQ0QL777"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8BF1BD035;
	Sun, 31 Aug 2025 20:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756671143; cv=none; b=IiJfeHUBMnoDHOJ7IQefAgPvMUBDrIvSoX6/hSl/mVXT3zkGLD7FehRYsDFGpG5qSY+nXcviE/ofOp0qVquXa88BUmT636VNpFLdxGSDcHq8Uar4nzPrytzDdOToDkIvHpENDpsw8Ar35a5KZHHzPot/J/u6nMuHlK/jFcOZc94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756671143; c=relaxed/simple;
	bh=P2avC4DPGz+eM6QafeV2RCQHcJNlw7b/ZrlUdKq+U4E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ifd+K3W0fdPIWWsLRzoPa/X0EA33+1b9YsfGJQ0+beqlJzk73F+qIbxveJQIneH5bTc5gpfo/tfPTIYEOCotKz4a3XNToKkNmWZokn5KjSK0VEh/QzqoAknO62rnhvc97jx6cqaYFmiK54rJzA9rvdkc/fqt5zi8J597JKx4y24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=hQ0QL777; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5980440B03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1756671136; bh=jeNn2yqsZkFs7KvKwIK46ykzytj6cKlzLAe6/krfRos=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hQ0QL777blvzeEno3CoTZVUU6Ee7DIHX9tJzvFR1RXz04L8I3nX7aEMSGhF3T3jk9
	 KG+vJv37GVhjs7wcS+IBFqW54pMjunZNBttfGw+HZRzIB7Exgq52B3P5pDBTc8dqh3
	 NFJ7965aDNXw71y9rubHd7ELxRMbdNEUovruhx3MBCf897LuxrktR84JbxdmX1ndkd
	 h/ILhvTfG5oo9+OjsIQTrgVbeRdlFfDuxFNswYwl/KN2FxfgY30GYnAZ5uUGFe9tsb
	 +4p4Yxb+80IQXQ2Hzx1t5k8X8iDwX418wqfV3xLR+F/4PWd9gdXZaU3S4cNmRtufNt
	 2WiwyRjJKzAew==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 5980440B03;
	Sun, 31 Aug 2025 20:12:16 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux F2FS
 <linux-f2fs-devel@lists.sourceforge.net>, Chao Yu <chao@kernel.org>, Daeho
 Jeong <daehojeong@google.com>, Yuanye Ma <yuanye.ma20@gmail.com>, Yangtao
 Li <frank.li@vivo.com>
Subject: Re: [PATCH 0/6] f2fs: documentation formatting cleanup and
 improvements
In-Reply-To: <aLOPq_zLap9PuMrW@google.com>
References: <20250820043432.22509-1-bagasdotme@gmail.com>
 <87qzwt3glo.fsf@trenco.lwn.net> <aLOPq_zLap9PuMrW@google.com>
Date: Sun, 31 Aug 2025 14:12:15 -0600
Message-ID: <874itn1c9s.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jaegeuk Kim <jaegeuk@kernel.org> writes:

> On 08/29, Jonathan Corbet wrote:
>> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>> 
>> > Hi,
>> >
>> > Here are documentation formatting cleanup for f2fs. This also includes
>> > docs retitle at the end of series ([6/6]) as a bonus.
>> >
>> > This series is based on docs-next tree.
>> >
>> > Enjoy!
>> >
>> > Bagas Sanjaya (6):
>> >   Documentation: f2fs: Separate errors mode subtable
>> >   Documentation: f2fs: Format compression level subtable
>> >   Documentation: f2fs: Span write hint table section rows
>> >   Documentation: f2fs: Wrap snippets in literal code blocks
>> >   Documentation: f2fs: Indent compression_mode option list
>> >   Documentation: f2fs: Reword title
>> >
>> >  Documentation/filesystems/f2fs.rst | 88 +++++++++++++++++-------------
>> >  1 file changed, 50 insertions(+), 38 deletions(-)
>> 
>> Jaegeuk, are you going to pick this up, or would you like me to?
>
> Hi, I applied them in the f2fs tree, if you don't mind.

Not at all - thanks for letting me know!

jon

