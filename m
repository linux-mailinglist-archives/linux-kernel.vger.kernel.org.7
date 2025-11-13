Return-Path: <linux-kernel+bounces-898978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CF6C567B6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AEA04E392F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DEC340A79;
	Thu, 13 Nov 2025 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fxGTiEmI"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159A4332912
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024125; cv=none; b=iDtckWfM3+uS7wwmww9oNQLZ/Z02qi6gVOMXlWT5hlKt2UKkkNWnj71G4tjbMXtRk27mGmn6+phKUOOHBPu0B9RmB8/X78Pbnb9MjRFUOqQMEjHzJ3jQ0iw83e5fRZzOmMzBNw14AcUtyIXWxWpJo2f830w864vf8uQKFN5Zha4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024125; c=relaxed/simple;
	bh=oqFFefcanov3Um6l3KaQ3SgfwADSa1KKIsncfWKh/BM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1S3tRCp0egcXskt+xrcjztoHyAvVmCLnGObxiKAwJu6911MEgrDJNSrP8tCXZHgEx9l6BSbAuKURcGGVLsrvGPCOp08bKqmcRhyKlSzKIPA2AURGrPQAYlj6aqBfv0LhqFSkh7Sl7fmei9nxyngDkLh3yf0UB5uXE6ELK3u/HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fxGTiEmI; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-37b9728a353so5096681fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763024120; x=1763628920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqFFefcanov3Um6l3KaQ3SgfwADSa1KKIsncfWKh/BM=;
        b=fxGTiEmIPITtpBRA1lSFEIdlJr1gfpBqic/I5HNF9HyNUa6T8nsHQ66XHS4jESevha
         3EtdEuMFD7hnUAhByP/A3g8iydvYz+z3BtqXXxX0v4qg08xjXWAutV/ZXoTgPt44Wmlq
         VvN7HJdi6vn6iO1V5gTER7iqMmd/ngIJg/7unZv/4FejkaplDmxrVdbtOoTQS5sFbE/o
         GW1VyA9hYTVsVsLumqoU97cDNJ3VfMahyJ77uKJ8qTP3mQusW5UK7fMOGg6+R0PZB2Ij
         fsgL0F2bFGdoPlAovaTxXmxGt0Kn9B53R46rYfF6/6/ccCSdg1ZoOtKpZ9q3t06U6Ej+
         2B/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763024120; x=1763628920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oqFFefcanov3Um6l3KaQ3SgfwADSa1KKIsncfWKh/BM=;
        b=rd1DAQC24FJmJYY8mUKTxhicI84sR7WoU96m+ygOuwAaI4EkWFim+3uqpE/pTDHoV7
         l+Ruk/kZzmfmdMbHYKec+AP59vxd0kFuYH6fsOBr2cG2siXJzs1bx5ARFWC+8DiKkIgQ
         qmRPRDFD4YxXolX1e0AvVws7OmRDWu7DhRx2NkHAzoXPvKRcAzFXrvpA1YAI5bZ6jTw7
         tGh5E6jQGYSnSEX/uJ+9pQRCKhQ4Ia/xGObBYSTYTHkwi+F8usagM1AIGinmHQdgYhnZ
         /5GDUZY7ridn+hsR56izCNzXtrULNa5rNjOVhYwmJzaTQun7E4/eN5THwFw5qPFihvFq
         8+aQ==
X-Gm-Message-State: AOJu0Yz2omEYf+mNMMqO/QjtYvqWcNuiq01o9BTrJ1pWbHJkgyTwItbs
	VJcVklC5Aqr+eDMT2i7sm6tjaSvBajdPZo3lnuxl2EY68tM8AvsUpLVvSNHrRSdJPbJM33R4h/K
	UT+mlaTrN6zf6wByb1RUyPuDEP44oCwMcLKhMAvLRAQ==
X-Gm-Gg: ASbGncuq8jn7+LEVC2JQqF8asKZz52QtCTRYe57jXCbqFSAxB7CT7gPn6yQHXnpeebW
	zYeTOXWABzkhMpUNlzFxJlj9+RXahBQfesquQ/b++ldS+Ncz3QcizCkB3zhPhT9AsBQbST86XLF
	qZipzMxs+HwIC9NWp9V4g8Sy+E10qGBrD+ZZ3vPDgnNjNeBrsreQiQ/Teh37oJIumPX5O/3H4aZ
	OqlP7cSDJjVqnrk1JJo9PjXyxWQCpHEPXCO49o6XpKuvOB9jeNvntJhEte5yU8+oGBp776T91Te
	79+YjyxVwN0eqGNMgg==
X-Google-Smtp-Source: AGHT+IGhNZssejb7sPGrO4L/+9VcIHDp1nlVWFAAUidHbPBR/ijjPcKhcW+oYOoxYOCrlVAvlykPZrOv5uuq4iVhn5w=
X-Received: by 2002:ac2:4c4d:0:b0:594:31af:4de0 with SMTP id
 2adb3069b0e04-59576d9c67emr1905817e87.0.1763024120126; Thu, 13 Nov 2025
 00:55:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031095643.74246-1-marco.crivellari@suse.com> <yq1wm3ud5nw.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1wm3ud5nw.fsf@ca-mkp.ca.oracle.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 13 Nov 2025 09:55:09 +0100
X-Gm-Features: AWmQ_bk3lDKoQX6ocQVr8RbfDQjAOX0gR7NyBotclXyjQUjDz14brjHk4rM_7vY
Message-ID: <CAAofZF41Jn7o2KdbwHCHjrspHub-pLdOrs3Dp4JUKUij8MG1eQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] replace old wq(s), added WQ_PERCPU to alloc_workqueue
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 3:38=E2=80=AFAM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Marco,
>
> > Let's consider a nohz_full system with isolated CPUs:
> > wq_unbound_cpumask is set to the housekeeping CPUs, for !WQ_UNBOUND
> > the local CPU is selected.
>
> I applied this series and your other applicable workqueue patches to
> 6.19/scsi-staging. But ugh, that was a lot of work.
>
> Next time, instead of posting individual patches, please prepare one
> comprehensive series for the entire subsystem and submit that as a unit
> so I don't have to stitch everything together, deal with dupes, etc.
>
> --
> Martin K. Petersen

Sure Martin, thank you!


--

Marco Crivellari

L3 Support Engineer, Technology & Product

