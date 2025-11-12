Return-Path: <linux-kernel+bounces-897761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB4AC5381C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C0BA6352B74
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5958233D6E7;
	Wed, 12 Nov 2025 16:36:41 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A322D130B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965401; cv=none; b=ge+gogb4PgKxeYcudkSprKZngptMF5+w44vJTYV7fp1Ro9FGUwHV1/+uL6iZJWFlDe16avNLKV8ZlbmHsV/uF1xOzOXtzkvfQ3A/oTdIpSiIv0fO0DGiJqqNsPvE7RYzIXGbFqKYAs852MB0xUTZnobcPl+3XEdUp9TTBeqxq88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965401; c=relaxed/simple;
	bh=Sk/VdDOjP8jSOytlFi9s9mo2ys81rNWZ2228bwgTL4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFoxpJebrTlzwLEROZ0Z3fKpzQeNpZOdMXYSqqGiOiDwWoHKDZLNThi+mqA0RBHAWYFAWNOC/vonadUWO3sFsFYWMNQCaHjma9YtATjTdKJNOgmHaDWy9Ay4h4YTTP8Es3obwOd4OUjHXppLTHi6BPg5uPz8IbWWCYXt4aUZF+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b25ed53fcbso143332985a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:36:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762965398; x=1763570198;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sffz3tuaGapQMQeKbnEwNMkk8oLRrGLz73c/pcBk56A=;
        b=TnLPrYdkKbfk1F/+6l8n5TYdtJuoLuT0Kvbuc2tisjRoo1V14zWhdx3HggL1VoL6nM
         Bk0xiM60dbGviz431wv3oaoP9LOu5y8XR0RPSopdoUO/wRcKLBaICVRBjs+PIBo6nKwK
         JkWwwK0F3gpDbmHI6tkMc5glHmPn1bCxH/pVsnJa4prpvvm6zRJ8z9mH/l2ZImMyJqrM
         bhWW0LH5GwPbG+TkPTIHgbo5n0KwyKHbdH0vMVvC01xq9O33B6dtZBLqfjG+aqxd85sl
         EN2HtTg2Ig7o32r+I1jIftDAzNYfI7VoZ8NfTxGoxo+rmgCmLKAiT42t5z7Pgv1ALLHQ
         hsPg==
X-Forwarded-Encrypted: i=1; AJvYcCURw5f+Q1oVDcizttXsY+Ic2LhqTm3q+3SkwfWKrn4jo7NGF78rAdQo7ndCJmo8sWrCukGxLO//bkBYbmI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi+dBrW99hAAI/+EdTN63MCwaFmsVTPFpm5SUpIt7vgcaKdyS0
	1gBUuWSg3+IFD0mYajQz89thLOcg79PnY4QSJjqnidImuUAKM+IKwOUIg1uLnuS6
X-Gm-Gg: ASbGncstfo99OedIHedprsPMVm2uifjy1Uv5b9sYxu20X/oueizt7qxprHfWVGZCbWA
	F53vSr97FMTqwFDJ/EpXQ8WjoTLkmBx/TSIm9ymCUv06Zt+Cdjzw9IMQLY39OawmmPMamJ1AfSR
	OYGZx8KlqkGM+39mhhkYUzbba7fmBx++C1VPj0Xc4ii2kF9Cmym96GDIHEieFAiYclG/alt7fiy
	AJb6JRgpVLzSqZWuYRS1Ohv4yaf4SWf0/9vPnMjTSOKoOZ0NQzl0VoDEJoQIZ7rkRZKCHAZ8ZUK
	SwxhUPpMx+KbmQdCSE+xbzpbViSdN14jW1NmlFJLuxbHUl5AhuRKpXmgnOxRk9ETg04NozoK7w+
	PTVC7Rbk7HFwf0pVaaAfwC6zMaj86XaCoSCgVFXK5DkDzXrHlUS0FJm+lQvYAFk3gyEbKagNc7m
	ZIPpUQ+V9mV+tfhw0GM6rmkQ5dRvibbcz8gjkA9b63hONRgDMHzIsz
X-Google-Smtp-Source: AGHT+IEC5WmfmYzKRTN/4xKvG7+gh3JUKQ/Nta0eU3GbtBtMshRDbq221ULSwh7Xa2onWJ/elmARnQ==
X-Received: by 2002:a05:620a:4406:b0:8a4:40da:b907 with SMTP id af79cd13be357-8b29b768ba9mr470826985a.32.1762965398016;
        Wed, 12 Nov 2025 08:36:38 -0800 (PST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa0082esm218707385a.50.2025.11.12.08.36.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 08:36:37 -0800 (PST)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b25ed53fcbso143330785a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:36:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXhKVkVjAByV3zwN9ZEM6QziFL5+O17Ljhf431mUxrt97de5seBXhILpSG/O5nr9XQHk9vU9c1iAcb1y24=@vger.kernel.org
X-Received: by 2002:a05:6102:2913:b0:5d7:ddf6:b3b7 with SMTP id
 ada2fe7eead31-5de07d0bbedmr1183622137.8.1762964930074; Wed, 12 Nov 2025
 08:28:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112143520.233870-1-yuntao.wang@linux.dev> <20251112143520.233870-3-yuntao.wang@linux.dev>
In-Reply-To: <20251112143520.233870-3-yuntao.wang@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Nov 2025 17:28:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV_n1XBNkZ+4pYF2RyNn+LWu4DasUgOut9ZJg7RnZn1Ng@mail.gmail.com>
X-Gm-Features: AWmQ_bk4xxmjNl-qRNjNfh_2vFa7asZw1z28h-USze4ilNHopbNHQRytaRHEDHs
Message-ID: <CAMuHMdV_n1XBNkZ+4pYF2RyNn+LWu4DasUgOut9ZJg7RnZn1Ng@mail.gmail.com>
Subject: Re: [PATCH 02/10] of/reserved_mem: Use dt_root_addr_size_bytes()
 instead of open-coding it
To: Yuntao Wang <yuntao.wang@linux.dev>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, 
	James Morse <james.morse@arm.com>, Chen Zhou <chenzhou10@huawei.com>, Baoquan He <bhe@redhat.com>, 
	Zhen Lei <thunder.leizhen@huawei.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Changyuan Lyu <changyuanl@google.com>, Alexander Graf <graf@amazon.com>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Nov 2025 at 15:37, Yuntao Wang <yuntao.wang@linux.dev> wrote:
> Use dt_root_addr_size_bytes() instead of open-coding it in
> __reserved_mem_reserve_reg() to improve code maintainability.
>
> Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

