Return-Path: <linux-kernel+bounces-898517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C90BC55732
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58ABA3ABC49
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA7C219A8E;
	Thu, 13 Nov 2025 02:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpYZYZ+h"
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768021EF0B9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763001298; cv=none; b=seG13Ar59Xkhz4FJq/NUzYp5+WJPjIk7lbnH5j8jJ0kuWb+P6nifdwc/RZ+I4ypsV+z+qtbVaXLXWcmqXODuOyWLXPIWCL1O+hTFk5Tksh8N7A1s/eye5If2V2QJIGkimSmrmOGIjoCktwSJnC6IVD5duPvCEbikytVOH0Bu09w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763001298; c=relaxed/simple;
	bh=2be84pmSGoqY5LY6UKe7Kjzv5ECj0W6rD+fdLU1Dgdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASdUVQesmywzub6PdP7R5e5B20CTFW+JovthvvxAMf8s085UNBFILXZSDnVdl5bTMNJcpca4GcFltRYzWb/gZCck+ZtxzmAPIVVrZ+Qh/EldeBFDfIeqSU/RZSY09FxAMTqo5m61zOIa16/VcxlX3PwOzqnByTzZO1BxnzsS0JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpYZYZ+h; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b7291af7190so35932966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763001295; x=1763606095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zv02JfQdgNQDAuVUUhZD9gwf/2OoSOdMlkTDlq5Wbwk=;
        b=KpYZYZ+h1mVzvUhVP49A9aTVZV2U8caBqLuRPOHxrgUz7g5ZH41UhKreWoI+PJ9g8e
         GnEs3HgWv1NcDLE+eWqanGWE6Y4vvsbQHD1MqHrAi3jGFBqxv2NGg7zmoXngkqSeZouI
         yGeifwVxWOVYV18IisWapCqO4gSUgRBnEq0NFw0p7CP2NUcimrN5FspRzRqyAnSkoCUN
         6lAQBKy2GhYxc7Z7j3y4ncrHaWo6haw6tDtmZppsFewmj+UQGSBz9FEi+NVkODqlFO3+
         MC2pEdxne9CHoEVW7JALOFXDT3/MqvaT7b6xaFMzUXTQv54+vpaILVXhQXXfMvoGQhUv
         Q86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763001295; x=1763606095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zv02JfQdgNQDAuVUUhZD9gwf/2OoSOdMlkTDlq5Wbwk=;
        b=dowJUY4X2hLuH0YzfOCOahs9lAnqUTtk+efwI7lYpZ9fWwaSveCK+qB9s6SbpPTOV/
         lAEOIhrL40g/2OLzdCbZkorjlIlzPR+HqNY3J26NfMgmOwsAMQjm8ES+eviRXuUi7baP
         g6lQN51BlVzdzQ1Hem0nEkOfh9YNeY4IvfrXC1tIE0DWWMoLe3V/CBEJK1LXGhladGJc
         QouxbsG1w1SZDRQscmJm+njDVI9TvZUFmjzpEk6ch4muK8MaimcYTX3gcMN9LrMRbqA6
         w16FmzpxiORZkQJ4FeUfGaiM2rXujs+RE6ustyM2nPkqJps+pec/PwHnIZfxaCuvIx0j
         UtDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEbVR4I5deF7ezWUZIT0dpnyLC8m6gWerFnSTtukZGhKNPYXG0S4+0mNT203X6CZC9l7goOAEdEFWNKOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7rGqOkNvRC7ZSYngPi7uyfQlugKGwA00QWqg2OVPjM4YoL228
	0dy5mVMwW0daOyZ7cMCBqjSl5douCLGEU5twyBbbyndSYLWf42efXxFfPZIUJVUhJj3wQzc+qh0
	t9DhbBSjNLoM5tLAyUvlVFKQqOzlQqJ0=
X-Gm-Gg: ASbGncu1qK6EkMSoBAV5sGq3tOH99EK99akkvDljQadoZfmdrawI26ejZmqF1Lf8XLx
	DmdMCxrh5PW11E4ISMl4W8qGT1Xw2mJ+x00p7blG7wwMYHXHwMv5bZyXeupxSNtpB2x9CmHPrPC
	Mek0geOjARlrH/levWYE7K5NDWaHk1X3oIoycs0yctnFfegIEfFop0XFuGfICJnY7JLg0uMYlER
	5s0p9ST0duxspebzQ+t/h6DOnYs+tbUPt4YHXgUtR2ZB0Zef4gGKTtoqLwhlVql2WWTa0pJ
X-Google-Smtp-Source: AGHT+IHnM5JSPUAxCvA9H9uZ3tXrWbt1AXlQ5LnzI4R1/1MgrQjv91aPRT1UFoRpJikcTedZWVwfEVHUSRM43aX+kGo=
X-Received: by 2002:a17:906:dc8f:b0:b71:8448:a8bf with SMTP id
 a640c23a62f3a-b7331aec77emr541405966b.62.1763001294763; Wed, 12 Nov 2025
 18:34:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN2Y7hwttMyUn0qsEcSBbrQ1h+aSzNpHMhgAxEbqJZn4vf5hBw@mail.gmail.com>
 <aROfRBGmglPgcPVf@slm.duckdns.org> <CAN2Y7hwUmdFMM=mwYq7gsBpbSEBq6n0nXzmES4_=p3fDV=S+Ag@mail.gmail.com>
 <aRSvxyoWiqzcBj-N@slm.duckdns.org>
In-Reply-To: <aRSvxyoWiqzcBj-N@slm.duckdns.org>
From: ying chen <yc1082463@gmail.com>
Date: Thu, 13 Nov 2025 10:34:43 +0800
X-Gm-Features: AWmQ_bmqqpz2BzShuLtpfDU10VTxD7EM0FTkyssYomi0u4miw5mWWt5iNq3Aejg
Message-ID: <CAN2Y7hzDZxt5tBPeqwKwNNwwGXgmhj_uYDMkxx5_QtoqV97v1A@mail.gmail.com>
Subject: Re: [PATCH] workqueue: add workqueue.mayday_initial_timeout
To: Tejun Heo <tj@kernel.org>
Cc: corbet@lwn.net, jiangshanlai@gmail.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, laoar.shao@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 12:03=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, Nov 12, 2025 at 10:01:10AM +0800, ying chen wrote:
> > Works that have already been scheduled will be executed sequentially
> > within the rescuer thread.
> > static int rescuer_thread(void *__rescuer)
> > {
> >                 ......
> >                 /*
> >                  * Slurp in all works issued via this workqueue and
> >                  * process'em.
> >                  */
> >                 WARN_ON_ONCE(!list_empty(scheduled));
> >                 list_for_each_entry_safe(work, n, &pool->worklist, entr=
y) {
> >                         if (get_work_pwq(work) =3D=3D pwq) {
> >                                 if (first)
> >                                         pool->watchdog_ts =3D jiffies;
> >                                 move_linked_works(work, scheduled, &n);
> >                         }
> >                         first =3D false;
> >                 }
> >
> >                 if (!list_empty(scheduled)) {
> >                         process_scheduled_works(rescuer);
> >                         ......
> >                 }
>
> Ah, I see what you mean. The slurping is to avoid potentially O(N^2)
> scanning but that probably the wrong trade-off to make here. I think the
> right solution is making it break out after finding the first matching wo=
rk
> item and loop outside so that it processes work item one by one.

Processing work items one-by-one is indeed an excellent solution.
However, wouldn't it also be necessary to provide a method for
adjusting the mayday initial timeout?

Thanks.

