Return-Path: <linux-kernel+bounces-749511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C16B14F46
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 099473BAC9D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04801B4233;
	Tue, 29 Jul 2025 14:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BoxQwcv0"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC401746E
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753799574; cv=none; b=teAEI9hDKil/qsu0ANK9UhhJnEy52C9mgNP9XtnfMGtFdHH5iX6YWTCda7EqB5N9LiIJjV1K40LrLG2jKwbs39CYETERmRFN25OckXIlQMeMB5/3T+91usTV0lFZQXK5QAqm7ORkU2VumgjcnlVdEhQQ/2Eo9reAVTgIMcx5vJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753799574; c=relaxed/simple;
	bh=IkWDWoBJij9QguNEy2BLwcRd1oNQ+Yf2WDd1Lv90sME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DgP2zl6a5ualchl1NIgmXxJ1cLEedFyDUfBrRSmLHi4LyStOif/rAG9ByB4ipAxvU9gfnm22aDTrB8NA+4dBHjkNtt0Ly8ASgGD/zE0HYLV98hJ9Jhx2CAs0qUikk3YvB7LTTBpbsORtoxSmfIhjydx1m80iA+3wsL/Ng7O76kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BoxQwcv0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2400f746440so23397925ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753799572; x=1754404372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+wwvR9XBcu7AuCZWcOhUdwzQYu0UbSfxifoPaySbFM=;
        b=BoxQwcv061qc2jgIJiM8OESKrnNpJiKmMyTRCP0DguvmC1uHmFG7fjw4g7nkjYkcVq
         GUDBsHXCrbGUmhWmMbKAc8iwTSK4odb2qFSnbgvHMJ3DaRkCFsWdIa7coU7ba9tyYAan
         AOX8A5Nnt1x/0AGdt2O1hDEoGhSe3btqziAVrlSWmicjcRmOLaMnjAlzKyjAek9/7WVh
         gB2eYSMakx4REbPmFhWwc0BOy5M4qotH6aaKTFkdv/9T/JLhETpuG5RE7VWzrt7GEDVv
         VlMv0KTutTkhrtXcXQ4crHrapKVwprj3hzeWo1yym7nxPpfUGJoBf9A5fRHFIwUSv3YO
         RwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753799572; x=1754404372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+wwvR9XBcu7AuCZWcOhUdwzQYu0UbSfxifoPaySbFM=;
        b=itMjJc3saHZwEGIUzoo9H5VQHhr1/Hod7H2QSdklxnQBYovR4fMtgiZqZ2cE1BaAK1
         Pd+v48CTePBtuzm3FBc8zJMWOIzELqeGyscK9Bsj3Um3plu0nyg27ORpaacCz8IAomqi
         y2G32/PR791BZEYuNqMOpe7ieDqsu0OseLgBXmVO5vi9I1C1a44YkR9AVYsZbsIiz4sm
         7ceVKlX8L2X8JvTvF3e1fCyY470SFcWwvFm/LeUxm6VjusDQn4ROd8MzXo58Xrz7miIR
         4lAWYmOH7D6y0o8jWpS1NAfElFIYr4DhgQexwS8ykD02fzcE0l2fLpSLkP4pDK3603XY
         gRbw==
X-Forwarded-Encrypted: i=1; AJvYcCWLeV4LWospFXV5UI4ezk033tlVcHXTQGzfltYZDatb0/8c6fkFYMXVPurYnzYlHGpM5oRDyiq5aKEtiic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws53UiDBZXI9tfa6Af4uK41R6xGpCvhIY6PKubDaNdWIVYbwQ2
	hq6VD76mrX/fnUZMytjSGJdkresDzCJw0SSNo1WMLIZFiYnXS5dYSSRuhXHlzgW+RY9TjUY0btO
	oxHFqOfJcTMhseTTw2Moi3OxDwBS78kVr30KBKBDH
X-Gm-Gg: ASbGncuwMfWC3K6umohPdM/aaJm3FN+J2RG/MkbNLzG6zm657diFwaXLNSNtbAm/qPb
	5MWwxlp+k6CXa23s8+fOf5NAnm1WhoQHenT/+2JReQkoVnW96wrOMm7eQ76aM9niCn/i7Gi9qCT
	M7W7DU0GKibpizAQyFLUxgZpbL6OIT+L/Qb4eRipODMGb1DcrH0MM3TlHcezFdtsbzmdNLcBzuS
	BtSVejgUun8yaI/bfs1yd/tPRiPuhj3Tm0kew==
X-Google-Smtp-Source: AGHT+IE7MiES2oe3RwXD/66vyjN0XONK+KyAUiDIPKGMvzeZrDPZco5j81quzr1sKyyqDWkf7UzIPuxaMj2+uYikF8g=
X-Received: by 2002:a17:902:e541:b0:23f:8bcc:e4f3 with SMTP id
 d9443c01a7336-23fb30ab8bbmr264814415ad.32.1753799571596; Tue, 29 Jul 2025
 07:32:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6888d004.a00a0220.26d0e1.0004.GAE@google.com> <20250729142512.GBaIjZyNHliBrvMFlo@fat_crate.local>
In-Reply-To: <20250729142512.GBaIjZyNHliBrvMFlo@fat_crate.local>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 29 Jul 2025 16:32:39 +0200
X-Gm-Features: Ac12FXyPEzOuhCDq-_uexdLqH6sqlBvJ-ZCNhTVCp5bHN-HSk-0PInEHo01_chE
Message-ID: <CANp29Y4cTQD0EB6pTHgbbrja8ExxZuoz+RRLDY1ua+FQ=EjJ9w@mail.gmail.com>
Subject: Re: [syzbot] upstream build error (23)
To: Borislav Petkov <bp@alien8.de>
Cc: syzbot <syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com>, 
	Ard Biesheuvel <ardb@kernel.org>, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 4:25=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> + Ard.
>
> On Tue, Jul 29, 2025 at 06:43:32AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    86aa72182095 Merge tag 'chrome-platform-v6.17' of git:/=
/gi..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D171674a2580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D3816ffa0a2b=
ab886
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D5245cb609175f=
b6e8122
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for=
 Debian) 2.40
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com
> >
> > arch/x86/kernel/setup.c:1251: undefined reference to `efi_mem_type'
> > ld: arch/x86/kernel/setup.c:987: undefined reference to `efi_init'
> > ld: arch/x86/kernel/setup.c:971: undefined reference to `efi_memblock_x=
86_reserve_range'
> > arch/x86/kernel/cpu/mshyperv.c:496: undefined reference to `isolation_t=
ype_tdx'
> > ld: arch/x86/kernel/cpu/mshyperv.c:494: undefined reference to `isolati=
on_type_snp'
> > arch/x86/kernel/kvm.c:600: undefined reference to `efi'
> > ld: arch/x86/kernel/kvm.c:600: undefined reference to `efi'
> > drivers/acpi/osl.c:210: undefined reference to `efi'
> > ld: drivers/acpi/osl.c:210: undefined reference to `efi'
>
> # CONFIG_EFI is not set
>
> If that's a random config, why do we care?

It's not a random config - syzbot uses a set of fixed kernel configs
(most without CONFIG_EFI, as in this report) which used to work well
before today.

--=20
Aleksandr

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
>

