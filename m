Return-Path: <linux-kernel+bounces-778717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB38B2E95D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2C017B027
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123D36BB5B;
	Thu, 21 Aug 2025 00:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WFuxreCg"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06418AD4B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755735088; cv=none; b=q2NdSed0spIF1xwNpFL6iDiQA9OGDq0ErImqgdtub7qRGPN3LACLE6AqujtINw5gwVkj8RArwJndgOyKnAuFn9au7d+QB3+x8m2/DL6PdbuNf7YI8Ky8ZCtyt5HxHkjMll1Le3S+h8KNZeGEhBqCs4NM4lbaslLyejwMyguI1gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755735088; c=relaxed/simple;
	bh=qDuVJJoAUxv3muiSSv8fpnNTDGR/x0zGedQPQ79mWr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3+Df9IXmQdVscqj94IyKBCrDUEloyEWzPE89Ofy6MmA3JPhEfd2q6hGewJZ9Os45qLanKXhkeZVgzlS5wWSMLh1y4TFhZ42IMtIzSvQWlvM4mdcEUdMhC5fhaBN5HKZPBrU9EsFUmmoHF2HRUG9vjH7hJ6gYzsHqWUOtDYNrzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WFuxreCg; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b29b715106so90961cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 17:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755735086; x=1756339886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDuVJJoAUxv3muiSSv8fpnNTDGR/x0zGedQPQ79mWr0=;
        b=WFuxreCgViEf4kw6XrMhA1cOYMhHvU6YfawjVolwzPllXdiPNz55jCmZW+2P7pwIWl
         2nmMF0PWe0FVS6TC9y3QmVBZ9bk3EaXlq6gZZWrDZmVaWzF9KOMYQ8q8MJUF/EnpNBsS
         j2iemWSP7UUJj3lnvI/2K2iOsBd5Rdf0/QpMSen0fvWSc46nj9WiC4a2Def7bv2Yb8IG
         Ki5ZP5pu/4GK/UWO5bn8xp0xc33sdVs8JfQHCI8e3Ki1+VzoSipNiMHDktcbhRcCX9E7
         IL5ftuHBwoVkiQrWPLAhIA9lBZl8mnXy5rLjfL/yG3HKlyMfgntCHNO80Z17tyPEamM6
         H35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755735086; x=1756339886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDuVJJoAUxv3muiSSv8fpnNTDGR/x0zGedQPQ79mWr0=;
        b=MDYwqWoz/Fv9uMNp3GPzvwJgASQHHFPAo5xYnlT9SHPPrVKFCNexdZOrUr8XA69Mhd
         OcfGnNanRLhePZ5OTv6CP5g+6ZP8WwQUrT1Ot7CaTnWiF+9UB3Bd6g1YTTaYWGWZQIj/
         6idS+6julwsN+ilNrbiLJn82HJyw7TtLw0B76QyGZdhkDb5rsMAshjeBVe4yFAl6jzQU
         LJC1/at27sylaSfMXqGfDCdagC4oBtCH52CoCga0kNHzNxBvVlITaDCgSYLsthsj7vD0
         zJp4mJ7M4azrl+gcdg9t4s92AEKZqDQ2l+cHhG7HWJOH2tosOrnBqpGuRlQyL/D5yopQ
         tumQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsxe+pWrwMwJA3J5hyVlE6JFG/TPtfM4W3XRvHpUVIz4R2cF4Tyr0VC/0GT7xmMg9+6kf8JWnOJpgHwtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/xIJgSWAzh8Y50JWTTZXKmFz/zK6Rx6YXFWZ34UczfZeYYUzl
	qsYVvhtcAlaUIzJHA7Wecn4luNAhhFlqUMLpyxTlpT4nGUWn0ayGasJ9UgaCfaczNzOxKKBosjk
	VdhDMCf9iPtXZbBnt59v4IM7zM57j5dqbocFflMMr
X-Gm-Gg: ASbGncuZF8rVOJLbzBD1LYD8aWzpWBBP+ZqF1Pl02HhdheoGGZROXsl57mC5XafbxXt
	AODtMXqhtZyOTi6GeT8cL+TDqMPophgXa5fwXWoaPGPFxD+oRecavZ7i8xRdVAd9dnoFuO+/7sY
	s8BfkDsuXcZVihTDqjGJo5WYmP/GpCFr53Zw4li8BU/6oMhFbnP5m+3DkTe1QLiLqlow7V+A4kN
	3mszXjxybwQWQ==
X-Google-Smtp-Source: AGHT+IF99LbXLI9xEqv3Lg2WHOkySPTdFwGRmDiyZwt1GZaiEZ7cjqwrrgYD0oh+Ce8wlVOKqoIDbE1J5rXIEQ9vIrs=
X-Received: by 2002:a05:622a:241:b0:4a8:eb0:c528 with SMTP id
 d75a77b69052e-4b29fa23c6cmr876461cf.15.1755735085447; Wed, 20 Aug 2025
 17:11:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730205644.2595052-1-blakejones@google.com>
In-Reply-To: <20250730205644.2595052-1-blakejones@google.com>
From: Josh Don <joshdon@google.com>
Date: Wed, 20 Aug 2025 17:11:14 -0700
X-Gm-Features: Ac12FXy4W0l_KdhBgYJG7licE8FPoEnG5_TIQu1hkBF_vtvydIZGjWCXQuOfjxY
Message-ID: <CABk29Ns_YttEU29AhREcNv-vqxDC2jEvFL-5MyhZh1RReecYsg@mail.gmail.com>
Subject: Re: [PATCH v2] Reorder some fields in struct rq.
To: Blake Jones <blakejones@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Blake,

On Wed, Jul 30, 2025 at 1:56=E2=80=AFPM Blake Jones <blakejones@google.com>=
 wrote:
>
> This colocates some hot fields in "struct rq" to be on the same cache lin=
e
> as others that are often accessed at the same time or in similar ways.
>

Thanks for the analysis and this patch.

I was going to suggest ____cacheline_aligned_in_smp, but it'll behave
nearly identical in practice so it doesn't matter (would save 64 bytes
on a 128 byte cacheline UP system).

Peter, any thoughts on this patch?

Best,
Josh

