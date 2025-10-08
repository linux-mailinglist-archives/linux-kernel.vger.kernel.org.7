Return-Path: <linux-kernel+bounces-845769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D38BBC60EB
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D7FC4E9495
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883962BE7B4;
	Wed,  8 Oct 2025 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eEX/+L+X"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267F22BE03C
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759941695; cv=none; b=soi3K0F6/baikiRMajigoInLx8gQRYVOrlwAY9tgr3he9edQz3VShiK4oKSykn0w+nddDlNMuBDSOuFNvoGRmQpogJ1OiiN5RGyN7tKT2kzLrgDtbCzSl/C3sd5kLy0X8RMgcu2QNhB6nTEpu77nvIYmjH8u8k/s5IePpLpG9Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759941695; c=relaxed/simple;
	bh=QR6dvvk3oaD7H14sYrSs779Fo6D7QZnJQfr7drHcfcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4dv5hPaszfwsfdv0h2qnO41MI+hCvJrmR/fRDKkhwjbWTXZidSYsbzuzZRmIfApguAIL/sOvFF8PvpZt4LdpX/ih/jl/c/5RmxTnAwfnZ/rU6MJnmaI+KQMjJIPnD9eWtpdLm7GmRGMYaQ54ZBgCftgYfJPNYrTIwsdr3F3O/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eEX/+L+X; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee1221ceaaso101295f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759941692; x=1760546492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkUn0bEy7UnVm486p7imiiUaSOovfIgjhU580ToC/W4=;
        b=eEX/+L+XKDHcwQIEFMbr16WxHyxkMSIYDVQGUr53xjFPmfoLwjkYTy//LpfM9LE3Ho
         1Dj/UNlo6B9T+3/0n4qhTISZ64lkznyXxRC6eOdy927iE2J/G/eU71h36URWTtRYfNdu
         h7Otc+iahbAyG/DG+mI50fHlzOPKkQ4DW4e4zlh+Rw0NLw84zlQbatAZRRIbuy1LWbFV
         OqME+dHSovSrNHJobIDSdihWQDG/U54Niedo9K2sST2AOiWFluDbXP4+AnH8l+fVwSJU
         qBXwNJayvB9Vqtp3Vw+tUGnyLB3glz4kU2OosmvlPzGRfthiyCrs1iZ/wAAxDp32C0+O
         rBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759941692; x=1760546492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QkUn0bEy7UnVm486p7imiiUaSOovfIgjhU580ToC/W4=;
        b=SebT21RecbUvvWmjoQo75UMfYjCAMdGEgFSxxrzBRpqvdTZdwl5MAv0ZK3ime1ZKo3
         hhSgJOjUuqmyzYooToFsL+c6+VqqHCCTUhmlPVUATjPw2DBtlaii1r3TBtuIomcZStOT
         MuaXB3QP2tZ7iac+2dg4k8iofT54mHzynrvCb+kvPAd8L2aI1Q5/fiHW+BA0HJvtwzc5
         XgnTgJR/2hj8Ow7eSYCDOApas5gQ5Usfkm8CH8BW/5QSlJg5HCszn1BlTUoB2ue2wbVe
         CHD32vz3F2iD6q85xkxZWZe9B8dFU0hApYa8dtxfZ0YHAnm474njCwEyLUlBwDLcY3Dp
         KBqg==
X-Forwarded-Encrypted: i=1; AJvYcCVQNnxHZdgvYBXK8s/Gtujxij050VZ1DmDemTy+WnzjAbeDg4nqcqcarfOfpGBhv45NPE+crUDAnQb6gUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuiKEDeH6OlcVJKFK+86ormbpAV0+UwUl33WhoJzSbD5dXHlz6
	B4c+TzTK92NGsefsrArxJBmgcshweMELM6hPCB1IZP7tiYP/lBKzJxbJeIKAKOs3Tg6Xvznz2/u
	dQVrmUZJVOE9mznfSIy56vewW7A6838L2+1S721fq
X-Gm-Gg: ASbGncuaoyFgKGVs/MsnskRKZb/IkMiMMkFQsjgn4zXSga660dy1+Dt02badvG11tlo
	g2qtAsett4lVnmE0GtzMX0R+1yc4UO6bGxnR3CrlUpF5h0885Pvpdg41+3/+AUVzQ0uPyHj1wm3
	rh22wJaSykVmdCzJn6OmPL9lbZ6nlcew1fHUJ8AOuFWnfYL+Uq2i5myX9EBcXz91IJgob2Fkyhh
	1aR9fAFBmgh0a2i/ZptNbjtvEYQrG87u1GWkLhOstaP1VVQGw+g7oo+kSF/
X-Google-Smtp-Source: AGHT+IENntzdxU9hJJ0lQZCsCFGj1Ic7MQ9klALciP1L+8DYvg+bOP2NRoNHPHzJOIHdM11CqhWHIUa/Olm+nwWSBVY=
X-Received: by 2002:a05:6000:2584:b0:3ec:c50c:7164 with SMTP id
 ffacd0b85a97d-4266726c309mr3088352f8f.15.1759941692317; Wed, 08 Oct 2025
 09:41:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-binder-freeze-v2-0-5376bd64fb59@google.com>
 <20251007-binder-freeze-v2-1-5376bd64fb59@google.com> <aOaSA0dPnY2I4a_D@google.com>
 <CAH5fLgiChj29SbwN-5vHhCNzaUa7wewOXe1D8mN3XFfyZr33gw@mail.gmail.com> <aOaTgDMY-VvM_r6m@google.com>
In-Reply-To: <aOaTgDMY-VvM_r6m@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 8 Oct 2025 18:41:20 +0200
X-Gm-Features: AS18NWBoH6tOgrYOnO5M1uMQvG_f-Fy902WmSwfhC4NmactLE-sHdwsTsy9R4Eo
Message-ID: <CAH5fLgha8DdiZ=XyyNRx8Y+GS6SCO2DHF4qMgKwMoq8tUXc3LQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rust_binder: freeze_notif_done should resend if
 wrong state
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 6:38=E2=80=AFPM Carlos Llamas <cmllamas@google.com> =
wrote:
>
> On Wed, Oct 08, 2025 at 06:34:54PM +0200, Alice Ryhl wrote:
> > On Wed, Oct 8, 2025 at 6:32=E2=80=AFPM Carlos Llamas <cmllamas@google.c=
om> wrote:
> > >
> > > On Tue, Oct 07, 2025 at 09:39:51AM +0000, Alice Ryhl wrote:
> > > > Consider the following scenario:
> > > > 1. A freeze notification is delivered to thread 1.
> > > > 2. The process becomes frozen or unfrozen.
> > > > 3. The message for step 2 is delivered to thread 2 and ignored beca=
use
> > > >    there is already a pending notification from step 1.
> > > > 4. Thread 1 acknowledges the notification from step 1.
> > > > In this case, step 4 should ensure that the message ignored in step=
 3 is
> > > > resent as it can now be delivered.
> > >
> > > hmmm, I wonder what happens with 3 threads involved where the state g=
oes
> > > back to the (unconsumed) initial freeze notification. Userspace will
> > > probably see two separate notifications of the same state?
> >
> > The way I implemented it, the work items report the current state when
> > the work item is *executed*, and they do nothing if there's no change
> > since last notification.
>
> Oh I see, then that means the 2nd and 3rd notifications would do nothing
> as the state went back to the last notification, correct?

Yeah.

If the state flips quickly, userspace might not get told about that if
it's too slow to receive the update, but that's no different from C
Binder.

Alice

