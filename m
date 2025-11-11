Return-Path: <linux-kernel+bounces-895255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0489FC4D5F5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F993A474D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF7F354701;
	Tue, 11 Nov 2025 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVl1T59E"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE94634D4D7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762859639; cv=none; b=e2Hbwoo5r93naMkAFPnQ19PU51yV+Ys3Uw4dWd63674hPf0Sm7RUEmyWnhlQs2OXfGM7r0ajWlFQUDWS9lrzMRB4NX9TB2Om8C5M6FuB9gyjlaqey+FRZdRTwEDk5GRUemqnWCr5Vp9tbd2Ef0WM7zRmjNDUu5PvTP/JIFDu4LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762859639; c=relaxed/simple;
	bh=mfpxJized6ddPC3qHoBNdHGOU71qGPnLof2yVroAmRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=un48Hy01HayiOPaXuHkG+aKspOOlBNdwBq+gZ6ba1xaD4DX25o4A//XEe+o5D90k6qv6VWoUPyxUPGfKaWlruPzBguV2SMVo9ebhN454+aokr3BaizXkdKvjXyzQT2p6+exdoJIXP+fJu4ix+uOL01guzafPFqRLN9uKDwqzooE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVl1T59E; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b472842981fso527624866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762859636; x=1763464436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qI0L2Ed/xTKonR94/9lycNCAUJYqkyjIqxvcRxrvF7Y=;
        b=JVl1T59Eq9WfU1MqgYtSBDr+hiCxT34sTKZLjD4yIRxZGniaBCiRjAvSBHzwBbIv45
         OLN6Gc9G6V0TItqECZ8UktcrUadOL7Cf2hffaGIfTNXrxrlTZvAmGkOtnXhmWt+5e/H5
         T2Z3Ut+jCo//8jPxJEtpLeSi7SWIg14OxNlyTlWZ0wNhfXi79EHvOI/smIvu79I1OY3H
         njXPj9LTcUVt61M/Vhb8/n0zYo56FVpfy3DgLTPAmwysYllMOUfXTRLdyojK64H67h5z
         F4748dSmKDhoh01WD7UCuG5AtHfl22/0tMKLAMdWSe9uo8vr/A84Ls/X33eHzukY5SNC
         qtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762859636; x=1763464436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qI0L2Ed/xTKonR94/9lycNCAUJYqkyjIqxvcRxrvF7Y=;
        b=cVTxyUgls+wQU383zVQZo/ckgEk/dyYrqKXGd/wIcA6Xo+aQrOncZdE5WQBg6uzG9N
         oKCp6wxPugh6Nf/EM75png1MuCdbUO/bcY1FiqqCkno+c7aYrG70Nn7+b8Dh4zO1vXh5
         IE6s4NEsEhHyCKCT47VFYi1IH3SOInsvwLBpKaDGrK4d/lEt0HBBMuIdy62RgJURMKDq
         RTIR5/Cy+cW4Sf4f4TeJAfVlSXxeFoarLWRel4ZeqA5H7d/GlarS7XX7UtTQ4xcRdf6y
         M/sGckKwTBdJ5VLD4jjfEGKsUBGbKfgvhQxKs/PJen6NxvmfXzyQafDDetXZY8iKR9Qx
         V4+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6wGKVatYfN15TsDy34SMbt7qveiqN2LWpJ+NitPyZfc4blqifZ/zvU3qhGqu8AeOUWn8rcD1pvygftyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL50VrFgey0bNharf/jnN31ZmfiTgb6t/5OhXNeIwEXkhl/C8O
	TrVCQeRS+ShdkDiOFjAeIJ8DJpy1PAOmQkx1QxW+nD9pqsMjmG2AYbvw28A/649l5W40FEdqv3m
	kVCaraMu/idnwUZ/2EnzxabFptoCL3Os=
X-Gm-Gg: ASbGncv0OiOxR4LBjSB7sNEjLxjwmmrwMLF5JWqX7BJgwTOey50z0RCmeMg4IhEq8xN
	ODSlLiypolClWCIbTUkMNs6CO45x9375c/H81rJ9EKm4sStNqBPDu3t3FPO60c7emX6VtIjXnrZ
	x/fJSTd84z90KHWUsOUld/y13WZFfaov9OzMdSAJ43baFHaxWpZm4Jvz2fQ/rSwfA9dB63sP9eU
	FNuq9uKn17mR3sHlvb9VETM1U2u9FJYgPUllSmYt1XamIyrg/eI+ZMpEhbS5iaQ9JejGCBypphQ
	Wuek26kXVkicCVXlBaLssbKN1w==
X-Google-Smtp-Source: AGHT+IFCERcs0ehjjKA/2M2GTFXwzqYa8iiT/pNklRVmaRpQgF44uW7J1kvaXulSj9Snkld7WJIal5/64pd1gpBwVGA=
X-Received: by 2002:a17:907:1c9f:b0:b72:7dbd:3c6 with SMTP id
 a640c23a62f3a-b72e05bd010mr1112366566b.55.1762859636167; Tue, 11 Nov 2025
 03:13:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110100503.1434167-1-mjguzik@gmail.com> <20251111-entkriminalisierung-chatbot-feeb7455fc74@brauner>
In-Reply-To: <20251111-entkriminalisierung-chatbot-feeb7455fc74@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 11 Nov 2025 12:13:43 +0100
X-Gm-Features: AWmQ_bn1Oq353vLtOaM933qqCHZui_Cj9HtV86r-w72vSSCxVFbxshwkj6NlrZc
Message-ID: <CAGudoHHi7+gy5sRsOimLqSy02814cYKN6FQZ8hQcATue0PV8gg@mail.gmail.com>
Subject: Re: [PATCH v2] fs: avoid calls to legitimize_links() if possible
To: Christian Brauner <brauner@kernel.org>
Cc: jack@suse.cz, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

this patch is obsolete, I posted a v3 (and later v4) with more
predicts in the area:
https://lore.kernel.org/linux-fsdevel/20251110165901.1491476-1-mjguzik@gmai=
l.com/

but that will require at least a v5 later

tl;dr please drop this patch

On Tue, Nov 11, 2025 at 10:47=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Mon, 10 Nov 2025 11:05:03 +0100, Mateusz Guzik wrote:
> > The routine is always called towards the end of lookup.
> >
> > According to bpftrace on my boxen and boxen of people I asked, the dept=
h
> > count is almost always 0, thus the call can be avoided in the common ca=
se.
> >
> > one-liner:
> > bpftrace -e 'kprobe:legitimize_links { @[((struct nameidata *)arg0)->de=
pth] =3D count(); }'
> >
> > [...]
>
> Applied to the vfs-6.19.misc branch of the vfs/vfs.git tree.
> Patches in the vfs-6.19.misc branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-6.19.misc
>
> [1/1] fs: avoid calls to legitimize_links() if possible
>       https://git.kernel.org/vfs/vfs/c/ab328bc1eb61

