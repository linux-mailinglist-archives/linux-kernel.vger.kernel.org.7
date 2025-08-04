Return-Path: <linux-kernel+bounces-755349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD06B1A543
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFBF73BF013
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07880202F9F;
	Mon,  4 Aug 2025 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AT0EQzud"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DEA1FECC3
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754319051; cv=none; b=nGVychE6yOl00uOlYitOOLvduDn92ewyhExlTOTIG2cf1FmZPsLeeeFUhLnMUhFwA5PEtHGZTRzzTS9ANi4d8lk05QhqJUKFlmU/TuTFJUplE5kH33CeqKxdUjLTH4P2PFmNMcFY3Q1ux/gWkRS5BL6sm7hJTjkIbKPh1OX/Lu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754319051; c=relaxed/simple;
	bh=Th/zbNG2w/sGAVRFlv12HJ6Li/jSTJBgQ6X2ZZll/S0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AokMr7bRqr2OA0YLRYAdJBZ4Vag1CqumE+idtB2ECCjaaIYr7vV2GjJ0HIzc21DVjDfRiQFyT4ru9CKn3jQJMTrlcHwzQkevL1QY04F/KvALk6yeoD1C3f8QMJ7o9IzRlbScE9GSrOvKsRF0qtMOjxckmLReT7IqdqVqD+ont2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AT0EQzud; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754319048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Th/zbNG2w/sGAVRFlv12HJ6Li/jSTJBgQ6X2ZZll/S0=;
	b=AT0EQzudZFc49a2P6Lc09y1lku7p3iNeqCYLW+bAzspyIzKyWUIhq6gdlveZQ7WW3wIFdS
	40oPlndmkpZBEy+RTyFl/MgTqwniOm6l0m8yNwTcE2NGe4G8caH5KKTfq6RW4zjCkgY+4K
	Nktl0txoHw98oo3R7CTmSOwccJ3zakg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-i6H0hCVdMEasr-XVMGgj5A-1; Mon, 04 Aug 2025 10:50:46 -0400
X-MC-Unique: i6H0hCVdMEasr-XVMGgj5A-1
X-Mimecast-MFC-AGG-ID: i6H0hCVdMEasr-XVMGgj5A_1754319045
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4595cfed9f4so5499275e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 07:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754319042; x=1754923842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Th/zbNG2w/sGAVRFlv12HJ6Li/jSTJBgQ6X2ZZll/S0=;
        b=Y5isgxCqMye0zFBUAA9pwXVpx2z/4lKC2QiXJoNPnBehilTpeJA8W7OAjvJU46UQwk
         9wUXqdC4u8SOcYNB4oLwzP3T7YMPCgywLhhVNQDltR0PzFfN1brCfy8WM0otIUp5Kt59
         M4XlOBs9e/n6XbxmCMQ7Vtn4ZWGPzpZBDRM+KCq54KzYfurc5pbj96rAfs5pzDC5aOUP
         ffPN2OsaF2x8Aoc+YLitJvco72sooWoAsHSylpYiacvGH3G2ch1G+38HOwYud/7yuwWi
         vrEF0yDXmTa6Vj6+5tX/V65E2kAVQTi6Z3tETxvMRShMeb7mK6niheIaDoX/6zvlmqQj
         hGIA==
X-Forwarded-Encrypted: i=1; AJvYcCVpPOs5ml9W6okOYAjtnlBmsCcA7JQ1I6DPuSH4puK7Gy/KXVzxTy2eAid/QBU17iVuZfWv8Wop9qfkHxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyitdfiA8S6O9WPEIJ+WC7jaEvCceQYjS9npQvZ5Gs6MBUSjsdr
	3lzpTLhbj0mLmatTG+DKBwxFCOENHHzGEvmLeO0H3CYNi2Ybj4QGK1thIxOO35K5KNeqAWmmrDZ
	Agb0JTiTZrR/CUZG2FVxTlZHD8Mfe27t+52SBrk6A3Es0y7aMwHJ8KU7zziUNuikEyF1taHgJ0L
	3ONM9HrvfjWhXohZMg18kzQ2+ZMVp8QvtxQCS9Hji1+ztKO5CiqOs=
X-Gm-Gg: ASbGncu2aUQPjgJw/MGTu1ElXWnvRMCUDnVfgyxJJA8awkAyGnmL/H546c67wSawxXb
	7sNTxTz5mQHYHfwVvhd8PaIKwV5MWu6ZaAjotMrVAHojmCJlZmJ1R9/0sO83gaQ9MjmrpPlEKA0
	g/TeDRRocniEaAN2RwK/3u
X-Received: by 2002:a05:6000:1788:b0:3b7:94c3:2786 with SMTP id ffacd0b85a97d-3b8d94c1c49mr6701544f8f.34.1754319041925;
        Mon, 04 Aug 2025 07:50:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgsw4pwEJUoqykoSclSWi0JkSR9VtvKkMXz/zduARm+hjzykjvBGRpvCt0a+Ds377veRWW/i7OVVOUhVwFvkM=
X-Received: by 2002:a05:6000:1788:b0:3b7:94c3:2786 with SMTP id
 ffacd0b85a97d-3b8d94c1c49mr6701520f8f.34.1754319041488; Mon, 04 Aug 2025
 07:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACTEcX6oXBot1VBApOyKVMVXsAN9BsvQMLa8J0iKpNeB-eLttQ@mail.gmail.com>
 <642d439ea1be8e48ee5c47fd3921a786452fb931@intel.com> <CACTEcX5Y3PNXNkhnK1dGFe+k3sigOZNpj66KKGAS9XeHqRu35w@mail.gmail.com>
 <0b15e33603a46f6cc7ad7d09a156044f11367169@intel.com> <CACTEcX47bUd2tp=LYkQnhK29Js=vLN0JfXL8Aq6mOFBVYumpzQ@mail.gmail.com>
In-Reply-To: <CACTEcX47bUd2tp=LYkQnhK29Js=vLN0JfXL8Aq6mOFBVYumpzQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 4 Aug 2025 16:50:28 +0200
X-Gm-Features: Ac12FXwltMgUzEEB8nqMLRA_D51YfOsfFkH1rt4nc_9cVgH_FR6V2EdEIAFZooc
Message-ID: <CABgObfZKKeqMrAUyS8CB4ARkW_8Z9QREgpgYcq2jxoQ9ppS6MA@mail.gmail.com>
Subject: Re: [REGRESSION] tty lockup and WWAN loss after hibernate/suspend in
 6.8+ on ThinkPad X1 Carbon Gen 10
To: Andy Mindful <andy.mindful@gmail.com>
Cc: regressions@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, 
	rafael@kernel.org, ville.syrjala@linux.intel.com, tglx@linutronix.de, 
	Christian Brauner <brauner@kernel.org>, Jani Nikula <jani.nikula@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 12:57=E2=80=AFPM Andy Mindful <andy.mindful@gmail.co=
m> wrote:
> Double-checked bisect, looks like I've have found broken commit:
>
> > > git bisect bad
> > > The merge base ba5afb9a84df2e6b26a1b6389b98849cd16ea757 is bad.
> > > This means the bug has been fixed between
> > > ba5afb9a84df2e6b26a1b6389b98849cd16ea757 and
> > > [1b1934dbbdcf9aa2d507932ff488cec47999cf3f
> > > 61da593f4458f25c59f65cfd9ba1bda570db5db7
> > > 6fc5460ed8dd0edf29e7c5cfb1ef9b1aa04208a1
> > > ba5afb9a84df2e6b26a1b6389b98849cd16ea757].

This skip is messing up the results:

# skip: [0dd3ee31125508cd67f7e7172247f05b7fd1753a] Linux 6.7
git bisect skip 0dd3ee31125508cd67f7e7172247f05b7fd1753a

and there are still 3858 commits in
ba5afb9a84df2e6b26a1b6389b98849cd16ea757..{1b1934dbbdcf9aa2d507932ff488cec4=
7999cf3f,61da593f4458f25c59f65cfd9ba1bda570db5db7,ba5afb9a84df2e6b26a1b6389=
b98849cd16ea757}

Any chance you can get 6.7 to work and restrict the range further?

Thanks,

Paolo


