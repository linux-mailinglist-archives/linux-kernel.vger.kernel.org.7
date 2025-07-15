Return-Path: <linux-kernel+bounces-732584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E70F8B0691D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2366C17A90E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EBD2C15A7;
	Tue, 15 Jul 2025 22:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ila4cXPc"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B41DF76;
	Tue, 15 Jul 2025 22:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752617475; cv=none; b=tlLhPvZSxJxpwe1D2s+cbUIEL9qd7SCtJwk12kbSSBXfWqubqI2I+dwrj1+Fdf8ioHVh7uBxpRhGWnSVNMecKRd7WpwM3UAnu1CZmmoNGy5KXhJKKWQcUedffNmIjeXDxRS4zm97o1kDJcrJZf5owJF5boNYLRdfu+TySPjvb+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752617475; c=relaxed/simple;
	bh=/dfXrEHD5LWNJo8S+FdlRH17OJZoWda9bkjTUWLJNp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qMpy3+SsVioWl/JalnzXwPRRb7S2gGVKkTo3fa9XH1SeOFR57nDcwDLvQoWFu2gPmzX3169JsAYD7l6QXXR/yvoTO5vuS2ebZtjy2dxOmEqR1FLElohaSb04vraM9/l8b/nrbkjQuzdz3SZV0hEShOe4yclc5TsODK030559ULY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ila4cXPc; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-41b1ca1f28cso1209460b6e.1;
        Tue, 15 Jul 2025 15:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752617473; x=1753222273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbI9ihowVv8CtjBa6m/5OA0ET/gDNLTT+t5LJJNLHDI=;
        b=Ila4cXPc5wsSH5yMajQ8BZr27IB4myMPZhI2skw0Kn9ww8kThy0EfuyqZB95IQvkge
         mEzT8fDA2PpS615liJBkNXjFIxIdh4eV1Y8h+8ibATRMtZSZdKtNFRTDQo1NVfIk6+n2
         hbWiZzAdivWD5VRYKgPKx63MrF+zoJkjSTmocjFn7xgScbV+Ulm8vuDh7u9b8kOsaiR7
         ibCwpzO8w+EutA5Y18QPyWaHpTe91ZvZwI/HSNYHvlrwTyX1KWdKaotVdYoXWqA6jTxL
         fuVX6bXo79kYYRWEDUC/bOs7EJuES58TIRSmhFxNqNwHaFhpsfHV1T7m3wMksXS6Exw5
         XN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752617473; x=1753222273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZbI9ihowVv8CtjBa6m/5OA0ET/gDNLTT+t5LJJNLHDI=;
        b=Cul44k867lasMxlG6h2LBJsv78WifSbW+XSS/u/2d97VCYWcTTCXMIkYFmEPvTRylG
         6dM7wwcKbZyJWUU7azjnxwv5iRlpGgLK+anMtcjmPQ756B3vE42gv2q4A4ZD5EksUcQ4
         JbP7L6b5NqcDsOmVUrIgUnORc6QmqNHkm3E5oYrDztI2eC7wlRCoxi+Nst8rRgCqZ6dt
         JB0jAD4wU8iGpgKubQYQNh+wS9lnHpG+6j51kQUghWZAtFY9qa5BS/vj6zzlCtf5u/IL
         9FHndWertlkYm1gzYICSAjhWgeUkL/YuMw8d53YSSTtOKVUNUqpEyHgmBfiT6bo6d/QW
         LVTg==
X-Forwarded-Encrypted: i=1; AJvYcCVUrddbATf22PqCHoFtHPRAKVVEnm+UnQfEKAVrRpbNyzuJKgTPwepbLWqs2+vPMGgtQwWxVP4QYC11@vger.kernel.org, AJvYcCW2Y/M77osxcbX7ssySUrbiL9HWFdYC/zdsNFCag2rjwub6yW7H4DedCzdF17YEADu1eZWRUqBsh22BZZRo@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz3RB9D6XBavawI6d3I4mCvEEeCXG1rlkgk00nzPrWfcSK8cn/
	wKUyPzoZWT6R8uVIsyDLMCFwGVE9X2vPjc/acakeTRWB2a2d9bNn4KiENRi/Lrz8CMF66bNnq5O
	Q5ds5ZaPlO0FWITTBgr0iFDoZwpoKCUs=
X-Gm-Gg: ASbGncsCaL4MovnTTovLzObb6zYMy29yUmWIlz1+O/wHoL1agUR1a3NxZQ52XmWgqo1
	EmHtm7otpYHkrCgr42CIkig/H4pv7yW5+MHaEHxADdHWTX0THxIevnTIhHpADoYUfrBhztxrunO
	F3AlSGvGZxCTKWg627096Xe2c7XW/I9KSD4SlvMOeQUkLKkhnwDVx7M5Kc9vfkBiIjY3EXUB/aX
	pMbMX6N
X-Google-Smtp-Source: AGHT+IGoHhMbBQXjyBcxgr9jpiV5+fAtALUG//n+FivI3N/qkbXgWlenBt0IKpzxq5ZVRyBBUhDp5LDbSwsZfe/UeKQ=
X-Received: by 2002:a05:6808:190b:b0:41c:8e9f:3853 with SMTP id
 5614622812f47-41d038e1b01mr367005b6e.13.1752617472967; Tue, 15 Jul 2025
 15:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609031627.1605851-1-peter.chen@cixtech.com>
 <20250609031627.1605851-6-peter.chen@cixtech.com> <CABb+yY17OOBx73655OhBp8At1b81w9M61zzGu4uhXcMTw4Q=Dw@mail.gmail.com>
 <aG0i75h32dWg/L2G@gchen> <CABb+yY2BmqiQ18hU+7C234UnY8n-8PH5VEoS7nH5Xq5O1krGhQ@mail.gmail.com>
 <6b5f38f7-0557-483b-9252-cfade7a24cf5@app.fastmail.com>
In-Reply-To: <6b5f38f7-0557-483b-9252-cfade7a24cf5@app.fastmail.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Tue, 15 Jul 2025 17:11:01 -0500
X-Gm-Features: Ac12FXx1y9xaaVn7eKkY0Gzou_yfDgjczblmTIjxslc2qDlMZ6VVtwwaRLEk8wk
Message-ID: <CABb+yY26R_DHQUhpg-xUR_Z7EnjdR_4LPai0M-vfFTAOZy=vvQ@mail.gmail.com>
Subject: Re: [PATCH v9 5/9] mailbox: add CIX mailbox driver
To: Arnd Bergmann <arnd@arndb.de>
Cc: Guomin Chen <guomin.chen@cixtech.com>, Rob Herring <robh@kernel.org>, krzk+dt@kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Peter Chen <peter.chen@cixtech.com>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com, 
	Marc Zyngier <maz@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	Kajetan Puchalski <kajetan.puchalski@arm.com>, Enric Balletbo <eballetb@redhat.com>, 
	Gary Yang <gary.yang@cixtech.com>, Lihua Liu <Lihua.Liu@cixtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 10:40=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> On Sun, Jul 13, 2025, at 19:00, Jassi Brar wrote:
> > On Tue, Jul 8, 2025 at 8:54=E2=80=AFAM Guomin chen <guomin.chen@cixtech=
.com> wrote:
> > ....
> >> > > +/* [0~7] Fast channel
> >> > > + * [8] doorbell base channel
> >> > > + * [9]fifo base channel
> >> > > + * [10] register base channel
> >> > > + */
> >> > > +#define MBOX_FAST_IDX          7
> >> > > +#define MBOX_DB_IDX            8
> >> > > +#define MBOX_FIFO_IDX          9
> >> > > +#define MBOX_REG_IDX           10
> >> > > +#define CIX_MBOX_CHANS         11
> >> > > +
> >> > if it is not really a single controller owning different channels,
> >> > maybe implement only what you currently use.
> >> >
> >> As mentioned in the previous email, a single controller can support
> >> multiple different channels.
> >>
> > OK. I am not too worried about having all variants in one driver esp
> > when it is manageable and share the code.
> > Unless I am overlooking something. Arnd?
>
> My main worry here is that the types are all quite different: while
> the doorbell and fast mailboxes are what a lot of other drivers have,
> the FIFO mode does not seem to be a good fit for the mailbox subsystem
> but instead looks like a more generic firmware interface with variable
> length messages.
>
> For those, I think a higher-level driver with fixed data structures
> passed through the hardware interface seems more appropriate.
>
Yes. But sometimes when the data structures of a protocol are not
bigger than FIFO depth, the platform may choose to use the FIFO mode.
I see it as platform dependent.

> Are there any other mailbox drivers that just use the mailbox to
> tunnel variable-length messages?
>
From a quick look, Armada 37xx and Hi6220 have fifo though they fill
them up fully for each transfer.

Thanks

