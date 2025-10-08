Return-Path: <linux-kernel+bounces-845759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26178BC6088
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22AD3BE9CC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D6E21507F;
	Wed,  8 Oct 2025 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tG8CyvmU"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8EC29B217
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759941310; cv=none; b=ralgtkwVpxW+c29SLJlO5UrRPs4bUGC5PPcZNZk7wRmlKtzwL75qAFXsxWO5zQQsqeec9filiUuAddkRGvOgRR29xFKYcy3MqySQYHxKGwcwsumxM089gS98ufDm8P6UFvh3z1DWtHz2WIh3/RwqSPE2MXc1dnZGdIm1YmOv4IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759941310; c=relaxed/simple;
	bh=IbjrFZZRj8tiQxzn9Tw7s3jFUO207TYdzCaeEvnG2RM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDB87FWS7DEKrJ7YaEfSpF0jEkUjmiy0U3lavMyo8XBkziavIGKyM64toDwJHObvDNVwyFl1SxpZRl0749n1/lC1Hil39ejzUXG21RbjqWUTa34lxe91m6fEaTv45OXb80M5zG3EVXgbboxTGfTXn70AUSYR7dmm+tPgZW38Lh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tG8CyvmU; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso103410f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759941306; x=1760546106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iG17mnyEmeBo+WTlpwapGwV5hivono+ardKEAadCAIE=;
        b=tG8CyvmU/Z/THyDIMVuVDprPipRDI2nSnORBmfd6J7rV+TEKePqk0XH4YpWiLjrT/s
         F0iyROzXzUb/am2YVSPzo/e8eeBFf7bpB+Ik4vhiq/conOzsgBpMgqw52pIdltyPSZez
         tOBQRiCP/HDjGMneAV5Ea4v88KuQrkWbUVqj94ZllvesCne8TFW35efPZg2sSQ8EuuL/
         1hI7Y0m3aFmDpgX52xa7q7FFaP9Y0m2Pz2VT42Qq+16iRqqitgj/ZDf2C0NHQ6cNJiME
         I3sAKqVN9knNsVGWIQ8OhtMSEvNtlKbcOI+s92cJoWbmtkXmh2nrs6ygy3yJ8XSL9k5S
         /oZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759941306; x=1760546106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iG17mnyEmeBo+WTlpwapGwV5hivono+ardKEAadCAIE=;
        b=p0m7/7ytbPV+YX+lBJ4OuufHSA+qJKYI+N0iz4fwSC3hGXJGSrqmTEa6DthBaze89d
         4Jw03M8eJtiZuVrqGjwXqDlVeJ4QQX7vbdcpdtJOrb0NO6hl7lJewIIyKcvAykAgSxqq
         2LAs0KTokQk6jWPzRW0dQ7E5SdVjaiOnkSXU+31LB638SHZ6LhKf7Ho+79pFQtqa+dqz
         lTI65ajDhbjRi0t54dceYsm2hluSL4lzl6PH7uW+3pqNX+Z9WpBsPJv+ivtXiOXVnJV7
         OfrdN2ochMYjP3ijJpDAKREAnuiBtSQESyHYDpAc6cNV0I68FXFLtgBP83l+LaVtGDdz
         E6fA==
X-Forwarded-Encrypted: i=1; AJvYcCXo0yezXyJ1QY4jsCFVlkKkRhda838G3gkwbptejk5UFNqNvh6/uq1zVdIcHQHaHRCl7u62j7QHzDxpR7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRJnARkRp02aad16HVEmS88IPYsA+FhnQLrtJmi8bICPmUwnJl
	9abrJjcULaHucXO4UAkvMkt6KT3IXr74MlAu0P50UpZm25PHWSKU+OfDSPbRxFM8r/SoXPMQ6s8
	vImxv0nYsLL+BvPlVjk05sGLwFS0u552Nk7ZI5PEI
X-Gm-Gg: ASbGnct/UT+CT7f0CcmzwAjzKxAUJbT680J2sdAlKg6CPx5vRgy8Kz5X4rPjoo/c2Q3
	vHqKl3amFvGLXCNSh/Jr0L5zOMLiJV3lp1pBTrKnkCk2qrfNEoqf+K2Eyo50uuvQC/lFz6jjcoG
	+jvreTAHTpUa4pnraAvMUpD+GypHfqUBMLWBtMne1bjELwK8NEYhPRvFVm2GWKiadUCFLRfWiNo
	WsUp9LC5I/OqcyS6wwOSpi8vGkM+kqg2MV0CO0=
X-Google-Smtp-Source: AGHT+IGOP2oC9TW27xuQkxQNpBJDuMKavhOqjyc8WPJQN6SajGsuHVU6YhsxH4O1jzOYq+/hWyBubJUFBHsPUi+NeGk=
X-Received: by 2002:a5d:5f94:0:b0:40d:86d8:a180 with SMTP id
 ffacd0b85a97d-4266e7bf005mr3031145f8f.20.1759941306365; Wed, 08 Oct 2025
 09:35:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-binder-freeze-v2-0-5376bd64fb59@google.com>
 <20251007-binder-freeze-v2-1-5376bd64fb59@google.com> <aOaSA0dPnY2I4a_D@google.com>
In-Reply-To: <aOaSA0dPnY2I4a_D@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 8 Oct 2025 18:34:54 +0200
X-Gm-Features: AS18NWASkyAzuiNEsEfeFUJmpejwxlM_VmjQJonfv_8L-HMyxpBNUlWWQ6OKXvA
Message-ID: <CAH5fLgiChj29SbwN-5vHhCNzaUa7wewOXe1D8mN3XFfyZr33gw@mail.gmail.com>
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

On Wed, Oct 8, 2025 at 6:32=E2=80=AFPM Carlos Llamas <cmllamas@google.com> =
wrote:
>
> On Tue, Oct 07, 2025 at 09:39:51AM +0000, Alice Ryhl wrote:
> > Consider the following scenario:
> > 1. A freeze notification is delivered to thread 1.
> > 2. The process becomes frozen or unfrozen.
> > 3. The message for step 2 is delivered to thread 2 and ignored because
> >    there is already a pending notification from step 1.
> > 4. Thread 1 acknowledges the notification from step 1.
> > In this case, step 4 should ensure that the message ignored in step 3 i=
s
> > resent as it can now be delivered.
>
> hmmm, I wonder what happens with 3 threads involved where the state goes
> back to the (unconsumed) initial freeze notification. Userspace will
> probably see two separate notifications of the same state?

The way I implemented it, the work items report the current state when
the work item is *executed*, and they do nothing if there's no change
since last notification.

Alice

