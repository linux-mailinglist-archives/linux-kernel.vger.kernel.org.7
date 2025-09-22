Return-Path: <linux-kernel+bounces-827584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C60B92273
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A47D442F07
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F823112A3;
	Mon, 22 Sep 2025 16:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzDrXIPX"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE481310785
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557670; cv=none; b=lGK/66z//OiSkEd7LwbhDfgoeCE/0WtoeVj9tUfj7oM+sqpLXoFucTwiSNxC0m8RSD4BYTQXYPldsz+OHI8Epc2Su7NSj15FZXCKCswcdvgRXJjlk93mMJ7vl+jEpk3UHfBEyN6mZB5fLSwbvXofQ57M0XbZMZ8Deu0Qtg2iAms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557670; c=relaxed/simple;
	bh=30ZsOOdTdIvFOBRZCGShkP5CSMuuIYqi33XXYVJfMrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BG8ghiujZMwcseBWJPpkCkzZ3MhMPXa2EAkJv055RxniUycfyeZv0wgXWKnTHn2lU7QslDUTcWmCTMw1S9z1JXsHQY45R4Jq++o51lPqNN+cUj2656XXzKYBRd9z8Z6QsmpzkHwnkV3udohTB5/tAVUMTL4Ss7e2D4EkZLxqNvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzDrXIPX; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-7bb414430d4so12999896d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758557667; x=1759162467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CBVYfoU6o53B/HSfKNkUVa7COgkMVy8im6SMIh04P4=;
        b=JzDrXIPXRU2UCSSn4kuBPixSk1g/FtByvAx9hJU6MtwShiUTTBSYP/y1P1eIoVZ2NJ
         KKIdzo6EjVmyh0o09eyP4swRVgk4q3+Wh9dHeZpjgnzZCdjT1Q1QzlmNvIIHL9RAHKuG
         kp6DfyjiqfbnN4sIqxfL2JDtTok/LdMTL+No8Cq6a3k5ERJGfpzeh4y8EuN+c2QBSvSV
         x9Q5evHnn459lMMx9u7tIchbsvooGHXvlTdOmdcYyc2GMYVpKGQtSzQLjTOuCR7CxvSQ
         BjiklwLT9cfvUCqpAZOW5g6p6oLfsuZM0CjyMd/jY969gG9OyQNUjjOEM1IiHYcNerrN
         j25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758557667; x=1759162467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CBVYfoU6o53B/HSfKNkUVa7COgkMVy8im6SMIh04P4=;
        b=vTSoOmyfR+TENXWlDfGgJApvkMjAZmNFQDEYBaiSUddSCkH5TWCVwB89l4V7w7YVOp
         ywXIOb7xh3MTXpTmVlPPp8twvOvhS2e6ISttxu7CWhwP3AwmAsQeSOJUwFujvTXms9B8
         cunK6tqpf2u6GqYwzRncHTEc591vzrtiTGzJ6Pztb3YrtkzRylXG4xs5Jg/f7IK7CQKu
         MAArsE4CLrGll/weWkLO0ZdhfjBhZbHi6nKdC3P80YQ8u4zUTlEK6IY/X5wZKZk+qpUP
         sS0MQvgVdQ0gJlW/HB22Vv/5vJqLvkg/N4XffR9isv44KGvQS1p7cCyWRMsnKRvk65rY
         zFOA==
X-Forwarded-Encrypted: i=1; AJvYcCXa52x1df2LuPfvxZQ99+eJY1BI20qYu5LufFT45o7ji7dCFQsYOzNmwK3qOQlbeThT9a7uuxuRMMw0HM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx505GR5sNE2mB3L07bzESkRx9c9Gin3MLfDbCcMcKp1US5I1X5
	deCAyZyTVYeFub0FzntiQEcArzQsF8EfdN+rX2K0oOPSId4iYuQVYFpcamoKjnplWg2CJJwkQd9
	2f6u0Ujw5fVu4g1n25xOiSTPM2ipLbK4=
X-Gm-Gg: ASbGncvsiagBtUEPaWIneou49LrElBtlrbYaKngFGjZTY5LfWyFcO5UjCckB/5RZNrZ
	/nKamNo2tNqNlu29z01EC0slD4HQz9dMJdff0rD2kp3PKvWdFUpR9dosv6UemYY6wKk4p4UY+wT
	121+pQnbRIrfyD7kJmpLMlqOi25xbbx6dpuXuW+LsaKsjXESGkR51dib26Hizure3jqZbVCGRGA
	x4yanjdj87ErZ65a6pxHGHJsqELVPFHps2sll9tZs5cmwLOeQody7vP4CuKh6G1y3ww3iL8QrUs
	7dS1Bc0nrc+pK/kQqudoxhAS4fL+K8TY/DyuLr7OdtKwqueLF5sjca54ZD2K3XQcSh6tU76RNaO
	1cQ+nODh5Q4KdvcMWGeyD
X-Google-Smtp-Source: AGHT+IEqZU/wF0sn1DWt8sMOHpiPXw7fk9nZf6HIqD/usItSrrexiSvbEo6NMOuRV89WWu9lrxUB2IlEFQz8631SxmU=
X-Received: by 2002:ad4:5f88:0:b0:77b:3734:8a6e with SMTP id
 6a1803df08f44-798c54f30e5mr145325036d6.29.1758557666331; Mon, 22 Sep 2025
 09:14:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922082417.816331-1-rajasimandalos@gmail.com>
 <da3e2b5a-a5da-4526-9884-8789990ebf95@suse.com> <qmf3xwqq4hqj4issgci2g76eghytaqxihnrp236ithh2istkkf@n4s54vp3hblr>
In-Reply-To: <qmf3xwqq4hqj4issgci2g76eghytaqxihnrp236ithh2istkkf@n4s54vp3hblr>
From: Steve French <smfrench@gmail.com>
Date: Mon, 22 Sep 2025 11:14:14 -0500
X-Gm-Features: AS18NWCMq_JNOli-tfaoAf_osXE7CkxbRo-UTZnodnIN7idYXbnwuLpYslWJ6-g
Message-ID: <CAH2r5mu9xUQz5e1Mf-dBCNh2_y2jnxPYMhmuHr1bVqKC6atd8w@mail.gmail.com>
Subject: Re: [PATCH 1/2] cifs: client: force multichannel=off when max_channels=1
To: Enzo Matsumiya <ematsumiya@suse.de>
Cc: Henrique Carvalho <henrique.carvalho@suse.com>, rajasimandalos@gmail.com, 
	linux-cifs@vger.kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, linux-kernel@vger.kernel.org, 
	Rajasi Mandal <rajasimandal@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

. >Do we even need ->multichannel flag at all?

Yes - especially in the future.   The goal is for the user to have
three options:
1) (preferred) "multichannel" (max channels will be dynamically
selected and can change) the client gets to choose how many channels
to connect to based on what it sees in the output of the most recent
query interfaces call (it can change on the fly as server dynamically
adds and removes channels or networks become temporarily unreachable)
2) "max_channels=3D"   This is for the case where user wants to choose
the number of channels rather than have the client automatically
(hopefully soon in the future) choose it for you
3) if server has mchan bugs, allow client to mount with no
multichannel (or equivalent max_channels=3D1)

But ... "remount" also has to work for the three above (and currently
doesn't) and this is what I am hoping the recent patches can fix (?)
but haven't tested them enough yet

> I'd actually like to propose going even further and having the whole
module behaving as if multichannel was always on, even with
max_channels=3D1

Obviously the goal (would love patches for this) is to turn
multichannel on by default, have the client select the appropriate
number of channels by default etc. but we have to let the user
override it (as described above)

On Mon, Sep 22, 2025 at 9:59=E2=80=AFAM Enzo Matsumiya <ematsumiya@suse.de>=
 wrote:
>
> On 09/22, Henrique Carvalho wrote:
> >Hi Rajasi,
> >
> >On 9/22/25 5:24 AM, rajasimandalos@gmail.com wrote:
> >> From: Rajasi Mandal <rajasimandal@microsoft.com>
> >>
> >> Previously, specifying both multichannel and max_channels=3D1 as mount
> >> options would leave multichannel enabled, even though it is not
> >> meaningful when only one channel is allowed. This led to confusion and
> >> inconsistent behavior, as the client would advertise multichannel
> >> capability but never establish secondary channels.
> >>
> >> Fix this by forcing multichannel to false whenever max_channels=3D1,
> >> ensuring the mount configuration is consistent and matches user intent=
.
> >> This prevents the client from advertising or attempting multichannel
> >> support when it is not possible.
> >>
> >> Signed-off-by: Rajasi Mandal <rajasimandal@microsoft.com>
> >> ---
> >>  fs/smb/client/fs_context.c | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
> >> index 072383899e81..43552b44f613 100644
> >> --- a/fs/smb/client/fs_context.c
> >> +++ b/fs/smb/client/fs_context.c
> >> @@ -1820,6 +1820,13 @@ static int smb3_fs_context_parse_param(struct f=
s_context *fc,
> >>              goto cifs_parse_mount_err;
> >>      }
> >>
> >> +    /*
> >> +     * Multichannel is not meaningful if max_channels is 1.
> >> +     * Force multichannel to false to ensure consistent configuration=
.
> >> +     */
> >> +    if (ctx->multichannel && ctx->max_channels =3D=3D 1)
> >> +            ctx->multichannel =3D false;
> >> +
> >>      return 0;
> >>
> >>   cifs_parse_mount_err:
> >
> >Do we even need ->multichannel flag at all? Maybe we could replace
> >->multichannel for a function that checks for max_channels > 1?
>
> I agree with Henrique.
>
> I'd actually like to propose going even further and having the whole
> module behaving as if multichannel was always on, even with
> max_channels=3D1 -- the only difference being the need to run the
> query_interfaces worker.
>
> This is probably work for another patch/series though.
>
>
> Cheers,
>
> Enzo
>


--=20
Thanks,

Steve

