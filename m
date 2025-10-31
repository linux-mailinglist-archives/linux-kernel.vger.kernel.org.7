Return-Path: <linux-kernel+bounces-879486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48293C2339E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 04:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D6D3BBB3A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E25028A1CC;
	Fri, 31 Oct 2025 03:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdyCPWMy"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C4512CDBE
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761883154; cv=none; b=rH+NanZQcnanOwu2CT/NziylqQrqPZf95OG/gtU30mnk7LQaxSgDAd7CaPevW7i/vSOaGaNjpn1ogm6G7qc7S1BKWGbJEGhvXfcjphIvpNbLFLeOCvlMf38xVhsGTcdTBSIrD5ORiKD/JkMWflpZVVwDGP2fKyhWxA2TP4S7Yag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761883154; c=relaxed/simple;
	bh=K463F0WgtQayvGVKq8pk4vbCuftR3MqSiQYta790Raw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfC3SdIsQ6Jd67yj2mUDK3i9Z3Mt8tN0ecWutMp7jCNGdPNPhomSUuvS+qAG8p7R8Bp4/Xmhx829B3dTAF7lLom2OoXdT+VukZ/DIxnQ4a8snBtFi6G/B32dIOYZBIFn4qshHzJfu8R80Q9AaTY6fDw0HybqVIBweb35MtkvySc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdyCPWMy; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-940dbb1e343so119770839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761883151; x=1762487951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CVzgaw4KSyg5cjdxONzSMPRVaLN7EB7muCaP1M+QOZ4=;
        b=HdyCPWMyIC0bdculZNN/fTB5pavIsK/OL+pdDV6BP43ELgyXXMjnIyOK+EhDvMsfgd
         ZX1B5Gjvazmzb9g6LLhxWy0kwMbG7qEMVI66zg4kUVRx8bEQZW0Hf4LA2TVHIWlVw/Fh
         A/uJ39QbrcRqxIzLwzgoOFcC+EZ+8Kp6TyUElkU+wdNf7oQICVmQspa3TfSgpQEX1ES1
         uFfMWZFi6NM4PVLxizZSa7/PSwjPadlA/8DkWotEqudZqEaVIa56aSSxWhvkoPx3s36k
         aF7gDidj1nUwhLzFciTnFqlDEYCSC4AIqp8G752PwUOEKpswjQf5whfcYaBVUl0pZrAj
         iELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761883151; x=1762487951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVzgaw4KSyg5cjdxONzSMPRVaLN7EB7muCaP1M+QOZ4=;
        b=B5T3Ipo5kcTl0AETpc8shRCFvHovXvl+ZkDrFdlFgCQ14IKOS0eifj8plJWHCrTWgV
         KQ5H0fa0A7HM+aXCFNHkGggt92QoYu7aArY2tDqUn1mVttXIHTd3EZpueQff2V7Op/6s
         3Wdgyi4ezY+NZ+nnyRUxG6roHcMxiFMRyuh1iJYwQUF6unz13b+XjGX2Z1yt28qexEtf
         GrMLcUvbSZr+SJrDFo2SZQnMFW5j1fpkDeZg8F9J0zMawNCCvR03curn94p6BHmWlyBw
         oimMWcz8dv3SAepBydLNqUe7ChrRhIBlSaPdpsT5wW2inEIQ5vYSdLbKwzOrtpztYEOS
         R1zA==
X-Forwarded-Encrypted: i=1; AJvYcCXfUs1hVex5Mxeoh9XrgK0qeQbkZ7eesJApAUhMUsgS5rHQls46929k8pp3u2XjnDVf360L+yis4fGzq5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyLSuZfjYQXp5Nge6Rf0opahNpbj3OAYw68HX44qaxYO/52r0L
	tcu/nK9nE1sE9vPKNLN4bUflkJozvjGUyTet4sBNRoAXYweVJAkVoBGI
X-Gm-Gg: ASbGnctUci6DPcTw/+8MO+/UZlyAZ77QAjxrDj3amdwNuIJM2cqy8losrCvI71cgwEh
	+qOHwNHI6p13tBK18l/bS1llqQS7ViJCjFtXh46k+wm0Zw+Rc5TNi/edSkaMYEYvHKttk8GCzt6
	5i1TS5hU7ogGY+cc7OvirGRUHZ8QOTtDKpbWjAbTwTbjcEguDBdWQKP0gvYTg4XI0OWn/5iT35r
	Wen0Sz9xLQcJlohrcQ4QVgb9bhzbBBkwLfE9cHsv0oOijSPs7qG04smb5kVBetPrVfgLU+j/+0B
	Z4rMY2wyxJ6LjgmmLFuy7xQIsLSX23mAhYqTPmX6r5zl6Jqoks01oi9gkM0tRaaeEo0w49tkhvg
	glzYnFfdEI26COOp5LQ9RHLdLH8vrsVUGCzQSMEfZQKBUKbaUEI45Ku80+v98zqAolfeMm7E=
X-Google-Smtp-Source: AGHT+IG4begvpcbVwzfsZabnnFSMeIq+HmErPXe/nObkhvCU/XUbrqj72iI4aGEGSEYIIOWKCkdzuA==
X-Received: by 2002:a05:6e02:1aab:b0:42f:a4d7:ebac with SMTP id e9e14a558f8ab-4330bd94293mr37773685ab.4.1761883151459;
        Thu, 30 Oct 2025 20:59:11 -0700 (PDT)
Received: from arch-box ([2607:fea8:54de:2200::c98d])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43310322c59sm2341965ab.20.2025.10.30.20.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 20:59:10 -0700 (PDT)
Date: Thu, 30 Oct 2025 23:59:08 -0400
From: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
To: Heming Zhao <heming.zhao@suse.com>
Cc: Ahmet Eray Karadag <eraykrdg1@gmail.com>, mark@fasheh.com,
	jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
	ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com, skhan@linuxfoundation.org,
	syzbot+b93b65ee321c97861072@syzkaller.appspotmail.com
Subject: Re: [RFC RFT PATCH] ocfs2: Mark inode bad upon validation failure
 during read
Message-ID: <aQQ0DLqL0iVN7D15@arch-box>
References: <20251029225748.11361-2-eraykrdg1@gmail.com>
 <wzykonhpj76qowdn24inwtaji4zfclesmc3lqnnc7cn6jkyjl4@oauagnarupov>
 <CAHxJ8O_7-PfJRyGp9-1KOkwmYJWQDzCvvo_P-jxzbzHoqXyH9Q@mail.gmail.com>
 <qfizhbe5rwzddwnoekr6xjy3gozbqbtl64c5xmfeuudxvficmv@onazesxv4ur6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qfizhbe5rwzddwnoekr6xjy3gozbqbtl64c5xmfeuudxvficmv@onazesxv4ur6>

Hi Heming, Thanks for the feedback.

> > I had one question about your proposal to combine this patch with
> > Albin's [1]. When you mentioned, "We should forbid any write
> > operations," were you referring to Albin's read-only check in
> > ocfs2_setattr as the mechanism to "forbid" the operation? Or
> > were you suggesting we should use the inode size sanity check
> > itself (e.g., by converting the BUG_ON to an -EIO return)
> > as that mechanism?
> > 
> 
> The 'forbid' refers to the read-only check in ocfs2_setattr.
> We can refer to ext4_setattr(), which calls ext4_emergency_state()
> to forbid write operations.

I just looked at the ext4 implementation you mentioned. When we were working on
it, I actually referenced how XFS's setattr was handling this because I
couldn't find the exact ext4 implementation for this at the time, so I wasn't
sure. From what I understand now, ext4 is doing something similar too.

If everything looks good, we can combine these two patches and send them as a
patch series.

Best,
	Albin

