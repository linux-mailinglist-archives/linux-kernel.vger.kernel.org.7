Return-Path: <linux-kernel+bounces-881162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D85DC27982
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 09:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24D854E1AE7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 08:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439FA2882D7;
	Sat,  1 Nov 2025 08:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DL/uBb+A"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863F24369A
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 08:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761985181; cv=none; b=MA9Y/ezuMH2j3+XKuH2zw4SA2X6kdDYfwWwBrVjjSgsKDVR2eGuU1aqHaFDWx/mPT11+uMreHq2VWC1jff0df0oqlHWwl0UzmM7Vm313DsfKreHrUeDyPz9p4b6jVZpaY3KSWFb9RirYbf/WoLNbXOOL6e5RLRJK2sUxyOxvQUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761985181; c=relaxed/simple;
	bh=0m1KiCxrcLAq57bvrNoE/GhvmNxPugLIsp03lfyd6uE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hr7v+ddtDiEnpiPCTCJOyITSobRuHcwVPpx8sYTihVGJMWgg4zAQLLmmDGQGxRylqTotaqb/miVIywCvMcMgMTkqLZdYSt+am/E20vqG6CkcDGXce72yDq35zm5WUzRT0WhmZqMOs08TbFEr/Ay7BtJp5NNe06tBnR762pLBY9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DL/uBb+A; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3b27b50090so514012166b.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 01:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761985174; x=1762589974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2fiys+iyv8ARWUS9urU0rDn8AzFYvrnowS3Ktzie8w=;
        b=DL/uBb+Aqk762izW6faOjCjw0wk2K447JAHxBe225gUfJAnonV6qX/7x5zxtvqhYdZ
         doTcCN5/dklIrAL68W640vtjIfqe4DcliwBaPS5zgREUglofi/w8BM1ukl6f6Cwdrqsc
         140QfR2lUUOwc34F3Pk1lIcnhwZqEcawk1fXvobOC8bydLpnNh1It0l64Jh7Wxdu3/3l
         o9TN8E9B6srNF2mjn3fsO7JaEZnRaKtrtc3ah0Y0kOHU2Izn6p9OaPCX5VeP+RpKHrpn
         snxAt30hflZPron2etPvXR0BPpLYo57lyPWvZInlN2prrnSnmg9dYnHsTRXCBzydcy4B
         PAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761985174; x=1762589974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2fiys+iyv8ARWUS9urU0rDn8AzFYvrnowS3Ktzie8w=;
        b=EshrpLk4P7jqqmgPrTKfCOEFN2i9jMc9n23B9trZqPvyDsLuiDGgqecHAHKLRrRNED
         UVkM7F0WwW9jfR6imkqPEmVL5/u8/RuLQ02cSl1OdYFuR6DNDQfI9VS8jBiXhBfmw3ES
         XMKkwdq7bOMZqtXqSUG5OwqW5Bu6AXV85G/TBeIRfeHoxWn+7aM1TQA0vGevirIo+Ghe
         tPh+lfk2Qj0AltrkfIh4FzZpX0VkNc4PswdbwnCc0Un4rmPe4lgiofTf39jvWgxrPfWX
         adoT90Bc2d+pYTuJqZwh/S4ZqXAqjszZXX+Yf9ZtYPnEbH3F+0JX2++99D67L4rudKkF
         z9HQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5hmpe+MGnC8QiqUyqaxk1H5EoUi23C/27x5kKW6ZxFF+hgh38FjHLXASziQsBeW2HuZM4oo/Rxc/zQAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZJVneIfCdq8I+f6ZV8AnxlTK6B4VA/JXdSmmANhu0K7Kpo5l1
	cqTiDP0k346nIVDEjF5KlJ/b1UJMePcj7QzKIOmWTgOn9D9Yame2q0U8+uod/GLh7XUMEdlaYTo
	uvdsa+fjRi3X9TBuvR9WlYiqQ6NDEsGw=
X-Gm-Gg: ASbGnctS2yN0EPuj4oIyLVFks3NmRpbzzoKnbNBqnIF2F4sE9RbHYReYiXn1rp26B28
	9LZoNexjx4FIuC1+yQEnoxOsLS/F0WmwdIBhxn1PXAypVRj07djTc/6J0vkjaGnZ/FlI6Jfx8g7
	n7mJ+/Zutbl2OppwVkLSEkIEa3yKpLH3FtqhKmVCv3/kXoU2Foduf/vUtJvPUZycikxPevE4Eer
	O+0m/E5996ZHTCSkfTMbB9620IBPH2z2WU59Mbm4pTLIPIh5sC79ZDQBxC/Hkvw/qW4E9zN39Ed
	1UJA1wGppQ7YWvE=
X-Google-Smtp-Source: AGHT+IHHZisxkG0pWkZYJfYt2yrPfxCqmDqjea0f1awr3nxsgakffV+oCCROQMtRitvrrYjVKn+NejJDkvxd+gn/2B8=
X-Received: by 2002:a17:906:fe4d:b0:b3f:3570:3405 with SMTP id
 a640c23a62f3a-b70704b3554mr533169066b.34.1761985173594; Sat, 01 Nov 2025
 01:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029134952.658450-1-mjguzik@gmail.com> <20251031201753.GD2441659@ZenIV>
 <20251101060556.GA1235503@ZenIV>
In-Reply-To: <20251101060556.GA1235503@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 1 Nov 2025 09:19:21 +0100
X-Gm-Features: AWmQ_bncJFNlDcLqUPC7424LGnLaX9bqYHTH-MSz1Ry6nI1Gke1V5yviwukC44Y
Message-ID: <CAGudoHHno74hGjwu7rryrS4x2q2W8=SwMwT9Lohjr4mBbAg+LA@mail.gmail.com>
Subject: Re: [PATCH] fs: touch up predicts in putname()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 1, 2025 at 7:05=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Fri, Oct 31, 2025 at 08:17:53PM +0000, Al Viro wrote:
>
> > 0) get rid of audit_reusename() and aname->uptr (I have that series,
> > massaging it for posting at the moment).  Basically, don't have
> > getname et.al. called in retry loops - there are few places doing
> > that, and they are not hard to fix.
>
> See #work.filename-uptr; I'll post individual patches tomorrow morning,
> hopefully along with getname_alien()/take_filename() followups, including
> the removal of atomic (still not settled on the calling conventions for
> getname_alien()).
>

Ok, in that case I think it will be most expedient if my patch gets
dropped and you just fold the updated predicts into your patchset
somewhere. I don't need any credit.

