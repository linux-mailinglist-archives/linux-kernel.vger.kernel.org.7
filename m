Return-Path: <linux-kernel+bounces-866475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBA4BFFDD8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8813D1A06E7E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1392E2F3605;
	Thu, 23 Oct 2025 08:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/zN1aQC"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86332F83D4
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207654; cv=none; b=UTd3nmT8RI/dpncn6CXbq345wdYyWCDMbb/+krtXGHLXiMCchNms/wC8OeqHKMpPS2zhNFQFB7Vm4F+u79WbSPl4uCxh1D8dTSV1ysGWjWkEkyQPyFYSXDP5ECb+9yGoHaIOupyBv8ciobJMmU/gdnP5uCyHabTDVk3ifxiZ2Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207654; c=relaxed/simple;
	bh=/kzwLma60KyeM4C1lbV9kL+l7FiRZQTbszIYI4trr4c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+t9g/RHcaMJ3Wh17//akMv8RZGOVP+OcNP71SJm1aSbnPmBam9lQVtjn7NkbF+ptqkVNynmInN3gf/afGX7p6yRo2d/tSWa1f1Be9homzAhJkZLs7WlfWAQiIdEfFEDN7USoO2+6jsX9wt9xDt0Co3bYtCKUNdEzAaij0Wy0Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/zN1aQC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47103b6058fso3758655e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761207648; x=1761812448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEYNjz+HsVVYinojoxpbidjnmyoS4XjFSkLlwaniZc4=;
        b=H/zN1aQC2/uY73CPDxcR3A8HvKY9qQBG4Yqtc5EkmSmr/WhhSeB/cDUxw3pRNq/Qn7
         mWDYLDDJnM1jwUU0X1lDh/eyERB+9yMkkkMUao/UtaQYNZzvSY3vNtp3hlKx5EEfZVps
         iOqEZDLsQV7/FxqNg1BozaOOpOusWDQvLKEmlPo8aegSYmTTOnruXOEPhCWd6uMXTvTc
         F/BFSrfjIhRrrvUEx5yy+FSFoRLcNYAOgGOAXXMqPoslPrfdSB8IBnWv9cLdfZ2c9a3t
         yfyiYcadPSUDPJVf84tXFOU0RK02D0VdGPwfPmwsIcBBkyWknj6DAoD85TTnWIL40ueA
         6Now==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761207648; x=1761812448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEYNjz+HsVVYinojoxpbidjnmyoS4XjFSkLlwaniZc4=;
        b=oek1xcInBcl7vGPnG8kxIIraL5COQ7dZkUH9H9edH9DE6ZMEyeSU474c613+K1z6/d
         aEyh3VI3iJ9kpnXr70lCYQ6D8FLsd0IjB/QDLQVAVxoX4o/qO5fO9ZzDquCY9I2yCFHU
         QlocIMpAYEclPxUPgyAxrodomED/Ms9VSq3ufGVO0lth2GxidzXEN/Uow/27Ut7jMcxd
         CymJiaN+GHKST6XeW4SHhuSX1S+jSO1+OJSEy0Im1P6EJ+S6O2l4ZJMhSl2p+U60629J
         widYGnBMpdnwc06BE8ohhoHkEcrSsbEGvMDDT82qaXUhCykQyWFdoP6aWXj55s7JnpDd
         TrTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJT2eLB1+YPsuwKMpz9wob5yVX6NxDaqgC6ihnsvkFh+uP1z6tib2rAIDx7XrVXjWELOTYMf7C5L78FZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJfdyf1pfLcZdyPLVO9tzxEaTEWAsUt/5GJXIcmDWfy2+4/hK9
	z5PEHPKT7X1B3WBdvKzY6Lsq7toePbErMrH91JgFlXnnPzL6frJ0Dl82
X-Gm-Gg: ASbGnctqIXewhz2+LjhIVt66oZfFvRdpDsVc8B/CQ+v9WolqUhLs7n1FDP5/qEHF+kp
	1IqGe18wlO+Gj+jopzTIY4DzskFflizOZEMoIPAxVAQCcI2FuDxSNwA2iUzYTGnVJIvm4mhfLjE
	6KO+CalBCNb2cdfGGW6GlOv+murjvYjFls1WC0MH3k7rArpl7GOPl4nDkkL23Pzx07SoAaccNwf
	GAh25hO0BLxocVJqmsbf3ovRjMupgGR8uLaszOCdwHTsxhxcxdR0Sfok9ZUFieKRPvzGtc0oxCH
	kkZ22n+/ZLdFpGi+2AFoolR8jg6kpNcTgTsI9dFdunh+axAyhjzE6gAy9rp5blC3bzbgGWhL1Ff
	OgqR4Lz+KA1tTcZkeqIkJluIqsoTW7OSk9NWtI7CGxE8Onf4CI9yea3+HVFWBquM55qzivE/uB2
	vjGG9fcmHsifwresBLgm9pp9/ZO9KumwGDErrGup3XJg==
X-Google-Smtp-Source: AGHT+IHxwQzd6t6kPmDT9mLD66n8ELzc2lh8zguwps85JG/bAq5fbMdHocSaID3n4PD7hcE7rSKviQ==
X-Received: by 2002:a05:600c:6995:b0:46e:33ed:bca4 with SMTP id 5b1f17b1804b1-475c6f68f4dmr29819895e9.15.1761207648234;
        Thu, 23 Oct 2025 01:20:48 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475caf2f142sm25151455e9.15.2025.10.23.01.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 01:20:47 -0700 (PDT)
Date: Thu, 23 Oct 2025 09:20:46 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Biancaa Ramesh <biancaa2210329@ssn.edu.in>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] replace strcpy with strscpy for safe copy
Message-ID: <20251023092046.4f556e0f@pumpkin>
In-Reply-To: <20251022192318.GI2441659@ZenIV>
References: <20251021143952.37036-1-biancaa2210329@ssn.edu.in>
	<20251022192318.GI2441659@ZenIV>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 20:23:18 +0100
Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Tue, Oct 21, 2025 at 08:09:52PM +0530, Biancaa Ramesh wrote:
> 
> > diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
> > index 0388a1bae326..cffb7863adc5 100644
> > --- a/fs/ufs/dir.c
> > +++ b/fs/ufs/dir.c
> > @@ -557,14 +557,14 @@ int ufs_make_empty(struct inode * inode, struct inode *dir)
> >  	ufs_set_de_type(sb, de, inode->i_mode);
> >  	ufs_set_de_namlen(sb, de, 1);
> >  	de->d_reclen = cpu_to_fs16(sb, UFS_DIR_REC_LEN(1));
> > -	strcpy (de->d_name, ".");
> > +	strscpy(de->d_name, ".", sizeof(de->d_name));
> >  	de = (struct ufs_dir_entry *)
> >  		((char *)de + fs16_to_cpu(sb, de->d_reclen));
> >  	de->d_ino = cpu_to_fs32(sb, dir->i_ino);
> >  	ufs_set_de_type(sb, de, dir->i_mode);
> >  	de->d_reclen = cpu_to_fs16(sb, chunk_size - UFS_DIR_REC_LEN(1));
> >  	ufs_set_de_namlen(sb, de, 2);
> > -	strcpy (de->d_name, "..");
> > +	strscpy(de->d_name, "..", sizeof(de->d_name));
> >  	kunmap_local(kaddr);  
> 
> Hard NAK.  This kind of cargo-culting is completely pointless.
> 
> Think for a second.  Really.  We are creating "." and ".." entries in freshly
> created directory.  What your change does is "if directory entry name couldn't
> hold a 2-character string, we might have trouble".  No shit - we would.  Not of
> the "overflow something" variety, actually, but there's not much use for a
> filesystem that could only handle single-character filenames, is there?
> 
> What's worse, you are papering over a real subtlety here: directory entries on
> UFS are variable-length.  There is a fixed-sized header (8 bytes), followed by
> NUL-terminated name.  The size of entry is encoded in 16bit field in the header
> (offset 4), and name (including NUL) must not be longer than entry length - 8.
> 
> struct ufs_dir_entry describes the entry layout, all right, with ->d_name[]
> being the last member.  It is declared as
>         __u8    d_name[UFS_MAXNAMLEN + 1];      /* file name */
> which is to say, the longest we might need (255+1).  So your changes are basically
> 'check that "." or ".." aren't longer than 255 characters to make sure we are
> memory-safe'.  However, that does *NOT* guarantee memory safety - the first
> entry is actually only 12 bytes long, while the second one spans the rest of the
> block.  What is relevant is "entry size is at least UFS_DIR_REC_LEN(strlen(name))",
> which is true for both entries - the first one is explicitly UFS_DIR_REC_LEN(1)
> bytes long, the second - block size - UFS_DIR_REC_LEN(1), which is going to be
> greater than UFS_DIR_REC_LEN(2).  Block size is going to be over twenty four
> bytes, after all...
> 
> What we ought to do is turning ->d_name into a flex array:
>         __u8    d_name[];      /* file name, no more than UFS_MAXNAMLEN + 1 */
> at which point your obfuscation^Wimprovement falls apart.
> 
> Note that
> 	* use of strscpy() here was *not* any safer than strcpy()
> 	* it _pretended_ to improve safety ("move along, nothing to look
> at in this place"), but at the closer look result was a lot more fishy 
> than the original; it reads as "we have 256 bytes there", which is simply
> false.
> 
> This is not an improvement.
> 

It is also likely to make the code much worse, strscpy() is already slower
than strcpy() - because the compiler knows about strcpy().
The copy of "." can reduce to the write of a 16bit constant.
The copy of ".." is more problematic, a memcpy() of "..\0" might be better.

	David

