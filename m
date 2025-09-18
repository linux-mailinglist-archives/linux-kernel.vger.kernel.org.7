Return-Path: <linux-kernel+bounces-822227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C95B4B835B2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0788C1C270E4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948122EAD0A;
	Thu, 18 Sep 2025 07:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jcqc9eOG"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2E72EA476
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181098; cv=none; b=ZE/rjRJOCN9BIbaBQIlM7Exh3u4zuIJS425UzKfNVLSrcMUaguRxAY2+ikfzr5AI2USfqarxuH54QXPpuyvBTQst4HxiO4lzQNVry7ZQgdhdchiL6hu8qshDwn6CIRfzTtQNHwSx8+WCQ6DhF4llXmKSAXhbI86EClE2iAj/yBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181098; c=relaxed/simple;
	bh=6zlwxdDIAyVrGnNAHri1B0Y1ptGiieeG3NVUpGeZvP0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGyW0P6kJlg1BjfnqyQMJQ7rXAc65h4G4QSyEuVuLhOHKzbvAuRefrsbS0aU9jI64id6sFEdzseRaw7KEgqMdnwSEM5id5se6gGTovH1mvItaGt111hYXKxzMpbDO6UFxboRrRKWQZ4YZ5x8mcDFUuZ0hJcjBZZf3vpqGtTOCfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jcqc9eOG; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2445824dc27so6443635ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758181097; x=1758785897; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qj4Q+ln53TMlKl8vivxQ4bA1KF8gRzVwWQSodcHaYwk=;
        b=Jcqc9eOGw0rHZ9RsJzr+UpA7MhJVawcDm9kaxwOlINpF/fjIHgCPai9yC+3i+nVAoc
         /Lgh2U4syiXxvRLqF1Qz1D9RR/VQNu7FVdTOsFnlgTEImsAGFqSVAcvbZv50LnBze2NY
         pDfbWLY9SZgeNBonMkXzB3+DVjAuOcGu41vfs3rY67vS6z6KeHJsuK0uVGd09592RNpb
         l8cqkc3qf0bJPXl7g4MvZcrD9pzR78l+hOoIyKr4zUauT4CSseMeO82cCMGzyAxcyUL6
         JlZ0WMMM5x4copBgrCx8p1XcBkaVl8BV90SeB08H4YfaB/HKCHx/BJBArp5DT8xoV41d
         koUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758181097; x=1758785897;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qj4Q+ln53TMlKl8vivxQ4bA1KF8gRzVwWQSodcHaYwk=;
        b=Q/zXiDVVi6r0yNI5RrFWpsOty+WDdv9XAL373TO3PTLfEY9MtTFkyHh6SInbv528gC
         wc6YtUVkrWTYLglDvwsfslnKNTVZSiW7Ipz+KI9elo7Scg5X5a6i1tnQuxFkJRYZ9LeG
         tFGdhmNSLW+zWCDgtVQ2l4EUSOvvxEraxEJjDQuueQf8txg20yy+RiF0D5MR8wIeZle5
         lgeUi2w8QvqSyChAS7Lh19OV+ybPM442w66hbp8WxBrdE+q1w0UYiBUWkJsP3Wzlv46z
         Lj8sB5FpqZRtUbHPHYtp8602W9ZGQXf1+AXExPLgiUsPjR66imxoUzlPK1/Cfc8bltHn
         Gzog==
X-Forwarded-Encrypted: i=1; AJvYcCW3b+x1MwSGxc09JFsxXxC4saucFZ5MQm7jR6Z2zA0zLnx1e/526MXjx0XmKya/ajhWjdHeQl2lIgXLAfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YygvkzXs4C0r3ez+8hLUUnc6qqt9ptzfKCT7WZMoR4+jTNhswFW
	uZNC0s40JhRAy37CsxBLAmvqpWbSY88UNNx6q/dV53LXSfqlZR2xsd90
X-Gm-Gg: ASbGncsYF8TBRqRTLRJ8b1f6dqQm6Nv1qp9nMOqbAPjVNfMkG0KDAzIiDY4oeKInTDx
	pTVvLp//Fsm3cHGB4fvCFu+mwXy7zXb5bqzVIDeB007aMooU5kpE27KyOA0YHjrBAJE0OQn5kzY
	9VTJ5NRA/uDdqZQJHaiv/t5OVs/bwEeJeCyFiOqF7JwIHw7J8PP3hoRlH3RJ9F5GpIM+0IrDMQR
	G4PdejnidCGnbgMm/gVAuYAjUpirjz8GuiK0jtwTybsNlNdKrsOnhPSZSxX0J9WLiKe/QKM9a0h
	tt9x4Pt+vGdwdcWBo+pDotZ5SM/nlcEx1nc3jnyPb9U9rsc2693A6nDM9pbjKqfd16lSRmrTk+7
	LR2XbQ+mPyt5fVCnThthsEJDGwU/0Pvo8T3cg9ZAK8766/NNkpAewVmrGVtWPOPezOCy8NzGlo2
	43xaRunAWpExSFgdnvtYlRoac0r1k=
X-Google-Smtp-Source: AGHT+IHCWymmqh8qlbDIpoojQaPDf9+JIFsgk8hQf/Yt1/SICfDMa5fretaS9o89jnSnDm6Zife20g==
X-Received: by 2002:a17:902:f113:b0:24a:fab6:d15a with SMTP id d9443c01a7336-2681218fe0bmr45234575ad.20.1758181096722;
        Thu, 18 Sep 2025 00:38:16 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802de5dbsm16738855ad.84.2025.09.18.00.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 00:38:15 -0700 (PDT)
Date: Thu, 18 Sep 2025 16:38:12 +0900
Message-ID: <m2bjn88b2z.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 00/14] nommu UML
In-Reply-To: <cover.1758171893.git.thehajime@gmail.com>
References: <cover.1758171893.git.thehajime@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII


sorry,

I included an unintentional patch in the series ([PATCH v11 06/14])
so, will resend this version very soon.

-- Hajime

On Thu, 18 Sep 2025 14:15:53 +0900,
Hajime Tazaki wrote:
> 
> This patchset is another spin of nommu mode addition to UML.  It would
> be nice to hear about your opinions on that.
> 
> There are still several limitations/issues which we already found;
> here is the list of those issues.
> 
> - memory mapped by loadable modules are not distinguished from
>   userspace memory.
> 
> -- Hajime
> 
> v11:
> - clean up userspace return routine and integrate to userspace() ([04/13])
> - fix direction flag issue on using nolibc memcpy ([04/13])
> - fix a crash issue when using usermode helper ([06/13])
> - test with out-of-tree kunit-uapi patches (which uses umh)
>  - https://lore.kernel.org/all/20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de/
>  - https://lore.kernel.org/all/20250626195714.2123694-3-benjamin@sipsolutions.net/

