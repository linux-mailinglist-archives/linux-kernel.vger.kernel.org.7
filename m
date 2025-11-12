Return-Path: <linux-kernel+bounces-897787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5AEC5396B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18271502DC8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C2C329384;
	Wed, 12 Nov 2025 16:56:37 +0000 (UTC)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FA823B628
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762966597; cv=none; b=SKNxzQcFIYLJJZ4OkHxLXhpzzhX7txgWgSTXXGO2KW2umLkZ3KiWfyje7VsPdl9pR2gRW6WvsG6wHuvTqZcygn9ARq6BgykTZOCp/J8hb08NGEg17qOuQKlmbFLjyp4s5FRAG6rSD4mzwVtP00qLoCISZyuRqz6qsMu8Vyzj2sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762966597; c=relaxed/simple;
	bh=T3lNvQ0y2bm+Oi2zi67RnQocL22TWx1eaOJ5o7iDPFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CaDuQkLMQmWbkEV8R55b0q1zT8XrImNjbzQ5N6YlKBH9JM7I23IbOnlnP+Pb4YjPwSA7E/gniCDdY683GZcclWozKvI7PMBhgAbKRgOQFCaywtN2A1jPJ0ySCDeBlgDwm8tE+mCY2a4TOsyN/PiqrieFcRuSJsD7bCm9sv1yWz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5dbddd71c46so427008137.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:56:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762966594; x=1763571394;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhutrMq7B1n6leDwSPcGHxIdFInhi5IFryLgJwU5jxA=;
        b=dXyQuP5xONt5mPdFjouzIKQQgzOP+5r6LzP2tzpHR+DuvaqwyYsukEyeYWSgNWJcwx
         2Hz/8QVsGEHv/475xFN7DRrmW8zdk/kjRc8eotZePVanf2l1vCKbwq4q9/HnYgB7cx26
         rGT0sa7JLiPd6RgS3kayWLX+la3kYRcWZUrK/tp6t7Dtsj4H4x6W3wS/iadHoZMyAYQZ
         WepVaTatqNyuJkB/DExWbwkAJ8i31QQuo73j1TlJg4ntETrNBYOZdYqwhxxFko2W13qa
         w1NrmoezC647aFzvVF3a3SXjJb36Cdz9VUePNGqJyo82QCCTVOs1lXOt+8zAZbdJgh3N
         7BjA==
X-Forwarded-Encrypted: i=1; AJvYcCW3BkTbjHm6b5P1XragdGbOQpcj8cYOmagyHL7n/bqJfGBNxMLFuC0p1l69VEjfv0Lujku0+SWmHK0FQd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGTeAQSwPk9uGWJcvhrCDllslQb0dwQGR8R4hcQs18H9yhGpGX
	ksZEtCrvrTfFAR5OgqSq3DlhvvrwQdlYbKVkqxOy6QjsQvd+UHV/fQ3q00odAZgW
X-Gm-Gg: ASbGnctoRRO18pIeADL29S8smIkM4+8Paz7kuhG00GUAPMdg3ShyYt1gR4V8+heZczv
	kS52I63re5Y2hmH9OmjOwNwwXMomNwObZsuiYIM6YkFjx/4zl9zZ4+jtphPAMHq70q1o7mM6rHK
	4YgceTNdpQxbslgqipMP2sHx3+3T1wSLgDIfD6i7hBoWO+AZpPQNJNcjxclETLK5ezrARZeYI/4
	LSrpczPFYPkOvpXcUtFJbV1oezZxizAWTJpBHvDbRCED1nDsXV1PhpMZh/3nVQ7bSp3XXVZVG+Y
	YmLknV+81qj5L0I+xLmQ6TVtXwhmvc1EQu6nacRE1UWVS9f7v+tKbHwEl1O14k4OqNW4jA7yl4r
	t9QODTOYe4aByrjTkfy+acABUrI4RTkxoQVt/arfH8qyserFPByiK8eLj+Vt/pyXLEbsxXh993T
	3hO8DzFQUF+7Qz2V9vz0vktuydci1KG9U772gjsg==
X-Google-Smtp-Source: AGHT+IHIAlSEOHuUzitSREdvl1RgzoeirqifVphsrLx7Ktu7nBrdcDatBdRxAigye4otOzkfZ0z9dg==
X-Received: by 2002:a05:6102:a4a:b0:5db:b7d9:4db with SMTP id ada2fe7eead31-5de07d5228amr1166499137.14.1762966593587;
        Wed, 12 Nov 2025 08:56:33 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dda200bc7dsm8138280137.10.2025.11.12.08.56.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 08:56:33 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-9371f6f2813so342425241.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:56:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXrzMZFrWltF6cXdl/kAgksdu0gY4YAMNyMAKHh0RZYF+59Rwqs4auhHbhspjRWV8E6/KFc8/GTxWl8eiE=@vger.kernel.org
X-Received: by 2002:a05:6102:950:b0:5db:fb4c:3a89 with SMTP id
 ada2fe7eead31-5de07d873a3mr1213694137.19.1762966593135; Wed, 12 Nov 2025
 08:56:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112143520.233870-1-yuntao.wang@linux.dev> <20251112143520.233870-11-yuntao.wang@linux.dev>
In-Reply-To: <20251112143520.233870-11-yuntao.wang@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Nov 2025 17:56:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX4yfPGY-HhP=f+2wg9kUxTw4_L16uVof8TT8GikM5X+Q@mail.gmail.com>
X-Gm-Features: AWmQ_bnTmdC0UtH4pcRnMOG6DoWT1MWDKeFhGtY0fjv71oOtf1MXcy_DKHcnSwg
Message-ID: <CAMuHMdX4yfPGY-HhP=f+2wg9kUxTw4_L16uVof8TT8GikM5X+Q@mail.gmail.com>
Subject: Re: [PATCH 10/10] of/address: Remove the incorrect and misleading comment
To: Yuntao Wang <yuntao.wang@linux.dev>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, James Morse <james.morse@arm.com>, 
	Baoquan He <bhe@redhat.com>, Zhen Lei <thunder.leizhen@huawei.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Changyuan Lyu <changyuanl@google.com>, 
	Alexander Graf <graf@amazon.com>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Nov 2025 at 15:38, Yuntao Wang <yuntao.wang@linux.dev> wrote:
> The of_bus_default_match() function appears to have been copied from
> of_bus_default_flags_match() with some modifications.
>
> However, the comment was left unchanged and still describes the behavior
> of of_bus_default_flags_match(), it is incorrect and misleading, remove it.
>
> Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>

Fixes: 6e5773d52f4a2d9c ("of/address: Fix WARN when attempting
translating non-translatable addresses")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

