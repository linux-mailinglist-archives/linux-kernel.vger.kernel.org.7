Return-Path: <linux-kernel+bounces-853407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A41EBDB8F9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 00:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7393818A8538
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C577530DD3A;
	Tue, 14 Oct 2025 22:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuXT4COZ"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721D530DD0D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 22:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760479467; cv=none; b=J53LAtKuAD2Oj2C9ApUgORWl2CnKB2pfZoR5j2FCvwXdQUvIsy3dKTDsmIUvDJ4FLmZUqFU8f913VUsstmAtO+cXtv/NxGCDXURXJ7Qm+amMGRURE95yKCp4rVFUgJpaNDT//CEvo3oVK4sw9janLIczjf3rbGpD6eTctC2xLP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760479467; c=relaxed/simple;
	bh=pG515i7syHG3vED4MTNqB/DberSEKkguAtEkJvVagCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JVV6DhKMM8Oz80/bIeao3BlOurwWaIGs2QFF5hsC7UKkDWMnX9Y0p8+5JGJ2blpfSpZvV2ZmGS3ITQTNO9lPamdzC0ZWAnhXNyCon0YERujKCWipBCZ80vhtsC1CALIPttr+wJ9nzCSc0MvGIk+i1Cu8mZEf51+JRF5JuFysn9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuXT4COZ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33255011eafso6228809a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760479465; x=1761084265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l6XDsENWGoamE2lQfBoeAOTQv2/NbQK1cLV8RQTx+rU=;
        b=BuXT4COZt833j/MT8p8ax319LGdRXi0b/KO67c7Av6vdB9shb0wEtOhRxuuZN0iHrr
         J1bcKGTvyVVFMRuKd5Vy28WN1lebSZeI3E8/nKnN1WKAq/m1E4mF2qIY+2ZWRqcB5gsO
         9WLm0ODXxFQHclwoGz2JKNAeJ/b1hnONmz6nNHFH/t6Dc0gUX6C7blz9QA1NuyZWqYFw
         spZ/RqlVAD4fyQ5eIajKbWdkEC/EUpesN95yRprQoI5ZOgfVBBeHWA6FuITANN+pV1Mk
         2mJLz90hX+MJ2He1mWtIqxbGDsD1HRD4CC/c8RvD9aIAPKGScUyY7qMVoJ+OT40Rkhwz
         Dyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760479465; x=1761084265;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l6XDsENWGoamE2lQfBoeAOTQv2/NbQK1cLV8RQTx+rU=;
        b=A6hetq/TmhDdnxSBAY5MMqgjeKhcBP8UsjjN9Vv1s2dpKKrwSAfSGafmmpLgW5GvNF
         OgCzrA570Jaltfg70XZGYxUCSOZVJDKsdLtlWXweamvZXA87Jdbamyn4GjIchfYFSC9e
         LAWWpwnGFCJ0reKCkm+Hg8aM65JYK5QEK53hlUT9GuEnzDnPNLDfnGBcTjPpnzL9KX1v
         xpYUV7pnHh/VhYNc5hhaRnGrv6pg4WTyk72eTz6RJvWe8Cu16KGETouoKxoOwmmu5Ian
         SuDthvQdlBRM4dZwOzuHwGVmwU7LjSKeEWfhgYlFX8qwxBnuMQji06XVRyjdA2j0uHga
         xqiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiqeC6o8w80h9cQsRjBbG38cSzUebfgA0BKcLTY+yy2824v83KOc5RYP4HNXtu3hWSDy/TRh28YNyTnAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlMo9KhbUosE+XTRXlprXixtJa3e0c/ct5VO7x2Tk+rvw2JqBr
	/QoJNC4UZUf3cnF/HApxvLgQw/TvU6A7MRDYwcUcjPZafZKen8w3Gpsr
X-Gm-Gg: ASbGnct8Idhro/Zhz0F7qMekmUyXg9ZighI6BeqHn0XENSDrxzYuls/0rTzEoyyVQjo
	cPLthmEuvhMw2Q/fdG+B8fRs6HH1auIj1WVxReaLtoLr1bPoXimUdiwKYOoQmWG+LyDKRVOp/8n
	ahCoyHICBwBJ8mQw22k3SuYjtkZ/ZbEAw60kXfjkxC6Dewk2w3jURtQXyHz99c98giY6MXUDJCn
	Z/4P+08ugWPOyFDyIN5pn7mgrinRImxK41BegCa2XTrBHfOwSufzMYhZ5dASnnZXdp0izhZ34Z+
	S0emtFGwKZhjrgZlyLYd1or3aC3zIBMXpyk88Y22C8tNJRiPLRLp5WTb82si3cFgvRMPATyEAUZ
	vrCAiXXVnUTOkttju7Ow79DzgI+cIHMVSaYmyCgnIRhlr9kkSC263BYXwcWcZq1Dx4KxsC5sVTl
	Lo17BcAaFUVetA8VWao8eCzOFT
X-Google-Smtp-Source: AGHT+IHUB3rz/slBsn1LJeEC9+FO5BtqHcvv9o2+l1YGXAcHXI2KItjdeh1X4Zw/JN1lCdNJMeKK5A==
X-Received: by 2002:a17:90b:1b41:b0:32e:8c14:5cd2 with SMTP id 98e67ed59e1d1-33b513d0b37mr31894521a91.28.1760479464543;
        Tue, 14 Oct 2025 15:04:24 -0700 (PDT)
Received: from [192.168.50.102] ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df7e1d1sm13042068a12.40.2025.10.14.15.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 15:04:24 -0700 (PDT)
Message-ID: <e890fbd0-7b05-47d2-a444-f61409e4bbf5@gmail.com>
Date: Wed, 15 Oct 2025 06:04:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] ovl: brtfs' temp_fsid doesn't work with ovl
 index=on
Content-Language: en-GB
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: kernel-dev@igalia.com, Miklos Szeredi <miklos@szeredi.hu>,
 Amir Goldstein <amir73il@gmail.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, "Guilherme G . Piccoli"
 <gpiccoli@igalia.com>
References: <20251014015707.129013-1-andrealmeid@igalia.com>
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <20251014015707.129013-1-andrealmeid@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14-Oct-25 9:57 AM, AndrÃ© Almeida wrote:
> Hi everyone,
> 
> When using overlayfs with the mount option index=on, the first time a directory is
> used as upper dir, overlayfs stores in a xattr "overlay.origin" the UUID of the
> filesystem being used in the layers. If the upper dir is reused, overlayfs
> refuses to mount for a different filesystem, by comparing the UUID with what's
> stored at overlay.origin, and it fails with "failed to verify upper root origin"
> on dmesg. Remounting with the very same fs is supported and works fine.
> 
> However, btrfs mounts may have volatiles UUIDs. When mounting the exact same
> disk image with btrfs, a random UUID is assigned for the following disks each
> time they are mounted, stored at temp_fsid and used across the kernel as the
> disk UUID. `btrfs filesystem show` presents that. Calling statfs() however shows
> the original (and duplicated) UUID for all disks.
> 
> This feature doesn't work well with overlayfs with index=on, as when the image
> is mounted a second time, will get a different UUID and ovl will refuse to
> mount, breaking the user expectation that using the same image should work. A
> small script can be find in the end of this cover letter that illustrates this.
> 
>  From this, I can think of some options:
> 
> - Use statfs() internally to always get the fsid, that is persistent. The patch
> here illustrates that approach, but doesn't fully implement it.
> - Create a new sb op, called get_uuid() so the filesystem returns what's
> appropriated.
> - Have a workaround in ovl for btrfs.
> - Document this as unsupported, and userland needs to erase overlay.origin each
> time it wants to remount.
> - If ovl detects that temp_fsid and index are being used at the same time,
> refuses to mount.
> 
> I'm not sure which one would be better here, so I would like to hear some ideas
> on this.
> 
> Thanks!
> 	André
> 
> ---
> 
> To reproduce:
> 
> mkdir -p dir1 dir2
> 
> fallocate -l 300m ./disk1.img
> mkfs.btrfs -q -f ./disk1.img
> 
> # cloning the disks
> cp disk1.img disk2.img
> sudo mount -o loop ./disk1.img dir1
> sudo mount -o loop ./disk2.img dir2
> 
> mkdir -p dir2/lower aux/upper aux/work
> 
> # this works
> sudo mount -t overlay -o lowerdir=dir2/lower,upperdir=aux/upper,workdir=aux/work,userxattr none dir2/lower
> 
> sudo umount dir2/lower
> sudo umount dir2
> 
> sudo mount -o loop ./disk2.img dir2

At this point, Btrfs assigns a new temporary FSID, but without it,
the test case fails.

Temp FSID support only came in with kernel v6.7, so wondering,
how is this test supposed to work on older kernels?

Thanks, Anand


> 
> # this doesn't works
> sudo mount -t overlay -o lowerdir=dir2/lower,upperdir=aux/upper,workdir=aux/work,userxattr none dir2/lower
> 
> André Almeida (1):
>    ovl: Use fsid as unique identifier for trusted origin
> 
>   fs/overlayfs/copy_up.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 


