Return-Path: <linux-kernel+bounces-730124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E198B04082
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7058E1885859
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7F42528F3;
	Mon, 14 Jul 2025 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktzYezOY"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C968F247DE1
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752500636; cv=none; b=Rr2F5j45UgmMbVpeFKJDMvhOXdj57JToGj+9XLm2SvWb9gyRwxGRXaW3D6TYr57fjmbmwa/uHPEHB6fcW9mhmtFqbVtCiz9lZrtSu+UlLFg7O9+IgmLp8R6xUYcnwMD+Y5jG8BQ70QTcU+8mCHxNYsuwt6jqnP+xaAHynFl9ZJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752500636; c=relaxed/simple;
	bh=w1Xebi6AtT1S3Q+VGN0QLgDop3oklMeBsIRgD0Z/5Ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZZsxjzcI3dMMloQVKRjG1bLJcYQq/+yizixeLz8r2Cr+tvAsoimtRrl2jsTvI1nhZiUJm6Fg6NA4TlJ4KyWKT/h7TpeYaNSmUbFnQh+GmjGBOHQRXNHB2+EJL0HJAyDHEvrBjqYXSuqw4rkezAw8+WCL1o6UUT5oSXoz1/rDZzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktzYezOY; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-70e302191a3so39429937b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752500633; x=1753105433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1Xebi6AtT1S3Q+VGN0QLgDop3oklMeBsIRgD0Z/5Ks=;
        b=ktzYezOYfgUY/rZZ5Kw6LwGemb+EPx+Asev9S50IJ2kwEDLEzO77MQFo4M0/g4s/jT
         NDeMyWVQdRexRn9LMx5BlJIhF7lw0z1TL7ARmVfwuFT413yOzusybg350r/QhUxEQKXK
         2hx6XpvyigellHJpWuokkEPBLxXN9R9VSuNWa5iIakFB0Q65wPmGZ5Ns3qyqI+4Df5ZI
         VoAFt8mBV7ajfpFWCCUY2nwJwmNpRvFp3CfW68YF99UPWo7TZu5lGGcgSOB69WEhSoSr
         5mPDHewOAHKaxXKTLhzgDwNrI1UZgHckwX00gds4uQy1zNyQUUz4qP3jeF/X4FfKW0IP
         sN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752500633; x=1753105433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1Xebi6AtT1S3Q+VGN0QLgDop3oklMeBsIRgD0Z/5Ks=;
        b=trVYyPyf3r+hxBErWoTf6wBOtkRfDa+rtG4p1qe7ZcHf3Xn9mTREW6D53ixqdfLYdx
         9AB0Daq8UroErj5N7/W667pC8OpYRx6uhcQY7aYuQqJeGhB91+Izl636UBK1K9R0Eqdr
         mBEfzrr+Ic8sGDZDur3ttXbxL/apcCec/134pYH/zVgG2MCZLbm4Zw2hR9g/VisttDbt
         87X7mWwMP7Twuh6SGjwhW0RLAvMBleJxxUpOULdz/mTJLTusQGPXpIZMvEK5uu3PNIZY
         wsWGkbkcVzR4ehBtDwrgDhJ+SkzYTlJzb5IvKobZzqrhM/mT1H89Tq3uyJKfRYPl1Bo9
         IV1w==
X-Forwarded-Encrypted: i=1; AJvYcCWfH3Ql6/QMW98tHJQdPwbJ5EMM/kJo8CSd+iqJ/XDSdBN2NnOe1U3BZJ0Mdi/dn3+QyrLC8LouEzeW5ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS2PFVfcdXn+L0J1lSqQ8FY8hRdG3FqqgAil6sGysTA+z2zORr
	jrukC5idGUWfU3pAor4CtDZc4iy9fnj221yw3DWQ63Wg2DX+RPCeUKKGNnG8cRkO6icmHFbUHuL
	V3UXl/vpRdI7uEB9urxKaxYbImFqly+U=
X-Gm-Gg: ASbGncu1F2Sis8O5MOhj9wtuhMNI2CDXy8Yx1FAOHH8XCPLnvXKF3Htoalbl7lgJHia
	YY0886MC1pIlU1QTZe9WAeTZoZOL1QyBURPgT78hSDg6nascJSAfD3X/BN35lq4UQMXSu5yY60O
	7HIl1WqPjLySMO6eMy0teATcnRDrfiO3cWFVhxvn5t4VDbv07PGnY/sbX0qg1CX8kT848SQq3x8
	hvA5GNu
X-Google-Smtp-Source: AGHT+IHWmL583izbEWxZU0YwN1qFCbPgQ2oeUofRdL/TqaByhVp6aZPPyERBUFnYYrrAqzm5H2m3Cb2oIop2vE/Fd28=
X-Received: by 2002:a05:690c:f15:b0:70e:7638:a3a9 with SMTP id
 00721157ae682-717dae7523dmr176399917b3.18.1752500632617; Mon, 14 Jul 2025
 06:43:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
 <20250709212556.32777-3-mathieu.desnoyers@efficios.com> <aHC-_HWR2L5kTYU5@infradead.org>
 <20250711065742.00d6668b@gandalf.local.home> <aHSmIa3uffj5vW-m@infradead.org>
 <20250714062724.6febd9fb@gandalf.local.home> <aHTsOcIUs0ObXCo1@infradead.org>
 <20250714075426.36bdda0b@gandalf.local.home> <2025071443-lazily-blabber-3fbd@gregkh>
 <20250714082033.702160ad@gandalf.local.home> <2025071419-negligent-balcony-84c5@gregkh>
In-Reply-To: <2025071419-negligent-balcony-84c5@gregkh>
From: Arjan van de Ven <arjanvandeven@gmail.com>
Date: Mon, 14 Jul 2025 06:43:39 -0700
X-Gm-Features: Ac12FXwBc4nv6AeYu1ATtH4BnEVMOYJ34FvZLVktrepiKtnXkFtYMSmTAXC6fSI
Message-ID: <CADyApD3uRdrAk6zkHPDwi93bt0NMPNS6yg+_JQ9j+y3JaQYNrg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] unwind: Export unwind_user symbol to GPL modules
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Christoph Hellwig <hch@infradead.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Jens Remus <jremus@linux.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, tech-board-discuss@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 6:28=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
 > So he could just send a thousand patch series that doesn't touch any oth=
er
> > subsystem? It would have a diffstat that touches nothing but kernel/ltt=
ng,
> > kernel/Makefile and kernel/Kconfig. Who's going to review it? Who's goi=
ng
> > to accept it?
>
> Again, this is all things that we all know how to do and aren't new.
> Get someone in a subsystem relevant to it to review a patch series that
> adds the needed files to the kernel in a way that they can actually be
> reviewed.
>
> As it seems that we do have other tracing/perf developers already, start
> with them and go forward to see what they say.


and a good best practice before posting 1000 series is .. to identify
the most likely reviews and ask them upfront what their preferred way
to do this is...

