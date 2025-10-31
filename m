Return-Path: <linux-kernel+bounces-879628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBDEC239C6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED5BE42769E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF81328B77;
	Fri, 31 Oct 2025 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxqUeRtN"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A47927B32D
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761896958; cv=none; b=S97FamRZgeHW6MiB8jyEgFCFSm8la5SD39/T7ZoipSYVwZGcR2wKA3pi7Jgz2Ssi1GqvP4FovffpTl2y5D2TD4IdM/3n2W/+cOz8MJWoGNTDGJX+20Z5uuWJ2HFyCpu1nyGSg7zWXa9lz7+Q+zNWG0X+baujg9+cROU6t79BpU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761896958; c=relaxed/simple;
	bh=mj/okHz5PHZV0wR4OqbZRN7R8+J74cRQmf1t7fmO9CM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xm1OGXK99wFz9sQfrnagFShfTkRMiqFVXbv5Zn/yZ71WGNlwfD6fWuqFURJVdONbogi8143C2lZSW7KNcIN5dYfUYt+UOCrg19C4s3x7SMtjqtFNLFzCne2pFkvy9PZMbxCU3kasIOBm38RuJLPB4eKkRtgE3JYMnqlGlVZndp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxqUeRtN; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d71bcac45so22872787b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761896954; x=1762501754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mj/okHz5PHZV0wR4OqbZRN7R8+J74cRQmf1t7fmO9CM=;
        b=SxqUeRtNx+BaFjKkAlBbX7Mz9rBWZvOHFHBBx7DvJ5kbVTi/gEolF71Y0iXVrEy8wq
         gfim5iF35rbhHKYutLaDI8vk26onDVBH2uUPdH80t55bHluITtWBV5PBuLppl7Tztvw6
         8OH5GnMoTFAnMF0cI4GQoHXMWJf96mgeHxbLOxAG9QKDeE4j6sh9O5W0a3hPcEhUlbxL
         oIi3F3Od+j3vwyg/EEvlD+EzM9wbu7myXB9DMTsN5FnyVaGQ4LbR9wHXRfJfte6Dw0Ai
         aDzIn5lKow3KOKHsnZKOHdN5bmQi8HVNYNU1HlWxA4PYe3l9a/LfhsnH1xr8N2ytovnB
         Sq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761896954; x=1762501754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mj/okHz5PHZV0wR4OqbZRN7R8+J74cRQmf1t7fmO9CM=;
        b=wxeEeeMIVDcdpvKHNKekfaewu/bjCkurXdJbZ4p3JcyK0METbd8EAPHV0zVWPCc84X
         9ppPJ0j5dJnpBlyvkiFYkrZNLf23m3rjl9X8uksutYUIluT0EUwa2o2amvLCff6fa/G5
         eaQ0+Kdn0vABc3GNrW818Yi2nR2NPszz64mTy9f/CO7TsD9goZvytbQjMAaZ4yaElwR9
         T7hJh829QcO6GiR1IW7GLgZH7jQRFJlrTBglV3HafG7O8mCRUtVCvQJi7hKnNZcwiox3
         KfypW7eT/eTnGT5ELkpAvlhkYiE1a88mdPv9bWfcYvYIetUlnd2Hw4myfIDzd8f9vATw
         aGgw==
X-Forwarded-Encrypted: i=1; AJvYcCXVcs1Ulb8hA/5y0dYljSDUA/mKgSUIX6f7G8/Anl3OkK/86SBStuinueyudt1w943z7PszXiB/2yK2IQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuWCVRm20hFyIG35eLYPEZDaelgRTvMw+9gXWfa4Mkt3iP+OiW
	9UmeC+FiK+129Fme8JzzoAKYF1HB8rFAurG+Sv0ZDEXJ5m6ioSQND/QKu1tBkilbClBpnoXepBb
	UHf2ShoEnNlfYeBHdhAzqy2Ja948KyQM=
X-Gm-Gg: ASbGnctFa1MwfoOLGUKBm0o1mSY2mqOqoDki+6jvke5XdAqGl8yMdKi+56ABvAo6vJS
	XyEIOFMWQXCRzXSyh2LMruqrypnsOBgJMiQ7KPICndUuUR1aMXsBvcW86QCoL3ZiLwgKPur5ZfS
	M/2cJ0InhWtakWyu4qKf/hzcu3yokoUABsrIFfU43lHBsM5FSr9xQ0Ks+1Uq5sTq90A0/amdnRx
	hFpl503ikwGDXBfYIUlzuDjw383dlCIljSx4YTVgzB0HRiXsLPOUg7tx064GuQ9xuVoZ1X57FTi
	XzmfA4RrfKiotdLNnhRCHQ==
X-Google-Smtp-Source: AGHT+IEccNo+Ud/dOtRufb2gzRJKeSMooBpV7Zz3ch+oKF7jaIplRlzywy5u4xYHf4jy/vs0gsE5Pv+qfW9zHowBm0A=
X-Received: by 2002:a05:690c:3603:b0:739:7377:fdc4 with SMTP id
 00721157ae682-786484dd91dmr22017567b3.35.1761896954009; Fri, 31 Oct 2025
 00:49:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030064736.24061-1-dqfext@gmail.com> <CAKYAXd9nkQFgXPpKpOY+O_B5HRLeyiZKO5a4X5MdfjYoO_O+Aw@mail.gmail.com>
 <CALW65jZQzTMv1HMB3R9cSACebVagtUsMM9iiL8zkTGmethfcPg@mail.gmail.com> <2025103116-grinning-component-3aea@gregkh>
In-Reply-To: <2025103116-grinning-component-3aea@gregkh>
From: Qingfang Deng <dqfext@gmail.com>
Date: Fri, 31 Oct 2025 15:49:02 +0800
X-Gm-Features: AWmQ_bnGnl7eYzzqxU3isuAIhu5FYgWbwGA7Uh3VYsm5FYbX-qLmiqhxk1Hb_ds
Message-ID: <CALW65jZgu2=BfSEvi5A8vG_vBKrg=XLs68UoE3F3GBOOpeJtpg@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: server: avoid busy polling in accept loop
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	Ronnie Sahlberg <lsahlber@redhat.com>, Hyunchul Lee <hyc.lee@gmail.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Sasha Levin <sashal@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 3:44=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Oct 31, 2025 at 03:32:06PM +0800, Qingfang Deng wrote:
> > Hi Namjae,
> >
> > On Thu, Oct 30, 2025 at 4:11=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.=
org> wrote:
> > > > Fixes: 0626e6641f6b ("cifsd: add server handler for central process=
ing and tranport layers")
> > > > Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> > > Applied it to #ksmbd-for-next-next.
> > > Thanks!
> >
> > I just found that this depends on another commit which is not in
> > kernel versions earlier than v6.1:
> > a7c01fa93aeb ("signal: break out of wait loops on kthread_stop()")
> >
> > With the current Fixes tag, this commit will be backported to v5.15
> > automatically. But without said commit, kthread_stop() cannot wake up
> > a blocking kernel_accept().
> > Should I change the Fixes tag, or inform linux-stable not to backport
> > this patch to v5.15?
>
> Email stable@vger.kernel.org when it lands in Linus's tree to not
> backport it that far.

Noted. Thanks!

