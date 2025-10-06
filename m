Return-Path: <linux-kernel+bounces-843081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C23BBE5FB
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 16:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCCFA1899545
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 14:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10482D5C74;
	Mon,  6 Oct 2025 14:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="im4Ifywn"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919792D2486
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759761618; cv=none; b=TUyQsmInVbQU9fq7FAhc6jm0u3Ipy0MMClHf7k8MW2jW0QB24s2Ww1bx7f/w19Wr1TI0HfDMaO6k0lkpy/zmKMQY+8FUa4qYxe+a07Fi4QRiGfB+achVf+1Pn4jA/QGWThOGqOcDT02MLROnQlPsAN8sqBL66WCsS4ke/JDabAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759761618; c=relaxed/simple;
	bh=EkR1H7X+TDjtCRI9KWYEwXGW5NBq3MyXaQ39Dh/nn3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UsStZkpzpIPzQMmK7sGe+2UkbymNlfE2tzr1Nc09A+OYf1iYLknKDsPVreqAWag+8OSpHRNLMwP3AmOii62TsF/bMTyS7VxscXWbuCvalcW1qGUYUyDaVSRvMQuwDpH4f4AvmtLBqAHC4p66D9fxsubDTq8gyDqwfojJ82le0ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=im4Ifywn; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-637dbabdb32so9895547a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 07:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759761613; x=1760366413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkR1H7X+TDjtCRI9KWYEwXGW5NBq3MyXaQ39Dh/nn3M=;
        b=im4IfywnSfxkP83dl8psGq2Rk2Z21zYb4jvP9nKF9vr9f3Nn2L6JqohFlgdCpyT4ui
         SNFRCjB8yvFMI7CGKmJrS/VXB1bWBqMIfcJZvFZa4qnDartVwNwBa4dvznfG7eOUJ1HF
         G2e2ITptWjR30EYsV02Yg1H2TFrHGR8XbQi4bC9NxRJveiRU75yQl8kSw1uObnrbT0gL
         l3FSe1dS2uheXAxUp25AiVvk5wG/pXZVqk6Rk14JRX9GSF9Uy4mN4pSI+oWS04AF5HJ4
         orYYatd8sXLkae2RL6M3y4FiUyhBU8oM39Kgc71VZqj5Hxpph6tb0+CvSu/njymjp636
         yNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759761613; x=1760366413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkR1H7X+TDjtCRI9KWYEwXGW5NBq3MyXaQ39Dh/nn3M=;
        b=KvtAafGaJf9a4Jfya88FEwHc9Pfpvv7+rdzuNQeVMqLMXPDJG17cpd3tIQ6IiB6Liy
         6EaaRqjyDPI8MGZhcwvuCJ6Kq5D+J51zBrYr1IrZqH9tbchdCnRfeP8xlqGVIQtAkHgU
         0BdPCRsXqGJ+LXxc7MKWo2ndlGWgd67hKZE+OmFrhmqnAiQj7gGYt5LmQQ4FMriD76dF
         u7314bKUVU2tesauZca1kugUplLo/atGN9lvvbv8Mx0iJD/lzE/6vpa4peoeCBp7Bqnx
         SKfKRqpHrwRVXOIkgEdzR82T/JA27O6hym8vX23jPN9Ta4TCjlUg+/Z/SIPIWWeSReQ5
         +z5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHtPoXlX9oVbN3FlK2Ig+P1W1GX6hUWn6uYWAyl0zhrSnWG1IUpJ8KzRgn1hrsPHlKhhX1HLgcyS4l2KA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8oPLSjiB5H4cfxhMxZImPBwNPA+Z57K4TlRv32hVQ7OozfkDk
	TMFMx381OsHAhxyTcBhDvXctmeETCeIcy1GwVpRS9yF5pBz1QanN0E8uvYmF0vnx5zN5RljzQ8Q
	/DUmP4oDbZQ7RL9rAP1GB+5XQjhAM0yM=
X-Gm-Gg: ASbGncsRiIxsqu//uW0WC5lcBcOaITkOowdS8H11kseEB2Ah2h5ZvdQYZbCSIlqzdfM
	YlE+MFAsmT8YLuRXx0vLB19di28bKazyr1BTI1chsrYMFMuSMFoyoaMGYrqCjpogwsnQlp4pz7R
	9doP6ShXssPm3vkP4YGagPUSMI1A0KpCPHc7F2rcGcfITUjMf9eBJKqVftVmsoANvrRulKiFzoz
	ThsmIXlM+YMb3WMOhBjcmUdt/O/NdcvtH5/WxsTMABPGfj7LdV6FzpFFFeJ9yJSAU90ErSciC/0
X-Google-Smtp-Source: AGHT+IG7l9FcW7nFH5wcnGqf94SKHFIJbD02eMTFgXIso7ems2/RZwPOGR76iL5Jz5L+CD+kbTGEfLyCiPawWH7oe0s=
X-Received: by 2002:a05:6402:520e:b0:634:8c41:c299 with SMTP id
 4fb4d7f45d1cf-6393491e788mr15011143a12.19.1759761612739; Mon, 06 Oct 2025
 07:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003155238.2147410-1-ryan.roberts@arm.com>
 <edc832b4-5f4c-4f26-a306-954d65ec2e85@redhat.com> <66251c3e-4970-4cac-a1fc-46749d2a727a@arm.com>
 <989c49fc-1f6f-4674-96e7-9f987ec490db@redhat.com>
In-Reply-To: <989c49fc-1f6f-4674-96e7-9f987ec490db@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 6 Oct 2025 16:40:00 +0200
X-Gm-Features: AS18NWBuQFyxsQau3P8JL_AyINiEL_Ybt3_UNKcM6OGOrGzarzlxxcIDC21sR04
Message-ID: <CAOQ4uxh+Mho71c93FNqcw=crw2H3yEs-uecWf4b6JMKYDTBCWQ@mail.gmail.com>
Subject: Re: [PATCH v1] fsnotify: Pass correct offset to fsnotify_mmap_perm()
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Jan Kara <jack@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 3:53=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 06.10.25 14:14, Ryan Roberts wrote:
> > On 06/10/2025 12:36, David Hildenbrand wrote:
> >> On 03.10.25 17:52, Ryan Roberts wrote:
> >>> fsnotify_mmap_perm() requires a byte offset for the file about to be
> >>> mmap'ed. But it is called from vm_mmap_pgoff(), which has a page offs=
et.
> >>> Previously the conversion was done incorrectly so let's fix it, being
> >>> careful not to overflow on 32-bit platforms.
> >>>
> >>> Discovered during code review.
> >>>
> >>> Cc: <stable@vger.kernel.org>
> >>> Fixes: 066e053fe208 ("fsnotify: add pre-content hooks on mmap()")
> >>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >>> ---
> >>> Applies against today's mm-unstable (aa05a436eca8).
> >>>
> >>
> >> Curious: is there some easy way to write a reproducer? Did you look in=
to that?
> >
> > I didn't; this was just a drive-by discovery.
> >
> > It looks like there are some fanotify tests in the filesystems selftest=
s; I
> > guess they could be extended to add a regression test?
> >
> > But FWIW, I think the kernel is just passing the ofset/length info off =
to user
> > space and isn't acting on it itself. So there is no kernel vulnerabilit=
y here.
>
> Right, I'm rather wondering if this could have been caught earlier and
> how we could have caught it earlier :)

Ha! you would have thought we either have no test for it or we test
only mmap with offset 0.

But we have LTP test fanotify24 which does mmap with offset page_sz*100
and indeed it prints the info and info says offset 0, only we do not verify=
 the
offset info in this test...

Will be fixed.

Thanks Ryan for being alert!
Amir.

