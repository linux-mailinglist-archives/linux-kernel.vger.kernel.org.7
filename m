Return-Path: <linux-kernel+bounces-897348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F6BC52B31
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E2DF44FAA87
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C9725B2FA;
	Wed, 12 Nov 2025 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RcnkXanq"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47228258ED9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762956138; cv=none; b=Px5njrcgvsjsR4kVL1DN6iJKyDPKetvHBdyswNW6NJCaxoU8DGgNDrCchjSaodaeh8h3mS1sNMJtSXHVZPsyLZS1kGWKvWPsOAX2TxL5xIS2Pr5yG4tQn21nb6iij+b8qM6eY02GJ7Ea9ex2SWBJmDE3thMK3gJGgNI2XgXjaDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762956138; c=relaxed/simple;
	bh=SlEYDOScQZNVr1WYQjXUJKiqkkseqZPjckRYMu3nBoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIhrgVCCCGD8hMmlimr1lXk6/+ynHy+qYupj/VFMnk3rTHPX3OWXY6LI8P1Pky4pUo9o4z5lxJ9SuMTaNhtXOe54H+wpUuxH5TDabDUoXqQU1HqJRJsltTT/p0jQErEyFWMWaZJ1gu0YQ1K6+Iyn9aWoXpd2pD6GpACZhVmATkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RcnkXanq; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b3c965cc4so351511f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762956135; x=1763560935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=97+x+h8dQ4e8GUTjDZqoRrL1FA9+Qvtg5x2caP/F8R8=;
        b=RcnkXanqGjT8Whv4CCstturHR4uI5lkDApZuKUjhCQQ1GvnH/AWDLvN+8blXno9HBj
         uD43U+goT9He3rHbTnqXwmRB/QSEQK2hf96/xJij8GxaZdrR24oLPcFSOcurpgj7ynQr
         mMVHKgPMFxdw2HaBPDJIXxIeCs2Y4/FTpIHL8LJkunWvmHtvrD0+fYoXnMd8hdlWDcvM
         QcABsylAuLD/yp47dQVLPgjy1QNsJ9Xe0joC173EH9DJ6f/w2o8qppdE5EUI7wFfPH5i
         u2vU/JNPh5ICSPPMtaz8QZRsnJANH8M+Jt2L/6zmIDo8r39puVR7U0y4lC+dXDNpsmE2
         n3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762956135; x=1763560935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97+x+h8dQ4e8GUTjDZqoRrL1FA9+Qvtg5x2caP/F8R8=;
        b=tbVslIMuLHCo0ffnVuVPMWFzmojzoQDe0hc2NWCaoPXqYLVS+7yvW7dqWgvUzTN9kG
         QWL4FvzS/4XFfKVIe4PHBEtg2EM9mV2oAnZAFuh5KNDX0uVd/P/pV+Nao2TUe1WaEDY6
         T1u4V1Uh2k615RV+yIXfAFbNKJUpaPGjoxAcMLs5+XXkSLyiIpU81R2J91Po38STyLF8
         0xym0tBe5U83w4ft7uytWWNTZLbV2ECbNHlm9VzmGMCM+oG1heRk+yj38AsyMiTk9KYk
         f2XA4dn1oMebvOg2W/vpczG0xaMl0hmw5nnwK0Y0xwRG8+bDxz4qzfeiVmy8fGNPdCd7
         r6sg==
X-Forwarded-Encrypted: i=1; AJvYcCVjq8x9pYBMtb5LrRYO9ZF1+g90JNZBih/o+lpGyyjHgxzOyFJvmTVLrhXAq7hZENk2DFmJRDgaQBkIWAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAyO/JCP4SzIOszhLaVMMFh2vACBivlz41mxTLYlwD/PsMk9TZ
	qRu+BjyxsqwsZtVw2vj38U6tH7DQojyeWz3incQfICYPFqNIMDe3pF113okqLGTIAqA=
X-Gm-Gg: ASbGncsIFz/8FtcYEVlVMxsaRngxqqsVdBFn5V4LjgdbUyLAEoM4ORFcEL4noGrYqF6
	LMX3o2s3fEESV7uzBDPRMl8sDZyFFY7cSa/MB7hxWpQrmHMrMsr1meI9lx96/ZHUab/HeyA9xmX
	no/j08ftBHzRuPQw0eZCaXNAir1UCX3nkT9rPlI7TCYyLdPCYiyGAISjSqoqHXEfpLPXMSoYsNm
	dZsoQyt+tVU1TFzDH1zz9MLGT0eimWvNsxtvUqKiXKF9itj3C4HItQdgWEYEa4xiasKlAR7avVw
	4mOnQh4XqF+ICgosCGyvueDq86qEvVU0U8p3lI1s41MANlDBMTJA8wCcvVvFWzORe0V+8omVp7j
	/+xWL5jkJePqRiq37WvtXoDUUqSIVGYcCniUHjiwczxhW8Xm7eslSP8WL2GasfWM5zQYoOyHBbj
	jRdr1+OVn2+Axp5hYMZGom
X-Google-Smtp-Source: AGHT+IF+oB8mjrQRe5QSu7EfBjAysEQG22PZLyD/6924dtA5Ki8nSfNI1qTwkRcog78mpQsXY/aLvQ==
X-Received: by 2002:a05:6000:615:b0:426:f9d3:2feb with SMTP id ffacd0b85a97d-42b4ba81c5fmr3242633f8f.23.1762956134571;
        Wed, 12 Nov 2025 06:02:14 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac679c5dcsm38723673f8f.44.2025.11.12.06.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 06:02:14 -0800 (PST)
Date: Wed, 12 Nov 2025 15:02:12 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Leon Huang Fu <leon.huangfu@shopee.com>, akpm@linux-foundation.org, 
	cgroups@vger.kernel.org, corbet@lwn.net, hannes@cmpxchg.org, jack@suse.cz, 
	joel.granados@kernel.org, kyle.meyer@hpe.com, lance.yang@linux.dev, laoar.shao@gmail.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mclapinski@google.com, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, tj@kernel.org
Subject: Re: [PATCH mm-new v3] mm/memcontrol: Add memory.stat_refresh for
 on-demand stats flushing
Message-ID: <chffrjnr5ebky6aytx6va4lptu7mbxclmzqvzdnjwa6hrb7fzw@ewpebokeqfzs>
References: <7d46ef17-684b-4603-be7a-a9428149da05@huaweicloud.com>
 <20251111064415.75290-1-leon.huangfu@shopee.com>
 <2f43bdf7-5ce0-4835-9e60-39d91f637152@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qrv7ktcycf6a43eq"
Content-Disposition: inline
In-Reply-To: <2f43bdf7-5ce0-4835-9e60-39d91f637152@huaweicloud.com>


--qrv7ktcycf6a43eq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH mm-new v3] mm/memcontrol: Add memory.stat_refresh for
 on-demand stats flushing
MIME-Version: 1.0

On Wed, Nov 12, 2025 at 08:56:28AM +0800, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> However, this fails the LTP test quite easily. The error logs come direct=
ly from LTP. The issue
> occurs because the threshold isn=E2=80=99t reached, resulting in an RSS v=
alue of 0. We tried increasing the
> memory allocated by the LTP case, but that wasn=E2=80=99t the right solut=
ion.

You touched on a slightly different cause (other than  async flushing)
-- there are other fields/stats that are quantified by (basic) page
size. I.e. I think that might need different/more central solution, e.g.
working with absolute (not relative to pagesize) thresholds if absolute
precision is needed.


Thanks,
Michal

--qrv7ktcycf6a43eq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRSTYhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AiSagD/WULk3YU+JZ1RgyrGtBcK
Rk5AScqXYcflK31hxM9Cw9UA/3e8l571U4YVUYXkPQ44w97Y1nTKbxU0rJ7BHri1
sywP
=pSJv
-----END PGP SIGNATURE-----

--qrv7ktcycf6a43eq--

