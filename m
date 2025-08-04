Return-Path: <linux-kernel+bounces-755350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE34B1A544
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB143179108
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FA01FFC48;
	Mon,  4 Aug 2025 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcKUtV+y"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964DD1F582E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754319072; cv=none; b=mbH/YC1CeCxkusEgXcI/7HSNqVOZ/kNP8DYjkzqvI++DvrwP3Z///AkjXXTXpZEU+CVZZfHCGGZU8ijMK+fqTMN4J+UCh2Qx7HKMQgRbVVJgDTikrHc8aAFQqRDg+JrgmjxufJ+0MDHOv+TQAEYqgOUHxzqaBahU2l6IZiXsF60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754319072; c=relaxed/simple;
	bh=0QNi2433aMOcT7VvcJO8yI0WQRWFprB/tnxl9b0uKg0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=d8wkls1zM9/TuXF0vuhKF8vjpNgivh5y2PJj8k4aQ/iUnMnJcTETBpgtIMDxlGlW2Uj08k5hmOYI13gbyFiJdUMwTyvBXIUtz4qIXxvfqf19nqJoJNhO1uj1c110hnvG4AVwRn5B3GqcEO5a5S8MwCCxgk1DcBYp5yibnyj8tps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcKUtV+y; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-458bece40fcso9880255e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 07:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754319069; x=1754923869; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QNi2433aMOcT7VvcJO8yI0WQRWFprB/tnxl9b0uKg0=;
        b=kcKUtV+yfAXDiYEUsnv7Mp6D8klMp2aoLQd0Gx18yJWj4sUPUIH1tf+80xBwqEjdGX
         ZNWJp3aP3My13rb6y2VyoftHR5mZREV6w4+bY5F0g1E1dU2tv86mHYvsBtvWIgohpIG6
         QZvGwynQhk0v44yUyYXCdaoTvZQLboM1HEHlBPuFViYcz6jV3GWs4ccREDYbKj58sr52
         XgHPSgoc3AdjzJ7wxkprRMLtksxVsOrdjekjubtg+wmk5ZiWAm/O7JY85FWhczRV0xms
         +j088ck56RQ1g2+RxgZU2kgeqsvmcT5Eday1TPkg0y1oKou7yx/73fBAKXPUdMxswdHK
         HDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754319069; x=1754923869;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0QNi2433aMOcT7VvcJO8yI0WQRWFprB/tnxl9b0uKg0=;
        b=SEQMpZ4UGMDjVjFKe6Jgp9sI34rtat8wJk13oqsP3+YoO3lU6o3XURF65WcI8P1vVt
         HC5pzMAXTP2Sct5svSBgBSTCmXBmzSMLCIlCatzdtz2gvLIybCf5jB1XwbTwJmcFqWAL
         Y1PYYe9sCbjNls0mhy9MtiZUbhpCPm4WrZ5kTz/q2boUNvnDEBTyoGC5Xop8T22rsYwR
         WxtfI4madyEvZP6JkVc7kA2odj7AKEHPm3ipDZTcSvy69Z/I8KTZ9/SvKSBtVTUGNWdr
         t65r1EuM9XPXK64PnVNKVdgBmKg9W8MoexVy9lG4YwGterWatg9IlZLgBKoo2/NfIk53
         vG3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWO6oQP8LqSC3VRzbWuV3K6Q/DhQnx583H0pyEYpnR1UUbAGPYBbenGL1GFnTWXUAG06X2KezmQvIe8IWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOA/JuMeZj5mwtUNi+Wwo5VYTqYuHkLiAMJl9CK6uz+vl4YDQj
	lSYAbzj7GCeELvDVYJ1xMgWC1hfQ1CkymKEJ1PR/Z5oKrp41HATZ+a4gI+ax1C0D0x8=
X-Gm-Gg: ASbGnct5KKABoaJSroOGy0vnwNUblnWWf4e6YORqkKbvW5IEiBi2z7SKC/NMAAGM8GA
	Y79ohc7MrPCvWmCj+56U8/xXl6cCqbAGd/tWJn4FZHtUtaGOygDDxEnRryesbzAd22zip2rGagw
	272wVkV+iafUGqByV4eW/CWoJWPU7b3t9ORem2LyXN3DwE0FvfVJ3W/LjNzy3KDPRYmZYhfiuRf
	hkD/cVw25WjTbzrKm3zazvFgplkQlpySWQVajuyJZ9YpXyJUUpU/a2cSq4zUcueWBVpWTpomzrs
	yHVVMEtkB8Tb/1DyLuNwlqode+EJYxAR9BdWiMGFv5i0i0Oo2cb68n6q2BV7/BGOTEFBE7THx4+
	0Um38FnS2cE2PWmtsIhFfDtXYnGQRyCMDVZjKnA==
X-Google-Smtp-Source: AGHT+IEk/XsbxMajLX0zrOWwGT5yoALOK+d2YnoUE0SWEpt7Bdw+f5idlnSsn8XeUpvU2PaNJyVvng==
X-Received: by 2002:a05:600c:3113:b0:43b:ca39:6c75 with SMTP id 5b1f17b1804b1-458b6b32b36mr78981895e9.16.1754319068717;
        Mon, 04 Aug 2025 07:51:08 -0700 (PDT)
Received: from smtpclient.apple ([132.68.46.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459db13fc9fsm39629925e9.7.2025.08.04.07.51.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Aug 2025 07:51:08 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] mm: memory: Force-inline PTE/PMD zapping functions for
 performance
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <2a1b7ebc-f27c-444e-be89-df14ac1dc97d@lucifer.local>
Date: Mon, 4 Aug 2025 17:50:56 +0300
Cc: Li Qiang <liqiang01@kylinos.cn>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasarya <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0F715281-1754-4D81-A71D-4AC20BC13095@gmail.com>
References: <20250804123923.296230-1-liqiang01@kylinos.cn>
 <ab22e314-63d1-46cf-a54c-b2af8db4d97a@lucifer.local>
 <2a1b7ebc-f27c-444e-be89-df14ac1dc97d@lucifer.local>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)



> On 4 Aug 2025, at 16:59, Lorenzo Stoakes <lorenzo.stoakes@oracle.com> =
wrote:
>=20
> OK,
>=20
> So I hacked -fopt-info-inline-all into the mm/ Makefile in a rather =
quick and
> dirty way and it seems some stuff gets inlined locally, but we're =
mostly hitting
> the '--param max-inline-insns-single limit reached' limit here.

Yes, it does require further investigation. My point is that sprinkling
__always_inline is a slippery slope. You start with putting =
__always_inline on
zap_present_folio_ptes (as currently done), and then the caller becomes =
expensive.

Now you noticed that the caller to zap_present_folio_ptes is not getting =
inlined,
which is not surprising because it got the cost of the always-inlined =
callee,
so you put __always_inline there, and so on.


