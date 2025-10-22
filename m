Return-Path: <linux-kernel+bounces-865527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6286DBFD6E6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00349564799
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF0D35B14C;
	Wed, 22 Oct 2025 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gih6GnAj"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C3F35B14A
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761150793; cv=none; b=VNom6GTOsghwMlKY++iZ+fIamB1M7niA5HeecsY5rn5iASC6impPgX8bHFEBshYkDDLJoNtJe1dIUx3eviegLujsWK85/hDXPCUDo6p7qkxY6CPzChhLub6BwqQXuQVe6TkCrxGXzFxNW3lHxILc5cRrJ8g8cTaKFxMCAG9or/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761150793; c=relaxed/simple;
	bh=E6RCTKW47ipGGb84adNktUnAjoSlq99ffGTznqkY3RQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r8DfjwxRnv84EBvrivnPGNdil6rQcJHANDCEnSiaFq4HXBmdf90GERhrDTKGGHqDcHBK2qxc2vpmRmaK0+RhwzNBXrb8O45o8Nve7LldBsw0dpk7bptP8s0oCmhbShTDBCjR7nhllHb9bba6LiLHTPhUkI2NXvAHmbPjfqfE0C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=gih6GnAj; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-891667bcd82so168770685a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1761150790; x=1761755590; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E6RCTKW47ipGGb84adNktUnAjoSlq99ffGTznqkY3RQ=;
        b=gih6GnAj43MWw01wBmq7ky2wd07LywctC4NYEJ708lLTfnncJm0iSEJVfzNu2SEaKw
         A9EIZBTiVFHz5Ys/Wrv3UrU3MzzW8aqqlnNLe9ekWKHN4j/AUgNPHzGXxyLRUhDM8V+y
         WbufrnUBf+0rN3hTfX7uxyX+Hjrz5Utp42I6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761150790; x=1761755590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6RCTKW47ipGGb84adNktUnAjoSlq99ffGTznqkY3RQ=;
        b=Kzu+KSALZX17L5xMgtpdw3P17EY1Y0hO1tr/8ZOY4Xs4wDI07SrQXRTXPxLAnadBms
         QiKJJDA3V3qut2w+BqjLH05FYE6QTw0B5Oh8Gp65ftoEM0x9s/VX0kdJqxohbKJFO4wb
         TYIHMdpGvSlVLF7LBjd+XyvOeIc7eB3mX4zIwQpKzLsQhjGfSGkpFDOfGXUmnKK+DJwo
         zsrJA9NDCVGH+ijtNhq2kiBcadrtINXrAKKh61DnpAzDFTZYsa/ubaWeqZ2gWjPbPHJg
         5+9Zz+wfIE2HJDV1Ej42QgJOYi6zY6SB99NWakzRxacCD2Noo2tTML6oH1Y0hP+7HDlN
         dF0w==
X-Forwarded-Encrypted: i=1; AJvYcCVnvDvH0nZtRmfivJ11uym5pz+DSeLVSIEbgr2soWmAkdj4ok9/10p0cThzzQgfhvURdJup01U5IHDgoJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcHqePlYWz/rRdB2T2pDM/5hUZ1q2EJs2G4OwV03xQ2uDfY2kZ
	KejHKMyfE+7+e3J6iIed+RKJPa7MzxasllOWzkDN3UiBmlSPaa6eNlUGHATSDb4Sr5QIkgSchu5
	8zRSsjHBLptRgvf7ZbcyIe/Fk7pi2YlOQtdl5C6yFRw==
X-Gm-Gg: ASbGnctxO4UuQb6HsgEYMvMfb4AdlsVEZQA9SR0A/PmdM5swbKFo98lBPzz6kITwnI3
	we921TDKm7c/jozdS1QKrAhUya7YHSUf6aR8FLKdPF3AZIkDAJd4QH2hPvkwLKYMYXNrvPuTDG2
	q+AhPo1CVd60E5Ok7QwiMst3VHmR/jWOz5F/sc2LPpzjNvvfDik8hof1ERgrGw6X0XmJ/w2GFXq
	F+TxG/5+yUhSuGwy/JiudRQwiv78r4t7YzMpDTT6PxAW/kk/YrDTqaKVWAyBXAl3fp/QDgoolcJ
	OLHG2WiV3oJRV7pwvcAFbFbk
X-Google-Smtp-Source: AGHT+IHetFuQbcZ9sjeq1LfiwewhKOyzVgvyfZaoCwvZtpuzT0xhYxgjtjZJzL7XAL6bFknweJbXWrduyMZYn0Iipq8=
X-Received: by 2002:a05:620a:29cb:b0:890:e60c:de2c with SMTP id
 af79cd13be357-89adfa0210fmr257643185a.14.1761150789598; Wed, 22 Oct 2025
 09:33:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251011124753.1820802-1-b.sachdev1904@gmail.com> <20251011124753.1820802-2-b.sachdev1904@gmail.com>
In-Reply-To: <20251011124753.1820802-2-b.sachdev1904@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 22 Oct 2025 18:32:58 +0200
X-Gm-Features: AS18NWBpOtFOj38mwb2zwp85aespn4SrliR7HP6OAG5Pp6lvNUwpX1kQdf_Iz04
Message-ID: <CAJfpegtW_qR2+5hKPoaQnPRPixFUnL3t8XpcByKxLRJvkroP5w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] statmount: accept fd as a parameter
To: Bhavik Sachdev <b.sachdev1904@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aleksa Sarai <cyphar@cyphar.com>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Jan Kara <jack@suse.cz>, 
	John Garry <john.g.garry@oracle.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	"Darrick J . Wong" <djwong@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Andrei Vagin <avagin@gmail.com>, Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 Oct 2025 at 14:48, Bhavik Sachdev <b.sachdev1904@gmail.com> wrote:
>
> Extend `struct mnt_id_req` to take in a fd and introduce STATMOUNT_FD
> flag. When a valid fd is provided and STATMOUNT_FD is set, statmount
> will return mountinfo about the mount the fd is on.

What's wrong with statx + statmount?

Thanks,
Miklos

