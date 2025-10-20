Return-Path: <linux-kernel+bounces-860769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CB2BF0E3A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249D11884CC7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C1D1C8611;
	Mon, 20 Oct 2025 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIIga+L3"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996D51A9FB5
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760960413; cv=none; b=Ht1CWWh4RTM/N/stVfhBvMcO2PYRzm1tOuAPVc7yGo619KP9TgomegqDtEZ/DBGdmX0hq+jyc3Hk/CyegYIUqUPk4mmcm+4fUeVclI6JrCpAmEC6t0FEAeOHFQG8h8xKF5YhpgfeUhNoBdX6iRgzCLIuP0LEwnltdJ6AMiR+I9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760960413; c=relaxed/simple;
	bh=N6Ub8U07IBy/fuFEXEEof+xicUbburBe/O/bkAp8JYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ay11aZbh8a0rl+/JACkqHrNreOXVIAvXBDEvH2eQMBXfJgYrlDRm9SwtoNA6J/QzduFDbExaoxBnlw79BOA/2UjK+V6lgr3MVEhpEaYN6obtUQ9IYmoNVIpcC3lkdBZqF7dlGKS2eOzH3Dtkn/J9e1xxa30SH3DcblLUwPmqj9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIIga+L3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-26987b80720so8434785ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760960412; x=1761565212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6Ub8U07IBy/fuFEXEEof+xicUbburBe/O/bkAp8JYE=;
        b=BIIga+L3efe61QDuCYlEaF2PxEbSOla3K2niXJE5iaNrolmF8ecp3OsuTB8Hf95WVq
         FuLp37A5lBK4KUut1xsHUfLX8ILrWL3AovT6IZlzSfCwD3raJ/msRrh6A0LJUzzT+eC6
         6rGcV8K5RAEOi4a5CMQcgMq4nwmlt8a9Mhh4CaBoXsTgZaNVz92aYc19uhT4QzMJnFxH
         o25wVXUsoDM0G/dPOwDuCNJ0LxUpI8jqMj+fqy6PoW/bKILS7QJscxaAlgDjl4CYcmeN
         2zR446im9oYT0rVk++1n9ZnJ3oIlfV9sCNYEQD7qTGyNAJhaUocCJK9awaZOA2kLyTrI
         C+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760960412; x=1761565212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6Ub8U07IBy/fuFEXEEof+xicUbburBe/O/bkAp8JYE=;
        b=Lv5ektDtVO0ksAWyXMVr1lbGnIG7jRv+2XFYXIYB3Ne1x5C16DQZVOGvi+WGY9xPL8
         jyTU5BGqkh2VwFRRG1GlI/nlGME059GzJWWOxwyZmmvv6j6wi9GYRpWKR40Y1f/xXicq
         VCq2/eD+M3ZcappC8gQD0vaGIv1DgKV6DLFFp/2li7L+4ZpwcyiizePt79KhQDKmTsRC
         OU+HDdMF9vOJhYnc2rXS2gpTeJNjMLluVq9oDsneNIGCx71sXE0wE89nDnsRV/LQmEEB
         2Zw95svyhCUA362LBJSk9rSky5K3JdwtR4Pk/TS5uARSlmo6JgGo8q/vWIvL9X6esV06
         EiCg==
X-Forwarded-Encrypted: i=1; AJvYcCXvhA+EYNGvQqunTDc900/Dhbd0QVWgJO8K2+WadnPCvjGbx2rq+Tf+obh1ZTjud/BZLG2MPQGcGqEJHGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcPxsLL6LENtYNV/W5ftLuc+Pf6eBmgoSU0kZ+c0OXfiG7H3Uz
	1up0QXbOy/IXnnjbdkUd+ZTQG8yAoX9WBxKh96ZFkCdnQzZOT/AmlqlNytAmsujHn2aTNkCOc9i
	gN0pTgNCz8sfLqBMjY4i3w8xUuKqzEOgOUKnNnjI=
X-Gm-Gg: ASbGncvVE6BjBkDoGLtzooV1fF01EshttqmLe3A9VybF1ccvxj/jlxoD7Las8Zlg+Nj
	OthQ0tDuCmAGQr9zUa7SPXaMIT9yi5xuIP5TJjyuWvzHxEkEsjKk4nx+vKLz4C+2vEcnhF5lGvR
	LFzyuViCi12WavC2sNzNqv099TnUGdt/nbeJJyFo+2k3AC7VJOJELZM+OZwI1iqv6HB7kO0gd1f
	ARS+hAJBNkcBttXvav3qlyuMg4hGb8EMByCwEhUCOvdSRRPcpfq1g3zBXv1rbkAlkJKD6qsc+aj
	o2JB11W5PGCLUiLfVwR7D0jJJZeLRek4bMnpNcSTSZLvxi2f4QY1MHljpTukf1A5t4RMRbMPsGG
	MiufI5GlpkrYwPg==
X-Google-Smtp-Source: AGHT+IGSaSv8hgjno7iKSEHfDTg6K0zXC9sATuT4+4URstT3UCuS9sw6Bz3LqHlG6Dl1DGsrxosXOZgOvaTzVn8NlvQ=
X-Received: by 2002:a17:902:eccd:b0:290:ccf2:9371 with SMTP id
 d9443c01a7336-290ccf29388mr104445095ad.0.1760960411889; Mon, 20 Oct 2025
 04:40:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020123907.13e15922@canb.auug.org.au> <CANiq72kHWgsvmxPYSAHpM5HaxCSf73t4NkPsBRXiPMTTe_u51w@mail.gmail.com>
 <2025102057-wolverine-morbidly-7f51@gregkh>
In-Reply-To: <2025102057-wolverine-morbidly-7f51@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 20 Oct 2025 13:39:59 +0200
X-Gm-Features: AS18NWDQjEalVX5boZ81nA2NT3g9faKnXRAIFq7BBrOXYhbDJGLsy1YiU_9WypI
Message-ID: <CANiq72kBYQM+McLJUVedsC_ZoE90EG8mkAMcQDKHgUhaAip7Ww@mail.gmail.com>
Subject: Re: linux-next: duplicate patch in the rust tree
To: Greg KH <greg@kroah.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Miguel Ojeda <ojeda@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 7:30=E2=80=AFAM Greg KH <greg@kroah.com> wrote:
>
> Yes, will send those fixes to Linus for the next -rc release, sorry for
> the delay.

Thanks, no rush!

And sorry, I didn't mean to be pushy -- I checked the last pulls for
char-misc-linus and saw both -rc1 and other -rcs, so I didn't know if
you would wait for the merge window.

Cheers,
Miguel

