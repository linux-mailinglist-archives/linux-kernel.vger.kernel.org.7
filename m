Return-Path: <linux-kernel+bounces-884089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B251C2F54E
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 06:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D6704E2161
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 05:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E88327F75F;
	Tue,  4 Nov 2025 05:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJxeridB"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563E51DFF0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 05:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762232564; cv=none; b=Sxm0KDHqJHiT/nlNNFn4NmhHQ7h1gwZRkcIg9CDpUT/14J8BIOBZ/CQ+Mrz/q63oV1khcU60Wl0pkENOhkKmiP5e0MsjnDS6dajl2F2ESV0PqVeSCXWZGT+Yv8XRRDia9yBoJLW8ItoO+xGpP2ZIv+UPSIp1eK8nPzrhSsf1nTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762232564; c=relaxed/simple;
	bh=NnkoEv9aNK4Of098YGCNNK01iawIJsiNdU9WkaijWI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e58yeF7EwvF9xhQLquVBCf8V7kzfL1j/mzlololwILmnayLVKpPraQFCW6aqHUefrk5bTBoFMM/AKaJYXnpuSNJwPyDFrKKKtadJedMNMrJ5dk8QCjy7WZ5s7JRLavMpZQBXDKoemJUDfKhqUttIG1SS7YhuhmSNy8BIgj5kyy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJxeridB; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7042e50899so888071866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 21:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762232560; x=1762837360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnkoEv9aNK4Of098YGCNNK01iawIJsiNdU9WkaijWI8=;
        b=fJxeridBtxX+nlwWEifbjaH+AY5CgS8m9SGxSGqd60f0zjOg2XsVOSQNRG17HFtj4e
         jUOffmx9hcOA6avn9aCOchxWLxxKOGo90sDDN23nA/uB/CG/SIt60RLgJ0qdRfcszmuF
         5ulkJpJOcaUZ7Shznme1zrwHFK8GbjsTfQffSO0HXnLdZTp4lq7KQd7AOK2ivNuRjrfV
         eqr0j9R6fxuhD3xalk29QqCWKSjCjTMd7YOdqHnKwcuk+6lfkcacXGf54wcxFQTg5GST
         TMmhLN7T2DoShPGQdGC15tFgyuyYoNvJHdV3ZsSmOW/zhIcNFG4iye06vphwPDX5yqh9
         Dofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762232560; x=1762837360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnkoEv9aNK4Of098YGCNNK01iawIJsiNdU9WkaijWI8=;
        b=upbHDIINsElkWp4x5g8/0uZO3gqaIiS2DSphPWkBRpYLdytcKuR6rTehzK54V7uMlz
         GjSgUbpU/KtBh/QIfv+DRoK8UHG8vCMGoajUrDftUVfwpg/kb3iMWljDuVPQC3679v7q
         Zrr+TqErnO/gG+tyhSMud6l2wKVq9DbjluDsEmyj6h18zYhGI46RDM87DXLspFAhlqd5
         B7epBfe0jBzNWzvYa1gF1HU/RWoEhqPGXDWTbzen9rzLtZY6ObLeAoWwc73K5w0OPwtG
         6MBG8lC/n28H8uogdcC1bHcyqGZ076J7wNi/sFRztsuweser7E0cGD7qtKPv+Y6xHm5s
         ppcg==
X-Gm-Message-State: AOJu0YwjYnq1+UKYGqNwoIg9wt84ZyXpO7UpKNIApyk9QRneIYYrrAWy
	rHWwLf/xsWCjcAloGSWfcVeSYtg2fOMvYbC23GVMJdRnoqlc1QsXwCdpFL4Wvhk3KmKVeyPMtQd
	1NIsUNQC0kl+xeVKhvWklT4Kl7XjkbpXLKQ==
X-Gm-Gg: ASbGnctDoCjF5XwbJl4mQz+FxqZbS2OSj/ry/KocZwPORFhUlc79TomN4/dF5u2uMtk
	LAWjCq1qxvQ4x5AfrcMOE5bUdR/d0ny6YVRSyTM/VEcB+BscATlBPfS4jPLnD71uQM3AG5sKKZf
	vC3oIpamyyNrW8FIRt7ob8idjLqyuXZPBY6i1oLQrX+x6ZkcJVXBvbh7kW1dg1HYhb6Cig9rUSQ
	vXoyARjvKjkTM299BsyND/vjYgY5QNKbwvXPpXBGY40hwi5y5rNHdp7cpIsAw==
X-Google-Smtp-Source: AGHT+IHPJe2rIt5BN19iN24bUfRnZZt/qWIXMVAt0IaSqmQIj7Z++U4fzkWV4WoYhVI/8dQepyt+iNqcgMaHgR2WWqE=
X-Received: by 2002:a17:906:ee89:b0:b44:f9fe:913a with SMTP id
 a640c23a62f3a-b70708a2d37mr1410981466b.65.1762232560422; Mon, 03 Nov 2025
 21:02:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOuPNLh4R=H0BfQ4f13woGzc82jX9LGB+kxAGeGVkhwYqKcg4w@mail.gmail.com>
 <19a481a7843.53422ba121754.4867625372707455852@siddh.me>
In-Reply-To: <19a481a7843.53422ba121754.4867625372707455852@siddh.me>
From: Pintu Kumar Agarwal <pintu.ping@gmail.com>
Date: Tue, 4 Nov 2025 10:32:28 +0530
X-Gm-Features: AWmQ_bnehoVqnMZ_GeHn98TM5n3M8hAZ8c6cEJCNStbHsr3LptgmmL1_nKH6dkA
Message-ID: <CAOuPNLhMcPJ_vkvyDKTW1c4TcSYusrzrAdu8khazHoy3txJGDw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=C2=A0Query=3A_Y2038_patch_series_for_3=2E18_Kernel?=
To: Siddh Raman Pant <sanganaka@siddh.me>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, 
	kernelnewbies <kernelnewbies@kernelnewbies.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Nov 2025 at 10:35, Siddh Raman Pant <sanganaka@siddh.me> wrote:
>
> Mon, 03 Nov 2025 09:57:18 +0530 =E0=A4=95=E0=A5=8B Pintu Kumar Agarwal =
=E0=A4=A8=E0=A5=87 =E0=A4=B2=E0=A4=BF=E0=A4=96=E0=A4=BE :
> > We have an arm32 based embedded product which is based on the 3.18
> > kernel and a simple busybox.
> > We wanted to support the Y2038 issue on this older kernel.
> > Is this feasible
> > Do we have the Y2038 separate patches available for both kernel and use=
rspace
> > ?
> > Or upgrading the kernel is the only option ?
>
> Upgrading is a much much better option.
>
Yes, I understand, but upgrading the kernel on this older SoC brings
more complexities, challenges and time taking.
Customers also do not agree for the upgrade at this stage and they are
looking for alternatives.
So, we are exploring both the options right now.

Are there any patchset maintained separately for this Y2038 issue for
each kernel version to have a look ?


Thanks,
Pintu

