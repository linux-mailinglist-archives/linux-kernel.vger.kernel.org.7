Return-Path: <linux-kernel+bounces-819843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3414B7F58C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6533AB71E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 01:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19BA21B918;
	Wed, 17 Sep 2025 01:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l12U35td"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0EF1C3BF7
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758072151; cv=none; b=IOvCWXerssOL8yOBf5UENv3Q0cci+DkMhzVwgGGVn3/9nkLnumSlRkKrTmhOsJ/IwKqfY12Hz8MQdrc6uzQcN6FsdBiaZTBxk9Gl9z5e5zv0NGyuRO/f8D1Mh1kteyo/gOyU4rvcorBwFQxqwn6Xjvnf1vMbKjGBY4krbH6fmls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758072151; c=relaxed/simple;
	bh=rUwYUfEVwgtherHE5w2Lq98za4Mn+0GYvGErylseNA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4dJ1Fx4e9nKHpf/D0/YwJ1Q42ZYnbZktZ4ZJPakJlLy+qheCw1DCqSa2HN2StnyfpRncKTdQPTCmPTqXMqNkasF92CGtIeXxgUtNv1BvYsRfleQSKi7+u86SOks9l/qx+EO/ffI59J6iEggx1z0RHuvlBK6rbOvCQ7I9qS0UPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l12U35td; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62f4a8dfadcso3487594a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 18:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758072148; x=1758676948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtvpRw2skwIDYeLYnJtYbENzaRocLr8itc+rc0AxN3I=;
        b=l12U35tdBy+CEfeOgwSa5RZGhG9ps4GzXotEeYBCc743an7P0JKRekUBh4TFcmg5ij
         70WRaJEAHcXuH/A5Ws2ozJJoinRs2JEE0+FosZ8Q4sigaAOkM7XiBP1GV4ch4zVXxjMm
         1PpdcLa6uw9i7NZ01xPshNc9qC4kFqlk2wGg6ZP+xxOZ/1l7lyrFhBdA196TcQW1K89A
         ZQHDvGi94kbVW4MUx7kKmRbNEYZ6L6+xaY74m7h8iC5XXgRmJyShayfMkH8KqDBP13M2
         GArTdTLdbRh0w7zNXWL9zUn3KLt0eJpYz89KI94FxWqwoEUmOyQJefjWn9OYmV2JWBOI
         Tz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758072148; x=1758676948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtvpRw2skwIDYeLYnJtYbENzaRocLr8itc+rc0AxN3I=;
        b=eStb6AKfaKg8OzaVW4D004cFTQsUSanWs45XezdsFCqxZ7L2/BRHiqOZKoG57xi85M
         D1Y2OuwJUyOuVgzwAOIS08nLxRQQ+baSUaSbU0ACoesmOSZuowRX8O02DZQDR+DJ7Mg2
         KFaZeaJ4im7jU6Pcxms/VkhcM//rktFz8sWwwC3OH/1zK/cIuob4g3yPyYnRYU3lijXw
         Rp5IIuvl2gHDKlqDFf1jdgSBPhU4oUwkzreX6VzW6qGBzJcMFPfV4924/H66dVjL9Efu
         WEoeAyJcj+DDhq8bwgDX2UcS4jilePwZuwkr3AL2PQb/aPTcAUcJk/cfBrkHo5DxndAA
         bXCg==
X-Forwarded-Encrypted: i=1; AJvYcCXF2CkR6ydZWvyunYeglRXtXRUj5gV9iOEftpQoAofknPBP0vm/8Pzr4F5vo2X2Ji2nVE7dBzD89aycMeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzvrLyefZkm/x3U+Fi4PVzATi96neFE4CoJl3m+0EholzXXcew
	RB7Ukvp9fFK4/8D1t9aQvc6pilwQxUrZ350+IdlhjJgOQSB8hCGW9d6USpo9zaGv4GshYfXY4k/
	w8k/nkPOYPGoNMHHoxcMHAwZ0T3SlStFMnzTL+aiL
X-Gm-Gg: ASbGncte9bUP/eLlYuiEUqz+rJYJ+IXyekx8zIVxj9ATiKstyVPXFpfTgqM2jDBVqxT
	pr+df7qhm1qZ2/YM50WTGU6Z1KqsPTZtMTOq8tH3IBAm2WKg7nmdASvK6tLAKppN/nJTh0celWN
	6VMwkeMXqwVBvFHtDg+7VSMZ0iSJv4MpfNEy1l6mZIOavS0/Nx4fknfOQCwtDcShtz5vT8Cbl/i
	HyF2sL3FtoYJXFnPpc3SLG4latm/SHMICBoJFGsz04nmT5PKr7C5NL5CdJZp8Fct+/1
X-Google-Smtp-Source: AGHT+IF3cY3woTYDfHAOdf6v8U3gfZQ2LkEiVSJvH8VmNjR6wN91SZk1ZTmjg3Ky/uZkx3qvCsBnZl9tkp2OSOIY83A=
X-Received: by 2002:a17:907:3f10:b0:b07:dcc9:1186 with SMTP id
 a640c23a62f3a-b1bc30239acmr45850066b.60.1758072148051; Tue, 16 Sep 2025
 18:22:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825195833.226839-1-zecheng@google.com> <aLKpmcHtdyaqzunq@google.com>
In-Reply-To: <aLKpmcHtdyaqzunq@google.com>
From: Zecheng Li <zecheng@google.com>
Date: Tue, 16 Sep 2025 21:22:15 -0400
X-Gm-Features: AS18NWCAA8jZTc1dXpHLv__FqTlwongv36MmfPHCHni_ZGI0wWlu5HxlQrx28O4
Message-ID: <CAJUgMy+wP7t3Ss=JLOXDaxkLTZZHkirT5CJrz27K=HYiKU0ocw@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] perf dwarf-aux: support DW_OP_piece expressions
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 3:34=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Aug 25, 2025 at 07:58:33PM +0000, Zecheng Li wrote:
> > Support variables split across multiple registers or stack locations by
> > handling DW_OP_piece in DWARF expressions. This enables correct matchin=
g
> > of such variables by iterating over all pieces in the expression.
>
> Can you show me a real world example of these variables?

An optimizing compiler can sometimes split a struct (mostly stack
variable) to multiple locations, or even optimized out. DW_OP_piece
describes the location of each part. For example,

DW_OP_reg2 RCX, DW_OP_piece 0x4, DW_OP_breg7 RSP+28, DW_OP_piece 0x4

The first part is in RCX, the second part is in the memory location
RSP+28, each of size 0x4 byte. Memory access on 0(RCX) corresponds to
case 2 and 28(RSP) corresponds to case 1.

> >
> > There are two cases for matching memory access on the target register:
> >
> > 1. Accessing a struct member:
> >    - The type is the original variable's type.
> >    - The offset is the sum of the piece's offset and the operand's
> >      offset.
> > 2. Dereferencing a member:
> >    - The type is the member of the original variable (the member must b=
e
> >      a pointer).
> >    - The size must match the piece size.
> >    - The access offset is the operand's offset.
> >
> > This change improves support for piece-wise variable locations in DWARF
> > expressions.

