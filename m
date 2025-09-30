Return-Path: <linux-kernel+bounces-838217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DCFBAEB5B
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 00:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454E43C4C41
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 22:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC01F2D0C75;
	Tue, 30 Sep 2025 22:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4aStPfKJ"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16461EE02F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 22:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759271852; cv=none; b=pO70lLPqNfP3GxtjTK+5o9lT1XAEArtdEXPSTSbsSODFsaae2dpM0pHqja6WRcSuS1m6jibKfvPPNViNtJU+BmtoNjf6UDyCjkGexgrIpHFaH6GvIyXn3TgURegOpp6wrb1XIpMrIPDD4f9GA76utWw62uhBRNuJPGzUvMF/l3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759271852; c=relaxed/simple;
	bh=HiSU258gEuvRwD03tvF/b7uusp9crc7Wt4cFeKzPiM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BYZupReMVhgCvXCQZDXL5Yi971FKIcoJK/IihNYW/SpRpr44MTigUvqWSb2t1ZVOrVvPT/DXeGkDH4qkKiPGmKk/EqbfMUfwKiKhXuujADuLcbRUbjk5/H6vyufOl6qKijEJ8zoMasG15eTUpCucBbv+uoVx7LuyFn0LH+yJtwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4aStPfKJ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-634b774f135so8905856a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 15:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759271849; x=1759876649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiSU258gEuvRwD03tvF/b7uusp9crc7Wt4cFeKzPiM8=;
        b=4aStPfKJyOwUk4c5vtS/dceSZZn19GXKITIP6stpkSxHc3RxQexxzI3hUuquntJnfi
         CJUC9YvnI1wMNgyDc45XrB26zywCpWCg0tbeegbQe0/Rg5LL7yHtgIFMbhQtDTzZwGRa
         CyzqJFcylRCqaIHH+5Wbo/QIc4uKkdGAsm274H0qtgXoE3OcTOlnZmXR1gQaqNZT3SS5
         7kJbwg0gK4VJy91RggIlmCLybtJvtKxAOJGHp/IoaogRjrr/dMjU+YeMgG+ppNFkKcdU
         /BqpZglHfQp1kgZYVO+axTbt/A2JCaEgfCrGVPrcvlNHtOh4oHfNQjOl0q8EOMdWHRY5
         ZFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759271849; x=1759876649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HiSU258gEuvRwD03tvF/b7uusp9crc7Wt4cFeKzPiM8=;
        b=kUYGKl+uluBy/qTS4I/B/rJiVB3pgFUsDDnP8ApHMlIrRsD9MhjzHekqdzidNA5r9a
         Hnqpi5rYjciey43PfNpD2flrX43/nB9yAltME+uZ7SpGcCHbXHeaZjOadv4aHY1b8Fsq
         EUZu93JK09pQukigPRJuHzxowgM1ZSuyb9FkKdafiagkn/7GM1hdX2M7pm/5V39zQ4fu
         N905iaTvIev8B6lIpM/X043pr5cbjbXrpKbEhjsZJa6AR7WnLhrjQ1/dyui/XjCSqrZw
         K57yeEb5y7vz4dZOtxanFVfZgYHiRqXHsMBDX7Xoa264k78j6r6835dSCoTldVKQOuXa
         aomw==
X-Forwarded-Encrypted: i=1; AJvYcCUKLufWaiQ2VYViQ5zrpAClLwDkqy6/WHfEnZ8OuCxR36syjYKBw5EmnnaAf/6PK9d3Zcs8MIcMzmn1y/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZdLnTCq5Qt+AYHZzFuJpP4qW+shVmKROHUrwLT32nNCISiwZ6
	UtHfLV9OVR1jIZkOQ19byQXj85Gl6FeXYKksP21/DSllrx+6fqZn+DDK61SKdCI+SvD6SMiJVN3
	oNulSt2lUh10qN8uZ8IXI9gL3LTvmmBSnjprhHKHA
X-Gm-Gg: ASbGnctZiRAIFAP/bhkcMV3zIg1u+Ar6txoKGKEGOs6qUNyZqpGz/j1fV0kbGu3C0s5
	o6Jmpo39WWyzZcEhZDL+GN7QdEPgu12JZQB4LotqzOTkZhAtWeINJkSy0TTQvY9Lpwtn2aM1SyQ
	kdDT5xv+eqS79RmstsXZEoRnMLT+tcgT+w6k3i/DTddv2XcAEPeahSK5+2aYzPSgSqdCxyJMHNE
	Lxt7aPMbnokBR31qGbUN4HxHE/PZHZYjoKMrpsDCjdEk+hkq1z3Zk8xfF4LxrHB8+SA8kt0FOpa
X-Google-Smtp-Source: AGHT+IFhTLsM9VWajQNAcvfDSRfiJKQsQdakG+/xw1ybWNiHCG3MR95bnTzqAS3/FEkb1vCHOW01TN0UPCnaVkJ8TL8=
X-Received: by 2002:a17:907:2684:b0:b3e:f028:2d57 with SMTP id
 a640c23a62f3a-b46e9e45915mr146021666b.57.1759271848783; Tue, 30 Sep 2025
 15:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911185314.2377124-1-wusamuel@google.com> <CAG2Kctqf=Q+nuuDqzkrOpjp+tOttf079DS_R8Q0pHU-k8DmFvA@mail.gmail.com>
 <CAJZ5v0gtKmtiLQwi-2qaw2G4O4PF_iqz6UbUZuaknepcJ1ToZQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gtKmtiLQwi-2qaw2G4O4PF_iqz6UbUZuaknepcJ1ToZQ@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Tue, 30 Sep 2025 15:37:17 -0700
X-Gm-Features: AS18NWBHp6syKIsOWMv8Q0jCQTPbz8FkUeurXM-DWYEWDmRvZzl9bUqKzPeWAN4
Message-ID: <CAG2KctrK0JrP7JNUyzF72JeDgR4-GSRmJDe+yEnav=gQCAf64Q@mail.gmail.com>
Subject: Re: [PATCH v4] PM: Support aborting sleep during filesystem sync
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 11:51=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> Hi,
>
> On Tue, Sep 30, 2025 at 8:30=E2=80=AFPM Samuel Wu <wusamuel@google.com> w=
rote:
> >
> > Hi Rafael,
> >
> > Just a friendly ping on this patch. Please let me know if there's any
> > feedback or if you'd like me to make any changes.
>
> Have you seen https://lore.kernel.org/all/20250909065836.32534-1-tuhaowen=
@uniontech.com/
> ?
>
> If so, what do you think about it?

I was following this chain
(https://lore.kernel.org/all/20250908024655.14636-1-tuhaowen@uniontech.com/=
),
where there is some ongoing discussion on converging the solution.

Our changes aren't mutually exclusive, and tuhaowen can build changes
on top of ours, even indicating:
> I'm happy to work on this as a follow-up patch series after your changes =
land, or we could explore a unified solution that handles both scenarios.

These patchsets don't negate each other, so could we decouple these
two patchsets since they address different issues?

Thanks,
Sam
>
> If not, please see it.
>
> Thanks!

