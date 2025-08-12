Return-Path: <linux-kernel+bounces-764449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9D8B2232F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA043B4013
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260122E8DEE;
	Tue, 12 Aug 2025 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CI8PX8iM"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EB51C5D46
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990832; cv=none; b=a1QSBMIgx/ICKrt1DIjRMFDugive9MNkv4On/R1cuHAWWDw2KtO3tBg7HhoKAKU3CgLyERf7Os8B/WrpiL7teJ7jwkPnEdINDEX/xCgLuz1RD/y5C1aePyaYKiFzhSIO5g4bTprG/pLZek6lkZK6h6ZSC45p7yBunl3FZRdTLnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990832; c=relaxed/simple;
	bh=EQiCMrOW6d0ack6Jt6caSgsfJMbni5eEelJcbz45kfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e9MRCFpVg24XF2Oyy6/7VgO8Cu6AfFllRqVvH7e6dFeynqO2pFl1pLjzULZFKhw28oCY79iP2yBlQeWLdPyhcrt94vDHUM7u7d9oi7EX0ZPkWU04WrHwnYeTa6fUA4lo4hREMkL6mkymNpwxRLDe3YBBJFIeEMzSeM43Gqn4KeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CI8PX8iM; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-708d90aa8f9so55557387b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754990830; x=1755595630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbNnZigL96XkjlyiZZXbbetrtilx16GXfj1hRtZynwA=;
        b=CI8PX8iMbLj74ca6ygw0BS6S8YXFLDPp3dKDirP6aL6k4RUKs36rdJgKpWZofMoF/D
         JxQdWIpkOUexFl45pocoSvGOkihceheWZcII0lA97J/DzRX4SUDpZrKYlnROez1bAyXi
         tU3EVRz5uf8dGWQWqdmO0D4Ym3t8NkKHC4UCLjvyK+8aanYIcZ1cnkUBL23mBysxLaz3
         TIcqDqnJaA8IuJmSG4Xw8P6SPbahYEdV87ISFyNikJu9P5/htZNhdCN2AUfHoxlay8Vp
         lC5HxK5OKuCngWYxvfBTWxTUx5b4duC8a8DA5ifbprlHiDqJIPjZ59DQddQLqMspjDAL
         pgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990830; x=1755595630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbNnZigL96XkjlyiZZXbbetrtilx16GXfj1hRtZynwA=;
        b=N0t/dsUEyoqdPwHYUaO0eNCfjeEePtaH9bZzQY5XyESNEItgc/MuLezSGfKCHExbL3
         L+N/mmJ/IygUBzqeX4JlIir46yuPhy9J3zy4eHPBNvVFl6GorLKVgiPNK6dIoebut7ri
         8CxTwbO4V4oGuqZtIyE0/ttxcYpD3M6URyeMQzgeWWV9pdW9iEDXBHHt+4EnOMXeYcgh
         SweVi1nSCbz8pqFlGG/Xcpn7o9+Cc0SYtQ7RG6Jg8yKVxIitk1QvCOK++YOlW+tyoxiu
         9bj6pptzhIhysPDFnzKSYSVdlD80GFO0mvOnZdV1KITv80qfmqMwa45g74qTLTRkaFDK
         M3aw==
X-Forwarded-Encrypted: i=1; AJvYcCW/dc+rVyL+G7Tvz1VnfKqEsdekn38wJDk55Eop2VYqfmRDHiXjuoIYph36GPqSUw2XmTwwhaMxh+n3QzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU8DL+kZNdZ7zsySTrCgE8x58BDYV7AjNjOzvzarxhsemVtkwF
	zriwKE78rMwuAC7AKyiRS4ENDZSgt3O/0xVIj7TQ9c0zYw8H4SteBwQ0Wj+ERNMdIbcYJ/1QHoT
	yfMBFC6KmsVaYHzgQI+WkEBqqgxE1C9n5RcHTXqvm9g==
X-Gm-Gg: ASbGnctX12FzfY7NqNj2jSHGMBxbdpe2wMKLzjvRF17QffsTiKPIZh8aODbe/k9IoZN
	x+nlN9HAEs8Z5OHfe9OWPH3gC09Bh5+/TNEMrQc5aOiMXtSK4aRLLxTVD+kuKRvABy/EJ1803fo
	suDu2UkNeJTTkmfXRDDgWh24E9x9qsOSEXBG2GkzXN1B4dHe94XyPvjvNNp2Zzj9UkDCQRPQXkg
	6m88zmS
X-Google-Smtp-Source: AGHT+IFNHyi9PkglivXNoVBWj4TyIoB57VF8R/kbQ4uy2Cl5XiB1zv2NfrPbzHVGSmscBPhn3nbLKKjwbESLvohzgkA=
X-Received: by 2002:a05:690c:2609:b0:71c:530:1450 with SMTP id
 00721157ae682-71c42a3efd5mr27229697b3.21.1754990829669; Tue, 12 Aug 2025
 02:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716123323.65441-1-ulf.hansson@linaro.org>
 <20250716123323.65441-2-ulf.hansson@linaro.org> <CAJZ5v0iq7UODJ83fkwnzfFR3HpG2_R-YRnip_cLwyUHZZ+rXyg@mail.gmail.com>
 <7hldnp6apf.fsf@baylibre.com> <CAJZ5v0j=9RXHrcVEBp0yy1Ae4_kC1y-WFQyBf89r3NtoL-tYQw@mail.gmail.com>
In-Reply-To: <CAJZ5v0j=9RXHrcVEBp0yy1Ae4_kC1y-WFQyBf89r3NtoL-tYQw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Aug 2025 11:26:33 +0200
X-Gm-Features: Ac12FXwwaNXc80cBU4vSzIIxgYvcERSkmEn1P5fKOYJFDUVvl_f-HYgIWyz5FVI
Message-ID: <CAPDyKFpeVF_EHJDQ9u=LDuJ56g7ykYUQWHXV2WXTYLa-mYahVA@mail.gmail.com>
Subject: Re: [RFC/PATCH 1/3] PM: QoS: Introduce a system-wakeup QoS limit
To: "Rafael J. Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@baylibre.com>
Cc: linux-pm@vger.kernel.org, Pavel Machek <pavel@kernel.org>, 
	Len Brown <len.brown@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Saravana Kannan <saravanak@google.com>, Maulik Shah <quic_mkshah@quicinc.com>, 
	Prasad Sodagudi <psodagud@quicinc.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Aug 2025 at 21:16, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Aug 11, 2025 at 7:16=E2=80=AFPM Kevin Hilman <khilman@baylibre.co=
m> wrote:
> >
> > "Rafael J. Wysocki" <rafael@kernel.org> writes:
> >
> > > On Wed, Jul 16, 2025 at 2:33=E2=80=AFPM Ulf Hansson <ulf.hansson@lina=
ro.org> wrote:
> > >>
> > >> Some platforms and devices supports multiple low-power-states than c=
an be
> > >> used for system-wide suspend. Today these states are selected on per
> > >> subsystem basis and in most cases it's the deepest possible state th=
at
> > >> becomes selected.
> > >>
> > >> For some use-cases this is a problem as it isn't suitable or even br=
eaks
> > >> the system-wakeup latency constraint, when we decide to enter these =
deeper
> > >> states during system-wide suspend.
> > >>
> > >> Therefore, let's introduce an interface for user-space, allowing us =
to
> > >> specify the system-wakeup QoS limit. Subsequent changes will start t=
aking
> > >> into account the QoS limit.
> > >
> > > Well, this is not really a system-wakeup limit, but a CPU idle state
> > > latency limit for states entered in the last step of suspend-to-idle.
> > >
> > > It looks like the problem is that the existing CPU latency QoS is not
> > > taken into account by suspend-to-idle, so instead of adding an
> > > entirely new interface to overcome this, would it make sense to add a=
n
> > > ioctl() to the existing one that would allow the user of it to
> > > indicate that the given request should also be respected by
> > > suspend-to-idle?
> > >
> > > There are two basic reasons why I think so:
> > > (1) The requests that you want to be respected by suspend-to-idle
> > > should also be respected by the regular "runtime" idle, or at least I
> > > don't see a reason why it wouldn't be the case.
> > > (2) The new interface introduced by this patch basically duplicates
> > > the existing one.
> >
> > I also think that just using the existing /dev/cpu_dma_latency is the
> > right approach here, and simply teaching s2idle to respect this value.
> >
> > I'm curious about the need for a new ioctl() though.  Under what
> > conditions do you want normal/runtime CPUidle to respect this value and
> > s2idle to not respect this value?
>
> In a typical PC environment s2idle is a replacement for ACPI S3 which
> does not take any QoS constraints into account, so users may want to
> set QoS limits for run-time and then suspend with the expectation that
> QoS will not affect it.

Yes, I agree. To me, these are orthogonal use-cases which could have
different wakeup latency constraints.

Adding an ioctl for /dev/cpu_dma_latency, as suggested by Rafael would
allow this to be managed, I think.

Although, I am not fully convinced yet that re-using
/dev/cpu_dma_latency is the right path. The main reason is that I
don't want us to limit the use-case to CPU latencies, but rather allow
the QoS constraint to be system-wide for any type of device. For
example, it could be used by storage drivers too (like NVMe, UFS,
eMMC), as a way to understand what low power state to pick as system
wide suspend. If you have a closer look at patch2 [1] , I suggest we
extend the genpd-governor for *both* CPU-cluster-PM-domains and for
other PM-domains too.

Interested to hear your thoughts around this.

Kind regards
Uffe

[1]
https://lore.kernel.org/all/20250716123323.65441-3-ulf.hansson@linaro.org/

