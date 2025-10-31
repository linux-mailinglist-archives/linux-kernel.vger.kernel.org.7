Return-Path: <linux-kernel+bounces-880295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E92AEC255CB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 61714341777
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9948534A3A9;
	Fri, 31 Oct 2025 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhZ485Fl"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8734A341AD8
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761918886; cv=none; b=OEMaYwUwR8X6I0OHuly3XbB/R8fuUkvdUV/7HhEBIhIWHsxBQQCBpuO/9Q+8YyTEWLbKBrOIA6sHc9h5n9Kvo5I5oaC3qOJXXjqX11ExYRgooe2poJk8bfzDVQlvEcKv7GC5jq3YT0cFI4iVqncUbdnFT/2o8pguay+SPAFSJ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761918886; c=relaxed/simple;
	bh=FN2tQDX/wwLUC2mxidAL9H47bLyAFnJDpvPQlovcMVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y298vvqfsU2AhntK9tNSYd+hlZo5qQu/zNPm+pKtk6r41s2bK00Pdqet0+zo3j7uxX7fMH4M0Ge1kon3u0I+bg8CchnPRCOkzUMDuVq//zqIRMJspuIfJlAzyxiCHhzvAxDbCV2rruyQoyf5jDsd5TXvUzQmzbf0OBxgSkGUxq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhZ485Fl; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-433100c59dcso3407705ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761918883; x=1762523683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AIC+1h53umAhjFDxKUylX2ye8sI922EhJMx+ZKGKkKc=;
        b=MhZ485FldR4fdphq5CwcNTKUjce80RrhTYv9anz8BBd1mRJU6MDV3kgsPWxuPJpOWi
         7gpAq2SMnB16Oy/k12k6RFZ8G9VDlXVO5E7+OBTdvnSDzUmmtI9GVFYZOq87AGS6U4tm
         Cz5BLDVbO9pUyw5bvYMq5YYg7tyh6QVabOajjWMG8f0I0ZAw9EYQ0jBLuNkcPPJt61/K
         pxj4I9VAa6oLxkhAwCBBblp8mTfz9i2EpB+WnZXKVqdTpyoQNT/38sbvKh2A3QZOmUBZ
         43YOWpVHwZHoZLgMADE/nNWm8YnCx9BMZijhaa/o10DCewwIRX5HI8nyRLm0OXQ6ZqKY
         8hAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761918883; x=1762523683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIC+1h53umAhjFDxKUylX2ye8sI922EhJMx+ZKGKkKc=;
        b=Sp+Y2+zE9/Qn6VbcXaDb2waLxNzaWi2eE3sKkABeVN5h77AgszmVmX2pKyREMTCuR0
         qEQiclDxKck9WI70J/zchcsQ9h9oWaz2QTsQdepUV1Ujefwr2xsyHPldrHa7g36wYrlS
         ggKe8KfRuAZ+uQcIf/EzqlG6iB8XaK7/s/MgiuirUxZCsZUgMF9UrlHU7nnl4LrcLgS6
         X/5PiPsjZWcplLSo/BOnoDrjGvrLoXlXwsZkwlrecPHwK7CmXLVmmr8qPgN13tehs8WJ
         JxJFiDwxDa1NArUcK/NF2YBC8SYyXLPLLCg6/SSbwv3OzZjY2lZe7zrvEMGObK4h9vAw
         pSvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8dsDd2jf4KDk7PKnugmssgqKa1A+eJ3+7yu9OePErTAoFYC/h+A/Kcn4C/8ElF9N070kfErQqMt/4f+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVa7y+wTgOh2GtPZKRyZKQGGqpu84s/QsrbQIE05pvePqVAA0d
	Q0g7gnfqN22QvgKNcg/xeu9Sag/1R1hca+bmhrRqujj4HAxA9XEsToNB
X-Gm-Gg: ASbGncuycK/klp3DdGzhByoNqqKDlPbBHPpTTe1na7Eqe6Oo66qCYbDpDWrebEorpSe
	d62Yt5qsdo4hAHoQv4WU6cIR+zj7g71/so6Y9zJbi22KdMSYtCGCEaUCIBR6OpkP0mYOVJvDHLB
	+mdOrRdU0TeMVEktfcldFCYfxRkJFgvXMvFuE2fCIENOWBnDDD+k0eJVGZLKGmB1uz8SMWUqA7N
	7pZsw2wGMRvu/CO+Lvo9GwdfHYZcXyzv8XcrZi8IKHdz0rx/TCL9TQqxXt5OnJx6z8qw3u36L42
	arL4U/oYffMRRlbYeWwvN6nyWk498XCzN+nb/cbuQc/Fn0V/ScQcrvlRFrnoGU8XvhjHTr7Yz5K
	cTTUggYowuFDeA9DqzXIUTFT5TezIEzQ+EQYMZ/D4rRZBJgjJFiMJCFu06B/whHggS82MHsw=
X-Google-Smtp-Source: AGHT+IHCzKlOoNPt0LzvrQC5mz1ulgeoDbMFZSeqzUEOGflwrunfIy79QuN9s2TzFHch5oRbAD1Y3A==
X-Received: by 2002:a92:cd8c:0:b0:432:fd5c:df03 with SMTP id e9e14a558f8ab-4330d1eb232mr49401325ab.24.1761918883467;
        Fri, 31 Oct 2025 06:54:43 -0700 (PDT)
Received: from arch-box ([2607:fea8:54de:2200::c98d])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b6a34b63dfsm721718173.16.2025.10.31.06.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 06:54:43 -0700 (PDT)
Date: Fri, 31 Oct 2025 09:54:41 -0400
From: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
To: Heming Zhao <heming.zhao@suse.com>
Cc: Ahmet Eray Karadag <eraykrdg1@gmail.com>, mark@fasheh.com,
	jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
	ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com, skhan@linuxfoundation.org,
	syzbot+b93b65ee321c97861072@syzkaller.appspotmail.com
Subject: Re: [RFC RFT PATCH] ocfs2: Mark inode bad upon validation failure
 during read
Message-ID: <aQS_oUDXGt_nF__d@arch-box>
References: <20251029225748.11361-2-eraykrdg1@gmail.com>
 <wzykonhpj76qowdn24inwtaji4zfclesmc3lqnnc7cn6jkyjl4@oauagnarupov>
 <CAHxJ8O_7-PfJRyGp9-1KOkwmYJWQDzCvvo_P-jxzbzHoqXyH9Q@mail.gmail.com>
 <qfizhbe5rwzddwnoekr6xjy3gozbqbtl64c5xmfeuudxvficmv@onazesxv4ur6>
 <aQQ0DLqL0iVN7D15@arch-box>
 <leys5guzkcvlilaccjmsw7cvncm6o2vqo2wwezhuz7r6lcfjnk@va3cnphl4zf3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <leys5guzkcvlilaccjmsw7cvncm6o2vqo2wwezhuz7r6lcfjnk@va3cnphl4zf3>

Hi Heming,

> I support adding make_bad_inode() in ocfs2_read_inode_block_full().
> ocfs2_read_locked_inode() calls ocfs2_read_inode_block[_full] to read the inode
> from disk. However, ocfs2_read_inode_block[_full] have many callers, and in
> current code, only ocfs2_read_locked_inode() marks the inode as bad. All others
> forget to set the bad_inode.
> 
> The 'forbid' write operations when read-only mode is worth another patch, and
> I plan to create this patch. This patch adds a similar ext4_emergency_state()
> function for ocfs2.

We're working on this as part of the Linux Kernel Mentorship Program, and we'd
love to take on implementing the read-only check if it's not overly
complicated. We're just beginners, but we thought it would be a great learning
experience to work on this following the ext4 pattern you mentioned - if you
haven't already started working on it by the time you see this reply.

> Therefore, your original patch looks good to me. I will provide my Reivewed-by
> for it.

Thank you so much for your review and the Reviewed-by tag

Cheers,
	Albin

