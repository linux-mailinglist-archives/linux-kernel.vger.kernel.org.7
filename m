Return-Path: <linux-kernel+bounces-880551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D43BC2607A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACE6C4F6F36
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B5C2EC080;
	Fri, 31 Oct 2025 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WaAq1KKY"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EAB2F2915
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926694; cv=none; b=Uh9Em8IDo7QiefCSBdfwaPRgbg9UqCZzQPffGgUTenALgpN2IEu648T9+ECCo2J/IPuFK1s9JNUt3lUtQpsAPRINpHeIyQ9JpGkUI6qU1mP1NL+KaJs7FTIYE/wtz4PmIHPZrgiOWB5Zx3zCsuIqnOfy0YvhxtDpTYeKZK3ukhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926694; c=relaxed/simple;
	bh=tB2xm0tHoFpBrehX5ultMyNxbTezXcjRnBrfqVxMnrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1uH1qaaWx5p77bDDfaw5LjyOT5ugXALH29PVFCq6P67EXsK6nX//C1T/suSX3eIIgZNO1gg/E0MIL3auS82LOGyrub+SX9sUCbhdWcwfmmwPEUFkaptLK6fJI+2AvOqk9Wfga2IbrGeRkU8kT0U+vPQ+YwxbrRqYjwEKsJdIB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WaAq1KKY; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so528074566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761926690; x=1762531490; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=60wW3RdT/GxZgMsGz0dv4U+v3VStlN+NgjbyhA221jo=;
        b=WaAq1KKYS+dDnhPh/U/7KvILvcBrD3JNnr6zCrXJZGzqvpiZx4qAYLV57167fNt0Ir
         RPrKymyQr+H2I6z+e4C8NJK43gNlIjSb1cjgX9eRCVoQmLxkcUli+pEmdwPl/jvNL+N8
         OiGdJ3l4LPOnqWqi/ej0k+PVsrwhRgVMrXFlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761926690; x=1762531490;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=60wW3RdT/GxZgMsGz0dv4U+v3VStlN+NgjbyhA221jo=;
        b=VTAlCtiDyUzeoEwar8Hi3md2O12MZ+PiBH8yECMx89F/4Lu9x7kSBmRssToSZPUxE/
         y+k10gYZhxpo0pp4imhK4a1aW3pmES/RYV9TPA2YlExxWmLG41btEy2uVE5CTviLdil/
         7JdDawFToI2jCKxHc/Szb9MeMXhlPUGglF1ByXQduOnJqCmpgse//7mzU+9Y+pVAKPbB
         syCh1M4Ml/loPgcIEnR8XV+0ctNq/zGIEc28W3hZds5SV/JuS5vQORHLYteE8QncDsnc
         ktEEl1GJHKJ/UEzOrWLLuF1qFvgxURBXDCWZVghWNu7qpPrbRq6LTIM3uNnf++P314X/
         bz2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdl1SHzb1ndBjxmJ3WGelBT6fseXiWJhc8XtOOsCRjvE/F7Aj5JtXGoC/pvkX/dsz7aYmCH/WjvvZhkB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2QWXanlL4eCeUQCn4hJEst1DSdQorNHkgJwPuq9aFquUCHD6j
	/3iAHZ2xJzFr+i9+zcOu2wunNbBek9ED0nvbmi9tJv3ACvrnXFCBYVxE2kEe7Pr0HZ3l3UaVEO+
	FaaPDFmA=
X-Gm-Gg: ASbGncvpqgmmy8lCxDeIiA95kwlH1mupfedAhcqI7/MUnWpN/KZaczTKDCEts1cDCfG
	7Xs1qWLfkFeuGxqp1boRJ+k2q4uL3u1Qg/Z7nBRu1aNK+CEUIf1CYSxxyGB+Jf0OLkn7yJ5vLVZ
	erJSjhiFKUmJWkcvPl00LelYpz/ugLvan5U7vOEasyAXXyRvAuigMxFTj9j3gXD8exSY+yraU1r
	u+u/wNpR/VWVWno5QxAjB4LXI9b5TNXJIPv/DpsNNngAgoRh7ub7zf2/EDgtJTyxmXxg8oTPIXe
	Nbtsqk7HjhsWZUnKuIEM3Dc31l6/MuvV3W9QoVFh2eqpvCn71V+tP+i5USzgTwvz5f8mjY+HNrf
	60ZTgCU2vWQzzww9RUcZ/xoKYkCS6i2Kyx0OpfCJsPB3HhYvcV+b6N/D9hzUuaUQFud/vnxG22I
	QdODWAqv8vDD+97UaucpCZIIP2tP3MIVersX+heiqYDnQvWyPGKwKjubslwdmD
X-Google-Smtp-Source: AGHT+IHz34rNDqSz4z94CVzOsHgEb+1kpAcYz2v/SG9ERs1m82uLOedyNiDpOKHmHHxRuS28/+l8gQ==
X-Received: by 2002:a17:906:4fd3:b0:b2d:d7ba:8e7b with SMTP id a640c23a62f3a-b70701b183cmr449581666b.23.1761926690152;
        Fri, 31 Oct 2025 09:04:50 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077975cfesm208802466b.4.2025.10.31.09.04.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 09:04:49 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso4354974a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:04:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWET10+gw8KngIIFVG90zYK5GwuRN3bJy4ddLpKHgmWL28nVdGtHGyeu5+OdRF3n5Z7niDh2jZkkjClPo8=@vger.kernel.org
X-Received: by 2002:a05:6402:1e94:b0:634:ad98:669e with SMTP id
 4fb4d7f45d1cf-64076f67832mr3110351a12.3.1761926688856; Fri, 31 Oct 2025
 09:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030105242.801528-1-mjguzik@gmail.com> <CAHk-=wj5o+BPgrUNase4tOuzbBMmiqyiYO9apO9Ou-M_M1-tKQ@mail.gmail.com>
 <CAGudoHG_WYnoqAYgN2P5LcjyT6r-vORgeAG2EHbHoH+A-PvDUA@mail.gmail.com>
 <CAHk-=wgGFUAPb7z5RzUq=jxRh2PO7yApd9ujMnC5OwXa-_e3Qw@mail.gmail.com>
 <CAGudoHH817CKv0ts4dO08j5FOfEAWtvoBeoT06KarjzOh_U6ug@mail.gmail.com>
 <20251031-liehen-weltoffen-cddb6394cc14@brauner> <CAGudoHE-9R0ZfFk-bE9TBhejkmZE3Hu2sT0gGiy=i_1_He=9GA@mail.gmail.com>
In-Reply-To: <CAGudoHE-9R0ZfFk-bE9TBhejkmZE3Hu2sT0gGiy=i_1_He=9GA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 31 Oct 2025 09:04:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg8yBs7y+TVUFP=k=rjFa3eQFqqmXDDgnzN4buzSdToiA@mail.gmail.com>
X-Gm-Features: AWmQ_bnRDX2Gol1yij6lUw-TnphkeV13i2oTAsPwXYUAWwp3tGTy0FOLWSc_Muc
Message-ID: <CAHk-=wg8yBs7y+TVUFP=k=rjFa3eQFqqmXDDgnzN4buzSdToiA@mail.gmail.com>
Subject: Re: [PATCH v4] fs: hide names_cachep behind runtime access machinery
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, viro@zeniv.linux.org.uk, 
	jack@suse.cz, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Oct 2025 at 08:13, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> I slept on it and I think the pragmatic way forward is to split up
> runtime-const.h instead.

I don't think that would be wrong, but I do think the real bug was to
include runtime-const.h in any headers at all.

It should only be included by C code that is always built-in.

And it's all my fault and due to incompetence: this was introduced by
me in commit 86e6b1547b3d ("x86: fix user address masking
non-canonical speculation issue").

The original runtime const design was for core code optimization only,
and I just didn't think about the module case when I did that thing.

Sadly, this goes beyond just the trivial "access_ok()" - which can
trivially be fixed by just making it out-of-line. It ends up impacting
user address masking too.

It so happens that all our can_do_masked_user_access() optimizations
are in core code, so it's not an *actual* bug, just a potential one,
but it's one that Thomas' patches to do the nice scoped user accesses
will likely make much more common, just because his interface is so
much more convenient.

End result: I think your patch to just use

  #ifdef MODULE

in the header was the right one. Except instead of that

+#ifdef MODULE
+#define __USER_PTR_MAX USER_PTR_MAX
+#else

thing, I think the right thing to do is to just do

  #ifdef MODULE
   #include <asm-generic/runtime-const.h>
   #undef runtime_const_init
 #else
   #include <asm/runtime-const.h>
  #endif

in the x86 uaccess_64.h header file.

Let me think about this a bit more, but I feel really bad about having
missed this bug. I'm relieved to say that it looks largely harmless in
practice, but it really is me having royally messed up.

                  Linus

