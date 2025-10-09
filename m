Return-Path: <linux-kernel+bounces-846690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E726BC8C17
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 13:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 912BD4FAEB9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 11:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6DE2E092E;
	Thu,  9 Oct 2025 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jnJhDsKo"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4292DF133
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008792; cv=none; b=FZFjUEc+GxZJ74M2KZgXZLUqGeivxiY72DPOiMES+uKklUPkHOn1Khr1KLoFVmB44Y/OVlQ57/6+9+9LFBBtCNDQY0Fc7JeN/947gF0FuEhYCVGl4A2BAi2g85fPCr2xW4VqNWriqrI06vV2p3OoEbFhn0lGwNBtT5JNnEHGukA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008792; c=relaxed/simple;
	bh=RzE7qmTe7VW1DwA3fxirB0NZxAahBI8Q2RnBonVma7w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BYmjyMyRH47VOQGNOQ75eQt+edk9jQ7MH5OMTyXx1U9+I4v2Sxx7zWzan2bsRhRU6jKr5zwDlJlyL8Nyz8w7Yv+b1T2vq0m5E3QUZ6F2ng2RuTVLfaKwXq5KHQw5PPheFyFTZcU8keuqA9TEkt3jtvHF1oOTJWpYB1ifjmKY1Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jnJhDsKo; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e44b9779eso4285035e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 04:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760008789; x=1760613589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DUd84J0qxU625unTGoQRcfxjZI7PthQsRTwRgbjUIs=;
        b=jnJhDsKouKH/2v8ag22OrYmiNA+LN5wqg5z1Jvz9EgKTvAUEQ+dAR+83C0pf8H/t50
         0Vh6DTyL3my8UhIyPz9i26H71oUYkoQGQ6kHha2otMhNilb0saru1XEmoofMWUcVNtch
         wthrPY37vpcajuI0bkLUvykuMKqDFjkFwvUHHejxTjAL6wOnMOcNnHwgsdn7Idub04tw
         uZw3Dqe+7n9QplNHSS4v4svul2HdbYHL8+qfZDf/LQ+JOhEWzNtwaKu4ms/PuhmdUjnG
         qexiHrk+PyHgzLorW1Jhrog962xFL8cYegghqb4/GiN8xhdbw2tJ8hXK7+mFFxQOd03Y
         YXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760008789; x=1760613589;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2DUd84J0qxU625unTGoQRcfxjZI7PthQsRTwRgbjUIs=;
        b=jsY0JOnuHstu1/snqg2VEcagqCE85GZH5hQ9vDO8DpWnMjAJCVMzOXJDT9BvKYFBRV
         uzQHhJ32YtV5dvabdILj49nv330W59R7bwFwvRqYC3q2VZ4JMp8JA6ijTfZHFayv7vz8
         5UIIeah3nayjJlKLpJGGJK9bdCjGqDFqCSGOzLSYOQ1kCS7vBTaIJZSwh8zxNvEslm9b
         qvu086GhxrbwbUDdKbWpBFJ/usYJQ+e/ugG8JFOFqj6ezrozrG8hH8CLGwilnn8uvRv7
         2/V+8tx0lPTgc67kA53miGbVbxqX97Q9ZcaapXH7LnsaDon9+JPvEjSL1IJym+j67mbT
         c0Lw==
X-Forwarded-Encrypted: i=1; AJvYcCXGuXsy5cLfTI3TmrefttL+uSiThfoXB8BswhNNqStAOiRTYp1FzALJpaQHPVdYe2Ex3fHrm5/BdgWbNBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmsOC/o7n+vYq0B01vj865YJ8N5bRv8ddSkaHsoTSFbKL2wH6p
	WhbhcXLE8lveE/Zlni56mOthpFXkRNdMxUo8lHXgaQ9tmmTN8wgsuxP+w9Wii+uKzp13Oeken7D
	4ZB2Qj3QgC3XEruC54w==
X-Google-Smtp-Source: AGHT+IHDNiC37K6gv5N9rlmQWR84UKoo8mya5NIGmasE//q5bLN74a4a6FScJ09rff60l5B8yC3SZYWSCfFYwx4=
X-Received: from wmro18.prod.google.com ([2002:a05:600c:3792:b0:45d:dc32:3d4a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:314b:b0:46e:2109:f435 with SMTP id 5b1f17b1804b1-46fa9a966f6mr49436855e9.11.1760008789266;
 Thu, 09 Oct 2025 04:19:49 -0700 (PDT)
Date: Thu, 9 Oct 2025 11:19:48 +0000
In-Reply-To: <aOaW5s30sRc6gPnA@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007-binder-freeze-v2-0-5376bd64fb59@google.com>
 <20251007-binder-freeze-v2-1-5376bd64fb59@google.com> <aOaSA0dPnY2I4a_D@google.com>
 <CAH5fLgiChj29SbwN-5vHhCNzaUa7wewOXe1D8mN3XFfyZr33gw@mail.gmail.com>
 <aOaTgDMY-VvM_r6m@google.com> <CAH5fLgha8DdiZ=XyyNRx8Y+GS6SCO2DHF4qMgKwMoq8tUXc3LQ@mail.gmail.com>
 <aOaW5s30sRc6gPnA@google.com>
Message-ID: <aOeaVMHC2SWzg_Fe@google.com>
Subject: Re: [PATCH v2 1/3] rust_binder: freeze_notif_done should resend if
 wrong state
From: Alice Ryhl <aliceryhl@google.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 04:52:54PM +0000, Carlos Llamas wrote:
> On Wed, Oct 08, 2025 at 06:41:20PM +0200, Alice Ryhl wrote:
> > On Wed, Oct 8, 2025 at 6:38=E2=80=AFPM Carlos Llamas <cmllamas@google.c=
om> wrote:
> > >
> > > On Wed, Oct 08, 2025 at 06:34:54PM +0200, Alice Ryhl wrote:
> > > > On Wed, Oct 8, 2025 at 6:32=E2=80=AFPM Carlos Llamas <cmllamas@goog=
le.com> wrote:
> > > > >
> > > > > On Tue, Oct 07, 2025 at 09:39:51AM +0000, Alice Ryhl wrote:
> > > > > > Consider the following scenario:
> > > > > > 1. A freeze notification is delivered to thread 1.
> > > > > > 2. The process becomes frozen or unfrozen.
> > > > > > 3. The message for step 2 is delivered to thread 2 and ignored =
because
> > > > > >    there is already a pending notification from step 1.
> > > > > > 4. Thread 1 acknowledges the notification from step 1.
> > > > > > In this case, step 4 should ensure that the message ignored in =
step 3 is
> > > > > > resent as it can now be delivered.
> > > > >
> > > > > hmmm, I wonder what happens with 3 threads involved where the sta=
te goes
> > > > > back to the (unconsumed) initial freeze notification. Userspace w=
ill
> > > > > probably see two separate notifications of the same state?
> > > >
> > > > The way I implemented it, the work items report the current state w=
hen
> > > > the work item is *executed*, and they do nothing if there's no chan=
ge
> > > > since last notification.
> > >
> > > Oh I see, then that means the 2nd and 3rd notifications would do noth=
ing
> > > as the state went back to the last notification, correct?
> >=20
> > Yeah.
> >=20
> > If the state flips quickly, userspace might not get told about that if
> > it's too slow to receive the update, but that's no different from C
> > Binder.
>=20
> I believe the difference is C binder doesn't report the current state at
> the time of consuming the notification. So I'm thinking that it would
> report two notifications regardless of the state, even if they are both
> the same. Oh well.

Yeah, I guess if it only toggles once, then C Binder will report that.
On the other hand, if it toggles multiple times, then C Binder might not
report it that many times.

We could make Rust Binder faithfully report the callback the right
number of times in the face of toggling, but it seems not worth it.

Alice

