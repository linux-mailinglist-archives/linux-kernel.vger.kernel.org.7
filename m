Return-Path: <linux-kernel+bounces-898625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA74C559D1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 05:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E5913B138A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979847B3E1;
	Thu, 13 Nov 2025 04:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mc1UOhnE"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DBA23BD02
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 04:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763006520; cv=none; b=u/lUbSisyC6HJWcZYTIcmyB3Aa8k8UruHwUfXsBTjgWrgda3reYCVu8nFYeSyW7n4u6xeKedXJwr7x0jfkhlA5Qv05u2pOu5lgRjIe9BUZpluKnAg3rwHIn4RlYimZZTFq6QSM93vmmeFslPF4Ye5Md5qzXTA2gGKuNkncd5MnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763006520; c=relaxed/simple;
	bh=fkCbXX32BT/rlU5p8dYlIrropSScZucjNWyXCAxT69M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4fQ1WUORciUu3+uiiklILIXEzJi2Wa/ivE+HiP078+9+wIfXUigu4W4yPhwDc1fXOdMmdULkuBEc72GEJmZxYnMj/MH1YpX+9KAPudD0SyH9RcHpFmfAOVR0jM5nyYCIyCkLOnawOC8QOsCdVHjP/yA0dTiSCEGBhIyUcEN5Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mc1UOhnE; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso492207a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763006517; x=1763611317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruk0C/2CNClZ5Kv+8DN1BbjisIWDyvg1zZIhMP8jZGE=;
        b=Mc1UOhnECDhD/aNOrcgPXuMV95ohgeHA3metK0VAmg6ReRu0IZaGTxA0GP7X95u8Q8
         yANgEK8G8P41T6Uy9/Kz5pUzF36Q3oShti9dhIj0DlCMKdt6ka50yVW0mzopHxta7n50
         fl3elEIujC2QfEPfjO5bLY7IVTyaWgK2tPqGsp08FDo9b/wibi+eyQCUpCzgPMs67nZB
         R0UMIsFP+eUNJY+HIxoDVQxoC0dvJRsEu4adqfrHoBfEqNGGt4pSy11CMCs17lcS9Vd7
         2ml24/Ftcq7cmD4WFmUtn4j54RGqQHoz1muhn8Ds0fNyJrwOUTjed3kXZceVobEH+MyR
         iNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763006517; x=1763611317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ruk0C/2CNClZ5Kv+8DN1BbjisIWDyvg1zZIhMP8jZGE=;
        b=KeJMF9bw3rtv4TIrmVVSw+eVgRSaDI1nDzCKROt3PW9AtK2bOyoamdfOoVk8aA158i
         G7QVpCfBGLe1Owf5txVisc7inyaMsFnjMdFngPY6j0a75SwGSVs0WYtmpnZvGZwfWOAv
         tIMxtDpFg/ieabKNnrPkbH8wteSEONUJGKsa0jYzbexMKmRn7SbtrSO0qnu/Wp4NAIvJ
         kM81hUUEZDTY4s7ZMqV+7I4qA62ZyEl7VwBsIV7ycxFYD+TtNpGl68vt8lAdPdV0I4XS
         BB5fFyKbflOT/PjY7VybGDTiGvBqFUI+wIa0MMTnavwEv7CCk4cEmtKINnd1ES/eBjN1
         O31Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6hDCSTcrDvnt2XsYtjEMl+/iCKKwv9lH+DSlCnoZIOgL8eOfkNHbj1DMhGIF30eYbOpTiueXfJ43jEnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGeAB1dfltfzJGhcXndXkpWpMvb/webZ/w3b6e4F2P0c6VfCHq
	rXDQvIjHtOLUMu+ljlO+QARsFXcb488lnYy7lPHiEE/f9X/l5sEr85L17OSNvnRtLvfMCB4k02G
	3qPgtaKV+oMMbVKX88nIDFbL7A/hZsTY=
X-Gm-Gg: ASbGncsecesKhwtYEegAB9rX0e3kJPaPFAvROT8EhXPGw8raKDHCuO2C+8BAOulhvBv
	8CcFFpJzmp/9+/XJWPznHLlcYQ9Yh+vcrXM6VII+1WJw3TIZDfCE8jh3dn0DDhlJR1pRcj5c1+o
	IizJOUZ1p5Vt/nrq92SwDy3+J/6cET1X1CCthR+Pyb/LWzqcG8PGc+b2KK/habwlPCaaAUPr10E
	MYkVLUwht/VN+X4+eX+YLQQZCJyHvWxABsgaRxIocIgxddzMNTb+CnvMNtczBmgzg5UfB3XOSNn
	dZH/m3sx/uflPOQ=
X-Google-Smtp-Source: AGHT+IFXLl7x2uJRLoXlx277Si5mBM8h/gS1p+bZUwni/MfCDjn87uckvcbYakQIrBl2+ZQGH9ohDAV+xs6EuIVqfj4=
X-Received: by 2002:a05:6402:510e:b0:643:18c2:124e with SMTP id
 4fb4d7f45d1cf-6431a392eebmr5125372a12.7.1763006517205; Wed, 12 Nov 2025
 20:01:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030035114.16840-1-alistair.francis@wdc.com>
 <20251030035114.16840-4-alistair.francis@wdc.com> <8a236ca6-3675-461a-9166-4d4df3b5de08@suse.de>
 <CAKmqyKO=W2+5ZBudWhN_L1choupte9vzJBEoxVeZ-vNHykeR0Q@mail.gmail.com>
 <20251112070256.GA5276@lst.de> <c7679208-c963-4fdd-a038-a91ccda0a075@suse.de>
In-Reply-To: <c7679208-c963-4fdd-a038-a91ccda0a075@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 13 Nov 2025 14:01:30 +1000
X-Gm-Features: AWmQ_bkICN55tPuzDm6zLa1MtEfNqZymtOObpTTa8T2RNOSB_QTCazWXu8t0Tv0
Message-ID: <CAKmqyKNZj6gwPOBrjRk_vTJqpUTPTsHF5S0iQPgVPi4+NHP7uQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] nvme: Allow reauth from sysfs
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 5:21=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 11/12/25 08:02, Christoph Hellwig wrote:
> > On Wed, Nov 12, 2025 at 09:32:00AM +1000, Alistair Francis wrote:
> >>> I would suggest just allow writes to the 'tls_key' attribute; any
> >>> writes to that would trigger a replacepsk operation.
> >>
> >> I think the `tls_configured_key` is actually the better attribute to
> >> write to as that is the one that updates after a REPLACETLSPSK
> >> operation, see v2 patches which I'm sending now.
> >
> > Just saw Hannes reply here and saw why you did the current version
> > the way I did.  Hannes, please don't recommend weird ABIs that
> > make error checking and future extensibility impossible.
> >
> Hmm.
>
> 'tls_configured_key' prints out the value of
> ctrl->opts->tls_key, ie the key passed in from the 'connect'
> string. Normally this value will be empty,
> as the 'connect' command will pick up the TLS key from
> the keyring automatically.

`tls_configured_key` does print out the value of
`ctrl->opts->tls_key`. That's the key that is generated in
`nvme_auth_secure_concat()`.

`ctrl->opts->tls_key` is also the key that changes after a
REPLACETLSPSK operation. `ctrl->opts->tls_key` is what's used in
nvme_auth_set_dhchap_negotiate_data() to determine if we should issue
a NEWTLSPSK or a REPLACETLSPSK.

So `ctrl->opts->tls_key` (and hence `tls_configured_key`) seems like
the way to go

>
> 'tls_key' prints out the value of
> ctrl->tls_pskid, ie the value of the _negotiated_ key.

Is it possible you have `ctrl->tls_pskid` and `ctrl->opts->tls_key` mixed u=
p?

`ctrl->tls_pskid` is set by userspace via the nvme_tcp_tls_done()
callback. It's really more of the "configured" key as it's supplied by
userspace and doesn't change after a REPLACETLSPSK operation.

I'm not sure why the sysfs names are what they are, but
`tls_configured_key` seems like the negotiated key and `tls_key` is
configured by userspace.

>
> So why is 'tls_configured_key' key the better option?

`tls_configured_key` is the key that changes after a REPLACETLSPSK, so
it feels like that's the better place to trigger a REPLACETLSPSK.

> Personally I think that 'tls_key' is more 'natural',
> as we want to replace the negotiated key, not the
> configured key ...

I really think writing to the `tls_configured_key` to trigger a
REPLACETLSPSK is the way to go. It's the sysfs entry that changes
after a REPLACETLSPSK command. Writing to 'tls_key' and having it not
update just seems confusing.

Alistair

>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

