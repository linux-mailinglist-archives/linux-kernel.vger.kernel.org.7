Return-Path: <linux-kernel+bounces-814743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AECD6B5580C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64ADBA01114
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 21:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B884532ED41;
	Fri, 12 Sep 2025 21:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gdbk9Rzm"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7595028489B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 21:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711183; cv=none; b=c7Ue2Jl8uTsaMZVoSsVBlbuTBXyie1yUyJ+cGXAAcggCRLM4bkNfX0hXX8aElMq6zV+pmRvuaeE1ixtmhUHva+d/fuS8k9LuEhzwR16DUh6kYgqlavYBoWTeeCYnPd+AvTRQrk6UckaoW8Iojz5Mrq0V5G10OqewdYNLUZESoTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711183; c=relaxed/simple;
	bh=J0uLC7O54zZEqMTW/1kC7lXHzi7kn0Wiz3wS9V4s0nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGdycgVWf22g+XPSOkZOLbg+FbR61Nukp1toxTglTyO9S/O5ffC8j66HupJAa6MybFCQ18P+Jbo2C/5fzewEo4MyVS1ii15pPSqpZYtM2y9B5gXT8VrLyRbaFQ2QeHqC5tbjGNrChMGF13zefW9gQ/HM8qtfsAaI+l9HcDAidR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gdbk9Rzm; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-560885b40e2so2200e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757711178; x=1758315978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0uLC7O54zZEqMTW/1kC7lXHzi7kn0Wiz3wS9V4s0nk=;
        b=Gdbk9Rzmm43q3XC1SuwbKR27h6gTtC9UTih2MIM6UPO5RdNR0+oYmS0tXFpoJa4Iuh
         olz5CvZp9LuSdXZJPD95gxUvPFx0Ipjn6CaNTF7eHVdeKTeR8pFVCi63G+Ghklr2mSH2
         YbpJI2i3PhRv/r/z+V73avfQDsj6tpYr3iKOoO0SNi5Ruum0wOIqwPoIRiRbVZ3kfuzi
         fGgsu6pcSWrd4PJ0YVHHUlZ/zDt+njq1TT9pVtMssbMoqk0DNuoGXYPU9Glaa4Bacj8i
         Oa2J06pWBtDV7eTSD4YGaIovPLWLFAsFR21FEAnPdfgyF/EmKT2H/Glg3tvZnezV4bjc
         Is6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757711178; x=1758315978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0uLC7O54zZEqMTW/1kC7lXHzi7kn0Wiz3wS9V4s0nk=;
        b=H3xkOSA7vEePZtO5WL5EeoWLlaQOlmUMtFQ/e8DEma70aXyfKM6/e4JXkfZBcuohAa
         dLYPy9RC7l3WiX3nujD07bDCgRs2EFAQN9XhtrbkK6iGi6S0jLVQyDNeLWXpzLSimZ1b
         MV4PuMq24JW6nVcwjJIMs4ozTYziIqx+DrH+zBzbvmvArOIaAZuLcnuPur56g7klXIId
         92zofaBohrLE6fd922kA/SbZiomWyL6v3VHkSJwpNraE7Qp/Ib8GqLvKhHO9Zxpu527/
         jVFGBJ7np9YTu8ShJKLhVV/iGJRZtFsh6I7voE2PunaKw2apk8rLroyxE7jI3WsXq/3B
         opGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2OeUvUVDQJBwwOHb0HO6lf7TvaTohKHJnyaZAa9dE63dpAK3V4/gjDtKSXn2NQZYJP2HiJ3a106TJxXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpS0pLyoiUeYEJIfEwHoRCayTdUhM9qAEhvGHFWSTEUXW2il+g
	O+E4y1NQO5fT2GdBwKmnMpfy3k7EZQcfzX5Z2QMysmvQ6rxXmOXfdjLGQl87yQ27aaqHuBiGfyu
	JLrgk6yCFMV1KM2XJAC3b071fk29dSUrJeE6RaAHB
X-Gm-Gg: ASbGncv36AuU69GtwEed8nZe5bHV9mAPSDhtpD+AIeBSjPJuq5tCfk8pV0EQ/eLmTmG
	sw/XoMDuwMI3FO0/GpK4m9kYecIWCC+2MeNlKka4hd2r68kWiisrsi+NeYVyOkY9StHCJge2phH
	Vxo1an5tCZvF+7yNIJl+A/xH/PlaG9h3FGwoMDmcLx0fdDHXgJZqGFx384Nne1dx45JVPtOWRou
	3TvW0ui2ZJfRPoVeVbO58dc97qJl+pK54Lm/h+yxBCKO7jdWhkoIws=
X-Google-Smtp-Source: AGHT+IFo4cD/BxVNOTywCONMB0xxSgIfWIheC5wDA9CVLI7iF4J1whY/WrIulwEDO784Yw6phn3QOH0lmYu8KuRZe0o=
X-Received: by 2002:a05:6512:4284:b0:55f:6aa7:c20 with SMTP id
 2adb3069b0e04-571ec0f1920mr31259e87.2.1757711178303; Fri, 12 Sep 2025
 14:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912170611.676110-1-sdf@fomichev.me>
In-Reply-To: <20250912170611.676110-1-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 12 Sep 2025 14:06:06 -0700
X-Gm-Features: Ac12FXyWyx4o42PDWjsODv1chbAaWgFV6VBuUC2qYTuwYWTDLJD2IV5Da0to1WE
Message-ID: <CAHS8izNSeLSzkTsmhcVwJ1fF25Y_LY7vo_LTWtVL+Erc8dD6SQ@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: ncdevmem: remove sleep on rx
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, shuah@kernel.org, 
	joe@dama.to, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 10:06=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.m=
e> wrote:
>
> RX devmem sometimes fails on NIPA:
>
> https://netdev-3.bots.linux.dev/vmksft-fbnic-qemu-dbg/results/294402/7-de=
vmem-py/
>
> Both RSS and flow steering are properly installed, but the wait_port_list=
en
> fails. Try to remove sleep(1) to see if the cause of the failure is
> spending too much time during RX setup.

OK, I can see that happening indeed.

> I don't see a good reason to
> have sleep in the first place. If there needs to be a delay between
> installing the rules and receiving the traffic, let's add it to the
> callers (devmem.py) instead.
>

Yeah, I was worried there would be something asynchronous about
installing flow steering rules (such as by the time when ethtool
returns, the rule is not yet fully active), that may cause some
flaky-iness, but that's unlikely the case.

> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Mina Almasry <almasrymina@google.com>


--=20
Thanks,
Mina

