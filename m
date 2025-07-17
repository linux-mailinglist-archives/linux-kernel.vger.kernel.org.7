Return-Path: <linux-kernel+bounces-735928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DD3B09569
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C9A1895D53
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15B92248AF;
	Thu, 17 Jul 2025 20:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="X/RnAtaM"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B8F2236FF
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752782685; cv=none; b=TRtTGKzSKjE47AKyI4259Oia9QB5HmzsxTvwv6XUbfItLReBeexzyeSv+AnIVvLerIIvRSNmmbfQdyCzaZ04SmLvkQ1w32zv39v0qydJh/hh+ivb6sGxyBaFqkcRztgep75HKnCNTL7p6dmAvSAmh8Op7MTqT87f+MkSJPcPsO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752782685; c=relaxed/simple;
	bh=U/+v7KLWnVxoUKhIBBslHybhE/t5sUE6Pg10SYhDzK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LT3pCxwzTpcq4DiL/CMjU6Jh3iAmcR3u/kATs4963Up2Sb5w+oSYoWcZtTKt0R1tvUzV/Z0kU1KfVx+aj/iJ/R7CJWF+tsuDHyPH0e7o3RmUrq9YG1CqE0DUcVGilgEQB6Vr7CMJoLsPsu4lgWlv5uwmYqfHCa6otbfv7mze64s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=X/RnAtaM; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-313336f8438so216524a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752782683; x=1753387483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/v0WT+7vq9SCfoMg2Yag6ZEXMrfYo0BDeUgpiKJwjw=;
        b=X/RnAtaMalF0WoNywXqWuMCKNDVBr5wz/XH7cZ3kn1ZoHkxK41QbmfBML9phnPCbbY
         jkMiQYiMrAX4EBHgF8+i9YX4rKzZtz6swxrPBOBW9EZDPE5OH5c/oAX33IdS1zUqnSFd
         8hcf77p2eZ8I3Zs8RikJMWPLU4zLGbowu4NdS/ZK53MzJXj/SYcBtT6bgz7nk2hR4xfX
         So39mTbNFkb/4+QgXjgGlh4m9FJnZmbcdPCw8S1M5yTXwnBqyaMh6N+gKa+C4f/2nwD0
         0waZ3sseO6QbGjWDLzxcoWAE0FZyTpUdRFTFUMcvtaXR3oFsVU4wDqOJx8IxL95DsyxJ
         0RMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752782683; x=1753387483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/v0WT+7vq9SCfoMg2Yag6ZEXMrfYo0BDeUgpiKJwjw=;
        b=SALwsuES9j+a0pcFAHmF/JyCIz4xWL0xcJ3vV/hNBDgkU5Y+1CiSBV166bRtyBPiiX
         qTY0Cv4RckHl6Aa2F1A54hAfhXJBXM8dGAdrZ7g4OaZtB4tpli/C/79dIy1E7uBv4wfI
         qwZpl9VZoZjw7bSgFm5uKBIXc4iuPVzrsTUQXJyEEPNip9M+OW4amx8f1bTG/SZ5NeBL
         ALA0m9a+TfgK3vcW9FWoOZe8gZgd3foK2BYb2Zf1h6hMM5hjjJSmiyYkqGhEaW9avrxk
         Qa6nIqehyW7bFe/cs/T+Uf4Kwh+GBWxyFtoHG1V3sZSPWx/Jr2wcpzWp6IEaEuQFloff
         IGbg==
X-Forwarded-Encrypted: i=1; AJvYcCUu45AIhkujJU6YUUqurOiErHMaOi0+O54N1p+mIcle53LMQ6FgTrjW2Yasia/pQoh50Dkw6FzgwQC9jgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YybfrzvLjiNgwChzGQdtFGvjqo2mdIMgkVE+NCdYciAIZLveSee
	fVUTm4xyjO8j1Ca4rQG6ItUroL5EuGOB/iDMoGMp7P286SJX7n2/1q4ORrn9vUMBZX6H8imSF1U
	TM0HIyPoOuSfbUZjFuFH8hblsXLk2IzCfdMt0esxppw==
X-Gm-Gg: ASbGncv2DKaO78cdkTFdNTmGC2exE1vethhzHx9LQOOsT0/kXK3JoR2OCfagiBCz9wG
	82H4WmXy+H1SymBBxMvRiOjs75TsbqggeWGQvYhGrYyvTS2L/Wvg4OgwRFAs8LtdhJX/1U34cMa
	NsP7WE870M8G8uWcEXerRctCwaykrnMWqEcfm26Jdtq+IjO+QKdpYoqyOt/AJ9J6WXZUmQuiwcT
	heOj02K
X-Google-Smtp-Source: AGHT+IEhtJhj93AM6HYFT5RBg05Ilw6taTJ3/mXZBlGWr1wjpnrg+tZXlSuFBThy/hFSUe1C/9a92iYVg1S6R9eX2Uk=
X-Received: by 2002:a17:90b:3d09:b0:311:fde5:c4ae with SMTP id
 98e67ed59e1d1-31c9e776737mr4663891a91.6.1752782682862; Thu, 17 Jul 2025
 13:04:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708202212.2851548-1-csander@purestorage.com>
In-Reply-To: <20250708202212.2851548-1-csander@purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 17 Jul 2025 16:04:31 -0400
X-Gm-Features: Ac12FXz4umVHFmIzVUIOYyEMbfS69u7WsqSmgyR0PovCc2BoXLdELiz-nczSAh8
Message-ID: <CADUfDZr6d_EV6sek0K1ULpg2T862PsnnFT08PhoX9WjHGBA=0w@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] io_uring/btrfs: remove struct io_uring_cmd_data
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Jens Axboe <axboe@kernel.dk>
Cc: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org, 
	io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,
Are you satisfied with the updated version of this series? Let me know
if there's anything else you'd like to see.

Thanks,
Caleb

On Tue, Jul 8, 2025 at 4:22=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> btrfs's ->uring_cmd() implementations are the only ones using io_uring_cm=
d_data
> to store data that lasts for the lifetime of the uring_cmd. But all uring=
_cmds
> have to pay the memory and CPU cost of initializing this field and freein=
g the
> pointer if necessary when the uring_cmd ends. There is already a pdu fiel=
d in
> struct io_uring_cmd that ->uring_cmd() implementations can use for storag=
e. The
> only benefit of op_data seems to be that io_uring initializes it, so
> ->uring_cmd() can read it to tell if there was a previous call to ->uring=
_cmd().
>
> Introduce a flag IORING_URING_CMD_REISSUE that ->uring_cmd() implementati=
ons can
> use to tell if this is the first call to ->uring_cmd() or a reissue of th=
e
> uring_cmd. Switch btrfs to use the pdu storage for its btrfs_uring_encode=
d_data.
> If IORING_URING_CMD_REISSUE is unset, allocate a new btrfs_uring_encoded_=
data.
> If it's set, use the existing one in op_data. Free the btrfs_uring_encode=
d_data
> in the btrfs layer instead of relying on io_uring to free op_data. Finall=
y,
> remove io_uring_cmd_data since it's now unused.
>
> Caleb Sander Mateos (4):
>   btrfs/ioctl: don't skip accounting in early ENOTTY return
>   io_uring/cmd: introduce IORING_URING_CMD_REISSUE flag
>   btrfs/ioctl: store btrfs_uring_encoded_data in io_btrfs_cmd
>   io_uring/cmd: remove struct io_uring_cmd_data
>
>  fs/btrfs/ioctl.c             | 41 +++++++++++++++++++++++++-----------
>  include/linux/io_uring/cmd.h | 11 ++--------
>  io_uring/uring_cmd.c         | 18 ++++++----------
>  io_uring/uring_cmd.h         |  1 -
>  4 files changed, 37 insertions(+), 34 deletions(-)
>
> v2:
> - Don't branch twice on -EAGAIN in io_uring_cmd() (Jens)
> - Rebase on for-6.17/io_uring
>
> --
> 2.45.2
>

