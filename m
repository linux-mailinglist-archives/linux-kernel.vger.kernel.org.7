Return-Path: <linux-kernel+bounces-770763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A02B27EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D28213A8CB0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D251B2FCC07;
	Fri, 15 Aug 2025 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YfPOM09X"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F104C22576C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755254901; cv=none; b=ajcio82cvcOqf4Vi//GZ9e44QFQ2KWlgA1aYtN0aZZkU041ZSIneLQDzv9jCQJCJ3rncU46jByhi1KP8tk7GUlknvrdOApVL5VioqHYdjqdX9lRSkj7/l8KaNirhk6xqFDbnopwe+AaT1r06XqFwhkM2TD6XZATADNT1thfHZ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755254901; c=relaxed/simple;
	bh=RJu/sNUIv8XQfDSHQySP+VYb7RjTMwaetdYaK/UPq6U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cr1pLLsnsvTvEWEmDzjzvHc6E4A4x2L3LhJPpl2BTJZWDrN2ERp2L4mB4JzHonrOEsBXE134jfSxFAgKZhIPocBzDvlHlexJw8n65QdsUS0mjxpMYk9wKRyGmu++mOF8mhDO2+DswCh/GwHuq7PzbPzU1Y+As6TwAJc6Q5vYZAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YfPOM09X; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755254896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AaSW/iwCuCeSk0qdAIyHg2YdKiOz+eJwbEC+JwzC1eA=;
	b=YfPOM09XPo1BU+oBnOV3ID7DL0F8FnzVL3RMOFLtqj21U19HXwnZY8KFOUVHOMGUfAl5R0
	8+YOoU/zvn2CHEU2EX5fkIO1C4fqTfaoM7SeT4oky+Ar/RYCAKAxfVUqOFagng5rDH2mF8
	9op5kavoHOpYOXm5SI0rRRMAXalkwGY=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3] kdb: Replace deprecated strcpy() with strscpy() and
 memcpy()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <CAD=FV=Udf3pZjhpPxEuHsFynP7GoHnZ7RG=NYZ2gLzm=E_4V4A@mail.gmail.com>
Date: Fri, 15 Aug 2025 12:48:02 +0200
Cc: Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>,
 Nir Lichtman <nir@lichtman.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yuran Pereira <yuran.pereira@hotmail.com>,
 linux-hardening@vger.kernel.org,
 Daniel Thompson <daniel@riscstar.com>,
 kgdb-bugreport@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <0BB3AC5A-5B9B-4149-90CA-80171B8B0A48@linux.dev>
References: <20250814220130.281187-2-thorsten.blum@linux.dev>
 <CAD=FV=Udf3pZjhpPxEuHsFynP7GoHnZ7RG=NYZ2gLzm=E_4V4A@mail.gmail.com>
To: Doug Anderson <dianders@chromium.org>
X-Migadu-Flow: FLOW_OUT

Hi Doug,

On 15. Aug 2025, at 04:05, Doug Anderson wrote:
> Let's think about some test cases...
> 
> Old code:
> mp->usage = kdb_strdup(argv[2], GFP_KDB);
> if (mp->usage[0] == '"') {
>  strcpy(mp->usage, argv[2]+1);
>  mp->usage[strlen(mp->usage)-1] = '\0';
> }
> 
> New code:
> mp->usage = kdb_strdup(argv[2], GFP_KDB);
> if (mp->usage[0] == '"')
>  strscpy(mp->usage, argv[2] + 1, strlen(argv[2]) - 1);
> 
> Example string: argv[2] = "\"xyz\""
> 
> Old:
>  mp->usage = strdup("\"xyz\"")
>  mp->usage becomes "xyz\""
>  mp->usage becomes "xyz"
> 
> New:
>  mp->usage = strdup("\"xyz\"")
>  mp->usage becomes "xyz\""
>  mp->usage doesn't change (!)
> 
> To match old behavior, I think you'd need "strlen(argv[2]) - 2", right?

No, it should be "strlen(argv[2]) - 1" to match the old behavior.

In the new code, there are only two steps instead of three.

With your example source string "\"xyz\"" in argv[2]:

	strscpy(mp->usage, argv[2] + 1, strlen(argv[2]) - 1)

evaluates to:

	strscpy(mp->usage, "xyz\"", strlen("\"xyz\"") - 1)

strlen("\"xyz\"") is 5, so this becomes:

	strscpy(mp->usage, "xyz\"", 4)

Unlike strcpy(), strscpy() copies at most 'size - 1' characters and then
appends a NUL terminator. In the example, it copies only the first three
bytes (xyz) and then appends a NUL terminator, effectively replacing the
trailing quote. The result is "xyz", the same as before.

Thanks,
Thorsten


