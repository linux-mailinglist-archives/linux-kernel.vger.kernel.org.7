Return-Path: <linux-kernel+bounces-794248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D757B3DEF3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9573AA31F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98F230ACEA;
	Mon,  1 Sep 2025 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Gj1RKTFo"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA853054E1
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 09:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719943; cv=none; b=S6P/zNF3qPozoAEUZ8r1V7ls+/o9xUY1o+vRmPdydtK0EG8EIr9NAZCAJdz32tWEEDUd9875Q88Wk4r6h8ry30yCBPTN6tC2olccGCdNB1hGIpw09CoyXzbr5yAKLmL9yIZ7rD2dw4s6wuQtb93uA3XwR4R1dZMIPSVtEHp/zvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719943; c=relaxed/simple;
	bh=6t2ITYvNLE5WTPnsN43xygLJ/wnmWwmkkfyibPexe6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIQFccbGlep1efqmG32ypM38nyn9X1kE+k7zA8JjnrakzviEr17R1vXS0Y1E/hXvbCKngrQ3vO3of7OF0SVFMjtYv7e0rkdsDQaUlYk1CAuizvPpqA094162DSlytizwnvtrYAfTi+u2T/+BCfwEnojXr8mYYOuwsJ7Zr2WKp/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Gj1RKTFo; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afec5651966so122776166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 02:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756719939; x=1757324739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6t2ITYvNLE5WTPnsN43xygLJ/wnmWwmkkfyibPexe6Y=;
        b=Gj1RKTFoWLYtgb0fkHLWUDycQvXbV9POQooGz1KPyGt+TKAZ0wxjN8m5IORhOoHBZ4
         e4pch2ywyuxdtnzZoFg86BxZMhLG47p02H7oPZBzQHzbJYqJnMG5846MdTQQxkQUiA6e
         whh3T6aqv7uy7YgrI4lIbIgAaIQ+kFx3gn14KUaTiZKl8ps+paNgA8a/fw43J4FOyfEM
         qxVCaTMWzF2vDMut+6AQCHvb3sHwBFLhZTNNMlgCiIZAya5MCr/Koywsj8EIFyX5qSba
         aVKBwwcu/FItlQpf8GbtcwEAtETpKOCyocDIalRs94eqT8bEltCCGFuAdm+z0YVFErgg
         BEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756719939; x=1757324739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6t2ITYvNLE5WTPnsN43xygLJ/wnmWwmkkfyibPexe6Y=;
        b=VWUhfNHScGQpCo5TDGJpD3T3zPdLmj106782EZiTNrOCajXk/e1ubiV/svFdZ4H9+V
         XzfhZ2V2o9kKTBW9eZx8VCDltgNI5f28AX4nohmeGv53V5gTVMy2My418V/Q86ywCGcp
         HJASSLvnzDE29uJoThrLZpaga9qYsJCGmeAV8lniHGpzAFc/N0VcItXuIOUB1qRnSlf8
         cM5Lhl2cddLzMoxF/tnm3TliipHKFYebrqaWqVU4CapUmpjQ1Xf03uWBdDA9nu93Tzgd
         EOVfyZYd4C1YHXDYNHraEodrq53ikImR++cOAVt5lvLg5XNhLBjF2xRrnpilk6nPrpyF
         uNPw==
X-Forwarded-Encrypted: i=1; AJvYcCW0gpSAD9+DjmNJV2bAyl3q+4nfkQ2Lkg4wE3Sqh7/0NyUP/jTPz7SXqTghqIaDJeD2TXnJF5K5f6tsxUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0TGyvlT3Bp2hm+b86jRSJ6D2pwztz3G28LGCNQmhck1ZXeHhw
	dGOfmaJl2DlmxpIFh2BWbIuwAe04x0T5eLvwalc+lhc4kZVUOpTSBzc+OBC1S4798RzRYF9dZwz
	dZBL7tnpoePmGHmsQhOHnn8oOp/5cnVbn0GjRPlhtNA==
X-Gm-Gg: ASbGnctA62Tj6R/R0WqHsE0UluIXneG3IPLqPcWBQYRfjsH1AhJEkHmkxMRdRs5gsHY
	8H8YHzbqyQGLp0QsspzsuvloKtTKEN8CaDkV7Cngo4TzizVyi0zE7pY18ORihgys2tycpioLnVH
	mwxRu27G3rbo7hoiPOHWsOmpUdTZgt/vhl+VP/a5taaOAGYvsNgTGoZEXl7IcFYzXmURLhLudI5
	tU+rfzxMsxPjMixXKHO/ZMspTwYW8Fw6kA=
X-Google-Smtp-Source: AGHT+IG7cUupsgf9QyFp47qCVkb9CQwuGk68ny0b5Ceuv/evNVjr+pSVwxeV+0Uxnvw8DZ77eIdq32imbwuBG59+mEk=
X-Received: by 2002:a17:907:3f12:b0:afe:ea46:e808 with SMTP id
 a640c23a62f3a-b01d9793846mr587668866b.47.1756719939395; Mon, 01 Sep 2025
 02:45:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831093918.2815332-1-max.kellermann@ionos.com>
 <20250831093918.2815332-2-max.kellermann@ionos.com> <day257vhz3o7hepucfz5itjvdtp2k36hkqdg7hckqleb4jxyku@rs4rs3zhl4hn>
 <CAKPOu+-ZjNr9hEir8H=C5C9ZwbS7ynY4PrJuvnxa-V425A+U3Q@mail.gmail.com>
 <e3ec5583-adf0-44c3-99c9-5a388c43fb7d@redhat.com> <CAKPOu+9CiT-5P--6TZcyq=jHLDhCa8LDh1AYjKr69+0shO8UrQ@mail.gmail.com>
 <244b73d5-39dc-4bcc-a69c-8ae3010b40d9@redhat.com> <CAKPOu+_wQ9DDHOQDtFeXU7ZqwvwxYqXNqWeSP3zJpfC0Cm2YAA@mail.gmail.com>
 <adb9e55e-0023-44b7-bc88-ed95be8dc71c@suse.cz>
In-Reply-To: <adb9e55e-0023-44b7-bc88-ed95be8dc71c@suse.cz>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 11:45:28 +0200
X-Gm-Features: Ac12FXxn_NF7uHHkLiMMFlqOfaTSrUR87f4Qa0DhgYVGwhIKOLTI7d0lR08TJLQ
Message-ID: <CAKPOu+8wK16XWCx1+7801tyE66uLBu79CySLFetCWbS3TnH3bQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] mm/shmem: add `const` to lots of pointer parameters
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>, Kiryl Shutsemau <kirill@shutemov.name>, akpm@linux-foundation.org, 
	axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org, 
	hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 11:32=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
> > Sure, but first I need to know what is really needed. Reviews on LKML
> > are often contradictory, and it's easy to get pushed around from one
> > corner to the next.
> >
> > I just posted v4 with longer commit messages. I think that's a lot of
> > unnecessary noise that takes a lot of time to read, but oh well, if
> > that's what you guys really want...
>
> No I don't think we want a passive-aggressive malicious compliance.

What the .....
Your response is similar to what I mean with "getting pushed around".

You guys insist on verbose commit messages, or else it won't get
merged, you say. I don't agree, but when I yield to your requirements,
take the time to implement them, I get accused of being
"passive-aggressive" and "malicious".

Please be more respectful when handling code submissions.

