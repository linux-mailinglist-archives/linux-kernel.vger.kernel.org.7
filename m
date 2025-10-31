Return-Path: <linux-kernel+bounces-879572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E1FC237D7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D14D64E955B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D61C30FC15;
	Fri, 31 Oct 2025 07:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YR4aQUB+"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAA82BD5BC
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761894251; cv=none; b=po+e1iRaeW7Kiu+WROI2gRpuoOZm1hHb4/PaOWBqKJuUEVZe5vfWF6sa72zvV5NSOKkT1kZMpT04/jykJtJ7w15+girkjB68LsUoupiwznK1xYpHHBzdABvpn0sUmPkjz7lvMqxKOWtWfn+lQFBK/2BwZ8uLRxMh/DaOp803Ls4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761894251; c=relaxed/simple;
	bh=oLMCmmEia+w9/vo2VNryqUYejtfLk5Br1N13I2cnmTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqrJQsxBVe35O4yi/bf5XDOdt1rhrdAGQH0A/8+6JuCmd0KePGG4OtQHcsZ/XGgwu0CTYGs/trbcJV4qLzBai7d6zKTg8YPRKTc+uKGF1V7V7a9ZrM2mnvGE7IX9IY7MdykpQQr0L0Uf2wxnUU2IISnrK+R+M5RtPgybaMOiyyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YR4aQUB+; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4285645fdfbso254233f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761894248; x=1762499048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xiWigIdfjh8lgJ3SEN1A7uaDplKEo1jveY+w8/D092o=;
        b=YR4aQUB+4SuFWpWb/DyXuped49hmPT7b6YWnkiRzu++SGkfCZ7/913Jykj4I0TCol1
         YgYu7Sz2gs4hY5jFSjW5T7GGE1hYCztLQyfHGPYXCH7o9lCGMtZ0yhnMnwT4hsUgEb2/
         lIuOdq9V/LrEcY1WHbtKHOJr2Y2G4WjDC+TH7/ipGh2AzC94iJ8KyfDkiDNltT4pvWgB
         YujUHcKaSWLO6UAFCf8omAAEWXOYWPyUePKev9bm7gyocMMCALeMF2om37mofBjDQVgH
         +nSDAx6MIpD9XCYJ0Cyaj7586zP8q+8ay+yS6wf4/uc3lUzkoK5MslmkTG1ZJeNLhD73
         WSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761894248; x=1762499048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiWigIdfjh8lgJ3SEN1A7uaDplKEo1jveY+w8/D092o=;
        b=qHgRlGtCe3WYWli5+MTBvb+KOsYn22I8LEwMUrWnyi4dhunUCG8Gz4SZwVbge/G9Kq
         0plltATxfYOCBArsbq+L4Cnw6GYXAPb61lFI4HlNfDmmYrnzblqloJCmoX2X4cb6vI1o
         LERAQLWh4P6MRUI23WwiDn2xy+CbFORue0/9LsS5pG4PkcYhHG+Oycvbo37GGOdSSasL
         3kyVO9Qm/Ks3xvYH0nso1qTt+6/CMF+PUs8Nd2dnJuL+5odt+lC/RP+zRRU17BK6u+Dr
         E+KGpTfG0RW5pvbtMl7yOThcSmi0nTSPkiZ+KPpCaFu49FPdzTvReSEd4bHU77hAL7c3
         fPhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF17DzgPi+ES8/Pxc2uzgLa1wMt8astGsPmoglNDXt65KKtnHfAQxySSTvLmQAS7TUx5+dqyTA847ibDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWiQOiHYOqpXJZYK6ObGd1Fu7f2+G3kW77dpIJSgDIhYKJg6EO
	VFjQzAehlfoC7Qkn+EJ9Dln6elnNInKjzSQ0B0scsBm5EHYo81U9nJPd2sHPkaTs+ac=
X-Gm-Gg: ASbGncuYhnE5Pha2oGd1dO1TIi9RsFHeoElicsrcYTXZY9a6x6I/qhRRwpbLuOHJGCc
	ueolTC1joDXdV78tKAy4x4wi8+v6uTXUML0fZ3MRPLMAZaTJAQIyqUpmR0DmFhESrbA04NtqTOu
	kGhIuFUG+QW1+D6mc7QvPl2WwZNt50iPUHxri+wr+xPkdwFuIOXykuDMU9M1m2ostVKPnOdGKMI
	Xedlkw7560aBdRcsfiaBht/q14HwinCKQ2fuBvbyUdngS7wm7rnSKw9zp8GcghmHzBT34d/qg3J
	d5MWl22h/UnT+cVMgvcmu5ou9jVoi6BBPY0j/j3Tf3vOfo0O8sGeRPz8ujnk4UxHnAddLMj035A
	qj9qqTTfFFvtrrL5IfyMhI1dC/21qZu9lYS+HMmpNCAZmhlKdrqTFDk//FHaobkml4+8JDtlaKE
	c=
X-Google-Smtp-Source: AGHT+IEeqUFVKJ1hFaxe7zqKDUJhcpRVzgWqw6m6PPHOQHTGejVbMJJPn4hu++UXlkkSqK9yP1ks2Q==
X-Received: by 2002:adf:fa85:0:b0:429:bde0:1da8 with SMTP id ffacd0b85a97d-429bde01e0amr624513f8f.7.1761894247949;
        Fri, 31 Oct 2025 00:04:07 -0700 (PDT)
Received: from localhost ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db0a07cfsm1036897b3a.39.2025.10.31.00.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 00:04:07 -0700 (PDT)
Date: Fri, 31 Oct 2025 15:04:04 +0800
From: Heming Zhao <heming.zhao@suse.com>
To: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Cc: Ahmet Eray Karadag <eraykrdg1@gmail.com>, mark@fasheh.com, 
	jlbec@evilplan.org, joseph.qi@linux.alibaba.com, ocfs2-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com, skhan@linuxfoundation.org, 
	syzbot+b93b65ee321c97861072@syzkaller.appspotmail.com
Subject: Re: [RFC RFT PATCH] ocfs2: Mark inode bad upon validation failure
 during read
Message-ID: <leys5guzkcvlilaccjmsw7cvncm6o2vqo2wwezhuz7r6lcfjnk@va3cnphl4zf3>
References: <20251029225748.11361-2-eraykrdg1@gmail.com>
 <wzykonhpj76qowdn24inwtaji4zfclesmc3lqnnc7cn6jkyjl4@oauagnarupov>
 <CAHxJ8O_7-PfJRyGp9-1KOkwmYJWQDzCvvo_P-jxzbzHoqXyH9Q@mail.gmail.com>
 <qfizhbe5rwzddwnoekr6xjy3gozbqbtl64c5xmfeuudxvficmv@onazesxv4ur6>
 <aQQ0DLqL0iVN7D15@arch-box>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQQ0DLqL0iVN7D15@arch-box>

On Thu, Oct 30, 2025 at 11:59:08PM -0400, Albin Babu Varghese wrote:
> Hi Heming, Thanks for the feedback.
> 
> > > I had one question about your proposal to combine this patch with
> > > Albin's [1]. When you mentioned, "We should forbid any write
> > > operations," were you referring to Albin's read-only check in
> > > ocfs2_setattr as the mechanism to "forbid" the operation? Or
> > > were you suggesting we should use the inode size sanity check
> > > itself (e.g., by converting the BUG_ON to an -EIO return)
> > > as that mechanism?
> > > 
> > 
> > The 'forbid' refers to the read-only check in ocfs2_setattr.
> > We can refer to ext4_setattr(), which calls ext4_emergency_state()
> > to forbid write operations.
> 
> I just looked at the ext4 implementation you mentioned. When we were working on
> it, I actually referenced how XFS's setattr was handling this because I
> couldn't find the exact ext4 implementation for this at the time, so I wasn't
> sure. From what I understand now, ext4 is doing something similar too.
> 
> If everything looks good, we can combine these two patches and send them as a
> patch series.
> 
> Best,
> 	Albin

I support adding make_bad_inode() in ocfs2_read_inode_block_full().
ocfs2_read_locked_inode() calls ocfs2_read_inode_block[_full] to read the inode
from disk. However, ocfs2_read_inode_block[_full] have many callers, and in
current code, only ocfs2_read_locked_inode() marks the inode as bad. All others
forget to set the bad_inode.

The 'forbid' write operations when read-only mode is worth another patch, and
I plan to create this patch. This patch adds a similar ext4_emergency_state()
function for ocfs2.
Therefore, your original patch looks good to me. I will provide my Reivewed-by
for it.

Thanks,
Heming

