Return-Path: <linux-kernel+bounces-852968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1B8BDA5A9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EACC33A8025
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120882ED14E;
	Tue, 14 Oct 2025 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hs0QOuLl"
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100502BF009
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455328; cv=none; b=hOfdfjV6E5gnBEPqCyi/yip7/iIG1O8tguG26S4+DQhQWejOVDLrzMqdyvveYiWZiH6EOySSy9MhHs3G4Q0WD0KF1mPP+hjvaGCIhcVMquvV5AR28Y9BA/Df3FuoDt2yA61Ol0tJUEEV9iWpoW6gD9HW+RkwHbvcC0F7gevTwcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455328; c=relaxed/simple;
	bh=JuysP1XZp2+WEfzp4GkcBSuCN/6dU0XTRD+b0F+kRdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSJQPTcWTvnhBXqBh7W1dH4uukwG/HRaeiiUYYaBjSAwk92HDN2O9mwXBjAEiXeI68/0/Ui83a38o1JRIlrcoPZNoQGoEclR/uwaLLcfPRc9yx7hTmpv1ZN8K0Yq622C1nOagMD2vnhGgWuwOF82dZIXSWX3LPs9DFIRPe1yxPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hs0QOuLl; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-636d5cefab2so5844786d50.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760455325; x=1761060125; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JuysP1XZp2+WEfzp4GkcBSuCN/6dU0XTRD+b0F+kRdY=;
        b=Hs0QOuLl5lkdtZfhNw8fgOx4JEQCZU57Ln2h6tNStySq/5dmFLE9GX6jUAiXWtb/Lx
         TSs+KnKFDXlVEMjYjZEBQzVwtyRcWcftOzu0XC2rFg0946smXlpDJeuwMgRYJYSuskO9
         Zmd0lAACONBuKxnCofW6HmqW2sNM242CPGOx55fV/d1THF9hsBwZpSiy+j439NxoWR0I
         FT5aAhcMlFR8oDozNle+v5HNEubgpVOJKMaw+kxoURHt41XHfA5KT/8phN7OksoeYKcR
         cybOqCAHnIYKNlsps5ZF3+LtExx/icVE26QffRQgpOskqLWdnd+LM8dBC1IsFFLTOio+
         pdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760455325; x=1761060125;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JuysP1XZp2+WEfzp4GkcBSuCN/6dU0XTRD+b0F+kRdY=;
        b=TJCVj0EDh69AEFtf6231fH5toP1VG8K66dScw35VK7e/7l0bHLaWTEQVkGu7XS3ksH
         l4yaxUO2Ivhopsvj30JtRb0dy8Yuwy1cHQZ4W2CFkTMYq8ar0Hgr7RimbnddZFhsD6cr
         Lu4PLEvEWmC/KUz9JfhNaVoJKFkWIoTfMqbFcC3cPQuqDvlsIRV7Wap+tlR3yGlfRy6t
         eajrogr6kovNTeF4dlWUfW4ncrKOvjA8WbrDdiIUQhYT0yvZeVMH2X46z1D/qZtX0ecf
         QmN+A/2jXQ2M1aMNx+bYu/sDmRDG7ApcNNKpBF1VlU3JH7lgflNYIh9EMudhIgoYINER
         8BsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlkeiMnxCSNA1Ob/ejmdf9XWMCbnQSJy2Id56Z7wvfqgpUmGp5eKAPihkHEW5+ZFKXBIljswEVkBfOMj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzauBF7UK82GZ7mM+vd2SpJpqpL8Pv2wR/LdUwJOEhmeB097vh1
	eRW2Mbi6GnJD+jFK9SabD7P6wRVS39JVMnks2T4VXBUgWnlDxCsnvp52T42Ex18GHfQFYonDNYV
	IDAeSR6hzLs/zxfQQB2ZvSJLiE8DLI2GrWxQQ7RbQew==
X-Gm-Gg: ASbGnctUdYib+JFup0TNVnEL01aahtWXFr1onJo/hcqvOceEXC3KuJUspu0pEFaZxPG
	8eqVGwjsbKxNZUJ/26ywBLkN2PfO+jTnoGg05XCYqhj8uuRwHxwCmRHVVxk77UScBNy/647Fenx
	hTzyawvVMx4xtSsu4IpNQtGGcpDgTt7ugQbJksSKUDBYyTiqzt4MrGfK0copfPvYJyDbGVYJErP
	yLfBooVxzAaOWOxHyd5sSAHBDMMqPmuErKTjENF2XLojPzwgVEfrfC0g/nTLBJMCXx4ZnoWcz05
	xNRz6CeVo0+BaA==
X-Google-Smtp-Source: AGHT+IERV5dkXUsA6PH8pJwqCjdZ1eXgQEpyOnGcHx77VYXj072DGb1WicKpR+KfiyDh3yoI8ZXSPK0rdZ/9oCTg4i4=
X-Received: by 2002:a05:690e:18e:b0:635:4ed0:572b with SMTP id
 956f58d0204a3-63ccb92c021mr17705016d50.47.1760455324924; Tue, 14 Oct 2025
 08:22:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014143942.643856-1-kartikey406@gmail.com>
In-Reply-To: <20251014143942.643856-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 14 Oct 2025 20:51:52 +0530
X-Gm-Features: AS18NWBwjfaDYJB5WmtkQrp5W16BLZdaiSVxrVnQ2U0n-pt0jFD_zwCWJEjGOmc
Message-ID: <CADhLXY6zA0EGhKjzBZXSv3QFC2OMHxTxzgZy2sObzNaaza7eLg@mail.gmail.com>
Subject: Re: [PATCH] ntfs3: prevent operations on NTFS system files
To: almaz.alexandrovich@paragon-software.com, 
	penguin-kernel@i-love.sakura.ne.jp
Cc: ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+3e58a7dc1a8c00243999@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Tetsuo,

Thank you for testing on a legitimate filesystem and for your question.

I'm trying to understand the protection mechanism better. When I searched
for ENXIO in fs/ntfs3/, I didn't find any explicit checks. Could you help
me understand where the ENXIO is coming from in your test?

I noticed that in the $Extend code path, inode->i_fop doesn't appear to
be set (only i_op is set), unlike regular files. Could this be why
operations fail on legitimate filesystems?

Regarding the syzbot reproducer - it uses a malformed filesystem image
from the fuzzer. I'm wondering if such corrupted images might bypass the
normal protections and reach ntfs_setattr() in ways that don't happen on
proper filesystems.

Would it make sense to add an explicit check in ntfs_setattr() to reject
size changes on system inodes (rno < MFT_REC_FREE) as additional
protection? Or do you think Edward's patch (just initializing the lock)
is sufficient?

I'd appreciate your guidance on the right approach here.

Best regards,
Deepanshu

