Return-Path: <linux-kernel+bounces-722210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 108BFAFD677
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C114F481F2D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34082DE1FE;
	Tue,  8 Jul 2025 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="apBFbMGB"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8D421ABCF
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751999558; cv=none; b=h3E7YxKjGkO75TY223wVAF01QDi8rczRA1it/kuc/LIP8rZeTqjK3/aGFWeRYcPB7eewIa9AP91QG3H83blwiaxGBFopRarSXvEwWW3ZzImtlPzf83JxM6xtTI7pieLxm5Vejvpn0+IhqVj6CVVKJwGCtgGHzAbv2xq6qwQUm0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751999558; c=relaxed/simple;
	bh=O1GcTiIi/oWvVrYOvUmB5bjT3cWL6oGGPmNHOi/KSRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umlGN53k2H1RBDww9zp6c0AnNb4R/2S9oa/HzpjSCibhEv8aI9OS7+NEfu/BIwmHcYW9f9cMjxeaIY/VrMyp+VgIj+KlkDuiDMePUOrlKGS5nOUSktgA7yspVgpJ1yzcVcnjPAdtFUqhlapbOlH4BlSv0ssIm5nbEzyFqjLIVME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=apBFbMGB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-234eaea2e4eso6737985ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 11:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1751999556; x=1752604356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KG1Wx6OUZ9cQBjqvnO/QEWRp1+n48srDtYVZJzr7dSU=;
        b=apBFbMGB//ztyDe0OTLIySD6nWBigzg6u21pe9kABNcjUVkigTBDqDwIkNDD7YdPy8
         cIOyBUNPLTBB49x8OPMlopbVx2zzL9cy1kJ2b0fSOG8DfR1cbBK85KJHrZZcA//Sqxm7
         syhIJDpFt8TsV7OQdemvqy/kQDvZ7x/VWwETmrbOTxPF7JWfO0sbZTNZPbBeurXJEu9u
         wBqL6QdOMDym1/pK/evEbBefXExykl8kZnYR8/OucfreD9WfcGbIgFp0rvqF2yT1XxVl
         78D3EIvK7ImxqtB2styUH/hrVaYie4YLc6cBIXkmiU/xmpjE5pcBTK4WfJRdx2x2XsQT
         XRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751999556; x=1752604356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KG1Wx6OUZ9cQBjqvnO/QEWRp1+n48srDtYVZJzr7dSU=;
        b=R9GWeEVKSBOr5t9/cAdXqsuQAEvhPSXrRtHm+m0ptAvQhicGyLKOBSeaRbXnHfYpA7
         i1AM8+T5N8yas9Btorfao5m/e/DRvm8irGL0Xf8MF20UxvUcATecle5chhb5Y3VUYbms
         ONSBS5m1oK8ud0kBpTQAcnCSwmu7SE2l2a3SN6iWd+p6ZwCj/UYlYmrjgm8uwzXLx/2Q
         25blGui9qMrSGApfUiLAihRMv2dQg+m+PbZPG7HhE4PTjlMCtbs9L32FenU2Mf6zMEFV
         MU+EQ8qMDrhOt7ofZGt7eZOqUaq3B3/NIZeHIBONeH22BWrhiAAUcb4Hp36SWjm5Kk2Y
         YNwg==
X-Forwarded-Encrypted: i=1; AJvYcCUIRqY1My8jGFYwhNP6DSDuh9eZ9+qBJf3VpaK8hS4UEdc6Ho457zezHkM7gLrE5U4RQ+n4+YAN7cS1w0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiJ3rOUy5rsb0tMhfiz917A2NkOpKhEBJAWDz4VTS3sv7c+8XN
	Nf5am5hhb7VxuieObi8XI2AifILdQJPKfWy7OAVO7mLco++2Iew27ME+9iCGuXcckfVUm8QjOQY
	17lxfMDeMhH1qf1+LIANVB493iyYXP1mWTAbxPuYWUA==
X-Gm-Gg: ASbGncuL0aL13v5SkDDdwzGaRLpis5MqgG9tLo9ziUsDoyPza51jbtXGbFjXpjwNukQ
	Dt6mibFdd1YsbSaXnfFJBM3EZfUifb76no2feFKir8c2UnHEdVSH8eg/SPKweo3CmB7sVErEBC/
	2DjMMeL/UoZksZvuauwFU7lPv//G9XbzeyIQ7gK1P2uZZP
X-Google-Smtp-Source: AGHT+IGjquqT49t3mk9uGsBdWrji9vx+SHIhp2vhXIPomfvzssP2TLOXJlJDWqiYxr3KiEgZnyLCabCV7oJzVVEChrA=
X-Received: by 2002:a17:90b:3e44:b0:311:c939:c842 with SMTP id
 98e67ed59e1d1-31aaccd7e36mr9067045a91.7.1751999556030; Tue, 08 Jul 2025
 11:32:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619192748.3602122-1-csander@purestorage.com>
 <20250619192748.3602122-4-csander@purestorage.com> <c83a2cb6-3486-4977-9e1e-abda015a4dad@kernel.dk>
 <CADUfDZr6A51QxVWw2hJF6_FZW7QYoUHwH-JtNEgmkAefMiUjqQ@mail.gmail.com> <76ea020f-7f57-42d5-9f86-b21f732be603@kernel.dk>
In-Reply-To: <76ea020f-7f57-42d5-9f86-b21f732be603@kernel.dk>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 8 Jul 2025 14:32:24 -0400
X-Gm-Features: Ac12FXyEbJh8A-70IJqk1u3VgKtVIrMS8nYA9UhDEjT4t4zZd9AHBYP8tZeznMI
Message-ID: <CADUfDZppvPG9iZg6ED0ZUW_ms1EnNUJwwYyAJ7eCTWsJqa417w@mail.gmail.com>
Subject: Re: [PATCH 3/4] btrfs/ioctl: store btrfs_uring_encoded_data in io_btrfs_cmd
To: Jens Axboe <axboe@kernel.dk>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 2:17=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 7/2/25 1:51 PM, Caleb Sander Mateos wrote:
> > On Tue, Jul 1, 2025 at 3:06?PM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >>> @@ -4811,11 +4813,15 @@ static int btrfs_uring_encoded_read(struct io=
_uring_cmd *cmd, unsigned int issue
> >>>       loff_t pos;
> >>>       struct kiocb kiocb;
> >>>       struct extent_state *cached_state =3D NULL;
> >>>       u64 start, lockend;
> >>>       void __user *sqe_addr;
> >>> -     struct btrfs_uring_encoded_data *data =3D io_uring_cmd_get_asyn=
c_data(cmd)->op_data;
> >>> +     struct io_btrfs_cmd *bc =3D io_uring_cmd_to_pdu(cmd, struct io_=
btrfs_cmd);
> >>> +     struct btrfs_uring_encoded_data *data =3D NULL;
> >>> +
> >>> +     if (cmd->flags & IORING_URING_CMD_REISSUE)
> >>> +             data =3D bc->data;
> >>
> >> Can this be a btrfs io_btrfs_cmd specific flag? Doesn't seem like it
> >> would need to be io_uring wide.
> >
> > Maybe. But where are you thinking it would be stored? I don't think
> > io_uring_cmd's pdu field would work because it's not initialized
> > before the first call to ->uring_cmd(). That's the whole reason I
> > needed to add a flag to tell whether this was the first call to
> > ->uring_cmd() or a subsequent one.
> > I also put the flag in the uring_cmd layer because that's where
> > op_data was defined. Even though btrfs is the only current user of
> > op_data, it seems like it was intended as a generic mechanism that
> > other ->uring_cmd() implementations might want to use. It seems like
> > the same argument would apply to this flag.
> > Thoughts?
>
> It's probably fine as-is, it was just some quick reading of it.
>
> I'd like to stage this up so we can get it done for 6.17. Can you
> respind with the other minor comments addressed? And then we can attempt
> to work this out with the btrfs side.

Sure, I can definitely incorporate the refactoring suggestion. Will
try to resend the patch series today.

Best,
Caleb

