Return-Path: <linux-kernel+bounces-824587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0039B899D3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE73D17E579
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F99230AD18;
	Fri, 19 Sep 2025 13:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQIPISGy"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735D6226D02
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758287373; cv=none; b=Df/NXYaNYypHfbrT6MbkABnURng8b+Ii8882cqVWAEJiwNLjpDnaB1EB28QYRXuErwaMV2Yn3UHDUg6KNTbJd6WHadoCzOBX+ggyr4VWxuwCGoi0AVlsFql4Gj+mjzPtcifa5nQ4jxQkjgdZEo4H/Jvq1TlHn+0MNhKqTeywXKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758287373; c=relaxed/simple;
	bh=H2nghK4bl/H+DNUfQhtZLwYHG07QNLlFwkEd9mrXbhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B8twDR7OVFjTBD46at0RlcB9H7Jf/QsX05IunFmdRtwx7FRaQ7d3iKODiCu+BU9cdwZG2gec9w1cc+CX8sP5lJzxa7XJ8N+lNtK/ssdQNDtPoZFYRN7XaGE0tyerbJ70EoNMxj0EB/JoIk/5DeUSY6vkM6CPfEKpQGAuQoOh7Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQIPISGy; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62fa0653cd1so2497215a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758287369; x=1758892169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2nghK4bl/H+DNUfQhtZLwYHG07QNLlFwkEd9mrXbhQ=;
        b=BQIPISGyaL9K2DiFORwYXbLp0t2u4Qq7Wi9F4RNLMuSVpyK66tSAoNsyEIYswqWV26
         iNyNMFsvPDMLcyCx5Brope1KQRqcyBHMz4yssiys1snjyeR3l1GIcRFDsIjglAi9HvWj
         IlBVLk4wEYQGTNNyUT7TeWjslzh1k5HuAp+0Qpsn5AsZ2NW8Y5UyHSzN70Zer329AMnZ
         n996bHOKl75/nauI8STW5nkufGGR6s1xIt3boi1DFvvYhV32fAvcCtgJqEW1NhPtORuX
         wm9IS6roqrijLmO1HE8RXHPiymNGhW+W2wOGR4/VZPeKOGA6ByVNxAJRMbvc1aw+r+Xm
         q8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758287369; x=1758892169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2nghK4bl/H+DNUfQhtZLwYHG07QNLlFwkEd9mrXbhQ=;
        b=HRDea7eZfe8ATzDZLqKcpTgHqHVP7LnXaskKmqcESQX1oXgYNsrBSxMnIpcafgCuoS
         j/K4PBoWFTk1cXF0McB60vPJ2FBZeVXSqLf5N56pPtWJroeQMy4bQmdJ7Sp25RnxJmil
         Ez0SRiRzhxvBgvhDt7EqK8kSMrZMbsT90gZQwZK9e1KhzaZz/37DjPIv/Uhilnmlc4th
         ninkAHiLT8UGG6TByOYnKAZ4KgXujsC0Sz9ZAxN4T3hH1MU/8u4QykMyW8tl4UZTfXAB
         i1Hu3s61CInlgk7lg+xs4UuzjiGRxX9t9R+/WwNZd144HfgzVcBUpBbvlUVEol2QSoTL
         rNGw==
X-Forwarded-Encrypted: i=1; AJvYcCVjdM63nJScQE31isCW8DaFu2upUWgEKFefzU7l/+XmD2mDYl/EPJBHOwQAKvU0bNqg/7JLlEMEls+hQyI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx01Ju3VVbZrsCzU1TYyoKV76Ny7BjhEO9hsbcsaIUFQmaxiDC
	yum8D65bKyeMZFSEbUtw4Hd8M2y1/39X01x2aBYnGGhtzn6InOXt+lRIdlTgILK1VOiWYhfc4aR
	jp+tutmgXFUyWE2Aci6Q5eN87S5rRaHArmNW0
X-Gm-Gg: ASbGncvpn8Zj/bI0MCaWr+W5WqFNxbFl8iF8n+SuAKaNB05ZbiVy4SaWpDJJnHpfKa+
	uDq0z0Pa+ovpTO1bpGdvAsYk7YmXtxvoM3bcokF7i/FZnQUGGO2/bBd3SCxSMko4mZI+FtpdkG3
	vxOm4L085JeoQP0UYp5BVRVhGEWeVuwhY2epBGsw1iV76n/t011/qEMgRs8hM3F7S3pAxYBGVmT
	gs6pQvyixLcMevlyd96Ubu7uLfRI+3oVv/8OqA=
X-Google-Smtp-Source: AGHT+IFApfhAHEjMUI5U299k57YwKnPsMN/Ik0b5HX6lVlpdtHbeIxsd1Q0r+GQz5I22vbwNy4Ut9U4zuDgZ7sOE0qo=
X-Received: by 2002:a05:6402:5343:10b0:62b:2899:5b31 with SMTP id
 4fb4d7f45d1cf-62fc08d40ecmr2418056a12.5.1758287368510; Fri, 19 Sep 2025
 06:09:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916135900.2170346-1-mjguzik@gmail.com> <20250919-unmotiviert-dankt-40775a34d7a7@brauner>
In-Reply-To: <20250919-unmotiviert-dankt-40775a34d7a7@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 19 Sep 2025 15:09:16 +0200
X-Gm-Features: AS18NWD5Om8yGekTULVtEvApOLHSTiZijG74rmoXqBK7CgJeOnhoxL1KEl8c09g
Message-ID: <CAGudoHFgf3pCAOfp7cXc4Y6pmrVRjG9R79Ak16kcMUq+uQyUfw@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] hide ->i_state behind accessors
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, kernel-team@fb.com, 
	amir73il@gmail.com, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 2:19=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Sep 16, 2025 at 03:58:48PM +0200, Mateusz Guzik wrote:
> > This is generated against:
> > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=
=3Dvfs-6.18.inode.refcount.preliminaries
>
> Given how late in the cycle it is I'm going to push this into the v6.19
> merge window. You don't need to resend. We might get by with applying
> and rebasing given that it's fairly mechanincal overall. Objections
> Mateusz?

First a nit: if the prelim branch is going in, you may want to adjust
the dump_inode commit to use icount_read instead of
atomic_read(&inode->i_count));

Getting this in *now* is indeed not worth it, so I support the idea.

