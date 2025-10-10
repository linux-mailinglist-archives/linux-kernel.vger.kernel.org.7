Return-Path: <linux-kernel+bounces-848081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C49BCC76E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC2EC4E7757
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CF62EDD4F;
	Fri, 10 Oct 2025 10:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVwQB8Jm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B773226FA77
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760090711; cv=none; b=laG+5xL4a+BBR+LJs8mgGm2Q1Jnso9VO3SlnaAtVzYC09iq7JN/HSHogncH4Zt5qLdZZuf+VwNeH+qIF1xhgRKBtqUr/cSX0drKLwuOJhEvVt/GjqBg7mV3/YpLCf5rQJldIGRHgb5905BDPlZQeo3wvlQZoHaU5uL7jcjnVkvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760090711; c=relaxed/simple;
	bh=yxjUvtTYbJzNPd6jcvWn4XkfkMtZPuAQxmu/eENPV1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SG1TzqTe2/QBTaRikrMcyvzhjwQnmz6ZQ4r2pYW0N6dqbB9wuQg2eW8tDqodp49kopHbUl5VMWpgxx20Jy4pgKSULCwf99y0OeOoA+u8KiJMKWl8y1xrNAzKSlnF8mpnG6eybz+1qbD09DqtWZGg5IuQm63s6NG7VEXPuAXxaFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UVwQB8Jm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760090708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1tnuXFIEOnkdTLEedmD2VLZtLJP/FDB86U+RErd2EzU=;
	b=UVwQB8JmsifIDwDTwbpf/vN59yRqHQrCXnyMqTkNpkJew7aytDyk1KkKjqIwsUO/ZFmx43
	MWYZdytSW/zzmcJutHoVfYbkJaz65a0ZaCYAJ58g/kKrcSfRr4LNq87ekUdQMu3tIWI1B0
	Mo/pQUi6zODDB+suHnf4s80PDab+Q8g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-zGwYuUYtPBeNmD2dhEEaoA-1; Fri, 10 Oct 2025 06:05:07 -0400
X-MC-Unique: zGwYuUYtPBeNmD2dhEEaoA-1
X-Mimecast-MFC-AGG-ID: zGwYuUYtPBeNmD2dhEEaoA_1760090706
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ee1317b132so1115766f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 03:05:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760090706; x=1760695506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tnuXFIEOnkdTLEedmD2VLZtLJP/FDB86U+RErd2EzU=;
        b=rDt61f2wJYV4FAWRAm1f2kMneUi1iIsP3OFzCkWXYxbPhzKrWPz1kq5i+tcmrPYnjd
         LBfPNCWYxeUl2LKKIkV1x8V5VEG0e6EwR51/Q/i6CGcohDbT0aG47Vxj2vT0kfJ9gbPg
         tylRTKL7Euq0SZaVCzkVs0uvsTBpZEN9p7fdIpswN33mMjLB94l+oLo5Tzgl6R9Ukyvs
         eQ3epclDlyMBbS2juqbVqLMLErWg/8pwtoNiNXQmxfEOqDy5B589ejekQHBiDJNVaXQI
         AQ5eutboCLW66R1KnKZrQAfsvYMHWkzbwRHS66DHOHFbCGNEgssUV+YgJawu1rvcnj6f
         ZZaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSIeFHEI1YTc8NNJld3Iqllvxlv7nuRxWyj3fXdQnFZ4mOu3lSQICh7+Q7Betz2Tux0WIW5A9M5l/FTIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8msW5/DlMkC6lsSC1OM25f/bSdmJrLjQDs0DA69uwByhZG65l
	qip1BZMzCrS0Lf0p/GhZ8pfScQYu1zSDrzW0acdGqcs5Fs597pNfaXd1HEb4x5m9y1C0YIN6j/T
	HGuuI420tqnwOZlTAClV3xs+xi/xLeDq8V02a9e9KKahpzcwhhX0/3karPUrgj2hOMEw4DBur
X-Gm-Gg: ASbGncsv5ySru/bkQfkXD8OYIj8e2JB0rQtoF2PQOZZxXB8Pk2vEC5PbEY3oGHpxRhO
	xR1Nt+SqXEaE5rclkMQwOwMrvjmjp6rsa7m8hehXA+ZZWPdZM/If1zIHyVMaG81buWKh8d552cd
	A7yJ5qwuYbf0uzXVggvZxLIXyxGJQT4YuV7BpCJPKVFUii2/k3fyHypNUjuYipMoBtJkRiqUKeL
	kTwWeO+Pr5u5DaE6OtIPpOeD0esUpt5Xq9bauGQjTl558gvdUE6lC6OxNNI8Q01ypXx5fw1tP1m
	8fzUMbm5CffY8mR+x06O1ZSqvjjLAO+H42h40j40oK6GIM7JW4bkG0M/mLTu
X-Received: by 2002:a5d:5f82:0:b0:405:9e2a:8535 with SMTP id ffacd0b85a97d-4266e7c0240mr7991708f8f.27.1760090705840;
        Fri, 10 Oct 2025 03:05:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3MG+EMhV6WcoQA4r+co7LNvaX9gw5/qrhvPUQ1CI9icTl+BzkJJl0HQutbbiXtsdES2s0pA==
X-Received: by 2002:a5d:5f82:0:b0:405:9e2a:8535 with SMTP id ffacd0b85a97d-4266e7c0240mr7991667f8f.27.1760090705321;
        Fri, 10 Oct 2025 03:05:05 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce583664sm3470012f8f.22.2025.10.10.03.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 03:05:04 -0700 (PDT)
Date: Fri, 10 Oct 2025 12:05:04 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Jiri Slaby <jirislaby@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH 2/2] fs: return EOPNOTSUPP from file_setattr/file_getattr
 syscalls
Message-ID: <q6phvrrl2fumjwwd66d5glauch76uca4rr5pkvl2dwaxzx62bm@sjcixwa7r6r5>
References: <20251008-eopnosupp-fix-v1-0-5990de009c9f@kernel.org>
 <20251008-eopnosupp-fix-v1-2-5990de009c9f@kernel.org>
 <20251009172041.GA6174@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009172041.GA6174@frogsfrogsfrogs>

On 2025-10-09 10:20:41, Darrick J. Wong wrote:
> On Wed, Oct 08, 2025 at 02:44:18PM +0200, Andrey Albershteyn wrote:
> > These syscalls call to vfs_fileattr_get/set functions which return
> > ENOIOCTLCMD if filesystem doesn't support setting file attribute on an
> > inode. For syscalls EOPNOTSUPP would be more appropriate return error.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> >  fs/file_attr.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/fs/file_attr.c b/fs/file_attr.c
> > index 460b2dd21a85..5e3e2aba97b5 100644
> > --- a/fs/file_attr.c
> > +++ b/fs/file_attr.c
> > @@ -416,6 +416,8 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
> >  	}
> >  
> >  	error = vfs_fileattr_get(filepath.dentry, &fa);
> > +	if (error == -ENOIOCTLCMD)
> 
> Hrm.  Back in 6.17, XFS would return ENOTTY if you called ->fileattr_get
> on a special file:
> 
> int
> xfs_fileattr_get(
> 	struct dentry		*dentry,
> 	struct file_kattr	*fa)
> {
> 	struct xfs_inode	*ip = XFS_I(d_inode(dentry));
> 
> 	if (d_is_special(dentry))
> 		return -ENOTTY;
> 	...
> }
> 
> Given that there are other fileattr_[gs]et implementations out there
> that might return ENOTTY (e.g. fuse servers and other externally
> maintained filesystems), I think both syscall functions need to check
> for that as well:
> 
> 	if (error == -ENOIOCTLCMD || error == -ENOTTY)
> 		return -EOPNOTSUPP;

Make sense (looks like ubifs, jfs and gfs2 also return ENOTTY for
special files), I haven't found ENOTTY being used for anything else
there

-- 
- Andrey


