Return-Path: <linux-kernel+bounces-880345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C90F7C258AE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08B68188A5E0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BA233E353;
	Fri, 31 Oct 2025 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpFspz4I"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD8E320380
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761920540; cv=none; b=iEFTSQEy2Mg59dy+RetHaWfGbKqQxq54kUY4vAE9idzYKqUnMDV/NxurSZofZHRXysfH5Eec9oR85wh+bgx9s0G7lgip2gG0wG52xr/UZYjJUymV2y1qaWx6xeWbOiE/HfQud9Oj0ejJHdSMnFC9F2UgigK5VMeadvWg9p3gz8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761920540; c=relaxed/simple;
	bh=U/JnwHocTOv3DE1OsEmzLByYGz+pJaHHFL1XoiTiHWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4y+cSu5t/LQCrhATIWPoFZiy+rP4JlyBBlCcwB2/xcq7lofLGQlBvSzNcP6qQL/fKwu/hD6kMIijIgCdST3HRy47xrGYo/MLJOzdxrjf4zzhMCKym4JFTyAK0o5NHDwNWt2PFv+8T+aE1JBerV4xK2zAL9OiIFM3MHetwjQpdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpFspz4I; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4e8850b09eeso21241901cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761920537; x=1762525337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HmvHznY30SKNic0c8rWZfpNF8gg00p8bPWt2eYJyfec=;
        b=XpFspz4IMy1syoKZKu3jWkZpW9Ibs7tg5JfqHMdN4EdqwiNXp7e/KPNpk2/ETDlqrv
         WWKjRB6/VWrezEthECdJtehxClrOIJ4HXrHEk2GF8Gw3xnrVFHVar0JGzxyhyikNZfIo
         jQZSN7df+puDDYjhIhBITkyK4ApJsD2Y0jVpf+g2AVlVes2xjTK+MdpKidoluPF1n4vT
         J30nNiBH5/rmSzVEFFRuslQ19LimjUPSVMTO/rEeh9WKgGfO4m9Xf7dNR770M/AU2SZZ
         6zFhjiIywultJaGgOjExtzJP6pVD/u1KhjTAQsQzZXfQ2B9GeyB7GmcLaS2uTbcuDTTW
         Expg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761920537; x=1762525337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmvHznY30SKNic0c8rWZfpNF8gg00p8bPWt2eYJyfec=;
        b=CFa2WrEyWV2xenngbbQV5ReN8WPNl9RUQ8hE3Sxkt0Ihd7IB5gaLlOLzyGyZolV+JI
         80oximEpuPwwrDApL0RAMN3xKdtiCGkaenf7E1gkbhAFTe1x2tNDaJ8ItDCuGXPU8EfN
         1x6REAZIqLUyFDe+3KnGvwkFBvWXN3tdsS6W7bt5ZIuigWCe9FcX1XwwDDNGJSgDwB4b
         giRHEqnpnL3gJh9/2jz46m0aodjsS3+lECSe+D7d6z7UvvzSTe+vPRaMIF+mxzROStNz
         W3bY/jvrlxb0qf9V1yemnniAkwT8H1HZfubGVEUO6Urp+EhP6klZp9fdEwassL0SFG1O
         7dbA==
X-Forwarded-Encrypted: i=1; AJvYcCV77f0WIv4kox2ArprfTmOsC4YyAr7eHlCcdt09CjDAd2yjp8UlzouwI/Uc3stpneqeUCgzWXY6GiQGHmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywkeutwOXB86LGQT5AqGclywZKGm0jH8pr33VEACG+5J098BH6
	scTN24qX8klBChT8J7dRYxkhe9ddd7wCeThr3oKiU85QvFBoGXu/m0Wj
X-Gm-Gg: ASbGncszUlXJAVLtDdFRyzEbtYcVlbCn0qf0fy0ANryaQ4P0H40G1fuGoCtLOpn4XZG
	g8B4uyiFL73EL45I0PcTyzSctQ0+jGLMe8uoa51ty1q9BaqXFXK2IJsFJH1OItVuWH5fxvHHF8z
	IMkAwTweLdx7GiNHLFZPfPnUK9+I0cOYUbb+u5Sptb+TRjfzeEWrDC4C7uI/mVBhhXzcIRDbsD5
	6GJ/MJmSPOjd8anWYLv5uANmPXcyRG0neqag0cAeY5pc3X/ueJ0jpkNURHer9cXopQ5MK7xD686
	QC7BDeRSGSL4KyjK25p5xwF/+ccPl9ay1cyx9FNCHTr2txqpvS7TEDCgLtVsguCVcBb2mlQOneT
	Wtp3GFKiplCc8Iib7FyOJ/1yD/9MeMNacGkALKKo6akf81bTAQ2JtQcJv5fg8nm3wh5PLZKQ=
X-Google-Smtp-Source: AGHT+IGHtm/+hhl7f5mUMjQi2hNOc2hOPb+Jd0XRa+ulUtHaxufSgtRvl924/sYMVKbMfvjfNf8rFQ==
X-Received: by 2002:a05:622a:2307:b0:4ec:ee66:166b with SMTP id d75a77b69052e-4ed31001a6dmr41523111cf.57.1761920537330;
        Fri, 31 Oct 2025 07:22:17 -0700 (PDT)
Received: from arch-box ([2607:fea8:54de:2200::c98d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed35354982sm11212601cf.34.2025.10.31.07.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:22:16 -0700 (PDT)
Date: Fri, 31 Oct 2025 10:22:14 -0400
From: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
To: Heming Zhao <heming.zhao@suse.com>
Cc: Ahmet Eray Karadag <eraykrdg1@gmail.com>, mark@fasheh.com,
	jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
	ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com, skhan@linuxfoundation.org,
	syzbot+b93b65ee321c97861072@syzkaller.appspotmail.com
Subject: Re: [RFC RFT PATCH] ocfs2: Mark inode bad upon validation failure
 during read
Message-ID: <aQTGFvVX22RmDhb0@arch-box>
References: <20251029225748.11361-2-eraykrdg1@gmail.com>
 <wzykonhpj76qowdn24inwtaji4zfclesmc3lqnnc7cn6jkyjl4@oauagnarupov>
 <CAHxJ8O_7-PfJRyGp9-1KOkwmYJWQDzCvvo_P-jxzbzHoqXyH9Q@mail.gmail.com>
 <qfizhbe5rwzddwnoekr6xjy3gozbqbtl64c5xmfeuudxvficmv@onazesxv4ur6>
 <aQQ0DLqL0iVN7D15@arch-box>
 <leys5guzkcvlilaccjmsw7cvncm6o2vqo2wwezhuz7r6lcfjnk@va3cnphl4zf3>
 <aQS_oUDXGt_nF__d@arch-box>
 <stmj7kbqis2idlscf5iwch23ft2azuyyr7q2kmelavjk5lnug4@66in667d6bym>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <stmj7kbqis2idlscf5iwch23ft2azuyyr7q2kmelavjk5lnug4@66in667d6bym>

> > > I support adding make_bad_inode() in ocfs2_read_inode_block_full().
> > > ocfs2_read_locked_inode() calls ocfs2_read_inode_block[_full] to read the inode
> > > from disk. However, ocfs2_read_inode_block[_full] have many callers, and in
> > > current code, only ocfs2_read_locked_inode() marks the inode as bad. All others
> > > forget to set the bad_inode.
> > > 
> > > The 'forbid' write operations when read-only mode is worth another patch, and
> > > I plan to create this patch. This patch adds a similar ext4_emergency_state()
> > > function for ocfs2.
> > 
> > We're working on this as part of the Linux Kernel Mentorship Program, and we'd
> > love to take on implementing the read-only check if it's not overly
> > complicated. We're just beginners, but we thought it would be a great learning
> > experience to work on this following the ext4 pattern you mentioned - if you
> > haven't already started working on it by the time you see this reply.
> 
> I haven't started the patch job, you are welcome to take it.

Thank you! We'll work on it and send the patch for review.

Cheers,
	Albin

