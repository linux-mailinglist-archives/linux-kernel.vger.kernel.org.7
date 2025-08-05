Return-Path: <linux-kernel+bounces-756460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC143B1B4A2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CD80179B82
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21620274B40;
	Tue,  5 Aug 2025 13:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QFkpxDe6"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5826F2749CF
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399737; cv=none; b=NAyDjLN2xL7YzZTEAPVgVWFdzW1QX+iTeZNh84s4h8+lKJRaB5LsKdgYdsz/jpmZMwOlOON0lukoCDdbdr8+4cHs2TJd/gE2F74CG+1kfW3Q2CCWX58ngbUqLJmHxYxYSKAyVIT0D7AYD4VWkex+aHUwDXayhMJNaH2boUG9eBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399737; c=relaxed/simple;
	bh=+qO3PB9bP+33YrM4AWmEKTR1mfjqtXnwr+VkBAhMJaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOLFnJ9eYUP36Smv9X9QcHdpYi8er+82Hl6IPwQam59eucK2L/ID9iC6spt7bG17zjS+yzKxAeQd1XCjTD8MGVC+rmvOAKuWkc8578diApsHVRSV0g8hteL36yUCAz5bOwauprQvPbSvZMh9nDMR2B/paP8x7nBesGb8kR3HIUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QFkpxDe6; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so9883790a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 06:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754399733; x=1755004533; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IeApHAiG6oQ+gXTtDO1UmH6ll3A+3GlaXtGicO+VwBo=;
        b=QFkpxDe6jDqfks+mATZndwDLqzLlMKLglswGPE1I3UznEGzKLfH0ZdFVxUKuSpA3S0
         aD7AcAS4y2gvEPuYiIbWaT0gUDC6+OytnQTg4B8FMQhZ9dlez5OftB3GUYUakl+wUOPh
         XGI6ckvH9Iun3kmZvZGiNsBtcKHvPhw7rjPLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754399733; x=1755004533;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IeApHAiG6oQ+gXTtDO1UmH6ll3A+3GlaXtGicO+VwBo=;
        b=R5KfnhyCaF8yfClUILevh5uA37PUk5aiHrMANGpKL+Vtx3OdO+lkVu3t0EJ6twU98q
         Gk7XUHi/AOYA5OGOVynR5PuUAyh+PVpY8NcdEMjKErJ/EwEG4TJjVc/84IcrwqQg/+PL
         TAqqWE3NvqHUOP3/sVDwbtkPPspl8ARNDwxG5DTNIs3IAsllDGA2O8HKiUS888ZROy7r
         jclUwLoVsBPogVJy5Z8EdMhdH7rsP2RRIpD6hMo52PYIigbPz5oFyvmG8ybU2SuaswzA
         l+Wb8kJ3r98tTEfnCnTdOSBeh09LAGxqrB/WHUlGAOqn8JVBbO2bqgNWEGpcK6JzFLQg
         cJpg==
X-Forwarded-Encrypted: i=1; AJvYcCU585KfaLEnQSob6Pa1S9tgeukcPUJ9Vwagjcy4tVMqKswT7pLWccXSndFxWCY2634ir/C/EkPO4faCoN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5x2uDlxVaB++DEJQ/m708I7xuAp5oUCAHbaWkh2LZHMQ05sqn
	VPESl+F6kBUcu+aDEUumQTDd3E87D2rHGwxzTKMsX89RVHzWpGnFNKw1SZa4UbgX2pTo0ynbavx
	aCgTebFm9Ow==
X-Gm-Gg: ASbGncsgnMO73NkfDb1QfmV1ReRpBsBuNoK01JeUmnx6T7tMYSmeifkh2a/bOHiVqoA
	+/UltsOXC4G0noR1mrYyIKJd0MyfeD74JBw+SAqPCDkMKTlB2P+jptkB2uhTZlj4Q06QyduojMY
	LNK4eL2tgcRrUO9jiwNEO2fntjhhrSVTN9GeHKiksj3rZ8XVYs7qM3by8NX+SIBYvDC1y9SUwVp
	7iOAyqFgHIH8ABXjWIkCMcNR3lHnNgmEXlkhIwx+mvKc2rlBF7xlsVDchU7rY3HJVs/DuZuIpsk
	1A/aMvuPvvyPQDL0YsUJK3tLlTKz/x4UR9oSXssWBdzCTWJPaOkPUPp4VCJbVUqau+abq0200QU
	qZPIjTa2QFLEY56IoppMjoVnGyru6mTZ04YUkgZtsCUxazTTcfMgRlsqFpQhT0MzTyvrHo4MO
X-Google-Smtp-Source: AGHT+IHklX2OsiCWjL5HIvt8zAmSTDAayYDvZzcZN9eU88fTv4uyE40alS+iHN8+s/nhMLQ8fMaP5g==
X-Received: by 2002:a17:907:6096:b0:aec:5478:9697 with SMTP id a640c23a62f3a-af9401af456mr1203151166b.34.1754399733232;
        Tue, 05 Aug 2025 06:15:33 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a219ecfsm907304866b.94.2025.08.05.06.15.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 06:15:32 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-615622ed70fso8524366a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 06:15:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXTQG9IW9E4RrWwIjc8odChImZqutflLkvoDF67JVlDG5oRY/hXjjj6WM6nLf28iQqVUprzUgShyn+H7ag=@vger.kernel.org
X-Received: by 2002:a05:6402:510b:b0:608:6501:6a1f with SMTP id
 4fb4d7f45d1cf-615e6eb5b94mr11310388a12.1.1754399731827; Tue, 05 Aug 2025
 06:15:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804162201.66d196ad.alex.williamson@redhat.com>
 <CAHk-=whhYRMS7Xc9k_JBdrGvp++JLmU0T2xXEgn046hWrj7q8Q@mail.gmail.com>
 <20250804185306.6b048e7c.alex.williamson@redhat.com> <0a2e8593-47c6-4a17-b7b0-d4cb718b8f88@redhat.com>
 <20250805114908.GE184255@nvidia.com> <9b447a66-7dcb-442b-9d45-f0b14688aa8c@redhat.com>
 <20250805123858.GJ184255@nvidia.com> <db30f547-ba98-490c-aaf7-6b141bb1b52a@redhat.com>
 <20250805125643.GK184255@nvidia.com> <a18a9b55-b3f0-466f-abc8-39b231c04bb1@redhat.com>
In-Reply-To: <a18a9b55-b3f0-466f-abc8-39b231c04bb1@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 5 Aug 2025 16:15:15 +0300
X-Gmail-Original-Message-ID: <CAHk-=wiQ=9g=+A8LPWhPj9yRXFzf=tJKw1Cy-wpj1N9FKu-65w@mail.gmail.com>
X-Gm-Features: Ac12FXwrAL_htKZpJKiw_Db3QzCJ14QwInGEA0oKHNUPYerZIQYMEL6CgT5QlJY
Message-ID: <CAHk-=wiQ=9g=+A8LPWhPj9yRXFzf=tJKw1Cy-wpj1N9FKu-65w@mail.gmail.com>
Subject: Re: [GIT PULL] VFIO updates for v6.17-rc1
To: David Hildenbrand <david@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lizhe.67@bytedance.com" <lizhe.67@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Aug 2025 at 16:05, David Hildenbrand <david@redhat.com> wrote:
>
> So I don't like the idea of micro-optimizing num_pages_contiguous() by
> adding weird tweaks to the core for that.

Seriously - take a look at that suggested sequence I posted, and tell
me that it isn't *MORE* obvious than the horror that is nth_page().

Honestly, if anybody thinks nth_page() is obvious and good, I think
they have some bad case of Stockholm syndrome.

This isn't about micro-optimizing. This is about not writing complete
garbage code that makes no sense.

nth_page() is a disgusting thing that is designed to look up
known-contiguous pages. That code mis-used it for *testing* for being
contiguous. It may have _worked_, but it was the wrong thing to do.

nth_page() in general should just not exist. I don't actually believe
there is any valid reason for it. I do not believe we should actually
have valid consecutive allocations of pages across sections.

So please work on removing that eldritch horror, not adding new worse
versions of it.

           Linus

