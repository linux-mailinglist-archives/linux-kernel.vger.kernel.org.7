Return-Path: <linux-kernel+bounces-720890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EC4AFC1C0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4533E4A12ED
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 04:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A1A218AC4;
	Tue,  8 Jul 2025 04:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ZQ8X/nWr"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587E01C8605
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 04:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751949929; cv=none; b=hMKRaQAqon0K2H8pLnuJ17SY8PeL47beOJGIcKr3vzjH+1xH02Wli46qsS6X4mGTtoaNbX0/Ah3EXXAxsPRRCaTCM6BIT6dFqsXK5Cqmqv3f6Xuu+9gjkKU0gEHMe+CcUXVQSfHU8B+Gd2a28XVMY/AX1sV2iAkeWvY9/onsX3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751949929; c=relaxed/simple;
	bh=cyuVu0Zvm5Ok3FJ6+scXo4j6aYvJ2vTUs+cizbFEfPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRpOuRCPW5VVzcEbB7peks74e3RgeKP7FzQN4bNQZHNKI19EKMwuLnIQKpvAkQl2mIwIrHZxYR69C24XagSS0+rik1Fd9J6fvuIthG/xsjse2LPVU0KHdAhT5J3KhHH+vEnYrKF260Dj5jeBfbZMSdouSMnNpUO54+DjQQMLZTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ZQ8X/nWr; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae360b6249fso697046366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 21:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1751949926; x=1752554726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqNJXRqxCyyydpdXfWSTJ2EExhN9/S2LJXo+S80XU9o=;
        b=ZQ8X/nWr1S4lafNfxeTSRwt7yIARs1tPBdp39WObmxjVNE04IdA9TfoGvbF6FU8Sk2
         jUSDQyx/FsQM8XX3B0WGaMd7mmX4aD1GZGoB5/h+uOGFVk5As8sjnoI0y4ZRTZbKkIR4
         ZAtvVXgoJqgxfIFAXREv68bL0Gh0ihoDHbKqpcFXzIY4RJLD25MuZPi84iA7WPKJamyw
         FmNRvAE0UqNPlE/m3bs8RrNlCXYRZb9lHklJsKsquhmuhnegic3nHpb8npmWuGprGBsW
         x3Iu7HvgmhEfzvN9P40ARzm0qncuEpAhtbhPQXSItec2LfOh+WU1XAvWemkSe13tQs2Q
         zbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751949926; x=1752554726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqNJXRqxCyyydpdXfWSTJ2EExhN9/S2LJXo+S80XU9o=;
        b=QOdMvbIKiQyIn+R/enF9QavZlLJkReuZU2vHDP3zCgxDBk5EPOPoY7rDTI69ZAYMLu
         80517r26XWxJyzbx/g4ljaihOt/V4V6GV5p5tGjq64PAXmHM2OF0Bpla3XGMZukXMDKZ
         c86EcRbvgkWjJfqza2v4Oh61aWJe0yGoR06AUww2dUFFodaBZW+91ZmD1F9fQ4iKQ5ca
         u6oegaDtsLP6V6MKnd87s4EVWx8EuJQl4qUCaOAgUfxbqWHjXObJIfipAEf5+5rMXcD3
         YrzGDHh+qaRIKoIQWuG43DRDhII4wvBrcsmLEIPibFFi9Tprzg7LZKPdB4ybdn5JIqTe
         +b+w==
X-Forwarded-Encrypted: i=1; AJvYcCX1ygrvnhcLC+JTsC3P/kdDCfKdGOISQkMBicTtBmccCe/jMz21c1yYVOa7wKz9tVxrxfBhK22S2hJlcG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI6yMfWiVGv5N6JI6CQZqixi1S6Hec0k9QTuCsJK0y36MRMsVd
	LK77xyxau4JALHsRcBxZpDK8oheckZRKGfxW5Qyn4vLpeMw2nfM12Apuimkwpw4xfs9pZvvWKOy
	Rp0MUuroZhNATagrwgdqvMYVuqPN8PPI6aqTSOsxbRQ==
X-Gm-Gg: ASbGncuJLzrtgj/B5NaS9kjG+QHF49dDqUcM3S6mrqq3WVzkOxrV3tZXkU5zrJqoH8+
	KRqPRBe9iurSkwXUqqCU4wlOpiJtDhoZ5F5x1T6Csxw7I/mrYgKXh+cB8otNMk5C3TrpSFF56N4
	PKYDpfGmRolhMROewDE5ZIkriHwfgk68No7ORFYgPqb9UfhxUbb2zqnMPKmqfE0A8OvcT5yQc=
X-Google-Smtp-Source: AGHT+IETYFQda78DtHooqQ3BAuCv43WpCt427AA99z9bQ5whlMvxg6MGcxRk/OIADdstlJE+HsC+VdHydGitg9T/H+o=
X-Received: by 2002:a17:907:9689:b0:ae0:d4f2:dffa with SMTP id
 a640c23a62f3a-ae6b055ed0fmr158366766b.3.1751949925746; Mon, 07 Jul 2025
 21:45:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+_q7--Yfoko2F2B1WD=rnq94AduevZD1MeFW+ib94-Pxg@mail.gmail.com>
 <20250707203104.GJ1880847@ZenIV> <CAKPOu+8kLwwG4aKiArX2pKq-jroTgq0MSWW2AC1SjO-G9O_Aog@mail.gmail.com>
 <20250707204918.GK1880847@ZenIV> <CAKPOu+9qpqSSr300ZDduXRbj6dwQo8Cp2bskdS=gfehcVx-=ug@mail.gmail.com>
 <20250707205952.GL1880847@ZenIV> <CAKPOu+8zjtLkjYzCCVyyC80YgekMws4vGOvnPLjvUiQ6zWaqaA@mail.gmail.com>
 <20250707213214.GM1880847@ZenIV> <CAKPOu+-JxtBnjxiLDXWFNQrD=4dR_KtJbvEdNEzJA33ZqKGuAw@mail.gmail.com>
 <20250707221917.GO1880847@ZenIV> <20250707223753.GQ1880847@ZenIV>
In-Reply-To: <20250707223753.GQ1880847@ZenIV>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 8 Jul 2025 06:45:14 +0200
X-Gm-Features: Ac12FXxgiii8qUvUobplOId_mZyl2t5XqOzi0KxyTJenDipJp-urULM8ZwIQBAA
Message-ID: <CAKPOu+9=AV-NxJYXjwiUL4iXPH=oUSF25+6t25M8ujfj2OvHVQ@mail.gmail.com>
Subject: Re: [PATCH v3 20/21] __dentry_kill(): new locking scheme
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 12:37=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
> You are asked to evict everything evictable in there.  It would be rather=
 odd
> if you ended up with some dentries sticking around (_still_ with refcount=
s
> equal to the number of their surviving children) just because in the midd=
le
> of your work a memory pressure had been applied and started evicting one =
of
> the leaves in that tree (none of them busy, all leaves have refcount 0, s=
o
> all of them are evictable).

They are not evictable, or else you'd be evicting them, but you do not.
Instead, you busy-wait for the dying dentry to disappear. (Which can
take a loooong time)

Your explanations do make sense, I understand them, and I think I'm
getting a slight understanding of the dcache code. But you haven't
even tried to argue why you implemented busy-waiting in this patch.
I believe the busy-wait was accidental.
I've been trying to make you aware that this is effectively a
busy-wait, one that can take a long time burning CPU cycles, but I
have a feeling I can't reach you.

Al, please confirm that it was your intention to busy-wait until dying
dentries disappear!

